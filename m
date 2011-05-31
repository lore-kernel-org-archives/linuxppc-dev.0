Return-Path: <ronne@list.ru>
Received: from fallback3.mail.ru (fallback3.mail.ru [94.100.176.58])
	by ozlabs.org (Postfix) with ESMTP id 68850B6F64
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jun 2011 06:50:41 +1000 (EST)
Message-ID: <4DE552A7.1070507@list.ru>
Date: Wed, 01 Jun 2011 00:42:15 +0400
From: Andrey Gusev <ronne@list.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PROBLEM: 2.6.39 doesn't boot on POWER MAC
References: <4DE0AA62.4070909@list.ru>	
	<BANLkTinZd32+5b=3DdYknBCtQJT0qiNKcg@mail.gmail.com>	
	<4DE29B78.1070209@list.ru> <1306705871.7481.594.camel@pasglop>	
	<BANLkTimLm1DYVWy2Cj-F9hLw3mNsqtk4iQ@mail.gmail.com>
	<1306793824.7481.622.camel@pasglop>
In-Reply-To: <1306793824.7481.622.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: kevin diggs <diggskevin38@gmail.com>,
	Tabi Timur-B04825 <B04825@freescale.com>,
	"paulus@samba.org" <paulus@samba.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

31.05.2011 02:17, Benjamin Herrenschmidt пишет:
> On Mon, 2011-05-30 at 17:11 -0500, kevin diggs wrote:
>> Hi,
>>
>>> This is an SMP machine ? If not, does it work with a UP kernel ?
>>>
>>> Cheers,
>>> Ben.
>>>
>> ??? Even if it is SMP, you can run non-SMP kernel on it, right?
> Yes, I was asking whether the bug also occured with an UP kernel.
>
> Cheers,
> Ben.
>
>
I checked the kernel without HOT PLUG CPU support, it works.
I checked the kernel without SMP support, it works.
I ckecked the final kernel without HOTPLUG CPU support it doesn't work.
There are a diff of the configuration files:
--- old_config  2011-05-31 20:35:23.459100951 +0400
+++ .config 2011-05-31 20:36:02.962653880 +0400
@@ -1,7 +1,7 @@
  #
  # Automatically generated make config: don't edit
  # Linux/powerpc 2.6.39-rc1 Kernel Configuration
-# Sun May 29 23:00:54 2011
+# Tue May 31 20:36:02 2011
  #
  # CONFIG_PPC64 is not set

@@ -310,8 +310,7 @@
  CONFIG_BINFMT_MISC=m
  # CONFIG_IOMMU_HELPER is not set
  # CONFIG_SWIOTLB is not set
-CONFIG_HOTPLUG_CPU=y
-CONFIG_ARCH_CPU_PROBE_RELEASE=y
+# CONFIG_HOTPLUG_CPU is not set
  CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
  CONFIG_ARCH_HAS_WALK_MEMORY=y
  CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
@@ -1875,7 +1874,6 @@
  # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
  # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
  # CONFIG_LKDTM is not set
-# CONFIG_CPU_NOTIFIER_ERROR_INJECT is not set
  # CONFIG_FAULT_INJECTION is not set
  # CONFIG_LATENCYTOP is not set
  CONFIG_SYSCTL_SYSCALL_CHECK=y


--- old_config    2011-05-31 20:35:23.459100951 +0400
+++ .config    2011-05-31 22:32:07.595559180 +0400
@@ -1,7 +1,7 @@
  #
  # Automatically generated make config: don't edit
  # Linux/powerpc 2.6.39-rc1 Kernel Configuration
-# Sun May 29 23:00:54 2011
+# Tue May 31 22:32:07 2011
  #
  # CONFIG_PPC64 is not set

@@ -23,8 +23,7 @@
  # CONFIG_PPC_MM_SLICES is not set
  CONFIG_PPC_HAVE_PMU_SUPPORT=y
  CONFIG_PPC_PERF_CTRS=y
-CONFIG_SMP=y
-CONFIG_NR_CPUS=2
+# CONFIG_SMP is not set
  CONFIG_PPC32=y
  CONFIG_32BIT=y
  CONFIG_WORD_SIZE=32
@@ -42,7 +41,6 @@
  CONFIG_TRACE_IRQFLAGS_SUPPORT=y
  CONFIG_LOCKDEP_SUPPORT=y
  CONFIG_RWSEM_XCHGADD_ALGORITHM=y
-CONFIG_GENERIC_LOCKBREAK=y
  CONFIG_ARCH_HAS_ILOG2_U32=y
  CONFIG_GENERIC_HWEIGHT=y
  CONFIG_GENERIC_FIND_NEXT_BIT=y
@@ -55,7 +53,7 @@
  CONFIG_ARCH_MAY_HAVE_PC_FDC=y
  CONFIG_PPC_OF=y
  # CONFIG_PPC_UDBG_16550 is not set
-CONFIG_GENERIC_TBSYNC=y
+# CONFIG_GENERIC_TBSYNC is not set
  CONFIG_AUDIT_ARCH=y
  CONFIG_GENERIC_BUG=y
  # CONFIG_DEFAULT_UIMAGE is not set
@@ -73,6 +71,7 @@
  # General setup
  #
  CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
  CONFIG_INIT_ENV_ARG_LIMIT=32
  CONFIG_CROSS_COMPILE=""
  CONFIG_LOCALVERSION=""
@@ -105,6 +104,8 @@
  # RCU Subsystem
  #
  CONFIG_TREE_PREEMPT_RCU=y
