Message-ID: <40DCA1A3.6000401@mvista.com>
Date: Fri, 25 Jun 2004 15:05:23 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Cc: Dieu Morales <dieumorales@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Brian Waite <waite@skycomputers.com>
Subject: Re: GT64260_eth (Ethernet) Driver
References: <20040620202719.25741.qmail@web60407.mail.yahoo.com>	 <40DA06BE.204@mvista.com>	 <1088066228.18627.3352.camel@hades.cambridge.redhat.com>	 <40DB2199.2050006@mvista.com> <1088147437.4636.114.camel@imladris.demon.co.uk>
In-Reply-To: <1088147437.4636.114.camel@imladris.demon.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Woodhouse wrote:

>On Thu, 2004-06-24 at 11:46 -0700, Mark A. Greer wrote:
>
>
>>>Ooh look another one. What's in here that merits it having its own tree
>>>and prevents it from being accepted upstream?
>>>
>>>
>>>
>>It doesn't "merit" its own tree; it has its own tree because the code is
>>not yet ready to be passed upstream but others need to see the code.  If
>>you don't want to deal with the code in this tree, don't.  When it is
>>ready, and eventually [hopefully] accepted into the kernel.org tree,
>>this tree will disappear.
>>
>>
>
>Oh, I definitely want to deal with this tree :)
>
>Do you have a brief list of what still offends you about this rewritten
>code, such that you haven't sent it yet? Especially those parts which I
>could usefully address myself.
>
I don't have a good list but a couple things are a) I vaguely remember
thinking, "Ooh, I need to put 'this' in there for the 64360" but haven't
gone back thru the existing 360 code to see what that is; and b) I
change the .paddr field in the ocp to vaddrs, I need to undo that.
There are also a few hacks that I need to clean up but mostly, what I'm
hoping for are a) more eyeballs to critique the code, b) much more
testing of the code, c) ocp-ified drivers (i2c, 10/100 enet for 260,
10/100/1000 enet for >= 360 (maybe then can be combined?), and mpsc)
that are accepted by the respective gatekeepers for those types of drivers.

Would you mind looking at the code, giving me feedback ("this totally
sucks and needs to be thrown out" is perfectly valid) and looking for
things I may have missed?  There are a lot of registers and a lot of
bits & pieces to these things so its easy to miss something--or, maybe
you just don't like how I did it.  If you don't have major objections to
the core code, we need enet driver(s) and an i2c driver (there are
existing drivers for all of these already but they need to be ported or
possibly rewritten).

The main core code is in arch/ppc/syslib/mv64x60.c, mv64x60_ocp.c,
gt64260_pic.c, and mv64360_pic.c (untested).  I'm working on an mpsc
driver that fits under rmk's new serial infrastructure.  Its in
drivers/serial/mpsc/*.  I've made several changes to it since my last
push so I'll push again early next week when I have it working better.
An existing 64260 enet driver can be found in the linuxppc_2_4_devel
tree, an existing 64360 enet driver can be found in the
linuxppc_2_4_galileo tree (see below), and I've seen a i2c driver for
the 64360 (same ctlr as the 260, I *think*) that I can dig up.

>
>I note there are no platforms actually present which use the 64360.
>There's Artesyn Katana support in Kconfig but no actual platform support
>for that unless I'm being particularly dim today.
>
You note correctly.  I haven't tested any 64360 boards yet.  All of the
ones I have use the mpsc and I'm still shaking bugs out of that driver
so I can't test any them yet.  My first 64360 board to test will likely
be the Katana 750i.

>Is the 64360 support expected to work? Is there an older known-working
>tree for 64360? I'm looking at the Timesys 2.4 port for the Dy-4
>DMV-182, but that doesn't actually seem to boot on my DMV-182 so I lack
>confidence in the wisdom of using that as any form of reference ;)
>
Yes, there is code that Rabeeh Khoury from Marvell wrote and put into
[yet] another tree, bk://source.mvista.com/linuxppc_2_4_galileo.  Yes, I
know, yet another tree.  Basically, I was asleep at the switch and
didn't have that tree locked down before the code was pushed into
there.  That tree still exists because it has the 64360 code and it has
work Troy B. did for the Motorola MVP platform but I haven't heard
anything about that for a good 2 year so...

Once everyone is happy with the code and we've done some serious
testing, we can push the core code in and the drivers can go in as they
become available.  After that, we can finally get rid of these other 2
trees and never see them again.  Sound like a plan?

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
