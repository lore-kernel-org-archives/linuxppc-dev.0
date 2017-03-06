Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcJQC34dPzDqHY
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 23:05:23 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: sfr@canb.auug.org.au,
	andrew.donnellan@au1.ibm.com
Subject: [PATCH] powerpc: Sort the selects under CONFIG_PPC
Date: Mon,  6 Mar 2017 23:05:17 +1100
Message-Id: <1488801917-17782-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have a big list of selects under CONFIG_PPC, and currently they're
completely unsorted. This means people tend to add new selects at the
bottom of the list, and so two commits which both add a new select will
often conflict.

Instead sort it alphabetically. This is nicer in and of itself, but also
means two commits that add a new select will have a greater chance of
not conflicting.

Add a note at the top and bottom asking people to keep it sorted.

And while we're here pad out the 'if' expressions to make them stand
out.

Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig | 138 +++++++++++++++++++++++++++------------------------
 1 file changed, 72 insertions(+), 66 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 494091762bd7..97a8bc8a095c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -80,93 +80,99 @@ config ARCH_HAS_DMA_SET_COHERENT_MASK
 config PPC
 	bool
 	default y
-	select BUILDTIME_EXTABLE_SORT
+	#
+	# Please keep this list sorted alphabetically.
+	#
+	select ARCH_HAS_DEVMEM_IS_ALLOWED
+	select ARCH_HAS_DMA_SET_COHERENT_MASK
+	select ARCH_HAS_ELF_RANDOMIZE
+	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE
+	select ARCH_HAS_SG_CHAIN
+	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ARCH_SUPPORTS_ATOMIC_RMW
+	select ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
+	select ARCH_USE_BUILTIN_BSWAP
+	select ARCH_USE_CMPXCHG_LOCKREF		if PPC64
+	select ARCH_WANT_IPC_PARSE_VERSION
 	select BINFMT_ELF
-	select ARCH_HAS_ELF_RANDOMIZE
-	select OF
-	select OF_EARLY_FLATTREE
-	select OF_RESERVED_MEM
-	select HAVE_FTRACE_MCOUNT_RECORD
+	select BUILDTIME_EXTABLE_SORT
+	select CLONE_BACKWARDS
+	select DCACHE_WORD_ACCESS		if PPC64 && CPU_LITTLE_ENDIAN
+	select EDAC_ATOMIC_SCRUB
+	select EDAC_SUPPORT
+	select GENERIC_ATOMIC64			if PPC32
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_CLOCKEVENTS_BROADCAST	if SMP
+	select GENERIC_CMOS_UPDATE
+	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_IRQ_SHOW
+	select GENERIC_IRQ_SHOW_LEVEL
+	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_STRNCPY_FROM_USER
+	select GENERIC_STRNLEN_USER
+	select GENERIC_TIME_VSYSCALL_OLD
+	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_HARDENED_USERCOPY
+	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_ARCH_KGDB
+	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_TRACEHOOK
+	select HAVE_CBPF_JIT			if !PPC64
+	select HAVE_CONTEXT_TRACKING		if PPC64
+	select HAVE_DEBUG_KMEMLEAK
+	select HAVE_DEBUG_STACKOVERFLOW
+	select HAVE_DMA_API_DEBUG
 	select HAVE_DYNAMIC_FTRACE
-	select HAVE_DYNAMIC_FTRACE_WITH_REGS if MPROFILE_KERNEL
-	select HAVE_FUNCTION_TRACER
+	select HAVE_DYNAMIC_FTRACE_WITH_REGS	if MPROFILE_KERNEL
+	select HAVE_EBPF_JIT			if PPC64
+	select HAVE_EFFICIENT_UNALIGNED_ACCESS	if !(CPU_LITTLE_ENDIAN && POWER7_CPU)
+	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
-	select SYSCTL_EXCEPTION_TRACE
-	select VIRT_TO_BUS if !PPC64
+	select HAVE_GENERIC_RCU_GUP
+	select HAVE_HW_BREAKPOINT		if PERF_EVENTS && (PPC_BOOK3S || PPC_8xx)
 	select HAVE_IDE
 	select HAVE_IOREMAP_PROT
-	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !(CPU_LITTLE_ENDIAN && POWER7_CPU)
+	select HAVE_IRQ_EXIT_ON_IRQ_STACK
+	select HAVE_KERNEL_GZIP
 	select HAVE_KPROBES
