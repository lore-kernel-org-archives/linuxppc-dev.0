Date: Fri, 24 Mar 2000 19:43:06 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Gabriel Paubert <paubert@iram.es>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.HPX.4.10.10003241848330.14656-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.10.10003241927550.22814-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > They are prioritized the right way: if you memset the whole aperture to 0
> > the chip freaks out instead of just painting the whole screen black. Been
> > there, done that.
>
> Ok, anyway memsetting the whole aperture may not be the smartest thing to
> do since the aperture may be larger than the installed VRAM.

I was hoping for OF to report the right thing.

> > Well, arguing with X is pointless. So far I've always got the short end of
> > the stick :-)
>
> Hmmm, then find some free space and put the MMIO registers in this area.

Assuming VRAM is from 0x81800000 to 0x81ffffff (the big endian aperture),
a perfect place to put MMIO would be 0x817ff000. The same registers appear
there, and that's the very place atyfb exports for MMIO mmap. It's just
the combination of silly PCI mapping in OF and X boneheadedness that gets
us here.

> > I mean: if someone disables the original resource, what happens to the
> > new resources?
>
> I don't understand the question.

Assume the 0x81000000->0x81ffffff mapping is left untouched and I just add
a new one for 0x81800000>0x81ffffff, and another one for 0x817ff000->
0x817fffff. X goes along and disables 0x81800000->0x81ffffff, does the
0x81800000>0x81ffffff stil work? X disables 0x81fff000->0x81ffffff, does
0x817ff000->0x817fffff still work?

But probably X will disable both 0x81000000->0x81ffffff and 0x81800000->
0x81ffffff because they overlap the 0x81fff000->0x81ffffff range. No gain.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
