Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 08 May 2007 16:27:28 +1000
Subject: [PATCH 3/5] powerpc: Add ability to 4K kernel to hash in 64K pages
In-Reply-To: <1178605646.637780.625211974455.qpush@grosgo>
Message-Id: <20070508062749.715A0DDEF5@ozlabs.org>
Cc: Hugh Dickins <hugh@veritas.com>, Paul Mackerras <paulus@samba.org>
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
 arch/powerpc/mm/hash_utils_64.c   |   39 ++++++++++++++++++++++++++------------
 arch/powerpc/mm/tlb_64.c          |   12 ++++++++---
 include/asm-powerpc/pgtable-4k.h  |    6 ++++-
 include/asm-powerpc/pgtable-64k.h |    7 +++++-
 6 files changed, 57 insertions(+), 18 deletions(-)

Index: linux-cell/arch/powerpc/mm/hash_low_64.S
===================================================================
--- linux-cell.orig/arch/powerpc/mm/hash_low_64.S	2007-05-08 15:27:03.000000000 +1000
+++ linux-cell/arch/powerpc/mm/hash_low_64.S	2007-05-08 15:29:21.000000000 +1000
@@ -615,6 +615,9 @@ htab_pte_insert_failure:
 	li	r3,-1
 	b	htab_bail
 
+#endif /* CONFIG_PPC_64K_PAGES */
+
+#ifdef CONFIG_PPC_HAS_HASH_64K
 
 /*****************************************************************************
  *                                                                           *
@@ -870,7 +873,7 @@ ht64_pte_insert_failure:
 	b	ht64_bail
 
 
-#endif /* CONFIG_PPC_64K_PAGES */
+#endif /* CONFIG_PPC_HAS_HASH_64K */
 
 
 /*****************************************************************************
Index: linux-cell/include/asm-powerpc/pgtable-64k.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/pgtable-64k.h	2007-05-08 15:27:03.000000000 +1000
+++ linux-cell/include/asm-powerpc/pgtable-64k.h	2007-05-08 15:29:21.000000000 +1000
@@ -36,6 +36,11 @@
 #define _PAGE_HPTE_SUB0	0x08000000 /* combo only: first sub page */
 #define _PAGE_COMBO	0x10000000 /* this is a combo 4k page */
 #define _PAGE_4K_PFN	0x20000000 /* PFN is for a single 4k page */
+
+/* Note the full page bits must be in the same location as for normal
+ * 4k pages as the same asssembly will be used to insert 64K pages
+ * wether the kernel has CONFIG_PPC_64K_PAGES or not
+ */
 #define _PAGE_F_SECOND  0x00008000 /* full page: hidx bits */
 #define _PAGE_F_GIX     0x00007000 /* full page: hidx bits */
 
@@ -91,7 +96,7 @@
 
 #define pte_iterate_hashed_end() } while(0); } } while(0)
 
-#define pte_pagesize_index(pte)	\
+#define pte_pagesize_index(mm, addr, pte)	\
 	(((pte) & _PAGE_COMBO)? MMU_PAGE_4K: MMU_PAGE_64K)
 
 #define remap_4k_pfn(vma, addr, pfn, prot)				\
