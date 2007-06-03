Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id D4B9EDDE42
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 18:33:45 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Sun, 3 Jun 2007 10:33:39 +0200
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Message-ID: <20070603083339.GB2157@iram.es>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <28e0600256815f93db45b2f4eb2d9df5@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jun 03, 2007 at 09:41:33AM +0200, Segher Boessenkool wrote:
> >>Oh what the hell, I'm too curious...  "pnpPNP,0" it is.
> >>
> >>>I believe that "8259" should appear somewhere because of the
> >>>"8259-interrupt-acknowledge" property (defined in CHRP bindings)
> >>>which you can have on the parent bridge to speed up interrupt
> >>>vector acquisition.
> >>
> >>You're not CHRP so you have nothing to do with the CHRP
> >>bindings...
> >
> >Still, you are close to CHRP
> 
> Not at all, the rest of the device interrupt subsystem
> is very different, too.

Given how well you agree, I understand how other people
might get a bit confused ;-)

This said, I'm looking at device trees right now, and I can understand
that interrupt-parent of the 8259 is &mpic in mpc8641_hpcn.dts, but
I don't understand at all why it is &pci1 on the mpc85??cds.dts.

But the definition of the ISA bridge in these files is very strange to 
start with: I've never seen an ISA bridge with only an interrupt controller 
on it, no interrupts are connected to it and its reg property is
almost certainly wrong. Maybe it is an example of things that should
not be done.


> >and the CHRP bindings do apply :-)
> 
> Nope.

At least the 8259-interrupt-acknowledge property of the bus
on which the ISA bridge is found should keep its name. It's what
the kernel uses.

It just seems odd to call the chip iic (for ISA interrupt controller 
I suppose) on one side and 8259 on the other. Naming consistency
is important.

Technically the 8259-interrupt-acknowledge is not a very fortunate
name choise since it is an a 8259 like chip (or an ISA bridge 
for the matter) that has to claim the interrupt acknowledge
cycles, but it is what happens in practice. 

> 
> >the 8259
> >should thus be chrp,iic :-) It's even documented that way in
> >booting-without-of.txt iirc.

Nope.

	Gabriel
