Date: Fri, 22 Oct 1999 20:32:01 -0500
From: Grant Erickson <grant@lcse.umn.edu>
To: linuxppc-embedded@lists.linuxppc.org
cc: Daniel Nilsson <daniel.n.nilsson@home.se>,
        Adrian Cox <apc@agelectronics.co.uk>, Wolfgang Denk <wd@denx.de>
Subject: TiVo Kernel for 403GCX Update (was Re: Support for IBM CPUs?)
In-Reply-To: <Pine.SGI.4.10.9910201456390.20307-100000@brule.lcse.umn.edu>
Message-ID: <Pine.SGI.4.10.9910222012050.46619-100000@brule.lcse.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've made some progress since Wednesday with the TiVo source code. As I
mentioned previously, the TiVo Linux kernel is based on the 2.1.24 PowerPC
sources. However, after comparing the tree against both stock 2.1.24 and
2.2.12 trees, it appears they've borrowed code from more recent trees and
HEAVILY modified the 2.1.24 code in others.

They have configurations for both the TeleWorld Consumer Device (TCD) and
the TeleWorld Consumer Device Eval Board (TCD_EVAL). The latter of these
is presumed to be the IBM PowerPC 403GCX "Oak" evaluation board.

Included in arch/ppc are two configuration files, devconf and prodconf,
one presumably for development/manufacturing configurations and the other
for released product in the field (I've included devconf below).

Compiling this with the LATEST released set of GNU tools and the GCC
2.95.1 compiler was pretty straightforward using the 'devconf'
configuration as a base and then adding "CONFIG_TCD_EVAL=y" for my IBM
evaluation board.

The only major changes required were to drivers/char/serial.c (which is
changed dramatically from stock) and arch/ppc/tcd/qdma.c (a DMA engine for
their Audio, Video, and disk controllers).

Anyway, I was able to successfully load the kernel to the IBM evaluation
board using the tftpboot functionality in the IBM-supplied PROM; however,
the system froze after a few instructions.

Time to hook up the ICE and figure out where things are stopping...

Getting most of the changes into the 2.3.x development tree shouldn't be
too difficult. I've got some preliminary stuff done. What is the best
protocol to follow, submit the patches to the list for general evaluation
and dissemination or send them to Cort and then everyone call grab them
from vger?

Anyone else out there call up TiVo and get their source code yet?

---

#
# Automatically generated make config: don't edit
#

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set

#
# Platform support: you must select the Teleworld Customer Device
#
CONFIG_TCD=y
# CONFIG_TCD_EVAL is not set

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
CONFIG_KERNELD=y

#
# General setup
#
CONFIG_CONTIGMEM=y
CONFIG_TCD_MEMLOG=y
CONFIG_NET=y
# CONFIG_MATH_EMULATION is not set
CONFIG_KERNEL_ELF=y
CONFIG_NO_KEYBOARD=y
CONFIG_XMON=y
# CONFIG_GUARDS is not set
CONFIG_SYSVIPC=y
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_JAVA=m

#
# Floppy, IDE, and other block devices
#
# CONFIG_BLK_DEV_FD is not set
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_IDE_CHIPSETS=y

#
# Note: most of these also require special kernel boot parameters
#
CONFIG_TCD_IDE_DMA=y
# CONFIG_BLK_DEV_ALI14XX is not set
# CONFIG_BLK_DEV_DTC2278 is not set
# CONFIG_BLK_DEV_HT6560B is not set
# CONFIG_BLK_DEV_QD6580 is not set
# CONFIG_BLK_DEV_UMC8672 is not set

#
# Additional Block Devices
#
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_RAM=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_DEV_EZ is not set
# CONFIG_BLK_DEV_HD is not set

#
# Networking options
#
# CONFIG_NETLINK is not set
# CONFIG_FIREWALL is not set
CONFIG_NET_ALIAS=y
CONFIG_INET=y
# CONFIG_IP_FORWARD is not set
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ACCT is not set
CONFIG_IP_ALIAS=y

#
# (it is safe to leave these untouched)
#
# CONFIG_INET_PCTCP is not set
CONFIG_INET_RARP=y
CONFIG_PATH_MTU_DISCOVERY=y
CONFIG_IP_NOSR=y
# CONFIG_SKB_LARGE is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_AX25 is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_TCD8390=y
CONFIG_PPP=y

#
# CCP compressors for PPP are only built as modules.
#

#
# Filesystems
#
# CONFIG_QUOTA is not set
# CONFIG_MINIX_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_BEXT2_FS is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_UMSDOS_FS is not set
CONFIG_PROC_FS=y
CONFIG_NFS_FS=y
CONFIG_ROOT_NFS=y
CONFIG_RNFS_BOOTP=y
CONFIG_RNFS_RARP=y
# CONFIG_SMB_FS is not set
# CONFIG_ISO9660_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_MAC_PARTITION=y
# CONFIG_HFS_FS is not set

#
# Character devices
#
CONFIG_SERIAL=y
# CONFIG_DIGI is not set
# CONFIG_CYCLADES is not set
# CONFIG_STALDRV is not set
# CONFIG_RISCOM8 is not set
# CONFIG_ESPSERIAL is not set
# CONFIG_PRINTER is not set
# CONFIG_MOUSE is not set
# CONFIG_UMISC is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_FTAPE is not set
# CONFIG_APM is not set
# CONFIG_WATCHDOG is not set
# CONFIG_RTC is not set

#
# Kernel hacking
#
# CONFIG_PROFILE is not set


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
