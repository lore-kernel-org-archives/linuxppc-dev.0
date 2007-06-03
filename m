Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1BD26DDE43
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 20:03:01 +1000 (EST)
In-Reply-To: <1180861939.31677.15.camel@localhost.localdomain>
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
	<1180861939.31677.15.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5b895c2df8d84d33ba229aeb965f5aa3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Sun, 3 Jun 2007 12:02:48 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I have no idea what this whole 8259-ack thing is
>> so I cannot comment further.
>

> When you get an IRQ on your main PIC (MPIC for example) which happens 
> to
> be the cascade to the 8259, you have two ways of retreiving the actual
> 8259 interrupt source.
>
> One is the "poll" method which goes read IOs on the 8259. The other one
> is to generate a PCI interrupt acknowledge cycle on the bus that leads
> to the 8259. If your bridges properly forward it all the way to the ISA
> bridge, it should "mimminc" the x86 interrupt acknowledge and return 
> the
> interrupt number (an INTACK cycle on PCI is pretty much a read from a
> broadcast address).

Ah, that stuff.

> So on CHRP, that property in a PHB indicates, when possible, and 
> address
> you can ioremap and readb from to generate an INTACK cycle on that bus
> and retreive the pending IRQ of any legacy PIC on that segment.

Right, so it is just misnamed (and belongs in the "reg"
property for that specific PHB anyway).  It has nothing
to do with 8259, it is part of the PCI spec.

> In theory, in fact, MPIC itself, at least the PCI variant of it, is 
> also
> supposed to be able to respond to these rather than reading an MMIO
> register (remember, MPIC was supposed to be useable on x86 too, though 
> I
> don't know if that was never actually implemented).

OpenPIC was I think.  No idea if it ever actually got
used anywhere though.


Segher
