Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>,
	<cbe-oss-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 02 Mar 2007 22:33:14 +1100
Subject: [PATCH 4/5] powerpc: Add ability to 4K kernel to hash in 64K pages
In-Reply-To: <1172835163.743765.616483133775.qpush@grosgo>
Message-Id: <20070302113328.85425DDF77@ozlabs.org>
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the ability for a kernel compiled with 4K page size
to have special slices containing 64K pages and hash the right type
of hash PTEs.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/Kconfig              |    6 +++++
 arch/powerpc/mm/hash_low_64.S     |    5 +++-
 arch/powerpc/mm/hash_utils_64.c   |   45 +++++++++++++++++++++++++++-----------
 arch/powerpc/mm/tlb_64.c          |   12 +++++++---
 include/asm-powerpc/pgtable-4k.h  |    6 ++++-
 include/asm-powerpc/pgtable-64k.h |    7 +++++
 6 files changed, 62 insertions(+), 19 deletions(-)

Index: linux-cell/arch/powerpc/mm/hash_low_64.S
===================================================================
--- linux-cell.orig/arch/powerpc/mm/hash_low_64.S	2007-02-20 18:03:14.000000000 +1100
+++ linux-cell/arch/powerpc/mm/hash_low_64.S	2007-02-20 18:10:15.000000000 +1100
@@ -612,6 +612,9 @@ htab_pte_insert_failure:
 	li	r3,-1
 	b	htab_bail
 
+#endif /* CONFIG_PPC_64K_PAGES */
+
+#ifdef CONFIG_PPC_HAS_HASH_64K
 
 /*****************************************************************************
  *                                                                           *
@@ -867,7 +870,7 @@ ht64_pte_insert_failure:
 	b	ht64_bail
 
 
-#endif /* CONFIG_PPC_64K_PAGES */
+#endif /* CONFIG_PPC_HAS_HASH_64K */
 
 
 /*****************************************************************************
Index: linux-cell/include/asm-powerpc/pgtable-64k.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/pgtable-64k.h	2007-02-20 18:03:14.000000000 +1100
+++ linux-cell/include/asm-powerpc/pgtable-64k.h	2007-02-20 18:10:15.000000000 +1100
@@ -35,6 +35,11 @@
 #define _PAGE_HPTE_SUB	0x0ffff000 /* combo only: sub pages HPTE bits */
 #define _PAGE_HPTE_SUB0	0x08000000 /* combo only: first sub page */
 #define _PAGE_COMBO	0x10000000 /* this is a combo 4k page */
+
+/* Note the full page bits must be in the same location as for normal
+ * 4k pages as the same asssembly will be used to insert 64K pages
+ * wether the kernel has CONFIG_PPC_64K_PAGES or not
+ */
 #define _PAGE_F_SECOND  0x00008000 /* full page: hidx bits */
 #define _PAGE_F_GIX     0x00007000 /* full page: hidx bits */
 
@@ -90,7 +95,7 @@
 
 #define pte_iterate_hashed_end() } while(0); } } while(0)
 
-#define pte_pagesize_index(pte)	\
+#define pte_pagesize_index(mm, addr, pte)	\
 	(((pte) & _PAGE_COMBO)? MMU_PAGE_4K: MMU_PAGE_64K)
 
 #endif /*  __ASSEMBLY__ */
Index: linux-cell/arch/powerpc/Kconfig
===================================================================
--- linux-cell.orig/arch/powerpc/Kconfig	2007-02-20 18:10:14.000000000 +1100
+++ linux-cell/arch/powerpc/Kconfig	2007-02-20 18:10:15.000000000 +1100
@@ -905,9 +905,15 @@ config NODES_SPAN_OTHER_NODES
 	def_bool y
 	depends on NEED_MULTIPLE_NODES
 
+config PPC_HAS_HASH_64K
+	bool
+	depends on PPC64
+	default n
+
 config PPC_64K_PAGES
 	bool "64k page size"
 	depends on PPC64
+	select PPC_HAS_HASH_64K
 	help
 	  This option changes the kernel logical page size to 64k. On machines
           without processor support for 64k pages, the kernel will simulate
