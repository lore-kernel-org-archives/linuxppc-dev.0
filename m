Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EA84D1A2ABC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 10:36:24 +1100 (AEDT)
Message-ID: <1427153762.4770.266.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH] powerpc/mm/thp: Make page table walk safe against
 thp split/collapse
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 24 Mar 2015 10:36:02 +1100
In-Reply-To: <1427122851-22495-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1427122851-22495-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: anton@au1.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-23 at 20:30 +0530, Aneesh Kumar K.V wrote:

> -static inline pte_t *lookup_linux_ptep(pgd_t *pgdir, unsigned long hva,
> +static inline pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
>  				     unsigned long *pte_sizep)
>  {
>  	pte_t *ptep;
>  	unsigned long ps = *pte_sizep;
>  	unsigned int shift;
> +	unsigned long flags;
>  
> +	local_irq_save(flags);
>  	ptep = find_linux_pte_or_hugepte(pgdir, hva, &shift);
>  	if (!ptep)
> -		return NULL;
> +		goto err_out;
>  	if (shift)
>  		*pte_sizep = 1ul << shift;
>  	else
>  		*pte_sizep = PAGE_SIZE;
>  
>  	if (ps > *pte_sizep)
> -		return NULL;
> +		goto err_out;
>  
> -	return ptep;
> +	local_irq_restore(flags);
> +	return *ptep;
> +err_out:
> +	local_irq_restore(flags);
> +	return __pte(0);
>  }

Doesn't the above go backward vs. your explanation ? IE. You capture the
PTE *value* inside the lock then drop the lock and have no check for
splitting or anything, causing you to potentially return a stale PTE.

You assume the caller will check for splitting ? It doesn't ...

>  #endif /* __ASSEMBLY__ */
>  
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 3b2252e7731b..c2b44f250824 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -326,17 +326,21 @@ void eeh_slot_error_detail(struct eeh_pe *pe, int severity)
>  static inline unsigned long eeh_token_to_phys(unsigned long token)
>  {
>  	pte_t *ptep;
> -	unsigned long pa;
> +	unsigned long pa, flags;
>  	int hugepage_shift;
>  
>  	/*
>  	 * We won't find hugepages here, iomem
>  	 */
> +	local_irq_save(flags);
>  	ptep = find_linux_pte_or_hugepte(init_mm.pgd, token, &hugepage_shift);
> -	if (!ptep)
> +	if (!ptep) {
> +		local_irq_restore(flags);
>  		return token;
> +	}
>  	WARN_ON(hugepage_shift);
>  	pa = pte_pfn(*ptep) << PAGE_SHIFT;
> +	local_irq_restore(flags);

Isn't think the same as lookup_linux_pte ? Can't you just use that and
keep WARN_ON(psize != PAGE_SIZE) ?

>  	return pa | (token & (PAGE_SIZE-1));
>  }
> diff --git a/arch/powerpc/kernel/io-workarounds.c b/arch/powerpc/kernel/io-workarounds.c
> index 24b968f8e4d8..bd958d93fd38 100644
> --- a/arch/powerpc/kernel/io-workarounds.c
> +++ b/arch/powerpc/kernel/io-workarounds.c
> @@ -65,6 +65,7 @@ struct iowa_bus *iowa_mem_find_bus(const PCI_IO_ADDR addr)
>  	if (token && token <= iowa_bus_count)
>  		bus = &iowa_busses[token - 1];
>  	else {
> +		unsigned long flags;
>  		unsigned long vaddr, paddr;
>  		pte_t *ptep;
>  
> @@ -72,6 +73,7 @@ struct iowa_bus *iowa_mem_find_bus(const PCI_IO_ADDR addr)
>  		if (vaddr < PHB_IO_BASE || vaddr >= PHB_IO_END)
>  			return NULL;
>  
> +		local_irq_save(flags);
>  		ptep = find_linux_pte_or_hugepte(init_mm.pgd, vaddr,
>  						 &hugepage_shift);
>  		if (ptep == NULL)
> @@ -83,6 +85,7 @@ struct iowa_bus *iowa_mem_find_bus(const PCI_IO_ADDR addr)
>  			WARN_ON(hugepage_shift);
>  			paddr = pte_pfn(*ptep) << PAGE_SHIFT;
>  		}
> +		local_irq_restore(flags);
>  		bus = iowa_pci_find(vaddr, paddr);

Same.

