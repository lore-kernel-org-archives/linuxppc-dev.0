Message-ID: <20040717224154.36897.qmail@web15205.mail.bjs.yahoo.com>
Date: Sun, 18 Jul 2004 06:41:54 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: [Summary]2.6.7 kernel can work on RPXlite DW with RAMDISK R.F.S
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20040709215108.5DC7DC109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,everyone,

After following 8xx pioneers' step,I tested linuxppc
bk tree on RPXlite DW board and get a certain
result.By now 2.6.7 kernel can work on 8xx demo
board,RPXlite DW with RAMDISK root file
system.Following is my detail process,from downloading
BitKeeper package to test the compiling kernel on this
board.This post only intends to sum up 8xx pioneers'
work partly and try to help some 8xx fans' do the
similar test effectively.But if the post take you
"waste" more time on such test without getting
expected satisfaction,don't blame it on 8xx
pioneers.Blame it on yourself or this post :-)

Thanks to Dan Malek,Tom Rini,Pantelis Antoniou and
many other people's excellent porting work on 8xx with
2.6.x.Also,I should apperciate Robert P. J. Day's good
questions,most are what I want to know.Yeah,Embedded
Planet provided the nice hardware platform.Last but
not least,thanks to DENX U-Boot project and solid tool
kit,ELDK 3.0,to make the test a reality.Uh,MVL PRO 3.0
can also compling 2.6.x kernel right.But I use ELDK
for the test.

1.Download BitKeeper from
http://www.bitkeeper.com/Products.BK_Pro.Downloads.html
For RED HAT 7.3 on i686 host pc,you could choose
bk-3.2.2c-x86-glibc22-linux like me.
bk-3.2.2c-x86-glibc23-linux is for RED HAT 9.0 on
i386.After a free registration,you can get the binary
install package.

2.Install BitKeeper on your host PC.Just type the
command: ./bk-3.2.2c-x86-glibc22-linux
Following the instruction,you would finish the
installation in no time.

3.Get a work copy from linuxppc-2.5 bk tree.
bk clone http://ppc.bkbits.net:8080/linuxppc-2.5
linuxppc26

If it doesn't work,you could try use a proxy server
like:
export http_proxy=http://xxx.xxx.xxx.xxx:xx

[...]

4.Check out all files:
- cd linuxppc26
- bk -r edit

[...]

5.Compiling the kernel as follows:
- make ARCH=ppc menuconfig
or you could use my config file as a start like:
- make ARCH=ppc rpxlite-sam_defconfig

[HOSTCC  scripts/basic/fixdep
 ...
 scripts/kconfig/mconf arch/ppc/Kconfig
 ...]

- make ARCH=ppc CROSS_COMPILE=ppc_8xx- uImage

[CHK     include/linux/version.h
 ...
 Image Name:   Linux-2.6.7
 Created:
 ...
  Image arch/ppc/boot/images/uImage is ready]

{There are no any cross compling help in linuxppc
kernel README.Does every embedded folk know it
clearly?At least I didn't.I got the compiling format
in Karim Yaghmour's book,Building Embedded Linux
Systems}

6. Copy the uImage kernel to your tftp boot directory.
[root@localhost linuxppc26]# cp
arch/ppc/boot/images/uImage /tftpboot/uImage.rpx2618

7. Boot the kernel by U-Boot:
First,erase the uImage kernel to target FLASH by
U-Boot.And a ramdisk,which you could download it from
DENX ftp,is supposed to have been programmed at
another place in FLASH.There are several ways to boot
a kernel with a ramdisk but I make the demo in the
simpliest way.Finally,here is the result:

U-Boot 1.1.2 (Jul 15 2004 - 17:26:45)

CPU:   PPC823EZTnnB2 at 48 MHz: 16 kB I-Cache 8 kB
D-Cache
Board: RPXlite_DW
DRAM:  64 MB
FLASH: 16 MB
In:    serial
Out:   serial
Err:   serial
Net:   SCC ETHERNET
u-boot>pri
bootcmd=run flash_self
baudrate=9600
loads_echo=1
ethaddr=00:10:EC:00:37:5B
netdev=eth0
addip=setenv bootargs $(bootargs)
ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname):$(netdev):off
panic=1
flash_nfs=run nfsargs addip;bootm $(kernel_addr)
flash_self=run ramargs addip;bootm $(kernel_addr)
$(ramdisk_addr)
net_nfs=tftp 200000 $(bootfile);run nfsargs
addip;bootm
ethact=SCC ETHERNET
rootpath=/eldk/ppc_8xx/
ramargs=setenv bootargs root=/dev/ram rw
ramdisk_addr=ff900000
bootargs=root=/dev/nfs rw
nfsroot=172.16.115.3:/eldk/ppc_8xx/
ip=172.16.115.7:172.16.115.3:172.16.115.254:255.255.255.0::eth0:off
panic=1
filesize=b8cbd
fileaddr=100000
gatewayip=172.16.115.254
netmask=255.255.255.0
ipaddr=172.16.115.7
serverip=172.16.115.3
kernel_addr=ff600000
bootfile=uImage.rpx2618
nfsargs=setenv root=/dev/nfs rw
rootpath=:/eldk/ppc_8xx/
severip=172.16.115.3
stdin=serial
stdout=serial
stderr=serial

Environment size: 905/32764 bytes
u-boot>run flash_self
## Booting image at ff600000 ...
   Image Name:   Linux-2.6.7
   Image Type:   PowerPC Linux Kernel Image (gzip
compressed)
   Data Size:    767194 Bytes = 749.2 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at ff900000 ...
   Image Name:   SELF in commpressed
   Image Type:   PowerPC Linux RAMDisk Image (gzip
compressed)
   Data Size:    1557227 Bytes =  1.5 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 03e38000, end 03fb42eb ... OK
