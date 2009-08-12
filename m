Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E68CCB7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 17:57:44 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EE3F1DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 17:57:43 +1000 (EST)
Subject: ARM clock API to PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: devicetree-discuss@lists.ozlabs.org
Content-Type: text/plain
Date: Wed, 12 Aug 2009 17:57:05 +1000
Message-Id: <1250063825.15143.43.camel@pasglop>
Mime-Version: 1.0
Cc: John Jacques <john.jacques@lsi.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Torez Smith <torez@us.ibm.com>, Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi folks !

(Russell, let us know if you want to dropped from the CC list, but I
felt you may have some useful input to provide here).

So I think it would be valuable to provide the ARM clock API exposed by
include/linux/clk.h on various PowerPC embedded hardware.

However, that brings various issues that I would like to discuss here,
as while the API exposed to driver is quite sane and something we might
want to keep mostly intact, I'm not too happy with what appears to be
the common practice on ARM which is to re-implement the whole API on
each machine type :-) I understand why they do that but that won't work
very well for us.

That leads to two major "items" to deal with basically:

 - What provides the implementation of clk_get & friends
 - How do we want (do we want at all ?) to use the device-tree to
   some extent to represent the clocks

Now, here are some ideas, mostly in random orders, that I'm throwing
to the list for discussion, and from there we might see a plan emerge
(or not).

 - Similar to what I did for interrupts, the core clk API implementation
(if there is such a thing) should not -require- some device-tree
representation or another, ie, we could and probably should provide
helpers, for example by allowing clk_get to use the device-tree to
lookup clocks (see discussions below) etc... but the base infrastructure
should work without and it should be possible (even if discouraged) for
a platform to provide the necessary stuff entirely from C code, like we
can create virq mappings without device-tree.

 - We aren't be able to cater for all possible clock net layouts with a
single "core". Thus I think we should provide a "think" layer. The clk
object should probably have methods and clk_get_rate etc.. end up
calling these. Thus the "core" basically boils down to finding a clock
object for a given device. IE, Implementing clk_get(), which thus could
become a ppc_md. callback. We can provide a default one that uses the
device-tree to some extent, do be discussed.

 - I looked at ARMs' mach-ns9xxx, which pretty much does the above
(without the ppc_md. bit) and I tend to think that maybe this would do a
nice base for a "core". I do wonder whether we should have the "ops" in
a separate struct so that it's easier for multiple instances of a clk to
share ops (when multiple clocks come from the same clock chip).

 - From the above, question: Do we want to keep that parent pointer ?
Does it make sense ? Will we have objects that are clock providers and
themselves source from multiple parent ? Or we don't care and it becomes
entirely the responsibility of a given struct clk instance to deal with
its own parenthood ? Parenthood in the core has the advantage of making
it potentially easier to represent clock nets in the device-tree.

 - Device-tree: The idea on top of my mind would be to define a
clock-map property that has the following format:

A list of:
	- zero terminated string clock ID, padded with zeros
          to a cell boundary
 	- a phandle to the clock provider
	- a numerical (string ?) ID for that clock within that provider

The core would thus be able to do a search in that list based on the
clock-id passed in, or if clk_get(dev, NULL), then, use the first one.

A bit like irq_hosts, we provide a way to register clock providers
associated with a device-node. They provide a matching clk_get()
routine, thus when clk_get is called, the above lookup is done in the
clock-map, the clock provider is found, and it's own clk_get() method is
called with the original ID, the numerical ID, the target device, all it
might need to sort things out.

That's a reasonably simple way. I was thinking about something more
fancy like interrupts, with a #clock-cells, clocks, clock-parent
proprerties etc... but that has several drawbacks and isn't that useful.
One drawback is that like interrupts, it's hard to use such a scheme
with more than one parent for a device, and that's a lot more common
with clocks. Also, the existing API uses string clock IDs while the
above would have worked well only with numerical IDs.

Anyways, you guys give it a good thought and we see how it goes, it
shouldn't be a big deal, what do you think ?

Note that clock providers can be any node, so they can themselves be
of_devices that are naturally probed as such. We of course end up with
the usual problem of who gets registered first, since obviously clock
providers need to come in before they are looked up, and so I might
suggest that we stick in there a clock-provider property with no value,
and we have a way to return a specific error code to the driver if there
seem to be a DT clock provider but nothing registered for it yet, but
that adds some complication.

Maybe threaded probe can get us out of it by having one guy wait and the
probe continue until the clock provider is there :-) Or in the meantime
we just manually register them from arch code... whatever.

Also, it would be nice to have a way to have "generic" clock provider
drivers. For example, have a driver for the FooBar Clock chip, which is
known to provide 4 fully programmable clocks. So there could be a
generic driver for that, attached to the clock provider by the probe
code or via the device-tree, the devices clock-map's just provide the
clock ID within the chip (which output of the chip they are connected
to), and so the remaining questions is what to program in each clocks.

That's where we may want to define a clock-rates property that the clock
provider uses. HOWEVER, I'm keen at first to make that device-specific
rather than try to go to far at generalizing. Clock ships are fancy
little things with all sort of weird issues and constraints, so while it
would be nice to have all the necessary infos to program it in the DT,
I'm tempted to make the 'format' of those specific to a given clock chip
device/driver combination. To be discussed.

Anyway, thoughts ?

Cheers,
Ben.
