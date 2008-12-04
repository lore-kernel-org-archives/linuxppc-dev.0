Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 04 Dec 2008 16:41:48 +1100
Subject: [PATCH 2/3] powerpc: Split mmu_context handling
Message-Id: <20081204054228.E8FE6DDE0F@ozlabs.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This splits the mmu_context handling between 32-bit hash based processors,
64-bit hash based processors and everybody else. This is preliminary work
for adding SMP support for BookE processors.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/bug.h               |    9 
 arch/powerpc/include/asm/mmu_context.h       |  266 +++------------------------
 arch/powerpc/kernel/asm-offsets.c            |    1 
 arch/powerpc/kernel/head_32.S                |   14 +
 arch/powerpc/kernel/ppc_ksyms.c              |    3 
 arch/powerpc/kernel/swsusp.c                 |    2 
 arch/powerpc/mm/Makefile                     |    6 
 arch/powerpc/mm/mmu_context_hash32.c         |  101 ++++++++++
 arch/powerpc/mm/mmu_context_hash64.c         |   78 +++++++
 arch/powerpc/mm/mmu_context_nohash.c         |  168 +++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype       |   18 +
 arch/powerpc/platforms/powermac/cpufreq_32.c |    2 
 drivers/macintosh/via-pmu.c                  |    4 
 13 files changed, 430 insertions(+), 242 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/bug.h	2008-12-03 13:50:01.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/bug.h	2008-12-03 13:50:18.000000000 +1100
@@ -26,7 +26,7 @@
 	 .previous
 .endm
 #else
- .macro EMIT_BUG_ENTRY addr,file,line,flags
+.macro EMIT_BUG_ENTRY addr,file,line,flags
 	 .section __bug_table,"a"
 5001:	 PPC_LONG \addr
 	 .short \flags
@@ -113,6 +113,13 @@
 #define HAVE_ARCH_BUG_ON
 #define HAVE_ARCH_WARN_ON
 #endif /* __ASSEMBLY __ */
+#else
+#ifdef __ASSEMBLY__
+.macro EMIT_BUG_ENTRY addr,file,line,flags
+.endm
+#else /* !__ASSEMBLY__ */
+#define _EMIT_BUG_ENTRY
+#endif
 #endif /* CONFIG_BUG */
 
 #include <asm-generic/bug.h>
Index: linux-work/arch/powerpc/include/asm/mmu_context.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/mmu_context.h	2008-12-03 13:50:01.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/mmu_context.h	2008-12-03 13:50:18.000000000 +1100
@@ -2,270 +2,71 @@
 #define __ASM_POWERPC_MMU_CONTEXT_H
 #ifdef __KERNEL__
 
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
 #include <asm/mmu.h>	
 #include <asm/cputable.h>
 #include <asm-generic/mm_hooks.h>
-
-#ifndef CONFIG_PPC64
-#include <asm/atomic.h>
-#include <linux/bitops.h>
-
-/*
- * On 32-bit PowerPC 6xx/7xx/7xxx CPUs, we use a set of 16 VSIDs
- * (virtual segment identifiers) for each context.  Although the
- * hardware supports 24-bit VSIDs, and thus >1 million contexts,
- * we only use 32,768 of them.  That is ample, since there can be
- * at most around 30,000 tasks in the system anyway, and it means
- * that we can use a bitmap to indicate which contexts are in use.
- * Using a bitmap means that we entirely avoid all of the problems
- * that we used to have when the context number overflowed,
- * particularly on SMP systems.
- *  -- paulus.
- */
-
-/*
- * This function defines the mapping from contexts to VSIDs (virtual
- * segment IDs).  We use a skew on both the context and the high 4 bits
- * of the 32-bit virtual address (the "effective segment ID") in order
- * to spread out the entries in the MMU hash table.  Note, if this
- * function is changed then arch/ppc/mm/hashtable.S will have to be
- * changed to correspond.
- */
-#define CTX_TO_VSID(ctx, va)	(((ctx) * (897 * 16) + ((va) >> 28) * 0x111) \
-				 & 0xffffff)
-
-/*
-   The MPC8xx has only 16 contexts.  We rotate through them on each
-   task switch.  A better way would be to keep track of tasks that
-   own contexts, and implement an LRU usage.  That way very active
-   tasks don't always have to pay the TLB reload overhead.  The
-   kernel pages are mapped shared, so the kernel can run on behalf
-   of any task that makes a kernel entry.  Shared does not mean they
-   are not protected, just that the ASID comparison is not performed.
-        -- Dan
-
-   The IBM4xx has 256 contexts, so we can just rotate through these
-   as a way of "switching" contexts.  If the TID of the TLB is zero,
-   the PID/TID comparison is disabled, so we can use a TID of zero
-   to represent all kernel pages as shared among all contexts.
-   	-- Dan
- */
-
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
-#ifdef CONFIG_8xx
-#define NO_CONTEXT      	16
-#define LAST_CONTEXT    	15
-#define FIRST_CONTEXT    	0
-
-#elif defined(CONFIG_4xx)
-#define NO_CONTEXT      	256
-#define LAST_CONTEXT    	255
-#define FIRST_CONTEXT    	1
-
-#elif defined(CONFIG_E200) || defined(CONFIG_E500)
-#define NO_CONTEXT      	256
-#define LAST_CONTEXT    	255
-#define FIRST_CONTEXT    	1
-
-#else
-
-/* PPC 6xx, 7xx CPUs */
-#define NO_CONTEXT      	((unsigned long) -1)
-#define LAST_CONTEXT    	32767
-#define FIRST_CONTEXT    	1
-#endif
+#include <asm/cputhreads.h>
 
 /*
- * Set the current MMU context.
- * On 32-bit PowerPCs (other than the 8xx embedded chips), this is done by
- * loading up the segment registers for the user part of the address space.
- *
- * Since the PGD is immediately available, it is much faster to simply
- * pass this along as a second parameter, which is required for 8xx and
- * can be used for debugging on all processors (if you happen to have
- * an Abatron).
+ * Most if the context management is out of line
  */
-extern void set_context(unsigned long contextid, pgd_t *pgd);
-
-/*
- * Bitmap of contexts in use.
- * The size of this bitmap is LAST_CONTEXT + 1 bits.
- */
-extern unsigned long context_map[];
-
-/*
- * This caches the next context number that we expect to be free.
- * Its use is an optimization only, we can't rely on this context
- * number to be free, but it usually will be.
- */
-extern unsigned long next_mmu_context;
-
-/*
- * If we don't have sufficient contexts to give one to every task
- * that could be in the system, we need to be able to steal contexts.
- * These variables support that.
- */
-#if LAST_CONTEXT < 30000
-#define FEW_CONTEXTS	1
-extern atomic_t nr_free_contexts;
-extern struct mm_struct *context_mm[LAST_CONTEXT+1];
-extern void steal_context(void);
-#endif
-
-/*
- * Get a new mmu context for the address space described by `mm'.
- */
-static inline void get_mmu_context(struct mm_struct *mm)
-{
-	unsigned long ctx;
-
-	if (mm->context.id != NO_CONTEXT)
-		return;
-#ifdef FEW_CONTEXTS
-	while (atomic_dec_if_positive(&nr_free_contexts) < 0)
-		steal_context();
-#endif
-	ctx = next_mmu_context;
-	while (test_and_set_bit(ctx, context_map)) {
-		ctx = find_next_zero_bit(context_map, LAST_CONTEXT+1, ctx);
-		if (ctx > LAST_CONTEXT)
-			ctx = 0;
-	}
-	next_mmu_context = (ctx + 1) & LAST_CONTEXT;
-	mm->context.id = ctx;
-#ifdef FEW_CONTEXTS
-	context_mm[ctx] = mm;
-#endif
-}
-
-/*
- * Set up the context for a new address space.
- */
-static inline int init_new_context(struct task_struct *t, struct mm_struct *mm)
-{
-	mm->context.id = NO_CONTEXT;
-	return 0;
-}
-
-/*
- * We're finished using the context for an address space.
- */
-static inline void destroy_context(struct mm_struct *mm)
-{
-	preempt_disable();
-	if (mm->context.id != NO_CONTEXT) {
-		clear_bit(mm->context.id, context_map);
-		mm->context.id = NO_CONTEXT;
-#ifdef FEW_CONTEXTS
-		atomic_inc(&nr_free_contexts);
-#endif
-	}
-	preempt_enable();
-}
-
-static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
-			     struct task_struct *tsk)
-{
-#ifdef CONFIG_ALTIVEC
-	if (cpu_has_feature(CPU_FTR_ALTIVEC))
-	asm volatile ("dssall;\n"
-#ifndef CONFIG_POWER4
-	 "sync;\n" /* G4 needs a sync here, G5 apparently not */
-#endif
-	 : : );
-#endif /* CONFIG_ALTIVEC */
-
-	tsk->thread.pgdir = next->pgd;
-
-	if (!cpu_isset(smp_processor_id(), next->cpu_vm_mask))
-		cpu_set(smp_processor_id(), next->cpu_vm_mask);
-
-	/* No need to flush userspace segments if the mm doesnt change */
-	if (prev == next)
-		return;
-
-	/* Setup new userspace context */
-	get_mmu_context(next);
-	set_context(next->context.id, next->pgd);
-}
-
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
-/*
- * After we have set current->mm to a new value, this activates
- * the context for the new mm so we see the new mappings.
- */
-#define activate_mm(active_mm, mm)   switch_mm(active_mm, mm, current)
-
 extern void mmu_context_init(void);
-
-
-#else
-
-#include <linux/kernel.h>	
-#include <linux/mm.h>	
-#include <linux/sched.h>
-
-/*
- * Copyright (C) 2001 PPC 64 Team, IBM Corp
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-static inline void enter_lazy_tlb(struct mm_struct *mm,
-				  struct task_struct *tsk)
-{
-}
-
-/*
- * The proto-VSID space has 2^35 - 1 segments available for user mappings.
- * Each segment contains 2^28 bytes.  Each context maps 2^44 bytes,
- * so we can support 2^19-1 contexts (19 == 35 + 28 - 44).
- */
-#define NO_CONTEXT	0
-#define MAX_CONTEXT	((1UL << 19) - 1)
-
 extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
 extern void destroy_context(struct mm_struct *mm);
 
+extern void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next);
 extern void switch_stab(struct task_struct *tsk, struct mm_struct *mm);
 extern void switch_slb(struct task_struct *tsk, struct mm_struct *mm);
+extern void set_context(unsigned long id, pgd_t *pgd);
 
-/*
- * switch_mm is the entry point called from the architecture independent
+/* switch_mm is the entry point called from the architecture independent
  * code in kernel/sched.c
  */
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 			     struct task_struct *tsk)
 {
-	if (!cpu_isset(smp_processor_id(), next->cpu_vm_mask))
-		cpu_set(smp_processor_id(), next->cpu_vm_mask);
+	/* Mark this context has been used on the new CPU */
+	cpu_set(smp_processor_id(), next->cpu_vm_mask);
+
+	/* 32-bit keeps track of the current PGDIR in the thread struct */
+#ifdef CONFIG_PPC32
+	tsk->thread.pgdir = next->pgd;
+#endif /* CONFIG_PPC32 */
 
-	/* No need to flush userspace segments if the mm doesnt change */
+	/* Nothing else to do if we aren't actually switching */
 	if (prev == next)
 		return;
 
+	/* We must stop all altivec streams before changing the HW
+	 * context
+	 */
 #ifdef CONFIG_ALTIVEC
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
 		asm volatile ("dssall");
 #endif /* CONFIG_ALTIVEC */
 
+	/* The actual HW switching method differs between the various
+	 * sub architectures.
+	 */
+#ifdef CONFIG_PPC_STD_MMU_64
 	if (cpu_has_feature(CPU_FTR_SLB))
 		switch_slb(tsk, next);
 	else
 		switch_stab(tsk, next);
+#else
+	/* Out of line for now */
+	switch_mmu_context(prev, next);
+#endif
+
 }
 
 #define deactivate_mm(tsk,mm)	do { } while (0)
 
