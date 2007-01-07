Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 76FB6DDDFC
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jan 2007 08:18:42 +1100 (EST)
Subject: Re: [PATCH] Probe Efika platform before CHRP.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <45A1535C.1080007@genesi-usa.com>
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>
	<1166528379.19254.69.camel@localhost.localdomain>
	<4587D338.7060906@246tNt.com>
	<1166538553.25827.99.camel@pmac.infradead.org>
	<1166558300.19254.71.camel@localhost.localdomain>
	<1167773388.22068.443.camel@pmac.infradead.org>
	<1167773863.6165.82.camel@localhost.localdomain>
	<1167775493.3660.23.camel@shinybook.infradead.org>
	<528646bc0701021504k88682bl765fad4c100bd40e@mail.gmail.com>
	<45A01416.6080401@genesi-usa.com>
	<528646bc0701061423o270df3dfj9d27d5572840ec79@mail.gmail.com>
	<45A1535C.1080007@genesi-usa.com>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 08:16:57 +1100
Message-Id: <1168204618.22458.60.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Linux PPC DEV <linuxppc-dev@ozlabs.org>, bbrv@genesi-usa.com,
	David Woodhouse <dwmw2@infradead.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> NetBSD, FreeBSD will support the device tree for enumeration and the
> ports in progress already do, and they also keep the Client Interface
> open so they have a much better environment to work from than the
> Linux "cache" of the device tree. If the OF device is there and there
> is no driver in the OS, at least somehow (slowly) it could be used.

The idea that keeping OF alive is a "much better environment" to work
from is at best an illusion.
 
> #1: As the only Open Firmware platform on this chip, what *we* do matters
> here, we DO have to offer some stability in operating system support
> and that means once we fix a device tree it needs to stay fairly similar,
> which is exactly why we feel justified defining the tree standard for it :D

And that's why we feel justified asking you to change it for the very
reason that you did this "definition" behind closed doors, repeately
refusing to discuss it publically with the other parties involved in
porting linux to the 52xx

> We do have to work with a lot more operating systems and vendors than
> just Linux, and a "booting without Open Firmware" standard which proves
> to solve the lack of device tree in U-Boot and other firmwares by making
> more work for firmware and Linux kernel porting harder, is not really
> something we are too concerned about.

If that's what you think it is, then you are full of sh*t. Sorry, but
I'm getting really badly pissed off by your attitude and that of bPlan.
There is a limit to the amount of arrogance I can cope with.

>  We hope we offer something a little
> better than "recompile your device tree file, embed it into the kernel,
> hope UBoot is the correct version, or recompile it, and flash and hope for
> the best". What we offer here is fairly unique; both in that we seem to be
> the only guys offering Open Firmware (especially a C-based one, OpenBIOS
> is 90% Forth which is a terrible lock-in), and on the MPC5200 (or PowerPC
> in general).

Can we cut on the marketing filler a bit here and get back to useful
points ?

> We also recognise OF and the device tree is flawed in some areas, RTAS
> isn't the best thing in the world (but it is totally misused in Linux,
> in places) so we are not BLIND to the need for change, we just think a
> few compatibility names and node device_type changes are not really where
> the real problems are.

It's where most of the problems that matter in pratice are. As for
"runtime abstraction of hardware", I agree, RTAS sucks. As SMM BIOS
sucks. As ACPI tables suck. As keeping OF alive suck badly too. In fact,
there isn't a single attempt at doing that sort of thing that has not
resulted in creating more problems than it solves, except maybe in some
very limited circumstances where the firmware and the OS have been very
closely tailored to each other.

In fact, history so far proves that it's a bad idea. It sounds good at
first, but when you get down to the details, it doesn't work out.

Get away with it, nothing works as well as a good HW description &
documentation and proper drivers for it. 
 
> #2: Personally I think naming device compatibility after the chip they are in
> is a ridiculous lock-in, also. You may end up with a device_type of
> ethernet, and compatibility flags for 100 SoC chip numbers. This is
> fairly stupid.

