Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 897BCDE23A
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 01:41:38 +1000 (EST)
Date: Wed, 21 May 2008 19:41:37 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/4] [SPI] spi_mpc83xx: convert to the OF platform driver
Message-ID: <20080521154137.GA4566@polina.dev.rtsoft.ru>
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080521154103.GA32577@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Gary Jennejohn <garyj@denx.de>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch converts the driver to speak OF directly. FSL SPI controllers
do not use internal chip-select machines, so boards must use GPIOs for
these purposes.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |    1 +
 drivers/spi/Kconfig                          |    3 +-
 drivers/spi/spi_mpc83xx.c                    |  279 +++++++++++++++++---------
 3 files changed, 184 insertions(+), 99 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 8545f82..011bf5e 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1607,6 +1607,7 @@ platforms are moved over to use the flattened-device-tree model.
      controller you have.
    - interrupt-parent : the phandle for the interrupt controller that
      services interrupts for this device.
+   - gpios : (optional) may specify GPIOs used for SPI chip-selects
 
    Example:
 	spi@4c0 {
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3f0dcae..4c9afeb 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -129,7 +129,8 @@ config SPI_MPC52xx_PSC
 
 config SPI_MPC83xx
 	tristate "Freescale MPC8xxx SPI controller"
-	depends on SPI_MASTER && FSL_SOC && EXPERIMENTAL
+	depends on SPI_MASTER && OF_GPIO && FSL_SOC && EXPERIMENTAL
+	select SPI_MASTER_OF
 	help
 	  This enables using the Freescale MPC8xxx SPI controllers in master
 	  mode.
diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 6832da6..7ae4096 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -21,11 +21,14 @@
 #include <linux/device.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
-#include <linux/platform_device.h>
-#include <linux/fsl_devices.h>
+#include <linux/spi/spi_of.h>
+#include <linux/of_platform.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
 
 #include <asm/irq.h>
 #include <asm/io.h>
+#include <sysdev/fsl_soc.h>
 
 /* SPI Controller registers */
 struct mpc83xx_spi_reg {
@@ -66,6 +69,11 @@ struct mpc83xx_spi_reg {
 #define	SPIM_NE		0x00000200	/* Not empty */
 #define	SPIM_NF		0x00000100	/* Not full */
 
+enum spi83xx_mode {
+	CPU_MODE = 0,
+	CPU_QE_MODE,
+};
+
 /* SPI Controller driver's private data. */
 struct mpc83xx_spi {
 	struct mpc83xx_spi_reg __iomem *base;
@@ -80,6 +88,7 @@ struct mpc83xx_spi {
 
 	unsigned int count;
 	int irq;
+	unsigned int *gpios;
 
 	unsigned nsecs;		/* (clock cycle time)/2 */
 
@@ -87,10 +96,7 @@ struct mpc83xx_spi {
 	u32 rx_shift;		/* RX data reg shift when in qe mode */
 	u32 tx_shift;		/* TX data reg shift when in qe mode */
 
-	bool qe_mode;
-
-	void (*activate_cs) (u8 cs, u8 polarity);
-	void (*deactivate_cs) (u8 cs, u8 polarity);
+	enum spi83xx_mode mode;
 
 	u8 busy;
 
@@ -151,16 +157,13 @@ MPC83XX_SPI_TX_BUF(u32)
 
 static void mpc83xx_spi_chipselect(struct spi_device *spi, int value)
 {
-	struct mpc83xx_spi *mpc83xx_spi;
 	u8 pol = spi->mode & SPI_CS_HIGH ? 1 : 0;
+	struct mpc83xx_spi *mpc83xx_spi = spi_master_get_devdata(spi->master);
 	struct spi_mpc83xx_cs	*cs = spi->controller_state;
+	unsigned int cs_gpio = mpc83xx_spi->gpios[spi->chip_select];
 
-	mpc83xx_spi = spi_master_get_devdata(spi->master);
-
-	if (value == BITBANG_CS_INACTIVE) {
-		if (mpc83xx_spi->deactivate_cs)
-			mpc83xx_spi->deactivate_cs(spi->chip_select, pol);
-	}
+	if (value == BITBANG_CS_INACTIVE && gpio_is_valid(cs_gpio))
+		gpio_set_value(cs_gpio, !pol);
 
 	if (value == BITBANG_CS_ACTIVE) {
 		u32 regval = mpc83xx_spi_read_reg(&mpc83xx_spi->base->mode);
@@ -184,8 +187,8 @@ static void mpc83xx_spi_chipselect(struct spi_device *spi, int value)
 			mpc83xx_spi_write_reg(tmp_ptr, regval);
 			local_irq_restore(flags);
 		}
-		if (mpc83xx_spi->activate_cs)
-			mpc83xx_spi->activate_cs(spi->chip_select, pol);
+		if (gpio_is_valid(cs_gpio))
+			gpio_set_value(cs_gpio, pol);
 	}
 }
 
@@ -225,14 +228,14 @@ int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	if (bits_per_word <= 8) {
 		cs->get_rx = mpc83xx_spi_rx_buf_u8;
 		cs->get_tx = mpc83xx_spi_tx_buf_u8;
-		if (mpc83xx_spi->qe_mode) {
+		if (mpc83xx_spi->mode == CPU_QE_MODE) {
 			cs->rx_shift = 16;
 			cs->tx_shift = 24;
 		}
 	} else if (bits_per_word <= 16) {
 		cs->get_rx = mpc83xx_spi_rx_buf_u16;
 		cs->get_tx = mpc83xx_spi_tx_buf_u16;
-		if (mpc83xx_spi->qe_mode) {
+		if (mpc83xx_spi->mode == CPU_QE_MODE) {
 			cs->rx_shift = 16;
 			cs->tx_shift = 16;
 		}
@@ -242,7 +245,7 @@ int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	} else
 		return -EINVAL;
 
-	if (mpc83xx_spi->qe_mode && spi->mode & SPI_LSB_FIRST) {
+	if (mpc83xx_spi->mode == CPU_QE_MODE && spi->mode & SPI_LSB_FIRST) {
 		cs->tx_shift = 0;
 		if (bits_per_word <= 8)
 			cs->rx_shift = 8;
@@ -536,92 +539,152 @@ static void mpc83xx_spi_cleanup(struct spi_device *spi)
 	kfree(spi->controller_state);
 }
 
-static int __init mpc83xx_spi_probe(struct platform_device *dev)
+static unsigned int of_num_children(struct device_node *parent)
+{
+	unsigned int count = 0;
+	struct device_node *child = NULL;
+
+	for_each_child_of_node(parent, child)
+		count++;
+
+	return count;
+}
+
+static void __devinit mpc83xx_spi_hwinit(struct mpc83xx_spi *mpc83xx_spi)
 {
+	u32 regval;
+
+	/* SPI controller initializations */
+	mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, 0);
+	mpc83xx_spi_write_reg(&mpc83xx_spi->base->mask, 0);
+	mpc83xx_spi_write_reg(&mpc83xx_spi->base->command, 0);
+	mpc83xx_spi_write_reg(&mpc83xx_spi->base->event, 0xffffffff);
+
+	/* Enable SPI interface */
+	regval = SPMODE_INIT_VAL | SPMODE_ENABLE;
+	if (mpc83xx_spi->mode == CPU_QE_MODE)
+		regval |= SPMODE_OP;
+
+	mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, regval);
+}
+
+static int __devinit mpc83xx_spi_probe(struct of_device *ofdev,
+				       const struct of_device_id *match)
+{
+	struct device *dev = &ofdev->dev;
+	struct device_node *np = ofdev->node;
 	struct spi_master *master;
 	struct mpc83xx_spi *mpc83xx_spi;
-	struct fsl_spi_platform_data *pdata;
-	struct resource *r;
-	u32 regval;
 	int ret = 0;
+	int size;
+	const char *mode;
+	const u32 *bus_num;
+	int i = 0;
+
+	master = spi_alloc_master(dev, sizeof(struct mpc83xx_spi));
+	if (!master)
+		return -ENOMEM;
+	dev_set_drvdata(dev, master);
+	mpc83xx_spi = spi_master_get_devdata(master);
 
-	/* Get resources(memory, IRQ) associated with the device */
-	master = spi_alloc_master(&dev->dev, sizeof(struct mpc83xx_spi));
+	master->setup = mpc83xx_spi_setup;
+	master->transfer = mpc83xx_spi_transfer;
+	master->cleanup = mpc83xx_spi_cleanup;
+	mpc83xx_spi->get_rx = mpc83xx_spi_rx_buf_u8;
+	mpc83xx_spi->get_tx = mpc83xx_spi_tx_buf_u8;
 
-	if (master == NULL) {
+	bus_num = of_get_property(np, "reg", &size);
+	if (!bus_num || size < sizeof(*bus_num)) {
+		dev_err(dev, "unable to get reg property from OF\n");
+		ret = -EINVAL;
+		goto err_bus_num;
+	}
+	master->bus_num = *bus_num;
+
+	master->num_chipselect = of_num_children(np);
+	mpc83xx_spi->gpios = kmalloc(
+		sizeof(mpc83xx_spi->gpios[0]) * master->num_chipselect,
+		GFP_KERNEL);
+	if (!mpc83xx_spi->gpios) {
 		ret = -ENOMEM;
-		goto err;
+		goto err_alloc_gpios;
 	}
 
-	platform_set_drvdata(dev, master);
-	pdata = dev->dev.platform_data;
+	if (master->num_chipselect == 1) {
+		/* no retval check, CS isn't mandatory for single device */
+		mpc83xx_spi->gpios[0] = of_get_gpio(np, 0);
+		i++;
+	}
 
-	if (pdata == NULL) {
-		ret = -ENODEV;
-		goto free_master;
+	for (; i < master->num_chipselect; i++) {
+		mpc83xx_spi->gpios[i] = of_get_gpio(np, i);
+		if (!gpio_is_valid(mpc83xx_spi->gpios[i])) {
+			dev_err(dev, "chipselect %d without GPIO\n", i);
+			goto err_of_get_gpio;
+		}
 	}
 
-	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	if (r == NULL) {
-		ret = -ENODEV;
-		goto free_master;
+	for (i = 0; i < master->num_chipselect; i++) {
+		int gpio = mpc83xx_spi->gpios[i];
+
+		if (!gpio_is_valid(gpio))
+			continue;
+
+		ret = gpio_request(gpio, dev->bus_id);
+		if (ret)
+			goto err_gpio_request;
+
+		ret = gpio_direction_output(gpio, 0);
+		if (ret)
+			goto err_gpio_dir;
 	}
-	master->setup = mpc83xx_spi_setup;
-	master->transfer = mpc83xx_spi_transfer;
-	master->cleanup = mpc83xx_spi_cleanup;
 
-	mpc83xx_spi = spi_master_get_devdata(master);
-	mpc83xx_spi->activate_cs = pdata->activate_cs;
-	mpc83xx_spi->deactivate_cs = pdata->deactivate_cs;
-	mpc83xx_spi->qe_mode = pdata->qe_mode;
-	mpc83xx_spi->get_rx = mpc83xx_spi_rx_buf_u8;
-	mpc83xx_spi->get_tx = mpc83xx_spi_tx_buf_u8;
-	mpc83xx_spi->spibrg = pdata->sysclk;
+#ifdef CONFIG_QUICC_ENGINE
+	mpc83xx_spi->spibrg = get_brgfreq();
+#endif
+	if (!mpc83xx_spi->spibrg || mpc83xx_spi->spibrg == -1) {
+		mpc83xx_spi->spibrg = fsl_get_sys_freq();
+		if (!mpc83xx_spi->spibrg || mpc83xx_spi->spibrg == -1) {
+			dev_err(dev, "unable to get frequency from OF\n");
+			goto err_sysclk;
+		}
+	}
+
+	mode = of_get_property(np, "mode", NULL);
+	if (mode && !strcmp(mode, "cpu-qe"))
+		mpc83xx_spi->mode = CPU_QE_MODE;
 
 	mpc83xx_spi->rx_shift = 0;
 	mpc83xx_spi->tx_shift = 0;
-	if (mpc83xx_spi->qe_mode) {
+	if (mpc83xx_spi->mode == CPU_QE_MODE) {
 		mpc83xx_spi->rx_shift = 16;
 		mpc83xx_spi->tx_shift = 24;
 	}
 
 	init_completion(&mpc83xx_spi->done);
 
-	mpc83xx_spi->base = ioremap(r->start, r->end - r->start + 1);
-	if (mpc83xx_spi->base == NULL) {
+	mpc83xx_spi->base = of_iomap(np, 0);
+	if (!mpc83xx_spi->base) {
+		dev_err(dev, "unable to get memory from OF\n");
 		ret = -ENOMEM;
-		goto put_master;
+		goto err_iomap;
 	}
 
-	mpc83xx_spi->irq = platform_get_irq(dev, 0);
-
-	if (mpc83xx_spi->irq < 0) {
+	mpc83xx_spi->irq = irq_of_parse_and_map(np, 0);
+	if (mpc83xx_spi->irq == NO_IRQ) {
+		dev_err(dev, "unable to get IRQ from OF\n");
 		ret = -ENXIO;
-		goto unmap_io;
+		goto err_irq_parse;
 	}
 
 	/* Register for SPI Interrupt */
 	ret = request_irq(mpc83xx_spi->irq, mpc83xx_spi_irq,
 			  0, "mpc83xx_spi", mpc83xx_spi);
+	if (ret != 0) {
+		dev_err(dev, "unable to request IRQ\n");
+		goto err_irq_request;
+	}
 
-	if (ret != 0)
-		goto unmap_io;
-
-	master->bus_num = pdata->bus_num;
-	master->num_chipselect = pdata->max_chipselect;
-
-	/* SPI controller initializations */
-	mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, 0);
-	mpc83xx_spi_write_reg(&mpc83xx_spi->base->mask, 0);
-	mpc83xx_spi_write_reg(&mpc83xx_spi->base->command, 0);
-	mpc83xx_spi_write_reg(&mpc83xx_spi->base->event, 0xffffffff);
-
-	/* Enable SPI interface */
-	regval = pdata->initial_spmode | SPMODE_INIT_VAL | SPMODE_ENABLE;
-	if (pdata->qe_mode)
-		regval |= SPMODE_OP;
-
-	mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, regval);
 	spin_lock_init(&mpc83xx_spi->lock);
 	init_completion(&mpc83xx_spi->done);
 	INIT_WORK(&mpc83xx_spi->work, mpc83xx_spi_work);
@@ -629,42 +692,53 @@ static int __init mpc83xx_spi_probe(struct platform_device *dev)
 
 	mpc83xx_spi->workqueue = create_singlethread_workqueue(
 		master->dev.parent->bus_id);
-	if (mpc83xx_spi->workqueue == NULL) {
+	if (!mpc83xx_spi->workqueue) {
 		ret = -EBUSY;
-		goto free_irq;
+		goto err_wqueue;
 	}
 
+	mpc83xx_spi_hwinit(mpc83xx_spi);
+
 	ret = spi_register_master(master);
 	if (ret < 0)
-		goto unreg_master;
+		goto err_spi_reg;
+
+	spi_of_register_devices(master, np);
 
 	printk(KERN_INFO
 	       "%s: MPC83xx SPI Controller driver at 0x%p (irq = %d)\n",
-	       dev->dev.bus_id, mpc83xx_spi->base, mpc83xx_spi->irq);
+	       dev->bus_id, mpc83xx_spi->base, mpc83xx_spi->irq);
 
 	return ret;
 
-unreg_master:
+err_spi_reg:
 	destroy_workqueue(mpc83xx_spi->workqueue);
-free_irq:
+err_wqueue:
 	free_irq(mpc83xx_spi->irq, mpc83xx_spi);
-unmap_io:
+err_irq_request:
+	irq_dispose_mapping(mpc83xx_spi->irq);
+err_irq_parse:
 	iounmap(mpc83xx_spi->base);
-put_master:
+err_iomap:
+err_sysclk:
+err_gpio_dir:
+	i++;
+err_gpio_request:
+	while (--i >= 0)
+		gpio_free(mpc83xx_spi->gpios[i]);
+err_of_get_gpio:
+	kfree(mpc83xx_spi->gpios);
+err_alloc_gpios:
+err_bus_num:
 	spi_master_put(master);
-free_master:
-	kfree(master);
-err:
 	return ret;
 }
 
-static int __exit mpc83xx_spi_remove(struct platform_device *dev)
+static int __devexit mpc83xx_spi_remove(struct of_device *ofdev)
 {
-	struct mpc83xx_spi *mpc83xx_spi;
-	struct spi_master *master;
-
-	master = platform_get_drvdata(dev);
-	mpc83xx_spi = spi_master_get_devdata(master);
+	struct spi_master *master = dev_get_drvdata(&ofdev->dev);
+	struct mpc83xx_spi *mpc83xx_spi = spi_master_get_devdata(master);
+	int i = master->num_chipselect;
 
 	flush_workqueue(mpc83xx_spi->workqueue);
 	destroy_workqueue(mpc83xx_spi->workqueue);
@@ -673,29 +747,38 @@ static int __exit mpc83xx_spi_remove(struct platform_device *dev)
 	free_irq(mpc83xx_spi->irq, mpc83xx_spi);
 	iounmap(mpc83xx_spi->base);
 
+	while (--i >= 0)
+		gpio_free(mpc83xx_spi->gpios[i]);
+
 	return 0;
 }
 
-MODULE_ALIAS("platform:mpc83xx_spi");
-static struct platform_driver mpc83xx_spi_driver = {
-	.remove = __exit_p(mpc83xx_spi_remove),
-	.driver = {
-		.name = "mpc83xx_spi",
-		.owner = THIS_MODULE,
+static const struct of_device_id mpc83xx_spi_match[] = {
+	{ .compatible = "fsl,spi", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mpc83xx_spi_match);
+
+static struct of_platform_driver mpc83xx_spi_driver = {
+	.match_table	= mpc83xx_spi_match,
+	.probe		= mpc83xx_spi_probe,
+	.remove		= __devexit_p(mpc83xx_spi_remove),
+	.driver		= {
+		.name	= "mpc83xx_spi",
+		.owner	= THIS_MODULE,
 	},
 };
 
 static int __init mpc83xx_spi_init(void)
 {
-	return platform_driver_probe(&mpc83xx_spi_driver, mpc83xx_spi_probe);
+	return of_register_platform_driver(&mpc83xx_spi_driver);
 }
+module_init(mpc83xx_spi_init);
 
 static void __exit mpc83xx_spi_exit(void)
 {
-	platform_driver_unregister(&mpc83xx_spi_driver);
+	of_unregister_platform_driver(&mpc83xx_spi_driver);
 }
-
-module_init(mpc83xx_spi_init);
 module_exit(mpc83xx_spi_exit);
 
 MODULE_AUTHOR("Kumar Gala");
-- 
1.5.5.1
