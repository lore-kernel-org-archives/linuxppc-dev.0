Return-Path: <sshukla@sh.mvista.com>
Subject: [PATCH] Xilinx LL-TEMAC: Add Netpoll controller support
From: santosh shukla <sshukla@sh.mvista.com>
To: Linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 14 Oct 2009 11:42:14 +0530
Message-Id: <1255500735.2591.13.camel@santosh>
Mime-Version: 1.0
Cc: John.Linn@xilinx.com
Reply-To: sshukla@sh.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Santosh Shukla <sshukla@sh.mvista.com>
Date: Tue, 13 Oct 2009 18:55:57 +0530
Subject: [PATCH] Xilinx LL-TEMAC: Add Netpoll controller support

Adding Netpoll controller support to Xilinx LL-TEMAC ethernet
driver.Repaced Rx, Tx tasklet schedule call with their handlers,
Added correct version of call which can execute interrupt on/off
context i.e. dev_kfree_skb_any().
---
 drivers/net/xilinx_lltemac/xlltemac_main.c |   41 +++++++++++++++++++++++++++-
 1 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/drivers/net/xilinx_lltemac/xlltemac_main.c b/drivers/net/xilinx_lltemac/xlltemac_main.c
index b245422..697f474 100644
--- a/drivers/net/xilinx_lltemac/xlltemac_main.c
+++ b/drivers/net/xilinx_lltemac/xlltemac_main.c
@@ -87,11 +87,18 @@
 #define BUFFER_ALIGNSEND_PERF(adr) ((ALIGNMENT_SEND_PERF - ((u32) adr)) % 32)
 #define BUFFER_ALIGNRECV(adr) ((ALIGNMENT_RECV - ((u32) adr)) % 32)
 
+#ifndef CONFIG_NET_POLL_CONTROLLER
 /* Default TX/RX Threshold and waitbound values for SGDMA mode */
 #define DFT_TX_THRESHOLD  24
 #define DFT_TX_WAITBOUND  254
 #define DFT_RX_THRESHOLD  4
 #define DFT_RX_WAITBOUND  254
+#else
+#define DFT_TX_THRESHOLD  1
+#define DFT_TX_WAITBOUND  0
+#define DFT_RX_THRESHOLD  1
+#define DFT_RX_WAITBOUND  0
+#endif
 
 #define XTE_AUTOSTRIPPING 1
 
@@ -1097,7 +1104,11 @@ static irqreturn_t xenet_dma_rx_interrupt(int irq, void *dev_id)
 			list_add_tail(&lp->rcv, &receivedQueue);
 			XLlDma_mBdRingIntDisable(&lp->Dma.RxBdRing,
 						 XLLDMA_CR_IRQ_ALL_EN_MASK);
+#ifndef CONFIG_NET_POLL_CONTROLLER
 			tasklet_schedule(&DmaRecvBH);
+#else
+			DmaRecvHandlerBH(0);
+#endif
 		}
 		spin_unlock_irqrestore(&receivedQueueSpin, flags);
 	}
@@ -1134,7 +1145,11 @@ static irqreturn_t xenet_dma_tx_interrupt(int irq, void *dev_id)
 			list_add_tail(&lp->xmit, &sentQueue);
 			XLlDma_mBdRingIntDisable(&lp->Dma.TxBdRing,
 						 XLLDMA_CR_IRQ_ALL_EN_MASK);
+#ifndef CONFIG_NET_POLL_CONTROLLER
 			tasklet_schedule(&DmaSendBH);
+#else
+			DmaSendHandlerBH(0);
+#endif
 		}
 		spin_unlock_irqrestore(&sentQueueSpin, flags);
 	}
@@ -1711,11 +1726,15 @@ static int xenet_DmaSend(struct sk_buff *skb, struct net_device *dev)
 	 * SgAlloc, SgCommit sequence, which also exists in DmaSendHandlerBH Bottom
 	 * Half, or triggered by other processor in SMP case.
 	 */
+#ifndef CONFIG_NET_POLL_CONTROLLER
 	spin_lock_bh(&XTE_tx_spinlock);
+#endif
 
 	xenet_DmaSend_internal(skb, dev);
 
+#ifndef CONFIG_NET_POLL_CONTROLLER
 	spin_unlock_bh(&XTE_tx_spinlock);
+#endif
 
 	return 0;
 }
@@ -1764,7 +1783,7 @@ static void DmaSendHandlerBH(unsigned long p)
 				skb = (struct sk_buff *)
 					XLlDma_mBdGetId(BdCurPtr);
 				if (skb)
-					dev_kfree_skb(skb);
+					dev_kfree_skb_any(skb);
 
 				/* reset BD id */
 				XLlDma_mBdSetId(BdCurPtr, NULL);
@@ -3220,6 +3239,23 @@ static int detect_phy(struct net_local *lp, char *dev_name)
 	return 0;		/* default to zero */
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void
+lltemac_poll_controller(struct net_device *ndev)
+{
+       struct net_local *lp = netdev_priv(ndev);
+
+       disable_irq(lp->dma_irq_s);
+       disable_irq(lp->dma_irq_r);
+
+       xenet_dma_tx_interrupt(lp->dma_irq_s, ndev);
+       xenet_dma_rx_interrupt(lp->dma_irq_r, ndev);
+
+       enable_irq(lp->dma_irq_s);
+       enable_irq(lp->dma_irq_r);
+}
+#endif
+
 static struct net_device_ops xilinx_netdev_ops;
 
 /* From include/linux/ethtool.h */
@@ -3491,6 +3527,9 @@ static struct net_device_ops xilinx_netdev_ops = {
 	.ndo_change_mtu	= xenet_change_mtu,
 	.ndo_tx_timeout	= xenet_tx_timeout,
 	.ndo_get_stats	= xenet_get_stats,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller = lltemac_poll_controller,
+#endif
 };
 
 static struct of_device_id xtenet_fifo_of_match[] = {
-- 
1.6.3.3.220.g609a0
