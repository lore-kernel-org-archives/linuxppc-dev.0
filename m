Return-Path: <dgibson@ozlabs.org>
Date: Mon, 30 Jul 2007 15:55:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Fixes to allow use of Ebony's flash chips through physmap_of
Message-ID: <20070730055502.GA16391@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
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

Paul, this should be mergeable for 2.6.24.


Index: working-2.6/drivers/mtd/maps/Kconfig
===================================================================
--- working-2.6.orig/drivers/mtd/maps/Kconfig	2007-07-30 15:47:54.000000000 +1000
+++ working-2.6/drivers/mtd/maps/Kconfig	2007-07-30 15:47:56.000000000 +1000
@@ -362,7 +362,7 @@ config MTD_WALNUT
 
 config MTD_EBONY
 	tristate "Flash devices mapped on IBM 440GP Ebony"
-	depends on MTD_JEDECPROBE && EBONY
+	depends on MTD_JEDECPROBE && EBONY && !PPC_MERGE
 	help
 	  This enables access routines for the flash chips on the IBM 440GP
 	  Ebony board. If you have one of these boards and would like to
Index: working-2.6/arch/powerpc/boot/ebony.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/ebony.c	2007-07-30 15:47:54.000000000 +1000
+++ working-2.6/arch/powerpc/boot/ebony.c	2007-07-30 15:47:56.000000000 +1000
@@ -24,6 +24,7 @@
 #include "page.h"
 #include "ops.h"
 #include "reg.h"
+#include "io.h"
 #include "dcr.h"
 #include "44x.h"
 
@@ -92,6 +93,43 @@ void ibm440gp_fixup_clocks(unsigned int 
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
+	if (!devp)
+		fatal("Couldn't locate FPGA node %s\n\r", EBONY_FPGA_PATH);
+
+	if (getprop(devp, "virtual-reg", &fpga, sizeof(fpga)) != sizeof(fpga))
+		fatal("%s has missing or invalid virtual-reg property\n\r",
+		      EBONY_FPGA_PATH);
+
+	fpga_reg0 = in_8(fpga);
+
+	devp = finddevice(EBONY_SMALL_FLASH_PATH);
+	if (!devp)
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
@@ -101,6 +139,7 @@ static void ebony_fixups(void)
 	ibm44x_fixup_memsize();
 	dt_fixup_mac_addresses(ebony_mac0, ebony_mac1);
 	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
+	ebony_flashsel_fixup();
 }
 
 void ebony_init(void *mac0, void *mac1)
Index: working-2.6/arch/powerpc/boot/dts/ebony.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/ebony.dts	2007-07-30 15:47:54.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2007-07-30 15:47:56.000000000 +1000
@@ -175,6 +175,7 @@
 				fpga@7,0 {
 					compatible = "Ebony-FPGA";
 					reg = <7 0 10>;
+					virtual-reg = <e8300000>;
 				};
 			};
 
Index: working-2.6/arch/powerpc/configs/ebony_defconfig
===================================================================
--- working-2.6.orig/arch/powerpc/configs/ebony_defconfig	2007-07-30 15:47:54.000000000 +1000
+++ working-2.6/arch/powerpc/configs/ebony_defconfig	2007-07-30 15:48:02.000000000 +1000
@@ -1,9 +1,25 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.22-rc6
-# Tue Jun 26 12:38:33 2007
+# Linux kernel version: 2.6.23-rc1-powerpc-ebony-mtd
+# Mon Jul 30 15:47:59 2007
 #
 # CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+# CONFIG_6xx is not set
+# CONFIG_PPC_85xx is not set
+# CONFIG_PPC_8xx is not set
+# CONFIG_40x is not set
+CONFIG_44x=y
+# CONFIG_E200 is not set
+CONFIG_4xx=y
+CONFIG_BOOKE=y
+CONFIG_PTE_64BIT=y
+CONFIG_PHYS_64BIT=y
+# CONFIG_PPC_MM_SLICES is not set
+CONFIG_NOT_COHERENT_CACHE=y
 CONFIG_PPC32=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
@@ -14,39 +30,22 @@ CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
+# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
 CONFIG_PPC=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_GENERIC_NVRAM=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_PPC_OF=y
+CONFIG_OF=y
 # CONFIG_PPC_UDBG_16550 is not set
 # CONFIG_GENERIC_TBSYNC is not set
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
 # CONFIG_DEFAULT_UIMAGE is not set
-
-#
-# Processor support
-#
-# CONFIG_CLASSIC32 is not set
-# CONFIG_PPC_82xx is not set
-# CONFIG_PPC_83xx is not set
-# CONFIG_PPC_85xx is not set
-# CONFIG_PPC_86xx is not set
-# CONFIG_PPC_8xx is not set
-# CONFIG_40x is not set
-CONFIG_44x=y
-# CONFIG_E200 is not set
 CONFIG_PPC_DCR_NATIVE=y
 # CONFIG_PPC_DCR_MMIO is not set
 CONFIG_PPC_DCR=y
-CONFIG_4xx=y
-CONFIG_BOOKE=y
-CONFIG_PTE_64BIT=y
-CONFIG_PHYS_64BIT=y
-# CONFIG_PPC_MM_SLICES is not set
-CONFIG_NOT_COHERENT_CACHE=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -63,12 +62,11 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
-# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
+# CONFIG_USER_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
@@ -102,24 +100,17 @@ CONFIG_SLAB=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-
-#
-# Loadable module support
-#
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
-
-#
-# Block layer
-#
 CONFIG_BLOCK=y
 CONFIG_LBD=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
 
 #
 # IO Schedulers
@@ -184,6 +175,8 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_RESOURCES_64BIT=y
 CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 CONFIG_SECCOMP=y
