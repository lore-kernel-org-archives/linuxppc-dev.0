Date: Wed, 22 Mar 2000 11:43:41 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Lanners <mlan@mcp.cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <200003221024.LAA10024@mcp.cpu.lu>
Message-ID: <Pine.GSO.4.10.10003221130220.29557-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 22 Mar 2000, Michel Lanners wrote:
> > Notes:
> >
> >   - There are machine dependent things related to PCI resource assignment,
> >     namely PCIBIOS_MIN_IO and PCIBIOS_MIN_MEM in include/asm-ppc/pci.h. On the
> >     LongTrail, PCI memory space is from 0xc0000000 until 0xf7000000, so I had
> >     to change PCIBIOS_MIN_MEM to make sure allocation starts at 0xc0000000. I
> >     think we need
> >
> > 	#define PCIBIOS_MIN_IO	ppc_md.pcibios_min_io
> > 	#define PCIBIOS_MIN_MEM	ppc_md.pcibios_min_mem
> >
> >     and solve this in the machine specific setup code.
>
> Hmmm.. bad solution. At least on a number of PowerMacs, there are multiple IO
> windows, out of which IO resources need to be allocated (depends on the parent
> bridge, in fact). So a single static definition doesn't do the job.
>
> Can't we replace this with a seed to the resource tree, defined per host bridge
> in arch-specific code? On PowerMacs, there's a function that scans for known
> host bridges; that code could (either dynamically or based on hardcoded
> knowledge) put the available IO window into some resource of the host bridge
> pci_dev struct. The tree of IO resources could then be built from there.

The PCI resource allocation code allocates from the parent of the device. So I
think it must be possible to put bus-specific resource nodes in between the
general io{port,mem}_resource that covers the whole address space and the
device itself.

My PCI bus (struct pci_bus) shows up as:

    PCI bus c025f5a0
      node.prev = c01578b8 node.next = c01578b8
      parent = 00000000
      children.prev = c025f5ac children.next = c025f5ac
      devices.prev = c025c008 devices.next = c025dc08
      self = 00000000
      resource[] = [
	0: c01412f8 [ I/O 00000000-ffffffff ]
	1: c0141314 [ MEM 00000000-ffffffff ]
      ]
      ops = c014059c sysdata = 00000000 procdir = c05b2540
      number = 0 primary = 0 secondary = 0 subordinate = 0
      vendor/device = 0000:0000
      serial = 0 pnpver = 0 productver = 0 checksum = 0

    Resource c01412f8 PCI IO
      range = 00000000-ffffffff
      flags = 0x00000100 [ IO ]
      parent = 00000000 sibling = 00000000 child = c027dac0
    Resource c0141314 PCI mem
      range = 00000000-ffffffff
      flags = 0x00000200 [ MEM MEM_8BIT ]
      parent = 00000000 sibling = 00000000 child = c025c48c

so the parents of all resources for devices are `PCI IO' and `PCI mem', the
whole address space. If the PCI bus would have resources that contain only the
effective areas for that bus, we can live with the standard

#define PCIBIOS_MIN_IO          0x1000		(10 bit XT ISA I/O space)
#define PCIBIOS_MIN_MEM         0x10000000	(why 256 MB and not 16 MB
						 ISA memory space??)

as on ia32.

So the resources for my PCI bus should be

    I/O 00000000-00ffffff
    MEM c0000000-f6ffffff

If you have two PCI busses, you want to have separate busresources for I/O,
like

    I/O 00000000-00ffffff

for bus 0 and

    I/O 01000000-01ffffff

for bus 1.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
