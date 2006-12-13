Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 96DBD67E86
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 08:18:56 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBDLIrYq029234
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 16:18:53 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBDLIriN485928
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 14:18:53 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBDLIqdQ015876
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 14:18:53 -0700
Date: Wed, 13 Dec 2006 15:18:52 -0600
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 8/14] Spidernet RX Refill
Message-ID: <20061213211852.GH1915@austin.ibm.com>
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


The invocation of the rx ring refill routine is haphazard,
it can be called from a central location.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

Index: linux-2.6.19-git7/drivers/net/spider_net.c
===================================================================
--- linux-2.6.19-git7.orig/drivers/net/spider_net.c	2006-12-13 14:27:35.000000000 -0600
+++ linux-2.6.19-git7/drivers/net/spider_net.c	2006-12-13 14:28:11.000000000 -0600
@@ -980,17 +980,11 @@ spider_net_decode_one_descr(struct spide
 
 	status = spider_net_get_descr_status(descr);
 
-	/* nothing in the descriptor yet */
-	if (status == SPIDER_NET_DESCR_CARDOWNED)
+	/* Nothing in the descriptor, or ring must be empty */
+	if ((status == SPIDER_NET_DESCR_CARDOWNED) ||
+	    (status == SPIDER_NET_DESCR_NOT_IN_USE))
 		return 0;
 
-	if (status == SPIDER_NET_DESCR_NOT_IN_USE) {
-		/* not initialized yet, the ring must be empty */
-		spider_net_refill_rx_chain(card);
-		spider_net_enable_rxdmac(card);
-		return 0;
-	}
-
 	/* descriptor definitively used -- move on tail */
 	chain->tail = descr->next;
 
@@ -1074,6 +1068,7 @@ spider_net_poll(struct net_device *netde
 	netdev->quota -= packets_done;
 	*budget -= packets_done;
 	spider_net_refill_rx_chain(card);
+	spider_net_enable_rxdmac(card);
 
 	/* if all packets are in the stack, enable interrupts and return 0 */
 	/* if not, return 1 */
