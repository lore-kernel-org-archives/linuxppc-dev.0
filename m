Return-Path: <mroos@linux.ee>
Received: from smtp2.it.da.ut.ee (smtp2.it.da.ut.ee
 [IPv6:2001:bb8:2002:500:20f:1fff:fe04:1bbb])
 by lists.ozlabs.org (Postfix) with ESMTP id 3ydg1t0ZwkzDrKc
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Nov 2017 01:08:14 +1100 (AEDT)
Date: Fri, 17 Nov 2017 16:08:09 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: LEROY Christophe <christophe.leroy@c-s.fr>
cc: Michael Ellerman <mpe@ellerman.id.au>,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: STRICT_KERNEL_RWX on PPC32 is broken on PowerMac G4
In-Reply-To: <20171117090609.Horde.DBRyYUc0XYQixQKoV-_Luw1@messagerie.c-s.fr>
Message-ID: <alpine.LRH.2.21.1711171606540.28670@math.ut.ee>
References: <20171116202839.Horde.gP0ycbGMQpT2Ragrd4TEog1@messagerie.c-s.fr>
 <alpine.LRH.2.21.1711162146260.3639@math.ut.ee>
 <20171117090609.Horde.DBRyYUc0XYQixQKoV-_Luw1@messagerie.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Meelis Roos <mroos@linux.ee> a =C3=A9crit=C2=A0:
>=20
> > > > For me, 4.13 worked and 4.14 hangs early during boot. Bisecting l=
ed to
> > > > the following commit. I had STRICT_KERNEL_RWX enabled when I met =
the
> > > > option. When I disabled STRICT_KERNEL_RWX, the same kernel booted=
 fine.
> > >=20
> > > Can you please check that 4.13 boots properly with 'nobats' kernel
> > > parametre ?
> >=20
> > Yes, 4.13.0 with nobats works.
>=20
> How early does it hang ? Any oops or trace ?

Very early - instead oif kernel emssages, I see some repeated gibberish=20
of some characteers, and the background turns white.
I am booting from yaboot, background is normally black.

