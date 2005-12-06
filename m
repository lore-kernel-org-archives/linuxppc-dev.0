Return-Path: <pantelis.antoniou@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.206])
	by ozlabs.org (Postfix) with ESMTP id 28629688AF
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 08:50:53 +1100 (EST)
Received: by nproxy.gmail.com with SMTP id m18so54714nfc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 06 Dec 2005 13:50:53 -0800 (PST)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Dan Malek <dan@embeddededge.com>, linuxppc-embedded@ozlabs.org
Date: Tue, 6 Dec 2005 23:58:47 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200512062358.47700.pantelis.antoniou@gmail.com>
Subject: [PATCH] ppc32-8xx: STXXTC core board support.
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

Support Silicon Turnkey's XTc board. Core.

---
commit 76d9ad9d0440e6f26ff87899284a90cd865dd330
tree b2e28d3a62e2fa47ca75579a04d579dfc41a36a5
parent 978475b1cf2b5b060bd07321ec482918966ac20b
author Pantelis Antoniou <pantelis.antoniou@gmail.com> Tue, 06 Dec 2005 23:17:43 +0200
committer Pantelis Antoniou <pantelis.antoniou@gmail.com> Tue, 06 Dec 2005 23:17:43 +0200

 arch/ppc/Kconfig                  |    5 
 arch/ppc/configs/stxxtc_defconfig |  804 +++++++++++++++++++++++++++++++++++++
 arch/ppc/platforms/Makefile       |    1 
 arch/ppc/platforms/stxxtc.h       |  136 ++++++
 arch/ppc/platforms/stxxtc_setup.c |  202 +++++++++
 arch/ppc/syslib/m8xx_setup.c      |    3 
 include/asm-ppc/mpc8xx.h          |    4 
 7 files changed, 1155 insertions(+), 0 deletions(-)

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
+CONFIG_PIN_TLB=y
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
@@ -0,0 +1,136 @@
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
+#define IMAP_ADDR	0xFF000000		/* physical base address of IMMR area	*/
+#define IMAP_SIZE	(64 * 1024)		/* mapped size of IMMR area		*/
+
+/* NOTE: must be included after the IMAP_ADDR definition */
+#include <asm/8xx_pin.h>
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
+/* TODO: Investigate why direct ide disk mode need these undefined */
+/* define IO_BASE for PCMCIA */
+#define _IO_BASE 0x80000000
+#define _IO_BASE_SIZE  (64<<10)
+
+/******************************************************************************/
+
+#ifndef __ASSEMBLY__
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
@@ -0,0 +1,202 @@
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
+struct platform_notify_dev_map {
+	const char *bus_id;
+	void (*rtn)(struct platform_device * pdev, int idx);
+};
+
+static void platform_notify_map(const struct platform_notify_dev_map *map,
+		struct device *dev)
+{
+	struct platform_device *pdev;
+	int len, idx;
+	const char *s;
+
+	/* do nothing if no device or no bus_id */
+	if (!dev || !dev->bus_id)
+		return;
+
+	/* call per device map */
+	while (map->bus_id != NULL) {
+		idx = -1;
+		s = strrchr(dev->bus_id, '.');
+		if (s != NULL)
+			idx = (int)simple_strtol(s + 1, NULL, 10);
+		else
+			s = dev->bus_id + strlen(s);
+
+		len = s - dev->bus_id;
+
+		if (!strncmp(dev->bus_id, map->bus_id, len)) {
+			pdev = container_of(dev, struct platform_device, dev);
+			map->rtn(pdev, idx);
+		}
+		map++;
+	}
+}
+
+static int stxxtc_platform_notify(struct device *dev)
+{
+	static const struct platform_notify_dev_map dev_map[] = {
+		{
+			.bus_id = "fsl-cpm-fec",
+			.rtn	= stxxtc_fixup_fec_pdata
+		}, {
+			.bus_id	= NULL,
+		},
+	};
+	
+	platform_notify_map(dev_map, dev);
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
@@ -370,6 +370,9 @@ m8xx_map_io(void)
 #if defined(CONFIG_NETTA)
 	io_block_mapping(_IO_BASE,_IO_BASE,_IO_BASE_SIZE, _PAGE_IO);
 #endif
+#if defined(CONFIG_STXXTC)
+ 	io_block_mapping(_IO_BASE,_IO_BASE, _IO_BASE_SIZE, _PAGE_IO);
+#endif
 }
 
 void __init
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
