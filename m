Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0A368B7D18
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 14:25:42 +1000 (EST)
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration
	for ALSA SoC drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
In-Reply-To: <20100427205924.GC15083@opensource.wolfsonmicro.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
	<4BD74D0C.40303@freescale.com>
	<20100427205924.GC15083@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Apr 2010 14:25:29 +1000
Message-ID: <1272428729.24542.70.camel@pasglop>
Mime-Version: 1.0
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-04-27 at 21:59 +0100, Mark Brown wrote:
> It's entirely possible that if the board designer intended the verious
> SSIs to be used in concert they've done something like cross wire the
> clocks which creates a board-specific interrelationship that needs to
> be dealt with. 

In which case, have that in some board specific code :-) Really, as I
said earlier, I think there's no point to aim toward a
uber-representation that can describe everything along with code that
can cope with anything the tree can describe :-) That's just insane.

I'd stay stick to the basics and move incrementally up until it stops
making sense:

 - First, the basics: nodes for actual physical devices. i2c codecs on
their i2c busses, DMA controllers, etc...

 - From there, see what simple properties are better off being put in
those respective nodes because they represent common enough variants of
functionality or simply because they are specific attributes of a given
device that aren't too concerned by the way things are interconnected.

 - Provide at least one identifier (either in a "sound" virtual device,
or just use the board's own "compatible" property) to have a .c file to
put everything together.

>From there, you may decide that 90% of the simple cases can be very
easily represented by a couple of properties in the said "sound" node,
and henceforth, create a simple.c "board" file that matches against a
list of boards known to fit within that simple model, and that pretty
much exclusively use the device-tree to put things together.

But you don't have to.

The whole thing is a matter of common sense and a bit of taste :-)

Cheers,
Ben.
