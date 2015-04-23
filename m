Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id BC1A61A0C27
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 22:11:51 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: fsl-spi: fix devm_ioremap_resource() error case
Message-Id: <20150423121147.AFEA31A2439@localhost.localdomain>
Date: Thu, 23 Apr 2015 14:11:47 +0200 (CEST)
Cc: jogo@openwrt.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

devm_ioremap_resource() doesn't return NULL but an ERR_PTR on error.

Reported-by: Jonas Gorsky <jogo@openwrt.org>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 drivers/spi/spi-fsl-cpm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index 4e5c945..1e66644 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -305,10 +305,15 @@ int fsl_spi_cpm_init(struct mpc8xxx_spi *mspi)
 
 	if (mspi->flags & SPI_CPM1) {
 		struct resource *res;
+		void *pram;
 
 		res = platform_get_resource(to_platform_device(dev),
 					    IORESOURCE_MEM, 1);
-		mspi->pram = devm_ioremap_resource(dev, res);
+		pram = devm_ioremap_resource(dev, res);
+		if (IS_ERR(pram))
+			mspi->pram = NULL;
+		else
+			mspi->pram = pram;
 	} else {
 		unsigned long pram_ofs = fsl_spi_cpm_get_pram(mspi);
 
-- 
2.1.0
