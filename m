Date: Tue, 9 Apr 02 12:52:40 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204091952.AA24042@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> wrote:

> Most of the code is actually rather
> clean.  The Sandpoint is actally a good candidate for some sort of run-time
> checks since it's a development board and the X2/X3 (and X3b) do differ in
> some ways.  I actually think the Spruce thing is a red-herring, but maybe the
> Spurce Paul/David Gibson have is different than the one mporter has access to.

But the point is that these two ports as they are right now aren't suitable for
CONFIG_GENERIC_PPC32 because of #ifdefs in them. An #ifdef-ectomy would mean
splitting the Sandpoint port into two ports, X2 and X3 with different _machine
codes, selected at run time. I don't know what to do for the Spruce. Does that
board have a spec saying what the baud clock is supposed to be? If there is,
assume the value from the spec and fix the boards that don't meet the spec. If
there is no right value and both values are equally legit, that's a screwed-up
board that standard OSes like Debian Linux/PPC don't need to support, so don't
bother putting it in the generic kernel.

> > I think the way I've handled serial in CONFIG_GENERIC_PPC32 is neat and the
> > RTTD.
>
> This works great if you let the firmware deal with the serial port.  I
> need to play abit more with it I suspect, but using early_serial_setup()
> becomes less than ideal, w/o some trickery anyhow, ifyou have to use
> arch/ppc/boot/common/ns16550.c

Ahh, the arch/ppc/boot morass is a fly in the ointment again... Well, you know
my solution: remove the fly. When you have just vmlinux, early_serial_setup()
is the ideal solution as that's precisely what it's designed for. It's doing
things the right way, the way they were meant to be done.

You were just talking about making make zImage spit out a pile of zImages for
different boards by compiling the wrapper many times in different
configurations. Just instantiate the wrapper's ns16550 driver per board.

> > I don't see it as ugly, I think it's quite beautiful.
>
> Adding an #ifdef per board?

Yes. It's a lot more beautiful than getting link errors about platform_init
multiply defined or <x>_init undefined.

> So you're more one of those hardware people inflicting really wierd
> designs on us software people, aren't you? :)

Actually I've been very outspoken about strictly following standards and not
making frivolous designs some others are fond of. Also since I intend to run
standard OSes on any hardware I design and I'm the one writing that OS support,
I plan for that in advance in the hardware design stage.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
