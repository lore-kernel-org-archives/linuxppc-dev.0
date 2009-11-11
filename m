Return-Path: <richard.rojfors@mocean-labs.com>
Received: from av7-2-sn3.vrr.skanova.net (av7-2-sn3.vrr.skanova.net
	[81.228.9.182]) by ozlabs.org (Postfix) with ESMTP id 9F8A7B7E97
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 01:38:38 +1100 (EST)
Message-ID: <4AFACC6A.304@mocean-labs.com>
Date: Wed, 11 Nov 2009 15:38:34 +0100
From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
MIME-Version: 1.0
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH 2/4] xilinx_spi: Switch to iomem functions and support little
	endian.
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

This patch changes the out_(be)(8|16|32) and in_(be)(8|16|32) calls to iowrite(8|16|32)
and ioread(8|16|32). This to be able to build on platforms not supporting the in/out calls
for instance x86.

Support is also added for little endian writes. In some systems the registers should be
accessed little endian rather than big endian.

Signed-off-by: Richard Röjfors <richard.rojfors@mocean-labs.com>
---
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index e60b264..9667650 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -236,7 +236,7 @@ config SPI_TXX9

 config SPI_XILINX
 	tristate "Xilinx SPI controller"
-	depends on EXPERIMENTAL
+	depends on HAS_IOMEM && EXPERIMENTAL
 	select SPI_BITBANG
 	help
 	  This exposes the SPI controller IP from the Xilinx EDK.
diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index 1562e9b..b00dabc 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -19,12 +19,12 @@
 #include <linux/spi/spi_bitbang.h>
 #include <linux/io.h>

-#define XILINX_SPI_NAME "xilinx_spi"
+#include "xilinx_spi.h"

 /* Register definitions as per "OPB Serial Peripheral Interface (SPI) (v1.00e)
  * Product Specification", DS464
  */
-#define XSPI_CR_OFFSET		0x62	/* 16-bit Control Register */
+#define XSPI_CR_OFFSET		0x60	/* 16-bit Control Register */

 #define XSPI_CR_ENABLE		0x02
 #define XSPI_CR_MASTER_MODE	0x04
@@ -36,7 +36,7 @@
 #define XSPI_CR_MANUAL_SSELECT	0x80
 #define XSPI_CR_TRANS_INHIBIT	0x100

-#define XSPI_SR_OFFSET		0x67	/* 8-bit Status Register */
+#define XSPI_SR_OFFSET		0x64	/* 8-bit Status Register */

 #define XSPI_SR_RX_EMPTY_MASK	0x01	/* Receive FIFO is empty */
 #define XSPI_SR_RX_FULL_MASK	0x02	/* Receive FIFO is full */
@@ -44,8 +44,8 @@
 #define XSPI_SR_TX_FULL_MASK	0x08	/* Transmit FIFO is full */
 #define XSPI_SR_MODE_FAULT_MASK	0x10	/* Mode fault error */

-#define XSPI_TXD_OFFSET		0x6b	/* 8-bit Data Transmit Register */
-#define XSPI_RXD_OFFSET		0x6f	/* 8-bit Data Receive Register */
+#define XSPI_TXD_OFFSET		0x68	/* 8-bit Data Transmit Register */
+#define XSPI_RXD_OFFSET		0x6c	/* 8-bit Data Receive Register */

 #define XSPI_SSR_OFFSET		0x70	/* 32-bit Slave Select Register */

@@ -83,23 +83,69 @@ struct xilinx_spi {
 	u8 *rx_ptr;		/* pointer in the Tx buffer */
 	const u8 *tx_ptr;	/* pointer in the Rx buffer */
 	int remaining_bytes;	/* the number of bytes left to transfer */
+	bool big_endian;	/* The device could be accessed big or little
+				 * endian
+				 */
 };

