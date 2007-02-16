Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ED225DDEFF
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 11:57:15 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l1G0uaPw007530
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 19:56:36 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1G0vCOD543308
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 17:57:12 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1G0vCgs023734
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 17:57:12 -0700
Date: Thu, 15 Feb 2007 18:57:11 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 11/12] spidernet: janitorial, typos
Message-ID: <20070216005711.GK8192@austin.ibm.com>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	<45D3EAA7.80805@garzik.org>
	<1171525923.20192.243.camel@localhost.localdomain>
	<200702151141.49708.jens@de.ibm.com>
	<20070215171414.GU923@austin.ibm.com>
	<1171572392.5644.15.camel@localhost.localdomain>
	<20070216001857.GC923@austin.ibm.com>
	<20070216004325.GA8192@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070216004325.GA8192@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Janitorial patch. Undo long lines, fix typo in err msg.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
Cc: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>

----
 drivers/net/spider_net.c |   13 +++++++------
 drivers/net/spider_net.h |    2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

Index: linux-2.6.20-git4/drivers/net/spider_net.c
===================================================================
--- linux-2.6.20-git4.orig/drivers/net/spider_net.c	2007-02-15 18:00:49.000000000 -0600
+++ linux-2.6.20-git4/drivers/net/spider_net.c	2007-02-15 18:01:14.000000000 -0600
@@ -1053,14 +1053,15 @@ static void show_rx_chain(struct spider_
 #endif
 
 /**
- * spider_net_decode_one_descr - processes an rx descriptor
+ * spider_net_decode_one_descr - processes an RX descriptor
  * @card: card structure
  *
- * Returns 1 if a packet has been sent to the stack, otherwise 0
+ * Returns 1 if a packet has been sent to the stack, otherwise 0.
  *
- * Processes an rx descriptor by iommu-unmapping the data buffer and passing
- * the packet up to the stack. This function is called in softirq
- * context, e.g. either bottom half from interrupt or NAPI polling context
+ * Processes an RX descriptor by iommu-unmapping the data buffer
+ * and passing the packet up to the stack. This function is called
+ * in softirq context, e.g. either bottom half from interrupt or
+ * NAPI polling context.
  */
 static int
 spider_net_decode_one_descr(struct spider_net_card *card)
@@ -1097,7 +1098,7 @@ spider_net_decode_one_descr(struct spide
 	if ( (status != SPIDER_NET_DESCR_COMPLETE) &&
 	     (status != SPIDER_NET_DESCR_FRAME_END) ) {
 		if (netif_msg_rx_err(card))
-			pr_err("%s: RX descriptor with unkown state %d\n",
+			pr_err("%s: RX descriptor with unknown state %d\n",
 			       card->netdev->name, status);
 		card->spider_stats.rx_desc_unk_state++;
 		goto bad_desc;
Index: linux-2.6.20-git4/drivers/net/spider_net.h
===================================================================
--- linux-2.6.20-git4.orig/drivers/net/spider_net.h	2007-02-15 18:00:49.000000000 -0600
+++ linux-2.6.20-git4/drivers/net/spider_net.h	2007-02-15 18:01:14.000000000 -0600
@@ -25,7 +25,7 @@
 #ifndef _SPIDER_NET_H
 #define _SPIDER_NET_H
 
-#define VERSION "1.6 C"
+#define VERSION "2.0 A"
 
 #include "sungem_phy.h"
 
