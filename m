Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqpr1ZQgzDqFM
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:25:08 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 02:25:06 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 133AE19D803E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:12:56 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u2R8P2pq46661856
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 01:25:02 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8P0gG027086
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:25:02 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 16/65] powerpc/mm: Move hash and no hash code to separate files
Date: Sun, 27 Mar 2016 13:53:24 +0530
Message-Id: <1459067053-10835-16-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch reduce #ifdef in C code and also help in adding radix changes
later. Only code movement in this patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/Makefile         |   3 +-
 arch/powerpc/mm/init_64.c        |  74 ++--------------------
 arch/powerpc/mm/pgtable-book3e.c | 128 +++++++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/pgtable-hash64.c | 100 ++++++++++++++++++++++++++++++
 arch/powerpc/mm/pgtable_64.c     |  83 -------------------------
 5 files changed, 235 insertions(+), 153 deletions(-)
 create mode 100644 arch/powerpc/mm/pgtable-book3e.c
 create mode 100644 arch/powerpc/mm/pgtable-hash64.c

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 1ffeda85c086..6b5cc805c7ba 100644
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
index 000000000000..f75ba4142875
--- /dev/null
+++ b/arch/powerpc/mm/pgtable-book3e.c
@@ -0,0 +1,128 @@
+
+/*
+ * Copyright IBM Corporation, 2015
+ * Author Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU Lesser General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ */
+
+/*
+ * PPC64 THP Support for hash based MMUs
+ */
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
index 000000000000..04d6fa12789e
--- /dev/null
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -0,0 +1,100 @@
+/*
+ * Copyright IBM Corporation, 2015
+ * Author Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU Lesser General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ */
+
+/*
+ * PPC64 THP Support for hash based MMUs
+ */
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
index 5fff787da17a..d493f62d12eb 100644
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
