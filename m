Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMhr84WQ2zDrfp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 15:41:12 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v725f9qQ097477
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 01:41:10 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c37cmm57y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 01:41:10 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Aug 2017 23:41:09 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 08/17] powerpc/mm/hash: Don't track hash pte slot number
 in linux page table.
Date: Wed,  2 Aug 2017 11:10:07 +0530
In-Reply-To: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20170802054016.8927-9-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have updated all MMU hash operations to work with hash value instead
of slot, remove slot tracking completely. We also remove real_pte because
without slot tracking 4k, 64k and 64k subpages all have similar pte format.

One of the side effect of this is, we now don't track whether we have taken
a fault on 4k subpages on a 64k page config. That means a invalidate will try
to invalidate all the 4k subpages.

To minimize the impact from above THP still track the slot details. With THP we
have 4096 subpages and we want to avoid calling invalidate on all. For THP we
don't track slot details as part of linux page table, but are tracked in the
deposited page table

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h       | 16 +++-
 arch/powerpc/include/asm/book3s/64/hash-64k.h      | 44 +---------
 arch/powerpc/include/asm/book3s/64/hash.h          |  5 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       | 26 ------
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h |  3 +-
 arch/powerpc/include/asm/pgtable-be-types.h        | 10 ---
 arch/powerpc/include/asm/pgtable-types.h           |  9 --
 arch/powerpc/mm/dump_linuxpagetables.c             | 10 ---
 arch/powerpc/mm/hash64_4k.c                        |  2 -
 arch/powerpc/mm/hash64_64k.c                       | 95 +++++-----------------
 arch/powerpc/mm/hash_native_64.c                   | 12 +--
 arch/powerpc/mm/hash_utils_64.c                    | 22 +----
 arch/powerpc/mm/hugetlbpage-hash64.c               |  4 -
 arch/powerpc/mm/tlb_hash64.c                       |  9 +-
 arch/powerpc/platforms/pseries/lpar.c              |  4 +-
 15 files changed, 50 insertions(+), 221 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 0c4e470571ca..d65dcb5826ff 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -17,8 +17,7 @@
 #define H_PGD_TABLE_SIZE	(sizeof(pgd_t) << H_PGD_INDEX_SIZE)
 
 /* PTE flags to conserve for HPTE identification */
-#define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_HASHPTE | \
-			 H_PAGE_F_SECOND | H_PAGE_F_GIX)
+#define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_HASHPTE)
 /*
  * Not supported by 4k linux page size
  */
@@ -27,6 +26,19 @@
 #define H_PAGE_COMBO	0x0
 #define H_PTE_FRAG_NR	0
 #define H_PTE_FRAG_SIZE_SHIFT  0
+
+#define pte_iterate_hashed_subpages(vpn, psize, index, shift)	\
+	do {							\
+	index = 0;						\
+	shift = mmu_psize_defs[psize].shift;			\
+
+#define pte_iterate_hashed_end() } while(0)
+/*
+ * We expect this to be called only for user addresses or kernel virtual
+ * addresses other than the linear mapping.
+ */
+#define pte_pagesize_index(mm, addr, pte)	MMU_PAGE_4K
+
 /*
  * On all 4K setups, remap_4k_pfn() equates to remap_pfn_range()
  */
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 9732837aaae8..ab36323b8a3e 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -25,8 +25,7 @@
 #define H_PAGE_COMBO_VALID	(H_PAGE_F_GIX | H_PAGE_F_SECOND)
 
 /* PTE flags to conserve for HPTE identification */
-#define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_F_SECOND | \
-			 H_PAGE_F_GIX | H_PAGE_HASHPTE | H_PAGE_COMBO)
+#define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_HASHPTE | H_PAGE_COMBO)
 /*
  * we support 16 fragments per PTE page of 64K size.
  */
@@ -40,55 +39,16 @@
 
 #ifndef __ASSEMBLY__
 #include <asm/errno.h>
