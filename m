Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 032F9DDEF8
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 11:34:18 +1000 (EST)
Subject: Re: [PATCH][RT][PPC64] Fix preempt unsafe paths accessing per_cpu
	variables
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chirag Jog <chirag@linux.vnet.ibm.com>
In-Reply-To: <20080709160543.GG7101@linux.vnet.ibm.com>
References: <20080709160543.GG7101@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Tue, 15 Jul 2008 11:32:01 +1000
Message-Id: <1216085521.7740.37.camel@pasglop>
Mime-Version: 1.0
Cc: linux-rt-users@vger.kernel.org, Josh Triplett <josht@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Nivedita Singhvi <niv@us.ibm.com>,
	"Timothy R. Chavez" <tim.chavez@linux.vnet.ibm.com>,
	paulmck@linux.vnet.ibm.com, linux.kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-07-09 at 21:35 +0530, Chirag Jog wrote:
> Hi,
> This patch fixes various paths in the -rt kernel on powerpc64 where per_cpu
> variables are accessed in a preempt unsafe way.
> When a power box with -rt kernel is booted, multiple BUG messages are
> generated "BUG: init:1 task might have lost a preemption check!".
> After booting a kernel with these patches applied, these messages
> don't appear.
> 
> Also I ran the realtime tests from ltp to ensure the stability.

That sounds bad tho...

IE. You are changing the code to lock/unlock on all those TLB batching
operations, but seem to miss the core reason why it was done that way:
ie, the code assumes that it will not change CPU -between- those calls,
since the whole stuff should be already have been within a per-cpu
locked section at the caller level.

As for the TCE code, well, it lived on the assumption that the upper
level spinlock did the job of preventing preempt, I suppose that's not
the case anymore. So that part of the patch sounds ok.

Ben.

