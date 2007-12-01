Return-Path: <SRS0=wK9d=QY=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 90905DDDFF
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 21:25:28 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] 4xx: Add EMAC support to Kilauea defconfig
Date: Sat,  1 Dec 2007 11:25:29 +0100
Message-Id: <1196504729-24431-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/configs/kilauea_defconfig |  717 ++++++++++++++++++++++++--------
 1 files changed, 533 insertions(+), 184 deletions(-)

diff --git a/arch/powerpc/configs/kilauea_defconfig b/arch/powerpc/configs/kilauea_defconfig
index fd1c530..1340871 100644
--- a/arch/powerpc/configs/kilauea_defconfig
+++ b/arch/powerpc/configs/kilauea_defconfig
@@ -1,53 +1,22 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc9
-# Thu Oct 11 19:05:15 2007
+# Linux kernel version: 2.6.23
+# Sat Dec  1 07:52:20 2007
 #
-# CONFIG_PPC64 is not set
-
-#
-# Processor support
-#
-# CONFIG_6xx is not set
-# CONFIG_PPC_85xx is not set
-# CONFIG_PPC_8xx is not set
-CONFIG_40x=y
-# CONFIG_44x is not set
-# CONFIG_E200 is not set
-CONFIG_4xx=y
-# CONFIG_PPC_MM_SLICES is not set
-CONFIG_NOT_COHERENT_CACHE=y
-CONFIG_PPC32=y
-CONFIG_WORD_SIZE=32
-CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
-CONFIG_GENERIC_CMOS_UPDATE=y
-CONFIG_GENERIC_TIME=y
-CONFIG_GENERIC_TIME_VSYSCALL=y
-CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_HARDIRQS=y
-CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_ARCH_HAS_ILOG2_U32=y
+# CONFIG_ARCH_HAS_ILOG2_U64 is not set
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
-CONFIG_GENERIC_FIND_NEXT_BIT=y
-# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
 CONFIG_PPC=y
-CONFIG_EARLY_PRINTK=y
+CONFIG_PPC32=y
 CONFIG_GENERIC_NVRAM=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_ARCH_MAY_HAVE_PC_FDC=y
-CONFIG_PPC_OF=y
-CONFIG_OF=y
-# CONFIG_PPC_UDBG_16550 is not set
-# CONFIG_GENERIC_TBSYNC is not set
-CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
-# CONFIG_DEFAULT_UIMAGE is not set
-CONFIG_PPC_DCR_NATIVE=y
-# CONFIG_PPC_DCR_MMIO is not set
-CONFIG_PPC_DCR=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -76,24 +45,22 @@ CONFIG_INITRAMFS_SOURCE=""
 CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
-CONFIG_KALLSYMS=y
-CONFIG_KALLSYMS_ALL=y
-CONFIG_KALLSYMS_EXTRA_PASS=y
-CONFIG_HOTPLUG=y
+# CONFIG_KALLSYMS is not set
+# CONFIG_HOTPLUG is not set
 CONFIG_PRINTK=y
+# CONFIG_LOGBUFFER is not set
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
-CONFIG_EPOLL=y
+# CONFIG_EPOLL is not set
 CONFIG_SIGNALFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLUB_DEBUG=y
-# CONFIG_SLAB is not set
-CONFIG_SLUB=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -105,7 +72,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
 CONFIG_BLOCK=y
-CONFIG_LBD=y
+# CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
 # CONFIG_BLK_DEV_BSG is not set
@@ -124,36 +91,58 @@ CONFIG_DEFAULT_AS=y
 CONFIG_DEFAULT_IOSCHED="anticipatory"
 
 #
