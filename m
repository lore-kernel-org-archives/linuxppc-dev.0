Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	by ozlabs.org (Postfix) with ESMTP id 9E27BDE007
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 01:31:21 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/4xx: Sequoia: Enable NAND support
Date: Tue,  7 Apr 2009 17:31:05 +0200
Message-Id: <1239118265-9276-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that the 4xx NAND driver is available again in arch/powerpc, let's
enable it on Sequoia. This patch also disables the early debug messages
(CONFIG_PPC_EARLY_DEBUG) in the Sequoia defconfig.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/boot/dts/sequoia.dts          |   22 ++++++
 arch/powerpc/configs/44x/sequoia_defconfig |  109 ++++++++++++++++++----------
 2 files changed, 94 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/boot/dts/sequoia.dts b/arch/powerpc/boot/dts/sequoia.dts
index 43cc68b..739dd0d 100644
--- a/arch/powerpc/boot/dts/sequoia.dts
+++ b/arch/powerpc/boot/dts/sequoia.dts
@@ -199,6 +199,28 @@
 					};
 				};
 
+				ndfc@3,0 {
+					compatible = "ibm,ndfc";
+					reg = <0x00000003 0x00000000 0x00002000>;
+					ccr = <0x00001000>;
+					bank-settings = <0x80002222>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					nand {
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						partition@0 {
+							label = "u-boot";
+							reg = <0x00000000 0x00084000>;
+						};
+						partition@84000 {
+							label = "user";
+							reg = <0x00000000 0x01f7c000>;
+						};
+					};
+				};
 			};
 
 			UART0: serial@ef600300 {
diff --git a/arch/powerpc/configs/44x/sequoia_defconfig b/arch/powerpc/configs/44x/sequoia_defconfig
index a921fe3..0dd7d3b 100644
--- a/arch/powerpc/configs/44x/sequoia_defconfig
+++ b/arch/powerpc/configs/44x/sequoia_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.29-rc2
-# Tue Jan 20 08:22:45 2009
+# Linux kernel version: 2.6.29
+# Tue Apr  7 17:04:52 2009
 #
 # CONFIG_PPC64 is not set
 
@@ -57,6 +57,7 @@ CONFIG_GENERIC_BUG=y
 CONFIG_PPC_DCR_NATIVE=y
 # CONFIG_PPC_DCR_MMIO is not set
 CONFIG_PPC_DCR=y
+CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -74,6 +75,15 @@ CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
 # CONFIG_AUDIT is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_CLASSIC_RCU=y
+# CONFIG_TREE_RCU is not set
+# CONFIG_PREEMPT_RCU is not set
+# CONFIG_TREE_RCU_TRACE is not set
+# CONFIG_PREEMPT_RCU_TRACE is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_GROUP_SCHED=y
@@ -88,8 +98,12 @@ CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
+CONFIG_RD_GZIP=y
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
 CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
@@ -99,10 +113,8 @@ CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
-CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
-CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
 CONFIG_SIGNALFD=y
 CONFIG_TIMERFD=y
@@ -112,10 +124,12 @@ CONFIG_AIO=y
 CONFIG_VM_EVENT_COUNTERS=y
 CONFIG_PCI_QUIRKS=y
 CONFIG_SLUB_DEBUG=y
+CONFIG_COMPAT_BRK=y
 # CONFIG_SLAB is not set
 CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 # CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
 # CONFIG_KPROBES is not set
 CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
@@ -123,6 +137,7 @@ CONFIG_HAVE_IOREMAP_PROT=y
 CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
 CONFIG_HAVE_ARCH_TRACEHOOK=y
+# CONFIG_SLOW_WORK is not set
 # CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
@@ -135,7 +150,6 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_BLOCK=y
 CONFIG_LBD=y
-# CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_BLK_DEV_INTEGRITY is not set
 
@@ -151,11 +165,6 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
-CONFIG_CLASSIC_RCU=y
-# CONFIG_TREE_RCU is not set
-# CONFIG_PREEMPT_RCU is not set
-# CONFIG_TREE_RCU_TRACE is not set
-# CONFIG_PREEMPT_RCU_TRACE is not set
 # CONFIG_FREEZER is not set
 # CONFIG_PPC4xx_PCI_EXPRESS is not set
 
@@ -176,6 +185,7 @@ CONFIG_SEQUOIA=y
 # CONFIG_ARCHES is not set
 # CONFIG_CANYONLANDS is not set
 # CONFIG_GLACIER is not set
+# CONFIG_REDWOOD is not set
 # CONFIG_YOSEMITE is not set
 # CONFIG_XILINX_VIRTEX440_GENERIC_BOARD is not set
 CONFIG_PPC44x_SIMPLE=y
@@ -238,9 +248,13 @@ CONFIG_ZONE_DMA_FLAG=1
 CONFIG_BOUNCE=y
 CONFIG_VIRT_TO_BUS=y
 CONFIG_UNEVICTABLE_LRU=y
+CONFIG_HAVE_MLOCK=y
+CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+CONFIG_STDBINUTILS=y
 CONFIG_PPC_4K_PAGES=y
 # CONFIG_PPC_16K_PAGES is not set
 # CONFIG_PPC_64K_PAGES is not set
+# CONFIG_PPC_256K_PAGES is not set
 CONFIG_FORCE_MAX_ZONEORDER=11
 CONFIG_PROC_DEVICETREE=y
 CONFIG_CMDLINE_BOOL=y
@@ -265,6 +279,7 @@ CONFIG_ARCH_SUPPORTS_MSI=y
 CONFIG_PCI_LEGACY=y
 # CONFIG_PCI_DEBUG is not set
 # CONFIG_PCI_STUB is not set
+# CONFIG_PCI_IOV is not set
 # CONFIG_PCCARD is not set
 # CONFIG_HOTPLUG_PCI is not set
 # CONFIG_HAS_RAPIDIO is not set
@@ -278,18 +293,16 @@ CONFIG_PCI_LEGACY=y
 # Default settings for advanced configuration options are used
 #
 CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_LOWMEM_CAM_NUM=3
 CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
 # Networking options
 #
-CONFIG_COMPAT_NET_DEV_OPS=y
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
@@ -339,6 +352,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
+# CONFIG_PHONET is not set
 # CONFIG_NET_SCHED is not set
 # CONFIG_DCB is not set
 
@@ -351,7 +365,6 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
-# CONFIG_PHONET is not set
 # CONFIG_WIRELESS is not set
 # CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
@@ -448,14 +461,23 @@ CONFIG_MTD_PHYSMAP_OF=y
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
-# CONFIG_MTD_NAND is not set
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+CONFIG_MTD_NAND_ECC_SMC=y
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+CONFIG_MTD_NAND_IDS=y
+CONFIG_MTD_NAND_NDFC=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_CAFE is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_MTD_NAND_PLATFORM is not set
+# CONFIG_MTD_NAND_FSL_ELBC is not set
 # CONFIG_MTD_ONENAND is not set
 
 #
 # LPDDR flash memory drivers
 #
 # CONFIG_MTD_LPDDR is not set
-# CONFIG_MTD_QINFO_PROBE is not set
 
 #
 # UBI - Unsorted block images
@@ -483,12 +505,16 @@ CONFIG_BLK_DEV_RAM_SIZE=35000
 # CONFIG_BLK_DEV_HD is not set
 CONFIG_MISC_DEVICES=y
 # CONFIG_PHANTOM is not set
-# CONFIG_EEPROM_93CX6 is not set
 # CONFIG_SGI_IOC4 is not set
 # CONFIG_TIFM_CORE is not set
 # CONFIG_ENCLOSURE_SERVICES is not set
 # CONFIG_HP_ILO is not set
 # CONFIG_C2PORT is not set
+
+#
+# EEPROM support
+#
+# CONFIG_EEPROM_93CX6 is not set
 CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
 
@@ -515,6 +541,7 @@ CONFIG_HAVE_IDE=y
 # CONFIG_I2O is not set
 # CONFIG_MACINTOSH_DRIVERS is not set
 CONFIG_NETDEVICES=y
+CONFIG_COMPAT_NET_DEV_OPS=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
 # CONFIG_MACVLAN is not set
@@ -529,6 +556,8 @@ CONFIG_NET_ETHERNET=y
 # CONFIG_SUNGEM is not set
 # CONFIG_CASSINI is not set
 # CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_ETHOC is not set
+# CONFIG_DNET is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
 CONFIG_IBM_NEW_EMAC=y
@@ -568,6 +597,7 @@ CONFIG_NETDEV_1000=y
 # CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
 # CONFIG_ATL1E is not set
+# CONFIG_ATL1C is not set
 # CONFIG_JME is not set
 CONFIG_NETDEV_10000=y
 # CONFIG_CHELSIO_T1 is not set
@@ -577,6 +607,7 @@ CONFIG_CHELSIO_T3_DEPENDS=y
 # CONFIG_IXGBE is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
+# CONFIG_VXGE is not set
 # CONFIG_MYRI10GE is not set
 # CONFIG_NETXEN_NIC is not set
 # CONFIG_NIU is not set
@@ -586,6 +617,7 @@ CONFIG_CHELSIO_T3_DEPENDS=y
 # CONFIG_BNX2X is not set
 # CONFIG_QLGE is not set
 # CONFIG_SFC is not set
+# CONFIG_BE2NET is not set
 # CONFIG_TR is not set
 
 #
@@ -593,7 +625,6 @@ CONFIG_CHELSIO_T3_DEPENDS=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
-# CONFIG_IWLWIFI_LEDS is not set
 
 #
 # Enable WiMAX (Networking options) to see the WiMAX drivers
@@ -734,7 +765,7 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 #
 
 #
-# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may also be needed;
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
 #
 # CONFIG_USB_GADGET is not set
 
@@ -750,6 +781,7 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 # CONFIG_EDAC is not set
 # CONFIG_RTC_CLASS is not set
 # CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
 # CONFIG_STAGING is not set
 
@@ -778,6 +810,11 @@ CONFIG_INOTIFY_USER=y
 # CONFIG_FUSE_FS is not set
 
 #
+# Caches
+#
+# CONFIG_FSCACHE is not set
+
+#
 # CD-ROM/DVD Filesystems
 #
 # CONFIG_ISO9660_FS is not set
@@ -842,7 +879,6 @@ CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_REGISTER_V4 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -858,6 +894,7 @@ CONFIG_SUNRPC=y
 CONFIG_MSDOS_PARTITION=y
 # CONFIG_NLS is not set
 # CONFIG_DLM is not set
+# CONFIG_BINARY_PRINTF is not set
 
 #
 # Library routines
@@ -873,11 +910,12 @@ CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
-CONFIG_PLIST=y
+CONFIG_DECOMPRESS_GZIP=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
 CONFIG_HAVE_LMB=y
+CONFIG_NLATTR=y
 
 #
 # Kernel hacking
@@ -924,9 +962,12 @@ CONFIG_SCHED_DEBUG=y
 # CONFIG_FAULT_INJECTION is not set
 # CONFIG_LATENCYTOP is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
+# CONFIG_DEBUG_PAGEALLOC is not set
 CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
 CONFIG_HAVE_DYNAMIC_FTRACE=y
 CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_TRACING_SUPPORT=y
 
 #
 # Tracers
@@ -934,17 +975,20 @@ CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
 # CONFIG_FUNCTION_TRACER is not set
 # CONFIG_SCHED_TRACER is not set
 # CONFIG_CONTEXT_SWITCH_TRACER is not set
+# CONFIG_EVENT_TRACER is not set
 # CONFIG_BOOT_TRACER is not set
 # CONFIG_TRACE_BRANCH_PROFILING is not set
 # CONFIG_STACK_TRACER is not set
-# CONFIG_DYNAMIC_PRINTK_DEBUG is not set
+# CONFIG_KMEMTRACE is not set
+# CONFIG_WORKQUEUE_TRACER is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_DYNAMIC_DEBUG is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_KGDB is not set
 CONFIG_PRINT_STACK_DEPTH=64
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
-# CONFIG_DEBUG_PAGEALLOC is not set
 # CONFIG_CODE_PATCHING_SELFTEST is not set
 # CONFIG_FTR_FIXUP_SELFTEST is not set
 # CONFIG_MSI_BITMAP_SELFTEST is not set
@@ -952,20 +996,7 @@ CONFIG_PRINT_STACK_DEPTH=64
 # CONFIG_IRQSTACKS is not set
 # CONFIG_VIRQ_DEBUG is not set
 # CONFIG_BDI_SWITCH is not set
-CONFIG_PPC_EARLY_DEBUG=y
-# CONFIG_PPC_EARLY_DEBUG_LPAR is not set
-# CONFIG_PPC_EARLY_DEBUG_G5 is not set
-# CONFIG_PPC_EARLY_DEBUG_RTAS_PANEL is not set
-# CONFIG_PPC_EARLY_DEBUG_RTAS_CONSOLE is not set
-# CONFIG_PPC_EARLY_DEBUG_MAPLE is not set
-# CONFIG_PPC_EARLY_DEBUG_ISERIES is not set
-# CONFIG_PPC_EARLY_DEBUG_PAS_REALMODE is not set
-# CONFIG_PPC_EARLY_DEBUG_BEAT is not set
-CONFIG_PPC_EARLY_DEBUG_44x=y
-# CONFIG_PPC_EARLY_DEBUG_40x is not set
-# CONFIG_PPC_EARLY_DEBUG_CPM is not set
-CONFIG_PPC_EARLY_DEBUG_44x_PHYSLOW=0xef600300
-CONFIG_PPC_EARLY_DEBUG_44x_PHYSHIGH=0x1
+# CONFIG_PPC_EARLY_DEBUG is not set
 
 #
 # Security options
@@ -988,10 +1019,12 @@ CONFIG_CRYPTO_BLKCIPHER2=y
 CONFIG_CRYPTO_HASH=y
 CONFIG_CRYPTO_HASH2=y
 CONFIG_CRYPTO_RNG2=y
+CONFIG_CRYPTO_PCOMP=y
 CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_MANAGER2=y
 # CONFIG_CRYPTO_GF128MUL is not set
 # CONFIG_CRYPTO_NULL is not set
+CONFIG_CRYPTO_WORKQUEUE=y
 # CONFIG_CRYPTO_CRYPTD is not set
 # CONFIG_CRYPTO_AUTHENC is not set
 # CONFIG_CRYPTO_TEST is not set
@@ -1060,6 +1093,7 @@ CONFIG_CRYPTO_DES=y
 # Compression
 #
 # CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_ZLIB is not set
 # CONFIG_CRYPTO_LZO is not set
 
 #
@@ -1068,5 +1102,6 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_HW=y
 # CONFIG_CRYPTO_DEV_HIFN_795X is not set
+# CONFIG_CRYPTO_DEV_PPC4XX is not set
 # CONFIG_PPC_CLOCK is not set
 # CONFIG_VIRTUALIZATION is not set
-- 
1.6.2.2
