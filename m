Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD5B21A02C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 07:12:50 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 21 Oct 2015 01:42:48 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id F257B125805B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 01:42:35 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9KKCjgl5701890
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 01:42:45 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9KKCjxN006435
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 01:42:45 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 4/7] powerpc/mm: Don't track 4k subpage information with
 64k linux page size
Date: Wed, 21 Oct 2015 01:42:30 +0530
Message-Id: <1445371953-9627-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1445371953-9627-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1445371953-9627-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We search the hash table to find the slot information. This slows down
the lookup, but we do that only for 4k subpage config

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 33 +--------------
 arch/powerpc/include/asm/machdep.h            |  2 +
 arch/powerpc/include/asm/page.h               |  4 +-
 arch/powerpc/mm/hash64_64k.c                  | 59 ++++++++++++++++++++-------
 arch/powerpc/mm/hash_native_64.c              | 23 ++++++++++-
 arch/powerpc/mm/hash_utils_64.c               |  5 ++-
 arch/powerpc/mm/pgtable_64.c                  |  6 ++-
 arch/powerpc/platforms/pseries/lpar.c         | 17 +++++++-
 8 files changed, 96 insertions(+), 53 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 681657cabbe4..5062c6d423fd 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -67,51 +67,22 @@
  */
 #define __real_pte __real_pte
 extern real_pte_t __real_pte(unsigned long addr, pte_t pte, pte_t *ptep);
-static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
-{
-	if ((pte_val(rpte.pte) & _PAGE_COMBO))
-		return (unsigned long) rpte.hidx[index] >> 4;
-	return (pte_val(rpte.pte) >> _PAGE_F_GIX_SHIFT) & 0xf;
-}
-
+extern unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long hash,
+				    unsigned long vpn, int ssize, bool *valid);
 static inline pte_t __rpte_to_pte(real_pte_t rpte)
 {
 	return rpte.pte;
 }
 /*
- * we look at the second half of the pte page to determine whether
- * the sub 4k hpte is valid. We use 8 bits per each index, and we have
- * 16 index mapping full 64K page. Hence for each
- * 64K linux page we use 128 bit from the second half of pte page.
- * The encoding in the second half of the page is as below:
- * [ index 15 ] .........................[index 0]
- * [bit 127 ..................................bit 0]
- * fomat of each index
- * bit 7 ........ bit0
- * [one bit secondary][ 3 bit hidx][1 bit valid][000]
- */
-static inline bool __rpte_sub_valid(real_pte_t rpte, unsigned long index)
-{
-	unsigned char index_val = rpte.hidx[index];
-
-	if ((index_val >> 3) & 0x1)
-		return true;
-	return false;
-}
-
-/*
  * Trick: we set __end to va + 64k, which happens works for
  * a 16M page as well as we want only one iteration
  */
 #define pte_iterate_hashed_subpages(rpte, psize, vpn, index, shift)	\
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
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index cab6753f1be5..40df21982ae1 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -61,6 +61,8 @@ struct machdep_calls {
 					       unsigned long addr,
 					       unsigned char *hpte_slot_array,
 					       int psize, int ssize, int local);
+
+	unsigned long (*get_hpte_v)(unsigned long slot);
 	/* special for kexec, to be called in real mode, linear mapping is
 	 * destroyed as well */
 	void		(*hpte_clear_all)(void);
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index f63b2761cdd0..bbdf9e6cc8b1 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -295,7 +295,7 @@ static inline pte_basic_t pte_val(pte_t x)
  * the "second half" part of the PTE for pseudo 64k pages
  */
 #if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC_STD_MMU_64)
-typedef struct { pte_t pte; unsigned char *hidx; } real_pte_t;
+typedef struct { pte_t pte; } real_pte_t;
 #else
 typedef struct { pte_t pte; } real_pte_t;
 #endif
@@ -347,7 +347,7 @@ static inline pte_basic_t pte_val(pte_t pte)
 }
 
 #if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC_STD_MMU_64)
