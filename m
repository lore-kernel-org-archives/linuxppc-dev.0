Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E08FA67B22
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 11:22:34 +1000 (EST)
Subject: Re: powerpc virq: new routine virq_to_hw
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <44EF818B.9080301@am.sony.com>
References: <44EF818B.9080301@am.sony.com>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 11:22:19 +1000
Message-Id: <1156728139.8433.413.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-08-25 at 16:02 -0700, Geoff Levand wrote:
> Ben,
> 
> Please consider this accessor routine which hides the details
> of the map.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> ---
> Index: cell--common--4/include/asm-powerpc/irq.h
> ===================================================================
> --- cell--common--4.orig/include/asm-powerpc/irq.h
> +++ cell--common--4/include/asm-powerpc/irq.h
> @@ -136,6 +136,11 @@
>  
>  extern struct irq_map_entry irq_map[NR_IRQS];
>  
> +static inline irq_hw_number_t
> +virq_to_hw (unsigned int virq)
> +{
> +	return irq_map[virq].hwirq;
> +}

I'd much prefer:

static inline irq_hw_number_t virq_to_hw (unsigned int virq)
{
	return irq_map[virq].hwirq;
}

I've grown to dislike the CR between the return type and the function
name (I used to do that too) and it seems that this opinion is shared by
Linus (there was an old thread on lkml about it).

Cheers,
Ben.
