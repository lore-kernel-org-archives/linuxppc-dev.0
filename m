Message-ID: <313680C9A886D511A06000204840E1CF08F430CE@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: linux-2.6.8-rc2 cross-compilation errors with CONFIG_ADS8272=y
Date: Thu, 5 Aug 2004 11:49:33 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have tried 2 more configurational variants:

1) with CONFIG_SANDPOINT=y

This cross-compiled but would not boot - similarly to previously reported
...

2) with

 CONFIG_ADS8272=y
 CONFIG_PQ2ADS=y
 CONFIG_8260=y
 CONFIG_8272=y
 CONFIG_CPM2=y
 CONFIG_EMBEDDEDBOOT=y

In this case the cross-compilation build

make ARCH=ppc CROSS_COMPILE=powerpc-linux-

 came to following errors:

arch/ppc/boot/simple/embed_config.c:29: warning: `bdinfo' defined but not
used
arch/ppc/boot/simple/embed_config.c:42: warning: `def_enet_addr' defined but
not used
arch/ppc/boot/simple/embed_config.c:415: warning: `clk_8260' defined but not
used
arch/ppc/boot/simple/embed_config.c:457: warning: `clk_8280' defined but not
used
  CC      arch/ppc/boot/simple/dummy.o
powerpc-linux-objcopy -O elf32-powerpc \
        --add-section=.image=arch/ppc/boot/images/vmlinux.gz \
        --set-section-flags=.image=contents,alloc,load,readonly,data \
        arch/ppc/boot/simple/dummy.o arch/ppc/boot/simple/image.o
powerpc-linux-ld -T
/cygdrive/d/Profiles/apovolot/linux-2.6.8-rc2/linux-2.6.7/ar
ch/ppc/boot/ld.script -Ttext 0x00400000 -Bstatic -o
arch/ppc/boot/simple/zvmlinu
x arch/ppc/boot/simple/head.o arch/ppc/boot/simple/relocate.o
arch/ppc/boot/simp
le/misc-embedded.o arch/ppc/boot/simple/embed_config.o
arch/ppc/boot/simple/imag
e.o arch/ppc/boot/common/lib.a arch/ppc/boot/lib/lib.a
arch/ppc/boot/simple/misc-embedded.o(.text+0x2c): In function `load_kernel':
: undefined reference to `embed_config'
make[2]: *** [arch/ppc/boot/simple/zvmlinux] Error 1
make[1]: *** [simple] Error 2
make: *** [zImage] Error 2

-----Original Message-----
From: Povolotsky, Alexander
Sent: Thursday, August 05, 2004 8:41 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Has anybody successfuly run linux-2.6.8-rc2 (or any
previous linu x 2.6 version) on MPC 82xx ?


Hi Miguel,

OK - I redid configuration and rebuilt it - now it hangs but without
resetting the processor

=> tftpboot 400000 uimagenfs
TFTP from server 172.16.240.200; our IP address is 172.16.119.3
Filename 'uimagenfs'.
Load address: 0x400000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################
done
Bytes transferred = 1246731 (13060b hex)
=> bootm
## Booting image at 00400000 ...
   Image Name:   linux-2.6.8-rc2 Kernel for PQ2FA
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1246667 Bytes =  1.2 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

The sequence of building I used is:

make ARCH=ppc CROSS_COMPILE=powerpc-linux-  clean
make ARCH=ppc CROSS_COMPILE=powerpc-linux-  defconfig
make ARCH=ppc CROSS_COMPILE=powerpc-linux-  menuconfig
make ARCH=ppc CROSS_COMPILE=powerpc-linux-
cd arch/ppc/boot/images
ln -s /cygdrive/d/Profiles/apovolot/U-boot/u-boot-1.1.1/tools/mkimage

./mkimage -n 'linux-2.6.8-rc2 Kernel for PQ2FADS' -A ppc -O linux  -T kernel
-C gzip -a 0 -e 0  -d ./vmlinux.gz ./uImage

My .config file now is:

#
# Automatically generated make config: don't edit
#
CONFIG_MMU=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_GENERIC_NVRAM=y

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Processor
#
CONFIG_6xx=y
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_POWER3 is not set
# CONFIG_POWER4 is not set
# CONFIG_8xx is not set
# CONFIG_E500 is not set
# CONFIG_CPU_FREQ is not set
CONFIG_EMBEDDEDBOOT=y
CONFIG_PPC_STD_MMU=y

#
# Platform options
#
# CONFIG_PPC_MULTIPLATFORM is not set
# CONFIG_APUS is not set
# CONFIG_WILLOW is not set
# CONFIG_PCORE is not set
# CONFIG_POWERPMC250 is not set
# CONFIG_EV64260 is not set
# CONFIG_SPRUCE is not set
# CONFIG_LOPEC is not set
# CONFIG_MCPN765 is not set
# CONFIG_MVME5100 is not set
# CONFIG_PPLUS is not set
# CONFIG_PRPMC750 is not set
# CONFIG_PRPMC800 is not set
# CONFIG_SANDPOINT is not set
# CONFIG_ADIR is not set
# CONFIG_K2 is not set
# CONFIG_PAL4 is not set
# CONFIG_GEMINI is not set
CONFIG_EST8260=y
# CONFIG_SBC82xx is not set
# CONFIG_SBS8260 is not set
# CONFIG_RPX6 is not set
# CONFIG_TQM8260 is not set
# CONFIG_ADS8272 is not set
CONFIG_8260=y
CONFIG_CPM2=y
# CONFIG_PC_KEYBOARD is not set
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
# CONFIG_HIGHMEM is not set
CONFIG_KERNEL_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
# CONFIG_CMDLINE_BOOL is not set

