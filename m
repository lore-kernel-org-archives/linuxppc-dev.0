Return-Path: <mzaturenskiy.st@gmail.com>
Received: from mail-pz0-f202.google.com (mail-pz0-f202.google.com
	[209.85.222.202])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 8724DB7135
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 04:04:57 +1000 (EST)
Received: by pzk40 with SMTP id 40so918957pzk.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 01 Jul 2009 11:04:55 -0700 (PDT)
MIME-Version: 1.0
From: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Date: Wed, 1 Jul 2009 13:04:35 -0500
Message-ID: <97dd5fd20907011104t773c3fc9tca7f0fe56ea22477@mail.gmail.com>
Subject: RAMDISK on EP88xc
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,
I'm trying to get a ramdisk working on my EP88xc with uboot and linux
kernel v2.6.30. The ramdisk image is from
ELDK_4.2/ppc_8xx/images/uRamdisk.

At first I thought my issue was similar to
http://ozlabs.org/pipermail/linuxppc-embedded/2008-August/031204.html
but I'm not so sure anymore. I think my problem is with incorrectly
configuring my kernel.

Here is my console output:
***************************************************************************=
*************************
U-Boot 2009.03-svn8609 (Jun 30 2009 - 11:32:48)

CPU: =A0 MPC885ZPnn at 100 MHz [40.0...133.0 MHz]
=A0 =A0 =A0 8 kB I-Cache 8 kB D-Cache FEC present
Board: EP88xC 1.1 =A0CPLD revision 2
DRAM: =A064 MB
FLASH: 32 MB
In: =A0 =A0serial
Out: =A0 serial
Err: =A0 serial
Net: =A0 FEC ETHERNET, FEC2 ETHERNET
Hit any key to stop autoboot: =A00
=3D> setenv bootargs console=3DttyCPM0,9600n8 loglevel=3D7
=3D> tftp 400000 ep88x_uimage
Using FEC ETHERNET device
TFTP from server 10.0.54.129; our IP address is 10.0.54.150
Filename 'ep88x_uimage'.
Load address: 0x400000
Loading: #################################################################
=A0 =A0 =A0 =A0 ###
done
Bytes transferred =3D 986921 (f0f29 hex)
=3D> tftp 650000 ep88x_ramdisk_eldk
Using FEC ETHERNET device
TFTP from server 10.0.54.129; our IP address is 10.0.54.150
Filename 'ep88x_ramdisk_eldk'.
Load address: 0x650000
Loading: #################################################################
=A0 =A0 =A0 =A0 ###########################################################=
##
done
Bytes transferred =3D 1846099 (1c2b53 hex)
=3D> tftp 850000 ep88x_dtb
Using FEC ETHERNET device
TFTP from server 10.0.54.129; our IP address is 10.0.54.150
Filename 'ep88x_dtb'.
Load address: 0x850000
Loading: #
done
Bytes transferred =3D 7643 (1ddb hex)
=3D> bootm 400000 650000 850000
## Booting kernel from Legacy Image at 00400000 ...
=A0 Image Name: =A0 Linux-2.6.30-rc2-01402-gd4e2f68-
=A0 Image Type: =A0 PowerPC Linux Kernel Image (gzip compressed)
=A0 Data Size: =A0 =A0986857 Bytes =3D 963.7 kB
=A0 Load Address: 00000000
=A0 Entry Point: =A000000000
=A0 Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at 00650000 ...
=A0 Image Name: =A0 Simple Embedded Linux Framework
=A0 Image Type: =A0 PowerPC Linux RAMDisk Image (gzip compressed)
=A0 Data Size: =A0 =A01846035 Bytes =3D =A01.8 MB
=A0 Load Address: 00000000
=A0 Entry Point: =A000000000
=A0 Verifying Checksum ... OK
## Flattened Device Tree blob at 00850000
=A0 Booting using the fdt blob at 0x850000
=A0 Uncompressing Kernel Image ... OK
=A0 Loading Ramdisk to 03daa000, end 03f6cb13 ... OK
=A0 Loading Device Tree to 007fb000, end 007ffdda ... OK
Using Embedded Planet EP88xC machine description
Linux version 2.6.30-rc2-01402-gd4e2f68-dirty (devone@localhost.localdomain=
) (gc
c version 4.2.2) #3 Wed Jul 1 10:09:29 CDT 2009
Found initrd at 0xc3daa000:0xc3f6cb13
Zone PFN ranges:
=A0DMA =A0 =A0 =A00x00000000 -> 0x00004000
=A0Normal =A0 0x00004000 -> 0x00004000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
=A0 =A00: 0x00000000 -> 0x00004000
MMU: Allocated 72 bytes of context maps for 16 contexts
Built 1 zonelists in Zone order, mobility grouping on. =A0Total pages: 1625=
6
Kernel command line: console=3DttyCPM0,9600n8 loglevel=3D7
NR_IRQS:512
PID hash table entries: 256 (order: 8, 1024 bytes)
Decrementer Frequency =3D 0x5f5e10
clocksource: timebase mult[28000000] shift[22] registered
console [ttyCPM0] enabled
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 60868k/65536k available (1952k kernel code, 4604k reserved, 100k da=
ta, 6
8k bss, 100k init)
SLUB: Genslabs=3D12, HWalign=3D16, Order=3D0-3, MinObjects=3D0, CPUs=3D1, N=
odes=3D1
Calibrating delay loop... 12.39 BogoMIPS (lpj=3D61952)
Mount-cache hash table entries: 512
net_namespace: 296 bytes
NET: Registered protocol family 16
bio: create slab <bio-0> at 0
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
NET: Registered protocol family 1
Unpacking initramfs... failed!
no cpio magic
Freeing initrd memory: 1802k freed
msgmni has been set to 122
io scheduler noop registered
io scheduler deadline registered (default)
Generic RTC Driver v1.07
f0000a80.serial: ttyCPM0 at MMIO 0xc5000a80 (irq =3D 19) is a CPM UART
f0000a20.serial: ttyCPM1 at MMIO 0xc5008a20 (irq =3D 29) is a CPM UART
eth0: fs_enet: 00:00:00:00:00:00
eth1: fs_enet: 00:00:00:00:00:00
FEC MII Bus: probed
fe000000.flash: Found 2 x16 devices at 0x0 in 32-bit bank
Amd/Fujitsu Extended Query Table at 0x0040
fe000000.flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
List of all partitions:
1f00 =A0 =A0 =A0 =A0 =A0 32768 mtdblock0 driver: of-flash
No filesystem could mount root, tried:
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1=
,0)
Call Trace:
[c381fef0] [c0006554] show_stack+0x50/0x154 (unreliable)
[c381ff30] [c001b894] panic+0x8c/0x164
[c381ff80] [c01cfc00] mount_block_root+0x204/0x228
[c381ffc0] [c01cfe88] prepare_namespace+0x150/0x190
[c381ffe0] [c01cf1b0] kernel_init+0xd0/0xec
[c381fff0] [c000cfdc] kernel_thread+0x4c/0x68
Rebooting in 180 seconds..
***************************************************************************=
*************************

