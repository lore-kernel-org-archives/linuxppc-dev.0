Return-Path: <richard.rojfors@mocean-labs.com>
Received: from av7-1-sn3.vrr.skanova.net (av7-1-sn3.vrr.skanova.net
	[81.228.9.181]) by ozlabs.org (Postfix) with ESMTP id 05551B7D53
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 01:26:55 +1100 (EST)
Message-ID: <4AFC1B2D.2070809@mocean-labs.com>
Date: Thu, 12 Nov 2009 15:26:53 +0100
From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
MIME-Version: 1.0
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH v2 2/4] xilinx_spi: Switch to iomem functions and support
	little endian.
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

This patch changes the out_(be)(8|16|32) and in_(be)(8|16|32) calls to 32 bits ioread/iowrite.

The read and write function are attached to the internal struct as callbacks, callback
is selected depending on endianess.

This will also build on platforms not supporting the in/out calls for instance x86.

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
index 5761a4c..d0ca13a 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -27,7 +27,7 @@
 /* Register definitions as per "OPB Serial Peripheral Interface (SPI) (v1.00e)
  * Product Specification", DS464
  */
-#define XSPI_CR_OFFSET		0x62	/* 16-bit Control Register */
+#define XSPI_CR_OFFSET		0x60	/* 16-bit Control Register */

 #define XSPI_CR_ENABLE		0x02
 #define XSPI_CR_MASTER_MODE	0x04
@@ -39,7 +39,7 @@
 #define XSPI_CR_MANUAL_SSELECT	0x80
 #define XSPI_CR_TRANS_INHIBIT	0x100

-#define XSPI_SR_OFFSET		0x67	/* 8-bit Status Register */
+#define XSPI_SR_OFFSET		0x64	/* 8-bit Status Register */

 #define XSPI_SR_RX_EMPTY_MASK	0x01	/* Receive FIFO is empty */
 #define XSPI_SR_RX_FULL_MASK	0x02	/* Receive FIFO is full */
@@ -47,8 +47,8 @@
 #define XSPI_SR_TX_FULL_MASK	0x08	/* Transmit FIFO is full */
 #define XSPI_SR_MODE_FAULT_MASK	0x10	/* Mode fault error */

-#define XSPI_TXD_OFFSET		0x6b	/* 8-bit Data Transmit Register */
-#define XSPI_RXD_OFFSET		0x6f	/* 8-bit Data Receive Register */
+#define XSPI_TXD_OFFSET		0x68	/* 8-bit Data Transmit Register */
+#define XSPI_RXD_OFFSET		0x6c	/* 8-bit Data Receive Register */

 #define XSPI_SSR_OFFSET		0x70	/* 32-bit Slave Select Register */

@@ -86,25 +86,29 @@ struct xilinx_spi {
 	u8 *rx_ptr;		/* pointer in the Tx buffer */
 	const u8 *tx_ptr;	/* pointer in the Rx buffer */
 	int remaining_bytes;	/* the number of bytes left to transfer */
+	unsigned int (*read_fn) (void __iomem *);
+	void (*write_fn) (u32, void __iomem *);
 };

-static void xspi_init_hw(void __iomem *regs_base)
+static void xspi_init_hw(struct xilinx_spi *xspi)
 {
+	void __iomem *regs_base = xspi->regs;
+
 	/* Reset the SPI device */
-	out_be32(regs_base + XIPIF_V123B_RESETR_OFFSET,
-		 XIPIF_V123B_RESET_MASK);
+	xspi->write_fn(XIPIF_V123B_RESET_MASK,
+		regs_base + XIPIF_V123B_RESETR_OFFSET);
 	/* Disable all the interrupts just in case */
-	out_be32(regs_base + XIPIF_V123B_IIER_OFFSET, 0);
+	xspi->write_fn(0, regs_base + XIPIF_V123B_IIER_OFFSET);
 	/* Enable the global IPIF interrupt */
-	out_be32(regs_base + XIPIF_V123B_DGIER_OFFSET,
-		 XIPIF_V123B_GINTR_ENABLE);
+	xspi->write_fn(XIPIF_V123B_GINTR_ENABLE,
+		regs_base + XIPIF_V123B_DGIER_OFFSET);
 	/* Deselect the slave on the SPI bus */
-	out_be32(regs_base + XSPI_SSR_OFFSET, 0xffff);
+	xspi->write_fn(0xffff, regs_base + XSPI_SSR_OFFSET);
 	/* Disable the transmitter, enable Manual Slave Select Assertion,
 	 * put SPI controller into master mode, and enable it */
-	out_be16(regs_base + XSPI_CR_OFFSET,
-		 XSPI_CR_TRANS_INHIBIT | XSPI_CR_MANUAL_SSELECT
-		 | XSPI_CR_MASTER_MODE | XSPI_CR_ENABLE);
+	xspi->write_fn(XSPI_CR_TRANS_INHIBIT | XSPI_CR_MANUAL_SSELECT |
+		XSPI_CR_MASTER_MODE | XSPI_CR_ENABLE,
+		regs_base + XSPI_CR_OFFSET);
 }

 static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