-
-/*
- * With 64K pages on hash table, we have a special PTE format that
- * uses a second "half" of the page table to encode sub-page information
- * in order to deal with 64K made of 4K HW pages. Thus we override the
- * generic accessors and iterators here
- */
-#define __real_pte __real_pte
-static inline real_pte_t __real_pte(pte_t pte, pte_t *ptep)
-{
-	real_pte_t rpte;
-	unsigned long *hidxp;
-
-	rpte.pte = pte;
-	rpte.hidx = 0;
-	if (pte_val(pte) & H_PAGE_COMBO) {
-		/*
-		 * Make sure we order the hidx load against the H_PAGE_COMBO
-		 * check. The store side ordering is done in __hash_page_4K
-		 */
-		smp_rmb();
-		hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
-		rpte.hidx = *hidxp;
-	}
-	return rpte;
-}
-
-static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
-{
-	if ((pte_val(rpte.pte) & H_PAGE_COMBO))
-		return (rpte.hidx >> (index<<2)) & 0xf;
-	return (pte_val(rpte.pte) >> H_PAGE_F_GIX_SHIFT) & 0xf;
-}
-
-#define __rpte_to_pte(r)	((r).pte)
-extern bool __rpte_sub_valid(real_pte_t rpte, unsigned long index);
 /*
  * Trick: we set __end to va + 64k, which happens works for
  * a 16M page as well as we want only one iteration
  */
