Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rhQ31L4BzF1BS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 04:49:31 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4NIhsav002548
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 14:49:29 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j5akja0cg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 14:49:28 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Wed, 23 May 2018 12:49:28 -0600
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Cc: nfont@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [PATCH net-next 3/8] ibmvnic: Check CRQ command return codes
Date: Wed, 23 May 2018 13:37:57 -0500
In-Reply-To: <1527100682-23099-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1527100682-23099-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Message-Id: <1527100682-23099-4-git-send-email-tlfalcon@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Check whether CRQ command is successful before awaiting a response
from the management partition. If the command was not successful, the
driver may hang waiting for a response that will never come.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 51 +++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index e6a081c..7083519 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -109,8 +109,8 @@ static union sub_crq *ibmvnic_next_scrq(struct ibmvnic_adapter *,
 					struct ibmvnic_sub_crq_queue *);
 static int ibmvnic_poll(struct napi_struct *napi, int data);
 static void send_map_query(struct ibmvnic_adapter *adapter);
-static void send_request_map(struct ibmvnic_adapter *, dma_addr_t, __be32, u8);
-static void send_request_unmap(struct ibmvnic_adapter *, u8);
+static int send_request_map(struct ibmvnic_adapter *, dma_addr_t, __be32, u8);
+static int send_request_unmap(struct ibmvnic_adapter *, u8);
 static int send_login(struct ibmvnic_adapter *adapter);
 static void send_cap_queries(struct ibmvnic_adapter *adapter);
 static int init_sub_crqs(struct ibmvnic_adapter *);
