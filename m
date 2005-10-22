Return-Path: <olh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9929F68601
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2005 07:30:41 +1000 (EST)
Date: Sat, 22 Oct 2005 23:30:37 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>
Message-ID: <20051022213037.GA6097@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] hide pmac specific drivers if CONFIG_ADB is not set
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This started out as a fix for https://bugzilla.novell.com/show_bug.cgi?id=119606

Hiding a few pmac specific drivers when ADB is disabled can not hurt:

AGP_UNINORTH exist only on systems with ADB_PMU
I2C_KEYWEST is used by sound
MACE exists only on systems with ADB_CUDA
BMAC exists on old and new Macs
SCSI_MESH exists on old Macs, but the PB Lombard has an external connector
SERIAL_PMACZILOG exists on old and new Macs
BLK_DEV_IDE_PMAC exists on old and new Macs
APPLE_AIRPORT exist only on systems with ADB_PMU
FB_CONTROL exists only on old Macs
FB_PLATINUM exists only on old Macs
FB_VALKYRIE exists only on old Macs
FB_CT65550 exists only on old Macs



Signed-off-by: Olaf Hering <olh@suse.de>

 drivers/char/agp/Kconfig     |    2 +-
 drivers/i2c/busses/Kconfig   |    2 +-
 drivers/ide/Kconfig          |    2 +-
 drivers/net/Kconfig          |    4 ++--
 drivers/net/wireless/Kconfig |    2 +-
 drivers/scsi/Kconfig         |    4 ++--
 drivers/serial/Kconfig       |    2 +-
 drivers/video/Kconfig        |    8 ++++----
 8 files changed, 13 insertions(+), 13 deletions(-)

Index: linux-2.6.14-rc5/drivers/char/agp/Kconfig
===================================================================
--- linux-2.6.14-rc5.orig/drivers/char/agp/Kconfig
+++ linux-2.6.14-rc5/drivers/char/agp/Kconfig
@@ -147,7 +147,7 @@ config AGP_ALPHA_CORE
 
 config AGP_UNINORTH
 	tristate "Apple UniNorth & U3 AGP support"
-	depends on AGP && PPC_PMAC
+	depends on AGP && PPC_PMAC && ADB_PMU
 	help
 	  This option gives you AGP support for Apple machines with a
 	  UniNorth or U3 (Apple G5) bridge.
Index: linux-2.6.14-rc5/drivers/i2c/busses/Kconfig
===================================================================
--- linux-2.6.14-rc5.orig/drivers/i2c/busses/Kconfig
+++ linux-2.6.14-rc5/drivers/i2c/busses/Kconfig
@@ -237,7 +237,7 @@ config I2C_IXP2000
 
 config I2C_KEYWEST
 	tristate "Powermac Keywest I2C interface"
-	depends on I2C && PPC_PMAC
+	depends on I2C && PPC_PMAC && (ADB_CUDA || ADB_PMU)
 	help
 	  This supports the use of the I2C interface in the combo-I/O
 	  chip on recent Apple machines.  Say Y if you have such a machine.
Index: linux-2.6.14-rc5/drivers/net/Kconfig
===================================================================
--- linux-2.6.14-rc5.orig/drivers/net/Kconfig
+++ linux-2.6.14-rc5/drivers/net/Kconfig
@@ -178,7 +178,7 @@ source "drivers/net/arm/Kconfig"
 
 config MACE
 	tristate "MACE (Power Mac ethernet) support"
-	depends on NET_ETHERNET && PPC_PMAC && PPC32
+	depends on NET_ETHERNET && PPC_PMAC && PPC32 && ADB_CUDA
 	select CRC32
 	help
 	  Power Macintoshes and clones with Ethernet built-in on the
@@ -201,7 +201,7 @@ config MACE_AAUI_PORT
 
 config BMAC
 	tristate "BMAC (G3 ethernet) support"
-	depends on NET_ETHERNET && PPC_PMAC && PPC32
+	depends on NET_ETHERNET && PPC_PMAC && PPC32 && (ADB_CUDA || ADB_PMU)
 	select CRC32
 	help
 	  Say Y for support of BMAC Ethernet interfaces. These are used on G3
Index: linux-2.6.14-rc5/drivers/scsi/Kconfig
===================================================================
--- linux-2.6.14-rc5.orig/drivers/scsi/Kconfig
+++ linux-2.6.14-rc5/drivers/scsi/Kconfig
@@ -1529,7 +1529,7 @@ config SCSI_DEBUG
 
 config SCSI_MESH
 	tristate "MESH (Power Mac internal SCSI) support"
