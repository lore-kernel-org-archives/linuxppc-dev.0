Mime-Version: 1.0
Message-Id: <a04310105bbcdcaaea8e5@[199.170.89.159]>
Date: Tue, 4 Nov 2003 15:29:23 -0600
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
From: Jeff Walther <trag@io.com>
Subject: Re: IRQS on 6 Slot Macs
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 20:14 +1100 11/04/2003, Benjamin Herrenschmidt wrote:
>>  I can't
>>  find the reference now, but I could swear that I read that the proper
>>  procedure when implementing a PCI-PCI Bridge is to tie the
>>  subordinate slot's interrupts into the interrupt for the host slot.

>Hrm... nah nah nah :) If you tie them together, you get one
>interrupt shared for all in the end... what you can do on
>platforms with an irq router like x86 is to make use of the
>4 different irq lines of the bridge and route them to the
>sub-slots, but on macs, like on lots of othre platforms, the
>4 lines are just or-ed together.

Ah, my memory is working this morning (okay, afternoon).   The
reference I couldn't find was Apple's Tech Note TN_1135, which is an
Apple reference, not a PCI specification reference.   My apologies
for any confusion I may have caused anyone.

>Anyway, such a rule really only apply when you design a PCI
>card with a P2P bridge on it. As long as you are on the
>motherboard, you do what you want.

Right, because with a card, one only has access to what's in the slot
but on the motherboard one can wire to anything present.   Thank you.
Brain is feeling much more limber now.

>>  After all, one can, in theory, add 1024 PCI slots to a machine using
>>  PPBs.   There aren't going to be 1024 interrupts available.
>
>Why ? Some iSeries have up to 2048 irq lines afaik ;)

By iSeries, do you mean iBook and iMac?   Or is that something else?
I'm still kind of living in the PowerSurge world, with occasional
forays up to Beige G3.  :-)

>>  The
>>  specification for PCI-PCI Bridges had to have some more general
>>  method of handling interrupts for slots behind a PPB, and tieing them
>>  to the host slot interrupt makes the most sense.
>
>No. The P2P specification provides nothing for interrupts, just
>a generic "guideline" that you may or may not follow depending on
>what you are designing. The way you route a motherboard interrupt
>line (regardless of it beeing on a bridge or not) is a matter
>of commen sense rather.

Right.   My mistake for misremembering an Apple note as part of the PCI spec.

>>  All that said, the firmware for the x500 and x600 Macs is not written
>>  properly, at least with respect to implementing PCI-PCI Bridges.
>
>Well... Again, do not mix what happens on the mobo and what happens
>in slots. Indeed, the x500 and x600 machines have an OF bug that
>cause it to not properly assign the shared irq line to the child
>devices, but that's really only a concern for _slots_.

The bug I've observed, I first became aware of because of the S900.
The PowerSurge machines have a problem with more than one level of
PPB.  If you put a PPB bearing card in the lower four slots of the
S900, you've created two layers of PPBs.   With a few exceptions
(like leaving all the other lower slots empty) this causes the
machine to freeze during initialization at the gray screen.

>>  >Basicallly, what they did when designing that machine was to use a
>>  >standard powersurge design with 3 slots and replace one of them
>>  >with a PCI<->PCI bridge. Since they didn't "know" how to get more
>>  >interrupt lines out of Grand Central, they just also stuffed all
>>  >interrupt lines together for those 4 slots (I'm pretty sure GC do
>>  >have spare lines they could have used,

>I don't know how much exactly GC provides. It has a single mask
>register of 32 interrupts, so if you count all the GC internal ones,
>that still leaves a few of them I beleive... You'd need the pinout
>of GC, I don't have it (maybe you do ? :) I'm interested in any spec
>for these old chipsets...)

Unfortunately, no, I don't have the GC pinout.  All the pinout
information I have on the PowerSurge chipset, I've gotten by starting
with the PCI slot pinout and the PPC601 pinout and working backwards
to the various chips.  I wish, wish, wish that I had access to
Apple's documents on that chipset.  Oh, and the CPU slot listing in
the ANS Hardware Developer Notes helped too, because the ANS used the
same chipset, so some of the pin IDs can be found by working
backwards to Hammerhead on the ANS.

