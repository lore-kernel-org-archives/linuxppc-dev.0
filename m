Return-Path: <arunkat@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.234])
	by ozlabs.org (Postfix) with ESMTP id A188667BA8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Jul 2006 00:56:32 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id i5so387631wra
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Jul 2006 07:56:29 -0700 (PDT)
Message-ID: <edd12c050607210756h71bab7f8ve323edf3bf6077c6@mail.gmail.com>
Date: Fri, 21 Jul 2006 20:26:28 +0530
From: "Arun Kumar" <arunkat@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: problems with mounting JFFS2 using CFI for AM29LV160MT on ppc8245
	k2.4.x
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_58153_24972525.1153493788920"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_58153_24972525.1153493788920
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi ,
Can anyone help me in this naive problem ?

I am using k 2.4.x based on ppc8245 based .I have a 8MB flash mapped to
adress -0xff800000 .with 4 interleaved AMD flash devices each of size 2Mib =
.
Inte

The problem I am facing are two :
I am not sure whether my flash read/write routines are working properly
.(cfi_cmdset_0002.c routines )

I am able to detect my flash and do MTD partions too on the flash .But I
cannot see that in my
dev directory .I mean I should see something like /dev/mtd0 ...etc .

As I want to mount JFFS2 and I am not sure of whether i can mount any
Filesystem without seeing it in /dev directory .

Is there way wherein I can invoke mtd->write/mtd/->
read routines so that I can be sure that my CFI driver is working fine ?
these routines are mapped to amdstd_read/write routines in cfi_cmdset_0002
routine .
 mtd->read =3D cfi_amdstd_read;
 mtd->write =3D cfi_amdstd_write;

Here is my dump

################################################################

LSP Revision 1
Starting kswapd
Disabling the Out Of Memory Killer
JFFS2 version 2.1. (C) 2001, 2002 Red Hat, Inc., designed by Axis
Communications
 AB.
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI en
abled
ttyS00 at 0xfcf04500 (irq =3D 13) is a ST16650
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize

 AMD_FLASH_INIT called  *aks *
physmap flash device: 800000 at ff800000 virtual address Number of erase
regions
: 4
Primary Vendor Command Set: 0002 (AMD/Fujitsu Standard)
Primary Algorithm Table at 0040
Alternative Vendor Command Set: 0000 (None)
No Alternate Algorithm Table
Vcc Minimum: 2.7 V
Vcc Maximum: 3.6 V
No Vpp line
Typical byte/word write timeout: 128 =B5s
Maximum byte/word write timeout: 256 =B5s
Full buffer write not supported
Typical block erase timeout: 1024 ms
Maximum block erase timeout: 16384 ms
Chip erase not supported
Device size: 0x200000 bytes (2 MiB)
Flash Device Interface description: 0x0002
  - supports x8 and x16 via BYTE# with asynchronous interface
Max. bytes in buffer write: 0x1
Number of Erase Block Regions: 4
  Erase Region #0: BlockSize 0x4000 bytes, 1 blocks
  Erase Region #1: BlockSize 0x2000 bytes, 2 blocks
  Erase Region #2: BlockSize 0x8000 bytes, 1 blocks
  Erase Region #3: BlockSize 0x10000 bytes, 31 blocks
 Amd/Fujitsu Extended Query Table v1.3 at 0x0040
number of CFI chips: 4

 in amdstd_setup 0:
cfi_cmdset_0002: Disabling fast programming due to code brokenness.

 in MTD Partitioning <5>No RedBoot partition table detected in
phys_mapped_flash

Using physmap partition definition
Creating 3 MTD partitions on "phys_mapped_flash":
0x00000000-0x00040000 : "foo-ets0"
mtd: Giving out device 0 to foo-ets0
0x00040000-0x001e0000 : "foo-ets1"
mtd: partition "agere-ets1" doesn't end on an erase block -- force read-onl=
y
mtd: Giving out device 1 to foo-ets1
0x001e0000-0x00200000 : "foo-ets2"
mtd: partition "foo-ets2" doesn't start on an erase block boundary -- force
re
ad-only
mtd: Giving out device 2 to foo-ets2
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
IP-Config: No network devices available.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
/dev/console mapped to mkdev 5: minor: 1
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1247k freed
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 76k init
calling sbin/init
init started:  BusyBox v1.2.0 (2006.07.12-05:25+0000) multi-call binary
init started:  BusyBox v1.2.0 (2006.07.12-05:25+0000) multi-call binary
Starting pid 8, console /dev/ttyS0: '/bin/ash'



/ $ cd /dev
/dev $ ls
console  loop2    loop7    ram1     ram14    ram4     ram9     urandom
full     loop3    mem      ram10    ram15    ram5     random   zero
kmem     loop4    null     ram11    ram16    ram6     tty
loop0    loop5    port     ram12    ram2     ram7     tty0
loop1    loop6    ram0     ram13    ram3     ram8     ttyS0




################################################################


#
# Automatically generated make config: don't edit
#
# CONFIG_UID16 is not set
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_HAVE_DEC_LOCK=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy
# CONFIG_ADVANCED_OPTIONS is not set

#
# Loadable module support
#
CONFIG_MODULES=3Dy
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=3Dy

