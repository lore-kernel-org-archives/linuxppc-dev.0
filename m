Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 556FDDDE38
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 19:59:57 +1000 (EST)
In-Reply-To: <1180861620.31677.10.camel@localhost.localdomain>
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
	<1180861620.31677.10.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1c8da1eed0d6f2b87c47b865f11cb29f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Sun, 3 Jun 2007 11:59:46 +0200
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

> But feel free to disagree, it's not of terrible importance. The board
> code is the one to "find" the PICs, including the cascaded 8259, the
> acutal 8259 driver takes whatever node is given to it, so as long as
> your .dts matches your board, it doesn't matter that much.

Here at least we do agree -- with the one added nit that
when using "chrp,iic" you're _forcing_ it to be platform
code that handles this device.  But like I said before,
not all that important.

>> This said, I'm looking at device trees right now, and I can understand
>> that interrupt-parent of the 8259 is &mpic in mpc8641_hpcn.dts, but
>> I don't understand at all why it is &pci1 on the mpc85??cds.dts.
>
> Maybe the ISA IRQ on that board is routed to a PCI IRQ# line in which
> case it will use the ISA bridge pci device to lookup in the PCI
> interrupt map... it's a bit weird but as long as it resolves using the
> standard parser, it's perfectly fine.

I don't think it resolves using the _standard_ parser,
it needs a few of the workarounds.  But the tree there
is completely broken anyway, fixing it is highly
recommended ;-)


Segher
