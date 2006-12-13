Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 35B3C67C89
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 10:25:59 +1100 (EST)
Subject: Re: [PATCH 6/9] MPIC MSI allocator
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20061213122353.7498a25e@pb15>
References: <1166006370.90082.476088563252.qpush@cradle>
	<20061213104007.4B8F967DA9@ozlabs.org> <20061213122353.7498a25e@pb15>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 10:25:44 +1100
Message-Id: <1166052344.11914.233.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Wed, 2006-12-13 at 12:23 -0600, Olof Johansson wrote:
> On Wed, 13 Dec 2006 21:40:03 +1100 Michael Ellerman <michael@ellerman.id.au> wrote:
> 
> > To support MSI on MPIC we need a way to reserve and allocate hardware irq
> > numbers, this patch implements an allocator for that. It looks like we'll
> > end up with several backends based on the MPIC, so the allocator is attached
> > to the struct mpic, not the msi backend.
> > 
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> 
> > +static void mpic_msi_auto_reserve_hwirqs(struct mpic *mpic)
> > +{
> > +	irq_hw_number_t hwirq;
> > +	struct irq_host_ops *ops = mpic->irqhost->ops;
> > +	struct device_node *np;
> > +	int flags, index, i;
> > +	struct of_irq oirq;
> > +
> > +	/* Reserve source numbers we know are reserved in the HW */
> 
> How do we know? Reserved on what HW? Sure looks system/platform
> dependent to me.
> 
> > +	for (i = 0;   i < 8;   i++)
> > +		__mpic_msi_reserve_hwirq(mpic, i);
> > +	for (i = 42;  i < 26;  i++)
>              ^^^^^^^^^^^^^^^
> 
> Is this some sort of check to see if we're awake? :)

This code in MPIC currently is only ever used on U3/U4 and so that code
reserves IRQs we know are used for U3/U4 internal IRQs and not available
for HT interrupts (or MSIs). The code, then, does a second pass also
exclusing all IRQs for all devices in the device-tree.

This is a "hack" that works until device-trees provide the right
property we have defined for mpic to indicate what range of irqs is to
be used for MSIs.

Ben.