#
# Platform support
#
CONFIG_PPC=3Dy
CONFIG_PPC32=3Dy
CONFIG_6xx=3Dy
# CONFIG_40x is not set
# CONFIG_440 is not set
# CONFIG_POWER3 is not set
# CONFIG_8xx is not set
# CONFIG_8260 is not set
CONFIG_PPC_STD_MMU=3Dy
# CONFIG_EMBEDDED_OOM_KILLER is not set
# CONFIG_ALL_PPC is not set
# CONFIG_APUS is not set
# CONFIG_WILLOW is not set
# CONFIG_CPCI690 is not set
# CONFIG_PCORE is not set
# CONFIG_POWERPMC250 is not set
# CONFIG_PPMC260 is not set
# CONFIG_EV64260 is not set
# CONFIG_SPRUCE is not set
# CONFIG_MENF1 is not set
# CONFIG_PUMA_A is not set
# CONFIG_HXEB100 is not set
# CONFIG_LOPEC is not set
# CONFIG_MCPN765 is not set
# CONFIG_MVME5100 is not set
# CONFIG_PPLUS is not set
# CONFIG_PRPMC750 is not set
# CONFIG_PRPMC800 is not set
CONFIG_SANDPOINT=3Dy
# CONFIG_POWERK2 is not set
# CONFIG_ADIR is not set
# CONFIG_K2 is not set
# CONFIG_PAL4 is not set
# CONFIG_GEMINI is not set
# CONFIG_ZX4500 is not set
# CONFIG_MPC10X_STORE_GATHERING is not set
# CONFIG_SANDPOINT_X3 is not set
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
# CONFIG_IKCONFIG is not set
# CONFIG_ALTIVEC is not set
# CONFIG_TAU is not set
CONFIG_PPC_ISATIMER=3Dy

#
# General setup
#
CONFIG_MAX_POSIX_TIMERS=3D3000
# CONFIG_HIGH_RES_TIMERS is not set
# CONFIG_HIGHMEM is not set
# CONFIG_ILATENCY is not set
# CONFIG_ISA is not set
# CONFIG_EISA is not set
# CONFIG_SBUS is not set
# CONFIG_MCA is not set
CONFIG_PCI=3Dy
CONFIG_NET=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_SYSVIPC_SEMMNI=3D128
CONFIG_SYSVIPC_SEMMSL=3D250
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_MAX_USER_RT_PRIO=3D100
CONFIG_MAX_RT_PRIO=3D0
CONFIG_KCORE_ELF=3Dy
CONFIG_BINFMT_ELF=3Dy
CONFIG_MULTITHREADED_CORES=3Dy
CONFIG_KERNEL_ELF=3Dy
# CONFIG_BINFMT_MISC is not set
# CONFIG_PCI_NAMES is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set
CONFIG_PPC_RTC=3Dm
# CONFIG_CMDLINE_BOOL is not set

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=3Dy
CONFIG_MTD_DEBUG=3Dy
CONFIG_MTD_DEBUG_VERBOSE=3D2
CONFIG_MTD_PARTITIONS=3Dy
CONFIG_MTD_CONCAT=3Dy
CONFIG_MTD_REDBOOT_PARTS=3Dy
CONFIG_MTD_CMDLINE_PARTS=3Dy

#
# User Modules And Translation Layers
#
# CONFIG_MTD_CHAR is not set
# CONFIG_MTD_BLOCK is not set
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=3Dy
CONFIG_MTD_JEDECPROBE=3Dy
CONFIG_MTD_GEN_PROBE=3Dy
CONFIG_MTD_CFI_ADV_OPTIONS=3Dy
# CONFIG_MTD_CFI_NOSWAP is not set
CONFIG_MTD_CFI_BE_BYTE_SWAP=3Dy
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=3Dy
# CONFIG_MTD_CFI_B1 is not set
CONFIG_MTD_CFI_B2=3Dy
# CONFIG_MTD_CFI_B4 is not set
# CONFIG_MTD_CFI_B8 is not set
# CONFIG_MTD_CFI_I1 is not set
# CONFIG_MTD_CFI_I2 is not set
CONFIG_MTD_CFI_I4=3Dy
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=3Dy
# CONFIG_MTD_CFI_STAA is not set
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# CONFIG_MTD_OBSOLETE_CHIPS is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=3Dy
# CONFIG_MTD_MOT_MVP is not set
# CONFIG_MTD_POWERPLUS is not set
# CONFIG_MTD_K2 is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLKMTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOC2001PLUS is not set
# CONFIG_MTD_DOCPROBE is not set

#
# Serial Flash Device Drivers
#
# CONFIG_MTD_SFLASH is not set

#
# NAND Flash Device Drivers
#
# CONFIG_MTD_NAND is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_SIZE=3D8192
CONFIG_BLK_DEV_INITRD=3Dy
# CONFIG_BLK_STATS is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Cryptography support (CryptoAPI)
#
# CONFIG_CRYPTO is not set

#
# 128 bit blocksize
#

#
# 64 bit blocksize
#

#
# Deprecated
#

#
# Networking options
#
CONFIG_PACKET=3Dy
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
# CONFIG_FILTER is not set
# CONFIG_NET_NEIGH_DEBUG is not set
# CONFIG_NET_RESTRICTED_REUSE is not set
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
# CONFIG_IPSEC is not set
CONFIG_IP_MULTICAST=3Dy
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=3Dy
# CONFIG_IP_PNP_DHCP is not set
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_IPV4_IPSEC_TUNNEL=3Dy

#
#   IP: Netfilter Configuration
#
# CONFIG_IP_NF_CONNTRACK is not set
# CONFIG_IP_NF_QUEUE is not set
# CONFIG_IP_NF_IPTABLES is not set
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_IPV6=3Dm
# CONFIG_IPV6_DEBUG is not set
# CONFIG_IPV6_IM is not set
# CONFIG_IPV6_ZONE is not set
# CONFIG_IPV6_DROP_FAKE_V4MAPPED is not set
# CONFIG_IPV6_6TO4_NEXTHOP is not set
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_IPV6_ANYCAST is not set
# CONFIG_IPV6_ISATAP is not set
# CONFIG_IPV6_PREFIXLIST is not set
# CONFIG_IPV6_SUBTREES is not set
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_MLD6_ALL_DONE is not set
# CONFIG_IPV6_NODEINFO is not set

#
#   IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
# CONFIG_IP6_NF_IPTABLES is not set
CONFIG_IPV6_IPSEC_TUNNEL=3Dy
# CONFIG_IPV6_IPV6_TUNNEL is not set
# CONFIG_IPV6_MOBILITY is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
#
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
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
# Fusion MPT device support
#
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
# CONFIG_NETDEVICES is not set

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
# CONFIG_VGA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Input core support
#
CONFIG_INPUT=3Dm
CONFIG_INPUT_KEYBDEV=3Dm
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=3Dm

#
# Macintosh device drivers
#

#
# Character devices
#
# CONFIG_VT is not set
CONFIG_SERIAL=3Dy
CONFIG_SERIAL_CONSOLE=3Dy
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_UNIX98_PTYS is not set
# CONFIG_HVC_CONSOLE is not set
# CONFIG_IXP2000_SLAVE is not set

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
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_INPUT_SERIO is not set

#
# Joysticks
#
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_LINUX_LED is not set
# CONFIG_AMD_PM768 is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
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
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
CONFIG_AUTOFS_FS=3Dm
CONFIG_AUTOFS4_FS=3Dm
# CONFIG_REISERFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=3Dm
CONFIG_JBD=3Dm
# CONFIG_JBD_DEBUG is not set
# CONFIG_FAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
CONFIG_JFFS2_FS=3Dy
CONFIG_JFFS2_FS_DEBUG=3D2
CONFIG_JFFS2_FS_NAND=3Dy
# CONFIG_CRAMFS is not set
# CONFIG_POSIX_MQUEUE_FS is not set
# CONFIG_TMPFS is not set
CONFIG_RAMFS=3Dy
# CONFIG_ISO9660_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=3Dy
# CONFIG_DEVFS_FS is not set
# CONFIG_QNX4FS_FS is not set
CONFIG_ROMFS_FS=3Dm
CONFIG_EXT2_FS=3Dy
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_XFS_FS is not set
# Network File Systems
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_ZISOFS_FS is not set
# Partition Types

# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy
# CONFIG_SMB_NLS is not set
# CONFIG_NLS is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel tracing
#
# CONFIG_TRACE is not set

#
# Library routines
#
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dy

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_SERIAL_TEXT_DEBUG is not set


################################################################

Can any happy soul let me know  :--

1)How to mount jffs2 on this flash and also to test mtd->read/write routine=
s
?

2) Is it ok not to see mtd0.. partions in /dev directory .

3 ) Where do I register the mtd partitions to get them noticed here ??


Thanks
Arun

------=_Part_58153_24972525.1153493788920
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi ,<br>Can anyone help me in this naive problem ?<br><br>I am using k 2.4.=
x based on ppc8245 based .I have a 8MB flash mapped to adress -0xff800000 .=
with 4 interleaved AMD flash devices each of size 2Mib .<br>Inte<br><br>
The problem I am facing are two :<br>I am not sure whether my flash read/wr=
ite routines are working properly .(cfi_cmdset_0002.c routines )<br><br>I a=
m able to detect my flash and do MTD partions too on the flash .But I canno=
t see that in my=20
<br>dev directory .I mean I should see something like /dev/mtd0 ...etc .<br=
><br>As I want to mount JFFS2 and I am not sure of whether i can mount any =
Filesystem without seeing it in /dev directory .<br><br>Is there way wherei=
n I can invoke mtd-&gt;write/mtd/-&gt;
<br>read routines so that I can be sure that my CFI driver is working fine =
?<br clear=3D"all">these routines are mapped to amdstd_read/write routines =
in cfi_cmdset_0002 routine .<br>&nbsp;mtd-&gt;read =3D cfi_amdstd_read;<br>=
&nbsp;mtd-&gt;write =3D cfi_amdstd_write;
<br><br>Here is my dump<br><br>############################################=
####################<br><br>LSP Revision 1<br>Starting kswapd<br>Disabling =
the Out Of Memory Killer<br>JFFS2 version 2.1. (C) 2001, 2002 Red Hat, Inc.=
, designed by Axis Communications
<br>&nbsp;AB.<br>Serial driver version 5.05c (2001-07-08) with MANY_PORTS S=
HARE_IRQ SERIAL_PCI en<br>abled<br>ttyS00 at 0xfcf04500 (irq =3D 13) is a S=
T16650<br>RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 block=
size
<br><br>&nbsp;AMD_FLASH_INIT called&nbsp; *aks *<br>physmap flash device: 8=
00000 at ff800000 virtual address Number of erase regions<br>: 4<br>Primary=
 Vendor Command Set: 0002 (AMD/Fujitsu Standard)<br>Primary Algorithm Table=
 at 0040
