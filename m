Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2FBE21A0404
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 14:02:27 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 9 Oct 2015 08:32:25 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id E67701258019
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 08:32:05 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9932NhT131578
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2015 08:32:23 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9932NgB018584
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2015 08:32:23 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: Differentiate between hugetlb and THP during page
 walk
Date: Fri,  9 Oct 2015 08:32:21 +0530
Message-Id: <1444359741-3037-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to properly identify whether a hugepage is an explicit or
a transparent hugepage in follow_huge_addr(). We used to depend
on hugepage shift argument to do that. But in some case that can
result in wrong results. For ex:

On finding a transparent hugepage we set hugepage shift to PMD_SHIFT.
But we can end up clearing the thp pte, via pmdp_huge_get_and_clear.
We do prevent reusing the pfn page via the usage of
kick_all_cpus_sync(). But that happens after we updated the pte to 0.
Hence in follow_huge_addr() we can find hugepage shift set, but transparent
huge page check fail for a thp pte.

NOTE: We fixed a variant of this race against thp split in commit
691e95fd7396905a38d98919e9c150dbc3ea21a3
("powerpc/mm/thp: Make page table walk safe against thp split/collapse")

Without this patch, we may hit the BUG_ON(flags & FOLL_GET) in
follow_page_mask occasionally.

In the long term, we may want to switch ppc64 64k page size config to
enable CONFIG_ARCH_WANT_GENERAL_HUGETLB

Reported-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h    |  1 +
 arch/powerpc/include/asm/pgtable-ppc64.h | 10 +++++++++-
 arch/powerpc/include/asm/pgtable.h       |  6 +++---
 arch/powerpc/kernel/eeh.c                |  3 ++-
 arch/powerpc/kernel/io-workarounds.c     |  2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c      |  2 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |  8 +++++---
 arch/powerpc/kvm/e500_mmu_host.c         |  2 +-
 arch/powerpc/mm/hash_utils_64.c          |  7 ++++---
 arch/powerpc/mm/hugetlbpage.c            | 21 ++++++++++++++++-----
 arch/powerpc/mm/tlb_hash64.c             |  9 +++++----
 arch/powerpc/perf/callchain.c            |  2 +-
 12 files changed, 49 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index a82f5347540a..ba3342bbdbda 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -14,6 +14,7 @@
 
 #include <asm/asm-compat.h>
 #include <asm/page.h>
+#include <asm/bug.h>
 
 /*
  * This is necessary to get the definition of PGTABLE_RANGE which we
diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index fa1dfb7f7b48..3245f2d96d4f 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -437,9 +437,9 @@ static inline char *get_hpte_slot_array(pmd_t *pmdp)
 
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 				   pmd_t *pmdp, unsigned long old_pmd);
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot);
 extern pmd_t mk_pmd(struct page *page, pgprot_t pgprot);
 extern pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot);
@@ -479,6 +479,14 @@ static inline int pmd_trans_splitting(pmd_t pmd)
 }
 
 extern int has_transparent_hugepage(void);
+#else
+static inline void hpte_do_hugepage_flush(struct mm_struct *mm,
+					  unsigned long addr, pmd_t *pmdp,
+					  unsigned long old_pmd)
+{
+
+	WARN(1, "%s called with THP disabled\n", __func__);
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline int pmd_large(pmd_t pmd)
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 0717693c8428..b64b4212b71f 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -259,15 +259,15 @@ extern int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 #define has_transparent_hugepage() 0
 #endif
 pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
-				 unsigned *shift);
+				   bool *is_thp, unsigned *shift);
 static inline pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
-					       unsigned *shift)
+					       bool *is_thp, unsigned *shift)
 {
 	if (!arch_irqs_disabled()) {
 		pr_info("%s called with irq enabled\n", __func__);
 		dump_stack();
 	}
-	return __find_linux_pte_or_hugepte(pgdir, ea, shift);
+	return __find_linux_pte_or_hugepte(pgdir, ea, is_thp, shift);
 }
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index e968533e3e05..00ba5de12256 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -351,7 +351,8 @@ static inline unsigned long eeh_token_to_phys(unsigned long token)
 	 * worried about _PAGE_SPLITTING/collapse. Also we will not hit
 	 * page table free, because of init_mm.
 	 */
-	ptep = __find_linux_pte_or_hugepte(init_mm.pgd, token, &hugepage_shift);
+	ptep = __find_linux_pte_or_hugepte(init_mm.pgd, token,
+					   NULL, &hugepage_shift);
 	if (!ptep)
 		return token;
 	WARN_ON(hugepage_shift);
