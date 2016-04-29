Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDxx4sfXzDqBK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 22/70] powerpc/mm/book3s: Rename hash specific PTE bits to
 carry H_ prefix
Date: Fri, 29 Apr 2016 23:25:45 +1000
Message-Id: <1461936393-10131-22-git-send-email-mpe@ellerman.id.au>
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

This helps to make following hash only pte bits easier.

We have kept _PAGE_CHG_MASK, _HPAGE_CHG_MASK and _PAGE_PROT_BITS as it
is in this patch eventhough they use hash specific bits. Using them in
radix as it is should be ok, because with radix we expect those bit
positions to be zero.

Only renames in this patch, no change in functionality.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  | 12 ++++--
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 38 +++++++++++--------
 arch/powerpc/include/asm/book3s/64/hash.h     | 38 +++++++++----------
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
 13 files changed, 121 insertions(+), 107 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 772850e517f3..2f818cbd8aa6 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -48,10 +48,14 @@
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
+#define H_PAGE_COMBO	0x0
 #ifndef __ASSEMBLY__
 /*
  * On all 4K setups, remap_4k_pfn() equates to remap_pfn_range()
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index ecc7ce0f4baf..607cf3219d88 100644
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
index 4fffc963ac14..556670212781 100644
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
+
 
-#define _PAGE_F_GIX_SHIFT	57
-#define _PAGE_F_GIX		(7ul << 57)	/* HPTE index within HPTEG */
-#define _PAGE_F_SECOND		(1ul << 60)	/* HPTE is in 2ndary HPTEG */
-#define _PAGE_HASHPTE		(1ul << 61)	/* PTE has associated HPTE */
+#define H_PAGE_F_GIX_SHIFT	57
+#define H_PAGE_F_GIX		(7ul << 57)	/* HPTE index within HPTEG */
+#define H_PAGE_F_SECOND		(1ul << 60)	/* HPTE is in 2ndary HPTEG */
+#define H_PAGE_HASHPTE		(1ul << 61)	/* PTE has associated HPTE */
 #define _PAGE_PTE		(1ul << 62)	/* distinguishes PTEs from pointers */
 #define _PAGE_PRESENT		(1ul << 63)	/* pte contains a translation */
 /*
@@ -48,11 +51,6 @@
  */
 #define _PAGE_NO_CACHE		_PAGE_TOLERANT
 /*
- * We need to differentiate between explicit huge page and THP huge
- * page, since THP huge page also need to track real subpage details
- */
-#define _PAGE_THP_HUGE  _PAGE_4K_PFN
-/*
  * We support 57 bit real address in pte. Clear everything above 57, and
  * every thing below PAGE_SHIFT;
  */
@@ -61,7 +59,7 @@
  * set of bits not changed in pmd_modify.
  */
 #define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
-			 _PAGE_ACCESSED | _PAGE_THP_HUGE | _PAGE_PTE | \
+			 _PAGE_ACCESSED | H_PAGE_THP_HUGE | _PAGE_PTE | \
 			 _PAGE_SOFT_DIRTY)
 
 
@@ -148,7 +146,7 @@
  * Mask of bits returned by pte_pgprot()
  */
 #define PAGE_PROT_BITS  (_PAGE_SAO | _PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT | \
-			 _PAGE_4K_PFN | _PAGE_PRIVILEGED | _PAGE_ACCESSED | \
+			 H_PAGE_4K_PFN | _PAGE_PRIVILEGED | _PAGE_ACCESSED | \
 			 _PAGE_READ | _PAGE_WRITE |  _PAGE_DIRTY | _PAGE_EXEC | \
 			 _PAGE_SOFT_DIRTY)
 /*
@@ -262,14 +260,14 @@ static inline unsigned long pte_update(struct mm_struct *mm,
 	bne-	1b"
 	: "=&r" (old_be), "=&r" (tmp_be), "=m" (*ptep)
 	: "r" (ptep), "r" (cpu_to_be64(clr)), "m" (*ptep),
-	  "r" (cpu_to_be64(_PAGE_BUSY)), "r" (cpu_to_be64(set))
+	  "r" (cpu_to_be64(H_PAGE_BUSY)), "r" (cpu_to_be64(set))
 	: "cc" );
 	/* huge pages use the old page table lock */
 	if (!huge)
 		assert_pte_locked(mm, addr);
 
 	old = be64_to_cpu(old_be);
