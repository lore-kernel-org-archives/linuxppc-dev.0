Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 15 Dec 2008 16:44:39 +1100
Subject: [PATCH 8/16] powerpc/mm: Rename tlb_32.c and tlb_64.c to tlb_hash32.c
	and tlb_hash64.c
In-Reply-To: <1229319836.100184.344640589620.qpush@grosgo>
Message-Id: <20081215054539.2B9B8DDFB4@ozlabs.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This renames the files to clarify the fact that they are used by
the hash based family of CPUs (the 603 being an exception in that
family but is still handled by that code).

This paves the way for the new tlb_nohash.c coming via a subsequent
patch.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/mm/Makefile     |    2 
 arch/powerpc/mm/tlb_32.c     |  190 --------------------------------------
 arch/powerpc/mm/tlb_64.c     |  211 -------------------------------------------
 arch/powerpc/mm/tlb_hash32.c |  190 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/tlb_hash64.c |  211 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 402 insertions(+), 402 deletions(-)

--- linux-work.orig/arch/powerpc/mm/tlb_32.c	2008-12-09 16:30:49.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,190 +0,0 @@
-/*
- * This file contains the routines for TLB flushing.
- * On machines where the MMU uses a hash table to store virtual to
- * physical translations, these routines flush entries from the
- * hash table also.
- *  -- paulus
- *
- *  Derived from arch/ppc/mm/init.c:
- *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
- *
- *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
- *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
- *    Copyright (C) 1996 Paul Mackerras
- *
- *  Derived from "arch/i386/mm/init.c"
- *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/init.h>
-#include <linux/highmem.h>
-#include <linux/pagemap.h>
-
-#include <asm/tlbflush.h>
-#include <asm/tlb.h>
-
-#include "mmu_decl.h"
-
-/*
- * Called when unmapping pages to flush entries from the TLB/hash table.
- */
-void flush_hash_entry(struct mm_struct *mm, pte_t *ptep, unsigned long addr)
-{
-	unsigned long ptephys;
-
-	if (Hash != 0) {
-		ptephys = __pa(ptep) & PAGE_MASK;
-		flush_hash_pages(mm->context.id, addr, ptephys, 1);
-	}
-}
-EXPORT_SYMBOL(flush_hash_entry);
-
-/*
- * Called by ptep_set_access_flags, must flush on CPUs for which the
- * DSI handler can't just "fixup" the TLB on a write fault
- */
-void flush_tlb_page_nohash(struct vm_area_struct *vma, unsigned long addr)
-{
-	if (Hash != 0)
-		return;
-	_tlbie(addr);
-}
-
-/*
- * Called at the end of a mmu_gather operation to make sure the
- * TLB flush is completely done.
- */
-void tlb_flush(struct mmu_gather *tlb)
-{
-	if (Hash == 0) {
-		/*
-		 * 603 needs to flush the whole TLB here since
-		 * it doesn't use a hash table.
-		 */
-		_tlbia();
-	}
-}
-
-/*
- * TLB flushing:
- *
- *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
- *  - flush_tlb_page(vma, vmaddr) flushes one page
- *  - flush_tlb_range(vma, start, end) flushes a range of pages
- *  - flush_tlb_kernel_range(start, end) flushes kernel pages
- *
- * since the hardware hash table functions as an extension of the
- * tlb as far as the linux tables are concerned, flush it too.
- *    -- Cort
- */
-
-/*
- * 750 SMP is a Bad Idea because the 750 doesn't broadcast all
- * the cache operations on the bus.  Hence we need to use an IPI
- * to get the other CPU(s) to invalidate their TLBs.
- */
-#ifdef CONFIG_SMP_750
-#define FINISH_FLUSH	smp_send_tlb_invalidate(0)
-#else
-#define FINISH_FLUSH	do { } while (0)
-#endif
-
-static void flush_range(struct mm_struct *mm, unsigned long start,
-			unsigned long end)
-{
-	pmd_t *pmd;
-	unsigned long pmd_end;
-	int count;
-	unsigned int ctx = mm->context.id;
-
-	if (Hash == 0) {
-		_tlbia();
-		return;
-	}
-	start &= PAGE_MASK;
-	if (start >= end)
-		return;
-	end = (end - 1) | ~PAGE_MASK;
-	pmd = pmd_offset(pud_offset(pgd_offset(mm, start), start), start);
-	for (;;) {
-		pmd_end = ((start + PGDIR_SIZE) & PGDIR_MASK) - 1;
-		if (pmd_end > end)
-			pmd_end = end;
-		if (!pmd_none(*pmd)) {
-			count = ((pmd_end - start) >> PAGE_SHIFT) + 1;
-			flush_hash_pages(ctx, start, pmd_val(*pmd), count);
-		}
-		if (pmd_end == end)
-			break;
-		start = pmd_end + 1;
-		++pmd;
-	}
-}
-
-/*
- * Flush kernel TLB entries in the given range
- */
-void flush_tlb_kernel_range(unsigned long start, unsigned long end)
-{
-	flush_range(&init_mm, start, end);
-	FINISH_FLUSH;
-}
-
-/*
- * Flush all the (user) entries for the address space described by mm.
- */
-void flush_tlb_mm(struct mm_struct *mm)
-{
-	struct vm_area_struct *mp;
-
-	if (Hash == 0) {
-		_tlbia();
-		return;
-	}
-
-	/*
-	 * It is safe to go down the mm's list of vmas when called
-	 * from dup_mmap, holding mmap_sem.  It would also be safe from
-	 * unmap_region or exit_mmap, but not from vmtruncate on SMP -
-	 * but it seems dup_mmap is the only SMP case which gets here.
-	 */
-	for (mp = mm->mmap; mp != NULL; mp = mp->vm_next)
-		flush_range(mp->vm_mm, mp->vm_start, mp->vm_end);
-	FINISH_FLUSH;
-}
-
-void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
-{
-	struct mm_struct *mm;
-	pmd_t *pmd;
-
-	if (Hash == 0) {
-		_tlbie(vmaddr);
-		return;
-	}
-	mm = (vmaddr < TASK_SIZE)? vma->vm_mm: &init_mm;
-	pmd = pmd_offset(pud_offset(pgd_offset(mm, vmaddr), vmaddr), vmaddr);
-	if (!pmd_none(*pmd))
-		flush_hash_pages(mm->context.id, vmaddr, pmd_val(*pmd), 1);
-	FINISH_FLUSH;
-}
-
-/*
- * For each address in the range, find the pte for the address
- * and check _PAGE_HASHPTE bit; if it is set, find and destroy
- * the corresponding HPTE.
- */
-void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-		     unsigned long end)
-{
-	flush_range(vma->vm_mm, start, end);
-	FINISH_FLUSH;
-}
Index: linux-work/arch/powerpc/mm/tlb_64.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/tlb_64.c	2008-12-09 16:30:49.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,211 +0,0 @@
-/*
- * This file contains the routines for flushing entries from the
- * TLB and MMU hash table.
- *
- *  Derived from arch/ppc64/mm/init.c:
- *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
- *
- *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
- *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
- *    Copyright (C) 1996 Paul Mackerras
- *
- *  Derived from "arch/i386/mm/init.c"
- *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
- *
- *  Dave Engebretsen <engebret@us.ibm.com>
- *      Rework for PPC64 port.
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
- */
-
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/init.h>
-#include <linux/percpu.h>
-#include <linux/hardirq.h>
-#include <asm/pgalloc.h>
-#include <asm/tlbflush.h>
-#include <asm/tlb.h>
-#include <asm/bug.h>
-
-DEFINE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
-
-/* This is declared as we are using the more or less generic
- * arch/powerpc/include/asm/tlb.h file -- tgall
- */
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
-
-/*
- * A linux PTE was changed and the corresponding hash table entry
- * neesd to be flushed. This function will either perform the flush
- * immediately or will batch it up if the current CPU has an active
- * batch on it.
- *
- * Must be called from within some kind of spinlock/non-preempt region...
- */
-void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
-		     pte_t *ptep, unsigned long pte, int huge)
-{
-	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
-	unsigned long vsid, vaddr;
-	unsigned int psize;
-	int ssize;
-	real_pte_t rpte;
-	int i;
-
-	i = batch->index;
-
-	/* We mask the address for the base page size. Huge pages will
-	 * have applied their own masking already
-	 */
-	addr &= PAGE_MASK;
-
-	/* Get page size (maybe move back to caller).
-	 *
-	 * NOTE: when using special 64K mappings in 4K environment like
-	 * for SPEs, we obtain the page size from the slice, which thus
-	 * must still exist (and thus the VMA not reused) at the time
-	 * of this call
-	 */
-	if (huge) {
-#ifdef CONFIG_HUGETLB_PAGE
-		psize = get_slice_psize(mm, addr);;
-#else
-		BUG();
-		psize = pte_pagesize_index(mm, addr, pte); /* shutup gcc */
-#endif
-	} else
-		psize = pte_pagesize_index(mm, addr, pte);
-
-	/* Build full vaddr */
-	if (!is_kernel_addr(addr)) {
-		ssize = user_segment_size(addr);
-		vsid = get_vsid(mm->context.id, addr, ssize);
-		WARN_ON(vsid == 0);
-	} else {
-		vsid = get_kernel_vsid(addr, mmu_kernel_ssize);
-		ssize = mmu_kernel_ssize;
-	}
-	vaddr = hpt_va(addr, vsid, ssize);
-	rpte = __real_pte(__pte(pte), ptep);
-
-	/*
-	 * Check if we have an active batch on this CPU. If not, just
-	 * flush now and return. For now, we don global invalidates
-	 * in that case, might be worth testing the mm cpu mask though
-	 * and decide to use local invalidates instead...
-	 */
-	if (!batch->active) {
-		flush_hash_page(vaddr, rpte, psize, ssize, 0);
-		return;
-	}
-
-	/*
-	 * This can happen when we are in the middle of a TLB batch and
-	 * we encounter memory pressure (eg copy_page_range when it tries
-	 * to allocate a new pte). If we have to reclaim memory and end
-	 * up scanning and resetting referenced bits then our batch context
-	 * will change mid stream.
-	 *
-	 * We also need to ensure only one page size is present in a given
-	 * batch
-	 */
-	if (i != 0 && (mm != batch->mm || batch->psize != psize ||
-		       batch->ssize != ssize)) {
-		__flush_tlb_pending(batch);
-		i = 0;
-	}
-	if (i == 0) {
-		batch->mm = mm;
-		batch->psize = psize;
-		batch->ssize = ssize;
-	}
-	batch->pte[i] = rpte;
-	batch->vaddr[i] = vaddr;
-	batch->index = ++i;
-	if (i >= PPC64_TLB_BATCH_NR)
-		__flush_tlb_pending(batch);
-}
-
-/*
- * This function is called when terminating an mmu batch or when a batch
- * is full. It will perform the flush of all the entries currently stored
- * in a batch.
- *
- * Must be called from within some kind of spinlock/non-preempt region...
- */
-void __flush_tlb_pending(struct ppc64_tlb_batch *batch)
-{
-	cpumask_t tmp;
-	int i, local = 0;
-
-	i = batch->index;
-	tmp = cpumask_of_cpu(smp_processor_id());
-	if (cpus_equal(batch->mm->cpu_vm_mask, tmp))
-		local = 1;
-	if (i == 1)
-		flush_hash_page(batch->vaddr[0], batch->pte[0],
-				batch->psize, batch->ssize, local);
-	else
-		flush_hash_range(i, local);
-	batch->index = 0;
-}
-
-/**
- * __flush_hash_table_range - Flush all HPTEs for a given address range
- *                            from the hash table (and the TLB). But keeps
- *                            the linux PTEs intact.
- *
- * @mm		: mm_struct of the target address space (generally init_mm)
- * @start	: starting address
- * @end         : ending address (not included in the flush)
- *
- * This function is mostly to be used by some IO hotplug code in order
- * to remove all hash entries from a given address range used to map IO
- * space on a removed PCI-PCI bidge without tearing down the full mapping
- * since 64K pages may overlap with other bridges when using 64K pages
- * with 4K HW pages on IO space.
- *
- * Because of that usage pattern, it's only available with CONFIG_HOTPLUG
- * and is implemented for small size rather than speed.
- */
-#ifdef CONFIG_HOTPLUG
-
-void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
-			      unsigned long end)
-{
-	unsigned long flags;
-
-	start = _ALIGN_DOWN(start, PAGE_SIZE);
-	end = _ALIGN_UP(end, PAGE_SIZE);
-
-	BUG_ON(!mm->pgd);
-
-	/* Note: Normally, we should only ever use a batch within a
-	 * PTE locked section. This violates the rule, but will work
-	 * since we don't actually modify the PTEs, we just flush the
-	 * hash while leaving the PTEs intact (including their reference
-	 * to being hashed). This is not the most performance oriented
-	 * way to do things but is fine for our needs here.
-	 */
-	local_irq_save(flags);
-	arch_enter_lazy_mmu_mode();
-	for (; start < end; start += PAGE_SIZE) {
-		pte_t *ptep = find_linux_pte(mm->pgd, start);
-		unsigned long pte;
-
-		if (ptep == NULL)
-			continue;
-		pte = pte_val(*ptep);
-		if (!(pte & _PAGE_HASHPTE))
-			continue;
-		hpte_need_flush(mm, start, ptep, pte, 0);
-	}
-	arch_leave_lazy_mmu_mode();
-	local_irq_restore(flags);
-}
-
-#endif /* CONFIG_HOTPLUG */
Index: linux-work/arch/powerpc/mm/tlb_hash32.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/mm/tlb_hash32.c	2008-12-09 16:31:43.000000000 +1100
@@ -0,0 +1,190 @@
+/*
+ * This file contains the routines for TLB flushing.
+ * On machines where the MMU uses a hash table to store virtual to
+ * physical translations, these routines flush entries from the
+ * hash table also.
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
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/highmem.h>
+#include <linux/pagemap.h>
+
+#include <asm/tlbflush.h>
+#include <asm/tlb.h>
+
+#include "mmu_decl.h"
+
+/*
+ * Called when unmapping pages to flush entries from the TLB/hash table.
+ */
+void flush_hash_entry(struct mm_struct *mm, pte_t *ptep, unsigned long addr)
+{
+	unsigned long ptephys;
+
+	if (Hash != 0) {
+		ptephys = __pa(ptep) & PAGE_MASK;
+		flush_hash_pages(mm->context.id, addr, ptephys, 1);
+	}
+}
+EXPORT_SYMBOL(flush_hash_entry);
+
+/*
+ * Called by ptep_set_access_flags, must flush on CPUs for which the
+ * DSI handler can't just "fixup" the TLB on a write fault
+ */
+void flush_tlb_page_nohash(struct vm_area_struct *vma, unsigned long addr)
+{
+	if (Hash != 0)
+		return;
+	_tlbie(addr);
+}
+
+/*
+ * Called at the end of a mmu_gather operation to make sure the
+ * TLB flush is completely done.
+ */
+void tlb_flush(struct mmu_gather *tlb)
+{
+	if (Hash == 0) {
+		/*
+		 * 603 needs to flush the whole TLB here since
+		 * it doesn't use a hash table.
+		 */
+		_tlbia();
+	}
+}
+
+/*
+ * TLB flushing:
+ *
+ *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
+ *  - flush_tlb_page(vma, vmaddr) flushes one page
+ *  - flush_tlb_range(vma, start, end) flushes a range of pages
+ *  - flush_tlb_kernel_range(start, end) flushes kernel pages
+ *
+ * since the hardware hash table functions as an extension of the
+ * tlb as far as the linux tables are concerned, flush it too.
+ *    -- Cort
+ */
+
+/*
+ * 750 SMP is a Bad Idea because the 750 doesn't broadcast all
+ * the cache operations on the bus.  Hence we need to use an IPI
+ * to get the other CPU(s) to invalidate their TLBs.
+ */
+#ifdef CONFIG_SMP_750
+#define FINISH_FLUSH	smp_send_tlb_invalidate(0)
+#else
+#define FINISH_FLUSH	do { } while (0)
+#endif
+
+static void flush_range(struct mm_struct *mm, unsigned long start,
+			unsigned long end)
+{
+	pmd_t *pmd;
+	unsigned long pmd_end;
+	int count;
+	unsigned int ctx = mm->context.id;
+
+	if (Hash == 0) {
+		_tlbia();
+		return;
+	}
+	start &= PAGE_MASK;
+	if (start >= end)
+		return;
+	end = (end - 1) | ~PAGE_MASK;
+	pmd = pmd_offset(pud_offset(pgd_offset(mm, start), start), start);
+	for (;;) {
+		pmd_end = ((start + PGDIR_SIZE) & PGDIR_MASK) - 1;
+		if (pmd_end > end)
+			pmd_end = end;
+		if (!pmd_none(*pmd)) {
+			count = ((pmd_end - start) >> PAGE_SHIFT) + 1;
+			flush_hash_pages(ctx, start, pmd_val(*pmd), count);
+		}
+		if (pmd_end == end)
+			break;
+		start = pmd_end + 1;
+		++pmd;
+	}
+}
+
+/*
+ * Flush kernel TLB entries in the given range
+ */
+void flush_tlb_kernel_range(unsigned long start, unsigned long end)
+{
+	flush_range(&init_mm, start, end);
+	FINISH_FLUSH;
+}
+
+/*
+ * Flush all the (user) entries for the address space described by mm.
+ */
+void flush_tlb_mm(struct mm_struct *mm)
+{
+	struct vm_area_struct *mp;
+
+	if (Hash == 0) {
+		_tlbia();
+		return;
+	}
+
+	/*
+	 * It is safe to go down the mm's list of vmas when called
+	 * from dup_mmap, holding mmap_sem.  It would also be safe from
+	 * unmap_region or exit_mmap, but not from vmtruncate on SMP -
+	 * but it seems dup_mmap is the only SMP case which gets here.
+	 */
+	for (mp = mm->mmap; mp != NULL; mp = mp->vm_next)
+		flush_range(mp->vm_mm, mp->vm_start, mp->vm_end);
+	FINISH_FLUSH;
+}
+
+void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
+{
+	struct mm_struct *mm;
+	pmd_t *pmd;
+
+	if (Hash == 0) {
+		_tlbie(vmaddr);
+		return;
+	}
+	mm = (vmaddr < TASK_SIZE)? vma->vm_mm: &init_mm;
+	pmd = pmd_offset(pud_offset(pgd_offset(mm, vmaddr), vmaddr), vmaddr);
+	if (!pmd_none(*pmd))
+		flush_hash_pages(mm->context.id, vmaddr, pmd_val(*pmd), 1);
+	FINISH_FLUSH;
+}
+
+/*
+ * For each address in the range, find the pte for the address
+ * and check _PAGE_HASHPTE bit; if it is set, find and destroy
+ * the corresponding HPTE.
+ */
+void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
+		     unsigned long end)
+{
+	flush_range(vma->vm_mm, start, end);
+	FINISH_FLUSH;
+}
Index: linux-work/arch/powerpc/mm/tlb_hash64.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/mm/tlb_hash64.c	2008-12-09 16:31:39.000000000 +1100
@@ -0,0 +1,211 @@
+/*
+ * This file contains the routines for flushing entries from the
+ * TLB and MMU hash table.
+ *
+ *  Derived from arch/ppc64/mm/init.c:
+ *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
+ *
+ *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
+ *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
+ *    Copyright (C) 1996 Paul Mackerras
+ *
+ *  Derived from "arch/i386/mm/init.c"
+ *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
+ *
+ *  Dave Engebretsen <engebret@us.ibm.com>
+ *      Rework for PPC64 port.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/percpu.h>
+#include <linux/hardirq.h>
+#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
+#include <asm/tlb.h>
+#include <asm/bug.h>
+
+DEFINE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
+
+/* This is declared as we are using the more or less generic
+ * arch/powerpc/include/asm/tlb.h file -- tgall
+ */
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
+
+/*
+ * A linux PTE was changed and the corresponding hash table entry
+ * neesd to be flushed. This function will either perform the flush
+ * immediately or will batch it up if the current CPU has an active
+ * batch on it.
+ *
+ * Must be called from within some kind of spinlock/non-preempt region...
+ */
+void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
+		     pte_t *ptep, unsigned long pte, int huge)
+{
+	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
+	unsigned long vsid, vaddr;
+	unsigned int psize;
+	int ssize;
+	real_pte_t rpte;
+	int i;
+
+	i = batch->index;
+
+	/* We mask the address for the base page size. Huge pages will
+	 * have applied their own masking already
+	 */
+	addr &= PAGE_MASK;
+
+	/* Get page size (maybe move back to caller).
+	 *
+	 * NOTE: when using special 64K mappings in 4K environment like
+	 * for SPEs, we obtain the page size from the slice, which thus
+	 * must still exist (and thus the VMA not reused) at the time
+	 * of this call
+	 */
+	if (huge) {
+#ifdef CONFIG_HUGETLB_PAGE
+		psize = get_slice_psize(mm, addr);;
+#else
+		BUG();
+		psize = pte_pagesize_index(mm, addr, pte); /* shutup gcc */
+#endif
+	} else
+		psize = pte_pagesize_index(mm, addr, pte);
+
+	/* Build full vaddr */
+	if (!is_kernel_addr(addr)) {
+		ssize = user_segment_size(addr);
+		vsid = get_vsid(mm->context.id, addr, ssize);
+		WARN_ON(vsid == 0);
+	} else {
+		vsid = get_kernel_vsid(addr, mmu_kernel_ssize);
+		ssize = mmu_kernel_ssize;
+	}
+	vaddr = hpt_va(addr, vsid, ssize);
+	rpte = __real_pte(__pte(pte), ptep);
+
+	/*
+	 * Check if we have an active batch on this CPU. If not, just
+	 * flush now and return. For now, we don global invalidates
+	 * in that case, might be worth testing the mm cpu mask though
+	 * and decide to use local invalidates instead...
+	 */
+	if (!batch->active) {
+		flush_hash_page(vaddr, rpte, psize, ssize, 0);
+		return;
+	}
+
+	/*
+	 * This can happen when we are in the middle of a TLB batch and
+	 * we encounter memory pressure (eg copy_page_range when it tries
+	 * to allocate a new pte). If we have to reclaim memory and end
+	 * up scanning and resetting referenced bits then our batch context
+	 * will change mid stream.
+	 *
+	 * We also need to ensure only one page size is present in a given
+	 * batch
+	 */
+	if (i != 0 && (mm != batch->mm || batch->psize != psize ||
+		       batch->ssize != ssize)) {
+		__flush_tlb_pending(batch);
+		i = 0;
+	}
+	if (i == 0) {
+		batch->mm = mm;
+		batch->psize = psize;
+		batch->ssize = ssize;
+	}
+	batch->pte[i] = rpte;
+	batch->vaddr[i] = vaddr;
+	batch->index = ++i;
+	if (i >= PPC64_TLB_BATCH_NR)
+		__flush_tlb_pending(batch);
+}
+
+/*
+ * This function is called when terminating an mmu batch or when a batch
+ * is full. It will perform the flush of all the entries currently stored
+ * in a batch.
+ *
+ * Must be called from within some kind of spinlock/non-preempt region...
+ */
+void __flush_tlb_pending(struct ppc64_tlb_batch *batch)
+{
+	cpumask_t tmp;
+	int i, local = 0;
+
+	i = batch->index;
+	tmp = cpumask_of_cpu(smp_processor_id());
+	if (cpus_equal(batch->mm->cpu_vm_mask, tmp))
+		local = 1;
+	if (i == 1)
+		flush_hash_page(batch->vaddr[0], batch->pte[0],
+				batch->psize, batch->ssize, local);
+	else
+		flush_hash_range(i, local);
+	batch->index = 0;
+}
+
+/**
+ * __flush_hash_table_range - Flush all HPTEs for a given address range
+ *                            from the hash table (and the TLB). But keeps
+ *                            the linux PTEs intact.
+ *
+ * @mm		: mm_struct of the target address space (generally init_mm)
+ * @start	: starting address
+ * @end         : ending address (not included in the flush)
+ *
+ * This function is mostly to be used by some IO hotplug code in order
+ * to remove all hash entries from a given address range used to map IO
+ * space on a removed PCI-PCI bidge without tearing down the full mapping
+ * since 64K pages may overlap with other bridges when using 64K pages
+ * with 4K HW pages on IO space.
+ *
+ * Because of that usage pattern, it's only available with CONFIG_HOTPLUG
+ * and is implemented for small size rather than speed.
+ */
+#ifdef CONFIG_HOTPLUG
+
+void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
+			      unsigned long end)
+{
+	unsigned long flags;
+
+	start = _ALIGN_DOWN(start, PAGE_SIZE);
+	end = _ALIGN_UP(end, PAGE_SIZE);
+
+	BUG_ON(!mm->pgd);
+
+	/* Note: Normally, we should only ever use a batch within a
+	 * PTE locked section. This violates the rule, but will work
+	 * since we don't actually modify the PTEs, we just flush the
+	 * hash while leaving the PTEs intact (including their reference
+	 * to being hashed). This is not the most performance oriented
+	 * way to do things but is fine for our needs here.
+	 */
+	local_irq_save(flags);
+	arch_enter_lazy_mmu_mode();
+	for (; start < end; start += PAGE_SIZE) {
+		pte_t *ptep = find_linux_pte(mm->pgd, start);
+		unsigned long pte;
+
+		if (ptep == NULL)
+			continue;
+		pte = pte_val(*ptep);
+		if (!(pte & _PAGE_HASHPTE))
+			continue;
+		hpte_need_flush(mm, start, ptep, pte, 0);
+	}
+	arch_leave_lazy_mmu_mode();
+	local_irq_restore(flags);
+}
+
+#endif /* CONFIG_HOTPLUG */
Index: linux-work/arch/powerpc/mm/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/mm/Makefile	2008-12-09 16:31:02.000000000 +1100
+++ linux-work/arch/powerpc/mm/Makefile	2008-12-09 16:31:43.000000000 +1100
@@ -16,7 +16,7 @@ obj-$(CONFIG_PPC64)		+= hash_utils_64.o 
 				   gup.o mmap.o $(hash-y)
 obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o
 obj-$(CONFIG_PPC_STD_MMU)	+= hash_low_$(CONFIG_WORD_SIZE).o \
-				   tlb_$(CONFIG_WORD_SIZE).o \
+				   tlb_hash$(CONFIG_WORD_SIZE).o \
 				   mmu_context_hash$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_40x)		+= 40x_mmu.o
 obj-$(CONFIG_44x)		+= 44x_mmu.o
