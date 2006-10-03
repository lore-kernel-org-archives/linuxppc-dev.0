Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4454167C57
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 06:57:35 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k93KvV7M027374
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Oct 2006 16:57:31 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k93KvUt4337808
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Oct 2006 14:57:30 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k93KvUWV017412
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Oct 2006 14:57:30 -0600
Date: Tue, 3 Oct 2006 15:57:29 -0500
To: akpm@osdl.org, jeff@garzik.org
Subject: [PATCH 1/4]: Spidernet stop queue when queue is full
Message-ID: <20061003205729.GF4381@austin.ibm.com>
References: <20061003205240.GE4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061003205240.GE4381@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Subject: [PATCH 1/4]: Spidernet stop queue when queue is full.

This patch adds a call to netif_stop_queue() when there is
no more room for more packets on the transmit queue.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-02 12:12:56.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-02 18:59:43.000000000 -0500
@@ -686,6 +686,7 @@ spider_net_prepare_tx_descr(struct spide
 	/* Chain the bus address, so that the DMA engine finds this descr. */
 	descr->prev->next_descr_addr = descr->bus_addr;
 
+	card->netdev->trans_start = jiffies;
 	return 0;
 }
 
@@ -857,29 +858,23 @@ spider_net_xmit(struct sk_buff *skb, str
 
 	spider_net_release_tx_chain(card, 0);
 
-	if (chain->head->next == chain->tail->prev) {
-		card->netdev_stats.tx_dropped++;
-		result = NETDEV_TX_LOCKED;
-		goto out;
-	}
-
-	if (spider_net_get_descr_status(descr) != SPIDER_NET_DESCR_NOT_IN_USE) {
-		card->netdev_stats.tx_dropped++;
+	if ((chain->head->next == chain->tail->prev) ||
+	   (spider_net_get_descr_status(descr) != SPIDER_NET_DESCR_NOT_IN_USE)) {
 		result = NETDEV_TX_LOCKED;
 		goto out;
 	}
 
 	if (spider_net_prepare_tx_descr(card, skb) != 0) {
-		card->netdev_stats.tx_dropped++;
 		result = NETDEV_TX_BUSY;
 		goto out;
 	}
 
-	result = NETDEV_TX_OK;
 	spider_net_kick_tx_dma(card);
+	return NETDEV_TX_OK;
 
 out:
-	netif_wake_queue(netdev);
+	card->netdev_stats.tx_dropped++;
+	netif_stop_queue(netdev);
 	return result;
 }
 
@@ -898,6 +893,8 @@ spider_net_cleanup_tx_ring(struct spider
 	if ((spider_net_release_tx_chain(card, 0) != 0) &&
 	    (card->netdev->flags & IFF_UP))
 		spider_net_kick_tx_dma(card);
+
+	netif_wake_queue(card->netdev);
 }
 
 /**
