Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 050BDDDF53
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 01:41:39 +1000 (EST)
Subject: Re: IRQ questions & puzzles
From: Jon Loeliger <jdl@freescale.com>
To: Charles Krinke <ckrinke@istor.com>
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1EB@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1EB@MERCURY.inside.istor.com>
Content-Type: text/plain
Message-Id: <1177688490.8797.11.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 27 Apr 2007 10:41:30 -0500
Cc: Randy Brown <rbrown@istor.com>, Chris Carlson <ccarlson@istor.com>,
	Kevin Smith <ksmith@istor.com>,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2007-04-26 at 13:36, Charles Krinke wrote:
> I have a linux-2.6.17.11 source tree that has configs for two boards.
> One has an 8241 and the other has an 8541. The kernel code works fine on
> the 8241, but appears to lock up in my custom driver in the 8541 when
> interrupts are enabled.

OK, let's back up a step.  The 8241 and the 8541 are
two very different parts.  Different PPC cores with very
different peripherals placed on two very likely different
boards as well.  So I am at a bit of a loss to understand
how you are comparing these two parts in casual comparison
like this.  You aren't suggesting that you are expecting
these to be the same in some way are you?

> What I see happening, based on using a BDI to go/halt after the apparent
> lockup is that the kernel is spinning around in routines like
> kernel/irq/handle.c:__do_IRQ and an associated
> arch/powerpc/kernel/irq.c.
> 
> It looks like the interrupt, which should be level triggered and at this
> point, is probably continuously asserted is causing the kernel to spin
> in a tight loop and be incapable of doing printk's out the serial port
> at 115200.
> 
> This leads to a few questions:

It certainly does! :-)

> 1. I can see most everything comes from arch/ppc, but do_IRQ comes from
> arch/powerpc. Is that OK?

"Most everything" for _which_ board?  The 8241 or the 8541?
Specifically, the former would easily still be arch/ppc based
while the latter _should_  be arch/powerpc based by now.
When compling arch/powerpc, only legacy #include files should
be being used during the build.

> 2. What is the most straightforward way to slow down a tight loop like
> this slow enough so I can printk what is happening.

Your BDI-2000, likely. :-)

> 3. What might be the likely scenarios leading to such a despicable
> state.

Initial PEBCAK, perhaps?  But yea, there may be a level difinition
problem on an line here.  Dunno yet, because the scenario seems a
bit strained or ill-described yet...

Any chance for a bit more clarity on what your situation is?

It seems to me that it is quite possible that many of these
issues might vanish with a 2.6.21 build straight up too.

HTH,
jdl
