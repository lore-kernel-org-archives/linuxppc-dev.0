Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJRQT3TMBzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 17:25:53 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id s62so1115834pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 00:25:53 -0700 (PDT)
Message-ID: <1493882745.7934.3.camel@gmail.com>
Subject: Re: [RFC 1/2] powerpc/mm: Add marker for contexts requiring global
 TLB invalidations
From: Balbir Singh <bsingharora@gmail.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, alistair@popple.id.au,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
Date: Thu, 04 May 2017 17:25:45 +1000
In-Reply-To: <20170503142906.29220-2-fbarrat@linux.vnet.ibm.com>
References: <20170503142906.29220-1-fbarrat@linux.vnet.ibm.com>
 <20170503142906.29220-2-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-05-03 at 16:29 +0200, Frederic Barrat wrote:
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
> +
>  typedef struct {
>  	mm_context_id_t id;
> +	unsigned long flags;

Should these flags be under #ifdef PPC_BOOK3S_64 as well? Not sure.

>  	u16 user_psize;		/* page size index */
>  
>  	/* NPU NMMU context */
> @@ -164,5 +168,10 @@ extern void radix_init_pseries(void);
>  static inline void radix_init_pseries(void) { };
>  #endif
>  
> +static inline void mm_context_set_global_tlbi(mm_context_t *ctx)
> +{
> +	set_bit(MM_CONTEXT_GLOBAL_TLBI, &ctx->flags);
> +}
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* _ASM_POWERPC_BOOK3S_64_MMU_H_ */
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

Acked-by: Balbir Singh <bsingharora@gmail.com>
