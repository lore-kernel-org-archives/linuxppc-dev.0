Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 31F55DE0EE
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 08:03:51 +1000 (EST)
Date: Sat, 18 Apr 2009 02:03:48 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH] ucc_geth: Move freeing of TX packets to NAPI context
Message-ID: <20090417220348.GA5429@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: netdev@vger.kernel.org, Li Yang <leoli@freescale.com>,
	Andy Fleming <afleming@freescale.com>,
	Joakim Tjernlund <Joakim.Tjernlund@transmode.se>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

This will make the system alot more responsive while ping flooding the
ucc_geth ethernet interface.

Also set NAPI weight to 64 as this is a common value.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/ucc_geth.c |   31 +++++++++++--------------------
 drivers/net/ucc_geth.h |    1 -
 2 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index d3f39e8..98f961e 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -3216,7 +3216,7 @@ static int ucc_geth_tx(struct net_device *dev, u8 txQ)
 		dev->stats.tx_packets++;
 
 		/* Free the sk buffer associated with this TxBD */
-		dev_kfree_skb_irq(ugeth->
+		dev_kfree_skb(ugeth->
 				  tx_skbuff[txQ][ugeth->skb_dirtytx[txQ]]);
 		ugeth->tx_skbuff[txQ][ugeth->skb_dirtytx[txQ]] = NULL;
 		ugeth->skb_dirtytx[txQ] =
@@ -3250,9 +3250,15 @@ static int ucc_geth_poll(struct napi_struct *napi, int budget)
 	for (i = 0; i < ug_info->numQueuesRx; i++)
 		howmany += ucc_geth_rx(ugeth, i, budget - howmany);
 
+	/* Tx event processing */
+	spin_lock(&ugeth->lock);
+	for (i = 0; i < ug_info->numQueuesTx; i++)
+		ucc_geth_tx(ugeth->ndev, i);
+	spin_unlock(&ugeth->lock);
+
 	if (howmany < budget) {
 		napi_complete(napi);
-		setbits32(ugeth->uccf->p_uccm, UCCE_RX_EVENTS);
+		setbits32(ugeth->uccf->p_uccm, UCCE_RX_EVENTS | UCCE_TX_EVENTS);
 	}
 
 	return howmany;
@@ -3266,8 +3272,6 @@ static irqreturn_t ucc_geth_irq_handler(int irq, void *info)
 	struct ucc_geth_info *ug_info;
 	register u32 ucce;
 	register u32 uccm;
-	register u32 tx_mask;
-	u8 i;
 
 	ugeth_vdbg("%s: IN", __func__);
 
@@ -3281,27 +3285,14 @@ static irqreturn_t ucc_geth_irq_handler(int irq, void *info)
 	out_be32(uccf->p_ucce, ucce);
 
 	/* check for receive events that require processing */
-	if (ucce & UCCE_RX_EVENTS) {
+	if (ucce & (UCCE_RX_EVENTS | UCCE_TX_EVENTS)) {
 		if (napi_schedule_prep(&ugeth->napi)) {
-			uccm &= ~UCCE_RX_EVENTS;
+			uccm &= ~(UCCE_RX_EVENTS | UCCE_TX_EVENTS);
 			out_be32(uccf->p_uccm, uccm);
 			__napi_schedule(&ugeth->napi);
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
@@ -3734,7 +3725,7 @@ static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *ma
 	dev->netdev_ops = &ucc_geth_netdev_ops;
 	dev->watchdog_timeo = TX_TIMEOUT;
 	INIT_WORK(&ugeth->timeout_work, ucc_geth_timeout_work);
-	netif_napi_add(dev, &ugeth->napi, ucc_geth_poll, UCC_GETH_DEV_WEIGHT);
+	netif_napi_add(dev, &ugeth->napi, ucc_geth_poll, 64);
 	dev->mtu = 1500;
 
 	ugeth->msg_enable = netif_msg_init(debug.msg_enable, UGETH_MSG_DEFAULT);
diff --git a/drivers/net/ucc_geth.h b/drivers/net/ucc_geth.h
index 2f8ee7c..6027647 100644
--- a/drivers/net/ucc_geth.h
+++ b/drivers/net/ucc_geth.h
@@ -852,7 +852,6 @@ struct ucc_geth_hardware_statistics {
 /* Driver definitions */
 #define TX_BD_RING_LEN                          0x10
 #define RX_BD_RING_LEN                          0x10
-#define UCC_GETH_DEV_WEIGHT                     TX_BD_RING_LEN
 
 #define TX_RING_MOD_MASK(size)                  (size-1)
 #define RX_RING_MOD_MASK(size)                  (size-1)
-- 
1.6.2.2