-	select HAVE_OPTPROBES if PPC64
-	select HAVE_ARCH_KGDB
 	select HAVE_KRETPROBES
-	select HAVE_ARCH_TRACEHOOK
+	select HAVE_LIVEPATCH			if HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
-	select HAVE_DMA_API_DEBUG
+	select HAVE_MOD_ARCH_SPECIFIC
+	select HAVE_NMI				if PERF_EVENTS
 	select HAVE_OPROFILE
-	select HAVE_DEBUG_KMEMLEAK
-	select ARCH_HAS_SG_CHAIN
-	select GENERIC_ATOMIC64 if PPC32
+	select HAVE_OPTPROBES			if PPC64
 	select HAVE_PERF_EVENTS
+	select HAVE_PERF_EVENTS_NMI		if PPC64
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_RCU_TABLE_FREE		if SMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
-	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (PPC_BOOK3S || PPC_8xx)
-	select ARCH_WANT_IPC_PARSE_VERSION
-	select SPARSE_IRQ
+	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_VIRT_CPU_ACCOUNTING
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_SHOW
-	select GENERIC_IRQ_SHOW_LEVEL
 	select IRQ_FORCED_THREADING
-	select HAVE_RCU_TABLE_FREE if SMP
-	select HAVE_SYSCALL_TRACEPOINTS
-	select HAVE_CBPF_JIT if !PPC64
-	select HAVE_EBPF_JIT if PPC64
-	select HAVE_ARCH_JUMP_LABEL
-	select ARCH_HAVE_NMI_SAFE_CMPXCHG
-	select ARCH_HAS_GCOV_PROFILE_ALL
-	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_CMOS_UPDATE
-	select GENERIC_TIME_VSYSCALL_OLD
-	select GENERIC_CLOCKEVENTS
-	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
-	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
-	select GENERIC_STRNCPY_FROM_USER
-	select GENERIC_STRNLEN_USER
-	select HAVE_MOD_ARCH_SPECIFIC
 	select MODULES_USE_ELF_RELA
-	select CLONE_BACKWARDS
-	select ARCH_USE_BUILTIN_BSWAP
-	select OLD_SIGSUSPEND
-	select OLD_SIGACTION if PPC32
-	select HAVE_DEBUG_STACKOVERFLOW
-	select HAVE_IRQ_EXIT_ON_IRQ_STACK
-	select ARCH_USE_CMPXCHG_LOCKREF if PPC64
-	select HAVE_ARCH_AUDITSYSCALL
-	select ARCH_SUPPORTS_ATOMIC_RMW
-	select DCACHE_WORD_ACCESS if PPC64 && CPU_LITTLE_ENDIAN
 	select NO_BOOTMEM
-	select HAVE_GENERIC_RCU_GUP
-	select HAVE_PERF_EVENTS_NMI if PPC64
-	select HAVE_NMI if PERF_EVENTS
-	select EDAC_SUPPORT
-	select EDAC_ATOMIC_SCRUB
-	select ARCH_HAS_DMA_SET_COHERENT_MASK
-	select ARCH_HAS_DEVMEM_IS_ALLOWED
-	select HAVE_ARCH_SECCOMP_FILTER
-	select ARCH_HAS_UBSAN_SANITIZE_ALL
-	select ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
-	select HAVE_LIVEPATCH if HAVE_DYNAMIC_FTRACE_WITH_REGS
-	select GENERIC_CPU_AUTOPROBE
-	select HAVE_VIRT_CPU_ACCOUNTING
-	select ARCH_HAS_SCALED_CPUTIME if VIRT_CPU_ACCOUNTING_NATIVE
-	select HAVE_ARCH_HARDENED_USERCOPY
-	select HAVE_KERNEL_GZIP
-	select HAVE_CONTEXT_TRACKING if PPC64
+	select OF
+	select OF_EARLY_FLATTREE
+	select OF_RESERVED_MEM
+	select OLD_SIGACTION			if PPC32
+	select OLD_SIGSUSPEND
+	select SPARSE_IRQ
+	select SYSCTL_EXCEPTION_TRACE
+	select VIRT_TO_BUS			if !PPC64
+	#
+	# Please keep this list sorted alphabetically.
+	#
 
 config GENERIC_CSUM
 	def_bool n
-- 
2.7.4
