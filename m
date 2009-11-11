Return-Path: <richard.rojfors@mocean-labs.com>
Received: from av6-1-sn3.vrr.skanova.net (av6-1-sn3.vrr.skanova.net
	[81.228.9.179]) by ozlabs.org (Postfix) with ESMTP id B3F93B7093
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 01:39:48 +1100 (EST)
Message-ID: <4AFACCAC.10304@mocean-labs.com>
Date: Wed, 11 Nov 2009 15:39:40 +0100
From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
MIME-Version: 1.0
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH 3/4] xilinx_spi: add support for the DS570 IP.
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

This patch adds in support for the DS570 IP.

It's register compatible with the DS464, but adds support for 8/16/32 SPI.

Signed-off-by: Richard Röjfors <richard.rojfors@mocean-labs.com>
---
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9667650..b956284 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -235,7 +235,7 @@ config SPI_TXX9
 	  SPI driver for Toshiba TXx9 MIPS SoCs

 config SPI_XILINX
-	tristate "Xilinx SPI controller"
+	tristate "Xilinx SPI controller common module"
 	depends on HAS_IOMEM && EXPERIMENTAL
 	select SPI_BITBANG
 	help
@@ -244,6 +244,8 @@ config SPI_XILINX
 	  See the "OPB Serial Peripheral Interface (SPI) (v1.00e)"
 	  Product Specification document (DS464) for hardware details.

+	  Or for the DS570, see "XPS Serial Peripheral Interface (SPI) (v2.00b)"
+
 config SPI_XILINX_OF
 	tristate "Xilinx SPI controller OF device"
 	depends on SPI_XILINX && (XILINX_VIRTEX || MICROBLAZE)
diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index b00dabc..ae744ba 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -24,7 +24,7 @@
 /* Register definitions as per "OPB Serial Peripheral Interface (SPI) (v1.00e)
  * Product Specification", DS464
  */
-#define XSPI_CR_OFFSET		0x60	/* 16-bit Control Register */
+#define XSPI_CR_OFFSET		0x60	/* Control Register */

 #define XSPI_CR_ENABLE		0x02
 #define XSPI_CR_MASTER_MODE	0x04
@@ -35,8 +35,9 @@
 #define XSPI_CR_RXFIFO_RESET	0x40
 #define XSPI_CR_MANUAL_SSELECT	0x80
 #define XSPI_CR_TRANS_INHIBIT	0x100
+#define XSPI_CR_LSB_FIRST	0x200

-#define XSPI_SR_OFFSET		0x64	/* 8-bit Status Register */
+#define XSPI_SR_OFFSET		0x64	/* Status Register */

 #define XSPI_SR_RX_EMPTY_MASK	0x01	/* Receive FIFO is empty */
 #define XSPI_SR_RX_FULL_MASK	0x02	/* Receive FIFO is full */
@@ -44,8 +45,8 @@
 #define XSPI_SR_TX_FULL_MASK	0x08	/* Transmit FIFO is full */
 #define XSPI_SR_MODE_FAULT_MASK	0x10	/* Mode fault error */

-#define XSPI_TXD_OFFSET		0x68	/* 8-bit Data Transmit Register */
-#define XSPI_RXD_OFFSET		0x6c	/* 8-bit Data Receive Register */
+#define XSPI_TXD_OFFSET		0x68	/* Data Transmit Register */
+#define XSPI_RXD_OFFSET		0x6c	/* Data Receive Register */

 #define XSPI_SSR_OFFSET		0x70	/* 32-bit Slave Select Register */

@@ -65,6 +66,7 @@
 #define XSPI_INTR_TX_UNDERRUN		0x08	/* TxFIFO was underrun */
 #define XSPI_INTR_RX_FULL		0x10	/* RxFIFO is full */
 #define XSPI_INTR_RX_OVERRUN		0x20	/* RxFIFO was overrun */
+#define XSPI_INTR_TX_HALF_EMPTY		0x40	/* TxFIFO is half empty */

 #define XIPIF_V123B_RESETR_OFFSET	0x40	/* IPIF reset register */
 #define XIPIF_V123B_RESET_MASK		0x0a	/* the value to write */
