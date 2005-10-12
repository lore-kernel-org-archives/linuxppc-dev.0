Return-Path: <wd@denx.de>
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com
	[194.25.134.80]) by ozlabs.org (Postfix) with ESMTP id 1D367684E3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Oct 2005 01:49:30 +1000 (EST)
To: linuxppc-embedded@ozlabs.org
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Wed, 12 Oct 2005 17:38:17 +0200
Sender: wd@denx.de
Message-Id: <20051012153817.D370D353A4F@atlas.denx.de>
Cc: llandre <r&d2@dave-tech.it>
Subject: [PATCH 1/2] ppc32: Add initial support for DAVE "PPChameleon" board.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

the following patch (against current kernel.org tree) adds suport for
the "PPChameleon" modules / eval boards manufactured by DAVE s.r.l.


[PATCH] ppc32: Add initial support for DAVE "PPChameleon" board.

Not included yet: support for MTD, I2C, RTC.

Signed-off-by: Wolfgang Denk <wd@denx.de>

---
commit c9759e3e50c6e0f7c935a0f84f6c811e0bc3bc84
tree ae801a82c095e78a09fca6d4b77c9ee5d677304a
parent 2f70d4fec3a12a03db9a6accbff3271c85b91a2b
author Wolfgang Denk <wd@pollux.denx.de> Wed, 12 Oct 2005 17:29:22 +0200
committer Wolfgang Denk <wd@pollux.denx.de> Wed, 12 Oct 2005 17:29:22 +0200

 arch/ppc/configs/PPChameleon_defconfig |  881 ++++++++++++++++++++++++++++++++
 arch/ppc/platforms/4xx/Kconfig         |    9 
 arch/ppc/platforms/4xx/Makefile        |    1 
 arch/ppc/platforms/4xx/ibm405ep.h      |   49 +-
 arch/ppc/platforms/4xx/ppchameleon.c   |  257 +++++++++
 arch/ppc/platforms/4xx/ppchameleon.h   |  145 +++++
 include/asm-ppc/ibm4xx.h               |    4 
 7 files changed, 1328 insertions(+), 18 deletions(-)

