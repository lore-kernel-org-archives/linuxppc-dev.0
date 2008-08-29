Return-Path: <Agostino.Sette@technolabs.it>
Received: from smtp.technolabs.it
	(host20-155-static.82-213-b.business.telecomitalia.it
	[213.82.155.20]) by ozlabs.org (Postfix) with ESMTP id 004F0DE0B6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Aug 2008 01:43:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: MPC8568MDS RAMDISK Problem
Date: Fri, 29 Aug 2008 17:31:13 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E01000F98@aquib01a>
In-Reply-To: <48B71D04.4080805@embedded-sol.com>
From: "SETTE AGOSTINO - technolabs" <Agostino.Sette@technolabs.it>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I am trying to port a RAMDISK Filesystem on the MPC8568MDS board but I
have the following problem:
U-Boot 1.3.0-rc3 (Nov 23 2007 - 18:17:06)

CPU:   8568_E, Version: 1.1, (0x807d0011)
Core:  E500, Version: 2.2, (0x80210022)
Clock Configuration:
       CPU:1320 MHz, CCB: 528 MHz,
       DDR: 264 MHz, LBC: 132 MHz
L1:    D-cache 32 kB enabled
       I-cache 32 kB enabled
Board: 8568 MDS
I2C:   ready
DRAM:  Initializing
    SDRAM: 64 MB
    DDR: 512 MB
FLASH: 32 MB
L2 cache 512KB: enabled
    PCI: 32 bit, 66 MHz, async, host, arbiter
               Scanning PCI bus 00
PCI on bus 00 - 00

    PCIE connected to slot as Root Complex (base address e000a000)
PCIE on bus 01 - 01
In:    serial
Out:   serial
Err:   serial
Net:   UEC: PHY is Marvell 88E11x1 (1410cc2)
UEC: PHY is Marvell 88E11x1 (1410cc2)
eTSEC0, eTSEC1, FSL UEC0, FSL UEC1
Hit any key to stop autoboot:  0

## Checking Image at 02000100 ...
   Image Name:   Linux-2.6.25.5
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1325906 Bytes =3D  1.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Booting image at 02000100 ...
   Image Name:   Linux-2.6.25.5
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1325906 Bytes =3D  1.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 02200100 ...
   Image Name:   initrd
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    3658144 Bytes =3D  3.5 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Booting using the fdt at 0x21f0100
   Loading Ramdisk to 00482000, end 007ff1a0 ... OK
   Loading Device Tree to 007fa000, end 007fcfff ... OK
Using MPC85xx MDS machine description
Memory CAM mapping: CAM0=3D16Mb, CAM1=3D16Mb, CAM2=3D16Mb residual: 15Mb
Linux version 2.6.25.5 (ity10223@aqlbl05x) (gcc version 4.2.2) #1 Fri
Aug 29 16:44:02 CEST 2008
Found legacy serial port 0 for /soc8568@e0000000/serial@4500
  mem=3De0004500, taddr=3De0004500, irq=3D0, clk=3D528000000, speed=3D0
Found legacy serial port 1 for /soc8568@e0000000/serial@4600
  mem=3De0004600, taddr=3De0004600, irq=3D0, clk=3D528000000, speed=3D0
console [udbg0] enabled
Entering add_active_range(0, 0, 12288) 0 entries of 256 used
setup_arch: bootmem
mpc85xx_mds_setup_arch()
Found FSL PCI host bridge at 0x00000000e0008000. Firmware bus number:
0->0
PCI host bridge /soc8568@e0000000/pci@8000 (primary) ranges:
Found FSL PCI host bridge at 0x00000000e000a000. Firmware bus number:
0->0
PCI host bridge /soc8568@e0000000/pcie@a000  ranges:
arch: exit
Top of RAM: 0x3000000, Total RAM: 0x3000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA             0 ->    12288
  Normal      12288 ->    12288
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->    12288
On node 0 totalpages: 12288
  DMA zone: 96 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 12192 pages, LIFO batch:1
  Normal zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
