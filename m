Return-Path: <mgreer@mvista.com>
Date: Thu, 1 Sep 2005 17:55:29 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20050902005529.GC10106@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: [PATCH 2.6.13-mm1] ppc32: cpci690 updates
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Update the cpci690 platform code:
- pass mem size in from bootwrapper via bi_rec
- some minor fixups

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

diff -Nur linux-2.6.13-mm1/arch/ppc/boot/simple/misc-cpci690.c linux-2.6.13-mm1-mag/arch/ppc/boot/simple/misc-cpci690.c
--- linux-2.6.13-mm1/arch/ppc/boot/simple/misc-cpci690.c	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13-mm1-mag/arch/ppc/boot/simple/misc-cpci690.c	2005-09-01 17:00:39.000000000 -0700
@@ -12,16 +12,56 @@
  */
 
 #include <linux/types.h>
+#include <asm/io.h>
 #include <platforms/cpci690.h>
 
+#define	KB	(1024UL)
+#define	MB	(1024UL*KB)
+#define	GB	(1024UL*MB)
+
 extern u32 mv64x60_console_baud;
 extern u32 mv64x60_mpsc_clk_src;
 extern u32 mv64x60_mpsc_clk_freq;
 
+u32 mag = 0xffff;
+
+unsigned long
+get_mem_size(void)
+{
+	u32	size;
+
+	switch (in_8(((void __iomem *)CPCI690_BR_BASE + CPCI690_BR_MEM_CTLR))
+			& 0x07) {
+	case 0x01:
+		size = 256*MB;
+		break;
+	case 0x02:
+		size = 512*MB;
+		break;
+	case 0x03:
+		size = 768*MB;
+		break;
+	case 0x04:
+		size = 1*GB;
+		break;
+	case 0x05:
+		size = 1*GB + 512*MB;
+		break;
+	case 0x06:
+		size = 2*GB;
+		break;
+	default:
+		size = 0;
+	}
+
+	return size;
+}
+
 void
 mv64x60_board_init(void __iomem *old_base, void __iomem *new_base)
 {
 	mv64x60_console_baud = CPCI690_MPSC_BAUD;
 	mv64x60_mpsc_clk_src = CPCI690_MPSC_CLK_SRC;
-	mv64x60_mpsc_clk_freq = CPCI690_BUS_FREQ;
+	mv64x60_mpsc_clk_freq =
+		(get_mem_size() >= (1*GB)) ? 100000000 : 133333333;
 }
diff -Nur linux-2.6.13-mm1/arch/ppc/configs/cpci690_defconfig linux-2.6.13-mm1-mag/arch/ppc/configs/cpci690_defconfig
--- linux-2.6.13-mm1/arch/ppc/configs/cpci690_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13-mm1-mag/arch/ppc/configs/cpci690_defconfig	2005-09-01 17:10:44.000000000 -0700
@@ -1,15 +1,17 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc2
-# Fri Dec  3 15:56:10 2004
+# Linux kernel version: 2.6.13-mm1
+# Thu Sep  1 17:10:37 2005
 #
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_HAVE_DEC_LOCK=y
 CONFIG_PPC=y
 CONFIG_PPC32=y
 CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 
 #
 # Code maturity level options
@@ -17,33 +19,38 @@
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
 
 #
 # General setup
 #
 CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_HOTPLUG is not set
 CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
+CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SHMEM=y
 CONFIG_CC_ALIGN_FUNCTIONS=0
 CONFIG_CC_ALIGN_LABELS=0
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
 
 #
 # Loadable module support
@@ -65,38 +72,42 @@
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
 # CONFIG_8xx is not set
+# CONFIG_E200 is not set
 # CONFIG_E500 is not set
+CONFIG_PPC_FPU=y
 CONFIG_ALTIVEC=y
 # CONFIG_TAU is not set
+# CONFIG_KEXEC is not set
 # CONFIG_CPU_FREQ is not set