-#define pte_iterate_hashed_subpages(rpte, psize, vpn, index, shift)	\
+#define pte_iterate_hashed_subpages(vpn, psize, index, shift)		\
 	do {								\
 		unsigned long __end = vpn + (1UL << (PAGE_SHIFT - VPN_SHIFT));	\
-		unsigned __split = (psize == MMU_PAGE_4K ||		\
-				    psize == MMU_PAGE_64K_AP);		\
 		shift = mmu_psize_defs[psize].shift;			\
 		for (index = 0; vpn < __end; index++,			\
 			     vpn += (1L << (shift - VPN_SHIFT))) {	\
-			if (!__split || __rpte_sub_valid(rpte, index))	\
 				do {
 
 #define pte_iterate_hashed_end() } while(0); } } while(0)
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 36fc7bfe9e11..4b7035f0344d 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -8,11 +8,8 @@
  *
  */
 #define H_PTE_NONE_MASK		_PAGE_HPTEFLAGS
-#define H_PAGE_F_GIX_SHIFT	56
 #define H_PAGE_BUSY		_RPAGE_RSV1 /* software: PTE & hash are busy */
-#define H_PAGE_F_SECOND		_RPAGE_RSV2	/* HPTE is in 2ndary HPTEG */
-#define H_PAGE_F_GIX		(_RPAGE_RSV3 | _RPAGE_RSV4 | _RPAGE_RPN44)
-#define H_PAGE_HASHPTE		_RPAGE_RPN43	/* PTE has associated HPTE */
+#define H_PAGE_HASHPTE		_RPAGE_RSV2	/* PTE has associated HPTE */
 
 #ifdef CONFIG_PPC_64K_PAGES
 #include <asm/book3s/64/hash-64k.h>
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index f349f5388af6..ce9cb2a2198c 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -315,32 +315,6 @@ extern unsigned long pci_io_base;
 
 #ifndef __ASSEMBLY__
 
-/*
- * This is the default implementation of various PTE accessors, it's
- * used in all cases except Book3S with 64K pages where we have a
- * concept of sub-pages
- */
-#ifndef __real_pte
-
-#define __real_pte(e,p)		((real_pte_t){(e)})
-#define __rpte_to_pte(r)	((r).pte)
-#define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >> H_PAGE_F_GIX_SHIFT)
-
-#define pte_iterate_hashed_subpages(rpte, psize, va, index, shift)       \
-	do {							         \
-		index = 0;					         \
-		shift = mmu_psize_defs[psize].shift;		         \
-
-#define pte_iterate_hashed_end() } while(0)
-
-/*
- * We expect this to be called only for user addresses or kernel virtual
- * addresses other than the linear mapping.
- */
-#define pte_pagesize_index(mm, addr, pte)	MMU_PAGE_4K
-
-#endif /* __real_pte */
-
 static inline unsigned long pte_update(struct mm_struct *mm, unsigned long addr,
 				       pte_t *ptep, unsigned long clr,
 				       unsigned long set, int huge)
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
index 2f6373144e2c..d9d409b03ce4 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
@@ -14,7 +14,6 @@ struct ppc64_tlb_batch {
 	int			active;
 	unsigned long		index;
 	struct mm_struct	*mm;
-	real_pte_t		pte[PPC64_TLB_BATCH_NR];
 	unsigned long		vpn[PPC64_TLB_BATCH_NR];
 	unsigned int		psize;
 	int			ssize;
@@ -51,7 +50,7 @@ static inline void arch_leave_lazy_mmu_mode(void)
 #define arch_flush_lazy_mmu_mode()      do {} while (0)
 
 
-extern void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize,
+extern void flush_hash_page(unsigned long vpn, int psize,
 			    int ssize, unsigned long flags);
 extern void flush_hash_range(unsigned long number, int local);
 extern void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
diff --git a/arch/powerpc/include/asm/pgtable-be-types.h b/arch/powerpc/include/asm/pgtable-be-types.h
index 9c0f5db5cf46..dc56a214d38a 100644
--- a/arch/powerpc/include/asm/pgtable-be-types.h
+++ b/arch/powerpc/include/asm/pgtable-be-types.h
@@ -72,16 +72,6 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 #define pgprot_val(x)	((x).pgprot)
 #define __pgprot(x)	((pgprot_t) { (x) })
 
-/*
- * With hash config 64k pages additionally define a bigger "real PTE" type that
- * gathers the "second half" part of the PTE for pseudo 64k pages
- */
-#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC_STD_MMU_64)
-typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
-#else
-typedef struct { pte_t pte; } real_pte_t;
-#endif
-
 static inline bool pte_xchg(pte_t *ptep, pte_t old, pte_t new)
 {
 	unsigned long *p = (unsigned long *)ptep;
diff --git a/arch/powerpc/include/asm/pgtable-types.h b/arch/powerpc/include/asm/pgtable-types.h
index 8bd3b13fe2fb..f19e4ad6bb1f 100644
--- a/arch/powerpc/include/asm/pgtable-types.h
+++ b/arch/powerpc/include/asm/pgtable-types.h
@@ -45,15 +45,6 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 #define pgprot_val(x)	((x).pgprot)
 #define __pgprot(x)	((pgprot_t) { (x) })
 
-/*
- * With hash config 64k pages additionally define a bigger "real PTE" type that
- * gathers the "second half" part of the PTE for pseudo 64k pages
- */
-#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC_STD_MMU_64)
-typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
-#else
-typedef struct { pte_t pte; } real_pte_t;
-#endif
 
 #ifdef CONFIG_PPC_STD_MMU_64
 #include <asm/cmpxchg.h>
diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index 44fe4833910f..5554df9b77ae 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -214,16 +214,6 @@ static const struct flag_info flag_array[] = {
 		.set	= "4K_pfn",
 	}, {
 #endif
-		.mask	= H_PAGE_F_GIX,
-		.val	= H_PAGE_F_GIX,
-		.set	= "f_gix",
-		.is_val	= true,
-		.shift	= H_PAGE_F_GIX_SHIFT,
-	}, {
-		.mask	= H_PAGE_F_SECOND,
-		.val	= H_PAGE_F_SECOND,
-		.set	= "f_second",
-	}, {
 #endif
 		.mask	= _PAGE_SPECIAL,
 		.val	= _PAGE_SPECIAL,
diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
index d262d814ca55..88e2346ab597 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -113,8 +113,6 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 			return -1;
 		}
 		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | H_PAGE_HASHPTE;
-		new_pte |= (slot << H_PAGE_F_GIX_SHIFT) &
-			(H_PAGE_F_SECOND | H_PAGE_F_GIX);
 	}
 	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
 	return 0;
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index 2b72f2c5ed10..7325ed8cfe09 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -15,45 +15,15 @@
 #include <linux/mm.h>
 #include <asm/machdep.h>
 #include <asm/mmu.h>
-/*
- * index from 0 - 15
- */
-bool __rpte_sub_valid(real_pte_t rpte, unsigned long index)
-{
-	unsigned long g_idx;
-	unsigned long ptev = pte_val(rpte.pte);
-
-	g_idx = (ptev & H_PAGE_COMBO_VALID) >> H_PAGE_F_GIX_SHIFT;
-	index = index >> 2;
-	if (g_idx & (0x1 << index))
-		return true;
-	else
-		return false;
-}
-/*
- * index from 0 - 15
- */
-static unsigned long mark_subptegroup_valid(unsigned long ptev, unsigned long index)
-{
-	unsigned long g_idx;
-
-	if (!(ptev & H_PAGE_COMBO))
-		return ptev;
-	index = index >> 2;
-	g_idx = 0x1 << index;
-
-	return ptev | (g_idx << H_PAGE_F_GIX_SHIFT);
-}
 
 int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		   pte_t *ptep, unsigned long trap, unsigned long flags,
 		   int ssize, int subpg_prot)
 {
-	real_pte_t rpte;
-	unsigned long *hidxp;
+	int ret;
 	unsigned long hpte_group;
 	unsigned int subpg_index;
-	unsigned long rflags, pa, hidx;
+	unsigned long rflags, pa;
 	unsigned long old_pte, new_pte, subpg_pte;
 	unsigned long vpn, hash, slot;
 	unsigned long shift = mmu_psize_defs[MMU_PAGE_4K].shift;
@@ -99,7 +69,6 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 
 	subpg_index = (ea & (PAGE_SIZE - 1)) >> shift;
 	vpn  = hpt_vpn(ea, vsid, ssize);
-	rpte = __real_pte(__pte(old_pte), ptep);
 	/*
 	 *None of the sub 4k page is hashed
 	 */
@@ -110,37 +79,31 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	 * as a 64k HW page, and invalidate the 64k HPTE if so.
 	 */
 	if (!(old_pte & H_PAGE_COMBO)) {
-		flush_hash_page(vpn, rpte, MMU_PAGE_64K, ssize, flags);
-		/*
-		 * clear the old slot details from the old and new pte.
-		 * On hash insert failure we use old pte value and we don't
-		 * want slot information there if we have a insert failure.
-		 */
-		old_pte &= ~(H_PAGE_HASHPTE | H_PAGE_F_GIX | H_PAGE_F_SECOND);
-		new_pte &= ~(H_PAGE_HASHPTE | H_PAGE_F_GIX | H_PAGE_F_SECOND);
+		flush_hash_page(vpn, MMU_PAGE_64K, ssize, flags);
+		old_pte &= ~H_PAGE_HASHPTE;
+		new_pte &= ~H_PAGE_HASHPTE;
 		goto htab_insert_hpte;
 	}
 	/*
-	 * Check for sub page valid and update
+	 * We are not tracking the validty of 4k entries seperately. Hence
+	 * If H_PAGE_HASHPTE is set, we always try an update.
 	 */
-	if (__rpte_sub_valid(rpte, subpg_index)) {
-		int ret;
-
-		hash = hpt_hash(vpn, shift, ssize);
-		ret = mmu_hash_ops.hash_updatepp(hash, rflags, vpn,
-						 MMU_PAGE_4K, MMU_PAGE_4K,
-						 ssize, flags);
-		/*
-		 * if we failed because typically the HPTE wasn't really here
-		 * we try an insertion.
-		 */
-		if (ret == -1)
-			goto htab_insert_hpte;
-
+	hash = hpt_hash(vpn, shift, ssize);
+	ret = mmu_hash_ops.hash_updatepp(hash, rflags, vpn,
+					 MMU_PAGE_4K, MMU_PAGE_4K,
+					 ssize, flags);
+	/*
+	 * if we failed because typically the HPTE wasn't really here
+	 * we try an insertion.
+	 */
+	if (ret != -1) {
 		*ptep = __pte(new_pte & ~H_PAGE_BUSY);
 		return 0;
 	}
-
+	/*
+	 * updatepp failed, hash table doesn't have an entry for this,
+	 * insert a new entry
+	 */
 htab_insert_hpte:
 	/*
 	 * handle H_PAGE_4K_PFN case
@@ -192,21 +155,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 				   MMU_PAGE_4K, MMU_PAGE_4K, old_pte);
 		return -1;
 	}
-	/*
-	 * Insert slot number & secondary bit in PTE second half,
-	 * clear H_PAGE_BUSY and set appropriate HPTE slot bit
-	 * Since we have H_PAGE_BUSY set on ptep, we can be sure
-	 * nobody is undating hidx.
-	 */
-	hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
-	rpte.hidx &= ~(0xfUL << (subpg_index << 2));
-	*hidxp = rpte.hidx  | (slot << (subpg_index << 2));
-	new_pte = mark_subptegroup_valid(new_pte, subpg_index);
 	new_pte |=  H_PAGE_HASHPTE;
-	/*
-	 * check __real_pte for details on matching smp_rmb()
-	 */
-	smp_wmb();
 	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
 	return 0;
 }
@@ -311,9 +260,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 					   MMU_PAGE_64K, MMU_PAGE_64K, old_pte);
 			return -1;
 		}
-		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | H_PAGE_HASHPTE;
-		new_pte |= (slot << H_PAGE_F_GIX_SHIFT) &
-			(H_PAGE_F_SECOND | H_PAGE_F_GIX);
+		new_pte = new_pte |  H_PAGE_HASHPTE;
 	}
 	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
 	return 0;
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 2eaded4680ae..f24ff28e9fab 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -741,7 +741,6 @@ static void native_flush_hash_range(unsigned long number, int local)
 	unsigned long hash, index, shift;
 	struct hash_pte *hptep;
 	unsigned long flags;
-	real_pte_t pte;
 	struct ppc64_tlb_batch *batch = this_cpu_ptr(&ppc64_tlb_batch);
 	unsigned long psize = batch->psize;
 	int ssize = batch->ssize;
@@ -755,9 +754,8 @@ static void native_flush_hash_range(unsigned long number, int local)
 
 	for (i = 0; i < number; i++) {
 		vpn = batch->vpn[i];
-		pte = batch->pte[i];
 
-		pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
+		pte_iterate_hashed_subpages(vpn, psize, index, shift) {
 			hash = hpt_hash(vpn, shift, ssize);
 			hptep = native_hpte_find(hash, vpn, psize, ssize);
 			if (!hptep)
@@ -773,10 +771,8 @@ static void native_flush_hash_range(unsigned long number, int local)
 		asm volatile("ptesync":::"memory");
 		for (i = 0; i < number; i++) {
 			vpn = batch->vpn[i];
-			pte = batch->pte[i];
 
-			pte_iterate_hashed_subpages(pte, psize,
-						    vpn, index, shift) {
+			pte_iterate_hashed_subpages(vpn, psize, index, shift) {
 				__tlbiel(vpn, psize, psize, ssize);
 			} pte_iterate_hashed_end();
 		}
@@ -790,10 +786,8 @@ static void native_flush_hash_range(unsigned long number, int local)
 		asm volatile("ptesync":::"memory");
 		for (i = 0; i < number; i++) {
 			vpn = batch->vpn[i];
-			pte = batch->pte[i];
 
-			pte_iterate_hashed_subpages(pte, psize,
-						    vpn, index, shift) {
+			pte_iterate_hashed_subpages(vpn, psize, index, shift) {
 				__tlbie(vpn, psize, psize, ssize);
 			} pte_iterate_hashed_end();
 		}
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 66f12b48f838..36a8c2dcb820 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -973,21 +973,8 @@ void __init hash__early_init_devtree(void)
 
 void __init hash__early_init_mmu(void)
 {
-	/*
-	 * We have code in __hash_page_64K() and elsewhere, which assumes it can
-	 * do the following:
-	 *   new_pte |= (slot << H_PAGE_F_GIX_SHIFT) & (H_PAGE_F_SECOND | H_PAGE_F_GIX);
-	 *
-	 * Where the slot number is between 0-15, and values of 8-15 indicate
-	 * the secondary bucket. For that code to work H_PAGE_F_SECOND and
-	 * H_PAGE_F_GIX must occupy four contiguous bits in the PTE, and
-	 * H_PAGE_F_SECOND must be placed above H_PAGE_F_GIX. Assert that here
-	 * with a BUILD_BUG_ON().
-	 */
-	BUILD_BUG_ON(H_PAGE_F_SECOND != (1ul  << (H_PAGE_F_GIX_SHIFT + 3)));
 
 	htab_init_page_sizes();
-
 	/*
 	 * initialize page table size
 	 */
@@ -1590,14 +1577,13 @@ static inline void tm_flush_hash_page(int local)
 /* WARNING: This is called from hash_low_64.S, if you change this prototype,
  *          do not forget to update the assembly call site !
  */
-void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
-		     unsigned long flags)
+void flush_hash_page(unsigned long vpn, int psize, int ssize, unsigned long flags)
 {
 	unsigned long hash, index, shift;
 	int local = flags & HPTE_LOCAL_UPDATE;
 
 	DBG_LOW("flush_hash_page(vpn=%016lx)\n", vpn);
-	pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
+	pte_iterate_hashed_subpages(vpn, psize, index, shift) {
 		hash = hpt_hash(vpn, shift, ssize);
 		DBG_LOW(" sub %ld: hash=%lx\n", index, hash);
 		/*
@@ -1679,8 +1665,8 @@ void flush_hash_range(unsigned long number, int local)
 			this_cpu_ptr(&ppc64_tlb_batch);
 
 		for (i = 0; i < number; i++)
-			flush_hash_page(batch->vpn[i], batch->pte[i],
-					batch->psize, batch->ssize, local);
+			flush_hash_page(batch->vpn[i], batch->psize,
+					batch->ssize, local);
 	}
 }
 
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index 4eb8c9d2f452..8aff8d17d91c 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -100,11 +100,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 					   mmu_psize, mmu_psize, old_pte);
 			return -1;
 		}
-
-		new_pte |= (slot << H_PAGE_F_GIX_SHIFT) &
-			(H_PAGE_F_SECOND | H_PAGE_F_GIX);
 	}
-
 	/*
 	 * No need to use ldarx/stdcx here
 	 */
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index 71cb2742bd16..8cb61f0c9608 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -50,7 +50,6 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 	unsigned long vsid;
 	unsigned int psize;
 	int ssize;
-	real_pte_t rpte;
 	int i;
 
 	i = batch->index;
@@ -91,14 +90,13 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 	}
 	WARN_ON(vsid == 0);
 	vpn = hpt_vpn(addr, vsid, ssize);
-	rpte = __real_pte(__pte(pte), ptep);
 
 	/*
 	 * Check if we have an active batch on this CPU. If not, just
 	 * flush now and return.
 	 */
 	if (!batch->active) {
-		flush_hash_page(vpn, rpte, psize, ssize, mm_is_thread_local(mm));
+		flush_hash_page(vpn, psize, ssize, mm_is_thread_local(mm));
 		put_cpu_var(ppc64_tlb_batch);
 		return;
 	}
@@ -123,7 +121,6 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 		batch->psize = psize;
 		batch->ssize = ssize;
 	}
-	batch->pte[i] = rpte;
 	batch->vpn[i] = vpn;
 	batch->index = ++i;
 	if (i >= PPC64_TLB_BATCH_NR)
@@ -148,8 +145,8 @@ void __flush_tlb_pending(struct ppc64_tlb_batch *batch)
 	if (cpumask_equal(mm_cpumask(batch->mm), tmp))
 		local = 1;
 	if (i == 1)
-		flush_hash_page(batch->vpn[0], batch->pte[0],
-				batch->psize, batch->ssize, local);
+		flush_hash_page(batch->vpn[0], batch->psize,
+				batch->ssize, local);
 	else
 		flush_hash_range(i, local);
 	batch->index = 0;
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index f4970bae5909..e28e62f6afba 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -616,7 +616,6 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
 	unsigned long param[PLPAR_HCALL9_BUFSIZE];
 	unsigned long index, shift, slot;
-	real_pte_t pte;
 	int psize, ssize, pix;
 
 	if (lock_tlbie)
@@ -627,8 +626,7 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 	pix = 0;
 	for (i = 0; i < number; i++) {
 		vpn = batch->vpn[i];
-		pte = batch->pte[i];
-		pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
+		pte_iterate_hashed_subpages(vpn, psize, index, shift) {
 			slot = pSeries_lpar_hpte_find(vpn, psize, ssize);
 			if (!firmware_has_feature(FW_FEATURE_BULK_REMOVE)) {
 				/*
-- 
2.13.3
