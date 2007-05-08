Return-Path: <dgibson@ozlabs.org>
Date: Tue, 8 May 2007 12:46:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: powerpc: Remove use of 4level-fixup.h for ppc32
Message-ID: <20070508024649.GB11340@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For 32-bit systems, powerpc still relies on the 4level-fixup.h hack,
to pretend that the generic pagetable handling stuff is 3-levels
rather than 4.  This patch removes this, instead using the newer
pgtable-nopmd.h to handle the elision of both the pud and pmd
pagetable levels (ppc32 pagetables are actually 2 levels).

This removes a little extraneous code, and makes it more easily
compared to the 64-bit pagetable code.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 arch/powerpc/lib/dma-noncoherent.c  |    4 +++-
 arch/powerpc/mm/pgtable_32.c        |   28 ++++++++++++++++------------
 include/asm-powerpc/page.h          |   12 ++++++++----
 include/asm-powerpc/pgalloc-32.h    |    4 ++--
 include/asm-powerpc/pgtable-ppc32.h |   30 ++----------------------------
 5 files changed, 31 insertions(+), 47 deletions(-)

Index: working-2.6/include/asm-powerpc/pgtable-ppc32.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/pgtable-ppc32.h	2007-05-08 10:05:16.000000000 +1000
+++ working-2.6/include/asm-powerpc/pgtable-ppc32.h	2007-05-08 12:37:45.000000000 +1000
@@ -1,7 +1,7 @@
 #ifndef _ASM_POWERPC_PGTABLE_PPC32_H
 #define _ASM_POWERPC_PGTABLE_PPC32_H
 
-#include <asm-generic/4level-fixup.h>
+#include <asm-generic/pgtable-nopmd.h>
 
 #ifndef __ASSEMBLY__
 #include <linux/sched.h>
@@ -76,13 +76,8 @@ extern unsigned long ioremap_bot, iorema
  * level has 2048 entries and the second level has 512 64-bit PTE entries.
  * -Matt
  */
-/* PMD_SHIFT determines the size of the area mapped by the PTE pages */
-#define PMD_SHIFT	(PAGE_SHIFT + PTE_SHIFT)
-#define PMD_SIZE	(1UL << PMD_SHIFT)
-#define PMD_MASK	(~(PMD_SIZE-1))
-
 /* PGDIR_SHIFT determines what a top-level page table entry can map */
-#define PGDIR_SHIFT	PMD_SHIFT
+#define PGDIR_SHIFT	(PAGE_SHIFT + PTE_SHIFT)
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
@@ -103,8 +98,6 @@ extern unsigned long ioremap_bot, iorema
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %llx.\n", __FILE__, __LINE__, \
 		(unsigned long long)pte_val(e))