+# CONFIG_WANT_EARLY_SERIAL is not set
 CONFIG_PPC_STD_MMU=y
 # CONFIG_NOT_COHERENT_CACHE is not set
 
 #
+# Performance-monitoring counters support
+#
+# CONFIG_PERFCTR is not set
+
+#
 # Platform options
 #
 # CONFIG_PPC_MULTIPLATFORM is not set
 # CONFIG_APUS is not set
 # CONFIG_KATANA is not set
-# CONFIG_DMV182 is not set
 # CONFIG_WILLOW is not set
 CONFIG_CPCI690=y
-# CONFIG_PCORE is not set
 # CONFIG_POWERPMC250 is not set
-# CONFIG_EV64260 is not set
-# CONFIG_DB64360 is not set
 # CONFIG_CHESTNUT is not set
 # CONFIG_SPRUCE is not set
+# CONFIG_HDPU is not set
+# CONFIG_EV64260 is not set
 # CONFIG_LOPEC is not set
-# CONFIG_MCPN765 is not set
 # CONFIG_MVME5100 is not set
 # CONFIG_PPLUS is not set
 # CONFIG_PRPMC750 is not set
 # CONFIG_PRPMC800 is not set
-# CONFIG_PRPMC880 is not set
 # CONFIG_SANDPOINT is not set
-# CONFIG_ADIR is not set
-# CONFIG_K2 is not set
+# CONFIG_RADSTONE_PPC7D is not set
 # CONFIG_PAL4 is not set
 # CONFIG_GEMINI is not set
 # CONFIG_EST8260 is not set
@@ -105,22 +116,41 @@
 # CONFIG_RPX8260 is not set
 # CONFIG_TQM8260 is not set
 # CONFIG_ADS8272 is not set
+# CONFIG_PQ2FADS is not set
 # CONFIG_LITE5200 is not set
+# CONFIG_MPC834x_SYS is not set
+# CONFIG_EV64360 is not set
+CONFIG_GT64260=y
+CONFIG_MV64X60=y
 
 #
 # Set bridge options
 #
 CONFIG_MV64X60_BASE=0xf1000000
 CONFIG_MV64X60_NEW_BASE=0xf1000000
-CONFIG_GT64260=y
-CONFIG_MV64X60=y
 # CONFIG_SMP is not set
+CONFIG_HIGHMEM=y
+CONFIG_HZ_100=y
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=100
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
-# CONFIG_HIGHMEM is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=y
 CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttyMM0,9600 ip=on"
+CONFIG_CMDLINE="console=ttyMM0 ip=on"
+# CONFIG_PM is not set
+CONFIG_SECCOMP=y
+CONFIG_ISA_DMA_API=y
 
 #
 # Bus options
@@ -129,7 +159,11 @@
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 CONFIG_PCI_LEGACY_PROC=y
-CONFIG_PCI_NAMES=y
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
 
 #
 # Advanced setup
@@ -146,6 +180,76 @@
 CONFIG_BOOT_LOAD=0x00800000
 
 #
+# Networking
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
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=y
+# CONFIG_IPV6 is not set
+# CONFIG_NETFILTER is not set
+
+#
+# DCCP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_DCCP is not set
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
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_NETFILTER_NETLINK is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_IEEE80211 is not set
+
+#
 # Device Drivers
 #
 
@@ -154,6 +258,7 @@
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
 
 #
 # Memory Technology Devices (MTD)
@@ -177,6 +282,7 @@
 # CONFIG_BLK_CPQ_CISS_DA is not set
 # CONFIG_BLK_DEV_DAC960 is not set
 # CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
@@ -185,7 +291,6 @@
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_LBD is not set
 # CONFIG_CDROM_PKTCDVD is not set
 
@@ -196,6 +301,7 @@
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -205,6 +311,7 @@
 #
 # SCSI device support
 #
+# CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
 
 #
@@ -215,6 +322,7 @@
 #
 # Fusion MPT device support
 #
+# CONFIG_FUSION is not set
 
 #
 # IEEE 1394 (FireWire) support
