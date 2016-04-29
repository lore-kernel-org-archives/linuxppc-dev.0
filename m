Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDxw6LX5zDqBD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 21/70] powerpc/mm: Move hash and no hash code to separate
 files
Date: Fri, 29 Apr 2016 23:25:44 +1000
Message-Id: <1461936393-10131-21-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This patch reduces the number of #ifdefs in C code and will also help in
adding radix changes later. Only code movement in this patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
[mpe: Propagate copyrights and update GPL text]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/Makefile         |   3 +-
 arch/powerpc/mm/init_64.c        |  74 ++----------------------
 arch/powerpc/mm/pgtable-book3e.c | 121 +++++++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/pgtable-hash64.c |  94 ++++++++++++++++++++++++++++++
 arch/powerpc/mm/pgtable_64.c     |  83 ---------------------------
 5 files changed, 222 insertions(+), 153 deletions(-)
 create mode 100644 arch/powerpc/mm/pgtable-book3e.c
 create mode 100644 arch/powerpc/mm/pgtable-hash64.c

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index adfee3f1aeb9..ef778997daa9 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -13,7 +13,8 @@ obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
 				   tlb_nohash_low.o
 obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(CONFIG_WORD_SIZE)e.o
 hash64-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
-obj-$(CONFIG_PPC_STD_MMU_64)	+= hash_utils_64.o slb_low.o slb.o $(hash64-y)
+obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
+obj-$(CONFIG_PPC_STD_MMU_64)	+= pgtable-hash64.o hash_utils_64.o slb_low.o slb.o $(hash64-y)
 obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o hash_low_32.o
 obj-$(CONFIG_PPC_STD_MMU)	+= tlb_hash$(CONFIG_WORD_SIZE).o \
 				   mmu_context_hash$(CONFIG_WORD_SIZE).o
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index ba655666186d..8d1daf7d9785 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -189,75 +189,6 @@ static int __meminit vmemmap_populated(unsigned long start, int page_size)
 	return 0;
 }
 
-/* On hash-based CPUs, the vmemmap is bolted in the hash table.
- *
- * On Book3E CPUs, the vmemmap is currently mapped in the top half of
- * the vmalloc space using normal page tables, though the size of
- * pages encoded in the PTEs can be different
- */
-
-#ifdef CONFIG_PPC_BOOK3E
-static int __meminit vmemmap_create_mapping(unsigned long start,
-					    unsigned long page_size,
-					    unsigned long phys)
-{
-	/* Create a PTE encoding without page size */
-	unsigned long i, flags = _PAGE_PRESENT | _PAGE_ACCESSED |
-		_PAGE_KERNEL_RW;
-
-	/* PTEs only contain page size encodings up to 32M */
-	BUG_ON(mmu_psize_defs[mmu_vmemmap_psize].enc > 0xf);
-
-	/* Encode the size in the PTE */
-	flags |= mmu_psize_defs[mmu_vmemmap_psize].enc << 8;
-
-	/* For each PTE for that area, map things. Note that we don't
-	 * increment phys because all PTEs are of the large size and
-	 * thus must have the low bits clear
-	 */
-	for (i = 0; i < page_size; i += PAGE_SIZE)
-		BUG_ON(map_kernel_page(start + i, phys, flags));
-
-	return 0;
-}
-
-#ifdef CONFIG_MEMORY_HOTPLUG
-static void vmemmap_remove_mapping(unsigned long start,
-				   unsigned long page_size)
-{
-}
-#endif
-#else /* CONFIG_PPC_BOOK3E */
-static int __meminit vmemmap_create_mapping(unsigned long start,
-					    unsigned long page_size,
-					    unsigned long phys)
-{
-	int rc = htab_bolt_mapping(start, start + page_size, phys,
-				   pgprot_val(PAGE_KERNEL),
-				   mmu_vmemmap_psize, mmu_kernel_ssize);
-	if (rc < 0) {
-		int rc2 = htab_remove_mapping(start, start + page_size,
-					      mmu_vmemmap_psize,
-					      mmu_kernel_ssize);
-		BUG_ON(rc2 && (rc2 != -ENOENT));
-	}
-	return rc;
-}
-
-#ifdef CONFIG_MEMORY_HOTPLUG
-static void vmemmap_remove_mapping(unsigned long start,
-				   unsigned long page_size)
-{
-	int rc = htab_remove_mapping(start, start + page_size,
-				     mmu_vmemmap_psize,
-				     mmu_kernel_ssize);
-	BUG_ON((rc < 0) && (rc != -ENOENT));
-	WARN_ON(rc == -ENOENT);
-}
-#endif
-
-#endif /* CONFIG_PPC_BOOK3E */
-
 struct vmemmap_backing *vmemmap_list;
 static struct vmemmap_backing *next;
 static int num_left;
