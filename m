Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17547.38430.196272.344667@cargo.ozlabs.ibm.com>
Date: Sun, 11 Jun 2006 14:03:42 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: add context.vdso_base for 32-bit too
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds a vdso_base element to the mm_context_t for 32-bit compiles
(both for ARCH=powerpc and ARCH=ppc).  This fixes the compile errors
that have been reported in arch/powerpc/kernel/signal_32.c.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/mm/mmu_context_32.c b/arch/powerpc/mm/mmu_context_32.c
index a8816e0..e326e42 100644
--- a/arch/powerpc/mm/mmu_context_32.c
+++ b/arch/powerpc/mm/mmu_context_32.c
@@ -30,7 +30,7 @@ #include <linux/init.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
 
-mm_context_t next_mmu_context;
+unsigned long next_mmu_context;
 unsigned long context_map[LAST_CONTEXT / BITS_PER_LONG + 1];
 #ifdef FEW_CONTEXTS
 atomic_t nr_free_contexts;
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index ed7fcfe..1df731e 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -190,7 +190,7 @@ void hash_preload(struct mm_struct *mm, 
 		return;
 	pmd = pmd_offset(pgd_offset(mm, ea), ea);
 	if (!pmd_none(*pmd))
-		add_hash_page(mm->context, ea, pmd_val(*pmd));
+		add_hash_page(mm->context.id, ea, pmd_val(*pmd));
 }
 
 /*
diff --git a/arch/powerpc/mm/tlb_32.c b/arch/powerpc/mm/tlb_32.c
index ad580f3..02eb23e 100644
--- a/arch/powerpc/mm/tlb_32.c
+++ b/arch/powerpc/mm/tlb_32.c
@@ -42,7 +42,7 @@ void flush_hash_entry(struct mm_struct *
 
 	if (Hash != 0) {
 		ptephys = __pa(ptep) & PAGE_MASK;
-		flush_hash_pages(mm->context, addr, ptephys, 1);
+		flush_hash_pages(mm->context.id, addr, ptephys, 1);
 	}
 }
 
@@ -102,7 +102,7 @@ static void flush_range(struct mm_struct
 	pmd_t *pmd;
 	unsigned long pmd_end;
 	int count;
-	unsigned int ctx = mm->context;
+	unsigned int ctx = mm->context.id;
 
 	if (Hash == 0) {
 		_tlbia();
@@ -172,7 +172,7 @@ void flush_tlb_page(struct vm_area_struc
 	mm = (vmaddr < TASK_SIZE)? vma->vm_mm: &init_mm;
 	pmd = pmd_offset(pgd_offset(mm, vmaddr), vmaddr);
 	if (!pmd_none(*pmd))
-		flush_hash_pages(mm->context, vmaddr, pmd_val(*pmd), 1);
+		flush_hash_pages(mm->context.id, vmaddr, pmd_val(*pmd), 1);
 	FINISH_FLUSH;
 }
 
diff --git a/arch/powerpc/platforms/powermac/cpufreq_32.c b/arch/powerpc/platforms/powermac/cpufreq_32.c
index cfd6527..af2a8f9 100644
--- a/arch/powerpc/platforms/powermac/cpufreq_32.c
+++ b/arch/powerpc/platforms/powermac/cpufreq_32.c
@@ -314,7 +314,7 @@ #endif /* CONFIG_ALTIVEC */
  		_set_L3CR(save_l3cr);
 
 	/* Restore userland MMU context */
-	set_context(current->active_mm->context, current->active_mm->pgd);
+	set_context(current->active_mm->context.id, current->active_mm->pgd);
 
 #ifdef DEBUG_FREQ
 	printk(KERN_DEBUG "HID1, after: %x\n", mfspr(SPRN_HID1));
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index b9200fb..9cc7db7 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -458,7 +458,7 @@ static int pmac_pm_finish(suspend_state_
 	printk(KERN_DEBUG "%s(%d)\n", __FUNCTION__, state);
 
 	/* Restore userland MMU context */
-	set_context(current->active_mm->context, current->active_mm->pgd);
+	set_context(current->active_mm->context.id, current->active_mm->pgd);
 
 	return 0;
 }
diff --git a/arch/ppc/mm/mmu_context.c b/arch/ppc/mm/mmu_context.c
index b4a4b3f..8784f37 100644
--- a/arch/ppc/mm/mmu_context.c
+++ b/arch/ppc/mm/mmu_context.c
@@ -30,7 +30,7 @@ #include <linux/init.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
 
-mm_context_t next_mmu_context;
+unsigned long next_mmu_context;
 unsigned long context_map[LAST_CONTEXT / BITS_PER_LONG + 1];
 #ifdef FEW_CONTEXTS
 atomic_t nr_free_contexts;
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 0b5ff55..c63d4e7 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -2268,7 +2268,7 @@ static int powerbook_sleep_grackle(void)
  		_set_L2CR(save_l2cr);
 	
 	/* Restore userland MMU context */
-	set_context(current->active_mm->context, current->active_mm->pgd);
+	set_context(current->active_mm->context.id, current->active_mm->pgd);
 
 	/* Power things up */
 	pmu_unlock();
