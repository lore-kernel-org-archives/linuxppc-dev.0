Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9138ADDE45
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 05:05:45 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l4IJ5dlP001214
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 12:05:40 -0700 (MST)
Subject: Re: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev
	1.02hardware
From: Jon Loeliger <jdl@freescale.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <464DEF3C.7070202@freescale.com>
References: <1179245829.8132.100.camel@rhino> <1179247809.8132.138.camel@rhino>
	<46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>
	<1179417813.8132.250.camel@rhino>
	<744CD970-5421-47D6-A30A-C7C79BE21BE8@kernel.crashing.org>
	<1179421139.8132.256.camel@rhino> <464CA302.9060707@freescale.com>
	<20070518005641.GA27350@localhost.localdomain>
	<464DB986.20205@freescale.com>
	<20070518164628.GA16825@ld0162-tx32.am.freescale.net>
	<464DE2D3.3090805@smiths-aerospace.com>
	<464DE4C7.7030906@freescale.com>
	<464DE5D2.5000301@freescale.com> <464DE6C1.2010108@freescale.com>
	<464DE7F7.3030302@freescale.com>  <464DE8BB.5040601@freescale.com>
	<1179512385.19664.8.camel@ld0161-tx32> <464DEF3C.7070202@freescale.com>
Content-Type: text/plain
Message-Id: <1179515137.19664.19.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 18 May 2007 14:05:38 -0500
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Timur Tabi <timur@freescale.com>,
	Wei Zhang <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-05-18 at 13:23, Scott Wood wrote:
> Jon Loeliger wrote:
> > First of all, I wanted to get away from the notion of calling
> > anything a "jumper".  What I said to you was to predicate the
> > clause based on some arbitrary conditional, not just some "jumper
> > setting."
> 
> Yes, I like the "hwoption" name better.

I think my point was missed.  It could be more general
than "a hardware thing".  Sure, HW contributes.


> No, we were pretty much always talking about a run-time thing.

On he contrary, here are copies of two pieces of mail from
roughly May 2006 and Feb 2007 in which CPP and M4 as _compiled_time_
processing are being discussed.  In the latter, you discuss it more:.

	From: 	Kumar Gala <galak@kernel.crashing.org>
	To: 	Jon Loeliger <jdl@freescale.com>
	Cc:	Jon Loeliger <jdl@jdl.com>, Benjamin Herrenschmidt
		<benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org list
		<linuxppc-dev@ozlabs.org>
	Subject: 	Re: DTC/dts modifications
	Date: 	Mon, 1 May 2006 14:52:23 -0500	

	[snip]


	>> If these used some other symbol instead of '#' cpp 
	>> will be happy and we can use it to create macros for us.
	>
	> Yeah, we're not going to be able to change those; they
	> are "By The Book".

	By what book?  It would seem to me that BNF for dtc is
	completely under our control and if we want to change it we can.
	I understand that there is some correspondence to Open Firmware,
	but it seems that if its people are ok with the dts format
	changing that's a lot easier than implementing tons of support
	in dtc for features that cpp gives us.

	[I'm also guessing no one's really got time to go and implement
	these features in dtc]

	> Instead, we'll have to make the lexical analysis conscious
	> of something like a <newline> context sensitive token or so.
	> Or throw some flag to cpp to not emit location markers.

	- kumar





	From: 	Jon Loeliger <jdl@jdl.com>
	To: 	Benjamin Herrenschmidt <benh@kernel.crashing.org>
	Cc: 	linuxppc-dev@ozlabs.org,
		Roland Dreier <rdreier@cisco.com>,
	          Stefan Roese <sr@denx.de>, linuxppc-embedded@ozlabs.org
	Subject:Re: [PATCH] ppc: Add support for AMCC Taishan 440GX eval board
	Date: 	Mon, 12 Feb 2007 14:16:21 -0600	

	So, like, the other day Benjamin Herrenschmidt mumbled:
	> Note that there are still things that we might want to
	> change. For example, I think we really should look into adding
	> a macro mecanism and/or an include mecanism to dtc so that we
	> can do things like #include <ibm440gp.dtc> to get the base
	> processor/SoC definition and then "overlay" some properties on
	> top of it (like emac phy mode etc...)

	What do people prefer here?  Straight CPP pre-run?
	Direct support built into dtc to do file-inclusion, macros?

	Thoughts, opinions, suggestions, pre-NACKs, Cabernet Franc bribes?

	jdl


And you reply:


	Simple textual macros would make it difficult to define 123A and
	123B SoCs whose device tree nodes are mostly a generic 123, but
	require a few changes in various parts.  I'd rather see dtc
	support overlaying trees, with the "newer" tree able to add,
	modify, and remove nodes and properties from the "older", more
	generic tree.

	Parametric macros (or "template" nodes) might be nice for a few
	things on top of that, though (preferably with better syntax
	than CPP).

Clearly, we have in fact historically discussed compile-time
conditional DTC behavior.

> Compile-time would just give you a more convenient way of generating 
> multiple dtbs; it wouldn't address the root problem of combinatorial 
> explosion with several independent options.  Even when the number of 
> alternatives isn't high, it's much nicer to the user to be able to just 
> type a command into u-boot (or better yet, have it be autodetected) when 
> an option changes than to have to rebuild and install a new dtb.

Yes, I understand.  But I think, say, the Linux build handles
the compile time combinatorial explosion of compile time options
reasonably well so far... :-)

jdl
