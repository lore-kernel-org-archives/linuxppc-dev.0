Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 11 Feb 2009 13:02:37 +1100
Subject: [PATCH] powerpc: Rework I$/D$ coherency (v3)
Message-Id: <20090211020303.E1A3EDDDA7@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch reworks the way we do I and D cache coherency on PowerPC.

The "old" way was split in 3 different parts depending on the processor type:

   - Hash with per-page exec support (64-bit and >= POWER4 only) does it
at hashing time, by preventing exec on unclean pages and cleaning pages
on exec faults.

   - Everything without per-page exec support (32-bit hash, 8xx, and
64-bit < POWER4) does it for all page going to user space in update_mmu_cache().

   - Embedded with per-page exec support does it from do_page_fault() on
exec faults, in a way similar to what the hash code does.

That leads to confusion, and bugs. For example, the method using update_mmu_cache()
is racy on SMP where another processor can see the new PTE and hash it in before
we have cleaned the cache, and then blow trying to execute. This is hard to hit but
I think it has bitten us in the past.

Also, it's inefficient for embedded where we always end up having to do at least
one more page fault.

This reworks the whole thing by moving the cache sync into two main call sites,
though we keep different behaviours depending on the HW capability. The call
sites are set_pte_at() which is now made out of line, and ptep_set_access_flags()
which joins the former in pgtable.c

The base idea for Embedded with per-page exec support, is that we now do the
flush at set_pte_at() time when coming from an exec fault, which allows us
to avoid the double fault problem completely (we can even improve the situation
more by implementing TLB preload in update_mmu_cache() but that's for later).

If for some reason we didn't do it there and we try to execute, we'll hit
the page fault, which will do a minor fault, which will hit ptep_set_access_flags()
to do things like update _PAGE_ACCESSED or _PAGE_DIRTY if needed, we just make
this guys also perform the I/D cache sync for exec faults now. This second path
is the catch all for things that weren't cleaned at set_pte_at() time.

For cpus without per-pag exec support, we always do the sync at set_pte_at(),
thus guaranteeing that when the PTE is visible to other processors, the cache
is clean.

For the 64-bit hash with per-page exec support case, we keep the old mechanism
for now. I'll look into changing it later, once I've reworked a bit how we
use _PAGE_EXEC.

This is also a first step for adding _PAGE_EXEC support for embedded platforms

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v2: Fix duplicate #define spotted by Kumar
    Fix missing _PAGE_EXEC/HWEXEC from the mask of bits filtered out
      by __ptep_set_access_flags() on 32-bit, causing thing not to work
      on processors with HWEXEC support (oops !).
v3: Minor comment fixup

 arch/powerpc/include/asm/highmem.h       |    2 
 arch/powerpc/include/asm/pgtable-ppc32.h |   56 +------------
 arch/powerpc/include/asm/pgtable-ppc64.h |   29 +-----
 arch/powerpc/include/asm/pgtable.h       |   84 +++++++++++++++++++
 arch/powerpc/mm/fault.c                  |   46 ++++------
 arch/powerpc/mm/mem.c                    |   33 -------
 arch/powerpc/mm/pgtable.c                |  131 +++++++++++++++++++++++++++++++
 7 files changed, 245 insertions(+), 136 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/pgtable-ppc32.h	2009-02-04 16:54:07.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pgtable-ppc32.h	2009-02-10 16:27:11.000000000 +1100
@@ -429,6 +429,8 @@ extern int icache_44x_need_flush;
 #define PMD_PAGE_SIZE(pmd)	bad_call_to_PMD_PAGE_SIZE()
 #endif
 
+#define _PAGE_HPTEFLAGS _PAGE_HASHPTE
+
 #define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY)
 
 
@@ -667,44 +669,6 @@ static inline unsigned long long pte_upd
 #endif /* CONFIG_PTE_64BIT */
 
 /*
- * set_pte stores a linux PTE into the linux page table.
- * On machines which use an MMU hash table we avoid changing the
- * _PAGE_HASHPTE bit.
- */
-
-static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, pte_t pte)
-{
-#if (_PAGE_HASHPTE != 0) && defined(CONFIG_SMP) && !defined(CONFIG_PTE_64BIT)
-	pte_update(ptep, ~_PAGE_HASHPTE, pte_val(pte) & ~_PAGE_HASHPTE);
-#elif defined(CONFIG_PTE_64BIT) && defined(CONFIG_SMP)
-#if _PAGE_HASHPTE != 0
-	if (pte_val(*ptep) & _PAGE_HASHPTE)
-		flush_hash_entry(mm, ptep, addr);
-#endif
-	__asm__ __volatile__("\
-		stw%U0%X0 %2,%0\n\
-		eieio\n\
-		stw%U0%X0 %L2,%1"
-	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
-	: "r" (pte) : "memory");
-#else
-	*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
-		      | (pte_val(pte) & ~_PAGE_HASHPTE));
-#endif
-}
-
-
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, pte_t pte)
-{
-#if defined(CONFIG_PTE_64BIT) && defined(CONFIG_SMP) && defined(CONFIG_DEBUG_VM)
-	WARN_ON(pte_present(*ptep));
-#endif
-	__set_pte_at(mm, addr, ptep, pte);
-}
-
-/*
  * 2.6 calls this without flushing the TLB entry; this is wrong
  * for our hash-based implementation, we fix that up here.
  */