So the kernel does say "Found initrd at 0xc3daa000:0xc3f6cb13", but then

"Unpacking initramfs... failed!
no cpio magic
Freeing initrd memory: 1802k freed"

What's going on here? Please help.

My kernel's .config below:
***************************************************************************=
***************
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.30-rc2
# Wed Jul  1 10:04:09 2009
#
# CONFIG_PPC64 is not set

#
# Processor support
#
# CONFIG_6xx is not set
# CONFIG_PPC_85xx is not set
CONFIG_PPC_8xx=3Dy
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_E200 is not set
CONFIG_8xx=3Dy
CONFIG_PPC_MMU_NOHASH=3Dy
# CONFIG_PPC_MM_SLICES is not set
CONFIG_NOT_COHERENT_CACHE=3Dy
CONFIG_PPC32=3Dy
CONFIG_WORD_SIZE=3D32
# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
CONFIG_MMU=3Dy
CONFIG_GENERIC_CMOS_UPDATE=3Dy
CONFIG_GENERIC_TIME=3Dy
CONFIG_GENERIC_TIME_VSYSCALL=3Dy
CONFIG_GENERIC_CLOCKEVENTS=3Dy
CONFIG_GENERIC_HARDIRQS=3Dy
# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
CONFIG_IRQ_PER_CPU=3Dy
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_ARCH_HAS_ILOG2_U32=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_GENERIC_FIND_NEXT_BIT=3Dy
# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
CONFIG_PPC=3Dy
CONFIG_EARLY_PRINTK=3Dy
CONFIG_GENERIC_NVRAM=3Dy
CONFIG_SCHED_OMIT_FRAME_POINTER=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
CONFIG_PPC_OF=3Dy
CONFIG_OF=3Dy
# CONFIG_PPC_UDBG_16550 is not set
# CONFIG_GENERIC_TBSYNC is not set
CONFIG_AUDIT_ARCH=3Dy
CONFIG_GENERIC_BUG=3Dy
# CONFIG_DEFAULT_UIMAGE is not set
# CONFIG_PPC_DCR_NATIVE is not set
# CONFIG_PPC_DCR_MMIO is not set
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"