@@ -113,16 +117,16 @@ static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)

 	if (is_on == BITBANG_CS_INACTIVE) {
 		/* Deselect the slave on the SPI bus */
-		out_be32(xspi->regs + XSPI_SSR_OFFSET, 0xffff);
+		xspi->write_fn(0xffff, xspi->regs + XSPI_SSR_OFFSET);
 	} else if (is_on == BITBANG_CS_ACTIVE) {
 		/* Set the SPI clock phase and polarity */
-		u16 cr = in_be16(xspi->regs + XSPI_CR_OFFSET)
+		u16 cr = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET)
 			 & ~XSPI_CR_MODE_MASK;
 		if (spi->mode & SPI_CPHA)
 			cr |= XSPI_CR_CPHA;
 		if (spi->mode & SPI_CPOL)
 			cr |= XSPI_CR_CPOL;
-		out_be16(xspi->regs + XSPI_CR_OFFSET, cr);
+		xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);

 		/* We do not check spi->max_speed_hz here as the SPI clock
 		 * frequency is not software programmable (the IP block design
@@ -130,8 +134,8 @@ static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
 		 */

 		/* Activate the chip select */
-		out_be32(xspi->regs + XSPI_SSR_OFFSET,
-			 ~(0x0001 << spi->chip_select));
+		xspi->write_fn(~(0x0001 << spi->chip_select),
+			xspi->regs + XSPI_SSR_OFFSET);
 	}
 }

@@ -177,15 +181,15 @@ static void xilinx_spi_fill_tx_fifo(struct xilinx_spi *xspi)
 	u8 sr;

 	/* Fill the Tx FIFO with as many bytes as possible */
-	sr = in_8(xspi->regs + XSPI_SR_OFFSET);
+	sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
 	while ((sr & XSPI_SR_TX_FULL_MASK) == 0 && xspi->remaining_bytes > 0) {
-		if (xspi->tx_ptr) {
-			out_8(xspi->regs + XSPI_TXD_OFFSET, *xspi->tx_ptr++);
-		} else {
-			out_8(xspi->regs + XSPI_TXD_OFFSET, 0);
-		}
+		if (xspi->tx_ptr)
+			xspi->write_fn(*xspi->tx_ptr++,
+				xspi->regs + XSPI_TXD_OFFSET);
+		else
+			xspi->write_fn(0, xspi->regs + XSPI_TXD_OFFSET);
 		xspi->remaining_bytes--;
-		sr = in_8(xspi->regs + XSPI_SR_OFFSET);
+		sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
 	}
 }

@@ -207,18 +211,19 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 	/* Enable the transmit empty interrupt, which we use to determine
 	 * progress on the transmission.
 	 */
-	ipif_ier = in_be32(xspi->regs + XIPIF_V123B_IIER_OFFSET);
-	out_be32(xspi->regs + XIPIF_V123B_IIER_OFFSET,
-		 ipif_ier | XSPI_INTR_TX_EMPTY);
+	ipif_ier = xspi->read_fn(xspi->regs + XIPIF_V123B_IIER_OFFSET);
+	xspi->write_fn(ipif_ier | XSPI_INTR_TX_EMPTY,
+		xspi->regs + XIPIF_V123B_IIER_OFFSET);

 	/* Start the transfer by not inhibiting the transmitter any longer */
