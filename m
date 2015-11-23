Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 806B61A1E3E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:35:11 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 20:35:11 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 49BDC2CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:35:08 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tANAZ0eV51314872
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:35:08 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANAYZ9j028352
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:34:35 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 09/10] powerpc/mm: Drop real_pte_t usage
Date: Mon, 23 Nov 2015 16:03:44 +0530
Message-Id: <1448274825-30289-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448274825-30289-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1448274825-30289-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we don't track 4k subpage slot details, get rid of real_pte

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h    | 15 +++--------
 arch/powerpc/include/asm/book3s/64/pgtable.h     | 33 ++++++++++--------------
 arch/powerpc/include/asm/nohash/64/pgtable-64k.h |  3 +--
 arch/powerpc/include/asm/page.h                  | 15 -----------
 arch/powerpc/include/asm/tlbflush.h              |  4 +--
 arch/powerpc/mm/hash64_64k.c                     | 29 ++++++---------------
 arch/powerpc/mm/hash_native_64.c                 |  4 +--
 arch/powerpc/mm/hash_utils_64.c                  |  4 +--
 arch/powerpc/mm/init_64.c                        |  3 +--
 arch/powerpc/mm/tlb_hash64.c                     | 15 +++++------
 arch/powerpc/platforms/pseries/lpar.c            |  4 +--
 11 files changed, 43 insertions(+), 86 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 19e0afb36fa8..5f18801ae722 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -43,8 +43,7 @@
  */
 #define PTE_FRAG_NR	32
 /*
- * We use a 2K PTE page fragment and another 4K for storing
- * real_pte_t hash index. Rounding the entire thing to 8K
+ * We use a 2K PTE page fragment
  */
 #define PTE_FRAG_SIZE_SHIFT  11
 #define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
@@ -58,21 +57,15 @@
 #define PUD_MASKED_BITS		0x1ff
 
 #ifndef __ASSEMBLY__
-
 /*
  * With 64K pages on hash table, we have a special PTE format that
  * uses a second "half" of the page table to encode sub-page information
  * in order to deal with 64K made of 4K HW pages. Thus we override the
  * generic accessors and iterators here
  */
-#define __real_pte __real_pte
-extern real_pte_t __real_pte(unsigned long addr, pte_t pte, pte_t *ptep);
-extern unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long hash,
-				    unsigned long vpn, int ssize, bool *valid);
-static inline pte_t __rpte_to_pte(real_pte_t rpte)
-{
-	return rpte.pte;
-}
+#define pte_to_hidx pte_to_hidx
+extern unsigned long pte_to_hidx(pte_t pte, unsigned long hash,
+				 unsigned long vpn, int ssize, bool *valid);
 /*
  * Trick: we set __end to va + 64k, which happens works for
  * a 16M page as well as we want only one iteration
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 63120d4025d7..74be69c8e5de 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -35,45 +35,40 @@
 #define __HAVE_ARCH_PTE_SPECIAL
 
 #ifndef __ASSEMBLY__
-
 /*
  * This is the default implementation of various PTE accessors, it's
  * used in all cases except Book3S with 64K pages where we have a
  * concept of sub-pages
  */