#
# Bus options
#
# CONFIG_PCI is not set
# CONFIG_PCI_DOMAINS is not set

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_TCIC=y

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
CONFIG_BOOT_LOAD=0x00400000

#
# Device Drivers
#

#
# Generic Driver Options
#
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
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
# CONFIG_LBD is not set

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
# CONFIG_IEEE1394 is not set

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
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
# CONFIG_SERIO is not set
# CONFIG_SERIO_I8042 is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_CPM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
CONFIG_IPMI_HANDLER=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
# CONFIG_IPMI_SI is not set
CONFIG_IPMI_WATCHDOG=y

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_NVRAM is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_RAW_DRIVER is not set

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
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_MDA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_DEBUG=y
# CONFIG_JFS_STATISTICS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
CONFIG_MINIX_FS=y
CONFIG_ROMFS_FS=y
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="n"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_HFSPLUS_FS is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_CRAMFS=y
CONFIG_VXFS_FS=y
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
CONFIG_SYSV_FS=y
CONFIG_UFS_FS=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_UTF8=y

#
# CPM2 Options
#

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_KGDB_CONSOLE is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set


Thanks,
Best Regards,
Alex
-----Original Message-----
From: miguel.valero@axxessit.no [mailto:miguel.valero@axxessit.no]
Sent: Thursday, August 05, 2004 6:04 AM
To: Povolotsky, Alexander
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Has anybody successfuly run linux-2.6.8-rc2 (or any
previous linu x 2.6 version) on MPC 82xx ?


I have linux-2.6.7 running on both MPC8265 and MPC8280 based custom
boards.

Firstly, I think your problem may be that the u-boot overwrites the linux
image file during decompression, because it is placed too low in memory
(0x200000).
Try first to set your u-boot environment loadaddr higher.

0x400000 works fine for linux-2.6.7, but another thing I see is that your
linux image file is rather large (190c52 hex). My linux-2.6.7 uImage file is
f10e9 hex, quite smaller.
Has linux-2.6.8 grown so much ? or are you making the wrong image ? You
should make uImage, I guess you are aware of that.

Miguel

"Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Sent by: owner-linuxppc-embedded@lists.linuxppc.org
05.08.04 10:39


To:"'linuxppc-embedded@lists.linuxppc.org'"
<linuxppc-embedded@lists.linuxppc.org>
cc: "'mcclintock@freescale.com'" <mcclintock@freescale.com>
Subject: Has anybody successfuly run linux-2.6.8-rc2 or any previous linux
2.6 version on MPC82xx ?


Hello,

I have been told that the first linux 2.6 version, which should work on MPC
82xx is linux-6.8-rc2 ...?
So I have cross-compiled "vanilla" linux-2.6.8-rc2 (using Cygwin with
quite a few patches from Dan Kegel, Martin Schaffner and others to make
cross-compiling work - except for netfilter code, which doesn't
cross-compile on Cygwin and needs to be disabled, which I did) for ppc,
82xx and created uimage (used mkimage tool from u-boot-1.1.1, which I have
built also on Cygwin with the latest Yuli Barcohen's patch). I have loaded
this
uimage onto PQ2 ADS witn MPC8270 (U-Boot version loaded on the PQ2 ADS
flash is still 1.0.0.) and tried to run it with "bootm" - but it fails
(resets)
immediately after decompressing the image ... and I do not have 82xx
back-end Jtag probe/debugger available to me to see what is happening...

U-Boot 1.0.0 (Jan 30 2004 - 16:09:23)
=> tftpboot 200000 uimagenfs
TFTP from server 172.16.240.200; our IP address is 172.16.119.3
Filename 'uimagenfs'.
Load address: 0x200000
Loading: T
#################################################################
         #################################################################
         #################################################################
         #################################################################
         #############################################################
done
Bytes transferred = 1641554 (190c52 hex)
=>bootm

Has anybody successfuly run linux-2.6.8-rc2 (or previous linux 2.6
version)on MPC 82xx ?
If so, could you share with me ".config" file used ?

On another more general subject - does Freescale (former Motorola) has a
single focal point person who's charter is to promote Linux board support
on Motorola development boards (aka Linux czar) - do you have his contact
info ?

I know that there were Linux OS Development Breakout Sessions SNDF (Smart
Networks Developer Forum ) April,  2004 Dallas
http://www.freescale.com/webapp/sps/site/overview.jsp?nodeId=02VS0llCc5pzMP5
51361587974
So somebody should stand behind Linux development activity  at  Freescale/
Motorola (both IBM and HP do have dedicated Linux Labs and people working
strictly on Linux ...) I guess ...

Thanks,
Best Regards,
Alex


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
