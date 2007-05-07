Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 753AEDDE43
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 May 2007 10:46:51 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so768530ugf
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 06 May 2007 17:46:49 -0700 (PDT)
Message-ID: <528646bc0705061746s28ebb15et428c7afda2f477ba@mail.gmail.com>
Date: Sun, 6 May 2007 18:46:49 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: virtex_devices.c
In-Reply-To: <463E4B13.2030600@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <463C379D.7020804@dlasys.net>
	<528646bc0705051516h2b0259cfgbe3be784acf4086a@mail.gmail.com>
	<463E4B13.2030600@dlasys.net>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/6/07, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
> >>     At some point if I get inspired I may take a wack at crafting
> >> generic approach using an early serial mini driver.
> >>
> >>     But for the moment my choices are:
> >>             add a few more 8250 specific #ifdefs to kill off most of
> >> the
> >> conflicting code in virtex_devices.c
> >>     and adapt my own code that is already in my BSP. This is the
> >> simplest and does the least damage to your code.
>
> > Considering the fact that the whole purpose of virtex_devices.c is to
> > massage the mess of #defines that is xparameters.h in to something
> > more parsable, then extra #if defined() test may not be a big deal.
>     This is not just about virtex_devices. Supporting early Output on
> something other than an 8250
>     requires #ifdef's all over creation.
>     This is just screaming for a more generic solution. But that needs
> to happen without
>     much increase in complexity

Okay if I understand you correctly, you're talking about two areas:
1. setting up output in the zImage wrapper (which is easy), and
2. Stuff turned on by CONFIG_SERIAL_TEXT_DEBUG which does seem to be a
mess of #ifdefs.

Uartlite s already supported in the zImage wrapper, and keyhole
support should be easy to add.  As far as CONFIG_SERIAL_TEXT_DEBUG
support; it's probably a case of do whatever you need to make it work;
but don't get too worked up about getting it into mainline.  It's all
pretty arch/ppc specific at the moment, and if you want to work on a
generic solution then you should probably wait until arch/powerpc is
working.

> > However, I need clarification.  Are you talking about early serial
> > port support, console support or regular serial devices?
>     While I am specifically dealing with one area. More broadly I am
> talking about
>     all Output prior to the real serial driver coming up.
>     This seems to  be the pre-linux stuff in
>     arch/ppc/boot/simple. You just added a uartlite_tty.c there. I have
> had one for a long time.
>     but that is pretty trivial.
>     and the slightly more complex
>     arch/ppc/syslib/uartlite_dbg that is used by the progress stuff and
> for a bit prior to the early serial
>     driver code.
>     I do not think you have code for this - but I do.

No, I've not tackled this, and I haven't looked at your code.

>     These bits are only critical when something early goes completely to
> crap.
>     But then they are important.
>
> > For example;
> > on one of my boards here I've got both 16550 and uartlite devices on
> > the same board and it works fine for serial port access.  I've also
> > got another design with only uartlite and another with only 16550.
> > Each of these scenarios should work with the code that is now in
> > mainline (but there are some issues still).
>     This is also relevant to me because I have another pseudo serial
> device that I support in exactly the same way as UartLite. It is unique
> enough to our hardware that it is likely of little interest to anyone else.
> But it means everytime I look at a UartLite

Bullshit.  :-)  The pico is a commercially available board; support
for it should be in mainline.  Besides, support in mainline should
make it easier for Pico to sell boards.  :-)

>     issue, I am looking at a "keyhole" issue too.  It means that everywhere
> there is an 8250 specific solution to a problem, I end up with a 3 way fork.
> While support for early non-8250's is lite - there are others besides the
> uartlite and my keyhole.

Right; I agree this should be fixed.  However keep in mind that if you
work on it in arch/ppc; you'll probably just end up redoing all your
work again in arch/powerpc.

> > plat_serial8250_port is used because it is the structure used by the
> > platform bus to connect the 8250 driver to 8250 devices.  This is of
> > course specific to the 8250 driver.  The Uartlite ports are simple
> > enough that they don't need a *_platform_data structure; instead the
> > resources table in a virtex_platform_devices[] entry is sufficient to
> > describe the device to the platform bus.  You should be able to do the
> > same thing with your keyhole device registration.
>     By substituting uart_port for plat_serial8250 I end up with something generic.
>     I do not understand the rational behind the plat_serialxxxx structs.
>     It is not like u-boot or something else passes them, they seem to be
> entirely a kernel
>     creation, they contain no information that is not in uart_port which
> is generic for
>     anything that pretends to be a serial device, and using the
> plat_serial8250 means
>     individually copying values from that struct to a uart_port.
>     By just substitution uart_port for plat_serial8250 I end up with
> code that is
>     exactly the same for anything that looks like a serial device.

plat_serial8250 isn't supposed to be generic.  You shouldn't use it as
such.  It is supposed to be the driver specific data for the driver's
platform device binding.  I may not like the approach of
plat_serial8250, but it at the correct level, and therefore isolated.
The 8250 platform bus binding is the only user of that data.

The generic bit is the platform_device structure.  the
virtex_platform_devices[] table is supposed to contain one entry per
device.  (8250 is an abomination in this regard; it uses 1
platform_device entry to represent all 8250 serial ports).  The
generic early serial code should *not* be looking to the
virtex_serial_platform_data[] table to find ports.  It should be
parsing the virtex_platform_devices[] table.

It is done this way because the platform bus infrastructure takes care
of binding platform_device records to platform bus device drivers.  No
extra code required.

> > Now, early serial is still a problem.  When using zImages, you must
> > To add early serial support, I think virtex_early_serial_map() should
> > be reworked to scan the whole virtex_platform_devices table looking
> > for either "uartlite", "serial8250" or "keyhole" devices.
>
>     That is basically what I am doing.
>        The UART macro(s) in xparameters, are changed to use uart_port
> element names.
>        All serial/pseudo serial devices are setup uniformly the same.
>        Serial devices are distinguishable in the uart_port struct by
> their .type field,
>        In the rare instances I need to distinguish there are if's or
> switches on the .type field.

Yes, but then you need to write new code to pass each port off to the
correct driver; completely ignoring the platform bus code which *does
the exact same thing*.

> > It doesn't smell right; but I'm not sure I fully understand what
> > you're suggesting.  Show me patches.
>
>     The basic fundimental question is why is there an 8250 specific
> structure,
>     when there is a perfectly good generic structure that already exists ?
>     Actually it seems to be even more complex than that because I think
> there is actually an
>     old_serial structure that is also used in places.

I ask the opposite question; why try to make the 8250 structure
generic when there is already a generic structure that does exactly
what you want one level up?

I *do* think that 8250 should be changed; but not in the way you're describing.

>
>     This is not really a virtex or ppc question and probably belongs on
> linux-serial,
>     but the gist is uart_port is what the majority if not all serial
> devices end up using.

Right; but we're not talking about the internal use of uart_port by
the drivers.  We're talking about the
>     instead of starting with something else and then having incongruent
> field names
>    lots fo device specific code and/or #ifdef's,
>     if we just use uart_port instead of plat_serialxxx's for every device,
>     then all code gets simpler as does adding additional devices.
>     Shortly I hope. I have code, it is just not working at this minute.
>     Actually I suspect it is working, but my overall migration from my
>     implimentation of your earlier code to my implimentation of your newer
>     code is not yet working.

I look forward to seeing it.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
