Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BA93267C78
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 07:03:08 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k93L357R017306
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Oct 2006 17:03:05 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k93L35uB058258
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Oct 2006 17:03:05 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k93L3438029878
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Oct 2006 17:03:05 -0400
Date: Tue, 3 Oct 2006 16:03:04 -0500
To: akpm@osdl.org, jeff@garzik.org
Subject: [PATCH 3/4]: Spidernet transmit interupt mitigation
Message-ID: <20061003210304.GH4381@austin.ibm.com>
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



For small packets, the transmit interrupt settings were 
accidentally generating too many interrupts. This patch
turns off all transmit-related interrupts when the tx
queue is mostly empty.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |    8 +++++---
 drivers/net/spider_net.h |    7 +++----
 2 files changed, 8 insertions(+), 7 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-02 19:06:55.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-02 19:09:38.000000000 -0500
@@ -707,7 +707,9 @@ spider_net_set_low_watermark(struct spid
 		descr = descr->next;
 		cnt++;
 	}
-	if (cnt == 0)
+
+	/* If TX queue is short, don't even bother with interrupts */
+	if (cnt < tx_descriptors/4)
 		return;
 
 	/* Set low-watermark 3/4th's of the way into the queue. */
@@ -716,7 +718,7 @@ spider_net_set_low_watermark(struct spid
 	for (i=0;i<cnt; i++)
 		descr = descr->next;
 
-	/* Set the new watermark, clear the old wtermark */
+	/* Set the new watermark, clear the old watermark */
 	spin_lock_irqsave(&card->tx_chain.lock, flags);
 	descr->dmac_cmd_status |= SPIDER_NET_DESCR_TXDESFLG;
 	if (card->low_watermark && card->low_watermark != descr)
@@ -1639,7 +1641,7 @@ spider_net_enable_card(struct spider_net
 			     SPIDER_NET_INT2_MASK_VALUE);
 
 	spider_net_write_reg(card, SPIDER_NET_GDTDMACCNTR,
-			     SPIDER_NET_GDTBSTA);
+			     SPIDER_NET_GDTBSTA | SPIDER_NET_GDTDCEIDIS);
 }
 
 /**
Index: linux-2.6.18-mm2/drivers/net/spider_net.h
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.h	2006-10-02 19:06:55.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.h	2006-10-02 19:09:38.000000000 -0500
@@ -217,7 +217,8 @@ extern char spider_net_driver_name[];
 #define SPIDER_NET_GDTBSTA             0x00000300
 #define SPIDER_NET_GDTDCEIDIS          0x00000002
 #define SPIDER_NET_DMA_TX_VALUE        SPIDER_NET_TX_DMA_EN | \
-                                       SPIDER_NET_GDTBSTA
+                                       SPIDER_NET_GDTBSTA   | \
+                                       SPIDER_NET_GDTDCEIDIS
 #define SPIDER_NET_DMA_TX_FEND_VALUE	0x00030003
 
 /* SPIDER_NET_UA_DESCR_VALUE is OR'ed with the unicast address */
@@ -326,9 +327,7 @@ enum spider_net_int2_status {
 	SPIDER_NET_GRISPDNGINT
 };
 
-#define SPIDER_NET_TXINT	( (1 << SPIDER_NET_GTTEDINT) | \
-				  (1 << SPIDER_NET_GDTDCEINT) | \
-				  (1 << SPIDER_NET_GDTFDCINT) )
+#define SPIDER_NET_TXINT	( (1 << SPIDER_NET_GDTFDCINT) )
 
 /* we rely on flagged descriptor interrupts*/
 #define SPIDER_NET_RXINT	( (1 << SPIDER_NET_GDAFDCINT) | \
