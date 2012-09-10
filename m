Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E41352C03F4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 22:53:16 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 10 Sep 2012 18:23:14 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8ACr8O25439788
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 18:23:08 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8ACr8et015251
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 22:53:08 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V9 11/11] arch/powerpc: Make some of the PGTABLE_RANGE
 dependency explicit
Date: Mon, 10 Sep 2012 18:22:57 +0530
Message-Id: <1347281577-5460-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1347281577-5460-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1347281577-5460-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

slice array size and slice mask size depend on PGTABLE_RANGE.

Reviewed-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h    |   15 ++++++++++-----
 arch/powerpc/include/asm/mmu.h           |    9 +++++++++
 arch/powerpc/include/asm/page_64.h       |   12 ++++++++----
 arch/powerpc/include/asm/pgtable-ppc64.h |   17 ++---------------
 arch/powerpc/include/asm/pgtable.h       |   10 ++--------
 arch/powerpc/include/asm/tlbflush.h      |    3 ---
 arch/powerpc/mm/pgtable_64.c             |   12 +++++++++++-
 arch/powerpc/mm/slice.c                  |    5 +++++
 8 files changed, 47 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 3e88746..9673f73 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -16,6 +16,13 @@
 #include <asm/page.h>
 
 /*
+ * This is necessary to get the definition of PGTABLE_RANGE which we
+ * need for various slices related matters. Note that this isn't the
+ * complete pgtable.h but only a portion of it.
+ */
+#include <asm/pgtable-ppc64.h>
+
+/*
  * Segment table
  */
 
@@ -414,6 +421,8 @@ extern void slb_set_size(u16 size);
 	srdi	rx,rx,VSID_BITS_##size;	/* extract 2^VSID_BITS bit */	\
 	add	rt,rt,rx
 
+/* 4 bits per slice and we have one slice per 1TB */
+#define SLICE_ARRAY_SIZE  (PGTABLE_RANGE >> 41)
 
 #ifndef __ASSEMBLY__
 
