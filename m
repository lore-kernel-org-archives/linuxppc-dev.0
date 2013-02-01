Return-Path: <B29408@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D599A2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 20:07:35 +1100 (EST)
From: Jianhua Xie <jianhua.xie@freescale.com>
To: <claudiu.manoil@freescale.com>, <davem@davemloft.net>
Subject: [PATCH 1/2] gianfar: Clean up an unnecessary function gfar_new_skb
Date: Fri, 1 Feb 2013 17:07:07 +0800
Message-ID: <1359709627-18223-1-git-send-email-jianhua.xie@freescale.com>
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

Clean up an unnecessary function gfar_new_skb, since gfar_new_skb()
has the same parameters, return value and function as gfar_alloc_skb(),
should be cleaned up.

Signed-off-by: Jianhua Xie <jianhua.xie@freescale.com>
---
 drivers/net/ethernet/freescale/gianfar.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index bffb2ed..94d36ac 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -110,7 +110,7 @@ static int gfar_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static void gfar_reset_task(struct work_struct *work);
 static void gfar_timeout(struct net_device *dev);
 static int gfar_close(struct net_device *dev);
-struct sk_buff *gfar_new_skb(struct net_device *dev);
+static struct sk_buff *gfar_alloc_skb(struct net_device *dev);
 static void gfar_new_rxbdp(struct gfar_priv_rx_q *rx_queue, struct rxbd8 *bdp,
 			   struct sk_buff *skb);
 static int gfar_set_mac_address(struct net_device *dev);
@@ -207,7 +207,7 @@ static int gfar_init_bds(struct net_device *ndev)
 				gfar_init_rxbdp(rx_queue, rxbdp,
 						rxbdp->bufPtr);
 			} else {
-				skb = gfar_new_skb(ndev);
+				skb = gfar_alloc_skb(ndev);
 				if (!skb) {
 					netdev_err(ndev, "Can't allocate RX buffers\n");
 					return -ENOMEM;
@@ -2612,11 +2612,6 @@ static struct sk_buff *gfar_alloc_skb(struct net_device *dev)
 	return skb;
 }
 
-struct sk_buff *gfar_new_skb(struct net_device *dev)
-{
-	return gfar_alloc_skb(dev);
-}
-
 static inline void count_errors(unsigned short status, struct net_device *dev)
 {
 	struct gfar_private *priv = netdev_priv(dev);
@@ -2754,7 +2749,7 @@ int gfar_clean_rx_ring(struct gfar_priv_rx_q *rx_queue, int rx_work_limit)
 		rmb();
 
 		/* Add another skb for the future */
-		newskb = gfar_new_skb(dev);
+		newskb = gfar_alloc_skb(dev);
 
 		skb = rx_queue->rx_skbuff[rx_queue->skb_currx];
 
-- 
1.7.9.5
