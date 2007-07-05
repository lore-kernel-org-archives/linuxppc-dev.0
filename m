Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A6A0BDDE2C
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:48 +1000 (EST)
Message-Id: <20070705170235.599200000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:02:41 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 08/35] pasemi_mac: Enable L2 caching of packet headers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Enable settings to target L2 for the first few cachelines of the packet,
since we'll access them to get to the various headers.


Signed-off-by: Olof Johansson <olof@lixom.net>


Index: netdev-2.6/drivers/net/pasemi_mac.c
===================================================================
--- netdev-2.6.orig/drivers/net/pasemi_mac.c
+++ netdev-2.6/drivers/net/pasemi_mac.c
@@ -216,7 +216,7 @@ static int pasemi_mac_setup_rx_resources
 			   PAS_DMA_RXCHAN_BASEU_SIZ(RX_RING_SIZE >> 2));
 
 	write_dma_reg(mac, PAS_DMA_RXCHAN_CFG(chan_id),
-			   PAS_DMA_RXCHAN_CFG_HBU(1));
+			   PAS_DMA_RXCHAN_CFG_HBU(2));
 
 	write_dma_reg(mac, PAS_DMA_RXINT_BASEL(mac->dma_if),
 			   PAS_DMA_RXINT_BASEL_BRBL(__pa(ring->buffers)));
@@ -225,6 +225,9 @@ static int pasemi_mac_setup_rx_resources
 			   PAS_DMA_RXINT_BASEU_BRBH(__pa(ring->buffers) >> 32) |
 			   PAS_DMA_RXINT_BASEU_SIZ(RX_RING_SIZE >> 3));
 
+	write_dma_reg(mac, PAS_DMA_RXINT_CFG(mac->dma_if),
+			   PAS_DMA_RXINT_CFG_DHL(2));
+
 	ring->next_to_fill = 0;
 	ring->next_to_clean = 0;
 
Index: netdev-2.6/drivers/net/pasemi_mac.h
===================================================================
--- netdev-2.6.orig/drivers/net/pasemi_mac.h
+++ netdev-2.6/drivers/net/pasemi_mac.h
@@ -218,6 +218,14 @@ enum {
 #define    PAS_DMA_RXINT_RCMDSTA_ACT	0x00010000
 #define    PAS_DMA_RXINT_RCMDSTA_DROPS_M	0xfffe0000
 #define    PAS_DMA_RXINT_RCMDSTA_DROPS_S	17
+#define PAS_DMA_RXINT_CFG(i)		(0x204+(i)*_PAS_DMA_RXINT_STRIDE)
+#define    PAS_DMA_RXINT_CFG_DHL_M	0x07000000
+#define    PAS_DMA_RXINT_CFG_DHL_S	24
+#define    PAS_DMA_RXINT_CFG_DHL(x)	(((x) << PAS_DMA_RXINT_CFG_DHL_S) & \
+					 PAS_DMA_RXINT_CFG_DHL_M)
+#define    PAS_DMA_RXINT_CFG_WIF	0x00000002
+#define    PAS_DMA_RXINT_CFG_WIL	0x00000001
+
 #define PAS_DMA_RXINT_INCR(i)		(0x210+(i)*_PAS_DMA_RXINT_STRIDE)
 #define    PAS_DMA_RXINT_INCR_INCR_M	0x0000ffff
 #define    PAS_DMA_RXINT_INCR_INCR_S	0

--
