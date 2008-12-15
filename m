Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 15 Dec 2008 16:44:54 +1100
Subject: [PATCH 11/16] powerpc/mm: Add SMP support to no-hash TLB handling v3
In-Reply-To: <1229319836.100184.344640589620.qpush@grosgo>
Message-Id: <20081215054554.E883EDDF9D@ozlabs.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch moves the whole no-hash TLB handling out of line into a
new tlb_nohash.c file, and implements some basic SMP support using
IPIs and/or broadcast tlbivax instructions.

Note that I'm using local invalidations for D->I cache coherency.

At worst, if another processor is trying to execute the same and
has the old entry in its TLB, it will just take a fault and re-do
the TLB flush locally (it won't re-do the cache flush in any case).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v2. This variant fixes usage of linux/spinlock.h instead of asm/spinlock.h
v3. Invadvertently un-EXPORT_SYMBOL'ed some cache flush calls on ppc64
v4. Fix differences in local_* flush variants between CPU types and
    corresponding clash with highmem code. Remove remaining _tlbie calls
    from nohash code.

 arch/powerpc/include/asm/highmem.h  |    4 
 arch/powerpc/include/asm/mmu.h      |    3 
 arch/powerpc/include/asm/tlbflush.h |   84 ++++++--------
 arch/powerpc/kernel/misc_32.S       |    9 +
 arch/powerpc/kernel/ppc_ksyms.c     |    6 -
 arch/powerpc/mm/Makefile            |    2 
 arch/powerpc/mm/fault.c             |    2 
 arch/powerpc/mm/mem.c               |    2 
 arch/powerpc/mm/tlb_hash32.c        |    4 
 arch/powerpc/mm/tlb_nohash.c        |  209 ++++++++++++++++++++++++++++++++++++
 10 files changed, 268 insertions(+), 57 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/tlbflush.h	2008-12-15 14:36:20.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/tlbflush.h	2008-12-15 14:36:38.000000000 +1100
@@ -6,7 +6,9 @@
  *
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
  *  - flush_tlb_page(vma, vmaddr) flushes one page
- *  - local_flush_tlb_page(vmaddr) flushes one page on the local processor
+ *  - local_flush_tlb_mm(mm) flushes the specified mm context on
+ *                           the local processor
+ *  - local_flush_tlb_page(vma, vmaddr) flushes one page on the local processor
  *  - flush_tlb_page_nohash(vma, vmaddr) flushes one page if SW loaded TLB
  *  - flush_tlb_range(vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
@@ -18,7 +20,7 @@
  */
 #ifdef __KERNEL__
 
-#if defined(CONFIG_4xx) || defined(CONFIG_8xx) || defined(CONFIG_FSL_BOOKE)
+#ifdef CONFIG_PPC_MMU_NOHASH
 /*
  * TLB flushing for software loaded TLB chips
  *
@@ -31,10 +33,10 @@
 
 #define MMU_NO_CONTEXT      	((unsigned int)-1)
 
-extern void _tlbie(unsigned long address, unsigned int pid);
 extern void _tlbil_all(void);
 extern void _tlbil_pid(unsigned int pid);
 extern void _tlbil_va(unsigned long address, unsigned int pid);
+extern void _tlbivax_bcast(unsigned long address, unsigned int pid);
 
 #if defined(CONFIG_40x) || defined(CONFIG_8xx)
 #define _tlbia()	asm volatile ("tlbia; sync" : : : "memory")
@@ -42,48 +44,26 @@ extern void _tlbil_va(unsigned long addr
 extern void _tlbia(void);
 #endif
 
-static inline void local_flush_tlb_mm(struct mm_struct *mm)
-{
-	_tlbil_pid(mm->context.id);
-}
-
-static inline void flush_tlb_mm(struct mm_struct *mm)
-{
-	_tlbil_pid(mm->context.id);
-}
-
-static inline void local_flush_tlb_page(unsigned long vmaddr)
-{
-	_tlbil_va(vmaddr, 0);
-}
-
-static inline void flush_tlb_page(struct vm_area_struct *vma,
-				  unsigned long vmaddr)
-{
-	_tlbil_va(vmaddr, vma ? vma->vm_mm->context.id : 0);
-}
+extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
+			    unsigned long end);
+extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
-static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
-					 unsigned long vmaddr)
-{
-	flush_tlb_page(vma, vmaddr);
-}
+extern void local_flush_tlb_mm(struct mm_struct *mm);
+extern void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 
-static inline void flush_tlb_range(struct vm_area_struct *vma,
-				   unsigned long start, unsigned long end)
-{
-	_tlbil_pid(vma->vm_mm->context.id);
-}
+#ifdef CONFIG_SMP
+extern void flush_tlb_mm(struct mm_struct *mm);
+extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
+#else
+#define flush_tlb_mm(mm)		local_flush_tlb_mm(mm)
+#define flush_tlb_page(vma,addr)	local_flush_tlb_page(vma,addr)
+#endif
+#define flush_tlb_page_nohash(vma,addr)	flush_tlb_page(vma,addr)
 
-static inline void flush_tlb_kernel_range(unsigned long start,
-					  unsigned long end)
-{
-	_tlbil_pid(0);
-}
+#elif defined(CONFIG_PPC_STD_MMU_32)
 
-#elif defined(CONFIG_PPC32)
 /*
- * TLB flushing for "classic" hash-MMMU 32-bit CPUs, 6xx, 7xx, 7xxx
+ * TLB flushing for "classic" hash-MMU 32-bit CPUs, 6xx, 7xx, 7xxx
  */
 extern void _tlbie(unsigned long address);
 extern void _tlbia(void);
@@ -94,14 +74,20 @@ extern void flush_tlb_page_nohash(struct
 extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			    unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
-static inline void local_flush_tlb_page(unsigned long vmaddr)
+static inline void local_flush_tlb_page(struct vm_area_struct *vma,
+					unsigned long vmaddr)
 {
-	flush_tlb_page(NULL, vmaddr);
+	flush_tlb_page(vma, vmaddr);
+}
+static inline void local_flush_tlb_mm(struct mm_struct *mm)
+{
+	flush_tlb_mm(mm);
 }
 
-#else
+#elif defined(CONFIG_PPC_STD_MMU_64)
+
 /*
- * TLB flushing for 64-bit has-MMU CPUs
+ * TLB flushing for 64-bit hash-MMU CPUs
  */
 
 #include <linux/percpu.h>
@@ -151,11 +137,16 @@ extern void flush_hash_page(unsigned lon
 extern void flush_hash_range(unsigned long number, int local);
 
 
+static inline void local_flush_tlb_mm(struct mm_struct *mm)
+{
+}
+
 static inline void flush_tlb_mm(struct mm_struct *mm)
 {
 }
 
-static inline void local_flush_tlb_page(unsigned long vmaddr)
+static inline void local_flush_tlb_page(struct vm_area_struct *vma,
+					unsigned long vmaddr)
 {
 }
 
@@ -183,7 +174,8 @@ static inline void flush_tlb_kernel_rang
 extern void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 				     unsigned long end);
 
-
+#else
+#error Unsupported MMU type
 #endif
 
 #endif /*__KERNEL__ */
Index: linux-work/arch/powerpc/mm/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/mm/Makefile	2008-12-15 14:36:20.000000000 +1100
+++ linux-work/arch/powerpc/mm/Makefile	2008-12-15 14:36:38.000000000 +1100
@@ -9,7 +9,7 @@ endif
 obj-y				:= fault.o mem.o pgtable.o \
 				   init_$(CONFIG_WORD_SIZE).o \
 				   pgtable_$(CONFIG_WORD_SIZE).o
-obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o
+obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o
 hash-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
 obj-$(CONFIG_PPC64)		+= hash_utils_64.o \
 				   slb_low.o slb.o stab.o \
Index: linux-work/arch/powerpc/mm/tlb_nohash.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/mm/tlb_nohash.c	2008-12-15 14:36:20.000000000 +1100
@@ -0,0 +1,209 @@
+/*
+ * This file contains the routines for TLB flushing.
+ * On machines where the MMU does not use a hash table to store virtual to
+ * physical translations (ie, SW loaded TLBs or Book3E compilant processors,
+ * this does -not- include 603 however which shares the implementation with
+ * hash based processors)
+ *
+ *  -- BenH
+ *
+ * Copyright 2008 Ben Herrenschmidt <benh@kernel.crashing.org>
+ *                IBM Corp.
+ *
+ *  Derived from arch/ppc/mm/init.c:
+ *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
+ *
+ *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
+ *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
+ *    Copyright (C) 1996 Paul Mackerras
+ *
+ *  Derived from "arch/i386/mm/init.c"
+ *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/highmem.h>
+#include <linux/pagemap.h>
+#include <linux/preempt.h>
+#include <linux/spinlock.h>
+
+#include <asm/tlbflush.h>
+#include <asm/tlb.h>
+
+#include "mmu_decl.h"
+
+/*
+ * Basse TLB flushing operations:
+ *
+ *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
+ *  - flush_tlb_page(vma, vmaddr) flushes one page
+ *  - flush_tlb_range(vma, start, end) flushes a range of pages
+ *  - flush_tlb_kernel_range(start, end) flushes kernel pages
+ *
+ *  - local_* variants of page and mm only apply to the current
+ *    processor
+ */
+
+/*
+ * These are the base non-SMP variants of page and mm flushing
+ */
+void local_flush_tlb_mm(struct mm_struct *mm)
+{
+	unsigned int pid;
+
+	preempt_disable();
+	pid = mm->context.id;
+	if (pid != MMU_NO_CONTEXT)
+		_tlbil_pid(pid);
+	preempt_enable();
+}
+EXPORT_SYMBOL(local_flush_tlb_mm);
+
+void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
+{
+	unsigned int pid;
+
+	preempt_disable();
+	pid = vma ? vma->vm_mm->context.id : 0;
+	if (pid != MMU_NO_CONTEXT)
+		_tlbil_va(vmaddr, pid);
+	preempt_enable();
+}
+EXPORT_SYMBOL(local_flush_tlb_page);
+
+
+/*
+ * And here are the SMP non-local implementations
+ */
+#ifdef CONFIG_SMP
+
+static DEFINE_SPINLOCK(tlbivax_lock);
+
+struct tlb_flush_param {
+	unsigned long addr;
+	unsigned int pid;
+};
+
+static void do_flush_tlb_mm_ipi(void *param)
+{
+	struct tlb_flush_param *p = param;
+
+	_tlbil_pid(p ? p->pid : 0);
+}
+
+static void do_flush_tlb_page_ipi(void *param)
+{
+	struct tlb_flush_param *p = param;
+
+	_tlbil_va(p->addr, p->pid);
+}
+
+
+/* Note on invalidations and PID:
+ *
+ * We snapshot the PID with preempt disabled. At this point, it can still
+ * change either because:
+ * - our context is being stolen (PID -> NO_CONTEXT) on another CPU
+ * - we are invaliating some target that isn't currently running here
+ *   and is concurrently acquiring a new PID on another CPU
+ * - some other CPU is re-acquiring a lost PID for this mm
+ * etc...
+ *
+ * However, this shouldn't be a problem as we only guarantee
+ * invalidation of TLB entries present prior to this call, so we
+ * don't care about the PID changing, and invalidating a stale PID
+ * is generally harmless.
+ */
+
+void flush_tlb_mm(struct mm_struct *mm)
+{
+	cpumask_t cpu_mask;
+	unsigned int pid;
+
+	preempt_disable();
+	pid = mm->context.id;
+	if (unlikely(pid == MMU_NO_CONTEXT))
+		goto no_context;
+	cpu_mask = mm->cpu_vm_mask;
+	cpu_clear(smp_processor_id(), cpu_mask);
+	if (!cpus_empty(cpu_mask)) {
+		struct tlb_flush_param p = { .pid = pid };
+		smp_call_function_mask(cpu_mask, do_flush_tlb_mm_ipi, &p, 1);
+	}
+	_tlbil_pid(pid);
+ no_context:
+	preempt_enable();
+}
+EXPORT_SYMBOL(flush_tlb_mm);
+
+void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
+{
+	cpumask_t cpu_mask;
+	unsigned int pid;
+
+	preempt_disable();
+	pid = vma ? vma->vm_mm->context.id : 0;
+	if (unlikely(pid == MMU_NO_CONTEXT))
+		goto bail;
+	cpu_mask = vma->vm_mm->cpu_vm_mask;
+	cpu_clear(smp_processor_id(), cpu_mask);
+	if (!cpus_empty(cpu_mask)) {
+		/* If broadcast tlbivax is supported, use it */
+		if (mmu_has_feature(MMU_FTR_HAS_TLBIVAX_BCAST)) {
+			int lock = mmu_has_feature(MMU_FTR_TLBIVAX_NEED_LOCK);
+			if (lock)
+				spin_lock(&tlbivax_lock);
+			_tlbivax_bcast(vmaddr, pid);
+			if (lock)
+				spin_unlock(&tlbivax_lock);
+			goto bail;
+		} else {
+			struct tlb_flush_param p = { .pid = pid, .addr = vmaddr };
+			smp_call_function_mask(cpu_mask,
+					       do_flush_tlb_page_ipi, &p, 1);
+		}
+	}
+	_tlbil_va(vmaddr, pid);
+ bail:
+	preempt_enable();
+}
+EXPORT_SYMBOL(flush_tlb_page);
+
+#endif /* CONFIG_SMP */
+
+/*
+ * Flush kernel TLB entries in the given range
+ */
+void flush_tlb_kernel_range(unsigned long start, unsigned long end)
+{
+#ifdef CONFIG_SMP
+	preempt_disable();
+	smp_call_function(do_flush_tlb_mm_ipi, NULL, 1);
+	_tlbil_pid(0);
+	preempt_enable();
+#endif
+	_tlbil_pid(0);
+}
+EXPORT_SYMBOL(flush_tlb_kernel_range);
+
+/*
+ * Currently, for range flushing, we just do a full mm flush. This should
+ * be optimized based on a threshold on the size of the range, since
+ * some implementation can stack multiple tlbivax before a tlbsync but
+ * for now, we keep it that way
+ */
+void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
+		     unsigned long end)
+
+{
+	flush_tlb_mm(vma->vm_mm);
+}
+EXPORT_SYMBOL(flush_tlb_range);
Index: linux-work/arch/powerpc/kernel/misc_32.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/misc_32.S	2008-12-15 14:36:20.000000000 +1100
+++ linux-work/arch/powerpc/kernel/misc_32.S	2008-12-15 14:37:28.000000000 +1100
@@ -29,6 +29,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/processor.h>
 #include <asm/kexec.h>
+#include <asm/bug.h>
 
 	.text
 
@@ -496,6 +497,14 @@ _GLOBAL(_tlbil_va)
 	blr
 #endif /* CONFIG_FSL_BOOKE */
 
+/*
+ * Nobody implements this yet
+ */
+_GLOBAL(_tlbivax_bcast)
+1:	trap
+	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,0;
+	blr
+
 
 /*
  * Flush instruction cache.
Index: linux-work/arch/powerpc/kernel/ppc_ksyms.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/ppc_ksyms.c	2008-12-15 14:36:20.000000000 +1100
+++ linux-work/arch/powerpc/kernel/ppc_ksyms.c	2008-12-15 14:36:20.000000000 +1100
@@ -116,12 +116,6 @@ EXPORT_SYMBOL(giveup_spe);
 
 #ifndef CONFIG_PPC64
 EXPORT_SYMBOL(flush_instruction_cache);
-EXPORT_SYMBOL(flush_tlb_kernel_range);
-EXPORT_SYMBOL(flush_tlb_page);
-EXPORT_SYMBOL(_tlbie);
-#if defined(CONFIG_4xx) || defined(CONFIG_8xx) || defined(CONFIG_FSL_BOOKE)
-EXPORT_SYMBOL(_tlbil_va);
-#endif
 #endif
 EXPORT_SYMBOL(__flush_icache_range);
 EXPORT_SYMBOL(flush_dcache_range);
Index: linux-work/arch/powerpc/mm/tlb_hash32.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/tlb_hash32.c	2008-12-15 14:36:20.000000000 +1100
+++ linux-work/arch/powerpc/mm/tlb_hash32.c	2008-12-15 14:36:20.000000000 +1100
@@ -137,6 +137,7 @@ void flush_tlb_kernel_range(unsigned lon
 	flush_range(&init_mm, start, end);
 	FINISH_FLUSH;
 }
+EXPORT_SYMBOL(flush_tlb_kernel_range);
 
 /*
  * Flush all the (user) entries for the address space described by mm.
@@ -160,6 +161,7 @@ void flush_tlb_mm(struct mm_struct *mm)
 		flush_range(mp->vm_mm, mp->vm_start, mp->vm_end);
 	FINISH_FLUSH;
 }
+EXPORT_SYMBOL(flush_tlb_mm);
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 {
@@ -176,6 +178,7 @@ void flush_tlb_page(struct vm_area_struc
 		flush_hash_pages(mm->context.id, vmaddr, pmd_val(*pmd), 1);
 	FINISH_FLUSH;
 }
+EXPORT_SYMBOL(flush_tlb_page);
 
 /*
  * For each address in the range, find the pte for the address
@@ -188,3 +191,4 @@ void flush_tlb_range(struct vm_area_stru
 	flush_range(vma->vm_mm, start, end);
 	FINISH_FLUSH;
 }
+EXPORT_SYMBOL(flush_tlb_range);
Index: linux-work/arch/powerpc/include/asm/mmu.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/mmu.h	2008-12-15 14:36:20.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/mmu.h	2008-12-15 14:36:20.000000000 +1100
@@ -15,6 +15,9 @@
 #define MMU_FTR_TYPE_FSL_E		ASM_CONST(0x00000010)
 #define MMU_FTR_HAS_HIGH_BATS		ASM_CONST(0x00010000)
 #define MMU_FTR_BIG_PHYS		ASM_CONST(0x00020000)
+#define MMU_FTR_HAS_TLBIVAX_BCAST	ASM_CONST(0x00040000)
+#define MMU_FTR_HAS_TLBILX_PID		ASM_CONST(0x00080000)
+#define MMU_FTR_TLBIVAX_NEED_LOCK	ASM_CONST(0x00100000)
 
 #ifndef __ASSEMBLY__
 #include <asm/cputable.h>
Index: linux-work/arch/powerpc/include/asm/highmem.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/highmem.h	2008-12-08 15:40:33.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/highmem.h	2008-12-15 14:36:20.000000000 +1100
@@ -85,7 +85,7 @@ static inline void *kmap_atomic_prot(str
 	BUG_ON(!pte_none(*(kmap_pte-idx)));
 #endif
 	__set_pte_at(&init_mm, vaddr, kmap_pte-idx, mk_pte(page, prot));
-	local_flush_tlb_page(vaddr);
+	local_flush_tlb_page(NULL, vaddr);
 
 	return (void*) vaddr;
 }
@@ -113,7 +113,7 @@ static inline void kunmap_atomic(void *k
 	 * this pte without first remap it
 	 */
 	pte_clear(&init_mm, vaddr, kmap_pte-idx);
-	local_flush_tlb_page(vaddr);
+	local_flush_tlb_page(NULL, vaddr);
 #endif
 	pagefault_enable();
 }
Index: linux-work/arch/powerpc/mm/fault.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/fault.c	2008-12-03 13:32:53.000000000 +1100
+++ linux-work/arch/powerpc/mm/fault.c	2008-12-15 14:36:20.000000000 +1100
@@ -284,7 +284,7 @@ good_area:
 				}
 				pte_update(ptep, 0, _PAGE_HWEXEC |
 					   _PAGE_ACCESSED);
-				_tlbie(address, mm->context.id);
+				local_flush_tlb_page(vma, address);
 				pte_unmap_unlock(ptep, ptl);
 				up_read(&mm->mmap_sem);
 				return 0;
Index: linux-work/arch/powerpc/mm/mem.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/mem.c	2008-11-24 14:48:55.000000000 +1100
+++ linux-work/arch/powerpc/mm/mem.c	2008-12-15 14:36:20.000000000 +1100
@@ -488,7 +488,7 @@ void update_mmu_cache(struct vm_area_str
 		 * we invalidate the TLB here, thus avoiding dcbst
 		 * misbehaviour.
 		 */
-		_tlbie(address, 0 /* 8xx doesn't care about PID */);
+		_tlbil_va(address, 0 /* 8xx doesn't care about PID */);
 #endif
 		/* The _PAGE_USER test should really be _PAGE_EXEC, but
 		 * older glibc versions execute some code from no-exec
