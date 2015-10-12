Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4AC991A0758
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 05:40:34 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 13 Oct 2015 00:10:32 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5BC39394005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:28 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9CIeRv911272572
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:27 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9CIeQbF013276
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:27 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v3 06/31] powerpc/mm: Delete booke bits from book3s
Date: Tue, 13 Oct 2015 00:09:50 +0530
Message-Id: <1444675215-19484-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1444675215-19484-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1444675215-19484-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We also move __ASSEMBLY__ towards the end of header. This avoid
having #ifndef __ASSEMBLY___ all over the header

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 93 +++++++---------------------
 arch/powerpc/include/asm/book3s/64/pgtable.h | 88 ++++++++------------------
 arch/powerpc/include/asm/book3s/pgtable.h    |  1 +
 3 files changed, 51 insertions(+), 131 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index a7738dfbe7e5..2afe5958c837 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -3,18 +3,10 @@
 
 #include <asm-generic/pgtable-nopmd.h>
 
-#ifndef __ASSEMBLY__
-#include <linux/sched.h>
-#include <linux/threads.h>
-#include <asm/io.h>			/* For sub-arch specific PPC_PIN_SIZE */
-
-extern unsigned long ioremap_bot;
-
-#ifdef CONFIG_44x
-extern int icache_44x_need_flush;
-#endif
+#include <asm/book3s/32/hash.h>
 
-#endif /* __ASSEMBLY__ */
+/* And here we include common definitions */
+#include <asm/pte-common.h>
 
 /*
  * The normal case is that PTEs are 32-bits and we have a 1-page
@@ -31,28 +23,11 @@ extern int icache_44x_need_flush;
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
-/*
- * entries per page directory level: our page-table tree is two-level, so
- * we don't really have any PMD directory.
- */
-#ifndef __ASSEMBLY__
-#define PTE_TABLE_SIZE	(sizeof(pte_t) << PTE_SHIFT)
-#define PGD_TABLE_SIZE	(sizeof(pgd_t) << (32 - PGDIR_SHIFT))
-#endif	/* __ASSEMBLY__ */
-
 #define PTRS_PER_PTE	(1 << PTE_SHIFT)
 #define PTRS_PER_PMD	1
 #define PTRS_PER_PGD	(1 << (32 - PGDIR_SHIFT))
 
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
-#define FIRST_USER_ADDRESS	0UL
-
-#define pte_ERROR(e) \
-	pr_err("%s:%d: bad pte %llx.\n", __FILE__, __LINE__, \
-		(unsigned long long)pte_val(e))
-#define pgd_ERROR(e) \
-	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
-
 /*
  * This is the bottom of the PKMAP area with HIGHMEM or an arbitrary
  * value (for now) on others, from where we can start layout kernel
@@ -100,30 +75,30 @@ extern int icache_44x_need_flush;
 #endif
 #define VMALLOC_END	ioremap_bot
 
+#ifndef __ASSEMBLY__
+#include <linux/sched.h>
+#include <linux/threads.h>
+#include <asm/io.h>			/* For sub-arch specific PPC_PIN_SIZE */
+
+extern unsigned long ioremap_bot;
+
+/*
+ * entries per page directory level: our page-table tree is two-level, so
+ * we don't really have any PMD directory.
+ */
+#define PTE_TABLE_SIZE	(sizeof(pte_t) << PTE_SHIFT)
+#define PGD_TABLE_SIZE	(sizeof(pgd_t) << (32 - PGDIR_SHIFT))
+
+#define pte_ERROR(e) \
+	pr_err("%s:%d: bad pte %llx.\n", __FILE__, __LINE__, \
+		(unsigned long long)pte_val(e))
+#define pgd_ERROR(e) \
+	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 /*
  * Bits in a linux-style PTE.  These match the bits in the
  * (hardware-defined) PowerPC PTE as closely as possible.
  */
 
-#if defined(CONFIG_40x)
-#include <asm/pte-40x.h>
-#elif defined(CONFIG_44x)
-#include <asm/pte-44x.h>
-#elif defined(CONFIG_FSL_BOOKE) && defined(CONFIG_PTE_64BIT)
-#include <asm/pte-book3e.h>
-#elif defined(CONFIG_FSL_BOOKE)
-#include <asm/pte-fsl-booke.h>
-#elif defined(CONFIG_8xx)
-#include <asm/pte-8xx.h>
-#else /* CONFIG_6xx */
-#include <asm/book3s/32/hash.h>
-#endif
-
-/* And here we include common definitions */
-#include <asm/pte-common.h>
-
-#ifndef __ASSEMBLY__
-
 #define pte_clear(mm, addr, ptep) \
 	do { pte_update(ptep, ~_PAGE_HASHPTE, 0); } while (0)
 
