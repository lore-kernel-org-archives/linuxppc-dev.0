Message-ID: <3D06E702.4000709@embeddededge.com>
Date: Wed, 12 Jun 2002 02:15:30 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: First cut at large page support on 40x
References: <20020531042153.GD16537@zax> <3CFC0D3F.9030901@embeddededge.com> <20020604035947.GH2762@zax> <3CFCFC20.80101@embeddededge.com> <15614.37065.549142.218906@argo.ozlabs.ibm.com> <3CFEE9A3.5060300@embeddededge.com> <15614.63160.272890.683586@argo.ozlabs.ibm.com> <3CFF1624.2070808@embeddededge.com> <20020612035203.GQ25800@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> So what happened to the idea?

Never got implemented, I guess.  Lots of things are discussed that
people just don't have time to do.


> That isn't of itself an argument.  I haven't yet seen a case where
> extending virt_to_phys() to non-lowmem addresses is useful.  In any
> case I've so far thought of there are other considerations which make
> the benefits of having a common interface illusory.

Let's just say it's nice to have designs that have common functional
interfaces.  The Linux VM is one old hack on top of another, and inserting
something like iopa() under virt_to_* is just the same.  As systems and
memory sizes grew, the functions to support them didn't for a variety of
reasons.  These problems have all been nicely solved long ago, and some
of us were around back then to appreciate the nice solutions :-)


> Not only is that wrong, it's bloody obviously wrong.  How could we
> create a new virtual mapping without knowing the physical addresses
> first.

Oh, cool down and just think about this for a moment.  All of this was
done to support noncoherent caches where we allocate some VM space to
remap pages with different cache attributes.  Everything that does
DMA expects to use virt_to_* functions to find the physical address.
Of course we know the physical address, but functions using the standard
pci_consistent_* don't know them.  To support PCI on noncoherent cache
processors you have to be able to find the physical address from the
virtual one, and just an arithmetic operation on the virtual address
won't work on these processors.  It's just the way these functions are
designed to work in Linux.  It's obviously the only way to make it work
with the way the higher level functions are designed.

> ..... We
> can't use vmalloc()ed memory anyway, because it wouldn't be physically
> contiguous.

Ummmm....we do use vmalloc()'ed (sort of) memory anyway.  We grab a set
of physical pages and then map them to a new vm_area.  Just what vmalloc()
does, except we do it so it is contiguous.

> And it isn't needed in consistent_*(), so where is it needed at all?

It's needed at the higher level of PCI and DMA functions that are simply
given virtual addresses and need to find the physical page(s) associated.

	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
