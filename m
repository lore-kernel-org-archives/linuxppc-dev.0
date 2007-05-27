Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 228ACDDEED
	for <linuxppc-dev@ozlabs.org>; Sun, 27 May 2007 19:47:45 +1000 (EST)
Message-ID: <465953D9.4030902@genesi-usa.com>
Date: Sun, 27 May 2007 10:48:09 +0100
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
	<465060D8.9090304@genesi-usa.com>
	<c829bacbfbea66b31629372cf6cc2c1b@kernel.crashing.org>
In-Reply-To: <c829bacbfbea66b31629372cf6cc2c1b@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Segher Boessenkool wrote:
>> Like you said, that's just my opinion on it, but I have
>> seen too many people nag at Genesi/bplan for the quirks
>> in our device tree, and a lot of effort went into making
>> our device trees fit the expectations of Linux where it
>> was absolutely forced upon us by Linux driver writers.
> 
> You could have avoided most of those problems by working
> with us from the start.  Developing in a hidden corner
> for months and then dropping all your code on us seldom
> gives the results you hope for.  Anyway, let's not rehash
> *that* discussion.

*Rubbish/Rehash*. When we started firmware development for
the Efika (ahem, mid-2005) there was NO mpc52xx device tree
specification.

Even if you do have a device tree specification I think it
has been somewhat tainted by it being written by the driver
developers, who are not so much hell-bent on writing a great
spec as hell-bent on making their code easier on the eyes
of the people who ACK it.

And lastly, the real crime here is that absolutely NO input
was attempted to be gained from the developers of the ONLY
open-firmware 5200B board on the planet, at the time. It
was just written, and pushed out there, and then it was
asked "why aren't bplan following our specification?!?!"

~

I really do not think it is a problem for a device to be
called "usb-ohci" in the device tree, with a property for
"big-endian". Or perhaps, "irda" with a compatible for
"psc-irda". Without the chip specifier. I also do not think
it is a problem for the device driver to look at the parent
bus node or soc node or platform node or builtin node or
whatever else, to find out more information about the driver.
Naming these nodes with long-winded device-inclusive names
in the first place is a difficult to understand shortcut
which provides no reasonable benefits.

Ostensibly, with an OCHI USB controller, they are all the
same anyway (it's a register definition, the only variable
points being where it starts and whether you use big endian
or little endian values), so why give it a special name?

If you have 6 chips which implement the same Freescale OHCI
controller but with varying levels of compliance, they are
still all OHCI controllers. And you can tell which OHCI
quirks you need to fix up in the driver, by.. looking at
the chip it's running on. The controller itself would never,
ever tell you how broken it is in real life. I don't
think encapsulation problems exist here. You want to support
a device but quirk out some specific chip revisions it's
built into, well, you need to find the device, then find out
the chip it's in, if in fact it's in a chip at all (if it's
not, then it could be a PCI device, in which case the
details of that are in the PCI config space, without a doubt.
Since most x86 chipset drivers do not look at device trees
they are implementing blacklists, id checks and tweaking
values to see the effects - isn't it code sharing to let
the ppc-compiled version of the same driver do the same
tests, rather than compile it out, add all new code to
determine it's capabilities from a device tree, which may
not have been written to fully determine the device quirks
of 10,000,000 PCI devices in the world possible of being
plugged into a PCI slot?). This is why I artificially limit
it to SoC's.

What is the effect if the device never changes over the
lifetime of the chip and you started calling it "mpc5200-usb"
to start with? Well, every device has to list "compatible"
for at least one chip which may well be very far removed,
I think that is an ugly solution in terms of the namespace.

If a device driver knows about certain chip revisions and
needs only to make small quirks and changes happen in the
device driver, naming it "mpc5200-usb" and "mpc5200b-usb"
and "mpc5121e-usb" and "mpc5900-usb" over and over makes
no benefit to the small modifications required.

As compared to, for instance, calling it "usb-ohci", giving
it a "big-endian" property, then looking at the parent
node, seeing if it's an "soc" node, looking at the model
property to check the chip revision or board revision, and
implementing the quirks, I don't see why this is any different
to the way you wanted to have it done in the first place. In
fact I think it's a more portable, more true-to-OF-specs
way of doing it.

And in fact, if there is no point whatsoever to implementing
the soc model property since all the child nodes need to be
encapsulated, why bother having it there? it's an optional
property in the specs.

If I had my way I'd be rewriting your device tree specs for
the MPC52xx now, but that would only burden the guys at
bplan writing the firmware to model new revisions against a
new device tree spec, which is a waste of time. We're stuck
with what you all jotted down one day, and expected all
device vendors to follow without nary a consultation, and
you yourself have admitted there, that some parts of it are
written and the authors seem to have gone a little overboard
on it. Now it is written, it is practically fixed, so what
do we do about it?

Is there some future process that can be determined which
stops brand new devices being released, reverse engineered
by Linux developers and then have the device vendors
hammered with a "linuxised" device tree they must then
certainly match for fear of derision, a device tree which
on a real and unbiased review, would probably be picked to
fault itself?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
