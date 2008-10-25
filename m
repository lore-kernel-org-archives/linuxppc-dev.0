Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 3F21CDDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 15:30:14 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH v2] spi: Add PPC4xx SPI driver
Date: Sat, 25 Oct 2008 06:30:04 +0200
Message-Id: <1224909004-18756-1-git-send-email-sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, weo@reccoware.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds a SPI driver for the SPI controller found in the IBM/AMCC
4xx PowerPC's.

Signed-off-by: Stefan Roese <sr@denx.de>
---
Changes in v2:
- Now the gpios property is correctly decoded and the
  resulting gpio numbers are used as the devices chip
  selects.

  So we can describe the SPI node like this:

	SPI0: spi@ef600900 {
		#address-cells = <1>;
		#size-cells = <0>;
		...

		/* two GPIOs, representing two chip selects: 0 and 1 */
		gpios = <&GPIO0 5 0 &GPIO1 16 0>;

		mmc-slot@0 {
			reg = <0>;
			...
		};

		touchscreen@1 {
			reg = <1>;
			...
		};
	}

Special thanks to Wolfgang Ocker and Anton Vorontsov for their input.

 drivers/spi/Kconfig      |    7 +
 drivers/spi/Makefile     |    1 +
 drivers/spi/spi_ppc4xx.c |  583 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 591 insertions(+), 0 deletions(-)
 create mode 100644 drivers/spi/spi_ppc4xx.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b9d0efb..69d5fee 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -155,6 +155,13 @@ config SPI_ORION
 	help
 	  This enables using the SPI master controller on the Orion chips.
 
+config SPI_PPC4xx
+	tristate "PPC4xx SPI Controller"
+	depends on 4xx && SPI_MASTER
+	select SPI_BITBANG
+	help
+	  This selects a driver for the PPC4xx SPI Controller.
+
 config SPI_PXA2XX
 	tristate "PXA2xx SSP SPI master"
 	depends on ARCH_PXA && EXPERIMENTAL
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index ccf18de..a2e5816 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_SPI_OMAP24XX)		+= omap2_mcspi.o
 obj-$(CONFIG_SPI_ORION)			+= orion_spi.o
 obj-$(CONFIG_SPI_MPC52xx_PSC)		+= mpc52xx_psc_spi.o
 obj-$(CONFIG_SPI_MPC83xx)		+= spi_mpc83xx.o
+obj-$(CONFIG_SPI_PPC4xx)		+= spi_ppc4xx.o
 obj-$(CONFIG_SPI_S3C24XX_GPIO)		+= spi_s3c24xx_gpio.o
 obj-$(CONFIG_SPI_S3C24XX)		+= spi_s3c24xx.o
 obj-$(CONFIG_SPI_TXX9)			+= spi_txx9.o
