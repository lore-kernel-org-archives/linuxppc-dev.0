Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C9898DE10F
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 07:57:01 +1000 (EST)
Date: Tue, 10 Apr 2007 16:56:53 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/4] powerpc: turn on corresponding PHY drivers in QE UEC
	platforms defconfigs
Message-Id: <20070410165653.7b3e3569.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
please consider for 2.6.22

 arch/powerpc/configs/mpc832x_mds_defconfig |   67 +++++++++++++++++++++-------
 arch/powerpc/configs/mpc832x_rdb_defconfig |   28 +++++++----
 arch/powerpc/configs/mpc836x_mds_defconfig |   42 ++++++++++++-----
 3 files changed, 97 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/configs/mpc832x_mds_defconfig b/arch/powerpc/configs/mpc832x_mds_defconfig
index e1b36de..83192c0 100644
--- a/arch/powerpc/configs/mpc832x_mds_defconfig
+++ b/arch/powerpc/configs/mpc832x_mds_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20-rc5
-# Tue Jan 30 14:27:25 2007
+# Linux kernel version: 2.6.21-rc5
+# Mon Apr  9 16:09:16 2007
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -34,9 +34,9 @@ CONFIG_DEFAULT_UIMAGE=y
 CONFIG_PPC_83xx=y
 # CONFIG_PPC_85xx is not set
 # CONFIG_PPC_86xx is not set
+# CONFIG_PPC_8xx is not set
 # CONFIG_40x is not set
 # CONFIG_44x is not set
-# CONFIG_8xx is not set
 # CONFIG_E200 is not set
 CONFIG_6xx=y
 CONFIG_83xx=y
@@ -63,6 +63,7 @@ CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_IPC_NS is not set
+CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
@@ -71,6 +72,7 @@ CONFIG_SYSVIPC=y
 # CONFIG_IKCONFIG is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
@@ -123,16 +125,17 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
 CONFIG_QUICC_ENGINE=y
-CONFIG_PPC_GEN550=y
 # CONFIG_WANT_EARLY_SERIAL is not set
 
 #
 # Platform support
 #
+# CONFIG_MPC8313_RDB is not set
 CONFIG_MPC832x_MDS=y
-# CONFIG_MPC834x_SYS is not set
+# CONFIG_MPC832x_RDB is not set
+# CONFIG_MPC834x_MDS is not set
 # CONFIG_MPC834x_ITX is not set
-# CONFIG_MPC8360E_PB is not set
+# CONFIG_MPC836x_MDS is not set
 CONFIG_PPC_MPC832x=y
 # CONFIG_MPIC is not set
 
@@ -163,6 +166,7 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
@@ -172,6 +176,7 @@ CONFIG_ISA_DMA_API=y
 #
 # Bus options
 #
+CONFIG_ZONE_DMA=y
 CONFIG_GENERIC_ISA_DMA=y
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
@@ -220,6 +225,7 @@ CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
 # CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -324,6 +330,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # Plug and Play support
 #
+# CONFIG_PNPACPI is not set
 
 #
 # Block devices
@@ -342,7 +349,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=32768
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
@@ -482,7 +488,21 @@ CONFIG_NETDEVICES=y
 #
 # PHY device support
 #
-# CONFIG_PHYLIB is not set
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+CONFIG_DAVICOM_PHY=y
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_FIXED_PHY is not set
 
 #
 # Ethernet (10 or 100Mbit)
@@ -524,11 +544,13 @@ CONFIG_UCC_GETH=y
 # CONFIG_UGETH_FILTERING is not set
 # CONFIG_UGETH_TX_ON_DEMOND is not set
 # CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
 
 #
 # Ethernet (10000 Mbit)
 #
 # CONFIG_CHELSIO_T1 is not set
+# CONFIG_CHELSIO_T3 is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
@@ -621,6 +643,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
+# CONFIG_SERIAL_OF_PLATFORM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -691,6 +714,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_OCORES is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PASEMI is not set
 # CONFIG_I2C_PROSAVAGE is not set
 # CONFIG_I2C_SAVAGE4 is not set
 # CONFIG_I2C_SIS5595 is not set
@@ -738,6 +762,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_ADM1021 is not set
 # CONFIG_SENSORS_ADM1025 is not set
 # CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1029 is not set
 # CONFIG_SENSORS_ADM1031 is not set
 # CONFIG_SENSORS_ADM9240 is not set
 # CONFIG_SENSORS_ASB100 is not set
@@ -779,6 +804,11 @@ CONFIG_HWMON=y
 # CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -791,10 +821,9 @@ CONFIG_HWMON=y
 #
 # Graphics support
 #
-CONFIG_FIRMWARE_EDID=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 # CONFIG_FB is not set
 # CONFIG_FB_IBM_GXT4500 is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -805,6 +834,7 @@ CONFIG_FIRMWARE_EDID=y
 # HID Devices
 #
 CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
 
 #
 # USB support
@@ -869,6 +899,10 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 #
 
 #
+# Auxiliary Display support
+#
+
+#
 # Virtualization
 #
 
@@ -995,11 +1029,7 @@ CONFIG_PARTITION_ADVANCED=y
 # Distributed Lock Manager
 #
 # CONFIG_DLM is not set
-
-#
-# QE Options
-#
-CONFIG_UCC_SLOW=y
+# CONFIG_UCC_SLOW is not set
 CONFIG_UCC_FAST=y
 CONFIG_UCC=y
 
