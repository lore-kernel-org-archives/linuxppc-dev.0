Mime-Version: 1.0
Message-Id: <a04310106bbcdcc771453@[199.170.89.159]>
In-Reply-To: <E1AH7lb-0000FE-00@piglet.grunz.lu>
References: <E1AH7lb-0000FE-00@piglet.grunz.lu>
Date: Tue, 4 Nov 2003 15:53:59 -0600
To: linuxppc-dev@lists.linuxppc.org
From: Jeff Walther <trag@io.com>
Subject: Re: IRQS on 6 Slot Macs
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 21:27 +0100 11/04/2003, Mich Lanners wrote:

>>  However, I can't help but wonder if all that lovely video circuitry
>>  on the 7500 and 8500 requires any interrupts and if so, where they
>>  come from.  Do they recycle the interrupts for slots 4 -6 or are
>>  there other interrupts available on GC besides the ones for the six
>>  slots?
>
>Here is my all-slots-filled config on a 7600:
>
>00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
>         Flags: bus master, medium devsel, latency 32, IRQ 22
>00:0d.0 Unknown mass storage controller: Promise Technology, Inc.
>20262 (rev 01)
>         Flags: bus master, medium devsel, latency 32, IRQ 23
>00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
>         Flags: bus master, medium devsel, latency 32, IRQ 24
>00:0f.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W
>[Millennium] (rev 01) (prog-if 00 [VGA])
>         Flags: stepping, medium devsel, IRQ 25
>00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
>         Flags: bus master, medium devsel, latency 32, IRQ 22
>01:0b.0 Non-VGA unclassified device: Apple Computer Inc. Control Video
>         Flags: fast devsel, IRQ 26
>01:0d.0 Class ff00: Apple Computer Inc. PlanB Video-In (rev 01)
>         Flags: bus master, medium devsel, latency 32, IRQ 28
>
>So yes, video-in and graphics have separate interrupts. But those could
>be the same IRQ's as used on slots 4-6 on 9x00 machines. AFAIK, there
>have been no machines with video circuitry _and_ 6 PCI slots.

Thank you, michel.  That will get me quite a ways along on that inquiry.

>I have no info about video-in; but I think I remember some site
>somewhere with all possible device trees online. You might find more
>info there...

I have that site bookmarked somewhere--at least I think it's the same
site.   I just haven't checked it in a while.  However, I think that
the device tree only generates a listing if there is a PCI card
installed in the slot, and as I recall, most of the machines listed
only had one or two PCI cards installed.  Still, it's worth a look to
me.

I have a hardware project in mind, but am not actively working on it.
So, when discussion that touches on it comes up, I'll pop up for a
bit to gather/share what info I can, but until I move this to the
front of my hobby queue I won't make a lot of progress.

The thing I'm interested in is building a PowerSurge with three or
four Bandits.   The architecture supports it, according to Apple
docs, but the big question is whether the actual implementation of
chips supports the full architecture or just a subset.   For example,
one would need twelve interrupts for PCI slots (at least) with four
Bandits.  Are there six more external interrupts available on GC?
And how could we ever figure that one out, unless someone sneaks into
a vault at Apple?  (Or one could build that hypothetical machine with
6 PCI slots and built-in video which you mentioned above.)

Another essential question is whether there are sufficient
arbitration lines on Hammerhead to support three or four Bandits.

And the thing that usually kills my ambition to make this my primary
hobby at the moment is the firmware mods it would take.   I'm into
hardware and not much of a programmer.

As to how I would build such a machine, if Apple's chips supported
it, the S900 has a second CPU slot on the motherboard.   However,
that slot could be used for a CPU Bus expansion card, because almost
all the required signals are available there.    So, one could put
two or three Bandits on a daughter card, install the card in the
secondary CPU slot on the S900 and run cables from the daughter card
to the PCI backplanes for the additional Bandits.   Actually, it
would be fairly trivial to build a daughter card with a single Bandit
on it for the S900, adding three PCI slots....One need only copy
connections from the 9500 in order to do that.

Jeff Walther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
