Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqtGs3QxfzDrRp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 16:09:57 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt  <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/4] powerpc/64: do not trace irqs-off at interrupt return
 to soft-disabled context
In-Reply-To: <20171116160052.18672-3-npiggin@gmail.com>
References: <20171116160052.18672-1-npiggin@gmail.com>
 <20171116160052.18672-3-npiggin@gmail.com>
Date: Mon, 04 Dec 2017 16:09:57 +1100
Message-ID: <87d13v3wpm.fsf@concordia.ellerman.id.au>
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

> When an interrupt is returning to a soft-disabled context (which can
> happen for non-maskable interrupts or synchronous interrupts), it goes
> through the motions of soft-disabling again, including calling
> TRACE_DISABLE_INTS (i.e., trace_hardirqs_off()).
>
> This is not necessary, because we must already be soft-disabled in the
> interrupt context, it also may be causing crashes in the irq tracing
> code to re-enter as an nmi. Replace it with a warning to ensure that
> soft-interrupts are still disabled.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/entry_64.S | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

So this patch is the core of the bug fix I gather.

Git blames says:

  Fixes: 7c0482e3d055 ("powerpc/irq: Fix another case of lazy IRQ state getting out of sync")
  Cc: stable@vger.kernel.org # v3.4+

But I'm wondering how this has been broken that long without us
noticing? You hit it doing some sort of perf stress test I think - so is
it just that we've never pushed hard enough? Or did something change to
expose this? Or we're just not sure?

cheers

> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 3320bcac7192..36878b6ee8b8 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -911,9 +911,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
>  	beq	1f
>  	rlwinm	r7,r7,0,~PACA_IRQ_HARD_DIS
>  	stb	r7,PACAIRQHAPPENED(r13)
> -1:	li	r0,0
> -	stb	r0,PACASOFTIRQEN(r13);
> -	TRACE_DISABLE_INTS
> +1:
> +#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_BUG)
> +	/* The interrupt should not have soft enabled. */
> +	lbz	r7,PACASOFTIRQEN(r13)
> +1:	tdnei	r7,0
> +	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
> +#endif
>  	b	.Ldo_restore
>  
>  	/*
> -- 
> 2.15.0
