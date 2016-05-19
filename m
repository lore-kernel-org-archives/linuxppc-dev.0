Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9NdZ38tTzDqJ9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 17:54:58 +1000 (AEST)
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 19 May 2016 13:24:53 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 09166E005F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:28:02 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4J7smrM49414344
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:24:49 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4J7sk5U031599
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:24:48 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 3/6] powerpc/mm/hash: Update SDR1 size encoding as documented
 in ISA 3.0
Date: Thu, 19 May 2016 13:24:29 +0530
Message-Id: <1463644472-10158-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1463644472-10158-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1463644472-10158-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index 59268969a0bc..3849de15b65f 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -677,10 +677,9 @@ int remove_section_mapping(unsigned long start, unsigned long end)
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 static void __init hash_init_partition_table(phys_addr_t hash_table,
-					     unsigned long pteg_count)
+					     unsigned long htab_size)
 {
 	unsigned long ps_field;
-	unsigned long htab_size;
 	unsigned long patb_size = 1UL << PATB_SIZE_SHIFT;
 
 	/*
@@ -688,7 +687,7 @@ static void __init hash_init_partition_table(phys_addr_t hash_table,
 	 * We can ignore that for lpid 0
 	 */
 	ps_field = 0;
-	htab_size =  __ilog2(pteg_count) - 11;
+	htab_size =  __ilog2(htab_size) - 18;
 
 	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 24), "Partition table size too large.");
 	partition_tb = __va(memblock_alloc_base(patb_size, patb_size,
@@ -774,7 +773,7 @@ static void __init htab_initialize(void)
 		htab_address = __va(table);
 
 		/* htab absolute addr + encoded htabsize */
-		_SDR1 = table + __ilog2(pteg_count) - 11;
+		_SDR1 = table + __ilog2(htab_size_bytes) - 18;
 
 		/* Initialize the HPT with no entries */
 		memset((void *)table, 0, htab_size_bytes);
@@ -783,7 +782,7 @@ static void __init htab_initialize(void)
 			/* Set SDR1 */
 			mtspr(SPRN_SDR1, _SDR1);
 		else
-			hash_init_partition_table(table, pteg_count);
+			hash_init_partition_table(table, htab_size_bytes);
 	}
 
 	prot = pgprot_val(PAGE_KERNEL);
-- 
2.7.4
