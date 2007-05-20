Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6FE64DDDF3
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 01:49:07 +1000 (EST)
In-Reply-To: <465060D8.9090304@genesi-usa.com>
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>	<FB8DD3C1-A095-4ABB-9E74-7EC66A43D983@kernel.crashing.org>	<464C800C.20400@freescale.com>	<FFBD3A3A-ADBE-4DC8-A1A1-4163367244D5@kernel.crashing.org>	<464C871C.4090300@freescale.com>	<5B363A90-5528-4441-BBF9-9C6D8833D938@kernel.crashing.org>	<20070518171555.543f9bdc@hyperion.delvare>	<D50C4D36-CEA5-4F7F-8A4C-CC747DF85865@kernel.crashing.org>	<464DD5E3.1060301@freescale.com>
	<6F8D3143-423D-45FA-9F40-00BF770831F2@kernel.crashing.org>
	<464E3F18.5010700@genesi-usa.com>
	<2087d135c4139e94e0b2c8826d808292@kernel.crashing.org>
	<464EFE96.3000801@genesi-usa.com>
	<94e1abed8781f279d2d4c7cddbc25ba2@kernel.crashing.org>
	<465060D8.9090304@genesi-usa.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Message-Id: <c829bacbfbea66b31629372cf6cc2c1b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
Date: Sun, 20 May 2007 17:48:42 +0200
To: Matt Sealey <matt@genesi-usa.com>
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

>>> I might be a little less noisy about it if there was
>>> some kind of edict for devices never to wander outside
>>> of their own node in the device tree, but there isn't.
>>
>> I'm not sure what you mean here.  It is best practice
>> for device nodes to be reasonably self-contained though.
>> Of course not completely; every node always has to refer
>> to its parent bus, etc.  Device drivers will sometimes
>> have to refer to board model for board-specific workarounds.
>
> Right. So, my question is, what is the difference between
> device A and B on the same chipset or using the same IP core,
> which cannot be described by board model or board-specific
> handling in other places in the device tree?

I still don't understand the question.

> I see a lot of clutter on my particular tree here; the USB
> controller has 'ohci-bigendian, ohci-be, mpc5200-ohci,
> mpc5200-usb' in it's compatible nodes. The model is mpc5200-ohci.
>
> I would love to know why ohci-bigendian isn't just used. It
> is perfectly obvious from the location of the node (it's
> parent is /builtin or /soc, which has model 'mpc5200b').

"fsl,mpc5200b-usb" is the exact name.  This one can be matched
against if the driver needs to do things specific to this
chip.

"fsl,mpc5200-usb" is one step below; it can be used by a driver
if that driver can drive every USB in the 5200 family.

"usb-ohci-bigendian" can be matched against by the USB OHCI
driver if there is no need for any 5200-specific quirks.

(And yes I know I changed some names here).

> The various names and compatibles I think are just information
> for information's sake.

Lots of people go overboard with them.  "compatible" is a very
important property though: it is the main thing that is used
to match OS device drivers with devices.

> Prepending mpc5200 to it is useless
> information.

Not at all.  If the 5200 needs any special treatment, this
is where the device driver (or some early quirk step, or
whatever) will see it has to deal with that.

> The ONLY differentiation I see relevant here is
> that the device is big-endian. Isn't that a standard property
> though in most device trees, and not part of the device name?

It isn't a standard property.  It would have been a better
way to go about this though, yes -- not put the "big-endian"
in the name, but in a separate property.

> I don't think you could put the information in there any other
> way, but then again, if you are running an MPC5200B, how many
> other ways can you configure the USB device? You can practically
> assume big-endianess.

But then you need to put chipset-specific information in the
kernel, where it isn't necessary at all.  There are quite
a few USB OHCs that are big-endian.

> The same goes for the Ethernet (mpc5200b-fec, mpc5200-fec)
> which is a ridiculous differentiation. It's parent node
> as defined in the same device-tree bindings document
> is ALWAYS going to be the 'soc' node, which has a model
> which perfectly describes the SoC. Even THAT node has
> compatible properties (mpc5200-soc, mpc5200b-soc) in
> the documentation.

You shouldn't have to look at any other nodes if all you're
trying to figure out is what one device is exactly.

> Again it is information for information's sake.

Not at all.  I'm sorry you don't see that.  It seems
you'd rather want one single node that says "5200" but
that's just not how the device tree is supposed to be
used.

> A driver for
> platform USB as implemented in Linux only needs one of them,
> and none of the detailing on how much of it pertains to the
> chip revision is required in-node.