Linux version 2.6.7 (root@localhost.localdomain) (gcc
version 3.2.2 20030217 (Yellow Dog Linux 3.0
3.2.2-2a_1)) #1 Sun Jul 18 03:48:35 CST 2004
On node 0 totalpages: 16384
  DMA zone: 16384 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: root=/dev/ram rw
ip=172.16.115.7:172.16.115.3:172.16.115.254:255.255.255.0::eth0:off
panic=1
PID hash table entries: 512 (order 9: 4096 bytes)
Decrementer Frequency = 180000000/60
Dentry cache hash table entries: 16384 (order: 4,
65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768
bytes)
Memory: 61488k available (1368k kernel code, 300k
data, 60k init, 0k highmem)
Calibrating delay loop... 47.10 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096
bytes)
checking if image is initramfs...it isn't (no cpio
magic); looks like an initrd
Freeing initrd memory: 1520k freed
NET: Registered protocol family 16
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Generic RTC Driver v1.07
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xfa200a80 (irq = 20) is a CPM UART
ttyCPM1 at MMIO 0xfa200a00 (irq = 46) is a CPM UART
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
loop: loaded (max 8 devices)
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind
8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 60k init
serial console detected.  Disabling virtual terminals.
lo: driver changed get_stats after register

BusyBox v0.60.1 (2002.10.24-04:52+0000) Built-in shell
(msh)
Enter 'help' for a list of built-in commands.

# My application is running ... Sam Song
         Feb.7,2004
Hello Shanghai Univ.
Hi Everybody!

# ls
bin
dev
etc
ftp
home
lib
proc
sbin
timer
tmp
usr
var
#

===================================================
rpxlite-sam_defconfig
===================================================
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
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_HOTPLUG is not set
# CONFIG_IKCONFIG is not set
CONFIG_EMBEDDED=y
# CONFIG_KALLSYMS is not set
CONFIG_FUTEX=y
# CONFIG_EPOLL is not set
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
# CONFIG_IOSCHED_CFQ is not set
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

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
CONFIG_8xx=y
# CONFIG_E500 is not set
CONFIG_MATH_EMULATION=y
# CONFIG_CPU_FREQ is not set
CONFIG_EMBEDDEDBOOT=y
CONFIG_NOT_COHERENT_CACHE=y

#
# Platform options
#
CONFIG_RPXLITE=y
# CONFIG_RPXCLASSIC is not set
# CONFIG_BSEIP is not set
# CONFIG_FADS is not set
# CONFIG_TQM823L is not set
# CONFIG_TQM850L is not set
# CONFIG_TQM855L is not set
# CONFIG_TQM860L is not set
# CONFIG_FPS850L is not set
# CONFIG_SPD823TS is not set
# CONFIG_IVMS8 is not set
# CONFIG_IVML24 is not set
# CONFIG_SM850 is not set
# CONFIG_HERMES_PRO is not set
# CONFIG_IP860 is not set
# CONFIG_LWMON is not set
# CONFIG_PCU_E is not set
# CONFIG_CCM is not set
# CONFIG_LANTEC is not set
# CONFIG_MBX is not set
# CONFIG_WINCEPT is not set
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
# CONFIG_HIGHMEM is not set
CONFIG_KERNEL_ELF=y
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_CMDLINE_BOOL is not set

#
# Bus options
#
# CONFIG_PCI is not set
# CONFIG_PCI_DOMAINS is not set
# CONFIG_PCI_QSPAN is not set

#
# Advanced setup
#
# CONFIG_ADVANCED_OPTIONS is not set

#
# Default settings for advanced configuration options
are used
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
CONFIG_PREVENT_FIRMWARE_BUILD=y

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
# CONFIG_BLK_DEV_NBD is not set
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
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
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
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_BT is not set

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
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
# CONFIG_SERIO_I8042 is not set
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set

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
# CONFIG_VT is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_CPM=y
CONFIG_SERIAL_CPM_CONSOLE=y
CONFIG_SERIAL_CPM_SCC1=y
# CONFIG_SERIAL_CPM_SCC2 is not set
# CONFIG_SERIAL_CPM_SCC3 is not set
# CONFIG_SERIAL_CPM_SCC4 is not set
CONFIG_SERIAL_CPM_SMC1=y
# CONFIG_SERIAL_CPM_SMC2 is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_QIC02_TAPE is not set

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
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_RAW_DRIVER is not set

#
# I2C support
#
# CONFIG_I2C is not set

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
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
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
# CONFIG_FAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_SYSFS is not set
CONFIG_DEVFS_FS=y
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
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
CONFIG_LOCKD=y
# CONFIG_EXPORTFS is not set
CONFIG_SUNRPC=y
# CONFIG_RPCSEC_GSS_KRB5 is not set
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
# CONFIG_MSDOS_PARTITION is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
# CONFIG_NLS is not set

#
# MPC8xx CPM Options
#
# CONFIG_8xx_UART is not set

#
# Generic MPC8xx Options
#
CONFIG_8xx_COPYBACK=y
# CONFIG_8xx_CPU6 is not set
# CONFIG_UCODE_PATCH is not set

#
# Library routines
#
# CONFIG_CRC16 is not set
# CONFIG_CRC32 is not set
# CONFIG_LIBCRC32C is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

--------------------------------------------------

Best regards,

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
