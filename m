Date: Wed, 9 Feb 2000 10:57:29 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Retrace
In-Reply-To: <20000208222916.011600@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.10002091009440.1866-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 8 Feb 2000, Benjamin Herrenschmidt wrote:

> On Tue, Feb 8, 2000, Gabriel Paubert <paubert@iram.es> wrote:
>
> >	deviobase = ioport_ptr(dev->resource[0]);
> >
> >	data = inl(deviobase+register_offset);
> >
> >and for an MMIO mapped area:
> >
> >	mmioptr = ioremap(ioremap_ptr(dev->resource[1]));
> >
> >	data = readl(mmioptr+register_offset);
>
> Is it possible to "walk up" the resource tree from dev->resource[0] ? I
> mean, the ioport_ptr function, to work on those weird Apple bridges, need
> to go thru a special routine that looks up the device in OF device tree
> to find out on which sub-bridge it is.
> In order to do that, it needs the pci dev_fn. Can this be retreived from
> dev->resource[0] ?

Yes, each resource has a parent and the idea is that walk the tree up
using the NONTRANSPARENT nodes to translate the address until you reach
the top (parent==0) or something similar.

> Also, this doesn't solve the userland problem.

 I was thinking of showing the non transparent nodes
explicitly in the /proc/iomem which would look like:
(on my MVME2400 boards in CHRP mode)

00000000-001fffff: System RAM
02000000-3fffffff: Unused
40000000-fcffffff: PCI memory space
  fcfbec00-fcfbefff : Digital Equipment Corporation DECchip 21142/43
  fcfbf000-fcfbffff : Tundra Semiconductor Corp. CA91C042 [Universe]
  fcfc0000-fcffffff : Motorola Hawk
fd000000-fdffffff[->00000000-00ffffff]: ISA memory space
  000a0000-000bffff: Video memory
fe000000-febfffff[->00000000-00bfffff]: PCI/ISA I/O space
  00000000-0000001f : dma1
  00000020-0000003f : pic1
  00000040-0000005f : timer
  00000074-00000077 : PreP NVRAM
  00000080-0000008f : dma page reg
  000000a0-000000bf : pic2
  000000c0-000000df : dma2
  000003f8-000003ff : serial(auto)
  00010000-00010fff : Tundra Semiconductor Corp. CA91C042 [Universe]
  00011000-0001107f : Digital Equipment Corporation DECchip 21142/43
    00011000-0001107f : DC21143 (eth0)
  00011080-0001108f : Symphony Labs SL82c105
  00011090-0001109f : Symphony Labs SL82c105
  000110a0-000110a7 : Symphony Labs SL82c105
  000110a8-000110af : Symphony Labs SL82c105
  000110b0-000110b3 : Symphony Labs SL82c105
  000110b4-000110b7 : Symphony Labs SL82c105
...

which gives at least a relatively easy to parse syntax.  But it might be
useful to find a way to export it in binary to user space (I hate parsers
myself, computers work much better in binary, converting from binary to
human readable is easy but the other way around is always tedious when
properly done with error checking...)


In PreP mode it would rather look like
00000000-001fffff: System RAM
02000000-7fffffff: Unused
80000000-bfffffff[->00000000-3fffffff]: PCI/ISA I/O space
  00000000-0000001f : dma1
  00000020-0000003f : pic1
  00000040-0000005f : timer
  00000074-00000077 : PreP NVRAM
  00000080-0000008f : dma page reg
  000000a0-000000bf : pic2
  000000c0-000000df : dma2
  000003f8-000003ff : serial(auto)
  00010000-00010fff : Tundra Semiconductor Corp. CA91C042 [Universe]
  00011000-0001107f : Digital Equipment Corporation DECchip 21142/43
    00011000-0001107f : DC21143 (eth0)
c0000000-fcffffff[->00000000-3cffffff]: PCI/ISA memory space
  000a0000-000bffff: Video memory
  01000000-0103ffff : Motorola Hawk
  01040000-01040fff : Tundra Semiconductor Corp. CA91C042 [Universe]
  01041000-010413ff : Digital Equipment Corporation DECchip 21142/43

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