diff --git a/drivers/spi/spi_ppc4xx.c b/drivers/spi/spi_ppc4xx.c
new file mode 100644
index 0000000..979a8c1
--- /dev/null
+++ b/drivers/spi/spi_ppc4xx.c
@@ -0,0 +1,583 @@
+/*
+ * SPI_PPC4XX SPI controller driver.
+ *
+ * Copyright (C) 2007 Gary Jennejohn <garyj@denx.de>
+ * Copyright 2008 Stefan Roese <sr@denx.de>, DENX Software Engineering
+ *
+ * Based in part on drivers/spi/spi_s3c24xx.c
+ *
+ * Copyright (c) 2006 Ben Dooks
+ * Copyright (c) 2006 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/wait.h>
+#include <linux/of_platform.h>
+#include <linux/of_spi.h>
+#include <linux/of_gpio.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+
+#include <linux/gpio.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+
+#include <asm/io.h>
+#include <asm/dcr-native.h>
+#include <asm/dcr-regs.h>
+
+/* bits in mode register - bit 0 ist MSb */
+/* data latched on leading edge of clock, else trailing edge */
+#define SPI_PPC4XX_MODE_SCP	(0x80 >> 3)
+/* port enabled */
+#define SPI_PPC4XX_MODE_SPE	(0x80 >> 4)
+/* MSB first, else LSB first */
+#define SPI_PPC4XX_MODE_RD	(0x80 >> 5)
+/* clock invert - idle clock = 1, active clock = 0; else reversed */
+#define SPI_PPC4XX_MODE_CI	(0x80 >> 6)
+/* loopback enable */
+#define SPI_PPC4XX_MODE_IL	(0x80 >> 7)
+/* bits in control register */
+/* starts a transfer when set */
+#define SPI_PPC4XX_CR_STR	(0x80 >> 7)
+/* bits in status register */
+/* port is busy with a transfer */
+#define SPI_PPC4XX_SR_BSY	(0x80 >> 6)
+/* RxD ready */
+#define SPI_PPC4XX_SR_RBR	(0x80 >> 7)
+
+/* the spi->mode bits understood by this driver: */
+#define MODEBITS	(SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST)
+
+/* clock settings (SCP and CI) for various SPI modes */
+#define SPI_CLK_MODE0	SPI_PPC4XX_MODE_SCP
+#define SPI_CLK_MODE1	0
+#define SPI_CLK_MODE2	SPI_PPC4XX_MODE_CI
+#define SPI_CLK_MODE3	(SPI_PPC4XX_MODE_SCP | SPI_PPC4XX_MODE_CI)
+
+#define DRIVER_NAME	"spi_ppc4xx_of"
+
+struct spi_ppc4xx_regs {
+	u8 mode;
+	u8 rxd;
+	u8 txd;
+	u8 cr;
+	u8 sr;
+	u8 dummy;
+	/*
+	 * Clock divisor modulus register
+	 * This uses the follwing formula:
+	 *    SCPClkOut = OPBCLK/(4(CDM + 1))
+	 * or
+	 *    CDM = (OPBCLK/4*SCPClkOut) - 1
+	 * bit 0 is the MSb!
+	 */
+	u8 cdm;
+};
+
+/* SPI Controller driver's private data. */
+struct ppc4xx_spi {
+	/* bitbang has to be first */
+	struct spi_bitbang bitbang;
+	struct completion done;
+
+	u64 mapbase;
+	u64 mapsize;
+	int irqnum;
+	/* need this to set the SPI clock */
+	unsigned int opb_freq;
+
+	/* for transfers */
+	int len;
+	int count;
+	/* data buffers */
+	const unsigned char *tx;
+	unsigned char *rx;
+
+	int *gpios;
+	unsigned int num_gpios;
+
+	volatile struct spi_ppc4xx_regs __iomem *regs; /* pointer to the registers */
+	struct spi_master *master;
+	struct device *dev;
+};
+
+/* need this so we can set the clock in the chipselect routine */
+struct spi_ppc4xx_cs {
+	/* speed in hertz */
+	u32 speed_hz;
+	/* bits per word - must be 8! */
+	u8  bpw;
+};
+
+static int spi_ppc4xx_txrx(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct ppc4xx_spi *hw;
+	u8 data;
+
+	dev_dbg(&spi->dev, "txrx: tx %p, rx %p, len %d\n",
+		t->tx_buf, t->rx_buf, t->len);
+
+	hw = spi_master_get_devdata(spi->master);
+
+	hw->tx = t->tx_buf;
+	hw->rx = t->rx_buf;
+	hw->len = t->len;
+	hw->count = 0;
+
+	/* send the first byte */
+	data = hw->tx ? hw->tx[0] : 0;
+	out_8(&hw->regs->txd, data);
+	out_8(&hw->regs->cr, SPI_PPC4XX_CR_STR);
+	wait_for_completion(&hw->done);
+
+	return hw->count;
+}
+
+static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct ppc4xx_spi *hw = spi_master_get_devdata(spi->master);
+	struct spi_ppc4xx_cs *cs = spi->controller_state;
+	unsigned char cdm = 0;
+	int scr;
+
+	if (cs == NULL) {
+		cs = kzalloc(sizeof(*cs), GFP_KERNEL);
+		if (!cs)
+			return -ENOMEM;
+		spi->controller_state = cs;
+	}
+
+	/*
+	 * Allow platform reduce the interrupt load on the CPU during SPI
+	 * transfers. We do not target maximum performance, but rather allow
+	 * platform to limit SPI bus frequency and interrupt rate.
+	 */
+	cs->bpw = t ? t->bits_per_word : spi->bits_per_word;
+	cs->speed_hz = t ? min(t->speed_hz, spi->max_speed_hz) :
+		spi->max_speed_hz;
+
+	if (cs->bpw != 8) {
+		dev_err(&spi->dev, "invalid bits-per-word (%d)\n", cs->bpw);
+		return -EINVAL;
+	}
+
+	if (cs->speed_hz == 0) {
+		dev_err(&spi->dev, "invalid speed_hz (must be non-zero)\n");
+		return -EINVAL;
+	}
+
+	/* set the clock */
+	/* opb_freq was already divided by 4 */
+	scr = (hw->opb_freq / cs->speed_hz) - 1;
+
+	if (scr > 0)
+		cdm = min(scr, 0xff);
+
+	dev_dbg(&spi->dev, "setting pre-scaler to %d (hz %d)\n", cdm,
+		cs->speed_hz);
+
+	if (in_8(&hw->regs->cdm) != cdm)
+		out_8(&hw->regs->cdm, cdm);
+
+	spin_lock(&hw->bitbang.lock);
+	if (!hw->bitbang.busy) {
+		hw->bitbang.chipselect(spi, BITBANG_CS_INACTIVE);
+		/* need to ndelay here? */
+	}
+	spin_unlock(&hw->bitbang.lock);
+
+	return 0;
+}
+
+static int spi_ppc4xx_setup(struct spi_device *spi)
+{
+	struct ppc4xx_spi *hw = spi_master_get_devdata(spi->master);
+	int ret;
+	struct spi_ppc4xx_cs *cs = spi->controller_state;
+	unsigned char mode;
+
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+
+	if (spi->mode & ~MODEBITS) {
+		dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
+			spi->mode & ~MODEBITS);
+		return -EINVAL;
+	}
+
+	if (cs == NULL) {
+		cs = kzalloc(sizeof *cs, GFP_KERNEL);
+		if (!cs)
+			return -ENOMEM;
+		spi->controller_state = cs;
+	}
+
+	ret = spi_ppc4xx_setupxfer(spi, NULL);
+	if (ret < 0) {
+		dev_err(&spi->dev, "setupxfer returned %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * We set all bits of the SPI0_MODE register, so,
+	 * no need to read-modify-write
+	 */
+	mode = SPI_PPC4XX_MODE_SPE;
+
+	switch (spi->mode & (SPI_CPHA | SPI_CPOL)) {
+	case SPI_MODE_0:
+		mode |= SPI_CLK_MODE0;
+		break;
+	case SPI_MODE_1:
+		mode |= SPI_CLK_MODE1;
+		break;
+	case SPI_MODE_2:
+		mode |= SPI_CLK_MODE2;
+		break;
+	case SPI_MODE_3:
+		mode |= SPI_CLK_MODE3;
+		break;
+	}
+
+	if (spi->mode & SPI_LSB_FIRST) {
+		/* this assumes that bit 7 is the LSb! */
+		mode |= SPI_PPC4XX_MODE_RD;
+	}
+
+	/* write new configration */
+	out_8(&hw->regs->mode, mode);
+
+	dev_dbg(&spi->dev, "%s: mode %d, %u bpw, %d hz\n",
+		__FUNCTION__, spi->mode, spi->bits_per_word,
+		spi->max_speed_hz);
+
+	return 0;
+}
+
+static void spi_ppc4xx_chipsel(struct spi_device *spi, int value)
+{
+	struct ppc4xx_spi *hw = spi_master_get_devdata(spi->master);
+	unsigned int cspol = spi->mode & SPI_CS_HIGH ? 1 : 0;
+	unsigned int cs = spi->chip_select;
+
+	if (!hw->num_gpios)
+		return;
+
+	if (cs >= hw->num_gpios)
+		return;
+
+	if (value != BITBANG_CS_INACTIVE && value != BITBANG_CS_ACTIVE)
+		return;
+
+	if (value == BITBANG_CS_INACTIVE)
+		cspol = !cspol;
+
+	gpio_set_value(hw->gpios[cs], cspol);
+}
+
+static irqreturn_t spi_ppc4xx_int(int irq, void *dev_id)
+{
+	struct ppc4xx_spi *hw;
+	u8 status;
+	u8 data;
+	unsigned int count;
+
+	hw = (struct ppc4xx_spi *)dev_id;
+
+	status = in_8(&hw->regs->sr);
+	if (!status)
+		return IRQ_NONE;
+
+	/* should never happen but check anyway */
+	if (status & SPI_PPC4XX_SR_BSY) {
+		u8 lstatus;
+		int cnt = 0;
+
+		dev_dbg(hw->dev, "got interrupt but spi still busy?\n");
+		do {
+			ndelay(10);
+			lstatus = in_8(&hw->regs->sr);
+		} while (++cnt < 100 && lstatus & SPI_PPC4XX_SR_BSY);
+
+		if (cnt >= 100) {
+			dev_err(hw->dev, "busywait: too many loops!\n");
+			complete(&hw->done);
+			return IRQ_HANDLED;
+		} else {
+			/* status is always 1 (RBR) here */
+			status = in_8(&hw->regs->sr);
+			dev_dbg(hw->dev, "loops %d status %x\n", cnt, status);
+		}
+	}
+
+	count = hw->count;
+	hw->count++;
+
+	if (status & SPI_PPC4XX_SR_RBR) {
+		/* Data Ready */
+		data = in_8(&hw->regs->rxd);
+		if (hw->rx)
+			hw->rx[count] = data;
+	}
+
+	count++;
+
+	if (count < hw->len) {
+		data = hw->tx ? hw->tx[count] : 0;
+		out_8(&hw->regs->txd, data);
+		out_8(&hw->regs->cr, SPI_PPC4XX_CR_STR);
+	} else {
+		complete(&hw->done);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void spi_ppc4xx_cleanup(struct spi_device *spi)
+{
+	kfree(spi->controller_state);
+}
+
+static void spi_ppc4xx_enable(struct ppc4xx_spi *hw)
+{
+	/*
+	 * On all 4xx PPC's the SPI bus is shared/multiplexed with
+	 * the 2nd I2C bus. We need to enable the the SPI bus before
+	 * using it.
+	 */
+
+	/* need to clear bit 14 to enable SPC */
+	dcri_clrset(SDR0, SDR0_PFC1, 0x80000000 >> 14, 0);
+}
+
+unsigned int of_num_gpios(struct device_node *node)
+{
+	unsigned int num = 0;
+
+	while (gpio_is_valid(of_get_gpio(node, num)))
+		num++;
+	return num;
+}
+
+/*
+ * of_device layer stuff...
+ */
+static int __init spi_ppc4xx_of_probe(struct of_device *op,
+				      const struct of_device_id *match)
+{
+	struct ppc4xx_spi *hw;
+	struct spi_master *master;
+	struct spi_bitbang *bbp;
+	struct resource resource;
+	struct device_node *np = op->node;
+	struct device *dev = &op->dev;
+	struct device_node *opbnp;
+	int ret;
+	const unsigned int *clk;
+
+	master = spi_alloc_master(dev, sizeof *hw);
+	if (master == NULL)
+		return -ENOMEM;
+	dev_set_drvdata(dev, master);
+	hw = spi_master_get_devdata(master);
+	memset(hw, 0, sizeof(struct ppc4xx_spi));
+
+	hw->master = spi_master_get(master);
+	hw->dev = dev;
+
+	init_completion(&hw->done);
+
+	hw->num_gpios = of_num_gpios(np);
+	if (hw->num_gpios) {
+		int i;
+
+		hw->gpios = kzalloc(sizeof(int) * hw->num_gpios,
+				    GFP_KERNEL);
+		if (!hw->gpios) {
+			ret = -ENOMEM;
+			goto free_master;
+		}
+
+		for (i = 0; i < hw->num_gpios; i++) {
+			int gpio = of_get_gpio(np, i);
+			if (gpio < 0) {
+				dev_err(dev, "Invalid gpio spec %d\n", i);
+				ret = gpio;
+				goto free_gpios;
+			}
+
+			ret = gpio_request(gpio, np->name);
+			if (ret < 0) {
+				dev_err(dev, "gpio %d already in use\n", i);
+				ret = gpio;
+				goto free_gpios;
+			}
+
+			gpio_direction_output(gpio, 0);
+			hw->gpios[i] = gpio;
+		}
+	}
+
+	/* Setup the state for the bitbang driver */
+	bbp = &hw->bitbang;
+	bbp->master = hw->master;
+	bbp->setup_transfer = spi_ppc4xx_setupxfer;
+	bbp->chipselect = spi_ppc4xx_chipsel;
+	bbp->txrx_bufs = spi_ppc4xx_txrx;
+	bbp->use_dma = 0;
+	bbp->master->setup = spi_ppc4xx_setup;
+	bbp->master->cleanup = spi_ppc4xx_cleanup;
+	/* only one SPI controller */
+	bbp->master->bus_num = 0;
+	if (bbp->master->num_chipselect == 0) {
+		/* this many pins in al GPIO controllers */
+		bbp->master->num_chipselect = hw->num_gpios;
+	}
+
+	/* Get the clock for the OPB */
+	opbnp = of_find_compatible_node(NULL, NULL, "ibm,opb");
+	if (opbnp == NULL) {
+		dev_err(dev, "OPB: cannot find node\n");
+		ret = -ENODEV;
+		goto free_gpios;
+	}
+	/* Get the clock (Hz) for the OPB */
+	clk = of_get_property(opbnp, "clock-frequency", NULL);
+	if (clk == NULL) {
+		dev_err(dev, "OPB: no clock-frequency property set\n");
+		of_node_put(opbnp);
+		ret = -ENODEV;
+		goto free_gpios;
+	}
+	hw->opb_freq = *clk;
+	hw->opb_freq >>= 2;
+	of_node_put(opbnp);
+
+	ret = of_address_to_resource(np, 0, &resource);
+	if (ret) {
+		dev_err(dev, "error while parsing device node resource\n");
+		goto free_gpios;
+	}
+	hw->mapbase = resource.start;
+	hw->mapsize = resource.end - resource.start + 1;
+
+	/* Sanity check */
+	if (hw->mapsize < sizeof(struct spi_ppc4xx_regs)) {
+		dev_err(dev, "too small to map registers\n");
+		ret = -EINVAL;
+		goto free_gpios;
+	}
+
+	/* Request IRQ */
+	hw->irqnum = irq_of_parse_and_map(np, 0);
+	ret = request_irq(hw->irqnum, spi_ppc4xx_int,
+			  IRQF_DISABLED, "spi_ppc4xx_of", (void *)hw);
+	if (ret) {
+		dev_err(dev, "unable to allocate interrupt\n");
+		goto free_gpios;
+	}
+
+	if (!request_mem_region(hw->mapbase, hw->mapsize, DRIVER_NAME)) {
+		dev_err(dev, "resource unavailable\n");
+		ret = -EBUSY;
+		goto request_mem_error;
+	}
+
+	hw->regs = ioremap(hw->mapbase, sizeof(struct spi_ppc4xx_regs));
+
+	if (!hw->regs) {
+		dev_err(dev, "unable to memory map registers\n");
+		ret = -ENXIO;
+		goto map_io_error;
+	}
+
+	spi_ppc4xx_enable(hw);
+
+	/* Finally register our spi controller */
+	dev->dma_mask = 0;
+	ret = spi_bitbang_start(bbp);
+	if (ret) {
+		dev_err(dev, "failed to register SPI master\n");
+		goto unmap_regs;
+	}
+
+	dev_info(dev, "driver initialized\n");
+	of_register_spi_devices(master, np);
+
+	return 0;
+
+unmap_regs:
+	iounmap(hw->regs);
+map_io_error:
+	release_mem_region(hw->mapbase, hw->mapsize);
+request_mem_error:
+	free_irq(hw->irqnum, hw);
+free_gpios:
+	kfree(hw->gpios);
+free_master:
+	dev_set_drvdata(dev, NULL);
+	spi_master_put(master);
+
+	dev_err(dev, "initialization failed\n");
+	return ret;
+}
+
+static int __exit spi_ppc4xx_of_remove(struct of_device *op)
+{
+	struct spi_master *master = dev_get_drvdata(&op->dev);
+	struct ppc4xx_spi *hw;
+
+	hw = spi_master_get_devdata(master);
+	spi_bitbang_stop(&hw->bitbang);
+	dev_set_drvdata(&op->dev, NULL);
+	release_mem_region(hw->mapbase, hw->mapsize);
+	free_irq(hw->irqnum, hw);
+	iounmap(hw->regs);
+
+	return 0;
+}
+
+static struct of_device_id spi_ppc4xx_of_match[] = {
+	{ .compatible = "ibm,spi", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, spi_ppc4xx_of_match);
+
+static struct of_platform_driver spi_ppc4xx_of_driver = {
+	.owner = THIS_MODULE,
+	.name = DRIVER_NAME,
+	.match_table = spi_ppc4xx_of_match,
+	.probe = spi_ppc4xx_of_probe,
+	.remove = __exit_p(spi_ppc4xx_of_remove),
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init spi_ppc4xx_init(void)
+{
+	return of_register_platform_driver(&spi_ppc4xx_of_driver);
+}
+
+static void __exit spi_ppc4xx_exit(void)
+{
+	of_unregister_platform_driver(&spi_ppc4xx_of_driver);
+}
+
+module_init(spi_ppc4xx_init);
+module_exit(spi_ppc4xx_exit);
+
+MODULE_AUTHOR("Gary Jennejohn & Stefan Roese");
+MODULE_DESCRIPTION("Simple PPC4xx SPI Driver");
+MODULE_LICENSE("GPL");
-- 
1.6.0.3
