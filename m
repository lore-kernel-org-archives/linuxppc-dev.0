Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BBCB2DDE9F
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 18:58:09 +1000 (EST)
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
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <34eddd7ce58e7983017077454d592332@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Sun, 3 Jun 2007 10:57:59 +0200
To: Gabriel Paubert <paubert@iram.es>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> Oh what the hell, I'm too curious...  "pnpPNP,0" it is.
>>>>
>>>>> I believe that "8259" should appear somewhere because of the
>>>>> "8259-interrupt-acknowledge" property (defined in CHRP bindings)
>>>>> which you can have on the parent bridge to speed up interrupt
>>>>> vector acquisition.
>>>>
>>>> You're not CHRP so you have nothing to do with the CHRP
>>>> bindings...
>>>
>>> Still, you are close to CHRP
>>
>> Not at all, the rest of the device interrupt subsystem
>> is very different, too.
>
> Given how well you agree, I understand how other people
> might get a bit confused ;-)

Heh.  Let's look at it some other way: if you use
"chrp,iic", this node needs to be handled by either
CHRP platform code (which will not work, you aren't
CHRP), or by platform-specific code.  If you use the
generic "pnpPNP,0" name, it can (in theory) be handled
by architecture-neutral code, even.

For the foreseeable future (or perhaps forever) the
interrupt stuff will be set up from the platform
code, so there is no direct impact on Linux.  You
might want to support other OSes, or be more future-
proof, or generically want a cleaner device tree.

> This said, I'm looking at device trees right now, and I can understand
> that interrupt-parent of the 8259 is &mpic in mpc8641_hpcn.dts, but
> I don't understand at all why it is &pci1 on the mpc85??cds.dts.

Perhaps the 8259 IRQ output is routed to a PCI
interrupt.  If not, this is just plain wrong.

> But the definition of the ISA bridge in these files is very strange to
> start with: I've never seen an ISA bridge with only an interrupt 
> controller
> on it, no interrupts are connected to it

Maybe that's why it works ;-)

> and its reg property is
> almost certainly wrong.

<19000 0 0 0 0> could be right, that means device d#18
on PCI bus 1.  There is a missing bus #1 node in between
though.  And the unit address is @12 in that case,
not @19000 .

> Maybe it is an example of things that should
> not be done.

Maybe :-)

>>> and the CHRP bindings do apply :-)
>>
>> Nope.
>
> At least the 8259-interrupt-acknowledge property of the bus
> on which the ISA bridge is found should keep its name. It's what
> the kernel uses.

Only the CHRP Linux platform code should use that.
It's not necessarily a bad idea to define your
platform's binding to do the same, of course --
other platform's bindings do not apply to yours,
but there is no harm in creating a certain similarity.

I have no idea what this whole 8259-ack thing is
so I cannot comment further.

> It just seems odd to call the chip iic (for ISA interrupt controller
> I suppose) on one side and 8259 on the other. Naming consistency
> is important.

It certainly helps, yes.

> Technically the 8259-interrupt-acknowledge is not a very fortunate
> name choise since it is an a 8259 like chip (or an ISA bridge
> for the matter) that has to claim the interrupt acknowledge
> cycles, but it is what happens in practice.

Could you explain what this is (or point me to
some doc)?

>>> the 8259
>>> should thus be chrp,iic :-) It's even documented that way in
>>> booting-without-of.txt iirc.
>
> Nope.

Good to hear :-)


Segher
