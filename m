Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 01CA3DDE31
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 19:12:26 +1000 (EST)
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <34eddd7ce58e7983017077454d592332@kernel.crashing.org>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
	<1180734314.5674.49.camel@rhino>
	<4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org>
	<20070602085359.GA10333@iram.es>
	<3ebd6ca6877ea74925f066ff96ac81db@kernel.crashing.org>
	<20070602195308.GA21618@iram.es>
	<12ad593bd17f769e44f05bc24eac4d0a@kernel.crashing.org>
	<1180828907.14025.37.camel@localhost.localdomain>
	<28e0600256815f93db45b2f4eb2d9df5@kernel.crashing.org>
	<20070603083339.GB2157@iram.es>
	<34eddd7ce58e7983017077454d592332@kernel.crashing.org>
Content-Type: text/plain
Date: Sun, 03 Jun 2007 19:12:19 +1000
Message-Id: <1180861939.31677.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-06-03 at 10:57 +0200, Segher Boessenkool wrote:
> 
> I have no idea what this whole 8259-ack thing is
> so I cannot comment further.

When you get an IRQ on your main PIC (MPIC for example) which happens to
be the cascade to the 8259, you have two ways of retreiving the actual
8259 interrupt source.

One is the "poll" method which goes read IOs on the 8259. The other one
is to generate a PCI interrupt acknowledge cycle on the bus that leads
to the 8259. If your bridges properly forward it all the way to the ISA
bridge, it should "mimminc" the x86 interrupt acknowledge and return the
interrupt number (an INTACK cycle on PCI is pretty much a read from a
broadcast address).

The later is more efficient but the mecanism to generate such cycles is
very much platform specific and was never abstracted in the PCI stack
(possibly because x86 never needs to explicitely do it, it's all
implicit in the x86 bus protocol :-)

So on CHRP, that property in a PHB indicates, when possible, and address
you can ioremap and readb from to generate an INTACK cycle on that bus
and retreive the pending IRQ of any legacy PIC on that segment.

In theory, in fact, MPIC itself, at least the PCI variant of it, is also
supposed to be able to respond to these rather than reading an MMIO
register (remember, MPIC was supposed to be useable on x86 too, though I
don't know if that was never actually implemented). But then, I've never
seen that used or implemented in practice.

Cheers,
Ben.
