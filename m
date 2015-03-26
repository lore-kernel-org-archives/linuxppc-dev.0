Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 665F01A0B7A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 00:14:20 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 26 Mar 2015 18:44:17 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6C751E0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 18:46:31 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2QDEGJK51511334
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 18:44:16 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2QD5PDd025899
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 18:35:26 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH V4 3/4] powerpc/mm/thp: Make page table walk safe against thp
 split/collapse
Date: Thu, 26 Mar 2015 18:43:41 +0530
Message-Id: <1427375622-3708-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1427375622-3708-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1427375622-3708-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

We can disable a THP split or a hugepage collapse by disabling irq.
We do send IPI to all the cpus in the early part of split/collapse,
and disabling local irq ensure we don't make progress with
split/collapse. If the THP is getting split we return NULL from
find_linux_pte_or_hugepte(). For all the current callers it should be ok.
We need to be careful if we want to use returned pte_t pointer outside
the irq disabled region. W.r.t to THP split, the pfn remains the same,
but then a hugepage collapse will result in a pfn change. There are
few steps we can take to avoid a hugepage collapse.One way is to take page
reference inside the irq disable region. Other option is to take
mmap_sem so that a parallel collapse will not happen. We can also
disable collapse by taking pmd_lock. Another method used by kvm
subsystem is to check whether we had a mmu_notifer update in between
using mmu_notifier_retry().

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Changes from V3:
* Split the pmd_trans_splitting related changes into a new patch
  Now we don't have any change related how we handle trans splitting pmd
  in this patch

 arch/powerpc/include/asm/pgtable.h   | 11 ++++++++++-
 arch/powerpc/kernel/eeh.c            |  6 ++++--
 arch/powerpc/kernel/io-workarounds.c | 10 +++++-----
 arch/powerpc/kvm/book3s_64_mmu_hv.c  |  5 +++--
 arch/powerpc/kvm/book3s_hv_rm_mmu.c  | 30 +++++++++++++++++++++++-------
 arch/powerpc/kvm/e500_mmu_host.c     | 14 ++++++++++++--
 arch/powerpc/mm/hash_utils_64.c      |  2 +-
 arch/powerpc/mm/hugetlbpage.c        | 20 ++++++++++++++------
 arch/powerpc/perf/callchain.c        | 24 ++++++++++++++----------
 9 files changed, 86 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 92fe01c355a9..11a38635dd65 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -247,8 +247,17 @@ extern int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 #define pmd_large(pmd)		0
 #define has_transparent_hugepage() 0
 #endif
-pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
+pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
 				 unsigned *shift);
+static inline pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
+					       unsigned *shift)
+{
+	if (!arch_irqs_disabled()) {
+		pr_info("%s called with irq enabled\n", __func__);
+		dump_stack();
+	}
+	return __find_linux_pte_or_hugepte(pgdir, ea, shift);
+}
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 3b2252e7731b..8424b232e598 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -330,9 +330,11 @@ static inline unsigned long eeh_token_to_phys(unsigned long token)
 	int hugepage_shift;
 
 	/*
-	 * We won't find hugepages here, iomem
+	 * We won't find hugepages here(this is iomem). Hence we are not
+	 * worried about _PAGE_SPLITTING/collapse. Also we will not hit
+	 * page table free, because of init_mm.
 	 */
-	ptep = find_linux_pte_or_hugepte(init_mm.pgd, token, &hugepage_shift);
+	ptep = __find_linux_pte_or_hugepte(init_mm.pgd, token, &hugepage_shift);
 	if (!ptep)
 		return token;
 	WARN_ON(hugepage_shift);
diff --git a/arch/powerpc/kernel/io-workarounds.c b/arch/powerpc/kernel/io-workarounds.c
index 24b968f8e4d8..63d9cc4d7366 100644
--- a/arch/powerpc/kernel/io-workarounds.c
+++ b/arch/powerpc/kernel/io-workarounds.c
@@ -71,15 +71,15 @@ struct iowa_bus *iowa_mem_find_bus(const PCI_IO_ADDR addr)
 		vaddr = (unsigned long)PCI_FIX_ADDR(addr);
 		if (vaddr < PHB_IO_BASE || vaddr >= PHB_IO_END)
 			return NULL;
