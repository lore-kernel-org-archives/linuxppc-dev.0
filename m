Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJVSF2vRTzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 19:42:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, alistair@popple.id.au,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 1/2] powerpc/mm: Add marker for contexts requiring global
 TLB invalidations
In-Reply-To: <20170503142906.29220-2-fbarrat@linux.vnet.ibm.com>
References: <20170503142906.29220-1-fbarrat@linux.vnet.ibm.com>
 <20170503142906.29220-2-fbarrat@linux.vnet.ibm.com>
Date: Thu, 04 May 2017 19:42:35 +1000
Message-ID: <87efw5yn3o.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> Introduce a new 'flags' attribute per context and define its first bit
> to be a marker requiring all TLBIs for that context to be broadcasted
> globally. Once that marker is set on a context, it cannot be removed.
>
> Such a marker is useful for memory contexts used by devices behind the
> NPU and CAPP/PSL. The NPU and the PSL keep their own
> translation cache so they need to see all the TLBIs for those
> contexts.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu.h |  9 +++++++++
>  arch/powerpc/include/asm/tlb.h           | 10 ++++++++--
>  arch/powerpc/mm/mmu_context_book3s64.c   |  1 +
>  3 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> index 77529a3e3811..7b640ab1cbeb 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> @@ -78,8 +78,12 @@ struct spinlock;
>  /* Maximum possible number of NPUs in a system. */
>  #define NV_MAX_NPUS 8
>  
> +/* Bits definition for the context flags */
> +#define MM_CONTEXT_GLOBAL_TLBI	1	/* TLBI must be global */

I think I'd prefer MM_GLOBAL_TLBIE, it's shorter and tlbie is the name
of the instruction so is something people can search for.

> @@ -164,5 +168,10 @@ extern void radix_init_pseries(void);
>  static inline void radix_init_pseries(void) { };
>  #endif
>  
> +static inline void mm_context_set_global_tlbi(mm_context_t *ctx)
> +{
> +	set_bit(MM_CONTEXT_GLOBAL_TLBI, &ctx->flags);
> +}

set_bit() and test_bit() are non-atomic, and unordered vs other loads
and stores.

So the caller will need to be careful they have a barrier between this
and whatever it is they do that creates mappings that might need to be
invalidated.

Similarly on the read side we should have a barrier between the store
that makes the PTE invalid and the load of the flag.

Which makes me think cxl_ctx_in_use() is buggy :/, hmm. But it's late so
hopefully I'm wrong :D

> diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
> index 609557569f65..bd18ed083011 100644
> --- a/arch/powerpc/include/asm/tlb.h
> +++ b/arch/powerpc/include/asm/tlb.h
> @@ -71,8 +71,14 @@ static inline int mm_is_core_local(struct mm_struct *mm)
>  
>  static inline int mm_is_thread_local(struct mm_struct *mm)
>  {
> -	return cpumask_equal(mm_cpumask(mm),
> -			      cpumask_of(smp_processor_id()));
> +	int rc;
> +
> +	rc = cpumask_equal(mm_cpumask(mm),
> +			cpumask_of(smp_processor_id()));
> +#ifdef CONFIG_PPC_BOOK3S_64
> +	rc = rc && !test_bit(MM_CONTEXT_GLOBAL_TLBI, &mm->context.flags);
> +#endif

The ifdef's a bit ugly, but I guess it's not worth putting it in a
static inline.

I'd be interested to see the generated code for this, and for the
reverse, ie. putting the test_bit() first, and doing an early return if
it's true. That way once the bit is set we can just skip the cpumask
comparison.

cheers
