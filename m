Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40HTrJ3tfmzF1qv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 16:12:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] KVM: PPC: Book3S HV: lockless tlbie for HPT hcalls
In-Reply-To: <20180405175631.31381-3-npiggin@gmail.com>
References: <20180405175631.31381-1-npiggin@gmail.com>
 <20180405175631.31381-3-npiggin@gmail.com>
Date: Fri, 06 Apr 2018 16:12:32 +1000
Message-ID: <87a7ugeucv.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:
> diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> index 78e6a392330f..0221a0f74f07 100644
> --- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> +++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> @@ -439,6 +439,9 @@ static inline int try_lock_tlbie(unsigned int *lock)
>  	unsigned int tmp, old;
>  	unsigned int token = LOCK_TOKEN;
>  
> +	if (mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE))
> +		return 1;
> +
>  	asm volatile("1:lwarx	%1,0,%2\n"
>  		     "	cmpwi	cr0,%1,0\n"
>  		     "	bne	2f\n"
> @@ -452,6 +455,12 @@ static inline int try_lock_tlbie(unsigned int *lock)
>  	return old == 0;
>  }
>  
> +static inline void unlock_tlbie_after_sync(unsigned int *lock)
> +{
> +	if (mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE))
> +		return;
> +}

So this is a bit hard to follow:

#define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	\
	MMU_FTR_HPTE_TABLE | MMU_FTR_PPCAS_ARCH_V2
#define MMU_FTRS_POWER		MMU_FTRS_DEFAULT_HPTE_ARCH_V2
#define MMU_FTRS_PPC970		MMU_FTRS_POWER | MMU_FTR_TLBIE_CROP_VA			// does NOT
#define MMU_FTRS_POWER5		MMU_FTRS_POWER | MMU_FTR_LOCKLESS_TLBIE
#define MMU_FTRS_POWER6		MMU_FTRS_POWER5 | MMU_FTR_KERNEL_RO | MMU_FTR_68_BIT_VA	// includes lockless TLBIE
#define MMU_FTRS_POWER7		MMU_FTRS_POWER6						// includes lockless TLBIE
#define MMU_FTRS_POWER8		MMU_FTRS_POWER6						// includes lockless TLBIE
#define MMU_FTRS_POWER9		MMU_FTRS_POWER6						// includes lockless TLBIE
#define MMU_FTRS_CELL		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | 			// does NOT
				MMU_FTR_CI_LARGE_PAGE
#define MMU_FTRS_PA6T		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \			// does NOT
				MMU_FTR_CI_LARGE_PAGE | MMU_FTR_NO_SLBIE_B


So it's only 970, Cell and Pasemi that *don't* have lockless TLBIE.

And KVM HV doesn't doesn't run on any of those.

So we can just not check for the feature in the KVM HV code.

Am I right?

cheers