12192
Kernel command line:
mtdparts=3Dphysmap-flash.0:1M(boot),7M(aps0),7M(aps1),1M(optusr)
console=3DttyS0,115200 root=3D/dev/ram ramdisk_size=3D500000 rw =
ip=3D192.168.0.1
26:192.168.0.33:192.168.1.1:255.255.255.0:MPC8568MDS:eth0:off panic=3D1
mem=3D0x3f00000 aps=3D0
mpic: Setting up MPIC " OpenPIC  " version 1.2 at e0040000, max 1 CPUs
mpic: ISU size: 80, shift: 7, mask: 7f
mpic: Initializing for 80 sources
PID hash table entries: 256 (order: 8, 1024 bytes)
time_init: decrementer frequency =3D 66.000000 MHz
time_init: processor frequency   =3D 1320.000000 MHz
clocksource: timebase mult[3c9b26d] shift[22] registered
clockevent: decrementer mult[10e5] shift[16] cpu[0]
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 42240k/49152k available (2632k kernel code, 6892k reserved, 104k
data, 96k bss, 128k init)
SLUB: Genslabs=3D12, HWalign=3D32, Order=3D0-1, MinObjects=3D4, =
CPUs=3D1, Nodes=3D1
Calibrating delay loop... 131.58 BogoMIPS (lpj=3D263168)
Mount-cache hash table entries: 512
net_namespace: 152 bytes
NET: Registered protocol family 16

PCI: Probing PCI hardware
Memory resource not set for host bridge 0
PCI: 0001:01:00.0: class b20 doesn't match header type 01. Ignoring
class.
Memory resource not set for host bridge 1
PCI: Closing bogus Apple Firmware region 1 on bus 0x02
PCI: Closing bogus Apple Firmware region 2 on bus 0x02
PCI: Bridge: 0001:01:00.0
  IO window: 0000-ffffffff
  MEM window: 0x00000000-0xffffffff
  PREFETCH window: disabled.
PCI: Enabling device 0001:01:00.0 (0106 -> 0107)
Registering qe_ic with sysfs...
SCSI subsystem initialized
NET: Registered protocol family 2
Switched to high resolution mode on CPU 0
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq =3D 42) is a 16550A
                                                             console
handover: boot [udbg0] -> real [ttyS0]
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq =3D 42) is a 16550A
brd: module loaded
loop: module loaded
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2, 00:e0:0c:00:00:fd
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2, 00:e0:0c:00:01:fd
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
i2c /dev entries driver
rtc-ds1374 0-0068: rtc core: registered rtc-ds1374 as rtc0
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
rtc-ds1374 0-0068: setting system clock to 1970-07-19 01:19:19 UTC
(17198359)
IP-Config: Gateway not on directly connected network.
List of all partitions:
0100     500000 ram0 (driver?)
0101     500000 ram1 (driver?)
0102     500000 ram2 (driver?)
0103     500000 ram3 (driver?)
0104     500000 ram4 (driver?)
0105     500000 ram5 (driver?)
0106     500000 ram6 (driver?)
0107     500000 ram7 (driver?)
0108     500000 ram8 (driver?)
0109     500000 ram9 (driver?)
010a     500000 ram10 (driver?)
010b     500000 ram11 (driver?)
010c     500000 ram12 (driver?)
010d     500000 ram13 (driver?)
010e     500000 ram14 (driver?)
010f     500000 ram15 (driver?)
No filesystem could mount root, tried:  ext3 ext2
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(1,0)
Rebooting in 1 seconds..

The U-Boot is quite old but is what I found on the board, I just change
the envirinment variables