-	depends on PPC32 && PPC_PMAC && SCSI
+	depends on PPC32 && PPC_PMAC && SCSI && (ADB_CUDA || ADB_PMU)
 	help
 	  Many Power Macintoshes and clones have a MESH (Macintosh Enhanced
 	  SCSI Hardware) SCSI bus adaptor (the 7200 doesn't, but all of the
@@ -1560,7 +1560,7 @@ config SCSI_MESH_RESET_DELAY_MS
 
 config SCSI_MAC53C94
 	tristate "53C94 (Power Mac external SCSI) support"
-	depends on PPC32 && PPC_PMAC && SCSI
+	depends on PPC32 && PPC_PMAC && SCSI && ADB_CUDA
 	help
 	  On Power Macintoshes (and clones) with two SCSI buses, the external
 	  SCSI bus is usually controlled by a 53C94 SCSI bus adaptor. Older
Index: linux-2.6.14-rc5/drivers/serial/Kconfig
===================================================================
--- linux-2.6.14-rc5.orig/drivers/serial/Kconfig
+++ linux-2.6.14-rc5/drivers/serial/Kconfig
@@ -651,7 +651,7 @@ config SERIAL_68360
 
 config SERIAL_PMACZILOG
 	tristate "PowerMac z85c30 ESCC support"
-	depends on PPC_OF && PPC_PMAC
+	depends on PPC_OF && PPC_PMAC && (ADB_CUDA || ADB_PMU)
 	select SERIAL_CORE
 	help
 	  This driver supports the Zilog z85C30 serial ports found on
Index: linux-2.6.14-rc5/drivers/ide/Kconfig
===================================================================
--- linux-2.6.14-rc5.orig/drivers/ide/Kconfig
+++ linux-2.6.14-rc5/drivers/ide/Kconfig
@@ -744,7 +744,7 @@ endif
 
 config BLK_DEV_IDE_PMAC
 	bool "Builtin PowerMac IDE support"
-	depends on PPC_PMAC && IDE=y
+	depends on PPC_PMAC && IDE=y && (ADB_CUDA || ADB_PMU)
 	help
 	  This driver provides support for the built-in IDE controller on
 	  most of the recent Apple Power Macintoshes and PowerBooks.
Index: linux-2.6.14-rc5/drivers/net/wireless/Kconfig
===================================================================
--- linux-2.6.14-rc5.orig/drivers/net/wireless/Kconfig
+++ linux-2.6.14-rc5/drivers/net/wireless/Kconfig
@@ -281,7 +281,7 @@ config HERMES
 
 config APPLE_AIRPORT
 	tristate "Apple Airport support (built-in)"
-	depends on PPC_PMAC && HERMES
+	depends on PPC_PMAC && HERMES && ADB_PMU
 	help
 	  Say Y here to support the Airport 802.11b wireless Ethernet hardware
 	  built into the Macintosh iBook and other recent PowerPC-based
Index: linux-2.6.14-rc5/drivers/video/Kconfig
===================================================================
--- linux-2.6.14-rc5.orig/drivers/video/Kconfig
+++ linux-2.6.14-rc5/drivers/video/Kconfig
@@ -359,7 +359,7 @@ config FB_OF
 
 config FB_CONTROL
 	bool "Apple \"control\" display support"
-	depends on (FB = y) && PPC_PMAC
+	depends on (FB = y) && PPC_PMAC && ADB_CUDA
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -371,7 +371,7 @@ config FB_CONTROL
 
 config FB_PLATINUM
 	bool "Apple \"platinum\" display support"
-	depends on (FB = y) && PPC_PMAC
+	depends on (FB = y) && PPC_PMAC && ADB_CUDA
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -383,7 +383,7 @@ config FB_PLATINUM
 
 config FB_VALKYRIE
 	bool "Apple \"valkyrie\" display support"
-	depends on (FB = y) && (MAC || PPC_PMAC)
+	depends on (FB = y) && (MAC || (PPC_PMAC && ADB_CUDA))
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -395,7 +395,7 @@ config FB_VALKYRIE
 
 config FB_CT65550
 	bool "Chips 65550 display support"
-	depends on (FB = y) && PPC
+	depends on (FB = y) && PPC_PMAC && ADB_CUDA
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
