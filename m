Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBlnF6qFTzDqC3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 21:22:09 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 13/20] KVM: PPC: Book3S HV: Page table construction and
 page faults for radix guests
Date: Mon, 30 Jan 2017 21:21:46 +1100
Message-Id: <1485771713-24801-14-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
References: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds the code to construct the second-level ("partition-scoped" in
architecturese) page tables for guests using the radix MMU.  Apart from
the PGD level, which is allocated when the guest is created, the rest
of the tree is all constructed in response to hypervisor page faults.

As well as hypervisor page faults for missing pages, we also get faults
for reference/change (RC) bits needing to be set, as well as various
other error conditions.  For now, we only set the R or C bit in the
guest page table if the same bit is set in the host PTE for the
backing page.

This code can take advantage of the guest being backed with either
transparent or ordinary 2MB huge pages, and insert 2MB page entries
into the guest page tables.  There is no support for 1GB huge pages
yet.
---
 arch/powerpc/include/asm/kvm_book3s.h  |   8 +
 arch/powerpc/kvm/book3s.c              |   1 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c    |   7 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 385 +++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c           |  17 +-
 5 files changed, 415 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 7adfcc0..ff5cd5c 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -170,6 +170,8 @@ extern int kvmppc_book3s_hv_page_fault(struct kvm_run *run,
 			unsigned long status);
 extern long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr,
 			unsigned long slb_v, unsigned long valid);
+extern int kvmppc_hv_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu,
+			unsigned long gpa, gva_t ea, int is_store);
 
 extern void kvmppc_mmu_hpte_cache_map(struct kvm_vcpu *vcpu, struct hpte_cache *pte);
 extern struct hpte_cache *kvmppc_mmu_hpte_cache_next(struct kvm_vcpu *vcpu);
@@ -182,8 +184,14 @@ extern void kvmppc_mmu_hpte_sysexit(void);
 extern int kvmppc_mmu_hv_init(void);
 extern int kvmppc_book3s_hcall_implemented(struct kvm *kvm, unsigned long hc);
 
+extern int kvmppc_book3s_radix_page_fault(struct kvm_run *run,
+			struct kvm_vcpu *vcpu,
+			unsigned long ea, unsigned long dsisr);
 extern int kvmppc_mmu_radix_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 			struct kvmppc_pte *gpte, bool data, bool iswrite);
+extern void kvmppc_free_radix(struct kvm *kvm);
+extern int kvmppc_radix_init(void);
+extern void kvmppc_radix_exit(void);
 
 /* XXX remove this export when load_last_inst() is generic */
 extern int kvmppc_ld(struct kvm_vcpu *vcpu, ulong *eaddr, int size, void *ptr, bool data);
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 019f008..b6b5c18 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -239,6 +239,7 @@ void kvmppc_core_queue_data_storage(struct kvm_vcpu *vcpu, ulong dar,
 	kvmppc_set_dsisr(vcpu, flags);
 	kvmppc_book3s_queue_irqprio(vcpu, BOOK3S_INTERRUPT_DATA_STORAGE);
 }
+EXPORT_SYMBOL_GPL(kvmppc_core_queue_data_storage);	/* used by kvm_hv */
 
 void kvmppc_core_queue_inst_storage(struct kvm_vcpu *vcpu, ulong flags)
 {
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index c208bf3..57690c2 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -395,8 +395,8 @@ static int instruction_is_store(unsigned int instr)
 	return (instr & mask) != 0;
 }
 