-# Platform support
+# Processor
+#
+# CONFIG_6xx is not set
+CONFIG_40x=y
+# CONFIG_44x is not set
+# CONFIG_8xx is not set
+# CONFIG_E200 is not set
+# CONFIG_E500 is not set
+CONFIG_PPC_DCR_NATIVE=y
+CONFIG_PPC_DCR=y
+# CONFIG_MATH_EMULATION is not set
+# CONFIG_KEXEC is not set
+# CONFIG_CPU_FREQ is not set
+CONFIG_4xx=y
+CONFIG_WANT_EARLY_SERIAL=y
+
+#
+# IBM 4xx options
 #
-# CONFIG_PPC_MPC52xx is not set
-# CONFIG_PPC_MPC5200 is not set
-# CONFIG_PPC_CELL is not set
-# CONFIG_PPC_CELL_NATIVE is not set
-# CONFIG_PQ2ADS is not set
+# CONFIG_ACADIA is not set
+# CONFIG_BUBINGA is not set
+# CONFIG_CPCI405 is not set
+# CONFIG_EP405 is not set
 CONFIG_KILAUEA=y
+# CONFIG_MAKALU is not set
+# CONFIG_PPChameleonEVB is not set
+# CONFIG_REDWOOD_5 is not set
+# CONFIG_REDWOOD_6 is not set
+# CONFIG_SC3 is not set
+# CONFIG_SYCAMORE is not set
+# CONFIG_TAIHU is not set
 # CONFIG_WALNUT is not set
-# CONFIG_XILINX_VIRTEX_GENERIC_BOARD is not set
-# CONFIG_MPIC is not set
-# CONFIG_MPIC_WEIRD is not set
-# CONFIG_PPC_I8259 is not set
-# CONFIG_PPC_RTAS is not set
-# CONFIG_MMIO_NVRAM is not set
-# CONFIG_PPC_MPC106 is not set
-# CONFIG_PPC_970_NAP is not set
-# CONFIG_PPC_INDIRECT_IO is not set
-# CONFIG_GENERIC_IOMAP is not set
-# CONFIG_CPU_FREQ is not set
-# CONFIG_CPM2 is not set
-# CONFIG_FSL_ULI1575 is not set
+# CONFIG_XILINX_ML300 is not set
+# CONFIG_XILINX_ML403 is not set
+CONFIG_IBM405_ERR77=y
+CONFIG_IBM405_ERR51=y
+CONFIG_IBM_OCP=y
+CONFIG_IBM_EMAC4=y
+CONFIG_IBM_EMAC4V4=y
+CONFIG_405EX=y
+# CONFIG_PPC4xx_DMA is not set
+CONFIG_PPC_GEN550=y
+CONFIG_UART0_TTYS0=y
+# CONFIG_UART0_TTYS1 is not set
+CONFIG_NOT_COHERENT_CACHE=y
 
 #
-# Kernel options
+# Platform options
 #
+# CONFIG_PC_KEYBOARD is not set
 # CONFIG_HIGHMEM is not set
-# CONFIG_TICK_ONESHOT is not set
-# CONFIG_NO_HZ is not set
-# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
 # CONFIG_HZ_300 is not set
@@ -162,12 +151,6 @@ CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
-CONFIG_BINFMT_ELF=y
-# CONFIG_BINFMT_MISC is not set
-# CONFIG_MATH_EMULATION is not set
-CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
-CONFIG_ARCH_FLATMEM_ENABLE=y
-CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -180,29 +163,38 @@ CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_ZONE_DMA_FLAG=1
 CONFIG_BOUNCE=y
 CONFIG_VIRT_TO_BUS=y
-CONFIG_PROC_DEVICETREE=y
-# CONFIG_CMDLINE_BOOL is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="ip=on"
 # CONFIG_PM is not set
 CONFIG_SUSPEND_UP_POSSIBLE=y
 CONFIG_HIBERNATION_UP_POSSIBLE=y
 CONFIG_SECCOMP=y
-CONFIG_WANT_DEVICE_TREE=y
-CONFIG_DEVICE_TREE="kilauea.dts"
+CONFIG_PPC_PAGE_4K=y
+# CONFIG_PPC_PAGE_16K is not set
+# CONFIG_PPC_PAGE_64K is not set
 CONFIG_ISA_DMA_API=y
 
 #
 # Bus options
 #
 CONFIG_ZONE_DMA=y
