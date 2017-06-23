Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wvCtY1JQ2zDqkk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 19:33:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 benh@kernel.crashing.org, Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: Invalidate ERAT on powersave wakeup for POWER9
In-Reply-To: <20170622172616.7598-1-mikey@neuling.org>
References: <20170622172616.7598-1-mikey@neuling.org>
Date: Fri, 23 Jun 2017 19:33:23 +1000
Message-ID: <87mv8zoxp8.fsf@concordia.ellerman.id.au>
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

Michael Neuling <mikey@neuling.org> writes:

> On POWER9 the ERAT may be incorrect on wakeup from some stop states
> that lose state. This causes random segvs and illegal instructions
> when these stop states are enabled.

Incorrect how?

Because with the ERAT flush where you've put it, there's still a good
amount of code executed prior to the flush isn't there?

ie. we come in at 0x100, do some of the prolog, do IDLE_TEST which takes
us to pnv_powersave_wakeup, which then restores state from the paca
(memory), that returns and then we check KVM ... and then finally we end
up at pnv_wakeup_loss.

Or is there some other path? Or is the ERAT incorrect in some specific
way which means we only need to flush there?

cheers

> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 1ea14b96f1..ace2ad50c8 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -793,6 +793,9 @@ fastsleep_workaround_at_exit:
>   */
>  .global pnv_wakeup_loss
>  pnv_wakeup_loss:
> +BEGIN_FTR_SECTION
> +	PPC_INVALIDATE_ERAT
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>  	ld	r1,PACAR1(r13)
>  BEGIN_FTR_SECTION
>  	CHECK_HMI_INTERRUPT
> -- 
> 2.11.0
