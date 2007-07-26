Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D4D7DDDE09
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 23:14:30 +1000 (EST)
Date: Thu, 26 Jul 2007 17:14:09 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH 2/4] [POWERPC][SPI] spi_mpc83xx: get rid of magic numbers
Message-ID: <20070726131409.GB3417@localhost.localdomain>
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
 drivers/spi/spi_mpc83xx.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 0b99fd9..e2d8dbc 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -153,7 +153,8 @@ static void mpc83xx_spi_chipselect(struct spi_device *spi, int value)
 			len = len - 1;
 
 		/* mask out bits we are going to set */
-		regval &= ~0x38ff0000;
+		regval &= ~(SPMODE_CP_BEGIN_EDGECLK | SPMODE_CI_INACTIVEHIGH |
+			    SPMODE_LEN(0xF) | SPMODE_DIV16 | SPMODE_PM(0xF));
 
 		if (spi->mode & SPI_CPHA)
 			regval |= SPMODE_CP_BEGIN_EDGECLK;
@@ -248,7 +249,7 @@ int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	regval = mpc83xx_spi_read_reg(&mpc83xx_spi->base->mode);
 
 	/* Mask out bits_per_wordgth */
-	regval &= 0xff0fffff;
+	regval &= ~SPMODE_LEN(0xF);
 	regval |= SPMODE_LEN(bits_per_word);
 
 	/* Turn off SPI unit prior changing mode */
-- 
1.5.0.6