diff --git a/arch/ppc/configs/PPChameleon_defconfig b/arch/ppc/configs/PPChameleon_defconfig
new file mode 100644
--- /dev/null
+++ b/arch/ppc/configs/PPChameleon_defconfig
@@ -0,0 +1,881 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.14-rc3
+# Mon Oct 10 14:06:58 2005
+#
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_PPC=y
+CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
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
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+# CONFIG_HOTPLUG is not set
+CONFIG_KOBJECT_UEVENT=y
+# CONFIG_IKCONFIG is not set
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_EMBEDDED=y
+# CONFIG_KALLSYMS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+# CONFIG_EPOLL is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
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
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+
+#
+# Processor
+#
+# CONFIG_6xx is not set
+CONFIG_40x=y
+# CONFIG_44x is not set
+# CONFIG_POWER3 is not set
+# CONFIG_POWER4 is not set
+# CONFIG_8xx is not set
+# CONFIG_E200 is not set
+# CONFIG_E500 is not set
+# CONFIG_MATH_EMULATION is not set
+# CONFIG_KEXEC is not set
+# CONFIG_CPU_FREQ is not set
+CONFIG_4xx=y
+# CONFIG_WANT_EARLY_SERIAL is not set
+
+#
+# IBM 4xx options
+#
+# CONFIG_BUBINGA is not set
+# CONFIG_CPCI405 is not set
+# CONFIG_EP405 is not set
+CONFIG_PPChameleonEVB=y
+# CONFIG_REDWOOD_5 is not set
+# CONFIG_REDWOOD_6 is not set
+# CONFIG_SYCAMORE is not set
+# CONFIG_WALNUT is not set
+# CONFIG_XILINX_ML300 is not set
+CONFIG_IBM_OCP=y
+CONFIG_405EP=y
+# CONFIG_PPC4xx_DMA is not set
+CONFIG_PPC_GEN550=y
+CONFIG_UART0_TTYS0=y
+# CONFIG_UART0_TTYS1 is not set
+CONFIG_NOT_COHERENT_CACHE=y
+
+#
+# Platform options
+#
+# CONFIG_PC_KEYBOARD is not set
+# CONFIG_HIGHMEM is not set
+CONFIG_HZ_100=y
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=100
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_PM is not set
+# CONFIG_SOFTWARE_SUSPEND is not set
+CONFIG_SECCOMP=y
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_LEGACY_PROC=y
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
+CONFIG_BOOT_LOAD=0x00400000
+
+#
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
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_IEEE80211 is not set
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
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
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
+CONFIG_MTD_CFI_AMDSTD_RETRY=3
+CONFIG_MTD_CFI_STAA=y
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+CONFIG_MTD_COMPLEX_MAPPINGS=y
+# CONFIG_MTD_PHYSMAP is not set
+CONFIG_MTD_PPCHAMELEON=y
+# CONFIG_MTD_PCI is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLKMTD is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+
+#
+# NAND Flash Device Drivers
+#
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_VERIFY_WRITE=y
+CONFIG_MTD_NAND_IDS=y
+CONFIG_MTD_NAND_PPCHAMELEONEVB=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
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
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=4
+CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_INITRD=y
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
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
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
+# Network device support
+#
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
+# PHY device support
+#
+# CONFIG_PHYLIB is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_IBM_EMAC=y
+CONFIG_IBM_EMAC_RXB=64
+CONFIG_IBM_EMAC_TXB=32
+CONFIG_IBM_EMAC_POLL_WEIGHT=32
+CONFIG_IBM_EMAC_RX_COPY_THRESHOLD=256
+CONFIG_IBM_EMAC_RX_SKB_HEADROOM=0
+# CONFIG_IBM_EMAC_PHY_RX_CLK_FIX is not set
+# CONFIG_IBM_EMAC_DEBUG is not set
+# CONFIG_NET_PCI is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_CHELSIO_T1 is not set
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
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
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
+CONFIG_SERIAL_8250_NR_UARTS=2
+# CONFIG_SERIAL_8250_EXTENDED is not set
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
+CONFIG_GEN_RTC=y
+# CONFIG_GEN_RTC_X is not set
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
+# Hardware Monitoring support
+#
+CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia Capabilities Port drivers
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
+# CONFIG_USB is not set
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
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+CONFIG_EXT2_FS_POSIX_ACL=y
+# CONFIG_EXT2_FS_SECURITY is not set
+CONFIG_EXT2_FS_XIP=y
+CONFIG_FS_XIP=y
+# CONFIG_EXT3_FS is not set
+# CONFIG_JBD is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+CONFIG_FS_POSIX_ACL=y
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
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
+CONFIG_TMPFS=y
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+# CONFIG_RELAYFS_FS is not set
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
+# CONFIG_JFFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_JFFS2_CMODE_NONE is not set
+CONFIG_JFFS2_CMODE_PRIORITY=y
+# CONFIG_JFFS2_CMODE_SIZE is not set
+CONFIG_CRAMFS=y
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
+CONFIG_NFS_V3=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_ACL_SUPPORT=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
+CONFIG_RPCSEC_GSS_KRB5=y
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set
+
+#
+# Partition Types
+#
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
+# CONFIG_EFI_PARTITION is not set
+
+#
+# Native Language Support
+#
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
+CONFIG_NLS_ASCII=y
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
+
+#
+# IBM 40x options
+#
+
+#
+# Library routines
+#
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
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
+# CONFIG_DEBUG_KERNEL is not set
+CONFIG_LOG_BUF_SHIFT=14
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
+CONFIG_CRYPTO=y
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Hardware crypto devices
+#
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -32,6 +32,11 @@ config EP405
 	help
 	  This option enables support for the EP405/EP405PC boards.
 
+config PPChameleonEVB
+	bool "PPChameleonEVB"
+	help
+	  This option enables support for the DAVE 405EP evaluation board.
+
 config REDWOOD_5
 	bool "Redwood-5"
 	help
@@ -175,7 +180,7 @@ config BOOKE
 
 config IBM_OCP
 	bool
-	depends on ASH || BAMBOO || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT || YELLOWSTONE || YOSEMITE
+	depends on ASH || BAMBOO || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || OCOTEA || PPChameleonEVB || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT || YELLOWSTONE || YOSEMITE
 	default y
 
 config XILINX_OCP
