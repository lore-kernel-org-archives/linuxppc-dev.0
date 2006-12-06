Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7358467C71
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 10:29:57 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB6NTrL2021923
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 18:29:53 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB6NTrLt121582
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 18:29:53 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB6NTrsO015022
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 18:29:53 -0500
Date: Wed, 6 Dec 2006 17:29:52 -0600
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/16] Spidernet add net_ratelimit to suppress long output
Message-ID: <20061206232952.GB4649@austin.ibm.com>
References: <20061206223223.GH17931@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061206223223.GH17931@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linuxppc-dev@ozlabs.org,
	jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch adds net_ratelimit to many of the printks 
in order to limit extraneous warning messages 
This patch supercedes all previous ratelimit patches.
This has been tested, please apply.

From: James K Lewis <jklewis@us.ibm.com>
Signed-off-by: James K Lewis <jklewis@us.ibm.com>
Signed-off-by: Linas Vepstas <jlinas@austin.ibm.com>

----
 drivers/net/spider_net.c |   11 +++++------
 drivers/net/spider_net.h |    2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

Index: linux-2.6.19-git7/drivers/net/spider_net.c
===================================================================
--- linux-2.6.19-git7.orig/drivers/net/spider_net.c	2006-12-06 15:56:20.000000000 -0600
+++ linux-2.6.19-git7/drivers/net/spider_net.c	2006-12-06 15:58:27.000000000 -0600
@@ -1008,11 +1008,10 @@ spider_net_decode_one_descr(struct spide
 
 	if ( (status != SPIDER_NET_DESCR_COMPLETE) &&
 	     (status != SPIDER_NET_DESCR_FRAME_END) ) {
-		if (netif_msg_rx_err(card)) {
+		if (netif_msg_rx_err(card))
 			pr_err("%s: RX descriptor with state %d\n",
 			       card->netdev->name, status);
-			card->spider_stats.rx_desc_unk_state++;
-		}
+		card->spider_stats.rx_desc_unk_state++;
 		goto refill;
 	}
 
@@ -1331,7 +1330,7 @@ spider_net_handle_error_irq(struct spide
 	case SPIDER_NET_GRFAFLLINT: /* fallthrough */
 	case SPIDER_NET_GRMFLLINT:
 		if (netif_msg_intr(card) && net_ratelimit())
-			pr_debug("Spider RX RAM full, incoming packets "
+			pr_err("Spider RX RAM full, incoming packets "
 			       "might be discarded!\n");
 		spider_net_rx_irq_off(card);
 		tasklet_schedule(&card->rxram_full_tl);
@@ -1349,7 +1348,7 @@ spider_net_handle_error_irq(struct spide
 	case SPIDER_NET_GDCDCEINT: /* fallthrough */
 	case SPIDER_NET_GDBDCEINT: /* fallthrough */
 	case SPIDER_NET_GDADCEINT:
-		if (netif_msg_intr(card))
+		if (netif_msg_intr(card) && net_ratelimit())
 			pr_err("got descriptor chain end interrupt, "
 			       "restarting DMAC %c.\n",
 			       'D'-(i-SPIDER_NET_GDDDCEINT)/3);
@@ -1420,7 +1419,7 @@ spider_net_handle_error_irq(struct spide
 			break;
 	}
 
-	if ((show_error) && (netif_msg_intr(card)))
+	if ((show_error) && (netif_msg_intr(card)) && net_ratelimit())
 		pr_err("Got error interrupt on %s, GHIINT0STS = 0x%08x, "
 		       "GHIINT1STS = 0x%08x, GHIINT2STS = 0x%08x\n",
 		       card->netdev->name,
Index: linux-2.6.19-git7/drivers/net/spider_net.h
===================================================================
--- linux-2.6.19-git7.orig/drivers/net/spider_net.h	2006-12-06 15:56:20.000000000 -0600
+++ linux-2.6.19-git7/drivers/net/spider_net.h	2006-12-06 15:57:28.000000000 -0600
@@ -24,7 +24,7 @@
 #ifndef _SPIDER_NET_H
 #define _SPIDER_NET_H
 
-#define VERSION "1.6 A"
+#define VERSION "1.6 B"
 
 #include "sungem_phy.h"
 
