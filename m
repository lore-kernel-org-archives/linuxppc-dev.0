Return-Path: <richard.rojfors@mocean-labs.com>
Received: from av8-2-sn3.vrr.skanova.net (av8-2-sn3.vrr.skanova.net
	[81.228.9.184]) by ozlabs.org (Postfix) with ESMTP id C36ACB7BC2
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 03:38:10 +1100 (EST)
Message-ID: <4AFAE870.7080308@mocean-labs.com>
Date: Wed, 11 Nov 2009 17:38:08 +0100
From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
MIME-Version: 1.0
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH v2] xilinx_spi: Add the platform driver to the Kconfig
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

This patch adds the xilinx_spi_pltfm to the SPI Kconfig and Makefile.

The xilinx_spi_pltfm was added in a previous patchset.

Signed-off-by: Richard Röjfors <richard.rojfors@mocean-labs.com>
---
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b956284..d1f8ee3 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -252,6 +252,13 @@ config SPI_XILINX_OF
 	help
 	  This is the OF driver for the SPI controller IP from the Xilinx EDK.

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
index 97dee8f..d8b0e4c 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_SPI_S3C24XX)		+= spi_s3c24xx.o
 obj-$(CONFIG_SPI_TXX9)			+= spi_txx9.o
 obj-$(CONFIG_SPI_XILINX)		+= xilinx_spi.o
 obj-$(CONFIG_SPI_XILINX_OF)		+= xilinx_spi_of.o
+obj-$(CONFIG_SPI_XILINX_PLTFM)		+= xilinx_spi_pltfm.o
 obj-$(CONFIG_SPI_SH_SCI)		+= spi_sh_sci.o
 obj-$(CONFIG_SPI_STMP3XXX)		+= spi_stmp.o
 # 	... add above this line ...
