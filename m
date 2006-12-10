Return-Path: <olaf@aepfle.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.190])
	by ozlabs.org (Postfix) with ESMTP id 6258867BEA
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Dec 2006 23:19:39 +1100 (EST)
Date: Sun, 10 Dec 2006 13:19:19 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] update powerpc defconfig files
Message-ID: <20061210121916.GA8857@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Refresh defconfig files for 2.6.19-git15
Enable more drivers in ppc64_defconfig

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 arch/powerpc/configs/cell_defconfig         |   71 +++--
 arch/powerpc/configs/chrp32_defconfig       |  160 +++++++++----
 arch/powerpc/configs/g5_defconfig           |  226 ++++++++++++++----
 arch/powerpc/configs/iseries_defconfig      |  117 ++++++---
 arch/powerpc/configs/linkstation_defconfig  |   92 +++++--
 arch/powerpc/configs/lite5200_defconfig     |   28 +-
 arch/powerpc/configs/maple_defconfig        |   74 ++++--
 arch/powerpc/configs/mpc7448_hpc2_defconfig |  164 ++++++++++---
 arch/powerpc/configs/mpc834x_itx_defconfig  |  175 +++++++++++---
 arch/powerpc/configs/mpc834x_mds_defconfig  |   85 +++++-
 arch/powerpc/configs/mpc8360emds_defconfig  |   93 ++++++-
 arch/powerpc/configs/mpc8540_ads_defconfig  |   77 ++++--
 arch/powerpc/configs/mpc8560_ads_defconfig  |   85 +++++-
 arch/powerpc/configs/mpc85xx_cds_defconfig  |   85 +++++-
 arch/powerpc/configs/mpc8641_hpcn_defconfig |   83 +++++-
 arch/powerpc/configs/pmac32_defconfig       |  209 ++++++++++++-----
 arch/powerpc/configs/ppc64_defconfig        |  341 +++++++++++++++++++++-------
 arch/powerpc/configs/ps3_defconfig          |   27 +-
 arch/powerpc/configs/pseries_defconfig      |  229 +++++++++++++++---
 arch/ppc/configs/prep_defconfig             |  157 ++++++++----
 20 files changed, 1920 insertions(+), 658 deletions(-)

Index: linux-2.6/arch/powerpc/configs/cell_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/cell_defconfig
+++ linux-2.6/arch/powerpc/configs/cell_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.19-rc6
-# Wed Nov 22 15:33:04 2006
+# Linux kernel version: 2.6.19
+# Sat Dec  9 13:48:26 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -10,6 +10,8 @@ CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+CONFIG_ARCH_HAS_ILOG2_U64=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -66,6 +68,7 @@ CONFIG_SYSVIPC=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CPUSETS=y
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
@@ -128,14 +131,16 @@ CONFIG_PPC_MULTIPLATFORM=y
 # CONFIG_APUS is not set
 # CONFIG_PPC_PSERIES is not set
 # CONFIG_PPC_ISERIES is not set
+# CONFIG_PPC_MPC52xx is not set
 # CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_MAPLE is not set
 # CONFIG_PPC_PASEMI is not set
 CONFIG_PPC_CELL=y
 CONFIG_PPC_CELL_NATIVE=y
 CONFIG_PPC_IBM_CELL_BLADE=y
-CONFIG_UDBG_RTAS_CONSOLE=y
 CONFIG_PPC_PS3=y
+CONFIG_PPC_NATIVE=y
+CONFIG_UDBG_RTAS_CONSOLE=y
 # CONFIG_U3_DART is not set
 CONFIG_PPC_RTAS=y
 # CONFIG_RTAS_ERROR_LOGGING is not set
@@ -183,6 +188,7 @@ CONFIG_PS3_USE_LPAR_ADDR=y
 #
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
@@ -237,6 +243,7 @@ CONFIG_GENERIC_ISA_DMA=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 CONFIG_PCIEPORTBUS=y
+# CONFIG_PCI_MULTITHREAD_PROBE is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -289,6 +296,7 @@ CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 
 #
 # IP: Virtual Server Configuration
@@ -318,29 +326,35 @@ CONFIG_NETFILTER=y
 # Core Netfilter Configuration
 #
 # CONFIG_NETFILTER_NETLINK is not set
+CONFIG_NF_CONNTRACK_ENABLED=y
+CONFIG_NF_CONNTRACK_SUPPORT=y
+# CONFIG_IP_NF_CONNTRACK_SUPPORT is not set
+CONFIG_NF_CONNTRACK=y
+# CONFIG_NF_CT_ACCT is not set
+# CONFIG_NF_CONNTRACK_MARK is not set
+# CONFIG_NF_CONNTRACK_EVENTS is not set
+# CONFIG_NF_CT_PROTO_SCTP is not set
+# CONFIG_NF_CONNTRACK_AMANDA is not set
+CONFIG_NF_CONNTRACK_FTP=m
+# CONFIG_NF_CONNTRACK_H323 is not set
+CONFIG_NF_CONNTRACK_IRC=m
+# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
+# CONFIG_NF_CONNTRACK_PPTP is not set
+# CONFIG_NF_CONNTRACK_SIP is not set
+# CONFIG_NF_CONNTRACK_TFTP is not set
 # CONFIG_NETFILTER_XTABLES is not set
 
 #
 # IP: Netfilter Configuration
 #
-CONFIG_IP_NF_CONNTRACK=y
-# CONFIG_IP_NF_CT_ACCT is not set
-# CONFIG_IP_NF_CONNTRACK_MARK is not set
-# CONFIG_IP_NF_CONNTRACK_EVENTS is not set
-CONFIG_IP_NF_CT_PROTO_SCTP=y
-CONFIG_IP_NF_FTP=m
-CONFIG_IP_NF_IRC=m
-# CONFIG_IP_NF_NETBIOS_NS is not set
-CONFIG_IP_NF_TFTP=m
-CONFIG_IP_NF_AMANDA=m
-# CONFIG_IP_NF_PPTP is not set
-# CONFIG_IP_NF_H323 is not set
-# CONFIG_IP_NF_SIP is not set
+CONFIG_NF_CONNTRACK_IPV4=m
+CONFIG_NF_CONNTRACK_PROC_COMPAT=y
 CONFIG_IP_NF_QUEUE=m
 
 #
 # IPv6: Netfilter Configuration (EXPERIMENTAL)
 #
+CONFIG_NF_CONNTRACK_IPV6=m
 # CONFIG_IP6_NF_QUEUE is not set
 
 #
@@ -468,7 +482,6 @@ CONFIG_IDEPCI_SHARE_IRQ=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 CONFIG_BLK_DEV_GENERIC=y
 # CONFIG_BLK_DEV_OPTI621 is not set
-# CONFIG_BLK_DEV_SL82C105 is not set
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
@@ -492,6 +505,7 @@ CONFIG_BLK_DEV_AEC62XX=y
 # CONFIG_BLK_DEV_PDC202XX_NEW is not set
 # CONFIG_BLK_DEV_SVWKS is not set
 CONFIG_BLK_DEV_SIIMAGE=y
+# CONFIG_BLK_DEV_SL82C105 is not set
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
 # CONFIG_BLK_DEV_VIA82CXXX is not set
@@ -552,6 +566,7 @@ CONFIG_DM_MULTIPATH=m
 #
 # Macintosh device drivers
 #
+# CONFIG_MAC_EMUMOUSEBTN is not set
 # CONFIG_WINDFARM is not set
 
 #
@@ -618,6 +633,7 @@ CONFIG_SPIDER_NET=m
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
 
 #
 # Token Ring devices
@@ -703,6 +719,7 @@ CONFIG_SERIAL_NONSTANDARD=y
 # CONFIG_DIGIEPCA is not set
 # CONFIG_MOXA_INTELLIO is not set
 # CONFIG_MOXA_SMARTIO is not set
+# CONFIG_MOXA_SMARTIO_NEW is not set
 # CONFIG_ISI is not set
 # CONFIG_SYNCLINK is not set
 # CONFIG_SYNCLINKMP is not set
@@ -762,10 +779,6 @@ CONFIG_GEN_RTC=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -875,6 +888,11 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_SOUND is not set
 
 #
+# HID Devices
+#
+# CONFIG_HID is not set
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -1120,16 +1138,20 @@ CONFIG_NLS_ISO8859_15=m
 # CONFIG_NLS_UTF8 is not set
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Library routines
 #
+CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=m
 CONFIG_ZLIB_DEFLATE=m
-CONFIG_TEXTSEARCH=y
-CONFIG_TEXTSEARCH_KMP=m
 CONFIG_PLIST=y
 
 #
@@ -1191,6 +1213,7 @@ CONFIG_CRYPTO_BLKCIPHER=m
 CONFIG_CRYPTO_HASH=y
 CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_HMAC=y
+# CONFIG_CRYPTO_XCBC is not set
 # CONFIG_CRYPTO_NULL is not set
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=m
@@ -1199,8 +1222,10 @@ CONFIG_CRYPTO_SHA1=m
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_CBC=m
+# CONFIG_CRYPTO_LRW is not set
 CONFIG_CRYPTO_DES=m
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
Index: linux-2.6/arch/powerpc/configs/chrp32_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/chrp32_defconfig
+++ linux-2.6/arch/powerpc/configs/chrp32_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc6
-# Sun Sep 10 10:22:54 2006
+# Linux kernel version: 2.6.19
+# Sat Dec  9 13:48:29 2006
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -10,6 +10,7 @@ CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -21,13 +22,13 @@ CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_PPC_OF=y
 CONFIG_PPC_UDBG_16550=y
 CONFIG_GENERIC_TBSYNC=y
+CONFIG_AUDIT_ARCH=y
 # CONFIG_DEFAULT_UIMAGE is not set
 
 #
 # Processor support
 #
 CONFIG_CLASSIC32=y
-# CONFIG_PPC_52xx is not set
 # CONFIG_PPC_82xx is not set
 # CONFIG_PPC_83xx is not set
 # CONFIG_PPC_85xx is not set
@@ -38,6 +39,8 @@ CONFIG_CLASSIC32=y
 # CONFIG_E200 is not set
 CONFIG_6xx=y
 CONFIG_PPC_FPU=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
 # CONFIG_ALTIVEC is not set
 CONFIG_PPC_STD_MMU=y
 CONFIG_PPC_STD_MMU_32=y
@@ -59,18 +62,22 @@ CONFIG_LOCALVERSION=""
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-CONFIG_SYSCTL=y
+# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_CPUSETS is not set
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -79,12 +86,12 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
-CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
 CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
@@ -103,6 +110,7 @@ CONFIG_STOP_MACHINE=y
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 CONFIG_LBD=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
@@ -124,13 +132,16 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # Platform support
 #
 CONFIG_PPC_MULTIPLATFORM=y
-# CONFIG_PPC_ISERIES is not set
 # CONFIG_EMBEDDED6xx is not set
 # CONFIG_APUS is not set
 CONFIG_PPC_CHRP=y
+CONFIG_PPC_MPC52xx=y
+CONFIG_PPC_EFIKA=y
+# CONFIG_PPC_LITE5200 is not set
 # CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
+CONFIG_PPC_NATIVE=y
 # CONFIG_UDBG_RTAS_CONSOLE is not set
 CONFIG_PPC_RTAS=y
 # CONFIG_RTAS_ERROR_LOGGING is not set
@@ -138,6 +149,8 @@ CONFIG_RTAS_PROC=y
 # CONFIG_MMIO_NVRAM is not set
 CONFIG_PPC_MPC106=y
 # CONFIG_PPC_970_NAP is not set
+# CONFIG_PPC_INDIRECT_IO is not set
+# CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
 # CONFIG_TAU is not set
 # CONFIG_WANT_EARLY_SERIAL is not set
@@ -149,6 +162,7 @@ CONFIG_MPIC=y
 CONFIG_HIGHMEM=y
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
@@ -161,6 +175,7 @@ CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 # CONFIG_KEXEC is not set
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -187,6 +202,7 @@ CONFIG_PPC_INDIRECT_PCI=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCIEPORTBUS is not set
+# CONFIG_PCI_MULTITHREAD_PROBE is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -243,10 +259,13 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 
 #
 # IP: Virtual Server Configuration
@@ -263,24 +282,29 @@ CONFIG_NETFILTER=y
 # Core Netfilter Configuration
 #
 # CONFIG_NETFILTER_NETLINK is not set
+CONFIG_NF_CONNTRACK_ENABLED=y
+CONFIG_NF_CONNTRACK_SUPPORT=y
+# CONFIG_IP_NF_CONNTRACK_SUPPORT is not set
+CONFIG_NF_CONNTRACK=y
+# CONFIG_NF_CT_ACCT is not set
+# CONFIG_NF_CONNTRACK_MARK is not set
+# CONFIG_NF_CONNTRACK_EVENTS is not set
+# CONFIG_NF_CT_PROTO_SCTP is not set
+# CONFIG_NF_CONNTRACK_AMANDA is not set
+CONFIG_NF_CONNTRACK_FTP=m
+# CONFIG_NF_CONNTRACK_H323 is not set
+CONFIG_NF_CONNTRACK_IRC=m
+# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
+# CONFIG_NF_CONNTRACK_PPTP is not set
+# CONFIG_NF_CONNTRACK_SIP is not set
+# CONFIG_NF_CONNTRACK_TFTP is not set
 # CONFIG_NETFILTER_XTABLES is not set
 
 #
 # IP: Netfilter Configuration
 #
-CONFIG_IP_NF_CONNTRACK=m
-# CONFIG_IP_NF_CT_ACCT is not set
-# CONFIG_IP_NF_CONNTRACK_MARK is not set
-# CONFIG_IP_NF_CONNTRACK_EVENTS is not set
-# CONFIG_IP_NF_CT_PROTO_SCTP is not set
-CONFIG_IP_NF_FTP=m
-CONFIG_IP_NF_IRC=m
-# CONFIG_IP_NF_NETBIOS_NS is not set
-CONFIG_IP_NF_TFTP=m
-CONFIG_IP_NF_AMANDA=m
-# CONFIG_IP_NF_PPTP is not set
-# CONFIG_IP_NF_H323 is not set
-# CONFIG_IP_NF_SIP is not set
+CONFIG_NF_CONNTRACK_IPV4=m
+CONFIG_NF_CONNTRACK_PROC_COMPAT=y
 # CONFIG_IP_NF_QUEUE is not set
 
 #
@@ -306,7 +330,6 @@ CONFIG_IP_NF_AMANDA=m
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 
@@ -381,6 +404,12 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
+# Misc devices
+#
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+
+#
 # ATA/ATAPI/MFM/RLL support
 #
 CONFIG_IDE=y
@@ -407,7 +436,6 @@ CONFIG_IDEPCI_SHARE_IRQ=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 CONFIG_BLK_DEV_GENERIC=y
 # CONFIG_BLK_DEV_OPTI621 is not set
-CONFIG_BLK_DEV_SL82C105=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
@@ -422,6 +450,7 @@ CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_BLK_DEV_CS5530 is not set
 # CONFIG_BLK_DEV_HPT34X is not set
 # CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_JMICRON is not set
 # CONFIG_BLK_DEV_SC1200 is not set
 # CONFIG_BLK_DEV_PIIX is not set
 # CONFIG_BLK_DEV_IT821X is not set
@@ -430,6 +459,7 @@ CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_BLK_DEV_PDC202XX_NEW is not set
 # CONFIG_BLK_DEV_SVWKS is not set
 # CONFIG_BLK_DEV_SIIMAGE is not set
+CONFIG_BLK_DEV_SL82C105=y
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
 CONFIG_BLK_DEV_VIA82CXXX=y
@@ -445,6 +475,8 @@ CONFIG_IDEDMA_AUTO=y
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+# CONFIG_SCSI_TGT is not set
+# CONFIG_SCSI_NETLINK is not set
 CONFIG_SCSI_PROC_FS=y
 
 #
@@ -464,14 +496,16 @@ CONFIG_CHR_DEV_SG=y
 # CONFIG_SCSI_MULTI_LUN is not set
 CONFIG_SCSI_CONSTANTS=y
 # CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
 
 #
-# SCSI Transport Attributes
+# SCSI Transports
 #
 CONFIG_SCSI_SPI_ATTRS=y
 # CONFIG_SCSI_FC_ATTRS is not set
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
 
 #
 # SCSI low-level drivers
@@ -487,12 +521,13 @@ CONFIG_SCSI_SPI_ATTRS=y
 # CONFIG_SCSI_AIC7XXX is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC94XX is not set
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_IN2000 is not set
+# CONFIG_SCSI_ARCMSR is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_ATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
@@ -506,17 +541,18 @@ CONFIG_SCSI_SPI_ATTRS=y
 # CONFIG_SCSI_INITIO is not set
 # CONFIG_SCSI_INIA100 is not set
 # CONFIG_SCSI_NCR53C406A is not set
+# CONFIG_SCSI_STEX is not set
 CONFIG_SCSI_SYM53C8XX_2=y
 CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
 CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
 CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
 CONFIG_SCSI_SYM53C8XX_MMIO=y
-# CONFIG_SCSI_IPR is not set
 # CONFIG_SCSI_PAS16 is not set
 # CONFIG_SCSI_PSI240I is not set
 # CONFIG_SCSI_QLOGIC_FAS is not set
 # CONFIG_SCSI_QLOGIC_1280 is not set
 # CONFIG_SCSI_QLA_FC is not set
+# CONFIG_SCSI_QLA_ISCSI is not set
 # CONFIG_SCSI_LPFC is not set
 # CONFIG_SCSI_SYM53C416 is not set
 # CONFIG_SCSI_DC395x is not set
@@ -525,6 +561,12 @@ CONFIG_SCSI_SYM53C8XX_MMIO=y
 # CONFIG_SCSI_U14_34F is not set
 # CONFIG_SCSI_NSP32 is not set
 # CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_SRP is not set
+
+#
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+# CONFIG_ATA is not set
 
 #
 # Old CD-ROM drivers (not SCSI, not IDE)
@@ -557,6 +599,7 @@ CONFIG_SCSI_SYM53C8XX_MMIO=y
 #
 # Macintosh device drivers
 #
+# CONFIG_MAC_EMUMOUSEBTN is not set
 # CONFIG_WINDFARM is not set
 
 #
@@ -607,6 +650,7 @@ CONFIG_DE4X5=y
 # CONFIG_NET_ISA is not set
 CONFIG_NET_PCI=y
 CONFIG_PCNET32=y
+CONFIG_PCNET32_NAPI=y
 # CONFIG_AMD8111_ETH is not set
 # CONFIG_ADAPTEC_STARFIRE is not set
 # CONFIG_AC3200 is not set
@@ -655,6 +699,7 @@ CONFIG_MV643XX_ETH=y
 # CONFIG_MV643XX_ETH_0 is not set
 # CONFIG_MV643XX_ETH_1 is not set
 # CONFIG_MV643XX_ETH_2 is not set
+# CONFIG_QLA3XXX is not set
 
 #
 # Ethernet (10000 Mbit)
@@ -663,6 +708,7 @@ CONFIG_MV643XX_ETH=y
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
 
 #
 # Token Ring devices
@@ -690,6 +736,7 @@ CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_MPPE=m
 CONFIG_PPPOE=m
 # CONFIG_SLIP is not set
+CONFIG_SLHC=m
 # CONFIG_NET_FC is not set
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
@@ -710,6 +757,7 @@ CONFIG_PPPOE=m
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -732,6 +780,7 @@ CONFIG_KEYBOARD_ATKBD=y
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
 CONFIG_INPUT_MOUSE=y
 CONFIG_MOUSE_PS2=y
 # CONFIG_MOUSE_SERIAL is not set
@@ -778,12 +827,15 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 #
 # Non-8250 serial port support
 #
+# CONFIG_SERIAL_UARTLITE is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_MPC52xx is not set
 # CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
+CONFIG_BRIQ_PANEL=m
 # CONFIG_HVC_RTAS is not set
 
 #
@@ -802,10 +854,6 @@ CONFIG_GEN_RTC=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -814,7 +862,6 @@ CONFIG_GEN_RTC=y
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-# CONFIG_TELCLOCK is not set
 
 #
 # I2C support
@@ -881,6 +928,7 @@ CONFIG_I2C_ALGOBIT=y
 #
 # Dallas's 1-wire bus
 #
+# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -889,14 +937,9 @@ CONFIG_I2C_ALGOBIT=y
 # CONFIG_HWMON_VID is not set
 
 #
-# Misc devices
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -909,6 +952,7 @@ CONFIG_VIDEO_V4L2=y
 #
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB=y
+CONFIG_FB_DDC=y
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
@@ -979,6 +1023,11 @@ CONFIG_LOGO_LINUX_CLUT224=y
 # CONFIG_SOUND is not set
 
 #
+# HID Devices
+#
+CONFIG_HID=y
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -993,6 +1042,7 @@ CONFIG_USB=y
 CONFIG_USB_DEVICEFS=y
 # CONFIG_USB_BANDWIDTH is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_MULTITHREAD_PROBE is not set
 # CONFIG_USB_OTG is not set
 
 #
@@ -1004,7 +1054,9 @@ CONFIG_USB_EHCI_HCD=m
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
 # CONFIG_USB_ISP116X_HCD is not set
 CONFIG_USB_OHCI_HCD=y
-# CONFIG_USB_OHCI_BIG_ENDIAN is not set
+CONFIG_USB_OHCI_HCD_PPC_SOC=y
+CONFIG_USB_OHCI_HCD_PCI=y
+CONFIG_USB_OHCI_BIG_ENDIAN=y
 CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 CONFIG_USB_UHCI_HCD=y
 # CONFIG_USB_SL811_HCD is not set
@@ -1034,14 +1086,14 @@ CONFIG_USB_STORAGE=m
 # CONFIG_USB_STORAGE_JUMPSHOT is not set
 # CONFIG_USB_STORAGE_ALAUDA is not set
 # CONFIG_USB_STORAGE_ONETOUCH is not set
+# CONFIG_USB_STORAGE_KARMA is not set
 # CONFIG_USB_LIBUSUAL is not set
 
 #
 # USB Input Devices
 #
 CONFIG_USB_HID=y
-CONFIG_USB_HIDINPUT=y
-# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_USB_HID_POWERBOOK is not set
 # CONFIG_HID_FF is not set
 # CONFIG_USB_HIDDEV is not set
 # CONFIG_USB_AIPTEK is not set
@@ -1070,6 +1122,7 @@ CONFIG_USB_HIDINPUT=y
 # CONFIG_USB_KAWETH is not set
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET_MII is not set
 # CONFIG_USB_USBNET is not set
 CONFIG_USB_MON=y
 
@@ -1087,6 +1140,7 @@ CONFIG_USB_MON=y
 #
 # CONFIG_USB_EMI62 is not set
 # CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
@@ -1094,12 +1148,13 @@ CONFIG_USB_MON=y
 # CONFIG_USB_LED is not set
 # CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
-# CONFIG_USB_PHIDGETKIT is not set
-# CONFIG_USB_PHIDGETSERVO is not set
+# CONFIG_USB_PHIDGET is not set
 # CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
 # CONFIG_USB_APPLEDISPLAY is not set
 # CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_TEST is not set
 
 #
@@ -1166,6 +1221,7 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
 # CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
@@ -1173,6 +1229,7 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -1207,8 +1264,10 @@ CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -1308,16 +1367,20 @@ CONFIG_NLS_ISO8859_1=m
 # CONFIG_NLS_UTF8 is not set
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Library routines
 #
+CONFIG_BITREVERSE=y
 CONFIG_CRC_CCITT=m
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=m
 CONFIG_ZLIB_DEFLATE=m
-CONFIG_TEXTSEARCH=y
-CONFIG_TEXTSEARCH_KMP=m
 CONFIG_PLIST=y
 
 #
@@ -1329,6 +1392,7 @@ CONFIG_PLIST=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
@@ -1348,13 +1412,17 @@ CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 CONFIG_FORCED_INLINING=y
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 CONFIG_DEBUGGER=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
+CONFIG_XMON_DISASSEMBLY=y
 # CONFIG_BDI_SWITCH is not set
 # CONFIG_BOOTX_TEXT is not set
+# CONFIG_SERIAL_TEXT_DEBUG is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
 
 #
@@ -1367,7 +1435,11 @@ CONFIG_XMON_DEFAULT=y
 # Cryptographic options
 #
 CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=m
+CONFIG_CRYPTO_BLKCIPHER=m
+CONFIG_CRYPTO_MANAGER=m
 # CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
 # CONFIG_CRYPTO_NULL is not set
 # CONFIG_CRYPTO_MD4 is not set
 # CONFIG_CRYPTO_MD5 is not set
@@ -1376,6 +1448,10 @@ CONFIG_CRYPTO_SHA1=m
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+CONFIG_CRYPTO_ECB=m
+# CONFIG_CRYPTO_CBC is not set
+# CONFIG_CRYPTO_LRW is not set
 # CONFIG_CRYPTO_DES is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
Index: linux-2.6/arch/powerpc/configs/g5_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/g5_defconfig
+++ linux-2.6/arch/powerpc/configs/g5_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc6
-# Sun Sep 10 10:22:55 2006
+# Linux kernel version: 2.6.19
+# Sun Dec 10 11:25:49 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -10,6 +10,8 @@ CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+CONFIG_ARCH_HAS_ILOG2_U64=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -22,6 +24,7 @@ CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_PPC_OF=y
 # CONFIG_PPC_UDBG_16550 is not set
 CONFIG_GENERIC_TBSYNC=y
+CONFIG_AUDIT_ARCH=y
 # CONFIG_DEFAULT_UIMAGE is not set
 
 #
@@ -30,6 +33,9 @@ CONFIG_GENERIC_TBSYNC=y
 CONFIG_POWER4_ONLY=y
 CONFIG_POWER4=y
 CONFIG_PPC_FPU=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
+# CONFIG_PPC_OF_PLATFORM_PCI is not set
 CONFIG_ALTIVEC=y
 CONFIG_PPC_STD_MMU=y
 CONFIG_VIRT_CPU_ACCOUNTING=y
@@ -51,18 +57,22 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-CONFIG_SYSCTL=y
+# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_CPUSETS is not set
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -71,12 +81,12 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
-CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
 CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
@@ -95,6 +105,7 @@ CONFIG_STOP_MACHINE=y
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
 
 #
@@ -114,23 +125,28 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # Platform support
 #
 CONFIG_PPC_MULTIPLATFORM=y
-# CONFIG_PPC_ISERIES is not set
 # CONFIG_EMBEDDED6xx is not set
 # CONFIG_APUS is not set
 # CONFIG_PPC_PSERIES is not set
+# CONFIG_PPC_ISERIES is not set
+# CONFIG_PPC_MPC52xx is not set
 CONFIG_PPC_PMAC=y
 CONFIG_PPC_PMAC64=y
 # CONFIG_PPC_MAPLE is not set
+# CONFIG_PPC_PASEMI is not set
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_IBM_CELL_BLADE is not set
-# CONFIG_UDBG_RTAS_CONSOLE is not set
+# CONFIG_PPC_PS3 is not set
+CONFIG_PPC_NATIVE=y
 CONFIG_U3_DART=y
 # CONFIG_PPC_RTAS is not set
 # CONFIG_MMIO_NVRAM is not set
 CONFIG_MPIC_BROKEN_U3=y
 # CONFIG_PPC_MPC106 is not set
 CONFIG_PPC_970_NAP=y
+# CONFIG_PPC_INDIRECT_IO is not set
+# CONFIG_GENERIC_IOMAP is not set
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_TABLE=y
 # CONFIG_CPU_FREQ_DEBUG is not set
@@ -152,6 +168,7 @@ CONFIG_MPIC=y
 #
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
@@ -171,6 +188,7 @@ CONFIG_IRQ_ALL_CPUS=y
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_SPARSEMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -198,6 +216,7 @@ CONFIG_GENERIC_ISA_DMA=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCIEPORTBUS is not set
+# CONFIG_PCI_MULTITHREAD_PROBE is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -225,6 +244,7 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 CONFIG_XFRM_USER=m
+# CONFIG_XFRM_SUB_POLICY is not set
 CONFIG_NET_KEY=m
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -243,10 +263,13 @@ CONFIG_INET_XFRM_TUNNEL=m
 CONFIG_INET_TUNNEL=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
+# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 
 #
 # IP: Virtual Server Configuration
@@ -263,24 +286,29 @@ CONFIG_NETFILTER=y
 # Core Netfilter Configuration
 #
 # CONFIG_NETFILTER_NETLINK is not set
