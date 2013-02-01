Return-Path: <B29408@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3D7522C0086
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 20:13:17 +1100 (EST)
From: Jianhua Xie <jianhua.xie@freescale.com>
To: <claudiu.manoil@freescale.com>, <davem@davemloft.net>
Subject: [PATCH 2/2] gianfar: Add a parameter to support allocation skb
 GFP_KERNEL and GFP_ATOMIC
Date: Fri, 1 Feb 2013 17:12:49 +0800
Message-ID: <1359709969-18381-1-git-send-email-jianhua.xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Jianhua Xie <jianhua.xie@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While allocation skb in IRQ/SOFTIRQ, such as processing each frame
in the rx ring, alloc skb should be ATOMIC based, should not sleep.

When allocation skb is not in IRQ/SOFTIRQ, such as allocation skb
when initializing a net driver, starting up the NIC from stopped
status. In this case, it is not necessary to alloc memory base on
GFP_ATOMIC, should use GFP_KERNEL.

The second method also avoid kernel crash and reporting -ENOMEM
when free low memory is near vm.min_free_kbytes as below:

Signed-off-by: Jianhua Xie <jianhua.xie@freescale.com>
---
 drivers/net/ethernet/freescale/gianfar.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 94d36ac..559a01c 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -110,7 +110,7 @@ static int gfar_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static void gfar_reset_task(struct work_struct *work);
 static void gfar_timeout(struct net_device *dev);
 static int gfar_close(struct net_device *dev);
-static struct sk_buff *gfar_alloc_skb(struct net_device *dev);
+static struct sk_buff *gfar_alloc_skb(struct net_device *dev, gfp_t gfp_mask);
 static void gfar_new_rxbdp(struct gfar_priv_rx_q *rx_queue, struct rxbd8 *bdp,
 			   struct sk_buff *skb);
 static int gfar_set_mac_address(struct net_device *dev);
@@ -207,7 +207,7 @@ static int gfar_init_bds(struct net_device *ndev)
 				gfar_init_rxbdp(rx_queue, rxbdp,
 						rxbdp->bufPtr);
 			} else {
-				skb = gfar_alloc_skb(ndev);
+				skb = gfar_alloc_skb(ndev, GFP_KERNEL);
 				if (!skb) {
 					netdev_err(ndev, "Can't allocate RX buffers\n");
 					return -ENOMEM;
@@ -2598,12 +2598,13 @@ static void gfar_new_rxbdp(struct gfar_priv_rx_q *rx_queue, struct rxbd8 *bdp,
 	gfar_init_rxbdp(rx_queue, bdp, buf);
 }
 
-static struct sk_buff *gfar_alloc_skb(struct net_device *dev)
+static struct sk_buff *gfar_alloc_skb(struct net_device *dev, gfp_t gfp_mask)
 {
 	struct gfar_private *priv = netdev_priv(dev);
 	struct sk_buff *skb;
 
-	skb = netdev_alloc_skb(dev, priv->rx_buffer_size + RXBUF_ALIGNMENT);
+	skb = __netdev_alloc_skb(dev, priv->rx_buffer_size + RXBUF_ALIGNMENT,
+				gfp_mask);
 	if (!skb)
 		return NULL;
 
@@ -2749,7 +2750,7 @@ int gfar_clean_rx_ring(struct gfar_priv_rx_q *rx_queue, int rx_work_limit)
 		rmb();
 
 		/* Add another skb for the future */
-		newskb = gfar_alloc_skb(dev);
+		newskb = gfar_alloc_skb(dev, GFP_ATOMIC);
 
 		skb = rx_queue->rx_skbuff[rx_queue->skb_currx];
 
-- 
1.7.9.5
