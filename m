Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 761CF67BCB
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 09:19:27 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8TNJNDa013426
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 19:19:24 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8TNJNck049850
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 19:19:23 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8TNJNnT019543
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 19:19:23 -0400
Date: Fri, 29 Sep 2006 18:19:22 -0500
To: jeff@garzik.org, akpm@osdl.org
Subject: [PATCH 3/6]: powerpc/cell spidernet stop error printing patch.
Message-ID: <20060929231922.GK6433@austin.ibm.com>
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


Turn off mis-interpretation of the queue-empty interrupt
status bit as an error. This bit is set as a part of 
the previous low-watermark patch.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Signed-off-by: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-09-29 15:01:55.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-09-29 16:33:43.000000000 -0500
@@ -1282,12 +1282,15 @@ spider_net_handle_error_irq(struct spide
 	case SPIDER_NET_PHYINT:
 	case SPIDER_NET_GMAC2INT:
 	case SPIDER_NET_GMAC1INT:
-	case SPIDER_NET_GIPSINT:
 	case SPIDER_NET_GFIFOINT:
 	case SPIDER_NET_DMACINT:
 	case SPIDER_NET_GSYSINT:
 		break; */
 
+	case SPIDER_NET_GIPSINT:
+		show_error = 0;
+		break;
+
 	case SPIDER_NET_GPWOPCMPINT:
 		/* PHY write operation completed */
 		show_error = 0;
@@ -1346,9 +1349,10 @@ spider_net_handle_error_irq(struct spide
 	case SPIDER_NET_GDTDCEINT:
 		/* chain end. If a descriptor should be sent, kick off
 		 * tx dma
-		if (card->tx_chain.tail == card->tx_chain.head)
+		if (card->tx_chain.tail != card->tx_chain.head)
 			spider_net_kick_tx_dma(card);
-		show_error = 0; */
+		*/
+		show_error = 0;
 		break;
 
 	/* case SPIDER_NET_G1TMCNTINT: not used. print a message */
@@ -1462,8 +1466,9 @@ spider_net_handle_error_irq(struct spide
 	}
 
 	if ((show_error) && (netif_msg_intr(card)))
-		pr_err("Got error interrupt, GHIINT0STS = 0x%08x, "
+		pr_err("Got error interrupt on %s, GHIINT0STS = 0x%08x, "
 		       "GHIINT1STS = 0x%08x, GHIINT2STS = 0x%08x\n",
+		       card->netdev->name,
 		       status_reg, error_reg1, error_reg2);
 
 	/* clear interrupt sources */