@@ -231,71 +339,8 @@
 #
 
 #
-# Networking support
+# Network device support
 #
-CONFIG_NET=y
-
-#
-# Networking options
-#
-CONFIG_PACKET=y
-# CONFIG_PACKET_MMAP is not set
-# CONFIG_NETLINK_DEV is not set
-CONFIG_UNIX=y
-# CONFIG_NET_KEY is not set
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-# CONFIG_IP_ADVANCED_ROUTER is not set
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-# CONFIG_IP_PNP_BOOTP is not set
-# CONFIG_IP_PNP_RARP is not set
-# CONFIG_NET_IPIP is not set
-# CONFIG_NET_IPGRE is not set
-# CONFIG_IP_MROUTE is not set
-# CONFIG_ARPD is not set
-CONFIG_SYN_COOKIES=y
-# CONFIG_INET_AH is not set
-# CONFIG_INET_ESP is not set
-# CONFIG_INET_IPCOMP is not set
-# CONFIG_INET_TUNNEL is not set
-CONFIG_IP_TCPDIAG=y
-# CONFIG_IP_TCPDIAG_IPV6 is not set
-# CONFIG_IPV6 is not set
-# CONFIG_NETFILTER is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
-# CONFIG_IP_SCTP is not set
-# CONFIG_ATM is not set
-# CONFIG_BRIDGE is not set
-# CONFIG_VLAN_8021Q is not set
-# CONFIG_DECNET is not set
-# CONFIG_LLC2 is not set
-# CONFIG_IPX is not set
-# CONFIG_ATALK is not set
-# CONFIG_X25 is not set
-# CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
-# CONFIG_ECONET is not set
-# CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
-# CONFIG_NET_SCHED is not set
-# CONFIG_NET_CLS_ROUTE is not set
-
-#
-# Network testing
-#
-# CONFIG_NET_PKTGEN is not set
-# CONFIG_NETPOLL is not set
-# CONFIG_NET_POLL_CONTROLLER is not set
-# CONFIG_HAMRADIO is not set
-# CONFIG_IRDA is not set
-# CONFIG_BT is not set
 CONFIG_NETDEVICES=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
@@ -308,6 +353,11 @@
 # CONFIG_ARCNET is not set
 
 #
+# PHY device support
+#
+# CONFIG_PHYLIB is not set
+
+#
 # Ethernet (10 or 100Mbit)
 #
 CONFIG_NET_ETHERNET=y
@@ -328,6 +378,7 @@
 # CONFIG_DE4X5 is not set
 # CONFIG_WINBOND_840 is not set
 # CONFIG_DM9102 is not set
+# CONFIG_ULI526X is not set
 # CONFIG_HP100 is not set
 CONFIG_NET_PCI=y
 # CONFIG_PCNET32 is not set
@@ -337,7 +388,6 @@
 # CONFIG_FORCEDETH is not set
 # CONFIG_DGRS is not set
 CONFIG_EEPRO100=y
-# CONFIG_EEPRO100_PIO is not set
 # CONFIG_E100 is not set
 # CONFIG_FEALNX is not set
 # CONFIG_NATSEMI is not set
@@ -360,13 +410,18 @@
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
 # CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
 # CONFIG_SK98LIN is not set
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
 
 #
 # Ethernet (10000 Mbit)
 #
+# CONFIG_CHELSIO_T1 is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 
@@ -390,6 +445,11 @@
 # CONFIG_SLIP is not set
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
+# CONFIG_KGDBOE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NETPOLL_RX is not set
+# CONFIG_NETPOLL_TRAP is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
 
 #
 # ISDN subsystem
@@ -419,14 +479,6 @@
 # CONFIG_INPUT_EVBUG is not set
 
 #
-# Input I/O drivers
-#
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
-# CONFIG_SERIO is not set
-# CONFIG_SERIO_I8042 is not set
-
-#
 # Input Device Drivers
 #
 # CONFIG_INPUT_KEYBOARD is not set
