Return-Path: <bsingharora@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zXSzZ5V6TzF0Yd
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Feb 2018 05:18:34 +1100 (AEDT)
Received: by mail-pl0-x243.google.com with SMTP id ay8so4144278plb.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Feb 2018 10:18:34 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: david@gibson.dropbear.id.au, aneesh.kumar@linux.vnet.ibm.com,
 mpe@ellerman.id.au, Balbir Singh <bsingharora@gmail.com>
Subject: [RFC] powerpc/mm/pgtable: Split mappings on hot-unplug
Date: Thu,  1 Feb 2018 23:48:19 +0530
Message-Id: <20180201181819.5723-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch splits the a linear mapping if the hot-unplug range
is smaller than the mapping size. The code detects if the mapping
needs to be split into a smaller size and if so, uses the stop
machine infrastructure to map the current linear mapping with
a smaller size mapping. Then the requested area is unmapped.

A new API to do a local TLB flush is introduced and exported.
This API is used in stop mapping after clearing the larger
mapping and before creating the smaller mapping. There is also
a check to ensure that we don't overlap with kernel text
(the region that is being split) as it could cause the executing
text to fault.

There are some caveats with this approach, as the unmapping can
cause reserved memory area to be freed up (memblock reserved
mappings and allocations as well), that can be a problem. There
could be a case where radix__map_kernel_page() may fault if the
area selected to unmap contains the process page table, this is
not a new problem created by the patch, but something to watch
out for while testing. The right approach to solving the hot-unplug
issue is to make the node/DIMM to be marked hotpluggable so that
all the memory in that is movable. Currently there is no method
of enforcing the hotpluggable property via libvirt or qemu.

I've tested these changes under a kvm guest with 2 vcpus, from
a split mapping point of view, some of the caveats mentioned
above applied to the testing I did.

TODOs

1. In addition of checking overlapping text, we should check for
reserved memory allocations in the unmapped region
2. The code has duplication across several remove_*pgtable
(pgd/pud/pmd), we could create helper functions to simplify
the functionality.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |   1 +
 arch/powerpc/mm/pgtable-radix.c                    | 130 +++++++++++++++++----
 arch/powerpc/mm/tlb-radix.c                        |   6 +
 3 files changed, 116 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index 6a9e68003387..d1d4104e676d 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -20,6 +20,7 @@ extern void radix__flush_pmd_tlb_range(struct vm_area_struct *vma,
 extern void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			    unsigned long end);
 extern void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end);
+extern void radix__flush_tlb_local_kernel_range(unsigned long start, unsigned long end);
 
 extern void radix__local_flush_tlb_mm(struct mm_struct *mm);
 extern void radix__local_flush_all_mm(struct mm_struct *mm);
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index cfbbee941a76..10b6a1c433ff 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -17,6 +17,7 @@
 #include <linux/of_fdt.h>
 #include <linux/mm.h>
 #include <linux/string_helpers.h>
+#include <linux/stop_machine.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -671,6 +672,35 @@ static void free_pmd_table(pmd_t *pmd_start, pud_t *pud)
 	pud_clear(pud);
 }
 
+struct change_mapping_params {
+	pte_t *pte;
+	unsigned long start;
+	unsigned long end;
+	unsigned long size;
+	unsigned long aligned_start;
+	unsigned long aligned_end;
+};
+
+static int stop_machine_change_mapping(void *data)
+{
+	struct change_mapping_params *params =
+			(struct change_mapping_params *)data;
+	unsigned long addr;
+
+	if (!data)
+		return -1;
+
+	spin_unlock(&init_mm.page_table_lock);
+	pte_clear(&init_mm, params->aligned_start, params->pte);
+	radix__flush_tlb_local_kernel_range(params->aligned_start,
+						params->aligned_end);
+	for (addr = params->aligned_start; addr < params->aligned_end;
+			addr += params->size)
+		create_physical_mapping(addr, addr + params->size);
+	spin_lock(&init_mm.page_table_lock);
+	return 0;
+}
+
 static void remove_pte_table(pte_t *pte_start, unsigned long addr,
 			     unsigned long end)
 {
@@ -699,12 +729,65 @@ static void remove_pte_table(pte_t *pte_start, unsigned long addr,
 	}
 }
 
