Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrdlr1wC9zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 14:48:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 4/9] powerpc/64s: SLB miss handler avoid r3 save/restore
In-Reply-To: <20170521131550.25813-5-npiggin@gmail.com>
References: <20170521131550.25813-1-npiggin@gmail.com>
 <20170521131550.25813-5-npiggin@gmail.com>
Date: Mon, 19 Jun 2017 14:48:37 +1000
Message-ID: <87tw3cvaze.fsf@concordia.ellerman.id.au>
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

> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 486e205cc762..6ba4c4c6ae69 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -625,6 +625,9 @@ EXC_COMMON_BEGIN(slb_miss_realmode)
>  	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
>  	std	r10,PACA_EXSLB+EX_LR(r13)	/* save LR */
>  
> +	andi.	r11,r11,MSR_RI	/* check for unrecoverable exception */
> +	beq-	2f
> +
>  	crset	4*cr0+eq
>  #ifdef CONFIG_PPC_STD_MMU_64
>  BEGIN_MMU_FTR_SECTION
> @@ -638,9 +641,6 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
>  
>  	beq-	8f		/* if bad address, make full stack frame */
>  
> -	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
> -	beq-	2f
> -

Moving that check before slb_allocate_realmode() makes me a bit nervous.

It's already a bug if we're taking an SLB miss with RI off, but I'm
worried that by not doing the SLB allocate we might turn what would be a
regular oops into an infinite loop of SLB misses. But my brain is too
sleep deprived today to decide either way.

cheers