@@ -744,24 +708,14 @@ static inline void huge_ptep_set_wrprote
 }
 
 
-#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
-static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry, int dirty)
+static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 {
 	unsigned long bits = pte_val(entry) &
-		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW);
+		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW |
+		 _PAGE_HWEXEC | _PAGE_EXEC);
 	pte_update(ptep, 0, bits);
 }
 
-#define  ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
-({									   \
-	int __changed = !pte_same(*(__ptep), __entry);			   \
-	if (__changed) {						   \
-		__ptep_set_access_flags(__ptep, __entry, __dirty);         \
-		flush_tlb_page_nohash(__vma, __address);		   \
-	}								   \
-	__changed;							   \
-})
-
 #define __HAVE_ARCH_PTE_SAME
 #define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HASHPTE) == 0)
 
Index: linux-work/arch/powerpc/include/asm/pgtable-ppc64.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pgtable-ppc64.h	2009-02-04 16:54:07.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pgtable-ppc64.h	2009-02-10 16:27:11.000000000 +1100
@@ -125,6 +125,8 @@
 #define _PTEIDX_SECONDARY	0x8
 #define _PTEIDX_GROUP_IX	0x7
 
+/* To make some generic powerpc code happy */
+#define _PAGE_HWEXEC		0
 
 /*
  * POWER4 and newer have per page execute protection, older chips can only
@@ -285,6 +287,10 @@ static inline unsigned long pte_update(s
 	: "r" (ptep), "r" (clr), "m" (*ptep), "i" (_PAGE_BUSY)
 	: "cc" );
 
+	/* huge pages use the old page table lock */
+	if (!huge)
+		assert_pte_locked(mm, addr);
+
 	if (old & _PAGE_HASHPTE)
 		hpte_need_flush(mm, addr, ptep, old, huge);
 	return old;
@@ -359,23 +365,11 @@ static inline void pte_clear(struct mm_s
 	pte_update(mm, addr, ptep, ~0UL, 0);
 }
 
-/*
- * set_pte stores a linux PTE into the linux page table.
- */
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, pte_t pte)
-{
-	if (pte_present(*ptep))
-		pte_clear(mm, addr, ptep);
-	pte = __pte(pte_val(pte) & ~_PAGE_HPTEFLAGS);
-	*ptep = pte;
-}
 
 /* Set the dirty and/or accessed bits atomically in a linux PTE, this
  * function doesn't need to flush the hash entry
  */
