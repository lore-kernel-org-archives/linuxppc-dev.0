Date: Fri, 24 Mar 2000 22:37:07 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Gabriel Paubert <paubert@iram.es>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.HPX.4.10.10003242053320.14656-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.10.10003242159010.25227-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > I was hoping for OF to report the right thing.
>
> Nope, if it is the assigned addresses properties. It has to be the range
> of addresses potentially decoded by this device to make sure that
> allocation of other devices does not cause conflicts. I remember seeing

OK, strictly speaking the OF mapping is right, we just never need the
full address range.

> > Assume the 0x81000000->0x81ffffff mapping is left untouched and I just add
> > a new one for 0x81800000>0x81ffffff, and another one for 0x817ff000->
> > 0x817fffff. X goes along and disables 0x81800000->0x81ffffff, does the
> > 0x81800000>0x81ffffff stil work? X disables 0x81fff000->0x81ffffff, does
> > 0x817ff000->0x817fffff still work?
>
> It depends on how it disables it. By writing 0 to the BAR ?

By writing to the register at offset 4 - I'm not familiar with PCI speak
but this seems to be the same register that pcibios_write_config* writes
to in the atyfb code. 0 to disable, different bit patterns to enable mem
or io access.

> Anyway the resource tree in 2.3 won't let you add the 0x81800000 mapping
> unless you put it as a child of the 0x81000000, which it actually is AFAIU
> the intent of the resource tree code.

I'll look at the 2.3 code some more.

> > But probably X will disable both 0x81000000->0x81ffffff and 0x81800000->
> > 0x81ffffff because they overlap the 0x81fff000->0x81ffffff range. No gain.
>
> Then X needs to be fixed, perhaps the generic X PCI code needs special
> hooks for individual drivers to check whether the configuration is
> acceptable or not. OTOH I don't understand why something there (OF ?)
> insists in overlapping the registers with the VRAM, the PCI code in the
> kernel (2.3) should give the registers a separate area, saving 4kB of MMIO
> space is completely useless.

It should but last time I tried it complained about resource conflicts.
I've sent BenH a log of this on request.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
