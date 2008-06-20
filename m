Return-Path: <G.Chen@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4FB44DDF4D
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 19:43:22 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m5K9hG0O013064
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 02:43:16 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m5K9hEDJ008637
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 04:43:15 -0500 (CDT)
From: Chen Gong <g.chen@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] fix mpc83xx spi prescale modulus calculate
Date: Fri, 20 Jun 2008 17:38:17 +0800
Message-Id: <1213954697-8569-1-git-send-email-g.chen@freescale.com>
Cc: Chen Gong <g.chen@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Chen Gong <g.chen@freescale.com>
---
 drivers/spi/spi_mpc83xx.c |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 6832da6..070c621 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -266,21 +266,24 @@ int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 
 	cs->hw_mode |= SPMODE_LEN(bits_per_word);
 
-	if ((mpc83xx_spi->spibrg / hz) >= 64) {
-		pm = mpc83xx_spi->spibrg / (hz * 64) - 1;
-		if (pm > 0x0f) {
-			dev_err(&spi->dev, "Requested speed is too "
-				"low: %d Hz. Will use %d Hz instead.\n",
-				hz, mpc83xx_spi->spibrg / 1024);
-			pm = 0x0f;
+	if ((mpc83xx_spi->spibrg / hz) > 64) {
+		pm = mpc83xx_spi->spibrg / (hz * 64);
+		if (pm > 16) {
+			cs->hw_mode |= SPMODE_DIV16;
+			pm /= 16;
+			if (pm > 16) {
+				dev_err(&spi->dev, "Requested speed is too "
+					"low: %d Hz. Will use %d Hz instead.\n",
+					hz, mpc83xx_spi->spibrg / 1024);
+				pm = 16;
+			}
 		}
-		cs->hw_mode |= SPMODE_PM(pm) | SPMODE_DIV16;
-	} else {
+	} else
 		pm = mpc83xx_spi->spibrg / (hz * 4);
-		if (pm)
-			pm--;
-		cs->hw_mode |= SPMODE_PM(pm);
-	}
+	if (pm)
+		pm--;
+
+	cs->hw_mode |= SPMODE_PM(pm);
 	regval =  mpc83xx_spi_read_reg(&mpc83xx_spi->base->mode);
 	if (cs->hw_mode != regval) {
 		unsigned long flags;
-- 
1.5.4