@@ -201,7 +206,7 @@ config 403GCX
 
 config 405EP
 	bool
-	depends on BUBINGA
+	depends on BUBINGA || PPChameleonEVB
 	default y
 
 config 405GP
diff --git a/arch/ppc/platforms/4xx/Makefile b/arch/ppc/platforms/4xx/Makefile
--- a/arch/ppc/platforms/4xx/Makefile
+++ b/arch/ppc/platforms/4xx/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_EP405)		+= ep405.o
 obj-$(CONFIG_BUBINGA)		+= bubinga.o
 obj-$(CONFIG_LUAN)		+= luan.o
 obj-$(CONFIG_OCOTEA)		+= ocotea.o
+obj-$(CONFIG_PPChameleonEVB)	+= ppchameleon.o
 obj-$(CONFIG_REDWOOD_5)		+= redwood5.o
 obj-$(CONFIG_REDWOOD_6)		+= redwood6.o
 obj-$(CONFIG_SYCAMORE)		+= sycamore.o
diff --git a/arch/ppc/platforms/4xx/ibm405ep.h b/arch/ppc/platforms/4xx/ibm405ep.h
--- a/arch/ppc/platforms/4xx/ibm405ep.h
+++ b/arch/ppc/platforms/4xx/ibm405ep.h
@@ -54,6 +54,23 @@
 #define PPC4xx_ONB_IO_VADDR	PPC4xx_ONB_IO_PADDR
 #define PPC4xx_ONB_IO_SIZE	((uint)4*1024)
 
+/* GPIO macro register defines */
+#define GPIO_BASE		((uint)0xEF600700)
+#define GPIO0_OR		(GPIO_BASE+0x0)
+#define GPIO0_TCR		(GPIO_BASE+0x4)
+#define GPIO0_OSRH		(GPIO_BASE+0x8)
+#define GPIO0_OSRL		(GPIO_BASE+0xC)
+#define GPIO0_TSRH		(GPIO_BASE+0x10)
+#define GPIO0_TSRL		(GPIO_BASE+0x14)
+#define GPIO0_ODR		(GPIO_BASE+0x18)
+#define GPIO0_IR		(GPIO_BASE+0x1C)
+#define GPIO0_RR1		(GPIO_BASE+0x20)
+#define GPIO0_RR2		(GPIO_BASE+0x24)
+#define GPIO0_ISR1H		(GPIO_BASE+0x30)
+#define GPIO0_ISR1L		(GPIO_BASE+0x34)
+#define GPIO0_ISR2H		(GPIO_BASE+0x38)
+#define GPIO0_ISR2L		(GPIO_BASE+0x3C)
+
 /* serial port defines */
 #define RS_TABLE_SIZE	2
 
@@ -91,8 +108,8 @@
 	STD_UART_OP(1)
 
 /* DCR defines */
-#define DCRN_CPMSR_BASE         0x0BA
-#define DCRN_CPMFR_BASE         0x0B9
+#define DCRN_CPMSR_BASE		0x0BA
+#define DCRN_CPMFR_BASE		0x0B9
 
 #define DCRN_CPC0_PLLMR0_BASE   0x0F0
 #define DCRN_CPC0_BOOT_BASE     0x0F1
@@ -107,20 +124,20 @@
 #define DCRN_CPC0_PCI_BASE      0x0F9
 
 