@@ -436,6 +488,12 @@
 # CONFIG_INPUT_MISC is not set
 
 #
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
 # Character devices
 #
 CONFIG_VT=y
@@ -455,6 +513,7 @@
 CONFIG_SERIAL_MPSC_CONSOLE=y
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -483,6 +542,11 @@
 # CONFIG_RAW_DRIVER is not set
 
 #
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+
+#
 # I2C support
 #
 # CONFIG_I2C is not set
@@ -493,10 +557,21 @@
 # CONFIG_W1 is not set
 
 #
+# Hardware Monitoring support
+#
+CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
+
+#
 # Misc devices
 #
 
 #
+# Multimedia Capabilities Port drivers
+#
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -518,6 +593,11 @@
 CONFIG_DUMMY_CONSOLE=y
 
 #
+# Speakup console speech
+#
+# CONFIG_SPEAKUP is not set
+
+#
 # Sound
 #
 # CONFIG_SOUND is not set
@@ -525,35 +605,59 @@
 #
 # USB support
 #
-# CONFIG_USB is not set
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
+# CONFIG_USB is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+# USB Gadget Support
 #
+# CONFIG_USB_GADGET is not set
 
 #
-# USB Gadget Support
+# MMC/SD Card support
 #
-# CONFIG_USB_GADGET is not set
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
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
 
 #
 # File systems
 #
 CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
 # CONFIG_EXT3_FS is not set
-# CONFIG_JBD is not set
+# CONFIG_REISER4_FS is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+
+#
+# XFS support
+#
 # CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
 
 #
 # CD-ROM/DVD Filesystems
@@ -574,20 +678,18 @@
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
-CONFIG_DEVFS_FS=y
-# CONFIG_DEVFS_MOUNT is not set
-# CONFIG_DEVFS_DEBUG is not set
-# CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
-# CONFIG_TMPFS_XATTR is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
+# CONFIG_CONFIGFS_FS is not set
+# CONFIG_RELAYFS_FS is not set
 
 #
 # Miscellaneous filesystems
 #
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
+# CONFIG_ASFS_FS is not set
 # CONFIG_HFS_FS is not set
 # CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
@@ -605,13 +707,14 @@
 #
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
 CONFIG_NFS_V4=y
 # CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
-# CONFIG_EXPORTFS is not set
+CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 CONFIG_SUNRPC_GSS=y
 CONFIG_RPCSEC_GSS_KRB5=y
@@ -621,6 +724,7 @@
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -637,6 +741,7 @@
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 
@@ -648,7 +753,9 @@
 #
 # Kernel hacking
 #
+# CONFIG_PRINTK_TIME is not set
 # CONFIG_DEBUG_KERNEL is not set
+CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_SERIAL_TEXT_DEBUG is not set
 
 #
@@ -669,6 +776,7 @@
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
 CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
@@ -684,3 +792,7 @@
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_TEST is not set
+
+#
+# Hardware crypto devices
+#
diff -Nur linux-2.6.13-mm1/arch/ppc/platforms/cpci690.c linux-2.6.13-mm1-mag/arch/ppc/platforms/cpci690.c
--- linux-2.6.13-mm1/arch/ppc/platforms/cpci690.c	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13-mm1-mag/arch/ppc/platforms/cpci690.c	2005-09-01 17:00:40.000000000 -0700
@@ -35,11 +35,7 @@
 #define SET_PCI_IDE_NATIVE
 
 static struct mv64x60_handle	bh;
-static u32 cpci690_br_base;
-
-static const unsigned int cpu_7xx[16] = { /* 7xx & 74xx (but not 745x) */
-	18, 15, 14, 2, 4, 13, 5, 9, 6, 11, 8, 10, 16, 12, 7, 0
-};
+static void __iomem *cpci690_br_base;
 
 TODC_ALLOC();
 
