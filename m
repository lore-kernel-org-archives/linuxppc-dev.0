From: Benjamin Herrenschmidt <bh40@calva.net>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        Linux/PPC
 Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/MIPS Development
 <linux@cthulhu.engr.sgi.com>
Subject: Re: Proposal: non-PC ISA bus support
Date: Tue, 20 Jun 2000 14:23:29 +0200
Message-Id: <20000620122329.13473@mailhost.mipsys.com>
In-Reply-To: <Pine.GSO.4.10.10006201254290.8592-100000@dandelion.sonytel.be>
References: <Pine.GSO.4.10.10006201254290.8592-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jun 20, 2000, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
wrote:


> 1. Provide /proc/bus/isa/map, which contains the ISA I/O and memory space
>    mappings on machines where these are memory mapped.
>
>    Example (on PPC CHRP LongTrail):
>
>	callisto$ cat /proc/bus/isa/map
>	f8000000	01000000	IO
>	f7000000	01000000	MEM
>	callisto$

Looks fine except for one thing: How can we handle weird HW (like Apple
Uni-N bridge) that has actually 3 different IO spaces at different
locations (all of them beeing childs of the same PCI bus).
This is more or less related since the ISA iospace can be considered as a
subset of the PCI IO space. The problem is generic (it happens with both
"pure" PCI drivers doing IOs and ISA drivers doing IOs). The problem
exist for both the kernel and userland apps like XFree wanting to do PCI
or ISA IOs. The kernel has a built-in IO-base, your patch would expose it
to userland fixing part of the problem for XFree (so userland don't have
to probe for zillion different bridges) but wouldn't solve the problem of
multiple busses.

Paul suggested mapping them one after each other in a single contiguous
region (with the appropriate fixup in the kernel PCI io resources) but
this can work only for PCI IOs (drivers using the io resource base).
Drivers hard-coding legacy IO addresses will still not work (except if
they are on the first bus).

We still can decide (and that's what I currently do in the kernel) that
IO space is only supported on one of those 3 busses (the one on which the
external PCI is). This prevents however use of IOs on the AGP slot, which
is a problem for things like XFree who may try to use VGA addresses on
the card.

I still don't have a clue about a good solution to this issue. Apple
solves it in their kernel by having an object oriented bus structure,
each device asking for mappings to their parent bridge, based on the
device tree and independently of PCI bus numbers.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
