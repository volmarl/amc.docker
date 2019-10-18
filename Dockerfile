FROM ubuntu:bionic

ENV AMC_VERSION 4.0.27 


# Install AMC server 


RUN \
  apt-get update -y \
  && apt-get install -y wget python python-argparse python-bcrypt python-openssl logrotate net-tools iproute2 iputils-ping \
  && wget "https://www.aerospike.com/artifacts/aerospike-amc-community/${AMC_VERSION}/aerospike-amc-community-${AMC_VERSION}_amd64.deb" -O aerospike-amc.deb \
  && dpkg -i aerospike-amc.deb \
  && apt-get purge -y




# Expose Aerospike ports
#
#   8081 – amc port
#
EXPOSE 8081 

# Execute the run script in foreground mode
ENTRYPOINT ["/opt/amc/amc"]
CMD [" -config-file=/etc/amc/amc.conf -config-dir=/etc/amc"]

#/opt/amc/amc -config-file=/etc/amc/amc.conf -config-dir=/etc/amc

# Docker build sample:
# docker build -t amctest .

# Docker run sample for running amc on port 8081
# docker run -tid --name amc -p 8081:8081 amctest
# and access through http://127.0.0.1:8081
