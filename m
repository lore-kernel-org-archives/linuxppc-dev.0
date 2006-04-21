Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 691F2679EB
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Apr 2006 09:29:51 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3LNTm4f004400
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 19:29:48 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3LNTmLg236924
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 19:29:48 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3LNTlPV021599
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 19:29:48 -0400
Date: Fri, 21 Apr 2006 18:29:42 -0500
To: utz.bacher@de.ibm.com, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 1/2]: Spider ethernet driver spinlocks
Message-ID: <20060421232942.GG7242@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Maxim Shchetynin <maxim@de.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Please review/apply/ack/forward upstream.

--linas


The spider network driver currently uses hand-rolled spinlocks
in a few places. Replace these with industry standard spinlocks.
In particular, this should add some safety if multiple threads
are touching the tx and rx chain pointers.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/net/spider_net.c |   18 ++++++++----------
 drivers/net/spider_net.h |    4 ++--
 2 files changed, 10 insertions(+), 12 deletions(-)

Index: linux-2.6.17-rc1/drivers/net/spider_net.c
===================================================================
--- linux-2.6.17-rc1.orig/drivers/net/spider_net.c	2006-04-20 17:22:04.000000000 -0500
+++ linux-2.6.17-rc1/drivers/net/spider_net.c	2006-04-21 11:52:39.000000000 -0500
@@ -335,8 +335,6 @@ spider_net_init_chain(struct spider_net_
 	struct spider_net_descr *descr;
 	dma_addr_t buf;
 
-	atomic_set(&card->rx_chain_refill,0);
-
 	descr = start_descr;
 	memset(descr, 0, sizeof(*descr) * no);
 
@@ -509,15 +507,15 @@ spider_net_refill_rx_chain(struct spider
 	 * and omitting it) is ok. If called by NAPI, we'll be called again
 	 * as spider_net_decode_one_descr is called several times. If some
 	 * interrupt calls us, the NAPI is about to clean up anyway. */
-	if (atomic_inc_return(&card->rx_chain_refill) == 1)
+	if (spin_trylock(&card->rx_chain_lock)) {
 		while (spider_net_get_descr_status(chain->head) ==
 		       SPIDER_NET_DESCR_NOT_IN_USE) {
 			if (spider_net_prepare_rx_descr(card, chain->head))
 				break;
 			chain->head = chain->head->next;
 		}
-
-	atomic_dec(&card->rx_chain_refill);
+		spin_unlock(&card->rx_chain_lock);
+	}
 }
 
 /**
@@ -596,10 +594,8 @@ spider_net_release_tx_chain(struct spide
 	struct spider_net_descr_chain *tx_chain = &card->tx_chain;
 	enum spider_net_descr_status status;
 
-	if (atomic_inc_return(&card->tx_chain_release) != 1) {
-		atomic_dec(&card->tx_chain_release);
+	if (!spin_trylock(&card->tx_chain_lock))
 		return 1;
-	}
 
 	for (;;) {
 		status = spider_net_get_descr_status(tx_chain->tail);
@@ -633,7 +629,7 @@ spider_net_release_tx_chain(struct spide
 		tx_chain->tail = tx_chain->tail->next;
 	}
 out:
-	atomic_dec(&card->tx_chain_release);
+	spin_unlock(&card->tx_chain_lock);
 
 	netif_wake_queue(card->netdev);
 
@@ -2072,7 +2068,9 @@ spider_net_setup_netdev(struct spider_ne
 
 	pci_set_drvdata(card->pdev, netdev);
 
-	atomic_set(&card->tx_chain_release,0);
+	spin_lock_init(&card->rx_chain_lock);
+	spin_lock_init(&card->tx_chain_lock);
+
 	card->rxram_full_tl.data = (unsigned long) card;
 	card->rxram_full_tl.func =
 		(void (*)(unsigned long)) spider_net_handle_rxram_full;
Index: linux-2.6.17-rc1/drivers/net/spider_net.h
===================================================================
--- linux-2.6.17-rc1.orig/drivers/net/spider_net.h	2006-04-20 17:22:04.000000000 -0500
+++ linux-2.6.17-rc1/drivers/net/spider_net.h	2006-04-21 11:47:17.000000000 -0500
@@ -451,8 +451,8 @@ struct spider_net_card {
 
 	struct spider_net_descr_chain tx_chain;
 	struct spider_net_descr_chain rx_chain;
-	atomic_t rx_chain_refill;
-	atomic_t tx_chain_release;
+	spinlock_t rx_chain_lock;
+	spinlock_t tx_chain_lock;
 
 	struct net_device_stats netdev_stats;
 
