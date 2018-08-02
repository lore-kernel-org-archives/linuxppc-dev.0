Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hNGS6PT2zF2D1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 07:14:24 +1000 (AEST)
Message-ID: <de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Will Deacon <will.deacon@arm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
 haren@linux.vnet.ibm.com, paulus@samba.org, srikar@linux.vnet.ibm.com,
 robin.murphy@arm.com, jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Date: Thu, 02 Aug 2018 16:13:09 -0500
In-Reply-To: <20180802225738-mutt-send-email-mst@kernel.org>
References: <20180730155633-mutt-send-email-mst@kernel.org>
 <20180731173052.GA17153@infradead.org>
 <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
 <20180801081637.GA14438@arm.com> <20180801083639.GF26378@infradead.org>
 <26c1d3d50d8e081eed44fe9940fbefed34598cbd.camel@kernel.crashing.org>
 <20180802182959-mutt-send-email-mst@kernel.org>
 <82ccef6ec3d95ee43f3990a4a2d0aea87eb45e89.camel@kernel.crashing.org>
 <20180802200646-mutt-send-email-mst@kernel.org>
 <e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
 <20180802225738-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-08-02 at 23:52 +0300, Michael S. Tsirkin wrote:
> > Yes, this is the purpose of Anshuman original patch (I haven't looked
> > at the details of the patch in a while but that's what I told him to
> > implement ;-) :
> > 
> >   - Make virtio always use DMA ops to simplify the code path (with a set
> > of "transparent" ops for legacy)
> > 
> >   and
> > 
> >   -  Provide an arch hook allowing us to "override" those "transparent"
> > DMA ops with some custom ones that do the appropriate swiotlb gunk.
> > 
> > Cheers,
> > Ben.
> > 
> 
> Right but as I tried to say doing that brings us to a bunch of issues
> with using DMA APIs in virtio. Put simply DMA APIs weren't designed for
> guest to hypervisor communication.

I'm not sure I see the problem, see below

> When we do (as is the case with PLATFORM_IOMMU right now) this adds a
> bunch of overhead which we need to get rid of if we are to switch to
> PLATFORM_IOMMU by default.  We need to fix that.

So let's differenciate the two problems of having an IOMMU (real or
emulated) which indeeds adds overhead etc... and using the DMA API.

At the moment, virtio does this all over the place:

	if (use_dma_api)
		dma_map/alloc_something(...)
	else
		use_pa

The idea of the patch set is to do two, somewhat orthogonal, changes
that together achieve what we want. Let me know where you think there
is "a bunch of issues" because I'm missing it:

 1- Replace the above if/else constructs with just calling the DMA API,
and have virtio, at initialization, hookup its own dma_ops that just
"return pa" (roughly) when the IOMMU stuff isn't used.

This adds an indirect function call to the path that previously didn't
have one (the else case above). Is that a significant/measurable
overhead ?

This change stands alone, and imho "cleans" up virtio by avoiding all
that if/else "2 path" and unless it adds a measurable overhead, should
probably be done.

 2- Make virtio use the DMA API with our custom platform-provided
swiotlb callbacks when needed, that is when not using IOMMU *and*
running on a secure VM in our case.

This benefits from -1- by making us just plumb in a different set of
DMA ops we would have cooked up specifically for virtio in our arch
code (or in virtio itself but build arch-conditionally in a separate
file). But it doesn't strictly need it -1-:

Now, -2- doesn't strictly needs -1-. We could have just done another
xen-like hack that forces the DMA API "ON" for virtio when running in a
secure VM.

The problem if we do that however is that we also then need the arch
PCI code to make sure it hooks up the virtio PCI devices with the
special "magic" DMA ops that avoid the iommu but still do swiotlb, ie,
not the same as other PCI devices. So it will have to play games such
as checking vendor/device IDs for virtio, checking the IOMMU flag,
etc... from the arch code which really bloody sucks when assigning PCI
DMA ops.

However, if we do it the way we plan here, on top of -1-, with a hook
called from virtio into the arch to "override" the virtio DMA ops, then
we avoid the problem completely: The arch hook would only be called by
virtio if the IOMMU flag is *not* set. IE only when using that special
"hypervisor" iommu bypass. If the IOMMU flag is set, virtio uses normal
PCI dma ops as usual.

That way, we have a very clear semantic: This hook is purely about
replacing those "null" DMA ops that just return PA introduced in -1-
with some arch provided specially cooked up DMA ops for non-IOMMU
virtio that know about the arch special requirements. For us bounce
buffering.

Is there something I'm missing ?

Cheers,
Ben.
