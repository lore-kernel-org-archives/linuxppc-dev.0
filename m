Date: Wed, 10 Apr 2002 08:16:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Message-ID: <20020410151654.GC26754@opus.bloom.county>
References: <20020409145929.GC710@opus.bloom.county> <0204091952.AA24042@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0204091952.AA24042@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 09, 2002 at 12:52:40PM -0700, Michael Sokolov wrote:
>
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > Most of the code is actually rather
> > clean.  The Sandpoint is actally a good candidate for some sort of run-time
> > checks since it's a development board and the X2/X3 (and X3b) do differ in
> > some ways.  I actually think the Spruce thing is a red-herring, but maybe the
> > Spurce Paul/David Gibson have is different than the one mporter has access to.
>
> But the point is that these two ports as they are right now aren't suitable for
> CONFIG_GENERIC_PPC32 because of #ifdefs in them. An #ifdef-ectomy would mean
> splitting the Sandpoint port into two ports, X2 and X3 with different _machine
> codes, selected at run time.



> I don't know what to do for the Spruce. Does that
> board have a spec saying what the baud clock is supposed to be? If there is,
> assume the value from the spec and fix the boards that don't meet the spec. If
> there is no right value and both values are equally legit, that's a screwed-up
> board that standard OSes like Debian Linux/PPC don't need to support, so don't
> bother putting it in the generic kernel.

Again, I think the Spruce thing is a red herring since I think it's only
the Spruce that David Gibson has which needs or needed a different
speed.  I suspect I'll end up looking in the archives and settling this
once and for all before Spruce moves up to linuxppc_2_4.

> > > I think the way I've handled serial in CONFIG_GENERIC_PPC32 is neat and the
> > > RTTD.
> >
> > This works great if you let the firmware deal with the serial port.  I
> > need to play abit more with it I suspect, but using early_serial_setup()
> > becomes less than ideal, w/o some trickery anyhow, ifyou have to use
> > arch/ppc/boot/common/ns16550.c
>
> Ahh, the arch/ppc/boot morass is a fly in the ointment again...

Not quite.  DINK32/PPCBug/PMON/Force firmware (pcore?)/other commerical
firmwares which know 0 about Linux and won't ever quite probably is the
'fly in the ointment'.

> Well, you know
> my solution: remove the fly. When you have just vmlinux, early_serial_setup()
> is the ideal solution as that's precisely what it's designed for. It's doing
> things the right way, the way they were meant to be done.

Except when you compile serial as a module like Paul pointed out.  Maybe
this will be better in 2.5 tho w/ the new serial driver Russel King has
(http://www.arm.linux.org.uk/cvs/).

> You were just talking about making make zImage spit out a pile of zImages for
> different boards by compiling the wrapper many times in different
> configurations. Just instantiate the wrapper's ns16550 driver per board.

That's what we do now, and would do, with the 'current' <asm/serial.h>
which gets the right file for the right board, in a 1-board config.  It
also 'just works' when the ports are at the legacy location, from what I
recall.  (or legacy + 0x00800000 or something).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
