Date: Wed, 12 Jun 2002 13:52:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddededge.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: First cut at large page support on 40x
Message-ID: <20020612035203.GQ25800@zax>
References: <20020531042153.GD16537@zax> <3CFC0D3F.9030901@embeddededge.com> <20020604035947.GH2762@zax> <3CFCFC20.80101@embeddededge.com> <15614.37065.549142.218906@argo.ozlabs.ibm.com> <3CFEE9A3.5060300@embeddededge.com> <15614.63160.272890.683586@argo.ozlabs.ibm.com> <3CFF1624.2070808@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CFF1624.2070808@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 06, 2002 at 03:58:28AM -0400, Dan Malek wrote:
>
> Paul Mackerras wrote:
>
> >.... I didn't think we were getting "there"
> >(i.e. towards having a device tree) at all yet on systems without OF
> >though.
>
> It was one of the first things Ben and I discussed long ago before
> this bi_rec stuff appeared.  We were just going to have the bootloaders
> build OF-like device tree........and I'll just stop that discussion
> right here :-)

So what happened to the idea?

> >....  The reason for that is that every other architecture
> >restricts the use of virt_to_phys/bus to addresses that are part of
> >the kernel mapping of lowmem,
>
> I know, and I've been exposed to operating systems that have emerged
> from this primitive state long ago :-)  It's hard to go back to early-80's
> designs :-)

That isn't of itself an argument.  I haven't yet seen a case where
extending virt_to_phys() to non-lowmem addresses is useful.  In any
case I've so far thought of there are other considerations which make
the benefits of having a common interface illusory.

> >.... If a driver uses
> >consistent_alloc or pci_alloc_consistent, the driver should save and
> >use the physical address returned by those functions.
>
> But, that's a relatively new addition and the support of these functions
> in a non cache coherent system requires the use of something like iopa().
> We allocate a contiguous virtual space to remap the pages we wish to
> change cache attributes.  We can't find the physical addresses associated
> with these pages unless we search the page tables.  Prior to having
> consistent_* we had to do this behind the curtains and needed iopa() to
> get the proper mapping result.

Not only is that wrong, it's bloody obviously wrong.  How could we
create a new virtual mapping without knowing the physical addresses
first.

> >.....  Ideally we
> >would have analogous routines to pci_[un]map_single for the on-chip
> >devices.
>
> I agree, but it doesn't remove the lower level requirement of searching
> page tables.

No.  Where is the memory this is to be used on coming except from
kmalloc() in which case just subtracting KERNELBASE is sufficient.  We
can't use vmalloc()ed memory anyway, because it wouldn't be physically
contiguous.

> >Do you have other situations in mind (other than debugging-type
> >things) where you need to use virt_to_phys/bus on something that isn't
> >a lowmem address?
>
> I just think Linux should at least move into the last decade and have
> standard methods for managing memory regardless of how it is allocated or
> where it is located :-)  The consistent_* functions have removed the need
> for drivers to search out mappings on their own, so I don't see the need
> for this function outside of supporting the consistent_* functions.

And it isn't needed in consistent_*(), so where is it needed at all?

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
