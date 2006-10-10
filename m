Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E8BCE67C28
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 07:01:24 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9AL11jF022821
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 17:01:01 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9AL11hO476486
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 15:01:01 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9AL10FH013152
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 15:01:01 -0600
Date: Tue, 10 Oct 2006 16:01:00 -0500
To: akpm@osdl.org
Subject: [PATCH 5/21]: powerpc/cell spidernet zlen min packet length
Message-ID: <20061010210100.GB4381@austin.ibm.com>
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



Polite device drivers pad short packets to 60 bytes, 
so that mean-spirited users don't accidentally DOS 
some other OS that can't handle short packets.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 12:22:49.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 12:43:51.000000000 -0500
@@ -648,18 +648,26 @@ spider_net_prepare_tx_descr(struct spide
 {
 	struct spider_net_descr *descr = card->tx_chain.head;
 	dma_addr_t buf;
+	int length;
 
-	buf = pci_map_single(card->pdev, skb->data, skb->len, PCI_DMA_TODEVICE);
+	length = skb->len;
+	if (length < ETH_ZLEN) {
+		if (skb_pad(skb, ETH_ZLEN-length))
+			return 0;
+		length = ETH_ZLEN;
+	}
+
+	buf = pci_map_single(card->pdev, skb->data, length, PCI_DMA_TODEVICE);
 	if (pci_dma_mapping_error(buf)) {
 		if (netif_msg_tx_err(card) && net_ratelimit())
 			pr_err("could not iommu-map packet (%p, %i). "
-				  "Dropping packet\n", skb->data, skb->len);
+				  "Dropping packet\n", skb->data, length);
 		card->spider_stats.tx_iommu_map_error++;
 		return -ENOMEM;
 	}
 
 	descr->buf_addr = buf;
-	descr->buf_size = skb->len;
+	descr->buf_size = length;
 	descr->next_descr_addr = 0;
 	descr->skb = skb;
 	descr->data_status = 0;
@@ -693,6 +701,7 @@ spider_net_release_tx_descr(struct spide
 {
 	struct spider_net_descr *descr = card->tx_chain.tail;
 	struct sk_buff *skb;
+	unsigned int len;
 
 	card->tx_chain.tail = card->tx_chain.tail->next;
 	descr->dmac_cmd_status |= SPIDER_NET_DESCR_NOT_IN_USE;
@@ -701,7 +710,8 @@ spider_net_release_tx_descr(struct spide
 	skb = descr->skb;
 	if (!skb)
 		return;
-	pci_unmap_single(card->pdev, descr->buf_addr, skb->len,
+	len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
+	pci_unmap_single(card->pdev, descr->buf_addr, len,
 			PCI_DMA_TODEVICE);
 	dev_kfree_skb_any(skb);
 }
