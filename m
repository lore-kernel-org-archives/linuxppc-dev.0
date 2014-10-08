Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB2EB1A042E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 13:52:10 +1100 (EST)
In-Reply-To: <54343B54.4060500@us.ibm.com>
To: Paul Clarke <pc@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: mitigate impact of decrementer reset
Message-Id: <20141008025210.AF949140144@ozlabs.org>
Date: Wed,  8 Oct 2014 13:52:10 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-07-10 at 19:13:24 UTC, Paul Clarke wrote:
> The POWER ISA defines an always-running decrementer which can be used
> to schedule interrupts after a certain time interval has elapsed.
> The decrementer counts down at the same frequency as the Time Base,
> which is 512 MHz.  The maximum value of the decrementer is 0x7fffffff.
> This works out to a maximum interval of about 4.19 seconds.
> 
> If a larger interval is desired, the kernel will set the decrementer
> to its maximum value and reset it after it expires (underflows)
> a sufficient number of times until the desired interval has elapsed.
> 
> The negative effect of this is that an unwanted latency spike will
> impact normal processing at most every 4.19 seconds.  On an IBM
> POWER8-based system, this spike was measured at about 25-30
> microseconds, much of which was basic, opportunistic housekeeping
> tasks that could otherwise have waited.
> 
> This patch short-circuits the reset of the decrementer, exiting after
> the decrementer reset, but before the housekeeping tasks if the only
> need for the interrupt is simply to reset it.  After this patch,
> the latency spike was measured at about 150 nanoseconds.

Hi Paul,

Thanks for the excellent changelog. But this patch makes me a bit nervous :)

Do you know where the latency is coming from? Is it primarily the irq work?

If so I'd prefer if we could move the short circuit into __timer_interrupt()
itself. That way we'd still have the trace points usable, and it would
hopefully result in less duplicated logic.

cheers