-#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
-static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry, int dirty)
+static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 {
 	unsigned long bits = pte_val(entry) &
 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
@@ -392,15 +386,6 @@ static inline void __ptep_set_access_fla
 	:"r" (bits), "r" (ptep), "m" (*ptep), "i" (_PAGE_BUSY)
 	:"cc");
 }
-#define  ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
-({									   \
-	int __changed = !pte_same(*(__ptep), __entry);			   \
-	if (__changed) {						   \
-		__ptep_set_access_flags(__ptep, __entry, __dirty);    	   \
-		flush_tlb_page_nohash(__vma, __address);		   \
-	}								   \
-	__changed;							   \
-})
 
 #define __HAVE_ARCH_PTE_SAME
 #define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HPTEFLAGS) == 0)
Index: linux-work/arch/powerpc/include/asm/pgtable.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pgtable.h	2009-02-04 16:54:07.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pgtable.h	2009-02-10 16:27:11.000000000 +1100
@@ -6,7 +6,17 @@
 #include <asm/processor.h>		/* For TASK_SIZE */
 #include <asm/mmu.h>
 #include <asm/page.h>
+
 struct mm_struct;
+
+#ifdef CONFIG_DEBUG_VM
+extern void assert_pte_locked(struct mm_struct *mm, unsigned long addr);
+#else /* CONFIG_DEBUG_VM */
+static inline void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
+{
+}
+#endif /* !CONFIG_DEBUG_VM */
+
 #endif /* !__ASSEMBLY__ */
 
 #if defined(CONFIG_PPC64)
@@ -17,6 +27,80 @@ struct mm_struct;
 
 #ifndef __ASSEMBLY__
 
+/* Insert a PTE, top-level function is out of line. It uses an inline
+ * low level function in the respective pgtable-* files
+ */
+extern void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
+		       pte_t pte);
+
+/* This low level function performs the actual PTE insertion
+ * Setting the PTE depends on the MMU type and other factors. It's
+ * an horrible mess that I'm not going to try to clean up now but
+ * I'm keeping it in one place rather than spread around
+ */
+static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, pte_t pte, int percpu)
+{
+#if defined(CONFIG_PPC_STD_MMU_32) && defined(CONFIG_SMP) && !defined(CONFIG_PTE_64BIT)
+	/* First case is 32-bit Hash MMU in SMP mode with 32-bit PTEs. We use the
+	 * helper pte_update() which does an atomic update. We need to do that
+	 * because a concurrent invalidation can clear _PAGE_HASHPTE. If it's a
+	 * per-CPU PTE such as a kmap_atomic, we do a simple update preserving
+	 * the hash bits instead (ie, same as the non-SMP case)
+	 */
+	if (percpu)
+		*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
+			      | (pte_val(pte) & ~_PAGE_HASHPTE));
+	else
+		pte_update(ptep, ~_PAGE_HASHPTE, pte_val(pte));
+
+#elif defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT) && defined(CONFIG_SMP)
+	/* Second case is 32-bit with 64-bit PTE in SMP mode. In this case, we
+	 * can just store as long as we do the two halves in the right order
+	 * with a barrier in between. This is possible because we take care,
+	 * in the hash code, to pre-invalidate if the PTE was already hashed,
+	 * which synchronizes us with any concurrent invalidation.
+	 * In the percpu case, we also fallback to the simple update preserving
+	 * the hash bits
+	 */
+	if (percpu) {
+		*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
+			      | (pte_val(pte) & ~_PAGE_HASHPTE));
+		return;
+	}
+#if _PAGE_HASHPTE != 0
+	if (pte_val(*ptep) & _PAGE_HASHPTE)
+		flush_hash_entry(mm, ptep, addr);
+#endif
+	__asm__ __volatile__("\
+		stw%U0%X0 %2,%0\n\
+		eieio\n\
+		stw%U0%X0 %L2,%1"
+	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
+	: "r" (pte) : "memory");
+
+#elif defined(CONFIG_PPC_STD_MMU_32)
+	/* Third case is 32-bit hash table in UP mode, we need to preserve
+	 * the _PAGE_HASHPTE bit since we may not have invalidated the previous
+	 * translation in the hash yet (done in a subsequent flush_tlb_xxx())
+	 * and see we need to keep track that this PTE needs invalidating
+	 */
+	*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
+		      | (pte_val(pte) & ~_PAGE_HASHPTE));
+
+#else
+	/* Anything else just stores the PTE normally. That covers all 64-bit
+	 * cases, and 32-bit non-hash with 64-bit PTEs in UP mode
+	 */
+	*ptep = pte;
+#endif
+}
+
+
+#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+extern int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
+				 pte_t *ptep, pte_t entry, int dirty);
+
 /*
  * Macro to mark a page protection value as "uncacheable".
  */
