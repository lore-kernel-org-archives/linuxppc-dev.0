Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 80949B70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 18:52:01 +1100 (EST)
Subject: Re: [PATCH 01/28] powerpc: mpic irq_data conversion.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
In-Reply-To: <20110309073309.GL16649@mail.wantstofly.org>
References: <cover.1299541392.git.buytenh@wantstofly.org>
	<20110307235902.GF16649@mail.wantstofly.org>
	<1299640975.22236.263.camel@pasglop>
	<20110309073309.GL16649@mail.wantstofly.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Mar 2011 18:51:44 +1100
Message-ID: <1299657104.22236.386.camel@pasglop>
Mime-Version: 1.0
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-03-09 at 08:33 +0100, Lennert Buytenhek wrote:
> > > -static void mpic_unmask_ht_irq(unsigned int irq)
> > > +static void mpic_unmask_ht_irq(struct irq_data *d)
> > >  {
> > > -   struct mpic *mpic = mpic_from_irq(irq);
> > > -   unsigned int src = mpic_irq_to_hw(irq);
> > > +   struct mpic *mpic = mpic_from_irq(d->irq);
> > > +   unsigned int src = mpic_irq_to_hw(d->irq);
> > 
> > It's a bit sad to have a pointerm turn it back to a irq number,
> > look it up just to get back the chip data in there :-)
> 
> ACK, how about the below?

Much better. Do you want to fold it in and re-post only the affected
patch (es) ?

> > Either we should create an mpic_from_irqdata() which itself uses
> > irq_data_get_irq_chip_data() or just change mpic_from_irq() if we
> > decide we can always call it with "data" instead of "irq"
> 
> There's one site left that needs to go from virq to mpic, so I've
> done the former.

Ok.

> > should be trivial to add. Thomas, what do you reckon ?
> 
> It really shouldn't be looking at the desc at all.
> 
> This should help, as we only look at IRQ_LEVEL here:
> 
>         http://git.kernel.org/?p=linux/kernel/git/x86/linux-2.6-tip.git;a=commitdiff;h=876dbd4cc1b35c1a4cb96a2be1d43ea0eabce3b4

Ah yes, indeed. The trigger is all we care about. We can do that in
second phase after Thomas stuff goes in.

Cheers,
Ben.