@@ -55,7 +51,7 @@
 		 * 	   A   B   C   D
 		 */
 		{
-			{ 90, 91, 88, 89}, /* IDSEL 30/20 - Sentinel */
+			{ 90, 91, 88, 89 }, /* IDSEL 30/20 - Sentinel */
 		};
 
 		const long min_idsel = 20, max_idsel = 20, irqs_per_slot = 4;
@@ -67,9 +63,9 @@
 		 * 	   A   B   C   D
 		 */
 		{
-			{ 93, 94, 95, 92}, /* IDSEL 28/18 - PMC slot 2 */
-			{  0,  0,  0,  0}, /* IDSEL 29/19 - Not used */
-			{ 94, 95, 92, 93}, /* IDSEL 30/20 - PMC slot 1 */
+			{ 93, 94, 95, 92 }, /* IDSEL 28/18 - PMC slot 2 */
+			{  0,  0,  0,  0 }, /* IDSEL 29/19 - Not used */
+			{ 94, 95, 92, 93 }, /* IDSEL 30/20 - PMC slot 1 */
 		};
 
 		const long min_idsel = 18, max_idsel = 20, irqs_per_slot = 4;
@@ -77,68 +73,29 @@
 	}
 }
 
-static int
-cpci690_get_cpu_speed(void)
-{
-	unsigned long	hid1;
+#define	GB	(1024UL * 1024UL * 1024UL)
 
-	hid1 = mfspr(SPRN_HID1) >> 28;
-	return CPCI690_BUS_FREQ * cpu_7xx[hid1]/2;
+static u32
+cpci690_get_bus_freq(void)
+{
+	if (boot_mem_size >= (1*GB)) /* bus speed based on mem size */
+		return 100000000;
+	else
+		return 133333333;
 }
 
-#define	KB	(1024UL)
-#define	MB	(1024UL * KB)
-#define	GB	(1024UL * MB)
-
-unsigned long __init
-cpci690_find_end_of_memory(void)
-{
-	u32		mem_ctlr_size;
-	static u32	board_size;
-	static u8	first_time = 1;
-
-	if (first_time) {
-		/* Using cpci690_set_bat() mapping ==> virt addr == phys addr */
-		switch (in_8((u8 *) (cpci690_br_base +
-			CPCI690_BR_MEM_CTLR)) & 0x07) {
-		case 0x01:
-			board_size = 256*MB;
-			break;
-		case 0x02:
-			board_size = 512*MB;
-			break;
-		case 0x03:
-			board_size = 768*MB;
-			break;
-		case 0x04:
-			board_size = 1*GB;
-			break;
-		case 0x05:
-			board_size = 1*GB + 512*MB;
-			break;
-		case 0x06:
-			board_size = 2*GB;
-			break;
-		default:
-			board_size = 0xffffffff; /* use mem ctlr size */
-		} /* switch */
-
-		mem_ctlr_size =  mv64x60_get_mem_size(CONFIG_MV64X60_NEW_BASE,
-			MV64x60_TYPE_GT64260A);
-
-		/* Check that mem ctlr & board reg agree.  If not, pick MIN. */
-		if (board_size != mem_ctlr_size) {
-			printk(KERN_WARNING "Board register & memory controller"
-				"mem size disagree (board reg: 0x%lx, "
-				"mem ctlr: 0x%lx)\n",
-				(ulong)board_size, (ulong)mem_ctlr_size);
-			board_size = min(board_size, mem_ctlr_size);
-		}
+static const unsigned int cpu_750xx[32] = { /* 750FX & 750GX */
+	 0,  0,  2,  2,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,/* 0-15*/
+	16, 17, 18, 19, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40,  0 /*16-31*/
+};
 
-		first_time = 0;
-	} /* if */
+static int
+cpci690_get_cpu_freq(void)
+{
+	unsigned long	pll_cfg;
 
-	return board_size;
+	pll_cfg = (mfspr(SPRN_HID1) & 0xf8000000) >> 27;
+	return cpci690_get_bus_freq() * cpu_750xx[pll_cfg]/2;
 }
 
 static void __init
@@ -228,7 +185,7 @@
 	mv64x60_set_32bit_window(&bh, MV64x60_CPU2DEV_0_WIN, CPCI690_BR_BASE,
 		CPCI690_BR_SIZE, 0);
 	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2DEV_0_WIN);
-	cpci690_br_base = (u32)ioremap(CPCI690_BR_BASE, CPCI690_BR_SIZE);
+	cpci690_br_base = ioremap(CPCI690_BR_BASE, CPCI690_BR_SIZE);
 
 	mv64x60_set_32bit_window(&bh, MV64x60_CPU2DEV_1_WIN, CPCI690_TODC_BASE,
 		CPCI690_TODC_SIZE, 0);
@@ -329,7 +286,7 @@
 	pdata->max_idle = 40;
 	pdata->default_baud = CPCI690_MPSC_BAUD;
 	pdata->brg_clk_src = CPCI690_MPSC_CLK_SRC;
-	pdata->brg_clk_freq = CPCI690_BUS_FREQ;
+	pdata->brg_clk_freq = cpci690_get_bus_freq();
 }
 
 static int __init
