Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0141.outbound.protection.outlook.com [65.55.169.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D34071A075D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 11:02:10 +1100 (AEDT)
Date: Fri, 16 Oct 2015 19:01:55 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
CC: <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [v2] powerpc/e6500: hw tablewalk: make sure we invalidate and
 write to the same tlb entry
Message-ID: <20151017000155.GA15466@home.buserror.net>
References: <1439884556-11291-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1439884556-11291-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 18, 2015 at 03:55:56PM +0800, Kevin Hao wrote:
> diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
> index e4185581c5a7..3a5b89dfb5a1 100644
> --- a/arch/powerpc/mm/tlb_low_64e.S
> +++ b/arch/powerpc/mm/tlb_low_64e.S
> @@ -68,11 +68,21 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
>  	ld	r14,PACAPGD(r13)
>  	std	r15,EX_TLB_R15(r12)
>  	std	r10,EX_TLB_CR(r12)
> +#ifdef CONFIG_PPC_FSL_BOOK3E
> +BEGIN_FTR_SECTION
> +	std	r7,EX_TLB_R7(r12)
> +END_FTR_SECTION_IFSET(CPU_FTR_SMT)
> +#endif
>  	TLB_MISS_PROLOG_STATS
>  .endm
>  
>  .macro tlb_epilog_bolted
>  	ld	r14,EX_TLB_CR(r12)
> +#ifdef CONFIG_PPC_FSL_BOOK3E
> +BEGIN_FTR_SECTION
> +	ld	r7,EX_TLB_R7(r12)
> +END_FTR_SECTION_IFSET(CPU_FTR_SMT)
> +#endif

r7 is used outside the CPU_FTR_SMT section of the e6500 TLB handler.

-Scott