-# CONFIG_PCI is not set
-# CONFIG_PCI_DOMAINS is not set
-# CONFIG_PCI_SYSCALL is not set
+# CONFIG_PPC_I8259 is not set
+CONFIG_PPC_INDIRECT_PCI=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_SYSCALL=y
 # CONFIG_ARCH_SUPPORTS_MSI is not set
+# CONFIG_PCI_DEBUG is not set
 
 #
 # PCCARD (PCMCIA/CardBus) support
 #
-# CONFIG_PCCARD is not set
+
+#
+# PCI Express support
+#
 
 #
 # Advanced setup
@@ -231,27 +223,32 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
-# CONFIG_IP_MULTICAST is not set
+CONFIG_IP_MULTICAST=y
 # CONFIG_IP_ADVANCED_ROUTER is not set
 CONFIG_IP_FIB_HASH=y
 CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
+# CONFIG_IP_PNP_DHCP is not set
 CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IP_PNP_RARP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
 # CONFIG_ARPD is not set
-# CONFIG_SYN_COOKIES is not set
+CONFIG_SYN_COOKIES=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -288,6 +285,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
@@ -309,17 +307,15 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # Generic Driver Options
 #
-CONFIG_STANDALONE=y
+# CONFIG_STANDALONE is not set
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-CONFIG_FW_LOADER=y
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
-CONFIG_CONNECTOR=y
-CONFIG_PROC_EVENTS=y
+# CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
-# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_CONCAT=y
 CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_REDBOOT_PARTS is not set
 CONFIG_MTD_CMDLINE_PARTS=y
@@ -328,9 +324,8 @@ CONFIG_MTD_CMDLINE_PARTS=y
 # User Modules And Translation Layers
 #
 CONFIG_MTD_CHAR=y
-CONFIG_MTD_BLKDEVS=m
-CONFIG_MTD_BLOCK=m
-# CONFIG_MTD_BLOCK_RO is not set
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
 # CONFIG_FTL is not set
 # CONFIG_NFTL is not set
 # CONFIG_INFTL is not set
@@ -341,7 +336,7 @@ CONFIG_MTD_BLOCK=m
 # RAM/ROM/Flash chip drivers
 #
 CONFIG_MTD_CFI=y
-CONFIG_MTD_JEDECPROBE=y
+# CONFIG_MTD_JEDECPROBE is not set
 CONFIG_MTD_GEN_PROBE=y
 # CONFIG_MTD_CFI_ADV_OPTIONS is not set
 CONFIG_MTD_MAP_BANK_WIDTH_1=y
@@ -366,13 +361,16 @@ CONFIG_MTD_CFI_UTIL=y
 # Mapping drivers for chip access
 #
 # CONFIG_MTD_COMPLEX_MAPPINGS is not set
-# CONFIG_MTD_PHYSMAP is not set
-CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_START=0x8000000
+CONFIG_MTD_PHYSMAP_LEN=0x0
+CONFIG_MTD_PHYSMAP_BANKWIDTH=2
 # CONFIG_MTD_PLATRAM is not set
 
 #
 # Self-contained MTD device drivers
 #
+# CONFIG_MTD_PMC551 is not set
 # CONFIG_MTD_SLRAM is not set
 # CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
@@ -384,23 +382,38 @@ CONFIG_MTD_PHYSMAP_OF=y
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
-# CONFIG_MTD_NAND is not set
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_VERIFY_WRITE=y
+CONFIG_MTD_NAND_ECC_SMC=y
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+# CONFIG_MTD_NAND_RB500 is not set
+CONFIG_MTD_NAND_IDS=y
+CONFIG_MTD_NAND_NDFC=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_CAFE is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_MTD_NAND_PLATFORM is not set
 # CONFIG_MTD_ONENAND is not set
 
 #
 # UBI - Unsorted block images
 #
 # CONFIG_MTD_UBI is not set