@@ -365,7 +322,7 @@
 	u32	i = 10000;
 
 	local_irq_disable();
-	out_8((u8 *)(cpci690_br_base + CPCI690_BR_SW_RESET), 0x11);
+	out_8((cpci690_br_base + CPCI690_BR_SW_RESET), 0x11);
 
 	while (i != 0) i++;
 	panic("restart failed\n");
@@ -394,10 +351,40 @@
 static int
 cpci690_show_cpuinfo(struct seq_file *m)
 {
+	char	*s;
+
+	seq_printf(m, "cpu MHz\t\t: %d\n",
+		(cpci690_get_cpu_freq() + 500000) / 1000000);
+	seq_printf(m, "bus MHz\t\t: %d\n",
+		(cpci690_get_bus_freq() + 500000) / 1000000);
 	seq_printf(m, "vendor\t\t: " BOARD_VENDOR "\n");
 	seq_printf(m, "machine\t\t: " BOARD_MACHINE "\n");
-	seq_printf(m, "cpu MHz\t\t: %d\n", cpci690_get_cpu_speed()/1000/1000);
-	seq_printf(m, "bus MHz\t\t: %d\n", CPCI690_BUS_FREQ/1000/1000);
+	seq_printf(m, "FPGA Revision\t: %d\n",
+		in_8(cpci690_br_base + CPCI690_BR_MEM_CTLR) >> 5);
+
+	switch(bh.type) {
+	case MV64x60_TYPE_GT64260A:
+		s = "gt64260a";
+		break;
+	case MV64x60_TYPE_GT64260B:
+		s = "gt64260b";
+		break;
+	case MV64x60_TYPE_MV64360:
+		s = "mv64360";
+		break;
+	case MV64x60_TYPE_MV64460:
+		s = "mv64460";
+		break;
+	default:
+		s = "Unknown";
+	}
+	seq_printf(m, "bridge type\t: %s\n", s);
+	seq_printf(m, "bridge rev\t: 0x%x\n", bh.rev);
+#if defined(CONFIG_NOT_COHERENT_CACHE)
+	seq_printf(m, "coherency\t: %s\n", "off");
+#else
+	seq_printf(m, "coherency\t: %s\n", "on");
+#endif
 
 	return 0;
 }
@@ -407,7 +394,7 @@
 {
 	ulong freq;
 
-	freq = CPCI690_BUS_FREQ / 4;
+	freq = cpci690_get_bus_freq() / 4;
 
 	printk(KERN_INFO "time_init: decrementer frequency = %lu.%.6lu MHz\n",
 	       freq/1000000, freq%1000000);
@@ -416,25 +403,12 @@
 	tb_to_us = mulhwu_scale_factor(freq, 1000000);
 }
 
