Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqpp2YbqzDqDx
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:25:06 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 02:25:04 -0600
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 8AFCD1FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:13:11 -0600 (MDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8P2jf35586152
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 08:25:02 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8P1sf018241
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:25:02 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 17/65] powerpc/mm/book3s: Rename hash specific PTE bits to
 carry H_ prefix
Date: Sun, 27 Mar 2016 13:53:25 +0530
Message-Id: <1459067053-10835-17-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

This helps is following hash only pte bits easily.

We have kept _PAGE_CHG_MASK, _HPAGE_CHG_MASK and _PAGE_PROT_BITS as it
is in this patch eventhough they use hash specific bits. Using them in
radix as it is should be ok, because with radix we expect those bit
positions to be zero.

Only rename in this patch, no change in functionality.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  | 11 ++++--
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 38 +++++++++++--------
 arch/powerpc/include/asm/book3s/64/hash.h     | 39 +++++++++-----------
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  4 +-
 arch/powerpc/include/asm/kvm_book3s_64.h      |  4 +-
 arch/powerpc/include/asm/pte-common.h         |  4 ++
 arch/powerpc/mm/hash64_4k.c                   | 21 ++++++-----
 arch/powerpc/mm/hash64_64k.c                  | 53 ++++++++++++++-------------
 arch/powerpc/mm/hash_utils_64.c               |  8 ++--
 arch/powerpc/mm/hugepage-hash64.c             | 14 +++----
 arch/powerpc/mm/hugetlbpage-hash64.c          | 20 +++++-----
 arch/powerpc/mm/pgtable_64.c                  |  8 ++--
 arch/powerpc/mm/tlb_hash64.c                  |  4 +-
 13 files changed, 120 insertions(+), 108 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 772850e517f3..115427f61ef0 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -48,10 +48,13 @@
 #define PGD_MASKED_BITS		0
 
 /* PTE flags to conserve for HPTE identification */
-#define _PAGE_HPTEFLAGS (_PAGE_BUSY | _PAGE_HASHPTE | \
-			 _PAGE_F_SECOND | _PAGE_F_GIX)
-
-#define _PAGE_4K_PFN		0
+#define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_HASHPTE | \
+			 H_PAGE_F_SECOND | H_PAGE_F_GIX)
+/*
+ * Not supported by 4k linux page size
+ */
+#define H_PAGE_4K_PFN	0x0
+#define H_PAGE_THP_HUGE 0x0
 #ifndef __ASSEMBLY__
 /*
  * On all 4K setups, remap_4k_pfn() equates to remap_pfn_range()
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 8bb038076892..93bef8162d66 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -29,17 +29,23 @@
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
-#define _PAGE_COMBO	0x00001000 /* this is a combo 4k page */
-#define _PAGE_4K_PFN	0x00002000 /* PFN is for a single 4k page */
+#define H_PAGE_COMBO	0x00001000 /* this is a combo 4k page */
+#define H_PAGE_4K_PFN	0x00002000 /* PFN is for a single 4k page */
 /*
- * Used to track subpage group valid if _PAGE_COMBO is set
- * This overloads _PAGE_F_GIX and _PAGE_F_SECOND
+ * We need to differentiate between explicit huge page and THP huge
+ * page, since THP huge page also need to track real subpage details
  */
-#define _PAGE_COMBO_VALID	(_PAGE_F_GIX | _PAGE_F_SECOND)
+#define H_PAGE_THP_HUGE  H_PAGE_4K_PFN
+
+/*
+ * Used to track subpage group valid if H_PAGE_COMBO is set
+ * This overloads H_PAGE_F_GIX and H_PAGE_F_SECOND
+ */
+#define H_PAGE_COMBO_VALID	(H_PAGE_F_GIX | H_PAGE_F_SECOND)
 
 /* PTE flags to conserve for HPTE identification */
-#define _PAGE_HPTEFLAGS (_PAGE_BUSY | _PAGE_F_SECOND | \
-			 _PAGE_F_GIX | _PAGE_HASHPTE | _PAGE_COMBO)
+#define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_F_SECOND | \
+			 H_PAGE_F_GIX | H_PAGE_HASHPTE | H_PAGE_COMBO)
 /*
  * we support 16 fragments per PTE page of 64K size.
  */