>=20
> Christophe
>=20
> >=20
> > >=20
> > > Christophe
> > >=20
> > > >=20
> > > >=20
> > > > 95902e6c8864d39b09134dcaa3c99d8161d1deea is the first bad commit
> > > > commit 95902e6c8864d39b09134dcaa3c99d8161d1deea
> > > > Author: Christophe Leroy <christophe.leroy@c-s.fr>
> > > > Date:   Wed Aug 2 15:51:05 2017 +0200
> > > >=20
> > > >    powerpc/mm: Implement STRICT_KERNEL_RWX on PPC32
> > > >=20
> > > >    This patch implements STRICT_KERNEL_RWX on PPC32.
> > > >=20
> > > >    As for CONFIG_DEBUG_PAGEALLOC, it deactivates BAT and LTLB map=
pings
> > > >    in order to allow page protection setup at the level of each p=
age.
> > > >=20
> > > >    As BAT/LTLB mappings are deactivated, there might be a perform=
ance
> > > >    impact.
> > > >=20
> > > >    Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > > >    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > > >=20
> > > > :040000 040000 1eac3de57642856e31a914da2e1fe5368095f04b
> > > > ee3634b9ae309852feebc69b8a6bd473944e212c M      arch
> > > >=20
> > > >=20
> > > > Config:
> > > >=20
> > > > #
> > > > # Automatically generated file; DO NOT EDIT.
> > > > # Linux/powerpc 4.13.0-rc2 Kernel Configuration
> > > > #
> > > > # CONFIG_PPC64 is not set
> > > >=20
> > > > #
> > > > # Processor support
> > > > #
> > > > CONFIG_PPC_BOOK3S_32=3Dy
> > > > # CONFIG_PPC_85xx is not set
> > > > # CONFIG_PPC_8xx is not set
> > > > # CONFIG_40x is not set
> > > > # CONFIG_44x is not set
> > > > # CONFIG_E200 is not set
> > > > CONFIG_PPC_BOOK3S=3Dy
> > > > CONFIG_6xx=3Dy
> > > > CONFIG_PPC_FPU=3Dy
> > > > CONFIG_ALTIVEC=3Dy
> > > > CONFIG_PPC_STD_MMU=3Dy
> > > > CONFIG_PPC_STD_MMU_32=3Dy
> > > > # CONFIG_PPC_MM_SLICES is not set
> > > > CONFIG_PPC_HAVE_PMU_SUPPORT=3Dy
> > > > # CONFIG_FORCE_SMP is not set
> > > > # CONFIG_SMP is not set
> > > > # CONFIG_PPC_DOORBELL is not set
> > > > CONFIG_VDSO32=3Dy
> > > > CONFIG_CPU_BIG_ENDIAN=3Dy
> > > > CONFIG_PPC32=3Dy
> > > > CONFIG_32BIT=3Dy
> > > > # CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
> > > > # CONFIG_ARCH_DMA_ADDR_T_64BIT is not set
> > > > CONFIG_MMU=3Dy
> > > > CONFIG_ARCH_MMAP_RND_BITS_MAX=3D17
> > > > CONFIG_ARCH_MMAP_RND_BITS_MIN=3D11
> > > > CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=3D17
> > > > CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=3D11
> > > > # CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
> > > > # CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK is not set
> > > > CONFIG_NR_IRQS=3D512
> > > > CONFIG_STACKTRACE_SUPPORT=3Dy
> > > > CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
> > > > CONFIG_LOCKDEP_SUPPORT=3Dy
> > > > CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
> > > > CONFIG_GENERIC_HWEIGHT=3Dy
> > > > CONFIG_ARCH_HAS_DMA_SET_COHERENT_MASK=3Dy
> > > > CONFIG_PPC=3Dy
> > > > # CONFIG_GENERIC_CSUM is not set
> > > > CONFIG_EARLY_PRINTK=3Dy
> > > > CONFIG_PANIC_TIMEOUT=3D180
> > > > CONFIG_GENERIC_NVRAM=3Dy
> > > > CONFIG_SCHED_OMIT_FRAME_POINTER=3Dy
> > > > CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
> > > > # CONFIG_PPC_UDBG_16550 is not set
> > > > # CONFIG_GENERIC_TBSYNC is not set
> > > > CONFIG_AUDIT_ARCH=3Dy
> > > > CONFIG_GENERIC_BUG=3Dy
> > > > # CONFIG_EPAPR_BOOT is not set
> > > > # CONFIG_DEFAULT_UIMAGE is not set
> > > > CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
> > > > CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
> > > > # CONFIG_PPC_DCR_NATIVE is not set
> > > > # CONFIG_PPC_DCR_MMIO is not set
> > > > CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
> > > > CONFIG_ARCH_SUPPORTS_UPROBES=3Dy
> > > > CONFIG_PGTABLE_LEVELS=3D2
> > > > CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
> > > > CONFIG_IRQ_WORK=3Dy
> > > > CONFIG_BUILDTIME_EXTABLE_SORT=3Dy
> > > >=20
> > > > #
> > > > # General setup
> > > > #
> > > > CONFIG_BROKEN_ON_SMP=3Dy
> > > > CONFIG_INIT_ENV_ARG_LIMIT=3D32
> > > > CONFIG_CROSS_COMPILE=3D""
> > > > # CONFIG_COMPILE_TEST is not set
> > > > CONFIG_LOCALVERSION=3D""
> > > > CONFIG_LOCALVERSION_AUTO=3Dy
> > > > CONFIG_HAVE_KERNEL_GZIP=3Dy
> > > > CONFIG_KERNEL_GZIP=3Dy
> > > > CONFIG_DEFAULT_HOSTNAME=3D"pohl"
> > > > CONFIG_SWAP=3Dy
> > > > CONFIG_SYSVIPC=3Dy
> > > > CONFIG_SYSVIPC_SYSCTL=3Dy
> > > > CONFIG_POSIX_MQUEUE=3Dy
> > > > CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
> > > > CONFIG_CROSS_MEMORY_ATTACH=3Dy
> > > > CONFIG_FHANDLE=3Dy
> > > > # CONFIG_USELIB is not set
> > > > # CONFIG_AUDIT is not set
> > > > CONFIG_HAVE_ARCH_AUDITSYSCALL=3Dy
> > > >=20
> > > > #
> > > > # IRQ subsystem
> > > > #
> > > > CONFIG_GENERIC_IRQ_SHOW=3Dy
> > > > CONFIG_GENERIC_IRQ_SHOW_LEVEL=3Dy
> > > > CONFIG_IRQ_DOMAIN=3Dy
> > > > # CONFIG_IRQ_DOMAIN_DEBUG is not set
> > > > CONFIG_IRQ_FORCED_THREADING=3Dy
> > > > CONFIG_SPARSE_IRQ=3Dy
> > > > # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> > > > CONFIG_GENERIC_TIME_VSYSCALL=3Dy
> > > > CONFIG_GENERIC_CLOCKEVENTS=3Dy
> > > > CONFIG_GENERIC_CMOS_UPDATE=3Dy
> > > >=20
> > > > #
> > > > # Timers subsystem
> > > > #
> > > > CONFIG_TICK_ONESHOT=3Dy
> > > > CONFIG_NO_HZ_COMMON=3Dy
> > > > # CONFIG_HZ_PERIODIC is not set
> > > > CONFIG_NO_HZ_IDLE=3Dy
> > > > CONFIG_NO_HZ=3Dy
> > > > CONFIG_HIGH_RES_TIMERS=3Dy
> > > >=20
> > > > #
> > > > # CPU/Task time and stats accounting
> > > > #
> > > > CONFIG_TICK_CPU_ACCOUNTING=3Dy
> > > > # CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set
> > > > # CONFIG_IRQ_TIME_ACCOUNTING is not set
> > > > # CONFIG_BSD_PROCESS_ACCT is not set
> > > > # CONFIG_TASKSTATS is not set
> > > >=20
> > > > #
> > > > # RCU Subsystem
> > > > #
> > > > CONFIG_TINY_RCU=3Dy
> > > > # CONFIG_RCU_EXPERT is not set
> > > > CONFIG_SRCU=3Dy
> > > > CONFIG_TINY_SRCU=3Dy
> > > > # CONFIG_TASKS_RCU is not set
> > > > # CONFIG_RCU_STALL_COMMON is not set
> > > > # CONFIG_RCU_NEED_SEGCBLIST is not set
> > > > # CONFIG_BUILD_BIN2C is not set
> > > > # CONFIG_IKCONFIG is not set
> > > > CONFIG_LOG_BUF_SHIFT=3D17
> > > > CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=3D13
> > > > CONFIG_CGROUPS=3Dy
> > > > # CONFIG_MEMCG is not set
> > > > # CONFIG_BLK_CGROUP is not set
> > > > # CONFIG_CGROUP_SCHED is not set
> > > > # CONFIG_CGROUP_PIDS is not set
> > > > # CONFIG_CGROUP_RDMA is not set
> > > > # CONFIG_CGROUP_FREEZER is not set
> > > > # CONFIG_CGROUP_DEVICE is not set
> > > > # CONFIG_CGROUP_CPUACCT is not set
> > > > # CONFIG_CGROUP_BPF is not set
> > > > # CONFIG_CGROUP_DEBUG is not set
> > > > # CONFIG_SOCK_CGROUP_DATA is not set
> > > > # CONFIG_CHECKPOINT_RESTORE is not set
> > > > CONFIG_NAMESPACES=3Dy
> > > > # CONFIG_UTS_NS is not set
> > > > # CONFIG_IPC_NS is not set
> > > > # CONFIG_USER_NS is not set
> > > > # CONFIG_PID_NS is not set
> > > > # CONFIG_NET_NS is not set
> > > > # CONFIG_SCHED_AUTOGROUP is not set
> > > > # CONFIG_SYSFS_DEPRECATED is not set
> > > > CONFIG_RELAY=3Dy
> > > > # CONFIG_BLK_DEV_INITRD is not set
> > > > CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy
> > > > # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> > > > CONFIG_SYSCTL=3Dy
> > > > CONFIG_ANON_INODES=3Dy
> > > > CONFIG_SYSCTL_EXCEPTION_TRACE=3Dy
> > > > CONFIG_BPF=3Dy
> > > > # CONFIG_EXPERT is not set
> > > > CONFIG_MULTIUSER=3Dy
> > > > CONFIG_SGETMASK_SYSCALL=3Dy
> > > > CONFIG_SYSFS_SYSCALL=3Dy
> > > > # CONFIG_SYSCTL_SYSCALL is not set
> > > > CONFIG_POSIX_TIMERS=3Dy
> > > > CONFIG_KALLSYMS=3Dy
> > > > # CONFIG_KALLSYMS_ALL is not set
> > > > # CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
> > > > CONFIG_KALLSYMS_BASE_RELATIVE=3Dy
> > > > CONFIG_PRINTK=3Dy
> > > > CONFIG_BUG=3Dy
> > > > CONFIG_ELF_CORE=3Dy
> > > > CONFIG_BASE_FULL=3Dy
> > > > CONFIG_FUTEX=3Dy
> > > > CONFIG_EPOLL=3Dy
> > > > CONFIG_SIGNALFD=3Dy
> > > > CONFIG_TIMERFD=3Dy
> > > > CONFIG_EVENTFD=3Dy
> > > > CONFIG_BPF_SYSCALL=3Dy
> > > > CONFIG_SHMEM=3Dy
> > > > CONFIG_AIO=3Dy
> > > > CONFIG_ADVISE_SYSCALLS=3Dy
> > > > CONFIG_USERFAULTFD=3Dy
> > > > CONFIG_PCI_QUIRKS=3Dy
> > > > CONFIG_MEMBARRIER=3Dy
> > > > # CONFIG_EMBEDDED is not set
> > > > CONFIG_HAVE_PERF_EVENTS=3Dy
> > > > # CONFIG_PC104 is not set
> > > >=20
> > > > #
> > > > # Kernel Performance Events And Counters
> > > > #
> > > > # CONFIG_PERF_EVENTS is not set
> > > > CONFIG_VM_EVENT_COUNTERS=3Dy
> > > > CONFIG_SLUB_DEBUG=3Dy
> > > > # CONFIG_COMPAT_BRK is not set
> > > > # CONFIG_SLAB is not set
> > > > CONFIG_SLUB=3Dy
> > > > CONFIG_SLAB_MERGE_DEFAULT=3Dy
> > > > # CONFIG_SLAB_FREELIST_RANDOM is not set
> > > > # CONFIG_SYSTEM_DATA_VERIFICATION is not set
> > > > # CONFIG_PROFILING is not set
> > > > CONFIG_HAVE_OPROFILE=3Dy
> > > > # CONFIG_KPROBES is not set
> > > > CONFIG_JUMP_LABEL=3Dy
> > > > # CONFIG_STATIC_KEYS_SELFTEST is not set
> > > > # CONFIG_UPROBES is not set
> > > > # CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
> > > > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
> > > > CONFIG_ARCH_USE_BUILTIN_BSWAP=3Dy
> > > > CONFIG_HAVE_IOREMAP_PROT=3Dy
> > > > CONFIG_HAVE_KPROBES=3Dy
> > > > CONFIG_HAVE_KRETPROBES=3Dy
> > > > CONFIG_HAVE_KPROBES_ON_FTRACE=3Dy
> > > > CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
> > > > CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
> > > > CONFIG_ARCH_HAS_FORTIFY_SOURCE=3Dy
> > > > CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
> > > > CONFIG_HAVE_DMA_API_DEBUG=3Dy
> > > > CONFIG_HAVE_PERF_REGS=3Dy
> > > > CONFIG_HAVE_PERF_USER_STACK_DUMP=3Dy
> > > > CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
> > > > CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy
> > > > CONFIG_ARCH_WEAK_RELEASE_ACQUIRE=3Dy
> > > > CONFIG_ARCH_WANT_IPC_PARSE_VERSION=3Dy
> > > > CONFIG_HAVE_ARCH_SECCOMP_FILTER=3Dy
> > > > CONFIG_HAVE_GCC_PLUGINS=3Dy
> > > > # CONFIG_GCC_PLUGINS is not set
> > > > # CONFIG_CC_STACKPROTECTOR is not set
> > > > CONFIG_THIN_ARCHIVES=3Dy
> > > > CONFIG_HAVE_VIRT_CPU_ACCOUNTING=3Dy
> > > > CONFIG_HAVE_IRQ_TIME_ACCOUNTING=3Dy
> > > > CONFIG_HAVE_MOD_ARCH_SPECIFIC=3Dy
> > > > CONFIG_MODULES_USE_ELF_RELA=3Dy
> > > > CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=3Dy
> > > > CONFIG_ARCH_HAS_ELF_RANDOMIZE=3Dy
> > > > CONFIG_HAVE_ARCH_MMAP_RND_BITS=3Dy
> > > > CONFIG_ARCH_MMAP_RND_BITS=3D11
> > > > # CONFIG_HAVE_ARCH_HASH is not set
> > > > # CONFIG_ISA_BUS_API is not set
> > > > CONFIG_CLONE_BACKWARDS=3Dy
> > > > CONFIG_OLD_SIGSUSPEND=3Dy
> > > > CONFIG_OLD_SIGACTION=3Dy
> > > > # CONFIG_CPU_NO_EFFICIENT_FFS is not set
> > > > # CONFIG_HAVE_ARCH_VMAP_STACK is not set
> > > > CONFIG_ARCH_OPTIONAL_KERNEL_RWX=3Dy
> > > > # CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
> > > > CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=3Dy
> > > > CONFIG_STRICT_KERNEL_RWX=3Dy
> > > > # CONFIG_ARCH_HAS_STRICT_MODULE_RWX is not set
> > > > # CONFIG_REFCOUNT_FULL is not set
> > > >=20
> > > > #
> > > > # GCOV-based kernel profiling
> > > > #
> > > > # CONFIG_GCOV_KERNEL is not set
> > > > CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=3Dy
> > > > # CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
> > > > CONFIG_SLABINFO=3Dy
> > > > CONFIG_RT_MUTEXES=3Dy
> > > > CONFIG_BASE_SMALL=3D0
> > > > CONFIG_MODULES=3Dy
> > > > # CONFIG_MODULE_FORCE_LOAD is not set
> > > > CONFIG_MODULE_UNLOAD=3Dy
> > > > CONFIG_MODULE_FORCE_UNLOAD=3Dy
> > > > # CONFIG_MODVERSIONS is not set
> > > > # CONFIG_MODULE_SRCVERSION_ALL is not set
> > > > # CONFIG_MODULE_SIG is not set
> > > > # CONFIG_MODULE_COMPRESS is not set
> > > > # CONFIG_TRIM_UNUSED_KSYMS is not set
> > > > CONFIG_BLOCK=3Dy
> > > > CONFIG_LBDAF=3Dy
> > > > CONFIG_BLK_SCSI_REQUEST=3Dy
> > > > CONFIG_BLK_DEV_BSG=3Dy
> > > > CONFIG_BLK_DEV_BSGLIB=3Dy
> > > > # CONFIG_BLK_DEV_INTEGRITY is not set
> > > > # CONFIG_BLK_DEV_ZONED is not set
> > > > # CONFIG_BLK_CMDLINE_PARSER is not set
> > > > # CONFIG_BLK_WBT is not set
> > > > # CONFIG_BLK_DEBUG_FS is not set
> > > > # CONFIG_BLK_SED_OPAL is not set
> > > >=20
> > > > #
> > > > # Partition Types
> > > > #
> > > > CONFIG_PARTITION_ADVANCED=3Dy
> > > > # CONFIG_ACORN_PARTITION is not set
> > > > CONFIG_AIX_PARTITION=3Dy
> > > > CONFIG_OSF_PARTITION=3Dy
> > > > CONFIG_AMIGA_PARTITION=3Dy
> > > > CONFIG_ATARI_PARTITION=3Dy
> > > > CONFIG_MAC_PARTITION=3Dy
> > > > CONFIG_MSDOS_PARTITION=3Dy
> > > > CONFIG_BSD_DISKLABEL=3Dy
> > > > CONFIG_MINIX_SUBPARTITION=3Dy
> > > > CONFIG_SOLARIS_X86_PARTITION=3Dy
> > > > CONFIG_UNIXWARE_DISKLABEL=3Dy
> > > > CONFIG_LDM_PARTITION=3Dy
> > > > # CONFIG_LDM_DEBUG is not set
> > > > CONFIG_SGI_PARTITION=3Dy
> > > > CONFIG_ULTRIX_PARTITION=3Dy
> > > > CONFIG_SUN_PARTITION=3Dy
> > > > CONFIG_KARMA_PARTITION=3Dy
> > > > CONFIG_EFI_PARTITION=3Dy
> > > > CONFIG_SYSV68_PARTITION=3Dy
> > > > # CONFIG_CMDLINE_PARTITION is not set
> > > > CONFIG_BLK_MQ_PCI=3Dy
> > > >=20
> > > > #
> > > > # IO Schedulers
> > > > #
> > > > CONFIG_IOSCHED_NOOP=3Dy
> > > > CONFIG_IOSCHED_DEADLINE=3Dy
> > > > CONFIG_IOSCHED_CFQ=3Dy
> > > > # CONFIG_DEFAULT_DEADLINE is not set
> > > > CONFIG_DEFAULT_CFQ=3Dy
> > > > # CONFIG_DEFAULT_NOOP is not set
> > > > CONFIG_DEFAULT_IOSCHED=3D"cfq"
> > > > # CONFIG_MQ_IOSCHED_DEADLINE is not set
> > > > # CONFIG_MQ_IOSCHED_KYBER is not set
> > > > # CONFIG_IOSCHED_BFQ is not set
> > > > CONFIG_INLINE_SPIN_UNLOCK_IRQ=3Dy
> > > > CONFIG_INLINE_READ_UNLOCK=3Dy
> > > > CONFIG_INLINE_READ_UNLOCK_IRQ=3Dy
> > > > CONFIG_INLINE_WRITE_UNLOCK=3Dy
> > > > CONFIG_INLINE_WRITE_UNLOCK_IRQ=3Dy
> > > > CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy
> > > > # CONFIG_FREEZER is not set
> > > > # CONFIG_PPC_XICS is not set
> > > > # CONFIG_PPC_ICP_NATIVE is not set
> > > > # CONFIG_PPC_ICP_HV is not set
> > > > # CONFIG_PPC_ICS_RTAS is not set
> > > > # CONFIG_PPC_XIVE is not set
> > > > # CONFIG_GE_FPGA is not set
> > > >=20
> > > > #
> > > > # Platform support
> > > > #
> > > > # CONFIG_PPC_CHRP is not set
> > > > # CONFIG_PPC_MPC512x is not set
> > > > # CONFIG_PPC_MPC52xx is not set
> > > > CONFIG_PPC_PMAC=3Dy
> > > > # CONFIG_PPC_CELL is not set
> > > > # CONFIG_PPC_CELL_NATIVE is not set
> > > > # CONFIG_PPC_82xx is not set
> > > > # CONFIG_PQ2ADS is not set
> > > > # CONFIG_PPC_83xx is not set
> > > > # CONFIG_PPC_86xx is not set
> > > > # CONFIG_EMBEDDED6xx is not set
> > > > # CONFIG_AMIGAONE is not set
> > > > # CONFIG_KVM_GUEST is not set
> > > > # CONFIG_EPAPR_PARAVIRT is not set
> > > > CONFIG_PPC_NATIVE=3Dy
> > > > CONFIG_PPC_OF_BOOT_TRAMPOLINE=3Dy
> > > > # CONFIG_IPIC is not set
> > > > CONFIG_MPIC=3Dy
> > > > # CONFIG_PPC_EPAPR_HV_PIC is not set
> > > > # CONFIG_MPIC_WEIRD is not set
> > > > CONFIG_MPIC_MSGR=3Dy
> > > > # CONFIG_PPC_I8259 is not set
> > > > # CONFIG_PPC_RTAS is not set
> > > > # CONFIG_MMIO_NVRAM is not set
> > > > # CONFIG_MPIC_U3_HT_IRQS is not set
> > > > CONFIG_PPC_MPC106=3Dy
> > > > # CONFIG_PPC_970_NAP is not set
> > > > # CONFIG_PPC_P7_NAP is not set
> > > >=20
> > > > #
> > > > # CPU Frequency scaling
> > > > #
> > > > # CONFIG_CPU_FREQ is not set
> > > >=20
> > > > #
> > > > # CPUIdle driver
> > > > #
> > > >=20
> > > > #
> > > > # CPU Idle
> > > > #
> > > > # CONFIG_CPU_IDLE is not set
> > > > # CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
> > > > # CONFIG_PPC601_SYNC_FIX is not set
> > > > CONFIG_TAU=3Dy
> > > > # CONFIG_TAU_INT is not set
> > > > CONFIG_TAU_AVERAGE=3Dy
> > > > # CONFIG_FSL_ULI1575 is not set
> > > > CONFIG_GEN_RTC=3Dy
> > > > # CONFIG_SIMPLE_GPIO is not set
> > > >=20
> > > > #
> > > > # Kernel options
> > > > #
> > > > CONFIG_HIGHMEM=3Dy
> > > > # CONFIG_HZ_100 is not set
> > > > CONFIG_HZ_250=3Dy
> > > > # CONFIG_HZ_300 is not set
> > > > # CONFIG_HZ_1000 is not set
> > > > CONFIG_HZ=3D250
> > > > CONFIG_SCHED_HRTICK=3Dy
> > > > CONFIG_PREEMPT_NONE=3Dy
> > > > # CONFIG_PREEMPT_VOLUNTARY is not set
> > > > # CONFIG_PREEMPT is not set
> > > > CONFIG_BINFMT_ELF=3Dy
> > > > CONFIG_ELFCORE=3Dy
> > > > CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
> > > > CONFIG_BINFMT_SCRIPT=3Dy
> > > > # CONFIG_HAVE_AOUT is not set
> > > > CONFIG_BINFMT_MISC=3Dy
> > > > CONFIG_COREDUMP=3Dy
> > > > # CONFIG_IOMMU_HELPER is not set
> > > > # CONFIG_SWIOTLB is not set
> > > > CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
> > > > CONFIG_ARCH_HAS_WALK_MEMORY=3Dy
> > > > CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=3Dy
> > > > # CONFIG_KEXEC is not set
> > > > # CONFIG_CRASH_DUMP is not set
> > > > CONFIG_ARCH_FLATMEM_ENABLE=3Dy
> > > > CONFIG_ILLEGAL_POINTER_VALUE=3D0
> > > > CONFIG_FLATMEM=3Dy
> > > > CONFIG_FLAT_NODE_MEM_MAP=3Dy
> > > > CONFIG_HAVE_MEMBLOCK=3Dy
> > > > CONFIG_HAVE_MEMBLOCK_NODE_MAP=3Dy
> > > > CONFIG_HAVE_GENERIC_GUP=3Dy
> > > > CONFIG_NO_BOOTMEM=3Dy
> > > > # CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
> > > > CONFIG_SPLIT_PTLOCK_CPUS=3D4
> > > > # CONFIG_COMPACTION is not set
> > > > # CONFIG_MIGRATION is not set
> > > > # CONFIG_PHYS_ADDR_T_64BIT is not set
> > > > # CONFIG_BOUNCE is not set
> > > > CONFIG_VIRT_TO_BUS=3Dy
> > > > CONFIG_MMU_NOTIFIER=3Dy
> > > > # CONFIG_KSM is not set
> > > > CONFIG_DEFAULT_MMAP_MIN_ADDR=3D4096
> > > > # CONFIG_ARCH_WANTS_THP_SWAP is not set
> > > > CONFIG_NEED_PER_CPU_KM=3Dy
> > > > # CONFIG_CLEANCACHE is not set
> > > > # CONFIG_FRONTSWAP is not set
> > > > # CONFIG_CMA is not set
> > > > # CONFIG_ZPOOL is not set
> > > > # CONFIG_ZBUD is not set
> > > > # CONFIG_ZSMALLOC is not set
> > > > CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=3Dy
> > > > # CONFIG_IDLE_PAGE_TRACKING is not set
> > > > # CONFIG_PERCPU_STATS is not set
> > > > CONFIG_PPC_4K_PAGES=3Dy
> > > > CONFIG_THREAD_SHIFT=3D13
> > > > CONFIG_FORCE_MAX_ZONEORDER=3D11
> > > > # CONFIG_PPC_COPRO_BASE is not set
> > > > CONFIG_CMDLINE_BOOL=3Dy
> > > > CONFIG_CMDLINE=3D"console=3DttyS0,9600 console=3Dtty0"
> > > > # CONFIG_CMDLINE_FORCE is not set
> > > > CONFIG_EXTRA_TARGETS=3D""
> > > > CONFIG_ARCH_WANTS_FREEZER_CONTROL=3Dy
> > > > # CONFIG_SUSPEND is not set
> > > > # CONFIG_HIBERNATION is not set
> > > > CONFIG_PM=3Dy
> > > > # CONFIG_PM_DEBUG is not set
> > > > # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> > > > # CONFIG_SECCOMP is not set
> > > > CONFIG_ISA_DMA_API=3Dy
> > > >=20
> > > > #
> > > > # Bus options
> > > > #
> > > > CONFIG_ZONE_DMA=3Dy
> > > > # CONFIG_NEED_DMA_MAP_STATE is not set
> > > > CONFIG_NEED_SG_DMA_LENGTH=3Dy
> > > > CONFIG_GENERIC_ISA_DMA=3Dy
> > > > CONFIG_PPC_INDIRECT_PCI=3Dy
> > > > # CONFIG_FSL_LBC is not set
> > > > CONFIG_PCI=3Dy
> > > > CONFIG_PCI_DOMAINS=3Dy
> > > > CONFIG_PCI_SYSCALL=3Dy
> > > > # CONFIG_PCIEPORTBUS is not set
> > > > # CONFIG_PCI_MSI is not set
> > > > # CONFIG_PCI_DEBUG is not set
> > > > # CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
> > > > # CONFIG_PCI_STUB is not set
> > > > # CONFIG_PCI_IOV is not set
> > > > # CONFIG_PCI_PRI is not set
> > > > # CONFIG_PCI_PASID is not set
> > > > # CONFIG_HOTPLUG_PCI is not set
> > > >=20
> > > > #
> > > > # DesignWare PCI Core Support
> > > > #
> > > >=20
> > > > #
> > > > # PCI host controller drivers
> > > > #
> > > >=20
> > > > #
> > > > # PCI Endpoint
> > > > #
> > > > # CONFIG_PCI_ENDPOINT is not set
> > > >=20
> > > > #
> > > > # PCI switch controller drivers
> > > > #
> > > > # CONFIG_PCI_SW_SWITCHTEC is not set
> > > > # CONFIG_PCCARD is not set
> > > > # CONFIG_HAS_RAPIDIO is not set
> > > > # CONFIG_RAPIDIO is not set
> > > > # CONFIG_NONSTATIC_KERNEL is not set
> > > >=20
> > > > #
> > > > # Advanced setup
> > > > #
> > > > # CONFIG_ADVANCED_OPTIONS is not set
> > > >=20
> > > > #
> > > > # Default settings for advanced configuration options are used
> > > > #
> > > > CONFIG_LOWMEM_SIZE=3D0x30000000
> > > > CONFIG_PAGE_OFFSET=3D0xc0000000
> > > > CONFIG_KERNEL_START=3D0xc0000000
> > > > CONFIG_PHYSICAL_START=3D0x00000000
> > > > CONFIG_TASK_SIZE=3D0xc0000000
> > > > # CONFIG_ARCH_RANDOM is not set
> > > > CONFIG_NET=3Dy
> > > >=20
> > > > #
> > > > # Networking options
> > > > #
> > > > CONFIG_PACKET=3Dy
> > > > # CONFIG_PACKET_DIAG is not set
> > > > CONFIG_UNIX=3Dy
> > > > # CONFIG_UNIX_DIAG is not set
> > > > # CONFIG_TLS is not set
> > > > CONFIG_XFRM=3Dy
> > > > # CONFIG_XFRM_USER is not set
> > > > # CONFIG_XFRM_SUB_POLICY is not set
> > > > # CONFIG_XFRM_MIGRATE is not set
> > > > # CONFIG_XFRM_STATISTICS is not set
> > > > # CONFIG_NET_KEY is not set
> > > > CONFIG_INET=3Dy
> > > > CONFIG_IP_MULTICAST=3Dy
> > > > # CONFIG_IP_ADVANCED_ROUTER is not set
> > > > # CONFIG_IP_PNP is not set
> > > > # CONFIG_NET_IPIP is not set
> > > > # CONFIG_NET_IPGRE_DEMUX is not set
> > > > CONFIG_NET_IP_TUNNEL=3Dm
> > > > # CONFIG_IP_MROUTE is not set
> > > > # CONFIG_SYN_COOKIES is not set
> > > > # CONFIG_NET_UDP_TUNNEL is not set
> > > > # CONFIG_NET_FOU is not set
> > > > # CONFIG_NET_FOU_IP_TUNNELS is not set
> > > > # CONFIG_INET_AH is not set
> > > > # CONFIG_INET_ESP is not set
> > > > # CONFIG_INET_IPCOMP is not set
> > > > # CONFIG_INET_XFRM_TUNNEL is not set
> > > > CONFIG_INET_TUNNEL=3Dm
> > > > # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> > > > # CONFIG_INET_XFRM_MODE_TUNNEL is not set
> > > > # CONFIG_INET_XFRM_MODE_BEET is not set
> > > > # CONFIG_INET_DIAG is not set
> > > > # CONFIG_TCP_CONG_ADVANCED is not set
> > > > CONFIG_TCP_CONG_CUBIC=3Dy
> > > > CONFIG_DEFAULT_TCP_CONG=3D"cubic"
> > > > # CONFIG_TCP_MD5SIG is not set
> > > > CONFIG_IPV6=3Dy
> > > > CONFIG_IPV6_ROUTER_PREF=3Dy
> > > > CONFIG_IPV6_ROUTE_INFO=3Dy
> > > > CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
> > > > # CONFIG_INET6_AH is not set
> > > > # CONFIG_INET6_ESP is not set
> > > > # CONFIG_INET6_IPCOMP is not set
> > > > CONFIG_IPV6_MIP6=3Dm
> > > > # CONFIG_INET6_XFRM_TUNNEL is not set
> > > > CONFIG_INET6_TUNNEL=3Dm
> > > > # CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
> > > > # CONFIG_INET6_XFRM_MODE_TUNNEL is not set
> > > > # CONFIG_INET6_XFRM_MODE_BEET is not set
> > > > # CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
> > > > CONFIG_IPV6_SIT=3Dm
> > > > CONFIG_IPV6_SIT_6RD=3Dy
> > > > CONFIG_IPV6_NDISC_NODETYPE=3Dy
> > > > CONFIG_IPV6_TUNNEL=3Dm
> > > > # CONFIG_IPV6_FOU is not set
> > > > # CONFIG_IPV6_FOU_TUNNEL is not set
> > > > # CONFIG_IPV6_MULTIPLE_TABLES is not set
> > > > # CONFIG_IPV6_MROUTE is not set
> > > > # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> > > > # CONFIG_IPV6_SEG6_HMAC is not set
> > > > # CONFIG_NETWORK_SECMARK is not set
> > > > # CONFIG_NET_PTP_CLASSIFY is not set
> > > > # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> > > > # CONFIG_NETFILTER is not set
> > > > # CONFIG_IP_DCCP is not set
> > > > # CONFIG_IP_SCTP is not set
> > > > # CONFIG_RDS is not set
> > > > # CONFIG_TIPC is not set
> > > > # CONFIG_ATM is not set
> > > > # CONFIG_L2TP is not set
> > > > CONFIG_STP=3Dm
> > > > CONFIG_GARP=3Dm
> > > > CONFIG_MRP=3Dm
> > > > # CONFIG_BRIDGE is not set
> > > > CONFIG_HAVE_NET_DSA=3Dy
> > > > # CONFIG_NET_DSA is not set
> > > > CONFIG_VLAN_8021Q=3Dm
> > > > CONFIG_VLAN_8021Q_GVRP=3Dy
> > > > CONFIG_VLAN_8021Q_MVRP=3Dy
> > > > # CONFIG_DECNET is not set
> > > > CONFIG_LLC=3Dm
> > > > # CONFIG_LLC2 is not set
> > > > # CONFIG_IPX is not set
> > > > # CONFIG_ATALK is not set
> > > > # CONFIG_X25 is not set
> > > > # CONFIG_LAPB is not set
> > > > # CONFIG_PHONET is not set
> > > > # CONFIG_6LOWPAN is not set
> > > > # CONFIG_IEEE802154 is not set
> > > > # CONFIG_NET_SCHED is not set
> > > > # CONFIG_DCB is not set
> > > > # CONFIG_BATMAN_ADV is not set
> > > > # CONFIG_OPENVSWITCH is not set
> > > > # CONFIG_VSOCKETS is not set
> > > > # CONFIG_NETLINK_DIAG is not set
> > > > # CONFIG_MPLS is not set
> > > > # CONFIG_HSR is not set
> > > > # CONFIG_NET_SWITCHDEV is not set
> > > > # CONFIG_NET_L3_MASTER_DEV is not set
> > > > # CONFIG_NET_NCSI is not set
> > > > # CONFIG_CGROUP_NET_PRIO is not set
> > > > # CONFIG_CGROUP_NET_CLASSID is not set
> > > > CONFIG_NET_RX_BUSY_POLL=3Dy
> > > > CONFIG_BQL=3Dy
> > > > CONFIG_BPF_JIT=3Dy
> > > >=20
> > > > #
> > > > # Network testing
> > > > #
> > > > CONFIG_NET_PKTGEN=3Dm
> > > > # CONFIG_HAMRADIO is not set
> > > > # CONFIG_CAN is not set
> > > > # CONFIG_IRDA is not set
> > > > CONFIG_BT=3Dm
> > > > CONFIG_BT_BREDR=3Dy
> > > > CONFIG_BT_RFCOMM=3Dm
> > > > CONFIG_BT_RFCOMM_TTY=3Dy
> > > > CONFIG_BT_BNEP=3Dm
> > > > CONFIG_BT_BNEP_MC_FILTER=3Dy
> > > > CONFIG_BT_BNEP_PROTO_FILTER=3Dy
> > > > CONFIG_BT_HIDP=3Dm
> > > > CONFIG_BT_HS=3Dy
> > > > CONFIG_BT_LE=3Dy
> > > > # CONFIG_BT_SELFTEST is not set
> > > > # CONFIG_BT_DEBUGFS is not set
> > > >=20
> > > > #
> > > > # Bluetooth device drivers
> > > > #
> > > > CONFIG_BT_INTEL=3Dm
> > > > CONFIG_BT_BCM=3Dm
> > > > CONFIG_BT_RTL=3Dm
> > > > CONFIG_BT_QCA=3Dm
> > > > CONFIG_BT_HCIBTUSB=3Dm
> > > > CONFIG_BT_HCIBTUSB_BCM=3Dy
> > > > CONFIG_BT_HCIBTUSB_RTL=3Dy
> > > > CONFIG_BT_HCIUART=3Dm
> > > > CONFIG_BT_HCIUART_H4=3Dy
> > > > CONFIG_BT_HCIUART_BCSP=3Dy
> > > > CONFIG_BT_HCIUART_ATH3K=3Dy
> > > > # CONFIG_BT_HCIUART_3WIRE is not set
> > > > CONFIG_BT_HCIUART_INTEL=3Dy
> > > > # CONFIG_BT_HCIUART_BCM is not set
> > > > CONFIG_BT_HCIUART_QCA=3Dy
> > > > # CONFIG_BT_HCIUART_AG6XX is not set
> > > > # CONFIG_BT_HCIUART_MRVL is not set
> > > > CONFIG_BT_HCIBCM203X=3Dm
> > > > CONFIG_BT_HCIBPA10X=3Dm
> > > > CONFIG_BT_HCIBFUSB=3Dm
> > > > # CONFIG_BT_HCIVHCI is not set
> > > > # CONFIG_BT_MRVL is not set
> > > > CONFIG_BT_ATH3K=3Dm
> > > > # CONFIG_AF_RXRPC is not set
> > > > # CONFIG_AF_KCM is not set
> > > > # CONFIG_STREAM_PARSER is not set
> > > > CONFIG_WIRELESS=3Dy
> > > > CONFIG_WIRELESS_EXT=3Dy
> > > > CONFIG_WEXT_CORE=3Dy
> > > > CONFIG_WEXT_PROC=3Dy
> > > > CONFIG_WEXT_SPY=3Dy
> > > > CONFIG_WEXT_PRIV=3Dy
> > > > CONFIG_CFG80211=3Dm
> > > > # CONFIG_NL80211_TESTMODE is not set
> > > > # CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
> > > > CONFIG_CFG80211_DEFAULT_PS=3Dy
> > > > # CONFIG_CFG80211_DEBUGFS is not set
> > > > # CONFIG_CFG80211_INTERNAL_REGDB is not set
> > > > CONFIG_CFG80211_CRDA_SUPPORT=3Dy
> > > > # CONFIG_CFG80211_WEXT is not set
> > > > # CONFIG_LIB80211 is not set
> > > > CONFIG_MAC80211=3Dm
> > > > CONFIG_MAC80211_HAS_RC=3Dy
> > > > CONFIG_MAC80211_RC_MINSTREL=3Dy
> > > > CONFIG_MAC80211_RC_MINSTREL_HT=3Dy
> > > > # CONFIG_MAC80211_RC_MINSTREL_VHT is not set
> > > > CONFIG_MAC80211_RC_DEFAULT_MINSTREL=3Dy
> > > > CONFIG_MAC80211_RC_DEFAULT=3D"minstrel_ht"
> > > > # CONFIG_MAC80211_MESH is not set
> > > > # CONFIG_MAC80211_DEBUGFS is not set
> > > > # CONFIG_MAC80211_MESSAGE_TRACING is not set
> > > > # CONFIG_MAC80211_DEBUG_MENU is not set
> > > > CONFIG_MAC80211_STA_HASH_MAX_SIZE=3D0
> > > > # CONFIG_WIMAX is not set
> > > > # CONFIG_RFKILL is not set
> > > > # CONFIG_NET_9P is not set
> > > > # CONFIG_CAIF is not set
> > > > # CONFIG_CEPH_LIB is not set
> > > > # CONFIG_NFC is not set
> > > > # CONFIG_PSAMPLE is not set
> > > > # CONFIG_NET_IFE is not set
> > > > # CONFIG_LWTUNNEL is not set
> > > > CONFIG_DST_CACHE=3Dy
> > > > CONFIG_GRO_CELLS=3Dy
> > > > # CONFIG_NET_DEVLINK is not set
> > > > CONFIG_MAY_USE_DEVLINK=3Dy
> > > > CONFIG_HAVE_CBPF_JIT=3Dy
> > > >=20
> > > > #
> > > > # Device Drivers
> > > > #
> > > >=20
> > > > #
> > > > # Generic Driver Options
> > > > #
> > > > CONFIG_UEVENT_HELPER=3Dy
> > > > CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
> > > > CONFIG_DEVTMPFS=3Dy
> > > > CONFIG_DEVTMPFS_MOUNT=3Dy
> > > > CONFIG_STANDALONE=3Dy
> > > > CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
> > > > CONFIG_FW_LOADER=3Dy
> > > > # CONFIG_FIRMWARE_IN_KERNEL is not set
> > > > CONFIG_EXTRA_FIRMWARE=3D""
> > > > # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> > > > CONFIG_ALLOW_DEV_COREDUMP=3Dy
> > > > # CONFIG_DEBUG_DRIVER is not set
> > > > # CONFIG_DEBUG_DEVRES is not set
> > > > # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> > > > # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> > > > # CONFIG_SYS_HYPERVISOR is not set
> > > > # CONFIG_GENERIC_CPU_DEVICES is not set
> > > > CONFIG_GENERIC_CPU_AUTOPROBE=3Dy
> > > > CONFIG_REGMAP=3Dy
> > > > CONFIG_REGMAP_I2C=3Dy
> > > > CONFIG_DMA_SHARED_BUFFER=3Dy
> > > > # CONFIG_DMA_FENCE_TRACE is not set
> > > >=20
> > > > #
> > > > # Bus devices
> > > > #
> > > > # CONFIG_SIMPLE_PM_BUS is not set
> > > > # CONFIG_CONNECTOR is not set
> > > > # CONFIG_MTD is not set
> > > > CONFIG_DTC=3Dy
> > > > CONFIG_OF=3Dy
> > > > # CONFIG_OF_UNITTEST is not set
> > > > CONFIG_OF_FLATTREE=3Dy
> > > > CONFIG_OF_EARLY_FLATTREE=3Dy
> > > > CONFIG_OF_ADDRESS=3Dy
> > > > CONFIG_OF_ADDRESS_PCI=3Dy
> > > > CONFIG_OF_IRQ=3Dy
> > > > CONFIG_OF_NET=3Dy
> > > > CONFIG_OF_PCI=3Dy
> > > > CONFIG_OF_PCI_IRQ=3Dy
> > > > CONFIG_OF_RESERVED_MEM=3Dy
> > > > # CONFIG_OF_OVERLAY is not set
> > > > CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=3Dy
> > > > # CONFIG_PARPORT is not set
> > > > CONFIG_BLK_DEV=3Dy
> > > > # CONFIG_BLK_DEV_NULL_BLK is not set
> > > > # CONFIG_BLK_DEV_FD is not set
> > > > # CONFIG_MAC_FLOPPY is not set
> > > > # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> > > > # CONFIG_BLK_CPQ_CISS_DA is not set
> > > > # CONFIG_BLK_DEV_DAC960 is not set
> > > > # CONFIG_BLK_DEV_UMEM is not set
> > > > # CONFIG_BLK_DEV_COW_COMMON is not set
> > > > CONFIG_BLK_DEV_LOOP=3Dy
> > > > CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D8
> > > > # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> > > > # CONFIG_BLK_DEV_DRBD is not set
> > > > # CONFIG_BLK_DEV_NBD is not set
> > > > # CONFIG_BLK_DEV_SX8 is not set
> > > > # CONFIG_BLK_DEV_RAM is not set
> > > > # CONFIG_CDROM_PKTCDVD is not set
> > > > # CONFIG_ATA_OVER_ETH is not set
> > > > # CONFIG_BLK_DEV_RBD is not set
> > > > # CONFIG_BLK_DEV_RSXX is not set
> > > > # CONFIG_BLK_DEV_NVME is not set
> > > > # CONFIG_NVME_FC is not set
> > > >=20
> > > > #
> > > > # Misc devices
> > > > #
> > > > # CONFIG_SENSORS_LIS3LV02D is not set
> > > > # CONFIG_AD525X_DPOT is not set
> > > > # CONFIG_DUMMY_IRQ is not set
> > > > # CONFIG_PHANTOM is not set
> > > > # CONFIG_SGI_IOC4 is not set
> > > > # CONFIG_TIFM_CORE is not set
> > > > # CONFIG_ICS932S401 is not set
> > > > # CONFIG_ENCLOSURE_SERVICES is not set
> > > > # CONFIG_HP_ILO is not set
> > > > # CONFIG_APDS9802ALS is not set
> > > > # CONFIG_ISL29003 is not set
> > > > # CONFIG_ISL29020 is not set
> > > > # CONFIG_SENSORS_TSL2550 is not set
> > > > # CONFIG_SENSORS_BH1770 is not set
> > > > # CONFIG_SENSORS_APDS990X is not set
> > > > # CONFIG_HMC6352 is not set
> > > > # CONFIG_DS1682 is not set
> > > > # CONFIG_USB_SWITCH_FSA9480 is not set
> > > > # CONFIG_SRAM is not set
> > > > # CONFIG_PCI_ENDPOINT_TEST is not set
> > > > # CONFIG_C2PORT is not set
> > > >=20
> > > > #
> > > > # EEPROM support
> > > > #
> > > > CONFIG_EEPROM_AT24=3Dm
> > > > CONFIG_EEPROM_LEGACY=3Dm
> > > > # CONFIG_EEPROM_MAX6875 is not set
> > > > CONFIG_EEPROM_93CX6=3Dm
> > > > # CONFIG_EEPROM_IDT_89HPESX is not set
> > > > # CONFIG_CB710_CORE is not set
> > > >=20
> > > > #
> > > > # Texas Instruments shared transport line discipline
> > > > #
> > > > # CONFIG_SENSORS_LIS3_I2C is not set
> > > >=20
> > > > #
> > > > # Altera FPGA firmware download module
> > > > #
> > > > # CONFIG_ALTERA_STAPL is not set
> > > >=20
> > > > #
> > > > # Intel MIC Bus Driver
> > > > #
> > > >=20
> > > > #
> > > > # SCIF Bus Driver
> > > > #
> > > >=20
> > > > #
> > > > # VOP Bus Driver
> > > > #
> > > >=20
> > > > #
> > > > # Intel MIC Host Driver
> > > > #
> > > >=20
> > > > #
> > > > # Intel MIC Card Driver
> > > > #
> > > >=20
> > > > #
> > > > # SCIF Driver
> > > > #
> > > >=20
> > > > #
> > > > # Intel MIC Coprocessor State Management (COSM) Drivers
> > > > #
> > > >=20
> > > > #
> > > > # VOP Driver
> > > > #
> > > > # CONFIG_ECHO is not set
> > > > # CONFIG_CXL_BASE is not set
> > > > # CONFIG_CXL_AFU_DRIVER_OPS is not set
> > > > # CONFIG_CXL_LIB is not set
> > > > CONFIG_HAVE_IDE=3Dy
> > > > # CONFIG_IDE is not set
> > > >=20
> > > > #
> > > > # SCSI device support
> > > > #
> > > > CONFIG_SCSI_MOD=3Dy
> > > > # CONFIG_RAID_ATTRS is not set
> > > > CONFIG_SCSI=3Dy
> > > > CONFIG_SCSI_DMA=3Dy
> > > > # CONFIG_SCSI_NETLINK is not set
> > > > CONFIG_SCSI_PROC_FS=3Dy
> > > >=20
> > > > #
> > > > # SCSI support type (disk, tape, CD-ROM)
> > > > #
> > > > CONFIG_BLK_DEV_SD=3Dy
> > > > # CONFIG_CHR_DEV_ST is not set
> > > > # CONFIG_CHR_DEV_OSST is not set
> > > > CONFIG_BLK_DEV_SR=3Dm
> > > > CONFIG_BLK_DEV_SR_VENDOR=3Dy
> > > > CONFIG_CHR_DEV_SG=3Dm
> > > > CONFIG_CHR_DEV_SCH=3Dm
> > > > CONFIG_SCSI_CONSTANTS=3Dy
> > > > # CONFIG_SCSI_LOGGING is not set
> > > > CONFIG_SCSI_SCAN_ASYNC=3Dy
> > > >=20
> > > > #
> > > > # SCSI Transports
> > > > #
> > > > # CONFIG_SCSI_SPI_ATTRS is not set
> > > > # CONFIG_SCSI_FC_ATTRS is not set
> > > > # CONFIG_SCSI_ISCSI_ATTRS is not set
> > > > # CONFIG_SCSI_SAS_ATTRS is not set
> > > > # CONFIG_SCSI_SAS_LIBSAS is not set
> > > > # CONFIG_SCSI_SRP_ATTRS is not set
> > > > # CONFIG_SCSI_LOWLEVEL is not set
> > > > # CONFIG_SCSI_DH is not set
> > > > # CONFIG_SCSI_OSD_INITIATOR is not set
> > > > CONFIG_ATA=3Dy
> > > > # CONFIG_ATA_NONSTANDARD is not set
> > > > CONFIG_ATA_VERBOSE_ERROR=3Dy
> > > > CONFIG_SATA_PMP=3Dy
> > > >=20
> > > > #
> > > > # Controllers with non-SFF native interface
> > > > #
> > > > # CONFIG_SATA_AHCI is not set
> > > > # CONFIG_SATA_AHCI_PLATFORM is not set
> > > > # CONFIG_AHCI_CEVA is not set
> > > > # CONFIG_AHCI_QORIQ is not set
> > > > # CONFIG_SATA_INIC162X is not set
> > > > # CONFIG_SATA_ACARD_AHCI is not set
> > > > # CONFIG_SATA_SIL24 is not set
> > > > CONFIG_ATA_SFF=3Dy
> > > >=20
> > > > #
> > > > # SFF controllers with custom DMA interface
> > > > #
> > > > # CONFIG_PDC_ADMA is not set
> > > > # CONFIG_SATA_QSTOR is not set
> > > > # CONFIG_SATA_SX4 is not set
> > > > CONFIG_ATA_BMDMA=3Dy
> > > >=20
> > > > #
> > > > # SATA SFF controllers with BMDMA
> > > > #
> > > > # CONFIG_ATA_PIIX is not set
> > > > # CONFIG_SATA_MV is not set
> > > > # CONFIG_SATA_NV is not set
> > > > # CONFIG_SATA_PROMISE is not set
> > > > # CONFIG_SATA_SIL is not set
> > > > # CONFIG_SATA_SIS is not set
> > > > # CONFIG_SATA_SVW is not set
> > > > # CONFIG_SATA_ULI is not set
> > > > # CONFIG_SATA_VIA is not set
> > > > # CONFIG_SATA_VITESSE is not set
> > > >=20
> > > > #
> > > > # PATA SFF controllers with BMDMA
> > > > #
> > > > # CONFIG_PATA_ALI is not set
> > > > # CONFIG_PATA_AMD is not set
> > > > # CONFIG_PATA_ARTOP is not set
> > > > # CONFIG_PATA_ATIIXP is not set
> > > > # CONFIG_PATA_ATP867X is not set
> > > > # CONFIG_PATA_CMD64X is not set
> > > > # CONFIG_PATA_CYPRESS is not set
> > > > # CONFIG_PATA_EFAR is not set
> > > > # CONFIG_PATA_HPT366 is not set
> > > > # CONFIG_PATA_HPT37X is not set
> > > > # CONFIG_PATA_HPT3X2N is not set
> > > > # CONFIG_PATA_HPT3X3 is not set
> > > > # CONFIG_PATA_IT8213 is not set
> > > > # CONFIG_PATA_IT821X is not set
> > > > # CONFIG_PATA_JMICRON is not set
> > > > CONFIG_PATA_MACIO=3Dy
> > > > # CONFIG_PATA_MARVELL is not set
> > > > # CONFIG_PATA_NETCELL is not set
> > > > # CONFIG_PATA_NINJA32 is not set
> > > > # CONFIG_PATA_NS87415 is not set
> > > > # CONFIG_PATA_OLDPIIX is not set
> > > > # CONFIG_PATA_OPTIDMA is not set
> > > > # CONFIG_PATA_PDC2027X is not set
> > > > # CONFIG_PATA_PDC_OLD is not set
> > > > # CONFIG_PATA_RADISYS is not set
> > > > # CONFIG_PATA_RDC is not set
> > > > # CONFIG_PATA_SCH is not set
> > > > # CONFIG_PATA_SERVERWORKS is not set
> > > > # CONFIG_PATA_SIL680 is not set
> > > > # CONFIG_PATA_SIS is not set
> > > > # CONFIG_PATA_TOSHIBA is not set
> > > > # CONFIG_PATA_TRIFLEX is not set
> > > > # CONFIG_PATA_VIA is not set
> > > > # CONFIG_PATA_WINBOND is not set
> > > >=20
> > > > #
> > > > # PIO-only SFF controllers
> > > > #
> > > > # CONFIG_PATA_CMD640_PCI is not set
> > > > # CONFIG_PATA_MPIIX is not set
> > > > # CONFIG_PATA_NS87410 is not set
> > > > # CONFIG_PATA_OPTI is not set
> > > > # CONFIG_PATA_PLATFORM is not set
> > > > # CONFIG_PATA_RZ1000 is not set
> > > >=20
> > > > #
> > > > # Generic fallback / legacy drivers
> > > > #
> > > > # CONFIG_ATA_GENERIC is not set
> > > > # CONFIG_PATA_LEGACY is not set
> > > > # CONFIG_MD is not set
> > > > # CONFIG_TARGET_CORE is not set
> > > > # CONFIG_FUSION is not set
> > > >=20
> > > > #
> > > > # IEEE 1394 (FireWire) support
> > > > #
> > > > CONFIG_FIREWIRE=3Dm
> > > > CONFIG_FIREWIRE_OHCI=3Dm
> > > > CONFIG_FIREWIRE_SBP2=3Dm
> > > > CONFIG_FIREWIRE_NET=3Dm
> > > > # CONFIG_FIREWIRE_NOSY is not set
> > > > CONFIG_MACINTOSH_DRIVERS=3Dy
> > > > # CONFIG_ADB is not set
> > > > # CONFIG_ADB_CUDA is not set
> > > > CONFIG_ADB_PMU=3Dy
> > > > # CONFIG_ADB_PMU_LED is not set
> > > > # CONFIG_PMAC_APM_EMU is not set
> > > > # CONFIG_PMAC_MEDIABAY is not set
> > > > # CONFIG_PMAC_BACKLIGHT is not set
> > > > CONFIG_MAC_EMUMOUSEBTN=3Dy
> > > > # CONFIG_THERM_WINDTUNNEL is not set
> > > > # CONFIG_THERM_ADT746X is not set
> > > > # CONFIG_WINDFARM is not set
> > > > # CONFIG_PMAC_RACKMETER is not set
> > > > # CONFIG_SENSORS_AMS is not set
> > > > CONFIG_NETDEVICES=3Dy
> > > > CONFIG_NET_CORE=3Dy
> > > > # CONFIG_BONDING is not set
> > > > # CONFIG_DUMMY is not set
> > > > # CONFIG_EQUALIZER is not set
> > > > # CONFIG_NET_FC is not set
> > > > # CONFIG_NET_TEAM is not set
> > > > # CONFIG_MACVLAN is not set
> > > > # CONFIG_VXLAN is not set
> > > > # CONFIG_MACSEC is not set
> > > > CONFIG_NETCONSOLE=3Dy
> > > > CONFIG_NETPOLL=3Dy
> > > > CONFIG_NET_POLL_CONTROLLER=3Dy
> > > > CONFIG_TUN=3Dm
> > > > # CONFIG_TUN_VNET_CROSS_LE is not set
> > > > # CONFIG_VETH is not set
> > > > # CONFIG_NLMON is not set
> > > > CONFIG_SUNGEM_PHY=3Dm
> > > > # CONFIG_ARCNET is not set
> > > >=20
> > > > #
> > > > # CAIF transport drivers
> > > > #
> > > >=20
> > > > #
> > > > # Distributed Switch Architecture drivers
> > > > #
> > > > CONFIG_ETHERNET=3Dy
> > > > # CONFIG_NET_VENDOR_3COM is not set
> > > > # CONFIG_NET_VENDOR_ADAPTEC is not set
> > > > # CONFIG_NET_VENDOR_AGERE is not set
> > > > # CONFIG_NET_VENDOR_ALACRITECH is not set
> > > > # CONFIG_NET_VENDOR_ALTEON is not set
> > > > # CONFIG_ALTERA_TSE is not set
> > > > # CONFIG_NET_VENDOR_AMAZON is not set
> > > > # CONFIG_NET_VENDOR_AMD is not set
> > > > # CONFIG_NET_VENDOR_APPLE is not set
> > > > # CONFIG_NET_VENDOR_AQUANTIA is not set
> > > > # CONFIG_NET_VENDOR_ARC is not set
> > > > # CONFIG_NET_VENDOR_ATHEROS is not set
> > > > # CONFIG_NET_VENDOR_AURORA is not set
> > > > # CONFIG_NET_CADENCE is not set
> > > > # CONFIG_NET_VENDOR_BROADCOM is not set
> > > > # CONFIG_NET_VENDOR_BROCADE is not set
> > > > # CONFIG_NET_VENDOR_CAVIUM is not set
> > > > # CONFIG_NET_VENDOR_CHELSIO is not set
> > > > # CONFIG_NET_VENDOR_CISCO is not set
> > > > # CONFIG_DNET is not set
> > > > # CONFIG_NET_VENDOR_DEC is not set
> > > > # CONFIG_NET_VENDOR_DLINK is not set
> > > > # CONFIG_NET_VENDOR_EMULEX is not set
> > > > # CONFIG_NET_VENDOR_EZCHIP is not set
> > > > # CONFIG_NET_VENDOR_EXAR is not set
> > > > # CONFIG_NET_VENDOR_HP is not set
> > > > # CONFIG_NET_VENDOR_INTEL is not set
> > > > # CONFIG_JME is not set
> > > > # CONFIG_NET_VENDOR_MARVELL is not set
> > > > # CONFIG_NET_VENDOR_MELLANOX is not set
> > > > # CONFIG_NET_VENDOR_MICREL is not set
> > > > # CONFIG_NET_VENDOR_MYRI is not set
> > > > # CONFIG_FEALNX is not set
> > > > # CONFIG_NET_VENDOR_NATSEMI is not set
> > > > # CONFIG_NET_VENDOR_NETRONOME is not set
> > > > # CONFIG_NET_VENDOR_NVIDIA is not set
> > > > # CONFIG_NET_VENDOR_OKI is not set
> > > > # CONFIG_ETHOC is not set
> > > > # CONFIG_NET_PACKET_ENGINE is not set
> > > > # CONFIG_NET_VENDOR_QLOGIC is not set
> > > > # CONFIG_NET_VENDOR_QUALCOMM is not set
> > > > # CONFIG_NET_VENDOR_REALTEK is not set
> > > > # CONFIG_NET_VENDOR_RENESAS is not set
> > > > # CONFIG_NET_VENDOR_RDC is not set
> > > > # CONFIG_NET_VENDOR_ROCKER is not set
> > > > # CONFIG_NET_VENDOR_SAMSUNG is not set
> > > > # CONFIG_NET_VENDOR_SEEQ is not set
> > > > # CONFIG_NET_VENDOR_SILAN is not set
> > > > # CONFIG_NET_VENDOR_SIS is not set
> > > > # CONFIG_NET_VENDOR_SOLARFLARE is not set
> > > > # CONFIG_NET_VENDOR_SMSC is not set
> > > > # CONFIG_NET_VENDOR_STMICRO is not set
> > > > CONFIG_NET_VENDOR_SUN=3Dy
> > > > # CONFIG_HAPPYMEAL is not set
> > > > CONFIG_SUNGEM=3Dm
> > > > # CONFIG_CASSINI is not set
> > > > # CONFIG_NIU is not set
> > > > # CONFIG_NET_VENDOR_TEHUTI is not set
> > > > # CONFIG_NET_VENDOR_TI is not set
> > > > # CONFIG_NET_VENDOR_VIA is not set
> > > > # CONFIG_NET_VENDOR_WIZNET is not set
> > > > # CONFIG_NET_VENDOR_XILINX is not set
> > > > # CONFIG_NET_VENDOR_SYNOPSYS is not set
> > > > # CONFIG_FDDI is not set
> > > > # CONFIG_HIPPI is not set
> > > > # CONFIG_MDIO_DEVICE is not set
> > > > # CONFIG_PHYLIB is not set
> > > > # CONFIG_PPP is not set
> > > > # CONFIG_SLIP is not set
> > > > # CONFIG_USB_NET_DRIVERS is not set
> > > > CONFIG_WLAN=3Dy
> > > > # CONFIG_WLAN_VENDOR_ADMTEK is not set
> > > > # CONFIG_WLAN_VENDOR_ATH is not set
> > > > # CONFIG_WLAN_VENDOR_ATMEL is not set
> > > > CONFIG_WLAN_VENDOR_BROADCOM=3Dy
> > > > CONFIG_B43=3Dm
> > > > CONFIG_B43_BCMA=3Dy
> > > > CONFIG_B43_SSB=3Dy
> > > > CONFIG_B43_BUSES_BCMA_AND_SSB=3Dy
> > > > # CONFIG_B43_BUSES_BCMA is not set
> > > > # CONFIG_B43_BUSES_SSB is not set
> > > > CONFIG_B43_PCI_AUTOSELECT=3Dy
> > > > CONFIG_B43_PCICORE_AUTOSELECT=3Dy
> > > > CONFIG_B43_BCMA_PIO=3Dy
> > > > CONFIG_B43_PIO=3Dy
> > > > CONFIG_B43_PHY_G=3Dy
> > > > # CONFIG_B43_PHY_N is not set
> > > > # CONFIG_B43_PHY_LP is not set
> > > > # CONFIG_B43_PHY_HT is not set
> > > > CONFIG_B43_HWRNG=3Dy
> > > > # CONFIG_B43_DEBUG is not set
> > > > CONFIG_B43LEGACY=3Dm
> > > > CONFIG_B43LEGACY_PCI_AUTOSELECT=3Dy
> > > > CONFIG_B43LEGACY_PCICORE_AUTOSELECT=3Dy
> > > > CONFIG_B43LEGACY_HWRNG=3Dy
> > > > CONFIG_B43LEGACY_DEBUG=3Dy
> > > > CONFIG_B43LEGACY_DMA=3Dy
> > > > CONFIG_B43LEGACY_PIO=3Dy
> > > > CONFIG_B43LEGACY_DMA_AND_PIO_MODE=3Dy
> > > > # CONFIG_B43LEGACY_DMA_MODE is not set
> > > > # CONFIG_B43LEGACY_PIO_MODE is not set
> > > > # CONFIG_BRCMSMAC is not set
> > > > # CONFIG_BRCMFMAC is not set
> > > > CONFIG_WLAN_VENDOR_CISCO=3Dy
> > > > CONFIG_AIRO=3Dm
> > > > # CONFIG_WLAN_VENDOR_INTEL is not set
> > > > # CONFIG_WLAN_VENDOR_INTERSIL is not set
> > > > # CONFIG_WLAN_VENDOR_MARVELL is not set
> > > > # CONFIG_WLAN_VENDOR_MEDIATEK is not set
> > > > # CONFIG_WLAN_VENDOR_RALINK is not set
> > > > # CONFIG_WLAN_VENDOR_REALTEK is not set
> > > > # CONFIG_WLAN_VENDOR_RSI is not set
> > > > # CONFIG_WLAN_VENDOR_ST is not set
> > > > # CONFIG_WLAN_VENDOR_TI is not set
> > > > # CONFIG_WLAN_VENDOR_ZYDAS is not set
> > > > # CONFIG_WLAN_VENDOR_QUANTENNA is not set
> > > > # CONFIG_MAC80211_HWSIM is not set
> > > > # CONFIG_USB_NET_RNDIS_WLAN is not set
> > > >=20
> > > > #
> > > > # Enable WiMAX (Networking options) to see the WiMAX drivers
> > > > #
> > > > # CONFIG_WAN is not set
> > > > # CONFIG_VMXNET3 is not set
> > > > # CONFIG_ISDN is not set
> > > > # CONFIG_NVM is not set
> > > >=20
> > > > #
> > > > # Input device support
> > > > #
> > > > CONFIG_INPUT=3Dy
> > > > # CONFIG_INPUT_FF_MEMLESS is not set
> > > > # CONFIG_INPUT_POLLDEV is not set
> > > > # CONFIG_INPUT_SPARSEKMAP is not set
> > > > # CONFIG_INPUT_MATRIXKMAP is not set
> > > >=20
> > > > #
> > > > # Userland interfaces
> > > > #
> > > > CONFIG_INPUT_MOUSEDEV=3Dy
> > > > CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
> > > > CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> > > > CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> > > > # CONFIG_INPUT_JOYDEV is not set
> > > > CONFIG_INPUT_EVDEV=3Dm
> > > > # CONFIG_INPUT_EVBUG is not set
> > > >=20
> > > > #
> > > > # Input Device Drivers
> > > > #
> > > > CONFIG_INPUT_KEYBOARD=3Dy
> > > > # CONFIG_KEYBOARD_ADP5588 is not set
> > > > # CONFIG_KEYBOARD_ADP5589 is not set
> > > > # CONFIG_KEYBOARD_ATKBD is not set
> > > > # CONFIG_KEYBOARD_QT1070 is not set
> > > > # CONFIG_KEYBOARD_QT2160 is not set
> > > > # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> > > > # CONFIG_KEYBOARD_LKKBD is not set
> > > > # CONFIG_KEYBOARD_TCA6416 is not set
> > > > # CONFIG_KEYBOARD_TCA8418 is not set
> > > > # CONFIG_KEYBOARD_LM8333 is not set
> > > > # CONFIG_KEYBOARD_MAX7359 is not set
> > > > # CONFIG_KEYBOARD_MCS is not set
> > > > # CONFIG_KEYBOARD_MPR121 is not set
> > > > # CONFIG_KEYBOARD_NEWTON is not set
> > > > # CONFIG_KEYBOARD_OPENCORES is not set
> > > > # CONFIG_KEYBOARD_STOWAWAY is not set
> > > > # CONFIG_KEYBOARD_SUNKBD is not set
> > > > # CONFIG_KEYBOARD_OMAP4 is not set
> > > > # CONFIG_KEYBOARD_XTKBD is not set
> > > > # CONFIG_KEYBOARD_CAP11XX is not set
> > > > CONFIG_INPUT_MOUSE=3Dy
> > > > # CONFIG_MOUSE_PS2 is not set
> > > > # CONFIG_MOUSE_SERIAL is not set
> > > > # CONFIG_MOUSE_APPLETOUCH is not set
> > > > # CONFIG_MOUSE_BCM5974 is not set
> > > > # CONFIG_MOUSE_CYAPA is not set
> > > > # CONFIG_MOUSE_ELAN_I2C is not set
> > > > # CONFIG_MOUSE_VSXXXAA is not set
> > > > # CONFIG_MOUSE_SYNAPTICS_I2C is not set
> > > > # CONFIG_MOUSE_SYNAPTICS_USB is not set
> > > > # CONFIG_INPUT_JOYSTICK is not set
> > > > # CONFIG_INPUT_TABLET is not set
> > > > # CONFIG_INPUT_TOUCHSCREEN is not set
> > > > CONFIG_INPUT_MISC=3Dy
> > > > # CONFIG_INPUT_AD714X is not set
> > > > # CONFIG_INPUT_ATMEL_CAPTOUCH is not set
> > > > # CONFIG_INPUT_BMA150 is not set
> > > > # CONFIG_INPUT_E3X0_BUTTON is not set
> > > > # CONFIG_INPUT_MMA8450 is not set
> > > > # CONFIG_INPUT_ATI_REMOTE2 is not set
> > > > # CONFIG_INPUT_KEYSPAN_REMOTE is not set
> > > > # CONFIG_INPUT_KXTJ9 is not set
> > > > # CONFIG_INPUT_POWERMATE is not set
> > > > # CONFIG_INPUT_YEALINK is not set
> > > > # CONFIG_INPUT_CM109 is not set
> > > > CONFIG_INPUT_UINPUT=3Dm
> > > > # CONFIG_INPUT_PCF8574 is not set
> > > > # CONFIG_INPUT_ADXL34X is not set
> > > > # CONFIG_INPUT_CMA3000 is not set
> > > > # CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
> > > > # CONFIG_INPUT_DRV2665_HAPTICS is not set
> > > > # CONFIG_INPUT_DRV2667_HAPTICS is not set
> > > > # CONFIG_RMI4_CORE is not set
> > > >=20
> > > > #
> > > > # Hardware I/O ports
> > > > #
> > > > CONFIG_SERIO=3Dm
> > > > CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=3Dy
> > > > CONFIG_SERIO_I8042=3Dm
> > > > CONFIG_SERIO_SERPORT=3Dm
> > > > # CONFIG_SERIO_PCIPS2 is not set
> > > > CONFIG_SERIO_LIBPS2=3Dm
> > > > CONFIG_SERIO_RAW=3Dm
> > > > # CONFIG_SERIO_XILINX_XPS_PS2 is not set
> > > > # CONFIG_SERIO_ALTERA_PS2 is not set
> > > > # CONFIG_SERIO_PS2MULT is not set
> > > > # CONFIG_SERIO_ARC_PS2 is not set
> > > > # CONFIG_SERIO_APBPS2 is not set
> > > > # CONFIG_USERIO is not set
> > > > CONFIG_GAMEPORT=3Dm
> > > > CONFIG_GAMEPORT_NS558=3Dm
> > > > CONFIG_GAMEPORT_L4=3Dm
> > > > CONFIG_GAMEPORT_EMU10K1=3Dm
> > > > CONFIG_GAMEPORT_FM801=3Dm
> > > >=20
> > > > #
> > > > # Character devices
> > > > #
> > > > CONFIG_TTY=3Dy
> > > > CONFIG_VT=3Dy
> > > > CONFIG_CONSOLE_TRANSLATIONS=3Dy
> > > > CONFIG_VT_CONSOLE=3Dy
> > > > CONFIG_HW_CONSOLE=3Dy
> > > > CONFIG_VT_HW_CONSOLE_BINDING=3Dy
> > > > CONFIG_UNIX98_PTYS=3Dy
> > > > # CONFIG_LEGACY_PTYS is not set
> > > > # CONFIG_SERIAL_NONSTANDARD is not set
> > > > # CONFIG_NOZOMI is not set
> > > > # CONFIG_N_GSM is not set
> > > > # CONFIG_TRACE_SINK is not set
> > > > # CONFIG_PPC_EPAPR_HV_BYTECHAN is not set
> > > > # CONFIG_DEVMEM is not set
> > > > # CONFIG_DEVKMEM is not set
> > > >=20
> > > > #
> > > > # Serial drivers
> > > > #
> > > > CONFIG_SERIAL_EARLYCON=3Dy
> > > > CONFIG_SERIAL_8250=3Dy
> > > > # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> > > > # CONFIG_SERIAL_8250_FINTEK is not set
> > > > CONFIG_SERIAL_8250_CONSOLE=3Dy
> > > > CONFIG_SERIAL_8250_PCI=3Dy
> > > > CONFIG_SERIAL_8250_EXAR=3Dy
> > > > CONFIG_SERIAL_8250_NR_UARTS=3D32
> > > > CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
> > > > # CONFIG_SERIAL_8250_EXTENDED is not set
> > > > # CONFIG_SERIAL_8250_ASPEED_VUART is not set
> > > > CONFIG_SERIAL_8250_FSL=3Dy
> > > > # CONFIG_SERIAL_8250_DW is not set
> > > > # CONFIG_SERIAL_8250_RT288X is not set
> > > > # CONFIG_SERIAL_8250_MOXA is not set
> > > > CONFIG_SERIAL_OF_PLATFORM=3Dy
> > > >=20
> > > > #
> > > > # Non-8250 serial port support
> > > > #
> > > > # CONFIG_SERIAL_UARTLITE is not set
> > > > CONFIG_SERIAL_CORE=3Dy
> > > > CONFIG_SERIAL_CORE_CONSOLE=3Dy
> > > > CONFIG_SERIAL_PMACZILOG=3Dy
> > > > CONFIG_SERIAL_PMACZILOG_TTYS=3Dy
> > > > CONFIG_SERIAL_PMACZILOG_CONSOLE=3Dy
> > > > # CONFIG_SERIAL_JSM is not set
> > > > # CONFIG_SERIAL_SCCNXP is not set
> > > > # CONFIG_SERIAL_SC16IS7XX is not set
> > > > # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> > > > # CONFIG_SERIAL_ALTERA_UART is not set
> > > > # CONFIG_SERIAL_XILINX_PS_UART is not set
> > > > # CONFIG_SERIAL_ARC is not set
> > > > # CONFIG_SERIAL_RP2 is not set
> > > > # CONFIG_SERIAL_FSL_LPUART is not set
> > > > # CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
> > > > # CONFIG_SERIAL_DEV_BUS is not set
> > > > # CONFIG_HVC_UDBG is not set
> > > > # CONFIG_IPMI_HANDLER is not set
> > > > CONFIG_HW_RANDOM=3Dm
> > > > # CONFIG_HW_RANDOM_TIMERIOMEM is not set
> > > > CONFIG_NVRAM=3Dy
> > > > # CONFIG_R3964 is not set
> > > > # CONFIG_APPLICOM is not set
> > > > # CONFIG_RAW_DRIVER is not set
> > > > # CONFIG_TCG_TPM is not set
> > > > CONFIG_DEVPORT=3Dy
> > > > # CONFIG_XILLYBUS is not set
> > > >=20
> > > > #
> > > > # I2C support
> > > > #
> > > > CONFIG_I2C=3Dy
> > > > CONFIG_I2C_BOARDINFO=3Dy
> > > > CONFIG_I2C_COMPAT=3Dy
> > > > CONFIG_I2C_CHARDEV=3Dm
> > > > # CONFIG_I2C_MUX is not set
> > > > CONFIG_I2C_HELPER_AUTO=3Dy
> > > > CONFIG_I2C_ALGOBIT=3Dm
> > > >=20
> > > > #
> > > > # I2C Hardware Bus support
> > > > #
> > > >=20
> > > > #
> > > > # PC SMBus host controller drivers
> > > > #
> > > > # CONFIG_I2C_ALI1535 is not set
> > > > # CONFIG_I2C_ALI1563 is not set
> > > > # CONFIG_I2C_ALI15X3 is not set
> > > > # CONFIG_I2C_AMD756 is not set
> > > > # CONFIG_I2C_AMD8111 is not set
> > > > # CONFIG_I2C_I801 is not set
> > > > # CONFIG_I2C_ISCH is not set
> > > > # CONFIG_I2C_PIIX4 is not set
> > > > # CONFIG_I2C_NFORCE2 is not set
> > > > # CONFIG_I2C_SIS5595 is not set
> > > > # CONFIG_I2C_SIS630 is not set
> > > > # CONFIG_I2C_SIS96X is not set
> > > > # CONFIG_I2C_VIA is not set
> > > > # CONFIG_I2C_VIAPRO is not set
> > > >=20
> > > > #
> > > > # Mac SMBus host controller drivers
> > > > #
> > > > CONFIG_I2C_POWERMAC=3Dm
> > > >=20
> > > > #
> > > > # I2C system bus drivers (mostly embedded / system-on-chip)
> > > > #
> > > > # CONFIG_I2C_DESIGNWARE_PLATFORM is not set
> > > > # CONFIG_I2C_DESIGNWARE_PCI is not set
> > > > # CONFIG_I2C_MPC is not set
> > > > # CONFIG_I2C_OCORES is not set
> > > > # CONFIG_I2C_PCA_PLATFORM is not set
> > > > # CONFIG_I2C_PXA_PCI is not set
> > > > # CONFIG_I2C_SIMTEC is not set
> > > > # CONFIG_I2C_XILINX is not set
> > > >=20
> > > > #
> > > > # External I2C/SMBus adapter drivers
> > > > #
> > > > # CONFIG_I2C_DIOLAN_U2C is not set
> > > > # CONFIG_I2C_PARPORT_LIGHT is not set
> > > > # CONFIG_I2C_ROBOTFUZZ_OSIF is not set
> > > > # CONFIG_I2C_TAOS_EVM is not set
> > > > # CONFIG_I2C_TINY_USB is not set
> > > >=20
> > > > #
> > > > # Other I2C/SMBus bus drivers
> > > > #
> > > > # CONFIG_I2C_STUB is not set
> > > > # CONFIG_I2C_SLAVE is not set
> > > > # CONFIG_I2C_DEBUG_CORE is not set
> > > > # CONFIG_I2C_DEBUG_ALGO is not set
> > > > # CONFIG_I2C_DEBUG_BUS is not set
> > > > # CONFIG_SPI is not set
> > > > # CONFIG_SPMI is not set
> > > > # CONFIG_HSI is not set
> > > > # CONFIG_PPS is not set
> > > >=20
> > > > #
> > > > # PTP clock support
> > > > #
> > > > # CONFIG_PTP_1588_CLOCK is not set
> > > >=20
> > > > #
> > > > # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additiona=
l
> > > > clocks.
> > > > #
> > > > # CONFIG_GPIOLIB is not set
> > > > # CONFIG_W1 is not set
> > > > # CONFIG_POWER_AVS is not set
> > > > # CONFIG_POWER_RESET is not set
> > > > CONFIG_POWER_SUPPLY=3Dy
> > > > # CONFIG_POWER_SUPPLY_DEBUG is not set
> > > > # CONFIG_PDA_POWER is not set
> > > > # CONFIG_TEST_POWER is not set
> > > > # CONFIG_BATTERY_DS2780 is not set
> > > > # CONFIG_BATTERY_DS2781 is not set
> > > > # CONFIG_BATTERY_DS2782 is not set
> > > > CONFIG_BATTERY_PMU=3Dm
> > > > # CONFIG_BATTERY_SBS is not set
> > > > # CONFIG_CHARGER_SBS is not set
> > > > # CONFIG_BATTERY_BQ27XXX is not set
> > > > # CONFIG_BATTERY_MAX17040 is not set
> > > > # CONFIG_BATTERY_MAX17042 is not set
> > > > # CONFIG_CHARGER_MAX8903 is not set
> > > > # CONFIG_CHARGER_LP8727 is not set
> > > > # CONFIG_CHARGER_DETECTOR_MAX14656 is not set
> > > > # CONFIG_CHARGER_BQ2415X is not set
> > > > # CONFIG_CHARGER_SMB347 is not set
> > > > # CONFIG_BATTERY_GAUGE_LTC2941 is not set
> > > > CONFIG_HWMON=3Dm
> > > > # CONFIG_HWMON_VID is not set
> > > > # CONFIG_HWMON_DEBUG_CHIP is not set
> > > >=20
> > > > #
> > > > # Native drivers
> > > > #
> > > > # CONFIG_SENSORS_AD7414 is not set
> > > > # CONFIG_SENSORS_AD7418 is not set
> > > > # CONFIG_SENSORS_ADM1021 is not set
> > > > # CONFIG_SENSORS_ADM1025 is not set
> > > > # CONFIG_SENSORS_ADM1026 is not set
> > > > # CONFIG_SENSORS_ADM1029 is not set
> > > > # CONFIG_SENSORS_ADM1031 is not set
> > > > # CONFIG_SENSORS_ADM9240 is not set
> > > > # CONFIG_SENSORS_ADT7410 is not set
> > > > # CONFIG_SENSORS_ADT7411 is not set
> > > > # CONFIG_SENSORS_ADT7462 is not set
> > > > # CONFIG_SENSORS_ADT7470 is not set
> > > > # CONFIG_SENSORS_ADT7475 is not set
> > > > # CONFIG_SENSORS_ASC7621 is not set
> > > > # CONFIG_SENSORS_ASPEED is not set
> > > > # CONFIG_SENSORS_ATXP1 is not set
> > > > # CONFIG_SENSORS_DS620 is not set
> > > > # CONFIG_SENSORS_DS1621 is not set
> > > > # CONFIG_SENSORS_I5K_AMB is not set
> > > > # CONFIG_SENSORS_F75375S is not set
> > > > # CONFIG_SENSORS_FTSTEUTATES is not set
> > > > # CONFIG_SENSORS_GL518SM is not set
> > > > # CONFIG_SENSORS_GL520SM is not set
> > > > # CONFIG_SENSORS_G760A is not set
> > > > # CONFIG_SENSORS_G762 is not set
> > > > # CONFIG_SENSORS_HIH6130 is not set
> > > > # CONFIG_SENSORS_JC42 is not set
> > > > # CONFIG_SENSORS_POWR1220 is not set
> > > > # CONFIG_SENSORS_LINEAGE is not set
> > > > # CONFIG_SENSORS_LTC2945 is not set
> > > > # CONFIG_SENSORS_LTC2990 is not set
> > > > # CONFIG_SENSORS_LTC4151 is not set
> > > > # CONFIG_SENSORS_LTC4215 is not set
> > > > # CONFIG_SENSORS_LTC4222 is not set
> > > > # CONFIG_SENSORS_LTC4245 is not set
> > > > # CONFIG_SENSORS_LTC4260 is not set
> > > > # CONFIG_SENSORS_LTC4261 is not set
> > > > # CONFIG_SENSORS_MAX16065 is not set
> > > > # CONFIG_SENSORS_MAX1619 is not set
> > > > # CONFIG_SENSORS_MAX1668 is not set
> > > > # CONFIG_SENSORS_MAX197 is not set
> > > > # CONFIG_SENSORS_MAX6639 is not set
> > > > # CONFIG_SENSORS_MAX6642 is not set
> > > > # CONFIG_SENSORS_MAX6650 is not set
> > > > # CONFIG_SENSORS_MAX6697 is not set
> > > > # CONFIG_SENSORS_MAX31790 is not set
> > > > # CONFIG_SENSORS_MCP3021 is not set
> > > > # CONFIG_SENSORS_TC654 is not set
> > > > # CONFIG_SENSORS_LM63 is not set
> > > > # CONFIG_SENSORS_LM73 is not set
> > > > # CONFIG_SENSORS_LM75 is not set
> > > > # CONFIG_SENSORS_LM77 is not set
> > > > # CONFIG_SENSORS_LM78 is not set
> > > > # CONFIG_SENSORS_LM80 is not set
> > > > # CONFIG_SENSORS_LM83 is not set
> > > > # CONFIG_SENSORS_LM85 is not set
> > > > # CONFIG_SENSORS_LM87 is not set
> > > > # CONFIG_SENSORS_LM90 is not set
> > > > # CONFIG_SENSORS_LM92 is not set
> > > > # CONFIG_SENSORS_LM93 is not set
> > > > # CONFIG_SENSORS_LM95234 is not set
> > > > # CONFIG_SENSORS_LM95241 is not set
> > > > # CONFIG_SENSORS_LM95245 is not set
> > > > # CONFIG_SENSORS_NTC_THERMISTOR is not set
> > > > # CONFIG_SENSORS_NCT7802 is not set
> > > > # CONFIG_SENSORS_NCT7904 is not set
> > > > # CONFIG_SENSORS_PCF8591 is not set
> > > > # CONFIG_PMBUS is not set
> > > > # CONFIG_SENSORS_SHT21 is not set
> > > > # CONFIG_SENSORS_SHT3x is not set
> > > > # CONFIG_SENSORS_SHTC1 is not set
> > > > # CONFIG_SENSORS_SIS5595 is not set
> > > > # CONFIG_SENSORS_EMC1403 is not set
> > > > # CONFIG_SENSORS_EMC2103 is not set
> > > > # CONFIG_SENSORS_EMC6W201 is not set
> > > > # CONFIG_SENSORS_SMSC47M192 is not set
> > > > # CONFIG_SENSORS_SCH56XX_COMMON is not set
> > > > # CONFIG_SENSORS_STTS751 is not set
> > > > # CONFIG_SENSORS_SMM665 is not set
> > > > # CONFIG_SENSORS_ADC128D818 is not set
> > > > # CONFIG_SENSORS_ADS1015 is not set
> > > > # CONFIG_SENSORS_ADS7828 is not set
> > > > # CONFIG_SENSORS_AMC6821 is not set
> > > > # CONFIG_SENSORS_INA209 is not set
> > > > # CONFIG_SENSORS_INA2XX is not set
> > > > # CONFIG_SENSORS_INA3221 is not set
> > > > # CONFIG_SENSORS_TC74 is not set
> > > > # CONFIG_SENSORS_THMC50 is not set
> > > > # CONFIG_SENSORS_TMP102 is not set
> > > > # CONFIG_SENSORS_TMP103 is not set
> > > > # CONFIG_SENSORS_TMP108 is not set
> > > > # CONFIG_SENSORS_TMP401 is not set
> > > > # CONFIG_SENSORS_TMP421 is not set
> > > > # CONFIG_SENSORS_VIA686A is not set
> > > > # CONFIG_SENSORS_VT8231 is not set
> > > > # CONFIG_SENSORS_W83781D is not set
> > > > # CONFIG_SENSORS_W83791D is not set
> > > > # CONFIG_SENSORS_W83792D is not set
> > > > # CONFIG_SENSORS_W83793 is not set
> > > > # CONFIG_SENSORS_W83795 is not set
> > > > # CONFIG_SENSORS_W83L785TS is not set
> > > > # CONFIG_SENSORS_W83L786NG is not set
> > > > # CONFIG_THERMAL is not set
> > > > CONFIG_WATCHDOG=3Dy
> > > > CONFIG_WATCHDOG_CORE=3Dy
> > > > # CONFIG_WATCHDOG_NOWAYOUT is not set
> > > > CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=3Dy
> > > > CONFIG_WATCHDOG_SYSFS=3Dy
> > > >=20
> > > > #
> > > > # Watchdog Device Drivers
> > > > #
> > > > CONFIG_SOFT_WATCHDOG=3Dm
> > > > # CONFIG_XILINX_WATCHDOG is not set
> > > > # CONFIG_ZIIRAVE_WATCHDOG is not set
> > > > # CONFIG_CADENCE_WATCHDOG is not set
> > > > # CONFIG_DW_WATCHDOG is not set
> > > > # CONFIG_MAX63XX_WATCHDOG is not set
> > > > # CONFIG_ALIM7101_WDT is not set
> > > > # CONFIG_I6300ESB_WDT is not set
> > > >=20
> > > > #
> > > > # PCI-based Watchdog Cards
> > > > #
> > > > # CONFIG_PCIPCWATCHDOG is not set
> > > > # CONFIG_WDTPCI is not set
> > > >=20
> > > > #
> > > > # USB-based Watchdog Cards
> > > > #
> > > > # CONFIG_USBPCWATCHDOG is not set
> > > >=20
> > > > #
> > > > # Watchdog Pretimeout Governors
> > > > #
> > > > # CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
> > > > CONFIG_SSB_POSSIBLE=3Dy
> > > >=20
> > > > #
> > > > # Sonics Silicon Backplane
> > > > #
> > > > CONFIG_SSB=3Dm
> > > > CONFIG_SSB_SPROM=3Dy
> > > > CONFIG_SSB_BLOCKIO=3Dy
> > > > CONFIG_SSB_PCIHOST_POSSIBLE=3Dy
> > > > CONFIG_SSB_PCIHOST=3Dy
> > > > CONFIG_SSB_B43_PCI_BRIDGE=3Dy
> > > > # CONFIG_SSB_DEBUG is not set
> > > > CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=3Dy
> > > > CONFIG_SSB_DRIVER_PCICORE=3Dy
> > > > CONFIG_BCMA_POSSIBLE=3Dy
> > > >=20
> > > > #
> > > > # Broadcom specific AMBA
> > > > #
> > > > CONFIG_BCMA=3Dm
> > > > CONFIG_BCMA_BLOCKIO=3Dy
> > > > CONFIG_BCMA_HOST_PCI_POSSIBLE=3Dy
> > > > # CONFIG_BCMA_HOST_PCI is not set
> > > > # CONFIG_BCMA_HOST_SOC is not set
> > > > CONFIG_BCMA_DRIVER_PCI=3Dy
> > > > # CONFIG_BCMA_DRIVER_GMAC_CMN is not set
> > > > # CONFIG_BCMA_DEBUG is not set
> > > >=20
> > > > #
> > > > # Multifunction device drivers
> > > > #
> > > > # CONFIG_MFD_CORE is not set
> > > > # CONFIG_MFD_ACT8945A is not set
> > > > # CONFIG_MFD_AS3711 is not set
> > > > # CONFIG_MFD_AS3722 is not set
> > > > # CONFIG_PMIC_ADP5520 is not set
> > > > # CONFIG_MFD_ATMEL_FLEXCOM is not set
> > > > # CONFIG_MFD_ATMEL_HLCDC is not set
> > > > # CONFIG_MFD_BCM590XX is not set
> > > > # CONFIG_MFD_AXP20X_I2C is not set
> > > > # CONFIG_PMIC_DA903X is not set
> > > > # CONFIG_MFD_DA9052_I2C is not set
> > > > # CONFIG_MFD_DA9055 is not set
> > > > # CONFIG_MFD_DA9062 is not set
> > > > # CONFIG_MFD_DA9063 is not set
> > > > # CONFIG_MFD_DA9150 is not set
> > > > # CONFIG_MFD_DLN2 is not set
> > > > # CONFIG_MFD_MC13XXX_I2C is not set
> > > > # CONFIG_MFD_HI6421_PMIC is not set
> > > > # CONFIG_HTC_PASIC3 is not set
> > > > # CONFIG_LPC_ICH is not set
> > > > # CONFIG_LPC_SCH is not set
> > > > # CONFIG_MFD_JANZ_CMODIO is not set
> > > > # CONFIG_MFD_KEMPLD is not set
> > > > # CONFIG_MFD_88PM800 is not set
> > > > # CONFIG_MFD_88PM805 is not set
> > > > # CONFIG_MFD_88PM860X is not set
> > > > # CONFIG_MFD_MAX14577 is not set
> > > > # CONFIG_MFD_MAX77620 is not set
> > > > # CONFIG_MFD_MAX77686 is not set
> > > > # CONFIG_MFD_MAX77693 is not set
> > > > # CONFIG_MFD_MAX77843 is not set
> > > > # CONFIG_MFD_MAX8907 is not set
> > > > # CONFIG_MFD_MAX8925 is not set
> > > > # CONFIG_MFD_MAX8997 is not set
> > > > # CONFIG_MFD_MAX8998 is not set
> > > > # CONFIG_MFD_MT6397 is not set
> > > > # CONFIG_MFD_MENF21BMC is not set
> > > > # CONFIG_MFD_VIPERBOARD is not set
> > > > # CONFIG_MFD_RETU is not set
> > > > # CONFIG_MFD_PCF50633 is not set
> > > > # CONFIG_MFD_RDC321X is not set
> > > > # CONFIG_MFD_RTSX_PCI is not set
> > > > # CONFIG_MFD_RT5033 is not set
> > > > # CONFIG_MFD_RTSX_USB is not set
> > > > # CONFIG_MFD_RC5T583 is not set
> > > > # CONFIG_MFD_RK808 is not set
> > > > # CONFIG_MFD_RN5T618 is not set
> > > > # CONFIG_MFD_SEC_CORE is not set
> > > > # CONFIG_MFD_SI476X_CORE is not set
> > > > # CONFIG_MFD_SM501 is not set
> > > > # CONFIG_MFD_SKY81452 is not set
> > > > # CONFIG_MFD_SMSC is not set
> > > > # CONFIG_ABX500_CORE is not set
> > > > # CONFIG_MFD_STMPE is not set
> > > > # CONFIG_MFD_SYSCON is not set
> > > > # CONFIG_MFD_TI_AM335X_TSCADC is not set
> > > > # CONFIG_MFD_LP3943 is not set
> > > > # CONFIG_MFD_LP8788 is not set
> > > > # CONFIG_MFD_TI_LMU is not set
> > > > # CONFIG_MFD_PALMAS is not set
> > > > # CONFIG_TPS6105X is not set
> > > > # CONFIG_TPS6507X is not set
> > > > # CONFIG_MFD_TPS65086 is not set
> > > > # CONFIG_MFD_TPS65090 is not set
> > > > # CONFIG_MFD_TPS65217 is not set
> > > > # CONFIG_MFD_TI_LP873X is not set
> > > > # CONFIG_MFD_TI_LP87565 is not set
> > > > # CONFIG_MFD_TPS65218 is not set
> > > > # CONFIG_MFD_TPS6586X is not set
> > > > # CONFIG_MFD_TPS65912_I2C is not set
> > > > # CONFIG_MFD_TPS80031 is not set
> > > > # CONFIG_TWL4030_CORE is not set
> > > > # CONFIG_TWL6040_CORE is not set
> > > > # CONFIG_MFD_WL1273_CORE is not set
> > > > # CONFIG_MFD_LM3533 is not set
> > > > # CONFIG_MFD_TC3589X is not set
> > > > # CONFIG_MFD_TMIO is not set
> > > > # CONFIG_MFD_VX855 is not set
> > > > # CONFIG_MFD_ARIZONA_I2C is not set
> > > > # CONFIG_MFD_WM8400 is not set
> > > > # CONFIG_MFD_WM831X_I2C is not set
> > > > # CONFIG_MFD_WM8350_I2C is not set
> > > > # CONFIG_MFD_WM8994 is not set
> > > > # CONFIG_REGULATOR is not set
> > > > # CONFIG_MEDIA_SUPPORT is not set
> > > >=20
> > > > #
> > > > # Graphics support
> > > > #
> > > > CONFIG_AGP=3Dm
> > > > CONFIG_AGP_UNINORTH=3Dm
> > > > CONFIG_VGA_ARB=3Dy
> > > > CONFIG_VGA_ARB_MAX_GPUS=3D16
> > > > CONFIG_DRM=3Dm
> > > > # CONFIG_DRM_DP_AUX_CHARDEV is not set
> > > > # CONFIG_DRM_DEBUG_MM_SELFTEST is not set
> > > > CONFIG_DRM_KMS_HELPER=3Dm
> > > > CONFIG_DRM_KMS_FB_HELPER=3Dy
> > > > CONFIG_DRM_FBDEV_EMULATION=3Dy
> > > > CONFIG_DRM_FBDEV_OVERALLOC=3D100
> > > > # CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
> > > > CONFIG_DRM_TTM=3Dm
> > > > CONFIG_DRM_VM=3Dy
> > > >=20
> > > > #
> > > > # I2C encoder or helper chips
> > > > #
> > > > # CONFIG_DRM_I2C_CH7006 is not set
> > > > # CONFIG_DRM_I2C_SIL164 is not set
> > > > # CONFIG_DRM_I2C_NXP_TDA998X is not set
> > > > CONFIG_DRM_RADEON=3Dm
> > > > CONFIG_DRM_RADEON_USERPTR=3Dy
> > > > # CONFIG_DRM_AMDGPU is not set
> > > >=20
> > > > #
> > > > # ACP (Audio CoProcessor) Configuration
> > > > #
> > > > CONFIG_DRM_NOUVEAU=3Dm
> > > > CONFIG_NOUVEAU_DEBUG=3D5
> > > > CONFIG_NOUVEAU_DEBUG_DEFAULT=3D3
> > > > # CONFIG_DRM_NOUVEAU_BACKLIGHT is not set
> > > > # CONFIG_DRM_VGEM is not set
> > > > # CONFIG_DRM_UDL is not set
> > > > # CONFIG_DRM_AST is not set
> > > > # CONFIG_DRM_MGAG200 is not set
> > > > # CONFIG_DRM_CIRRUS_QEMU is not set
> > > > # CONFIG_DRM_RCAR_DW_HDMI is not set
> > > > # CONFIG_DRM_QXL is not set
> > > > # CONFIG_DRM_BOCHS is not set
> > > > CONFIG_DRM_PANEL=3Dy
> > > >=20
> > > > #
> > > > # Display Panels
> > > > #
> > > > # CONFIG_DRM_PANEL_LVDS is not set
> > > > # CONFIG_DRM_PANEL_SIMPLE is not set
> > > > # CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
> > > > CONFIG_DRM_BRIDGE=3Dy
> > > > CONFIG_DRM_PANEL_BRIDGE=3Dy
> > > >=20
> > > > #
> > > > # Display Interface Bridges
> > > > #
> > > > # CONFIG_DRM_ANALOGIX_ANX78XX is not set
> > > > # CONFIG_DRM_DUMB_VGA_DAC is not set
> > > > # CONFIG_DRM_LVDS_ENCODER is not set
> > > > # CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
> > > > # CONFIG_DRM_NXP_PTN3460 is not set
> > > > # CONFIG_DRM_PARADE_PS8622 is not set
> > > > # CONFIG_DRM_SIL_SII8620 is not set
> > > > # CONFIG_DRM_SII902X is not set
> > > > # CONFIG_DRM_TOSHIBA_TC358767 is not set
> > > > # CONFIG_DRM_TI_TFP410 is not set
> > > > # CONFIG_DRM_I2C_ADV7511 is not set
> > > > # CONFIG_DRM_ARCPGU is not set
> > > > # CONFIG_DRM_HISI_HIBMC is not set
> > > > # CONFIG_DRM_TINYDRM is not set
> > > > CONFIG_DRM_LEGACY=3Dy
> > > > # CONFIG_DRM_TDFX is not set
> > > > CONFIG_DRM_R128=3Dm
> > > > # CONFIG_DRM_MGA is not set
> > > > # CONFIG_DRM_SIS is not set
> > > > # CONFIG_DRM_VIA is not set
> > > > # CONFIG_DRM_SAVAGE is not set
> > > > # CONFIG_DRM_LIB_RANDOM is not set
> > > >=20
> > > > #
> > > > # Frame buffer Devices
> > > > #
> > > > CONFIG_FB=3Dy
> > > > CONFIG_FIRMWARE_EDID=3Dy
> > > > CONFIG_FB_CMDLINE=3Dy
> > > > CONFIG_FB_NOTIFY=3Dy
> > > > CONFIG_FB_DDC=3Dm
> > > > # CONFIG_FB_BOOT_VESA_SUPPORT is not set
> > > > CONFIG_FB_CFB_FILLRECT=3Dy
> > > > CONFIG_FB_CFB_COPYAREA=3Dy
> > > > CONFIG_FB_CFB_IMAGEBLIT=3Dy
> > > > # CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
> > > > CONFIG_FB_SYS_FILLRECT=3Dm
> > > > CONFIG_FB_SYS_COPYAREA=3Dm
> > > > CONFIG_FB_SYS_IMAGEBLIT=3Dm
> > > > # CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
> > > > # CONFIG_FB_FOREIGN_ENDIAN is not set
> > > > CONFIG_FB_SYS_FOPS=3Dm
> > > > CONFIG_FB_DEFERRED_IO=3Dy
> > > > # CONFIG_FB_SVGALIB is not set
> > > > CONFIG_FB_MACMODES=3Dy
> > > > CONFIG_FB_BACKLIGHT=3Dy
> > > > CONFIG_FB_MODE_HELPERS=3Dy
> > > > CONFIG_FB_TILEBLITTING=3Dy
> > > >=20
> > > > #
> > > > # Frame buffer hardware drivers
> > > > #
> > > > # CONFIG_FB_CIRRUS is not set
> > > > # CONFIG_FB_PM2 is not set
> > > > # CONFIG_FB_CYBER2000 is not set
> > > > # CONFIG_FB_OF is not set
> > > > # CONFIG_FB_CONTROL is not set
> > > > # CONFIG_FB_PLATINUM is not set
> > > > # CONFIG_FB_VALKYRIE is not set
> > > > # CONFIG_FB_CT65550 is not set
> > > > # CONFIG_FB_ASILIANT is not set
> > > > # CONFIG_FB_IMSTT is not set
> > > > # CONFIG_FB_VGA16 is not set
> > > > # CONFIG_FB_OPENCORES is not set
> > > > # CONFIG_FB_S1D13XXX is not set
> > > > # CONFIG_FB_NVIDIA is not set
> > > > # CONFIG_FB_RIVA is not set
> > > > # CONFIG_FB_I740 is not set
> > > > CONFIG_FB_MATROX=3Dm
> > > > CONFIG_FB_MATROX_MILLENIUM=3Dy
> > > > CONFIG_FB_MATROX_MYSTIQUE=3Dy
> > > > CONFIG_FB_MATROX_G=3Dy
> > > > CONFIG_FB_MATROX_I2C=3Dm
> > > > CONFIG_FB_MATROX_MAVEN=3Dm
> > > > # CONFIG_FB_RADEON is not set
> > > > CONFIG_FB_ATY128=3Dy
> > > > CONFIG_FB_ATY128_BACKLIGHT=3Dy
> > > > CONFIG_FB_ATY=3Dm
> > > > CONFIG_FB_ATY_CT=3Dy
> > > > # CONFIG_FB_ATY_GENERIC_LCD is not set
> > > > CONFIG_FB_ATY_GX=3Dy
> > > > CONFIG_FB_ATY_BACKLIGHT=3Dy
> > > > # CONFIG_FB_S3 is not set
> > > > # CONFIG_FB_SAVAGE is not set
> > > > # CONFIG_FB_SIS is not set
> > > > # CONFIG_FB_NEOMAGIC is not set
> > > > # CONFIG_FB_KYRO is not set
> > > > # CONFIG_FB_3DFX is not set
> > > > # CONFIG_FB_VOODOO1 is not set
> > > > # CONFIG_FB_VT8623 is not set
> > > > # CONFIG_FB_TRIDENT is not set
> > > > # CONFIG_FB_ARK is not set
> > > > # CONFIG_FB_PM3 is not set
> > > > # CONFIG_FB_CARMINE is not set
> > > > # CONFIG_FB_SMSCUFX is not set
> > > > # CONFIG_FB_UDL is not set
> > > > # CONFIG_FB_IBM_GXT4500 is not set
> > > > # CONFIG_FB_VIRTUAL is not set
> > > > # CONFIG_FB_METRONOME is not set
> > > > # CONFIG_FB_MB862XX is not set
> > > > # CONFIG_FB_BROADSHEET is not set
> > > > # CONFIG_FB_AUO_K190X is not set
> > > > # CONFIG_FB_SIMPLE is not set
> > > > # CONFIG_FB_SM712 is not set
> > > > CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
> > > > # CONFIG_LCD_CLASS_DEVICE is not set
> > > > CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
> > > > # CONFIG_BACKLIGHT_GENERIC is not set
> > > > # CONFIG_BACKLIGHT_PM8941_WLED is not set
> > > > # CONFIG_BACKLIGHT_ADP8860 is not set
> > > > # CONFIG_BACKLIGHT_ADP8870 is not set
> > > > # CONFIG_BACKLIGHT_LM3639 is not set
> > > > # CONFIG_BACKLIGHT_LV5207LP is not set
> > > > # CONFIG_BACKLIGHT_BD6107 is not set
> > > > # CONFIG_BACKLIGHT_ARCXCNN is not set
> > > > # CONFIG_VGASTATE is not set
> > > > CONFIG_HDMI=3Dy
> > > >=20
> > > > #
> > > > # Console display driver support
> > > > #
> > > > # CONFIG_VGA_CONSOLE is not set
> > > > CONFIG_DUMMY_CONSOLE=3Dy
> > > > CONFIG_DUMMY_CONSOLE_COLUMNS=3D80
> > > > CONFIG_DUMMY_CONSOLE_ROWS=3D25
> > > > CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> > > > CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy
> > > > # CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
> > > > CONFIG_LOGO=3Dy
> > > > # CONFIG_LOGO_LINUX_MONO is not set
> > > > # CONFIG_LOGO_LINUX_VGA16 is not set
> > > > CONFIG_LOGO_LINUX_CLUT224=3Dy
> > > > CONFIG_SOUND=3Dm
> > > > CONFIG_SOUND_OSS_CORE=3Dy
> > > > CONFIG_SOUND_OSS_CORE_PRECLAIM=3Dy
> > > > CONFIG_SND=3Dm
> > > > CONFIG_SND_TIMER=3Dm
> > > > CONFIG_SND_PCM=3Dm
> > > > CONFIG_SND_SEQ_DEVICE=3Dm
> > > > CONFIG_SND_OSSEMUL=3Dy
> > > > CONFIG_SND_MIXER_OSS=3Dm
> > > > CONFIG_SND_PCM_OSS=3Dm
> > > > CONFIG_SND_PCM_OSS_PLUGINS=3Dy
> > > > CONFIG_SND_PCM_TIMER=3Dy
> > > > CONFIG_SND_HRTIMER=3Dm
> > > > CONFIG_SND_DYNAMIC_MINORS=3Dy
> > > > CONFIG_SND_MAX_CARDS=3D32
> > > > CONFIG_SND_SUPPORT_OLD_API=3Dy
> > > > CONFIG_SND_PROC_FS=3Dy
> > > > CONFIG_SND_VERBOSE_PROCFS=3Dy
> > > > CONFIG_SND_VERBOSE_PRINTK=3Dy
> > > > # CONFIG_SND_DEBUG is not set
> > > > CONFIG_SND_VMASTER=3Dy
> > > > CONFIG_SND_SEQUENCER=3Dm
> > > > # CONFIG_SND_SEQ_DUMMY is not set
> > > > CONFIG_SND_SEQUENCER_OSS=3Dm
> > > > CONFIG_SND_SEQ_HRTIMER_DEFAULT=3Dy
> > > > CONFIG_SND_SEQ_MIDI_EVENT=3Dm
> > > > # CONFIG_SND_OPL3_LIB_SEQ is not set
> > > > # CONFIG_SND_OPL4_LIB_SEQ is not set
> > > > CONFIG_SND_DRIVERS=3Dy
> > > > CONFIG_SND_DUMMY=3Dm
> > > > CONFIG_SND_ALOOP=3Dm
> > > > # CONFIG_SND_VIRMIDI is not set
> > > > # CONFIG_SND_MTPAV is not set
> > > > # CONFIG_SND_SERIAL_U16550 is not set
> > > > # CONFIG_SND_MPU401 is not set
> > > > # CONFIG_SND_PCI is not set
> > > >=20
> > > > #
> > > > # HD-Audio
> > > > #
> > > > CONFIG_SND_HDA_PREALLOC_SIZE=3D64
> > > > CONFIG_SND_PPC=3Dy
> > > > CONFIG_SND_POWERMAC=3Dm
> > > > CONFIG_SND_POWERMAC_AUTO_DRC=3Dy
> > > > CONFIG_SND_AOA=3Dm
> > > > CONFIG_SND_AOA_FABRIC_LAYOUT=3Dm
> > > > CONFIG_SND_AOA_ONYX=3Dm
> > > > CONFIG_SND_AOA_TAS=3Dm
> > > > CONFIG_SND_AOA_TOONIE=3Dm
> > > > CONFIG_SND_AOA_SOUNDBUS=3Dm
> > > > CONFIG_SND_AOA_SOUNDBUS_I2S=3Dm
> > > > # CONFIG_SND_USB is not set
> > > > # CONFIG_SND_FIREWIRE is not set
> > > > # CONFIG_SND_SOC is not set
> > > >=20
> > > > #
> > > > # HID support
> > > > #
> > > > CONFIG_HID=3Dm
> > > > # CONFIG_HID_BATTERY_STRENGTH is not set
> > > > CONFIG_HIDRAW=3Dy
> > > > CONFIG_UHID=3Dm
> > > > CONFIG_HID_GENERIC=3Dm
> > > >=20
> > > > #
> > > > # Special HID drivers
> > > > #
> > > > # CONFIG_HID_A4TECH is not set
> > > > # CONFIG_HID_ACCUTOUCH is not set
> > > > # CONFIG_HID_ACRUX is not set
> > > > # CONFIG_HID_APPLE is not set
> > > > # CONFIG_HID_APPLEIR is not set
> > > > # CONFIG_HID_AUREAL is not set
> > > > # CONFIG_HID_BELKIN is not set
> > > > # CONFIG_HID_BETOP_FF is not set
> > > > # CONFIG_HID_CHERRY is not set
> > > > # CONFIG_HID_CHICONY is not set
> > > > # CONFIG_HID_PRODIKEYS is not set
> > > > # CONFIG_HID_CMEDIA is not set
> > > > # CONFIG_HID_CYPRESS is not set
> > > > # CONFIG_HID_DRAGONRISE is not set
> > > > # CONFIG_HID_EMS_FF is not set
> > > > # CONFIG_HID_ELECOM is not set
> > > > # CONFIG_HID_ELO is not set
> > > > # CONFIG_HID_EZKEY is not set
> > > > # CONFIG_HID_GEMBIRD is not set
> > > > # CONFIG_HID_GFRM is not set
> > > > # CONFIG_HID_HOLTEK is not set
> > > > # CONFIG_HID_KEYTOUCH is not set
> > > > # CONFIG_HID_KYE is not set
> > > > # CONFIG_HID_UCLOGIC is not set
> > > > # CONFIG_HID_WALTOP is not set
> > > > # CONFIG_HID_GYRATION is not set
> > > > # CONFIG_HID_ICADE is not set
> > > > # CONFIG_HID_ITE is not set
> > > > # CONFIG_HID_TWINHAN is not set
> > > > # CONFIG_HID_KENSINGTON is not set
> > > > # CONFIG_HID_LCPOWER is not set
> > > > # CONFIG_HID_LENOVO is not set
> > > > # CONFIG_HID_LOGITECH is not set
> > > > # CONFIG_HID_MAGICMOUSE is not set
> > > > # CONFIG_HID_MAYFLASH is not set
> > > > # CONFIG_HID_MICROSOFT is not set
> > > > # CONFIG_HID_MONTEREY is not set
> > > > # CONFIG_HID_MULTITOUCH is not set
> > > > # CONFIG_HID_NTI is not set
> > > > # CONFIG_HID_NTRIG is not set
> > > > # CONFIG_HID_ORTEK is not set
> > > > # CONFIG_HID_PANTHERLORD is not set
> > > > # CONFIG_HID_PENMOUNT is not set
> > > > # CONFIG_HID_PETALYNX is not set
> > > > # CONFIG_HID_PICOLCD is not set
> > > > # CONFIG_HID_PLANTRONICS is not set
> > > > # CONFIG_HID_PRIMAX is not set
> > > > # CONFIG_HID_RETRODE is not set
> > > > # CONFIG_HID_ROCCAT is not set
> > > > # CONFIG_HID_SAITEK is not set
> > > > # CONFIG_HID_SAMSUNG is not set
> > > > # CONFIG_HID_SPEEDLINK is not set
> > > > # CONFIG_HID_STEELSERIES is not set
> > > > # CONFIG_HID_SUNPLUS is not set
> > > > # CONFIG_HID_RMI is not set
> > > > # CONFIG_HID_GREENASIA is not set
> > > > # CONFIG_HID_SMARTJOYPLUS is not set
> > > > # CONFIG_HID_TIVO is not set
> > > > # CONFIG_HID_TOPSEED is not set
> > > > # CONFIG_HID_THRUSTMASTER is not set
> > > > # CONFIG_HID_UDRAW_PS3 is not set
> > > > # CONFIG_HID_WACOM is not set
> > > > # CONFIG_HID_XINMO is not set
> > > > # CONFIG_HID_ZEROPLUS is not set
> > > > # CONFIG_HID_ZYDACRON is not set
> > > > # CONFIG_HID_SENSOR_HUB is not set
> > > > # CONFIG_HID_ALPS is not set
> > > >=20
> > > > #
> > > > # USB HID support
> > > > #
> > > > CONFIG_USB_HID=3Dm
> > > > CONFIG_HID_PID=3Dy
> > > > CONFIG_USB_HIDDEV=3Dy
> > > >=20
> > > > #
> > > > # I2C HID support
> > > > #
> > > > # CONFIG_I2C_HID is not set
> > > > CONFIG_USB_OHCI_BIG_ENDIAN_DESC=3Dy
> > > > CONFIG_USB_OHCI_BIG_ENDIAN_MMIO=3Dy
> > > > CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
> > > > CONFIG_USB_SUPPORT=3Dy
> > > > CONFIG_USB_COMMON=3Dy
> > > > CONFIG_USB_ARCH_HAS_HCD=3Dy
> > > > CONFIG_USB=3Dy
> > > > CONFIG_USB_PCI=3Dy
> > > > CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy
> > > >=20
> > > > #
> > > > # Miscellaneous USB options
> > > > #
> > > > CONFIG_USB_DEFAULT_PERSIST=3Dy
> > > > CONFIG_USB_DYNAMIC_MINORS=3Dy
> > > > # CONFIG_USB_OTG is not set
> > > > # CONFIG_USB_OTG_WHITELIST is not set
> > > > CONFIG_USB_MON=3Dm
> > > > # CONFIG_USB_WUSB_CBAF is not set
> > > >=20
> > > > #
> > > > # USB Host Controller Drivers
> > > > #
> > > > # CONFIG_USB_C67X00_HCD is not set
> > > > # CONFIG_USB_XHCI_HCD is not set
> > > > CONFIG_USB_EHCI_HCD=3Dm
> > > > CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
> > > > CONFIG_USB_EHCI_TT_NEWSCHED=3Dy
> > > > CONFIG_USB_EHCI_PCI=3Dm
> > > > # CONFIG_XPS_USB_HCD_XILINX is not set
> > > > CONFIG_USB_EHCI_HCD_PPC_OF=3Dy
> > > > # CONFIG_USB_EHCI_HCD_PLATFORM is not set
> > > > # CONFIG_USB_OXU210HP_HCD is not set
> > > > # CONFIG_USB_ISP116X_HCD is not set
> > > > # CONFIG_USB_ISP1362_HCD is not set
> > > > # CONFIG_USB_FOTG210_HCD is not set
> > > > CONFIG_USB_OHCI_HCD=3Dy
> > > > CONFIG_USB_OHCI_HCD_PPC_OF_BE=3Dy
> > > > CONFIG_USB_OHCI_HCD_PPC_OF_LE=3Dy
> > > > CONFIG_USB_OHCI_HCD_PPC_OF=3Dy
> > > > CONFIG_USB_OHCI_HCD_PCI=3Dy
> > > > # CONFIG_USB_OHCI_HCD_PLATFORM is not set
> > > > CONFIG_USB_UHCI_HCD=3Dm
> > > > # CONFIG_USB_SL811_HCD is not set
> > > > # CONFIG_USB_R8A66597_HCD is not set
> > > > # CONFIG_USB_HCD_BCMA is not set
> > > > # CONFIG_USB_HCD_SSB is not set
> > > > # CONFIG_USB_HCD_TEST_MODE is not set
> > > >=20
> > > > #
> > > > # USB Device Class drivers
> > > > #
> > > > CONFIG_USB_ACM=3Dm
> > > > CONFIG_USB_PRINTER=3Dm
> > > > CONFIG_USB_WDM=3Dm
> > > > CONFIG_USB_TMC=3Dm
> > > >=20
> > > > #
> > > > # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> > > > #
> > > >=20
> > > > #
> > > > # also be needed; see USB_STORAGE Help for more info
> > > > #
> > > > CONFIG_USB_STORAGE=3Dm
> > > > # CONFIG_USB_STORAGE_DEBUG is not set
> > > > CONFIG_USB_STORAGE_REALTEK=3Dm
> > > > CONFIG_REALTEK_AUTOPM=3Dy
> > > > CONFIG_USB_STORAGE_DATAFAB=3Dm
> > > > CONFIG_USB_STORAGE_FREECOM=3Dm
> > > > CONFIG_USB_STORAGE_ISD200=3Dm
> > > > CONFIG_USB_STORAGE_USBAT=3Dm
> > > > CONFIG_USB_STORAGE_SDDR09=3Dm
> > > > CONFIG_USB_STORAGE_SDDR55=3Dm
> > > > CONFIG_USB_STORAGE_JUMPSHOT=3Dm
> > > > CONFIG_USB_STORAGE_ALAUDA=3Dm
> > > > CONFIG_USB_STORAGE_ONETOUCH=3Dm
> > > > CONFIG_USB_STORAGE_KARMA=3Dm
> > > > CONFIG_USB_STORAGE_CYPRESS_ATACB=3Dm
> > > > CONFIG_USB_STORAGE_ENE_UB6250=3Dm
> > > > CONFIG_USB_UAS=3Dm
> > > >=20
> > > > #
> > > > # USB Imaging devices
> > > > #
> > > > CONFIG_USB_MDC800=3Dm
> > > > CONFIG_USB_MICROTEK=3Dm
> > > > # CONFIG_USBIP_CORE is not set
> > > > # CONFIG_USB_MUSB_HDRC is not set
> > > > # CONFIG_USB_DWC3 is not set
> > > > # CONFIG_USB_DWC2 is not set
> > > > # CONFIG_USB_CHIPIDEA is not set
> > > > # CONFIG_USB_ISP1760 is not set
> > > >=20
> > > > #
> > > > # USB port drivers
> > > > #
> > > > CONFIG_USB_SERIAL=3Dm
> > > > CONFIG_USB_SERIAL_GENERIC=3Dy
> > > > CONFIG_USB_SERIAL_SIMPLE=3Dm
> > > > CONFIG_USB_SERIAL_AIRCABLE=3Dm
> > > > CONFIG_USB_SERIAL_ARK3116=3Dm
> > > > CONFIG_USB_SERIAL_BELKIN=3Dm
> > > > CONFIG_USB_SERIAL_CH341=3Dm
> > > > CONFIG_USB_SERIAL_WHITEHEAT=3Dm
> > > > CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm
> > > > CONFIG_USB_SERIAL_CP210X=3Dm
> > > > CONFIG_USB_SERIAL_CYPRESS_M8=3Dm
> > > > CONFIG_USB_SERIAL_EMPEG=3Dm
> > > > CONFIG_USB_SERIAL_FTDI_SIO=3Dm
> > > > CONFIG_USB_SERIAL_VISOR=3Dm
> > > > CONFIG_USB_SERIAL_IPAQ=3Dm
> > > > CONFIG_USB_SERIAL_IR=3Dm
> > > > CONFIG_USB_SERIAL_EDGEPORT=3Dm
> > > > CONFIG_USB_SERIAL_EDGEPORT_TI=3Dm
> > > > CONFIG_USB_SERIAL_F81232=3Dm
> > > > CONFIG_USB_SERIAL_F8153X=3Dm
> > > > CONFIG_USB_SERIAL_GARMIN=3Dm
> > > > CONFIG_USB_SERIAL_IPW=3Dm
> > > > CONFIG_USB_SERIAL_IUU=3Dm
> > > > CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm
> > > > CONFIG_USB_SERIAL_KEYSPAN=3Dm
> > > > CONFIG_USB_SERIAL_KLSI=3Dm
> > > > CONFIG_USB_SERIAL_KOBIL_SCT=3Dm
> > > > CONFIG_USB_SERIAL_MCT_U232=3Dm
> > > > # CONFIG_USB_SERIAL_METRO is not set
> > > > CONFIG_USB_SERIAL_MOS7720=3Dm
> > > > CONFIG_USB_SERIAL_MOS7840=3Dm
> > > > CONFIG_USB_SERIAL_MXUPORT=3Dm
> > > > CONFIG_USB_SERIAL_NAVMAN=3Dm
> > > > CONFIG_USB_SERIAL_PL2303=3Dm
> > > > CONFIG_USB_SERIAL_OTI6858=3Dm
> > > > CONFIG_USB_SERIAL_QCAUX=3Dm
> > > > CONFIG_USB_SERIAL_QUALCOMM=3Dm
> > > > CONFIG_USB_SERIAL_SPCP8X5=3Dm
> > > > CONFIG_USB_SERIAL_SAFE=3Dm
> > > > CONFIG_USB_SERIAL_SAFE_PADDED=3Dy
> > > > CONFIG_USB_SERIAL_SIERRAWIRELESS=3Dm
> > > > CONFIG_USB_SERIAL_SYMBOL=3Dm
> > > > CONFIG_USB_SERIAL_TI=3Dm
> > > > CONFIG_USB_SERIAL_CYBERJACK=3Dm
> > > > CONFIG_USB_SERIAL_XIRCOM=3Dm
> > > > CONFIG_USB_SERIAL_WWAN=3Dm
> > > > CONFIG_USB_SERIAL_OPTION=3Dm
> > > > CONFIG_USB_SERIAL_OMNINET=3Dm
> > > > CONFIG_USB_SERIAL_OPTICON=3Dm
> > > > # CONFIG_USB_SERIAL_XSENS_MT is not set
> > > > # CONFIG_USB_SERIAL_WISHBONE is not set
> > > > CONFIG_USB_SERIAL_SSU100=3Dm
> > > > CONFIG_USB_SERIAL_QT2=3Dm
> > > > CONFIG_USB_SERIAL_UPD78F0730=3Dm
> > > > CONFIG_USB_SERIAL_DEBUG=3Dm
> > > >=20
> > > > #
> > > > # USB Miscellaneous drivers
> > > > #
> > > > # CONFIG_USB_EMI62 is not set
> > > > # CONFIG_USB_EMI26 is not set
> > > > # CONFIG_USB_ADUTUX is not set
> > > > # CONFIG_USB_SEVSEG is not set
> > > > # CONFIG_USB_RIO500 is not set
> > > > # CONFIG_USB_LEGOTOWER is not set
> > > > # CONFIG_USB_LCD is not set
> > > > # CONFIG_USB_CYPRESS_CY7C63 is not set
> > > > # CONFIG_USB_CYTHERM is not set
> > > > # CONFIG_USB_IDMOUSE is not set
> > > > # CONFIG_USB_FTDI_ELAN is not set
> > > > CONFIG_USB_APPLEDISPLAY=3Dm
> > > > # CONFIG_USB_SISUSBVGA is not set
> > > > # CONFIG_USB_LD is not set
> > > > # CONFIG_USB_TRANCEVIBRATOR is not set
> > > > # CONFIG_USB_IOWARRIOR is not set
> > > > # CONFIG_USB_TEST is not set
> > > > # CONFIG_USB_EHSET_TEST_FIXTURE is not set
> > > > # CONFIG_USB_ISIGHTFW is not set
> > > > # CONFIG_USB_YUREX is not set
> > > > CONFIG_USB_EZUSB_FX2=3Dm
> > > > # CONFIG_USB_HUB_USB251XB is not set
> > > > # CONFIG_USB_HSIC_USB3503 is not set
> > > > # CONFIG_USB_HSIC_USB4604 is not set
> > > > # CONFIG_USB_LINK_LAYER_TEST is not set
> > > > # CONFIG_USB_CHAOSKEY is not set
> > > >=20
> > > > #
> > > > # USB Physical Layer drivers
> > > > #
> > > > # CONFIG_USB_PHY is not set
> > > > # CONFIG_NOP_USB_XCEIV is not set
> > > > # CONFIG_USB_ISP1301 is not set
> > > > # CONFIG_USB_GADGET is not set
> > > >=20
> > > > #
> > > > # USB Power Delivery and Type-C drivers
> > > > #
> > > > # CONFIG_USB_ULPI_BUS is not set
> > > > # CONFIG_UWB is not set
> > > > # CONFIG_MMC is not set
> > > > # CONFIG_MEMSTICK is not set
> > > > # CONFIG_NEW_LEDS is not set
> > > > # CONFIG_ACCESSIBILITY is not set
> > > > # CONFIG_INFINIBAND is not set
> > > > CONFIG_EDAC_ATOMIC_SCRUB=3Dy
> > > > CONFIG_EDAC_SUPPORT=3Dy
> > > > CONFIG_RTC_LIB=3Dy
> > > > CONFIG_RTC_CLASS=3Dy
> > > > CONFIG_RTC_HCTOSYS=3Dy
> > > > CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
> > > > CONFIG_RTC_SYSTOHC=3Dy
> > > > CONFIG_RTC_SYSTOHC_DEVICE=3D"rtc0"
> > > > # CONFIG_RTC_DEBUG is not set
> > > > CONFIG_RTC_NVMEM=3Dy
> > > >=20
> > > > #
> > > > # RTC interfaces
> > > > #
> > > > CONFIG_RTC_INTF_SYSFS=3Dy
> > > > CONFIG_RTC_INTF_PROC=3Dy
> > > > CONFIG_RTC_INTF_DEV=3Dy
> > > > CONFIG_RTC_INTF_DEV_UIE_EMUL=3Dy
> > > > # CONFIG_RTC_DRV_TEST is not set
> > > >=20
> > > > #
> > > > # I2C RTC drivers
> > > > #
> > > > # CONFIG_RTC_DRV_ABB5ZES3 is not set
> > > > # CONFIG_RTC_DRV_ABX80X is not set
> > > > # CONFIG_RTC_DRV_DS1307 is not set
> > > > # CONFIG_RTC_DRV_DS1374 is not set
> > > > # CONFIG_RTC_DRV_DS1672 is not set
> > > > # CONFIG_RTC_DRV_HYM8563 is not set
> > > > # CONFIG_RTC_DRV_MAX6900 is not set
> > > > # CONFIG_RTC_DRV_RS5C372 is not set
> > > > # CONFIG_RTC_DRV_ISL1208 is not set
> > > > # CONFIG_RTC_DRV_ISL12022 is not set
> > > > # CONFIG_RTC_DRV_X1205 is not set
> > > > # CONFIG_RTC_DRV_PCF8523 is not set
> > > > # CONFIG_RTC_DRV_PCF85063 is not set
> > > > # CONFIG_RTC_DRV_PCF8563 is not set
> > > > # CONFIG_RTC_DRV_PCF8583 is not set
> > > > # CONFIG_RTC_DRV_M41T80 is not set
> > > > # CONFIG_RTC_DRV_BQ32K is not set
> > > > # CONFIG_RTC_DRV_S35390A is not set
> > > > # CONFIG_RTC_DRV_FM3130 is not set
> > > > # CONFIG_RTC_DRV_RX8010 is not set
> > > > # CONFIG_RTC_DRV_RX8581 is not set
> > > > # CONFIG_RTC_DRV_RX8025 is not set
> > > > # CONFIG_RTC_DRV_EM3027 is not set
> > > > # CONFIG_RTC_DRV_RV8803 is not set
> > > >=20
> > > > #
> > > > # SPI RTC drivers
> > > > #
> > > > CONFIG_RTC_I2C_AND_SPI=3Dy
> > > >=20
> > > > #
> > > > # SPI and I2C RTC drivers
> > > > #
> > > > # CONFIG_RTC_DRV_DS3232 is not set
> > > > # CONFIG_RTC_DRV_PCF2127 is not set
> > > > # CONFIG_RTC_DRV_RV3029C2 is not set
> > > >=20
> > > > #
> > > > # Platform RTC drivers
> > > > #
> > > > # CONFIG_RTC_DRV_CMOS is not set
> > > > # CONFIG_RTC_DRV_DS1286 is not set
> > > > # CONFIG_RTC_DRV_DS1511 is not set
> > > > # CONFIG_RTC_DRV_DS1553 is not set
> > > > # CONFIG_RTC_DRV_DS1685_FAMILY is not set
> > > > # CONFIG_RTC_DRV_DS1742 is not set
> > > > # CONFIG_RTC_DRV_DS2404 is not set
> > > > # CONFIG_RTC_DRV_STK17TA8 is not set
> > > > # CONFIG_RTC_DRV_M48T86 is not set
> > > > # CONFIG_RTC_DRV_M48T35 is not set
> > > > # CONFIG_RTC_DRV_M48T59 is not set
> > > > # CONFIG_RTC_DRV_MSM6242 is not set
> > > > # CONFIG_RTC_DRV_BQ4802 is not set
> > > > # CONFIG_RTC_DRV_RP5C01 is not set
> > > > # CONFIG_RTC_DRV_V3020 is not set
> > > > # CONFIG_RTC_DRV_ZYNQMP is not set
> > > >=20
> > > > #
> > > > # on-CPU RTC drivers
> > > > #
> > > > CONFIG_RTC_DRV_GENERIC=3Dy
> > > > # CONFIG_RTC_DRV_FTRTC010 is not set
> > > > # CONFIG_RTC_DRV_SNVS is not set
> > > > # CONFIG_RTC_DRV_R7301 is not set
> > > >=20
> > > > #
> > > > # HID Sensor RTC drivers
> > > > #
> > > > # CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
> > > > # CONFIG_DMADEVICES is not set
> > > >=20
> > > > #
> > > > # DMABUF options
> > > > #
> > > > CONFIG_SYNC_FILE=3Dy
> > > > # CONFIG_SW_SYNC is not set
> > > > # CONFIG_AUXDISPLAY is not set
> > > > # CONFIG_UIO is not set
> > > > # CONFIG_VIRT_DRIVERS is not set
> > > >=20
> > > > #
> > > > # Virtio drivers
> > > > #
> > > > # CONFIG_VIRTIO_PCI is not set
> > > > # CONFIG_VIRTIO_MMIO is not set
> > > >=20
> > > > #
> > > > # Microsoft Hyper-V guest support
> > > > #
> > > > # CONFIG_HYPERV_TSCPAGE is not set
> > > > # CONFIG_STAGING is not set
> > > > # CONFIG_HWSPINLOCK is not set
> > > >=20
> > > > #
> > > > # Clock Source drivers
> > > > #
> > > > # CONFIG_ATMEL_PIT is not set
> > > > # CONFIG_SH_TIMER_CMT is not set
> > > > # CONFIG_SH_TIMER_MTU2 is not set
> > > > # CONFIG_SH_TIMER_TMU is not set
> > > > # CONFIG_EM_TIMER_STI is not set
> > > > # CONFIG_MAILBOX is not set
> > > > # CONFIG_IOMMU_SUPPORT is not set
> > > >=20
> > > > #
> > > > # Remoteproc drivers
> > > > #
> > > > # CONFIG_REMOTEPROC is not set
> > > >=20
> > > > #
> > > > # Rpmsg drivers
> > > > #
> > > >=20
> > > > #
> > > > # SOC (System On Chip) specific Drivers
> > > > #
> > > >=20
> > > > #
> > > > # Broadcom SoC drivers
> > > > #
> > > >=20
> > > > #
> > > > # i.MX SoC drivers
> > > > #
> > > > # CONFIG_SUNXI_SRAM is not set
> > > > # CONFIG_SOC_TI is not set
> > > > # CONFIG_SOC_ZTE is not set
> > > > # CONFIG_PM_DEVFREQ is not set
> > > > # CONFIG_EXTCON is not set
> > > > # CONFIG_MEMORY is not set
> > > > # CONFIG_IIO is not set
> > > > # CONFIG_NTB is not set
> > > > # CONFIG_VME_BUS is not set
> > > > # CONFIG_PWM is not set
> > > > CONFIG_IRQCHIP=3Dy
> > > > CONFIG_ARM_GIC_MAX_NR=3D1
> > > > # CONFIG_IPACK_BUS is not set
> > > > # CONFIG_RESET_CONTROLLER is not set
> > > > # CONFIG_FMC is not set
> > > >=20
> > > > #
> > > > # PHY Subsystem
> > > > #
> > > > CONFIG_GENERIC_PHY=3Dy
> > > > # CONFIG_BCM_KONA_USB2_PHY is not set
> > > > # CONFIG_PHY_PXA_28NM_HSIC is not set
> > > > # CONFIG_PHY_PXA_28NM_USB2 is not set
> > > > # CONFIG_POWERCAP is not set
> > > > # CONFIG_MCB is not set
> > > > # CONFIG_RAS is not set
> > > >=20
> > > > #
> > > > # Android
> > > > #
> > > > # CONFIG_ANDROID is not set
> > > > # CONFIG_DAX is not set
> > > > CONFIG_NVMEM=3Dy
> > > > # CONFIG_STM is not set
> > > > # CONFIG_INTEL_TH is not set
> > > >=20
> > > > #
> > > > # FPGA Configuration Support
> > > > #
> > > > # CONFIG_FPGA is not set
> > > >=20
> > > > #
> > > > # FSI support
> > > > #
> > > > # CONFIG_FSI is not set
> > > >=20
> > > > #
> > > > # File systems
> > > > #
> > > > # CONFIG_EXT2_FS is not set
> > > > # CONFIG_EXT3_FS is not set
> > > > CONFIG_EXT4_FS=3Dy
> > > > CONFIG_EXT4_USE_FOR_EXT2=3Dy
> > > > CONFIG_EXT4_FS_POSIX_ACL=3Dy
> > > > CONFIG_EXT4_FS_SECURITY=3Dy
> > > > # CONFIG_EXT4_ENCRYPTION is not set
> > > > # CONFIG_EXT4_DEBUG is not set
> > > > CONFIG_JBD2=3Dy
> > > > # CONFIG_JBD2_DEBUG is not set
> > > > CONFIG_FS_MBCACHE=3Dy
> > > > # CONFIG_REISERFS_FS is not set
> > > > # CONFIG_JFS_FS is not set
> > > > # CONFIG_XFS_FS is not set
> > > > # CONFIG_GFS2_FS is not set
> > > > # CONFIG_BTRFS_FS is not set
> > > > # CONFIG_NILFS2_FS is not set
> > > > # CONFIG_F2FS_FS is not set
> > > > # CONFIG_FS_DAX is not set
> > > > CONFIG_FS_POSIX_ACL=3Dy
> > > > CONFIG_EXPORTFS=3Dy
> > > > CONFIG_EXPORTFS_BLOCK_OPS=3Dy
> > > > CONFIG_FILE_LOCKING=3Dy
> > > > CONFIG_MANDATORY_FILE_LOCKING=3Dy
> > > > # CONFIG_FS_ENCRYPTION is not set
> > > > CONFIG_FSNOTIFY=3Dy
> > > > CONFIG_DNOTIFY=3Dy
> > > > CONFIG_INOTIFY_USER=3Dy
> > > > CONFIG_FANOTIFY=3Dy
> > > > # CONFIG_QUOTA is not set
> > > > # CONFIG_QUOTACTL is not set
> > > > CONFIG_AUTOFS4_FS=3Dm
> > > > CONFIG_FUSE_FS=3Dm
> > > > CONFIG_CUSE=3Dm
> > > > CONFIG_OVERLAY_FS=3Dm
> > > > CONFIG_OVERLAY_FS_REDIRECT_DIR=3Dy
> > > > CONFIG_OVERLAY_FS_INDEX=3Dy
> > > >=20
> > > > #
> > > > # Caches
> > > > #
> > > > # CONFIG_FSCACHE is not set
> > > >=20
> > > > #
> > > > # CD-ROM/DVD Filesystems
> > > > #
> > > > CONFIG_ISO9660_FS=3Dm
> > > > CONFIG_JOLIET=3Dy
> > > > CONFIG_ZISOFS=3Dy
> > > > CONFIG_UDF_FS=3Dm
> > > > CONFIG_UDF_NLS=3Dy
> > > >=20
> > > > #
> > > > # DOS/FAT/NT Filesystems
> > > > #
> > > > CONFIG_FAT_FS=3Dm
> > > > CONFIG_MSDOS_FS=3Dm
> > > > CONFIG_VFAT_FS=3Dm
> > > > CONFIG_FAT_DEFAULT_CODEPAGE=3D437
> > > > CONFIG_FAT_DEFAULT_IOCHARSET=3D"utf8"
> > > > CONFIG_FAT_DEFAULT_UTF8=3Dy
> > > > CONFIG_NTFS_FS=3Dm
> > > > # CONFIG_NTFS_DEBUG is not set
> > > > CONFIG_NTFS_RW=3Dy
> > > >=20
> > > > #
> > > > # Pseudo filesystems
> > > > #
> > > > CONFIG_PROC_FS=3Dy
> > > > CONFIG_PROC_KCORE=3Dy
> > > > CONFIG_PROC_SYSCTL=3Dy
> > > > CONFIG_PROC_PAGE_MONITOR=3Dy
> > > > # CONFIG_PROC_CHILDREN is not set
> > > > CONFIG_KERNFS=3Dy
> > > > CONFIG_SYSFS=3Dy
> > > > CONFIG_TMPFS=3Dy
> > > > CONFIG_TMPFS_POSIX_ACL=3Dy
> > > > CONFIG_TMPFS_XATTR=3Dy
> > > > # CONFIG_HUGETLB_PAGE is not set
> > > > # CONFIG_CONFIGFS_FS is not set
> > > > CONFIG_MISC_FILESYSTEMS=3Dy
> > > > # CONFIG_ORANGEFS_FS is not set
> > > > # CONFIG_ADFS_FS is not set
> > > > # CONFIG_AFFS_FS is not set
> > > > CONFIG_HFS_FS=3Dm
> > > > CONFIG_HFSPLUS_FS=3Dm
> > > > CONFIG_HFSPLUS_FS_POSIX_ACL=3Dy
> > > > # CONFIG_BEFS_FS is not set
> > > > # CONFIG_BFS_FS is not set
> > > > # CONFIG_EFS_FS is not set
> > > > # CONFIG_CRAMFS is not set
> > > > # CONFIG_SQUASHFS is not set
> > > > # CONFIG_VXFS_FS is not set
> > > > # CONFIG_MINIX_FS is not set
> > > > # CONFIG_OMFS_FS is not set
> > > > # CONFIG_HPFS_FS is not set
> > > > # CONFIG_QNX4FS_FS is not set
> > > > # CONFIG_QNX6FS_FS is not set
> > > > # CONFIG_ROMFS_FS is not set
> > > > # CONFIG_PSTORE is not set
> > > > # CONFIG_SYSV_FS is not set
> > > > # CONFIG_UFS_FS is not set
> > > > # CONFIG_NETWORK_FILESYSTEMS is not set
> > > > CONFIG_NLS=3Dy
> > > > CONFIG_NLS_DEFAULT=3D"utf8"
> > > > CONFIG_NLS_CODEPAGE_437=3Dm
> > > > # CONFIG_NLS_CODEPAGE_737 is not set
> > > > # CONFIG_NLS_CODEPAGE_775 is not set
> > > > CONFIG_NLS_CODEPAGE_850=3Dm
> > > > # CONFIG_NLS_CODEPAGE_852 is not set
> > > > # CONFIG_NLS_CODEPAGE_855 is not set
> > > > # CONFIG_NLS_CODEPAGE_857 is not set
> > > > # CONFIG_NLS_CODEPAGE_860 is not set
> > > > # CONFIG_NLS_CODEPAGE_861 is not set
> > > > # CONFIG_NLS_CODEPAGE_862 is not set
> > > > # CONFIG_NLS_CODEPAGE_863 is not set
> > > > # CONFIG_NLS_CODEPAGE_864 is not set
> > > > # CONFIG_NLS_CODEPAGE_865 is not set
> > > > # CONFIG_NLS_CODEPAGE_866 is not set
> > > > # CONFIG_NLS_CODEPAGE_869 is not set
> > > > # CONFIG_NLS_CODEPAGE_936 is not set
> > > > # CONFIG_NLS_CODEPAGE_950 is not set
> > > > # CONFIG_NLS_CODEPAGE_932 is not set
> > > > # CONFIG_NLS_CODEPAGE_949 is not set
> > > > # CONFIG_NLS_CODEPAGE_874 is not set
> > > > # CONFIG_NLS_ISO8859_8 is not set
> > > > # CONFIG_NLS_CODEPAGE_1250 is not set
> > > > # CONFIG_NLS_CODEPAGE_1251 is not set
> > > > # CONFIG_NLS_ASCII is not set
> > > > CONFIG_NLS_ISO8859_1=3Dm
> > > > # CONFIG_NLS_ISO8859_2 is not set
> > > > # CONFIG_NLS_ISO8859_3 is not set
> > > > # CONFIG_NLS_ISO8859_4 is not set
> > > > # CONFIG_NLS_ISO8859_5 is not set
> > > > # CONFIG_NLS_ISO8859_6 is not set
> > > > # CONFIG_NLS_ISO8859_7 is not set
> > > > # CONFIG_NLS_ISO8859_9 is not set
> > > > # CONFIG_NLS_ISO8859_13 is not set
> > > > # CONFIG_NLS_ISO8859_14 is not set
> > > > # CONFIG_NLS_ISO8859_15 is not set
> > > > # CONFIG_NLS_KOI8_R is not set
> > > > # CONFIG_NLS_KOI8_U is not set
> > > > # CONFIG_NLS_MAC_ROMAN is not set
> > > > # CONFIG_NLS_MAC_CELTIC is not set
> > > > # CONFIG_NLS_MAC_CENTEURO is not set
> > > > # CONFIG_NLS_MAC_CROATIAN is not set
> > > > # CONFIG_NLS_MAC_CYRILLIC is not set
> > > > # CONFIG_NLS_MAC_GAELIC is not set
> > > > # CONFIG_NLS_MAC_GREEK is not set
> > > > # CONFIG_NLS_MAC_ICELAND is not set
> > > > # CONFIG_NLS_MAC_INUIT is not set
> > > > # CONFIG_NLS_MAC_ROMANIAN is not set
> > > > # CONFIG_NLS_MAC_TURKISH is not set
> > > > CONFIG_NLS_UTF8=3Dm
> > > > # CONFIG_BINARY_PRINTF is not set
> > > >=20
> > > > #
> > > > # Library routines
> > > > #
> > > > CONFIG_BITREVERSE=3Dy
> > > > # CONFIG_HAVE_ARCH_BITREVERSE is not set
> > > > CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy
> > > > CONFIG_GENERIC_STRNLEN_USER=3Dy
> > > > CONFIG_GENERIC_NET_UTILS=3Dy
> > > > CONFIG_GENERIC_PCI_IOMAP=3Dy
> > > > CONFIG_GENERIC_IO=3Dy
> > > > # CONFIG_CRC_CCITT is not set
> > > > CONFIG_CRC16=3Dy
> > > > # CONFIG_CRC_T10DIF is not set
> > > > CONFIG_CRC_ITU_T=3Dm
> > > > CONFIG_CRC32=3Dy
> > > > # CONFIG_CRC32_SELFTEST is not set
> > > > CONFIG_CRC32_SLICEBY8=3Dy
> > > > # CONFIG_CRC32_SLICEBY4 is not set
> > > > # CONFIG_CRC32_SARWATE is not set
> > > > # CONFIG_CRC32_BIT is not set
> > > > # CONFIG_CRC4 is not set
> > > > # CONFIG_CRC7 is not set
> > > > # CONFIG_LIBCRC32C is not set
> > > > # CONFIG_CRC8 is not set
> > > > # CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
> > > > # CONFIG_RANDOM32_SELFTEST is not set
> > > > CONFIG_ZLIB_INFLATE=3Dm
> > > > # CONFIG_XZ_DEC is not set
> > > > # CONFIG_XZ_DEC_BCJ is not set
> > > > CONFIG_INTERVAL_TREE=3Dy
> > > > CONFIG_HAS_IOMEM=3Dy
> > > > CONFIG_HAS_IOPORT_MAP=3Dy
> > > > CONFIG_HAS_DMA=3Dy
> > > > # CONFIG_DMA_NOOP_OPS is not set
> > > > # CONFIG_DMA_VIRT_OPS is not set
> > > > CONFIG_DQL=3Dy
> > > > CONFIG_GLOB=3Dy
> > > > # CONFIG_GLOB_SELFTEST is not set
> > > > CONFIG_NLATTR=3Dy
> > > > CONFIG_GENERIC_ATOMIC64=3Dy
> > > > # CONFIG_CORDIC is not set
> > > > # CONFIG_DDR is not set
> > > > # CONFIG_IRQ_POLL is not set
> > > > CONFIG_LIBFDT=3Dy
> > > > CONFIG_FONT_SUPPORT=3Dy
> > > > # CONFIG_FONTS is not set
> > > > CONFIG_FONT_8x8=3Dy
> > > > CONFIG_FONT_8x16=3Dy
> > > > # CONFIG_SG_SPLIT is not set
> > > > CONFIG_SG_POOL=3Dy
> > > > CONFIG_ARCH_HAS_SG_CHAIN=3Dy
> > > > CONFIG_SBITMAP=3Dy
> > > >=20
> > > > #
> > > > # Kernel hacking
> > > > #
> > > >=20
> > > > #
> > > > # printk and dmesg options
> > > > #
> > > > CONFIG_PRINTK_TIME=3Dy
> > > > CONFIG_CONSOLE_LOGLEVEL_DEFAULT=3D7
> > > > CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3D4
> > > > # CONFIG_DYNAMIC_DEBUG is not set
> > > >=20
> > > > #
> > > > # Compile-time checks and compiler options
> > > > #
> > > > # CONFIG_DEBUG_INFO is not set
> > > > # CONFIG_ENABLE_WARN_DEPRECATED is not set
> > > > # CONFIG_ENABLE_MUST_CHECK is not set
> > > > CONFIG_FRAME_WARN=3D1024
> > > > CONFIG_STRIP_ASM_SYMS=3Dy
> > > > # CONFIG_READABLE_ASM is not set
> > > > # CONFIG_UNUSED_SYMBOLS is not set
> > > > # CONFIG_PAGE_OWNER is not set
> > > > CONFIG_DEBUG_FS=3Dy
> > > > # CONFIG_HEADERS_CHECK is not set
> > > > # CONFIG_DEBUG_SECTION_MISMATCH is not set
> > > > CONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy
> > > > # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> > > > CONFIG_MAGIC_SYSRQ=3Dy
> > > > CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=3D0x1
> > > > CONFIG_MAGIC_SYSRQ_SERIAL=3Dy
> > > > CONFIG_DEBUG_KERNEL=3Dy
> > > >=20
> > > > #
> > > > # Memory Debugging
> > > > #
> > > > # CONFIG_PAGE_EXTENSION is not set
> > > > # CONFIG_DEBUG_PAGEALLOC is not set
> > > > # CONFIG_PAGE_POISONING is not set
> > > > CONFIG_DEBUG_RODATA_TEST=3Dy
> > > > # CONFIG_DEBUG_OBJECTS is not set
> > > > # CONFIG_SLUB_DEBUG_ON is not set
> > > > # CONFIG_SLUB_STATS is not set
> > > > CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
> > > > # CONFIG_DEBUG_KMEMLEAK is not set
> > > > # CONFIG_DEBUG_STACK_USAGE is not set
> > > > # CONFIG_DEBUG_VM is not set
> > > > CONFIG_DEBUG_MEMORY_INIT=3Dy
> > > > # CONFIG_DEBUG_HIGHMEM is not set
> > > > CONFIG_HAVE_DEBUG_STACKOVERFLOW=3Dy
> > > > # CONFIG_DEBUG_STACKOVERFLOW is not set
> > > > # CONFIG_DEBUG_SHIRQ is not set
> > > >=20
> > > > #
> > > > # Debug Lockups and Hangs
> > > > #
> > > > CONFIG_LOCKUP_DETECTOR=3Dy
> > > > CONFIG_SOFTLOCKUP_DETECTOR=3Dy
> > > > # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> > > > CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0
> > > > CONFIG_DETECT_HUNG_TASK=3Dy
> > > > CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D120
> > > > # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> > > > CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0
> > > > CONFIG_WQ_WATCHDOG=3Dy
> > > > # CONFIG_PANIC_ON_OOPS is not set
> > > > CONFIG_PANIC_ON_OOPS_VALUE=3D0
> > > > # CONFIG_SCHED_DEBUG is not set
> > > > # CONFIG_SCHED_INFO is not set
> > > > # CONFIG_SCHEDSTATS is not set
> > > > # CONFIG_SCHED_STACK_END_CHECK is not set
> > > > # CONFIG_DEBUG_TIMEKEEPING is not set
> > > >=20
> > > > #
> > > > # Lock Debugging (spinlocks, mutexes, etc...)
> > > > #
> > > > # CONFIG_DEBUG_RT_MUTEXES is not set
> > > > # CONFIG_DEBUG_SPINLOCK is not set
> > > > # CONFIG_DEBUG_MUTEXES is not set
> > > > # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> > > > # CONFIG_DEBUG_LOCK_ALLOC is not set
> > > > # CONFIG_PROVE_LOCKING is not set
> > > > # CONFIG_LOCK_STAT is not set
> > > > # CONFIG_DEBUG_ATOMIC_SLEEP is not set
> > > > # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> > > > # CONFIG_LOCK_TORTURE_TEST is not set
> > > > # CONFIG_WW_MUTEX_SELFTEST is not set
> > > > # CONFIG_STACKTRACE is not set
> > > > CONFIG_WARN_ALL_UNSEEDED_RANDOM=3Dy
> > > > # CONFIG_DEBUG_KOBJECT is not set
> > > > CONFIG_DEBUG_BUGVERBOSE=3Dy
> > > > # CONFIG_DEBUG_LIST is not set
> > > > # CONFIG_DEBUG_PI_LIST is not set
> > > > # CONFIG_DEBUG_SG is not set
> > > > # CONFIG_DEBUG_NOTIFIERS is not set
> > > > # CONFIG_DEBUG_CREDENTIALS is not set
> > > >=20
> > > > #
> > > > # RCU Debugging
> > > > #
> > > > # CONFIG_PROVE_RCU is not set
> > > > # CONFIG_TORTURE_TEST is not set
> > > > # CONFIG_RCU_PERF_TEST is not set
> > > > # CONFIG_RCU_TORTURE_TEST is not set
> > > > # CONFIG_RCU_TRACE is not set
> > > > # CONFIG_RCU_EQS_DEBUG is not set
> > > > # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> > > > # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> > > > # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> > > > # CONFIG_FAULT_INJECTION is not set
> > > > # CONFIG_LATENCYTOP is not set
> > > > CONFIG_HAVE_FUNCTION_TRACER=3Dy
> > > > CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
> > > > CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
> > > > CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
> > > > CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
> > > > CONFIG_TRACING_SUPPORT=3Dy
> > > > # CONFIG_FTRACE is not set
> > > >=20
> > > > #
> > > > # Runtime Testing
> > > > #
> > > > # CONFIG_LKDTM is not set
> > > > # CONFIG_TEST_LIST_SORT is not set
> > > > # CONFIG_TEST_SORT is not set
> > > > # CONFIG_BACKTRACE_SELF_TEST is not set
> > > > # CONFIG_RBTREE_TEST is not set
> > > > # CONFIG_INTERVAL_TREE_TEST is not set
> > > > # CONFIG_PERCPU_TEST is not set
> > > > # CONFIG_ATOMIC64_SELFTEST is not set
> > > > # CONFIG_TEST_HEXDUMP is not set
> > > > # CONFIG_TEST_STRING_HELPERS is not set
> > > > # CONFIG_TEST_KSTRTOX is not set
> > > > # CONFIG_TEST_PRINTF is not set
> > > > # CONFIG_TEST_BITMAP is not set
> > > > # CONFIG_TEST_UUID is not set
> > > > # CONFIG_TEST_RHASHTABLE is not set
> > > > # CONFIG_TEST_HASH is not set
> > > > # CONFIG_DMA_API_DEBUG is not set
> > > > # CONFIG_TEST_LKM is not set
> > > > # CONFIG_TEST_USER_COPY is not set
> > > > # CONFIG_TEST_BPF is not set
> > > > # CONFIG_TEST_FIRMWARE is not set
> > > > # CONFIG_TEST_SYSCTL is not set
> > > > # CONFIG_TEST_UDELAY is not set
> > > > # CONFIG_MEMTEST is not set
> > > > # CONFIG_TEST_STATIC_KEYS is not set
> > > > # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> > > > # CONFIG_TEST_KMOD is not set
> > > > # CONFIG_SAMPLES is not set
> > > > CONFIG_HAVE_ARCH_KGDB=3Dy
> > > > # CONFIG_KGDB is not set
> > > > CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=3Dy
> > > > # CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
> > > > # CONFIG_UBSAN is not set
> > > > CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=3Dy
> > > > # CONFIG_PPC_DISABLE_WERROR is not set
> > > > CONFIG_PPC_WERROR=3Dy
> > > > CONFIG_PRINT_STACK_DEPTH=3D64
> > > > # CONFIG_PPC_EMULATED_STATS is not set
> > > > # CONFIG_CODE_PATCHING_SELFTEST is not set
> > > > CONFIG_JUMP_LABEL_FEATURE_CHECKS=3Dy
> > > > CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG=3Dy
> > > > # CONFIG_FTR_FIXUP_SELFTEST is not set
> > > > # CONFIG_MSI_BITMAP_SELFTEST is not set
> > > > # CONFIG_XMON is not set
> > > > # CONFIG_BDI_SWITCH is not set
> > > > CONFIG_BOOTX_TEXT=3Dy
> > > > # CONFIG_PPC_EARLY_DEBUG is not set
> > > > # CONFIG_PPC_PTDUMP is not set
> > > >=20
> > > > #
> > > > # Security options
> > > > #
> > > > # CONFIG_KEYS is not set
> > > > # CONFIG_SECURITY_DMESG_RESTRICT is not set
> > > > # CONFIG_SECURITY is not set
> > > > # CONFIG_SECURITYFS is not set
> > > > CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=3Dy
> > > > # CONFIG_HARDENED_USERCOPY is not set
> > > > CONFIG_FORTIFY_SOURCE=3Dy
> > > > # CONFIG_STATIC_USERMODEHELPER is not set
> > > > CONFIG_DEFAULT_SECURITY_DAC=3Dy
> > > > CONFIG_DEFAULT_SECURITY=3D""
> > > > CONFIG_CRYPTO=3Dy
> > > >=20
> > > > #
> > > > # Crypto core or helper
> > > > #
> > > > CONFIG_CRYPTO_ALGAPI=3Dy
> > > > CONFIG_CRYPTO_ALGAPI2=3Dy
> > > > CONFIG_CRYPTO_AEAD=3Dy
> > > > CONFIG_CRYPTO_AEAD2=3Dy
> > > > CONFIG_CRYPTO_BLKCIPHER=3Dy
> > > > CONFIG_CRYPTO_BLKCIPHER2=3Dy
> > > > CONFIG_CRYPTO_HASH=3Dy
> > > > CONFIG_CRYPTO_HASH2=3Dy
> > > > CONFIG_CRYPTO_RNG=3Dy
> > > > CONFIG_CRYPTO_RNG2=3Dy
> > > > CONFIG_CRYPTO_RNG_DEFAULT=3Dy
> > > > CONFIG_CRYPTO_AKCIPHER2=3Dy
> > > > CONFIG_CRYPTO_KPP2=3Dy
> > > > CONFIG_CRYPTO_ACOMP2=3Dy
> > > > # CONFIG_CRYPTO_RSA is not set
> > > > # CONFIG_CRYPTO_DH is not set
> > > > CONFIG_CRYPTO_ECDH=3Dm
> > > > CONFIG_CRYPTO_MANAGER=3Dy
> > > > CONFIG_CRYPTO_MANAGER2=3Dy
> > > > # CONFIG_CRYPTO_USER is not set
> > > > CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy
> > > > CONFIG_CRYPTO_GF128MUL=3Dy
> > > > CONFIG_CRYPTO_NULL=3Dy
> > > > CONFIG_CRYPTO_NULL2=3Dy
> > > > CONFIG_CRYPTO_WORKQUEUE=3Dy
> > > > # CONFIG_CRYPTO_CRYPTD is not set
> > > > # CONFIG_CRYPTO_MCRYPTD is not set
> > > > # CONFIG_CRYPTO_AUTHENC is not set
> > > > # CONFIG_CRYPTO_TEST is not set
> > > >=20
> > > > #
> > > > # Authenticated Encryption with Associated Data
> > > > #
> > > > CONFIG_CRYPTO_CCM=3Dm
> > > > CONFIG_CRYPTO_GCM=3Dm
> > > > # CONFIG_CRYPTO_CHACHA20POLY1305 is not set
> > > > CONFIG_CRYPTO_SEQIV=3Dy
> > > > # CONFIG_CRYPTO_ECHAINIV is not set
> > > >=20
> > > > #
> > > > # Block modes
> > > > #
> > > > # CONFIG_CRYPTO_CBC is not set
> > > > CONFIG_CRYPTO_CTR=3Dy
> > > > # CONFIG_CRYPTO_CTS is not set
> > > > CONFIG_CRYPTO_ECB=3Dy
> > > > # CONFIG_CRYPTO_LRW is not set
> > > > # CONFIG_CRYPTO_PCBC is not set
> > > > # CONFIG_CRYPTO_XTS is not set
> > > > # CONFIG_CRYPTO_KEYWRAP is not set
> > > >=20
> > > > #
> > > > # Hash modes
> > > > #
> > > > CONFIG_CRYPTO_CMAC=3Dm
> > > > CONFIG_CRYPTO_HMAC=3Dy
> > > > # CONFIG_CRYPTO_XCBC is not set
> > > > # CONFIG_CRYPTO_VMAC is not set
> > > >=20
> > > > #
> > > > # Digest
> > > > #
> > > > CONFIG_CRYPTO_CRC32C=3Dy
> > > > # CONFIG_CRYPTO_CRC32 is not set
> > > > # CONFIG_CRYPTO_CRCT10DIF is not set
> > > > CONFIG_CRYPTO_GHASH=3Dm
> > > > # CONFIG_CRYPTO_POLY1305 is not set
> > > > # CONFIG_CRYPTO_MD4 is not set
> > > > # CONFIG_CRYPTO_MD5 is not set
> > > > # CONFIG_CRYPTO_MD5_PPC is not set
> > > > # CONFIG_CRYPTO_MICHAEL_MIC is not set
> > > > # CONFIG_CRYPTO_RMD128 is not set
> > > > # CONFIG_CRYPTO_RMD160 is not set
> > > > # CONFIG_CRYPTO_RMD256 is not set
> > > > # CONFIG_CRYPTO_RMD320 is not set
> > > > # CONFIG_CRYPTO_SHA1 is not set
> > > > # CONFIG_CRYPTO_SHA1_PPC is not set
> > > > CONFIG_CRYPTO_SHA256=3Dy
> > > > # CONFIG_CRYPTO_SHA512 is not set
> > > > # CONFIG_CRYPTO_SHA3 is not set
> > > > # CONFIG_CRYPTO_TGR192 is not set
> > > > # CONFIG_CRYPTO_WP512 is not set
> > > >=20
> > > > #
> > > > # Ciphers
> > > > #
> > > > CONFIG_CRYPTO_AES=3Dy
> > > > # CONFIG_CRYPTO_AES_TI is not set
> > > > # CONFIG_CRYPTO_ANUBIS is not set
> > > > CONFIG_CRYPTO_ARC4=3Dm
> > > > # CONFIG_CRYPTO_BLOWFISH is not set
> > > > # CONFIG_CRYPTO_CAMELLIA is not set
> > > > # CONFIG_CRYPTO_CAST5 is not set
> > > > # CONFIG_CRYPTO_CAST6 is not set
> > > > # CONFIG_CRYPTO_DES is not set
> > > > # CONFIG_CRYPTO_FCRYPT is not set
> > > > # CONFIG_CRYPTO_KHAZAD is not set
> > > > # CONFIG_CRYPTO_SALSA20 is not set
> > > > # CONFIG_CRYPTO_CHACHA20 is not set
> > > > # CONFIG_CRYPTO_SEED is not set
> > > > # CONFIG_CRYPTO_SERPENT is not set
> > > > # CONFIG_CRYPTO_TEA is not set
> > > > # CONFIG_CRYPTO_TWOFISH is not set
> > > >=20
> > > > #
> > > > # Compression
> > > > #
> > > > # CONFIG_CRYPTO_DEFLATE is not set
> > > > # CONFIG_CRYPTO_LZO is not set
> > > > # CONFIG_CRYPTO_842 is not set
> > > > # CONFIG_CRYPTO_LZ4 is not set
> > > > # CONFIG_CRYPTO_LZ4HC is not set
> > > >=20
> > > > #
> > > > # Random Number Generation
> > > > #
> > > > # CONFIG_CRYPTO_ANSI_CPRNG is not set
> > > > CONFIG_CRYPTO_DRBG_MENU=3Dy
> > > > CONFIG_CRYPTO_DRBG_HMAC=3Dy
> > > > # CONFIG_CRYPTO_DRBG_HASH is not set
> > > > # CONFIG_CRYPTO_DRBG_CTR is not set
> > > > CONFIG_CRYPTO_DRBG=3Dy
> > > > CONFIG_CRYPTO_JITTERENTROPY=3Dy
> > > > # CONFIG_CRYPTO_USER_API_HASH is not set
> > > > # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> > > > # CONFIG_CRYPTO_USER_API_RNG is not set
> > > > # CONFIG_CRYPTO_USER_API_AEAD is not set
> > > > # CONFIG_CRYPTO_HW is not set
> > > >=20
> > > > #
> > > > # Certificates for signature checking
> > > > #
> > > > # CONFIG_VIRTUALIZATION is not set
> > > >=20
> > > >=20
> > > > --
> > > > Meelis Roos (mroos@linux.ee)
> > >=20
> > >=20
> >=20
> > --
> > Meelis Roos (mroos@linux.ee)
>=20
>=20
>=20
>=20

--=20
Meelis Roos (mroos@linux.ee)
