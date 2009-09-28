Return-Path: <richard.rojfors@mocean-labs.com>
Received: from av9-1-sn2.hy.skanova.net (av9-1-sn2.hy.skanova.net
	[81.228.8.179]) by ozlabs.org (Postfix) with ESMTP id 315DAB7BE8
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Sep 2009 00:22:25 +1000 (EST)
Message-ID: <4AC0C699.2070506@mocean-labs.com>
Date: Mon, 28 Sep 2009 16:22:17 +0200
From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
MIME-Version: 1.0
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH v4] xilinx_spi: Splitted into generic, of and platform driver,
	added support for DS570
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	dbrownell@users.sourceforge.net, John Linn <John.Linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch splits xilinx_spi into three parts, an OF and a platform
driver and generic part.

The generic part now also works on X86, it supports accessing the IP
booth big and little endian. There is also support for 16 and 32 bit
SPI for the Xilinx SPI IP DS570

Signed-off-by: Richard Röjfors <richard.rojfors@mocean-labs.com>
---
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 2c733c2..ecabc12 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -218,8 +218,8 @@ config SPI_TXX9
 	  SPI driver for Toshiba TXx9 MIPS SoCs

 config SPI_XILINX
-	tristate "Xilinx SPI controller"
-	depends on (XILINX_VIRTEX || MICROBLAZE) && EXPERIMENTAL
+	tristate "Xilinx SPI controller common module"
+	depends on HAS_IOMEM && EXPERIMENTAL
 	select SPI_BITBANG
 	help
 	  This exposes the SPI controller IP from the Xilinx EDK.
@@ -227,6 +227,21 @@ config SPI_XILINX
 	  See the "OPB Serial Peripheral Interface (SPI) (v1.00e)"
 	  Product Specification document (DS464) for hardware details.

+	  Or for the DS570, see "XPS Serial Peripheral Interface (SPI) (v2.00b)"
+
+config SPI_XILINX_OF
+	tristate "Xilinx SPI controller OF device"
+	depends on SPI_XILINX && XILINX_VIRTEX
+	help
+	  This is the OF driver for the SPI controller IP from the Xilinx EDK.
+
+config SPI_XILINX_PLTFM
+	tristate "Xilinx SPI controller platform device"
+	depends on SPI_XILINX
+	help
+	  This is the platform driver for the SPI controller IP
+	  from the Xilinx EDK.
+
 #
 # Add new SPI master controllers in alphabetical order above this line
 #
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 3de408d..5a91cf5 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -30,6 +30,8 @@ obj-$(CONFIG_SPI_S3C24XX_GPIO)		+= spi_s3c24xx_gpio.o
 obj-$(CONFIG_SPI_S3C24XX)		+= spi_s3c24xx.o
 obj-$(CONFIG_SPI_TXX9)			+= spi_txx9.o
 obj-$(CONFIG_SPI_XILINX)		+= xilinx_spi.o
+obj-$(CONFIG_SPI_XILINX_OF)		+= xilinx_spi_of.o
+obj-$(CONFIG_SPI_XILINX_PLTFM)		+= xilinx_spi_pltfm.o
 obj-$(CONFIG_SPI_SH_SCI)		+= spi_sh_sci.o
 # 	... add above this line ...

diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index 46b8c5c..b1fcc00 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -14,22 +14,35 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/platform_device.h>
-
-#include <linux/of_platform.h>
-#include <linux/of_device.h>
-#include <linux/of_spi.h>

 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/io.h>

-#define XILINX_SPI_NAME "xilinx_spi"
+#include "xilinx_spi.h"
+
+struct xilinx_spi {
+	/* bitbang has to be first */
+	struct spi_bitbang bitbang;
+	struct completion done;
+	struct resource mem; /* phys mem */
+	void __iomem	*regs;	/* virt. address of the control registers */
+	u32 irq;
+	u8 *rx_ptr;		/* pointer in the Tx buffer */
+	const u8 *tx_ptr;	/* pointer in the Rx buffer */
+	int remaining_bytes;	/* the number of bytes left to transfer */
+	/* offset to the XSPI regs, these might vary... */
+	u8 bits_per_word;
+	bool big_endian;	/* The device could be accessed big or little
+				 * endian
+				 */
+};
+

 /* Register definitions as per "OPB Serial Peripheral Interface (SPI) (v1.00e)
  * Product Specification", DS464
  */
-#define XSPI_CR_OFFSET		0x62	/* 16-bit Control Register */
+#define XSPI_CR_OFFSET		0x60	/* Control Register */

 #define XSPI_CR_ENABLE		0x02
 #define XSPI_CR_MASTER_MODE	0x04
