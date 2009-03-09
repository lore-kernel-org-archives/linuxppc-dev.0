Return-Path: <Cris.Gong@accton.com.cn>
Received: from smtp-out.accton.com.cn (unknown [203.94.26.22])
	by ozlabs.org (Postfix) with ESMTP id 96B8ADDFB3
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Mar 2009 17:58:26 +1100 (EST)
Received: from shard-notes.accton.com.cn (unknown [192.168.96.5])
	by smtp-out.accton.com.cn (Postfix) with ESMTP id 9E5A63D041B
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Mar 2009 14:29:57 +0800 (CST)
To: linuxppc-dev@ozlabs.org
Subject: help:About USB_EHCI_ROOT_HUB_TT in MPC8347 USB development
MIME-Version: 1.0
Message-ID: <OF2930ED1B.0E0A4B5A-ON48257574.00239D6A-48257574.0023B1A0@accton.com.cn>
From: "Cris Gong" <Cris.Gong@accton.com.cn>
Date: Mon, 9 Mar 2009 14:29:58 +0800
Content-Type: multipart/alternative;
	boundary="=_alternative 0023B19948257574_="
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 0023B19948257574_=
Content-Type: text/plain; charset="US-ASCII"

Greetings,

     I have an mpc8347 board here.The linux kernel version is  2.6.19.2.

     MPC8347 MPH0 is connectted to a FS/LS PHY(Philips ISP1105),I insert a 
USB 2.0 storage disk.

     I add initial usb_platform_data in 
linux_2.6.19.2/arch/ppc/syslib/mpc83xx_devices.c

static struct fsl_usb2_platform_data mpc83xx_usb_platform_data = {
        .operating_mode = FSL_USB2_MPH_HOST,
        .phy_mode         = FSL_USB2_PHY_SERIAL,
        .port_enables      = FSL_USB2_PORT0_ENABLED,
};
 
   In kernel config,I have set CONFIG_USB_EHCI_ROOT_HUB_TT to y(get rid of 
EXPERIMENTAL)

   Why does it report error -32?(the Macro is EPIPE)


The following is capture file.
## Booting image at 01000000 ...
   Loading image: 
   Image version: 
   Created:      2009-03-06   7:52:17 UTC
   Verifying Checksum ... OK
   Uncompressing Multi-File Image ... OK
   Loading Ramdisk to 03e8b000, end 04000000 ... OK
Linux version 2.6.19.2-0.1 (cris.gong@atan-cat.accton.com.cn) (gcc version 
4.0.0 (DENX ELDK 4.1 4.0.0)) #1 PREEMPT Fri Mar 6 15:48:37 CST 2009
Zone PFN ranges:
  DMA             0 ->   125952
  Normal     125952 ->   125952
early_node_map[1] active PFN ranges
    0:        0 ->   125952
Built 1 zonelists.  Total pages: 124968
Kernel command line: root=/dev/ram rw console=ttyS0,115200 mem=492M 
dbg_start=0x1fc00914 dbg_size=524288
IPIC (128 IRQ sources, 8 External IRQs) at fe000700
PID hash table entries: 2048 (order: 11, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 494464k available (2036k kernel code, 1192k data, 144k init, 0k 
highmem)
Mount-cache hash table entries: 512
checking if image is initramfs...it isn't (bad gzip magic numbers); looks 
like an initrd
Freeing initrd memory: 1492k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
Generic PHY: Registered new driver
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler cfq registered (default)
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 9) is a 16550A
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 10) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: loaded (max 8 devices)
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2, 00:08:07:00:00:39 
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2, 85:e1:89:82:72:6f 
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
Common Flash mtd init ...
physmap platform flash device: 04000000 at fc000000
physmap-flash.0: Found 1 x16 devices at 0x0 in 8-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
physmap-flash.0: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
RedBoot partition parsing not available
Using physmap partition information
Creating 8 MTD partitions on "physmap-flash.0":
0x03f00000-0x03f80000 : "loader"
0x03c00000-0x03c20000 : "partitiontable"
0x03c20000-0x03c40000 : "environment"
0x03c40000-0x03c60000 : "filemapping"
0x03c60000-0x03c80000 : "hwinfo"
0x00c00000-0x01000000 : "userdata"
0x01000000-0x02000000 : "runtime0"
0x02000000-0x03000000 : "runtime1"
fsl-ehci fsl-ehci.1: No platform data for fsl-ehci.1.
fsl-ehci fsl-ehci.2: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.2: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.2: irq 39, io base 0xe0022000
fsl-ehci fsl-ehci.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: Product: Freescale On-Chip EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.19.2-0.1 ehci_hcd
usb usb1: SerialNumber: fsl-ehci.2
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usb 1-1: new full speed USB device using fsl-ehci and address 2
usb 1-1: device descriptor read/64, error -32
usb 1-1: device descriptor read/64, error -32
usb 1-1: new full speed USB device using fsl-ehci and address 3
usb 1-1: device descriptor read/64, error -32
usb 1-1: device descriptor read/64, error -32
usb 1-1: new full speed USB device using fsl-ehci and address 4
usb 1-1: device not accepting address 4, error -32
usb 1-1: new full speed USB device using fsl-ehci and address 5
usb 1-1: device not accepting address 5, error -32
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
i2c /dev entries driver
oprofile: using timer interrupt.
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 1492KiB [1 disk] into ram disk... done.
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 144k init
Running rc.accton.init ...

Please press Enter to activate this console. 
root:~> echo 8 > /proc/sys/kernel/printk  
root:~> hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0002
fsl-ehci fsl-ehci.2: GetStatus port 1 status cc001002 POWER sig=se0 CSC
hub 1-0:1.0: port 1, status 0100, change 0001, 12 Mb/s
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0002
fsl-ehci fsl-ehci.2: GetStatus port 1 status c0001803 POWER sig=j CSC 
CONNECT
hub 1-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
fsl-ehci fsl-ehci.2: port 1 high speed
fsl-ehci fsl-ehci.2: GetStatus port 1 status c0001005 POWER sig=se0 PE 
CONNECT
usb 1-1: new full speed USB device using fsl-ehci and address 6
fsl-ehci fsl-ehci.2: port 1 high speed
fsl-ehci fsl-ehci.2: GetStatus port 1 status c0001005 POWER sig=se0 PE 
CONNECT
usb 1-1: device descriptor read/64, error -32
usb 1-1: device descriptor read/64, error -32
usb 1-1: new full speed USB device using fsl-ehci and address 7
fsl-ehci fsl-ehci.2: port 1 high speed
fsl-ehci fsl-ehci.2: GetStatus port 1 status c0001005 POWER sig=se0 PE 
CONNECT
usb 1-1: device descriptor read/64, error -32
usb 1-1: device descriptor read/64, error -32
usb 1-1: new full speed USB device using fsl-ehci and address 8
usb 1-1: device not accepting address 8, error -32
usb 1-1: new full speed USB device using fsl-ehci and address 9
usb 1-1: device not accepting address 9, error -32

The following is my kernel configure file.

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.19.2-0.1
# Wed Mar  4 13:35:26 2009
#
CONFIG_MMU=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_GENERIC_NVRAM=y
CONFIG_GENERIC_FIND_NEXT_BIT=y
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_IPC_NS is not set
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
# CONFIG_UTS_NS is not set
# CONFIG_AUDIT is not set
# CONFIG_IKCONFIG is not set
# CONFIG_RELAY is not set
CONFIG_INITRAMFS_SOURCE=""
CONFIG_SYSCTL=y
CONFIG_EMBEDDED=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_EXTRA_PASS=y
# CONFIG_HOTPLUG is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Block layer
#
CONFIG_BLOCK=y
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_AS is not set
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"

#
# Processor
#
CONFIG_6xx=y
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_8xx is not set
# CONFIG_E200 is not set
# CONFIG_E500 is not set
CONFIG_PPC_FPU=y
# CONFIG_CPU_FREQ is not set
# CONFIG_WANT_EARLY_SERIAL is not set
CONFIG_PPC_GEN550=y
# CONFIG_ES4626H is not set
CONFIG_PPC_STD_MMU=y

