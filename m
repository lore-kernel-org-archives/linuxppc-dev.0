Date: Wed, 17 Jul 2002 11:24:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: consistent_alloc() revisited
Message-ID: <20020717012442.GA22786@zax>
References: <20020716021313.GQ22786@zax> <3D3428FF.5090401@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D3428FF.5090401@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jul 16, 2002 at 10:09:03AM -0400, Dan Malek wrote:
>
> David Gibson wrote:
>
> >In addition, the following seem to me like desirable (to a greater or
> >lesser extent) properties for consistent_alloc():
> >	a. one of the return values can be used as a single "handle"
> >so that consistent_free() only needs one parameter.
>
> We want the implementation API to be identical across all architectures.
> Until there is a consistent way of handling devices that are on local
> processor busses, platforms with these types of devices may call these
> functions directly.    This is particularly true of some host USB
> controllers
> on embedded systems that don't have PCI busses.

Well, the unified device tree stuff should give us that.

> >	b. works on both cache coherent and non cache coherent
> >machines
>
> The original purpose of the consistent_* functions was to provide support
> for processors that aren't cache coherent.  The pci_* (and any other
> functions)
> can call these if appropriate, but I still believe the decision should  be
> made at a higher level.  Obviously, these consistent_* functions will
> be implemented differently on non- or cache coherent processors, and across
> different architectures.  The PCI functions (or others) should still do
> their
> thing as they always have, and call these consistent_* functions when
> appropriate.

I know that's their original purpose, but it's *really easy* to make
consistent_* work on cache coherent chips too, so why not do it.
It'll make our life easier when we get an OCP device appearing on a
cache coherent chip.

> >	c. be able to use highmem pages
>
> You think there will be non-coherent processors with this much memory? :-)

I think it's possible, yes.

> >-	if (in_interrupt())
> >-		BUG();
> >+	BUG_ON(in_interrupt());
>
> We should be able to call these functions from interrupt, let's push
> the remainder of the changes though get_free_pages() to make this happen.

As far as I can tell there's no problem with get_free_pages() (or
rather, alloc_pages()), except that we need to add GFP_ATOMIC to the
flags if we're in interrupt context.

The problems are in get_vm_area() which does a kmalloc() without
GFP_ATOMIC and in map_page() which can sleep.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