Anyway, the listing of slot interrupt pins on GC was all I have
except that pin 61 is GNT and pin 62 is REQ for Grand Central's
arbitration as a device on the PCI bus.    It will be fairly easy to
identify the PCI bus pins on GC.  I just haven't done it yet and
that's probably the least interesting component of GC's pinout.

I think I can find GC's connection to MESH as well, but I'm
uncertain.   I believe that MESH is just a licensed NEC (now LSI
Logic) 53CF96 and I have the pinout for the 53CF96 so tracing
backwards from that wouldn't be tough, if that's true.   I need to
solder a 53CF96 in place of a MESH some time and see if it works....

I do have the complete CPU slot pinout and a mostly complete Bandit
pinout (two or three pins uncertain).   But I think I've emailed
those to the list before, so you probably have them.   If not, let me
know and I'll shoot you a copy.

>>  This seems to be born out (limited interrupts available) by the
>>  gymnastics they went through to arrange the interrupts in the Apple
>>  Network Server, which has six PCI slots, but also four built-in PCI
>>  devices (including Grand Central) on the motherboard.  They didn't
>>  use any previously unused interrupts on GC in the ANS, they just
>>  rearranged and combined the interrupts used in the 9500.
>
>Yup. Still... it would have made a lot of sense for the S900 designers
>to actually route the additional slot interrupts to separate GC
>interrupt pins. The main problem with that would have been the need to
>"teach" Apple's OF about the binding, which of course would have been
>a total mess....

You've convinced me.   I agree that would have been better.    It's
kind of sad, because I worked with a fellow who interned at Umax's
Mac cloning hardware group, and he said they were engaging in a
pretty intricate firmware development effort for PREP (or was it
CHRP?) before things got shut down.  If they put that much effort
into the next generation, they were willing to spend the same type of
resources it would have taken to hack the earlier OF.   But it was a
different deal as far as the licensing issues go.

>>  However, I can't help but wonder if all that lovely video circuitry
>>  on the 7500 and 8500 requires any interrupts and if so, where they
>>  come from.  Do they recycle the interrupts for slots 4 -6 or are
>>  there other interrupts available on GC besides the ones for the six
>>  slots?
>
>Maybe compare the interrupt numbers ? I don't have my datas at hand
>but that should give you an idea of who goes where. IIRC, some Mklinux
>source (or maybe it's early darwin source) had a map of all the irqs
>of GC as well.

Now that's interesting.   I wonder how they figured them out.  I
wonder how hard it's going to be to find...

>  A bit more tricky, they could have put a routing
>circuit optionally or'ing them all together. By default, the machine
>boots with them all or'ed. If the nvramrc script (or whatever other
>possible software patch) doesn't load, they stay that way. The software
>patch ticks an IO disabling that OR'ing after patching either the
>device-tree  (nvramrc patch) or whatever MacOS used for routing.
>
>Probably doable with a few gates, or bits of a PLD if any was already
>there.

There is no PLD between the PCI interrupt pins and GC on the S900
board.  But, since Umax designed the board, they certainly could have
added one.   They already did that quirky E100 hack to PCI slot 1.
I haven't dug into that, but I'd like to know how they made that
work.  Does an Enet card require an interrupt?  Does it ever master
the PCI bus?

Somehow they convinced the machine that there's another PCI slot
there when the E100 (Mercury) card is installed.   It's a combined UW
SCSI and 10/100 Enet for those not familiar with it and slot 1 on the
S900 has an extender to provide additional signals to the E100 card.

The E100 gets dual fuctionality without a PPB.   I haven't traced the
connections, but my assumption is that the two chipsets on the card
are sharing the common PCI bus lines in the slot, and that the
extender on slot 1 provides the slot specific PCI signals to one of
the two chipsets on the card.   But that might include an additional
interrupt and additional bus arbitration (does Enet bus master?).
And somehow the extension for the E100 card tells the S900 firmware
that there's an extra PCI slot called E100.

I read something about a legacy device left in the firmware called
E100, and I think Umax took advantage of that somehow, but I never
really understood what I read, and my memory is vague.

Jeff Walther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
