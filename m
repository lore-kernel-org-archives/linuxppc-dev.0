Date: Thu, 26 Oct 2000 19:23:47 -0700
From: Matt Porter <mporter@mvista.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: mgreer@mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Early PCI auto-configuration
Message-ID: <20001026192347.A12553@cx258813-a.chnd1.az.home.com>
References: <39F8B44B.7980796@mvista.com> <19340920165843.29028@192.168.1.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19340920165843.29028@192.168.1.10>; from bh40@calva.net on Fri, Oct 27, 2000 at 01:26:59AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Oct 27, 2000 at 01:26:59AM +0200, Benjamin Herrenschmidt wrote:
> >My problem:  The firmware on a couple platform I need to support do
> >absolutely _no_ PCI device initialization.

<snip>

> You may also want to look at pci_assign_unassigned_resources() (in
> drivers/pci/setup-res.c) and friends. They do things a bit differently,
> but it might match more closely what you want.

This stuff is the key.  After a good read of alpha's usage of the
setup-res.c, setup-irq.c, and setup-bus.c code I'm really impressed
with how they are using it to accomplish what Mark has been doing
with an autoconfigurator that runs before the first busscan (in 2.2
that was the best solution).

Tracing through arch/alpha/kernel/pci.c around the call to to
pci_assign_unassigned_resources() is a good way to get a feel of
how the generic resource handling code can be used to accomplish
autoconfiguration in a post bus scan way.  It's not as pretty
as doing it right the first time but the code is already there and
easy to hook in to...see following snippet:

	[loop to scan all pci controllers]
        pcibios_size_bridges();
        pci_assign_unassigned_resources();
        pci_fixup_irqs(alpha_mv.pci_swizzle, alpha_mv.pci_map_irq);
        pci_set_bus_ranges();

After doing some PCI bus swizzle routines for the embedded Motorola
boards for 2.2 (prep_pci.c), it's nice to see a generic swizzle
routine that can be passed an irq map to do the dirty work in the
new resources framework.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
