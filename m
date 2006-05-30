Return-Path: <mostrows@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0940C67B34
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 23:55:01 +1000 (EST)
Subject: Re: [RFC/PATCH 0/8] Overhaul of virt IRQ configuration. / Kill
	ppc64_interrupt_controller.
From: Michal Ostrowski <mostrows@watson.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1148938117.5959.24.camel@localhost.localdomain>
References: <1148935262.25048.31.camel@brick>
	<1148938117.5959.24.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 30 May 2006 09:54:49 -0400
Message-Id: <1148997289.25048.153.camel@brick>
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

On Tue, 2006-05-30 at 07:28 +1000, Benjamin Herrenschmidt wrote:
> Hi ! Interesting.. I've start looking at reworking that with a slightly
> different approach though...
> 
> We need irq controller instances (which we get from the genirq patch
> from Ingo & Thomas Gleixner), and we decided that interrupt controller
> nodes are mandatory in the device-tree thus we can do something like:
> 

The genirq patches were not available until this morning, but now that
I've got them here are some more thought as to what can be done.


> - Each interrupt controller instance, when allocated, requests a certain
> number of interrupts and gets that allocated (gets an offset allocated).
> It can locally use the virtual irq remapping too, I'm still toying with
> the best way to deal with that. This interrupt controller structure is
> associated to the device-node of the controller (or the root node of the
> tree if no controller node is found)

A PIC would not need to reserve anything is when it is allocated.  Only
when interrupt numbers need to be presented to generic kernel code is a
virq number required.

One can use irq_desc->chip_data to easily go from virq -> (PIC, line).
The PIC then maintains an array to map each of it's lines to virq.  
This allows for all re-mappings to always be arbitrary in nature and
still allows for O(1) look-up in either direction.

> 
>  - Interrupt 0..15 are reserved. 0 is always invalid. Only ISA PICs that
> carry legacy devices can request those (by passing a special flag to the
> allocation routine). 

Always create an ISA PIC that immediately requests lines 0..15.
Should one actually exists, we can associate the ISA PIC with the
appropriate device node.  Should ISA devices exist, once they request
interrupts (using (PIC,line) as arguments) we'll short-circuit virq
allocation since all ISA PIC mappings already exists.

Then there's no need to special case anything (and all other interrupts
are forced to be remapped out of the 0..15 range, without an explicit
"offset" concept).


> Any other gets remapped (including powermac MPICs).
> That will avoid endless problems that we never properly solved with
> legacy drivers and the fact that Linus decided that 0 should be the
> invalid interrupt number on all platforms
> 
>  - Provide in prom_parse.c functions for obtaining the PIC node and
> local interrupt number of a given device based on a passed-in array
> matching the semantics of an "interrupts" property and a parent node.
> Along with a helper that may just take a child node. The former is
> needed for PCI devices that have no device node. Provide a
> pci_ppc_map_interrupt() that takes a pci_dev and does the interrupt
> mapping, either by using the standard OF approach if a device-node is
> present, or walking up the PCI tree while doing standard swizzling until
> it reaches a device node

How is this different from the current use of map_interrupt() in
finish_node_interrupts()?  

It seems to me that it would be better to have the struct device_node
store the raw interrupt vector data as presented in the dev tree
(without remapping) along with a pointer to the struct device_node for
the appropriate PIC.

Later on, when we need to provide interrupt lines to the PCI device
structures (e.g. pci_read_irq_line()) we have the PIC and the raw
interrupt vectors identified and we ask the PIC to provide us with a
kernel/virt IRQ.

Deferring the remapping of the interrupt vectors to this later time
should allow for some simplification opportunities. All code that
handles device nodes would not need to deal with offsets or remapping,
only when IRQ information crosses the boundary between powerpc and
generic code would one need to be aware of the need to re-map (i.e.
dev->irq = ??? and ppc_md.get_irq(regs);/ __do_IRQ() interactions ).  
Since arbitrary re-mappings need to be supported, the reservation of
vectors 0..15 can be hidden as a re-mapping implementation detail.
Consequently one could eliminate irq_offset_up() and irq_offset_down()
altogether.


-- 
Michal Ostrowski <mostrows@watson.ibm.com>
