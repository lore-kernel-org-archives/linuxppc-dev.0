Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EA56D67C05
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 08:17:43 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBDLHfPk026226
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 16:17:41 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBDLHfdQ492350
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 14:17:41 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBDLHeDM010804
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 14:17:40 -0700
Date: Wed, 13 Dec 2006 15:17:39 -0600
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 7/14] Spidernet Cleanup return codes
Message-ID: <20061213211739.GG1915@austin.ibm.com>
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


Simplify the somewhat convoluted use of return codes
in the rx buffer handling.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

Index: linux-2.6.19-git7/drivers/net/spider_net.c
===================================================================
--- linux-2.6.19-git7.orig/drivers/net/spider_net.c	2006-12-13 14:24:20.000000000 -0600
+++ linux-2.6.19-git7/drivers/net/spider_net.c	2006-12-13 14:27:35.000000000 -0600
@@ -911,12 +911,10 @@ spider_net_do_ioctl(struct net_device *n
  * @descr: descriptor to process
  * @card: card structure
  *
- * returns 1 on success, 0 if no packet was passed to the stack
- *
  * Fills out skb structure and passes the data to the stack.
  * The descriptor state is not changed.
  */
-static int
+static void
 spider_net_pass_skb_up(struct spider_net_descr *descr,
 		       struct spider_net_card *card)
 {
@@ -961,8 +959,6 @@ spider_net_pass_skb_up(struct spider_net
 	/* update netdevice statistics */
 	card->netdev_stats.rx_packets++;
 	card->netdev_stats.rx_bytes += skb->len;
-
-	return 1;
 }
 
 /**
@@ -981,7 +977,6 @@ spider_net_decode_one_descr(struct spide
 	struct spider_net_descr_chain *chain = &card->rx_chain;
 	struct spider_net_descr *descr = chain->tail;
 	int status;
-	int result;
 
 	status = spider_net_get_descr_status(descr);
 
@@ -999,8 +994,6 @@ spider_net_decode_one_descr(struct spide
 	/* descriptor definitively used -- move on tail */
 	chain->tail = descr->next;
 
-	result = 0;
-
 	/* unmap descriptor */
 	pci_unmap_single(card->pdev, descr->buf_addr,
 			SPIDER_NET_MAX_FRAME, PCI_DMA_FROMDEVICE);
@@ -1012,8 +1005,7 @@ spider_net_decode_one_descr(struct spide
 			pr_err("%s: dropping RX descriptor with state %d\n",
 			       card->netdev->name, status);
 		card->netdev_stats.rx_dropped++;
-		dev_kfree_skb_irq(descr->skb);
-		goto refill;
+		goto bad_desc;
 	}
 
 	if ( (status != SPIDER_NET_DESCR_COMPLETE) &&
@@ -1022,8 +1014,7 @@ spider_net_decode_one_descr(struct spide
 			pr_err("%s: RX descriptor with unkown state %d\n",
 			       card->netdev->name, status);
 		card->spider_stats.rx_desc_unk_state++;
-		dev_kfree_skb_irq(descr->skb);
-		goto refill;
+		goto bad_desc;
 	}
 
 	/* The cases we'll throw away the packet immediately */
@@ -1033,17 +1024,18 @@ spider_net_decode_one_descr(struct spide
 			       "data_status=x%08x, data_error=x%08x\n",
 			       card->netdev->name,
 			       descr->data_status, descr->data_error);
-		card->spider_stats.rx_desc_error++;
-		dev_kfree_skb_irq(descr->skb);
-		goto refill;
+		goto bad_desc;
 	}
 
-	/* ok, we've got a packet in descr */
-	result = spider_net_pass_skb_up(descr, card);
-refill:
-	/* change the descriptor state: */
+	/* Ok, we've got a packet in descr */
+	spider_net_pass_skb_up(descr, card);
 	descr->dmac_cmd_status = SPIDER_NET_DESCR_NOT_IN_USE;
-	return result;
+	return 1;
+
+bad_desc:
+	dev_kfree_skb_irq(descr->skb);
+	descr->dmac_cmd_status = SPIDER_NET_DESCR_NOT_IN_USE;
+	return 0;
 }
 
 /**
