Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 701B467CB9
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 05:24:54 +1100 (EST)
Date: Wed, 13 Dec 2006 12:23:53 -0600
From: Olof Johansson <olof@lixom.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 6/9] MPIC MSI allocator
Message-ID: <20061213122353.7498a25e@pb15>
In-Reply-To: <20061213104007.4B8F967DA9@ozlabs.org>
References: <1166006370.90082.476088563252.qpush@cradle>
	<20061213104007.4B8F967DA9@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 13 Dec 2006 21:40:03 +1100 Michael Ellerman <michael@ellerman.id.au> wrote:

> To support MSI on MPIC we need a way to reserve and allocate hardware irq
> numbers, this patch implements an allocator for that. It looks like we'll
> end up with several backends based on the MPIC, so the allocator is attached
> to the struct mpic, not the msi backend.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

> +static void mpic_msi_auto_reserve_hwirqs(struct mpic *mpic)
> +{
> +	irq_hw_number_t hwirq;
> +	struct irq_host_ops *ops = mpic->irqhost->ops;
> +	struct device_node *np;
> +	int flags, index, i;
> +	struct of_irq oirq;
> +
> +	/* Reserve source numbers we know are reserved in the HW */

How do we know? Reserved on what HW? Sure looks system/platform
dependent to me.

> +	for (i = 0;   i < 8;   i++)
> +		__mpic_msi_reserve_hwirq(mpic, i);
> +	for (i = 42;  i < 26;  i++)
             ^^^^^^^^^^^^^^^

Is this some sort of check to see if we're awake? :)

> +		__mpic_msi_reserve_hwirq(mpic, i);
> +	for (i = 100; i < 105; i++)
> +		__mpic_msi_reserve_hwirq(mpic, i);




-Olof