-/*
- * After we have set current->mm to a new value, this activates
+/* After we have set current->mm to a new value, this activates
  * the context for the new mm so we see the new mappings.
  */
 static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
@@ -277,6 +78,11 @@ static inline void activate_mm(struct mm
 	local_irq_restore(flags);
 }
 
-#endif /* CONFIG_PPC64 */
+/* We don't currently use enter_lazy_tlb() for anything */
+static inline void enter_lazy_tlb(struct mm_struct *mm,
+				  struct task_struct *tsk)
+{
+}
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_MMU_CONTEXT_H */
Index: linux-work/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/asm-offsets.c	2008-12-03 13:50:01.000000000 +1100
+++ linux-work/arch/powerpc/kernel/asm-offsets.c	2008-12-03 13:50:18.000000000 +1100
@@ -60,6 +60,7 @@ int main(void)
 {
 	DEFINE(THREAD, offsetof(struct task_struct, thread));
 	DEFINE(MM, offsetof(struct task_struct, mm));
+	DEFINE(MMCONTEXTID, offsetof(struct mm_struct, context.id));
 #ifdef CONFIG_PPC64
 	DEFINE(AUDITCONTEXT, offsetof(struct task_struct, audit_context));
 #else
Index: linux-work/arch/powerpc/kernel/head_32.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_32.S	2008-12-03 13:50:01.000000000 +1100
+++ linux-work/arch/powerpc/kernel/head_32.S	2008-12-03 13:50:18.000000000 +1100
@@ -31,6 +31,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
+#include <asm/bug.h>
 
 /* 601 only have IBAT; cr0.eq is set on 601 when using this macro */
 #define LOAD_BAT(n, reg, RA, RB)	\
@@ -1050,7 +1051,7 @@ start_here:
 	 * We do this here because we know the mmu is disabled, and
 	 * will be enabled for real in just a few instructions.
 	 */
-	lis	r5, abatron_pteptrs@h
+	lis	r5, abatron_pteptrs@h\
 	ori	r5, r5, abatron_pteptrs@l
 	stw	r5, 0xf0(r0)	/* This much match your Abatron config */
 	lis	r6, swapper_pg_dir@h
@@ -1070,9 +1071,14 @@ start_here:
 	RFI
 
 /*
+ * void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next);
+ *
  * Set up the segment registers for a new context.
  */
-_ENTRY(set_context)
+_ENTRY(switch_mmu_context)
+	lwz	r3,MMCONTEXTID(r4)
+	cmpwi	cr0,r3,0
+	blt-	4f
 	mulli	r3,r3,897	/* multiply context by skew factor */
 	rlwinm	r3,r3,4,8,27	/* VSID = (context & 0xfffff) << 4 */
 	addis	r3,r3,0x6000	/* Set Ks, Ku bits */
@@ -1083,6 +1089,7 @@ _ENTRY(set_context)
 	/* Context switch the PTE pointer for the Abatron BDI2000.
 	 * The PGDIR is passed as second argument.
 	 */
+	lwz	r4,MM_PGD(r4)
 	lis	r5, KERNELBASE@h
 	lwz	r5, 0xf0(r5)
 	stw	r4, 0x4(r5)
@@ -1098,6 +1105,9 @@ _ENTRY(set_context)
 	sync
 	isync
 	blr
+4:	trap
+	EMIT_BUG_ENTRY 4b,__FILE__,__LINE__,BUGFLAG_WARNING
+	blr
 
 /*
  * An undocumented "feature" of 604e requires that the v bit
Index: linux-work/arch/powerpc/kernel/ppc_ksyms.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/ppc_ksyms.c	2008-12-03 13:50:01.000000000 +1100
+++ linux-work/arch/powerpc/kernel/ppc_ksyms.c	2008-12-03 13:50:18.000000000 +1100
@@ -174,8 +174,7 @@ EXPORT_SYMBOL(cacheable_memcpy);
 #endif
 
 #ifdef CONFIG_PPC32
-EXPORT_SYMBOL(next_mmu_context);
-EXPORT_SYMBOL(set_context);
+EXPORT_SYMBOL(switch_mmu_context);
 #endif
 
 #ifdef CONFIG_PPC_STD_MMU_32
Index: linux-work/arch/powerpc/kernel/swsusp.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/swsusp.c	2008-12-03 13:50:01.000000000 +1100
+++ linux-work/arch/powerpc/kernel/swsusp.c	2008-12-03 13:50:18.000000000 +1100
@@ -34,6 +34,6 @@ void save_processor_state(void)
 void restore_processor_state(void)
 {
 #ifdef CONFIG_PPC32
-	set_context(current->active_mm->context.id, current->active_mm->pgd);
+	switch_mmu_context(NULL, current->active_mm);
 #endif
 }
Index: linux-work/arch/powerpc/mm/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/mm/Makefile	2008-12-03 13:50:17.000000000 +1100
+++ linux-work/arch/powerpc/mm/Makefile	2008-12-03 13:50:18.000000000 +1100
@@ -8,8 +8,10 @@ endif
 
 obj-y				:= fault.o mem.o pgtable.o \
 				   init_$(CONFIG_WORD_SIZE).o \
-				   pgtable_$(CONFIG_WORD_SIZE).o \
-				   mmu_context_$(CONFIG_WORD_SIZE).o
+				   pgtable_$(CONFIG_WORD_SIZE).o
+obj-$(CONFIG_PPC_STD_MMU_32)	+= mmu_context_hash32.o
+obj-$(CONFIG_PPC_STD_MMU_64)	+= mmu_context_hash64.o
+obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o
 hash-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
 obj-$(CONFIG_PPC64)		+= hash_utils_64.o \
 				   slb_low.o slb.o stab.o \
Index: linux-work/arch/powerpc/mm/mmu_context_hash32.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/mm/mmu_context_hash32.c	2008-12-03 13:50:18.000000000 +1100
@@ -0,0 +1,101 @@
+/*
+ * This file contains the routines for handling the MMU on those
+ * PowerPC implementations where the MMU substantially follows the
+ * architecture specification.  This includes the 6xx, 7xx, 7xxx,
+ * 8260, and POWER3 implementations but excludes the 8xx and 4xx.
+ *  -- paulus
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
+#include <linux/mm.h>
+#include <linux/init.h>
+
+#include <asm/mmu_context.h>
+#include <asm/tlbflush.h>
+
+/*
+ * On 32-bit PowerPC 6xx/7xx/7xxx CPUs, we use a set of 16 VSIDs
+ * (virtual segment identifiers) for each context.  Although the
+ * hardware supports 24-bit VSIDs, and thus >1 million contexts,
+ * we only use 32,768 of them.  That is ample, since there can be
+ * at most around 30,000 tasks in the system anyway, and it means
+ * that we can use a bitmap to indicate which contexts are in use.
+ * Using a bitmap means that we entirely avoid all of the problems
+ * that we used to have when the context number overflowed,
+ * particularly on SMP systems.
+ *  -- paulus.
+ */
+#define NO_CONTEXT      	((unsigned long) -1)
+#define LAST_CONTEXT    	32767
+#define FIRST_CONTEXT    	1
+
+/*
+ * This function defines the mapping from contexts to VSIDs (virtual
+ * segment IDs).  We use a skew on both the context and the high 4 bits
+ * of the 32-bit virtual address (the "effective segment ID") in order
+ * to spread out the entries in the MMU hash table.  Note, if this
+ * function is changed then arch/ppc/mm/hashtable.S will have to be
+ * changed to correspond.
+ */
+#define CTX_TO_VSID(ctx, va)	(((ctx) * (897 * 16) + ((va) >> 28) * 0x111) \
+				 & 0xffffff)
+
+static unsigned long next_mmu_context;
+static unsigned long context_map[LAST_CONTEXT / BITS_PER_LONG + 1];
+
+
+/*
+ * Set up the context for a new address space.
+ */
+int init_new_context(struct task_struct *t, struct mm_struct *mm)
+{
+	unsigned long ctx = next_mmu_context;
+
+	while (test_and_set_bit(ctx, context_map)) {
+		ctx = find_next_zero_bit(context_map, LAST_CONTEXT+1, ctx);
+		if (ctx > LAST_CONTEXT)
+			ctx = 0;
+	}
+	next_mmu_context = (ctx + 1) & LAST_CONTEXT;
+	mm->context.id = ctx;
+
+	return 0;
+}
+
+/*
+ * We're finished using the context for an address space.
+ */
+void destroy_context(struct mm_struct *mm)
+{
+	preempt_disable();
+	if (mm->context.id != NO_CONTEXT) {
+		clear_bit(mm->context.id, context_map);
+		mm->context.id = NO_CONTEXT;
+	}
+	preempt_enable();
+}
+
+/*
+ * Initialize the context management stuff.
+ */
+void __init mmu_context_init(void)
+{
+	/* Reserve context 0 for kernel use */
+	context_map[0] = (1 << FIRST_CONTEXT) - 1;
+	next_mmu_context = FIRST_CONTEXT;
+}
Index: linux-work/arch/powerpc/mm/mmu_context_hash64.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/mm/mmu_context_hash64.c	2008-12-03 13:50:18.000000000 +1100
@@ -0,0 +1,78 @@
+/*
+ *  MMU context allocation for 64-bit kernels.
+ *
+ *  Copyright (C) 2004 Anton Blanchard, IBM Corp. <anton@samba.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/spinlock.h>
+#include <linux/idr.h>
+
+#include <asm/mmu_context.h>
+
+static DEFINE_SPINLOCK(mmu_context_lock);
+static DEFINE_IDR(mmu_context_idr);
+
+/*
+ * The proto-VSID space has 2^35 - 1 segments available for user mappings.
+ * Each segment contains 2^28 bytes.  Each context maps 2^44 bytes,
+ * so we can support 2^19-1 contexts (19 == 35 + 28 - 44).
+ */
+#define NO_CONTEXT	0
+#define MAX_CONTEXT	((1UL << 19) - 1)
+
+int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	int index;
+	int err;
+
+again:
+	if (!idr_pre_get(&mmu_context_idr, GFP_KERNEL))
+		return -ENOMEM;
+
+	spin_lock(&mmu_context_lock);
+	err = idr_get_new_above(&mmu_context_idr, NULL, 1, &index);
+	spin_unlock(&mmu_context_lock);
+
+	if (err == -EAGAIN)
+		goto again;
+	else if (err)
+		return err;
+
+	if (index > MAX_CONTEXT) {
+		spin_lock(&mmu_context_lock);
+		idr_remove(&mmu_context_idr, index);
+		spin_unlock(&mmu_context_lock);
+		return -ENOMEM;
+	}
+
+	/* The old code would re-promote on fork, we don't do that
+	 * when using slices as it could cause problem promoting slices
+	 * that have been forced down to 4K
+	 */
+	if (slice_mm_new_context(mm))
+		slice_set_user_psize(mm, mmu_virtual_psize);
+	mm->context.id = index;
+
+	return 0;
+}
+
+void destroy_context(struct mm_struct *mm)
+{
+	spin_lock(&mmu_context_lock);
+	idr_remove(&mmu_context_idr, mm->context.id);
+	spin_unlock(&mmu_context_lock);
+
+	mm->context.id = NO_CONTEXT;
+}
Index: linux-work/arch/powerpc/mm/mmu_context_nohash.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/mm/mmu_context_nohash.c	2008-12-03 13:50:18.000000000 +1100
@@ -0,0 +1,168 @@
+/*
+ * This file contains the routines for handling the MMU on those
+ * PowerPC implementations where the MMU substantially follows the
+ * architecture specification.  This includes the 6xx, 7xx, 7xxx,
+ * 8260, and POWER3 implementations but excludes the 8xx and 4xx.
+ *  -- paulus
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
+#include <linux/mm.h>
+#include <linux/init.h>
+
+#include <asm/mmu_context.h>
+#include <asm/tlbflush.h>
+
+/*
+ *   The MPC8xx has only 16 contexts.  We rotate through them on each
+ * task switch.  A better way would be to keep track of tasks that
+ * own contexts, and implement an LRU usage.  That way very active
+ * tasks don't always have to pay the TLB reload overhead.  The
+ * kernel pages are mapped shared, so the kernel can run on behalf
+ * of any task that makes a kernel entry.  Shared does not mean they
+ * are not protected, just that the ASID comparison is not performed.
+ *      -- Dan
+ *
+ * The IBM4xx has 256 contexts, so we can just rotate through these
+ * as a way of "switching" contexts.  If the TID of the TLB is zero,
+ * the PID/TID comparison is disabled, so we can use a TID of zero
+ * to represent all kernel pages as shared among all contexts.
+ * 	-- Dan
+ */
+
+#ifdef CONFIG_8xx
+#define NO_CONTEXT      	16
+#define LAST_CONTEXT    	15
+#define FIRST_CONTEXT    	0
+
+#elif defined(CONFIG_4xx)
+#define NO_CONTEXT      	256
+#define LAST_CONTEXT    	255
+#define FIRST_CONTEXT    	1
+
+#elif defined(CONFIG_E200) || defined(CONFIG_E500)
+#define NO_CONTEXT      	256
+#define LAST_CONTEXT    	255
+#define FIRST_CONTEXT    	1
+
+#else
+#error Unsupported processor type
+#endif
+
+static unsigned long next_mmu_context;
+static unsigned long context_map[LAST_CONTEXT / BITS_PER_LONG + 1];
+static atomic_t nr_free_contexts;
+static struct mm_struct *context_mm[LAST_CONTEXT+1];
+static void steal_context(void);
+
+/* Steal a context from a task that has one at the moment.
+ * This is only used on 8xx and 4xx and we presently assume that
+ * they don't do SMP.  If they do then this will have to check
+ * whether the MM we steal is in use.
+ * We also assume that this is only used on systems that don't
+ * use an MMU hash table - this is true for 8xx and 4xx.
+ * This isn't an LRU system, it just frees up each context in
+ * turn (sort-of pseudo-random replacement :).  This would be the
+ * place to implement an LRU scheme if anyone was motivated to do it.
+ *  -- paulus
+ */
+static void steal_context(void)
+{
+	struct mm_struct *mm;
+
+	/* free up context `next_mmu_context' */
+	/* if we shouldn't free context 0, don't... */
+	if (next_mmu_context < FIRST_CONTEXT)
+		next_mmu_context = FIRST_CONTEXT;
+	mm = context_mm[next_mmu_context];
+	flush_tlb_mm(mm);
+	destroy_context(mm);
+}
+
+
+/*
+ * Get a new mmu context for the address space described by `mm'.
+ */
+static inline void get_mmu_context(struct mm_struct *mm)
+{
+	unsigned long ctx;
+
+	if (mm->context.id != NO_CONTEXT)
+		return;
+
+	while (atomic_dec_if_positive(&nr_free_contexts) < 0)
+		steal_context();
+
+	ctx = next_mmu_context;
+	while (test_and_set_bit(ctx, context_map)) {
+		ctx = find_next_zero_bit(context_map, LAST_CONTEXT+1, ctx);
+		if (ctx > LAST_CONTEXT)
+			ctx = 0;
+	}
+	next_mmu_context = (ctx + 1) & LAST_CONTEXT;
+	mm->context.id = ctx;
+	context_mm[ctx] = mm;
+}
+
+void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
+{
+	get_mmu_context(next);
+
+	set_context(next->context.id, next->pgd);
+}
+
+/*
+ * Set up the context for a new address space.
+ */
+int init_new_context(struct task_struct *t, struct mm_struct *mm)
+{
+	mm->context.id = NO_CONTEXT;
+	return 0;
+}
+
+/*
+ * We're finished using the context for an address space.
+ */
+void destroy_context(struct mm_struct *mm)
+{
+	preempt_disable();
+	if (mm->context.id != NO_CONTEXT) {
+		clear_bit(mm->context.id, context_map);
+		mm->context.id = NO_CONTEXT;
+		atomic_inc(&nr_free_contexts);
+	}
+	preempt_enable();
+}
+
+
+/*
+ * Initialize the context management stuff.
+ */
+void __init mmu_context_init(void)
+{
+	/*
+	 * Some processors have too few contexts to reserve one for
+	 * init_mm, and require using context 0 for a normal task.
+	 * Other processors reserve the use of context zero for the kernel.
+	 * This code assumes FIRST_CONTEXT < 32.
+	 */
+	context_map[0] = (1 << FIRST_CONTEXT) - 1;
+	next_mmu_context = FIRST_CONTEXT;
+	atomic_set(&nr_free_contexts, LAST_CONTEXT - FIRST_CONTEXT + 1);
+}
+
Index: linux-work/arch/powerpc/platforms/Kconfig.cputype
===================================================================
--- linux-work.orig/arch/powerpc/platforms/Kconfig.cputype	2008-12-03 13:50:01.000000000 +1100
+++ linux-work/arch/powerpc/platforms/Kconfig.cputype	2008-12-03 13:50:18.000000000 +1100
@@ -195,13 +195,29 @@ config SPE
 
 config PPC_STD_MMU
 	bool
