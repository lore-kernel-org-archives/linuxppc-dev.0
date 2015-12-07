Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 52BA21A0E5A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 09:10:20 +1100 (AEDT)
In-Reply-To: <1449448108-9867-1-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: dllehr@us.ibm.com, mikey@neuling.org, stable@vger.kernel.org,
 Alistair Popple <alistair@popple.id.au>
Subject: Re: powernv/opal-irqchip: Fix double endian conversion
Message-Id: <20151207221020.11FC91402A9@ozlabs.org>
Date: Tue,  8 Dec 2015 09:10:19 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Subject should start "powerpc/", so probably "powerpc/opal-irqchip:", I can fix
it up here.

On Mon, 2015-07-12 at 00:28:28 UTC, Alistair Popple wrote:
> The OPAL event calls return a mask of events that are active in big
> endian format. This is checked when unmasking the events in the
> irqchip by comparison with a cached value. The cached value was stored
> in big endian format but should've been converted to CPU endian
> first. This bug leads to OPAL event delivery being delayed or dropped
> on some systems.
> 
> The bug is fixed by calling opal_handle_events(...) instead of
> duplicating code in opal_event_unmask(...).
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Reported-by: Douglas L Lehr <dllehr@us.ibm.com>
> Cc: stable@vger.kernel.org

Which commit does it fix? Looks like:

Fixes: 9f0fd0499d30 ("powerpc/powernv: Add a virtual irqchip for opal events")

> diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
> index 2c91ee7..a387d18 100644
> --- a/arch/powerpc/platforms/powernv/opal-irqchip.c
> +++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
> @@ -43,11 +43,34 @@ static unsigned int opal_irq_count;
>  static unsigned int *opal_irqs;
>  
>  static void opal_handle_irq_work(struct irq_work *work);
> -static __be64 last_outstanding_events;
> +static u64 last_outstanding_events;
>  static struct irq_work opal_event_irq_work = {
>  	.func = opal_handle_irq_work,
>  };
>  
> +void opal_handle_events(uint64_t events)
> +{
> +	int virq, hwirq = 0;
> +	u64 mask = opal_event_irqchip.mask;
> +
> +	if (!in_irq() && (events & mask)) {
> +		last_outstanding_events = events;
> +		irq_work_queue(&opal_event_irq_work);
> +		return;
> +	}
> +
> +	while (events & mask) {
> +		hwirq = fls64(events) - 1;
> +		if (BIT_ULL(hwirq) & mask) {
> +			virq = irq_find_mapping(opal_event_irqchip.domain,
> +						hwirq);
> +			if (virq)
> +				generic_handle_irq(virq);
> +		}
> +		events &= ~BIT_ULL(hwirq);
> +	}
> +}

So this is 100% just a move of the code from down below right?

> @@ -55,12 +78,12 @@ static void opal_event_mask(struct irq_data *d)
>  
>  static void opal_event_unmask(struct irq_data *d)
>  {
> +	__be64 events;
> +
>  	set_bit(d->hwirq, &opal_event_irqchip.mask);
>  
> -	opal_poll_events(&last_outstanding_events);
> -	if (last_outstanding_events & opal_event_irqchip.mask)
> -		/* Need to retrigger the interrupt */
> -		irq_work_queue(&opal_event_irq_work);
> +	opal_poll_events(&events);
> +	opal_handle_events(be64_to_cpu(events));
>  }
>  
>  static int opal_event_set_type(struct irq_data *d, unsigned int flow_type)
> @@ -96,29 +119,6 @@ static int opal_event_map(struct irq_domain *d, unsigned int irq,
>  	return 0;
>  }
>  
> -void opal_handle_events(uint64_t events)
> -{
> -	int virq, hwirq = 0;
> -	u64 mask = opal_event_irqchip.mask;
> -
> -	if (!in_irq() && (events & mask)) {
> -		last_outstanding_events = events;
> -		irq_work_queue(&opal_event_irq_work);
> -		return;
> -	}
> -
> -	while (events & mask) {
> -		hwirq = fls64(events) - 1;
> -		if (BIT_ULL(hwirq) & mask) {
> -			virq = irq_find_mapping(opal_event_irqchip.domain,
> -						hwirq);
> -			if (virq)
> -				generic_handle_irq(virq);
> -		}
> -		events &= ~BIT_ULL(hwirq);
> -	}
> -}
> -
>  static irqreturn_t opal_interrupt(int irq, void *data)
>  {
>  	__be64 events;
> @@ -131,7 +131,7 @@ static irqreturn_t opal_interrupt(int irq, void *data)
>  
>  static void opal_handle_irq_work(struct irq_work *work)
>  {
> -	opal_handle_events(be64_to_cpu(last_outstanding_events));
> +	opal_handle_events(last_outstanding_events);
>  }
>  
>  static int opal_event_match(struct irq_domain *h, struct device_node *node,


cheers
