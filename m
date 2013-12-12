Return-Path: <B48286@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 944FE2C00AC
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Dec 2013 17:17:05 +1100 (EST)
From: Hou Zhiqiang <b48286@freescale.com>
To: <linux-spi@vger.kernel.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH v2] spi/fsl-espi: Add Power Management support for eSPI
 controller
Date: Thu, 12 Dec 2013 12:53:52 +0800
Message-ID: <1386824032-19198-1-git-send-email-b48286@freescale.com>
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
and resume in .driver.pm of platform_driver.

Signed-off-by: Hou Zhiqiang <b48286@freescale.com>
---
v2:
 - Replace .driver.suspend and .driver.resume with .driver.pm
 - Use CONFIG_PM_SLEEP instead of CONFIG_PM
 - Add spi_master_suspend and spi_master_resume

 drivers/spi/spi-fsl-espi.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 8106006..428dc7a 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -727,6 +727,66 @@ static int of_fsl_espi_remove(struct platform_device *dev)
 	return mpc8xxx_spi_remove(&dev->dev);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int of_fsl_espi_suspend(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct mpc8xxx_spi *mpc8xxx_spi;
+	struct fsl_espi_reg *reg_base;
+	u32 regval;
+	int ret;
+
+	mpc8xxx_spi = spi_master_get_devdata(master);
+	reg_base = mpc8xxx_spi->reg_base;
+
+	ret = spi_master_suspend(master);
+	if (ret) {
+		dev_warn(dev, "cannot suspend master\n");
+		return ret;
+	}
+
+	regval = mpc8xxx_spi_read_reg(&reg_base->mode);
+	regval &= ~SPMODE_ENABLE;
+	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
+
+	return 0;
+}
+
+static int of_fsl_espi_resume(struct device *dev)
+{
+	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
+	struct spi_master *master = dev_get_drvdata(dev);
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
+	return spi_master_resume(master);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops espi_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(of_fsl_espi_suspend, of_fsl_espi_resume)
+};
+
 static const struct of_device_id of_fsl_espi_match[] = {
 	{ .compatible = "fsl,mpc8536-espi" },
 	{}
@@ -738,6 +798,7 @@ static struct platform_driver fsl_espi_driver = {
 		.name = "fsl_espi",
 		.owner = THIS_MODULE,
 		.of_match_table = of_fsl_espi_match,
+		.pm = &espi_pm,
 	},
 	.probe		= of_fsl_espi_probe,
 	.remove		= of_fsl_espi_remove,
-- 
1.8.4.1
