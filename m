Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 86051DDF0D
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 04:28:33 +1100 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org,
	jacmet@sunsite.dk, git-dev@xilinx.com
Subject: [PATCH] [RFC][v2] Xilinx: Add generic configuration option to enable
	all xilinx drivers.
Date: Wed, 19 Mar 2008 10:24:42 -0700
In-Reply-To: fa686aa40803182205n741c652ci1e1871707c5c3e13@mail.gmail.com
References: fa686aa40803182205n741c652ci1e1871707c5c3e13@mail.gmail.com
Message-Id: <20080319172447.EBA579A8074@mail205-sin.bigfish.com>
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

[V2] Updated to depend on PPC32, rather than just XILINX_VIRTEX, to let
these drivers be compiled in more configurations.

---

Grant,

There is still the issue of the ppc part, which is
required for backward compatibility.  If this has to wait until ppc
dies, then that's fine with me, I guess.

Steve
---
 drivers/block/Kconfig  |    2 +-
 drivers/char/Kconfig   |    2 +-
 drivers/misc/Kconfig   |   17 +++++++++++++++++
 drivers/serial/Kconfig |    2 +-
 drivers/spi/Kconfig    |    2 +-
 drivers/video/Kconfig  |    2 +-
 6 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 4d0119e..7f55ba4 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -412,7 +412,7 @@ source "drivers/s390/block/Kconfig"
 
 config XILINX_SYSACE
 	tristate "Xilinx SystemACE support"
-	depends on 4xx
+	depends on XILINX_DRIVERS
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
index b5e67c0..89f9309 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -233,3 +233,20 @@ config ATMEL_SSC
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
+	bool
+	depends on PPC32
+	default y
+	---help---
+	  This option is used to enable all of the Xilinx drivers on
+	  supported architectures.  This is often useful if you have a
+	  Xilinx FPGA in a system, either using embedded processors
+	  internal to the FPGA or external processors.
+
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index d7e1996..d4e8879 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -757,7 +757,7 @@ config SERIAL_IMX_CONSOLE
 
 config SERIAL_UARTLITE
 	tristate "Xilinx uartlite serial port support"
-	depends on PPC32
+	depends on XILINX_DRIVERS
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
