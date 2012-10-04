Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 250162C0330
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2012 21:06:01 +1000 (EST)
Message-ID: <1349348756.4260.15.camel@pasglop>
Subject: Re: [PATCH] PPC: Enable the Watchdog vector for 405
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Thu, 04 Oct 2012 21:05:56 +1000
In-Reply-To: <20120930232723.GF30637@obsidianresearch.com>
References: <20120930232723.GF30637@obsidianresearch.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2012-09-30 at 17:27 -0600, Jason Gunthorpe wrote:
> diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
> index 4989661..7edd7b1 100644
> --- a/arch/powerpc/kernel/head_40x.S
> +++ b/arch/powerpc/kernel/head_40x.S
> @@ -431,29 +431,19 @@ label:
>  
>  /* 0x1000 - Programmable Interval Timer (PIT) Exception */
>  	START_EXCEPTION(0x1000, Decrementer)
> -	NORMAL_EXCEPTION_PROLOG
> -	lis	r0,TSR_PIS@h
> -	mtspr	SPRN_TSR,r0		/* Clear the PIT exception */
> -	addi	r3,r1,STACK_FRAME_OVERHEAD
> -	EXC_XFER_LITE(0x1000, timer_interrupt)
> +	b pit_longer

Looks like you indeed have no choice but move it down, though I dislike
the label name :-)

Look at how we do a similar thing in exceptions-64.S, we basically just
don't use START_EXCEPTION at that location. We put a .=xxxx and a
branch, and use the real exception name at the target label.

Or just name it "pit_exception" if you want to keep things simple. I
just don't like "pit_longer" :-)
 
> -#if 0
>  /* NOTE:
> - * FIT and WDT handlers are not implemented yet.
> + * FIT handler is not implemented yet.
>   */

Any reason to comment that out ? Better off also branching out of line
to a stub similar to the PIT one that then calls unknown_exception. That
way if it triggers by accident, you'll get a clean trace.

>  /* 0x1010 - Fixed Interval Timer (FIT) Exception
>  */
> -	STND_EXCEPTION(0x1010,	FITException,		unknown_exception)
> +//	STND_EXCEPTION(0x1010,	FITException,		unknown_exception)
>  
>  /* 0x1020 - Watchdog Timer (WDT) Exception
>  */
> -#ifdef CONFIG_BOOKE_WDT
>  	CRITICAL_EXCEPTION(0x1020, WDTException, WatchdogException)
> -#else
> -	CRITICAL_EXCEPTION(0x1020, WDTException, unknown_exception)
> -#endif
> -#endif

Move it out of line too please. When a given vector "slot" gets crowded,
I prefer moving everything in it out of line to keep things consistent.
 
>  /* 0x1100 - Data TLB Miss Exception
>   * As the name implies, translation is not in the MMU, so search the
> @@ -738,6 +728,16 @@ label:
>  		(MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
>  		NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
>  
> +	/* Programmable Interval Timer (PIT) Exception. The PIT runs into
> +	   the space reserved for other exceptions, so we branch down
> +	   to here. */
> +pit_longer:
> +	NORMAL_EXCEPTION_PROLOG
> +	lis	r0,TSR_PIS@h
> +	mtspr	SPRN_TSR,r0		/* Clear the PIT exception */
> +	addi	r3,r1,STACK_FRAME_OVERHEAD
> +	EXC_XFER_LITE(0x1000, timer_interrupt)
> +
>  /*
>   * The other Data TLB exceptions bail out to this point
>   * if they can't resolve the lightweight TLB fault.
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index ae0843f..0701ec1 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1514,7 +1514,7 @@ void unrecoverable_exception(struct pt_regs *regs)
>  	die("Unrecoverable exception", regs, SIGABRT);
>  }
>  
> -#ifdef CONFIG_BOOKE_WDT
> +#if defined(CONFIG_BOOKE_WDT) | defined(CONFIG_40x)
>  /*
>   * Default handler for a Watchdog exception,
>   * spins until a reboot occurs

Cheers,
Ben.
