Date: Sat, 16 Mar 02 23:03:13 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203170703.AA00587@ivan.Harhan.ORG>
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] My GT-64260 enhancements
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> wrote:

> I'd be willing to bet $5 it's from Troy.

OK...

> IMHO, 9600 is the defacto
> default rate,

YES!!!

> but Troy likes 'fast' serial consoles.

But Troy's personal preferences shouldn't affect the public tree, should they?
If 9600 is the default baud rate for all of Linux, why should one port be
different? Who is the maintainer with authority over this? Would s/he accept a
patch to axe that 115200 line out?

> Right, And boards other than the EV-64260-BP use the zImage wrapper,
> like the Motorola MVP.
>
> [...]
>
> I'm saying that if nothing else the comment is wrong or slightly
> misleading, as it's not 'just' for the EV-64260-BP, it's for the
> Motorola MVP as well, and possibly other boards in the future which have
> to use !(StarMON || PPCBoot).

But right now there is no MVP in 2_4_devel, so for 2_4_devel as it is right now
it's for EV-64260-BP only. If/then someone adds another port that needs the
same ugly hack in the zImage wrapper, they can add -o "$CONFIG_MYBOARD" = "y"
to it. But it still won't be for all GT-64260 boards, like it won't be for my
StarMON-only boards.

> Well, (and I do need to check out the _galileo tree) iirc the stuff to
> support that option is in one of the generic files.  Or generic to the
> work currently in there.  If that's the case, and you're explicitly not
> going to support it in your files (and ports) then add a -a
> "$CONFIG_xxx" = "n" .

You still don't get it. I find that logic offensive. It makes me not want to
use the GT-64260 in my designs because your logic implies that if someone uses
the GT-64260 s/he wants to do things your way. Just because there is a generic
file doesn't mean I'm obligated to use it in my ports. I can build a board with
a GT-64260A in an epoxy-filled tamper-resistant module where StarMON sets up
the system environment and the Linux port looks just like the Adirondack one.
You'll never be able to tell that there even is a GT-64260 in that system!

Think of StarMON like OF. That's a good model, as StarMON is indeed a real
competitor to OF. Just like on OF machines the device tree tells you where
system features are located and you don't really know or care what chips
implement these features and what magic the firmware had to do to make it all
work, so with StarMON. You have so much memory, a PCI bus here, a UART there,
etc., and you don't really need to know whether it's a CPC710 or a GT-64260.

I want to design my ports like this: OK, here is my hardware feature set, let's
write the files telling Linux how to make use of it. You are forcing me to
think differently: OK, here are the chips on my board, let's see what generic
files they have for them. But I don't want to do my ports your way, and I find
it offensive that the GT-64260 code you have in the tree now essentially forces
me how to think.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