<br>Alternative Vendor Command Set: 0000 (None)<br>No Alternate Algorithm T=
able<br>Vcc Minimum: 2.7 V<br>Vcc Maximum: 3.6 V<br>No Vpp line<br>Typical =
byte/word write timeout: 128 =B5s<br>Maximum byte/word write timeout: 256 =
=B5s
<br>Full buffer write not supported<br>Typical block erase timeout: 1024 ms=
<br>Maximum block erase timeout: 16384 ms<br>Chip erase not supported<br>De=
vice size: 0x200000 bytes (2 MiB)<br>Flash Device Interface description: 0x=
0002
<br>&nbsp; - supports x8 and x16 via BYTE# with asynchronous interface<br>M=
ax. bytes in buffer write: 0x1<br>Number of Erase Block Regions: 4<br>&nbsp=
; Erase Region #0: BlockSize 0x4000 bytes, 1 blocks<br>&nbsp; Erase Region =
#1: BlockSize 0x2000 bytes, 2 blocks
<br>&nbsp; Erase Region #2: BlockSize 0x8000 bytes, 1 blocks<br>&nbsp; Eras=
e Region #3: BlockSize 0x10000 bytes, 31 blocks<br>&nbsp;Amd/Fujitsu Extend=
ed Query Table v1.3 at 0x0040<br>number of CFI chips: 4<br><br>&nbsp;in amd=
std_setup 0:<br>
cfi_cmdset_0002: Disabling fast programming due to code brokenness. <br><br=
>&nbsp;in MTD Partitioning &lt;5&gt;No RedBoot partition table detected in =
phys_mapped_flash<br><br>Using physmap partition definition<br>Creating 3 M=
TD partitions on &quot;phys_mapped_flash&quot;:
<br>0x00000000-0x00040000 : &quot;foo-ets0&quot;<br>mtd: Giving out device =
0 to foo-ets0<br>0x00040000-0x001e0000 : &quot;foo-ets1&quot;<br>mtd: parti=
tion &quot;agere-ets1&quot; doesn't end on an erase block -- force read-onl=
y
<br>mtd: Giving out device 1 to foo-ets1<br>0x001e0000-0x00200000 : &quot;f=
oo-ets2&quot;<br>mtd: partition &quot;foo-ets2&quot; doesn't start on an er=
ase block boundary -- force re<br>ad-only<br>mtd: Giving out device 2 to fo=
o-ets2
<br>NET4: Linux TCP/IP 1.0 for NET4.0<br>IP Protocols: ICMP, UDP, TCP, IGMP=
<br>IP: routing cache hash table of 512 buckets, 4Kbytes<br>TCP: Hash table=
s configured (established 4096 bind 8192)<br>IP-Config: No network devices =
available.
<br>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.<br>/dev/console map=
ped to mkdev 5: minor: 1<br>RAMDISK: Compressed image found at block 0<br>F=
reeing initrd memory: 1247k freed<br>VFS: Mounted root (ext2 filesystem) re=
adonly.
<br>Freeing unused kernel memory: 76k init<br>calling sbin/init<br>init sta=
rted:&nbsp; BusyBox v1.2.0 (2006.07.12-05:25+0000) multi-call binary<br>ini=
t started:&nbsp; BusyBox v1.2.0 (2006.07.12-05:25+0000) multi-call binary<b=
r>Starting pid 8, console /dev/ttyS0: '/bin/ash'
<br><br><br><br>/ $ cd /dev<br>/dev $ ls<br>console&nbsp; loop2&nbsp;&nbsp;=
&nbsp; loop7&nbsp;&nbsp;&nbsp; ram1&nbsp;&nbsp;&nbsp;&nbsp; ram14&nbsp;&nbs=
p;&nbsp; ram4&nbsp;&nbsp;&nbsp;&nbsp; ram9&nbsp;&nbsp;&nbsp;&nbsp; urandom<=
br>full&nbsp;&nbsp;&nbsp;&nbsp; loop3&nbsp;&nbsp;&nbsp; mem&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ram10&nbsp;&nbsp;&nbsp; ram15&nbsp;&nbsp;&nbsp; ram5&nbsp;&n=
bsp;&nbsp;&nbsp; random&nbsp;&nbsp; zero<br>kmem&nbsp;&nbsp;&nbsp;&nbsp; lo=
op4&nbsp;&nbsp;&nbsp; null&nbsp;&nbsp;&nbsp;&nbsp; ram11&nbsp;&nbsp;&nbsp; =
ram16&nbsp;&nbsp;&nbsp; ram6&nbsp;&nbsp;&nbsp;&nbsp; tty
<br>loop0&nbsp;&nbsp;&nbsp; loop5&nbsp;&nbsp;&nbsp; port&nbsp;&nbsp;&nbsp;&=
nbsp; ram12&nbsp;&nbsp;&nbsp; ram2&nbsp;&nbsp;&nbsp;&nbsp; ram7&nbsp;&nbsp;=
&nbsp;&nbsp; tty0<br>loop1&nbsp;&nbsp;&nbsp; loop6&nbsp;&nbsp;&nbsp; ram0&n=
bsp;&nbsp;&nbsp;&nbsp; ram13&nbsp;&nbsp;&nbsp; ram3&nbsp;&nbsp;&nbsp;&nbsp;=
 ram8&nbsp;&nbsp;&nbsp;&nbsp; ttyS0<br><br><br><br><br>####################=
