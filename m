Return-Path: <Brian.Madzarevic@uav.com>
Received: from asimail1.rb.uav.com (m174092.sd.gat.com [141.248.174.92])
	by ozlabs.org (Postfix) with ESMTP id C821667A75
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2005 05:20:18 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 8 Mar 2005 10:11:31 -0800
Message-ID: <A79EE6739F2C7348A857541FB5CD92D6011566F6@asimail1.rb.uav.com>
From: "Brian V. Madzarevic" <Brian.Madzarevic@uav.com>
To: <linuxppc-dev@ozlabs.org>
Subject: 2.6.11 prep image on radstone ppc4a not booting
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am trying to boot a Linux 2.6.11 prep image on a Radstone PPC4A.
PPC4A Specifications http://www.radstone.com/rtcd/pdfs/ppc4a.pdf

I was trying to get an nfs filesystem mounted, but after the bios
retrieves the kernel using tftp, no more packets are even sent out.  I
don't know if there is a problem with the network driver or the PCI bus
or what.

Here is my boot log:

Radstone Technology.
SilverChip PowerPC PReP Boot Firmware

Version: 4.05
Built (Jan 20 2004 10:34:02)

PPC4a-7400 333MHz, 83MHz Bus Rev. 3B Ser. No. 0003815 ID No. 0xd

PCI devices
0  0 ID 0x00021057 Motorola MPC106 PowerPC Chipset, Rev. 4.0
0  1 Fn 0 ID 0x056510ad Winbond W83C553F ISA bridge, Rev. 1.0
0  1 Fn 1 ID 0x010510ad Winbond W83C553F IDE controller, Rev. 0.5
0  2 ID 0x00061000 LSI 53C860 Ultra SCSI/Narrow, Rev. 0.2
0  3 ID 0x00191011 DEC DC21143 PCI/CardBus 10/100 Mbit Ethernet Ctlr,
Rev. 4.1
0  4 ID 0x000010e3 Tundra CA91C042 VMEbus Bridge, Rev. 0.1

2 Mbytes of L2 cache on a 133MHz cache bus
128 Mbytes of SDRAM

Floppy drive 0
Floppy drive 1
SCSI id 0
SCSI id 1
SCSI id 2
SCSI id 3
SCSI id 4
SCSI id 5
SCSI id 6

No keyboard found. Using COM1 for input.
No boot authentication required

Opening File
"multi()net()server(192.168.1.73)clientip(192.168.1.147)brian26.prp"
Loading ...
loaded at:     00800400 00912F4C
relocated to:  00800000 00912B4C
zimage at:     0080A86C 00909B2E
avail ram:     00400000 00800000

