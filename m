Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EFA45B7BCE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 15:59:52 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 23 Jul 2009 15:59:41 +1000
Subject: [PATCH 6/20] powerpc/mm: Add support for early ioremap on non-hash
	64-bit processors
Message-Id: <20090723055952.E2DCCDDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds some code to do early ioremap's using page tables instead of
bolting entries in the hash table. This will be used by the upcoming
64-bits BookE port.

The patch also changes the test for early vs. late ioremap to use
slab_is_available() instead of our old hackish mem_init_done.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/mm/pgtable_64.c |   59 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 5 deletions(-)

--- linux-work.orig/arch/powerpc/mm/pgtable_64.c	2009-07-22 15:49:09.000000000 +1000
+++ linux-work/arch/powerpc/mm/pgtable_64.c	2009-07-23 14:56:39.000000000 +1000
@@ -33,6 +33,8 @@
 #include <linux/stddef.h>
 #include <linux/vmalloc.h>
 #include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/lmb.h>
 
 #include <asm/pgalloc.h>
 #include <asm/page.h>
@@ -55,19 +57,36 @@
 
 unsigned long ioremap_bot = IOREMAP_BASE;
 
+
+#ifdef CONFIG_PPC_MMU_NOHASH
+static void *early_alloc_pgtable(unsigned long size)
+{
+	void *pt;
+
+	if (init_bootmem_done)
+		pt = __alloc_bootmem(size, size, __pa(MAX_DMA_ADDRESS));
+	else
+		pt = __va(lmb_alloc_base(size, size,
+					 __pa(MAX_DMA_ADDRESS)));
+	memset(pt, 0, size);
+
+	return pt;
+}
+#endif /* CONFIG_PPC_MMU_NOHASH */
+
 /*
- * map_io_page currently only called by __ioremap
- * map_io_page adds an entry to the ioremap page table
+ * map_kernel_page currently only called by __ioremap
+ * map_kernel_page adds an entry to the ioremap page table
  * and adds an entry to the HPT, possibly bolting it
  */
-static int map_io_page(unsigned long ea, unsigned long pa, int flags)
+static int map_kernel_page(unsigned long ea, unsigned long pa, int flags)
 {
 	pgd_t *pgdp;
 	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
 
-	if (mem_init_done) {
+	if (slab_is_available()) {
 		pgdp = pgd_offset_k(ea);
 		pudp = pud_alloc(&init_mm, pgdp, ea);
 		if (!pudp)
@@ -81,6 +100,35 @@ static int map_io_page(unsigned long ea,
 		set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT,
 							  __pgprot(flags)));
 	} else {
+#ifdef CONFIG_PPC_MMU_NOHASH
+		/* Warning ! This will blow up if bootmem is not initialized
+		 * which our ppc64 code is keen to do that, we'll need to
+		 * fix it and/or be more careful
+		 */
+		pgdp = pgd_offset_k(ea);
+#ifdef PUD_TABLE_SIZE
+		if (pgd_none(*pgdp)) {
+			pudp = early_alloc_pgtable(PUD_TABLE_SIZE);
+			BUG_ON(pudp == NULL);
+			pgd_populate(&init_mm, pgdp, pudp);
+		}
+#endif /* PUD_TABLE_SIZE */
+		pudp = pud_offset(pgdp, ea);
+		if (pud_none(*pudp)) {
+			pmdp = early_alloc_pgtable(PMD_TABLE_SIZE);
+			BUG_ON(pmdp == NULL);
+			pud_populate(&init_mm, pudp, pmdp);
+		}
+		pmdp = pmd_offset(pudp, ea);
+		if (!pmd_present(*pmdp)) {
+			ptep = early_alloc_pgtable(PAGE_SIZE);
+			BUG_ON(ptep == NULL);
+			pmd_populate_kernel(&init_mm, pmdp, ptep);
+		}
+		ptep = pte_offset_kernel(pmdp, ea);
+		set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT,
+							  __pgprot(flags)));
+#else /* CONFIG_PPC_MMU_NOHASH */
 		/*
 		 * If the mm subsystem is not fully up, we cannot create a
 		 * linux page table entry for this mapping.  Simply bolt an
@@ -93,6 +141,7 @@ static int map_io_page(unsigned long ea,
 			       "memory at %016lx !\n", pa);
 			return -ENOMEM;
 		}
+#endif /* !CONFIG_PPC_MMU_NOHASH */
 	}
 	return 0;
 }
@@ -124,7 +173,7 @@ void __iomem * __ioremap_at(phys_addr_t 
 	WARN_ON(size & ~PAGE_MASK);
 
 	for (i = 0; i < size; i += PAGE_SIZE)
-		if (map_io_page((unsigned long)ea+i, pa+i, flags))
+		if (map_kernel_page((unsigned long)ea+i, pa+i, flags))
 			return NULL;
 
 	return (void __iomem *)ea;