#
# General setup
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32
CONFIG_LOCALVERSION=3D""
CONFIG_LOCALVERSION_AUTO=3Dy
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=3Dy
CONFIG_SYSVIPC_SYSCTL=3Dy
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_AUDIT is not set

#
# RCU Subsystem
#
CONFIG_CLASSIC_RCU=3Dy
# CONFIG_TREE_RCU is not set
# CONFIG_PREEMPT_RCU is not set
# CONFIG_TREE_RCU_TRACE is not set
# CONFIG_PREEMPT_RCU_TRACE is not set
# CONFIG_IKCONFIG is not set
CONFIG_LOG_BUF_SHIFT=3D14
CONFIG_GROUP_SCHED=3Dy
# CONFIG_FAIR_GROUP_SCHED is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_USER_SCHED=3Dy
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUPS is not set
# CONFIG_SYSFS_DEPRECATED_V2 is not set
# CONFIG_RELAY is not set
# CONFIG_NAMESPACES is not set
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_RD_GZIP=3Dy
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_ANON_INODES=3Dy
CONFIG_EMBEDDED=3Dy
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=3Dy
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_HOTPLUG=3Dy
CONFIG_PRINTK=3Dy
# CONFIG_LOGBUFFER is not set
CONFIG_BUG=3Dy
# CONFIG_ELF_CORE is not set
# CONFIG_BASE_FULL is not set
# CONFIG_FUTEX is not set
CONFIG_EPOLL=3Dy
CONFIG_SIGNALFD=3Dy
CONFIG_TIMERFD=3Dy
CONFIG_EVENTFD=3Dy
CONFIG_SHMEM=3Dy
CONFIG_AIO=3Dy
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_SLUB_DEBUG=3Dy
CONFIG_COMPAT_BRK=3Dy
# CONFIG_SLAB is not set
CONFIG_SLUB=3Dy
# CONFIG_SLOB is not set
# CONFIG_PROFILING is not set
# CONFIG_MARKERS is not set
CONFIG_HAVE_OPROFILE=3Dy
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
CONFIG_HAVE_IOREMAP_PROT=3Dy
CONFIG_HAVE_KPROBES=3Dy
CONFIG_HAVE_KRETPROBES=3Dy
CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
CONFIG_HAVE_CLK=3Dy
# CONFIG_SLOW_WORK is not set
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=3Dy
CONFIG_BASE_SMALL=3D1
# CONFIG_MODULES is not set
CONFIG_BLOCK=3Dy
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_BSG is not set
# CONFIG_BLK_DEV_INTEGRITY is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
# CONFIG_IOSCHED_AS is not set
CONFIG_IOSCHED_DEADLINE=3Dy
# CONFIG_IOSCHED_CFQ is not set
# CONFIG_DEFAULT_AS is not set
CONFIG_DEFAULT_DEADLINE=3Dy
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"deadline"
# CONFIG_FREEZER is not set

