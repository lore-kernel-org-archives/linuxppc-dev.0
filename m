Date: Sat, 6 Apr 02 14:17:18 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204062217.AA17328@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

>  - bi_recs are found in r4 when r3 contains "birc" (please, Michael, adapt
>    to this so we stay consistent which what BootX does). Older way of finding
>    them & cmdline & initrd still used when r3 doesn't contain that magic
>    value. r5 still contains the OF PROM pointer, at least until we have
>    the OF interface in a wrapper.

Let's have Paul rule on what the register interface should be. I'll go with
whatever interface is finalized. I've given up on having an external bootloader
boot vmlinux, as although I think ideally that's the RTTD and there are no
technical obstacles, you guys just can't agree on the vmlinux boot ABI and that
makes the point moot. I now have an arch/ppc/boot/ppcstar wrapper in each tree
that I work in which conforms to whatever vmlinux boot ABI that tree uses.

(This doesn't mean that having such wrapper is the RTTD or that the vmlinux
boot ABI inherently has to change all the time. It is perfectly possible
technically to fix the vmlinux boot ABI, keep it stable, and eliminate all
those wrappers. But that would require a revolution to oust the current tyrants
with a strangehold on write access to the mainline tree and let people with
more progressive minds in.)

> I don't plan to include Michael boards in it, I want to rework
> our ground to match what Michael does and then let him drop in his new
> boards.

I don't have my own boards yet. In my tree I used the Adirondack, EV-64260A,
and K2 ports to prove the CONFIG_GENERIC_PPC32 implementation. EV-64260A is
Galileo's reference board for the GT-64260A system controller, and Adirondack
and K2 are SBS boards already supported in 2_4_devel. I'm not at SBS any more
and don't have their hardware, but those boards are still fresh in my head and
I needed a few ports to prove my generic PPC32 implementation.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
