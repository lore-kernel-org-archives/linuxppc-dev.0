Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2D476DDEC6
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 19:07:13 +1000 (EST)
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20070603083339.GB2157@iram.es>
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
Content-Type: text/plain
Date: Sun, 03 Jun 2007 19:07:00 +1000
Message-Id: <1180861620.31677.10.camel@localhost.localdomain>
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


> > Not at all, the rest of the device interrupt subsystem
> > is very different, too.
> 
> Given how well you agree, I understand how other people
> might get a bit confused ;-)

Well... we initially decided to base the whole linux device-tree thing
on the CHRP specification. After all, it's flexible and pretty much
everything that has a PCI bus (and especially if it has an i8259) can
almost be considered as a superset of CHRP :-)

Now, Segher seems to disagree, but I tend to think that since it's been
the common practice -and- the chrp spec to make the cascaded i8259 on
the ISA bridge "chrp,iic" so far, doing differently gratuituously will
not help anybody whatsoever.

But feel free to disagree, it's not of terrible importance. The board
code is the one to "find" the PICs, including the cascaded 8259, the
acutal 8259 driver takes whatever node is given to it, so as long as
your .dts matches your board, it doesn't matter that much.

> This said, I'm looking at device trees right now, and I can understand
> that interrupt-parent of the 8259 is &mpic in mpc8641_hpcn.dts, but
> I don't understand at all why it is &pci1 on the mpc85??cds.dts.

Maybe the ISA IRQ on that board is routed to a PCI IRQ# line in which
case it will use the ISA bridge pci device to lookup in the PCI
interrupt map... it's a bit weird but as long as it resolves using the
standard parser, it's perfectly fine.

> But the definition of the ISA bridge in these files is very strange to 
> start with: I've never seen an ISA bridge with only an interrupt controller 
> on it, no interrupts are connected to it and its reg property is
> almost certainly wrong. Maybe it is an example of things that should
> not be done.

Heh, dunno, I haven't looked that closely at what they did... I would
have expected legacy devices to have their IRQ pointing to the 8259
indeed.

Ben.