>  		if (bus == NULL)
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 534acb3c6c3d..2dccaa6a1113 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -537,14 +537,15 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  		}
>  		/* if the guest wants write access, see if that is OK */
>  		if (!writing && hpte_is_writable(r)) {
> +			unsigned long flags;
>  			unsigned int hugepage_shift;
>  			pte_t *ptep, pte;
>  
>  			/*
>  			 * We need to protect against page table destruction
> -			 * while looking up and updating the pte.
> +			 * hugepage split and collapse.
>  			 */
> -			rcu_read_lock_sched();
> +			local_irq_save(flags);
>  			ptep = find_linux_pte_or_hugepte(current->mm->pgd,
>  							 hva, &hugepage_shift);
>  			if (ptep) {
> @@ -553,7 +554,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  				if (pte_write(pte))
>  					write_ok = 1;
>  			}
> -			rcu_read_unlock_sched();
> +			local_irq_restore(flags);
>  		}
>  	}

Ack.

> diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> index 625407e4d3b0..b0ad673b35cf 100644
> --- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> +++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> @@ -24,14 +24,19 @@
>  /* Translate address of a vmalloc'd thing to a linear map address */
>  static void *real_vmalloc_addr(void *x)
>  {
> +	unsigned long flags;
>  	unsigned long addr = (unsigned long) x;
>  	pte_t *p;
>  
> +	local_irq_save(flags);
>  	p = find_linux_pte_or_hugepte(swapper_pg_dir, addr, NULL);
> -	if (!p || !pte_present(*p))
> +	if (!p || !pte_present(*p)) {
> +		local_irq_restore(flags);
>  		return NULL;
> +	}
>  	/* assume we don't have huge pages in vmalloc space... */
>  	addr = (pte_pfn(*p) << PAGE_SHIFT) | (addr & ~PAGE_MASK);
> +	local_irq_restore(flags);
>  	return __va(addr);
>  }

This is called in real mode, I don't like the debug stuff that can
happen inside local_irq_* in that context. Can you either pounce that
to the higher level callers (and so not do it in real mode at all) or
use a lower level variant ? (I prefer going for the callers).

