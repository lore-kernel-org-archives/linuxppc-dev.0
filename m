Return-Path: <pantelis.antoniou@gmail.com>
Received: from uproxy.gmail.com (uproxy.gmail.com [66.249.92.205])
	by ozlabs.org (Postfix) with ESMTP id A5D9C68862
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Dec 2005 06:08:09 +1100 (EST)
Received: by uproxy.gmail.com with SMTP id m2so22482uge
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 05 Dec 2005 11:08:07 -0800 (PST)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Dan Malek <dan@embeddededge.com>,
	Robert Applebaum <rapplebaum@silicontkx.com>, linuxppc-embedded@ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 5 Dec 2005 21:15:43 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200512052115.45858.pantelis.antoniou@gmail.com>
Subject: [PATCH] Support 8xx based Silicon Turnkey XTc
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Support of Silicon Turnkey's XTc.

---
commit fac9bbd80d8f8ab3c6af5a417f804dbf8537c700
tree 7863f94249651a26ca3eb29aed4c65c214968dda
parent e4f5c82a92c2a546a16af1614114eec19120e40a
author Pantelis Antoniou <pantelis.antoniou@gmail.com> Mon, 05 Dec 2005 21:13:56 +0200
committer Pantelis Antoniou <pantelis.antoniou@gmail.com> Mon, 05 Dec 2005 21:13:56 +0200

 arch/ppc/Kconfig                  |    5 
 arch/ppc/configs/stxxtc_defconfig |  804 +++++++++++++++++++++++++++++++++++++
 arch/ppc/platforms/Makefile       |    1 
 arch/ppc/platforms/stxxtc.h       |  285 +++++++++++++
 arch/ppc/platforms/stxxtc_setup.c |  193 +++++++++
 arch/ppc/syslib/m8xx_setup.c      |   14 +
 drivers/mtd/maps/Kconfig          |    6 
 drivers/mtd/maps/Makefile         |    1 
 drivers/mtd/maps/stxxtc_nor.c     |  326 +++++++++++++++
 drivers/mtd/nand/Kconfig          |    8 
 drivers/mtd/nand/Makefile         |    1 
 drivers/mtd/nand/stxxtc_nand.c    |  277 +++++++++++++
 include/asm-ppc/mpc8xx.h          |    4 
 13 files changed, 1922 insertions(+), 3 deletions(-)

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -504,6 +504,11 @@ config WINCEPT
 	  MPC821 PowerPC, introduced in 1998 and designed to be used in
 	  thin-client machines.  Say Y to support it directly.
 
+config STXXTC
+	bool "Silicon Turnkey eXpress XTc"
+	help
+	  Select STXXTC if configuring for an Silicon Turnkey eXpress XTc
+
 endchoice
 
 choice
diff --git a/arch/ppc/configs/stxxtc_defconfig b/arch/ppc/configs/stxxtc_defconfig
new file mode 100644
--- /dev/null
+++ b/arch/ppc/configs/stxxtc_defconfig
@@ -0,0 +1,804 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.15-rc5
+# Mon Dec  5 19:57:09 2005
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
+CONFIG_LOCALVERSION="-stxxtc"
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_SWAP is not set
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
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_KALLSYMS_EXTRA_PASS=y
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
+# CONFIG_KMOD is not set
+
+#
+# Block layer
+#
+# CONFIG_LBD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
+
+#
+# Processor
+#
+# CONFIG_6xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_POWER3 is not set
+# CONFIG_POWER4 is not set
+CONFIG_8xx=y
+# CONFIG_E200 is not set
+# CONFIG_E500 is not set
+CONFIG_MATH_EMULATION=y
+# CONFIG_KEXEC is not set
+# CONFIG_CPU_FREQ is not set
+# CONFIG_WANT_EARLY_SERIAL is not set
+CONFIG_EMBEDDEDBOOT=y
+CONFIG_NOT_COHERENT_CACHE=y
+
+#
+# Platform options
+#
+# CONFIG_RPXLITE is not set
+# CONFIG_RPXCLASSIC is not set
+# CONFIG_BSEIP is not set
+# CONFIG_MPC8XXFADS is not set
+# CONFIG_MPC86XADS is not set
+# CONFIG_MPC885ADS is not set
+# CONFIG_TQM823L is not set
+# CONFIG_TQM850L is not set
+# CONFIG_TQM855L is not set
+# CONFIG_TQM860L is not set
+# CONFIG_FPS850L is not set
+# CONFIG_IVMS8 is not set
+# CONFIG_IVML24 is not set
+# CONFIG_HERMES_PRO is not set
+# CONFIG_IP860 is not set
+# CONFIG_LWMON is not set
+# CONFIG_PCU_E is not set
+# CONFIG_CCM is not set
+# CONFIG_LANTEC is not set
+# CONFIG_MBX is not set
+# CONFIG_WINCEPT is not set
+CONFIG_STXXTC=y
+CONFIG_CPM1=y
+# CONFIG_HIGHMEM is not set
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=250
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
+CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_PM is not set
+# CONFIG_SOFTWARE_SUSPEND is not set
+# CONFIG_SECCOMP is not set
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+# CONFIG_PPC_I8259 is not set
+# CONFIG_PCI is not set
+# CONFIG_PCI_DOMAINS is not set
+# CONFIG_PCI_QSPAN is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# Advanced setup
+#
+CONFIG_ADVANCED_OPTIONS=y
+CONFIG_HIGHMEM_START=0xfe000000
+# CONFIG_LOWMEM_SIZE_BOOL is not set
+CONFIG_LOWMEM_SIZE=0x30000000
+# CONFIG_KERNEL_START_BOOL is not set
+CONFIG_KERNEL_START=0xc0000000
+# CONFIG_TASK_SIZE_BOOL is not set
+CONFIG_TASK_SIZE=0x80000000
+CONFIG_CONSISTENT_START_BOOL=y
+CONFIG_CONSISTENT_START=0xe0000000
+# CONFIG_CONSISTENT_SIZE_BOOL is not set
+CONFIG_CONSISTENT_SIZE=0x00200000
+# CONFIG_BOOT_LOAD_BOOL is not set
+CONFIG_BOOT_LOAD=0x00400000
+# CONFIG_PIN_TLB is not set
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
+# CONFIG_IP_PNP_DHCP is not set
+CONFIG_IP_PNP_BOOTP=y
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
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
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
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
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
+CONFIG_MTD_CONCAT=y
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
+# CONFIG_RFD_FTL is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_NOSWAP=y
+# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
+# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
+# CONFIG_MTD_CFI_GEOMETRY is not set
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
+# CONFIG_MTD_OTP is not set
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_CFI_AMDSTD_RETRY=0
+CONFIG_MTD_CFI_STAA=y
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
+# CONFIG_MTD_CFI_FLAGADM is not set
+# CONFIG_MTD_PLATRAM is not set
+CONFIG_MTD_STXXTC_NOR=y
+
+#
+# Self-contained MTD device drivers
+#
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
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+CONFIG_MTD_NAND_STXXTC=y
+
+#
+# OneNAND Flash Device Drivers
+#
+# CONFIG_MTD_ONENAND is not set
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
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_CDROM_PKTCDVD is not set
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
+
+#
+# I2O device support
+#
+
+#
+# Macintosh device drivers
+#
+# CONFIG_WINDFARM is not set
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
+# PHY device support
+#
+# CONFIG_PHYLIB is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_FEC_8XX is not set
+CONFIG_FS_ENET=y
+# CONFIG_FS_ENET_HAS_SCC is not set
+CONFIG_FS_ENET_HAS_FEC=y
+
+#
+# Ethernet (1000 Mbit)
+#
+
+#
+# Ethernet (10000 Mbit)
+#
+
+#
+# Token Ring devices
+#
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
+# CONFIG_INPUT is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
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
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_CPM=y
+CONFIG_SERIAL_CPM_CONSOLE=y
+# CONFIG_SERIAL_CPM_SCC1 is not set
+# CONFIG_SERIAL_CPM_SCC2 is not set
+# CONFIG_SERIAL_CPM_SCC3 is not set
+# CONFIG_SERIAL_CPM_SCC4 is not set
+CONFIG_SERIAL_CPM_SMC1=y
+# CONFIG_SERIAL_CPM_SMC2 is not set
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
+CONFIG_WATCHDOG=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_SOFT_WATCHDOG is not set
+CONFIG_8xx_WDT=y
+# CONFIG_NVRAM is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_AGP is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+# CONFIG_TELCLOCK is not set
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
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
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
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
+# CONFIG_QUOTA is not set
+# CONFIG_DNOTIFY is not set
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
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
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
+# CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
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
+# CONFIG_NLS is not set
+
+#
+# MPC8xx CPM Options
+#
+# CONFIG_SCC_ENET is not set
+# CONFIG_FEC_ENET is not set
+
+#
+# Generic MPC8xx Options
+#
+CONFIG_8xx_COPYBACK=y
+# CONFIG_8xx_CPU6 is not set
+CONFIG_NO_UCODE_PATCH=y
+# CONFIG_USB_SOF_UCODE_PATCH is not set
+# CONFIG_I2C_SPI_UCODE_PATCH is not set
+# CONFIG_I2C_SPI_SMC1_UCODE_PATCH is not set
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
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_MAGIC_SYSRQ is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_DETECT_SOFTLOCKUP is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_FS is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_XMON is not set
+# CONFIG_BDI_SWITCH is not set
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
diff --git a/arch/ppc/platforms/Makefile b/arch/ppc/platforms/Makefile
--- a/arch/ppc/platforms/Makefile
+++ b/arch/ppc/platforms/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_SBC82xx)		+= sbc82xx.o
 obj-$(CONFIG_SPRUCE)		+= spruce.o
 obj-$(CONFIG_LITE5200)		+= lite5200.o
 obj-$(CONFIG_EV64360)		+= ev64360.o
