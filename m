Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyb3GsdzDqB9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:35 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 60/70] powerpc/mm: pte_frag abstraction
Date: Fri, 29 Apr 2016 23:26:23 +1000
Message-Id: <1461936393-10131-60-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

In this patch we make the number of pte fragments per level 4 page table
page a variable. Radix level 4 table size is 256 bytes and hence we can
have 256 fragments per level 4 page. We don't update the fragment count
in this patch. We need to do performance measurements to find the right
value for fragment count.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
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
index c00e39fa3eba..80d2abe25280 100644
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
index f5628f96134b..9175a688e70f 100644
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
index 68aee435ea97..262082e51db1 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -873,6 +873,9 @@ void __init hash__early_init_mmu(void)
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
index 13afacdfa96e..a5a5253c3ea1 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -334,6 +334,11 @@ void __init radix__early_init_mmu(void)
 	__vmalloc_end = RADIX_VMALLOC_END;
 	vmemmap = (struct page *)RADIX_VMEMMAP_BASE;
 	ioremap_bot = IOREMAP_BASE;
+	/*
+	 * For now radix also use the same frag size
+	 */
+	__pte_frag_nr = H_PTE_FRAG_NR;
+	__pte_frag_size_shift = H_PTE_FRAG_SIZE_SHIFT;
 
 	radix_init_page_sizes();
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index e2463c03902b..44e7f6f98b26 100644
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