@@ -75,9 +81,9 @@ static inline real_pte_t __real_pte(pte_t pte, pte_t *ptep)
 
 	rpte.pte = pte;
 	rpte.hidx = 0;
-	if (pte_val(pte) & _PAGE_COMBO) {
+	if (pte_val(pte) & H_PAGE_COMBO) {
 		/*
-		 * Make sure we order the hidx load against the _PAGE_COMBO
+		 * Make sure we order the hidx load against the H_PAGE_COMBO
 		 * check. The store side ordering is done in __hash_page_4K
 		 */
 		smp_rmb();
@@ -89,9 +95,9 @@ static inline real_pte_t __real_pte(pte_t pte, pte_t *ptep)
 
 static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
 {
-	if ((pte_val(rpte.pte) & _PAGE_COMBO))
+	if ((pte_val(rpte.pte) & H_PAGE_COMBO))
 		return (rpte.hidx >> (index<<2)) & 0xf;
-	return (pte_val(rpte.pte) >> _PAGE_F_GIX_SHIFT) & 0xf;
+	return (pte_val(rpte.pte) >> H_PAGE_F_GIX_SHIFT) & 0xf;
 }
 
 #define __rpte_to_pte(r)	((r).pte)
@@ -114,7 +120,7 @@ extern bool __rpte_sub_valid(real_pte_t rpte, unsigned long index);
 #define pte_iterate_hashed_end() } while(0); } } while(0)
 
 #define pte_pagesize_index(mm, addr, pte)	\
-	(((pte) & _PAGE_COMBO)? MMU_PAGE_4K: MMU_PAGE_64K)
+	(((pte) & H_PAGE_COMBO)? MMU_PAGE_4K: MMU_PAGE_64K)
 
 extern int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
 			   unsigned long pfn, unsigned long size, pgprot_t);
@@ -126,7 +132,7 @@ static inline int remap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
 		return -EINVAL;
 	}
 	return remap_pfn_range(vma, addr, pfn, PAGE_SIZE,
-			       __pgprot(pgprot_val(prot) | _PAGE_4K_PFN));
+			       __pgprot(pgprot_val(prot) | H_PAGE_4K_PFN));
 }
 
 #define PTE_TABLE_SIZE	PTE_FRAG_SIZE
@@ -255,8 +261,8 @@ static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
  */
 static inline int pmd_trans_huge(pmd_t pmd)
 {
-	return !!((pmd_val(pmd) & (_PAGE_PTE | _PAGE_THP_HUGE)) ==
-		  (_PAGE_PTE | _PAGE_THP_HUGE));
+	return !!((pmd_val(pmd) & (_PAGE_PTE | H_PAGE_THP_HUGE)) ==
+		  (_PAGE_PTE | H_PAGE_THP_HUGE));
 }
 
 static inline int pmd_large(pmd_t pmd)
