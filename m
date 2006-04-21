Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 75436679F3
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Apr 2006 09:46:00 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3LNjqIB027710
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 19:45:52 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3LNnHla187276
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 17:49:17 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3LNjpSj020535
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 17:45:52 -0600
Date: Fri, 21 Apr 2006 18:45:51 -0500
To: utz.bacher@de.ibm.com, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 2/2]: Spider ethernet driver -- protect chain head
Message-ID: <20060421234551.GI7242@austin.ibm.com>
References: <20060421232942.GG7242@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060421232942.GG7242@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Maxim Shchetynin <maxim@de.ibm.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Please review/apply/ack/forward upstream.

--linas


Prevent a potential race. If two threads are both calling
the transmit routine, both can potentially try to grab the
same dma descriptor. Serialize access to the head of the
tx ring with spinlocks.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/net/spider_net.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

Index: linux-2.6.17-rc1/drivers/net/spider_net.c
===================================================================
--- linux-2.6.17-rc1.orig/drivers/net/spider_net.c	2006-04-21 18:32:46.000000000 -0500
+++ linux-2.6.17-rc1/drivers/net/spider_net.c	2006-04-21 18:39:12.000000000 -0500
@@ -806,13 +806,19 @@ spider_net_stop(struct net_device *netde
 static struct spider_net_descr *
 spider_net_get_next_tx_descr(struct spider_net_card *card)
 {
+	struct spider_net_descr *descr;
+	spin_lock(&card->tx_chain_lock);
+
+	descr = card->tx_chain.head;
 	/* check, if head points to not-in-use descr */
 	if ( spider_net_get_descr_status(card->tx_chain.head) ==
 	     SPIDER_NET_DESCR_NOT_IN_USE ) {
-		return card->tx_chain.head;
+		card->tx_chain.head = descr->next;
 	} else {
-		return NULL;
+		descr = NULL;
 	}
+	spin_unlock(&card->tx_chain_lock);
+	return descr;
 }
 
 /**
@@ -932,8 +938,6 @@ spider_net_xmit(struct sk_buff *skb, str
 	if (result)
 		goto error;
 
-	card->tx_chain.head = card->tx_chain.head->next;
-
 	if (spider_net_get_descr_status(descr->prev) !=
 	    SPIDER_NET_DESCR_CARDOWNED) {
 		/* make sure the current descriptor is in memory. Then