Index: linux-cell/arch/powerpc/Kconfig
===================================================================
--- linux-cell.orig/arch/powerpc/Kconfig	2007-05-08 15:27:52.000000000 +1000
+++ linux-cell/arch/powerpc/Kconfig	2007-05-08 15:29:21.000000000 +1000
@@ -532,9 +532,15 @@ config NODES_SPAN_OTHER_NODES
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
--- linux-cell.orig/arch/powerpc/mm/hash_utils_64.c	2007-05-08 15:28:34.000000000 +1000
+++ linux-cell/arch/powerpc/mm/hash_utils_64.c	2007-05-08 15:29:21.000000000 +1000
@@ -420,7 +420,7 @@ static void __init htab_finish_init(void
 	extern unsigned int *htab_call_hpte_remove;
 	extern unsigned int *htab_call_hpte_updatepp;
 
-#ifdef CONFIG_PPC_64K_PAGES
+#ifdef CONFIG_PPC_HAS_HASH_64K
 	extern unsigned int *ht64_call_hpte_insert1;
 	extern unsigned int *ht64_call_hpte_insert2;
 	extern unsigned int *ht64_call_hpte_remove;
@@ -648,7 +648,11 @@ int hash_page(unsigned long ea, unsigned
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
@@ -678,13 +682,21 @@ int hash_page(unsigned long ea, unsigned
 
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
@@ -707,9 +719,7 @@ int hash_page(unsigned long ea, unsigned
 	}
 
 	/* Do actual hashing */
-#ifndef CONFIG_PPC_64K_PAGES
-	rc = __hash_page_4K(ea, access, vsid, ptep, trap, local);
-#else
+#ifdef CONFIG_PPC_64K_PAGES
 	/* If _PAGE_4K_PFN is set, make sure this is a 4k segment */
 	if (pte_val(*ptep) & _PAGE_4K_PFN) {
 		demote_segment_4k(mm, ea);
@@ -751,12 +761,14 @@ int hash_page(unsigned long ea, unsigned
 			mmu_psize_defs[mmu_vmalloc_psize].sllp;
 		slb_flush_and_rebolt();
 	}
+#endif /* CONFIG_PPC_64K_PAGES */
 
+#ifdef CONFIG_PPC_HAS_HASH_64K
 	if (psize == MMU_PAGE_64K)
 		rc = __hash_page_64K(ea, access, vsid, ptep, trap, local);
 	else
+#endif /* CONFIG_PPC_HAS_HASH_64K */
 		rc = __hash_page_4K(ea, access, vsid, ptep, trap, local);
-#endif /* CONFIG_PPC_64K_PAGES */
 
 #ifndef CONFIG_PPC_64K_PAGES
 	DBG_LOW(" o-pte: %016lx\n", pte_val(*ptep));
@@ -812,19 +824,22 @@ void hash_preload(struct mm_struct *mm, 
 	/* Get VSID */
 	vsid = get_vsid(mm->context.id, ea);
 
-	/* Hash it in */
+	/* Hash doesn't like irqs */
 	local_irq_save(flags);
+
+	/* Is that local to this CPU ? */
 	mask = cpumask_of_cpu(smp_processor_id());
 	if (cpus_equal(mm->cpu_vm_mask, mask))
 		local = 1;
-#ifndef CONFIG_PPC_64K_PAGES
-	__hash_page_4K(ea, access, vsid, ptep, trap, local);
-#else
+
+	/* Hash it in */
+#ifdef CONFIG_PPC_HAS_HASH_64K
 	if (mm->context.user_psize == MMU_PAGE_64K)
 		__hash_page_64K(ea, access, vsid, ptep, trap, local);
 	else
-		__hash_page_4K(ea, access, vsid, ptep, trap, local);
 #endif /* CONFIG_PPC_64K_PAGES */
+		__hash_page_4K(ea, access, vsid, ptep, trap, local);
+
 	local_irq_restore(flags);
 }
 
Index: linux-cell/arch/powerpc/mm/tlb_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/mm/tlb_64.c	2007-05-08 15:27:03.000000000 +1000
+++ linux-cell/arch/powerpc/mm/tlb_64.c	2007-05-08 15:29:21.000000000 +1000
@@ -143,16 +143,22 @@ void hpte_need_flush(struct mm_struct *m
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
 
 	/* Build full vaddr */
 	if (!is_kernel_addr(addr)) {
Index: linux-cell/include/asm-powerpc/pgtable-4k.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/pgtable-4k.h	2007-05-08 15:27:03.000000000 +1000
+++ linux-cell/include/asm-powerpc/pgtable-4k.h	2007-05-08 15:29:21.000000000 +1000
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