-	cr = in_be16(xspi->regs + XSPI_CR_OFFSET) & ~XSPI_CR_TRANS_INHIBIT;
-	out_be16(xspi->regs + XSPI_CR_OFFSET, cr);
+	cr = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET) &
+		~XSPI_CR_TRANS_INHIBIT;
+	xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);

 	wait_for_completion(&xspi->done);

 	/* Disable the transmit empty interrupt */
-	out_be32(xspi->regs + XIPIF_V123B_IIER_OFFSET, ipif_ier);
+	xspi->write_fn(ipif_ier, xspi->regs + XIPIF_V123B_IIER_OFFSET);

 	return t->len - xspi->remaining_bytes;
 }
@@ -235,8 +240,8 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_id)
 	u32 ipif_isr;

 	/* Get the IPIF interrupts, and clear them immediately */
-	ipif_isr = in_be32(xspi->regs + XIPIF_V123B_IISR_OFFSET);
-	out_be32(xspi->regs + XIPIF_V123B_IISR_OFFSET, ipif_isr);
+	ipif_isr = xspi->read_fn(xspi->regs + XIPIF_V123B_IISR_OFFSET);
+	xspi->write_fn(ipif_isr, xspi->regs + XIPIF_V123B_IISR_OFFSET);

 	if (ipif_isr & XSPI_INTR_TX_EMPTY) {	/* Transmission completed */
 		u16 cr;
@@ -247,20 +252,20 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_id)
 		 * transmitter while the Isr refills the transmit register/FIFO,
 		 * or make sure it is stopped if we're done.
 		 */
-		cr = in_be16(xspi->regs + XSPI_CR_OFFSET);
-		out_be16(xspi->regs + XSPI_CR_OFFSET,
-			 cr | XSPI_CR_TRANS_INHIBIT);
+		cr = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET);
+		xspi->write_fn(cr | XSPI_CR_TRANS_INHIBIT,
+			xspi->regs + XSPI_CR_OFFSET);

 		/* Read out all the data from the Rx FIFO */
-		sr = in_8(xspi->regs + XSPI_SR_OFFSET);
+		sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
 		while ((sr & XSPI_SR_RX_EMPTY_MASK) == 0) {
 			u8 data;

-			data = in_8(xspi->regs + XSPI_RXD_OFFSET);
+			data = xspi->read_fn(xspi->regs + XSPI_RXD_OFFSET);
 			if (xspi->rx_ptr) {
 				*xspi->rx_ptr++ = data;
 			}
-			sr = in_8(xspi->regs + XSPI_SR_OFFSET);
+			sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
 		}

 		/* See if there is more data to send */
@@ -269,7 +274,7 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_id)
 			/* Start the transfer by not inhibiting the
 			 * transmitter any longer
 			 */
-			out_be16(xspi->regs + XSPI_CR_OFFSET, cr);
+			xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
 		} else {
 			/* No more data to send.
 			 * Indicate the transfer is completed.
@@ -324,9 +329,16 @@ struct spi_master *xilinx_spi_init(struct device *dev, struct resource *mem,

 	xspi->mem = *mem;
 	xspi->irq = irq;
+	if (pdata->little_endian) {
+		xspi->read_fn = ioread32;
+		xspi->write_fn = iowrite32;
+	} else {
+		xspi->read_fn = ioread32be;
+		xspi->write_fn = iowrite32be;
+	}

 	/* SPI controller initializations */
-	xspi_init_hw(xspi->regs);
+	xspi_init_hw(xspi);

 	/* Register for SPI Interrupt */
 	ret = request_irq(xspi->irq, xilinx_spi_irq, 0, XILINX_SPI_NAME, xspi);
diff --git a/include/linux/spi/xilinx_spi.h b/include/linux/spi/xilinx_spi.h
index 06df0ab..a705ad8 100644
--- a/include/linux/spi/xilinx_spi.h
+++ b/include/linux/spi/xilinx_spi.h
@@ -4,11 +4,13 @@
 /**
  * struct xspi_platform_data - Platform data of the Xilinx SPI driver
  * @num_chipselect:	Number of chip select by the IP
+ * @little_endian	If registers should be accessed little endian or not
  * @devices:		Devices to add when the driver is probed.
  * @num_devices:	Number of devices in the devices array.
  */
 struct xspi_platform_data {
 	u16 num_chipselect;
+	bool little_endian;
 	struct spi_board_info *devices;
 	u8 num_devices;
 };
