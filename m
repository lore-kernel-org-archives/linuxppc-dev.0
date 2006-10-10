Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 16E2267D00
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 07:18:22 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9ALIJfm015667
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 17:18:19 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9ALIJFh108332
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 17:18:19 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9ALIJHn029251
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 17:18:19 -0400
Date: Tue, 10 Oct 2006 16:18:18 -0500
To: akpm@osdl.org
Subject: [PATCH 17/21]: powerpc/cell spidernet reduce DMA kicking
Message-ID: <20061010211818.GN4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The current code attempts to start the TX dma every time a packet
is queued. This is too conservative, and wastes CPU time. This
patch changes behaviour to call the kick-dma function less often, 
only when the tx queue is at risk of emptying.

This reduces cpu usage, improves performance.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 13:21:41.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 13:28:43.000000000 -0500
@@ -698,7 +698,7 @@ spider_net_prepare_tx_descr(struct spide
 	return 0;
 }
 
-static void
+static int
 spider_net_set_low_watermark(struct spider_net_card *card)
 {
 	unsigned long flags;
@@ -719,7 +719,7 @@ spider_net_set_low_watermark(struct spid
 
 	/* If TX queue is short, don't even bother with interrupts */
 	if (cnt < card->tx_desc/4)
-		return;
+		return cnt;
 
 	/* Set low-watermark 3/4th's of the way into the queue. */
 	descr = card->tx_chain.tail;
@@ -735,6 +735,7 @@ spider_net_set_low_watermark(struct spid
 		     card->low_watermark->dmac_cmd_status & ~SPIDER_NET_DESCR_TXDESFLG;
 	card->low_watermark = descr;
 	spin_unlock_irqrestore(&card->tx_chain.lock, flags);
+	return cnt;
 }
 
 /**
@@ -819,8 +820,12 @@ spider_net_release_tx_chain(struct spide
  * @card: card structure
  * @descr: descriptor address to enable TX processing at
  *
- * spider_net_kick_tx_dma writes the current tx chain head as start address
- * of the tx descriptor chain and enables the transmission DMA engine
+ * This routine will start the transmit DMA running if
+ * it is not already running. This routine ned only be
+ * called when queueing a new packet to an empty tx queue.
+ * Writes the current tx chain head as start address
+ * of the tx descriptor chain and enables the transmission
+ * DMA engine.
  */
 static inline void
 spider_net_kick_tx_dma(struct spider_net_card *card)
@@ -860,6 +865,7 @@ out:
 static int
 spider_net_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
+	int cnt;
 	struct spider_net_card *card = netdev_priv(netdev);
 	struct spider_net_descr_chain *chain = &card->tx_chain;
 
@@ -873,8 +879,9 @@ spider_net_xmit(struct sk_buff *skb, str
 		return NETDEV_TX_BUSY;
 	}
 
-	spider_net_set_low_watermark(card);
-	spider_net_kick_tx_dma(card);
+	cnt = spider_net_set_low_watermark(card);
+	if (cnt < 5)
+		spider_net_kick_tx_dma(card);
 	return NETDEV_TX_OK;
 }
 
