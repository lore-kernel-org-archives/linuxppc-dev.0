From: Michel Lanners <mlan@mcp.cpu.lu>
Message-Id: <200003221024.LAA10024@mcp.cpu.lu>
Subject: Re: LongTrail PCI resource assignment
To: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 22 Mar 2000 11:24:31 MET
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.GSO.4.10.10003220852390.29557-100000@dandelion.sonytel.be>; from "Geert Uytterhoeven" at Mar 22, 100 9:27 am
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Geert,

> I added code to do automatic PCI resource assignment for unassigned resources
> on my CHRP LongTrail. This is experimental, of course.

Cool!

> Notes:
>
>   - There are machine dependent things related to PCI resource assignment,
>     namely PCIBIOS_MIN_IO and PCIBIOS_MIN_MEM in include/asm-ppc/pci.h. On the
>     LongTrail, PCI memory space is from 0xc0000000 until 0xf7000000, so I had
>     to change PCIBIOS_MIN_MEM to make sure allocation starts at 0xc0000000. I
>     think we need
>
> 	#define PCIBIOS_MIN_IO	ppc_md.pcibios_min_io
> 	#define PCIBIOS_MIN_MEM	ppc_md.pcibios_min_mem
>
>     and solve this in the machine specific setup code.

Hmmm.. bad solution. At least on a number of PowerMacs, there are multiple IO
windows, out of which IO resources need to be allocated (depends on the parent
bridge, in fact). So a single static definition doesn't do the job.

Can't we replace this with a seed to the resource tree, defined per host bridge
in arch-specific code? On PowerMacs, there's a function that scans for known
host bridges; that code could (either dynamically or based on hardcoded
knowledge) put the available IO window into some resource of the host bridge
pci_dev struct. The tree of IO resources could then be built from there.

>     Martin, do you think it makes sense to have PCIBIOS_MAX_IO and
>     PCIBIOS_MAX_MEM to pass to allocate_resource() as the upper limits?

I think so; allthough if you are clever at assigning resources, there's little chance you would ever hist the limit.... The reason to have the limit is that:

a. (on PMacs at least) IO windows are defined by the host bridges which map
a certain address range to IO accesses on the subordinate bus

b. mem windows are limited by the memory map of the arch.


Thanks

Michel
______________________________
.sig at home

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
