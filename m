Message-ID: <3BB38008.39A3F149@we.mediaone.net>
Date: Thu, 27 Sep 2001 12:37:44 -0700
From: Dan Taylor <danieltaylor@we.mediaone.net>
Reply-To: danieltaylor@acm.org
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Adding 'bus_offset' to pci_controller
References: <200109271310.JAA20256@missioncriticallinux.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The bus number refers to the segment of PCI between bridges (host
PCI-PCI, or other) or attached to a single bridge; multiple host
bridges are referenced although I have never tried it.  So, from
your host bridge, for example the embedded MPC107 in an '8240, there
are four Ethernet devices, an IDE interface, and a PCI-PCI bridge,
and then there are two Fibre Channel devices attached to the PCI-
PCI bridge.  There will be two pci_bus structures, one for the PCI
bus from the host bridge to the PCI-PCI bridge, which should be bus
number 0, and another for the PCI bus on the "other" side of the
PCI-PCI bridge, which should be number 1.  All the Ethernet devices'
AND the PCI-PCI bridge's pci_dev structures will point to the
HOST BRIDGE pci_bus structure; the Fibre Channel devices will point
to a pci_bus structure associated with the PCI-PCI bridge.

Even if you have non-standard bridges, this works; I have used an
Intel 21554 in configurations where a card is sometimes the system
controller (assigner of PCI addresses for all of the other devices)
and sometimes not.

The routines for reading/writing configuration space, assigning
addresses, AND converting PCI addresses <-> CPU addresses have to
encapsulate the "magic" knowledge of the hardware configuration
to allow drivers to be portable across different implementations.

If you have hardware with offsets, then encode that in the bus_to_virt
conversion routine.  Set up tables in
arch/ppc/kernel/<your_implementation>.c,
if you have to; even with multiple host bridges, there should be NO
duplicated PCI addresses on different PCI busses, even though the
spec' allows it.  We HAVE the source; we CONTROL the address assignments;
even if you have offsets (as the 21554 does), don't replicate addresses.
Use only part of the available address space on each bus and use some
of the upper bits as tags so bus_to_virt, etc. can uniquely identify the
bus from the address and provide the correct response.


mod+linuxppc-embedded@MissionCriticalLinux.com wrote:
>
> I'm just catching up with this thread and I'm
> not sure which problem it is that we're trying
> to solve here.  Isn't it true that the various
> pci_ops routines are passed a pci_dev from which
> they can extract pci_dev->pci_bus->number and
> decide which bus is meant from that?  Or does
> that constitute a namespace (or number-space)
> collision?  Aha - yes it might - each "node" in
> a PCI bus "tree" has its own bus number, right?
> So pci_dev->pci_bus->number is only intended to
> be meaningful within a given tree and each tree
> is (should be) its own domain...
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