-	depends on 6xx || POWER3 || POWER4 || PPC64
+	depends on 6xx || PPC64
 	default y
 
 config PPC_STD_MMU_32
 	def_bool y
 	depends on PPC_STD_MMU && PPC32
 
+config PPC_STD_MMU_64
+	def_bool y
+	depends on PPC_STD_MMU && PPC64
+
+config PPC_MMU_NOHASH
+	def_bool y
+	depends on !PPC_STD_MMU
+
+config PPC_MMU_NOHASH_32
+	def_bool y
+	depends on PPC_MMU_NOHASH && PPC32
+
+config PPC_MMU_NOHASH_64
+	def_bool y
+	depends on PPC_MMU_NOHASH && PPC64
+
 config PPC_MM_SLICES
 	bool
 	default y if HUGETLB_PAGE || PPC_64K_PAGES
Index: linux-work/arch/powerpc/platforms/powermac/cpufreq_32.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/cpufreq_32.c	2008-12-03 13:50:01.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/cpufreq_32.c	2008-12-03 13:50:18.000000000 +1100
@@ -310,7 +310,7 @@ static int pmu_set_cpu_speed(int low_spe
  		_set_L3CR(save_l3cr);
 
 	/* Restore userland MMU context */
-	set_context(current->active_mm->context.id, current->active_mm->pgd);
+	switch_mmu_context(NULL, current->active_mm);
 
 #ifdef DEBUG_FREQ
 	printk(KERN_DEBUG "HID1, after: %x\n", mfspr(SPRN_HID1));
Index: linux-work/drivers/macintosh/via-pmu.c
===================================================================
--- linux-work.orig/drivers/macintosh/via-pmu.c	2008-12-03 13:50:01.000000000 +1100
+++ linux-work/drivers/macintosh/via-pmu.c	2008-12-03 13:50:18.000000000 +1100
@@ -1814,7 +1814,7 @@ static int powerbook_sleep_grackle(void)
  		_set_L2CR(save_l2cr);
 	
 	/* Restore userland MMU context */
-	set_context(current->active_mm->context.id, current->active_mm->pgd);
+	switch_mmu_context(NULL, current->active_mm);
 
 	/* Power things up */
 	pmu_unlock();
@@ -1903,7 +1903,7 @@ powerbook_sleep_Core99(void)
  		_set_L3CR(save_l3cr);
 	
 	/* Restore userland MMU context */
-	set_context(current->active_mm->context.id, current->active_mm->pgd);
+	switch_mmu_context(NULL, current->active_mm);
 
 	/* Tell PMU we are ready */
 	pmu_unlock();
