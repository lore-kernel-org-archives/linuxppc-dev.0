Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5B59467B6F
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 09:26:31 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8TNQQ6k026259
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 19:26:26 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8TNQQP3250068
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 19:26:26 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8TNQPnA012383
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 19:26:26 -0400
Date: Fri, 29 Sep 2006 18:26:25 -0500
To: jeff@garzik.org, akpm@osdl.org
Subject: [PATCH 5/6]: powerpc/cell spidernet ethtool -i version number
Message-ID: <20060929232625.GM6433@austin.ibm.com>
References: <20060929230552.GG6433@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060929230552.GG6433@austin.ibm.com>
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


Jim, as the official maintainer, you should explicitly ack this patch.
--linas

This patch moves transmit queue cleanup code out of the 
interrupt context, and into the NAPI polling routine.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----

 drivers/net/spider_net.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-09-29 17:01:39.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-09-29 17:39:06.000000000 -0500
@@ -887,9 +887,10 @@ out:
  * spider_net_cleanup_tx_ring - cleans up the TX ring
  * @card: card structure
  *
- * spider_net_cleanup_tx_ring is called by the tx_timer (as we don't use
- * interrupts to cleanup our TX ring) and returns sent packets to the stack
- * by freeing them
+ * spider_net_cleanup_tx_ring is called by either the tx_timer
+ * or from the NAPI polling routine.
+ * This routine releases resources associted with transmitted
+ * packets, including updating the queue tail pointer.
  */
 static void
 spider_net_cleanup_tx_ring(struct spider_net_card *card)
@@ -1093,6 +1094,7 @@ spider_net_poll(struct net_device *netde
 	int packets_to_do, packets_done = 0;
 	int no_more_packets = 0;
 
+	spider_net_cleanup_tx_ring(card);
 	packets_to_do = min(*budget, netdev->quota);
 
 	while (packets_to_do) {
@@ -1505,10 +1507,8 @@ spider_net_interrupt(int irq, void *ptr,
 		spider_net_rx_irq_off(card);
 		netif_rx_schedule(netdev);
 	}
-	if (status_reg & SPIDER_NET_TXINT ) {
-		spider_net_cleanup_tx_ring(card);
-		netif_wake_queue(netdev);
-	}
+	if (status_reg & SPIDER_NET_TXINT)
+		netif_rx_schedule(netdev);
 
 	if (status_reg & SPIDER_NET_ERRINT )
 		spider_net_handle_error_irq(card, status_reg);
