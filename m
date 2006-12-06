Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A264067D14
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 10:31:41 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB6NVcJr017979
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 18:31:38 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB6NVcMW544206
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 16:31:38 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB6NVbq3015471
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 16:31:38 -0700
Date: Wed, 6 Dec 2006 17:31:34 -0600
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/16] Spidernet RX Locking
Message-ID: <20061206233134.GC4649@austin.ibm.com>
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


The RX packet handling can be called from several
places, yet does not protect the rx ring structure.
This patch places the ring buffer pointers under a lock.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

Index: linux-2.6.19-git7/drivers/net/spider_net.c
===================================================================
--- linux-2.6.19-git7.orig/drivers/net/spider_net.c	2006-12-06 15:58:27.000000000 -0600
+++ linux-2.6.19-git7/drivers/net/spider_net.c	2006-12-06 16:01:49.000000000 -0600
@@ -969,28 +969,33 @@ static int
 spider_net_decode_one_descr(struct spider_net_card *card, int napi)
 {
 	struct spider_net_descr_chain *chain = &card->rx_chain;
-	struct spider_net_descr *descr = chain->tail;
+	struct spider_net_descr *descr;
 	int status;
 	int result;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chain->lock, flags);
+	descr = chain->tail;
 
 	status = spider_net_get_descr_status(descr);
 
 	if (status == SPIDER_NET_DESCR_CARDOWNED) {
 		/* nothing in the descriptor yet */
-		result=0;
-		goto out;
+		spin_unlock_irqrestore(&chain->lock, flags);
+		return 0;
 	}
 
 	if (status == SPIDER_NET_DESCR_NOT_IN_USE) {
 		/* not initialized yet, the ring must be empty */
+		spin_unlock_irqrestore(&chain->lock, flags);
 		spider_net_refill_rx_chain(card);
 		spider_net_enable_rxdmac(card);
-		result=0;
-		goto out;
+		return 0;
 	}
 
 	/* descriptor definitively used -- move on tail */
 	chain->tail = descr->next;
+	spin_unlock_irqrestore(&chain->lock, flags);
 
 	result = 0;
 	if ( (status == SPIDER_NET_DESCR_RESPONSE_ERROR) ||
@@ -1022,7 +1027,6 @@ refill:
 	/* change the descriptor state: */
 	if (!napi)
 		spider_net_refill_rx_chain(card);
-out:
 	return result;
 }
 
