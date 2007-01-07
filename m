Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6F862DDDFC
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jan 2007 07:09:08 +1100 (EST)
Message-ID: <45A1535C.1080007@genesi-usa.com>
Date: Sun, 07 Jan 2007 20:09:00 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Probe Efika platform before CHRP.
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
In-Reply-To: <528646bc0701061423o270df3dfj9d27d5572840ec79@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


Grant Likely wrote:
> On 1/6/07, Matt Sealey <matt@genesi-usa.com> wrote:
>>
>> One basic problem is we're talking about changing Efika to adapt to the
>> definitions, whims and determinations of the *Linux* community.
> 
> As opposed to the Linux community being asked to adapt to the
> definitions, whims and determinations of a single corporate entity?
> :-)
> 
>>
>> What if NetBSD, FreeBSD, QNX and WindRiver disagree with you guys?
> 
> I'm pretty sure that Linux is the only OS which is requiring a device
> tree for booting for new ports

NetBSD, FreeBSD will support the device tree for enumeration and the
ports in progress already do, and they also keep the Client Interface
open so they have a much better environment to work from than the
Linux "cache" of the device tree. If the OF device is there and there
is no driver in the OS, at least somehow (slowly) it could be used.

> Efika is the only 52xx board with open firmware on it.

Yes you're right.

At least from my point of view (I don't speak for Nico or Gerald here),
here is my discussion on the subject.

#1: As the only Open Firmware platform on this chip, what *we* do matters
here, we DO have to offer some stability in operating system support
and that means once we fix a device tree it needs to stay fairly similar,
which is exactly why we feel justified defining the tree standard for it :D

We do have to work with a lot more operating systems and vendors than
just Linux, and a "booting without Open Firmware" standard which proves
to solve the lack of device tree in U-Boot and other firmwares by making
more work for firmware and Linux kernel porting harder, is not really
something we are too concerned about. We hope we offer something a little
better than "recompile your device tree file, embed it into the kernel,
hope UBoot is the correct version, or recompile it, and flash and hope for
the best". What we offer here is fairly unique; both in that we seem to be
the only guys offering Open Firmware (especially a C-based one, OpenBIOS
is 90% Forth which is a terrible lock-in), and on the MPC5200 (or PowerPC
in general).

We also recognise OF and the device tree is flawed in some areas, RTAS
isn't the best thing in the world (but it is totally misused in Linux,
in places) so we are not BLIND to the need for change, we just think a
few compatibility names and node device_type changes are not really where
the real problems are.

#2: Personally I think naming device compatibility after the chip they are in
is a ridiculous lock-in, also. You may end up with a device_type of
ethernet, and compatibility flags for 100 SoC chip numbers. This is
fairly stupid.

Isn't the e300 PVR and e300 SVR, or any other device identifier on the
chip, a much better differentiator for drivers, than a named compatibility
flag? These are present in the device tree (/cpu node?) no? I can't boot
mine currently I blew up my power supply unfortunately.

I happen to know the next Freescale device won't be called 52xx so we're
talking about adding another compatibility naming to it like 51xx or 55xx
or 5xxx and changing everyone's firmware and Linux device trees again.

Or you could switch based on the processor! Cleaner, simpler, and doesn't
need each device to have a specially unique name, only a vague "class"
without some specific model number in it. If it's an SoC.. this is what
the SVR is for!

#3: While the above is basically a case for an SoC node (device parent
would have the SVR in it), this does not scale generically or flexibly
to non-SoC platforms where devices are nevertheless highly integrated.

AMD's new processors with integrated CPU and memory controller, will not
be classed as SoC's - how would you class them, really? Just a CPU with
some devices builtin (aha!) I would say. With the Pegasos, we have the
CPU, and the Marvell chip has Ethernet (not on PCI) and SRAM (also just
mapped in as memory) but it is not an SoC.

We just don't want to clutter up the root node with devices, otherwise
it would basically be more of a device shrubbery. The e300 SVR is also
defined in the manual (as is the e500 equivalent, and e200 equivalent)
as a CPU core feature, not a SoC-device feature, so this kind of
differentiation and numbering belongs in the CPU node.

~

Those are MY problems with the device tree specification you have with
"Booting Without Open Firmware". I am sure the other guys have other
things to say.

As for real bugs in the firmware; we definitely have 3 or 4 I have
noticed, be it the serial port not being changable baud rate from
the firmware itself (" /builtin/serial:38400" io doesn't set the
baud rate), AC97 is not configured (Sylvain hacked it though) even
though we have a node that specifies it, disk numbering is DEFINITELY
off (some facepalms going on at the office I think) even though we
definitely already have a fix for it, among a lot of other niggly
little things like the IrDA port (not set up, but I really think
PSC6 should be configurable from a firmware variable because it is
very multipurpose)

I would expect that it is so much easier, even if it does not strike
you as too "clean", to forget about naming compatibility nodes here,
and concentrate on the real showstoppers. I would consider the AC97
PSC not being set up, the IrDA PSC not being set up, the disk
numbering and any problems we're having with USB devices (argh) to
be real showstoppers.

We are working on a new firmware which will provide a lot of new
functionality in the coming month or two. I am not sure anything that
is merely based on principles or cleanliness of Linux code, to be changed.
I know it's not nice to look at your own code and see a bunch of hacks
for some hardware in there, but Linux and other OS are littered with these
already, you cannot avoid a bug or two, or a discrepency in something
else, and considering there are more important things in the design,
and in life in general, maybe it is best just to use what you've got
to work with (which is, unfortunately, what we gave you on the initial
board..)?


-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
