From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15623.56859.381319.347724@argo.ozlabs.ibm.com>
Date: Thu, 13 Jun 2002 09:49:47 +1000 (EST)
To: Dan Malek <dan@embeddededge.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: First cut at large page support on 40x
In-Reply-To: <3D06E702.4000709@embeddededge.com>
References: <20020531042153.GD16537@zax>
	<3CFC0D3F.9030901@embeddededge.com>
	<20020604035947.GH2762@zax>
	<3CFCFC20.80101@embeddededge.com>
	<15614.37065.549142.218906@argo.ozlabs.ibm.com>
	<3CFEE9A3.5060300@embeddededge.com>
	<15614.63160.272890.683586@argo.ozlabs.ibm.com>
	<3CFF1624.2070808@embeddededge.com>
	<20020612035203.GQ25800@zax>
	<3D06E702.4000709@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:

> Oh, cool down and just think about this for a moment.  All of this was
> done to support noncoherent caches where we allocate some VM space to
> remap pages with different cache attributes.  Everything that does
> DMA expects to use virt_to_* functions to find the physical address.

Well no.  Drivers shouldn't need to use virt_to_* at all.

> Of course we know the physical address, but functions using the standard
> pci_consistent_* don't know them.  To support PCI on noncoherent cache
> processors you have to be able to find the physical address from the
> virtual one, and just an arithmetic operation on the virtual address
> won't work on these processors.  It's just the way these functions are
> designed to work in Linux.  It's obviously the only way to make it work
> with the way the higher level functions are designed.

Using the pci_* functions as a model, you have two ways to do things.
The first is to use pci_alloc_consistent.  It internally gets some
pages of lowmem and, if necessary, maps them cache-inhibited somewhere
and returns both the virtual and bus addresses to the driver.  The
driver gives the bus address to the device and uses the virtual
address itself and everyone is happy.

The second is to use pci_map_single/pci_unmap_single and friends.  The
*_single variants work on lowmem, the *_page variants work on any page
of memory.  You do a pci_map_* and get back a bus address that you
give to the device.  It does its DMA, you call pci_unmap_* and then
you can access the buffer again.  With this variant the buffer doesn't
need to be remapped cache-inhibited.  Since the buffer is either
lowmem or specified by its struct page *, working out its physical
address is trivial.  In no case do we need to go chasing through page
tables to find it.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
