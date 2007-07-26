Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5F9EADDDF3
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 23:14:07 +1000 (EST)
Date: Thu, 26 Jul 2007 17:13:46 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH 1/4] [POWERPC][SPI] spi_mpc83xx.c: should turn off SPI unit
	while switching any mode.
Message-ID: <20070726131346.GA3417@localhost.localdomain>
References: <20070726131134.GA3309@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20070726131134.GA3309@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Documentation clearly states, that mode should not be changed
till SPMODE_ENABLE bit set. I've seen hangs w/o this patch.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/spi/spi_mpc83xx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 3295cfc..0b99fd9 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -176,6 +176,8 @@ static void mpc83xx_spi_chipselect(struct spi_device *spi, int value)
 			regval |= SPMODE_PM(pm);
 		}
 
+		/* Turn off SPI unit prior changing mode */
+		mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, 0);
 		mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, regval);
 		if (mpc83xx_spi->activate_cs)
 			mpc83xx_spi->activate_cs(spi->chip_select, pol);
@@ -249,6 +251,8 @@ int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	regval &= 0xff0fffff;
 	regval |= SPMODE_LEN(bits_per_word);
 
+	/* Turn off SPI unit prior changing mode */
+	mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, 0);
 	mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, regval);
 
 	return 0;
-- 
1.5.0.6