@@ -1012,7 +1042,8 @@ CONFIG_BITREVERSE=y
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=y
-CONFIG_IOMAP_COPY=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
 
 #
 # Instrumentation Support
@@ -1032,7 +1063,6 @@ CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_BOOTX_TEXT is not set
-# CONFIG_SERIAL_TEXT_DEBUG is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
 
 #
@@ -1061,8 +1091,10 @@ CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_GF128MUL is not set
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_LRW is not set
 CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
 # CONFIG_CRYPTO_SERPENT is not set
@@ -1076,6 +1108,7 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_DEFLATE is not set
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_TEST is not set
 
 #
diff --git a/arch/powerpc/configs/mpc832x_rdb_defconfig b/arch/powerpc/configs/mpc832x_rdb_defconfig
index 56fc0a8..4a4da87 100644
--- a/arch/powerpc/configs/mpc832x_rdb_defconfig
+++ b/arch/powerpc/configs/mpc832x_rdb_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.21-rc3
-# Mon Mar 12 17:32:19 2007
+# Linux kernel version: 2.6.21-rc5
+# Mon Apr  9 16:12:43 2007
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -125,7 +125,6 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
 CONFIG_QUICC_ENGINE=y
-CONFIG_PPC_GEN550=y
 # CONFIG_WANT_EARLY_SERIAL is not set
 
 #
@@ -490,7 +489,21 @@ CONFIG_NETDEVICES=y
 #
 # PHY device support
 #
-# CONFIG_PHYLIB is not set
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
+CONFIG_ICPLUS_PHY=y
+# CONFIG_FIXED_PHY is not set
 
 #
 # Ethernet (10 or 100Mbit)
@@ -1200,11 +1213,7 @@ CONFIG_NLS_ISO8859_1=y
 # Distributed Lock Manager
 #
 # CONFIG_DLM is not set
-
-#
-# QE Options
-#
-CONFIG_UCC_SLOW=y
+# CONFIG_UCC_SLOW is not set
 CONFIG_UCC_FAST=y
 CONFIG_UCC=y
 
@@ -1238,7 +1247,6 @@ CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_BOOTX_TEXT is not set
-# CONFIG_SERIAL_TEXT_DEBUG is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
 
 #
diff --git a/arch/powerpc/configs/mpc836x_mds_defconfig b/arch/powerpc/configs/mpc836x_mds_defconfig
index 8eb475c..921a151 100644
--- a/arch/powerpc/configs/mpc836x_mds_defconfig
+++ b/arch/powerpc/configs/mpc836x_mds_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Sat Feb 17 10:09:26 2007
+# Linux kernel version: 2.6.21-rc5
+# Mon Apr  9 16:14:05 2007
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -72,6 +72,7 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_IKCONFIG is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
@@ -124,7 +125,6 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
 CONFIG_QUICC_ENGINE=y
-CONFIG_PPC_GEN550=y
 # CONFIG_WANT_EARLY_SERIAL is not set
 
 #
@@ -132,6 +132,7 @@ CONFIG_PPC_GEN550=y
 #
 # CONFIG_MPC8313_RDB is not set
 # CONFIG_MPC832x_MDS is not set
+# CONFIG_MPC832x_RDB is not set
 # CONFIG_MPC834x_MDS is not set
 # CONFIG_MPC834x_ITX is not set
 CONFIG_MPC836x_MDS=y
@@ -328,6 +329,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # Plug and Play support
 #
+# CONFIG_PNPACPI is not set
 
 #
 # Block devices
@@ -346,7 +348,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=32768
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
@@ -486,7 +487,21 @@ CONFIG_NETDEVICES=y
 #
 # PHY device support
 #
-# CONFIG_PHYLIB is not set
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+CONFIG_MARVELL_PHY=y
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_FIXED_PHY is not set
 
 #
 # Ethernet (10 or 100Mbit)
@@ -528,6 +543,7 @@ CONFIG_UCC_GETH=y
 # CONFIG_UGETH_FILTERING is not set
 # CONFIG_UGETH_TX_ON_DEMOND is not set
 # CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
 
 #
 # Ethernet (10000 Mbit)
@@ -745,6 +761,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_ADM1021 is not set
 # CONFIG_SENSORS_ADM1025 is not set
 # CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1029 is not set
 # CONFIG_SENSORS_ADM1031 is not set
 # CONFIG_SENSORS_ADM9240 is not set
 # CONFIG_SENSORS_ASB100 is not set
@@ -786,6 +803,11 @@ CONFIG_HWMON=y
 # CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -798,10 +820,9 @@ CONFIG_HWMON=y
 #
 # Graphics support
 #
-CONFIG_FIRMWARE_EDID=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 # CONFIG_FB is not set
 # CONFIG_FB_IBM_GXT4500 is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -1007,11 +1028,7 @@ CONFIG_PARTITION_ADVANCED=y
 # Distributed Lock Manager
 #
 # CONFIG_DLM is not set
-
-#
-# QE Options
-#
-CONFIG_UCC_SLOW=y
+# CONFIG_UCC_SLOW is not set
 CONFIG_UCC_FAST=y
 CONFIG_UCC=y
 
@@ -1045,7 +1062,6 @@ CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_BOOTX_TEXT is not set
-# CONFIG_SERIAL_TEXT_DEBUG is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
 
 #
-- 
1.5.0.1
