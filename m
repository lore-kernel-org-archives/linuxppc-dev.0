Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7C4DF67C6B
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 10:42:42 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB6NgdmM002781
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 18:42:39 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB6Ngdd6538858
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 16:42:39 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB6Ngccp027169
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 16:42:39 -0700
Date: Wed, 6 Dec 2006 17:42:38 -0600
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 11/16] Spidernet RX Chain tail
Message-ID: <20061206234238.GK4649@austin.ibm.com>
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


Tell the hardware the location of the rx ring tail.
More punctuation cleanup.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

Index: linux-2.6.19-git7/drivers/net/spider_net.c
===================================================================
--- linux-2.6.19-git7.orig/drivers/net/spider_net.c	2006-12-06 16:03:11.000000000 -0600
+++ linux-2.6.19-git7/drivers/net/spider_net.c	2006-12-06 16:03:13.000000000 -0600
@@ -457,10 +457,10 @@ spider_net_refill_rx_chain(struct spider
 }
 
 /**
- * spider_net_alloc_rx_skbs - allocates rx skbs in rx descriptor chains
+ * spider_net_alloc_rx_skbs - Allocates rx skbs in rx descriptor chains
  * @card: card structure
  *
- * returns 0 on success, <0 on failure
+ * Returns 0 on success, <0 on failure.
  */
 static int
 spider_net_alloc_rx_skbs(struct spider_net_card *card)
@@ -471,17 +471,18 @@ spider_net_alloc_rx_skbs(struct spider_n
 	result = -ENOMEM;
 
 	chain = &card->rx_chain;
-	/* put at least one buffer into the chain. if this fails,
-	 * we've got a problem. if not, spider_net_refill_rx_chain
-	 * will do the rest at the end of this function */
+	/* Put at least one buffer into the chain. if this fails,
+	 * we've got a problem. If not, spider_net_refill_rx_chain
+	 * will do the rest at the end of this function. */
 	if (spider_net_prepare_rx_descr(card, chain->head))
 		goto error;
 	else
 		chain->head = chain->head->next;
 
-	/* this will allocate the rest of the rx buffers; if not, it's
-	 * business as usual later on */
+	/* This will allocate the rest of the rx buffers;
+	 * if not, it's business as usual later on. */
 	spider_net_refill_rx_chain(card);
+	spider_net_enable_rxchtails(card);
 	spider_net_enable_rxdmac(card);
 	return 0;
 
