Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJk6C4v4MzDqhq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 16:26:43 +1000 (AEST)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 31 May 2016 02:26:40 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 1/3] powerpc/mm/radix: Update LPCR only if it is powernv
Date: Tue, 31 May 2016 11:56:29 +0530
Message-Id: <1464675991-13023-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

LPCR cannot be updated when running in guest mode.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable-radix.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 18b2c11604fa..c939e6e57a9e 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -296,11 +296,6 @@ found:
 void __init radix__early_init_mmu(void)
 {
 	unsigned long lpcr;
-	/*
-	 * setup LPCR UPRT based on mmu_features
-	 */
-	lpcr = mfspr(SPRN_LPCR);
-	mtspr(SPRN_LPCR, lpcr | LPCR_UPRT);
 
 #ifdef CONFIG_PPC_64K_PAGES
 	/* PAGE_SIZE mappings */
@@ -343,8 +338,11 @@ void __init radix__early_init_mmu(void)
 	__pte_frag_size_shift = H_PTE_FRAG_SIZE_SHIFT;
 
 	radix_init_page_sizes();
-	if (!firmware_has_feature(FW_FEATURE_LPAR))
+	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
+		lpcr = mfspr(SPRN_LPCR);
+		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT);
 		radix_init_partition_table();
+	}
 
 	radix_init_pgtable();
 }
@@ -353,16 +351,15 @@ void radix__early_init_mmu_secondary(void)
 {
 	unsigned long lpcr;
 	/*
-	 * setup LPCR UPRT based on mmu_features
+	 * update partition table control register and UPRT
 	 */
-	lpcr = mfspr(SPRN_LPCR);
-	mtspr(SPRN_LPCR, lpcr | LPCR_UPRT);
-	/*
-	 * update partition table control register, 64 K size.
-	 */
-	if (!firmware_has_feature(FW_FEATURE_LPAR))
+	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
+		lpcr = mfspr(SPRN_LPCR);
+		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT);
+
 		mtspr(SPRN_PTCR,
 		      __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
+	}
 }
 
 void radix__setup_initial_memory_limit(phys_addr_t first_memblock_base,
-- 
2.7.4