############################################<br><br><br>
#<br># Automatically generated make config: don't edit<br>#<br># CONFIG_UID=
16 is not set<br># CONFIG_RWSEM_GENERIC_SPINLOCK is not set<br>CONFIG_RWSEM=
_XCHGADD_ALGORITHM=3Dy<br>CONFIG_HAVE_DEC_LOCK=3Dy<br>CONFIG_GENERIC_ISA_DM=
A=3Dy
<br><br>#<br># Code maturity level options<br>#<br>CONFIG_EXPERIMENTAL=3Dy<=
br># CONFIG_ADVANCED_OPTIONS is not set<br><br>#<br># Loadable module suppo=
rt<br>#<br>CONFIG_MODULES=3Dy<br># CONFIG_MODVERSIONS is not set<br>CONFIG_=
KMOD=3Dy
<br><br>#<br># Platform support<br>#<br>CONFIG_PPC=3Dy<br>CONFIG_PPC32=3Dy<=
br>CONFIG_6xx=3Dy<br># CONFIG_40x is not set<br># CONFIG_440 is not set<br>=
# CONFIG_POWER3 is not set<br># CONFIG_8xx is not set<br># CONFIG_8260 is n=
ot set
<br>CONFIG_PPC_STD_MMU=3Dy<br># CONFIG_EMBEDDED_OOM_KILLER is not set<br># =
CONFIG_ALL_PPC is not set<br># CONFIG_APUS is not set<br># CONFIG_WILLOW is=
 not set<br># CONFIG_CPCI690 is not set<br># CONFIG_PCORE is not set<br># C=
ONFIG_POWERPMC250 is not set
<br># CONFIG_PPMC260 is not set<br># CONFIG_EV64260 is not set<br># CONFIG_=
SPRUCE is not set<br># CONFIG_MENF1 is not set<br># CONFIG_PUMA_A is not se=
t<br># CONFIG_HXEB100 is not set<br># CONFIG_LOPEC is not set<br># CONFIG_M=
CPN765 is not set
<br># CONFIG_MVME5100 is not set<br># CONFIG_PPLUS is not set<br># CONFIG_P=
RPMC750 is not set<br># CONFIG_PRPMC800 is not set<br>CONFIG_SANDPOINT=3Dy<=
br># CONFIG_POWERK2 is not set<br># CONFIG_ADIR is not set<br># CONFIG_K2 i=
s not set
<br># CONFIG_PAL4 is not set<br># CONFIG_GEMINI is not set<br># CONFIG_ZX45=
00 is not set<br># CONFIG_MPC10X_STORE_GATHERING is not set<br># CONFIG_SAN=
DPOINT_X3 is not set<br># CONFIG_SMP is not set<br># CONFIG_PREEMPT is not =
set
<br># CONFIG_IKCONFIG is not set<br># CONFIG_ALTIVEC is not set<br># CONFIG=
_TAU is not set<br>CONFIG_PPC_ISATIMER=3Dy<br><br>#<br># General setup<br>#=
<br>CONFIG_MAX_POSIX_TIMERS=3D3000<br># CONFIG_HIGH_RES_TIMERS is not set<b=
r>
# CONFIG_HIGHMEM is not set<br># CONFIG_ILATENCY is not set<br># CONFIG_ISA=
 is not set<br># CONFIG_EISA is not set<br># CONFIG_SBUS is not set<br># CO=
NFIG_MCA is not set<br>CONFIG_PCI=3Dy<br>CONFIG_NET=3Dy<br>CONFIG_SYSCTL=3D=
y<br>
CONFIG_SYSVIPC=3Dy<br>CONFIG_SYSVIPC_SEMMNI=3D128<br>CONFIG_SYSVIPC_SEMMSL=
=3D250<br># CONFIG_BSD_PROCESS_ACCT is not set<br>CONFIG_MAX_USER_RT_PRIO=
=3D100<br>CONFIG_MAX_RT_PRIO=3D0<br>CONFIG_KCORE_ELF=3Dy<br>CONFIG_BINFMT_E=
LF=3Dy<br>CONFIG_MULTITHREADED_CORES=3Dy
<br>CONFIG_KERNEL_ELF=3Dy<br># CONFIG_BINFMT_MISC is not set<br># CONFIG_PC=
I_NAMES is not set<br># CONFIG_HOTPLUG is not set<br># CONFIG_PCMCIA is not=
 set<br><br>#<br># Parallel port support<br>#<br># CONFIG_PARPORT is not se=
t
<br>CONFIG_PPC_RTC=3Dm<br># CONFIG_CMDLINE_BOOL is not set<br><br>#<br># Me=
mory Technology Devices (MTD)<br>#<br>CONFIG_MTD=3Dy<br>CONFIG_MTD_DEBUG=3D=
y<br>CONFIG_MTD_DEBUG_VERBOSE=3D2<br>CONFIG_MTD_PARTITIONS=3Dy<br>CONFIG_MT=
D_CONCAT=3Dy
<br>CONFIG_MTD_REDBOOT_PARTS=3Dy<br>CONFIG_MTD_CMDLINE_PARTS=3Dy<br><br>#<b=
r># User Modules And Translation Layers<br>#<br># CONFIG_MTD_CHAR is not se=
t<br># CONFIG_MTD_BLOCK is not set<br># CONFIG_MTD_BLOCK_RO is not set<br>#=
 CONFIG_FTL is not set