#
# Platform options
#
# CONFIG_PPC_PREP is not set
# CONFIG_APUS is not set
# CONFIG_KATANA is not set
# CONFIG_WILLOW is not set
# CONFIG_CPCI690 is not set
# CONFIG_POWERPMC250 is not set
# CONFIG_CHESTNUT is not set
# CONFIG_SPRUCE is not set
# CONFIG_HDPU is not set
# CONFIG_EV64260 is not set
# CONFIG_LOPEC is not set
# CONFIG_MVME5100 is not set
# CONFIG_PPLUS is not set
# CONFIG_PRPMC750 is not set
# CONFIG_PRPMC800 is not set
# CONFIG_SANDPOINT is not set
# CONFIG_RADSTONE_PPC7D is not set
# CONFIG_PAL4 is not set
# CONFIG_GEMINI is not set
# CONFIG_EST8260 is not set
# CONFIG_SBC82xx is not set
# CONFIG_SBS8260 is not set
# CONFIG_RPX8260 is not set
# CONFIG_TQM8260 is not set
# CONFIG_PM82X is not set
# CONFIG_ADS8272_PLATFORM is not set
CONFIG_ASF4528B=y
# CONFIG_PQ2FADS is not set
# CONFIG_LITE5200 is not set
# CONFIG_EV64360 is not set
# CONFIG_TQM834x is not set
# CONFIG_TQM8272 is not set
CONFIG_MPC834x_SYS=y
CONFIG_83xx=y
CONFIG_MPC834x=y
CONFIG_PPC_83xx=y
# CONFIG_SMP is not set
# CONFIG_HIGHMEM is not set
CONFIG_ARCH_POPULATES_NODE_MAP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_RESOURCES_64BIT is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_PM is not set
CONFIG_SECCOMP=y
CONFIG_ISA_DMA_API=y

#
# Bus options
#
CONFIG_GENERIC_ISA_DMA=y
# CONFIG_PPC_I8259 is not set
CONFIG_PPC_INDIRECT_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_MPC83xx_PCI2 is not set
# CONFIG_PCI_DEBUG is not set

#
# PCCARD (PCMCIA/CardBus) support
#

#
# PCI Express support
#

#
# Advanced setup
#
CONFIG_ADVANCED_OPTIONS=y
CONFIG_HIGHMEM_START=0xfe000000
# CONFIG_LOWMEM_SIZE_BOOL is not set
CONFIG_LOWMEM_SIZE=0x30000000
# CONFIG_KERNEL_START_BOOL is not set
CONFIG_KERNEL_START=0xc0000000
# CONFIG_TASK_SIZE_BOOL is not set
CONFIG_TASK_SIZE=0x80000000
# CONFIG_BOOT_LOAD_BOOL is not set
CONFIG_BOOT_LOAD=0x00800000

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
# CONFIG_DEFAULT_BIC is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_HTCP is not set
# CONFIG_DEFAULT_VEGAS is not set
# CONFIG_DEFAULT_WESTWOOD is not set
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETFILTER is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_SYS_HYPERVISOR is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=y
# CONFIG_MTD_DEBUG is not set
# CONFIG_MTD_CONCAT is not set
CONFIG_MTD_PARTITIONS=y
# CONFIG_MTD_REDBOOT_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=y

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLOCK=y
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# CONFIG_MTD_OBSOLETE_CHIPS is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_START=0xFE000000
CONFIG_MTD_PHYSMAP_LEN=0x02000000
CONFIG_MTD_PHYSMAP_BANKWIDTH=1
# CONFIG_MTD_PLATRAM is not set
# CONFIG_MTD_ECN430_FB2_FLASH is not set
CONFIG_MTD_ASF4528B_FLASH=y

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOC2001PLUS is not set

#
# NAND Flash Device Drivers
#
# CONFIG_MTD_NAND is not set

#
# OneNAND Flash Device Drivers
#
# CONFIG_MTD_ONENAND is not set

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
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=32768
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
CONFIG_BLK_DEV_INITRD=y
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# Misc devices
#
# CONFIG_SGI_IOC4 is not set

#
# ATA/ATAPI/MFM/RLL support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Serial ATA (prod) and Parallel ATA (experimental) drivers
#
# CONFIG_ATA is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

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
# CONFIG_WINDFARM is not set

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
# PHY device support
#
CONFIG_PHYLIB=y

#
# MII PHY device drivers
#
# CONFIG_MARVELL_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_FIXED_PHY is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set
CONFIG_GIANFAR=y
CONFIG_GFAR_NAPI=y
# CONFIG_QLA3XXX is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set
# CONFIG_MYRI10GE is not set

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
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
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
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
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
# CONFIG_HW_RANDOM is not set
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
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_MPC=y
# CONFIG_I2C_MPC8260 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_M41T00 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set
# CONFIG_HWMON_VID is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
# CONFIG_USB_DABUSB is not set

#
# Graphics support
#
# CONFIG_FIRMWARE_EDID is not set
# CONFIG_FB is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
# CONFIG_USB_HID is not set

#
# USB HID Boot Protocol drivers
#

#
# USB Imaging devices
#
# CONFIG_USB_MICROTEK is not set

#
# USB Network Adapters
#
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_USBNET_MII is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_MON is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGET is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set

#
# USB DSL modem support
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
# LED devices
#
# CONFIG_NEW_LEDS is not set

#
# LED drivers
#

#
# LED Triggers
#

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#

#
# Real Time Clock
#

#
# DMA Engine support
#
# CONFIG_DMA_ENGINE is not set

#
# DMA Clients
#

#
# DMA Devices
#

#
# File systems
#
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_FUSE_FS is not set

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
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_HFSPLUS_FS is not set
# CONFIG_JFFS_FS is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
CONFIG_JFFS2_RUBIN=y
# CONFIG_JFFS2_CMODE_NONE is not set
CONFIG_JFFS2_CMODE_PRIORITY=y
# CONFIG_JFFS2_CMODE_SIZE is not set
CONFIG_CRAMFS=y
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_NFSD is not set
CONFIG_ROOT_NFS=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

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
CONFIG_NLS_ASCII=y
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
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_PLIST=y
CONFIG_PROFILING=y
CONFIG_OPROFILE=y

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_MUST_CHECK=y
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
CONFIG_FORCED_INLINING=y
# CONFIG_HEADERS_CHECK is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_KGDB is not set
# CONFIG_XMON is not set
# CONFIG_BDI_SWITCH is not set
# CONFIG_SERIAL_TEXT_DEBUG is not set
# CONFIG_ICE_DEBUG is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

Best Regards!
--=_alternative 0023B19948257574_=
Content-Type: text/html; charset="US-ASCII"


