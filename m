Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3D33DDDEE9
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 06:23:56 +1000 (EST)
In-Reply-To: <20070602195308.GA21618@iram.es>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
	<1180734314.5674.49.camel@rhino>
	<4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org>
	<20070602085359.GA10333@iram.es>
	<3ebd6ca6877ea74925f066ff96ac81db@kernel.crashing.org>
	<20070602195308.GA21618@iram.es>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <12ad593bd17f769e44f05bc24eac4d0a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Sat, 2 Jun 2007 22:23:32 +0200
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

>> Yes, I think we all agree -- it should be interrupt-controller@20,
>> with 20, a0, 4d0 in the "reg" property.
>
> In the current tree it is called "i8259" in mpc8641_hpcn.dts.

"interrupt-controller" is the preferred name for all
interrupt controller nodes.  The "compatible" property
can easily distinguish between different types.  Not
that it matters all that much -- just remember that
the "name" is used for device matching before "compatible"
is (_should_ be, Linux ignores this part of the standard
right now in most cases), so don't put junk in there!

> The other
> ones which have a 8259 are not usable (mpc8555 for example). I don't
> even understand their reg property (19000 0 0 0 1),

Very weird indeed.  What bustype is this?  (I looked it up,
it's PCI, and I can't make heads or tails of it either --
it says it sits on bus #1, although its parent isn't bus #1;
and the final "1" should be "0".  Many more weird things
in that node, too).

> and the driver
> has hardcoded addresses at 0x20 and 0xa0, which is reasonable
> since I've never seen an ISA bridge put the 8259 at another address.

As long as the driver (platform code I hope?) at least checks
for the existence of the node, that's fair enough I guess.
Actually using the "reg" would be better of course.

>> I'm not sure what "compatible" should be for this node, someone
>> else can dig that up :-)

Oh what the hell, I'm too curious...  "pnpPNP,0" it is.

> I believe that "8259" should appear somewhere because of the
> "8259-interrupt-acknowledge" property (defined in CHRP bindings)
> which you can have on the parent bridge to speed up interrupt
> vector acquisition.

You're not CHRP so you have nothing to do with the CHRP
bindings...


Segher
