From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15614.63160.272890.683586@argo.ozlabs.ibm.com>
Date: Thu, 6 Jun 2002 15:44:24 +1000 (EST)
To: Dan Malek <dan@embeddededge.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: First cut at large page support on 40x
In-Reply-To: <3CFEE9A3.5060300@embeddededge.com>
References: <20020531042153.GD16537@zax>
	<3CFC0D3F.9030901@embeddededge.com>
	<20020604035947.GH2762@zax>
	<3CFCFC20.80101@embeddededge.com>
	<15614.37065.549142.218906@argo.ozlabs.ibm.com>
	<3CFEE9A3.5060300@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:

> When did I ever complain about a device tree?  I think it's the right
> idea, I just didn't like the way we were getting there on systems
> that don't have OF.

OK, that's cool then.  I didn't think we were getting "there"
(i.e. towards having a device tree) at all yet on systems without OF
though.  In 2.5 the devicefs stuff may yet give us an acceptable
unification.

> What isn't needed?  The page tables or the iopa()?  I'm tired of having

The page table pages aren't needed and are a pain for large-page
entries on 4xx since the pmd is already largely occupied with the
physical base address and other bits.

As for iopa(), what I mainly don't like is its use in virt_to_phys and
virt_to_bus.  The reason for that is that every other architecture
restricts the use of virt_to_phys/bus to addresses that are part of
the kernel mapping of lowmem, which means that they become very
simple.  Using iopa() in virt_to_* is just going to tempt us to use
them on other sorts of addresses, which will make our drivers less
portable.

Instead I think that we should only use virt_to_* on addresses that
are part of the kernel mapping of lowmem.  If a driver uses
consistent_alloc or pci_alloc_consistent, the driver should save and
use the physical address returned by those functions.  Ideally we
would have analogous routines to pci_[un]map_single for the on-chip
devices.  With that, I think there would be very few legitimate
reasons for a driver to need to use virt_to_* directly at all.

> different methods to look up VM information just because the memory
> was allocated in a different way.  With iopa() (which seems fine for
> other architectures to use) I don't care how the memory was allocated,
> I just feed it a virtual address and get the answer.  What's wrong with
> that (other than it's not a hack :-)?  The page tables have always

Well, if what you fed it was obtained from vmalloc, and you don't deal
explicitly with the fact that vmalloc'd memory is not physically
contiguous, you are in danger of DMA'ing into some random page
somewhere and corrupting it.  If what you feed it is a user address
and you start some DMA into it, you have in addition to the physical
discontiguity the fact that the page might get taken away from the
process and used for something else before the DMA finishes.

So in general if you want an address for doing DMA, virt_to_bus is
really only safe on kernel addresses (i.e. addresses that are within
the kernel mapping of lowmem).

Do you have other situations in mind (other than debugging-type
things) where you need to use virt_to_phys/bus on something that isn't
a lowmem address?

> been there, and it's not a big deal.  Why haven't we done the same
> hack for processors with BATs?  They don't need the page tables either.

True. :)

> I also stated the importance of the page tables is to allow background
> hardware debuggers to look up translations so they can work with Linux.
> Kind of a nice thing to have once in a while.

That's reasonable.

> I find a simple solution for an enhancement and you don't like it because
> it isn't a big hacked up mess (or maybe because I had an original thought).

I don't see a lot of value in doing things differently from all the
other architectures in this instance, and I think that restricting
virt_to_bus/phys to lowmem addresses is reasonable.  I don't mind if
iopa() stays around for a few specialized uses.

> If I would have made the same hacked up mess you have done it wouldn't have
> been checked in.....not long ago all of the embedded stuff was viewed as a
> problem child, and today it's OK to hack up generic code with an #ifdef

Viewed as a problem child?  By whom?

> for a specific IBM embedded processor????  Does that surprise you? :-)

You know I hate ifdefs. :)

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
