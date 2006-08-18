Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B9B7267B5F
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 08:23:17 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7IMNCOH019532
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 18:23:12 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7IMNCp1161990
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 16:23:12 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7IMNBqh016849
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 16:23:11 -0600
Date: Fri, 18 Aug 2006 17:23:11 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 3/6]: powerpc/cell spidernet stop error printing patch.
Message-ID: <20060818222311.GJ26889@austin.ibm.com>
References: <20060818220700.GG26889@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060818220700.GG26889@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: akpm@osdl.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, ens Osterkamp <Jens.Osterkamp@de.ibm.com>
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
Cc: Utz Bacher <utz.bacher@de.ibm.com>
Cc: Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

Index: linux-2.6.18-rc3-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/drivers/net/spider_net.c	2006-08-11 11:23:24.000000000 -0500
+++ linux-2.6.18-rc3-mm2/drivers/net/spider_net.c	2006-08-11 11:34:16.000000000 -0500
@@ -1275,12 +1275,15 @@ spider_net_handle_error_irq(struct spide
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
@@ -1339,9 +1342,10 @@ spider_net_handle_error_irq(struct spide
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
@@ -1455,8 +1459,9 @@ spider_net_handle_error_irq(struct spide
 	}
 
 	if ((show_error) && (netif_msg_intr(card)))
-		pr_err("Got error interrupt, GHIINT0STS = 0x%08x, "
+		pr_err("Got error interrupt on %s, GHIINT0STS = 0x%08x, "
 		       "GHIINT1STS = 0x%08x, GHIINT2STS = 0x%08x\n",
+		       card->netdev->name,
 		       status_reg, error_reg1, error_reg2);
 
 	/* clear interrupt sources */