@@ -196,9 +189,9 @@ CONFIG_ISA_DMA_API=y
 #
 CONFIG_ZONE_DMA=y
 CONFIG_PPC_INDIRECT_PCI=y
-# CONFIG_PPC_INDIRECT_PCI_BE is not set
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_SYSCALL=y
 # CONFIG_PCIEPORTBUS is not set
 CONFIG_ARCH_SUPPORTS_MSI=y
 # CONFIG_PCI_MSI is not set
@@ -306,6 +299,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
 # CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -320,27 +314,85 @@ CONFIG_FW_LOADER=y
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
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
 
 #
-# Parallel port support
+# UBI - Unsorted block images
 #
+# CONFIG_MTD_UBI is not set
+CONFIG_OF_DEVICE=y
 # CONFIG_PARPORT is not set
-
-#
-# Plug and Play support
-#
-# CONFIG_PNPACPI is not set
-
-#
-# Block devices
-#
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_FD is not set
 # CONFIG_BLK_CPQ_DA is not set
 # CONFIG_BLK_CPQ_CISS_DA is not set
@@ -356,14 +408,12 @@ CONFIG_BLK_DEV_RAM_SIZE=35000
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
-
-#
-# Misc devices
-#
+# CONFIG_XILINX_SYSACE is not set
+CONFIG_MISC_DEVICES=y
 # CONFIG_PHANTOM is not set
+# CONFIG_EEPROM_93CX6 is not set
 # CONFIG_SGI_IOC4 is not set
 # CONFIG_TIFM_CORE is not set
-# CONFIG_BLINK is not set
 # CONFIG_IDE is not set
 
 #
@@ -371,12 +421,9 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 #
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
 # CONFIG_SCSI_NETLINK is not set
 # CONFIG_ATA is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
 # CONFIG_MD is not set
 
 #
@@ -389,35 +436,17 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 #
 # CONFIG_FIREWIRE is not set
 # CONFIG_IEEE1394 is not set
-
-#
-# I2O device support
-#
 # CONFIG_I2O is not set
 # CONFIG_MACINTOSH_DRIVERS is not set
-
-#
-# Network device support
-#
 CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
 # CONFIG_ARCNET is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
 # CONFIG_NET_ETHERNET is not set
-CONFIG_IBM_EMAC=y
-CONFIG_IBM_EMAC_RXB=128
-CONFIG_IBM_EMAC_TXB=64
-CONFIG_IBM_EMAC_POLL_WEIGHT=32
-CONFIG_IBM_EMAC_RX_COPY_THRESHOLD=256
-CONFIG_IBM_EMAC_RX_SKB_HEADROOM=0
-# CONFIG_IBM_EMAC_DEBUG is not set
-CONFIG_IBM_EMAC_ZMII=y
 CONFIG_NETDEV_1000=y
 # CONFIG_ACENIC is not set
 # CONFIG_DL2K is not set
@@ -429,7 +458,6 @@ CONFIG_NETDEV_1000=y
 # CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
-# CONFIG_SK98LIN is not set
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
@@ -459,15 +487,7 @@ CONFIG_NETDEV_10000=y
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
 # CONFIG_ISDN is not set
-
-#
-# Telephony Support
-#
 # CONFIG_PHONE is not set
 
 #
@@ -512,10 +532,6 @@ CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
-
-#
-# IPMI
-#
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
@@ -526,10 +542,6 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
-
-#
-# TPM devices
-#
 # CONFIG_TCG_TPM is not set
 CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
@@ -539,11 +551,8 @@ CONFIG_DEVPORT=y
 #
 # CONFIG_SPI is not set
 # CONFIG_SPI_MASTER is not set
-
-#
-# Dallas's 1-wire bus
-#
 # CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
 
 #
@@ -568,6 +577,7 @@ CONFIG_DEVPORT=y
 #
 # CONFIG_DISPLAY_SUPPORT is not set
 # CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
 # CONFIG_FB is not set
 # CONFIG_FB_IBM_GXT4500 is not set
 
@@ -575,10 +585,7 @@ CONFIG_DEVPORT=y
 # Sound
 #
 # CONFIG_SOUND is not set
-
-#
-# USB support
-#
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
@@ -593,28 +600,9 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 #
 # CONFIG_USB_GADGET is not set
 # CONFIG_MMC is not set
-
-#
-# LED devices
-#
 # CONFIG_NEW_LEDS is not set
-
-#
-# LED drivers
-#
-
-#
-# LED Triggers
-#
-
-#
-# InfiniBand support
-#
 # CONFIG_INFINIBAND is not set
-
-#
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
-#
+# CONFIG_EDAC is not set
 
 #
 # Real Time Clock
@@ -635,6 +623,11 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 #
 
 #
+# Userspace I/O
+#
+# CONFIG_UIO is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -694,6 +687,15 @@ CONFIG_RAMFS=y
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
@@ -723,7 +725,6 @@ CONFIG_SUNRPC=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -750,8 +751,10 @@ CONFIG_BITREVERSE=y
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
@@ -774,6 +777,7 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
 CONFIG_DETECT_SOFTLOCKUP=y
+CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
@@ -796,7 +800,6 @@ CONFIG_FORCED_INLINING=y
 # CONFIG_DEBUG_PAGEALLOC is not set
 # CONFIG_DEBUGGER is not set
 # CONFIG_BDI_SWITCH is not set
-# CONFIG_BOOTX_TEXT is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
 
 #
@@ -804,10 +807,6 @@ CONFIG_FORCED_INLINING=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_BLKCIPHER=y
@@ -845,7 +844,4 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_TEST is not set
-
-#
-# Hardware crypto devices
-#
+CONFIG_CRYPTO_HW=y

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