> @@ -134,20 +139,27 @@ static void remove_revmap_chain(struct kvm *kvm, long pte_index,
>  static pte_t lookup_linux_pte_and_update(pgd_t *pgdir, unsigned long hva,
>  			      int writing, unsigned long *pte_sizep)
>  {
> -	pte_t *ptep;
> +	pte_t *ptep, pte;
> +	unsigned long flags;
>  	unsigned long ps = *pte_sizep;
>  	unsigned int hugepage_shift;
>  
> +	local_irq_save(flags);
>  	ptep = find_linux_pte_or_hugepte(pgdir, hva, &hugepage_shift);
>  	if (!ptep)
> -		return __pte(0);
> +		goto err_out;
>  	if (hugepage_shift)
>  		*pte_sizep = 1ul << hugepage_shift;
>  	else
>  		*pte_sizep = PAGE_SIZE;
>  	if (ps > *pte_sizep)
> -		return __pte(0);
> -	return kvmppc_read_update_linux_pte(ptep, writing, hugepage_shift);
> +		goto err_out;
> +	pte = kvmppc_read_update_linux_pte(ptep, writing, hugepage_shift);
> +	local_irq_restore(flags);
> +	return pte;
> +err_out:
> +	local_irq_restore(flags);
> +	return __pte(0);
>  }

Ditto

>  static inline void unlock_hpte(__be64 *hpte, unsigned long hpte_v)
> @@ -211,6 +223,10 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
>  
>  	/* Look up the Linux PTE for the backing page */
>  	pte_size = psize;
> +	/*
> +	 * If we had a page table table change after lookup, we would
> +	 * retry via mmu_notifier_retry.
> +	 */
>  	pte = lookup_linux_pte_and_update(pgdir, hva, writing, &pte_size);
>  	if (pte_present(pte) && !pte_protnone(pte)) {
>  		if (writing && !pte_write(pte))
> diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
> index cc536d4a75ef..b50778eee650 100644
> --- a/arch/powerpc/kvm/e500_mmu_host.c
> +++ b/arch/powerpc/kvm/e500_mmu_host.c
> @@ -335,7 +335,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
>  	unsigned long mmu_seq;
>  	struct kvm *kvm = vcpu_e500->vcpu.kvm;
>  	unsigned long tsize_pages = 0;
> -	pte_t *ptep;
> +	pte_t pte;
>  	unsigned int wimg = 0;
>  	pgd_t *pgdir;
>  
> @@ -468,9 +468,16 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
>  
> 
>  	pgdir = vcpu_e500->vcpu.arch.pgdir;
> -	ptep = lookup_linux_ptep(pgdir, hva, &tsize_pages);
> -	if (pte_present(*ptep))
> -		wimg = (*ptep >> PTE_WIMGE_SHIFT) & MAS2_WIMGE_MASK;
> +	/*
> +	 * We are just looking at the wimg bits, so we don't
> +	 * care much about the trans splitting bit.
> +	 * How about hugepage collapse ? the pfn will change,
> +	 * may be we should hold mmap_sem ?. We also don't
> +	 * have a page reference count here .
> +	 */
> +	pte = lookup_linux_pte(pgdir, hva, &tsize_pages);
> +	if (pte_present(pte))
> +		wimg = (pte >> PTE_WIMGE_SHIFT) & MAS2_WIMGE_MASK;
>  	else {
>  		if (printk_ratelimit())
>  			pr_err("%s: pte not present: gfn %lx, pfn %lx\n",
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 7e408bfc7948..92f01649450a 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -108,8 +108,17 @@ int pgd_huge(pgd_t pgd)
>  
>  pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
>  {
> -	/* Only called for hugetlbfs pages, hence can ignore THP */
> -	return find_linux_pte_or_hugepte(mm->pgd, addr, NULL);
> +	unsigned long flags;
> +	pte_t *ptep;
> +	/*
> +	 * Only called for hugetlbfs pages, hence can ignore THP
> +	 * The save and restore are there only for avoiding the warning
> +	 * in find_linux_pte_or_hugepte().
> +	 */
> +	local_irq_save(flags);
> +	ptep = find_linux_pte_or_hugepte(mm->pgd, addr, NULL);
> +	local_irq_restore(flags);
> +	return ptep;
>  }
>  
>  static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
> @@ -681,28 +690,35 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
>  	} while (addr = next, addr != end);
>  }
>  
> +/*
> + * We are holding mmap_sem, so a parallel huge page collapse cannot run.
> + * To prevent hugepage split, disable irq.
> + */
>  struct page *
>  follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
>  {
>  	pte_t *ptep;
>  	struct page *page;
>  	unsigned shift;
> -	unsigned long mask;
> +	unsigned long mask, flags;
>  	/*
>  	 * Transparent hugepages are handled by generic code. We can skip them
>  	 * here.
>  	 */
> +	local_irq_save(flags);
>  	ptep = find_linux_pte_or_hugepte(mm->pgd, address, &shift);
>  
>  	/* Verify it is a huge page else bail. */
> -	if (!ptep || !shift || pmd_trans_huge(*(pmd_t *)ptep))
> +	if (!ptep || !shift || pmd_trans_huge(*(pmd_t *)ptep)) {
> +		local_irq_restore(flags);
>  		return ERR_PTR(-EINVAL);
> -
> +	}
>  	mask = (1UL << shift) - 1;
>  	page = pte_page(*ptep);
>  	if (page)
>  		page += (address & mask) / PAGE_SIZE;
>  
> +	local_irq_restore(flags);
>  	return page;
>  }
>  
> @@ -949,6 +965,8 @@ void flush_dcache_icache_hugepage(struct page *page)
>   *
>   * So long as we atomically load page table pointers we are safe against teardown,
>   * we can follow the address down to the the page and take a ref on it.
> + * Should be called with irq disabled. If is is splitting hugepage, we will return
> + * NULL;
>   */
>  
>  pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea, unsigned *shift)
> @@ -963,6 +981,11 @@ pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea, unsigned *shift
>  	if (shift)
>  		*shift = 0;
>  
> +	if (!irqs_disabled()) {

Might want to use the arch_* variant for similar "beware of generic
debug stuff in real mode" reasons...

> +		pr_info("%s called with irq enabled\n", __func__);
> +		dump_stack();
> +	}
> +
>  	pgdp = pgdir + pgd_index(ea);
>  	pgd  = ACCESS_ONCE(*pgdp);
>  	/*
> diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
> index 2396dda282cd..173e4abc0c56 100644
> --- a/arch/powerpc/perf/callchain.c
> +++ b/arch/powerpc/perf/callchain.c
> @@ -125,6 +125,7 @@ static int read_user_stack_slow(void __user *ptr, void *ret, int nb)
>  	if (!pgdir)
>  		return -EFAULT;
>  
> +	/* FIXME!! I guess we come with irq disabled here ? */

Not that I know of, that's not guaranteed.

>  	ptep = find_linux_pte_or_hugepte(pgdir, addr, &shift);
>  	if (!shift)
>  		shift = PAGE_SHIFT;
