Return-Path: <sfalco@harris.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2CE3CB70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 00:34:39 +1000 (EST)
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 726E1DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 00:34:38 +1000 (EST)
Message-ID: <4A42397A.8030105@harris.com>
Date: Wed, 24 Jun 2009 10:34:34 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [PATCH v1] Make spi_ppc4xx.c tolerate 0 bits-per-word and 0 speed_hz
Content-Type: text/plain; charset=UTF-8
Cc: David Brownell <david-b@pacbell.net>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If a SPI transfer is set up, but does not explicitly set bits-per-word
and speed_hz, then the transaction fails, because spi_ppc4xx_setupxfer
rejects it.

This patch modifies the logic to chose the struct spi_transfer parameters
only if they are non-zero.  Otherwise, the struct spi_device parameters
are used.

Additionally, since there is no OF binding for bits-per-word, we have to
tolerate the case where both t->bits_per_word and spi->bits_per_word are
zero.
---
This was brought to light by a pending patch to spi_bitbang, which results
in more calls to spi_ppc4xx_setupxfer.

 drivers/spi/spi_ppc4xx.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi_ppc4xx.c b/drivers/spi/spi_ppc4xx.c
index e46292b..9775bf2 100644
--- a/drivers/spi/spi_ppc4xx.c
+++ b/drivers/spi/spi_ppc4xx.c
@@ -151,16 +151,24 @@ static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 	/* Write new configration */
 	out_8(&hw->regs->mode, cs->mode);
 
+	/* Start with the generic configuration for this device. */
+	bpw = spi->bits_per_word;
+	cs->speed_hz = spi->max_speed_hz;
+
 	/*
-	 * Allow platform reduce the interrupt load on the CPU during SPI
-	 * transfers. We do not target maximum performance, but rather allow
-	 * platform to limit SPI bus frequency and interrupt rate.
+	 * Allow the platform to reduce the interrupt load on the CPU during
+	 * SPI transfers. We do not target maximum performance, but rather
+	 * allow the platform to limit SPI bus frequency and interrupt rate.
 	 */
-	bpw = t ? t->bits_per_word : spi->bits_per_word;
-	cs->speed_hz = t ? min(t->speed_hz, spi->max_speed_hz) :
-		spi->max_speed_hz;
+	if(t) {
+		if(t->bits_per_word)
+			bpw = t->bits_per_word;
+
+		if(t->speed_hz)
+			cs->speed_hz = min(t->speed_hz, spi->max_speed_hz);
+	}
 
-	if (bpw != 8) {
+	if (bpw && bpw != 8) {
 		dev_err(&spi->dev, "invalid bits-per-word (%d)\n", bpw);
 		return -EINVAL;
 	}
-- 
1.6.0.2
