Date: Fri, 24 Mar 2000 21:03:21 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.10.10003241927550.22814-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.HPX.4.10.10003242053320.14656-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Mar 2000, Michael Schmitz wrote:

> > > They are prioritized the right way: if you memset the whole aperture to 0
> > > the chip freaks out instead of just painting the whole screen black. Been
> > > there, done that.
> >
> > Ok, anyway memsetting the whole aperture may not be the smartest thing to
> > do since the aperture may be larger than the installed VRAM.
>
> I was hoping for OF to report the right thing.

Nope, if it is the assigned addresses properties. It has to be the range
of addresses potentially decoded by this device to make sure that
allocation of other devices does not cause conflicts. I remember seeing
something about allocating subareas in OF but I don't know where to find
it right now.

> Assuming VRAM is from 0x81800000 to 0x81ffffff (the big endian aperture),
> a perfect place to put MMIO would be 0x817ff000. The same registers appear
> there, and that's the very place atyfb exports for MMIO mmap. It's just
> the combination of silly PCI mapping in OF and X boneheadedness that gets
> us here.

I disagree, mapping in OF or in the resource tree is not that silly. At
one point you have to describe all address ranges potentially decoded
by a device to perform correct allocation, even if they corresopnd to
alias addresses of the same VRAM for example.

> Assume the 0x81000000->0x81ffffff mapping is left untouched and I just add
> a new one for 0x81800000>0x81ffffff, and another one for 0x817ff000->
> 0x817fffff. X goes along and disables 0x81800000->0x81ffffff, does the
> 0x81800000>0x81ffffff stil work? X disables 0x81fff000->0x81ffffff, does
> 0x817ff000->0x817fffff still work?

It depends on how it disables it. By writing 0 to the BAR ?

Anyway the resource tree in 2.3 won't let you add the 0x81800000 mapping
unless you put it as a child of the 0x81000000, which it actually is AFAIU
the intent of the resource tree code.

> But probably X will disable both 0x81000000->0x81ffffff and 0x81800000->
> 0x81ffffff because they overlap the 0x81fff000->0x81ffffff range. No gain.

Then X needs to be fixed, perhaps the generic X PCI code needs special
hooks for individual drivers to check whether the configuration is
acceptable or not. OTOH I don't understand why something there (OF ?)
insists in overlapping the registers with the VRAM, the PCI code in the
kernel (2.3) should give the registers a separate area, saving 4kB of MMIO
space is completely useless.

	Gabriel.

>
> 	Michael
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