@@ -167,7 +142,6 @@ static inline unsigned long pte_update(pte_t *p,
 				       unsigned long clr,
 				       unsigned long set)
 {
-#ifdef PTE_ATOMIC_UPDATES
 	unsigned long old, tmp;
 
 	__asm__ __volatile__("\
@@ -180,15 +154,7 @@ static inline unsigned long pte_update(pte_t *p,
 	: "=&r" (old), "=&r" (tmp), "=m" (*p)
 	: "r" (p), "r" (clr), "r" (set), "m" (*p)
 	: "cc" );
-#else /* PTE_ATOMIC_UPDATES */
-	unsigned long old = pte_val(*p);
-	*p = __pte((old & ~clr) | set);
-#endif /* !PTE_ATOMIC_UPDATES */
-
-#ifdef CONFIG_44x
-	if ((old & _PAGE_USER) && (old & _PAGE_EXEC))
-		icache_44x_need_flush = 1;
-#endif
+
 	return old;
 }
 #else /* CONFIG_PTE_64BIT */
@@ -196,7 +162,6 @@ static inline unsigned long long pte_update(pte_t *p,
 					    unsigned long clr,
 					    unsigned long set)
 {
-#ifdef PTE_ATOMIC_UPDATES
 	unsigned long long old;
 	unsigned long tmp;
 
@@ -211,15 +176,7 @@ static inline unsigned long long pte_update(pte_t *p,
 	: "=&r" (old), "=&r" (tmp), "=m" (*p)
 	: "r" (p), "r" ((unsigned long)(p) + 4), "r" (clr), "r" (set), "m" (*p)
 	: "cc" );
-#else /* PTE_ATOMIC_UPDATES */
-	unsigned long long old = pte_val(*p);
-	*p = __pte((old & ~(unsigned long long)clr) | set);
-#endif /* !PTE_ATOMIC_UPDATES */
-
-#ifdef CONFIG_44x
-	if ((old & _PAGE_USER) && (old & _PAGE_EXEC))
-		icache_44x_need_flush = 1;
-#endif
+
 	return old;
 }
 #endif /* CONFIG_PTE_64BIT */
@@ -233,12 +190,10 @@ static inline int __ptep_test_and_clear_young(unsigned int context, unsigned lon
 {
 	unsigned long old;
 	old = pte_update(ptep, _PAGE_ACCESSED, 0);
-#if _PAGE_HASHPTE != 0
 	if (old & _PAGE_HASHPTE) {
 		unsigned long ptephys = __pa(ptep) & PAGE_MASK;
 		flush_hash_pages(context, addr, ptephys, 1);
 	}
-#endif
 	return (old & _PAGE_ACCESSED) != 0;
 }
 #define ptep_test_and_clear_young(__vma, __addr, __ptep) \
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 2741ac6fbd3d..cf4824395027 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -8,7 +8,6 @@
 #include <asm/book3s/64/hash.h>
 #include <asm/barrier.h>
 
-#define FIRST_USER_ADDRESS	0UL
 
 /*
  * Size of EA range mapped by our pagetables.
@@ -25,27 +24,16 @@
 /*
  * Define the address range of the kernel non-linear virtual area
  */
-
-#ifdef CONFIG_PPC_BOOK3E
-#define KERN_VIRT_START ASM_CONST(0x8000000000000000)
-#else
 #define KERN_VIRT_START ASM_CONST(0xD000000000000000)
-#endif
 #define KERN_VIRT_SIZE	ASM_CONST(0x0000100000000000)
-
 /*
  * The vmalloc space starts at the beginning of that region, and
  * occupies half of it on hash CPUs and a quarter of it on Book3E
  * (we keep a quarter for the virtual memmap)
  */
 #define VMALLOC_START	KERN_VIRT_START
-#ifdef CONFIG_PPC_BOOK3E
-#define VMALLOC_SIZE	(KERN_VIRT_SIZE >> 2)
-#else
 #define VMALLOC_SIZE	(KERN_VIRT_SIZE >> 1)
-#endif
 #define VMALLOC_END	(VMALLOC_START + VMALLOC_SIZE)
-
 /*
  * The second half of the kernel virtual space is used for IO mappings,
  * it's itself carved into the PIO region (ISA and PHB IO space) and
@@ -64,7 +52,6 @@
 #define IOREMAP_BASE	(PHB_IO_END)
 #define IOREMAP_END	(KERN_VIRT_START + KERN_VIRT_SIZE)
 
-
 /*
  * Region IDs
  */
@@ -79,32 +66,41 @@
 
 /*
  * Defines the address of the vmemap area, in its own region on
- * hash table CPUs and after the vmalloc space on Book3E
+ * hash table CPUs.
  */
-#ifdef CONFIG_PPC_BOOK3E
-#define VMEMMAP_BASE		VMALLOC_END
-#define VMEMMAP_END		KERN_IO_START
-#else
 #define VMEMMAP_BASE		(VMEMMAP_REGION_ID << REGION_SHIFT)
-#endif
 #define vmemmap			((struct page *)VMEMMAP_BASE)
 
 
-/*
- * Include the PTE bits definitions
- */
-#ifdef CONFIG_PPC_BOOK3S
-#include <asm/book3s/64/hash.h>
-#else
-#include <asm/pte-book3e.h>
-#endif
-#include <asm/pte-common.h>
-
 #ifdef CONFIG_PPC_MM_SLICES
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+#else
+#error "Hash Config needs mm slice enabled"
 #endif /* CONFIG_PPC_MM_SLICES */
 
+/*
+ * THP pages can't be special. So use the _PAGE_SPECIAL
+ */
+#define _PAGE_SPLITTING _PAGE_SPECIAL
+
+/*
+ * We need to differentiate between explicit huge page and THP huge
+ * page, since THP huge page also need to track real subpage details
+ */
+#define _PAGE_THP_HUGE  _PAGE_4K_PFN
+
+/*
+ * set of bits not changed in pmd_modify.
+ */
+#define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS |		\
+			 _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_SPLITTING | \
+			 _PAGE_THP_HUGE)
+/*
+ * Default defines for things which we don't use.
+ * We should get this removed.
+ */
+#include <asm/pte-common.h>
 #ifndef __ASSEMBLY__
 
 /*
@@ -144,7 +140,7 @@
 #define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
 #define PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
 
-#define pmd_set(pmdp, pmdval) 	(pmd_val(*(pmdp)) = (pmdval))
+#define pmd_set(pmdp, pmdval)	(pmd_val(*(pmdp)) = (pmdval))
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(!is_kernel_addr(pmd_val(pmd)) \
 				 || (pmd_val(pmd) & PMD_BAD_BITS))
@@ -206,7 +202,6 @@ static inline unsigned long pte_update(struct mm_struct *mm,
 				       unsigned long set,
 				       int huge)
 {
-#ifdef PTE_ATOMIC_UPDATES
 	unsigned long old, tmp;
 
 	__asm__ __volatile__(
@@ -220,18 +215,12 @@ static inline unsigned long pte_update(struct mm_struct *mm,
 	: "=&r" (old), "=&r" (tmp), "=m" (*ptep)
 	: "r" (ptep), "r" (clr), "m" (*ptep), "i" (_PAGE_BUSY), "r" (set)
 	: "cc" );
-#else
-	unsigned long old = pte_val(*ptep);
-	*ptep = __pte((old & ~clr) | set);
-#endif
 	/* huge pages use the old page table lock */
 	if (!huge)
 		assert_pte_locked(mm, addr);
 