<br># CONFIG_NFTL is not set<br># CONFIG_INFTL is not set<br><br>#<br># RAM=
/ROM/Flash chip drivers<br>#<br>CONFIG_MTD_CFI=3Dy<br>CONFIG_MTD_JEDECPROBE=
=3Dy<br>CONFIG_MTD_GEN_PROBE=3Dy<br>CONFIG_MTD_CFI_ADV_OPTIONS=3Dy<br># CON=
FIG_MTD_CFI_NOSWAP is not set
<br>CONFIG_MTD_CFI_BE_BYTE_SWAP=3Dy<br># CONFIG_MTD_CFI_LE_BYTE_SWAP is not=
 set<br>CONFIG_MTD_CFI_GEOMETRY=3Dy<br># CONFIG_MTD_CFI_B1 is not set<br>CO=
NFIG_MTD_CFI_B2=3Dy<br># CONFIG_MTD_CFI_B4 is not set<br># CONFIG_MTD_CFI_B=
8 is not set
<br># CONFIG_MTD_CFI_I1 is not set<br># CONFIG_MTD_CFI_I2 is not set<br>CON=
FIG_MTD_CFI_I4=3Dy<br># CONFIG_MTD_CFI_I8 is not set<br># CONFIG_MTD_CFI_IN=
TELEXT is not set<br>CONFIG_MTD_CFI_AMDSTD=3Dy<br># CONFIG_MTD_CFI_STAA is =
not set
<br># CONFIG_MTD_RAM is not set<br># CONFIG_MTD_ROM is not set<br># CONFIG_=
MTD_ABSENT is not set<br># CONFIG_MTD_OBSOLETE_CHIPS is not set<br><br>#<br=
># Mapping drivers for chip access<br>#<br># CONFIG_MTD_COMPLEX_MAPPINGS is=
 not set
<br>CONFIG_MTD_PHYSMAP=3Dy<br># CONFIG_MTD_MOT_MVP is not set<br># CONFIG_M=
TD_POWERPLUS is not set<br># CONFIG_MTD_K2 is not set<br><br>#<br># Self-co=
ntained MTD device drivers<br>#<br># CONFIG_MTD_PMC551 is not set<br># CONF=
IG_MTD_SLRAM is not set
<br># CONFIG_MTD_MTDRAM is not set<br># CONFIG_MTD_BLKMTD is not set<br><br=
>#<br># Disk-On-Chip Device Drivers<br>#<br># CONFIG_MTD_DOC2000 is not set=
<br># CONFIG_MTD_DOC2001 is not set<br># CONFIG_MTD_DOC2001PLUS is not set
<br># CONFIG_MTD_DOCPROBE is not set<br><br>#<br># Serial Flash Device Driv=
ers<br>#<br># CONFIG_MTD_SFLASH is not set<br><br>#<br># NAND Flash Device =
Drivers<br>#<br># CONFIG_MTD_NAND is not set<br><br>#<br># Plug and Play co=
nfiguration
<br>#<br># CONFIG_PNP is not set<br><br>#<br># Block devices<br>#<br># CONF=
IG_BLK_DEV_FD is not set<br># CONFIG_BLK_CPQ_DA is not set<br># CONFIG_BLK_=
CPQ_CISS_DA is not set<br># CONFIG_BLK_DEV_DAC960 is not set<br># CONFIG_BL=
K_DEV_UMEM is not set
<br># CONFIG_BLK_DEV_LOOP is not set<br># CONFIG_BLK_DEV_NBD is not set<br>=
CONFIG_BLK_DEV_RAM=3Dy<br>CONFIG_BLK_DEV_RAM_SIZE=3D8192<br>CONFIG_BLK_DEV_=
INITRD=3Dy<br># CONFIG_BLK_STATS is not set<br><br>#<br># Multi-device supp=
ort (RAID and LVM)
<br>#<br># CONFIG_MD is not set<br><br>#<br># Cryptography support (CryptoA=
PI)<br>#<br># CONFIG_CRYPTO is not set<br><br>#<br># 128 bit blocksize<br>#=
<br><br>#<br># 64 bit blocksize<br>#<br><br>#<br># Deprecated<br>#<br><br>
#<br># Networking options<br>#<br>CONFIG_PACKET=3Dy<br># CONFIG_PACKET_MMAP=
 is not set<br># CONFIG_NETLINK_DEV is not set<br>CONFIG_NETFILTER=3Dy<br>#=
 CONFIG_NETFILTER_DEBUG is not set<br># CONFIG_FILTER is not set<br># CONFI=
G_NET_NEIGH_DEBUG is not set
<br># CONFIG_NET_RESTRICTED_REUSE is not set<br>CONFIG_UNIX=3Dy<br>CONFIG_I=
NET=3Dy<br># CONFIG_IPSEC is not set<br>CONFIG_IP_MULTICAST=3Dy<br># CONFIG=
_IP_ADVANCED_ROUTER is not set<br>CONFIG_IP_PNP=3Dy<br># CONFIG_IP_PNP_DHCP=
 is not set
<br># CONFIG_IP_PNP_BOOTP is not set<br># CONFIG_IP_PNP_RARP is not set<br>=
# CONFIG_NET_IPIP is not set<br># CONFIG_NET_IPGRE is not set<br># CONFIG_I=
P_MROUTE is not set<br># CONFIG_ARPD is not set<br># CONFIG_INET_ECN is not=
 set