-static void xspi_init_hw(void __iomem *regs_base)
+/* to follow are some functions that does little of big endian read and
+ * write depending on the config of the device.
+ */
+static inline void xspi_write8(struct xilinx_spi *xspi, u32 offs, u8 val)
+{
+	iowrite8(val, xspi->regs + offs + ((xspi->big_endian) ? 3 : 0));
+}
+
+static inline void xspi_write16(struct xilinx_spi *xspi, u32 offs, u16 val)
+{
+	if (xspi->big_endian)
+		iowrite16be(val, xspi->regs + offs + 2);
+	else
+		iowrite16(val, xspi->regs + offs);
+}
+
+static inline void xspi_write32(struct xilinx_spi *xspi, u32 offs, u32 val)
+{
+	if (xspi->big_endian)
+		iowrite32be(val, xspi->regs + offs);
+	else
+		iowrite32(val, xspi->regs + offs);
+}
+
+static inline u8 xspi_read8(struct xilinx_spi *xspi, u32 offs)
+{
+	return ioread8(xspi->regs + offs + ((xspi->big_endian) ? 3 : 0));
+}
+
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
+
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
+	xspi_write16(xspi, XSPI_CR_OFFSET,
 		 XSPI_CR_TRANS_INHIBIT | XSPI_CR_MANUAL_SSELECT
 		 | XSPI_CR_MASTER_MODE | XSPI_CR_ENABLE);
 }
@@ -110,16 +156,15 @@ static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)

 	if (is_on == BITBANG_CS_INACTIVE) {
 		/* Deselect the slave on the SPI bus */
-		out_be32(xspi->regs + XSPI_SSR_OFFSET, 0xffff);
+		xspi_write32(xspi, XSPI_SSR_OFFSET, 0xffff);
 	} else if (is_on == BITBANG_CS_ACTIVE) {
 		/* Set the SPI clock phase and polarity */
-		u16 cr = in_be16(xspi->regs + XSPI_CR_OFFSET)
-			 & ~XSPI_CR_MODE_MASK;
+		u16 cr = xspi_read16(xspi, XSPI_CR_OFFSET) & ~XSPI_CR_MODE_MASK;
 		if (spi->mode & SPI_CPHA)
 			cr |= XSPI_CR_CPHA;
 		if (spi->mode & SPI_CPOL)
 			cr |= XSPI_CR_CPOL;
-		out_be16(xspi->regs + XSPI_CR_OFFSET, cr);
+		xspi_write16(xspi, XSPI_CR_OFFSET, cr);

 		/* We do not check spi->max_speed_hz here as the SPI clock
 		 * frequency is not software programmable (the IP block design
@@ -127,7 +172,7 @@ static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
 		 */

 		/* Activate the chip select */
-		out_be32(xspi->regs + XSPI_SSR_OFFSET,
+		xspi_write32(xspi, XSPI_SSR_OFFSET,
 			 ~(0x0001 << spi->chip_select));
 	}
 }
@@ -174,15 +219,15 @@ static void xilinx_spi_fill_tx_fifo(struct xilinx_spi *xspi)
 	u8 sr;

 	/* Fill the Tx FIFO with as many bytes as possible */
-	sr = in_8(xspi->regs + XSPI_SR_OFFSET);
+	sr = xspi_read8(xspi, XSPI_SR_OFFSET);
 	while ((sr & XSPI_SR_TX_FULL_MASK) == 0 && xspi->remaining_bytes > 0) {
 		if (xspi->tx_ptr) {
-			out_8(xspi->regs + XSPI_TXD_OFFSET, *xspi->tx_ptr++);
+			xspi_write8(xspi, XSPI_TXD_OFFSET, *xspi->tx_ptr++);
 		} else {
-			out_8(xspi->regs + XSPI_TXD_OFFSET, 0);
+			xspi_write8(xspi, XSPI_TXD_OFFSET, 0);
 		}
 		xspi->remaining_bytes--;
-		sr = in_8(xspi->regs + XSPI_SR_OFFSET);
+		sr = xspi_read8(xspi, XSPI_SR_OFFSET);
 	}
 }

