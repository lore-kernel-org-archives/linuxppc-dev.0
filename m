Return-Path: <wfarnsworth@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id DCBEC67CD7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jul 2005 01:57:42 +1000 (EST)
Received: from rhino.az.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id IAA05342
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Jul 2005 08:57:28 -0700
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: multipart/mixed; boundary="=-wATmQvwCLT5PHgmfek7p"
Message-Id: <1122393448.22059.32.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 26 Jul 2005 08:57:28 -0700
Subject: [PATCH 1/3] PPC440EP SoC and Bamboo board support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



--=-wATmQvwCLT5PHgmfek7p
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

This adds support for the AMCC PPC440EP SoC and the Bamboo reference
board.  This patch makes use of fpu.S.

Signed-off by: Wade Farnsworth <wfarnsworth@mvista.com>

--=-wATmQvwCLT5PHgmfek7p
Content-Disposition: attachment; filename=440ep-ppc.patch
Content-Type: text/x-patch; name=440ep-ppc.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

diff -uprN linux-2.6.12/include/asm-ppc/ibm44x.h linux-2.6.12-440ep/include/asm-ppc/ibm44x.h
--- linux-2.6.12/include/asm-ppc/ibm44x.h	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-440ep/include/asm-ppc/ibm44x.h	2005-07-25 11:32:23.000000000 -0700
@@ -35,8 +35,10 @@
 #define PPC44x_LOW_SLOT		63
 
 /* LS 32-bits of UART0 physical address location for early serial text debug */
-#ifdef CONFIG_440SP
+#if defined(CONFIG_440SP)
 #define UART0_PHYS_IO_BASE	0xf0000200
+#elif defined(CONFIG_440EP)
+#define UART0_PHYS_IO_BASE	0xe0000000
 #else
 #define UART0_PHYS_IO_BASE	0x40000200
 #endif
@@ -49,11 +51,16 @@
 /*
  * Standard 4GB "page" definitions
  */
-#ifdef CONFIG_440SP
+#if defined(CONFIG_440SP)
 #define	PPC44x_IO_PAGE		0x0000000100000000ULL
 #define	PPC44x_PCICFG_PAGE	0x0000000900000000ULL
 #define	PPC44x_PCIIO_PAGE	PPC44x_PCICFG_PAGE
 #define	PPC44x_PCIMEM_PAGE	0x0000000a00000000ULL
+#elif defined(CONFIG_440EP)
+#define PPC44x_IO_PAGE		0x0000000000000000ULL
+#define PPC44x_PCICFG_PAGE	0x0000000000000000ULL
+#define PPC44x_PCIIO_PAGE	PPC44x_PCICFG_PAGE
+#define PPC44x_PCIMEM_PAGE	0x0000000000000000ULL
 #else
 #define	PPC44x_IO_PAGE		0x0000000100000000ULL
 #define	PPC44x_PCICFG_PAGE	0x0000000200000000ULL
@@ -64,7 +71,7 @@
 /*
  * 36-bit trap ranges
  */
-#ifdef CONFIG_440SP
+#if defined(CONFIG_440SP)
 #define PPC44x_IO_LO		0xf0000000UL
 #define PPC44x_IO_HI		0xf0000fffUL
 #define PPC44x_PCI0CFG_LO	0x0ec00000UL
@@ -75,6 +82,13 @@
 #define PPC44x_PCI2CFG_HI	0x2ec00007UL
 #define PPC44x_PCIMEM_LO	0x80000000UL
 #define PPC44x_PCIMEM_HI	0xdfffffffUL
+#elif defined(CONFIG_440EP)
+#define PPC44x_IO_LO		0xef500000UL
+#define PPC44x_IO_HI		0xefffffffUL
+#define PPC44x_PCI0CFG_LO	0xeec00000UL
+#define PPC44x_PCI0CFG_HI	0xeecfffffUL
+#define PPC44x_PCIMEM_LO	0xa0000000UL
+#define PPC44x_PCIMEM_HI	0xdfffffffUL
 #else
 #define PPC44x_IO_LO		0x40000000UL
 #define PPC44x_IO_HI		0x40000fffUL
@@ -152,6 +166,12 @@
 #define DCRN_SDR_UART0		0x0120
 #define DCRN_SDR_UART1		0x0121
 
+#ifdef CONFIG_440EP
+#define DCRN_SDR_UART2		0x0122
+#define DCRN_SDR_UART3		0x0123
+#define DCRN_SDR_CUST0		0x4000
+#endif
+
 /* SDR read/write helper macros */
 #define SDR_READ(offset) ({\
 	mtdcr(DCRN_SDR_CONFIG_ADDR, offset); \
@@ -169,6 +189,14 @@
 #define DCRNCAP_DMA_SG		1	/* have DMA scatter/gather capability */
 #define DCRN_MAL_BASE		0x180
 
+#ifdef CONFIG_440EP
+#define DCRN_DMA2P40_BASE	0x300
+#define DCRN_DMA2P41_BASE	0x308
+#define DCRN_DMA2P42_BASE	0x310
+#define DCRN_DMA2P43_BASE	0x318
+#define DCRN_DMA2P4SR_BASE	0x320
+#endif
+
 /* UIC */
 #define DCRN_UIC0_BASE	0xc0
 #define DCRN_UIC1_BASE	0xd0