@@ -40,8 +53,9 @@
 #define XSPI_CR_RXFIFO_RESET	0x40
 #define XSPI_CR_MANUAL_SSELECT	0x80
 #define XSPI_CR_TRANS_INHIBIT	0x100
+#define XSPI_CR_LSB_FIRST	0x200

-#define XSPI_SR_OFFSET		0x67	/* 8-bit Status Register */
+#define XSPI_SR_OFFSET		0x64	/* Status Register */

 #define XSPI_SR_RX_EMPTY_MASK	0x01	/* Receive FIFO is empty */
 #define XSPI_SR_RX_FULL_MASK	0x02	/* Receive FIFO is full */
@@ -49,8 +63,8 @@
 #define XSPI_SR_TX_FULL_MASK	0x08	/* Transmit FIFO is full */
 #define XSPI_SR_MODE_FAULT_MASK	0x10	/* Mode fault error */

-#define XSPI_TXD_OFFSET		0x6b	/* 8-bit Data Transmit Register */
-#define XSPI_RXD_OFFSET		0x6f	/* 8-bit Data Receive Register */
+#define XSPI_TXD_OFFSET		0x68	/* Data Transmit Register */
+#define XSPI_RXD_OFFSET		0x6C	/* Data Receive Register */

 #define XSPI_SSR_OFFSET		0x70	/* 32-bit Slave Select Register */

@@ -70,43 +84,72 @@
 #define XSPI_INTR_TX_UNDERRUN		0x08	/* TxFIFO was underrun */
 #define XSPI_INTR_RX_FULL		0x10	/* RxFIFO is full */
 #define XSPI_INTR_RX_OVERRUN		0x20	/* RxFIFO was overrun */
+#define XSPI_INTR_TX_HALF_EMPTY		0x40	/* TxFIFO is half empty */

 #define XIPIF_V123B_RESETR_OFFSET	0x40	/* IPIF reset register */
 #define XIPIF_V123B_RESET_MASK		0x0a	/* the value to write */

-struct xilinx_spi {
-	/* bitbang has to be first */
-	struct spi_bitbang bitbang;
-	struct completion done;
+/* to follow are some functions that does little of big endian read and
+ * write depending on the config of the device.
+ */
+static inline void xspi_write8(struct xilinx_spi *xspi, u32 offs, u8 val)
+{
+	iowrite8(val, xspi->regs + offs + ((xspi->big_endian) ? 3 : 0));
+}

-	void __iomem	*regs;	/* virt. address of the control registers */
+static inline void xspi_write16(struct xilinx_spi *xspi, u32 offs, u16 val)
+{
+	if (xspi->big_endian)
+		iowrite16be(val, xspi->regs + offs + 2);
+	else
+		iowrite16(val, xspi->regs + offs);
+}

-	u32		irq;
+static inline void xspi_write32(struct xilinx_spi *xspi, u32 offs, u32 val)
+{
+	if (xspi->big_endian)
+		iowrite32be(val, xspi->regs + offs);
+	else
+		iowrite32(val, xspi->regs + offs);
+}

-	u32		speed_hz; /* SCK has a fixed frequency of speed_hz Hz */
+static inline u8 xspi_read8(struct xilinx_spi *xspi, u32 offs)
+{
+	return ioread8(xspi->regs + offs + ((xspi->big_endian) ? 3 : 0));
+}

-	u8 *rx_ptr;		/* pointer in the Tx buffer */
-	const u8 *tx_ptr;	/* pointer in the Rx buffer */
-	int remaining_bytes;	/* the number of bytes left to transfer */
-};
+static inline u16 xspi_read16(struct xilinx_spi *xspi, u32 offs)
+{
+	if (xspi->big_endian)
+		return ioread16be(xspi->regs + offs + 2);
+	else
+		return ioread16(xspi->regs + offs);
+}
+
+static inline u32 xspi_read32(struct xilinx_spi *xspi, u32 offs)
+{
+	if (xspi->big_endian)
+		return ioread32be(xspi->regs + offs);
+	else
+		return ioread32(xspi->regs + offs);
+}

