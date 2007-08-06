Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7D4B2DDE11
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 23:11:53 +1000 (EST)
Date: Mon, 6 Aug 2007 17:10:14 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH] [SPI][POWERPC] spi_mpc83xx: fix prescale modulus calculation
Message-ID: <20070806131014.GA6913@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

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
---
 drivers/spi/spi_mpc83xx.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 446b624..042704b 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -170,7 +170,8 @@ static void mpc83xx_spi_chipselect(struct spi_device *spi, int value)
 		regval |= SPMODE_LEN(len);
 
 		if ((mpc83xx_spi->spibrg / spi->max_speed_hz) >= 64) {
-			u8 pm = mpc83xx_spi->spibrg / (spi->max_speed_hz * 64);
+			u8 pm = mpc83xx_spi->spibrg / (spi->max_speed_hz * 64) - 1;
+
 			if (pm > 0x0f) {
 				dev_warn(&spi->dev, "Requested speed is too "
 					"low: %d Hz. Will use %d Hz instead.\n",
@@ -180,6 +181,13 @@ static void mpc83xx_spi_chipselect(struct spi_device *spi, int value)
 			regval |= SPMODE_PM(pm) | SPMODE_DIV16;
 		} else {
 			u8 pm = mpc83xx_spi->spibrg / (spi->max_speed_hz * 4);
+
+			if (pm)
+				pm--;
+			else /* this floods dmesg if using mmc_spi, so dbg */
+				dev_dbg(&spi->dev, "Requested speed is too "
+					"high: %d Hz. Will use %d Hz instead.\n",
+					spi->max_speed_hz, mpc83xx_spi->spibrg / 4);
 			regval |= SPMODE_PM(pm);
 		}
 
-- 
1.5.0.6
