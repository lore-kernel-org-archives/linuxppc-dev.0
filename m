Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F19ADDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 17:36:25 +1100 (EST)
Subject: Re: [PATCH] cpumask: use mm_cpumask() wrapper: powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <200903161446.43726.rusty@rustcorp.com.au>
References: <200903161446.43726.rusty@rustcorp.com.au>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 Mar 2009 17:36:17 +1100
Message-Id: <1237530977.25062.572.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-03-16 at 14:46 +1030, Rusty Russell wrote:
> Makes code futureproof against the impending change to mm->cpu_vm_mask.
> 
> It's also a chance to use the new cpumask_ ops which take a pointer
> (the older ones are deprecated, but there's no hurry for arch code).

Boom :-)

In file included from /home/benh/linux-powerpc-test/arch/powerpc/kernel/vdso.c:30:
/home/benh/linux-powerpc-test/arch/powerpc/include/asm/mmu_context.h: In function ‘switch_mm’:
/home/benh/linux-powerpc-test/arch/powerpc/include/asm/mmu_context.h:34: error: implicit declaration of function ‘mm_cpumask’
/home/benh/linux-powerpc-test/arch/powerpc/include/asm/mmu_context.h:34: warning: passing argument 2 of ‘cpumask_set_cpu’ makes pointer from integer without a cast

> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  arch/powerpc/include/asm/mmu_context.h |    2 +-
>  arch/powerpc/mm/hash_utils_64.c        |   10 ++++------
>  arch/powerpc/mm/mmu_context_nohash.c   |    2 +-
>  arch/powerpc/mm/pgtable.c              |    3 +--
>  arch/powerpc/mm/tlb_hash64.c           |    6 +++---
>  arch/powerpc/mm/tlb_nohash.c           |   18 +++++++++---------
>  arch/powerpc/platforms/cell/spu_base.c |    2 +-
>  7 files changed, 20 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -31,7 +31,7 @@ static inline void switch_mm(struct mm_s
>  			     struct task_struct *tsk)
>  {
>  	/* Mark this context has been used on the new CPU */
> -	cpu_set(smp_processor_id(), next->cpu_vm_mask);
> +	cpumask_set_cpu(smp_processor_id(), mm_cpumask(next));
>  
>  	/* 32-bit keeps track of the current PGDIR in the thread struct */
>  #ifdef CONFIG_PPC32
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -858,7 +858,7 @@ int hash_page(unsigned long ea, unsigned
>  	unsigned long vsid;
>  	struct mm_struct *mm;
>  	pte_t *ptep;
> -	cpumask_t tmp;
> +	const struct cpumask *tmp;
>  	int rc, user_region = 0, local = 0;
>  	int psize, ssize;
>  
> @@ -906,8 +906,8 @@ int hash_page(unsigned long ea, unsigned
>  		return 1;
>  
>  	/* Check CPU locality */
> -	tmp = cpumask_of_cpu(smp_processor_id());
> -	if (user_region && cpus_equal(mm->cpu_vm_mask, tmp))
> +	tmp = cpumask_of(smp_processor_id());
> +	if (user_region && cpumask_equal(mm_cpumask(mm), tmp))
>  		local = 1;
>  
>  #ifdef CONFIG_HUGETLB_PAGE
> @@ -1023,7 +1023,6 @@ void hash_preload(struct mm_struct *mm, 
>  	unsigned long vsid;
>  	void *pgdir;
>  	pte_t *ptep;
> -	cpumask_t mask;
>  	unsigned long flags;
>  	int local = 0;
>  	int ssize;
> @@ -1066,8 +1065,7 @@ void hash_preload(struct mm_struct *mm, 
>  	local_irq_save(flags);
>  
>  	/* Is that local to this CPU ? */
> -	mask = cpumask_of_cpu(smp_processor_id());
> -	if (cpus_equal(mm->cpu_vm_mask, mask))
> +	if (cpumask_equal(mm_cpumask(mm), cpumask_of(smp_processor_id())))
>  		local = 1;
>  
>  	/* Hash it in */
> diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
> --- a/arch/powerpc/mm/mmu_context_nohash.c
> +++ b/arch/powerpc/mm/mmu_context_nohash.c
> @@ -97,7 +97,7 @@ static unsigned int steal_context_smp(un
>  		mm->context.id = MMU_NO_CONTEXT;
>  
>  		/* Mark it stale on all CPUs that used this mm */
> -		for_each_cpu_mask_nr(cpu, mm->cpu_vm_mask)
> +		for_each_cpu(cpu, mm_cpumask(mm))
>  			__set_bit(id, stale_map[cpu]);
>  		return id;
>  	}
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -81,11 +81,10 @@ void pgtable_free_tlb(struct mmu_gather 
>  void pgtable_free_tlb(struct mmu_gather *tlb, pgtable_free_t pgf)
>  {
>  	/* This is safe since tlb_gather_mmu has disabled preemption */
> -        cpumask_t local_cpumask = cpumask_of_cpu(smp_processor_id());
>  	struct pte_freelist_batch **batchp = &__get_cpu_var(pte_freelist_cur);
>  
>  	if (atomic_read(&tlb->mm->mm_users) < 2 ||
> -	    cpus_equal(tlb->mm->cpu_vm_mask, local_cpumask)) {
> +	    cpumask_equal(mm_cpumask(tlb->mm), cpumask_of(smp_processor_id()))){
>  		pgtable_free(pgf);
>  		return;
>  	}
> diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
> --- a/arch/powerpc/mm/tlb_hash64.c
> +++ b/arch/powerpc/mm/tlb_hash64.c
> @@ -139,12 +139,12 @@ void hpte_need_flush(struct mm_struct *m
>   */
>  void __flush_tlb_pending(struct ppc64_tlb_batch *batch)
>  {
> -	cpumask_t tmp;
> +	const struct cpumask *tmp;
>  	int i, local = 0;
>  
>  	i = batch->index;
> -	tmp = cpumask_of_cpu(smp_processor_id());
> -	if (cpus_equal(batch->mm->cpu_vm_mask, tmp))
> +	tmp = cpumask_of(smp_processor_id());
> +	if (cpumask_equal(mm_cpumask(batch->mm), tmp))
>  		local = 1;
>  	if (i == 1)
>  		flush_hash_page(batch->vaddr[0], batch->pte[0],
> diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
> --- a/arch/powerpc/mm/tlb_nohash.c
> +++ b/arch/powerpc/mm/tlb_nohash.c
> @@ -132,11 +132,11 @@ void flush_tlb_mm(struct mm_struct *mm)
>  	pid = mm->context.id;
>  	if (unlikely(pid == MMU_NO_CONTEXT))
>  		goto no_context;
> -	cpu_mask = mm->cpu_vm_mask;
> -	cpu_clear(smp_processor_id(), cpu_mask);
> -	if (!cpus_empty(cpu_mask)) {
> +	if (!cpumask_equal(mm_cpumask(mm), cpumask_of(smp_processor_id()))) {
>  		struct tlb_flush_param p = { .pid = pid };
> -		smp_call_function_mask(cpu_mask, do_flush_tlb_mm_ipi, &p, 1);
> +		/* Ignores smp_processor_id() even if set. */
> +		smp_call_function_many(mm_cpumask(mm),
> +				       do_flush_tlb_mm_ipi, &p, 1);
>  	}
>  	_tlbil_pid(pid);
>   no_context:
> @@ -146,16 +146,15 @@ EXPORT_SYMBOL(flush_tlb_mm);
>  
>  void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
>  {
> -	cpumask_t cpu_mask;
> +	struct cpumask *cpu_mask;
>  	unsigned int pid;
>  
>  	preempt_disable();
>  	pid = vma ? vma->vm_mm->context.id : 0;
>  	if (unlikely(pid == MMU_NO_CONTEXT))
>  		goto bail;
> -	cpu_mask = vma->vm_mm->cpu_vm_mask;
> -	cpu_clear(smp_processor_id(), cpu_mask);
> -	if (!cpus_empty(cpu_mask)) {
> +	cpu_mask = mm_cpumask(vma->vm_mm);
> +	if (!cpumask_equal(cpu_mask, cpumask_of(smp_processor_id()))) {
>  		/* If broadcast tlbivax is supported, use it */
>  		if (mmu_has_feature(MMU_FTR_USE_TLBIVAX_BCAST)) {
>  			int lock = mmu_has_feature(MMU_FTR_LOCK_BCAST_INVAL);
> @@ -167,7 +166,8 @@ void flush_tlb_page(struct vm_area_struc
>  			goto bail;
>  		} else {
>  			struct tlb_flush_param p = { .pid = pid, .addr = vmaddr };
> -			smp_call_function_mask(cpu_mask,
> +			/* Ignores smp_processor_id() even if set in cpu_mask */
> +			smp_call_function_many(cpu_mask,
>  					       do_flush_tlb_page_ipi, &p, 1);
>  		}
>  	}
> diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
> --- a/arch/powerpc/platforms/cell/spu_base.c
> +++ b/arch/powerpc/platforms/cell/spu_base.c
> @@ -114,7 +114,7 @@ static inline void mm_needs_global_tlbie
>  	int nr = (NR_CPUS > 1) ? NR_CPUS : NR_CPUS + 1;
>  
>  	/* Global TLBIE broadcast required with SPEs. */
> -	__cpus_setall(&mm->cpu_vm_mask, nr);
> +	bitmap_fill(cpumask_bits(mm_cpumask(mm)), nr);
>  }
>  
>  void spu_associate_mm(struct spu *spu, struct mm_struct *mm)
