Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 917F267DB7
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 10:40:11 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB6NeYle020942
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 18:40:34 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB6Ne862225560
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 18:40:08 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB6Ne7dv002723
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 18:40:08 -0500
Date: Wed, 6 Dec 2006 17:40:06 -0600
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 9/16] Spidernet Merge error branches
Message-ID: <20061206234006.GI4649@austin.ibm.com>
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


Two distinct if() statements have the ame body. Merge the clauses.
Also clean up punctuation, capitalization, etc.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

Index: linux-2.6.19-git7/drivers/net/spider_net.c
===================================================================
--- linux-2.6.19-git7.orig/drivers/net/spider_net.c	2006-12-06 16:03:08.000000000 -0600
+++ linux-2.6.19-git7/drivers/net/spider_net.c	2006-12-06 16:03:09.000000000 -0600
@@ -936,15 +936,16 @@ spider_net_pass_skb_up(struct spider_net
 }
 
 /**
- * spider_net_decode_one_descr - processes an rx descriptor
+ * spider_net_decode_one_descr - Processes an RX descriptor
  * @card: card structure
  * @napi: whether caller is in NAPI context
  *
- * returns 1 if a packet has been sent to the stack, otherwise 0
+ * Returns 1 if a packet has been sent to the stack, otherwise 0.
  *
- * processes an rx descriptor by iommu-unmapping the data buffer and passing
- * the packet up to the stack. This function is called in softirq
- * context, e.g. either bottom half from interrupt or NAPI polling context
+ * Processes an RX descriptor by iommu-unmapping the data buffer
+ * and passing the packet up to the stack. This function is called
+ * in a softirq context, e.g. either bottom half from interrupt or
+ * NAPI polling context.
  */
 static int
 spider_net_decode_one_descr(struct spider_net_card *card, int napi)
@@ -959,23 +960,18 @@ spider_net_decode_one_descr(struct spide
 
 	status = spider_net_get_descr_status(descr);
 
-	if (status == SPIDER_NET_DESCR_CARDOWNED) {
-		/* nothing in the descriptor yet */
+	/* Nothing in the descriptor yet, or ring is empty */
+	if ( (status == SPIDER_NET_DESCR_CARDOWNED) ||
+	     (status == SPIDER_NET_DESCR_NOT_IN_USE) ) {
 		spin_unlock_irqrestore(&chain->lock, flags);
 		return 0;
 	}
 
-	if (status == SPIDER_NET_DESCR_NOT_IN_USE) {
-		/* not initialized yet, the ring must be empty */
-		spin_unlock_irqrestore(&chain->lock, flags);
-		return 0;
-	}
-
-	/* descriptor definitively used -- move on tail */
+	/* Descriptor definitively used -- move on tail. */
 	chain->tail = descr->next;
 	spin_unlock_irqrestore(&chain->lock, flags);
 
-	/* unmap descriptor */
+	/* Unmap descriptor. */
 	pci_unmap_single(card->pdev, descr->buf_addr,
 			SPIDER_NET_MAX_FRAME, PCI_DMA_FROMDEVICE);
 
@@ -998,7 +994,7 @@ spider_net_decode_one_descr(struct spide
 		goto bad_desc;
 	}
 
-	/* The cases we'll throw away the packet immediately */
+	/* The cases we'll throw away the packet immediately. */
 	if (descr->data_error & SPIDER_NET_DESTROY_RX_FLAGS) {
 		if (netif_msg_rx_err(card))
 			pr_err("%s: error in received descriptor found, "
