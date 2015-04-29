Return-Path: <madalin.bucur@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0139.outbound.protection.outlook.com [157.56.111.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D97B81A118D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 00:57:03 +1000 (AEST)
From: Madalin Bucur <madalin.bucur@freescale.com>
To: <netdev@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [RFC,v3 05/10] dpaa_eth: add driver's Tx queue selection mechanism
Date: Wed, 29 Apr 2015 17:56:40 +0300
Message-ID: <1430319405-31280-4-git-send-email-madalin.bucur@freescale.com>
In-Reply-To: <1430319405-31280-3-git-send-email-madalin.bucur@freescale.com>
References: <1430319405-31280-1-git-send-email-madalin.bucur@freescale.com>
 <1430319405-31280-2-git-send-email-madalin.bucur@freescale.com>
 <1430319405-31280-3-git-send-email-madalin.bucur@freescale.com>
Reply-To: <madalin.bucur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org, Madalin Bucur <madalin.bucur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allow the selection of the transmission queue based on the CPU id.

Signed-off-by: Madalin Bucur <madalin.bucur@freescale.com>
---
 drivers/net/ethernet/freescale/dpaa/Kconfig           | 10 ++++++++++
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c        |  3 +++
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.h        |  6 ++++++
 drivers/net/ethernet/freescale/dpaa/dpaa_eth_common.c |  9 +++++++++
 drivers/net/ethernet/freescale/dpaa/dpaa_eth_common.h |  4 ++++
 5 files changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa/Kconfig b/drivers/net/ethernet/freescale/dpaa/Kconfig
index 9e6a39f..3fa7925 100644
--- a/drivers/net/ethernet/freescale/dpaa/Kconfig
+++ b/drivers/net/ethernet/freescale/dpaa/Kconfig
@@ -11,6 +11,16 @@ menuconfig FSL_DPAA_ETH
 
 if FSL_DPAA_ETH
 
+config FSL_DPAA_ETH_USE_NDO_SELECT_QUEUE
+	bool "Use driver's Tx queue selection mechanism"
+	default y
+	---help---
+	  The DPAA-Ethernet driver defines a ndo_select_queue() callback for optimal selection
+	  of the egress FQ. That will override the XPS support for this netdevice.
+	  If for whatever reason you want to be in control of the egress FQ-to-CPU selection and mapping,
+	  or simply don't want to use the driver's ndo_select_queue() callback, then unselect this
+	  and use the standard XPS support instead.
+
 config FSL_DPAA_ETH_MAX_BUF_COUNT
 	int "Maximum number of buffers in private bpool"
 	range 64 2048
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index ba4bd3a..2ba929b 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -387,6 +387,9 @@ static const struct net_device_ops dpa_private_ops = {
 	.ndo_get_stats64 = dpa_get_stats64,
 	.ndo_set_mac_address = dpa_set_mac_address,
 	.ndo_validate_addr = eth_validate_addr,
+#ifdef CONFIG_FSL_DPAA_ETH_USE_NDO_SELECT_QUEUE
+	.ndo_select_queue = dpa_select_queue,
+#endif
 	.ndo_change_mtu = dpa_change_mtu,
 	.ndo_set_rx_mode = dpa_set_rx_mode,
 	.ndo_init = dpa_ndo_init,
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
index 7656c85..0162a21 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
@@ -431,9 +431,15 @@ static inline void _dpa_assign_wq(struct dpa_fq *fq)
 	}
 }
 
+#ifdef CONFIG_FSL_DPAA_ETH_USE_NDO_SELECT_QUEUE
+/* Use in lieu of skb_get_queue_mapping() */
+#define dpa_get_queue_mapping(skb) \
+	smp_processor_id()
+#else
 /* Use the queue selected by XPS */
 #define dpa_get_queue_mapping(skb) \
 	skb_get_queue_mapping(skb)
+#endif
 
 static inline void _dpa_bp_free_pf(void *addr)
 {
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth_common.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth_common.c
index dc8bc41..9b137f8 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth_common.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth_common.c
@@ -607,6 +607,15 @@ bool dpa_bpid2pool_use(int bpid)
 	return false;
 }
 
+#ifdef CONFIG_FSL_DPAA_ETH_USE_NDO_SELECT_QUEUE
+u16 dpa_select_queue(struct net_device *net_dev, struct sk_buff *skb,
+		     void *accel_priv, select_queue_fallback_t fallback)
+{
+	return dpa_get_queue_mapping(skb);
+}
+EXPORT_SYMBOL(dpa_select_queue);
+#endif
+
 struct dpa_fq *dpa_fq_alloc(struct device *dev,
 			    const struct fqid_cell *fqids,
 			    struct list_head *list,
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth_common.h b/drivers/net/ethernet/freescale/dpaa/dpaa_eth_common.h
index 7355cd6..d837d40 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth_common.h
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth_common.h
@@ -89,6 +89,10 @@ struct dpa_bp *dpa_bpid2pool(int bpid);
 void dpa_bpid2pool_map(int bpid, struct dpa_bp *dpa_bp);
 bool dpa_bpid2pool_use(int bpid);
 void dpa_bp_drain(struct dpa_bp *bp);
+#ifdef CONFIG_FSL_DPAA_ETH_USE_NDO_SELECT_QUEUE
+u16 dpa_select_queue(struct net_device *net_dev, struct sk_buff *skb,
+		     void *accel_priv, select_queue_fallback_t fallback);
+#endif
 struct dpa_fq *dpa_fq_alloc(struct device *dev,
 			    const struct fqid_cell *fqids,
 			    struct list_head *list,
-- 
1.7.11.7
