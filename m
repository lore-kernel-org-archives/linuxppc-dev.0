Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BE5BADDF6A
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 23:51:12 +1000 (EST)
Date: Thu, 26 Jul 2007 17:50:51 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH 2/3] [SPI] Add new mode: SPI_LOOP
Message-ID: <20070726135051.GB5550@localhost.localdomain>
References: <20070726134754.GA3539@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20070726134754.GA3539@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Loopback mode is supported by various controllers, this mode
is useful for testing, especially in conjunction with spidev
driver.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/spi/spidev.c       |    2 +-
 include/linux/spi/spi.h    |    1 +
 include/linux/spi/spidev.h |    1 +
 3 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 4c51a61..24c8d4d 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -57,7 +57,7 @@ static unsigned long	minors[N_SPI_MINORS / BITS_PER_LONG];
 
 /* Bit masks for spi_device.mode management */
 #define SPI_MODE_MASK			(SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | \
-					 SPI_LSB_FIRST | SPI_3WIRE)
+					 SPI_LSB_FIRST | SPI_3WIRE | SPI_LOOP)
 
 struct spidev_data {
 	struct device		dev;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 302b81d..e180615 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -77,6 +77,7 @@ struct spi_device {
 #define	SPI_CS_HIGH	0x04			/* chipselect active high? */
 #define	SPI_LSB_FIRST	0x08			/* per-word bits-on-wire */
 #define	SPI_3WIRE	0x10			/* SI/SO signals shared */
+#define	SPI_LOOP	0x20			/* loopback mode */
 	u8			bits_per_word;
 	int			irq;
 	void			*controller_state;
diff --git a/include/linux/spi/spidev.h b/include/linux/spi/spidev.h
index 369d42e..c93ef9d 100644
--- a/include/linux/spi/spidev.h
+++ b/include/linux/spi/spidev.h
@@ -38,6 +38,7 @@
 #define SPI_CS_HIGH		0x04
 #define SPI_LSB_FIRST		0x08
 #define SPI_3WIRE		0x10
+#define SPI_LOOP		0x20
 
 /*---------------------------------------------------------------------------*/
 
-- 
1.5.0.6
