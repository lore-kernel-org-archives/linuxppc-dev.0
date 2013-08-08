Return-Path: <schivers@csc.com.au>
Received: from mail1.bemta8.messagelabs.com (mail1.bemta8.messagelabs.com
 [216.82.243.203])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.bemta8.messagelabs.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 32A1E2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Aug 2013 10:10:30 +1000 (EST)
To: benh@kernel.crashing.org, paulus@samba.org
MIME-Version: 1.0
Subject: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for Motorola/Emerson
 MVME5100.
From: Stephen N Chivers <schivers@csc.com.au>
Message-ID: <OFBCFBBD51.E4ECB0DF-ONCA257BC0.0083C866-CA257BC1.0000531E@csc.com>
Date: Thu, 8 Aug 2013 11:03:31 +1100
Content-Type: text/plain; charset="US-ASCII"
Cc: Chris Proctor <cproctor@csc.com.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for the Motorola/Emerson MVME5100 Single Board Computer.

The MVME5100 is a 6U form factor VME64 computer with:

        - A single MPC7410 or MPC750 CPU
        - A HAWK Processor Host Bridge (CPU to PCI) and
          MultiProcessor Interrupt Controller (MPIC)
        - Up to 500Mb of onboard memory
        - A M48T37 Real Time Clock (RTC) and Non-Volatile Memory chip
        - Two 16550 compatible UARTS
        - Two Intel E100 Fast Ethernets
        - Two PCI Mezzanine Card (PMC) Slots
        - PPCBug Firmware

The HAWK PHB/MPIC is compatible with the MPC10x devices.

There is no onboard disk support. This is usually provided by installing a 
PMC
in first PMC slot.

This patch revives the board support, it was present in early 2.6
series kernels. The board support in those days was by Matt Porter of
MontaVista Software.

CSC Australia has around 31 of these boards in service. The kernel in use
for the boards is based on 2.6.31. The boards are operated without disks
from a file server. 

This patch is based on linux-3.11-rc4 and has been boot tested.

Signed-off-by: Stephen Chivers <schivers@csc.com>
---
 arch/powerpc/boot/dts/mvme5100.dts            |  195 ++
 arch/powerpc/boot/mvme5100.c                  |   28 +
 arch/powerpc/configs/mvme5100_defconfig       | 2597 
+++++++++++++++++++++++++
 arch/powerpc/platforms/embedded6xx/mvme5100.c |  288 +++
 4 files changed, 3108 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mvme5100.dts 
