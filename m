Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 9D0A6DDDF7
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jun 2007 23:59:35 +1000 (EST)
Message-ID: <4666BF47.8080103@ru.mvista.com>
Date: Wed, 06 Jun 2007 18:05:59 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH] Simple driver for Xilinx SPI controler.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Only master mode is supported.
No support for multiple masters. Slave mode is not supported either.
Not using level 1 drivers from EDK.

The reason not to use EDK is basically this driver being a simple one:
- SPI level 1 driver from EDK supports much more then needed for this
   simple version of the SPI driver (slave mode, multiple masters etc).
   And leaving just single master case alone is not possible without
   changing the level 1 driver.
- SPI level 1 driver from EDK manipulates chip selects on its own.
   This makes it impossible to use the spi_bitbang.

The driver has been tested with Xilinx ML300 reference design.

The patch to enable SPI for Xilinx ML300 board (EDK reference design)
will be sent to linuxppc-embedded list shortly.

Would be nice to get this driver into mainline.
Reviews and comments are welcome.

Thanks,
Andrei

Signed-off-by: Yuri Frolov <yfrolov@ru.mvista.com>
Signed-off-by: Andrei Konovalov <akonovalov@ru.mvista.com>
---
  arch/ppc/syslib/virtex_devices.h |    6 +
  drivers/spi/Kconfig              |    9 +
  drivers/spi/Makefile             |    1 +
  drivers/spi/xilinx_spi.c         |  447 ++++++++++++++++++++++++++++++++++++++
  4 files changed, 463 insertions(+), 0 deletions(-)
  create mode 100644 drivers/spi/xilinx_spi.c

diff --git a/arch/ppc/syslib/virtex_devices.h b/arch/ppc/syslib/virtex_devices.h
index b49dc61..9ab3152 100644
--- a/arch/ppc/syslib/virtex_devices.h
+++ b/arch/ppc/syslib/virtex_devices.h
@@ -45,4 +45,10 @@ struct xtemac_platform_data {
  	u8 mac_addr[6];
  };

+/* SPI Controller IP */
+struct xspi_platform_data {
+	s16 bus_num;
+	u16 num_chipselect;
+};
+
  #endif  /* __ASM_VIRTEX_DEVICES_H__ */
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 5e3f748..851d651 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -156,6 +156,15 @@ config SPI_S3C24XX_GPIO
  	  GPIO lines to provide the SPI bus. This can be used where
  	  the inbuilt hardware cannot provide the transfer mode, or
  	  where the board is using non hardware connected pins.
+
+config SPI_XILINX
+	tristate "Xilinx SPI controller"
+	depends on SPI_MASTER && XILINX_VIRTEX && EXPERIMENTAL
+	select SPI_BITBANG
+	help
+	  This enables using the SPI controller IP from Xilinx EDK in master
+	  mode. See the DS464, "OPB Serial Peripheral Interface (SPI) (v1.00e)"
+	  Product Specification document for the hardware details.
  #
  # Add new SPI master controllers in alphabetical order above this line
  #
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 5788d86..a2412bd 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_SPI_MPC52xx_PSC)		+= mpc52xx_psc_spi.o
  obj-$(CONFIG_SPI_MPC83xx)		+= spi_mpc83xx.o
  obj-$(CONFIG_SPI_S3C24XX_GPIO)		+= spi_s3c24xx_gpio.o
  obj-$(CONFIG_SPI_S3C24XX)		+= spi_s3c24xx.o
+obj-$(CONFIG_SPI_XILINX)		+= xilinx_spi.o
  # 	... add above this line ...

  # SPI protocol drivers (device/link on bus)
diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
new file mode 100644
index 0000000..e5f149f
--- /dev/null
+++ b/drivers/spi/xilinx_spi.c
@@ -0,0 +1,447 @@
+/*
+ * xilinx_spi.c
+ *
+ * Xilinx SPI controler driver (master mode only)
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * 2002-2007 (c) MontaVista Software, Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2.  This program is licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+
+#include <asm/io.h>
+#include <syslib/virtex_devices.h>
+
+#define XILINX_SPI_NAME "xspi"
+
+/* Register definitions as per "OPB Serial Peripheral Interface (SPI) (v1.00e)
+ * Product Specification", DS464
+ */
+#define XSPI_CR_OFFSET		0x62	/* 16-bit Control Register */
+
+#define XSPI_CR_ENABLE		0x02
+#define XSPI_CR_MASTER_MODE	0x04
+#define XSPI_CR_CPOL		0x08
+#define XSPI_CR_CPHA		0x10
+#define XSPI_CR_MODE_MASK	(XSPI_CR_CPHA | XSPI_CR_CPOL)
+#define XSPI_CR_TXFIFO_RESET	0x20
+#define XSPI_CR_RXFIFO_RESET	0x40
+#define XSPI_CR_MANUAL_SSELECT	0x80
+#define XSPI_CR_TRANS_INHIBIT	0x100
+
+#define XSPI_SR_OFFSET		0x67	/* 8-bit Status Register */
+
+#define XSPI_SR_RX_EMPTY_MASK	0x01	/* Receive FIFO is empty */
+#define XSPI_SR_RX_FULL_MASK	0x02	/* Receive FIFO is full */
+#define XSPI_SR_TX_EMPTY_MASK	0x04	/* Transmit FIFO is empty */
+#define XSPI_SR_TX_FULL_MASK	0x08	/* Transmit FIFO is full */
+#define XSPI_SR_MODE_FAULT_MASK	0x10	/* Mode fault error */
+
+#define XSPI_TXD_OFFSET		0x6b	/* 8-bit Data Transmit Register */
+#define XSPI_RXD_OFFSET		0x6f	/* 8-bit Data Receive Register */
+
+#define XSPI_SSR_OFFSET		0x70	/* 32-bit Slave Select Register */
+
+/* Register definitions as per "OPB IPIF (v3.01c) Product Specification", DS414
+ * IPIF registers are 32 bit
+ */
+#define XIPIF_V123B_DGIER_OFFSET	0x1c	/* IPIF global int enable reg */
+#define XIPIF_V123B_GINTR_ENABLE	0x80000000
+
+#define XIPIF_V123B_IISR_OFFSET		0x20	/* IPIF interrupt status reg */
+#define XIPIF_V123B_IIER_OFFSET		0x28	/* IPIF interrupt enable reg */
+
+#define XSPI_INTR_MODE_FAULT		0x01	/* Mode fault error */
+#define XSPI_INTR_SLAVE_MODE_FAULT	0x02	/* Selected as slave while
+                                                * disabled */
+#define XSPI_INTR_TX_EMPTY		0x04	/* TxFIFO is empty */
+#define XSPI_INTR_TX_UNDERRUN		0x08	/* TxFIFO was underrun */
+#define XSPI_INTR_RX_FULL		0x10	/* RxFIFO is full */
+#define XSPI_INTR_RX_OVERRUN		0x20	/* RxFIFO was overrun */
+
+#define XIPIF_V123B_RESETR_OFFSET	0x40	/* IPIF reset register */
+#define XIPIF_V123B_RESET_MASK		0x0a	/* the value to write */
+
+/* Simple macros to get the code more readable */
+#define xspi_in16(addr)		in_be16((u16 __iomem *)(addr))
+#define xspi_in32(addr)		in_be32((u32 __iomem *)(addr))
+#define xspi_out16(addr, value)	out_be16((u16 __iomem *)(addr), (value))
+#define xspi_out32(addr, value)	out_be32((u32 __iomem *)(addr), (value))
+
+struct xilinx_spi {
+	/* bitbang has to be first */
+	struct spi_bitbang bitbang;
+	struct completion done;
+
+	u32		regs_phys;	/* phys. address of the control registers */
+	void __iomem	*regs;		/* virt. address of the control registers */
+
+	u32 irq;
+
+	u8 *rx_ptr;		/* pointer in the Tx buffer */
+	const u8 *tx_ptr;	/* pointer in the Rx buffer */
+	int remaining_bytes;	/* the number of bytes left to transfer */
+};
+
+static void xspi_abort_transfer(u8 __iomem *regs_base)
+{
+	/* Deselect the slave on the SPI bus */
+	xspi_out32(regs_base + XSPI_SSR_OFFSET, 0xffff);
+
+	/* Terminate transmit in progress (if any) and Reset the FIFOs */
+	xspi_out16(regs_base + XSPI_CR_OFFSET,
+		   xspi_in16(regs_base + XSPI_CR_OFFSET)
+		   | XSPI_CR_TRANS_INHIBIT | XSPI_CR_TXFIFO_RESET
+		   | XSPI_CR_RXFIFO_RESET);
+}
+
+static void xspi_init_hw(u8 __iomem *regs_base)
+{
+	/* Reset the SPI device */
+	xspi_out32(regs_base + XIPIF_V123B_RESETR_OFFSET,
+		   XIPIF_V123B_RESET_MASK);
+	/* Disable all the interrupts just in case */
+	xspi_out32(regs_base + XIPIF_V123B_IIER_OFFSET, 0);
+	/* Enable the global IPIF interrupt */
+	xspi_out32(regs_base + XIPIF_V123B_DGIER_OFFSET,
+		   XIPIF_V123B_GINTR_ENABLE);
+	/* Deselect the slave on the SPI bus */
+	xspi_out32(regs_base + XSPI_SSR_OFFSET, 0xffff);
+	/* Disable the transmitter, enable Manual Slave Select Assertion,
+	 * put SPI controller into master mode, and enable it */
+	xspi_out16(regs_base + XSPI_CR_OFFSET,
+		   XSPI_CR_TRANS_INHIBIT | XSPI_CR_MANUAL_SSELECT
+		   | XSPI_CR_MASTER_MODE | XSPI_CR_ENABLE);
+}
+
+static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
+{
+	struct xilinx_spi *xspi;
+	u8 __iomem *regs_base;
+
+	xspi = spi_master_get_devdata(spi->master);
+	regs_base = xspi->regs;
+
+	if (is_on == BITBANG_CS_INACTIVE) {
+		/* Deselect the slave on the SPI bus */
+		xspi_out32(regs_base + XSPI_SSR_OFFSET, 0xffff);
+	} else if (is_on == BITBANG_CS_ACTIVE) {
+		/* Set the SPI clock phase and polarity */
+		u16 cr = xspi_in16(regs_base + XSPI_CR_OFFSET)
+			 & ~XSPI_CR_MODE_MASK;
+		if (spi->mode & SPI_CPHA)
+			cr |= XSPI_CR_CPHA;
+		if (spi->mode & SPI_CPOL)
+			cr |= XSPI_CR_CPOL;
+		xspi_out16(regs_base + XSPI_CR_OFFSET, cr);
+
+		/* We do not check spi->max_speed_hz here as the SPI clock
+		 * frequency is not software programmable (the IP block design
+		 * parameter)
+		 */
+
+		/* Activate the chip select */
+		xspi_out32(regs_base + XSPI_SSR_OFFSET,
+			   ~(0x0001 << spi->chip_select));
+	}
+}
+
+/* spi_bitbang requires custom setup_transfer() to be defined if there is a
+ * custom txrx_bufs(). We have nothing to setup here as the SPI IP block
+ * supports just 8 bits per word, and SPI clock can't be changed in software.
+ * Check for 8 bits per word; speed_hz checking could be added if the SPI
+ * clock information is available. Chip select delay calculations could be
+ * added here as soon as bitbang_work() can be made aware of the delay value.
+ */
+static int xilinx_spi_setup_transfer(struct spi_device *spi,
+				     struct spi_transfer *t)
+{
+	u8 bits_per_word;
+
+	bits_per_word = (t) ? t->bits_per_word : spi->bits_per_word;
+	if (bits_per_word != 8)
+		return -EINVAL;
+
+	return 0;
+}
+
+
+static int xilinx_spi_setup(struct spi_device *spi)
+{
+	struct spi_bitbang *bitbang;
+	struct xilinx_spi *xspi;
+	int retval;
+
+	xspi = spi_master_get_devdata(spi->master);
+	bitbang = &xspi->bitbang;
+
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+
+	retval = xilinx_spi_setup_transfer(spi, NULL);
+	if (retval < 0)
+		return retval;
+
+	dev_dbg(&spi->dev, "%s, mode %d, %u bits/w, %u nsec/bit\n",
+		__FUNCTION__, spi->mode & (SPI_CPOL | SPI_CPHA),
+		spi->bits_per_word, 0);
+
+	return 0;
+}
+
+static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct xilinx_spi *xspi;
+	u8 __iomem *regs_base;
+	u32 ipif_ier;
+	u16 cr;
+	u8 sr;
+
+	/* We get here with transmitter inhibited */
+
+	xspi = spi_master_get_devdata(spi->master);
+	regs_base = xspi->regs;
+
+	xspi->tx_ptr = t->tx_buf;
+	xspi->rx_ptr = t->rx_buf;
+	xspi->remaining_bytes = t->len;
+	INIT_COMPLETION(xspi->done);
+
+	/* Fill the Tx FIFO with as many bytes as possible */
+	sr = in_8(regs_base + XSPI_SR_OFFSET);
+	while ((sr & XSPI_SR_TX_FULL_MASK) == 0 && xspi->remaining_bytes > 0) {
+		if (xspi->tx_ptr) {
+			out_8(regs_base + XSPI_TXD_OFFSET, *xspi->tx_ptr++);
+		} else {
+			out_8(regs_base + XSPI_TXD_OFFSET, 0);
+		}
+		xspi->remaining_bytes--;
+		sr = in_8(regs_base + XSPI_SR_OFFSET);
+	}
+
+	/* Enable the transmit empty interrupt, which we use to determine
+	 * progress on the transmission.
+	 */
+	ipif_ier = xspi_in32(regs_base + XIPIF_V123B_IIER_OFFSET);
+	xspi_out32(regs_base + XIPIF_V123B_IIER_OFFSET,
+		   ipif_ier | XSPI_INTR_TX_EMPTY);
+
+	/* Start the transfer by not inhibiting the transmitter any longer */
+	cr = xspi_in16(regs_base + XSPI_CR_OFFSET) & ~XSPI_CR_TRANS_INHIBIT;
+	xspi_out16(regs_base + XSPI_CR_OFFSET, cr);
+
+	wait_for_completion(&xspi->done);
+
+	/* Disable the transmit empty interrupt */
+	xspi_out32(regs_base + XIPIF_V123B_IIER_OFFSET, ipif_ier);
+
+	return t->len - xspi->remaining_bytes;
+}
+
+
+/* This driver supports single master mode only. Hence Tx FIFO Empty
+ * is the only interrupt we care about.
+ * Receive FIFO Overrun, Transmit FIFO Underrun, Mode Fault, and Slave Mode
+ * Fault are not to happen.
+ */
+static irqreturn_t xilinx_spi_irq(int irq, void *dev_id)
+{
+	struct xilinx_spi *xspi;
+	u8 __iomem *regs_base;
+	u32 ipif_isr;
+
+	xspi = (struct xilinx_spi *) dev_id;
+	regs_base = xspi->regs;
+
+     	/* Get the IPIF inetrrupts, and clear them immediately */
+	ipif_isr = xspi_in32(regs_base + XIPIF_V123B_IISR_OFFSET);
+	xspi_out32(regs_base + XIPIF_V123B_IISR_OFFSET, ipif_isr);
+
+	if (ipif_isr & XSPI_INTR_TX_EMPTY) {	/* Transmission completed */
+		u16 cr;
+		u8 sr;
+
+		/* A transmit has just completed. Process received data and
+		 * check for more data to transmit. Always inhibit the
+		 * transmitter while the Isr refills the transmit register/FIFO,
+		 * or make sure it is stopped if we're done.
+	         */
+		cr = xspi_in16(regs_base + XSPI_CR_OFFSET);
+		xspi_out16(regs_base + XSPI_CR_OFFSET,
+			   cr | XSPI_CR_TRANS_INHIBIT);
+
+		/* Read out all the data from the Rx FIFO */
+		sr = in_8(regs_base + XSPI_SR_OFFSET);
+		while ((sr & XSPI_SR_RX_EMPTY_MASK) == 0) {
+			u8 data;
+
+			data = in_8(regs_base + XSPI_RXD_OFFSET);
+			if (xspi->rx_ptr) {
+				*xspi->rx_ptr++ = data;
+			}
+			sr = in_8(regs_base + XSPI_SR_OFFSET);
+		}
+
+	        /* See if there is more data to send */
+		if (xspi->remaining_bytes > 0) {
+			/* sr content is valid here; no need for io_8() */
+			while ((sr & XSPI_SR_TX_FULL_MASK) == 0
+				&& xspi->remaining_bytes > 0) {
+				if (xspi->tx_ptr) {
+					out_8(regs_base + XSPI_TXD_OFFSET,
+					      *xspi->tx_ptr++);
+				} else {
+					out_8(regs_base + XSPI_TXD_OFFSET, 0);
+				}
+				xspi->remaining_bytes--;
+				sr = in_8(regs_base + XSPI_SR_OFFSET);
+			}
+			/* Start the transfer by not inhibiting the
+			 * transmitter any longer
+			 */
+			xspi_out16(regs_base + XSPI_CR_OFFSET, cr);
+		} else {
+			/* No more data to send.
+			 * Indicate the transfer is completed.
+			 */
+			complete(&xspi->done);
+		}
+	} else {
+		/* spurious interrupt */
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int __init xilinx_spi_probe(struct platform_device *dev)
+{
+	int ret = 0;
+	struct spi_master *master;
+	struct xilinx_spi *xspi;
+	struct xspi_platform_data *pdata;
+	struct resource *r;
+
+	/* Get resources(memory, IRQ) associated with the device */
+	master = spi_alloc_master(&dev->dev, sizeof(struct xilinx_spi));
+
+	if (master == NULL) {
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(dev, master);
+	pdata = dev->dev.platform_data;
+
+	if (pdata == NULL) {
+		ret = -ENODEV;
+		goto put_master;
+	}
+
+	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (r == NULL) {
+		ret = -ENODEV;
+		goto put_master;
+	}
+
+	xspi = spi_master_get_devdata(master);
+	xspi->bitbang.master = spi_master_get(master);
+	xspi->bitbang.chipselect = xilinx_spi_chipselect;
+	xspi->bitbang.setup_transfer = xilinx_spi_setup_transfer;
+	xspi->bitbang.txrx_bufs = xilinx_spi_txrx_bufs;
+	xspi->bitbang.master->setup = xilinx_spi_setup;
+	init_completion(&xspi->done);
+
+	xspi->regs = ioremap(r->start, r->end - r->start + 1);
+	if (xspi->regs == NULL) {
+		ret = -ENOMEM;
+		goto put_master;
+	}
+
+	xspi->irq = platform_get_irq(dev, 0);
+	if (xspi->irq < 0) {
+		ret = -ENXIO;
+		goto unmap_io;
+	}
+
+	master->bus_num = pdata->bus_num;
+	master->num_chipselect = pdata->num_chipselect;
+
+	/* SPI controller initializations */
+	xspi_init_hw(xspi->regs);
+
+	/* Register for SPI Interrupt */
+	ret = request_irq(xspi->irq, xilinx_spi_irq, 0, XILINX_SPI_NAME, xspi);
+	if (ret != 0)
+		goto unmap_io;
+
+	ret = spi_bitbang_start(&xspi->bitbang);
+	if (ret != 0) {
+		printk(KERN_ALERT "spi_btbang_start FAILED\n");
+		goto free_irq;
+	}
+
+	printk(KERN_INFO "%s: at 0x%08X mapped to 0x%08X, irq=%d\n",
+	       dev->dev.bus_id, r->start, (u32)xspi->regs, xspi->irq);
+
+	return ret;
+
+free_irq:
+        free_irq(xspi->irq, xspi);
+unmap_io:
+	iounmap(xspi->regs);
+put_master:
+        spi_master_put(master);
+	return ret;
+}
+
+static int __devexit xilinx_spi_remove(struct platform_device *dev)
+{
+	struct xilinx_spi *xspi;
+	struct spi_master *master;
+
+	master = platform_get_drvdata(dev);
+	xspi = spi_master_get_devdata(master);
+
+	spi_bitbang_stop(&xspi->bitbang);
+	xspi_abort_transfer(xspi->regs);
+	free_irq(xspi->irq, xspi);
+	iounmap(xspi->regs);
+	platform_set_drvdata(dev, 0);
+	spi_master_put(xspi->bitbang.master);
+
+	return 0;
+}
+
+static struct platform_driver xilinx_spi_driver = {
+	.probe	= xilinx_spi_probe,
+	.remove	= __devexit_p(xilinx_spi_remove),
+	.driver = {
+		   .name = XILINX_SPI_NAME,
+		   .owner = THIS_MODULE,
+	},
+};
+
+static int __init xilinx_spi_init(void)
+{
+	return platform_driver_register(&xilinx_spi_driver);
+}
+
+static void __exit xilinx_spi_exit(void)
+{
+	platform_driver_unregister(&xilinx_spi_driver);
+}
+
+module_init(xilinx_spi_init);
+module_exit(xilinx_spi_exit);
+
+MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");
+MODULE_DESCRIPTION("Xilinx SPI driver");
+MODULE_LICENSE("GPL");
-- 
1.5.1.1
