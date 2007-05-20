Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A31BDDE1A
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 00:52:52 +1000 (EST)
Message-ID: <465060D8.9090304@genesi-usa.com>
Date: Sun, 20 May 2007 15:53:12 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>	<FB8DD3C1-A095-4ABB-9E74-7EC66A43D983@kernel.crashing.org>	<464C800C.20400@freescale.com>	<FFBD3A3A-ADBE-4DC8-A1A1-4163367244D5@kernel.crashing.org>	<464C871C.4090300@freescale.com>	<5B363A90-5528-4441-BBF9-9C6D8833D938@kernel.crashing.org>	<20070518171555.543f9bdc@hyperion.delvare>	<D50C4D36-CEA5-4F7F-8A4C-CC747DF85865@kernel.crashing.org>	<464DD5E3.1060301@freescale.com>
	<6F8D3143-423D-45FA-9F40-00BF770831F2@kernel.crashing.org>
	<464E3F18.5010700@genesi-usa.com>
	<2087d135c4139e94e0b2c8826d808292@kernel.crashing.org>
	<464EFE96.3000801@genesi-usa.com>
	<94e1abed8781f279d2d4c7cddbc25ba2@kernel.crashing.org>
In-Reply-To: <94e1abed8781f279d2d4c7cddbc25ba2@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Segher Boessenkool wrote:
>>> Actually, you can, and should.  All this information is
>> I'll take an example of putting useless information in
>> the device tree - how about the CPU node? It has all the
>> information for cache sizes etc. but does Linux use it?
> 
> It *should* use it though.  But it cannot really do that,
> since many/most device trees are broken in this respect.

But if it does work, you could use it. There is information
in the device tree enough, I think, to determine which board
you are running on, which firmware version, and then simply
use that data.

However it doesn't. But as an aside, maybe it's not the best
example, since this is part of the Open Firmware device tree
standard and it would be a shame not to implement in any
device tree information which is dictated by a real standard.

The Linux flat device tree is no previously-ratified IEEE
standard in use for 15 years though :)

> Linux *does* use some of the "cpu" properties though.
> Maybe in the future it will use more.





>> This is what I mean by 'describing exactly what the device
>> is' being rather a tedious and time-wasting concept.
> 
> This is equivalent to stating the device tree is a useless
> concept.  You are free to your opinion of course.

The device tree is a great concept for what it was invented
for; it describes the hardware and it ALSO provides access
to rudimentary abstraction of hardware device drivers. OF
is not just a machine description, it is supposed to involve
using those devices through standardised I/O and function
calls.

The device tree in OF and the FDT are relegated to machine
descriptions in Linux because a) Linux kills the OF on boot
and doesn't use any of the abstraction and b) U-Boot doesn't
have any.

>> I might be a little less noisy about it if there was
>> some kind of edict for devices never to wander outside
>> of their own node in the device tree, but there isn't.
> 
> I'm not sure what you mean here.  It is best practice
> for device nodes to be reasonably self-contained though.
> Of course not completely; every node always has to refer
> to its parent bus, etc.  Device drivers will sometimes
> have to refer to board model for board-specific workarounds.

Right. So, my question is, what is the difference between
device A and B on the same chipset or using the same IP core,
which cannot be described by board model or board-specific
handling in other places in the device tree?

I see a lot of clutter on my particular tree here; the USB
controller has 'ohci-bigendian, ohci-be, mpc5200-ohci,
mpc5200-usb' in it's compatible nodes. The model is mpc5200-ohci.

I would love to know why ohci-bigendian isn't just used. It
is perfectly obvious from the location of the node (it's
parent is /builtin or /soc, which has model 'mpc5200b').

The various names and compatibles I think are just information
for information's sake. Prepending mpc5200 to it is useless
information. The ONLY differentiation I see relevant here is
that the device is big-endian. Isn't that a standard property
though in most device trees, and not part of the device name?
I don't think you could put the information in there any other
way, but then again, if you are running an MPC5200B, how many
other ways can you configure the USB device? You can practically
assume big-endianess.

The same goes for the Ethernet (mpc5200b-fec, mpc5200-fec)
which is a ridiculous differentiation. It's parent node
as defined in the same device-tree bindings document
is ALWAYS going to be the 'soc' node, which has a model
which perfectly describes the SoC. Even THAT node has
compatible properties (mpc5200-soc, mpc5200b-soc) in
the documentation.

Again it is information for information's sake. A driver for
platform USB as implemented in Linux only needs one of them,
and none of the detailing on how much of it pertains to the
chip revision is required in-node.

The information in my device tree on my Efika here, then,
is being cluttered up with properties it doesn't even need
to expose for even the dumbest driver. And most of them
are in there to support the very dumbest drivers, over 3
or 4 revisions, and then been removed.

