Return-Path: <B48286@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DBA872C00A6
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Dec 2013 20:34:44 +1100 (EST)
From: Hou Zhiqiang <b48286@freescale.com>
To: <linux-spi@vger.kernel.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] spi/fsl-espi: Add Power Management support for eSPI controller
Date: Wed, 11 Dec 2013 16:11:51 +0800
Message-ID: <1386749511-21904-1-git-send-email-b48286@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Mingkai.Hu@freescale.com, broonie@kernel.org,
 Hou Zhiqiang <b48286@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add PM support for eSPI controller using callback function suspend
and resume in .driver of platform_driver.

Signed-off-by: Hou Zhiqiang <b48286@freescale.com>
---
 drivers/spi/spi-fsl-espi.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 8106006..9c3fe70 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -727,6 +727,59 @@ static int of_fsl_espi_remove(struct platform_device *dev)
 	return mpc8xxx_spi_remove(&dev->dev);
 }
 
+#ifdef CONFIG_PM
+static int of_fsl_espi_suspend(struct device *dev, pm_message_t state)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct mpc8xxx_spi *mpc8xxx_spi;
+	struct fsl_espi_reg *reg_base;
+	u32 regval;
+
+	mpc8xxx_spi = spi_master_get_devdata(master);
+	reg_base = mpc8xxx_spi->reg_base;
+
+	regval = mpc8xxx_spi_read_reg(&reg_base->mode);
+	regval &= ~(SPMODE_ENABLE);
+	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
+
+	regval = mpc8xxx_spi_read_reg(&reg_base->mode);
+
+	return 0;
+}
+
+static int of_fsl_espi_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct mpc8xxx_spi *mpc8xxx_spi;
+	struct fsl_espi_reg *reg_base;
+	u32 regval;
+	int i;
+
+	mpc8xxx_spi = spi_master_get_devdata(master);
+	reg_base = mpc8xxx_spi->reg_base;
+
+	/* SPI controller initializations */
+	mpc8xxx_spi_write_reg(&reg_base->mode, 0);
+	mpc8xxx_spi_write_reg(&reg_base->mask, 0);
+	mpc8xxx_spi_write_reg(&reg_base->command, 0);
+	mpc8xxx_spi_write_reg(&reg_base->event, 0xffffffff);
+
+	/* Init eSPI CS mode register */
+	for (i = 0; i < pdata->max_chipselect; i++)
+		mpc8xxx_spi_write_reg(&reg_base->csmode[i], CSMODE_INIT_VAL);
+
+	/* Enable SPI interface */
+	regval = pdata->initial_spmode | SPMODE_INIT_VAL | SPMODE_ENABLE;
+
+	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
+
+	return 0;
+}
+#endif /* CONFIG_PM */
+
 static const struct of_device_id of_fsl_espi_match[] = {
 	{ .compatible = "fsl,mpc8536-espi" },
 	{}
@@ -738,6 +791,10 @@ static struct platform_driver fsl_espi_driver = {
 		.name = "fsl_espi",
 		.owner = THIS_MODULE,
 		.of_match_table = of_fsl_espi_match,
+#ifdef CONFIG_PM
+		.suspend	= of_fsl_espi_suspend,
+		.resume		= of_fsl_espi_resume,
+#endif
 	},
 	.probe		= of_fsl_espi_probe,
 	.remove		= of_fsl_espi_remove,
-- 
1.8.4.1