-typedef struct { pte_t pte; unsigned char *hidx; } real_pte_t;
+typedef struct { pte_t pte; } real_pte_t;
 #else
 typedef pte_t real_pte_t;
 #endif
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index 84867a1491a2..e063895694e9 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -18,29 +18,59 @@
 
 real_pte_t __real_pte(unsigned long addr, pte_t pte, pte_t *ptep)
 {
-	int indx;
 	real_pte_t rpte;
-	pte_t *pte_headp;
 
 	rpte.pte = pte;
-	rpte.hidx = NULL;
-	if (pte_val(pte) & _PAGE_COMBO) {
-		indx = pte_index(addr);
-		pte_headp = ptep - indx;
+	return rpte;
+}
+
+unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long hash,
+			     unsigned long vpn, int ssize, bool *valid)
+{
+	int i;
+	unsigned long slot;
+	unsigned long want_v, hpte_v;
+	*valid = false;
+	if ((pte_val(rpte.pte) & _PAGE_COMBO)) {
 		/*
-		 * Make sure we order the hidx load against the _PAGE_COMBO
-		 * check. The store side ordering is done in __hash_page_4K
+		 * try primary first
 		 */
-		smp_rmb();
-		rpte.hidx = (unsigned char *)(pte_headp + PTRS_PER_PTE) + (16 * indx);
+		want_v = hpte_encode_avpn(vpn, MMU_PAGE_4K, ssize);
+		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+		for (i = 0; i < HPTES_PER_GROUP; i++) {
+			hpte_v = ppc_md.get_hpte_v(slot);
+			if (HPTE_V_COMPARE(hpte_v, want_v) && (hpte_v & HPTE_V_VALID)) {
+				/* HPTE matches */
+				*valid = true;
+				return i;
+			}
+			++slot;
+		}
+		/* try secondary */
+		slot = (~hash & htab_hash_mask) * HPTES_PER_GROUP;
+		for (i = 0; i < HPTES_PER_GROUP; i++) {
+			hpte_v = ppc_md.get_hpte_v(slot);
+			if (HPTE_V_COMPARE(hpte_v, want_v) && (hpte_v & HPTE_V_VALID)) {
+				*valid = true;
+				/* Add secondary bit */
+				return i | (1 << 3);
+			}
+			++slot;
+		}
+		return 0;
 	}
-	return rpte;
+	if (pte_val(rpte.pte) & _PAGE_HASHPTE) {
+		*valid = true;
+		return (pte_val(rpte.pte) >> _PAGE_F_GIX_SHIFT) & 0xf;
+	}
+	return 0;
 }
 
 int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		   pte_t *ptep, unsigned long trap, unsigned long flags,
 		   int ssize, int subpg_prot)
 {
+	bool valid_slot;
 	real_pte_t rpte;
 	unsigned long hpte_group;
 	unsigned int subpg_index;
@@ -111,11 +141,11 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	/*
 	 * Check for sub page valid and update
 	 */
-	if (__rpte_sub_valid(rpte, subpg_index)) {
+	hash = hpt_hash(vpn, shift, ssize);
+	hidx = __rpte_to_hidx(rpte, hash, vpn, ssize, &valid_slot);
+	if (valid_slot) {
 		int ret;
 
-		hash = hpt_hash(vpn, shift, ssize);
-		hidx = __rpte_to_hidx(rpte, subpg_index);
 		if (hidx & _PTEIDX_SECONDARY)
 			hash = ~hash;
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
@@ -191,7 +221,6 @@ repeat:
 	 * Since we have _PAGE_BUSY set on ptep, we can be sure
 	 * nobody is undating hidx.
 	 */
-	rpte.hidx[subpg_index] = (unsigned char)(slot << 4 | 0x1 << 3);
 	new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE | _PAGE_COMBO;
 	/*
 	 * check __real_pte for details on matching smp_rmb()
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 538390638b63..ca747ae19c76 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -660,12 +660,16 @@ static void native_flush_hash_range(unsigned long number, int local)
 	local_irq_save(flags);
 
 	for (i = 0; i < number; i++) {
+		bool valid_slot;
+
 		vpn = batch->vpn[i];
 		pte = batch->pte[i];
 
 		pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
 			hash = hpt_hash(vpn, shift, ssize);
-			hidx = __rpte_to_hidx(pte, index);
+			hidx = __rpte_to_hidx(pte, hash, vpn, ssize, &valid_slot);
+			if (!valid_slot)
+				continue;
 			if (hidx & _PTEIDX_SECONDARY)
 				hash = ~hash;
 			slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
@@ -691,6 +695,9 @@ static void native_flush_hash_range(unsigned long number, int local)
 
 			pte_iterate_hashed_subpages(pte, psize,
 						    vpn, index, shift) {
+				/*
+				 * We are not looking at subpage valid here
+				 */
 				__tlbiel(vpn, psize, psize, ssize);
 			} pte_iterate_hashed_end();
 		}
@@ -708,6 +715,9 @@ static void native_flush_hash_range(unsigned long number, int local)
 
 			pte_iterate_hashed_subpages(pte, psize,
 						    vpn, index, shift) {
+				/*
+				 * We are not looking at subpage valid here
+				 */
 				__tlbie(vpn, psize, psize, ssize);
 			} pte_iterate_hashed_end();
 		}
