Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BB03F67BD7
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 08:15:20 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBDLFGx5002201
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 16:15:16 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBDLFGDM127470
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 16:15:16 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBDLFFwD021457
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 16:15:16 -0500
Date: Wed, 13 Dec 2006 15:15:15 -0600
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 5/14] Spidernet RX skb mem leak
Message-ID: <20061213211515.GE1915@austin.ibm.com>
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


One of the unlikely error branches has an skb memory leak.
Fix this by handling the error conditions consistently.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

Index: linux-2.6.19-git7/drivers/net/spider_net.c
===================================================================
--- linux-2.6.19-git7.orig/drivers/net/spider_net.c	2006-12-13 14:24:13.000000000 -0600
+++ linux-2.6.19-git7/drivers/net/spider_net.c	2006-12-13 14:24:16.000000000 -0600
@@ -913,8 +913,8 @@ spider_net_do_ioctl(struct net_device *n
  *
  * returns 1 on success, 0 if no packet was passed to the stack
  *
- * iommu-unmaps the skb, fills out skb structure and passes the data to the
- * stack. The descriptor state is not changed.
+ * Fills out skb structure and passes the data to the stack.
+ * The descriptor state is not changed.
  */
 static int
 spider_net_pass_skb_up(struct spider_net_descr *descr,
@@ -929,10 +929,6 @@ spider_net_pass_skb_up(struct spider_net
 
 	netdev = card->netdev;
 
-	/* unmap descriptor */
-	pci_unmap_single(card->pdev, descr->buf_addr, SPIDER_NET_MAX_FRAME,
-			PCI_DMA_FROMDEVICE);
-
 	/* the cases we'll throw away the packet immediately */
 	if (data_error & SPIDER_NET_DESTROY_RX_FLAGS) {
 		if (netif_msg_rx_err(card))
@@ -1015,6 +1011,11 @@ spider_net_decode_one_descr(struct spide
 	chain->tail = descr->next;
 
 	result = 0;
+
+	/* unmap descriptor */
+	pci_unmap_single(card->pdev, descr->buf_addr,
+			SPIDER_NET_MAX_FRAME, PCI_DMA_FROMDEVICE);
+
 	if ( (status == SPIDER_NET_DESCR_RESPONSE_ERROR) ||
 	     (status == SPIDER_NET_DESCR_PROTECTION_ERROR) ||
 	     (status == SPIDER_NET_DESCR_FORCE_END) ) {
@@ -1022,8 +1023,6 @@ spider_net_decode_one_descr(struct spide
 			pr_err("%s: dropping RX descriptor with state %d\n",
 			       card->netdev->name, status);
 		card->netdev_stats.rx_dropped++;
-		pci_unmap_single(card->pdev, descr->buf_addr,
-				SPIDER_NET_MAX_FRAME, PCI_DMA_FROMDEVICE);
 		dev_kfree_skb_irq(descr->skb);
 		goto refill;
 	}
@@ -1031,9 +1030,10 @@ spider_net_decode_one_descr(struct spide
 	if ( (status != SPIDER_NET_DESCR_COMPLETE) &&
 	     (status != SPIDER_NET_DESCR_FRAME_END) ) {
 		if (netif_msg_rx_err(card))
-			pr_err("%s: RX descriptor with state %d\n",
+			pr_err("%s: RX descriptor with unkown state %d\n",
 			       card->netdev->name, status);
 		card->spider_stats.rx_desc_unk_state++;
+		dev_kfree_skb_irq(descr->skb);
 		goto refill;
 	}
 
