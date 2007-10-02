Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 14D0ADDFCA
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 07:21:12 +1000 (EST)
Date: Tue, 2 Oct 2007 16:25:14 -0500
From: Olof Johansson <olof@lixom.net>
To: jgarzik@pobox.com
Subject: [PATCH] [2/11] pasemi_mac: fix bug in receive buffer dma mapping
Message-ID: <20071002212514.GC2282@lixom.net>
References: <20071002212421.GA2282@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071002212421.GA2282@lixom.net>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pasemi_mac: fix bug in receive buffer dma mapping

skb->len isn't actually set to the size of the allocated skb, so don't
try to use it when figuring out how much to map.

(This hasn't surfaced as a real bug because we effectively disable
translation for the interface, but it still needs fixing for the future)


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: k.org/drivers/net/pasemi_mac.c
===================================================================
--- k.org.orig/drivers/net/pasemi_mac.c
+++ k.org/drivers/net/pasemi_mac.c
@@ -396,7 +396,7 @@ static void pasemi_mac_replenish_rx_ring
 		if (unlikely(!skb))
 			break;
 
-		dma = pci_map_single(mac->dma_pdev, skb->data, skb->len,
+		dma = pci_map_single(mac->dma_pdev, skb->data, BUF_SIZE,
 				     PCI_DMA_FROMDEVICE);
 
 		if (unlikely(dma_mapping_error(dma))) {