-static void xspi_init_hw(void __iomem *regs_base)
+static void xspi_init_hw(struct xilinx_spi *xspi)
 {
 	/* Reset the SPI device */
-	out_be32(regs_base + XIPIF_V123B_RESETR_OFFSET,
-		 XIPIF_V123B_RESET_MASK);
+	xspi_write32(xspi, XIPIF_V123B_RESETR_OFFSET, XIPIF_V123B_RESET_MASK);
 	/* Disable all the interrupts just in case */
-	out_be32(regs_base + XIPIF_V123B_IIER_OFFSET, 0);
+	xspi_write32(xspi, XIPIF_V123B_IIER_OFFSET, 0);
 	/* Enable the global IPIF interrupt */
-	out_be32(regs_base + XIPIF_V123B_DGIER_OFFSET,
-		 XIPIF_V123B_GINTR_ENABLE);
+	xspi_write32(xspi, XIPIF_V123B_DGIER_OFFSET, XIPIF_V123B_GINTR_ENABLE);
 	/* Deselect the slave on the SPI bus */
-	out_be32(regs_base + XSPI_SSR_OFFSET, 0xffff);
+	xspi_write32(xspi, XSPI_SSR_OFFSET, 0xffff);
 	/* Disable the transmitter, enable Manual Slave Select Assertion,
 	 * put SPI controller into master mode, and enable it */
-	out_be16(regs_base + XSPI_CR_OFFSET,
-		 XSPI_CR_TRANS_INHIBIT | XSPI_CR_MANUAL_SSELECT
-		 | XSPI_CR_MASTER_MODE | XSPI_CR_ENABLE);
+	xspi_write16(xspi, XSPI_CR_OFFSET,
+		 XSPI_CR_TRANS_INHIBIT | XSPI_CR_MANUAL_SSELECT |
+		 XSPI_CR_MASTER_MODE | XSPI_CR_ENABLE | XSPI_CR_TXFIFO_RESET |
+		 XSPI_CR_RXFIFO_RESET);
 }

 static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
