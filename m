Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4556AB708C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 01:09:03 +1000 (EST)
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by ozlabs.org (Postfix) with ESMTP id C2922DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 01:09:01 +1000 (EST)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1MdQIr-00082l-J6
	for linuxppc-dev@ozlabs.org; Tue, 18 Aug 2009 17:08:49 +0200
Received: from 24.114.226.27 ([24.114.226.27])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 17:08:49 +0200
Received: from michaelbarkowski by 24.114.226.27 with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 17:08:49 +0200
To: linuxppc-dev@ozlabs.org
From: Michael Barkowski <michaelbarkowski@ruggedcom.com>
Subject: [PATCH] mpc8xxx_spi: Fix polarity inversion in chipselect
Date: Tue, 18 Aug 2009 11:08:24 -0400
Message-ID: <4A8AC3E8.5070301@ruggedcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: news <news@ger.gmane.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we use open firmware, then alow_flags handles active-low
chipselects, which is the same as SPI_CS_HIGH. This patch fixes the
double negative.

Signed-off-by: Michael Barkowski <michaelbarkowski@ruggedcom.com>
---
Anton,

thanks to your device table matching support patch I can use open firmware
to configure two spi devices on 8360E.  I use the gpios node, with flags set
to 1, matching OF_GPIO_ACTIVE_LOW.  When I do this I notice that the polarity
was already handled in a different way.  Did some searching and didn't find
it had been discussed.  Here's what I am doing now - feel free to use it or
abuse it :) (based in galak-powerpc/next plus your patches 1 and 2)

 drivers/spi/spi_mpc8xxx.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
index 0fd0ec4..36bda94 100644
--- a/drivers/spi/spi_mpc8xxx.c
+++ b/drivers/spi/spi_mpc8xxx.c
@@ -159,14 +159,8 @@ static void mpc8xxx_spi_chipselect(struct spi_device *spi, int value)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
 	struct fsl_spi_platform_data *pdata = spi->dev.parent->platform_data;
-	bool pol = spi->mode & SPI_CS_HIGH;
 	struct spi_mpc8xxx_cs	*cs = spi->controller_state;
 
-	if (value == BITBANG_CS_INACTIVE) {
-		if (pdata->cs_control)
-			pdata->cs_control(spi, !pol);
-	}
-
 	if (value == BITBANG_CS_ACTIVE) {
 		u32 regval = mpc8xxx_spi_read_reg(&mpc8xxx_spi->base->mode);
 
@@ -189,9 +183,9 @@ static void mpc8xxx_spi_chipselect(struct spi_device *spi, int value)
 			mpc8xxx_spi_write_reg(mode, regval);
 			local_irq_restore(flags);
 		}
-		if (pdata->cs_control)
-			pdata->cs_control(spi, pol);
 	}
+	if (pdata->cs_control)
+		pdata->cs_control(spi, value);
 }
 
 static
-- 
1.6.3.3
