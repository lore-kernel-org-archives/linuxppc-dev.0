Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40PmMT73zQzF1sY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 21:27:48 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3GBNbwT030389
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:27:46 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hct2t2g96-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:27:46 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 16 Apr 2018 07:27:45 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V1 01/11] powerpc/mm/book3s64: Move book3s64 code to
 pgtable-book3s64
Date: Mon, 16 Apr 2018 16:57:14 +0530
In-Reply-To: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
References: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180416112724.9677-3-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Only code movement and avoid #ifdef.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable-book3s64.c | 54 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/pgtable_64.c       | 56 --------------------------------------
 2 files changed, 54 insertions(+), 56 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 518518fb7c45..35913b0b6d56 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -9,10 +9,13 @@
 
 #include <linux/sched.h>
 #include <linux/mm_types.h>
+#include <linux/memblock.h>
 #include <misc/cxl-base.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
+#include <asm/trace.h>
+#include <asm/powernv.h>
 
 #include "mmu_decl.h"
 #include <trace/events/thp.h>
@@ -171,3 +174,54 @@ int __meminit remove_section_mapping(unsigned long start, unsigned long end)
 	return hash__remove_section_mapping(start, end);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
+
+void __init mmu_partition_table_init(void)
+{
+	unsigned long patb_size = 1UL << PATB_SIZE_SHIFT;
+	unsigned long ptcr;
+
+	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 36), "Partition table size too large.");
+	partition_tb = __va(memblock_alloc_base(patb_size, patb_size,
+						MEMBLOCK_ALLOC_ANYWHERE));
+
+	/* Initialize the Partition Table with no entries */
+	memset((void *)partition_tb, 0, patb_size);
+
+	/*
+	 * update partition table control register,
+	 * 64 K size.
+	 */
+	ptcr = __pa(partition_tb) | (PATB_SIZE_SHIFT - 12);
+	mtspr(SPRN_PTCR, ptcr);
+	powernv_set_nmmu_ptcr(ptcr);
+}
+
+void mmu_partition_table_set_entry(unsigned int lpid, unsigned long dw0,
+				   unsigned long dw1)
+{
+	unsigned long old = be64_to_cpu(partition_tb[lpid].patb0);
+
+	partition_tb[lpid].patb0 = cpu_to_be64(dw0);
+	partition_tb[lpid].patb1 = cpu_to_be64(dw1);
+
+	/*
+	 * Global flush of TLBs and partition table caches for this lpid.
+	 * The type of flush (hash or radix) depends on what the previous
+	 * use of this partition ID was, not the new use.
+	 */
+	asm volatile("ptesync" : : : "memory");
+	if (old & PATB_HR) {
+		asm volatile(PPC_TLBIE_5(%0,%1,2,0,1) : :
+			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
+		asm volatile(PPC_TLBIE_5(%0,%1,2,1,1) : :
+			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
+		trace_tlbie(lpid, 0, TLBIEL_INVAL_SET_LPID, lpid, 2, 0, 1);
+	} else {
+		asm volatile(PPC_TLBIE_5(%0,%1,2,0,0) : :
+			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
+		trace_tlbie(lpid, 0, TLBIEL_INVAL_SET_LPID, lpid, 2, 0, 0);
+	}
+	/* do we need fixup here ?*/
+	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
+}
+EXPORT_SYMBOL_GPL(mmu_partition_table_set_entry);
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 9bf659d5078c..a41784dd2042 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -33,7 +33,6 @@
 #include <linux/swap.h>
 #include <linux/stddef.h>
 #include <linux/vmalloc.h>
-#include <linux/memblock.h>
 #include <linux/slab.h>
 #include <linux/hugetlb.h>
 
@@ -47,13 +46,11 @@
 #include <asm/smp.h>
 #include <asm/machdep.h>
 #include <asm/tlb.h>
-#include <asm/trace.h>
 #include <asm/processor.h>
 #include <asm/cputable.h>
 #include <asm/sections.h>
 #include <asm/firmware.h>
 #include <asm/dma.h>
-#include <asm/powernv.h>
 
 #include "mmu_decl.h"
 
@@ -429,59 +426,6 @@ void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
 }
 #endif
 
-#ifdef CONFIG_PPC_BOOK3S_64
-void __init mmu_partition_table_init(void)
-{
-	unsigned long patb_size = 1UL << PATB_SIZE_SHIFT;
-	unsigned long ptcr;
-
-	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 36), "Partition table size too large.");
-	partition_tb = __va(memblock_alloc_base(patb_size, patb_size,
-						MEMBLOCK_ALLOC_ANYWHERE));
-
-	/* Initialize the Partition Table with no entries */
-	memset((void *)partition_tb, 0, patb_size);
-
-	/*
-	 * update partition table control register,
-	 * 64 K size.
-	 */
-	ptcr = __pa(partition_tb) | (PATB_SIZE_SHIFT - 12);
-	mtspr(SPRN_PTCR, ptcr);
-	powernv_set_nmmu_ptcr(ptcr);
-}
-
-void mmu_partition_table_set_entry(unsigned int lpid, unsigned long dw0,
-				   unsigned long dw1)
-{
-	unsigned long old = be64_to_cpu(partition_tb[lpid].patb0);
-
-	partition_tb[lpid].patb0 = cpu_to_be64(dw0);
-	partition_tb[lpid].patb1 = cpu_to_be64(dw1);
-
-	/*
-	 * Global flush of TLBs and partition table caches for this lpid.
-	 * The type of flush (hash or radix) depends on what the previous
-	 * use of this partition ID was, not the new use.
-	 */
-	asm volatile("ptesync" : : : "memory");
-	if (old & PATB_HR) {
-		asm volatile(PPC_TLBIE_5(%0,%1,2,0,1) : :
-			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
-		asm volatile(PPC_TLBIE_5(%0,%1,2,1,1) : :
-			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
-		trace_tlbie(lpid, 0, TLBIEL_INVAL_SET_LPID, lpid, 2, 0, 1);
-	} else {
-		asm volatile(PPC_TLBIE_5(%0,%1,2,0,0) : :
-			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
-		trace_tlbie(lpid, 0, TLBIEL_INVAL_SET_LPID, lpid, 2, 0, 0);
-	}
-	/* do we need fixup here ?*/
-	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
-}
-EXPORT_SYMBOL_GPL(mmu_partition_table_set_entry);
-#endif /* CONFIG_PPC_BOOK3S_64 */
-
 #ifdef CONFIG_STRICT_KERNEL_RWX
 void mark_rodata_ro(void)
 {
-- 
2.14.3
