Return-Path: <linas@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 260BE67DC7
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 07:07:00 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9AL6sap029116
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 17:06:54 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9AL6spq056288
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 17:06:54 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9AL6rGx015319
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 17:06:54 -0400
Date: Tue, 10 Oct 2006 16:06:53 -0500
To: akpm@osdl.org
Subject: [PATCH 10/21]: powerpc/cell spidernet  fix error interrupt print
Message-ID: <20061010210653.GG4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



The print message associated with the descriptor chain end interrupt
prints a bogs value. Fix that.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 12:52:42.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 12:58:08.000000000 -0500
@@ -1356,7 +1356,7 @@ spider_net_handle_error_irq(struct spide
 		if (netif_msg_intr(card))
 			pr_err("got descriptor chain end interrupt, "
 			       "restarting DMAC %c.\n",
-			       'D'+i-SPIDER_NET_GDDDCEINT);
+			       'D'-(i-SPIDER_NET_GDDDCEINT)/3);
 		spider_net_refill_rx_chain(card);
 		spider_net_enable_rxdmac(card);
 		show_error = 0;