-	if (old & _PAGE_HASHPTE)
+	if (old & H_PAGE_HASHPTE)
 		hpte_need_flush(mm, addr, ptep, old, huge);
 
 	return old;
@@ -287,7 +285,7 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 {
 	unsigned long old;
 
-	if ((pte_val(*ptep) & (_PAGE_ACCESSED | _PAGE_HASHPTE)) == 0)
+	if ((pte_val(*ptep) & (_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
 		return 0;
 	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
 	return (old & _PAGE_ACCESSED) != 0;
@@ -355,7 +353,7 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 		stdcx.	%0,0,%4\n\
 		bne-	1b"
 	:"=&r" (old), "=&r" (tmp), "=m" (*ptep)
-	:"r" (val), "r" (ptep), "m" (*ptep), "r" (cpu_to_be64(_PAGE_BUSY))
+	:"r" (val), "r" (ptep), "m" (*ptep), "r" (cpu_to_be64(H_PAGE_BUSY))
 	:"cc");
 }
 
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
index 3c380c247d4e..1f4497fb5b83 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -310,9 +310,9 @@ static inline pte_t kvmppc_read_update_linux_pte(pte_t *ptep, int writing)
 		 */
 		old_pte = READ_ONCE(*ptep);
 		/*
-		 * wait until _PAGE_BUSY is clear then set it atomically
+		 * wait until H_PAGE_BUSY is clear then set it atomically
 		 */
-		if (unlikely(pte_val(old_pte) & _PAGE_BUSY)) {
+		if (unlikely(pte_val(old_pte) & H_PAGE_BUSY)) {
 			cpu_relax();
 			continue;
 		}
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index 5f457535573b..2eeaf80d41b7 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -206,3 +206,7 @@ static inline bool pte_user(pte_t pte)
 #define _PAGE_READ 0
 #define _PAGE_WRITE _PAGE_RW
 #endif
+
+#ifndef H_PAGE_4K_PFN
+#define H_PAGE_4K_PFN 0
+#endif
diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
index 529e49204f6b..6333b273d2d5 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -34,7 +34,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 
 		old_pte = pte_val(pte);
 		/* If PTE busy, retry the access */
-		if (unlikely(old_pte & _PAGE_BUSY))
+		if (unlikely(old_pte & H_PAGE_BUSY))
 			return 0;
 		/* If PTE permissions don't match, take page fault */
 		if (unlikely(!check_pte_access(access, old_pte)))
@@ -42,9 +42,9 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
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
 	} while (!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
@@ -60,22 +60,22 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
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
@@ -115,9 +115,10 @@ repeat:
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
index 675331083728..16644e1f4e6b 100644
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
@@ -66,7 +66,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 
 		old_pte = pte_val(pte);
 		/* If PTE busy, retry the access */
-		if (unlikely(old_pte & _PAGE_BUSY))
+		if (unlikely(old_pte & H_PAGE_BUSY))
 			return 0;
 		/* If PTE permissions don't match, take page fault */
 		if (unlikely(!check_pte_access(access, old_pte)))
@@ -74,9 +74,9 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
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
 	} while (!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
@@ -103,21 +103,21 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
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
@@ -143,15 +143,15 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
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
@@ -199,20 +199,20 @@ repeat:
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
 
@@ -234,7 +234,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 
 		old_pte = pte_val(pte);
 		/* If PTE busy, retry the access */
-		if (unlikely(old_pte & _PAGE_BUSY))
+		if (unlikely(old_pte & H_PAGE_BUSY))
 			return 0;
 		/* If PTE permissions don't match, take page fault */
 		if (unlikely(!check_pte_access(access, old_pte)))
@@ -250,7 +250,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
 		 * a write access.
 		 */
-		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
+		new_pte = old_pte | H_PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_WRITE)
 			new_pte |= _PAGE_DIRTY;
 	} while (!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
@@ -262,22 +262,22 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
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
@@ -317,9 +317,10 @@ repeat:
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
index f76a033d1e16..2a193f28b6c7 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1172,8 +1172,8 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
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
@@ -1335,13 +1335,13 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 
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
index 6cb6bdd254bb..ba3fc229468a 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -37,7 +37,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 
 		old_pmd = pmd_val(pmd);
 		/* If PMD busy, retry the access */
-		if (unlikely(old_pmd & _PAGE_BUSY))
+		if (unlikely(old_pmd & H_PAGE_BUSY))
 			return 0;
 		/* If PMD permissions don't match, take page fault */
 		if (unlikely(!check_pte_access(access, old_pmd)))
@@ -46,7 +46,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
 		 * a write access
 		 */
-		new_pmd = old_pmd | _PAGE_BUSY | _PAGE_ACCESSED;
+		new_pmd = old_pmd | H_PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_WRITE)
 			new_pmd |= _PAGE_DIRTY;
 	} while (!pmd_xchg(pmdp, __pmd(old_pmd), __pmd(new_pmd)));