-static int kvmppc_hv_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu,
-				  unsigned long gpa, gva_t ea, int is_store)
+int kvmppc_hv_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu,
+			   unsigned long gpa, gva_t ea, int is_store)
 {
 	u32 last_inst;
 
@@ -461,6 +461,9 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	unsigned long rcbits;
 	long mmio_update;
 
+	if (kvm_is_radix(kvm))
+		return kvmppc_book3s_radix_page_fault(run, vcpu, ea, dsisr);
+
 	/*
 	 * Real-mode code has already searched the HPT and found the
 	 * entry we're interested in.  Lock the entry and check that
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 9091407..865ea9b 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -137,3 +137,388 @@ int kvmppc_mmu_radix_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 	return 0;
 }
 
+#ifdef CONFIG_PPC_64K_PAGES
+#define MMU_BASE_PSIZE	MMU_PAGE_64K
+#else
+#define MMU_BASE_PSIZE	MMU_PAGE_4K
+#endif
+
+static void kvmppc_radix_tlbie_page(struct kvm *kvm, unsigned long addr,
+				    unsigned int pshift)
+{
+	int psize = MMU_BASE_PSIZE;
+
+	if (pshift >= PMD_SHIFT)
+		psize = MMU_PAGE_2M;
+	addr &= ~0xfffUL;
+	addr |= mmu_psize_defs[psize].ap << 5;
+	asm volatile("ptesync": : :"memory");
+	asm volatile(PPC_TLBIE_5(%0, %1, 0, 0, 1)
+		     : : "r" (addr), "r" (kvm->arch.lpid) : "memory");
+	asm volatile("ptesync": : :"memory");
+}
+
+void kvmppc_radix_update_pte(struct kvm *kvm, pte_t *ptep, unsigned long clr,
+			     unsigned long set, unsigned long addr,
+			     unsigned int shift)
+{
+	if (!(clr & _PAGE_PRESENT) && cpu_has_feature(CPU_FTR_POWER9_DD1) &&
+	    pte_present(*ptep)) {
+		/* have to invalidate it first */
+		__radix_pte_update(ptep, _PAGE_PRESENT, 0);
+		kvmppc_radix_tlbie_page(kvm, addr, shift);
+		set |= _PAGE_PRESENT;
+	}
+	__radix_pte_update(ptep, clr, set);
+}
+
+void kvmppc_radix_set_pte_at(struct kvm *kvm, unsigned long addr,
+			     pte_t *ptep, pte_t pte)
+{
+	radix__set_pte_at(kvm->mm, addr, ptep, pte, 0);
+}
+
+static struct kmem_cache *kvm_pte_cache;
+
+static pte_t *kvmppc_pte_alloc(void)
+{
+	return kmem_cache_alloc(kvm_pte_cache, GFP_KERNEL);
+}
+
+static void kvmppc_pte_free(pte_t *ptep)
+{
+	kmem_cache_free(kvm_pte_cache, ptep);
+}
+
+static int kvmppc_create_pte(struct kvm *kvm, pte_t pte, unsigned long gpa,
+			     unsigned int level, unsigned long mmu_seq)
+{
+	pgd_t *pgd;
+	pud_t *pud, *new_pud = NULL;
+	pmd_t *pmd, *new_pmd = NULL;
+	pte_t *ptep, *new_ptep = NULL;
+	int ret;
+
+	/* Traverse the guest's 2nd-level tree, allocate new levels needed */
+	pgd = kvm->arch.pgtable + pgd_index(gpa);
+	pud = NULL;
+	if (pgd_present(*pgd))
+		pud = pud_offset(pgd, gpa);
+	else
+		new_pud = pud_alloc_one(kvm->mm, gpa);
+
+	pmd = NULL;
+	if (pud && pud_present(*pud))
+		pmd = pmd_offset(pud, gpa);
+	else
+		new_pmd = pmd_alloc_one(kvm->mm, gpa);
+
+	if (level == 0 && !(pmd && pmd_present(*pmd)))
+		new_ptep = kvmppc_pte_alloc();
+
+	/* Check if we might have been invalidated; let the guest retry if so */
+	spin_lock(&kvm->mmu_lock);
+	ret = -EAGAIN;
+	if (mmu_notifier_retry(kvm, mmu_seq))
+		goto out_unlock;
+
+	/* Now traverse again under the lock and change the tree */
+	ret = -ENOMEM;
+	if (pgd_none(*pgd)) {
+		if (!new_pud)
+			goto out_unlock;
+		pgd_populate(kvm->mm, pgd, new_pud);
+		new_pud = NULL;
+	}
+	pud = pud_offset(pgd, gpa);
+	if (pud_none(*pud)) {
+		if (!new_pmd)
+			goto out_unlock;
+		pud_populate(kvm->mm, pud, new_pmd);
+		new_pmd = NULL;
+	}
+	pmd = pmd_offset(pud, gpa);
+	if (pmd_large(*pmd)) {
+		/* Someone else has instantiated a large page here; retry */
+		ret = -EAGAIN;
+		goto out_unlock;
+	}
+	if (level == 1 && !pmd_none(*pmd)) {
+		/*
+		 * There's a page table page here, but we wanted
+		 * to install a large page.  Tell the caller and let
+		 * it try installing a normal page if it wants.
+		 */
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	if (level == 0) {
+		if (pmd_none(*pmd)) {
+			if (!new_ptep)
+				goto out_unlock;
+			pmd_populate(kvm->mm, pmd, new_ptep);
+			new_ptep = NULL;
+		}
+		ptep = pte_offset_kernel(pmd, gpa);
+		if (pte_present(*ptep)) {
+			/* PTE was previously valid, so invalidate it */
+			kvmppc_radix_update_pte(kvm, ptep, _PAGE_PRESENT,
+						0, gpa, 0);
+			kvmppc_radix_tlbie_page(kvm, gpa, 0);
+		}
+		kvmppc_radix_set_pte_at(kvm, gpa, ptep, pte);
+	} else {
+		kvmppc_radix_set_pte_at(kvm, gpa, pmdp_ptep(pmd), pte);
+	}
+	ret = 0;
+
+ out_unlock:
+	spin_unlock(&kvm->mmu_lock);
+	if (new_pud)
+		pud_free(kvm->mm, new_pud);
+	if (new_pmd)
+		pmd_free(kvm->mm, new_pmd);
+	if (new_ptep)
+		kvmppc_pte_free(new_ptep);
+	return ret;
+}
+
+int kvmppc_book3s_radix_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
+				   unsigned long ea, unsigned long dsisr)
+{
+	struct kvm *kvm = vcpu->kvm;
+	unsigned long mmu_seq, pte_size;
+	unsigned long gpa, gfn, hva, pfn;
+	struct kvm_memory_slot *memslot;
+	struct page *page = NULL, *pages[1];
+	long ret, npages, ok;
+	unsigned int writing;
+	struct vm_area_struct *vma;
+	unsigned long flags;
+	pte_t pte, *ptep;
+	unsigned long pgflags;
+	unsigned int shift, level;
+
+	/* Check for unusual errors */
+	if (dsisr & DSISR_UNSUPP_MMU) {
+		pr_err("KVM: Got unsupported MMU fault\n");
+		return -EFAULT;
+	}
+	if (dsisr & DSISR_BADACCESS) {
+		/* Reflect to the guest as DSI */
+		pr_err("KVM: Got radix HV page fault with DSISR=%lx\n", dsisr);
+		kvmppc_core_queue_data_storage(vcpu, ea, dsisr);
+		return RESUME_GUEST;
+	}
+
+	/* Translate the logical address and get the page */
+	gpa = vcpu->arch.fault_gpa & ~0xfffUL;
+	gpa &= ~0xF000000000000000ul;
+	gfn = gpa >> PAGE_SHIFT;
+	if (!(dsisr & DSISR_PGDIRFAULT))
+		gpa |= ea & 0xfff;
+	memslot = gfn_to_memslot(kvm, gfn);
+
+	/* No memslot means it's an emulated MMIO region */
+	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID)) {
+		if (dsisr & (DSISR_PGDIRFAULT | DSISR_BADACCESS |
+			     DSISR_SET_RC)) {
+			/*
+			 * Bad address in guest page table tree, or other
+			 * unusual error - reflect it to the guest as DSI.
+			 */
+			kvmppc_core_queue_data_storage(vcpu, ea, dsisr);
+			return RESUME_GUEST;
+		}
+		return kvmppc_hv_emulate_mmio(run, vcpu, gpa, ea,
+					      dsisr & DSISR_ISSTORE);
+	}
+
+	/* used to check for invalidations in progress */
+	mmu_seq = kvm->mmu_notifier_seq;
+	smp_rmb();
+
+	writing = (dsisr & DSISR_ISSTORE) != 0;
+	hva = gfn_to_hva_memslot(memslot, gfn);
+	if (dsisr & DSISR_SET_RC) {
+		/*
+		 * Need to set an R or C bit in the 2nd-level tables;
+		 * if the relevant bits aren't already set in the linux
+		 * page tables, fall through to do the gup_fast to
+		 * set them in the linux page tables too.
+		 */
+		ok = 0;
+		pgflags = _PAGE_ACCESSED;
+		if (writing)
+			pgflags |= _PAGE_DIRTY;
+		local_irq_save(flags);
+		ptep = __find_linux_pte_or_hugepte(current->mm->pgd, hva,
+						   NULL, NULL);
+		if (ptep) {
+			pte = READ_ONCE(*ptep);
+			if (pte_present(pte) &&
+			    (pte_val(pte) & pgflags) == pgflags)
+				ok = 1;
+		}
+		local_irq_restore(flags);
+		if (ok) {
+			spin_lock(&kvm->mmu_lock);
+			if (mmu_notifier_retry(vcpu->kvm, mmu_seq)) {
+				spin_unlock(&kvm->mmu_lock);
+				return RESUME_GUEST;
+			}
+			ptep = __find_linux_pte_or_hugepte(kvm->arch.pgtable,
+							gpa, NULL, &shift);
+			if (ptep && pte_present(*ptep)) {
+				kvmppc_radix_update_pte(kvm, ptep, 0, pgflags,
+							gpa, shift);
+				spin_unlock(&kvm->mmu_lock);
+				return RESUME_GUEST;
+			}
+			spin_unlock(&kvm->mmu_lock);
+		}
+	}
+
+	ret = -EFAULT;
+	pfn = 0;
+	pte_size = PAGE_SIZE;
+	pgflags = _PAGE_READ | _PAGE_EXEC;
+	level = 0;
+	npages = get_user_pages_fast(hva, 1, writing, pages);
+	if (npages < 1) {
+		/* Check if it's an I/O mapping */
+		down_read(&current->mm->mmap_sem);
+		vma = find_vma(current->mm, hva);
+		if (vma && vma->vm_start <= hva && hva < vma->vm_end &&
+		    (vma->vm_flags & VM_PFNMAP)) {
+			pfn = vma->vm_pgoff +
+				((hva - vma->vm_start) >> PAGE_SHIFT);
+			pgflags = pgprot_val(vma->vm_page_prot);
+		}
+		up_read(&current->mm->mmap_sem);
+		if (!pfn)
+			return -EFAULT;
+	} else {
+		page = pages[0];
+		pfn = page_to_pfn(page);
+		if (PageHuge(page)) {
+			page = compound_head(page);
+			pte_size <<= compound_order(page);
+			/* See if we can insert a 2MB large-page PTE here */
+			if (pte_size >= PMD_SIZE &&
+			    (gpa & PMD_MASK & PAGE_MASK) ==
+			    (hva & PMD_MASK & PAGE_MASK)) {
+				level = 1;
+				pfn &= ~((PMD_SIZE >> PAGE_SHIFT) - 1);
+			}
+		}
+		/* See if we can provide write access */
+		if (writing) {
+			/*
+			 * We assume gup_fast has set dirty on the host PTE.
+			 */
+			pgflags |= _PAGE_WRITE;
+		} else {
+			local_irq_save(flags);
+			ptep = __find_linux_pte_or_hugepte(current->mm->pgd,
+							hva, NULL, NULL);
+			if (ptep && pte_write(*ptep) && pte_dirty(*ptep))
+				pgflags |= _PAGE_WRITE;
+			local_irq_restore(flags);
+		}
+	}
+
+	/*
+	 * Compute the PTE value that we need to insert.
+	 */
+	pgflags |= _PAGE_PRESENT | _PAGE_PTE | _PAGE_ACCESSED;
+	if (pgflags & _PAGE_WRITE)
+		pgflags |= _PAGE_DIRTY;
+	pte = pfn_pte(pfn, __pgprot(pgflags));
+
+	/* Allocate space in the tree and write the PTE */
+	ret = kvmppc_create_pte(kvm, pte, gpa, level, mmu_seq);
+	if (ret == -EBUSY) {
+		/*
+		 * There's already a PMD where wanted to install a large page;
+		 * for now, fall back to installing a small page.
+		 */
+		level = 0;
+		pfn |= gfn & ((PMD_SIZE >> PAGE_SHIFT) - 1);
+		pte = pfn_pte(pfn, __pgprot(pgflags));
+		ret = kvmppc_create_pte(kvm, pte, gpa, level, mmu_seq);
+	}
+	if (ret == 0 || ret == -EAGAIN)
+		ret = RESUME_GUEST;
+
+	if (page) {
+		/*
+		 * We drop pages[0] here, not page because page might
+		 * have been set to the head page of a compound, but
+		 * we have to drop the reference on the correct tail
+		 * page to match the get inside gup()
+		 */
+		put_page(pages[0]);
+	}
+	return ret;
+}
+
+void kvmppc_free_radix(struct kvm *kvm)
+{
+	unsigned long ig, iu, im;
+	pte_t *pte;
+	pmd_t *pmd;
+	pud_t *pud;
+	pgd_t *pgd;
+
+	if (!kvm->arch.pgtable)
+		return;
+	pgd = kvm->arch.pgtable;
+	for (ig = 0; ig < PTRS_PER_PGD; ++ig, ++pgd) {
+		if (!pgd_present(*pgd))
+			continue;
+		pud = pud_offset(pgd, 0);
+		for (iu = 0; iu < PTRS_PER_PUD; ++iu, ++pud) {
+			if (!pud_present(*pud))
+				continue;
+			pmd = pmd_offset(pud, 0);
+			for (im = 0; im < PTRS_PER_PMD; ++im, ++pmd) {
+				if (pmd_huge(*pmd)) {
+					pmd_clear(pmd);
+					continue;
+				}
+				if (!pmd_present(*pmd))
+					continue;
+				pte = pte_offset_map(pmd, 0);
+				memset(pte, 0, sizeof(long) << PTE_INDEX_SIZE);
+				kvmppc_pte_free(pte);
+				pmd_clear(pmd);
+			}
+			pmd_free(kvm->mm, pmd_offset(pud, 0));
+			pud_clear(pud);
+		}
+		pud_free(kvm->mm, pud_offset(pgd, 0));
+		pgd_clear(pgd);
+	}
+	pgd_free(kvm->mm, kvm->arch.pgtable);
+}
+
+static void pte_ctor(void *addr)
+{
+	memset(addr, 0, PTE_TABLE_SIZE);
+}
+
+int kvmppc_radix_init(void)
+{
+	unsigned long size = sizeof(void *) << PTE_INDEX_SIZE;
+
+	kvm_pte_cache = kmem_cache_create("kvm-pte", size, size, 0, pte_ctor);
+	if (!kvm_pte_cache)
+		return -ENOMEM;
+	return 0;
+}
+
+void kvmppc_radix_exit(void)
+{
+	kmem_cache_destroy(kvm_pte_cache);
+}
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index bb28543..d50251f 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3356,7 +3356,10 @@ static void kvmppc_core_destroy_vm_hv(struct kvm *kvm)
 
 	kvmppc_free_vcores(kvm);
 
-	kvmppc_free_hpt(kvm);
+	if (kvm_is_radix(kvm))
+		kvmppc_free_radix(kvm);
+	else
+		kvmppc_free_hpt(kvm);
 
 	kvmppc_free_pimap(kvm);
 }
@@ -3768,6 +3771,11 @@ static int kvm_init_subcore_bitmap(void)
 	return 0;
 }
 
+static int kvmppc_radix_possible(void)
+{
+	return cpu_has_feature(CPU_FTR_ARCH_300) && radix_enabled();
+}
+
 static int kvmppc_book3s_init_hv(void)
 {
 	int r;
@@ -3807,12 +3815,19 @@ static int kvmppc_book3s_init_hv(void)
 	init_vcore_lists();
 
 	r = kvmppc_mmu_hv_init();
+	if (r)
+		return r;
+
+	if (kvmppc_radix_possible())
+		r = kvmppc_radix_init();
 	return r;
 }
 
 static void kvmppc_book3s_exit_hv(void)
 {
 	kvmppc_free_host_rm_ops();
+	if (kvmppc_radix_possible())
+		kvmppc_radix_exit();
 	kvmppc_hv_ops = NULL;
 }
 
-- 
2.7.4
