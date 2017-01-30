Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBkfS08C7zDqCl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 20:31:11 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0U9SvwN052445
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 04:31:07 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 289td6q5u1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 04:31:07 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 30 Jan 2017 19:31:05 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CAF9F2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 20:31:03 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0U9Utqj35651766
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 20:31:03 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0U9UVIJ018770
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 20:30:31 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: sfr@canb.auug.org.au, paulmck@linux.vnet.ibm.com, benh@kernel.crashing.org,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: [PATCH] powerpc: sort Kconfig selects under CONFIG_PPC
Date: Mon, 30 Jan 2017 20:30:02 +1100
In-Reply-To: <87y3xtw62l.fsf@concordia.ellerman.id.au>
References: <87y3xtw62l.fsf@concordia.ellerman.id.au>
Message-Id: <20170130093002.22180-1-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

config PPC has a lot of selects under it. They're not sorted in any
particular order, leading to merge conflicts when adding items at the end.

Sort them alphabetically.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---

On top of linux-next 20170130

---
 arch/powerpc/Kconfig | 128 +++++++++++++++++++++++++--------------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 689cf9218b21..570195c8a86a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -80,91 +80,91 @@ config ARCH_HAS_DMA_SET_COHERENT_MASK
 config PPC
 	bool
 	default y
-	select BUILDTIME_EXTABLE_SORT
+	select ARCH_HAS_DEVMEM_IS_ALLOWED
+	select ARCH_HAS_DMA_SET_COHERENT_MASK
+	select ARCH_HAS_ELF_RANDOMIZE
+	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_SCALED_CPUTIME if VIRT_CPU_ACCOUNTING_NATIVE
+	select ARCH_HAS_SG_CHAIN
+	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ARCH_SUPPORTS_ATOMIC_RMW
+	select ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
+	select ARCH_USE_BUILTIN_BSWAP
+	select ARCH_USE_CMPXCHG_LOCKREF if PPC64
+	select ARCH_WANT_IPC_PARSE_VERSION
+	select ARCH_WEAK_RELEASE_ACQUIRE
 	select BINFMT_ELF
-	select ARCH_HAS_ELF_RANDOMIZE
-	select OF
-	select OF_EARLY_FLATTREE
-	select OF_RESERVED_MEM
-	select HAVE_FTRACE_MCOUNT_RECORD
+	select BUILDTIME_EXTABLE_SORT
+	select CLONE_BACKWARDS
+	select DCACHE_WORD_ACCESS if PPC64 && CPU_LITTLE_ENDIAN
+	select EDAC_ATOMIC_SCRUB
+	select EDAC_SUPPORT
+	select GENERIC_ATOMIC64 if PPC32
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
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
+	select HAVE_CBPF_JIT if !PPC64
+	select HAVE_DEBUG_KMEMLEAK
+	select HAVE_DEBUG_STACKOVERFLOW
+	select HAVE_DMA_API_DEBUG
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if MPROFILE_KERNEL
-	select HAVE_FUNCTION_TRACER
+	select HAVE_EBPF_JIT if PPC64
+	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !(CPU_LITTLE_ENDIAN && POWER7_CPU)
+	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
-	select SYSCTL_EXCEPTION_TRACE
-	select VIRT_TO_BUS if !PPC64
+	select HAVE_FUNCTION_TRACER
+	select HAVE_GENERIC_RCU_GUP
+	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (PPC_BOOK3S || PPC_8xx)
 	select HAVE_IDE
 	select HAVE_IOREMAP_PROT
-	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !(CPU_LITTLE_ENDIAN && POWER7_CPU)
+	select HAVE_IRQ_EXIT_ON_IRQ_STACK
+	select HAVE_KERNEL_GZIP
 	select HAVE_KPROBES
-	select HAVE_ARCH_KGDB
 	select HAVE_KRETPROBES
-	select HAVE_ARCH_TRACEHOOK
+	select HAVE_LIVEPATCH if HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
-	select HAVE_DMA_API_DEBUG
+	select HAVE_MOD_ARCH_SPECIFIC
+	select HAVE_NMI if PERF_EVENTS
 	select HAVE_OPROFILE
-	select HAVE_DEBUG_KMEMLEAK
-	select ARCH_HAS_SG_CHAIN
-	select GENERIC_ATOMIC64 if PPC32
 	select HAVE_PERF_EVENTS
+	select HAVE_PERF_EVENTS_NMI if PPC64
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_RCU_TABLE_FREE if SMP
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
-	select ARCH_WEAK_RELEASE_ACQUIRE
+	select OF
+	select OF_EARLY_FLATTREE
+	select OF_RESERVED_MEM
+	select OLD_SIGACTION if PPC32
+	select OLD_SIGSUSPEND
+	select SPARSE_IRQ
+	select SYSCTL_EXCEPTION_TRACE
+	select VIRT_TO_BUS if !PPC64
 
 config GENERIC_CSUM
 	def_bool n
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
