Date: Mon, 8 Apr 02 11:18:43 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204081818.AA21305@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> wrote:

> > The platforms I've initially included in this new model are Adirondack,
> > EV-64260A, and K2.
>
> Just checking, but right now these are only supported with StarMON and
> not necessarily their shipping ROMs, right? :)

The Adirondack port currently in 2_4_devel has always been StarMON-only. For
this one board StarMON was the only existing firmware period for a few months,
and IMAO on this board it's essential, Adirondack can't be made to work right
with anything other than StarMON. I think they are still using StarMON to
production-test Adirondacks and program their serial EEPROMs with Ethernet
addresses, etc.

Of course that fucker, then software eng. manager, now director of engineering
Art Webb, wanted PeeMON on it no matter how stupid. I obstructed them as much
as I could by not making a zImage for the Adirondack and telling them that it
couldn't be done and that one had to boot vmlinux directly on Adirondack. But
the fuckers did manage to put their PeeMON on Adirondack, of course stealing
all the very complex board init code from StarMON. They actually made it load
the vmlinux ELF image and pass it a bi_recs list. But the only info they put in
there was the memory size. No way to set the command line, select the root
device, or boot with an initrd. So it's basically unusable. But the fuckers
didn't care if they make a usable system or not, all they cared was that it
says "PMON" on it, whether it works or not. No wonder they've recently had two
big customer projects canceled from what I've heard, with that attitude.

And I'm not even mentioning that the Adirondack has a hardware quirk it seems
that means that it *requires* something like OF or StarMON to work correctly.
It seems like that wonderful VT82C686B south bridge has a feature that if it's
enumerated more than once (like first by the firmware and then by Linux) IDE
won't work. In any case what I found when trying to get IDE to work was that it
stopped working after Linux did its pci_auto_bus_scan thing, but would work
fine if I changed the Linux port not to use pci_auto.c and instead keep the PCI
enumeration from StarMON (and of course IDE works in StarMON). If I made that
change, perfectly legitimate as it's necessary to make IDE work, it would bind
Adirondack Linux even more tightly to StarMON, stopping SBS fuckers' PeeMON
efforts once and for all. But the fucker fired me before I could do that. :-(

As for the K2, I just did it from memory to validate my CONFIG_GENERIC_PPC32
framework. I don't have a K2 or any other SBS hardware personally, so I'm not
defending that one.

Now I made the EV-64260A port very carefully to make it work with absolutely
any boot ROM. That's the vmlinux port, assuming it's booted with the right
bi_recs. I have a boot wrapper for StarMON, but not for anything else as I
don't have anything else. The PPCBoot people claim to boot vmlinux directly,
and I say they should be able to do it with my EV-64260A port, just pass it the
right bi_recs.

The issue of "shipping ROMs" for the EV-64260A is moot I think. There are as
many different ROMs for this eval board as there are actual boards. The one I
had at SBS came up right in VxWorks on power-up, no "shipping ROM" to boot
Linux with. The one I have now came with a PPCBoot ROM that spitted garbage out
the serial port and was unusable until I got the PROM burner working and made
it a StarMON ROM. (And that PPCBoot ROM was put in there by the guy I got the
board from, not by Galileo.)

> I'm sure it's unintentional, but it looks more like it'd be changing
> platform_init to x_init,

I'm not sure what you mean by unintentional, it's necessary to change
platform_init to <board>_init in order to have more than one board supported in
one kernel, which is necessary in order for my boards to compete fairly with
PMacs, PRePs, and CHRPs that are all supported in one kernel.

> and serial fixes rather than changing #ifdefs.

I think the way I've handled serial in CONFIG_GENERIC_PPC32 is neat and the
RTTD.

Adding other 2_4_devel boards to CONFIG_GENERIC_PPC32 will sometimes require an
#ifdef-ectomy. Look at Sandpoint for example. Choosing X2 or X3 at compile time
defeats the purpose of having one kernel support everything and decide at run
time. Same thing with Spruce having a compile option for 30 MHz or 33 MHz
serial port baud base.

> Aside from some ugliness added back to the code (see my other email).

I don't see it as ugly, I think it's quite beautiful.

> One other problem is that in case anyone forgot, back when we used to
> always define a new _MACH type, we had actually ran out (or got w/in 3
> or so) so we might want to think of changing the values in 2.5 to
> something that can scale better, if we're going to do this.

Perhaps you've missed my comment in processor.h:

/*
 * New CONFIG_GENERIC_PPC32 machine codes. There is absolutely no need for a
 * machine code to be a walking 1, so when defining a new code add 1 to the
 * last one, don't shift left one bit like before, or incur the wrath of the
 * person trying to support the 33rd machine. These machine codes are passed to
 * us by external bootloaders, so we are under a social contract not to ever
 * change them.
 */
#define	_MACH_adir	0x00000001
#define	_MACH_ev64260a	0x00000002
#define	_MACH_k2	0x00000003

> It's worth noting why these are done as they are, since I'm not sure you
> quite see why.  pmac and chrp fall into the same category as ppcstar,
> which is 'We know the firmware, it can be useful, and we will use it'.

I know this.

> If you didn't have the option of replacing a firmware, I'd bet you'd end
> up using it too :)

Ahmm, when you are making a new board there is no firmware to replace, you have
to write it!

> But anyhow, it's actually not incompatible with this.  I've gone and
> looked at this abit, and it'd be a matter of re-writing the Makefile a
> bit (obj-$(...) and XXX_OBJS -> platform.o, rm -f'ed after each zImage,
> and then a -DMACH_TYPE=_MACH_xxx for one of the files..).

Are you saying you are going to make some kind of loop in
arch/ppc/boot/simple/Makefile that would spit out 20 zImages on one make zImage
for CONFIG_GENERIC_PPC32? Fine with me if you want to do that.

> Well, since 'simple' will still work, this is a non-issue once again.

Even better then.

> > This will be
> > an encouragement to board makers to use standardized firmware like OF,
> > StarMON, or PPCBoot rather than roll a board-unique one: use something
> > standard and you can use one of existing zImages, or roll your own and
> > be prepared to convince people to accept adding yet another zImage.
>
> Or use a firmware which can load an ELF image (pmon, yes?) or fake it

But this way you still have to add a new zImage for each new board, even if
only to carry the knowledge of which board it is. With standardized firmware
like OF and StarMON it's unnecessary, there is one firmware standard that can
be implemented on an infinite number of boards, one common interface so one
zImage can work on all, and a machine ID that it can sense to select the right
port in vmlinux.

> Personally, I think some people spend too much time in the firmware and
> not enough time actually in linux.

That's probably because some of us are more hardware than software engineers.
When you are trying to get SDRAM to work and it's tough going because you've
got a new unfamiliar system controller chip, you aren't sure of the right
timing parameters, and the board is the very first prototype with some HW
design errors still not caught and fixed, StarMON is a much better debug tool
than Linux.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
