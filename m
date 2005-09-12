Return-Path: <mqy@263.net.cn>
Received: from smtp.263.net (smtp.263.net [211.150.96.25])
	by ozlabs.org (Postfix) with ESMTP id 9A08768221
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Sep 2005 23:46:44 +1000 (EST)
Received: from image (smtp2 [127.0.0.1])
	by smtp.263.net (Postfix) with ESMTP id 02C34936
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Sep 2005 21:46:44 +0800 (CST) (envelope-from mqy@263.net.cn)
From: "KylongMu" <mqy@263.net.cn>
To: <linuxppc-embedded@ozlabs.org>
Date: Mon, 12 Sep 2005 21:46:34 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_001D_01C5B7E3.7238C730"
Message-Id: <20050912134644.02C34936@smtp.263.net>
Subject: "Lost interrupt" with promise20268 PCI-IDE chard on mpc8540_ads
	platform!
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_001D_01C5B7E3.7238C730
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, all
        Please help solve this problem , or give me some advise .
Thanks a lot !


Distribution: kernel from kernel.org , cross compiler from www.DENX.de
Hardware Environment: mpc8540_ads demo board + promise20268 PCI-IDE chard +
HD
Software Environment: kernel from kernel.org , cross compiler for powerpc
from www.DENX.de , and simple file system with busybox.
Problem Description:
    The kernel shows "lost interrupt" after the promise20268 PCI-IDE card be
finded , and the /proc/partitions shows correct message , but when mount the
HD , it shows " lost interrupt " again

Steps to reproduce: Include the .config file and the steps of boot are below
.

.config file
#-----------------start here------------------------
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.13
# Fri Sep  9 15:48:15 2005
#
CONFIG_MMU=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_GENERIC_NVRAM=y
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
# CONFIG_HOTPLUG is not set
CONFIG_KOBJECT_UEVENT=y
# CONFIG_IKCONFIG is not set
CONFIG_EMBEDDED=y
# CONFIG_KALLSYMS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
# CONFIG_EPOLL is not set
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Processor
#
# CONFIG_6xx is not set
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_POWER3 is not set
# CONFIG_POWER4 is not set
# CONFIG_8xx is not set
# CONFIG_E200 is not set
CONFIG_E500=y
CONFIG_BOOKE=y
CONFIG_FSL_BOOKE=y
# CONFIG_PHYS_64BIT is not set
CONFIG_SPE=y
CONFIG_MATH_EMULATION=y
# CONFIG_KEXEC is not set
# CONFIG_CPU_FREQ is not set
# CONFIG_WANT_EARLY_SERIAL is not set
CONFIG_PPC_GEN550=y
CONFIG_85xx=y
CONFIG_PPC_INDIRECT_PCI_BE=y

#
# Freescale 85xx options
#
CONFIG_MPC8540_ADS=y
# CONFIG_MPC8548_CDS is not set
# CONFIG_MPC8555_CDS is not set
# CONFIG_MPC8560_ADS is not set
# CONFIG_SBC8560 is not set
# CONFIG_STX_GP3 is not set
CONFIG_MPC8540=y

#
# Platform options
#
# CONFIG_HIGHMEM is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_PM is not set
CONFIG_SECCOMP=y
CONFIG_ISA_DMA_API=y

#
# Bus options
#
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# Advanced setup
#
# CONFIG_ADVANCED_OPTIONS is not set

#
# Default settings for advanced configuration options are used
#
CONFIG_HIGHMEM_START=0xfe000000
CONFIG_LOWMEM_SIZE=0x30000000
CONFIG_KERNEL_START=0xc0000000
CONFIG_TASK_SIZE=0x80000000
CONFIG_BOOT_LOAD=0x00800000

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_IP_TCPDIAG=y
# CONFIG_IP_TCPDIAG_IPV6 is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=32768
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_LBD=y
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_SL82C105 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
CONFIG_BLK_DEV_PDC202XX_NEW=y
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Macintosh device drivers
#

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_NET_PCI is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SKGE is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set
CONFIG_GIANFAR=y
CONFIG_GFAR_NAPI=y

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
# CONFIG_SERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
# CONFIG_VT is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
CONFIG_GEN_RTC=y
# CONFIG_GEN_RTC_X is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_RAW_DRIVER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_ISA is not set
CONFIG_I2C_MPC=y
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set
# CONFIG_I2C_SENSOR is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_SENSORS_M41T00 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
# CONFIG_USB is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# SN Devices
#

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set

#
# XFS support
#
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_NFSD is not set
CONFIG_ROOT_NFS=y
CONFIG_LOCKD=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
CONFIG_SOLARIS_X86_PARTITION=y
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=y
CONFIG_LDM_DEBUG=y
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_SERIAL_TEXT_DEBUG is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Hardware crypto devices
#
#-----------------config file end here------------------------


Kernel boot message and opp steps:

         #################################################################  


U-Boot 1.1.2(pq3-20040622-0) (Sep 27 2004 - 16:46:03)              
         ##########################################################     

    Core:   E500, Version: 2.0, (0x80200020)              
done   
Bytes transferred = 1292138 (13b76a hex)rsion: 2.0,
(0x80300020)               
MPC8540SK=> bootm 400000 ff800000locks: CPU: 833 MHz             
## Booting image at 00400000 ...Hz                       
    
   Image Name:   Linux-2.6.13            
            LBC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)che 32KB
enabled.                                           
   Data Size:    1292074 Bytes =  1.2 MBev.
B.                                 
   Load Address: 00000000ot Flash is U13         
   Entry Point:  00000000I1:   32 bit            
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)

    Net:    MOTO ENET0: PHY is Marvell 88E111
   Data Size:    4710501 Bytes =  4.5 MB                           
          
   Load Address: 00000000l 88E1111S (1410cc1)    
   Entry Point:  00000000                        
   Verifying Checksum ... OK is Realtek RTL8201CP (8201)
   Loading Ramdisk to 07750000, end 07bce065 ... OK  
            MOTO ENET0, MOTO ENET1, MOTO ENET2
Memory CAM mapping: CAM0=64Mb, CAM1=64Mb, CAM2=0Mb residual: 0Mbp autoboot: 
0                               