<br>
<br><font size=2 face="sans-serif">Greetings,</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp;I have an mpc8347
board here.The linux kernel version is &nbsp;2.6.19.2.</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp;MPC8347 MPH0 is
connectted to a FS/LS PHY(<b>Philips ISP1105</b>),I insert a USB 2.0 storage
disk.</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp;I add initial usb_platform_data
in linux_2.6.19.2/arch/ppc/syslib/mpc83xx_devices.c</font>
<br>
<table border width=100%>
<tr valign=top>
<td width=100%><font size=2 face="sans-serif">static struct fsl_usb2_platform_data
mpc83xx_usb_platform_data = {</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; .operating_mode
= FSL_USB2_MPH_HOST,</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; .phy_mode
&nbsp; &nbsp; &nbsp; &nbsp; = FSL_USB2_PHY_SERIAL,</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; .port_enables
&nbsp; &nbsp; &nbsp;= FSL_USB2_PORT0_ENABLED,</font>
<br><font size=2 face="sans-serif">};</font></table>
<br><font size=2 face="sans-serif">&nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp;In kernel config,I have
set CONFIG_USB_EHCI_ROOT_HUB_TT to y(get rid of EXPERIMENTAL)</font>
<br>
<br><font size=2 face="sans-serif"><b>&nbsp; &nbsp;</b></font><font size=2 color=red face="sans-serif"><b>Why
does it report error -32?(the Macro is EPIPE)</b></font>
<br>
<br>
<br><font size=2 face="sans-serif">The following is capture file.</font>
<table border width=100%>
<tr valign=top>
<td width=100%><font size=2 face="sans-serif">## Booting image at 01000000
...</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp;Loading image: &nbsp; </font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp;Image version: &nbsp; </font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp;Created: &nbsp; &nbsp;
&nbsp;2009-03-06 &nbsp; 7:52:17 UTC</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp;Verifying Checksum ...
OK</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp;Uncompressing Multi-File
Image ... OK</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp;Loading Ramdisk to 03e8b000,
end 04000000 ... OK</font>
<br><font size=2 face="sans-serif">Linux version 2.6.19.2-0.1 (cris.gong@atan-cat.accton.com.cn)
(gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)) #1 PREEMPT Fri Mar 6 15:48:37
CST 2009</font>
<br><font size=2 face="sans-serif">Zone PFN ranges:</font>
<br><font size=2 face="sans-serif">&nbsp; DMA &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; 0 -&gt; &nbsp; 125952</font>
<br><font size=2 face="sans-serif">&nbsp; Normal &nbsp; &nbsp; 125952 -&gt;
&nbsp; 125952</font>
<br><font size=2 face="sans-serif">early_node_map[1] active PFN ranges</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; 0: &nbsp; &nbsp; &nbsp;
&nbsp;0 -&gt; &nbsp; 125952</font>
<br><font size=2 face="sans-serif">Built 1 zonelists. &nbsp;Total pages:
124968</font>
<br><font size=2 face="sans-serif">Kernel command line: root=/dev/ram rw
console=ttyS0,115200 mem=492M dbg_start=0x1fc00914 dbg_size=524288</font>
<br><font size=2 face="sans-serif">IPIC (128 IRQ sources, 8 External IRQs)
at fe000700</font>
<br><font size=2 face="sans-serif">PID hash table entries: 2048 (order:
11, 8192 bytes)</font>
<br><font size=2 face="sans-serif">Dentry cache hash table entries: 65536
(order: 6, 262144 bytes)</font>
<br><font size=2 face="sans-serif">Inode-cache hash table entries: 32768
(order: 5, 131072 bytes)</font>
<br><font size=2 face="sans-serif">Memory: 494464k available (2036k kernel
code, 1192k data, 144k init, 0k highmem)</font>
<br><font size=2 face="sans-serif">Mount-cache hash table entries: 512</font>
<br><font size=2 face="sans-serif">checking if image is initramfs...it
isn't (bad gzip magic numbers); looks like an initrd</font>
<br><font size=2 face="sans-serif">Freeing initrd memory: 1492k freed</font>
<br><font size=2 face="sans-serif">NET: Registered protocol family 16</font>
<br><font size=2 face="sans-serif">PCI: Probing PCI hardware</font>
<br><font size=2 face="sans-serif">Generic PHY: Registered new driver</font>
<br><font size=2 face="sans-serif">SCSI subsystem initialized</font>
<br><font size=2 face="sans-serif">usbcore: registered new interface driver
usbfs</font>
<br><font size=2 face="sans-serif">usbcore: registered new interface driver
hub</font>
<br><font size=2 face="sans-serif">usbcore: registered new device driver
usb</font>
<br><font size=2 face="sans-serif">NET: Registered protocol family 2</font>
<br><font size=2 face="sans-serif">IP route cache hash table entries: 4096
(order: 2, 16384 bytes)</font>
<br><font size=2 face="sans-serif">TCP established hash table entries:
16384 (order: 4, 65536 bytes)</font>
<br><font size=2 face="sans-serif">TCP bind hash table entries: 8192 (order:
3, 32768 bytes)</font>
<br><font size=2 face="sans-serif">TCP: Hash tables configured (established
16384 bind 8192)</font>
<br><font size=2 face="sans-serif">TCP reno registered</font>
<br><font size=2 face="sans-serif">JFFS2 version 2.2. (NAND) (C) 2001-2006
Red Hat, Inc.</font>
<br><font size=2 face="sans-serif">io scheduler noop registered</font>
<br><font size=2 face="sans-serif">io scheduler cfq registered (default)</font>
<br><font size=2 face="sans-serif">Generic RTC Driver v1.07</font>
<br><font size=2 face="sans-serif">Serial: 8250/16550 driver $Revision:
1.90 $ 4 ports, IRQ sharing disabled</font>
<br><font size=2 face="sans-serif">serial8250.0: ttyS0 at MMIO 0xe0004500
(irq = 9) is a 16550A</font>
<br><font size=2 face="sans-serif">serial8250.0: ttyS1 at MMIO 0xe0004600
(irq = 10) is a 16550A</font>
<br><font size=2 face="sans-serif">RAMDISK driver initialized: 16 RAM disks
of 32768K size 1024 blocksize</font>
<br><font size=2 face="sans-serif">loop: loaded (max 8 devices)</font>
<br><font size=2 face="sans-serif">Gianfar MII Bus: probed</font>
<br><font size=2 face="sans-serif">eth0: Gianfar Ethernet Controller Version
1.2, 00:08:07:00:00:39 </font>
<br><font size=2 face="sans-serif">eth0: Running with NAPI enabled</font>
<br><font size=2 face="sans-serif">eth0: 256/256 RX/TX BD ring size</font>
<br><font size=2 face="sans-serif">eth1: Gianfar Ethernet Controller Version
1.2, 85:e1:89:82:72:6f </font>
<br><font size=2 face="sans-serif">eth1: Running with NAPI enabled</font>
<br><font size=2 face="sans-serif">eth1: 256/256 RX/TX BD ring size</font>
<br><font size=2 face="sans-serif">Common Flash mtd init ...</font>
<br><font size=2 face="sans-serif">physmap platform flash device: 04000000
at fc000000</font>
<br><font size=2 face="sans-serif">physmap-flash.0: Found 1 x16 devices
at 0x0 in 8-bit bank</font>
<br><font size=2 face="sans-serif">&nbsp;Amd/Fujitsu Extended Query Table
at 0x0040</font>
<br><font size=2 face="sans-serif">physmap-flash.0: CFI does not contain
boot bank location. Assuming top.</font>
<br><font size=2 face="sans-serif">number of CFI chips: 1</font>
<br><font size=2 face="sans-serif">cfi_cmdset_0002: Disabling erase-suspend-program
due to code brokenness.</font>
<br><font size=2 face="sans-serif">RedBoot partition parsing not available</font>
<br><font size=2 face="sans-serif">Using physmap partition information</font>
<br><font size=2 face="sans-serif">Creating 8 MTD partitions on &quot;physmap-flash.0&quot;:</font>
<br><font size=2 face="sans-serif">0x03f00000-0x03f80000 : &quot;loader&quot;</font>
<br><font size=2 face="sans-serif">0x03c00000-0x03c20000 : &quot;partitiontable&quot;</font>
<br><font size=2 face="sans-serif">0x03c20000-0x03c40000 : &quot;environment&quot;</font>
<br><font size=2 face="sans-serif">0x03c40000-0x03c60000 : &quot;filemapping&quot;</font>
<br><font size=2 face="sans-serif">0x03c60000-0x03c80000 : &quot;hwinfo&quot;</font>
<br><font size=2 face="sans-serif">0x00c00000-0x01000000 : &quot;userdata&quot;</font>
<br><font size=2 face="sans-serif">0x01000000-0x02000000 : &quot;runtime0&quot;</font>
<br><font size=2 face="sans-serif">0x02000000-0x03000000 : &quot;runtime1&quot;</font>
<br><font size=2 face="sans-serif">fsl-ehci fsl-ehci.1: No platform data
for fsl-ehci.1.</font>
<br><font size=2 face="sans-serif">fsl-ehci fsl-ehci.2: Freescale On-Chip
EHCI Host Controller</font>
<br><font size=2 face="sans-serif">fsl-ehci fsl-ehci.2: new USB bus registered,
assigned bus number 1</font>
<br><font size=2 face="sans-serif">fsl-ehci fsl-ehci.2: irq 39, io base
0xe0022000</font>
<br><font size=2 face="sans-serif">fsl-ehci fsl-ehci.2: USB 2.0 started,
EHCI 1.00, driver 10 Dec 2004</font>
<br><font size=2 face="sans-serif">usb usb1: Product: Freescale On-Chip
EHCI Host Controller</font>
<br><font size=2 face="sans-serif">usb usb1: Manufacturer: Linux 2.6.19.2-0.1
ehci_hcd</font>
<br><font size=2 face="sans-serif">usb usb1: SerialNumber: fsl-ehci.2</font>
<br><font size=2 face="sans-serif">usb usb1: configuration #1 chosen from
1 choice</font>
<br><font size=2 face="sans-serif">hub 1-0:1.0: USB hub found</font>
<br><font size=2 face="sans-serif">hub 1-0:1.0: 2 ports detected</font>
<br><font size=2 face="sans-serif">Initializing USB Mass Storage driver...</font>
<br><font size=2 face="sans-serif">usb 1-1: new full speed USB device using
fsl-ehci and address 2</font>
<br><font size=2 color=red face="sans-serif"><b>usb 1-1: device descriptor
read/64, error -32</b></font>
<br><font size=2 color=red face="sans-serif"><b>usb 1-1: device descriptor
read/64, error -32</b></font>
<br><font size=2 face="sans-serif">usb 1-1: new full speed USB device using
fsl-ehci and address 3</font>
<br><font size=2 face="sans-serif">usb 1-1: device descriptor read/64,
error -32</font>
<br><font size=2 face="sans-serif">usb 1-1: device descriptor read/64,
error -32</font>
<br><font size=2 face="sans-serif">usb 1-1: new full speed USB device using
fsl-ehci and address 4</font>
<br><font size=2 face="sans-serif">usb 1-1: device not accepting address
4, error -32</font>
<br><font size=2 face="sans-serif">usb 1-1: new full speed USB device using
fsl-ehci and address 5</font>
<br><font size=2 face="sans-serif">usb 1-1: device not accepting address
5, error -32</font>
<br><font size=2 face="sans-serif">usbcore: registered new interface driver
usb-storage</font>
<br><font size=2 face="sans-serif">USB Mass Storage support registered.</font>
<br><font size=2 face="sans-serif">i2c /dev entries driver</font>
<br><font size=2 face="sans-serif">oprofile: using timer interrupt.</font>
<br><font size=2 face="sans-serif">TCP cubic registered</font>
<br><font size=2 face="sans-serif">NET: Registered protocol family 1</font>
<br><font size=2 face="sans-serif">NET: Registered protocol family 17</font>
<br><font size=2 face="sans-serif">RAMDISK: cramfs filesystem found at
block 0</font>
<br><font size=2 face="sans-serif">RAMDISK: Loading 1492KiB [1 disk] into
ram disk... done.</font>
<br><font size=2 face="sans-serif">VFS: Mounted root (cramfs filesystem)
readonly.</font>
<br><font size=2 face="sans-serif">Freeing unused kernel memory: 144k init</font>
<br><font size=2 face="sans-serif">Running rc.accton.init ...</font>
<br>
<br><font size=2 face="sans-serif">Please press Enter to activate this
console. </font>
<br><font size=2 face="sans-serif">root:~&gt; <b>echo 8 &gt; /proc/sys/kernel/printk
</b>&nbsp; </font>
<br><font size=2 face="sans-serif">root:~&gt; hub 1-0:1.0: state 7 ports
2 chg 0000 evt 0002</font>
<br><font size=2 face="sans-serif">fsl-ehci fsl-ehci.2: GetStatus port
1 status cc001002 POWER sig=se0 CSC</font>
<br><font size=2 face="sans-serif">hub 1-0:1.0: port 1, status 0100, change
0001, 12 Mb/s</font>
<br><font size=2 face="sans-serif">hub 1-0:1.0: debounce: port 1: total
100ms stable 100ms status 0x100</font>
<br><font size=2 face="sans-serif">hub 1-0:1.0: state 7 ports 2 chg 0000
evt 0002</font>
<br><font size=2 face="sans-serif">fsl-ehci fsl-ehci.2: GetStatus port
1 status c0001803 POWER sig=j CSC CONNECT</font>
<br><font size=2 face="sans-serif">hub 1-0:1.0: port 1, status 0101, change
0001, 12 Mb/s</font>
<br><font size=2 face="sans-serif">hub 1-0:1.0: debounce: port 1: total
100ms stable 100ms status 0x101</font>
<br><font size=2 face="sans-serif">fsl-ehci fsl-ehci.2: port 1 high speed</font>
<br><font size=2 face="sans-serif">fsl-ehci fsl-ehci.2: GetStatus port
1 status c0001005 POWER sig=se0 PE CONNECT</font>
<br><font size=2 face="sans-serif">usb 1-1: new full speed USB device using
fsl-ehci and address 6</font>
<br><font size=2 face="sans-serif">fsl-ehci fsl-ehci.2: port 1 high speed</font>
<br><font size=2 face="sans-serif">fsl-ehci fsl-ehci.2: GetStatus port
1 status c0001005 POWER sig=se0 PE CONNECT</font>
<br><font size=2 face="sans-serif">usb 1-1: device descriptor read/64,
error -32</font>
<br><font size=2 face="sans-serif">usb 1-1: device descriptor read/64,
error -32</font>
<br><font size=2 face="sans-serif">usb 1-1: new full speed USB device using
fsl-ehci and address 7</font>
<br><font size=2 face="sans-serif">fsl-ehci fsl-ehci.2: port 1 high speed</font>
<br><font size=2 face="sans-serif">fsl-ehci fsl-ehci.2: GetStatus port
1 status c0001005 POWER sig=se0 PE CONNECT</font>
<br><font size=2 face="sans-serif">usb 1-1: device descriptor read/64,
error -32</font>
<br><font size=2 face="sans-serif">usb 1-1: device descriptor read/64,
error -32</font>
<br><font size=2 face="sans-serif">usb 1-1: new full speed USB device using
fsl-ehci and address 8</font>
<br><font size=2 face="sans-serif">usb 1-1: device not accepting address
8, error -32</font>
<br><font size=2 face="sans-serif">usb 1-1: new full speed USB device using
fsl-ehci and address 9</font>
<br><font size=2 face="sans-serif">usb 1-1: device not accepting address
9, error -32</font></table>
<br>
<br><font size=2 face="sans-serif">The following is my kernel configure
file.</font>
<br>
<table border width=100%>
<tr valign=top>
<td width=100%><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Automatically generated make config:
don't edit</font>
<br><font size=2 face="sans-serif"># Linux kernel version: 2.6.19.2-0.1</font>
<br><font size=2 face="sans-serif"># Wed Mar &nbsp;4 13:35:26 2009</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_MMU=y</font>
<br><font size=2 face="sans-serif">CONFIG_GENERIC_HARDIRQS=y</font>
<br><font size=2 face="sans-serif">CONFIG_RWSEM_XCHGADD_ALGORITHM=y</font>
<br><font size=2 face="sans-serif">CONFIG_GENERIC_HWEIGHT=y</font>
<br><font size=2 face="sans-serif">CONFIG_GENERIC_CALIBRATE_DELAY=y</font>
<br><font size=2 face="sans-serif">CONFIG_PPC=y</font>
<br><font size=2 face="sans-serif">CONFIG_PPC32=y</font>
<br><font size=2 face="sans-serif">CONFIG_GENERIC_NVRAM=y</font>
<br><font size=2 face="sans-serif">CONFIG_GENERIC_FIND_NEXT_BIT=y</font>
<br><font size=2 face="sans-serif">CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y</font>
<br><font size=2 face="sans-serif">CONFIG_ARCH_MAY_HAVE_PC_FDC=y</font>
<br><font size=2 face="sans-serif">CONFIG_DEFCONFIG_LIST=&quot;/lib/modules/$UNAME_RELEASE/.config&quot;</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Code maturity level options</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_EXPERIMENTAL is not set</font>
<br><font size=2 face="sans-serif">CONFIG_BROKEN_ON_SMP=y</font>
<br><font size=2 face="sans-serif">CONFIG_LOCK_KERNEL=y</font>
<br><font size=2 face="sans-serif">CONFIG_INIT_ENV_ARG_LIMIT=32</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># General setup</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_LOCALVERSION=&quot;&quot;</font>
<br><font size=2 face="sans-serif">CONFIG_LOCALVERSION_AUTO=y</font>
<br><font size=2 face="sans-serif">CONFIG_SWAP=y</font>
<br><font size=2 face="sans-serif">CONFIG_SYSVIPC=y</font>
<br><font size=2 face="sans-serif"># CONFIG_IPC_NS is not set</font>
<br><font size=2 face="sans-serif">CONFIG_BSD_PROCESS_ACCT=y</font>
<br><font size=2 face="sans-serif"># CONFIG_BSD_PROCESS_ACCT_V3 is not
set</font>
<br><font size=2 face="sans-serif"># CONFIG_TASKSTATS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_UTS_NS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_AUDIT is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_IKCONFIG is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_RELAY is not set</font>
<br><font size=2 face="sans-serif">CONFIG_INITRAMFS_SOURCE=&quot;&quot;</font>
<br><font size=2 face="sans-serif">CONFIG_SYSCTL=y</font>
<br><font size=2 face="sans-serif">CONFIG_EMBEDDED=y</font>
<br><font size=2 face="sans-serif">CONFIG_SYSCTL_SYSCALL=y</font>
<br><font size=2 face="sans-serif">CONFIG_KALLSYMS=y</font>
<br><font size=2 face="sans-serif"># CONFIG_KALLSYMS_ALL is not set</font>
<br><font size=2 face="sans-serif">CONFIG_KALLSYMS_EXTRA_PASS=y</font>
<br><font size=2 face="sans-serif"># CONFIG_HOTPLUG is not set</font>
<br><font size=2 face="sans-serif">CONFIG_PRINTK=y</font>
<br><font size=2 face="sans-serif">CONFIG_BUG=y</font>
<br><font size=2 face="sans-serif">CONFIG_ELF_CORE=y</font>
<br><font size=2 face="sans-serif">CONFIG_BASE_FULL=y</font>
<br><font size=2 face="sans-serif">CONFIG_FUTEX=y</font>
<br><font size=2 face="sans-serif">CONFIG_EPOLL=y</font>
<br><font size=2 face="sans-serif">CONFIG_SHMEM=y</font>
<br><font size=2 face="sans-serif">CONFIG_SLAB=y</font>
<br><font size=2 face="sans-serif"># CONFIG_VM_EVENT_COUNTERS is not set</font>
<br><font size=2 face="sans-serif">CONFIG_RT_MUTEXES=y</font>
<br><font size=2 face="sans-serif"># CONFIG_TINY_SHMEM is not set</font>
<br><font size=2 face="sans-serif">CONFIG_BASE_SMALL=0</font>
<br><font size=2 face="sans-serif"># CONFIG_SLOB is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Loadable module support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_MODULES=y</font>
<br><font size=2 face="sans-serif">CONFIG_MODULE_UNLOAD=y</font>
<br><font size=2 face="sans-serif"># CONFIG_MODVERSIONS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_MODULE_SRCVERSION_ALL is not
set</font>
<br><font size=2 face="sans-serif">CONFIG_KMOD=y</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Block layer</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_BLOCK=y</font>
<br><font size=2 face="sans-serif"># CONFIG_LBD is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_BLK_DEV_IO_TRACE is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_LSF is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># IO Schedulers</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_IOSCHED_NOOP=y</font>
<br><font size=2 face="sans-serif"># CONFIG_IOSCHED_AS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_IOSCHED_DEADLINE is not set</font>
<br><font size=2 face="sans-serif">CONFIG_IOSCHED_CFQ=y</font>
<br><font size=2 face="sans-serif"># CONFIG_DEFAULT_AS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_DEFAULT_DEADLINE is not set</font>
<br><font size=2 face="sans-serif">CONFIG_DEFAULT_CFQ=y</font>
<br><font size=2 face="sans-serif"># CONFIG_DEFAULT_NOOP is not set</font>
<br><font size=2 face="sans-serif">CONFIG_DEFAULT_IOSCHED=&quot;cfq&quot;</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Processor</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_6xx=y</font>
<br><font size=2 face="sans-serif"># CONFIG_40x is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_44x is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_8xx is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_E200 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_E500 is not set</font>
<br><font size=2 face="sans-serif">CONFIG_PPC_FPU=y</font>
<br><font size=2 face="sans-serif"># CONFIG_CPU_FREQ is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_WANT_EARLY_SERIAL is not set</font>
<br><font size=2 face="sans-serif">CONFIG_PPC_GEN550=y</font>
<br><font size=2 face="sans-serif"># CONFIG_ES4626H is not set</font>
<br><font size=2 face="sans-serif">CONFIG_PPC_STD_MMU=y</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Platform options</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_PPC_PREP is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_APUS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_KATANA is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_WILLOW is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_CPCI690 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_POWERPMC250 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_CHESTNUT is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SPRUCE is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_HDPU is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_EV64260 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_LOPEC is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_MVME5100 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_PPLUS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_PRPMC750 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_PRPMC800 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SANDPOINT is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_RADSTONE_PPC7D is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_PAL4 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_GEMINI is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_EST8260 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SBC82xx is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SBS8260 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_RPX8260 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_TQM8260 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_PM82X is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_ADS8272_PLATFORM is not set</font>
<br><font size=2 face="sans-serif">CONFIG_ASF4528B=y</font>
<br><font size=2 face="sans-serif"># CONFIG_PQ2FADS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_LITE5200 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_EV64360 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_TQM834x is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_TQM8272 is not set</font>
<br><font size=2 face="sans-serif">CONFIG_MPC834x_SYS=y</font>
<br><font size=2 face="sans-serif">CONFIG_83xx=y</font>
<br><font size=2 face="sans-serif">CONFIG_MPC834x=y</font>
<br><font size=2 face="sans-serif">CONFIG_PPC_83xx=y</font>
<br><font size=2 face="sans-serif"># CONFIG_SMP is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_HIGHMEM is not set</font>
<br><font size=2 face="sans-serif">CONFIG_ARCH_POPULATES_NODE_MAP=y</font>
<br><font size=2 face="sans-serif"># CONFIG_HZ_100 is not set</font>
<br><font size=2 face="sans-serif">CONFIG_HZ_250=y</font>
<br><font size=2 face="sans-serif"># CONFIG_HZ_1000 is not set</font>
<br><font size=2 face="sans-serif">CONFIG_HZ=250</font>
<br><font size=2 face="sans-serif"># CONFIG_PREEMPT_NONE is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_PREEMPT_VOLUNTARY is not set</font>
<br><font size=2 face="sans-serif">CONFIG_PREEMPT=y</font>
<br><font size=2 face="sans-serif">CONFIG_PREEMPT_BKL=y</font>
<br><font size=2 face="sans-serif">CONFIG_FLATMEM=y</font>
<br><font size=2 face="sans-serif">CONFIG_FLAT_NODE_MEM_MAP=y</font>
<br><font size=2 face="sans-serif"># CONFIG_SPARSEMEM_STATIC is not set</font>
<br><font size=2 face="sans-serif">CONFIG_SPLIT_PTLOCK_CPUS=4</font>
<br><font size=2 face="sans-serif"># CONFIG_RESOURCES_64BIT is not set</font>
<br><font size=2 face="sans-serif">CONFIG_BINFMT_ELF=y</font>
<br><font size=2 face="sans-serif">CONFIG_BINFMT_MISC=y</font>
<br><font size=2 face="sans-serif"># CONFIG_CMDLINE_BOOL is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_PM is not set</font>
<br><font size=2 face="sans-serif">CONFIG_SECCOMP=y</font>
<br><font size=2 face="sans-serif">CONFIG_ISA_DMA_API=y</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Bus options</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_GENERIC_ISA_DMA=y</font>
<br><font size=2 face="sans-serif"># CONFIG_PPC_I8259 is not set</font>
<br><font size=2 face="sans-serif">CONFIG_PPC_INDIRECT_PCI=y</font>
<br><font size=2 face="sans-serif">CONFIG_PCI=y</font>
<br><font size=2 face="sans-serif">CONFIG_PCI_DOMAINS=y</font>
<br><font size=2 face="sans-serif"># CONFIG_MPC83xx_PCI2 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_PCI_DEBUG is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># PCCARD (PCMCIA/CardBus) support</font>
<br><font size=2 face="sans-serif">#</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># PCI Express support</font>
<br><font size=2 face="sans-serif">#</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Advanced setup</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_ADVANCED_OPTIONS=y</font>
<br><font size=2 face="sans-serif">CONFIG_HIGHMEM_START=0xfe000000</font>
<br><font size=2 face="sans-serif"># CONFIG_LOWMEM_SIZE_BOOL is not set</font>
<br><font size=2 face="sans-serif">CONFIG_LOWMEM_SIZE=0x30000000</font>
<br><font size=2 face="sans-serif"># CONFIG_KERNEL_START_BOOL is not set</font>
<br><font size=2 face="sans-serif">CONFIG_KERNEL_START=0xc0000000</font>
<br><font size=2 face="sans-serif"># CONFIG_TASK_SIZE_BOOL is not set</font>
<br><font size=2 face="sans-serif">CONFIG_TASK_SIZE=0x80000000</font>
<br><font size=2 face="sans-serif"># CONFIG_BOOT_LOAD_BOOL is not set</font>
<br><font size=2 face="sans-serif">CONFIG_BOOT_LOAD=0x00800000</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Networking</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_NET=y</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Networking options</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_NETDEBUG is not set</font>
<br><font size=2 face="sans-serif">CONFIG_PACKET=y</font>
<br><font size=2 face="sans-serif">CONFIG_PACKET_MMAP=y</font>
<br><font size=2 face="sans-serif">CONFIG_UNIX=y</font>
<br><font size=2 face="sans-serif"># CONFIG_NET_KEY is not set</font>
<br><font size=2 face="sans-serif">CONFIG_INET=y</font>
<br><font size=2 face="sans-serif"># CONFIG_IP_MULTICAST is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_IP_ADVANCED_ROUTER is not set</font>
<br><font size=2 face="sans-serif">CONFIG_IP_FIB_HASH=y</font>
<br><font size=2 face="sans-serif">CONFIG_IP_PNP=y</font>
<br><font size=2 face="sans-serif">CONFIG_IP_PNP_DHCP=y</font>
<br><font size=2 face="sans-serif">CONFIG_IP_PNP_BOOTP=y</font>
<br><font size=2 face="sans-serif">CONFIG_IP_PNP_RARP=y</font>
<br><font size=2 face="sans-serif"># CONFIG_NET_IPIP is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_NET_IPGRE is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SYN_COOKIES is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_INET_AH is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_INET_ESP is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_INET_IPCOMP is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_INET_XFRM_TUNNEL is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_INET_TUNNEL is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_INET_XFRM_MODE_TRANSPORT is
not set</font>
<br><font size=2 face="sans-serif"># CONFIG_INET_XFRM_MODE_TUNNEL is not
set</font>
<br><font size=2 face="sans-serif"># CONFIG_INET_XFRM_MODE_BEET is not
set</font>
<br><font size=2 face="sans-serif">CONFIG_INET_DIAG=y</font>
<br><font size=2 face="sans-serif">CONFIG_INET_TCP_DIAG=y</font>
<br><font size=2 face="sans-serif">CONFIG_TCP_CONG_ADVANCED=y</font>
<br><font size=2 face="sans-serif">CONFIG_TCP_CONG_BIC=m</font>
<br><font size=2 face="sans-serif">CONFIG_TCP_CONG_CUBIC=y</font>
<br><font size=2 face="sans-serif">CONFIG_TCP_CONG_WESTWOOD=m</font>
<br><font size=2 face="sans-serif">CONFIG_TCP_CONG_HTCP=m</font>
<br><font size=2 face="sans-serif"># CONFIG_DEFAULT_BIC is not set</font>
<br><font size=2 face="sans-serif">CONFIG_DEFAULT_CUBIC=y</font>
<br><font size=2 face="sans-serif"># CONFIG_DEFAULT_HTCP is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_DEFAULT_VEGAS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_DEFAULT_WESTWOOD is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_DEFAULT_RENO is not set</font>
<br><font size=2 face="sans-serif">CONFIG_DEFAULT_TCP_CONG=&quot;cubic&quot;</font>
<br><font size=2 face="sans-serif"># CONFIG_IPV6 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_INET6_XFRM_TUNNEL is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_INET6_TUNNEL is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_NETWORK_SECMARK is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_NETFILTER is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_BRIDGE is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_VLAN_8021Q is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_DECNET is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_LLC2 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_IPX is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_ATALK is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># QoS and/or fair queueing</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_NET_SCHED is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Network testing</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_NET_PKTGEN is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_HAMRADIO is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_IRDA is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_BT is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_IEEE80211 is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Device Drivers</font>
<br><font size=2 face="sans-serif">#</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Generic Driver Options</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_STANDALONE=y</font>
<br><font size=2 face="sans-serif">CONFIG_PREVENT_FIRMWARE_BUILD=y</font>
<br><font size=2 face="sans-serif"># CONFIG_DEBUG_DRIVER is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SYS_HYPERVISOR is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Connector - unified userspace &lt;-&gt;
kernelspace linker</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_CONNECTOR is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Memory Technology Devices (MTD)</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_MTD=y</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_DEBUG is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_CONCAT is not set</font>
<br><font size=2 face="sans-serif">CONFIG_MTD_PARTITIONS=y</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_REDBOOT_PARTS is not set</font>
<br><font size=2 face="sans-serif">CONFIG_MTD_CMDLINE_PARTS=y</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># User Modules And Translation Layers</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_MTD_CHAR=y</font>
<br><font size=2 face="sans-serif">CONFIG_MTD_BLOCK=y</font>
<br><font size=2 face="sans-serif"># CONFIG_FTL is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_NFTL is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_INFTL is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_RFD_FTL is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SSFDC is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># RAM/ROM/Flash chip drivers</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_MTD_CFI=y</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_JEDECPROBE is not set</font>
<br><font size=2 face="sans-serif">CONFIG_MTD_GEN_PROBE=y</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_CFI_ADV_OPTIONS is not
set</font>
<br><font size=2 face="sans-serif">CONFIG_MTD_MAP_BANK_WIDTH_1=y</font>
<br><font size=2 face="sans-serif">CONFIG_MTD_MAP_BANK_WIDTH_2=y</font>
<br><font size=2 face="sans-serif">CONFIG_MTD_MAP_BANK_WIDTH_4=y</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_MAP_BANK_WIDTH_8 is not
set</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_MAP_BANK_WIDTH_16 is not
set</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_MAP_BANK_WIDTH_32 is not
set</font>
<br><font size=2 face="sans-serif">CONFIG_MTD_CFI_I1=y</font>
<br><font size=2 face="sans-serif">CONFIG_MTD_CFI_I2=y</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_CFI_I4 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_CFI_I8 is not set</font>
<br><font size=2 face="sans-serif">CONFIG_MTD_CFI_INTELEXT=y</font>
<br><font size=2 face="sans-serif">CONFIG_MTD_CFI_AMDSTD=y</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_CFI_STAA is not set</font>
<br><font size=2 face="sans-serif">CONFIG_MTD_CFI_UTIL=y</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_RAM is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_ROM is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_ABSENT is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_OBSOLETE_CHIPS is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Mapping drivers for chip access</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_COMPLEX_MAPPINGS is not
set</font>
<br><font size=2 face="sans-serif">CONFIG_MTD_PHYSMAP=y</font>
<br><font size=2 face="sans-serif">CONFIG_MTD_PHYSMAP_START=0xFE000000</font>
<br><font size=2 face="sans-serif">CONFIG_MTD_PHYSMAP_LEN=0x02000000</font>
<br><font size=2 face="sans-serif">CONFIG_MTD_PHYSMAP_BANKWIDTH=1</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_PLATRAM is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_ECN430_FB2_FLASH is not
set</font>
<br><font size=2 face="sans-serif">CONFIG_MTD_ASF4528B_FLASH=y</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Self-contained MTD device drivers</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_PMC551 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_SLRAM is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_PHRAM is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_MTDRAM is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_BLOCK2MTD is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Disk-On-Chip Device Drivers</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_DOC2000 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_DOC2001 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_DOC2001PLUS is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># NAND Flash Device Drivers</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_NAND is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># OneNAND Flash Device Drivers</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_MTD_ONENAND is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Parallel port support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_PARPORT is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Plug and Play support</font>
<br><font size=2 face="sans-serif">#</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Block devices</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_BLK_DEV_FD is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_BLK_CPQ_DA is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_BLK_CPQ_CISS_DA is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_BLK_DEV_DAC960 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_BLK_DEV_COW_COMMON is not set</font>
<br><font size=2 face="sans-serif">CONFIG_BLK_DEV_LOOP=y</font>
<br><font size=2 face="sans-serif"># CONFIG_BLK_DEV_CRYPTOLOOP is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_BLK_DEV_NBD is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_BLK_DEV_SX8 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_BLK_DEV_UB is not set</font>
<br><font size=2 face="sans-serif">CONFIG_BLK_DEV_RAM=y</font>
<br><font size=2 face="sans-serif">CONFIG_BLK_DEV_RAM_COUNT=16</font>
<br><font size=2 face="sans-serif">CONFIG_BLK_DEV_RAM_SIZE=32768</font>
<br><font size=2 face="sans-serif">CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024</font>
<br><font size=2 face="sans-serif">CONFIG_BLK_DEV_INITRD=y</font>
<br><font size=2 face="sans-serif"># CONFIG_CDROM_PKTCDVD is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_ATA_OVER_ETH is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Misc devices</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_SGI_IOC4 is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># ATA/ATAPI/MFM/RLL support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_IDE is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># SCSI device support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_RAID_ATTRS is not set</font>
<br><font size=2 face="sans-serif">CONFIG_SCSI=y</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_NETLINK is not set</font>
<br><font size=2 face="sans-serif">CONFIG_SCSI_PROC_FS=y</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># SCSI support type (disk, tape, CD-ROM)</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_BLK_DEV_SD=y</font>
<br><font size=2 face="sans-serif"># CONFIG_CHR_DEV_ST is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_CHR_DEV_OSST is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_BLK_DEV_SR is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_CHR_DEV_SG is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_CHR_DEV_SCH is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Some SCSI devices (e.g. CD jukebox)
support multiple LUNs</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_MULTI_LUN is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_CONSTANTS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_LOGGING is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># SCSI Transports</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_SPI_ATTRS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_FC_ATTRS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_ISCSI_ATTRS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_SAS_ATTRS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_SAS_LIBSAS is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># SCSI low-level drivers</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_ISCSI_TCP is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_BLK_DEV_3W_XXXX_RAID is not
set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_3W_9XXX is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_ACARD is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_AACRAID is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_AIC7XXX is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_AIC7XXX_OLD is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_AIC79XX is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_AIC94XX is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_DPT_I2O is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_ARCMSR is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_MEGARAID_NEWGEN is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_MEGARAID_LEGACY is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_MEGARAID_SAS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_HPTIOP is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_BUSLOGIC is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_DMX3191D is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_EATA is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_FUTURE_DOMAIN is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_GDTH is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_IPS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_INITIO is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_INIA100 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_STEX is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_SYM53C8XX_2 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_QLOGIC_1280 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_QLA_FC is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_QLA_ISCSI is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_LPFC is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_DC390T is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_NSP32 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SCSI_DEBUG is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Serial ATA (prod) and Parallel ATA
(experimental) drivers</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_ATA is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Multi-device support (RAID and LVM)</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_MD is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Fusion MPT device support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_FUSION is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_FUSION_SPI is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_FUSION_FC is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_FUSION_SAS is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># IEEE 1394 (FireWire) support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_IEEE1394 is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># I2O device support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_I2O is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Macintosh device drivers</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_WINDFARM is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Network device support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_NETDEVICES=y</font>
<br><font size=2 face="sans-serif"># CONFIG_DUMMY is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_BONDING is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_EQUALIZER is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_TUN is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># ARCnet devices</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_ARCNET is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># PHY device support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_PHYLIB=y</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># MII PHY device drivers</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_MARVELL_PHY is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_DAVICOM_PHY is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_QSEMI_PHY is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_LXT_PHY is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_CICADA_PHY is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_VITESSE_PHY is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SMSC_PHY is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_FIXED_PHY is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Ethernet (10 or 100Mbit)</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_NET_ETHERNET is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Ethernet (1000 Mbit)</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_ACENIC is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_DL2K is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_E1000 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_NS83820 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_HAMACHI is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_R8169 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SIS190 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SKGE is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SKY2 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SK98LIN is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_TIGON3 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_BNX2 is not set</font>
<br><font size=2 face="sans-serif">CONFIG_GIANFAR=y</font>
<br><font size=2 face="sans-serif">CONFIG_GFAR_NAPI=y</font>
<br><font size=2 face="sans-serif"># CONFIG_QLA3XXX is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Ethernet (10000 Mbit)</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_CHELSIO_T1 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_IXGB is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_S2IO is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_MYRI10GE is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Token Ring devices</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_TR is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Wireless LAN (non-hamradio)</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_NET_RADIO is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Wan interfaces</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_WAN is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_FDDI is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_PPP is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SLIP is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_NET_FC is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_NETPOLL is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_NET_POLL_CONTROLLER is not
set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># ISDN subsystem</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_ISDN is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Telephony Support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_PHONE is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Input device support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_INPUT is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Hardware I/O ports</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_SERIO is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_GAMEPORT is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Character devices</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_VT is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SERIAL_NONSTANDARD is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Serial drivers</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_SERIAL_8250=y</font>
<br><font size=2 face="sans-serif">CONFIG_SERIAL_8250_CONSOLE=y</font>
<br><font size=2 face="sans-serif">CONFIG_SERIAL_8250_PCI=y</font>
<br><font size=2 face="sans-serif">CONFIG_SERIAL_8250_NR_UARTS=4</font>
<br><font size=2 face="sans-serif">CONFIG_SERIAL_8250_RUNTIME_UARTS=4</font>
<br><font size=2 face="sans-serif"># CONFIG_SERIAL_8250_EXTENDED is not
set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Non-8250 serial port support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_SERIAL_CORE=y</font>
<br><font size=2 face="sans-serif">CONFIG_SERIAL_CORE_CONSOLE=y</font>
<br><font size=2 face="sans-serif"># CONFIG_SERIAL_JSM is not set</font>
<br><font size=2 face="sans-serif">CONFIG_UNIX98_PTYS=y</font>
<br><font size=2 face="sans-serif">CONFIG_LEGACY_PTYS=y</font>
<br><font size=2 face="sans-serif">CONFIG_LEGACY_PTY_COUNT=256</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># IPMI</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_IPMI_HANDLER is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Watchdog Cards</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_WATCHDOG is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_HW_RANDOM is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_NVRAM is not set</font>
<br><font size=2 face="sans-serif">CONFIG_GEN_RTC=y</font>
<br><font size=2 face="sans-serif"># CONFIG_GEN_RTC_X is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_DTLK is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_R3964 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_APPLICOM is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Ftape, the floppy tape device driver</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_AGP is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_DRM is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_RAW_DRIVER is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># TPM devices</font>
<br><font size=2 face="sans-serif">#</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># I2C support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_I2C=y</font>
<br><font size=2 face="sans-serif">CONFIG_I2C_CHARDEV=y</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># I2C Algorithms</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_ALGOBIT is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_ALGOPCF is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_ALGOPCA is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># I2C Hardware Bus support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_ALI1535 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_ALI15X3 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_AMD756 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_AMD8111 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_I801 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_I810 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_PIIX4 is not set</font>
<br><font size=2 face="sans-serif">CONFIG_I2C_MPC=y</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_MPC8260 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_NFORCE2 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_PARPORT_LIGHT is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_PROSAVAGE is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_SIS5595 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_SIS630 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_SIS96X is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_VIAPRO is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_VOODOO3 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_PCA_ISA is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Miscellaneous I2C Chip support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_SENSORS_M41T00 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_DEBUG_CORE is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_DEBUG_ALGO is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_DEBUG_BUS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_I2C_DEBUG_CHIP is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># SPI support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_SPI is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SPI_MASTER is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Dallas's 1-wire bus</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_W1 is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Hardware Monitoring support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_HWMON is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_HWMON_VID is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Multimedia devices</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_VIDEO_DEV is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Digital Video Broadcasting Devices</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_DVB is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_DABUSB is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Graphics support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_FIRMWARE_EDID is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_FB is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_BACKLIGHT_LCD_SUPPORT is not
set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Sound</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_SOUND is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># USB support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_USB_ARCH_HAS_HCD=y</font>
<br><font size=2 face="sans-serif">CONFIG_USB_ARCH_HAS_OHCI=y</font>
<br><font size=2 face="sans-serif">CONFIG_USB_ARCH_HAS_EHCI=y</font>
<br><font size=2 face="sans-serif">CONFIG_USB=y</font>
<br><font size=2 face="sans-serif">CONFIG_USB_DEBUG=y</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Miscellaneous USB options</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_USB_DEVICEFS=y</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># USB Host Controller Drivers</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 color=red face="sans-serif"><b>CONFIG_USB_EHCI_HCD=y</b></font>
<br><font size=2 color=red face="sans-serif"><b>CONFIG_USB_EHCI_ROOT_HUB_TT=y</b></font>
<br><font size=2 face="sans-serif"># CONFIG_USB_EHCI_TT_NEWSCHED is not
set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_OHCI_HCD is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_UHCI_HCD is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_SL811_HCD is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># USB Device Class drivers</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_ACM is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_PRINTER is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># NOTE: USB_STORAGE enables SCSI, and
'SCSI disk support'</font>
<br><font size=2 face="sans-serif">#</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># may also be needed; see USB_STORAGE
Help for more information</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_USB_STORAGE=y</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_STORAGE_DEBUG is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_STORAGE_FREECOM is not
set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_STORAGE_DPCM is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_STORAGE_KARMA is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_LIBUSUAL is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># USB Input Devices</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_HID is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># USB HID Boot Protocol drivers</font>
<br><font size=2 face="sans-serif">#</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># USB Imaging devices</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_MICROTEK is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># USB Network Adapters</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_KAWETH is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_PEGASUS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_USBNET_MII is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_USBNET is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_MON is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># USB port drivers</font>
<br><font size=2 face="sans-serif">#</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># USB Serial Converter support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_SERIAL is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># USB Miscellaneous drivers</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_EMI62 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_EMI26 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_LCD is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_LED is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_CYPRESS_CY7C63 is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_CYTHERM is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_PHIDGET is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_IDMOUSE is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_FTDI_ELAN is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_APPLEDISPLAY is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_SISUSBVGA is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_LD is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_TRANCEVIBRATOR is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># USB DSL modem support</font>
<br><font size=2 face="sans-serif">#</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># USB Gadget Support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_USB_GADGET is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># MMC/SD Card support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_MMC is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># LED devices</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_NEW_LEDS is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># LED drivers</font>
<br><font size=2 face="sans-serif">#</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># LED Triggers</font>
<br><font size=2 face="sans-serif">#</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># InfiniBand support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_INFINIBAND is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># EDAC - error detection and reporting
(RAS) (EXPERIMENTAL)</font>
<br><font size=2 face="sans-serif">#</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Real Time Clock</font>
<br><font size=2 face="sans-serif">#</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># DMA Engine support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_DMA_ENGINE is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># DMA Clients</font>
<br><font size=2 face="sans-serif">#</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># DMA Devices</font>
<br><font size=2 face="sans-serif">#</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># File systems</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_EXT2_FS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_EXT3_FS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_REISERFS_FS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_JFS_FS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_FS_POSIX_ACL is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_XFS_FS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_OCFS2_FS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_MINIX_FS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_ROMFS_FS is not set</font>
<br><font size=2 face="sans-serif">CONFIG_INOTIFY=y</font>
<br><font size=2 face="sans-serif">CONFIG_INOTIFY_USER=y</font>
<br><font size=2 face="sans-serif"># CONFIG_QUOTA is not set</font>
<br><font size=2 face="sans-serif">CONFIG_DNOTIFY=y</font>
<br><font size=2 face="sans-serif"># CONFIG_AUTOFS_FS is not set</font>
<br><font size=2 face="sans-serif">CONFIG_AUTOFS4_FS=y</font>
<br><font size=2 face="sans-serif"># CONFIG_FUSE_FS is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CD-ROM/DVD Filesystems</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_ISO9660_FS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_UDF_FS is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># DOS/FAT/NT Filesystems</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_FAT_FS=y</font>
<br><font size=2 face="sans-serif">CONFIG_MSDOS_FS=y</font>
<br><font size=2 face="sans-serif">CONFIG_VFAT_FS=y</font>
<br><font size=2 face="sans-serif">CONFIG_FAT_DEFAULT_CODEPAGE=437</font>
<br><font size=2 face="sans-serif">CONFIG_FAT_DEFAULT_IOCHARSET=&quot;iso8859-1&quot;</font>
<br><font size=2 face="sans-serif"># CONFIG_NTFS_FS is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Pseudo filesystems</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_PROC_FS=y</font>
<br><font size=2 face="sans-serif">CONFIG_PROC_KCORE=y</font>
<br><font size=2 face="sans-serif">CONFIG_PROC_SYSCTL=y</font>
<br><font size=2 face="sans-serif">CONFIG_SYSFS=y</font>
<br><font size=2 face="sans-serif">CONFIG_TMPFS=y</font>
<br><font size=2 face="sans-serif"># CONFIG_TMPFS_POSIX_ACL is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_HUGETLB_PAGE is not set</font>
<br><font size=2 face="sans-serif">CONFIG_RAMFS=y</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Miscellaneous filesystems</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_HFSPLUS_FS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_JFFS_FS is not set</font>
<br><font size=2 face="sans-serif">CONFIG_JFFS2_FS=y</font>
<br><font size=2 face="sans-serif">CONFIG_JFFS2_FS_DEBUG=0</font>
<br><font size=2 face="sans-serif">CONFIG_JFFS2_FS_WRITEBUFFER=y</font>
<br><font size=2 face="sans-serif">CONFIG_JFFS2_COMPRESSION_OPTIONS=y</font>
<br><font size=2 face="sans-serif">CONFIG_JFFS2_ZLIB=y</font>
<br><font size=2 face="sans-serif">CONFIG_JFFS2_RTIME=y</font>
<br><font size=2 face="sans-serif">CONFIG_JFFS2_RUBIN=y</font>
<br><font size=2 face="sans-serif"># CONFIG_JFFS2_CMODE_NONE is not set</font>
<br><font size=2 face="sans-serif">CONFIG_JFFS2_CMODE_PRIORITY=y</font>
<br><font size=2 face="sans-serif"># CONFIG_JFFS2_CMODE_SIZE is not set</font>
<br><font size=2 face="sans-serif">CONFIG_CRAMFS=y</font>
<br><font size=2 face="sans-serif"># CONFIG_VXFS_FS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_HPFS_FS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_QNX4FS_FS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SYSV_FS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_UFS_FS is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Network File Systems</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_NFS_FS=y</font>
<br><font size=2 face="sans-serif">CONFIG_NFS_V3=y</font>
<br><font size=2 face="sans-serif"># CONFIG_NFS_V3_ACL is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_NFS_DIRECTIO is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_NFSD is not set</font>
<br><font size=2 face="sans-serif">CONFIG_ROOT_NFS=y</font>
<br><font size=2 face="sans-serif">CONFIG_LOCKD=y</font>
<br><font size=2 face="sans-serif">CONFIG_LOCKD_V4=y</font>
<br><font size=2 face="sans-serif">CONFIG_NFS_COMMON=y</font>
<br><font size=2 face="sans-serif">CONFIG_SUNRPC=y</font>
<br><font size=2 face="sans-serif"># CONFIG_SMB_FS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_CIFS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_NCP_FS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_CODA_FS is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Partition Types</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_PARTITION_ADVANCED is not set</font>
<br><font size=2 face="sans-serif">CONFIG_MSDOS_PARTITION=y</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Native Language Support</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif">CONFIG_NLS=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_DEFAULT=&quot;iso8859-1&quot;</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_437=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_737=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_775=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_850=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_852=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_855=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_857=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_860=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_861=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_862=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_863=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_864=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_865=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_866=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_869=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_936=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_950=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_932=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_949=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_874=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_ISO8859_8=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_1250=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_CODEPAGE_1251=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_ASCII=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_ISO8859_1=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_ISO8859_2=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_ISO8859_3=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_ISO8859_4=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_ISO8859_5=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_ISO8859_6=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_ISO8859_7=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_ISO8859_9=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_ISO8859_13=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_ISO8859_14=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_ISO8859_15=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_KOI8_R=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_KOI8_U=y</font>
<br><font size=2 face="sans-serif">CONFIG_NLS_UTF8=y</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Library routines</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_CRC_CCITT is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_CRC16 is not set</font>
<br><font size=2 face="sans-serif">CONFIG_CRC32=y</font>
<br><font size=2 face="sans-serif"># CONFIG_LIBCRC32C is not set</font>
<br><font size=2 face="sans-serif">CONFIG_ZLIB_INFLATE=y</font>
<br><font size=2 face="sans-serif">CONFIG_ZLIB_DEFLATE=y</font>
<br><font size=2 face="sans-serif">CONFIG_PLIST=y</font>
<br><font size=2 face="sans-serif">CONFIG_PROFILING=y</font>
<br><font size=2 face="sans-serif">CONFIG_OPROFILE=y</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Kernel hacking</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_PRINTK_TIME is not set</font>
<br><font size=2 face="sans-serif">CONFIG_ENABLE_MUST_CHECK=y</font>
<br><font size=2 face="sans-serif"># CONFIG_MAGIC_SYSRQ is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_UNUSED_SYMBOLS is not set</font>
<br><font size=2 face="sans-serif">CONFIG_DEBUG_KERNEL=y</font>
<br><font size=2 face="sans-serif">CONFIG_LOG_BUF_SHIFT=14</font>
<br><font size=2 face="sans-serif">CONFIG_DETECT_SOFTLOCKUP=y</font>
<br><font size=2 face="sans-serif"># CONFIG_SCHEDSTATS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_DEBUG_SLAB is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_DEBUG_RT_MUTEXES is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_RT_MUTEX_TESTER is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_DEBUG_SPINLOCK is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_DEBUG_MUTEXES is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_DEBUG_RWSEMS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_DEBUG_SPINLOCK_SLEEP is not
set</font>
<br><font size=2 face="sans-serif"># CONFIG_DEBUG_LOCKING_API_SELFTESTS
is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_DEBUG_KOBJECT is not set</font>
<br><font size=2 face="sans-serif">CONFIG_DEBUG_INFO=y</font>
<br><font size=2 face="sans-serif"># CONFIG_DEBUG_FS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_DEBUG_VM is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_DEBUG_LIST is not set</font>
<br><font size=2 face="sans-serif">CONFIG_FORCED_INLINING=y</font>
<br><font size=2 face="sans-serif"># CONFIG_HEADERS_CHECK is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_RCU_TORTURE_TEST is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_KGDB is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_XMON is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_BDI_SWITCH is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SERIAL_TEXT_DEBUG is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_ICE_DEBUG is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Security options</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_KEYS is not set</font>
<br><font size=2 face="sans-serif"># CONFIG_SECURITY is not set</font>
<br>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># Cryptographic options</font>
<br><font size=2 face="sans-serif">#</font>
<br><font size=2 face="sans-serif"># CONFIG_CRYPTO is not set</font></table>
<br>
<br><font size=2 face="sans-serif">Best Regards!</font>
--=_alternative 0023B19948257574_=--
