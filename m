Date: Fri, 24 Mar 2000 14:35:49 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.10.10003241142540.18758-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.HPX.4.10.10003241425470.14656-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Mar 2000, Michael Schmitz wrote:

> On a somewhat related issue (the PCI mapping funnies for the Lombard and
> possibly other Rage Pro devices): what are the penalties if I 'correct'
> the PCI mapping for the Rage Pro within atyfb_of_init?
>
> Probing the PCI config in atyfb_of_init (code stolen from the non-OFFB
> case), I get:
>
>  atyfb_of_init: got 2 adresses for ATY: 81000000-81ffffff 80881000-80881fff
>  atyfb: chunk 0 base 0x81000000 breg 16 io 0 pbase 0x81000000 size 0x1000000
>  atydb: chunk 1 base 0x80881000 breg 20 io 1 pbase 0xc01 size 0x100
>  atydb: chunk 2 base 0x0 breg 24 io 0 pbase 0x81fff000 size 0x1000
>  atydb: chunk 3 base 0x4 breg 28 io 0 pbase 0x0 size 0x0
>
> I'd like to correct the first one to only include the big endian aperture,
> and the third one to use the little endian aperture (0x817ff000). Can this
> be done in atyfb_init?

Don't touch the resources which correspond to assigned PCI bus addresses
because they correspond to the address ranges to which chip decoders
respond. Lying in this area makes dynamic allocation and hotplugging
impossible by giving the resource allocator the impression that some area
is free. Rather attach asubtree to the already existing device resources.

That's for example how it looks like for the VME bridge I'm using
(I hope to build a diff soon, but it's very easy to do), the third
bridge area actually consists of 8 subareas which together occupy 64 Mb
(ther other subareas I've defined are mostly cosmetic):

e0000000-f2ffffff : Tundra Semiconductor Corp. CA91C042 [Universe]
  e0000000-f2ffffff : VMEbus A32 BLT        D32 [e0000000-f2ffffff]
f3000000-f3ffffff : Tundra Semiconductor Corp. CA91C042 [Universe]
  f3000000-f3ffffff : VMEbus CR/CSR         D32 [00000000-00ffffff]
f4000000-f7ffffff : Tundra Semiconductor Corp. CA91C042 [Universe]
  f4000000-f4feffff : VMEbus A24 DATA       D16 [00000000-00feffff]
  f4ff0000-f4ffffff : VMEbus A16            D16 [00000000-0000ffff]
  f5000000-f5feffff : VMEbus A24 DATA       D32 [00000000-00feffff]
  f5ff0000-f5ffffff : VMEbus A16            D32 [00000000-0000ffff]
  f6000000-f6feffff : VMEbus A24 DATA  PRIV D16 [00000000-00feffff]
  f6ff0000-f6ffffff : VMEbus A16       PRIV D16 [00000000-0000ffff]
  f7000000-f7feffff : VMEbus A24 DATA  PRIV D32 [00000000-00feffff]
  f7ff0000-f7ffffff : VMEbus A16       PRIV D32 [00000000-0000ffff]
fc6b0000-fc6bffff : S3 Inc. 86c764/765 [Trio32/64/64V+]
fc6c0000-fc6fffff : Digital Equipment Corporation DECchip 21140 [FasterNet]
fc700000-fc701fff : Tundra Semiconductor Corp. CA91C042 [Universe]
  fc700000-fc701fff : Dynamically reprogrammed VME slave image
fc7aee80-fc7aeeff : Digital Equipment Corporation DECchip 21140 [FasterNet]
fc7aef00-fc7aefff : Symbios Logic Inc. (formerly NCR) 53c825
fc7af000-fc7affff : Symbios Logic Inc. (formerly NCR) 53c825
fc7b0000-fc7bffff : Tundra Semiconductor Corp. CA91C042 [Universe]
fc7c0000-fc7fffff : Motorola Raven
fc800000-fcffffff : S3 Inc. 86c764/765 [Trio32/64/64V+]

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
