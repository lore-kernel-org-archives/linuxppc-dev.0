Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPrNf44lTzDr2m
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 00:26:58 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 10:26:56 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 09/10] powerpc/mm: Print formation regarding the the MMU
 mode
Date: Wed,  8 Jun 2016 19:55:57 +0530
Message-Id: <1465395958-21349-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1465395958-21349-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465395958-21349-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This helps in easily identifying the MMU mode with which the kernel
is operating.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c | 3 ++-
 arch/powerpc/mm/pgtable-radix.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index b2740c67e172..bf9b0b80bbfc 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -720,7 +720,7 @@ static void __init hash_init_partition_table(phys_addr_t hash_table,
 	 * For now UPRT is 0 for us.
 	 */
 	partition_tb->patb1 = 0;
-	DBG("Partition table %p\n", partition_tb);
+	pr_info("Partition table %p\n", partition_tb);
 	/*
 	 * update partition table control register,
 	 * 64 K size.
@@ -924,6 +924,7 @@ void __init hash__early_init_mmu(void)
 	 */
 	htab_initialize();
 
+	pr_info("Initializing hash mmu with SLB\n");
 	/* Initialize SLB management */
 	slb_initialize();
 }
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 73aa402047ef..d6598cd1c3e6 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -185,7 +185,8 @@ static void __init radix_init_partition_table(void)
 	partition_tb = early_alloc_pgtable(1UL << PATB_SIZE_SHIFT);
 	partition_tb->patb0 = cpu_to_be64(rts_field | __pa(init_mm.pgd) |
 					  RADIX_PGD_INDEX_SIZE | PATB_HR);
-	printk("Partition table %p\n", partition_tb);
+	pr_info("Initializing Radix MMU\n");
+	pr_info("Partition table %p\n", partition_tb);
 
 	memblock_set_current_limit(MEMBLOCK_ALLOC_ANYWHERE);
 	/*
-- 
2.7.4