@@ -309,6 +240,9 @@ static __meminit void vmemmap_list_populate(unsigned long phys,
 	vmemmap_list = vmem_back;
 }
 
+extern int __meminit vmemmap_create_mapping(unsigned long start,
+					    unsigned long page_size,
+					    unsigned long phys);
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 {
 	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
@@ -347,6 +281,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
+extern void vmemmap_remove_mapping(unsigned long start,
+				   unsigned long page_size);
 static unsigned long vmemmap_list_free(unsigned long start)
 {
 	struct vmemmap_backing *vmem_back, *vmem_back_prev;
diff --git a/arch/powerpc/mm/pgtable-book3e.c b/arch/powerpc/mm/pgtable-book3e.c
new file mode 100644
index 000000000000..b323735a8360
--- /dev/null
+++ b/arch/powerpc/mm/pgtable-book3e.c
@@ -0,0 +1,121 @@
+/*
+ * Copyright 2005, Paul Mackerras, IBM Corporation.
+ * Copyright 2009, Benjamin Herrenschmidt, IBM Corporation.
+ * Copyright 2015-2016, Aneesh Kumar K.V, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/sched.h>
+#include <linux/memblock.h>
+#include <asm/pgalloc.h>
+#include <asm/tlb.h>
+#include <asm/dma.h>
+
+#include "mmu_decl.h"
+
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+/*
+ * On Book3E CPUs, the vmemmap is currently mapped in the top half of
+ * the vmalloc space using normal page tables, though the size of
+ * pages encoded in the PTEs can be different
+ */
+int __meminit vmemmap_create_mapping(unsigned long start,
+				     unsigned long page_size,
+				     unsigned long phys)
+{
+	/* Create a PTE encoding without page size */
+	unsigned long i, flags = _PAGE_PRESENT | _PAGE_ACCESSED |
+		_PAGE_KERNEL_RW;
+
+	/* PTEs only contain page size encodings up to 32M */
+	BUG_ON(mmu_psize_defs[mmu_vmemmap_psize].enc > 0xf);
+
+	/* Encode the size in the PTE */
+	flags |= mmu_psize_defs[mmu_vmemmap_psize].enc << 8;
+
+	/* For each PTE for that area, map things. Note that we don't
+	 * increment phys because all PTEs are of the large size and
+	 * thus must have the low bits clear
+	 */
+	for (i = 0; i < page_size; i += PAGE_SIZE)
+		BUG_ON(map_kernel_page(start + i, phys, flags));
+
+	return 0;
+}
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+void vmemmap_remove_mapping(unsigned long start,
+			    unsigned long page_size)
+{
+}
+#endif
+#endif /* CONFIG_SPARSEMEM_VMEMMAP */
+
+static __ref void *early_alloc_pgtable(unsigned long size)
+{
+	void *pt;
+
+	pt = __va(memblock_alloc_base(size, size, __pa(MAX_DMA_ADDRESS)));
+	memset(pt, 0, size);
+
+	return pt;
+}
+
+/*
+ * map_kernel_page currently only called by __ioremap
+ * map_kernel_page adds an entry to the ioremap page table
+ * and adds an entry to the HPT, possibly bolting it
+ */
+int map_kernel_page(unsigned long ea, unsigned long pa, unsigned long flags)
+{
+	pgd_t *pgdp;
+	pud_t *pudp;
+	pmd_t *pmdp;
+	pte_t *ptep;
+
+	if (slab_is_available()) {
+		pgdp = pgd_offset_k(ea);
+		pudp = pud_alloc(&init_mm, pgdp, ea);
+		if (!pudp)
+			return -ENOMEM;
+		pmdp = pmd_alloc(&init_mm, pudp, ea);
+		if (!pmdp)
+			return -ENOMEM;
+		ptep = pte_alloc_kernel(pmdp, ea);
+		if (!ptep)
+			return -ENOMEM;
+		set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT,
+							  __pgprot(flags)));
+	} else {
+		pgdp = pgd_offset_k(ea);
+#ifndef __PAGETABLE_PUD_FOLDED
+		if (pgd_none(*pgdp)) {
+			pudp = early_alloc_pgtable(PUD_TABLE_SIZE);
+			BUG_ON(pudp == NULL);
+			pgd_populate(&init_mm, pgdp, pudp);
+		}
+#endif /* !__PAGETABLE_PUD_FOLDED */
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
+	}
+
+	smp_wmb();
+	return 0;
+}
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
new file mode 100644
index 000000000000..f405a67c807a
--- /dev/null
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -0,0 +1,94 @@
+/*
+ * Copyright 2005, Paul Mackerras, IBM Corporation.
+ * Copyright 2009, Benjamin Herrenschmidt, IBM Corporation.
+ * Copyright 2015-2016, Aneesh Kumar K.V, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/sched.h>
+#include <asm/pgalloc.h>
+#include <asm/tlb.h>
+
+#include "mmu_decl.h"
+
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+/*
+ * On hash-based CPUs, the vmemmap is bolted in the hash table.
+ *
+ */
+int __meminit vmemmap_create_mapping(unsigned long start,
+				     unsigned long page_size,
+				     unsigned long phys)
+{
+	int rc = htab_bolt_mapping(start, start + page_size, phys,
+				   pgprot_val(PAGE_KERNEL),
+				   mmu_vmemmap_psize, mmu_kernel_ssize);
+	if (rc < 0) {
+		int rc2 = htab_remove_mapping(start, start + page_size,
+					      mmu_vmemmap_psize,
+					      mmu_kernel_ssize);
+		BUG_ON(rc2 && (rc2 != -ENOENT));
+	}
+	return rc;
+}
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+void vmemmap_remove_mapping(unsigned long start,
+			    unsigned long page_size)
+{
+	int rc = htab_remove_mapping(start, start + page_size,
+				     mmu_vmemmap_psize,
+				     mmu_kernel_ssize);
+	BUG_ON((rc < 0) && (rc != -ENOENT));
+	WARN_ON(rc == -ENOENT);
+}
+#endif
+#endif /* CONFIG_SPARSEMEM_VMEMMAP */
+
+/*
+ * map_kernel_page currently only called by __ioremap
+ * map_kernel_page adds an entry to the ioremap page table
+ * and adds an entry to the HPT, possibly bolting it
+ */
+int map_kernel_page(unsigned long ea, unsigned long pa, unsigned long flags)
+{
+	pgd_t *pgdp;
+	pud_t *pudp;
+	pmd_t *pmdp;
+	pte_t *ptep;
+
+	if (slab_is_available()) {
+		pgdp = pgd_offset_k(ea);
+		pudp = pud_alloc(&init_mm, pgdp, ea);
+		if (!pudp)
+			return -ENOMEM;
+		pmdp = pmd_alloc(&init_mm, pudp, ea);
+		if (!pmdp)
+			return -ENOMEM;
+		ptep = pte_alloc_kernel(pmdp, ea);
+		if (!ptep)
+			return -ENOMEM;
+		set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT,
+							  __pgprot(flags)));
+	} else {
+		/*
+		 * If the mm subsystem is not fully up, we cannot create a
+		 * linux page table entry for this mapping.  Simply bolt an
+		 * entry in the hardware page table.
+		 *
+		 */
+		if (htab_bolt_mapping(ea, ea + PAGE_SIZE, pa, flags,
+				      mmu_io_psize, mmu_kernel_ssize)) {
+			printk(KERN_ERR "Failed to do bolted mapping IO "
+			       "memory at %016lx !\n", pa);
+			return -ENOMEM;
+		}
+	}
+
+	smp_wmb();
+	return 0;
+}
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 8f3b2942fba8..1bfb112e1453 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -78,89 +78,6 @@ struct patb_entry *partition_tb;
 #endif
 unsigned long ioremap_bot = IOREMAP_BASE;
 