-
-		ptep = find_linux_pte_or_hugepte(init_mm.pgd, vaddr,
+		/*
+		 * We won't find huge pages here (iomem). Also can't hit
+		 * a page table free due to init_mm
+		 */
+		ptep = __find_linux_pte_or_hugepte(init_mm.pgd, vaddr,
 						 &hugepage_shift);
 		if (ptep == NULL)
 			paddr = 0;
 		else {
-			/*
-			 * we don't have hugepages backing iomem
-			 */
 			WARN_ON(hugepage_shift);
 			paddr = pte_pfn(*ptep) << PAGE_SHIFT;
 		}
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 534acb3c6c3d..26df3864d85a 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -539,12 +539,13 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		if (!writing && hpte_is_writable(r)) {
 			unsigned int hugepage_shift;
 			pte_t *ptep, pte;
+			unsigned long flags;
 
 			/*
 			 * We need to protect against page table destruction
 			 * while looking up and updating the pte.
 			 */
-			rcu_read_lock_sched();
+			local_irq_save(flags);
 			ptep = find_linux_pte_or_hugepte(current->mm->pgd,
 							 hva, &hugepage_shift);
 			if (ptep) {
@@ -553,7 +554,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 				if (pte_write(pte))
 					write_ok = 1;
 			}
-			rcu_read_unlock_sched();
+			local_irq_restore(flags);
 		}
 	}
 
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 73e083cb9f7e..f559b25de173 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -26,11 +26,14 @@ static void *real_vmalloc_addr(void *x)
 {
 	unsigned long addr = (unsigned long) x;
 	pte_t *p;
-
-	p = find_linux_pte_or_hugepte(swapper_pg_dir, addr, NULL);
+	/*
+	 * assume we don't have huge pages in vmalloc space...
+	 * So don't worry about THP collapse/split. Called
+	 * Only in realmode, hence won't need irq_save/restore.
+	 */
+	p = __find_linux_pte_or_hugepte(swapper_pg_dir, addr, NULL);
 	if (!p || !pte_present(*p))
 		return NULL;
-	/* assume we don't have huge pages in vmalloc space... */
 	addr = (pte_pfn(*p) << PAGE_SHIFT) | (addr & ~PAGE_MASK);
 	return __va(addr);
 }
@@ -153,7 +156,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 	pte_t *ptep;
 	unsigned int writing;
 	unsigned long mmu_seq;
-	unsigned long rcbits;
+	unsigned long rcbits, irq_flags = 0;
 
 	psize = hpte_page_size(pteh, ptel);
 	if (!psize)
@@ -189,7 +192,16 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 
 	/* Translate to host virtual address */
 	hva = __gfn_to_hva_memslot(memslot, gfn);
-	ptep = find_linux_pte_or_hugepte(pgdir, hva, &hpage_shift);
+	/*
+	 * If we had a page table table change after lookup, we would
+	 * retry via mmu_notifier_retry.
+	 */
+	if (realmode)
+		ptep = __find_linux_pte_or_hugepte(pgdir, hva, &hpage_shift);
+	else {
+		local_irq_save(irq_flags);
+		ptep = find_linux_pte_or_hugepte(pgdir, hva, &hpage_shift);
+	}
 	if (ptep) {
 		pte_t pte;
 		unsigned int host_pte_size;
@@ -202,9 +214,11 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 		 * We should always find the guest page size
 		 * to <= host page size, if host is using hugepage
 		 */
-		if (host_pte_size < psize)
+		if (host_pte_size < psize) {
+			if (!realmode)
+				local_irq_restore(flags);
 			return H_PARAMETER;
-
+		}
 		pte = kvmppc_read_update_linux_pte(ptep, writing, hpage_shift);
 		if (pte_present(pte) && !pte_protnone(pte)) {
 			if (writing && !pte_write(pte))
@@ -216,6 +230,8 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 			pa |= gpa & ~PAGE_MASK;
 		}
 	}
+	if (!realmode)
+		local_irq_restore(irq_flags);
 
 	ptel &= ~(HPTE_R_PP0 - psize);
 	ptel |= pa;
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index a1f5b0d4b1d6..4d33e199edcc 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -338,6 +338,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	pte_t *ptep;
 	unsigned int wimg = 0;
 	pgd_t *pgdir;
+	unsigned long flags;
 
 	/* used to check for invalidations in progress */
 	mmu_seq = kvm->mmu_notifier_seq;
@@ -468,14 +469,23 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 
 
 	pgdir = vcpu_e500->vcpu.arch.pgdir;