-CONFIG_OF_DEVICE=y
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
 # CONFIG_BLK_DEV_COW_COMMON is not set
-# CONFIG_BLK_DEV_LOOP is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
-CONFIG_BLK_DEV_RAM_SIZE=35000
+CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
@@ -412,11 +425,90 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # SCSI device support
 #
 # CONFIG_RAID_ATTRS is not set
-# CONFIG_SCSI is not set
-# CONFIG_SCSI_DMA is not set
+CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
+# CONFIG_SCSI_TGT is not set
 # CONFIG_SCSI_NETLINK is not set
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=y
+# CONFIG_CHR_DEV_ST is not set
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
+# CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m
+
+#
+# SCSI Transports
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
+CONFIG_SCSI_LOWLEVEL=y
+# CONFIG_ISCSI_TCP is not set
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC94XX is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_ARCMSR is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_MEGARAID_SAS is not set
+# CONFIG_SCSI_HPTIOP is not set
+# CONFIG_SCSI_BUSLOGIC is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_EATA is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_GDTH is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_STEX is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+# CONFIG_SCSI_QLA_FC is not set
+# CONFIG_SCSI_QLA_ISCSI is not set
+# CONFIG_SCSI_LPFC is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_NSP32 is not set
+# CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_SRP is not set
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+# CONFIG_FUSION_SPI is not set
+# CONFIG_FUSION_FC is not set
+# CONFIG_FUSION_SAS is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_FIREWIRE is not set
+# CONFIG_IEEE1394 is not set
+# CONFIG_I2O is not set
 # CONFIG_MACINTOSH_DRIVERS is not set
 CONFIG_NETDEVICES=y
 # CONFIG_NETDEVICES_MULTIQUEUE is not set
@@ -425,9 +517,52 @@ CONFIG_NETDEVICES=y
 # CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
-# CONFIG_NET_ETHERNET is not set
-# CONFIG_NETDEV_1000 is not set
+# CONFIG_ARCNET is not set
+# CONFIG_PHYLIB is not set
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_IBM_EMAC=y
+CONFIG_IBM_EMAC_RXB=256
+CONFIG_IBM_EMAC_TXB=256
+CONFIG_IBM_EMAC_POLL_WEIGHT=32
+CONFIG_IBM_EMAC_RX_COPY_THRESHOLD=256
+CONFIG_IBM_EMAC_RX_SKB_HEADROOM=0
+CONFIG_IBM_EMAC_PHY_RX_CLK_FIX=y
+# CONFIG_IBM_EMAC_DEBUG is not set
+CONFIG_IBM_EMAC_RGMII=y
+CONFIG_IBM_EMAC_NR_START=0
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_NET_PCI is not set
+CONFIG_NETDEV_1000=y
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+CONFIG_E1000=y
+CONFIG_E1000_NAPI=y
+# CONFIG_E1000_DISABLE_PACKET_SPLIT is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+# CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
 # CONFIG_NETDEV_10000 is not set
+# CONFIG_TR is not set
 
 #
 # Wireless LAN
@@ -435,8 +570,11 @@ CONFIG_NETDEVICES=y
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
 # CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
@@ -447,7 +585,28 @@ CONFIG_NETDEVICES=y
 #
 # Input device support
 #
-# CONFIG_INPUT is not set
+CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
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
+# CONFIG_INPUT_TABLET is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
 
 #
 # Hardware I/O ports
@@ -466,13 +625,10 @@ CONFIG_NETDEVICES=y
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_PCI=y
 CONFIG_SERIAL_8250_NR_UARTS=4
 CONFIG_SERIAL_8250_RUNTIME_UARTS=4