+CONFIG_NF_CONNTRACK_ENABLED=y
+CONFIG_NF_CONNTRACK_SUPPORT=y
+# CONFIG_IP_NF_CONNTRACK_SUPPORT is not set
+CONFIG_NF_CONNTRACK=y
+CONFIG_NF_CT_ACCT=y
+CONFIG_NF_CONNTRACK_MARK=y
+CONFIG_NF_CONNTRACK_EVENTS=y
+CONFIG_NF_CT_PROTO_SCTP=m
+CONFIG_NF_CONNTRACK_AMANDA=m
+CONFIG_NF_CONNTRACK_FTP=m
+CONFIG_NF_CONNTRACK_H323=m
+CONFIG_NF_CONNTRACK_IRC=m
+# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
+# CONFIG_NF_CONNTRACK_PPTP is not set
+# CONFIG_NF_CONNTRACK_SIP is not set
+CONFIG_NF_CONNTRACK_TFTP=m
 # CONFIG_NETFILTER_XTABLES is not set
 
 #
 # IP: Netfilter Configuration
 #
-CONFIG_IP_NF_CONNTRACK=m
-CONFIG_IP_NF_CT_ACCT=y
-CONFIG_IP_NF_CONNTRACK_MARK=y
-CONFIG_IP_NF_CONNTRACK_EVENTS=y
-CONFIG_IP_NF_CT_PROTO_SCTP=m
-CONFIG_IP_NF_FTP=m
-CONFIG_IP_NF_IRC=m
-# CONFIG_IP_NF_NETBIOS_NS is not set
-CONFIG_IP_NF_TFTP=m
-CONFIG_IP_NF_AMANDA=m
-# CONFIG_IP_NF_PPTP is not set
-# CONFIG_IP_NF_H323 is not set
-# CONFIG_IP_NF_SIP is not set
+CONFIG_NF_CONNTRACK_IPV4=m
+CONFIG_NF_CONNTRACK_PROC_COMPAT=y
 CONFIG_IP_NF_QUEUE=m
 
 #
@@ -307,7 +335,6 @@ CONFIG_LLC=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 
@@ -382,6 +409,12 @@ CONFIG_CDROM_PKTCDVD_BUFFERS=8
 # CONFIG_ATA_OVER_ETH is not set
 
 #
+# Misc devices
+#
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+
+#
 # ATA/ATAPI/MFM/RLL support
 #
 CONFIG_IDE=y
@@ -408,7 +441,6 @@ CONFIG_BLK_DEV_IDEPCI=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 # CONFIG_BLK_DEV_GENERIC is not set
 # CONFIG_BLK_DEV_OPTI621 is not set
-# CONFIG_BLK_DEV_SL82C105 is not set
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
@@ -423,6 +455,7 @@ CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_BLK_DEV_CS5530 is not set
 # CONFIG_BLK_DEV_HPT34X is not set
 # CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_JMICRON is not set
 # CONFIG_BLK_DEV_SC1200 is not set
 # CONFIG_BLK_DEV_PIIX is not set
 # CONFIG_BLK_DEV_IT821X is not set
@@ -431,6 +464,7 @@ CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_BLK_DEV_PDC202XX_NEW is not set
 # CONFIG_BLK_DEV_SVWKS is not set
 # CONFIG_BLK_DEV_SIIMAGE is not set
+# CONFIG_BLK_DEV_SL82C105 is not set
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
 # CONFIG_BLK_DEV_VIA82CXXX is not set
@@ -448,6 +482,8 @@ CONFIG_IDEDMA_AUTO=y
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+# CONFIG_SCSI_TGT is not set
+# CONFIG_SCSI_NETLINK is not set
 CONFIG_SCSI_PROC_FS=y
 
 #
@@ -467,14 +503,16 @@ CONFIG_CHR_DEV_SG=y
 CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 # CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
 
 #
-# SCSI Transport Attributes
+# SCSI Transports
 #
 CONFIG_SCSI_SPI_ATTRS=y
 # CONFIG_SCSI_FC_ATTRS is not set
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
 
 #
 # SCSI low-level drivers
@@ -487,26 +525,12 @@ CONFIG_SCSI_SPI_ATTRS=y
 # CONFIG_SCSI_AIC7XXX is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC94XX is not set
+# CONFIG_SCSI_ARCMSR is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-CONFIG_ATA=y
-# CONFIG_SATA_AHCI is not set
-CONFIG_SATA_SVW=y
-# CONFIG_SCSI_ATA_PIIX is not set
-# CONFIG_SATA_MV is not set
-# CONFIG_SATA_NV is not set
-# CONFIG_SCSI_PDC_ADMA is not set
 # CONFIG_SCSI_HPTIOP is not set
-# CONFIG_SATA_QSTOR is not set
-# CONFIG_SATA_PROMISE is not set
-# CONFIG_SATA_SX4 is not set
-# CONFIG_SATA_SIL is not set
-# CONFIG_SATA_SIL24 is not set
-# CONFIG_SATA_SIS is not set
-# CONFIG_SATA_ULI is not set
-# CONFIG_SATA_VIA is not set
-# CONFIG_SATA_VITESSE is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
@@ -515,14 +539,71 @@ CONFIG_SATA_SVW=y
 # CONFIG_SCSI_IPS is not set
 # CONFIG_SCSI_INITIO is not set
 # CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_STEX is not set
 # CONFIG_SCSI_SYM53C8XX_2 is not set
 # CONFIG_SCSI_IPR is not set
 # CONFIG_SCSI_QLOGIC_1280 is not set
 # CONFIG_SCSI_QLA_FC is not set
+# CONFIG_SCSI_QLA_ISCSI is not set
 # CONFIG_SCSI_LPFC is not set
 # CONFIG_SCSI_DC395x is not set
 # CONFIG_SCSI_DC390T is not set
 # CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_SRP is not set
+
+#
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+CONFIG_ATA=y
+# CONFIG_SATA_AHCI is not set
+CONFIG_SATA_SVW=y
+# CONFIG_ATA_PIIX is not set
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+# CONFIG_SATA_SIL is not set
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
+# CONFIG_PATA_ALI is not set
+# CONFIG_PATA_AMD is not set
+# CONFIG_PATA_ARTOP is not set
+# CONFIG_PATA_ATIIXP is not set
+# CONFIG_PATA_CMD64X is not set
+# CONFIG_PATA_CS5520 is not set
+# CONFIG_PATA_CS5530 is not set
+# CONFIG_PATA_CYPRESS is not set
+# CONFIG_PATA_EFAR is not set
+# CONFIG_ATA_GENERIC is not set
+# CONFIG_PATA_HPT366 is not set
+# CONFIG_PATA_HPT37X is not set
+# CONFIG_PATA_HPT3X2N is not set
+# CONFIG_PATA_HPT3X3 is not set
+# CONFIG_PATA_IT821X is not set
+# CONFIG_PATA_JMICRON is not set
+# CONFIG_PATA_TRIFLEX is not set
+# CONFIG_PATA_MARVELL is not set
+# CONFIG_PATA_MPIIX is not set
+# CONFIG_PATA_OLDPIIX is not set
+# CONFIG_PATA_NETCELL is not set
+# CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_OPTI is not set
+# CONFIG_PATA_OPTIDMA is not set
+# CONFIG_PATA_PDC_OLD is not set
+# CONFIG_PATA_RADISYS is not set
+# CONFIG_PATA_RZ1000 is not set
+# CONFIG_PATA_SC1200 is not set
+# CONFIG_PATA_SERVERWORKS is not set
+# CONFIG_PATA_PDC2027X is not set
+# CONFIG_PATA_SIL680 is not set
+# CONFIG_PATA_SIS is not set
+# CONFIG_PATA_VIA is not set
+# CONFIG_PATA_WINBOND is not set
 
 #
 # Multi-device support (RAID and LVM)
@@ -537,6 +618,7 @@ CONFIG_MD_RAID10=m
 CONFIG_MD_MULTIPATH=m
 CONFIG_MD_FAULTY=m
 CONFIG_BLK_DEV_DM=y
+# CONFIG_DM_DEBUG is not set
 CONFIG_DM_CRYPT=m
 CONFIG_DM_SNAPSHOT=m
 CONFIG_DM_MIRROR=m
@@ -591,11 +673,13 @@ CONFIG_IEEE1394_RAWIO=y
 CONFIG_ADB_PMU=y
 # CONFIG_ADB_PMU_LED is not set
 CONFIG_PMAC_SMU=y
+# CONFIG_MAC_EMUMOUSEBTN is not set
 CONFIG_THERM_PM72=y
 CONFIG_WINDFARM=y
 CONFIG_WINDFARM_PM81=y
 CONFIG_WINDFARM_PM91=y
 CONFIG_WINDFARM_PM112=y
+CONFIG_PMAC_RACKMETER=m
 
 #
 # Network device support
@@ -652,7 +736,7 @@ CONFIG_E1000=y
 # CONFIG_SK98LIN is not set
 CONFIG_TIGON3=y
 # CONFIG_BNX2 is not set
-# CONFIG_MV643XX_ETH is not set
+# CONFIG_QLA3XXX is not set
 
 #
 # Ethernet (10000 Mbit)
@@ -661,6 +745,7 @@ CONFIG_TIGON3=y
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
 
 #
 # Token Ring devices
@@ -691,6 +776,7 @@ CONFIG_PPP_BSDCOMP=m
 # CONFIG_PPP_MPPE is not set
 CONFIG_PPPOE=m
 # CONFIG_SLIP is not set
+CONFIG_SLHC=m
 # CONFIG_NET_FC is not set
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
@@ -711,6 +797,7 @@ CONFIG_PPPOE=m
 # Input device support
 #
 CONFIG_INPUT=y
+CONFIG_INPUT_FF_MEMLESS=y
 
 #
 # Userland interfaces
@@ -733,6 +820,7 @@ CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
 CONFIG_INPUT_MOUSE=y
 # CONFIG_MOUSE_PS2 is not set
 # CONFIG_MOUSE_SERIAL is not set
@@ -789,10 +877,6 @@ CONFIG_GEN_RTC=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 CONFIG_AGP=m
 # CONFIG_AGP_SIS is not set
 # CONFIG_AGP_VIA is not set
@@ -806,7 +890,6 @@ CONFIG_MAX_RAW_DEVS=256
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-# CONFIG_TELCLOCK is not set
 
 #
 # I2C support
@@ -871,6 +954,7 @@ CONFIG_I2C_POWERMAC=y
 #
 # Dallas's 1-wire bus
 #
+# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -879,14 +963,9 @@ CONFIG_I2C_POWERMAC=y
 # CONFIG_HWMON_VID is not set
 
 #
-# Misc devices
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -899,6 +978,7 @@ CONFIG_VIDEO_V4L2=y
 #
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB=y
+CONFIG_FB_DDC=y
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
@@ -1080,6 +1160,11 @@ CONFIG_SND_USB_AUDIO=m
 # CONFIG_SOUND_PRIME is not set
 
 #
+# HID Devices
+#
+CONFIG_HID=y
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -1094,6 +1179,7 @@ CONFIG_USB=y
 CONFIG_USB_DEVICEFS=y
 # CONFIG_USB_BANDWIDTH is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_MULTITHREAD_PROBE is not set
 # CONFIG_USB_OTG is not set
 
 #
@@ -1135,18 +1221,19 @@ CONFIG_USB_STORAGE_SDDR55=y
 CONFIG_USB_STORAGE_JUMPSHOT=y
 # CONFIG_USB_STORAGE_ALAUDA is not set
 # CONFIG_USB_STORAGE_ONETOUCH is not set
+# CONFIG_USB_STORAGE_KARMA is not set
 # CONFIG_USB_LIBUSUAL is not set
 
 #
 # USB Input Devices
 #
 CONFIG_USB_HID=y
-CONFIG_USB_HIDINPUT=y
-# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_USB_HID_POWERBOOK is not set
 CONFIG_HID_FF=y
 CONFIG_HID_PID=y
 CONFIG_LOGITECH_FF=y
 CONFIG_THRUSTMASTER_FF=y
+# CONFIG_ZEROPLUS_FF is not set
 CONFIG_USB_HIDDEV=y
 # CONFIG_USB_AIPTEK is not set
 # CONFIG_USB_WACOM is not set
@@ -1174,12 +1261,14 @@ CONFIG_USB_CATC=m
 CONFIG_USB_KAWETH=m
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
+# CONFIG_USB_USBNET_MII is not set
 CONFIG_USB_USBNET=m
 # CONFIG_USB_NET_AX8817X is not set
 CONFIG_USB_NET_CDCETHER=m
 # CONFIG_USB_NET_GL620A is not set
 # CONFIG_USB_NET_NET1080 is not set
 # CONFIG_USB_NET_PLUSB is not set
+# CONFIG_USB_NET_MCS7830 is not set
 # CONFIG_USB_NET_RNDIS_HOST is not set
 # CONFIG_USB_NET_CDC_SUBSET is not set
 # CONFIG_USB_NET_ZAURUS is not set
@@ -1194,6 +1283,7 @@ CONFIG_USB_MON=y
 #
 CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_GENERIC=y
+# CONFIG_USB_SERIAL_AIRCABLE is not set
 # CONFIG_USB_SERIAL_AIRPRIME is not set
 # CONFIG_USB_SERIAL_ARK3116 is not set
 CONFIG_USB_SERIAL_BELKIN=m
@@ -1228,6 +1318,8 @@ CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
 CONFIG_USB_SERIAL_KLSI=m
 CONFIG_USB_SERIAL_KOBIL_SCT=m
 CONFIG_USB_SERIAL_MCT_U232=m
+# CONFIG_USB_SERIAL_MOS7720 is not set
+# CONFIG_USB_SERIAL_MOS7840 is not set
 # CONFIG_USB_SERIAL_NAVMAN is not set
 CONFIG_USB_SERIAL_PL2303=m
 # CONFIG_USB_SERIAL_HP4X is not set
@@ -1239,6 +1331,7 @@ CONFIG_USB_SERIAL_CYBERJACK=m
 CONFIG_USB_SERIAL_XIRCOM=m
 # CONFIG_USB_SERIAL_OPTION is not set
 CONFIG_USB_SERIAL_OMNINET=m
+# CONFIG_USB_SERIAL_DEBUG is not set
 CONFIG_USB_EZUSB=y
 
 #
@@ -1246,6 +1339,7 @@ CONFIG_USB_EZUSB=y
 #
 # CONFIG_USB_EMI62 is not set
 # CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
@@ -1253,12 +1347,13 @@ CONFIG_USB_EZUSB=y
 # CONFIG_USB_LED is not set
 # CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
-# CONFIG_USB_PHIDGETKIT is not set
-# CONFIG_USB_PHIDGETSERVO is not set
+# CONFIG_USB_PHIDGET is not set
 # CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
 CONFIG_USB_APPLEDISPLAY=m
 # CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_TEST is not set
 
 #
@@ -1328,6 +1423,7 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
@@ -1344,6 +1440,7 @@ CONFIG_XFS_FS=m
 CONFIG_XFS_SECURITY=y
 CONFIG_XFS_POSIX_ACL=y
 # CONFIG_XFS_RT is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -1380,8 +1477,10 @@ CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 CONFIG_HUGETLBFS=y
 CONFIG_HUGETLB_PAGE=y
 CONFIG_RAMFS=y
@@ -1505,8 +1604,14 @@ CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_UTF8=y
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Library routines
 #
+CONFIG_BITREVERSE=y
 CONFIG_CRC_CCITT=m
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
@@ -1528,6 +1633,7 @@ CONFIG_OPROFILE=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
@@ -1546,7 +1652,9 @@ CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_INFO is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 CONFIG_FORCED_INLINING=y
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
@@ -1565,7 +1673,12 @@ CONFIG_BOOTX_TEXT=y
 # Cryptographic options
 #
 CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_HMAC=y
+# CONFIG_CRYPTO_XCBC is not set
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MD5=y
@@ -1574,9 +1687,14 @@ CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_WP512=m
 # CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_ECB is not set
+CONFIG_CRYPTO_CBC=y
+# CONFIG_CRYPTO_LRW is not set
 CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_TWOFISH=m
+CONFIG_CRYPTO_TWOFISH_COMMON=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_AES=m
 CONFIG_CRYPTO_CAST5=m
Index: linux-2.6/arch/powerpc/configs/iseries_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/iseries_defconfig
+++ linux-2.6/arch/powerpc/configs/iseries_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.19-rc1
-# Fri Oct  6 13:25:04 2006
+# Linux kernel version: 2.6.19
+# Sun Dec 10 11:23:31 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -10,6 +10,8 @@ CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+CONFIG_ARCH_HAS_ILOG2_U64=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -32,6 +34,9 @@ CONFIG_AUDIT_ARCH=y
 CONFIG_POWER3=y
 CONFIG_POWER4=y
 CONFIG_PPC_FPU=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
+# CONFIG_PPC_OF_PLATFORM_PCI is not set
 # CONFIG_ALTIVEC is not set
 CONFIG_PPC_STD_MMU=y
 CONFIG_VIRT_CPU_ACCOUNTING=y
@@ -63,12 +68,13 @@ CONFIG_AUDITSYSCALL=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_CPUSETS is not set
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
-# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -125,18 +131,22 @@ CONFIG_PPC_MULTIPLATFORM=y
 # CONFIG_APUS is not set
 # CONFIG_PPC_PSERIES is not set
 CONFIG_PPC_ISERIES=y
+# CONFIG_PPC_MPC52xx is not set
 # CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_MAPLE is not set
 # CONFIG_PPC_PASEMI is not set
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_IBM_CELL_BLADE is not set
+# CONFIG_PPC_PS3 is not set
 # CONFIG_U3_DART is not set
 # CONFIG_PPC_RTAS is not set
 # CONFIG_MMIO_NVRAM is not set
 CONFIG_IBMVIO=y
 # CONFIG_PPC_MPC106 is not set
 # CONFIG_PPC_970_NAP is not set
+CONFIG_PPC_INDIRECT_IO=y
+CONFIG_GENERIC_IOMAP=y
 # CONFIG_CPU_FREQ is not set
 # CONFIG_WANT_EARLY_SERIAL is not set
 # CONFIG_MPIC is not set
@@ -146,6 +156,7 @@ CONFIG_IBMVIO=y
 #
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
@@ -178,6 +189,7 @@ CONFIG_RESOURCES_64BIT=y
 # CONFIG_PPC_64K_PAGES is not set
 # CONFIG_SCHED_SMT is not set
 CONFIG_PROC_DEVICETREE=y
+# CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
 CONFIG_SECCOMP=y
 CONFIG_ISA_DMA_API=y
@@ -245,6 +257,7 @@ CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 
 #
 # IP: Virtual Server Configuration
@@ -261,12 +274,29 @@ CONFIG_NETFILTER=y
 # Core Netfilter Configuration
 #
 # CONFIG_NETFILTER_NETLINK is not set
+CONFIG_NF_CONNTRACK_ENABLED=y
+CONFIG_NF_CONNTRACK_SUPPORT=y
+# CONFIG_IP_NF_CONNTRACK_SUPPORT is not set
+CONFIG_NF_CONNTRACK=y
+CONFIG_NF_CT_ACCT=y
+CONFIG_NF_CONNTRACK_MARK=y
+CONFIG_NF_CONNTRACK_EVENTS=y
+CONFIG_NF_CT_PROTO_SCTP=m
+CONFIG_NF_CONNTRACK_AMANDA=m
+CONFIG_NF_CONNTRACK_FTP=m
+# CONFIG_NF_CONNTRACK_H323 is not set
+CONFIG_NF_CONNTRACK_IRC=m
+# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
+# CONFIG_NF_CONNTRACK_PPTP is not set
+# CONFIG_NF_CONNTRACK_SIP is not set
+# CONFIG_NF_CONNTRACK_TFTP is not set
 CONFIG_NETFILTER_XTABLES=m
 CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
 CONFIG_NETFILTER_XT_TARGET_DSCP=m
 CONFIG_NETFILTER_XT_TARGET_MARK=m
 CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
+# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
 CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
 CONFIG_NETFILTER_XT_MATCH_COMMENT=m
 CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
@@ -290,23 +320,13 @@ CONFIG_NETFILTER_XT_MATCH_STATE=m
 # CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
 CONFIG_NETFILTER_XT_MATCH_STRING=m
 CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
+# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
 
 #
 # IP: Netfilter Configuration
 #
-CONFIG_IP_NF_CONNTRACK=m
-CONFIG_IP_NF_CT_ACCT=y
-CONFIG_IP_NF_CONNTRACK_MARK=y
-CONFIG_IP_NF_CONNTRACK_EVENTS=y
-CONFIG_IP_NF_CT_PROTO_SCTP=m
-CONFIG_IP_NF_FTP=m
-CONFIG_IP_NF_IRC=m
-# CONFIG_IP_NF_NETBIOS_NS is not set
-CONFIG_IP_NF_TFTP=m
-CONFIG_IP_NF_AMANDA=m
-# CONFIG_IP_NF_PPTP is not set
-# CONFIG_IP_NF_H323 is not set
-# CONFIG_IP_NF_SIP is not set
+CONFIG_NF_CONNTRACK_IPV4=m
+CONFIG_NF_CONNTRACK_PROC_COMPAT=y
 CONFIG_IP_NF_QUEUE=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_IPRANGE=m
@@ -317,28 +337,30 @@ CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_MATCH_OWNER=m
 CONFIG_IP_NF_MATCH_ADDRTYPE=m
-CONFIG_IP_NF_MATCH_HASHLIMIT=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_TARGET_LOG=m
 CONFIG_IP_NF_TARGET_ULOG=m
 CONFIG_IP_NF_TARGET_TCPMSS=m
-CONFIG_IP_NF_NAT=m
-CONFIG_IP_NF_NAT_NEEDED=y
+CONFIG_NF_NAT=m
+CONFIG_NF_NAT_NEEDED=y
 CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_TARGET_NETMAP=m
 CONFIG_IP_NF_TARGET_SAME=m
-CONFIG_IP_NF_NAT_SNMP_BASIC=m
-CONFIG_IP_NF_NAT_IRC=m
-CONFIG_IP_NF_NAT_FTP=m
-CONFIG_IP_NF_NAT_TFTP=m
-CONFIG_IP_NF_NAT_AMANDA=m
+CONFIG_NF_NAT_SNMP_BASIC=m
+CONFIG_NF_NAT_FTP=m
+CONFIG_NF_NAT_IRC=m
+# CONFIG_NF_NAT_TFTP is not set
+CONFIG_NF_NAT_AMANDA=m
+# CONFIG_NF_NAT_PPTP is not set
+# CONFIG_NF_NAT_H323 is not set
+# CONFIG_NF_NAT_SIP is not set
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_TOS=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
+# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
 CONFIG_IP_NF_RAW=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
@@ -440,6 +462,12 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
+# Misc devices
+#
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+
+#
 # ATA/ATAPI/MFM/RLL support
 #
 # CONFIG_IDE is not set
@@ -449,6 +477,7 @@ CONFIG_BLK_DEV_INITRD=y
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+# CONFIG_SCSI_TGT is not set
 CONFIG_SCSI_NETLINK=y
 CONFIG_SCSI_PROC_FS=y
 
@@ -469,6 +498,7 @@ CONFIG_CHR_DEV_SG=y
 CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 # CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
 
 #
 # SCSI Transports
@@ -515,6 +545,7 @@ CONFIG_SCSI_IBMVSCSI=m
 # CONFIG_SCSI_DC395x is not set
 # CONFIG_SCSI_DC390T is not set
 # CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_SRP is not set
 
 #
 # Serial ATA (prod) and Parallel ATA (experimental) drivers
@@ -562,6 +593,7 @@ CONFIG_DM_ZERO=m
 #
 # Macintosh device drivers
 #
+# CONFIG_MAC_EMUMOUSEBTN is not set
 # CONFIG_WINDFARM is not set
 
 #
@@ -647,6 +679,7 @@ CONFIG_E1000=m
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
 
 #
 # Token Ring devices
@@ -765,10 +798,6 @@ CONFIG_GEN_RTC=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 CONFIG_RAW_DRIVER=y
@@ -779,7 +808,6 @@ CONFIG_MAX_RAW_DEVS=256
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-# CONFIG_TELCLOCK is not set
 
 #
 # I2C support
@@ -795,6 +823,7 @@ CONFIG_MAX_RAW_DEVS=256
 #
 # Dallas's 1-wire bus
 #
+# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -803,11 +832,6 @@ CONFIG_MAX_RAW_DEVS=256
 # CONFIG_HWMON_VID is not set
 
 #
-# Misc devices
-#
-# CONFIG_TIFM_CORE is not set
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -830,6 +854,11 @@ CONFIG_FIRMWARE_EDID=y
 # CONFIG_SOUND is not set
 
 #
+# HID Devices
+#
+# CONFIG_HID is not set
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -904,6 +933,7 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
@@ -966,7 +996,7 @@ CONFIG_PROC_KCORE=y
 CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLBFS is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
@@ -1024,7 +1054,6 @@ CONFIG_CIFS_POSIX=y
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
 # CONFIG_9P_FS is not set
-CONFIG_GENERIC_ACL=y
 
 #
 # Partition Types
@@ -1080,6 +1109,8 @@ CONFIG_NLS_ISO8859_1=y
 # Distributed Lock Manager
 #
 CONFIG_DLM=m
+CONFIG_DLM_TCP=y
+# CONFIG_DLM_SCTP is not set
 # CONFIG_DLM_DEBUG is not set
 
 #
@@ -1094,6 +1125,7 @@ CONFIG_VIOPATH=y
 #
 # Library routines
 #
+CONFIG_BITREVERSE=y
 CONFIG_CRC_CCITT=m
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
@@ -1137,11 +1169,13 @@ CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_FORCED_INLINING is not set
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_DEBUG_STACK_USAGE=y
 # CONFIG_DEBUGGER is not set
 CONFIG_IRQSTACKS=y
+# CONFIG_BOOTX_TEXT is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
 
 #
@@ -1155,10 +1189,11 @@ CONFIG_IRQSTACKS=y
 #
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ALGAPI=y
-CONFIG_CRYPTO_BLKCIPHER=m
+CONFIG_CRYPTO_BLKCIPHER=y
 CONFIG_CRYPTO_HASH=y
-CONFIG_CRYPTO_MANAGER=m
+CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_HMAC=y
+# CONFIG_CRYPTO_XCBC is not set
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MD5=y
@@ -1167,8 +1202,10 @@ CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_TGR192=m
+# CONFIG_CRYPTO_GF128MUL is not set
 CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_CBC=m
+CONFIG_CRYPTO_CBC=y
+# CONFIG_CRYPTO_LRW is not set
 CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_TWOFISH=m
Index: linux-2.6/arch/powerpc/configs/linkstation_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/linkstation_defconfig
+++ linux-2.6/arch/powerpc/configs/linkstation_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.19-rc4
-# Wed Nov 15 20:36:30 2006
+# Linux kernel version: 2.6.19
+# Sun Dec 10 11:16:25 2006
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -10,6 +10,7 @@ CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -28,7 +29,6 @@ CONFIG_AUDIT_ARCH=y
 # Processor support
 #
 CONFIG_CLASSIC32=y
-# CONFIG_PPC_52xx is not set
 # CONFIG_PPC_82xx is not set
 # CONFIG_PPC_83xx is not set
 # CONFIG_PPC_85xx is not set
@@ -69,12 +69,13 @@ CONFIG_POSIX_MQUEUE=y
 # CONFIG_AUDIT is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
-# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -130,6 +131,7 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # CONFIG_PPC_MULTIPLATFORM is not set
 CONFIG_EMBEDDED6xx=y
 # CONFIG_APUS is not set
+# CONFIG_PPC_MPC52xx is not set
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_RTAS is not set
@@ -166,7 +168,6 @@ CONFIG_LINKSTATION=y
 # CONFIG_TQM8260 is not set
 # CONFIG_ADS8272 is not set
 # CONFIG_PQ2FADS is not set
-# CONFIG_LITE5200 is not set
 # CONFIG_EV64360 is not set
 CONFIG_PPC_GEN550=y
 CONFIG_MPC10X_BRIDGE=y
@@ -181,6 +182,7 @@ CONFIG_MPIC=y
 # CONFIG_HIGHMEM is not set
 CONFIG_HZ_100=y
 # CONFIG_HZ_250 is not set
+# CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=100
 CONFIG_PREEMPT_NONE=y
@@ -286,6 +288,7 @@ CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 
 #
 # IP: Virtual Server Configuration
@@ -302,11 +305,28 @@ CONFIG_NETFILTER=y
 # Core Netfilter Configuration
 #
 # CONFIG_NETFILTER_NETLINK is not set
+CONFIG_NF_CONNTRACK_ENABLED=y
+CONFIG_NF_CONNTRACK_SUPPORT=y
+# CONFIG_IP_NF_CONNTRACK_SUPPORT is not set
+CONFIG_NF_CONNTRACK=y
+# CONFIG_NF_CT_ACCT is not set
+# CONFIG_NF_CONNTRACK_MARK is not set
+# CONFIG_NF_CONNTRACK_EVENTS is not set
+# CONFIG_NF_CT_PROTO_SCTP is not set
+# CONFIG_NF_CONNTRACK_AMANDA is not set
+CONFIG_NF_CONNTRACK_FTP=m
+# CONFIG_NF_CONNTRACK_H323 is not set
+CONFIG_NF_CONNTRACK_IRC=m
+# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
+# CONFIG_NF_CONNTRACK_PPTP is not set
+# CONFIG_NF_CONNTRACK_SIP is not set
+CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NETFILTER_XTABLES=m
 CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 # CONFIG_NETFILTER_XT_TARGET_DSCP is not set
 CONFIG_NETFILTER_XT_TARGET_MARK=m
 # CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
+# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
 # CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
 # CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
 CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
@@ -328,23 +348,13 @@ CONFIG_NETFILTER_XT_MATCH_STATE=m
 # CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
 # CONFIG_NETFILTER_XT_MATCH_STRING is not set
 # CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
+# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
 
 #
 # IP: Netfilter Configuration
 #
-CONFIG_IP_NF_CONNTRACK=m
-# CONFIG_IP_NF_CT_ACCT is not set
-# CONFIG_IP_NF_CONNTRACK_MARK is not set
-# CONFIG_IP_NF_CONNTRACK_EVENTS is not set
-# CONFIG_IP_NF_CT_PROTO_SCTP is not set
-CONFIG_IP_NF_FTP=m
-CONFIG_IP_NF_IRC=m
-# CONFIG_IP_NF_NETBIOS_NS is not set
-CONFIG_IP_NF_TFTP=m
-# CONFIG_IP_NF_AMANDA is not set
-# CONFIG_IP_NF_PPTP is not set
-# CONFIG_IP_NF_H323 is not set
-# CONFIG_IP_NF_SIP is not set
+CONFIG_NF_CONNTRACK_IPV4=m
+CONFIG_NF_CONNTRACK_PROC_COMPAT=y
 # CONFIG_IP_NF_QUEUE is not set
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_IPRANGE=m
@@ -355,22 +365,25 @@ CONFIG_IP_NF_MATCH_IPRANGE=m
 # CONFIG_IP_NF_MATCH_TTL is not set
 # CONFIG_IP_NF_MATCH_OWNER is not set
 # CONFIG_IP_NF_MATCH_ADDRTYPE is not set
-# CONFIG_IP_NF_MATCH_HASHLIMIT is not set
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 # CONFIG_IP_NF_TARGET_LOG is not set
 # CONFIG_IP_NF_TARGET_ULOG is not set
 # CONFIG_IP_NF_TARGET_TCPMSS is not set
-CONFIG_IP_NF_NAT=m
-CONFIG_IP_NF_NAT_NEEDED=y
+CONFIG_NF_NAT=m
+CONFIG_NF_NAT_NEEDED=y
 CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_TARGET_NETMAP=m
 CONFIG_IP_NF_TARGET_SAME=m
-# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
-CONFIG_IP_NF_NAT_IRC=m
-CONFIG_IP_NF_NAT_FTP=m
-CONFIG_IP_NF_NAT_TFTP=m
+# CONFIG_NF_NAT_SNMP_BASIC is not set
+CONFIG_NF_NAT_FTP=m
+CONFIG_NF_NAT_IRC=m
+CONFIG_NF_NAT_TFTP=m
+# CONFIG_NF_NAT_AMANDA is not set
+# CONFIG_NF_NAT_PPTP is not set
+# CONFIG_NF_NAT_H323 is not set
+# CONFIG_NF_NAT_SIP is not set
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_TOS=m
 CONFIG_IP_NF_TARGET_ECN=m
@@ -580,6 +593,7 @@ CONFIG_BLK_DEV_INITRD=y
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+# CONFIG_SCSI_TGT is not set
 # CONFIG_SCSI_NETLINK is not set
 CONFIG_SCSI_PROC_FS=y
 
@@ -599,6 +613,7 @@ CONFIG_CHR_DEV_SG=y
 CONFIG_SCSI_MULTI_LUN=y
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
 
 #
 # SCSI Transports
@@ -646,6 +661,7 @@ CONFIG_SCSI_MULTI_LUN=y
 # CONFIG_SCSI_DC390T is not set
 # CONFIG_SCSI_NSP32 is not set
 # CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_SRP is not set
 
 #
 # Serial ATA (prod) and Parallel ATA (experimental) drivers
@@ -683,6 +699,7 @@ CONFIG_ATA=y
 # CONFIG_PATA_IT821X is not set
 # CONFIG_PATA_JMICRON is not set
 # CONFIG_PATA_TRIFLEX is not set
+# CONFIG_PATA_MARVELL is not set
 # CONFIG_PATA_MPIIX is not set
 # CONFIG_PATA_OLDPIIX is not set
 # CONFIG_PATA_NETCELL is not set
@@ -726,6 +743,7 @@ CONFIG_PATA_SIL680=y
 #
 # Macintosh device drivers
 #
+# CONFIG_MAC_EMUMOUSEBTN is not set
 # CONFIG_WINDFARM is not set
 
 #
@@ -777,6 +795,7 @@ CONFIG_R8169=y
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
 
 #
 # Token Ring devices
@@ -899,6 +918,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 #
 # Non-8250 serial port support
 #
+# CONFIG_SERIAL_UARTLITE is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
@@ -921,10 +941,6 @@ CONFIG_HW_RANDOM=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -1077,6 +1093,11 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_SOUND is not set
 
 #
+# HID Devices
+#
+# CONFIG_HID is not set
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -1091,6 +1112,7 @@ CONFIG_USB=y
 CONFIG_USB_DEVICEFS=y
 # CONFIG_USB_BANDWIDTH is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_MULTITHREAD_PROBE is not set
 # CONFIG_USB_OTG is not set
 
 #
@@ -1137,7 +1159,6 @@ CONFIG_USB_STORAGE=m
 #
 # USB Input Devices
 #
-# CONFIG_USB_HID is not set
 
 #
 # USB HID Boot Protocol drivers
@@ -1170,6 +1191,7 @@ CONFIG_USB_STORAGE=m
 # CONFIG_USB_KAWETH is not set
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET_MII is not set
 # CONFIG_USB_USBNET is not set
 CONFIG_USB_MON=y
 
@@ -1218,6 +1240,7 @@ CONFIG_USB_SERIAL_FTDI_SIO=y
 # CONFIG_USB_SERIAL_XIRCOM is not set
 # CONFIG_USB_SERIAL_OPTION is not set
 # CONFIG_USB_SERIAL_OMNINET is not set
+# CONFIG_USB_SERIAL_DEBUG is not set
 
 #
 # USB Miscellaneous drivers
@@ -1488,8 +1511,14 @@ CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_UTF8=m
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Library routines
 #
+CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
@@ -1551,6 +1580,7 @@ CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_BLKCIPHER=y
 CONFIG_CRYPTO_MANAGER=y
 # CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
 # CONFIG_CRYPTO_NULL is not set
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MD5=y
@@ -1559,8 +1589,10 @@ CONFIG_CRYPTO_SHA1=m
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_CBC=y
+# CONFIG_CRYPTO_LRW is not set
 CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_TWOFISH=m
Index: linux-2.6/arch/powerpc/configs/lite5200_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/lite5200_defconfig
+++ linux-2.6/arch/powerpc/configs/lite5200_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.19-rc6
-# Mon Nov 27 11:08:20 2006
+# Linux kernel version: 2.6.19
+# Sat Dec  9 13:48:42 2006
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -10,6 +10,7 @@ CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -28,7 +29,6 @@ CONFIG_AUDIT_ARCH=y
 # Processor support
 #
 CONFIG_CLASSIC32=y
-# CONFIG_PPC_52xx is not set
 # CONFIG_PPC_82xx is not set
 # CONFIG_PPC_83xx is not set
 # CONFIG_PPC_85xx is not set
@@ -68,6 +68,7 @@ CONFIG_SYSVIPC=y
 # CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -151,6 +152,7 @@ CONFIG_PPC_LITE5200=y
 # CONFIG_HIGHMEM is not set
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
@@ -191,6 +193,7 @@ CONFIG_GENERIC_ISA_DMA=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCIEPORTBUS is not set
+# CONFIG_PCI_MULTITHREAD_PROBE is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -259,6 +262,7 @@ CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
@@ -374,6 +378,7 @@ CONFIG_BLK_DEV_INITRD=y
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+# CONFIG_SCSI_TGT is not set
 # CONFIG_SCSI_NETLINK is not set
 # CONFIG_SCSI_PROC_FS is not set
 
@@ -393,6 +398,7 @@ CONFIG_SCSI=y
 # CONFIG_SCSI_MULTI_LUN is not set
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
 
 #
 # SCSI Transports
@@ -440,6 +446,7 @@ CONFIG_SCSI=y
 # CONFIG_SCSI_DC390T is not set
 # CONFIG_SCSI_NSP32 is not set
 # CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_SRP is not set
 
 #
 # Serial ATA (prod) and Parallel ATA (experimental) drivers
@@ -477,7 +484,7 @@ CONFIG_ATA=y
 # CONFIG_PATA_IT821X is not set
 # CONFIG_PATA_JMICRON is not set
 # CONFIG_PATA_TRIFLEX is not set
-CONFIG_PATA_MPC52xx=y
+# CONFIG_PATA_MARVELL is not set
 # CONFIG_PATA_MPIIX is not set
 # CONFIG_PATA_OLDPIIX is not set
 # CONFIG_PATA_NETCELL is not set
@@ -494,6 +501,7 @@ CONFIG_PATA_MPC52xx=y
 # CONFIG_PATA_SIS is not set
 # CONFIG_PATA_VIA is not set
 # CONFIG_PATA_WINBOND is not set
+# CONFIG_PATA_PLATFORM is not set
 
 #
 # Multi-device support (RAID and LVM)
@@ -521,6 +529,7 @@ CONFIG_PATA_MPC52xx=y
 #
 # Macintosh device drivers
 #
+# CONFIG_MAC_EMUMOUSEBTN is not set
 # CONFIG_WINDFARM is not set
 
 #
@@ -572,6 +581,7 @@ CONFIG_NETDEVICES=y
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
 
 #
 # Token Ring devices
@@ -632,6 +642,7 @@ CONFIG_NETDEVICES=y
 #
 # Non-8250 serial port support
 #
+# CONFIG_SERIAL_UARTLITE is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_SERIAL_MPC52xx=y
@@ -657,10 +668,6 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -873,6 +880,11 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_NLS is not set
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
Index: linux-2.6/arch/powerpc/configs/maple_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/maple_defconfig
+++ linux-2.6/arch/powerpc/configs/maple_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18
-# Mon Oct  9 11:59:34 2006
+# Linux kernel version: 2.6.19
+# Sun Dec 10 11:11:31 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -10,6 +10,8 @@ CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+CONFIG_ARCH_HAS_ILOG2_U64=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -31,6 +33,9 @@ CONFIG_AUDIT_ARCH=y
 CONFIG_POWER4_ONLY=y
 CONFIG_POWER4=y
 CONFIG_PPC_FPU=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
+# CONFIG_PPC_OF_PLATFORM_PCI is not set
 # CONFIG_ALTIVEC is not set
 CONFIG_PPC_STD_MMU=y
 CONFIG_VIRT_CPU_ACCOUNTING=y
@@ -61,12 +66,13 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_CPUSETS is not set
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
-# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -123,18 +129,23 @@ CONFIG_PPC_MULTIPLATFORM=y
 # CONFIG_APUS is not set
 # CONFIG_PPC_PSERIES is not set
 # CONFIG_PPC_ISERIES is not set
+# CONFIG_PPC_MPC52xx is not set
 # CONFIG_PPC_PMAC is not set
 CONFIG_PPC_MAPLE=y
 # CONFIG_PPC_PASEMI is not set
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_IBM_CELL_BLADE is not set
+# CONFIG_PPC_PS3 is not set
+CONFIG_PPC_NATIVE=y
 CONFIG_U3_DART=y
 # CONFIG_PPC_RTAS is not set
 # CONFIG_MMIO_NVRAM is not set
 CONFIG_MPIC_BROKEN_U3=y
 # CONFIG_PPC_MPC106 is not set
 CONFIG_PPC_970_NAP=y
+# CONFIG_PPC_INDIRECT_IO is not set
+# CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
 # CONFIG_WANT_EARLY_SERIAL is not set
 CONFIG_MPIC=y
@@ -144,6 +155,7 @@ CONFIG_MPIC=y
 #
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
@@ -246,6 +258,7 @@ CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
@@ -346,6 +359,12 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # CONFIG_ATA_OVER_ETH is not set
 
 #
+# Misc devices
+#
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+
+#
 # ATA/ATAPI/MFM/RLL support
 #
 CONFIG_IDE=y
@@ -371,7 +390,6 @@ CONFIG_IDEPCI_SHARE_IRQ=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 CONFIG_BLK_DEV_GENERIC=y
 # CONFIG_BLK_DEV_OPTI621 is not set
-# CONFIG_BLK_DEV_SL82C105 is not set
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
@@ -395,6 +413,7 @@ CONFIG_BLK_DEV_AMD74XX=y
 # CONFIG_BLK_DEV_PDC202XX_NEW is not set
 # CONFIG_BLK_DEV_SVWKS is not set
 # CONFIG_BLK_DEV_SIIMAGE is not set
+# CONFIG_BLK_DEV_SL82C105 is not set
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
 # CONFIG_BLK_DEV_VIA82CXXX is not set
@@ -439,6 +458,7 @@ CONFIG_IDEDMA_AUTO=y
 #
 # Macintosh device drivers
 #
+# CONFIG_MAC_EMUMOUSEBTN is not set
 # CONFIG_WINDFARM is not set
 
 #
@@ -523,6 +543,7 @@ CONFIG_TIGON3=y
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
 
 #
 # Token Ring devices
@@ -634,10 +655,6 @@ CONFIG_GEN_RTC=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -647,7 +664,6 @@ CONFIG_GEN_RTC=y
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-# CONFIG_TELCLOCK is not set
 
 #
 # I2C support
@@ -711,6 +727,7 @@ CONFIG_I2C_AMD8111=y
 #
 # Dallas's 1-wire bus
 #
+# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -719,15 +736,9 @@ CONFIG_I2C_AMD8111=y
 # CONFIG_HWMON_VID is not set
 
 #
-# Misc devices
-#
-# CONFIG_TIFM_CORE is not set
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -754,6 +765,11 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_SOUND is not set
 
 #
+# HID Devices
+#
+CONFIG_HID=y
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -768,6 +784,7 @@ CONFIG_USB=y
 CONFIG_USB_DEVICEFS=y
 # CONFIG_USB_BANDWIDTH is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_MULTITHREAD_PROBE is not set
 # CONFIG_USB_OTG is not set
 
 #
@@ -803,8 +820,7 @@ CONFIG_USB_UHCI_HCD=y
 # USB Input Devices
 #
 CONFIG_USB_HID=y
-CONFIG_USB_HIDINPUT=y
-# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_USB_HID_POWERBOOK is not set
 # CONFIG_HID_FF is not set
 # CONFIG_USB_HIDDEV is not set
 # CONFIG_USB_AIPTEK is not set
@@ -819,7 +835,6 @@ CONFIG_USB_HIDINPUT=y
 # CONFIG_USB_ATI_REMOTE2 is not set
 # CONFIG_USB_KEYSPAN_REMOTE is not set
 # CONFIG_USB_APPLETOUCH is not set
-# CONFIG_USB_TRANCEVIBRATOR is not set
 
 #
 # USB Imaging devices
@@ -833,6 +848,7 @@ CONFIG_USB_HIDINPUT=y
 # CONFIG_USB_KAWETH is not set
 CONFIG_USB_PEGASUS=y
 # CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET_MII is not set
 # CONFIG_USB_USBNET is not set
 CONFIG_USB_MON=y
 
@@ -881,6 +897,7 @@ CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
 # CONFIG_USB_SERIAL_KLSI is not set
 # CONFIG_USB_SERIAL_KOBIL_SCT is not set
 # CONFIG_USB_SERIAL_MCT_U232 is not set
+# CONFIG_USB_SERIAL_MOS7720 is not set
 # CONFIG_USB_SERIAL_MOS7840 is not set
 # CONFIG_USB_SERIAL_NAVMAN is not set
 # CONFIG_USB_SERIAL_PL2303 is not set
@@ -892,6 +909,7 @@ CONFIG_USB_SERIAL_TI=m
 # CONFIG_USB_SERIAL_XIRCOM is not set
 # CONFIG_USB_SERIAL_OPTION is not set
 # CONFIG_USB_SERIAL_OMNINET is not set
+# CONFIG_USB_SERIAL_DEBUG is not set
 CONFIG_USB_EZUSB=y
 
 #
@@ -913,6 +931,7 @@ CONFIG_USB_EZUSB=y
 # CONFIG_USB_APPLEDISPLAY is not set
 # CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_TEST is not set
 
 #
@@ -978,12 +997,14 @@ CONFIG_EXT2_FS_XIP=y
 CONFIG_FS_XIP=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -1133,8 +1154,14 @@ CONFIG_NLS_DEFAULT="utf-8"
 CONFIG_NLS_UTF8=y
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Library routines
 #
+CONFIG_BITREVERSE=y
 CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
@@ -1174,12 +1201,14 @@ CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_FORCED_INLINING is not set
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_DEBUGGER=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
+CONFIG_XMON_DISASSEMBLY=y
 # CONFIG_IRQSTACKS is not set
 CONFIG_BOOTX_TEXT=y
 # CONFIG_PPC_EARLY_DEBUG is not set
@@ -1195,9 +1224,10 @@ CONFIG_BOOTX_TEXT=y
 #
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ALGAPI=y
-CONFIG_CRYPTO_BLKCIPHER=m
-CONFIG_CRYPTO_MANAGER=m
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_MANAGER=y
 # CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
 # CONFIG_CRYPTO_NULL is not set
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=y
@@ -1206,8 +1236,10 @@ CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
 CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_CBC=m
+CONFIG_CRYPTO_CBC=y
+# CONFIG_CRYPTO_LRW is not set
 CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
Index: linux-2.6/arch/powerpc/configs/mpc7448_hpc2_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/mpc7448_hpc2_defconfig
+++ linux-2.6/arch/powerpc/configs/mpc7448_hpc2_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc6
-# Sun Sep 10 10:26:55 2006
+# Linux kernel version: 2.6.19
+# Sat Dec  9 13:48:49 2006
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -10,6 +10,7 @@ CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -21,13 +22,13 @@ CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_PPC_OF=y
 CONFIG_PPC_UDBG_16550=y
 # CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=y
 CONFIG_DEFAULT_UIMAGE=y
 
 #
 # Processor support
 #
 CONFIG_CLASSIC32=y
-# CONFIG_PPC_52xx is not set
 # CONFIG_PPC_82xx is not set
 # CONFIG_PPC_83xx is not set
 # CONFIG_PPC_85xx is not set
@@ -38,6 +39,8 @@ CONFIG_CLASSIC32=y
 # CONFIG_E200 is not set
 CONFIG_6xx=y
 CONFIG_PPC_FPU=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
 # CONFIG_ALTIVEC is not set
 CONFIG_PPC_STD_MMU=y
 CONFIG_PPC_STD_MMU_32=y
@@ -58,16 +61,20 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-CONFIG_SYSCTL=y
+# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
 CONFIG_HOTPLUG=y
@@ -75,12 +82,12 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
-CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
 CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
@@ -93,6 +100,7 @@ CONFIG_BASE_SMALL=0
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 CONFIG_LBD=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
@@ -114,19 +122,19 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # Platform support
 #
 # CONFIG_PPC_MULTIPLATFORM is not set
-# CONFIG_PPC_ISERIES is not set
 CONFIG_EMBEDDED6xx=y
 # CONFIG_APUS is not set
+# CONFIG_PPC_MPC52xx is not set
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
-# CONFIG_UDBG_RTAS_CONSOLE is not set
 # CONFIG_PPC_RTAS is not set
 # CONFIG_MMIO_NVRAM is not set
 # CONFIG_PPC_MPC106 is not set
 # CONFIG_PPC_970_NAP is not set
+# CONFIG_PPC_INDIRECT_IO is not set
+# CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
 # CONFIG_TAU is not set
-# CONFIG_PPC_TODC is not set
 # CONFIG_KATANA is not set
 # CONFIG_WILLOW is not set
 # CONFIG_CPCI690 is not set
@@ -141,6 +149,7 @@ CONFIG_EMBEDDED6xx=y
 # CONFIG_PRPMC750 is not set
 # CONFIG_PRPMC800 is not set
 # CONFIG_SANDPOINT is not set
+# CONFIG_LINKSTATION is not set
 CONFIG_MPC7448HPC2=y
 # CONFIG_RADSTONE_PPC7D is not set
 # CONFIG_PAL4 is not set
@@ -152,7 +161,6 @@ CONFIG_MPC7448HPC2=y
 # CONFIG_TQM8260 is not set
 # CONFIG_ADS8272 is not set
 # CONFIG_PQ2FADS is not set
-# CONFIG_LITE5200 is not set
 # CONFIG_EV64360 is not set
 CONFIG_TSI108_BRIDGE=y
 # CONFIG_WANT_EARLY_SERIAL is not set
@@ -164,6 +172,7 @@ CONFIG_MPIC=y
 # CONFIG_HIGHMEM is not set
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
@@ -173,6 +182,7 @@ CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -198,6 +208,7 @@ CONFIG_MPIC_WEIRD=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCIEPORTBUS is not set
+# CONFIG_PCI_MULTITHREAD_PROBE is not set
 
 #
 # PCCARD (PCMCIA/CardBus) support
@@ -237,6 +248,7 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 CONFIG_XFRM_USER=y
+# CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -258,10 +270,13 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_TUNNEL is not set
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
+# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
@@ -291,7 +306,6 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 
@@ -362,6 +376,12 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
+# Misc devices
+#
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+
+#
 # ATA/ATAPI/MFM/RLL support
 #
 # CONFIG_IDE is not set
@@ -371,6 +391,8 @@ CONFIG_BLK_DEV_INITRD=y
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+# CONFIG_SCSI_TGT is not set
+# CONFIG_SCSI_NETLINK is not set
 CONFIG_SCSI_PROC_FS=y
 
 #
@@ -389,14 +411,16 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_MULTI_LUN is not set
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
 
 #
-# SCSI Transport Attributes
+# SCSI Transports
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
 
 #
 # SCSI low-level drivers
@@ -409,27 +433,13 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_AIC7XXX is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC94XX is not set
 # CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_ARCMSR is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-CONFIG_ATA=y
-# CONFIG_SATA_AHCI is not set
-# CONFIG_SATA_SVW is not set
-# CONFIG_SCSI_ATA_PIIX is not set
-CONFIG_SATA_MV=y
-# CONFIG_SATA_NV is not set
-# CONFIG_SCSI_PDC_ADMA is not set
 # CONFIG_SCSI_HPTIOP is not set
-# CONFIG_SATA_QSTOR is not set
-# CONFIG_SATA_PROMISE is not set
-# CONFIG_SATA_SX4 is not set
-# CONFIG_SATA_SIL is not set
-# CONFIG_SATA_SIL24 is not set
-# CONFIG_SATA_SIS is not set
-# CONFIG_SATA_ULI is not set
-# CONFIG_SATA_VIA is not set
-# CONFIG_SATA_VITESSE is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
@@ -438,15 +448,73 @@ CONFIG_SATA_MV=y
 # CONFIG_SCSI_IPS is not set
 # CONFIG_SCSI_INITIO is not set
 # CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_STEX is not set
 # CONFIG_SCSI_SYM53C8XX_2 is not set
 # CONFIG_SCSI_IPR is not set
 # CONFIG_SCSI_QLOGIC_1280 is not set
 # CONFIG_SCSI_QLA_FC is not set
+# CONFIG_SCSI_QLA_ISCSI is not set
 # CONFIG_SCSI_LPFC is not set
 # CONFIG_SCSI_DC395x is not set
 # CONFIG_SCSI_DC390T is not set
 # CONFIG_SCSI_NSP32 is not set
 # CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_SRP is not set
+
+#
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+CONFIG_ATA=y
+# CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_SVW is not set
+# CONFIG_ATA_PIIX is not set
+CONFIG_SATA_MV=y
+# CONFIG_SATA_NV is not set
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+# CONFIG_SATA_SIL is not set
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
+# CONFIG_PATA_ALI is not set
+# CONFIG_PATA_AMD is not set
+# CONFIG_PATA_ARTOP is not set
+# CONFIG_PATA_ATIIXP is not set
+# CONFIG_PATA_CMD64X is not set
+# CONFIG_PATA_CS5520 is not set
+# CONFIG_PATA_CS5530 is not set
+# CONFIG_PATA_CYPRESS is not set
+# CONFIG_PATA_EFAR is not set
+# CONFIG_ATA_GENERIC is not set
+# CONFIG_PATA_HPT366 is not set
+# CONFIG_PATA_HPT37X is not set
+# CONFIG_PATA_HPT3X2N is not set
+# CONFIG_PATA_HPT3X3 is not set
+# CONFIG_PATA_IT821X is not set
+# CONFIG_PATA_JMICRON is not set
+# CONFIG_PATA_TRIFLEX is not set
+# CONFIG_PATA_MARVELL is not set
+# CONFIG_PATA_MPIIX is not set
+# CONFIG_PATA_OLDPIIX is not set
+# CONFIG_PATA_NETCELL is not set
+# CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_OPTI is not set
+# CONFIG_PATA_OPTIDMA is not set
+# CONFIG_PATA_PDC_OLD is not set
+# CONFIG_PATA_RADISYS is not set
+# CONFIG_PATA_RZ1000 is not set
+# CONFIG_PATA_SC1200 is not set
+# CONFIG_PATA_SERVERWORKS is not set
+# CONFIG_PATA_PDC2027X is not set
+# CONFIG_PATA_SIL680 is not set
+# CONFIG_PATA_SIS is not set
+# CONFIG_PATA_VIA is not set
+# CONFIG_PATA_WINBOND is not set
+# CONFIG_PATA_PLATFORM is not set
 
 #
 # Multi-device support (RAID and LVM)
@@ -474,6 +542,7 @@ CONFIG_SATA_MV=y
 #
 # Macintosh device drivers
 #
+# CONFIG_MAC_EMUMOUSEBTN is not set
 # CONFIG_WINDFARM is not set
 
 #
@@ -505,6 +574,7 @@ CONFIG_PHYLIB=y
 # CONFIG_CICADA_PHY is not set
 # CONFIG_VITESSE_PHY is not set
 # CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
 # CONFIG_FIXED_PHY is not set
 
 #
@@ -563,6 +633,8 @@ CONFIG_8139TOO=y
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
+# CONFIG_TSI108_ETH is not set
+# CONFIG_QLA3XXX is not set
 
 #
 # Ethernet (10000 Mbit)
@@ -571,6 +643,7 @@ CONFIG_8139TOO=y
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
 
 #
 # Token Ring devices
@@ -610,6 +683,7 @@ CONFIG_8139TOO=y
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -654,6 +728,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 #
 # Non-8250 serial port support
 #
+# CONFIG_SERIAL_UARTLITE is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
@@ -677,10 +752,6 @@ CONFIG_GEN_RTC=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -689,7 +760,6 @@ CONFIG_GEN_RTC=y
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-# CONFIG_TELCLOCK is not set
 
 #
 # I2C support
@@ -705,6 +775,7 @@ CONFIG_GEN_RTC=y
 #
 # Dallas's 1-wire bus
 #
+# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -713,17 +784,13 @@ CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
 # CONFIG_SENSORS_ABITUGURU is not set
 # CONFIG_SENSORS_F71805F is not set
+# CONFIG_SENSORS_VT1211 is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
-# Misc devices
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -743,6 +810,11 @@ CONFIG_FIRMWARE_EDID=y
 # CONFIG_SOUND is not set
 
 #
+# HID Devices
+#
+# CONFIG_HID is not set
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -814,6 +886,7 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
 # CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
@@ -821,6 +894,7 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -850,8 +924,10 @@ CONFIG_DNOTIFY=y
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -921,8 +997,14 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_NLS is not set
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Library routines
 #
+CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
@@ -938,12 +1020,14 @@ CONFIG_PLIST=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_DEBUG_FS is not set
 # CONFIG_UNWIND_INFO is not set
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_BOOTX_TEXT is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
 
@@ -957,7 +1041,3 @@ CONFIG_LOG_BUF_SHIFT=14
 # Cryptographic options
 #
 # CONFIG_CRYPTO is not set
-
-#
-# Hardware crypto devices
-#
Index: linux-2.6/arch/powerpc/configs/mpc834x_itx_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/mpc834x_itx_defconfig
+++ linux-2.6/arch/powerpc/configs/mpc834x_itx_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18
-# Mon Sep 25 19:41:14 2006
+# Linux kernel version: 2.6.19
+# Sat Dec  9 13:48:52 2006
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -10,6 +10,7 @@ CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -28,7 +29,6 @@ CONFIG_DEFAULT_UIMAGE=y
 # Processor support
 #
 # CONFIG_CLASSIC32 is not set
-# CONFIG_PPC_52xx is not set
 # CONFIG_PPC_82xx is not set
 CONFIG_PPC_83xx=y
 # CONFIG_PPC_85xx is not set
@@ -40,6 +40,8 @@ CONFIG_PPC_83xx=y
 CONFIG_6xx=y
 CONFIG_83xx=y
 CONFIG_PPC_FPU=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
 CONFIG_PPC_STD_MMU=y
 CONFIG_PPC_STD_MMU_32=y
 # CONFIG_SMP is not set
@@ -59,16 +61,20 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
+# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
-CONFIG_EMBEDDED=y
 CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+CONFIG_SYSCTL_SYSCALL=y
 # CONFIG_KALLSYMS is not set
 CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
@@ -98,6 +104,7 @@ CONFIG_MODULE_UNLOAD=y
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
@@ -120,8 +127,10 @@ CONFIG_PPC_GEN550=y
 #
 # Platform support
 #
+# CONFIG_MPC832x_MDS is not set
 # CONFIG_MPC834x_SYS is not set
 CONFIG_MPC834x_ITX=y
+# CONFIG_MPC8360E_PB is not set
 CONFIG_MPC834x=y
 # CONFIG_MPIC is not set
 
@@ -131,6 +140,7 @@ CONFIG_MPC834x=y
 # CONFIG_HIGHMEM is not set
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
@@ -140,6 +150,7 @@ CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -166,6 +177,7 @@ CONFIG_FSL_SOC=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCIEPORTBUS is not set
+# CONFIG_PCI_MULTITHREAD_PROBE is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -206,6 +218,7 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -227,10 +240,13 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_TUNNEL is not set
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
+# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
@@ -411,9 +427,16 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
+# Misc devices
+#
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+
+#
 # ATA/ATAPI/MFM/RLL support
 #
 CONFIG_IDE=y
+CONFIG_IDE_MAX_HWIFS=4
 # CONFIG_BLK_DEV_IDE is not set
 # CONFIG_BLK_DEV_HD_ONLY is not set
 # CONFIG_BLK_DEV_HD is not set
@@ -423,6 +446,8 @@ CONFIG_IDE=y
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+# CONFIG_SCSI_TGT is not set
+# CONFIG_SCSI_NETLINK is not set
 CONFIG_SCSI_PROC_FS=y
 
 #
@@ -441,14 +466,16 @@ CONFIG_CHR_DEV_SG=y
 # CONFIG_SCSI_MULTI_LUN is not set
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
 
 #
-# SCSI Transport Attributes
+# SCSI Transports
 #
 CONFIG_SCSI_SPI_ATTRS=y
 # CONFIG_SCSI_FC_ATTRS is not set
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
 
 #
 # SCSI low-level drivers
@@ -461,27 +488,13 @@ CONFIG_SCSI_SPI_ATTRS=y
 # CONFIG_SCSI_AIC7XXX is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC94XX is not set
 # CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_ARCMSR is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-CONFIG_ATA=y
-# CONFIG_SATA_AHCI is not set
-# CONFIG_SATA_SVW is not set
-# CONFIG_SCSI_ATA_PIIX is not set
-# CONFIG_SATA_MV is not set
-# CONFIG_SATA_NV is not set
-# CONFIG_SCSI_PDC_ADMA is not set
 # CONFIG_SCSI_HPTIOP is not set
-# CONFIG_SATA_QSTOR is not set
-# CONFIG_SATA_PROMISE is not set
-# CONFIG_SATA_SX4 is not set
-CONFIG_SATA_SIL=y
-# CONFIG_SATA_SIL24 is not set
-# CONFIG_SATA_SIS is not set
-# CONFIG_SATA_ULI is not set
-# CONFIG_SATA_VIA is not set
-# CONFIG_SATA_VITESSE is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
@@ -490,15 +503,73 @@ CONFIG_SATA_SIL=y
 # CONFIG_SCSI_IPS is not set
 # CONFIG_SCSI_INITIO is not set
 # CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_STEX is not set
 # CONFIG_SCSI_SYM53C8XX_2 is not set
 # CONFIG_SCSI_IPR is not set
 # CONFIG_SCSI_QLOGIC_1280 is not set
 # CONFIG_SCSI_QLA_FC is not set
+# CONFIG_SCSI_QLA_ISCSI is not set
 # CONFIG_SCSI_LPFC is not set
 # CONFIG_SCSI_DC395x is not set
 # CONFIG_SCSI_DC390T is not set
 # CONFIG_SCSI_NSP32 is not set
 # CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_SRP is not set
+
+#
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+CONFIG_ATA=y
+# CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_SVW is not set
+# CONFIG_ATA_PIIX is not set
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+CONFIG_SATA_SIL=y
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
+# CONFIG_PATA_ALI is not set
+# CONFIG_PATA_AMD is not set
+# CONFIG_PATA_ARTOP is not set
+# CONFIG_PATA_ATIIXP is not set
+# CONFIG_PATA_CMD64X is not set
+# CONFIG_PATA_CS5520 is not set
+# CONFIG_PATA_CS5530 is not set
+# CONFIG_PATA_CYPRESS is not set
+# CONFIG_PATA_EFAR is not set
+# CONFIG_ATA_GENERIC is not set
+# CONFIG_PATA_HPT366 is not set
+# CONFIG_PATA_HPT37X is not set
+# CONFIG_PATA_HPT3X2N is not set
+# CONFIG_PATA_HPT3X3 is not set
+# CONFIG_PATA_IT821X is not set
+# CONFIG_PATA_JMICRON is not set
+# CONFIG_PATA_TRIFLEX is not set
+# CONFIG_PATA_MARVELL is not set
+# CONFIG_PATA_MPIIX is not set
+# CONFIG_PATA_OLDPIIX is not set
+# CONFIG_PATA_NETCELL is not set
+# CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_OPTI is not set
+# CONFIG_PATA_OPTIDMA is not set
+# CONFIG_PATA_PDC_OLD is not set
+# CONFIG_PATA_RADISYS is not set
+# CONFIG_PATA_RZ1000 is not set
+# CONFIG_PATA_SC1200 is not set
+# CONFIG_PATA_SERVERWORKS is not set
+# CONFIG_PATA_PDC2027X is not set
+# CONFIG_PATA_SIL680 is not set
+# CONFIG_PATA_SIS is not set
+# CONFIG_PATA_VIA is not set
+# CONFIG_PATA_WINBOND is not set
+# CONFIG_PATA_PLATFORM is not set
 
 #
 # Multi-device support (RAID and LVM)
@@ -535,6 +606,7 @@ CONFIG_MD_RAID1=y
 #
 # Macintosh device drivers
 #
+# CONFIG_MAC_EMUMOUSEBTN is not set
 # CONFIG_WINDFARM is not set
 
 #
@@ -566,6 +638,7 @@ CONFIG_PHYLIB=y
 CONFIG_CICADA_PHY=y
 # CONFIG_VITESSE_PHY is not set
 # CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
 # CONFIG_FIXED_PHY is not set
 
 #
@@ -622,6 +695,7 @@ CONFIG_E100=y
 # CONFIG_BNX2 is not set
 CONFIG_GIANFAR=y
 CONFIG_GFAR_NAPI=y
+# CONFIG_QLA3XXX is not set
 
 #
 # Ethernet (10000 Mbit)
@@ -630,6 +704,7 @@ CONFIG_GFAR_NAPI=y
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
 
 #
 # Token Ring devices
@@ -669,6 +744,7 @@ CONFIG_GFAR_NAPI=y
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -713,6 +789,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 #
 # Non-8250 serial port support
 #
+# CONFIG_SERIAL_UARTLITE is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
@@ -753,10 +830,6 @@ CONFIG_HW_RANDOM=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -765,7 +838,6 @@ CONFIG_HW_RANDOM=y
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-# CONFIG_TELCLOCK is not set
 
 #
 # I2C support
@@ -842,6 +914,7 @@ CONFIG_SPI_MPC83xx=y
 #
 # Dallas's 1-wire bus
 #
+# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -881,6 +954,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_SMSC47M192 is not set
 # CONFIG_SENSORS_SMSC47B397 is not set
 # CONFIG_SENSORS_VIA686A is not set
+# CONFIG_SENSORS_VT1211 is not set
 # CONFIG_SENSORS_VT8231 is not set
 # CONFIG_SENSORS_W83781D is not set
 # CONFIG_SENSORS_W83791D is not set
@@ -891,14 +965,9 @@ CONFIG_HWMON=y
 # CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
-# Misc devices
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -919,6 +988,11 @@ CONFIG_FIRMWARE_EDID=y
 # CONFIG_SOUND is not set
 
 #
+# HID Devices
+#
+# CONFIG_HID is not set
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -933,6 +1007,7 @@ CONFIG_USB=y
 CONFIG_USB_DEVICEFS=y
 # CONFIG_USB_BANDWIDTH is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_MULTITHREAD_PROBE is not set
 # CONFIG_USB_OTG is not set
 
 #
@@ -972,12 +1047,12 @@ CONFIG_USB_STORAGE=y
 # CONFIG_USB_STORAGE_SDDR55 is not set
 # CONFIG_USB_STORAGE_JUMPSHOT is not set
 # CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_KARMA is not set
 # CONFIG_USB_LIBUSUAL is not set
 
 #
 # USB Input Devices
 #
-# CONFIG_USB_HID is not set
 
 #
 # USB HID Boot Protocol drivers
@@ -1010,6 +1085,7 @@ CONFIG_USB_STORAGE=y
 # CONFIG_USB_KAWETH is not set
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET_MII is not set
 # CONFIG_USB_USBNET is not set
 CONFIG_USB_MON=y
 
@@ -1027,6 +1103,7 @@ CONFIG_USB_MON=y
 #
 # CONFIG_USB_EMI62 is not set
 # CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
@@ -1034,12 +1111,13 @@ CONFIG_USB_MON=y
 # CONFIG_USB_LED is not set
 # CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
-# CONFIG_USB_PHIDGETKIT is not set
-# CONFIG_USB_PHIDGETSERVO is not set
+# CONFIG_USB_PHIDGET is not set
 # CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
 # CONFIG_USB_APPLEDISPLAY is not set
 # CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_TEST is not set
 
 #
@@ -1067,6 +1145,7 @@ CONFIG_USB_ETH_RNDIS=y
 # CONFIG_USB_GADGETFS is not set
 # CONFIG_USB_FILE_STORAGE is not set
 # CONFIG_USB_G_SERIAL is not set
+# CONFIG_USB_MIDI_GADGET is not set
 
 #
 # MMC/SD Card support
@@ -1102,6 +1181,7 @@ CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_HCTOSYS=y
 CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
 
 #
 # RTC interfaces
@@ -1154,6 +1234,7 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
 # CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
@@ -1161,6 +1242,7 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -1190,8 +1272,10 @@ CONFIG_DNOTIFY=y
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -1249,6 +1333,10 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_ATARI_PARTITION is not set
 # CONFIG_MAC_PARTITION is not set
 CONFIG_MSDOS_PARTITION=y
+# CONFIG_BSD_DISKLABEL is not set
+# CONFIG_MINIX_SUBPARTITION is not set
+# CONFIG_SOLARIS_X86_PARTITION is not set
+# CONFIG_UNIXWARE_DISKLABEL is not set
 # CONFIG_LDM_PARTITION is not set
 # CONFIG_SGI_PARTITION is not set
 # CONFIG_ULTRIX_PARTITION is not set
@@ -1262,8 +1350,14 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_NLS is not set
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Library routines
 #
+CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
@@ -1279,6 +1373,7 @@ CONFIG_PLIST=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
@@ -1297,7 +1392,9 @@ CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 CONFIG_FORCED_INLINING=y
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_DEBUGGER is not set
 # CONFIG_BDI_SWITCH is not set
@@ -1316,8 +1413,10 @@ CONFIG_FORCED_INLINING=y
 #
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ALGAPI=y
-# CONFIG_CRYPTO_MANAGER is not set
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_MANAGER=y
 # CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
 # CONFIG_CRYPTO_NULL is not set
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=y
@@ -1326,8 +1425,10 @@ CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
 # CONFIG_CRYPTO_ECB is not set
-# CONFIG_CRYPTO_CBC is not set
+CONFIG_CRYPTO_CBC=y
+# CONFIG_CRYPTO_LRW is not set
 CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
Index: linux-2.6/arch/powerpc/configs/mpc834x_mds_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/mpc834x_mds_defconfig
+++ linux-2.6/arch/powerpc/configs/mpc834x_mds_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc6
-# Sun Sep 10 10:28:54 2006
+# Linux kernel version: 2.6.19
+# Sat Dec  9 13:48:55 2006
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -10,6 +10,7 @@ CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -21,13 +22,13 @@ CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_PPC_OF=y
 CONFIG_PPC_UDBG_16550=y
 # CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=y
 CONFIG_DEFAULT_UIMAGE=y
 
 #
 # Processor support
 #
 # CONFIG_CLASSIC32 is not set
-# CONFIG_PPC_52xx is not set
 # CONFIG_PPC_82xx is not set
 CONFIG_PPC_83xx=y
 # CONFIG_PPC_85xx is not set
@@ -39,6 +40,8 @@ CONFIG_PPC_83xx=y
 CONFIG_6xx=y
 CONFIG_83xx=y
 CONFIG_PPC_FPU=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
 CONFIG_PPC_STD_MMU=y
 CONFIG_PPC_STD_MMU_32=y
 # CONFIG_SMP is not set
@@ -58,28 +61,32 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-CONFIG_SYSCTL=y
+# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
+CONFIG_SYSCTL_SYSCALL=y
 # CONFIG_KALLSYMS is not set
 CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
-CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 # CONFIG_EPOLL is not set
 CONFIG_SHMEM=y
 CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
@@ -97,6 +104,7 @@ CONFIG_MODULE_UNLOAD=y
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
@@ -119,8 +127,10 @@ CONFIG_PPC_GEN550=y
 #
 # Platform support
 #
+# CONFIG_MPC832x_MDS is not set
 CONFIG_MPC834x_SYS=y
 # CONFIG_MPC834x_ITX is not set
+# CONFIG_MPC8360E_PB is not set
 CONFIG_MPC834x=y
 # CONFIG_MPIC is not set
 
@@ -130,6 +140,7 @@ CONFIG_MPC834x=y
 # CONFIG_HIGHMEM is not set
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
@@ -139,6 +150,7 @@ CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -165,6 +177,7 @@ CONFIG_FSL_SOC=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCIEPORTBUS is not set
+# CONFIG_PCI_MULTITHREAD_PROBE is not set
 
 #
 # PCCARD (PCMCIA/CardBus) support
@@ -204,6 +217,7 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 CONFIG_XFRM_USER=m
+# CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -225,10 +239,13 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_TUNNEL is not set
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
+# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
@@ -258,7 +275,6 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 
@@ -329,6 +345,12 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
+# Misc devices
+#
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+
+#
 # ATA/ATAPI/MFM/RLL support
 #
 # CONFIG_IDE is not set
@@ -338,6 +360,12 @@ CONFIG_BLK_DEV_INITRD=y
 #
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
+# CONFIG_SCSI_NETLINK is not set
+
+#
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+# CONFIG_ATA is not set
 
 #
 # Multi-device support (RAID and LVM)
@@ -362,6 +390,7 @@ CONFIG_BLK_DEV_INITRD=y
 #
 # Macintosh device drivers
 #
+# CONFIG_MAC_EMUMOUSEBTN is not set
 # CONFIG_WINDFARM is not set
 
 #
@@ -393,6 +422,7 @@ CONFIG_MARVELL_PHY=y
 # CONFIG_CICADA_PHY is not set
 # CONFIG_VITESSE_PHY is not set
 # CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
 # CONFIG_FIXED_PHY is not set
 
 #
@@ -449,6 +479,7 @@ CONFIG_E100=y
 # CONFIG_BNX2 is not set
 CONFIG_GIANFAR=y
 # CONFIG_GFAR_NAPI is not set
+# CONFIG_QLA3XXX is not set
 
 #
 # Ethernet (10000 Mbit)
@@ -457,6 +488,7 @@ CONFIG_GIANFAR=y
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
 
 #
 # Token Ring devices
@@ -495,6 +527,7 @@ CONFIG_GIANFAR=y
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -539,6 +572,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 #
 # Non-8250 serial port support
 #
+# CONFIG_SERIAL_UARTLITE is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
@@ -575,10 +609,6 @@ CONFIG_GEN_RTC=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -587,7 +617,6 @@ CONFIG_GEN_RTC=y
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-# CONFIG_TELCLOCK is not set
 
 #
 # I2C support
@@ -653,6 +682,7 @@ CONFIG_I2C_MPC=y
 #
 # Dallas's 1-wire bus
 #
+# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -691,6 +721,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_SMSC47M192 is not set
 # CONFIG_SENSORS_SMSC47B397 is not set
 # CONFIG_SENSORS_VIA686A is not set
+# CONFIG_SENSORS_VT1211 is not set
 # CONFIG_SENSORS_VT8231 is not set
 # CONFIG_SENSORS_W83781D is not set
 # CONFIG_SENSORS_W83791D is not set
@@ -701,14 +732,9 @@ CONFIG_HWMON=y
 # CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
-# Misc devices
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -728,6 +754,11 @@ CONFIG_FIRMWARE_EDID=y
 # CONFIG_SOUND is not set
 
 #
+# HID Devices
+#
+# CONFIG_HID is not set
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -799,6 +830,7 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
 # CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
@@ -806,6 +838,7 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -835,8 +868,10 @@ CONFIG_DNOTIFY=y
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -905,8 +940,14 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_NLS is not set
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Library routines
 #
+CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
@@ -922,11 +963,13 @@ CONFIG_PLIST=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_BOOTX_TEXT is not set
 # CONFIG_SERIAL_TEXT_DEBUG is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
@@ -941,7 +984,11 @@ CONFIG_LOG_BUF_SHIFT=14
 # Cryptographic options
 #
 CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_MANAGER=y
 # CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
 # CONFIG_CRYPTO_NULL is not set
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=y
@@ -950,6 +997,10 @@ CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_ECB is not set
+CONFIG_CRYPTO_CBC=y
+# CONFIG_CRYPTO_LRW is not set
 CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
Index: linux-2.6/arch/powerpc/configs/mpc8360emds_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/mpc8360emds_defconfig
+++ linux-2.6/arch/powerpc/configs/mpc8360emds_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18
-# Thu Sep 21 18:14:27 2006
+# Linux kernel version: 2.6.19
+# Sat Dec  9 13:48:58 2006
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -10,6 +10,7 @@ CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -28,7 +29,6 @@ CONFIG_DEFAULT_UIMAGE=y
 # Processor support
 #
 # CONFIG_CLASSIC32 is not set
-# CONFIG_PPC_52xx is not set
 # CONFIG_PPC_82xx is not set
 CONFIG_PPC_83xx=y
 # CONFIG_PPC_85xx is not set
@@ -40,6 +40,8 @@ CONFIG_PPC_83xx=y
 CONFIG_6xx=y
 CONFIG_83xx=y
 CONFIG_PPC_FPU=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
 CONFIG_PPC_STD_MMU=y
 CONFIG_PPC_STD_MMU_32=y
 # CONFIG_SMP is not set
@@ -59,16 +61,20 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
+# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
-CONFIG_EMBEDDED=y
 CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+CONFIG_SYSCTL_SYSCALL=y
 # CONFIG_KALLSYMS is not set
 CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
@@ -98,6 +104,7 @@ CONFIG_MODULE_UNLOAD=y
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
@@ -121,6 +128,7 @@ CONFIG_PPC_GEN550=y
 #
 # Platform support
 #
+# CONFIG_MPC832x_MDS is not set
 # CONFIG_MPC834x_SYS is not set
 # CONFIG_MPC834x_ITX is not set
 CONFIG_MPC8360E_PB=y
@@ -133,6 +141,7 @@ CONFIG_PPC_MPC836x=y
 # CONFIG_HIGHMEM is not set
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
@@ -142,6 +151,7 @@ CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -168,6 +178,7 @@ CONFIG_FSL_SOC=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCIEPORTBUS is not set
+# CONFIG_PCI_MULTITHREAD_PROBE is not set
 
 #
 # PCCARD (PCMCIA/CardBus) support
@@ -207,6 +218,7 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -228,10 +240,13 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_TUNNEL is not set
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
+# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
@@ -331,6 +346,12 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
+# Misc devices
+#
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+
+#
 # ATA/ATAPI/MFM/RLL support
 #
 # CONFIG_IDE is not set
@@ -340,6 +361,8 @@ CONFIG_BLK_DEV_INITRD=y
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+# CONFIG_SCSI_TGT is not set
+# CONFIG_SCSI_NETLINK is not set
 CONFIG_SCSI_PROC_FS=y
 
 #
@@ -358,14 +381,16 @@ CONFIG_SCSI_PROC_FS=y
 # CONFIG_SCSI_MULTI_LUN is not set
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
 
 #
-# SCSI Transport Attributes
+# SCSI Transports
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
 
 #
 # SCSI low-level drivers
@@ -378,11 +403,12 @@ CONFIG_SCSI_PROC_FS=y
 # CONFIG_SCSI_AIC7XXX is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC94XX is not set
 # CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_ARCMSR is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
@@ -392,15 +418,22 @@ CONFIG_SCSI_PROC_FS=y
 # CONFIG_SCSI_IPS is not set
 # CONFIG_SCSI_INITIO is not set
 # CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_STEX is not set
 # CONFIG_SCSI_SYM53C8XX_2 is not set
-# CONFIG_SCSI_IPR is not set
 # CONFIG_SCSI_QLOGIC_1280 is not set
 # CONFIG_SCSI_QLA_FC is not set
+# CONFIG_SCSI_QLA_ISCSI is not set
 # CONFIG_SCSI_LPFC is not set
 # CONFIG_SCSI_DC395x is not set
 # CONFIG_SCSI_DC390T is not set
 # CONFIG_SCSI_NSP32 is not set
 # CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_SRP is not set
+
+#
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+# CONFIG_ATA is not set
 
 #
 # Multi-device support (RAID and LVM)
@@ -428,6 +461,7 @@ CONFIG_SCSI_PROC_FS=y
 #
 # Macintosh device drivers
 #
+# CONFIG_MAC_EMUMOUSEBTN is not set
 # CONFIG_WINDFARM is not set
 
 #
@@ -488,6 +522,7 @@ CONFIG_UCC_GETH=y
 # CONFIG_UGETH_MAGIC_PACKET is not set
 # CONFIG_UGETH_FILTERING is not set
 # CONFIG_UGETH_TX_ON_DEMOND is not set
+# CONFIG_QLA3XXX is not set
 
 #
 # Ethernet (10000 Mbit)
@@ -496,6 +531,7 @@ CONFIG_UCC_GETH=y
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
 
 #
 # Token Ring devices
@@ -535,6 +571,7 @@ CONFIG_UCC_GETH=y
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -579,6 +616,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 #
 # Non-8250 serial port support
 #
+# CONFIG_SERIAL_UARTLITE is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
@@ -615,10 +653,6 @@ CONFIG_GEN_RTC=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -627,7 +661,6 @@ CONFIG_GEN_RTC=y
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-# CONFIG_TELCLOCK is not set
 
 #
 # I2C support
@@ -693,6 +726,7 @@ CONFIG_I2C_MPC=y
 #
 # Dallas's 1-wire bus
 #
+# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -731,6 +765,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_SMSC47M192 is not set
 # CONFIG_SENSORS_SMSC47B397 is not set
 # CONFIG_SENSORS_VIA686A is not set
+# CONFIG_SENSORS_VT1211 is not set
 # CONFIG_SENSORS_VT8231 is not set
 # CONFIG_SENSORS_W83781D is not set
 # CONFIG_SENSORS_W83791D is not set
@@ -741,14 +776,9 @@ CONFIG_HWMON=y
 # CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
-# Misc devices
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -768,6 +798,11 @@ CONFIG_FIRMWARE_EDID=y
 # CONFIG_SOUND is not set
 
 #
+# HID Devices
+#
+# CONFIG_HID is not set
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -839,6 +874,7 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
 # CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
@@ -846,6 +882,7 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -875,8 +912,10 @@ CONFIG_DNOTIFY=y
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -945,15 +984,21 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_NLS is not set
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # QE Options
 #
-# CONFIG_UCC_SLOW is not set
+CONFIG_UCC_SLOW=y
 CONFIG_UCC_FAST=y
 CONFIG_UCC=y
 
 #
 # Library routines
 #
+CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
@@ -969,11 +1014,13 @@ CONFIG_PLIST=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_BOOTX_TEXT is not set
 # CONFIG_SERIAL_TEXT_DEBUG is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
@@ -988,7 +1035,11 @@ CONFIG_LOG_BUF_SHIFT=14
 # Cryptographic options
 #
 CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_MANAGER=y
 # CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
 # CONFIG_CRYPTO_NULL is not set
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=y
@@ -997,6 +1048,10 @@ CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_ECB is not set
+CONFIG_CRYPTO_CBC=y
+# CONFIG_CRYPTO_LRW is not set
 CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
Index: linux-2.6/arch/powerpc/configs/mpc8540_ads_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/mpc8540_ads_defconfig
+++ linux-2.6/arch/powerpc/configs/mpc8540_ads_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc6
-# Sun Sep 10 10:29:23 2006
+# Linux kernel version: 2.6.19
+# Sat Dec  9 13:49:02 2006
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -10,6 +10,7 @@ CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -21,13 +22,13 @@ CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_PPC_OF=y
 CONFIG_PPC_UDBG_16550=y
 # CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=y
 CONFIG_DEFAULT_UIMAGE=y
 
 #
 # Processor support
 #
 # CONFIG_CLASSIC32 is not set
-# CONFIG_PPC_52xx is not set
 # CONFIG_PPC_82xx is not set
 # CONFIG_PPC_83xx is not set
 CONFIG_PPC_85xx=y
@@ -38,6 +39,8 @@ CONFIG_PPC_85xx=y
 # CONFIG_E200 is not set
 CONFIG_85xx=y
 CONFIG_E500=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
 CONFIG_BOOKE=y
 CONFIG_FSL_BOOKE=y
 # CONFIG_PHYS_64BIT is not set
@@ -58,16 +61,20 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-CONFIG_SYSCTL=y
+# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -76,12 +83,12 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
-CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
 CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
@@ -94,6 +101,7 @@ CONFIG_BASE_SMALL=0
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
@@ -116,6 +124,7 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # Platform support
 #
 CONFIG_MPC8540_ADS=y
+# CONFIG_MPC8560_ADS is not set
 # CONFIG_MPC85xx_CDS is not set
 CONFIG_MPC8540=y
 CONFIG_PPC_INDIRECT_PCI_BE=y
@@ -127,6 +136,7 @@ CONFIG_MPIC=y
 # CONFIG_HIGHMEM is not set
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
@@ -137,6 +147,7 @@ CONFIG_BINFMT_MISC=y
 CONFIG_MATH_EMULATION=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -199,6 +210,7 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 CONFIG_XFRM_USER=y
+# CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -220,10 +232,13 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_TUNNEL is not set
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
+# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
@@ -253,7 +268,6 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 
@@ -320,6 +334,11 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
+# Misc devices
+#
+# CONFIG_TIFM_CORE is not set
+
+#
 # ATA/ATAPI/MFM/RLL support
 #
 # CONFIG_IDE is not set
@@ -329,6 +348,12 @@ CONFIG_BLK_DEV_INITRD=y
 #
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
+# CONFIG_SCSI_NETLINK is not set
+
+#
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+# CONFIG_ATA is not set
 
 #
 # Multi-device support (RAID and LVM)
@@ -351,6 +376,7 @@ CONFIG_BLK_DEV_INITRD=y
 #
 # Macintosh device drivers
 #
+# CONFIG_MAC_EMUMOUSEBTN is not set
 # CONFIG_WINDFARM is not set
 
 #
@@ -377,6 +403,7 @@ CONFIG_PHYLIB=y
 # CONFIG_CICADA_PHY is not set
 # CONFIG_VITESSE_PHY is not set
 # CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
 # CONFIG_FIXED_PHY is not set
 
 #
@@ -429,6 +456,7 @@ CONFIG_GFAR_NAPI=y
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -472,6 +500,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 #
 # Non-8250 serial port support
 #
+# CONFIG_SERIAL_UARTLITE is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
@@ -493,17 +522,12 @@ CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_RAW_DRIVER is not set
 
 #
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-# CONFIG_TELCLOCK is not set
 
 #
 # I2C support
@@ -519,6 +543,7 @@ CONFIG_GEN_RTC=y
 #
 # Dallas's 1-wire bus
 #
+# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -527,17 +552,13 @@ CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
 # CONFIG_SENSORS_ABITUGURU is not set
 # CONFIG_SENSORS_F71805F is not set
+# CONFIG_SENSORS_VT1211 is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
-# Misc devices
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -557,6 +578,11 @@ CONFIG_FIRMWARE_EDID=y
 # CONFIG_SOUND is not set
 
 #
+# HID Devices
+#
+# CONFIG_HID is not set
+
+#
 # USB support
 #
 # CONFIG_USB_ARCH_HAS_HCD is not set
@@ -626,6 +652,7 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
 # CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
@@ -633,6 +660,7 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -662,8 +690,10 @@ CONFIG_DNOTIFY=y
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -729,8 +759,14 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_NLS is not set
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Library routines
 #
+CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
@@ -746,6 +782,7 @@ CONFIG_PLIST=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
@@ -764,8 +801,10 @@ CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 # CONFIG_UNWIND_INFO is not set
 CONFIG_FORCED_INLINING=y
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_DEBUGGER is not set
 # CONFIG_BDI_SWITCH is not set
@@ -782,7 +821,3 @@ CONFIG_FORCED_INLINING=y
 # Cryptographic options
 #
 # CONFIG_CRYPTO is not set
-
-#
-# Hardware crypto devices
-#
Index: linux-2.6/arch/powerpc/configs/mpc8560_ads_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/mpc8560_ads_defconfig
+++ linux-2.6/arch/powerpc/configs/mpc8560_ads_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc4
-# Fri Aug 11 16:45:05 2006
+# Linux kernel version: 2.6.19
+# Sat Dec  9 13:49:05 2006
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -10,6 +10,7 @@ CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -21,13 +22,13 @@ CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_PPC_OF=y
 # CONFIG_PPC_UDBG_16550 is not set
 # CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=y
 CONFIG_DEFAULT_UIMAGE=y
 
 #
 # Processor support
 #
 # CONFIG_CLASSIC32 is not set
-# CONFIG_PPC_52xx is not set
 # CONFIG_PPC_82xx is not set
 # CONFIG_PPC_83xx is not set
 CONFIG_PPC_85xx=y
@@ -38,6 +39,8 @@ CONFIG_PPC_85xx=y
 # CONFIG_E200 is not set
 CONFIG_85xx=y
 CONFIG_E500=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
 CONFIG_BOOKE=y
 CONFIG_FSL_BOOKE=y
 # CONFIG_PHYS_64BIT is not set
@@ -58,16 +61,20 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-CONFIG_SYSCTL=y
+# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -76,12 +83,12 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
-CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
 CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
@@ -94,6 +101,7 @@ CONFIG_BASE_SMALL=0
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
@@ -110,7 +118,6 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
-CONFIG_MPIC=y
 CONFIG_CPM2=y
 # CONFIG_WANT_EARLY_SERIAL is not set
 
@@ -122,6 +129,7 @@ CONFIG_MPC8560_ADS=y
 # CONFIG_MPC85xx_CDS is not set
 CONFIG_MPC8560=y
 CONFIG_PPC_INDIRECT_PCI_BE=y
+CONFIG_MPIC=y
 
 #
 # Kernel options
@@ -129,6 +137,7 @@ CONFIG_PPC_INDIRECT_PCI_BE=y
 # CONFIG_HIGHMEM is not set
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
@@ -140,6 +149,7 @@ CONFIG_BINFMT_MISC=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 # CONFIG_PC_KEYBOARD is not set
 CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -152,19 +162,20 @@ CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_PROC_DEVICETREE is not set
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
-# CONFIG_SOFTWARE_SUSPEND is not set
 # CONFIG_SECCOMP is not set
 CONFIG_ISA_DMA_API=y
 
 #
 # Bus options
 #
+# CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
 CONFIG_PPC_INDIRECT_PCI=y
 CONFIG_FSL_SOC=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCIEPORTBUS is not set
+# CONFIG_PCI_MULTITHREAD_PROBE is not set
 CONFIG_PCI_DEBUG=y
 
 #
@@ -205,6 +216,7 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -226,10 +238,13 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_TUNNEL is not set
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
+# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
@@ -259,7 +274,6 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 
@@ -331,6 +345,12 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
+# Misc devices
+#
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+
+#
 # ATA/ATAPI/MFM/RLL support
 #
 # CONFIG_IDE is not set
@@ -340,6 +360,12 @@ CONFIG_BLK_DEV_INITRD=y
 #
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
+# CONFIG_SCSI_NETLINK is not set
+
+#
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+# CONFIG_ATA is not set
 
 #
 # Multi-device support (RAID and LVM)
@@ -364,6 +390,7 @@ CONFIG_BLK_DEV_INITRD=y
 #
 # Macintosh device drivers
 #
+# CONFIG_MAC_EMUMOUSEBTN is not set
 # CONFIG_WINDFARM is not set
 
 #
@@ -395,6 +422,7 @@ CONFIG_DAVICOM_PHY=y
 # CONFIG_CICADA_PHY is not set
 # CONFIG_VITESSE_PHY is not set
 # CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
 # CONFIG_FIXED_PHY is not set
 
 #
@@ -437,6 +465,7 @@ CONFIG_E1000_NAPI=y
 # CONFIG_BNX2 is not set
 CONFIG_GIANFAR=y
 CONFIG_GFAR_NAPI=y
+# CONFIG_QLA3XXX is not set
 
 #
 # Ethernet (10000 Mbit)
@@ -445,6 +474,7 @@ CONFIG_GFAR_NAPI=y
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
 
 #
 # Token Ring devices
@@ -483,6 +513,7 @@ CONFIG_GFAR_NAPI=y
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -522,6 +553,7 @@ CONFIG_INPUT=y
 #
 # Non-8250 serial port support
 #
+# CONFIG_SERIAL_UARTLITE is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_SERIAL_CPM=y
@@ -536,7 +568,6 @@ CONFIG_SERIAL_CPM_SCC2=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
-# CONFIG_BRIQ_PANEL is not set
 
 #
 # IPMI
@@ -554,10 +585,6 @@ CONFIG_GEN_RTC=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -566,7 +593,6 @@ CONFIG_GEN_RTC=y
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-# CONFIG_TELCLOCK is not set
 
 #
 # I2C support
@@ -582,6 +608,7 @@ CONFIG_GEN_RTC=y
 #
 # Dallas's 1-wire bus
 #
+# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -590,17 +617,13 @@ CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
 # CONFIG_SENSORS_ABITUGURU is not set
 # CONFIG_SENSORS_F71805F is not set
+# CONFIG_SENSORS_VT1211 is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
-# Misc devices
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -620,6 +643,11 @@ CONFIG_FIRMWARE_EDID=y
 # CONFIG_SOUND is not set
 
 #
+# HID Devices
+#
+# CONFIG_HID is not set
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -691,6 +719,7 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
 # CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
@@ -698,6 +727,7 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -727,8 +757,10 @@ CONFIG_DNOTIFY=y
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -794,8 +826,14 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_NLS is not set
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Library routines
 #
+CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
@@ -811,6 +849,7 @@ CONFIG_PLIST=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
@@ -829,8 +868,10 @@ CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 # CONFIG_UNWIND_INFO is not set
 CONFIG_FORCED_INLINING=y
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_DEBUGGER is not set
 # CONFIG_KGDB_CONSOLE is not set
@@ -848,7 +889,3 @@ CONFIG_FORCED_INLINING=y
 # Cryptographic options
 #
 # CONFIG_CRYPTO is not set
-
-#
-# Hardware crypto devices
-#
Index: linux-2.6/arch/powerpc/configs/mpc85xx_cds_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/mpc85xx_cds_defconfig
+++ linux-2.6/arch/powerpc/configs/mpc85xx_cds_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc6
-# Sun Sep 10 10:29:49 2006
+# Linux kernel version: 2.6.19
+# Sat Dec  9 13:49:08 2006
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -10,6 +10,7 @@ CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -21,13 +22,13 @@ CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_PPC_OF=y
 CONFIG_PPC_UDBG_16550=y
 # CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=y
 CONFIG_DEFAULT_UIMAGE=y
 
 #
 # Processor support
 #
 # CONFIG_CLASSIC32 is not set
-# CONFIG_PPC_52xx is not set
 # CONFIG_PPC_82xx is not set
 # CONFIG_PPC_83xx is not set
 CONFIG_PPC_85xx=y
@@ -38,6 +39,8 @@ CONFIG_PPC_85xx=y
 # CONFIG_E200 is not set
 CONFIG_85xx=y
 CONFIG_E500=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
 CONFIG_BOOKE=y
 CONFIG_FSL_BOOKE=y
 # CONFIG_PHYS_64BIT is not set
@@ -58,16 +61,20 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-CONFIG_SYSCTL=y
+# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -76,12 +83,12 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
-CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
 CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
@@ -94,6 +101,7 @@ CONFIG_BASE_SMALL=0
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
@@ -116,6 +124,7 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # Platform support
 #
 # CONFIG_MPC8540_ADS is not set
+# CONFIG_MPC8560_ADS is not set
 CONFIG_MPC85xx_CDS=y
 CONFIG_MPC8540=y
 CONFIG_PPC_INDIRECT_PCI_BE=y
@@ -127,6 +136,7 @@ CONFIG_MPIC=y
 # CONFIG_HIGHMEM is not set
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
@@ -137,6 +147,7 @@ CONFIG_BINFMT_MISC=y
 CONFIG_MATH_EMULATION=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -162,6 +173,7 @@ CONFIG_FSL_SOC=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCIEPORTBUS is not set
+# CONFIG_PCI_MULTITHREAD_PROBE is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -202,6 +214,7 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 CONFIG_XFRM_USER=y
+# CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -223,10 +236,13 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_TUNNEL is not set
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
+# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
@@ -256,7 +272,6 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 
@@ -328,9 +343,16 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
+# Misc devices
+#
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+
+#
 # ATA/ATAPI/MFM/RLL support
 #
 CONFIG_IDE=y
+CONFIG_IDE_MAX_HWIFS=4
 CONFIG_BLK_DEV_IDE=y
 
 #
@@ -353,7 +375,6 @@ CONFIG_IDEPCI_SHARE_IRQ=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 CONFIG_BLK_DEV_GENERIC=y
 # CONFIG_BLK_DEV_OPTI621 is not set
-# CONFIG_BLK_DEV_SL82C105 is not set
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 # CONFIG_IDEDMA_PCI_AUTO is not set
@@ -367,6 +388,7 @@ CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_CS5530 is not set
 # CONFIG_BLK_DEV_HPT34X is not set
 # CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_JMICRON is not set
 # CONFIG_BLK_DEV_SC1200 is not set
 # CONFIG_BLK_DEV_PIIX is not set
 # CONFIG_BLK_DEV_IT821X is not set
@@ -375,6 +397,7 @@ CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_PDC202XX_NEW is not set
 # CONFIG_BLK_DEV_SVWKS is not set
 # CONFIG_BLK_DEV_SIIMAGE is not set
+# CONFIG_BLK_DEV_SL82C105 is not set
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
 CONFIG_BLK_DEV_VIA82CXXX=y
@@ -389,6 +412,12 @@ CONFIG_BLK_DEV_IDEDMA=y
 #
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
+# CONFIG_SCSI_NETLINK is not set
+
+#
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+# CONFIG_ATA is not set
 
 #
 # Multi-device support (RAID and LVM)
@@ -413,6 +442,7 @@ CONFIG_BLK_DEV_IDEDMA=y
 #
 # Macintosh device drivers
 #
+# CONFIG_MAC_EMUMOUSEBTN is not set
 # CONFIG_WINDFARM is not set
 
 #
@@ -444,6 +474,7 @@ CONFIG_PHYLIB=y
 # CONFIG_CICADA_PHY is not set
 # CONFIG_VITESSE_PHY is not set
 # CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
 # CONFIG_FIXED_PHY is not set
 
 #
@@ -483,6 +514,7 @@ CONFIG_E1000_NAPI=y
 # CONFIG_BNX2 is not set
 CONFIG_GIANFAR=y
 CONFIG_GFAR_NAPI=y
+# CONFIG_QLA3XXX is not set
 
 #
 # Ethernet (10000 Mbit)
@@ -491,6 +523,7 @@ CONFIG_GFAR_NAPI=y
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
 
 #
 # Token Ring devices
@@ -529,6 +562,7 @@ CONFIG_GFAR_NAPI=y
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -573,6 +607,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 #
 # Non-8250 serial port support
 #
+# CONFIG_SERIAL_UARTLITE is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
@@ -596,10 +631,6 @@ CONFIG_GEN_RTC=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -608,7 +639,6 @@ CONFIG_GEN_RTC=y
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-# CONFIG_TELCLOCK is not set
 
 #
 # I2C support
@@ -624,6 +654,7 @@ CONFIG_GEN_RTC=y
 #
 # Dallas's 1-wire bus
 #
+# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -632,17 +663,13 @@ CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
 # CONFIG_SENSORS_ABITUGURU is not set
 # CONFIG_SENSORS_F71805F is not set
+# CONFIG_SENSORS_VT1211 is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
-# Misc devices
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -662,6 +689,11 @@ CONFIG_FIRMWARE_EDID=y
 # CONFIG_SOUND is not set
 
 #
+# HID Devices
+#
+# CONFIG_HID is not set
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -733,6 +765,7 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
 # CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
@@ -740,6 +773,7 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -769,8 +803,10 @@ CONFIG_DNOTIFY=y
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -836,8 +872,14 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_NLS is not set
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Library routines
 #
+CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
@@ -853,6 +895,7 @@ CONFIG_PLIST=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
@@ -871,8 +914,10 @@ CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 # CONFIG_UNWIND_INFO is not set
 CONFIG_FORCED_INLINING=y
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_DEBUGGER is not set
 # CONFIG_BDI_SWITCH is not set
@@ -889,7 +934,3 @@ CONFIG_FORCED_INLINING=y
 # Cryptographic options
 #
 # CONFIG_CRYPTO is not set
-
-#
-# Hardware crypto devices
-#
Index: linux-2.6/arch/powerpc/configs/mpc8641_hpcn_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/mpc8641_hpcn_defconfig
+++ linux-2.6/arch/powerpc/configs/mpc8641_hpcn_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc6
-# Sun Sep 10 10:30:15 2006
+# Linux kernel version: 2.6.19
+# Sat Dec  9 13:49:12 2006
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -10,6 +10,7 @@ CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -21,13 +22,13 @@ CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_PPC_OF=y
 CONFIG_PPC_UDBG_16550=y
 CONFIG_GENERIC_TBSYNC=y
+CONFIG_AUDIT_ARCH=y
 # CONFIG_DEFAULT_UIMAGE is not set
 
 #
 # Processor support
 #
 # CONFIG_CLASSIC32 is not set
-# CONFIG_PPC_52xx is not set
 # CONFIG_PPC_82xx is not set
 # CONFIG_PPC_83xx is not set
 # CONFIG_PPC_85xx is not set
@@ -38,6 +39,8 @@ CONFIG_PPC_86xx=y
 # CONFIG_E200 is not set
 CONFIG_6xx=y
 CONFIG_PPC_FPU=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
 CONFIG_ALTIVEC=y
 CONFIG_PPC_STD_MMU=y
 CONFIG_PPC_STD_MMU_32=y
@@ -62,15 +65,18 @@ CONFIG_LOCALVERSION=""
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-CONFIG_SYSCTL=y
+# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_CPUSETS is not set
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 CONFIG_KALLSYMS_EXTRA_PASS=y
@@ -79,12 +85,12 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 # CONFIG_ELF_CORE is not set
 CONFIG_BASE_FULL=y
-CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
 # CONFIG_SLAB is not set
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 CONFIG_SLOB=y
@@ -97,6 +103,7 @@ CONFIG_SLOB=y
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
@@ -129,6 +136,7 @@ CONFIG_MPC8641=y
 CONFIG_HIGHMEM=y
 # CONFIG_HZ_100 is not set
 # CONFIG_HZ_250 is not set
+# CONFIG_HZ_300 is not set
 CONFIG_HZ_1000=y
 CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
@@ -140,6 +148,7 @@ CONFIG_BINFMT_ELF=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 # CONFIG_IRQ_ALL_CPUS is not set
 CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -166,6 +175,7 @@ CONFIG_FSL_SOC=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCIEPORTBUS is not set
+# CONFIG_PCI_MULTITHREAD_PROBE is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -206,6 +216,7 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 CONFIG_XFRM_USER=y
+# CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 # CONFIG_IP_MULTICAST is not set
@@ -226,21 +237,29 @@ CONFIG_IP_PNP_RARP=y
 # CONFIG_INET_TUNNEL is not set
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
+# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 CONFIG_IPV6=y
 # CONFIG_IPV6_PRIVACY is not set
 # CONFIG_IPV6_ROUTER_PREF is not set
 # CONFIG_INET6_AH is not set
 # CONFIG_INET6_ESP is not set
 # CONFIG_INET6_IPCOMP is not set
+# CONFIG_IPV6_MIP6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
 CONFIG_INET6_XFRM_MODE_TRANSPORT=y
 CONFIG_INET6_XFRM_MODE_TUNNEL=y
+# CONFIG_INET6_XFRM_MODE_BEET is not set
+# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
+# CONFIG_IPV6_SIT is not set
 # CONFIG_IPV6_TUNNEL is not set
+# CONFIG_IPV6_MULTIPLE_TABLES is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
 
@@ -267,7 +286,6 @@ CONFIG_INET6_XFRM_MODE_TUNNEL=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 
@@ -339,6 +357,12 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
+# Misc devices
+#
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+
+#
 # ATA/ATAPI/MFM/RLL support
 #
 # CONFIG_IDE is not set
@@ -348,6 +372,12 @@ CONFIG_BLK_DEV_INITRD=y
 #
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
+# CONFIG_SCSI_NETLINK is not set
+
+#
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+# CONFIG_ATA is not set
 
 #
 # Multi-device support (RAID and LVM)
@@ -372,6 +402,7 @@ CONFIG_BLK_DEV_INITRD=y
 #
 # Macintosh device drivers
 #
+# CONFIG_MAC_EMUMOUSEBTN is not set
 # CONFIG_WINDFARM is not set
 
 #
@@ -403,6 +434,7 @@ CONFIG_PHYLIB=y
 # CONFIG_CICADA_PHY is not set
 CONFIG_VITESSE_PHY=y
 # CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
 # CONFIG_FIXED_PHY is not set
 
 #
@@ -440,6 +472,7 @@ CONFIG_MII=y
 # CONFIG_BNX2 is not set
 CONFIG_GIANFAR=y
 # CONFIG_GFAR_NAPI is not set
+# CONFIG_QLA3XXX is not set
 
 #
 # Ethernet (10000 Mbit)
@@ -448,6 +481,7 @@ CONFIG_GIANFAR=y
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
 
 #
 # Token Ring devices
@@ -486,6 +520,7 @@ CONFIG_GIANFAR=y
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -542,6 +577,7 @@ CONFIG_SERIAL_8250_RSA=y
 #
 # Non-8250 serial port support
 #
+# CONFIG_SERIAL_UARTLITE is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
@@ -563,10 +599,6 @@ CONFIG_UNIX98_PTYS=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -575,7 +607,6 @@ CONFIG_UNIX98_PTYS=y
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-# CONFIG_TELCLOCK is not set
 
 #
 # I2C support
@@ -640,6 +671,7 @@ CONFIG_SENSORS_EEPROM=y
 #
 # Dallas's 1-wire bus
 #
+# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -648,14 +680,9 @@ CONFIG_SENSORS_EEPROM=y
 # CONFIG_HWMON_VID is not set
 
 #
-# Misc devices
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -682,6 +709,11 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_SOUND is not set
 
 #
+# HID Devices
+#
+# CONFIG_HID is not set
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -753,6 +785,7 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
 # CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
@@ -760,6 +793,7 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -788,8 +822,10 @@ CONFIG_FS_MBCACHE=y
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -904,8 +940,14 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_UTF8 is not set
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Library routines
 #
+CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
@@ -921,6 +963,7 @@ CONFIG_PLIST=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
@@ -939,8 +982,10 @@ CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 # CONFIG_UNWIND_INFO is not set
 CONFIG_FORCED_INLINING=y
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_DEBUGGER is not set
 # CONFIG_BDI_SWITCH is not set
@@ -957,7 +1002,3 @@ CONFIG_FORCED_INLINING=y
 # Cryptographic options
 #
 # CONFIG_CRYPTO is not set
-
-#
-# Hardware crypto devices
-#
Index: linux-2.6/arch/powerpc/configs/pmac32_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/pmac32_defconfig
+++ linux-2.6/arch/powerpc/configs/pmac32_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc6
-# Sun Sep 10 10:30:23 2006
+# Linux kernel version: 2.6.19
+# Sun Dec 10 11:07:28 2006
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -10,6 +10,7 @@ CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -21,13 +22,13 @@ CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_PPC_OF=y
 # CONFIG_PPC_UDBG_16550 is not set
 # CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=y
 # CONFIG_DEFAULT_UIMAGE is not set
 
 #
 # Processor support
 #
 CONFIG_CLASSIC32=y
-# CONFIG_PPC_52xx is not set
 # CONFIG_PPC_82xx is not set
 # CONFIG_PPC_83xx is not set
 # CONFIG_PPC_85xx is not set
@@ -38,6 +39,8 @@ CONFIG_CLASSIC32=y
 # CONFIG_E200 is not set
 CONFIG_6xx=y
 CONFIG_PPC_FPU=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
 CONFIG_ALTIVEC=y
 CONFIG_PPC_STD_MMU=y
 CONFIG_PPC_STD_MMU_32=y
@@ -58,17 +61,21 @@ CONFIG_LOCALVERSION=""
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-CONFIG_SYSCTL=y
+# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -77,12 +84,12 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
-CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
 CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
@@ -100,6 +107,7 @@ CONFIG_KMOD=y
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 CONFIG_LBD=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
 CONFIG_LSF=y
@@ -121,18 +129,22 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # Platform support
 #
 CONFIG_PPC_MULTIPLATFORM=y
-# CONFIG_PPC_ISERIES is not set
 # CONFIG_EMBEDDED6xx is not set
 # CONFIG_APUS is not set
 # CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_MPC52xx is not set
+# CONFIG_PPC_EFIKA is not set
+# CONFIG_PPC_LITE5200 is not set
 CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
-# CONFIG_UDBG_RTAS_CONSOLE is not set
+CONFIG_PPC_NATIVE=y
 # CONFIG_PPC_RTAS is not set
 # CONFIG_MMIO_NVRAM is not set
 CONFIG_PPC_MPC106=y
 # CONFIG_PPC_970_NAP is not set
+# CONFIG_PPC_INDIRECT_IO is not set
+# CONFIG_GENERIC_IOMAP is not set
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_TABLE=y
 # CONFIG_CPU_FREQ_DEBUG is not set
@@ -157,6 +169,7 @@ CONFIG_MPIC=y
 # CONFIG_HIGHMEM is not set
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
@@ -167,6 +180,7 @@ CONFIG_BINFMT_MISC=m
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 # CONFIG_KEXEC is not set
 CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -181,6 +195,8 @@ CONFIG_PROC_DEVICETREE=y
 CONFIG_PM=y
 # CONFIG_PM_LEGACY is not set
 CONFIG_PM_DEBUG=y
+# CONFIG_DISABLE_CONSOLE_SUSPEND is not set
+# CONFIG_PM_SYSFS_DEPRECATED is not set
 CONFIG_SOFTWARE_SUSPEND=y
 CONFIG_PM_STD_PARTITION=""
 CONFIG_SECCOMP=y
@@ -196,6 +212,7 @@ CONFIG_PPC_INDIRECT_PCI=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCIEPORTBUS is not set
+# CONFIG_PCI_MULTITHREAD_PROBE is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -254,6 +271,7 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 CONFIG_XFRM_USER=y
+# CONFIG_XFRM_SUB_POLICY is not set
 CONFIG_NET_KEY=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -272,10 +290,13 @@ CONFIG_INET_ESP=y
 # CONFIG_INET_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 
 #
 # IP: Virtual Server Configuration
@@ -291,15 +312,40 @@ CONFIG_NETFILTER=y
 #
 # Core Netfilter Configuration
 #
-# CONFIG_NETFILTER_NETLINK is not set
+CONFIG_NETFILTER_NETLINK=m
+CONFIG_NETFILTER_NETLINK_QUEUE=m
+CONFIG_NETFILTER_NETLINK_LOG=m
+CONFIG_NF_CONNTRACK_ENABLED=y
+CONFIG_NF_CONNTRACK_SUPPORT=y
+# CONFIG_IP_NF_CONNTRACK_SUPPORT is not set
+CONFIG_NF_CONNTRACK=y
+CONFIG_NF_CT_ACCT=y
+CONFIG_NF_CONNTRACK_MARK=y
+CONFIG_NF_CONNTRACK_EVENTS=y
+CONFIG_NF_CT_PROTO_GRE=m
+CONFIG_NF_CT_PROTO_SCTP=m
+CONFIG_NF_CONNTRACK_AMANDA=m
+CONFIG_NF_CONNTRACK_FTP=m
+CONFIG_NF_CONNTRACK_H323=m
+CONFIG_NF_CONNTRACK_IRC=m
+CONFIG_NF_CONNTRACK_NETBIOS_NS=m
+CONFIG_NF_CONNTRACK_PPTP=m
+CONFIG_NF_CONNTRACK_SIP=m
+CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NETFILTER_XTABLES=m
 CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
+CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
+CONFIG_NETFILTER_XT_TARGET_DSCP=m
 CONFIG_NETFILTER_XT_TARGET_MARK=m
 CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
+CONFIG_NETFILTER_XT_TARGET_NFLOG=m
 CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
 CONFIG_NETFILTER_XT_MATCH_COMMENT=m
+CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
+CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
 CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
 CONFIG_NETFILTER_XT_MATCH_DCCP=m
+CONFIG_NETFILTER_XT_MATCH_DSCP=m
 CONFIG_NETFILTER_XT_MATCH_ESP=m
 CONFIG_NETFILTER_XT_MATCH_HELPER=m
 CONFIG_NETFILTER_XT_MATCH_LENGTH=m
@@ -309,65 +355,55 @@ CONFIG_NETFILTER_XT_MATCH_MARK=m
 CONFIG_NETFILTER_XT_MATCH_POLICY=m
 CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
 CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
-# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
+CONFIG_NETFILTER_XT_MATCH_QUOTA=m
 CONFIG_NETFILTER_XT_MATCH_REALM=m
 CONFIG_NETFILTER_XT_MATCH_SCTP=m
 CONFIG_NETFILTER_XT_MATCH_STATE=m
-# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
+CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
 CONFIG_NETFILTER_XT_MATCH_STRING=m
 CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
+CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
 
 #
 # IP: Netfilter Configuration
 #
-CONFIG_IP_NF_CONNTRACK=m
-# CONFIG_IP_NF_CT_ACCT is not set
-# CONFIG_IP_NF_CONNTRACK_MARK is not set
-# CONFIG_IP_NF_CONNTRACK_EVENTS is not set
-# CONFIG_IP_NF_CT_PROTO_SCTP is not set
-CONFIG_IP_NF_FTP=m
-CONFIG_IP_NF_IRC=m
-CONFIG_IP_NF_NETBIOS_NS=m
-CONFIG_IP_NF_TFTP=m
-CONFIG_IP_NF_AMANDA=m
-CONFIG_IP_NF_PPTP=m
-CONFIG_IP_NF_H323=m
-# CONFIG_IP_NF_SIP is not set
+CONFIG_NF_CONNTRACK_IPV4=m
+CONFIG_NF_CONNTRACK_PROC_COMPAT=y
 # CONFIG_IP_NF_QUEUE is not set
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_IPRANGE=m
 CONFIG_IP_NF_MATCH_TOS=m
 CONFIG_IP_NF_MATCH_RECENT=m
 CONFIG_IP_NF_MATCH_ECN=m
-CONFIG_IP_NF_MATCH_DSCP=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_MATCH_OWNER=m
 CONFIG_IP_NF_MATCH_ADDRTYPE=m
-CONFIG_IP_NF_MATCH_HASHLIMIT=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_TARGET_LOG=m
 CONFIG_IP_NF_TARGET_ULOG=m
 CONFIG_IP_NF_TARGET_TCPMSS=m
-CONFIG_IP_NF_NAT=m
-CONFIG_IP_NF_NAT_NEEDED=y
+CONFIG_NF_NAT=m
+CONFIG_NF_NAT_NEEDED=y
 CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
-CONFIG_IP_NF_TARGET_NETMAP=m
-CONFIG_IP_NF_TARGET_SAME=m
-CONFIG_IP_NF_NAT_SNMP_BASIC=m
-CONFIG_IP_NF_NAT_IRC=m
-CONFIG_IP_NF_NAT_FTP=m
-CONFIG_IP_NF_NAT_TFTP=m
-CONFIG_IP_NF_NAT_AMANDA=m
-CONFIG_IP_NF_NAT_PPTP=m
-CONFIG_IP_NF_NAT_H323=m
+# CONFIG_IP_NF_TARGET_NETMAP is not set
+# CONFIG_IP_NF_TARGET_SAME is not set
+# CONFIG_NF_NAT_SNMP_BASIC is not set
+CONFIG_NF_NAT_PROTO_GRE=m
+CONFIG_NF_NAT_FTP=m
+CONFIG_NF_NAT_IRC=m
+CONFIG_NF_NAT_TFTP=m
+CONFIG_NF_NAT_AMANDA=m
+CONFIG_NF_NAT_PPTP=m
+CONFIG_NF_NAT_H323=m
+CONFIG_NF_NAT_SIP=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_TOS=m
 CONFIG_IP_NF_TARGET_ECN=m
-CONFIG_IP_NF_TARGET_DSCP=m
 CONFIG_IP_NF_TARGET_TTL=m
+# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
 CONFIG_IP_NF_RAW=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
@@ -384,8 +420,11 @@ CONFIG_IP_DCCP_ACKVEC=y
 # DCCP CCIDs Configuration (EXPERIMENTAL)
 #
 CONFIG_IP_DCCP_CCID2=m
+# CONFIG_IP_DCCP_CCID2_DEBUG is not set
 CONFIG_IP_DCCP_CCID3=m
 CONFIG_IP_DCCP_TFRC_LIB=m
+# CONFIG_IP_DCCP_CCID3_DEBUG is not set
+CONFIG_IP_DCCP_CCID3_RTO=100
 
 #
 # DCCP Kernel Hacking
@@ -410,7 +449,6 @@ CONFIG_IP_DCCP_TFRC_LIB=m
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 
@@ -567,6 +605,12 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
+# Misc devices
+#
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+
+#
 # ATA/ATAPI/MFM/RLL support
 #
 CONFIG_IDE=y
@@ -594,7 +638,6 @@ CONFIG_IDEPCI_SHARE_IRQ=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 CONFIG_BLK_DEV_GENERIC=y
 # CONFIG_BLK_DEV_OPTI621 is not set
-CONFIG_BLK_DEV_SL82C105=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
@@ -609,6 +652,7 @@ CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_BLK_DEV_CS5530 is not set
 # CONFIG_BLK_DEV_HPT34X is not set
 # CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_JMICRON is not set
 # CONFIG_BLK_DEV_SC1200 is not set
 # CONFIG_BLK_DEV_PIIX is not set
 # CONFIG_BLK_DEV_IT821X is not set
@@ -617,6 +661,7 @@ CONFIG_IDEDMA_PCI_AUTO=y
 CONFIG_BLK_DEV_PDC202XX_NEW=y
 # CONFIG_BLK_DEV_SVWKS is not set
 # CONFIG_BLK_DEV_SIIMAGE is not set
+CONFIG_BLK_DEV_SL82C105=y
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
 # CONFIG_BLK_DEV_VIA82CXXX is not set
@@ -634,6 +679,8 @@ CONFIG_IDEDMA_AUTO=y
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+# CONFIG_SCSI_TGT is not set
+CONFIG_SCSI_NETLINK=y
 CONFIG_SCSI_PROC_FS=y
 
 #
@@ -653,14 +700,16 @@ CONFIG_CHR_DEV_SG=y
 # CONFIG_SCSI_MULTI_LUN is not set
 CONFIG_SCSI_CONSTANTS=y
 # CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
 
 #
-# SCSI Transport Attributes
+# SCSI Transports
 #
 CONFIG_SCSI_SPI_ATTRS=y
 CONFIG_SCSI_FC_ATTRS=y
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
 
 #
 # SCSI low-level drivers
@@ -678,11 +727,12 @@ CONFIG_AIC7XXX_DEBUG_MASK=0
 CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
 CONFIG_SCSI_AIC7XXX_OLD=m
 # CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC94XX is not set
 # CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_ARCMSR is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_ATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
@@ -692,14 +742,15 @@ CONFIG_SCSI_AIC7XXX_OLD=m
 # CONFIG_SCSI_IPS is not set
 # CONFIG_SCSI_INITIO is not set
 # CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_STEX is not set
 CONFIG_SCSI_SYM53C8XX_2=y
 CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
 CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
 CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
 CONFIG_SCSI_SYM53C8XX_MMIO=y
-# CONFIG_SCSI_IPR is not set
 # CONFIG_SCSI_QLOGIC_1280 is not set
 # CONFIG_SCSI_QLA_FC is not set
+# CONFIG_SCSI_QLA_ISCSI is not set
 # CONFIG_SCSI_LPFC is not set
 # CONFIG_SCSI_DC395x is not set
 # CONFIG_SCSI_DC390T is not set
@@ -709,6 +760,7 @@ CONFIG_SCSI_MESH=y
 CONFIG_SCSI_MESH_SYNC_RATE=5
 CONFIG_SCSI_MESH_RESET_DELAY_MS=4000
 CONFIG_SCSI_MAC53C94=y
+# CONFIG_SCSI_SRP is not set
 
 #
 # PCMCIA SCSI adapter support
@@ -720,6 +772,11 @@ CONFIG_SCSI_MAC53C94=y
 # CONFIG_PCMCIA_SYM53C500 is not set
 
 #
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+# CONFIG_ATA is not set
+
+#
 # Multi-device support (RAID and LVM)
 #
 CONFIG_MD=y
@@ -732,6 +789,7 @@ CONFIG_MD_RAID10=m
 CONFIG_MD_MULTIPATH=m
 CONFIG_MD_FAULTY=m
 CONFIG_BLK_DEV_DM=m
+# CONFIG_DM_DEBUG is not set
 CONFIG_DM_CRYPT=m
 CONFIG_DM_SNAPSHOT=m
 CONFIG_DM_MIRROR=m
@@ -798,6 +856,7 @@ CONFIG_THERM_WINDTUNNEL=m
 CONFIG_THERM_ADT746X=m
 # CONFIG_WINDFARM is not set
 # CONFIG_ANSLCD is not set
+CONFIG_PMAC_RACKMETER=m
 
 #
 # Network device support
@@ -838,6 +897,7 @@ CONFIG_SUNGEM=y
 # CONFIG_HP100 is not set
 CONFIG_NET_PCI=y
 CONFIG_PCNET32=y
+CONFIG_PCNET32_NAPI=y
 # CONFIG_AMD8111_ETH is not set
 # CONFIG_ADAPTEC_STARFIRE is not set
 # CONFIG_B44 is not set
@@ -874,6 +934,7 @@ CONFIG_PCNET32=y
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
 # CONFIG_MV643XX_ETH is not set
+# CONFIG_QLA3XXX is not set
 
 #
 # Ethernet (10000 Mbit)
@@ -882,6 +943,7 @@ CONFIG_PCNET32=y
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
 
 #
 # Token Ring devices
@@ -957,6 +1019,7 @@ CONFIG_PPP_BSDCOMP=m
 # CONFIG_PPP_MPPE is not set
 # CONFIG_PPPOE is not set
 # CONFIG_SLIP is not set
+CONFIG_SLHC=y
 # CONFIG_NET_FC is not set
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
@@ -977,6 +1040,7 @@ CONFIG_PPP_BSDCOMP=m
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -999,6 +1063,7 @@ CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
 CONFIG_INPUT_MOUSE=y
 # CONFIG_MOUSE_PS2 is not set
 # CONFIG_MOUSE_SERIAL is not set
@@ -1039,6 +1104,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 #
 # Non-8250 serial port support
 #
+# CONFIG_SERIAL_UARTLITE is not set
 CONFIG_SERIAL_CORE=m
 CONFIG_SERIAL_PMACZILOG=m
 # CONFIG_SERIAL_JSM is not set
@@ -1062,10 +1128,6 @@ CONFIG_GEN_RTC=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 CONFIG_AGP=m
 # CONFIG_AGP_SIS is not set
 # CONFIG_AGP_VIA is not set
@@ -1091,7 +1153,6 @@ CONFIG_DRM_RADEON=m
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-# CONFIG_TELCLOCK is not set
 
 #
 # I2C support
@@ -1167,14 +1228,9 @@ CONFIG_I2C_POWERMAC=y
 # CONFIG_HWMON_VID is not set
 
 #
-# Misc devices
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -1187,6 +1243,7 @@ CONFIG_VIDEO_V4L2=y
 #
 # CONFIG_FIRMWARE_EDID is not set
 CONFIG_FB=y
+CONFIG_FB_DDC=y
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
@@ -1393,6 +1450,11 @@ CONFIG_SND_USB_AUDIO=m
 # CONFIG_SOUND_PRIME is not set
 
 #
+# HID Devices
+#
+CONFIG_HID=y
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -1408,6 +1470,7 @@ CONFIG_USB_DEVICEFS=y
 # CONFIG_USB_BANDWIDTH is not set
 CONFIG_USB_DYNAMIC_MINORS=y
 # CONFIG_USB_SUSPEND is not set
+# CONFIG_USB_MULTITHREAD_PROBE is not set
 # CONFIG_USB_OTG is not set
 
 #
@@ -1448,14 +1511,14 @@ CONFIG_USB_STORAGE=m
 # CONFIG_USB_STORAGE_SDDR55 is not set
 # CONFIG_USB_STORAGE_JUMPSHOT is not set
 # CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_KARMA is not set
 # CONFIG_USB_LIBUSUAL is not set
 
 #
 # USB Input Devices
 #
 CONFIG_USB_HID=y
-CONFIG_USB_HIDINPUT=y
-CONFIG_USB_HIDINPUT_POWERBOOK=y
+CONFIG_USB_HID_POWERBOOK=y
 # CONFIG_HID_FF is not set
 # CONFIG_USB_HIDDEV is not set
 # CONFIG_USB_AIPTEK is not set
@@ -1484,12 +1547,14 @@ CONFIG_USB_APPLETOUCH=y
 # CONFIG_USB_KAWETH is not set
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
+CONFIG_USB_USBNET_MII=m
 CONFIG_USB_USBNET=m
 CONFIG_USB_NET_AX8817X=m
 CONFIG_USB_NET_CDCETHER=m
 # CONFIG_USB_NET_GL620A is not set
 CONFIG_USB_NET_NET1080=m
 # CONFIG_USB_NET_PLUSB is not set
+# CONFIG_USB_NET_MCS7830 is not set
 # CONFIG_USB_NET_RNDIS_HOST is not set
 # CONFIG_USB_NET_CDC_SUBSET is not set
 CONFIG_USB_NET_ZAURUS=m
@@ -1504,6 +1569,7 @@ CONFIG_USB_MON=y
 #
 CONFIG_USB_SERIAL=m
 # CONFIG_USB_SERIAL_GENERIC is not set
+# CONFIG_USB_SERIAL_AIRCABLE is not set
 # CONFIG_USB_SERIAL_AIRPRIME is not set
 # CONFIG_USB_SERIAL_ARK3116 is not set
 # CONFIG_USB_SERIAL_BELKIN is not set
@@ -1538,6 +1604,8 @@ CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
 # CONFIG_USB_SERIAL_KLSI is not set
 # CONFIG_USB_SERIAL_KOBIL_SCT is not set
 # CONFIG_USB_SERIAL_MCT_U232 is not set
+# CONFIG_USB_SERIAL_MOS7720 is not set
+# CONFIG_USB_SERIAL_MOS7840 is not set
 # CONFIG_USB_SERIAL_NAVMAN is not set
 # CONFIG_USB_SERIAL_PL2303 is not set
 # CONFIG_USB_SERIAL_HP4X is not set
@@ -1548,6 +1616,7 @@ CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
 # CONFIG_USB_SERIAL_XIRCOM is not set
 # CONFIG_USB_SERIAL_OPTION is not set
 # CONFIG_USB_SERIAL_OMNINET is not set
+# CONFIG_USB_SERIAL_DEBUG is not set
 CONFIG_USB_EZUSB=y
 
 #
@@ -1555,6 +1624,7 @@ CONFIG_USB_EZUSB=y
 #
 # CONFIG_USB_EMI62 is not set
 # CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
@@ -1562,12 +1632,13 @@ CONFIG_USB_EZUSB=y
 # CONFIG_USB_LED is not set
 # CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
-# CONFIG_USB_PHIDGETKIT is not set
-# CONFIG_USB_PHIDGETSERVO is not set
+# CONFIG_USB_PHIDGET is not set
 # CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
 CONFIG_USB_APPLEDISPLAY=m
 # CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_TEST is not set
 
 #
@@ -1639,6 +1710,7 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 # CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
@@ -1646,6 +1718,7 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -1682,8 +1755,10 @@ CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -1802,8 +1877,14 @@ CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_UTF8=m
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Library routines
 #
+CONFIG_BITREVERSE=y
 CONFIG_CRC_CCITT=y
 CONFIG_CRC16=y
 CONFIG_CRC32=y
@@ -1826,6 +1907,7 @@ CONFIG_OPROFILE=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
@@ -1844,11 +1926,14 @@ CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 # CONFIG_FORCED_INLINING is not set
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 CONFIG_DEBUGGER=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
+CONFIG_XMON_DISASSEMBLY=y
 # CONFIG_BDI_SWITCH is not set
 CONFIG_BOOTX_TEXT=y
 # CONFIG_PPC_EARLY_DEBUG is not set
@@ -1863,7 +1948,12 @@ CONFIG_BOOTX_TEXT=y
 # Cryptographic options
 #
 CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MD5=y
@@ -1872,9 +1962,14 @@ CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_TGR192=m
+CONFIG_CRYPTO_GF128MUL=m
+CONFIG_CRYPTO_ECB=m
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_TWOFISH=m
+CONFIG_CRYPTO_TWOFISH_COMMON=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_AES=m
 CONFIG_CRYPTO_CAST5=m
Index: linux-2.6/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/ppc64_defconfig
+++ linux-2.6/arch/powerpc/configs/ppc64_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc6
-# Sun Sep 10 10:45:11 2006
+# Linux kernel version: 2.6.19
+# Sun Dec 10 10:55:06 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -10,6 +10,8 @@ CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+CONFIG_ARCH_HAS_ILOG2_U64=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -22,6 +24,7 @@ CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_PPC_OF=y
 CONFIG_PPC_UDBG_16550=y
 CONFIG_GENERIC_TBSYNC=y
+CONFIG_AUDIT_ARCH=y
 # CONFIG_DEFAULT_UIMAGE is not set
 
 #
@@ -31,6 +34,10 @@ CONFIG_GENERIC_TBSYNC=y
 CONFIG_POWER3=y
 CONFIG_POWER4=y
 CONFIG_PPC_FPU=y
+# CONFIG_PPC_DCR_NATIVE is not set
+CONFIG_PPC_DCR_MMIO=y
+CONFIG_PPC_DCR=y
+CONFIG_PPC_OF_PLATFORM_PCI=y
 CONFIG_ALTIVEC=y
 CONFIG_PPC_STD_MMU=y
 CONFIG_VIRT_CPU_ACCOUNTING=y
@@ -52,19 +59,24 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_TASKSTATS=y
 CONFIG_TASK_DELAY_ACCT=y
-CONFIG_SYSCTL=y
+# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CPUSETS=y
+CONFIG_SYSFS_DEPRECATED=y
 CONFIG_RELAY=y
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_TASK_XACCT is not set
+CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -73,12 +85,12 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
-CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
 CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
@@ -97,6 +109,7 @@ CONFIG_STOP_MACHINE=y
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 CONFIG_BLK_DEV_IO_TRACE=y
 
 #
@@ -116,16 +129,20 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # Platform support
 #
 CONFIG_PPC_MULTIPLATFORM=y
-# CONFIG_PPC_ISERIES is not set
 # CONFIG_EMBEDDED6xx is not set
 # CONFIG_APUS is not set
 CONFIG_PPC_PSERIES=y
+CONFIG_PPC_ISERIES=y
+# CONFIG_PPC_MPC52xx is not set
 CONFIG_PPC_PMAC=y
 CONFIG_PPC_PMAC64=y
 CONFIG_PPC_MAPLE=y
+CONFIG_PPC_PASEMI=y
 CONFIG_PPC_CELL=y
 CONFIG_PPC_CELL_NATIVE=y
 CONFIG_PPC_IBM_CELL_BLADE=y
+CONFIG_PPC_PS3=y
+CONFIG_PPC_NATIVE=y
 CONFIG_UDBG_RTAS_CONSOLE=y
 CONFIG_XICS=y
 CONFIG_U3_DART=y
@@ -136,9 +153,11 @@ CONFIG_RTAS_FLASH=m
 CONFIG_MMIO_NVRAM=y
 CONFIG_MPIC_BROKEN_U3=y
 CONFIG_IBMVIO=y
-# CONFIG_IBMEBUS is not set
+CONFIG_IBMEBUS=y
 # CONFIG_PPC_MPC106 is not set
 CONFIG_PPC_970_NAP=y
+CONFIG_PPC_INDIRECT_IO=y
+CONFIG_GENERIC_IOMAP=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_TABLE=y
 # CONFIG_CPU_FREQ_DEBUG is not set
@@ -160,14 +179,23 @@ CONFIG_MPIC=y
 #
 CONFIG_SPU_FS=m
 CONFIG_SPU_BASE=y
-CONFIG_SPUFS_MMAP=y
 CONFIG_CBE_RAS=y
+CONFIG_CBE_THERM=m
+CONFIG_CBE_CPUFREQ=m
+
+#
+# PS3 Platform Options
+#
+CONFIG_PS3_HTAB_SIZE=20
+# CONFIG_PS3_DYNAMIC_DMA is not set
+CONFIG_PS3_USE_LPAR_ADDR=y
 
 #
 # Kernel options
 #
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
@@ -192,6 +220,7 @@ CONFIG_ARCH_SELECT_MEMORY_MODEL=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_SPARSEMEM_ENABLE=y
 CONFIG_ARCH_SPARSEMEM_DEFAULT=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 # CONFIG_FLATMEM_MANUAL is not set
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -201,14 +230,18 @@ CONFIG_HAVE_MEMORY_PRESENT=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPARSEMEM_EXTREME=y
 CONFIG_MEMORY_HOTPLUG=y
+CONFIG_MEMORY_HOTPLUG_SPARSE=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_RESOURCES_64BIT=y
 CONFIG_ARCH_MEMORY_PROBE=y
 # CONFIG_PPC_64K_PAGES is not set
-# CONFIG_SCHED_SMT is not set
+CONFIG_SCHED_SMT=y
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
-# CONFIG_PM is not set
+CONFIG_PM=y
+CONFIG_PM_LEGACY=y
+# CONFIG_PM_DEBUG is not set
+# CONFIG_PM_SYSFS_DEPRECATED is not set
 CONFIG_SECCOMP=y
 CONFIG_ISA_DMA_API=y
 
@@ -222,6 +255,7 @@ CONFIG_PPC_I8259=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCIEPORTBUS is not set
+# CONFIG_PCI_MULTITHREAD_PROBE is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -254,6 +288,7 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 CONFIG_XFRM_USER=m
+# CONFIG_XFRM_SUB_POLICY is not set
 CONFIG_NET_KEY=m
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -272,10 +307,13 @@ CONFIG_INET_XFRM_TUNNEL=m
 CONFIG_INET_TUNNEL=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
+# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 
 #
 # IP: Virtual Server Configuration
@@ -294,25 +332,30 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK=y
 CONFIG_NETFILTER_NETLINK_QUEUE=m
 CONFIG_NETFILTER_NETLINK_LOG=m
+CONFIG_NF_CONNTRACK_ENABLED=y
+CONFIG_NF_CONNTRACK_SUPPORT=y
+# CONFIG_IP_NF_CONNTRACK_SUPPORT is not set
+CONFIG_NF_CONNTRACK=y
+CONFIG_NF_CT_ACCT=y
+CONFIG_NF_CONNTRACK_MARK=y
+CONFIG_NF_CONNTRACK_EVENTS=y
+CONFIG_NF_CT_PROTO_SCTP=m
+# CONFIG_NF_CONNTRACK_AMANDA is not set
+CONFIG_NF_CONNTRACK_FTP=m
+# CONFIG_NF_CONNTRACK_H323 is not set
+CONFIG_NF_CONNTRACK_IRC=m
+# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
+# CONFIG_NF_CONNTRACK_PPTP is not set
+# CONFIG_NF_CONNTRACK_SIP is not set
+# CONFIG_NF_CONNTRACK_TFTP is not set
+CONFIG_NF_CT_NETLINK=m
 # CONFIG_NETFILTER_XTABLES is not set
 
 #
 # IP: Netfilter Configuration
 #
-CONFIG_IP_NF_CONNTRACK=m
-CONFIG_IP_NF_CT_ACCT=y
-CONFIG_IP_NF_CONNTRACK_MARK=y
-CONFIG_IP_NF_CONNTRACK_EVENTS=y
-CONFIG_IP_NF_CONNTRACK_NETLINK=m
-CONFIG_IP_NF_CT_PROTO_SCTP=m
-CONFIG_IP_NF_FTP=m
-CONFIG_IP_NF_IRC=m
-# CONFIG_IP_NF_NETBIOS_NS is not set
-CONFIG_IP_NF_TFTP=m
-CONFIG_IP_NF_AMANDA=m
-# CONFIG_IP_NF_PPTP is not set
-# CONFIG_IP_NF_H323 is not set
-CONFIG_IP_NF_SIP=m
+CONFIG_NF_CONNTRACK_IPV4=m
+CONFIG_NF_CONNTRACK_PROC_COMPAT=y
 CONFIG_IP_NF_QUEUE=m
 
 #
@@ -339,7 +382,6 @@ CONFIG_LLC=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 
@@ -383,7 +425,14 @@ CONFIG_FW_LOADER=y
 #
 # Parallel port support
 #
-# CONFIG_PARPORT is not set
+CONFIG_PARPORT=m
+CONFIG_PARPORT_PC=m
+CONFIG_PARPORT_SERIAL=m
+CONFIG_PARPORT_PC_FIFO=y
+# CONFIG_PARPORT_PC_SUPERIO is not set
+# CONFIG_PARPORT_GSC is not set
+# CONFIG_PARPORT_AX88796 is not set
+CONFIG_PARPORT_1284=y
 
 #
 # Plug and Play support
@@ -393,6 +442,7 @@ CONFIG_FW_LOADER=y
 # Block devices
 #
 CONFIG_BLK_DEV_FD=y
+# CONFIG_PARIDE is not set
 # CONFIG_BLK_CPQ_DA is not set
 # CONFIG_BLK_CPQ_CISS_DA is not set
 # CONFIG_BLK_DEV_DAC960 is not set
@@ -412,6 +462,12 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
+# Misc devices
+#
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+
+#
 # ATA/ATAPI/MFM/RLL support
 #
 CONFIG_IDE=y
@@ -438,7 +494,6 @@ CONFIG_IDEPCI_SHARE_IRQ=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 CONFIG_BLK_DEV_GENERIC=y
 # CONFIG_BLK_DEV_OPTI621 is not set
-CONFIG_BLK_DEV_SL82C105=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
@@ -453,6 +508,7 @@ CONFIG_BLK_DEV_AMD74XX=y
 # CONFIG_BLK_DEV_CS5530 is not set
 # CONFIG_BLK_DEV_HPT34X is not set
 # CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_JMICRON is not set
 # CONFIG_BLK_DEV_SC1200 is not set
 # CONFIG_BLK_DEV_PIIX is not set
 # CONFIG_BLK_DEV_IT821X is not set
@@ -461,6 +517,7 @@ CONFIG_BLK_DEV_AMD74XX=y
 # CONFIG_BLK_DEV_PDC202XX_NEW is not set
 # CONFIG_BLK_DEV_SVWKS is not set
 # CONFIG_BLK_DEV_SIIMAGE is not set
+CONFIG_BLK_DEV_SL82C105=y
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
 # CONFIG_BLK_DEV_VIA82CXXX is not set
@@ -478,6 +535,8 @@ CONFIG_IDEDMA_AUTO=y
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+CONFIG_SCSI_TGT=m
+CONFIG_SCSI_NETLINK=y
 CONFIG_SCSI_PROC_FS=y
 
 #
@@ -497,19 +556,22 @@ CONFIG_CHR_DEV_SG=y
 CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 # CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
 
 #
-# SCSI Transport Attributes
+# SCSI Transports
 #
 CONFIG_SCSI_SPI_ATTRS=y
-CONFIG_SCSI_FC_ATTRS=y
+CONFIG_SCSI_FC_ATTRS=m
 CONFIG_SCSI_ISCSI_ATTRS=m
-# CONFIG_SCSI_SAS_ATTRS is not set
+CONFIG_SCSI_SAS_ATTRS=m
+CONFIG_SCSI_SAS_LIBSAS=m
+# CONFIG_SCSI_SAS_LIBSAS_DEBUG is not set
 
 #
 # SCSI low-level drivers
 #
-# CONFIG_ISCSI_TCP is not set
+CONFIG_ISCSI_TCP=m
 # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
 # CONFIG_SCSI_3W_9XXX is not set
 # CONFIG_SCSI_ACARD is not set
@@ -517,26 +579,13 @@ CONFIG_SCSI_ISCSI_ATTRS=m
 # CONFIG_SCSI_AIC7XXX is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_AIC79XX is not set
+CONFIG_SCSI_AIC94XX=m
+CONFIG_AIC94XX_DEBUG=y
+# CONFIG_SCSI_ARCMSR is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
-# CONFIG_MEGARAID_SAS is not set
-CONFIG_ATA=y
-# CONFIG_SATA_AHCI is not set
-CONFIG_SATA_SVW=y
-# CONFIG_SCSI_ATA_PIIX is not set
-# CONFIG_SATA_MV is not set
-# CONFIG_SATA_NV is not set
-# CONFIG_SCSI_PDC_ADMA is not set
+CONFIG_MEGARAID_SAS=m
 # CONFIG_SCSI_HPTIOP is not set