+	/*
+	 * We are just looking at the wimg bits, so we don't
+	 * care much about the trans splitting bit.
+	 * We are holding kvm->mmu_lock so a notifier invalidate
+	 * can't run hence pfn won't change.
+	 */
+	local_irq_save(flags);
 	ptep = find_linux_pte_or_hugepte(pgdir, hva, NULL);
 	if (ptep) {
 		pte_t pte = READ_ONCE(*ptep);
 
-		if (pte_present(pte))
+		if (pte_present(pte)) {
 			wimg = (pte_val(pte) >> PTE_WIMGE_SHIFT) &
 				MAS2_WIMGE_MASK;
-		else {
+			local_irq_restore(flags);
+		} else {
+			local_irq_restore(flags);
 			pr_err_ratelimited("%s: pte not present: gfn %lx,pfn %lx\n",
 					   __func__, (long)gfn, pfn);
 			ret = -EINVAL;
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 2c2022d16059..444f7a5b859b 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1066,7 +1066,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 #endif /* CONFIG_PPC_64K_PAGES */
 
 	/* Get PTE and page size from page tables */
-	ptep = find_linux_pte_or_hugepte(pgdir, ea, &hugeshift);
+	ptep = __find_linux_pte_or_hugepte(pgdir, ea, &hugeshift);
 	if (ptep == NULL || !pte_present(*ptep)) {
 		DBG_LOW(" no PTE !\n");
 		rc = 1;
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index fa9d5c238d22..d79cd3190b39 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -109,7 +109,7 @@ int pgd_huge(pgd_t pgd)
 pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
 	/* Only called for hugetlbfs pages, hence can ignore THP */
-	return find_linux_pte_or_hugepte(mm->pgd, addr, NULL);
+	return __find_linux_pte_or_hugepte(mm->pgd, addr, NULL);
 }
 
 static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
@@ -681,28 +681,35 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 	} while (addr = next, addr != end);
 }
 
+/*
+ * We are holding mmap_sem, so a parallel huge page collapse cannot run.
+ * To prevent hugepage split, disable irq.
+ */
 struct page *
 follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
 {
 	pte_t *ptep;
 	struct page *page;
 	unsigned shift;
-	unsigned long mask;
+	unsigned long mask, flags;
 	/*
 	 * Transparent hugepages are handled by generic code. We can skip them
 	 * here.
 	 */
+	local_irq_save(flags);
 	ptep = find_linux_pte_or_hugepte(mm->pgd, address, &shift);
 
 	/* Verify it is a huge page else bail. */
-	if (!ptep || !shift || pmd_trans_huge(*(pmd_t *)ptep))
+	if (!ptep || !shift || pmd_trans_huge(*(pmd_t *)ptep)) {
+		local_irq_restore(flags);
 		return ERR_PTR(-EINVAL);
-
+	}
 	mask = (1UL << shift) - 1;
 	page = pte_page(*ptep);
 	if (page)
 		page += (address & mask) / PAGE_SIZE;
 
+	local_irq_restore(flags);
 	return page;
 }
 
@@ -951,7 +958,8 @@ void flush_dcache_icache_hugepage(struct page *page)
  * we can follow the address down to the the page and take a ref on it.
  */
 
-pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea, unsigned *shift)
+pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
+				   unsigned *shift)
 {
 	pgd_t pgd, *pgdp;
 	pud_t pud, *pudp;
@@ -1030,7 +1038,7 @@ out:
 		*shift = pdshift;
 	return ret_pte;
 }
-EXPORT_SYMBOL_GPL(find_linux_pte_or_hugepte);
+EXPORT_SYMBOL_GPL(__find_linux_pte_or_hugepte);
 
 int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		unsigned long end, int write, struct page **pages, int *nr)
diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index 2396dda282cd..a5162d789cfc 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -111,41 +111,45 @@ perf_callchain_kernel(struct perf_callchain_entry *entry, struct pt_regs *regs)
  * interrupt context, so if the access faults, we read the page tables
  * to find which page (if any) is mapped and access it directly.
  */
-static int read_user_stack_slow(void __user *ptr, void *ret, int nb)
+static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
 {
+	int ret = -EFAULT;
 	pgd_t *pgdir;
 	pte_t *ptep, pte;
 	unsigned shift;
 	unsigned long addr = (unsigned long) ptr;
 	unsigned long offset;
-	unsigned long pfn;
+	unsigned long pfn, flags;
 	void *kaddr;
 
 	pgdir = current->mm->pgd;
 	if (!pgdir)
 		return -EFAULT;
 
+	local_irq_save(flags);
 	ptep = find_linux_pte_or_hugepte(pgdir, addr, &shift);
+	if (!ptep)
+		goto err_out;
 	if (!shift)
 		shift = PAGE_SHIFT;
 
 	/* align address to page boundary */
 	offset = addr & ((1UL << shift) - 1);
-	addr -= offset;
 
-	if (ptep == NULL)
-		return -EFAULT;
-	pte = *ptep;
+	pte = READ_ONCE(*ptep);
 	if (!pte_present(pte) || !(pte_val(pte) & _PAGE_USER))
-		return -EFAULT;
+		goto err_out;
 	pfn = pte_pfn(pte);
 	if (!page_is_ram(pfn))
-		return -EFAULT;
+		goto err_out;
 
 	/* no highmem to worry about here */
 	kaddr = pfn_to_kaddr(pfn);
-	memcpy(ret, kaddr + offset, nb);
-	return 0;
+	memcpy(buf, kaddr + offset, nb);
+	ret = 0;
+err_out:
+	local_irq_restore(flags);
+	return ret;
 }
 
 static int read_user_stack_64(unsigned long __user *ptr, unsigned long *ret)
-- 
2.1.0