#
# Platform support
#
# CONFIG_PPC_CELL is not set
# CONFIG_PPC_CELL_NATIVE is not set
CONFIG_CPM1=3Dy
# CONFIG_MGSUVD is not set
# CONFIG_MPC8XXFADS is not set
# CONFIG_MPC86XADS is not set
# CONFIG_MPC885ADS is not set
CONFIG_PPC_EP88XC=3Dy
# CONFIG_PPC_ADDER875 is not set
# CONFIG_PPC_MGSUVD is not set

#
# MPC8xx CPM Options
#

#
# Generic MPC8xx Options
#
CONFIG_8xx_COPYBACK=3Dy
# CONFIG_8xx_GPIO is not set
# CONFIG_8xx_CPU6 is not set
CONFIG_8xx_CPU15=3Dy
CONFIG_NO_UCODE_PATCH=3Dy
# CONFIG_USB_SOF_UCODE_PATCH is not set
# CONFIG_I2C_SPI_UCODE_PATCH is not set
# CONFIG_I2C_SPI_SMC1_UCODE_PATCH is not set
# CONFIG_PQ2ADS is not set
# CONFIG_IPIC is not set
# CONFIG_MPIC is not set
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
# CONFIG_QE_GPIO is not set
# CONFIG_FSL_ULI1575 is not set
CONFIG_CPM=3Dy
# CONFIG_SIMPLE_GPIO is not set

#
# Kernel options
#
# CONFIG_HIGHMEM is not set
CONFIG_TICK_ONESHOT=3Dy
CONFIG_NO_HZ=3Dy
CONFIG_HIGH_RES_TIMERS=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy
CONFIG_HZ_100=3Dy
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=3D100
CONFIG_SCHED_HRTICK=3Dy
CONFIG_PREEMPT_NONE=3Dy
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_BINFMT_ELF=3Dy
# CONFIG_HAVE_AOUT is not set
# CONFIG_BINFMT_MISC is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_8XX_MINIMAL_FPEMU=3Dy
# CONFIG_IOMMU_HELPER is not set
CONFIG_PPC_NEED_DMA_SYNC_OPS=3Dy
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
CONFIG_PAGEFLAGS_EXTENDED=3Dy
CONFIG_SPLIT_PTLOCK_CPUS=3D4
CONFIG_MIGRATION=3Dy
# CONFIG_PHYS_ADDR_T_64BIT is not set
CONFIG_ZONE_DMA_FLAG=3D1
CONFIG_BOUNCE=3Dy
CONFIG_VIRT_TO_BUS=3Dy
CONFIG_UNEVICTABLE_LRU=3Dy
CONFIG_HAVE_MLOCK=3Dy
CONFIG_HAVE_MLOCKED_PAGE_BIT=3Dy
CONFIG_PPC_4K_PAGES=3Dy
# CONFIG_PPC_16K_PAGES is not set
# CONFIG_PPC_64K_PAGES is not set
# CONFIG_PPC_256K_PAGES is not set
CONFIG_FORCE_MAX_ZONEORDER=3D11
CONFIG_PROC_DEVICETREE=3Dy
# CONFIG_CMDLINE_BOOL is not set
CONFIG_EXTRA_TARGETS=3D""
# CONFIG_PM is not set
# CONFIG_SECCOMP is not set
CONFIG_ISA_DMA_API=3Dy

#
# Bus options
#
CONFIG_ZONE_DMA=3Dy
CONFIG_FSL_SOC=3Dy
# CONFIG_PCI is not set
# CONFIG_PCI_DOMAINS is not set
# CONFIG_PCI_SYSCALL is not set
# CONFIG_PCI_QSPAN is not set
# CONFIG_ARCH_SUPPORTS_MSI is not set
# CONFIG_PCCARD is not set
# CONFIG_HAS_RAPIDIO is not set