@@ -86,6 +88,7 @@ struct xilinx_spi {
 	bool big_endian;	/* The device could be accessed big or little
 				 * endian
 				 */
+	u8 bits_per_word;
 };

 /* to follow are some functions that does little of big endian read and
@@ -146,8 +149,9 @@ static void xspi_init_hw(struct xilinx_spi *xspi)
 	/* Disable the transmitter, enable Manual Slave Select Assertion,
 	 * put SPI controller into master mode, and enable it */
 	xspi_write16(xspi, XSPI_CR_OFFSET,
-		 XSPI_CR_TRANS_INHIBIT | XSPI_CR_MANUAL_SSELECT
-		 | XSPI_CR_MASTER_MODE | XSPI_CR_ENABLE);
+		XSPI_CR_TRANS_INHIBIT | XSPI_CR_MANUAL_SSELECT |
+		XSPI_CR_MASTER_MODE | XSPI_CR_ENABLE | XSPI_CR_TXFIFO_RESET |
+		XSPI_CR_RXFIFO_RESET);
 }

 static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
@@ -179,17 +183,20 @@ static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)

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
@@ -200,33 +207,49 @@ static int xilinx_spi_setup_transfer(struct spi_device *spi,

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
 	sr = xspi_read8(xspi, XSPI_SR_OFFSET);
-	while ((sr & XSPI_SR_TX_FULL_MASK) == 0 && xspi->remaining_bytes > 0) {
+	while ((sr & XSPI_SR_TX_FULL_MASK) == 0 &&
+		xspi->remaining_bytes > 0) {
 		if (xspi->tx_ptr) {
-			xspi_write8(xspi, XSPI_TXD_OFFSET, *xspi->tx_ptr++);
-		} else {
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
 			xspi_write8(xspi, XSPI_TXD_OFFSET, 0);
-		}
-		xspi->remaining_bytes--;
+		xspi->remaining_bytes -= wsize;
 		sr = xspi_read8(xspi, XSPI_SR_OFFSET);
 	}
 }
@@ -283,6 +306,13 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_id)
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
@@ -295,11 +325,22 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_id)
 		/* Read out all the data from the Rx FIFO */
 		sr = xspi_read8(xspi, XSPI_SR_OFFSET);
 		while ((sr & XSPI_SR_RX_EMPTY_MASK) == 0) {
-			u8 data;
+			u32 data;
+			if (rsize == 1)
+				data = xspi_read8(xspi, XSPI_RXD_OFFSET);
+			else if (rsize == 2)
+				data = xspi_read16(xspi, XSPI_RXD_OFFSET);
+			else
+				data = xspi_read32(xspi, XSPI_RXD_OFFSET);

-			data = xspi_read8(xspi, XSPI_RXD_OFFSET);
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
 			sr = xspi_read8(xspi, XSPI_SR_OFFSET);
 		}
@@ -323,7 +364,8 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_id)
 }

 struct spi_master *xilinx_spi_init(struct device *dev, struct resource *mem,
-	u32 irq, s16 bus_num, u16 num_chipselect, bool big_endian)
+	u32 irq, s16 bus_num, u16 num_chipselect, bool big_endian,
+	u8 bits_per_word)
 {
 	struct spi_master *master;
 	struct xilinx_spi *xspi;
@@ -364,6 +406,7 @@ struct spi_master *xilinx_spi_init(struct device *dev, struct resource *mem,
 	xspi->mem = *mem;
 	xspi->irq = irq;
 	xspi->big_endian = big_endian;
+	xspi->bits_per_word = bits_per_word;

 	/* SPI controller initializations */
 	xspi_init_hw(xspi);
diff --git a/drivers/spi/xilinx_spi.h b/drivers/spi/xilinx_spi.h
index c381c4a..f73c35d 100644
--- a/drivers/spi/xilinx_spi.h
+++ b/drivers/spi/xilinx_spi.h
@@ -25,7 +25,8 @@
 #define XILINX_SPI_NAME "xilinx_spi"

 struct spi_master *xilinx_spi_init(struct device *dev, struct resource *mem,
-	u32 irq, s16 bus_num, u16 num_chipselect, bool big_endian);
+	u32 irq, s16 bus_num, u16 num_chipselect, bool big_endian,
+	u8 bits_per_word);

 void xilinx_spi_deinit(struct spi_master *master);
 #endif
diff --git a/drivers/spi/xilinx_spi_of.c b/drivers/spi/xilinx_spi_of.c
index 83f23be..b9fa4e9 100644
--- a/drivers/spi/xilinx_spi_of.c
+++ b/drivers/spi/xilinx_spi_of.c
@@ -66,7 +66,7 @@ static int __init xilinx_spi_of_probe(struct of_device *ofdev,
 		return -EINVAL;
 	}
 	master = xilinx_spi_init(&ofdev->dev, r_mem, r_irq->start, -1, *prop,
-		true);
+		true, 8);
 	if (IS_ERR(master))
 		return PTR_ERR(master);
