Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgmCf0KtCzF1PM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 02:09:18 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id o1so44737pgn.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 07:09:17 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 13/14] powerpc/64s/radix: split early page table mapping to
 its own function
Date: Wed, 14 Feb 2018 01:08:23 +1000
Message-Id: <20180213150824.27689-14-npiggin@gmail.com>
In-Reply-To: <20180213150824.27689-1-npiggin@gmail.com>
References: <20180213150824.27689-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/pgtable-radix.c | 114 +++++++++++++++++++++++-----------------
 1 file changed, 66 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 435b19e74508..4c5cc69c92c2 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -58,6 +58,50 @@ static __ref void *early_alloc_pgtable(unsigned long size)
 	return pt;
 }
 
+static int early_map_kernel_page(unsigned long ea, unsigned long pa,
+			  pgprot_t flags,
+			  unsigned int map_page_size)
+{
+	pgd_t *pgdp;
+	pud_t *pudp;
+	pmd_t *pmdp;
+	pte_t *ptep;
+
+	pgdp = pgd_offset_k(ea);
+	if (pgd_none(*pgdp)) {
+		pudp = early_alloc_pgtable(PUD_TABLE_SIZE);
+		BUG_ON(pudp == NULL);
+		pgd_populate(&init_mm, pgdp, pudp);
+	}
+	pudp = pud_offset(pgdp, ea);
+	if (map_page_size == PUD_SIZE) {
+		ptep = (pte_t *)pudp;
+		goto set_the_pte;
+	}
+	if (pud_none(*pudp)) {
+		pmdp = early_alloc_pgtable(PMD_TABLE_SIZE);
+		BUG_ON(pmdp == NULL);
+		pud_populate(&init_mm, pudp, pmdp);
+	}
+	pmdp = pmd_offset(pudp, ea);
+	if (map_page_size == PMD_SIZE) {
+		ptep = pmdp_ptep(pmdp);
+		goto set_the_pte;
+	}
+	if (!pmd_present(*pmdp)) {
+		ptep = early_alloc_pgtable(PAGE_SIZE);
+		BUG_ON(ptep == NULL);
+		pmd_populate_kernel(&init_mm, pmdp, ptep);
+	}
+	ptep = pte_offset_kernel(pmdp, ea);
+
+set_the_pte:
+	set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT, flags));
+	smp_wmb();
+	return 0;
+}
+
+
 int radix__map_kernel_page(unsigned long ea, unsigned long pa,
 			  pgprot_t flags,
 			  unsigned int map_page_size)
@@ -70,54 +114,28 @@ int radix__map_kernel_page(unsigned long ea, unsigned long pa,
 	 * Make sure task size is correct as per the max adddr
 	 */
 	BUILD_BUG_ON(TASK_SIZE_USER64 > RADIX_PGTABLE_RANGE);
-	if (slab_is_available()) {
-		pgdp = pgd_offset_k(ea);
-		pudp = pud_alloc(&init_mm, pgdp, ea);
-		if (!pudp)
-			return -ENOMEM;
-		if (map_page_size == PUD_SIZE) {
-			ptep = (pte_t *)pudp;
-			goto set_the_pte;
-		}
-		pmdp = pmd_alloc(&init_mm, pudp, ea);
-		if (!pmdp)
-			return -ENOMEM;
-		if (map_page_size == PMD_SIZE) {
-			ptep = pmdp_ptep(pmdp);
-			goto set_the_pte;
-		}
-		ptep = pte_alloc_kernel(pmdp, ea);
-		if (!ptep)
-			return -ENOMEM;
-	} else {
-		pgdp = pgd_offset_k(ea);
-		if (pgd_none(*pgdp)) {
-			pudp = early_alloc_pgtable(PUD_TABLE_SIZE);
-			BUG_ON(pudp == NULL);
-			pgd_populate(&init_mm, pgdp, pudp);
-		}
-		pudp = pud_offset(pgdp, ea);
-		if (map_page_size == PUD_SIZE) {
-			ptep = (pte_t *)pudp;
-			goto set_the_pte;
-		}
-		if (pud_none(*pudp)) {
-			pmdp = early_alloc_pgtable(PMD_TABLE_SIZE);
-			BUG_ON(pmdp == NULL);
-			pud_populate(&init_mm, pudp, pmdp);
-		}
-		pmdp = pmd_offset(pudp, ea);
-		if (map_page_size == PMD_SIZE) {
-			ptep = pmdp_ptep(pmdp);
-			goto set_the_pte;
-		}
-		if (!pmd_present(*pmdp)) {
-			ptep = early_alloc_pgtable(PAGE_SIZE);
-			BUG_ON(ptep == NULL);
-			pmd_populate_kernel(&init_mm, pmdp, ptep);
-		}
-		ptep = pte_offset_kernel(pmdp, ea);
+
+	if (!slab_is_available())
+		return early_map_kernel_page(ea, pa, flags, map_page_size);
+
+	pgdp = pgd_offset_k(ea);
+	pudp = pud_alloc(&init_mm, pgdp, ea);
+	if (!pudp)
+		return -ENOMEM;
+	if (map_page_size == PUD_SIZE) {
+		ptep = (pte_t *)pudp;
+		goto set_the_pte;
+	}
+	pmdp = pmd_alloc(&init_mm, pudp, ea);
+	if (!pmdp)
+		return -ENOMEM;
+	if (map_page_size == PMD_SIZE) {
+		ptep = pmdp_ptep(pmdp);
+		goto set_the_pte;
 	}
+	ptep = pte_alloc_kernel(pmdp, ea);
+	if (!ptep)
+		return -ENOMEM;
 
 set_the_pte:
 	set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT, flags));
@@ -864,7 +882,7 @@ static void remove_pagetable(unsigned long start, unsigned long end)
 
 int __ref radix__create_section_mapping(unsigned long start, unsigned long end, int nid)
 {
-	return create_physical_mapping(start, end, nid);
+	return create_physical_mapping(start, end);
 }
 
 int radix__remove_section_mapping(unsigned long start, unsigned long end)
-- 
2.16.1