Maybe the 5200b USB is actually *fully* compatible to the
5200 USB.  So you got lucky, and the device driver can
simply match on plain 5200 for both, since the 5200b device
trees state it is compatible to that, too.  Now OTOH if some
sneaky bug would show up that requires a workaround on 5200b
devices, you can match on that instead.

> The device tree has become a dumping ground for decisions
> made by Linux developers ("what shall I call this node?"
> and changing their mind each time), and is no better for
> driver support for it if you only track the mainline.

There are many bad device trees around yes.

> I2S is another one on this particular chip example;
>
> ~~
> PSC in i2s mode:  The mpc5200 and mpc5200b PSCs are not compatible=20
> when in
> i2s mode.  An 'mpc5200b-psc-i2s' node cannot include 'mpc5200-psc-i2s'=20=

> in the
> compatible field.
> ~~
>
> All you need to know is that it's an i2s controller as defined
> by the board designer. Secondary to that, you need to know
> that it is a PSC I2S controller (the same distinction is true
> of MPC52xx SPI). This is what your model attribute is for,
> right?

No, the "model" property is for defining the exact
"part number" (or similar) for the device.  I'll quote:

	Standard property name to define a manufacturer=92s model
	number.

	prop-encoded-array: Text string, encoded with encode-string.
	A manufacturer-dependent string that generally specifies the
	model name and number (including revision level) for this
	device. The format of the text string is arbitrary, although
	in conventional usage the string begins with the name of the
	device=92s manufacturer as with the =93name=94 property. =
Although
	there is no standard interpretation for the value of the
	=93model=94 property, a specific device driver might use it to
	learn, for instance, the revision level of its particular
	device.

> That you are running on an MPC5200 or MPC5200B is
> defined by the SoC node already.

Irrelevant, as I've said many times now.

> If you want to use any of
> the devices on the chip, you NEED to ioremap the register
> space, which entails accessing the parent SoC node.

But the probing routine doesn't have to; there are
helper functions for that.

> So the advantage is lost; driver code isn't succinct,
> and certainly having lists of devices which 'fit'
> certain names is a wasteful concept. You trade off
> 20 lines of code to differentiate the chip with 20
> lines of compatibility tables.
>
> In fact, this kind of device naming and using compatibility
> properties is practically discouraged by Ben's device
> tree document (Section III, note 3)

I think you just read it wrong.  Either way, you should
read the standard OF documentation as well, it would
certainly help you understand some of the concepts here.

>>> It is quite another
>>> matter to make it a kind of Linux-programmers errata
>>> replacement framework and artificially recreate already
>>> easily-accessible information.
>>
>> No one is proposing that I hope.  This information indeed
>> is already easily available in most cases -- namely, in
>> the device tree.
>
> And if it isn't, it is always accessible by the chip in
> question anyway. Want the SVR of the SoC? Well, accessing
> the SVR on the SoC is something any driver can do, the same
> for any general purpose register, and even if the device
> node is not in the tree.. it can still access it because
> the registers are there.

While you could do that for some SoC devices perhaps,
_iff_ you know for sure that no matter what those SVR
or whatever registers live at certain addresses when
all you really know is that you have one specific SoC
device, you cannot for most other devices.  Why would
you special case some SoC devices?  It is an encapsulation
violation no matter what.

> WhileI think it would be cute to put it in the device tree,
> it is far from an essential value.

Nothing is "essential", certainly you *can* boot a Linux
kernel without any device tree.  Duh.

> All in all I think the flat device tree is being abused,

Yes it is, but the things that you complain about aren't
the problem -- things that require implicit knowledge
(about Linux for example) are.

> Like you said, that's just my opinion on it, but I have
> seen too many people nag at Genesi/bplan for the quirks
> in our device tree, and a lot of effort went into making
> our device trees fit the expectations of Linux where it
> was absolutely forced upon us by Linux driver writers.

You could have avoided most of those problems by working
with us from the start.  Developing in a hidden corner
for months and then dropping all your code on us seldom
gives the results you hope for.  Anyway, let's not rehash
*that* discussion.

> What I saw is a lot of effort being expended into
> looking at device drivers past and present and trying
> to interpret a complete lack of coherent documentation

There is *plenty* very good documentation.  And you
can always ask.

> and going back to the original goal of the
> device tree - it describes the system, but it mostly
> exists to abstract devices for -drivers in the
> firmware- and not in Linux.

Rubbish.

> /soc/usb/storage/disk@0,0
> was a block device handle far, far before it was
> simply an advertisement of an attached disk..

It *always* is the second, and it *can* be the first.


Segher