@@ -172,6 +172,7 @@ static int alloc_long_term_buff(struct ibmvnic_adapter *adapter,
 				struct ibmvnic_long_term_buff *ltb, int size)
 {
 	struct device *dev = &adapter->vdev->dev;
+	int rc;
 
 	ltb->size = size;
 	ltb->buff = dma_alloc_coherent(dev, ltb->size, &ltb->addr,
@@ -185,8 +186,12 @@ static int alloc_long_term_buff(struct ibmvnic_adapter *adapter,
 	adapter->map_id++;
 
 	init_completion(&adapter->fw_done);
-	send_request_map(adapter, ltb->addr,
-			 ltb->size, ltb->map_id);
+	rc = send_request_map(adapter, ltb->addr,
+			      ltb->size, ltb->map_id);
+	if (rc) {
+		dma_free_coherent(dev, ltb->size, ltb->buff, ltb->addr);
+		return rc;
+	}
 	wait_for_completion(&adapter->fw_done);
 
 	if (adapter->fw_done_rc) {
@@ -215,10 +220,14 @@ static void free_long_term_buff(struct ibmvnic_adapter *adapter,
 static int reset_long_term_buff(struct ibmvnic_adapter *adapter,
 				struct ibmvnic_long_term_buff *ltb)
 {
+	int rc;
+
 	memset(ltb->buff, 0, ltb->size);
 
 	init_completion(&adapter->fw_done);
-	send_request_map(adapter, ltb->addr, ltb->size, ltb->map_id);
+	rc = send_request_map(adapter, ltb->addr, ltb->size, ltb->map_id);
+	if (rc)
+		return rc;
 	wait_for_completion(&adapter->fw_done);
 
 	if (adapter->fw_done_rc) {
@@ -952,6 +961,7 @@ static int ibmvnic_get_vpd(struct ibmvnic_adapter *adapter)
 	struct device *dev = &adapter->vdev->dev;
 	union ibmvnic_crq crq;
 	int len = 0;
+	int rc;
 
 	if (adapter->vpd->buff)
 		len = adapter->vpd->len;
@@ -959,7 +969,9 @@ static int ibmvnic_get_vpd(struct ibmvnic_adapter *adapter)
 	init_completion(&adapter->fw_done);
 	crq.get_vpd_size.first = IBMVNIC_CRQ_CMD;
 	crq.get_vpd_size.cmd = GET_VPD_SIZE;
-	ibmvnic_send_crq(adapter, &crq);
+	rc = ibmvnic_send_crq(adapter, &crq);
+	if (rc)
+		return rc;
 	wait_for_completion(&adapter->fw_done);
 
 	if (!adapter->vpd->len)
@@ -992,7 +1004,12 @@ static int ibmvnic_get_vpd(struct ibmvnic_adapter *adapter)
 	crq.get_vpd.cmd = GET_VPD;
 	crq.get_vpd.ioba = cpu_to_be32(adapter->vpd->dma_addr);
 	crq.get_vpd.len = cpu_to_be32((u32)adapter->vpd->len);
-	ibmvnic_send_crq(adapter, &crq);
+	rc = ibmvnic_send_crq(adapter, &crq);
+	if (rc) {
+		kfree(adapter->vpd->buff);
+		adapter->vpd->buff = NULL;
+		return rc;
+	}
 	wait_for_completion(&adapter->fw_done);
 
 	return 0;
@@ -1691,6 +1708,7 @@ static int __ibmvnic_set_mac(struct net_device *netdev, struct sockaddr *p)
 	struct ibmvnic_adapter *adapter = netdev_priv(netdev);
 	struct sockaddr *addr = p;
 	union ibmvnic_crq crq;
+	int rc;
 
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
@@ -1701,7 +1719,9 @@ static int __ibmvnic_set_mac(struct net_device *netdev, struct sockaddr *p)
 	ether_addr_copy(&crq.change_mac_addr.mac_addr[0], addr->sa_data);
 
 	init_completion(&adapter->fw_done);
-	ibmvnic_send_crq(adapter, &crq);
+	rc = ibmvnic_send_crq(adapter, &crq);
+	if (rc)
+		return rc;
 	wait_for_completion(&adapter->fw_done);
 	/* netdev->dev_addr is changed in handle_change_mac_rsp function */
 	return adapter->fw_done_rc ? -EIO : 0;
@@ -2365,6 +2385,7 @@ static void ibmvnic_get_ethtool_stats(struct net_device *dev,
 	struct ibmvnic_adapter *adapter = netdev_priv(dev);
 	union ibmvnic_crq crq;
 	int i, j;
+	int rc;
 
 	memset(&crq, 0, sizeof(crq));
 	crq.request_statistics.first = IBMVNIC_CRQ_CMD;
@@ -2375,7 +2396,9 @@ static void ibmvnic_get_ethtool_stats(struct net_device *dev,
 
 	/* Wait for data to be written */
 	init_completion(&adapter->stats_done);
-	ibmvnic_send_crq(adapter, &crq);
+	rc = ibmvnic_send_crq(adapter, &crq);
+	if (rc)
+		return;
 	wait_for_completion(&adapter->stats_done);
 
 	for (i = 0; i < ARRAY_SIZE(ibmvnic_stats); i++)
@@ -3377,8 +3400,8 @@ static int send_login(struct ibmvnic_adapter *adapter)
 	return -1;
 }
 
-static void send_request_map(struct ibmvnic_adapter *adapter, dma_addr_t addr,
-			     u32 len, u8 map_id)
+static int send_request_map(struct ibmvnic_adapter *adapter, dma_addr_t addr,
+			    u32 len, u8 map_id)
 {
 	union ibmvnic_crq crq;
 
@@ -3388,10 +3411,10 @@ static void send_request_map(struct ibmvnic_adapter *adapter, dma_addr_t addr,
 	crq.request_map.map_id = map_id;
 	crq.request_map.ioba = cpu_to_be32(addr);
 	crq.request_map.len = cpu_to_be32(len);
-	ibmvnic_send_crq(adapter, &crq);
+	return ibmvnic_send_crq(adapter, &crq);
 }
 
-static void send_request_unmap(struct ibmvnic_adapter *adapter, u8 map_id)
+static int send_request_unmap(struct ibmvnic_adapter *adapter, u8 map_id)
 {
 	union ibmvnic_crq crq;
 
@@ -3399,7 +3422,7 @@ static void send_request_unmap(struct ibmvnic_adapter *adapter, u8 map_id)
 	crq.request_unmap.first = IBMVNIC_CRQ_CMD;
 	crq.request_unmap.cmd = REQUEST_UNMAP;
 	crq.request_unmap.map_id = map_id;
-	ibmvnic_send_crq(adapter, &crq);
+	return ibmvnic_send_crq(adapter, &crq);
 }
 
 static void send_map_query(struct ibmvnic_adapter *adapter)
-- 
2.7.5
