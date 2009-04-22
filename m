Return-Path: <david-b@pacbell.net>
Received: from smtp126.sbc.mail.sp1.yahoo.com (smtp126.sbc.mail.sp1.yahoo.com
	[69.147.65.185]) by ozlabs.org (Postfix) with SMTP id 3836CDDEF0
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 16:46:01 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v6] spi: Add PPC4xx SPI driver
Date: Tue, 21 Apr 2009 22:36:12 -0700
References: <1231411250-25380-1-git-send-email-sr@denx.de>
In-Reply-To: <1231411250-25380-1-git-send-email-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200904212236.12904.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 08 January 2009, Stefan Roese wrote:
> This adds a SPI driver for the SPI controller found in the IBM/AMCC
> 4xx PowerPC's.

Note that given some patches now in the mm tree, this needs
something like the appended fixup.  Some common code has now
moved into the spi core.

- Dave


---
 drivers/spi/spi_ppc4xx.c |   19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

--- a/drivers/spi/spi_ppc4xx.c
+++ b/drivers/spi/spi_ppc4xx.c
@@ -61,9 +61,6 @@
 /* RxD ready */
 #define SPI_PPC4XX_SR_RBR	(0x80 >> 7)
 
-/* the spi->mode bits understood by this driver: */
-#define MODEBITS	(SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST)
-
 /* clock settings (SCP and CI) for various SPI modes */
 #define SPI_CLK_MODE0	SPI_PPC4XX_MODE_SCP
 #define SPI_CLK_MODE1	0
@@ -198,9 +195,6 @@ static int spi_ppc4xx_setup(struct spi_d
 	struct spi_ppc4xx_cs *cs = spi->controller_state;
 	int init = 0;
 
-	if (!spi->bits_per_word)
-		spi->bits_per_word = 8;
-
 	if (spi->bits_per_word != 8) {
 		dev_err(&spi->dev, "invalid bits-per-word (%d)\n",
 			spi->bits_per_word);
@@ -212,12 +206,6 @@ static int spi_ppc4xx_setup(struct spi_d
 		return -EINVAL;
 	}
 
-	if (spi->mode & ~MODEBITS) {
-		dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
-			spi->mode & ~MODEBITS);
-		return -EINVAL;
-	}
-
 	if (cs == NULL) {
 		cs = kzalloc(sizeof *cs, GFP_KERNEL);
 		if (!cs)
@@ -268,10 +256,6 @@ static int spi_ppc4xx_setup(struct spi_d
 		}
 	}
 
-	dev_dbg(&spi->dev, "%s: mode %d, %u bpw, %d hz\n",
-		__func__, spi->mode, spi->bits_per_word,
-		spi->max_speed_hz);
-
 	return 0;
 }
 
@@ -442,6 +426,9 @@ static int __init spi_ppc4xx_of_probe(st
 		}
 	}
 
+	/* the spi->mode bits understood by this driver: */
+	master->modebits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST;
+
 	/* Setup the state for the bitbang driver */
 	bbp = &hw->bitbang;
 	bbp->master = hw->master;
