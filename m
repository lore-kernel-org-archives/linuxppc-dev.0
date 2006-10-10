Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 93DA267DBF
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 07:21:14 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9ALLBtb000860
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 17:21:11 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9ALLBGZ494196
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 15:21:11 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9ALLAHQ012486
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 15:21:11 -0600
Date: Tue, 10 Oct 2006 16:21:10 -0500
To: akpm@osdl.org
Subject: [PATCH 19/21]: powerpc/cell spidernet DMA direction fix
Message-ID: <20061010212110.GP4381@austin.ibm.com>
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


The ring buffer descriptors are DMA-accessed bidirectionally,
but are not declared in this way.  Fix this.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 13:35:33.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 13:37:40.000000000 -0500
@@ -301,7 +301,7 @@ static int
 spider_net_init_chain(struct spider_net_card *card,
 		       struct spider_net_descr_chain *chain,
 		       struct spider_net_descr *start_descr,
-		       int direction, int no)
+		       int no)
 {
 	int i;
 	struct spider_net_descr *descr;
@@ -316,7 +316,7 @@ spider_net_init_chain(struct spider_net_
 
 		buf = pci_map_single(card->pdev, descr,
 				     SPIDER_NET_DESCR_SIZE,
-				     direction);
+				     PCI_DMA_BIDIRECTIONAL);
 
 		if (pci_dma_mapping_error(buf))
 			goto iommu_error;
@@ -330,11 +330,6 @@ spider_net_init_chain(struct spider_net_
 	(descr-1)->next = start_descr;
 	start_descr->prev = descr-1;
 
-	descr = start_descr;
-	if (direction == PCI_DMA_FROMDEVICE)
-		for (i=0; i < no; i++, descr++)
-			descr->next_descr_addr = descr->next->bus_addr;
-
 	spin_lock_init(&chain->lock);
 	chain->head = start_descr;
 	chain->tail = start_descr;
@@ -347,7 +342,7 @@ iommu_error:
 		if (descr->bus_addr)
 			pci_unmap_single(card->pdev, descr->bus_addr,
 					 SPIDER_NET_DESCR_SIZE,
-					 direction);
+					 PCI_DMA_BIDIRECTIONAL);
 	return -ENOMEM;
 }
 
@@ -368,7 +363,7 @@ spider_net_free_rx_chain_contents(struct
 			dev_kfree_skb(descr->skb);
 			pci_unmap_single(card->pdev, descr->buf_addr,
 					 SPIDER_NET_MAX_FRAME,
-					 PCI_DMA_FROMDEVICE);
+					 PCI_DMA_BIDIRECTIONAL);
 		}
 		descr = descr->next;
 	}
@@ -1662,21 +1657,26 @@ int
 spider_net_open(struct net_device *netdev)
 {
 	struct spider_net_card *card = netdev_priv(netdev);
-	int result;
+	struct spider_net_descr *descr;
+	int i, result;
 
 	result = -ENOMEM;
 	if (spider_net_init_chain(card, &card->tx_chain, card->descr,
-			PCI_DMA_TODEVICE, card->num_tx_desc))
+	                          card->num_tx_desc))
 		goto alloc_tx_failed;
 
 	card->low_watermark = NULL;
 
 	/* rx_chain is after tx_chain, so offset is descr + tx_count */
 	if (spider_net_init_chain(card, &card->rx_chain,
-			card->descr + card->num_tx_desc,
-			PCI_DMA_FROMDEVICE, card->num_rx_desc))
+	                          card->descr + card->num_tx_desc,
+	                          card->num_rx_desc))
 		goto alloc_rx_failed;
 
+	descr = card->rx_chain.head;
+	for (i=0; i < card->num_rx_desc; i++, descr++)
+		descr->next_descr_addr = descr->next->bus_addr;
+
 	/* allocate rx skbs */
 	if (spider_net_alloc_rx_skbs(card))
 		goto alloc_skbs_failed;
