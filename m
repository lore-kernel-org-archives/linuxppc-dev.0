Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkPvC3qjVzDqb5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 21:33:11 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2GANjoN011635
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 06:32:58 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2978fjar0x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 06:32:57 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 06:32:56 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 10/11] powerpc/mm/radix: Make max pfn bits a variable
Date: Thu, 16 Mar 2017 16:02:08 +0530
In-Reply-To: <1489660329-22501-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1489660329-22501-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1489660329-22501-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes max pysical address bits a variable so that hash and radix
translation mode can choose what value to use. In this patch we also switch the
radix translation mode to use 57 bits. This make it resilient to future changes
to max pfn supported by platforms.

This patch is split from the previous one to make the review easier.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h    | 18 ++++++++++++++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h | 28 +++++-----------------------
 arch/powerpc/include/asm/book3s/64/radix.h   |  4 ++++
 arch/powerpc/mm/hash_utils_64.c              |  1 +
 arch/powerpc/mm/pgtable-radix.c              |  1 +
 arch/powerpc/mm/pgtable_64.c                 |  3 +++
 6 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index ec2828b1db07..af3c88624d3a 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -20,6 +20,24 @@
 #define H_PAGE_F_GIX		(_RPAGE_RSV2 | _RPAGE_RSV3 | _RPAGE_RSV4)
 #define H_PAGE_F_SECOND		_RPAGE_RSV1	/* HPTE is in 2ndary HPTEG */
 #define H_PAGE_HASHPTE		_RPAGE_SW0	/* PTE has associated HPTE */
+/*
+ * Max physical address bit we will use for now.
+ *
+ * This is mostly a hardware limitation and for now Power9 has
+ * a 51 bit limit.
+ *
+ * This is different from the number of physical bit required to address
+ * the last byte of memory. That is defined by MAX_PHYSMEM_BITS.
+ * MAX_PHYSMEM_BITS is a linux limitation imposed by the maximum
+ * number of sections we can support (SECTIONS_SHIFT).
+ *
+ * This is different from Radix page table limitation and
+ * should always be less than that. The limit is done such that
+ * we can overload the bits between _RPAGE_PA_MAX and H_PAGE_PA_MAX
+ * for hash linux page table specific bits.
+ */
+#define H_PAGE_PA_MAX		51
+#define H_PTE_RPN_MASK	(((1UL << H_PAGE_PA_MAX) - 1) & (PAGE_MASK))
 
 #ifdef CONFIG_PPC_64K_PAGES
 #include <asm/book3s/64/hash-64k.h>
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index c470dcc815d5..eb82b60b5c89 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -40,23 +40,6 @@
 #define _RPAGE_RPN1		0x02000
 /* Max physicall address bit as per radix table */
 #define _RPAGE_PA_MAX		57
-/*
- * Max physical address bit we will use for now.
- *
- * This is mostly a hardware limitation and for now Power9 has
- * a 51 bit limit.
- *
- * This is different from the number of physical bit required to address
- * the last byte of memory. That is defined by MAX_PHYSMEM_BITS.
- * MAX_PHYSMEM_BITS is a linux limitation imposed by the maximum
- * number of sections we can support (SECTIONS_SHIFT).
- *
- * This is different from Radix page table limitation above and
- * should always be less than that. The limit is done such that
- * we can overload the bits between _RPAGE_PA_MAX and _PAGE_PA_MAX
- * for hash linux page table specific bits.
- */
-#define _PAGE_PA_MAX		51
 
 #define _PAGE_SOFT_DIRTY	_RPAGE_SW3 /* software: software dirty tracking */
 #define _PAGE_SPECIAL		_RPAGE_SW2 /* software: special page */
@@ -70,12 +53,6 @@
  */
 #define _PAGE_NO_CACHE		_PAGE_TOLERANT
 /*
- * We support _RPAGE_PA_MAX bit real address in pte. On the linux side
- * we are limited by _PAGE_PA_MAX. Clear everything above _PAGE_PA_MAX
- * every thing below PAGE_SHIFT;
- */
-#define PTE_RPN_MASK	(((1UL << _PAGE_PA_MAX) - 1) & (PAGE_MASK))
-/*
  * set of bits not changed in pmd_modify. Even though we have hash specific bits
  * in here, on radix we expect them to be zero.
  */
@@ -180,6 +157,11 @@
 
 #ifndef __ASSEMBLY__
 /*
+ * based on max physical address bit that we want to encode in page table
+ */
+extern unsigned long __pte_rpn_mask;
+#define PTE_RPN_MASK __pte_rpn_mask
+/*
  * page table defines
  */
 extern unsigned long __pte_index_size;
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index ac16d1943022..142739b31174 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -24,6 +24,10 @@
 
 /* An empty PTE can still have a R or C writeback */
 #define RADIX_PTE_NONE_MASK		(_PAGE_DIRTY | _PAGE_ACCESSED)
+/*
+ * Clear everything above _RPAGE_PA_MAX every thing below PAGE_SHIFT
+ */
+#define RADIX_PTE_RPN_MASK		(((1UL << _RPAGE_PA_MAX) - 1) & (PAGE_MASK))
 
 /* Bits to set in a RPMD/RPUD/RPGD */
 #define RADIX_PMD_VAL_BITS		(0x8000000000000000UL | RADIX_PTE_INDEX_SIZE)
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index c554768b1fa2..d990c3332057 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -986,6 +986,7 @@ void __init hash__early_init_mmu(void)
 	/*
 	 * initialize page table size
 	 */
+	__pte_rpn_mask = H_PTE_RPN_MASK;
 	__pte_frag_nr = H_PTE_FRAG_NR;
 	__pte_frag_size_shift = H_PTE_FRAG_SIZE_SHIFT;
 
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index c28165d8970b..6eecbbc7c8af 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -379,6 +379,7 @@ void __init radix__early_init_mmu(void)
 	/*
 	 * initialize page table size
 	 */
+	__pte_rpn_mask  = RADIX_PTE_RPN_MASK;
 	__pte_index_size = RADIX_PTE_INDEX_SIZE;
 	__pmd_index_size = RADIX_PMD_INDEX_SIZE;
 	__pud_index_size = RADIX_PUD_INDEX_SIZE;
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index db93cf747a03..ac0c7ee60de0 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -68,6 +68,9 @@
  */
 struct prtb_entry *process_tb;
 struct patb_entry *partition_tb;
+
+unsigned long __pte_rpn_mask;
+EXPORT_SYMBOL(__pte_rpn_mask);
 /*
  * page table size
  */
-- 
2.7.4