@@ -280,7 +286,7 @@ static inline int __pmdp_test_and_clear_young(struct mm_struct *mm,
 {
 	unsigned long old;
 
-	if ((pmd_val(*pmdp) & (_PAGE_ACCESSED | _PAGE_HASHPTE)) == 0)
+	if ((pmd_val(*pmdp) & (_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
 		return 0;
 	old = pmd_hugepage_update(mm, addr, pmdp, _PAGE_ACCESSED, 0);
 	return ((old & _PAGE_ACCESSED) != 0);
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index d54ebb16692c..2b0824defa6e 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -26,19 +26,22 @@
 #define _PAGE_TOLERANT		0x00030 /* tolerant memory, cache inhibited */
 #define _PAGE_DIRTY		0x00080 /* C: page changed */
 #define _PAGE_ACCESSED		0x00100 /* R: page referenced */
-#define _PAGE_SPECIAL		0x00400 /* software: special page */
-#define _PAGE_BUSY		0x00800 /* software: PTE & hash are busy */
-
+/*
+ * Software bits
+ */
 #ifdef CONFIG_MEM_SOFT_DIRTY
-#define _PAGE_SOFT_DIRTY	0x200 /* software: software dirty tracking */
+#define _PAGE_SOFT_DIRTY	0x00200 /* software: software dirty tracking */
 #else
-#define _PAGE_SOFT_DIRTY	0x000
+#define _PAGE_SOFT_DIRTY	0x00000
 #endif
+#define _PAGE_SPECIAL		0x00400 /* software: special page */
+#define H_PAGE_BUSY		0x00800 /* software: PTE & hash are busy */
 
-#define _PAGE_F_GIX_SHIFT	57
-#define _PAGE_F_GIX		(7ul << 57)	/* HPTE index within HPTEG */
-#define _PAGE_F_SECOND		(1ul << 60)	/* HPTE is in 2ndary HPTEG */
-#define _PAGE_HASHPTE		(1ul << 61)	/* PTE has associated HPTE */
+
+#define H_PAGE_F_GIX_SHIFT	57
+#define H_PAGE_F_GIX		(7ul << 57)	/* HPTE index within HPTEG */
+#define H_PAGE_F_SECOND		(1ul << 60)	/* HPTE is in 2ndary HPTEG */
+#define H_PAGE_HASHPTE		(1ul << 61)	/* PTE has associated HPTE */
 #define _PAGE_PTE		(1ul << 62)	/* distinguishes PTEs from pointers */
 #define _PAGE_PRESENT		(1ul << 63)	/* pte contains a translation */
 /*
@@ -48,16 +51,10 @@
  */
 #define _PAGE_NO_CACHE		_PAGE_TOLERANT
 /*
- * We need to differentiate between explicit huge page and THP huge
- * page, since THP huge page also need to track real subpage details
- */
-#define _PAGE_THP_HUGE  _PAGE_4K_PFN
-
-/*
  * set of bits not changed in pmd_modify.
  */
 #define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
-			 _PAGE_ACCESSED | _PAGE_THP_HUGE | _PAGE_PTE | \
+			 _PAGE_ACCESSED | H_PAGE_THP_HUGE | _PAGE_PTE | \
 			 _PAGE_SOFT_DIRTY)
 
 
@@ -151,7 +148,7 @@
  * Mask of bits returned by pte_pgprot()
  */
 #define PAGE_PROT_BITS  (_PAGE_SAO | _PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT | \
-			 _PAGE_4K_PFN | _PAGE_PRIVILEGED | _PAGE_ACCESSED | \
+			 H_PAGE_4K_PFN | _PAGE_PRIVILEGED | _PAGE_ACCESSED | \
 			 _PAGE_READ | _PAGE_WRITE |  _PAGE_DIRTY | _PAGE_EXEC | \
 			 _PAGE_SOFT_DIRTY)
 /*
@@ -253,7 +250,7 @@ static inline unsigned long pte_update(struct mm_struct *mm,
 				       int huge)
 {
 	unsigned long old, tmp;
-	unsigned long busy = cpu_to_be64(_PAGE_BUSY);
+	unsigned long busy = cpu_to_be64(H_PAGE_BUSY);
 
 	clr = cpu_to_be64(clr);
 	set = cpu_to_be64(set);
@@ -274,7 +271,7 @@ static inline unsigned long pte_update(struct mm_struct *mm,
 		assert_pte_locked(mm, addr);
 
 	old = be64_to_cpu(old);
-	if (old & _PAGE_HASHPTE)
+	if (old & H_PAGE_HASHPTE)
 		hpte_need_flush(mm, addr, ptep, old, huge);
 
 	return old;
@@ -292,7 +289,7 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 {
 	unsigned long old;
 
-	if ((pte_val(*ptep) & (_PAGE_ACCESSED | _PAGE_HASHPTE)) == 0)
+	if ((pte_val(*ptep) & (_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
 		return 0;
 	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
 	return (old & _PAGE_ACCESSED) != 0;
@@ -350,7 +347,7 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 		 _PAGE_SOFT_DIRTY);
 
 	unsigned long old, tmp;
-	unsigned long busy = cpu_to_be64(_PAGE_BUSY);
+	unsigned long busy = cpu_to_be64(H_PAGE_BUSY);
 
 	bits = cpu_to_be64(bits);
 
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 4745d314acfb..65eb819609b1 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -45,7 +45,7 @@
 
 #define __real_pte(e,p)		((real_pte_t){(e)})
 #define __rpte_to_pte(r)	((r).pte)
-#define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >>_PAGE_F_GIX_SHIFT)
+#define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >> H_PAGE_F_GIX_SHIFT)
 
 #define pte_iterate_hashed_subpages(rpte, psize, va, index, shift)       \
 	do {							         \
@@ -287,7 +287,7 @@ static inline int pmd_protnone(pmd_t pmd)
 
 static inline pmd_t pmd_mkhuge(pmd_t pmd)
 {
-	return __pmd(pmd_val(pmd) | (_PAGE_PTE | _PAGE_THP_HUGE));
+	return __pmd(pmd_val(pmd) | (_PAGE_PTE | H_PAGE_THP_HUGE));
 }
 
 #define __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index ebdaf576cf26..2be3c6497609 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -315,9 +315,9 @@ static inline pte_t kvmppc_read_update_linux_pte(pte_t *ptep, int writing)
 		old_pte = READ_ONCE(*ptep);
 		old_ptev = pte_val(old_pte);
 		/*
-		 * wait until _PAGE_BUSY is clear then set it atomically
+		 * wait until H_PAGE_BUSY is clear then set it atomically
 		 */
-		if (unlikely(old_ptev & _PAGE_BUSY)) {
+		if (unlikely(old_ptev & H_PAGE_BUSY)) {
 			cpu_relax();
 			continue;
 		}
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index 9f5dea58b0db..2ad5d94d45cd 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -203,3 +203,7 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
 #define _PAGE_READ 0
 #define _PAGE_WRITE _PAGE_RW
 #endif
+
+#ifndef H_PAGE_4K_PFN
+#define H_PAGE_4K_PFN 0
+#endif
diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
index 42ba12c184e1..a1e5ed3ced81 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -35,7 +35,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 
 		old_pte = pte_val(pte);
 		/* If PTE busy, retry the access */
-		if (unlikely(old_pte & _PAGE_BUSY))
+		if (unlikely(old_pte & H_PAGE_BUSY))
 			return 0;
 		/* If PTE permissions don't match, take page fault */
 		if (unlikely(!check_pte_access(access, old_pte)))
@@ -43,9 +43,9 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		/*
 		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
 		 * a write access. Since this is 4K insert of 64K page size
-		 * also add _PAGE_COMBO
+		 * also add H_PAGE_COMBO
 		 */
-		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
+		new_pte = old_pte | H_PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_WRITE)
 			new_pte |= _PAGE_DIRTY;
 
@@ -63,22 +63,22 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		rflags = hash_page_do_lazy_icache(rflags, __pte(old_pte), trap);
 
 	vpn  = hpt_vpn(ea, vsid, ssize);
-	if (unlikely(old_pte & _PAGE_HASHPTE)) {
+	if (unlikely(old_pte & H_PAGE_HASHPTE)) {
 		/*
 		 * There MIGHT be an HPTE for this pte
 		 */
 		hash = hpt_hash(vpn, shift, ssize);
-		if (old_pte & _PAGE_F_SECOND)
+		if (old_pte & H_PAGE_F_SECOND)
 			hash = ~hash;
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		slot += (old_pte & _PAGE_F_GIX) >> _PAGE_F_GIX_SHIFT;
+		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
 
 		if (ppc_md.hpte_updatepp(slot, rflags, vpn, MMU_PAGE_4K,
 					 MMU_PAGE_4K, ssize, flags) == -1)
 			old_pte &= ~_PAGE_HPTEFLAGS;
 	}
 
-	if (likely(!(old_pte & _PAGE_HASHPTE))) {
+	if (likely(!(old_pte & H_PAGE_HASHPTE))) {
 
 		pa = pte_pfn(__pte(old_pte)) << PAGE_SHIFT;
 		hash = hpt_hash(vpn, shift, ssize);
@@ -118,9 +118,10 @@ repeat:
 					   MMU_PAGE_4K, MMU_PAGE_4K, old_pte);
 			return -1;
 		}
-		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE;
-		new_pte |= (slot << _PAGE_F_GIX_SHIFT) & (_PAGE_F_SECOND | _PAGE_F_GIX);
+		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | H_PAGE_HASHPTE;
+		new_pte |= (slot << H_PAGE_F_GIX_SHIFT) &
+			(H_PAGE_F_SECOND | H_PAGE_F_GIX);
 	}
-	*ptep = __pte(new_pte & ~_PAGE_BUSY);
+	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
 	return 0;
 }
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index 419562b0e9c8..f0d209376603 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -23,7 +23,7 @@ bool __rpte_sub_valid(real_pte_t rpte, unsigned long index)
 	unsigned long g_idx;
 	unsigned long ptev = pte_val(rpte.pte);
 
-	g_idx = (ptev & _PAGE_COMBO_VALID) >> _PAGE_F_GIX_SHIFT;
+	g_idx = (ptev & H_PAGE_COMBO_VALID) >> H_PAGE_F_GIX_SHIFT;
 	index = index >> 2;
 	if (g_idx & (0x1 << index))
 		return true;
@@ -37,12 +37,12 @@ static unsigned long mark_subptegroup_valid(unsigned long ptev, unsigned long in
 {
 	unsigned long g_idx;
 
-	if (!(ptev & _PAGE_COMBO))
+	if (!(ptev & H_PAGE_COMBO))
 		return ptev;
 	index = index >> 2;
 	g_idx = 0x1 << index;
 
-	return ptev | (g_idx << _PAGE_F_GIX_SHIFT);
+	return ptev | (g_idx << H_PAGE_F_GIX_SHIFT);
 }
 
 int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
@@ -67,7 +67,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 
 		old_pte = pte_val(pte);
 		/* If PTE busy, retry the access */
-		if (unlikely(old_pte & _PAGE_BUSY))
+		if (unlikely(old_pte & H_PAGE_BUSY))
 			return 0;
 		/* If PTE permissions don't match, take page fault */
 		if (unlikely(!check_pte_access(access, old_pte)))
@@ -75,9 +75,9 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		/*
 		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
 		 * a write access. Since this is 4K insert of 64K page size
-		 * also add _PAGE_COMBO
+		 * also add H_PAGE_COMBO
 		 */
-		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED | _PAGE_COMBO;
+		new_pte = old_pte | H_PAGE_BUSY | _PAGE_ACCESSED | H_PAGE_COMBO;
 		if (access & _PAGE_WRITE)
 			new_pte |= _PAGE_DIRTY;
 
@@ -106,21 +106,21 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	/*
 	 *None of the sub 4k page is hashed
 	 */
-	if (!(old_pte & _PAGE_HASHPTE))
+	if (!(old_pte & H_PAGE_HASHPTE))
 		goto htab_insert_hpte;
 	/*
 	 * Check if the pte was already inserted into the hash table
 	 * as a 64k HW page, and invalidate the 64k HPTE if so.
 	 */
-	if (!(old_pte & _PAGE_COMBO)) {
+	if (!(old_pte & H_PAGE_COMBO)) {
 		flush_hash_page(vpn, rpte, MMU_PAGE_64K, ssize, flags);
 		/*
 		 * clear the old slot details from the old and new pte.
 		 * On hash insert failure we use old pte value and we don't
 		 * want slot information there if we have a insert failure.
 		 */
-		old_pte &= ~(_PAGE_HASHPTE | _PAGE_F_GIX | _PAGE_F_SECOND);
-		new_pte &= ~(_PAGE_HASHPTE | _PAGE_F_GIX | _PAGE_F_SECOND);
+		old_pte &= ~(H_PAGE_HASHPTE | H_PAGE_F_GIX | H_PAGE_F_SECOND);
+		new_pte &= ~(H_PAGE_HASHPTE | H_PAGE_F_GIX | H_PAGE_F_SECOND);
 		goto htab_insert_hpte;
 	}
 	/*
@@ -146,15 +146,15 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		if (ret == -1)
 			goto htab_insert_hpte;
 
-		*ptep = __pte(new_pte & ~_PAGE_BUSY);
+		*ptep = __pte(new_pte & ~H_PAGE_BUSY);
 		return 0;
 	}
 
 htab_insert_hpte:
 	/*
-	 * handle _PAGE_4K_PFN case
+	 * handle H_PAGE_4K_PFN case
 	 */
-	if (old_pte & _PAGE_4K_PFN) {
+	if (old_pte & H_PAGE_4K_PFN) {
 		/*
 		 * All the sub 4k page have the same
 		 * physical address.
@@ -202,20 +202,20 @@ repeat:
 	}
 	/*
 	 * Insert slot number & secondary bit in PTE second half,
-	 * clear _PAGE_BUSY and set appropriate HPTE slot bit
-	 * Since we have _PAGE_BUSY set on ptep, we can be sure
+	 * clear H_PAGE_BUSY and set appropriate HPTE slot bit
+	 * Since we have H_PAGE_BUSY set on ptep, we can be sure
 	 * nobody is undating hidx.
 	 */
 	hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
 	rpte.hidx &= ~(0xfUL << (subpg_index << 2));
 	*hidxp = rpte.hidx  | (slot << (subpg_index << 2));
 	new_pte = mark_subptegroup_valid(new_pte, subpg_index);
-	new_pte |=  _PAGE_HASHPTE;
+	new_pte |=  H_PAGE_HASHPTE;
 	/*
 	 * check __real_pte for details on matching smp_rmb()
 	 */
 	smp_wmb();
-	*ptep = __pte(new_pte & ~_PAGE_BUSY);
+	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
 	return 0;
 }
 
@@ -238,7 +238,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 
 		old_pte = pte_val(pte);
 		/* If PTE busy, retry the access */
-		if (unlikely(old_pte & _PAGE_BUSY))
+		if (unlikely(old_pte & H_PAGE_BUSY))
 			return 0;
 		/* If PTE permissions don't match, take page fault */
 		if (unlikely(!check_pte_access(access, old_pte)))
@@ -254,7 +254,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
 		 * a write access.
 		 */
-		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
+		new_pte = old_pte | H_PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_WRITE)
 			new_pte |= _PAGE_DIRTY;
 		opte = cpu_to_be64(old_pte);
@@ -268,22 +268,22 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		rflags = hash_page_do_lazy_icache(rflags, __pte(old_pte), trap);
 
 	vpn  = hpt_vpn(ea, vsid, ssize);
-	if (unlikely(old_pte & _PAGE_HASHPTE)) {
+	if (unlikely(old_pte & H_PAGE_HASHPTE)) {
 		/*
 		 * There MIGHT be an HPTE for this pte
 		 */
 		hash = hpt_hash(vpn, shift, ssize);
-		if (old_pte & _PAGE_F_SECOND)
+		if (old_pte & H_PAGE_F_SECOND)
 			hash = ~hash;
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		slot += (old_pte & _PAGE_F_GIX) >> _PAGE_F_GIX_SHIFT;
+		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
 
 		if (ppc_md.hpte_updatepp(slot, rflags, vpn, MMU_PAGE_64K,
 					 MMU_PAGE_64K, ssize, flags) == -1)
 			old_pte &= ~_PAGE_HPTEFLAGS;
 	}
 
-	if (likely(!(old_pte & _PAGE_HASHPTE))) {
+	if (likely(!(old_pte & H_PAGE_HASHPTE))) {
 
 		pa = pte_pfn(__pte(old_pte)) << PAGE_SHIFT;
 		hash = hpt_hash(vpn, shift, ssize);
@@ -323,9 +323,10 @@ repeat:
 					   MMU_PAGE_64K, MMU_PAGE_64K, old_pte);
 			return -1;
 		}
-		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE;
-		new_pte |= (slot << _PAGE_F_GIX_SHIFT) & (_PAGE_F_SECOND | _PAGE_F_GIX);
+		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | H_PAGE_HASHPTE;
+		new_pte |= (slot << H_PAGE_F_GIX_SHIFT) &
+			(H_PAGE_F_SECOND | H_PAGE_F_GIX);
 	}
-	*ptep = __pte(new_pte & ~_PAGE_BUSY);
+	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
 	return 0;
 }
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 43e0d86b7ca1..c2ffc97cf665 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1168,8 +1168,8 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 #endif
 	/* Do actual hashing */
 #ifdef CONFIG_PPC_64K_PAGES
-	/* If _PAGE_4K_PFN is set, make sure this is a 4k segment */
-	if ((pte_val(*ptep) & _PAGE_4K_PFN) && psize == MMU_PAGE_64K) {
+	/* If H_PAGE_4K_PFN is set, make sure this is a 4k segment */
+	if ((pte_val(*ptep) & H_PAGE_4K_PFN) && psize == MMU_PAGE_64K) {
 		demote_segment_4k(mm, ea);
 		psize = MMU_PAGE_4K;
 	}
@@ -1331,13 +1331,13 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 
 	WARN_ON(hugepage_shift);
 #ifdef CONFIG_PPC_64K_PAGES
-	/* If either _PAGE_4K_PFN or cache inhibited is set (and we are on
+	/* If either H_PAGE_4K_PFN or cache inhibited is set (and we are on
 	 * a 64K kernel), then we don't preload, hash_page() will take
 	 * care of it once we actually try to access the page.
 	 * That way we don't have to duplicate all of the logic for segment
 	 * page size demotion here
 	 */
-	if ((pte_val(*ptep) & _PAGE_4K_PFN) || pte_ci(*ptep))
+	if ((pte_val(*ptep) & H_PAGE_4K_PFN) || pte_ci(*ptep))
 		goto out_exit;
 #endif /* CONFIG_PPC_64K_PAGES */
 
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 182f1d3fe73c..abf6c468bbc8 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -38,7 +38,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 
 		old_pmd = pmd_val(pmd);
 		/* If PMD busy, retry the access */
-		if (unlikely(old_pmd & _PAGE_BUSY))
+		if (unlikely(old_pmd & H_PAGE_BUSY))
 			return 0;
 		/* If PMD permissions don't match, take page fault */
 		if (unlikely(!check_pte_access(access, old_pmd)))
@@ -47,7 +47,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
 		 * a write access
 		 */
-		new_pmd = old_pmd | _PAGE_BUSY | _PAGE_ACCESSED;
+		new_pmd = old_pmd | H_PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_WRITE)
 			new_pmd |= _PAGE_DIRTY;
 		opmd = cpu_to_be64(old_pmd);
@@ -81,7 +81,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		 * base page size. This is because demote_segment won't flush
 		 * hash page table entries.
 		 */
-		if ((old_pmd & _PAGE_HASHPTE) && !(old_pmd & _PAGE_COMBO)) {
+		if ((old_pmd & H_PAGE_HASHPTE) && !(old_pmd & H_PAGE_COMBO)) {
 			flush_hash_hugepage(vsid, ea, pmdp, MMU_PAGE_64K,
 					    ssize, flags);
 			/*
@@ -128,7 +128,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		hash = hpt_hash(vpn, shift, ssize);
 		/* insert new entry */
 		pa = pmd_pfn(__pmd(old_pmd)) << PAGE_SHIFT;
-		new_pmd |= _PAGE_HASHPTE;
+		new_pmd |= H_PAGE_HASHPTE;
 
 repeat:
 		hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
@@ -172,17 +172,17 @@ repeat:
 		mark_hpte_slot_valid(hpte_slot_array, index, slot);
 	}
 	/*
-	 * Mark the pte with _PAGE_COMBO, if we are trying to hash it with
+	 * Mark the pte with H_PAGE_COMBO, if we are trying to hash it with
 	 * base page size 4k.
 	 */
 	if (psize == MMU_PAGE_4K)
-		new_pmd |= _PAGE_COMBO;
+		new_pmd |= H_PAGE_COMBO;
 	/*
 	 * The hpte valid is stored in the pgtable whose address is in the
 	 * second half of the PMD. Order this against clearing of the busy bit in
 	 * huge pmd.
 	 */
 	smp_wmb();
-	*pmdp = __pmd(new_pmd & ~_PAGE_BUSY);
+	*pmdp = __pmd(new_pmd & ~H_PAGE_BUSY);
 	return 0;
 }
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index 96765510a49c..86a1f36714a3 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -48,7 +48,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 	do {
 		old_pte = pte_val(*ptep);
 		/* If PTE busy, retry the access */
-		if (unlikely(old_pte & _PAGE_BUSY))
+		if (unlikely(old_pte & H_PAGE_BUSY))
 			return 0;
 		/* If PTE permissions don't match, take page fault */
 		if (unlikely(!check_pte_access(access, old_pte)))
@@ -56,7 +56,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 
 		/* Try to lock the PTE, add ACCESSED and DIRTY if it was
 		 * a write access */
-		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
+		new_pte = old_pte | H_PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_WRITE)
 			new_pte |= _PAGE_DIRTY;
 		opte = cpu_to_be64(old_pte);
@@ -72,28 +72,28 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		rflags = hash_page_do_lazy_icache(rflags, __pte(old_pte), trap);
 
 	/* Check if pte already has an hpte (case 2) */
-	if (unlikely(old_pte & _PAGE_HASHPTE)) {
+	if (unlikely(old_pte & H_PAGE_HASHPTE)) {
 		/* There MIGHT be an HPTE for this pte */
 		unsigned long hash, slot;
 
 		hash = hpt_hash(vpn, shift, ssize);
-		if (old_pte & _PAGE_F_SECOND)
+		if (old_pte & H_PAGE_F_SECOND)
 			hash = ~hash;
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		slot += (old_pte & _PAGE_F_GIX) >> _PAGE_F_GIX_SHIFT;
+		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
 
 		if (ppc_md.hpte_updatepp(slot, rflags, vpn, mmu_psize,
 					 mmu_psize, ssize, flags) == -1)
 			old_pte &= ~_PAGE_HPTEFLAGS;
 	}
 
-	if (likely(!(old_pte & _PAGE_HASHPTE))) {
+	if (likely(!(old_pte & H_PAGE_HASHPTE))) {
 		unsigned long hash = hpt_hash(vpn, shift, ssize);
 
 		pa = pte_pfn(__pte(old_pte)) << PAGE_SHIFT;
 
 		/* clear HPTE slot informations in new PTE */
-		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE;
+		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | H_PAGE_HASHPTE;
 
 		slot = hpte_insert_repeating(hash, vpn, pa, rflags, 0,
 					     mmu_psize, ssize);
@@ -109,14 +109,14 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 			return -1;
 		}
 
-		new_pte |= (slot << _PAGE_F_GIX_SHIFT) &
-			(_PAGE_F_SECOND | _PAGE_F_GIX);
+		new_pte |= (slot << H_PAGE_F_GIX_SHIFT) &
+			(H_PAGE_F_SECOND | H_PAGE_F_GIX);
 	}
 
 	/*
 	 * No need to use ldarx/stdcx here
 	 */
-	*ptep = __pte(new_pte & ~_PAGE_BUSY);
+	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
 	return 0;
 }
 
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index d493f62d12eb..e43e0ea820e0 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -92,7 +92,7 @@ void __iomem * __ioremap_at(phys_addr_t pa, void *ea, unsigned long size,
 		flags |= pgprot_val(PAGE_KERNEL);
 
 	/* We don't support the 4K PFN hack with ioremap */
-	if (flags & _PAGE_4K_PFN)
+	if (flags & H_PAGE_4K_PFN)
 		return NULL;
 
 	WARN_ON(pa & ~PAGE_MASK);
@@ -445,7 +445,7 @@ unsigned long pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
 {
 
 	unsigned long old, tmp;
-	unsigned long busy = cpu_to_be64(_PAGE_BUSY);
+	unsigned long busy = cpu_to_be64(H_PAGE_BUSY);
 
 #ifdef CONFIG_DEBUG_VM
 	WARN_ON(!pmd_trans_huge(*pmdp));
@@ -473,7 +473,7 @@ unsigned long pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
 	*pmdp = __pmd((old & ~clr) | set);
 #endif
 	trace_hugepage_update(addr, old, clr, set);
-	if (old & _PAGE_HASHPTE)
+	if (old & H_PAGE_HASHPTE)
 		hpte_do_hugepage_flush(mm, addr, pmdp, old);
 	return old;
 }
@@ -645,7 +645,7 @@ void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 	psize = get_slice_psize(mm, addr);
 	BUG_ON(psize == MMU_PAGE_16M);
 #endif
-	if (old_pmd & _PAGE_COMBO)
+	if (old_pmd & H_PAGE_COMBO)
 		psize = MMU_PAGE_4K;
 	else
 		psize = MMU_PAGE_64K;
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index f7b80391bee7..38497cf5e31b 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -218,7 +218,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 		pte = pte_val(*ptep);
 		if (is_thp)
 			trace_hugepage_invalidate(start, pte);
-		if (!(pte & _PAGE_HASHPTE))
+		if (!(pte & H_PAGE_HASHPTE))
 			continue;
 		if (unlikely(is_thp))
 			hpte_do_hugepage_flush(mm, start, (pmd_t *)ptep, pte);
@@ -248,7 +248,7 @@ void flush_tlb_pmd_range(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
 	start_pte = pte_offset_map(pmd, addr);
 	for (pte = start_pte; pte < start_pte + PTRS_PER_PTE; pte++) {
 		unsigned long pteval = pte_val(*pte);
-		if (pteval & _PAGE_HASHPTE)
+		if (pteval & H_PAGE_HASHPTE)
 			hpte_need_flush(mm, addr, pte, pteval, 0);
 		addr += PAGE_SIZE;
 	}
-- 
2.5.0