-CONFIG_SERIAL_8250_EXTENDED=y
-# CONFIG_SERIAL_8250_MANY_PORTS is not set
-CONFIG_SERIAL_8250_SHARE_IRQ=y
-# CONFIG_SERIAL_8250_DETECT_IRQ is not set
-# CONFIG_SERIAL_8250_RSA is not set
+# CONFIG_SERIAL_8250_EXTENDED is not set
 
 #
 # Non-8250 serial port support
@@ -480,19 +636,82 @@ CONFIG_SERIAL_8250_SHARE_IRQ=y
 # CONFIG_SERIAL_UARTLITE is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
-CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_WATCHDOG is not set
-# CONFIG_HW_RANDOM is not set
+CONFIG_HW_RANDOM=y
 # CONFIG_NVRAM is not set
 # CONFIG_GEN_RTC is not set
 # CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
-# CONFIG_I2C is not set
+CONFIG_DEVPORT=y
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_CHARDEV=y
+
+#
+# I2C Algorithms
+#
+# CONFIG_I2C_ALGOBIT is not set
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_I810 is not set
+# CONFIG_I2C_PIIX4 is not set
+CONFIG_I2C_IBM_IIC=y
+# CONFIG_I2C_MPC is not set
+# CONFIG_I2C_MPC8260 is not set
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PROSAVAGE is not set
+# CONFIG_I2C_SAVAGE4 is not set
+# CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_TAOS_EVM is not set
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+# CONFIG_I2C_VOODOO3 is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_SENSORS_24C01A is not set
+# CONFIG_SENSORS_AD7416 is not set
+# CONFIG_SENSORS_DS1337 is not set
+# CONFIG_SENSORS_DS1374 is not set
+# CONFIG_DS1682 is not set
+CONFIG_SENSORS_EEPROM=y
+# CONFIG_SENSORS_MAX6900 is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_M41T00 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
 
 #
 # SPI support
@@ -501,7 +720,61 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_SPI_MASTER is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
-# CONFIG_HWMON is not set
+CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
+# CONFIG_SENSORS_ABITUGURU is not set
+# CONFIG_SENSORS_ABITUGURU3 is not set
+CONFIG_SENSORS_AD7414=y
+# CONFIG_SENSORS_AD7418 is not set
+# CONFIG_SENSORS_ADM1021 is not set
+# CONFIG_SENSORS_ADM1025 is not set
+# CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1029 is not set
+# CONFIG_SENSORS_ADM1031 is not set
+# CONFIG_SENSORS_ADM9240 is not set
+# CONFIG_SENSORS_ASB100 is not set
+# CONFIG_SENSORS_ATXP1 is not set
+# CONFIG_SENSORS_DS1621 is not set
+# CONFIG_SENSORS_F71805F is not set
+# CONFIG_SENSORS_FM75 is not set
+# CONFIG_SENSORS_FSCHER is not set
+# CONFIG_SENSORS_FSCPOS is not set
+# CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_GL520SM is not set
+# CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_LM63 is not set
+# CONFIG_SENSORS_LM75 is not set
+# CONFIG_SENSORS_LM77 is not set
+# CONFIG_SENSORS_LM78 is not set
+# CONFIG_SENSORS_LM80 is not set
+# CONFIG_SENSORS_LM83 is not set
+# CONFIG_SENSORS_LM85 is not set
+# CONFIG_SENSORS_LM87 is not set
+# CONFIG_SENSORS_LM90 is not set
+# CONFIG_SENSORS_LM92 is not set
+# CONFIG_SENSORS_LM93 is not set
+# CONFIG_SENSORS_MAX1619 is not set
+# CONFIG_SENSORS_MAX6650 is not set
+# CONFIG_SENSORS_PC87360 is not set
+# CONFIG_SENSORS_PC87427 is not set
+# CONFIG_SENSORS_SIS5595 is not set
+# CONFIG_SENSORS_DME1737 is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_SMSC47M192 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_THMC50 is not set
+# CONFIG_SENSORS_VIA686A is not set
+# CONFIG_SENSORS_VT1115 is not set
+# CONFIG_SENSORS_VT1211 is not set
+# CONFIG_SENSORS_VT8231 is not set
+# CONFIG_SENSORS_W83781D is not set
+# CONFIG_SENSORS_W83791D is not set
+# CONFIG_SENSORS_W83792D is not set
+# CONFIG_SENSORS_W83793 is not set
+# CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83627HF is not set
+# CONFIG_SENSORS_W83627EHF is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
 # Multifunction device drivers
