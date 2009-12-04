Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A3EFBB7BF2
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 20:06:02 +1100 (EST)
Subject: Re: PCI interrupt question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Hawkins <dwh@ovro.caltech.edu>
In-Reply-To: <4B1816F9.1020601@ovro.caltech.edu>
References: <1259821316.12651.26.camel@qu102.quarc.com>
	<4B17F14A.1060001@ovro.caltech.edu>
	<1259869140.18190.52.camel@qu102.quarc.com>
	<4B1816F9.1020601@ovro.caltech.edu>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Dec 2009 20:05:53 +1100
Message-ID: <1259917553.2076.1270.camel@pasglop>
Mime-Version: 1.0
Cc: Jeff Hane <jeff.hane@maxim-ic.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-12-03 at 11:52 -0800, David Hawkins wrote:
> 
> Really? I thought the pci_dev structures represent the
> devices found on the PCI bus, and the IRQ line in
> that structure was merely copied from the configuration
> space registers. 

No, it's not. In fact it's mostly irrelevant. It has room for only 8
bits and we commonly manipulate a lot more interrupts on some modern
systems.

Linux will obtain from the device-tree the routing for the interrupt
line(s) of the device. If you don't have a node for the device (which is
allowed for PCI), linux will use the INTERRUPT_PIN register to query
which interrupt line is the device output, and will use the host bridge
device-tree node "interrupt-map" property to find where it's connected
to on the PIC.

It will then map that to a linux virtual IRQ number which is what you
find in pci_dev. At least that's how it works on powerpc :-)

> When you request that interrupt, the
> code would have to remap it to a host IRQ line, which
> it would use the DTS for. (But I'm just speculating).

No, it's already remapped in pci_dev. The mapping happen when the PCI
devices are discovered by the kernel.

> Bottom line is; if the IRQ field of lspci is 0, then you
> need to figure out that problem first :)

I wouldn't trust lspci too much, I'm not sure we bother writing back the
number to the PCI_INTERRUPT_LINE register anymore anyways.

If your pci_dev->irq is non-0 then Linux found -something- but it might
not be right, it depends on your device-tree.

Cheers,
Ben.