#
# Advanced setup
#
# CONFIG_ADVANCED_OPTIONS is not set

#
# Default settings for advanced configuration options are used
#
CONFIG_LOWMEM_SIZE=3D0x30000000
CONFIG_PAGE_OFFSET=3D0xc0000000
CONFIG_KERNEL_START=3D0xc0000000
CONFIG_PHYSICAL_START=3D0x00000000
CONFIG_TASK_SIZE=3D0x80000000
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=3Dy
# CONFIG_NET_KEY is not set
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=3Dy
CONFIG_IP_PNP=3Dy
# CONFIG_IP_PNP_DHCP is not set
# CONFIG_IP_PNP_BOOTP is not set
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
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
# CONFIG_INET_LRO is not set
CONFIG_INET_DIAG=3Dy
CONFIG_INET_TCP_DIAG=3Dy
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=3Dy
CONFIG_DEFAULT_TCP_CONG=3D"cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_PHONET is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_WIRELESS is not set
# CONFIG_WIMAX is not set
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
CONFIG_MTD=3Dy
# CONFIG_MTD_DEBUG is not set
# CONFIG_MTD_CONCAT is not set
# CONFIG_MTD_PARTITIONS is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=3Dy
CONFIG_MTD_BLKDEVS=3Dy
CONFIG_MTD_BLOCK=3Dy
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_MTD_OOPS is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=3Dy
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=3Dy
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=3Dy
CONFIG_MTD_CFI_I2=3Dy
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=3Dy
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=3Dy
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PHYSMAP is not set
CONFIG_MTD_PHYSMAP_OF=3Dy
# CONFIG_MTD_CFI_FLAGADM is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
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
# CONFIG_MTD_NAND is not set
# CONFIG_MTD_ONENAND is not set

#
# LPDDR flash memory drivers
#
# CONFIG_MTD_LPDDR is not set

#
# UBI - Unsorted block images
#
# CONFIG_MTD_UBI is not set
CONFIG_OF_DEVICE=3Dy
# CONFIG_PARPORT is not set
# CONFIG_BLK_DEV is not set
# CONFIG_MISC_DEVICES is not set
CONFIG_HAVE_IDE=3Dy
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
# CONFIG_SCSI is not set
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set
# CONFIG_ATA is not set
# CONFIG_MD is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=3Dy
CONFIG_COMPAT_NET_DEV_OPS=3Dy
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_VETH is not set
CONFIG_PHYLIB=3Dy

#
# MII PHY device drivers
#
# CONFIG_MARVELL_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_LXT_PHY=3Dy
# CONFIG_CICADA_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_FIXED_PHY is not set
# CONFIG_MDIO_BITBANG is not set
CONFIG_NET_ETHERNET=3Dy
CONFIG_MII=3Dy
# CONFIG_ETHOC is not set
# CONFIG_DNET is not set
# CONFIG_IBM_NEW_EMAC_ZMII is not set
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
# CONFIG_B44 is not set
CONFIG_FS_ENET=3Dy
# CONFIG_FS_ENET_HAS_SCC is not set
CONFIG_FS_ENET_HAS_FEC=3Dy
CONFIG_FS_ENET_MDIO_FEC=3Dy
# CONFIG_NETDEV_1000 is not set
# CONFIG_NETDEV_10000 is not set

#
# Wireless LAN
#
# CONFIG_WLAN_PRE80211 is not set
# CONFIG_WLAN_80211 is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_ISDN is not set
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
CONFIG_DEVKMEM=3Dy
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
CONFIG_SERIAL_CPM=3Dy
CONFIG_SERIAL_CPM_CONSOLE=3Dy
# CONFIG_SERIAL_QE is not set
CONFIG_UNIX98_PTYS=3Dy
# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
# CONFIG_LEGACY_PTYS is not set
# CONFIG_HVC_UDBG is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=3Dy
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
# CONFIG_NVRAM is not set
CONFIG_GEN_RTC=3Dy
# CONFIG_GEN_RTC_X is not set
# CONFIG_R3964 is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_BOOTCOUNT is not set
# CONFIG_TCG_TPM is not set
# CONFIG_I2C is not set
# CONFIG_SPI is not set
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=3Dy
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_HWMON is not set
# CONFIG_THERMAL is not set
# CONFIG_THERMAL_HWMON is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=3Dy

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_REGULATOR is not set

