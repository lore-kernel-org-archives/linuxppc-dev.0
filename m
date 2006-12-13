Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8072067D60
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 08:10:15 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBDLABFQ029678
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 16:10:11 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBDLA8Fa136258
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 16:10:08 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBDLA7XH001025
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 16:10:08 -0500
Date: Wed, 13 Dec 2006 15:10:06 -0600
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/14] Spidernet remove rxramfull tasklet
Message-ID: <20061213211006.GC1915@austin.ibm.com>
References: <20061213210010.GR4329@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061213210010.GR4329@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	Jens Osterkamp <Jens.Osterkamp@gmx.de>, jgarzik@pobox.com,
	James K Lewis <jim@jklewis.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Get rid of the rxramfull tasklet, and let the NAPI poll routine
deal with this situation. (The rxramfull interrupt is simply 
stating that the h/w has run out of room for incoming packets).

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   24 +-----------------------
 drivers/net/spider_net.h |    1 -
 2 files changed, 1 insertion(+), 24 deletions(-)

Index: linux-2.6.19-git7/drivers/net/spider_net.c
===================================================================
--- linux-2.6.19-git7.orig/drivers/net/spider_net.c	2006-12-13 14:24:04.000000000 -0600
+++ linux-2.6.19-git7/drivers/net/spider_net.c	2006-12-13 14:24:07.000000000 -0600
@@ -1221,24 +1221,6 @@ spider_net_set_mac(struct net_device *ne
 }
 
 /**
- * spider_net_handle_rxram_full - cleans up RX ring upon RX RAM full interrupt
- * @card: card structure
- *
- * spider_net_handle_rxram_full empties the RX ring so that spider can put
- * more packets in it and empty its RX RAM. This is called in bottom half
- * context
- */
-static void
-spider_net_handle_rxram_full(struct spider_net_card *card)
-{
-	while (spider_net_decode_one_descr(card, 0))
-		;
-	spider_net_enable_rxchtails(card);
-	spider_net_enable_rxdmac(card);
-	netif_rx_schedule(card->netdev);
-}
-
-/**
  * spider_net_handle_error_irq - handles errors raised by an interrupt
  * @card: card structure
  * @status_reg: interrupt status register 0 (GHIINT0STS)
@@ -1363,7 +1345,7 @@ spider_net_handle_error_irq(struct spide
 			pr_err("Spider RX RAM full, incoming packets "
 			       "might be discarded!\n");
 		spider_net_rx_irq_off(card);
-		tasklet_schedule(&card->rxram_full_tl);
+		netif_rx_schedule(card->netdev);
 		show_error = 0;
 		break;
 
@@ -1895,7 +1877,6 @@ spider_net_stop(struct net_device *netde
 {
 	struct spider_net_card *card = netdev_priv(netdev);
 
-	tasklet_kill(&card->rxram_full_tl);
 	netif_poll_disable(netdev);
 	netif_carrier_off(netdev);
 	netif_stop_queue(netdev);
@@ -2037,9 +2018,6 @@ spider_net_setup_netdev(struct spider_ne
 
 	pci_set_drvdata(card->pdev, netdev);
 
-	card->rxram_full_tl.data = (unsigned long) card;
-	card->rxram_full_tl.func =
-		(void (*)(unsigned long)) spider_net_handle_rxram_full;
 	init_timer(&card->tx_timer);
 	card->tx_timer.function =
 		(void (*)(unsigned long)) spider_net_cleanup_tx_ring;
Index: linux-2.6.19-git7/drivers/net/spider_net.h
===================================================================
--- linux-2.6.19-git7.orig/drivers/net/spider_net.h	2006-12-13 14:24:04.000000000 -0600
+++ linux-2.6.19-git7/drivers/net/spider_net.h	2006-12-13 14:24:07.000000000 -0600
@@ -442,7 +442,6 @@ struct spider_net_card {
 	struct spider_net_descr_chain rx_chain;
 	struct spider_net_descr *low_watermark;
 
-	struct tasklet_struct rxram_full_tl;
 	struct timer_list tx_timer;
 	struct work_struct tx_timeout_task;
 	atomic_t tx_timeout_task_counter;
