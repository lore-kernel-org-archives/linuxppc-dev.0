Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D6A9BB7B76
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 14:21:39 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3C18BDDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 14:21:38 +1000 (EST)
Subject: [RFC] Clock binding
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: devicetree-discuss@lists.ozlabs.org
Content-Type: text/plain
Date: Tue, 18 Aug 2009 14:21:28 +1000
Message-Id: <1250569288.19007.15.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So here's a followup to my discussion about the clock API.

I'm cooking up a patch that replace our current primitive implementation
in arch/powerpc/kernel/clock.c with something along the lines of what I
described. However, I want a bit more churn here on the device-tree
related bits.

So, basically, the goal here is to define a binding so that we can link
a device clock inputs to a clock provider clock outputs.

In general, in a system, there's actually 3 "names" involved. The clock
provider output name, the clock signal name, and the clock input name on
the device. However, I want to avoid involving the clock signal name as
it's a "global" name and it will just end up being a mess if we start
exposing that.

So basically, it boils down to a device having some clock inputs,
referenced by names, that need to be linked to another node which is a
clock provider, which has outputs, references either by number or names,
see discussion below.

First, why names, and not numbers ? IE. It's the OF "tradition" for
resources to just be an array, like interrupts, or address ranges in
"reg" properties, and one has to know what the Nth interrupt correspond
too.

My answer here is that maybe the tradition but it's crap :-) Names are
much better in the long run, besides it makes it easier to represent if
not all inputs have been wired. Also, to some extent, things like PCI do
encode a "name" with "reg" or "assigned-addresses" properties as part of
the config space offset in the top part of the address, and that has
proved very useful.

Thus I think using names is the way to go, and we should even generalize
that and add a new "interrupt-names" property to name the members of an
"interrupts" :-)

So back to the subject at hand. That leaves us with having to populate
the driver with some kind of map (I call it clock-map). Ideally, if
everything is named, which is the best approach imho, that map would
bind a list of:

	- clock input name
	- clock provider phandle
	- clock output name on provider

However, it's a bit nasty to mix strings and numbers (phandles) in a
single property. It's possible, but would likely lead to the phandle not
being aligned and tools such as lsprop to fail miserably to display
those properties in any kind of readable form.

My earlier emails proposed an approach like this:

	- clock input names go into a "clock-names" property
	  (which I suggest naming instead "clock-input-names" btw)

	- the map goes into a "clock-map" property and for each input
	  provides a phandle and a one cell numerical ID that identifies
	  the clock on the source.

However, I really dislike that numerical clock ID. Magic numbers suck.
It should be a string. But I don't want to add a 3rd property in there.

Hence my idea below. It's not perfect but it's the less sucky i've come
up with so far. And then we can do some small refinements.

	* Device has:

		- "clock-input-names" as above
		- "clock-map" contains list of phandle,index

	* Clock source has:

		- "clock-output-names" list of strings

The "index" in the clock map thus would reference the
"clock-output-names" array in the clock provider. That means that the
"magic number" here is entirely local to a given device-tree, doesn't
leak into driver code, which continues using names.

In addition, we can even have some smooth "upgrade" path from existing
"clock-frequency" properties by assuming that if "clock-output-names" is
absent, but "clock-frequency" exist, then index 0 references a fixed
frequency clock source without a driver. This could be generally handy
anyway to represent crystals of fixed bus clocks without having to write
a clock source driver for them.

Any comments ?

I'll post a patch, maybe later today, implementing the above (I may or
may not have time to also convert the existing 512x code to it, we'll
see).

Cheers,
Ben.


 
