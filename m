Return-Path: <B06378@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1EC48B703E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2012 19:10:25 +1000 (EST)
From: Jiajun Wu <b06378@freescale.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
Subject: [PATCH] gianfar: add GRO support
Date: Fri, 20 Apr 2012 16:54:35 +0800
Message-ID: <1334912075-27073-1-git-send-email-b06378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Jiajun Wu <b06378@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace netif_receive_skb with napi_gro_receive.

Signed-off-by: Jiajun Wu <b06378@freescale.com>
---
 drivers/net/ethernet/freescale/gianfar.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index e7bed53..1adb024 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -136,7 +136,7 @@ static void gfar_netpoll(struct net_device *dev);
 int gfar_clean_rx_ring(struct gfar_priv_rx_q *rx_queue, int rx_work_limit);
 static int gfar_clean_tx_ring(struct gfar_priv_tx_q *tx_queue);
 static int gfar_process_frame(struct net_device *dev, struct sk_buff *skb,
-			      int amount_pull);
+			      int amount_pull, struct napi_struct *napi);
 void gfar_halt(struct net_device *dev);
 static void gfar_halt_nodisable(struct net_device *dev);
 void gfar_start(struct net_device *dev);
@@ -2675,12 +2675,12 @@ static inline void gfar_rx_checksum(struct sk_buff *skb, struct rxfcb *fcb)
 /* gfar_process_frame() -- handle one incoming packet if skb
  * isn't NULL.  */
 static int gfar_process_frame(struct net_device *dev, struct sk_buff *skb,
-			      int amount_pull)
+			      int amount_pull, struct napi_struct *napi)
 {
 	struct gfar_private *priv = netdev_priv(dev);
 	struct rxfcb *fcb = NULL;
 
-	int ret;
+	gro_result_t ret;
 
 	/* fcb is at the beginning if exists */
 	fcb = (struct rxfcb *)skb->data;
@@ -2719,9 +2719,9 @@ static int gfar_process_frame(struct net_device *dev, struct sk_buff *skb,
 		__vlan_hwaccel_put_tag(skb, fcb->vlctl);
 
 	/* Send the packet up the stack */
-	ret = netif_receive_skb(skb);
+	ret = napi_gro_receive(napi, skb);
 
-	if (NET_RX_DROP == ret)
+	if (GRO_DROP == ret)
 		priv->extra_stats.kernel_dropped++;
 
 	return 0;
@@ -2783,7 +2783,8 @@ int gfar_clean_rx_ring(struct gfar_priv_rx_q *rx_queue, int rx_work_limit)
 				skb_put(skb, pkt_len);
 				rx_queue->stats.rx_bytes += pkt_len;
 				skb_record_rx_queue(skb, rx_queue->qindex);
-				gfar_process_frame(dev, skb, amount_pull);
+				gfar_process_frame(dev, skb, amount_pull,
+						&rx_queue->grp->napi);
 
 			} else {
 				netif_warn(priv, rx_err, dev, "Missing skb!\n");
-- 
1.5.6.5
