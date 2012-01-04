Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 4C3111007D7
 for <linuxppc-dev@ozlabs.org>; Thu,  5 Jan 2012 08:09:10 +1100 (EST)
Message-ID: <4F04BFEA.1050009@freescale.com>
Date: Wed, 4 Jan 2012 15:08:58 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Subject: Re: Cannot wake-up from standby with MPC8313
References: <4F047BF8.7090400@aimvalley.nl>
In-Reply-To: <4F047BF8.7090400@aimvalley.nl>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/04/2012 10:19 AM, Norbert van Bolhuis wrote:
> 
> after entering:
> 
> echo standby > /sys/power/state
> 
> I'm unable to wake up the MPC8313 (on our custom designed
> MPC8313 board).
> 
> I need it to wake up through GPIO IRQ.
> I cause multiple GPIO interrupts (all properly handled by an isr),
> but the MPC8313 does not wake up.
> 
> How should one wake up via GPGIO IRQ ?
> 
> I'm using v2.6.29 and I wonder whether this is related to
> our custom 8313 board and/or v2.6.29 and/or missing kernel
> patches or maybe this never worked ?
> 
> Also, I do not understand line 220 of arch/powerpc/platforms/83xx/suspend.c
> 
> 219         } else {
> 220                 out_be32(&pmc_regs->mask, PMCER_PMCI);
> 221
> 222                 mpc6xx_enter_standby();
> 
> How can wake up ever work if TSEC/GPIO/TIMER/etc.. wake up events
> are disabled ?
> 
> changing this into "out_be32(&pmc_regs->mask, PMCER_PMCI|PMCER_GPIO);"
> gives same result.

It's been a while since I've touched this, but IIRC the PMC events are
mainly important for deep sleep, and for normal sleep (standby) you can
wake from any interrupt other than core interrupts like timebase.  I'm
not sure to what extent setting PMCCR[SLPEN] affects this -- I don't see
where the documentation says what "system low power state" means.  I
would be surprised if GPIO were affected, though, since it's supported
as a wakeup source even in deep sleep.  I think I was able to wake from
standby on a UART interrupt even with SLPEN set.

Are you sure the GPIO block is asserting an interrupt, and that it
hasn't been masked during the preparation for standby?

What happens if you modify mpc6xx_enter_standby() to not actually set
MSR_POW?

-Scott