-#define pmd_ERROR(e) \
-	printk("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pmd_val(e))
 #define pgd_ERROR(e) \
 	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
@@ -516,19 +509,6 @@ extern unsigned long empty_zero_page[102
 
 #ifndef __ASSEMBLY__
 /*
- * The "pgd_xxx()" functions here are trivial for a folded two-level
- * setup: the pgd is never bad, and a pmd always exists (as it's folded
- * into the pgd entry)
- */
-static inline int pgd_none(pgd_t pgd)		{ return 0; }
-static inline int pgd_bad(pgd_t pgd)		{ return 0; }
-static inline int pgd_present(pgd_t pgd)	{ return 1; }
-#define pgd_clear(xp)				do { } while (0)
-
-#define pgd_page_vaddr(pgd) \
-	((unsigned long) __va(pgd_val(pgd) & PAGE_MASK))
-
-/*
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
  */
@@ -737,12 +717,6 @@ extern pgprot_t phys_mem_access_prot(str
 #define pgd_index(address)	 ((address) >> PGDIR_SHIFT)
 #define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
 
-/* Find an entry in the second-level page table.. */
-static inline pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
-{
-	return (pmd_t *) dir;
-}
-
 /* Find an entry in the third-level page table.. */
 #define pte_index(address)		\
 	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
Index: working-2.6/include/asm-powerpc/page.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/page.h	2007-05-08 12:37:45.000000000 +1000
+++ working-2.6/include/asm-powerpc/page.h	2007-05-08 12:37:45.000000000 +1000
@@ -121,16 +121,18 @@ typedef struct { pte_t pte; } real_pte_t
 #endif
 
 /* PMD level */
+#ifdef CONFIG_PPC64
 typedef struct { unsigned long pmd; } pmd_t;
 #define pmd_val(x)	((x).pmd)
 #define __pmd(x)	((pmd_t) { (x) })
 
 /* PUD level exusts only on 4k pages */
-#if defined(CONFIG_PPC64) && !defined(CONFIG_PPC_64K_PAGES)
+#ifndef CONFIG_PPC_64K_PAGES
 typedef struct { unsigned long pud; } pud_t;
 #define pud_val(x)	((x).pud)
 #define __pud(x)	((pud_t) { (x) })
-#endif
+#endif /* !CONFIG_PPC_64K_PAGES */
+#endif /* CONFIG_PPC64 */
 
 /* PGD level */
 typedef struct { unsigned long pgd; } pgd_t;
@@ -159,15 +161,17 @@ typedef unsigned long real_pte_t;
 #endif
 
 
+#ifdef CONFIG_PPC64
 typedef unsigned long pmd_t;
 #define pmd_val(x)	(x)
 #define __pmd(x)	(x)
 
-#if defined(CONFIG_PPC64) && !defined(CONFIG_PPC_64K_PAGES)
+#ifndef CONFIG_PPC_64K_PAGES
 typedef unsigned long pud_t;
 #define pud_val(x)	(x)
 #define __pud(x)	(x)
-#endif
+#endif /* !CONFIG_PPC_64K_PAGES */
+#endif /* CONFIG_PPC64 */
 
 typedef unsigned long pgd_t;
 #define pgd_val(x)	(x)
Index: working-2.6/arch/powerpc/mm/pgtable_32.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/pgtable_32.c	2007-04-26 13:57:24.000000000 +1000
+++ working-2.6/arch/powerpc/mm/pgtable_32.c	2007-05-08 12:37:45.000000000 +1000
@@ -261,7 +261,7 @@ int map_page(unsigned long va, phys_addr
 	int err = -ENOMEM;
 
 	/* Use upper 10 bits of VA to index the first level map */
-	pd = pmd_offset(pgd_offset_k(va), va);
+	pd = pmd_offset(pud_offset(pgd_offset_k(va), va), va);
 	/* Use middle 10 bits of VA to index the second-level map */
 	pg = pte_alloc_kernel(pd, va);
 	if (pg != 0) {
@@ -354,23 +354,27 @@ int
 get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep, pmd_t **pmdp)
 {
         pgd_t	*pgd;
+	pud_t	*pud;
         pmd_t	*pmd;
         pte_t	*pte;
         int     retval = 0;
 
         pgd = pgd_offset(mm, addr & PAGE_MASK);
         if (pgd) {
-                pmd = pmd_offset(pgd, addr & PAGE_MASK);
-                if (pmd_present(*pmd)) {
-                        pte = pte_offset_map(pmd, addr & PAGE_MASK);
-                        if (pte) {
-				retval = 1;
-				*ptep = pte;
-				if (pmdp)
-					*pmdp = pmd;
-				/* XXX caller needs to do pte_unmap, yuck */
-                        }
-                }
+		pud = pud_offset(pgd, addr & PAGE_MASK);
+		if (pud && pud_present(*pud)) {
+			pmd = pmd_offset(pud, addr & PAGE_MASK);
+			if (pmd_present(*pmd)) {
+				pte = pte_offset_map(pmd, addr & PAGE_MASK);
+				if (pte) {
+					retval = 1;
+					*ptep = pte;
+					if (pmdp)
+						*pmdp = pmd;
+					/* XXX caller needs to do pte_unmap, yuck */
+				}
+			}
+		}
         }
         return(retval);
 }
Index: working-2.6/include/asm-powerpc/pgalloc-32.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/pgalloc-32.h	2007-05-07 12:57:07.000000000 +1000
+++ working-2.6/include/asm-powerpc/pgalloc-32.h	2007-05-08 12:37:45.000000000 +1000
@@ -12,10 +12,10 @@ extern void pgd_free(pgd_t *pgd);
  * We don't have any real pmd's, and this code never triggers because
  * the pgd will always be present..
  */
-#define pmd_alloc_one(mm,address)       ({ BUG(); ((pmd_t *)2); })
+/* #define pmd_alloc_one(mm,address)       ({ BUG(); ((pmd_t *)2); }) */
 #define pmd_free(x)                     do { } while (0)
 #define __pmd_free_tlb(tlb,x)		do { } while (0)
-#define pgd_populate(mm, pmd, pte)      BUG()
+/* #define pgd_populate(mm, pmd, pte)      BUG() */
 
 #ifndef CONFIG_BOOKE
 #define pmd_populate_kernel(mm, pmd, pte)	\
Index: working-2.6/arch/powerpc/lib/dma-noncoherent.c
===================================================================
--- working-2.6.orig/arch/powerpc/lib/dma-noncoherent.c	2007-02-09 09:57:55.000000000 +1100
+++ working-2.6/arch/powerpc/lib/dma-noncoherent.c	2007-05-08 12:37:45.000000000 +1000
@@ -306,13 +306,15 @@ EXPORT_SYMBOL(__dma_free_coherent);
 static int __init dma_alloc_init(void)
 {
 	pgd_t *pgd;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 	int ret = 0;
 
 	do {
 		pgd = pgd_offset(&init_mm, CONSISTENT_BASE);
-		pmd = pmd_alloc(&init_mm, pgd, CONSISTENT_BASE);
+		pud = pud_alloc(&init_mm, pgd, CONSISTENT_BASE);
+		pmd = pmd_alloc(&init_mm, pud, CONSISTENT_BASE);
 		if (!pmd) {
 			printk(KERN_ERR "%s: no pmd tables\n", __func__);
 			ret = -ENOMEM;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
