Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 14585DDDF3
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 08:31:16 +1000 (EST)
Date: Fri, 1 May 2009 02:31:14 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] mpc52xx_psc_spi: Convert to cs_control callback
Message-ID: <20090430223114.GA12571@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mpc52xx_psc_spi driver is the last user of the legacy activate_cs
and deactivate_cs callbacks, so convert the driver to the cs_control
hook and remove the legacy callbacks from fsl_spi_platform_data
struct.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/spi/mpc52xx_psc_spi.c |   22 +++++++++-------------
 include/linux/fsl_devices.h   |    4 ----
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index 68c77a9..e1901fd 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -13,6 +13,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/of_platform.h>
@@ -30,8 +31,7 @@
 
 struct mpc52xx_psc_spi {
 	/* fsl_spi_platform data */
-	void (*activate_cs)(u8, u8);
-	void (*deactivate_cs)(u8, u8);
+	void (*cs_control)(struct spi_device *spi, bool on);
 	u32 sysclk;
 
 	/* driver internal data */
@@ -111,18 +111,16 @@ static void mpc52xx_psc_spi_activate_cs(struct spi_device *spi)
 	out_be16((u16 __iomem *)&psc->ccr, ccr);
 	mps->bits_per_word = cs->bits_per_word;
 
-	if (mps->activate_cs)
-		mps->activate_cs(spi->chip_select,
-				(spi->mode & SPI_CS_HIGH) ? 1 : 0);
+	if (mps->cs_control)
+		mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 1 : 0);
 }
 
 static void mpc52xx_psc_spi_deactivate_cs(struct spi_device *spi)
 {
 	struct mpc52xx_psc_spi *mps = spi_master_get_devdata(spi->master);
 
-	if (mps->deactivate_cs)
-		mps->deactivate_cs(spi->chip_select,
-				(spi->mode & SPI_CS_HIGH) ? 1 : 0);
+	if (mps->cs_control)
+		mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 0 : 1);
 }
 
 #define MPC52xx_PSC_BUFSIZE (MPC52xx_PSC_RFNUM_MASK + 1)
@@ -388,15 +386,13 @@ static int __init mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	mps->irq = irq;
 	if (pdata == NULL) {
 		dev_warn(dev, "probe called without platform data, no "
-				"(de)activate_cs function will be called\n");
-		mps->activate_cs = NULL;
-		mps->deactivate_cs = NULL;
+				"cs_control function will be called\n");
+		mps->cs_control = NULL;
 		mps->sysclk = 0;
 		master->bus_num = bus_num;
 		master->num_chipselect = 255;
 	} else {
-		mps->activate_cs = pdata->activate_cs;
-		mps->deactivate_cs = pdata->deactivate_cs;
+		mps->cs_control = pdata->cs_control;
 		mps->sysclk = pdata->sysclk;
 		master->bus_num = pdata->bus_num;
 		master->num_chipselect = pdata->max_chipselect;
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index 244677c..43fc95d 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -79,10 +79,6 @@ struct fsl_spi_platform_data {
 	u16	max_chipselect;
 	void	(*cs_control)(struct spi_device *spi, bool on);
 	u32	sysclk;
-
-	/* Legacy hooks, used by mpc52xx_psc_spi driver. */
-	void	(*activate_cs)(u8 cs, u8 polarity);
-	void	(*deactivate_cs)(u8 cs, u8 polarity);
 };
 
 struct mpc8xx_pcmcia_ops {
-- 
1.6.2.2
