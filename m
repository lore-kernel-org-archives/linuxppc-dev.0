Return-Path: <hs@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6FAADB708C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 16:36:01 +1000 (EST)
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id A4DC7DDD01
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 16:35:59 +1000 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by b.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	866D531B01B
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 08:35:47 +0200 (CEST)
Received: from [192.168.1.6] ([82.131.206.253])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KNZ00E5BUBJJP90@invitel.hu> for
	linuxppc-dev@ozlabs.org; Fri, 07 Aug 2009 08:35:44 +0200 (CEST)
Date: Fri, 07 Aug 2009 08:41:15 +0200
From: Heiko Schocher <hs@denx.de>
Subject: [PATCH v3 2/2] 82xx, mgcoge: update defconfig for 2.6.32
In-reply-to: <40E28EF5-215D-4D69-B44E-CD3145652F9B@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Message-id: <4A7BCC8B.8080704@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <4A769326.9090302@denx.de>
	<40E28EF5-215D-4D69-B44E-CD3145652F9B@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- add I2C support
- add FCC1 and FCC2 support

Signed-off-by: Heiko Schocher <hs@denx.de>
---
- against git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
  next branch
- checked with checkpatch.pl:
$ ./scripts/checkpatch.pl 0001-82xx-mgcoge-update-defconfig-for-2.6.32.patch
total: 0 errors, 0 warnings, 134 lines checked

0001-82xx-mgcoge-update-defconfig-for-2.6.32.patch has no obvious style problems and is ready for submission.
$

- changes since v1
  - Add comments from David Gibson
    removed 2 "device_type" entries
  - Add comment from Kumar Gala
    splittet into 2 patches (seperated defconfig patch)
- changes since v2
  - based against kumars tree, next branch

 arch/powerpc/configs/mgcoge_defconfig |   86 ++++++++++++++++++++++++++++++--
 1 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/configs/mgcoge_defconfig b/arch/powerpc/configs/mgcoge_defconfig
index e9491c1..30b68bf 100644
--- a/arch/powerpc/configs/mgcoge_defconfig
+++ b/arch/powerpc/configs/mgcoge_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.31-rc4
-# Wed Jul 29 23:31:51 2009
+# Linux kernel version: 2.6.31-rc5
+# Fri Aug  7 08:19:15 2009
 #
 # CONFIG_PPC64 is not set

@@ -158,6 +158,7 @@ CONFIG_BASE_SMALL=0
 # CONFIG_MODULES is not set
 CONFIG_BLOCK=y
 CONFIG_LBDAF=y
+CONFIG_BLK_DEV_BSG=y
 # CONFIG_BLK_DEV_INTEGRITY is not set

 #
@@ -506,6 +507,7 @@ CONFIG_MTD_PHYSMAP_OF=y
 # CONFIG_MTD_UBI is not set
 CONFIG_OF_DEVICE=y
 CONFIG_OF_GPIO=y
+CONFIG_OF_I2C=y
 CONFIG_OF_MDIO=y
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
@@ -582,7 +584,8 @@ CONFIG_PHYLIB=y
 # CONFIG_STE10XP is not set
 # CONFIG_LSI_ET1011C_PHY is not set
 CONFIG_FIXED_PHY=y
-# CONFIG_MDIO_BITBANG is not set
+CONFIG_MDIO_BITBANG=y
+# CONFIG_MDIO_GPIO is not set
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
 # CONFIG_MACE is not set
@@ -608,8 +611,8 @@ CONFIG_MII=y
 # CONFIG_ATL2 is not set
 CONFIG_FS_ENET=y
 CONFIG_FS_ENET_HAS_SCC=y
-# CONFIG_FS_ENET_HAS_FCC is not set
-# CONFIG_FS_ENET_MDIO_FCC is not set
+CONFIG_FS_ENET_HAS_FCC=y
+CONFIG_FS_ENET_MDIO_FCC=y
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set
@@ -680,7 +683,68 @@ CONFIG_HW_RANDOM=y
 # CONFIG_APPLICOM is not set
 # CONFIG_RAW_DRIVER is not set
 CONFIG_DEVPORT=y
-# CONFIG_I2C is not set
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_HELPER_AUTO=y
+
+#
+# I2C Hardware Bus support
+#
+
+#
+# PC SMBus host controller drivers
+#
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_ISCH is not set
+# CONFIG_I2C_PIIX4 is not set
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_VIAPRO is not set
+
+#
+# Mac SMBus host controller drivers
+#
+# CONFIG_I2C_POWERMAC is not set
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
+CONFIG_I2C_CPM=y
+# CONFIG_I2C_DESIGNWARE is not set
+# CONFIG_I2C_GPIO is not set
+# CONFIG_I2C_MPC is not set
+# CONFIG_I2C_SIMTEC is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
+
+#
+# Graphics adapter I2C/DDC channel drivers
+#
+# CONFIG_I2C_VOODOO3 is not set
+
+#
+# Other I2C/SMBus bus drivers
+#
+# CONFIG_I2C_PCA_PLATFORM is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_PCF8575 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
 # CONFIG_SPI is not set

 #
@@ -699,6 +763,9 @@ CONFIG_GPIOLIB=y
 #
 # I2C GPIO expanders:
 #
+# CONFIG_GPIO_MAX732X is not set
+# CONFIG_GPIO_PCA953X is not set
+# CONFIG_GPIO_PCF857X is not set

 #
 # PCI GPIO expanders:
@@ -727,7 +794,14 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_CORE is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set
+# CONFIG_TPS65010 is not set
+# CONFIG_TWL4030_CORE is not set
 # CONFIG_MFD_TMIO is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_PCF50633 is not set
+# CONFIG_AB3100_CORE is not set
 # CONFIG_REGULATOR is not set
 # CONFIG_MEDIA_SUPPORT is not set

-- 
1.6.0.6

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