-# CONFIG_SATA_QSTOR is not set
-# CONFIG_SATA_PROMISE is not set
-# CONFIG_SATA_SX4 is not set
-# CONFIG_SATA_SIL is not set
-# CONFIG_SATA_SIL24 is not set
-# CONFIG_SATA_SIS is not set
-# CONFIG_SATA_ULI is not set
-# CONFIG_SATA_VIA is not set
-# CONFIG_SATA_VITESSE is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
@@ -544,8 +593,12 @@ CONFIG_SATA_SVW=y
 # CONFIG_SCSI_GDTH is not set
 # CONFIG_SCSI_IPS is not set
 CONFIG_SCSI_IBMVSCSI=y
+CONFIG_SCSI_IBMVSCSIS=m
 # CONFIG_SCSI_INITIO is not set
 # CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_PPA is not set
+# CONFIG_SCSI_IMM is not set
+# CONFIG_SCSI_STEX is not set
 CONFIG_SCSI_SYM53C8XX_2=y
 CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
 CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
@@ -555,11 +608,67 @@ CONFIG_SCSI_IPR=y
 CONFIG_SCSI_IPR_TRACE=y
 CONFIG_SCSI_IPR_DUMP=y
 # CONFIG_SCSI_QLOGIC_1280 is not set
-# CONFIG_SCSI_QLA_FC is not set
+CONFIG_SCSI_QLA_FC=m
+CONFIG_SCSI_QLA_ISCSI=m
 CONFIG_SCSI_LPFC=m
 # CONFIG_SCSI_DC395x is not set
 # CONFIG_SCSI_DC390T is not set
 CONFIG_SCSI_DEBUG=m
+CONFIG_SCSI_SRP=m
+
+#
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+CONFIG_ATA=y
+# CONFIG_SATA_AHCI is not set
+CONFIG_SATA_SVW=y
+# CONFIG_ATA_PIIX is not set
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+# CONFIG_SATA_SIL is not set
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
+# CONFIG_PATA_ALI is not set
+# CONFIG_PATA_AMD is not set
+# CONFIG_PATA_ARTOP is not set
+# CONFIG_PATA_ATIIXP is not set
+# CONFIG_PATA_CMD64X is not set
+# CONFIG_PATA_CS5520 is not set
+# CONFIG_PATA_CS5530 is not set
+# CONFIG_PATA_CYPRESS is not set
+# CONFIG_PATA_EFAR is not set
+# CONFIG_ATA_GENERIC is not set
+# CONFIG_PATA_HPT366 is not set
+# CONFIG_PATA_HPT37X is not set
+# CONFIG_PATA_HPT3X2N is not set
+# CONFIG_PATA_HPT3X3 is not set
+# CONFIG_PATA_IT821X is not set
+# CONFIG_PATA_JMICRON is not set
+# CONFIG_PATA_TRIFLEX is not set
+# CONFIG_PATA_MARVELL is not set
+# CONFIG_PATA_MPIIX is not set
+# CONFIG_PATA_OLDPIIX is not set
+# CONFIG_PATA_NETCELL is not set
+# CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_OPTI is not set
+# CONFIG_PATA_OPTIDMA is not set
+# CONFIG_PATA_PDC_OLD is not set
+# CONFIG_PATA_RADISYS is not set
+# CONFIG_PATA_RZ1000 is not set
+# CONFIG_PATA_SC1200 is not set
+# CONFIG_PATA_SERVERWORKS is not set
+CONFIG_PATA_PDC2027X=y
+# CONFIG_PATA_SIL680 is not set
+# CONFIG_PATA_SIS is not set
+# CONFIG_PATA_VIA is not set
+# CONFIG_PATA_WINBOND is not set
 
 #
 # Multi-device support (RAID and LVM)
@@ -575,6 +684,7 @@ CONFIG_MD_RAID5_RESHAPE=y
 CONFIG_MD_MULTIPATH=m
 CONFIG_MD_FAULTY=m
 CONFIG_BLK_DEV_DM=y
+# CONFIG_DM_DEBUG is not set
 CONFIG_DM_CRYPT=m
 CONFIG_DM_SNAPSHOT=m
 CONFIG_DM_MIRROR=m
@@ -585,10 +695,11 @@ CONFIG_DM_MULTIPATH_EMC=m
 #
 # Fusion MPT device support
 #
-# CONFIG_FUSION is not set
+CONFIG_FUSION=y
 # CONFIG_FUSION_SPI is not set
 # CONFIG_FUSION_FC is not set
-# CONFIG_FUSION_SAS is not set
+CONFIG_FUSION_SAS=m
+CONFIG_FUSION_MAX_SGE=128
 
 #
 # IEEE 1394 (FireWire) support
@@ -630,11 +741,13 @@ CONFIG_IEEE1394_RAWIO=y
 CONFIG_ADB_PMU=y
 # CONFIG_ADB_PMU_LED is not set
 CONFIG_PMAC_SMU=y
+# CONFIG_MAC_EMUMOUSEBTN is not set
 CONFIG_THERM_PM72=y
 CONFIG_WINDFARM=y
 CONFIG_WINDFARM_PM81=y
 CONFIG_WINDFARM_PM91=y
 CONFIG_WINDFARM_PM112=y
+CONFIG_PMAC_RACKMETER=m
 
 #
 # Network device support
@@ -675,6 +788,7 @@ CONFIG_VORTEX=y
 CONFIG_IBMVETH=m
 CONFIG_NET_PCI=y
 CONFIG_PCNET32=y
+CONFIG_PCNET32_NAPI=y
 # CONFIG_AMD8111_ETH is not set
 # CONFIG_ADAPTEC_STARFIRE is not set
 # CONFIG_B44 is not set
@@ -691,6 +805,7 @@ CONFIG_E100=y
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
 # CONFIG_VIA_RHINE is not set
+# CONFIG_NET_POCKET is not set
 
 #
 # Ethernet (1000 Mbit)
@@ -713,16 +828,18 @@ CONFIG_E1000=y
 CONFIG_TIGON3=y
 # CONFIG_BNX2 is not set
 CONFIG_SPIDER_NET=m
-# CONFIG_MV643XX_ETH is not set
+# CONFIG_QLA3XXX is not set
 
 #
 # Ethernet (10000 Mbit)
 #
 # CONFIG_CHELSIO_T1 is not set
+CONFIG_EHEA=m
 CONFIG_IXGB=m
 # CONFIG_IXGB_NAPI is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
 
 #
 # Token Ring devices
@@ -741,8 +858,10 @@ CONFIG_IBMOL=y
 # Wan interfaces
 #
 # CONFIG_WAN is not set
+CONFIG_ISERIES_VETH=m
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
+# CONFIG_PLIP is not set
 CONFIG_PPP=m
 # CONFIG_PPP_MULTILINK is not set
 # CONFIG_PPP_FILTER is not set
@@ -753,6 +872,7 @@ CONFIG_PPP_BSDCOMP=m
 # CONFIG_PPP_MPPE is not set
 CONFIG_PPPOE=m
 # CONFIG_SLIP is not set
+CONFIG_SLHC=m
 # CONFIG_NET_FC is not set
 # CONFIG_SHAPER is not set
 CONFIG_NETCONSOLE=y
@@ -775,6 +895,7 @@ CONFIG_NET_POLL_CONTROLLER=y
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -797,6 +918,7 @@ CONFIG_KEYBOARD_ATKBD=y
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
 CONFIG_INPUT_MOUSE=y
 CONFIG_MOUSE_PS2=y
 # CONFIG_MOUSE_SERIAL is not set
@@ -805,7 +927,7 @@ CONFIG_MOUSE_PS2=y
 # CONFIG_INPUT_TOUCHSCREEN is not set
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PCSPKR=m
-# CONFIG_INPUT_UINPUT is not set
+CONFIG_INPUT_UINPUT=m
 
 #
 # Hardware I/O ports
@@ -813,6 +935,7 @@ CONFIG_INPUT_PCSPKR=m
 CONFIG_SERIO=y
 CONFIG_SERIO_I8042=y
 # CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_PARKBD is not set
 # CONFIG_SERIO_PCIPS2 is not set
 CONFIG_SERIO_LIBPS2=y
 # CONFIG_SERIO_RAW is not set
@@ -844,12 +967,17 @@ CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_PMACZILOG is not set
 CONFIG_SERIAL_ICOM=m
-# CONFIG_SERIAL_JSM is not set
+CONFIG_SERIAL_JSM=m
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
+CONFIG_PRINTER=m
+# CONFIG_LP_CONSOLE is not set
+# CONFIG_PPDEV is not set
+# CONFIG_TIPAR is not set
 CONFIG_HVC_DRIVER=y
 CONFIG_HVC_CONSOLE=y
+CONFIG_HVC_ISERIES=y
 CONFIG_HVC_RTAS=y
 CONFIG_HVCS=m
 
@@ -868,10 +996,6 @@ CONFIG_GEN_RTC=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 CONFIG_RAW_DRIVER=y
@@ -881,8 +1005,8 @@ CONFIG_MAX_RAW_DEVS=256
 #
 # TPM devices
 #
-# CONFIG_TCG_TPM is not set
-# CONFIG_TELCLOCK is not set
+CONFIG_TCG_TPM=m
+CONFIG_TCG_ATMEL=m
 
 #
 # I2C support
@@ -911,6 +1035,7 @@ CONFIG_I2C_AMD8111=y
 CONFIG_I2C_POWERMAC=y
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_PARPORT is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_PROSAVAGE is not set
 # CONFIG_I2C_SAVAGE4 is not set
@@ -947,6 +1072,7 @@ CONFIG_I2C_POWERMAC=y
 #
 # Dallas's 1-wire bus
 #
+# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -955,14 +1081,9 @@ CONFIG_I2C_POWERMAC=y
 # CONFIG_HWMON_VID is not set
 
 #
-# Misc devices
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -975,6 +1096,7 @@ CONFIG_VIDEO_V4L2=y
 #
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB=y
+CONFIG_FB_DDC=y
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
@@ -990,7 +1112,8 @@ CONFIG_FB_OF=y
 # CONFIG_FB_IMSTT is not set
 # CONFIG_FB_VGA16 is not set
 # CONFIG_FB_S1D13XXX is not set
-# CONFIG_FB_NVIDIA is not set
+CONFIG_FB_NVIDIA=y
+CONFIG_FB_NVIDIA_I2C=y
 # CONFIG_FB_RIVA is not set
 CONFIG_FB_MATROX=y
 CONFIG_FB_MATROX_MILLENIUM=y
@@ -1067,6 +1190,7 @@ CONFIG_SND_VERBOSE_PROCFS=y
 # CONFIG_SND_DUMMY is not set
 # CONFIG_SND_VIRMIDI is not set
 # CONFIG_SND_MTPAV is not set
+# CONFIG_SND_MTS64 is not set
 # CONFIG_SND_SERIAL_U16550 is not set
 # CONFIG_SND_MPU401 is not set
 
@@ -1133,8 +1257,7 @@ CONFIG_SND_VERBOSE_PROCFS=y
 #
 # ALSA PowerMac devices
 #
-CONFIG_SND_POWERMAC=m
-CONFIG_SND_POWERMAC_AUTO_DRC=y
+# CONFIG_SND_POWERMAC is not set
 
 #
 # Apple Onboard Audio driver
@@ -1159,6 +1282,11 @@ CONFIG_SND_AOA_SOUNDBUS_I2S=m
 # CONFIG_SOUND_PRIME is not set
 
 #
+# HID Devices
+#
+CONFIG_HID=y
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -1173,6 +1301,8 @@ CONFIG_USB=y
 CONFIG_USB_DEVICEFS=y
 # CONFIG_USB_BANDWIDTH is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_SUSPEND is not set
+# CONFIG_USB_MULTITHREAD_PROBE is not set
 # CONFIG_USB_OTG is not set
 
 #
@@ -1213,15 +1343,14 @@ CONFIG_USB_STORAGE=m
 # CONFIG_USB_STORAGE_SDDR55 is not set
 # CONFIG_USB_STORAGE_JUMPSHOT is not set
 # CONFIG_USB_STORAGE_ALAUDA is not set
-# CONFIG_USB_STORAGE_ONETOUCH is not set
+# CONFIG_USB_STORAGE_KARMA is not set
 # CONFIG_USB_LIBUSUAL is not set
 
 #
 # USB Input Devices
 #
 CONFIG_USB_HID=y
-CONFIG_USB_HIDINPUT=y
-# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_USB_HID_POWERBOOK is not set
 # CONFIG_HID_FF is not set
 CONFIG_USB_HIDDEV=y
 # CONFIG_USB_AIPTEK is not set
@@ -1250,12 +1379,14 @@ CONFIG_USB_HIDDEV=y
 # CONFIG_USB_KAWETH is not set
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET_MII is not set
 # CONFIG_USB_USBNET is not set
 # CONFIG_USB_MON is not set
 
 #
 # USB port drivers
 #
+# CONFIG_USB_USS720 is not set
 
 #
 # USB Serial Converter support
@@ -1267,6 +1398,7 @@ CONFIG_USB_HIDDEV=y
 #
 # CONFIG_USB_EMI62 is not set
 # CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
@@ -1274,12 +1406,13 @@ CONFIG_USB_HIDDEV=y
 # CONFIG_USB_LED is not set
 # CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
-# CONFIG_USB_PHIDGETKIT is not set
-# CONFIG_USB_PHIDGETSERVO is not set
+# CONFIG_USB_PHIDGET is not set
 # CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
 CONFIG_USB_APPLEDISPLAY=m
 # CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_TEST is not set
 
 #
@@ -1318,6 +1451,9 @@ CONFIG_INFINIBAND=m
 CONFIG_INFINIBAND_ADDR_TRANS=y
 CONFIG_INFINIBAND_MTHCA=m
 CONFIG_INFINIBAND_MTHCA_DEBUG=y
+# CONFIG_INFINIBAND_EHCA is not set
+CONFIG_INFINIBAND_AMSO1100=m
+# CONFIG_INFINIBAND_AMSO1100_DEBUG is not set
 CONFIG_INFINIBAND_IPOIB=m
 CONFIG_INFINIBAND_IPOIB_DEBUG=y
 # CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
@@ -1359,8 +1495,14 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4DEV_FS=m
+CONFIG_EXT4DEV_FS_XATTR=y
+CONFIG_EXT4DEV_FS_POSIX_ACL=y
+CONFIG_EXT4DEV_FS_SECURITY=y
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
+CONFIG_JBD2=m
+# CONFIG_JBD2_DEBUG is not set
 CONFIG_FS_MBCACHE=y
 CONFIG_REISERFS_FS=y
 # CONFIG_REISERFS_CHECK is not set
@@ -1379,7 +1521,11 @@ CONFIG_XFS_FS=m
 CONFIG_XFS_SECURITY=y
 CONFIG_XFS_POSIX_ACL=y
 # CONFIG_XFS_RT is not set
-# CONFIG_OCFS2_FS is not set
+CONFIG_GFS2_FS=m
+# CONFIG_GFS2_FS_LOCKING_NOLOCK is not set
+CONFIG_GFS2_FS_LOCKING_DLM=m
+CONFIG_OCFS2_FS=m
+CONFIG_OCFS2_DEBUG_MASKLOG=y
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 CONFIG_INOTIFY=y
@@ -1389,13 +1535,15 @@ CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 CONFIG_AUTOFS4_FS=m
 # CONFIG_FUSE_FS is not set
+CONFIG_GENERIC_ACL=y
 
 #
 # CD-ROM/DVD Filesystems
 #
 CONFIG_ISO9660_FS=y
-# CONFIG_JOLIET is not set
-# CONFIG_ZISOFS is not set
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_ZISOFS_FS=y
 CONFIG_UDF_FS=m
 CONFIG_UDF_NLS=y
 
@@ -1414,12 +1562,14 @@ CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_HUGETLBFS=y
 CONFIG_HUGETLB_PAGE=y
 CONFIG_RAMFS=y
-# CONFIG_CONFIGFS_FS is not set
+CONFIG_CONFIGFS_FS=m
 
 #
 # Miscellaneous filesystems
@@ -1540,16 +1690,32 @@ CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=m
 
 #
+# Distributed Lock Manager
+#
+CONFIG_DLM=m
+CONFIG_DLM_TCP=y
+# CONFIG_DLM_SCTP is not set
+# CONFIG_DLM_DEBUG is not set
+
+#
+# iSeries device drivers
+#
+# CONFIG_VIOCONS is not set
+CONFIG_VIODASD=y
+CONFIG_VIOCD=y
+CONFIG_VIOTAPE=m
+CONFIG_VIOPATH=y
+
+#
 # Library routines
 #
+CONFIG_BITREVERSE=y
 CONFIG_CRC_CCITT=m
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
 CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=m
-CONFIG_TEXTSEARCH=y
-CONFIG_TEXTSEARCH_KMP=m
 CONFIG_PLIST=y
 
 #
@@ -1563,6 +1729,7 @@ CONFIG_OPROFILE=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
@@ -1581,13 +1748,17 @@ CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_INFO is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 CONFIG_FORCED_INLINING=y
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_DEBUG_STACK_USAGE=y
+CONFIG_HCALL_STATS=y
 CONFIG_DEBUGGER=y
 CONFIG_XMON=y
 # CONFIG_XMON_DEFAULT is not set
+CONFIG_XMON_DISASSEMBLY=y
 CONFIG_IRQSTACKS=y
 CONFIG_BOOTX_TEXT=y
 # CONFIG_PPC_EARLY_DEBUG is not set
@@ -1602,7 +1773,12 @@ CONFIG_BOOTX_TEXT=y
 # Cryptographic options
 #
 CONFIG_CRYPTO=y
-CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_HASH=m
+CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_HMAC=m
+CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MD5=y
@@ -1611,9 +1787,14 @@ CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_TGR192=m
+CONFIG_CRYPTO_GF128MUL=m
+CONFIG_CRYPTO_ECB=m
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_TWOFISH=m
+CONFIG_CRYPTO_TWOFISH_COMMON=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_AES=m
 CONFIG_CRYPTO_CAST5=m
Index: linux-2.6/arch/powerpc/configs/ps3_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/ps3_defconfig
+++ linux-2.6/arch/powerpc/configs/ps3_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.19-rc6
-# Tue Nov 21 19:38:53 2006
+# Linux kernel version: 2.6.19
+# Sat Dec  9 13:49:34 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -10,6 +10,8 @@ CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+CONFIG_ARCH_HAS_ILOG2_U64=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -64,6 +66,7 @@ CONFIG_SYSVIPC=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 # CONFIG_CPUSETS is not set
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -126,6 +129,7 @@ CONFIG_PPC_MULTIPLATFORM=y
 # CONFIG_APUS is not set
 # CONFIG_PPC_PSERIES is not set
 # CONFIG_PPC_ISERIES is not set
+# CONFIG_PPC_MPC52xx is not set
 # CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_MAPLE is not set
 # CONFIG_PPC_PASEMI is not set
@@ -163,6 +167,7 @@ CONFIG_PS3_USE_LPAR_ADDR=y
 #
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
@@ -260,6 +265,7 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
@@ -365,6 +371,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+# CONFIG_SCSI_TGT is not set
 # CONFIG_SCSI_NETLINK is not set
 CONFIG_SCSI_PROC_FS=y
 
@@ -384,6 +391,7 @@ CONFIG_SCSI_PROC_FS=y
 # CONFIG_SCSI_MULTI_LUN is not set
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
 
 #
 # SCSI Transports
@@ -426,6 +434,7 @@ CONFIG_SCSI_PROC_FS=y
 #
 # Macintosh device drivers
 #
+# CONFIG_MAC_EMUMOUSEBTN is not set
 # CONFIG_WINDFARM is not set
 
 #
@@ -548,10 +557,6 @@ CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_HANGCHECK_TIMER is not set
 
@@ -611,6 +616,11 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_SOUND is not set
 
 #
+# HID Devices
+#
+CONFIG_HID=y
+
+#
 # USB support
 #
 # CONFIG_USB_ARCH_HAS_HCD is not set
@@ -771,6 +781,11 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_NLS is not set
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
Index: linux-2.6/arch/powerpc/configs/pseries_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/pseries_defconfig
+++ linux-2.6/arch/powerpc/configs/pseries_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc6
-# Sun Sep 10 10:45:12 2006
+# Linux kernel version: 2.6.19
+# Sun Dec 10 10:17:18 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -10,6 +10,8 @@ CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+CONFIG_ARCH_HAS_ILOG2_U64=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -22,6 +24,7 @@ CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_PPC_OF=y
 CONFIG_PPC_UDBG_16550=y
 # CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=y
 # CONFIG_DEFAULT_UIMAGE is not set
 
 #
@@ -31,6 +34,9 @@ CONFIG_PPC_UDBG_16550=y
 CONFIG_POWER3=y
 CONFIG_POWER4=y
 CONFIG_PPC_FPU=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
+# CONFIG_PPC_OF_PLATFORM_PCI is not set
 CONFIG_ALTIVEC=y
 CONFIG_PPC_STD_MMU=y
 CONFIG_VIRT_CPU_ACCOUNTING=y
@@ -52,19 +58,23 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-CONFIG_SYSCTL=y
+# CONFIG_UTS_NS is not set
 CONFIG_AUDIT=y
 CONFIG_AUDITSYSCALL=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CPUSETS=y
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -73,12 +83,12 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
-CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
 CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
@@ -97,6 +107,7 @@ CONFIG_STOP_MACHINE=y
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
 
 #
@@ -116,15 +127,19 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # Platform support
 #
 CONFIG_PPC_MULTIPLATFORM=y
-# CONFIG_PPC_ISERIES is not set
 # CONFIG_EMBEDDED6xx is not set
 # CONFIG_APUS is not set
 CONFIG_PPC_PSERIES=y
+# CONFIG_PPC_ISERIES is not set
+# CONFIG_PPC_MPC52xx is not set
 # CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_MAPLE is not set
+# CONFIG_PPC_PASEMI is not set
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_IBM_CELL_BLADE is not set
+# CONFIG_PPC_PS3 is not set
+CONFIG_PPC_NATIVE=y
 # CONFIG_UDBG_RTAS_CONSOLE is not set
 CONFIG_XICS=y
 # CONFIG_U3_DART is not set
@@ -137,6 +152,8 @@ CONFIG_IBMVIO=y
 CONFIG_IBMEBUS=y
 # CONFIG_PPC_MPC106 is not set
 # CONFIG_PPC_970_NAP is not set
+# CONFIG_PPC_INDIRECT_IO is not set
+# CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
 # CONFIG_WANT_EARLY_SERIAL is not set
 CONFIG_MPIC=y
@@ -146,6 +163,7 @@ CONFIG_MPIC=y
 #
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
@@ -170,6 +188,7 @@ CONFIG_NODES_SHIFT=4
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
 CONFIG_ARCH_SPARSEMEM_ENABLE=y
 CONFIG_ARCH_SPARSEMEM_DEFAULT=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 # CONFIG_FLATMEM_MANUAL is not set
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -183,7 +202,6 @@ CONFIG_SPARSEMEM_EXTREME=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_MIGRATION=y
 CONFIG_RESOURCES_64BIT=y
-CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
 CONFIG_NODES_SPAN_OTHER_NODES=y
 # CONFIG_PPC_64K_PAGES is not set
 CONFIG_SCHED_SMT=y
@@ -203,6 +221,7 @@ CONFIG_PPC_I8259=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCIEPORTBUS is not set
+# CONFIG_PCI_MULTITHREAD_PROBE is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -235,6 +254,7 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 CONFIG_XFRM_USER=m
+# CONFIG_XFRM_SUB_POLICY is not set
 CONFIG_NET_KEY=m
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -253,10 +273,13 @@ CONFIG_INET_XFRM_TUNNEL=m
 CONFIG_INET_TUNNEL=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
+# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 
 #
 # IP: Virtual Server Configuration
@@ -275,25 +298,30 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK=y
 CONFIG_NETFILTER_NETLINK_QUEUE=m
 CONFIG_NETFILTER_NETLINK_LOG=m
+CONFIG_NF_CONNTRACK_ENABLED=y
+CONFIG_NF_CONNTRACK_SUPPORT=y
+# CONFIG_IP_NF_CONNTRACK_SUPPORT is not set
+CONFIG_NF_CONNTRACK=y
+CONFIG_NF_CT_ACCT=y
+CONFIG_NF_CONNTRACK_MARK=y
+CONFIG_NF_CONNTRACK_EVENTS=y
+CONFIG_NF_CT_PROTO_SCTP=m
+# CONFIG_NF_CONNTRACK_AMANDA is not set
+CONFIG_NF_CONNTRACK_FTP=m
+# CONFIG_NF_CONNTRACK_H323 is not set
+CONFIG_NF_CONNTRACK_IRC=m
+# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
+# CONFIG_NF_CONNTRACK_PPTP is not set
+# CONFIG_NF_CONNTRACK_SIP is not set
+CONFIG_NF_CONNTRACK_TFTP=m
+CONFIG_NF_CT_NETLINK=m
 # CONFIG_NETFILTER_XTABLES is not set
 
 #
 # IP: Netfilter Configuration
 #
-CONFIG_IP_NF_CONNTRACK=m
-CONFIG_IP_NF_CT_ACCT=y
-CONFIG_IP_NF_CONNTRACK_MARK=y
-CONFIG_IP_NF_CONNTRACK_EVENTS=y
-CONFIG_IP_NF_CONNTRACK_NETLINK=m
-CONFIG_IP_NF_CT_PROTO_SCTP=m
-CONFIG_IP_NF_FTP=m
-CONFIG_IP_NF_IRC=m
-# CONFIG_IP_NF_NETBIOS_NS is not set
-CONFIG_IP_NF_TFTP=m
-CONFIG_IP_NF_AMANDA=m
-# CONFIG_IP_NF_PPTP is not set
-# CONFIG_IP_NF_H323 is not set
-# CONFIG_IP_NF_SIP is not set
+CONFIG_NF_CONNTRACK_IPV4=m
+CONFIG_NF_CONNTRACK_PROC_COMPAT=y
 CONFIG_IP_NF_QUEUE=m
 
 #
@@ -320,7 +348,6 @@ CONFIG_LLC=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 
@@ -402,6 +429,12 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
+# Misc devices
+#
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+
+#
 # ATA/ATAPI/MFM/RLL support
 #
 CONFIG_IDE=y
@@ -428,7 +461,6 @@ CONFIG_IDEPCI_SHARE_IRQ=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 CONFIG_BLK_DEV_GENERIC=y
 # CONFIG_BLK_DEV_OPTI621 is not set
-CONFIG_BLK_DEV_SL82C105=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
@@ -443,6 +475,7 @@ CONFIG_BLK_DEV_AMD74XX=y
 # CONFIG_BLK_DEV_CS5530 is not set
 # CONFIG_BLK_DEV_HPT34X is not set
 # CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_JMICRON is not set
 # CONFIG_BLK_DEV_SC1200 is not set
 # CONFIG_BLK_DEV_PIIX is not set
 # CONFIG_BLK_DEV_IT821X is not set
@@ -451,6 +484,7 @@ CONFIG_BLK_DEV_AMD74XX=y
 # CONFIG_BLK_DEV_PDC202XX_NEW is not set
 # CONFIG_BLK_DEV_SVWKS is not set
 # CONFIG_BLK_DEV_SIIMAGE is not set
+CONFIG_BLK_DEV_SL82C105=y
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
 # CONFIG_BLK_DEV_VIA82CXXX is not set
@@ -465,6 +499,8 @@ CONFIG_IDEDMA_AUTO=y
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+CONFIG_SCSI_TGT=m
+CONFIG_SCSI_NETLINK=y
 CONFIG_SCSI_PROC_FS=y
 
 #
@@ -484,19 +520,22 @@ CONFIG_CHR_DEV_SG=y
 CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 # CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
 
 #
-# SCSI Transport Attributes
+# SCSI Transports
 #
 CONFIG_SCSI_SPI_ATTRS=y
-CONFIG_SCSI_FC_ATTRS=y
+CONFIG_SCSI_FC_ATTRS=m
 CONFIG_SCSI_ISCSI_ATTRS=m
 CONFIG_SCSI_SAS_ATTRS=m
+CONFIG_SCSI_SAS_LIBSAS=m
+CONFIG_SCSI_SAS_LIBSAS_DEBUG=y
 
 #
 # SCSI low-level drivers
 #
-# CONFIG_ISCSI_TCP is not set
+CONFIG_ISCSI_TCP=m
 # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
 # CONFIG_SCSI_3W_9XXX is not set
 # CONFIG_SCSI_ACARD is not set
