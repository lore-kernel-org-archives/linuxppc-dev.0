Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7877167A5F
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 07:28:47 +1000 (EST)
Subject: Re: [RFC/PATCH 0/8] Overhaul of virt IRQ configuration. / Kill
	ppc64_interrupt_controller.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michal Ostrowski <mostrows@watson.ibm.com>
In-Reply-To: <1148935262.25048.31.camel@brick>
References: <1148935262.25048.31.camel@brick>
Content-Type: text/plain
Date: Tue, 30 May 2006 07:28:36 +1000
Message-Id: <1148938117.5959.24.camel@localhost.localdomain>
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

On Mon, 2006-05-29 at 16:41 -0400, Michal Ostrowski wrote:
> The following set of patches is aimed at killing the
> ppc64_interrupt_controller global variable, and similarly that various
> global variables used to tweak the parameters of virtual IRQ re-mapping.
> Instead each platform can use a single function to configure IRQ
> re-mapping in "init_early()".

 .../...

Hi ! Interesting.. I've start looking at reworking that with a slightly
different approach though...

We need irq controller instances (which we get from the genirq patch
from Ingo & Thomas Gleixner), and we decided that interrupt controller
nodes are mandatory in the device-tree thus we can do something like:

- Each interrupt controller instance, when allocated, requests a certain
number of interrupts and gets that allocated (gets an offset allocated).
It can locally use the virtual irq remapping too, I'm still toying with
the best way to deal with that. This interrupt controller structure is
associated to the device-node of the controller (or the root node of the
tree if no controller node is found)

 - Interrupt 0..15 are reserved. 0 is always invalid. Only ISA PICs that
carry legacy devices can request those (by passing a special flag to the
allocation routine). Any other gets remapped (including powermac MPICs).
That will avoid endless problems that we never properly solved with
legacy drivers and the fact that Linus decided that 0 should be the
invalid interrupt number on all platforms

 - Provide in prom_parse.c functions for obtaining the PIC node and
local interrupt number of a given device based on a passed-in array
matching the semantics of an "interrupts" property and a parent node.
Along with a helper that may just take a child node. The former is
needed for PCI devices that have no device node. Provide a
pci_ppc_map_interrupt() that takes a pci_dev and does the interrupt
mapping, either by using the standard OF approach if a device-node is
present, or walking up the PCI tree while doing standard swizzling until
it reaches a device node

 - Mapping from a virtual number to a local number can be done by a
helper that does the offset and possible virq mapping if requested by
the controller. Same goes with inverse mapping. Mapping is done locally
by the controller code using that helper.

Ben.
