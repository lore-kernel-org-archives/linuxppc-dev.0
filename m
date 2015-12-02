Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-x22d.google.com (mail-yk0-x22d.google.com
 [IPv6:2607:f8b0:4002:c07::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41B451A017D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 23:12:07 +1100 (AEDT)
Received: by ykdv3 with SMTP id v3so43683223ykd.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Dec 2015 04:12:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1448010842-22345-1-git-send-email-chenhui.zhao@freescale.com>
References: <1448010842-22345-1-git-send-email-chenhui.zhao@freescale.com>
Date: Wed, 2 Dec 2015 15:12:05 +0300
Message-ID: <CAOJe8K1_S1EwfjO1qW6mBKA+ighFBKbuKCW6-Q5B_og4-NuzFg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] powerpc/mm: any thread in one core can be the
 first to setup TLB1
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Chenhui Zhao <chenhui.zhao@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, scottwood@freescale.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/20/15, Chenhui Zhao <chenhui.zhao@freescale.com> wrote:
> On e6500, in the case of cpu hotplug, either thread in one core
> may be the first thread initilzing the TLB1. The subsequent threads
> must not setup it again.
>
> The code is derived from the comment of Scott Wood.
>
> Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> ---
>  arch/powerpc/include/asm/cputhreads.h | 7 +++++++
>  arch/powerpc/mm/tlb_nohash.c          | 4 +---
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/cputhreads.h
> b/arch/powerpc/include/asm/cputhreads.h
> index ba42e46..b56cece 100644
> --- a/arch/powerpc/include/asm/cputhreads.h
> +++ b/arch/powerpc/include/asm/cputhreads.h
> @@ -94,6 +94,13 @@ static inline int cpu_last_thread_sibling(int cpu)
>  	return cpu | (threads_per_core - 1);
>  }
>
> +static inline u32 get_tensr(void)
> +{
> +	if (cpu_has_feature(CPU_FTR_SMT))
> +		return mfspr(SPRN_TENSR);
> +	else
> +		return 1;
> +}
If i get it right, SPRN_TENSR used in the code only if CONFIG_PPC64
is defined. Then we can make it noop on ppc32.

Thanks!

>
>  #endif /* _ASM_POWERPC_CPUTHREADS_H */
> diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
> index bb04e4d..f466848 100644
> --- a/arch/powerpc/mm/tlb_nohash.c
> +++ b/arch/powerpc/mm/tlb_nohash.c
> @@ -640,9 +640,7 @@ static void early_init_this_mmu(void)
>  		 * transient mapping would cause problems.
>  		 */
>  #ifdef CONFIG_SMP
> -		if (cpu != boot_cpuid &&
> -		    (cpu != cpu_first_thread_sibling(cpu) ||
> -		     cpu == cpu_first_thread_sibling(boot_cpuid)))
> +		if (hweight32(get_tensr()) > 1)
>  			map = false;
>  #endif
>
> --
> 1.9.1
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