That isn't the rule. The rule for compatible is to name after the
functional cell used. However, if it happens that this cell is very
specific to a familiy of SOCs (which is common), then go for it. The
rule is also that "compatible" is a list from the most specific to the
most generic. Thus it _ALSO_ shall contain a name specific to a given
implementation in order to allow the driver to differenciate them in
order to work around the always present implementation specific errata.

> Isn't the e300 PVR and e300 SVR, or any other device identifier on the
> chip, a much better differentiator for drivers, than a named compatibility
> flag? These are present in the device tree (/cpu node?) no? I can't boot
> mine currently I blew up my power supply unfortunately.

The PVR of the core is probably the worst possible choice there :-) If
there's one thing that really doesn't matter much as far as device
identification is concerned, it's what core is used on the die.

> I happen to know the next Freescale device won't be called 52xx so we're
> talking about adding another compatibility naming to it like 51xx or 55xx
> or 5xxx and changing everyone's firmware and Linux device trees again.

Why ? Who cares what they call the next one ? Once we have a defined
binding that properly identify those parts. If their next chip has an
FEC that is actually compatible with the 52xx-fec, then it should
contain that in the compatible property, whatever the marketing name at
the time is. We pick a name that defines a programming interface. It
could be anything. It could be the codename of the cell of we knew it.
52xx-fec is as good as anything else, as long as we _agree_ what
convention we want to use and keep consistent accross devices. It's an
arbitrary choice.

> Or you could switch based on the processor! Cleaner, simpler, and doesn't
> need each device to have a specially unique name, only a vague "class"
> without some specific model number in it. If it's an SoC.. this is what
> the SVR is for!

And totally bogus.

> #3: While the above is basically a case for an SoC node (device parent
> would have the SVR in it), this does not scale generically or flexibly
> to non-SoC platforms where devices are nevertheless highly integrated.

? I don't understand your sentence.

> AMD's new processors with integrated CPU and memory controller, will not
> be classed as SoC's - how would you class them, really? Just a CPU with
> some devices builtin (aha!) I would say. With the Pegasos, we have the
> CPU, and the Marvell chip has Ethernet (not on PCI) and SRAM (also just
> mapped in as memory) but it is not an SoC.

Who cares ? I don't personally think the word "SoC" is indeed very good
as, as you pointed out, things can be implemented in different ways with
the same parts. However, again, it's just arbitrary naming conventions
to represent the specific set of IP blocks those drivers we are writing
for.

Take a very good example here: 4xx and cell.... The 4xx processors use
the IBM CoreConnect library of parts for their on-chip devices (EMAC
ethernet, MAL, PLB5, PLB4, OPB busses, etc...). They are technically
SoCs. However, we now have this southbridge for the Cell processor which
happens to ... contain a PLB5 and all ther other bits & pieces. In fact,
it also contains a 405 so it could be considered a SoC... or not :-) The
point is:

IT DOES NOT MATTER !

It's all a naming convention. We call plb5 ... plb5 heh ! The emac will
have a compatible property with something like "emac-axon\0emac4\0emac".
That is, from the more specific to the more generic: The axon
implementation of emac, which is an emac4 cell which is an emac familiy
of ethernet cores. This is a convention. Once decided (there will be a
public discussion, unless nobody disagrees with my proposal there), if
tomorrow, a version of AMD64 is released with an EMAC in it and x86
folks want an OF-like device-tree (which is something that might be
happening sooner than expected), it will hopefully follow that
convention.

And this has nothing to do with booting without OF. In fact, we should
split that document between what is indeed booting without OF (the
format of the flattened device-tree that can be provided by zImage or
uboot if you don't have a real OF) from what is in practice OF bindings
for a variety of chips out there.  

> We just don't want to clutter up the root node with devices, otherwise
> it would basically be more of a device shrubbery. The e300 SVR is also
> defined in the manual (as is the e500 equivalent, and e200 equivalent)
> as a CPU core feature, not a SoC-device feature, so this kind of
> differentiation and numbering belongs in the CPU node.

If there is something that does NOT belong in the CPU nodes, it's
anything related to the on chip devices. Bang bang... try again.

> ~
> 
> Those are MY problems with the device tree specification you have with
> "Booting Without Open Firmware". I am sure the other guys have other
> things to say.

You don't seem to understand it much though.

Ben.