-#define IBM_CPM_GPT             0x80000000      /* GPT interface */
-#define IBM_CPM_PCI             0x40000000      /* PCI bridge */
-#define IBM_CPM_UIC             0x00010000      /* Universal Int Controller */
-#define IBM_CPM_CPU             0x00008000      /* processor core */
-#define IBM_CPM_EBC             0x00002000      /* EBC controller */
-#define IBM_CPM_SDRAM0          0x00004000      /* SDRAM memory controller */
-#define IBM_CPM_GPIO0           0x00001000      /* General Purpose IO */
-#define IBM_CPM_TMRCLK          0x00000400      /* CPU timers */
-#define IBM_CPM_PLB             0x00000100      /* PLB bus arbiter */
-#define IBM_CPM_OPB             0x00000080      /* PLB to OPB bridge */
-#define IBM_CPM_DMA             0x00000040      /* DMA controller */
-#define IBM_CPM_IIC0            0x00000010      /* IIC interface */
-#define IBM_CPM_UART1           0x00000002      /* serial port 0 */
-#define IBM_CPM_UART0           0x00000001      /* serial port 1 */
+#define IBM_CPM_GPT		0x80000000      /* GPT interface */
+#define IBM_CPM_PCI		0x40000000      /* PCI bridge */
+#define IBM_CPM_UIC		0x00010000      /* Universal Int Controller */
+#define IBM_CPM_CPU		0x00008000      /* processor core */
+#define IBM_CPM_EBC		0x00002000      /* EBC controller */
+#define IBM_CPM_SDRAM0		0x00004000      /* SDRAM memory controller */
+#define IBM_CPM_GPIO0		0x00001000      /* General Purpose IO */
+#define IBM_CPM_TMRCLK		0x00000400      /* CPU timers */
+#define IBM_CPM_PLB		0x00000100      /* PLB bus arbiter */
+#define IBM_CPM_OPB		0x00000080      /* PLB to OPB bridge */
+#define IBM_CPM_DMA		0x00000040      /* DMA controller */
+#define IBM_CPM_IIC0		0x00000010      /* IIC interface */
+#define IBM_CPM_UART1		0x00000002      /* serial port 0 */
+#define IBM_CPM_UART0		0x00000001      /* serial port 1 */
 #define DFLT_IBM4xx_PM          ~(IBM_CPM_PCI | IBM_CPM_CPU | IBM_CPM_DMA \
                                         | IBM_CPM_OPB | IBM_CPM_EBC \
                                         | IBM_CPM_SDRAM0 | IBM_CPM_PLB \
