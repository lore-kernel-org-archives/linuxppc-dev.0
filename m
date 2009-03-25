Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59776DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 00:30:54 +1100 (EST)
Received: from tmnt04.transmode.se (tmnt04.transmode.se [192.168.46.15])
	by gw1.transmode.se (Postfix) with ESMTP id 9D14B8608D
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 14:30:49 +0100 (CET)
Subject: [PATCH] ucc_geth: Move freeing of TX packets to NAPI context.
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Netdev <netdev@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 25 Mar 2009 14:30:49 +0100
Message-Id: <1237987849.2194.9.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>, leoli@freescale.com
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From 1c2f23b1f37f4818c0fd0217b93eb38ab6564840 Mon Sep 17 00:00:00 2001
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Tue, 24 Mar 2009 10:19:27 +0100
Subject: [PATCH] ucc_geth: Move freeing of TX packets to NAPI context.
 Also increase NAPI weight somewhat.
 This will make the system alot more responsive while
 ping flooding the ucc_geth ethernet interaface.


Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 drivers/net/ucc_geth.c |   30 +++++++++++-------------------
 drivers/net/ucc_geth.h |    2 +-
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 097aed8..7d5d110 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -3214,7 +3214,7 @@ static int ucc_geth_tx(struct net_device *dev, u8 txQ)
 		dev->stats.tx_packets++;
 
 		/* Free the sk buffer associated with this TxBD */
-		dev_kfree_skb_irq(ugeth->
+		dev_kfree_skb(ugeth->
 				  tx_skbuff[txQ][ugeth->skb_dirtytx[txQ]]);
 		ugeth->tx_skbuff[txQ][ugeth->skb_dirtytx[txQ]] = NULL;
 		ugeth->skb_dirtytx[txQ] =
@@ -3248,9 +3248,16 @@ static int ucc_geth_poll(struct napi_struct *napi, int budget)
 	for (i = 0; i < ug_info->numQueuesRx; i++)
 		howmany += ucc_geth_rx(ugeth, i, budget - howmany);
 
+	/* Tx event processing */
+	spin_lock(&ugeth->lock);
+	for (i = 0; i < ug_info->numQueuesTx; i++) {
+		ucc_geth_tx(ugeth->dev, i);
+	}
+	spin_unlock(&ugeth->lock);
+
 	if (howmany < budget) {
 		netif_rx_complete(napi);
-		setbits32(ugeth->uccf->p_uccm, UCCE_RX_EVENTS);
+		setbits32(ugeth->uccf->p_uccm, UCCE_RX_EVENTS | UCCE_TX_EVENTS);
 	}
 
 	return howmany;
@@ -3264,8 +3271,6 @@ static irqreturn_t ucc_geth_irq_handler(int irq, void *info)
 	struct ucc_geth_info *ug_info;
 	register u32 ucce;
 	register u32 uccm;
-	register u32 tx_mask;
-	u8 i;
 
 	ugeth_vdbg("%s: IN", __func__);
 
@@ -3279,27 +3284,14 @@ static irqreturn_t ucc_geth_irq_handler(int irq, void *info)
 	out_be32(uccf->p_ucce, ucce);
 
 	/* check for receive events that require processing */
-	if (ucce & UCCE_RX_EVENTS) {
+	if (ucce & (UCCE_RX_EVENTS | UCCE_TX_EVENTS)) {
 		if (netif_rx_schedule_prep(&ugeth->napi)) {
-			uccm &= ~UCCE_RX_EVENTS;
+			uccm &= ~(UCCE_RX_EVENTS | UCCE_TX_EVENTS);
 			out_be32(uccf->p_uccm, uccm);
 			__netif_rx_schedule(&ugeth->napi);
 		}
 	}
 
-	/* Tx event processing */
-	if (ucce & UCCE_TX_EVENTS) {
-		spin_lock(&ugeth->lock);
-		tx_mask = UCC_GETH_UCCE_TXB0;
-		for (i = 0; i < ug_info->numQueuesTx; i++) {
-			if (ucce & tx_mask)
-				ucc_geth_tx(dev, i);
-			ucce &= ~tx_mask;
-			tx_mask <<= 1;
-		}
-		spin_unlock(&ugeth->lock);
-	}
-
 	/* Errors and other events */
 	if (ucce & UCCE_OTHER) {
 		if (ucce & UCC_GETH_UCCE_BSY)
diff --git a/drivers/net/ucc_geth.h b/drivers/net/ucc_geth.h
index 44218b8..ea30aa7 100644
--- a/drivers/net/ucc_geth.h
+++ b/drivers/net/ucc_geth.h
@@ -843,7 +843,7 @@ struct ucc_geth_hardware_statistics {
 /* Driver definitions */
 #define TX_BD_RING_LEN                          0x10
 #define RX_BD_RING_LEN                          0x10
-#define UCC_GETH_DEV_WEIGHT                     TX_BD_RING_LEN
+#define UCC_GETH_DEV_WEIGHT                     (RX_BD_RING_LEN+TX_BD_RING_LEN/2)
 
 #define TX_RING_MOD_MASK(size)                  (size-1)
 #define RX_RING_MOD_MASK(size)                  (size-1)
-- 
1.6.1.3
