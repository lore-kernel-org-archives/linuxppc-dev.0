Date: Tue, 4 Nov 2003 21:27:06 +0100 (CET)
From: Mich Lanners <mlan@cpu.lu>
Reply-To: Mich Lanners <mlan@cpu.lu>
Subject: Re: IRQS on 6 Slot Macs
To: trag@io.com
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Message-Id: <E1AH7lb-0000FE-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   4 Nov, this message from Jeff Walther echoed through cyberspace:
> I'm not sure it was bad motherboard design--at least, not unless
> following specifications leads to bad motherboard design.   I can't
> find the reference now, but I could swear that I read that the proper
> procedure when implementing a PCI-PCI Bridge is to tie the
> subordinate slot's interrupts into the interrupt for the host slot.
> The firmware for the host machine is supposed to be able to sort this
> out, if written properly.
>
> After all, one can, in theory, add 1024 PCI slots to a machine using
> PPBs.   There aren't going to be 1024 interrupts available.   The
> specification for PCI-PCI Bridges had to have some more general
> method of handling interrupts for slots behind a PPB, and tieing them
> to the host slot interrupt makes the most sense.
>
> All that said, the firmware for the x500 and x600 Macs is not written
> properly, at least with respect to implementing PCI-PCI Bridges.
>
>>Basicallly, what they did when designing that machine was to use a
>>standard powersurge design with 3 slots and replace one of them
>>with a PCI<->PCI bridge. Since they didn't "know" how to get more
>>interrupt lines out of Grand Central, they just also stuffed all
>>interrupt lines together for those 4 slots (I'm pretty sure GC do
>>have spare lines they could have used,
>
> The interrupts for the slots (in the 9500/9600) go to the following
> pins on GC:
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
>
> Slots 1 through 3 are also correct for all other PowerSurge machines.
> I would love to know if there are other unused interrupts available,
> as the PowerSurge architecture supposedly can support up to four
> Bandit chips, but as far as I know, if one constructed such a beast,
> there'd be no interrupts available for any PCI slots beyond six.
>
> This seems to be born out (limited interrupts available) by the
> gymnastics they went through to arrange the interrupts in the Apple
> Network Server, which has six PCI slots, but also four built-in PCI
> devices (including Grand Central) on the motherboard.  They didn't
> use any previously unused interrupts on GC in the ANS, they just
> rearranged and combined the interrupts used in the 9500.
>
> However, I can't help but wonder if all that lovely video circuitry
> on the 7500 and 8500 requires any interrupts and if so, where they
> come from.  Do they recycle the interrupts for slots 4 -6 or are
> there other interrupts available on GC besides the ones for the six
> slots?

Here is my all-slots-filled config on a 7600:

00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
        Flags: bus master, medium devsel, latency 32, IRQ 22
00:0d.0 Unknown mass storage controller: Promise Technology, Inc. 20262 (rev 01)
        Flags: bus master, medium devsel, latency 32, IRQ 23
00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Flags: bus master, medium devsel, latency 32, IRQ 24
00:0f.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W [Millennium] (rev 01) (prog-if 00 [VGA])
        Flags: stepping, medium devsel, IRQ 25
00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
        Flags: bus master, medium devsel, latency 32, IRQ 22
01:0b.0 Non-VGA unclassified device: Apple Computer Inc. Control Video
        Flags: fast devsel, IRQ 26
01:0d.0 Class ff00: Apple Computer Inc. PlanB Video-In (rev 01)
        Flags: bus master, medium devsel, latency 32, IRQ 28

So yes, video-in and graphics have separate interrupts. But those could
be the same IRQ's as used on slots 4-6 on 9x00 machines. AFAIK, there
have been no machines with video circuitry _and_ 6 PCI slots.

I have no info about video-in; but I think I remember some site
somewhere with all possible device trees online. You might find more
info there...

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
