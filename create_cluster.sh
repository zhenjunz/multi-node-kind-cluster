#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "\n*******************************************************************************************************************"
echo "Installing Kind"
echo "*******************************************************************************************************************"
# Mac
# Install Docker Desktop
#brew update && brew install kind

# Ubuntu
# Install/Upgrade to Docker/20+
#./install_kind.sh

echo "\n*******************************************************************************************************************"
echo "Creating new kind cluster"
echo "*******************************************************************************************************************"
kind create cluster --config "$SCRIPT_DIR"/develop.config.yaml --name develop
# kind create cluster --config "$SCRIPT_DIR"/remote1.config.yaml --name remote1
# kind create cluster --config "$SCRIPT_DIR"/remote2.config.yaml --name remote2

echo "\n*******************************************************************************************************************"
echo "Installing Calico"
echo "*******************************************************************************************************************"
kubectl create -f mirror_tigera_operator.yaml
kubectl create -f mirror_custom_resources.yaml
#kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml
#kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml

echo "\n*******************************************************************************************************************"
echo "Installing Nginx Ingress Controller"
echo "*******************************************************************************************************************"
# https://github.com/anjia0532/gcr.io_mirror
kubectl apply -f mirror_ingress_deploy.yaml
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

echo "\n*******************************************************************************************************************"
echo "Labeling work node"
echo "*******************************************************************************************************************"
#kubectl label node dev-worker ingress-ready=true