@@ -115,16 +158,16 @@ static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)

 	if (is_on == BITBANG_CS_INACTIVE) {
 		/* Deselect the slave on the SPI bus */
-		out_be32(xspi->regs + XSPI_SSR_OFFSET, 0xffff);
+		xspi_write32(xspi, XSPI_SSR_OFFSET, 0xffff);
 	} else if (is_on == BITBANG_CS_ACTIVE) {
 		/* Set the SPI clock phase and polarity */
-		u16 cr = in_be16(xspi->regs + XSPI_CR_OFFSET)
+		u16 cr = xspi_read16(xspi, XSPI_CR_OFFSET)
 			 & ~XSPI_CR_MODE_MASK;
 		if (spi->mode & SPI_CPHA)
 			cr |= XSPI_CR_CPHA;
 		if (spi->mode & SPI_CPOL)
 			cr |= XSPI_CR_CPOL;
-		out_be16(xspi->regs + XSPI_CR_OFFSET, cr);
+		xspi_write16(xspi, XSPI_CR_OFFSET, cr);

 		/* We do not check spi->max_speed_hz here as the SPI clock
 		 * frequency is not software programmable (the IP block design
@@ -132,24 +175,27 @@ static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
 		 */

 		/* Activate the chip select */
-		out_be32(xspi->regs + XSPI_SSR_OFFSET,
+		xspi_write32(xspi, XSPI_SSR_OFFSET,
 			 ~(0x0001 << spi->chip_select));
 	}
 }

 /* spi_bitbang requires custom setup_transfer() to be defined if there is a
  * custom txrx_bufs(). We have nothing to setup here as the SPI IP block
- * supports just 8 bits per word, and SPI clock can't be changed in software.
- * Check for 8 bits per word. Chip select delay calculations could be
+ * supports 8 or 16 bits per word, which can not be changed in software.
+ * SPI clock can't be changed in software.
+ * Check for correct bits per word. Chip select delay calculations could be
  * added here as soon as bitbang_work() can be made aware of the delay value.
  */
 static int xilinx_spi_setup_transfer(struct spi_device *spi,
-		struct spi_transfer *t)
+	struct spi_transfer *t)
 {
 	u8 bits_per_word;
+	struct xilinx_spi *xspi = spi_master_get_devdata(spi->master);

-	bits_per_word = (t) ? t->bits_per_word : spi->bits_per_word;
-	if (bits_per_word != 8) {
+	bits_per_word = (t->bits_per_word) ? t->bits_per_word :
+		spi->bits_per_word;
+	if (bits_per_word != xspi->bits_per_word) {
 		dev_err(&spi->dev, "%s, unsupported bits_per_word=%d\n",
 			__func__, bits_per_word);
 		return -EINVAL;
@@ -160,34 +206,50 @@ static int xilinx_spi_setup_transfer(struct spi_device *spi,

 static int xilinx_spi_setup(struct spi_device *spi)
 {
-	struct spi_bitbang *bitbang;
-	struct xilinx_spi *xspi;
-	int retval;
-
-	xspi = spi_master_get_devdata(spi->master);
-	bitbang = &xspi->bitbang;
-
-	retval = xilinx_spi_setup_transfer(spi, NULL);
-	if (retval < 0)
-		return retval;
-
+	/* always return 0, we can not check the number of bits.
+	 * There are cases when SPI setup is called before any driver is
+	 * there, in that case the SPI core defaults to 8 bits, which we
+	 * do not support in some cases. But if we return an error, the
+	 * SPI device would not be registered and no driver can get hold of it
+	 * When the driver is there, it will call SPI setup again with the
+	 * correct number of bits per transfer.
+	 * If a driver setups with the wrong bit number, it will fail when
+	 * it tries to do a transfer
+	 */
 	return 0;
 }

 static void xilinx_spi_fill_tx_fifo(struct xilinx_spi *xspi)
 {
 	u8 sr;
+	u8 wsize;
+	if (xspi->bits_per_word == 8)
+		wsize = 1;
+	else if (xspi->bits_per_word == 16)
+		wsize = 2;
+	else
+		wsize = 4;

 	/* Fill the Tx FIFO with as many bytes as possible */
-	sr = in_8(xspi->regs + XSPI_SR_OFFSET);
-	while ((sr & XSPI_SR_TX_FULL_MASK) == 0 && xspi->remaining_bytes > 0) {
+	sr = xspi_read8(xspi, XSPI_SR_OFFSET);
+	while ((sr & XSPI_SR_TX_FULL_MASK) == 0 &&
+		xspi->remaining_bytes > 0) {
 		if (xspi->tx_ptr) {
-			out_8(xspi->regs + XSPI_TXD_OFFSET, *xspi->tx_ptr++);
-		} else {
-			out_8(xspi->regs + XSPI_TXD_OFFSET, 0);
-		}
-		xspi->remaining_bytes--;
-		sr = in_8(xspi->regs + XSPI_SR_OFFSET);
+			if (wsize == 1)
+				xspi_write8(xspi, XSPI_TXD_OFFSET,
+					*xspi->tx_ptr);
+			else if (wsize == 2)
+				xspi_write16(xspi, XSPI_TXD_OFFSET,
+					*(u16 *)(xspi->tx_ptr));
+			else if (wsize == 4)
+				xspi_write32(xspi, XSPI_TXD_OFFSET,
+					*(u32 *)(xspi->tx_ptr));
+
+			xspi->tx_ptr += wsize;
+		} else
+			xspi_write8(xspi, XSPI_TXD_OFFSET, 0);
+		xspi->remaining_bytes -= wsize;
+		sr = xspi_read8(xspi, XSPI_SR_OFFSET);
 	}
 }

@@ -209,23 +271,22 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 	/* Enable the transmit empty interrupt, which we use to determine
 	 * progress on the transmission.
 	 */
-	ipif_ier = in_be32(xspi->regs + XIPIF_V123B_IIER_OFFSET);
-	out_be32(xspi->regs + XIPIF_V123B_IIER_OFFSET,
+	ipif_ier = xspi_read32(xspi, XIPIF_V123B_IIER_OFFSET);
+	xspi_write32(xspi, XIPIF_V123B_IIER_OFFSET,
 		 ipif_ier | XSPI_INTR_TX_EMPTY);

 	/* Start the transfer by not inhibiting the transmitter any longer */
-	cr = in_be16(xspi->regs + XSPI_CR_OFFSET) & ~XSPI_CR_TRANS_INHIBIT;
-	out_be16(xspi->regs + XSPI_CR_OFFSET, cr);
+	cr = xspi_read16(xspi, XSPI_CR_OFFSET) & ~XSPI_CR_TRANS_INHIBIT;
+	xspi_write16(xspi, XSPI_CR_OFFSET, cr);

 	wait_for_completion(&xspi->done);

 	/* Disable the transmit empty interrupt */
-	out_be32(xspi->regs + XIPIF_V123B_IIER_OFFSET, ipif_ier);
+	xspi_write32(xspi, XIPIF_V123B_IIER_OFFSET, ipif_ier);

 	return t->len - xspi->remaining_bytes;
 }

-
 /* This driver supports single master mode only. Hence Tx FIFO Empty
  * is the only interrupt we care about.
  * Receive FIFO Overrun, Transmit FIFO Underrun, Mode Fault, and Slave Mode
@@ -237,32 +298,50 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_id)
 	u32 ipif_isr;

 	/* Get the IPIF interrupts, and clear them immediately */
-	ipif_isr = in_be32(xspi->regs + XIPIF_V123B_IISR_OFFSET);
-	out_be32(xspi->regs + XIPIF_V123B_IISR_OFFSET, ipif_isr);
+	ipif_isr = xspi_read32(xspi, XIPIF_V123B_IISR_OFFSET);
+	xspi_write32(xspi, XIPIF_V123B_IISR_OFFSET, ipif_isr);

 	if (ipif_isr & XSPI_INTR_TX_EMPTY) {	/* Transmission completed */
 		u16 cr;
 		u8 sr;
+		u8 rsize;
+		if (xspi->bits_per_word == 8)
+			rsize = 1;
+		else if (xspi->bits_per_word == 16)
+			rsize = 2;
+		else
+			rsize = 4;

 		/* A transmit has just completed. Process received data and
 		 * check for more data to transmit. Always inhibit the
 		 * transmitter while the Isr refills the transmit register/FIFO,
 		 * or make sure it is stopped if we're done.
 		 */
-		cr = in_be16(xspi->regs + XSPI_CR_OFFSET);
-		out_be16(xspi->regs + XSPI_CR_OFFSET,
-			 cr | XSPI_CR_TRANS_INHIBIT);
+		cr = xspi_read16(xspi, XSPI_CR_OFFSET);
+		xspi_write16(xspi, XSPI_CR_OFFSET, cr | XSPI_CR_TRANS_INHIBIT);

 		/* Read out all the data from the Rx FIFO */
-		sr = in_8(xspi->regs + XSPI_SR_OFFSET);
+		sr = xspi_read8(xspi, XSPI_SR_OFFSET);
 		while ((sr & XSPI_SR_RX_EMPTY_MASK) == 0) {
-			u8 data;
+			u32 data;
+			if (rsize == 1)
+				data = xspi_read8(xspi, XSPI_RXD_OFFSET);
+			else if (rsize == 2)
+				data = xspi_read16(xspi, XSPI_RXD_OFFSET);
+			else
+				data = xspi_read32(xspi, XSPI_RXD_OFFSET);

-			data = in_8(xspi->regs + XSPI_RXD_OFFSET);
 			if (xspi->rx_ptr) {
-				*xspi->rx_ptr++ = data;
+				if (rsize == 1)
+					*xspi->rx_ptr = data & 0xff;
+				else if (rsize == 2)
+					*(u16 *)(xspi->rx_ptr) = data & 0xffff;
+				else
+					*((u32 *)(xspi->rx_ptr)) = data;
+				xspi->rx_ptr += rsize;
 			}
-			sr = in_8(xspi->regs + XSPI_SR_OFFSET);
+
+			sr = xspi_read8(xspi, XSPI_SR_OFFSET);
 		}

 		/* See if there is more data to send */
@@ -271,7 +350,7 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_id)
 			/* Start the transfer by not inhibiting the
 			 * transmitter any longer
 			 */
-			out_be16(xspi->regs + XSPI_CR_OFFSET, cr);
+			xspi_write16(xspi, XSPI_CR_OFFSET, cr);
 		} else {
 			/* No more data to send.
 			 * Indicate the transfer is completed.
@@ -279,44 +358,21 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_id)
 			complete(&xspi->done);
 		}
 	}
-
 	return IRQ_HANDLED;
 }

-static int __init xilinx_spi_of_probe(struct of_device *ofdev,
-					const struct of_device_id *match)
+struct spi_master *xilinx_spi_init(struct device *dev, struct resource *mem,
+	u32 irq, s16 bus_num, u16 num_chipselect, u8 bits_per_word,
+	bool big_endian)
 {
 	struct spi_master *master;
 	struct xilinx_spi *xspi;
-	struct resource r_irq_struct;
-	struct resource r_mem_struct;
-
-	struct resource *r_irq = &r_irq_struct;
-	struct resource *r_mem = &r_mem_struct;
-	int rc = 0;
-	const u32 *prop;
-	int len;
-
-	/* Get resources(memory, IRQ) associated with the device */
-	master = spi_alloc_master(&ofdev->dev, sizeof(struct xilinx_spi));
-
-	if (master == NULL) {
-		return -ENOMEM;
-	}
+	int ret = 0;

-	dev_set_drvdata(&ofdev->dev, master);
+	master = spi_alloc_master(dev, sizeof(struct xilinx_spi));

-	rc = of_address_to_resource(ofdev->node, 0, r_mem);
-	if (rc) {
-		dev_warn(&ofdev->dev, "invalid address\n");
-		goto put_master;
-	}
-
-	rc = of_irq_to_resource(ofdev->node, 0, r_irq);
-	if (rc == NO_IRQ) {
-		dev_warn(&ofdev->dev, "no IRQ found\n");
-		goto put_master;
-	}
+	if (master == NULL)
+		return ERR_PTR(-ENOMEM);

 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA;
@@ -329,128 +385,73 @@ static int __init xilinx_spi_of_probe(struct of_device *ofdev,
 	xspi->bitbang.master->setup = xilinx_spi_setup;
 	init_completion(&xspi->done);

-	xspi->irq = r_irq->start;
-
-	if (!request_mem_region(r_mem->start,
-			r_mem->end - r_mem->start + 1, XILINX_SPI_NAME)) {
-		rc = -ENXIO;
-		dev_warn(&ofdev->dev, "memory request failure\n");
+	if (!request_mem_region(mem->start, resource_size(mem),
+		XILINX_SPI_NAME)) {
+		ret = -ENXIO;
 		goto put_master;
 	}

-	xspi->regs = ioremap(r_mem->start, r_mem->end - r_mem->start + 1);
+	xspi->regs = ioremap(mem->start, resource_size(mem));
 	if (xspi->regs == NULL) {
-		rc = -ENOMEM;
-		dev_warn(&ofdev->dev, "ioremap failure\n");
-		goto release_mem;
+		ret = -ENOMEM;
+		dev_warn(dev, "ioremap failure\n");
+		goto map_failed;
 	}
-	xspi->irq = r_irq->start;

-	/* dynamic bus assignment */
-	master->bus_num = -1;
+	master->bus_num = bus_num;
+	master->num_chipselect = num_chipselect;

-	/* number of slave select bits is required */
-	prop = of_get_property(ofdev->node, "xlnx,num-ss-bits", &len);
-	if (!prop || len < sizeof(*prop)) {
-		dev_warn(&ofdev->dev, "no 'xlnx,num-ss-bits' property\n");
-		goto unmap_io;
-	}
-	master->num_chipselect = *prop;
+	xspi->mem = *mem;
+	xspi->irq = irq;
+	xspi->bits_per_word = bits_per_word;
+	xspi->big_endian = big_endian;

 	/* SPI controller initializations */
-	xspi_init_hw(xspi->regs);
+	xspi_init_hw(xspi);

 	/* Register for SPI Interrupt */
-	rc = request_irq(xspi->irq, xilinx_spi_irq, 0, XILINX_SPI_NAME, xspi);
-	if (rc != 0) {
-		dev_warn(&ofdev->dev, "irq request failure: %d\n", xspi->irq);
+	ret = request_irq(xspi->irq, xilinx_spi_irq, 0, XILINX_SPI_NAME, xspi);
+	if (ret != 0)
 		goto unmap_io;
-	}

-	rc = spi_bitbang_start(&xspi->bitbang);
-	if (rc != 0) {
-		dev_err(&ofdev->dev, "spi_bitbang_start FAILED\n");
+	ret = spi_bitbang_start(&xspi->bitbang);
+	if (ret != 0) {
+		dev_err(dev, "spi_bitbang_start FAILED\n");
 		goto free_irq;
 	}

-	dev_info(&ofdev->dev, "at 0x%08X mapped to 0x%08X, irq=%d\n",
-			(unsigned int)r_mem->start, (u32)xspi->regs, xspi->irq);
-
-	/* Add any subnodes on the SPI bus */
-	of_register_spi_devices(master, ofdev->node);
-
-	return rc;
+	dev_info(dev, "at 0x%08X mapped to 0x%08X, irq=%d\n",
+		(u32)mem->start, (u32)xspi->regs, xspi->irq);
+	return master;

 free_irq:
 	free_irq(xspi->irq, xspi);
 unmap_io:
 	iounmap(xspi->regs);
-release_mem:
-	release_mem_region(r_mem->start, resource_size(r_mem));
+map_failed:
+	release_mem_region(mem->start, resource_size(mem));
 put_master:
 	spi_master_put(master);
-	return rc;
+	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL(xilinx_spi_init);

-static int __devexit xilinx_spi_remove(struct of_device *ofdev)
+void xilinx_spi_deinit(struct spi_master *master)
 {
 	struct xilinx_spi *xspi;
-	struct spi_master *master;
-	struct resource r_mem;

-	master = platform_get_drvdata(ofdev);
 	xspi = spi_master_get_devdata(master);

 	spi_bitbang_stop(&xspi->bitbang);
 	free_irq(xspi->irq, xspi);
 	iounmap(xspi->regs);
-	if (!of_address_to_resource(ofdev->node, 0, &r_mem))
-		release_mem_region(r_mem.start, resource_size(&r_mem));
-	dev_set_drvdata(&ofdev->dev, 0);
-	spi_master_put(xspi->bitbang.master);
-
-	return 0;
-}
-
-/* work with hotplug and coldplug */
-MODULE_ALIAS("platform:" XILINX_SPI_NAME);
-
-static int __exit xilinx_spi_of_remove(struct of_device *op)
-{
-	return xilinx_spi_remove(op);
-}
-
-static struct of_device_id xilinx_spi_of_match[] = {
-	{ .compatible = "xlnx,xps-spi-2.00.a", },
-	{ .compatible = "xlnx,xps-spi-2.00.b", },
-	{}
-};
-
-MODULE_DEVICE_TABLE(of, xilinx_spi_of_match);
-
-static struct of_platform_driver xilinx_spi_of_driver = {
-	.owner = THIS_MODULE,
-	.name = "xilinx-xps-spi",
-	.match_table = xilinx_spi_of_match,
-	.probe = xilinx_spi_of_probe,
-	.remove = __exit_p(xilinx_spi_of_remove),
-	.driver = {
-		.name = "xilinx-xps-spi",
-		.owner = THIS_MODULE,
-	},
-};

-static int __init xilinx_spi_init(void)
-{
-	return of_register_platform_driver(&xilinx_spi_of_driver);
+	release_mem_region(xspi->mem.start, resource_size(&xspi->mem));
+	spi_master_put(xspi->bitbang.master);
 }
-module_init(xilinx_spi_init);
+EXPORT_SYMBOL(xilinx_spi_deinit);

-static void __exit xilinx_spi_exit(void)
-{
-	of_unregister_platform_driver(&xilinx_spi_of_driver);
-}
-module_exit(xilinx_spi_exit);
 MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");
 MODULE_DESCRIPTION("Xilinx SPI driver");
 MODULE_LICENSE("GPL");
+
diff --git a/drivers/spi/xilinx_spi.h b/drivers/spi/xilinx_spi.h
new file mode 100644
index 0000000..e0ad67e
--- /dev/null
+++ b/drivers/spi/xilinx_spi.h
@@ -0,0 +1,33 @@
+/*
+ * xilinx_spi.h
+ * Copyright (c) 2009 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef _XILINX_SPI_H_
+#define _XILINX_SPI_H_ 1
+
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+#include <linux/spi/xilinx_spi.h>
+
+#define XILINX_SPI_NAME "xilinx_spi"
+
+struct spi_master *xilinx_spi_init(struct device *dev, struct resource *mem,
+	u32 irq, s16 bus_num, u16 num_chipselect, u8 bits_per_word,
+	bool big_endian);
+
+void xilinx_spi_deinit(struct spi_master *master);
+#endif
diff --git a/drivers/spi/xilinx_spi_of.c b/drivers/spi/xilinx_spi_of.c
new file mode 100644
index 0000000..f101a9f
--- /dev/null
+++ b/drivers/spi/xilinx_spi_of.c
@@ -0,0 +1,120 @@
+/*
+ * xilinx_spi_of.c
+ *
+ * Xilinx SPI controller driver (master mode only)
+ *
+ * Author: MontaVista Software, Inc.
+ *	source@mvista.com
+ *
+ * 2002-2007 (c) MontaVista Software, Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2.  This program is licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include <linux/of_platform.h>
+#include <linux/of_device.h>
+#include <linux/of_spi.h>
+
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+
+#include "xilinx_spi.h"
+
+
+static int __init xilinx_spi_of_probe(struct of_device *ofdev,
+					const struct of_device_id *match)
+{
+	struct resource r_irq_struct;
+	struct resource r_mem_struct;
+	struct spi_master *master;
+
+	struct resource *r_irq = &r_irq_struct;
+	struct resource *r_mem = &r_mem_struct;
+	int rc = 0;
+	const u32 *prop;
+	int len;
+
+	rc = of_address_to_resource(ofdev->node, 0, r_mem);
+	if (rc) {
+		dev_warn(&ofdev->dev, "invalid address\n");
+		return rc;
+	}
+
+	rc = of_irq_to_resource(ofdev->node, 0, r_irq);
+	if (rc == NO_IRQ) {
+		dev_warn(&ofdev->dev, "no IRQ found\n");
+		return -ENODEV;
+	}
+
+	/* number of slave select bits is required */
+	prop = of_get_property(ofdev->node, "xlnx,num-ss-bits", &len);
+	if (!prop || len < sizeof(*prop)) {
+		dev_warn(&ofdev->dev, "no 'xlnx,num-ss-bits' property\n");
+		return -EINVAL;
+	}
+	master = xilinx_spi_init(&ofdev->dev, r_mem, r_irq->start, -1, *prop, 8,
+		true);
+	if (IS_ERR(master))
+		return PTR_ERR(master);
+
+	dev_set_drvdata(&ofdev->dev, master);
+
+	/* Add any subnodes on the SPI bus */
+	of_register_spi_devices(master, ofdev->node);
+
+	return 0;
+}
+
+static int __devexit xilinx_spi_remove(struct of_device *ofdev)
+{
+	xilinx_spi_deinit(dev_get_drvdata(&ofdev->dev));
+	dev_set_drvdata(&ofdev->dev, 0);
+	return 0;
+}
+
+static int __exit xilinx_spi_of_remove(struct of_device *op)
+{
+	return xilinx_spi_remove(op);
+}
+
+static struct of_device_id xilinx_spi_of_match[] = {
+	{ .compatible = "xlnx,xps-spi-2.00.a", },
+	{ .compatible = "xlnx,xps-spi-2.00.b", },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, xilinx_spi_of_match);
+
+static struct of_platform_driver xilinx_spi_of_driver = {
+	.owner = THIS_MODULE,
+	.name = "xilinx-xps-spi",
+	.match_table = xilinx_spi_of_match,
+	.probe = xilinx_spi_of_probe,
+	.remove = __exit_p(xilinx_spi_of_remove),
+	.driver = {
+		.name = "xilinx-xps-spi",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init xilinx_spi_of_init(void)
+{
+	return of_register_platform_driver(&xilinx_spi_of_driver);
+}
+module_init(xilinx_spi_of_init);
+
+static void __exit xilinx_spi_of_exit(void)
+{
+	of_unregister_platform_driver(&xilinx_spi_of_driver);
+}
+module_exit(xilinx_spi_of_exit);
+MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");
+MODULE_DESCRIPTION("Xilinx SPI driver");
+MODULE_LICENSE("GPL");
+
diff --git a/drivers/spi/xilinx_spi_pltfm.c b/drivers/spi/xilinx_spi_pltfm.c
new file mode 100644
index 0000000..81ac297
--- /dev/null
+++ b/drivers/spi/xilinx_spi_pltfm.c
@@ -0,0 +1,104 @@
+/*
+ * xilinx_spi_pltfm.c Support for Xilinx SPI platform devices
+ * Copyright (c) 2009 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/* Supports:
+ * Xilinx SPI devices as platform devices
+ *
+ * Inspired by xilinx_spi.c, 2002-2007 (c) MontaVista Software, Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+#include <linux/spi/xilinx_spi.h>
+
+#include "xilinx_spi.h"
+
+static int __devinit xilinx_spi_probe(struct platform_device *dev)
+{
+	struct xspi_platform_data *pdata;
+	struct resource *r;
+	int irq;
+	struct spi_master *master;
+	u8 i;
+
+	pdata = dev->dev.platform_data;
+	if (pdata == NULL)
+		return -ENODEV;
+
+	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (r == NULL)
+		return -ENODEV;
+
+	irq = platform_get_irq(dev, 0);
+	if (irq < 0)
+		return -ENXIO;
+
+	master = xilinx_spi_init(&dev->dev, r, irq, dev->id,
+		pdata->num_chipselect, pdata->bits_per_word, false);
+	if (IS_ERR(master))
+		return PTR_ERR(master);
+
+	for (i = 0; i < pdata->num_devices; i++)
+		spi_new_device(master, pdata->devices + i);
+
+	platform_set_drvdata(dev, master);
+	return 0;
+}
+
+static int __devexit xilinx_spi_remove(struct platform_device *dev)
+{
+	xilinx_spi_deinit(platform_get_drvdata(dev));
+	platform_set_drvdata(dev, 0);
+
+	return 0;
+}
+
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:" XILINX_SPI_NAME);
+
+static struct platform_driver xilinx_spi_driver = {
+	.probe	= xilinx_spi_probe,
+	.remove	= __devexit_p(xilinx_spi_remove),
+	.driver = {
+		.name = XILINX_SPI_NAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init xilinx_spi_pltfm_init(void)
+{
+	return platform_driver_register(&xilinx_spi_driver);
+}
+module_init(xilinx_spi_pltfm_init);
+
+static void __exit xilinx_spi_pltfm_exit(void)
+{
+	platform_driver_unregister(&xilinx_spi_driver);
+}
+module_exit(xilinx_spi_pltfm_exit);
+
+MODULE_AUTHOR("Mocean Laboratories <info@mocean-labs.com>");
+MODULE_DESCRIPTION("Xilinx SPI platform driver");
+MODULE_LICENSE("GPL v2");
+
diff --git a/include/linux/spi/xilinx_spi.h b/include/linux/spi/xilinx_spi.h
new file mode 100644
index 0000000..03e1301
--- /dev/null
+++ b/include/linux/spi/xilinx_spi.h
@@ -0,0 +1,19 @@
+#ifndef __LINUX_SPI_XILINX_SPI_H
+#define __LINUX_SPI_XILINX_SPI_H
+
+/**
+ * struct xspi_platform_data - Platform data of the Xilinx SPI driver
+ * @num_chipselect:	Number of chip select by the IP
+ * @bits_per_word:	Number of bits per word. 8/16/32, Note that the DS464
+ *			only support 8bit SPI.
+ * @devices:		Devices to add when the driver is probed.
+ * @num_devices:	Number of devices in the devices array.
+ */
+struct xspi_platform_data {
+	u16 num_chipselect;
+	u8 bits_per_word;
+	struct spi_board_info *devices;
+	u8 num_devices;
+};
+
+#endif /* __LINUX_SPI_XILINX_SPI_H */
