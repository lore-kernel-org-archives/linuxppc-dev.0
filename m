From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15357.41391.911951.855909@cargo.ozlabs.ibm.com>
Date: Fri, 23 Nov 2001 12:09:03 +1100 (EST)
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Armin Kuster <akuster@mvista.com>,
	ppcdevel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: New API for non cache coherent ppc cpu's
In-Reply-To: <3BFD8F2F.247CDF33@linux-m68k.org>
References: <3BFAB960.DAA72239@mvista.com>
	<15357.26322.107051.143144@cargo.ozlabs.ibm.com>
	<3BFD8F2F.247CDF33@linux-m68k.org>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Roman Zippel writes:

> This document only describes DMA _mappings_, it doesn't say anything
> about cache coherency.

It talks about the conditions under which the cpu and the DMA device
will see a consistent view of memory.  The section on the streaming
DMA mappings could be more explicit, but the idea is that between the
pci_map_{single,sg} and the corresponding pci_unmap_*, the device owns
the region and the cpu shouldn't touch it without first calling
pci_dma_sync_*.  (Hmmm, there is possibly a hole here - the API should
maybe require that you call a sync function both before and after
touching the memory.)  At other times the cpu owns the region and
should see a consistent view of that memory.  That implies some cache
flushing in pci_map_* and/or pci_unmap_* on non-cache-coherent
systems.

> That's the other problem, "non-PCI" sounds like ISA there, what about
> other buses?

That is implementation-dependent.  My view is that we should make this
API work for every kind of bus we have, if possible.

Note also that in 2.5 the struct pci_dev is going to transmogrify into
a "struct device" that will be used for I/O devices on any kind of
bus.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
