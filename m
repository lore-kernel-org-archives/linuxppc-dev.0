Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDfz4013DzDqxR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 04:52:48 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id 14so248060qtn.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 11:52:47 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, linuxram@us.ibm.com,
 mhocko@kernel.org
Subject: [PATCH 6/6] powerpc: use helper functions to get and set hash slots
Date: Fri, 21 Jul 2017 11:52:09 -0700
Message-Id: <1500663129-10615-7-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1500663129-10615-1-git-send-email-linuxram@us.ibm.com>
References: <1500663129-10615-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

replace redundant code in __hash_page_64K(), __hash_page_huge(),
__hash_page_4K(), __hash_page_4K() and flush_hash_page()   with
helper functions pte_get_hash_gslot() and   pte_set_hash_slot()

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/mm/hash64_4k.c          |   14 +++-----
 arch/powerpc/mm/hash64_64k.c         |   58 +++++++--------------------------
 arch/powerpc/mm/hash_utils_64.c      |   13 ++-----
 arch/powerpc/mm/hugetlbpage-hash64.c |   28 ++--------------
 4 files changed, 27 insertions(+), 86 deletions(-)

diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
index 6fa450c..a1eebc1 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -20,6 +20,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		   pte_t *ptep, unsigned long trap, unsigned long flags,
 		   int ssize, int subpg_prot)
 {
+	real_pte_t rpte;
 	unsigned long hpte_group;
 	unsigned long rflags, pa;
 	unsigned long old_pte, new_pte;
@@ -54,6 +55,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	 * need to add in 0x1 if it's a read-only user page
 	 */
 	rflags = htab_convert_pte_flags(new_pte);
+	rpte = __real_pte(__pte(old_pte), ptep);
 
 	if (cpu_has_feature(CPU_FTR_NOEXECUTE) &&
 	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
@@ -64,13 +66,10 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		/*
 		 * There MIGHT be an HPTE for this pte
 		 */
-		hash = hpt_hash(vpn, shift, ssize);
-		if (old_pte & H_PAGE_F_SECOND)
-			hash = ~hash;
-		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
+		unsigned long gslot = pte_get_hash_gslot(vpn, shift,
+						ssize, rpte, 0);
 
-		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, MMU_PAGE_4K,
+		if (mmu_hash_ops.hpte_updatepp(gslot, rflags, vpn, MMU_PAGE_4K,
 					       MMU_PAGE_4K, ssize, flags) == -1)
 			old_pte &= ~_PAGE_HPTEFLAGS;
 	}
@@ -118,8 +117,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 			return -1;
 		}
 		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | H_PAGE_HASHPTE;
