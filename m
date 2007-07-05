Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A7200DDF1C
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:48 +1000 (EST)
Message-Id: <20070705170236.420815000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:02:44 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 11/35] pasemi_mac: Reduce locking when cleaning TX ring
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Postpone pci unmap and skb free of the transmitted buffers to outside
of the tx ring lock, batching them up 32 at a time.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: netdev-2.6/drivers/net/pasemi_mac.c
===================================================================
--- netdev-2.6.orig/drivers/net/pasemi_mac.c
+++ netdev-2.6/drivers/net/pasemi_mac.c
@@ -562,37 +562,56 @@ static int pasemi_mac_clean_tx(struct pa
 	int i;
 	struct pasemi_mac_buffer *info;
 	struct pas_dma_xct_descr *dp;
-	int start, count;
+	unsigned int start, count, limit;
+	unsigned int total_count;
 	int flags;
+	struct sk_buff *skbs[32];
+	dma_addr_t dmas[32];
 
+	total_count = 0;
+restart:
 	spin_lock_irqsave(&mac->tx->lock, flags);
 
 	start = mac->tx->next_to_clean;
+	limit = min(mac->tx->next_to_use, start+32);
+
 	count = 0;
 
-	for (i = start; i < mac->tx->next_to_use; i++) {
+	for (i = start; i < limit; i++) {
 		dp = &TX_DESC(mac, i);
+
 		if (unlikely(dp->mactx & XCT_MACTX_O))
+			/* Not yet transmitted */
 			break;
 
-		count++;
-
 		info = &TX_DESC_INFO(mac, i);
-
-		pci_unmap_single(mac->dma_pdev, info->dma,
-				 info->skb->len, PCI_DMA_TODEVICE);
-		dev_kfree_skb_irq(info->skb);
+		skbs[count] = info->skb;
+		dmas[count] = info->dma;
 
 		info->skb = NULL;
 		info->dma = 0;
 		dp->mactx = 0;
 		dp->ptr = 0;
+
+		count++;
 	}
 	mac->tx->next_to_clean += count;
 	spin_unlock_irqrestore(&mac->tx->lock, flags);
 	netif_wake_queue(mac->netdev);
 
-	return count;
+	for (i = 0; i < count; i++) {
+		pci_unmap_single(mac->dma_pdev, dmas[i],
+				 skbs[i]->len, PCI_DMA_TODEVICE);
+		dev_kfree_skb_irq(skbs[i]);
+	}
+
+	total_count += count;
+
+	/* If the batch was full, try to clean more */
+	if (count == 32)
+		goto restart;
+
+	return total_count;
 }
 
 

--
