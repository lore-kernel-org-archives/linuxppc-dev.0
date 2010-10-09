Return-Path: <david.hagood@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) by ozlabs.org (Postfix) with ESMTP id 6D8AAB70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 10 Oct 2010 02:52:55 +1100 (EST)
Received: by yxs7 with SMTP id 7so780072yxs.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 09 Oct 2010 08:52:53 -0700 (PDT)
Message-ID: <adaf806ee1c11621dbb51246bef0acd8.squirrel@localhost>
In-Reply-To: <20101007152626.4e834d43@udp111988uds.am.freescale.net>
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>
	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>
	<20100921170700.53a99e56@udp111988uds.am.freescale.net>
	<fe4c3e4086132d746b79670f236302f1.squirrel@localhost>
	<20101007152626.4e834d43@udp111988uds.am.freescale.net>
Date: Sat, 9 Oct 2010 10:52:49 -0500
Subject: Re: Questions on interrupt vector assignment on MPC8641D
From: david.hagood@gmail.com
To: "Scott Wood" <scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: david.hagood@gmail.com,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

First of all - where is all of this documented? There seems to be a great
deal of "oral tradition" type knowledge here, but is any of it actually
written down somewhere? (see below for examples)

> On Thu, 7 Oct 2010 15:12:26 -0500
> This is asking for the 256th specifier in the interrupts property in
> the mpic node -- not what you want.

That was from some of the previous emails in this thread.

> Ideally you would have a node for your device with an interrupt
> specifier that you could look up with irq_of_parse_and_map().

OK, and how do these devices come into being? From what I can tell, they
are defined by uBoot, and if uBoot doesn't define it, then you are out of
luck.

But even assuming you can define these nodes at run time, as far as I can
see, you are right back to the question of "and how do I know what the
mappings are so I can create the node?" You haven't answered the question,
you've just moved where you are asking it.


> The vector/priority register (MSIVPR0) is at offset
> 0x51c00.  Each interrupt source is 32 bytes.  The first interrupt
> source is at 0x50000.
>
> So the interrupt number is (0x51c00 - 0x50000) / 32 = 224.

OK, so that's how you get the MPIC IRQ number. It's a pity that the key
piece of information - "MPIC IRQ Numbers are defined by the interrupt
vector table starting at 0x50000 and incrementing by 0x20 - see table 9.3
of the MPD8641D manual for details" wasn't spelled out anywhere I could
find.

Given the data I had: the kernel sources, the MPD8641D manual, and not
much else, I had three unknowns:
* a table of config registers, that could map an set of events into an
arbitrary vector number.
* The standard kernel "request_irq" API that takes that arbitrary vector
number
* A set of APIs (irq_of_parse_and_map(), irq_create_mapping) that were,
for all intents, undocumented (just "here's the parameters", no
description of when and how to use them), that took a ???? and returned a
???? (because, with the documentation I had, that's basically all I could
say about them).

There was no documentation that said how to compute the MPIC interrupt
vector, no documentation that said which API to use to convert that to an
kernel IRQ, nothing.

> BTW, the MSIs are already described in an msi node in the device tree.

As I stated previously - not that I can see. Neither does
/proc/device_tree contain such a listing, nor does doing a
"of_find_node_by_name(0,"msi");" nor "of_find_node_by_type(0,"msi");" find
them.

It may be they are defined in PCI Root Complex mode, but again - I am
writing code to handle Endpoint mode, which, as far as I can tell from the
kernel sources, is NOT handled in any standardized way.


Again, it would be nice were this sort of thing documented somewhere. If
it is, I'd love a link - I've tried every combination of search terms I
can think of to find it to no avail.

If it isn't documented, might I suggest that either a) creating a
dedicated "Programming PPC Embedded devices and their components under
Linux" be created, or b) an appropriate chapter or chapters be drafted and
submitted to the Linux Device Drivers book.


Don't take this message the wrong way - I do want to say "THANK YOU FOR
THE HELP!" - I am just trying to point out why somebody with a fair amount
of Linux kernel experience and a great deal of general embedded experience
is having great trouble doing a simple thing.

I'll try creating a mapping, binding to it, and seeing what happens.