-		new_pte |= (slot << H_PAGE_F_GIX_SHIFT) &
-			(H_PAGE_F_SECOND | H_PAGE_F_GIX);
+		new_pte |= pte_set_hash_slot(ptep, rpte, 0, slot);
 	}
 	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
 	return 0;
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index e922a70..6c1c87a 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -39,9 +39,8 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 {
 	real_pte_t rpte;
 	unsigned long hpte_group;
-	unsigned long *hidxp;
 	unsigned int subpg_index;
-	unsigned long rflags, pa, hidx;
+	unsigned long rflags, pa;
 	unsigned long old_pte, new_pte, subpg_pte;
 	unsigned long vpn, hash, slot, gslot;
 	unsigned long shift = mmu_psize_defs[MMU_PAGE_4K].shift;
@@ -114,18 +113,13 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	if (__rpte_sub_valid(rpte, subpg_index)) {
 		int ret;
 
-		hash = hpt_hash(vpn, shift, ssize);
-		hidx = __rpte_to_hidx(rpte, subpg_index);
-		if (hidx & _PTEIDX_SECONDARY)
-			hash = ~hash;
-		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		slot += hidx & _PTEIDX_GROUP_IX;
-
-		ret = mmu_hash_ops.hpte_updatepp(slot, rflags, vpn,
+		gslot = pte_get_hash_gslot(vpn, shift, ssize, rpte,
+				subpg_index);
+		ret = mmu_hash_ops.hpte_updatepp(gslot, rflags, vpn,
 						 MMU_PAGE_4K, MMU_PAGE_4K,
 						 ssize, flags);
 		/*
-		 *if we failed because typically the HPTE wasn't really here
+		 * if we failed because typically the HPTE wasn't really here
 		 * we try an insertion.
 		 */
 		if (ret == -1)
@@ -221,20 +215,10 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
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
-	/*
-	 * check __real_pte for details on matching smp_rmb()
-	 */
-	smp_wmb();
-	new_pte |=  H_PAGE_HASHPTE;
+
+	new_pte |= pte_set_hash_slot(ptep, rpte, subpg_index, slot);
+	new_pte |= H_PAGE_HASHPTE;
+
 	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
 	return 0;
 }
@@ -244,7 +228,6 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		    unsigned long flags, int ssize)
 {
 	real_pte_t rpte;
-	unsigned long *hidxp;
 	unsigned long hpte_group;
 	unsigned long rflags, pa;
 	unsigned long old_pte, new_pte;
@@ -289,18 +272,12 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 
 	vpn  = hpt_vpn(ea, vsid, ssize);
 	if (unlikely(old_pte & H_PAGE_HASHPTE)) {
-		unsigned long hash, slot, hidx;
-
-		hash = hpt_hash(vpn, shift, ssize);
-		hidx = __rpte_to_hidx(rpte, 0);
-		if (hidx & _PTEIDX_SECONDARY)
-			hash = ~hash;
-		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		slot += hidx & _PTEIDX_GROUP_IX;
+		unsigned long gslot;
 		/*
 		 * There MIGHT be an HPTE for this pte
 		 */
-		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, MMU_PAGE_64K,
+		gslot = pte_get_hash_gslot(vpn, shift, ssize, rpte, 0);
+		if (mmu_hash_ops.hpte_updatepp(gslot, rflags, vpn, MMU_PAGE_64K,
 					       MMU_PAGE_64K, ssize,
 					       flags) == -1)
 			old_pte &= ~_PAGE_HPTEFLAGS;
@@ -350,17 +327,8 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 			return -1;
 		}
 
-		/*
-		 * Insert slot number & secondary bit in PTE second half.
-		 */
-		hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
-		rpte.hidx &= ~(0xfUL);
-		*hidxp = rpte.hidx  | (slot & 0xfUL);
-		/*
-		 * check __real_pte for details on matching smp_rmb()
-		 */
-		smp_wmb();
 		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | H_PAGE_HASHPTE;
+		new_pte |= pte_set_hash_slot(ptep, rpte, 0, slot);
 	}
 	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
 	return 0;
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index d3604da..d863696 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1615,23 +1615,18 @@ unsigned long pte_get_hash_gslot(unsigned long vpn, unsigned long shift,
 void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
 		     unsigned long flags)
 {
-	unsigned long hash, index, shift, hidx, slot;
+	unsigned long index, shift, gslot;
 	int local = flags & HPTE_LOCAL_UPDATE;
 
 	DBG_LOW("flush_hash_page(vpn=%016lx)\n", vpn);
 	pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
-		hash = hpt_hash(vpn, shift, ssize);
-		hidx = __rpte_to_hidx(pte, index);
-		if (hidx & _PTEIDX_SECONDARY)
-			hash = ~hash;
-		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		slot += hidx & _PTEIDX_GROUP_IX;
-		DBG_LOW(" sub %ld: hash=%lx, hidx=%lx\n", index, slot, hidx);
+		gslot = pte_get_hash_gslot(vpn, shift, ssize, pte, index);
+		DBG_LOW(" sub %ld: gslot=%lx\n", index, gslot);
 		/*
 		 * We use same base page size and actual psize, because we don't
 		 * use these functions for hugepage
 		 */
-		mmu_hash_ops.hpte_invalidate(slot, vpn, psize, psize,
+		mmu_hash_ops.hpte_invalidate(gslot, vpn, psize, psize,
 					     ssize, local);
 	} pte_iterate_hashed_end();
 
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index 5964b6d..e6dcd50 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -23,9 +23,6 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		     int ssize, unsigned int shift, unsigned int mmu_psize)
 {
 	real_pte_t rpte;
-#ifdef CONFIG_PPC_64K_PAGES
-	unsigned long *hidxp;
-#endif /* CONFIG_PPC_64K_PAGES */
 	unsigned long vpn;
 	unsigned long old_pte, new_pte;
 	unsigned long rflags, pa, sz;
@@ -76,16 +73,10 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 	/* Check if pte already has an hpte (case 2) */
 	if (unlikely(old_pte & H_PAGE_HASHPTE)) {
 		/* There MIGHT be an HPTE for this pte */
-		unsigned long hash, slot, hidx;
+		unsigned long gslot;
 
-		hash = hpt_hash(vpn, shift, ssize);
-		hidx = __rpte_to_hidx(rpte, 0);
-		if (hidx & _PTEIDX_SECONDARY)
-			hash = ~hash;
-		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		slot += hidx & _PTEIDX_GROUP_IX;
-
-		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, mmu_psize,
+		gslot = pte_get_hash_gslot(vpn, shift, ssize, rpte, 0);
+		if (mmu_hash_ops.hpte_updatepp(gslot, rflags, vpn, mmu_psize,
 					       mmu_psize, ssize, flags) == -1)
 			old_pte &= ~_PAGE_HPTEFLAGS;
 	}
@@ -112,18 +103,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 			return -1;
 		}
 
-#ifdef CONFIG_PPC_64K_PAGES
-		/*
-		 * Insert slot number & secondary bit in PTE second half.
-		 */
-		hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
-		rpte.hidx &= ~(0xfUL);
-		*hidxp = rpte.hidx  | (slot & 0xfUL);
-		/*
-		 * check __real_pte for details on matching smp_rmb()
-		 */
-		smp_wmb();
-#endif /* CONFIG_PPC_64K_PAGES */
+		new_pte |= pte_set_hash_slot(ptep, rpte, 0, slot);
 	}
 
 	/*
-- 
1.7.1
