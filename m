Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcSXJ18tWzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 19:11:28 +1000 (AEST)
In-Reply-To: <20170519154705.10504-1-ivan@de.ibm.com>
To: Ivan Mikhaylov <ivan@de.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>
Subject: Re: [4/4] arch/powerpc/44x/fsp2: wdt tcr update instead of whole
 rewrite
Message-Id: <3wcSXH5BdSz9s81@ozlabs.org>
Date: Tue, 30 May 2017 19:11:27 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-05-19 at 15:47:05 UTC, Ivan Mikhaylov wrote:
> Hi Michael,
> 
> >> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> >> index 2b33cfa..f75e512 100644
> >> --- a/arch/powerpc/kernel/time.c
> >> +++ b/arch/powerpc/kernel/time.c
> >> @@ -738,12 +738,28 @@ static int __init get_freq(char *name, int cells, unsigned long *val)
> >>  
> >>  static void start_cpu_decrementer(void)
> >>  {
> >> +	unsigned int tcr;
> >>  #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
> >>  	/* Clear any pending timer interrupts */
> >>  	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
> >>  
> >> +#ifdef CONFIG_FSP2
> >> +	/*
> >> +	 * Prevent a kernel panic caused by unintentionally clearing TCR
> >> +	 * watchdog bits.  At this point in the kernel boot, the watchdog has
> >> +	 * already been enabled by u-boot.  The original code's attempt to
> >
> > Don't refer to "the original code", as it doesn't exist anymore now that
> > we've patched it. Just say something like ".. so we must not clear the
> > watchdog configuration bits".
> Ok, got it.
> 
> >That breaks the build for other platforms:
> >
> > arch/powerpc/kernel/time.c: In function ‘start_cpu_decrementer’:
> > arch/powerpc/kernel/time.c:741:15: error: unused variable ‘tcr’ [-Werror=unused-variable]
> >
> Oops, didn't notice, my fault. 
> 
> >Or you could possibly just always leave TCR[WP], is there any case where
> >it would be correct to clear that?
> >
> >cheers
> 
> >From my point of view it's possible. I've checked docu and on idea
> it should be possible cause WP is only affecting watchdog ping time.
> Which in case of '00' is very small, around ~5 ms. 
> Ben also in next message said about get rid of ifdef for FSP2.
> 
> And now patch looks like this, What do you think Michael, Ben?
> 
>  arch/powerpc/kernel/time.c |   15 +++++++++++++--
>  1 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index bc2e08d..2411c49 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -718,11 +718,22 @@ static int __init get_freq(char *name, int cells, unsigned long *val)
>  static void start_cpu_decrementer(void)
>  {
>  #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
> +	unsigned int tcr;
>  	/* Clear any pending timer interrupts */
>  	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
>  
> -	/* Enable decrementer interrupt */
> -	mtspr(SPRN_TCR, TCR_DIE);
> +	tcr = mfspr(SPRN_TCR);
> +	/*
> +	 * At this point in the kernel boot, the watchdog has already
> +	 * been enabled by u-boot. If we set it this to '00' it may
> +	 * trigger watchdog earlier than needed which will cause
> +	 * inattentional kernel panic. In this case we leaving TCR[WP]
> +	 * bit setting from uboot/bootstrap.
> +	 */
> +	tcr &= TCR_WP_MASK; /* clear all bits except for TCR[WP] */
> +	tcr |= TCR_DIE; /* enable decrementer */
> +	mtspr(SPRN_TCR, tcr);
> +
>  #endif /* defined(CONFIG_BOOKE) || defined(CONFIG_40x) */
>  }
>  

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6e2f03e292ef46eed2b31b0a344a91

cheers
