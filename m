Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqDGy5JS3zDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 19:36:10 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D9YdNg039394
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:36:08 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24507bvd3t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:36:08 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 03:36:07 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH for-4.8 07/12] powerpc/mm/hash: Update SDR1 size encoding as
 documented in ISA 3.0
Date: Wed, 13 Jul 2016 15:05:26 +0530
In-Reply-To: <1468402531-4914-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1468402531-4914-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1468402531-4914-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ISA 3.0 document hash table size in bytes = 2^(HTABSIZE + 18)

No functionality change by this patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index b90fe2480089..47d59a1f12f1 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -714,10 +714,9 @@ int remove_section_mapping(unsigned long start, unsigned long end)
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 static void __init hash_init_partition_table(phys_addr_t hash_table,
-					     unsigned long pteg_count)
+					     unsigned long htab_size)
 {
 	unsigned long ps_field;
-	unsigned long htab_size;
 	unsigned long patb_size = 1UL << PATB_SIZE_SHIFT;
 
 	/*
@@ -725,7 +724,7 @@ static void __init hash_init_partition_table(phys_addr_t hash_table,
 	 * We can ignore that for lpid 0
 	 */
 	ps_field = 0;
-	htab_size =  __ilog2(pteg_count) - 11;
+	htab_size =  __ilog2(htab_size) - 18;
 
 	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 24), "Partition table size too large.");
 	partition_tb = __va(memblock_alloc_base(patb_size, patb_size,
@@ -811,7 +810,7 @@ static void __init htab_initialize(void)
 		htab_address = __va(table);
 
 		/* htab absolute addr + encoded htabsize */
-		_SDR1 = table + __ilog2(pteg_count) - 11;
+		_SDR1 = table + __ilog2(htab_size_bytes) - 18;
 
 		/* Initialize the HPT with no entries */
 		memset((void *)table, 0, htab_size_bytes);
@@ -820,7 +819,7 @@ static void __init htab_initialize(void)
 			/* Set SDR1 */
 			mtspr(SPRN_SDR1, _SDR1);
 		else
-			hash_init_partition_table(table, pteg_count);
+			hash_init_partition_table(table, htab_size_bytes);
 	}
 
 	prot = pgprot_val(PAGE_KERNEL);
-- 
2.7.4