<br># CONFIG_SYN_COOKIES is not set<br>CONFIG_IPV4_IPSEC_TUNNEL=3Dy<br><br>=
#<br>#&nbsp;&nbsp; IP: Netfilter Configuration<br>#<br># CONFIG_IP_NF_CONNT=
RACK is not set<br># CONFIG_IP_NF_QUEUE is not set<br># CONFIG_IP_NF_IPTABL=
ES is not set
<br># CONFIG_IP_NF_ARPTABLES is not set<br># CONFIG_IP_NF_COMPAT_IPCHAINS i=
s not set<br># CONFIG_IP_NF_COMPAT_IPFWADM is not set<br>CONFIG_IPV6=3Dm<br=
># CONFIG_IPV6_DEBUG is not set<br># CONFIG_IPV6_IM is not set<br># CONFIG_=
IPV6_ZONE is not set
<br># CONFIG_IPV6_DROP_FAKE_V4MAPPED is not set<br># CONFIG_IPV6_6TO4_NEXTH=
OP is not set<br># CONFIG_IPV6_PRIVACY is not set<br># CONFIG_IPV6_ANYCAST =
is not set<br># CONFIG_IPV6_ISATAP is not set<br># CONFIG_IPV6_PREFIXLIST i=
s not set
<br># CONFIG_IPV6_SUBTREES is not set<br># CONFIG_IPV6_ROUTER_PREF is not s=
et<br># CONFIG_IPV6_MLD6_ALL_DONE is not set<br># CONFIG_IPV6_NODEINFO is n=
ot set<br><br>#<br>#&nbsp;&nbsp; IPv6: Netfilter Configuration<br>#<br># CO=
NFIG_IP6_NF_QUEUE is not set
<br># CONFIG_IP6_NF_IPTABLES is not set<br>CONFIG_IPV6_IPSEC_TUNNEL=3Dy<br>=
# CONFIG_IPV6_IPV6_TUNNEL is not set<br># CONFIG_IPV6_MOBILITY is not set<b=
r># CONFIG_KHTTPD is not set<br># CONFIG_ATM is not set<br># CONFIG_VLAN_80=
21Q is not set
<br><br>#<br>#&nbsp; <br>#<br># CONFIG_IPX is not set<br># CONFIG_ATALK is =
not set<br><br>#<br># Appletalk devices<br>#<br># CONFIG_DECNET is not set<=
br># CONFIG_BRIDGE is not set<br># CONFIG_X25 is not set<br># CONFIG_LAPB i=
s not set
<br># CONFIG_LLC is not set<br># CONFIG_NET_DIVERT is not set<br># CONFIG_E=
CONET is not set<br># CONFIG_WAN_ROUTER is not set<br># CONFIG_NET_FASTROUT=
E is not set<br># CONFIG_NET_HW_FLOWCONTROL is not set<br><br>#<br># QoS an=
d/or fair queueing
<br>#<br># CONFIG_NET_SCHED is not set<br><br>#<br># Network testing<br>#<b=
r># CONFIG_NET_PKTGEN is not set<br><br>#<br># ATA/IDE/MFM/RLL support<br>#=
<br># CONFIG_IDE is not set<br># CONFIG_BLK_DEV_IDE_MODES is not set<br>
# CONFIG_BLK_DEV_HD is not set<br><br>#<br># SCSI support<br>#<br># CONFIG_=
SCSI is not set<br><br>#<br># Fusion MPT device support<br>#<br># CONFIG_FU=
SION_BOOT is not set<br># CONFIG_FUSION_ISENSE is not set<br># CONFIG_FUSIO=
N_CTL is not set
<br># CONFIG_FUSION_LAN is not set<br><br>#<br># IEEE 1394 (FireWire) suppo=
rt (EXPERIMENTAL)<br>#<br># CONFIG_IEEE1394 is not set<br><br>#<br># I2O de=
vice support<br>#<br># CONFIG_I2O is not set<br><br>#<br># Network device s=
upport
<br>#<br># CONFIG_NETDEVICES is not set<br><br>#<br># Amateur Radio support=
<br>#<br># CONFIG_HAMRADIO is not set<br><br>#<br># IrDA (infrared) support=
<br>#<br># CONFIG_IRDA is not set<br><br>#<br># ISDN subsystem<br>#<br>
# CONFIG_ISDN is not set<br><br>#<br># Old CD-ROM drivers (not SCSI, not ID=
E)<br>#<br># CONFIG_CD_NO_IDESCSI is not set<br><br>#<br># Console drivers<=
br>#<br># CONFIG_VGA_CONSOLE is not set<br><br>#<br># Frame-buffer support
<br>#<br># CONFIG_FB is not set<br><br>#<br># Input core support<br>#<br>CO=
NFIG_INPUT=3Dm<br>CONFIG_INPUT_KEYBDEV=3Dm<br># CONFIG_INPUT_MOUSEDEV is no=
t set<br># CONFIG_INPUT_JOYDEV is not set<br>CONFIG_INPUT_EVDEV=3Dm<br><br>=
#<br>
# Macintosh device drivers<br>#<br><br>#<br># Character devices<br>#<br># C=
ONFIG_VT is not set<br>CONFIG_SERIAL=3Dy<br>CONFIG_SERIAL_CONSOLE=3Dy<br># =
CONFIG_SERIAL_EXTENDED is not set<br># CONFIG_SERIAL_NONSTANDARD is not set
<br># CONFIG_UNIX98_PTYS is not set<br># CONFIG_HVC_CONSOLE is not set<br>#=
 CONFIG_IXP2000_SLAVE is not set<br><br>#<br># I2C support<br>#<br># CONFIG=