#
# Multimedia devices
#

#
# Multimedia core support
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DVB_CORE is not set
# CONFIG_VIDEO_MEDIA is not set

#
# Multimedia drivers
#
CONFIG_DAB=3Dy

#
# Graphics support
#
# CONFIG_VGASTATE is not set
# CONFIG_VIDEO_OUTPUT_CONTROL is not set
# CONFIG_FB is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Display device support
#
# CONFIG_DISPLAY_SUPPORT is not set
# CONFIG_SOUND is not set
# CONFIG_USB_SUPPORT is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_EDAC is not set
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_STAGING is not set

#
# File systems
#
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_FILE_LOCKING is not set
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_DNOTIFY is not set
# CONFIG_INOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set

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
CONFIG_PROC_PAGE_MONITOR=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_CONFIGFS_FS is not set
CONFIG_MISC_FILESYSTEMS=3Dy
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_YAFFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_NILFS2_FS is not set
CONFIG_NETWORK_FILESYSTEMS=3Dy
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_V4 is not set
CONFIG_ROOT_NFS=3Dy
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
CONFIG_NFS_COMMON=3Dy
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
# CONFIG_NLS is not set
# CONFIG_DLM is not set
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_BITREVERSE=3Dy
CONFIG_GENERIC_FIND_LAST_BIT=3Dy
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
# CONFIG_CRC_T10DIF is not set
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=3Dy
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_DECOMPRESS_GZIP=3Dy
CONFIG_HAS_IOMEM=3Dy
CONFIG_HAS_IOPORT=3Dy
CONFIG_HAS_DMA=3Dy
CONFIG_HAVE_LMB=3Dy
CONFIG_NLATTR=3Dy

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_WARN_DEPRECATED=3Dy
CONFIG_ENABLE_MUST_CHECK=3Dy
CONFIG_FRAME_WARN=3D1024
CONFIG_MAGIC_SYSRQ=3Dy
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
CONFIG_DEBUG_KERNEL=3Dy
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_DETECT_SOFTLOCKUP=3Dy
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0
CONFIG_DETECT_HUNG_TASK=3Dy
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0
CONFIG_SCHED_DEBUG=3Dy
# CONFIG_SCHEDSTATS is not set
# CONFIG_TIMER_STATS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=3Dy
CONFIG_DEBUG_INFO=3Dy
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_WRITECOUNT is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_CPU_STALL_DETECTOR is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_HAVE_FUNCTION_TRACER=3Dy
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
CONFIG_TRACING_SUPPORT=3Dy

#
# Tracers
#
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_CONTEXT_SWITCH_TRACER is not set
# CONFIG_EVENT_TRACER is not set
# CONFIG_BOOT_TRACER is not set
# CONFIG_TRACE_BRANCH_PROFILING is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_KMEMTRACE is not set
# CONFIG_WORKQUEUE_TRACER is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=3Dy
# CONFIG_KGDB is not set
CONFIG_PRINT_STACK_DEPTH=3D64
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_CODE_PATCHING_SELFTEST is not set
# CONFIG_FTR_FIXUP_SELFTEST is not set
# CONFIG_MSI_BITMAP_SELFTEST is not set
# CONFIG_XMON is not set
# CONFIG_IRQSTACKS is not set
# CONFIG_BDI_SWITCH is not set
# CONFIG_PPC_EARLY_DEBUG is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
# CONFIG_SECURITY_FILE_CAPABILITIES is not set
# CONFIG_CRYPTO is not set
CONFIG_PPC_CLOCK=3Dy
CONFIG_PPC_LIB_RHEAP=3Dy
# CONFIG_VIRTUALIZATION is not set
***************************************************************************=
***************

Thanks,
Mikhail Zaturenskiy
