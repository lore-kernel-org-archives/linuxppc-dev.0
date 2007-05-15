Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 3/3] Fixes to allow use of Ebony's flash chips through
	physmap_of
In-Reply-To: <20070515045247.GA6998@localhost.localdomain>
Message-Id: <20070515045415.98889DDED7@ozlabs.org>
Date: Tue, 15 May 2007 14:54:15 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch contains a handful of small fixes to allow the Ebony's
flash to be exposed as MTD devices via the physmap_of driver.
Specifically it:
	- Makes a small addition to the device tree and zImage wrapper
to record the correct address for the flash in the device tree based
on the board switches as reported via an FPGA register.
	- Prohibits building the old hard-coded "Ebony" flash map on
arch/powerpc kernels, in favour of using physmap_of's device tree
based approach.
	- Enables MTD and physmap_of in the Ebony defconfig.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

 arch/powerpc/boot/dts/ebony.dts      |    1 
 arch/powerpc/boot/ebony.c            |   41 +++++++++
 arch/powerpc/configs/ebony_defconfig |  148 ++++++++++++++++++++++++++---------
 drivers/mtd/maps/Kconfig             |    2 
 4 files changed, 154 insertions(+), 38 deletions(-)

Index: working-2.6/drivers/mtd/maps/Kconfig
===================================================================
--- working-2.6.orig/drivers/mtd/maps/Kconfig	2007-05-14 14:37:57.000000000 +1000
+++ working-2.6/drivers/mtd/maps/Kconfig	2007-05-14 14:45:58.000000000 +1000
@@ -368,7 +368,7 @@ config MTD_WALNUT
 
 config MTD_EBONY
 	tristate "Flash devices mapped on IBM 440GP Ebony"
-	depends on MTD_JEDECPROBE && EBONY
+	depends on MTD_JEDECPROBE && EBONY && !PPC_MERGE
 	help
 	  This enables access routines for the flash chips on the IBM 440GP
 	  Ebony board. If you have one of these boards and would like to
Index: working-2.6/arch/powerpc/configs/ebony_defconfig
===================================================================
--- working-2.6.orig/arch/powerpc/configs/ebony_defconfig	2007-05-14 14:37:57.000000000 +1000
+++ working-2.6/arch/powerpc/configs/ebony_defconfig	2007-05-14 14:45:58.000000000 +1000
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.21
-# Fri May  4 13:47:08 2007
+# Linux kernel version: 2.6.21-powerpc-ebony-mtd
+# Fri May 11 14:41:46 2007
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -45,6 +45,7 @@ CONFIG_4xx=y
 CONFIG_BOOKE=y
 CONFIG_PTE_64BIT=y
 CONFIG_PHYS_64BIT=y
+# CONFIG_PPC_MM_SLICES is not set
 CONFIG_NOT_COHERENT_CACHE=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
@@ -70,6 +71,7 @@ CONFIG_POSIX_MQUEUE=y
 # CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_BLK_DEV_INITRD=y
@@ -89,12 +91,13 @@ CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
-CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-# CONFIG_SLOB is not set
 
 #
 # Loadable module support
@@ -193,16 +196,14 @@ CONFIG_PPC_INDIRECT_PCI=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCIEPORTBUS is not set
+CONFIG_ARCH_SUPPORTS_MSI=y
+# CONFIG_PCI_MSI is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
 # PCCARD (PCMCIA/CardBus) support
 #
 # CONFIG_PCCARD is not set
-
-#
-# PCI Hotplug Support
-#
 # CONFIG_HOTPLUG_PCI is not set
 
 #
@@ -310,7 +311,9 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # CONFIG_CFG80211 is not set
 # CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
 
 #
 # Device Drivers
@@ -331,7 +334,80 @@ CONFIG_FW_LOADER=y
 #
 CONFIG_CONNECTOR=y
 CONFIG_PROC_EVENTS=y
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PHYSMAP is not set
+CONFIG_MTD_PHYSMAP_OF=y
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+# CONFIG_MTD_NAND is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
 
 #
 # Parallel port support
@@ -365,8 +441,10 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 #
 # Misc devices
 #
+# CONFIG_PHANTOM is not set
 # CONFIG_SGI_IOC4 is not set
 # CONFIG_TIFM_CORE is not set
+# CONFIG_BLINK is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -398,6 +476,7 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 #
 # IEEE 1394 (FireWire) support
 #
+# CONFIG_FIREWIRE is not set
 # CONFIG_IEEE1394 is not set
 
 #
@@ -468,6 +547,8 @@ CONFIG_IBM_NEW_EMAC_ZMII=y
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
 # CONFIG_NETXEN_NIC is not set
+# CONFIG_MLX4_CORE is not set
+CONFIG_MLX4_DEBUG=y
 
 #
 # Token Ring devices
@@ -550,15 +631,10 @@ CONFIG_LEGACY_PTY_COUNT=256
 # IPMI
 #
 # CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
 # CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_NVRAM is not set
 # CONFIG_GEN_RTC is not set
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_AGP is not set
@@ -569,10 +645,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-
-#
-# I2C support
-#
+CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
 
 #
