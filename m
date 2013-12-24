Return-Path: <anton@samba.org>
Date: Tue, 24 Dec 2013 12:55:29 +1100
From: Anton Blanchard <anton@samba.org>
To: Joe Perches <joe@perches.com>
Subject: [PATCH] ibmveth: Fix more little endian issues
Message-ID: <20131224125529.58970f1b@kryten>
In-Reply-To: <1387810329.22671.66.camel@joe-AO722>
References: <1387762163-39662-1-git-send-email-agraf@suse.de>
 <20131223173833.0a9a6705@kryten>
 <1387810329.22671.66.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Dinar Valeev <dvaleev@suse.com>, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.de>, netdev@vger.kernel.org,
 Santiago Leon <santil@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The hypervisor expects MAC addresses passed in registers to be big
endian u64. Create a helper function called ibmveth_encode_mac_addr
which does the right thing in both big and little endian.

We were storing the MAC address in a long in struct ibmveth_adapter.
It's never used so remove it - we don't need another place in the
driver where we create endian issues with MAC addresses.

Signed-off-by: Anton Blanchard <anton@samba.org>
Reviewed-by: Alexander Graf <agraf@suse.de>
---

v2: annotate with __be64 as suggested by Joe

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 952d795..bb9a631 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -497,7 +497,7 @@ static void ibmveth_cleanup(struct ibmveth_adapter *adapter)
 }
 
 static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
-        union ibmveth_buf_desc rxq_desc, u64 mac_address)
+			union ibmveth_buf_desc rxq_desc, __be64 mac_address)
 {
 	int rc, try_again = 1;
 
@@ -523,10 +523,20 @@ retry:
 	return rc;
 }
 
+/* The hypervisor expects MAC addresses passed in registers to be
+ * big endian u64.
+ */
+static __be64 ibmveth_encode_mac_addr(char *mac)
+{
+	unsigned long encoded = 0;
+	memcpy(((char *)&encoded) + 2, mac, ETH_ALEN);
+	return cpu_to_be64(encoded);
+}
+
 static int ibmveth_open(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	u64 mac_address = 0;
+	__be64 mac_address = 0;
 	int rxq_entries = 1;
 	unsigned long lpar_rc;
 	int rc;
@@ -580,8 +590,7 @@ static int ibmveth_open(struct net_device *netdev)
 	adapter->rx_queue.num_slots = rxq_entries;
 	adapter->rx_queue.toggle = 1;
 
-	memcpy(&mac_address, netdev->dev_addr, netdev->addr_len);
-	mac_address = mac_address >> 16;
+	mac_address = ibmveth_encode_mac_addr(netdev->dev_addr);
 
 	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
 					adapter->rx_queue.queue_len;
@@ -1184,8 +1193,8 @@ static void ibmveth_set_multicast_list(struct net_device *netdev)
 		/* add the addresses to the filter table */
 		netdev_for_each_mc_addr(ha, netdev) {
 			/* add the multicast address to the filter table */
-			unsigned long mcast_addr = 0;
-			memcpy(((char *)&mcast_addr)+2, ha->addr, ETH_ALEN);
+			__be64 mcast_addr;
+			mcast_addr = ibmveth_encode_mac_addr(ha->addr);
 			lpar_rc = h_multicast_ctrl(adapter->vdev->unit_address,
 						   IbmVethMcastAddFilter,
 						   mcast_addr);
@@ -1369,9 +1378,6 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	netif_napi_add(netdev, &adapter->napi, ibmveth_poll, 16);
 
-	adapter->mac_addr = 0;
-	memcpy(&adapter->mac_addr, mac_addr_p, ETH_ALEN);
-
 	netdev->irq = dev->irq;
 	netdev->netdev_ops = &ibmveth_netdev_ops;
 	netdev->ethtool_ops = &netdev_ethtool_ops;
@@ -1380,7 +1386,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
 	netdev->features |= netdev->hw_features;
 
-	memcpy(netdev->dev_addr, &adapter->mac_addr, netdev->addr_len);
+	memcpy(netdev->dev_addr, mac_addr_p, ETH_ALEN);
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
 		struct kobject *kobj = &adapter->rx_buff_pool[i].kobj;
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 84066ba..2c636cb 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -139,7 +139,6 @@ struct ibmveth_adapter {
     struct napi_struct napi;
     struct net_device_stats stats;
     unsigned int mcastFilterSize;
-    unsigned long mac_addr;
     void * buffer_list_addr;
     void * filter_list_addr;
     dma_addr_t buffer_list_dma;
