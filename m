Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6D160DDE30
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 07:36:41 +1000 (EST)
Subject: Re: Problem with OF interrupt parsing code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20071001210025.314240@gmx.net>
References: <20071001210025.314240@gmx.net>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 07:36:32 +1000
Message-Id: <1191274592.6310.13.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-10-01 at 23:00 +0200, Gerhard Pircher wrote:
> Hi,
> 
> I think I found an issue in the OF interrupt parsing code, although I
> have to admit that my device tree source doesn't really follow the
> specification.
> 
> First some information about my target setup. I didn't specify an
> interrupt-map and interrupt-map-mask property in the pci node, because
> AFAIK there are three different AmigaOne models with different IRQ
> routing. Secondly the AmigaOne is a desktop system with 4 PCI/AGP slots,
> thus I can't specify device nodes for all possible devices. By looking at
> pci_read_irq_line() in pci_common.c it should be possible for the kernel
> to fall back to the interrupt settings in the PCI config space of every
> device.

That's deprecated and only support for legacy stuff that predates the
current device-tree support & old/crappy firmware.

You should be able to generate the appropriate interrupt-map from your
loader or wrapper to provide the routing for your slots. It should be
easy enough to have 3 static arrays in your wrapper and use the right
one to "set" the property value.

> Unfortunately I couldn't capture the kernel log, because the serial
> console is not yet working, so here comes a description of what I think
> is going on.
> Well, pci_read_irq_line() starts with PCI device 00:00.0 (PCI host bridge)
> and invokes of_irq_map_pci() in prom_parse.c. It find the predefined
> device node in the device tree. Since of_irq_map_one() can't find an
> interrupt property in the device node, it returns to pci_read_irq_line()
> and setups the interrupt mapping based on the settings in the PCI config
> space. So far so good.
> The problem occurs now, if there is no device node defined for another
> PCI device. In this case, of_irq_map_pci() checks for an interrupt pin,
> searches again for the host bridge node and calls of_irq_map_raw() with
> the device node of the host bridge. The function finds the
> #interrupt-cells, #address-cells, interrupt-controller properties, but
> fails to find the interrupt-map property (because it's missing in the
> device tree). Therefore the function then tries to find a new parent,
> which leads to an endless loop (it always selects the PCI2ISA southbridge
> in the device tree).
> 
> Can somebody confirm my explanation? It would help, if the kernel could
> fall back to the PCI settings in this case, too.

I'm not sure what you are trying to explain above... It looks like your
tree layout is somewhat broken though I think I see how... 

One option would be to make the PCI specific IRQ parsing stop & fail if
the host bridge doesn't provide a map instead of following up an
interrupt-parent link (which is I think what you have in there).

But I don't like that. Just fixup your maps properly and everything
should work just fine.

Ben.