b/arch/powerpc/boot/dts/mvme5100.dts
new file mode 100644
index 0000000..17fdbc7
--- /dev/null
+++ b/arch/powerpc/boot/dts/mvme5100.dts
@@ -0,0 +1,195 @@
+/*
+ * Device Tree Souce for Motorola/Emerson MVME5100.
+ *
+ * Copyright 2013 CSC Australia Pty. Ltd.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+/ {
+       model = "MVME5100";
+       compatible = "MVME5100";
+       #address-cells = <1>;
+       #size-cells = <1>;
+
+       aliases {
+               serial0 = &serial0;
+               pci0 = &pci0;
+       };
+
+       cpus {
+               #address-cells = <1>;
+               #size-cells = <0>;
+
+               PowerPC,7410 {
+                       device_type = "cpu";
+                       reg = <0x0>;
+                       /* Following required by dtc but not used */
+                       d-cache-line-size = <32>;
+                       i-cache-line-size = <32>;
+                       i-cache-size = <32768>;
+                       d-cache-size = <32768>;
+                       timebase-frequency = <25000000>;
+                       clock-frequency = <500000000>;
+                        bus-frequency = <100000000>;
+               };
+       };
+
+       memory {
+               device_type = "memory";
+               reg = <0x0 0x20000000>;
+       };
+
+       hawk@fef8 {
+               #address-cells = <1>;
+               #size-cells = <1>;
+               device_type = "soc";
+               compatible = "mpc10x";
+               store-gathering = <0>;
+               ranges = <0x0 0xfef80000 0x10000>;
+               reg = <0xfef80000 0x10000>;
+
+               serial0: serial@8000 {
+                       cell-index = <0>;
+                       device_type = "serial";
+                       compatible = "ns16550";
+                       reg = <0x8000 0x80>;
+                       reg-shift = <4>;
+                       clock-frequency = <1843200>;
+                       current-speed = <9600>;
+                       interrupts = <1 1>; // IRQ1 Level Active Low.
+                       interrupt-parent = <&mpic>;
+               };
+
+               serial1: serial@8200 {
+                       cell-index = <1>;
+                       device_type = "serial";
+                       compatible = "ns16550";
+                       reg = <0x8200 0x80>;
+                       reg-shift = <4>;
+                       clock-frequency = <1843200>;
+                       current-speed = <9600>;
+                       interrupts = <1 1>; // IRQ1 Level Active Low.
+                       interrupt-parent = <&mpic>;
+               };
+
+               mpic: interrupt-controller@f3f80000 {
+                       #interrupt-cells = <2>;
+                       #address-cells = <0>;
+                       device_type = "open-pic";
+                       compatible = "chrp,open-pic";
+                       interrupt-controller;
+                       reg = <0xf3f80000 0x40000>;
+               };
+
+       };
+
+       pci0: pci@feff0000 {
+               #address-cells = <3>;
+               #size-cells = <2>;
+               #interrupt-cells = <1>;
+               device_type = "pci";
+               compatible = "mpc10x-pci";
+               reg = <0xfec00000 0x400000>;
+               8259-interrupt-acknowledge = <0xfeff0030>;
+               ranges = <0x1000000 0x0        0x0 0xfe000000 0x0 0x800000
+                         0x2000000 0x0 0x80000000 0x80000000 0x0 
0x74000000>;
+               bus-range = <0 255>;
+               clock-frequency = <33333333>;
+               interrupt-parent = <&mpic>;
+               interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+               interrupt-map = <
+
+                       /*
+                        * This definition (IDSEL 11) duplicates the
+                        * interrupts definition in the i8259
+                        * interrupt controller below.
+                        *
+                        * It isn't essential to provide it and the
+                        * board will run happily without it.
+                        *
+                        * Do not change the interrupt sense/polarity from
+                        * 0x2 to anything else, doing so will cause 
endless
+                        * "spurious" i8259 interrupts to be fielded.
+                        */
+                       // IDSEL 11 - iPMC712 PCI/ISA Bridge
+                       0x5800 0x0 0x0 0x1 &mpic 0x0 0x2
+                       0x5800 0x0 0x0 0x2 &mpic 0x0 0x2
+                       0x5800 0x0 0x0 0x3 &mpic 0x0 0x2
+                       0x5800 0x0 0x0 0x4 &mpic 0x0 0x2
+
+                       /* IDSEL 12 - Not Used */
+
+                       /* IDSEL 13 - Universe VME Bridge */
+                       0x6800 0x0 0x0 0x1 &mpic 0x5 0x1
+                       0x6800 0x0 0x0 0x2 &mpic 0x6 0x1
+                       0x6800 0x0 0x0 0x3 &mpic 0x7 0x1
+                       0x6800 0x0 0x0 0x4 &mpic 0x8 0x1
+
+                       /* IDSEL 14 - ENET 1 */
+                       0x7000 0x0 0x0 0x1 &mpic 0x2 0x1
+
+                       /* IDSEL 15 - Not Used */
+
+                       /* IDSEL 16 - PMC Slot 1 */
+                       0x8000 0x0 0x0 0x1 &mpic 0x9 0x1
+                       0x8000 0x0 0x0 0x2 &mpic 0xa 0x1
+                       0x8000 0x0 0x0 0x3 &mpic 0xb 0x1
+                       0x8000 0x0 0x0 0x4 &mpic 0xc 0x1
+
+                       /* IDSEL 17 - PMC Slot 2 */
+                       0x8800 0x0 0x0 0x1 &mpic 0xc 0x1
+                       0x8800 0x0 0x0 0x2 &mpic 0x9 0x1
+                       0x8800 0x0 0x0 0x3 &mpic 0xa 0x1
+                       0x8800 0x0 0x0 0x4 &mpic 0xb 0x1
+
+                       /* IDSEL 18 - Not Used */
+
+                       /* IDSEL 19 - ENET 2 */
+                       0x9800 0x0 0x0 0x1 &mpic 0xd 0x1
+
+                       /* IDSEL 20 - PMCSPAN (PCI-X) */
+                       0xa000 0x0 0x0 0x1 &mpic 0x9 0x1
+                       0xa000 0x0 0x0 0x2 &mpic 0xa 0x1
+                       0xa000 0x0 0x0 0x3 &mpic 0xb 0x1
+                       0xa000 0x0 0x0 0x4 &mpic 0xc 0x1
+
+               >;
+
+               isa {
+                       #address-cells = <2>;
+                       #size-cells = <1>;
+                       #interrupt-cells = <2>;
+                       device_type = "isa";
+                       compatible = "isa";
+                       ranges = <0x00000001 0 0x01000000 0 0x00000000 
0x00001000>;
+                       interrupt-parent = <&i8259>;
+
+                       i8259: interrupt-controller@20 {
+                               #interrupt-cells = <2>;
+                               #address-cells = <0>;
+                               interrupts = <0 2>;
+                               device_type = "interrupt-controller";
+                               compatible = "chrp,iic";
+                               interrupt-controller;
+                               reg = <1 0x00000020 0x00000002
+                                       1 0x000000a0 0x00000002
+                                       1 0x000004d0 0x00000002>;
+                               clock-frequency = <0>;
+                               built-in;
+                               interrupt-parent = <&mpic>;
+                       };
+
+               };
+
+       };
+
+       chosen {
+               linux,stdout-path = &serial0;
+        };
+
+};
diff --git a/arch/powerpc/boot/mvme5100.c b/arch/powerpc/boot/mvme5100.c
new file mode 100644
index 0000000..65ea0f3
--- /dev/null
+++ b/arch/powerpc/boot/mvme5100.c
@@ -0,0 +1,28 @@
+/*
+ * Motorola/Emerson MVME5100 with PPCBug firmware.
+ *
+ * Author: Stephen Chivers <schivers@csc.com>
+ *
+ * Copyright 2013 CSC Australia Pty. Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ */
+#include "types.h"
+#include "ops.h"
+#include "io.h"
+
+BSS_STACK(4096);
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5)
+{
+       u32                     heapsize;
+
+
+       heapsize = 0x8000000 - (u32)_end; /* 128M */
+       simple_alloc_init(_end, heapsize, 32, 64);
+       fdt_init(_dtb_start);
+       serial_console_init();
+}
diff --git a/arch/powerpc/configs/mvme5100_defconfig 
b/arch/powerpc/configs/mvme5100_defconfig
new file mode 100644
index 0000000..43682de
--- /dev/null
+++ b/arch/powerpc/configs/mvme5100_defconfig
@@ -0,0 +1,2597 @@
+#
+# Automatically generated file; DO NOT EDIT.
+# Linux/powerpc 3.11.0-rc4 Kernel Configuration
+#
+# CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+CONFIG_PPC_BOOK3S_32=y
+# CONFIG_PPC_85xx is not set
+# CONFIG_PPC_8xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+CONFIG_PPC_BOOK3S=y
+CONFIG_6xx=y
+CONFIG_PPC_FPU=y
+# CONFIG_ALTIVEC is not set
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_PPC_MM_SLICES is not set
+CONFIG_PPC_HAVE_PMU_SUPPORT=y
+# CONFIG_SMP is not set
+# CONFIG_PPC_DOORBELL is not set
+CONFIG_PPC32=y
+CONFIG_32BIT=y
+CONFIG_WORD_SIZE=32
+# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
+# CONFIG_ARCH_DMA_ADDR_T_64BIT is not set
+CONFIG_MMU=y
+# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
+# CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK is not set
+CONFIG_NR_IRQS=512
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_HAVE_LATENCYTOP_SUPPORT=y
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_PPC=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+CONFIG_PPC_OF=y
+# CONFIG_PPC_UDBG_16550 is not set
+# CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=y
+CONFIG_GENERIC_BUG=y
+# CONFIG_EPAPR_BOOT is not set
+# CONFIG_DEFAULT_UIMAGE is not set
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
+CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
+CONFIG_ARCH_SUPPORTS_UPROBES=y
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_IRQ_WORK=y
+
+#
+# General setup
+#
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_CROSS_COMPILE=""
+# CONFIG_COMPILE_TEST is not set
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_DEFAULT_HOSTNAME="(none)"
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
+# CONFIG_FHANDLE is not set
+# CONFIG_AUDIT is not set
+CONFIG_HAVE_GENERIC_HARDIRQS=y
+
+#
+# IRQ subsystem
+#
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_SHOW=y
+CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
+CONFIG_IRQ_DOMAIN=y
+CONFIG_IRQ_FORCED_THREADING=y
+CONFIG_SPARSE_IRQ=y
+CONFIG_GENERIC_TIME_VSYSCALL_OLD=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+
+#
+# Timers subsystem
+#
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ_COMMON=y
+# CONFIG_HZ_PERIODIC is not set
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+
+#
+# CPU/Task time and stats accounting
+#
+CONFIG_TICK_CPU_ACCOUNTING=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_TINY_RCU=y
+# CONFIG_PREEMPT_RCU is not set
+# CONFIG_RCU_STALL_COMMON is not set
+# CONFIG_TREE_RCU_TRACE is not set
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+# CONFIG_CHECKPOINT_RESTORE is not set
+CONFIG_NAMESPACES=y
+# CONFIG_UTS_NS is not set
+# CONFIG_IPC_NS is not set
+# CONFIG_PID_NS is not set
+# CONFIG_NET_NS is not set
+# CONFIG_SCHED_AUTOGROUP is not set
+# CONFIG_SYSFS_DEPRECATED is not set
+# CONFIG_RELAY is not set
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
+CONFIG_SYSCTL_EXCEPTION_TRACE=y
+# CONFIG_EXPERT is not set
+# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+CONFIG_AIO=y
+CONFIG_PCI_QUIRKS=y
+# CONFIG_EMBEDDED is not set
+CONFIG_HAVE_PERF_EVENTS=y
+
+#
+# Kernel Performance Events And Counters
+#
+# CONFIG_PERF_EVENTS is not set
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLUB_DEBUG=y
+# CONFIG_COMPAT_BRK is not set
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+CONFIG_SLUB_CPU_PARTIAL=y
+# CONFIG_PROFILING is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_KPROBES is not set
+# CONFIG_JUMP_LABEL is not set
+# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
+CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
+CONFIG_ARCH_USE_BUILTIN_BSWAP=y
+CONFIG_HAVE_IOREMAP_PROT=y
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
+CONFIG_HAVE_ARCH_TRACEHOOK=y
+CONFIG_HAVE_DMA_ATTRS=y
+CONFIG_GENERIC_SMP_IDLE_THREAD=y
+CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
+CONFIG_HAVE_DMA_API_DEBUG=y
+CONFIG_HAVE_ARCH_JUMP_LABEL=y
+CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
+CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
+CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
+CONFIG_MODULES_USE_ELF_RELA=y
+CONFIG_CLONE_BACKWARDS=y
+CONFIG_OLD_SIGSUSPEND=y
+CONFIG_OLD_SIGACTION=y
+
+#
+# GCOV-based kernel profiling
+#
+# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+# CONFIG_MODULE_SIG is not set
+CONFIG_BLOCK=y
+CONFIG_LBDAF=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_BSGLIB is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+CONFIG_EFI_PARTITION=y
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_DEFAULT_DEADLINE is not set
+CONFIG_DEFAULT_CFQ=y
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="cfq"
+CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
+CONFIG_INLINE_READ_UNLOCK=y
+CONFIG_INLINE_READ_UNLOCK_IRQ=y
+CONFIG_INLINE_WRITE_UNLOCK=y
+CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
+# CONFIG_FREEZER is not set
+# CONFIG_PPC_XICS is not set
+# CONFIG_PPC_ICP_NATIVE is not set
+# CONFIG_PPC_ICP_HV is not set
+# CONFIG_PPC_ICS_RTAS is not set
+# CONFIG_GE_FPGA is not set
+
+#
+# Platform support
+#
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_MPC512x is not set
+# CONFIG_PPC_MPC52xx is not set
+# CONFIG_PPC_PMAC is not set
+# CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+# CONFIG_PPC_82xx is not set
+# CONFIG_PQ2ADS is not set
+# CONFIG_PPC_83xx is not set
+# CONFIG_PPC_86xx is not set
+CONFIG_EMBEDDED6xx=y
+# CONFIG_LINKSTATION is not set
+# CONFIG_STORCENTER is not set
+# CONFIG_MPC7448HPC2 is not set
+# CONFIG_PPC_HOLLY is not set
+# CONFIG_PPC_PRPMC2800 is not set
+# CONFIG_PPC_C2K is not set
+# CONFIG_GAMECUBE is not set
+# CONFIG_WII is not set
+CONFIG_MVME5100=y
+# CONFIG_AMIGAONE is not set
+# CONFIG_PPC_WSP is not set
+CONFIG_KVM_GUEST=y
+CONFIG_EPAPR_PARAVIRT=y
+CONFIG_PPC_NATIVE=y
+CONFIG_PPC_OF_BOOT_TRAMPOLINE=y
+# CONFIG_IPIC is not set
+CONFIG_MPIC=y
+# CONFIG_PPC_EPAPR_HV_PIC is not set
+# CONFIG_MPIC_WEIRD is not set
+# CONFIG_MPIC_MSGR is not set
+CONFIG_PPC_I8259=y
+# CONFIG_PPC_RTAS is not set
+# CONFIG_MMIO_NVRAM is not set
+# CONFIG_MPIC_U3_HT_IRQS is not set
+# CONFIG_PPC_MPC106 is not set
+# CONFIG_PPC_970_NAP is not set
+# CONFIG_PPC_P7_NAP is not set
+
+#
+# CPU Frequency scaling
+#
+# CONFIG_CPU_FREQ is not set
+
+#
+# CPUIdle driver
+#
+# CONFIG_CPU_IDLE is not set
+# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
+# CONFIG_TAU is not set
+# CONFIG_FSL_ULI1575 is not set
+# CONFIG_SIMPLE_GPIO is not set
+
+#
+# Kernel options
+#
+# CONFIG_HIGHMEM is not set
+CONFIG_HZ_100=y
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_300 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=100
+CONFIG_SCHED_HRTICK=y
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_BINFMT_SCRIPT=y
+# CONFIG_HAVE_AOUT is not set
+# CONFIG_BINFMT_MISC is not set
+CONFIG_COREDUMP=y
+# CONFIG_IOMMU_HELPER is not set
+# CONFIG_SWIOTLB is not set
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+CONFIG_ARCH_HAS_WALK_MEMORY=y
+CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
+# CONFIG_KEXEC is not set
+# CONFIG_CRASH_DUMP is not set
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_HAVE_MEMBLOCK=y
+CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
+# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_COMPACTION is not set
+CONFIG_MIGRATION=y
+# CONFIG_PHYS_ADDR_T_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
+CONFIG_CROSS_MEMORY_ATTACH=y
+CONFIG_NEED_PER_CPU_KM=y
+# CONFIG_CLEANCACHE is not set
+# CONFIG_FRONTSWAP is not set
+# CONFIG_ZBUD is not set
+CONFIG_PPC_4K_PAGES=y
+CONFIG_FORCE_MAX_ZONEORDER=11
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="console=ttyS0,9600 ip=dhcp root=/dev/nfs"
+CONFIG_EXTRA_TARGETS=""
+# CONFIG_HIBERNATION is not set
+# CONFIG_PM_RUNTIME is not set
+CONFIG_SECCOMP=y
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_ZONE_DMA=y
+# CONFIG_NEED_DMA_MAP_STATE is not set
+CONFIG_NEED_SG_DMA_LENGTH=y
+CONFIG_GENERIC_ISA_DMA=y
+CONFIG_PPC_INDIRECT_PCI=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_SYSCALL=y
+# CONFIG_PCIEPORTBUS is not set
+CONFIG_ARCH_SUPPORTS_MSI=y
+# CONFIG_PCI_MSI is not set
+# CONFIG_PCI_DEBUG is not set
+# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
+# CONFIG_PCI_STUB is not set
+# CONFIG_PCI_IOV is not set
+# CONFIG_PCI_PRI is not set
+# CONFIG_PCI_PASID is not set
+
+#
+# PCI host controller drivers
+#
+# CONFIG_PCCARD is not set
+# CONFIG_HOTPLUG_PCI is not set
+# CONFIG_HAS_RAPIDIO is not set
+# CONFIG_RAPIDIO is not set
+# CONFIG_NONSTATIC_KERNEL is not set
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_PAGE_OFFSET=0xc0000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_PHYSICAL_START=0x00000000
+CONFIG_TASK_SIZE=0xc0000000
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_DIAG is not set
+CONFIG_UNIX=y
+# CONFIG_UNIX_DIAG is not set
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
+# CONFIG_XFRM_STATISTICS is not set
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE_DEMUX is not set
+# CONFIG_NET_IP_TUNNEL is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_NET_IPVTI is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_LRO is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_INET_UDP_DIAG is not set
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+CONFIG_NETFILTER_ADVANCED=y
+
+#
+# Core Netfilter Configuration
+#
+# CONFIG_NETFILTER_NETLINK_ACCT is not set
+# CONFIG_NETFILTER_NETLINK_QUEUE is not set
+# CONFIG_NETFILTER_NETLINK_LOG is not set
+CONFIG_NF_CONNTRACK=m
+# CONFIG_NF_CONNTRACK_MARK is not set
+CONFIG_NF_CONNTRACK_PROCFS=y
+# CONFIG_NF_CONNTRACK_EVENTS is not set
+# CONFIG_NF_CONNTRACK_TIMEOUT is not set
+# CONFIG_NF_CONNTRACK_TIMESTAMP is not set
+# CONFIG_NF_CT_PROTO_DCCP is not set
+CONFIG_NF_CT_PROTO_GRE=m
+CONFIG_NF_CT_PROTO_SCTP=m
+# CONFIG_NF_CT_PROTO_UDPLITE is not set
+CONFIG_NF_CONNTRACK_AMANDA=m
+CONFIG_NF_CONNTRACK_FTP=m
+CONFIG_NF_CONNTRACK_H323=m
+CONFIG_NF_CONNTRACK_IRC=m
+CONFIG_NF_CONNTRACK_BROADCAST=m
+CONFIG_NF_CONNTRACK_NETBIOS_NS=m
+# CONFIG_NF_CONNTRACK_SNMP is not set
+CONFIG_NF_CONNTRACK_PPTP=m
+# CONFIG_NF_CONNTRACK_SANE is not set
+CONFIG_NF_CONNTRACK_SIP=m
+CONFIG_NF_CONNTRACK_TFTP=m
+# CONFIG_NF_CT_NETLINK is not set
+# CONFIG_NF_CT_NETLINK_TIMEOUT is not set
+# CONFIG_NETFILTER_TPROXY is not set
+CONFIG_NETFILTER_XTABLES=m
+
+#
+# Xtables combined modules
+#
+# CONFIG_NETFILTER_XT_MARK is not set
+# CONFIG_NETFILTER_XT_CONNMARK is not set
+
+#
+# Xtables targets
+#
+# CONFIG_NETFILTER_XT_TARGET_CHECKSUM is not set
+# CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
+# CONFIG_NETFILTER_XT_TARGET_CONNMARK is not set
+# CONFIG_NETFILTER_XT_TARGET_CT is not set
+# CONFIG_NETFILTER_XT_TARGET_DSCP is not set
+CONFIG_NETFILTER_XT_TARGET_HL=m
+# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
+# CONFIG_NETFILTER_XT_TARGET_IDLETIMER is not set
+# CONFIG_NETFILTER_XT_TARGET_LOG is not set
+# CONFIG_NETFILTER_XT_TARGET_MARK is not set
+# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
+# CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
+# CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
+# CONFIG_NETFILTER_XT_TARGET_RATEEST is not set
+# CONFIG_NETFILTER_XT_TARGET_TEE is not set
+# CONFIG_NETFILTER_XT_TARGET_TRACE is not set
+# CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set
+# CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP is not set
+
+#
+# Xtables matches
+#
+# CONFIG_NETFILTER_XT_MATCH_ADDRTYPE is not set
+# CONFIG_NETFILTER_XT_MATCH_BPF is not set
+# CONFIG_NETFILTER_XT_MATCH_CLUSTER is not set
+# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
+# CONFIG_NETFILTER_XT_MATCH_CONNBYTES is not set
+# CONFIG_NETFILTER_XT_MATCH_CONNLABEL is not set
+# CONFIG_NETFILTER_XT_MATCH_CONNLIMIT is not set
+# CONFIG_NETFILTER_XT_MATCH_CONNMARK is not set
+# CONFIG_NETFILTER_XT_MATCH_CONNTRACK is not set
+# CONFIG_NETFILTER_XT_MATCH_CPU is not set
+# CONFIG_NETFILTER_XT_MATCH_DCCP is not set
+# CONFIG_NETFILTER_XT_MATCH_DEVGROUP is not set
+# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
+# CONFIG_NETFILTER_XT_MATCH_ECN is not set
+# CONFIG_NETFILTER_XT_MATCH_ESP is not set
+# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
+# CONFIG_NETFILTER_XT_MATCH_HELPER is not set
+# CONFIG_NETFILTER_XT_MATCH_HL is not set
+# CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
+# CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
+# CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
+CONFIG_NETFILTER_XT_MATCH_MAC=m
+# CONFIG_NETFILTER_XT_MATCH_MARK is not set
+# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
+# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
+# CONFIG_NETFILTER_XT_MATCH_OWNER is not set
+# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
+CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
+# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
+# CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
+# CONFIG_NETFILTER_XT_MATCH_REALM is not set
+# CONFIG_NETFILTER_XT_MATCH_RECENT is not set
+# CONFIG_NETFILTER_XT_MATCH_SCTP is not set
+CONFIG_NETFILTER_XT_MATCH_STATE=m
+# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
+# CONFIG_NETFILTER_XT_MATCH_STRING is not set
+# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
+# CONFIG_NETFILTER_XT_MATCH_TIME is not set
+# CONFIG_NETFILTER_XT_MATCH_U32 is not set
+# CONFIG_IP_VS is not set
+
+#
+# IP: Netfilter Configuration
+#
+CONFIG_NF_DEFRAG_IPV4=m
+CONFIG_NF_CONNTRACK_IPV4=m
+CONFIG_NF_CONNTRACK_PROC_COMPAT=y
+CONFIG_IP_NF_IPTABLES=m
+# CONFIG_IP_NF_MATCH_AH is not set
+# CONFIG_IP_NF_MATCH_ECN is not set
+# CONFIG_IP_NF_MATCH_RPFILTER is not set
+# CONFIG_IP_NF_MATCH_TTL is not set
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_TARGET_REJECT=m
+# CONFIG_IP_NF_TARGET_ULOG is not set
+# CONFIG_NF_NAT_IPV4 is not set
+CONFIG_IP_NF_MANGLE=m
+# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
+CONFIG_IP_NF_TARGET_ECN=m
+CONFIG_IP_NF_TARGET_TTL=m
+CONFIG_IP_NF_RAW=m
+CONFIG_IP_NF_ARPTABLES=m
+CONFIG_IP_NF_ARPFILTER=m
+CONFIG_IP_NF_ARP_MANGLE=m
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_RDS is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_L2TP is not set
+# CONFIG_BRIDGE is not set
+CONFIG_HAVE_NET_DSA=y
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+CONFIG_LAPB=m
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
+# CONFIG_NET_SCHED is not set
+# CONFIG_DCB is not set
+CONFIG_DNS_RESOLVER=y
+# CONFIG_BATMAN_ADV is not set
+# CONFIG_OPENVSWITCH is not set
+# CONFIG_VSOCKETS is not set
+# CONFIG_NETLINK_MMAP is not set
+# CONFIG_NETLINK_DIAG is not set
+# CONFIG_NET_MPLS_GSO is not set
+CONFIG_NET_RX_BUSY_POLL=y
+CONFIG_BQL=y
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+CONFIG_WIRELESS=y
+# CONFIG_CFG80211 is not set
+# CONFIG_LIB80211 is not set
+
+#
+# CFG80211 needs to be enabled for MAC80211
+#
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+# CONFIG_CAIF is not set
+# CONFIG_CEPH_LIB is not set
+# CONFIG_NFC is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_DEVTMPFS is not set
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+CONFIG_FW_LOADER_USER_HELPER=y
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_GENERIC_CPU_DEVICES is not set
+# CONFIG_DMA_SHARED_BUFFER is not set
+
+#
+# Bus devices
+#
+# CONFIG_CONNECTOR is not set
+CONFIG_MTD=y
+# CONFIG_MTD_TESTS is not set
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_OF_PARTS=y
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_SM_FTL is not set
+# CONFIG_MTD_OOPS is not set
+# CONFIG_MTD_SWAP is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_NOSWAP=y
+# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
+# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
+CONFIG_MTD_CFI_GEOMETRY=y
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+# CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+# CONFIG_MTD_CFI_I2 is not set
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_OTP is not set
+# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_PHYSMAP=y
+# CONFIG_MTD_PHYSMAP_COMPAT is not set
+# CONFIG_MTD_PHYSMAP_OF is not set
+# CONFIG_MTD_INTEL_VR_NOR is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOCG3 is not set
+# CONFIG_MTD_NAND is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# LPDDR flash memory drivers
+#
+# CONFIG_MTD_LPDDR is not set
+# CONFIG_MTD_UBI is not set
+CONFIG_DTC=y
+CONFIG_OF=y
+
+#
+# Device Tree and Open Firmware support
+#
+CONFIG_PROC_DEVICETREE=y
+# CONFIG_OF_SELFTEST is not set
+CONFIG_OF_FLATTREE=y
+CONFIG_OF_EARLY_FLATTREE=y
+CONFIG_OF_ADDRESS=y
+CONFIG_OF_IRQ=y
+CONFIG_OF_I2C=y
+CONFIG_OF_NET=y
+CONFIG_OF_PCI=y
+CONFIG_OF_PCI_IRQ=y
+CONFIG_OF_MTD=y
+CONFIG_PARPORT=m
+CONFIG_PARPORT_PC=m
+# CONFIG_PARPORT_SERIAL is not set
+# CONFIG_PARPORT_PC_FIFO is not set
+# CONFIG_PARPORT_PC_SUPERIO is not set
+# CONFIG_PARPORT_GSC is not set
+# CONFIG_PARPORT_AX88796 is not set
+CONFIG_PARPORT_1284=y
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_PARIDE is not set
+# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_DRBD is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_NVME is not set
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=2
+CONFIG_BLK_DEV_RAM_SIZE=8192
+# CONFIG_BLK_DEV_XIP is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_HD is not set
+# CONFIG_BLK_DEV_RBD is not set
+# CONFIG_BLK_DEV_RSXX is not set
+
+#
+# Misc devices
+#
+# CONFIG_SENSORS_LIS3LV02D is not set
+# CONFIG_AD525X_DPOT is not set
+# CONFIG_DUMMY_IRQ is not set
+# CONFIG_PHANTOM is not set
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+# CONFIG_ICS932S401 is not set
+# CONFIG_ATMEL_SSC is not set
+# CONFIG_ENCLOSURE_SERVICES is not set
+# CONFIG_HP_ILO is not set
+# CONFIG_APDS9802ALS is not set
+# CONFIG_ISL29003 is not set
+# CONFIG_ISL29020 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_SENSORS_BH1780 is not set
+# CONFIG_SENSORS_BH1770 is not set
+# CONFIG_SENSORS_APDS990X is not set
+# CONFIG_HMC6352 is not set
+# CONFIG_DS1682 is not set
+# CONFIG_BMP085_I2C is not set
+# CONFIG_PCH_PHUB is not set
+# CONFIG_USB_SWITCH_FSA9480 is not set
+# CONFIG_SRAM is not set
+# CONFIG_C2PORT is not set
+
+#
+# EEPROM support
+#
+# CONFIG_EEPROM_AT24 is not set
+CONFIG_EEPROM_LEGACY=m
+# CONFIG_EEPROM_MAX6875 is not set
+# CONFIG_EEPROM_93CX6 is not set
+# CONFIG_CB710_CORE is not set
+
+#
+# Texas Instruments shared transport line discipline
+#
+# CONFIG_SENSORS_LIS3_I2C is not set
+
+#
+# Altera FPGA firmware download module
+#
+# CONFIG_ALTERA_STAPL is not set
+CONFIG_HAVE_IDE=y
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+CONFIG_SCSI_MOD=y
+# CONFIG_RAID_ATTRS is not set
+CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
+# CONFIG_SCSI_TGT is not set
+# CONFIG_SCSI_NETLINK is not set
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=y
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+# CONFIG_BLK_DEV_SR is not set
+CONFIG_CHR_DEV_SG=y
+# CONFIG_CHR_DEV_SCH is not set
+CONFIG_SCSI_MULTI_LUN=y
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
+
+#
+# SCSI Transports
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
+CONFIG_SCSI_LOWLEVEL=y
+# CONFIG_ISCSI_TCP is not set
+# CONFIG_ISCSI_BOOT_SYSFS is not set
+# CONFIG_SCSI_CXGB3_ISCSI is not set
+# CONFIG_SCSI_CXGB4_ISCSI is not set
+# CONFIG_SCSI_BNX2_ISCSI is not set
+# CONFIG_SCSI_BNX2X_FCOE is not set
+# CONFIG_BE2ISCSI is not set
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_HPSA is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_3W_SAS is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC94XX is not set
+# CONFIG_SCSI_MVSAS is not set
+# CONFIG_SCSI_MVUMI is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_ADVANSYS is not set
+# CONFIG_SCSI_ARCMSR is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_MEGARAID_SAS is not set
+# CONFIG_SCSI_MPT2SAS is not set
+# CONFIG_SCSI_MPT3SAS is not set
+# CONFIG_SCSI_UFSHCD is not set
+# CONFIG_SCSI_HPTIOP is not set
+# CONFIG_SCSI_BUSLOGIC is not set
+# CONFIG_LIBFC is not set
+# CONFIG_LIBFCOE is not set
+# CONFIG_FCOE is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_EATA is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_GDTH is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_PPA is not set
+# CONFIG_SCSI_IMM is not set
+# CONFIG_SCSI_STEX is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_IPR is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+# CONFIG_SCSI_QLA_FC is not set
+# CONFIG_SCSI_QLA_ISCSI is not set
+# CONFIG_SCSI_LPFC is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_NSP32 is not set
+# CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_PMCRAID is not set
+# CONFIG_SCSI_PM8001 is not set
+# CONFIG_SCSI_SRP is not set
+# CONFIG_SCSI_BFA_FC is not set
+# CONFIG_SCSI_CHELSIO_FCOE is not set
+# CONFIG_SCSI_DH is not set
+# CONFIG_SCSI_OSD_INITIATOR is not set
+CONFIG_ATA=y
+# CONFIG_ATA_NONSTANDARD is not set
+CONFIG_ATA_VERBOSE_ERROR=y
+CONFIG_SATA_PMP=y
+
+#
+# Controllers with non-SFF native interface
+#
+# CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_AHCI_PLATFORM is not set
+# CONFIG_SATA_INIC162X is not set
+# CONFIG_SATA_ACARD_AHCI is not set
+# CONFIG_SATA_SIL24 is not set
+CONFIG_ATA_SFF=y
+
+#
+# SFF controllers with custom DMA interface
+#
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_SX4 is not set
+CONFIG_ATA_BMDMA=y
+
+#
+# SATA SFF controllers with BMDMA
+#
+# CONFIG_ATA_PIIX is not set
+# CONFIG_SATA_HIGHBANK is not set
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_RCAR is not set
+# CONFIG_SATA_SIL is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_SVW is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
+
+#
+# PATA SFF controllers with BMDMA
+#
+# CONFIG_PATA_ALI is not set
+# CONFIG_PATA_AMD is not set
+# CONFIG_PATA_ARTOP is not set
+# CONFIG_PATA_ATIIXP is not set
+# CONFIG_PATA_ATP867X is not set
+# CONFIG_PATA_CMD64X is not set
+# CONFIG_PATA_CS5520 is not set
+# CONFIG_PATA_CS5530 is not set
+# CONFIG_PATA_CS5536 is not set
+# CONFIG_PATA_CYPRESS is not set
+# CONFIG_PATA_EFAR is not set
+# CONFIG_PATA_HPT366 is not set
+# CONFIG_PATA_HPT37X is not set
+# CONFIG_PATA_HPT3X2N is not set
+# CONFIG_PATA_HPT3X3 is not set
+# CONFIG_PATA_IT8213 is not set
+CONFIG_PATA_IT821X=y
+# CONFIG_PATA_JMICRON is not set
+# CONFIG_PATA_MARVELL is not set
+# CONFIG_PATA_NETCELL is not set
+# CONFIG_PATA_NINJA32 is not set
+# CONFIG_PATA_NS87415 is not set
+# CONFIG_PATA_OLDPIIX is not set
+# CONFIG_PATA_OPTIDMA is not set
+# CONFIG_PATA_PDC2027X is not set
+# CONFIG_PATA_PDC_OLD is not set
+# CONFIG_PATA_RADISYS is not set
+# CONFIG_PATA_RDC is not set
+# CONFIG_PATA_SC1200 is not set
+# CONFIG_PATA_SCH is not set
+# CONFIG_PATA_SERVERWORKS is not set
+CONFIG_PATA_SIL680=y
+# CONFIG_PATA_SIS is not set
+# CONFIG_PATA_TOSHIBA is not set
+# CONFIG_PATA_TRIFLEX is not set
+# CONFIG_PATA_VIA is not set
+# CONFIG_PATA_WINBOND is not set
+
+#
+# PIO-only SFF controllers
+#
+# CONFIG_PATA_CMD640_PCI is not set
+# CONFIG_PATA_MPIIX is not set
+# CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_OPTI is not set
+# CONFIG_PATA_PLATFORM is not set
+# CONFIG_PATA_RZ1000 is not set
+
+#
+# Generic fallback / legacy drivers
+#
+# CONFIG_ATA_GENERIC is not set
+# CONFIG_PATA_LEGACY is not set
+# CONFIG_MD is not set
+# CONFIG_TARGET_CORE is not set
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_FIREWIRE is not set
+# CONFIG_FIREWIRE_NOSY is not set
+# CONFIG_I2O is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
+CONFIG_NETDEVICES=y
+CONFIG_MII=y
+CONFIG_NET_CORE=y
+# CONFIG_BONDING is not set
+# CONFIG_DUMMY is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_NET_FC is not set
+# CONFIG_NET_TEAM is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_VXLAN is not set
+CONFIG_NETCONSOLE=y
+CONFIG_NETPOLL=y
+# CONFIG_NETPOLL_TRAP is not set
+CONFIG_NET_POLL_CONTROLLER=y
+CONFIG_TUN=m
+# CONFIG_VETH is not set
+# CONFIG_NLMON is not set
+# CONFIG_ARCNET is not set
+
+#
+# CAIF transport drivers
+#
+
+#
+# Distributed Switch Architecture drivers
+#
+# CONFIG_NET_DSA_MV88E6XXX is not set
+# CONFIG_NET_DSA_MV88E6060 is not set
+# CONFIG_NET_DSA_MV88E6XXX_NEED_PPU is not set
+# CONFIG_NET_DSA_MV88E6131 is not set
+# CONFIG_NET_DSA_MV88E6123_61_65 is not set
+CONFIG_ETHERNET=y
+# CONFIG_NET_VENDOR_3COM is not set
+CONFIG_NET_VENDOR_ADAPTEC=y
+# CONFIG_ADAPTEC_STARFIRE is not set
+CONFIG_NET_VENDOR_ALTEON=y
+# CONFIG_ACENIC is not set
+CONFIG_NET_VENDOR_AMD=y
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_PCNET32 is not set
+CONFIG_NET_VENDOR_ARC=y
+# CONFIG_ARC_EMAC is not set
+CONFIG_NET_VENDOR_ATHEROS=y
+# CONFIG_ATL2 is not set
+# CONFIG_ATL1 is not set
+# CONFIG_ATL1E is not set
+# CONFIG_ATL1C is not set
+# CONFIG_ALX is not set
+CONFIG_NET_CADENCE=y
+# CONFIG_ARM_AT91_ETHER is not set
+# CONFIG_MACB is not set
+CONFIG_NET_VENDOR_BROADCOM=y
+# CONFIG_B44 is not set
+# CONFIG_BNX2 is not set
+# CONFIG_CNIC is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2X is not set
+CONFIG_NET_VENDOR_BROCADE=y
+# CONFIG_BNA is not set
+# CONFIG_NET_CALXEDA_XGMAC is not set
+CONFIG_NET_VENDOR_CHELSIO=y
+# CONFIG_CHELSIO_T1 is not set
+# CONFIG_CHELSIO_T3 is not set
+# CONFIG_CHELSIO_T4 is not set
+# CONFIG_CHELSIO_T4VF is not set
+CONFIG_NET_VENDOR_CISCO=y
+# CONFIG_ENIC is not set
+# CONFIG_DNET is not set
+CONFIG_NET_VENDOR_DEC=y
+# CONFIG_NET_TULIP is not set
+CONFIG_NET_VENDOR_DLINK=y
+# CONFIG_DL2K is not set
+# CONFIG_SUNDANCE is not set
+CONFIG_NET_VENDOR_EMULEX=y
+# CONFIG_BE2NET is not set
+CONFIG_NET_VENDOR_EXAR=y
+# CONFIG_S2IO is not set
+# CONFIG_VXGE is not set
+CONFIG_NET_VENDOR_HP=y
+# CONFIG_HP100 is not set
+CONFIG_NET_VENDOR_INTEL=y
+CONFIG_E100=y
+# CONFIG_E1000 is not set
+# CONFIG_E1000E is not set
+# CONFIG_IGB is not set
+# CONFIG_IGBVF is not set
+# CONFIG_IXGB is not set
+# CONFIG_IXGBE is not set
+CONFIG_NET_VENDOR_I825XX=y
+# CONFIG_IP1000 is not set
+# CONFIG_JME is not set
+CONFIG_NET_VENDOR_MARVELL=y
+# CONFIG_MV643XX_ETH is not set
+# CONFIG_MVMDIO is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+CONFIG_NET_VENDOR_MELLANOX=y
+# CONFIG_MLX4_EN is not set
+# CONFIG_MLX4_CORE is not set
+CONFIG_NET_VENDOR_MICREL=y
+# CONFIG_KS8851_MLL is not set
+# CONFIG_KSZ884X_PCI is not set
+CONFIG_NET_VENDOR_MYRI=y
+# CONFIG_MYRI10GE is not set
+# CONFIG_FEALNX is not set
+CONFIG_NET_VENDOR_NATSEMI=y
+# CONFIG_NATSEMI is not set
+# CONFIG_NS83820 is not set
+CONFIG_NET_VENDOR_8390=y
+# CONFIG_NE2K_PCI is not set
+CONFIG_NET_VENDOR_NVIDIA=y
+# CONFIG_FORCEDETH is not set
+CONFIG_NET_VENDOR_OKI=y
+# CONFIG_ETHOC is not set
+CONFIG_NET_PACKET_ENGINE=y
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+CONFIG_NET_VENDOR_QLOGIC=y
+# CONFIG_QLA3XXX is not set
+# CONFIG_QLCNIC is not set
+# CONFIG_QLGE is not set
+# CONFIG_NETXEN_NIC is not set
+CONFIG_NET_VENDOR_REALTEK=y
+# CONFIG_8139CP is not set
+# CONFIG_8139TOO is not set
+CONFIG_R8169=y
+# CONFIG_SH_ETH is not set
+CONFIG_NET_VENDOR_RDC=y
+# CONFIG_R6040 is not set
+CONFIG_NET_VENDOR_SEEQ=y
+CONFIG_NET_VENDOR_SILAN=y
+# CONFIG_SC92031 is not set
+CONFIG_NET_VENDOR_SIS=y
+# CONFIG_SIS900 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SFC is not set
+CONFIG_NET_VENDOR_SMSC=y
+# CONFIG_EPIC100 is not set
+# CONFIG_SMSC911X is not set
+# CONFIG_SMSC9420 is not set
+CONFIG_NET_VENDOR_STMICRO=y
+# CONFIG_STMMAC_ETH is not set
+CONFIG_NET_VENDOR_SUN=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NIU is not set
+CONFIG_NET_VENDOR_TEHUTI=y
+# CONFIG_TEHUTI is not set
+CONFIG_NET_VENDOR_TI=y
+# CONFIG_TLAN is not set
+CONFIG_NET_VENDOR_VIA=y
+# CONFIG_VIA_RHINE is not set
+# CONFIG_VIA_VELOCITY is not set
+CONFIG_NET_VENDOR_WIZNET=y
+# CONFIG_WIZNET_W5100 is not set
+# CONFIG_WIZNET_W5300 is not set
+CONFIG_NET_VENDOR_XILINX=y
+# CONFIG_XILINX_EMACLITE is not set
+# CONFIG_XILINX_LL_TEMAC is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PHYLIB is not set
+# CONFIG_PLIP is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_RTL8152 is not set
+# CONFIG_USB_USBNET is not set
+# CONFIG_USB_IPHETH is not set
+# CONFIG_WLAN is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
+CONFIG_WAN=y
+# CONFIG_LANMEDIA is not set
+CONFIG_HDLC=m
+CONFIG_HDLC_RAW=m
+CONFIG_HDLC_RAW_ETH=m
+CONFIG_HDLC_CISCO=m
+CONFIG_HDLC_FR=m
+CONFIG_HDLC_PPP=m
+CONFIG_HDLC_X25=m
+# CONFIG_PCI200SYN is not set
+# CONFIG_WANXL is not set
+# CONFIG_PC300TOO is not set
+# CONFIG_FARSYNC is not set
+# CONFIG_DSCC4 is not set
+CONFIG_DLCI=m
+CONFIG_DLCI_MAX=8
+# CONFIG_VMXNET3 is not set
+# CONFIG_ISDN is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
+# CONFIG_INPUT_MATRIXKMAP is not set
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+CONFIG_INPUT_EVDEV=m
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+CONFIG_INPUT_MISC=y
+# CONFIG_INPUT_AD714X is not set
+# CONFIG_INPUT_BMA150 is not set
+# CONFIG_INPUT_MMA8450 is not set
+# CONFIG_INPUT_MPU3050 is not set
+# CONFIG_INPUT_ATI_REMOTE2 is not set
+# CONFIG_INPUT_KEYSPAN_REMOTE is not set
+# CONFIG_INPUT_KXTJ9 is not set
+# CONFIG_INPUT_POWERMATE is not set
+# CONFIG_INPUT_YEALINK is not set
+# CONFIG_INPUT_CM109 is not set
+CONFIG_INPUT_UINPUT=m
+# CONFIG_INPUT_PCF8574 is not set
+# CONFIG_INPUT_ADXL34X is not set
+# CONFIG_INPUT_CMA3000 is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_PARKBD is not set
+# CONFIG_SERIO_PCIPS2 is not set
+# CONFIG_SERIO_RAW is not set
+# CONFIG_SERIO_XILINX_XPS_PS2 is not set
+# CONFIG_SERIO_ALTERA_PS2 is not set
+# CONFIG_SERIO_PS2MULT is not set
+# CONFIG_SERIO_ARC_PS2 is not set
+# CONFIG_SERIO_APBPS2 is not set
+# CONFIG_SERIO_OLPC_APSP is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+CONFIG_TTY=y
+CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
+CONFIG_UNIX98_PTYS=y
+# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_NOZOMI is not set
+# CONFIG_N_GSM is not set
+# CONFIG_TRACE_SINK is not set
+# CONFIG_PPC_EPAPR_HV_BYTECHAN is not set
+CONFIG_DEVKMEM=y
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_PCI=y
+CONFIG_SERIAL_8250_NR_UARTS=10
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_MANY_PORTS=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+# CONFIG_SERIAL_8250_DETECT_IRQ is not set
+# CONFIG_SERIAL_8250_RSA is not set
+# CONFIG_SERIAL_8250_DW is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_MFD_HSU is not set
+# CONFIG_SERIAL_UARTLITE is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_SERIAL_SCCNXP is not set
+# CONFIG_SERIAL_TIMBERDALE is not set
+# CONFIG_SERIAL_ALTERA_JTAGUART is not set
+# CONFIG_SERIAL_ALTERA_UART is not set
+# CONFIG_SERIAL_PCH_UART is not set
+# CONFIG_SERIAL_XILINX_PS_UART is not set
+# CONFIG_SERIAL_ARC is not set
+# CONFIG_SERIAL_RP2 is not set
+# CONFIG_SERIAL_FSL_LPUART is not set
+# CONFIG_PRINTER is not set
+CONFIG_PPDEV=m
+# CONFIG_HVC_UDBG is not set
+# CONFIG_IPMI_HANDLER is not set
+CONFIG_HW_RANDOM=y
+# CONFIG_HW_RANDOM_TIMERIOMEM is not set
+# CONFIG_NVRAM is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_DEVPORT=y
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_COMPAT=y
+CONFIG_I2C_CHARDEV=y
+# CONFIG_I2C_MUX is not set
+CONFIG_I2C_HELPER_AUTO=y
+
+#
+# I2C Hardware Bus support
+#
+
+#
+# PC SMBus host controller drivers
+#
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_ISCH is not set
+# CONFIG_I2C_PIIX4 is not set
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
+# CONFIG_I2C_DESIGNWARE_PCI is not set
+# CONFIG_I2C_EG20T is not set
+CONFIG_I2C_MPC=y
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_PCA_PLATFORM is not set
+# CONFIG_I2C_PXA_PCI is not set
+# CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_XILINX is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_DIOLAN_U2C is not set
+# CONFIG_I2C_PARPORT is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_TAOS_EVM is not set
+# CONFIG_I2C_TINY_USB is not set
+
+#
+# Other I2C/SMBus bus drivers
+#
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_SPI is not set
+# CONFIG_HSI is not set
+
+#
+# PPS support
+#
+# CONFIG_PPS is not set
+
+#
+# PPS generators support
+#
+
+#
+# PTP clock support
+#
+# CONFIG_PTP_1588_CLOCK is not set
+
+#
+# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional 
clocks.
+#
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
+CONFIG_GPIO_DEVRES=y
+# CONFIG_GPIOLIB is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_POWER_AVS is not set
+CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
+
+#
+# Native drivers
+#
+# CONFIG_SENSORS_AD7414 is not set
+# CONFIG_SENSORS_AD7418 is not set
+# CONFIG_SENSORS_ADM1021 is not set
+# CONFIG_SENSORS_ADM1025 is not set
+# CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1029 is not set
+# CONFIG_SENSORS_ADM1031 is not set
+# CONFIG_SENSORS_ADM9240 is not set
+# CONFIG_SENSORS_ADT7410 is not set
+# CONFIG_SENSORS_ADT7411 is not set
+# CONFIG_SENSORS_ADT7462 is not set
+# CONFIG_SENSORS_ADT7470 is not set
+# CONFIG_SENSORS_ADT7475 is not set
+# CONFIG_SENSORS_ASC7621 is not set
+# CONFIG_SENSORS_ATXP1 is not set
+# CONFIG_SENSORS_DS620 is not set
+# CONFIG_SENSORS_DS1621 is not set
+# CONFIG_SENSORS_I5K_AMB is not set
+# CONFIG_SENSORS_F75375S is not set
+# CONFIG_SENSORS_G760A is not set
+# CONFIG_SENSORS_G762 is not set
+# CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_GL520SM is not set
+# CONFIG_SENSORS_HIH6130 is not set
+# CONFIG_SENSORS_JC42 is not set
+# CONFIG_SENSORS_LINEAGE is not set
+# CONFIG_SENSORS_LM63 is not set
+# CONFIG_SENSORS_LM73 is not set
+# CONFIG_SENSORS_LM75 is not set
+# CONFIG_SENSORS_LM77 is not set
+# CONFIG_SENSORS_LM78 is not set
+# CONFIG_SENSORS_LM80 is not set
+# CONFIG_SENSORS_LM83 is not set
+# CONFIG_SENSORS_LM85 is not set
+# CONFIG_SENSORS_LM87 is not set
+# CONFIG_SENSORS_LM90 is not set
+# CONFIG_SENSORS_LM92 is not set
+# CONFIG_SENSORS_LM93 is not set
+# CONFIG_SENSORS_LTC4151 is not set
+# CONFIG_SENSORS_LTC4215 is not set
+# CONFIG_SENSORS_LTC4245 is not set
+# CONFIG_SENSORS_LTC4261 is not set
+# CONFIG_SENSORS_LM95234 is not set
+# CONFIG_SENSORS_LM95241 is not set
+# CONFIG_SENSORS_LM95245 is not set
+# CONFIG_SENSORS_MAX16065 is not set
+# CONFIG_SENSORS_MAX1619 is not set
+# CONFIG_SENSORS_MAX1668 is not set
+# CONFIG_SENSORS_MAX197 is not set
+# CONFIG_SENSORS_MAX6639 is not set
+# CONFIG_SENSORS_MAX6642 is not set
+# CONFIG_SENSORS_MAX6650 is not set
+# CONFIG_SENSORS_MAX6697 is not set
+# CONFIG_SENSORS_MCP3021 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_PMBUS is not set
+# CONFIG_SENSORS_SHT21 is not set
+# CONFIG_SENSORS_SIS5595 is not set
+# CONFIG_SENSORS_SMM665 is not set
+# CONFIG_SENSORS_EMC1403 is not set
+# CONFIG_SENSORS_EMC2103 is not set
+# CONFIG_SENSORS_EMC6W201 is not set
+# CONFIG_SENSORS_SMSC47M192 is not set
+# CONFIG_SENSORS_SCH56XX_COMMON is not set
+# CONFIG_SENSORS_ADS1015 is not set
+# CONFIG_SENSORS_ADS7828 is not set
+# CONFIG_SENSORS_AMC6821 is not set
+# CONFIG_SENSORS_INA209 is not set
+# CONFIG_SENSORS_INA2XX is not set
+# CONFIG_SENSORS_THMC50 is not set
+# CONFIG_SENSORS_TMP102 is not set
+# CONFIG_SENSORS_TMP401 is not set
+# CONFIG_SENSORS_TMP421 is not set
+# CONFIG_SENSORS_VIA686A is not set
+# CONFIG_SENSORS_VT8231 is not set
+# CONFIG_SENSORS_W83781D is not set
+# CONFIG_SENSORS_W83791D is not set
+# CONFIG_SENSORS_W83792D is not set
+# CONFIG_SENSORS_W83793 is not set
+# CONFIG_SENSORS_W83795 is not set
+# CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83L786NG is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
+
+#
+# Sonics Silicon Backplane
+#
+# CONFIG_SSB is not set
+CONFIG_BCMA_POSSIBLE=y
+
+#
+# Broadcom specific AMBA
+#
+# CONFIG_BCMA is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_AS3711 is not set
+# CONFIG_PMIC_ADP5520 is not set
+# CONFIG_MFD_CROS_EC is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_MFD_DA9052_I2C is not set
+# CONFIG_MFD_DA9055 is not set
+# CONFIG_MFD_MC13XXX_I2C is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_LPC_ICH is not set
+# CONFIG_LPC_SCH is not set
+# CONFIG_MFD_JANZ_CMODIO is not set
+# CONFIG_MFD_KEMPLD is not set
+# CONFIG_MFD_88PM800 is not set
+# CONFIG_MFD_88PM805 is not set
+# CONFIG_MFD_88PM860X is not set
+# CONFIG_MFD_MAX77686 is not set
+# CONFIG_MFD_MAX77693 is not set
+# CONFIG_MFD_MAX8907 is not set
+# CONFIG_MFD_MAX8925 is not set
+# CONFIG_MFD_MAX8997 is not set
+# CONFIG_MFD_MAX8998 is not set
+# CONFIG_MFD_VIPERBOARD is not set
+# CONFIG_MFD_RETU is not set
+# CONFIG_MFD_PCF50633 is not set
+# CONFIG_MFD_RDC321X is not set
+# CONFIG_MFD_RTSX_PCI is not set
+# CONFIG_MFD_RC5T583 is not set
+# CONFIG_MFD_SEC_CORE is not set
+# CONFIG_MFD_SI476X_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_MFD_SMSC is not set
+# CONFIG_ABX500_CORE is not set
+# CONFIG_MFD_STMPE is not set
+# CONFIG_MFD_SYSCON is not set
+# CONFIG_MFD_TI_AM335X_TSCADC is not set
+# CONFIG_MFD_LP8788 is not set
+# CONFIG_MFD_PALMAS is not set
+# CONFIG_TPS6105X is not set
+# CONFIG_TPS6507X is not set
+# CONFIG_MFD_TPS65090 is not set
+# CONFIG_MFD_TPS65217 is not set
+# CONFIG_MFD_TPS6586X is not set
+# CONFIG_MFD_TPS80031 is not set
+# CONFIG_TWL4030_CORE is not set
+# CONFIG_TWL6040_CORE is not set
+# CONFIG_MFD_WL1273_CORE is not set
+# CONFIG_MFD_LM3533 is not set
+# CONFIG_MFD_TC3589X is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_MFD_VX855 is not set
+# CONFIG_MFD_ARIZONA_I2C is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM831X_I2C is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_WM8994 is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
+
+#
+# Graphics support
+#
+# CONFIG_AGP is not set
+CONFIG_VGA_ARB=y
+CONFIG_VGA_ARB_MAX_GPUS=16
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=m
+# CONFIG_FB is not set
+# CONFIG_EXYNOS_VIDEO is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+CONFIG_SOUND=m
+# CONFIG_SOUND_OSS_CORE is not set
+CONFIG_SND=m
+CONFIG_SND_TIMER=m
+CONFIG_SND_PCM=m
+CONFIG_SND_HWDEP=m
+CONFIG_SND_RAWMIDI=m
+# CONFIG_SND_SEQUENCER is not set
+# CONFIG_SND_MIXER_OSS is not set
+# CONFIG_SND_PCM_OSS is not set
+# CONFIG_SND_HRTIMER is not set
+# CONFIG_SND_DYNAMIC_MINORS is not set
+CONFIG_SND_SUPPORT_OLD_API=y
+CONFIG_SND_VERBOSE_PROCFS=y
+# CONFIG_SND_VERBOSE_PRINTK is not set
+# CONFIG_SND_DEBUG is not set
+CONFIG_SND_VMASTER=y
+# CONFIG_SND_RAWMIDI_SEQ is not set
+# CONFIG_SND_OPL3_LIB_SEQ is not set
+# CONFIG_SND_OPL4_LIB_SEQ is not set
+# CONFIG_SND_SBAWE_SEQ is not set
+# CONFIG_SND_EMU10K1_SEQ is not set
+CONFIG_SND_MPU401_UART=m
+CONFIG_SND_OPL3_LIB=m
+CONFIG_SND_AC97_CODEC=m
+CONFIG_SND_DRIVERS=y
+CONFIG_SND_DUMMY=m
+# CONFIG_SND_ALOOP is not set
+# CONFIG_SND_MTPAV is not set
+# CONFIG_SND_MTS64 is not set
+# CONFIG_SND_SERIAL_U16550 is not set
+# CONFIG_SND_MPU401 is not set
+# CONFIG_SND_PORTMAN2X4 is not set
+# CONFIG_SND_AC97_POWER_SAVE is not set
+CONFIG_SND_PCI=y
+# CONFIG_SND_AD1889 is not set
+# CONFIG_SND_ALS300 is not set
+# CONFIG_SND_ALS4000 is not set
+# CONFIG_SND_ALI5451 is not set
+# CONFIG_SND_ATIIXP is not set
+# CONFIG_SND_ATIIXP_MODEM is not set
+# CONFIG_SND_AU8810 is not set
+# CONFIG_SND_AU8820 is not set
+# CONFIG_SND_AU8830 is not set
+# CONFIG_SND_AW2 is not set
+# CONFIG_SND_AZT3328 is not set
+# CONFIG_SND_BT87X is not set
+# CONFIG_SND_CA0106 is not set
+# CONFIG_SND_CMIPCI is not set
+# CONFIG_SND_OXYGEN is not set
+# CONFIG_SND_CS4281 is not set
+# CONFIG_SND_CS46XX is not set
+# CONFIG_SND_CS5530 is not set
+# CONFIG_SND_CS5535AUDIO is not set
+# CONFIG_SND_CTXFI is not set
+# CONFIG_SND_DARLA20 is not set
+# CONFIG_SND_GINA20 is not set
+# CONFIG_SND_LAYLA20 is not set
+# CONFIG_SND_DARLA24 is not set
+# CONFIG_SND_GINA24 is not set
+# CONFIG_SND_LAYLA24 is not set
+# CONFIG_SND_MONA is not set
+# CONFIG_SND_MIA is not set
+# CONFIG_SND_ECHO3G is not set
+# CONFIG_SND_INDIGO is not set
+# CONFIG_SND_INDIGOIO is not set
+# CONFIG_SND_INDIGODJ is not set
+# CONFIG_SND_INDIGOIOX is not set
+# CONFIG_SND_INDIGODJX is not set
+# CONFIG_SND_EMU10K1 is not set
+# CONFIG_SND_EMU10K1X is not set
+# CONFIG_SND_ENS1370 is not set
+# CONFIG_SND_ENS1371 is not set
+CONFIG_SND_ES1938=m
+CONFIG_SND_ES1968=m
+# CONFIG_SND_ES1968_INPUT is not set
+# CONFIG_SND_FM801 is not set
+# CONFIG_SND_HDA_INTEL is not set
+# CONFIG_SND_HDSP is not set
+# CONFIG_SND_HDSPM is not set
+# CONFIG_SND_ICE1712 is not set
+# CONFIG_SND_ICE1724 is not set
+# CONFIG_SND_INTEL8X0 is not set
+# CONFIG_SND_INTEL8X0M is not set
+# CONFIG_SND_KORG1212 is not set
+# CONFIG_SND_LOLA is not set
+# CONFIG_SND_LX6464ES is not set
+# CONFIG_SND_MAESTRO3 is not set
+# CONFIG_SND_MIXART is not set
+# CONFIG_SND_NM256 is not set
+# CONFIG_SND_PCXHR is not set
+# CONFIG_SND_RIPTIDE is not set
+# CONFIG_SND_RME32 is not set
+# CONFIG_SND_RME96 is not set
+# CONFIG_SND_RME9652 is not set
+# CONFIG_SND_SONICVIBES is not set
+# CONFIG_SND_TRIDENT is not set
+# CONFIG_SND_VIA82XX is not set
+# CONFIG_SND_VIA82XX_MODEM is not set
+# CONFIG_SND_VIRTUOSO is not set
+# CONFIG_SND_VX222 is not set
+# CONFIG_SND_YMFPCI is not set
+# CONFIG_SND_PPC is not set
+# CONFIG_SND_USB is not set
+# CONFIG_SND_SOC is not set
+# CONFIG_SOUND_PRIME is not set
+CONFIG_AC97_BUS=m
+
+#
+# HID support
+#
+CONFIG_HID=m
+# CONFIG_HIDRAW is not set
+# CONFIG_UHID is not set
+CONFIG_HID_GENERIC=m
+
+#
+# Special HID drivers
+#
+CONFIG_HID_A4TECH=m
+# CONFIG_HID_ACRUX is not set
+CONFIG_HID_APPLE=m
+# CONFIG_HID_AUREAL is not set
+CONFIG_HID_BELKIN=m
+CONFIG_HID_CHERRY=m
+CONFIG_HID_CHICONY=m
+# CONFIG_HID_PRODIKEYS is not set
+CONFIG_HID_CYPRESS=m
+# CONFIG_HID_DRAGONRISE is not set
+# CONFIG_HID_EMS_FF is not set
+# CONFIG_HID_ELECOM is not set
+CONFIG_HID_EZKEY=m
+# CONFIG_HID_KEYTOUCH is not set
+# CONFIG_HID_KYE is not set
+# CONFIG_HID_UCLOGIC is not set
+# CONFIG_HID_WALTOP is not set
+# CONFIG_HID_GYRATION is not set
+# CONFIG_HID_ICADE is not set
+# CONFIG_HID_TWINHAN is not set
+CONFIG_HID_KENSINGTON=m
+# CONFIG_HID_LCPOWER is not set
+CONFIG_HID_LOGITECH=m
+# CONFIG_HID_LOGITECH_DJ is not set
+# CONFIG_LOGITECH_FF is not set
+# CONFIG_LOGIRUMBLEPAD2_FF is not set
+# CONFIG_LOGIG940_FF is not set
+# CONFIG_LOGIWHEELS_FF is not set
+# CONFIG_HID_MAGICMOUSE is not set
+CONFIG_HID_MICROSOFT=m
+CONFIG_HID_MONTEREY=m
+# CONFIG_HID_MULTITOUCH is not set
+# CONFIG_HID_ORTEK is not set
+# CONFIG_HID_PANTHERLORD is not set
+# CONFIG_HID_PETALYNX is not set
+# CONFIG_HID_PICOLCD is not set
+# CONFIG_HID_PRIMAX is not set
+# CONFIG_HID_SAITEK is not set
+# CONFIG_HID_SAMSUNG is not set
+# CONFIG_HID_SPEEDLINK is not set
+# CONFIG_HID_STEELSERIES is not set
+# CONFIG_HID_SUNPLUS is not set
+# CONFIG_HID_GREENASIA is not set
+# CONFIG_HID_SMARTJOYPLUS is not set
+# CONFIG_HID_TIVO is not set
+# CONFIG_HID_TOPSEED is not set
+# CONFIG_HID_THRUSTMASTER is not set
+# CONFIG_HID_ZEROPLUS is not set
+# CONFIG_HID_ZYDACRON is not set
+# CONFIG_HID_SENSOR_HUB is not set
+
+#
+# USB HID support
+#
+# CONFIG_USB_HID is not set
+# CONFIG_HID_PID is not set
+
+#
+# I2C HID support
+#
+# CONFIG_I2C_HID is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_COMMON=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEFAULT_PERSIST=y
+# CONFIG_USB_DYNAMIC_MINORS is not set
+CONFIG_USB_MON=y
+# CONFIG_USB_WUSB_CBAF is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_C67X00_HCD is not set
+# CONFIG_USB_XHCI_HCD is not set
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+CONFIG_USB_EHCI_PCI=y
+# CONFIG_XPS_USB_HCD_XILINX is not set
+CONFIG_USB_EHCI_HCD_PPC_OF=y
+# CONFIG_USB_EHCI_HCD_PLATFORM is not set
+# CONFIG_USB_OXU210HP_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
+# CONFIG_USB_ISP1362_HCD is not set
+# CONFIG_USB_FUSBH200_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
+# CONFIG_USB_OHCI_HCD_PPC_OF_LE is not set
+CONFIG_USB_OHCI_HCD_PPC_OF=y
+CONFIG_USB_OHCI_HCD_PCI=y
+# CONFIG_USB_OHCI_HCD_PLATFORM is not set
+CONFIG_USB_OHCI_BIG_ENDIAN_DESC=y
+CONFIG_USB_OHCI_BIG_ENDIAN_MMIO=y
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+CONFIG_USB_PRINTER=m
+# CONFIG_USB_WDM is not set
+# CONFIG_USB_TMC is not set
+
+#
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
+#
+
+#
+# also be needed; see USB_STORAGE Help for more info
+#
+CONFIG_USB_STORAGE=m
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_REALTEK is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_ONETOUCH is not set
+# CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
+# CONFIG_USB_STORAGE_ENE_UB6250 is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+# CONFIG_USB_DWC3 is not set
+# CONFIG_USB_CHIPIDEA is not set
+
+#
+# USB port drivers
+#
+# CONFIG_USB_USS720 is not set
+CONFIG_USB_SERIAL=y
+CONFIG_USB_SERIAL_CONSOLE=y
+# CONFIG_USB_SERIAL_GENERIC is not set
+# CONFIG_USB_SERIAL_AIRCABLE is not set
+# CONFIG_USB_SERIAL_ARK3116 is not set
+# CONFIG_USB_SERIAL_BELKIN is not set
+# CONFIG_USB_SERIAL_CH341 is not set
+# CONFIG_USB_SERIAL_WHITEHEAT is not set
+# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
+# CONFIG_USB_SERIAL_CP210X is not set
+# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
+# CONFIG_USB_SERIAL_EMPEG is not set
+CONFIG_USB_SERIAL_FTDI_SIO=y
+# CONFIG_USB_SERIAL_FUNSOFT is not set
+# CONFIG_USB_SERIAL_VISOR is not set
+# CONFIG_USB_SERIAL_IPAQ is not set
+# CONFIG_USB_SERIAL_IR is not set
+# CONFIG_USB_SERIAL_EDGEPORT is not set
+# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
+# CONFIG_USB_SERIAL_F81232 is not set
+# CONFIG_USB_SERIAL_GARMIN is not set
+# CONFIG_USB_SERIAL_IPW is not set
+# CONFIG_USB_SERIAL_IUU is not set
+# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
+# CONFIG_USB_SERIAL_KEYSPAN is not set
+# CONFIG_USB_SERIAL_KLSI is not set
+# CONFIG_USB_SERIAL_KOBIL_SCT is not set
+# CONFIG_USB_SERIAL_MCT_U232 is not set
+# CONFIG_USB_SERIAL_METRO is not set
+# CONFIG_USB_SERIAL_MOS7720 is not set
+# CONFIG_USB_SERIAL_MOS7840 is not set
+# CONFIG_USB_SERIAL_MOTOROLA is not set
+# CONFIG_USB_SERIAL_NAVMAN is not set
+# CONFIG_USB_SERIAL_PL2303 is not set
+# CONFIG_USB_SERIAL_OTI6858 is not set
+# CONFIG_USB_SERIAL_QCAUX is not set
+# CONFIG_USB_SERIAL_QUALCOMM is not set
+# CONFIG_USB_SERIAL_SPCP8X5 is not set
+# CONFIG_USB_SERIAL_HP4X is not set
+# CONFIG_USB_SERIAL_SAFE is not set
+# CONFIG_USB_SERIAL_SIEMENS_MPI is not set
+# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
+# CONFIG_USB_SERIAL_SYMBOL is not set
+# CONFIG_USB_SERIAL_TI is not set
+# CONFIG_USB_SERIAL_CYBERJACK is not set
+# CONFIG_USB_SERIAL_XIRCOM is not set
+# CONFIG_USB_SERIAL_OPTION is not set
+# CONFIG_USB_SERIAL_OMNINET is not set
+# CONFIG_USB_SERIAL_OPTICON is not set
+# CONFIG_USB_SERIAL_VIVOPAY_SERIAL is not set
+# CONFIG_USB_SERIAL_XSENS_MT is not set
+# CONFIG_USB_SERIAL_ZIO is not set
+# CONFIG_USB_SERIAL_WISHBONE is not set
+# CONFIG_USB_SERIAL_ZTE is not set
+# CONFIG_USB_SERIAL_SSU100 is not set
+# CONFIG_USB_SERIAL_QT2 is not set
+# CONFIG_USB_SERIAL_FLASHLOADER is not set
+# CONFIG_USB_SERIAL_SUUNTO is not set
+# CONFIG_USB_SERIAL_DEBUG is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_SEVSEG is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_SISUSBVGA is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
+# CONFIG_USB_ISIGHTFW is not set
+# CONFIG_USB_YUREX is not set
+# CONFIG_USB_EZUSB_FX2 is not set
+# CONFIG_USB_HSIC_USB3503 is not set
+# CONFIG_USB_PHY is not set
+# CONFIG_USB_GADGET is not set
+# CONFIG_UWB is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
+# CONFIG_INFINIBAND is not set
+# CONFIG_EDAC is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_SYSTOHC=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# I2C RTC drivers
+#
+# CONFIG_RTC_DRV_DS1307 is not set
+# CONFIG_RTC_DRV_DS1374 is not set
+# CONFIG_RTC_DRV_DS1672 is not set
+# CONFIG_RTC_DRV_DS3232 is not set
+# CONFIG_RTC_DRV_MAX6900 is not set
+CONFIG_RTC_DRV_RS5C372=y
+# CONFIG_RTC_DRV_ISL1208 is not set
+# CONFIG_RTC_DRV_ISL12022 is not set
+# CONFIG_RTC_DRV_X1205 is not set
+# CONFIG_RTC_DRV_PCF2127 is not set
+# CONFIG_RTC_DRV_PCF8523 is not set
+# CONFIG_RTC_DRV_PCF8563 is not set
+# CONFIG_RTC_DRV_PCF8583 is not set
+# CONFIG_RTC_DRV_M41T80 is not set
+# CONFIG_RTC_DRV_BQ32K is not set
+# CONFIG_RTC_DRV_S35390A is not set
+# CONFIG_RTC_DRV_FM3130 is not set
+# CONFIG_RTC_DRV_RX8581 is not set
+# CONFIG_RTC_DRV_RX8025 is not set
+# CONFIG_RTC_DRV_EM3027 is not set
+# CONFIG_RTC_DRV_RV3029C2 is not set
+
+#
+# SPI RTC drivers
+#
+
+#
+# Platform RTC drivers
+#
+# CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1286 is not set
+# CONFIG_RTC_DRV_DS1511 is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T35 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_MSM6242 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_RP5C01 is not set
+# CONFIG_RTC_DRV_V3020 is not set
+# CONFIG_RTC_DRV_DS2404 is not set
+
+#
+# on-CPU RTC drivers
+#
+# CONFIG_RTC_DRV_GENERIC is not set
+# CONFIG_RTC_DRV_SNVS is not set
+
+#
+# HID Sensor RTC drivers
+#
+# CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
+# CONFIG_VIRT_DRIVERS is not set
+
+#
+# Virtio drivers
+#
+# CONFIG_VIRTIO_PCI is not set
+# CONFIG_VIRTIO_MMIO is not set
+
+#
+# Microsoft Hyper-V guest support
+#
+# CONFIG_STAGING is not set
+
+#
+# Hardware Spinlock drivers
+#
+# CONFIG_MAILBOX is not set
+CONFIG_IOMMU_SUPPORT=y
+CONFIG_OF_IOMMU=y
+
+#
+# Remoteproc drivers
+#
+# CONFIG_STE_MODEM_RPROC is not set
+
+#
+# Rpmsg drivers
+#
+# CONFIG_PM_DEVFREQ is not set
+# CONFIG_EXTCON is not set
+# CONFIG_MEMORY is not set
+# CONFIG_IIO is not set
+# CONFIG_VME_BUS is not set
+# CONFIG_PWM is not set
+CONFIG_IRQCHIP=y
+# CONFIG_IPACK_BUS is not set
+# CONFIG_RESET_CONTROLLER is not set
+# CONFIG_FMC is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=m
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=m
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4_FS is not set
+CONFIG_JBD=m
+CONFIG_FS_MBCACHE=m
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+CONFIG_XFS_FS=m
+# CONFIG_XFS_QUOTA is not set
+# CONFIG_XFS_POSIX_ACL is not set
+# CONFIG_XFS_RT is not set
+# CONFIG_XFS_WARN is not set
+# CONFIG_XFS_DEBUG is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+CONFIG_FS_POSIX_ACL=y
+CONFIG_EXPORTFS=m
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_FANOTIFY is not set
+# CONFIG_QUOTA is not set
+# CONFIG_QUOTACTL is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# Caches
+#
+# CONFIG_FSCACHE is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=m
+CONFIG_UDF_NLS=y
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=m
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+CONFIG_NTFS_FS=m
+# CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_TMPFS_XATTR is not set
+# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_CONFIGFS_FS is not set
+CONFIG_MISC_FILESYSTEMS=y
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_ECRYPT_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_JFFS2_FS is not set
+# CONFIG_LOGFS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_SQUASHFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_QNX6FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_PSTORE is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+# CONFIG_F2FS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V2=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+# CONFIG_NFS_SWAP is not set
+# CONFIG_NFS_V4_1 is not set
+CONFIG_ROOT_NFS=y
+# CONFIG_NFS_USE_LEGACY_DNS is not set
+CONFIG_NFS_USE_KERNEL_DNS=y
+CONFIG_NFSD=m
+CONFIG_NFSD_V3=y
+# CONFIG_NFSD_V3_ACL is not set
+# CONFIG_NFSD_V4 is not set
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_ACL_SUPPORT=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
+# CONFIG_SUNRPC_DEBUG is not set
+# CONFIG_CEPH_FS is not set
+CONFIG_CIFS=m
+# CONFIG_CIFS_STATS is not set
+# CONFIG_CIFS_WEAK_PW_HASH is not set
+# CONFIG_CIFS_UPCALL is not set
+# CONFIG_CIFS_XATTR is not set
+CONFIG_CIFS_DEBUG=y
+# CONFIG_CIFS_DEBUG2 is not set
+# CONFIG_CIFS_DFS_UPCALL is not set
+# CONFIG_CIFS_SMB2 is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=m
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+CONFIG_NLS_CODEPAGE_932=m
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+CONFIG_NLS_ISO8859_1=m
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_MAC_ROMAN is not set
+# CONFIG_NLS_MAC_CELTIC is not set
+# CONFIG_NLS_MAC_CENTEURO is not set
+# CONFIG_NLS_MAC_CROATIAN is not set
+# CONFIG_NLS_MAC_CYRILLIC is not set
+# CONFIG_NLS_MAC_GAELIC is not set
+# CONFIG_NLS_MAC_GREEK is not set
+# CONFIG_NLS_MAC_ICELAND is not set
+# CONFIG_NLS_MAC_INUIT is not set
+# CONFIG_NLS_MAC_ROMANIAN is not set
+# CONFIG_NLS_MAC_TURKISH is not set
+CONFIG_NLS_UTF8=m
+# CONFIG_BINARY_PRINTF is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+CONFIG_GENERIC_STRNCPY_FROM_USER=y
+CONFIG_GENERIC_STRNLEN_USER=y
+CONFIG_GENERIC_NET_UTILS=y
+CONFIG_GENERIC_PCI_IOMAP=y
+CONFIG_GENERIC_IO=y
+CONFIG_CRC_CCITT=m
+# CONFIG_CRC16 is not set
+CONFIG_CRC_T10DIF=y
+CONFIG_CRC_ITU_T=m
+CONFIG_CRC32=y
+# CONFIG_CRC32_SELFTEST is not set
+CONFIG_CRC32_SLICEBY8=y
+# CONFIG_CRC32_SLICEBY4 is not set
+# CONFIG_CRC32_SARWATE is not set
+# CONFIG_CRC32_BIT is not set
+# CONFIG_CRC7 is not set
+CONFIG_LIBCRC32C=m
+# CONFIG_CRC8 is not set
+CONFIG_ZLIB_INFLATE=m
+CONFIG_ZLIB_DEFLATE=m
+CONFIG_XZ_DEC=y
+CONFIG_XZ_DEC_X86=y
+CONFIG_XZ_DEC_POWERPC=y
+CONFIG_XZ_DEC_IA64=y
+CONFIG_XZ_DEC_ARM=y
+CONFIG_XZ_DEC_ARMTHUMB=y
+CONFIG_XZ_DEC_SPARC=y
+CONFIG_XZ_DEC_BCJ=y
+# CONFIG_XZ_DEC_TEST is not set
+CONFIG_TEXTSEARCH=y
+CONFIG_TEXTSEARCH_KMP=m
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_DQL=y
+CONFIG_NLATTR=y
+CONFIG_GENERIC_ATOMIC64=y
+CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=y
+# CONFIG_AVERAGE is not set
+# CONFIG_CORDIC is not set
+# CONFIG_DDR is not set
+CONFIG_OID_REGISTRY=y
+
+#
+# Kernel hacking
+#
+
+#
+# printk and dmesg options
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_DEFAULT_MESSAGE_LOGLEVEL=4
+
+#
+# Compile-time checks and compiler options
+#
+# CONFIG_DEBUG_INFO is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
+# CONFIG_STRIP_ASM_SYMS is not set
+# CONFIG_READABLE_ASM is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+# CONFIG_DEBUG_SECTION_MISMATCH is not set
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_KERNEL=y
+
+#
+# Memory Debugging
+#
+# CONFIG_DEBUG_PAGEALLOC is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_SLUB_DEBUG_ON is not set
+# CONFIG_SLUB_STATS is not set
+CONFIG_HAVE_DEBUG_KMEMLEAK=y
+# CONFIG_DEBUG_KMEMLEAK is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_VM is not set
+CONFIG_DEBUG_MEMORY_INIT=y
+CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_SHIRQ is not set
+
+#
+# Debug Lockups and Hangs
+#
+# CONFIG_LOCKUP_DETECTOR is not set
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
+# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
+CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
+# CONFIG_PANIC_ON_OOPS is not set
+CONFIG_PANIC_ON_OOPS_VALUE=0
+CONFIG_SCHED_DEBUG=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+
+#
+# Lock Debugging (spinlocks, mutexes, etc...)
+#
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
+# CONFIG_DEBUG_ATOMIC_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_BUGVERBOSE=y
+# CONFIG_DEBUG_WRITECOUNT is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
+
+#
+# RCU Debugging
+#
+# CONFIG_SPARSE_RCU_POINTER is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_RCU_TRACE is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_NOTIFIER_ERROR_INJECTION is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_LATENCYTOP is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
+CONFIG_TRACING_SUPPORT=y
+CONFIG_FTRACE=y
+# CONFIG_FUNCTION_TRACER is not set
+# CONFIG_IRQSOFF_TRACER is not set
+# CONFIG_SCHED_TRACER is not set
+# CONFIG_ENABLE_DEFAULT_TRACERS is not set
+# CONFIG_FTRACE_SYSCALLS is not set
+# CONFIG_TRACER_SNAPSHOT is not set
+CONFIG_BRANCH_PROFILE_NONE=y
+# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
+# CONFIG_PROFILE_ALL_BRANCHES is not set
+# CONFIG_STACK_TRACER is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_UPROBE_EVENT is not set
+# CONFIG_PROBE_EVENTS is not set
+
+#
+# Runtime Testing
+#
+# CONFIG_TEST_LIST_SORT is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_RBTREE_TEST is not set
+# CONFIG_INTERVAL_TREE_TEST is not set
+# CONFIG_ATOMIC64_SELFTEST is not set
+# CONFIG_TEST_STRING_HELPERS is not set
+# CONFIG_TEST_KSTRTOX is not set
+# CONFIG_DMA_API_DEBUG is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+# CONFIG_PPC_DISABLE_WERROR is not set
+CONFIG_PPC_WERROR=y
+CONFIG_PRINT_STACK_DEPTH=64
+# CONFIG_CODE_PATCHING_SELFTEST is not set
+# CONFIG_FTR_FIXUP_SELFTEST is not set
+# CONFIG_MSI_BITMAP_SELFTEST is not set
+# CONFIG_XMON is not set
+# CONFIG_BDI_SWITCH is not set
+# CONFIG_BOOTX_TEXT is not set
+# CONFIG_PPC_EARLY_DEBUG is not set
+CONFIG_STRICT_DEVMEM=y
+
+#
+# Security options
+#
+CONFIG_KEYS=y
+# CONFIG_ENCRYPTED_KEYS is not set
+# CONFIG_KEYS_DEBUG_PROC_KEYS is not set
+# CONFIG_SECURITY_DMESG_RESTRICT is not set
+# CONFIG_SECURITY is not set
+# CONFIG_SECURITYFS is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
+CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_ALGAPI2=y
+CONFIG_CRYPTO_AEAD2=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_BLKCIPHER2=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_HASH2=y
+CONFIG_CRYPTO_RNG2=y
+CONFIG_CRYPTO_PCOMP2=y
+CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_MANAGER2=y
+# CONFIG_CRYPTO_USER is not set
+CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_NULL is not set
+CONFIG_CRYPTO_WORKQUEUE=y
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Authenticated Encryption with Associated Data
+#
+# CONFIG_CRYPTO_CCM is not set
+# CONFIG_CRYPTO_GCM is not set
+# CONFIG_CRYPTO_SEQIV is not set
+
+#
+# Block modes
+#
+CONFIG_CRYPTO_CBC=y
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_CTS is not set
+CONFIG_CRYPTO_ECB=m
+# CONFIG_CRYPTO_LRW is not set
+CONFIG_CRYPTO_PCBC=m
+# CONFIG_CRYPTO_XTS is not set
+
+#
+# Hash modes
+#
+CONFIG_CRYPTO_CMAC=m
+CONFIG_CRYPTO_HMAC=m
+# CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_VMAC is not set
+
+#
+# Digest
+#
+CONFIG_CRYPTO_CRC32C=m
+# CONFIG_CRYPTO_CRC32 is not set
+# CONFIG_CRYPTO_GHASH is not set
+CONFIG_CRYPTO_MD4=m
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_MICHAEL_MIC=m
+# CONFIG_CRYPTO_RMD128 is not set
+# CONFIG_CRYPTO_RMD160 is not set
+# CONFIG_CRYPTO_RMD256 is not set
+# CONFIG_CRYPTO_RMD320 is not set
+CONFIG_CRYPTO_SHA1=m
+# CONFIG_CRYPTO_SHA1_PPC is not set
+CONFIG_CRYPTO_SHA256=m
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_WP512 is not set
+
+#
+# Ciphers
+#
+CONFIG_CRYPTO_AES=y
+# CONFIG_CRYPTO_ANUBIS is not set
+CONFIG_CRYPTO_ARC4=m
+CONFIG_CRYPTO_BLOWFISH=m
+CONFIG_CRYPTO_BLOWFISH_COMMON=m
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_SALSA20 is not set
+# CONFIG_CRYPTO_SEED is not set
+CONFIG_CRYPTO_SERPENT=m
+# CONFIG_CRYPTO_TEA is not set
+CONFIG_CRYPTO_TWOFISH=m
+CONFIG_CRYPTO_TWOFISH_COMMON=m
+
+#
+# Compression
+#
+CONFIG_CRYPTO_DEFLATE=m
+# CONFIG_CRYPTO_ZLIB is not set
+# CONFIG_CRYPTO_LZO is not set
+# CONFIG_CRYPTO_LZ4 is not set
+# CONFIG_CRYPTO_LZ4HC is not set
+
+#
+# Random Number Generation
+#
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+# CONFIG_CRYPTO_USER_API_HASH is not set
+# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
+CONFIG_CRYPTO_HW=y
+# CONFIG_CRYPTO_DEV_HIFN_795X is not set
+# CONFIG_ASYMMETRIC_KEY_TYPE is not set
+# CONFIG_PPC_CLOCK is not set
+# CONFIG_VIRTUALIZATION is not set
diff --git a/arch/powerpc/platforms/embedded6xx/mvme5100.c 
b/arch/powerpc/platforms/embedded6xx/mvme5100.c
new file mode 100644
index 0000000..cc9ed8a
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/mvme5100.c
@@ -0,0 +1,288 @@
+/*
+ * Board setup routines for the Motorola/Emerson MVME5100.
+ *
+ * Copyright 2013 CSC Australia Pty. Ltd.
+ *
+ * Based on earlier code by:
+ *
+ *    Matt Porter, MontaVista Software Inc.
+ *    Copyright 2001 MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify 
it
+ * under  the terms of  the GNU General  Public License as published by 
the
+ * Free Software Foundation;  either version 2 of the  License, or (at 
your
+ * option) any later version.
+ *
+ * Author: Stephen Chivers <schivers@csc.com>
+ *
+ */
+
+#include <linux/of_platform.h>
+
+#include <asm/i8259.h>
+#include <asm/pci-bridge.h>
+#include <asm/mpic.h>
+#include <asm/prom.h>
+#include <mm/mmu_decl.h>
+#include <asm/udbg.h>
+
+
+#define HAWK_MPIC_SIZE         0x00040000U
+#define MVME5100_PCI_MEM_OFFSET 0x00000000
+
+/* Board register addresses. */
+#define        BOARD_STATUS_REG        0xfef88080
+#define        BOARD_MODFAIL_REG       0xfef88090
+#define        BOARD_MODRST_REG        0xfef880a0
+#define        BOARD_TBEN_REG          0xfef880c0
+#define BOARD_SW_READ_REG      0xfef880e0
+#define        BOARD_GEO_ADDR_REG      0xfef880e8
+#define        BOARD_EXT_FEATURE1_REG  0xfef880f0
+#define        BOARD_EXT_FEATURE2_REG  0xfef88100
+
+static unsigned int pci_membase;
+
+
+#ifdef DEBUG
+#define DBG(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
+#else
+#define DBG(fmt, args...)
+#endif
+
+
+static void
+mvme5100_8259_cascade(unsigned int irq, struct irq_desc *desc)
+{
+       struct irq_chip *chip = irq_desc_get_chip(desc);
+       unsigned int cascade_irq = i8259_irq();
+
+
+       if (cascade_irq != NO_IRQ)
+               generic_handle_irq(cascade_irq);
+
+       chip->irq_eoi(&desc->irq_data);
+}
+
+
+static void __init
+mvme5100_pic_init(void)
+{
+       struct mpic *mpic;
+       void __iomem *mpic_addr;
+       struct device_node *np;
+       struct device_node *cp = NULL;
+       unsigned int cirq;
+       unsigned long intack = 0;
+       const unsigned long *prop = NULL;
+
+
+       np = of_find_node_by_type(NULL, "open-pic");
+       if (!np) {
+               pr_err("Could not find open-pic node\n");
+               return;
+       }
+
+
+       pr_info("mvme5100_pic_init: pci_membase: %x\n", pci_membase);
+
+       mpic_addr = ioremap(pci_membase + MVME5100_PCI_MEM_OFFSET,
+                       HAWK_MPIC_SIZE);
+
+       pr_info("mvme5100_pic_init: mapped mpic_addr: 0x%p\n", mpic_addr);
+
+       mpic = mpic_alloc(np, pci_membase, 0, 16, 256, " OpenPIC  ");
+
+       BUG_ON(mpic == NULL);
+       of_node_put(np);
+
+       mpic_assign_isu(mpic, 0, pci_membase + 0x10000);
+
+       mpic_init(mpic);
+
+       for_each_node_by_type(np, "interrupt-controller")
+               if (of_device_is_compatible(np, "chrp,iic")) {
+                       cp = np;
+                       break;
+               }
+
+       if (cp == NULL) {
+               pr_warn("mvme5100_pic_init: couldn't find i8259\n");
+               return;
+       }
+
+       if ((cirq = irq_of_parse_and_map(cp, 0)) == NO_IRQ) {
+               pr_warn("mvme5100_pic_init: no cascade interrupt?\n");
+               return;
+       }
+
+
+       if ((np = of_find_compatible_node(NULL, "pci", "mpc10x-pci"))) {
+               prop = of_get_property(np, "8259-interrupt-acknowledge", 
NULL);
+
+               if (prop)
+                       intack = prop[0];
+
+               of_node_put(np);
+       }
+
+       if (intack)
+               pr_debug("mvme5100_pic_init: PCI 8259 intack at 
0x%016lx\n",
+                  intack);
+
+       i8259_init(cp, intack);
+       of_node_put(cp);
+       irq_set_chained_handler(cirq, mvme5100_8259_cascade);
+}
+
+
+static int __init
+mvme5100_add_bridge(struct device_node *dev)
+{
+       const int               *bus_range;
+       int                     len;
+       struct pci_controller   *hose;
+       unsigned short          devid;
+
+
+       pr_info("Adding PCI host bridge %s\n", dev->full_name);
+
+       bus_range = of_get_property(dev, "bus-range", &len);
+
+       if (bus_range == NULL || len < 2 * sizeof(int))
+               pr_warn("Can't get bus-range for %s, assuming bus 0\n",
+                       dev->full_name);
+
+       hose = pcibios_alloc_controller(dev);
+
+       if (hose == NULL)
+               return -ENOMEM;
+
+       hose->first_busno = bus_range ? bus_range[0] : 0;
+       hose->last_busno = bus_range ? bus_range[1] : 0xff;
+
+       setup_indirect_pci(hose, 0xfe000cf8, 0xfe000cfc, 0);
+
+       pci_process_bridge_OF_ranges(hose, dev, 1);
+
+       early_read_config_word(hose, 0, 0, PCI_DEVICE_ID, &devid);
+
+       if (devid != PCI_DEVICE_ID_MOTOROLA_HAWK) {
+               pr_err("HAWK PHB not present?\n");
+
+               return 0;
+       }
+
+       early_read_config_dword( hose, 0, 0, PCI_BASE_ADDRESS_1, 
&pci_membase);
+
+       if (pci_membase == 0) {
+               pr_err("HAWK PHB mibar not correctly set?\n");
+
+               return 0;
+       }
+
+       pr_info("mvme5100_pic_init: pci_membase: %x\n", pci_membase);
+
+       return 0;
+}
+
+
+
+/*
+ * Setup the architecture
+ */
+static void __init
+mvme5100_setup_arch(void)
+{
+       struct device_node *np;
+
+
+       if (ppc_md.progress)
+               ppc_md.progress("mvme5100_setup_arch()", 0);
+
+       for_each_compatible_node(np, "pci", "mpc10x-pci")
+               mvme5100_add_bridge(np);
+
+}
+
+
+static void
+mvme5100_show_cpuinfo(struct seq_file *m)
+{
+
+
+       seq_printf(m, "Vendor\t\t: Motorola/Emerson\n");
+       seq_printf(m, "Machine\t\t: MVME5100\n");
+}
+
+
+static void
+mvme5100_restart(char *cmd)
+{
+       volatile ulong          i = 10000000;
+
+
+       local_irq_disable();
+       _nmask_and_or_msr(0, MSR_IP);
+
+       out_8((u_char *) BOARD_MODRST_REG, 0x01);
+
+       while (i-- > 0);
+       panic("restart failed\n");
+}
+
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init mvme5100_probe(void)
+{
+       unsigned long root = of_get_flat_dt_root();
+
+
+       return of_flat_dt_is_compatible(root, "MVME5100");
+}
+
+
+
+static void __init
+mvme5100_set_bat(void)
+{
+
+
+       mb();
+       mtspr(SPRN_DBAT1U, 0xf0001ffe);
+       mtspr(SPRN_DBAT1L, 0xf000002a);
+       mb();
+       setbat(1, 0xfe000000, 0xfe000000, 0x02000000, PAGE_KERNEL_NCG);
+}
+
+
+static __initdata struct of_device_id mvme5100_of_bus_ids[] = {
+       { .type = "soc", },
+       { .compatible = "simple-bus", },
+       {},
+};
+
+static int __init probe_of_platform_devices(void)
+{
+
+
+       of_platform_bus_probe(NULL, mvme5100_of_bus_ids, NULL);
+       return 0;
+}
+
+machine_device_initcall(mvme5100, probe_of_platform_devices);
+
+
+define_machine(mvme5100) {
+       .name                   = "MVME5100",
+       .init_early             = mvme5100_set_bat,
+       .probe                  = mvme5100_probe,
+       .setup_arch             = mvme5100_setup_arch,
+       .init_IRQ               = mvme5100_pic_init,
+       .show_cpuinfo           = mvme5100_show_cpuinfo,
+       .get_irq                = mpic_get_irq,
+       .restart                = mvme5100_restart,
+       .calibrate_decr         = generic_calibrate_decr,
+       .progress               = udbg_progress,
+};
