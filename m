Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 459F41A087B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 17:26:39 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/mm: Unindent htab_dt_scan_page_sizes()
Date: Thu,  7 Aug 2014 17:26:33 +1000
Message-Id: <1407396393-29446-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can unindent the bulk of htab_dt_scan_page_sizes() by returning early
if the property is not found. That is nice in and of itself, but also
has the advantage of making it clear that we always return success once
we have found the ibm,segment-page-sizes property.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/hash_utils_64.c | 121 ++++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 61 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 6b7c1c824cf9..8fccc71d472f 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -333,70 +333,69 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
 		return 0;
 
 	prop = of_get_flat_dt_prop(node, "ibm,segment-page-sizes", &size);
-	if (prop != NULL) {
-		pr_info("Page sizes from device-tree:\n");
-		size /= 4;
-		cur_cpu_spec->mmu_features &= ~(MMU_FTR_16M_PAGE);
-		while(size > 0) {
-			unsigned int base_shift = be32_to_cpu(prop[0]);
-			unsigned int slbenc = be32_to_cpu(prop[1]);
-			unsigned int lpnum = be32_to_cpu(prop[2]);
-			struct mmu_psize_def *def;
-			int idx, base_idx;
-
-			size -= 3; prop += 3;
-			base_idx = get_idx_from_shift(base_shift);
-			if (base_idx < 0) {
-				/*
-				 * skip the pte encoding also
-				 */
-				prop += lpnum * 2; size -= lpnum * 2;
+	if (!prop)
+		return 0;
+
+	pr_info("Page sizes from device-tree:\n");
+	size /= 4;
+	cur_cpu_spec->mmu_features &= ~(MMU_FTR_16M_PAGE);
+	while(size > 0) {
+		unsigned int base_shift = be32_to_cpu(prop[0]);
+		unsigned int slbenc = be32_to_cpu(prop[1]);
+		unsigned int lpnum = be32_to_cpu(prop[2]);
+		struct mmu_psize_def *def;
+		int idx, base_idx;
+
+		size -= 3; prop += 3;
+		base_idx = get_idx_from_shift(base_shift);
+		if (base_idx < 0) {
+			/* skip the pte encoding also */
+			prop += lpnum * 2; size -= lpnum * 2;
+			continue;
+		}
+		def = &mmu_psize_defs[base_idx];
+		if (base_idx == MMU_PAGE_16M)
+			cur_cpu_spec->mmu_features |= MMU_FTR_16M_PAGE;
+
+		def->shift = base_shift;
+		if (base_shift <= 23)
+			def->avpnm = 0;
+		else
+			def->avpnm = (1 << (base_shift - 23)) - 1;
+		def->sllp = slbenc;
+		/*
+		 * We don't know for sure what's up with tlbiel, so
+		 * for now we only set it for 4K and 64K pages
+		 */
+		if (base_idx == MMU_PAGE_4K || base_idx == MMU_PAGE_64K)
+			def->tlbiel = 1;
+		else
+			def->tlbiel = 0;
+
+		while (size > 0 && lpnum) {
+			unsigned int shift = be32_to_cpu(prop[0]);
+			int penc  = be32_to_cpu(prop[1]);
+
+			prop += 2; size -= 2;
+			lpnum--;
+
+			idx = get_idx_from_shift(shift);
+			if (idx < 0)
 				continue;
-			}
-			def = &mmu_psize_defs[base_idx];
-			if (base_idx == MMU_PAGE_16M)
-				cur_cpu_spec->mmu_features |= MMU_FTR_16M_PAGE;
-
-			def->shift = base_shift;
-			if (base_shift <= 23)
-				def->avpnm = 0;
-			else
-				def->avpnm = (1 << (base_shift - 23)) - 1;
-			def->sllp = slbenc;
-			/*
-			 * We don't know for sure what's up with tlbiel, so
-			 * for now we only set it for 4K and 64K pages
-			 */
-			if (base_idx == MMU_PAGE_4K || base_idx == MMU_PAGE_64K)
-				def->tlbiel = 1;
-			else
-				def->tlbiel = 0;
-
-			while (size > 0 && lpnum) {
-				unsigned int shift = be32_to_cpu(prop[0]);
-				int penc  = be32_to_cpu(prop[1]);
-
-				prop += 2; size -= 2;
-				lpnum--;
-
-				idx = get_idx_from_shift(shift);
-				if (idx < 0)
-					continue;
-
-				if (penc == -1)
-					pr_err("Invalid penc for base_shift=%d "
-					       "shift=%d\n", base_shift, shift);
-
-				def->penc[idx] = penc;
-				pr_info("base_shift=%d: shift=%d, sllp=0x%04lx,"
-					" avpnm=0x%08lx, tlbiel=%d, penc=%d\n",
-					base_shift, shift, def->sllp,
-					def->avpnm, def->tlbiel, def->penc[idx]);
-			}
+
+			if (penc == -1)
+				pr_err("Invalid penc for base_shift=%d "
+				       "shift=%d\n", base_shift, shift);
+
+			def->penc[idx] = penc;
+			pr_info("base_shift=%d: shift=%d, sllp=0x%04lx,"
+				" avpnm=0x%08lx, tlbiel=%d, penc=%d\n",
+				base_shift, shift, def->sllp,
+				def->avpnm, def->tlbiel, def->penc[idx]);
 		}
-		return 1;
 	}
-	return 0;
+
+	return 1;
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
-- 
1.9.1
