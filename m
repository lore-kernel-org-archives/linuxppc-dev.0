Return-Path: <marwahamza63@gmail.com>
Received: from mail-vk0-x244.google.com (mail-vk0-x244.google.com
 [IPv6:2607:f8b0:400c:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwb5J1mPJzDqDJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 22:01:08 +1000 (AEST)
Received: by mail-vk0-x244.google.com with SMTP id v68so3992851vka.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 05:01:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGF64GUDPwkyUWgbAb7tfRsdpSPgnQ2+3B_3YaCFt5vco-EdwQ@mail.gmail.com>
References: <CAGF64GWNqfiWH6Joq0C7sCwQkuM2X-D6Ce-xM+iQGXPoaYYxnQ@mail.gmail.com>
 <CACPK8XeCOMRBVVHKEt3eDeD==E5BxB6H8B7c6H5tMjP++mBK6g@mail.gmail.com>
 <CAGF64GUDPwkyUWgbAb7tfRsdpSPgnQ2+3B_3YaCFt5vco-EdwQ@mail.gmail.com>
Date: Thu, 28 Apr 2016 13:01:04 +0100
Message-ID: <CAGF64GWPFw=tii63RbcvQd0oL4gtiJLAPGv5HWtZ+dz+Qe53Nw@mail.gmail.com>
Subject: Re: error while trying to compile linux kernel with powerpc arch
From: Marwa Hamza <marwahamza63@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001a11357726e5a1a405318a4784
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11357726e5a1a405318a4784
Content-Type: text/plain; charset=UTF-8

2016-04-28 9:45 GMT+01:00 Marwa Hamza <marwahamza63@gmail.com>:

>
> ---------- Forwarded message ----------
> From: Joel Stanley <joel@jms.id.au>
> Date: 2016-04-28 8:51 GMT+01:00
> Subject: Re: error while trying to compile linux kernel with powerpc arch
> To: Marwa Hamza <marwahamza63@gmail.com>
> Cc: linuxppc-dev@lists.ozlabs.org
>
>
> Hello,
>
> On Thu, Apr 28, 2016 at 2:13 AM, Marwa Hamza <marwahamza63@gmail.com>
> wrote:
> > hello
> > every time i try to compile the linux kernel with arch=powerpc i got this
> > error
> >
> > WRAP arch / powerpc / boot / zImage.pseries
> > powerpc-linux-gnu-ld: unrecognized emulation mode: -T
> > Emulations supported: elf32ppclinux elf32ppc elf32ppcsim elf64ppc
> elf32_spu
> > make [1]: *** [arch / powerpc / boot / zImage.pseries] Error 1
> > make: *** [zImage] Error 2
> >
> > im using powerpc-linux-gnu ( sudo apt-get install powerpc-linux-gnu)  and
> > linux-4.4.1
> > make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-  pseries_defconfig
> > make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-
> > ubuntu 14.04
> > any suggestion ?
>
> You need a 64 bit compiler, as the pseries configuration is for a 64
> bit machine.
>
> $ head -n1 arch/powerpc/configs/pseries_defconfig
> CONFIG_PPC64=y
>
> 'apt-get install gcc-powerpc64-linux-gnu' should do the trick. Set
> CROSS_COMPILE=powerpc64-linux-gnu- and you will be good to go.
>
> Cheers,
>
> Joel
> thanks for the response but this package doesn't exist
> gcc-powerpc64-linux-gnu so i install
> gccgo-powerpc64le-linux-gnu and i reconfigure the kernel
> make ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu-  pseries_defconfig
>
> and i compiled again make ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu-
> and i unfortunately i got another error
>
>
>
> VDSO32A arch / powerpc / kernel / vdso32 / getcpu.o
>   VDSO32L arch / powerpc / kernel / vdso32 / vdso32.so.dbg
> /usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
> arch / powerpc / kernel / vdso32 / sigtramp.o : byte compiled for a
> system of low weight while the target
> is a significant bytes system
> File in the wrong format: fusion failure targets specific data arch /
> powerpc / kernel / vdso32 / sigtramp.o
> /usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
> arch / powerpc / kernel / vdso32 / gettimeofday.o : byte compiled for a
> system of low weight while the target
> is a significant bytes system
> File in the wrong format: fusion failure targets specific data arch /
> powerpc / kernel / vdso32 / gettimeofday.o
> /usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
> arch / powerpc / kernel / vdso32 / datapage.o : byte compiled for a
> system of low weight while the target
> is a significant bytes system
> File in the wrong format: fusion failure targets specific data arch /
> powerpc / kernel / vdso32 / datapage.o
> /usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
> arch / powerpc / kernel / vdso32 / cacheflush.o : byte compiled for a
> system of low weight while the target
> is a significant bytes system
> File in the wrong format: fusion failure targets specific data arch /
> powerpc / kernel / vdso32 / cacheflush.o
> /usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
> arch / powerpc / kernel / vdso32 / note.o : byte compiled for a system of
> low weight while the target
> is a significant bytes system
> File in the wrong format: fusion failure targets specific data arch /
> powerpc / kernel / vdso32 / note.o
> /usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
> arch / powerpc / kernel / vdso32 / getcpu.o : byte compiled for a system
> of low weight while the target
> is a significant bytes system
> File in the wrong format: fusion failure targets specific data arch /
> powerpc / kernel / vdso32 / getcpu.o
> collect2: error: ld returned 1 exit status
> make [2]: *** [arch / powerpc / kernel / vdso32 / vdso32.so.dbg] Error 1
> make [1]: *** [arch / powerpc / kernel / vdso32] Error 2
> make: *** [arch / powerpc / kernel] Error 2
>
> i though fist that the problem is related to the big endian and little
> endian kernel but it seems not and i searched in google but i couldn't find
> any thing
>
> this is .config
>
> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/powerpc 4.4.1 Kernel Configuration
> #
> CONFIG_PPC64=y
>
> #
> # Processor support
> #
> CONFIG_PPC_BOOK3S_64=y
> # CONFIG_PPC_BOOK3E_64 is not set
> CONFIG_GENERIC_CPU=y
> # CONFIG_CELL_CPU is not set
> # CONFIG_POWER4_CPU is not set
> # CONFIG_POWER5_CPU is not set
> # CONFIG_POWER6_CPU is not set
> # CONFIG_POWER7_CPU is not set
> # CONFIG_POWER8_CPU is not set
> CONFIG_PPC_BOOK3S=y
> CONFIG_PPC_FPU=y
> CONFIG_ALTIVEC=y
> CONFIG_VSX=y
> # CONFIG_PPC_ICSWX is not set
> CONFIG_PPC_STD_MMU=y
> CONFIG_PPC_STD_MMU_64=y
> CONFIG_PPC_MM_SLICES=y
> CONFIG_PPC_HAVE_PMU_SUPPORT=y
> CONFIG_PPC_PERF_CTRS=y
> CONFIG_SMP=y
> CONFIG_NR_CPUS=32
> CONFIG_PPC_DOORBELL=y
> CONFIG_VDSO32=y
> CONFIG_CPU_BIG_ENDIAN=y
> # CONFIG_CPU_LITTLE_ENDIAN is not set
> CONFIG_64BIT=y
> CONFIG_WORD_SIZE=64
> CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> CONFIG_MMU=y
> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> CONFIG_NR_IRQS=512
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_HAVE_LATENCYTOP_SUPPORT=y
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_ARCH_HAS_ILOG2_U32=y
> CONFIG_ARCH_HAS_ILOG2_U64=y
> CONFIG_GENERIC_HWEIGHT=y
> CONFIG_ARCH_HAS_DMA_SET_COHERENT_MASK=y
> CONFIG_PPC=y
> # CONFIG_GENERIC_CSUM is not set
> CONFIG_EARLY_PRINTK=y
> CONFIG_PANIC_TIMEOUT=180
> CONFIG_COMPAT=y
> CONFIG_SYSVIPC_COMPAT=y
> CONFIG_SCHED_OMIT_FRAME_POINTER=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_PPC_UDBG_16550=y
> CONFIG_GENERIC_TBSYNC=y
> CONFIG_AUDIT_ARCH=y
> CONFIG_GENERIC_BUG=y
> CONFIG_EPAPR_BOOT=y
> # CONFIG_DEFAULT_UIMAGE is not set
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> # CONFIG_PPC_DCR_NATIVE is not set
> CONFIG_PPC_DCR_MMIO=y
> CONFIG_PPC_DCR=y
> CONFIG_PPC_OF_PLATFORM_PCI=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_PPC_EMULATE_SSTEP=y
> CONFIG_ZONE_DMA32=y
> CONFIG_PGTABLE_LEVELS=4
> CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
> CONFIG_IRQ_WORK=y
>
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=32
> CONFIG_CROSS_COMPILE=""
> # CONFIG_COMPILE_TEST is not set
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> CONFIG_POSIX_MQUEUE=y
> CONFIG_POSIX_MQUEUE_SYSCTL=y
> CONFIG_CROSS_MEMORY_ATTACH=y
> CONFIG_FHANDLE=y
> CONFIG_USELIB=y
> # CONFIG_AUDIT is not set
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
>
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
> CONFIG_IRQ_EDGE_EOI_HANDLER=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_GENERIC_MSI_IRQ=y
> CONFIG_IRQ_DOMAIN_DEBUG=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> CONFIG_GENERIC_TIME_VSYSCALL_OLD=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_ARCH_HAS_TICK_BROADCAST=y
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> CONFIG_GENERIC_CMOS_UPDATE=y
>
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> CONFIG_NO_HZ_IDLE=y
> # CONFIG_NO_HZ_FULL is not set
> CONFIG_NO_HZ=y
> CONFIG_HIGH_RES_TIMERS=y
>
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_VIRT_CPU_ACCOUNTING=y
> # CONFIG_TICK_CPU_ACCOUNTING is not set
> CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y
> # CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
> # CONFIG_BSD_PROCESS_ACCT is not set
> CONFIG_TASKSTATS=y
> CONFIG_TASK_DELAY_ACCT=y
> # CONFIG_TASK_XACCT is not set
>
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=y
> # CONFIG_TASKS_RCU is not set
> CONFIG_RCU_STALL_COMMON=y
> # CONFIG_TREE_RCU_TRACE is not set
> # CONFIG_RCU_EXPEDITE_BOOT is not set
> CONFIG_BUILD_BIN2C=y
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> CONFIG_LOG_BUF_SHIFT=17
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
> # CONFIG_NUMA_BALANCING is not set
> CONFIG_CGROUPS=y
> # CONFIG_CGROUP_DEBUG is not set
> # CONFIG_CGROUP_FREEZER is not set
> # CONFIG_CGROUP_PIDS is not set
> # CONFIG_CGROUP_DEVICE is not set
> CONFIG_CPUSETS=y
> CONFIG_PROC_PID_CPUSET=y
> # CONFIG_CGROUP_CPUACCT is not set
> # CONFIG_MEMCG is not set
> # CONFIG_CGROUP_HUGETLB is not set
> # CONFIG_CGROUP_PERF is not set
> # CONFIG_CGROUP_SCHED is not set
> # CONFIG_BLK_CGROUP is not set
> # CONFIG_CHECKPOINT_RESTORE is not set
> CONFIG_NAMESPACES=y
> CONFIG_UTS_NS=y
> CONFIG_IPC_NS=y
> # CONFIG_USER_NS is not set
> CONFIG_PID_NS=y
> CONFIG_NET_NS=y
> # CONFIG_SCHED_AUTOGROUP is not set
> # CONFIG_SYSFS_DEPRECATED is not set
> CONFIG_RELAY=y
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_RD_GZIP=y
> CONFIG_RD_BZIP2=y
> CONFIG_RD_LZMA=y
> CONFIG_RD_XZ=y
> CONFIG_RD_LZO=y
> CONFIG_RD_LZ4=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_SYSCTL=y
> CONFIG_ANON_INODES=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_HAVE_PCSPKR_PLATFORM=y
> CONFIG_BPF=y
> # CONFIG_EXPERT is not set
> CONFIG_MULTIUSER=y
> CONFIG_SGETMASK_SYSCALL=y
> CONFIG_SYSFS_SYSCALL=y
> # CONFIG_SYSCTL_SYSCALL is not set
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_PCSPKR_PLATFORM=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> # CONFIG_BPF_SYSCALL is not set
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> CONFIG_ADVISE_SYSCALLS=y
> # CONFIG_USERFAULTFD is not set
> CONFIG_PCI_QUIRKS=y
> CONFIG_MEMBARRIER=y
> # CONFIG_EMBEDDED is not set
> CONFIG_HAVE_PERF_EVENTS=y
>
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> CONFIG_VM_EVENT_COUNTERS=y
> CONFIG_SLUB_DEBUG=y
> # CONFIG_COMPAT_BRK is not set
> # CONFIG_SLAB is not set
> CONFIG_SLUB=y
> CONFIG_SLUB_CPU_PARTIAL=y
> # CONFIG_SYSTEM_DATA_VERIFICATION is not set
> CONFIG_PROFILING=y
> CONFIG_TRACEPOINTS=y
> CONFIG_KEXEC_CORE=y
> CONFIG_OPROFILE=y
> CONFIG_HAVE_OPROFILE=y
> CONFIG_KPROBES=y
> CONFIG_JUMP_LABEL=y
> # CONFIG_STATIC_KEYS_SELFTEST is not set
> # CONFIG_UPROBES is not set
> # CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_KRETPROBES=y
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_ATTRS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_DMA_API_DEBUG=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_RCU_TABLE_FREE=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
> CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
> CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_SECCOMP_FILTER=y
> # CONFIG_CC_STACKPROTECTOR is not set
> CONFIG_HAVE_CONTEXT_TRACKING=y
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING=y
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_RELA=y
> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_CLONE_BACKWARDS=y
> CONFIG_OLD_SIGSUSPEND=y
> CONFIG_COMPAT_OLD_SIGACTION=y
>
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> # CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
> CONFIG_SLABINFO=y
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> CONFIG_MODULES=y
> # CONFIG_MODULE_FORCE_LOAD is not set
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> CONFIG_MODVERSIONS=y
> CONFIG_MODULE_SRCVERSION_ALL=y
> # CONFIG_MODULE_SIG is not set
> # CONFIG_MODULE_COMPRESS is not set
> CONFIG_MODULES_TREE_LOOKUP=y
> CONFIG_BLOCK=y
> CONFIG_BLK_DEV_BSG=y
> CONFIG_BLK_DEV_BSGLIB=y
> # CONFIG_BLK_DEV_INTEGRITY is not set
> # CONFIG_BLK_CMDLINE_PARSER is not set
>
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> # CONFIG_ACORN_PARTITION is not set
> # CONFIG_AIX_PARTITION is not set
> # CONFIG_OSF_PARTITION is not set
> # CONFIG_AMIGA_PARTITION is not set
> # CONFIG_ATARI_PARTITION is not set
> CONFIG_MAC_PARTITION=y
> CONFIG_MSDOS_PARTITION=y
> # CONFIG_BSD_DISKLABEL is not set
> # CONFIG_MINIX_SUBPARTITION is not set
> # CONFIG_SOLARIS_X86_PARTITION is not set
> # CONFIG_UNIXWARE_DISKLABEL is not set
> # CONFIG_LDM_PARTITION is not set
> # CONFIG_SGI_PARTITION is not set
> # CONFIG_ULTRIX_PARTITION is not set
> # CONFIG_SUN_PARTITION is not set
> # CONFIG_KARMA_PARTITION is not set
> CONFIG_EFI_PARTITION=y
> # CONFIG_SYSV68_PARTITION is not set
> # CONFIG_CMDLINE_PARTITION is not set
> CONFIG_BLOCK_COMPAT=y
>
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=y
> # CONFIG_DEFAULT_DEADLINE is not set
> CONFIG_DEFAULT_CFQ=y
> # CONFIG_DEFAULT_NOOP is not set
> CONFIG_DEFAULT_IOSCHED="cfq"
> CONFIG_PREEMPT_NOTIFIERS=y
> CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
> CONFIG_INLINE_READ_UNLOCK=y
> CONFIG_INLINE_READ_UNLOCK_IRQ=y
> CONFIG_INLINE_WRITE_UNLOCK=y
> CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_RWSEM_SPIN_ON_OWNER=y
> CONFIG_LOCK_SPIN_ON_OWNER=y
> CONFIG_FREEZER=y
> CONFIG_PPC_MSI_BITMAP=y
> CONFIG_PPC_XICS=y
> CONFIG_PPC_ICP_NATIVE=y
> CONFIG_PPC_ICP_HV=y
> CONFIG_PPC_ICS_RTAS=y
> CONFIG_PPC_SCOM=y
> # CONFIG_SCOM_DEBUGFS is not set
> # CONFIG_GE_FPGA is not set
>
> #
> # Platform support
> #
> CONFIG_PPC_POWERNV=y
> # CONFIG_OPAL_PRD is not set
> CONFIG_PPC_PSERIES=y
> CONFIG_PPC_SPLPAR=y
> CONFIG_DTL=y
> CONFIG_PSERIES_ENERGY=y
> CONFIG_SCANLOG=m
> CONFIG_IO_EVENT_IRQ=y
> CONFIG_LPARCFG=y
> CONFIG_PPC_PSERIES_DEBUG=y
> CONFIG_PPC_SMLPAR=y
> CONFIG_CMM=y
> CONFIG_HV_PERF_CTRS=y
> CONFIG_PPC_PMAC=y
> CONFIG_PPC_PMAC64=y
> CONFIG_PPC_MAPLE=y
> CONFIG_PPC_PASEMI=y
>
> #
> # PA Semi PWRficient options
> #
> CONFIG_PPC_PASEMI_IOMMU=y
> # CONFIG_PPC_PASEMI_IOMMU_DMA_FORCE is not set
> CONFIG_PPC_PASEMI_MDIO=y
> CONFIG_PPC_PS3=y
>
> #
> # PS3 Platform Options
> #
> # CONFIG_PS3_ADVANCED is not set
> CONFIG_PS3_HTAB_SIZE=20
> # CONFIG_PS3_DYNAMIC_DMA is not set
> CONFIG_PS3_VUART=y
> CONFIG_PS3_PS3AV=y
> CONFIG_PS3_SYS_MANAGER=y
> # CONFIG_PS3_REPOSITORY_WRITE is not set
> CONFIG_PS3_STORAGE=m
> CONFIG_PS3_DISK=m
> CONFIG_PS3_ROM=m
> CONFIG_PS3_FLASH=m
> CONFIG_PS3_LPM=m
> # CONFIG_PS3GELIC_UDBG is not set
> CONFIG_PPC_CELL=y
> CONFIG_PPC_CELL_COMMON=y
> CONFIG_PPC_CELL_NATIVE=y
> CONFIG_PPC_IBM_CELL_BLADE=y
> CONFIG_PPC_CELL_QPACE=y
> CONFIG_AXON_MSI=y
>
> #
> # Cell Broadband Engine options
> #
> CONFIG_SPU_FS=m
> CONFIG_SPU_BASE=y
> CONFIG_CBE_RAS=y
> CONFIG_PPC_IBM_CELL_RESETBUTTON=y
> CONFIG_PPC_IBM_CELL_POWERBUTTON=m
> CONFIG_CBE_THERM=m
> CONFIG_PPC_PMI=m
> CONFIG_CBE_CPUFREQ_SPU_GOVERNOR=m
> CONFIG_OPROFILE_CELL=y
> # CONFIG_PQ2ADS is not set
> # CONFIG_KVM_GUEST is not set
> # CONFIG_EPAPR_PARAVIRT is not set
> CONFIG_PPC_NATIVE=y
> CONFIG_PPC_OF_BOOT_TRAMPOLINE=y
> CONFIG_UDBG_RTAS_CONSOLE=y
> CONFIG_PPC_SMP_MUXED_IPI=y
> # CONFIG_IPIC is not set
> CONFIG_MPIC=y
> # CONFIG_PPC_EPAPR_HV_PIC is not set
> # CONFIG_MPIC_WEIRD is not set
> # CONFIG_MPIC_MSGR is not set
> CONFIG_PPC_I8259=y
> CONFIG_U3_DART=y
> CONFIG_PPC_RTAS=y
> CONFIG_RTAS_ERROR_LOGGING=y
> CONFIG_PPC_RTAS_DAEMON=y
> CONFIG_RTAS_PROC=y
> CONFIG_RTAS_FLASH=m
> CONFIG_MMIO_NVRAM=y
> CONFIG_MPIC_U3_HT_IRQS=y
> CONFIG_MPIC_BROKEN_REGREAD=y
> CONFIG_IBMVIO=y
> CONFIG_IBMEBUS=y
> CONFIG_EEH=y
> # CONFIG_PPC_MPC106 is not set
> CONFIG_PPC_970_NAP=y
> CONFIG_PPC_P7_NAP=y
> CONFIG_PPC_INDIRECT_PIO=y
> CONFIG_PPC_INDIRECT_MMIO=y
> CONFIG_PPC_IO_WORKAROUNDS=y
>
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_GOV_COMMON=y
> CONFIG_CPU_FREQ_STAT=y
> # CONFIG_CPU_FREQ_STAT_DETAILS is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
>
> #
> # CPU frequency scaling drivers
> #
> CONFIG_CPU_FREQ_CBE=m
> # CONFIG_CPU_FREQ_CBE_PMI is not set
> # CONFIG_CPU_FREQ_MAPLE is not set
> CONFIG_CPU_FREQ_PMAC64=y
> CONFIG_PPC_PASEMI_CPUFREQ=y
> CONFIG_POWERNV_CPUFREQ=y
>
> #
> # CPUIdle driver
> #
>
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> CONFIG_CPU_IDLE_GOV_LADDER=y
> CONFIG_CPU_IDLE_GOV_MENU=y
>
> #
> # POWERPC CPU Idle Drivers
> #
> CONFIG_PSERIES_CPUIDLE=y
> CONFIG_POWERNV_CPUIDLE=y
> # CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
> CONFIG_AXON_RAM=m
> # CONFIG_FSL_ULI1575 is not set
> # CONFIG_SIMPLE_GPIO is not set
>
> #
> # Kernel options
> #
> CONFIG_HZ_100=y
> # CONFIG_HZ_250 is not set
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=100
> CONFIG_SCHED_HRTICK=y
> CONFIG_PREEMPT_NONE=y
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT is not set
> CONFIG_BINFMT_ELF=y
> CONFIG_COMPAT_BINFMT_ELF=y
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
> CONFIG_BINFMT_SCRIPT=y
> # CONFIG_HAVE_AOUT is not set
> CONFIG_BINFMT_MISC=m
> CONFIG_COREDUMP=y
> CONFIG_HUGETLB_PAGE_SIZE_VARIABLE=y
> CONFIG_PPC_TRANSACTIONAL_MEM=y
> CONFIG_IOMMU_HELPER=y
> # CONFIG_SWIOTLB is not set
> CONFIG_HOTPLUG_CPU=y
> CONFIG_ARCH_CPU_PROBE_RELEASE=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> CONFIG_ARCH_HAS_WALK_MEMORY=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
> CONFIG_PPC64_SUPPORTS_MEMORY_FAILURE=y
> CONFIG_KEXEC=y
> CONFIG_CRASH_DUMP=y
> # CONFIG_FA_DUMP is not set
> CONFIG_IRQ_ALL_CPUS=y
> CONFIG_NUMA=y
> CONFIG_NODES_SHIFT=8
> CONFIG_USE_PERCPU_NUMA_NODE_ID=y
> CONFIG_HAVE_MEMORYLESS_NODES=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> CONFIG_SYS_SUPPORTS_HUGETLBFS=y
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_SPARSEMEM_MANUAL=y
> CONFIG_SPARSEMEM=y
> CONFIG_NEED_MULTIPLE_NODES=y
> CONFIG_HAVE_MEMORY_PRESENT=y
> CONFIG_SPARSEMEM_EXTREME=y
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> CONFIG_SPARSEMEM_VMEMMAP=y
> CONFIG_HAVE_MEMBLOCK=y
> CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
> CONFIG_HAVE_GENERIC_RCU_GUP=y
> CONFIG_NO_BOOTMEM=y
> CONFIG_MEMORY_ISOLATION=y
> CONFIG_HAVE_BOOTMEM_INFO_NODE=y
> CONFIG_MEMORY_HOTPLUG=y
> CONFIG_MEMORY_HOTPLUG_SPARSE=y
> CONFIG_MEMORY_HOTREMOVE=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_MEMORY_BALLOON=y
> CONFIG_BALLOON_COMPACTION=y
> CONFIG_COMPACTION=y
> CONFIG_MIGRATION=y
> CONFIG_PHYS_ADDR_T_64BIT=y
> CONFIG_ZONE_DMA_FLAG=1
> CONFIG_BOUNCE=y
> CONFIG_MMU_NOTIFIER=y
> CONFIG_KSM=y
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
> # CONFIG_MEMORY_FAILURE is not set
> # CONFIG_CLEANCACHE is not set
> # CONFIG_FRONTSWAP is not set
> CONFIG_CMA=y
> # CONFIG_CMA_DEBUG is not set
> # CONFIG_CMA_DEBUGFS is not set
> CONFIG_CMA_AREAS=7
> # CONFIG_ZPOOL is not set
> # CONFIG_ZBUD is not set
> # CONFIG_ZSMALLOC is not set
> # CONFIG_IDLE_PAGE_TRACKING is not set
> CONFIG_ARCH_MEMORY_PROBE=y
> CONFIG_NODES_SPAN_OTHER_NODES=y
> CONFIG_PPC_4K_PAGES=y
> # CONFIG_PPC_64K_PAGES is not set
> CONFIG_FORCE_MAX_ZONEORDER=13
> CONFIG_PPC_COPRO_BASE=y
> CONFIG_SCHED_SMT=y
> CONFIG_PPC_DENORMALISATION=y
> # CONFIG_CMDLINE_BOOL is not set
> CONFIG_EXTRA_TARGETS=""
> CONFIG_ARCH_WANTS_FREEZER_CONTROL=y
> CONFIG_SUSPEND=y
> CONFIG_SUSPEND_FREEZER=y
> # CONFIG_HIBERNATION is not set
> CONFIG_PM_SLEEP=y
> CONFIG_PM_SLEEP_SMP=y
> # CONFIG_PM_AUTOSLEEP is not set
> # CONFIG_PM_WAKELOCKS is not set
> CONFIG_PM=y
> # CONFIG_PM_DEBUG is not set
> # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> CONFIG_SECCOMP=y
> CONFIG_ISA_DMA_API=y
>
> #
> # Bus options
> #
> CONFIG_ZONE_DMA=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> CONFIG_GENERIC_ISA_DMA=y
> # CONFIG_PPC_INDIRECT_PCI is not set
> CONFIG_PPC_PCI_CHOICE=y
> CONFIG_PCI=y
> CONFIG_PCI_DOMAINS=y
> CONFIG_PCI_SYSCALL=y
> # CONFIG_PCIEPORTBUS is not set
> CONFIG_PCI_BUS_ADDR_T_64BIT=y
> CONFIG_PCI_MSI=y
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
> # CONFIG_PCI_STUB is not set
> # CONFIG_PCI_IOV is not set
> # CONFIG_PCI_PRI is not set
> # CONFIG_PCI_PASID is not set
>
> #
> # PCI host controller drivers
> #
> CONFIG_PCCARD=y
> CONFIG_PCMCIA=y
> CONFIG_PCMCIA_LOAD_CIS=y
> CONFIG_CARDBUS=y
>
> #
> # PC-card bridges
> #
> # CONFIG_YENTA is not set
> # CONFIG_PD6729 is not set
> # CONFIG_I82092 is not set
> CONFIG_ELECTRA_CF=y
> CONFIG_HOTPLUG_PCI=y
> # CONFIG_HOTPLUG_PCI_CPCI is not set
> # CONFIG_HOTPLUG_PCI_SHPC is not set
> CONFIG_HOTPLUG_PCI_RPA=m
> CONFIG_HOTPLUG_PCI_RPA_DLPAR=m
> # CONFIG_HAS_RAPIDIO is not set
> # CONFIG_RAPIDIO is not set
> CONFIG_NONSTATIC_KERNEL=y
> CONFIG_RELOCATABLE=y
> CONFIG_PAGE_OFFSET=0xc000000000000000
> CONFIG_KERNEL_START=0xc000000000000000
> CONFIG_PHYSICAL_START=0x00000000
> CONFIG_ARCH_RANDOM=y
> CONFIG_NET=y
> CONFIG_COMPAT_NETLINK_MESSAGES=y
> CONFIG_NET_INGRESS=y
>
> #
> # Networking options
> #
> CONFIG_PACKET=y
> # CONFIG_PACKET_DIAG is not set
> CONFIG_UNIX=y
> # CONFIG_UNIX_DIAG is not set
> CONFIG_XFRM=y
> CONFIG_XFRM_ALGO=m
> CONFIG_XFRM_USER=m
> # CONFIG_XFRM_SUB_POLICY is not set
> # CONFIG_XFRM_MIGRATE is not set
> # CONFIG_XFRM_STATISTICS is not set
> CONFIG_XFRM_IPCOMP=m
> CONFIG_NET_KEY=m
> # CONFIG_NET_KEY_MIGRATE is not set
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> # CONFIG_IP_ADVANCED_ROUTER is not set
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> CONFIG_IP_PNP_BOOTP=y
> # CONFIG_IP_PNP_RARP is not set
> CONFIG_NET_IPIP=y
> # CONFIG_NET_IPGRE_DEMUX is not set
> CONFIG_NET_IP_TUNNEL=y
> # CONFIG_IP_MROUTE is not set
> CONFIG_SYN_COOKIES=y
> # CONFIG_NET_IPVTI is not set
> # CONFIG_NET_UDP_TUNNEL is not set
> # CONFIG_NET_FOU is not set
> # CONFIG_NET_FOU_IP_TUNNELS is not set
> CONFIG_INET_AH=m
> CONFIG_INET_ESP=m
> CONFIG_INET_IPCOMP=m
> CONFIG_INET_XFRM_TUNNEL=m
> CONFIG_INET_TUNNEL=y
> CONFIG_INET_XFRM_MODE_TRANSPORT=y
> CONFIG_INET_XFRM_MODE_TUNNEL=y
> CONFIG_INET_XFRM_MODE_BEET=y
> CONFIG_INET_LRO=y
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> # CONFIG_INET_UDP_DIAG is not set
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_DEFAULT_TCP_CONG="cubic"
> # CONFIG_TCP_MD5SIG is not set
> # CONFIG_IPV6 is not set
> # CONFIG_NETWORK_SECMARK is not set
> CONFIG_NET_PTP_CLASSIFY=y
> # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> CONFIG_NETFILTER=y
> # CONFIG_NETFILTER_DEBUG is not set
> # CONFIG_NETFILTER_ADVANCED is not set
>
> #
> # Core Netfilter Configuration
> #
> CONFIG_NETFILTER_INGRESS=y
> CONFIG_NETFILTER_NETLINK=m
> CONFIG_NETFILTER_NETLINK_LOG=m
> CONFIG_NF_CONNTRACK=m
> CONFIG_NF_LOG_COMMON=m
> CONFIG_NF_CONNTRACK_PROCFS=y
> CONFIG_NF_CONNTRACK_FTP=m
> CONFIG_NF_CONNTRACK_IRC=m
> # CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
> CONFIG_NF_CONNTRACK_SIP=m
> CONFIG_NF_CT_NETLINK=m
> # CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
> CONFIG_NF_NAT=m
> CONFIG_NF_NAT_NEEDED=y
> # CONFIG_NF_NAT_AMANDA is not set
> CONFIG_NF_NAT_FTP=m
> CONFIG_NF_NAT_IRC=m
> CONFIG_NF_NAT_SIP=m
> # CONFIG_NF_NAT_TFTP is not set
> # CONFIG_NF_NAT_REDIRECT is not set
> # CONFIG_NF_TABLES is not set
> CONFIG_NETFILTER_XTABLES=m
>
> #
> # Xtables combined modules
> #
> CONFIG_NETFILTER_XT_MARK=m
>
> #
> # Xtables targets
> #
> CONFIG_NETFILTER_XT_TARGET_LOG=m
> CONFIG_NETFILTER_XT_NAT=m
> # CONFIG_NETFILTER_XT_TARGET_NETMAP is not set
> CONFIG_NETFILTER_XT_TARGET_NFLOG=m
> # CONFIG_NETFILTER_XT_TARGET_REDIRECT is not set
> CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
>
> #
> # Xtables matches
> #
> CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
> CONFIG_NETFILTER_XT_MATCH_POLICY=m
> CONFIG_NETFILTER_XT_MATCH_STATE=m
> # CONFIG_IP_SET is not set
> # CONFIG_IP_VS is not set
>
> #
> # IP: Netfilter Configuration
> #
> CONFIG_NF_DEFRAG_IPV4=m
> CONFIG_NF_CONNTRACK_IPV4=m
> CONFIG_NF_CONNTRACK_PROC_COMPAT=y
> # CONFIG_NF_DUP_IPV4 is not set
> CONFIG_NF_LOG_ARP=m
> CONFIG_NF_LOG_IPV4=m
> CONFIG_NF_REJECT_IPV4=m
> CONFIG_NF_NAT_IPV4=m
> CONFIG_NF_NAT_MASQUERADE_IPV4=m
> # CONFIG_NF_NAT_PPTP is not set
> # CONFIG_NF_NAT_H323 is not set
> CONFIG_IP_NF_IPTABLES=m
> CONFIG_IP_NF_FILTER=m
> CONFIG_IP_NF_TARGET_REJECT=m
> CONFIG_IP_NF_NAT=m
> CONFIG_IP_NF_TARGET_MASQUERADE=m
> CONFIG_IP_NF_MANGLE=m
> # CONFIG_IP_NF_RAW is not set
> # CONFIG_BRIDGE_NF_EBTABLES is not set
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
> # CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_L2TP is not set
> CONFIG_STP=m
> CONFIG_BRIDGE=m
> CONFIG_BRIDGE_IGMP_SNOOPING=y
> CONFIG_HAVE_NET_DSA=y
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> CONFIG_LLC=m
> # CONFIG_LLC2 is not set
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_PHONET is not set
> # CONFIG_IEEE802154 is not set
> # CONFIG_NET_SCHED is not set
> # CONFIG_DCB is not set
> CONFIG_DNS_RESOLVER=y
> # CONFIG_BATMAN_ADV is not set
> # CONFIG_OPENVSWITCH is not set
> # CONFIG_VSOCKETS is not set
> # CONFIG_NETLINK_MMAP is not set
> # CONFIG_NETLINK_DIAG is not set
> # CONFIG_MPLS is not set
> # CONFIG_HSR is not set
> # CONFIG_NET_SWITCHDEV is not set
> # CONFIG_NET_L3_MASTER_DEV is not set
> CONFIG_RPS=y
> CONFIG_RFS_ACCEL=y
> CONFIG_XPS=y
> # CONFIG_CGROUP_NET_PRIO is not set
> # CONFIG_CGROUP_NET_CLASSID is not set
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> CONFIG_BPF_JIT=y
> CONFIG_NET_FLOW_LIMIT=y
>
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_NET_TCPPROBE is not set
> # CONFIG_NET_DROP_MONITOR is not set
> # CONFIG_HAMRADIO is not set
> # CONFIG_CAN is not set
> # CONFIG_IRDA is not set
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
> CONFIG_WIRELESS=y
> CONFIG_WIRELESS_EXT=y
> CONFIG_WEXT_CORE=y
> CONFIG_WEXT_PROC=y
> # CONFIG_CFG80211 is not set
> # CONFIG_LIB80211 is not set
>
> #
> # CFG80211 needs to be enabled for MAC80211
> #
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> # CONFIG_WIMAX is not set
> # CONFIG_RFKILL is not set
> # CONFIG_NET_9P is not set
> # CONFIG_CAIF is not set
> # CONFIG_CEPH_LIB is not set
> # CONFIG_NFC is not set
> # CONFIG_LWTUNNEL is not set
> CONFIG_HAVE_BPF_JIT=y
>
> #
> # Device Drivers
> #
>
> #
> # Generic Driver Options
> #
> CONFIG_UEVENT_HELPER=y
> CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
> CONFIG_DEVTMPFS=y
> CONFIG_DEVTMPFS_MOUNT=y
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> CONFIG_FW_LOADER=y
> CONFIG_FIRMWARE_IN_KERNEL=y
> CONFIG_EXTRA_FIRMWARE=""
> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> CONFIG_ALLOW_DEV_COREDUMP=y
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_SYS_HYPERVISOR is not set
> # CONFIG_GENERIC_CPU_DEVICES is not set
> # CONFIG_DMA_SHARED_BUFFER is not set
>
> #
> # Bus devices
> #
> # CONFIG_CONNECTOR is not set
> # CONFIG_MTD is not set
> CONFIG_DTC=y
> CONFIG_OF=y
> # CONFIG_OF_UNITTEST is not set
> CONFIG_OF_FLATTREE=y
> CONFIG_OF_EARLY_FLATTREE=y
> CONFIG_OF_DYNAMIC=y
> CONFIG_OF_ADDRESS=y
> CONFIG_OF_ADDRESS_PCI=y
> CONFIG_OF_IRQ=y
> CONFIG_OF_NET=y
> CONFIG_OF_MDIO=y
> CONFIG_OF_PCI=y
> CONFIG_OF_PCI_IRQ=y
> CONFIG_OF_RESERVED_MEM=y
> # CONFIG_OF_OVERLAY is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> # CONFIG_PARPORT is not set
> CONFIG_BLK_DEV=y
> # CONFIG_BLK_DEV_NULL_BLK is not set
> CONFIG_BLK_DEV_FD=y
> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> # CONFIG_BLK_DEV_COW_COMMON is not set
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> # CONFIG_BLK_DEV_DRBD is not set
> CONFIG_BLK_DEV_NBD=m
> # CONFIG_BLK_DEV_SKD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_COUNT=16
> CONFIG_BLK_DEV_RAM_SIZE=65536
> # CONFIG_CDROM_PKTCDVD is not set
> # CONFIG_ATA_OVER_ETH is not set
> CONFIG_VIRTIO_BLK=m
> # CONFIG_BLK_DEV_HD is not set
> # CONFIG_BLK_DEV_RBD is not set
> # CONFIG_BLK_DEV_RSXX is not set
> # CONFIG_BLK_DEV_NVME is not set
>
> #
> # Misc devices
> #
> # CONFIG_SENSORS_LIS3LV02D is not set
> # CONFIG_AD525X_DPOT is not set
> # CONFIG_DUMMY_IRQ is not set
> # CONFIG_PHANTOM is not set
> # CONFIG_SGI_IOC4 is not set
> # CONFIG_TIFM_CORE is not set
> # CONFIG_ICS932S401 is not set
> # CONFIG_ENCLOSURE_SERVICES is not set
> # CONFIG_HP_ILO is not set
> # CONFIG_APDS9802ALS is not set
> # CONFIG_ISL29003 is not set
> # CONFIG_ISL29020 is not set
> # CONFIG_SENSORS_TSL2550 is not set
> # CONFIG_SENSORS_BH1780 is not set
> # CONFIG_SENSORS_BH1770 is not set
> # CONFIG_SENSORS_APDS990X is not set
> # CONFIG_HMC6352 is not set
> # CONFIG_DS1682 is not set
> # CONFIG_BMP085_I2C is not set
> # CONFIG_USB_SWITCH_FSA9480 is not set
> # CONFIG_SRAM is not set
> # CONFIG_C2PORT is not set
>
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_AT24 is not set
> # CONFIG_EEPROM_LEGACY is not set
> # CONFIG_EEPROM_MAX6875 is not set
> # CONFIG_EEPROM_93CX6 is not set
> # CONFIG_CB710_CORE is not set
>
> #
> # Texas Instruments shared transport line discipline
> #
> # CONFIG_SENSORS_LIS3_I2C is not set
>
> #
> # Altera FPGA firmware download module
> #
> # CONFIG_ALTERA_STAPL is not set
>
> #
> # Intel MIC Bus Driver
> #
>
> #
> # SCIF Bus Driver
> #
>
> #
> # Intel MIC Host Driver
> #
>
> #
> # Intel MIC Card Driver
> #
>
> #
> # SCIF Driver
> #
>
> #
> # Intel MIC Coprocessor State Management (COSM) Drivers
> #
> # CONFIG_GENWQE is not set
> # CONFIG_ECHO is not set
> CONFIG_CXL_BASE=y
> CONFIG_CXL_KERNEL_API=y
> CONFIG_CXL_EEH=y
> CONFIG_CXL=m
> CONFIG_HAVE_IDE=y
> CONFIG_IDE=y
>
> #
> # Please see Documentation/ide/ide.txt for help/info on IDE drives
> #
> CONFIG_IDE_XFER_MODE=y
> CONFIG_IDE_TIMINGS=y
> CONFIG_IDE_ATAPI=y
> # CONFIG_BLK_DEV_IDE_SATA is not set
> CONFIG_IDE_GD=y
> CONFIG_IDE_GD_ATA=y
> # CONFIG_IDE_GD_ATAPI is not set
> # CONFIG_BLK_DEV_IDECS is not set
> # CONFIG_BLK_DEV_DELKIN is not set
> CONFIG_BLK_DEV_IDECD=y
> CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_IDE_TASK_IOCTL is not set
> CONFIG_IDE_PROC_FS=y
>
> #
> # IDE chipset support/bugfixes
> #
> # CONFIG_BLK_DEV_PLATFORM is not set
> CONFIG_BLK_DEV_IDEDMA_SFF=y
>
> #
> # PCI IDE chipsets support
> #
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_PCIBUS_ORDER=y
> # CONFIG_BLK_DEV_OFFBOARD is not set
> CONFIG_BLK_DEV_GENERIC=y
> # CONFIG_BLK_DEV_OPTI621 is not set
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> CONFIG_BLK_DEV_AMD74XX=y
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_JMICRON is not set
> # CONFIG_BLK_DEV_PIIX is not set
> # CONFIG_BLK_DEV_IT8172 is not set
> # CONFIG_BLK_DEV_IT8213 is not set
> # CONFIG_BLK_DEV_IT821X is not set
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SL82C105 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_BLK_DEV_TC86C001 is not set
> CONFIG_BLK_DEV_IDE_PMAC=y
> CONFIG_BLK_DEV_IDE_PMAC_ATA100FIRST=y
> CONFIG_BLK_DEV_IDEDMA=y
>
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> CONFIG_RAID_ATTRS=m
> CONFIG_SCSI=y
> CONFIG_SCSI_DMA=y
> CONFIG_SCSI_NETLINK=y
> # CONFIG_SCSI_MQ_DEFAULT is not set
> CONFIG_SCSI_PROC_FS=y
>
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=y
> CONFIG_CHR_DEV_ST=y
> # CONFIG_CHR_DEV_OSST is not set
> CONFIG_BLK_DEV_SR=y
> CONFIG_BLK_DEV_SR_VENDOR=y
> CONFIG_CHR_DEV_SG=y
> # CONFIG_CHR_DEV_SCH is not set
> CONFIG_SCSI_CONSTANTS=y
> # CONFIG_SCSI_LOGGING is not set
> # CONFIG_SCSI_SCAN_ASYNC is not set
>
> #
> # SCSI Transports
> #
> CONFIG_SCSI_SPI_ATTRS=y
> CONFIG_SCSI_FC_ATTRS=y
> CONFIG_SCSI_ISCSI_ATTRS=m
> CONFIG_SCSI_SAS_ATTRS=m
> # CONFIG_SCSI_SAS_LIBSAS is not set
> CONFIG_SCSI_SRP_ATTRS=y
> CONFIG_SCSI_LOWLEVEL=y
> # CONFIG_ISCSI_TCP is not set
> CONFIG_ISCSI_BOOT_SYSFS=m
> CONFIG_SCSI_CXGB3_ISCSI=m
> CONFIG_SCSI_CXGB4_ISCSI=m
> CONFIG_SCSI_BNX2_ISCSI=m
> CONFIG_BE2ISCSI=m
> CONFIG_CXLFLASH=m
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_HPSA is not set
> # CONFIG_SCSI_3W_9XXX is not set
> # CONFIG_SCSI_3W_SAS is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_AIC94XX is not set
> # CONFIG_SCSI_MVSAS is not set
> # CONFIG_SCSI_MVUMI is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_ARCMSR is not set
> # CONFIG_SCSI_ESAS2R is not set
> # CONFIG_MEGARAID_NEWGEN is not set
> # CONFIG_MEGARAID_LEGACY is not set
> # CONFIG_MEGARAID_SAS is not set
> CONFIG_SCSI_MPT3SAS=m
> CONFIG_SCSI_MPT2SAS_MAX_SGE=128
> CONFIG_SCSI_MPT3SAS_MAX_SGE=128
> CONFIG_SCSI_MPT2SAS=m
> # CONFIG_SCSI_UFSHCD is not set
> # CONFIG_SCSI_HPTIOP is not set
> # CONFIG_LIBFC is not set
> # CONFIG_SCSI_SNIC is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_IPS is not set
> CONFIG_SCSI_IBMVSCSI=y
> CONFIG_SCSI_IBMVFC=m
> CONFIG_SCSI_IBMVFC_TRACE=y
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_STEX is not set
> CONFIG_SCSI_SYM53C8XX_2=y
> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
> CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
> CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
> CONFIG_SCSI_SYM53C8XX_MMIO=y
> CONFIG_SCSI_IPR=y
> CONFIG_SCSI_IPR_TRACE=y
> CONFIG_SCSI_IPR_DUMP=y
> # CONFIG_SCSI_QLOGIC_1280 is not set
> CONFIG_SCSI_QLA_FC=m
> CONFIG_SCSI_QLA_ISCSI=m
> CONFIG_SCSI_LPFC=m
> # CONFIG_SCSI_LPFC_DEBUG_FS is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_WD719X is not set
> # CONFIG_SCSI_DEBUG is not set
> # CONFIG_SCSI_PMCRAID is not set
> # CONFIG_SCSI_PM8001 is not set
> # CONFIG_SCSI_BFA_FC is not set
> CONFIG_SCSI_VIRTIO=m
> # CONFIG_SCSI_CHELSIO_FCOE is not set
> # CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
> CONFIG_SCSI_DH=y
> CONFIG_SCSI_DH_RDAC=m
> # CONFIG_SCSI_DH_HP_SW is not set
> # CONFIG_SCSI_DH_EMC is not set
> CONFIG_SCSI_DH_ALUA=m
> # CONFIG_SCSI_OSD_INITIATOR is not set
> CONFIG_ATA=y
> CONFIG_ATA_NONSTANDARD=y
> CONFIG_ATA_VERBOSE_ERROR=y
> CONFIG_SATA_PMP=y
>
> #
> # Controllers with non-SFF native interface
> #
> CONFIG_SATA_AHCI=y
> # CONFIG_SATA_AHCI_PLATFORM is not set
> # CONFIG_AHCI_CEVA is not set
> # CONFIG_AHCI_QORIQ is not set
> # CONFIG_SATA_INIC162X is not set
> # CONFIG_SATA_ACARD_AHCI is not set
> CONFIG_SATA_SIL24=y
> CONFIG_ATA_SFF=y
>
> #
> # SFF controllers with custom DMA interface
> #
> # CONFIG_PDC_ADMA is not set
> # CONFIG_SATA_QSTOR is not set
> # CONFIG_SATA_SX4 is not set
> CONFIG_ATA_BMDMA=y
>
> #
> # SATA SFF controllers with BMDMA
> #
> # CONFIG_ATA_PIIX is not set
> CONFIG_SATA_MV=y
> # CONFIG_SATA_NV is not set
> # CONFIG_SATA_PROMISE is not set
> # CONFIG_SATA_SIL is not set
> # CONFIG_SATA_SIS is not set
> CONFIG_SATA_SVW=y
> # CONFIG_SATA_ULI is not set
> # CONFIG_SATA_VIA is not set
> # CONFIG_SATA_VITESSE is not set
>
> #
> # PATA SFF controllers with BMDMA
> #
> # CONFIG_PATA_ALI is not set
> # CONFIG_PATA_AMD is not set
> # CONFIG_PATA_ARTOP is not set
> # CONFIG_PATA_ATIIXP is not set
> # CONFIG_PATA_ATP867X is not set
> # CONFIG_PATA_CMD64X is not set
> # CONFIG_PATA_CYPRESS is not set
> # CONFIG_PATA_EFAR is not set
> # CONFIG_PATA_HPT366 is not set
> # CONFIG_PATA_HPT37X is not set
> # CONFIG_PATA_HPT3X2N is not set
> # CONFIG_PATA_HPT3X3 is not set
> # CONFIG_PATA_IT8213 is not set
> # CONFIG_PATA_IT821X is not set
> # CONFIG_PATA_JMICRON is not set
> # CONFIG_PATA_MACIO is not set
> # CONFIG_PATA_MARVELL is not set
> # CONFIG_PATA_NETCELL is not set
> # CONFIG_PATA_NINJA32 is not set
> # CONFIG_PATA_NS87415 is not set
> # CONFIG_PATA_OLDPIIX is not set
> # CONFIG_PATA_OPTIDMA is not set
> # CONFIG_PATA_PDC2027X is not set
> # CONFIG_PATA_PDC_OLD is not set
> # CONFIG_PATA_RADISYS is not set
> # CONFIG_PATA_RDC is not set
> # CONFIG_PATA_SCH is not set
> # CONFIG_PATA_SERVERWORKS is not set
> # CONFIG_PATA_SIL680 is not set
> # CONFIG_PATA_SIS is not set
> # CONFIG_PATA_TOSHIBA is not set
> # CONFIG_PATA_TRIFLEX is not set
> # CONFIG_PATA_VIA is not set
> # CONFIG_PATA_WINBOND is not set
>
> #
> # PIO-only SFF controllers
> #
> # CONFIG_PATA_CMD640_PCI is not set
> # CONFIG_PATA_MPIIX is not set
> # CONFIG_PATA_NS87410 is not set
> # CONFIG_PATA_OPTI is not set
> # CONFIG_PATA_PCMCIA is not set
> # CONFIG_PATA_PLATFORM is not set
> # CONFIG_PATA_RZ1000 is not set
>
> #
> # Generic fallback / legacy drivers
> #
> # CONFIG_ATA_GENERIC is not set
> # CONFIG_PATA_LEGACY is not set
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=y
> CONFIG_MD_AUTODETECT=y
> CONFIG_MD_LINEAR=y
> CONFIG_MD_RAID0=y
> CONFIG_MD_RAID1=y
> CONFIG_MD_RAID10=m
> CONFIG_MD_RAID456=m
> CONFIG_MD_MULTIPATH=m
> CONFIG_MD_FAULTY=m
> # CONFIG_BCACHE is not set
> CONFIG_BLK_DEV_DM_BUILTIN=y
> CONFIG_BLK_DEV_DM=y
> # CONFIG_DM_MQ_DEFAULT is not set
> # CONFIG_DM_DEBUG is not set
> CONFIG_DM_BUFIO=m
> CONFIG_DM_CRYPT=m
> CONFIG_DM_SNAPSHOT=m
> # CONFIG_DM_THIN_PROVISIONING is not set
> # CONFIG_DM_CACHE is not set
> # CONFIG_DM_ERA is not set
> CONFIG_DM_MIRROR=m
> # CONFIG_DM_LOG_USERSPACE is not set
> # CONFIG_DM_RAID is not set
> CONFIG_DM_ZERO=m
> CONFIG_DM_MULTIPATH=m
> CONFIG_DM_MULTIPATH_QL=m
> CONFIG_DM_MULTIPATH_ST=m
> # CONFIG_DM_DELAY is not set
> CONFIG_DM_UEVENT=y
> # CONFIG_DM_FLAKEY is not set
> # CONFIG_DM_VERITY is not set
> # CONFIG_DM_SWITCH is not set
> # CONFIG_DM_LOG_WRITES is not set
> # CONFIG_TARGET_CORE is not set
> # CONFIG_FUSION is not set
>
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_FIREWIRE is not set
> # CONFIG_FIREWIRE_NOSY is not set
> CONFIG_MACINTOSH_DRIVERS=y
> CONFIG_ADB_PMU=y
> # CONFIG_ADB_PMU_LED is not set
> CONFIG_PMAC_SMU=y
> # CONFIG_MAC_EMUMOUSEBTN is not set
> CONFIG_WINDFARM=y
> CONFIG_WINDFARM_PM81=y
> # CONFIG_WINDFARM_PM72 is not set
> # CONFIG_WINDFARM_RM31 is not set
> CONFIG_WINDFARM_PM91=y
> CONFIG_WINDFARM_PM112=y
> CONFIG_WINDFARM_PM121=y
> # CONFIG_PMAC_RACKMETER is not set
> CONFIG_NETDEVICES=y
> CONFIG_MII=y
> CONFIG_NET_CORE=y
> CONFIG_BONDING=m
> CONFIG_DUMMY=m
> # CONFIG_EQUALIZER is not set
> # CONFIG_NET_FC is not set
> # CONFIG_NET_TEAM is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_VXLAN is not set
> CONFIG_NETCONSOLE=y
> CONFIG_NETPOLL=y
> CONFIG_NET_POLL_CONTROLLER=y
> CONFIG_TUN=m
> # CONFIG_TUN_VNET_CROSS_LE is not set
> # CONFIG_VETH is not set
> CONFIG_VIRTIO_NET=m
> # CONFIG_NLMON is not set
> CONFIG_SUNGEM_PHY=y
> # CONFIG_ARCNET is not set
>
> #
> # CAIF transport drivers
> #
> CONFIG_VHOST_NET=m
> CONFIG_VHOST_RING=m
> CONFIG_VHOST=m
> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
>
> #
> # Distributed Switch Architecture drivers
> #
> # CONFIG_NET_DSA_MV88E6XXX is not set
> # CONFIG_NET_DSA_MV88E6XXX_NEED_PPU is not set
> CONFIG_ETHERNET=y
> CONFIG_MDIO=m
> CONFIG_NET_VENDOR_3COM=y
> # CONFIG_PCMCIA_3C574 is not set
> # CONFIG_PCMCIA_3C589 is not set
> CONFIG_VORTEX=y
> # CONFIG_TYPHOON is not set
> CONFIG_NET_VENDOR_ADAPTEC=y
> # CONFIG_ADAPTEC_STARFIRE is not set
> CONFIG_NET_VENDOR_AGERE=y
> # CONFIG_ET131X is not set
> CONFIG_NET_VENDOR_ALTEON=y
> CONFIG_ACENIC=m
> CONFIG_ACENIC_OMIT_TIGON_I=y
> # CONFIG_ALTERA_TSE is not set
> CONFIG_NET_VENDOR_AMD=y
> # CONFIG_AMD8111_ETH is not set
> CONFIG_PCNET32=y
> # CONFIG_PCMCIA_NMCLAN is not set
> CONFIG_NET_VENDOR_ARC=y
> # CONFIG_ARC_EMAC is not set
> CONFIG_NET_VENDOR_ATHEROS=y
> # CONFIG_ATL2 is not set
> # CONFIG_ATL1 is not set
> # CONFIG_ATL1E is not set
> # CONFIG_ATL1C is not set
> # CONFIG_ALX is not set
> # CONFIG_NET_VENDOR_AURORA is not set
> CONFIG_NET_CADENCE=y
> # CONFIG_MACB is not set
> CONFIG_NET_VENDOR_BROADCOM=y
> # CONFIG_B44 is not set
> # CONFIG_BCMGENET is not set
> CONFIG_BNX2=m
> CONFIG_CNIC=m
> CONFIG_TIGON3=y
> CONFIG_BNX2X=m
> # CONFIG_SYSTEMPORT is not set
> # CONFIG_BNXT is not set
> CONFIG_NET_VENDOR_BROCADE=y
> # CONFIG_BNA is not set
> CONFIG_NET_VENDOR_CAVIUM=y
> # CONFIG_THUNDER_NIC_PF is not set
> # CONFIG_THUNDER_NIC_VF is not set
> # CONFIG_THUNDER_NIC_BGX is not set
> # CONFIG_LIQUIDIO is not set
> CONFIG_NET_VENDOR_CHELSIO=y
> CONFIG_CHELSIO_T1=m
> # CONFIG_CHELSIO_T1_1G is not set
> CONFIG_CHELSIO_T3=m
> CONFIG_CHELSIO_T4=m
> # CONFIG_CHELSIO_T4VF is not set
> CONFIG_NET_VENDOR_CISCO=y
> # CONFIG_ENIC is not set
> # CONFIG_DNET is not set
> CONFIG_NET_VENDOR_DEC=y
> # CONFIG_NET_TULIP is not set
> CONFIG_NET_VENDOR_DLINK=y
> # CONFIG_DL2K is not set
> # CONFIG_SUNDANCE is not set
> CONFIG_NET_VENDOR_EMULEX=y
> CONFIG_BE2NET=m
> CONFIG_BE2NET_HWMON=y
> CONFIG_NET_VENDOR_EZCHIP=y
> # CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
> CONFIG_NET_VENDOR_EXAR=y
> CONFIG_S2IO=m
> # CONFIG_VXGE is not set
> CONFIG_NET_VENDOR_FUJITSU=y
> # CONFIG_PCMCIA_FMVJ18X is not set
> CONFIG_NET_VENDOR_HP=y
> # CONFIG_HP100 is not set
> CONFIG_NET_VENDOR_IBM=y
> CONFIG_IBMVETH=m
> # CONFIG_IBM_EMAC is not set
> CONFIG_IBM_EMAC_ZMII=y
> CONFIG_IBM_EMAC_RGMII=y
> CONFIG_IBM_EMAC_TAH=y
> CONFIG_IBM_EMAC_EMAC4=y
> # CONFIG_IBM_EMAC_NO_FLOW_CTRL is not set
> # CONFIG_IBM_EMAC_MAL_CLR_ICINTSTAT is not set
> # CONFIG_IBM_EMAC_MAL_COMMON_ERR is not set
> CONFIG_EHEA=m
> CONFIG_NET_VENDOR_INTEL=y
> CONFIG_E100=y
> CONFIG_E1000=y
> CONFIG_E1000E=y
> # CONFIG_IGB is not set
> # CONFIG_IGBVF is not set
> CONFIG_IXGB=m
> CONFIG_IXGBE=m
> CONFIG_IXGBE_HWMON=y
> # CONFIG_IXGBEVF is not set
> # CONFIG_I40E is not set
> # CONFIG_I40EVF is not set
> # CONFIG_FM10K is not set
> CONFIG_NET_VENDOR_I825XX=y
> # CONFIG_JME is not set
> CONFIG_NET_VENDOR_MARVELL=y
> # CONFIG_MVMDIO is not set
> # CONFIG_SKGE is not set
> # CONFIG_SKY2 is not set
> CONFIG_NET_VENDOR_MELLANOX=y
> CONFIG_MLX4_EN=m
> CONFIG_MLX4_CORE=m
> CONFIG_MLX4_DEBUG=y
> # CONFIG_MLX5_CORE is not set
> # CONFIG_MLXSW_CORE is not set
> CONFIG_NET_VENDOR_MICREL=y
> # CONFIG_KS8851_MLL is not set
> # CONFIG_KSZ884X_PCI is not set
> CONFIG_NET_VENDOR_MYRI=y
> CONFIG_MYRI10GE=m
> # CONFIG_FEALNX is not set
> CONFIG_NET_VENDOR_NATSEMI=y
> # CONFIG_NATSEMI is not set
> # CONFIG_NS83820 is not set
> CONFIG_NET_VENDOR_8390=y
> # CONFIG_PCMCIA_AXNET is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_PCMCIA_PCNET is not set
> CONFIG_NET_VENDOR_NVIDIA=y
> # CONFIG_FORCEDETH is not set
> CONFIG_NET_VENDOR_OKI=y
> # CONFIG_ETHOC is not set
> CONFIG_NET_PACKET_ENGINE=y
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> CONFIG_NET_VENDOR_PASEMI=y
> CONFIG_PASEMI_MAC=y
> CONFIG_NET_VENDOR_QLOGIC=y
> # CONFIG_QLA3XXX is not set
> # CONFIG_QLCNIC is not set
> CONFIG_QLGE=m
> CONFIG_NETXEN_NIC=m
> # CONFIG_QED is not set
> CONFIG_NET_VENDOR_QUALCOMM=y
> CONFIG_NET_VENDOR_REALTEK=y
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> # CONFIG_R8169 is not set
> CONFIG_NET_VENDOR_RENESAS=y
> CONFIG_NET_VENDOR_RDC=y
> # CONFIG_R6040 is not set
> CONFIG_NET_VENDOR_ROCKER=y
> CONFIG_NET_VENDOR_SAMSUNG=y
> # CONFIG_SXGBE_ETH is not set
> CONFIG_NET_VENDOR_SEEQ=y
> CONFIG_NET_VENDOR_SILAN=y
> # CONFIG_SC92031 is not set
> CONFIG_NET_VENDOR_SIS=y
> # CONFIG_SIS900 is not set
> # CONFIG_SIS190 is not set
> # CONFIG_SFC is not set
> CONFIG_NET_VENDOR_SMSC=y
> # CONFIG_PCMCIA_SMC91C92 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SMSC911X is not set
> # CONFIG_SMSC9420 is not set
> CONFIG_NET_VENDOR_STMICRO=y
> # CONFIG_STMMAC_ETH is not set
> CONFIG_NET_VENDOR_SUN=y
> # CONFIG_HAPPYMEAL is not set
> CONFIG_SUNGEM=y
> # CONFIG_CASSINI is not set
> # CONFIG_NIU is not set
> CONFIG_NET_VENDOR_SYNOPSYS=y
> # CONFIG_SYNOPSYS_DWC_ETH_QOS is not set
> CONFIG_NET_VENDOR_TEHUTI=y
> # CONFIG_TEHUTI is not set
> CONFIG_NET_VENDOR_TI=y
> # CONFIG_TI_CPSW_ALE is not set
> # CONFIG_TLAN is not set
> CONFIG_NET_VENDOR_TOSHIBA=y
> CONFIG_GELIC_NET=m
> CONFIG_GELIC_WIRELESS=y
> CONFIG_SPIDER_NET=m
> CONFIG_NET_VENDOR_VIA=y
> # CONFIG_VIA_RHINE is not set
> # CONFIG_VIA_VELOCITY is not set
> CONFIG_NET_VENDOR_WIZNET=y
> # CONFIG_WIZNET_W5100 is not set
> # CONFIG_WIZNET_W5300 is not set
> CONFIG_NET_VENDOR_XILINX=y
> # CONFIG_XILINX_LL_TEMAC is not set
> CONFIG_NET_VENDOR_XIRCOM=y
> # CONFIG_PCMCIA_XIRC2PS is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> CONFIG_PHYLIB=y
>
> #
> # MII PHY device drivers
> #
> # CONFIG_AQUANTIA_PHY is not set
> # CONFIG_AT803X_PHY is not set
> # CONFIG_AMD_PHY is not set
> CONFIG_MARVELL_PHY=y
> # CONFIG_DAVICOM_PHY is not set
> # CONFIG_QSEMI_PHY is not set
> # CONFIG_LXT_PHY is not set
> # CONFIG_CICADA_PHY is not set
> # CONFIG_VITESSE_PHY is not set
> # CONFIG_TERANETICS_PHY is not set
> # CONFIG_SMSC_PHY is not set
> CONFIG_BCM_NET_PHYLIB=m
> CONFIG_BROADCOM_PHY=m
> # CONFIG_BCM7XXX_PHY is not set
> # CONFIG_BCM87XX_PHY is not set
> # CONFIG_ICPLUS_PHY is not set
> # CONFIG_REALTEK_PHY is not set
> # CONFIG_NATIONAL_PHY is not set
> # CONFIG_STE10XP is not set
> # CONFIG_LSI_ET1011C_PHY is not set
> # CONFIG_MICREL_PHY is not set
> # CONFIG_DP83848_PHY is not set
> # CONFIG_DP83867_PHY is not set
> # CONFIG_MICROCHIP_PHY is not set
> # CONFIG_FIXED_PHY is not set
> # CONFIG_MDIO_BITBANG is not set
> # CONFIG_MDIO_OCTEON is not set
> # CONFIG_MDIO_BUS_MUX_MMIOREG is not set
> # CONFIG_MDIO_BCM_UNIMAC is not set
> CONFIG_PPP=m
> CONFIG_PPP_BSDCOMP=m
> CONFIG_PPP_DEFLATE=m
> # CONFIG_PPP_FILTER is not set
> # CONFIG_PPP_MPPE is not set
> # CONFIG_PPP_MULTILINK is not set
> CONFIG_PPPOE=m
> CONFIG_PPP_ASYNC=m
> CONFIG_PPP_SYNC_TTY=m
> # CONFIG_SLIP is not set
> CONFIG_SLHC=m
> CONFIG_USB_NET_DRIVERS=y
> # CONFIG_USB_CATC is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_RTL8150 is not set
> # CONFIG_USB_RTL8152 is not set
> # CONFIG_USB_LAN78XX is not set
> # CONFIG_USB_USBNET is not set
> # CONFIG_USB_IPHETH is not set
> CONFIG_WLAN=y
> # CONFIG_PCMCIA_RAYCS is not set
> # CONFIG_PRISM54 is not set
> # CONFIG_HOSTAP is not set
> # CONFIG_WL_MEDIATEK is not set
> # CONFIG_WL_TI is not set
>
> #
> # Enable WiMAX (Networking options) to see the WiMAX drivers
> #
> # CONFIG_WAN is not set
> # CONFIG_VMXNET3 is not set
> # CONFIG_ISDN is not set
> # CONFIG_NVM is not set
>
> #
> # Input device support
> #
> CONFIG_INPUT=y
> CONFIG_INPUT_LEDS=m
> # CONFIG_INPUT_FF_MEMLESS is not set
> # CONFIG_INPUT_POLLDEV is not set
> # CONFIG_INPUT_SPARSEKMAP is not set
> # CONFIG_INPUT_MATRIXKMAP is not set
>
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> # CONFIG_INPUT_JOYDEV is not set
> CONFIG_INPUT_EVDEV=m
> # CONFIG_INPUT_EVBUG is not set
>
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> # CONFIG_KEYBOARD_ADP5588 is not set
> # CONFIG_KEYBOARD_ADP5589 is not set
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_QT1070 is not set
> # CONFIG_KEYBOARD_QT2160 is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_TCA6416 is not set
> # CONFIG_KEYBOARD_TCA8418 is not set
> # CONFIG_KEYBOARD_LM8323 is not set
> # CONFIG_KEYBOARD_LM8333 is not set
> # CONFIG_KEYBOARD_MAX7359 is not set
> # CONFIG_KEYBOARD_MCS is not set
> # CONFIG_KEYBOARD_MPR121 is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_OPENCORES is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_OMAP4 is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_CAP11XX is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> CONFIG_MOUSE_PS2_ALPS=y
> CONFIG_MOUSE_PS2_LOGIPS2PP=y
> CONFIG_MOUSE_PS2_SYNAPTICS=y
> CONFIG_MOUSE_PS2_CYPRESS=y
> CONFIG_MOUSE_PS2_TRACKPOINT=y
> # CONFIG_MOUSE_PS2_ELANTECH is not set
> # CONFIG_MOUSE_PS2_SENTELIC is not set
> # CONFIG_MOUSE_PS2_TOUCHKIT is not set
> CONFIG_MOUSE_PS2_FOCALTECH=y
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_APPLETOUCH is not set
> # CONFIG_MOUSE_BCM5974 is not set
> # CONFIG_MOUSE_CYAPA is not set
> # CONFIG_MOUSE_ELAN_I2C is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> # CONFIG_MOUSE_SYNAPTICS_I2C is not set
> # CONFIG_MOUSE_SYNAPTICS_USB is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> # CONFIG_INPUT_AD714X is not set
> # CONFIG_INPUT_BMA150 is not set
> # CONFIG_INPUT_E3X0_BUTTON is not set
> CONFIG_INPUT_PCSPKR=m
> # CONFIG_INPUT_MMA8450 is not set
> # CONFIG_INPUT_MPU3050 is not set
> # CONFIG_INPUT_ATI_REMOTE2 is not set
> # CONFIG_INPUT_KEYSPAN_REMOTE is not set
> # CONFIG_INPUT_KXTJ9 is not set
> # CONFIG_INPUT_POWERMATE is not set
> # CONFIG_INPUT_YEALINK is not set
> # CONFIG_INPUT_CM109 is not set
> # CONFIG_INPUT_UINPUT is not set
> # CONFIG_INPUT_PCF8574 is not set
> # CONFIG_INPUT_ADXL34X is not set
> # CONFIG_INPUT_IMS_PCU is not set
> # CONFIG_INPUT_CMA3000 is not set
> # CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
> # CONFIG_INPUT_DRV2665_HAPTICS is not set
> # CONFIG_INPUT_DRV2667_HAPTICS is not set
>
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> CONFIG_SERIO_I8042=y
> # CONFIG_SERIO_SERPORT is not set
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=y
> # CONFIG_SERIO_RAW is not set
> # CONFIG_SERIO_XILINX_XPS_PS2 is not set
> # CONFIG_SERIO_ALTERA_PS2 is not set
> # CONFIG_SERIO_PS2MULT is not set
> # CONFIG_SERIO_ARC_PS2 is not set
> # CONFIG_SERIO_APBPS2 is not set
> # CONFIG_USERIO is not set
> # CONFIG_GAMEPORT is not set
>
> #
> # Character devices
> #
> CONFIG_TTY=y
> CONFIG_VT=y
> CONFIG_CONSOLE_TRANSLATIONS=y
> CONFIG_VT_CONSOLE=y
> CONFIG_VT_CONSOLE_SLEEP=y
> CONFIG_HW_CONSOLE=y
> CONFIG_VT_HW_CONSOLE_BINDING=y
> CONFIG_UNIX98_PTYS=y
> # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256
> # CONFIG_SERIAL_NONSTANDARD is not set
> # CONFIG_NOZOMI is not set
> # CONFIG_N_GSM is not set
> # CONFIG_TRACE_SINK is not set
> # CONFIG_PPC_EPAPR_HV_BYTECHAN is not set
> CONFIG_DEVMEM=y
> CONFIG_DEVKMEM=y
>
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_PCI=y
> # CONFIG_SERIAL_8250_CS is not set
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> CONFIG_SERIAL_8250_FSL=y
> # CONFIG_SERIAL_8250_DW is not set
> # CONFIG_SERIAL_8250_RT288X is not set
> # CONFIG_SERIAL_8250_INGENIC is not set
> # CONFIG_SERIAL_8250_MID is not set
>
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_UARTLITE is not set
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> # CONFIG_SERIAL_PMACZILOG is not set
> CONFIG_SERIAL_ICOM=m
> CONFIG_SERIAL_JSM=m
> # CONFIG_SERIAL_OF_PLATFORM is not set
> # CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL is not set
> # CONFIG_SERIAL_SCCNXP is not set
> # CONFIG_SERIAL_SC16IS7XX is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> # CONFIG_SERIAL_XILINX_PS_UART is not set
> # CONFIG_SERIAL_ARC is not set
> # CONFIG_SERIAL_RP2 is not set
> # CONFIG_SERIAL_FSL_LPUART is not set
> # CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
> CONFIG_HVC_DRIVER=y
> CONFIG_HVC_IRQ=y
> CONFIG_HVC_CONSOLE=y
> # CONFIG_HVC_OLD_HVSI is not set
> CONFIG_HVC_OPAL=y
> CONFIG_HVC_RTAS=y
> # CONFIG_HVC_UDBG is not set
> CONFIG_HVCS=m
> CONFIG_VIRTIO_CONSOLE=m
> CONFIG_IBM_BSR=m
> # CONFIG_IPMI_HANDLER is not set
> CONFIG_HW_RANDOM=m
> # CONFIG_HW_RANDOM_TIMERIOMEM is not set
> CONFIG_HW_RANDOM_AMD=m
> CONFIG_HW_RANDOM_PASEMI=m
> # CONFIG_HW_RANDOM_VIRTIO is not set
> CONFIG_HW_RANDOM_PSERIES=m
> CONFIG_HW_RANDOM_POWERNV=m
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
>
> #
> # PCMCIA character devices
> #
> # CONFIG_SYNCLINK_CS is not set
> # CONFIG_CARDMAN_4000 is not set
> # CONFIG_CARDMAN_4040 is not set
> # CONFIG_IPWIRELESS is not set
> CONFIG_RAW_DRIVER=y
> CONFIG_MAX_RAW_DEVS=256
> # CONFIG_HANGCHECK_TIMER is not set
> # CONFIG_TCG_TPM is not set
> CONFIG_DEVPORT=y
> # CONFIG_XILLYBUS is not set
>
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_COMPAT=y
> CONFIG_I2C_CHARDEV=y
> # CONFIG_I2C_MUX is not set
> CONFIG_I2C_HELPER_AUTO=y
> CONFIG_I2C_ALGOBIT=y
>
> #
> # I2C Hardware Bus support
> #
>
> #
> # PC SMBus host controller drivers
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> CONFIG_I2C_AMD8111=y
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_ISCH is not set
> # CONFIG_I2C_PIIX4 is not set
> # CONFIG_I2C_NFORCE2 is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> # CONFIG_I2C_SIS96X is not set
> # CONFIG_I2C_VIA is not set
> # CONFIG_I2C_VIAPRO is not set
>
> #
> # Mac SMBus host controller drivers
> #
> CONFIG_I2C_POWERMAC=y
>
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_DESIGNWARE_PLATFORM is not set
> # CONFIG_I2C_DESIGNWARE_PCI is not set
> # CONFIG_I2C_MPC is not set
> # CONFIG_I2C_OCORES is not set
> CONFIG_I2C_PASEMI=y
> # CONFIG_I2C_PCA_PLATFORM is not set
> # CONFIG_I2C_PXA_PCI is not set
> # CONFIG_I2C_SIMTEC is not set
> # CONFIG_I2C_XILINX is not set
>
> #
> # External I2C/SMBus adapter drivers
> #
> # CONFIG_I2C_DIOLAN_U2C is not set
> # CONFIG_I2C_PARPORT_LIGHT is not set
> # CONFIG_I2C_ROBOTFUZZ_OSIF is not set
> # CONFIG_I2C_TAOS_EVM is not set
> # CONFIG_I2C_TINY_USB is not set
>
> #
> # Other I2C/SMBus bus drivers
> #
> CONFIG_I2C_OPAL=y
> # CONFIG_I2C_STUB is not set
> # CONFIG_I2C_SLAVE is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # CONFIG_SPI is not set
> # CONFIG_SPMI is not set
> # CONFIG_HSI is not set
>
> #
> # PPS support
> #
> CONFIG_PPS=y
> # CONFIG_PPS_DEBUG is not set
>
> #
> # PPS clients support
> #
> # CONFIG_PPS_CLIENT_KTIMER is not set
> # CONFIG_PPS_CLIENT_LDISC is not set
> # CONFIG_PPS_CLIENT_GPIO is not set
>
> #
> # PPS generators support
> #
>
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK=y
>
> #
> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> #
> CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
> # CONFIG_GPIOLIB is not set
> # CONFIG_W1 is not set
> # CONFIG_POWER_SUPPLY is not set
> # CONFIG_POWER_AVS is not set
> CONFIG_HWMON=y
> # CONFIG_HWMON_VID is not set
> # CONFIG_HWMON_DEBUG_CHIP is not set
>
> #
> # Native drivers
> #
> # CONFIG_SENSORS_AD7414 is not set
> # CONFIG_SENSORS_AD7418 is not set
> # CONFIG_SENSORS_ADM1021 is not set
> # CONFIG_SENSORS_ADM1025 is not set
> # CONFIG_SENSORS_ADM1026 is not set
> # CONFIG_SENSORS_ADM1029 is not set
> # CONFIG_SENSORS_ADM1031 is not set
> # CONFIG_SENSORS_ADM9240 is not set
> # CONFIG_SENSORS_ADT7410 is not set
> # CONFIG_SENSORS_ADT7411 is not set
> # CONFIG_SENSORS_ADT7462 is not set
> # CONFIG_SENSORS_ADT7470 is not set
> # CONFIG_SENSORS_ADT7475 is not set
> # CONFIG_SENSORS_ASC7621 is not set
> # CONFIG_SENSORS_ATXP1 is not set
> # CONFIG_SENSORS_DS620 is not set
> # CONFIG_SENSORS_DS1621 is not set
> # CONFIG_SENSORS_I5K_AMB is not set
> # CONFIG_SENSORS_F75375S is not set
> # CONFIG_SENSORS_GL518SM is not set
> # CONFIG_SENSORS_GL520SM is not set
> # CONFIG_SENSORS_G760A is not set
> # CONFIG_SENSORS_G762 is not set
> # CONFIG_SENSORS_HIH6130 is not set
> CONFIG_SENSORS_IBMPOWERNV=y
> # CONFIG_SENSORS_JC42 is not set
> # CONFIG_SENSORS_POWR1220 is not set
> # CONFIG_SENSORS_LINEAGE is not set
> # CONFIG_SENSORS_LTC2945 is not set
> # CONFIG_SENSORS_LTC4151 is not set
> # CONFIG_SENSORS_LTC4215 is not set
> # CONFIG_SENSORS_LTC4222 is not set
> # CONFIG_SENSORS_LTC4245 is not set
> # CONFIG_SENSORS_LTC4260 is not set
> # CONFIG_SENSORS_LTC4261 is not set
> # CONFIG_SENSORS_MAX16065 is not set
> # CONFIG_SENSORS_MAX1619 is not set
> # CONFIG_SENSORS_MAX1668 is not set
> # CONFIG_SENSORS_MAX197 is not set
> # CONFIG_SENSORS_MAX6639 is not set
> # CONFIG_SENSORS_MAX6642 is not set
> # CONFIG_SENSORS_MAX6650 is not set
> # CONFIG_SENSORS_MAX6697 is not set
> # CONFIG_SENSORS_MAX31790 is not set
> # CONFIG_SENSORS_HTU21 is not set
> # CONFIG_SENSORS_MCP3021 is not set
> # CONFIG_SENSORS_LM63 is not set
> # CONFIG_SENSORS_LM73 is not set
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
> # CONFIG_SENSORS_LM95234 is not set
> # CONFIG_SENSORS_LM95241 is not set
> # CONFIG_SENSORS_LM95245 is not set
> # CONFIG_SENSORS_NTC_THERMISTOR is not set
> # CONFIG_SENSORS_NCT7802 is not set
> # CONFIG_SENSORS_NCT7904 is not set
> # CONFIG_SENSORS_PCF8591 is not set
> # CONFIG_PMBUS is not set
> # CONFIG_SENSORS_SHT21 is not set
> # CONFIG_SENSORS_SHTC1 is not set
> # CONFIG_SENSORS_SIS5595 is not set
> # CONFIG_SENSORS_EMC1403 is not set
> # CONFIG_SENSORS_EMC2103 is not set
> # CONFIG_SENSORS_EMC6W201 is not set
> # CONFIG_SENSORS_SMSC47M192 is not set
> # CONFIG_SENSORS_SCH56XX_COMMON is not set
> # CONFIG_SENSORS_SMM665 is not set
> # CONFIG_SENSORS_ADC128D818 is not set
> # CONFIG_SENSORS_ADS1015 is not set
> # CONFIG_SENSORS_ADS7828 is not set
> # CONFIG_SENSORS_AMC6821 is not set
> # CONFIG_SENSORS_INA209 is not set
> # CONFIG_SENSORS_INA2XX is not set
> # CONFIG_SENSORS_TC74 is not set
> # CONFIG_SENSORS_THMC50 is not set
> # CONFIG_SENSORS_TMP102 is not set
> # CONFIG_SENSORS_TMP103 is not set
> # CONFIG_SENSORS_TMP401 is not set
> # CONFIG_SENSORS_TMP421 is not set
> # CONFIG_SENSORS_VIA686A is not set
> # CONFIG_SENSORS_VT8231 is not set
> # CONFIG_SENSORS_W83781D is not set
> # CONFIG_SENSORS_W83791D is not set
> # CONFIG_SENSORS_W83792D is not set
> # CONFIG_SENSORS_W83793 is not set
> # CONFIG_SENSORS_W83795 is not set
> # CONFIG_SENSORS_W83L785TS is not set
> # CONFIG_SENSORS_W83L786NG is not set
> # CONFIG_THERMAL is not set
> # CONFIG_WATCHDOG is not set
> CONFIG_SSB_POSSIBLE=y
>
> #
> # Sonics Silicon Backplane
> #
> # CONFIG_SSB is not set
> CONFIG_BCMA_POSSIBLE=y
>
> #
> # Broadcom specific AMBA
> #
> # CONFIG_BCMA is not set
>
> #
> # Multifunction device drivers
> #
> # CONFIG_MFD_CORE is not set
> # CONFIG_MFD_AS3711 is not set
> # CONFIG_MFD_AS3722 is not set
> # CONFIG_PMIC_ADP5520 is not set
> # CONFIG_MFD_ATMEL_FLEXCOM is not set
> # CONFIG_MFD_ATMEL_HLCDC is not set
> # CONFIG_MFD_BCM590XX is not set
> # CONFIG_MFD_AXP20X is not set
> # CONFIG_PMIC_DA903X is not set
> # CONFIG_MFD_DA9052_I2C is not set
> # CONFIG_MFD_DA9055 is not set
> # CONFIG_MFD_DA9062 is not set
> # CONFIG_MFD_DA9063 is not set
> # CONFIG_MFD_DA9150 is not set
> # CONFIG_MFD_DLN2 is not set
> # CONFIG_MFD_MC13XXX_I2C is not set
> # CONFIG_MFD_HI6421_PMIC is not set
> # CONFIG_HTC_PASIC3 is not set
> # CONFIG_LPC_ICH is not set
> # CONFIG_LPC_SCH is not set
> # CONFIG_MFD_JANZ_CMODIO is not set
> # CONFIG_MFD_KEMPLD is not set
> # CONFIG_MFD_88PM800 is not set
> # CONFIG_MFD_88PM805 is not set
> # CONFIG_MFD_88PM860X is not set
> # CONFIG_MFD_MAX14577 is not set
> # CONFIG_MFD_MAX77686 is not set
> # CONFIG_MFD_MAX77693 is not set
> # CONFIG_MFD_MAX77843 is not set
> # CONFIG_MFD_MAX8907 is not set
> # CONFIG_MFD_MAX8925 is not set
> # CONFIG_MFD_MAX8997 is not set
> # CONFIG_MFD_MAX8998 is not set
> # CONFIG_MFD_MT6397 is not set
> # CONFIG_MFD_MENF21BMC is not set
> # CONFIG_MFD_VIPERBOARD is not set
> # CONFIG_MFD_RETU is not set
> # CONFIG_MFD_PCF50633 is not set
> # CONFIG_MFD_RDC321X is not set
> # CONFIG_MFD_RTSX_PCI is not set
> # CONFIG_MFD_RT5033 is not set
> # CONFIG_MFD_RTSX_USB is not set
> # CONFIG_MFD_RC5T583 is not set
> # CONFIG_MFD_RK808 is not set
> # CONFIG_MFD_RN5T618 is not set
> # CONFIG_MFD_SEC_CORE is not set
> # CONFIG_MFD_SI476X_CORE is not set
> # CONFIG_MFD_SM501 is not set
> # CONFIG_MFD_SKY81452 is not set
> # CONFIG_MFD_SMSC is not set
> # CONFIG_ABX500_CORE is not set
> # CONFIG_MFD_STMPE is not set
> # CONFIG_MFD_SYSCON is not set
> # CONFIG_MFD_TI_AM335X_TSCADC is not set
> # CONFIG_MFD_LP3943 is not set
> # CONFIG_MFD_LP8788 is not set
> # CONFIG_MFD_PALMAS is not set
> # CONFIG_TPS6105X is not set
> # CONFIG_TPS6507X is not set
> # CONFIG_MFD_TPS65090 is not set
> # CONFIG_MFD_TPS65217 is not set
> # CONFIG_MFD_TPS65218 is not set
> # CONFIG_MFD_TPS6586X is not set
> # CONFIG_MFD_TPS80031 is not set
> # CONFIG_TWL4030_CORE is not set
> # CONFIG_TWL6040_CORE is not set
> # CONFIG_MFD_WL1273_CORE is not set
> # CONFIG_MFD_LM3533 is not set
> # CONFIG_MFD_TC3589X is not set
> # CONFIG_MFD_TMIO is not set
> # CONFIG_MFD_VX855 is not set
> # CONFIG_MFD_ARIZONA_I2C is not set
> # CONFIG_MFD_WM8400 is not set
> # CONFIG_MFD_WM831X_I2C is not set
> # CONFIG_MFD_WM8350_I2C is not set
> # CONFIG_MFD_WM8994 is not set
> # CONFIG_REGULATOR is not set
> # CONFIG_MEDIA_SUPPORT is not set
>
> #
> # Graphics support
> #
> # CONFIG_AGP is not set
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=16
> # CONFIG_DRM is not set
>
> #
> # Frame buffer Devices
> #
> CONFIG_FB=y
> CONFIG_FIRMWARE_EDID=y
> CONFIG_FB_CMDLINE=y
> CONFIG_FB_DDC=y
> # CONFIG_FB_BOOT_VESA_SUPPORT is not set
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> # CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
> CONFIG_FB_SYS_FILLRECT=m
> CONFIG_FB_SYS_COPYAREA=m
> CONFIG_FB_SYS_IMAGEBLIT=m
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> CONFIG_FB_SYS_FOPS=m
> # CONFIG_FB_SVGALIB is not set
> CONFIG_FB_MACMODES=y
> CONFIG_FB_BACKLIGHT=y
> CONFIG_FB_MODE_HELPERS=y
> CONFIG_FB_TILEBLITTING=y
>
> #
> # Frame buffer hardware drivers
> #
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> CONFIG_FB_OF=y
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> # CONFIG_FB_OPENCORES is not set
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_NVIDIA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I740 is not set
> CONFIG_FB_MATROX=y
> CONFIG_FB_MATROX_MILLENIUM=y
> CONFIG_FB_MATROX_MYSTIQUE=y
> CONFIG_FB_MATROX_G=y
> CONFIG_FB_MATROX_I2C=m
> CONFIG_FB_MATROX_MAVEN=m
> CONFIG_FB_RADEON=y
> CONFIG_FB_RADEON_I2C=y
> CONFIG_FB_RADEON_BACKLIGHT=y
> # CONFIG_FB_RADEON_DEBUG is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_S3 is not set
> # CONFIG_FB_SAVAGE is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_VT8623 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_ARK is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_CARMINE is not set
> # CONFIG_FB_SMSCUFX is not set
> # CONFIG_FB_UDL is not set
> CONFIG_FB_IBM_GXT4500=y
> CONFIG_FB_PS3=m
> CONFIG_FB_PS3_DEFAULT_SIZE_M=9
> # CONFIG_FB_VIRTUAL is not set
> # CONFIG_FB_METRONOME is not set
> # CONFIG_FB_MB862XX is not set
> # CONFIG_FB_BROADSHEET is not set
> # CONFIG_FB_AUO_K190X is not set
> # CONFIG_FB_SIMPLE is not set
> # CONFIG_FB_SM712 is not set
> CONFIG_BACKLIGHT_LCD_SUPPORT=y
> CONFIG_LCD_CLASS_DEVICE=y
> # CONFIG_LCD_PLATFORM is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> CONFIG_BACKLIGHT_GENERIC=y
> # CONFIG_BACKLIGHT_PM8941_WLED is not set
> # CONFIG_BACKLIGHT_ADP8860 is not set
> # CONFIG_BACKLIGHT_ADP8870 is not set
> # CONFIG_BACKLIGHT_LM3639 is not set
> # CONFIG_BACKLIGHT_LV5207LP is not set
> # CONFIG_BACKLIGHT_BD6107 is not set
> # CONFIG_VGASTATE is not set
>
> #
> # Console display driver support
> #
> # CONFIG_VGA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_DUMMY_CONSOLE_COLUMNS=80
> CONFIG_DUMMY_CONSOLE_ROWS=25
> CONFIG_FRAMEBUFFER_CONSOLE=y
> # CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
> # CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
> CONFIG_LOGO=y
> CONFIG_FB_LOGO_EXTRA=y
> CONFIG_LOGO_LINUX_MONO=y
> CONFIG_LOGO_LINUX_VGA16=y
> CONFIG_LOGO_LINUX_CLUT224=y
> CONFIG_SOUND=m
> CONFIG_SOUND_OSS_CORE=y
> CONFIG_SOUND_OSS_CORE_PRECLAIM=y
> CONFIG_SND=m
> CONFIG_SND_TIMER=m
> CONFIG_SND_PCM=m
> CONFIG_SND_SEQUENCER=m
> CONFIG_SND_SEQ_DUMMY=m
> CONFIG_SND_OSSEMUL=y
> CONFIG_SND_MIXER_OSS=m
> CONFIG_SND_PCM_OSS=m
> CONFIG_SND_PCM_OSS_PLUGINS=y
> CONFIG_SND_PCM_TIMER=y
> CONFIG_SND_SEQUENCER_OSS=y
> # CONFIG_SND_HRTIMER is not set
> # CONFIG_SND_DYNAMIC_MINORS is not set
> CONFIG_SND_SUPPORT_OLD_API=y
> CONFIG_SND_PROC_FS=y
> CONFIG_SND_VERBOSE_PROCFS=y
> # CONFIG_SND_VERBOSE_PRINTK is not set
> # CONFIG_SND_DEBUG is not set
> CONFIG_SND_VMASTER=y
> # CONFIG_SND_RAWMIDI_SEQ is not set
> # CONFIG_SND_OPL3_LIB_SEQ is not set
> # CONFIG_SND_OPL4_LIB_SEQ is not set
> # CONFIG_SND_SBAWE_SEQ is not set
> # CONFIG_SND_EMU10K1_SEQ is not set
> CONFIG_SND_DRIVERS=y
> # CONFIG_SND_DUMMY is not set
> # CONFIG_SND_ALOOP is not set
> # CONFIG_SND_VIRMIDI is not set
> # CONFIG_SND_MTPAV is not set
> # CONFIG_SND_SERIAL_U16550 is not set
> # CONFIG_SND_MPU401 is not set
> CONFIG_SND_PCI=y
> # CONFIG_SND_AD1889 is not set
> # CONFIG_SND_ALS300 is not set
> # CONFIG_SND_ALS4000 is not set
> # CONFIG_SND_ALI5451 is not set
> # CONFIG_SND_ATIIXP is not set
> # CONFIG_SND_ATIIXP_MODEM is not set
> # CONFIG_SND_AU8810 is not set
> # CONFIG_SND_AU8820 is not set
> # CONFIG_SND_AU8830 is not set
> # CONFIG_SND_AW2 is not set
> # CONFIG_SND_AZT3328 is not set
> # CONFIG_SND_BT87X is not set
> # CONFIG_SND_CA0106 is not set
> # CONFIG_SND_CMIPCI is not set
> # CONFIG_SND_OXYGEN is not set
> # CONFIG_SND_CS4281 is not set
> # CONFIG_SND_CS46XX is not set
> # CONFIG_SND_CTXFI is not set
> # CONFIG_SND_DARLA20 is not set
> # CONFIG_SND_GINA20 is not set
> # CONFIG_SND_LAYLA20 is not set
> # CONFIG_SND_DARLA24 is not set
> # CONFIG_SND_GINA24 is not set
> # CONFIG_SND_LAYLA24 is not set
> # CONFIG_SND_MONA is not set
> # CONFIG_SND_MIA is not set
> # CONFIG_SND_ECHO3G is not set
> # CONFIG_SND_INDIGO is not set
> # CONFIG_SND_INDIGOIO is not set
> # CONFIG_SND_INDIGODJ is not set
> # CONFIG_SND_INDIGOIOX is not set
> # CONFIG_SND_INDIGODJX is not set
> # CONFIG_SND_EMU10K1 is not set
> # CONFIG_SND_EMU10K1X is not set
> # CONFIG_SND_ENS1370 is not set
> # CONFIG_SND_ENS1371 is not set
> # CONFIG_SND_ES1938 is not set
> # CONFIG_SND_ES1968 is not set
> # CONFIG_SND_FM801 is not set
> # CONFIG_SND_HDSP is not set
> # CONFIG_SND_HDSPM is not set
> # CONFIG_SND_ICE1712 is not set
> # CONFIG_SND_ICE1724 is not set
> # CONFIG_SND_INTEL8X0 is not set
> # CONFIG_SND_INTEL8X0M is not set
> # CONFIG_SND_KORG1212 is not set
> # CONFIG_SND_LOLA is not set
> # CONFIG_SND_LX6464ES is not set
> # CONFIG_SND_MAESTRO3 is not set
> # CONFIG_SND_MIXART is not set
> # CONFIG_SND_NM256 is not set
> # CONFIG_SND_PCXHR is not set
> # CONFIG_SND_RIPTIDE is not set
> # CONFIG_SND_RME32 is not set
> # CONFIG_SND_RME96 is not set
> # CONFIG_SND_RME9652 is not set
> # CONFIG_SND_SE6X is not set
> # CONFIG_SND_SONICVIBES is not set
> # CONFIG_SND_TRIDENT is not set
> # CONFIG_SND_VIA82XX is not set
> # CONFIG_SND_VIA82XX_MODEM is not set
> # CONFIG_SND_VIRTUOSO is not set
> # CONFIG_SND_VX222 is not set
> # CONFIG_SND_YMFPCI is not set
>
> #
> # HD-Audio
> #
> # CONFIG_SND_HDA_INTEL is not set
> CONFIG_SND_HDA_PREALLOC_SIZE=64
> CONFIG_SND_PPC=y
> CONFIG_SND_POWERMAC=m
> CONFIG_SND_POWERMAC_AUTO_DRC=y
> CONFIG_SND_PS3=m
> CONFIG_SND_PS3_DEFAULT_START_DELAY=2000
> CONFIG_SND_AOA=m
> CONFIG_SND_AOA_FABRIC_LAYOUT=m
> CONFIG_SND_AOA_ONYX=m
> CONFIG_SND_AOA_TAS=m
> CONFIG_SND_AOA_TOONIE=m
> CONFIG_SND_AOA_SOUNDBUS=m
> CONFIG_SND_AOA_SOUNDBUS_I2S=m
> CONFIG_SND_USB=y
> # CONFIG_SND_USB_AUDIO is not set
> # CONFIG_SND_USB_UA101 is not set
> # CONFIG_SND_USB_USX2Y is not set
> # CONFIG_SND_USB_CAIAQ is not set
> # CONFIG_SND_USB_6FIRE is not set
> # CONFIG_SND_USB_HIFACE is not set
> # CONFIG_SND_BCD2000 is not set
> # CONFIG_SND_USB_POD is not set
> # CONFIG_SND_USB_PODHD is not set
> # CONFIG_SND_USB_TONEPORT is not set
> # CONFIG_SND_USB_VARIAX is not set
> CONFIG_SND_PCMCIA=y
> # CONFIG_SND_VXPOCKET is not set
> # CONFIG_SND_PDAUDIOCF is not set
> # CONFIG_SND_SOC is not set
> # CONFIG_SOUND_PRIME is not set
>
> #
> # HID support
> #
> CONFIG_HID=y
> # CONFIG_HID_BATTERY_STRENGTH is not set
> # CONFIG_HIDRAW is not set
> # CONFIG_UHID is not set
> CONFIG_HID_GENERIC=y
>
> #
> # Special HID drivers
> #
> CONFIG_HID_A4TECH=y
> # CONFIG_HID_ACRUX is not set
> CONFIG_HID_APPLE=y
> # CONFIG_HID_APPLEIR is not set
> # CONFIG_HID_AUREAL is not set
> CONFIG_HID_BELKIN=y
> # CONFIG_HID_BETOP_FF is not set
> CONFIG_HID_CHERRY=y
> CONFIG_HID_CHICONY=y
> # CONFIG_HID_CORSAIR is not set
> # CONFIG_HID_PRODIKEYS is not set
> CONFIG_HID_CYPRESS=y
> # CONFIG_HID_DRAGONRISE is not set
> # CONFIG_HID_EMS_FF is not set
> # CONFIG_HID_ELECOM is not set
> # CONFIG_HID_ELO is not set
> CONFIG_HID_EZKEY=y
> # CONFIG_HID_GEMBIRD is not set
> # CONFIG_HID_GFRM is not set
> # CONFIG_HID_HOLTEK is not set
> # CONFIG_HID_GT683R is not set
> # CONFIG_HID_KEYTOUCH is not set
> # CONFIG_HID_KYE is not set
> # CONFIG_HID_UCLOGIC is not set
> # CONFIG_HID_WALTOP is not set
> CONFIG_HID_GYRATION=y
> # CONFIG_HID_ICADE is not set
> # CONFIG_HID_TWINHAN is not set
> CONFIG_HID_KENSINGTON=y
> # CONFIG_HID_LCPOWER is not set
> # CONFIG_HID_LENOVO is not set
> CONFIG_HID_LOGITECH=y
> # CONFIG_HID_LOGITECH_HIDPP is not set
> # CONFIG_LOGITECH_FF is not set
> # CONFIG_LOGIRUMBLEPAD2_FF is not set
> # CONFIG_LOGIG940_FF is not set
> # CONFIG_LOGIWHEELS_FF is not set
> # CONFIG_HID_MAGICMOUSE is not set
> CONFIG_HID_MICROSOFT=y
> CONFIG_HID_MONTEREY=y
> # CONFIG_HID_MULTITOUCH is not set
> # CONFIG_HID_NTRIG is not set
> # CONFIG_HID_ORTEK is not set
> CONFIG_HID_PANTHERLORD=y
> # CONFIG_PANTHERLORD_FF is not set
> # CONFIG_HID_PENMOUNT is not set
> CONFIG_HID_PETALYNX=y
> # CONFIG_HID_PICOLCD is not set
> # CONFIG_HID_PLANTRONICS is not set
> # CONFIG_HID_PRIMAX is not set
> # CONFIG_HID_ROCCAT is not set
> # CONFIG_HID_SAITEK is not set
> CONFIG_HID_SAMSUNG=y
> # CONFIG_HID_SONY is not set
> # CONFIG_HID_SPEEDLINK is not set
> # CONFIG_HID_STEELSERIES is not set
> CONFIG_HID_SUNPLUS=y
> # CONFIG_HID_RMI is not set
> # CONFIG_HID_GREENASIA is not set
> # CONFIG_HID_SMARTJOYPLUS is not set
> # CONFIG_HID_TIVO is not set
> # CONFIG_HID_TOPSEED is not set
> # CONFIG_HID_THINGM is not set
> # CONFIG_HID_THRUSTMASTER is not set
> # CONFIG_HID_WACOM is not set
> # CONFIG_HID_WIIMOTE is not set
> # CONFIG_HID_XINMO is not set
> # CONFIG_HID_ZEROPLUS is not set
> # CONFIG_HID_ZYDACRON is not set
> # CONFIG_HID_SENSOR_HUB is not set
>
> #
> # USB HID support
> #
> CONFIG_USB_HID=y
> # CONFIG_HID_PID is not set
> CONFIG_USB_HIDDEV=y
>
> #
> # I2C HID support
> #
> # CONFIG_I2C_HID is not set
> CONFIG_USB_OHCI_BIG_ENDIAN_MMIO=y
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_EHCI_BIG_ENDIAN_MMIO=y
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_COMMON=y
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB=y
> # CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
>
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEFAULT_PERSIST=y
> # CONFIG_USB_DYNAMIC_MINORS is not set
> # CONFIG_USB_OTG is not set
> # CONFIG_USB_OTG_WHITELIST is not set
> # CONFIG_USB_ULPI_BUS is not set
> CONFIG_USB_MON=m
> # CONFIG_USB_WUSB_CBAF is not set
>
> #
> # USB Host Controller Drivers
> #
> # CONFIG_USB_C67X00_HCD is not set
> # CONFIG_USB_XHCI_HCD is not set
> CONFIG_USB_EHCI_HCD=y
> # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
> CONFIG_USB_EHCI_TT_NEWSCHED=y
> CONFIG_USB_EHCI_PCI=y
> # CONFIG_USB_EHCI_HCD_PPC_OF is not set
> # CONFIG_USB_EHCI_HCD_PLATFORM is not set
> # CONFIG_USB_OXU210HP_HCD is not set
> # CONFIG_USB_ISP116X_HCD is not set
> # CONFIG_USB_ISP1362_HCD is not set
> # CONFIG_USB_FOTG210_HCD is not set
> CONFIG_USB_OHCI_HCD=y
> # CONFIG_USB_OHCI_HCD_PPC_OF_BE is not set
> # CONFIG_USB_OHCI_HCD_PPC_OF_LE is not set
> # CONFIG_USB_OHCI_HCD_PPC_OF is not set
> CONFIG_USB_OHCI_HCD_PCI=y
> # CONFIG_USB_OHCI_HCD_PLATFORM is not set
> # CONFIG_USB_UHCI_HCD is not set
> # CONFIG_USB_SL811_HCD is not set
> # CONFIG_USB_R8A66597_HCD is not set
> # CONFIG_USB_HCD_TEST_MODE is not set
>
> #
> # USB Device Class drivers
> #
> # CONFIG_USB_ACM is not set
> # CONFIG_USB_PRINTER is not set
> # CONFIG_USB_WDM is not set
> # CONFIG_USB_TMC is not set
>
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> #
>
> #
> # also be needed; see USB_STORAGE Help for more info
> #
> CONFIG_USB_STORAGE=m
> # CONFIG_USB_STORAGE_DEBUG is not set
> # CONFIG_USB_STORAGE_REALTEK is not set
> # CONFIG_USB_STORAGE_DATAFAB is not set
> # CONFIG_USB_STORAGE_FREECOM is not set
> # CONFIG_USB_STORAGE_ISD200 is not set
> # CONFIG_USB_STORAGE_USBAT is not set
> # CONFIG_USB_STORAGE_SDDR09 is not set
> # CONFIG_USB_STORAGE_SDDR55 is not set
> # CONFIG_USB_STORAGE_JUMPSHOT is not set
> # CONFIG_USB_STORAGE_ALAUDA is not set
> # CONFIG_USB_STORAGE_ONETOUCH is not set
> # CONFIG_USB_STORAGE_KARMA is not set
> # CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
> # CONFIG_USB_STORAGE_ENE_UB6250 is not set
> # CONFIG_USB_UAS is not set
>
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_MICROTEK is not set
> # CONFIG_USBIP_CORE is not set
> # CONFIG_USB_MUSB_HDRC is not set
> # CONFIG_USB_DWC3 is not set
> # CONFIG_USB_DWC2 is not set
> # CONFIG_USB_CHIPIDEA is not set
> # CONFIG_USB_ISP1760 is not set
>
> #
> # USB port drivers
> #
> # CONFIG_USB_SERIAL is not set
>
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_EMI62 is not set
> # CONFIG_USB_EMI26 is not set
> # CONFIG_USB_ADUTUX is not set
> # CONFIG_USB_SEVSEG is not set
> # CONFIG_USB_RIO500 is not set
> # CONFIG_USB_LEGOTOWER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_LED is not set
> # CONFIG_USB_CYPRESS_CY7C63 is not set
> # CONFIG_USB_CYTHERM is not set
> # CONFIG_USB_IDMOUSE is not set
> # CONFIG_USB_FTDI_ELAN is not set
> CONFIG_USB_APPLEDISPLAY=m
> # CONFIG_USB_SISUSBVGA is not set
> # CONFIG_USB_LD is not set
> # CONFIG_USB_TRANCEVIBRATOR is not set
> # CONFIG_USB_IOWARRIOR is not set
> # CONFIG_USB_TEST is not set
> # CONFIG_USB_EHSET_TEST_FIXTURE is not set
> # CONFIG_USB_ISIGHTFW is not set
> # CONFIG_USB_YUREX is not set
> # CONFIG_USB_EZUSB_FX2 is not set
> # CONFIG_USB_HSIC_USB3503 is not set
> # CONFIG_USB_LINK_LAYER_TEST is not set
> # CONFIG_USB_CHAOSKEY is not set
>
> #
> # USB Physical Layer drivers
> #
> # CONFIG_USB_PHY is not set
> # CONFIG_NOP_USB_XCEIV is not set
> # CONFIG_USB_ISP1301 is not set
> # CONFIG_USB_GADGET is not set
> # CONFIG_UWB is not set
> # CONFIG_MMC is not set
> # CONFIG_MEMSTICK is not set
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=m
> # CONFIG_LEDS_CLASS_FLASH is not set
>
> #
> # LED drivers
> #
> # CONFIG_LEDS_BCM6328 is not set
> # CONFIG_LEDS_BCM6358 is not set
> # CONFIG_LEDS_LM3530 is not set
> # CONFIG_LEDS_LM3642 is not set
> # CONFIG_LEDS_PCA9532 is not set
> # CONFIG_LEDS_LP3944 is not set
> # CONFIG_LEDS_LP5521 is not set
> # CONFIG_LEDS_LP5523 is not set
> # CONFIG_LEDS_LP5562 is not set
> # CONFIG_LEDS_LP8501 is not set
> # CONFIG_LEDS_LP8860 is not set
> # CONFIG_LEDS_PCA955X is not set
> # CONFIG_LEDS_PCA963X is not set
> # CONFIG_LEDS_BD2802 is not set
> # CONFIG_LEDS_TCA6507 is not set
> # CONFIG_LEDS_TLC591XX is not set
> # CONFIG_LEDS_LM355x is not set
>
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers
> (HID_THINGM)
> #
> # CONFIG_LEDS_BLINKM is not set
> CONFIG_LEDS_POWERNV=m
>
> #
> # LED Triggers
> #
> # CONFIG_LEDS_TRIGGERS is not set
> # CONFIG_ACCESSIBILITY is not set
> CONFIG_INFINIBAND=m
> CONFIG_INFINIBAND_USER_MAD=m
> CONFIG_INFINIBAND_USER_ACCESS=m
> CONFIG_INFINIBAND_USER_MEM=y
> CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
> CONFIG_INFINIBAND_ADDR_TRANS=y
> CONFIG_INFINIBAND_MTHCA=m
> CONFIG_INFINIBAND_MTHCA_DEBUG=y
> # CONFIG_INFINIBAND_QIB is not set
> CONFIG_INFINIBAND_CXGB3=m
> # CONFIG_INFINIBAND_CXGB3_DEBUG is not set
> CONFIG_INFINIBAND_CXGB4=m
> CONFIG_MLX4_INFINIBAND=m
> # CONFIG_INFINIBAND_NES is not set
> # CONFIG_INFINIBAND_OCRDMA is not set
> CONFIG_INFINIBAND_IPOIB=m
> CONFIG_INFINIBAND_IPOIB_CM=y
> CONFIG_INFINIBAND_IPOIB_DEBUG=y
> # CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
> CONFIG_INFINIBAND_SRP=m
> CONFIG_INFINIBAND_ISER=m
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> CONFIG_EDAC=y
> CONFIG_EDAC_LEGACY_SYSFS=y
> # CONFIG_EDAC_DEBUG is not set
> CONFIG_EDAC_MM_EDAC=y
> CONFIG_EDAC_PASEMI=y
> # CONFIG_EDAC_CELL is not set
> # CONFIG_EDAC_AMD8131 is not set
> # CONFIG_EDAC_AMD8111 is not set
> # CONFIG_EDAC_CPC925 is not set
> CONFIG_RTC_LIB=y
> CONFIG_RTC_CLASS=y
> CONFIG_RTC_HCTOSYS=y
> CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> CONFIG_RTC_SYSTOHC=y
> CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
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
> # CONFIG_RTC_DRV_ABB5ZES3 is not set
> # CONFIG_RTC_DRV_ABX80X is not set
> CONFIG_RTC_DRV_DS1307=y
> # CONFIG_RTC_DRV_DS1374 is not set
> # CONFIG_RTC_DRV_DS1672 is not set
> # CONFIG_RTC_DRV_DS3232 is not set
> # CONFIG_RTC_DRV_HYM8563 is not set
> # CONFIG_RTC_DRV_MAX6900 is not set
> # CONFIG_RTC_DRV_RS5C372 is not set
> # CONFIG_RTC_DRV_ISL1208 is not set
> # CONFIG_RTC_DRV_ISL12022 is not set
> # CONFIG_RTC_DRV_ISL12057 is not set
> # CONFIG_RTC_DRV_X1205 is not set
> # CONFIG_RTC_DRV_PCF2127 is not set
> # CONFIG_RTC_DRV_PCF8523 is not set
> # CONFIG_RTC_DRV_PCF8563 is not set
> # CONFIG_RTC_DRV_PCF85063 is not set
> # CONFIG_RTC_DRV_PCF8583 is not set
> # CONFIG_RTC_DRV_M41T80 is not set
> # CONFIG_RTC_DRV_BQ32K is not set
> # CONFIG_RTC_DRV_S35390A is not set
> # CONFIG_RTC_DRV_FM3130 is not set
> # CONFIG_RTC_DRV_RX8581 is not set
> # CONFIG_RTC_DRV_RX8025 is not set
> # CONFIG_RTC_DRV_EM3027 is not set
> # CONFIG_RTC_DRV_RV3029C2 is not set
> # CONFIG_RTC_DRV_RV8803 is not set
>
> #
> # SPI RTC drivers
> #
>
> #
> # Platform RTC drivers
> #
> # CONFIG_RTC_DRV_CMOS is not set
> # CONFIG_RTC_DRV_DS1286 is not set
> # CONFIG_RTC_DRV_DS1511 is not set
> # CONFIG_RTC_DRV_DS1553 is not set
> # CONFIG_RTC_DRV_DS1685_FAMILY is not set
> # CONFIG_RTC_DRV_DS1742 is not set
> # CONFIG_RTC_DRV_DS2404 is not set
> # CONFIG_RTC_DRV_STK17TA8 is not set
> # CONFIG_RTC_DRV_M48T86 is not set
> # CONFIG_RTC_DRV_M48T35 is not set
> # CONFIG_RTC_DRV_M48T59 is not set
> # CONFIG_RTC_DRV_MSM6242 is not set
> # CONFIG_RTC_DRV_BQ4802 is not set
> # CONFIG_RTC_DRV_RP5C01 is not set
> # CONFIG_RTC_DRV_V3020 is not set
> CONFIG_RTC_DRV_OPAL=y
> # CONFIG_RTC_DRV_ZYNQMP is not set
>
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_GENERIC is not set
> # CONFIG_RTC_DRV_PS3 is not set
> # CONFIG_RTC_DRV_SNVS is not set
>
> #
> # HID Sensor RTC drivers
> #
> # CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
> # CONFIG_DMADEVICES is not set
> # CONFIG_AUXDISPLAY is not set
> CONFIG_UIO=m
> # CONFIG_UIO_CIF is not set
> # CONFIG_UIO_PDRV_GENIRQ is not set
> # CONFIG_UIO_DMEM_GENIRQ is not set
> # CONFIG_UIO_AEC is not set
> # CONFIG_UIO_SERCOS3 is not set
> # CONFIG_UIO_PCI_GENERIC is not set
> # CONFIG_UIO_NETX is not set
> # CONFIG_UIO_PRUSS is not set
> # CONFIG_UIO_MF624 is not set
> # CONFIG_VIRT_DRIVERS is not set
> CONFIG_VIRTIO=m
>
> #
> # Virtio drivers
> #
> CONFIG_VIRTIO_PCI=m
> CONFIG_VIRTIO_PCI_LEGACY=y
> CONFIG_VIRTIO_BALLOON=m
> # CONFIG_VIRTIO_INPUT is not set
> # CONFIG_VIRTIO_MMIO is not set
>
> #
> # Microsoft Hyper-V guest support
> #
> # CONFIG_STAGING is not set
>
> #
> # Hardware Spinlock drivers
> #
>
> #
> # Clock Source drivers
> #
> CONFIG_I8253_LOCK=y
> CONFIG_CLKBLD_I8253=y
> # CONFIG_ATMEL_PIT is not set
> # CONFIG_SH_TIMER_CMT is not set
> # CONFIG_SH_TIMER_MTU2 is not set
> # CONFIG_SH_TIMER_TMU is not set
> # CONFIG_EM_TIMER_STI is not set
> # CONFIG_MAILBOX is not set
> CONFIG_IOMMU_SUPPORT=y
>
> #
> # Generic IOMMU Pagetable Support
> #
> # CONFIG_SPAPR_TCE_IOMMU is not set
>
> #
> # Remoteproc drivers
> #
> # CONFIG_STE_MODEM_RPROC is not set
>
> #
> # Rpmsg drivers
> #
>
> #
> # SOC (System On Chip) specific Drivers
> #
> # CONFIG_SUNXI_SRAM is not set
> # CONFIG_SOC_TI is not set
> # CONFIG_PM_DEVFREQ is not set
> # CONFIG_EXTCON is not set
> # CONFIG_MEMORY is not set
> # CONFIG_IIO is not set
> # CONFIG_NTB is not set
> # CONFIG_VME_BUS is not set
> # CONFIG_PWM is not set
> CONFIG_IRQCHIP=y
> # CONFIG_IPACK_BUS is not set
> # CONFIG_RESET_CONTROLLER is not set
> # CONFIG_FMC is not set
>
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=y
> # CONFIG_PHY_PXA_28NM_HSIC is not set
> # CONFIG_PHY_PXA_28NM_USB2 is not set
> # CONFIG_BCM_KONA_USB2_PHY is not set
> # CONFIG_POWERCAP is not set
> # CONFIG_MCB is not set
>
> #
> # Performance monitor support
> #
> CONFIG_RAS=y
> # CONFIG_THUNDERBOLT is not set
>
> #
> # Android
> #
> # CONFIG_ANDROID is not set
> # CONFIG_LIBNVDIMM is not set
> # CONFIG_NVMEM is not set
> # CONFIG_STM is not set
> # CONFIG_STM_DUMMY is not set
> # CONFIG_STM_SOURCE_CONSOLE is not set
> # CONFIG_INTEL_TH is not set
>
> #
> # FPGA Configuration Support
> #
> # CONFIG_FPGA is not set
>
> #
> # File systems
> #
> CONFIG_EXT2_FS=y
> CONFIG_EXT2_FS_XATTR=y
> CONFIG_EXT2_FS_POSIX_ACL=y
> CONFIG_EXT2_FS_SECURITY=y
> CONFIG_EXT3_FS=y
> CONFIG_EXT3_FS_POSIX_ACL=y
> CONFIG_EXT3_FS_SECURITY=y
> CONFIG_EXT4_FS=y
> CONFIG_EXT4_FS_POSIX_ACL=y
> CONFIG_EXT4_FS_SECURITY=y
> # CONFIG_EXT4_ENCRYPTION is not set
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_JBD2=y
> # CONFIG_JBD2_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> CONFIG_REISERFS_FS=y
> # CONFIG_REISERFS_CHECK is not set
> # CONFIG_REISERFS_PROC_INFO is not set
> CONFIG_REISERFS_FS_XATTR=y
> CONFIG_REISERFS_FS_POSIX_ACL=y
> CONFIG_REISERFS_FS_SECURITY=y
> CONFIG_JFS_FS=m
> CONFIG_JFS_POSIX_ACL=y
> CONFIG_JFS_SECURITY=y
> # CONFIG_JFS_DEBUG is not set
> # CONFIG_JFS_STATISTICS is not set
> CONFIG_XFS_FS=m
> # CONFIG_XFS_QUOTA is not set
> CONFIG_XFS_POSIX_ACL=y
> # CONFIG_XFS_RT is not set
> # CONFIG_XFS_WARN is not set
> # CONFIG_XFS_DEBUG is not set
> # CONFIG_GFS2_FS is not set
> CONFIG_BTRFS_FS=m
> CONFIG_BTRFS_FS_POSIX_ACL=y
> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> # CONFIG_BTRFS_DEBUG is not set
> # CONFIG_BTRFS_ASSERT is not set
> CONFIG_NILFS2_FS=m
> # CONFIG_F2FS_FS is not set
> # CONFIG_FS_DAX is not set
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> CONFIG_FILE_LOCKING=y
> CONFIG_FSNOTIFY=y
> CONFIG_DNOTIFY=y
> CONFIG_INOTIFY_USER=y
> # CONFIG_FANOTIFY is not set
> # CONFIG_QUOTA is not set
> # CONFIG_QUOTACTL is not set
> CONFIG_AUTOFS4_FS=m
> CONFIG_FUSE_FS=m
> # CONFIG_CUSE is not set
> CONFIG_OVERLAY_FS=m
>
> #
> # Caches
> #
> # CONFIG_FSCACHE is not set
>
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=y
> # CONFIG_JOLIET is not set
> # CONFIG_ZISOFS is not set
> CONFIG_UDF_FS=m
> CONFIG_UDF_NLS=y
>
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=y
> CONFIG_MSDOS_FS=y
> CONFIG_VFAT_FS=y
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> # CONFIG_NTFS_FS is not set
>
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_PROC_VMCORE=y
> CONFIG_PROC_SYSCTL=y
> CONFIG_PROC_PAGE_MONITOR=y
> # CONFIG_PROC_CHILDREN is not set
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> CONFIG_TMPFS_POSIX_ACL=y
> CONFIG_TMPFS_XATTR=y
> CONFIG_HUGETLBFS=y
> CONFIG_HUGETLB_PAGE=y
> # CONFIG_CONFIGFS_FS is not set
> CONFIG_MISC_FILESYSTEMS=y
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_ECRYPT_FS is not set
> CONFIG_HFS_FS=m
> CONFIG_HFSPLUS_FS=m
> # CONFIG_HFSPLUS_FS_POSIX_ACL is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_LOGFS is not set
> CONFIG_CRAMFS=m
> CONFIG_SQUASHFS=m
> CONFIG_SQUASHFS_FILE_CACHE=y
> # CONFIG_SQUASHFS_FILE_DIRECT is not set
> CONFIG_SQUASHFS_DECOMP_SINGLE=y
> # CONFIG_SQUASHFS_DECOMP_MULTI is not set
> # CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
> CONFIG_SQUASHFS_XATTR=y
> CONFIG_SQUASHFS_ZLIB=y
> # CONFIG_SQUASHFS_LZ4 is not set
> CONFIG_SQUASHFS_LZO=y
> CONFIG_SQUASHFS_XZ=y
> # CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
> # CONFIG_SQUASHFS_EMBEDDED is not set
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
> # CONFIG_VXFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_OMFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_QNX6FS_FS is not set
> # CONFIG_ROMFS_FS is not set
> # CONFIG_PSTORE is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> CONFIG_NETWORK_FILESYSTEMS=y
> CONFIG_NFS_FS=y
> CONFIG_NFS_V2=y
> CONFIG_NFS_V3=y
> CONFIG_NFS_V3_ACL=y
> CONFIG_NFS_V4=y
> # CONFIG_NFS_SWAP is not set
> # CONFIG_NFS_V4_1 is not set
> CONFIG_ROOT_NFS=y
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=y
> CONFIG_NFSD=m
> CONFIG_NFSD_V2_ACL=y
> CONFIG_NFSD_V3=y
> CONFIG_NFSD_V3_ACL=y
> CONFIG_NFSD_V4=y
> # CONFIG_NFSD_PNFS is not set
> # CONFIG_NFSD_FAULT_INJECTION is not set
> CONFIG_GRACE_PERIOD=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_NFS_ACL_SUPPORT=y
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=y
> CONFIG_SUNRPC_GSS=y
> # CONFIG_SUNRPC_DEBUG is not set
> CONFIG_SUNRPC_XPRT_RDMA=m
> # CONFIG_CEPH_FS is not set
> CONFIG_CIFS=m
> # CONFIG_CIFS_STATS is not set
> # CONFIG_CIFS_WEAK_PW_HASH is not set
> # CONFIG_CIFS_UPCALL is not set
> CONFIG_CIFS_XATTR=y
> CONFIG_CIFS_POSIX=y
> # CONFIG_CIFS_ACL is not set
> CONFIG_CIFS_DEBUG=y
> # CONFIG_CIFS_DEBUG2 is not set
> # CONFIG_CIFS_DFS_UPCALL is not set
> # CONFIG_CIFS_SMB2 is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="utf8"
> CONFIG_NLS_CODEPAGE_437=y
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> CONFIG_NLS_ASCII=y
> CONFIG_NLS_ISO8859_1=y
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> # CONFIG_NLS_MAC_ROMAN is not set
> # CONFIG_NLS_MAC_CELTIC is not set
> # CONFIG_NLS_MAC_CENTEURO is not set
> # CONFIG_NLS_MAC_CROATIAN is not set
> # CONFIG_NLS_MAC_CYRILLIC is not set
> # CONFIG_NLS_MAC_GAELIC is not set
> # CONFIG_NLS_MAC_GREEK is not set
> # CONFIG_NLS_MAC_ICELAND is not set
> # CONFIG_NLS_MAC_INUIT is not set
> # CONFIG_NLS_MAC_ROMANIAN is not set
> # CONFIG_NLS_MAC_TURKISH is not set
> CONFIG_NLS_UTF8=y
> CONFIG_BINARY_PRINTF=y
>
> #
> # Library routines
> #
> CONFIG_RAID6_PQ=m
> CONFIG_BITREVERSE=y
> # CONFIG_HAVE_ARCH_BITREVERSE is not set
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_GENERIC_IO=y
> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
> CONFIG_CRC_CCITT=m
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=m
> CONFIG_CRC_ITU_T=m
> CONFIG_CRC32=y
> # CONFIG_CRC32_SELFTEST is not set
> CONFIG_CRC32_SLICEBY8=y
> # CONFIG_CRC32_SLICEBY4 is not set
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> # CONFIG_CRC7 is not set
> CONFIG_LIBCRC32C=m
> # CONFIG_CRC8 is not set
> # CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_842_DECOMPRESS=y
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_LZO_COMPRESS=m
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> CONFIG_XZ_DEC_X86=y
> CONFIG_XZ_DEC_POWERPC=y
> CONFIG_XZ_DEC_IA64=y
> CONFIG_XZ_DEC_ARM=y
> CONFIG_XZ_DEC_ARMTHUMB=y
> CONFIG_XZ_DEC_SPARC=y
> CONFIG_XZ_DEC_BCJ=y
> # CONFIG_XZ_DEC_TEST is not set
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_DECOMPRESS_BZIP2=y
> CONFIG_DECOMPRESS_LZMA=y
> CONFIG_DECOMPRESS_XZ=y
> CONFIG_DECOMPRESS_LZO=y
> CONFIG_DECOMPRESS_LZ4=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_CPU_RMAP=y
> CONFIG_DQL=y
> CONFIG_GLOB=y
> # CONFIG_GLOB_SELFTEST is not set
> CONFIG_NLATTR=y
> CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=y
> # CONFIG_CORDIC is not set
> # CONFIG_DDR is not set
> CONFIG_LIBFDT=y
> CONFIG_OID_REGISTRY=y
> CONFIG_FONT_SUPPORT=y
> # CONFIG_FONTS is not set
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> # CONFIG_SG_SPLIT is not set
> CONFIG_ARCH_HAS_SG_CHAIN=y
>
> #
> # Kernel hacking
> #
>
> #
> # printk and dmesg options
> #
> # CONFIG_PRINTK_TIME is not set
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> # CONFIG_DYNAMIC_DEBUG is not set
>
> #
> # Compile-time checks and compiler options
> #
> # CONFIG_DEBUG_INFO is not set
> CONFIG_ENABLE_WARN_DEPRECATED=y
> CONFIG_ENABLE_MUST_CHECK=y
> CONFIG_FRAME_WARN=2048
> # CONFIG_STRIP_ASM_SYMS is not set
> # CONFIG_READABLE_ASM is not set
> # CONFIG_UNUSED_SYMBOLS is not set
> # CONFIG_PAGE_OWNER is not set
> CONFIG_DEBUG_FS=y
> # CONFIG_HEADERS_CHECK is not set
> # CONFIG_DEBUG_SECTION_MISMATCH is not set
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> CONFIG_DEBUG_KERNEL=y
>
> #
> # Memory Debugging
> #
> # CONFIG_PAGE_EXTENSION is not set
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_DEBUG_OBJECTS is not set
> # CONFIG_SLUB_DEBUG_ON is not set
> # CONFIG_SLUB_STATS is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> # CONFIG_DEBUG_KMEMLEAK is not set
> CONFIG_DEBUG_STACK_USAGE=y
> # CONFIG_DEBUG_VM is not set
> CONFIG_DEBUG_MEMORY_INIT=y
> # CONFIG_DEBUG_PER_CPU_MAPS is not set
> CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> CONFIG_DEBUG_STACKOVERFLOW=y
> # CONFIG_DEBUG_SHIRQ is not set
>
> #
> # Debug Lockups and Hangs
> #
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_HARDLOCKUP_DETECTOR=y
> # CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
> CONFIG_DETECT_HUNG_TASK=y
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
> # CONFIG_PANIC_ON_OOPS is not set
> CONFIG_PANIC_ON_OOPS_VALUE=0
> CONFIG_SCHED_DEBUG=y
> CONFIG_SCHED_INFO=y
> CONFIG_SCHEDSTATS=y
> # CONFIG_SCHED_STACK_END_CHECK is not set
> # CONFIG_DEBUG_TIMEKEEPING is not set
> # CONFIG_TIMER_STATS is not set
>
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> # CONFIG_DEBUG_RT_MUTEXES is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> CONFIG_DEBUG_MUTEXES=y
> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> # CONFIG_DEBUG_LOCK_ALLOC is not set
> # CONFIG_PROVE_LOCKING is not set
> # CONFIG_LOCK_STAT is not set
> # CONFIG_DEBUG_ATOMIC_SLEEP is not set
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> # CONFIG_LOCK_TORTURE_TEST is not set
> CONFIG_STACKTRACE=y
> # CONFIG_DEBUG_KOBJECT is not set
> CONFIG_DEBUG_BUGVERBOSE=y
> # CONFIG_DEBUG_LIST is not set
> # CONFIG_DEBUG_PI_LIST is not set
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
> # CONFIG_DEBUG_CREDENTIALS is not set
>
> #
> # RCU Debugging
> #
> # CONFIG_PROVE_RCU is not set
> # CONFIG_SPARSE_RCU_POINTER is not set
> # CONFIG_TORTURE_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=21
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> # CONFIG_FAULT_INJECTION is not set
> CONFIG_LATENCYTOP=y
> CONFIG_NOP_TRACER=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_TRACER_MAX_TRACE=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_RING_BUFFER=y
> CONFIG_EVENT_TRACING=y
> CONFIG_CONTEXT_SWITCH_TRACER=y
> CONFIG_RING_BUFFER_ALLOW_SWAP=y
> CONFIG_TRACING=y
> CONFIG_GENERIC_TRACER=y
> CONFIG_TRACING_SUPPORT=y
> CONFIG_FTRACE=y
> # CONFIG_FUNCTION_TRACER is not set
> # CONFIG_IRQSOFF_TRACER is not set
> CONFIG_SCHED_TRACER=y
> # CONFIG_FTRACE_SYSCALLS is not set
> CONFIG_TRACER_SNAPSHOT=y
> # CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
> CONFIG_BRANCH_PROFILE_NONE=y
> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> # CONFIG_PROFILE_ALL_BRANCHES is not set
> # CONFIG_STACK_TRACER is not set
> CONFIG_BLK_DEV_IO_TRACE=y
> CONFIG_KPROBE_EVENT=y
> # CONFIG_UPROBE_EVENT is not set
> CONFIG_PROBE_EVENTS=y
> # CONFIG_FTRACE_STARTUP_TEST is not set
> # CONFIG_TRACEPOINT_BENCHMARK is not set
> # CONFIG_RING_BUFFER_BENCHMARK is not set
> # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> # CONFIG_TRACE_ENUM_MAP_FILE is not set
>
> #
> # Runtime Testing
> #
> # CONFIG_LKDTM is not set
> # CONFIG_TEST_LIST_SORT is not set
> # CONFIG_KPROBES_SANITY_TEST is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_RBTREE_TEST is not set
> # CONFIG_INTERVAL_TREE_TEST is not set
> # CONFIG_PERCPU_TEST is not set
> # CONFIG_ATOMIC64_SELFTEST is not set
> # CONFIG_ASYNC_RAID6_TEST is not set
> # CONFIG_TEST_HEXDUMP is not set
> # CONFIG_TEST_STRING_HELPERS is not set
> # CONFIG_TEST_KSTRTOX is not set
> # CONFIG_TEST_PRINTF is not set
> # CONFIG_TEST_RHASHTABLE is not set
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_TEST_LKM is not set
> # CONFIG_TEST_USER_COPY is not set
> # CONFIG_TEST_BPF is not set
> # CONFIG_TEST_FIRMWARE is not set
> # CONFIG_TEST_UDELAY is not set
> # CONFIG_MEMTEST is not set
> # CONFIG_TEST_STATIC_KEYS is not set
> # CONFIG_SAMPLES is not set
> CONFIG_HAVE_ARCH_KGDB=y
> # CONFIG_KGDB is not set
> # CONFIG_PPC_DISABLE_WERROR is not set
> CONFIG_PPC_WERROR=y
> # CONFIG_STRICT_MM_TYPECHECKS is not set
> CONFIG_PRINT_STACK_DEPTH=64
> # CONFIG_HCALL_STATS is not set
> # CONFIG_PPC_EMULATED_STATS is not set
> CONFIG_CODE_PATCHING_SELFTEST=y
> CONFIG_FTR_FIXUP_SELFTEST=y
> CONFIG_MSI_BITMAP_SELFTEST=y
> CONFIG_XMON=y
> # CONFIG_XMON_DEFAULT is not set
> CONFIG_XMON_DISASSEMBLY=y
> CONFIG_DEBUGGER=y
> CONFIG_BOOTX_TEXT=y
> CONFIG_PPC_EARLY_DEBUG=y
> CONFIG_PPC_EARLY_DEBUG_BOOTX=y
> # CONFIG_PPC_EARLY_DEBUG_LPAR is not set
> # CONFIG_PPC_EARLY_DEBUG_LPAR_HVSI is not set
> # CONFIG_PPC_EARLY_DEBUG_G5 is not set
> # CONFIG_PPC_EARLY_DEBUG_RTAS_PANEL is not set
> # CONFIG_PPC_EARLY_DEBUG_RTAS_CONSOLE is not set
> # CONFIG_PPC_EARLY_DEBUG_MAPLE is not set
> # CONFIG_PPC_EARLY_DEBUG_PAS_REALMODE is not set
> # CONFIG_PPC_EARLY_DEBUG_PS3GELIC is not set
> # CONFIG_PPC_EARLY_DEBUG_OPAL_RAW is not set
> # CONFIG_PPC_EARLY_DEBUG_OPAL_HVSI is not set
> # CONFIG_PPC_EARLY_DEBUG_MEMCONS is not set
> CONFIG_STRICT_DEVMEM=y
>
> #
> # Security options
> #
> CONFIG_KEYS=y
> # CONFIG_PERSISTENT_KEYRINGS is not set
> # CONFIG_BIG_KEYS is not set
> # CONFIG_ENCRYPTED_KEYS is not set
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> # CONFIG_SECURITY is not set
> # CONFIG_SECURITYFS is not set
> CONFIG_DEFAULT_SECURITY_DAC=y
> CONFIG_DEFAULT_SECURITY=""
> CONFIG_KEYS_COMPAT=y
> CONFIG_XOR_BLOCKS=m
> CONFIG_ASYNC_CORE=m
> CONFIG_ASYNC_MEMCPY=m
> CONFIG_ASYNC_XOR=m
> CONFIG_ASYNC_PQ=m
> CONFIG_ASYNC_RAID6_RECOV=m
> CONFIG_CRYPTO=y
>
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=m
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_BLKCIPHER=m
> CONFIG_CRYPTO_BLKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=m
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_RNG_DEFAULT=m
> CONFIG_CRYPTO_PCOMP2=y
> CONFIG_CRYPTO_AKCIPHER2=y
> # CONFIG_CRYPTO_RSA is not set
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> # CONFIG_CRYPTO_USER is not set
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> # CONFIG_CRYPTO_GF128MUL is not set
> CONFIG_CRYPTO_NULL=m
> CONFIG_CRYPTO_NULL2=y
> # CONFIG_CRYPTO_PCRYPT is not set
> CONFIG_CRYPTO_WORKQUEUE=y
> # CONFIG_CRYPTO_CRYPTD is not set
> # CONFIG_CRYPTO_MCRYPTD is not set
> CONFIG_CRYPTO_AUTHENC=m
> CONFIG_CRYPTO_TEST=m
>
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=m
> # CONFIG_CRYPTO_GCM is not set
> # CONFIG_CRYPTO_CHACHA20POLY1305 is not set
> CONFIG_CRYPTO_SEQIV=m
> CONFIG_CRYPTO_ECHAINIV=m
>
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=m
> CONFIG_CRYPTO_CTR=m
> # CONFIG_CRYPTO_CTS is not set
> CONFIG_CRYPTO_ECB=m
> # CONFIG_CRYPTO_LRW is not set
> CONFIG_CRYPTO_PCBC=m
> # CONFIG_CRYPTO_XTS is not set
> # CONFIG_CRYPTO_KEYWRAP is not set
>
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=m
> CONFIG_CRYPTO_HMAC=y
> # CONFIG_CRYPTO_XCBC is not set
> # CONFIG_CRYPTO_VMAC is not set
>
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> # CONFIG_CRYPTO_CRC32 is not set
> CONFIG_CRYPTO_CRCT10DIF=m
> # CONFIG_CRYPTO_GHASH is not set
> # CONFIG_CRYPTO_POLY1305 is not set
> CONFIG_CRYPTO_MD4=m
> CONFIG_CRYPTO_MD5=m
> # CONFIG_CRYPTO_MD5_PPC is not set
> CONFIG_CRYPTO_MICHAEL_MIC=m
> # CONFIG_CRYPTO_RMD128 is not set
> # CONFIG_CRYPTO_RMD160 is not set
> # CONFIG_CRYPTO_RMD256 is not set
> # CONFIG_CRYPTO_RMD320 is not set
> CONFIG_CRYPTO_SHA1=m
> # CONFIG_CRYPTO_SHA1_PPC is not set
> CONFIG_CRYPTO_SHA256=m
> # CONFIG_CRYPTO_SHA512 is not set
> CONFIG_CRYPTO_TGR192=m
> CONFIG_CRYPTO_WP512=m
>
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=y
> CONFIG_CRYPTO_ANUBIS=m
> CONFIG_CRYPTO_ARC4=m
> CONFIG_CRYPTO_BLOWFISH=m
> CONFIG_CRYPTO_BLOWFISH_COMMON=m
> # CONFIG_CRYPTO_CAMELLIA is not set
> CONFIG_CRYPTO_CAST_COMMON=m
> # CONFIG_CRYPTO_CAST5 is not set
> CONFIG_CRYPTO_CAST6=m
> CONFIG_CRYPTO_DES=m
> # CONFIG_CRYPTO_FCRYPT is not set
> CONFIG_CRYPTO_KHAZAD=m
> CONFIG_CRYPTO_SALSA20=m
> # CONFIG_CRYPTO_CHACHA20 is not set
> # CONFIG_CRYPTO_SEED is not set
> CONFIG_CRYPTO_SERPENT=m
> CONFIG_CRYPTO_TEA=m
> CONFIG_CRYPTO_TWOFISH=m
> CONFIG_CRYPTO_TWOFISH_COMMON=m
>
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=m
> # CONFIG_CRYPTO_ZLIB is not set
> CONFIG_CRYPTO_LZO=m
> # CONFIG_CRYPTO_842 is not set
> # CONFIG_CRYPTO_LZ4 is not set
> # CONFIG_CRYPTO_LZ4HC is not set
>
> #
> # Random Number Generation
> #
> # CONFIG_CRYPTO_ANSI_CPRNG is not set
> CONFIG_CRYPTO_DRBG_MENU=m
> CONFIG_CRYPTO_DRBG_HMAC=y
> # CONFIG_CRYPTO_DRBG_HASH is not set
> # CONFIG_CRYPTO_DRBG_CTR is not set
> CONFIG_CRYPTO_DRBG=m
> CONFIG_CRYPTO_JITTERENTROPY=m
> # CONFIG_CRYPTO_USER_API_HASH is not set
> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> # CONFIG_CRYPTO_USER_API_RNG is not set
> # CONFIG_CRYPTO_USER_API_AEAD is not set
> CONFIG_CRYPTO_HW=y
> CONFIG_CRYPTO_DEV_NX=y
> CONFIG_CRYPTO_DEV_NX_ENCRYPT=m
> CONFIG_CRYPTO_DEV_NX_COMPRESS=y
> CONFIG_CRYPTO_DEV_NX_COMPRESS_PSERIES=y
> CONFIG_CRYPTO_DEV_NX_COMPRESS_POWERNV=y
> # CONFIG_CRYPTO_DEV_VMX is not set
> # CONFIG_ASYMMETRIC_KEY_TYPE is not set
>
> #
> # Certificates for signature checking
> #
> # CONFIG_SYSTEM_TRUSTED_KEYRING is not set
> CONFIG_HAVE_KVM_IRQCHIP=y
> CONFIG_HAVE_KVM_IRQFD=y
> CONFIG_HAVE_KVM_EVENTFD=y
> CONFIG_KVM_COMPAT=y
> CONFIG_VIRTUALIZATION=y
> CONFIG_KVM=y
> CONFIG_KVM_BOOK3S_HANDLER=y
> CONFIG_KVM_BOOK3S_64_HANDLER=y
> CONFIG_KVM_BOOK3S_HV_POSSIBLE=y
> CONFIG_KVM_BOOK3S_64=m
> CONFIG_KVM_BOOK3S_64_HV=m
> # CONFIG_KVM_BOOK3S_64_PR is not set
> # CONFIG_KVM_BOOK3S_HV_EXIT_TIMING is not set
> CONFIG_KVM_XICS=y
>
> any suggestion to fix this error and thanks
>
>  regards
>
> marwa
>
sorry this is the error in english , the other one was translated from
French to english
 VDSO32L arch/powerpc/kernel/vdso32/vdso32.so.dbg
/usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
arch/powerpc/kernel/vdso32/sigtramp.o: compiled for a little endian system
and target is big endian
/usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
failed to merge target specific data of file
arch/powerpc/kernel/vdso32/sigtramp.o
/usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
arch/powerpc/kernel/vdso32/gettimeofday.o: compiled for a little endian
system and target is big endian
/usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
failed to merge target specific data of file
arch/powerpc/kernel/vdso32/gettimeofday.o
/usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
arch/powerpc/kernel/vdso32/datapage.o: compiled for a little endian system
and target is big endian
/usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
failed to merge target specific data of file
arch/powerpc/kernel/vdso32/datapage.o
/usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
arch/powerpc/kernel/vdso32/cacheflush.o: compiled for a little endian
system and target is big endian
/usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
failed to merge target specific data of file
arch/powerpc/kernel/vdso32/cacheflush.o
/usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
arch/powerpc/kernel/vdso32/note.o: compiled for a little endian system and
target is big endian
/usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
failed to merge target specific data of file
arch/powerpc/kernel/vdso32/note.o
/usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
arch/powerpc/kernel/vdso32/getcpu.o: compiled for a little endian system
and target is big endian
/usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
failed to merge target specific data of file
arch/powerpc/kernel/vdso32/getcpu.o
collect2: error: ld returned 1 exit status
make[2]: *** [arch/powerpc/kernel/vdso32/vdso32.so.dbg] Error 1
make[1]: *** [arch/powerpc/kernel/vdso32] Error 2
make: *** [arch/powerpc/kernel] Error 2
it's a big endian and a little endian problem , so i changed the kernel
configuration into little endian and i got this error
*** binutils 2.24 miscompiles weak symbols in some circumstances.
*** Please use a different binutils version.make: *** [checkbin] Error 1
regards
marwa

--001a11357726e5a1a405318a4784
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-04-28 9:45 GMT+01:00 Marwa Hamza <span dir=3D"ltr">&lt;<a href=3D"=
mailto:marwahamza63@gmail.com" target=3D"_blank">marwahamza63@gmail.com</a>=
&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><br><div class=3D"gmail_quote">---------- Forwarded message ------=
----<br>From: <b class=3D"gmail_sendername">Joel Stanley</b> <span dir=3D"l=
tr">&lt;<a href=3D"mailto:joel@jms.id.au" target=3D"_blank">joel@jms.id.au<=
/a>&gt;</span><br>Date: 2016-04-28 8:51 GMT+01:00<br>Subject: Re: error whi=
le trying to compile linux kernel with powerpc arch<br>To: Marwa Hamza &lt;=
<a href=3D"mailto:marwahamza63@gmail.com" target=3D"_blank">marwahamza63@gm=
ail.com</a>&gt;<br>Cc: <a href=3D"mailto:linuxppc-dev@lists.ozlabs.org" tar=
get=3D"_blank">linuxppc-dev@lists.ozlabs.org</a><br><br><br>Hello,<br>
<div><div><br>
On Thu, Apr 28, 2016 at 2:13 AM, Marwa Hamza &lt;<a href=3D"mailto:marwaham=
za63@gmail.com" target=3D"_blank">marwahamza63@gmail.com</a>&gt; wrote:<br>
&gt; hello<br>
&gt; every time i try to compile the linux kernel with arch=3Dpowerpc i got=
 this<br>
&gt; error<br>
&gt;<br>
&gt; WRAP arch / powerpc / boot / zImage.pseries<br>
&gt; powerpc-linux-gnu-ld: unrecognized emulation mode: -T<br>
&gt; Emulations supported: elf32ppclinux elf32ppc elf32ppcsim elf64ppc elf3=
2_spu<br>
&gt; make [1]: *** [arch / powerpc / boot / zImage.pseries] Error 1<br>
&gt; make: *** [zImage] Error 2<br>
&gt;<br>
&gt; im using powerpc-linux-gnu ( sudo apt-get install powerpc-linux-gnu)=
=C2=A0 and<br>
&gt; linux-4.4.1<br>
&gt; make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux-gnu-=C2=A0 pseries_d=
efconfig<br>
&gt; make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux-gnu-<br>
&gt; ubuntu 14.04<br>
&gt; any suggestion ?<br>
<br>
</div></div>You need a 64 bit compiler, as the pseries configuration is for=
 a 64<br>
bit machine.<br>
<br>
$ head -n1 arch/powerpc/configs/pseries_defconfig<br>
CONFIG_PPC64=3Dy<br>
<br>
&#39;apt-get install gcc-powerpc64-linux-gnu&#39; should do the trick. Set<=
br>
CROSS_COMPILE=3Dpowerpc64-linux-gnu- and you will be good to go.<br>
<br>
Cheers,<br>
<br>
Joel<br>
</div>thanks for the response but this package doesn&#39;t exist gcc-powerp=
c64-linux-gnu so i install <br><h1><font size=3D"4"><span style=3D"font-wei=
ght:normal">gccgo-powerpc64le-linux-gnu <font size=3D"2">and i reconfigure =
the kernel </font></span></font><br><font size=3D"2"><span style=3D"font-we=
ight:normal">make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc64le-linux-</span><=
/font><font size=3D"2"><span style=3D"font-weight:normal">gnu-=C2=A0 pserie=
s_defconfig</span></font></h1><p>and i compiled again <font size=3D"2"><spa=
n style=3D"font-weight:normal">make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc6=
4le-linux-</span></font><font size=3D"2"><span style=3D"font-weight:normal"=
>gnu- and i unfortunately i got another error <br></span></font></p><p><br>=
<font size=3D"2"><span style=3D"font-weight:normal"></span></font></p><p><b=
r><span lang=3D"en"><span title=3D"VDSO32A arch/powerpc/kernel/vdso32/getcp=
u.o
=C2=A0=C2=A0">VDSO32A arch / powerpc / kernel / vdso32 / getcpu.o<br>=C2=A0=
=C2=A0</span><span title=3D"VDSO32L arch/powerpc/kernel/vdso32/vdso32.so.db=
g
">VDSO32L arch / powerpc / kernel / vdso32 / vdso32.so.dbg<br></span><span =
title=3D"/usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64=
le-linux-gnu/bin/ld: arch/powerpc/kernel/vdso32/sigtramp.o">/usr/lib/gcc-cr=
oss/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
 arch / powerpc / kernel / vdso32 / sigtramp.o </span><span title=3D": comp=
il=C3=A9 pour un syst=C3=A8me =C3=A0 octets de poids faible alors que la ci=
ble
">: byte compiled for a system of low weight while the target<br></span><sp=
an title=3D"est un syst=C3=A8me =C3=A0 octets de poids fort
">is a significant bytes system<br></span><span title=3D"Fichier dans un ma=
uvais format: =C3=A9chec de fusion des donn=C3=A9es sp=C3=A9cifiques cibles=
 du fichier arch/powerpc/kernel/vdso32/sigtramp.o
">File in the wrong format: fusion failure targets specific data arch / pow=
erpc / kernel / vdso32 / sigtramp.o<br></span><span title=3D"/usr/lib/gcc-c=
ross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld: ar=
ch/powerpc/kernel/vdso32/gettimeofday.o">/usr/lib/gcc-cross/powerpc64le-lin=
ux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
 arch / powerpc / kernel / vdso32 / gettimeofday.o </span><span title=3D": =
compil=C3=A9 pour un syst=C3=A8me =C3=A0 octets de poids faible alors que l=
a cible
">: byte compiled for a system of low weight while the target<br></span><sp=
an title=3D"est un syst=C3=A8me =C3=A0 octets de poids fort
">is a significant bytes system<br></span><span title=3D"Fichier dans un ma=
uvais format: =C3=A9chec de fusion des donn=C3=A9es sp=C3=A9cifiques cibles=
 du fichier arch/powerpc/kernel/vdso32/gettimeofday.o
">File in the wrong format: fusion failure targets specific data arch / pow=
erpc / kernel / vdso32 / gettimeofday.o<br></span><span title=3D"/usr/lib/g=
cc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld=
: arch/powerpc/kernel/vdso32/datapage.o">/usr/lib/gcc-cross/powerpc64le-lin=
ux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
 arch / powerpc / kernel / vdso32 / datapage.o </span><span title=3D": comp=
il=C3=A9 pour un syst=C3=A8me =C3=A0 octets de poids faible alors que la ci=
ble
">: byte compiled for a system of low weight while the target<br></span><sp=
an title=3D"est un syst=C3=A8me =C3=A0 octets de poids fort
">is a significant bytes system<br></span><span title=3D"Fichier dans un ma=
uvais format: =C3=A9chec de fusion des donn=C3=A9es sp=C3=A9cifiques cibles=
 du fichier arch/powerpc/kernel/vdso32/datapage.o
">File in the wrong format: fusion failure targets specific data arch / pow=
erpc / kernel / vdso32 / datapage.o<br></span><span title=3D"/usr/lib/gcc-c=
ross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld: ar=
ch/powerpc/kernel/vdso32/cacheflush.o">/usr/lib/gcc-cross/powerpc64le-linux=
-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
 arch / powerpc / kernel / vdso32 / cacheflush.o </span><span title=3D": co=
mpil=C3=A9 pour un syst=C3=A8me =C3=A0 octets de poids faible alors que la =
cible
">: byte compiled for a system of low weight while the target<br></span><sp=
an title=3D"est un syst=C3=A8me =C3=A0 octets de poids fort
">is a significant bytes system<br></span><span title=3D"Fichier dans un ma=
uvais format: =C3=A9chec de fusion des donn=C3=A9es sp=C3=A9cifiques cibles=
 du fichier arch/powerpc/kernel/vdso32/cacheflush.o
">File in the wrong format: fusion failure targets specific data arch / pow=
erpc / kernel / vdso32 / cacheflush.o<br></span><span title=3D"/usr/lib/gcc=
-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld: =
arch/powerpc/kernel/vdso32/note.o">/usr/lib/gcc-cross/powerpc64le-linux-gnu=
/4.8/../../../../powerpc64le-linux-gnu/bin/ld:
 arch / powerpc / kernel / vdso32 / note.o </span><span title=3D": compil=
=C3=A9 pour un syst=C3=A8me =C3=A0 octets de poids faible alors que la cibl=
e
">: byte compiled for a system of low weight while the target<br></span><sp=
an title=3D"est un syst=C3=A8me =C3=A0 octets de poids fort
">is a significant bytes system<br></span><span title=3D"Fichier dans un ma=
uvais format: =C3=A9chec de fusion des donn=C3=A9es sp=C3=A9cifiques cibles=
 du fichier arch/powerpc/kernel/vdso32/note.o
">File in the wrong format: fusion failure targets specific data arch / pow=
erpc / kernel / vdso32 / note.o<br></span><span title=3D"/usr/lib/gcc-cross=
/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld: arch/p=
owerpc/kernel/vdso32/getcpu.o">/usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8=
/../../../../powerpc64le-linux-gnu/bin/ld:
 arch / powerpc / kernel / vdso32 / getcpu.o </span><span title=3D": compil=
=C3=A9 pour un syst=C3=A8me =C3=A0 octets de poids faible alors que la cibl=
e
">: byte compiled for a system of low weight while the target<br></span><sp=
an title=3D"est un syst=C3=A8me =C3=A0 octets de poids fort
">is a significant bytes system<br></span><span title=3D"Fichier dans un ma=
uvais format: =C3=A9chec de fusion des donn=C3=A9es sp=C3=A9cifiques cibles=
 du fichier arch/powerpc/kernel/vdso32/getcpu.o
">File in the wrong format: fusion failure targets specific data arch / pow=
erpc / kernel / vdso32 / getcpu.o<br></span><span title=3D"collect2: error:=
 ld returned 1 exit status
">collect2: error: ld returned 1 exit status<br></span><span title=3D"make[=
2]: *** [arch/powerpc/kernel/vdso32/vdso32.so.dbg] Erreur 1
">make [2]: *** [arch / powerpc / kernel / vdso32 / vdso32.so.dbg] Error 1<=
br></span><span title=3D"make[1]: *** [arch/powerpc/kernel/vdso32] Erreur 2
">make [1]: *** [arch / powerpc / kernel / vdso32] Error 2<br></span><span =
title=3D"make: *** [arch/powerpc/kernel] Erreur 2">make: *** [arch / powerp=
c / kernel] Error 2</span></span></p><p><span lang=3D"en"><span title=3D"ma=
ke: *** [arch/powerpc/kernel] Erreur 2">i though fist that the problem is r=
elated to the big endian and little endian kernel but it seems not and i se=
arched in google but i couldn&#39;t find any thing<br></span></span></p><p>=
<span lang=3D"en"><span title=3D"make: *** [arch/powerpc/kernel] Erreur 2">=
this is .config <br></span></span></p><p><span lang=3D"en"><span title=3D"m=
ake: *** [arch/powerpc/kernel] Erreur 2">#<br># Automatically generated fil=
e; DO NOT EDIT.<br># Linux/powerpc 4.4.1 Kernel Configuration<br>#<br>CONFI=
G_PPC64=3Dy<br><br>#<br># Processor support<br>#<br>CONFIG_PPC_BOOK3S_64=3D=
y<br># CONFIG_PPC_BOOK3E_64 is not set<br>CONFIG_GENERIC_CPU=3Dy<br># CONFI=
G_CELL_CPU is not set<br># CONFIG_POWER4_CPU is not set<br># CONFIG_POWER5_=
CPU is not set<br># CONFIG_POWER6_CPU is not set<br># CONFIG_POWER7_CPU is =
not set<br># CONFIG_POWER8_CPU is not set<br>CONFIG_PPC_BOOK3S=3Dy<br>CONFI=
G_PPC_FPU=3Dy<br>CONFIG_ALTIVEC=3Dy<br>CONFIG_VSX=3Dy<br># CONFIG_PPC_ICSWX=
 is not set<br>CONFIG_PPC_STD_MMU=3Dy<br>CONFIG_PPC_STD_MMU_64=3Dy<br>CONFI=
G_PPC_MM_SLICES=3Dy<br>CONFIG_PPC_HAVE_PMU_SUPPORT=3Dy<br>CONFIG_PPC_PERF_C=
TRS=3Dy<br>CONFIG_SMP=3Dy<br>CONFIG_NR_CPUS=3D32<br>CONFIG_PPC_DOORBELL=3Dy=
<br>CONFIG_VDSO32=3Dy<br>CONFIG_CPU_BIG_ENDIAN=3Dy<br># CONFIG_CPU_LITTLE_E=
NDIAN is not set<br>CONFIG_64BIT=3Dy<br>CONFIG_WORD_SIZE=3D64<br>CONFIG_ARC=
H_PHYS_ADDR_T_64BIT=3Dy<br>CONFIG_ARCH_DMA_ADDR_T_64BIT=3Dy<br>CONFIG_MMU=
=3Dy<br>CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy<br>CONFIG_NEED_PER_CPU_EMBED_FIR=
ST_CHUNK=3Dy<br>CONFIG_NR_IRQS=3D512<br>CONFIG_STACKTRACE_SUPPORT=3Dy<br>CO=
NFIG_HAVE_LATENCYTOP_SUPPORT=3Dy<br>CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy<br>CO=
NFIG_LOCKDEP_SUPPORT=3Dy<br>CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy<br>CONFIG_AR=
CH_HAS_ILOG2_U32=3Dy<br>CONFIG_ARCH_HAS_ILOG2_U64=3Dy<br>CONFIG_GENERIC_HWE=
IGHT=3Dy<br>CONFIG_ARCH_HAS_DMA_SET_COHERENT_MASK=3Dy<br>CONFIG_PPC=3Dy<br>=
# CONFIG_GENERIC_CSUM is not set<br>CONFIG_EARLY_PRINTK=3Dy<br>CONFIG_PANIC=
_TIMEOUT=3D180<br>CONFIG_COMPAT=3Dy<br>CONFIG_SYSVIPC_COMPAT=3Dy<br>CONFIG_=
SCHED_OMIT_FRAME_POINTER=3Dy<br>CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy<br>CONFIG_P=
PC_UDBG_16550=3Dy<br>CONFIG_GENERIC_TBSYNC=3Dy<br>CONFIG_AUDIT_ARCH=3Dy<br>=
CONFIG_GENERIC_BUG=3Dy<br>CONFIG_EPAPR_BOOT=3Dy<br># CONFIG_DEFAULT_UIMAGE =
is not set<br>CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy<br>CONFIG_ARCH_SUSPEND_P=
OSSIBLE=3Dy<br># CONFIG_PPC_DCR_NATIVE is not set<br>CONFIG_PPC_DCR_MMIO=3D=
y<br>CONFIG_PPC_DCR=3Dy<br>CONFIG_PPC_OF_PLATFORM_PCI=3Dy<br>CONFIG_ARCH_SU=
PPORTS_DEBUG_PAGEALLOC=3Dy<br>CONFIG_ARCH_SUPPORTS_UPROBES=3Dy<br>CONFIG_PP=
C_EMULATE_SSTEP=3Dy<br>CONFIG_ZONE_DMA32=3Dy<br>CONFIG_PGTABLE_LEVELS=3D4<b=
r>CONFIG_DEFCONFIG_LIST=3D&quot;/lib/modules/$UNAME_RELEASE/.config&quot;<b=
r>CONFIG_IRQ_WORK=3Dy<br><br>#<br># General setup<br>#<br>CONFIG_INIT_ENV_A=
RG_LIMIT=3D32<br>CONFIG_CROSS_COMPILE=3D&quot;&quot;<br># CONFIG_COMPILE_TE=
ST is not set<br>CONFIG_LOCALVERSION=3D&quot;&quot;<br>CONFIG_LOCALVERSION_=
AUTO=3Dy<br>CONFIG_DEFAULT_HOSTNAME=3D&quot;(none)&quot;<br>CONFIG_SWAP=3Dy=
<br>CONFIG_SYSVIPC=3Dy<br>CONFIG_SYSVIPC_SYSCTL=3Dy<br>CONFIG_POSIX_MQUEUE=
=3Dy<br>CONFIG_POSIX_MQUEUE_SYSCTL=3Dy<br>CONFIG_CROSS_MEMORY_ATTACH=3Dy<br=
>CONFIG_FHANDLE=3Dy<br>CONFIG_USELIB=3Dy<br># CONFIG_AUDIT is not set<br>CO=
NFIG_HAVE_ARCH_AUDITSYSCALL=3Dy<br><br>#<br># IRQ subsystem<br>#<br>CONFIG_=
GENERIC_IRQ_SHOW=3Dy<br>CONFIG_GENERIC_IRQ_SHOW_LEVEL=3Dy<br>CONFIG_IRQ_EDG=
E_EOI_HANDLER=3Dy<br>CONFIG_IRQ_DOMAIN=3Dy<br>CONFIG_GENERIC_MSI_IRQ=3Dy<br=
>CONFIG_IRQ_DOMAIN_DEBUG=3Dy<br>CONFIG_IRQ_FORCED_THREADING=3Dy<br>CONFIG_S=
PARSE_IRQ=3Dy<br>CONFIG_GENERIC_TIME_VSYSCALL_OLD=3Dy<br>CONFIG_GENERIC_CLO=
CKEVENTS=3Dy<br>CONFIG_ARCH_HAS_TICK_BROADCAST=3Dy<br>CONFIG_GENERIC_CLOCKE=
VENTS_BROADCAST=3Dy<br>CONFIG_GENERIC_CMOS_UPDATE=3Dy<br><br>#<br># Timers =
subsystem<br>#<br>CONFIG_TICK_ONESHOT=3Dy<br>CONFIG_NO_HZ_COMMON=3Dy<br># C=
ONFIG_HZ_PERIODIC is not set<br>CONFIG_NO_HZ_IDLE=3Dy<br># CONFIG_NO_HZ_FUL=
L is not set<br>CONFIG_NO_HZ=3Dy<br>CONFIG_HIGH_RES_TIMERS=3Dy<br><br>#<br>=
# CPU/Task time and stats accounting<br>#<br>CONFIG_VIRT_CPU_ACCOUNTING=3Dy=
<br># CONFIG_TICK_CPU_ACCOUNTING is not set<br>CONFIG_VIRT_CPU_ACCOUNTING_N=
ATIVE=3Dy<br># CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set<br># CONFIG_BSD_PR=
OCESS_ACCT is not set<br>CONFIG_TASKSTATS=3Dy<br>CONFIG_TASK_DELAY_ACCT=3Dy=
<br># CONFIG_TASK_XACCT is not set<br><br>#<br># RCU Subsystem<br>#<br>CONF=
IG_TREE_RCU=3Dy<br># CONFIG_RCU_EXPERT is not set<br>CONFIG_SRCU=3Dy<br># C=
ONFIG_TASKS_RCU is not set<br>CONFIG_RCU_STALL_COMMON=3Dy<br># CONFIG_TREE_=
RCU_TRACE is not set<br># CONFIG_RCU_EXPEDITE_BOOT is not set<br>CONFIG_BUI=
LD_BIN2C=3Dy<br>CONFIG_IKCONFIG=3Dy<br>CONFIG_IKCONFIG_PROC=3Dy<br>CONFIG_L=
OG_BUF_SHIFT=3D17<br>CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12<br>CONFIG_ARCH_SUPPO=
RTS_NUMA_BALANCING=3Dy<br># CONFIG_NUMA_BALANCING is not set<br>CONFIG_CGRO=
UPS=3Dy<br># CONFIG_CGROUP_DEBUG is not set<br># CONFIG_CGROUP_FREEZER is n=
ot set<br># CONFIG_CGROUP_PIDS is not set<br># CONFIG_CGROUP_DEVICE is not =
set<br>CONFIG_CPUSETS=3Dy<br>CONFIG_PROC_PID_CPUSET=3Dy<br># CONFIG_CGROUP_=
CPUACCT is not set<br># CONFIG_MEMCG is not set<br># CONFIG_CGROUP_HUGETLB =
is not set<br># CONFIG_CGROUP_PERF is not set<br># CONFIG_CGROUP_SCHED is n=
ot set<br># CONFIG_BLK_CGROUP is not set<br># CONFIG_CHECKPOINT_RESTORE is =
not set<br>CONFIG_NAMESPACES=3Dy<br>CONFIG_UTS_NS=3Dy<br>CONFIG_IPC_NS=3Dy<=
br># CONFIG_USER_NS is not set<br>CONFIG_PID_NS=3Dy<br>CONFIG_NET_NS=3Dy<br=
># CONFIG_SCHED_AUTOGROUP is not set<br># CONFIG_SYSFS_DEPRECATED is not se=
t<br>CONFIG_RELAY=3Dy<br>CONFIG_BLK_DEV_INITRD=3Dy<br>CONFIG_INITRAMFS_SOUR=
CE=3D&quot;&quot;<br>CONFIG_RD_GZIP=3Dy<br>CONFIG_RD_BZIP2=3Dy<br>CONFIG_RD=
_LZMA=3Dy<br>CONFIG_RD_XZ=3Dy<br>CONFIG_RD_LZO=3Dy<br>CONFIG_RD_LZ4=3Dy<br>=
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set<br>CONFIG_SYSCTL=3Dy<br>CONFIG_ANO=
N_INODES=3Dy<br>CONFIG_SYSCTL_EXCEPTION_TRACE=3Dy<br>CONFIG_HAVE_PCSPKR_PLA=
TFORM=3Dy<br>CONFIG_BPF=3Dy<br># CONFIG_EXPERT is not set<br>CONFIG_MULTIUS=
ER=3Dy<br>CONFIG_SGETMASK_SYSCALL=3Dy<br>CONFIG_SYSFS_SYSCALL=3Dy<br># CONF=
IG_SYSCTL_SYSCALL is not set<br>CONFIG_KALLSYMS=3Dy<br>CONFIG_KALLSYMS_ALL=
=3Dy<br>CONFIG_PRINTK=3Dy<br>CONFIG_BUG=3Dy<br>CONFIG_ELF_CORE=3Dy<br>CONFI=
G_PCSPKR_PLATFORM=3Dy<br>CONFIG_BASE_FULL=3Dy<br>CONFIG_FUTEX=3Dy<br>CONFIG=
_EPOLL=3Dy<br>CONFIG_SIGNALFD=3Dy<br>CONFIG_TIMERFD=3Dy<br>CONFIG_EVENTFD=
=3Dy<br># CONFIG_BPF_SYSCALL is not set<br>CONFIG_SHMEM=3Dy<br>CONFIG_AIO=
=3Dy<br>CONFIG_ADVISE_SYSCALLS=3Dy<br># CONFIG_USERFAULTFD is not set<br>CO=
NFIG_PCI_QUIRKS=3Dy<br>CONFIG_MEMBARRIER=3Dy<br># CONFIG_EMBEDDED is not se=
t<br>CONFIG_HAVE_PERF_EVENTS=3Dy<br><br>#<br># Kernel Performance Events An=
d Counters<br>#<br>CONFIG_PERF_EVENTS=3Dy<br>CONFIG_VM_EVENT_COUNTERS=3Dy<b=
r>CONFIG_SLUB_DEBUG=3Dy<br># CONFIG_COMPAT_BRK is not set<br># CONFIG_SLAB =
is not set<br>CONFIG_SLUB=3Dy<br>CONFIG_SLUB_CPU_PARTIAL=3Dy<br># CONFIG_SY=
STEM_DATA_VERIFICATION is not set<br>CONFIG_PROFILING=3Dy<br>CONFIG_TRACEPO=
INTS=3Dy<br>CONFIG_KEXEC_CORE=3Dy<br>CONFIG_OPROFILE=3Dy<br>CONFIG_HAVE_OPR=
OFILE=3Dy<br>CONFIG_KPROBES=3Dy<br>CONFIG_JUMP_LABEL=3Dy<br># CONFIG_STATIC=
_KEYS_SELFTEST is not set<br># CONFIG_UPROBES is not set<br># CONFIG_HAVE_6=
4BIT_ALIGNED_ACCESS is not set<br>CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3D=
y<br>CONFIG_ARCH_USE_BUILTIN_BSWAP=3Dy<br>CONFIG_KRETPROBES=3Dy<br>CONFIG_H=
AVE_IOREMAP_PROT=3Dy<br>CONFIG_HAVE_KPROBES=3Dy<br>CONFIG_HAVE_KRETPROBES=
=3Dy<br>CONFIG_HAVE_ARCH_TRACEHOOK=3Dy<br>CONFIG_HAVE_DMA_ATTRS=3Dy<br>CONF=
IG_GENERIC_SMP_IDLE_THREAD=3Dy<br>CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy=
<br>CONFIG_HAVE_DMA_API_DEBUG=3Dy<br>CONFIG_HAVE_HW_BREAKPOINT=3Dy<br>CONFI=
G_HAVE_PERF_EVENTS_NMI=3Dy<br>CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy<br>CONFIG_HAV=
E_RCU_TABLE_FREE=3Dy<br>CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy<br>CONFIG_ARC=
H_WANT_IPC_PARSE_VERSION=3Dy<br>CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=
=3Dy<br>CONFIG_ARCH_WANT_OLD_COMPAT_IPC=3Dy<br>CONFIG_HAVE_ARCH_SECCOMP_FIL=
TER=3Dy<br>CONFIG_SECCOMP_FILTER=3Dy<br># CONFIG_CC_STACKPROTECTOR is not s=
et<br>CONFIG_HAVE_CONTEXT_TRACKING=3Dy<br>CONFIG_HAVE_VIRT_CPU_ACCOUNTING=
=3Dy<br>CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=3Dy<br>CONFIG_HAVE_MOD_ARCH_SPE=
CIFIC=3Dy<br>CONFIG_MODULES_USE_ELF_RELA=3Dy<br>CONFIG_HAVE_IRQ_EXIT_ON_IRQ=
_STACK=3Dy<br>CONFIG_ARCH_HAS_ELF_RANDOMIZE=3Dy<br>CONFIG_CLONE_BACKWARDS=
=3Dy<br>CONFIG_OLD_SIGSUSPEND=3Dy<br>CONFIG_COMPAT_OLD_SIGACTION=3Dy<br><br=
>#<br># GCOV-based kernel profiling<br>#<br># CONFIG_GCOV_KERNEL is not set=
<br>CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=3Dy<br># CONFIG_HAVE_GENERIC_DMA_COHER=
ENT is not set<br>CONFIG_SLABINFO=3Dy<br>CONFIG_RT_MUTEXES=3Dy<br>CONFIG_BA=
SE_SMALL=3D0<br>CONFIG_MODULES=3Dy<br># CONFIG_MODULE_FORCE_LOAD is not set=
<br>CONFIG_MODULE_UNLOAD=3Dy<br># CONFIG_MODULE_FORCE_UNLOAD is not set<br>=
CONFIG_MODVERSIONS=3Dy<br>CONFIG_MODULE_SRCVERSION_ALL=3Dy<br># CONFIG_MODU=
LE_SIG is not set<br># CONFIG_MODULE_COMPRESS is not set<br>CONFIG_MODULES_=
TREE_LOOKUP=3Dy<br>CONFIG_BLOCK=3Dy<br>CONFIG_BLK_DEV_BSG=3Dy<br>CONFIG_BLK=
_DEV_BSGLIB=3Dy<br># CONFIG_BLK_DEV_INTEGRITY is not set<br># CONFIG_BLK_CM=
DLINE_PARSER is not set<br><br>#<br># Partition Types<br>#<br>CONFIG_PARTIT=
ION_ADVANCED=3Dy<br># CONFIG_ACORN_PARTITION is not set<br># CONFIG_AIX_PAR=
TITION is not set<br># CONFIG_OSF_PARTITION is not set<br># CONFIG_AMIGA_PA=
RTITION is not set<br># CONFIG_ATARI_PARTITION is not set<br>CONFIG_MAC_PAR=
TITION=3Dy<br>CONFIG_MSDOS_PARTITION=3Dy<br># CONFIG_BSD_DISKLABEL is not s=
et<br># CONFIG_MINIX_SUBPARTITION is not set<br># CONFIG_SOLARIS_X86_PARTIT=
ION is not set<br># CONFIG_UNIXWARE_DISKLABEL is not set<br># CONFIG_LDM_PA=
RTITION is not set<br># CONFIG_SGI_PARTITION is not set<br># CONFIG_ULTRIX_=
PARTITION is not set<br># CONFIG_SUN_PARTITION is not set<br># CONFIG_KARMA=
_PARTITION is not set<br>CONFIG_EFI_PARTITION=3Dy<br># CONFIG_SYSV68_PARTIT=
ION is not set<br># CONFIG_CMDLINE_PARTITION is not set<br>CONFIG_BLOCK_COM=
PAT=3Dy<br><br>#<br># IO Schedulers<br>#<br>CONFIG_IOSCHED_NOOP=3Dy<br>CONF=
IG_IOSCHED_DEADLINE=3Dy<br>CONFIG_IOSCHED_CFQ=3Dy<br># CONFIG_DEFAULT_DEADL=
INE is not set<br>CONFIG_DEFAULT_CFQ=3Dy<br># CONFIG_DEFAULT_NOOP is not se=
t<br>CONFIG_DEFAULT_IOSCHED=3D&quot;cfq&quot;<br>CONFIG_PREEMPT_NOTIFIERS=
=3Dy<br>CONFIG_INLINE_SPIN_UNLOCK_IRQ=3Dy<br>CONFIG_INLINE_READ_UNLOCK=3Dy<=
br>CONFIG_INLINE_READ_UNLOCK_IRQ=3Dy<br>CONFIG_INLINE_WRITE_UNLOCK=3Dy<br>C=
ONFIG_INLINE_WRITE_UNLOCK_IRQ=3Dy<br>CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy<br=
>CONFIG_RWSEM_SPIN_ON_OWNER=3Dy<br>CONFIG_LOCK_SPIN_ON_OWNER=3Dy<br>CONFIG_=
FREEZER=3Dy<br>CONFIG_PPC_MSI_BITMAP=3Dy<br>CONFIG_PPC_XICS=3Dy<br>CONFIG_P=
PC_ICP_NATIVE=3Dy<br>CONFIG_PPC_ICP_HV=3Dy<br>CONFIG_PPC_ICS_RTAS=3Dy<br>CO=
NFIG_PPC_SCOM=3Dy<br># CONFIG_SCOM_DEBUGFS is not set<br># CONFIG_GE_FPGA i=
s not set<br><br>#<br># Platform support<br>#<br>CONFIG_PPC_POWERNV=3Dy<br>=
# CONFIG_OPAL_PRD is not set<br>CONFIG_PPC_PSERIES=3Dy<br>CONFIG_PPC_SPLPAR=
=3Dy<br>CONFIG_DTL=3Dy<br>CONFIG_PSERIES_ENERGY=3Dy<br>CONFIG_SCANLOG=3Dm<b=
r>CONFIG_IO_EVENT_IRQ=3Dy<br>CONFIG_LPARCFG=3Dy<br>CONFIG_PPC_PSERIES_DEBUG=
=3Dy<br>CONFIG_PPC_SMLPAR=3Dy<br>CONFIG_CMM=3Dy<br>CONFIG_HV_PERF_CTRS=3Dy<=
br>CONFIG_PPC_PMAC=3Dy<br>CONFIG_PPC_PMAC64=3Dy<br>CONFIG_PPC_MAPLE=3Dy<br>=
CONFIG_PPC_PASEMI=3Dy<br><br>#<br># PA Semi PWRficient options<br>#<br>CONF=
IG_PPC_PASEMI_IOMMU=3Dy<br># CONFIG_PPC_PASEMI_IOMMU_DMA_FORCE is not set<b=
r>CONFIG_PPC_PASEMI_MDIO=3Dy<br>CONFIG_PPC_PS3=3Dy<br><br>#<br># PS3 Platfo=
rm Options<br>#<br># CONFIG_PS3_ADVANCED is not set<br>CONFIG_PS3_HTAB_SIZE=
=3D20<br># CONFIG_PS3_DYNAMIC_DMA is not set<br>CONFIG_PS3_VUART=3Dy<br>CON=
FIG_PS3_PS3AV=3Dy<br>CONFIG_PS3_SYS_MANAGER=3Dy<br># CONFIG_PS3_REPOSITORY_=
WRITE is not set<br>CONFIG_PS3_STORAGE=3Dm<br>CONFIG_PS3_DISK=3Dm<br>CONFIG=
_PS3_ROM=3Dm<br>CONFIG_PS3_FLASH=3Dm<br>CONFIG_PS3_LPM=3Dm<br># CONFIG_PS3G=
ELIC_UDBG is not set<br>CONFIG_PPC_CELL=3Dy<br>CONFIG_PPC_CELL_COMMON=3Dy<b=
r>CONFIG_PPC_CELL_NATIVE=3Dy<br>CONFIG_PPC_IBM_CELL_BLADE=3Dy<br>CONFIG_PPC=
_CELL_QPACE=3Dy<br>CONFIG_AXON_MSI=3Dy<br><br>#<br># Cell Broadband Engine =
options<br>#<br>CONFIG_SPU_FS=3Dm<br>CONFIG_SPU_BASE=3Dy<br>CONFIG_CBE_RAS=
=3Dy<br>CONFIG_PPC_IBM_CELL_RESETBUTTON=3Dy<br>CONFIG_PPC_IBM_CELL_POWERBUT=
TON=3Dm<br>CONFIG_CBE_THERM=3Dm<br>CONFIG_PPC_PMI=3Dm<br>CONFIG_CBE_CPUFREQ=
_SPU_GOVERNOR=3Dm<br>CONFIG_OPROFILE_CELL=3Dy<br># CONFIG_PQ2ADS is not set=
<br># CONFIG_KVM_GUEST is not set<br># CONFIG_EPAPR_PARAVIRT is not set<br>=
CONFIG_PPC_NATIVE=3Dy<br>CONFIG_PPC_OF_BOOT_TRAMPOLINE=3Dy<br>CONFIG_UDBG_R=
TAS_CONSOLE=3Dy<br>CONFIG_PPC_SMP_MUXED_IPI=3Dy<br># CONFIG_IPIC is not set=
<br>CONFIG_MPIC=3Dy<br># CONFIG_PPC_EPAPR_HV_PIC is not set<br># CONFIG_MPI=
C_WEIRD is not set<br># CONFIG_MPIC_MSGR is not set<br>CONFIG_PPC_I8259=3Dy=
<br>CONFIG_U3_DART=3Dy<br>CONFIG_PPC_RTAS=3Dy<br>CONFIG_RTAS_ERROR_LOGGING=
=3Dy<br>CONFIG_PPC_RTAS_DAEMON=3Dy<br>CONFIG_RTAS_PROC=3Dy<br>CONFIG_RTAS_F=
LASH=3Dm<br>CONFIG_MMIO_NVRAM=3Dy<br>CONFIG_MPIC_U3_HT_IRQS=3Dy<br>CONFIG_M=
PIC_BROKEN_REGREAD=3Dy<br>CONFIG_IBMVIO=3Dy<br>CONFIG_IBMEBUS=3Dy<br>CONFIG=
_EEH=3Dy<br># CONFIG_PPC_MPC106 is not set<br>CONFIG_PPC_970_NAP=3Dy<br>CON=
FIG_PPC_P7_NAP=3Dy<br>CONFIG_PPC_INDIRECT_PIO=3Dy<br>CONFIG_PPC_INDIRECT_MM=
IO=3Dy<br>CONFIG_PPC_IO_WORKAROUNDS=3Dy<br><br>#<br># CPU Frequency scaling=
<br>#<br>CONFIG_CPU_FREQ=3Dy<br>CONFIG_CPU_FREQ_GOV_COMMON=3Dy<br>CONFIG_CP=
U_FREQ_STAT=3Dy<br># CONFIG_CPU_FREQ_STAT_DETAILS is not set<br># CONFIG_CP=
U_FREQ_DEFAULT_GOV_PERFORMANCE is not set<br># CONFIG_CPU_FREQ_DEFAULT_GOV_=
POWERSAVE is not set<br># CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set<=
br>CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=3Dy<br># CONFIG_CPU_FREQ_DEFAULT_GO=
V_CONSERVATIVE is not set<br>CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy<br>CONFIG_=
CPU_FREQ_GOV_POWERSAVE=3Dy<br>CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy<br>CONFIG_C=
PU_FREQ_GOV_ONDEMAND=3Dy<br>CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy<br><br>#<b=
r># CPU frequency scaling drivers<br>#<br>CONFIG_CPU_FREQ_CBE=3Dm<br># CONF=
IG_CPU_FREQ_CBE_PMI is not set<br># CONFIG_CPU_FREQ_MAPLE is not set<br>CON=
FIG_CPU_FREQ_PMAC64=3Dy<br>CONFIG_PPC_PASEMI_CPUFREQ=3Dy<br>CONFIG_POWERNV_=
CPUFREQ=3Dy<br><br>#<br># CPUIdle driver<br>#<br><br>#<br># CPU Idle<br>#<b=
r>CONFIG_CPU_IDLE=3Dy<br>CONFIG_CPU_IDLE_GOV_LADDER=3Dy<br>CONFIG_CPU_IDLE_=
GOV_MENU=3Dy<br><br>#<br># POWERPC CPU Idle Drivers<br>#<br>CONFIG_PSERIES_=
CPUIDLE=3Dy<br>CONFIG_POWERNV_CPUIDLE=3Dy<br># CONFIG_ARCH_NEEDS_CPU_IDLE_C=
OUPLED is not set<br>CONFIG_AXON_RAM=3Dm<br># CONFIG_FSL_ULI1575 is not set=
<br># CONFIG_SIMPLE_GPIO is not set<br><br>#<br># Kernel options<br>#<br>CO=
NFIG_HZ_100=3Dy<br># CONFIG_HZ_250 is not set<br># CONFIG_HZ_300 is not set=
<br># CONFIG_HZ_1000 is not set<br>CONFIG_HZ=3D100<br>CONFIG_SCHED_HRTICK=
=3Dy<br>CONFIG_PREEMPT_NONE=3Dy<br># CONFIG_PREEMPT_VOLUNTARY is not set<br=
># CONFIG_PREEMPT is not set<br>CONFIG_BINFMT_ELF=3Dy<br>CONFIG_COMPAT_BINF=
MT_ELF=3Dy<br>CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy<br>CONFIG_BINFMT_SCR=
IPT=3Dy<br># CONFIG_HAVE_AOUT is not set<br>CONFIG_BINFMT_MISC=3Dm<br>CONFI=
G_COREDUMP=3Dy<br>CONFIG_HUGETLB_PAGE_SIZE_VARIABLE=3Dy<br>CONFIG_PPC_TRANS=
ACTIONAL_MEM=3Dy<br>CONFIG_IOMMU_HELPER=3Dy<br># CONFIG_SWIOTLB is not set<=
br>CONFIG_HOTPLUG_CPU=3Dy<br>CONFIG_ARCH_CPU_PROBE_RELEASE=3Dy<br>CONFIG_AR=
CH_ENABLE_MEMORY_HOTPLUG=3Dy<br>CONFIG_ARCH_HAS_WALK_MEMORY=3Dy<br>CONFIG_A=
RCH_ENABLE_MEMORY_HOTREMOVE=3Dy<br>CONFIG_PPC64_SUPPORTS_MEMORY_FAILURE=3Dy=
<br>CONFIG_KEXEC=3Dy<br>CONFIG_CRASH_DUMP=3Dy<br># CONFIG_FA_DUMP is not se=
t<br>CONFIG_IRQ_ALL_CPUS=3Dy<br>CONFIG_NUMA=3Dy<br>CONFIG_NODES_SHIFT=3D8<b=
r>CONFIG_USE_PERCPU_NUMA_NODE_ID=3Dy<br>CONFIG_HAVE_MEMORYLESS_NODES=3Dy<br=
>CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy<br>CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy<br=
>CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy<br>CONFIG_SYS_SUPPORTS_HUGETLBFS=3Dy<br>=
CONFIG_SELECT_MEMORY_MODEL=3Dy<br>CONFIG_SPARSEMEM_MANUAL=3Dy<br>CONFIG_SPA=
RSEMEM=3Dy<br>CONFIG_NEED_MULTIPLE_NODES=3Dy<br>CONFIG_HAVE_MEMORY_PRESENT=
=3Dy<br>CONFIG_SPARSEMEM_EXTREME=3Dy<br>CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy=
<br>CONFIG_SPARSEMEM_VMEMMAP=3Dy<br>CONFIG_HAVE_MEMBLOCK=3Dy<br>CONFIG_HAVE=
_MEMBLOCK_NODE_MAP=3Dy<br>CONFIG_HAVE_GENERIC_RCU_GUP=3Dy<br>CONFIG_NO_BOOT=
MEM=3Dy<br>CONFIG_MEMORY_ISOLATION=3Dy<br>CONFIG_HAVE_BOOTMEM_INFO_NODE=3Dy=
<br>CONFIG_MEMORY_HOTPLUG=3Dy<br>CONFIG_MEMORY_HOTPLUG_SPARSE=3Dy<br>CONFIG=
_MEMORY_HOTREMOVE=3Dy<br>CONFIG_SPLIT_PTLOCK_CPUS=3D4<br>CONFIG_MEMORY_BALL=
OON=3Dy<br>CONFIG_BALLOON_COMPACTION=3Dy<br>CONFIG_COMPACTION=3Dy<br>CONFIG=
_MIGRATION=3Dy<br>CONFIG_PHYS_ADDR_T_64BIT=3Dy<br>CONFIG_ZONE_DMA_FLAG=3D1<=
br>CONFIG_BOUNCE=3Dy<br>CONFIG_MMU_NOTIFIER=3Dy<br>CONFIG_KSM=3Dy<br>CONFIG=
_DEFAULT_MMAP_MIN_ADDR=3D4096<br>CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy<br=
># CONFIG_MEMORY_FAILURE is not set<br># CONFIG_CLEANCACHE is not set<br># =
CONFIG_FRONTSWAP is not set<br>CONFIG_CMA=3Dy<br># CONFIG_CMA_DEBUG is not =
set<br># CONFIG_CMA_DEBUGFS is not set<br>CONFIG_CMA_AREAS=3D7<br># CONFIG_=
ZPOOL is not set<br># CONFIG_ZBUD is not set<br># CONFIG_ZSMALLOC is not se=
t<br># CONFIG_IDLE_PAGE_TRACKING is not set<br>CONFIG_ARCH_MEMORY_PROBE=3Dy=
<br>CONFIG_NODES_SPAN_OTHER_NODES=3Dy<br>CONFIG_PPC_4K_PAGES=3Dy<br># CONFI=
G_PPC_64K_PAGES is not set<br>CONFIG_FORCE_MAX_ZONEORDER=3D13<br>CONFIG_PPC=
_COPRO_BASE=3Dy<br>CONFIG_SCHED_SMT=3Dy<br>CONFIG_PPC_DENORMALISATION=3Dy<b=
r># CONFIG_CMDLINE_BOOL is not set<br>CONFIG_EXTRA_TARGETS=3D&quot;&quot;<b=
r>CONFIG_ARCH_WANTS_FREEZER_CONTROL=3Dy<br>CONFIG_SUSPEND=3Dy<br>CONFIG_SUS=
PEND_FREEZER=3Dy<br># CONFIG_HIBERNATION is not set<br>CONFIG_PM_SLEEP=3Dy<=
br>CONFIG_PM_SLEEP_SMP=3Dy<br># CONFIG_PM_AUTOSLEEP is not set<br># CONFIG_=
PM_WAKELOCKS is not set<br>CONFIG_PM=3Dy<br># CONFIG_PM_DEBUG is not set<br=
># CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set<br>CONFIG_SECCOMP=3Dy<br>CO=
NFIG_ISA_DMA_API=3Dy<br><br>#<br># Bus options<br>#<br>CONFIG_ZONE_DMA=3Dy<=
br>CONFIG_NEED_DMA_MAP_STATE=3Dy<br>CONFIG_NEED_SG_DMA_LENGTH=3Dy<br>CONFIG=
_GENERIC_ISA_DMA=3Dy<br># CONFIG_PPC_INDIRECT_PCI is not set<br>CONFIG_PPC_=
PCI_CHOICE=3Dy<br>CONFIG_PCI=3Dy<br>CONFIG_PCI_DOMAINS=3Dy<br>CONFIG_PCI_SY=
SCALL=3Dy<br># CONFIG_PCIEPORTBUS is not set<br>CONFIG_PCI_BUS_ADDR_T_64BIT=
=3Dy<br>CONFIG_PCI_MSI=3Dy<br># CONFIG_PCI_DEBUG is not set<br># CONFIG_PCI=
_REALLOC_ENABLE_AUTO is not set<br># CONFIG_PCI_STUB is not set<br># CONFIG=
_PCI_IOV is not set<br># CONFIG_PCI_PRI is not set<br># CONFIG_PCI_PASID is=
 not set<br><br>#<br># PCI host controller drivers<br>#<br>CONFIG_PCCARD=3D=
y<br>CONFIG_PCMCIA=3Dy<br>CONFIG_PCMCIA_LOAD_CIS=3Dy<br>CONFIG_CARDBUS=3Dy<=
br><br>#<br># PC-card bridges<br>#<br># CONFIG_YENTA is not set<br># CONFIG=
_PD6729 is not set<br># CONFIG_I82092 is not set<br>CONFIG_ELECTRA_CF=3Dy<b=
r>CONFIG_HOTPLUG_PCI=3Dy<br># CONFIG_HOTPLUG_PCI_CPCI is not set<br># CONFI=
G_HOTPLUG_PCI_SHPC is not set<br>CONFIG_HOTPLUG_PCI_RPA=3Dm<br>CONFIG_HOTPL=
UG_PCI_RPA_DLPAR=3Dm<br># CONFIG_HAS_RAPIDIO is not set<br># CONFIG_RAPIDIO=
 is not set<br>CONFIG_NONSTATIC_KERNEL=3Dy<br>CONFIG_RELOCATABLE=3Dy<br>CON=
FIG_PAGE_OFFSET=3D0xc000000000000000<br>CONFIG_KERNEL_START=3D0xc0000000000=
00000<br>CONFIG_PHYSICAL_START=3D0x00000000<br>CONFIG_ARCH_RANDOM=3Dy<br>CO=
NFIG_NET=3Dy<br>CONFIG_COMPAT_NETLINK_MESSAGES=3Dy<br>CONFIG_NET_INGRESS=3D=
y<br><br>#<br># Networking options<br>#<br>CONFIG_PACKET=3Dy<br># CONFIG_PA=
CKET_DIAG is not set<br>CONFIG_UNIX=3Dy<br># CONFIG_UNIX_DIAG is not set<br=
>CONFIG_XFRM=3Dy<br>CONFIG_XFRM_ALGO=3Dm<br>CONFIG_XFRM_USER=3Dm<br># CONFI=
G_XFRM_SUB_POLICY is not set<br># CONFIG_XFRM_MIGRATE is not set<br># CONFI=
G_XFRM_STATISTICS is not set<br>CONFIG_XFRM_IPCOMP=3Dm<br>CONFIG_NET_KEY=3D=
m<br># CONFIG_NET_KEY_MIGRATE is not set<br>CONFIG_INET=3Dy<br>CONFIG_IP_MU=
LTICAST=3Dy<br># CONFIG_IP_ADVANCED_ROUTER is not set<br>CONFIG_IP_PNP=3Dy<=
br>CONFIG_IP_PNP_DHCP=3Dy<br>CONFIG_IP_PNP_BOOTP=3Dy<br># CONFIG_IP_PNP_RAR=
P is not set<br>CONFIG_NET_IPIP=3Dy<br># CONFIG_NET_IPGRE_DEMUX is not set<=
br>CONFIG_NET_IP_TUNNEL=3Dy<br># CONFIG_IP_MROUTE is not set<br>CONFIG_SYN_=
COOKIES=3Dy<br># CONFIG_NET_IPVTI is not set<br># CONFIG_NET_UDP_TUNNEL is =
not set<br># CONFIG_NET_FOU is not set<br># CONFIG_NET_FOU_IP_TUNNELS is no=
t set<br>CONFIG_INET_AH=3Dm<br>CONFIG_INET_ESP=3Dm<br>CONFIG_INET_IPCOMP=3D=
m<br>CONFIG_INET_XFRM_TUNNEL=3Dm<br>CONFIG_INET_TUNNEL=3Dy<br>CONFIG_INET_X=
FRM_MODE_TRANSPORT=3Dy<br>CONFIG_INET_XFRM_MODE_TUNNEL=3Dy<br>CONFIG_INET_X=
FRM_MODE_BEET=3Dy<br>CONFIG_INET_LRO=3Dy<br>CONFIG_INET_DIAG=3Dy<br>CONFIG_=
INET_TCP_DIAG=3Dy<br># CONFIG_INET_UDP_DIAG is not set<br># CONFIG_TCP_CONG=
_ADVANCED is not set<br>CONFIG_TCP_CONG_CUBIC=3Dy<br>CONFIG_DEFAULT_TCP_CON=
G=3D&quot;cubic&quot;<br># CONFIG_TCP_MD5SIG is not set<br># CONFIG_IPV6 is=
 not set<br># CONFIG_NETWORK_SECMARK is not set<br>CONFIG_NET_PTP_CLASSIFY=
=3Dy<br># CONFIG_NETWORK_PHY_TIMESTAMPING is not set<br>CONFIG_NETFILTER=3D=
y<br># CONFIG_NETFILTER_DEBUG is not set<br># CONFIG_NETFILTER_ADVANCED is =
not set<br><br>#<br># Core Netfilter Configuration<br>#<br>CONFIG_NETFILTER=
_INGRESS=3Dy<br>CONFIG_NETFILTER_NETLINK=3Dm<br>CONFIG_NETFILTER_NETLINK_LO=
G=3Dm<br>CONFIG_NF_CONNTRACK=3Dm<br>CONFIG_NF_LOG_COMMON=3Dm<br>CONFIG_NF_C=
ONNTRACK_PROCFS=3Dy<br>CONFIG_NF_CONNTRACK_FTP=3Dm<br>CONFIG_NF_CONNTRACK_I=
RC=3Dm<br># CONFIG_NF_CONNTRACK_NETBIOS_NS is not set<br>CONFIG_NF_CONNTRAC=
K_SIP=3Dm<br>CONFIG_NF_CT_NETLINK=3Dm<br># CONFIG_NETFILTER_NETLINK_GLUE_CT=
 is not set<br>CONFIG_NF_NAT=3Dm<br>CONFIG_NF_NAT_NEEDED=3Dy<br># CONFIG_NF=
_NAT_AMANDA is not set<br>CONFIG_NF_NAT_FTP=3Dm<br>CONFIG_NF_NAT_IRC=3Dm<br=
>CONFIG_NF_NAT_SIP=3Dm<br># CONFIG_NF_NAT_TFTP is not set<br># CONFIG_NF_NA=
T_REDIRECT is not set<br># CONFIG_NF_TABLES is not set<br>CONFIG_NETFILTER_=
XTABLES=3Dm<br><br>#<br># Xtables combined modules<br>#<br>CONFIG_NETFILTER=
_XT_MARK=3Dm<br><br>#<br># Xtables targets<br>#<br>CONFIG_NETFILTER_XT_TARG=
ET_LOG=3Dm<br>CONFIG_NETFILTER_XT_NAT=3Dm<br># CONFIG_NETFILTER_XT_TARGET_N=
ETMAP is not set<br>CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dm<br># CONFIG_NETFIL=
TER_XT_TARGET_REDIRECT is not set<br>CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dm<=
br><br>#<br># Xtables matches<br>#<br>CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3D=
m<br>CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dm<br>CONFIG_NETFILTER_XT_MATCH_P=
OLICY=3Dm<br>CONFIG_NETFILTER_XT_MATCH_STATE=3Dm<br># CONFIG_IP_SET is not =
set<br># CONFIG_IP_VS is not set<br><br>#<br># IP: Netfilter Configuration<=
br>#<br>CONFIG_NF_DEFRAG_IPV4=3Dm<br>CONFIG_NF_CONNTRACK_IPV4=3Dm<br>CONFIG=
_NF_CONNTRACK_PROC_COMPAT=3Dy<br># CONFIG_NF_DUP_IPV4 is not set<br>CONFIG_=
NF_LOG_ARP=3Dm<br>CONFIG_NF_LOG_IPV4=3Dm<br>CONFIG_NF_REJECT_IPV4=3Dm<br>CO=
NFIG_NF_NAT_IPV4=3Dm<br>CONFIG_NF_NAT_MASQUERADE_IPV4=3Dm<br># CONFIG_NF_NA=
T_PPTP is not set<br># CONFIG_NF_NAT_H323 is not set<br>CONFIG_IP_NF_IPTABL=
ES=3Dm<br>CONFIG_IP_NF_FILTER=3Dm<br>CONFIG_IP_NF_TARGET_REJECT=3Dm<br>CONF=
IG_IP_NF_NAT=3Dm<br>CONFIG_IP_NF_TARGET_MASQUERADE=3Dm<br>CONFIG_IP_NF_MANG=
LE=3Dm<br># CONFIG_IP_NF_RAW is not set<br># CONFIG_BRIDGE_NF_EBTABLES is n=
ot set<br># CONFIG_IP_DCCP is not set<br># CONFIG_IP_SCTP is not set<br># C=
ONFIG_RDS is not set<br># CONFIG_TIPC is not set<br># CONFIG_ATM is not set=
<br># CONFIG_L2TP is not set<br>CONFIG_STP=3Dm<br>CONFIG_BRIDGE=3Dm<br>CONF=
IG_BRIDGE_IGMP_SNOOPING=3Dy<br>CONFIG_HAVE_NET_DSA=3Dy<br># CONFIG_VLAN_802=
1Q is not set<br># CONFIG_DECNET is not set<br>CONFIG_LLC=3Dm<br># CONFIG_L=
LC2 is not set<br># CONFIG_IPX is not set<br># CONFIG_ATALK is not set<br>#=
 CONFIG_X25 is not set<br># CONFIG_LAPB is not set<br># CONFIG_PHONET is no=
t set<br># CONFIG_IEEE802154 is not set<br># CONFIG_NET_SCHED is not set<br=
># CONFIG_DCB is not set<br>CONFIG_DNS_RESOLVER=3Dy<br># CONFIG_BATMAN_ADV =
is not set<br># CONFIG_OPENVSWITCH is not set<br># CONFIG_VSOCKETS is not s=
et<br># CONFIG_NETLINK_MMAP is not set<br># CONFIG_NETLINK_DIAG is not set<=
br># CONFIG_MPLS is not set<br># CONFIG_HSR is not set<br># CONFIG_NET_SWIT=
CHDEV is not set<br># CONFIG_NET_L3_MASTER_DEV is not set<br>CONFIG_RPS=3Dy=
<br>CONFIG_RFS_ACCEL=3Dy<br>CONFIG_XPS=3Dy<br># CONFIG_CGROUP_NET_PRIO is n=
ot set<br># CONFIG_CGROUP_NET_CLASSID is not set<br>CONFIG_NET_RX_BUSY_POLL=
=3Dy<br>CONFIG_BQL=3Dy<br>CONFIG_BPF_JIT=3Dy<br>CONFIG_NET_FLOW_LIMIT=3Dy<b=
r><br>#<br># Network testing<br>#<br># CONFIG_NET_PKTGEN is not set<br># CO=
NFIG_NET_TCPPROBE is not set<br># CONFIG_NET_DROP_MONITOR is not set<br># C=
ONFIG_HAMRADIO is not set<br># CONFIG_CAN is not set<br># CONFIG_IRDA is no=
t set<br># CONFIG_BT is not set<br># CONFIG_AF_RXRPC is not set<br>CONFIG_W=
IRELESS=3Dy<br>CONFIG_WIRELESS_EXT=3Dy<br>CONFIG_WEXT_CORE=3Dy<br>CONFIG_WE=
XT_PROC=3Dy<br># CONFIG_CFG80211 is not set<br># CONFIG_LIB80211 is not set=
<br><br>#<br># CFG80211 needs to be enabled for MAC80211<br>#<br>CONFIG_MAC=
80211_STA_HASH_MAX_SIZE=3D0<br># CONFIG_WIMAX is not set<br># CONFIG_RFKILL=
 is not set<br># CONFIG_NET_9P is not set<br># CONFIG_CAIF is not set<br># =
CONFIG_CEPH_LIB is not set<br># CONFIG_NFC is not set<br># CONFIG_LWTUNNEL =
is not set<br>CONFIG_HAVE_BPF_JIT=3Dy<br><br>#<br># Device Drivers<br>#<br>=
<br>#<br># Generic Driver Options<br>#<br>CONFIG_UEVENT_HELPER=3Dy<br>CONFI=
G_UEVENT_HELPER_PATH=3D&quot;/sbin/hotplug&quot;<br>CONFIG_DEVTMPFS=3Dy<br>=
CONFIG_DEVTMPFS_MOUNT=3Dy<br>CONFIG_STANDALONE=3Dy<br>CONFIG_PREVENT_FIRMWA=
RE_BUILD=3Dy<br>CONFIG_FW_LOADER=3Dy<br>CONFIG_FIRMWARE_IN_KERNEL=3Dy<br>CO=
NFIG_EXTRA_FIRMWARE=3D&quot;&quot;<br># CONFIG_FW_LOADER_USER_HELPER_FALLBA=
CK is not set<br>CONFIG_ALLOW_DEV_COREDUMP=3Dy<br># CONFIG_DEBUG_DRIVER is =
not set<br># CONFIG_DEBUG_DEVRES is not set<br># CONFIG_SYS_HYPERVISOR is n=
ot set<br># CONFIG_GENERIC_CPU_DEVICES is not set<br># CONFIG_DMA_SHARED_BU=
FFER is not set<br><br>#<br># Bus devices<br>#<br># CONFIG_CONNECTOR is not=
 set<br># CONFIG_MTD is not set<br>CONFIG_DTC=3Dy<br>CONFIG_OF=3Dy<br># CON=
FIG_OF_UNITTEST is not set<br>CONFIG_OF_FLATTREE=3Dy<br>CONFIG_OF_EARLY_FLA=
TTREE=3Dy<br>CONFIG_OF_DYNAMIC=3Dy<br>CONFIG_OF_ADDRESS=3Dy<br>CONFIG_OF_AD=
DRESS_PCI=3Dy<br>CONFIG_OF_IRQ=3Dy<br>CONFIG_OF_NET=3Dy<br>CONFIG_OF_MDIO=
=3Dy<br>CONFIG_OF_PCI=3Dy<br>CONFIG_OF_PCI_IRQ=3Dy<br>CONFIG_OF_RESERVED_ME=
M=3Dy<br># CONFIG_OF_OVERLAY is not set<br>CONFIG_ARCH_MIGHT_HAVE_PC_PARPOR=
T=3Dy<br># CONFIG_PARPORT is not set<br>CONFIG_BLK_DEV=3Dy<br># CONFIG_BLK_=
DEV_NULL_BLK is not set<br>CONFIG_BLK_DEV_FD=3Dy<br># CONFIG_BLK_DEV_PCIESS=
D_MTIP32XX is not set<br># CONFIG_BLK_CPQ_CISS_DA is not set<br># CONFIG_BL=
K_DEV_DAC960 is not set<br># CONFIG_BLK_DEV_UMEM is not set<br># CONFIG_BLK=
_DEV_COW_COMMON is not set<br>CONFIG_BLK_DEV_LOOP=3Dy<br>CONFIG_BLK_DEV_LOO=
P_MIN_COUNT=3D8<br># CONFIG_BLK_DEV_CRYPTOLOOP is not set<br># CONFIG_BLK_D=
EV_DRBD is not set<br>CONFIG_BLK_DEV_NBD=3Dm<br># CONFIG_BLK_DEV_SKD is not=
 set<br># CONFIG_BLK_DEV_SX8 is not set<br>CONFIG_BLK_DEV_RAM=3Dy<br>CONFIG=
_BLK_DEV_RAM_COUNT=3D16<br>CONFIG_BLK_DEV_RAM_SIZE=3D65536<br># CONFIG_CDRO=
M_PKTCDVD is not set<br># CONFIG_ATA_OVER_ETH is not set<br>CONFIG_VIRTIO_B=
LK=3Dm<br># CONFIG_BLK_DEV_HD is not set<br># CONFIG_BLK_DEV_RBD is not set=
<br># CONFIG_BLK_DEV_RSXX is not set<br># CONFIG_BLK_DEV_NVME is not set<br=
><br>#<br># Misc devices<br>#<br># CONFIG_SENSORS_LIS3LV02D is not set<br>#=
 CONFIG_AD525X_DPOT is not set<br># CONFIG_DUMMY_IRQ is not set<br># CONFIG=
_PHANTOM is not set<br># CONFIG_SGI_IOC4 is not set<br># CONFIG_TIFM_CORE i=
s not set<br># CONFIG_ICS932S401 is not set<br># CONFIG_ENCLOSURE_SERVICES =
is not set<br># CONFIG_HP_ILO is not set<br># CONFIG_APDS9802ALS is not set=
<br># CONFIG_ISL29003 is not set<br># CONFIG_ISL29020 is not set<br># CONFI=
G_SENSORS_TSL2550 is not set<br># CONFIG_SENSORS_BH1780 is not set<br># CON=
FIG_SENSORS_BH1770 is not set<br># CONFIG_SENSORS_APDS990X is not set<br># =
CONFIG_HMC6352 is not set<br># CONFIG_DS1682 is not set<br># CONFIG_BMP085_=
I2C is not set<br># CONFIG_USB_SWITCH_FSA9480 is not set<br># CONFIG_SRAM i=
s not set<br># CONFIG_C2PORT is not set<br><br>#<br># EEPROM support<br>#<b=
r># CONFIG_EEPROM_AT24 is not set<br># CONFIG_EEPROM_LEGACY is not set<br>#=
 CONFIG_EEPROM_MAX6875 is not set<br># CONFIG_EEPROM_93CX6 is not set<br># =
CONFIG_CB710_CORE is not set<br><br>#<br># Texas Instruments shared transpo=
rt line discipline<br>#<br># CONFIG_SENSORS_LIS3_I2C is not set<br><br>#<br=
># Altera FPGA firmware download module<br>#<br># CONFIG_ALTERA_STAPL is no=
t set<br><br>#<br># Intel MIC Bus Driver<br>#<br><br>#<br># SCIF Bus Driver=
<br>#<br><br>#<br># Intel MIC Host Driver<br>#<br><br>#<br># Intel MIC Card=
 Driver<br>#<br><br>#<br># SCIF Driver<br>#<br><br>#<br># Intel MIC Coproce=
ssor State Management (COSM) Drivers<br>#<br># CONFIG_GENWQE is not set<br>=
# CONFIG_ECHO is not set<br>CONFIG_CXL_BASE=3Dy<br>CONFIG_CXL_KERNEL_API=3D=
y<br>CONFIG_CXL_EEH=3Dy<br>CONFIG_CXL=3Dm<br>CONFIG_HAVE_IDE=3Dy<br>CONFIG_=
IDE=3Dy<br><br>#<br># Please see Documentation/ide/ide.txt for help/info on=
 IDE drives<br>#<br>CONFIG_IDE_XFER_MODE=3Dy<br>CONFIG_IDE_TIMINGS=3Dy<br>C=
ONFIG_IDE_ATAPI=3Dy<br># CONFIG_BLK_DEV_IDE_SATA is not set<br>CONFIG_IDE_G=
D=3Dy<br>CONFIG_IDE_GD_ATA=3Dy<br># CONFIG_IDE_GD_ATAPI is not set<br># CON=
FIG_BLK_DEV_IDECS is not set<br># CONFIG_BLK_DEV_DELKIN is not set<br>CONFI=
G_BLK_DEV_IDECD=3Dy<br>CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=3Dy<br># CONFIG_=
BLK_DEV_IDETAPE is not set<br># CONFIG_IDE_TASK_IOCTL is not set<br>CONFIG_=
IDE_PROC_FS=3Dy<br><br>#<br># IDE chipset support/bugfixes<br>#<br># CONFIG=
_BLK_DEV_PLATFORM is not set<br>CONFIG_BLK_DEV_IDEDMA_SFF=3Dy<br><br>#<br>#=
 PCI IDE chipsets support<br>#<br>CONFIG_BLK_DEV_IDEPCI=3Dy<br>CONFIG_IDEPC=
I_PCIBUS_ORDER=3Dy<br># CONFIG_BLK_DEV_OFFBOARD is not set<br>CONFIG_BLK_DE=
V_GENERIC=3Dy<br># CONFIG_BLK_DEV_OPTI621 is not set<br>CONFIG_BLK_DEV_IDED=
MA_PCI=3Dy<br># CONFIG_BLK_DEV_AEC62XX is not set<br># CONFIG_BLK_DEV_ALI15=
X3 is not set<br>CONFIG_BLK_DEV_AMD74XX=3Dy<br># CONFIG_BLK_DEV_CMD64X is n=
ot set<br># CONFIG_BLK_DEV_TRIFLEX is not set<br># CONFIG_BLK_DEV_HPT366 is=
 not set<br># CONFIG_BLK_DEV_JMICRON is not set<br># CONFIG_BLK_DEV_PIIX is=
 not set<br># CONFIG_BLK_DEV_IT8172 is not set<br># CONFIG_BLK_DEV_IT8213 i=
s not set<br># CONFIG_BLK_DEV_IT821X is not set<br># CONFIG_BLK_DEV_NS87415=
 is not set<br># CONFIG_BLK_DEV_PDC202XX_OLD is not set<br># CONFIG_BLK_DEV=
_PDC202XX_NEW is not set<br># CONFIG_BLK_DEV_SVWKS is not set<br># CONFIG_B=
LK_DEV_SIIMAGE is not set<br># CONFIG_BLK_DEV_SL82C105 is not set<br># CONF=
IG_BLK_DEV_SLC90E66 is not set<br># CONFIG_BLK_DEV_TRM290 is not set<br># C=
ONFIG_BLK_DEV_VIA82CXXX is not set<br># CONFIG_BLK_DEV_TC86C001 is not set<=
br>CONFIG_BLK_DEV_IDE_PMAC=3Dy<br>CONFIG_BLK_DEV_IDE_PMAC_ATA100FIRST=3Dy<b=
r>CONFIG_BLK_DEV_IDEDMA=3Dy<br><br>#<br># SCSI device support<br>#<br>CONFI=
G_SCSI_MOD=3Dy<br>CONFIG_RAID_ATTRS=3Dm<br>CONFIG_SCSI=3Dy<br>CONFIG_SCSI_D=
MA=3Dy<br>CONFIG_SCSI_NETLINK=3Dy<br># CONFIG_SCSI_MQ_DEFAULT is not set<br=
>CONFIG_SCSI_PROC_FS=3Dy<br><br>#<br># SCSI support type (disk, tape, CD-RO=
M)<br>#<br>CONFIG_BLK_DEV_SD=3Dy<br>CONFIG_CHR_DEV_ST=3Dy<br># CONFIG_CHR_D=
EV_OSST is not set<br>CONFIG_BLK_DEV_SR=3Dy<br>CONFIG_BLK_DEV_SR_VENDOR=3Dy=
<br>CONFIG_CHR_DEV_SG=3Dy<br># CONFIG_CHR_DEV_SCH is not set<br>CONFIG_SCSI=
_CONSTANTS=3Dy<br># CONFIG_SCSI_LOGGING is not set<br># CONFIG_SCSI_SCAN_AS=
YNC is not set<br><br>#<br># SCSI Transports<br>#<br>CONFIG_SCSI_SPI_ATTRS=
=3Dy<br>CONFIG_SCSI_FC_ATTRS=3Dy<br>CONFIG_SCSI_ISCSI_ATTRS=3Dm<br>CONFIG_S=
CSI_SAS_ATTRS=3Dm<br># CONFIG_SCSI_SAS_LIBSAS is not set<br>CONFIG_SCSI_SRP=
_ATTRS=3Dy<br>CONFIG_SCSI_LOWLEVEL=3Dy<br># CONFIG_ISCSI_TCP is not set<br>=
CONFIG_ISCSI_BOOT_SYSFS=3Dm<br>CONFIG_SCSI_CXGB3_ISCSI=3Dm<br>CONFIG_SCSI_C=
XGB4_ISCSI=3Dm<br>CONFIG_SCSI_BNX2_ISCSI=3Dm<br>CONFIG_BE2ISCSI=3Dm<br>CONF=
IG_CXLFLASH=3Dm<br># CONFIG_BLK_DEV_3W_XXXX_RAID is not set<br># CONFIG_SCS=
I_HPSA is not set<br># CONFIG_SCSI_3W_9XXX is not set<br># CONFIG_SCSI_3W_S=
AS is not set<br># CONFIG_SCSI_ACARD is not set<br># CONFIG_SCSI_AACRAID is=
 not set<br># CONFIG_SCSI_AIC7XXX is not set<br># CONFIG_SCSI_AIC79XX is no=
t set<br># CONFIG_SCSI_AIC94XX is not set<br># CONFIG_SCSI_MVSAS is not set=
<br># CONFIG_SCSI_MVUMI is not set<br># CONFIG_SCSI_ADVANSYS is not set<br>=
# CONFIG_SCSI_ARCMSR is not set<br># CONFIG_SCSI_ESAS2R is not set<br># CON=
FIG_MEGARAID_NEWGEN is not set<br># CONFIG_MEGARAID_LEGACY is not set<br># =
CONFIG_MEGARAID_SAS is not set<br>CONFIG_SCSI_MPT3SAS=3Dm<br>CONFIG_SCSI_MP=
T2SAS_MAX_SGE=3D128<br>CONFIG_SCSI_MPT3SAS_MAX_SGE=3D128<br>CONFIG_SCSI_MPT=
2SAS=3Dm<br># CONFIG_SCSI_UFSHCD is not set<br># CONFIG_SCSI_HPTIOP is not =
set<br># CONFIG_LIBFC is not set<br># CONFIG_SCSI_SNIC is not set<br># CONF=
IG_SCSI_DMX3191D is not set<br># CONFIG_SCSI_EATA is not set<br># CONFIG_SC=
SI_FUTURE_DOMAIN is not set<br># CONFIG_SCSI_GDTH is not set<br># CONFIG_SC=
SI_IPS is not set<br>CONFIG_SCSI_IBMVSCSI=3Dy<br>CONFIG_SCSI_IBMVFC=3Dm<br>=
CONFIG_SCSI_IBMVFC_TRACE=3Dy<br># CONFIG_SCSI_INITIO is not set<br># CONFIG=
_SCSI_INIA100 is not set<br># CONFIG_SCSI_STEX is not set<br>CONFIG_SCSI_SY=
M53C8XX_2=3Dy<br>CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=3D0<br>CONFIG_SC=
SI_SYM53C8XX_DEFAULT_TAGS=3D16<br>CONFIG_SCSI_SYM53C8XX_MAX_TAGS=3D64<br>CO=
NFIG_SCSI_SYM53C8XX_MMIO=3Dy<br>CONFIG_SCSI_IPR=3Dy<br>CONFIG_SCSI_IPR_TRAC=
E=3Dy<br>CONFIG_SCSI_IPR_DUMP=3Dy<br># CONFIG_SCSI_QLOGIC_1280 is not set<b=
r>CONFIG_SCSI_QLA_FC=3Dm<br>CONFIG_SCSI_QLA_ISCSI=3Dm<br>CONFIG_SCSI_LPFC=
=3Dm<br># CONFIG_SCSI_LPFC_DEBUG_FS is not set<br># CONFIG_SCSI_DC395x is n=
ot set<br># CONFIG_SCSI_AM53C974 is not set<br># CONFIG_SCSI_WD719X is not =
set<br># CONFIG_SCSI_DEBUG is not set<br># CONFIG_SCSI_PMCRAID is not set<b=
r># CONFIG_SCSI_PM8001 is not set<br># CONFIG_SCSI_BFA_FC is not set<br>CON=
FIG_SCSI_VIRTIO=3Dm<br># CONFIG_SCSI_CHELSIO_FCOE is not set<br># CONFIG_SC=
SI_LOWLEVEL_PCMCIA is not set<br>CONFIG_SCSI_DH=3Dy<br>CONFIG_SCSI_DH_RDAC=
=3Dm<br># CONFIG_SCSI_DH_HP_SW is not set<br># CONFIG_SCSI_DH_EMC is not se=
t<br>CONFIG_SCSI_DH_ALUA=3Dm<br># CONFIG_SCSI_OSD_INITIATOR is not set<br>C=
ONFIG_ATA=3Dy<br>CONFIG_ATA_NONSTANDARD=3Dy<br>CONFIG_ATA_VERBOSE_ERROR=3Dy=
<br>CONFIG_SATA_PMP=3Dy<br><br>#<br># Controllers with non-SFF native inter=
face<br>#<br>CONFIG_SATA_AHCI=3Dy<br># CONFIG_SATA_AHCI_PLATFORM is not set=
<br># CONFIG_AHCI_CEVA is not set<br># CONFIG_AHCI_QORIQ is not set<br># CO=
NFIG_SATA_INIC162X is not set<br># CONFIG_SATA_ACARD_AHCI is not set<br>CON=
FIG_SATA_SIL24=3Dy<br>CONFIG_ATA_SFF=3Dy<br><br>#<br># SFF controllers with=
 custom DMA interface<br>#<br># CONFIG_PDC_ADMA is not set<br># CONFIG_SATA=
_QSTOR is not set<br># CONFIG_SATA_SX4 is not set<br>CONFIG_ATA_BMDMA=3Dy<b=
r><br>#<br># SATA SFF controllers with BMDMA<br>#<br># CONFIG_ATA_PIIX is n=
ot set<br>CONFIG_SATA_MV=3Dy<br># CONFIG_SATA_NV is not set<br># CONFIG_SAT=
A_PROMISE is not set<br># CONFIG_SATA_SIL is not set<br># CONFIG_SATA_SIS i=
s not set<br>CONFIG_SATA_SVW=3Dy<br># CONFIG_SATA_ULI is not set<br># CONFI=
G_SATA_VIA is not set<br># CONFIG_SATA_VITESSE is not set<br><br>#<br># PAT=
A SFF controllers with BMDMA<br>#<br># CONFIG_PATA_ALI is not set<br># CONF=
IG_PATA_AMD is not set<br># CONFIG_PATA_ARTOP is not set<br># CONFIG_PATA_A=
TIIXP is not set<br># CONFIG_PATA_ATP867X is not set<br># CONFIG_PATA_CMD64=
X is not set<br># CONFIG_PATA_CYPRESS is not set<br># CONFIG_PATA_EFAR is n=
ot set<br># CONFIG_PATA_HPT366 is not set<br># CONFIG_PATA_HPT37X is not se=
t<br># CONFIG_PATA_HPT3X2N is not set<br># CONFIG_PATA_HPT3X3 is not set<br=
># CONFIG_PATA_IT8213 is not set<br># CONFIG_PATA_IT821X is not set<br># CO=
NFIG_PATA_JMICRON is not set<br># CONFIG_PATA_MACIO is not set<br># CONFIG_=
PATA_MARVELL is not set<br># CONFIG_PATA_NETCELL is not set<br># CONFIG_PAT=
A_NINJA32 is not set<br># CONFIG_PATA_NS87415 is not set<br># CONFIG_PATA_O=
LDPIIX is not set<br># CONFIG_PATA_OPTIDMA is not set<br># CONFIG_PATA_PDC2=
027X is not set<br># CONFIG_PATA_PDC_OLD is not set<br># CONFIG_PATA_RADISY=
S is not set<br># CONFIG_PATA_RDC is not set<br># CONFIG_PATA_SCH is not se=
t<br># CONFIG_PATA_SERVERWORKS is not set<br># CONFIG_PATA_SIL680 is not se=
t<br># CONFIG_PATA_SIS is not set<br># CONFIG_PATA_TOSHIBA is not set<br># =
CONFIG_PATA_TRIFLEX is not set<br># CONFIG_PATA_VIA is not set<br># CONFIG_=
PATA_WINBOND is not set<br><br>#<br># PIO-only SFF controllers<br>#<br># CO=
NFIG_PATA_CMD640_PCI is not set<br># CONFIG_PATA_MPIIX is not set<br># CONF=
IG_PATA_NS87410 is not set<br># CONFIG_PATA_OPTI is not set<br># CONFIG_PAT=
A_PCMCIA is not set<br># CONFIG_PATA_PLATFORM is not set<br># CONFIG_PATA_R=
Z1000 is not set<br><br>#<br># Generic fallback / legacy drivers<br>#<br># =
CONFIG_ATA_GENERIC is not set<br># CONFIG_PATA_LEGACY is not set<br>CONFIG_=
MD=3Dy<br>CONFIG_BLK_DEV_MD=3Dy<br>CONFIG_MD_AUTODETECT=3Dy<br>CONFIG_MD_LI=
NEAR=3Dy<br>CONFIG_MD_RAID0=3Dy<br>CONFIG_MD_RAID1=3Dy<br>CONFIG_MD_RAID10=
=3Dm<br>CONFIG_MD_RAID456=3Dm<br>CONFIG_MD_MULTIPATH=3Dm<br>CONFIG_MD_FAULT=
Y=3Dm<br># CONFIG_BCACHE is not set<br>CONFIG_BLK_DEV_DM_BUILTIN=3Dy<br>CON=
FIG_BLK_DEV_DM=3Dy<br># CONFIG_DM_MQ_DEFAULT is not set<br># CONFIG_DM_DEBU=
G is not set<br>CONFIG_DM_BUFIO=3Dm<br>CONFIG_DM_CRYPT=3Dm<br>CONFIG_DM_SNA=
PSHOT=3Dm<br># CONFIG_DM_THIN_PROVISIONING is not set<br># CONFIG_DM_CACHE =
is not set<br># CONFIG_DM_ERA is not set<br>CONFIG_DM_MIRROR=3Dm<br># CONFI=
G_DM_LOG_USERSPACE is not set<br># CONFIG_DM_RAID is not set<br>CONFIG_DM_Z=
ERO=3Dm<br>CONFIG_DM_MULTIPATH=3Dm<br>CONFIG_DM_MULTIPATH_QL=3Dm<br>CONFIG_=
DM_MULTIPATH_ST=3Dm<br># CONFIG_DM_DELAY is not set<br>CONFIG_DM_UEVENT=3Dy=
<br># CONFIG_DM_FLAKEY is not set<br># CONFIG_DM_VERITY is not set<br># CON=
FIG_DM_SWITCH is not set<br># CONFIG_DM_LOG_WRITES is not set<br># CONFIG_T=
ARGET_CORE is not set<br># CONFIG_FUSION is not set<br><br>#<br># IEEE 1394=
 (FireWire) support<br>#<br># CONFIG_FIREWIRE is not set<br># CONFIG_FIREWI=
RE_NOSY is not set<br>CONFIG_MACINTOSH_DRIVERS=3Dy<br>CONFIG_ADB_PMU=3Dy<br=
># CONFIG_ADB_PMU_LED is not set<br>CONFIG_PMAC_SMU=3Dy<br># CONFIG_MAC_EMU=
MOUSEBTN is not set<br>CONFIG_WINDFARM=3Dy<br>CONFIG_WINDFARM_PM81=3Dy<br>#=
 CONFIG_WINDFARM_PM72 is not set<br># CONFIG_WINDFARM_RM31 is not set<br>CO=
NFIG_WINDFARM_PM91=3Dy<br>CONFIG_WINDFARM_PM112=3Dy<br>CONFIG_WINDFARM_PM12=
1=3Dy<br># CONFIG_PMAC_RACKMETER is not set<br>CONFIG_NETDEVICES=3Dy<br>CON=
FIG_MII=3Dy<br>CONFIG_NET_CORE=3Dy<br>CONFIG_BONDING=3Dm<br>CONFIG_DUMMY=3D=
m<br># CONFIG_EQUALIZER is not set<br># CONFIG_NET_FC is not set<br># CONFI=
G_NET_TEAM is not set<br># CONFIG_MACVLAN is not set<br># CONFIG_VXLAN is n=
ot set<br>CONFIG_NETCONSOLE=3Dy<br>CONFIG_NETPOLL=3Dy<br>CONFIG_NET_POLL_CO=
NTROLLER=3Dy<br>CONFIG_TUN=3Dm<br># CONFIG_TUN_VNET_CROSS_LE is not set<br>=
# CONFIG_VETH is not set<br>CONFIG_VIRTIO_NET=3Dm<br># CONFIG_NLMON is not =
set<br>CONFIG_SUNGEM_PHY=3Dy<br># CONFIG_ARCNET is not set<br><br>#<br># CA=
IF transport drivers<br>#<br>CONFIG_VHOST_NET=3Dm<br>CONFIG_VHOST_RING=3Dm<=
br>CONFIG_VHOST=3Dm<br># CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set<br><br=
>#<br># Distributed Switch Architecture drivers<br>#<br># CONFIG_NET_DSA_MV=
88E6XXX is not set<br># CONFIG_NET_DSA_MV88E6XXX_NEED_PPU is not set<br>CON=
FIG_ETHERNET=3Dy<br>CONFIG_MDIO=3Dm<br>CONFIG_NET_VENDOR_3COM=3Dy<br># CONF=
IG_PCMCIA_3C574 is not set<br># CONFIG_PCMCIA_3C589 is not set<br>CONFIG_VO=
RTEX=3Dy<br># CONFIG_TYPHOON is not set<br>CONFIG_NET_VENDOR_ADAPTEC=3Dy<br=
># CONFIG_ADAPTEC_STARFIRE is not set<br>CONFIG_NET_VENDOR_AGERE=3Dy<br># C=
ONFIG_ET131X is not set<br>CONFIG_NET_VENDOR_ALTEON=3Dy<br>CONFIG_ACENIC=3D=
m<br>CONFIG_ACENIC_OMIT_TIGON_I=3Dy<br># CONFIG_ALTERA_TSE is not set<br>CO=
NFIG_NET_VENDOR_AMD=3Dy<br># CONFIG_AMD8111_ETH is not set<br>CONFIG_PCNET3=
2=3Dy<br># CONFIG_PCMCIA_NMCLAN is not set<br>CONFIG_NET_VENDOR_ARC=3Dy<br>=
# CONFIG_ARC_EMAC is not set<br>CONFIG_NET_VENDOR_ATHEROS=3Dy<br># CONFIG_A=
TL2 is not set<br># CONFIG_ATL1 is not set<br># CONFIG_ATL1E is not set<br>=
# CONFIG_ATL1C is not set<br># CONFIG_ALX is not set<br># CONFIG_NET_VENDOR=
_AURORA is not set<br>CONFIG_NET_CADENCE=3Dy<br># CONFIG_MACB is not set<br=
>CONFIG_NET_VENDOR_BROADCOM=3Dy<br># CONFIG_B44 is not set<br># CONFIG_BCMG=
ENET is not set<br>CONFIG_BNX2=3Dm<br>CONFIG_CNIC=3Dm<br>CONFIG_TIGON3=3Dy<=
br>CONFIG_BNX2X=3Dm<br># CONFIG_SYSTEMPORT is not set<br># CONFIG_BNXT is n=
ot set<br>CONFIG_NET_VENDOR_BROCADE=3Dy<br># CONFIG_BNA is not set<br>CONFI=
G_NET_VENDOR_CAVIUM=3Dy<br># CONFIG_THUNDER_NIC_PF is not set<br># CONFIG_T=
HUNDER_NIC_VF is not set<br># CONFIG_THUNDER_NIC_BGX is not set<br># CONFIG=
_LIQUIDIO is not set<br>CONFIG_NET_VENDOR_CHELSIO=3Dy<br>CONFIG_CHELSIO_T1=
=3Dm<br># CONFIG_CHELSIO_T1_1G is not set<br>CONFIG_CHELSIO_T3=3Dm<br>CONFI=
G_CHELSIO_T4=3Dm<br># CONFIG_CHELSIO_T4VF is not set<br>CONFIG_NET_VENDOR_C=
ISCO=3Dy<br># CONFIG_ENIC is not set<br># CONFIG_DNET is not set<br>CONFIG_=
NET_VENDOR_DEC=3Dy<br># CONFIG_NET_TULIP is not set<br>CONFIG_NET_VENDOR_DL=
INK=3Dy<br># CONFIG_DL2K is not set<br># CONFIG_SUNDANCE is not set<br>CONF=
IG_NET_VENDOR_EMULEX=3Dy<br>CONFIG_BE2NET=3Dm<br>CONFIG_BE2NET_HWMON=3Dy<br=
>CONFIG_NET_VENDOR_EZCHIP=3Dy<br># CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not=
 set<br>CONFIG_NET_VENDOR_EXAR=3Dy<br>CONFIG_S2IO=3Dm<br># CONFIG_VXGE is n=
ot set<br>CONFIG_NET_VENDOR_FUJITSU=3Dy<br># CONFIG_PCMCIA_FMVJ18X is not s=
et<br>CONFIG_NET_VENDOR_HP=3Dy<br># CONFIG_HP100 is not set<br>CONFIG_NET_V=
ENDOR_IBM=3Dy<br>CONFIG_IBMVETH=3Dm<br># CONFIG_IBM_EMAC is not set<br>CONF=
IG_IBM_EMAC_ZMII=3Dy<br>CONFIG_IBM_EMAC_RGMII=3Dy<br>CONFIG_IBM_EMAC_TAH=3D=
y<br>CONFIG_IBM_EMAC_EMAC4=3Dy<br># CONFIG_IBM_EMAC_NO_FLOW_CTRL is not set=
<br># CONFIG_IBM_EMAC_MAL_CLR_ICINTSTAT is not set<br># CONFIG_IBM_EMAC_MAL=
_COMMON_ERR is not set<br>CONFIG_EHEA=3Dm<br>CONFIG_NET_VENDOR_INTEL=3Dy<br=
>CONFIG_E100=3Dy<br>CONFIG_E1000=3Dy<br>CONFIG_E1000E=3Dy<br># CONFIG_IGB i=
s not set<br># CONFIG_IGBVF is not set<br>CONFIG_IXGB=3Dm<br>CONFIG_IXGBE=
=3Dm<br>CONFIG_IXGBE_HWMON=3Dy<br># CONFIG_IXGBEVF is not set<br># CONFIG_I=
40E is not set<br># CONFIG_I40EVF is not set<br># CONFIG_FM10K is not set<b=
r>CONFIG_NET_VENDOR_I825XX=3Dy<br># CONFIG_JME is not set<br>CONFIG_NET_VEN=
DOR_MARVELL=3Dy<br># CONFIG_MVMDIO is not set<br># CONFIG_SKGE is not set<b=
r># CONFIG_SKY2 is not set<br>CONFIG_NET_VENDOR_MELLANOX=3Dy<br>CONFIG_MLX4=
_EN=3Dm<br>CONFIG_MLX4_CORE=3Dm<br>CONFIG_MLX4_DEBUG=3Dy<br># CONFIG_MLX5_C=
ORE is not set<br># CONFIG_MLXSW_CORE is not set<br>CONFIG_NET_VENDOR_MICRE=
L=3Dy<br># CONFIG_KS8851_MLL is not set<br># CONFIG_KSZ884X_PCI is not set<=
br>CONFIG_NET_VENDOR_MYRI=3Dy<br>CONFIG_MYRI10GE=3Dm<br># CONFIG_FEALNX is =
not set<br>CONFIG_NET_VENDOR_NATSEMI=3Dy<br># CONFIG_NATSEMI is not set<br>=
# CONFIG_NS83820 is not set<br>CONFIG_NET_VENDOR_8390=3Dy<br># CONFIG_PCMCI=
A_AXNET is not set<br># CONFIG_NE2K_PCI is not set<br># CONFIG_PCMCIA_PCNET=
 is not set<br>CONFIG_NET_VENDOR_NVIDIA=3Dy<br># CONFIG_FORCEDETH is not se=
t<br>CONFIG_NET_VENDOR_OKI=3Dy<br># CONFIG_ETHOC is not set<br>CONFIG_NET_P=
ACKET_ENGINE=3Dy<br># CONFIG_HAMACHI is not set<br># CONFIG_YELLOWFIN is no=
t set<br>CONFIG_NET_VENDOR_PASEMI=3Dy<br>CONFIG_PASEMI_MAC=3Dy<br>CONFIG_NE=
T_VENDOR_QLOGIC=3Dy<br># CONFIG_QLA3XXX is not set<br># CONFIG_QLCNIC is no=
t set<br>CONFIG_QLGE=3Dm<br>CONFIG_NETXEN_NIC=3Dm<br># CONFIG_QED is not se=
t<br>CONFIG_NET_VENDOR_QUALCOMM=3Dy<br>CONFIG_NET_VENDOR_REALTEK=3Dy<br># C=
ONFIG_8139CP is not set<br># CONFIG_8139TOO is not set<br># CONFIG_R8169 is=
 not set<br>CONFIG_NET_VENDOR_RENESAS=3Dy<br>CONFIG_NET_VENDOR_RDC=3Dy<br>#=
 CONFIG_R6040 is not set<br>CONFIG_NET_VENDOR_ROCKER=3Dy<br>CONFIG_NET_VEND=
OR_SAMSUNG=3Dy<br># CONFIG_SXGBE_ETH is not set<br>CONFIG_NET_VENDOR_SEEQ=
=3Dy<br>CONFIG_NET_VENDOR_SILAN=3Dy<br># CONFIG_SC92031 is not set<br>CONFI=
G_NET_VENDOR_SIS=3Dy<br># CONFIG_SIS900 is not set<br># CONFIG_SIS190 is no=
t set<br># CONFIG_SFC is not set<br>CONFIG_NET_VENDOR_SMSC=3Dy<br># CONFIG_=
PCMCIA_SMC91C92 is not set<br># CONFIG_EPIC100 is not set<br># CONFIG_SMSC9=
11X is not set<br># CONFIG_SMSC9420 is not set<br>CONFIG_NET_VENDOR_STMICRO=
=3Dy<br># CONFIG_STMMAC_ETH is not set<br>CONFIG_NET_VENDOR_SUN=3Dy<br># CO=
NFIG_HAPPYMEAL is not set<br>CONFIG_SUNGEM=3Dy<br># CONFIG_CASSINI is not s=
et<br># CONFIG_NIU is not set<br>CONFIG_NET_VENDOR_SYNOPSYS=3Dy<br># CONFIG=
_SYNOPSYS_DWC_ETH_QOS is not set<br>CONFIG_NET_VENDOR_TEHUTI=3Dy<br># CONFI=
G_TEHUTI is not set<br>CONFIG_NET_VENDOR_TI=3Dy<br># CONFIG_TI_CPSW_ALE is =
not set<br># CONFIG_TLAN is not set<br>CONFIG_NET_VENDOR_TOSHIBA=3Dy<br>CON=
FIG_GELIC_NET=3Dm<br>CONFIG_GELIC_WIRELESS=3Dy<br>CONFIG_SPIDER_NET=3Dm<br>=
CONFIG_NET_VENDOR_VIA=3Dy<br># CONFIG_VIA_RHINE is not set<br># CONFIG_VIA_=
VELOCITY is not set<br>CONFIG_NET_VENDOR_WIZNET=3Dy<br># CONFIG_WIZNET_W510=
0 is not set<br># CONFIG_WIZNET_W5300 is not set<br>CONFIG_NET_VENDOR_XILIN=
X=3Dy<br># CONFIG_XILINX_LL_TEMAC is not set<br>CONFIG_NET_VENDOR_XIRCOM=3D=
y<br># CONFIG_PCMCIA_XIRC2PS is not set<br># CONFIG_FDDI is not set<br># CO=
NFIG_HIPPI is not set<br>CONFIG_PHYLIB=3Dy<br><br>#<br># MII PHY device dri=
vers<br>#<br># CONFIG_AQUANTIA_PHY is not set<br># CONFIG_AT803X_PHY is not=
 set<br># CONFIG_AMD_PHY is not set<br>CONFIG_MARVELL_PHY=3Dy<br># CONFIG_D=
AVICOM_PHY is not set<br># CONFIG_QSEMI_PHY is not set<br># CONFIG_LXT_PHY =
is not set<br># CONFIG_CICADA_PHY is not set<br># CONFIG_VITESSE_PHY is not=
 set<br># CONFIG_TERANETICS_PHY is not set<br># CONFIG_SMSC_PHY is not set<=
br>CONFIG_BCM_NET_PHYLIB=3Dm<br>CONFIG_BROADCOM_PHY=3Dm<br># CONFIG_BCM7XXX=
_PHY is not set<br># CONFIG_BCM87XX_PHY is not set<br># CONFIG_ICPLUS_PHY i=
s not set<br># CONFIG_REALTEK_PHY is not set<br># CONFIG_NATIONAL_PHY is no=
t set<br># CONFIG_STE10XP is not set<br># CONFIG_LSI_ET1011C_PHY is not set=
<br># CONFIG_MICREL_PHY is not set<br># CONFIG_DP83848_PHY is not set<br># =
CONFIG_DP83867_PHY is not set<br># CONFIG_MICROCHIP_PHY is not set<br># CON=
FIG_FIXED_PHY is not set<br># CONFIG_MDIO_BITBANG is not set<br># CONFIG_MD=
IO_OCTEON is not set<br># CONFIG_MDIO_BUS_MUX_MMIOREG is not set<br># CONFI=
G_MDIO_BCM_UNIMAC is not set<br>CONFIG_PPP=3Dm<br>CONFIG_PPP_BSDCOMP=3Dm<br=
>CONFIG_PPP_DEFLATE=3Dm<br># CONFIG_PPP_FILTER is not set<br># CONFIG_PPP_M=
PPE is not set<br># CONFIG_PPP_MULTILINK is not set<br>CONFIG_PPPOE=3Dm<br>=
CONFIG_PPP_ASYNC=3Dm<br>CONFIG_PPP_SYNC_TTY=3Dm<br># CONFIG_SLIP is not set=
<br>CONFIG_SLHC=3Dm<br>CONFIG_USB_NET_DRIVERS=3Dy<br># CONFIG_USB_CATC is n=
ot set<br># CONFIG_USB_KAWETH is not set<br># CONFIG_USB_PEGASUS is not set=
<br># CONFIG_USB_RTL8150 is not set<br># CONFIG_USB_RTL8152 is not set<br>#=
 CONFIG_USB_LAN78XX is not set<br># CONFIG_USB_USBNET is not set<br># CONFI=
G_USB_IPHETH is not set<br>CONFIG_WLAN=3Dy<br># CONFIG_PCMCIA_RAYCS is not =
set<br># CONFIG_PRISM54 is not set<br># CONFIG_HOSTAP is not set<br># CONFI=
G_WL_MEDIATEK is not set<br># CONFIG_WL_TI is not set<br><br>#<br># Enable =
WiMAX (Networking options) to see the WiMAX drivers<br>#<br># CONFIG_WAN is=
 not set<br># CONFIG_VMXNET3 is not set<br># CONFIG_ISDN is not set<br># CO=
NFIG_NVM is not set<br><br>#<br># Input device support<br>#<br>CONFIG_INPUT=
=3Dy<br>CONFIG_INPUT_LEDS=3Dm<br># CONFIG_INPUT_FF_MEMLESS is not set<br># =
CONFIG_INPUT_POLLDEV is not set<br># CONFIG_INPUT_SPARSEKMAP is not set<br>=
# CONFIG_INPUT_MATRIXKMAP is not set<br><br>#<br># Userland interfaces<br>#=
<br>CONFIG_INPUT_MOUSEDEV=3Dy<br># CONFIG_INPUT_MOUSEDEV_PSAUX is not set<b=
r>CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024<br>CONFIG_INPUT_MOUSEDEV_SCREEN_Y=
=3D768<br># CONFIG_INPUT_JOYDEV is not set<br>CONFIG_INPUT_EVDEV=3Dm<br># C=
ONFIG_INPUT_EVBUG is not set<br><br>#<br># Input Device Drivers<br>#<br>CON=
FIG_INPUT_KEYBOARD=3Dy<br># CONFIG_KEYBOARD_ADP5588 is not set<br># CONFIG_=
KEYBOARD_ADP5589 is not set<br>CONFIG_KEYBOARD_ATKBD=3Dy<br># CONFIG_KEYBOA=
RD_QT1070 is not set<br># CONFIG_KEYBOARD_QT2160 is not set<br># CONFIG_KEY=
BOARD_LKKBD is not set<br># CONFIG_KEYBOARD_TCA6416 is not set<br># CONFIG_=
KEYBOARD_TCA8418 is not set<br># CONFIG_KEYBOARD_LM8323 is not set<br># CON=
FIG_KEYBOARD_LM8333 is not set<br># CONFIG_KEYBOARD_MAX7359 is not set<br>#=
 CONFIG_KEYBOARD_MCS is not set<br># CONFIG_KEYBOARD_MPR121 is not set<br>#=
 CONFIG_KEYBOARD_NEWTON is not set<br># CONFIG_KEYBOARD_OPENCORES is not se=
t<br># CONFIG_KEYBOARD_STOWAWAY is not set<br># CONFIG_KEYBOARD_SUNKBD is n=
ot set<br># CONFIG_KEYBOARD_OMAP4 is not set<br># CONFIG_KEYBOARD_XTKBD is =
not set<br># CONFIG_KEYBOARD_CAP11XX is not set<br>CONFIG_INPUT_MOUSE=3Dy<b=
r>CONFIG_MOUSE_PS2=3Dy<br>CONFIG_MOUSE_PS2_ALPS=3Dy<br>CONFIG_MOUSE_PS2_LOG=
IPS2PP=3Dy<br>CONFIG_MOUSE_PS2_SYNAPTICS=3Dy<br>CONFIG_MOUSE_PS2_CYPRESS=3D=
y<br>CONFIG_MOUSE_PS2_TRACKPOINT=3Dy<br># CONFIG_MOUSE_PS2_ELANTECH is not =
set<br># CONFIG_MOUSE_PS2_SENTELIC is not set<br># CONFIG_MOUSE_PS2_TOUCHKI=
T is not set<br>CONFIG_MOUSE_PS2_FOCALTECH=3Dy<br># CONFIG_MOUSE_SERIAL is =
not set<br># CONFIG_MOUSE_APPLETOUCH is not set<br># CONFIG_MOUSE_BCM5974 i=
s not set<br># CONFIG_MOUSE_CYAPA is not set<br># CONFIG_MOUSE_ELAN_I2C is =
not set<br># CONFIG_MOUSE_VSXXXAA is not set<br># CONFIG_MOUSE_SYNAPTICS_I2=
C is not set<br># CONFIG_MOUSE_SYNAPTICS_USB is not set<br># CONFIG_INPUT_J=
OYSTICK is not set<br># CONFIG_INPUT_TABLET is not set<br># CONFIG_INPUT_TO=
UCHSCREEN is not set<br>CONFIG_INPUT_MISC=3Dy<br># CONFIG_INPUT_AD714X is n=
ot set<br># CONFIG_INPUT_BMA150 is not set<br># CONFIG_INPUT_E3X0_BUTTON is=
 not set<br>CONFIG_INPUT_PCSPKR=3Dm<br># CONFIG_INPUT_MMA8450 is not set<br=
># CONFIG_INPUT_MPU3050 is not set<br># CONFIG_INPUT_ATI_REMOTE2 is not set=
<br># CONFIG_INPUT_KEYSPAN_REMOTE is not set<br># CONFIG_INPUT_KXTJ9 is not=
 set<br># CONFIG_INPUT_POWERMATE is not set<br># CONFIG_INPUT_YEALINK is no=
t set<br># CONFIG_INPUT_CM109 is not set<br># CONFIG_INPUT_UINPUT is not se=
t<br># CONFIG_INPUT_PCF8574 is not set<br># CONFIG_INPUT_ADXL34X is not set=
<br># CONFIG_INPUT_IMS_PCU is not set<br># CONFIG_INPUT_CMA3000 is not set<=
br># CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set<br># CONFIG_INPUT_DRV2665_HAP=
TICS is not set<br># CONFIG_INPUT_DRV2667_HAPTICS is not set<br><br>#<br># =
Hardware I/O ports<br>#<br>CONFIG_SERIO=3Dy<br>CONFIG_ARCH_MIGHT_HAVE_PC_SE=
RIO=3Dy<br>CONFIG_SERIO_I8042=3Dy<br># CONFIG_SERIO_SERPORT is not set<br>#=
 CONFIG_SERIO_PCIPS2 is not set<br>CONFIG_SERIO_LIBPS2=3Dy<br># CONFIG_SERI=
O_RAW is not set<br># CONFIG_SERIO_XILINX_XPS_PS2 is not set<br># CONFIG_SE=
RIO_ALTERA_PS2 is not set<br># CONFIG_SERIO_PS2MULT is not set<br># CONFIG_=
SERIO_ARC_PS2 is not set<br># CONFIG_SERIO_APBPS2 is not set<br># CONFIG_US=
ERIO is not set<br># CONFIG_GAMEPORT is not set<br><br>#<br># Character dev=
ices<br>#<br>CONFIG_TTY=3Dy<br>CONFIG_VT=3Dy<br>CONFIG_CONSOLE_TRANSLATIONS=
=3Dy<br>CONFIG_VT_CONSOLE=3Dy<br>CONFIG_VT_CONSOLE_SLEEP=3Dy<br>CONFIG_HW_C=
ONSOLE=3Dy<br>CONFIG_VT_HW_CONSOLE_BINDING=3Dy<br>CONFIG_UNIX98_PTYS=3Dy<br=
># CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set<br>CONFIG_LEGACY_PTYS=3Dy<br=
>CONFIG_LEGACY_PTY_COUNT=3D256<br># CONFIG_SERIAL_NONSTANDARD is not set<br=
># CONFIG_NOZOMI is not set<br># CONFIG_N_GSM is not set<br># CONFIG_TRACE_=
SINK is not set<br># CONFIG_PPC_EPAPR_HV_BYTECHAN is not set<br>CONFIG_DEVM=
EM=3Dy<br>CONFIG_DEVKMEM=3Dy<br><br>#<br># Serial drivers<br>#<br>CONFIG_SE=
RIAL_EARLYCON=3Dy<br>CONFIG_SERIAL_8250=3Dy<br>CONFIG_SERIAL_8250_DEPRECATE=
D_OPTIONS=3Dy<br>CONFIG_SERIAL_8250_CONSOLE=3Dy<br>CONFIG_SERIAL_8250_PCI=
=3Dy<br># CONFIG_SERIAL_8250_CS is not set<br>CONFIG_SERIAL_8250_NR_UARTS=
=3D4<br>CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4<br># CONFIG_SERIAL_8250_EXTEND=
ED is not set<br>CONFIG_SERIAL_8250_FSL=3Dy<br># CONFIG_SERIAL_8250_DW is n=
ot set<br># CONFIG_SERIAL_8250_RT288X is not set<br># CONFIG_SERIAL_8250_IN=
GENIC is not set<br># CONFIG_SERIAL_8250_MID is not set<br><br>#<br># Non-8=
250 serial port support<br>#<br># CONFIG_SERIAL_UARTLITE is not set<br>CONF=
IG_SERIAL_CORE=3Dy<br>CONFIG_SERIAL_CORE_CONSOLE=3Dy<br># CONFIG_SERIAL_PMA=
CZILOG is not set<br>CONFIG_SERIAL_ICOM=3Dm<br>CONFIG_SERIAL_JSM=3Dm<br># C=
ONFIG_SERIAL_OF_PLATFORM is not set<br># CONFIG_SERIAL_OF_PLATFORM_NWPSERIA=
L is not set<br># CONFIG_SERIAL_SCCNXP is not set<br># CONFIG_SERIAL_SC16IS=
7XX is not set<br># CONFIG_SERIAL_ALTERA_JTAGUART is not set<br># CONFIG_SE=
RIAL_ALTERA_UART is not set<br># CONFIG_SERIAL_XILINX_PS_UART is not set<br=
># CONFIG_SERIAL_ARC is not set<br># CONFIG_SERIAL_RP2 is not set<br># CONF=
IG_SERIAL_FSL_LPUART is not set<br># CONFIG_SERIAL_CONEXANT_DIGICOLOR is no=
t set<br>CONFIG_HVC_DRIVER=3Dy<br>CONFIG_HVC_IRQ=3Dy<br>CONFIG_HVC_CONSOLE=
=3Dy<br># CONFIG_HVC_OLD_HVSI is not set<br>CONFIG_HVC_OPAL=3Dy<br>CONFIG_H=
VC_RTAS=3Dy<br># CONFIG_HVC_UDBG is not set<br>CONFIG_HVCS=3Dm<br>CONFIG_VI=
RTIO_CONSOLE=3Dm<br>CONFIG_IBM_BSR=3Dm<br># CONFIG_IPMI_HANDLER is not set<=
br>CONFIG_HW_RANDOM=3Dm<br># CONFIG_HW_RANDOM_TIMERIOMEM is not set<br>CONF=
IG_HW_RANDOM_AMD=3Dm<br>CONFIG_HW_RANDOM_PASEMI=3Dm<br># CONFIG_HW_RANDOM_V=
IRTIO is not set<br>CONFIG_HW_RANDOM_PSERIES=3Dm<br>CONFIG_HW_RANDOM_POWERN=
V=3Dm<br># CONFIG_R3964 is not set<br># CONFIG_APPLICOM is not set<br><br>#=
<br># PCMCIA character devices<br>#<br># CONFIG_SYNCLINK_CS is not set<br>#=
 CONFIG_CARDMAN_4000 is not set<br># CONFIG_CARDMAN_4040 is not set<br># CO=
NFIG_IPWIRELESS is not set<br>CONFIG_RAW_DRIVER=3Dy<br>CONFIG_MAX_RAW_DEVS=
=3D256<br># CONFIG_HANGCHECK_TIMER is not set<br># CONFIG_TCG_TPM is not se=
t<br>CONFIG_DEVPORT=3Dy<br># CONFIG_XILLYBUS is not set<br><br>#<br># I2C s=
upport<br>#<br>CONFIG_I2C=3Dy<br>CONFIG_I2C_BOARDINFO=3Dy<br>CONFIG_I2C_COM=
PAT=3Dy<br>CONFIG_I2C_CHARDEV=3Dy<br># CONFIG_I2C_MUX is not set<br>CONFIG_=
I2C_HELPER_AUTO=3Dy<br>CONFIG_I2C_ALGOBIT=3Dy<br><br>#<br># I2C Hardware Bu=
s support<br>#<br><br>#<br># PC SMBus host controller drivers<br>#<br># CON=
FIG_I2C_ALI1535 is not set<br># CONFIG_I2C_ALI1563 is not set<br># CONFIG_I=
2C_ALI15X3 is not set<br># CONFIG_I2C_AMD756 is not set<br>CONFIG_I2C_AMD81=
11=3Dy<br># CONFIG_I2C_I801 is not set<br># CONFIG_I2C_ISCH is not set<br>#=
 CONFIG_I2C_PIIX4 is not set<br># CONFIG_I2C_NFORCE2 is not set<br># CONFIG=
_I2C_SIS5595 is not set<br># CONFIG_I2C_SIS630 is not set<br># CONFIG_I2C_S=
IS96X is not set<br># CONFIG_I2C_VIA is not set<br># CONFIG_I2C_VIAPRO is n=
ot set<br><br>#<br># Mac SMBus host controller drivers<br>#<br>CONFIG_I2C_P=
OWERMAC=3Dy<br><br>#<br># I2C system bus drivers (mostly embedded / system-=
on-chip)<br>#<br># CONFIG_I2C_DESIGNWARE_PLATFORM is not set<br># CONFIG_I2=
C_DESIGNWARE_PCI is not set<br># CONFIG_I2C_MPC is not set<br># CONFIG_I2C_=
OCORES is not set<br>CONFIG_I2C_PASEMI=3Dy<br># CONFIG_I2C_PCA_PLATFORM is =
not set<br># CONFIG_I2C_PXA_PCI is not set<br># CONFIG_I2C_SIMTEC is not se=
t<br># CONFIG_I2C_XILINX is not set<br><br>#<br># External I2C/SMBus adapte=
r drivers<br>#<br># CONFIG_I2C_DIOLAN_U2C is not set<br># CONFIG_I2C_PARPOR=
T_LIGHT is not set<br># CONFIG_I2C_ROBOTFUZZ_OSIF is not set<br># CONFIG_I2=
C_TAOS_EVM is not set<br># CONFIG_I2C_TINY_USB is not set<br><br>#<br># Oth=
er I2C/SMBus bus drivers<br>#<br>CONFIG_I2C_OPAL=3Dy<br># CONFIG_I2C_STUB i=
s not set<br># CONFIG_I2C_SLAVE is not set<br># CONFIG_I2C_DEBUG_CORE is no=
t set<br># CONFIG_I2C_DEBUG_ALGO is not set<br># CONFIG_I2C_DEBUG_BUS is no=
t set<br># CONFIG_SPI is not set<br># CONFIG_SPMI is not set<br># CONFIG_HS=
I is not set<br><br>#<br># PPS support<br>#<br>CONFIG_PPS=3Dy<br># CONFIG_P=
PS_DEBUG is not set<br><br>#<br># PPS clients support<br>#<br># CONFIG_PPS_=
CLIENT_KTIMER is not set<br># CONFIG_PPS_CLIENT_LDISC is not set<br># CONFI=
G_PPS_CLIENT_GPIO is not set<br><br>#<br># PPS generators support<br>#<br><=
br>#<br># PTP clock support<br>#<br>CONFIG_PTP_1588_CLOCK=3Dy<br><br>#<br>#=
 Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.<b=
r>#<br>CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=3Dy<br># CONFIG_GPIOLIB is not set=
<br># CONFIG_W1 is not set<br># CONFIG_POWER_SUPPLY is not set<br># CONFIG_=
POWER_AVS is not set<br>CONFIG_HWMON=3Dy<br># CONFIG_HWMON_VID is not set<b=
r># CONFIG_HWMON_DEBUG_CHIP is not set<br><br>#<br># Native drivers<br>#<br=
># CONFIG_SENSORS_AD7414 is not set<br># CONFIG_SENSORS_AD7418 is not set<b=
r># CONFIG_SENSORS_ADM1021 is not set<br># CONFIG_SENSORS_ADM1025 is not se=
t<br># CONFIG_SENSORS_ADM1026 is not set<br># CONFIG_SENSORS_ADM1029 is not=
 set<br># CONFIG_SENSORS_ADM1031 is not set<br># CONFIG_SENSORS_ADM9240 is =
not set<br># CONFIG_SENSORS_ADT7410 is not set<br># CONFIG_SENSORS_ADT7411 =
is not set<br># CONFIG_SENSORS_ADT7462 is not set<br># CONFIG_SENSORS_ADT74=
70 is not set<br># CONFIG_SENSORS_ADT7475 is not set<br># CONFIG_SENSORS_AS=
C7621 is not set<br># CONFIG_SENSORS_ATXP1 is not set<br># CONFIG_SENSORS_D=
S620 is not set<br># CONFIG_SENSORS_DS1621 is not set<br># CONFIG_SENSORS_I=
5K_AMB is not set<br># CONFIG_SENSORS_F75375S is not set<br># CONFIG_SENSOR=
S_GL518SM is not set<br># CONFIG_SENSORS_GL520SM is not set<br># CONFIG_SEN=
SORS_G760A is not set<br># CONFIG_SENSORS_G762 is not set<br># CONFIG_SENSO=
RS_HIH6130 is not set<br>CONFIG_SENSORS_IBMPOWERNV=3Dy<br># CONFIG_SENSORS_=
JC42 is not set<br># CONFIG_SENSORS_POWR1220 is not set<br># CONFIG_SENSORS=
_LINEAGE is not set<br># CONFIG_SENSORS_LTC2945 is not set<br># CONFIG_SENS=
ORS_LTC4151 is not set<br># CONFIG_SENSORS_LTC4215 is not set<br># CONFIG_S=
ENSORS_LTC4222 is not set<br># CONFIG_SENSORS_LTC4245 is not set<br># CONFI=
G_SENSORS_LTC4260 is not set<br># CONFIG_SENSORS_LTC4261 is not set<br># CO=
NFIG_SENSORS_MAX16065 is not set<br># CONFIG_SENSORS_MAX1619 is not set<br>=
# CONFIG_SENSORS_MAX1668 is not set<br># CONFIG_SENSORS_MAX197 is not set<b=
r># CONFIG_SENSORS_MAX6639 is not set<br># CONFIG_SENSORS_MAX6642 is not se=
t<br># CONFIG_SENSORS_MAX6650 is not set<br># CONFIG_SENSORS_MAX6697 is not=
 set<br># CONFIG_SENSORS_MAX31790 is not set<br># CONFIG_SENSORS_HTU21 is n=
ot set<br># CONFIG_SENSORS_MCP3021 is not set<br># CONFIG_SENSORS_LM63 is n=
ot set<br># CONFIG_SENSORS_LM73 is not set<br># CONFIG_SENSORS_LM75 is not =
set<br># CONFIG_SENSORS_LM77 is not set<br># CONFIG_SENSORS_LM78 is not set=
<br># CONFIG_SENSORS_LM80 is not set<br># CONFIG_SENSORS_LM83 is not set<br=
># CONFIG_SENSORS_LM85 is not set<br># CONFIG_SENSORS_LM87 is not set<br># =
CONFIG_SENSORS_LM90 is not set<br># CONFIG_SENSORS_LM92 is not set<br># CON=
FIG_SENSORS_LM93 is not set<br># CONFIG_SENSORS_LM95234 is not set<br># CON=
FIG_SENSORS_LM95241 is not set<br># CONFIG_SENSORS_LM95245 is not set<br># =
CONFIG_SENSORS_NTC_THERMISTOR is not set<br># CONFIG_SENSORS_NCT7802 is not=
 set<br># CONFIG_SENSORS_NCT7904 is not set<br># CONFIG_SENSORS_PCF8591 is =
not set<br># CONFIG_PMBUS is not set<br># CONFIG_SENSORS_SHT21 is not set<b=
r># CONFIG_SENSORS_SHTC1 is not set<br># CONFIG_SENSORS_SIS5595 is not set<=
br># CONFIG_SENSORS_EMC1403 is not set<br># CONFIG_SENSORS_EMC2103 is not s=
et<br># CONFIG_SENSORS_EMC6W201 is not set<br># CONFIG_SENSORS_SMSC47M192 i=
s not set<br># CONFIG_SENSORS_SCH56XX_COMMON is not set<br># CONFIG_SENSORS=
_SMM665 is not set<br># CONFIG_SENSORS_ADC128D818 is not set<br># CONFIG_SE=
NSORS_ADS1015 is not set<br># CONFIG_SENSORS_ADS7828 is not set<br># CONFIG=
_SENSORS_AMC6821 is not set<br># CONFIG_SENSORS_INA209 is not set<br># CONF=
IG_SENSORS_INA2XX is not set<br># CONFIG_SENSORS_TC74 is not set<br># CONFI=
G_SENSORS_THMC50 is not set<br># CONFIG_SENSORS_TMP102 is not set<br># CONF=
IG_SENSORS_TMP103 is not set<br># CONFIG_SENSORS_TMP401 is not set<br># CON=
FIG_SENSORS_TMP421 is not set<br># CONFIG_SENSORS_VIA686A is not set<br># C=
ONFIG_SENSORS_VT8231 is not set<br># CONFIG_SENSORS_W83781D is not set<br>#=
 CONFIG_SENSORS_W83791D is not set<br># CONFIG_SENSORS_W83792D is not set<b=
r># CONFIG_SENSORS_W83793 is not set<br># CONFIG_SENSORS_W83795 is not set<=
br># CONFIG_SENSORS_W83L785TS is not set<br># CONFIG_SENSORS_W83L786NG is n=
ot set<br># CONFIG_THERMAL is not set<br># CONFIG_WATCHDOG is not set<br>CO=
NFIG_SSB_POSSIBLE=3Dy<br><br>#<br># Sonics Silicon Backplane<br>#<br># CONF=
IG_SSB is not set<br>CONFIG_BCMA_POSSIBLE=3Dy<br><br>#<br># Broadcom specif=
ic AMBA<br>#<br># CONFIG_BCMA is not set<br><br>#<br># Multifunction device=
 drivers<br>#<br># CONFIG_MFD_CORE is not set<br># CONFIG_MFD_AS3711 is not=
 set<br># CONFIG_MFD_AS3722 is not set<br># CONFIG_PMIC_ADP5520 is not set<=
br># CONFIG_MFD_ATMEL_FLEXCOM is not set<br># CONFIG_MFD_ATMEL_HLCDC is not=
 set<br># CONFIG_MFD_BCM590XX is not set<br># CONFIG_MFD_AXP20X is not set<=
br># CONFIG_PMIC_DA903X is not set<br># CONFIG_MFD_DA9052_I2C is not set<br=
># CONFIG_MFD_DA9055 is not set<br># CONFIG_MFD_DA9062 is not set<br># CONF=
IG_MFD_DA9063 is not set<br># CONFIG_MFD_DA9150 is not set<br># CONFIG_MFD_=
DLN2 is not set<br># CONFIG_MFD_MC13XXX_I2C is not set<br># CONFIG_MFD_HI64=
21_PMIC is not set<br># CONFIG_HTC_PASIC3 is not set<br># CONFIG_LPC_ICH is=
 not set<br># CONFIG_LPC_SCH is not set<br># CONFIG_MFD_JANZ_CMODIO is not =
set<br># CONFIG_MFD_KEMPLD is not set<br># CONFIG_MFD_88PM800 is not set<br=
># CONFIG_MFD_88PM805 is not set<br># CONFIG_MFD_88PM860X is not set<br># C=
ONFIG_MFD_MAX14577 is not set<br># CONFIG_MFD_MAX77686 is not set<br># CONF=
IG_MFD_MAX77693 is not set<br># CONFIG_MFD_MAX77843 is not set<br># CONFIG_=
MFD_MAX8907 is not set<br># CONFIG_MFD_MAX8925 is not set<br># CONFIG_MFD_M=
AX8997 is not set<br># CONFIG_MFD_MAX8998 is not set<br># CONFIG_MFD_MT6397=
 is not set<br># CONFIG_MFD_MENF21BMC is not set<br># CONFIG_MFD_VIPERBOARD=
 is not set<br># CONFIG_MFD_RETU is not set<br># CONFIG_MFD_PCF50633 is not=
 set<br># CONFIG_MFD_RDC321X is not set<br># CONFIG_MFD_RTSX_PCI is not set=
<br># CONFIG_MFD_RT5033 is not set<br># CONFIG_MFD_RTSX_USB is not set<br>#=
 CONFIG_MFD_RC5T583 is not set<br># CONFIG_MFD_RK808 is not set<br># CONFIG=
_MFD_RN5T618 is not set<br># CONFIG_MFD_SEC_CORE is not set<br># CONFIG_MFD=
_SI476X_CORE is not set<br># CONFIG_MFD_SM501 is not set<br># CONFIG_MFD_SK=
Y81452 is not set<br># CONFIG_MFD_SMSC is not set<br># CONFIG_ABX500_CORE i=
s not set<br># CONFIG_MFD_STMPE is not set<br># CONFIG_MFD_SYSCON is not se=
t<br># CONFIG_MFD_TI_AM335X_TSCADC is not set<br># CONFIG_MFD_LP3943 is not=
 set<br># CONFIG_MFD_LP8788 is not set<br># CONFIG_MFD_PALMAS is not set<br=
># CONFIG_TPS6105X is not set<br># CONFIG_TPS6507X is not set<br># CONFIG_M=
FD_TPS65090 is not set<br># CONFIG_MFD_TPS65217 is not set<br># CONFIG_MFD_=
TPS65218 is not set<br># CONFIG_MFD_TPS6586X is not set<br># CONFIG_MFD_TPS=
80031 is not set<br># CONFIG_TWL4030_CORE is not set<br># CONFIG_TWL6040_CO=
RE is not set<br># CONFIG_MFD_WL1273_CORE is not set<br># CONFIG_MFD_LM3533=
 is not set<br># CONFIG_MFD_TC3589X is not set<br># CONFIG_MFD_TMIO is not =
set<br># CONFIG_MFD_VX855 is not set<br># CONFIG_MFD_ARIZONA_I2C is not set=
<br># CONFIG_MFD_WM8400 is not set<br># CONFIG_MFD_WM831X_I2C is not set<br=
># CONFIG_MFD_WM8350_I2C is not set<br># CONFIG_MFD_WM8994 is not set<br># =
CONFIG_REGULATOR is not set<br># CONFIG_MEDIA_SUPPORT is not set<br><br>#<b=
r># Graphics support<br>#<br># CONFIG_AGP is not set<br>CONFIG_VGA_ARB=3Dy<=
br>CONFIG_VGA_ARB_MAX_GPUS=3D16<br># CONFIG_DRM is not set<br><br>#<br># Fr=
ame buffer Devices<br>#<br>CONFIG_FB=3Dy<br>CONFIG_FIRMWARE_EDID=3Dy<br>CON=
FIG_FB_CMDLINE=3Dy<br>CONFIG_FB_DDC=3Dy<br># CONFIG_FB_BOOT_VESA_SUPPORT is=
 not set<br>CONFIG_FB_CFB_FILLRECT=3Dy<br>CONFIG_FB_CFB_COPYAREA=3Dy<br>CON=
FIG_FB_CFB_IMAGEBLIT=3Dy<br># CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set<b=
r>CONFIG_FB_SYS_FILLRECT=3Dm<br>CONFIG_FB_SYS_COPYAREA=3Dm<br>CONFIG_FB_SYS=
_IMAGEBLIT=3Dm<br># CONFIG_FB_FOREIGN_ENDIAN is not set<br>CONFIG_FB_SYS_FO=
PS=3Dm<br># CONFIG_FB_SVGALIB is not set<br>CONFIG_FB_MACMODES=3Dy<br>CONFI=
G_FB_BACKLIGHT=3Dy<br>CONFIG_FB_MODE_HELPERS=3Dy<br>CONFIG_FB_TILEBLITTING=
=3Dy<br><br>#<br># Frame buffer hardware drivers<br>#<br># CONFIG_FB_CIRRUS=
 is not set<br># CONFIG_FB_PM2 is not set<br># CONFIG_FB_CYBER2000 is not s=
et<br>CONFIG_FB_OF=3Dy<br># CONFIG_FB_ASILIANT is not set<br># CONFIG_FB_IM=
STT is not set<br># CONFIG_FB_VGA16 is not set<br># CONFIG_FB_OPENCORES is =
not set<br># CONFIG_FB_S1D13XXX is not set<br># CONFIG_FB_NVIDIA is not set=
<br># CONFIG_FB_RIVA is not set<br># CONFIG_FB_I740 is not set<br>CONFIG_FB=
_MATROX=3Dy<br>CONFIG_FB_MATROX_MILLENIUM=3Dy<br>CONFIG_FB_MATROX_MYSTIQUE=
=3Dy<br>CONFIG_FB_MATROX_G=3Dy<br>CONFIG_FB_MATROX_I2C=3Dm<br>CONFIG_FB_MAT=
ROX_MAVEN=3Dm<br>CONFIG_FB_RADEON=3Dy<br>CONFIG_FB_RADEON_I2C=3Dy<br>CONFIG=
_FB_RADEON_BACKLIGHT=3Dy<br># CONFIG_FB_RADEON_DEBUG is not set<br># CONFIG=
_FB_ATY128 is not set<br># CONFIG_FB_ATY is not set<br># CONFIG_FB_S3 is no=
t set<br># CONFIG_FB_SAVAGE is not set<br># CONFIG_FB_SIS is not set<br># C=
ONFIG_FB_NEOMAGIC is not set<br># CONFIG_FB_KYRO is not set<br># CONFIG_FB_=
3DFX is not set<br># CONFIG_FB_VOODOO1 is not set<br># CONFIG_FB_VT8623 is =
not set<br># CONFIG_FB_TRIDENT is not set<br># CONFIG_FB_ARK is not set<br>=
# CONFIG_FB_PM3 is not set<br># CONFIG_FB_CARMINE is not set<br># CONFIG_FB=
_SMSCUFX is not set<br># CONFIG_FB_UDL is not set<br>CONFIG_FB_IBM_GXT4500=
=3Dy<br>CONFIG_FB_PS3=3Dm<br>CONFIG_FB_PS3_DEFAULT_SIZE_M=3D9<br># CONFIG_F=
B_VIRTUAL is not set<br># CONFIG_FB_METRONOME is not set<br># CONFIG_FB_MB8=
62XX is not set<br># CONFIG_FB_BROADSHEET is not set<br># CONFIG_FB_AUO_K19=
0X is not set<br># CONFIG_FB_SIMPLE is not set<br># CONFIG_FB_SM712 is not =
set<br>CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy<br>CONFIG_LCD_CLASS_DEVICE=3Dy<br>#=
 CONFIG_LCD_PLATFORM is not set<br>CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy<br>CON=
FIG_BACKLIGHT_GENERIC=3Dy<br># CONFIG_BACKLIGHT_PM8941_WLED is not set<br>#=
 CONFIG_BACKLIGHT_ADP8860 is not set<br># CONFIG_BACKLIGHT_ADP8870 is not s=
et<br># CONFIG_BACKLIGHT_LM3639 is not set<br># CONFIG_BACKLIGHT_LV5207LP i=
s not set<br># CONFIG_BACKLIGHT_BD6107 is not set<br># CONFIG_VGASTATE is n=
ot set<br><br>#<br># Console display driver support<br>#<br># CONFIG_VGA_CO=
NSOLE is not set<br>CONFIG_DUMMY_CONSOLE=3Dy<br>CONFIG_DUMMY_CONSOLE_COLUMN=
S=3D80<br>CONFIG_DUMMY_CONSOLE_ROWS=3D25<br>CONFIG_FRAMEBUFFER_CONSOLE=3Dy<=
br># CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set<br># CONFIG_FRAME=
BUFFER_CONSOLE_ROTATION is not set<br>CONFIG_LOGO=3Dy<br>CONFIG_FB_LOGO_EXT=
RA=3Dy<br>CONFIG_LOGO_LINUX_MONO=3Dy<br>CONFIG_LOGO_LINUX_VGA16=3Dy<br>CONF=
IG_LOGO_LINUX_CLUT224=3Dy<br>CONFIG_SOUND=3Dm<br>CONFIG_SOUND_OSS_CORE=3Dy<=
br>CONFIG_SOUND_OSS_CORE_PRECLAIM=3Dy<br>CONFIG_SND=3Dm<br>CONFIG_SND_TIMER=
=3Dm<br>CONFIG_SND_PCM=3Dm<br>CONFIG_SND_SEQUENCER=3Dm<br>CONFIG_SND_SEQ_DU=
MMY=3Dm<br>CONFIG_SND_OSSEMUL=3Dy<br>CONFIG_SND_MIXER_OSS=3Dm<br>CONFIG_SND=
_PCM_OSS=3Dm<br>CONFIG_SND_PCM_OSS_PLUGINS=3Dy<br>CONFIG_SND_PCM_TIMER=3Dy<=
br>CONFIG_SND_SEQUENCER_OSS=3Dy<br># CONFIG_SND_HRTIMER is not set<br># CON=
FIG_SND_DYNAMIC_MINORS is not set<br>CONFIG_SND_SUPPORT_OLD_API=3Dy<br>CONF=
IG_SND_PROC_FS=3Dy<br>CONFIG_SND_VERBOSE_PROCFS=3Dy<br># CONFIG_SND_VERBOSE=
_PRINTK is not set<br># CONFIG_SND_DEBUG is not set<br>CONFIG_SND_VMASTER=
=3Dy<br># CONFIG_SND_RAWMIDI_SEQ is not set<br># CONFIG_SND_OPL3_LIB_SEQ is=
 not set<br># CONFIG_SND_OPL4_LIB_SEQ is not set<br># CONFIG_SND_SBAWE_SEQ =
is not set<br># CONFIG_SND_EMU10K1_SEQ is not set<br>CONFIG_SND_DRIVERS=3Dy=
<br># CONFIG_SND_DUMMY is not set<br># CONFIG_SND_ALOOP is not set<br># CON=
FIG_SND_VIRMIDI is not set<br># CONFIG_SND_MTPAV is not set<br># CONFIG_SND=
_SERIAL_U16550 is not set<br># CONFIG_SND_MPU401 is not set<br>CONFIG_SND_P=
CI=3Dy<br># CONFIG_SND_AD1889 is not set<br># CONFIG_SND_ALS300 is not set<=
br># CONFIG_SND_ALS4000 is not set<br># CONFIG_SND_ALI5451 is not set<br># =
CONFIG_SND_ATIIXP is not set<br># CONFIG_SND_ATIIXP_MODEM is not set<br># C=
ONFIG_SND_AU8810 is not set<br># CONFIG_SND_AU8820 is not set<br># CONFIG_S=
ND_AU8830 is not set<br># CONFIG_SND_AW2 is not set<br># CONFIG_SND_AZT3328=
 is not set<br># CONFIG_SND_BT87X is not set<br># CONFIG_SND_CA0106 is not =
set<br># CONFIG_SND_CMIPCI is not set<br># CONFIG_SND_OXYGEN is not set<br>=
# CONFIG_SND_CS4281 is not set<br># CONFIG_SND_CS46XX is not set<br># CONFI=
G_SND_CTXFI is not set<br># CONFIG_SND_DARLA20 is not set<br># CONFIG_SND_G=
INA20 is not set<br># CONFIG_SND_LAYLA20 is not set<br># CONFIG_SND_DARLA24=
 is not set<br># CONFIG_SND_GINA24 is not set<br># CONFIG_SND_LAYLA24 is no=
t set<br># CONFIG_SND_MONA is not set<br># CONFIG_SND_MIA is not set<br># C=
ONFIG_SND_ECHO3G is not set<br># CONFIG_SND_INDIGO is not set<br># CONFIG_S=
ND_INDIGOIO is not set<br># CONFIG_SND_INDIGODJ is not set<br># CONFIG_SND_=
INDIGOIOX is not set<br># CONFIG_SND_INDIGODJX is not set<br># CONFIG_SND_E=
MU10K1 is not set<br># CONFIG_SND_EMU10K1X is not set<br># CONFIG_SND_ENS13=
70 is not set<br># CONFIG_SND_ENS1371 is not set<br># CONFIG_SND_ES1938 is =
not set<br># CONFIG_SND_ES1968 is not set<br># CONFIG_SND_FM801 is not set<=
br># CONFIG_SND_HDSP is not set<br># CONFIG_SND_HDSPM is not set<br># CONFI=
G_SND_ICE1712 is not set<br># CONFIG_SND_ICE1724 is not set<br># CONFIG_SND=
_INTEL8X0 is not set<br># CONFIG_SND_INTEL8X0M is not set<br># CONFIG_SND_K=
ORG1212 is not set<br># CONFIG_SND_LOLA is not set<br># CONFIG_SND_LX6464ES=
 is not set<br># CONFIG_SND_MAESTRO3 is not set<br># CONFIG_SND_MIXART is n=
ot set<br># CONFIG_SND_NM256 is not set<br># CONFIG_SND_PCXHR is not set<br=
># CONFIG_SND_RIPTIDE is not set<br># CONFIG_SND_RME32 is not set<br># CONF=
IG_SND_RME96 is not set<br># CONFIG_SND_RME9652 is not set<br># CONFIG_SND_=
SE6X is not set<br># CONFIG_SND_SONICVIBES is not set<br># CONFIG_SND_TRIDE=
NT is not set<br># CONFIG_SND_VIA82XX is not set<br># CONFIG_SND_VIA82XX_MO=
DEM is not set<br># CONFIG_SND_VIRTUOSO is not set<br># CONFIG_SND_VX222 is=
 not set<br># CONFIG_SND_YMFPCI is not set<br><br>#<br># HD-Audio<br>#<br>#=
 CONFIG_SND_HDA_INTEL is not set<br>CONFIG_SND_HDA_PREALLOC_SIZE=3D64<br>CO=
NFIG_SND_PPC=3Dy<br>CONFIG_SND_POWERMAC=3Dm<br>CONFIG_SND_POWERMAC_AUTO_DRC=
=3Dy<br>CONFIG_SND_PS3=3Dm<br>CONFIG_SND_PS3_DEFAULT_START_DELAY=3D2000<br>=
CONFIG_SND_AOA=3Dm<br>CONFIG_SND_AOA_FABRIC_LAYOUT=3Dm<br>CONFIG_SND_AOA_ON=
YX=3Dm<br>CONFIG_SND_AOA_TAS=3Dm<br>CONFIG_SND_AOA_TOONIE=3Dm<br>CONFIG_SND=
_AOA_SOUNDBUS=3Dm<br>CONFIG_SND_AOA_SOUNDBUS_I2S=3Dm<br>CONFIG_SND_USB=3Dy<=
br># CONFIG_SND_USB_AUDIO is not set<br># CONFIG_SND_USB_UA101 is not set<b=
r># CONFIG_SND_USB_USX2Y is not set<br># CONFIG_SND_USB_CAIAQ is not set<br=
># CONFIG_SND_USB_6FIRE is not set<br># CONFIG_SND_USB_HIFACE is not set<br=
># CONFIG_SND_BCD2000 is not set<br># CONFIG_SND_USB_POD is not set<br># CO=
NFIG_SND_USB_PODHD is not set<br># CONFIG_SND_USB_TONEPORT is not set<br># =
CONFIG_SND_USB_VARIAX is not set<br>CONFIG_SND_PCMCIA=3Dy<br># CONFIG_SND_V=
XPOCKET is not set<br># CONFIG_SND_PDAUDIOCF is not set<br># CONFIG_SND_SOC=
 is not set<br># CONFIG_SOUND_PRIME is not set<br><br>#<br># HID support<br=
>#<br>CONFIG_HID=3Dy<br># CONFIG_HID_BATTERY_STRENGTH is not set<br># CONFI=
G_HIDRAW is not set<br># CONFIG_UHID is not set<br>CONFIG_HID_GENERIC=3Dy<b=
r><br>#<br># Special HID drivers<br>#<br>CONFIG_HID_A4TECH=3Dy<br># CONFIG_=
HID_ACRUX is not set<br>CONFIG_HID_APPLE=3Dy<br># CONFIG_HID_APPLEIR is not=
 set<br># CONFIG_HID_AUREAL is not set<br>CONFIG_HID_BELKIN=3Dy<br># CONFIG=
_HID_BETOP_FF is not set<br>CONFIG_HID_CHERRY=3Dy<br>CONFIG_HID_CHICONY=3Dy=
<br># CONFIG_HID_CORSAIR is not set<br># CONFIG_HID_PRODIKEYS is not set<br=
>CONFIG_HID_CYPRESS=3Dy<br># CONFIG_HID_DRAGONRISE is not set<br># CONFIG_H=
ID_EMS_FF is not set<br># CONFIG_HID_ELECOM is not set<br># CONFIG_HID_ELO =
is not set<br>CONFIG_HID_EZKEY=3Dy<br># CONFIG_HID_GEMBIRD is not set<br># =
CONFIG_HID_GFRM is not set<br># CONFIG_HID_HOLTEK is not set<br># CONFIG_HI=
D_GT683R is not set<br># CONFIG_HID_KEYTOUCH is not set<br># CONFIG_HID_KYE=
 is not set<br># CONFIG_HID_UCLOGIC is not set<br># CONFIG_HID_WALTOP is no=
t set<br>CONFIG_HID_GYRATION=3Dy<br># CONFIG_HID_ICADE is not set<br># CONF=
IG_HID_TWINHAN is not set<br>CONFIG_HID_KENSINGTON=3Dy<br># CONFIG_HID_LCPO=
WER is not set<br># CONFIG_HID_LENOVO is not set<br>CONFIG_HID_LOGITECH=3Dy=
<br># CONFIG_HID_LOGITECH_HIDPP is not set<br># CONFIG_LOGITECH_FF is not s=
et<br># CONFIG_LOGIRUMBLEPAD2_FF is not set<br># CONFIG_LOGIG940_FF is not =
set<br># CONFIG_LOGIWHEELS_FF is not set<br># CONFIG_HID_MAGICMOUSE is not =
set<br>CONFIG_HID_MICROSOFT=3Dy<br>CONFIG_HID_MONTEREY=3Dy<br># CONFIG_HID_=
MULTITOUCH is not set<br># CONFIG_HID_NTRIG is not set<br># CONFIG_HID_ORTE=
K is not set<br>CONFIG_HID_PANTHERLORD=3Dy<br># CONFIG_PANTHERLORD_FF is no=
t set<br># CONFIG_HID_PENMOUNT is not set<br>CONFIG_HID_PETALYNX=3Dy<br># C=
ONFIG_HID_PICOLCD is not set<br># CONFIG_HID_PLANTRONICS is not set<br># CO=
NFIG_HID_PRIMAX is not set<br># CONFIG_HID_ROCCAT is not set<br># CONFIG_HI=
D_SAITEK is not set<br>CONFIG_HID_SAMSUNG=3Dy<br># CONFIG_HID_SONY is not s=
et<br># CONFIG_HID_SPEEDLINK is not set<br># CONFIG_HID_STEELSERIES is not =
set<br>CONFIG_HID_SUNPLUS=3Dy<br># CONFIG_HID_RMI is not set<br># CONFIG_HI=
D_GREENASIA is not set<br># CONFIG_HID_SMARTJOYPLUS is not set<br># CONFIG_=
HID_TIVO is not set<br># CONFIG_HID_TOPSEED is not set<br># CONFIG_HID_THIN=
GM is not set<br># CONFIG_HID_THRUSTMASTER is not set<br># CONFIG_HID_WACOM=
 is not set<br># CONFIG_HID_WIIMOTE is not set<br># CONFIG_HID_XINMO is not=
 set<br># CONFIG_HID_ZEROPLUS is not set<br># CONFIG_HID_ZYDACRON is not se=
t<br># CONFIG_HID_SENSOR_HUB is not set<br><br>#<br># USB HID support<br>#<=
br>CONFIG_USB_HID=3Dy<br># CONFIG_HID_PID is not set<br>CONFIG_USB_HIDDEV=
=3Dy<br><br>#<br># I2C HID support<br>#<br># CONFIG_I2C_HID is not set<br>C=
ONFIG_USB_OHCI_BIG_ENDIAN_MMIO=3Dy<br>CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy<br>=
CONFIG_USB_EHCI_BIG_ENDIAN_MMIO=3Dy<br>CONFIG_USB_SUPPORT=3Dy<br>CONFIG_USB=
_COMMON=3Dy<br>CONFIG_USB_ARCH_HAS_HCD=3Dy<br>CONFIG_USB=3Dy<br># CONFIG_US=
B_ANNOUNCE_NEW_DEVICES is not set<br><br>#<br># Miscellaneous USB options<b=
r>#<br>CONFIG_USB_DEFAULT_PERSIST=3Dy<br># CONFIG_USB_DYNAMIC_MINORS is not=
 set<br># CONFIG_USB_OTG is not set<br># CONFIG_USB_OTG_WHITELIST is not se=
t<br># CONFIG_USB_ULPI_BUS is not set<br>CONFIG_USB_MON=3Dm<br># CONFIG_USB=
_WUSB_CBAF is not set<br><br>#<br># USB Host Controller Drivers<br>#<br># C=
ONFIG_USB_C67X00_HCD is not set<br># CONFIG_USB_XHCI_HCD is not set<br>CONF=
IG_USB_EHCI_HCD=3Dy<br># CONFIG_USB_EHCI_ROOT_HUB_TT is not set<br>CONFIG_U=
SB_EHCI_TT_NEWSCHED=3Dy<br>CONFIG_USB_EHCI_PCI=3Dy<br># CONFIG_USB_EHCI_HCD=
_PPC_OF is not set<br># CONFIG_USB_EHCI_HCD_PLATFORM is not set<br># CONFIG=
_USB_OXU210HP_HCD is not set<br># CONFIG_USB_ISP116X_HCD is not set<br># CO=
NFIG_USB_ISP1362_HCD is not set<br># CONFIG_USB_FOTG210_HCD is not set<br>C=
ONFIG_USB_OHCI_HCD=3Dy<br># CONFIG_USB_OHCI_HCD_PPC_OF_BE is not set<br># C=
ONFIG_USB_OHCI_HCD_PPC_OF_LE is not set<br># CONFIG_USB_OHCI_HCD_PPC_OF is =
not set<br>CONFIG_USB_OHCI_HCD_PCI=3Dy<br># CONFIG_USB_OHCI_HCD_PLATFORM is=
 not set<br># CONFIG_USB_UHCI_HCD is not set<br># CONFIG_USB_SL811_HCD is n=
ot set<br># CONFIG_USB_R8A66597_HCD is not set<br># CONFIG_USB_HCD_TEST_MOD=
E is not set<br><br>#<br># USB Device Class drivers<br>#<br># CONFIG_USB_AC=
M is not set<br># CONFIG_USB_PRINTER is not set<br># CONFIG_USB_WDM is not =
set<br># CONFIG_USB_TMC is not set<br><br>#<br># NOTE: USB_STORAGE depends =
on SCSI but BLK_DEV_SD may<br>#<br><br>#<br># also be needed; see USB_STORA=
GE Help for more info<br>#<br>CONFIG_USB_STORAGE=3Dm<br># CONFIG_USB_STORAG=
E_DEBUG is not set<br># CONFIG_USB_STORAGE_REALTEK is not set<br># CONFIG_U=
SB_STORAGE_DATAFAB is not set<br># CONFIG_USB_STORAGE_FREECOM is not set<br=
># CONFIG_USB_STORAGE_ISD200 is not set<br># CONFIG_USB_STORAGE_USBAT is no=
t set<br># CONFIG_USB_STORAGE_SDDR09 is not set<br># CONFIG_USB_STORAGE_SDD=
R55 is not set<br># CONFIG_USB_STORAGE_JUMPSHOT is not set<br># CONFIG_USB_=
STORAGE_ALAUDA is not set<br># CONFIG_USB_STORAGE_ONETOUCH is not set<br># =
CONFIG_USB_STORAGE_KARMA is not set<br># CONFIG_USB_STORAGE_CYPRESS_ATACB i=
s not set<br># CONFIG_USB_STORAGE_ENE_UB6250 is not set<br># CONFIG_USB_UAS=
 is not set<br><br>#<br># USB Imaging devices<br>#<br># CONFIG_USB_MDC800 i=
s not set<br># CONFIG_USB_MICROTEK is not set<br># CONFIG_USBIP_CORE is not=
 set<br># CONFIG_USB_MUSB_HDRC is not set<br># CONFIG_USB_DWC3 is not set<b=
r># CONFIG_USB_DWC2 is not set<br># CONFIG_USB_CHIPIDEA is not set<br># CON=
FIG_USB_ISP1760 is not set<br><br>#<br># USB port drivers<br>#<br># CONFIG_=
USB_SERIAL is not set<br><br>#<br># USB Miscellaneous drivers<br>#<br># CON=
FIG_USB_EMI62 is not set<br># CONFIG_USB_EMI26 is not set<br># CONFIG_USB_A=
DUTUX is not set<br># CONFIG_USB_SEVSEG is not set<br># CONFIG_USB_RIO500 i=
s not set<br># CONFIG_USB_LEGOTOWER is not set<br># CONFIG_USB_LCD is not s=
et<br># CONFIG_USB_LED is not set<br># CONFIG_USB_CYPRESS_CY7C63 is not set=
<br># CONFIG_USB_CYTHERM is not set<br># CONFIG_USB_IDMOUSE is not set<br>#=
 CONFIG_USB_FTDI_ELAN is not set<br>CONFIG_USB_APPLEDISPLAY=3Dm<br># CONFIG=
_USB_SISUSBVGA is not set<br># CONFIG_USB_LD is not set<br># CONFIG_USB_TRA=
NCEVIBRATOR is not set<br># CONFIG_USB_IOWARRIOR is not set<br># CONFIG_USB=
_TEST is not set<br># CONFIG_USB_EHSET_TEST_FIXTURE is not set<br># CONFIG_=
USB_ISIGHTFW is not set<br># CONFIG_USB_YUREX is not set<br># CONFIG_USB_EZ=
USB_FX2 is not set<br># CONFIG_USB_HSIC_USB3503 is not set<br># CONFIG_USB_=
LINK_LAYER_TEST is not set<br># CONFIG_USB_CHAOSKEY is not set<br><br>#<br>=
# USB Physical Layer drivers<br>#<br># CONFIG_USB_PHY is not set<br># CONFI=
G_NOP_USB_XCEIV is not set<br># CONFIG_USB_ISP1301 is not set<br># CONFIG_U=
SB_GADGET is not set<br># CONFIG_UWB is not set<br># CONFIG_MMC is not set<=
br># CONFIG_MEMSTICK is not set<br>CONFIG_NEW_LEDS=3Dy<br>CONFIG_LEDS_CLASS=
=3Dm<br># CONFIG_LEDS_CLASS_FLASH is not set<br><br>#<br># LED drivers<br>#=
<br># CONFIG_LEDS_BCM6328 is not set<br># CONFIG_LEDS_BCM6358 is not set<br=
># CONFIG_LEDS_LM3530 is not set<br># CONFIG_LEDS_LM3642 is not set<br># CO=
NFIG_LEDS_PCA9532 is not set<br># CONFIG_LEDS_LP3944 is not set<br># CONFIG=
_LEDS_LP5521 is not set<br># CONFIG_LEDS_LP5523 is not set<br># CONFIG_LEDS=
_LP5562 is not set<br># CONFIG_LEDS_LP8501 is not set<br># CONFIG_LEDS_LP88=
60 is not set<br># CONFIG_LEDS_PCA955X is not set<br># CONFIG_LEDS_PCA963X =
is not set<br># CONFIG_LEDS_BD2802 is not set<br># CONFIG_LEDS_TCA6507 is n=
ot set<br># CONFIG_LEDS_TLC591XX is not set<br># CONFIG_LEDS_LM355x is not =
set<br><br>#<br># LED driver for blink(1) USB RGB LED is under Special HID =
drivers (HID_THINGM)<br>#<br># CONFIG_LEDS_BLINKM is not set<br>CONFIG_LEDS=
_POWERNV=3Dm<br><br>#<br># LED Triggers<br>#<br># CONFIG_LEDS_TRIGGERS is n=
ot set<br># CONFIG_ACCESSIBILITY is not set<br>CONFIG_INFINIBAND=3Dm<br>CON=
FIG_INFINIBAND_USER_MAD=3Dm<br>CONFIG_INFINIBAND_USER_ACCESS=3Dm<br>CONFIG_=
INFINIBAND_USER_MEM=3Dy<br>CONFIG_INFINIBAND_ON_DEMAND_PAGING=3Dy<br>CONFIG=
_INFINIBAND_ADDR_TRANS=3Dy<br>CONFIG_INFINIBAND_MTHCA=3Dm<br>CONFIG_INFINIB=
AND_MTHCA_DEBUG=3Dy<br># CONFIG_INFINIBAND_QIB is not set<br>CONFIG_INFINIB=
AND_CXGB3=3Dm<br># CONFIG_INFINIBAND_CXGB3_DEBUG is not set<br>CONFIG_INFIN=
IBAND_CXGB4=3Dm<br>CONFIG_MLX4_INFINIBAND=3Dm<br># CONFIG_INFINIBAND_NES is=
 not set<br># CONFIG_INFINIBAND_OCRDMA is not set<br>CONFIG_INFINIBAND_IPOI=
B=3Dm<br>CONFIG_INFINIBAND_IPOIB_CM=3Dy<br>CONFIG_INFINIBAND_IPOIB_DEBUG=3D=
y<br># CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set<br>CONFIG_INFINIBAND_S=
RP=3Dm<br>CONFIG_INFINIBAND_ISER=3Dm<br>CONFIG_EDAC_ATOMIC_SCRUB=3Dy<br>CON=
FIG_EDAC_SUPPORT=3Dy<br>CONFIG_EDAC=3Dy<br>CONFIG_EDAC_LEGACY_SYSFS=3Dy<br>=
# CONFIG_EDAC_DEBUG is not set<br>CONFIG_EDAC_MM_EDAC=3Dy<br>CONFIG_EDAC_PA=
SEMI=3Dy<br># CONFIG_EDAC_CELL is not set<br># CONFIG_EDAC_AMD8131 is not s=
et<br># CONFIG_EDAC_AMD8111 is not set<br># CONFIG_EDAC_CPC925 is not set<b=
r>CONFIG_RTC_LIB=3Dy<br>CONFIG_RTC_CLASS=3Dy<br>CONFIG_RTC_HCTOSYS=3Dy<br>C=
ONFIG_RTC_HCTOSYS_DEVICE=3D&quot;rtc0&quot;<br>CONFIG_RTC_SYSTOHC=3Dy<br>CO=
NFIG_RTC_SYSTOHC_DEVICE=3D&quot;rtc0&quot;<br># CONFIG_RTC_DEBUG is not set=
<br><br>#<br># RTC interfaces<br>#<br>CONFIG_RTC_INTF_SYSFS=3Dy<br>CONFIG_R=
TC_INTF_PROC=3Dy<br>CONFIG_RTC_INTF_DEV=3Dy<br># CONFIG_RTC_INTF_DEV_UIE_EM=
UL is not set<br># CONFIG_RTC_DRV_TEST is not set<br><br>#<br># I2C RTC dri=
vers<br>#<br># CONFIG_RTC_DRV_ABB5ZES3 is not set<br># CONFIG_RTC_DRV_ABX80=
X is not set<br>CONFIG_RTC_DRV_DS1307=3Dy<br># CONFIG_RTC_DRV_DS1374 is not=
 set<br># CONFIG_RTC_DRV_DS1672 is not set<br># CONFIG_RTC_DRV_DS3232 is no=
t set<br># CONFIG_RTC_DRV_HYM8563 is not set<br># CONFIG_RTC_DRV_MAX6900 is=
 not set<br># CONFIG_RTC_DRV_RS5C372 is not set<br># CONFIG_RTC_DRV_ISL1208=
 is not set<br># CONFIG_RTC_DRV_ISL12022 is not set<br># CONFIG_RTC_DRV_ISL=
12057 is not set<br># CONFIG_RTC_DRV_X1205 is not set<br># CONFIG_RTC_DRV_P=
CF2127 is not set<br># CONFIG_RTC_DRV_PCF8523 is not set<br># CONFIG_RTC_DR=
V_PCF8563 is not set<br># CONFIG_RTC_DRV_PCF85063 is not set<br># CONFIG_RT=
C_DRV_PCF8583 is not set<br># CONFIG_RTC_DRV_M41T80 is not set<br># CONFIG_=
RTC_DRV_BQ32K is not set<br># CONFIG_RTC_DRV_S35390A is not set<br># CONFIG=
_RTC_DRV_FM3130 is not set<br># CONFIG_RTC_DRV_RX8581 is not set<br># CONFI=
G_RTC_DRV_RX8025 is not set<br># CONFIG_RTC_DRV_EM3027 is not set<br># CONF=
IG_RTC_DRV_RV3029C2 is not set<br># CONFIG_RTC_DRV_RV8803 is not set<br><br=
>#<br># SPI RTC drivers<br>#<br><br>#<br># Platform RTC drivers<br>#<br># C=
ONFIG_RTC_DRV_CMOS is not set<br># CONFIG_RTC_DRV_DS1286 is not set<br># CO=
NFIG_RTC_DRV_DS1511 is not set<br># CONFIG_RTC_DRV_DS1553 is not set<br># C=
ONFIG_RTC_DRV_DS1685_FAMILY is not set<br># CONFIG_RTC_DRV_DS1742 is not se=
t<br># CONFIG_RTC_DRV_DS2404 is not set<br># CONFIG_RTC_DRV_STK17TA8 is not=
 set<br># CONFIG_RTC_DRV_M48T86 is not set<br># CONFIG_RTC_DRV_M48T35 is no=
t set<br># CONFIG_RTC_DRV_M48T59 is not set<br># CONFIG_RTC_DRV_MSM6242 is =
not set<br># CONFIG_RTC_DRV_BQ4802 is not set<br># CONFIG_RTC_DRV_RP5C01 is=
 not set<br># CONFIG_RTC_DRV_V3020 is not set<br>CONFIG_RTC_DRV_OPAL=3Dy<br=
># CONFIG_RTC_DRV_ZYNQMP is not set<br><br>#<br># on-CPU RTC drivers<br>#<b=
r># CONFIG_RTC_DRV_GENERIC is not set<br># CONFIG_RTC_DRV_PS3 is not set<br=
># CONFIG_RTC_DRV_SNVS is not set<br><br>#<br># HID Sensor RTC drivers<br>#=
<br># CONFIG_RTC_DRV_HID_SENSOR_TIME is not set<br># CONFIG_DMADEVICES is n=
ot set<br># CONFIG_AUXDISPLAY is not set<br>CONFIG_UIO=3Dm<br># CONFIG_UIO_=
CIF is not set<br># CONFIG_UIO_PDRV_GENIRQ is not set<br># CONFIG_UIO_DMEM_=
GENIRQ is not set<br># CONFIG_UIO_AEC is not set<br># CONFIG_UIO_SERCOS3 is=
 not set<br># CONFIG_UIO_PCI_GENERIC is not set<br># CONFIG_UIO_NETX is not=
 set<br># CONFIG_UIO_PRUSS is not set<br># CONFIG_UIO_MF624 is not set<br>#=
 CONFIG_VIRT_DRIVERS is not set<br>CONFIG_VIRTIO=3Dm<br><br>#<br># Virtio d=
rivers<br>#<br>CONFIG_VIRTIO_PCI=3Dm<br>CONFIG_VIRTIO_PCI_LEGACY=3Dy<br>CON=
FIG_VIRTIO_BALLOON=3Dm<br># CONFIG_VIRTIO_INPUT is not set<br># CONFIG_VIRT=
IO_MMIO is not set<br><br>#<br># Microsoft Hyper-V guest support<br>#<br># =
CONFIG_STAGING is not set<br><br>#<br># Hardware Spinlock drivers<br>#<br><=
br>#<br># Clock Source drivers<br>#<br>CONFIG_I8253_LOCK=3Dy<br>CONFIG_CLKB=
LD_I8253=3Dy<br># CONFIG_ATMEL_PIT is not set<br># CONFIG_SH_TIMER_CMT is n=
ot set<br># CONFIG_SH_TIMER_MTU2 is not set<br># CONFIG_SH_TIMER_TMU is not=
 set<br># CONFIG_EM_TIMER_STI is not set<br># CONFIG_MAILBOX is not set<br>=
CONFIG_IOMMU_SUPPORT=3Dy<br><br>#<br># Generic IOMMU Pagetable Support<br>#=
<br># CONFIG_SPAPR_TCE_IOMMU is not set<br><br>#<br># Remoteproc drivers<br=
>#<br># CONFIG_STE_MODEM_RPROC is not set<br><br>#<br># Rpmsg drivers<br>#<=
br><br>#<br># SOC (System On Chip) specific Drivers<br>#<br># CONFIG_SUNXI_=
SRAM is not set<br># CONFIG_SOC_TI is not set<br># CONFIG_PM_DEVFREQ is not=
 set<br># CONFIG_EXTCON is not set<br># CONFIG_MEMORY is not set<br># CONFI=
G_IIO is not set<br># CONFIG_NTB is not set<br># CONFIG_VME_BUS is not set<=
br># CONFIG_PWM is not set<br>CONFIG_IRQCHIP=3Dy<br># CONFIG_IPACK_BUS is n=
ot set<br># CONFIG_RESET_CONTROLLER is not set<br># CONFIG_FMC is not set<b=
r><br>#<br># PHY Subsystem<br>#<br>CONFIG_GENERIC_PHY=3Dy<br># CONFIG_PHY_P=
XA_28NM_HSIC is not set<br># CONFIG_PHY_PXA_28NM_USB2 is not set<br># CONFI=
G_BCM_KONA_USB2_PHY is not set<br># CONFIG_POWERCAP is not set<br># CONFIG_=
MCB is not set<br><br>#<br># Performance monitor support<br>#<br>CONFIG_RAS=
=3Dy<br># CONFIG_THUNDERBOLT is not set<br><br>#<br># Android<br>#<br># CON=
FIG_ANDROID is not set<br># CONFIG_LIBNVDIMM is not set<br># CONFIG_NVMEM i=
s not set<br># CONFIG_STM is not set<br># CONFIG_STM_DUMMY is not set<br># =
CONFIG_STM_SOURCE_CONSOLE is not set<br># CONFIG_INTEL_TH is not set<br><br=
>#<br># FPGA Configuration Support<br>#<br># CONFIG_FPGA is not set<br><br>=
#<br># File systems<br>#<br>CONFIG_EXT2_FS=3Dy<br>CONFIG_EXT2_FS_XATTR=3Dy<=
br>CONFIG_EXT2_FS_POSIX_ACL=3Dy<br>CONFIG_EXT2_FS_SECURITY=3Dy<br>CONFIG_EX=
T3_FS=3Dy<br>CONFIG_EXT3_FS_POSIX_ACL=3Dy<br>CONFIG_EXT3_FS_SECURITY=3Dy<br=
>CONFIG_EXT4_FS=3Dy<br>CONFIG_EXT4_FS_POSIX_ACL=3Dy<br>CONFIG_EXT4_FS_SECUR=
ITY=3Dy<br># CONFIG_EXT4_ENCRYPTION is not set<br># CONFIG_EXT4_DEBUG is no=
t set<br>CONFIG_JBD2=3Dy<br># CONFIG_JBD2_DEBUG is not set<br>CONFIG_FS_MBC=
ACHE=3Dy<br>CONFIG_REISERFS_FS=3Dy<br># CONFIG_REISERFS_CHECK is not set<br=
># CONFIG_REISERFS_PROC_INFO is not set<br>CONFIG_REISERFS_FS_XATTR=3Dy<br>=
CONFIG_REISERFS_FS_POSIX_ACL=3Dy<br>CONFIG_REISERFS_FS_SECURITY=3Dy<br>CONF=
IG_JFS_FS=3Dm<br>CONFIG_JFS_POSIX_ACL=3Dy<br>CONFIG_JFS_SECURITY=3Dy<br># C=
ONFIG_JFS_DEBUG is not set<br># CONFIG_JFS_STATISTICS is not set<br>CONFIG_=
XFS_FS=3Dm<br># CONFIG_XFS_QUOTA is not set<br>CONFIG_XFS_POSIX_ACL=3Dy<br>=
# CONFIG_XFS_RT is not set<br># CONFIG_XFS_WARN is not set<br># CONFIG_XFS_=
DEBUG is not set<br># CONFIG_GFS2_FS is not set<br>CONFIG_BTRFS_FS=3Dm<br>C=
ONFIG_BTRFS_FS_POSIX_ACL=3Dy<br># CONFIG_BTRFS_FS_CHECK_INTEGRITY is not se=
t<br># CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set<br># CONFIG_BTRFS_DEBUG =
is not set<br># CONFIG_BTRFS_ASSERT is not set<br>CONFIG_NILFS2_FS=3Dm<br>#=
 CONFIG_F2FS_FS is not set<br># CONFIG_FS_DAX is not set<br>CONFIG_FS_POSIX=
_ACL=3Dy<br>CONFIG_EXPORTFS=3Dy<br>CONFIG_FILE_LOCKING=3Dy<br>CONFIG_FSNOTI=
FY=3Dy<br>CONFIG_DNOTIFY=3Dy<br>CONFIG_INOTIFY_USER=3Dy<br># CONFIG_FANOTIF=
Y is not set<br># CONFIG_QUOTA is not set<br># CONFIG_QUOTACTL is not set<b=
r>CONFIG_AUTOFS4_FS=3Dm<br>CONFIG_FUSE_FS=3Dm<br># CONFIG_CUSE is not set<b=
r>CONFIG_OVERLAY_FS=3Dm<br><br>#<br># Caches<br>#<br># CONFIG_FSCACHE is no=
t set<br><br>#<br># CD-ROM/DVD Filesystems<br>#<br>CONFIG_ISO9660_FS=3Dy<br=
># CONFIG_JOLIET is not set<br># CONFIG_ZISOFS is not set<br>CONFIG_UDF_FS=
=3Dm<br>CONFIG_UDF_NLS=3Dy<br><br>#<br># DOS/FAT/NT Filesystems<br>#<br>CON=
FIG_FAT_FS=3Dy<br>CONFIG_MSDOS_FS=3Dy<br>CONFIG_VFAT_FS=3Dy<br>CONFIG_FAT_D=
EFAULT_CODEPAGE=3D437<br>CONFIG_FAT_DEFAULT_IOCHARSET=3D&quot;iso8859-1&quo=
t;<br># CONFIG_NTFS_FS is not set<br><br>#<br># Pseudo filesystems<br>#<br>=
CONFIG_PROC_FS=3Dy<br>CONFIG_PROC_KCORE=3Dy<br>CONFIG_PROC_VMCORE=3Dy<br>CO=
NFIG_PROC_SYSCTL=3Dy<br>CONFIG_PROC_PAGE_MONITOR=3Dy<br># CONFIG_PROC_CHILD=
REN is not set<br>CONFIG_KERNFS=3Dy<br>CONFIG_SYSFS=3Dy<br>CONFIG_TMPFS=3Dy=
<br>CONFIG_TMPFS_POSIX_ACL=3Dy<br>CONFIG_TMPFS_XATTR=3Dy<br>CONFIG_HUGETLBF=
S=3Dy<br>CONFIG_HUGETLB_PAGE=3Dy<br># CONFIG_CONFIGFS_FS is not set<br>CONF=
IG_MISC_FILESYSTEMS=3Dy<br># CONFIG_ADFS_FS is not set<br># CONFIG_AFFS_FS =
is not set<br># CONFIG_ECRYPT_FS is not set<br>CONFIG_HFS_FS=3Dm<br>CONFIG_=
HFSPLUS_FS=3Dm<br># CONFIG_HFSPLUS_FS_POSIX_ACL is not set<br># CONFIG_BEFS=
_FS is not set<br># CONFIG_BFS_FS is not set<br># CONFIG_EFS_FS is not set<=
br># CONFIG_LOGFS is not set<br>CONFIG_CRAMFS=3Dm<br>CONFIG_SQUASHFS=3Dm<br=
>CONFIG_SQUASHFS_FILE_CACHE=3Dy<br># CONFIG_SQUASHFS_FILE_DIRECT is not set=
<br>CONFIG_SQUASHFS_DECOMP_SINGLE=3Dy<br># CONFIG_SQUASHFS_DECOMP_MULTI is =
not set<br># CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set<br>CONFIG_SQUAS=
HFS_XATTR=3Dy<br>CONFIG_SQUASHFS_ZLIB=3Dy<br># CONFIG_SQUASHFS_LZ4 is not s=
et<br>CONFIG_SQUASHFS_LZO=3Dy<br>CONFIG_SQUASHFS_XZ=3Dy<br># CONFIG_SQUASHF=
S_4K_DEVBLK_SIZE is not set<br># CONFIG_SQUASHFS_EMBEDDED is not set<br>CON=
FIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3D3<br># CONFIG_VXFS_FS is not set<br># CO=
NFIG_MINIX_FS is not set<br># CONFIG_OMFS_FS is not set<br># CONFIG_HPFS_FS=
 is not set<br># CONFIG_QNX4FS_FS is not set<br># CONFIG_QNX6FS_FS is not s=
et<br># CONFIG_ROMFS_FS is not set<br># CONFIG_PSTORE is not set<br># CONFI=
G_SYSV_FS is not set<br># CONFIG_UFS_FS is not set<br>CONFIG_NETWORK_FILESY=
STEMS=3Dy<br>CONFIG_NFS_FS=3Dy<br>CONFIG_NFS_V2=3Dy<br>CONFIG_NFS_V3=3Dy<br=
>CONFIG_NFS_V3_ACL=3Dy<br>CONFIG_NFS_V4=3Dy<br># CONFIG_NFS_SWAP is not set=
<br># CONFIG_NFS_V4_1 is not set<br>CONFIG_ROOT_NFS=3Dy<br># CONFIG_NFS_USE=
_LEGACY_DNS is not set<br>CONFIG_NFS_USE_KERNEL_DNS=3Dy<br>CONFIG_NFSD=3Dm<=
br>CONFIG_NFSD_V2_ACL=3Dy<br>CONFIG_NFSD_V3=3Dy<br>CONFIG_NFSD_V3_ACL=3Dy<b=
r>CONFIG_NFSD_V4=3Dy<br># CONFIG_NFSD_PNFS is not set<br># CONFIG_NFSD_FAUL=
T_INJECTION is not set<br>CONFIG_GRACE_PERIOD=3Dy<br>CONFIG_LOCKD=3Dy<br>CO=
NFIG_LOCKD_V4=3Dy<br>CONFIG_NFS_ACL_SUPPORT=3Dy<br>CONFIG_NFS_COMMON=3Dy<br=
>CONFIG_SUNRPC=3Dy<br>CONFIG_SUNRPC_GSS=3Dy<br># CONFIG_SUNRPC_DEBUG is not=
 set<br>CONFIG_SUNRPC_XPRT_RDMA=3Dm<br># CONFIG_CEPH_FS is not set<br>CONFI=
G_CIFS=3Dm<br># CONFIG_CIFS_STATS is not set<br># CONFIG_CIFS_WEAK_PW_HASH =
is not set<br># CONFIG_CIFS_UPCALL is not set<br>CONFIG_CIFS_XATTR=3Dy<br>C=
ONFIG_CIFS_POSIX=3Dy<br># CONFIG_CIFS_ACL is not set<br>CONFIG_CIFS_DEBUG=
=3Dy<br># CONFIG_CIFS_DEBUG2 is not set<br># CONFIG_CIFS_DFS_UPCALL is not =
set<br># CONFIG_CIFS_SMB2 is not set<br># CONFIG_NCP_FS is not set<br># CON=
FIG_CODA_FS is not set<br># CONFIG_AFS_FS is not set<br>CONFIG_NLS=3Dy<br>C=
ONFIG_NLS_DEFAULT=3D&quot;utf8&quot;<br>CONFIG_NLS_CODEPAGE_437=3Dy<br># CO=
NFIG_NLS_CODEPAGE_737 is not set<br># CONFIG_NLS_CODEPAGE_775 is not set<br=
># CONFIG_NLS_CODEPAGE_850 is not set<br># CONFIG_NLS_CODEPAGE_852 is not s=
et<br># CONFIG_NLS_CODEPAGE_855 is not set<br># CONFIG_NLS_CODEPAGE_857 is =
not set<br># CONFIG_NLS_CODEPAGE_860 is not set<br># CONFIG_NLS_CODEPAGE_86=
1 is not set<br># CONFIG_NLS_CODEPAGE_862 is not set<br># CONFIG_NLS_CODEPA=
GE_863 is not set<br># CONFIG_NLS_CODEPAGE_864 is not set<br># CONFIG_NLS_C=
ODEPAGE_865 is not set<br># CONFIG_NLS_CODEPAGE_866 is not set<br># CONFIG_=
NLS_CODEPAGE_869 is not set<br># CONFIG_NLS_CODEPAGE_936 is not set<br># CO=
NFIG_NLS_CODEPAGE_950 is not set<br># CONFIG_NLS_CODEPAGE_932 is not set<br=
># CONFIG_NLS_CODEPAGE_949 is not set<br># CONFIG_NLS_CODEPAGE_874 is not s=
et<br># CONFIG_NLS_ISO8859_8 is not set<br># CONFIG_NLS_CODEPAGE_1250 is no=
t set<br># CONFIG_NLS_CODEPAGE_1251 is not set<br>CONFIG_NLS_ASCII=3Dy<br>C=
ONFIG_NLS_ISO8859_1=3Dy<br># CONFIG_NLS_ISO8859_2 is not set<br># CONFIG_NL=
S_ISO8859_3 is not set<br># CONFIG_NLS_ISO8859_4 is not set<br># CONFIG_NLS=
_ISO8859_5 is not set<br># CONFIG_NLS_ISO8859_6 is not set<br># CONFIG_NLS_=
ISO8859_7 is not set<br># CONFIG_NLS_ISO8859_9 is not set<br># CONFIG_NLS_I=
SO8859_13 is not set<br># CONFIG_NLS_ISO8859_14 is not set<br># CONFIG_NLS_=
ISO8859_15 is not set<br># CONFIG_NLS_KOI8_R is not set<br># CONFIG_NLS_KOI=
8_U is not set<br># CONFIG_NLS_MAC_ROMAN is not set<br># CONFIG_NLS_MAC_CEL=
TIC is not set<br># CONFIG_NLS_MAC_CENTEURO is not set<br># CONFIG_NLS_MAC_=
CROATIAN is not set<br># CONFIG_NLS_MAC_CYRILLIC is not set<br># CONFIG_NLS=
_MAC_GAELIC is not set<br># CONFIG_NLS_MAC_GREEK is not set<br># CONFIG_NLS=
_MAC_ICELAND is not set<br># CONFIG_NLS_MAC_INUIT is not set<br># CONFIG_NL=
S_MAC_ROMANIAN is not set<br># CONFIG_NLS_MAC_TURKISH is not set<br>CONFIG_=
NLS_UTF8=3Dy<br>CONFIG_BINARY_PRINTF=3Dy<br><br>#<br># Library routines<br>=
#<br>CONFIG_RAID6_PQ=3Dm<br>CONFIG_BITREVERSE=3Dy<br># CONFIG_HAVE_ARCH_BIT=
REVERSE is not set<br>CONFIG_RATIONAL=3Dy<br>CONFIG_GENERIC_STRNCPY_FROM_US=
ER=3Dy<br>CONFIG_GENERIC_STRNLEN_USER=3Dy<br>CONFIG_GENERIC_NET_UTILS=3Dy<b=
r>CONFIG_GENERIC_PCI_IOMAP=3Dy<br>CONFIG_GENERIC_IOMAP=3Dy<br>CONFIG_GENERI=
C_IO=3Dy<br>CONFIG_ARCH_USE_CMPXCHG_LOCKREF=3Dy<br>CONFIG_CRC_CCITT=3Dm<br>=
CONFIG_CRC16=3Dy<br>CONFIG_CRC_T10DIF=3Dm<br>CONFIG_CRC_ITU_T=3Dm<br>CONFIG=
_CRC32=3Dy<br># CONFIG_CRC32_SELFTEST is not set<br>CONFIG_CRC32_SLICEBY8=
=3Dy<br># CONFIG_CRC32_SLICEBY4 is not set<br># CONFIG_CRC32_SARWATE is not=
 set<br># CONFIG_CRC32_BIT is not set<br># CONFIG_CRC7 is not set<br>CONFIG=
_LIBCRC32C=3Dm<br># CONFIG_CRC8 is not set<br># CONFIG_AUDIT_ARCH_COMPAT_GE=
NERIC is not set<br># CONFIG_RANDOM32_SELFTEST is not set<br>CONFIG_842_DEC=
OMPRESS=3Dy<br>CONFIG_ZLIB_INFLATE=3Dy<br>CONFIG_ZLIB_DEFLATE=3Dy<br>CONFIG=
_LZO_COMPRESS=3Dm<br>CONFIG_LZO_DECOMPRESS=3Dy<br>CONFIG_LZ4_DECOMPRESS=3Dy=
<br>CONFIG_XZ_DEC=3Dy<br>CONFIG_XZ_DEC_X86=3Dy<br>CONFIG_XZ_DEC_POWERPC=3Dy=
<br>CONFIG_XZ_DEC_IA64=3Dy<br>CONFIG_XZ_DEC_ARM=3Dy<br>CONFIG_XZ_DEC_ARMTHU=
MB=3Dy<br>CONFIG_XZ_DEC_SPARC=3Dy<br>CONFIG_XZ_DEC_BCJ=3Dy<br># CONFIG_XZ_D=
EC_TEST is not set<br>CONFIG_DECOMPRESS_GZIP=3Dy<br>CONFIG_DECOMPRESS_BZIP2=
=3Dy<br>CONFIG_DECOMPRESS_LZMA=3Dy<br>CONFIG_DECOMPRESS_XZ=3Dy<br>CONFIG_DE=
COMPRESS_LZO=3Dy<br>CONFIG_DECOMPRESS_LZ4=3Dy<br>CONFIG_GENERIC_ALLOCATOR=
=3Dy<br>CONFIG_ASSOCIATIVE_ARRAY=3Dy<br>CONFIG_HAS_IOMEM=3Dy<br>CONFIG_HAS_=
IOPORT_MAP=3Dy<br>CONFIG_HAS_DMA=3Dy<br>CONFIG_CPU_RMAP=3Dy<br>CONFIG_DQL=
=3Dy<br>CONFIG_GLOB=3Dy<br># CONFIG_GLOB_SELFTEST is not set<br>CONFIG_NLAT=
TR=3Dy<br>CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=3Dy<br># CONFIG_CORDIC i=
s not set<br># CONFIG_DDR is not set<br>CONFIG_LIBFDT=3Dy<br>CONFIG_OID_REG=
ISTRY=3Dy<br>CONFIG_FONT_SUPPORT=3Dy<br># CONFIG_FONTS is not set<br>CONFIG=
_FONT_8x8=3Dy<br>CONFIG_FONT_8x16=3Dy<br># CONFIG_SG_SPLIT is not set<br>CO=
NFIG_ARCH_HAS_SG_CHAIN=3Dy<br><br>#<br># Kernel hacking<br>#<br><br>#<br># =
printk and dmesg options<br>#<br># CONFIG_PRINTK_TIME is not set<br>CONFIG_=
MESSAGE_LOGLEVEL_DEFAULT=3D4<br># CONFIG_DYNAMIC_DEBUG is not set<br><br>#<=
br># Compile-time checks and compiler options<br>#<br># CONFIG_DEBUG_INFO i=
s not set<br>CONFIG_ENABLE_WARN_DEPRECATED=3Dy<br>CONFIG_ENABLE_MUST_CHECK=
=3Dy<br>CONFIG_FRAME_WARN=3D2048<br># CONFIG_STRIP_ASM_SYMS is not set<br>#=
 CONFIG_READABLE_ASM is not set<br># CONFIG_UNUSED_SYMBOLS is not set<br># =
CONFIG_PAGE_OWNER is not set<br>CONFIG_DEBUG_FS=3Dy<br># CONFIG_HEADERS_CHE=
CK is not set<br># CONFIG_DEBUG_SECTION_MISMATCH is not set<br>CONFIG_SECTI=
ON_MISMATCH_WARN_ONLY=3Dy<br># CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set<b=
r>CONFIG_MAGIC_SYSRQ=3Dy<br>CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=3D0x1<br>CONF=
IG_DEBUG_KERNEL=3Dy<br><br>#<br># Memory Debugging<br>#<br># CONFIG_PAGE_EX=
TENSION is not set<br># CONFIG_DEBUG_PAGEALLOC is not set<br># CONFIG_DEBUG=
_OBJECTS is not set<br># CONFIG_SLUB_DEBUG_ON is not set<br># CONFIG_SLUB_S=
TATS is not set<br>CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy<br># CONFIG_DEBUG_KMEMLEA=
K is not set<br>CONFIG_DEBUG_STACK_USAGE=3Dy<br># CONFIG_DEBUG_VM is not se=
t<br>CONFIG_DEBUG_MEMORY_INIT=3Dy<br># CONFIG_DEBUG_PER_CPU_MAPS is not set=
<br>CONFIG_HAVE_DEBUG_STACKOVERFLOW=3Dy<br>CONFIG_DEBUG_STACKOVERFLOW=3Dy<b=
r># CONFIG_DEBUG_SHIRQ is not set<br><br>#<br># Debug Lockups and Hangs<br>=
#<br>CONFIG_LOCKUP_DETECTOR=3Dy<br>CONFIG_HARDLOCKUP_DETECTOR=3Dy<br># CONF=
IG_BOOTPARAM_HARDLOCKUP_PANIC is not set<br>CONFIG_BOOTPARAM_HARDLOCKUP_PAN=
IC_VALUE=3D0<br># CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set<br>CONFIG_BO=
OTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0<br>CONFIG_DETECT_HUNG_TASK=3Dy<br>CONFIG=
_DEFAULT_HUNG_TASK_TIMEOUT=3D120<br># CONFIG_BOOTPARAM_HUNG_TASK_PANIC is n=
ot set<br>CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0<br># CONFIG_PANIC_ON_O=
OPS is not set<br>CONFIG_PANIC_ON_OOPS_VALUE=3D0<br>CONFIG_SCHED_DEBUG=3Dy<=
br>CONFIG_SCHED_INFO=3Dy<br>CONFIG_SCHEDSTATS=3Dy<br># CONFIG_SCHED_STACK_E=
ND_CHECK is not set<br># CONFIG_DEBUG_TIMEKEEPING is not set<br># CONFIG_TI=
MER_STATS is not set<br><br>#<br># Lock Debugging (spinlocks, mutexes, etc.=
..)<br>#<br># CONFIG_DEBUG_RT_MUTEXES is not set<br># CONFIG_DEBUG_SPINLOCK=
 is not set<br>CONFIG_DEBUG_MUTEXES=3Dy<br># CONFIG_DEBUG_WW_MUTEX_SLOWPATH=
 is not set<br># CONFIG_DEBUG_LOCK_ALLOC is not set<br># CONFIG_PROVE_LOCKI=
NG is not set<br># CONFIG_LOCK_STAT is not set<br># CONFIG_DEBUG_ATOMIC_SLE=
EP is not set<br># CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set<br># CONFI=
G_LOCK_TORTURE_TEST is not set<br>CONFIG_STACKTRACE=3Dy<br># CONFIG_DEBUG_K=
OBJECT is not set<br>CONFIG_DEBUG_BUGVERBOSE=3Dy<br># CONFIG_DEBUG_LIST is =
not set<br># CONFIG_DEBUG_PI_LIST is not set<br># CONFIG_DEBUG_SG is not se=
t<br># CONFIG_DEBUG_NOTIFIERS is not set<br># CONFIG_DEBUG_CREDENTIALS is n=
ot set<br><br>#<br># RCU Debugging<br>#<br># CONFIG_PROVE_RCU is not set<br=
># CONFIG_SPARSE_RCU_POINTER is not set<br># CONFIG_TORTURE_TEST is not set=
<br># CONFIG_RCU_TORTURE_TEST is not set<br>CONFIG_RCU_CPU_STALL_TIMEOUT=3D=
21<br># CONFIG_RCU_TRACE is not set<br># CONFIG_RCU_EQS_DEBUG is not set<br=
># CONFIG_DEBUG_BLOCK_EXT_DEVT is not set<br># CONFIG_NOTIFIER_ERROR_INJECT=
ION is not set<br># CONFIG_FAULT_INJECTION is not set<br>CONFIG_LATENCYTOP=
=3Dy<br>CONFIG_NOP_TRACER=3Dy<br>CONFIG_HAVE_FUNCTION_TRACER=3Dy<br>CONFIG_=
HAVE_FUNCTION_GRAPH_TRACER=3Dy<br>CONFIG_HAVE_DYNAMIC_FTRACE=3Dy<br>CONFIG_=
HAVE_FTRACE_MCOUNT_RECORD=3Dy<br>CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy<br>CON=
FIG_TRACER_MAX_TRACE=3Dy<br>CONFIG_TRACE_CLOCK=3Dy<br>CONFIG_RING_BUFFER=3D=
y<br>CONFIG_EVENT_TRACING=3Dy<br>CONFIG_CONTEXT_SWITCH_TRACER=3Dy<br>CONFIG=
_RING_BUFFER_ALLOW_SWAP=3Dy<br>CONFIG_TRACING=3Dy<br>CONFIG_GENERIC_TRACER=
=3Dy<br>CONFIG_TRACING_SUPPORT=3Dy<br>CONFIG_FTRACE=3Dy<br># CONFIG_FUNCTIO=
N_TRACER is not set<br># CONFIG_IRQSOFF_TRACER is not set<br>CONFIG_SCHED_T=
RACER=3Dy<br># CONFIG_FTRACE_SYSCALLS is not set<br>CONFIG_TRACER_SNAPSHOT=
=3Dy<br># CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set<br>CONFIG_BRANCH_P=
ROFILE_NONE=3Dy<br># CONFIG_PROFILE_ANNOTATED_BRANCHES is not set<br># CONF=
IG_PROFILE_ALL_BRANCHES is not set<br># CONFIG_STACK_TRACER is not set<br>C=
ONFIG_BLK_DEV_IO_TRACE=3Dy<br>CONFIG_KPROBE_EVENT=3Dy<br># CONFIG_UPROBE_EV=
ENT is not set<br>CONFIG_PROBE_EVENTS=3Dy<br># CONFIG_FTRACE_STARTUP_TEST i=
s not set<br># CONFIG_TRACEPOINT_BENCHMARK is not set<br># CONFIG_RING_BUFF=
ER_BENCHMARK is not set<br># CONFIG_RING_BUFFER_STARTUP_TEST is not set<br>=
# CONFIG_TRACE_ENUM_MAP_FILE is not set<br><br>#<br># Runtime Testing<br>#<=
br># CONFIG_LKDTM is not set<br># CONFIG_TEST_LIST_SORT is not set<br># CON=
FIG_KPROBES_SANITY_TEST is not set<br># CONFIG_BACKTRACE_SELF_TEST is not s=
et<br># CONFIG_RBTREE_TEST is not set<br># CONFIG_INTERVAL_TREE_TEST is not=
 set<br># CONFIG_PERCPU_TEST is not set<br># CONFIG_ATOMIC64_SELFTEST is no=
t set<br># CONFIG_ASYNC_RAID6_TEST is not set<br># CONFIG_TEST_HEXDUMP is n=
ot set<br># CONFIG_TEST_STRING_HELPERS is not set<br># CONFIG_TEST_KSTRTOX =
is not set<br># CONFIG_TEST_PRINTF is not set<br># CONFIG_TEST_RHASHTABLE i=
s not set<br># CONFIG_DMA_API_DEBUG is not set<br># CONFIG_TEST_LKM is not =
set<br># CONFIG_TEST_USER_COPY is not set<br># CONFIG_TEST_BPF is not set<b=
r># CONFIG_TEST_FIRMWARE is not set<br># CONFIG_TEST_UDELAY is not set<br>#=
 CONFIG_MEMTEST is not set<br># CONFIG_TEST_STATIC_KEYS is not set<br># CON=
FIG_SAMPLES is not set<br>CONFIG_HAVE_ARCH_KGDB=3Dy<br># CONFIG_KGDB is not=
 set<br># CONFIG_PPC_DISABLE_WERROR is not set<br>CONFIG_PPC_WERROR=3Dy<br>=
# CONFIG_STRICT_MM_TYPECHECKS is not set<br>CONFIG_PRINT_STACK_DEPTH=3D64<b=
r># CONFIG_HCALL_STATS is not set<br># CONFIG_PPC_EMULATED_STATS is not set=
<br>CONFIG_CODE_PATCHING_SELFTEST=3Dy<br>CONFIG_FTR_FIXUP_SELFTEST=3Dy<br>C=
ONFIG_MSI_BITMAP_SELFTEST=3Dy<br>CONFIG_XMON=3Dy<br># CONFIG_XMON_DEFAULT i=
s not set<br>CONFIG_XMON_DISASSEMBLY=3Dy<br>CONFIG_DEBUGGER=3Dy<br>CONFIG_B=
OOTX_TEXT=3Dy<br>CONFIG_PPC_EARLY_DEBUG=3Dy<br>CONFIG_PPC_EARLY_DEBUG_BOOTX=
=3Dy<br># CONFIG_PPC_EARLY_DEBUG_LPAR is not set<br># CONFIG_PPC_EARLY_DEBU=
G_LPAR_HVSI is not set<br># CONFIG_PPC_EARLY_DEBUG_G5 is not set<br># CONFI=
G_PPC_EARLY_DEBUG_RTAS_PANEL is not set<br># CONFIG_PPC_EARLY_DEBUG_RTAS_CO=
NSOLE is not set<br># CONFIG_PPC_EARLY_DEBUG_MAPLE is not set<br># CONFIG_P=
PC_EARLY_DEBUG_PAS_REALMODE is not set<br># CONFIG_PPC_EARLY_DEBUG_PS3GELIC=
 is not set<br># CONFIG_PPC_EARLY_DEBUG_OPAL_RAW is not set<br># CONFIG_PPC=
_EARLY_DEBUG_OPAL_HVSI is not set<br># CONFIG_PPC_EARLY_DEBUG_MEMCONS is no=
t set<br>CONFIG_STRICT_DEVMEM=3Dy<br><br>#<br># Security options<br>#<br>CO=
NFIG_KEYS=3Dy<br># CONFIG_PERSISTENT_KEYRINGS is not set<br># CONFIG_BIG_KE=
YS is not set<br># CONFIG_ENCRYPTED_KEYS is not set<br># CONFIG_SECURITY_DM=
ESG_RESTRICT is not set<br># CONFIG_SECURITY is not set<br># CONFIG_SECURIT=
YFS is not set<br>CONFIG_DEFAULT_SECURITY_DAC=3Dy<br>CONFIG_DEFAULT_SECURIT=
Y=3D&quot;&quot;<br>CONFIG_KEYS_COMPAT=3Dy<br>CONFIG_XOR_BLOCKS=3Dm<br>CONF=
IG_ASYNC_CORE=3Dm<br>CONFIG_ASYNC_MEMCPY=3Dm<br>CONFIG_ASYNC_XOR=3Dm<br>CON=
FIG_ASYNC_PQ=3Dm<br>CONFIG_ASYNC_RAID6_RECOV=3Dm<br>CONFIG_CRYPTO=3Dy<br><b=
r>#<br># Crypto core or helper<br>#<br>CONFIG_CRYPTO_ALGAPI=3Dy<br>CONFIG_C=
RYPTO_ALGAPI2=3Dy<br>CONFIG_CRYPTO_AEAD=3Dm<br>CONFIG_CRYPTO_AEAD2=3Dy<br>C=
ONFIG_CRYPTO_BLKCIPHER=3Dm<br>CONFIG_CRYPTO_BLKCIPHER2=3Dy<br>CONFIG_CRYPTO=
_HASH=3Dy<br>CONFIG_CRYPTO_HASH2=3Dy<br>CONFIG_CRYPTO_RNG=3Dm<br>CONFIG_CRY=
PTO_RNG2=3Dy<br>CONFIG_CRYPTO_RNG_DEFAULT=3Dm<br>CONFIG_CRYPTO_PCOMP2=3Dy<b=
r>CONFIG_CRYPTO_AKCIPHER2=3Dy<br># CONFIG_CRYPTO_RSA is not set<br>CONFIG_C=
RYPTO_MANAGER=3Dy<br>CONFIG_CRYPTO_MANAGER2=3Dy<br># CONFIG_CRYPTO_USER is =
not set<br>CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy<br># CONFIG_CRYPTO_GF128=
MUL is not set<br>CONFIG_CRYPTO_NULL=3Dm<br>CONFIG_CRYPTO_NULL2=3Dy<br># CO=
NFIG_CRYPTO_PCRYPT is not set<br>CONFIG_CRYPTO_WORKQUEUE=3Dy<br># CONFIG_CR=
YPTO_CRYPTD is not set<br># CONFIG_CRYPTO_MCRYPTD is not set<br>CONFIG_CRYP=
TO_AUTHENC=3Dm<br>CONFIG_CRYPTO_TEST=3Dm<br><br>#<br># Authenticated Encryp=
tion with Associated Data<br>#<br>CONFIG_CRYPTO_CCM=3Dm<br># CONFIG_CRYPTO_=
GCM is not set<br># CONFIG_CRYPTO_CHACHA20POLY1305 is not set<br>CONFIG_CRY=
PTO_SEQIV=3Dm<br>CONFIG_CRYPTO_ECHAINIV=3Dm<br><br>#<br># Block modes<br>#<=
br>CONFIG_CRYPTO_CBC=3Dm<br>CONFIG_CRYPTO_CTR=3Dm<br># CONFIG_CRYPTO_CTS is=
 not set<br>CONFIG_CRYPTO_ECB=3Dm<br># CONFIG_CRYPTO_LRW is not set<br>CONF=
IG_CRYPTO_PCBC=3Dm<br># CONFIG_CRYPTO_XTS is not set<br># CONFIG_CRYPTO_KEY=
WRAP is not set<br><br>#<br># Hash modes<br>#<br>CONFIG_CRYPTO_CMAC=3Dm<br>=
CONFIG_CRYPTO_HMAC=3Dy<br># CONFIG_CRYPTO_XCBC is not set<br># CONFIG_CRYPT=
O_VMAC is not set<br><br>#<br># Digest<br>#<br>CONFIG_CRYPTO_CRC32C=3Dy<br>=
# CONFIG_CRYPTO_CRC32 is not set<br>CONFIG_CRYPTO_CRCT10DIF=3Dm<br># CONFIG=
_CRYPTO_GHASH is not set<br># CONFIG_CRYPTO_POLY1305 is not set<br>CONFIG_C=
RYPTO_MD4=3Dm<br>CONFIG_CRYPTO_MD5=3Dm<br># CONFIG_CRYPTO_MD5_PPC is not se=
t<br>CONFIG_CRYPTO_MICHAEL_MIC=3Dm<br># CONFIG_CRYPTO_RMD128 is not set<br>=
# CONFIG_CRYPTO_RMD160 is not set<br># CONFIG_CRYPTO_RMD256 is not set<br>#=
 CONFIG_CRYPTO_RMD320 is not set<br>CONFIG_CRYPTO_SHA1=3Dm<br># CONFIG_CRYP=
TO_SHA1_PPC is not set<br>CONFIG_CRYPTO_SHA256=3Dm<br># CONFIG_CRYPTO_SHA51=
2 is not set<br>CONFIG_CRYPTO_TGR192=3Dm<br>CONFIG_CRYPTO_WP512=3Dm<br><br>=
#<br># Ciphers<br>#<br>CONFIG_CRYPTO_AES=3Dy<br>CONFIG_CRYPTO_ANUBIS=3Dm<br=
>CONFIG_CRYPTO_ARC4=3Dm<br>CONFIG_CRYPTO_BLOWFISH=3Dm<br>CONFIG_CRYPTO_BLOW=
FISH_COMMON=3Dm<br># CONFIG_CRYPTO_CAMELLIA is not set<br>CONFIG_CRYPTO_CAS=
T_COMMON=3Dm<br># CONFIG_CRYPTO_CAST5 is not set<br>CONFIG_CRYPTO_CAST6=3Dm=
<br>CONFIG_CRYPTO_DES=3Dm<br># CONFIG_CRYPTO_FCRYPT is not set<br>CONFIG_CR=
YPTO_KHAZAD=3Dm<br>CONFIG_CRYPTO_SALSA20=3Dm<br># CONFIG_CRYPTO_CHACHA20 is=
 not set<br># CONFIG_CRYPTO_SEED is not set<br>CONFIG_CRYPTO_SERPENT=3Dm<br=
>CONFIG_CRYPTO_TEA=3Dm<br>CONFIG_CRYPTO_TWOFISH=3Dm<br>CONFIG_CRYPTO_TWOFIS=
H_COMMON=3Dm<br><br>#<br># Compression<br>#<br>CONFIG_CRYPTO_DEFLATE=3Dm<br=
># CONFIG_CRYPTO_ZLIB is not set<br>CONFIG_CRYPTO_LZO=3Dm<br># CONFIG_CRYPT=
O_842 is not set<br># CONFIG_CRYPTO_LZ4 is not set<br># CONFIG_CRYPTO_LZ4HC=
 is not set<br><br>#<br># Random Number Generation<br>#<br># CONFIG_CRYPTO_=
ANSI_CPRNG is not set<br>CONFIG_CRYPTO_DRBG_MENU=3Dm<br>CONFIG_CRYPTO_DRBG_=
HMAC=3Dy<br># CONFIG_CRYPTO_DRBG_HASH is not set<br># CONFIG_CRYPTO_DRBG_CT=
R is not set<br>CONFIG_CRYPTO_DRBG=3Dm<br>CONFIG_CRYPTO_JITTERENTROPY=3Dm<b=
r># CONFIG_CRYPTO_USER_API_HASH is not set<br># CONFIG_CRYPTO_USER_API_SKCI=
PHER is not set<br># CONFIG_CRYPTO_USER_API_RNG is not set<br># CONFIG_CRYP=
TO_USER_API_AEAD is not set<br>CONFIG_CRYPTO_HW=3Dy<br>CONFIG_CRYPTO_DEV_NX=
=3Dy<br>CONFIG_CRYPTO_DEV_NX_ENCRYPT=3Dm<br>CONFIG_CRYPTO_DEV_NX_COMPRESS=
=3Dy<br>CONFIG_CRYPTO_DEV_NX_COMPRESS_PSERIES=3Dy<br>CONFIG_CRYPTO_DEV_NX_C=
OMPRESS_POWERNV=3Dy<br># CONFIG_CRYPTO_DEV_VMX is not set<br># CONFIG_ASYMM=
ETRIC_KEY_TYPE is not set<br><br>#<br># Certificates for signature checking=
<br>#<br># CONFIG_SYSTEM_TRUSTED_KEYRING is not set<br>CONFIG_HAVE_KVM_IRQC=
HIP=3Dy<br>CONFIG_HAVE_KVM_IRQFD=3Dy<br>CONFIG_HAVE_KVM_EVENTFD=3Dy<br>CONF=
IG_KVM_COMPAT=3Dy<br>CONFIG_VIRTUALIZATION=3Dy<br>CONFIG_KVM=3Dy<br>CONFIG_=
KVM_BOOK3S_HANDLER=3Dy<br>CONFIG_KVM_BOOK3S_64_HANDLER=3Dy<br>CONFIG_KVM_BO=
OK3S_HV_POSSIBLE=3Dy<br>CONFIG_KVM_BOOK3S_64=3Dm<br>CONFIG_KVM_BOOK3S_64_HV=
=3Dm<br># CONFIG_KVM_BOOK3S_64_PR is not set<br># CONFIG_KVM_BOOK3S_HV_EXIT=
_TIMING is not set<br>CONFIG_KVM_XICS=3Dy</span></span></p><p><span lang=3D=
"en"><span title=3D"make: *** [arch/powerpc/kernel] Erreur 2">any suggestio=
n to fix this error and thanks</span></span></p><p><span lang=3D"en"><span =
title=3D"make: *** [arch/powerpc/kernel] Erreur 2">=C2=A0regards</span></sp=
an></p><span class=3D""><font color=3D"#888888"><p><span lang=3D"en"><span =
title=3D"make: *** [arch/powerpc/kernel] Erreur 2">marwa<br></span></span><=
/p><span></span></font></span></div>
</blockquote></div>sorry this is the error in english , the other one was t=
ranslated from French to english<br>=C2=A0VDSO32L arch/powerpc/kernel/vdso3=
2/vdso32.so.dbg<br>/usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../..=
/powerpc64le-linux-gnu/bin/ld: arch/powerpc/kernel/vdso32/sigtramp.o: compi=
led for a little endian system and target is big endian<br>/usr/lib/gcc-cro=
ss/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld: fail=
ed to merge target specific data of file arch/powerpc/kernel/vdso32/sigtram=
p.o<br>/usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le=
-linux-gnu/bin/ld: arch/powerpc/kernel/vdso32/gettimeofday.o: compiled for =
a little endian system and target is big endian<br>/usr/lib/gcc-cross/power=
pc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld: failed to me=
rge target specific data of file arch/powerpc/kernel/vdso32/gettimeofday.o<=
br>/usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-lin=
ux-gnu/bin/ld: arch/powerpc/kernel/vdso32/datapage.o: compiled for a little=
 endian system and target is big endian<br>/usr/lib/gcc-cross/powerpc64le-l=
inux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld: failed to merge targ=
et specific data of file arch/powerpc/kernel/vdso32/datapage.o<br>/usr/lib/=
gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/l=
d: arch/powerpc/kernel/vdso32/cacheflush.o: compiled for a little endian sy=
stem and target is big endian<br>/usr/lib/gcc-cross/powerpc64le-linux-gnu/4=
.8/../../../../powerpc64le-linux-gnu/bin/ld: failed to merge target specifi=
c data of file arch/powerpc/kernel/vdso32/cacheflush.o<br>/usr/lib/gcc-cros=
s/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld: arch/=
powerpc/kernel/vdso32/note.o: compiled for a little endian system and targe=
t is big endian<br>/usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../..=
/powerpc64le-linux-gnu/bin/ld: failed to merge target specific data of file=
 arch/powerpc/kernel/vdso32/note.o<br>/usr/lib/gcc-cross/powerpc64le-linux-=
gnu/4.8/../../../../powerpc64le-linux-gnu/bin/ld: arch/powerpc/kernel/vdso3=
2/getcpu.o: compiled for a little endian system and target is big endian<br=
>/usr/lib/gcc-cross/powerpc64le-linux-gnu/4.8/../../../../powerpc64le-linux=
-gnu/bin/ld: failed to merge target specific data of file arch/powerpc/kern=
el/vdso32/getcpu.o<br>collect2: error: ld returned 1 exit status<br>make[2]=
: *** [arch/powerpc/kernel/vdso32/vdso32.so.dbg] Error 1<br>make[1]: *** [a=
rch/powerpc/kernel/vdso32] Error 2<br>make: *** [arch/powerpc/kernel] Error=
 2<br></div><div class=3D"gmail_extra">it&#39;s a big endian and a little e=
ndian problem , so i changed the kernel configuration into little endian an=
d i got this error <br>*** binutils 2.24 miscompiles weak symbols in some c=
ircumstances.<br>*** Please use a different binutils version.make: *** [che=
ckbin] Error 1<br></div><div class=3D"gmail_extra">regards<br></div><div cl=
ass=3D"gmail_extra">marwa<br></div><div class=3D"gmail_extra"><br></div></d=
iv>

--001a11357726e5a1a405318a4784--
