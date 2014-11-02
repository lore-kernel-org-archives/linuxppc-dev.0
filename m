Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F318D1A1EA9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 02:45:43 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 3 Nov 2014 01:45:43 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DF9D23578047
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 02:45:41 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sA2FldVB34930746
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 02:47:39 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sA2FjeJH023215
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 02:45:41 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH V3 1/2] powerpc/mm/thp: Remove code duplication
Date: Sun,  2 Nov 2014 21:15:27 +0530
Message-Id: <1414943128-29889-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Rename invalidate_old_hpte to flush_hash_hugepage and use that in
other places.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Changes from V2:
* split the patch for easier review
* Rebase to latest linus tree

 arch/powerpc/include/asm/tlbflush.h |  3 +-
 arch/powerpc/mm/hash_utils_64.c     | 52 ++++++++++++++++++++++++++++++
 arch/powerpc/mm/hugepage-hash64.c   | 54 ++-----------------------------
 arch/powerpc/mm/pgtable_64.c        | 64 ++++++-------------------------------
 4 files changed, 65 insertions(+), 108 deletions(-)

diff --git a/arch/powerpc/include/asm/tlbflush.h b/arch/powerpc/include/asm/tlbflush.h
index 2def01ed0cb2..afe57427ef8e 100644
--- a/arch/powerpc/include/asm/tlbflush.h
+++ b/arch/powerpc/include/asm/tlbflush.h
@@ -127,7 +127,8 @@ static inline void arch_leave_lazy_mmu_mode(void)
 extern void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize,
 			    int ssize, int local);
 extern void flush_hash_range(unsigned long number, int local);