Index: linux-work/arch/powerpc/mm/mem.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/mem.c	2009-02-04 16:54:07.000000000 +1100
+++ linux-work/arch/powerpc/mm/mem.c	2009-02-10 16:27:11.000000000 +1100
@@ -472,40 +472,7 @@ void update_mmu_cache(struct vm_area_str
 {
 #ifdef CONFIG_PPC_STD_MMU
 	unsigned long access = 0, trap;
-#endif
-	unsigned long pfn = pte_pfn(pte);
 
-	/* handle i-cache coherency */
-	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE) &&
-	    !cpu_has_feature(CPU_FTR_NOEXECUTE) &&
-	    pfn_valid(pfn)) {
-		struct page *page = pfn_to_page(pfn);
-#ifdef CONFIG_8xx
-		/* On 8xx, cache control instructions (particularly
-		 * "dcbst" from flush_dcache_icache) fault as write
-		 * operation if there is an unpopulated TLB entry
-		 * for the address in question. To workaround that,
-		 * we invalidate the TLB here, thus avoiding dcbst
-		 * misbehaviour.
-		 */
-		_tlbil_va(address, 0 /* 8xx doesn't care about PID */);
-#endif
-		/* The _PAGE_USER test should really be _PAGE_EXEC, but
-		 * older glibc versions execute some code from no-exec
-		 * pages, which for now we are supporting.  If exec-only
-		 * pages are ever implemented, this will have to change.
-		 */
-		if (!PageReserved(page) && (pte_val(pte) & _PAGE_USER)
-		    && !test_bit(PG_arch_1, &page->flags)) {
-			if (vma->vm_mm == current->active_mm) {
-				__flush_dcache_icache((void *) address);
-			} else
-				flush_dcache_icache_page(page);
-			set_bit(PG_arch_1, &page->flags);
-		}
-	}
-
-#ifdef CONFIG_PPC_STD_MMU
 	/* We only want HPTEs for linux PTEs that have _PAGE_ACCESSED set */
 	if (!pte_young(pte) || address >= TASK_SIZE)
 		return;
