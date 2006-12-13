Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5542267BF3
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 08:16:23 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBDLGKrZ005500
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 16:16:20 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBDLGK3R435088
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 14:16:20 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBDLGJQ9027771
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 14:16:20 -0700
Date: Wed, 13 Dec 2006 15:16:18 -0600
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 6/14] Spidernet another skb mem leak
Message-ID: <20061213211618.GF1915@austin.ibm.com>
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


Another skb leak in an error branch. Fix this by adding
call to dev_kfree_skb_irq() after moving to a more
appropriate spot.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

Index: linux-2.6.19-git7/drivers/net/spider_net.c
===================================================================
--- linux-2.6.19-git7.orig/drivers/net/spider_net.c	2006-12-13 14:24:16.000000000 -0600
+++ linux-2.6.19-git7/drivers/net/spider_net.c	2006-12-13 14:24:20.000000000 -0600
@@ -926,19 +926,8 @@ spider_net_pass_skb_up(struct spider_net
 
 	data_status = descr->data_status;
 	data_error = descr->data_error;
-
 	netdev = card->netdev;
 
-	/* the cases we'll throw away the packet immediately */
-	if (data_error & SPIDER_NET_DESTROY_RX_FLAGS) {
-		if (netif_msg_rx_err(card))
-			pr_err("error in received descriptor found, "
-			       "data_status=x%08x, data_error=x%08x\n",
-			       data_status, data_error);
-		card->spider_stats.rx_desc_error++;
-		return 0;
-	}
-
 	skb = descr->skb;
 	skb->dev = netdev;
 	skb_put(skb, descr->valid_size);
@@ -1037,6 +1026,18 @@ spider_net_decode_one_descr(struct spide
 		goto refill;
 	}
 
+	/* The cases we'll throw away the packet immediately */
+	if (descr->data_error & SPIDER_NET_DESTROY_RX_FLAGS) {
+		if (netif_msg_rx_err(card))
+			pr_err("%s: error in received descriptor found, "
+			       "data_status=x%08x, data_error=x%08x\n",
+			       card->netdev->name,
+			       descr->data_status, descr->data_error);
+		card->spider_stats.rx_desc_error++;
+		dev_kfree_skb_irq(descr->skb);
+		goto refill;
+	}
+
 	/* ok, we've got a packet in descr */
 	result = spider_net_pass_skb_up(descr, card);
 refill:
