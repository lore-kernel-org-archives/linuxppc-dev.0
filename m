Message-ID: <3BFD8520.5060105@embeddededge.com>
Date: Thu, 22 Nov 2001 18:07:12 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: Armin Kuster <akuster@mvista.com>,
	ppcdevel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: New API for non cache coherent ppc cpu's
References: <3BFAB960.DAA72239@mvista.com> <15357.26322.107051.143144@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:


> If we have to have a consistent_sync_page, it should be purely a local
> function in our implementation of the official DMA mapping API - see
> Documentation/DMA-mapping.txt.

That's exactly what it is.  We are not creating a new API, and it shouldn't
have been described as such.

> ....  Drivers should be using functions such
> as pci_alloc_consistent, pci_map_single, pci_dma_sync_single,
> pci_unmap_single, etc.  The implementation of those routines should do
> the correct cache flushing - if it doesn't then we need to fix it.

They do.  Recently a pci_sync_page was added for some reason (because
Linux doesn't have a real VM implementation I guess :-).  We just needed
to add the underlying function to support it.  I think it popped up in
one of the SCSI drivers.

> If you're talking about non-PCI devices, use the pci DMA API but just
> pass NULL for the dev (we need to make sure that will work ok on the
> non-cache-coherent cpus).

Ummm....I don't normally do this because using these functions requires
the CONFIG_PCI option, which isn't supported or has bad effects when
requested on processors that don't have PCI.  For non-PCI devices,
I call the consistent_* functions, which other architectures support
and do as well.  So, we kind of have a common interface here for non-PCI
devices as well.

I stole all of this cache coherency stuff from ARM and Sparc (or MIPS,
I don't remember) when I did it the first time.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
