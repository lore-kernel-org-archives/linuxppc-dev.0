Return-Path: <jacmet@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by ozlabs.org (Postfix) with ESMTP id D426D474E2
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 23:49:03 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so432088fga.36
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Sep 2008 06:49:01 -0700 (PDT)
From: Peter Korsgaard <jacmet@sunsite.dk>
To: spi-devel-general@lists.sourceforge.net, dbrownell@users.sourceforge.net,
	g.chen@freescale.com, linuxppc-dev@ozlabs.org
Subject: [PATCH] spi_mpc83xx: fix clockrate calculation for low speed
Date: Thu,  4 Sep 2008 15:49:00 +0200
Message-Id: <1220536140-18289-1-git-send-email-jacmet@sunsite.dk>
Sender: Peter Korsgaard <jacmet@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit a61f5345 (spi_mpc83xx clockrate fixes) broke clockrate
calculation for low speeds. SPMODE_DIV16 should be set if the
divider is higher than 64, not only if the divider gets clipped
to 1024.

Furthermore, the clipping check was off by a factor 16 as well.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 drivers/spi/spi_mpc83xx.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 070c621..ab7ee44 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -267,16 +267,13 @@ int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	cs->hw_mode |= SPMODE_LEN(bits_per_word);
 
 	if ((mpc83xx_spi->spibrg / hz) > 64) {
+		cs->hw_mode |= SPMODE_DIV16;
 		pm = mpc83xx_spi->spibrg / (hz * 64);
 		if (pm > 16) {
-			cs->hw_mode |= SPMODE_DIV16;
-			pm /= 16;
-			if (pm > 16) {
-				dev_err(&spi->dev, "Requested speed is too "
-					"low: %d Hz. Will use %d Hz instead.\n",
-					hz, mpc83xx_spi->spibrg / 1024);
-				pm = 16;
-			}
+			dev_err(&spi->dev, "Requested speed is too "
+				"low: %d Hz. Will use %d Hz instead.\n",
+				hz, mpc83xx_spi->spibrg / 1024);
+			pm = 16;
 		}
 	} else
 		pm = mpc83xx_spi->spibrg / (hz * 4);
-- 
1.5.6.3