_I2C is not set<br><br>#<br># Mice<br>#<br># CONFIG_BUSMOUSE is not set
<br># CONFIG_MOUSE is not set<br><br>#<br># Joysticks<br>#<br># CONFIG_INPU=
T_GAMEPORT is not set<br># CONFIG_INPUT_SERIO is not set<br><br>#<br># Joys=
ticks<br>#<br># CONFIG_QIC02_TAPE is not set<br><br>#<br># Watchdog Cards
<br>#<br># CONFIG_WATCHDOG is not set<br># CONFIG_LINUX_LED is not set<br>#=
 CONFIG_AMD_PM768 is not set<br># CONFIG_NVRAM is not set<br># CONFIG_RTC i=
s not set<br># CONFIG_DTLK is not set<br># CONFIG_R3964 is not set<br># CON=
FIG_APPLICOM is not set
<br><br>#<br># Ftape, the floppy tape device driver<br>#<br># CONFIG_FTAPE =
is not set<br># CONFIG_AGP is not set<br># CONFIG_DRM is not set<br><br>#<b=
r># Multimedia devices<br>#<br># CONFIG_VIDEO_DEV is not set<br><br>#<br>
# File systems<br>#<br># CONFIG_QUOTA is not set<br>CONFIG_AUTOFS_FS=3Dm<br=
>CONFIG_AUTOFS4_FS=3Dm<br># CONFIG_REISERFS_FS is not set<br># CONFIG_ADFS_=
FS is not set<br># CONFIG_AFFS_FS is not set<br># CONFIG_HFS_FS is not set<=
br>
# CONFIG_BEFS_FS is not set<br># CONFIG_BFS_FS is not set<br>CONFIG_EXT3_FS=
=3Dm<br>CONFIG_JBD=3Dm<br># CONFIG_JBD_DEBUG is not set<br># CONFIG_FAT_FS =
is not set<br># CONFIG_EFS_FS is not set<br># CONFIG_JFFS_FS is not set<br>
CONFIG_JFFS2_FS=3Dy<br>CONFIG_JFFS2_FS_DEBUG=3D2<br>CONFIG_JFFS2_FS_NAND=3D=
y<br># CONFIG_CRAMFS is not set<br># CONFIG_POSIX_MQUEUE_FS is not set<br>#=
 CONFIG_TMPFS is not set<br>CONFIG_RAMFS=3Dy<br># CONFIG_ISO9660_FS is not =
set<br>
# CONFIG_JFS_FS is not set<br># CONFIG_MINIX_FS is not set<br># CONFIG_VXFS=
_FS is not set<br># CONFIG_NTFS_FS is not set<br># CONFIG_HPFS_FS is not se=
t<br>CONFIG_PROC_FS=3Dy<br># CONFIG_DEVFS_FS is not set<br># CONFIG_QNX4FS_=
FS is not set
<br>CONFIG_ROMFS_FS=3Dm<br>CONFIG_EXT2_FS=3Dy<br># CONFIG_SYSV_FS is not se=
t<br># CONFIG_UDF_FS is not set<br># CONFIG_UFS_FS is not set<br># CONFIG_X=
FS_FS is not set<br># Network File Systems<br># CONFIG_CODA_FS is not set<b=
r>
# CONFIG_INTERMEZZO_FS is not set<br># CONFIG_NFS_FS is not set<br># CONFIG=
_NFSD is not set<br># CONFIG_SUNRPC is not set<br># CONFIG_LOCKD is not set=
<br># CONFIG_SMB_FS is not set<br># CONFIG_NCP_FS is not set<br># CONFIG_ZI=
SOFS_FS is not set
<br># Partition Types<br><br># CONFIG_PARTITION_ADVANCED is not set<br>CONF=
IG_MSDOS_PARTITION=3Dy<br># CONFIG_SMB_NLS is not set<br># CONFIG_NLS is no=
t set<br><br>#<br># Sound<br>#<br># CONFIG_SOUND is not set<br><br>#<br># U=
SB support
<br>#<br># CONFIG_USB is not set<br><br>#<br># Bluetooth support<br>#<br># =
CONFIG_BLUEZ is not set<br><br>#<br># Kernel tracing<br>#<br># CONFIG_TRACE=
 is not set<br><br>#<br># Library routines<br>#<br>CONFIG_ZLIB_INFLATE=3Dy
<br>CONFIG_ZLIB_DEFLATE=3Dy<br><br>#<br># Kernel hacking<br>#<br># CONFIG_D=
EBUG_KERNEL is not set<br># CONFIG_SERIAL_TEXT_DEBUG is not set<br><br><br>=
################################################################<br><br>Can=
 any happy soul let me know&nbsp; :--=20
<br><br>1)How to mount jffs2 on this flash and also to test mtd-&gt;read/wr=
ite routines ?<br><br>2) Is it ok not to see mtd0.. partions in /dev direct=
ory .<br><br>3 ) Where do I register the mtd partitions to get them noticed=
 here ??
<br><br><br>Thanks<br>Arun<br><br>

------=_Part_58153_24972525.1153493788920--