diff --git a/arch/ppc/platforms/4xx/ppchameleon.c b/arch/ppc/platforms/4xx/ppchameleon.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/4xx/ppchameleon.c
@@ -0,0 +1,257 @@
+/*
+ * Support for DAVE PPC 405EP evaluation board (PPChameleon).
+ *
+ * Author: Wolfgang Denk, DENX Software Engineering, <wd@denx.de>
+ *	   derived from "Octobus hppc405" board by haag.cc
+ *	   (see http://www.haag.cc/downloads/files/octobus-hppc405-2.6.12.2-V0.1)
+ *	   which in turn was obviously based on evb405ep.
+ *         Maintained by Wolfgang Denk, <wd@denx.de>
+ *
+ * 2005 (c) Wolfgang Denk, DENX Software Engineering.  This file is
+ * licensed under the terms of the GNU General Public License version 2.
+ * This program is licensed "as is" without any warranty of any kind,
+ * whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/serial_core.h>
+#include <linux/serial.h>
+
+#include <asm/system.h>
+#include <asm/pci-bridge.h>
+#include <asm/machdep.h>
+#include <asm/page.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/ocp.h>
+#include <platforms/4xx/ibm405ep.h>
+
+#ifdef CONFIG_PPC_RTC
+#include <asm/todc.h>
+#endif
+
+#include <asm/kgdb.h>
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
+
+void *ppchameleon_rtc_base;
+
+extern void gen550_init(int, struct uart_port *);
+extern int early_serial_setup(struct uart_port *port);
+
+/* Some IRQs unique to the board
+ * Used by the generic 405 PCI setup functions in ppc4xx_pci.c
+ */
+int __init
+ppc405_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+{
+	static char pci_irq_table[][4] =
+	    /*
+	     *      PCI IDSEL/INTPIN->INTLINE
+	     *      A       B       C       D
+	     */
+	{
+		{28, 28, 28, 28},	/* IDSEL 1 - PCI slot 1 */
+		{29, 29, 29, 29},	/* IDSEL 2 - PCI slot 2 */
+		{30, 30, 30, 30},	/* IDSEL 3 - PCI slot 3 */
+		{31, 31, 31, 31},	/* IDSEL 4 - PCI slot 4 */
+	};
+
+	const long min_idsel = 1, max_idsel = 4, irqs_per_slot = 4;
+	return PCI_IRQ_TABLE_LOOKUP;
+};
+
+
+/* The serial clock for the chip is an internal clock determined by
+ * different clock speeds/dividers.
+ * Calculate the proper input baud rate and setup the serial driver.
+ */
+
+static void __init
+ppchameleon_early_serial_map (void)
+{
+	u32 uart_div;
+	struct uart_port port;
+	int serial_baud_405ep;
+
+	int size = sizeof (port);
+	bd_t tmp = (bd_t) __res;
+
+	/* bd_t *bip = &tmp; */
+	uart_div = (mfdcr (DCRN_CPC0_UCR_BASE) & DCRN_CPC0_UCR_U0DIV);
+
+	serial_baud_405ep = tmp.bi_intfreq / uart_div;
+	/* serial_baud_405ep=__res.bi_baudrate * uart_div; */
+
+	/* Setup ioremapped serial port access */
+	memset (&port, 0, size);
+	port.membase = (void *) ACTING_UART0_IO_BASE;
+	port.irq = UART0_INT;
+	port.uartclk = serial_baud_405ep;
+	port.regshift = 0;
+	port.iotype = SERIAL_IO_MEM;
+	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
+	port.line = 0;
+
+	if (early_serial_setup (&port) != 0) {
+		printk ("Early serial init of port 0 failed\n");
+	}
+}
+
+
+void __init board_setup_arch (void)
+{
+
+	ppc4xx_setup_arch ();
+
+	ibm_ocp_set_emac(0, 1);
+
+	ppchameleon_early_serial_map ();
+
+	printk ("DAVE PPchameleonEVB Board (Wolfgang Denk wd@denx.de)\n");
+}
+
+#if defined(CONFIG_BIOS_FIXUP)
+void __init bios_fixup (struct pci_controller *hose, struct pcil0_regs *pcip)
+{
+
+	unsigned int bar_response, bar;
+
+	/*
+	 * Expected PCI mapping:
+	 *
+	 *  PLB addr             PCI memory addr
+	 *  ---------------------       ---------------------
+	 *  0000'0000 - 7fff'ffff <---  0000'0000 - 7fff'ffff
+	 *  8000'0000 - Bfff'ffff --->  8000'0000 - Bfff'ffff
+	 *
+	 *  PLB addr             PCI io addr
+	 *  ---------------------       ---------------------
+	 *  e800'0000 - e800'ffff --->  0000'0000 - 0001'0000
+	 *
+	 * The following code is simplified by assuming that the bootrom
+	 * has been well behaved in following this mapping.
+	 */
+
+#ifdef DEBUG
+	int i;
+
+	printk ("ioremap PCLIO_BASE = 0x%x\n", pcip);
+	printk ("PCI bridge regs before fixup \n");
+	for (i = 0; i <= 3; i++) {
+		printk (" pmm%dma\t0x%x\n", i, in_le32 (&(pcip->pmm[i].ma)));
+		printk (" pmm%dma\t0x%x\n", i, in_le32 (&(pcip->pmm[i].la)));
+		printk (" pmm%dma\t0x%x\n", i,
+			in_le32 (&(pcip->pmm[i].pcila)));
+		printk (" pmm%dma\t0x%x\n", i,
+			in_le32 (&(pcip->pmm[i].pciha)));
+	}
+	printk (" ptm1ms\t0x%x\n", in_le32 (&(pcip->ptm1ms)));
+	printk (" ptm1la\t0x%x\n", in_le32 (&(pcip->ptm1la)));
+	printk (" ptm2ms\t0x%x\n", in_le32 (&(pcip->ptm2ms)));
+	printk (" ptm2la\t0x%x\n", in_le32 (&(pcip->ptm2la)));
+
+#endif
+
+	/* added for IBM boot rom version 1.15 bios bar changes  -AK */
+
+	/* Disable region first */
+	out_le32 ((void *) &(pcip->pmm[0].ma), 0x00000000);
+	/* PLB starting addr, PCI: 0x80000000 */
+	out_le32 ((void *) &(pcip->pmm[0].la), 0x80000000);
+	/* PCI start addr, 0x80000000 */
+	out_le32 ((void *) &(pcip->pmm[0].pcila), PPC405_PCI_MEM_BASE);
+	/* 512MB range of PLB to PCI */
+	out_le32 ((void *) &(pcip->pmm[0].pciha), 0x00000000);
+	/* Enable no pre-fetch, enable region */
+	out_le32 ((void *) &(pcip->pmm[0].ma), ((0xffffffff -
+						 (PPC405_PCI_UPPER_MEM -
+						  PPC405_PCI_MEM_BASE)) |
+						0x01));
+
+	/* Disable region one */
+	out_le32 ((void *) &(pcip->pmm[1].ma), 0x00000000);
+	out_le32 ((void *) &(pcip->pmm[1].la), 0x00000000);
+	out_le32 ((void *) &(pcip->pmm[1].pcila), 0x00000000);
+	out_le32 ((void *) &(pcip->pmm[1].pciha), 0x00000000);
+	out_le32 ((void *) &(pcip->pmm[1].ma), 0x00000000);
+	out_le32 ((void *) &(pcip->ptm1ms), 0x00000001);
+
+	/* Disable region two */
+	out_le32 ((void *) &(pcip->pmm[2].ma), 0x00000000);
+	out_le32 ((void *) &(pcip->pmm[2].la), 0x00000000);
+	out_le32 ((void *) &(pcip->pmm[2].pcila), 0x00000000);
+	out_le32 ((void *) &(pcip->pmm[2].pciha), 0x00000000);
+	out_le32 ((void *) &(pcip->pmm[2].ma), 0x00000000);
+	out_le32 ((void *) &(pcip->ptm2ms), 0x00000000);
+	out_le32 ((void *) &(pcip->ptm2la), 0x00000000);
+
+	/* Zero config bars */
+	for (bar = PCI_BASE_ADDRESS_1; bar <= PCI_BASE_ADDRESS_2; bar += 4) {
+		early_write_config_dword (hose, hose->first_busno,
+					  PCI_FUNC (hose->first_busno), bar,
+					  0x00000000);
+		early_read_config_dword (hose, hose->first_busno,
+					 PCI_FUNC (hose->first_busno), bar,
+					 &bar_response);
+		DBG ("BUS %d, device %d, Function %d bar 0x%8.8x is 0x%8.8x\n", hose->first_busno, PCI_SLOT (hose->first_busno), PCI_FUNC (hose->first_busno), bar, bar_response);
+	}
+	/* end work arround */
+#ifdef DEBUG
+
+	printk ("PCI bridge regs after fixup \n");
+	for (i = 0; i <= 3; i++) {
+		printk (" pmm%dma\t0x%x\n", i, in_le32 (&(pcip->pmm[i].ma)));
+		printk (" pmm%dma\t0x%x\n", i, in_le32 (&(pcip->pmm[i].la)));
+		printk (" pmm%dma\t0x%x\n", i,
+			in_le32 (&(pcip->pmm[i].pcila)));
+		printk (" pmm%dma\t0x%x\n", i,
+			in_le32 (&(pcip->pmm[i].pciha)));
+	}
+	printk (" ptm1ms\t0x%x\n", in_le32 (&(pcip->ptm1ms)));
+	printk (" ptm1la\t0x%x\n", in_le32 (&(pcip->ptm1la)));
+	printk (" ptm2ms\t0x%x\n", in_le32 (&(pcip->ptm2ms)));
+	printk (" ptm2la\t0x%x\n", in_le32 (&(pcip->ptm2la)));
+
+#endif
+}
+#endif
+
+void __init board_io_mapping (void)
+{
+	ppc4xx_map_io ();
+}
+
+void __init board_setup_irq (void)
+{
+}
+
+void __init
+platform_init (unsigned long r3, unsigned long r4, unsigned long r5,
+	       unsigned long r6, unsigned long r7)
+{
+	ppc4xx_init (r3, r4, r5, r6, r7);
+
+	ppc_md.setup_arch = board_setup_arch;
+	ppc_md.setup_io_mappings = board_io_mapping;
+
+#ifdef CONFIG_PPC_RTC
+	ppc_md.time_init = todc_time_init;
+	ppc_md.set_rtc_time = todc_set_rtc_time;
+	ppc_md.get_rtc_time = todc_get_rtc_time;
+	ppc_md.nvram_read_val = todc_direct_read_val;
+	ppc_md.nvram_write_val = todc_direct_write_val;
+#endif
+#ifdef CONFIG_KGDB
+	ppc_md.early_serial_map = ppchameleon_early_serial_map;
+#endif
+}
diff --git a/arch/ppc/platforms/4xx/ppchameleon.h b/arch/ppc/platforms/4xx/ppchameleon.h
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/4xx/ppchameleon.h
@@ -0,0 +1,145 @@
+/*
+ * Support for DAVE PPC 405EP evaluation board (PPChameleon).
+ *
+ * Author: Wolfgang Denk, DENX Software Engineering, <wd@denx.de>
+ *	   derived from "Octobus hppc405" board by haag.cc
+ *	   (see http://www.haag.cc/downloads/files/octobus-hppc405-2.6.12.2-V0.1)
+ *	   which in turn was obviously based on evb405ep.
+ *         Maintained by Wolfgang Denk, <wd@denx.de>
+ *
+ * 2005 (c) Wolfgang Denk, DENX Software Engineering.  This file is
+ * licensed under the terms of the GNU General Public License version 2.
+ * This program is licensed "as is" without any warranty of any kind,
+ * whether express or implied.
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_PPCHAMELEONEVB_H__
+#define __ASM_PPCHAMELEONEVB_H__
+
+/* 405EP */
+#include <platforms/4xx/ibm405ep.h>
+/*#include <asm/io.h>*/
+
+#include <asm/ppcboot.h>
+
+#ifndef __ASSEMBLY__
+
+/* Some 4xx parts use a different timebase frequency from the internal clock.
+*/
+#define bi_tbfreq bi_intfreq
+
+/* The UART clock is based off an internal clock -
+ * define BASE_BAUD based on the internal clock and divider(s).
+ * Since BASE_BAUD must be a constant, we will initialize it
+ * using clock/divider values which OpenBIOS initializes
+ * for typical configurations at various CPU speeds.
+ * The base baud is calculated as (FWDA / EXT UART DIV / 16)
+ */
+#define BASE_BAUD	0
+
+#define PPC4xx_MACHINE_NAME	"DAVE PPChameleonEVB"
+
+/******************************************************************************
+ * Some internal regs are not defined elsewhere so we put 'em here	      *
+ ******************************************************************************/
+
+/**************/
+/* NAND stuff */
+/**************/
+/* Internal NAND */
+#define CFG_NAND0_PADDR ((uint)0xFF400000)
+#define CFG_NAND0_VADDR CFG_NAND0_PADDR
+#define CFG_NAND0_CE  (0x80000000 >> 1)	 /* our CE  is GPIO1 */
+#define CFG_NAND0_CLE (0x80000000 >> 2)	 /* our CLE is GPIO2 */
+#define CFG_NAND0_ALE (0x80000000 >> 3)	 /* our ALE is GPIO3 */
+#define CFG_NAND0_RDY (0x80000000 >> 4)	 /* our RDY is GPIO4 */
+/* External NAND */
+#define CFG_NAND1_PADDR 0xFF000000
+#define CFG_NAND1_VADDR CFG_NAND1_PADDR
+#define CFG_NAND1_CE  (0x80000000 >> 14)  /* our CE  is GPIO14 */
+#define CFG_NAND1_CLE (0x80000000 >> 15)  /* our CLE is GPIO15 */
+#define CFG_NAND1_ALE (0x80000000 >> 16)  /* our ALE is GPIO16 */
+#define CFG_NAND1_RDY (0x80000000 >> 31)  /* our RDY is GPIO31 */
+/* Macros to perform I/O operations */
+#define MACRO_NAND_DISABLE_CE(nandptr) do { \
+	switch((unsigned long)nandptr) { \
+	case CFG_NAND0_PADDR: \
+		out_be32((volatile unsigned*)GPIO0_OR, in_be32((volatile unsigned*)GPIO0_OR) | CFG_NAND0_CE); \
+		break; \
+	case CFG_NAND1_PADDR: \
+		out_be32((volatile unsigned*)GPIO0_OR, in_be32((volatile unsigned*)GPIO0_OR) | CFG_NAND1_CE); \
+		break; \
+	} \
+} while(0)
+
+#define MACRO_NAND_ENABLE_CE(nandptr) do { \
+	switch((unsigned long)nandptr) { \
+	case CFG_NAND0_PADDR: \
+		out_be32((volatile unsigned*)GPIO0_OR, in_be32((volatile unsigned*)GPIO0_OR) & ~CFG_NAND0_CE); \
+		break; \
+	case CFG_NAND1_PADDR: \
+		out_be32((volatile unsigned*)GPIO0_OR, in_be32((volatile unsigned*)GPIO0_OR) & ~CFG_NAND1_CE); \
+		break; \
+	} \
+} while(0)
+
+
+#define MACRO_NAND_CTL_CLRALE(nandptr) do { \
+	switch((unsigned long)nandptr) { \
+	case CFG_NAND0_PADDR: \
+		out_be32((volatile unsigned*)GPIO0_OR, in_be32((volatile unsigned*)GPIO0_OR) & ~CFG_NAND0_ALE); \
+		break; \
+	case CFG_NAND1_PADDR: \
+		out_be32((volatile unsigned*)GPIO0_OR, in_be32((volatile unsigned*)GPIO0_OR) & ~CFG_NAND1_ALE); \
+		break; \
+	} \
+} while(0)
+
+#define MACRO_NAND_CTL_SETALE(nandptr) do { \
+	switch((unsigned long)nandptr) { \
+	case CFG_NAND0_PADDR: \
+		out_be32((volatile unsigned*)GPIO0_OR, in_be32((volatile unsigned*)GPIO0_OR) | CFG_NAND0_ALE); \
+		break; \
+	case CFG_NAND1_PADDR: \
+		out_be32((volatile unsigned*)GPIO0_OR, in_be32((volatile unsigned*)GPIO0_OR) | CFG_NAND1_ALE); \
+		break; \
+	} \
+} while(0)
+
+#define MACRO_NAND_CTL_CLRCLE(nandptr) do { \
+	switch((unsigned long)nandptr) { \
+	case CFG_NAND0_PADDR: \
+		out_be32((volatile unsigned*)GPIO0_OR, in_be32((volatile unsigned*)GPIO0_OR) & ~CFG_NAND0_CLE); \
+		break; \
+	case CFG_NAND1_PADDR: \
+		out_be32((volatile unsigned*)GPIO0_OR, in_be32((volatile unsigned*)GPIO0_OR) & ~CFG_NAND1_CLE); \
+		break; \
+	} \
+} while(0)
+
+#define MACRO_NAND_CTL_SETCLE(nandptr) do { \
+	switch((unsigned long)nandptr) { \
+	case CFG_NAND0_PADDR: \
+		out_be32((volatile unsigned*)GPIO0_OR, in_be32((volatile unsigned*)GPIO0_OR) | CFG_NAND0_CLE); \
+		break; \
+	case CFG_NAND1_PADDR: \
+		out_be32((volatile unsigned*)GPIO0_OR, in_be32((volatile unsigned*)GPIO0_OR) | CFG_NAND1_CLE); \
+		break; \
+	} \
+} while(0)
+
+#define MACRO_NAND_WAIT_READY(nand) while { \
+	switch((unsigned long)(((struct nand_chip *)nand)->IO_ADDR)) { \
+	case CFG_NAND0_PADDR: \
+		!(in_be32((volatile unsigned*)GPIO0_IR) & CFG_NAND0_RDY); \
+		break; \
+	case CFG_NAND1_PADDR: \
+		!(in_be32((volatile unsigned*)GPIO0_IR) & CFG_NAND1_RDY); \
+		break; \
+	} \
+}
+
+#endif /* !__ASSEMBLY__ */
+#endif /* __ASM_PPCHAMELEONEVB_H__ */
+#endif /* __KERNEL__ */
diff --git a/include/asm-ppc/ibm4xx.h b/include/asm-ppc/ibm4xx.h
--- a/include/asm-ppc/ibm4xx.h
+++ b/include/asm-ppc/ibm4xx.h
@@ -31,6 +31,10 @@
 #include <platforms/4xx/ep405.h>
 #endif
 
+#if defined(CONFIG_PPChameleonEVB)
+#include <platforms/4xx/ppchameleon.h>
+#endif
+
 #if defined(CONFIG_REDWOOD_5)
 #include <platforms/4xx/redwood5.h>
 #endif