Index: linux-cell/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/mm/hash_utils_64.c	2007-02-20 18:10:14.000000000 +1100
+++ linux-cell/arch/powerpc/mm/hash_utils_64.c	2007-03-02 22:16:20.000000000 +1100
@@ -408,7 +408,7 @@ static void __init htab_finish_init(void
 	extern unsigned int *htab_call_hpte_remove;
 	extern unsigned int *htab_call_hpte_updatepp;
 
-#ifdef CONFIG_PPC_64K_PAGES
+#ifdef CONFIG_PPC_HAS_HASH_64K
 	extern unsigned int *ht64_call_hpte_insert1;
 	extern unsigned int *ht64_call_hpte_insert2;
 	extern unsigned int *ht64_call_hpte_remove;
@@ -658,7 +658,11 @@ int hash_page(unsigned long ea, unsigned
 			return 1;
 		}
 		vsid = get_vsid(mm->context.id, ea);
+#ifdef CONFIG_PPC_MM_SLICES
+		psize = get_slice_psize(mm, ea);
+#else
 		psize = mm->context.user_psize;
+#endif
 		break;
 	case VMALLOC_REGION_ID:
 		mm = &init_mm;
@@ -688,13 +692,21 @@ int hash_page(unsigned long ea, unsigned
 
 #ifdef CONFIG_HUGETLB_PAGE
 	/* Handle hugepage regions */
-	if (HPAGE_SHIFT &&
-	    unlikely(get_slice_psize(mm, ea) == mmu_huge_psize)) {
+	if (HPAGE_SHIFT && psize == mmu_huge_psize) {
 		DBG_LOW(" -> huge page !\n");
 		return hash_huge_page(mm, access, ea, vsid, local, trap);
 	}
 #endif /* CONFIG_HUGETLB_PAGE */
 
+#ifndef CONFIG_PPC_64K_PAGES
+	/* If we use 4K pages and our psize is not 4K, then we are hitting
+	 * a special driver mapping, we need to align the address before
+	 * we fetch the PTE
+	 */
+	if (psize != MMU_PAGE_4K)
+		ea &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
+#endif /* CONFIG_PPC_64K_PAGES */
+
 	/* Get PTE and page size from page tables */
 	ptep = find_linux_pte(pgdir, ea);
 	if (ptep == NULL || !pte_present(*ptep)) {
@@ -716,17 +728,22 @@ int hash_page(unsigned long ea, unsigned
 		return 1;
 	}
 
-	/* Do actual hashing */
-#ifndef CONFIG_PPC_64K_PAGES
-	rc = __hash_page_4K(ea, access, vsid, ptep, trap, local);
-#else
+	/* Handle demotion to 4K pages in situations where 64K pages are
+	 * not supported for cache inhibited mappings
+	 */
+#ifdef CONFIG_PPC_64K_PAGES
 	if (mmu_ci_restrictions)
-		psize = hash_handle_ci_restrictions(mm, ea, ptep, psize, user_region);
+		psize = hash_handle_ci_restrictions(mm, ea, ptep, psize,
+						    user_region);
+#endif /* CONFIG_PPC_64K_PAGES */
+
+	/* Do actual hashing */
+#ifdef CONFIG_PPC_HAS_HASH_64K
 	if (psize == MMU_PAGE_64K)
 		rc = __hash_page_64K(ea, access, vsid, ptep, trap, local);
 	else
+#endif /* CONFIG_PPC_HAS_HASH_64K */
 		rc = __hash_page_4K(ea, access, vsid, ptep, trap, local);
-#endif /* CONFIG_PPC_64K_PAGES */
 
 #ifndef CONFIG_PPC_64K_PAGES
 	DBG_LOW(" o-pte: %016lx\n", pte_val(*ptep));
@@ -775,17 +792,19 @@ void hash_preload(struct mm_struct *mm, 
 	mask = cpumask_of_cpu(smp_processor_id());
 	if (cpus_equal(mm->cpu_vm_mask, mask))
 		local = 1;
+
 	psize = mm->context.user_psize;
-#ifndef CONFIG_PPC_64K_PAGES
-	__hash_page_4K(ea, access, vsid, ptep, trap, local);
-#else
+#ifdef CONFIG_PPC_64K_PAGES
 	if (mmu_ci_restrictions)
 		psize = hash_handle_ci_restrictions(mm, ea, ptep, psize, 1);
+#endif /* CONFIG_PPC_64K_PAGES */
+
+#ifdef CONFIG_PPC_HAS_HASH_64K
 	if (psize == MMU_PAGE_64K)
 		__hash_page_64K(ea, access, vsid, ptep, trap, local);
 	else
-		__hash_page_4K(ea, access, vsid, ptep, trap, local);
 #endif /* CONFIG_PPC_64K_PAGES */
+		__hash_page_4K(ea, access, vsid, ptep, trap, local);
 	local_irq_restore(flags);
 }
 
Index: linux-cell/arch/powerpc/mm/tlb_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/mm/tlb_64.c	2007-02-20 18:03:14.000000000 +1100
+++ linux-cell/arch/powerpc/mm/tlb_64.c	2007-02-20 18:10:15.000000000 +1100
@@ -140,16 +140,22 @@ void hpte_update(struct mm_struct *mm, u
 	 */
 	addr &= PAGE_MASK;
 
-	/* Get page size (maybe move back to caller) */
+	/* Get page size (maybe move back to caller).
+	 *
+	 * NOTE: when using special 64K mappings in 4K environment like
+	 * for SPEs, we obtain the page size from the slice, which thus
+	 * must still exist (and thus the VMA not reused) at the time
+	 * of this call
+	 */
 	if (huge) {
 #ifdef CONFIG_HUGETLB_PAGE
 		psize = mmu_huge_psize;
 #else
 		BUG();
-		psize = pte_pagesize_index(pte); /* shutup gcc */
+		psize = pte_pagesize_index(mm, addr, pte); /* shutup gcc */
 #endif
 	} else
-		psize = pte_pagesize_index(pte);
+		psize = pte_pagesize_index(mm, addr, pte);
 
 	/*
 	 * This can happen when we are in the middle of a TLB batch and
Index: linux-cell/include/asm-powerpc/pgtable-4k.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/pgtable-4k.h	2007-02-20 18:03:14.000000000 +1100
+++ linux-cell/include/asm-powerpc/pgtable-4k.h	2007-02-20 18:10:15.000000000 +1100
@@ -78,7 +78,11 @@
 
 #define pte_iterate_hashed_end() } while(0)
 
-#define pte_pagesize_index(pte)	MMU_PAGE_4K
+#ifdef CONFIG_PPC_HAS_HASH_64K
+#define pte_pagesize_index(mm, addr, pte)	get_slice_psize(mm, addr)
+#else
+#define pte_pagesize_index(mm, addr, pte)	MMU_PAGE_4K
+#endif
 
 /*
  * 4-level page tables related bits