-static __inline__ void
-cpci690_set_bat(u32 addr, u32 size)
-{
-	addr &= 0xfffe0000;
-	size &= 0x1ffe0000;
-	size = ((size >> 17) - 1) << 2;
-
-	mb();
-	mtspr(SPRN_DBAT1U, addr | size | 0x2); /* Vs == 1; Vp == 0 */
-	mtspr(SPRN_DBAT1L, addr | 0x2a); /* WIMG bits == 0101; PP == r/w access */
-	mb();
-}
-
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB_MPSC)
 static void __init
 cpci690_map_io(void)
 {
 	io_block_mapping(CONFIG_MV64X60_NEW_BASE, CONFIG_MV64X60_NEW_BASE,
-		128 * KB, _PAGE_IO);
+		128 * 1024, _PAGE_IO);
 }
 #endif
 
@@ -442,14 +416,15 @@
 platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	      unsigned long r6, unsigned long r7)
 {
-#ifdef CONFIG_BLK_DEV_INITRD
-	initrd_start=initrd_end=0;
-	initrd_below_start_ok=0;
-#endif /* CONFIG_BLK_DEV_INITRD */
-
 	parse_bootinfo(find_bootinfo());
 
-	loops_per_jiffy = cpci690_get_cpu_speed() / HZ;
+#ifdef CONFIG_BLK_DEV_INITRD
+	/* take care of initrd if we have one */
+	if (r4) {
+		initrd_start = r4 + KERNELBASE;
+		initrd_end = r5 + KERNELBASE;
+	}
+#endif /* CONFIG_BLK_DEV_INITRD */
 
 	isa_mem_base = 0;
 
@@ -460,7 +435,6 @@
 	ppc_md.restart = cpci690_restart;
 	ppc_md.power_off = cpci690_power_off;
 	ppc_md.halt = cpci690_halt;
-	ppc_md.find_end_of_memory = cpci690_find_end_of_memory;
 	ppc_md.time_init = todc_time_init;
 	ppc_md.set_rtc_time = todc_set_rtc_time;
 	ppc_md.get_rtc_time = todc_get_rtc_time;
@@ -468,22 +442,13 @@
 	ppc_md.nvram_write_val = todc_direct_write_val;
 	ppc_md.calibrate_decr = cpci690_calibrate_decr;
 
-	/*
-	 * Need to map in board regs (used by cpci690_find_end_of_memory())
-	 * and the bridge's regs (used by progress);
-	 */
-	cpci690_set_bat(CPCI690_BR_BASE, 32 * MB);
-	cpci690_br_base = CPCI690_BR_BASE;
-
-#ifdef	CONFIG_SERIAL_TEXT_DEBUG
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB_MPSC)
 	ppc_md.setup_io_mappings = cpci690_map_io;
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
 	ppc_md.progress = mv64x60_mpsc_progress;
 	mv64x60_progress_init(CONFIG_MV64X60_NEW_BASE);
 #endif	/* CONFIG_SERIAL_TEXT_DEBUG */
-#ifdef	CONFIG_KGDB
-	ppc_md.setup_io_mappings = cpci690_map_io;
-	ppc_md.early_serial_map = cpci690_early_serial_map;
-#endif	/* CONFIG_KGDB */
+#endif	/* defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB_MPSC) */
 
 #if defined(CONFIG_SERIAL_MPSC)
 	platform_notify = cpci690_platform_notify;
diff -Nur linux-2.6.13-mm1/arch/ppc/platforms/cpci690.h linux-2.6.13-mm1-mag/arch/ppc/platforms/cpci690.h
--- linux-2.6.13-mm1/arch/ppc/platforms/cpci690.h	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13-mm1-mag/arch/ppc/platforms/cpci690.h	2005-09-01 17:00:40.000000000 -0700
@@ -73,6 +73,4 @@
 #define	CPCI690_MPSC_BAUD			9600
 #define	CPCI690_MPSC_CLK_SRC			8 /* TCLK */
 
-#define	CPCI690_BUS_FREQ			133333333
-
 #endif /* __PPC_PLATFORMS_CPCI690_H */
