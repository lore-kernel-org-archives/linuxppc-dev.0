Return-Path: <bhupi.saharan@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 711F5DDF8F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Aug 2008 04:03:28 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so517829yxg.39
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Aug 2008 11:03:27 -0700 (PDT)
Message-ID: <720399a30808291103p4fb65f4ei5590f4c13b6ce076@mail.gmail.com>
Date: Fri, 29 Aug 2008 11:03:26 -0700
From: "Bhupender Saharan" <bhupi.saharan@gmail.com>
To: "SETTE AGOSTINO - technolabs" <Agostino.Sette@technolabs.it>
Subject: Re: MPC8568MDS RAMDISK Problem
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E01000F98@aquib01a>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7174_33277135.1220033006809"
References: <48B71D04.4080805@embedded-sol.com>
	<F1F6EC0C8B75034F9E3A79FC85122E8E01000F98@aquib01a>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_7174_33277135.1220033006809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

COuple of pthings bwhich i saw wrong:

Your compressed image size is 3.5 MByte and you have provoided the ramdisk
sizes as 5MByte. That is not correct. Uncompress ramdisk size would be more
than 5MByte for sure.

But from the log looks like kernel is not tring to find the ramdisk
itself....? Need to check if Kernel is looking at correct address what boot
loader has passed when checking for the ramdisk....

Bhupi
www.e-coninfotech.com





