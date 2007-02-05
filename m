Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D26DEDDE3E
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 15:45:30 +1100 (EST)
Date: Sun, 4 Feb 2007 22:52:58 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [7/9] pasemi: Configure DMA controller interrupts
Message-ID: <20070205045258.GB4719@lixom.net>
References: <20070202045448.145851000@lixom.net>
	<20070202045509.170129000@lixom.net>>
	<1170633229.2620.54.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1170633229.2620.54.camel@localhost.localdomain>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 05, 2007 at 10:53:49AM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2007-02-01 at 22:54 -0600, Olof Johansson wrote:
> > plain text document attachment (pasemi-dma-irqs)
> > The DMA controller on PWRficient is somewhat special -- has a PCI header
> > so it looks like it's on the root PCI (-Express) root bus, but it uses
> > more than the default number of interrupts (and they are hardwired).
> > 
> > We need to wire up all interrupts for the DMA controller. The generic
> > IRQ code will only map the primary interrupt from the PCI header (128),
> > so add 129->211 by hand.
> 
> Or you can have them in the device-tree ... the generic code only maps
> PCI IRQ index 0 but nothing prevents your fixup code to map the other
> ones.

I don't see the point in having them in the device tree fixups instead
of pci fixups. I'll move them to the driver for now.

> However, I do wonder what is the point of creating a mapping and nor
> storing the resulting virq anywhere ?

Current usage was relying on the virqs being allocated linearly with
the rest. Yes, that's in hindsight broken.

> When are those IRQs actually used ?

In the ethernet driver;

       ret = request_irq(mac->dma_pdev->irq + mac->dma_txch,
                         &pasemi_mac_tx_intr, IRQF_DISABLED,
                         mac->tx->irq_name, dev);
[...]

       ret = request_irq(mac->dma_pdev->irq + 20 + mac->dma_rxch,
                         &pasemi_mac_rx_intr, IRQF_DISABLED,
                         mac->rx->irq_name, dev);

> That is the place where the mapping should happen... There is no
> guarantee that the resulting virq from irq_create_mapping() will be the
> same as the HW irq you passed in (it will in -most- cases with the
> current code, but it's a bug to rely on that behaviour). Thus you should
> store the result of irq_create_mapping() and use that. I see no
> advantage in "pre-mapping" things that way.

I'll submit an incremental patch to the ethernet driver.


-Olof
