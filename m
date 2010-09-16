Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [194.2.40.7])
	by ozlabs.org (Postfix) with ESMTP id B81581E009
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 17:04:49 +1000 (EST)
Subject: [PATCH] spi_mpc8xxx: fix writing to adress 0
From: christophe leroy <christophe.leroy@c-s.fr>
To: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20100916070420.95083C7391@messagerie.si.c-s.fr>
Date: Thu, 16 Sep 2010 09:04:20 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch applies to 2.6.34.7 (already included in 2.6.35.4)
It fixes an issue when sending only or receiving only (mspi->tx-dma was reset as when no tx_buf is defined, tx_dma is 0)

Signed-off-by: christophe leroy <christophe.leroy@c-s.fr>

diff -urN a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
--- a/drivers/spi/spi_mpc8xxx.c	2010-09-08 16:42:30.000000000 +0200
+++ b/drivers/spi/spi_mpc8xxx.c	2010-09-08 16:43:50.000000000 +0200
@@ -438,7 +438,7 @@
 			dev_err(dev, "unable to map tx dma\n");
 			return -ENOMEM;
 		}
-	} else {
+	} else if (t->tx_buf) {
 		mspi->tx_dma = t->tx_dma;
 	}
 
@@ -449,7 +449,7 @@
 			dev_err(dev, "unable to map rx dma\n");
 			goto err_rx_dma;
 		}
-	} else {
+	} else if (t->rx_buf) {
 		mspi->rx_dma = t->rx_dma;
 	}
