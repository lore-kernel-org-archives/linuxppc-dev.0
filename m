Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [194.2.40.7])
	by ozlabs.org (Postfix) with ESMTP id 3BB9AB6EDD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 23:29:54 +1000 (EST)
Message-ID: <4C90CA4D.2020902@c-s.fr>
Date: Wed, 15 Sep 2010 15:29:49 +0200
From: LEROY Christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] fixes probe issue and hangup in spi_mpc8xxx.c for data bigger
	than PAGE_SIZE
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: spi-devel-general@lists.sourceforge.net,
	LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  This patch applies to 2.6.34.7. It also applies to 2.6.35.4 althought 
part of it is already included in 2.6.35.4
It fixed a problem with spi_mpc8xxx.c when transmitting or receiving 
data bigger than PAGE_SIZE when doing a read only or write only operation
It also fixed an issue with the init probe when fetching the information 
on parameter RAM from the DTB.

Signed-off-by: christophe leroy <christophe.leroy@c-s.fr>

Index: trunk/drivers/spi/spi_mpc8xxx.c
===================================================================
--- trunk/drivers/spi/spi_mpc8xxx.c    (révision 963)
+++ trunk/drivers/spi/spi_mpc8xxx.c    (copie de travail)
@@ -393,11 +393,17 @@

      xfer_ofs = mspi->xfer_in_progress->len - mspi->count;

-    out_be32(&rx_bd->cbd_bufaddr, mspi->rx_dma + xfer_ofs);
+    if (mspi->rx_dma == mspi->dma_dummy_rx)
+        out_be32(&rx_bd->cbd_bufaddr, mspi->rx_dma);
+    else
+        out_be32(&rx_bd->cbd_bufaddr, mspi->rx_dma + xfer_ofs);
      out_be16(&rx_bd->cbd_datlen, 0);
      out_be16(&rx_bd->cbd_sc, BD_SC_EMPTY | BD_SC_INTRPT | BD_SC_WRAP);

-    out_be32(&tx_bd->cbd_bufaddr, mspi->tx_dma + xfer_ofs);
+    if (mspi->tx_dma == mspi->dma_dummy_tx)
+        out_be32(&tx_bd->cbd_bufaddr, mspi->tx_dma);
+    else
+        out_be32(&tx_bd->cbd_bufaddr, mspi->tx_dma + xfer_ofs);
      out_be16(&tx_bd->cbd_datlen, xfer_len);
      out_be16(&tx_bd->cbd_sc, BD_SC_READY | BD_SC_INTRPT | BD_SC_WRAP |
                   BD_SC_LAST);
@@ -438,7 +444,7 @@
              dev_err(dev, "unable to map tx dma\n");
              return -ENOMEM;
          }
-    } else {
+    } else if (t->tx_buf) {
          mspi->tx_dma = t->tx_dma;
      }

@@ -449,7 +455,7 @@
              dev_err(dev, "unable to map rx dma\n");
              goto err_rx_dma;
          }
-    } else {
+    } else if (t->rx_buf) {
          mspi->rx_dma = t->rx_dma;
      }

@@ -822,7 +828,7 @@
      if (!iprop || size != sizeof(*iprop) * 4)
          return -ENOMEM;

-    spi_base_ofs = cpm_muram_alloc_fixed(iprop[2], 2);
+    spi_base_ofs = iprop[2];
      if (IS_ERR_VALUE(spi_base_ofs))
          return -ENOMEM;

@@ -844,7 +850,6 @@
              return spi_base_ofs;
      }

-    cpm_muram_free(spi_base_ofs);
      return pram_ofs;
  }
