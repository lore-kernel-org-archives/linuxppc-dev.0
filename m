Return-Path: <mhench@engagenet.com>
Received: from owa.engagenet.com (unknown [66.195.150.24])
	by ozlabs.org (Postfix) with ESMTP id 688CCDDDF3
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 23:03:46 +1000 (EST)
Subject: [PATCH] mpc83xx SPI glitch
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 31 Mar 2008 08:04:23 -0500
Message-ID: <6629C06B144F5C4098DFF95C4FF9DAF702BA1FA0@mailsrv.engagenet.com>
From: "Mike Hench" <mhench@engagenet.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

dont write SPMODE reg unless mode changed.
it causes SPI to go hi-z momentarily
which can cause a spike on the CLK line
this is a problem in MMC where /CS is held asserted
across multiple transactions.

Signed-off-by: Mike Hench <mhench@elutions.com>

---

--- linux-2.6.25-rc5.orig/drivers/spi/spi_mpc83xx.c	2008-03-10
00:22:27.000000000 -0500
+++ linux-2.6.25-rc5/drivers/spi/spi_mpc83xx.c	2008-03-31
07:37:37.000000000 -0500
@@ -147,6 +147,7 @@
=20
 	if (value =3D=3D BITBANG_CS_ACTIVE) {
 		u32 regval =3D
mpc83xx_spi_read_reg(&mpc83xx_spi->base->mode);
+		u32 regval0 =3D regval;
 		u32 len =3D spi->bits_per_word;
 		u8 pm;
=20
@@ -188,9 +189,16 @@
 			regval |=3D SPMODE_PM(pm);
 		}
=20
-		/* Turn off SPI unit prior changing mode */
-		mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, 0);
-		mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, regval);
+		// dont write reg unless mode changed.
+		// it causes SPI to go hi-z momentarily
+		// which can cause a spike on the CLK line
+		// this is a problem in MMC where /CS is held asserted
+		// across multiple transactions.
+		if(regval !=3D regval0) {
+			/* Turn off SPI unit prior changing mode */
+			mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode,
0);
+			mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode,
regval);
+		}
 		if (mpc83xx_spi->activate_cs)
 			mpc83xx_spi->activate_cs(spi->chip_select, pol);
 	}