-
+extern void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
+				pmd_t *pmdp, unsigned int psize, int ssize);
 
 static inline void local_flush_tlb_mm(struct mm_struct *mm)
 {
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index d5339a3b9945..26517ea34970 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1315,6 +1315,58 @@ void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
 #endif
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
+			 pmd_t *pmdp, unsigned int psize, int ssize)
+{
+	int i, max_hpte_count, valid;
+	unsigned long s_addr;
+	unsigned char *hpte_slot_array;
+	unsigned long hidx, shift, vpn, hash, slot;
+
+	s_addr = addr & HPAGE_PMD_MASK;
+	hpte_slot_array = get_hpte_slot_array(pmdp);
+	/*
+	 * IF we try to do a HUGE PTE update after a withdraw is done.
+	 * we will find the below NULL. This happens when we do
+	 * split_huge_page_pmd
+	 */
+	if (!hpte_slot_array)
+		return;
+
+	if (ppc_md.hugepage_invalidate)
+		return ppc_md.hugepage_invalidate(vsid, s_addr, hpte_slot_array,
+						  psize, ssize);
+	/*
+	 * No bluk hpte removal support, invalidate each entry
+	 */
+	shift = mmu_psize_defs[psize].shift;
+	max_hpte_count = HPAGE_PMD_SIZE >> shift;
+	for (i = 0; i < max_hpte_count; i++) {
+		/*
+		 * 8 bits per each hpte entries
+		 * 000| [ secondary group (one bit) | hidx (3 bits) | valid bit]
+		 */
+		valid = hpte_valid(hpte_slot_array, i);
+		if (!valid)
+			continue;
+		hidx =  hpte_hash_index(hpte_slot_array, i);
+
+		/* get the vpn */
+		addr = s_addr + (i * (1ul << shift));
+		vpn = hpt_vpn(addr, vsid, ssize);
+		hash = hpt_hash(vpn, shift, ssize);
+		if (hidx & _PTEIDX_SECONDARY)
+			hash = ~hash;
+
+		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+		slot += hidx & _PTEIDX_GROUP_IX;
+		ppc_md.hpte_invalidate(slot, vpn, psize,
+				       MMU_PAGE_16M, ssize, 0);
+	}
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 void flush_hash_range(unsigned long number, int local)
 {
 	if (ppc_md.flush_hash_range)
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 5f5e6328c21c..1b3ad46a71b5 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -18,57 +18,6 @@
 #include <linux/mm.h>
 #include <asm/machdep.h>
 
-static void invalidate_old_hpte(unsigned long vsid, unsigned long addr,
-				pmd_t *pmdp, unsigned int psize, int ssize)
-{
-	int i, max_hpte_count, valid;
-	unsigned long s_addr;
-	unsigned char *hpte_slot_array;
-	unsigned long hidx, shift, vpn, hash, slot;
-
-	s_addr = addr & HPAGE_PMD_MASK;
-	hpte_slot_array = get_hpte_slot_array(pmdp);
-	/*
-	 * IF we try to do a HUGE PTE update after a withdraw is done.
-	 * we will find the below NULL. This happens when we do
-	 * split_huge_page_pmd
-	 */
-	if (!hpte_slot_array)
-		return;
-
-	if (ppc_md.hugepage_invalidate)
-		return ppc_md.hugepage_invalidate(vsid, s_addr, hpte_slot_array,
-						  psize, ssize);
-	/*
-	 * No bluk hpte removal support, invalidate each entry
-	 */
-	shift = mmu_psize_defs[psize].shift;
-	max_hpte_count = HPAGE_PMD_SIZE >> shift;
-	for (i = 0; i < max_hpte_count; i++) {
-		/*
-		 * 8 bits per each hpte entries
-		 * 000| [ secondary group (one bit) | hidx (3 bits) | valid bit]
-		 */
-		valid = hpte_valid(hpte_slot_array, i);
-		if (!valid)
-			continue;
-		hidx =  hpte_hash_index(hpte_slot_array, i);
-
-		/* get the vpn */
-		addr = s_addr + (i * (1ul << shift));
-		vpn = hpt_vpn(addr, vsid, ssize);
-		hash = hpt_hash(vpn, shift, ssize);
-		if (hidx & _PTEIDX_SECONDARY)
-			hash = ~hash;
-
-		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		slot += hidx & _PTEIDX_GROUP_IX;
-		ppc_md.hpte_invalidate(slot, vpn, psize,
-				       MMU_PAGE_16M, ssize, 0);
-	}
-}
-
-
 int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		    pmd_t *pmdp, unsigned long trap, int local, int ssize,
 		    unsigned int psize)
@@ -145,7 +94,8 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		 * hash page table entries.
 		 */
 		if ((old_pmd & _PAGE_HASHPTE) && !(old_pmd & _PAGE_COMBO))
-			invalidate_old_hpte(vsid, ea, pmdp, MMU_PAGE_64K, ssize);
+			flush_hash_hugepage(vsid, ea, pmdp, MMU_PAGE_64K,
+					    ssize);
 	}
 
 	valid = hpte_valid(hpte_slot_array, index);
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index c8d709ab489d..62e8010a0c49 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -731,29 +731,13 @@ void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 			    pmd_t *pmdp, unsigned long old_pmd)
 {
-	int ssize, i;
-	unsigned long s_addr;
-	int max_hpte_count;
-	unsigned int psize, valid;
-	unsigned char *hpte_slot_array;
-	unsigned long hidx, vpn, vsid, hash, shift, slot;
-
-	/*
-	 * Flush all the hptes mapping this hugepage
-	 */
-	s_addr = addr & HPAGE_PMD_MASK;
-	hpte_slot_array = get_hpte_slot_array(pmdp);
-	/*
-	 * IF we try to do a HUGE PTE update after a withdraw is done.
-	 * we will find the below NULL. This happens when we do
-	 * split_huge_page_pmd
-	 */
-	if (!hpte_slot_array)
-		return;
+	int ssize;
+	unsigned int psize;
+	unsigned long vsid;
 
 	/* get the base page size,vsid and segment size */
 #ifdef CONFIG_DEBUG_VM
-	psize = get_slice_psize(mm, s_addr);
+	psize = get_slice_psize(mm, addr);
 	BUG_ON(psize == MMU_PAGE_16M);
 #endif
 	if (old_pmd & _PAGE_COMBO)
@@ -761,46 +745,16 @@ void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 	else
 		psize = MMU_PAGE_64K;
 
-	if (!is_kernel_addr(s_addr)) {
-		ssize = user_segment_size(s_addr);
-		vsid = get_vsid(mm->context.id, s_addr, ssize);
+	if (!is_kernel_addr(addr)) {
+		ssize = user_segment_size(addr);
+		vsid = get_vsid(mm->context.id, addr, ssize);
 		WARN_ON(vsid == 0);
 	} else {
-		vsid = get_kernel_vsid(s_addr, mmu_kernel_ssize);
+		vsid = get_kernel_vsid(addr, mmu_kernel_ssize);
 		ssize = mmu_kernel_ssize;
 	}
 
-	if (ppc_md.hugepage_invalidate)
-		return ppc_md.hugepage_invalidate(vsid, s_addr,
-						  hpte_slot_array,
-						  psize, ssize);
-	/*
-	 * No bluk hpte removal support, invalidate each entry
-	 */
-	shift = mmu_psize_defs[psize].shift;
-	max_hpte_count = HPAGE_PMD_SIZE >> shift;
-	for (i = 0; i < max_hpte_count; i++) {
-		/*
-		 * 8 bits per each hpte entries
-		 * 000| [ secondary group (one bit) | hidx (3 bits) | valid bit]
-		 */
-		valid = hpte_valid(hpte_slot_array, i);
-		if (!valid)
-			continue;
-		hidx =  hpte_hash_index(hpte_slot_array, i);
-
-		/* get the vpn */
-		addr = s_addr + (i * (1ul << shift));
-		vpn = hpt_vpn(addr, vsid, ssize);
-		hash = hpt_hash(vpn, shift, ssize);
-		if (hidx & _PTEIDX_SECONDARY)
-			hash = ~hash;
-
-		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		slot += hidx & _PTEIDX_GROUP_IX;
-		ppc_md.hpte_invalidate(slot, vpn, psize,
-				       MMU_PAGE_16M, ssize, 0);
-	}
+	return flush_hash_hugepage(vsid, addr, pmdp, psize, ssize);
 }
 
 static pmd_t pmd_set_protbits(pmd_t pmd, pgprot_t pgprot)
-- 
2.1.0