ramboot=3Drun ramargs;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr
$bootfile;bootm $loadaddr $ramdiskaddr
nfsboot=3Drun nfsargs;tftp $loadaddr $bootfile;tftp $fdtaddr
$fdtfile;bootm $loadaddr - $fdtaddr
bootdelay=3D10
baudrate=3D115200
loads_echo=3D1
ethaddr=3D00:E0:0C:00:00:FD
eth1addr=3D00:E0:0C:00:01:FD
eth2addr=3D00:E0:0C:00:02:FD
eth3addr=3D00:E0:0C:00:03:FD
rootpath=3D/nfsroot
bootfile=3Dyour.uImage
netdev=3Deth0
consoledev=3DttyS0
ramdiskaddr=3D600000
ramdiskfile=3Dyour.ramdisk.u-boot
fdtaddr=3D400000
fdtfile=3Dyour.fdt.dtb
nfsargs=3Dsetenv bootargs root=3D/dev/nfs rw =
nfsroot=3D$serverip:$rootpath
ip=3D$ipaddr:$serverip:$gatewayip:$netmask:$hostname:$netdev:off
console=3D$consoledev,$bau
drate $othbootargs
ramargs=3Dsetenv bootargs root=3D/dev/ram rw =
console=3D$consoledev,$baudrate
$othbootargs
bootargs=3Droot=3D/dev/ram rw console=3DttyS0,115200
bootcmdAQ=3Dif itest ${aps} =3D=3D 0; then run dl_ram0; else run =
dl_ram1;fi
ethact=3DeTSEC0
filesize=3D4E0E64
fileaddr=3D2000000
gatewayip=3D192.168.1.1
netmask=3D255.255.255.0
ipaddr=3D192.168.0.126
serverip=3D192.168.0.33
bootcmdFREE=3Drun ramargs;cp.b fff00000 400000 3500;bootm ff800000
ffa00000 400000
myaps=3DMPC8568MDS/aps
mtdargs=3Dmtdparts=3Dphysmap-flash.0:1M(boot),7M(aps0),7M(aps1),1M(optusr=
)
pram=3D0x100000
mem=3D0x3f00000
pram_start=3D0x3f00000
loadaddr=3D0x2000000
aps0_fl_start=3D0xfe100000
aps0_fl_size=3D0x00700000
aps1_fl_start=3D0xfe800000
aps1_fl_end=3D0xfeefffff
aps1_fl_size=3D0x00700000
aps_ram_start=3D0x2000000
aps_ram_kernel_start=3D0x2000100
aps_ram_dtb_start=3D0x21f0100
aps_ram_rootfs_start=3D0x2200100
aps=3D0
dl_boot=3Dtftp ${aps_ram_start} "u-boot.bin" && protect off 0xfe000000
0xfe07ffff && cp.b ${aps_ram_start} 0xfe000000 ${filesize} && protect on
0xfe000000 0xf
e07ffff && saveenv
bootcmd=3Dif itest ${aps} =3D=3D 0; then run dl_ram0; else run =
dl_ram1;fi
altbootcmd=3Dmw.b ${pram_start} 0 ${pram} && if itest ${aps} =3D=3D 0; =
then
setenv aps 1; else setenv aps 0; fi; saveenv; run bootcmd
dl_ram0=3Dcp.b ${aps0_fl_start} ${aps_ram_start} ${aps0_fl_size};if imi
${aps_ram_kernel_start}; then run bargs;bootm ${aps_ram_kernel_start}
${aps_ram_rootfs
_start} ${aps_ram_dtb_start}; else reset; fi
dl_ram1=3Dcp.b ${aps1_fl_start} ${aps_ram_start} ${aps1_fl_size};if imi
${aps_ram_kernel_start}; then run bargs;bootm ${aps_ram_kernel_start}
${aps_ram_rootfs
_start} ${aps_ram_dtb_start}; else reset; fi
bootlimit=3D5
initrd_high=3Dno
hostname=3DMPC8568MDS
aps0_fl_end=3D0xfe7fffff
dl_aps0=3Dtftp ${aps_ram_start} ${myaps};erase ${aps0_fl_start}
${aps0_fl_end};cp.b ${aps_ram_start} ${aps0_fl_start} ${filesize};boot
dl_aps1=3Dtftp ${aps_ram_start} ${myaps};erase ${aps1_fl_start}
${aps1_fl_end};cp.b ${aps_ram_start} ${aps1_fl_start} ${filesize};boot
bargs=3Dsetenv bootargs ${mtdargs} console=3DttyS0,$baudrate =
root=3D/dev/ram
ramdisk_size=3D500000 rw
ip=3D${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:e
th0:off panic=3D1 mem=3D${mem} aps=3D${aps} ${misc} ${slram}
stdin=3Dserial
stdout=3Dserial
stderr=3Dserial

Environment size: 2857/8188 bytes

I am using linux2.6.25-denx with the followind mpc8568mds_defconfig

>> cat kernel/linux/arch/powerpc/configs/mpc8568mds_defconfig
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.25.5
# Fri Aug 29 16:33:50 2008
#
# CONFIG_PPC64 is not set

#
# Processor support
#
# CONFIG_6xx is not set
CONFIG_PPC_85xx=3Dy
# CONFIG_PPC_8xx is not set
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_E200 is not set
CONFIG_E500=3Dy
CONFIG_BOOKE=3Dy
CONFIG_FSL_BOOKE=3Dy
CONFIG_FSL_EMB_PERFMON=3Dy
# CONFIG_PHYS_64BIT is not set
CONFIG_SPE=3Dy
# CONFIG_PPC_MM_SLICES is not set
CONFIG_PPC32=3Dy
CONFIG_WORD_SIZE=3D32
CONFIG_PPC_MERGE=3Dy
CONFIG_MMU=3Dy
CONFIG_GENERIC_CMOS_UPDATE=3Dy
CONFIG_GENERIC_TIME=3Dy
CONFIG_GENERIC_TIME_VSYSCALL=3Dy
CONFIG_GENERIC_CLOCKEVENTS=3Dy
CONFIG_GENERIC_HARDIRQS=3Dy
# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
CONFIG_IRQ_PER_CPU=3Dy
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_ARCH_HAS_ILOG2_U32=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_GENERIC_FIND_NEXT_BIT=3Dy
# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
CONFIG_PPC=3Dy
CONFIG_EARLY_PRINTK=3Dy
CONFIG_GENERIC_NVRAM=3Dy
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
CONFIG_PPC_OF=3Dy
CONFIG_OF=3Dy
CONFIG_PPC_UDBG_16550=3Dy
# CONFIG_GENERIC_TBSYNC is not set
CONFIG_AUDIT_ARCH=3Dy
CONFIG_GENERIC_BUG=3Dy
CONFIG_DEFAULT_UIMAGE=3Dy
# CONFIG_PPC_DCR_NATIVE is not set
# CONFIG_PPC_DCR_MMIO is not set
CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"

#
# General setup
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32
CONFIG_LOCALVERSION=3D""
CONFIG_LOCALVERSION_AUTO=3Dy
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_SYSVIPC_SYSCTL=3Dy
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_AUDIT is not set
# CONFIG_IKCONFIG is not set
CONFIG_LOG_BUF_SHIFT=3D14
# CONFIG_CGROUPS is not set
CONFIG_GROUP_SCHED=3Dy
# CONFIG_FAIR_GROUP_SCHED is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_USER_SCHED=3Dy
# CONFIG_CGROUP_SCHED is not set
CONFIG_SYSFS_DEPRECATED=3Dy
CONFIG_SYSFS_DEPRECATED_V2=3Dy
# CONFIG_RELAY is not set
# CONFIG_NAMESPACES is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=3Dy
CONFIG_EMBEDDED=3Dy
CONFIG_SYSCTL_SYSCALL=3Dy
# CONFIG_KALLSYMS is not set
CONFIG_HOTPLUG=3Dy
CONFIG_PRINTK=3Dy
# CONFIG_LOGBUFFER is not set
CONFIG_BUG=3Dy
CONFIG_ELF_CORE=3Dy
CONFIG_COMPAT_BRK=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_ANON_INODES=3Dy
# CONFIG_EPOLL is not set
CONFIG_SIGNALFD=3Dy
CONFIG_TIMERFD=3Dy
CONFIG_EVENTFD=3Dy
CONFIG_SHMEM=3Dy
CONFIG_VM_EVENT_COUNTERS=3Dy
CONFIG_SLUB_DEBUG=3Dy
# CONFIG_SLAB is not set
CONFIG_SLUB=3Dy
# CONFIG_SLOB is not set
# CONFIG_PROFILING is not set
# CONFIG_MARKERS is not set
CONFIG_HAVE_OPROFILE=3Dy
CONFIG_HAVE_KPROBES=3Dy
CONFIG_HAVE_KRETPROBES=3Dy
CONFIG_PROC_PAGE_MONITOR=3Dy
CONFIG_SLABINFO=3Dy
CONFIG_RT_MUTEXES=3Dy
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=3D0
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_KMOD is not set
CONFIG_BLOCK=3Dy
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set
# CONFIG_BLK_DEV_BSG is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
CONFIG_DEFAULT_AS=3Dy
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"anticipatory"
CONFIG_CLASSIC_RCU=3Dy

#
# Platform support
#
# CONFIG_PPC_MPC512x is not set
# CONFIG_PPC_MPC5121 is not set
# CONFIG_PPC_CELL is not set
# CONFIG_PPC_CELL_NATIVE is not set
# CONFIG_PQ2ADS is not set
CONFIG_MPC85xx=3Dy
# CONFIG_MPC8540_ADS is not set
# CONFIG_MPC8560_ADS is not set
# CONFIG_MPC85xx_CDS is not set
CONFIG_MPC85xx_MDS=3Dy
# CONFIG_MPC85xx_DS is not set
# CONFIG_STX_GP3 is not set
# CONFIG_TQM8540 is not set
# CONFIG_TQM8541 is not set
# CONFIG_TQM8555 is not set
# CONFIG_TQM8560 is not set
# CONFIG_SBC8548 is not set
# CONFIG_SBC8560 is not set
# CONFIG_IPIC is not set
CONFIG_MPIC=3Dy
# CONFIG_MPIC_WEIRD is not set
# CONFIG_PPC_I8259 is not set
# CONFIG_PPC_RTAS is not set
# CONFIG_MMIO_NVRAM is not set
# CONFIG_PPC_MPC106 is not set
# CONFIG_PPC_970_NAP is not set
# CONFIG_PPC_INDIRECT_IO is not set
# CONFIG_GENERIC_IOMAP is not set
# CONFIG_CPU_FREQ is not set
CONFIG_QUICC_ENGINE=3Dy
# CONFIG_CPM2 is not set
# CONFIG_FSL_ULI1575 is not set

#
# Kernel options
#
# CONFIG_HIGHMEM is not set
CONFIG_TICK_ONESHOT=3Dy
CONFIG_NO_HZ=3Dy
CONFIG_HIGH_RES_TIMERS=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=3Dy
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=3D250
# CONFIG_SCHED_HRTICK is not set
CONFIG_PREEMPT_NONE=3Dy
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_BINFMT_ELF=3Dy
# CONFIG_BINFMT_MISC is not set
CONFIG_MATH_EMULATION=3Dy
# CONFIG_IOMMU_HELPER is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
CONFIG_ARCH_HAS_WALK_MEMORY=3Dy
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=3Dy
CONFIG_ARCH_FLATMEM_ENABLE=3Dy
CONFIG_ARCH_POPULATES_NODE_MAP=3Dy
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_FLATMEM_MANUAL=3Dy
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=3Dy
CONFIG_FLAT_NODE_MEM_MAP=3Dy
# CONFIG_SPARSEMEM_STATIC is not set
# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
CONFIG_SPLIT_PTLOCK_CPUS=3D4
# CONFIG_RESOURCES_64BIT is not set
CONFIG_ZONE_DMA_FLAG=3D1
CONFIG_BOUNCE=3Dy
CONFIG_VIRT_TO_BUS=3Dy
CONFIG_PROC_DEVICETREE=3Dy
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_PM is not set
CONFIG_SECCOMP=3Dy
CONFIG_ISA_DMA_API=3Dy

#
# Bus options
#
CONFIG_ZONE_DMA=3Dy
CONFIG_PPC_INDIRECT_PCI=3Dy
CONFIG_FSL_SOC=3Dy
CONFIG_FSL_PCI=3Dy
CONFIG_PCI=3Dy
CONFIG_PCI_DOMAINS=3Dy
CONFIG_PCI_SYSCALL=3Dy
# CONFIG_PCIEPORTBUS is not set
CONFIG_ARCH_SUPPORTS_MSI=3Dy
# CONFIG_PCI_MSI is not set
CONFIG_PCI_LEGACY=3Dy
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCCARD is not set
# CONFIG_HOTPLUG_PCI is not set

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
CONFIG_TASK_SIZE=3D0xc0000000
CONFIG_BOOT_LOAD=3D0x00800000

#
# Networking
#
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=3Dy
CONFIG_XFRM=3Dy
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=3Dy
CONFIG_IP_PNP=3Dy
CONFIG_IP_PNP_DHCP=3Dy
CONFIG_IP_PNP_BOOTP=3Dy
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=3Dy
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_XFRM_MODE_TRANSPORT=3Dy
CONFIG_INET_XFRM_MODE_TUNNEL=3Dy
CONFIG_INET_XFRM_MODE_BEET=3Dy
# CONFIG_INET_LRO is not set
CONFIG_INET_DIAG=3Dy
CONFIG_INET_TCP_DIAG=3Dy
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=3Dy
CONFIG_DEFAULT_TCP_CONG=3D"cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set

#
# Wireless
#
# CONFIG_CFG80211 is not set
# CONFIG_WIRELESS_EXT is not set
# CONFIG_MAC80211 is not set
# CONFIG_IEEE80211 is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
CONFIG_OF_DEVICE=3Dy
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=3Dy
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dy
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_COUNT=3D16
CONFIG_BLK_DEV_RAM_SIZE=3D32768
# CONFIG_BLK_DEV_XIP is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_MISC_DEVICES=3Dy
# CONFIG_PHANTOM is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ENCLOSURE_SERVICES is not set
CONFIG_HAVE_IDE=3Dy
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=3Dy
CONFIG_SCSI_DMA=3Dy
# CONFIG_SCSI_TGT is not set
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_PROC_FS=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
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
# CONFIG_SCSI_SCAN_ASYNC is not set
CONFIG_SCSI_WAIT_SCAN=3Dm

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
CONFIG_SCSI_LOWLEVEL=3Dy
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
# CONFIG_SCSI_ADVANSYS is not set
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
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_SRP is not set
# CONFIG_ATA is not set
# CONFIG_MD is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_IEEE1394 is not set
# CONFIG_I2O is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=3Dy
# CONFIG_NETDEVICES_MULTIQUEUE is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_VETH is not set
# CONFIG_ARCNET is not set
CONFIG_PHYLIB=3Dy

#
# MII PHY device drivers
#
CONFIG_MARVELL_PHY=3Dy
# CONFIG_DAVICOM_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_FIXED_PHY is not set
# CONFIG_MDIO_BITBANG is not set
CONFIG_NET_ETHERNET=3Dy
CONFIG_MII=3Dy
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_IBM_NEW_EMAC_ZMII is not set
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
# CONFIG_NET_PCI is not set
# CONFIG_B44 is not set
CONFIG_NETDEV_1000=3Dy
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_E1000E is not set
# CONFIG_E1000E_ENABLED is not set
# CONFIG_IP1000 is not set
# CONFIG_IGB is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set
CONFIG_GIANFAR=3Dy
CONFIG_GFAR_NAPI=3Dy
# CONFIG_UCC_GETH is not set
# CONFIG_QLA3XXX is not set
# CONFIG_ATL1 is not set
CONFIG_NETDEV_10000=3Dy
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set
# CONFIG_MYRI10GE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_NIU is not set
# CONFIG_MLX4_CORE is not set
# CONFIG_TEHUTI is not set
# CONFIG_BNX2X is not set
# CONFIG_TR is not set

#
# Wireless LAN
#
# CONFIG_WLAN_PRE80211 is not set
# CONFIG_WLAN_80211 is not set
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_ISDN is not set
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=3Dy
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
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
# CONFIG_NOZOMI is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
CONFIG_SERIAL_8250_PCI=3Dy
CONFIG_SERIAL_8250_NR_UARTS=3D4
CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_SHARE_IRQ=3Dy

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_OF_PLATFORM is not set
# CONFIG_SERIAL_QE is not set
CONFIG_UNIX98_PTYS=3Dy
CONFIG_LEGACY_PTYS=3Dy
CONFIG_LEGACY_PTY_COUNT=3D256
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=3Dy
# CONFIG_NVRAM is not set
# CONFIG_GEN_RTC is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_TCG_TPM is not set
CONFIG_DEVPORT=3Dy
CONFIG_I2C=3Dy
CONFIG_I2C_BOARDINFO=3Dy
CONFIG_I2C_CHARDEV=3Dy

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
# CONFIG_I2C_IBM_OF is not set
CONFIG_I2C_MPC=3Dy
# CONFIG_I2C_MPC8260 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_24C01A is not set
# CONFIG_SENSORS_AD7416 is not set
# CONFIG_DS1682 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_MAX6900 is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_PCF8575 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_TPS65010 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
CONFIG_HWMON=3Dy
# CONFIG_HWMON_VID is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7473 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_FM75 is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
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
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1115 is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_HWMON_DEBUG_CHIP is not set
# CONFIG_THERMAL is not set
CONFIG_WATCHDOG=3Dy
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
# CONFIG_WD is not set
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_BOOKE_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# Sonics Silicon Backplane
#
CONFIG_SSB_POSSIBLE=3Dy
# CONFIG_SSB is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_SM501 is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DVB_CORE is not set
CONFIG_DAB=3Dy

#
# Graphics support
#
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_VGASTATE is not set
CONFIG_VIDEO_OUTPUT_CONTROL=3Dm
# CONFIG_FB is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Display device support
#
# CONFIG_DISPLAY_SUPPORT is not set

#
# Sound
#
# CONFIG_SOUND is not set
CONFIG_HID_SUPPORT=3Dy
CONFIG_HID=3Dy
# CONFIG_HID_DEBUG is not set
# CONFIG_HIDRAW is not set
CONFIG_USB_SUPPORT=3Dy
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy
CONFIG_USB_ARCH_HAS_EHCI=3Dy
# CONFIG_USB is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#
# CONFIG_USB_GADGET is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_INFINIBAND is not set
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=3Dy
CONFIG_RTC_CLASS=3Dy
CONFIG_RTC_HCTOSYS=3Dy
CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=3Dy
CONFIG_RTC_INTF_PROC=3Dy
CONFIG_RTC_INTF_DEV=3Dy
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=3Dy
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_S35390A is not set

#
# SPI RTC drivers
#

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#
# CONFIG_DMADEVICES is not set

#
# Userspace I/O
#
# CONFIG_UIO is not set

#
# File systems
#
CONFIG_EXT2_FS=3Dy
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=3Dy
CONFIG_EXT3_FS_XATTR=3Dy
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
# CONFIG_EXT4DEV_FS is not set
CONFIG_JBD=3Dy
CONFIG_FS_MBCACHE=3Dy
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_DNOTIFY=3Dy
CONFIG_INOTIFY=3Dy
CONFIG_INOTIFY_USER=3Dy
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

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
CONFIG_PROC_SYSCTL=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_CONFIGFS_FS is not set

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
# CONFIG_MINIX_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=3Dy
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=3Dy
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_NFSD is not set
CONFIG_ROOT_NFS=3Dy
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
CONFIG_NFS_COMMON=3Dy
CONFIG_SUNRPC=3Dy
CONFIG_SUNRPC_GSS=3Dy
# CONFIG_SUNRPC_BIND34 is not set
CONFIG_RPCSEC_GSS_KRB5=3Dy
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
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
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_NLS is not set
# CONFIG_DLM is not set

#
# Library routines
#
CONFIG_BITREVERSE=3Dy
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=3Dy
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
CONFIG_PLIST=3Dy
CONFIG_HAS_IOMEM=3Dy
CONFIG_HAS_IOPORT=3Dy
CONFIG_HAS_DMA=3Dy

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_WARN_DEPRECATED=3Dy
CONFIG_ENABLE_MUST_CHECK=3Dy
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
CONFIG_DEBUG_KERNEL=3Dy
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_DETECT_SOFTLOCKUP=3Dy
CONFIG_SCHED_DEBUG=3Dy
# CONFIG_SCHEDSTATS is not set
# CONFIG_TIMER_STATS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_BUGVERBOSE is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_SAMPLES is not set
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_DEBUGGER=3Dy
# CONFIG_XMON is not set
# CONFIG_BDI_SWITCH is not set
CONFIG_PPC_EARLY_DEBUG=3Dy
# CONFIG_PPC_EARLY_DEBUG_LPAR is not set
# CONFIG_PPC_EARLY_DEBUG_G5 is not set
# CONFIG_PPC_EARLY_DEBUG_RTAS_PANEL is not set
# CONFIG_PPC_EARLY_DEBUG_RTAS_CONSOLE is not set
# CONFIG_PPC_EARLY_DEBUG_MAPLE is not set
# CONFIG_PPC_EARLY_DEBUG_ISERIES is not set
# CONFIG_PPC_EARLY_DEBUG_PAS_REALMODE is not set
# CONFIG_PPC_EARLY_DEBUG_BEAT is not set
# CONFIG_PPC_EARLY_DEBUG_44x is not set
# CONFIG_PPC_EARLY_DEBUG_40x is not set
# CONFIG_PPC_EARLY_DEBUG_CPM is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITY_FILE_CAPABILITIES is not set
CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_ALGAPI=3Dy
CONFIG_CRYPTO_BLKCIPHER=3Dy
# CONFIG_CRYPTO_SEQIV is not set
CONFIG_CRYPTO_MANAGER=3Dy
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=3Dy
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_GF128MUL is not set
CONFIG_CRYPTO_ECB=3Dm
CONFIG_CRYPTO_CBC=3Dy
CONFIG_CRYPTO_PCBC=3Dm
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_XTS is not set
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_DES=3Dy
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_TEST is not set
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_LZO is not set
CONFIG_CRYPTO_HW=3Dy
# CONFIG_CRYPTO_DEV_HIFN_795X is not set
# CONFIG_PPC_CLOCK is not set
CONFIG_PPC_LIB_RHEAP=3Dy

Does anyone know this problem?

Thanks in advance

Agostino Sette
