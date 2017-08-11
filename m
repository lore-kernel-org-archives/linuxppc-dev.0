Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTPG16wpnzDr4c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 22:19:53 +1000 (AEST)
In-Reply-To: <20170801120054.3447-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v2,1/4] powerpc/64s: fix mce accounting for powernv
Message-Id: <3xTPG15xK9z9t3x@ozlabs.org>
Date: Fri, 11 Aug 2017 22:19:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-08-01 at 12:00:51 UTC, Nicholas Piggin wrote:
> ---
>  arch/powerpc/kernel/traps.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index bfcfd9ef09f2..5adfea2dc822 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -755,7 +755,14 @@ void machine_check_exception(struct pt_regs *regs)
>  	enum ctx_state prev_state = exception_enter();
>  	int recover = 0;
>  
> +#ifdef CONFIG_PPC_BOOK3S_64
> +	/* 64s accounts the mce in machine_check_early when in HVMODE */
> +	if (!cpu_has_feature(CPU_FTR_HVMODE))
> +		__this_cpu_inc(irq_stat.mce_exceptions);
> +#else
>  	__this_cpu_inc(irq_stat.mce_exceptions);
> +#endif
> +
>  
>  	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
>  

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f886f0f6e0e20d53dc36421c2ee83f

cheers
