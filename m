Date: Tue, 14 Mar 2000 23:59:23 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linux-fbdev@vuser.vu.union.edu,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [linux-fbdev] [PATCH 2.3.x] fbdev reversion
In-Reply-To: <Pine.GSO.4.10.10003141104380.15255-100000@dandelion.sonytel.be>
Message-ID: <Pine.HPX.4.10.10003141156530.16776-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 14 Mar 2000, Geert Uytterhoeven wrote:

> > I can code those fixes, but I'm not sure what solution has most chances
> > of beeing accepted (especially changing /poc/bus/pci semantics). The
> > problem is that exporting an IO address alone (without the iobase) has
> > really no meaning on arch that don't have a x86-like separate IO space at
> > the CPU level.

Indeed, there is one and only one CPU address space on _all_ architectures
except x86 (even HP's IA64 has does not have the silly I/O space). This
makes /proc/ioports an heresy while /proc/iomem is reasonable. How do you
handle I/O accesses in a machine with several bridges which have
independant PCI I/O spaces which a) appear at discontiguous physical
addresses b) map to the same or overlapping range of I/O addresses c)
support drivers which access hardwired I/O addresses ?

That's simple, there is no solution ;-)(especially if, god forbid, several
buses have an ISA bridge) So you have to select your goals:

- support non-transparent bridges, which is what PPC bridges are,
as "transparently" as possible, this will give support for non transparent
bridges (DEC21554) used in clusters almost for free

- get rid of iobase since the number of instructions which load iobase
into a register in an average kernel is far from negligible and this will
save a few pages: in some sequences it's about 30% of the instructions

- maintain maximum compatibility with existing code (don't need to modify
most drivers),

I think this is possible provided you accept to kill condition c) above,
forcing to modify many ISA drivers. This probably makes it a 2.5 task...

I might even give it a try because it would make inserting my VME driver
and devices inside the resource tree feasible, while it's currently a
mess.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
