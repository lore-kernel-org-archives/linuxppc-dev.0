Date: Fri, 24 Mar 2000 11:56:59 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <20000324105431.025518@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10003241142540.18758-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >Another advantage of no longer using the information from the OF tree is that
> >we can just call pci_assign_unassigned_resources() and get everything
> >reassigned, without worrying about inconsistencies with the OF device tree.
> >
> >BTW, if you do want to keep the OF device tree consistent,
> >pcibios_update_resource() is the place to do this.
>
> If this is called _after_ we have done the bus re-numbering, updating the
> OF tree will be difficult since we need the old bus number to match the
> PCI device with it's OF entry.

On a somewhat related issue (the PCI mapping funnies for the Lombard and
possibly other Rage Pro devices): what are the penalties if I 'correct'
the PCI mapping for the Rage Pro within atyfb_of_init?

Probing the PCI config in atyfb_of_init (code stolen from the non-OFFB
case), I get:

 atyfb_of_init: got 2 adresses for ATY: 81000000-81ffffff 80881000-80881fff
 atyfb: chunk 0 base 0x81000000 breg 16 io 0 pbase 0x81000000 size 0x1000000
 atydb: chunk 1 base 0x80881000 breg 20 io 1 pbase 0xc01 size 0x100
 atydb: chunk 2 base 0x0 breg 24 io 0 pbase 0x81fff000 size 0x1000
 atydb: chunk 3 base 0x4 breg 28 io 0 pbase 0x0 size 0x0

I'd like to correct the first one to only include the big endian aperture,
and the third one to use the little endian aperture (0x817ff000). Can this
be done in atyfb_init?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
