Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28DDA67CDC
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 08:47:46 +1100 (EST)
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <457F1F6E.4020502@freescale.com>
References: <20061208190758.6cee088f.kim.phillips@freescale.com>
	<1165648490.1103.117.camel@localhost.localdomain>
	<91EF8E0D-06BC-47FD-89E6-6350430946F9@kernel.crashing.org>
	<20061211155155.26868ca6.kim.phillips@freescale.com>
	<A1A95A77-B86C-41CF-87DC-58CD63843CE3@kernel.crashing.org>
	<20061211201055.21031c9b.kim.phillips@freescale.com>
	<1165890570.11914.5.camel@localhost.localdomain>
	<457F1F6E.4020502@freescale.com>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 08:47:38 +1100
Message-Id: <1165960058.11914.72.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > 
> > The point here is that other developpers making their own mpc83xx based
> > boards will not want to use your ppc_md.
> 
> They *may* not want to (and they certainly shouldn't be forced to), but 
> some may not want to define a new ppc_md (or modify a probe function) 
> for every new board if all of the differences are encapsulated in the 
> device tree.  I thought one of the main goals of having a device tree is 
> that if it's done right, the kernel need not know about every single 
> model of board, just the different components that a device tree can 
> specify.

That's the ideal situation yes. However, from a more realistic point of
view, I do expect embedded vendors to have their own ppc_md (though it
may cover multiple boards from that vendor). For things like board
specific initialisations, magic GPIOs, reset lines, etc...

The problem with Kim initial patch is that it matches on anything that
says "mpc83xx", thus you completely lose the ability to match somethign
else unless you remove that property, which I find a bit gross.

I do prefer the middle ground approach he (and you) proposed to have an
"mpc83xx_generic" in the compatible property and match on that, but I'm
not 100% certain we are really there yet and I would have been a bit
more comfortable limiting that to known fsl boards. But you are the guys
to maintain those things, so do as you like there.

> More generally (and longer-term), what about a completely generic 
> platform init file that implements the "booting-without-of.txt" 
> platform?  That is, a string that can be placed in the compatible 
> property, regardless of board or CPU, in order to assert that nothing 
> board-specific has to be done other than as specified by the device 
> tree.  The model property could still hold the actual board ID if needed 
> to present to the user, or for matching a more specialized machine 
> description if problems arise and the device tree cannot be easily 
> changed (the generic probe could be arranged to run last).
> 
> Alternately, just allow the kernel to boot without finding a matching 
> probe, if generic code is able to extract enough information from the 
> device tree for generic versions of any non-optional ppc_md functions to 
> work.  If a probe does match, then it can fill in any ppc_md fields it 
> wants to override (and/or do special initialization, etc).  ppc_md 
> fields can also be filled in by CPU-specific code, or by drivers the 
> device tree instantiates.

That's sort of a very long term ideal, yes, but again, we aren't quite
there and I'd rather not try to go too fast in that direction. We still
have plenty of stuff to port over from arch/ppc, cleanups to do (like
merging the PCI code, the kernel init code) etc... before we should
spend too much time on that I think.

Ben.