diff -uprN linux-2.6.12/include/asm-ppc/ibm4xx.h linux-2.6.12-440ep/include/asm-ppc/ibm4xx.h
--- linux-2.6.12/include/asm-ppc/ibm4xx.h	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-440ep/include/asm-ppc/ibm4xx.h	2005-07-25 11:32:23.000000000 -0700
@@ -97,6 +97,10 @@ void ppc4xx_init(unsigned long r3, unsig
 
 #elif CONFIG_44x
 
+#if defined(CONFIG_BAMBOO)
+#include <platforms/4xx/bamboo.h>
+#endif
+
 #if defined(CONFIG_EBONY)
 #include <platforms/4xx/ebony.h>
 #endif
diff -uprN linux-2.6.12/include/asm-ppc/ppc_asm.h linux-2.6.12-440ep/include/asm-ppc/ppc_asm.h
--- linux-2.6.12/include/asm-ppc/ppc_asm.h	2005-07-25 12:57:09.000000000 -0700
+++ linux-2.6.12-440ep/include/asm-ppc/ppc_asm.h	2005-07-25 11:32:23.000000000 -0700
@@ -186,6 +186,12 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #define PPC405_ERR77_SYNC
 #endif
 
+#ifdef CONFIG_IBM440EP_ERR42
+#define PPC440EP_ERR42 isync
+#else
+#define PPC440EP_ERR42
+#endif
+
 /* The boring bits... */
 
 /* Condition Register Bit Fields */
diff -uprN linux-2.6.12/arch/ppc/boot/simple/Makefile linux-2.6.12-440ep/arch/ppc/boot/simple/Makefile
--- linux-2.6.12/arch/ppc/boot/simple/Makefile	2005-07-25 12:57:00.000000000 -0700
+++ linux-2.6.12-440ep/arch/ppc/boot/simple/Makefile	2005-07-25 11:32:20.000000000 -0700
@@ -61,6 +61,12 @@ zimageinitrd-$(CONFIG_IBM_OPENBIOS)	:= z
          end-$(CONFIG_EMBEDDEDBOOT)	:= embedded
         misc-$(CONFIG_EMBEDDEDBOOT)	:= misc-embedded.o
 
+      zimage-$(CONFIG_BAMBOO)		:= zImage-TREE
+zimageinitrd-$(CONFIG_BAMBOO)		:= zImage.initrd-TREE
+         end-$(CONFIG_BAMBOO)		:= bamboo
+  entrypoint-$(CONFIG_BAMBOO)		:= 0x01000000
+     extra.o-$(CONFIG_BAMBOO)		:= pibs.o
+
       zimage-$(CONFIG_EBONY)		:= zImage-TREE
 zimageinitrd-$(CONFIG_EBONY)		:= zImage.initrd-TREE
          end-$(CONFIG_EBONY)		:= ebony
diff -uprN linux-2.6.12/arch/ppc/boot/simple/pibs.c linux-2.6.12-440ep/arch/ppc/boot/simple/pibs.c
--- linux-2.6.12/arch/ppc/boot/simple/pibs.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-440ep/arch/ppc/boot/simple/pibs.c	2005-07-25 11:32:21.000000000 -0700
@@ -91,9 +91,11 @@ load_kernel(unsigned long load_addr, int
 
 	mac64 = simple_strtoull((char *)PIBS_MAC_BASE, 0, 16);
 	memcpy(hold_residual->bi_enetaddr, (char *)&mac64+2, 6);
-#ifdef CONFIG_440GX
+#if defined(CONFIG_440GX) || defined(CONFIG_440EP)
 	mac64 = simple_strtoull((char *)(PIBS_MAC_BASE+PIBS_MAC_OFFSET), 0, 16);
 	memcpy(hold_residual->bi_enet1addr, (char *)&mac64+2, 6);
+#endif
+#ifdef CONFIG_440GX
 	mac64 = simple_strtoull((char *)(PIBS_MAC_BASE+PIBS_MAC_OFFSET*2), 0, 16);
 	memcpy(hold_residual->bi_enet2addr, (char *)&mac64+2, 6);
 	mac64 = simple_strtoull((char *)(PIBS_MAC_BASE+PIBS_MAC_OFFSET*3), 0, 16);
diff -uprN linux-2.6.12/arch/ppc/configs/bamboo_defconfig linux-2.6.12-440ep/arch/ppc/configs/bamboo_defconfig
--- linux-2.6.12/arch/ppc/configs/bamboo_defconfig	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.12-440ep/arch/ppc/configs/bamboo_defconfig	2005-07-25 11:32:21.000000000 -0700
@@ -0,0 +1,943 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.12
+# Tue Jun 28 15:24:25 2005
+#
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_HAVE_DEC_LOCK=y
+CONFIG_PPC=y
+CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+# CONFIG_HOTPLUG is not set
+CONFIG_KOBJECT_UEVENT=y
+# CONFIG_IKCONFIG is not set
+CONFIG_EMBEDDED=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+
+#
+# Processor
+#
+# CONFIG_6xx is not set
+# CONFIG_40x is not set
+CONFIG_44x=y
+# CONFIG_POWER3 is not set
+# CONFIG_POWER4 is not set
+# CONFIG_8xx is not set
+# CONFIG_E200 is not set
+# CONFIG_E500 is not set
+CONFIG_PPC_FPU=y
+CONFIG_BOOKE=y
+CONFIG_PTE_64BIT=y
+CONFIG_PHYS_64BIT=y
+# CONFIG_MATH_EMULATION is not set
+# CONFIG_KEXEC is not set
+# CONFIG_CPU_FREQ is not set
+CONFIG_4xx=y
+
+#
+# IBM 4xx options
+#
+CONFIG_BAMBOO=y
+# CONFIG_EBONY is not set
+# CONFIG_LUAN is not set
+# CONFIG_OCOTEA is not set
+CONFIG_440EP=y
+CONFIG_440=y
+CONFIG_IBM440EP_ERR42=y
+CONFIG_IBM_OCP=y
+# CONFIG_PPC4xx_DMA is not set
+CONFIG_PPC_GEN550=y
+# CONFIG_PM is not set
+CONFIG_NOT_COHERENT_CACHE=y
+
+#
+# Platform options
+#
+# CONFIG_PC_KEYBOARD is not set
+# CONFIG_SMP is not set
+# CONFIG_PREEMPT is not set
+# CONFIG_HIGHMEM is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="ip=on"
+CONFIG_SECCOMP=y
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+# CONFIG_PCI_LEGACY_PROC is not set
+# CONFIG_PCI_NAMES is not set
+# CONFIG_PCI_DEBUG is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_HIGHMEM_START=0xfe000000
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_TASK_SIZE=0x80000000
+CONFIG_CONSISTENT_START=0xff100000
+CONFIG_CONSISTENT_SIZE=0x00200000
+CONFIG_BOOT_LOAD=0x01000000
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+# CONFIG_STANDALONE is not set
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+# CONFIG_BLK_DEV_LOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
+# CONFIG_BLK_DEV_RAM is not set
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_LBD is not set
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+CONFIG_IDE=y
+CONFIG_BLK_DEV_IDE=y
+
+#
+# Please see Documentation/ide.txt for help/info on IDE drives
+#
+# CONFIG_BLK_DEV_IDE_SATA is not set
+CONFIG_BLK_DEV_IDEDISK=y
+# CONFIG_IDEDISK_MULTI_MODE is not set
+# CONFIG_BLK_DEV_IDECD is not set
+# CONFIG_BLK_DEV_IDETAPE is not set
+# CONFIG_BLK_DEV_IDEFLOPPY is not set
+# CONFIG_BLK_DEV_IDESCSI is not set
+# CONFIG_IDE_TASK_IOCTL is not set
+
+#
+# IDE chipset support/bugfixes
+#
+CONFIG_IDE_GENERIC=y
+CONFIG_BLK_DEV_IDEPCI=y
+# CONFIG_IDEPCI_SHARE_IRQ is not set
+# CONFIG_BLK_DEV_OFFBOARD is not set
+# CONFIG_BLK_DEV_GENERIC is not set
+# CONFIG_BLK_DEV_OPTI621 is not set
+# CONFIG_BLK_DEV_SL82C105 is not set
+CONFIG_BLK_DEV_IDEDMA_PCI=y
+# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
+# CONFIG_IDEDMA_PCI_AUTO is not set
+# CONFIG_BLK_DEV_AEC62XX is not set
+# CONFIG_BLK_DEV_ALI15X3 is not set
+# CONFIG_BLK_DEV_AMD74XX is not set
+CONFIG_BLK_DEV_CMD64X=y
+# CONFIG_BLK_DEV_TRIFLEX is not set
+# CONFIG_BLK_DEV_CY82C693 is not set
+# CONFIG_BLK_DEV_CS5520 is not set
+# CONFIG_BLK_DEV_CS5530 is not set
+# CONFIG_BLK_DEV_HPT34X is not set
+# CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_SC1200 is not set
+# CONFIG_BLK_DEV_PIIX is not set
+# CONFIG_BLK_DEV_IT821X is not set
+# CONFIG_BLK_DEV_NS87415 is not set
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
+# CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
+# CONFIG_BLK_DEV_SLC90E66 is not set
+# CONFIG_BLK_DEV_TRM290 is not set
+# CONFIG_BLK_DEV_VIA82CXXX is not set
+# CONFIG_IDE_ARM is not set
+CONFIG_BLK_DEV_IDEDMA=y
+# CONFIG_IDEDMA_IVB is not set
+# CONFIG_IDEDMA_AUTO is not set
+# CONFIG_BLK_DEV_HD is not set
+
+#
+# SCSI device support
+#
+CONFIG_SCSI=y
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+# CONFIG_BLK_DEV_SD is not set
+CONFIG_CHR_DEV_ST=y
+# CONFIG_CHR_DEV_OSST is not set
+# CONFIG_BLK_DEV_SR is not set
+# CONFIG_CHR_DEV_SG is not set
+# CONFIG_CHR_DEV_SCH is not set
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+# CONFIG_SCSI_MULTI_LUN is not set
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+
+#
+# SCSI Transport Attributes
+#
+CONFIG_SCSI_SPI_ATTRS=y
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+
+#
+# SCSI low-level drivers
+#
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_SCSI_SATA is not set
+# CONFIG_SCSI_BUSLOGIC is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_EATA is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_GDTH is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+CONFIG_SCSI_SYM53C8XX_2=y
+CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
+CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
+CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
+# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
+# CONFIG_SCSI_IPR is not set
+# CONFIG_SCSI_QLOGIC_FC is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+CONFIG_SCSI_QLA2XXX=y
+# CONFIG_SCSI_QLA21XX is not set
+# CONFIG_SCSI_QLA22XX is not set
+# CONFIG_SCSI_QLA2300 is not set
+# CONFIG_SCSI_QLA2322 is not set
+# CONFIG_SCSI_QLA6312 is not set
+# CONFIG_SCSI_LPFC is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_NSP32 is not set
+# CONFIG_SCSI_DEBUG is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+# CONFIG_FUSION_SPI is not set
+# CONFIG_FUSION_FC is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Macintosh device drivers
+#
+
+#
+# Networking support
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+# CONFIG_IP_PNP_DHCP is not set
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+# CONFIG_IP_TCPDIAG_IPV6 is not set
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=y
+
+#
+# IP: Virtual Server Configuration
+#
+# CONFIG_IP_VS is not set
+# CONFIG_IPV6 is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+
+#
+# IP: Netfilter Configuration
+#
+# CONFIG_IP_NF_CONNTRACK is not set
+# CONFIG_IP_NF_CONNTRACK_MARK is not set
+# CONFIG_IP_NF_QUEUE is not set
+# CONFIG_IP_NF_IPTABLES is not set
+# CONFIG_IP_NF_ARPTABLES is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_NET_VENDOR_3COM is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_IBM_EMAC=y
+# CONFIG_IBM_EMAC_ERRMSG is not set
+CONFIG_IBM_EMAC_RXB=64
+CONFIG_IBM_EMAC_TXB=8
+CONFIG_IBM_EMAC_FGAP=8
+CONFIG_IBM_EMAC_SKBRES=0
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
+# CONFIG_DGRS is not set
+CONFIG_EEPRO100=y
+# CONFIG_E100 is not set
+# CONFIG_FEALNX is not set
+CONFIG_NATSEMI=y
+# CONFIG_NE2K_PCI is not set
+# CONFIG_8139CP is not set
+# CONFIG_8139TOO is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_TLAN is not set
+# CONFIG_VIA_RHINE is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+CONFIG_E1000=y
+# CONFIG_E1000_NAPI is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_PCIPS2 is not set
+# CONFIG_SERIO_LIBPS2 is not set
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_EXTENDED=y
+# CONFIG_SERIAL_8250_MANY_PORTS is not set
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+# CONFIG_SERIAL_8250_DETECT_IRQ is not set
+# CONFIG_SERIAL_8250_RSA is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_NVRAM is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB=y
+CONFIG_USB_DEBUG=y
+
+#
+# Miscellaneous USB options
+#
+# CONFIG_USB_DEVICEFS is not set
+# CONFIG_USB_BANDWIDTH is not set
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_EHCI_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_OHCI_HCD is not set
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_BLUETOOTH_TTY is not set
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+# CONFIG_USB_STORAGE is not set
+
+#
+# USB Input Devices
+#
+# CONFIG_USB_HID is not set
+
+#
+# USB HID Boot Protocol drivers
+#
+# CONFIG_USB_KBD is not set
+# CONFIG_USB_MOUSE is not set
+# CONFIG_USB_AIPTEK is not set
+# CONFIG_USB_WACOM is not set
+# CONFIG_USB_ACECAD is not set
+# CONFIG_USB_KBTAB is not set
+# CONFIG_USB_POWERMATE is not set
+# CONFIG_USB_MTOUCH is not set
+# CONFIG_USB_ITMTOUCH is not set
+# CONFIG_USB_EGALAX is not set
+# CONFIG_USB_XPAD is not set
+# CONFIG_USB_ATI_REMOTE is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+
+#
+# USB Multimedia devices
+#
+# CONFIG_USB_DABUSB is not set
+
+#
+# Video4Linux support is needed for USB Multimedia device support
+#
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+CONFIG_USB_PEGASUS=y
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
+CONFIG_USB_MON=y
+
+#
+# USB port drivers
+#
+
+#
+# USB Serial Converter support
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGETKIT is not set
+# CONFIG_USB_PHIDGETSERVO is not set
+# CONFIG_USB_IDMOUSE is not set
+
+#
+# USB DSL modem support
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
+# SN Devices
+#
+
+#
+# File systems
+#
+# CONFIG_EXT2_FS is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_JBD is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+# CONFIG_DEVPTS_FS_XATTR is not set
+# CONFIG_TMPFS is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+# CONFIG_NFS_V3 is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
+# CONFIG_NLS is not set
+
+#
+# Library routines
+#
+# CONFIG_CRC_CCITT is not set
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_FS is not set
+# CONFIG_KGDB is not set
+# CONFIG_XMON is not set
+CONFIG_BDI_SWITCH=y
+# CONFIG_SERIAL_TEXT_DEBUG is not set
+CONFIG_PPC_OCP=y
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Hardware crypto devices
+#
diff -uprN linux-2.6.12/arch/ppc/kernel/cputable.c linux-2.6.12-440ep/arch/ppc/kernel/cputable.c
--- linux-2.6.12/arch/ppc/kernel/cputable.c	2005-07-25 12:57:00.000000000 -0700
+++ linux-2.6.12-440ep/arch/ppc/kernel/cputable.c	2005-07-25 11:32:21.000000000 -0700
@@ -852,6 +852,26 @@ struct cpu_spec	cpu_specs[] = {
 
 #endif /* CONFIG_40x */
 #ifdef CONFIG_44x
+	{
+		.pvr_mask		= 0xf0000fff,
+		.pvr_value		= 0x40000850,
+		.cpu_name		= "440EP Rev. A",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= COMMON_PPC, /* 440EP has an FPU */
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+	},
+	{
+		.pvr_mask		= 0xf0000fff,
+		.pvr_value		= 0x400008d3,
+		.cpu_name		= "440EP Rev. B",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= COMMON_PPC, /* 440EP has an FPU */
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+	},
 	{ 	/* 440GP Rev. B */
 		.pvr_mask		= 0xf0000fff,
 		.pvr_value		= 0x40000440,
diff -uprN linux-2.6.12/arch/ppc/kernel/entry.S linux-2.6.12-440ep/arch/ppc/kernel/entry.S
--- linux-2.6.12/arch/ppc/kernel/entry.S	2005-07-25 12:57:00.000000000 -0700
+++ linux-2.6.12-440ep/arch/ppc/kernel/entry.S	2005-07-25 11:32:21.000000000 -0700
@@ -215,6 +215,7 @@ syscall_dotrace_cont:
 	lwzx	r10,r10,r0	/* Fetch system call handler [ptr] */
 	mtlr	r10
 	addi	r9,r1,STACK_FRAME_OVERHEAD
+	PPC440EP_ERR42
 	blrl			/* Call handler */
 	.globl	ret_from_syscall
 ret_from_syscall:
diff -uprN linux-2.6.12/arch/ppc/kernel/head_44x.S linux-2.6.12-440ep/arch/ppc/kernel/head_44x.S
--- linux-2.6.12/arch/ppc/kernel/head_44x.S	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-440ep/arch/ppc/kernel/head_44x.S	2005-07-25 11:32:22.000000000 -0700
@@ -190,7 +190,9 @@ skpinv:	addi	r4,r4,1				/* Increment */
 
 	/* xlat fields */
 	lis	r4,UART0_PHYS_IO_BASE@h		/* RPN depends on SoC */
+#ifndef CONFIG_440EP
 	ori	r4,r4,0x0001		/* ERPN is 1 for second 4GB page */
+#endif
 
 	/* attrib fields */
 	li	r5,0
@@ -228,6 +230,16 @@ skpinv:	addi	r4,r4,1				/* Increment */
 	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
 	mtspr	SPRN_IVPR,r4
 
+#ifdef CONFIG_440EP
+	/* Clear DAPUIB flag in CCR0 (enable APU between CPU and FPU) */
+	mfspr	r2,SPRN_CCR0
+	lis	r3,0xffef
+	ori	r3,r3,0xffff
+	and	r2,r2,r3
+	mtspr	SPRN_CCR0,r2
+	isync
+#endif
+
 	/*
 	 * This is where the main kernel code starts.
 	 */
diff -uprN linux-2.6.12/arch/ppc/kernel/misc.S linux-2.6.12-440ep/arch/ppc/kernel/misc.S
--- linux-2.6.12/arch/ppc/kernel/misc.S	2005-07-25 12:57:00.000000000 -0700
+++ linux-2.6.12-440ep/arch/ppc/kernel/misc.S	2005-07-25 11:32:22.000000000 -0700
@@ -1145,6 +1145,7 @@ _GLOBAL(kernel_thread)
 	stwu	r0,-16(r1)
 	mtlr	r30		/* fn addr in lr */
 	mr	r3,r31		/* load arg and call fn */
+	PPC440EP_ERR42
 	blrl
 	li	r0,__NR_exit	/* exit if function returns */
 	li	r3,0
diff -uprN linux-2.6.12/arch/ppc/platforms/4xx/Kconfig linux-2.6.12-440ep/arch/ppc/platforms/4xx/Kconfig
--- linux-2.6.12/arch/ppc/platforms/4xx/Kconfig	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-440ep/arch/ppc/platforms/4xx/Kconfig	2005-07-25 11:32:22.000000000 -0700
@@ -68,6 +68,11 @@ choice
 	depends on 44x
 	default EBONY
 
+config BAMBOO
+	bool "Bamboo"
+	help
+	  This option enables support for the IBM PPC440EP evaluation board.
+
 config EBONY
 	bool "Ebony"
 	help
@@ -98,6 +103,12 @@ config NP405H
 	depends on ASH
 	default y
 
+config 440EP
+	bool
+	depends on BAMBOO
+	select PPC_FPU
+	default y
+
 config 440GP
 	bool
 	depends on EBONY
@@ -115,7 +126,7 @@ config 440SP
 
 config 440
 	bool
-	depends on 440GP || 440SP
+	depends on 440GP || 440SP || 440EP
 	default y
 
 config 440A
@@ -123,6 +134,11 @@ config 440A
 	depends on 440GX
 	default y
 
+config IBM440EP_ERR42
+	bool
+	depends on 440EP
+	default y
+
 # All 405-based cores up until the 405GPR and 405EP have this errata.
 config IBM405_ERR77
 	bool
@@ -142,7 +158,7 @@ config BOOKE
 
 config IBM_OCP
 	bool
-	depends on ASH || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
+	depends on ASH || BAMBOO || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
 	default y
 
 config XILINX_OCP
diff -uprN linux-2.6.12/arch/ppc/platforms/4xx/Makefile linux-2.6.12-440ep/arch/ppc/platforms/4xx/Makefile
--- linux-2.6.12/arch/ppc/platforms/4xx/Makefile	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-440ep/arch/ppc/platforms/4xx/Makefile	2005-07-25 11:32:22.000000000 -0700
@@ -2,6 +2,7 @@
 # Makefile for the PowerPC 4xx linux kernel.
 
 obj-$(CONFIG_ASH)		+= ash.o
+obj-$(CONFIG_BAMBOO)		+= bamboo.o
 obj-$(CONFIG_CPCI405)		+= cpci405.o
 obj-$(CONFIG_EBONY)		+= ebony.o
 obj-$(CONFIG_EP405)		+= ep405.o
@@ -19,6 +20,7 @@ obj-$(CONFIG_405GP)		+= ibm405gp.o
 obj-$(CONFIG_REDWOOD_5)		+= ibmstb4.o
 obj-$(CONFIG_NP405H)		+= ibmnp405h.o
 obj-$(CONFIG_REDWOOD_6)		+= ibmstbx25.o
+obj-$(CONFIG_440EP)		+= ibm440ep.o
 obj-$(CONFIG_440GP)		+= ibm440gp.o
 obj-$(CONFIG_440GX)		+= ibm440gx.o
 obj-$(CONFIG_440SP)		+= ibm440sp.o
diff -uprN linux-2.6.12/arch/ppc/platforms/4xx/bamboo.c linux-2.6.12-440ep/arch/ppc/platforms/4xx/bamboo.c
--- linux-2.6.12/arch/ppc/platforms/4xx/bamboo.c	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.12-440ep/arch/ppc/platforms/4xx/bamboo.c	2005-07-25 11:32:22.000000000 -0700
@@ -0,0 +1,427 @@
+/*
+ * arch/ppc/platforms/4xx/bamboo.c
+ *
+ * Bamboo board specific routines
+ *
+ * Wade Farnsworth <wfarnsworth@mvista.com>
+ * Copyright 2004 MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/types.h>
+#include <linux/major.h>
+#include <linux/blkdev.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/ide.h>
+#include <linux/initrd.h>
+#include <linux/irq.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/ethtool.h>
+
+#include <asm/system.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/dma.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/ocp.h>
+#include <asm/pci-bridge.h>
+#include <asm/time.h>
+#include <asm/todc.h>
+#include <asm/bootinfo.h>
+#include <asm/ppc4xx_pic.h>
+#include <asm/ppcboot.h>
+
+#include <syslib/gen550.h>
+#include <syslib/ibm440gx_common.h>
+
+/*
+ * This is a horrible kludge, we eventually need to abstract this
+ * generic PHY stuff, so the  standard phy mode defines can be
+ * easily used from arch code.
+ */
+#include "../../../../drivers/net/ibm_emac/ibm_emac_phy.h"
+
+bd_t __res;
+
+static struct ibm44x_clocks clocks __initdata;
+
+/*
+ * Bamboo external IRQ triggering/polarity settings
+ */
+unsigned char ppc4xx_uic_ext_irq_cfg[] __initdata = {
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ0: Ethernet transceiver */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE), /* IRQ1: Expansion connector */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ2: PCI slot 0 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ3: PCI slot 1 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ4: PCI slot 2 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ5: PCI slot 3 */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_NEGATIVE), /* IRQ6: SMI pushbutton */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ7: EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ8: EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ9: EXT */
+};
+
+static void __init
+bamboo_calibrate_decr(void)
+{
+	unsigned int freq;
+
+	if (mfspr(SPRN_CCR1) & CCR1_TCS)
+		freq = BAMBOO_TMRCLK;
+	else
+		freq = clocks.cpu;
+
+	ibm44x_calibrate_decr(freq);
+	
+}
+
+static int
+bamboo_show_cpuinfo(struct seq_file *m)
+{
+	seq_printf(m, "vendor\t\t: IBM\n");
+	seq_printf(m, "machine\t\t: PPC440EP EVB (Bamboo)\n");
+
+	return 0;
+}
+
+static inline int
+bamboo_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+{
+	static char pci_irq_table[][4] =
+	/*
+	 *	PCI IDSEL/INTPIN->INTLINE
+	 * 	   A   B   C   D
+	 */
+	{
+		{ 28, 28, 28, 28 },	/* IDSEL 1 - PCI Slot 0 */
+		{ 27, 27, 27, 27 },	/* IDSEL 2 - PCI Slot 1 */
+		{ 26, 26, 26, 26 },	/* IDSEL 3 - PCI Slot 2 */
+		{ 25, 25, 25, 25 },	/* IDSEL 4 - PCI Slot 3 */
+	};
+
+	const long min_idsel = 1, max_idsel = 4, irqs_per_slot = 4;
+	return PCI_IRQ_TABLE_LOOKUP;
+}
+
+static void __init bamboo_set_emacdata(void)
+{
+	unsigned char * selection1_base;
+	struct ocp_def *def;
+	struct ocp_func_emac_data *emacdata;
+	u8 selection1_val;
+	int mode;
+	
+	selection1_base = ioremap64(BAMBOO_FPGA_SELECTION1_REG_ADDR, 16);
+	selection1_val = readb(selection1_base);
+	iounmap((void *) selection1_base);
+	if (BAMBOO_SEL_MII(selection1_val))
+		mode = PHY_MODE_MII;
+	else if (BAMBOO_SEL_RMII(selection1_val))
+		mode = PHY_MODE_RMII;
+	else 
+		mode = PHY_MODE_SMII;
+	
+	/* Set mac_addr and phy mode for each EMAC */
+
+	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 0);
+	emacdata = def->additions;
+	memcpy(emacdata->mac_addr, __res.bi_enetaddr, 6);
+	emacdata->phy_mode = mode;
+
+	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 1);
+	emacdata = def->additions;
+	memcpy(emacdata->mac_addr, __res.bi_enet1addr, 6);
+	emacdata->phy_mode = mode;
+}
+
+static int
+bamboo_exclude_device(unsigned char bus, unsigned char devfn)
+{
+	return (bus == 0 && devfn == 0);
+}
+
+#define PCI_READW(offset) \
+        (readw((void *)((u32)pci_reg_base+offset)))
+
+#define PCI_WRITEW(value, offset) \
+	(writew(value, (void *)((u32)pci_reg_base+offset)))
+	
+#define PCI_WRITEL(value, offset) \
+	(writel(value, (void *)((u32)pci_reg_base+offset)))
+
+static void __init
+bamboo_setup_pci(void)
+{
+	void *pci_reg_base;
+	unsigned long memory_size;
+	memory_size = ppc_md.find_end_of_memory();
+
+	pci_reg_base = ioremap64(BAMBOO_PCIL0_BASE, BAMBOO_PCIL0_SIZE);
+
+	/* Enable PCI I/O, Mem, and Busmaster cycles */
+	PCI_WRITEW(PCI_READW(PCI_COMMAND) | 
+		   PCI_COMMAND_MEMORY | 
+		   PCI_COMMAND_MASTER, PCI_COMMAND);
+
+	/* Disable region first */
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM0MA);
+
+	/* PLB starting addr: 0x00000000A0000000 */
+	PCI_WRITEL(BAMBOO_PCI_PHY_MEM_BASE, BAMBOO_PCIL0_PMM0LA);
+
+	/* PCI start addr, 0xA0000000 (PCI Address) */
+	PCI_WRITEL(BAMBOO_PCI_MEM_BASE, BAMBOO_PCIL0_PMM0PCILA);
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM0PCIHA);
+
+	/* Enable no pre-fetch, enable region */
+	PCI_WRITEL(((0xffffffff - 
+		     (BAMBOO_PCI_UPPER_MEM - BAMBOO_PCI_MEM_BASE)) | 0x01), 
+		      BAMBOO_PCIL0_PMM0MA);
+	
+	/* Disable region one */
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM1MA);
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM1LA);
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM1PCILA);
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM1PCIHA);
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM1MA);
+	
+	/* Disable region two */
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM2MA);
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM2LA);
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM2PCILA);
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM2PCIHA);
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM2MA);
+	
+	/* Now configure the PCI->PLB windows, we only use PTM1
+	 *
+	 * For Inbound flow, set the window size to all available memory
+	 * This is required because if size is smaller,
+	 * then Eth/PCI DD would fail as PCI card not able to access
+	 * the memory allocated by DD.
+	 */
+	
+	PCI_WRITEL(0, BAMBOO_PCIL0_PTM1MS);	/* disabled region 1 */
+	PCI_WRITEL(0, BAMBOO_PCIL0_PTM1LA);	/* begin of address map */
+
+	memory_size = 1 << fls(memory_size - 1);
+
+	/* Size low + Enabled */
+	PCI_WRITEL((0xffffffff - (memory_size - 1)) | 0x1, BAMBOO_PCIL0_PTM1MS);
+	
+	eieio();
+	iounmap(pci_reg_base);
+}
+
+static void __init
+bamboo_setup_hose(void)
+{
+	unsigned int bar_response, bar;
+	struct pci_controller *hose;
+
+	bamboo_setup_pci();
+
+	hose = pcibios_alloc_controller();
+
+	if (!hose)
+		return;
+
+	hose->first_busno = 0;
+	hose->last_busno = 0xff;
+
+	hose->pci_mem_offset = BAMBOO_PCI_MEM_OFFSET;
+
+	pci_init_resource(&hose->io_resource,
+			BAMBOO_PCI_LOWER_IO,
+			BAMBOO_PCI_UPPER_IO,
+			IORESOURCE_IO,
+			"PCI host bridge");
+
+	pci_init_resource(&hose->mem_resources[0],
+			BAMBOO_PCI_LOWER_MEM,
+			BAMBOO_PCI_UPPER_MEM,
+			IORESOURCE_MEM,
+			"PCI host bridge");
+
+	ppc_md.pci_exclude_device = bamboo_exclude_device;
+
+	hose->io_space.start = BAMBOO_PCI_LOWER_IO;
+	hose->io_space.end = BAMBOO_PCI_UPPER_IO;
+	hose->mem_space.start = BAMBOO_PCI_LOWER_MEM;
+	hose->mem_space.end = BAMBOO_PCI_UPPER_MEM;
+	isa_io_base =
+		(unsigned long)ioremap64(BAMBOO_PCI_IO_BASE, BAMBOO_PCI_IO_SIZE);
+	hose->io_base_virt = (void *)isa_io_base;
+
+	setup_indirect_pci(hose,
+			BAMBOO_PCI_CFGA_PLB32,
+			BAMBOO_PCI_CFGD_PLB32);
+	hose->set_cfg_type = 1;
+
+	/* Zero config bars */
+	for (bar = PCI_BASE_ADDRESS_1; bar <= PCI_BASE_ADDRESS_2; bar += 4) {
+		early_write_config_dword(hose, hose->first_busno,
+					 PCI_FUNC(hose->first_busno), bar,
+					 0x00000000);
+		early_read_config_dword(hose, hose->first_busno,
+					PCI_FUNC(hose->first_busno), bar,
+					&bar_response);
+	}
+
+	hose->last_busno = pciauto_bus_scan(hose, hose->first_busno);
+
+	ppc_md.pci_swizzle = common_swizzle;
+	ppc_md.pci_map_irq = bamboo_map_irq;
+}
+
+TODC_ALLOC();
+
+static void __init
+bamboo_early_serial_map(void)
+{
+	struct uart_port port;
+
+	/* Setup ioremapped serial port access */
+	memset(&port, 0, sizeof(port));
+	port.membase = ioremap64(PPC440EP_UART0_ADDR, 8);
+	port.irq = 0;
+	port.uartclk = clocks.uart0;
+	port.regshift = 0;
+	port.iotype = SERIAL_IO_MEM;
+	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
+	port.line = 0;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 0 failed\n");
+	}
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	/* Configure debug serial access */
+	gen550_init(0, &port);
+#endif
+
+	port.membase = ioremap64(PPC440EP_UART1_ADDR, 8);
+	port.irq = 1;
+	port.uartclk = clocks.uart1;
+	port.line = 1;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 1 failed\n");
+	}
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	/* Configure debug serial access */
+	gen550_init(1, &port);
+#endif
+
+	port.membase = ioremap64(PPC440EP_UART2_ADDR, 8);
+	port.irq = 3;
+	port.uartclk = clocks.uart2;
+	port.line = 2;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 2 failed\n");
+	}
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	/* Configure debug serial access */
+	gen550_init(2, &port);
+#endif
+
+	port.membase = ioremap64(PPC440EP_UART3_ADDR, 8);
+	port.irq = 4;
+	port.uartclk = clocks.uart3;
+	port.line = 3;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 3 failed\n");
+	}
+}
+
+static void __init
+bamboo_setup_arch(void)
+{
+
+	bamboo_set_emacdata();
+
+	ibm440gx_get_clocks(&clocks, 33333333, 6 * 1843200);
+	ocp_sys_info.opb_bus_freq = clocks.opb;
+
+	/* Setup TODC access */
+	TODC_INIT(TODC_TYPE_DS1743,
+			0,
+			0,
+			ioremap64(BAMBOO_RTC_ADDR, BAMBOO_RTC_SIZE),
+			8);
+
+	/* init to some ~sane value until calibrate_delay() runs */
+        loops_per_jiffy = 50000000/HZ;
+
+	/* Setup PCI host bridge */
+	bamboo_setup_hose();
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (initrd_start)
+		ROOT_DEV = Root_RAM0;
+	else
+#endif
+#ifdef CONFIG_ROOT_NFS
+		ROOT_DEV = Root_NFS;
+#else
+		ROOT_DEV = Root_HDA1;
+#endif
+
+	bamboo_early_serial_map();
+
+	/* Identify the system */
+	printk("IBM Bamboo port (MontaVista Software, Inc. (source@mvista.com))\n");
+}
+
+void __init platform_init(unsigned long r3, unsigned long r4,
+		unsigned long r5, unsigned long r6, unsigned long r7)
+{
+	parse_bootinfo(find_bootinfo());
+
+	/*
+	 * If we were passed in a board information, copy it into the
+	 * residual data area.
+	 */
+	if (r3)
+		__res = *(bd_t *)(r3 + KERNELBASE);
+
+
+	ibm44x_platform_init();
+
+	ppc_md.setup_arch = bamboo_setup_arch;
+	ppc_md.show_cpuinfo = bamboo_show_cpuinfo;
+	ppc_md.get_irq = NULL;		/* Set in ppc4xx_pic_init() */
+
+	ppc_md.calibrate_decr = bamboo_calibrate_decr;
+	ppc_md.time_init = todc_time_init;
+	ppc_md.set_rtc_time = todc_set_rtc_time;
+	ppc_md.get_rtc_time = todc_get_rtc_time;
+
+	ppc_md.nvram_read_val = todc_direct_read_val;
+	ppc_md.nvram_write_val = todc_direct_write_val;
+#ifdef CONFIG_KGDB
+	ppc_md.early_serial_map = bamboo_early_serial_map;
+#endif
+}
+
diff -uprN linux-2.6.12/arch/ppc/platforms/4xx/bamboo.h linux-2.6.12-440ep/arch/ppc/platforms/4xx/bamboo.h
--- linux-2.6.12/arch/ppc/platforms/4xx/bamboo.h	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.12-440ep/arch/ppc/platforms/4xx/bamboo.h	2005-07-25 11:32:22.000000000 -0700
@@ -0,0 +1,136 @@
+/*
+ * arch/ppc/platforms/bamboo.h
+ *
+ * Bamboo board definitions
+ *
+ * Wade Farnsworth <wfarnsworth@mvista.com>
+ *
+ * Copyright 2004 MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_BAMBOO_H__
+#define __ASM_BAMBOO_H__
+
+#include <linux/config.h>
+#include <platforms/4xx/ibm440ep.h>
+
+/* F/W TLB mapping used in bootloader glue to reset EMAC */
+#define PPC44x_EMAC0_MR0		0x0EF600E00
+
+/* Location of MAC addresses in PIBS image */
+#define PIBS_FLASH_BASE			0xfff00000
+#define PIBS_MAC_BASE			(PIBS_FLASH_BASE+0xc0400)
+#define PIBS_MAC_SIZE			0x200
+#define PIBS_MAC_OFFSET			0x100
+
+/* Default clock rate */
+#define BAMBOO_TMRCLK			25000000
+
+/* RTC/NVRAM location */
+#define BAMBOO_RTC_ADDR			0x080000000ULL
+#define BAMBOO_RTC_SIZE			0x2000
+
+/* FPGA Registers */
+#define BAMBOO_FPGA_ADDR		0x080002000ULL
+
+#define BAMBOO_FPGA_CONFIG2_REG_ADDR	(BAMBOO_FPGA_ADDR + 0x1)
+#define BAMBOO_FULL_DUPLEX_EN(x)	(x & 0x08)
+#define BAMBOO_FORCE_100Mbps(x)		(x & 0x04)
+#define BAMBOO_AUTONEGOTIATE(x)		(x & 0x02)
+
+#define BAMBOO_FPGA_SETTING_REG_ADDR	(BAMBOO_FPGA_ADDR + 0x3)
+#define BAMBOO_BOOT_SMALL_FLASH(x)	(!(x & 0x80))
+#define BAMBOO_LARGE_FLASH_EN(x)	(!(x & 0x40))
+#define BAMBOO_BOOT_NAND_FLASH(x)	(!(x & 0x20))
+
+#define BAMBOO_FPGA_SELECTION1_REG_ADDR (BAMBOO_FPGA_ADDR + 0x4)
+#define BAMBOO_SEL_MII(x)		(x & 0x80)
+#define BAMBOO_SEL_RMII(x)		(x & 0x40)
+#define BAMBOO_SEL_SMII(x)		(x & 0x20)
+
+/* Flash */
+#define BAMBOO_SMALL_FLASH_LOW		0x087f00000ULL
+#define BAMBOO_SMALL_FLASH_HIGH		0x0fff00000ULL
+#define BAMBOO_SMALL_FLASH_SIZE		0x100000
+#define BAMBOO_LARGE_FLASH_LOW		0x087800000ULL
+#define BAMBOO_LARGE_FLASH_HIGH1	0x0ff800000ULL
+#define BAMBOO_LARGE_FLASH_HIGH2	0x0ffc00000ULL
+#define BAMBOO_LARGE_FLASH_SIZE		0x400000
+#define BAMBOO_SRAM_LOW			0x087f00000ULL
+#define BAMBOO_SRAM_HIGH1		0x0fff00000ULL
+#define BAMBOO_SRAM_HIGH2		0x0ff800000ULL
+#define BAMBOO_SRAM_SIZE		0x100000
+#define BAMBOO_NAND_FLASH_REG_ADDR	0x090000000ULL
+#define BAMBOO_NAND_FLASH_REG_SIZE	0x2000
+
+/*
+ * Serial port defines
+ */
+#define RS_TABLE_SIZE			4
+
+#define UART0_IO_BASE			0xEF600300
+#define UART1_IO_BASE			0xEF600400
+#define UART2_IO_BASE			0xEF600500
+#define UART3_IO_BASE			0xEF600600
+
+#define BASE_BAUD			33177600/3/16
+#define UART0_INT			0
+#define UART1_INT			1
+#define UART2_INT			3
+#define UART3_INT			4
+
+#define STD_UART_OP(num)					\
+	{ 0, BASE_BAUD, 0, UART##num##_INT,			\
+		(ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST),	\
+		iomem_base: UART##num##_IO_BASE,		\
+		io_type: SERIAL_IO_MEM},
+
+#define SERIAL_PORT_DFNS	\
+	STD_UART_OP(0)		\
+	STD_UART_OP(1)		\
+	STD_UART_OP(2)		\
+	STD_UART_OP(3)
+
+/* PCI support */
+#define BAMBOO_PCI_CFGA_PLB32		0xeec00000
+#define BAMBOO_PCI_CFGD_PLB32		0xeec00004
+
+#define BAMBOO_PCI_IO_BASE		0x00000000e8000000ULL
+#define BAMBOO_PCI_IO_SIZE		0x00010000
+#define BAMBOO_PCI_MEM_OFFSET		0x00000000
+#define BAMBOO_PCI_PHY_MEM_BASE		0x00000000a0000000ULL
+
+#define BAMBOO_PCI_LOWER_IO		0x00000000
+#define BAMBOO_PCI_UPPER_IO		0x0000ffff
+#define BAMBOO_PCI_LOWER_MEM		0xa0000000
+#define BAMBOO_PCI_UPPER_MEM		0xafffffff
+#define BAMBOO_PCI_MEM_BASE		0xa0000000
+
+#define BAMBOO_PCIL0_BASE		0x00000000ef400000ULL
+#define BAMBOO_PCIL0_SIZE		0x40
+
+#define BAMBOO_PCIL0_PMM0LA		0x000
+#define BAMBOO_PCIL0_PMM0MA		0x004
+#define BAMBOO_PCIL0_PMM0PCILA		0x008
+#define BAMBOO_PCIL0_PMM0PCIHA		0x00C
+#define BAMBOO_PCIL0_PMM1LA		0x010
+#define BAMBOO_PCIL0_PMM1MA		0x014
+#define BAMBOO_PCIL0_PMM1PCILA		0x018
+#define BAMBOO_PCIL0_PMM1PCIHA		0x01C
+#define BAMBOO_PCIL0_PMM2LA		0x020
+#define BAMBOO_PCIL0_PMM2MA		0x024
+#define BAMBOO_PCIL0_PMM2PCILA		0x028
+#define BAMBOO_PCIL0_PMM2PCIHA		0x02C
+#define BAMBOO_PCIL0_PTM1MS		0x030
+#define BAMBOO_PCIL0_PTM1LA		0x034
+#define BAMBOO_PCIL0_PTM2MS		0x038
+#define BAMBOO_PCIL0_PTM2LA		0x03C
+	
+#endif                          /* __ASM_BAMBOO_H__ */
+#endif                          /* __KERNEL__ */
diff -uprN linux-2.6.12/arch/ppc/platforms/4xx/ibm440ep.c linux-2.6.12-440ep/arch/ppc/platforms/4xx/ibm440ep.c
--- linux-2.6.12/arch/ppc/platforms/4xx/ibm440ep.c	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.12-440ep/arch/ppc/platforms/4xx/ibm440ep.c	2005-07-25 12:53:37.000000000 -0700
@@ -0,0 +1,220 @@
+/*
+ * arch/ppc/platforms/4xx/ibm440ep.c
+ *
+ * PPC440EP I/O descriptions
+ *
+ * Wade Farnsworth <wfarnsworth@mvista.com>
+ * Copyright 2004 MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <platforms/4xx/ibm440ep.h>
+#include <asm/ocp.h>
+#include <asm/ppc4xx_pic.h>
+
+static struct ocp_func_emac_data ibm440ep_emac0_def = {
+	.rgmii_idx	= -1,           /* No RGMII */
+	.rgmii_mux	= -1,           /* No RGMII */
+	.zmii_idx       = 0,            /* ZMII device index */
+	.zmii_mux       = 0,            /* ZMII input of this EMAC */
+	.mal_idx        = 0,            /* MAL device index */
+	.mal_rx_chan    = 0,            /* MAL rx channel number */
+	.mal_tx_chan    = 0,            /* MAL tx channel number */
+	.wol_irq        = 61,		/* WOL interrupt number */
+	.mdio_idx       = -1,           /* No shared MDIO */
+	.tah_idx	= -1,           /* No TAH */
+};
+
+static struct ocp_func_emac_data ibm440ep_emac1_def = {
+	.rgmii_idx	= -1,           /* No RGMII */
+	.rgmii_mux	= -1,           /* No RGMII */
+	.zmii_idx       = 0,            /* ZMII device index */
+	.zmii_mux       = 1,            /* ZMII input of this EMAC */
+	.mal_idx        = 0,            /* MAL device index */
+	.mal_rx_chan    = 1,            /* MAL rx channel number */
+	.mal_tx_chan    = 2,            /* MAL tx channel number */
+	.wol_irq        = 63,  		/* WOL interrupt number */
+	.mdio_idx       = -1,           /* No shared MDIO */
+	.tah_idx	= -1,           /* No TAH */
+};
+OCP_SYSFS_EMAC_DATA()
+
+static struct ocp_func_mal_data ibm440ep_mal0_def = {
+	.num_tx_chans   = 4,  		/* Number of TX channels */
+	.num_rx_chans   = 2,    	/* Number of RX channels */
+	.txeob_irq	= 10,		/* TX End Of Buffer IRQ  */
+	.rxeob_irq	= 11,		/* RX End Of Buffer IRQ  */
+	.txde_irq	= 33,		/* TX Descriptor Error IRQ */
+	.rxde_irq	= 34,		/* RX Descriptor Error IRQ */
+	.serr_irq	= 32,		/* MAL System Error IRQ    */
+};
+OCP_SYSFS_MAL_DATA()
+
+static struct ocp_func_iic_data ibm440ep_iic0_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+
+static struct ocp_func_iic_data ibm440ep_iic1_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+OCP_SYSFS_IIC_DATA()
+
+struct ocp_def core_ocp[] = {
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_OPB,
+	  .index	= 0,
+	  .paddr	= 0x0EF600000ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 0,
+	  .paddr	= PPC440EP_UART0_ADDR,
+	  .irq		= UART0_INT,
+	  .pm		= IBM_CPM_UART0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 1,
+	  .paddr	= PPC440EP_UART1_ADDR,
+	  .irq		= UART1_INT,
+	  .pm		= IBM_CPM_UART1,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 2,
+	  .paddr	= PPC440EP_UART2_ADDR,
+	  .irq		= UART2_INT,
+	  .pm		= IBM_CPM_UART2,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 3,
+	  .paddr	= PPC440EP_UART3_ADDR,
+	  .irq		= UART3_INT,
+	  .pm		= IBM_CPM_UART3,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .index	= 0,
+	  .paddr	= 0x0EF600700ULL,
+	  .irq		= 2,
+	  .pm		= IBM_CPM_IIC0,
+	  .additions	= &ibm440ep_iic0_def,
+	  .show		= &ocp_show_iic_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .index	= 1,
+	  .paddr	= 0x0EF600800ULL,
+	  .irq		= 7,
+	  .pm		= IBM_CPM_IIC1,
+	  .additions	= &ibm440ep_iic1_def,
+	  .show		= &ocp_show_iic_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_GPIO,
+	  .index	= 0,
+	  .paddr	= 0x0EF600B00ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= IBM_CPM_GPIO0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_GPIO,
+	  .index	= 1,
+	  .paddr	= 0x0EF600C00ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_MAL,
+	  .paddr	= OCP_PADDR_NA,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm440ep_mal0_def,
+	  .show		= &ocp_show_mal_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 0,
+	  .paddr	= 0x0EF600E00ULL,
+	  .irq		= 60,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm440ep_emac0_def,
+	  .show		= &ocp_show_emac_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 1,
+	  .paddr	= 0x0EF600F00ULL,
+	  .irq		= 62,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm440ep_emac1_def,
+	  .show		= &ocp_show_emac_data,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_ZMII,
+	  .paddr	= 0x0EF600D00ULL,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_INVALID
+	}
+};
+
+/* Polarity and triggering settings for internal interrupt sources */
+struct ppc4xx_uic_settings ppc4xx_core_uic_cfg[] __initdata = {
+	{ .polarity	= 0xffbffe03,
+	  .triggering   = 0xfffffe00,
+	  .ext_irq_mask = 0x000001fc,	/* IRQ0 - IRQ6 */
+	},
+	{ .polarity	= 0xffffc6ef,
+	  .triggering	= 0xffffc7ff,
+	  .ext_irq_mask = 0x00003800,	/* IRQ7 - IRQ9 */
+	},
+};
+
+static struct resource usb_gadget_resources[] = {
+	[0] = {
+		.start	= 0x050000100ULL,
+		.end 	= 0x05000017FULL,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 55,
+		.end	= 55,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static u64 dma_mask = 0xffffffffULL;
+
+static struct platform_device usb_gadget_device = {
+	.name		= "musbhsfc",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(usb_gadget_resources),
+	.resource       = usb_gadget_resources,
+	.dev		= {
+		.dma_mask = &dma_mask,
+		.coherent_dma_mask = 0xffffffffULL,
+	}
+};
+
+static struct platform_device *ibm440ep_devs[] __initdata = {
+	&usb_gadget_device,
+};
+
+static int __init
+ibm440ep_platform_add_devices(void)
+{
+	return platform_add_devices(ibm440ep_devs, ARRAY_SIZE(ibm440ep_devs));
+}
+arch_initcall(ibm440ep_platform_add_devices);
+
diff -uprN linux-2.6.12/arch/ppc/platforms/4xx/ibm440ep.h linux-2.6.12-440ep/arch/ppc/platforms/4xx/ibm440ep.h
--- linux-2.6.12/arch/ppc/platforms/4xx/ibm440ep.h	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.12-440ep/arch/ppc/platforms/4xx/ibm440ep.h	2005-07-25 11:32:22.000000000 -0700
@@ -0,0 +1,76 @@
+/*
+ * arch/ppc/platforms/4xx/ibm440ep.h
+ *
+ * PPC440EP definitions
+ *
+ * Wade Farnsworth <wfarnsworth@mvista.com>
+ *
+ * Copyright 2002 Roland Dreier
+ * Copyright 2004 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifdef __KERNEL__
+#ifndef __PPC_PLATFORMS_IBM440EP_H
+#define __PPC_PLATFORMS_IBM440EP_H
+
+#include <linux/config.h>
+#include <asm/ibm44x.h>
+
+/* UART */
+#define PPC440EP_UART0_ADDR		0x0EF600300
+#define PPC440EP_UART1_ADDR		0x0EF600400
+#define PPC440EP_UART2_ADDR		0x0EF600500
+#define PPC440EP_UART3_ADDR		0x0EF600600
+#define UART0_INT			0
+#define UART1_INT			1
+#define UART2_INT			3
+#define UART3_INT			4
+
+/* Clock and Power Management */
+#define IBM_CPM_IIC0		0x80000000	/* IIC interface */
+#define IBM_CPM_IIC1		0x40000000	/* IIC interface */
+#define IBM_CPM_PCI		0x20000000	/* PCI bridge */
+#define IBM_CPM_USB1H		0x08000000	/* USB 1.1 Host */
+#define IBM_CPM_FPU		0x04000000	/* floating point unit */
+#define IBM_CPM_CPU		0x02000000	/* processor core */
+#define IBM_CPM_DMA		0x01000000	/* DMA controller */
+#define IBM_CPM_BGO		0x00800000	/* PLB to OPB bus arbiter */
+#define IBM_CPM_BGI		0x00400000	/* OPB to PLB bridge */
+#define IBM_CPM_EBC		0x00200000	/* External Bus Controller */
+#define IBM_CPM_EBM		0x00100000	/* Ext Bus Master Interface */
+#define IBM_CPM_DMC		0x00080000	/* SDRAM peripheral controller */
+#define IBM_CPM_PLB4		0x00040000	/* PLB4 bus arbiter */
+#define IBM_CPM_PLB4x3		0x00020000	/* PLB4 to PLB3 bridge controller */
+#define IBM_CPM_PLB3x4		0x00010000	/* PLB3 to PLB4 bridge controller */
+#define IBM_CPM_PLB3		0x00008000	/* PLB3 bus arbiter */
+#define IBM_CPM_PPM		0x00002000	/* PLB Performance Monitor */
+#define IBM_CPM_UIC1		0x00001000	/* Universal Interrupt Controller */
+#define IBM_CPM_GPIO0		0x00000800	/* General Purpose IO (??) */
+#define IBM_CPM_GPT		0x00000400	/* General Purpose Timers  */
+#define IBM_CPM_UART0		0x00000200	/* serial port 0 */
+#define IBM_CPM_UART1		0x00000100	/* serial port 1 */
+#define IBM_CPM_UIC0		0x00000080	/* Universal Interrupt Controller */
+#define IBM_CPM_TMRCLK		0x00000040	/* CPU timers */
+#define IBM_CPM_EMAC0		0x00000020	/* ethernet port 0 */
+#define IBM_CPM_EMAC1		0x00000010	/* ethernet port 1 */
+#define IBM_CPM_UART2		0x00000008	/* serial port 2 */
+#define IBM_CPM_UART3		0x00000004	/* serial port 3 */
+#define IBM_CPM_USB2D		0x00000002	/* USB 2.0 Device */
+#define IBM_CPM_USB2H		0x00000001	/* USB 2.0 Host */
+
+#define DFLT_IBM4xx_PM		~(IBM_CPM_UIC0 | IBM_CPM_UIC1 | IBM_CPM_CPU \
+				| IBM_CPM_EBC | IBM_CPM_BGO | IBM_CPM_FPU \
+				| IBM_CPM_EBM | IBM_CPM_PLB4 | IBM_CPM_3x4 \
+				| IBM_CPM_PLB3 | IBM_CPM_PLB4x3 \
+				| IBM_CPM_EMAC0 | IBM_CPM_TMRCLK \
+				| IBM_CPM_DMA | IBM_CPM_PCI | IBM_CPM_EMAC1)
+
+
+#endif /* __PPC_PLATFORMS_IBM440EP_H */
+#endif /* __KERNEL__ */
diff -uprN linux-2.6.12/arch/ppc/syslib/Makefile linux-2.6.12-440ep/arch/ppc/syslib/Makefile
--- linux-2.6.12/arch/ppc/syslib/Makefile	2005-07-25 12:57:00.000000000 -0700
+++ linux-2.6.12-440ep/arch/ppc/syslib/Makefile	2005-07-25 11:32:22.000000000 -0700
@@ -11,6 +11,7 @@ obj-$(CONFIG_PPCBUG_NVRAM)	+= prep_nvram
 obj-$(CONFIG_PPC_OCP)		+= ocp.o
 obj-$(CONFIG_IBM_OCP)		+= ibm_ocp.o
 obj-$(CONFIG_44x)		+= ibm44x_common.o
+obj-$(CONFIG_440EP)		+= ibm440gx_common.o
 obj-$(CONFIG_440GP)		+= ibm440gp_common.o
 obj-$(CONFIG_440GX)		+= ibm440gx_common.o
 obj-$(CONFIG_440SP)		+= ibm440gx_common.o ibm440sp_common.o
@@ -44,6 +45,7 @@ obj-$(CONFIG_PPC_CHRP)		+= open_pic.o in
 obj-$(CONFIG_PPC_PREP)		+= open_pic.o indirect_pci.o i8259.o todc_time.o
 obj-$(CONFIG_ADIR)		+= i8259.o indirect_pci.o pci_auto.o \
 					todc_time.o
+obj-$(CONFIG_BAMBOO)		+= indirect_pci.o pci_auto.o todc_time.o
 obj-$(CONFIG_CPCI690)		+= todc_time.o pci_auto.o
 obj-$(CONFIG_EBONY)		+= indirect_pci.o pci_auto.o todc_time.o
 obj-$(CONFIG_EV64260)		+= todc_time.o pci_auto.o
diff -uprN linux-2.6.12/arch/ppc/syslib/ibm440gx_common.c linux-2.6.12-440ep/arch/ppc/syslib/ibm440gx_common.c
--- linux-2.6.12/arch/ppc/syslib/ibm440gx_common.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-440ep/arch/ppc/syslib/ibm440gx_common.c	2005-07-25 11:32:22.000000000 -0700
@@ -34,6 +34,10 @@ void __init ibm440gx_get_clocks(struct i
 	u32 plld  = CPR_READ(DCRN_CPR_PLLD);
 	u32 uart0 = SDR_READ(DCRN_SDR_UART0);
 	u32 uart1 = SDR_READ(DCRN_SDR_UART1);
+#ifdef CONFIG_440EP
+	u32 uart2 = SDR_READ(DCRN_SDR_UART2);
+	u32 uart3 = SDR_READ(DCRN_SDR_UART3);
+#endif
 
 	/* Dividers */
 	u32 fbdv   = __fix_zero((plld >> 24) & 0x1f, 32);
@@ -96,6 +100,17 @@ bypass:
 		p->uart1 = ser_clk;
 	else
 		p->uart1 = p->plb / __fix_zero(uart1 & 0xff, 256);
+#ifdef CONFIG_440EP
+	if (uart2 & 0x00800000)
+		p->uart2 = ser_clk;
+	else
+		p->uart2 = p->plb / __fix_zero(uart2 & 0xff, 256);
+	
+	if (uart3 & 0x00800000)
+		p->uart3 = ser_clk;
+	else
+		p->uart3 = p->plb / __fix_zero(uart3 & 0xff, 256);
+#endif
 }
 
 /* Issue L2C diagnostic command */
diff -uprN linux-2.6.12/arch/ppc/syslib/ibm44x_common.h linux-2.6.12-440ep/arch/ppc/syslib/ibm44x_common.h
--- linux-2.6.12/arch/ppc/syslib/ibm44x_common.h	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-440ep/arch/ppc/syslib/ibm44x_common.h	2005-07-25 11:32:23.000000000 -0700
@@ -29,6 +29,10 @@ struct ibm44x_clocks {
 	unsigned int ebc;	/* PerClk */
 	unsigned int uart0;
 	unsigned int uart1;
+#ifdef CONFIG_440EP
+	unsigned int uart2;
+	unsigned int uart3;
+#endif
 };
 
 /* common 44x platform init */

--=-wATmQvwCLT5PHgmfek7p--