On 8/29/08, SETTE AGOSTINO - technolabs <Agostino.Sette@technolabs.it>
wrote:
>
> Hi all,
>
> I am trying to port a RAMDISK Filesystem on the MPC8568MDS board but I
> have the following problem:
> U-Boot 1.3.0-rc3 (Nov 23 2007 - 18:17:06)
>
> CPU:   8568_E, Version: 1.1, (0x807d0011)
> Core:  E500, Version: 2.2, (0x80210022)
> Clock Configuration:
>       CPU:1320 MHz, CCB: 528 MHz,
>       DDR: 264 MHz, LBC: 132 MHz
> L1:    D-cache 32 kB enabled
>       I-cache 32 kB enabled
> Board: 8568 MDS
> I2C:   ready
> DRAM:  Initializing
>    SDRAM: 64 MB
>    DDR: 512 MB
> FLASH: 32 MB
> L2 cache 512KB: enabled
>    PCI: 32 bit, 66 MHz, async, host, arbiter
>               Scanning PCI bus 00
> PCI on bus 00 - 00
>
>    PCIE connected to slot as Root Complex (base address e000a000)
> PCIE on bus 01 - 01
> In:    serial
> Out:   serial
> Err:   serial
> Net:   UEC: PHY is Marvell 88E11x1 (1410cc2)
> UEC: PHY is Marvell 88E11x1 (1410cc2)
> eTSEC0, eTSEC1, FSL UEC0, FSL UEC1
> Hit any key to stop autoboot:  0
>
> ## Checking Image at 02000100 ...
>   Image Name:   Linux-2.6.25.5
>   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>   Data Size:    1325906 Bytes =  1.3 MB
>   Load Address: 00000000
>   Entry Point:  00000000
>   Verifying Checksum ... OK
> ## Booting image at 02000100 ...
>   Image Name:   Linux-2.6.25.5
>   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>   Data Size:    1325906 Bytes =  1.3 MB
>   Load Address: 00000000
>   Entry Point:  00000000
>   Verifying Checksum ... OK
>   Uncompressing Kernel Image ... OK
> ## Loading RAMDisk Image at 02200100 ...
>   Image Name:   initrd
>   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>   Data Size:    3658144 Bytes =  3.5 MB
>   Load Address: 00000000
>   Entry Point:  00000000
>   Verifying Checksum ... OK
>   Booting using the fdt at 0x21f0100
>   Loading Ramdisk to 00482000, end 007ff1a0 ... OK
>   Loading Device Tree to 007fa000, end 007fcfff ... OK
> Using MPC85xx MDS machine description
> Memory CAM mapping: CAM0=16Mb, CAM1=16Mb, CAM2=16Mb residual: 15Mb
> Linux version 2.6.25.5 (ity10223@aqlbl05x) (gcc version 4.2.2) #1 Fri
> Aug 29 16:44:02 CEST 2008
> Found legacy serial port 0 for /soc8568@e0000000/serial@4500
> mem=e0004500, taddr=e0004500, irq=0, clk=528000000, speed=0
> Found legacy serial port 1 for /soc8568@e0000000/serial@4600
> mem=e0004600, taddr=e0004600, irq=0, clk=528000000, speed=0
> console [udbg0] enabled
> Entering add_active_range(0, 0, 12288) 0 entries of 256 used
> setup_arch: bootmem
> mpc85xx_mds_setup_arch()
> Found FSL PCI host bridge at 0x00000000e0008000. Firmware bus number:
> 0->0
> PCI host bridge /soc8568@e0000000/pci@8000 (primary) ranges:
> Found FSL PCI host bridge at 0x00000000e000a000. Firmware bus number:
> 0->0
> PCI host bridge /soc8568@e0000000/pcie@a000  ranges:
> arch: exit
> Top of RAM: 0x3000000, Total RAM: 0x3000000
> Memory hole size: 0MB
> Zone PFN ranges:
> DMA             0 ->    12288
> Normal      12288 ->    12288
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>    0:        0 ->    12288
> On node 0 totalpages: 12288
> DMA zone: 96 pages used for memmap
> DMA zone: 0 pages reserved
> DMA zone: 12192 pages, LIFO batch:1
> Normal zone: 0 pages used for memmap
> Movable zone: 0 pages used for memmap
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
> 12192
> Kernel command line:
> mtdparts=physmap-flash.0:1M(boot),7M(aps0),7M(aps1),1M(optusr)
> console=ttyS0,115200 root=/dev/ram ramdisk_size=500000 rw ip=192.168.0.1
> 26:192.168.0.33:192.168.1.1:255.255.255.0:MPC8568MDS:eth0:off panic=1
> mem=0x3f00000 aps=0
> mpic: Setting up MPIC " OpenPIC  " version 1.2 at e0040000, max 1 CPUs
> mpic: ISU size: 80, shift: 7, mask: 7f
> mpic: Initializing for 80 sources
> PID hash table entries: 256 (order: 8, 1024 bytes)
> time_init: decrementer frequency = 66.000000 MHz
> time_init: processor frequency   = 1320.000000 MHz
> clocksource: timebase mult[3c9b26d] shift[22] registered
> clockevent: decrementer mult[10e5] shift[16] cpu[0]
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 42240k/49152k available (2632k kernel code, 6892k reserved, 104k
> data, 96k bss, 128k init)
> SLUB: Genslabs=12, HWalign=32, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
> Calibrating delay loop... 131.58 BogoMIPS (lpj=263168)
> Mount-cache hash table entries: 512
> net_namespace: 152 bytes
> NET: Registered protocol family 16
>
> PCI: Probing PCI hardware
> Memory resource not set for host bridge 0
> PCI: 0001:01:00.0: class b20 doesn't match header type 01. Ignoring
> class.
> Memory resource not set for host bridge 1
> PCI: Closing bogus Apple Firmware region 1 on bus 0x02
> PCI: Closing bogus Apple Firmware region 2 on bus 0x02
> PCI: Bridge: 0001:01:00.0
> IO window: 0000-ffffffff
> MEM window: 0x00000000-0xffffffff
> PREFETCH window: disabled.
> PCI: Enabling device 0001:01:00.0 (0106 -> 0107)
> Registering qe_ic with sysfs...
> SCSI subsystem initialized
> NET: Registered protocol family 2
> Switched to high resolution mode on CPU 0
> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> TCP established hash table entries: 2048 (order: 2, 16384 bytes)
> TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
> TCP: Hash tables configured (established 2048 bind 2048)
> TCP reno registered
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 42) is a 16550A
>                                                             console
> handover: boot [udbg0] -> real [ttyS0]
> serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 42) is a 16550A
> brd: module loaded
> loop: module loaded
> Gianfar MII Bus: probed
> eth0: Gianfar Ethernet Controller Version 1.2, 00:e0:0c:00:00:fd
> eth0: Running with NAPI enabled
> eth0: 256/256 RX/TX BD ring size
> eth1: Gianfar Ethernet Controller Version 1.2, 00:e0:0c:00:01:fd
> eth1: Running with NAPI enabled
> eth1: 256/256 RX/TX BD ring size
> i2c /dev entries driver
> rtc-ds1374 0-0068: rtc core: registered rtc-ds1374 as rtc0
> TCP cubic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> rtc-ds1374 0-0068: setting system clock to 1970-07-19 01:19:19 UTC
> (17198359)
> IP-Config: Gateway not on directly connected network.
> List of all partitions:
> 0100     500000 ram0 (driver?)
> 0101     500000 ram1 (driver?)
> 0102     500000 ram2 (driver?)
> 0103     500000 ram3 (driver?)
> 0104     500000 ram4 (driver?)
> 0105     500000 ram5 (driver?)
> 0106     500000 ram6 (driver?)
> 0107     500000 ram7 (driver?)
> 0108     500000 ram8 (driver?)
> 0109     500000 ram9 (driver?)
> 010a     500000 ram10 (driver?)
> 010b     500000 ram11 (driver?)
> 010c     500000 ram12 (driver?)
> 010d     500000 ram13 (driver?)
> 010e     500000 ram14 (driver?)
> 010f     500000 ram15 (driver?)
> No filesystem could mount root, tried:  ext3 ext2
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(1,0)
> Rebooting in 1 seconds..
>
> The U-Boot is quite old but is what I found on the board, I just change
> the envirinment variables
>
> ramboot=run ramargs;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr
> $bootfile;bootm $loadaddr $ramdiskaddr
> nfsboot=run nfsargs;tftp $loadaddr $bootfile;tftp $fdtaddr
> $fdtfile;bootm $loadaddr - $fdtaddr
> bootdelay=10
> baudrate=115200
> loads_echo=1
> ethaddr=00:E0:0C:00:00:FD
> eth1addr=00:E0:0C:00:01:FD
> eth2addr=00:E0:0C:00:02:FD
> eth3addr=00:E0:0C:00:03:FD
> rootpath=/nfsroot
> bootfile=your.uImage
> netdev=eth0
> consoledev=ttyS0
> ramdiskaddr=600000
> ramdiskfile=your.ramdisk.u-boot
> fdtaddr=400000
> fdtfile=your.fdt.dtb
> nfsargs=setenv bootargs root=/dev/nfs rw nfsroot=$serverip:$rootpath
> ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname:$netdev:off
> console=$consoledev,$bau
> drate $othbootargs
> ramargs=setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate
> $othbootargs
> bootargs=root=/dev/ram rw console=ttyS0,115200
> bootcmdAQ=if itest ${aps} == 0; then run dl_ram0; else run dl_ram1;fi
> ethact=eTSEC0
> filesize=4E0E64
> fileaddr=2000000
> gatewayip=192.168.1.1
> netmask=255.255.255.0
> ipaddr=192.168.0.126
> serverip=192.168.0.33
> bootcmdFREE=run ramargs;cp.b fff00000 400000 3500;bootm ff800000
> ffa00000 400000
> myaps=MPC8568MDS/aps
> mtdargs=mtdparts=physmap-flash.0:1M(boot),7M(aps0),7M(aps1),1M(optusr)
> pram=0x100000
> mem=0x3f00000
> pram_start=0x3f00000
> loadaddr=0x2000000
> aps0_fl_start=0xfe100000
> aps0_fl_size=0x00700000
> aps1_fl_start=0xfe800000
> aps1_fl_end=0xfeefffff
> aps1_fl_size=0x00700000
> aps_ram_start=0x2000000
> aps_ram_kernel_start=0x2000100
> aps_ram_dtb_start=0x21f0100
> aps_ram_rootfs_start=0x2200100
> aps=0
> dl_boot=tftp ${aps_ram_start} "u-boot.bin" && protect off 0xfe000000
> 0xfe07ffff && cp.b ${aps_ram_start} 0xfe000000 ${filesize} && protect on
> 0xfe000000 0xf
> e07ffff && saveenv
> bootcmd=if itest ${aps} == 0; then run dl_ram0; else run dl_ram1;fi
> altbootcmd=mw.b ${pram_start} 0 ${pram} && if itest ${aps} == 0; then
> setenv aps 1; else setenv aps 0; fi; saveenv; run bootcmd
> dl_ram0=cp.b ${aps0_fl_start} ${aps_ram_start} ${aps0_fl_size};if imi
> ${aps_ram_kernel_start}; then run bargs;bootm ${aps_ram_kernel_start}
> ${aps_ram_rootfs
> _start} ${aps_ram_dtb_start}; else reset; fi
> dl_ram1=cp.b ${aps1_fl_start} ${aps_ram_start} ${aps1_fl_size};if imi
> ${aps_ram_kernel_start}; then run bargs;bootm ${aps_ram_kernel_start}
> ${aps_ram_rootfs
> _start} ${aps_ram_dtb_start}; else reset; fi
> bootlimit=5
> initrd_high=no
> hostname=MPC8568MDS
> aps0_fl_end=0xfe7fffff
> dl_aps0=tftp ${aps_ram_start} ${myaps};erase ${aps0_fl_start}
> ${aps0_fl_end};cp.b ${aps_ram_start} ${aps0_fl_start} ${filesize};boot
> dl_aps1=tftp ${aps_ram_start} ${myaps};erase ${aps1_fl_start}
> ${aps1_fl_end};cp.b ${aps_ram_start} ${aps1_fl_start} ${filesize};boot
> bargs=setenv bootargs ${mtdargs} console=ttyS0,$baudrate root=/dev/ram
> ramdisk_size=500000 rw
> ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:e
> th0:off panic=1 mem=${mem} aps=${aps} ${misc} ${slram}
> stdin=serial
> stdout=serial
> stderr=serial
>
> Environment size: 2857/8188 bytes
>
> I am using linux2.6.25-denx with the followind mpc8568mds_defconfig
>
> >> cat kernel/linux/arch/powerpc/configs/mpc8568mds_defconfig
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.25.5
> # Fri Aug 29 16:33:50 2008
> #
> # CONFIG_PPC64 is not set
>
> #
> # Processor support
> #
> # CONFIG_6xx is not set
> CONFIG_PPC_85xx=y
> # CONFIG_PPC_8xx is not set
> # CONFIG_40x is not set
> # CONFIG_44x is not set
> # CONFIG_E200 is not set
> CONFIG_E500=y
> CONFIG_BOOKE=y
> CONFIG_FSL_BOOKE=y
> CONFIG_FSL_EMB_PERFMON=y
> # CONFIG_PHYS_64BIT is not set
> CONFIG_SPE=y
> # CONFIG_PPC_MM_SLICES is not set
> CONFIG_PPC32=y
> CONFIG_WORD_SIZE=32
> CONFIG_PPC_MERGE=y
> CONFIG_MMU=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> CONFIG_GENERIC_TIME=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_HARDIRQS=y
> # CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
> CONFIG_IRQ_PER_CPU=y
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_ARCH_HAS_ILOG2_U32=y
> CONFIG_GENERIC_HWEIGHT=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_GENERIC_FIND_NEXT_BIT=y
> # CONFIG_ARCH_NO_VIRT_TO_BUS is not set
> CONFIG_PPC=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_GENERIC_NVRAM=y
> CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_PPC_OF=y
> CONFIG_OF=y
> CONFIG_PPC_UDBG_16550=y
> # CONFIG_GENERIC_TBSYNC is not set
> CONFIG_AUDIT_ARCH=y
> CONFIG_GENERIC_BUG=y
> CONFIG_DEFAULT_UIMAGE=y
> # CONFIG_PPC_DCR_NATIVE is not set
> # CONFIG_PPC_DCR_MMIO is not set
> CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
>
> #
> # General setup
> #
> CONFIG_EXPERIMENTAL=y
> CONFIG_BROKEN_ON_SMP=y
> CONFIG_INIT_ENV_ARG_LIMIT=32
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> # CONFIG_POSIX_MQUEUE is not set
> # CONFIG_BSD_PROCESS_ACCT is not set
> # CONFIG_TASKSTATS is not set
> # CONFIG_AUDIT is not set
> # CONFIG_IKCONFIG is not set
> CONFIG_LOG_BUF_SHIFT=14
> # CONFIG_CGROUPS is not set
> CONFIG_GROUP_SCHED=y
> # CONFIG_FAIR_GROUP_SCHED is not set
> # CONFIG_RT_GROUP_SCHED is not set
> CONFIG_USER_SCHED=y
> # CONFIG_CGROUP_SCHED is not set
> CONFIG_SYSFS_DEPRECATED=y
> CONFIG_SYSFS_DEPRECATED_V2=y
> # CONFIG_RELAY is not set
> # CONFIG_NAMESPACES is not set
> # CONFIG_BLK_DEV_INITRD is not set
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_SYSCTL=y
> CONFIG_EMBEDDED=y
> CONFIG_SYSCTL_SYSCALL=y
> # CONFIG_KALLSYMS is not set
> CONFIG_HOTPLUG=y
> CONFIG_PRINTK=y
> # CONFIG_LOGBUFFER is not set
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_COMPAT_BRK=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_ANON_INODES=y
> # CONFIG_EPOLL is not set
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_VM_EVENT_COUNTERS=y
> CONFIG_SLUB_DEBUG=y
> # CONFIG_SLAB is not set
> CONFIG_SLUB=y
> # CONFIG_SLOB is not set
> # CONFIG_PROFILING is not set
> # CONFIG_MARKERS is not set
> CONFIG_HAVE_OPROFILE=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_PROC_PAGE_MONITOR=y
> CONFIG_SLABINFO=y
> CONFIG_RT_MUTEXES=y
> # CONFIG_TINY_SHMEM is not set
> CONFIG_BASE_SMALL=0
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> # CONFIG_KMOD is not set
> CONFIG_BLOCK=y
> # CONFIG_LBD is not set
> # CONFIG_BLK_DEV_IO_TRACE is not set
> # CONFIG_LSF is not set
> # CONFIG_BLK_DEV_BSG is not set
>
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_AS=y
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=y
> CONFIG_DEFAULT_AS=y
> # CONFIG_DEFAULT_DEADLINE is not set
> # CONFIG_DEFAULT_CFQ is not set
> # CONFIG_DEFAULT_NOOP is not set
> CONFIG_DEFAULT_IOSCHED="anticipatory"
> CONFIG_CLASSIC_RCU=y
>
> #
> # Platform support
> #
> # CONFIG_PPC_MPC512x is not set
> # CONFIG_PPC_MPC5121 is not set
> # CONFIG_PPC_CELL is not set
> # CONFIG_PPC_CELL_NATIVE is not set
> # CONFIG_PQ2ADS is not set
> CONFIG_MPC85xx=y
> # CONFIG_MPC8540_ADS is not set
> # CONFIG_MPC8560_ADS is not set
> # CONFIG_MPC85xx_CDS is not set
> CONFIG_MPC85xx_MDS=y
> # CONFIG_MPC85xx_DS is not set
> # CONFIG_STX_GP3 is not set
> # CONFIG_TQM8540 is not set
> # CONFIG_TQM8541 is not set
> # CONFIG_TQM8555 is not set
> # CONFIG_TQM8560 is not set
> # CONFIG_SBC8548 is not set
> # CONFIG_SBC8560 is not set
> # CONFIG_IPIC is not set
> CONFIG_MPIC=y
> # CONFIG_MPIC_WEIRD is not set
> # CONFIG_PPC_I8259 is not set
> # CONFIG_PPC_RTAS is not set
> # CONFIG_MMIO_NVRAM is not set
> # CONFIG_PPC_MPC106 is not set
> # CONFIG_PPC_970_NAP is not set
> # CONFIG_PPC_INDIRECT_IO is not set
> # CONFIG_GENERIC_IOMAP is not set
> # CONFIG_CPU_FREQ is not set
> CONFIG_QUICC_ENGINE=y
> # CONFIG_CPM2 is not set
> # CONFIG_FSL_ULI1575 is not set
>
> #
> # Kernel options
> #
> # CONFIG_HIGHMEM is not set
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ=y
> CONFIG_HIGH_RES_TIMERS=y
> CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
> # CONFIG_HZ_100 is not set
> CONFIG_HZ_250=y
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=250
> # CONFIG_SCHED_HRTICK is not set
> CONFIG_PREEMPT_NONE=y
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT is not set
> CONFIG_BINFMT_ELF=y
> # CONFIG_BINFMT_MISC is not set
> CONFIG_MATH_EMULATION=y
> # CONFIG_IOMMU_HELPER is not set
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> CONFIG_ARCH_HAS_WALK_MEMORY=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
> CONFIG_ARCH_FLATMEM_ENABLE=y
> CONFIG_ARCH_POPULATES_NODE_MAP=y
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_FLATMEM_MANUAL=y
> # CONFIG_DISCONTIGMEM_MANUAL is not set
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_FLATMEM=y
> CONFIG_FLAT_NODE_MEM_MAP=y
> # CONFIG_SPARSEMEM_STATIC is not set
> # CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
> CONFIG_SPLIT_PTLOCK_CPUS=4
> # CONFIG_RESOURCES_64BIT is not set
> CONFIG_ZONE_DMA_FLAG=1
> CONFIG_BOUNCE=y
> CONFIG_VIRT_TO_BUS=y
> CONFIG_PROC_DEVICETREE=y
> # CONFIG_CMDLINE_BOOL is not set
> # CONFIG_PM is not set
> CONFIG_SECCOMP=y
> CONFIG_ISA_DMA_API=y
>
> #
> # Bus options
> #
> CONFIG_ZONE_DMA=y
> CONFIG_PPC_INDIRECT_PCI=y
> CONFIG_FSL_SOC=y
> CONFIG_FSL_PCI=y
> CONFIG_PCI=y
> CONFIG_PCI_DOMAINS=y
> CONFIG_PCI_SYSCALL=y
> # CONFIG_PCIEPORTBUS is not set
> CONFIG_ARCH_SUPPORTS_MSI=y
> # CONFIG_PCI_MSI is not set
> CONFIG_PCI_LEGACY=y
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCCARD is not set
> # CONFIG_HOTPLUG_PCI is not set
>
> #
> # Advanced setup
> #
> # CONFIG_ADVANCED_OPTIONS is not set
>
> #
> # Default settings for advanced configuration options are used
> #
> CONFIG_HIGHMEM_START=0xfe000000
> CONFIG_LOWMEM_SIZE=0x30000000
> CONFIG_KERNEL_START=0xc0000000
> CONFIG_TASK_SIZE=0xc0000000
> CONFIG_BOOT_LOAD=0x00800000
>
> #
> # Networking
> #
> CONFIG_NET=y
>
> #
> # Networking options
> #
> CONFIG_PACKET=y
> # CONFIG_PACKET_MMAP is not set
> CONFIG_UNIX=y
> CONFIG_XFRM=y
> # CONFIG_XFRM_USER is not set
> # CONFIG_XFRM_SUB_POLICY is not set
> # CONFIG_XFRM_MIGRATE is not set
> # CONFIG_XFRM_STATISTICS is not set
> # CONFIG_NET_KEY is not set
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> # CONFIG_IP_ADVANCED_ROUTER is not set
> CONFIG_IP_FIB_HASH=y
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> CONFIG_IP_PNP_BOOTP=y
> # CONFIG_IP_PNP_RARP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_IP_MROUTE is not set
> # CONFIG_ARPD is not set
> CONFIG_SYN_COOKIES=y
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> # CONFIG_INET_XFRM_TUNNEL is not set
> # CONFIG_INET_TUNNEL is not set
> CONFIG_INET_XFRM_MODE_TRANSPORT=y
> CONFIG_INET_XFRM_MODE_TUNNEL=y
> CONFIG_INET_XFRM_MODE_BEET=y
> # CONFIG_INET_LRO is not set
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_DEFAULT_TCP_CONG="cubic"
> # CONFIG_TCP_MD5SIG is not set
> # CONFIG_IPV6 is not set
> # CONFIG_INET6_XFRM_TUNNEL is not set
> # CONFIG_INET6_TUNNEL is not set
> # CONFIG_NETWORK_SECMARK is not set
> # CONFIG_NETFILTER is not set
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_SCHED is not set
>
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_HAMRADIO is not set
> # CONFIG_CAN is not set
> # CONFIG_IRDA is not set
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
>
> #
> # Wireless
> #
> # CONFIG_CFG80211 is not set
> # CONFIG_WIRELESS_EXT is not set
> # CONFIG_MAC80211 is not set
> # CONFIG_IEEE80211 is not set
> # CONFIG_RFKILL is not set
> # CONFIG_NET_9P is not set
>
> #
> # Device Drivers
> #
>
> #
> # Generic Driver Options
> #
> CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> # CONFIG_FW_LOADER is not set
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_SYS_HYPERVISOR is not set
> # CONFIG_CONNECTOR is not set
> # CONFIG_MTD is not set
> CONFIG_OF_DEVICE=y
> # CONFIG_PARPORT is not set
> CONFIG_BLK_DEV=y
> # CONFIG_BLK_DEV_FD is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> # CONFIG_BLK_DEV_COW_COMMON is not set
> CONFIG_BLK_DEV_LOOP=y
> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_COUNT=16
> CONFIG_BLK_DEV_RAM_SIZE=32768
> # CONFIG_BLK_DEV_XIP is not set
> # CONFIG_CDROM_PKTCDVD is not set
> # CONFIG_ATA_OVER_ETH is not set
> CONFIG_MISC_DEVICES=y
> # CONFIG_PHANTOM is not set
> # CONFIG_EEPROM_93CX6 is not set
> # CONFIG_SGI_IOC4 is not set
> # CONFIG_TIFM_CORE is not set
> # CONFIG_ENCLOSURE_SERVICES is not set
> CONFIG_HAVE_IDE=y
> # CONFIG_IDE is not set
>
> #
> # SCSI device support
> #
> # CONFIG_RAID_ATTRS is not set
> CONFIG_SCSI=y
> CONFIG_SCSI_DMA=y
> # CONFIG_SCSI_TGT is not set
> # CONFIG_SCSI_NETLINK is not set
> CONFIG_SCSI_PROC_FS=y
>
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> # CONFIG_BLK_DEV_SD is not set
> # CONFIG_CHR_DEV_ST is not set
> # CONFIG_CHR_DEV_OSST is not set
> # CONFIG_BLK_DEV_SR is not set
> # CONFIG_CHR_DEV_SG is not set
> # CONFIG_CHR_DEV_SCH is not set
>
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> # CONFIG_SCSI_MULTI_LUN is not set
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
> # CONFIG_SCSI_SCAN_ASYNC is not set
> CONFIG_SCSI_WAIT_SCAN=m
>
> #
> # SCSI Transports
> #
> # CONFIG_SCSI_SPI_ATTRS is not set
> # CONFIG_SCSI_FC_ATTRS is not set
> # CONFIG_SCSI_ISCSI_ATTRS is not set
> # CONFIG_SCSI_SAS_LIBSAS is not set
> # CONFIG_SCSI_SRP_ATTRS is not set
> CONFIG_SCSI_LOWLEVEL=y
> # CONFIG_ISCSI_TCP is not set
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_3W_9XXX is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_AIC94XX is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_ARCMSR is not set
> # CONFIG_MEGARAID_NEWGEN is not set
> # CONFIG_MEGARAID_LEGACY is not set
> # CONFIG_MEGARAID_SAS is not set
> # CONFIG_SCSI_HPTIOP is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_MVSAS is not set
> # CONFIG_SCSI_STEX is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_QLA_FC is not set
> # CONFIG_SCSI_QLA_ISCSI is not set
> # CONFIG_SCSI_LPFC is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_NSP32 is not set
> # CONFIG_SCSI_DEBUG is not set
> # CONFIG_SCSI_SRP is not set
> # CONFIG_ATA is not set
> # CONFIG_MD is not set
> # CONFIG_FUSION is not set
>
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_FIREWIRE is not set
> # CONFIG_IEEE1394 is not set
> # CONFIG_I2O is not set
> # CONFIG_MACINTOSH_DRIVERS is not set
> CONFIG_NETDEVICES=y
> # CONFIG_NETDEVICES_MULTIQUEUE is not set
> # CONFIG_DUMMY is not set
> # CONFIG_BONDING is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
> # CONFIG_VETH is not set
> # CONFIG_ARCNET is not set
> CONFIG_PHYLIB=y
>
> #
> # MII PHY device drivers
> #
> CONFIG_MARVELL_PHY=y
> # CONFIG_DAVICOM_PHY is not set
> # CONFIG_QSEMI_PHY is not set
> # CONFIG_LXT_PHY is not set
> # CONFIG_CICADA_PHY is not set
> # CONFIG_VITESSE_PHY is not set
> # CONFIG_SMSC_PHY is not set
> # CONFIG_BROADCOM_PHY is not set
> # CONFIG_ICPLUS_PHY is not set
> # CONFIG_REALTEK_PHY is not set
> # CONFIG_FIXED_PHY is not set
> # CONFIG_MDIO_BITBANG is not set
> CONFIG_NET_ETHERNET=y
> CONFIG_MII=y
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NET_VENDOR_3COM is not set
> # CONFIG_NET_TULIP is not set
> # CONFIG_HP100 is not set
> # CONFIG_IBM_NEW_EMAC_ZMII is not set
> # CONFIG_IBM_NEW_EMAC_RGMII is not set
> # CONFIG_IBM_NEW_EMAC_TAH is not set
> # CONFIG_IBM_NEW_EMAC_EMAC4 is not set
> # CONFIG_NET_PCI is not set
> # CONFIG_B44 is not set
> CONFIG_NETDEV_1000=y
> # CONFIG_ACENIC is not set
> # CONFIG_DL2K is not set
> # CONFIG_E1000 is not set
> # CONFIG_E1000E is not set
> # CONFIG_E1000E_ENABLED is not set
> # CONFIG_IP1000 is not set
> # CONFIG_IGB is not set
> # CONFIG_NS83820 is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_R8169 is not set
> # CONFIG_SIS190 is not set
> # CONFIG_SKGE is not set
> # CONFIG_SKY2 is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_VIA_VELOCITY is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_BNX2 is not set
> CONFIG_GIANFAR=y
> CONFIG_GFAR_NAPI=y
> # CONFIG_UCC_GETH is not set
> # CONFIG_QLA3XXX is not set
> # CONFIG_ATL1 is not set
> CONFIG_NETDEV_10000=y
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_CHELSIO_T3 is not set
> # CONFIG_IXGBE is not set
> # CONFIG_IXGB is not set
> # CONFIG_S2IO is not set
> # CONFIG_MYRI10GE is not set
> # CONFIG_NETXEN_NIC is not set
> # CONFIG_NIU is not set
> # CONFIG_MLX4_CORE is not set
> # CONFIG_TEHUTI is not set
> # CONFIG_BNX2X is not set
> # CONFIG_TR is not set
>
> #
> # Wireless LAN
> #
> # CONFIG_WLAN_PRE80211 is not set
> # CONFIG_WLAN_80211 is not set
> # CONFIG_WAN is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> # CONFIG_NET_FC is not set
> # CONFIG_NETCONSOLE is not set
> # CONFIG_NETPOLL is not set
> # CONFIG_NET_POLL_CONTROLLER is not set
> # CONFIG_ISDN is not set
> # CONFIG_PHONE is not set
>
> #
> # Input device support
> #
> CONFIG_INPUT=y
> # CONFIG_INPUT_FF_MEMLESS is not set
> # CONFIG_INPUT_POLLDEV is not set
>
> #
> # Userland interfaces
> #
> # CONFIG_INPUT_MOUSEDEV is not set
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_EVDEV is not set
> # CONFIG_INPUT_EVBUG is not set
>
> #
> # Input Device Drivers
> #
> # CONFIG_INPUT_KEYBOARD is not set
> # CONFIG_INPUT_MOUSE is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
>
> #
> # Hardware I/O ports
> #
> # CONFIG_SERIO is not set
> # CONFIG_GAMEPORT is not set
>
> #
> # Character devices
> #
> # CONFIG_VT is not set
> # CONFIG_SERIAL_NONSTANDARD is not set
> # CONFIG_NOZOMI is not set
>
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> CONFIG_SERIAL_8250_SHARE_IRQ=y
>
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_UARTLITE is not set
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> # CONFIG_SERIAL_JSM is not set
> # CONFIG_SERIAL_OF_PLATFORM is not set
> # CONFIG_SERIAL_QE is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256
> # CONFIG_IPMI_HANDLER is not set
> CONFIG_HW_RANDOM=y
> # CONFIG_NVRAM is not set
> # CONFIG_GEN_RTC is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_RAW_DRIVER is not set
> # CONFIG_TCG_TPM is not set
> CONFIG_DEVPORT=y
> CONFIG_I2C=y
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_CHARDEV=y
>
> #
> # I2C Algorithms
> #
> # CONFIG_I2C_ALGOBIT is not set
> # CONFIG_I2C_ALGOPCF is not set
> # CONFIG_I2C_ALGOPCA is not set
>
> #
> # I2C Hardware Bus support
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_I810 is not set
> # CONFIG_I2C_PIIX4 is not set
> # CONFIG_I2C_IBM_OF is not set
> CONFIG_I2C_MPC=y
> # CONFIG_I2C_MPC8260 is not set
> # CONFIG_I2C_NFORCE2 is not set
> # CONFIG_I2C_OCORES is not set
> # CONFIG_I2C_PARPORT_LIGHT is not set
> # CONFIG_I2C_PROSAVAGE is not set
> # CONFIG_I2C_SAVAGE4 is not set
> # CONFIG_I2C_SIMTEC is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> # CONFIG_I2C_SIS96X is not set
> # CONFIG_I2C_TAOS_EVM is not set
> # CONFIG_I2C_STUB is not set
> # CONFIG_I2C_VIA is not set
> # CONFIG_I2C_VIAPRO is not set
> # CONFIG_I2C_VOODOO3 is not set
>
> #
> # Miscellaneous I2C Chip support
> #
> # CONFIG_SENSORS_24C01A is not set
> # CONFIG_SENSORS_AD7416 is not set
> # CONFIG_DS1682 is not set
> # CONFIG_SENSORS_EEPROM is not set
> # CONFIG_SENSORS_MAX6900 is not set
> # CONFIG_SENSORS_PCF8574 is not set
> # CONFIG_PCF8575 is not set
> # CONFIG_SENSORS_PCF8591 is not set
> # CONFIG_TPS65010 is not set
> # CONFIG_SENSORS_MAX6875 is not set
> # CONFIG_SENSORS_TSL2550 is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # CONFIG_I2C_DEBUG_CHIP is not set
>
> #
> # SPI support
> #
> # CONFIG_SPI is not set
> # CONFIG_SPI_MASTER is not set
> # CONFIG_W1 is not set
> # CONFIG_POWER_SUPPLY is not set
> CONFIG_HWMON=y
> # CONFIG_HWMON_VID is not set
> # CONFIG_SENSORS_AD7414 is not set
> # CONFIG_SENSORS_AD7418 is not set
> # CONFIG_SENSORS_ADM1021 is not set
> # CONFIG_SENSORS_ADM1025 is not set
> # CONFIG_SENSORS_ADM1026 is not set
> # CONFIG_SENSORS_ADM1029 is not set
> # CONFIG_SENSORS_ADM1031 is not set
> # CONFIG_SENSORS_ADM9240 is not set
> # CONFIG_SENSORS_ADT7470 is not set
> # CONFIG_SENSORS_ADT7473 is not set
> # CONFIG_SENSORS_ATXP1 is not set
> # CONFIG_SENSORS_DS1621 is not set
> # CONFIG_SENSORS_I5K_AMB is not set
> # CONFIG_SENSORS_F71805F is not set
> # CONFIG_SENSORS_FM75 is not set
> # CONFIG_SENSORS_F71882FG is not set
> # CONFIG_SENSORS_F75375S is not set
> # CONFIG_SENSORS_GL518SM is not set
> # CONFIG_SENSORS_GL520SM is not set
> # CONFIG_SENSORS_IT87 is not set
> # CONFIG_SENSORS_LM63 is not set
> # CONFIG_SENSORS_LM75 is not set
> # CONFIG_SENSORS_LM77 is not set
> # CONFIG_SENSORS_LM78 is not set
> # CONFIG_SENSORS_LM80 is not set
> # CONFIG_SENSORS_LM83 is not set
> # CONFIG_SENSORS_LM85 is not set
> # CONFIG_SENSORS_LM87 is not set
> # CONFIG_SENSORS_LM90 is not set
> # CONFIG_SENSORS_LM92 is not set
> # CONFIG_SENSORS_LM93 is not set
> # CONFIG_SENSORS_MAX1619 is not set
> # CONFIG_SENSORS_MAX6650 is not set
> # CONFIG_SENSORS_PC87360 is not set
> # CONFIG_SENSORS_PC87427 is not set
> # CONFIG_SENSORS_SIS5595 is not set
> # CONFIG_SENSORS_DME1737 is not set
> # CONFIG_SENSORS_SMSC47M1 is not set
> # CONFIG_SENSORS_SMSC47M192 is not set
> # CONFIG_SENSORS_SMSC47B397 is not set
> # CONFIG_SENSORS_ADS7828 is not set
> # CONFIG_SENSORS_THMC50 is not set
> # CONFIG_SENSORS_VIA686A is not set
> # CONFIG_SENSORS_VT1115 is not set
> # CONFIG_SENSORS_VT1211 is not set
> # CONFIG_SENSORS_VT8231 is not set
> # CONFIG_SENSORS_W83781D is not set
> # CONFIG_SENSORS_W83791D is not set
> # CONFIG_SENSORS_W83792D is not set
> # CONFIG_SENSORS_W83793 is not set
> # CONFIG_SENSORS_W83L785TS is not set
> # CONFIG_SENSORS_W83L786NG is not set
> # CONFIG_SENSORS_W83627HF is not set
> # CONFIG_SENSORS_W83627EHF is not set
> # CONFIG_HWMON_DEBUG_CHIP is not set
> # CONFIG_THERMAL is not set
> CONFIG_WATCHDOG=y
> # CONFIG_WATCHDOG_NOWAYOUT is not set
>
> #
> # Watchdog Device Drivers
> #
> # CONFIG_WD is not set
> # CONFIG_SOFT_WATCHDOG is not set
> # CONFIG_BOOKE_WDT is not set
>
> #
> # PCI-based Watchdog Cards
> #
> # CONFIG_PCIPCWATCHDOG is not set
> # CONFIG_WDTPCI is not set
>
> #
> # Sonics Silicon Backplane
> #
> CONFIG_SSB_POSSIBLE=y
> # CONFIG_SSB is not set
>
> #
> # Multifunction device drivers
> #
> # CONFIG_MFD_SM501 is not set
>
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
> # CONFIG_DVB_CORE is not set
> CONFIG_DAB=y
>
> #
> # Graphics support
> #
> # CONFIG_AGP is not set
> # CONFIG_DRM is not set
> # CONFIG_VGASTATE is not set
> CONFIG_VIDEO_OUTPUT_CONTROL=m
> # CONFIG_FB is not set
> # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
>
> #
> # Display device support
> #
> # CONFIG_DISPLAY_SUPPORT is not set
>
> #
> # Sound
> #
> # CONFIG_SOUND is not set
> CONFIG_HID_SUPPORT=y
> CONFIG_HID=y
> # CONFIG_HID_DEBUG is not set
> # CONFIG_HIDRAW is not set
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB_ARCH_HAS_OHCI=y
> CONFIG_USB_ARCH_HAS_EHCI=y
> # CONFIG_USB is not set
>
> #
> # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
> #
> # CONFIG_USB_GADGET is not set
> # CONFIG_MMC is not set
> # CONFIG_MEMSTICK is not set
> # CONFIG_NEW_LEDS is not set
> # CONFIG_INFINIBAND is not set
> # CONFIG_EDAC is not set
> CONFIG_RTC_LIB=y
> CONFIG_RTC_CLASS=y
> CONFIG_RTC_HCTOSYS=y
> CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> # CONFIG_RTC_DEBUG is not set
>
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=y
> CONFIG_RTC_INTF_PROC=y
> CONFIG_RTC_INTF_DEV=y
> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> # CONFIG_RTC_DRV_TEST is not set
>
> #
> # I2C RTC drivers
> #
> # CONFIG_RTC_DRV_DS1307 is not set
> CONFIG_RTC_DRV_DS1374=y
> # CONFIG_RTC_DRV_DS1672 is not set
> # CONFIG_RTC_DRV_MAX6900 is not set
> # CONFIG_RTC_DRV_RS5C372 is not set
> # CONFIG_RTC_DRV_ISL1208 is not set
> # CONFIG_RTC_DRV_X1205 is not set
> # CONFIG_RTC_DRV_PCF8563 is not set
> # CONFIG_RTC_DRV_PCF8583 is not set
> # CONFIG_RTC_DRV_M41T80 is not set
> # CONFIG_RTC_DRV_S35390A is not set
>
> #
> # SPI RTC drivers
> #
>
> #
> # Platform RTC drivers
> #
> # CONFIG_RTC_DRV_CMOS is not set
> # CONFIG_RTC_DRV_DS1511 is not set
> # CONFIG_RTC_DRV_DS1553 is not set
> # CONFIG_RTC_DRV_DS1742 is not set
> # CONFIG_RTC_DRV_STK17TA8 is not set
> # CONFIG_RTC_DRV_M48T86 is not set
> # CONFIG_RTC_DRV_M48T59 is not set
> # CONFIG_RTC_DRV_V3020 is not set
>
> #
> # on-CPU RTC drivers
> #
> # CONFIG_DMADEVICES is not set
>
> #
> # Userspace I/O
> #
> # CONFIG_UIO is not set
>
> #
> # File systems
> #
> CONFIG_EXT2_FS=y
> # CONFIG_EXT2_FS_XATTR is not set
> # CONFIG_EXT2_FS_XIP is not set
> CONFIG_EXT3_FS=y
> CONFIG_EXT3_FS_XATTR=y
> # CONFIG_EXT3_FS_POSIX_ACL is not set
> # CONFIG_EXT3_FS_SECURITY is not set
> # CONFIG_EXT4DEV_FS is not set
> CONFIG_JBD=y
> CONFIG_FS_MBCACHE=y
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> # CONFIG_FS_POSIX_ACL is not set
> # CONFIG_XFS_FS is not set
> # CONFIG_GFS2_FS is not set
> # CONFIG_OCFS2_FS is not set
> CONFIG_DNOTIFY=y
> CONFIG_INOTIFY=y
> CONFIG_INOTIFY_USER=y
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_FUSE_FS is not set
>
> #
> # CD-ROM/DVD Filesystems
> #
> # CONFIG_ISO9660_FS is not set
> # CONFIG_UDF_FS is not set
>
> #
> # DOS/FAT/NT Filesystems
> #
> # CONFIG_MSDOS_FS is not set
> # CONFIG_VFAT_FS is not set
> # CONFIG_NTFS_FS is not set
>
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_PROC_SYSCTL=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> # CONFIG_TMPFS_POSIX_ACL is not set
> # CONFIG_HUGETLB_PAGE is not set
> # CONFIG_CONFIGFS_FS is not set
>
> #
> # Miscellaneous filesystems
> #
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_VXFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_ROMFS_FS is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> CONFIG_NETWORK_FILESYSTEMS=y
> CONFIG_NFS_FS=y
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V3_ACL is not set
> CONFIG_NFS_V4=y
> # CONFIG_NFS_DIRECTIO is not set
> # CONFIG_NFSD is not set
> CONFIG_ROOT_NFS=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=y
> CONFIG_SUNRPC_GSS=y
> # CONFIG_SUNRPC_BIND34 is not set
> CONFIG_RPCSEC_GSS_KRB5=y
> # CONFIG_RPCSEC_GSS_SPKM3 is not set
> # CONFIG_SMB_FS is not set
> # CONFIG_CIFS is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
>
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> # CONFIG_ACORN_PARTITION is not set
> # CONFIG_OSF_PARTITION is not set
> # CONFIG_AMIGA_PARTITION is not set
> # CONFIG_ATARI_PARTITION is not set
> # CONFIG_MAC_PARTITION is not set
> # CONFIG_MSDOS_PARTITION is not set
> # CONFIG_LDM_PARTITION is not set
> # CONFIG_SGI_PARTITION is not set
> # CONFIG_ULTRIX_PARTITION is not set
> # CONFIG_SUN_PARTITION is not set
> # CONFIG_KARMA_PARTITION is not set
> # CONFIG_EFI_PARTITION is not set
> # CONFIG_SYSV68_PARTITION is not set
> # CONFIG_NLS is not set
> # CONFIG_DLM is not set
>
> #
> # Library routines
> #
> CONFIG_BITREVERSE=y
> # CONFIG_CRC_CCITT is not set
> # CONFIG_CRC16 is not set
> # CONFIG_CRC_ITU_T is not set
> CONFIG_CRC32=y
> # CONFIG_CRC7 is not set
> # CONFIG_LIBCRC32C is not set
> CONFIG_PLIST=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT=y
> CONFIG_HAS_DMA=y
>
> #
> # Kernel hacking
> #
> # CONFIG_PRINTK_TIME is not set
> CONFIG_ENABLE_WARN_DEPRECATED=y
> CONFIG_ENABLE_MUST_CHECK=y
> # CONFIG_MAGIC_SYSRQ is not set
> # CONFIG_UNUSED_SYMBOLS is not set
> # CONFIG_DEBUG_FS is not set
> # CONFIG_HEADERS_CHECK is not set
> CONFIG_DEBUG_KERNEL=y
> # CONFIG_DEBUG_SHIRQ is not set
> CONFIG_DETECT_SOFTLOCKUP=y
> CONFIG_SCHED_DEBUG=y
> # CONFIG_SCHEDSTATS is not set
> # CONFIG_TIMER_STATS is not set
> # CONFIG_SLUB_DEBUG_ON is not set
> # CONFIG_SLUB_STATS is not set
> # CONFIG_DEBUG_RT_MUTEXES is not set
> # CONFIG_RT_MUTEX_TESTER is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_MUTEXES is not set
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> # CONFIG_DEBUG_KOBJECT is not set
> # CONFIG_DEBUG_BUGVERBOSE is not set
> # CONFIG_DEBUG_INFO is not set
> # CONFIG_DEBUG_VM is not set
> # CONFIG_DEBUG_LIST is not set
> # CONFIG_DEBUG_SG is not set
> # CONFIG_BOOT_PRINTK_DELAY is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_FAULT_INJECTION is not set
> # CONFIG_SAMPLES is not set
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_DEBUG_PAGEALLOC is not set
> CONFIG_DEBUGGER=y
> # CONFIG_XMON is not set
> # CONFIG_BDI_SWITCH is not set
> CONFIG_PPC_EARLY_DEBUG=y
> # CONFIG_PPC_EARLY_DEBUG_LPAR is not set
> # CONFIG_PPC_EARLY_DEBUG_G5 is not set
> # CONFIG_PPC_EARLY_DEBUG_RTAS_PANEL is not set
> # CONFIG_PPC_EARLY_DEBUG_RTAS_CONSOLE is not set
> # CONFIG_PPC_EARLY_DEBUG_MAPLE is not set
> # CONFIG_PPC_EARLY_DEBUG_ISERIES is not set
> # CONFIG_PPC_EARLY_DEBUG_PAS_REALMODE is not set
> # CONFIG_PPC_EARLY_DEBUG_BEAT is not set
> # CONFIG_PPC_EARLY_DEBUG_44x is not set
> # CONFIG_PPC_EARLY_DEBUG_40x is not set
> # CONFIG_PPC_EARLY_DEBUG_CPM is not set
>
> #
> # Security options
> #
> # CONFIG_KEYS is not set
> # CONFIG_SECURITY is not set
> # CONFIG_SECURITY_FILE_CAPABILITIES is not set
> CONFIG_CRYPTO=y
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_BLKCIPHER=y
> # CONFIG_CRYPTO_SEQIV is not set
> CONFIG_CRYPTO_MANAGER=y
> # CONFIG_CRYPTO_HMAC is not set
> # CONFIG_CRYPTO_XCBC is not set
> # CONFIG_CRYPTO_NULL is not set
> # CONFIG_CRYPTO_MD4 is not set
> CONFIG_CRYPTO_MD5=y
> # CONFIG_CRYPTO_SHA1 is not set
> # CONFIG_CRYPTO_SHA256 is not set
> # CONFIG_CRYPTO_SHA512 is not set
> # CONFIG_CRYPTO_WP512 is not set
> # CONFIG_CRYPTO_TGR192 is not set
> # CONFIG_CRYPTO_GF128MUL is not set
> CONFIG_CRYPTO_ECB=m
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_PCBC=m
> # CONFIG_CRYPTO_LRW is not set
> # CONFIG_CRYPTO_XTS is not set
> # CONFIG_CRYPTO_CTR is not set
> # CONFIG_CRYPTO_GCM is not set
> # CONFIG_CRYPTO_CCM is not set
> # CONFIG_CRYPTO_CRYPTD is not set
> CONFIG_CRYPTO_DES=y
> # CONFIG_CRYPTO_FCRYPT is not set
> # CONFIG_CRYPTO_BLOWFISH is not set
> # CONFIG_CRYPTO_TWOFISH is not set
> # CONFIG_CRYPTO_SERPENT is not set
> # CONFIG_CRYPTO_AES is not set
> # CONFIG_CRYPTO_CAST5 is not set
> # CONFIG_CRYPTO_CAST6 is not set
> # CONFIG_CRYPTO_TEA is not set
> # CONFIG_CRYPTO_ARC4 is not set
> # CONFIG_CRYPTO_KHAZAD is not set
> # CONFIG_CRYPTO_ANUBIS is not set
> # CONFIG_CRYPTO_SEED is not set
> # CONFIG_CRYPTO_SALSA20 is not set
> # CONFIG_CRYPTO_DEFLATE is not set
> # CONFIG_CRYPTO_MICHAEL_MIC is not set
> # CONFIG_CRYPTO_CRC32C is not set
> # CONFIG_CRYPTO_CAMELLIA is not set
> # CONFIG_CRYPTO_TEST is not set
> # CONFIG_CRYPTO_AUTHENC is not set
> # CONFIG_CRYPTO_LZO is not set
> CONFIG_CRYPTO_HW=y
> # CONFIG_CRYPTO_DEV_HIFN_795X is not set
> # CONFIG_PPC_CLOCK is not set
> CONFIG_PPC_LIB_RHEAP=y
>
> Does anyone know this problem?
>
> Thanks in advance
>
> Agostino Sette
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_7174_33277135.1220033006809
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi </div>
<div>&nbsp;</div>
<div>COuple of pthings bwhich i saw wrong:</div>
<div>&nbsp;</div>
<div>Your compressed image size is 3.5 MByte and you have provoided the ramdisk sizes as 5MByte. That is not correct. Uncompress ramdisk size would be more than 5MByte for sure.</div>
<div>&nbsp;</div>
<div>But from the log looks like kernel is not tring to find the ramdisk itself....? Need to check if Kernel is looking at correct address what boot loader has passed when checking for the ramdisk....</div>
<div>&nbsp;</div>
<div>Bhupi</div>
<div><a href="http://www.e-coninfotech.com">www.e-coninfotech.com</a></div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div><br><br>&nbsp;</div>
<div><span class="gmail_quote">On 8/29/08, <b class="gmail_sendername">SETTE AGOSTINO - technolabs</b> &lt;<a href="mailto:Agostino.Sette@technolabs.it">Agostino.Sette@technolabs.it</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi all,<br><br>I am trying to port a RAMDISK Filesystem on the MPC8568MDS board but I<br>have the following problem:<br>
U-Boot 1.3.0-rc3 (Nov 23 2007 - 18:17:06)<br><br>CPU:&nbsp;&nbsp; 8568_E, Version: 1.1, (0x807d0011)<br>Core:&nbsp;&nbsp;E500, Version: 2.2, (0x80210022)<br>Clock Configuration:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CPU:1320 MHz, CCB: 528 MHz,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DDR: 264 MHz, LBC: 132 MHz<br>
L1:&nbsp;&nbsp;&nbsp;&nbsp;D-cache 32 kB enabled<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I-cache 32 kB enabled<br>Board: 8568 MDS<br>I2C:&nbsp;&nbsp; ready<br>DRAM:&nbsp;&nbsp;Initializing<br>&nbsp;&nbsp; SDRAM: 64 MB<br>&nbsp;&nbsp; DDR: 512 MB<br>FLASH: 32 MB<br>L2 cache 512KB: enabled<br>&nbsp;&nbsp; PCI: 32 bit, 66 MHz, async, host, arbiter<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Scanning PCI bus 00<br>PCI on bus 00 - 00<br><br>&nbsp;&nbsp; PCIE connected to slot as Root Complex (base address e000a000)<br>PCIE on bus 01 - 01<br>In:&nbsp;&nbsp;&nbsp;&nbsp;serial<br>Out:&nbsp;&nbsp; serial<br>Err:&nbsp;&nbsp; serial<br>Net:&nbsp;&nbsp; UEC: PHY is Marvell 88E11x1 (1410cc2)<br>
UEC: PHY is Marvell 88E11x1 (1410cc2)<br>eTSEC0, eTSEC1, FSL UEC0, FSL UEC1<br>Hit any key to stop autoboot:&nbsp;&nbsp;0<br><br>## Checking Image at 02000100 ...<br>&nbsp;&nbsp;Image Name:&nbsp;&nbsp; Linux-2.6.25.5<br>&nbsp;&nbsp;Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>
&nbsp;&nbsp;Data Size:&nbsp;&nbsp;&nbsp;&nbsp;1325906 Bytes =&nbsp;&nbsp;1.3 MB<br>&nbsp;&nbsp;Load Address: 00000000<br>&nbsp;&nbsp;Entry Point:&nbsp;&nbsp;00000000<br>&nbsp;&nbsp;Verifying Checksum ... OK<br>## Booting image at 02000100 ...<br>&nbsp;&nbsp;Image Name:&nbsp;&nbsp; Linux-2.6.25.5<br>&nbsp;&nbsp;Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>
&nbsp;&nbsp;Data Size:&nbsp;&nbsp;&nbsp;&nbsp;1325906 Bytes =&nbsp;&nbsp;1.3 MB<br>&nbsp;&nbsp;Load Address: 00000000<br>&nbsp;&nbsp;Entry Point:&nbsp;&nbsp;00000000<br>&nbsp;&nbsp;Verifying Checksum ... OK<br>&nbsp;&nbsp;Uncompressing Kernel Image ... OK<br>## Loading RAMDisk Image at 02200100 ...<br>&nbsp;&nbsp;Image Name:&nbsp;&nbsp; initrd<br>
&nbsp;&nbsp;Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image (gzip compressed)<br>&nbsp;&nbsp;Data Size:&nbsp;&nbsp;&nbsp;&nbsp;3658144 Bytes =&nbsp;&nbsp;3.5 MB<br>&nbsp;&nbsp;Load Address: 00000000<br>&nbsp;&nbsp;Entry Point:&nbsp;&nbsp;00000000<br>&nbsp;&nbsp;Verifying Checksum ... OK<br>&nbsp;&nbsp;Booting using the fdt at 0x21f0100<br>
&nbsp;&nbsp;Loading Ramdisk to 00482000, end 007ff1a0 ... OK<br>&nbsp;&nbsp;Loading Device Tree to 007fa000, end 007fcfff ... OK<br>Using MPC85xx MDS machine description<br>Memory CAM mapping: CAM0=16Mb, CAM1=16Mb, CAM2=16Mb residual: 15Mb<br>
Linux version <a href="http://2.6.25.5">2.6.25.5</a> (ity10223@aqlbl05x) (gcc version 4.2.2) #1 Fri<br>Aug 29 16:44:02 CEST 2008<br>Found legacy serial port 0 for /soc8568@e0000000/serial@4500<br>mem=e0004500, taddr=e0004500, irq=0, clk=528000000, speed=0<br>
Found legacy serial port 1 for /soc8568@e0000000/serial@4600<br>mem=e0004600, taddr=e0004600, irq=0, clk=528000000, speed=0<br>console [udbg0] enabled<br>Entering add_active_range(0, 0, 12288) 0 entries of 256 used<br>setup_arch: bootmem<br>
mpc85xx_mds_setup_arch()<br>Found FSL PCI host bridge at 0x00000000e0008000. Firmware bus number:<br>0-&gt;0<br>PCI host bridge /soc8568@e0000000/pci@8000 (primary) ranges:<br>Found FSL PCI host bridge at 0x00000000e000a000. Firmware bus number:<br>
0-&gt;0<br>PCI host bridge /soc8568@e0000000/pcie@a000&nbsp;&nbsp;ranges:<br>arch: exit<br>Top of RAM: 0x3000000, Total RAM: 0x3000000<br>Memory hole size: 0MB<br>Zone PFN ranges:<br>DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp;&nbsp;12288<br>Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;12288 -&gt;&nbsp;&nbsp;&nbsp;&nbsp;12288<br>
Movable zone start PFN for each node<br>early_node_map[1] active PFN ranges<br>&nbsp;&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0 -&gt;&nbsp;&nbsp;&nbsp;&nbsp;12288<br>On node 0 totalpages: 12288<br>DMA zone: 96 pages used for memmap<br>DMA zone: 0 pages reserved<br>DMA zone: 12192 pages, LIFO batch:1<br>
Normal zone: 0 pages used for memmap<br>Movable zone: 0 pages used for memmap<br>Built 1 zonelists in Zone order, mobility grouping on.&nbsp;&nbsp;Total pages:<br>12192<br>Kernel command line:<br>mtdparts=physmap-flash.0:1M(boot),7M(aps0),7M(aps1),1M(optusr)<br>
console=ttyS0,115200 root=/dev/ram ramdisk_size=500000 rw ip=<a href="http://192.168.0.1">192.168.0.1</a><br>26:192.168.0.33:192.168.1.1:255.255.255.0:MPC8568MDS:eth0:off panic=1<br>mem=0x3f00000 aps=0<br>mpic: Setting up MPIC &quot; OpenPIC&nbsp;&nbsp;&quot; version 1.2 at e0040000, max 1 CPUs<br>
mpic: ISU size: 80, shift: 7, mask: 7f<br>mpic: Initializing for 80 sources<br>PID hash table entries: 256 (order: 8, 1024 bytes)<br>time_init: decrementer frequency = 66.000000 MHz<br>time_init: processor frequency&nbsp;&nbsp; = 1320.000000 MHz<br>
clocksource: timebase mult[3c9b26d] shift[22] registered<br>clockevent: decrementer mult[10e5] shift[16] cpu[0]<br>Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)<br>Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)<br>
Memory: 42240k/49152k available (2632k kernel code, 6892k reserved, 104k<br>data, 96k bss, 128k init)<br>SLUB: Genslabs=12, HWalign=32, Order=0-1, MinObjects=4, CPUs=1, Nodes=1<br>Calibrating delay loop... 131.58 BogoMIPS (lpj=263168)<br>
Mount-cache hash table entries: 512<br>net_namespace: 152 bytes<br>NET: Registered protocol family 16<br><br>PCI: Probing PCI hardware<br>Memory resource not set for host bridge 0<br>PCI: 0001:01:00.0: class b20 doesn&#39;t match header type 01. Ignoring<br>
class.<br>Memory resource not set for host bridge 1<br>PCI: Closing bogus Apple Firmware region 1 on bus 0x02<br>PCI: Closing bogus Apple Firmware region 2 on bus 0x02<br>PCI: Bridge: 0001:01:00.0<br>IO window: 0000-ffffffff<br>
MEM window: 0x00000000-0xffffffff<br>PREFETCH window: disabled.<br>PCI: Enabling device 0001:01:00.0 (0106 -&gt; 0107)<br>Registering qe_ic with sysfs...<br>SCSI subsystem initialized<br>NET: Registered protocol family 2<br>
Switched to high resolution mode on CPU 0<br>IP route cache hash table entries: 1024 (order: 0, 4096 bytes)<br>TCP established hash table entries: 2048 (order: 2, 16384 bytes)<br>TCP bind hash table entries: 2048 (order: 1, 8192 bytes)<br>
TCP: Hash tables configured (established 2048 bind 2048)<br>TCP reno registered<br>io scheduler noop registered<br>io scheduler anticipatory registered (default)<br>io scheduler deadline registered<br>io scheduler cfq registered<br>
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled<br>serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 42) is a 16550A<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;console<br>handover: boot [udbg0] -&gt; real [ttyS0]<br>
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 42) is a 16550A<br>brd: module loaded<br>loop: module loaded<br>Gianfar MII Bus: probed<br>eth0: Gianfar Ethernet Controller Version 1.2, 00:e0:0c:00:00:fd<br>eth0: Running with NAPI enabled<br>
eth0: 256/256 RX/TX BD ring size<br>eth1: Gianfar Ethernet Controller Version 1.2, 00:e0:0c:00:01:fd<br>eth1: Running with NAPI enabled<br>eth1: 256/256 RX/TX BD ring size<br>i2c /dev entries driver<br>rtc-ds1374 0-0068: rtc core: registered rtc-ds1374 as rtc0<br>
TCP cubic registered<br>NET: Registered protocol family 1<br>NET: Registered protocol family 17<br>RPC: Registered udp transport module.<br>RPC: Registered tcp transport module.<br>rtc-ds1374 0-0068: setting system clock to 1970-07-19 01:19:19 UTC<br>
(17198359)<br>IP-Config: Gateway not on directly connected network.<br>List of all partitions:<br>0100&nbsp;&nbsp;&nbsp;&nbsp; 500000 ram0 (driver?)<br>0101&nbsp;&nbsp;&nbsp;&nbsp; 500000 ram1 (driver?)<br>0102&nbsp;&nbsp;&nbsp;&nbsp; 500000 ram2 (driver?)<br>0103&nbsp;&nbsp;&nbsp;&nbsp; 500000 ram3 (driver?)<br>
0104&nbsp;&nbsp;&nbsp;&nbsp; 500000 ram4 (driver?)<br>0105&nbsp;&nbsp;&nbsp;&nbsp; 500000 ram5 (driver?)<br>0106&nbsp;&nbsp;&nbsp;&nbsp; 500000 ram6 (driver?)<br>0107&nbsp;&nbsp;&nbsp;&nbsp; 500000 ram7 (driver?)<br>0108&nbsp;&nbsp;&nbsp;&nbsp; 500000 ram8 (driver?)<br>0109&nbsp;&nbsp;&nbsp;&nbsp; 500000 ram9 (driver?)<br>010a&nbsp;&nbsp;&nbsp;&nbsp; 500000 ram10 (driver?)<br>
010b&nbsp;&nbsp;&nbsp;&nbsp; 500000 ram11 (driver?)<br>010c&nbsp;&nbsp;&nbsp;&nbsp; 500000 ram12 (driver?)<br>010d&nbsp;&nbsp;&nbsp;&nbsp; 500000 ram13 (driver?)<br>010e&nbsp;&nbsp;&nbsp;&nbsp; 500000 ram14 (driver?)<br>010f&nbsp;&nbsp;&nbsp;&nbsp; 500000 ram15 (driver?)<br>No filesystem could mount root, tried:&nbsp;&nbsp;ext3 ext2<br>
Kernel panic - not syncing: VFS: Unable to mount root fs on<br>unknown-block(1,0)<br>Rebooting in 1 seconds..<br><br>The U-Boot is quite old but is what I found on the board, I just change<br>the envirinment variables<br>
<br>ramboot=run ramargs;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr<br>$bootfile;bootm $loadaddr $ramdiskaddr<br>nfsboot=run nfsargs;tftp $loadaddr $bootfile;tftp $fdtaddr<br>$fdtfile;bootm $loadaddr - $fdtaddr<br>bootdelay=10<br>
baudrate=115200<br>loads_echo=1<br>ethaddr=00:E0:0C:00:00:FD<br>eth1addr=00:E0:0C:00:01:FD<br>eth2addr=00:E0:0C:00:02:FD<br>eth3addr=00:E0:0C:00:03:FD<br>rootpath=/nfsroot<br>bootfile=your.uImage<br>netdev=eth0<br>consoledev=ttyS0<br>
ramdiskaddr=600000<br>ramdiskfile=your.ramdisk.u-boot<br>fdtaddr=400000<br>fdtfile=your.fdt.dtb<br>nfsargs=setenv bootargs root=/dev/nfs rw nfsroot=$serverip:$rootpath<br>ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname:$netdev:off<br>
console=$consoledev,$bau<br>drate $othbootargs<br>ramargs=setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate<br>$othbootargs<br>bootargs=root=/dev/ram rw console=ttyS0,115200<br>bootcmdAQ=if itest ${aps} == 0; then run dl_ram0; else run dl_ram1;fi<br>
ethact=eTSEC0<br>filesize=4E0E64<br>fileaddr=2000000<br>gatewayip=<a href="http://192.168.1.1">192.168.1.1</a><br>netmask=<a href="http://255.255.255.0">255.255.255.0</a><br>ipaddr=<a href="http://192.168.0.126">192.168.0.126</a><br>
serverip=<a href="http://192.168.0.33">192.168.0.33</a><br>bootcmdFREE=run ramargs;cp.b fff00000 400000 3500;bootm ff800000<br>ffa00000 400000<br>myaps=MPC8568MDS/aps<br>mtdargs=mtdparts=physmap-flash.0:1M(boot),7M(aps0),7M(aps1),1M(optusr)<br>
pram=0x100000<br>mem=0x3f00000<br>pram_start=0x3f00000<br>loadaddr=0x2000000<br>aps0_fl_start=0xfe100000<br>aps0_fl_size=0x00700000<br>aps1_fl_start=0xfe800000<br>aps1_fl_end=0xfeefffff<br>aps1_fl_size=0x00700000<br>aps_ram_start=0x2000000<br>
aps_ram_kernel_start=0x2000100<br>aps_ram_dtb_start=0x21f0100<br>aps_ram_rootfs_start=0x2200100<br>aps=0<br>dl_boot=tftp ${aps_ram_start} &quot;u-boot.bin&quot; &amp;&amp; protect off 0xfe000000<br>0xfe07ffff &amp;&amp; cp.b ${aps_ram_start} 0xfe000000 ${filesize} &amp;&amp; protect on<br>
0xfe000000 0xf<br>e07ffff &amp;&amp; saveenv<br>bootcmd=if itest ${aps} == 0; then run dl_ram0; else run dl_ram1;fi<br>altbootcmd=mw.b ${pram_start} 0 ${pram} &amp;&amp; if itest ${aps} == 0; then<br>setenv aps 1; else setenv aps 0; fi; saveenv; run bootcmd<br>
dl_ram0=cp.b ${aps0_fl_start} ${aps_ram_start} ${aps0_fl_size};if imi<br>${aps_ram_kernel_start}; then run bargs;bootm ${aps_ram_kernel_start}<br>${aps_ram_rootfs<br>_start} ${aps_ram_dtb_start}; else reset; fi<br>dl_ram1=cp.b ${aps1_fl_start} ${aps_ram_start} ${aps1_fl_size};if imi<br>
${aps_ram_kernel_start}; then run bargs;bootm ${aps_ram_kernel_start}<br>${aps_ram_rootfs<br>_start} ${aps_ram_dtb_start}; else reset; fi<br>bootlimit=5<br>initrd_high=no<br>hostname=MPC8568MDS<br>aps0_fl_end=0xfe7fffff<br>
dl_aps0=tftp ${aps_ram_start} ${myaps};erase ${aps0_fl_start}<br>${aps0_fl_end};cp.b ${aps_ram_start} ${aps0_fl_start} ${filesize};boot<br>dl_aps1=tftp ${aps_ram_start} ${myaps};erase ${aps1_fl_start}<br>${aps1_fl_end};cp.b ${aps_ram_start} ${aps1_fl_start} ${filesize};boot<br>
bargs=setenv bootargs ${mtdargs} console=ttyS0,$baudrate root=/dev/ram<br>ramdisk_size=500000 rw<br>ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:e<br>th0:off panic=1 mem=${mem} aps=${aps} ${misc} ${slram}<br>
stdin=serial<br>stdout=serial<br>stderr=serial<br><br>Environment size: 2857/8188 bytes<br><br>I am using linux2.6.25-denx with the followind mpc8568mds_defconfig<br><br>&gt;&gt; cat kernel/linux/arch/powerpc/configs/mpc8568mds_defconfig<br>
#<br># Automatically generated make config: don&#39;t edit<br># Linux kernel version: <a href="http://2.6.25.5">2.6.25.5</a><br># Fri Aug 29 16:33:50 2008<br>#<br># CONFIG_PPC64 is not set<br><br>#<br># Processor support<br>
#<br># CONFIG_6xx is not set<br>CONFIG_PPC_85xx=y<br># CONFIG_PPC_8xx is not set<br># CONFIG_40x is not set<br># CONFIG_44x is not set<br># CONFIG_E200 is not set<br>CONFIG_E500=y<br>CONFIG_BOOKE=y<br>CONFIG_FSL_BOOKE=y<br>
CONFIG_FSL_EMB_PERFMON=y<br># CONFIG_PHYS_64BIT is not set<br>CONFIG_SPE=y<br># CONFIG_PPC_MM_SLICES is not set<br>CONFIG_PPC32=y<br>CONFIG_WORD_SIZE=32<br>CONFIG_PPC_MERGE=y<br>CONFIG_MMU=y<br>CONFIG_GENERIC_CMOS_UPDATE=y<br>
CONFIG_GENERIC_TIME=y<br>CONFIG_GENERIC_TIME_VSYSCALL=y<br>CONFIG_GENERIC_CLOCKEVENTS=y<br>CONFIG_GENERIC_HARDIRQS=y<br># CONFIG_HAVE_SETUP_PER_CPU_AREA is not set<br>CONFIG_IRQ_PER_CPU=y<br>CONFIG_RWSEM_XCHGADD_ALGORITHM=y<br>
CONFIG_ARCH_HAS_ILOG2_U32=y<br>CONFIG_GENERIC_HWEIGHT=y<br>CONFIG_GENERIC_CALIBRATE_DELAY=y<br>CONFIG_GENERIC_FIND_NEXT_BIT=y<br># CONFIG_ARCH_NO_VIRT_TO_BUS is not set<br>CONFIG_PPC=y<br>CONFIG_EARLY_PRINTK=y<br>CONFIG_GENERIC_NVRAM=y<br>
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y<br>CONFIG_ARCH_MAY_HAVE_PC_FDC=y<br>CONFIG_PPC_OF=y<br>CONFIG_OF=y<br>CONFIG_PPC_UDBG_16550=y<br># CONFIG_GENERIC_TBSYNC is not set<br>CONFIG_AUDIT_ARCH=y<br>CONFIG_GENERIC_BUG=y<br>
CONFIG_DEFAULT_UIMAGE=y<br># CONFIG_PPC_DCR_NATIVE is not set<br># CONFIG_PPC_DCR_MMIO is not set<br>CONFIG_DEFCONFIG_LIST=&quot;/lib/modules/$UNAME_RELEASE/.config&quot;<br><br>#<br># General setup<br>#<br>CONFIG_EXPERIMENTAL=y<br>
CONFIG_BROKEN_ON_SMP=y<br>CONFIG_INIT_ENV_ARG_LIMIT=32<br>CONFIG_LOCALVERSION=&quot;&quot;<br>CONFIG_LOCALVERSION_AUTO=y<br>CONFIG_SWAP=y<br>CONFIG_SYSVIPC=y<br>CONFIG_SYSVIPC_SYSCTL=y<br># CONFIG_POSIX_MQUEUE is not set<br>
# CONFIG_BSD_PROCESS_ACCT is not set<br># CONFIG_TASKSTATS is not set<br># CONFIG_AUDIT is not set<br># CONFIG_IKCONFIG is not set<br>CONFIG_LOG_BUF_SHIFT=14<br># CONFIG_CGROUPS is not set<br>CONFIG_GROUP_SCHED=y<br># CONFIG_FAIR_GROUP_SCHED is not set<br>
# CONFIG_RT_GROUP_SCHED is not set<br>CONFIG_USER_SCHED=y<br># CONFIG_CGROUP_SCHED is not set<br>CONFIG_SYSFS_DEPRECATED=y<br>CONFIG_SYSFS_DEPRECATED_V2=y<br># CONFIG_RELAY is not set<br># CONFIG_NAMESPACES is not set<br>
# CONFIG_BLK_DEV_INITRD is not set<br># CONFIG_CC_OPTIMIZE_FOR_SIZE is not set<br>CONFIG_SYSCTL=y<br>CONFIG_EMBEDDED=y<br>CONFIG_SYSCTL_SYSCALL=y<br># CONFIG_KALLSYMS is not set<br>CONFIG_HOTPLUG=y<br>CONFIG_PRINTK=y<br># CONFIG_LOGBUFFER is not set<br>
CONFIG_BUG=y<br>CONFIG_ELF_CORE=y<br>CONFIG_COMPAT_BRK=y<br>CONFIG_BASE_FULL=y<br>CONFIG_FUTEX=y<br>CONFIG_ANON_INODES=y<br># CONFIG_EPOLL is not set<br>CONFIG_SIGNALFD=y<br>CONFIG_TIMERFD=y<br>CONFIG_EVENTFD=y<br>CONFIG_SHMEM=y<br>
CONFIG_VM_EVENT_COUNTERS=y<br>CONFIG_SLUB_DEBUG=y<br># CONFIG_SLAB is not set<br>CONFIG_SLUB=y<br># CONFIG_SLOB is not set<br># CONFIG_PROFILING is not set<br># CONFIG_MARKERS is not set<br>CONFIG_HAVE_OPROFILE=y<br>CONFIG_HAVE_KPROBES=y<br>
CONFIG_HAVE_KRETPROBES=y<br>CONFIG_PROC_PAGE_MONITOR=y<br>CONFIG_SLABINFO=y<br>CONFIG_RT_MUTEXES=y<br># CONFIG_TINY_SHMEM is not set<br>CONFIG_BASE_SMALL=0<br>CONFIG_MODULES=y<br>CONFIG_MODULE_UNLOAD=y<br># CONFIG_MODULE_FORCE_UNLOAD is not set<br>
# CONFIG_MODVERSIONS is not set<br># CONFIG_MODULE_SRCVERSION_ALL is not set<br># CONFIG_KMOD is not set<br>CONFIG_BLOCK=y<br># CONFIG_LBD is not set<br># CONFIG_BLK_DEV_IO_TRACE is not set<br># CONFIG_LSF is not set<br># CONFIG_BLK_DEV_BSG is not set<br>
<br>#<br># IO Schedulers<br>#<br>CONFIG_IOSCHED_NOOP=y<br>CONFIG_IOSCHED_AS=y<br>CONFIG_IOSCHED_DEADLINE=y<br>CONFIG_IOSCHED_CFQ=y<br>CONFIG_DEFAULT_AS=y<br># CONFIG_DEFAULT_DEADLINE is not set<br># CONFIG_DEFAULT_CFQ is not set<br>
# CONFIG_DEFAULT_NOOP is not set<br>CONFIG_DEFAULT_IOSCHED=&quot;anticipatory&quot;<br>CONFIG_CLASSIC_RCU=y<br><br>#<br># Platform support<br>#<br># CONFIG_PPC_MPC512x is not set<br># CONFIG_PPC_MPC5121 is not set<br># CONFIG_PPC_CELL is not set<br>
# CONFIG_PPC_CELL_NATIVE is not set<br># CONFIG_PQ2ADS is not set<br>CONFIG_MPC85xx=y<br># CONFIG_MPC8540_ADS is not set<br># CONFIG_MPC8560_ADS is not set<br># CONFIG_MPC85xx_CDS is not set<br>CONFIG_MPC85xx_MDS=y<br># CONFIG_MPC85xx_DS is not set<br>
# CONFIG_STX_GP3 is not set<br># CONFIG_TQM8540 is not set<br># CONFIG_TQM8541 is not set<br># CONFIG_TQM8555 is not set<br># CONFIG_TQM8560 is not set<br># CONFIG_SBC8548 is not set<br># CONFIG_SBC8560 is not set<br># CONFIG_IPIC is not set<br>
CONFIG_MPIC=y<br># CONFIG_MPIC_WEIRD is not set<br># CONFIG_PPC_I8259 is not set<br># CONFIG_PPC_RTAS is not set<br># CONFIG_MMIO_NVRAM is not set<br># CONFIG_PPC_MPC106 is not set<br># CONFIG_PPC_970_NAP is not set<br># CONFIG_PPC_INDIRECT_IO is not set<br>
# CONFIG_GENERIC_IOMAP is not set<br># CONFIG_CPU_FREQ is not set<br>CONFIG_QUICC_ENGINE=y<br># CONFIG_CPM2 is not set<br># CONFIG_FSL_ULI1575 is not set<br><br>#<br># Kernel options<br>#<br># CONFIG_HIGHMEM is not set<br>
CONFIG_TICK_ONESHOT=y<br>CONFIG_NO_HZ=y<br>CONFIG_HIGH_RES_TIMERS=y<br>CONFIG_GENERIC_CLOCKEVENTS_BUILD=y<br># CONFIG_HZ_100 is not set<br>CONFIG_HZ_250=y<br># CONFIG_HZ_300 is not set<br># CONFIG_HZ_1000 is not set<br>CONFIG_HZ=250<br>
# CONFIG_SCHED_HRTICK is not set<br>CONFIG_PREEMPT_NONE=y<br># CONFIG_PREEMPT_VOLUNTARY is not set<br># CONFIG_PREEMPT is not set<br>CONFIG_BINFMT_ELF=y<br># CONFIG_BINFMT_MISC is not set<br>CONFIG_MATH_EMULATION=y<br># CONFIG_IOMMU_HELPER is not set<br>
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y<br>CONFIG_ARCH_HAS_WALK_MEMORY=y<br>CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y<br>CONFIG_ARCH_FLATMEM_ENABLE=y<br>CONFIG_ARCH_POPULATES_NODE_MAP=y<br>CONFIG_SELECT_MEMORY_MODEL=y<br>CONFIG_FLATMEM_MANUAL=y<br>
# CONFIG_DISCONTIGMEM_MANUAL is not set<br># CONFIG_SPARSEMEM_MANUAL is not set<br>CONFIG_FLATMEM=y<br>CONFIG_FLAT_NODE_MEM_MAP=y<br># CONFIG_SPARSEMEM_STATIC is not set<br># CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set<br>
CONFIG_SPLIT_PTLOCK_CPUS=4<br># CONFIG_RESOURCES_64BIT is not set<br>CONFIG_ZONE_DMA_FLAG=1<br>CONFIG_BOUNCE=y<br>CONFIG_VIRT_TO_BUS=y<br>CONFIG_PROC_DEVICETREE=y<br># CONFIG_CMDLINE_BOOL is not set<br># CONFIG_PM is not set<br>
CONFIG_SECCOMP=y<br>CONFIG_ISA_DMA_API=y<br><br>#<br># Bus options<br>#<br>CONFIG_ZONE_DMA=y<br>CONFIG_PPC_INDIRECT_PCI=y<br>CONFIG_FSL_SOC=y<br>CONFIG_FSL_PCI=y<br>CONFIG_PCI=y<br>CONFIG_PCI_DOMAINS=y<br>CONFIG_PCI_SYSCALL=y<br>
# CONFIG_PCIEPORTBUS is not set<br>CONFIG_ARCH_SUPPORTS_MSI=y<br># CONFIG_PCI_MSI is not set<br>CONFIG_PCI_LEGACY=y<br># CONFIG_PCI_DEBUG is not set<br># CONFIG_PCCARD is not set<br># CONFIG_HOTPLUG_PCI is not set<br><br>
#<br># Advanced setup<br>#<br># CONFIG_ADVANCED_OPTIONS is not set<br><br>#<br># Default settings for advanced configuration options are used<br>#<br>CONFIG_HIGHMEM_START=0xfe000000<br>CONFIG_LOWMEM_SIZE=0x30000000<br>CONFIG_KERNEL_START=0xc0000000<br>
CONFIG_TASK_SIZE=0xc0000000<br>CONFIG_BOOT_LOAD=0x00800000<br><br>#<br># Networking<br>#<br>CONFIG_NET=y<br><br>#<br># Networking options<br>#<br>CONFIG_PACKET=y<br># CONFIG_PACKET_MMAP is not set<br>CONFIG_UNIX=y<br>CONFIG_XFRM=y<br>
# CONFIG_XFRM_USER is not set<br># CONFIG_XFRM_SUB_POLICY is not set<br># CONFIG_XFRM_MIGRATE is not set<br># CONFIG_XFRM_STATISTICS is not set<br># CONFIG_NET_KEY is not set<br>CONFIG_INET=y<br>CONFIG_IP_MULTICAST=y<br># CONFIG_IP_ADVANCED_ROUTER is not set<br>
CONFIG_IP_FIB_HASH=y<br>CONFIG_IP_PNP=y<br>CONFIG_IP_PNP_DHCP=y<br>CONFIG_IP_PNP_BOOTP=y<br># CONFIG_IP_PNP_RARP is not set<br># CONFIG_NET_IPIP is not set<br># CONFIG_NET_IPGRE is not set<br># CONFIG_IP_MROUTE is not set<br>
# CONFIG_ARPD is not set<br>CONFIG_SYN_COOKIES=y<br># CONFIG_INET_AH is not set<br># CONFIG_INET_ESP is not set<br># CONFIG_INET_IPCOMP is not set<br># CONFIG_INET_XFRM_TUNNEL is not set<br># CONFIG_INET_TUNNEL is not set<br>
CONFIG_INET_XFRM_MODE_TRANSPORT=y<br>CONFIG_INET_XFRM_MODE_TUNNEL=y<br>CONFIG_INET_XFRM_MODE_BEET=y<br># CONFIG_INET_LRO is not set<br>CONFIG_INET_DIAG=y<br>CONFIG_INET_TCP_DIAG=y<br># CONFIG_TCP_CONG_ADVANCED is not set<br>
CONFIG_TCP_CONG_CUBIC=y<br>CONFIG_DEFAULT_TCP_CONG=&quot;cubic&quot;<br># CONFIG_TCP_MD5SIG is not set<br># CONFIG_IPV6 is not set<br># CONFIG_INET6_XFRM_TUNNEL is not set<br># CONFIG_INET6_TUNNEL is not set<br># CONFIG_NETWORK_SECMARK is not set<br>
# CONFIG_NETFILTER is not set<br># CONFIG_IP_DCCP is not set<br># CONFIG_IP_SCTP is not set<br># CONFIG_TIPC is not set<br># CONFIG_ATM is not set<br># CONFIG_BRIDGE is not set<br># CONFIG_VLAN_8021Q is not set<br># CONFIG_DECNET is not set<br>
# CONFIG_LLC2 is not set<br># CONFIG_IPX is not set<br># CONFIG_ATALK is not set<br># CONFIG_X25 is not set<br># CONFIG_LAPB is not set<br># CONFIG_ECONET is not set<br># CONFIG_WAN_ROUTER is not set<br># CONFIG_NET_SCHED is not set<br>
<br>#<br># Network testing<br>#<br># CONFIG_NET_PKTGEN is not set<br># CONFIG_HAMRADIO is not set<br># CONFIG_CAN is not set<br># CONFIG_IRDA is not set<br># CONFIG_BT is not set<br># CONFIG_AF_RXRPC is not set<br><br>#<br>
# Wireless<br>#<br># CONFIG_CFG80211 is not set<br># CONFIG_WIRELESS_EXT is not set<br># CONFIG_MAC80211 is not set<br># CONFIG_IEEE80211 is not set<br># CONFIG_RFKILL is not set<br># CONFIG_NET_9P is not set<br><br>#<br>
# Device Drivers<br>#<br><br>#<br># Generic Driver Options<br>#<br>CONFIG_UEVENT_HELPER_PATH=&quot;/sbin/hotplug&quot;<br>CONFIG_STANDALONE=y<br>CONFIG_PREVENT_FIRMWARE_BUILD=y<br># CONFIG_FW_LOADER is not set<br># CONFIG_DEBUG_DRIVER is not set<br>
# CONFIG_DEBUG_DEVRES is not set<br># CONFIG_SYS_HYPERVISOR is not set<br># CONFIG_CONNECTOR is not set<br># CONFIG_MTD is not set<br>CONFIG_OF_DEVICE=y<br># CONFIG_PARPORT is not set<br>CONFIG_BLK_DEV=y<br># CONFIG_BLK_DEV_FD is not set<br>
# CONFIG_BLK_CPQ_DA is not set<br># CONFIG_BLK_CPQ_CISS_DA is not set<br># CONFIG_BLK_DEV_DAC960 is not set<br># CONFIG_BLK_DEV_UMEM is not set<br># CONFIG_BLK_DEV_COW_COMMON is not set<br>CONFIG_BLK_DEV_LOOP=y<br># CONFIG_BLK_DEV_CRYPTOLOOP is not set<br>
# CONFIG_BLK_DEV_NBD is not set<br># CONFIG_BLK_DEV_SX8 is not set<br>CONFIG_BLK_DEV_RAM=y<br>CONFIG_BLK_DEV_RAM_COUNT=16<br>CONFIG_BLK_DEV_RAM_SIZE=32768<br># CONFIG_BLK_DEV_XIP is not set<br># CONFIG_CDROM_PKTCDVD is not set<br>
# CONFIG_ATA_OVER_ETH is not set<br>CONFIG_MISC_DEVICES=y<br># CONFIG_PHANTOM is not set<br># CONFIG_EEPROM_93CX6 is not set<br># CONFIG_SGI_IOC4 is not set<br># CONFIG_TIFM_CORE is not set<br># CONFIG_ENCLOSURE_SERVICES is not set<br>
CONFIG_HAVE_IDE=y<br># CONFIG_IDE is not set<br><br>#<br># SCSI device support<br>#<br># CONFIG_RAID_ATTRS is not set<br>CONFIG_SCSI=y<br>CONFIG_SCSI_DMA=y<br># CONFIG_SCSI_TGT is not set<br># CONFIG_SCSI_NETLINK is not set<br>
CONFIG_SCSI_PROC_FS=y<br><br>#<br># SCSI support type (disk, tape, CD-ROM)<br>#<br># CONFIG_BLK_DEV_SD is not set<br># CONFIG_CHR_DEV_ST is not set<br># CONFIG_CHR_DEV_OSST is not set<br># CONFIG_BLK_DEV_SR is not set<br>
# CONFIG_CHR_DEV_SG is not set<br># CONFIG_CHR_DEV_SCH is not set<br><br>#<br># Some SCSI devices (e.g. CD jukebox) support multiple LUNs<br>#<br># CONFIG_SCSI_MULTI_LUN is not set<br># CONFIG_SCSI_CONSTANTS is not set<br>
# CONFIG_SCSI_LOGGING is not set<br># CONFIG_SCSI_SCAN_ASYNC is not set<br>CONFIG_SCSI_WAIT_SCAN=m<br><br>#<br># SCSI Transports<br>#<br># CONFIG_SCSI_SPI_ATTRS is not set<br># CONFIG_SCSI_FC_ATTRS is not set<br># CONFIG_SCSI_ISCSI_ATTRS is not set<br>
# CONFIG_SCSI_SAS_LIBSAS is not set<br># CONFIG_SCSI_SRP_ATTRS is not set<br>CONFIG_SCSI_LOWLEVEL=y<br># CONFIG_ISCSI_TCP is not set<br># CONFIG_BLK_DEV_3W_XXXX_RAID is not set<br># CONFIG_SCSI_3W_9XXX is not set<br># CONFIG_SCSI_ACARD is not set<br>
# CONFIG_SCSI_AACRAID is not set<br># CONFIG_SCSI_AIC7XXX is not set<br># CONFIG_SCSI_AIC7XXX_OLD is not set<br># CONFIG_SCSI_AIC79XX is not set<br># CONFIG_SCSI_AIC94XX is not set<br># CONFIG_SCSI_DPT_I2O is not set<br># CONFIG_SCSI_ADVANSYS is not set<br>
# CONFIG_SCSI_ARCMSR is not set<br># CONFIG_MEGARAID_NEWGEN is not set<br># CONFIG_MEGARAID_LEGACY is not set<br># CONFIG_MEGARAID_SAS is not set<br># CONFIG_SCSI_HPTIOP is not set<br># CONFIG_SCSI_BUSLOGIC is not set<br>
# CONFIG_SCSI_DMX3191D is not set<br># CONFIG_SCSI_EATA is not set<br># CONFIG_SCSI_FUTURE_DOMAIN is not set<br># CONFIG_SCSI_GDTH is not set<br># CONFIG_SCSI_IPS is not set<br># CONFIG_SCSI_INITIO is not set<br># CONFIG_SCSI_INIA100 is not set<br>
# CONFIG_SCSI_MVSAS is not set<br># CONFIG_SCSI_STEX is not set<br># CONFIG_SCSI_SYM53C8XX_2 is not set<br># CONFIG_SCSI_QLOGIC_1280 is not set<br># CONFIG_SCSI_QLA_FC is not set<br># CONFIG_SCSI_QLA_ISCSI is not set<br># CONFIG_SCSI_LPFC is not set<br>
# CONFIG_SCSI_DC395x is not set<br># CONFIG_SCSI_DC390T is not set<br># CONFIG_SCSI_NSP32 is not set<br># CONFIG_SCSI_DEBUG is not set<br># CONFIG_SCSI_SRP is not set<br># CONFIG_ATA is not set<br># CONFIG_MD is not set<br>
# CONFIG_FUSION is not set<br><br>#<br># IEEE 1394 (FireWire) support<br>#<br># CONFIG_FIREWIRE is not set<br># CONFIG_IEEE1394 is not set<br># CONFIG_I2O is not set<br># CONFIG_MACINTOSH_DRIVERS is not set<br>CONFIG_NETDEVICES=y<br>
# CONFIG_NETDEVICES_MULTIQUEUE is not set<br># CONFIG_DUMMY is not set<br># CONFIG_BONDING is not set<br># CONFIG_MACVLAN is not set<br># CONFIG_EQUALIZER is not set<br># CONFIG_TUN is not set<br># CONFIG_VETH is not set<br>
# CONFIG_ARCNET is not set<br>CONFIG_PHYLIB=y<br><br>#<br># MII PHY device drivers<br>#<br>CONFIG_MARVELL_PHY=y<br># CONFIG_DAVICOM_PHY is not set<br># CONFIG_QSEMI_PHY is not set<br># CONFIG_LXT_PHY is not set<br># CONFIG_CICADA_PHY is not set<br>
# CONFIG_VITESSE_PHY is not set<br># CONFIG_SMSC_PHY is not set<br># CONFIG_BROADCOM_PHY is not set<br># CONFIG_ICPLUS_PHY is not set<br># CONFIG_REALTEK_PHY is not set<br># CONFIG_FIXED_PHY is not set<br># CONFIG_MDIO_BITBANG is not set<br>
CONFIG_NET_ETHERNET=y<br>CONFIG_MII=y<br># CONFIG_HAPPYMEAL is not set<br># CONFIG_SUNGEM is not set<br># CONFIG_CASSINI is not set<br># CONFIG_NET_VENDOR_3COM is not set<br># CONFIG_NET_TULIP is not set<br># CONFIG_HP100 is not set<br>
# CONFIG_IBM_NEW_EMAC_ZMII is not set<br># CONFIG_IBM_NEW_EMAC_RGMII is not set<br># CONFIG_IBM_NEW_EMAC_TAH is not set<br># CONFIG_IBM_NEW_EMAC_EMAC4 is not set<br># CONFIG_NET_PCI is not set<br># CONFIG_B44 is not set<br>
CONFIG_NETDEV_1000=y<br># CONFIG_ACENIC is not set<br># CONFIG_DL2K is not set<br># CONFIG_E1000 is not set<br># CONFIG_E1000E is not set<br># CONFIG_E1000E_ENABLED is not set<br># CONFIG_IP1000 is not set<br># CONFIG_IGB is not set<br>
# CONFIG_NS83820 is not set<br># CONFIG_HAMACHI is not set<br># CONFIG_YELLOWFIN is not set<br># CONFIG_R8169 is not set<br># CONFIG_SIS190 is not set<br># CONFIG_SKGE is not set<br># CONFIG_SKY2 is not set<br># CONFIG_SK98LIN is not set<br>
# CONFIG_VIA_VELOCITY is not set<br># CONFIG_TIGON3 is not set<br># CONFIG_BNX2 is not set<br>CONFIG_GIANFAR=y<br>CONFIG_GFAR_NAPI=y<br># CONFIG_UCC_GETH is not set<br># CONFIG_QLA3XXX is not set<br># CONFIG_ATL1 is not set<br>
CONFIG_NETDEV_10000=y<br># CONFIG_CHELSIO_T1 is not set<br># CONFIG_CHELSIO_T3 is not set<br># CONFIG_IXGBE is not set<br># CONFIG_IXGB is not set<br># CONFIG_S2IO is not set<br># CONFIG_MYRI10GE is not set<br># CONFIG_NETXEN_NIC is not set<br>
# CONFIG_NIU is not set<br># CONFIG_MLX4_CORE is not set<br># CONFIG_TEHUTI is not set<br># CONFIG_BNX2X is not set<br># CONFIG_TR is not set<br><br>#<br># Wireless LAN<br>#<br># CONFIG_WLAN_PRE80211 is not set<br># CONFIG_WLAN_80211 is not set<br>
# CONFIG_WAN is not set<br># CONFIG_FDDI is not set<br># CONFIG_HIPPI is not set<br># CONFIG_PPP is not set<br># CONFIG_SLIP is not set<br># CONFIG_NET_FC is not set<br># CONFIG_NETCONSOLE is not set<br># CONFIG_NETPOLL is not set<br>
# CONFIG_NET_POLL_CONTROLLER is not set<br># CONFIG_ISDN is not set<br># CONFIG_PHONE is not set<br><br>#<br># Input device support<br>#<br>CONFIG_INPUT=y<br># CONFIG_INPUT_FF_MEMLESS is not set<br># CONFIG_INPUT_POLLDEV is not set<br>
<br>#<br># Userland interfaces<br>#<br># CONFIG_INPUT_MOUSEDEV is not set<br># CONFIG_INPUT_JOYDEV is not set<br># CONFIG_INPUT_EVDEV is not set<br># CONFIG_INPUT_EVBUG is not set<br><br>#<br># Input Device Drivers<br>#<br>
# CONFIG_INPUT_KEYBOARD is not set<br># CONFIG_INPUT_MOUSE is not set<br># CONFIG_INPUT_JOYSTICK is not set<br># CONFIG_INPUT_TABLET is not set<br># CONFIG_INPUT_TOUCHSCREEN is not set<br># CONFIG_INPUT_MISC is not set<br>
<br>#<br># Hardware I/O ports<br>#<br># CONFIG_SERIO is not set<br># CONFIG_GAMEPORT is not set<br><br>#<br># Character devices<br>#<br># CONFIG_VT is not set<br># CONFIG_SERIAL_NONSTANDARD is not set<br># CONFIG_NOZOMI is not set<br>
<br>#<br># Serial drivers<br>#<br>CONFIG_SERIAL_8250=y<br>CONFIG_SERIAL_8250_CONSOLE=y<br>CONFIG_SERIAL_8250_PCI=y<br>CONFIG_SERIAL_8250_NR_UARTS=4<br>CONFIG_SERIAL_8250_RUNTIME_UARTS=4<br># CONFIG_SERIAL_8250_EXTENDED is not set<br>
CONFIG_SERIAL_8250_SHARE_IRQ=y<br><br>#<br># Non-8250 serial port support<br>#<br># CONFIG_SERIAL_UARTLITE is not set<br>CONFIG_SERIAL_CORE=y<br>CONFIG_SERIAL_CORE_CONSOLE=y<br># CONFIG_SERIAL_JSM is not set<br># CONFIG_SERIAL_OF_PLATFORM is not set<br>
# CONFIG_SERIAL_QE is not set<br>CONFIG_UNIX98_PTYS=y<br>CONFIG_LEGACY_PTYS=y<br>CONFIG_LEGACY_PTY_COUNT=256<br># CONFIG_IPMI_HANDLER is not set<br>CONFIG_HW_RANDOM=y<br># CONFIG_NVRAM is not set<br># CONFIG_GEN_RTC is not set<br>
# CONFIG_R3964 is not set<br># CONFIG_APPLICOM is not set<br># CONFIG_RAW_DRIVER is not set<br># CONFIG_TCG_TPM is not set<br>CONFIG_DEVPORT=y<br>CONFIG_I2C=y<br>CONFIG_I2C_BOARDINFO=y<br>CONFIG_I2C_CHARDEV=y<br><br>#<br>
# I2C Algorithms<br>#<br># CONFIG_I2C_ALGOBIT is not set<br># CONFIG_I2C_ALGOPCF is not set<br># CONFIG_I2C_ALGOPCA is not set<br><br>#<br># I2C Hardware Bus support<br>#<br># CONFIG_I2C_ALI1535 is not set<br># CONFIG_I2C_ALI1563 is not set<br>
# CONFIG_I2C_ALI15X3 is not set<br># CONFIG_I2C_AMD756 is not set<br># CONFIG_I2C_AMD8111 is not set<br># CONFIG_I2C_I801 is not set<br># CONFIG_I2C_I810 is not set<br># CONFIG_I2C_PIIX4 is not set<br># CONFIG_I2C_IBM_OF is not set<br>
CONFIG_I2C_MPC=y<br># CONFIG_I2C_MPC8260 is not set<br># CONFIG_I2C_NFORCE2 is not set<br># CONFIG_I2C_OCORES is not set<br># CONFIG_I2C_PARPORT_LIGHT is not set<br># CONFIG_I2C_PROSAVAGE is not set<br># CONFIG_I2C_SAVAGE4 is not set<br>
# CONFIG_I2C_SIMTEC is not set<br># CONFIG_I2C_SIS5595 is not set<br># CONFIG_I2C_SIS630 is not set<br># CONFIG_I2C_SIS96X is not set<br># CONFIG_I2C_TAOS_EVM is not set<br># CONFIG_I2C_STUB is not set<br># CONFIG_I2C_VIA is not set<br>
# CONFIG_I2C_VIAPRO is not set<br># CONFIG_I2C_VOODOO3 is not set<br><br>#<br># Miscellaneous I2C Chip support<br>#<br># CONFIG_SENSORS_24C01A is not set<br># CONFIG_SENSORS_AD7416 is not set<br># CONFIG_DS1682 is not set<br>
# CONFIG_SENSORS_EEPROM is not set<br># CONFIG_SENSORS_MAX6900 is not set<br># CONFIG_SENSORS_PCF8574 is not set<br># CONFIG_PCF8575 is not set<br># CONFIG_SENSORS_PCF8591 is not set<br># CONFIG_TPS65010 is not set<br># CONFIG_SENSORS_MAX6875 is not set<br>
# CONFIG_SENSORS_TSL2550 is not set<br># CONFIG_I2C_DEBUG_CORE is not set<br># CONFIG_I2C_DEBUG_ALGO is not set<br># CONFIG_I2C_DEBUG_BUS is not set<br># CONFIG_I2C_DEBUG_CHIP is not set<br><br>#<br># SPI support<br>#<br>
# CONFIG_SPI is not set<br># CONFIG_SPI_MASTER is not set<br># CONFIG_W1 is not set<br># CONFIG_POWER_SUPPLY is not set<br>CONFIG_HWMON=y<br># CONFIG_HWMON_VID is not set<br># CONFIG_SENSORS_AD7414 is not set<br># CONFIG_SENSORS_AD7418 is not set<br>
# CONFIG_SENSORS_ADM1021 is not set<br># CONFIG_SENSORS_ADM1025 is not set<br># CONFIG_SENSORS_ADM1026 is not set<br># CONFIG_SENSORS_ADM1029 is not set<br># CONFIG_SENSORS_ADM1031 is not set<br># CONFIG_SENSORS_ADM9240 is not set<br>
# CONFIG_SENSORS_ADT7470 is not set<br># CONFIG_SENSORS_ADT7473 is not set<br># CONFIG_SENSORS_ATXP1 is not set<br># CONFIG_SENSORS_DS1621 is not set<br># CONFIG_SENSORS_I5K_AMB is not set<br># CONFIG_SENSORS_F71805F is not set<br>
# CONFIG_SENSORS_FM75 is not set<br># CONFIG_SENSORS_F71882FG is not set<br># CONFIG_SENSORS_F75375S is not set<br># CONFIG_SENSORS_GL518SM is not set<br># CONFIG_SENSORS_GL520SM is not set<br># CONFIG_SENSORS_IT87 is not set<br>
# CONFIG_SENSORS_LM63 is not set<br># CONFIG_SENSORS_LM75 is not set<br># CONFIG_SENSORS_LM77 is not set<br># CONFIG_SENSORS_LM78 is not set<br># CONFIG_SENSORS_LM80 is not set<br># CONFIG_SENSORS_LM83 is not set<br># CONFIG_SENSORS_LM85 is not set<br>
# CONFIG_SENSORS_LM87 is not set<br># CONFIG_SENSORS_LM90 is not set<br># CONFIG_SENSORS_LM92 is not set<br># CONFIG_SENSORS_LM93 is not set<br># CONFIG_SENSORS_MAX1619 is not set<br># CONFIG_SENSORS_MAX6650 is not set<br>
# CONFIG_SENSORS_PC87360 is not set<br># CONFIG_SENSORS_PC87427 is not set<br># CONFIG_SENSORS_SIS5595 is not set<br># CONFIG_SENSORS_DME1737 is not set<br># CONFIG_SENSORS_SMSC47M1 is not set<br># CONFIG_SENSORS_SMSC47M192 is not set<br>
# CONFIG_SENSORS_SMSC47B397 is not set<br># CONFIG_SENSORS_ADS7828 is not set<br># CONFIG_SENSORS_THMC50 is not set<br># CONFIG_SENSORS_VIA686A is not set<br># CONFIG_SENSORS_VT1115 is not set<br># CONFIG_SENSORS_VT1211 is not set<br>
# CONFIG_SENSORS_VT8231 is not set<br># CONFIG_SENSORS_W83781D is not set<br># CONFIG_SENSORS_W83791D is not set<br># CONFIG_SENSORS_W83792D is not set<br># CONFIG_SENSORS_W83793 is not set<br># CONFIG_SENSORS_W83L785TS is not set<br>
# CONFIG_SENSORS_W83L786NG is not set<br># CONFIG_SENSORS_W83627HF is not set<br># CONFIG_SENSORS_W83627EHF is not set<br># CONFIG_HWMON_DEBUG_CHIP is not set<br># CONFIG_THERMAL is not set<br>CONFIG_WATCHDOG=y<br># CONFIG_WATCHDOG_NOWAYOUT is not set<br>
<br>#<br># Watchdog Device Drivers<br>#<br># CONFIG_WD is not set<br># CONFIG_SOFT_WATCHDOG is not set<br># CONFIG_BOOKE_WDT is not set<br><br>#<br># PCI-based Watchdog Cards<br>#<br># CONFIG_PCIPCWATCHDOG is not set<br># CONFIG_WDTPCI is not set<br>
<br>#<br># Sonics Silicon Backplane<br>#<br>CONFIG_SSB_POSSIBLE=y<br># CONFIG_SSB is not set<br><br>#<br># Multifunction device drivers<br>#<br># CONFIG_MFD_SM501 is not set<br><br>#<br># Multimedia devices<br>#<br># CONFIG_VIDEO_DEV is not set<br>
# CONFIG_DVB_CORE is not set<br>CONFIG_DAB=y<br><br>#<br># Graphics support<br>#<br># CONFIG_AGP is not set<br># CONFIG_DRM is not set<br># CONFIG_VGASTATE is not set<br>CONFIG_VIDEO_OUTPUT_CONTROL=m<br># CONFIG_FB is not set<br>
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set<br><br>#<br># Display device support<br>#<br># CONFIG_DISPLAY_SUPPORT is not set<br><br>#<br># Sound<br>#<br># CONFIG_SOUND is not set<br>CONFIG_HID_SUPPORT=y<br>CONFIG_HID=y<br># CONFIG_HID_DEBUG is not set<br>
# CONFIG_HIDRAW is not set<br>CONFIG_USB_SUPPORT=y<br>CONFIG_USB_ARCH_HAS_HCD=y<br>CONFIG_USB_ARCH_HAS_OHCI=y<br>CONFIG_USB_ARCH_HAS_EHCI=y<br># CONFIG_USB is not set<br><br>#<br># NOTE: USB_STORAGE enables SCSI, and &#39;SCSI disk support&#39;<br>
#<br># CONFIG_USB_GADGET is not set<br># CONFIG_MMC is not set<br># CONFIG_MEMSTICK is not set<br># CONFIG_NEW_LEDS is not set<br># CONFIG_INFINIBAND is not set<br># CONFIG_EDAC is not set<br>CONFIG_RTC_LIB=y<br>CONFIG_RTC_CLASS=y<br>
CONFIG_RTC_HCTOSYS=y<br>CONFIG_RTC_HCTOSYS_DEVICE=&quot;rtc0&quot;<br># CONFIG_RTC_DEBUG is not set<br><br>#<br># RTC interfaces<br>#<br>CONFIG_RTC_INTF_SYSFS=y<br>CONFIG_RTC_INTF_PROC=y<br>CONFIG_RTC_INTF_DEV=y<br># CONFIG_RTC_INTF_DEV_UIE_EMUL is not set<br>
# CONFIG_RTC_DRV_TEST is not set<br><br>#<br># I2C RTC drivers<br>#<br># CONFIG_RTC_DRV_DS1307 is not set<br>CONFIG_RTC_DRV_DS1374=y<br># CONFIG_RTC_DRV_DS1672 is not set<br># CONFIG_RTC_DRV_MAX6900 is not set<br># CONFIG_RTC_DRV_RS5C372 is not set<br>
# CONFIG_RTC_DRV_ISL1208 is not set<br># CONFIG_RTC_DRV_X1205 is not set<br># CONFIG_RTC_DRV_PCF8563 is not set<br># CONFIG_RTC_DRV_PCF8583 is not set<br># CONFIG_RTC_DRV_M41T80 is not set<br># CONFIG_RTC_DRV_S35390A is not set<br>
<br>#<br># SPI RTC drivers<br>#<br><br>#<br># Platform RTC drivers<br>#<br># CONFIG_RTC_DRV_CMOS is not set<br># CONFIG_RTC_DRV_DS1511 is not set<br># CONFIG_RTC_DRV_DS1553 is not set<br># CONFIG_RTC_DRV_DS1742 is not set<br>
# CONFIG_RTC_DRV_STK17TA8 is not set<br># CONFIG_RTC_DRV_M48T86 is not set<br># CONFIG_RTC_DRV_M48T59 is not set<br># CONFIG_RTC_DRV_V3020 is not set<br><br>#<br># on-CPU RTC drivers<br>#<br># CONFIG_DMADEVICES is not set<br>
<br>#<br># Userspace I/O<br>#<br># CONFIG_UIO is not set<br><br>#<br># File systems<br>#<br>CONFIG_EXT2_FS=y<br># CONFIG_EXT2_FS_XATTR is not set<br># CONFIG_EXT2_FS_XIP is not set<br>CONFIG_EXT3_FS=y<br>CONFIG_EXT3_FS_XATTR=y<br>
# CONFIG_EXT3_FS_POSIX_ACL is not set<br># CONFIG_EXT3_FS_SECURITY is not set<br># CONFIG_EXT4DEV_FS is not set<br>CONFIG_JBD=y<br>CONFIG_FS_MBCACHE=y<br># CONFIG_REISERFS_FS is not set<br># CONFIG_JFS_FS is not set<br># CONFIG_FS_POSIX_ACL is not set<br>
# CONFIG_XFS_FS is not set<br># CONFIG_GFS2_FS is not set<br># CONFIG_OCFS2_FS is not set<br>CONFIG_DNOTIFY=y<br>CONFIG_INOTIFY=y<br>CONFIG_INOTIFY_USER=y<br># CONFIG_QUOTA is not set<br># CONFIG_AUTOFS_FS is not set<br># CONFIG_AUTOFS4_FS is not set<br>
# CONFIG_FUSE_FS is not set<br><br>#<br># CD-ROM/DVD Filesystems<br>#<br># CONFIG_ISO9660_FS is not set<br># CONFIG_UDF_FS is not set<br><br>#<br># DOS/FAT/NT Filesystems<br>#<br># CONFIG_MSDOS_FS is not set<br># CONFIG_VFAT_FS is not set<br>
# CONFIG_NTFS_FS is not set<br><br>#<br># Pseudo filesystems<br>#<br>CONFIG_PROC_FS=y<br>CONFIG_PROC_KCORE=y<br>CONFIG_PROC_SYSCTL=y<br>CONFIG_SYSFS=y<br>CONFIG_TMPFS=y<br># CONFIG_TMPFS_POSIX_ACL is not set<br># CONFIG_HUGETLB_PAGE is not set<br>
# CONFIG_CONFIGFS_FS is not set<br><br>#<br># Miscellaneous filesystems<br>#<br># CONFIG_ADFS_FS is not set<br># CONFIG_AFFS_FS is not set<br># CONFIG_HFS_FS is not set<br># CONFIG_HFSPLUS_FS is not set<br># CONFIG_BEFS_FS is not set<br>
# CONFIG_BFS_FS is not set<br># CONFIG_EFS_FS is not set<br># CONFIG_CRAMFS is not set<br># CONFIG_VXFS_FS is not set<br># CONFIG_MINIX_FS is not set<br># CONFIG_HPFS_FS is not set<br># CONFIG_QNX4FS_FS is not set<br># CONFIG_ROMFS_FS is not set<br>
# CONFIG_SYSV_FS is not set<br># CONFIG_UFS_FS is not set<br>CONFIG_NETWORK_FILESYSTEMS=y<br>CONFIG_NFS_FS=y<br>CONFIG_NFS_V3=y<br># CONFIG_NFS_V3_ACL is not set<br>CONFIG_NFS_V4=y<br># CONFIG_NFS_DIRECTIO is not set<br># CONFIG_NFSD is not set<br>
CONFIG_ROOT_NFS=y<br>CONFIG_LOCKD=y<br>CONFIG_LOCKD_V4=y<br>CONFIG_NFS_COMMON=y<br>CONFIG_SUNRPC=y<br>CONFIG_SUNRPC_GSS=y<br># CONFIG_SUNRPC_BIND34 is not set<br>CONFIG_RPCSEC_GSS_KRB5=y<br># CONFIG_RPCSEC_GSS_SPKM3 is not set<br>
# CONFIG_SMB_FS is not set<br># CONFIG_CIFS is not set<br># CONFIG_NCP_FS is not set<br># CONFIG_CODA_FS is not set<br># CONFIG_AFS_FS is not set<br><br>#<br># Partition Types<br>#<br>CONFIG_PARTITION_ADVANCED=y<br># CONFIG_ACORN_PARTITION is not set<br>
# CONFIG_OSF_PARTITION is not set<br># CONFIG_AMIGA_PARTITION is not set<br># CONFIG_ATARI_PARTITION is not set<br># CONFIG_MAC_PARTITION is not set<br># CONFIG_MSDOS_PARTITION is not set<br># CONFIG_LDM_PARTITION is not set<br>
# CONFIG_SGI_PARTITION is not set<br># CONFIG_ULTRIX_PARTITION is not set<br># CONFIG_SUN_PARTITION is not set<br># CONFIG_KARMA_PARTITION is not set<br># CONFIG_EFI_PARTITION is not set<br># CONFIG_SYSV68_PARTITION is not set<br>
# CONFIG_NLS is not set<br># CONFIG_DLM is not set<br><br>#<br># Library routines<br>#<br>CONFIG_BITREVERSE=y<br># CONFIG_CRC_CCITT is not set<br># CONFIG_CRC16 is not set<br># CONFIG_CRC_ITU_T is not set<br>CONFIG_CRC32=y<br>
# CONFIG_CRC7 is not set<br># CONFIG_LIBCRC32C is not set<br>CONFIG_PLIST=y<br>CONFIG_HAS_IOMEM=y<br>CONFIG_HAS_IOPORT=y<br>CONFIG_HAS_DMA=y<br><br>#<br># Kernel hacking<br>#<br># CONFIG_PRINTK_TIME is not set<br>CONFIG_ENABLE_WARN_DEPRECATED=y<br>
CONFIG_ENABLE_MUST_CHECK=y<br># CONFIG_MAGIC_SYSRQ is not set<br># CONFIG_UNUSED_SYMBOLS is not set<br># CONFIG_DEBUG_FS is not set<br># CONFIG_HEADERS_CHECK is not set<br>CONFIG_DEBUG_KERNEL=y<br># CONFIG_DEBUG_SHIRQ is not set<br>
CONFIG_DETECT_SOFTLOCKUP=y<br>CONFIG_SCHED_DEBUG=y<br># CONFIG_SCHEDSTATS is not set<br># CONFIG_TIMER_STATS is not set<br># CONFIG_SLUB_DEBUG_ON is not set<br># CONFIG_SLUB_STATS is not set<br># CONFIG_DEBUG_RT_MUTEXES is not set<br>
# CONFIG_RT_MUTEX_TESTER is not set<br># CONFIG_DEBUG_SPINLOCK is not set<br># CONFIG_DEBUG_MUTEXES is not set<br># CONFIG_DEBUG_SPINLOCK_SLEEP is not set<br># CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set<br># CONFIG_DEBUG_KOBJECT is not set<br>
# CONFIG_DEBUG_BUGVERBOSE is not set<br># CONFIG_DEBUG_INFO is not set<br># CONFIG_DEBUG_VM is not set<br># CONFIG_DEBUG_LIST is not set<br># CONFIG_DEBUG_SG is not set<br># CONFIG_BOOT_PRINTK_DELAY is not set<br># CONFIG_RCU_TORTURE_TEST is not set<br>
# CONFIG_BACKTRACE_SELF_TEST is not set<br># CONFIG_FAULT_INJECTION is not set<br># CONFIG_SAMPLES is not set<br># CONFIG_DEBUG_STACKOVERFLOW is not set<br># CONFIG_DEBUG_STACK_USAGE is not set<br># CONFIG_DEBUG_PAGEALLOC is not set<br>
CONFIG_DEBUGGER=y<br># CONFIG_XMON is not set<br># CONFIG_BDI_SWITCH is not set<br>CONFIG_PPC_EARLY_DEBUG=y<br># CONFIG_PPC_EARLY_DEBUG_LPAR is not set<br># CONFIG_PPC_EARLY_DEBUG_G5 is not set<br># CONFIG_PPC_EARLY_DEBUG_RTAS_PANEL is not set<br>
# CONFIG_PPC_EARLY_DEBUG_RTAS_CONSOLE is not set<br># CONFIG_PPC_EARLY_DEBUG_MAPLE is not set<br># CONFIG_PPC_EARLY_DEBUG_ISERIES is not set<br># CONFIG_PPC_EARLY_DEBUG_PAS_REALMODE is not set<br># CONFIG_PPC_EARLY_DEBUG_BEAT is not set<br>
# CONFIG_PPC_EARLY_DEBUG_44x is not set<br># CONFIG_PPC_EARLY_DEBUG_40x is not set<br># CONFIG_PPC_EARLY_DEBUG_CPM is not set<br><br>#<br># Security options<br>#<br># CONFIG_KEYS is not set<br># CONFIG_SECURITY is not set<br>
# CONFIG_SECURITY_FILE_CAPABILITIES is not set<br>CONFIG_CRYPTO=y<br>CONFIG_CRYPTO_ALGAPI=y<br>CONFIG_CRYPTO_BLKCIPHER=y<br># CONFIG_CRYPTO_SEQIV is not set<br>CONFIG_CRYPTO_MANAGER=y<br># CONFIG_CRYPTO_HMAC is not set<br>
# CONFIG_CRYPTO_XCBC is not set<br># CONFIG_CRYPTO_NULL is not set<br># CONFIG_CRYPTO_MD4 is not set<br>CONFIG_CRYPTO_MD5=y<br># CONFIG_CRYPTO_SHA1 is not set<br># CONFIG_CRYPTO_SHA256 is not set<br># CONFIG_CRYPTO_SHA512 is not set<br>
# CONFIG_CRYPTO_WP512 is not set<br># CONFIG_CRYPTO_TGR192 is not set<br># CONFIG_CRYPTO_GF128MUL is not set<br>CONFIG_CRYPTO_ECB=m<br>CONFIG_CRYPTO_CBC=y<br>CONFIG_CRYPTO_PCBC=m<br># CONFIG_CRYPTO_LRW is not set<br># CONFIG_CRYPTO_XTS is not set<br>
# CONFIG_CRYPTO_CTR is not set<br># CONFIG_CRYPTO_GCM is not set<br># CONFIG_CRYPTO_CCM is not set<br># CONFIG_CRYPTO_CRYPTD is not set<br>CONFIG_CRYPTO_DES=y<br># CONFIG_CRYPTO_FCRYPT is not set<br># CONFIG_CRYPTO_BLOWFISH is not set<br>
# CONFIG_CRYPTO_TWOFISH is not set<br># CONFIG_CRYPTO_SERPENT is not set<br># CONFIG_CRYPTO_AES is not set<br># CONFIG_CRYPTO_CAST5 is not set<br># CONFIG_CRYPTO_CAST6 is not set<br># CONFIG_CRYPTO_TEA is not set<br># CONFIG_CRYPTO_ARC4 is not set<br>
# CONFIG_CRYPTO_KHAZAD is not set<br># CONFIG_CRYPTO_ANUBIS is not set<br># CONFIG_CRYPTO_SEED is not set<br># CONFIG_CRYPTO_SALSA20 is not set<br># CONFIG_CRYPTO_DEFLATE is not set<br># CONFIG_CRYPTO_MICHAEL_MIC is not set<br>
# CONFIG_CRYPTO_CRC32C is not set<br># CONFIG_CRYPTO_CAMELLIA is not set<br># CONFIG_CRYPTO_TEST is not set<br># CONFIG_CRYPTO_AUTHENC is not set<br># CONFIG_CRYPTO_LZO is not set<br>CONFIG_CRYPTO_HW=y<br># CONFIG_CRYPTO_DEV_HIFN_795X is not set<br>
# CONFIG_PPC_CLOCK is not set<br>CONFIG_PPC_LIB_RHEAP=y<br><br>Does anyone know this problem?<br><br>Thanks in advance<br><br>Agostino Sette<br>_______________________________________________<br>Linuxppc-embedded mailing list<br>
<a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote></div>
<br>

------=_Part_7174_33277135.1220033006809--
