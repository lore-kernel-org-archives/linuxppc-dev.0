Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C0531A04C9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 22:42:03 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Aug 2014 22:42:02 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9BEB92CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 22:42:00 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7DCgeMB15794202
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 22:42:40 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7DCfxNO032555
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 22:42:00 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org
Subject: [PATCH V2] powerpc: thp: Use tlbiel wherever possible
Date: Wed, 13 Aug 2014 18:11:51 +0530
Message-Id: <1407933711-26080-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

If we know that user address space has never executed on other cpus
we could use tlbiel.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h    |  2 +-
 arch/powerpc/include/asm/tlbflush.h   |  4 +-
 arch/powerpc/mm/hash_native_64.c      |  4 +-
 arch/powerpc/mm/hash_utils_64.c       | 70 +++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/hugepage-hash64.c     | 54 +--------------------------
 arch/powerpc/mm/pgtable_64.c          | 69 +++++++---------------------------
 arch/powerpc/platforms/pseries/lpar.c |  2 +-
 7 files changed, 93 insertions(+), 112 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index b125ceab149c..c6047ee32a4f 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -60,7 +60,7 @@ struct machdep_calls {
 	void		(*hugepage_invalidate)(unsigned long vsid,
 					       unsigned long addr,
 					       unsigned char *hpte_slot_array,
-					       int psize, int ssize);
+					       int psize, int ssize, int local);
 	/* special for kexec, to be called in real mode, linear mapping is
 	 * destroyed as well */
 	void		(*hpte_clear_all)(void);
diff --git a/arch/powerpc/include/asm/tlbflush.h b/arch/powerpc/include/asm/tlbflush.h
index 2def01ed0cb2..6a5c1774b32c 100644
--- a/arch/powerpc/include/asm/tlbflush.h
+++ b/arch/powerpc/include/asm/tlbflush.h
@@ -127,7 +127,9 @@ static inline void arch_leave_lazy_mmu_mode(void)
 extern void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize,
 			    int ssize, int local);
 extern void flush_hash_range(unsigned long number, int local);
-
+extern void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
+				pmd_t *pmdp, unsigned int psize, int ssize,
+				int local);
 
 static inline void local_flush_tlb_mm(struct mm_struct *mm)
 {
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index afc0a8295f84..88de8a869c98 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -415,7 +415,7 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
 static void native_hugepage_invalidate(unsigned long vsid,
 				       unsigned long addr,
 				       unsigned char *hpte_slot_array,
-				       int psize, int ssize)
+				       int psize, int ssize, int local)
 {
 	int i;
 	struct hash_pte *hptep;
@@ -461,7 +461,7 @@ static void native_hugepage_invalidate(unsigned long vsid,
 		 * instruction compares entry_VA in tlb with the VA specified
 		 * here
 		 */
-		tlbie(vpn, psize, actual_psize, ssize, 0);
+		tlbie(vpn, psize, actual_psize, ssize, local);
 	}
 	local_irq_restore(flags);
 }
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index daee7f4e5a14..afd55ac9cd88 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1307,6 +1307,76 @@ void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
 #endif
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
+			 pmd_t *pmdp, unsigned int psize, int ssize, int local)
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
+	if (ppc_md.hugepage_invalidate) {
+		ppc_md.hugepage_invalidate(vsid, s_addr, hpte_slot_array,
+					   psize, ssize, local);
+		goto tm_abort;
+	}
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
+				       MMU_PAGE_16M, ssize, local);
+	}
+tm_abort:
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	/* Transactions are not aborted by tlbiel, only tlbie.
+	 * Without, syncing a page back to a block device w/ PIO could pick up
+	 * transactional data (bad!) so we force an abort here.  Before the
+	 * sync the page will be made read-only, which will flush_hash_page.
+	 * BIG ISSUE here: if the kernel uses a page from userspace without
+	 * unmapping it first, it may see the speculated version.
+	 */
+	if (local && cpu_has_feature(CPU_FTR_TM) &&
+	    current->thread.regs &&
+	    MSR_TM_ACTIVE(current->thread.regs->msr)) {
+		tm_enable();
+		tm_abort(TM_CAUSE_TLBI);
+	}
+#endif
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 void flush_hash_range(unsigned long number, int local)
 {
 	if (ppc_md.flush_hash_range)
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 5f5e6328c21c..3a648cd363ae 100644
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
+					    ssize, local);
 	}
 
 	valid = hpte_valid(hpte_slot_array, index);
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index c8d709ab489d..f54b0908c55e 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -731,29 +731,14 @@ void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
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
+	int ssize, local = 0;
+	unsigned int psize;
+	unsigned long vsid;
+	const struct cpumask *tmp;
 
 	/* get the base page size,vsid and segment size */
 #ifdef CONFIG_DEBUG_VM
-	psize = get_slice_psize(mm, s_addr);
+	psize = get_slice_psize(mm, addr);
 	BUG_ON(psize == MMU_PAGE_16M);
 #endif
 	if (old_pmd & _PAGE_COMBO)
@@ -761,46 +746,20 @@ void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
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
+	tmp = cpumask_of(smp_processor_id());
+	if (cpumask_equal(mm_cpumask(mm), tmp))
+		local = 1;
+
+	return flush_hash_hugepage(vsid, addr, pmdp, psize, ssize, local);
 }
 
 static pmd_t pmd_set_protbits(pmd_t pmd, pgprot_t pgprot)
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 34e64237fff9..90a576705d87 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -434,7 +434,7 @@ static void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
 static void pSeries_lpar_hugepage_invalidate(unsigned long vsid,
 					     unsigned long addr,
 					     unsigned char *hpte_slot_array,
-					     int psize, int ssize)
+					     int psize, int ssize, int local)
 {
 	int i, index = 0;
 	unsigned long s_addr = addr;
-- 
1.9.1
