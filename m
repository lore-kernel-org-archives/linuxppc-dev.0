Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F26D867BFF
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Nov 2006 09:30:37 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAHMUXgP010146
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 17:30:33 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAHMUQMY078170
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 17:30:31 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAHMUQMC024050
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 17:30:26 -0500
Date: Fri, 17 Nov 2006 16:30:22 -0600
To: akpm@osdl.org
Subject: [PATCH]: spidernet poor network performance
Message-ID: <20061117223022.GO23600@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Andrew, 

Please apply.

--linas


This patch corrects a problem seen on later kernels running 
the NetPIPE application.  Specifically, NetPIPE would begin 
running very slowly at the 1533 packet size. It was
determined that Spidernet slowed with an idle DMA 
engine.

Signed-off-by: James K Lewis <jklewis@us.ibm.com>
Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/net/spider_net.c |    2 +-
 drivers/net/spider_net.h |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6.19-rc4-git3/drivers/net/spider_net.c
===================================================================
--- linux-2.6.19-rc4-git3.orig/drivers/net/spider_net.c	2006-11-01 19:14:34.000000000 -0600
+++ linux-2.6.19-rc4-git3/drivers/net/spider_net.c	2006-11-17 13:33:44.000000000 -0600
@@ -1606,7 +1606,7 @@ spider_net_enable_card(struct spider_net
 			     SPIDER_NET_INT2_MASK_VALUE);
 
 	spider_net_write_reg(card, SPIDER_NET_GDTDMACCNTR,
-			     SPIDER_NET_GDTBSTA | SPIDER_NET_GDTDCEIDIS);
+			     SPIDER_NET_GDTBSTA);
 }
 
 /**
Index: linux-2.6.19-rc4-git3/drivers/net/spider_net.h
===================================================================
--- linux-2.6.19-rc4-git3.orig/drivers/net/spider_net.h	2006-11-01 19:14:34.000000000 -0600
+++ linux-2.6.19-rc4-git3/drivers/net/spider_net.h	2006-11-17 16:19:30.000000000 -0600
@@ -24,7 +24,7 @@
 #ifndef _SPIDER_NET_H
 #define _SPIDER_NET_H
 
-#define VERSION "1.1 A"
+#define VERSION "1.6 A"
 
 #include "sungem_phy.h"
 
@@ -217,8 +217,7 @@ extern char spider_net_driver_name[];
 #define SPIDER_NET_GDTBSTA             0x00000300
 #define SPIDER_NET_GDTDCEIDIS          0x00000002
 #define SPIDER_NET_DMA_TX_VALUE        SPIDER_NET_TX_DMA_EN | \
-                                       SPIDER_NET_GDTBSTA | \
-                                       SPIDER_NET_GDTDCEIDIS
+                                       SPIDER_NET_GDTBSTA
 
 #define SPIDER_NET_DMA_TX_FEND_VALUE	0x00030003
 
@@ -328,7 +327,8 @@ enum spider_net_int2_status {
 	SPIDER_NET_GRISPDNGINT
 };
 
-#define SPIDER_NET_TXINT	( (1 << SPIDER_NET_GDTFDCINT) )
+#define SPIDER_NET_TXINT	( (1 << SPIDER_NET_GDTFDCINT) | \
+                             (1 << SPIDER_NET_GDTDCEINT) )
 
 /* We rely on flagged descriptor interrupts */
 #define SPIDER_NET_RXINT	( (1 << SPIDER_NET_GDAFDCINT) )
