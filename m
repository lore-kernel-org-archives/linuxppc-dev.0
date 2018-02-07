Return-Path: <bsingharora@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zbs6F1BySzF11y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Feb 2018 17:36:05 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id f4so2871003plr.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Feb 2018 22:36:04 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mm/pgtable: Split mappings on hot-unplug
Date: Wed,  7 Feb 2018 17:35:51 +1100
Message-Id: <20180207063551.8991-1-bsingharora@gmail.com>
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

The code will skip any region of the mapping that overlaps with
kernel text and warn about it once. We don't want to remove
a mapping where the kernel text and the LMB we intend to remove
overlap in the same TLB mapping as it may affect the currently
executing code (being cautious, we might be able to remove this
restriction later, see TODOs below)

I've tested these changes under a kvm guest with 2 vcpus, from
a split mapping point of view, some of the caveats mentioned
above applied to the testing I did.

TODOs:
1. Refine the stop machine with an atomic replacement of the
PMD. The code needs to be refactored to support those changes.
I intend to publish those changes, but this is a minimal set
that should be also probably backported to stable

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---


Changelog
  - Refactored the code based on suggestions from mpe
  - Removed the local tlb flush
  - Skip creating mappings for region to be removed
    and then removing the region, let create_physical_mapping
    deal with that complexity (it already has the code)

 arch/powerpc/mm/pgtable-radix.c | 95 ++++++++++++++++++++++++++++++++---------
 1 file changed, 74 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index cfbbee941a76..17ae5c15a9e0 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -17,6 +17,7 @@
 #include <linux/of_fdt.h>
 #include <linux/mm.h>
 #include <linux/string_helpers.h>
+#include <linux/stop_machine.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -671,6 +672,30 @@ static void free_pmd_table(pmd_t *pmd_start, pud_t *pud)
 	pud_clear(pud);
 }
 
+struct change_mapping_params {
+	pte_t *pte;
+	unsigned long start;
+	unsigned long end;
+	unsigned long aligned_start;
+	unsigned long aligned_end;
+};
+
+static int stop_machine_change_mapping(void *data)
+{
+	struct change_mapping_params *params =
+			(struct change_mapping_params *)data;
+
+	if (!data)
+		return -1;
+
+	spin_unlock(&init_mm.page_table_lock);
+	pte_clear(&init_mm, params->aligned_start, params->pte);
+	create_physical_mapping(params->aligned_start, params->start);
+	create_physical_mapping(params->end, params->aligned_end);
+	spin_lock(&init_mm.page_table_lock);
+	return 0;
+}
+
 static void remove_pte_table(pte_t *pte_start, unsigned long addr,
 			     unsigned long end)
 {
@@ -699,6 +724,52 @@ static void remove_pte_table(pte_t *pte_start, unsigned long addr,
 	}
 }
 
+/*
+ * clear the pte and potentially split the mapping helper
+ */
+static void split_kernel_mapping(unsigned long addr, unsigned long end,
+				unsigned long size, pte_t *pte)
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
+			WARN_ONCE(1, "Linear mapping %lx->%lx overlaps kernel "
+				  "text, not splitting\n", addr, end);
+			return;
+		}
+		split_region = true;
+	}
+
+	if (split_region) {
+		params.pte = pte;
+		params.start = addr;
+		params.end = end;
+		params.aligned_start = addr & ~(size - 1);
+		params.aligned_end = min_t(unsigned long, aligned_end,
+				(unsigned long)__va(memblock_end_of_DRAM()));
+		stop_machine(stop_machine_change_mapping, &params, NULL);
+		return;
+	}
+
+	pte_clear(&init_mm, addr, pte);
+}
+
 static void remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
 			     unsigned long end)
 {
@@ -714,13 +785,7 @@ static void remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
 			continue;
 
 		if (pmd_huge(*pmd)) {
-			if (!IS_ALIGNED(addr, PMD_SIZE) ||
-			    !IS_ALIGNED(next, PMD_SIZE)) {
-				WARN_ONCE(1, "%s: unaligned range\n", __func__);
-				continue;
-			}
-
-			pte_clear(&init_mm, addr, (pte_t *)pmd);
+			split_kernel_mapping(addr, end, PMD_SIZE, (pte_t *)pmd);
 			continue;
 		}
 
@@ -745,13 +810,7 @@ static void remove_pud_table(pud_t *pud_start, unsigned long addr,
 			continue;
 
 		if (pud_huge(*pud)) {
-			if (!IS_ALIGNED(addr, PUD_SIZE) ||
-			    !IS_ALIGNED(next, PUD_SIZE)) {
-				WARN_ONCE(1, "%s: unaligned range\n", __func__);
-				continue;
-			}
-
-			pte_clear(&init_mm, addr, (pte_t *)pud);
+			split_kernel_mapping(addr, end, PUD_SIZE, (pte_t *)pud);
 			continue;
 		}
 
@@ -777,13 +836,7 @@ static void remove_pagetable(unsigned long start, unsigned long end)
 			continue;
 
 		if (pgd_huge(*pgd)) {
-			if (!IS_ALIGNED(addr, PGDIR_SIZE) ||
-			    !IS_ALIGNED(next, PGDIR_SIZE)) {
-				WARN_ONCE(1, "%s: unaligned range\n", __func__);
-				continue;
-			}
-
-			pte_clear(&init_mm, addr, (pte_t *)pgd);
+			split_kernel_mapping(addr, end, PGDIR_SIZE, (pte_t *)pgd);
 			continue;
 		}
 
-- 
2.13.6
