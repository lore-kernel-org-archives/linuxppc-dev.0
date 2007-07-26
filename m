Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3BB77DE092
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 23:14:39 +1000 (EST)
Date: Thu, 26 Jul 2007 17:14:17 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH 3/4] [POWERPC][SPI] spi_mpc83xx: support for lsb mode switching
Message-ID: <20070726131417.GC3417@localhost.localdomain>
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

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/spi/spi_mpc83xx.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index e2d8dbc..7e17c8b 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -154,12 +154,15 @@ static void mpc83xx_spi_chipselect(struct spi_device *spi, int value)
 
 		/* mask out bits we are going to set */
 		regval &= ~(SPMODE_CP_BEGIN_EDGECLK | SPMODE_CI_INACTIVEHIGH |
-			    SPMODE_LEN(0xF) | SPMODE_DIV16 | SPMODE_PM(0xF));
+			    SPMODE_LEN(0xF) | SPMODE_DIV16 | SPMODE_PM(0xF) | \
+			    SPMODE_REV);
 
 		if (spi->mode & SPI_CPHA)
 			regval |= SPMODE_CP_BEGIN_EDGECLK;
 		if (spi->mode & SPI_CPOL)
 			regval |= SPMODE_CI_INACTIVEHIGH;
+		if (!(spi->mode & SPI_LSB_FIRST))
+			regval |= SPMODE_REV;
 
 		regval |= SPMODE_LEN(len);
 
@@ -248,9 +251,11 @@ int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 
 	regval = mpc83xx_spi_read_reg(&mpc83xx_spi->base->mode);
 
-	/* Mask out bits_per_wordgth */
-	regval &= ~SPMODE_LEN(0xF);
+	/* mask out bits we are going to set */
+	regval &= ~(SPMODE_LEN(0xF) | SPMODE_REV);
 	regval |= SPMODE_LEN(bits_per_word);
+	if (!(spi->mode & SPI_LSB_FIRST))
+		regval |= SPMODE_REV;
 
 	/* Turn off SPI unit prior changing mode */
 	mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, 0);
@@ -260,7 +265,7 @@ int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 }
 
 /* the spi->mode bits understood by this driver: */
-#define MODEBITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH)
+#define MODEBITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST)
 
 static int mpc83xx_spi_setup(struct spi_device *spi)
 {
-- 
1.5.0.6
