Date: Fri, 24 Mar 2000 14:48:59 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Gabriel Paubert <paubert@iram.es>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.HPX.4.10.10003241425470.14656-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.10.10003241443040.21215-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Probing the PCI config in atyfb_of_init (code stolen from the non-OFFB
> > case), I get:
> >
> >  atyfb_of_init: got 2 adresses for ATY: 81000000-81ffffff 80881000-80881fff
> >  atyfb: chunk 0 base 0x81000000 breg 16 io 0 pbase 0x81000000 size 0x1000000
> >  atydb: chunk 1 base 0x80881000 breg 20 io 1 pbase 0xc01 size 0x100
> >  atydb: chunk 2 base 0x0 breg 24 io 0 pbase 0x81fff000 size 0x1000
> >  atydb: chunk 3 base 0x4 breg 28 io 0 pbase 0x0 size 0x0
> >
> > I'd like to correct the first one to only include the big endian aperture,
> > and the third one to use the little endian aperture (0x817ff000). Can this
> > be done in atyfb_init?
>
> Don't touch the resources which correspond to assigned PCI bus addresses
> because they correspond to the address ranges to which chip decoders
> respond. Lying in this area makes dynamic allocation and hotplugging
> impossible by giving the resource allocator the impression that some area
> is free. Rather attach asubtree to the already existing device resources.

So it's perfectly legal for resources within the same device to overlap?
WTF does X not tolerate this and disables the overlapping one?

(Side note: X also reports the mem resources in reverse order, or maybe
sorted by end address, and disables the larger of the two apertures
because it saw the smaller one first, even though the smaller one is
completely embedded in the larger).

I'm not sure adding subtrees will help - I guess X might go ahead and
disable the main resources anyway. Will the subtree resources remain
accessible in that case?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