-#ifndef __real_pte
-
-#ifdef CONFIG_STRICT_MM_TYPECHECKS
-#define __real_pte(a,e,p)	((real_pte_t){(e)})
-#define __rpte_to_pte(r)	((r).pte)
-#else
-#define __real_pte(a,e,p)	(e)
-#define __rpte_to_pte(r)	(__pte(r))
-#endif
-static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long hash,
-					   unsigned long vpn, int ssize, bool *valid)
+#ifndef pte_to_hidx
+static inline unsigned long pte_to_hidx(pte_t pte, unsigned long hash,
+					unsigned long vpn, int ssize, bool *valid)
 {
 	*valid = false;
-	if (pte_val(__rpte_to_pte(rpte)) & _PAGE_HASHPTE) {
+	if (pte_val(pte) & _PAGE_HASHPTE) {
 		*valid = true;
-		return (pte_val(__rpte_to_pte(rpte)) >> _PAGE_F_GIX_SHIFT) & 0xf;
+		return (pte_val(pte) >> _PAGE_F_GIX_SHIFT) & 0xf;
 	}
 	return 0;
 }
+#define pte_to_hidx pte_to_hidx
+#endif
 
-#define pte_iterate_hashed_subpages(vpn, psize, shift)		\
-	do {							\
-		shift = mmu_psize_defs[psize].shift;		\
+#ifndef pte_iterate_hashed_subpages
+#define pte_iterate_hashed_subpages(vpn, psize, shift)	\
+	do {						\
+		shift = mmu_psize_defs[psize].shift;	\
 
 #define pte_iterate_hashed_end() } while(0)
+#endif
 
 /*
  * We expect this to be called only for user addresses or kernel virtual
  * addresses other than the linear mapping.
  */
+#ifndef pte_pagesize_index
 #define pte_pagesize_index(mm, addr, pte)	MMU_PAGE_4K
-
-#endif /* __real_pte */
+#endif
 
 static inline void pmd_set(pmd_t *pmdp, unsigned long val)
 {
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable-64k.h b/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
index dbd9de9264c2..0f075799ae97 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
@@ -14,8 +14,7 @@
  */
 #define PTE_FRAG_NR	32
 /*
- * We use a 2K PTE page fragment and another 4K for storing
- * real_pte_t hash index. Rounding the entire thing to 8K
+ * We use a 2K PTE page fragment
  */
 #define PTE_FRAG_SIZE_SHIFT  11
 #define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index bbdf9e6cc8b1..ac30cfd6f9c1 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -291,14 +291,6 @@ static inline pte_basic_t pte_val(pte_t x)
 	return x.pte;
 }
 
-/* 64k pages additionally define a bigger "real PTE" type that gathers
- * the "second half" part of the PTE for pseudo 64k pages
- */
-#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC_STD_MMU_64)
-typedef struct { pte_t pte; } real_pte_t;
-#else
-typedef struct { pte_t pte; } real_pte_t;
-#endif
 
 /* PMD level */
 #ifdef CONFIG_PPC64
@@ -346,13 +338,6 @@ static inline pte_basic_t pte_val(pte_t pte)
 	return pte;
 }
 
-#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC_STD_MMU_64)
-typedef struct { pte_t pte; } real_pte_t;
-#else
-typedef pte_t real_pte_t;
-#endif
-
-
 #ifdef CONFIG_PPC64
 typedef unsigned long pmd_t;
 #define __pmd(x)	(x)
diff --git a/arch/powerpc/include/asm/tlbflush.h b/arch/powerpc/include/asm/tlbflush.h
index 23d351ca0303..1a4824fabcad 100644
--- a/arch/powerpc/include/asm/tlbflush.h
+++ b/arch/powerpc/include/asm/tlbflush.h
@@ -94,7 +94,7 @@ struct ppc64_tlb_batch {
 	int			active;
 	unsigned long		index;
 	struct mm_struct	*mm;
-	real_pte_t		pte[PPC64_TLB_BATCH_NR];
+	pte_t			pte[PPC64_TLB_BATCH_NR];
 	unsigned long		vpn[PPC64_TLB_BATCH_NR];
 	unsigned int		psize;
 	int			ssize;
@@ -124,7 +124,7 @@ static inline void arch_leave_lazy_mmu_mode(void)
 #define arch_flush_lazy_mmu_mode()      do {} while (0)
 
 
-extern void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize,
+extern void flush_hash_page(unsigned long vpn, pte_t pte, int psize,
 			    int ssize, unsigned long flags);
 extern void flush_hash_range(unsigned long number, int local);
 extern void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index 983574e6f8d5..c0bed3d01c1c 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -16,23 +16,14 @@
 #include <asm/machdep.h>
 #include <asm/mmu.h>
 
-real_pte_t __real_pte(unsigned long addr, pte_t pte, pte_t *ptep)
-{
-	real_pte_t rpte;
-
-	rpte.pte = pte;
-	return rpte;
-}
-
-unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long hash,
-			     unsigned long vpn, int ssize, bool *valid)
+unsigned long pte_to_hidx(pte_t pte, unsigned long hash,
+			  unsigned long vpn, int ssize, bool *valid)
 {
 	long slot;
 	unsigned long want_v;
 
 	*valid = false;
-	if ((pte_val(rpte.pte) & _PAGE_COMBO)) {
-
+	if ((pte_val(pte) & _PAGE_COMBO)) {
 		want_v = hpte_encode_avpn(vpn, MMU_PAGE_4K, ssize);
 		slot = ppc_md.get_hpte_slot(want_v, hash);
 		if (slot < 0)
@@ -40,9 +31,9 @@ unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long hash,
 		*valid = true;
 		return slot;
 	}
-	if (pte_val(rpte.pte) & _PAGE_HASHPTE) {
+	if (pte_val(pte) & _PAGE_HASHPTE) {
 		*valid = true;
-		return (pte_val(rpte.pte) >> _PAGE_F_GIX_SHIFT) & 0xf;
+		return (pte_val(pte) >> _PAGE_F_GIX_SHIFT) & 0xf;
 	}
 	return 0;
 }
@@ -52,7 +43,6 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		   int ssize, int subpg_prot)
 {
 	bool valid_slot;
-	real_pte_t rpte;
 	unsigned long hpte_group;
 	unsigned int subpg_index;
 	unsigned long rflags, pa, hidx;
@@ -101,10 +91,6 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 
 	subpg_index = (ea & (PAGE_SIZE - 1)) >> shift;
 	vpn  = hpt_vpn(ea, vsid, ssize);
-	if (!(old_pte & _PAGE_COMBO))
-		rpte = __real_pte(ea, __pte(old_pte | _PAGE_COMBO), ptep);
-	else
-		rpte = __real_pte(ea, __pte(old_pte), ptep);
 	/*
 	 *None of the sub 4k page is hashed
 	 */
@@ -115,7 +101,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	 * as a 64k HW page, and invalidate the 64k HPTE if so.
 	 */
 	if (!(old_pte & _PAGE_COMBO)) {
-		flush_hash_page(vpn, rpte, MMU_PAGE_64K, ssize, flags);
+		flush_hash_page(vpn, __pte(old_pte), MMU_PAGE_64K, ssize, flags);
 		old_pte &= ~_PAGE_HASHPTE | _PAGE_F_GIX | _PAGE_F_SECOND;
 		goto htab_insert_hpte;
 	}
@@ -123,7 +109,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	 * Check for sub page valid and update
 	 */
 	hash = hpt_hash(vpn, shift, ssize);
-	hidx = __rpte_to_hidx(rpte, hash, vpn, ssize, &valid_slot);
+	hidx = pte_to_hidx(__pte(old_pte), hash, vpn, ssize, &valid_slot);
 	if (valid_slot) {
 		int ret;
 
@@ -205,6 +191,7 @@ repeat:
 	new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE | _PAGE_COMBO;
 	/*
 	 * check __real_pte for details on matching smp_rmb()
+	 * FIXME!! We can possibly get rid of this ?
 	 */
 	smp_wmb();
 	*ptep = __pte(new_pte & ~_PAGE_BUSY);
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 15c92279953d..9f7f6673e726 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -650,7 +650,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 	unsigned long hpte_v;
 	unsigned long want_v;
 	unsigned long flags;
-	real_pte_t pte;
+	pte_t pte;
 	struct ppc64_tlb_batch *batch = this_cpu_ptr(&ppc64_tlb_batch);
 	unsigned long psize = batch->psize;
 	int ssize = batch->ssize;
@@ -666,7 +666,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 
 		pte_iterate_hashed_subpages(vpn, psize, shift) {
 			hash = hpt_hash(vpn, shift, ssize);
-			hidx = __rpte_to_hidx(pte, hash, vpn, ssize, &valid_slot);
+			hidx = pte_to_hidx(pte, hash, vpn, ssize, &valid_slot);
 			if (!valid_slot)
 				continue;
 			if (hidx & _PTEIDX_SECONDARY)
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 99a9de74993e..80e71ccc9474 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1294,7 +1294,7 @@ out_exit:
 /* WARNING: This is called from hash_low_64.S, if you change this prototype,
  *          do not forget to update the assembly call site !
  */
-void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
+void flush_hash_page(unsigned long vpn, pte_t pte, int psize, int ssize,
 		     unsigned long flags)
 {
 	bool valid_slot;
@@ -1304,7 +1304,7 @@ void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
 	DBG_LOW("flush_hash_page(vpn=%016lx)\n", vpn);
 	pte_iterate_hashed_subpages(vpn, psize, shift) {
 		hash = hpt_hash(vpn, shift, ssize);
-		hidx = __rpte_to_hidx(pte, hash, vpn, ssize, &valid_slot);
+		hidx = pte_to_hidx(pte, hash, vpn, ssize, &valid_slot);
 		if (!valid_slot)
 			continue;
 		if (hidx & _PTEIDX_SECONDARY)
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 379a6a90644b..6478c4970c2d 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -95,8 +95,7 @@ struct kmem_cache *pgtable_cache[MAX_PGTABLE_INDEX_SIZE];
 /*
  * Create a kmem_cache() for pagetables.  This is not used for PTE
  * pages - they're linked to struct page, come from the normal free
- * pages pool and have a different entry size (see real_pte_t) to
- * everything else.  Caches created by this function are used for all
+ * pages pool. Caches created by this function are used for all
  * the higher level pagetables, and for hugepage pagetables.
  */
 void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index dd0fd1783bcc..5fa78b1ab7d3 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -41,14 +41,14 @@ DEFINE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
  * batch on it.
  */
 void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
-		     pte_t *ptep, unsigned long pte, int huge)
+		     pte_t *ptep, unsigned long ptev, int huge)
 {
 	unsigned long vpn;
 	struct ppc64_tlb_batch *batch = &get_cpu_var(ppc64_tlb_batch);
 	unsigned long vsid;
 	unsigned int psize;
 	int ssize;
-	real_pte_t rpte;
+	pte_t pte;
 	int i;
 
 	i = batch->index;
@@ -67,10 +67,10 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 		addr &= ~((1UL << mmu_psize_defs[psize].shift) - 1);
 #else
 		BUG();
-		psize = pte_pagesize_index(mm, addr, pte); /* shutup gcc */
+		psize = pte_pagesize_index(mm, addr, ptev); /* shutup gcc */
 #endif
 	} else {
-		psize = pte_pagesize_index(mm, addr, pte);
+		psize = pte_pagesize_index(mm, addr, ptev);
 		/* Mask the address for the standard page size.  If we
 		 * have a 64k page kernel, but the hardware does not
 		 * support 64k pages, this might be different from the
@@ -89,8 +89,7 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 	}
 	WARN_ON(vsid == 0);
 	vpn = hpt_vpn(addr, vsid, ssize);
-	rpte = __real_pte(addr, __pte(pte), ptep);
-
+	pte = __pte(ptev);
 	/*
 	 * Check if we have an active batch on this CPU. If not, just
 	 * flush now and return. For now, we don global invalidates
@@ -98,7 +97,7 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 	 * and decide to use local invalidates instead...
 	 */
 	if (!batch->active) {
-		flush_hash_page(vpn, rpte, psize, ssize, 0);
+		flush_hash_page(vpn, pte, psize, ssize, 0);
 		put_cpu_var(ppc64_tlb_batch);
 		return;
 	}
@@ -123,7 +122,7 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 		batch->psize = psize;
 		batch->ssize = ssize;
 	}
-	batch->pte[i] = rpte;
+	batch->pte[i] = pte;
 	batch->vpn[i] = vpn;
 	batch->index = ++i;
 	if (i >= PPC64_TLB_BATCH_NR)
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index e3c20ea64ec8..1708cab20fc8 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -535,7 +535,7 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
 	unsigned long param[9];
 	unsigned long hash, shift, hidx, slot;
-	real_pte_t pte;
+	pte_t pte;
 	int psize, ssize;
 
 	if (lock_tlbie)
@@ -551,7 +551,7 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 		pte = batch->pte[i];
 		pte_iterate_hashed_subpages(vpn, psize, shift) {
 			hash = hpt_hash(vpn, shift, ssize);
-			hidx = __rpte_to_hidx(pte, hash, vpn, ssize, &valid_slot);
+			hidx = pte_to_hidx(pte, hash, vpn, ssize, &valid_slot);
 			if (!valid_slot)
 				continue;
 			if (hidx & _PTEIDX_SECONDARY)
-- 
2.5.0
