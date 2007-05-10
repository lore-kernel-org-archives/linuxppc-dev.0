Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 6/7] Start factoring pgtable-ppc32.h and pgtable-ppc64.h
In-Reply-To: <20070510060449.GA3118@localhost.localdomain>
Message-Id: <20070510060556.E5E00DDEBF@ozlabs.org>
Date: Thu, 10 May 2007 16:05:56 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch factors some things defined in both pgtable-ppc32.h and
pgtable-ppc64.h into the common part of asm-powerpc/pgtable.h.  These
are all things which have essentially identical definitions, and which
by their nature are very unlikely ever to need different definitions
in the two cases.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

 include/asm-powerpc/pgtable-ppc32.h |   18 ------------------
 include/asm-powerpc/pgtable-ppc64.h |   25 -------------------------
 include/asm-powerpc/pgtable.h       |   21 +++++++++++++++++++++
 3 files changed, 21 insertions(+), 43 deletions(-)

Index: working-2.6/include/asm-powerpc/pgtable-ppc32.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/pgtable-ppc32.h	2007-05-10 15:18:49.000000000 +1000
+++ working-2.6/include/asm-powerpc/pgtable-ppc32.h	2007-05-10 15:18:49.000000000 +1000
@@ -488,14 +488,6 @@ extern unsigned long bad_call_to_PMD_PAG
 #define pfn_pte(pfn, prot)	__pte(((pte_basic_t)(pfn) << PFN_SHIFT_OFFSET) |\
 					pgprot_val(prot))
 #define mk_pte(page, prot)	pfn_pte(page_to_pfn(page), prot)
-
-/*
- * ZERO_PAGE is a global shared page that is always zero: used
- * for zero-mapped memory areas etc..
- */
-extern unsigned long empty_zero_page[1024];
-#define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
-
 #endif /* __ASSEMBLY__ */
 
 #define pte_none(pte)		((pte_val(pte) & ~_PTE_NONE_MASK) == 0)
@@ -730,10 +722,6 @@ extern pgprot_t phys_mem_access_prot(str
 #define pte_unmap(pte)		kunmap_atomic(pte, KM_PTE0)
 #define pte_unmap_nested(pte)	kunmap_atomic(pte, KM_PTE1)
 
-extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
-
-extern void paging_init(void);
-
 /*
  * Encode and decode a swap entry.
  * Note that the bits we use in a PTE for representing a swap entry
@@ -751,12 +739,6 @@ extern void paging_init(void);
 #define pte_to_pgoff(pte)	(pte_val(pte) >> 3)
 #define pgoff_to_pte(off)	((pte_t) { ((off) << 3) | _PAGE_FILE })
 
-/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-#define kern_addr_valid(addr)	(1)
-
-#define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
-		remap_pfn_range(vma, vaddr, pfn, size, prot)
-
 /*
  * No page table caches to initialise
  */
Index: working-2.6/include/asm-powerpc/pgtable-ppc64.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/pgtable-ppc64.h	2007-05-07 12:57:07.000000000 +1000
+++ working-2.6/include/asm-powerpc/pgtable-ppc64.h	2007-05-10 15:18:49.000000000 +1000
@@ -134,16 +134,6 @@ struct mm_struct;
 #define __S110	PAGE_SHARED_X
 #define __S111	PAGE_SHARED_X
 
-#ifndef __ASSEMBLY__
-
-/*
- * ZERO_PAGE is a global shared page that is always zero: used
- * for zero-mapped memory areas etc..
- */
-extern unsigned long empty_zero_page[PAGE_SIZE/sizeof(unsigned long)];
-#define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
-#endif /* __ASSEMBLY__ */
-
 #ifdef CONFIG_HUGETLB_PAGE
 
 #define HAVE_ARCH_UNMAPPED_AREA
@@ -438,10 +428,6 @@ extern pgprot_t phys_mem_access_prot(str
 #define pgd_ERROR(e) \
 	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
-extern pgd_t swapper_pg_dir[];
-
-extern void paging_init(void);
-
 /* Encode and de-code a swap entry */
 #define __swp_type(entry)	(((entry).val >> 1) & 0x3f)
 #define __swp_offset(entry)	((entry).val >> 8)
@@ -452,17 +438,6 @@ extern void paging_init(void);
 #define pgoff_to_pte(off)	((pte_t) {((off) << PTE_RPN_SHIFT)|_PAGE_FILE})
 #define PTE_FILE_MAX_BITS	(BITS_PER_LONG - PTE_RPN_SHIFT)
 
-/*
- * kern_addr_valid is intended to indicate whether an address is a valid
- * kernel address.  Most 32-bit archs define it as always true (like this)
- * but most 64-bit archs actually perform a test.  What should we do here?
- * The only use is in fs/ncpfs/dir.c
- */
-#define kern_addr_valid(addr)	(1)
-
-#define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
-		remap_pfn_range(vma, vaddr, pfn, size, prot)
-
 void pgtable_cache_init(void);
 
 /*
Index: working-2.6/include/asm-powerpc/pgtable.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/pgtable.h	2007-05-07 12:57:07.000000000 +1000
+++ working-2.6/include/asm-powerpc/pgtable.h	2007-05-10 15:51:16.000000000 +1000
@@ -9,6 +9,27 @@
 #endif
 
 #ifndef __ASSEMBLY__
+/*
+ * ZERO_PAGE is a global shared page that is always zero: used
+ * for zero-mapped memory areas etc..
+ */
+extern unsigned long empty_zero_page[];
+#define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
+
+extern pgd_t swapper_pg_dir[];
+
+extern void paging_init(void);
+
+/*
+ * kern_addr_valid is intended to indicate whether an address is a valid
+ * kernel address.  Most 32-bit archs define it as always true (like this)
+ * but most 64-bit archs actually perform a test.  What should we do here?
+ */
+#define kern_addr_valid(addr)	(1)
+
+#define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
+		remap_pfn_range(vma, vaddr, pfn, size, prot)
+
 #include <asm-generic/pgtable.h>
 #endif /* __ASSEMBLY__ */
 