-#ifdef CONFIG_PPC_STD_MMU_64
 	if (old & _PAGE_HASHPTE)
 		hpte_need_flush(mm, addr, ptep, old, huge);
-#endif
 
 	return old;
 }
@@ -313,7 +302,6 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 	unsigned long bits = pte_val(entry) &
 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
 
-#ifdef PTE_ATOMIC_UPDATES
 	unsigned long old, tmp;
 
 	__asm__ __volatile__(
@@ -326,10 +314,6 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 	:"=&r" (old), "=&r" (tmp), "=m" (*ptep)
 	:"r" (bits), "r" (ptep), "m" (*ptep), "i" (_PAGE_BUSY)
 	:"cc");
-#else
-	unsigned long old = pte_val(*ptep);
-	*ptep = __pte(old | bits);
-#endif
 }
 
 #define __HAVE_ARCH_PTE_SAME
@@ -367,28 +351,8 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 
 void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
 void pgtable_cache_init(void);
-#endif /* __ASSEMBLY__ */
 
 /*
- * THP pages can't be special. So use the _PAGE_SPECIAL
- */
-#define _PAGE_SPLITTING _PAGE_SPECIAL
-
-/*
- * We need to differentiate between explicit huge page and THP huge
- * page, since THP huge page also need to track real subpage details
- */
-#define _PAGE_THP_HUGE  _PAGE_4K_PFN
-
-/*
- * set of bits not changed in pmd_modify.
- */
-#define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS |		\
-			 _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_SPLITTING | \
-			 _PAGE_THP_HUGE)
-
-#ifndef __ASSEMBLY__
-/*
  * The linux hugepage PMD now include the pmd entries followed by the address
  * to the stashed pgtable_t. The stashed pgtable_t contains the hpte bits.
  * [ 1 bit secondary | 3 bit hidx | 1 bit valid | 000]. We use one byte per
diff --git a/arch/powerpc/include/asm/book3s/pgtable.h b/arch/powerpc/include/asm/book3s/pgtable.h
index a8d8e5152bd4..3818cc7bc9b7 100644
--- a/arch/powerpc/include/asm/book3s/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/pgtable.h
@@ -7,4 +7,5 @@
 #include <asm/book3s/32/pgtable.h>
 #endif
 
+#define FIRST_USER_ADDRESS	0UL
 #endif
-- 
2.5.0