+# CONFIG_TINY_RCU is not set
+# CONFIG_TINY_PREEMPT_RCU is not set
  CONFIG_PREEMPT_RCU=y
  # CONFIG_RCU_TRACE is not set
  CONFIG_RCU_FANOUT=32
@@ -188,7 +189,6 @@
  CONFIG_HAVE_KRETPROBES=y
  CONFIG_HAVE_ARCH_TRACEHOOK=y
  CONFIG_HAVE_DMA_ATTRS=y
-CONFIG_USE_GENERIC_SMP_HELPERS=y
  CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
  CONFIG_HAVE_DMA_API_DEBUG=y

@@ -206,7 +206,6 @@
  CONFIG_MODULE_FORCE_UNLOAD=y
  CONFIG_MODVERSIONS=y
  # CONFIG_MODULE_SRCVERSION_ALL is not set
-CONFIG_STOP_MACHINE=y
  CONFIG_BLOCK=y
  # CONFIG_LBDAF is not set
  CONFIG_BLK_DEV_BSG=y
@@ -249,7 +248,7 @@
  # CONFIG_INLINE_WRITE_UNLOCK_BH is not set
  # CONFIG_INLINE_WRITE_UNLOCK_IRQ is not set
  # CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
-CONFIG_MUTEX_SPIN_ON_OWNER=y
+# CONFIG_MUTEX_SPIN_ON_OWNER is not set
  CONFIG_FREEZER=y

  #
@@ -265,6 +264,8 @@
  # CONFIG_PQ2ADS is not set
  # CONFIG_PPC_83xx is not set
  # CONFIG_PPC_86xx is not set
+# CONFIG_EMBEDDED6xx is not set
+# CONFIG_AMIGAONE is not set
  # CONFIG_KVM_GUEST is not set
  CONFIG_PPC_NATIVE=y
  CONFIG_PPC_OF_BOOT_TRAMPOLINE=y
@@ -310,14 +311,11 @@
  CONFIG_BINFMT_MISC=m
  # CONFIG_IOMMU_HELPER is not set
  # CONFIG_SWIOTLB is not set
-CONFIG_HOTPLUG_CPU=y
-CONFIG_ARCH_CPU_PROBE_RELEASE=y
  CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
  CONFIG_ARCH_HAS_WALK_MEMORY=y
  CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
  # CONFIG_KEXEC is not set
  # CONFIG_CRASH_DUMP is not set
-CONFIG_IRQ_ALL_CPUS=y
  CONFIG_MAX_ACTIVE_REGIONS=32
  CONFIG_ARCH_FLATMEM_ENABLE=y
  CONFIG_ARCH_POPULATES_NODE_MAP=y
@@ -336,6 +334,7 @@
  CONFIG_VIRT_TO_BUS=y
  # CONFIG_KSM is not set
  CONFIG_DEFAULT_MMAP_MIN_ADDR=32768
+CONFIG_NEED_PER_CPU_KM=y
  CONFIG_PPC_4K_PAGES=y
  CONFIG_FORCE_MAX_ZONEORDER=11
  # CONFIG_CMDLINE_BOOL is not set
@@ -472,9 +471,6 @@
  # CONFIG_NET_SCHED is not set
  # CONFIG_DCB is not set
  # CONFIG_BATMAN_ADV is not set
-CONFIG_RPS=y
-CONFIG_RFS_ACCEL=y
-CONFIG_XPS=y

  #
  # Network testing
@@ -744,7 +740,6 @@
  CONFIG_MD_RAID1=m
  CONFIG_MD_RAID10=m
  CONFIG_MD_RAID456=m
-CONFIG_MULTICORE_RAID456=y
  CONFIG_MD_MULTIPATH=m
  CONFIG_MD_FAULTY=m
  CONFIG_BLK_DEV_DM=y
@@ -1813,7 +1808,6 @@
  CONFIG_HAS_IOMEM=y
  CONFIG_HAS_IOPORT=y
  CONFIG_HAS_DMA=y
-CONFIG_CPU_RMAP=y
  CONFIG_NLATTR=y
  CONFIG_GENERIC_ATOMIC64=y
  # CONFIG_AVERAGE is not set
@@ -1875,7 +1869,6 @@
  # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
  # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
  # CONFIG_LKDTM is not set
-# CONFIG_CPU_NOTIFIER_ERROR_INJECT is not set
  # CONFIG_FAULT_INJECTION is not set
  # CONFIG_LATENCYTOP is not set
  CONFIG_SYSCTL_SYSCALL_CHECK=y
@@ -1902,7 +1895,6 @@
  CONFIG_PRINT_STACK_DEPTH=64
  # CONFIG_DEBUG_STACKOVERFLOW is not set
  # CONFIG_DEBUG_STACK_USAGE is not set
-# CONFIG_DEBUG_PER_CPU_MAPS is not set
  # CONFIG_PPC_EMULATED_STATS is not set
  # CONFIG_CODE_PATCHING_SELFTEST is not set
  # CONFIG_FTR_FIXUP_SELFTEST is not set
@@ -1954,7 +1946,6 @@
  # CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
  CONFIG_CRYPTO_GF128MUL=m
  CONFIG_CRYPTO_NULL=m
-# CONFIG_CRYPTO_PCRYPT is not set
  CONFIG_CRYPTO_WORKQUEUE=y
  # CONFIG_CRYPTO_CRYPTD is not set
  CONFIG_CRYPTO_AUTHENC=m


Andrey
