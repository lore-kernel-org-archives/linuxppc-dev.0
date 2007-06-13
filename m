Return-Path: <dgibson@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 6/13] Start factoring pgtable-ppc32.h and pgtable-ppc64.h
In-Reply-To: <20070613045031.GD16148@localhost.localdomain>
Message-Id: <20070613045256.E9CA3DDE25@ozlabs.org>
Date: Wed, 13 Jun 2007 14:52:56 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
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

 include/asm-powerpc/pgtable-ppc32.h |   22 ----------------------
 include/asm-powerpc/pgtable-ppc64.h |   29 -----------------------------
 include/asm-powerpc/pgtable.h       |   28 ++++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 51 deletions(-)

Index: working-2.6/include/asm-powerpc/pgtable-ppc32.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/pgtable-ppc32.h	2007-05-30 16:47:25.000000000 +1000
+++ working-2.6/include/asm-powerpc/pgtable-ppc32.h	2007-05-30 17:17:38.000000000 +1000
@@ -6,11 +6,7 @@
 #ifndef __ASSEMBLY__
 #include <linux/sched.h>
 #include <linux/threads.h>
-#include <asm/processor.h>		/* For TASK_SIZE */
-#include <asm/mmu.h>
-#include <asm/page.h>
 #include <asm/io.h>			/* For sub-arch specific PPC_PIN_SIZE */
-struct mm_struct;
 
 extern unsigned long va_to_phys(unsigned long address);
 extern pte_t *va_to_pte(unsigned long address);
@@ -488,14 +484,6 @@ extern unsigned long bad_call_to_PMD_PAG
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
@@ -730,10 +718,6 @@ extern pgprot_t phys_mem_access_prot(str
 #define pte_unmap(pte)		kunmap_atomic(pte, KM_PTE0)
 #define pte_unmap_nested(pte)	kunmap_atomic(pte, KM_PTE1)
 
-extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
-
-extern void paging_init(void);
-
 /*
  * Encode and decode a swap entry.
  * Note that the bits we use in a PTE for representing a swap entry
@@ -751,12 +735,6 @@ extern void paging_init(void);
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
--- working-2.6.orig/include/asm-powerpc/pgtable-ppc64.h	2007-05-30 16:47:25.000000000 +1000
+++ working-2.6/include/asm-powerpc/pgtable-ppc64.h	2007-05-30 16:52:16.000000000 +1000
@@ -7,11 +7,7 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/stddef.h>
-#include <asm/processor.h>		/* For TASK_SIZE */
-#include <asm/mmu.h>
-#include <asm/page.h>
 #include <asm/tlbflush.h>
-struct mm_struct;
 #endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_PPC_64K_PAGES
@@ -134,16 +130,6 @@ struct mm_struct;
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
@@ -438,10 +424,6 @@ extern pgprot_t phys_mem_access_prot(str
 #define pgd_ERROR(e) \
 	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
-extern pgd_t swapper_pg_dir[];
-
-extern void paging_init(void);
-
 /* Encode and de-code a swap entry */
 #define __swp_type(entry)	(((entry).val >> 1) & 0x3f)
 #define __swp_offset(entry)	((entry).val >> 8)
@@ -452,17 +434,6 @@ extern void paging_init(void);
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
--- working-2.6.orig/include/asm-powerpc/pgtable.h	2007-05-30 16:47:25.000000000 +1000
+++ working-2.6/include/asm-powerpc/pgtable.h	2007-05-30 16:52:11.000000000 +1000
@@ -2,6 +2,13 @@
 #define _ASM_POWERPC_PGTABLE_H
 #ifdef __KERNEL__
 
+#ifndef __ASSEMBLY__
+#include <asm/processor.h>		/* For TASK_SIZE */
+#include <asm/mmu.h>
+#include <asm/page.h>
+struct mm_struct;
+#endif /* !__ASSEMBLY__ */
+
 #if defined(CONFIG_PPC64)
 #  include <asm/pgtable-ppc64.h>
 #else
@@ -9,6 +16,27 @@
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
 
