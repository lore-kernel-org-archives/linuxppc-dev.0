Return-Path: <mostrows@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C91B767B39
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 08:53:21 +1000 (EST)
Subject: Re: [RFC/PATCH 0/8] Overhaul of virt IRQ configuration. / Kill
	ppc64_interrupt_controller.
From: Michal Ostrowski <mostrows@watson.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1149027185.9986.46.camel@localhost.localdomain>
References: <1148935262.25048.31.camel@brick>
	<1148938117.5959.24.camel@localhost.localdomain>
	<1148997289.25048.153.camel@brick>
	<1149027185.9986.46.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 30 May 2006 18:53:05 -0400
Message-Id: <1149029585.6507.39.camel@brick>
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

On Wed, 2006-05-31 at 08:13 +1000, Benjamin Herrenschmidt wrote:
> > A PIC would not need to reserve anything is when it is allocated.  Only
> > when interrupt numbers need to be presented to generic kernel code is a
> > virq number required.
> 
> We could have completely sparse allocation indeed and any virt number
> matching any PIC but I don't like that too much. Complicates things
> unnecessarily don't you think ? I like irq numbers to be somewhat stable
> on a given platform :) Helps debugging & diagnosing problems...
> 

The fact that the allocation may be sparse does not mean it actually
will be.  As long as code expects arbitrary remappings it will have a
degree of robustness; but that does not mean that the mechanism by which
remappings are done cannot instantiate simple mappings.  In other words,
I'd like to see the concept of "irq offsets" being banished, but having
re-mapping code be smart enough so that, for example, an MPIC that must
deal with interrupt vectors 0..127 has these vectors made visible to the
system at 16..143.

I think that the current virt irq remapping algorithm would provide you
with exactly this behavior.


> > One can use irq_desc->chip_data to easily go from virq -> (PIC, line).
> > The PIC then maintains an array to map each of it's lines to virq.  
> > This allows for all re-mappings to always be arbitrary in nature and
> > still allows for O(1) look-up in either direction.
> 
> I'll think about it, but I'm really tempted to keep simple ranges for
> now... we'll see.
> 
> > >  - Interrupt 0..15 are reserved. 0 is always invalid. Only ISA PICs that
> > > carry legacy devices can request those (by passing a special flag to the
> > > allocation routine). 
> > 


> > > Any other gets remapped (including powermac MPICs).
> > > That will avoid endless problems that we never properly solved with
> > > legacy drivers and the fact that Linus decided that 0 should be the
> > > invalid interrupt number on all platforms
> > > 
> > >  - Provide in prom_parse.c functions for obtaining the PIC node and
> > > local interrupt number of a given device based on a passed-in array
> > > matching the semantics of an "interrupts" property and a parent node.
> > > Along with a helper that may just take a child node. The former is
> > > needed for PCI devices that have no device node. Provide a
> > > pci_ppc_map_interrupt() that takes a pci_dev and does the interrupt
> > > mapping, either by using the standard OF approach if a device-node is
> > > present, or walking up the PCI tree while doing standard swizzling until
> > > it reaches a device node
> > 
> > How is this different from the current use of map_interrupt() in
> > finish_node_interrupts()?  
> 
> Slightly... basically cleaned up version of it.
> 
> > It seems to me that it would be better to have the struct device_node
> > store the raw interrupt vector data as presented in the dev tree
> > (without remapping) along with a pointer to the struct device_node for
> > the appropriate PIC.
> 
> I don't understand what you have in mind. Remember we are working with
> cases where devices may not have a node. There is no such thing as "an
> interrupt == a node" anyway. Beside, I want to _remove_ anything in
> struct device_node that isn't specifically the node linkage and property
> list. All the pre-parsed junk has to go.
> 

In cases where we have a struct device_node, the struct device_node
should have a pointer to the PIC (or the PIC's device_node), and the
raw, unmodified interrupt line values.   When one wants to present an
irq to generic code, we use the (PIC,line) information from the
device_node to instantiate a virq.

If there is no struct device_node, you still have to come up with a
(PIC,line) pair in order to get a virq.

virt_irq_create_mapping() (or whatever replaces it) should take the
physical line and a PIC identifier/pointer as arguments so that it can
inform the PIC about a mapping it has instantiated (in case we really
have to make an arbitrary re-mapping) and so that it can try to
instantiate an identity or offset-only translation if possible.  In the
latter case, the PIC object will tell the remapper what offset range to
use.


> I'm not sure how your scheme differs from what I have in mind at this
> point except from the fact that you'll shuffle interrupt numbers way
> more than I intend to. I suppose it _might_ be simpler to go through the
> virt irq remapper once rather than having both a set of ranges +
> eventually the remapper, and I've thought about using the remapper for
> everything too, but I'd still like to keep the concept of ranges, thus
> I'm tempted to still allocate all irqs for a given controller
> continuously in the remapper when instanciating the PIC rather than when
> actually looking for IRQs....

I think our thoughts on this differ only on the aspect of whether the
remapper is considered to be an arbitrary remapper, a smart
implementation of which results in IRQ being remapped via offsets,
versus multi-level remapping, with offsets first followed by arbitrary
remappings as necessary (and the distinction between offsets and
arbitrary remapping being visible beyond the remapper function).


-- 
Michal Ostrowski <mostrows@watson.ibm.com>
