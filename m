Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rW8y45fzYzDqsy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 16:10:51 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5H68wpS103115
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 02:10:49 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23kqt31d68-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 02:10:49 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 17 Jun 2016 00:10:48 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2] powerpc/mm/radix: Update Radix tree size as per ISA 3.0
Date: Fri, 17 Jun 2016 11:40:36 +0530
Message-Id: <1466143836-10034-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ISA 3.0 updated it to be encoded as Radix tree size = 2^(RTS + 31). We
have it encoded as 2^(RTS + 28). Add a helper with the correct encoding
and use it instead of opencoding.

Fixes commit 2bfd65e45e87 ("powerpc/mm/radix: Add radix callbacks for
early init routine ")

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
*changes from V1:
 rename radix__get_rts_value to radix__get_tree_size

 arch/powerpc/include/asm/book3s/64/radix.h | 15 +++++++++++++++
 arch/powerpc/mm/mmu_context_book3s64.c     |  2 +-
 arch/powerpc/mm/pgtable-radix.c            |  9 +++------
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 0d980de55c40..77a585a2cb4e 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -260,5 +260,20 @@ extern void radix__vmemmap_remove_mapping(unsigned long start,
 
 extern int radix__map_kernel_page(unsigned long ea, unsigned long pa,
 				 pgprot_t flags, unsigned int psz);
+
+static inline unsigned long radix__get_tree_size(void)
+{
+	unsigned long rts_field;
+	/*
+	 * we support 52 bits, hence 52-31 = 21, 0b10101
+	 * RTS encoding details
+	 * bits 0 - 3 of rts -> bits 6 - 8 unsigned long
+	 * bits 4 - 5 of rts -> bits 62 - 63 of unsigned long
+	 */
+	rts_field = (0x5UL << 5); /* 6 - 8 bits */
+	rts_field |= (0x2UL << 61);
+
+	return rts_field;
+}
 #endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 78ebc3877530..780f0dd4267e 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -65,7 +65,7 @@ static int radix__init_new_context(struct mm_struct *mm, int index)
 	/*
 	 * set the process table entry,
 	 */
-	rts_field = 3ull << PPC_BITLSHIFT(2);
+	rts_field = radix__get_tree_size();
 	process_tb[index].prtb0 = cpu_to_be64(rts_field | __pa(mm->pgd) | RADIX_PGD_INDEX_SIZE);
 	return 0;
 }
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 85da0212b276..a7a8e967b7aa 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -181,9 +181,8 @@ redo:
 	process_tb = early_alloc_pgtable(1UL << PRTB_SIZE_SHIFT);
 	/*
 	 * Fill in the process table.
-	 * we support 52 bits, hence 52-28 = 24, 11000
 	 */
-	rts_field = 3ull << PPC_BITLSHIFT(2);
+	rts_field = radix__get_tree_size();
 	process_tb->prtb0 = cpu_to_be64(rts_field | __pa(init_mm.pgd) | RADIX_PGD_INDEX_SIZE);
 	/*
 	 * Fill in the partition table. We are suppose to use effective address
@@ -197,10 +196,8 @@ redo:
 static void __init radix_init_partition_table(void)
 {
 	unsigned long rts_field;
-	/*
-	 * we support 52 bits, hence 52-28 = 24, 11000
-	 */
-	rts_field = 3ull << PPC_BITLSHIFT(2);
+
+	rts_field = radix__get_tree_size();
 
 	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 24), "Partition table size too large.");
 	partition_tb = early_alloc_pgtable(1UL << PATB_SIZE_SHIFT);
-- 
2.7.4
