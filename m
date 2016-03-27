Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqrS6Q1ZzDqFd
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:26:32 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 02:26:31 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1266419D803F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:14:21 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8QRZu44171374
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 01:26:27 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8QR5a031250
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:26:27 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 55/65] powerpc/mm: pte_frag abstraction
Date: Sun, 27 Mar 2016 13:54:03 +0530
Message-Id: <1459067053-10835-55-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In this patch we make the number of pte fragments per level4 page table
page a variable. Radix level 4 table size is 256 bytes and hence we
can have 256 fragments per level4 page. We don't update the fragment
count in this patch. We need to do performance measurements to find the
right value for fragment count.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  | 2 ++
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 4 ++--
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 6 ++++++
 arch/powerpc/mm/hash_utils_64.c               | 3 +++
 arch/powerpc/mm/pgtable-radix.c               | 5 +++++
 arch/powerpc/mm/pgtable_64.c                  | 4 ++++
 6 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index f121f8016d8b..10266ec97a83 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -27,6 +27,8 @@
  */
 #define H_PAGE_4K_PFN	0x0
 #define H_PAGE_THP_HUGE 0x0
+#define H_PTE_FRAG_NR	0
+#define H_PTE_FRAG_SIZE_SHIFT  0
 /*
  * On all 4K setups, remap_4k_pfn() equates to remap_pfn_range()
  */
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index ad797a8cc615..f4a19914fdbe 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -29,12 +29,12 @@
 /*
  * we support 16 fragments per PTE page of 64K size.
  */
-#define PTE_FRAG_NR	16
+#define H_PTE_FRAG_NR	16
 /*
  * We use a 2K PTE page fragment and another 2K for storing
  * real_pte_t hash index
  */
-#define PTE_FRAG_SIZE_SHIFT  12
+#define H_PTE_FRAG_SIZE_SHIFT  12
 #define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
 
 #ifndef __ASSEMBLY__
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 72e314c7f157..5db263a60322 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -177,6 +177,12 @@ extern unsigned long __pgd_val_bits;
 #define PMD_VAL_BITS	__pmd_val_bits
 #define PUD_VAL_BITS	__pud_val_bits
 #define PGD_VAL_BITS	__pgd_val_bits
+
+extern unsigned long __pte_frag_nr;
+#define PTE_FRAG_NR __pte_frag_nr
+extern unsigned long __pte_frag_size_shift;
+#define PTE_FRAG_SIZE_SHIFT __pte_frag_size_shift
+#define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
 /*
  * Pgtable size used by swapper, init in asm code
  */
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 599c4684e158..3356a48ca479 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -869,6 +869,9 @@ void __init hlearly_init_mmu(void)
 	/*
 	 * initialize page table size
 	 */
+	__pte_frag_nr = H_PTE_FRAG_NR;
+	__pte_frag_size_shift = H_PTE_FRAG_SIZE_SHIFT;
+
 	__pte_index_size = H_PTE_INDEX_SIZE;
 	__pmd_index_size = H_PMD_INDEX_SIZE;
 	__pud_index_size = H_PUD_INDEX_SIZE;
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 6fe83f160360..2b608c37526c 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -328,6 +328,11 @@ void __init rearly_init_mmu(void)
 	__vmalloc_end = R_VMALLOC_END;
 	vmemmap = (struct page *)R_VMEMMAP_BASE;
 	ioremap_bot = IOREMAP_BASE;
+	/*
+	 * For now radix also use the same frag size
+	 */
+	__pte_frag_nr = H_PTE_FRAG_NR;
+	__pte_frag_size_shift = H_PTE_FRAG_SIZE_SHIFT;
 
 	radix_init_page_sizes();
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 88b6cfc0a3e3..0e980204c4d5 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -107,6 +107,10 @@ unsigned long __vmalloc_end;
 EXPORT_SYMBOL(__vmalloc_end);
 struct page *vmemmap;
 EXPORT_SYMBOL(vmemmap);
+unsigned long __pte_frag_nr;
+EXPORT_SYMBOL(__pte_frag_nr);
+unsigned long __pte_frag_size_shift;
+EXPORT_SYMBOL(__pte_frag_size_shift);
 #endif
 unsigned long ioremap_bot;
 
-- 
2.5.0
