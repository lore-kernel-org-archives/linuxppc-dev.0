Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B1A72C0090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 16:00:50 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 25 Apr 2013 11:24:40 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id C75673940053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 11:30:42 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3P60coJ6226274
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 11:30:38 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3P60fk8025407
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 16:00:42 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V6 05/27] powerpc: New hugepage directory format
In-Reply-To: <20130424054734.GA2073@drongo>
References: <1366624861-24948-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1366624861-24948-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130424054734.GA2073@drongo>
Date: Thu, 25 Apr 2013 11:30:37 +0530
Message-ID: <87wqrr175m.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Mon, Apr 22, 2013 at 03:30:39PM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>
> [snip]
>
>>  /*
>> - * Use the top bit of the higher-level page table entries to indicate whether
>> - * the entries we point to contain hugepages.  This works because we know that
>> - * the page tables live in kernel space.  If we ever decide to support having
>> - * page tables at arbitrary addresses, this breaks and will have to change.
>> - */
>> -#ifdef CONFIG_PPC64
>> -#define PD_HUGE 0x8000000000000000
>> -#else
>> -#define PD_HUGE 0x80000000
>> -#endif
>
> I think this is a good thing to do ultimately, but if you do this you
> also need to fix arch/powerpc/kernel/head_fsl_booke.S:
>
> #ifdef CONFIG_PTE_64BIT
> #ifdef CONFIG_HUGETLB_PAGE
> #define FIND_PTE	\
> 	rlwinm	r12, r10, 13, 19, 29;	/* Compute pgdir/pmd offset */	\
> 	lwzx	r11, r12, r11;		/* Get pgd/pmd entry */		\
> 	rlwinm.	r12, r11, 0, 0, 20;	/* Extract pt base address */	\
> 	blt	1000f;			/* Normal non-huge page */	\
> 	beq	2f;			/* Bail if no table */		\
> 	oris	r11, r11, PD_HUGE@h;	/* Put back address bit */	\
> 	andi.	r10, r11, HUGEPD_SHIFT_MASK@l; /* extract size field */	\
> 	xor	r12, r10, r11;		/* drop size bits from pointer */ \
> 	b	1001f;							\
>

that should be easy, but

> and this, from arch/powerpc/mm/tlb_low_64e.S:
>
> 	cmpdi	cr0,r14,0
> 	bge	tlb_miss_fault_bolted	/* Bad pgd entry or hugepage; bail */
>
> (of which there are several similar instances in that file).
>
> If you want to avoid fixing these bits of assembly code (and any
> others I missed in my quick scan), you'll need to keep the definition
> of PD_HUGE, at least on anything not 64-bit Book3S.

I am not sure we can find all such usages easily. I looked at the commit
d1b9b12811ef079c37fe464f51953746d8b78e2a and am worried we might be
breaking assumptions like that. Considering that I won't be able to test
FSL, I am inclined to go with the second option you listed, even though
that adds few more #ifdef. How about

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 62e11a3..4daf7e6 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -6,6 +6,33 @@
 
 extern struct kmem_cache *hugepte_cache;
 
+#ifdef CONFIG_PPC_BOOK3S_64
+/*
+ * This should work for other subarchs too. But right now we use the
+ * new format only for 64bit book3s
+ */
+static inline pte_t *hugepd_page(hugepd_t hpd)
+{
+	BUG_ON(!hugepd_ok(hpd));
+	/*
+	 * We have only four bits to encode, MMU page size
+	 */
+	BUILD_BUG_ON((MMU_PAGE_COUNT - 1) > 0xf);
+	return (pte_t *)(hpd.pd & ~HUGEPD_SHIFT_MASK);
+}
+
+static inline unsigned int hugepd_mmu_psize(hugepd_t hpd)
+{
+	return (hpd.pd & HUGEPD_SHIFT_MASK) >> 2;
+}
+
+static inline unsigned int hugepd_shift(hugepd_t hpd)
+{
+	return mmu_psize_to_shift(hugepd_mmu_psize(hpd));
+}
+
+#else
+
 static inline pte_t *hugepd_page(hugepd_t hpd)
 {
 	BUG_ON(!hugepd_ok(hpd));
@@ -17,6 +44,9 @@ static inline unsigned int hugepd_shift(hugepd_t hpd)
 	return hpd.pd & HUGEPD_SHIFT_MASK;
 }
 
+#endif /* CONFIG_PPC_BOOK3S_64 */
+
+
 static inline pte_t *hugepte_offset(hugepd_t *hpdp, unsigned long addr,
 				    unsigned pdshift)
 {
diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index b59e06f..05895cf 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -21,6 +21,7 @@
  * complete pgtable.h but only a portion of it.
  */
 #include <asm/pgtable-ppc64.h>
+#include <asm/bug.h>
 
 /*
  * Segment table
@@ -159,6 +160,24 @@ struct mmu_psize_def
 	unsigned long	avpnm;	/* bits to mask out in AVPN in the HPTE */
 	unsigned long	sllp;	/* SLB L||LP (exact mask to use in slbmte) */
 };
+extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
+
+static inline int shift_to_mmu_psize(unsigned int shift)
+{
+	int psize;
+
+	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize)
+		if (mmu_psize_defs[psize].shift == shift)
+			return psize;
+	return -1;
+}
+
+static inline unsigned int mmu_psize_to_shift(unsigned int mmu_psize)
+{
+	if (mmu_psize_defs[mmu_psize].shift)
+		return mmu_psize_defs[mmu_psize].shift;
+	BUG();
+}
 
 #endif /* __ASSEMBLY__ */
 
@@ -193,7 +212,6 @@ static inline int segment_shift(int ssize)
 /*
  * The current system page and segment sizes
  */
-extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 extern int mmu_linear_psize;
 extern int mmu_virtual_psize;
 extern int mmu_vmalloc_psize;
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index f072e97..652719c 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -249,6 +249,7 @@ extern long long virt_phys_offset;
 #define is_kernel_addr(x)	((x) >= PAGE_OFFSET)
 #endif
 
+#ifndef CONFIG_PPC_BOOK3S_64
 /*
  * Use the top bit of the higher-level page table entries to indicate whether
  * the entries we point to contain hugepages.  This works because we know that
@@ -260,6 +261,7 @@ extern long long virt_phys_offset;
 #else
 #define PD_HUGE 0x80000000
 #endif
+#endif /* CONFIG_PPC_BOOK3S_64 */
 
 /*
  * Some number of bits at the level of the page table that points to
@@ -354,10 +356,21 @@ typedef unsigned long pgprot_t;
 typedef struct { signed long pd; } hugepd_t;
 
 #ifdef CONFIG_HUGETLB_PAGE
+#ifdef CONFIG_PPC_BOOK3S_64
+static inline int hugepd_ok(hugepd_t hpd)
+{
+	/*
+	 * hugepd pointer, bottom two bits == 00 and next 4 bits
+	 * indicate size of table
+	 */
+	return (((hpd.pd & 0x3) == 0x0) && ((hpd.pd & HUGEPD_SHIFT_MASK) != 0));
+}
+#else
 static inline int hugepd_ok(hugepd_t hpd)
 {
 	return (hpd.pd > 0);
 }
+#endif
 
 #define is_hugepd(pdep)               (hugepd_ok(*((hugepd_t *)(pdep))))
 #else /* CONFIG_HUGETLB_PAGE */
diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
index 292725c..69e352a 100644
--- a/arch/powerpc/include/asm/pgalloc-64.h
+++ b/arch/powerpc/include/asm/pgalloc-64.h
@@ -35,7 +35,10 @@ struct vmemmap_backing {
 #define MAX_PGTABLE_INDEX_SIZE	0xf
 
 extern struct kmem_cache *pgtable_cache[];
-#define PGT_CACHE(shift) (pgtable_cache[(shift)-1])
+#define PGT_CACHE(shift) ({				\
+			BUG_ON(!(shift));		\
+			pgtable_cache[(shift) - 1];	\
+		})
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 1a6de0a..b5f4a5f 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -48,23 +48,6 @@ static u64 gpage_freearray[MAX_NUMBER_GPAGES];
 static unsigned nr_gpages;
 #endif
 
-static inline int shift_to_mmu_psize(unsigned int shift)
-{
-	int psize;
-
-	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize)
-		if (mmu_psize_defs[psize].shift == shift)
-			return psize;
-	return -1;
-}
-
-static inline unsigned int mmu_psize_to_shift(unsigned int mmu_psize)
-{
-	if (mmu_psize_defs[mmu_psize].shift)
-		return mmu_psize_defs[mmu_psize].shift;
-	BUG();
-}
-
 #define hugepd_none(hpd)	((hpd).pd == 0)
 
 pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea, unsigned *shift)
@@ -145,6 +128,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 		if (unlikely(!hugepd_none(*hpdp)))
 			break;
 		else
+			/* We use the old format for PPC_FSL_BOOK3E */
 			hpdp->pd = ((unsigned long)new & ~PD_HUGE) | pshift;
 	}
 	/* If we bailed from the for loop early, an error occurred, clean up */
@@ -156,9 +140,15 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 #else
 	if (!hugepd_none(*hpdp))
 		kmem_cache_free(cachep, new);
-	else
+	else {
+#ifdef CONFIG_PPC_BOOK3S_64
+		hpdp->pd = (unsigned long)new |
+			    (shift_to_mmu_psize(pshift) << 2);
+#else
 		hpdp->pd = ((unsigned long)new & ~PD_HUGE) | pshift;
 #endif
+	}
+#endif
 	spin_unlock(&mm->page_table_lock);
 	return 0;
 }
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 7e2246f..a56de85 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -129,8 +129,7 @@ void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
 	align = max_t(unsigned long, align, minalign);
 	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
 	new = kmem_cache_create(name, table_size, align, 0, ctor);
-	PGT_CACHE(shift) = new;
-
+	pgtable_cache[shift - 1] = new;
 	pr_debug("Allocated pgtable cache for order %d\n", shift);
 }
 
