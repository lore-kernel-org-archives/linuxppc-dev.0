Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4D582DDE1E
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 13:56:13 +1000 (EST)
Subject: Re: [PATCH] synchronize_irq needs a barrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Maxim Levitsky <maximlevitsky@gmail.com>
In-Reply-To: <200710200402.43106.maximlevitsky@gmail.com>
References: <1192670742.12879.5.camel@pasglop>
	<200710200402.43106.maximlevitsky@gmail.com>
Content-Type: text/plain
Date: Sat, 20 Oct 2007 13:56:01 +1000
Message-Id: <1192852561.17235.23.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	akpm <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I have read this thread and I concluded few things:
> 
> 1) It is impossible to know that the card won't send more interrupts:
> Even if I do a read from the device, the IRQ can be pending in the bus/APIC
> It is even possible (and likely) that the IRQ line will be shared, thus the 
> handler can be called by non-relevant device.
> 
> 2) the synchronize_irq(); in .suspend is useless:
> an IRQ can happen immediately after this synchronize_irq();
> and interrupt even the .suspend()
> (At least theoretically)

It's not totally useless not. It guarantees that by the time your
are out of your suspend(), a simultaneous instance of the IRQ handler
is either finished, or it (or any subsequent occurence) have seen
your insuspend flag set to 1.

> Thus I now understand that .suspend() should do:
> 
> 	saa_writel(SAA7134_IRQ1, 0);
> 	saa_writel(SAA7134_IRQ2, 0);
> 	saa_writel(SAA7134_MAIN_CTRL, 0);
> 
> 	dev->insuspend = 1;
> 	smp_wmb();
> 
> 	/* at that point the _request to disable card's IRQs was issued, we don't know 
> 	   that there will be no irqs anymore.
> 	   the smp_mb(); guaranties that the IRQ handler will bail out in that case. */
> 	
> 	/* .......*/
> 
> 	pci_save_state(pci_dev);
> 	pci_set_power_state(pci_dev, pci_choose_state(pci_dev, state));
> 	return 0;

The above doesn't handle the case where the IRQ handle just passed the
if (insuspend) test. You may end up calling pci_set_power_state() while
in the middle of some further HW accesses in the handler.

You still need synchronize_irq() for that reason. Or use a spinlock.

> and the interrupt handler:
> 
> 	smp_rmb();
> 	if (dev->insuspend)
> 		goto out;
> 
> Am I right?

Not quite :-)

Also not that the work we are doing with synchronize_irq, if it gets
merged, renders it unnecessary for you to add those two memory barriers,
synchronize_irq will pretty much do the ordering for you.

Cheers,
Ben.
