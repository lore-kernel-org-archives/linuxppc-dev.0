Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 4BD921A002B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 03:11:46 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: fsl-spi: use of_iomap() to map parameter ram on CPM1
Message-Id: <20150226161142.D08681A2360@localhost.localdomain>
Date: Thu, 26 Feb 2015 17:11:42 +0100 (CET)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On CPM2, the SPI parameter RAM is dynamically allocated in the dualport RAM
whereas in CPM1, it is statically allocated to a default address with
capability to relocate it somewhere else via the use of CPM micropatch.
The address of the parameter RAM is given by the boot loader and expected
to be mapped via of_iomap()

In the current implementation, in function fsl_spi_cpm_get_pram() there is
a confusion between the SPI_BASE register and the base of the SPI
parameter RAM. Fortunatly, it is working properly with MPC866 and MPC885
because they do set SPI_BASE, but on MPC860 and other old MPC8xx that doesn't
set SPI_BASE, pram_ofs is not properly set.
Also, the parameter RAM is not properly mapped with of_iomap() as it should
but still gets accessible by chance through the full RAM which is mapped
from somewhere else.

This patch applies to the SPI driver the same principle as for the CPM UART:
when the CPM is of type CPM1, we simply do an of_iomap() of the area provided
via the device tree.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 drivers/spi/spi-fsl-cpm.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index e85ab1c..97c28d7 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -264,17 +264,6 @@ static unsigned long fsl_spi_cpm_get_pram(struct mpc8xxx_spi *mspi)
 	if (mspi->flags & SPI_CPM2) {
 		pram_ofs = cpm_muram_alloc(SPI_PRAM_SIZE, 64);
 		out_be16(spi_base, pram_ofs);
-	} else {
-		struct spi_pram __iomem *pram = spi_base;
-		u16 rpbase = in_be16(&pram->rpbase);
-
-		/* Microcode relocation patch applied? */
-		if (rpbase) {
-			pram_ofs = rpbase;
-		} else {
-			pram_ofs = cpm_muram_alloc(SPI_PRAM_SIZE, 64);
-			out_be16(spi_base, pram_ofs);
-		}
 	}
 
 	iounmap(spi_base);
@@ -287,7 +276,6 @@ int fsl_spi_cpm_init(struct mpc8xxx_spi *mspi)
 	struct device_node *np = dev->of_node;
 	const u32 *iprop;
 	int size;
-	unsigned long pram_ofs;
 	unsigned long bds_ofs;
 
 	if (!(mspi->flags & SPI_CPM_MODE))
@@ -314,8 +302,17 @@ int fsl_spi_cpm_init(struct mpc8xxx_spi *mspi)
 		}
 	}
 
-	pram_ofs = fsl_spi_cpm_get_pram(mspi);
-	if (IS_ERR_VALUE(pram_ofs)) {
+	if (mspi->flags & SPI_CPM1) {
+		mspi->pram = of_iomap(np, 1);
+	} else {
+		unsigned long pram_ofs = fsl_spi_cpm_get_pram(mspi);
+
+		if (IS_ERR_VALUE(pram_ofs))
+			mspi->pram = NULL;
+		else
+			mspi->pram = cpm_muram_addr(pram_ofs);
+	}
+	if (mspi->pram == NULL) {
 		dev_err(dev, "can't allocate spi parameter ram\n");
 		goto err_pram;
 	}
@@ -341,8 +338,6 @@ int fsl_spi_cpm_init(struct mpc8xxx_spi *mspi)
 		goto err_dummy_rx;
 	}
 
-	mspi->pram = cpm_muram_addr(pram_ofs);
-
 	mspi->tx_bd = cpm_muram_addr(bds_ofs);
 	mspi->rx_bd = cpm_muram_addr(bds_ofs + sizeof(*mspi->tx_bd));
 
@@ -370,7 +365,10 @@ err_dummy_rx:
 err_dummy_tx:
 	cpm_muram_free(bds_ofs);
 err_bds:
-	cpm_muram_free(pram_ofs);
+	if (mspi->flags & SPI_CPM1)
+		iounmap(mspi->pram);
+	else
+		cpm_muram_free(cpm_muram_offset(mspi->pram));
 err_pram:
 	fsl_spi_free_dummy_rx();
 	return -ENOMEM;
-- 
2.1.0
