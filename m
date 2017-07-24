Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGJvy1bbvzDqwx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 21:25:50 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id c23so10259309pfe.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 04:25:50 -0700 (PDT)
Date: Mon, 24 Jul 2017 21:25:33 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH 5/6] powerpc/mm: Optimize detection of thread local mm's
Message-ID: <20170724212533.195cb92b@roar.ozlabs.ibm.com>
In-Reply-To: <20170724042803.25848-5-benh@kernel.crashing.org>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
 <20170724042803.25848-5-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 24 Jul 2017 14:28:02 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Instead of comparing the whole CPU mask every time, let's
> keep a counter of how many bits are set in the mask. Thus
> testing for a local mm only requires testing if that counter
> is 1 and the current CPU bit is set in the mask.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu.h |  3 +++
>  arch/powerpc/include/asm/mmu_context.h   |  9 +++++++++
>  arch/powerpc/include/asm/tlb.h           | 11 ++++++++++-
>  arch/powerpc/mm/mmu_context_book3s64.c   |  2 ++
>  4 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> index 1a220cdff923..c3b00e8ff791 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> @@ -83,6 +83,9 @@ typedef struct {
>  	mm_context_id_t id;
>  	u16 user_psize;		/* page size index */
>  
> +	/* Number of bits in the mm_cpumask */
> +	atomic_t active_cpus;
> +
>  	/* NPU NMMU context */
>  	struct npu_context *npu_context;
>  
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index ff1aeb2cd19f..cf8f50cd4030 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -96,6 +96,14 @@ static inline void switch_mm_pgdir(struct task_struct *tsk,
>  				   struct mm_struct *mm) { }
>  #endif
>  
> +#ifdef CONFIG_PPC_BOOK3S_64
> +static inline void inc_mm_active_cpus(struct mm_struct *mm)
> +{
> +	atomic_inc(&mm->context.active_cpus);
> +}
> +#else
> +static inline void inc_mm_active_cpus(struct mm_struct *mm) { }
> +#endif

This is a bit awkward. Can we just move the entire function to test
cpumask and set / increment into helper functions and define them
together with mm_is_thread_local, so it's all in one place?

The extra atomic does not need to be defined when it's not used either.

Also does it make sense to define it based on NR_CPUS > BITS_PER_LONG?
If it's <= then it should be similar load and compare, no?

Looks like a good optimisation though.

Thanks,
Nick
