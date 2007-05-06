Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E71A2DDE2D
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 May 2007 07:41:13 +1000 (EST)
Message-ID: <463E4B13.2030600@dlasys.net>
Date: Sun, 06 May 2007 17:39:31 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: virtex_devices.c
References: <463C379D.7020804@dlasys.net>
	<528646bc0705051516h2b0259cfgbe3be784acf4086a@mail.gmail.com>
In-Reply-To: <528646bc0705051516h2b0259cfgbe3be784acf4086a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Grant Likely wrote:
>
> I think I understand what you're describing, but I'd need to see your
> code snippits to be sure.  Can you send me the relevant patches?
>
    As soon as I have something working I will post it.

>>     At some point if I get inspired I may take a wack at crafting
>> generic approach using an early serial mini driver.
>>
>>     But for the moment my choices are:
>>             add a few more 8250 specific #ifdefs to kill off most of
>> the 
>> conflicting code in virtex_devices.c 
>>     and adapt my own code that is already in my BSP. This is the
>> simplest and does the least damage to your code.
 
> Considering the fact that the whole purpose of virtex_devices.c is to
> massage the mess of #defines that is xparameters.h in to something
> more parsable, then extra #if defined() test may not be a big deal.
    This is not just about virtex_devices. Supporting early Output on
something other than an 8250
    requires #ifdef's all over creation.
    This is just screaming for a more generic solution. But that needs
to happen without
    much increase in complexity



>
> However, I need clarification.  Are you talking about early serial
> port support, console support or regular serial devices?
    While I am specifically dealing with one area. More broadly I am
talking about
    all Output prior to the real serial driver coming up.
    This seems to  be the pre-linux stuff in
    arch/ppc/boot/simple. You just added a uartlite_tty.c there. I have
had one for a long time.
    but that is pretty trivial.
    and the slightly more complex
    arch/ppc/syslib/uartlite_dbg that is used by the progress stuff and
for a bit prior to the early serial
    driver code.
    I do not think you have code for this - but I do.

    These bits are only critical when something early goes completely to
crap.
    But then they are important.
  
> For example;
> on one of my boards here I've got both 16550 and uartlite devices on
> the same board and it works fine for serial port access.  I've also
> got another design with only uartlite and another with only 16550.
> Each of these scenarios should work with the code that is now in
> mainline (but there are some issues still).
    This is also relevant to me because I have another pseudo serial
device that I support
    in exactly the same way as UartLite. It is unique enough to our
hardware that
    it is likely of little interest to anyone else. But it means
everytime I look at a UartLite
    issue, I am looking at a "keyhole" issue too.
    It means that everywhere there is an 8250 specific solution to a
problem,
    I end up with a 3 way fork.
    While support for early non-8250's is lite - there are others
besides the uartlite and my keyhole.

    I rarely use JTAG and other hardware debugging tools. It is critical
for me to be able to
    output information at most every part of the kernel load process.
   
>
> plat_serial8250_port is used because it is the structure used by the
> platform bus to connect the 8250 driver to 8250 devices.  This is of
> course specific to the 8250 driver.  The Uartlite ports are simple
> enough that they don't need a *_platform_data structure; instead the
> resources table in a virtex_platform_devices[] entry is sufficient to
> describe the device to the platform bus.  You should be able to do the
> same thing with your keyhole device registration.
    By substituting uart_port for plat_serial8250 I end up with
something generic.
    I do not understand the rational behind the plat_serialxxxx structs.
    It is not like u-boot or something else passes them, they seem to be
entirely a kernel
    creation, they contain no information that is not in uart_port which
is generic for
    anything that pretends to be a serial device, and using the
plat_serial8250 means
    individually copying values from that struct to a uart_port.
    By just substitution uart_port for plat_serial8250 I end up with
code that is
    exactly the same for anything that looks like a serial device.

   

>
> Now, early serial is still a problem.  When using zImages, you must
> make sure that only one of CONFIG_SERIAL_UARTLITE_CONSOLE and
> CONFIG_SERIAL_8250_CONSOLE is set.  If they are both set, then it will
> not compile.  (But this is just a zImage boot wrapper issue.  The
> kernel proper should work fine).  Also, early serial in the kernel
> proper is not implemented in driver which is in mainline, but console
> and regular serial access is supported.
>
> To add early serial support, I think virtex_early_serial_map() should
> be reworked to scan the whole virtex_platform_devices table looking
> for either "uartlite", "serial8250" or "keyhole" devices.
    That is basically what I am doing.
       The UART macro(s) in xparameters, are changed to use uart_port
element names.
       All serial/pseudo serial devices are setup uniformly the same.
       Serial devices are distinguishable in the uart_port struct by
their .type field,
       In the rare instances I need to distinguish there are if's or
switches on the .type field.


>
> Go ahead, stomp away.  Worst that can happen is that I disagree.  :)
> I certainly won't be offended.
>
>>
>>              Is there some compelling reason to use plat_serial8250 as
>> the structure in which the port data is stored  as opposed to
>>     something more generic ?
>
> plat_serial8250 isn't supposed to be generic.  The generic bit is
> supposed to be the virtex_platform_devices table.  BTW, my personal
> opinion is that plat_serial8250 is poorly implemented because it maps
> multiple 8250 devices to a single platform_device.  Instead, it should
> be a 1-1 mapping (like all the other devices in the
> virtex_platform_devices table).  ie. Don't try to describe all serial
> devices, regardless of type, in a single platform_device record.
>
>>              Do you have an objection to my making the changes needed to
>> switch to the uart_port struct as the initialization data ?
>
> It doesn't smell right; but I'm not sure I fully understand what
> you're suggesting.  Show me patches.
    The basic fundimental question is why is there an 8250 specific
structure,
    when there is a perfectly good generic structure that already exists ?
    Actually it seems to be even more complex than that because I think
there is actually an
    old_serial structure that is also used in places.

    This is not really a virtex or ppc question and probably belongs on
linux-serial,
    but the gist is uart_port is what the majority if not all serial
devices end up using.
    instead of starting with something else and then having incongruent
field names
   lots fo device specific code and/or #ifdef's,
    if we just use uart_port instead of plat_serialxxx's for every device,
    then all code gets simpler as does adding additional devices.
   

    Shortly I hope. I have code, it is just not working at this minute.
    Actually I suspect it is working, but my overall migration from my
    implimentation of your earlier code to my implimentation of your newer
    code is not yet working.

>
>>
>>              Do you have any objection to my adding additional choices
>> such as UartLite to the virtex_devices serial initialization ?
>
> Absolutely not.  This is a good thing.
>
>>     Do you have a different direction you would prefer to see things go
>> - aside from moving to device trees and/or implimenting
>>     a more generic early serial driver,  both of which I don't think I
>> want to try at this instant ?
>
> As I described above.
>
> Now, all this being said; we do need to migrate to arch/powerpc
> relatively soon.  If the changes are not too complex or if they ease
> our migration to arch/powerpc, then I'm all for it.  If you're
> undertaking a major development effort of stuff that's arch/ppc only;
> then I recommend against it.  :-)
>
> Oh, and I'd *really* like to see pico support hit mainline.  Easiest
> way to do this is to break of chunks and tackle them one at a time
> which is easier than trying to get the whole patchset in at once.
> Keyhole driver sounds like a good place to start.
>
> Cheers,
> g.
>
>


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
