Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 76EC9DDEEF
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 11:53:08 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1G0r5to005662
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 19:53:05 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1G0r5oj541122
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 17:53:05 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1G0r4tM029266
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 17:53:05 -0700
Date: Thu, 15 Feb 2007 18:53:04 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH: 9/12]: spidernet: fix racy double-free of skb
Message-ID: <20070216005303.GI8192@austin.ibm.com>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	<45D3EAA7.80805@garzik.org>
	<1171525923.20192.243.camel@localhost.localdomain>
	<200702151141.49708.jens@de.ibm.com>
	<20070215171414.GU923@austin.ibm.com>
	<1171572392.5644.15.camel@localhost.localdomain>
	<20070216001857.GC923@austin.ibm.com>
	<20070216004325.GA8192@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070216004325.GA8192@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


It appears that under certain circumstances, a race will result
in a double-free of an skb. This patch null's out the skb pointer
upon the skb free, avoiding the inadvertent deref of bogus data.
The next patch fixes the actual race.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
Cc: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>

----
 drivers/net/spider_net.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

Index: linux-2.6.20-git4/drivers/net/spider_net.c
===================================================================
--- linux-2.6.20-git4.orig/drivers/net/spider_net.c	2007-02-15 17:58:49.000000000 -0600
+++ linux-2.6.20-git4/drivers/net/spider_net.c	2007-02-15 17:58:54.000000000 -0600
@@ -396,10 +396,11 @@ spider_net_free_rx_chain_contents(struct
 	descr = card->rx_chain.head;
 	do {
 		if (descr->skb) {
-			dev_kfree_skb(descr->skb);
 			pci_unmap_single(card->pdev, descr->hwdescr->buf_addr,
 					 SPIDER_NET_MAX_FRAME,
 					 PCI_DMA_BIDIRECTIONAL);
+			dev_kfree_skb(descr->skb);
+			descr->skb = NULL;
 		}
 		descr = descr->next;
 	} while (descr != card->rx_chain.head);
@@ -453,6 +454,7 @@ spider_net_prepare_rx_descr(struct spide
 			SPIDER_NET_MAX_FRAME, PCI_DMA_FROMDEVICE);
 	if (pci_dma_mapping_error(buf)) {
 		dev_kfree_skb_any(descr->skb);
+		descr->skb = NULL;
 		if (netif_msg_rx_err(card) && net_ratelimit())
 			pr_err("Could not iommu-map rx buffer\n");
 		card->spider_stats.rx_iommu_map_error++;
@@ -682,6 +684,7 @@ static int
 spider_net_prepare_tx_descr(struct spider_net_card *card,
 			    struct sk_buff *skb)
 {
+	struct spider_net_descr_chain *chain = &card->tx_chain;
 	struct spider_net_descr *descr;
 	struct spider_net_hw_descr *hwdescr;
 	dma_addr_t buf;
@@ -696,10 +699,15 @@ spider_net_prepare_tx_descr(struct spide
 		return -ENOMEM;
 	}
 
-	spin_lock_irqsave(&card->tx_chain.lock, flags);
+	spin_lock_irqsave(&chain->lock, flags);
 	descr = card->tx_chain.head;
+	if (descr->next == chain->tail->prev) {
+		spin_unlock_irqrestore(&chain->lock, flags);
+		pci_unmap_single(card->pdev, buf, skb->len, PCI_DMA_TODEVICE);
+		return -ENOMEM;
+	}
 	hwdescr = descr->hwdescr;
-	card->tx_chain.head = descr->next;
+	chain->head = descr->next;
 
 	descr->skb = skb;
 	hwdescr->buf_addr = buf;
@@ -709,7 +717,7 @@ spider_net_prepare_tx_descr(struct spide
 
 	hwdescr->dmac_cmd_status =
 			SPIDER_NET_DESCR_CARDOWNED | SPIDER_NET_DMAC_NOCS;
-	spin_unlock_irqrestore(&card->tx_chain.lock, flags);
+	spin_unlock_irqrestore(&chain->lock, flags);
 
 	if (skb->protocol == htons(ETH_P_IP))
 		switch (skb->nh.iph->protocol) {
@@ -838,6 +846,7 @@ spider_net_release_tx_chain(struct spide
 		chain->tail = descr->next;
 		hwdescr->dmac_cmd_status |= SPIDER_NET_DESCR_NOT_IN_USE;
 		skb = descr->skb;
+		descr->skb = NULL;
 		buf_addr = hwdescr->buf_addr;
 		spin_unlock_irqrestore(&chain->lock, flags);
 
@@ -903,13 +912,10 @@ spider_net_xmit(struct sk_buff *skb, str
 {
 	int cnt;
 	struct spider_net_card *card = netdev_priv(netdev);
-	struct spider_net_descr_chain *chain = &card->tx_chain;
 
 	spider_net_release_tx_chain(card, 0);
 
-	if ((chain->head->next == chain->tail->prev) ||
-	   (spider_net_prepare_tx_descr(card, skb) != 0)) {
-
+	if (spider_net_prepare_tx_descr(card, skb) != 0) {
 		card->netdev_stats.tx_dropped++;
 		netif_stop_queue(netdev);
 		return NETDEV_TX_BUSY;
@@ -1127,6 +1133,7 @@ spider_net_decode_one_descr(struct spide
 
 bad_desc:
 	dev_kfree_skb_irq(descr->skb);
+	descr->skb = NULL;
 	hwdescr->dmac_cmd_status = SPIDER_NET_DESCR_NOT_IN_USE;
 	return 0;
 }