Linux/PPC load: console=3DttyS0,9600 console=3Dtty0 panic=3D0 =
root=3D/dev/nfs
nfsroot=3D192.168.1.73:/export/nfsroot
ip=3D192.168.1.147:192.168.1.73::255.255.255.0::eth0
Uncompressing Linux...done.
Now booting the kernel
Total memory =3D 128MB; using 256kB for hash table (at c0240000)
Linux version 2.6.11 (brian@rex) (gcc version 3.4.1) #6 Mon Mar 7
15:50:16 PST 2005
PReP architecture
Built 1 zonelists
Kernel command line: console=3DttyS0,9600 console=3Dtty0 panic=3D0
root=3D/dev/nfs nfsroot=3D192.168.1.73:/export/nfsroot
ip=3D192.168.1.147:192.168.1.73::255.255.255.0::eth0
PID hash table entries: 1024 (order: 10, 16384 bytes)
TODC real-time-clock was stopped. Now starting...
time_init: decrementer frequency =3D 20.833333 MHz
Warning: real time clock seems stuck!
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 127232k available (1512k kernel code, 640k data, 136k init, 0k
highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
NET: Registered protocol family 16
PCI: Probing PCI hardware
Setting PCI interrupts for a "Blackhawk (Powerstack)"
PCI: Cannot allocate resource region 0 of device 0000:00:0b.1
PCI: Cannot allocate resource region 1 of device 0000:00:0b.1
PCI: Cannot allocate resource region 2 of device 0000:00:0b.1
PCI: Cannot allocate resource region 3 of device 0000:00:0b.1
PCI: Cannot allocate resource region 4 of device 0000:00:0b.1
PCI: Cannot allocate resource region 5 of device 0000:00:0b.1
PCI: Cannot allocate resource region 0 of device 0000:00:0c.0
PCI: Cannot allocate resource region 0 of device 0000:00:0d.0
PCI: Cannot allocate resource region 0 of device 0000:00:0e.0
PCI: I/O Region 0000:00:0e.0/0 too large (4096 bytes)
PCI: I/O Region 0000:00:0e.0/0 too large (4096 bytes)
PCI: I/O Region 0000:00:0e.0/0 too large (4096 bytes)
PCI: I/O Region 0000:00:0e.0/0 too large (4096 bytes)
PCI: I/O Region 0000:00:0e.0/0 too large (4096 bytes)
PCI: I/O Region 0000:00:0e.0/0 too large (4096 bytes)
PCI: I/O Region 0000:00:0e.0/0 too large (4096 bytes)
PCI: I/O Region 0000:00:0e.0/0 too large (4096 bytes)
PCI: I/O Region 0000:00:0e.0/0 too large (4096 bytes)
PCI: I/O Region 0000:00:0e.0/0 too large (4096 bytes)
PCI: I/O Region 0000:00:0e.0/0 too large (4096 bytes)
PCI: I/O Region 0000:00:0e.0/0 too large (4096 bytes)
PCI: I/O Region 0000:00:0e.0/0 too large (4096 bytes)
Generic RTC Driver v1.07
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
disabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Linux Tulip driver version 1.1.13 (May 11, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media 10baseT (#0) described by a 21140 non-MII (0)
block.
tulip0:  Index #1 - Media 10base2 (#1) described by a <unknown> (8)
block.
tulip0:  Index #2 - Media 10baseT (#0) described by a 21140 non-MII (0)
block.
tulip0:  Index #3 - Media 10baseT (#0) described by a 21140 non-MII (0)
block.
eth0: Digital DS21143 Tulip rev 65 at 80001080, 00:80:8E:00:5D:5B, IRQ
0.
mice: PS/2 mouse device common for all mice
atkbd.c: keyboard reset failed on isa0060/serio1
atkbd.c: keyboard reset failed on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
IP-Config: Complete:
      device=3Deth0, addr=3D192.168.1.147, mask=3D255.255.255.0,
gw=3D255.255.255.255,
     host=3D192.168.1.147, domain=3D, nis-domain=3D(none),
     bootserver=3D192.168.1.73, rootserver=3D192.168.1.73, rootpath=3D
Looking up port of RPC 100003/2 on 192.168.1.73
portmap: server 192.168.1.73 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.1.73
portmap: server 192.168.1.73 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
NETDEV WATCHDOG: eth0: transmit timed out
eth0: 21140 transmit timed out, status f8678105, SIA 000000c5 ffff0001
fffbff7f 8ff04008, resetting...
eth0: transmit timed out, switching to 100baseTx media.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: 21140 transmit timed out, status f8278517, SIA 000000cb ffff0001
fffbff7f 8ff04008, resetting...
eth0: transmit timed out, switching to 10baseT media.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: 21140 transmit timed out, status f8678117, SIA 000000cb ffff0001
fffbff7f 8ff04008, resetting...
eth0: transmit timed out, switching to 10baseT media.
mount: server 192.168.1.73 not responding, timed out
Root-NFS: Server returned error -5 while mounting /export/nfsroot
VFS: Unable to mount root fs via NFS, trying floppy.
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0)
 <6>NETDEV WATCHDOG: eth0: transmit timed out
eth0: 21140 transmit timed out, status f8278517, SIA 000000cb ffff0001
fffbff7f 8ff04008, resetting...
eth0: transmit timed out, switching to 10baseT media.





Here is my .config file:=20

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.11
# Mon Mar  7 15:44:49 2005
#
CONFIG_MMU=3Dy
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_HAVE_DEC_LOCK=3Dy
CONFIG_PPC=3Dy
CONFIG_PPC32=3Dy
CONFIG_GENERIC_NVRAM=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy
# CONFIG_CLEAN_COMPILE is not set
CONFIG_BROKEN=3Dy
CONFIG_BROKEN_ON_SMP=3Dy

#
# General setup
#
CONFIG_LOCALVERSION=3D""
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_POSIX_MQUEUE=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=3Dy
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=3D14
CONFIG_HOTPLUG=3Dy
CONFIG_KOBJECT_UEVENT=3Dy
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=3Dy
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=3Dy
CONFIG_CC_ALIGN_FUNCTIONS=3D0
CONFIG_CC_ALIGN_LABELS=3D0
CONFIG_CC_ALIGN_LOOPS=3D0
CONFIG_CC_ALIGN_JUMPS=3D0
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_MODULE_SRCVERSION_ALL=3Dy
CONFIG_KMOD=3Dy

#
# Processor
#
CONFIG_6xx=3Dy
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_POWER3 is not set
# CONFIG_POWER4 is not set
# CONFIG_8xx is not set
# CONFIG_E500 is not set
# CONFIG_ALTIVEC is not set
# CONFIG_TAU is not set
# CONFIG_CPU_FREQ is not set
# CONFIG_PPC601_SYNC_FIX is not set
CONFIG_PPC_STD_MMU=3Dy

#
# Platform options
#
CONFIG_PPC_MULTIPLATFORM=3Dy
# CONFIG_APUS is not set
# CONFIG_KATANA is not set
# CONFIG_WILLOW is not set
# CONFIG_CPCI690 is not set
# CONFIG_PCORE is not set
# CONFIG_POWERPMC250 is not set
# CONFIG_CHESTNUT is not set
# CONFIG_SPRUCE is not set
# CONFIG_EV64260 is not set
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
# CONFIG_EST8260 is not set
# CONFIG_SBC82xx is not set
# CONFIG_SBS8260 is not set
# CONFIG_RPX8260 is not set
# CONFIG_TQM8260 is not set
# CONFIG_ADS8272 is not set
# CONFIG_PQ2FADS is not set
# CONFIG_LITE5200 is not set
CONFIG_PPC_CHRP=3Dy
CONFIG_PPC_PMAC=3Dy
CONFIG_PPC_PREP=3Dy
CONFIG_PPC_OF=3Dy
CONFIG_PPCBUG_NVRAM=3Dy
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
# CONFIG_HIGHMEM is not set
CONFIG_BINFMT_ELF=3Dy
# CONFIG_BINFMT_MISC is not set
# CONFIG_PROC_DEVICETREE is not set
CONFIG_PREP_RESIDUAL=3Dy
CONFIG_PROC_PREPRESIDUAL=3Dy
CONFIG_CMDLINE_BOOL=3Dy
CONFIG_CMDLINE=3D"console=3DttyS0,9600 console=3Dtty0 panic=3D0 =
root=3D/dev/nfs
nfsroot=3D192.168.1.73:/export/nfsroot
ip=3D192.168.1.147:192.168.1.73::255.255.255.0::eth0"

#
# Bus options
#
# CONFIG_ISA is not set
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_PCI=3Dy
CONFIG_PCI_DOMAINS=3Dy
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_NAMES is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PC-card bridges
#

#
# Advanced setup
#
# CONFIG_ADVANCED_OPTIONS is not set

#
# Default settings for advanced configuration options are used
#
CONFIG_HIGHMEM_START=3D0xfe000000
CONFIG_LOWMEM_SIZE=3D0x30000000
CONFIG_KERNEL_START=3D0xc0000000
CONFIG_TASK_SIZE=3D0x80000000
CONFIG_BOOT_LOAD=3D0x00800000

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set

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
# CONFIG_MAC_FLOPPY is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=3D16
CONFIG_INITRAMFS_SOURCE=3D""
# CONFIG_LBD is not set
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI=3Dm
CONFIG_SCSI_PROC_FS=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dm
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=3Dy
CONFIG_SCSI_LOGGING=3Dy

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=3Dm
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_SYM53C8XX_2=3Dm
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=3D1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=3D16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=3D64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=3Dm
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_MESH is not set
# CONFIG_SCSI_MAC53C94 is not set

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
# CONFIG_ADB is not set
# CONFIG_ADB_CUDA is not set
# CONFIG_ADB_PMU is not set
# CONFIG_MAC_SERIAL is not set

#
# Networking support
#
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=3Dy
# CONFIG_NET_KEY is not set
CONFIG_INET=3Dy
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=3Dy
CONFIG_IP_PNP_DHCP=3Dy
CONFIG_IP_PNP_BOOTP=3Dy
CONFIG_IP_PNP_RARP=3Dy
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_IP_TCPDIAG=3Dy
# CONFIG_IP_TCPDIAG_IPV6 is not set
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

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=3Dy
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
CONFIG_NET_ETHERNET=3Dy
# CONFIG_MII is not set
# CONFIG_MACE is not set
# CONFIG_BMAC is not set
# CONFIG_OAKNET is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
CONFIG_NET_TULIP=3Dy
# CONFIG_DE2104X is not set
CONFIG_TULIP=3Dy
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_TULIP_NAPI is not set
# CONFIG_DE4X5 is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
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
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

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
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

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
CONFIG_INPUT=3Dy

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=3Dy
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=3Dy
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
CONFIG_SERIAL_8250_NR_UARTS=3D4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
# CONFIG_SERIAL_PMACZILOG is not set
CONFIG_UNIX98_PTYS=3Dy
# CONFIG_LEGACY_PTYS is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
CONFIG_GEN_RTC=3Dy
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
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
CONFIG_DUMMY_CONSOLE=3Dy

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be
needed; see USB_STORAGE Help for more information
#

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
# CONFIG_EXT2_FS is not set
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
CONFIG_DNOTIFY=3Dy
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
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_SYSFS=3Dy
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=3Dy
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=3Dy

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
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_NFSD is not set
CONFIG_ROOT_NFS=3Dy
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
CONFIG_SUNRPC=3Dy
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
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy

#
# Native Language Support
#
# CONFIG_NLS is not set

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
CONFIG_CRC32=3Dy
# CONFIG_LIBCRC32C is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_MAGIC_SYSRQ=3Dy
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_KGDB is not set
CONFIG_XMON=3Dy
# CONFIG_BDI_SWITCH is not set
CONFIG_BOOTX_TEXT=3Dy

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
