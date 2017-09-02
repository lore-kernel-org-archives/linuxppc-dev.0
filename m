Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkhnl3GdfzDqbd
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Sep 2017 13:44:59 +1000 (AEST)
Message-ID: <1504323882.4974.101.camel@kernel.crashing.org>
Subject: Re: [PATCH 07/19] powerpc: Create mtmsrd_isync()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com, scottwood@freescale.com
Cc: linuxppc-dev@lists.ozlabs.org
Date: Sat, 02 Sep 2017 13:44:42 +1000
In-Reply-To: <1446079451-8774-8-git-send-email-anton@samba.org>
References: <1446079451-8774-1-git-send-email-anton@samba.org>
 <1446079451-8774-8-git-send-email-anton@samba.org>
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

On Thu, 2015-10-29 at 11:43 +1100, Anton Blanchard wrote:
> mtmsrd_isync() will do an mtmsrd followed by an isync on older
> processors. On newer processors we avoid the isync via a feature fixup.

The isync is needed specifically when enabling/disable FP etc... right
?

I'd like to make the name a bit clearer. Maybe something like
set_msr_fpvec() or maybe you can come up with something even better, ie
 use a name that represents what it's for rather than what it does.

> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/include/asm/reg.h |  8 ++++++++
>  arch/powerpc/kernel/process.c  | 30 ++++++++++++++++++++++--------
>  2 files changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index a908ada..987dac0 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -1193,12 +1193,20 @@
>  #define __mtmsrd(v, l)	asm volatile("mtmsrd %0," __stringify(l) \
>  				     : : "r" (v) : "memory")
>  #define mtmsr(v)	__mtmsrd((v), 0)
> +#define __MTMSR		"mtmsrd"
>  #else
>  #define mtmsr(v)	asm volatile("mtmsr %0" : \
>  				     : "r" ((unsigned long)(v)) \
>  				     : "memory")
> +#define __MTMSR		"mtmsr"
>  #endif
>  
> +static inline void mtmsr_isync(unsigned long val)
> +{
> +	asm volatile(__MTMSR " %0; " ASM_FTR_IFCLR("isync", "nop", %1) : :
> +			"r" (val), "i" (CPU_FTR_ARCH_206) : "memory");
> +}
> +
>  #define mfspr(rn)	({unsigned long rval; \
>  			asm volatile("mfspr %0," __stringify(rn) \
>  				: "=r" (rval)); rval;})
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index ef64219..5bf8ec2 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -130,7 +130,10 @@ void enable_kernel_fp(void)
>  		check_if_tm_restore_required(current);
>  		giveup_fpu(current);
>  	} else {
> -		giveup_fpu(NULL);	/* just enables FP for kernel */
> +		u64 oldmsr = mfmsr();
> +
> +		if (!(oldmsr & MSR_FP))
> +			mtmsr_isync(oldmsr | MSR_FP);
>  	}
>  }
>  EXPORT_SYMBOL(enable_kernel_fp);
> @@ -144,7 +147,10 @@ void enable_kernel_altivec(void)
>  		check_if_tm_restore_required(current);
>  		giveup_altivec(current);
>  	} else {
> -		giveup_altivec_notask();
> +		u64 oldmsr = mfmsr();
> +
> +		if (!(oldmsr & MSR_VEC))
> +			mtmsr_isync(oldmsr | MSR_VEC);
>  	}
>  }
>  EXPORT_SYMBOL(enable_kernel_altivec);
> @@ -173,10 +179,14 @@ void enable_kernel_vsx(void)
>  {
>  	WARN_ON(preemptible());
>  
> -	if (current->thread.regs && (current->thread.regs->msr & MSR_VSX))
> +	if (current->thread.regs && (current->thread.regs->msr & MSR_VSX)) {
>  		giveup_vsx(current);
> -	else
> -		giveup_vsx(NULL);	/* just enable vsx for kernel - force */
> +	} else {
> +		u64 oldmsr = mfmsr();
> +
> +		if (!(oldmsr & MSR_VSX))
> +			mtmsr_isync(oldmsr | MSR_VSX);
> +	}
>  }
>  EXPORT_SYMBOL(enable_kernel_vsx);
>  
> @@ -209,10 +219,14 @@ void enable_kernel_spe(void)
>  {
>  	WARN_ON(preemptible());
>  
> -	if (current->thread.regs && (current->thread.regs->msr & MSR_SPE))
> +	if (current->thread.regs && (current->thread.regs->msr & MSR_SPE)) {
>  		giveup_spe(current);
> -	else
> -		giveup_spe(NULL);	/* just enable SPE for kernel - force */
> +	} else {
> +		u64 oldmsr = mfmsr();
> +
> +		if (!(oldmsr & MSR_SPE))
> +			mtmsr_isync(oldmsr | MSR_SPE);
> +	}
>  }
>  EXPORT_SYMBOL(enable_kernel_spe);
>  
