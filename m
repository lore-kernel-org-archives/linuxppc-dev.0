Date: Tue, 27 Nov 01 07:33:27 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111271533.AA24180@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Please make K2 Linux bootable without PeeMON again
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> wrote:

> Er, why can't you find the magic location for the bi_recs and set that
> as well as the other registers you need to?

Because that location is tied to the kernel's symbols (__bss_start in this
case), and I have no way of knowing where that is. The kernel has already been
loaded into memory (by occult) by the time my booter runs, and my booter
doesn't have access to the original vmlinux ELF header or to System.map.

> > The patch below makes the K2 vmlinux expect a pointer to bi_recs in R3 like I
> > do on the Adirondack and makes the "simple" zImage goo pass a pointer to its
> > magic bi_recs in R3.
>
> And breaks all of the other ports which use 'simple' and expect bi_recs
> in the 'normal' place.

No, it doesn't. The patch I posted yesterday doesn't and cannot break anything.
The bi_recs are still being created in exactly the same place as before, I just
made the wrapper set R3 to point to that location before jumping to the kernel.
As R3 on entry to the kernel was previously undefined for "simple", this cannot
break anything. Why R3? Because there already is a precedent for it
(Adirondack).

> For now I'd much rather add back in the register
> checks.

You mean put arch/ppc/platforms/k2_setup.c back the way it was? That would work
for me. In that case you would also need to make
arch/ppc/boot/common/relocate.S put at least some meaningful values in R4 and
R6 (at least zeros) so that the kernel doesn't interpret garbage in those
registers as pointers to stuff.

> For 2.5 we can agree on a less magical and more predictable
> location.  Would somewhere around the end of memory work for you?

But why won't you just let me put it where I want and tell the kernel where I
put it? I'll fork Linux if I have to, but I would prefer not to.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
