Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [194.2.40.7])
	by ozlabs.org (Postfix) with ESMTP id 2517CB70CC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 17:05:38 +1000 (EST)
Subject: [PATCH] spi_mpc8xxx: fix buffer overrun when sending only/receiving
	only more than PAGE_SIZE bytes
From: christophe leroy <christophe.leroy@c-s.fr>
To: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20100916070525.4882CC7391@messagerie.si.c-s.fr>
Date: Thu, 16 Sep 2010 09:05:25 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch applies to 2.6.34.7 and 2.6.35.4
It fixes an issue when sending only or receiving only more than PAGE_SIZE bytes

Signed-off-by: christophe leroy <christophe.leroy@c-s.fr>

diff -urN c/drivers/spi/spi_mpc8xxx.c d/drivers/spi/spi_mpc8xxx.c
--- c/drivers/spi/spi_mpc8xxx.c	2010-09-08 16:44:03.000000000 +0200
+++ d/drivers/spi/spi_mpc8xxx.c	2010-09-08 16:44:14.000000000 +0200
@@ -393,11 +393,17 @@
 
 	xfer_ofs = mspi->xfer_in_progress->len - mspi->count;
 
-	out_be32(&rx_bd->cbd_bufaddr, mspi->rx_dma + xfer_ofs);
+	if (mspi->rx_dma == mspi->dma_dummy_rx)
+		out_be32(&rx_bd->cbd_bufaddr, mspi->rx_dma);
+	else
+		out_be32(&rx_bd->cbd_bufaddr, mspi->rx_dma + xfer_ofs);
 	out_be16(&rx_bd->cbd_datlen, 0);
 	out_be16(&rx_bd->cbd_sc, BD_SC_EMPTY | BD_SC_INTRPT | BD_SC_WRAP);
 
-	out_be32(&tx_bd->cbd_bufaddr, mspi->tx_dma + xfer_ofs);
+	if (mspi->tx_dma == mspi->dma_dummy_tx)
+		out_be32(&tx_bd->cbd_bufaddr, mspi->tx_dma);
+	else
+		out_be32(&tx_bd->cbd_bufaddr, mspi->tx_dma + xfer_ofs);
 	out_be16(&tx_bd->cbd_datlen, xfer_len);
 	out_be16(&tx_bd->cbd_sc, BD_SC_READY | BD_SC_INTRPT | BD_SC_WRAP |
 				 BD_SC_LAST);
