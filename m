Mime-Version: 1.0
Message-Id: <a04310106bbcd1501d614@[199.170.89.118]>
In-Reply-To: <1067842481.17970.8.camel@gaston>
References: <20031103033529.24416.qmail@kunk.qbjnet.com>
 <1067842481.17970.8.camel@gaston>
Date: Tue, 4 Nov 2003 02:55:40 -0600
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
From: Jeff Walther <trag@io.com>
Subject: Re: IRQS on 6 Slot Macs
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 17:54 +1100 11/03/2003, Benjamin Herrenschmidt wrote:
>On Mon, 2003-11-03 at 14:35, Robert E Brose II wrote:
>
>>  A couple of things right off, the rage128 appears to be the only thing on
>>  irq 23 however 23 doesn't show up in /proc/interrupts meaning, I suppose,
>>  that it's not using the interrupt. So why does the drm complain?
>>
>>  How come everything from slots 3-6 says it's on the same interrupt (25)?
>
>I don't know what's up with the DRM not liking your interrupt. I can
>answer for the sharing of USB, symbios and firewire interrupts: all 3
>slots share one interrupt because of bad motherboard design :)

I'm not sure it was bad motherboard design--at least, not unless
following specifications leads to bad motherboard design.   I can't
find the reference now, but I could swear that I read that the proper
procedure when implementing a PCI-PCI Bridge is to tie the
subordinate slot's interrupts into the interrupt for the host slot.
The firmware for the host machine is supposed to be able to sort this
out, if written properly.

After all, one can, in theory, add 1024 PCI slots to a machine using
PPBs.   There aren't going to be 1024 interrupts available.   The
specification for PCI-PCI Bridges had to have some more general
method of handling interrupts for slots behind a PPB, and tieing them
to the host slot interrupt makes the most sense.

All that said, the firmware for the x500 and x600 Macs is not written
properly, at least with respect to implementing PCI-PCI Bridges.

>Basicallly, what they did when designing that machine was to use a
>standard powersurge design with 3 slots and replace one of them
>with a PCI<->PCI bridge. Since they didn't "know" how to get more
>interrupt lines out of Grand Central, they just also stuffed all
>interrupt lines together for those 4 slots (I'm pretty sure GC do
>have spare lines they could have used,

The interrupts for the slots (in the 9500/9600) go to the following pins on GC:

Slot #      GC pin #
1                193
2	     194
3	     189
4	     188
5	      173
6	      174

On the S900 (and J700) the interrupts for slots 3 through 6 are tied
to pin 189.

Slots 1 through 3 are also correct for all other PowerSurge machines.
I would love to know if there are other unused interrupts available,
as the PowerSurge architecture supposedly can support up to four
Bandit chips, but as far as I know, if one constructed such a beast,
there'd be no interrupts available for any PCI slots beyond six.

This seems to be born out (limited interrupts available) by the
gymnastics they went through to arrange the interrupts in the Apple
Network Server, which has six PCI slots, but also four built-in PCI
devices (including Grand Central) on the motherboard.  They didn't
use any previously unused interrupts on GC in the ANS, they just
rearranged and combined the interrupts used in the 9500.

However, I can't help but wonder if all that lovely video circuitry
on the 7500 and 8500 requires any interrupts and if so, where they
come from.  Do they recycle the interrupts for slots 4 -6 or are
there other interrupts available on GC besides the ones for the six
slots?

>but that would have meant
>updating Open Firmware to understand the layout, I doubt the people
>who designed that machine wanted to dive into that).

At 14:16 +1100 11/04/2003, Benjamin Herrenschmidt wrote:
>Probably because updating Apple's 1.0.5 OF code to assign them properly
>with the P2P setup was beyond their ability to deal with crappy code :)

What is P2P setup?

The cloners just soldered Apple ROMs down in their machines.  The
ROM/firmware used in the PowerComputing and Umax machines (except
PowerBase and C series) was the same ROM/firmware used in the x500
series of machines--the $77D.28F2.   This ROM was used in the 7200,
7500, 8500, 9500, all of PCC's Catalyst clones, PowerWave, PowerTower
Pro, S900 and the J700.

I'm not sure if the cloner's license even allowed them to modify the
ROM.  The chips are labeled with Apple part numbers and Apple
markings, so I think they really did purchase them from Apple, rather
than licensing their production.

Anyway, the point being that even if Umax had wanted to go that route
(rewrite/modify/fix OF 1.05), I'm not sure it was technically
feasible under the licensing agreement.   Is hacking the interrupt
assignment for the PCI slots the kind of thing one could squeeze into
the NVRAMrc?

Jeff Walther


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
