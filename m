Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id B0FD0DE168
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 01:08:21 +1000 (EST)
Date: Wed, 22 Aug 2007 09:13:11 -0500
From: Olof Johansson <olof@lixom.net>
To: jgarzik@pobox.com
Subject: [PATCH] [08/10] pasemi_mac: Fix TX ring wrap checking
Message-ID: <20070822141311.GI16830@lixom.net>
References: <20070817205413.548020000@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The old logic didn't detect full (tx) ring cases properly, causing
overruns and general badness. Clean it up a bit and abstract out the
ring size checks, always making sure to leave 1 slot open.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: mainline/drivers/net/pasemi_mac.c
===================================================================
--- mainline.orig/drivers/net/pasemi_mac.c
+++ mainline/drivers/net/pasemi_mac.c
@@ -69,6 +69,10 @@
 #define RX_DESC_INFO(mac, num)	((mac)->rx->desc_info[(num) & (RX_RING_SIZE-1)])
 #define RX_BUFF(mac, num)	((mac)->rx->buffers[(num) & (RX_RING_SIZE-1)])
 
+#define RING_USED(ring)		(((ring)->next_to_fill - (ring)->next_to_clean) \
+				 & ((ring)->size - 1))
+#define RING_AVAIL(ring)	((ring->size) - RING_USED(ring))
+
 #define BUF_SIZE 1646 /* 1500 MTU + ETH_HLEN + VLAN_HLEN + 2 64B cachelines */
 
 MODULE_LICENSE("GPL");
@@ -184,6 +188,7 @@ static int pasemi_mac_setup_rx_resources
 
 	spin_lock_init(&ring->lock);
 
+	ring->size = RX_RING_SIZE;
 	ring->desc_info = kzalloc(sizeof(struct pasemi_mac_buffer) *
 				  RX_RING_SIZE, GFP_KERNEL);
 
@@ -263,6 +268,7 @@ static int pasemi_mac_setup_tx_resources
 
 	spin_lock_init(&ring->lock);
 
+	ring->size = TX_RING_SIZE;
 	ring->desc_info = kzalloc(sizeof(struct pasemi_mac_buffer) *
 				  TX_RING_SIZE, GFP_KERNEL);
 	if (!ring->desc_info)
@@ -291,7 +297,7 @@ static int pasemi_mac_setup_tx_resources
 			   PAS_DMA_TXCHAN_CFG_UP |
 			   PAS_DMA_TXCHAN_CFG_WT(2));
 
-	ring->next_to_use = 0;
+	ring->next_to_fill = 0;
 	ring->next_to_clean = 0;
 
 	snprintf(ring->irq_name, sizeof(ring->irq_name),
@@ -386,9 +392,7 @@ static void pasemi_mac_replenish_rx_ring
 	int start = mac->rx->next_to_fill;
 	unsigned int limit, count;
 
-	limit = (mac->rx->next_to_clean + RX_RING_SIZE -
-		 mac->rx->next_to_fill) & (RX_RING_SIZE - 1);
-
+	limit = RING_AVAIL(mac->rx);
 	/* Check to see if we're doing first-time setup */
 	if (unlikely(mac->rx->next_to_clean == 0 && mac->rx->next_to_fill == 0))
 		limit = RX_RING_SIZE;
@@ -572,7 +576,7 @@ restart:
 	spin_lock_irqsave(&mac->tx->lock, flags);
 
 	start = mac->tx->next_to_clean;
-	limit = min(mac->tx->next_to_use, start+32);
+	limit = min(mac->tx->next_to_fill, start+32);
 
 	count = 0;
 
@@ -1013,14 +1017,13 @@ static int pasemi_mac_start_tx(struct sk
 
 	spin_lock_irqsave(&txring->lock, flags);
 
-	if (txring->next_to_clean - txring->next_to_use == TX_RING_SIZE) {
+	if (RING_AVAIL(txring) <= 1) {
 		spin_unlock_irqrestore(&txring->lock, flags);
 		pasemi_mac_clean_tx(mac);
 		pasemi_mac_restart_tx_intr(mac);
 		spin_lock_irqsave(&txring->lock, flags);
 
-		if (txring->next_to_clean - txring->next_to_use ==
-		    TX_RING_SIZE) {
+		if (RING_AVAIL(txring) <= 1) {
 			/* Still no room -- stop the queue and wait for tx
 			 * intr when there's room.
 			 */
@@ -1029,15 +1032,15 @@ static int pasemi_mac_start_tx(struct sk
 		}
 	}
 
-	dp = &TX_DESC(mac, txring->next_to_use);
-	info = &TX_DESC_INFO(mac, txring->next_to_use);
+	dp = &TX_DESC(mac, txring->next_to_fill);
+	info = &TX_DESC_INFO(mac, txring->next_to_fill);
 
 	dp->mactx = mactx;
 	dp->ptr   = ptr;
 	info->dma = map;
 	info->skb = skb;
 
-	txring->next_to_use++;
+	txring->next_to_fill++;
 	mac->stats.tx_packets++;
 	mac->stats.tx_bytes += skb->len;
 
Index: mainline/drivers/net/pasemi_mac.h
===================================================================
--- mainline.orig/drivers/net/pasemi_mac.h
+++ mainline/drivers/net/pasemi_mac.h
@@ -31,7 +31,7 @@ struct pasemi_mac_txring {
 	struct pas_dma_xct_descr	*desc;
 	dma_addr_t	 dma;
 	unsigned int	 size;
-	unsigned int	 next_to_use;
+	unsigned int	 next_to_fill;
 	unsigned int	 next_to_clean;
 	struct pasemi_mac_buffer *desc_info;
 	char		 irq_name[10];  /* "eth%d tx" */

--