@@ -504,10 +543,12 @@ CONFIG_SCSI_SAS_ATTRS=m
 # CONFIG_SCSI_AIC7XXX is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_AIC79XX is not set
+CONFIG_SCSI_AIC94XX=m
+CONFIG_AIC94XX_DEBUG=y
+# CONFIG_SCSI_ARCMSR is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
-# CONFIG_MEGARAID_SAS is not set
-CONFIG_ATA=y
+CONFIG_MEGARAID_SAS=m
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
@@ -516,10 +557,12 @@ CONFIG_ATA=y
 # CONFIG_SCSI_GDTH is not set
 # CONFIG_SCSI_IPS is not set
 CONFIG_SCSI_IBMVSCSI=y
+CONFIG_SCSI_IBMVSCSIS=m
 # CONFIG_SCSI_INITIO is not set
 # CONFIG_SCSI_INIA100 is not set
 # CONFIG_SCSI_PPA is not set
 # CONFIG_SCSI_IMM is not set
+# CONFIG_SCSI_STEX is not set
 CONFIG_SCSI_SYM53C8XX_2=y
 CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
 CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
@@ -530,10 +573,66 @@ CONFIG_SCSI_IPR_TRACE=y
 CONFIG_SCSI_IPR_DUMP=y
 # CONFIG_SCSI_QLOGIC_1280 is not set
 CONFIG_SCSI_QLA_FC=m
+CONFIG_SCSI_QLA_ISCSI=m
 CONFIG_SCSI_LPFC=m
 # CONFIG_SCSI_DC395x is not set
 # CONFIG_SCSI_DC390T is not set
 # CONFIG_SCSI_DEBUG is not set
+CONFIG_SCSI_SRP=m
+
+#
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+CONFIG_ATA=y
+# CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_SVW is not set
+# CONFIG_ATA_PIIX is not set
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+# CONFIG_SATA_SIL is not set
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
+# CONFIG_PATA_ALI is not set
+# CONFIG_PATA_AMD is not set
+# CONFIG_PATA_ARTOP is not set
+# CONFIG_PATA_ATIIXP is not set
+# CONFIG_PATA_CMD64X is not set
+# CONFIG_PATA_CS5520 is not set
+# CONFIG_PATA_CS5530 is not set
+# CONFIG_PATA_CYPRESS is not set
+# CONFIG_PATA_EFAR is not set
+# CONFIG_ATA_GENERIC is not set
+# CONFIG_PATA_HPT366 is not set
+# CONFIG_PATA_HPT37X is not set
+# CONFIG_PATA_HPT3X2N is not set
+# CONFIG_PATA_HPT3X3 is not set
+# CONFIG_PATA_IT821X is not set
+# CONFIG_PATA_JMICRON is not set
+# CONFIG_PATA_TRIFLEX is not set
+# CONFIG_PATA_MARVELL is not set
+# CONFIG_PATA_MPIIX is not set
+# CONFIG_PATA_OLDPIIX is not set
+# CONFIG_PATA_NETCELL is not set
+# CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_OPTI is not set
+# CONFIG_PATA_OPTIDMA is not set
+# CONFIG_PATA_PDC_OLD is not set
+# CONFIG_PATA_RADISYS is not set
+# CONFIG_PATA_RZ1000 is not set
+# CONFIG_PATA_SC1200 is not set
+# CONFIG_PATA_SERVERWORKS is not set
+# CONFIG_PATA_PDC2027X is not set
+# CONFIG_PATA_SIL680 is not set
+# CONFIG_PATA_SIS is not set
+# CONFIG_PATA_VIA is not set
+# CONFIG_PATA_WINBOND is not set
 
 #
 # Multi-device support (RAID and LVM)
@@ -544,10 +643,12 @@ CONFIG_MD_LINEAR=y
 CONFIG_MD_RAID0=y
 CONFIG_MD_RAID1=y
 CONFIG_MD_RAID10=m
-# CONFIG_MD_RAID456 is not set
+CONFIG_MD_RAID456=m
+CONFIG_MD_RAID5_RESHAPE=y
 CONFIG_MD_MULTIPATH=m
 CONFIG_MD_FAULTY=m
 CONFIG_BLK_DEV_DM=y
+# CONFIG_DM_DEBUG is not set
 CONFIG_DM_CRYPT=m
 CONFIG_DM_SNAPSHOT=m
 CONFIG_DM_MIRROR=m
@@ -576,6 +677,7 @@ CONFIG_DM_MULTIPATH_EMC=m
 #
 # Macintosh device drivers
 #
+# CONFIG_MAC_EMUMOUSEBTN is not set
 # CONFIG_WINDFARM is not set
 
 #
@@ -617,6 +719,7 @@ CONFIG_VORTEX=y
 CONFIG_IBMVETH=y
 CONFIG_NET_PCI=y
 CONFIG_PCNET32=y
+CONFIG_PCNET32_NAPI=y
 # CONFIG_AMD8111_ETH is not set
 # CONFIG_ADAPTEC_STARFIRE is not set
 # CONFIG_B44 is not set
@@ -655,17 +758,19 @@ CONFIG_E1000=y
 # CONFIG_VIA_VELOCITY is not set
 CONFIG_TIGON3=y
 # CONFIG_BNX2 is not set
-# CONFIG_MV643XX_ETH is not set
+# CONFIG_QLA3XXX is not set
 
 #
 # Ethernet (10000 Mbit)
 #
 # CONFIG_CHELSIO_T1 is not set
+CONFIG_EHEA=y
 CONFIG_IXGB=m
 # CONFIG_IXGB_NAPI is not set
 CONFIG_S2IO=m
 # CONFIG_S2IO_NAPI is not set
 # CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
 
 #
 # Token Ring devices
@@ -697,6 +802,7 @@ CONFIG_PPP_BSDCOMP=m
 # CONFIG_PPP_MPPE is not set
 CONFIG_PPPOE=m
 # CONFIG_SLIP is not set
+CONFIG_SLHC=m
 # CONFIG_NET_FC is not set
 # CONFIG_SHAPER is not set
 CONFIG_NETCONSOLE=y
@@ -719,6 +825,7 @@ CONFIG_NET_POLL_CONTROLLER=y
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -741,6 +848,7 @@ CONFIG_KEYBOARD_ATKBD=y
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
 CONFIG_INPUT_MOUSE=y
 CONFIG_MOUSE_PS2=y
 # CONFIG_MOUSE_SERIAL is not set
@@ -815,10 +923,6 @@ CONFIG_GEN_RTC=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 CONFIG_RAW_DRIVER=y
@@ -829,7 +933,6 @@ CONFIG_MAX_RAW_DEVS=1024
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-# CONFIG_TELCLOCK is not set
 
 #
 # I2C support
@@ -894,6 +997,7 @@ CONFIG_I2C_ALGOBIT=y
 #
 # Dallas's 1-wire bus
 #
+# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -902,14 +1006,9 @@ CONFIG_I2C_ALGOBIT=y
 # CONFIG_HWMON_VID is not set
 
 #
-# Misc devices
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -922,6 +1021,7 @@ CONFIG_VIDEO_V4L2=y
 #
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB=y
+CONFIG_FB_DDC=y
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
@@ -989,6 +1089,11 @@ CONFIG_LCD_DEVICE=y
 # CONFIG_SOUND is not set
 
 #
+# HID Devices
+#
+CONFIG_HID=y
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -1003,6 +1108,7 @@ CONFIG_USB=y
 CONFIG_USB_DEVICEFS=y
 # CONFIG_USB_BANDWIDTH is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_MULTITHREAD_PROBE is not set
 # CONFIG_USB_OTG is not set
 
 #
@@ -1043,14 +1149,14 @@ CONFIG_USB_STORAGE=y
 # CONFIG_USB_STORAGE_SDDR55 is not set
 # CONFIG_USB_STORAGE_JUMPSHOT is not set
 # CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_KARMA is not set
 # CONFIG_USB_LIBUSUAL is not set
 
 #
 # USB Input Devices
 #
 CONFIG_USB_HID=y
-CONFIG_USB_HIDINPUT=y
-# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_USB_HID_POWERBOOK is not set
 # CONFIG_HID_FF is not set
 CONFIG_USB_HIDDEV=y
 # CONFIG_USB_AIPTEK is not set
@@ -1079,6 +1185,7 @@ CONFIG_USB_HIDDEV=y
 # CONFIG_USB_KAWETH is not set
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET_MII is not set
 # CONFIG_USB_USBNET is not set
 CONFIG_USB_MON=y
 
@@ -1097,6 +1204,7 @@ CONFIG_USB_MON=y
 #
 # CONFIG_USB_EMI62 is not set
 # CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
@@ -1104,12 +1212,13 @@ CONFIG_USB_MON=y
 # CONFIG_USB_LED is not set
 # CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
-# CONFIG_USB_PHIDGETKIT is not set
-# CONFIG_USB_PHIDGETSERVO is not set
+# CONFIG_USB_PHIDGET is not set
 # CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
 # CONFIG_USB_APPLEDISPLAY is not set
 # CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_TEST is not set
 
 #
@@ -1148,6 +1257,10 @@ CONFIG_INFINIBAND_USER_ACCESS=m
 CONFIG_INFINIBAND_ADDR_TRANS=y
 CONFIG_INFINIBAND_MTHCA=m
 CONFIG_INFINIBAND_MTHCA_DEBUG=y
+CONFIG_INFINIBAND_EHCA=m
+CONFIG_INFINIBAND_EHCA_SCALING=y
+CONFIG_INFINIBAND_AMSO1100=m
+# CONFIG_INFINIBAND_AMSO1100_DEBUG is not set
 CONFIG_INFINIBAND_IPOIB=m
 CONFIG_INFINIBAND_IPOIB_DEBUG=y
 # CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
@@ -1189,6 +1302,7 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
@@ -1209,6 +1323,7 @@ CONFIG_XFS_FS=m
 CONFIG_XFS_SECURITY=y
 CONFIG_XFS_POSIX_ACL=y
 # CONFIG_XFS_RT is not set
+# CONFIG_GFS2_FS is not set
 CONFIG_OCFS2_FS=m
 CONFIG_OCFS2_DEBUG_MASKLOG=y
 # CONFIG_MINIX_FS is not set
@@ -1246,8 +1361,10 @@ CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 CONFIG_HUGETLBFS=y
 CONFIG_HUGETLB_PAGE=y
 CONFIG_RAMFS=y
@@ -1357,16 +1474,20 @@ CONFIG_NLS_ISO8859_1=y
 # CONFIG_NLS_UTF8 is not set
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Library routines
 #
+CONFIG_BITREVERSE=y
 CONFIG_CRC_CCITT=m
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
 CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=m
-CONFIG_TEXTSEARCH=y
-CONFIG_TEXTSEARCH_KMP=m
 CONFIG_PLIST=y
 
 #
@@ -1380,6 +1501,7 @@ CONFIG_KPROBES=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
@@ -1398,13 +1520,18 @@ CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_DEBUG_INFO is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 CONFIG_FORCED_INLINING=y
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_RCU_TORTURE_TEST is not set
+CONFIG_LKDTM=m
 CONFIG_DEBUG_STACKOVERFLOW=y
 # CONFIG_DEBUG_STACK_USAGE is not set
+CONFIG_HCALL_STATS=y
 CONFIG_DEBUGGER=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
+CONFIG_XMON_DISASSEMBLY=y
 CONFIG_IRQSTACKS=y
 # CONFIG_BOOTX_TEXT is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
@@ -1419,7 +1546,12 @@ CONFIG_IRQSTACKS=y
 # Cryptographic options
 #
 CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_HMAC=y
+# CONFIG_CRYPTO_XCBC is not set
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MD5=y
@@ -1428,9 +1560,14 @@ CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_TGR192=m
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_ECB is not set
+CONFIG_CRYPTO_CBC=y
+# CONFIG_CRYPTO_LRW is not set
 CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_TWOFISH=m
+CONFIG_CRYPTO_TWOFISH_COMMON=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_AES=m
 CONFIG_CRYPTO_CAST5=m
Index: linux-2.6/arch/ppc/configs/prep_defconfig
===================================================================
--- linux-2.6.orig/arch/ppc/configs/prep_defconfig
+++ linux-2.6/arch/ppc/configs/prep_defconfig
@@ -1,11 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc6
-# Wed Sep  6 15:09:32 2006
+# Linux kernel version: 2.6.19
+# Sun Dec 10 10:13:53 2006
 #
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+# CONFIG_ARCH_HAS_ILOG2_U64 is not set
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_PPC=y
@@ -14,6 +16,7 @@ CONFIG_GENERIC_NVRAM=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+CONFIG_GENERIC_BUG=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -30,17 +33,21 @@ CONFIG_LOCALVERSION="-prep"
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-CONFIG_SYSCTL=y
+# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
+# CONFIG_SYSFS_DEPRECATED is not set
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -49,12 +56,12 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
-CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
 CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
@@ -72,6 +79,7 @@ CONFIG_KMOD=y
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 CONFIG_LBD=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
@@ -99,6 +107,7 @@ CONFIG_6xx=y
 # CONFIG_E200 is not set
 # CONFIG_E500 is not set
 CONFIG_PPC_FPU=y
+# CONFIG_PPC_DCR_NATIVE is not set
 # CONFIG_ALTIVEC is not set
 # CONFIG_TAU is not set
 # CONFIG_KEXEC is not set
@@ -142,8 +151,10 @@ CONFIG_PPC_PREP=y
 CONFIG_PPCBUG_NVRAM=y
 # CONFIG_SMP is not set
 # CONFIG_HIGHMEM is not set
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
@@ -166,6 +177,7 @@ CONFIG_PROC_PREPRESIDUAL=y
 CONFIG_PM=y
 # CONFIG_PM_LEGACY is not set
 # CONFIG_PM_DEBUG is not set
+# CONFIG_PM_SYSFS_DEPRECATED is not set
 CONFIG_SOFTWARE_SUSPEND=y
 CONFIG_PM_STD_PARTITION=""
 # CONFIG_SECCOMP is not set
@@ -180,6 +192,7 @@ CONFIG_PPC_I8259=y
 CONFIG_PPC_INDIRECT_PCI=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
+# CONFIG_PCI_MULTITHREAD_PROBE is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -246,9 +259,12 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 
 #
 # IP: Virtual Server Configuration
@@ -267,14 +283,34 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK=m
 CONFIG_NETFILTER_NETLINK_QUEUE=m
 CONFIG_NETFILTER_NETLINK_LOG=m
+CONFIG_NF_CONNTRACK_ENABLED=m
+CONFIG_NF_CONNTRACK_SUPPORT=y
+# CONFIG_IP_NF_CONNTRACK_SUPPORT is not set
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_CT_ACCT=y
+CONFIG_NF_CONNTRACK_MARK=y
+# CONFIG_NF_CONNTRACK_EVENTS is not set
+# CONFIG_NF_CT_PROTO_SCTP is not set
+# CONFIG_NF_CONNTRACK_AMANDA is not set
+CONFIG_NF_CONNTRACK_FTP=m
+# CONFIG_NF_CONNTRACK_H323 is not set
+CONFIG_NF_CONNTRACK_IRC=m
+# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
+# CONFIG_NF_CONNTRACK_PPTP is not set
+# CONFIG_NF_CONNTRACK_SIP is not set
+CONFIG_NF_CONNTRACK_TFTP=m
+CONFIG_NF_CT_NETLINK=m
 CONFIG_NETFILTER_XTABLES=m
 CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 CONFIG_NETFILTER_XT_TARGET_MARK=m
 CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
+# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
 CONFIG_NETFILTER_XT_MATCH_COMMENT=m
+CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
 CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
 CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
 CONFIG_NETFILTER_XT_MATCH_DCCP=m
+# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
 CONFIG_NETFILTER_XT_MATCH_ESP=m
 CONFIG_NETFILTER_XT_MATCH_HELPER=m
 CONFIG_NETFILTER_XT_MATCH_LENGTH=m
@@ -290,24 +326,13 @@ CONFIG_NETFILTER_XT_MATCH_STATE=m
 CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
 CONFIG_NETFILTER_XT_MATCH_STRING=m
 CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
+# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
 
 #
 # IP: Netfilter Configuration
 #
-CONFIG_IP_NF_CONNTRACK=m
-# CONFIG_IP_NF_CT_ACCT is not set
-CONFIG_IP_NF_CONNTRACK_MARK=y
-# CONFIG_IP_NF_CONNTRACK_EVENTS is not set
-# CONFIG_IP_NF_CONNTRACK_NETLINK is not set
-# CONFIG_IP_NF_CT_PROTO_SCTP is not set
-CONFIG_IP_NF_FTP=m
-CONFIG_IP_NF_IRC=m
-# CONFIG_IP_NF_NETBIOS_NS is not set
-CONFIG_IP_NF_TFTP=m
-CONFIG_IP_NF_AMANDA=m
-# CONFIG_IP_NF_PPTP is not set
-# CONFIG_IP_NF_H323 is not set
-# CONFIG_IP_NF_SIP is not set
+CONFIG_NF_CONNTRACK_IPV4=m
+CONFIG_NF_CONNTRACK_PROC_COMPAT=y
 CONFIG_IP_NF_QUEUE=m
 # CONFIG_IP_NF_IPTABLES is not set
 # CONFIG_IP_NF_ARPTABLES is not set
@@ -335,7 +360,6 @@ CONFIG_IP_NF_QUEUE=m
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 
@@ -420,6 +444,12 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
+# Misc devices
+#
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+
+#
 # ATA/ATAPI/MFM/RLL support
 #
 CONFIG_IDE=y
@@ -446,7 +476,6 @@ CONFIG_IDEPCI_SHARE_IRQ=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 CONFIG_BLK_DEV_GENERIC=y
 # CONFIG_BLK_DEV_OPTI621 is not set
-CONFIG_BLK_DEV_SL82C105=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
@@ -461,6 +490,7 @@ CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_BLK_DEV_CS5530 is not set
 # CONFIG_BLK_DEV_HPT34X is not set
 # CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_JMICRON is not set
 # CONFIG_BLK_DEV_SC1200 is not set
 # CONFIG_BLK_DEV_PIIX is not set
 # CONFIG_BLK_DEV_IT821X is not set
@@ -469,6 +499,7 @@ CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_BLK_DEV_PDC202XX_NEW is not set
 # CONFIG_BLK_DEV_SVWKS is not set
 # CONFIG_BLK_DEV_SIIMAGE is not set
+CONFIG_BLK_DEV_SL82C105=y
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
 # CONFIG_BLK_DEV_VIA82CXXX is not set
@@ -484,6 +515,8 @@ CONFIG_IDEDMA_AUTO=y
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+# CONFIG_SCSI_TGT is not set
+# CONFIG_SCSI_NETLINK is not set
 CONFIG_SCSI_PROC_FS=y
 
 #
@@ -503,14 +536,16 @@ CONFIG_CHR_DEV_SG=y
 # CONFIG_SCSI_MULTI_LUN is not set
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
+# CONFIG_SCSI_SCAN_ASYNC is not set
 
 #
-# SCSI Transport Attributes
+# SCSI Transports
 #
 CONFIG_SCSI_SPI_ATTRS=y
 # CONFIG_SCSI_FC_ATTRS is not set
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
 
 #
 # SCSI low-level drivers
@@ -526,12 +561,13 @@ CONFIG_SCSI_SPI_ATTRS=y
 # CONFIG_SCSI_AIC7XXX is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC94XX is not set
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_IN2000 is not set
+# CONFIG_SCSI_ARCMSR is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
@@ -547,17 +583,18 @@ CONFIG_SCSI_SPI_ATTRS=y
 # CONFIG_SCSI_PPA is not set
 # CONFIG_SCSI_IMM is not set
 # CONFIG_SCSI_NCR53C406A is not set
+# CONFIG_SCSI_STEX is not set
 CONFIG_SCSI_SYM53C8XX_2=y
 CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
 CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
 CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
 CONFIG_SCSI_SYM53C8XX_MMIO=y
-# CONFIG_SCSI_IPR is not set
 # CONFIG_SCSI_PAS16 is not set
 # CONFIG_SCSI_PSI240I is not set
 # CONFIG_SCSI_QLOGIC_FAS is not set
 # CONFIG_SCSI_QLOGIC_1280 is not set
 # CONFIG_SCSI_QLA_FC is not set
+# CONFIG_SCSI_QLA_ISCSI is not set
 # CONFIG_SCSI_LPFC is not set
 # CONFIG_SCSI_SYM53C416 is not set
 # CONFIG_SCSI_DC395x is not set
@@ -566,6 +603,12 @@ CONFIG_SCSI_SYM53C8XX_MMIO=y
 # CONFIG_SCSI_U14_34F is not set
 # CONFIG_SCSI_NSP32 is not set
 # CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_SRP is not set
+
+#
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+# CONFIG_ATA is not set
 
 #
 # Old CD-ROM drivers (not SCSI, not IDE)
@@ -622,6 +665,7 @@ CONFIG_IEEE1394_RAWIO=m
 #
 # Macintosh device drivers
 #
+# CONFIG_MAC_EMUMOUSEBTN is not set
 # CONFIG_WINDFARM is not set
 
 #
@@ -677,6 +721,7 @@ CONFIG_DE4X5=m
 # CONFIG_NET_ISA is not set
 CONFIG_NET_PCI=y
 CONFIG_PCNET32=y
+CONFIG_PCNET32_NAPI=y
 # CONFIG_AMD8111_ETH is not set
 # CONFIG_ADAPTEC_STARFIRE is not set
 # CONFIG_AC3200 is not set
@@ -716,6 +761,7 @@ CONFIG_PCNET32=y
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
+# CONFIG_QLA3XXX is not set
 
 #
 # Ethernet (10000 Mbit)
@@ -724,6 +770,7 @@ CONFIG_PCNET32=y
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
 
 #
 # Token Ring devices
@@ -781,6 +828,7 @@ CONFIG_PPP_BSDCOMP=m
 # CONFIG_PPP_MPPE is not set
 CONFIG_PPPOE=m
 # CONFIG_SLIP is not set
+CONFIG_SLHC=y
 # CONFIG_NET_FC is not set
 # CONFIG_SHAPER is not set
 CONFIG_NETCONSOLE=m
@@ -803,6 +851,7 @@ CONFIG_NET_POLL_CONTROLLER=y
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -825,6 +874,7 @@ CONFIG_KEYBOARD_ATKBD=y
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
 CONFIG_INPUT_MOUSE=y
 CONFIG_MOUSE_PS2=y
 # CONFIG_MOUSE_SERIAL is not set
@@ -872,6 +922,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 #
 # Non-8250 serial port support
 #
+# CONFIG_SERIAL_UARTLITE is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
@@ -898,10 +949,6 @@ CONFIG_GEN_RTC=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -910,7 +957,6 @@ CONFIG_GEN_RTC=y
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-# CONFIG_TELCLOCK is not set
 
 #
 # I2C support
@@ -978,6 +1024,7 @@ CONFIG_I2C_ALGOBIT=y
 #
 # Dallas's 1-wire bus
 #
+# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -986,14 +1033,9 @@ CONFIG_I2C_ALGOBIT=y
 # CONFIG_HWMON_VID is not set
 
 #
-# Misc devices
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -1006,6 +1048,7 @@ CONFIG_VIDEO_V4L2=y
 #
 # CONFIG_FIRMWARE_EDID is not set
 CONFIG_FB=y
+# CONFIG_FB_DDC is not set
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
@@ -1098,6 +1141,7 @@ CONFIG_SND_OPL3_LIB=m
 # CONFIG_SND_DUMMY is not set
 # CONFIG_SND_VIRMIDI is not set
 # CONFIG_SND_MTPAV is not set
+# CONFIG_SND_MTS64 is not set
 # CONFIG_SND_SERIAL_U16550 is not set
 # CONFIG_SND_MPU401 is not set
 
@@ -1193,12 +1237,6 @@ CONFIG_SND_CS4232=m
 #
 
 #
-# Apple Onboard Audio driver
-#
-# CONFIG_SND_AOA is not set
-# CONFIG_SND_AOA_SOUNDBUS is not set
-
-#
 # USB devices
 #
 CONFIG_SND_USB_AUDIO=m
@@ -1210,6 +1248,11 @@ CONFIG_SND_USB_AUDIO=m
 # CONFIG_SOUND_PRIME is not set
 
 #
+# HID Devices
+#
+CONFIG_HID=y
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -1225,6 +1268,7 @@ CONFIG_USB_DEVICEFS=y
 # CONFIG_USB_BANDWIDTH is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
 # CONFIG_USB_SUSPEND is not set
+# CONFIG_USB_MULTITHREAD_PROBE is not set
 # CONFIG_USB_OTG is not set
 
 #
@@ -1265,14 +1309,14 @@ CONFIG_USB_STORAGE_SDDR09=y
 CONFIG_USB_STORAGE_SDDR55=y
 CONFIG_USB_STORAGE_JUMPSHOT=y
 # CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_KARMA is not set
 # CONFIG_USB_LIBUSUAL is not set
 
 #
 # USB Input Devices
 #
 CONFIG_USB_HID=y
-CONFIG_USB_HIDINPUT=y
-# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_USB_HID_POWERBOOK is not set
 # CONFIG_HID_FF is not set
 CONFIG_USB_HIDDEV=y
 # CONFIG_USB_AIPTEK is not set
@@ -1301,6 +1345,7 @@ CONFIG_USB_HIDDEV=y
 # CONFIG_USB_KAWETH is not set
 CONFIG_USB_PEGASUS=m
 # CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET_MII is not set
 # CONFIG_USB_USBNET is not set
 # CONFIG_USB_MON is not set
 
@@ -1314,6 +1359,7 @@ CONFIG_USB_PEGASUS=m
 #
 CONFIG_USB_SERIAL=m
 # CONFIG_USB_SERIAL_GENERIC is not set
+# CONFIG_USB_SERIAL_AIRCABLE is not set
 # CONFIG_USB_SERIAL_AIRPRIME is not set
 # CONFIG_USB_SERIAL_ARK3116 is not set
 # CONFIG_USB_SERIAL_BELKIN is not set
@@ -1348,6 +1394,8 @@ CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
 # CONFIG_USB_SERIAL_KLSI is not set
 # CONFIG_USB_SERIAL_KOBIL_SCT is not set
 # CONFIG_USB_SERIAL_MCT_U232 is not set
+# CONFIG_USB_SERIAL_MOS7720 is not set
+# CONFIG_USB_SERIAL_MOS7840 is not set
 # CONFIG_USB_SERIAL_NAVMAN is not set
 # CONFIG_USB_SERIAL_PL2303 is not set
 # CONFIG_USB_SERIAL_HP4X is not set
@@ -1358,6 +1406,7 @@ CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
 # CONFIG_USB_SERIAL_XIRCOM is not set
 # CONFIG_USB_SERIAL_OPTION is not set
 # CONFIG_USB_SERIAL_OMNINET is not set
+# CONFIG_USB_SERIAL_DEBUG is not set
 CONFIG_USB_EZUSB=y
 
 #
@@ -1365,6 +1414,7 @@ CONFIG_USB_EZUSB=y
 #
 # CONFIG_USB_EMI62 is not set
 # CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
@@ -1372,12 +1422,13 @@ CONFIG_USB_EZUSB=y
 # CONFIG_USB_LED is not set
 # CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
-# CONFIG_USB_PHIDGETKIT is not set
-# CONFIG_USB_PHIDGETSERVO is not set
+# CONFIG_USB_PHIDGET is not set
 # CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
 # CONFIG_USB_APPLEDISPLAY is not set
 # CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_TEST is not set
 
 #
@@ -1446,6 +1497,7 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
@@ -1466,6 +1518,7 @@ CONFIG_XFS_FS=m
 CONFIG_XFS_SECURITY=y
 CONFIG_XFS_POSIX_ACL=y
 # CONFIG_XFS_RT is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -1501,8 +1554,10 @@ CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -1621,8 +1676,14 @@ CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=m
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Library routines
 #
+CONFIG_BITREVERSE=y
 CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
@@ -1640,6 +1701,7 @@ CONFIG_PLIST=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
@@ -1655,10 +1717,13 @@ CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 CONFIG_FORCED_INLINING=y
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_XMON is not set
 # CONFIG_BDI_SWITCH is not set
@@ -1673,7 +1738,3 @@ CONFIG_FORCED_INLINING=y
 # Cryptographic options
 #
 # CONFIG_CRYPTO is not set
-
-#
-# Hardware crypto devices
-#