@@ -204,18 +249,18 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
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
@@ -232,8 +277,8 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_id)
 	u32 ipif_isr;

 	/* Get the IPIF interrupts, and clear them immediately */
-	ipif_isr = in_be32(xspi->regs + XIPIF_V123B_IISR_OFFSET);
-	out_be32(xspi->regs + XIPIF_V123B_IISR_OFFSET, ipif_isr);
+	ipif_isr = xspi_read32(xspi, XIPIF_V123B_IISR_OFFSET);
+	xspi_write32(xspi, XIPIF_V123B_IISR_OFFSET, ipif_isr);

 	if (ipif_isr & XSPI_INTR_TX_EMPTY) {	/* Transmission completed */
 		u16 cr;
@@ -244,20 +289,19 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_id)
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
 			u8 data;

-			data = in_8(xspi->regs + XSPI_RXD_OFFSET);
+			data = xspi_read8(xspi, XSPI_RXD_OFFSET);
 			if (xspi->rx_ptr) {
 				*xspi->rx_ptr++ = data;
 			}
-			sr = in_8(xspi->regs + XSPI_SR_OFFSET);
+			sr = xspi_read8(xspi, XSPI_SR_OFFSET);
 		}

 		/* See if there is more data to send */
@@ -266,7 +310,7 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_id)
 			/* Start the transfer by not inhibiting the
 			 * transmitter any longer
 			 */
-			out_be16(xspi->regs + XSPI_CR_OFFSET, cr);
+			xspi_write16(xspi, XSPI_CR_OFFSET, cr);
 		} else {
 			/* No more data to send.
 			 * Indicate the transfer is completed.
@@ -279,7 +323,7 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_id)
 }

 struct spi_master *xilinx_spi_init(struct device *dev, struct resource *mem,
-	u32 irq, s16 bus_num, u16 num_chipselect)
+	u32 irq, s16 bus_num, u16 num_chipselect, bool big_endian)
 {
 	struct spi_master *master;
 	struct xilinx_spi *xspi;
@@ -319,9 +363,10 @@ struct spi_master *xilinx_spi_init(struct device *dev, struct resource *mem,

 	xspi->mem = *mem;
 	xspi->irq = irq;
+	xspi->big_endian = big_endian;

 	/* SPI controller initializations */
-	xspi_init_hw(xspi->regs);
+	xspi_init_hw(xspi);

 	/* Register for SPI Interrupt */
 	ret = request_irq(xspi->irq, xilinx_spi_irq, 0, XILINX_SPI_NAME, xspi);
diff --git a/drivers/spi/xilinx_spi.h b/drivers/spi/xilinx_spi.h
index 84c98ee..c381c4a 100644
--- a/drivers/spi/xilinx_spi.h
+++ b/drivers/spi/xilinx_spi.h
@@ -25,7 +25,7 @@
 #define XILINX_SPI_NAME "xilinx_spi"

 struct spi_master *xilinx_spi_init(struct device *dev, struct resource *mem,
-	u32 irq, s16 bus_num, u16 num_chipselect);
+	u32 irq, s16 bus_num, u16 num_chipselect, bool big_endian);

 void xilinx_spi_deinit(struct spi_master *master);
 #endif
diff --git a/drivers/spi/xilinx_spi_of.c b/drivers/spi/xilinx_spi_of.c
index 5440253..83f23be 100644
--- a/drivers/spi/xilinx_spi_of.c
+++ b/drivers/spi/xilinx_spi_of.c
@@ -65,7 +65,8 @@ static int __init xilinx_spi_of_probe(struct of_device *ofdev,
 		dev_warn(&ofdev->dev, "no 'xlnx,num-ss-bits' property\n");
 		return -EINVAL;
 	}
-	master = xilinx_spi_init(&ofdev->dev, r_mem, r_irq->start, -1, *prop);
+	master = xilinx_spi_init(&ofdev->dev, r_mem, r_irq->start, -1, *prop,
+		true);
 	if (IS_ERR(master))
 		return PTR_ERR(master);
