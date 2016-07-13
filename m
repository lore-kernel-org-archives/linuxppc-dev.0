Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqDGv6yfhzDqLD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 19:36:07 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D9YEoJ039980
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:36:05 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24567cnuyd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:36:05 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 03:36:04 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH for-4.8 06/12] powerpc/mm: Print formation regarding the the
 MMU mode
Date: Wed, 13 Jul 2016 15:05:25 +0530
In-Reply-To: <1468402531-4914-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1468402531-4914-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1468402531-4914-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index 7e6d38e01645..b90fe2480089 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -739,7 +739,7 @@ static void __init hash_init_partition_table(phys_addr_t hash_table,
 	 * For now UPRT is 0 for us.
 	 */
 	partition_tb->patb1 = 0;
-	DBG("Partition table %p\n", partition_tb);
+	pr_info("Partition table %p\n", partition_tb);
 	/*
 	 * update partition table control register,
 	 * 64 K size.
@@ -943,6 +943,7 @@ void __init hash__early_init_mmu(void)
 	 */
 	htab_initialize();
 
+	pr_info("Initializing hash mmu with SLB\n");
 	/* Initialize SLB management */
 	slb_initialize();
 }
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index f8a3bec315f7..366d1ea24465 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -182,7 +182,8 @@ static void __init radix_init_partition_table(void)
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