@@ -78,7 +78,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		 * base page size. This is because demote_segment won't flush
 		 * hash page table entries.
 		 */
-		if ((old_pmd & _PAGE_HASHPTE) && !(old_pmd & _PAGE_COMBO)) {
+		if ((old_pmd & H_PAGE_HASHPTE) && !(old_pmd & H_PAGE_COMBO)) {
 			flush_hash_hugepage(vsid, ea, pmdp, MMU_PAGE_64K,
 					    ssize, flags);
 			/*
@@ -125,7 +125,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		hash = hpt_hash(vpn, shift, ssize);
 		/* insert new entry */
 		pa = pmd_pfn(__pmd(old_pmd)) << PAGE_SHIFT;
-		new_pmd |= _PAGE_HASHPTE;
+		new_pmd |= H_PAGE_HASHPTE;
 
 repeat:
 		hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
@@ -169,17 +169,17 @@ repeat:
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
index bf9078440256..3058560b6121 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -47,7 +47,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 	do {
 		old_pte = pte_val(*ptep);
 		/* If PTE busy, retry the access */
-		if (unlikely(old_pte & _PAGE_BUSY))
+		if (unlikely(old_pte & H_PAGE_BUSY))
 			return 0;
 		/* If PTE permissions don't match, take page fault */
 		if (unlikely(!check_pte_access(access, old_pte)))
@@ -55,7 +55,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 
 		/* Try to lock the PTE, add ACCESSED and DIRTY if it was
 		 * a write access */
-		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
+		new_pte = old_pte | H_PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_WRITE)
 			new_pte |= _PAGE_DIRTY;
 	} while(!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
@@ -69,28 +69,28 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
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
@@ -106,14 +106,14 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
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
index 1bfb112e1453..1fe356cad7f6 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -92,7 +92,7 @@ void __iomem * __ioremap_at(phys_addr_t pa, void *ea, unsigned long size,
 		flags |= pgprot_val(PAGE_KERNEL);
 
 	/* We don't support the 4K PFN hack with ioremap */
-	if (flags & _PAGE_4K_PFN)
+	if (flags & H_PAGE_4K_PFN)
 		return NULL;
 
 	WARN_ON(pa & ~PAGE_MASK);
@@ -462,13 +462,13 @@ unsigned long pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
 		bne-	1b"
 	: "=&r" (old_be), "=&r" (tmp), "=m" (*pmdp)
 	: "r" (pmdp), "r" (cpu_to_be64(clr)), "m" (*pmdp),
-	  "r" (cpu_to_be64(_PAGE_BUSY)), "r" (cpu_to_be64(set))
+	  "r" (cpu_to_be64(H_PAGE_BUSY)), "r" (cpu_to_be64(set))
 	: "cc" );
 
 	old = be64_to_cpu(old_be);
 
 	trace_hugepage_update(addr, old, clr, set);
-	if (old & _PAGE_HASHPTE)
+	if (old & H_PAGE_HASHPTE)
 		hpte_do_hugepage_flush(mm, addr, pmdp, old);
 	return old;
 }
@@ -640,7 +640,7 @@ void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
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