@@ -533,11 +806,58 @@ CONFIG_LEGACY_PTY_COUNT=256
 # Sound
 #
 # CONFIG_SOUND is not set
+# CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_MMC is not set
 # CONFIG_NEW_LEDS is not set
+# CONFIG_INFINIBAND is not set
 # CONFIG_EDAC is not set
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+CONFIG_RTC_INTF_DEV_UIE_EMUL=y
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# I2C RTC drivers
+#
+CONFIG_RTC_DRV_DS1307=y
+# CONFIG_RTC_DRV_DS1672 is not set
+# CONFIG_RTC_DRV_MAX6900 is not set
+# CONFIG_RTC_DRV_RS5C372 is not set
+# CONFIG_RTC_DRV_ISL1208 is not set
+# CONFIG_RTC_DRV_X1205 is not set
+# CONFIG_RTC_DRV_PCF8563 is not set
+# CONFIG_RTC_DRV_PCF8583 is not set
+# CONFIG_RTC_DRV_M41T80 is not set
+
+#
+# SPI RTC drivers
+#
+
+#
+# Platform RTC drivers
+#
+# CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_V3020 is not set
+
+#
+# on-CPU RTC drivers
+#
 
 #
 # DMA Engine support
@@ -563,11 +883,17 @@ CONFIG_LEGACY_PTY_COUNT=256
 CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
 # CONFIG_EXT2_FS_XIP is not set
-# CONFIG_EXT3_FS is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
 # CONFIG_EXT4DEV_FS is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
-# CONFIG_FS_POSIX_ACL is not set
+CONFIG_FS_POSIX_ACL=y
 # CONFIG_XFS_FS is not set
 # CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
@@ -580,6 +906,7 @@ CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 # CONFIG_FUSE_FS is not set
+CONFIG_GENERIC_ACL=y
 
 #
 # CD-ROM/DVD Filesystems
@@ -590,8 +917,11 @@ CONFIG_DNOTIFY=y
 #
 # DOS/FAT/NT Filesystems
 #
+CONFIG_FAT_FS=y
 # CONFIG_MSDOS_FS is not set
-# CONFIG_VFAT_FS is not set
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
 
 #
@@ -602,7 +932,7 @@ CONFIG_PROC_KCORE=y
 CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
-# CONFIG_TMPFS_POSIX_ACL is not set
+CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -617,8 +947,17 @@ CONFIG_RAMFS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-# CONFIG_JFFS2_FS is not set
-CONFIG_CRAMFS=y
+# CONFIG_YAFFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
@@ -629,14 +968,12 @@ CONFIG_CRAMFS=y
 # Network File Systems
 #
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
-# CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFS_V3 is not set
 # CONFIG_NFS_V4 is not set
 # CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
-CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 # CONFIG_SUNRPC_BIND34 is not set
@@ -651,19 +988,73 @@ CONFIG_SUNRPC=y
 #
 # Partition Types
 #
-# CONFIG_PARTITION_ADVANCED is not set
-CONFIG_MSDOS_PARTITION=y
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+# CONFIG_MAC_PARTITION is not set
+# CONFIG_MSDOS_PARTITION is not set
+# CONFIG_LDM_PARTITION is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+# CONFIG_SYSV68_PARTITION is not set
 
 #
 # Native Language Support
 #
