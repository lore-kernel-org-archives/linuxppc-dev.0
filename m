Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 357FD1A010D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 16:29:37 +1100 (AEDT)
In-Reply-To: <1415772194.5124.37.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/powernv: Support OPAL requested heartbeat
Message-Id: <20141113052937.17DFF1400D2@ozlabs.org>
Date: Thu, 13 Nov 2014 16:29:37 +1100 (AEDT)
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-12-11 at 06:03:14 UTC, Benjamin Herrenschmidt wrote:
> If OPAL requests it, call it back via opal_poll_events() at a
> regular interval. Some versions of OPAL on some machines require
> this to operate some internal timeouts properly.
> 
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index f1e0d8c..0153064 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -678,6 +680,49 @@ static int __init opal_init(void)
>  				   " (0x%x)\n", rc, irq, hwirq);
>  		opal_irqs[i] = irq;
>  	}
> +}
> +
> +static int kopald(void *unused)
> +{
> +	set_freezable();
> +	do {
> +		try_to_freeze();
> +		opal_poll_events(NULL);
> +		msleep_interruptible(opal_heartbeat);
> +	} while (!kthread_should_stop());
> +
> +	return 0;
> +}
> +
> +static void opal_init_heartbeat(void)
> +{
> +	/* Old firwmware, we assume the HVC heartbeat is sufficient */
> +	if (of_property_read_u32(opal_node, "ibm,heartbeat-freq",
> +				 &opal_heartbeat) != 0)

I'd assume "freq" with no units is in HZ, but looks like it's milliseconds. I
guess it's too late to rename it.

cheers