MPC8540SK=>    
Linux version 2.6.13 (root@mqy-linux) (gcc version 3.3.3 (DENX ELDK 3.1.1
3.0,
full duplex                      
Using MOTO ENET0 de                
Freeing initrd memory: 4600k freed
    DRAM:   Initializing        
NET: Registered protocol family 16              
    DDR:    128 MB
PCI: Probing PCI hardwareSH:  8 MB               
NTFS driver 2.1.23 [Flags: R/W DEBUG].               
    In:     serial  
Generic RTC Driver v1.07   serial              
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
disabledrvell
88E1111S (1410cc1)                                                
ttyS0 at MMIO 0xe0004500 (irq = 26) is a 16550A88E1111S
(1410cc1)                            
ttyS1 at MMIO 0xe0004600 (irq = 26) is a 16550AET2: PHY is Realtek RTL8201CP
(8201)          
io scheduler noop registered              
           
io scheduler anticipatory registered                                   
io scheduler deadline registeredboot:  0                       
io scheduler cfq registered00000 uImage              
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024
Using MOTO ENET0 device                      
           
eth1: Gianfar Ethernet Controller Version 1.1,
00:e0:0c:40:01:03####################################################

 
eth1: Running with NAPI enabled                             

eth1: 256/256 RX/TX BD ring size################################
eth2: Gianfar Ethernet Controller Version 1.1,
00:e0:0c:40:02:03                 
         ####################################
eth2: Running with NAPI enabled                              
eth2: 256/256 RX/TX BD ring sizensferred = 1264114 (1349f2 hex)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2 4000000
ff800000                                 
## B
ide: Assuming 33MHz system bus speed for P                
Bad Magic Nu         
    ide2: BM-DMA at 0xffffd0-0xffffd7, BIOS settings: hde:pio,
hdf:pio                       
   Load Address: 00000000                   
    ide3: BM-DMA at 0xffffd8-0xffffdf, BIOS settings: hdg:pio,
hdh:piohecksum ... OK                           
   Uncompressing Kernel Ima
hde: QUANTUM FIREBALL CR8.4A, ATA DISK drive
## Loading RAMDisk Image at ff800000 ...  
ide2 at 0xfffff8-0xffffff,0xfffff6 on irq 50e Name:   MPC85xx
ramdisk                  
hde: max request size: 128KiB PowerPC Linux RAMDisk Image
hde: lost interrupt                  
hde: lost interrupt                  
hde: lost interrupt710501 Bytes =  4.5
hde: lost interrupt                  
PDC202XX: Primary channel reset.ux version 2.6.13 (root@mqy-linu
hde: DMA interrupt recoveryELDK 3.1.1 3.3.3-         
hde: lost interrupt                  
 hde1    
i2c /dev entries driver #11 Sun Sep 4 12:52:07
NET: Registered protocol family 2         
Built 1 zonelists    
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
0,115200                                                     
TCP established hash table entries: 8192 (order: 4, 65536
bytes)                                                         
PID h
TCP bind hash table entries: 8192 (order: 3, 32768
bytes)                                          
Dentry cache
TCP: Hash tables configured (e                            
RAMDISK: Compressed image found at block 0                          
Mount-cache ha
VFS: Mounted root (ext2 filesystem).                  
checking if imag
Freeing unused kernel memory: 336k init); looks like an initrd

INIT: version 2.78 booting                         
INIT: Entering runlevel: 2emory: 4600k freed       

Welcome to Linux on Puff!NET: Registered protocol
PuffLinux login: root                    
PuffLinux:root$cat /proc/partitions              

33      0       hde    
33      1       hde1   
PuffLinux:root$cd /dev
PuffLinux:dev$mknod hde b 33 0
PuffLinux:dev$mknod hde1 b 33 1
PuffLinux:dev$mount /dev/hde1 /mnt
hde: dma_timer_expiry: dma status == 0x24
PDC202XX: Primary channel reset.
hde: DMA interrupt recovery
hde: lost interrupt
hde: dma_timer_expiry: dma status == 0x24
PDC202XX: Primary channel reset.
hde: DMA interrupt recovery
hde: lost interrupt
hde: dma_timer_expiry: dma status == 0x24
PDC202XX: Primary channel reset.
hde: DMA interrupt recovery
hde: lost interrupt
hde: dma_timer_expiry: dma status == 0x24
PDC202XX: Primary channel reset.
hde: DMA interrupt recovery
hde: lost interrupt
FAT: codepage cp437 not found
mount: wrong fs type, bad option, bad superblock on /dev/hde1,
       or too many mounted file systems
PuffLinux:dev$



------=_NextPart_000_001D_01C5B7E3.7238C730
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE></TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2722" name=3DGENERATOR></HEAD>
<BODY><!-- Converted from text/plain format -->
<P><FONT size=3D2>Hi, all<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Please=20
help solve this problem , or give me some advise .<BR>Thanks a lot=20
!<BR><BR><BR><STRONG>Distribution:</STRONG> kernel from kernel.org , =
cross=20
compiler from www.DENX.de<BR><STRONG>Hardware Environment:</STRONG> =
mpc8540_ads=20
demo board + promise20268 PCI-IDE chard + HD<BR><STRONG>Software=20
Environment:</STRONG> kernel from kernel.org , cross compiler for =
powerpc from=20
www.DENX.de , and simple file system with busybox.<BR><STRONG>Problem=20
Description:</STRONG><BR>&nbsp;&nbsp;&nbsp; The kernel shows "lost =
interrupt"=20
after the promise20268 PCI-IDE card be<BR>finded , and the =
/proc/partitions=20
shows correct message , but when mount the<BR>HD , it shows " lost =
interrupt "=20
again<BR><BR><STRONG>Steps to reproduce:</STRONG> Include the .config =
file and=20
the steps of boot are below .<BR><BR>.config =
file<BR>#-----------------start=20
here------------------------<BR>#<BR># Automatically generated make =
config:=20
don't edit<BR># Linux kernel version: 2.6.13<BR># Fri Sep&nbsp; 9 =
15:48:15=20
2005<BR>#<BR>CONFIG_MMU=3Dy<BR>CONFIG_GENERIC_HARDIRQS=3Dy<BR>CONFIG_RWSE=
M_XCHGADD_ALGORITHM=3Dy<BR>CONFIG_GENERIC_CALIBRATE_DELAY=3Dy<BR>CONFIG_H=
AVE_DEC_LOCK=3Dy<BR>CONFIG_PPC=3Dy<BR>CONFIG_PPC32=3Dy<BR>CONFIG_GENERIC_=
NVRAM=3Dy<BR>CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=3Dy<BR><BR>#<BR>#=20
Code maturity level=20
options<BR>#<BR>CONFIG_EXPERIMENTAL=3Dy<BR>CONFIG_CLEAN_COMPILE=3Dy<BR>CO=
NFIG_BROKEN_ON_SMP=3Dy<BR>CONFIG_INIT_ENV_ARG_LIMIT=3D32<BR><BR>#<BR>#=20
General=20
setup<BR>#<BR>CONFIG_LOCALVERSION=3D""<BR>CONFIG_SWAP=3Dy<BR>CONFIG_SYSVI=
PC=3Dy<BR>#=20
CONFIG_POSIX_MQUEUE is not set<BR># CONFIG_BSD_PROCESS_ACCT is not=20
set<BR>CONFIG_SYSCTL=3Dy<BR># CONFIG_AUDIT is not set<BR># =
CONFIG_HOTPLUG is not=20
set<BR>CONFIG_KOBJECT_UEVENT=3Dy<BR># CONFIG_IKCONFIG is not=20
set<BR>CONFIG_EMBEDDED=3Dy<BR># CONFIG_KALLSYMS is not=20
set<BR>CONFIG_PRINTK=3Dy<BR>CONFIG_BUG=3Dy<BR>CONFIG_BASE_FULL=3Dy<BR>CON=
FIG_FUTEX=3Dy<BR>#=20
CONFIG_EPOLL is not set<BR># CONFIG_CC_OPTIMIZE_FOR_SIZE is not=20
set<BR>CONFIG_SHMEM=3Dy<BR>CONFIG_CC_ALIGN_FUNCTIONS=3D0<BR>CONFIG_CC_ALI=
GN_LABELS=3D0<BR>CONFIG_CC_ALIGN_LOOPS=3D0<BR>CONFIG_CC_ALIGN_JUMPS=3D0<B=
R>#=20
CONFIG_TINY_SHMEM is not set<BR>CONFIG_BASE_SMALL=3D0<BR><BR>#<BR># =
Loadable=20
module support<BR>#<BR># CONFIG_MODULES is not set<BR><BR>#<BR>#=20
Processor<BR>#<BR># CONFIG_6xx is not set<BR># CONFIG_40x is not =
set<BR>#=20
CONFIG_44x is not set<BR># CONFIG_POWER3 is not set<BR># CONFIG_POWER4 =
is not=20
set<BR># CONFIG_8xx is not set<BR># CONFIG_E200 is not=20
set<BR>CONFIG_E500=3Dy<BR>CONFIG_BOOKE=3Dy<BR>CONFIG_FSL_BOOKE=3Dy<BR>#=20
CONFIG_PHYS_64BIT is not =
set<BR>CONFIG_SPE=3Dy<BR>CONFIG_MATH_EMULATION=3Dy<BR>#=20
CONFIG_KEXEC is not set<BR># CONFIG_CPU_FREQ is not set<BR>#=20
CONFIG_WANT_EARLY_SERIAL is not=20
set<BR>CONFIG_PPC_GEN550=3Dy<BR>CONFIG_85xx=3Dy<BR>CONFIG_PPC_INDIRECT_PC=
I_BE=3Dy<BR><BR>#<BR>#=20
Freescale 85xx options<BR>#<BR>CONFIG_MPC8540_ADS=3Dy<BR># =
CONFIG_MPC8548_CDS is=20
not set<BR># CONFIG_MPC8555_CDS is not set<BR># CONFIG_MPC8560_ADS is =
not=20
set<BR># CONFIG_SBC8560 is not set<BR># CONFIG_STX_GP3 is not=20
set<BR>CONFIG_MPC8540=3Dy<BR><BR>#<BR># Platform options<BR>#<BR># =
CONFIG_HIGHMEM=20
is not set<BR># CONFIG_HZ_100 is not set<BR>CONFIG_HZ_250=3Dy<BR># =
CONFIG_HZ_1000=20
is not set<BR>CONFIG_HZ=3D250<BR>CONFIG_PREEMPT_NONE=3Dy<BR>#=20
CONFIG_PREEMPT_VOLUNTARY is not set<BR># CONFIG_PREEMPT is not=20
set<BR>CONFIG_SELECT_MEMORY_MODEL=3Dy<BR>CONFIG_FLATMEM_MANUAL=3Dy<BR>#=20
CONFIG_DISCONTIGMEM_MANUAL is not set<BR># CONFIG_SPARSEMEM_MANUAL is =
not=20
set<BR>CONFIG_FLATMEM=3Dy<BR>CONFIG_FLAT_NODE_MEM_MAP=3Dy<BR>CONFIG_BINFM=
T_ELF=3Dy<BR>#=20
CONFIG_BINFMT_MISC is not set<BR># CONFIG_CMDLINE_BOOL is not set<BR># =
CONFIG_PM=20
is not set<BR>CONFIG_SECCOMP=3Dy<BR>CONFIG_ISA_DMA_API=3Dy<BR><BR>#<BR># =
Bus=20
options<BR>#<BR>CONFIG_PCI=3Dy<BR>CONFIG_PCI_DOMAINS=3Dy<BR># =
CONFIG_PCI_LEGACY_PROC=20
is not set<BR>CONFIG_PCI_NAMES=3Dy<BR><BR>#<BR># PCCARD (PCMCIA/CardBus) =

support<BR>#<BR># CONFIG_PCCARD is not set<BR><BR>#<BR># Advanced=20
setup<BR>#<BR># CONFIG_ADVANCED_OPTIONS is not set<BR><BR>#<BR># Default =

settings for advanced configuration options are=20
used<BR>#<BR>CONFIG_HIGHMEM_START=3D0xfe000000<BR>CONFIG_LOWMEM_SIZE=3D0x=
30000000<BR>CONFIG_KERNEL_START=3D0xc0000000<BR>CONFIG_TASK_SIZE=3D0x8000=
0000<BR>CONFIG_BOOT_LOAD=3D0x00800000<BR><BR>#<BR>#=20
Networking<BR>#<BR>CONFIG_NET=3Dy<BR><BR>#<BR># Networking=20
options<BR>#<BR>CONFIG_PACKET=3Dy<BR># CONFIG_PACKET_MMAP is not=20
set<BR>CONFIG_UNIX=3Dy<BR># CONFIG_NET_KEY is not=20
set<BR>CONFIG_INET=3Dy<BR>CONFIG_IP_MULTICAST=3Dy<BR># =
CONFIG_IP_ADVANCED_ROUTER is=20
not=20
set<BR>CONFIG_IP_FIB_HASH=3Dy<BR>CONFIG_IP_PNP=3Dy<BR>CONFIG_IP_PNP_DHCP=3D=
y<BR>CONFIG_IP_PNP_BOOTP=3Dy<BR>#=20
CONFIG_IP_PNP_RARP is not set<BR># CONFIG_NET_IPIP is not set<BR>#=20
CONFIG_NET_IPGRE is not set<BR># CONFIG_IP_MROUTE is not set<BR># =
CONFIG_ARPD is=20
not set<BR>CONFIG_SYN_COOKIES=3Dy<BR># CONFIG_INET_AH is not set<BR>#=20
CONFIG_INET_ESP is not set<BR># CONFIG_INET_IPCOMP is not set<BR>#=20
CONFIG_INET_TUNNEL is not set<BR>CONFIG_IP_TCPDIAG=3Dy<BR># =
CONFIG_IP_TCPDIAG_IPV6=20
is not set<BR># CONFIG_TCP_CONG_ADVANCED is not=20
set<BR>CONFIG_TCP_CONG_BIC=3Dy<BR># CONFIG_IPV6 is not set<BR># =
CONFIG_NETFILTER=20
is not set<BR><BR>#<BR># SCTP Configuration (EXPERIMENTAL)<BR>#<BR>#=20
CONFIG_IP_SCTP is not set<BR># CONFIG_ATM is not set<BR># CONFIG_BRIDGE =
is not=20
set<BR># CONFIG_VLAN_8021Q is not set<BR># CONFIG_DECNET is not set<BR># =

CONFIG_LLC2 is not set<BR># CONFIG_IPX is not set<BR># CONFIG_ATALK is =
not=20
set<BR># CONFIG_X25 is not set<BR># CONFIG_LAPB is not set<BR>#=20
CONFIG_NET_DIVERT is not set<BR># CONFIG_ECONET is not set<BR>#=20
CONFIG_WAN_ROUTER is not set<BR># CONFIG_NET_SCHED is not set<BR>#=20
CONFIG_NET_CLS_ROUTE is not set<BR><BR>#<BR># Network testing<BR>#<BR>#=20
CONFIG_NET_PKTGEN is not set<BR># CONFIG_HAMRADIO is not set<BR># =
CONFIG_IRDA is=20
not set<BR># CONFIG_BT is not set<BR><BR>#<BR># Device=20
Drivers<BR>#<BR><BR>#<BR># Generic Driver=20
Options<BR>#<BR>CONFIG_STANDALONE=3Dy<BR>CONFIG_PREVENT_FIRMWARE_BUILD=3D=
y<BR>#=20
CONFIG_FW_LOADER is not set<BR><BR>#<BR># Memory Technology Devices=20
(MTD)<BR>#<BR># CONFIG_MTD is not set<BR><BR>#<BR># Parallel port=20
support<BR>#<BR># CONFIG_PARPORT is not set<BR><BR>#<BR># Plug and Play=20
support<BR>#<BR><BR>#<BR># Block devices<BR>#<BR># CONFIG_BLK_DEV_FD is =
not=20
set<BR># CONFIG_BLK_CPQ_DA is not set<BR># CONFIG_BLK_CPQ_CISS_DA is not =

set<BR># CONFIG_BLK_DEV_DAC960 is not set<BR># CONFIG_BLK_DEV_UMEM is =
not=20
set<BR># CONFIG_BLK_DEV_COW_COMMON is not =
set<BR>CONFIG_BLK_DEV_LOOP=3Dy<BR>#=20
CONFIG_BLK_DEV_CRYPTOLOOP is not set<BR># CONFIG_BLK_DEV_NBD is not =
set<BR>#=20
CONFIG_BLK_DEV_SX8 is not=20
set<BR>CONFIG_BLK_DEV_RAM=3Dy<BR>CONFIG_BLK_DEV_RAM_COUNT=3D16<BR>CONFIG_=
BLK_DEV_RAM_SIZE=3D32768<BR>CONFIG_BLK_DEV_INITRD=3Dy<BR>CONFIG_INITRAMFS=
_SOURCE=3D""<BR>CONFIG_LBD=3Dy<BR>#=20
CONFIG_CDROM_PKTCDVD is not set<BR><BR>#<BR># IO=20
Schedulers<BR>#<BR>CONFIG_IOSCHED_NOOP=3Dy<BR>CONFIG_IOSCHED_AS=3Dy<BR>CO=
NFIG_IOSCHED_DEADLINE=3Dy<BR>CONFIG_IOSCHED_CFQ=3Dy<BR>#=20
CONFIG_ATA_OVER_ETH is not set<BR><BR>#<BR># ATA/ATAPI/MFM/RLL=20
support<BR>#<BR>CONFIG_IDE=3Dy<BR>CONFIG_BLK_DEV_IDE=3Dy<BR><BR>#<BR># =
Please see=20
Documentation/ide.txt for help/info on IDE drives<BR>#<BR>#=20
CONFIG_BLK_DEV_IDE_SATA is not=20
set<BR>CONFIG_BLK_DEV_IDEDISK=3Dy<BR>CONFIG_IDEDISK_MULTI_MODE=3Dy<BR>CON=
FIG_BLK_DEV_IDECD=3Dy<BR>#=20
CONFIG_BLK_DEV_IDETAPE is not set<BR># CONFIG_BLK_DEV_IDEFLOPPY is not =
set<BR>#=20
CONFIG_IDE_TASK_IOCTL is not set<BR><BR>#<BR># IDE chipset=20
support/bugfixes<BR>#<BR>CONFIG_IDE_GENERIC=3Dy<BR>CONFIG_BLK_DEV_IDEPCI=3D=
y<BR>CONFIG_IDEPCI_SHARE_IRQ=3Dy<BR>#=20
CONFIG_BLK_DEV_OFFBOARD is not set<BR>CONFIG_BLK_DEV_GENERIC=3Dy<BR>#=20
CONFIG_BLK_DEV_OPTI621 is not set<BR># CONFIG_BLK_DEV_SL82C105 is not=20
set<BR>CONFIG_BLK_DEV_IDEDMA_PCI=3Dy<BR># CONFIG_BLK_DEV_IDEDMA_FORCED =
is not=20
set<BR>CONFIG_IDEDMA_PCI_AUTO=3Dy<BR># CONFIG_IDEDMA_ONLYDISK is not =
set<BR>#=20
CONFIG_BLK_DEV_AEC62XX is not set<BR># CONFIG_BLK_DEV_ALI15X3 is not =
set<BR>#=20
CONFIG_BLK_DEV_AMD74XX is not set<BR># CONFIG_BLK_DEV_CMD64X is not =
set<BR>#=20
CONFIG_BLK_DEV_TRIFLEX is not set<BR># CONFIG_BLK_DEV_CY82C693 is not =
set<BR>#=20
CONFIG_BLK_DEV_CS5520 is not set<BR># CONFIG_BLK_DEV_CS5530 is not =
set<BR>#=20
CONFIG_BLK_DEV_HPT34X is not set<BR># CONFIG_BLK_DEV_HPT366 is not =
set<BR>#=20
CONFIG_BLK_DEV_SC1200 is not set<BR># CONFIG_BLK_DEV_PIIX is not =
set<BR>#=20
CONFIG_BLK_DEV_IT821X is not set<BR># CONFIG_BLK_DEV_NS87415 is not =
set<BR>#=20
CONFIG_BLK_DEV_PDC202XX_OLD is not =
set<BR>CONFIG_BLK_DEV_PDC202XX_NEW=3Dy<BR>#=20
CONFIG_PDC202XX_FORCE is not set<BR># CONFIG_BLK_DEV_SVWKS is not =
set<BR>#=20
CONFIG_BLK_DEV_SIIMAGE is not set<BR># CONFIG_BLK_DEV_SLC90E66 is not =
set<BR>#=20
CONFIG_BLK_DEV_TRM290 is not set<BR># CONFIG_BLK_DEV_VIA82CXXX is not =
set<BR>#=20
CONFIG_IDE_ARM is not set<BR>CONFIG_BLK_DEV_IDEDMA=3Dy<BR># =
CONFIG_IDEDMA_IVB is=20
not set<BR>CONFIG_IDEDMA_AUTO=3Dy<BR># CONFIG_BLK_DEV_HD is not =
set<BR><BR>#<BR>#=20
SCSI device support<BR>#<BR># CONFIG_SCSI is not set<BR><BR>#<BR># =
Multi-device=20
support (RAID and LVM)<BR>#<BR># CONFIG_MD is not set<BR><BR>#<BR># =
Fusion MPT=20
device support<BR>#<BR># CONFIG_FUSION is not set<BR><BR>#<BR># IEEE =
1394=20
(FireWire) support<BR>#<BR># CONFIG_IEEE1394 is not set<BR><BR>#<BR># =
I2O device=20
support<BR>#<BR># CONFIG_I2O is not set<BR><BR>#<BR># Macintosh device=20
drivers<BR>#<BR><BR>#<BR># Network device=20
support<BR>#<BR>CONFIG_NETDEVICES=3Dy<BR># CONFIG_DUMMY is not set<BR>#=20
CONFIG_BONDING is not set<BR># CONFIG_EQUALIZER is not set<BR># =
CONFIG_TUN is=20
not set<BR><BR>#<BR># ARCnet devices<BR>#<BR># CONFIG_ARCNET is not=20
set<BR><BR>#<BR># Ethernet (10 or=20
100Mbit)<BR>#<BR>CONFIG_NET_ETHERNET=3Dy<BR>CONFIG_MII=3Dy<BR># =
CONFIG_HAPPYMEAL is=20
not set<BR># CONFIG_SUNGEM is not set<BR># CONFIG_NET_VENDOR_3COM is not =

set<BR><BR>#<BR># Tulip family network device support<BR>#<BR># =
CONFIG_NET_TULIP=20
is not set<BR># CONFIG_HP100 is not set<BR># CONFIG_NET_PCI is not=20
set<BR><BR>#<BR># Ethernet (1000 Mbit)<BR>#<BR># CONFIG_ACENIC is not =
set<BR>#=20
CONFIG_DL2K is not set<BR># CONFIG_E1000 is not set<BR># CONFIG_NS83820 =
is not=20
set<BR># CONFIG_HAMACHI is not set<BR># CONFIG_YELLOWFIN is not set<BR># =

CONFIG_R8169 is not set<BR># CONFIG_SKGE is not set<BR># CONFIG_SK98LIN =
is not=20
set<BR># CONFIG_TIGON3 is not set<BR># CONFIG_BNX2 is not=20
set<BR>CONFIG_GIANFAR=3Dy<BR>CONFIG_GFAR_NAPI=3Dy<BR><BR>#<BR># Ethernet =
(10000=20
Mbit)<BR>#<BR># CONFIG_IXGB is not set<BR># CONFIG_S2IO is not =
set<BR><BR>#<BR>#=20
Token Ring devices<BR>#<BR># CONFIG_TR is not set<BR><BR>#<BR># Wireless =
LAN=20
(non-hamradio)<BR>#<BR># CONFIG_NET_RADIO is not set<BR><BR>#<BR># Wan=20
interfaces<BR>#<BR># CONFIG_WAN is not set<BR># CONFIG_FDDI is not =
set<BR>#=20
CONFIG_HIPPI is not set<BR># CONFIG_PPP is not set<BR># CONFIG_SLIP is =
not=20
set<BR># CONFIG_SHAPER is not set<BR># CONFIG_NETCONSOLE is not set<BR># =

CONFIG_NETPOLL is not set<BR># CONFIG_NET_POLL_CONTROLLER is not=20
set<BR><BR>#<BR># ISDN subsystem<BR>#<BR># CONFIG_ISDN is not =
set<BR><BR>#<BR>#=20
Telephony Support<BR>#<BR># CONFIG_PHONE is not set<BR><BR>#<BR># Input =
device=20
support<BR>#<BR>CONFIG_INPUT=3Dy<BR><BR>#<BR># Userland =
interfaces<BR>#<BR>#=20
CONFIG_INPUT_MOUSEDEV is not set<BR># CONFIG_INPUT_JOYDEV is not =
set<BR>#=20
CONFIG_INPUT_TSDEV is not set<BR># CONFIG_INPUT_EVDEV is not set<BR>#=20
CONFIG_INPUT_EVBUG is not set<BR><BR>#<BR># Input Device =
Drivers<BR>#<BR>#=20
CONFIG_INPUT_KEYBOARD is not set<BR># CONFIG_INPUT_MOUSE is not set<BR># =

CONFIG_INPUT_JOYSTICK is not set<BR># CONFIG_INPUT_TOUCHSCREEN is not =
set<BR>#=20
CONFIG_INPUT_MISC is not set<BR><BR>#<BR># Hardware I/O ports<BR>#<BR>#=20
CONFIG_SERIO is not set<BR># CONFIG_GAMEPORT is not set<BR><BR>#<BR># =
Character=20
devices<BR>#<BR># CONFIG_VT is not set<BR># CONFIG_SERIAL_NONSTANDARD is =
not=20
set<BR><BR>#<BR># Serial=20
drivers<BR>#<BR>CONFIG_SERIAL_8250=3Dy<BR>CONFIG_SERIAL_8250_CONSOLE=3Dy<=
BR>CONFIG_SERIAL_8250_NR_UARTS=3D4<BR>#=20
CONFIG_SERIAL_8250_EXTENDED is not set<BR><BR>#<BR># Non-8250 serial =
port=20
support<BR>#<BR>CONFIG_SERIAL_CORE=3Dy<BR>CONFIG_SERIAL_CORE_CONSOLE=3Dy<=
BR>#=20
CONFIG_SERIAL_JSM is not=20
set<BR>CONFIG_UNIX98_PTYS=3Dy<BR>CONFIG_LEGACY_PTYS=3Dy<BR>CONFIG_LEGACY_=
PTY_COUNT=3D256<BR><BR>#<BR>#=20
IPMI<BR>#<BR># CONFIG_IPMI_HANDLER is not set<BR><BR>#<BR># Watchdog=20
Cards<BR>#<BR># CONFIG_WATCHDOG is not set<BR># CONFIG_NVRAM is not=20
set<BR>CONFIG_GEN_RTC=3Dy<BR># CONFIG_GEN_RTC_X is not set<BR># =
CONFIG_DTLK is not=20
set<BR># CONFIG_R3964 is not set<BR># CONFIG_APPLICOM is not =
set<BR><BR>#<BR>#=20
Ftape, the floppy tape device driver<BR>#<BR># CONFIG_AGP is not =
set<BR>#=20
CONFIG_DRM is not set<BR># CONFIG_RAW_DRIVER is not set<BR><BR>#<BR># =
TPM=20
devices<BR>#<BR># CONFIG_TCG_TPM is not set<BR><BR>#<BR># I2C=20
support<BR>#<BR>CONFIG_I2C=3Dy<BR>CONFIG_I2C_CHARDEV=3Dy<BR><BR>#<BR># =
I2C=20
Algorithms<BR>#<BR># CONFIG_I2C_ALGOBIT is not set<BR># =
CONFIG_I2C_ALGOPCF is=20
not set<BR># CONFIG_I2C_ALGOPCA is not set<BR><BR>#<BR># I2C Hardware =
Bus=20
support<BR>#<BR># CONFIG_I2C_ALI1535 is not set<BR># CONFIG_I2C_ALI1563 =
is not=20
set<BR># CONFIG_I2C_ALI15X3 is not set<BR># CONFIG_I2C_AMD756 is not =
set<BR>#=20
CONFIG_I2C_AMD8111 is not set<BR># CONFIG_I2C_I801 is not set<BR>#=20
CONFIG_I2C_I810 is not set<BR># CONFIG_I2C_PIIX4 is not set<BR># =
CONFIG_I2C_ISA=20
is not set<BR>CONFIG_I2C_MPC=3Dy<BR># CONFIG_I2C_NFORCE2 is not set<BR># =

CONFIG_I2C_PARPORT_LIGHT is not set<BR># CONFIG_I2C_PROSAVAGE is not =
set<BR>#=20
CONFIG_I2C_SAVAGE4 is not set<BR># CONFIG_SCx200_ACB is not set<BR>#=20
CONFIG_I2C_SIS5595 is not set<BR># CONFIG_I2C_SIS630 is not set<BR>#=20
CONFIG_I2C_SIS96X is not set<BR># CONFIG_I2C_VIA is not set<BR>#=20
CONFIG_I2C_VIAPRO is not set<BR># CONFIG_I2C_VOODOO3 is not set<BR>#=20
CONFIG_I2C_PCA_ISA is not set<BR># CONFIG_I2C_SENSOR is not =
set<BR><BR>#<BR>#=20
Miscellaneous I2C Chip support<BR>#<BR># CONFIG_SENSORS_DS1337 is not =
set<BR>#=20
CONFIG_SENSORS_DS1374 is not set<BR># CONFIG_SENSORS_EEPROM is not =
set<BR>#=20
CONFIG_SENSORS_PCF8574 is not set<BR># CONFIG_SENSORS_PCA9539 is not =
set<BR>#=20
CONFIG_SENSORS_PCF8591 is not set<BR># CONFIG_SENSORS_RTC8564 is not =
set<BR>#=20
CONFIG_SENSORS_M41T00 is not set<BR># CONFIG_SENSORS_MAX6875 is not =
set<BR>#=20
CONFIG_I2C_DEBUG_CORE is not set<BR># CONFIG_I2C_DEBUG_ALGO is not =
set<BR>#=20
CONFIG_I2C_DEBUG_BUS is not set<BR># CONFIG_I2C_DEBUG_CHIP is not=20
set<BR><BR>#<BR># Dallas's 1-wire bus<BR>#<BR># CONFIG_W1 is not=20
set<BR><BR>#<BR># Hardware Monitoring =
support<BR>#<BR>CONFIG_HWMON=3Dy<BR>#=20
CONFIG_SENSORS_ADM1021 is not set<BR># CONFIG_SENSORS_ADM1025 is not =
set<BR>#=20
CONFIG_SENSORS_ADM1026 is not set<BR># CONFIG_SENSORS_ADM1031 is not =
set<BR>#=20
CONFIG_SENSORS_ADM9240 is not set<BR># CONFIG_SENSORS_ASB100 is not =
set<BR>#=20
CONFIG_SENSORS_ATXP1 is not set<BR># CONFIG_SENSORS_DS1621 is not =
set<BR>#=20
CONFIG_SENSORS_FSCHER is not set<BR># CONFIG_SENSORS_FSCPOS is not =
set<BR>#=20
CONFIG_SENSORS_GL518SM is not set<BR># CONFIG_SENSORS_GL520SM is not =
set<BR>#=20
CONFIG_SENSORS_IT87 is not set<BR># CONFIG_SENSORS_LM63 is not set<BR>#=20
CONFIG_SENSORS_LM75 is not set<BR># CONFIG_SENSORS_LM77 is not set<BR>#=20
CONFIG_SENSORS_LM78 is not set<BR># CONFIG_SENSORS_LM80 is not set<BR>#=20
CONFIG_SENSORS_LM83 is not set<BR># CONFIG_SENSORS_LM85 is not set<BR>#=20
CONFIG_SENSORS_LM87 is not set<BR># CONFIG_SENSORS_LM90 is not set<BR>#=20
CONFIG_SENSORS_LM92 is not set<BR># CONFIG_SENSORS_MAX1619 is not =
set<BR>#=20
CONFIG_SENSORS_PC87360 is not set<BR># CONFIG_SENSORS_SIS5595 is not =
set<BR>#=20
CONFIG_SENSORS_SMSC47M1 is not set<BR># CONFIG_SENSORS_SMSC47B397 is not =

set<BR># CONFIG_SENSORS_VIA686A is not set<BR># CONFIG_SENSORS_W83781D =
is not=20
set<BR># CONFIG_SENSORS_W83L785TS is not set<BR># =
CONFIG_SENSORS_W83627HF is not=20
set<BR># CONFIG_SENSORS_W83627EHF is not set<BR># =
CONFIG_HWMON_DEBUG_CHIP is not=20
set<BR><BR>#<BR># Misc devices<BR>#<BR><BR>#<BR># Multimedia =
devices<BR>#<BR>#=20
CONFIG_VIDEO_DEV is not set<BR><BR>#<BR># Digital Video Broadcasting=20
Devices<BR>#<BR># CONFIG_DVB is not set<BR><BR>#<BR># Graphics =
support<BR>#<BR>#=20
CONFIG_FB is not set<BR><BR>#<BR># Sound<BR>#<BR># CONFIG_SOUND is not=20
set<BR><BR>#<BR># USB=20
support<BR>#<BR>CONFIG_USB_ARCH_HAS_HCD=3Dy<BR>CONFIG_USB_ARCH_HAS_OHCI=3D=
y<BR>#=20
CONFIG_USB is not set<BR><BR>#<BR># USB Gadget Support<BR>#<BR>#=20
CONFIG_USB_GADGET is not set<BR><BR>#<BR># MMC/SD Card support<BR>#<BR># =

CONFIG_MMC is not set<BR><BR>#<BR># InfiniBand support<BR>#<BR>#=20
CONFIG_INFINIBAND is not set<BR><BR>#<BR># SN Devices<BR>#<BR><BR>#<BR># =
File=20
systems<BR>#<BR>CONFIG_EXT2_FS=3Dy<BR># CONFIG_EXT2_FS_XATTR is not =
set<BR>#=20
CONFIG_EXT2_FS_XIP is not =
set<BR>CONFIG_EXT3_FS=3Dy<BR>CONFIG_EXT3_FS_XATTR=3Dy<BR>#=20
CONFIG_EXT3_FS_POSIX_ACL is not set<BR># CONFIG_EXT3_FS_SECURITY is not=20
set<BR>CONFIG_JBD=3Dy<BR># CONFIG_JBD_DEBUG is not =
set<BR>CONFIG_FS_MBCACHE=3Dy<BR>#=20
CONFIG_REISERFS_FS is not set<BR># CONFIG_JFS_FS is not set<BR>#=20
CONFIG_FS_POSIX_ACL is not set<BR><BR>#<BR># XFS support<BR>#<BR># =
CONFIG_XFS_FS=20
is not set<BR># CONFIG_MINIX_FS is not set<BR># CONFIG_ROMFS_FS is not=20
set<BR>CONFIG_INOTIFY=3Dy<BR># CONFIG_QUOTA is not =
set<BR>CONFIG_DNOTIFY=3Dy<BR>#=20
CONFIG_AUTOFS_FS is not set<BR># CONFIG_AUTOFS4_FS is not =
set<BR><BR>#<BR>#=20
CD-ROM/DVD Filesystems<BR>#<BR># CONFIG_ISO9660_FS is not set<BR># =
CONFIG_UDF_FS=20
is not set<BR><BR>#<BR># DOS/FAT/NT=20
Filesystems<BR>#<BR>CONFIG_FAT_FS=3Dy<BR>CONFIG_MSDOS_FS=3Dy<BR>CONFIG_VF=
AT_FS=3Dy<BR>CONFIG_FAT_DEFAULT_CODEPAGE=3D437<BR>CONFIG_FAT_DEFAULT_IOCH=
ARSET=3D"iso8859-1"<BR>CONFIG_NTFS_FS=3Dy<BR>CONFIG_NTFS_DEBUG=3Dy<BR>CON=
FIG_NTFS_RW=3Dy<BR><BR>#<BR>#=20
Pseudo=20
filesystems<BR>#<BR>CONFIG_PROC_FS=3Dy<BR>CONFIG_PROC_KCORE=3Dy<BR>CONFIG=
_SYSFS=3Dy<BR>#=20
CONFIG_DEVPTS_FS_XATTR is not set<BR>CONFIG_TMPFS=3Dy<BR># =
CONFIG_TMPFS_XATTR is=20
not set<BR># CONFIG_HUGETLB_PAGE is not =
set<BR>CONFIG_RAMFS=3Dy<BR><BR>#<BR>#=20
Miscellaneous filesystems<BR>#<BR># CONFIG_ADFS_FS is not set<BR>#=20
CONFIG_AFFS_FS is not set<BR># CONFIG_HFS_FS is not set<BR># =
CONFIG_HFSPLUS_FS=20
is not set<BR># CONFIG_BEFS_FS is not set<BR># CONFIG_BFS_FS is not =
set<BR>#=20
CONFIG_EFS_FS is not set<BR># CONFIG_CRAMFS is not set<BR># =
CONFIG_VXFS_FS is=20
not set<BR># CONFIG_HPFS_FS is not set<BR># CONFIG_QNX4FS_FS is not =
set<BR>#=20
CONFIG_SYSV_FS is not set<BR># CONFIG_UFS_FS is not set<BR><BR>#<BR># =
Network=20
File Systems<BR>#<BR>CONFIG_NFS_FS=3Dy<BR># CONFIG_NFS_V3 is not =
set<BR>#=20
CONFIG_NFS_V4 is not set<BR># CONFIG_NFS_DIRECTIO is not set<BR># =
CONFIG_NFSD is=20
not=20
set<BR>CONFIG_ROOT_NFS=3Dy<BR>CONFIG_LOCKD=3Dy<BR>CONFIG_NFS_COMMON=3Dy<B=
R>CONFIG_SUNRPC=3Dy<BR>#=20
CONFIG_RPCSEC_GSS_KRB5 is not set<BR># CONFIG_RPCSEC_GSS_SPKM3 is not =
set<BR>#=20
CONFIG_SMB_FS is not set<BR># CONFIG_CIFS is not set<BR># CONFIG_NCP_FS =
is not=20
set<BR># CONFIG_CODA_FS is not set<BR># CONFIG_AFS_FS is not =
set<BR><BR>#<BR>#=20
Partition Types<BR>#<BR>CONFIG_PARTITION_ADVANCED=3Dy<BR># =
CONFIG_ACORN_PARTITION=20
is not set<BR># CONFIG_OSF_PARTITION is not set<BR># =
CONFIG_AMIGA_PARTITION is=20
not set<BR># CONFIG_ATARI_PARTITION is not set<BR># CONFIG_MAC_PARTITION =
is not=20
set<BR>CONFIG_MSDOS_PARTITION=3Dy<BR># CONFIG_BSD_DISKLABEL is not =
set<BR>#=20
CONFIG_MINIX_SUBPARTITION is not =
set<BR>CONFIG_SOLARIS_X86_PARTITION=3Dy<BR>#=20
CONFIG_UNIXWARE_DISKLABEL is not=20
set<BR>CONFIG_LDM_PARTITION=3Dy<BR>CONFIG_LDM_DEBUG=3Dy<BR># =
CONFIG_SGI_PARTITION is=20
not set<BR># CONFIG_ULTRIX_PARTITION is not set<BR># =
CONFIG_SUN_PARTITION is not=20
set<BR># CONFIG_EFI_PARTITION is not set<BR><BR>#<BR># Native Language=20
Support<BR>#<BR>CONFIG_NLS=3Dy<BR>CONFIG_NLS_DEFAULT=3D"iso8859-1"<BR>#=20
CONFIG_NLS_CODEPAGE_437 is not set<BR># CONFIG_NLS_CODEPAGE_737 is not =
set<BR>#=20
CONFIG_NLS_CODEPAGE_775 is not set<BR># CONFIG_NLS_CODEPAGE_850 is not =
set<BR>#=20
CONFIG_NLS_CODEPAGE_852 is not set<BR># CONFIG_NLS_CODEPAGE_855 is not =
set<BR>#=20
CONFIG_NLS_CODEPAGE_857 is not set<BR># CONFIG_NLS_CODEPAGE_860 is not =
set<BR>#=20
CONFIG_NLS_CODEPAGE_861 is not set<BR># CONFIG_NLS_CODEPAGE_862 is not =
set<BR>#=20
CONFIG_NLS_CODEPAGE_863 is not set<BR># CONFIG_NLS_CODEPAGE_864 is not =
set<BR>#=20
CONFIG_NLS_CODEPAGE_865 is not set<BR># CONFIG_NLS_CODEPAGE_866 is not =
set<BR>#=20
CONFIG_NLS_CODEPAGE_869 is not set<BR>CONFIG_NLS_CODEPAGE_936=3Dy<BR>#=20
CONFIG_NLS_CODEPAGE_950 is not set<BR># CONFIG_NLS_CODEPAGE_932 is not =
set<BR>#=20
CONFIG_NLS_CODEPAGE_949 is not set<BR># CONFIG_NLS_CODEPAGE_874 is not =
set<BR>#=20
CONFIG_NLS_ISO8859_8 is not set<BR># CONFIG_NLS_CODEPAGE_1250 is not =
set<BR>#=20
CONFIG_NLS_CODEPAGE_1251 is not set<BR># CONFIG_NLS_ASCII is not =
set<BR>#=20
CONFIG_NLS_ISO8859_1 is not set<BR># CONFIG_NLS_ISO8859_2 is not =
set<BR>#=20
CONFIG_NLS_ISO8859_3 is not set<BR># CONFIG_NLS_ISO8859_4 is not =
set<BR>#=20
CONFIG_NLS_ISO8859_5 is not set<BR># CONFIG_NLS_ISO8859_6 is not =
set<BR>#=20
CONFIG_NLS_ISO8859_7 is not set<BR># CONFIG_NLS_ISO8859_9 is not =
set<BR>#=20
CONFIG_NLS_ISO8859_13 is not set<BR># CONFIG_NLS_ISO8859_14 is not =
set<BR>#=20
CONFIG_NLS_ISO8859_15 is not set<BR># CONFIG_NLS_KOI8_R is not set<BR>#=20
CONFIG_NLS_KOI8_U is not set<BR># CONFIG_NLS_UTF8 is not =
set<BR><BR>#<BR>#=20
Library routines<BR>#<BR># CONFIG_CRC_CCITT is not =
set<BR>CONFIG_CRC32=3Dy<BR>#=20
CONFIG_LIBCRC32C is not set<BR><BR>#<BR># Profiling support<BR>#<BR>#=20
CONFIG_PROFILING is not set<BR><BR>#<BR># Kernel hacking<BR>#<BR>#=20
CONFIG_PRINTK_TIME is not set<BR># CONFIG_DEBUG_KERNEL is not=20
set<BR>CONFIG_LOG_BUF_SHIFT=3D14<BR># CONFIG_SERIAL_TEXT_DEBUG is not=20
set<BR><BR>#<BR># Security options<BR>#<BR># CONFIG_KEYS is not set<BR># =

CONFIG_SECURITY is not set<BR><BR>#<BR># Cryptographic options<BR>#<BR># =

CONFIG_CRYPTO is not set<BR><BR>#<BR># Hardware crypto=20
devices<BR>#<BR>#-----------------config file end=20
here------------------------<BR><BR><BR>Kernel boot message and opp=20
steps:<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
#################################################################&nbsp;&n=
bsp;<BR><BR><BR>U-Boot=20
1.1.2(pq3-20040622-0) (Sep 27 2004 -=20
16:46:03)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

##########################################################&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;<BR><BR>&nbsp;&nbsp;&nbsp;=20
Core:&nbsp;&nbsp; E500, Version: 2.0,=20
(0x80200020)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;<BR>done&nbsp;&nbsp;&nbsp;<BR>Bytes=20
transferred =3D 1292138 (13b76a hex)rsion:=20
2.0,<BR>(0x80300020)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>MPC8540SK=3D&gt;=20
bootm 400000 ff800000locks: CPU: 833=20
MHz&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;<BR>##=20
Booting image at 00400000=20
...Hz&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR=
>&nbsp;&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;=20
Image Name:&nbsp;&nbsp;=20
Linux-2.6.13&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;=20
LBC<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image =
(gzip=20
compressed)che=20
32KB<BR>enabled.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;=20
Data Size:&nbsp;&nbsp;&nbsp; 1292074 Bytes =3D&nbsp; 1.2=20
MBev.<BR>B.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>&nbsp;=
&nbsp;=20
Load Address: 00000000ot Flash is=20
U13&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;=
 Entry=20
Point:&nbsp; 00000000I1:&nbsp;&nbsp; 32=20
bit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;<BR>&nbsp;&nbsp;=20
Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image (gzip=20
compressed)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;&nbsp;=20
Net:&nbsp;&nbsp;&nbsp; MOTO ENET0: PHY is Marvell 88E111<BR>&nbsp;&nbsp; =
Data=20
Size:&nbsp;&nbsp;&nbsp; 4710501 Bytes =3D&nbsp; 4.5=20
MB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;<BR>&nbsp;&nbsp;=20
Load Address: 00000000l 88E1111S=20
(1410cc1)&nbsp;&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp; Entry Point:&nbsp;=20
00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;<BR>&nbsp;&nbsp;=20
Verifying Checksum ... OK is Realtek RTL8201CP (8201)<BR>&nbsp;&nbsp; =
Loading=20
Ramdisk to 07750000, end 07bce065 ...=20
OK&nbsp;&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;=20
MOTO ENET0, MOTO ENET1, MOTO ENET2<BR>Memory CAM mapping: CAM0=3D64Mb, =
CAM1=3D64Mb,=20
CAM2=3D0Mb residual: 0Mbp=20
autoboot:&nbsp;<BR>0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR><BR>MPC85=
40SK=3D&gt;&nbsp;&nbsp;&nbsp;&nbsp;<BR>Linux=20
version 2.6.13 (root@mqy-linux) (gcc version 3.3.3 (DENX ELDK 3.1.1 =
3.0,<BR>full=20
duplex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>Usin=
g=20
MOTO ENET0=20
de&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;<BR>Freeing=20
initrd memory: 4600k freed<BR>&nbsp;&nbsp;&nbsp; DRAM:&nbsp;&nbsp;=20
Initializing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>NET: =
Registered=20
protocol family=20
16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;<BR>&nbsp;&nbsp;&nbsp;=20
DDR:&nbsp;&nbsp;&nbsp; 128 MB<BR>PCI: Probing PCI hardwareSH:&nbsp; 8=20
MB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;<BR>NTFS=20
driver 2.1.23 [Flags: R/W=20
DEBUG].&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;&nbsp;=20
In:&nbsp;&nbsp;&nbsp;&nbsp; serial&nbsp;&nbsp;<BR>Generic RTC Driver=20
v1.07&nbsp;&nbsp;=20
serial&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;<BR>Serial:=20
8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing=20
disabledrvell<BR>88E1111S=20
(1410cc1)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;<BR>ttyS0=20
at MMIO 0xe0004500 (irq =3D 26) is a=20
16550A88E1111S<BR>(1410cc1)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>ttyS1=20
at MMIO 0xe0004600 (irq =3D 26) is a 16550AET2: PHY is Realtek=20
RTL8201CP<BR>(8201)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;<BR>io=20
scheduler noop=20
registered&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;<BR>io=20
scheduler anticipatory=20
registered&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;<BR>io=20
scheduler deadline registeredboot:&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>io =

scheduler cfq registered00000=20
uImage&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;<BR>RAMDISK=20
driver initialized: 16 RAM disks of 32768K size 1024<BR>Using MOTO ENET0 =

device&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>eth1:=20
Gianfar Ethernet Controller Version=20
1.1,<BR>00:e0:0c:40:01:03################################################=
####&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>&nbsp;<BR>e=
th1:=20
Running with NAPI=20
enabled&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR><BR>eth1:=20
256/256 RX/TX BD ring size################################<BR>eth2: =
Gianfar=20
Ethernet Controller Version=20
1.1,<BR>00:e0:0c:40:02:03&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
####################################<BR>eth2: Running with NAPI=20
enabled&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>eth2:=20
256/256 RX/TX BD ring sizensferred =3D 1264114 (1349f2 hex)<BR>Uniform=20
Multi-Platform E-IDE driver Revision: 7.00alpha2=20
4000000<BR>ff800000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<B=
R>##=20
B<BR>ide: Assuming 33MHz system bus speed for=20
P&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;<BR>Bad=20
Magic=20
Nu&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;&=
nbsp;=20
ide2: BM-DMA at 0xffffd0-0xffffd7, BIOS settings:=20
hde:pio,<BR>hdf:pio&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;<BR>&nbsp;&nbsp;=20
Load Address:=20
00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;&nbsp;=20
ide3: BM-DMA at 0xffffd8-0xffffdf, BIOS settings: =
hdg:pio,<BR>hdh:piohecksum ...=20
OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;<BR>&nbsp;&nbsp;=20
Uncompressing Kernel Ima<BR>hde: QUANTUM FIREBALL CR8.4A, ATA DISK =
drive<BR>##=20
Loading RAMDisk Image at ff800000 ...&nbsp;&nbsp;<BR>ide2 at=20
0xfffff8-0xffffff,0xfffff6 on irq 50e Name:&nbsp;&nbsp;=20
MPC85xx<BR>ramdisk&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>hde:=20
max request size: 128KiB PowerPC Linux RAMDisk Image<BR>hde: lost=20
interrupt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>hde:=20
lost=20
interrupt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>hde:=20
lost interrupt710501 Bytes =3D&nbsp; 4.5<BR>hde: lost=20
interrupt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>PDC202XX:=20
Primary channel reset.ux version 2.6.13 (root@mqy-linu<BR>hde: DMA =
interrupt=20
recoveryELDK 3.1.1=20
3.3.3-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>hde: =
lost=20
interrupt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>&nbsp;hde1&nbsp;&nbsp;&nb=
sp;&nbsp;<BR>i2c=20
/dev entries driver #11 Sun Sep 4 12:52:07<BR>NET: Registered protocol =
family=20
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>Built 1=20
zonelists&nbsp;&nbsp;&nbsp;&nbsp;<BR>IP route cache hash table entries: =
2048=20
(order: 1, 8192=20
bytes)<BR>0,115200&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>TCP=20
established hash table entries: 8192 (order: 4,=20
65536<BR>bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>PID =

h<BR>TCP bind hash table entries: 8192 (order: 3,=20
32768<BR>bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>Dentry=20
cache<BR>TCP: Hash tables configured=20
(e&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;<BR>RAMDISK:=20
Compressed image found at block=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;<BR>Mount-cache=20
ha<BR>VFS: Mounted root (ext2=20
filesystem).&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>checking=20
if imag<BR>Freeing unused kernel memory: 336k init); looks like an=20
initrd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;<BR>INIT:=20
version 2.78=20
booting&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;<BR>INIT:=20
Entering runlevel: 2emory: 4600k=20
freed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR><BR>Welcome to Linux =
on=20
Puff!NET: Registered protocol<BR>PuffLinux login:=20
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>PuffLinux:root$cat=
=20
/proc/partitions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;<BR><BR>33&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
hde&nbsp;&nbsp;&nbsp;&nbsp;<BR>33&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1=20
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
hde1&nbsp;&nbsp;&nbsp;<BR>PuffLinux:root$cd=20
/dev<BR>PuffLinux:dev$mknod hde b 33 0<BR>PuffLinux:dev$mknod hde1 b 33=20
1<BR>PuffLinux:dev$mount /dev/hde1 /mnt<BR>hde: dma_timer_expiry: dma =
status =3D=3D=20
0x24<BR>PDC202XX: Primary channel reset.<BR>hde: DMA interrupt =
recovery<BR>hde:=20
lost interrupt<BR>hde: dma_timer_expiry: dma status =3D=3D =
0x24<BR>PDC202XX: Primary=20
channel reset.<BR>hde: DMA interrupt recovery<BR>hde: lost =
interrupt<BR>hde:=20
dma_timer_expiry: dma status =3D=3D 0x24<BR>PDC202XX: Primary channel =
reset.<BR>hde:=20
DMA interrupt recovery<BR>hde: lost interrupt<BR>hde: dma_timer_expiry: =
dma=20
status =3D=3D 0x24<BR>PDC202XX: Primary channel reset.<BR>hde: DMA =
interrupt=20
recovery<BR>hde: lost interrupt<BR>FAT: codepage cp437 not =
found<BR>mount: wrong=20
fs type, bad option, bad superblock on=20
/dev/hde1,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; or too many mounted =
file=20
systems<BR>PuffLinux:dev$<BR></FONT></P></BODY></HTML>

------=_NextPart_000_001D_01C5B7E3.7238C730--