-# CONFIG_NLS is not set
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+# CONFIG_NLS_CODEPAGE_437 is not set
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+# CONFIG_NLS_ISO8859_1 is not set
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
 
 #
 # Distributed Lock Manager
 #
 # CONFIG_DLM is not set
-# CONFIG_UCC_SLOW is not set
+
+#
+# IBM 40x options
+#
 
 #
 # Library routines
@@ -676,14 +1067,11 @@ CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
-
-#
-# Instrumentation Support
-#
 # CONFIG_PROFILING is not set
 
 #
@@ -691,9 +1079,9 @@ CONFIG_HAS_DMA=y
 #
 # CONFIG_PRINTK_TIME is not set
 CONFIG_ENABLE_MUST_CHECK=y
-CONFIG_MAGIC_SYSRQ=y
+# CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
-# CONFIG_DEBUG_FS is not set
+CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
@@ -701,7 +1089,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_SLUB_DEBUG_ON is not set
+# CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
@@ -709,61 +1097,22 @@ CONFIG_SCHED_DEBUG=y
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
-CONFIG_DEBUG_BUGVERBOSE=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
 CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_FAULT_INJECTION is not set
-# CONFIG_DEBUG_STACKOVERFLOW is not set
-# CONFIG_DEBUG_STACK_USAGE is not set
-# CONFIG_DEBUG_PAGEALLOC is not set
-# CONFIG_DEBUGGER is not set
-# CONFIG_BDI_SWITCH is not set
-# CONFIG_PPC_EARLY_DEBUG is not set
+# CONFIG_KGDB is not set
+# CONFIG_XMON is not set
+CONFIG_BDI_SWITCH=y
+# CONFIG_SERIAL_TEXT_DEBUG is not set
+CONFIG_PPC_OCP=y
 
 #
 # Security options
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_ALGAPI=y
-CONFIG_CRYPTO_BLKCIPHER=y
-CONFIG_CRYPTO_MANAGER=y
-# CONFIG_CRYPTO_HMAC is not set
-# CONFIG_CRYPTO_XCBC is not set
-# CONFIG_CRYPTO_NULL is not set
-# CONFIG_CRYPTO_MD4 is not set
-CONFIG_CRYPTO_MD5=y
-# CONFIG_CRYPTO_SHA1 is not set
-# CONFIG_CRYPTO_SHA256 is not set
-# CONFIG_CRYPTO_SHA512 is not set
-# CONFIG_CRYPTO_WP512 is not set
-# CONFIG_CRYPTO_TGR192 is not set
-# CONFIG_CRYPTO_GF128MUL is not set
-CONFIG_CRYPTO_ECB=y
-CONFIG_CRYPTO_CBC=y
-CONFIG_CRYPTO_PCBC=y
-# CONFIG_CRYPTO_LRW is not set
-# CONFIG_CRYPTO_CRYPTD is not set
-CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_FCRYPT is not set
-# CONFIG_CRYPTO_BLOWFISH is not set
-# CONFIG_CRYPTO_TWOFISH is not set
-# CONFIG_CRYPTO_SERPENT is not set
-# CONFIG_CRYPTO_AES is not set
-# CONFIG_CRYPTO_CAST5 is not set
-# CONFIG_CRYPTO_CAST6 is not set
-# CONFIG_CRYPTO_TEA is not set
-# CONFIG_CRYPTO_ARC4 is not set
-# CONFIG_CRYPTO_KHAZAD is not set
-# CONFIG_CRYPTO_ANUBIS is not set
-# CONFIG_CRYPTO_DEFLATE is not set
-# CONFIG_CRYPTO_MICHAEL_MIC is not set
-# CONFIG_CRYPTO_CRC32C is not set
-# CONFIG_CRYPTO_CAMELLIA is not set
-# CONFIG_CRYPTO_TEST is not set
-CONFIG_CRYPTO_HW=y
-# CONFIG_PPC_CLOCK is not set
+# CONFIG_CRYPTO is not set
-- 
1.5.3.6.985.g65c6a4
