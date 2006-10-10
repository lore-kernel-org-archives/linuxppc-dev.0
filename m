Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 73E0167CEA
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 07:04:04 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9AL41gV011608
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 17:04:01 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9AL41nk132290
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 17:04:01 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9AL40jh003358
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 17:04:00 -0400
Date: Tue, 10 Oct 2006 16:04:00 -0500
To: akpm@osdl.org
Subject: [PATCH 8/21]: Spidernet stop queue when queue is full.
Message-ID: <20061010210400.GE4381@austin.ibm.com>
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


This patch adds a call to netif_stop_queue() when there is
no more room for more packets on the transmit queue.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 12:51:26.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 12:52:42.000000000 -0500
@@ -823,39 +823,25 @@ spider_net_xmit(struct sk_buff *skb, str
 	struct spider_net_descr_chain *chain = &card->tx_chain;
 	struct spider_net_descr *descr = chain->head;
 	unsigned long flags;
-	int result;
 
 	spin_lock_irqsave(&chain->lock, flags);
 
 	spider_net_release_tx_chain(card, 0);
 
-	if (chain->head->next == chain->tail->prev) {
-		card->netdev_stats.tx_dropped++;
-		result = NETDEV_TX_LOCKED;
-		goto out;
-	}
+	if ((chain->head->next == chain->tail->prev) ||
+	   (spider_net_get_descr_status(descr) != SPIDER_NET_DESCR_NOT_IN_USE) ||
+	   (spider_net_prepare_tx_descr(card, skb) != 0)) {
 
-	if (spider_net_get_descr_status(descr) != SPIDER_NET_DESCR_NOT_IN_USE) {
 		card->netdev_stats.tx_dropped++;
-		result = NETDEV_TX_LOCKED;
-		goto out;
+		spin_unlock_irqrestore(&chain->lock, flags);
+		netif_stop_queue(netdev);
+		return NETDEV_TX_BUSY;
 	}
 
-	if (spider_net_prepare_tx_descr(card, skb) != 0) {
-		card->netdev_stats.tx_dropped++;
-		result = NETDEV_TX_BUSY;
-		goto out;
-	}
-
-	result = NETDEV_TX_OK;
-
 	spider_net_kick_tx_dma(card);
 	card->tx_chain.head = card->tx_chain.head->next;
-
-out:
 	spin_unlock_irqrestore(&chain->lock, flags);
-	netif_wake_queue(netdev);
-	return result;
+	return NETDEV_TX_OK;
 }
 
 /**
@@ -874,9 +860,10 @@ spider_net_cleanup_tx_ring(struct spider
 	spin_lock_irqsave(&card->tx_chain.lock, flags);
 
 	if ((spider_net_release_tx_chain(card, 0) != 0) &&
-	    (card->netdev->flags & IFF_UP))
+	    (card->netdev->flags & IFF_UP)) {
 		spider_net_kick_tx_dma(card);
-
+		netif_wake_queue(card->netdev);
+	}
 	spin_unlock_irqrestore(&card->tx_chain.lock, flags);
 }
 