@@ -2366,7 +2366,7 @@ powerbook_sleep_Core99(void)
  		_set_L3CR(save_l3cr);
 	
 	/* Restore userland MMU context */
-	set_context(current->active_mm->context, current->active_mm->pgd);
+	set_context(current->active_mm->context.id, current->active_mm->pgd);
 
 	/* Tell PMU we are ready */
 	pmu_unlock();
diff --git a/include/asm-ppc/mmu.h b/include/asm-ppc/mmu.h
index 9205db4..80ae604 100644
--- a/include/asm-ppc/mmu.h
+++ b/include/asm-ppc/mmu.h
@@ -24,8 +24,10 @@ extern phys_addr_t fixup_bigphys_addr(ph
 #define PHYS_FMT	"%16Lx"
 #endif
 
-/* Default "unsigned long" context */
-typedef unsigned long mm_context_t;
+typedef struct {
+	unsigned long id;
+	unsigned long vdso_base;
+} mm_context_t;
 
 /* Hardware Page Table Entry */
 typedef struct _PTE {
diff --git a/include/asm-ppc/mmu_context.h b/include/asm-ppc/mmu_context.h
index 4f152cc..4454ecf 100644
--- a/include/asm-ppc/mmu_context.h
+++ b/include/asm-ppc/mmu_context.h
@@ -71,7 +71,7 @@ #define FIRST_CONTEXT    	1
 #else
 
 /* PPC 6xx, 7xx CPUs */
-#define NO_CONTEXT      	((mm_context_t) -1)
+#define NO_CONTEXT      	((unsigned long) -1)
 #define LAST_CONTEXT    	32767
 #define FIRST_CONTEXT    	1
 #endif
@@ -86,7 +86,7 @@ #endif
  * can be used for debugging on all processors (if you happen to have
  * an Abatron).
  */
-extern void set_context(mm_context_t context, pgd_t *pgd);
+extern void set_context(unsigned long contextid, pgd_t *pgd);
 
 /*
  * Bitmap of contexts in use.
@@ -99,7 +99,7 @@ extern unsigned long context_map[];
  * Its use is an optimization only, we can't rely on this context
  * number to be free, but it usually will be.
  */
-extern mm_context_t next_mmu_context;
+extern unsigned long next_mmu_context;
 
 /*
  * If we don't have sufficient contexts to give one to every task
@@ -118,9 +118,9 @@ #endif
  */
 static inline void get_mmu_context(struct mm_struct *mm)
 {
-	mm_context_t ctx;
+	unsigned long ctx;
 
-	if (mm->context != NO_CONTEXT)
+	if (mm->context.id != NO_CONTEXT)
 		return;
 #ifdef FEW_CONTEXTS
 	while (atomic_dec_if_positive(&nr_free_contexts) < 0)
@@ -133,7 +133,7 @@ #endif
 			ctx = 0;
 	}
 	next_mmu_context = (ctx + 1) & LAST_CONTEXT;
-	mm->context = ctx;
+	mm->context.id = ctx;
 #ifdef FEW_CONTEXTS
 	context_mm[ctx] = mm;
 #endif
@@ -142,7 +142,12 @@ #endif
 /*
  * Set up the context for a new address space.
  */
-#define init_new_context(tsk,mm)	(((mm)->context = NO_CONTEXT), 0)
+static inline int init_new_context(struct task_struct *t, struct mm_struct *mm)
+{
+	mm->context.id = NO_CONTEXT;
+	mm->context.vdso_base = 0;
+	return 0;
+}
 
 /*
  * We're finished using the context for an address space.
@@ -150,9 +155,9 @@ #define init_new_context(tsk,mm)	(((mm)-
 static inline void destroy_context(struct mm_struct *mm)
 {
 	preempt_disable();
-	if (mm->context != NO_CONTEXT) {
-		clear_bit(mm->context, context_map);
-		mm->context = NO_CONTEXT;
+	if (mm->context.id != NO_CONTEXT) {
+		clear_bit(mm->context.id, context_map);
+		mm->context.id = NO_CONTEXT;
 #ifdef FEW_CONTEXTS
 		atomic_inc(&nr_free_contexts);
 #endif
@@ -180,7 +185,7 @@ #endif /* CONFIG_ALTIVEC */
 
 	/* Setup new userspace context */
 	get_mmu_context(next);
-	set_context(next->context, next->pgd);
+	set_context(next->context.id, next->pgd);
 }
 
 #define deactivate_mm(tsk,mm)	do { } while (0)
diff --git a/include/asm-ppc/pgtable.h b/include/asm-ppc/pgtable.h
index 570b355..f886066 100644
--- a/include/asm-ppc/pgtable.h
+++ b/include/asm-ppc/pgtable.h
@@ -663,7 +663,7 @@ #endif
 	return (old & _PAGE_ACCESSED) != 0;
 }
 #define ptep_test_and_clear_young(__vma, __addr, __ptep) \
-	__ptep_test_and_clear_young((__vma)->vm_mm->context, __addr, __ptep)
+	__ptep_test_and_clear_young((__vma)->vm_mm->context.id, __addr, __ptep)
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
 static inline int ptep_test_and_clear_dirty(struct vm_area_struct *vma,
