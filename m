Date: Tue, 9 Apr 2002 07:59:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Message-ID: <20020409145929.GC710@opus.bloom.county>
References: <20020408154808.GH2716@opus.bloom.county> <0204081818.AA21305@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0204081818.AA21305@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 08, 2002 at 11:18:43AM -0700, Michael Sokolov wrote:
>
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > > The platforms I've initially included in this new model are Adirondack,
> > > EV-64260A, and K2.
> >
> > Just checking, but right now these are only supported with StarMON and
> > not necessarily their shipping ROMs, right? :)
[snip]
> The issue of "shipping ROMs" for the EV-64260A is moot I think.

Yeah.

> > I'm sure it's unintentional, but it looks more like it'd be changing
> > platform_init to x_init,
>
> I'm not sure what you mean by unintentional, it's necessary to change

I ment the '#ifdef-ectomy' comment.  Most of the code is actually rather
clean.  The Sandpoint is actally a good candidate for some sort of run-time
checks since it's a development board and the X2/X3 (and X3b) do differ in
some ways.  I actually think the Spruce thing is a red-herring, but maybe the
Spurce Paul/David Gibson have is different than the one mporter has access to.


> > and serial fixes rather than changing #ifdefs.
>
> I think the way I've handled serial in CONFIG_GENERIC_PPC32 is neat and the
> RTTD.

This works great if you let the firmware deal with the serial port.  I
need to play abit more with it I suspect, but using early_serial_setup()
becomes less than ideal, w/o some trickery anyhow, ifyou have to use
arch/ppc/boot/common/ns16550.c

> > Aside from some ugliness added back to the code (see my other email).
>
> I don't see it as ugly, I think it's quite beautiful.

Adding an #ifdef per board?

> > One other problem is that in case anyone forgot, back when we used to
> > always define a new _MACH type, we had actually ran out (or got w/in 3
> > or so) so we might want to think of changing the values in 2.5 to
> > something that can scale better, if we're going to do this.
>
> Perhaps you've missed my comment in processor.h:

Yeap.

> > If you didn't have the option of replacing a firmware, I'd bet you'd end
> > up using it too :)
>
> Ahmm, when you are making a new board there is no firmware to replace,
> you have to write it!

If you don't have the option to replace an existing firmware...  but
anyways.

> > But anyhow, it's actually not incompatible with this.  I've gone and
> > looked at this abit, and it'd be a matter of re-writing the Makefile a
> > bit (obj-$(...) and XXX_OBJS -> platform.o, rm -f'ed after each zImage,
> > and then a -DMACH_TYPE=_MACH_xxx for one of the files..).
>
> Are you saying you are going to make some kind of loop in
> arch/ppc/boot/simple/Makefile that would spit out 20 zImages on one
> make zImage for CONFIG_GENERIC_PPC32? Fine with me if you want to do that.

Well it'd be no worse than the loop we have right now to spit out
zImages.

> > > This will be
> > > an encouragement to board makers to use standardized firmware like OF,
> > > StarMON, or PPCBoot rather than roll a board-unique one: use something
> > > standard and you can use one of existing zImages, or roll your own and
> > > be prepared to convince people to accept adding yet another zImage.
> >
> > Or use a firmware which can load an ELF image (pmon, yes?) or fake it
>
> But this way you still have to add a new zImage for each new board, even if
> only to carry the knowledge of which board it is. With standardized firmware
> like OF and StarMON it's unnecessary, there is one firmware standard that can
> be implemented on an infinite number of boards, one common interface so one
> zImage can work on all, and a machine ID that it can sense to select the right
> port in vmlinux.

I'll probably soon give up on trying to convince you that this won't
happen and the closest that's ever likely to be seen as a 'standard
firmware' is the ability to deal with a static ELF program.  It'd be
_nice_ if everyone use PPCBoot or StarMON or something (remember, not
all OF is created equal, and Apple doesn't have much/any incentive to be
compatible w/ the rest of the OF world).

> > Personally, I think some people spend too much time in the firmware and
> > not enough time actually in linux.
>
> That's probably because some of us are more hardware than software engineers.

<Another Joke>
So you're more one of those hardware people inflicting really wierd
designs on us software people, aren't you? :)
</Another Joke>

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