@@ -720,6 +730,16 @@ static void native_flush_hash_range(unsigned long number, int local)
 	local_irq_restore(flags);
 }
 
+unsigned long native_get_hpte_v(unsigned long slot)
+{
+	unsigned long hpte_v;
+	struct hash_pte *hptep;
+
+	hptep = htab_address + slot;
+	hpte_v = be64_to_cpu(hptep->v);
+	return hpte_v;
+}
+
 void __init hpte_init_native(void)
 {
 	ppc_md.hpte_invalidate	= native_hpte_invalidate;
@@ -730,4 +750,5 @@ void __init hpte_init_native(void)
 	ppc_md.hpte_clear_all	= native_hpte_clear;
 	ppc_md.flush_hash_range = native_flush_hash_range;
 	ppc_md.hugepage_invalidate   = native_hugepage_invalidate;
+	ppc_md.get_hpte_v	= native_get_hpte_v;
 }
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 3d261bc6fef8..f3d113b32c5e 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1297,13 +1297,16 @@ out_exit:
 void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
 		     unsigned long flags)
 {
+	bool valid_slot;
 	unsigned long hash, index, shift, hidx, slot;
 	int local = flags & HPTE_LOCAL_UPDATE;
 
 	DBG_LOW("flush_hash_page(vpn=%016lx)\n", vpn);
 	pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
 		hash = hpt_hash(vpn, shift, ssize);
-		hidx = __rpte_to_hidx(pte, index);
+		hidx = __rpte_to_hidx(pte, hash, vpn, ssize, &valid_slot);
+		if (!valid_slot)
+			continue;
 		if (hidx & _PTEIDX_SECONDARY)
 			hash = ~hash;
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index ea6bc31debb0..835c6a4ded90 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -417,9 +417,11 @@ pte_t *page_table_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel)
 
 	pte = get_from_cache(mm);
 	if (pte)
-		return pte;
+		goto out;
 
-	return __alloc_for_cache(mm, kernel);
+	pte = __alloc_for_cache(mm, kernel);
+out:
+	return pte;
 }
 
 void page_table_free(struct mm_struct *mm, unsigned long *table, int kernel)
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 6d46547871aa..c7c6bde41293 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -545,11 +545,15 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 	ssize = batch->ssize;
 	pix = 0;
 	for (i = 0; i < number; i++) {
+		bool valid_slot;
+
 		vpn = batch->vpn[i];
 		pte = batch->pte[i];
 		pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
 			hash = hpt_hash(vpn, shift, ssize);
-			hidx = __rpte_to_hidx(pte, index);
+			hidx = __rpte_to_hidx(pte, hash, vpn, ssize, &valid_slot);
+			if (!valid_slot)
+				continue;
 			if (hidx & _PTEIDX_SECONDARY)
 				hash = ~hash;
 			slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
@@ -588,6 +592,16 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 		spin_unlock_irqrestore(&pSeries_lpar_tlbie_lock, flags);
 }
 
+static unsigned long pSeries_lpar_get_hpte_v(unsigned long slot)
+{
+	unsigned long hpte_v;
+
+	hpte_v = pSeries_lpar_hpte_getword0(slot);
+	return hpte_v;
+}
+
+
+
 static int __init disable_bulk_remove(char *str)
 {
 	if (strcmp(str, "off") == 0 &&
@@ -611,6 +625,7 @@ void __init hpte_init_lpar(void)
 	ppc_md.flush_hash_range	= pSeries_lpar_flush_hash_range;
 	ppc_md.hpte_clear_all   = pSeries_lpar_hptab_clear;
 	ppc_md.hugepage_invalidate = pSeries_lpar_hugepage_invalidate;
+	ppc_md.get_hpte_v	= pSeries_lpar_get_hpte_v;
 }
 
 #ifdef CONFIG_PPC_SMLPAR
-- 
2.5.0
