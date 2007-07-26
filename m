Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 80567DDEBE
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 23:51:04 +1000 (EST)
Date: Thu, 26 Jul 2007 17:50:41 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH 1/3] [SPI] Sync spidev.{h,c} with spi.h
Message-ID: <20070726135041.GA5550@localhost.localdomain>
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

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/spi/spidev.c       |    4 ++--
 include/linux/spi/spidev.h |    3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 38b60ad..4c51a61 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -56,8 +56,8 @@ static unsigned long	minors[N_SPI_MINORS / BITS_PER_LONG];
 
 
 /* Bit masks for spi_device.mode management */
-#define SPI_MODE_MASK			(SPI_CPHA | SPI_CPOL)
-
+#define SPI_MODE_MASK			(SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | \
+					 SPI_LSB_FIRST | SPI_3WIRE)
 
 struct spidev_data {
 	struct device		dev;
diff --git a/include/linux/spi/spidev.h b/include/linux/spi/spidev.h
index 7d700be..369d42e 100644
--- a/include/linux/spi/spidev.h
+++ b/include/linux/spi/spidev.h
@@ -35,6 +35,9 @@
 #define SPI_MODE_2		(SPI_CPOL|0)
 #define SPI_MODE_3		(SPI_CPOL|SPI_CPHA)
 
+#define SPI_CS_HIGH		0x04
+#define SPI_LSB_FIRST		0x08
+#define SPI_3WIRE		0x10
 
 /*---------------------------------------------------------------------------*/
 
-- 
1.5.0.6
