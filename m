Message-ID: <3AE9ED9F.F768F526@carts.com>
Date: Fri, 27 Apr 2001 15:07:27 -0700
From: Kevin Fry <kevin@carts.com>
MIME-Version: 1.0
To: linuxppc emb3dd3d list <linuxppc-embedded@lists.linuxppc.org>
Subject: getty fails on custom mpc8260 board 
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    Hello fellow linuxppc'ers, I have a problem w/ linux crashing on my
custom mpc8260 board when init tries to call getty or bash and i'm
wondering if anyone can help me out.

    Im running ppcboot and hardhat linux 1.2, with the 2.4.0test2 kernel
and everything seems to be going fine until init tries to call getty for
tty1.. I changed inittab to try and call the bash shell by itself and it
crashed too.

    As you can see in the output, I have the debug statements enabled in
/drivers/char/tty_io.c, which dont help me out a whole lot.. You can
also see that because I have id:1:initdefault commented out in the
inittab, it asks me for a runlevel, and I'm able to enter it fine. then
it goes to getty and crashes, or if I enter 1 for the runlevel, it just
hangs as would be expected.    I'm also concerned about all though
/dev/cua messages, but i don't think they're causing my problem because
the serial i/o seems to be working fine.

    If anyone has any suggestions I would really appreciate it a lot!
thanks

Kevin Fry

---boot process--
   Loading Ramdisk to 03d1b000, end 03f5f7b5 ... OK
Total memory = 64MB; using 0kB for hash table (at 00000000)
Linux version 2.4.0-test2 (root@scirocco.carts.com) (gcc version 2.95.2
19991030
 (2.95.3 prerelease/franzo)) #130 Fri Apr 27 14:38:45 PDT 2001
Boot arguments: root=/dev/ram ramdisk_size=8192
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram ramdisk_size=8192
Calibrating delay loop... 109.77 BogoMIPS
Memory: 60832k available (752k kernel code, 348k data, 40k init)
[00000000,04000
000]
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
kmem_create: Poisoning requested, but con given - bdev_cache
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
kmem_create: Poisoning requested, but con given - inode_cache
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
kmem_create: Poisoning requested, but con given - skbuff_head_cache
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
Starting kswapd v1.6
CPM UART driver version 0.01
ttyS00 at 0x0000 is a SMC
ttyS01 at 0x0040 is a SMC
ttyS02 at 0x8100 is a SCC
ttyS03 at 0x8200 is a SCC
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: registered device at major 7
loop: enabling 8 loop devices
eth0: FCC ENET Version 0.1, 00:03:70:80:00:ff
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 2321k freed
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 40k init
opening c...<4>tty_io.c: process 1 (init) used obsolete
 /dev/cua - update software to use /dev/ttyS1
release_dev of cua (tty count=1)...freeing tty structure...opening
c...<4>tty_io
.c: process 1 (init) used obsolete /dev/cua - update software to use
/dev/tt1
release_dev of cua (tty count=1)...freeing tty structure...opening
c...<4>tty_io
.c: process 1 (init) used obsolete /dev/cua - update software to use
/dev/ttyS1
INIT: release_dev of cua (tty count=1)...freeing tty structure...opening
c...<4>
tty_io.c: process 1 (init) used obsolete /dev/cua - update software to
use /dev/
ttyS1
version 2.77 bootingrelease_dev of cua (tty count=1)...freeing tty
structure...o
pening c...<4>tty_io.c: process 1 (init) used obsolete /dev/cua - update
softwar
e to use /dev/ttyS1
release_dev of cua (tty count=1)...freeing tty structure...opening
c...release_d
ev of cua (tty count=1)...freeing tty structure...opening
c...release_dev of cua
 (tty count=1)...freeing tty structure...opening c...
Enter runlevel: 2
release_dev of cua (tty count=1)...freeing tty structure...opening
c...release_d
INIT: release_dev of cua (tty count=1)...freeing tty structure...opening
c...Ent
ering runlevel: 2release_dev of cua (tty count=1)...freeing tty
structure...open
release_dev of cua (tty count=1)...freeing tty structure...NIP: 03D97E88
XER: 20
000000 LR: 0000002C REGS: 03d97d20 TRAP: 0700
MSR: 00089002 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = 03d96000[5] 'init' Last syscall: 6
last math 00000000 last altivec 00000000
GPR00: 00000030 03D97DD0 03D96000 00009002 03D97E88 0000001F 03D97E60
00000001
GPR08: 03D97C30 0000000B FFFFFFFF 03D97C80 00000000 1001F1C8 03FDD000
007FFF1F
GPR16: 00000000 FFFFFFFF 00000000 10010000 00009032 03D97E80 00000000
00004ABC
GPR24: 00000000 10017908 10010000 00000001 03D97E60 0000001F 00000001
03D97E60
Call backtrace:
00000000
Kernel panic: Exception in kernel pc 3d97e88 signal 4
Rebooting in 180 seconds..

