Subject: Re: IRQS on 6 Slot Macs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Walther <trag@io.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <a04310106bbcd1501d614@[199.170.89.118]>
References: <20031103033529.24416.qmail@kunk.qbjnet.com>
	 <1067842481.17970.8.camel@gaston>  <a04310106bbcd1501d614@[199.170.89.118]>
Content-Type: text/plain
Message-Id: <1067937269.680.92.camel@gaston>
Mime-Version: 1.0
Date: Tue, 04 Nov 2003 20:14:29 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I'm not sure it was bad motherboard design--at least, not unless
> following specifications leads to bad motherboard design.   I can't
> find the reference now, but I could swear that I read that the proper
> procedure when implementing a PCI-PCI Bridge is to tie the
> subordinate slot's interrupts into the interrupt for the host slot.
> The firmware for the host machine is supposed to be able to sort this
> out, if written properly.

Hrm... nah nah nah :) If you tie them together, you get one
interrupt shared for all in the end... what you can do on
platforms with an irq router like x86 is to make use of the
4 different irq lines of the bridge and route them to the
sub-slots, but on macs, like on lots of othre platforms, the
4 lines are just or-ed together.

Anyway, such a rule really only apply when you design a PCI
card with a P2P bridge on it. As long as you are on the
motherboard, you do what you want.

> After all, one can, in theory, add 1024 PCI slots to a machine using
> PPBs.   There aren't going to be 1024 interrupts available.

Why ? Some iSeries have up to 2048 irq lines afaik ;)

> The
> specification for PCI-PCI Bridges had to have some more general
> method of handling interrupts for slots behind a PPB, and tieing them
> to the host slot interrupt makes the most sense.

No. The P2P specification provides nothing for interrupts, just
a generic "guideline" that you may or may not follow depending on
what you are designing. The way you route a motherboard interrupt
line (regardless of it beeing on a bridge or not) is a matter
of commen sense rather.

> All that said, the firmware for the x500 and x600 Macs is not written
> properly, at least with respect to implementing PCI-PCI Bridges.

Well... Again, do not mix what happens on the mobo and what happens
in slots. Indeed, the x500 and x600 machines have an OF bug that
cause it to not properly assign the shared irq line to the child
devices, but that's really only a concern for _slots_.

> >Basicallly, what they did when designing that machine was to use a
> >standard powersurge design with 3 slots and replace one of them
> >with a PCI<->PCI bridge. Since they didn't "know" how to get more
> >interrupt lines out of Grand Central, they just also stuffed all
> >interrupt lines together for those 4 slots (I'm pretty sure GC do
> >have spare lines they could have used,
>
> The interrupts for the slots (in the 9500/9600) go to the following pins on GC:
>
> Slot #      GC pin #
> 1                193
> 2	     194
> 3	     189
> 4	     188
> 5	      173
> 6	      174
>
> On the S900 (and J700) the interrupts for slots 3 through 6 are tied
> to pin 189.

Yup. My point is that those could have been dispatched to the GC pins

> Slots 1 through 3 are also correct for all other PowerSurge machines.
> I would love to know if there are other unused interrupts available,
> as the PowerSurge architecture supposedly can support up to four
> Bandit chips, but as far as I know, if one constructed such a beast,
> there'd be no interrupts available for any PCI slots beyond six.

I don't know how much exactly GC provides. It has a single mask
register of 32 interrupts, so if you count all the GC internal ones,
that still leaves a few of them I beleive... You'd need the pinout
of GC, I don't have it (maybe you do ? :) I'm interested in any spec
for these old chipsets...)

> This seems to be born out (limited interrupts available) by the
> gymnastics they went through to arrange the interrupts in the Apple
> Network Server, which has six PCI slots, but also four built-in PCI
> devices (including Grand Central) on the motherboard.  They didn't
> use any previously unused interrupts on GC in the ANS, they just
> rearranged and combined the interrupts used in the 9500.

Yup. Still... it would have made a lot of sense for the S900 designers
to actually route the additional slot interrupts to separate GC
interrupt pins. The main problem with that would have been the need to
"teach" Apple's OF about the binding, which of course would have been
a total mess....

> However, I can't help but wonder if all that lovely video circuitry
> on the 7500 and 8500 requires any interrupts and if so, where they
> come from.  Do they recycle the interrupts for slots 4 -6 or are
> there other interrupts available on GC besides the ones for the six
> slots?

Maybe compare the interrupt numbers ? I don't have my datas at hand
but that should give you an idea of who goes where. IIRC, some Mklinux
source (or maybe it's early darwin source) had a map of all the irqs
of GC as well.

> >but that would have meant
> >updating Open Firmware to understand the layout, I doubt the people
> >who designed that machine wanted to dive into that).
>
> At 14:16 +1100 11/04/2003, Benjamin Herrenschmidt wrote:
> >Probably because updating Apple's 1.0.5 OF code to assign them properly
> >with the P2P setup was beyond their ability to deal with crappy code :)
>
> What is P2P setup?

PCI 2 PCI bridge setup.

> The cloners just soldered Apple ROMs down in their machines.  The
> ROM/firmware used in the PowerComputing and Umax machines (except
> PowerBase and C series) was the same ROM/firmware used in the x500
> series of machines--the $77D.28F2.   This ROM was used in the 7200,
> 7500, 8500, 9500, all of PCC's Catalyst clones, PowerWave, PowerTower
> Pro, S900 and the J700.

Yup. That is part of the problem.

> I'm not sure if the cloner's license even allowed them to modify the
> ROM.  The chips are labeled with Apple part numbers and Apple
> markings, so I think they really did purchase them from Apple, rather
> than licensing their production.

Yah, though they probably could have dealt some small change to OF
to deal with that issue, or have an nvramrc patch (ugh !) at worst.

> Anyway, the point being that even if Umax had wanted to go that route
> (rewrite/modify/fix OF 1.05), I'm not sure it was technically
> feasible under the licensing agreement.   Is hacking the interrupt
> assignment for the PCI slots the kind of thing one could squeeze into
> the NVRAMrc?

Yes, that's doable. A bit more tricky, they could have put a routing
circuit optionally or'ing them all together. By default, the machine
boots with them all or'ed. If the nvramrc script (or whatever other
possible software patch) doesn't load, they stay that way. The software
patch ticks an IO disabling that OR'ing after patching either the
device-tree  (nvramrc patch) or whatever MacOS used for routing.

Probably doable with a few gates, or bits of a PLD if any was already
there.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