> 
> Signed-Off-By: Chirag <chirag@linux.vnet.ibm.com>
> arch/powerpc/mm/tlb_64.c               |   31 ++++++++++++++++---------------
> arch/powerpc/platforms/pseries/iommu.c |   14 ++++++++++----
> include/asm-powerpc/tlb.h              |    5 ++---
> 3 files changed, 28 insertions(+), 22 deletions(-)
> 
>  
> Index: linux-2.6.25.8-rt7/arch/powerpc/mm/tlb_64.c
> ===================================================================
> --- linux-2.6.25.8-rt7.orig/arch/powerpc/mm/tlb_64.c	2008-07-09 21:29:21.000000000 +0530
> +++ linux-2.6.25.8-rt7/arch/powerpc/mm/tlb_64.c	2008-07-09 21:30:37.000000000 +0530
> @@ -38,7 +38,6 @@
>   * include/asm-powerpc/tlb.h file -- tgall
>   */
>  DEFINE_PER_CPU_LOCKED(struct mmu_gather, mmu_gathers);
> -DEFINE_PER_CPU(struct pte_freelist_batch *, pte_freelist_cur);
>  unsigned long pte_freelist_forced_free;
>  
>  struct pte_freelist_batch
> @@ -48,7 +47,7 @@
>  	pgtable_free_t	tables[0];
>  };
>  
> -DEFINE_PER_CPU(struct pte_freelist_batch *, pte_freelist_cur);
> +DEFINE_PER_CPU_LOCKED(struct pte_freelist_batch *, pte_freelist_cur);
>  unsigned long pte_freelist_forced_free;
>  
>  #define PTE_FREELIST_SIZE \
> @@ -92,24 +91,21 @@
>  
>  void pgtable_free_tlb(struct mmu_gather *tlb, pgtable_free_t pgf)
>  {
> -	/*
> -	 * This is safe since tlb_gather_mmu has disabled preemption.
> -	 * tlb->cpu is set by tlb_gather_mmu as well.
> -	 */
> +	int cpu;
>          cpumask_t local_cpumask = cpumask_of_cpu(tlb->cpu);
> -	struct pte_freelist_batch **batchp = &__get_cpu_var(pte_freelist_cur);
> +	struct pte_freelist_batch **batchp = &get_cpu_var_locked(pte_freelist_cur, &cpu);
>  
>  	if (atomic_read(&tlb->mm->mm_users) < 2 ||
>  	    cpus_equal(tlb->mm->cpu_vm_mask, local_cpumask)) {
>  		pgtable_free(pgf);
> -		return;
> +		goto cleanup;
>  	}
>  
>  	if (*batchp == NULL) {
>  		*batchp = (struct pte_freelist_batch *)__get_free_page(GFP_ATOMIC);
>  		if (*batchp == NULL) {
>  			pgtable_free_now(pgf);
> -			return;
> +			goto cleanup;
>  		}
>  		(*batchp)->index = 0;
>  	}
> @@ -118,6 +114,9 @@
>  		pte_free_submit(*batchp);
>  		*batchp = NULL;
>  	}
> +
> + cleanup:
> +	put_cpu_var_locked(pte_freelist_cur, cpu);
>  }
>  
>  /*
> @@ -253,13 +252,15 @@
>  
>  void pte_free_finish(void)
>  {
> -	/* This is safe since tlb_gather_mmu has disabled preemption */
> -	struct pte_freelist_batch **batchp = &__get_cpu_var(pte_freelist_cur);
> +	int cpu;
> +	struct pte_freelist_batch **batchp = &get_cpu_var_locked(pte_freelist_cur, &cpu);
>  
> -	if (*batchp == NULL)
> -		return;
> -	pte_free_submit(*batchp);
> -	*batchp = NULL;
> +	if (*batchp) {
> +		pte_free_submit(*batchp);
> +		*batchp = NULL;
> +	}
> +
> +	put_cpu_var_locked(pte_freelist_cur, cpu);
>  }
>  
>  /**
> Index: linux-2.6.25.8-rt7/include/asm-powerpc/tlb.h
> ===================================================================
> --- linux-2.6.25.8-rt7.orig/include/asm-powerpc/tlb.h	2008-07-09 21:29:21.000000000 +0530
> +++ linux-2.6.25.8-rt7/include/asm-powerpc/tlb.h	2008-07-09 21:29:41.000000000 +0530
> @@ -40,18 +40,17 @@
>  
>  static inline void tlb_flush(struct mmu_gather *tlb)
>  {
> -	struct ppc64_tlb_batch *tlbbatch = &__get_cpu_var(ppc64_tlb_batch);
> +	struct ppc64_tlb_batch *tlbbatch = &get_cpu_var(ppc64_tlb_batch);
>  
>  	/* If there's a TLB batch pending, then we must flush it because the
>  	 * pages are going to be freed and we really don't want to have a CPU
>  	 * access a freed page because it has a stale TLB
>  	 */
>  	if (tlbbatch->index) {
> -		preempt_disable();
>  		__flush_tlb_pending(tlbbatch);
> -		preempt_enable();
>  	}
>  
> +	put_cpu_var(ppc64_tlb_batch);
>  	pte_free_finish();
>  }
>  
> Index: linux-2.6.25.8-rt7/arch/powerpc/platforms/pseries/iommu.c
> ===================================================================
> --- linux-2.6.25.8-rt7.orig/arch/powerpc/platforms/pseries/iommu.c	2008-07-09 21:29:21.000000000 +0530
> +++ linux-2.6.25.8-rt7/arch/powerpc/platforms/pseries/iommu.c	2008-07-09 21:29:41.000000000 +0530
> @@ -124,7 +124,7 @@
>  	}
>  }
>  
> -static DEFINE_PER_CPU(u64 *, tce_page) = NULL;
> +static DEFINE_PER_CPU_LOCKED(u64 *, tce_page) = NULL;
>  
>  static void tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>  				     long npages, unsigned long uaddr,
> @@ -135,12 +135,13 @@
>  	u64 *tcep;
>  	u64 rpn;
>  	long l, limit;
> +	int cpu;
>  
>  	if (npages == 1)
>  		return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
>  					   direction);
>  
> -	tcep = __get_cpu_var(tce_page);
> +	tcep = get_cpu_var_locked(tce_page, &cpu);
>  
>  	/* This is safe to do since interrupts are off when we're called
>  	 * from iommu_alloc{,_sg}()
> @@ -148,10 +149,13 @@
>  	if (!tcep) {
>  		tcep = (u64 *)__get_free_page(GFP_ATOMIC);
>  		/* If allocation fails, fall back to the loop implementation */
> -		if (!tcep)
> +		if (!tcep) {
> +			put_cpu_var_locked(tce_page, cpu);
>  			return tce_build_pSeriesLP(tbl, tcenum, npages,
>  						   uaddr, direction);
> -		__get_cpu_var(tce_page) = tcep;
> +		}
> +
> +		per_cpu_var_locked(tce_page, cpu) = tcep;
>  	}
>  
>  	rpn = (virt_to_abs(uaddr)) >> TCE_SHIFT;
> @@ -188,6 +192,8 @@
>  		printk("\ttce[0] val = 0x%lx\n", tcep[0]);
>  		show_stack(current, (unsigned long *)__get_SP());
>  	}
> +
> +	put_cpu_var_locked(tce_page, cpu);
>  }
>  
>  static void tce_free_pSeriesLP(struct iommu_table *tbl, long tcenum, long npages)
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
