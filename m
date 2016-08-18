Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFWx33rVGzDr5X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 02:37:59 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7IGXtTi136543
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 12:37:56 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24wcegxd6v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 12:37:56 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Thu, 18 Aug 2016 10:37:55 -0600
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, jallen@linux.vnet.ibm.com
Subject: [PATCH] ibmvnic: Handle backing device failover and reinitialization
Date: Thu, 18 Aug 2016 11:37:51 -0500
Message-Id: <1471538271-10131-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

An upcoming feature of IBM VNIC protocol is the ability to configure
redundant backing devices for a VNIC client. In case of a failure
on the current backing device, the driver will receive a signal
from the hypervisor indicating that a failover will occur. The driver
will then wait for a message from the backing device before 
establishing a new connection.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 34 ++++++++++++++++++++++++++++++++--
 drivers/net/ethernet/ibm/ibmvnic.h |  2 ++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 88f3c85..b942108 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -203,7 +203,8 @@ static void free_long_term_buff(struct ibmvnic_adapter *adapter,
 	struct device *dev = &adapter->vdev->dev;
 
 	dma_free_coherent(dev, ltb->size, ltb->buff, ltb->addr);
-	send_request_unmap(adapter, ltb->map_id);
+	if (!adapter->failover)
+		send_request_unmap(adapter, ltb->map_id);
 }
 
 static int alloc_rx_pool(struct ibmvnic_adapter *adapter,
@@ -522,7 +523,8 @@ static int ibmvnic_close(struct net_device *netdev)
 	for (i = 0; i < adapter->req_rx_queues; i++)
 		napi_disable(&adapter->napi[i]);
 
-	netif_tx_stop_all_queues(netdev);
+	if (!adapter->failover)
+		netif_tx_stop_all_queues(netdev);
 
 	if (adapter->bounce_buffer) {
 		if (!dma_mapping_error(dev, adapter->bounce_buffer_dma)) {
@@ -3280,6 +3282,10 @@ static void ibmvnic_handle_crq(union ibmvnic_crq *crq,
 			rc = ibmvnic_send_crq_init(adapter);
 			if (rc)
 				dev_err(dev, "Error sending init rc=%ld\n", rc);
+		} else if (gen_crq->cmd == IBMVNIC_DEVICE_FAILOVER) {
+			dev_info(dev, "Backing device failover detected\n");
+			netif_carrier_off(netdev);
+			adapter->failover = true;
 		} else {
 			/* The adapter lost the connection */
 			dev_err(dev, "Virtual Adapter failed (rc=%d)\n",
@@ -3615,8 +3621,18 @@ static void handle_crq_init_rsp(struct work_struct *work)
 	struct device *dev = &adapter->vdev->dev;
 	struct net_device *netdev = adapter->netdev;
 	unsigned long timeout = msecs_to_jiffies(30000);
+	bool restart = false;
 	int rc;
 
+	if (adapter->failover) {
+		release_sub_crqs(adapter);
+		if (netif_running(netdev)) {
+			netif_tx_disable(netdev);
+			ibmvnic_close(netdev);
+			restart = true;
+		}
+	}
+
 	send_version_xchg(adapter);
 	reinit_completion(&adapter->init_done);
 	if (!wait_for_completion_timeout(&adapter->init_done, timeout)) {
@@ -3645,6 +3661,17 @@ static void handle_crq_init_rsp(struct work_struct *work)
 
 	netdev->real_num_tx_queues = adapter->req_tx_queues;
 
+	if (adapter->failover) {
+		adapter->failover = false;
+		if (restart) {
+			rc = ibmvnic_open(netdev);
+			if (rc)
+				goto restart_failed;
+		}
+		netif_carrier_on(netdev);
+		return;
+	}
+
 	rc = register_netdev(netdev);
 	if (rc) {
 		dev_err(dev,
@@ -3655,6 +3682,8 @@ static void handle_crq_init_rsp(struct work_struct *work)
 
 	return;
 
+restart_failed:
+	dev_err(dev, "Failed to restart ibmvnic, rc=%d\n", rc);
 register_failed:
 	release_sub_crqs(adapter);
 task_failed:
@@ -3692,6 +3721,7 @@ static int ibmvnic_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	dev_set_drvdata(&dev->dev, netdev);
 	adapter->vdev = dev;
 	adapter->netdev = netdev;
+	adapter->failover = false;
 
 	ether_addr_copy(adapter->mac_addr, mac_addr_p);
 	ether_addr_copy(netdev->dev_addr, adapter->mac_addr);
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index e82898f..bfc84c7 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -830,6 +830,7 @@ enum ibmvfc_crq_format {
 	IBMVNIC_CRQ_INIT                 = 0x01,
 	IBMVNIC_CRQ_INIT_COMPLETE        = 0x02,
 	IBMVNIC_PARTITION_MIGRATED       = 0x06,
+	IBMVNIC_DEVICE_FAILOVER          = 0x08,
 };
 
 struct ibmvnic_crq_queue {
@@ -1047,4 +1048,5 @@ struct ibmvnic_adapter {
 	u8 map_id;
 
 	struct work_struct vnic_crq_init;
+	bool failover;
 };
-- 
1.8.3.1
