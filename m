Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 88B66DDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 08:31:25 +1100 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: linuxppc-dev@ozlabs.org, grant.likely@secretlab.ca,
	jacmet@sunsite.dk
Subject: [PATCH] [RFC] Xilinx: Add generic configuration option to enable all
	xilinx drivers.
Date: Tue, 12 Feb 2008 13:31:12 -0800
Message-Id: <20080212213120.D51157F806B@mail176-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In the future, this will be used to provide similar configuration for
PowerPC and Microblaze.  It may also be convenient for those using
Xilinx cores as peripherals for external processors, rather than
explicitly having a dependance on the processor architecture.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

---

Grant,

This is the patch, updated for all of the drivers that I think are in
the tree.  I think the problematic parts may be the ppc part, which is
required for backward compatibility.  If this has to wait until ppc
dies, then that's fine with me, I guess.

It may also be better to clean up the Kconfig lines for Sysace and
framebuffer drivers by having PPC32 or PPC4xx select XILINX_DRIVERS.
My understanding is that those config options are there because of
people using external PPCs with those devices in the FPGA.

Steve
---
 arch/powerpc/platforms/40x/Kconfig |    1 +
 arch/ppc/platforms/4xx/Kconfig     |    1 +
 drivers/block/Kconfig              |    2 +-
 drivers/char/Kconfig               |    2 +-
 drivers/misc/Kconfig               |   10 ++++++++++
 drivers/serial/Kconfig             |    2 +-
 drivers/spi/Kconfig                |    2 +-
 drivers/video/Kconfig              |    2 +-
 8 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index 8f6699f..03051bc 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -110,6 +110,7 @@ config 405GPR
 
 config XILINX_VIRTEX
 	bool
+	select XILINX_DRIVERS
 
 config XILINX_VIRTEX_II_PRO
 	bool
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
index 76551b6..d7db7e4 100644
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -228,6 +228,7 @@ config XILINX_VIRTEX_4_FX
 
 config XILINX_VIRTEX
 	bool
+	select XILINX_DRIVERS
 
 config STB03xxx
 	bool
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 4d0119e..0166560 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -412,7 +412,7 @@ source "drivers/s390/block/Kconfig"
 
 config XILINX_SYSACE
 	tristate "Xilinx SystemACE support"
-	depends on 4xx
+	depends on 4xx || XILINX_DRIVERS
 	help
 	  Include support for the Xilinx SystemACE CompactFlash interface
 
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 157ae2a..8230ad1 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -833,7 +833,7 @@ config DTLK
 
 config XILINX_HWICAP
 	tristate "Xilinx HWICAP Support"
-	depends on XILINX_VIRTEX
+	depends on XILINX_DRIVERS
 	help
 	  This option enables support for Xilinx Internal Configuration
 	  Access Port (ICAP) driver.
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index b5e67c0..e7b0bed 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -233,3 +233,13 @@ config ATMEL_SSC
 	  If unsure, say N.
 
 endif # MISC_DEVICES
+endmenu
+
+
+#
+# Xilinx devices and common device driver infrastructure
+#
+
+config XILINX_DRIVERS
+  bool
+
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index d7e1996..f922ec6 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -757,7 +757,7 @@ config SERIAL_IMX_CONSOLE
 
 config SERIAL_UARTLITE
 	tristate "Xilinx uartlite serial port support"
-	depends on PPC32
+	depends on PPC32 || XILINX_DRIVERS
 	select SERIAL_CORE
 	help
 	  Say Y here if you want to use the Xilinx uartlite serial controller.
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index abf0504..c66838f 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -183,7 +183,7 @@ config SPI_TXX9
 
 config SPI_XILINX
 	tristate "Xilinx SPI controller"
-	depends on SPI_MASTER && XILINX_VIRTEX && EXPERIMENTAL
+	depends on SPI_MASTER && XILINX_DRIVERS && EXPERIMENTAL
 	select SPI_BITBANG
 	help
 	  This exposes the SPI controller IP from the Xilinx EDK.
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 5b3dbcf..a66ff4b 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1871,7 +1871,7 @@ config FB_PS3_DEFAULT_SIZE_M
 
 config FB_XILINX
 	tristate "Xilinx frame buffer support"
-	depends on FB && XILINX_VIRTEX
+	depends on FB && XILINX_DRIVERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.5.3.4-dirty