-#ifdef CONFIG_PPC_MMU_NOHASH
-static __ref void *early_alloc_pgtable(unsigned long size)
-{
-	void *pt;
-
-	pt = __va(memblock_alloc_base(size, size, __pa(MAX_DMA_ADDRESS)));
-	memset(pt, 0, size);
-
-	return pt;
-}
-#endif /* CONFIG_PPC_MMU_NOHASH */
-
-/*
- * map_kernel_page currently only called by __ioremap
- * map_kernel_page adds an entry to the ioremap page table
- * and adds an entry to the HPT, possibly bolting it
- */
-int map_kernel_page(unsigned long ea, unsigned long pa, unsigned long flags)
-{
-	pgd_t *pgdp;
-	pud_t *pudp;
-	pmd_t *pmdp;
-	pte_t *ptep;
-
-	if (slab_is_available()) {
-		pgdp = pgd_offset_k(ea);
-		pudp = pud_alloc(&init_mm, pgdp, ea);
-		if (!pudp)
-			return -ENOMEM;
-		pmdp = pmd_alloc(&init_mm, pudp, ea);
-		if (!pmdp)
-			return -ENOMEM;
-		ptep = pte_alloc_kernel(pmdp, ea);
-		if (!ptep)
-			return -ENOMEM;
-		set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT,
-							  __pgprot(flags)));
-	} else {
-#ifdef CONFIG_PPC_MMU_NOHASH
-		pgdp = pgd_offset_k(ea);
-#ifdef PUD_TABLE_SIZE
-		if (pgd_none(*pgdp)) {
-			pudp = early_alloc_pgtable(PUD_TABLE_SIZE);
-			BUG_ON(pudp == NULL);
-			pgd_populate(&init_mm, pgdp, pudp);
-		}
-#endif /* PUD_TABLE_SIZE */
-		pudp = pud_offset(pgdp, ea);
-		if (pud_none(*pudp)) {
-			pmdp = early_alloc_pgtable(PMD_TABLE_SIZE);
-			BUG_ON(pmdp == NULL);
-			pud_populate(&init_mm, pudp, pmdp);
-		}
-		pmdp = pmd_offset(pudp, ea);
-		if (!pmd_present(*pmdp)) {
-			ptep = early_alloc_pgtable(PAGE_SIZE);
-			BUG_ON(ptep == NULL);
-			pmd_populate_kernel(&init_mm, pmdp, ptep);
-		}
-		ptep = pte_offset_kernel(pmdp, ea);
-		set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT,
-							  __pgprot(flags)));
-#else /* CONFIG_PPC_MMU_NOHASH */
-		/*
-		 * If the mm subsystem is not fully up, we cannot create a
-		 * linux page table entry for this mapping.  Simply bolt an
-		 * entry in the hardware page table.
-		 *
-		 */
-		if (htab_bolt_mapping(ea, ea + PAGE_SIZE, pa, flags,
-				      mmu_io_psize, mmu_kernel_ssize)) {
-			printk(KERN_ERR "Failed to do bolted mapping IO "
-			       "memory at %016lx !\n", pa);
-			return -ENOMEM;
-		}
-#endif /* !CONFIG_PPC_MMU_NOHASH */
-	}
-
-	smp_wmb();
-	return 0;
-}
-
-
 /**
  * __ioremap_at - Low level function to establish the page tables
  *                for an IO mapping
-- 
2.5.0