@@ -458,11 +467,7 @@ typedef struct {
 
 #ifdef CONFIG_PPC_MM_SLICES
 	u64 low_slices_psize;	/* SLB page size encodings */
-	/*
-	 * Right now we support 64TB and 4 bits for each
-	 * 1TB slice we need 32 bytes for 64TB.
-	 */
-	unsigned char high_slices_psize[32];  /* 4 bits per slice for now */
+	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
 #else
 	u16 sllp;		/* SLB page size encoding */
 #endif
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index e8a26db..5e38eed 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -146,6 +146,15 @@ extern void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 extern u64 ppc64_rma_size;
 #endif /* CONFIG_PPC64 */
 
+struct mm_struct;
+#ifdef CONFIG_DEBUG_VM
+extern void assert_pte_locked(struct mm_struct *mm, unsigned long addr);
+#else /* CONFIG_DEBUG_VM */
+static inline void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
+{
+}
+#endif /* !CONFIG_DEBUG_VM */
+
 #endif /* !__ASSEMBLY__ */
 
 /* The kernel use the constants below to index in the page sizes array.
diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index 6c9bef4..cd915d6 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -78,14 +78,18 @@ extern u64 ppc64_pft_size;
 #define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
 #define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
 
+/*
+ * 1 bit per slice and we have one slice per 1TB
+ * Right now we support only 64TB.
+ * IF we change this we will have to change the type
+ * of high_slices
+ */
+#define SLICE_MASK_SIZE 8
+
 #ifndef __ASSEMBLY__
 
 struct slice_mask {
 	u16 low_slices;
-	/*
-	 * This should be derived out of PGTABLE_RANGE. For the current
-	 * max 64TB, u64 should be ok.
-	 */
 	u64 high_slices;
 };
 
diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 8af1cf2..0182c20 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -21,17 +21,6 @@
 #define PGTABLE_RANGE (ASM_CONST(1) << PGTABLE_EADDR_SIZE)
 
 
-/* Some sanity checking */
-#if TASK_SIZE_USER64 > PGTABLE_RANGE
-#error TASK_SIZE_USER64 exceeds pagetable range
-#endif
-
-#ifdef CONFIG_PPC_STD_MMU_64
-#if TASK_SIZE_USER64 > (1UL << (USER_ESID_BITS + SID_SHIFT))
-#error TASK_SIZE_USER64 exceeds user VSID range
-#endif
-#endif
-
 /*
  * Define the address range of the kernel non-linear virtual area
  */
@@ -117,9 +106,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/stddef.h>
-#include <asm/tlbflush.h>
-
 /*
  * This is the default implementation of various PTE accessors, it's
  * used in all cases except Book3S with 64K pages where we have a
@@ -198,7 +184,8 @@
 /* to find an entry in a kernel page-table-directory */
 /* This now only contains the vmalloc pages */
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
-
+extern void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
+			    pte_t *ptep, unsigned long pte, int huge);
 
 /* Atomic PTE updates */
 static inline unsigned long pte_update(struct mm_struct *mm,
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 2e0e411..a9cbd3b 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -9,14 +9,6 @@
 
 struct mm_struct;
 
-#ifdef CONFIG_DEBUG_VM
-extern void assert_pte_locked(struct mm_struct *mm, unsigned long addr);
-#else /* CONFIG_DEBUG_VM */
-static inline void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
-{
-}
-#endif /* !CONFIG_DEBUG_VM */
-
 #endif /* !__ASSEMBLY__ */
 
 #if defined(CONFIG_PPC64)
@@ -27,6 +19,8 @@ static inline void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 
 #ifndef __ASSEMBLY__
 
+#include <asm/tlbflush.h>
+
 /* Generic accessors to PTE bits */
 static inline int pte_write(pte_t pte)		{ return pte_val(pte) & _PAGE_RW; }
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
diff --git a/arch/powerpc/include/asm/tlbflush.h b/arch/powerpc/include/asm/tlbflush.h
index fc02d1d..61a5927 100644
--- a/arch/powerpc/include/asm/tlbflush.h
+++ b/arch/powerpc/include/asm/tlbflush.h
@@ -103,9 +103,6 @@ DECLARE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
 
 extern void __flush_tlb_pending(struct ppc64_tlb_batch *batch);
 
-extern void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
-			    pte_t *ptep, unsigned long pte, int huge);
-
 #define __HAVE_ARCH_ENTER_LAZY_MMU_MODE
 
 static inline void arch_enter_lazy_mmu_mode(void)
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 249a063..affc4f1 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -56,8 +56,18 @@
 
 #include "mmu_decl.h"
 
-unsigned long ioremap_bot = IOREMAP_BASE;
+/* Some sanity checking */
+#if TASK_SIZE_USER64 > PGTABLE_RANGE
+#error TASK_SIZE_USER64 exceeds pagetable range
+#endif
+
+#ifdef CONFIG_PPC_STD_MMU_64
+#if TASK_SIZE_USER64 > (1UL << (USER_ESID_BITS + SID_SHIFT))
+#error TASK_SIZE_USER64 exceeds user VSID range
+#endif
+#endif
 
+unsigned long ioremap_bot = IOREMAP_BASE;
 
 #ifdef CONFIG_PPC_MMU_NOHASH
 static void *early_alloc_pgtable(unsigned long size)
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index b4e996a..5829d2a 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -34,6 +34,11 @@
 #include <asm/mmu.h>
 #include <asm/spu.h>
 
+/* some sanity checks */
+#if (PGTABLE_RANGE >> 43) > SLICE_MASK_SIZE
+#error PGTABLE_RANGE exceeds slice_mask high_slices size
+#endif
+
 static DEFINE_SPINLOCK(slice_convert_lock);
 
 
-- 
1.7.10