+/*
+ * clear the pte and potentially split the mapping helper
+ * Return values are as follows
+ *
+ * 0: pte cleared, no changes required
+ * 1: pte cleared and mapping split
+ * -1: We can't clear this pte range
+ */
+static int clear_and_maybe_split_kernel_mapping(unsigned long addr,
+		unsigned long end, unsigned long size, unsigned long prev_size,
+		pte_t *pte)
+{
+	unsigned long mask = ~(size - 1);
+	unsigned long aligned_start = addr & mask;
+	unsigned long aligned_end = addr + size;
+	struct change_mapping_params params;
+	bool split_region = false;
+
+	if ((end - addr) < size) {
+		/*
+		 * We're going to clear the PTE, but not flushed
+		 * the mapping, time to remap and flush. The
+		 * effects if visible outside the processor or
+		 * if we are running in code close to the
+		 * mapping we cleared, we are in trouble.
+		 */
+		if (overlaps_kernel_text(aligned_start, addr) ||
+			overlaps_kernel_text(end, aligned_end)) {
+			/*
+			 * Hack, just return, don't pte_clear
+			 */
+			return -1;
+		}
+		split_region = true;
+	}
+
+	if (split_region) {
+		params.pte = pte;
+		params.start = addr;
+		params.end = end;
+		params.size = prev_size;
+		params.aligned_end = aligned_end;
+		params.aligned_end = min_t(unsigned long, aligned_end,
+				(unsigned long)__va(memblock_end_of_DRAM()));
+		stop_machine(stop_machine_change_mapping, &params, NULL);
+		return 1;
+	}
+
+	pte_clear(&init_mm, addr, pte);
+	return 0;
+}
+
 static void remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
 			     unsigned long end)
 {
 	unsigned long next;
 	pte_t *pte_base;
 	pmd_t *pmd;
+	int rc = 0;
 
 	pmd = pmd_start + pmd_index(addr);
 	for (; addr < end; addr = next, pmd++) {
@@ -714,14 +797,15 @@ static void remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
 			continue;
 
 		if (pmd_huge(*pmd)) {
-			if (!IS_ALIGNED(addr, PMD_SIZE) ||
-			    !IS_ALIGNED(next, PMD_SIZE)) {
-				WARN_ONCE(1, "%s: unaligned range\n", __func__);
+			rc = clear_and_maybe_split_kernel_mapping(addr, end,
+				PMD_SIZE, PAGE_SIZE, (pte_t *)pmd);
+			if (rc == 0)
 				continue;
-			}
-
-			pte_clear(&init_mm, addr, (pte_t *)pmd);
-			continue;
+			if (rc == 1) {
+				pte_base = (pte_t *)pmd_page_vaddr(*pmd);
+				remove_pte_table(pte_base, addr, end);
+			} else
+				return;
 		}
 
 		pte_base = (pte_t *)pmd_page_vaddr(*pmd);
@@ -736,6 +820,7 @@ static void remove_pud_table(pud_t *pud_start, unsigned long addr,
 	unsigned long next;
 	pmd_t *pmd_base;
 	pud_t *pud;
+	int rc = 0;
 
 	pud = pud_start + pud_index(addr);
 	for (; addr < end; addr = next, pud++) {
@@ -745,14 +830,15 @@ static void remove_pud_table(pud_t *pud_start, unsigned long addr,
 			continue;
 
 		if (pud_huge(*pud)) {
-			if (!IS_ALIGNED(addr, PUD_SIZE) ||
-			    !IS_ALIGNED(next, PUD_SIZE)) {
-				WARN_ONCE(1, "%s: unaligned range\n", __func__);
+			rc = clear_and_maybe_split_kernel_mapping(addr, end,
+				PUD_SIZE, PMD_SIZE, (pte_t *)pud);
+			if (rc == 0)
 				continue;
-			}
-
-			pte_clear(&init_mm, addr, (pte_t *)pud);
-			continue;
+			if (rc == 1) {
+				pmd_base = (pmd_t *)pud_page_vaddr(*pud);
+				remove_pmd_table(pmd_base, addr, end);
+			} else
+				return;
 		}
 
 		pmd_base = (pmd_t *)pud_page_vaddr(*pud);
@@ -766,6 +852,7 @@ static void remove_pagetable(unsigned long start, unsigned long end)
 	unsigned long addr, next;
 	pud_t *pud_base;
 	pgd_t *pgd;
+	int rc = 0;
 
 	spin_lock(&init_mm.page_table_lock);
 
@@ -777,14 +864,15 @@ static void remove_pagetable(unsigned long start, unsigned long end)
 			continue;
 
 		if (pgd_huge(*pgd)) {
-			if (!IS_ALIGNED(addr, PGDIR_SIZE) ||
-			    !IS_ALIGNED(next, PGDIR_SIZE)) {
-				WARN_ONCE(1, "%s: unaligned range\n", __func__);
+			rc = clear_and_maybe_split_kernel_mapping(addr, end,
+				PGD_SIZE, PUD_SIZE, (pte_t *)pgd);
+			if (rc == 0)
 				continue;
-			}
-
-			pte_clear(&init_mm, addr, (pte_t *)pgd);
-			continue;
+			if (rc == 1) {
+				pud_base = (pud_t *)pgd_page_vaddr(*pgd);
+				remove_pud_table(pud_base, addr, end);
+			} else
+				return;
 		}
 
 		pud_base = (pud_t *)pgd_page_vaddr(*pgd);
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 884f4b705b57..9bbeaef1ee9b 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -323,6 +323,12 @@ void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end)
 }
 EXPORT_SYMBOL(radix__flush_tlb_kernel_range);
 
+void radix__flush_tlb_local_kernel_range(unsigned long start, unsigned long end)
+{
+	_tlbie_pid(0, RIC_FLUSH_ALL);
+}
+EXPORT_SYMBOL(radix__flush_tlb_local_kernel_range);
+
 #define TLB_FLUSH_ALL -1UL
 
 /*
-- 
2.13.6
