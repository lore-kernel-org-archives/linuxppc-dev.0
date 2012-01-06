Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EA691B6F71
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jan 2012 07:24:55 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: eric.dumazet@gmail.com, therbert@google.com
Subject: [PATCH/RFC] gianfar: Add support for byte queue limits.
Date: Fri,  6 Jan 2012 15:24:26 -0500
Message-Id: <1325881466-26214-1-git-send-email-paul.gortmaker@windriver.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for byte queue limits (BQL), based on the similar
modifications made to intel/igb/igb_main.c from Eric Dumazet
in commit bdbc063129e811264cd6c311d8c2d9b95de01231.

A local variable for tx_queue->qindex was introduced in
gfar_clean_tx_ring, since it is now used often enough to warrant it,
and it cleans up the readability somewhat as well.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[Too late for 3.3, but I figured I might as well get feedback from people
 in the interim.  Passes basic boot test with NFS root on sbc8548 board.]

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index e01cdaa..7d86d38 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -1755,9 +1755,12 @@ static void free_skb_resources(struct gfar_private *priv)
 
 	/* Go through all the buffer descriptors and free their data buffers */
 	for (i = 0; i < priv->num_tx_queues; i++) {
+		struct netdev_queue *txq;
 		tx_queue = priv->tx_queue[i];
+		txq = netdev_get_tx_queue(tx_queue->dev, tx_queue->qindex);
 		if(tx_queue->tx_skbuff)
 			free_skb_tx_queue(tx_queue);
+		netdev_tx_reset_queue(txq);
 	}
 
 	for (i = 0; i < priv->num_rx_queues; i++) {
@@ -2204,6 +2207,8 @@ static int gfar_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		lstatus |= BD_LFLAG(TXBD_CRC | TXBD_READY) | skb_headlen(skb);
 	}
 
+	netdev_tx_sent_queue(txq, skb->len);
+
 	/*
 	 * We can work in parallel with gfar_clean_tx_ring(), except
 	 * when modifying num_txbdfree. Note that we didn't grab the lock
@@ -2447,6 +2452,7 @@ static void gfar_align_skb(struct sk_buff *skb)
 static int gfar_clean_tx_ring(struct gfar_priv_tx_q *tx_queue)
 {
 	struct net_device *dev = tx_queue->dev;
+	struct netdev_queue *txq;
 	struct gfar_private *priv = netdev_priv(dev);
 	struct gfar_priv_rx_q *rx_queue = NULL;
 	struct txbd8 *bdp, *next = NULL;
@@ -2458,10 +2464,13 @@ static int gfar_clean_tx_ring(struct gfar_priv_tx_q *tx_queue)
 	int frags = 0, nr_txbds = 0;
 	int i;
 	int howmany = 0;
+	int tqi = tx_queue->qindex;
+	unsigned int bytes_sent = 0;
 	u32 lstatus;
 	size_t buflen;
 
-	rx_queue = priv->rx_queue[tx_queue->qindex];
+	rx_queue = priv->rx_queue[tqi];
+	txq = netdev_get_tx_queue(dev, tqi);
 	bdp = tx_queue->dirty_tx;
 	skb_dirtytx = tx_queue->skb_dirtytx;
 
@@ -2519,6 +2528,8 @@ static int gfar_clean_tx_ring(struct gfar_priv_tx_q *tx_queue)
 			bdp = next_txbd(bdp, base, tx_ring_size);
 		}
 
+		bytes_sent += skb->len;
+
 		/*
 		 * If there's room in the queue (limit it to rx_buffer_size)
 		 * we add this skb back into the pool, if it's the right size
@@ -2543,13 +2554,15 @@ static int gfar_clean_tx_ring(struct gfar_priv_tx_q *tx_queue)
 	}
 
 	/* If we freed a buffer, we can restart transmission, if necessary */
-	if (__netif_subqueue_stopped(dev, tx_queue->qindex) && tx_queue->num_txbdfree)
-		netif_wake_subqueue(dev, tx_queue->qindex);
+	if (__netif_subqueue_stopped(dev, tqi) && tx_queue->num_txbdfree)
+		netif_wake_subqueue(dev, tqi);
 
 	/* Update dirty indicators */
 	tx_queue->skb_dirtytx = skb_dirtytx;
 	tx_queue->dirty_tx = bdp;
 
+	netdev_tx_completed_queue(txq, howmany, bytes_sent);
+
 	return howmany;
 }
 
-- 
1.7.4.4
