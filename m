Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VqNQ6jdzzF3Hb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 18:01:26 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6I7xM55045546
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 04:01:24 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ka027kcvd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 04:01:23 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 18 Jul 2018 04:01:21 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 2/2] powerpc/mm/book3s/radix: Add mapping statistics
Date: Wed, 18 Jul 2018 13:31:12 +0530
In-Reply-To: <20180718080112.16633-1-aneesh.kumar@linux.ibm.com>
References: <20180718080112.16633-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180718080112.16633-2-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add statistics that show how memory is mapped within the kernel linear mapping.
This is similar to commit 37cd944c8d8f ("s390/pgtable: add mapping statistics")

We don't do this with Hash translation mode. Hash uses one size (mmu_linear_psize)
to map the kernel linear mapping and we print the linear psize during boot as
below.

"Page orders: linear mapping = 24, virtual = 16, io = 16, vmemmap = 24"

A sample output looks like:

DirectMap4k:           0 kB
DirectMap64k:       18432 kB
DirectMap2M:     1030144 kB
DirectMap1G:    11534336 kB

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 13 ++++++++++++
 arch/powerpc/include/asm/book3s/64/radix.h   |  3 +++
 arch/powerpc/mm/pgtable-book3s64.c           | 22 ++++++++++++++++++++
 arch/powerpc/mm/pgtable-radix.c              | 13 +++++++-----
 4 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 01ee40f11f3a..1d2d69ae1bd2 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -208,4 +208,17 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 
 #define check_pgt_cache()	do { } while (0)
 
+extern atomic_long_t direct_pages_count[MMU_PAGE_COUNT];
+static inline void update_page_count(unsigned long mapping_shift, long count)
+{
+	int level;
+
+	if (IS_ENABLED(CONFIG_PROC_FS)) {
+		level = shift_to_mmu_psize(mapping_shift);
+		if (level < 0)
+			return;
+		atomic_long_add(count, &direct_pages_count[level]);
+	}
+}
+
 #endif /* _ASM_POWERPC_BOOK3S_64_PGALLOC_H */
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 3ab3f7aef022..56a6e3f5f7c1 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -30,6 +30,9 @@
 #define RADIX_PUD_BAD_BITS		0x60000000000000e0UL
 #define RADIX_PGD_BAD_BITS		0x60000000000000e0UL
 
+#define RADIX_PMD_SHIFT		(PAGE_SHIFT + RADIX_PTE_INDEX_SIZE)
+#define RADIX_PUD_SHIFT		(RADIX_PMD_SHIFT + RADIX_PMD_INDEX_SIZE)
+#define RADIX_PGD_SHIFT		(RADIX_PUD_SHIFT + RADIX_PUD_INDEX_SIZE)
 /*
  * Size of EA range mapped by our pagetables.
  */
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 4afbfbb64bfd..5d2328ef7958 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -450,3 +450,25 @@ void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int index)
 	return pgtable_free(table, index);
 }
 #endif
+
+#ifdef CONFIG_PROC_FS
+atomic_long_t direct_pages_count[MMU_PAGE_COUNT];
+
+void arch_report_meminfo(struct seq_file *m)
+{
+	/*
+	 * Hash maps the memory with one size mmu_linear_psize.
+	 * So don't bother to print these on hash
+	 */
+	if (!radix_enabled())
+		return;
+	seq_printf(m, "DirectMap4k:    %8lu kB\n",
+		   atomic_long_read(&direct_pages_count[MMU_PAGE_4K]) << 2);
+	seq_printf(m, "DirectMap64k:    %8lu kB\n",
+		   atomic_long_read(&direct_pages_count[MMU_PAGE_64K]) << 6);
+	seq_printf(m, "DirectMap2M:    %8lu kB\n",
+		   atomic_long_read(&direct_pages_count[MMU_PAGE_2M]) << 11);
+	seq_printf(m, "DirectMap1G:    %8lu kB\n",
+		   atomic_long_read(&direct_pages_count[MMU_PAGE_1G]) << 20);
+}
+#endif /* CONFIG_PROC_FS */
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index d9819e573103..5c5ca58e7d1f 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -259,6 +259,7 @@ static int __meminit create_physical_mapping(unsigned long start,
 					     unsigned long end,
 					     int nid)
 {
+	int mapping_shift;
 	unsigned long vaddr, addr, mapping_size = 0;
 	pgprot_t prot;
 #ifdef CONFIG_STRICT_KERNEL_RWX
@@ -277,18 +278,19 @@ static int __meminit create_physical_mapping(unsigned long start,
 
 		if (IS_ALIGNED(addr, PUD_SIZE) && gap >= PUD_SIZE &&
 		    mmu_psize_defs[MMU_PAGE_1G].shift)
-			mapping_size = PUD_SIZE;
+			mapping_shift = RADIX_PUD_SHIFT;
 		else if (IS_ALIGNED(addr, PMD_SIZE) && gap >= PMD_SIZE &&
 			 mmu_psize_defs[MMU_PAGE_2M].shift)
-			mapping_size = PMD_SIZE;
+			mapping_shift = RADIX_PMD_SHIFT;
 		else
-			mapping_size = PAGE_SIZE;
+			mapping_shift = PAGE_SHIFT;
 
-		if (split_text_mapping && (mapping_size != PAGE_SIZE) &&
+		if (split_text_mapping && (mapping_shift != PAGE_SHIFT) &&
 		    (addr <= __pa_symbol(__init_begin)) &&
 		    (addr + mapping_size) >= __pa_symbol(_stext))
-			mapping_size = PAGE_SIZE;
+			mapping_shift = PAGE_SHIFT;
 
+		mapping_size = (1UL << mapping_shift);
 		if (mapping_size != previous_size) {
 			print_mapping(start, addr, previous_size);
 			start = addr;
@@ -305,6 +307,7 @@ static int __meminit create_physical_mapping(unsigned long start,
 		rc = __map_kernel_page(vaddr, addr, prot, mapping_size, nid, start, end);
 		if (rc)
 			return rc;
+		update_page_count(mapping_shift, 1);
 	}
 
 	print_mapping(start, addr, mapping_size);
-- 
2.17.1
