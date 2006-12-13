Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6FC0D67C56
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 08:19:59 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBDLJuNQ007413
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 16:19:56 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBDLJuip366122
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 14:19:56 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBDLJtNk014231
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 14:19:56 -0700
Date: Wed, 13 Dec 2006 15:19:54 -0600
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 9/14] Spidernet Remove unused variable
Message-ID: <20061213211954.GI1915@austin.ibm.com>
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


Remove unused variable; this makes code easier to read.
Tweak commentary.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

Index: linux-2.6.19-git7/drivers/net/spider_net.c
===================================================================
--- linux-2.6.19-git7.orig/drivers/net/spider_net.c	2006-12-13 14:28:11.000000000 -0600
+++ linux-2.6.19-git7/drivers/net/spider_net.c	2006-12-13 14:28:15.000000000 -0600
@@ -367,21 +367,20 @@ spider_net_free_rx_chain_contents(struct
 }
 
 /**
- * spider_net_prepare_rx_descr - reinitializes a rx descriptor
+ * spider_net_prepare_rx_descr - Reinitialize RX descriptor
  * @card: card structure
  * @descr: descriptor to re-init
  *
- * return 0 on succes, <0 on failure
+ * Return 0 on succes, <0 on failure.
  *
- * allocates a new rx skb, iommu-maps it and attaches it to the descriptor.
- * Activate the descriptor state-wise
+ * Allocates a new rx skb, iommu-maps it and attaches it to the
+ * descriptor. Mark the descriptor as activated, ready-to-use.
  */
 static int
 spider_net_prepare_rx_descr(struct spider_net_card *card,
 			    struct spider_net_descr *descr)
 {
 	dma_addr_t buf;
-	int error = 0;
 	int offset;
 	int bufsize;
 
@@ -409,7 +408,7 @@ spider_net_prepare_rx_descr(struct spide
 		(SPIDER_NET_RXBUF_ALIGN - 1);
 	if (offset)
 		skb_reserve(descr->skb, SPIDER_NET_RXBUF_ALIGN - offset);
-	/* io-mmu-map the skb */
+	/* iommu-map the skb */
 	buf = pci_map_single(card->pdev, descr->skb->data,
 			SPIDER_NET_MAX_FRAME, PCI_DMA_FROMDEVICE);
 	descr->buf_addr = buf;
@@ -424,7 +423,7 @@ spider_net_prepare_rx_descr(struct spide
 					 SPIDER_NET_DMAC_NOINTR_COMPLETE;
 	}
 
-	return error;
+	return 0;
 }
 
 /**