@@ -585,12 +658,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # Dallas's 1-wire bus
 #
 # CONFIG_W1 is not set
-
-#
-# Hardware Monitoring support
-#
 # CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set
 
 #
 # Multifunction device drivers
@@ -611,6 +679,12 @@ CONFIG_LEGACY_PTY_COUNT=256
 # Graphics support
 #
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_VGASTATE is not set
 # CONFIG_FB is not set
 # CONFIG_FB_IBM_GXT4500 is not set
 
@@ -635,10 +709,6 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
-
-#
-# MMC/SD Card support
-#
 # CONFIG_MMC is not set
 
 #
@@ -682,14 +752,6 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 #
 
 #
-# Auxiliary Display support
-#
-
-#
-# Virtualization
-#
-
-#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -749,6 +811,15 @@ CONFIG_RAMFS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
 CONFIG_CRAMFS=y
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
@@ -770,6 +841,7 @@ CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -803,12 +875,15 @@ CONFIG_MSDOS_PARTITION=y
 CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
 
 #
 # Instrumentation Support
@@ -826,7 +901,6 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
-CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
@@ -851,7 +925,6 @@ CONFIG_FORCED_INLINING=y
 # CONFIG_DEBUGGER is not set
 # CONFIG_BDI_SWITCH is not set
 # CONFIG_BOOTX_TEXT is not set
-# CONFIG_SERIAL_TEXT_DEBUG is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
 
 #
@@ -882,6 +955,7 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_PCBC=y
 # CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_CRYPTD is not set
 CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_FCRYPT is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
Index: working-2.6/arch/powerpc/boot/ebony.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ebony.c	2007-05-14 14:45:56.000000000 +1000
+++ working-2.6/arch/powerpc/boot/ebony.c	2007-05-14 14:45:58.000000000 +1000
@@ -24,6 +24,7 @@
 #include "page.h"
 #include "ops.h"
 #include "reg.h"
+#include "io.h"
 #include "dcr.h"
 #include "44x.h"
 
@@ -92,6 +93,45 @@ void ibm440gp_fixup_clocks(unsigned int 
 	dt_fixup_clock("/plb/opb/serial@40000300", uart1);
 }
 
+#define EBONY_FPGA_PATH		"/plb/opb/ebc/fpga"
+#define	EBONY_FPGA_FLASH_SEL	0x01
+#define EBONY_SMALL_FLASH_PATH	"/plb/opb/ebc/small-flash"
+
+static void ebony_flashsel_fixup(void)
+{
+	void *devp;
+	u32 reg[3] = {0x0, 0x0, 0x80000};
+	u8 *fpga;
+	u8 fpga_reg0 = 0x0;
+
+	devp = finddevice(EBONY_FPGA_PATH);
+	if (! devp)
+		fatal("Couldn't locate FPGA node %s\n\r", EBONY_FPGA_PATH);
+
+	if (getprop(devp, "virtual-reg", fpga, sizeof(fpga)) != sizeof(fpga))
+		fatal("%s has virtual-reg property of unexpected size\n\r",
+		      EBONY_FPGA_PATH);
+
+	fpga_reg0 = in_8(fpga);
+
+	printf("Ebony: FPGA register 0 = 0x%02x\n\r", fpga_reg0);
+
+	devp = finddevice(EBONY_SMALL_FLASH_PATH);
+	if (! devp)
+		fatal("Couldn't locate small flash node %s\n\r",
+		      EBONY_SMALL_FLASH_PATH);
+
+	if (getprop(devp, "reg", reg, sizeof(reg)) != sizeof(reg))
+		fatal("%s has reg property of unexpected size\n\r",
+		      EBONY_SMALL_FLASH_PATH);
+
+	/* Invert address bit 14 (IBM-endian) if FLASH_SEL fpga bit is set */
+	if (fpga_reg0 & EBONY_FPGA_FLASH_SEL)
+		reg[1] ^= 0x80000;
+
+	setprop(devp, "reg", reg, sizeof(reg));
+}
+
 static void ebony_fixups(void)
 {
 	// FIXME: sysclk should be derived by reading the FPGA registers
@@ -101,6 +141,7 @@ static void ebony_fixups(void)
 	ibm44x_fixup_memsize();
 	dt_fixup_mac_addresses(ebony_mac0, ebony_mac1);
 	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
+	ebony_flashsel_fixup();
 }
 
 void ebony_init(void *mac0, void *mac1)
Index: working-2.6/arch/powerpc/boot/dts/ebony.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/ebony.dts	2007-05-14 14:45:56.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2007-05-14 14:45:58.000000000 +1000
@@ -176,6 +176,7 @@
 				fpga@7,0 {
 					compatible = "Ebony-FPGA";
 					reg = <7 0 10>;
+					virtual-reg = <e8300000>;
 				};
 			};
 
