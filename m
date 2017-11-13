Return-Path: <desnesn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybJLw6PP9zDqj8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 04:59:52 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vADHwaW5029597
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 12:59:50 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e7bue8dwa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 12:59:50 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <desnesn@linux.vnet.ibm.com>;
 Mon, 13 Nov 2017 10:59:49 -0700
From: Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, tlfalcon@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com
Subject: [PATCH] [net-next,
 v4] ibmvnic: Feature implementation of Vital Product Data (VPD) for
 the ibmvnic driver
Date: Mon, 13 Nov 2017 15:59:19 -0200
Message-Id: <20171113175919.22541-1-desnesn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch implements and enables VDP support for the ibmvnic driver.
Moreover, it includes the implementation of suitable structs, signal
 transmission/handling and functions which allows the retrival of firmware
 information from the ibmvnic card through the ethtool command.

Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>
Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 153 ++++++++++++++++++++++++++++++++++++-
 drivers/net/ethernet/ibm/ibmvnic.h |  27 ++++++-
 2 files changed, 176 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index b918bc2..04aaacb 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -574,6 +574,15 @@ static int reset_tx_pools(struct ibmvnic_adapter *adapter)
 	return 0;
 }
 
+static void release_vpd_data(struct ibmvnic_adapter *adapter)
+{
+	if (!adapter->vpd)
+		return;
+
+	kfree(adapter->vpd->buff);
+	kfree(adapter->vpd);
+}
+
 static void release_tx_pools(struct ibmvnic_adapter *adapter)
 {
 	struct ibmvnic_tx_pool *tx_pool;
@@ -754,6 +763,8 @@ static void release_resources(struct ibmvnic_adapter *adapter)
 {
 	int i;
 
+	release_vpd_data(adapter);
+
 	release_tx_pools(adapter);
 	release_rx_pools(adapter);
 
@@ -834,6 +845,57 @@ static int set_real_num_queues(struct net_device *netdev)
 	return rc;
 }
 
+static int ibmvnic_get_vpd(struct ibmvnic_adapter *adapter)
+{
+	struct device *dev = &adapter->vdev->dev;
+	union ibmvnic_crq crq;
+	dma_addr_t dma_addr;
+	int len = 0;
+
+	if (adapter->vpd->buff)
+		len = adapter->vpd->len;
+
+	reinit_completion(&adapter->fw_done);
+	crq.get_vpd_size.first = IBMVNIC_CRQ_CMD;
+	crq.get_vpd_size.cmd = GET_VPD_SIZE;
+	ibmvnic_send_crq(adapter, &crq);
+	wait_for_completion(&adapter->fw_done);
+
+	if (!adapter->vpd->len)
+		return -ENODATA;
+
+	if (!adapter->vpd->buff)
+		adapter->vpd->buff = kzalloc(adapter->vpd->len, GFP_KERNEL);
+	else if (adapter->vpd->len != len)
+		adapter->vpd->buff =
+			krealloc(adapter->vpd->buff,
+				 adapter->vpd->len, GFP_KERNEL);
+
+	if (!adapter->vpd->buff) {
+		dev_err(dev, "Could allocate VPD buffer\n");
+		return -ENOMEM;
+	}
+
+	adapter->vpd->dma_addr =
+		dma_map_single(dev, adapter->vpd->buff, adapter->vpd->len,
+			       DMA_FROM_DEVICE);
+	if (dma_mapping_error(dev, dma_addr)) {
+		dev_err(dev, "Could not map VPD buffer\n");
+		kfree(adapter->vpd->buff);
+		return -ENOMEM;
+	}
+
+	reinit_completion(&adapter->fw_done);
+	crq.get_vpd.first = IBMVNIC_CRQ_CMD;
+	crq.get_vpd.cmd = GET_VPD;
+	crq.get_vpd.ioba = cpu_to_be32(adapter->vpd->dma_addr);
+	crq.get_vpd.len = cpu_to_be32((u32)adapter->vpd->len);
+	ibmvnic_send_crq(adapter, &crq);
+	wait_for_completion(&adapter->fw_done);
+
+	return 0;
+}
+
 static int init_resources(struct ibmvnic_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
@@ -851,6 +913,10 @@ static int init_resources(struct ibmvnic_adapter *adapter)
 	if (rc)
 		return rc;
 
+	adapter->vpd = kzalloc(sizeof(*adapter->vpd), GFP_KERNEL);
+	if (!adapter->vpd)
+		return -ENOMEM;
+
 	adapter->map_id = 1;
 	adapter->napi = kcalloc(adapter->req_rx_queues,
 				sizeof(struct napi_struct), GFP_KERNEL);
@@ -924,7 +990,7 @@ static int __ibmvnic_open(struct net_device *netdev)
 static int ibmvnic_open(struct net_device *netdev)
 {
 	struct ibmvnic_adapter *adapter = netdev_priv(netdev);
-	int rc;
+	int rc, vpd;
 
 	mutex_lock(&adapter->reset_lock);
 
@@ -951,6 +1017,12 @@ static int ibmvnic_open(struct net_device *netdev)
 
 	rc = __ibmvnic_open(netdev);
 	netif_carrier_on(netdev);
+
+	/* Vital Product Data (VPD) */
+	vpd = ibmvnic_get_vpd(adapter);
+	if (vpd)
+		netdev_err(netdev, "failed to initialize Vital Product Data (VPD)\n");
+
 	mutex_unlock(&adapter->reset_lock);
 
 	return rc;
@@ -1879,11 +1951,15 @@ static int ibmvnic_get_link_ksettings(struct net_device *netdev,
 	return 0;
 }
 
-static void ibmvnic_get_drvinfo(struct net_device *dev,
+static void ibmvnic_get_drvinfo(struct net_device *netdev,
 				struct ethtool_drvinfo *info)
 {
+	struct ibmvnic_adapter *adapter = netdev_priv(netdev);
+
 	strlcpy(info->driver, ibmvnic_driver_name, sizeof(info->driver));
 	strlcpy(info->version, IBMVNIC_DRIVER_VERSION, sizeof(info->version));
+	strlcpy(info->fw_version, adapter->fw_version,
+		sizeof(info->fw_version));
 }
 
 static u32 ibmvnic_get_msglevel(struct net_device *netdev)
@@ -3140,6 +3216,73 @@ static void send_cap_queries(struct ibmvnic_adapter *adapter)
 	ibmvnic_send_crq(adapter, &crq);
 }
 
+static void handle_vpd_size_rsp(union ibmvnic_crq *crq,
+				struct ibmvnic_adapter *adapter)
+{
+	struct device *dev = &adapter->vdev->dev;
+
+	if (crq->get_vpd_size_rsp.rc.code) {
+		dev_err(dev, "Error retrieving VPD size, rc=%x\n",
+			crq->get_vpd_size_rsp.rc.code);
+		complete(&adapter->fw_done);
+		return;
+	}
+
+	adapter->vpd->len = be64_to_cpu(crq->get_vpd_size_rsp.len);
+	complete(&adapter->fw_done);
+}
+
+static void handle_vpd_rsp(union ibmvnic_crq *crq,
+			   struct ibmvnic_adapter *adapter)
+{
+	struct device *dev = &adapter->vdev->dev;
+	unsigned char *substr = NULL, *ptr = NULL;
+	u8 fw_level_len = 0;
+
+	memset(adapter->fw_version, 0, 32);
+
+	dma_unmap_single(dev, adapter->vpd->dma_addr, adapter->vpd->len,
+			 DMA_FROM_DEVICE);
+
+	if (crq->get_vpd_rsp.rc.code) {
+		dev_err(dev, "Error retrieving VPD from device, rc=%x\n",
+			crq->get_vpd_rsp.rc.code);
+		goto complete;
+	}
+
+	/* get the position of the firmware version info
+	 * located after the ASCII 'RM' substring in the buffer
+	 */
+	substr = strnstr(adapter->vpd->buff, "RM", adapter->vpd->len);
+	if (!substr) {
+		dev_info(dev, "No FW level provided by VPD\n");
+		goto complete;
+	}
+
+	/* get length of firmware level ASCII substring */
+	if ((substr + 2) < (adapter->vpd->buff + adapter->vpd->len)) {
+		fw_level_len = *(substr + 2);
+	} else {
+		dev_info(dev, "Length of FW substr extrapolated VDP buff\n");
+		goto complete;
+	}
+
+	/* copy firmware version string from vpd into adapter */
+	if ((substr + 3 + fw_level_len) <
+	    (adapter->vpd->buff + adapter->vpd->len)) {
+		ptr = strncpy((char *)adapter->fw_version,
+			      substr + 3, fw_level_len);
+
+		if (!ptr)
+			dev_err(dev, "Failed to isolate FW level string\n");
+	} else {
+		dev_info(dev, "FW substr extrapolated VPD buff\n");
+	}
+
+complete:
+	complete(&adapter->fw_done);
+}
+
 static void handle_query_ip_offload_rsp(struct ibmvnic_adapter *adapter)
 {
 	struct device *dev = &adapter->vdev->dev;
@@ -3871,6 +4014,12 @@ static void ibmvnic_handle_crq(union ibmvnic_crq *crq,
 		netdev_dbg(netdev, "Got Collect firmware trace Response\n");
 		complete(&adapter->fw_done);
 		break;
+	case GET_VPD_SIZE_RSP:
+		handle_vpd_size_rsp(crq, adapter);
+		break;
+	case GET_VPD_RSP:
+		handle_vpd_rsp(crq, adapter);
+		break;
 	default:
 		netdev_err(netdev, "Got an invalid cmd type 0x%02x\n",
 			   gen_crq->cmd);
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index 8ed829c..4487f1e 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -560,6 +560,12 @@ struct ibmvnic_multicast_ctrl {
 	struct ibmvnic_rc rc;
 } __packed __aligned(8);
 
+struct ibmvnic_get_vpd_size {
+	u8 first;
+	u8 cmd;
+	u8 reserved[14];
+} __packed __aligned(8);
+
 struct ibmvnic_get_vpd_size_rsp {
 	u8 first;
 	u8 cmd;
@@ -577,6 +583,13 @@ struct ibmvnic_get_vpd {
 	u8 reserved[4];
 } __packed __aligned(8);
 
+struct ibmvnic_get_vpd_rsp {
+	u8 first;
+	u8 cmd;
+	u8 reserved[10];
+	struct ibmvnic_rc rc;
+} __packed __aligned(8);
+
 struct ibmvnic_acl_change_indication {
 	u8 first;
 	u8 cmd;
@@ -702,10 +715,10 @@ union ibmvnic_crq {
 	struct ibmvnic_change_mac_addr change_mac_addr_rsp;
 	struct ibmvnic_multicast_ctrl multicast_ctrl;
 	struct ibmvnic_multicast_ctrl multicast_ctrl_rsp;
-	struct ibmvnic_generic_crq get_vpd_size;
+	struct ibmvnic_get_vpd_size get_vpd_size;
 	struct ibmvnic_get_vpd_size_rsp get_vpd_size_rsp;
 	struct ibmvnic_get_vpd get_vpd;
-	struct ibmvnic_generic_crq get_vpd_rsp;
+	struct ibmvnic_get_vpd_rsp get_vpd_rsp;
 	struct ibmvnic_acl_change_indication acl_change_indication;
 	struct ibmvnic_acl_query acl_query;
 	struct ibmvnic_generic_crq acl_query_rsp;
@@ -939,6 +952,12 @@ struct ibmvnic_error_buff {
 	__be32 error_id;
 };
 
+struct ibmvnic_vpd {
+	unsigned char *buff;
+	dma_addr_t dma_addr;
+	u64 len;
+};
+
 enum vnic_state {VNIC_PROBING = 1,
 		 VNIC_PROBED,
 		 VNIC_OPENING,
@@ -980,6 +999,10 @@ struct ibmvnic_adapter {
 	dma_addr_t ip_offload_ctrl_tok;
 	u32 msg_enable;
 
+	/* Vital Product Data (VPD) */
+	struct ibmvnic_vpd *vpd;
+	char fw_version[32];
+
 	/* Statistics */
 	struct ibmvnic_statistics stats;
 	dma_addr_t stats_token;
-- 
2.9.5
