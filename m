Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmM34SBMzDqKD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:17:03 +1000 (AEST)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 00:17:01 -0600
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 6E4B03E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 00:16:58 -0600 (MDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396GvFg35717324
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 06:16:57 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396GvK6001462
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 02:16:57 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 57/68] powerpc/mm: pte_frag abstraction
Date: Sat,  9 Apr 2016 11:43:53 +0530
Message-Id: <1460182444-2468-58-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index dcb9d6e94a0c..99f360e0ecb0 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -28,6 +28,8 @@
 #define H_PAGE_4K_PFN	0x0
 #define H_PAGE_THP_HUGE 0x0
 #define H_PAGE_COMBO	0x0
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
index 87519ad1c5dc..be8f46853cc9 100644
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
index 508453c0eac4..c59dfe706a0f 100644
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