+obj-$(CONFIG_STXXTC)		+= stxxtc_setup.o
 
 ifeq ($(CONFIG_SMP),y)
 obj-$(CONFIG_PPC_PMAC)		+= pmac_smp.o
diff --git a/arch/ppc/platforms/stxxtc.h b/arch/ppc/platforms/stxxtc.h
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/stxxtc.h
@@ -0,0 +1,285 @@
+/*
+ * A collection of structures, addresses, and values associated with
+ * the STXXTC systems.
+ *
+ * Copyright (c) 2005 Pantelis Antoniou <pantelis.antoniou@gmail.com>
+ *                    Dan Malek <dan@embeddedalley.com>
+ *
+ */
+#ifndef __MACH_STXXTC_DEFS
+#define __MACH_STXXTC_DEFS
+
+#include <linux/config.h>
+
+#ifndef __ASSEMBLY__
+
+#include <asm/ppcboot.h>
+
+#include <asm/8xx_immap.h>
+#include <asm/commproc.h>
+#include <asm/mpc8xx.h>
+#include <asm/delay.h>
+
+#endif
+
+#define	IMAP_ADDR	0xFF000000		/* physical base address of IMMR area	*/
+#define IMAP_SIZE	(64 * 1024)		/* mapped size of IMMR area		*/
+
+/* We don't use the 8259.
+*/
+#define NR_8259_INTS	0
+
+#define NAND_SIZE	0x00010000
+#define NAND_BASE	0xF1000000
+
+/*-----------------------------------------------------------------------
+ * PCMCIA stuff
+ *-----------------------------------------------------------------------
+ *
+ */
+#define PCMCIA_MEM_SIZE		( 64 << 20 )
+
+#define	MAX_HWIFS	1	/* overwrite default in include/asm-ppc/ide.h	*/
+
+/*
+ * Definitions for IDE0 Interface
+ */
+#define IDE0_BASE_OFFSET		0
+#define IDE0_DATA_REG_OFFSET		(PCMCIA_MEM_SIZE + 0x320)
+#define IDE0_ERROR_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 1)
+#define IDE0_NSECTOR_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 2)
+#define IDE0_SECTOR_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 3)
+#define IDE0_LCYL_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 4)
+#define IDE0_HCYL_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 5)
+#define IDE0_SELECT_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 6)
+#define IDE0_STATUS_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 7)
+#define IDE0_CONTROL_REG_OFFSET		0x0106
+#define IDE0_IRQ_REG_OFFSET		0x000A	/* not used			*/
+
+#define	IDE0_INTERRUPT			13
+
+/* XXX FUCK!, for IDE disk set to 0, for normal PCMCIA set to 1 */
+/* XXX don't ask me why.. */
+#if 1
+/* define IO_BASE for PCMCIA */
+#define _IO_BASE 0x80000000
+#define _IO_BASE_SIZE  (64<<10)
+#endif
+
+/***********************************************************************/
+
+/* shorthand for the ports data registers */
+#define PORTA		(((volatile immap_t *)IMAP_ADDR)->im_ioport.iop_padat)
+#define PORTB		(((volatile immap_t *)IMAP_ADDR)->im_cpm.cp_pbdat)
+#define PORTC		(((volatile immap_t *)IMAP_ADDR)->im_ioport.iop_pcdat)
+#define PORTD		(((volatile immap_t *)IMAP_ADDR)->im_ioport.iop_pddat)
+#define PORTE		(((volatile immap_t *)IMAP_ADDR)->im_cpm.cp_pedat)
+
+/********************************************************************************/
+
+#define PIN_PORT_EQ(p, x)	((void *) & x ## _PORT == (void *) & p)
+#define PIN_PORT_NE(p, x)	((void *) & x ## _PORT != (void *) & p)
+
+#define PIN_PORT_RW(x)		(PIN_PORT_NE(PORTXWO, x) && PIN_PORT_NE(PORTXRO, x))
+#define PIN_PORT_RO(x)		PIN_PORT_EQ(PORTXRO, x)
+#define PIN_PORT_WO(x)		PIN_PORT_EQ(PORTXWO, x)
+
+/********************************************************************************/
+
+#define PIN_SFT(x) ((sizeof(x ## _PORT) * 8 - 1) - x ## _BIT)
+#define PIN_MSK(x) (1U << PIN_SFT(x))
+
+/********************************************************************************/
+
+/* normal m8xx pins */
+#define _PIN_HI(x) \
+	do { \
+		x ## _PORT |=  PIN_MSK(x); \
+	} while(0)
+
+#define _PIN_LO(x) \
+	do { \
+		x ## _PORT &= ~PIN_MSK(x); \
+	} while(0)
+
+#define _PIN_TGL(x) \
+	do { \
+		x ## _PORT ^=  PIN_MSK(x); \
+	} while(0)
+
+#define _PIN_GET(x) \
+	(!!(x ## _PORT & PIN_MSK(x)))
+
+#define _PIN_SET(x, v)	\
+	do { \
+		if (__builtin_constant_p(v)) { \
+			if ((v) != 0) \
+				_PIN_HI(x); \
+			else \
+				_PIN_LO(x); \
+		} else \
+			x ## _PORT = ( x ## _PORT & ~PIN_MSK(x)) | (!!(v) << PIN_SFT(x)); \
+	} while(0)
+
+#define _PIN_CFG_IN(x) \
+	do { \
+		if (PIN_PORT_EQ(PORTA, x)) \
+			PORTA_config(PIN_MSK(x), 0, 0); \
+		if (PIN_PORT_EQ(PORTB, x)) \
+			PORTB_config(PIN_MSK(x), 0, 0); \
+		if (PIN_PORT_EQ(PORTC, x)) \
+			PORTC_config(PIN_MSK(x), 0, 0); \
+		if (PIN_PORT_EQ(PORTD, x)) \
+			PORTD_config(PIN_MSK(x), 0, 0); \
+		if (PIN_PORT_EQ(PORTE, x)) \
+			PORTE_config(PIN_MSK(x), 0, 0); \
+	} while(0)
+
+#define _PIN_CFG_INT_ANY(x) \
+	do { \
+		if (PIN_PORT_EQ(PORTC, x)) \
+			PORTC_config(PIN_MSK(x), 0, 0); \
+	} while(0)
+
+#define _PIN_CFG_INT_FALL(x) \
+	do { \
+		if (PIN_PORT_EQ(PORTC, x)) \
+			PORTC_config(PIN_MSK(x), 0, 0); \
+	} while(0)
+
+#define _PIN_CFG_OUT(x, v) \
+	do { \
+		_PIN_SET(x, v); \
+		if (PIN_PORT_EQ(PORTA, x)) \
+			PORTA_config(0, PIN_MSK(x), 0); \
+		if (PIN_PORT_EQ(PORTB, x)) \
+			PORTB_config(0, PIN_MSK(x), 0); \
+		if (PIN_PORT_EQ(PORTC, x)) \
+			PORTC_config(0, PIN_MSK(x), 0); \
+		if (PIN_PORT_EQ(PORTD, x)) \
+			PORTD_config(0, PIN_MSK(x), 0); \
+		if (PIN_PORT_EQ(PORTE, x)) \
+			PORTE_config(0, PIN_MSK(x), 0); \
+	} while(0)
+
+#define _PIN_CFG_OUT_HI(x) _PIN_CFG_OUT(x, 1)
+#define _PIN_CFG_OUT_LO(x) _PIN_CFG_OUT(x, 0)
+
+#ifndef __ASSEMBLY__
+
+static inline void PORTA_config(uint inmsk, uint outmsk, uint dummy)
+{
+	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
+	ushort msk = (ushort)inmsk | (ushort)outmsk;
+
+	imap->im_ioport.iop_padir  = (imap->im_ioport.iop_padir & ~(ushort)inmsk) | (ushort)outmsk;
+	imap->im_ioport.iop_paodr &= ~msk;
+	imap->im_ioport.iop_papar &= ~msk;
+}
+
+static inline void PORTB_config(uint inmsk, uint outmsk, uint dummy)
+{
+	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
+	uint msk = inmsk | outmsk;
+
+	imap->im_cpm.cp_pbdir  = (imap->im_cpm.cp_pbdir & ~inmsk) | outmsk;
+	imap->im_cpm.cp_pbodr &= ~msk;
+	imap->im_cpm.cp_pbpar &= ~msk;
+}
+
+static inline void PORTC_config(uint inmsk, uint outmsk, uint fallmsk)
+{
+	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
+	ushort msk = (ushort)inmsk | (ushort)outmsk;
+
+	imap->im_ioport.iop_pcdir  = (imap->im_ioport.iop_pcdir & ~(ushort)inmsk) | (ushort)outmsk;
+	imap->im_ioport.iop_pcso  &= ~msk;
+	imap->im_ioport.iop_pcint  = (imap->im_ioport.iop_pcint & ~(ushort)inmsk) | ((ushort)fallmsk & (ushort)inmsk);
+	imap->im_ioport.iop_pcpar &= ~msk;
+}
+
+static inline void PORTD_config(uint inmsk, uint outmsk, uint dummy)
+{
+	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
+	ushort msk = (ushort)inmsk | (ushort)outmsk;
+
+	imap->im_ioport.iop_pddir  = (imap->im_ioport.iop_pddir & ~(ushort)inmsk) | (ushort)outmsk;
+	imap->im_ioport.iop_pdpar &= ~msk;
+}
+
+static inline void PORTE_config(uint inmsk, uint outmsk, uint dummy)
+{
+	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
+	uint msk = inmsk | outmsk;
+
+	imap->im_cpm.cp_pedir  = (imap->im_cpm.cp_pedir & ~inmsk) | outmsk;
+	imap->im_cpm.cp_peodr &= ~msk;
+	imap->im_cpm.cp_pepar &= ~msk;
+}
+
+/**********************************************/
+
+unsigned long pin_lock(void);
+void pin_unlock(unsigned long flags);
+
+#endif /* __ASSEMBLY */
+
+/******************************************************************************/
+
+/* NAND flash pins */
+
+#define F_ALE_PORT	PORTC
+#define F_ALE_BIT	15
+
+#define F_CLE_PORT	PORTB
+#define F_CLE_BIT	23
+
+#define F_CE_PORT	PORTA
+#define F_CE_BIT	7
+
+#define F_RY_BY_PORT	PORTA
+#define F_RY_BY_BIT	6
+
+/***********************************************************************/
+
+/* SPI pin definitions */
+
+#define SPI_RXD_PORT	PORTB
+#define SPI_RXD_BIT	28
+
+#define SPI_TXD_PORT	PORTB
+#define SPI_TXD_BIT	29
+
+#define SPI_CLK_PORT	PORTB
+#define SPI_CLK_BIT	30
+
+#define SPI_DELAY() 	udelay(1)
+
+#ifndef __ASSEMBLY__
+
+static inline unsigned int spi_transfer(unsigned int tx)
+{
+	unsigned int rx;
+	int i;
+
+	rx = 0;
+	for (i = 0; i < 8; i++) {
+		_PIN_SET(SPI_TXD, tx & 0x80);
+		tx <<= 1;
+		_PIN_TGL(SPI_CLK);
+		SPI_DELAY();
+		rx <<= 1;
+		rx |= _PIN_GET(SPI_RXD);
+		_PIN_TGL(SPI_CLK);
+		SPI_DELAY();
+	}
+
+	return rx;
+}
+
+#endif
+
+#define BOARD_CHIP_NAME "MPC870"
+
+#endif	/* __MACH_STXXTC_DEFS */
+
diff --git a/arch/ppc/platforms/stxxtc_setup.c b/arch/ppc/platforms/stxxtc_setup.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/stxxtc_setup.c
@@ -0,0 +1,193 @@
+/*
+ * arch/ppc/platforms/stxxtc.c
+ * 
+ * Platform setup for the Silicon Turnkey eXpress XTc
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+
+#include <asm/delay.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/page.h>
+#include <asm/processor.h>
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/ppcboot.h>
+#include <asm/ppc_sys.h>
+
+#include <linux/stddef.h>
+
+#include <linux/fs_enet_pd.h>
+
+#include <platforms/stxxtc.h>
+
+/***********************************************************************/
+
+#ifdef CONFIG_FW_ENV
+#include <syslib/fw_env.h>
+
+static const char *ro_vars[] = {
+	"ethaddr", "eth1addr", "adsladdr", "serial#", "usbaddr", "usb1addr", "ver", "board",
+	NULL
+};
+#endif
+
+/***********************************************************************/
+
+static spinlock_t port_spinlock;
+
+unsigned long pin_lock(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&port_spinlock, flags);
+	return flags;
+}
+EXPORT_SYMBOL(pin_lock);
+
+void pin_unlock(unsigned long flags)
+{
+	spin_unlock_irqrestore(&port_spinlock, flags);
+}
+EXPORT_SYMBOL(pin_unlock);
+
+/***********************************************************************/
+
+static struct fs_mii_bus_info fec_mii_bus_info = {
+        .method                 = fsmii_fec,
+        .id                     = 0,
+};
+
+static struct fs_platform_info mpc8xx_fec_pdata[2] = {
+	[0] = {
+		.phy_addr	= 0x01,
+		.phy_irq	= -1,
+		.fs_no		= fsid_fec1,
+		.rx_ring	= 128,
+		.tx_ring	= 16,
+		.napi_weight	= 17,
+		.bus_info	= &fec_mii_bus_info,
+		.rx_copybreak	= 240,
+		.use_napi	= 1,
+		.use_rmii	= 0,
+	},
+	[1] = {
+		.phy_addr	= 0x03,
+		.phy_irq	= -1,
+		.fs_no		= fsid_fec2,
+		.rx_ring	= 128,
+		.tx_ring	= 16,
+		.napi_weight	= 17,
+		.bus_info	= &fec_mii_bus_info,
+		.rx_copybreak	= 240,
+		.use_napi	= 1,
+		.use_rmii	= 0,
+	}
+};
+
+/***********************************************************************/
+
+static void stxxtc_fixup_fs_pdata(struct platform_device *pd, int fs_no)
+{
+	struct fs_platform_info *fpi;
+	bd_t *bd;
+	int idx;
+
+	idx = fs_get_fec_index(fs_no);
+	if (idx == -1) {
+		printk(KERN_ERR "stxxtc_setup: Only FEC ethernets supported by STXXTC.\n");
+		return;
+	}
+
+	fpi = &mpc8xx_fec_pdata[idx];
+
+	bd = (bd_t *)__res;
+
+	memcpy(fpi->macaddr, bd->bi_enetaddr, 6);
+	fpi->macaddr[5] += idx;	/* different per interface */
+
+	pd->dev.platform_data = fpi;
+
+	/* we don't setup *any* pins, we trust the bootloader */
+}
+
+static void stxxtc_fixup_fec_pdata(struct platform_device *pd, int idx)
+{
+	int fs_no = fsid_fec1 + pd->id - 1;
+
+	stxxtc_fixup_fs_pdata(pd, fs_no);
+}
+
+static int stxxtc_platform_notify(struct device *dev)
+{
+	static struct {
+		const char *bus_id;
+		void (*rtn)(struct platform_device * pdev, int idx);
+	} dev_map[] = {
+		{ "fsl-cpm-fec", stxxtc_fixup_fec_pdata },
+	};
+	struct platform_device *pdev;
+	int i, j, idx;
+	const char *s;
+
+	if (dev && dev->bus_id)
+		for (i = 0; i < ARRAY_SIZE(dev_map); i++) {
+			idx = -1;
+			if ((s = strrchr(dev->bus_id, '.')) != NULL)
+				idx = (int)simple_strtol(s + 1, NULL, 10);
+			else
+				s = dev->bus_id + strlen(s);
+
+			j = s - dev->bus_id;
+
+			if (!strncmp(dev->bus_id, dev_map[i].bus_id, j)) {
+				pdev = container_of(dev, struct platform_device, dev);
+				dev_map[i].rtn(pdev, idx);
+			}
+		}
+
+	return 0;
+}
+
+int __init
+stxxtc_init(void)
+{
+	immap_t *imap = (immap_t *)IMAP_ADDR;
+
+	spin_lock_init(&port_spinlock);
+
+	imap->im_siu_conf.sc_sypcr |= 0x0000FF00;
+
+	/* configure SPI pins */
+	_PIN_CFG_OUT_HI(SPI_TXD);
+	_PIN_CFG_OUT_HI(SPI_CLK);
+	_PIN_CFG_IN(SPI_RXD);
+
+	/* configure NAND pins */
+	_PIN_CFG_OUT_LO(F_ALE);
+	_PIN_CFG_OUT_LO(F_CLE);
+	_PIN_CFG_OUT_HI(F_CE);
+	_PIN_CFG_IN(F_RY_BY);
+
+	platform_notify = stxxtc_platform_notify;
+
+	identify_ppc_sys_by_name("MPC885");
+
+	/* remove these devices */
+	ppc_sys_device_remove(MPC8xx_CPM_SCC1);
+	ppc_sys_device_remove(MPC8xx_CPM_SCC2);
+	ppc_sys_device_remove(MPC8xx_CPM_SCC3);
+	ppc_sys_device_remove(MPC8xx_CPM_SCC4);
+
+	return 0;
+}
+
+arch_initcall(stxxtc_init);
+
diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
--- a/arch/ppc/syslib/m8xx_setup.c
+++ b/arch/ppc/syslib/m8xx_setup.c
@@ -370,16 +370,26 @@ m8xx_map_io(void)
 #if defined(CONFIG_NETTA)
 	io_block_mapping(_IO_BASE,_IO_BASE,_IO_BASE_SIZE, _PAGE_IO);
 #endif
+#if defined(CONFIG_STXXTC)
+ 	io_block_mapping(_IO_BASE,_IO_BASE,64 << 10, _PAGE_IO);
+#endif
 }
 
 void __init
 platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 		unsigned long r6, unsigned long r7)
 {
+	bd_t *bd;
+
 	parse_bootinfo(find_bootinfo());
 
-	if ( r3 )
-		memcpy( (void *)__res,(void *)(r3+KERNELBASE), sizeof(bd_t) );
+	if ( r3 ) {
+		bd = (bd_t *)(r3+KERNELBASE);
+		/* skip OF tree if present */
+		if (*(u32 *)bd == 0xd00dfeed)
+			bd = (bd_t *)((char *)bd + ((u32 *)bd)[1]);
+		memcpy(__res, bd, sizeof(bd_t));
+	}
 
 #ifdef CONFIG_PCI
 	m8xx_setup_pci_ptrs();
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -639,5 +639,11 @@ config MTD_PLATRAM
 
 	  This selection automatically selects the map_ram driver.
 
+config MTD_STXXTC_NOR
+	tristate "NOR Map driver for STXXTC NOR flash"
+	depends on STXXTC && MTD_CONCAT && MTD_PARTITIONS && MTD_CFI_INTELEXT
+	help
+	  Map driver for Silicon Turnkey eXpress XTc NOR flash. 
+
 endmenu
 
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -72,3 +72,4 @@ obj-$(CONFIG_MTD_PLATRAM)	+= plat-ram.o
 obj-$(CONFIG_MTD_OMAP_NOR)	+= omap_nor.o
 obj-$(CONFIG_MTD_MTX1)		+= mtx-1_flash.o
 obj-$(CONFIG_MTD_TQM834x)	+= tqm834x.o
+obj-$(CONFIG_MTD_STXXTC_NOR)	+= stxxtc_nor.o
diff --git a/drivers/mtd/maps/stxxtc_nor.c b/drivers/mtd/maps/stxxtc_nor.c
new file mode 100644
--- /dev/null
+++ b/drivers/mtd/maps/stxxtc_nor.c
@@ -0,0 +1,326 @@
+/*
+ * Handle mapping of the flash on the STXXTC board
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <asm/io.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/concat.h>
+
+/* Boot flash; same on every board */
+static struct mtd_info *stxxtc_mtd;
+
+#define SECTORSZ(x)	((x) * 64 * 1024)
+
+#define UBOOT_CODE_SECTORS	4
+
+#define ENV1_PART	0
+#define ENV2_PART	1
+
+#define CHKP1_PART	2
+#define CHKP2_PART	3
+
+#define STRG1_PART	4
+
+#define BOOT_PART	5
+
+#define STRG2_PART	6
+
+/* partition_info gives details on the logical partitions that the split the
+ * single flash device into. If the size if zero we use up to the end of the
+ * device. */
+static struct mtd_partition pi[]= {
+	[ENV1_PART] = {
+		.name		= "u-boot env #1 0 4000",
+		.size		= SECTORSZ(1),
+		.offset		= SECTORSZ(0),
+	},
+	[ENV2_PART] = {
+		.name		= "u-boot env #2 0 4000",
+		.size		= SECTORSZ(1),
+		.offset		= SECTORSZ(1),
+	},
+	[CHKP1_PART] = {
+		.name		= "checkpoint #1",
+		.size		= SECTORSZ(1),
+		.offset		= SECTORSZ(2),
+	},
+	[CHKP2_PART] = {
+		.name		= "checkpoint #2",
+		.size		= SECTORSZ(1),
+		.offset		= SECTORSZ(3),
+	},
+	[STRG1_PART] = {
+		.name		= "storage #1",
+		.size		= 0,	/* to be filled */
+		.offset		= SECTORSZ(4),
+	},
+	[BOOT_PART] = {
+		.name		= "u-boot code",
+		.size		= SECTORSZ(UBOOT_CODE_SECTORS),
+		.offset		= 0,	/* to be filled */
+		.mask_flags	= MTD_WRITEABLE,	/* don't allow writes at all */
+	},
+	[STRG2_PART] = {
+		.name		= "storage #2",
+		.size		= 0,	/* what ever remains */
+		.offset		= 0,	/* to be filled */
+	}
+};
+
+#define NUM_PARTITIONS (sizeof(pi) / sizeof(pi[0]))
+
+#define WINDOW_ADDR	0x40000000
+#define WINDOW_SIZE	0x00200000
+
+struct map_info stxxtc_map = {
+	.name		= "STXXTC boot flash",
+	.size		= WINDOW_SIZE,
+	.bankwidth	= 2,
+	.phys		= WINDOW_ADDR,
+};
+
+/* two chips supported */
+#define NR_CHIPS	2
+
+struct stxxtc_nor_info {
+	unsigned long base;
+	unsigned long map_size;
+	char *mapname;
+	int width;
+	struct map_info map;
+	struct mtd_info *mtd;
+	struct resource *res;
+};
+
+static struct stxxtc_nor_info info[NR_CHIPS] = {
+	{
+		.base		= 0x40000000,
+		.map_size	= 0x01000000,
+		.width		= 2,
+		.mapname	= "stxxtc NOR flash #1",
+	}, {
+		.base		= 0x42000000,
+		.map_size	= 0x01000000,
+		.width		= 2,
+		.mapname	= "stxxtc NOR flash #2",
+	}
+};
+
+#if 1
+
+int __init init_stxxtc_nor(void)
+{
+	struct stxxtc_nor_info *ni;
+	int i, j, r = 0, found = 0;
+	unsigned long mask, off;
+	struct mtd_info *subdev[NR_CHIPS];
+
+	memset(subdev, 0, sizeof(subdev));
+
+	for (i = 0, ni = info; i < NR_CHIPS; i++, ni++) {
+
+		memset(&ni->map, 0, sizeof(ni->map));
+
+		ni->res = request_mem_region(ni->base, ni->map_size, ni->mapname);
+		if (ni->res == NULL) {
+			r = -EBUSY;
+			goto err;
+		}
+
+		ni->map.virt = ioremap(ni->base, ni->map_size);
+		if (ni->map.virt == NULL) {
+			r = -ENOMEM;
+			goto err;
+		}
+		ni->map.name = ni->mapname;
+		ni->map.phys = ni->base;
+		ni->map.bankwidth = 2;
+		ni->map.size = ni->map_size;
+		simple_map_init(&ni->map);
+
+		ni->mtd = do_map_probe("cfi_probe", &ni->map);
+		if (ni->mtd == NULL) {
+			/* chip missing; just cleanup and continue */
+			iounmap(ni->map.virt);
+			release_resource(ni->res);
+			ni->res = NULL;
+			memset(&ni->map, 0, sizeof(ni->map));
+			continue;
+		}
+
+		ni->mtd->owner = THIS_MODULE;
+
+		found++;
+
+	}
+
+	/* no chips found... */
+	if (found == 0) {
+		printk(KERN_INFO "stxxtc_nor: No devices found\n");
+		return -ENXIO;
+	}
+
+	/* first chip must exist. */
+	ni = &info[0]; i = 0; j = 0;
+	if (ni->mtd == NULL) {
+		printk(KERN_INFO "stxxtc_nor: First chip missing, not able to continue\n");
+		r = -ENXIO;
+		goto err;
+	}
+
+	printk(KERN_INFO "stxxtc_nor: CFI device found at 0x%08lx, "
+			"%dMiB, %d-bit wide\n", 
+			ni->base, ni->mtd->size >> 20, ni->width * 8);
+
+	/* find out where u-boot code is. It's size is 256K and is located
+	 * at the last megabyte of the first flash, for example a 2M flash
+	 * will have the u-boot part at offset 0x00100000
+	 */
+
+	mask = ni->mtd->size - 1;
+	off = 0xFFF00000 & mask;
+	printk(KERN_INFO "u-boot offset is at 0x%08lx\n", off);
+
+	/* keep it */
+	subdev[j++] = ni->mtd;
+
+	/* next */
+	i++; ni++;
+
+	/* report what we found */
+	for (; i < NR_CHIPS; i++, ni++) {
+		if (ni->mtd == NULL)
+			continue;
+		printk(KERN_INFO "stxxtc_nor: CFI device found at 0x%08lx, "
+				"%dMiB, %d-bit wide\n", 
+				ni->base, ni->mtd->size >> 20, ni->width * 8);
+		subdev[j++] = ni->mtd;
+	}
+
+	/* concat all the devices into one */
+	stxxtc_mtd = mtd_concat_create(subdev, found, "stxxtc NOR flash");
+	if (stxxtc_mtd == NULL) {
+		r = -ENXIO;
+		goto err;
+	}
+	stxxtc_mtd->owner = THIS_MODULE;
+
+	/* fixup partitions */
+	pi[STRG1_PART].size	= off - pi[STRG1_PART].offset;
+	pi[BOOT_PART].offset 	= off;
+	pi[STRG2_PART].offset	= pi[BOOT_PART].offset + pi[BOOT_PART].size;
+
+	add_mtd_partitions(stxxtc_mtd, pi, NUM_PARTITIONS);
+
+	return 0;
+
+err:
+	if (stxxtc_mtd != NULL) {
+		del_mtd_partitions(stxxtc_mtd);
+		mtd_concat_destroy(stxxtc_mtd);
+	}
+
+	for (i = NR_CHIPS - 1, ni = info + i; i >= 0; i--, ni--) {
+		if (ni->mtd)
+			map_destroy(ni->mtd);
+		if (ni->map.virt)
+			iounmap(ni->map.virt);
+		if (ni->res != NULL)
+			release_resource(ni->res);
+	}
+
+
+	return r;
+}
+
+static void __exit cleanup_stxxtc_nor(void)
+{
+	int i;
+	struct stxxtc_nor_info *ni;
+
+	if (stxxtc_mtd != NULL) {
+		del_mtd_partitions(stxxtc_mtd);
+		mtd_concat_destroy(stxxtc_mtd);
+	}
+
+	for (i = NR_CHIPS - 1, ni = info + i; i >= 0; i--, ni--) {
+		if (ni->mtd)
+			map_destroy(ni->mtd);
+		if (ni->map.virt)
+			iounmap(ni->map.virt);
+		if (ni->res != NULL)
+			release_resource(ni->res);
+	}
+
+}
+
+#else
+
+int __init init_stxxtc_nor(void)
+{
+	int err = 0;
+	static const char *probes[] = { "cfi_probe", NULL };
+	const char **sv, *s;
+
+	stxxtc_map.virt = (void __iomem *)ioremap(WINDOW_ADDR, WINDOW_SIZE);
+	if (!stxxtc_map.virt) {
+		printk("stxxtc_nor: Failed to ioremap\n");
+		err = -ENXIO;
+		goto out;
+	}
+	simple_map_init(&stxxtc_map);
+
+	sv = probes;
+	while ((s = *sv++) != NULL) {
+		stxxtc_mtd = do_map_probe(s, &stxxtc_map);
+		if (stxxtc_mtd != NULL)
+			break;
+	}
+
+	if (!stxxtc_mtd) {
+		printk(KERN_NOTICE "stxxtc_nor: probe failed flash device: %x at %x\n", WINDOW_SIZE, WINDOW_ADDR);
+		err = -ENXIO;
+		goto out_unmap;
+	}
+
+	stxxtc_mtd->owner = THIS_MODULE;
+	add_mtd_partitions(stxxtc_mtd, pi, NUM_PARTITIONS);
+
+	return 0;
+
+out_unmap:
+	iounmap((void *)stxxtc_map.virt);
+out:
+
+	return err;
+}
+
+static void __exit cleanup_stxxtc_nor(void)
+{
+	if (stxxtc_mtd) {
+		del_mtd_partitions(stxxtc_mtd);
+		map_destroy(stxxtc_mtd);
+		stxxtc_mtd = 0;
+	}
+	if (stxxtc_map.virt) {
+		iounmap(stxxtc_map.virt);
+		stxxtc_map.virt = 0;
+	}
+}
+
+#endif
+
+module_init(init_stxxtc_nor);
+module_exit(cleanup_stxxtc_nor);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Pantelis Antoniou <pantelis.antoniou@gmail.com>");
+MODULE_DESCRIPTION("MTD map driver for STXXTC boards");
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -190,5 +190,11 @@ config MTD_NAND_DISKONCHIP_BBTWRITE
 	help
 	  The simulator may simulate verious NAND flash chips for the
 	  MTD nand layer.
- 
+
+config MTD_NAND_STXXTC
+	tristate "NAND Flash support for STXXTC"
+	depends on STXXTC && MTD_NAND
+	help
+	  Use the NAND flash present on Silicon Turnkey eXpress XTc.
+
 endmenu
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -18,5 +18,6 @@ obj-$(CONFIG_MTD_NAND_H1900)		+= h1910.o
 obj-$(CONFIG_MTD_NAND_RTC_FROM4)	+= rtc_from4.o
 obj-$(CONFIG_MTD_NAND_SHARPSL)		+= sharpsl.o
 obj-$(CONFIG_MTD_NAND_NANDSIM)		+= nandsim.o
+obj-$(CONFIG_MTD_NAND_STXXTC)		+= stxxtc_nand.o
 
 nand-objs = nand_base.o nand_bbt.o
diff --git a/drivers/mtd/nand/stxxtc_nand.c b/drivers/mtd/nand/stxxtc_nand.c
new file mode 100644
--- /dev/null
+++ b/drivers/mtd/nand/stxxtc_nand.c
@@ -0,0 +1,277 @@
+/*
+ *  drivers/mtd/nand/stxxtc_nand.c
+ *
+ *  Copyright (C) 2005 Pantelis Antoniou <pantelis.antoniou@gmail.com>
+ *                     Dan Malek <dan@embeddedalley.com>
+ *
+ *  Derived from drivers/mtd/nand/edb7312.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/config.h>
+
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/init.h>
+#include <asm/io.h>
+#include <asm/semaphore.h>
+
+#include <platforms/stxxtc.h>
+
+/******************************************************************************/
+
+static struct mtd_info *stxxtc_mtd = NULL;
+static unsigned int stxxtc_fio_base;
+static int mtd_parts_nb = 0;
+static struct mtd_partition *mtd_parts;
+static const char *part_type = NULL;
+static const char *part_probes[] = { "cmdlinepart", NULL };
+
+/* we need these */
+extern struct semaphore mtd_table_mutex;
+extern struct mtd_info *mtd_table[MAX_MTD_DEVICES];
+
+/******************************************************************************/
+
+/* 
+ * hardware specific access to control-lines
+ */
+static void stxxtc_hwcontrol(struct mtd_info *mtd, int cmd) 
+{
+	unsigned long flags;
+	
+	local_irq_save(flags);
+
+	switch (cmd) {
+
+		case NAND_CTL_SETNCE:
+			_PIN_LO(F_CE);
+			break;
+
+		case NAND_CTL_CLRNCE:
+			_PIN_HI(F_CE);
+			break;
+
+		case NAND_CTL_SETCLE:
+			_PIN_HI(F_CLE);
+			break;
+
+		case NAND_CTL_CLRCLE:
+			_PIN_LO(F_CLE);
+			break;
+
+		case NAND_CTL_SETALE:
+			_PIN_HI(F_ALE);
+			break;
+
+		case NAND_CTL_CLRALE:
+			_PIN_LO(F_ALE);
+			break;
+	}
+
+	local_irq_restore(flags);
+}
+
+/*
+ *	read device ready pin
+ */
+static int stxxtc_device_ready(struct mtd_info *mtd)
+{
+	return _PIN_GET(F_RY_BY);
+}
+
+/*
+ * Main initialization routine
+ */
+static int __init stxxtc_init(void)
+{
+	struct nand_chip *this = NULL;
+	int i, j, err = 0, rootidx;
+	const char *s, *rootmark="root=/dev/mtdblock";
+	unsigned int curroff, sz;
+	struct mtd_partition *part;
+	
+	/* Allocate memory for MTD device structure and private data */
+	stxxtc_mtd = kmalloc(sizeof(struct mtd_info) + sizeof(struct nand_chip), GFP_KERNEL);
+	if (!stxxtc_mtd) {
+		printk("Unable to allocate STXXTC NAND MTD device structure.\n");
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* map physical adress */
+	stxxtc_fio_base = (unsigned long)ioremap(NAND_BASE, NAND_SIZE);
+	if(!stxxtc_fio_base) {
+		printk("ioremap STXXTC NAND flash failed\n");
+		err = -EIO;
+		goto out;
+	}
+	
+	/* Get pointer to private data */
+	this = (struct nand_chip *)&stxxtc_mtd[1];
+	
+	/* Initialize structures */
+	memset((char *) stxxtc_mtd, 0, sizeof(struct mtd_info));
+	memset((char *) this, 0, sizeof(struct nand_chip));
+	
+	/* Link the private data with the MTD structure */
+	stxxtc_mtd->priv = this;
+	
+	/* insert callbacks */
+	this->IO_ADDR_R = (void __iomem *)stxxtc_fio_base;
+	this->IO_ADDR_W = (void __iomem *)stxxtc_fio_base;
+	this->hwcontrol = stxxtc_hwcontrol;
+	this->dev_ready = stxxtc_device_ready;
+	/* 15 us command delay time (XXX actually not used) */
+	this->chip_delay = 15;
+	/* TODO F_RY_BY pin is interrupt capable but it's not used as such */
+	this->eccmode = NAND_ECC_SOFT;
+	
+	/* Scan to find existence of the device (minimum size is 8MiB) */
+	if (nand_scan(stxxtc_mtd, 1) || stxxtc_mtd->size < 8 * 1024 * 1024) {
+		err = -ENXIO;
+		goto out;
+	}
+
+	/* Set internal data buffer */
+	this->data_buf = kmalloc(stxxtc_mtd->oobblock + stxxtc_mtd->oobsize, GFP_KERNEL);
+	if (this->data_buf == NULL) {
+		printk(KERN_ERR "stxxtc_nand: Unable to allocate data buffer\n");
+		err = -ENOMEM;
+		goto out;
+	}
+
+
+#ifdef CONFIG_MTD_CMDLINE_PARTS
+	stxxtc_mtd->name = "stxxtc-nand";
+	mtd_parts_nb = parse_mtd_partitions(stxxtc_mtd, part_probes, &mtd_parts, 0);
+	if (mtd_parts_nb > 0)
+		part_type = "command line";
+	else
+		mtd_parts_nb = 0;
+#endif
+	if (mtd_parts_nb == 0) {
+
+		mtd_parts_nb = 3;
+
+		mtd_parts = kmalloc(sizeof(*mtd_parts) * mtd_parts_nb, GFP_KERNEL);
+		if (mtd_parts == NULL) {
+			printk(KERN_ERR "stxxtc_nand: Unable to allocate partition table buffer\n");
+			err = -ENOMEM;
+			goto out;
+		}
+		memset(mtd_parts, 0, sizeof(*mtd_parts) * mtd_parts_nb);
+
+		part = mtd_parts;
+
+		curroff = 0;
+
+		sz = (stxxtc_mtd->size - 512 * 1024) / 2;
+
+		part->name	= "STXXTC root fs #1";
+		part->offset	= curroff;
+		part->size	= sz;
+		/* part->mask_flags= MTD_WRITEABLE; */
+		part++;
+		curroff += sz;
+
+		part->name	= "STXXTC root fs #2";
+		part->offset	= curroff;
+		part->size	= sz;
+		part++;
+		curroff += sz;
+
+		part->name	= "Persistent storage";
+		part->offset	= curroff;
+		part->size	= stxxtc_mtd->size - curroff;
+		part++;
+
+		part_type = "static";
+	}
+
+	/* lookup index of root MTD partition (if any) */
+	if ((s = strstr(saved_command_line, rootmark)) != NULL) {
+
+		rootidx = simple_strtoul(s + strlen(rootmark), NULL, 10);
+
+		/* XXX we assume that no-one will interrupts afterwards */
+		down(&mtd_table_mutex);
+		for (i = 0, j = 0; i < MAX_MTD_DEVICES; i++) {
+
+			if (mtd_table[i] != NULL)
+				continue;
+
+			if (i == rootidx) {
+				printk(KERN_INFO "stxxtc_nand: Marking root device mtd%d as read-only (%d)\n", i, j);
+				mtd_parts[j].mask_flags = MTD_WRITEABLE;
+				break;
+			}
+
+			if (++j >= mtd_parts_nb)
+				break;
+		}
+		up(&mtd_table_mutex);
+
+	}
+
+	/* Register the partitions */
+	printk(KERN_NOTICE "Using %s partition definition\n", part_type);
+	err = add_mtd_partitions(stxxtc_mtd, mtd_parts, mtd_parts_nb);
+	if (err != 0) {
+		printk(KERN_ERR "stxxtc_nand: Unable to add mtd partitions\n");
+		goto out;
+	}
+
+	kfree(mtd_parts);
+	mtd_parts = NULL;
+
+	return 0;
+
+out:
+	if (mtd_parts)
+		kfree(mtd_parts);
+	if (stxxtc_fio_base)
+		iounmap((void *)stxxtc_fio_base);
+	if (this && this->data_buf)
+		kfree(this->data_buf);
+	if (stxxtc_mtd)
+		kfree(stxxtc_mtd);
+	return err;
+}
+
+/*
+ * Clean up routine
+ */
+static void __exit stxxtc_cleanup(void)
+{
+	struct nand_chip *this = (struct nand_chip *) &stxxtc_mtd[1];
+
+	/* Unregister the device */
+	del_mtd_device(stxxtc_mtd);
+	
+	/* unmap */
+	iounmap((void *)stxxtc_fio_base);
+
+	/* free data buffer */
+	kfree(this->data_buf);
+
+	/* Free the MTD device structure */
+	kfree(stxxtc_mtd);
+}
+
+module_init(stxxtc_init);
+module_exit(stxxtc_cleanup);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Pantelis Antoniou <pantelis.antoniou@gmail.com>");
+MODULE_DESCRIPTION("MTD map driver for STXXTC");
+
+
diff --git a/include/asm-ppc/mpc8xx.h b/include/asm-ppc/mpc8xx.h
--- a/include/asm-ppc/mpc8xx.h
+++ b/include/asm-ppc/mpc8xx.h
@@ -68,6 +68,10 @@
 #include <platforms/mpc885ads.h>
 #endif
 
+#if defined(CONFIG_STXXTC)
+#include <platforms/stxxtc.h>
+#endif
+
 /* Currently, all 8xx boards that support a processor to PCI/ISA bridge
  * use the same memory map.
  */