diff --git a/arch/powerpc/kernel/io-workarounds.c b/arch/powerpc/kernel/io-workarounds.c
index 63d9cc4d7366..5f8613ceb97f 100644
--- a/arch/powerpc/kernel/io-workarounds.c
+++ b/arch/powerpc/kernel/io-workarounds.c
@@ -76,7 +76,7 @@ struct iowa_bus *iowa_mem_find_bus(const PCI_IO_ADDR addr)
 		 * a page table free due to init_mm
 		 */
 		ptep = __find_linux_pte_or_hugepte(init_mm.pgd, vaddr,
-						 &hugepage_shift);
+						   NULL, &hugepage_shift);
 		if (ptep == NULL)
 			paddr = 0;
 		else {
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 1f9c0a17f445..3fc2ba784a71 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -543,7 +543,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			 */
 			local_irq_save(flags);
 			ptep = find_linux_pte_or_hugepte(current->mm->pgd,
-							 hva, NULL);
+							 hva, NULL, NULL);
 			if (ptep) {
 				pte = kvmppc_read_update_linux_pte(ptep, 1);
 				if (pte_write(pte))
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index c1df9bb1e413..0bce4fffcb2e 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -32,7 +32,7 @@ static void *real_vmalloc_addr(void *x)
 	 * So don't worry about THP collapse/split. Called
 	 * Only in realmode, hence won't need irq_save/restore.
 	 */
-	p = __find_linux_pte_or_hugepte(swapper_pg_dir, addr, NULL);
+	p = __find_linux_pte_or_hugepte(swapper_pg_dir, addr, NULL, NULL);
 	if (!p || !pte_present(*p))
 		return NULL;
 	addr = (pte_pfn(*p) << PAGE_SHIFT) | (addr & ~PAGE_MASK);
@@ -221,10 +221,12 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 	 * retry via mmu_notifier_retry.
 	 */
 	if (realmode)
-		ptep = __find_linux_pte_or_hugepte(pgdir, hva, &hpage_shift);
+		ptep = __find_linux_pte_or_hugepte(pgdir, hva, NULL,
+						   &hpage_shift);
 	else {
 		local_irq_save(irq_flags);
-		ptep = find_linux_pte_or_hugepte(pgdir, hva, &hpage_shift);
+		ptep = find_linux_pte_or_hugepte(pgdir, hva, NULL,
+						 &hpage_shift);
 	}
 	if (ptep) {
 		pte_t pte;
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index 4d33e199edcc..805fee9beefa 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -476,7 +476,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	 * can't run hence pfn won't change.
 	 */
 	local_irq_save(flags);
-	ptep = find_linux_pte_or_hugepte(pgdir, hva, NULL);
+	ptep = find_linux_pte_or_hugepte(pgdir, hva, NULL, NULL);
 	if (ptep) {
 		pte_t pte = READ_ONCE(*ptep);
 
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index aee70171355b..7f9616f7c479 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -994,6 +994,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 		 unsigned long access, unsigned long trap,
 		 unsigned long flags)
 {
+	bool is_thp;
 	enum ctx_state prev_state = exception_enter();
 	pgd_t *pgdir;
 	unsigned long vsid;
@@ -1068,7 +1069,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 #endif /* CONFIG_PPC_64K_PAGES */
 
 	/* Get PTE and page size from page tables */
-	ptep = __find_linux_pte_or_hugepte(pgdir, ea, &hugeshift);
+	ptep = __find_linux_pte_or_hugepte(pgdir, ea, &is_thp, &hugeshift);
 	if (ptep == NULL || !pte_present(*ptep)) {
 		DBG_LOW(" no PTE !\n");
 		rc = 1;
@@ -1088,7 +1089,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 	}
 
 	if (hugeshift) {
-		if (pmd_trans_huge(*(pmd_t *)ptep))
+		if (is_thp)
 			rc = __hash_page_thp(ea, access, vsid, (pmd_t *)ptep,
 					     trap, flags, ssize, psize);
 #ifdef CONFIG_HUGETLB_PAGE
@@ -1243,7 +1244,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	 * THP pages use update_mmu_cache_pmd. We don't do
 	 * hash preload there. Hence can ignore THP here
 	 */
-	ptep = find_linux_pte_or_hugepte(pgdir, ea, &hugepage_shift);
+	ptep = find_linux_pte_or_hugepte(pgdir, ea, NULL, &hugepage_shift);
 	if (!ptep)
 		goto out_exit;
 
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 06c14523b787..c7b0ded670d7 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -109,7 +109,7 @@ int pgd_huge(pgd_t pgd)
 pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
 	/* Only called for hugetlbfs pages, hence can ignore THP */
-	return __find_linux_pte_or_hugepte(mm->pgd, addr, NULL);
+	return __find_linux_pte_or_hugepte(mm->pgd, addr, NULL, NULL);
 }
 
 static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
@@ -684,13 +684,14 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 struct page *
 follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
 {
+	bool is_thp;
 	pte_t *ptep, pte;
 	unsigned shift;
 	unsigned long mask, flags;
 	struct page *page = ERR_PTR(-EINVAL);
 
 	local_irq_save(flags);
-	ptep = find_linux_pte_or_hugepte(mm->pgd, address, &shift);
+	ptep = find_linux_pte_or_hugepte(mm->pgd, address, &is_thp, &shift);
 	if (!ptep)
 		goto no_page;
 	pte = READ_ONCE(*ptep);
@@ -699,7 +700,7 @@ follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
 	 * Transparent hugepages are handled by generic code. We can skip them
 	 * here.
 	 */
-	if (!shift || pmd_trans_huge(__pmd(pte_val(pte))))
+	if (!shift || is_thp)
 		goto no_page;
 
 	if (!pte_present(pte)) {
@@ -956,7 +957,7 @@ void flush_dcache_icache_hugepage(struct page *page)
  */
 
 pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
-				   unsigned *shift)
+				   bool *is_thp, unsigned *shift)
 {
 	pgd_t pgd, *pgdp;
 	pud_t pud, *pudp;
@@ -968,6 +969,9 @@ pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
 	if (shift)
 		*shift = 0;
 
+	if (is_thp)
+		*is_thp = false;
+
 	pgdp = pgdir + pgd_index(ea);
 	pgd  = READ_ONCE(*pgdp);
 	/*
@@ -1015,7 +1019,14 @@ pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
 			if (pmd_none(pmd))
 				return NULL;
 
-			if (pmd_huge(pmd) || pmd_large(pmd)) {
+			if (pmd_trans_huge(pmd)) {
+				if (is_thp)
+					*is_thp = true;
+				ret_pte = (pte_t *) pmdp;
+				goto out;
+			}
+
+			if (pmd_huge(pmd)) {
 				ret_pte = (pte_t *) pmdp;
 				goto out;
 			} else if (is_hugepd(__hugepd(pmd_val(pmd))))
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index c522969f012d..f7b80391bee7 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -190,6 +190,7 @@ void tlb_flush(struct mmu_gather *tlb)
 void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 			      unsigned long end)
 {
+	bool is_thp;
 	int hugepage_shift;
 	unsigned long flags;
 
@@ -208,21 +209,21 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 	local_irq_save(flags);
 	arch_enter_lazy_mmu_mode();
 	for (; start < end; start += PAGE_SIZE) {
-		pte_t *ptep = find_linux_pte_or_hugepte(mm->pgd, start,
+		pte_t *ptep = find_linux_pte_or_hugepte(mm->pgd, start, &is_thp,
 							&hugepage_shift);
 		unsigned long pte;
 
 		if (ptep == NULL)
 			continue;
 		pte = pte_val(*ptep);
-		if (hugepage_shift)
+		if (is_thp)
 			trace_hugepage_invalidate(start, pte);
 		if (!(pte & _PAGE_HASHPTE))
 			continue;
-		if (unlikely(hugepage_shift && pmd_trans_huge(*(pmd_t *)pte)))
+		if (unlikely(is_thp))
 			hpte_do_hugepage_flush(mm, start, (pmd_t *)ptep, pte);
 		else
-			hpte_need_flush(mm, start, ptep, pte, 0);
+			hpte_need_flush(mm, start, ptep, pte, hugepage_shift);
 	}
 	arch_leave_lazy_mmu_mode();
 	local_irq_restore(flags);
diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index ff09cde20cd2..e04a6752b399 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -127,7 +127,7 @@ static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
 		return -EFAULT;
 
 	local_irq_save(flags);
-	ptep = find_linux_pte_or_hugepte(pgdir, addr, &shift);
+	ptep = find_linux_pte_or_hugepte(pgdir, addr, NULL, &shift);
 	if (!ptep)
 		goto err_out;
 	if (!shift)
-- 
2.5.0
