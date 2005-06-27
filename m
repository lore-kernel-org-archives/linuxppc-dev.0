Return-Path: <grave@ipno.in2p3.fr>
Received: from ipnmail.in2p3.fr (ipnmail.in2p3.fr [134.158.92.208])
	by ozlabs.org (Postfix) with ESMTP id E9DD467A62
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jun 2005 00:32:36 +1000 (EST)
Received: from ipnnarval.in2p3.fr (ipnnarval.in2p3.fr [134.158.92.7])
	by ipnmail.in2p3.fr (8.13.4/8.13.4/IN2P3.FR) with ESMTP id
	j5RENDGA005506
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2005 16:23:13 +0200
From: Xavier Grave <grave@ipno.in2p3.fr>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="=-FC/fqtNb0Nqlti2N6feq"
Date: Mon, 27 Jun 2005 16:23:13 +0200
Message-Id: <1119882193.25013.2.camel@ipnnarval>
Mime-Version: 1.0
Subject: ppc405 kernel debugging
Reply-To: grave@ipno.in2p3.fr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-FC/fqtNb0Nqlti2N6feq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I try to boot a linux kernel (2.6.12) on a custom hardware (memec ff1152
board). If I use the xmd tool to download the zImage.elf I have the
following messages :

loaded at:     00400000 0047813C
board data at: 00476124 0047613C
relocated to:  004051D4 004051EC
zimage at:     004059E5 00475A06
avail ram:     00479000 04000000

Linux/PPC load: console=ttyS0,9600 root=/dev/nfs ip=dhcp
Uncompressing Linux...done.
Now booting the kernel
closing serial
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
ml300_map_io:enter
ml300_map_io:exit
MMU:exit

Starting with uboot I get (uImage) :
Filename 'ubootimage'.
Load address: 0x400000
Loading:
#################################################################
         #########################
done
Bytes transferred = 458849 (70061 hex)
=> bootm 0x400000
## Booting image at 00400000 ...
   Image Name:   Linux-2.6.12-bitsim
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    458785 Bytes = 448 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin

Does somebody know how to go further ?

In xilinx_ml300.c file, it seems that the following call is
start_kernel, but I don't know how to really debug at this point...
I had a try with print_char function but without much success...

I have a very small config file for the kernel, don't know to have a
smaller one...

kernel version : 2.6.12
gcc : 3.3.6
binutils : 2.14


Thanks in advance for any help...

xavier

--=-FC/fqtNb0Nqlti2N6feq
Content-Disposition: attachment; filename=config_kernel
Content-Type: text/plain; name=config_kernel; charset=us-ascii
Content-Transfer-Encoding: 7bit

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.12
# Mon Jun 27 12:53:17 2005
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
CONFIG_LOCALVERSION="-bitsim"
# CONFIG_SWAP is not set
# CONFIG_SYSVIPC is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_SYSCTL is not set
# CONFIG_AUDIT is not set
# CONFIG_HOTPLUG is not set
# CONFIG_IKCONFIG is not set
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
# CONFIG_SHMEM is not set
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_TINY_SHMEM=y
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Processor
#
# CONFIG_6xx is not set
CONFIG_40x=y
# CONFIG_44x is not set
# CONFIG_POWER3 is not set
# CONFIG_POWER4 is not set
# CONFIG_8xx is not set
# CONFIG_E500 is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_CPU_FREQ is not set
CONFIG_4xx=y

#
# IBM 4xx options
#
# CONFIG_ASH is not set
# CONFIG_BUBINGA is not set
# CONFIG_CPCI405 is not set
# CONFIG_EP405 is not set
# CONFIG_OAK is not set
# CONFIG_REDWOOD_5 is not set
# CONFIG_REDWOOD_6 is not set
# CONFIG_SYCAMORE is not set
# CONFIG_WALNUT is not set
CONFIG_XILINX_ML300=y
CONFIG_IBM405_ERR77=y
CONFIG_IBM405_ERR51=y
CONFIG_XILINX_OCP=y
CONFIG_VIRTEX_II_PRO=y
CONFIG_EMBEDDEDBOOT=y
# CONFIG_PPC4xx_DMA is not set
CONFIG_PPC_GEN550=y
# CONFIG_PM is not set
CONFIG_UART0_TTYS0=y
# CONFIG_UART0_TTYS1 is not set
CONFIG_NOT_COHERENT_CACHE=y

#
# Platform options
#
# CONFIG_PC_KEYBOARD is not set
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
# CONFIG_HIGHMEM is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="console=ttyS0,9600 root=/dev/nfs ip=dhcp"
CONFIG_ISA_DMA_API=y

#
# Bus options
#
# CONFIG_PCI is not set
# CONFIG_PCI_DOMAINS is not set

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
CONFIG_CONSISTENT_START=0xff100000
CONFIG_CONSISTENT_SIZE=0x00200000
CONFIG_BOOT_LOAD=0x00400000

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set
CONFIG_DEBUG_DRIVER=y

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
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_AS is not set
CONFIG_IOSCHED_DEADLINE=y
# CONFIG_IOSCHED_CFQ is not set

#
# ATA/ATAPI/MFM/RLL support
#
# CONFIG_IDE is not set

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

#
# IEEE 1394 (FireWire) support
#

#
# I2O device support
#

#
# Macintosh device drivers
#

#
# Networking support
#
# CONFIG_NET is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
# CONFIG_INPUT is not set

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
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_RAW_DRIVER is not set

#
# TPM devices
#

#
# I2C support
#
# CONFIG_I2C is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

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
# CONFIG_USB_ARCH_HAS_HCD is not set
# CONFIG_USB_ARCH_HAS_OHCI is not set

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
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set

#
# XFS support
#
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_DNOTIFY is not set
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
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
# CONFIG_TMPFS is not set
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
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
# CONFIG_NLS is not set

#
# IBM 40x options
#

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC32 is not set
# CONFIG_LIBCRC32C is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_FS is not set
CONFIG_KGDB=y
CONFIG_KGDB_TTYS0=y
# CONFIG_KGDB_TTYS1 is not set
# CONFIG_KGDB_TTYS2 is not set
# CONFIG_KGDB_TTYS3 is not set
# CONFIG_XMON is not set
# CONFIG_BDI_SWITCH is not set
CONFIG_SERIAL_TEXT_DEBUG=y
CONFIG_PPC_OCP=y

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

--=-FC/fqtNb0Nqlti2N6feq--
