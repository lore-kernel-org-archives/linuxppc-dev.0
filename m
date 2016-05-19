Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9NdW5MgkzDqJ9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 17:54:55 +1000 (AEST)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 19 May 2016 13:24:52 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 43D2FE005B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:28:01 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4J7sliW58261690
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:24:47 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4J7sj9R031529
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:24:47 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 1/6] powerpc/mm/radix: Update LPCR only if it is powernv
Date: Thu, 19 May 2016 13:24:27 +0530
Message-Id: <1463644472-10158-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
