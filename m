Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 70D95DDF29
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:47 +1000 (EST)
Message-Id: <20070705170234.489685000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:02:37 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 04/35] pasemi_mac: Fix TX interrupt threshold
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It was mistakenly set to interrupt on the second packet instead of first, causing
some interesting latency behaviour.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: netdev-2.6/drivers/net/pasemi_mac.c
===================================================================
--- netdev-2.6.orig/drivers/net/pasemi_mac.c
+++ netdev-2.6/drivers/net/pasemi_mac.c
@@ -755,7 +755,7 @@ static int pasemi_mac_open(struct net_de
 	flags |= PAS_MAC_CFG_PCFG_TSR_1G | PAS_MAC_CFG_PCFG_SPD_1G;
 
 	pci_write_config_dword(mac->iob_pdev, PAS_IOB_DMA_RXCH_CFG(mac->dma_rxch),
-			       PAS_IOB_DMA_RXCH_CFG_CNTTH(1));
+			       PAS_IOB_DMA_RXCH_CFG_CNTTH(0));
 
 	pci_write_config_dword(mac->iob_pdev, PAS_IOB_DMA_TXCH_CFG(mac->dma_txch),
 			       PAS_IOB_DMA_TXCH_CFG_CNTTH(32));

--
