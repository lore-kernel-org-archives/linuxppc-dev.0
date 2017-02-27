Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vX0jl4NbczDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 23:03:55 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/xics: Fix migrate_irqs_away - set CPPR to lowest
 priority
In-Reply-To: <20170227003655.18459-1-bsingharora@gmail.com>
References: <20170227003655.18459-1-bsingharora@gmail.com>
Date: Mon, 27 Feb 2017 23:03:51 +1100
Message-ID: <87fuizrgbc.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> With XICS emulation, setting the CPPR to DEFAULT_PRIORITY
                                        ^
                                        (Current Processor Priority Register)
                                   
> masks all interrupts including IPI's which map to a single
> underlying priority.

It took me a while to parse that.

So because of the way the OPAL XICS emulation is implemented, setting
the CPPR to DEFAULT_PRIORITY has the effect of masking all interrupts.

That is because the OPAL code internally maps all priorities that are >
0 and < 0xff to a single priority. It happens to use 7, but I don't
think that matters does it? It's just that there's no differentiation
between DEFAULT and IPI.

I realise we need to work around it anyway, but are we calling this a
bug in the XICS emulation? Or just an alternate feature? :)

Have we thought about doing the fix in icp_opal_set_cpu_priority()
instead?


> The fix does two things
>
> 1. It moves the setting of CPPR to after all IRQ migration
>    is complete
> 2. It sets the CPPR to LOWEST_PRIORITY, so that interrupts
>    and IPI's are effectively enabled. The expectation is that
>    we'll see just IPI's after migration
>
> The fix is quite generic in that it will work when we move
> DEFAULT and IPI priorities to the same value in the kernel
> later.

I didn't know we were doing that :)

What I'm most interested in is some soothing words to tell me that this
definitely won't break on existing machines, using either a real native
XICS or the HV backend.


> Cc: mikey@neuling.org
> Cc: benh@kernel.crashing.org

I really dislike those Cc lines in the change log, they record nothing,
other than the fact that Ben & Mikey get lots of email that they don't
have time to read. In fact I'm not sure you even Cc'ed them?


> Fixes: d74361881f0d ("powerpc/xics: Add ICP OPAL backend")
> Cc: stable@vger.kernel.org # v4.8+
>
> Reported-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Tested-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/sysdev/xics/xics-common.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
> index c674a9d..31774e0 100644
> --- a/arch/powerpc/sysdev/xics/xics-common.c
> +++ b/arch/powerpc/sysdev/xics/xics-common.c
> @@ -20,6 +20,7 @@
>  #include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/delay.h>
>  
>  #include <asm/prom.h>
>  #include <asm/io.h>
> @@ -198,9 +199,6 @@ void xics_migrate_irqs_away(void)
>  	/* Remove ourselves from the global interrupt queue */
>  	xics_set_cpu_giq(xics_default_distrib_server, 0);
>  
> -	/* Allow IPIs again... */
> -	icp_ops->set_priority(LOWEST_PRIORITY);
> -

That's DEFAULT_PRIORITY in my tree?

> @@ -255,6 +253,19 @@ void xics_migrate_irqs_away(void)
>  unlock:
>  		raw_spin_unlock_irqrestore(&desc->lock, flags);
>  	}
> +
> +	/*
> +	 * Allow sufficient time to drop any inflight IRQ's
> +	 */
> +	mdelay(1);

That looks suspiciously like the code in migrate_irqs(), except it lacks
the irq enable/disable.
 
So the comment should make it clear that we're waiting for the hardware
to drop any inflight IRQs, not that we're waiting for them to be handled
by Linux. And the dropping is caused by the set_priority(0) we did
previously (not visible in the diff).

Do we have *any* basis for 1ms, other than it's "a while"?

> +
> +	/*
> +	 * Allow IPIs again. This is done at the very end, after
                 ^
                 and all other interrupts
                 
> +	 * migrating all interrupts, the expectation is that we'll
> +	 * only get woken up by an IPI interrupt beyond this point

**because we have migrated all other irqs away**

?

> +	 */
> +	icp_ops->set_priority(LOWEST_PRIORITY);
> +
>  }
>  #endif /* CONFIG_HOTPLUG_CPU */


cheers