Index: linux-work/arch/powerpc/mm/pgtable.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/pgtable.c	2009-02-04 16:54:07.000000000 +1100
+++ linux-work/arch/powerpc/mm/pgtable.c	2009-02-10 16:27:34.000000000 +1100
@@ -1,5 +1,6 @@
 /*
  * This file contains common routines for dealing with free of page tables
+ * Along with common page table handling code
  *
  *  Derived from arch/powerpc/mm/tlb_64.c:
  *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
@@ -115,3 +116,133 @@ void pte_free_finish(void)
 	pte_free_submit(*batchp);
 	*batchp = NULL;
 }
+
+/*
+ * Handle i/d cache flushing, called from set_pte_at() or ptep_set_access_flags()
+ */
+static pte_t do_dcache_icache_coherency(pte_t pte)
+{
+	unsigned long pfn = pte_pfn(pte);
+	struct page *page;
+
+	if (unlikely(!pfn_valid(pfn)))
+		return pte;
+	page = pfn_to_page(pfn);
+
+	if (!PageReserved(page) && !test_bit(PG_arch_1, &page->flags)) {
+		pr_debug("do_dcache_icache_coherency... flushing\n");
+		flush_dcache_icache_page(page);
+		set_bit(PG_arch_1, &page->flags);
+	}
+	else
+		pr_debug("do_dcache_icache_coherency... already clean\n");
+	return __pte(pte_val(pte) | _PAGE_HWEXEC);
+}
+
+static inline int is_exec_fault(void)
+{
+	return current->thread.regs && TRAP(current->thread.regs) == 0x400;
+}
+
+/* We only try to do i/d cache coherency on stuff that looks like
+ * reasonably "normal" PTEs. We currently require a PTE to be present
+ * and we avoid _PAGE_SPECIAL and _PAGE_NO_CACHE
+ */
+static inline int pte_looks_normal(pte_t pte)
+{
+	return (pte_val(pte) &
+		(_PAGE_PRESENT | _PAGE_SPECIAL | _PAGE_NO_CACHE)) ==
+		(_PAGE_PRESENT);
+}
+
+#if defined(CONFIG_PPC_STD_MMU)
+/* Server-style MMU handles coherency when hashing if HW exec permission
+ * is supposed per page (currently 64-bit only). Else, we always flush
+ * valid PTEs in set_pte.
+ */
+static inline int pte_need_exec_flush(pte_t pte, int set_pte)
+{
+	return set_pte && pte_looks_normal(pte) &&
+		!(cpu_has_feature(CPU_FTR_COHERENT_ICACHE) ||
+		  cpu_has_feature(CPU_FTR_NOEXECUTE));
+}
+#elif _PAGE_HWEXEC == 0
+/* Embedded type MMU without HW exec support (8xx only so far), we flush
+ * the cache for any present PTE
+ */
+static inline int pte_need_exec_flush(pte_t pte, int set_pte)
+{
+	return set_pte && pte_looks_normal(pte);
+}
+#else
+/* Other embedded CPUs with HW exec support per-page, we flush on exec
+ * fault if HWEXEC is not set
+ */
+static inline int pte_need_exec_flush(pte_t pte, int set_pte)
+{
+	return pte_looks_normal(pte) && is_exec_fault() &&
+		!(pte_val(pte) & _PAGE_HWEXEC);
+}
+#endif
+
+/*
+ * set_pte stores a linux PTE into the linux page table.
+ */
+void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte)
+{
+#ifdef CONFIG_DEBUG_VM
+	WARN_ON(pte_present(*ptep));
+#endif
+	/* Note: mm->context.id might not yet have been assigned as
+	 * this context might not have been activated yet when this
+	 * is called.
+	 */
+	pte = __pte(pte_val(pte) & ~_PAGE_HPTEFLAGS);
+	if (pte_need_exec_flush(pte, 1))
+		pte = do_dcache_icache_coherency(pte);
+
+	/* Perform the setting of the PTE */
+	__set_pte_at(mm, addr, ptep, pte, 0);
+}
+
+/*
+ * This is called when relaxing access to a PTE. It's also called in the page
+ * fault path when we don't hit any of the major fault cases, ie, a minor
+ * update of _PAGE_ACCESSED, _PAGE_DIRTY, etc... The generic code will have
+ * handled those two for us, we additionally deal with missing execute
+ * permission here on some processors
+ */
+int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
+			  pte_t *ptep, pte_t entry, int dirty)
+{
+	int changed;
+	if (!dirty && pte_need_exec_flush(entry, 0))
+		entry = do_dcache_icache_coherency(entry);
+	changed = !pte_same(*(ptep), entry);
+ 	if (changed) {
+		assert_pte_locked(vma->vm_mm, address);
+		__ptep_set_access_flags(ptep, entry);
+		flush_tlb_page_nohash(vma, address);
+	}
+	return changed;
+}
+
+#ifdef CONFIG_DEBUG_VM
+void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	if (mm == &init_mm)
+		return;
+	pgd = mm->pgd + pgd_index(addr);
+	BUG_ON(pgd_none(*pgd));
+	pud = pud_offset(pgd, addr);
+	BUG_ON(pud_none(*pud));
+	pmd = pmd_offset(pud, addr);
+	BUG_ON(!pmd_present(*pmd));
+	BUG_ON(!spin_is_locked(pte_lockptr(mm, pmd)));
+}
+#endif /* CONFIG_DEBUG_VM */
+
Index: linux-work/arch/powerpc/include/asm/highmem.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/highmem.h	2009-02-04 16:54:07.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/highmem.h	2009-02-10 16:27:11.000000000 +1100
@@ -99,7 +99,7 @@ static inline void *kmap_atomic_prot(str
 #ifdef CONFIG_DEBUG_HIGHMEM
 	BUG_ON(!pte_none(*(kmap_pte-idx)));
 #endif
-	__set_pte_at(&init_mm, vaddr, kmap_pte-idx, mk_pte(page, prot));
+	__set_pte_at(&init_mm, vaddr, kmap_pte-idx, mk_pte(page, prot), 1);
 	local_flush_tlb_page(NULL, vaddr);
 
 	return (void*) vaddr;
Index: linux-work/arch/powerpc/mm/fault.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/fault.c	2009-02-04 16:54:07.000000000 +1100
+++ linux-work/arch/powerpc/mm/fault.c	2009-02-10 16:27:11.000000000 +1100
@@ -253,45 +253,33 @@ good_area:
 #endif /* CONFIG_8xx */
 
 	if (is_exec) {
-#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
-		/* protection fault */
+#ifdef CONFIG_PPC_STD_MMU
+		/* Protection fault on exec go straight to failure on
+		 * Hash based MMUs as they either don't support per-page
+		 * execute permission, or if they do, it's handled already
+		 * at the hash level. This test would probably have to
+		 * be removed if we change the way this works to make hash
+		 * processors use the same I/D cache coherency mechanism
+		 * as embedded.
+		 */
 		if (error_code & DSISR_PROTFAULT)
 			goto bad_area;
+#endif /* CONFIG_PPC_STD_MMU */
+
 		/*
 		 * Allow execution from readable areas if the MMU does not
 		 * provide separate controls over reading and executing.
+		 *
+		 * Note: That code used to not be enabled for 4xx/BookE.
+		 * It is now as I/D cache coherency for these is done at
+		 * set_pte_at() time and I see no reason why the test
+		 * below wouldn't be valid on those processors. This -may-
+		 * break programs compiled with a really old ABI though.
 		 */
 		if (!(vma->vm_flags & VM_EXEC) &&
 		    (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
 		     !(vma->vm_flags & (VM_READ | VM_WRITE))))
 			goto bad_area;
-#else
-		pte_t *ptep;
-		pmd_t *pmdp;
-
-		/* Since 4xx/Book-E supports per-page execute permission,
-		 * we lazily flush dcache to icache. */
-		ptep = NULL;
-		if (get_pteptr(mm, address, &ptep, &pmdp)) {
-			spinlock_t *ptl = pte_lockptr(mm, pmdp);
-			spin_lock(ptl);
-			if (pte_present(*ptep)) {
-				struct page *page = pte_page(*ptep);
-
-				if (!test_bit(PG_arch_1, &page->flags)) {
-					flush_dcache_icache_page(page);
-					set_bit(PG_arch_1, &page->flags);
-				}
-				pte_update(ptep, 0, _PAGE_HWEXEC |
-					   _PAGE_ACCESSED);
-				local_flush_tlb_page(vma, address);
-				pte_unmap_unlock(ptep, ptl);
-				up_read(&mm->mmap_sem);
-				return 0;
-			}
-			pte_unmap_unlock(ptep, ptl);
-		}
-#endif
 	/* a write */
 	} else if (is_write) {
 		if (!(vma->vm_flags & VM_WRITE))
