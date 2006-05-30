Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 00E4767B36
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 08:13:12 +1000 (EST)
Subject: Re: [RFC/PATCH 0/8] Overhaul of virt IRQ configuration. / Kill
	ppc64_interrupt_controller.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michal Ostrowski <mostrows@watson.ibm.com>
In-Reply-To: <1148997289.25048.153.camel@brick>
References: <1148935262.25048.31.camel@brick>
	<1148938117.5959.24.camel@localhost.localdomain>
	<1148997289.25048.153.camel@brick>
Content-Type: text/plain
Date: Wed, 31 May 2006 08:13:05 +1000
Message-Id: <1149027185.9986.46.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> A PIC would not need to reserve anything is when it is allocated.  Only
> when interrupt numbers need to be presented to generic kernel code is a
> virq number required.

We could have completely sparse allocation indeed and any virt number
matching any PIC but I don't like that too much. Complicates things
unnecessarily don't you think ? I like irq numbers to be somewhat stable
on a given platform :) Helps debugging & diagnosing problems...

> One can use irq_desc->chip_data to easily go from virq -> (PIC, line).
> The PIC then maintains an array to map each of it's lines to virq.  
> This allows for all re-mappings to always be arbitrary in nature and
> still allows for O(1) look-up in either direction.

I'll think about it, but I'm really tempted to keep simple ranges for
now... we'll see.

> >  - Interrupt 0..15 are reserved. 0 is always invalid. Only ISA PICs that
> > carry legacy devices can request those (by passing a special flag to the
> > allocation routine). 
> 
> Always create an ISA PIC that immediately requests lines 0..15.

Well, if we use your suggested "sparse" allocation method, then yes, we
need to request them right away before anything else. But I'd like to
start with the range allocation in which case simply reserving that
range for use by whatever PIC says "I'm the legacy ISA PIC" is enough.

> Should one actually exists, we can associate the ISA PIC with the
> appropriate device node.  Should ISA devices exist, once they request
> interrupts (using (PIC,line) as arguments) we'll short-circuit virq
> allocation since all ISA PIC mappings already exists.

I'm not sure I understand there. ISA devices don't "request interrupts
using (PCI,line)" or whatever... we don't necessarily know in advance.
Part of the reasoning here is to also make sure that if no ISA PIC
allocated 0...15 then a stupid legacy driver loaded by the user will
fail it's call to request_irq()

> Then there's no need to special case anything (and all other interrupts
> are forced to be remapped out of the 0..15 range, without an explicit
> "offset" concept).

/me is a bit dubious...

> > Any other gets remapped (including powermac MPICs).
> > That will avoid endless problems that we never properly solved with
> > legacy drivers and the fact that Linus decided that 0 should be the
> > invalid interrupt number on all platforms
> > 
> >  - Provide in prom_parse.c functions for obtaining the PIC node and
> > local interrupt number of a given device based on a passed-in array
> > matching the semantics of an "interrupts" property and a parent node.
> > Along with a helper that may just take a child node. The former is
> > needed for PCI devices that have no device node. Provide a
> > pci_ppc_map_interrupt() that takes a pci_dev and does the interrupt
> > mapping, either by using the standard OF approach if a device-node is
> > present, or walking up the PCI tree while doing standard swizzling until
> > it reaches a device node
> 
> How is this different from the current use of map_interrupt() in
> finish_node_interrupts()?  

Slightly... basically cleaned up version of it.

> It seems to me that it would be better to have the struct device_node
> store the raw interrupt vector data as presented in the dev tree
> (without remapping) along with a pointer to the struct device_node for
> the appropriate PIC.

I don't understand what you have in mind. Remember we are working with
cases where devices may not have a node. There is no such thing as "an
interrupt == a node" anyway. Beside, I want to _remove_ anything in
struct device_node that isn't specifically the node linkage and property
list. All the pre-parsed junk has to go.

> Later on, when we need to provide interrupt lines to the PCI device
> structures (e.g. pci_read_irq_line()) we have the PIC and the raw
> interrupt vectors identified and we ask the PIC to provide us with a
> kernel/virt IRQ.

Yah, well, in order to have the PIC and the raw IRQ identified, we have
to do the algorithm I described :) Not sure how your scheme differs
except maybe by putting things in the device node itself... We do have a
void * there though we can use for non-PCI devices, thus if the PIC node
is always guaranteed _not_ to be a PCI device, we can use that to get
the PIC quickly but old MPICs are PCI devices afaik, and beside, that is
not a performance critical path.

> Deferring the remapping of the interrupt vectors to this later time
> should allow for some simplification opportunities. All code that
> handles device nodes would not need to deal with offsets or remapping,

I still don't see what you mean here.... the only things that has to
deal with offset and/or remapping are the PIC code itself when it gets
called with virtual numbers and the binding of a device to an irq when
going from the raw number to the virtual number.

> only when IRQ information crosses the boundary between powerpc and
> generic code would one need to be aware of the need to re-map (i.e.
> dev->irq = ??? and ppc_md.get_irq(regs);/ __do_IRQ() interactions ).  
> Since arbitrary re-mappings need to be supported, the reservation of
> vectors 0..15 can be hidden as a re-mapping implementation detail.
> Consequently one could eliminate irq_offset_up() and irq_offset_down()
> altogether.

I'm not sure how your scheme differs from what I have in mind at this
point except from the fact that you'll shuffle interrupt numbers way
more than I intend to. I suppose it _might_ be simpler to go through the
virt irq remapper once rather than having both a set of ranges +
eventually the remapper, and I've thought about using the remapper for
everything too, but I'd still like to keep the concept of ranges, thus
I'm tempted to still allocate all irqs for a given controller
continuously in the remapper when instanciating the PIC rather than when
actually looking for IRQs....

Ben.