The device tree has become a dumping ground for decisions
made by Linux developers ("what shall I call this node?"
and changing their mind each time), and is no better for
driver support for it if you only track the mainline.

I2S is another one on this particular chip example;

~~
PSC in i2s mode:  The mpc5200 and mpc5200b PSCs are not compatible when in
i2s mode.  An 'mpc5200b-psc-i2s' node cannot include 'mpc5200-psc-i2s' in the
compatible field.
~~

All you need to know is that it's an i2s controller as defined
by the board designer. Secondary to that, you need to know
that it is a PSC I2S controller (the same distinction is true
of MPC52xx SPI). This is what your model attribute is for,
right? That you are running on an MPC5200 or MPC5200B is
defined by the SoC node already. To be extremely wary you
may have the SVR or revision property in the SoC node.

All I see is the dubious 'advantage' to make Linux probe
and device driver code wonderfully succinct - it only has
to look for one particular node from a list and then makes
some brilliant assumptions based on that. But if it is
differentiating between different compatibilities, names
and models, it will be doing a lot of if/elsing around
things, different setup and so on, by checking other
properties and other nodes. If you want to use any of
the devices on the chip, you NEED to ioremap the register
space, which entails accessing the parent SoC node.

So the advantage is lost; driver code isn't succinct,
and certainly having lists of devices which 'fit'
certain names is a wasteful concept. You trade off
20 lines of code to differentiate the chip with 20
lines of compatibility tables.

In fact, this kind of device naming and using compatibility
properties is practically discouraged by Ben's device
tree document (Section III, note 3)

>> It is quite another
>> matter to make it a kind of Linux-programmers errata
>> replacement framework and artificially recreate already
>> easily-accessible information.
> 
> No one is proposing that I hope.  This information indeed
> is already easily available in most cases -- namely, in
> the device tree.

And if it isn't, it is always accessible by the chip in
question anyway. Want the SVR of the SoC? Well, accessing
the SVR on the SoC is something any driver can do, the same
for any general purpose register, and even if the device
node is not in the tree.. it can still access it because
the registers are there.

WhileI think it would be cute to put it in the device tree,
it is far from an essential value. There may be a small
advantage in "faking" devices towards the OS in order to
encourage other behaviours or even for testing. Give a
device a different name and see if it will still try to
handle it. If you are concerned about the resiliance of
driver probing and setups, here is the way to do it.

The functionality of the device tree I think is summed up
at the bottom of Grant's 52xx bindings doc;

~~
Some SoC devices share registers between them.  ie. the i2c devices use
a single clock control register, and almost all device are affected by
the port_config register.  Devices which need to manipulate shared regs
should look to the parent SoC node.  The soc node is responsible
for arbitrating all shared register access.
~~

However that seems fairly naive a distinction. I prefer to
look at this from a pin muxing point of view; If it's not in
the device tree, the board designer probably either didn't
connect it up, or it's multiplexed with something else.

In the case of devices sharing registers, you cannot
arbitrate access sometimes in individual device nodes. But
if you know the board you know the mechanisms..

The other option is, the board designer was too lazy to add the
node, but if you can accurately determine the exact board
you're running on (this, I think, is very important to have
in the device tree).

So, when designing device trees, I think the documentation
sucks, and what was originally good about trees has gotten
lost by having drivers and DT's mutually track each other.
I don't think that spurs adoption of the format, I don't
think any of the major decisions on "how much info should
I put in the tree" are relevant. Where it is board
specific, you have already defined the board, you don't
need to redefine that the component is a part of the
board. You don't need to bring in strings and properties
where the operation is fixed or obvious, just so that
it can be "detected" in the device tree.

All in all I think the flat device tree is being abused,
and the effect is, that it is making dynamic device
trees no more useful either, in fact adding development
time for *real* firmware developers.

Like you said, that's just my opinion on it, but I have
seen too many people nag at Genesi/bplan for the quirks
in our device tree, and a lot of effort went into making
our device trees fit the expectations of Linux where it
was absolutely forced upon us by Linux driver writers.

Yes, we missed out the interrupt stuff in a couple of
places and made a mistake here or there, but they are
bugs. What I saw is a lot of effort being expended into
looking at device drivers past and present and trying
to interpret a complete lack of coherent documentation
into a device tree everyone likes, and enables existing
drivers out of the box, and then getting whined at for
it.. :D

When you look at the documentation, the recommended
practises, and 10 years of Open Firmware device tree
usage, and even the booting-without-of document, it
seems the direction of FDTs is being lost in the
scramble to add more and more and more functionality
to it, and going back to the original goal of the
device tree - it describes the system, but it mostly
exists to abstract devices for -drivers in the
firmware- and not in Linux. /soc/usb/storage/disk@0,0
was a block device handle far, far before it was
simply an advertisement of an attached disk..

--
Matt Sealey <matt@genesi-usa.com>
