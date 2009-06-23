Return-Path: <david-b@pacbell.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 067F7B7085
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 08:38:46 +1000 (EST)
Received: from smtp102.sbc.mail.gq1.yahoo.com (smtp102.sbc.mail.gq1.yahoo.com
	[67.195.15.61]) by ozlabs.org (Postfix) with SMTP id 51477DDDE9
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 08:38:42 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [Question] m25p80 driver versus spi clock rate
Date: Tue, 23 Jun 2009 15:38:39 -0700
References: <4A3FEE98.60700@harris.com>
	<200906231408.26912.david-b@pacbell.net>
	<4A414E07.5050303@harris.com>
In-Reply-To: <4A414E07.5050303@harris.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200906231538.40125.david-b@pacbell.net>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Stefan Roese <sr@denx.de>, linux-mtd@lists.infradead.org,
	Mike Frysinger <vapier.adi@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 23 June 2009, Steven A. Falco wrote:
> m25p80 spi0.0: invalid bits-per-word (0)
> 
> This message comes from spi_ppc4xx_setupxfer.  I believe your patch
> is doing what you intended (i.e. forcing an initial call to
> spi_ppc4xx_setupxfer), but it exposes an OF / SPI linkage problem.
> 
> Namely, of_register_spi_devices does not support a bits-per-word
> property, so bits-per-word is zero.

Bits-per-word == 0 must be interpreted as == 8.

Simple bug in the ppc4xx code.  It currently rejects
values other than 8.

Speaking of spi_ppc4xx issues ... I still have an oldish
copy in my review queue, it needs something like the
appended patch.  (Plus something to accept bpw == 0.)
Is there a newer version?

- Dave


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