---inittab---

# inittab       This file describes how the INIT process should set up
#               the system in a certain run-level.
#
# Author:       Miquel van Smoorenburg, <miquels@drinkel.nl.mugnet.org>
#               Modified for RHS Linux by Marc Ewing and Donnie Barnes
#
# hacked for hhl-ppc_8xx

# Default runlevel. The runlevels used by RHS are:
#   0 - halt (Do NOT set initdefault to this)
#   1 - Single user mode
#   2 - Multiuser, without NFS (The same as 3, if you do not have
networking)
#   3 - Full multiuser mode
#   4 - unused
#   5 - X11
#   6 - reboot (Do NOT set initdefault to this)
#
#id:1:initdefault:

# System initialization.
#si::sysinit:/etc/rc.d/rc.sysinit
#si::sysinit:/etc/rc

# Single user shell
1:2345:respawn:/sbin/getty 9600 tty1
#2:23:respawn:/sbin/getty 9600 tty2

---.config---
#
# Automatically generated make config: don't edit
#
# CONFIG_UID16 is not set

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set

#
# Platform support
#
CONFIG_PPC=y
# CONFIG_6xx is not set
# CONFIG_4xx is not set
# CONFIG_PPC64BRIDGE is not set
CONFIG_8260=y
# CONFIG_8xx is not set
CONFIG_6xx=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_ALL_PPC is not set
# CONFIG_GEMINI is not set
CONFIG_EST8260=y
# CONFIG_SANDPOINT is not set
# CONFIG_APUS is not set
# CONFIG_ALL_PPC is not set
# CONFIG_SMP is not set
# CONFIG_RTSCHED is not set
# CONFIG_ALTIVEC is not set
CONFIG_MACH_SPECIFIC=y

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# General setup
#
# CONFIG_ISA is not set
# CONFIG_SBUS is not set
# CONFIG_PCI is not set
CONFIG_NET=y
CONFIG_SYSCTL=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_KERNEL_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set
# CONFIG_VGA_CONSOLE is not set
# CONFIG_FB is not set
# CONFIG_PMAC_PBOOK is not set
# CONFIG_MAC_FLOPPY is not set
# CONFIG_MAC_SERIAL is not set
# CONFIG_ADB is not set
# CONFIG_PROC_DEVICETREE is not set
# CONFIG_BOOTX_TEXT is not set
# CONFIG_MOTOROLA_HOTSWAP is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_LVM is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=8192
CONFIG_BLK_DEV_INITRD=y
# CONFIG_BLK_DEV_FLASH is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK=y
# CONFIG_RTNETLINK is not set
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_IP_ROUTER is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
CONFIG_IP_ALIAS=y
# CONFIG_SYN_COOKIES is not set

#
# (it is safe to leave these untouched)
#
CONFIG_SKB_LARGE=y

#
#
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
#
# ATA/IDE/MFM/RLL support
#
# CONFIG_IDE is not set
# CONFIG_BLK_DEV_IDE_MODES is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MACE is not set
# CONFIG_BMAC is not set
# CONFIG_GMAC is not set
# CONFIG_NCR885E is not set
# CONFIG_OAKNET is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_DEPCA is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set
#

# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Console drivers
#

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Character devices
#
# CONFIG_VT is not set
# CONFIG_SERIAL is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set

#
# Video For Linux
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_DRM is not set
# CONFIG_DRM_TDFX is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_RAMFS is not set
# CONFIG_ISO9660_FS is not set
# CONFIG_JOLIET is not set
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_SYSV_FS_WRITE is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_MOUNT_SUBDIR is not set
# CONFIG_NCPFS_NDS_DOMAINS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_NLS is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# MPC8260 Communication Options
#
# CONFIG_SCC_ENET is not set
CONFIG_FEC_ENET=y
# CONFIG_FCC1_ENET is not set
CONFIG_FCC2_ENET=y

#
# USB support
#
# CONFIG_USB is not set

#
# Kernel hacking
#
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_KGDB is not set
# CONFIG_XMON is not set


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
