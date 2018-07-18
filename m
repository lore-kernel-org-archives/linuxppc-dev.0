Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VqNN3jRWzF3Hb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 18:01:23 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6I7xj54013659
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 04:01:21 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ka0h02rd2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 04:01:20 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 18 Jul 2018 04:01:19 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 1/2] powerpc/mm/book3s/radix: Drop the unnecessary retry when
 creating linear mapping
Date: Wed, 18 Jul 2018 13:31:11 +0530
Message-Id: <20180718080112.16633-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Checking for mapping_size != PAGE_SIZE should make sure we handle the
split_text_mapping correctly. Drop the retry loop.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/mm/pgtable-radix.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index bba168d02235..d9819e573103 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -261,7 +261,6 @@ static int __meminit create_physical_mapping(unsigned long start,
 {
 	unsigned long vaddr, addr, mapping_size = 0;
 	pgprot_t prot;
-	unsigned long max_mapping_size;
 #ifdef CONFIG_STRICT_KERNEL_RWX
 	int split_text_mapping = 1;
 #else
@@ -275,12 +274,9 @@ static int __meminit create_physical_mapping(unsigned long start,
 
 		gap = end - addr;
 		previous_size = mapping_size;
-		max_mapping_size = PUD_SIZE;
 
-retry:
 		if (IS_ALIGNED(addr, PUD_SIZE) && gap >= PUD_SIZE &&
-		    mmu_psize_defs[MMU_PAGE_1G].shift &&
-		    PUD_SIZE <= max_mapping_size)
+		    mmu_psize_defs[MMU_PAGE_1G].shift)
 			mapping_size = PUD_SIZE;
 		else if (IS_ALIGNED(addr, PMD_SIZE) && gap >= PMD_SIZE &&
 			 mmu_psize_defs[MMU_PAGE_2M].shift)
@@ -288,14 +284,7 @@ static int __meminit create_physical_mapping(unsigned long start,
 		else
 			mapping_size = PAGE_SIZE;
 
-		if (split_text_mapping && (mapping_size == PUD_SIZE) &&
-			(addr <= __pa_symbol(__init_begin)) &&
-			(addr + mapping_size) >= __pa_symbol(_stext)) {
-			max_mapping_size = PMD_SIZE;
-			goto retry;
-		}
-
-		if (split_text_mapping && (mapping_size == PMD_SIZE) &&
+		if (split_text_mapping && (mapping_size != PAGE_SIZE) &&
 		    (addr <= __pa_symbol(__init_begin)) &&
 		    (addr + mapping_size) >= __pa_symbol(_stext))
 			mapping_size = PAGE_SIZE;
-- 
2.17.1
