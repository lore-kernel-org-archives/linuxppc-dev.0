Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41pl7B2c6LzDr5t
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 15:45:09 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7D5i9Ke178660
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 01:45:07 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ku1cf4u5g-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 01:45:07 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 13 Aug 2018 01:45:06 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V2] powerpc/mm/book3s/radix: Add mapping statistics
Date: Mon, 13 Aug 2018 11:14:57 +0530
Message-Id: <20180813054457.13241-1-aneesh.kumar@linux.ibm.com>
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
Changes from V1:
 * updates from mpe to simplify the create_physical_mapping changes
 * Drop the dependency on patch that removed retry loop changes in
   the same function.

 arch/powerpc/include/asm/book3s/64/pgalloc.h |  7 +++++++
 arch/powerpc/include/asm/book3s/64/radix.h   |  3 +++
 arch/powerpc/mm/pgtable-book3s64.c           | 22 ++++++++++++++++++++
 arch/powerpc/mm/pgtable-radix.c              | 19 ++++++++++++-----
 4 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 76234a14b97d..391ed2c3b697 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -227,4 +227,11 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 
 #define check_pgt_cache()	do { } while (0)
 
+extern atomic_long_t direct_pages_count[MMU_PAGE_COUNT];
+static inline void update_page_count(int psize, long count)
+{
+	if (IS_ENABLED(CONFIG_PROC_FS))
+		atomic_long_add(count, &direct_pages_count[psize]);
+}
+
 #endif /* _ASM_POWERPC_BOOK3S_64_PGALLOC_H */
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 77440e837869..7d1a3d1543fc 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -32,6 +32,9 @@
 #define RADIX_PUD_BAD_BITS		0x60000000000000e0UL
 #define RADIX_PGD_BAD_BITS		0x60000000000000e0UL
 
+#define RADIX_PMD_SHIFT		(PAGE_SHIFT + RADIX_PTE_INDEX_SIZE)
+#define RADIX_PUD_SHIFT		(RADIX_PMD_SHIFT + RADIX_PMD_INDEX_SIZE)
+#define RADIX_PGD_SHIFT		(RADIX_PUD_SHIFT + RADIX_PUD_INDEX_SIZE)
 /*
  * Size of EA range mapped by our pagetables.
  */
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 78d0b3d5ebad..01d7c0f7c4f0 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -455,3 +455,25 @@ void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int index)
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
index bba168d02235..7be99fd9af15 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -267,6 +267,7 @@ static int __meminit create_physical_mapping(unsigned long start,
 #else
 	int split_text_mapping = 0;
 #endif
+	int psize;
 
 	start = _ALIGN_UP(start, PAGE_SIZE);
 	for (addr = start; addr < end; addr += mapping_size) {
@@ -280,13 +281,17 @@ static int __meminit create_physical_mapping(unsigned long start,
 retry:
 		if (IS_ALIGNED(addr, PUD_SIZE) && gap >= PUD_SIZE &&
 		    mmu_psize_defs[MMU_PAGE_1G].shift &&
-		    PUD_SIZE <= max_mapping_size)
+		    PUD_SIZE <= max_mapping_size) {
 			mapping_size = PUD_SIZE;
-		else if (IS_ALIGNED(addr, PMD_SIZE) && gap >= PMD_SIZE &&
-			 mmu_psize_defs[MMU_PAGE_2M].shift)
+			psize = MMU_PAGE_1G;
+		} else if (IS_ALIGNED(addr, PMD_SIZE) && gap >= PMD_SIZE &&
+			   mmu_psize_defs[MMU_PAGE_2M].shift) {
 			mapping_size = PMD_SIZE;
-		else
+			psize = MMU_PAGE_2M;
+		} else {
 			mapping_size = PAGE_SIZE;
+			psize = mmu_virtual_psize;
+		}
 
 		if (split_text_mapping && (mapping_size == PUD_SIZE) &&
 			(addr <= __pa_symbol(__init_begin)) &&
@@ -297,8 +302,10 @@ static int __meminit create_physical_mapping(unsigned long start,
 
 		if (split_text_mapping && (mapping_size == PMD_SIZE) &&
 		    (addr <= __pa_symbol(__init_begin)) &&
-		    (addr + mapping_size) >= __pa_symbol(_stext))
+		    (addr + mapping_size) >= __pa_symbol(_stext)) {
 			mapping_size = PAGE_SIZE;
+			psize = mmu_virtual_psize;
+		}
 
 		if (mapping_size != previous_size) {
 			print_mapping(start, addr, previous_size);
@@ -316,6 +323,8 @@ static int __meminit create_physical_mapping(unsigned long start,
 		rc = __map_kernel_page(vaddr, addr, prot, mapping_size, nid, start, end);
 		if (rc)
 			return rc;
+
+		update_page_count(psize, 1);
 	}
 
 	print_mapping(start, addr, mapping_size);
-- 
2.17.1
