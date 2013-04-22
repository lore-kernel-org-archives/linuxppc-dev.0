Return-Path: <devurandom@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by ozlabs.org (Postfix) with ESMTP id 3E0272C0121
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 02:49:29 +1000 (EST)
Received: from mailout-de.gmx.net ([10.1.76.10]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MXCId-1Ty46z3oiT-00WBYb for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 18:44:20 +0200
From: Dennis Schridde <devurandom@gmx.net>
To: arnd@arndb.de, linuxppc-dev@lists.ozlabs.org, cbe-oss-dev@lists.ozlabs.org
Subject: PROBLEM: Only 2 of 4 cores used on IBM Cell blades and no threads
 shown in spufs
Date: Mon, 22 Apr 2013 18:44:13 +0200
Message-ID: <1470334.YUWOQ37ijW@ernie>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11397420.PkTpOoy5kv";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--nextPart11397420.PkTpOoy5kv
Content-Type: multipart/mixed; boundary="nextPart1616500.8WGK4DeFhD"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart1616500.8WGK4DeFhD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello!


[1.] One line summary of the problem:
Only 2 of 4 cores used on IBM Cell blades and no threads shown in spufs


[2.] Full description of the problem/report:
On my IBM Cell blades, only 2 out of the 4 CPU cores are being used, even when 
several threads are running. Also /spu is always empty, despite the SPUs being 
utilised. These are probably two unrelated problems, but I just wrote one 
email so I do not have to duplicate all the information. Please tell me if I 
should split the email up into two threads.

For testing, I started an instance of cellminer with --ppe 2 --spe 16 (2 
threads on the PPEs, 16 on the SPEs) and htop reports two CPU cores being used 
at 100% and two others at 0%, while 4 threads are running (each at 50% CPU 
utilisation -> they share a core).

During that test, spu-tools report:
---
# spu-top
spu-top: Context View
Cpu(s) load avg:   4.0%,  4.2%,  3.7%
Spu(s) load avg:  16.0%, 16.0%, 14.4%
Cpu(s): 50.0%us,  0.0%sys,  0.0%wait,  0.0%nice, 50.0%idle
Spu(s):100.0%us,  0.0%sys,  0.0%wait,  0.0%idle

   PID   TID USERNAME   S F  %SPU SPE     TIME BINARY
---
# spu-ps
   PID   TID USERNAME   S F SPE     TIME BINARY            
---

And the spufs is empty:
---
# ls -la /spu
total 0
# mount | grep spu
none on /spu type spufs (rw,relatime)
---


[3.] Keywords (i.e., modules, networking, kernel):
No idea what you want to know here...


[4.] Kernel information

[4.1.] Kernel version (from /proc/version):
I am using the Linux 3.8.8 kernel (vanilla-sources-3.8.8 on Gentoo/Linux):
# cat /proc/version 
Linux version 3.8.8 (root@blade00) (gcc version 4.7.2 (Gentoo 4.7.2-r1 p1.5, 
pie-0.5.5) ) #2 SMP Mon Apr 22 18:21:20 CEST 2013

[4.2.] Kernel .config file:
Please find the kernel config attached.


[5.] Most recent kernel version which did not have the bug:
N/A


[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
N/A, but please find the output of dmesg attached.


[7.] A small shell script or example program which triggers the
     problem (if possible)
N/A


[8.] Environment

[8.1.] Software (add the output of the ver_linux script here)
# ./source/scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux blade00 3.8.8 #2 SMP Mon Apr 22 18:21:20 CEST 2013 ppc64 Cell Broadband 
Engine, altivec supported CHRP IBM,0793-38G GNU/Linux
 
Gnu C                  4.7.2
Gnu make               3.82
binutils               2.22
util-linux             2.22.2
mount                  debug
module-init-tools      12
e2fsprogs              1.42
Linux C Library        2.17
Dynamic linker (ldd)   2.17
Procps                 3.3.4
Net-tools              1.60_p20120127084908
Kbd                    1.15.3wip
Sh-utils               8.20
Modules Loaded         rdma_ucm rdma_cm iw_cm ib_addr ib_cm ib_uverbs ib_umad 
mlx4_ib ib_sa ib_mad ib_core mlx4_core rtc_generic nfsv3 nfs_acl nfsv4 
auth_rpcgss nfs lockd fscache af_packet ehci_pci ohci_hcd ehci_hcd usbcore 
usb_common nls_base tg3 hwmon ptp pps_core libphy ipv6 unix sunrpc

[8.2.] Processor information (from /proc/cpuinfo):
# cat /proc/cpuinfo 
processor       : 0
cpu             : Cell Broadband Engine, altivec supported
clock           : 3200.000000MHz
revision        : 48.0 (pvr 0070 3000)

processor       : 1
cpu             : Cell Broadband Engine, altivec supported
clock           : 3200.000000MHz
revision        : 48.0 (pvr 0070 3000)

processor       : 2
cpu             : Cell Broadband Engine, altivec supported
clock           : 3200.000000MHz
revision        : 48.0 (pvr 0070 3000)

processor       : 3
cpu             : Cell Broadband Engine, altivec supported
clock           : 3200.000000MHz
revision        : 48.0 (pvr 0070 3000)

timebase        : 26664380
platform        : Cell
model           : IBM,0793-38G
machine         : CHRP IBM,0793-38G

[8.3.] Module information (from /proc/modules):
# cat /proc/modules 
rdma_ucm 18293 0 - Live 0xd000000001870000
rdma_cm 41579 1 rdma_ucm, Live 0xd000000001855000
iw_cm 10924 1 rdma_cm, Live 0xd00000000183b000
ib_addr 7425 1 rdma_cm, Live 0xd00000000182e000
ib_cm 40938 1 rdma_cm, Live 0xd000000001818000
ib_uverbs 45864 1 rdma_ucm, Live 0xd0000000017f4000
ib_umad 17663 0 - Live 0xd0000000017d6000
mlx4_ib 132595 0 - Live 0xd00000000172c000
ib_sa 29508 4 rdma_ucm,rdma_cm,ib_cm,mlx4_ib, Live 0xd0000000016ec000
ib_mad 47187 4 ib_cm,ib_umad,mlx4_ib,ib_sa, Live 0xd0000000016cb000
ib_core 72200 9 
rdma_ucm,rdma_cm,iw_cm,ib_cm,ib_uverbs,ib_umad,mlx4_ib,ib_sa,ib_mad, Live 
0xd000000001697000
mlx4_core 208672 1 mlx4_ib, Live 0xd00000000162d000
rtc_generic 2325 0 - Live 0xd0000000015d4000
nfsv3 36741 1 - Live 0xd0000000015c2000
nfs_acl 3380 1 nfsv3, Live 0xd0000000015ac000
nfsv4 163536 1 - Live 0xd000000001571000
auth_rpcgss 44818 1 nfsv4, Live 0xd00000000151c000
nfs 183674 5 nfsv3,nfsv4, Live 0xd0000000014c3000
lockd 84130 2 nfsv3,nfs, Live 0xd000000001451000
fscache 49687 2 nfsv4,nfs, Live 0xd000000001417000
af_packet 38205 0 - Live 0xd0000000013ee000
ehci_pci 5600 0 - Live 0xd0000000013b0000
ohci_hcd 54842 0 - Live 0xd000000001398000
ehci_hcd 66682 1 ehci_pci, Live 0xd00000000136d000
usbcore 205456 3 ehci_pci,ohci_hcd,ehci_hcd, Live 0xd0000000011ca000
usb_common 987 1 usbcore, Live 0xd00000000116d000
nls_base 8541 1 usbcore, Live 0xd000000001164000
tg3 190708 0 - Live 0xd0000000010ad000
hwmon 2174 1 tg3, Live 0xd000000001069000
ptp 12774 1 tg3, Live 0xd00000000105e000
pps_core 11405 1 ptp, Live 0xd00000000104f000
libphy 30711 1 tg3, Live 0xd000000001038000
ipv6 348760 48 ib_addr, Live 0xd000000000fb8000
unix 41060 44 - Live 0xd000000000f20000
sunrpc 238337 23 nfsv3,nfs_acl,nfsv4,auth_rpcgss,nfs,lockd, Live 
0xd000000000eb6000

[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
# cat /proc/ioports 
# cat /proc/iomem 
00000000-ffffffff : System RAM
100000000-1ffffffff : System RAM
14540000200-14540000207 : serial
14540000300-14540000307 : serial
14780000000-1478000ffff : tg3
14780010000-1478001ffff : tg3
34540000200-34540000207 : serial
34540000300-34540000307 : serial
34780000000-34780000fff : ohci_hcd
34780001000-34780001fff : ohci_hcd
34780002000-347800020ff : ehci_hcd
3d080000000-3d0800fffff : mlx4_core
3d0c0000000-3d0c1ffffff : mlx4_core

[8.5.] PCI information ('lspci -vvv' as root)
Please find this attached.

[8.6.] SCSI information (from /proc/scsi/scsi)
The system is diskless and the file you request is not available. I also 
tested on my desktop machine - seems to be gone in newer kernel versions?

[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
Please request anything that might be interesting.


[X.] Other notes, patches, fixes, workarounds:
I would like to know whether this a misconfiguration of my kernel, a hardware 
problem, or a bug in Linux.
You might find additional information (especially on the program being used 
for testing) in my support request for cellminer: 
https://github.com/verement/cellminer/issues/10


Best regards,
Dennis
--nextPart1616500.8WGK4DeFhD
Content-Disposition: attachment; filename="config-3.8.8"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="config-3.8.8"

#
# Automatically generated file; DO NOT EDIT.
# Linux/powerpc 3.8.8 Kernel Configuration
#
CONFIG_PPC64=y

#
# Processor support
#
CONFIG_PPC_BOOK3S_64=y
# CONFIG_PPC_BOOK3E_64 is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_CELL_CPU=y
# CONFIG_POWER4_CPU is not set
# CONFIG_POWER5_CPU is not set
# CONFIG_POWER6_CPU is not set
# CONFIG_POWER7_CPU is not set
CONFIG_PPC_BOOK3S=y
CONFIG_POWER3=y
CONFIG_POWER4=y
CONFIG_TUNE_CELL=y
CONFIG_PPC_FPU=y
CONFIG_ALTIVEC=y
CONFIG_VSX=y
# CONFIG_PPC_ICSWX is not set
CONFIG_PPC_STD_MMU=y
CONFIG_PPC_STD_MMU_64=y
# CONFIG_PPC_MM_SLICES is not set
CONFIG_PPC_HAVE_PMU_SUPPORT=y
CONFIG_SMP=y
CONFIG_NR_CPUS=32
CONFIG_64BIT=y
CONFIG_WORD_SIZE=64
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_MMU=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NR_IRQS=512
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_ARCH_HAS_ILOG2_U32=y
CONFIG_ARCH_HAS_ILOG2_U64=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_GPIO=y
CONFIG_ARCH_NO_VIRT_TO_BUS=y
CONFIG_PPC=y
CONFIG_EARLY_PRINTK=y
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_PPC_OF=y
CONFIG_PPC_UDBG_16550=y
# CONFIG_GENERIC_TBSYNC is not set
CONFIG_AUDIT_ARCH=y
CONFIG_GENERIC_BUG=y
# CONFIG_EPAPR_BOOT is not set
# CONFIG_DEFAULT_UIMAGE is not set
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
# CONFIG_PPC_DCR_NATIVE is not set
CONFIG_PPC_DCR_MMIO=y
CONFIG_PPC_DCR=y
CONFIG_PPC_OF_PLATFORM_PCI=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_HAVE_IRQ_WORK=y

#
# General setup
#
CONFIG_EXPERIMENTAL=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_FHANDLE=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_GENERIC_HARDIRQS=y

#
# IRQ subsystem
#
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
CONFIG_IRQ_EDGE_EOI_HANDLER=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_TIME_VSYSCALL_OLD=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_PREEMPT_RCU is not set
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_FANOUT_EXACT is not set
# CONFIG_RCU_FAST_NO_HZ is not set
# CONFIG_TREE_RCU_TRACE is not set
CONFIG_RCU_NOCB_CPU=y
CONFIG_IKCONFIG=m
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
# CONFIG_CGROUPS is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
# CONFIG_EXPERT is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_KALLSYMS=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
# CONFIG_PERF_EVENTS is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PCI_QUIRKS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_PROFILING is not set
CONFIG_HAVE_OPROFILE=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_HAVE_SYSCALL_WRAPPERS=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_ATTRS=y
CONFIG_USE_GENERIC_SMP_HELPERS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_CLONE_BACKWARDS=y

#
# GCOV-based kernel profiling
#
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_STOP_MACHINE=y
CONFIG_BLOCK=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_BLK_DEV_BSGLIB is not set
# CONFIG_BLK_DEV_INTEGRITY is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_BLOCK_COMPAT=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
# CONFIG_FREEZER is not set
CONFIG_PPC_MSI_BITMAP=y
# CONFIG_PPC_XICS is not set
# CONFIG_PPC_ICP_NATIVE is not set
# CONFIG_PPC_ICP_HV is not set
# CONFIG_PPC_ICS_RTAS is not set
# CONFIG_GE_FPGA is not set

#
# Platform support
#
# CONFIG_PPC_POWERNV is not set
# CONFIG_PPC_PSERIES is not set
# CONFIG_PPC_PMAC is not set
# CONFIG_PPC_MAPLE is not set
# CONFIG_PPC_PASEMI is not set
# CONFIG_PPC_PS3 is not set
CONFIG_PPC_CELL=y
CONFIG_PPC_CELL_COMMON=y
CONFIG_PPC_CELL_NATIVE=y
CONFIG_PPC_IBM_CELL_BLADE=y
# CONFIG_PPC_CELLEB is not set
# CONFIG_PPC_CELL_QPACE is not set
CONFIG_AXON_MSI=y

#
# Cell Broadband Engine options
#
CONFIG_SPU_FS=y
CONFIG_SPU_BASE=y
CONFIG_CBE_RAS=y
CONFIG_PPC_IBM_CELL_RESETBUTTON=y
CONFIG_CBE_THERM=y
CONFIG_CBE_CPUFREQ=y
CONFIG_CBE_CPUFREQ_PMI_ENABLE=y
CONFIG_CBE_CPUFREQ_PMI=y
CONFIG_PPC_PMI=y
CONFIG_CBE_CPUFREQ_SPU_GOVERNOR=y
# CONFIG_PQ2ADS is not set
# CONFIG_PPC_WSP is not set
# CONFIG_KVM_GUEST is not set
# CONFIG_EPAPR_PARAVIRT is not set
CONFIG_PPC_NATIVE=y
CONFIG_PPC_OF_BOOT_TRAMPOLINE=y
CONFIG_UDBG_RTAS_CONSOLE=y
# CONFIG_IPIC is not set
CONFIG_MPIC=y
# CONFIG_PPC_EPAPR_HV_PIC is not set
# CONFIG_MPIC_WEIRD is not set
CONFIG_MPIC_MSGR=y
# CONFIG_PPC_I8259 is not set
# CONFIG_U3_DART is not set
CONFIG_PPC_RTAS=y
# CONFIG_RTAS_ERROR_LOGGING is not set
# CONFIG_PPC_RTAS_DAEMON is not set
CONFIG_RTAS_PROC=y
CONFIG_RTAS_FLASH=m
CONFIG_MMIO_NVRAM=y
# CONFIG_MPIC_U3_HT_IRQS is not set
# CONFIG_PPC_MPC106 is not set
# CONFIG_PPC_970_NAP is not set
# CONFIG_PPC_P7_NAP is not set
CONFIG_PPC_INDIRECT_IO=y
CONFIG_PPC_INDIRECT_PIO=y
CONFIG_PPC_INDIRECT_MMIO=y
CONFIG_PPC_IO_WORKAROUNDS=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=m
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

#
# PowerPC CPU frequency scaling drivers
#

#
# CPU Frequency drivers
#

#
# CPUIdle driver
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_MULTIPLE_DRIVERS is not set
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
CONFIG_AXON_RAM=m
# CONFIG_FSL_ULI1575 is not set
CONFIG_SIMPLE_GPIO=y

#
# Kernel options
#
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
CONFIG_IOMMU_HELPER=y
CONFIG_SWIOTLB=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_HAS_WALK_MEMORY=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_IRQ_ALL_CPUS=y
CONFIG_NUMA=y
CONFIG_NODES_SHIFT=8
CONFIG_MAX_ACTIVE_REGIONS=256
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_SYS_SUPPORTS_HUGETLBFS=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTREMOVE is not set
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_ZONE_DMA_FLAG=1
CONFIG_BOUNCE=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_PPC_HAS_HASH_64K is not set
CONFIG_PPC_4K_PAGES=y
# CONFIG_PPC_64K_PAGES is not set
CONFIG_FORCE_MAX_ZONEORDER=13
CONFIG_SCHED_SMT=y
CONFIG_PPC_DENORMALISATION=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_EXTRA_TARGETS=""
# CONFIG_HIBERNATION is not set
CONFIG_PM_RUNTIME=y
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_SECCOMP=y
CONFIG_ISA_DMA_API=y

#
# Bus options
#
CONFIG_ZONE_DMA=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
# CONFIG_PPC_INDIRECT_PCI is not set
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_SYSCALL=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
# CONFIG_PCIE_ECRC is not set
# CONFIG_PCIEAER_INJECT is not set
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_ARCH_SUPPORTS_MSI=y
CONFIG_PCI_MSI=y
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
# CONFIG_PCCARD is not set
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HAS_RAPIDIO is not set
# CONFIG_RAPIDIO is not set
CONFIG_NONSTATIC_KERNEL=y
CONFIG_RELOCATABLE=y
CONFIG_PAGE_OFFSET=0xc000000000000000
CONFIG_KERNEL_START=0xc000000000000000
CONFIG_PHYSICAL_START=0x00000000
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=m
# CONFIG_UNIX_DIAG is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=m
CONFIG_XFRM_USER=m
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
CONFIG_INET_LRO=m
# CONFIG_INET_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=m
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
# CONFIG_INET6_XFRM_MODE_BEET is not set
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_SIT is not set
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_GRE is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set

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
CONFIG_NET_9P=m
# CONFIG_NET_9P_RDMA is not set
CONFIG_NET_9P_DEBUG=y
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
CONFIG_HAVE_BPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_FIRMWARE_IN_KERNEL is not set
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
# CONFIG_DMA_SHARED_BUFFER is not set

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y

#
# Device Tree and Open Firmware support
#
CONFIG_PROC_DEVICETREE=y
CONFIG_OF_SELFTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_DEVICE=y
CONFIG_OF_NET=y
CONFIG_OF_MDIO=m
CONFIG_OF_PCI=y
CONFIG_OF_PCI_IRQ=y
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_BLK_DEV_RBD is not set

#
# Misc devices
#
# CONFIG_SENSORS_LIS3LV02D is not set
# CONFIG_PHANTOM is not set
# CONFIG_INTEL_MID_PTI is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_PCH_PHUB is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set

#
# Altera FPGA firmware download module
#
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=m
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=m
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_TGT is not set
# CONFIG_SCSI_NETLINK is not set
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m
# CONFIG_CHR_DEV_SCH is not set
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
# CONFIG_ATA is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_I2O is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_MII is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_TUN is not set
# CONFIG_VETH is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# CONFIG_NET_DSA_MV88E6XXX is not set
# CONFIG_NET_DSA_MV88E6060 is not set
# CONFIG_NET_DSA_MV88E6XXX_NEED_PPU is not set
# CONFIG_NET_DSA_MV88E6131 is not set
# CONFIG_NET_DSA_MV88E6123_61_65 is not set
CONFIG_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
# CONFIG_NET_CADENCE is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
CONFIG_TIGON3=m
# CONFIG_BNX2X is not set
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_CALXEDA_XGMAC is not set
# CONFIG_NET_VENDOR_CHELSIO is not set
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_DNET is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
# CONFIG_NET_VENDOR_EMULEX is not set
# CONFIG_NET_VENDOR_EXAR is not set
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_IBM=y
CONFIG_IBM_EMAC=m
CONFIG_IBM_EMAC_RXB=128
CONFIG_IBM_EMAC_TXB=64
CONFIG_IBM_EMAC_POLL_WEIGHT=32
CONFIG_IBM_EMAC_RX_COPY_THRESHOLD=256
CONFIG_IBM_EMAC_RX_SKB_HEADROOM=0
# CONFIG_IBM_EMAC_DEBUG is not set
CONFIG_IBM_EMAC_ZMII=y
CONFIG_IBM_EMAC_RGMII=y
CONFIG_IBM_EMAC_TAH=y
CONFIG_IBM_EMAC_EMAC4=y
# CONFIG_IBM_EMAC_NO_FLOW_CTRL is not set
# CONFIG_IBM_EMAC_MAL_CLR_ICINTSTAT is not set
# CONFIG_IBM_EMAC_MAL_COMMON_ERR is not set
# CONFIG_NET_VENDOR_INTEL is not set
# CONFIG_IP1000 is not set
# CONFIG_JME is not set
# CONFIG_NET_VENDOR_MARVELL is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MYRI is not set
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
# CONFIG_ETHOC is not set
# CONFIG_NET_PACKET_ENGINE is not set
# CONFIG_NET_VENDOR_QLOGIC is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RDC is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_SFC is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_TOSHIBA is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_XILINX is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PHYLIB=m

#
# MII PHY device drivers
#
# CONFIG_AT803X_PHY is not set
# CONFIG_AMD_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BUS_MUX_GPIO is not set
# CONFIG_MDIO_BUS_MUX_MMIOREG is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
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
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_PPC_EPAPR_HV_BYTECHAN is not set
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_FSL=y
# CONFIG_SERIAL_8250_DW is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MFD_HSU is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_OF_PLATFORM is not set
# CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_RTAS=y
# CONFIG_HVC_UDBG is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
# CONFIG_HW_RANDOM is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
CONFIG_DEVPORT=y
# CONFIG_I2C is not set
# CONFIG_SPI is not set
# CONFIG_HSI is not set

#
# PPS support
#
CONFIG_PPS=m
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=m

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
CONFIG_ARCH_REQUIRE_GPIOLIB=y
CONFIG_GPIOLIB=y
CONFIG_OF_GPIO=y
# CONFIG_GPIO_SYSFS is not set

#
# Memory mapped GPIO drivers:
#
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_TS5500 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_VX855 is not set

#
# I2C GPIO expanders:
#

#
# PCI GPIO expanders:
#
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders:
#

#
# AC97 GPIO expanders:
#

#
# MODULbus GPIO expanders:
#

#
# USB GPIO expanders:
#
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_POWER_AVS is not set
CONFIG_HWMON=m
# CONFIG_HWMON_VID is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SCH56XX_COMMON is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_RTSX_PCI is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_LPC_SCH is not set
# CONFIG_LPC_ICH is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_REGULATOR is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_DRM is not set
# CONFIG_STUB_POULSBO is not set
# CONFIG_VGASTATE is not set
# CONFIG_VIDEO_OUTPUT_CONTROL is not set
# CONFIG_FB is not set
# CONFIG_EXYNOS_VIDEO is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Console display driver support
#
# CONFIG_VGA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
# CONFIG_SOUND is not set

#
# HID support
#
# CONFIG_HID is not set

#
# USB HID support
#
# CONFIG_USB_HID is not set
# CONFIG_HID_PID is not set
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB_ARCH_HAS_XHCI=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=m
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set
# CONFIG_USB_MON is not set
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=m
CONFIG_USB_EHCI_HCD_PPC_OF=y
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1760_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
CONFIG_USB_OHCI_HCD_PPC_OF_LE=y
CONFIG_USB_OHCI_HCD_PPC_OF=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
CONFIG_USB_OHCI_BIG_ENDIAN_DESC=y
CONFIG_USB_OHCI_BIG_ENDIAN_MMIO=y
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_CHIPIDEA is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set

#
# USB Physical Layer drivers
#
# CONFIG_USB_RCAR_PHY is not set
# CONFIG_USB_GADGET is not set

#
# OTG and related infrastructure
#
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_UWB is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ADDR_TRANS=y
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_QIB is not set
# CONFIG_INFINIBAND_AMSO1100 is not set
CONFIG_MLX4_INFINIBAND=m
# CONFIG_INFINIBAND_NES is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_IPOIB is not set
# CONFIG_INFINIBAND_SRP is not set
# CONFIG_INFINIBAND_ISER is not set
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_MM_EDAC=m
CONFIG_EDAC_CELL=m
# CONFIG_EDAC_CPC925 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# SPI RTC drivers
#

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
# CONFIG_RTC_DRV_DS2404 is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_GENERIC=m
# CONFIG_RTC_DRV_SNVS is not set
# CONFIG_DMADEVICES is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set

#
# Virtio drivers
#
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_STAGING is not set

#
# Hardware Spinlock drivers
#
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers (EXPERIMENTAL)
#
# CONFIG_STE_MODEM_RPROC is not set

#
# Rpmsg drivers (EXPERIMENTAL)
#
# CONFIG_VIRT_DRIVERS is not set
# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set
# CONFIG_IPACK_BUS is not set

#
# File systems
#
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT2_FS_XIP=y
CONFIG_EXT3_FS=m
CONFIG_EXT3_DEFAULTS_TO_ORDERED=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=m
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_FS_XIP=y
CONFIG_JBD=m
CONFIG_JBD2=m
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_FILE_LOCKING=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_QUOTA is not set
# CONFIG_QUOTACTL is not set
CONFIG_AUTOFS4_FS=m
CONFIG_FUSE_FS=m
# CONFIG_CUSE is not set

#
# Caches
#
CONFIG_FSCACHE=m
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
# CONFIG_CACHEFILES is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_CONFIGFS_FS is not set
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_LOGFS is not set
# CONFIG_CRAMFS is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_PSTORE is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_F2FS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=m
CONFIG_NFS_V2=m
CONFIG_NFS_V3=m
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
CONFIG_NFS_FSCACHE=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_XPRT_RDMA=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=m
# CONFIG_9P_FSCACHE is not set
CONFIG_9P_FS_POSIX_ACL=y
CONFIG_NLS=m
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_IO=y
CONFIG_PERCPU_RWSEM=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=m
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
# CONFIG_CRC8 is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=y
# CONFIG_AVERAGE is not set
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set

#
# Kernel hacking
#
CONFIG_PRINTK_TIME=y
CONFIG_DEFAULT_MESSAGE_LOGLEVEL=4
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_SPARSE_RCU_POINTER is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_PPC_DISABLE_WERROR is not set
CONFIG_PPC_WERROR=y
CONFIG_PRINT_STACK_DEPTH=64
# CONFIG_BOOTX_TEXT is not set
# CONFIG_PPC_EARLY_DEBUG is not set
CONFIG_STRICT_DEVMEM=y

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEYS_DEBUG_PROC_KEYS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_KEYS_COMPAT=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_HASH=m
CONFIG_CRYPTO_HASH2=m
# CONFIG_CRYPTO_MANAGER is not set
# CONFIG_CRYPTO_MANAGER2 is not set
# CONFIG_CRYPTO_USER is not set
# CONFIG_CRYPTO_GF128MUL is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_PCRYPT is not set
# CONFIG_CRYPTO_CRYPTD is not set
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_SEQIV is not set

#
# Block modes
#
# CONFIG_CRYPTO_CBC is not set
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_CTS is not set
# CONFIG_CRYPTO_ECB is not set
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set

#
# Hash modes
#
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=m
# CONFIG_CRYPTO_GHASH is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_ZLIB is not set
# CONFIG_CRYPTO_LZO is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set
# CONFIG_PPC_CLOCK is not set
# CONFIG_VIRTUALIZATION is not set

--nextPart1616500.8WGK4DeFhD
Content-Disposition: attachment; filename="dmesg.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="UTF-8"; name="dmesg.log"

[    0.000000] Allocated 20480 bytes for 32 pacas at c00000000fffb000
[    0.000000] Using Cell machine description
[    0.000000] Page orders: linear mapping = 24, virtual = 12, io = 12, vmemmap = 24
[    0.000000] Found initrd at 0xc000000004268000:0xc000000004c0b27a
[    0.000000] Found legacy serial port 0 for /axon@10000000000/plb5/plb4/opb/serial@40000200
[    0.000000]   mem=14540000200, taddr=14540000200, irq=0, clk=14745600, speed=19200
[    0.000000] Found legacy serial port 1 for /axon@10000000000/plb5/plb4/opb/serial@40000300
[    0.000000]   mem=14540000300, taddr=14540000300, irq=0, clk=14745600, speed=115200
[    0.000000] Found legacy serial port 2 for /axon@30000000000/plb5/plb4/opb/serial@40000200
[    0.000000]   mem=34540000200, taddr=34540000200, irq=0, clk=14745600, speed=-1
[    0.000000] Found legacy serial port 3 for /axon@30000000000/plb5/plb4/opb/serial@40000300
[    0.000000]   mem=34540000300, taddr=34540000300, irq=0, clk=14745600, speed=-1
[    0.000000] bootconsole [udbg0] enabled
[    0.000000] CPU maps initialized for 2 threads per core
[    0.000000]  (thread shift is 1)
[    0.000000] Freed 16384 bytes for unused pacas
[    0.000000] Starting Linux PPC64 #2 SMP Mon Apr 22 18:21:20 CEST 2013
[    0.000000] -----------------------------------------------------
[    0.000000] ppc64_pft_size                = 0x0
[    0.000000] physicalMemorySize            = 0x200000000
[    0.000000] htab_address                  = 0xc000000078000000
[    0.000000] htab_hash_mask                = 0xfffff
[    0.000000] -----------------------------------------------------
[    0.000000] Linux version 3.8.8 (root@blade00) (gcc version 4.7.2 (Gentoo 4.7.2-r1 p1.5, pie-0.5.5) ) #2 SMP Mon Apr 22 18:21:20 CEST 2013
[    0.000000] *** 0000 : CF000012

[    0.000000] *** 0000 : Setup Arch
[    0.000000] [boot]0012 Setup Arch
[    0.000000] Node 0 Memory: 0x0-0x100000000
[    0.000000] Node 1 Memory: 0x100000000-0x200000000
[    0.000000] mmio NVRAM, 1020k at 0x14502000000 mapped to d000080080008000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00000000-0x1ffffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0xffffffff]
[    0.000000]   node   1: [mem 0x100000000-0x1ffffffff]
[    0.000000] On node 0 totalpages: 1048576
[    0.000000]   DMA zone: 14336 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 1034240 pages, LIFO batch:31
[    0.000000] On node 1 totalpages: 1048576
[    0.000000]   DMA zone: 14336 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 1034240 pages, LIFO batch:31
[    0.000000] *** 0000 : CF000015

[    0.000000] *** 0000 : Setup Done
[    0.000000] [boot]0015 Setup Done
[    0.000000] PERCPU: Embedded 11 pages/cpu @c000000000900000 s14848 r0 d30208 u262144
[    0.000000] pcpu-alloc: s14848 r0 d30208 u262144 alloc=1*1048576
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 2 zonelists in Node order, mobility grouping on.  Total pages: 2068480
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line:  ksdevice=bootif lang=  ip=eth0:dhcp root=nfs:192.168.100.1:/export/gentoo/root-ppc64 text  
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] freeing bootmem node 0
[    0.000000] freeing bootmem node 1
[    0.000000] Memory: 8057880k/8388608k available (6188k kernel code, 330728k reserved, 700k data, 1304k bss, 2096k init)
[    0.000000] SLUB: Genslabs=15, HWalign=128, Order=0-3, MinObjects=0, CPUs=4, Nodes=256
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=32 to nr_cpu_ids=4.
[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] IIC for CPU 0 target id 0xe : /be@20000000000/interrupt-controller@508400
[    0.000000] IIC for CPU 1 target id 0xf : /be@20000000000/interrupt-controller@508400
[    0.000000] IIC for CPU 2 target id 0x1e : /be@20100000000/interrupt-controller@508400
[    0.000000] IIC for CPU 3 target id 0x1f : /be@20100000000/interrupt-controller@508400
[    0.000000] mpic: Setting up MPIC " MPIC     " version 1.2 at 0, max 4 CPUs
[    0.000000] mpic: ISU size: 128, shift: 7, mask: 7f
[    0.000000] mpic: Initializing for 128 sources
[    0.000000] /axon@10000000000/interrupt-controller: hooking up to IRQ 43
[    0.000000] mpic: Setting up MPIC " MPIC     " version 1.2 at 0, max 4 CPUs
[    0.000000] mpic: ISU size: 128, shift: 7, mask: 7f
[    0.000000] mpic: Initializing for 128 sources
[    0.000000] /axon@30000000000/interrupt-controller: hooking up to IRQ 299
[    0.000000] time_init: decrementer frequency = 26.664380 MHz
[    0.000000] time_init: processor frequency   = 3200.000000 MHz
[    0.000000] clocksource: timebase mult[2580d2c2] shift[24] registered
[    0.000000] clockevent: decrementer mult[6d37a10] shift[32] cpu[0]
[    0.000000] Console: colour dummy device 80x25
[    0.065091] pid_max: default: 32768 minimum: 301
[    0.095745] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.151501] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.199100] Mount-cache hash table entries: 256
[    0.231379] Brought up 4 CPUs
[    0.248670] Node 0 CPUs: 0-1
[    0.248679] Node 1 CPUs: 2-3
[    0.249395] devtmpfs: initialized
[    0.316507] NET: Registered protocol family 16
[    0.342962] iommu: node 0, dynamic window 0x0-0x80000000 fixed window 0x80000000-0x280000000
[    0.344275] IOMMU: Using strong ordering for fixed mapping
[    0.378760] IOMMU table initialized, virtual merging enabled
[    0.412270] iommu: node 1, dynamic window 0x0-0x80000000 fixed window 0x80000000-0x280000000
[    0.414432] IOMMU: Using strong ordering for fixed mapping
[    0.468468] PCI: Probing PCI hardware
[    0.489926] PCI: Probing PCI hardware done
[    0.490315] irq: irq-93==>hwirq-0x5d mapping failed: -22
[    0.521713] ------------[ cut here ]------------
[    0.549291] WARNING: at /usr/src/linux-3.8.8/kernel/irq/irqdomain.c:467
[    0.588875] Modules linked in:
[    0.607107] NIP: c0000000000be464 LR: c0000000000be460 CTR: c000000000024448
[    0.649297] REGS: c0000000fe69f190 TRAP: 0700   Not tainted  (3.8.8)
[    0.687316] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 44000024  XER: 00000000
[    0.734193] SOFTE: 1
[    0.747216] TASK = c0000000fe6a0000[1] 'swapper/0' THREAD: c0000000fe69c000 CPU: 1
GPR00: c0000000000be460 c0000000fe69f410 c0000000006a1e08 000000000000002c 
GPR04: 0000000000000000 00000000780f66c9 0000000000000008 0000000000000000 
GPR08: 00000000781841f7 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb280 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000000fe006078 000000000000005e 
GPR24: 0000000000000174 000000000000005d 000000000000005d c0000000fe748d00 
GPR28: c0000000fe006060 000000000000005d c00000000064aea0 000000000000005d 
[    1.113385] NIP [c0000000000be464] .irq_domain_associate_many+0x264/0x290
[    1.154004] LR [c0000000000be460] .irq_domain_associate_many+0x260/0x290
[    1.194106] Call Trace:
[    1.208694] [c0000000fe69f410] [c0000000000be460] .irq_domain_associate_many+0x260/0x290 (unreliable)
[    1.263904] [c0000000fe69f4e0] [c0000000000beee0] .irq_create_mapping+0xc8/0x1d0
[    1.308176] [c0000000fe69f580] [c0000000000bf090] .irq_create_of_mapping+0xa8/0x170
[    1.354016] [c0000000fe69f630] [c000000000290740] .irq_of_parse_and_map+0x40/0x58
[    1.398805] [c0000000fe69f6c0] [c000000000290900] .of_irq_count+0x30/0x58
[    1.439432] [c0000000fe69f750] [c00000000029133c] .of_device_alloc+0x1ec/0x288
[    1.482663] [c0000000fe69f850] [c00000000029142c] .of_platform_device_create_pdata+0x54/0xf8
[    1.533185] [c0000000fe69f8f0] [c000000000291614] .of_platform_bus_create+0x144/0x1e0
[    1.580062] [c0000000fe69f9e0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[    1.626939] [c0000000fe69fad0] [c000000000291860] .of_platform_bus_probe+0xd0/0x140
[    1.672777] [c0000000fe69fb70] [c000000000410f24] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[    1.730593] [c0000000fe69fc40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[    1.773821] [c0000000fe69fd00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[    1.819654] [c0000000fe69fdb0] [c00000000000a47c] .kernel_init+0x1c/0x108
[    1.860282] [c0000000fe69fe30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[    1.906112] Instruction dump:
[    1.923821] 7fa4eb78 7ca507b4 4828aa89 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[    1.970177] 7fa4eb78 7fe5fb78 4828aa69 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[    2.017587] ---[ end trace c6cef7a91fd6095f ]---
[    2.045735] irq: irq-59==>hwirq-0x3b mapping failed: -22
[    2.077069] ------------[ cut here ]------------
[    2.104662] WARNING: at /usr/src/linux-3.8.8/kernel/irq/irqdomain.c:467
[    2.144247] Modules linked in:
[    2.162478] NIP: c0000000000be464 LR: c0000000000be460 CTR: c000000000024448
[    2.204667] REGS: c0000000fe69efb0 TRAP: 0700   Tainted: G        W     (3.8.8)
[    2.248417] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 44000024  XER: 00000000
[    2.295294] SOFTE: 1
[    2.308316] TASK = c0000000fe6a0000[1] 'swapper/0' THREAD: c0000000fe69c000 CPU: 1
GPR00: c0000000000be460 c0000000fe69f230 c0000000006a1e08 000000000000002c 
GPR04: 0000000000000000 000000007a88331f 0000000000000008 0000000000000000 
GPR08: 000000007a9115ed 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb280 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000000fe006078 000000000000003c 
GPR24: 00000000000000ec 000000000000003b 000000000000003b c0000000fe74f200 
GPR28: c0000000fe006060 000000000000003b c00000000064aea0 000000000000003b 
[    2.674480] NIP [c0000000000be464] .irq_domain_associate_many+0x264/0x290
[    2.715105] LR [c0000000000be460] .irq_domain_associate_many+0x260/0x290
[    2.755207] Call Trace:
[    2.769795] [c0000000fe69f230] [c0000000000be460] .irq_domain_associate_many+0x260/0x290 (unreliable)
[    2.825005] [c0000000fe69f300] [c0000000000beee0] .irq_create_mapping+0xc8/0x1d0
[    2.869277] [c0000000fe69f3a0] [c0000000000bf090] .irq_create_of_mapping+0xa8/0x170
[    2.915113] [c0000000fe69f450] [c000000000290740] .irq_of_parse_and_map+0x40/0x58
[    2.959905] [c0000000fe69f4e0] [c000000000290900] .of_irq_count+0x30/0x58
[    3.000532] [c0000000fe69f570] [c00000000029133c] .of_device_alloc+0x1ec/0x288
[    3.043763] [c0000000fe69f670] [c00000000029142c] .of_platform_device_create_pdata+0x54/0xf8
[    3.094285] [c0000000fe69f710] [c000000000291614] .of_platform_bus_create+0x144/0x1e0
[    3.141163] [c0000000fe69f800] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[    3.188039] [c0000000fe69f8f0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[    3.234915] [c0000000fe69f9e0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[    3.281793] [c0000000fe69fad0] [c000000000291860] .of_platform_bus_probe+0xd0/0x140
[    3.327628] [c0000000fe69fb70] [c000000000410f24] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[    3.385447] [c0000000fe69fc40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[    3.428674] [c0000000fe69fd00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[    3.474509] [c0000000fe69fdb0] [c00000000000a47c] .kernel_init+0x1c/0x108
[    3.515135] [c0000000fe69fe30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[    3.560966] Instruction dump:
[    3.578675] 7fa4eb78 7ca507b4 4828aa89 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[    3.625031] 7fa4eb78 7fe5fb78 4828aa69 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[    3.672429] ---[ end trace c6cef7a91fd60960 ]---
[    3.701051] irq: irq-18==>hwirq-0x2 mapping failed: -22
[    3.731872] ------------[ cut here ]------------
[    3.759465] WARNING: at /usr/src/linux-3.8.8/kernel/irq/irqdomain.c:467
[    3.799048] Modules linked in:
[    3.817280] NIP: c0000000000be464 LR: c0000000000be460 CTR: c000000000024448
[    3.859470] REGS: c0000000fe69eec0 TRAP: 0700   Tainted: G        W     (3.8.8)
[    3.903219] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 44000024  XER: 00000000
[    3.950095] SOFTE: 1
[    3.963119] TASK = c0000000fe6a0000[1] 'swapper/0' THREAD: c0000000fe69c000 CPU: 1
GPR00: c0000000000be460 c0000000fe69f140 c0000000006a1e08 000000000000002b 
GPR04: 0000000000000000 000000007d298111 0000000000000008 0000000000000000 
GPR08: 000000007d325e5f 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb280 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000000fe006078 0000000000000013 
GPR24: 0000000000000008 0000000000000002 0000000000000012 c0000000fe74f600 
GPR28: c0000000fe006060 0000000000000012 c00000000064aea0 0000000000000002 
[    4.329282] NIP [c0000000000be464] .irq_domain_associate_many+0x264/0x290
[    4.369906] LR [c0000000000be460] .irq_domain_associate_many+0x260/0x290
[    4.410008] Call Trace:
[    4.424596] [c0000000fe69f140] [c0000000000be460] .irq_domain_associate_many+0x260/0x290 (unreliable)
[    4.479807] [c0000000fe69f210] [c0000000000beee0] .irq_create_mapping+0xc8/0x1d0
[    4.524079] [c0000000fe69f2b0] [c0000000000bf090] .irq_create_of_mapping+0xa8/0x170
[    4.569915] [c0000000fe69f360] [c000000000290740] .irq_of_parse_and_map+0x40/0x58
[    4.614707] [c0000000fe69f3f0] [c000000000290900] .of_irq_count+0x30/0x58
[    4.655334] [c0000000fe69f480] [c00000000029133c] .of_device_alloc+0x1ec/0x288
[    4.698565] [c0000000fe69f580] [c00000000029142c] .of_platform_device_create_pdata+0x54/0xf8
[    4.749088] [c0000000fe69f620] [c000000000291614] .of_platform_bus_create+0x144/0x1e0
[    4.795965] [c0000000fe69f710] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[    4.842841] [c0000000fe69f800] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[    4.889718] [c0000000fe69f8f0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[    4.936595] [c0000000fe69f9e0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[    4.983472] [c0000000fe69fad0] [c000000000291860] .of_platform_bus_probe+0xd0/0x140
[    5.029308] [c0000000fe69fb70] [c000000000410f24] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[    5.087122] [c0000000fe69fc40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[    5.130352] [c0000000fe69fd00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[    5.176187] [c0000000fe69fdb0] [c00000000000a47c] .kernel_init+0x1c/0x108
[    5.216814] [c0000000fe69fe30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[    5.262645] Instruction dump:
[    5.280354] 7fa4eb78 7ca507b4 4828aa89 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[    5.326710] 7fa4eb78 7fe5fb78 4828aa69 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[    5.374108] ---[ end trace c6cef7a91fd60961 ]---
[    5.403514] irq: irq-102==>hwirq-0x66 mapping failed: -22
[    5.435373] ------------[ cut here ]------------
[    5.462966] WARNING: at /usr/src/linux-3.8.8/kernel/irq/irqdomain.c:467
[    5.502550] Modules linked in:
[    5.520782] NIP: c0000000000be464 LR: c0000000000be460 CTR: c000000000024448
[    5.562971] REGS: c0000000fe69f0a0 TRAP: 0700   Tainted: G        W     (3.8.8)
[    5.606721] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 44000024  XER: 00000000
[    5.653597] SOFTE: 1
[    5.666620] TASK = c0000000fe6a0000[1] 'swapper/0' THREAD: c0000000fe69c000 CPU: 1
GPR00: c0000000000be460 c0000000fe69f320 c0000000006a1e08 000000000000002d 
GPR04: 0000000000000000 000000007fdddc30 0000000000000008 0000000000000000 
GPR08: 000000007fe77743 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb280 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000000fe006078 0000000000000067 
GPR24: 0000000000000198 0000000000000066 0000000000000066 c0000000fe765000 
GPR28: c0000000fe006060 0000000000000066 c00000000064aea0 0000000000000066 
[    6.032783] NIP [c0000000000be464] .irq_domain_associate_many+0x264/0x290
[    6.073408] LR [c0000000000be460] .irq_domain_associate_many+0x260/0x290
[    6.113511] Call Trace:
[    6.128099] [c0000000fe69f320] [c0000000000be460] .irq_domain_associate_many+0x260/0x290 (unreliable)
[    6.183308] [c0000000fe69f3f0] [c0000000000beee0] .irq_create_mapping+0xc8/0x1d0
[    6.227580] [c0000000fe69f490] [c0000000000bf090] .irq_create_of_mapping+0xa8/0x170
[    6.273417] [c0000000fe69f540] [c000000000290740] .irq_of_parse_and_map+0x40/0x58
[    6.318209] [c0000000fe69f5d0] [c000000000290900] .of_irq_count+0x30/0x58
[    6.358836] [c0000000fe69f660] [c00000000029133c] .of_device_alloc+0x1ec/0x288
[    6.402067] [c0000000fe69f760] [c00000000029142c] .of_platform_device_create_pdata+0x54/0xf8
[    6.452589] [c0000000fe69f800] [c000000000291614] .of_platform_bus_create+0x144/0x1e0
[    6.499466] [c0000000fe69f8f0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[    6.546343] [c0000000fe69f9e0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[    6.593219] [c0000000fe69fad0] [c000000000291860] .of_platform_bus_probe+0xd0/0x140
[    6.639056] [c0000000fe69fb70] [c000000000410f24] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[    6.696871] [c0000000fe69fc40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[    6.740100] [c0000000fe69fd00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[    6.785935] [c0000000fe69fdb0] [c00000000000a47c] .kernel_init+0x1c/0x108
[    6.826562] [c0000000fe69fe30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[    6.872393] Instruction dump:
[    6.890102] 7fa4eb78 7ca507b4 4828aa89 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[    6.936458] 7fa4eb78 7fe5fb78 4828aa69 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[    6.983857] ---[ end trace c6cef7a91fd60962 ]---
[    7.011665] irq: irq-110==>hwirq-0x6e mapping failed: -22
[    7.043765] ------------[ cut here ]------------
[    7.071360] WARNING: at /usr/src/linux-3.8.8/kernel/irq/irqdomain.c:467
[    7.110944] Modules linked in:
[    7.129175] NIP: c0000000000be464 LR: c0000000000be460 CTR: c000000000024448
[    7.171365] REGS: c0000000fe69f0a0 TRAP: 0700   Tainted: G        W     (3.8.8)
[    7.215115] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[    7.261992] SOFTE: 1
[    7.275014] TASK = c0000000fe6a0000[1] 'swapper/0' THREAD: c0000000fe69c000 CPU: 1
GPR00: c0000000000be460 c0000000fe69f320 c0000000006a1e08 000000000000002d 
GPR04: 0000000000000000 00000000826ccf99 0000000000000008 0000000000000000 
GPR08: 000000008275ddfa 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb280 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000000fe006078 000000000000006f 
GPR24: 00000000000001b8 000000000000006e 000000000000006e c0000000fe765000 
GPR28: c0000000fe006060 000000000000006e c00000000064aea0 000000000000006e 
[    7.641177] NIP [c0000000000be464] .irq_domain_associate_many+0x264/0x290
[    7.681803] LR [c0000000000be460] .irq_domain_associate_many+0x260/0x290
[    7.721905] Call Trace:
[    7.736492] [c0000000fe69f320] [c0000000000be460] .irq_domain_associate_many+0x260/0x290 (unreliable)
[    7.791703] [c0000000fe69f3f0] [c0000000000beee0] .irq_create_mapping+0xc8/0x1d0
[    7.835975] [c0000000fe69f490] [c0000000000bf090] .irq_create_of_mapping+0xa8/0x170
[    7.881810] [c0000000fe69f540] [c000000000290740] .irq_of_parse_and_map+0x40/0x58
[    7.926603] [c0000000fe69f5d0] [c000000000290900] .of_irq_count+0x30/0x58
[    7.967230] [c0000000fe69f660] [c00000000029133c] .of_device_alloc+0x1ec/0x288
[    8.010461] [c0000000fe69f760] [c00000000029142c] .of_platform_device_create_pdata+0x54/0xf8
[    8.060983] [c0000000fe69f800] [c000000000291614] .of_platform_bus_create+0x144/0x1e0
[    8.107860] [c0000000fe69f8f0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[    8.154737] [c0000000fe69f9e0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[    8.201613] [c0000000fe69fad0] [c000000000291860] .of_platform_bus_probe+0xd0/0x140
[    8.247449] [c0000000fe69fb70] [c000000000410f24] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[    8.305263] [c0000000fe69fc40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[    8.348494] [c0000000fe69fd00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[    8.394329] [c0000000fe69fdb0] [c00000000000a47c] .kernel_init+0x1c/0x108
[    8.434956] [c0000000fe69fe30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[    8.480787] Instruction dump:
[    8.498496] 7fa4eb78 7ca507b4 4828aa89 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[    8.544852] 7fa4eb78 7fe5fb78 4828aa69 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[    8.592251] ---[ end trace c6cef7a91fd60963 ]---
[    8.620092] irq: irq-39==>hwirq-0x27 mapping failed: -22
[    8.651638] ------------[ cut here ]------------
[    8.679234] WARNING: at /usr/src/linux-3.8.8/kernel/irq/irqdomain.c:467
[    8.718816] Modules linked in:
[    8.737049] NIP: c0000000000be464 LR: c0000000000be460 CTR: c000000000024448
[    8.779238] REGS: c0000000fe69f0a0 TRAP: 0700   Tainted: G        W     (3.8.8)
[    8.822988] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[    8.869865] SOFTE: 1
[    8.882888] TASK = c0000000fe6a0000[1] 'swapper/0' THREAD: c0000000fe69c000 CPU: 1
GPR00: c0000000000be460 c0000000fe69f320 c0000000006a1e08 000000000000002c 
GPR04: 0000000000000000 0000000084fb364a 0000000000000008 0000000000000000 
GPR08: 0000000085040e5f 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb280 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000000fe006078 0000000000000028 
GPR24: 000000000000009c 0000000000000027 0000000000000027 c0000000fe765100 
GPR28: c0000000fe006060 0000000000000027 c00000000064aea0 0000000000000027 
[    9.249050] NIP [c0000000000be464] .irq_domain_associate_many+0x264/0x290
[    9.289675] LR [c0000000000be460] .irq_domain_associate_many+0x260/0x290
[    9.329778] Call Trace:
[    9.344366] [c0000000fe69f320] [c0000000000be460] .irq_domain_associate_many+0x260/0x290 (unreliable)
[    9.399576] [c0000000fe69f3f0] [c0000000000beee0] .irq_create_mapping+0xc8/0x1d0
[    9.443848] [c0000000fe69f490] [c0000000000bf090] .irq_create_of_mapping+0xa8/0x170
[    9.489684] [c0000000fe69f540] [c000000000290740] .irq_of_parse_and_map+0x40/0x58
[    9.534476] [c0000000fe69f5d0] [c000000000290900] .of_irq_count+0x30/0x58
[    9.575104] [c0000000fe69f660] [c00000000029133c] .of_device_alloc+0x1ec/0x288
[    9.618334] [c0000000fe69f760] [c00000000029142c] .of_platform_device_create_pdata+0x54/0xf8
[    9.668857] [c0000000fe69f800] [c000000000291614] .of_platform_bus_create+0x144/0x1e0
[    9.715733] [c0000000fe69f8f0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[    9.762610] [c0000000fe69f9e0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[    9.809487] [c0000000fe69fad0] [c000000000291860] .of_platform_bus_probe+0xd0/0x140
[    9.855322] [c0000000fe69fb70] [c000000000410f24] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[    9.913137] [c0000000fe69fc40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[    9.956368] [c0000000fe69fd00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[   10.002203] [c0000000fe69fdb0] [c00000000000a47c] .kernel_init+0x1c/0x108
[   10.042829] [c0000000fe69fe30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[   10.088660] Instruction dump:
[   10.106369] 7fa4eb78 7ca507b4 4828aa89 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[   10.152725] 7fa4eb78 7fe5fb78 4828aa69 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[   10.200124] ---[ end trace c6cef7a91fd60964 ]---
[   10.228218] irq: irq-93==>hwirq-0x5d mapping failed: -22
[   10.259569] ------------[ cut here ]------------
[   10.287158] WARNING: at /usr/src/linux-3.8.8/kernel/irq/irqdomain.c:467
[   10.326742] Modules linked in:
[   10.344974] NIP: c0000000000be464 LR: c0000000000be460 CTR: c000000000024448
[   10.387163] REGS: c0000000fe69f190 TRAP: 0700   Tainted: G        W     (3.8.8)
[   10.430913] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[   10.477790] SOFTE: 1
[   10.490812] TASK = c0000000fe6a0000[1] 'swapper/0' THREAD: c0000000fe69c000 CPU: 1
GPR00: c0000000000be460 c0000000fe69f410 c0000000006a1e08 000000000000002c 
GPR04: 0000000000000000 00000000878966be 0000000000000008 0000000000000000 
GPR08: 0000000087924447 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb280 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000001fe001018 000000000000005e 
GPR24: 0000000000000174 000000000000005d 000000000000005d c0000001fe740100 
GPR28: c0000001fe001000 000000000000005d c00000000064aea0 000000000000005d 
[   10.856976] NIP [c0000000000be464] .irq_domain_associate_many+0x264/0x290
[   10.897601] LR [c0000000000be460] .irq_domain_associate_many+0x260/0x290
[   10.937703] Call Trace:
[   10.952291] [c0000000fe69f410] [c0000000000be460] .irq_domain_associate_many+0x260/0x290 (unreliable)
[   11.007501] [c0000000fe69f4e0] [c0000000000beee0] .irq_create_mapping+0xc8/0x1d0
[   11.051773] [c0000000fe69f580] [c0000000000bf090] .irq_create_of_mapping+0xa8/0x170
[   11.097609] [c0000000fe69f630] [c000000000290740] .irq_of_parse_and_map+0x40/0x58
[   11.142402] [c0000000fe69f6c0] [c000000000290900] .of_irq_count+0x30/0x58
[   11.183028] [c0000000fe69f750] [c00000000029133c] .of_device_alloc+0x1ec/0x288
[   11.226260] [c0000000fe69f850] [c00000000029142c] .of_platform_device_create_pdata+0x54/0xf8
[   11.276782] [c0000000fe69f8f0] [c000000000291614] .of_platform_bus_create+0x144/0x1e0
[   11.323659] [c0000000fe69f9e0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[   11.370535] [c0000000fe69fad0] [c000000000291860] .of_platform_bus_probe+0xd0/0x140
[   11.416371] [c0000000fe69fb70] [c000000000410f24] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[   11.474186] [c0000000fe69fc40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[   11.517416] [c0000000fe69fd00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[   11.563251] [c0000000fe69fdb0] [c00000000000a47c] .kernel_init+0x1c/0x108
[   11.603877] [c0000000fe69fe30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[   11.649709] Instruction dump:
[   11.667418] 7fa4eb78 7ca507b4 4828aa89 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[   11.713774] 7fa4eb78 7fe5fb78 4828aa69 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[   11.761172] ---[ end trace c6cef7a91fd60965 ]---
[   11.789366] irq: irq-59==>hwirq-0x3b mapping failed: -22
[   11.820719] ------------[ cut here ]------------
[   11.848311] WARNING: at /usr/src/linux-3.8.8/kernel/irq/irqdomain.c:467
[   11.887895] Modules linked in:
[   11.906126] NIP: c0000000000be464 LR: c0000000000be460 CTR: c000000000024448
[   11.948316] REGS: c0000000fe69efb0 TRAP: 0700   Tainted: G        W     (3.8.8)
[   11.992066] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[   12.038943] SOFTE: 1
[   12.051966] TASK = c0000000fe6a0000[1] 'swapper/0' THREAD: c0000000fe69c000 CPU: 1
GPR00: c0000000000be460 c0000000fe69f230 c0000000006a1e08 000000000000002c 
GPR04: 0000000000000000 000000008a0489e8 0000000000000008 0000000000000000 
GPR08: 000000008a0d724a 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb280 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000001fe001018 000000000000003c 
GPR24: 00000000000000ec 000000000000003b 000000000000003b c0000001fe740600 
GPR28: c0000001fe001000 000000000000003b c00000000064aea0 000000000000003b 
[   12.418129] NIP [c0000000000be464] .irq_domain_associate_many+0x264/0x290
[   12.458753] LR [c0000000000be460] .irq_domain_associate_many+0x260/0x290
[   12.498855] Call Trace:
[   12.513444] [c0000000fe69f230] [c0000000000be460] .irq_domain_associate_many+0x260/0x290 (unreliable)
[   12.568654] [c0000000fe69f300] [c0000000000beee0] .irq_create_mapping+0xc8/0x1d0
[   12.612926] [c0000000fe69f3a0] [c0000000000bf090] .irq_create_of_mapping+0xa8/0x170
[   12.658762] [c0000000fe69f450] [c000000000290740] .irq_of_parse_and_map+0x40/0x58
[   12.703554] [c0000000fe69f4e0] [c000000000290900] .of_irq_count+0x30/0x58
[   12.744181] [c0000000fe69f570] [c00000000029133c] .of_device_alloc+0x1ec/0x288
[   12.787411] [c0000000fe69f670] [c00000000029142c] .of_platform_device_create_pdata+0x54/0xf8
[   12.837934] [c0000000fe69f710] [c000000000291614] .of_platform_bus_create+0x144/0x1e0
[   12.884811] [c0000000fe69f800] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[   12.931688] [c0000000fe69f8f0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[   12.978565] [c0000000fe69f9e0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[   13.025441] [c0000000fe69fad0] [c000000000291860] .of_platform_bus_probe+0xd0/0x140
[   13.071277] [c0000000fe69fb70] [c000000000410f24] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[   13.129092] [c0000000fe69fc40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[   13.172322] [c0000000fe69fd00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[   13.218157] [c0000000fe69fdb0] [c00000000000a47c] .kernel_init+0x1c/0x108
[   13.258784] [c0000000fe69fe30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[   13.304615] Instruction dump:
[   13.322324] 7fa4eb78 7ca507b4 4828aa89 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[   13.368680] 7fa4eb78 7fe5fb78 4828aa69 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[   13.416078] ---[ end trace c6cef7a91fd60966 ]---
[   13.444283] irq: irq-20==>hwirq-0x2 mapping failed: -22
[   13.475102] ------------[ cut here ]------------
[   13.502696] WARNING: at /usr/src/linux-3.8.8/kernel/irq/irqdomain.c:467
[   13.542280] Modules linked in:
[   13.560512] NIP: c0000000000be464 LR: c0000000000be460 CTR: c000000000024448
[   13.602701] REGS: c0000000fe69eec0 TRAP: 0700   Tainted: G        W     (3.8.8)
[   13.646451] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[   13.693328] SOFTE: 1
[   13.706350] TASK = c0000000fe6a0000[1] 'swapper/0' THREAD: c0000000fe69c000 CPU: 1
GPR00: c0000000000be460 c0000000fe69f140 c0000000006a1e08 000000000000002b 
GPR04: 0000000000000000 000000008ca5dd66 0000000000000008 0000000000000000 
GPR08: 000000008cae8f62 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb280 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000001fe001018 0000000000000015 
GPR24: 0000000000000008 0000000000000002 0000000000000014 c0000001fe740900 
GPR28: c0000001fe001000 0000000000000014 c00000000064aea0 0000000000000002 
[   14.072513] NIP [c0000000000be464] .irq_domain_associate_many+0x264/0x290
[   14.113138] LR [c0000000000be460] .irq_domain_associate_many+0x260/0x290
[   14.153241] Call Trace:
[   14.167829] [c0000000fe69f140] [c0000000000be460] .irq_domain_associate_many+0x260/0x290 (unreliable)
[   14.223038] [c0000000fe69f210] [c0000000000beee0] .irq_create_mapping+0xc8/0x1d0
[   14.267311] [c0000000fe69f2b0] [c0000000000bf090] .irq_create_of_mapping+0xa8/0x170
[   14.313147] [c0000000fe69f360] [c000000000290740] .irq_of_parse_and_map+0x40/0x58
[   14.357940] [c0000000fe69f3f0] [c000000000290900] .of_irq_count+0x30/0x58
[   14.398566] [c0000000fe69f480] [c00000000029133c] .of_device_alloc+0x1ec/0x288
[   14.441797] [c0000000fe69f580] [c00000000029142c] .of_platform_device_create_pdata+0x54/0xf8
[   14.492320] [c0000000fe69f620] [c000000000291614] .of_platform_bus_create+0x144/0x1e0
[   14.539197] [c0000000fe69f710] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[   14.586073] [c0000000fe69f800] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[   14.632950] [c0000000fe69f8f0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[   14.679827] [c0000000fe69f9e0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[   14.726703] [c0000000fe69fad0] [c000000000291860] .of_platform_bus_probe+0xd0/0x140
[   14.772539] [c0000000fe69fb70] [c000000000410f24] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[   14.830354] [c0000000fe69fc40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[   14.873585] [c0000000fe69fd00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[   14.919420] [c0000000fe69fdb0] [c00000000000a47c] .kernel_init+0x1c/0x108
[   14.960046] [c0000000fe69fe30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[   15.005877] Instruction dump:
[   15.023586] 7fa4eb78 7ca507b4 4828aa89 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[   15.069942] 7fa4eb78 7fe5fb78 4828aa69 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[   15.117340] ---[ end trace c6cef7a91fd60967 ]---
[   15.146930] irq: irq-108==>hwirq-0x66 mapping failed: -22
[   15.178814] ------------[ cut here ]------------
[   15.206407] WARNING: at /usr/src/linux-3.8.8/kernel/irq/irqdomain.c:467
[   15.245991] Modules linked in:
[   15.264221] NIP: c0000000000be464 LR: c0000000000be460 CTR: c000000000024448
[   15.306412] REGS: c0000000fe69f0a0 TRAP: 0700   Tainted: G        W     (3.8.8)
[   15.350161] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[   15.397038] SOFTE: 1
[   15.410061] TASK = c0000000fe6a0000[1] 'swapper/0' THREAD: c0000000fe69c000 CPU: 1
GPR00: c0000000000be460 c0000000fe69f320 c0000000006a1e08 000000000000002d 
GPR04: 0000000000000000 000000008f5a0d0f 0000000000000008 0000000000000000 
GPR08: 000000008f63bdf3 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb280 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000001fe001018 000000000000006d 
GPR24: 0000000000000198 0000000000000066 000000000000006c c0000001fe74f400 
GPR28: c0000001fe001000 000000000000006c c00000000064aea0 0000000000000066 
[   15.776224] NIP [c0000000000be464] .irq_domain_associate_many+0x264/0x290
[   15.816849] LR [c0000000000be460] .irq_domain_associate_many+0x260/0x290
[   15.856951] Call Trace:
[   15.871539] [c0000000fe69f320] [c0000000000be460] .irq_domain_associate_many+0x260/0x290 (unreliable)
[   15.926749] [c0000000fe69f3f0] [c0000000000beee0] .irq_create_mapping+0xc8/0x1d0
[   15.971021] [c0000000fe69f490] [c0000000000bf090] .irq_create_of_mapping+0xa8/0x170
[   16.016857] [c0000000fe69f540] [c000000000290740] .irq_of_parse_and_map+0x40/0x58
[   16.061650] [c0000000fe69f5d0] [c000000000290900] .of_irq_count+0x30/0x58
[   16.102276] [c0000000fe69f660] [c00000000029133c] .of_device_alloc+0x1ec/0x288
[   16.145507] [c0000000fe69f760] [c00000000029142c] .of_platform_device_create_pdata+0x54/0xf8
[   16.196030] [c0000000fe69f800] [c000000000291614] .of_platform_bus_create+0x144/0x1e0
[   16.242907] [c0000000fe69f8f0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[   16.289784] [c0000000fe69f9e0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[   16.336660] [c0000000fe69fad0] [c000000000291860] .of_platform_bus_probe+0xd0/0x140
[   16.382497] [c0000000fe69fb70] [c000000000410f24] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[   16.440311] [c0000000fe69fc40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[   16.483541] [c0000000fe69fd00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[   16.529376] [c0000000fe69fdb0] [c00000000000a47c] .kernel_init+0x1c/0x108
[   16.570003] [c0000000fe69fe30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[   16.615834] Instruction dump:
[   16.633543] 7fa4eb78 7ca507b4 4828aa89 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[   16.679898] 7fa4eb78 7fe5fb78 4828aa69 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[   16.727297] ---[ end trace c6cef7a91fd60968 ]---
[   16.755113] irq: irq-110==>hwirq-0x6e mapping failed: -22
[   16.787205] ------------[ cut here ]------------
[   16.814800] WARNING: at /usr/src/linux-3.8.8/kernel/irq/irqdomain.c:467
[   16.854385] Modules linked in:
[   16.872616] NIP: c0000000000be464 LR: c0000000000be460 CTR: c000000000024448
[   16.914806] REGS: c0000000fe69f0a0 TRAP: 0700   Tainted: G        W     (3.8.8)
[   16.958555] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[   17.005432] SOFTE: 1
[   17.018455] TASK = c0000000fe6a0000[1] 'swapper/0' THREAD: c0000000fe69c000 CPU: 1
GPR00: c0000000000be460 c0000000fe69f320 c0000000006a1e08 000000000000002d 
GPR04: 0000000000000000 0000000091e91645 0000000000000008 0000000000000000 
GPR08: 0000000091f22499 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb280 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000001fe001018 000000000000006f 
GPR24: 00000000000001b8 000000000000006e 000000000000006e c0000001fe74f400 
GPR28: c0000001fe001000 000000000000006e c00000000064aea0 000000000000006e 
[   17.384618] NIP [c0000000000be464] .irq_domain_associate_many+0x264/0x290
[   17.425243] LR [c0000000000be460] .irq_domain_associate_many+0x260/0x290
[   17.465345] Call Trace:
[   17.479932] [c0000000fe69f320] [c0000000000be460] .irq_domain_associate_many+0x260/0x290 (unreliable)
[   17.535143] [c0000000fe69f3f0] [c0000000000beee0] .irq_create_mapping+0xc8/0x1d0
[   17.579415] [c0000000fe69f490] [c0000000000bf090] .irq_create_of_mapping+0xa8/0x170
[   17.625251] [c0000000fe69f540] [c000000000290740] .irq_of_parse_and_map+0x40/0x58
[   17.670043] [c0000000fe69f5d0] [c000000000290900] .of_irq_count+0x30/0x58
[   17.710670] [c0000000fe69f660] [c00000000029133c] .of_device_alloc+0x1ec/0x288
[   17.753902] [c0000000fe69f760] [c00000000029142c] .of_platform_device_create_pdata+0x54/0xf8
[   17.804424] [c0000000fe69f800] [c000000000291614] .of_platform_bus_create+0x144/0x1e0
[   17.851301] [c0000000fe69f8f0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[   17.898178] [c0000000fe69f9e0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[   17.945054] [c0000000fe69fad0] [c000000000291860] .of_platform_bus_probe+0xd0/0x140
[   17.990889] [c0000000fe69fb70] [c000000000410f24] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[   18.048705] [c0000000fe69fc40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[   18.091935] [c0000000fe69fd00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[   18.137770] [c0000000fe69fdb0] [c00000000000a47c] .kernel_init+0x1c/0x108
[   18.178396] [c0000000fe69fe30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[   18.224227] Instruction dump:
[   18.241937] 7fa4eb78 7ca507b4 4828aa89 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[   18.288293] 7fa4eb78 7fe5fb78 4828aa69 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[   18.335691] ---[ end trace c6cef7a91fd60969 ]---
[   18.363543] irq: irq-42==>hwirq-0x27 mapping failed: -22
[   18.395081] ------------[ cut here ]------------
[   18.422674] WARNING: at /usr/src/linux-3.8.8/kernel/irq/irqdomain.c:467
[   18.462257] Modules linked in:
[   18.480489] NIP: c0000000000be464 LR: c0000000000be460 CTR: c000000000024448
[   18.522679] REGS: c0000000fe69f0a0 TRAP: 0700   Tainted: G        W     (3.8.8)
[   18.566428] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[   18.613305] SOFTE: 1
[   18.626328] TASK = c0000000fe6a0000[1] 'swapper/0' THREAD: c0000000fe69c000 CPU: 1
GPR00: c0000000000be460 c0000000fe69f320 c0000000006a1e08 000000000000002c 
GPR04: 0000000000000000 0000000094777ce7 0000000000000008 0000000000000000 
GPR08: 0000000094805500 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb280 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000001fe001018 000000000000002b 
GPR24: 000000000000009c 0000000000000027 000000000000002a c0000001fe74f500 
GPR28: c0000001fe001000 000000000000002a c00000000064aea0 0000000000000027 
[   18.992492] NIP [c0000000000be464] .irq_domain_associate_many+0x264/0x290
[   19.033116] LR [c0000000000be460] .irq_domain_associate_many+0x260/0x290
[   19.073218] Call Trace:
[   19.087806] [c0000000fe69f320] [c0000000000be460] .irq_domain_associate_many+0x260/0x290 (unreliable)
[   19.143016] [c0000000fe69f3f0] [c0000000000beee0] .irq_create_mapping+0xc8/0x1d0
[   19.187289] [c0000000fe69f490] [c0000000000bf090] .irq_create_of_mapping+0xa8/0x170
[   19.233124] [c0000000fe69f540] [c000000000290740] .irq_of_parse_and_map+0x40/0x58
[   19.277917] [c0000000fe69f5d0] [c000000000290900] .of_irq_count+0x30/0x58
[   19.318543] [c0000000fe69f660] [c00000000029133c] .of_device_alloc+0x1ec/0x288
[   19.361775] [c0000000fe69f760] [c00000000029142c] .of_platform_device_create_pdata+0x54/0xf8
[   19.412297] [c0000000fe69f800] [c000000000291614] .of_platform_bus_create+0x144/0x1e0
[   19.459174] [c0000000fe69f8f0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[   19.506050] [c0000000fe69f9e0] [c000000000291670] .of_platform_bus_create+0x1a0/0x1e0
[   19.552927] [c0000000fe69fad0] [c000000000291860] .of_platform_bus_probe+0xd0/0x140
[   19.598763] [c0000000fe69fb70] [c000000000410f24] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[   19.656578] [c0000000fe69fc40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[   19.699808] [c0000000fe69fd00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[   19.745643] [c0000000fe69fdb0] [c00000000000a47c] .kernel_init+0x1c/0x108
[   19.786269] [c0000000fe69fe30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[   19.832101] Instruction dump:
[   19.849810] 7fa4eb78 7ca507b4 4828aa89 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[   19.896165] 7fa4eb78 7fe5fb78 4828aa69 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[   19.943564] ---[ end trace c6cef7a91fd6096a ]---
[   19.971465] iommu: missing iommu for <no-node> (node -1)
[   20.002987] iommu: missing iommu for <no-node> (node -1)
[   20.034852] axon_msi: setup MSIC on /axon@10000000000/plb5/msic@4000004400003000
[   20.035048] axon_msi: setup MSIC on /axon@30000000000/plb5/msic@4000004400003000
[   20.036305] bio: create slab <bio-0> at 0
[   20.060218] vgaarb: loaded
[   20.076270] Switching to clocksource timebase
[   20.107987] NET: Registered protocol family 2
[   20.134325] TCP established hash table entries: 65536 (order: 8, 1048576 bytes)
[   20.178934] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   20.220890] TCP: Hash tables configured (established 65536 bind 65536)
[   20.259643] TCP: reno registered
[   20.278864] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[   20.315452] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[   20.354659] PCI: CLS 0 bytes, default 128
[   20.354798] Unpacking initramfs...
[   20.921499] Freeing initrd memory: 9872k freed
[   20.949913] iommu: missing iommu for <no-node> (node -1)
[   20.981470] Setting up PCI bus /axon@10000000000/plb5/plb4/pcix@4000004600000000
[   21.025681] PCI host bridge /axon@10000000000/plb5/plb4/pcix@4000004600000000  ranges:
[   21.072957]   IO 0x0000014608000000..0x000001460800ffff -> 0x0000000000000000
[   21.115663]  MEM 0x0000014780000000..0x00000147bfffffff -> 0x0000000080000000 
[   21.158893]  MEM 0x00000147c0000000..0x00000147ffffffff -> 0x00000000c0000000 Prefetch
[   21.206426] of-pci 14600000000.pcix: PCI host bridge to bus 0000:00
[   21.243792] pci_bus 0000:00: root bus resource [io  0x10000-0x1ffff] (bus address [0x0000-0xffff])
[   21.297435] pci_bus 0000:00: root bus resource [mem 0x14780000000-0x147bfffffff] (bus address [0x80000000-0xbfffffff])
[   21.361502] pci_bus 0000:00: root bus resource [mem 0x147c0000000-0x147ffffffff pref] (bus address [0xc0000000-0xffffffff])
[   21.428171] pci_bus 0000:00: root bus resource [bus 00-ff]
[   21.460982] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
[   21.461086] pci 0000:00:01.0: [14e4:16a8] type 00 class 0x020000
[   21.461191] pci 0000:00:01.0: reg 10: [mem 0x14780000000-0x1478000ffff 64bit]
[   21.461628] pci 0000:00:01.0: PME# supported from D3hot D3cold
[   21.461769] pci 0000:00:01.1: [14e4:16a8] type 00 class 0x020000
[   21.461869] pci 0000:00:01.1: reg 10: [mem 0x14780010000-0x1478001ffff 64bit]
[   21.462318] pci 0000:00:01.1: PME# supported from D3hot D3cold
[   21.462486] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[   21.462702] Setting up PCI bus /axon@10000000000/plb5/pciex@a00000a000000000
[   21.504496] PCI host bridge /axon@10000000000/plb5/pciex@a00000a000000000  ranges:
[   21.549792]   IO 0x000001a100000000..0x000001a10000ffff -> 0x0000000000000000
[   21.592500]  MEM 0x000001c080000000..0x000001c0bfffffff -> 0x0000000080000000 
[   21.635735]  MEM 0x000001c0c0000000..0x000001c0ffffffff -> 0x00000000c0000000 Prefetch
[   21.683213] of-pci D18000002400.pciex: PCI host bridge to bus 0001:00
[   21.721669] pci_bus 0001:00: root bus resource [io  0x21000-0x30fff] (bus address [0x0000-0xffff])
[   21.775319] pci_bus 0001:00: root bus resource [mem 0x1c080000000-0x1c0bfffffff] (bus address [0x80000000-0xbfffffff])
[   21.839381] pci_bus 0001:00: root bus resource [mem 0x1c0c0000000-0x1c0ffffffff pref] (bus address [0xc0000000-0xffffffff])
[   21.906053] pci_bus 0001:00: root bus resource [bus 00-ff]
[   21.938864] pci_bus 0001:00: busn_res: [bus 00-ff] end is updated to ff
[   21.938963] pci 0001:00:00.0: [1014:032c] type 01 class 0x060400
[   21.939058] pci 0001:00:00.0: reg 10: [mem 0x00000000-0x7fffffff 64bit pref]
[   21.939111] pci 0001:00:00.0: reg 38: [mem 0x1c0ffff8000-0x1c0ffffffff pref]
[   21.939178] PCI: Hiding resources on Axon PCIE RC 0001:00:00.0
[   21.939409] pci 0001:00:00.0: supports D1 D2
[   21.939416] pci 0001:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   21.939558] irq: no irq domain found for /axon@10000000000/plb5/pciex-utl@a00000a000004000 !
[   21.989902] pci 0001:00:00.0: PCI bridge to [bus 01]
[   22.019437] pci_bus 0001:00: busn_res: [bus 00-ff] end is updated to 01
[   22.019578] Setting up PCI bus /axon@10000000000/plb5/pciex@a00000a200000000
[   22.061546] PCI host bridge /axon@10000000000/plb5/pciex@a00000a200000000  ranges:
[   22.106843]   IO 0x000001a300000000..0x000001a30000ffff -> 0x0000000000000000
[   22.149553]  MEM 0x000001d080000000..0x000001d0bfffffff -> 0x0000000080000000 
[   22.192785]  MEM 0x000001d0c0000000..0x000001d0ffffffff -> 0x00000000c0000000 Prefetch
[   22.240263] of-pci D18000002800.pciex: PCI host bridge to bus 0002:00
[   22.278727] pci_bus 0002:00: root bus resource [io  0x32000-0x41fff] (bus address [0x0000-0xffff])
[   22.332374] pci_bus 0002:00: root bus resource [mem 0x1d080000000-0x1d0bfffffff] (bus address [0x80000000-0xbfffffff])
[   22.396435] pci_bus 0002:00: root bus resource [mem 0x1d0c0000000-0x1d0ffffffff pref] (bus address [0xc0000000-0xffffffff])
[   22.463103] pci_bus 0002:00: root bus resource [bus 00-ff]
[   22.495914] pci_bus 0002:00: busn_res: [bus 00-ff] end is updated to ff
[   22.496028] pci 0002:00:00.0: [1014:032c] type 01 class 0x060400
[   22.496123] pci 0002:00:00.0: reg 10: [mem 0x00000000-0x7fffffff 64bit pref]
[   22.496176] pci 0002:00:00.0: reg 38: [mem 0x1d0ffff8000-0x1d0ffffffff pref]
[   22.496242] PCI: Hiding resources on Axon PCIE RC 0002:00:00.0
[   22.496472] pci 0002:00:00.0: supports D1 D2
[   22.496479] pci 0002:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   22.496620] irq: no irq domain found for /axon@10000000000/plb5/pciex-utl@a00000a200004000 !
[   22.546946] pci 0002:00:00.0: PCI bridge to [bus 01]
[   22.576489] pci_bus 0002:00: busn_res: [bus 00-ff] end is updated to 01
[   22.576654] Setting up PCI bus /axon@30000000000/plb5/plb4/pcix@4000004600000000
[   22.620684] PCI host bridge /axon@30000000000/plb5/plb4/pcix@4000004600000000  ranges:
[   22.668065]   IO 0x0000034608000000..0x000003460800ffff -> 0x0000000000000000
[   22.710773]  MEM 0x0000034780000000..0x00000347bfffffff -> 0x0000000080000000 
[   22.754007]  MEM 0x00000347c0000000..0x00000347ffffffff -> 0x00000000c0000000 Prefetch
[   22.801491] of-pci 34600000000.pcix: PCI host bridge to bus 0003:00
[   22.838902] pci_bus 0003:00: root bus resource [io  0x43000-0x52fff] (bus address [0x0000-0xffff])
[   22.892550] pci_bus 0003:00: root bus resource [mem 0x34780000000-0x347bfffffff] (bus address [0x80000000-0xbfffffff])
[   22.956612] pci_bus 0003:00: root bus resource [mem 0x347c0000000-0x347ffffffff pref] (bus address [0xc0000000-0xffffffff])
[   23.023282] pci_bus 0003:00: root bus resource [bus 00-ff]
[   23.056093] pci_bus 0003:00: busn_res: [bus 00-ff] end is updated to ff
[   23.056156] pci 0003:00:01.0: [1033:0035] type 00 class 0x0c0310
[   23.056238] pci 0003:00:01.0: reg 10: [mem 0x34780000000-0x34780000fff]
[   23.056604] pci 0003:00:01.0: supports D1 D2
[   23.056611] pci 0003:00:01.0: PME# supported from D0 D1 D2 D3hot
[   23.056703] pci 0003:00:01.1: [1033:0035] type 00 class 0x0c0310
[   23.056785] pci 0003:00:01.1: reg 10: [mem 0x34780001000-0x34780001fff]
[   23.057148] pci 0003:00:01.1: supports D1 D2
[   23.057155] pci 0003:00:01.1: PME# supported from D0 D1 D2 D3hot
[   23.057247] pci 0003:00:01.2: [1033:00e0] type 00 class 0x0c0320
[   23.057328] pci 0003:00:01.2: reg 10: [mem 0x34780002000-0x347800020ff]
[   23.057693] pci 0003:00:01.2: supports D1 D2
[   23.057699] pci 0003:00:01.2: PME# supported from D0 D1 D2 D3hot
[   23.057861] pci_bus 0003:00: busn_res: [bus 00-ff] end is updated to 00
[   23.172183] pci 0003:00:01.2: enabling device (0140 -> 0142)
[   23.205788] Setting up PCI bus /axon@30000000000/plb5/pciex@a00000a000000000
[   23.247843] PCI host bridge /axon@30000000000/plb5/pciex@a00000a000000000  ranges:
[   23.293139]   IO 0x000003a100000000..0x000003a10000ffff -> 0x0000000000000000
[   23.335851]  MEM 0x000003c080000000..0x000003c0bfffffff -> 0x0000000080000000 
[   23.379077]  MEM 0x000003c0c0000000..0x000003c0ffffffff -> 0x00000000c0000000 Prefetch
[   23.426565] of-pci D38000002400.pciex: PCI host bridge to bus 0004:00
[   23.465025] pci_bus 0004:00: root bus resource [io  0x54000-0x63fff] (bus address [0x0000-0xffff])
[   23.518665] pci_bus 0004:00: root bus resource [mem 0x3c080000000-0x3c0bfffffff] (bus address [0x80000000-0xbfffffff])
[   23.582730] pci_bus 0004:00: root bus resource [mem 0x3c0c0000000-0x3c0ffffffff pref] (bus address [0xc0000000-0xffffffff])
[   23.649399] pci_bus 0004:00: root bus resource [bus 00-ff]
[   23.682211] pci_bus 0004:00: busn_res: [bus 00-ff] end is updated to ff
[   23.682316] pci 0004:00:00.0: [1014:032c] type 01 class 0x060400
[   23.682416] pci 0004:00:00.0: reg 10: [mem 0x00000000-0x7fffffff 64bit pref]
[   23.682473] pci 0004:00:00.0: reg 38: [mem 0x3c0ffff8000-0x3c0ffffffff pref]
[   23.682544] PCI: Hiding resources on Axon PCIE RC 0004:00:00.0
[   23.682792] pci 0004:00:00.0: supports D1 D2
[   23.682798] pci 0004:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   23.682951] irq: no irq domain found for /axon@30000000000/plb5/pciex-utl@a00000a000004000 !
[   23.733314] pci 0004:00:00.0: PCI bridge to [bus 01]
[   23.762844] pci_bus 0004:00: busn_res: [bus 00-ff] end is updated to 01
[   23.762986] Setting up PCI bus /axon@30000000000/plb5/pciex@a00000a200000000
[   23.804955] PCI host bridge /axon@30000000000/plb5/pciex@a00000a200000000  ranges:
[   23.850244]   IO 0x000003a300000000..0x000003a30000ffff -> 0x0000000000000000
[   23.892953]  MEM 0x000003d080000000..0x000003d0bfffffff -> 0x0000000080000000 
[   23.936186]  MEM 0x000003d0c0000000..0x000003d0ffffffff -> 0x00000000c0000000 Prefetch
[   23.983665] of-pci D38000002800.pciex: PCI host bridge to bus 0005:00
[   24.022126] pci_bus 0005:00: root bus resource [io  0x65000-0x74fff] (bus address [0x0000-0xffff])
[   24.075773] pci_bus 0005:00: root bus resource [mem 0x3d080000000-0x3d0bfffffff] (bus address [0x80000000-0xbfffffff])
[   24.139834] pci_bus 0005:00: root bus resource [mem 0x3d0c0000000-0x3d0ffffffff pref] (bus address [0xc0000000-0xffffffff])
[   24.206504] pci_bus 0005:00: root bus resource [bus 00-ff]
[   24.239315] pci_bus 0005:00: busn_res: [bus 00-ff] end is updated to ff
[   24.239417] pci 0005:00:00.0: [1014:032c] type 01 class 0x060400
[   24.239518] pci 0005:00:00.0: reg 10: [mem 0x00000000-0x7fffffff 64bit pref]
[   24.239574] pci 0005:00:00.0: reg 38: [mem 0x3d0ffff8000-0x3d0ffffffff pref]
[   24.239644] PCI: Hiding resources on Axon PCIE RC 0005:00:00.0
[   24.239891] pci 0005:00:00.0: supports D1 D2
[   24.239898] pci 0005:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   24.240045] irq: no irq domain found for /axon@30000000000/plb5/pciex-utl@a00000a200004000 !
[   24.290582] pci 0005:01:00.0: [15b3:634a] type 00 class 0x0c0600
[   24.290762] pci 0005:01:00.0: reg 10: [mem 0x3d080000000-0x3d0800fffff 64bit]
[   24.290906] pci 0005:01:00.0: reg 18: [mem 0x3d0c0000000-0x3d0c1ffffff 64bit pref]
[   24.291905] pci 0005:00:00.0: PCI bridge to [bus 01]
[   24.321239] pci 0005:00:00.0:   bridge window [mem 0x3d080000000-0x3d0800fffff]
[   24.321275] pci 0005:00:00.0:   bridge window [mem 0x3d0c0000000-0x3d0c1ffffff 64bit pref]
[   24.321364] pci_bus 0005:00: busn_res: [bus 00-ff] end is updated to 01
[   24.321705] iommu: missing iommu for <no-node> (node -1)
[   24.353225] pmi: found pmi device at addr d00008008013c000.
[   24.416973] pmi: expected ACK, but got 1
[   24.479742] iommu: missing iommu for <no-node> (node -1)
[   24.522461] msgmni has been set to 15886
[   24.555902] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[   24.599780] io scheduler noop registered
[   24.623209] io scheduler deadline registered
[   24.648837] io scheduler cfq registered (default)
[   24.719867] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[   24.757572] iommu: missing iommu for <no-node> (node -1)
[   24.810337] serial8250.0: ttyS0 at MMIO 0x14540000200 (irq = 16) is a U6_16550A
[   24.853693] console [ttyS0] enabled, bootconsole disabled
[   24.938942] serial8250.0: ttyS1 at MMIO 0x14540000300 (irq = 17) is a U6_16550A
[   25.003414] serial8250.0: ttyS2 at MMIO 0x34540000200 (irq = 18) is a U6_16550A
[   25.067917] serial8250.0: ttyS3 at MMIO 0x34540000300 (irq = 19) is a U6_16550A
[   25.112312] mousedev: PS/2 mouse device common for all mice
[   25.145751] cpuidle: using governor ladder
[   25.170328] cpuidle: using governor menu
[   25.194061] TCP: cubic registered
[   25.213949] Key type dns_resolver registered
[   25.241108] /usr/src/linux-3.8.8/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   25.289768] ### of_selftest(): No testcase data in device tree; not running tests
[   25.336816] Freeing unused kernel memory: 2096k freed
[   25.546401] dracut: dracut-027-ebfd8cd
[   25.720086] RPC: Registered named UNIX socket transport module.
[   25.755748] RPC: Registered udp transport module.
[   25.783979] RPC: Registered tcp transport module.
[   25.812179] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   25.883942] NET: Registered protocol family 1
[   25.936835] NET: Registered protocol family 10
[   26.039028] systemd-udevd[143]: starting version 200
[   26.251278] pps_core: LinuxPPS API ver. 1 registered
[   26.281147] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   26.340326] PTP clock support registered
[   26.382619] tg3.c:v3.128 (December 03, 2012)
[   26.408395] tg3 0000:00:01.0: enabling device (0140 -> 0142)
[   26.411554] usbcore: registered new interface driver usbfs
[   26.411637] usbcore: registered new interface driver hub
[   26.509332] usbcore: registered new device driver usb
[   26.528332] tg3 0000:00:01.0 eth0: Tigon3 [partno(none) rev 2100] (PCIX:100MHz:64-bit) MAC address 00:1a:64:b8:08:18
[   26.528345] tg3 0000:00:01.0 eth0: attached PHY is serdes (1000Base-SX Ethernet) (WireSpeed[0], EEE[0])
[   26.528355] tg3 0000:00:01.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[0]
[   26.528363] tg3 0000:00:01.0 eth0: dma_rwctrl[769f4000] dma_mask[64-bit]
[   26.746681] tg3 0000:00:01.1: enabling device (0140 -> 0142)
[   26.753700] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   26.758602] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   26.759616] ohci_hcd 0003:00:01.0: OHCI Host Controller
[   26.759679] ohci_hcd 0003:00:01.0: new USB bus registered, assigned bus number 1
[   26.759981] ohci_hcd 0003:00:01.0: irq 21, io mem 0x34780000000
[   26.760557] ehci-pci: EHCI PCI platform driver
[   26.997113] hub 1-0:1.0: USB hub found
[   27.017083] tg3 0000:00:01.1 eth1: Tigon3 [partno(none) rev 2100] (PCIX:100MHz:64-bit) MAC address 00:1a:64:b8:08:19
[   27.017091] tg3 0000:00:01.1 eth1: attached PHY is serdes (1000Base-SX Ethernet) (WireSpeed[0], EEE[0])
[   27.017099] tg3 0000:00:01.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   27.017108] tg3 0000:00:01.1 eth1: dma_rwctrl[769f4000] dma_mask[64-bit]
[   27.226195] hub 1-0:1.0: 3 ports detected
[   27.251253] ohci_hcd 0003:00:01.1: OHCI Host Controller
[   27.282684] ohci_hcd 0003:00:01.1: new USB bus registered, assigned bus number 2
[   27.327162] ohci_hcd 0003:00:01.1: irq 21, io mem 0x34780001000
[   27.451829] hub 2-0:1.0: USB hub found
[   27.474379] hub 2-0:1.0: 2 ports detected
[   27.499078] ehci-pci 0003:00:01.2: EHCI Host Controller
[   27.530483] ehci-pci 0003:00:01.2: new USB bus registered, assigned bus number 3
[   27.575136] ehci-pci 0003:00:01.2: irq 21, io mem 0x34780002000
[   27.622138] ehci-pci 0003:00:01.2: USB 2.0 started, EHCI 1.00
[   27.657240] hub 3-0:1.0: USB hub found
[   27.679763] hub 3-0:1.0: 5 ports detected
[   28.482160] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   28.532609] NET: Registered protocol family 17
[   29.472321] tg3 0000:00:01.0 eth0: Link is up at 1000 Mbps, full duplex
[   29.512047] tg3 0000:00:01.0 eth0: Flow control is on for TX and on for RX
[   29.553507] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   36.700766] FS-Cache: Loaded
[   36.733457] FS-Cache: Netfs 'nfs' registered for caching
[   36.784559] NFS: Registering the id_resolver key type
[   36.814944] Key type id_resolver registered
[   36.840047] Key type id_legacy registered
[   37.769976] dracut: Mounted root filesystem 192.168.100.1:/export/gentoo/root-ppc64
[   38.098269] dracut: Switching root
[   39.589453] systemd-udevd[371]: starting version 200
[   40.073703] systemd-udevd[383]: renamed network interface eth1 to enp0s1f1
[   40.131302] rtc-generic rtc-generic: rtc core: registered rtc-generic as rtc0
[   40.151676] mlx4_core: Mellanox ConnectX core driver v1.1 (Dec, 2011)
[   40.151714] mlx4_core: Initializing 0005:01:00.0
[   40.151808] mlx4_core 0005:01:00.0: enabling device (0140 -> 0142)
[   43.593495] mlx4_core 0005:01:00.0: command 0xc failed: fw status = 0x40
[   43.593865] mlx4_core 0005:01:00.0: command 0xc failed: fw status = 0x40
[   44.761077] <mlx4_ib> mlx4_ib_add: mlx4_ib: Mellanox ConnectX InfiniBand driver v1.0 (April 4, 2008)
[   52.369757] mlx4_core 0005:01:00.0: command 0x5a failed: fw status = 0x2

--nextPart1616500.8WGK4DeFhD
Content-Disposition: attachment; filename="lspci.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="UTF-8"; name="lspci.log"

0000:00:01.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704S Gigabit Ethernet (rev 10)
	Subsystem: IBM Device 02a8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (16000ns min)
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at 14780000000 (64-bit, non-prefetchable) [size=64K]
	Expansion ROM at <ignored> [disabled]
	Capabilities: [40] PCI-X non-bridge device
		Command: DPERE- ERO- RBC=2048 OST=1
		Status: Dev=ff:01.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=1 DMCRS=16 RSCEM- 266MHz- 533MHz-
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable+ DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
		Product Name: Broadcom NetXtreme Gigabit Ethernet Controller
		Read-only fields:
		Unknown small resource type 0a, will not decode more.
	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 2213062122c02600  Data: 3558
	Kernel driver in use: tg3

0000:00:01.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704S Gigabit Ethernet (rev 10)
	Subsystem: IBM Device 02a8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (16000ns min)
	Interrupt: pin B routed to IRQ 69
	Region 0: Memory at 14780010000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] PCI-X non-bridge device
		Command: DPERE- ERO+ RBC=512 OST=1
		Status: Dev=ff:01.1 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=1 DMCRS=16 RSCEM- 266MHz- 533MHz-
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
		Product Name: Broadcom NetXtreme Gigabit Ethernet Controller
		Read-only fields:
		Unknown small resource type 0a, will not decode more.
	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 2018267002902d24  Data: 8024
	Kernel driver in use: tg3

0001:00:00.0 PCI bridge: IBM Device 032c (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at <unassigned> (64-bit, prefetchable)
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00001000-00000fff
	Memory behind bridge: 80000000-7fffffff
	Prefetchable memory behind bridge: 00000000c0000000-00000000bfffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	Expansion ROM at <ignored>
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 8000004400003000  Data: 009f
	Capabilities: [58] Express (v1) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Latency L0 <256ns, L1 <2us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn+
	Capabilities: [138 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending+ InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=0 ArbSelect=Fixed TC/VC=00
			Status:	NegoPending+ InProgress-
	Capabilities: [1f8 v1] Vendor Specific Information: ID=0000 Rev=0 Len=240 <?>
	Kernel driver in use: pcieport

0002:00:00.0 PCI bridge: IBM Device 032c (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at <unassigned> (64-bit, prefetchable)
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00001000-00000fff
	Memory behind bridge: 80000000-7fffffff
	Prefetchable memory behind bridge: 00000000c0000000-00000000bfffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	Expansion ROM at <ignored>
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 8000004400003000  Data: 00a0
	Capabilities: [58] Express (v1) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Latency L0 <256ns, L1 <2us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn+
	Capabilities: [138 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending+ InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=0 ArbSelect=Fixed TC/VC=00
			Status:	NegoPending+ InProgress-
	Capabilities: [1f8 v1] Vendor Specific Information: ID=0000 Rev=0 Len=240 <?>
	Kernel driver in use: pcieport

0003:00:01.0 USB controller: NEC Corporation OHCI USB Controller (rev 43) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 8 (250ns min, 10500ns max)
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at 34780000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ohci_hcd

0003:00:01.1 USB controller: NEC Corporation OHCI USB Controller (rev 43) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 8 (250ns min, 10500ns max)
	Interrupt: pin B routed to IRQ 21
	Region 0: Memory at 34780001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ohci_hcd

0003:00:01.2 USB controller: NEC Corporation uPD72010x USB 2.0 Controller (rev 04) (prog-if 20 [EHCI])
	Subsystem: NEC Corporation uPD72010x USB 2.0 Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 68 (4000ns min, 8500ns max)
	Interrupt: pin C routed to IRQ 21
	Region 0: Memory at 34780002000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ehci-pci

0004:00:00.0 PCI bridge: IBM Device 032c (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at <unassigned> (64-bit, prefetchable)
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00001000-00000fff
	Memory behind bridge: 80000000-7fffffff
	Prefetchable memory behind bridge: 00000000c0000000-00000000bfffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	Expansion ROM at <ignored>
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 8000004400003000  Data: 00a1
	Capabilities: [58] Express (v1) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Latency L0 <256ns, L1 <2us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn+
	Capabilities: [138 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending+ InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=0 ArbSelect=Fixed TC/VC=00
			Status:	NegoPending+ InProgress-
	Capabilities: [1f8 v1] Vendor Specific Information: ID=0000 Rev=0 Len=240 <?>
	Kernel driver in use: pcieport

0005:00:00.0 PCI bridge: IBM Device 032c (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at <unassigned> (64-bit, prefetchable)
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00001000-00000fff
	Memory behind bridge: 80000000-800fffff
	Prefetchable memory behind bridge: 00000000c0000000-00000000c1ffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	Expansion ROM at <ignored>
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 8000004400003000  Data: 00a2
	Capabilities: [58] Express (v1) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Latency L0 <256ns, L1 <2us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn+
	Capabilities: [138 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=0 ArbSelect=Fixed TC/VC=00
			Status:	NegoPending+ InProgress-
	Capabilities: [1f8 v1] Vendor Specific Information: ID=0000 Rev=0 Len=240 <?>
	Kernel driver in use: pcieport

0005:01:00.0 InfiniBand: Mellanox Technologies MT25418 [ConnectX VPI PCIe 2.0 2.5GT/s - IB DDR / 10GigE] (rev a0)
	Subsystem: Mellanox Technologies MT25418 [ConnectX VPI PCIe 2.0 2.5GT/s - IB DDR / 10GigE]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 110
	Region 0: Memory at 3d080000000 (64-bit, non-prefetchable) [size=1M]
	Region 2: Memory at 3d0c0000000 (64-bit, prefetchable) [size=32M]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Vital Product Data
		Product Name: IB Mezz
		Read-only fields:
			[PN] Part number: 43W4441
			[EC] Engineering changes: A3
			[SN] Serial number: YK10AG012821
			[V0] Vendor specific: IBM InfiniBand DDR HCA
			[RV] Reserved: checksum good, 0 byte(s) reserved
		Read/write fields:
			[V1] Vendor specific: N/A   
			[YA] Asset tag: N/A                             
			[RW] Read-write area: 133 byte(s) free
		End
	Capabilities: [9c] MSI-X: Enable+ Count=256 Masked-
		Vector table: BAR=0 offset=0007c000
		PBA: BAR=0 offset=0007d000
	Capabilities: [60] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #8, Speed 2.5GT/s, Width x8, ASPM L0s, Latency L0 unlimited, L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 1
		ARICtl:	MFVC- ACS-, Function Group: 0
	Kernel driver in use: mlx4_core


--nextPart1616500.8WGK4DeFhD--

--nextPart11397420.PkTpOoy5kv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlF1aOEACgkQjqfyF1DtJW6bbACeMF5KVT4g4+6CyUZPKKsREY4n
zY8An0At5gDAeoP3g5K4qCL5MyHTTXcB
=9qLN
-----END PGP SIGNATURE-----

--nextPart11397420.PkTpOoy5kv--
