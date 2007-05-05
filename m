Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 5F1DBDDECB
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  6 May 2007 08:16:28 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so669562ugf
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 05 May 2007 15:16:26 -0700 (PDT)
Message-ID: <528646bc0705051516h2b0259cfgbe3be784acf4086a@mail.gmail.com>
Date: Sat, 5 May 2007 16:16:26 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "David H. Lynch Jr." <dhlii@dlasys.net>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: virtex_devices.c
In-Reply-To: <463C379D.7020804@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <463C379D.7020804@dlasys.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/5/07, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
>    I am in the process of migrating my BSP code - which is loosely
> based on your earlier xilinx_mlxxx code to your newer code.
>    I am pulling your code from your virtex-dev branch of your git tree.
>
>
>    The first big obstacle I have encountered is the assumption that any
> early serial device will be an 8250.
>    When I altered your earlier code to deal with other early serial
> devices (my BSP supports both the UartLite and a pseudo serial device
> used when the Pico card is hosted called the Keyhole).
>
>     I made 2 significant changes:
>           I completely eliminated the use of plat_serial8250 in the
> platform data, and used uart_port as the structure for platform data.
>     It had everything I needed for 8250's and could be messaged for most
> anything else I had to deal with.
>     I explicitly set the type field in the structure so that I could use
> it do decide the approriate init routine to call.
>
>     I do not like this - as adding additional potential early serial
> devices means creating an ever increasing set of tests.
>     But it was better that only supporting the 8250.

I think I understand what you're describing, but I'd need to see your
code snippits to be sure.  Can you send me the relevant patches?

>     At some point if I get inspired I may take a wack at crafting
> generic approach using an early serial mini driver.
>
>     But for the moment my choices are:
>             add a few more 8250 specific #ifdefs to kill off most of the
> conflicting code in virtex_devices.c
>     and adapt my own code that is already in my BSP. This is the
> simplest and does the least damage to your code.

Considering the fact that the whole purpose of virtex_devices.c is to
massage the mess of #defines that is xparameters.h in to something
more parsable, then extra #if defined() test may not be a big deal.

However, I need clarification.  Are you talking about early serial
port support, console support or regular serial devices?  For example;
on one of my boards here I've got both 16550 and uartlite devices on
the same board and it works fine for serial port access.  I've also
got another design with only uartlite and another with only 16550.
Each of these scenarios should work with the code that is now in
mainline (but there are some issues still).

plat_serial8250_port is used because it is the structure used by the
platform bus to connect the 8250 driver to 8250 devices.  This is of
course specific to the 8250 driver.  The Uartlite ports are simple
enough that they don't need a *_platform_data structure; instead the
resources table in a virtex_platform_devices[] entry is sufficient to
describe the device to the platform bus.  You should be able to do the
same thing with your keyhole device registration.

Now, early serial is still a problem.  When using zImages, you must
make sure that only one of CONFIG_SERIAL_UARTLITE_CONSOLE and
CONFIG_SERIAL_8250_CONSOLE is set.  If they are both set, then it will
not compile.  (But this is just a zImage boot wrapper issue.  The
kernel proper should work fine).  Also, early serial in the kernel
proper is not implemented in driver which is in mainline, but console
and regular serial access is supported.

To add early serial support, I think virtex_early_serial_map() should
be reworked to scan the whole virtex_platform_devices table looking
for either "uartlite", "serial8250" or "keyhole" devices.

>              Or restructure your code in virtex_devices so that it uses
> uart_port as the pdata format and has support to
>     initialize devices other than the 8250. Which I think is the better
> way to go, but before I go stomping all over your
>     serial code I thought I was ask your thoughts ?

Go ahead, stomp away.  Worst that can happen is that I disagree.  :)
I certainly won't be offended.

>
>              Is there some compelling reason to use plat_serial8250 as
> the structure in which the port data is stored  as opposed to
>     something more generic ?

plat_serial8250 isn't supposed to be generic.  The generic bit is
supposed to be the virtex_platform_devices table.  BTW, my personal
opinion is that plat_serial8250 is poorly implemented because it maps
multiple 8250 devices to a single platform_device.  Instead, it should
be a 1-1 mapping (like all the other devices in the
virtex_platform_devices table).  ie. Don't try to describe all serial
devices, regardless of type, in a single platform_device record.

>              Do you have an objection to my making the changes needed to
> switch to the uart_port struct as the initialization data ?

It doesn't smell right; but I'm not sure I fully understand what
you're suggesting.  Show me patches.

>
>              Do you have any objection to my adding additional choices
> such as UartLite to the virtex_devices serial initialization ?

Absolutely not.  This is a good thing.

>     Do you have a different direction you would prefer to see things go
> - aside from moving to device trees and/or implimenting
>     a more generic early serial driver,  both of which I don't think I
> want to try at this instant ?

As I described above.

Now, all this being said; we do need to migrate to arch/powerpc
relatively soon.  If the changes are not too complex or if they ease
our migration to arch/powerpc, then I'm all for it.  If you're
undertaking a major development effort of stuff that's arch/ppc only;
then I recommend against it.  :-)

Oh, and I'd *really* like to see pico support hit mainline.  Easiest
way to do this is to break of chunks and tackle them one at a time
which is easier than trying to get the whole patchset in at once.
Keyhole driver sounds like a good place to start.

Cheers,
g.


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
