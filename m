Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 81B2EDDE21
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 02:41:32 +1000 (EST)
Date: Mon, 6 Aug 2007 20:39:51 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [PATCH] [SPI][POWERPC] spi_mpc83xx: fix
	prescale modulus?calculation
Message-ID: <20070806163951.GA1724@localhost.localdomain>
References: <20070806131014.GA6913@localhost.localdomain>
	<200708060844.40310.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200708060844.40310.david-b@pacbell.net>
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 06, 2007 at 08:44:40AM -0700, David Brownell wrote:
> On Monday 06 August 2007, Anton Vorontsov wrote:
> > +
> > +                       if (pm)
> > +                               pm--;
> > +                       else /* this floods dmesg if using mmc_spi, so dbg */
> > +                               dev_dbg(&spi->dev, "Requested speed is too "
> > +                                       "high: %d Hz. Will use %d Hz instead.\n",
> > +                                       spi->max_speed_hz, mpc83xx_spi->spibrg / 4);
> 
> Except that's not worthy of any message whatsoever, so it shouldn't
> even be a debug message:  user says "give me at most X", driver says
> "fine", end of story.
> 
> I'm more bothered by the earlier message, which gives a rate higher
> than X instead of cleanly failing.

[...]
> So the patch should be more like the appended ...

Thanks! Reposting here.

- - - -
From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: spi_mpc83xx: fix prescale modulus calculation

Long ago I've noticed (but didn't pay much attention) that
spi_mpc83xx using PM calculations that differs from what
specs describe. I.e.

u8 pm = mpc83xx_spi->spibrg / (spi->max_speed_hz * 4);

While specs says: "The SPI baud rate generator clock source (either
system clock or system clock divided by 16, depending on DIV16 bit) is
divided by 4 * ([PM] + 1), a range from 4 to 64.".

Thus " - 1" is missing in the spi_mpc83xx's formula.

Why nobody noticed that bug? Probably because sysclk usually less then
user expects, e.g. you expect 200 MHz, but real clock is 198 MHz,
and integer rounding helps when this formula is used.

Suppose it's SPI in QE, SYSCLK at 198 MHz, thus SPIBRG at 99MHz, 25 MHz
requested.

PM = (99MHz / ( 25 MHz * 4 )), PM == 0, output SPICLK will be 24.75 MHz

At lower frequencies this bug is more noticeable, though.

And this bug shows itself in all its beauty if SYSCLK is equal or a bit
more than you expect (200 MHz SYSCLK, 100 MHz SPIBRG):
PM = (100MHz / ( 25 MHz * 4 )), PM == 1, output SPICLK will be 12.625 MHz!

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/spi/spi_mpc83xx.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index fe69e94..2adf856 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -148,6 +148,8 @@ static void mpc83xx_spi_chipselect(struct spi_device *spi, int value)
 	if (value == BITBANG_CS_ACTIVE) {
 		u32 regval = mpc83xx_spi_read_reg(&mpc83xx_spi->base->mode);
 		u32 len = spi->bits_per_word;
+		u8 pm;
+
 		if (len == 32)
 			len = 0;
 		else
@@ -170,7 +172,7 @@ static void mpc83xx_spi_chipselect(struct spi_device *spi, int value)
 		regval |= SPMODE_LEN(len);
 
 		if ((mpc83xx_spi->spibrg / spi->max_speed_hz) >= 64) {
-			u8 pm = mpc83xx_spi->spibrg / (spi->max_speed_hz * 64);
+			pm = mpc83xx_spi->spibrg / (spi->max_speed_hz * 64) - 1;
 			if (pm > 0x0f) {
 				dev_err(&spi->dev, "Requested speed is too "
 					"low: %d Hz. Will use %d Hz instead.\n",
@@ -180,7 +182,9 @@ static void mpc83xx_spi_chipselect(struct spi_device *spi, int value)
 			}
 			regval |= SPMODE_PM(pm) | SPMODE_DIV16;
 		} else {
-			u8 pm = mpc83xx_spi->spibrg / (spi->max_speed_hz * 4);
+			pm = mpc83xx_spi->spibrg / (spi->max_speed_hz * 4);
+			if (pm)
+				pm--;
 			regval |= SPMODE_PM(pm);
 		}
 
-- 
1.5.0.6
