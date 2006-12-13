Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 901E367EF9
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 08:08:31 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBDL8SvG002110
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 16:08:28 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBDL8Rwp391684
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 14:08:28 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBDL8Qib022205
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 14:08:27 -0700
Date: Wed, 13 Dec 2006 15:08:25 -0600
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/14] Spidernet add net_ratelimit to suppress long output
Message-ID: <20061213210825.GB1915@austin.ibm.com>
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


This patch adds net_ratelimit to many of the printks in order to
limit extraneous warning messages (created in response to Bug 28554).
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
--- linux-2.6.19-git7.orig/drivers/net/spider_net.c	2006-12-13 13:04:04.000000000 -0600
+++ linux-2.6.19-git7/drivers/net/spider_net.c	2006-12-13 13:19:59.000000000 -0600
@@ -1038,11 +1038,10 @@ spider_net_decode_one_descr(struct spide
 
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
 
@@ -1361,7 +1360,7 @@ spider_net_handle_error_irq(struct spide
 	case SPIDER_NET_GRFAFLLINT: /* fallthrough */
 	case SPIDER_NET_GRMFLLINT:
 		if (netif_msg_intr(card) && net_ratelimit())
-			pr_debug("Spider RX RAM full, incoming packets "
+			pr_err("Spider RX RAM full, incoming packets "
 			       "might be discarded!\n");
 		spider_net_rx_irq_off(card);
 		tasklet_schedule(&card->rxram_full_tl);
@@ -1379,7 +1378,7 @@ spider_net_handle_error_irq(struct spide
 	case SPIDER_NET_GDCDCEINT: /* fallthrough */
 	case SPIDER_NET_GDBDCEINT: /* fallthrough */
 	case SPIDER_NET_GDADCEINT:
-		if (netif_msg_intr(card))
+		if (netif_msg_intr(card) && net_ratelimit())
 			pr_err("got descriptor chain end interrupt, "
 			       "restarting DMAC %c.\n",
 			       'D'-(i-SPIDER_NET_GDDDCEINT)/3);
@@ -1450,7 +1449,7 @@ spider_net_handle_error_irq(struct spide
 			break;
 	}
 
-	if ((show_error) && (netif_msg_intr(card)))
+	if ((show_error) && (netif_msg_intr(card)) && net_ratelimit())
 		pr_err("Got error interrupt on %s, GHIINT0STS = 0x%08x, "
 		       "GHIINT1STS = 0x%08x, GHIINT2STS = 0x%08x\n",
 		       card->netdev->name,
Index: linux-2.6.19-git7/drivers/net/spider_net.h
===================================================================
--- linux-2.6.19-git7.orig/drivers/net/spider_net.h	2006-12-13 12:04:02.000000000 -0600
+++ linux-2.6.19-git7/drivers/net/spider_net.h	2006-12-13 13:19:59.000000000 -0600
@@ -24,7 +24,7 @@
 #ifndef _SPIDER_NET_H
 #define _SPIDER_NET_H
 
-#define VERSION "1.6 A"
+#define VERSION "1.6 B"
 
 #include "sungem_phy.h"
 
