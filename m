Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hP5W69n3zF2D1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 07:51:43 +1000 (AEST)
Date: Fri, 3 Aug 2018 00:51:34 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Hellwig <hch@infradead.org>, Will Deacon <will.deacon@arm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
 haren@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
 jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180803001818-mutt-send-email-mst@kernel.org>
References: <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
 <20180801081637.GA14438@arm.com>
 <20180801083639.GF26378@infradead.org>
 <26c1d3d50d8e081eed44fe9940fbefed34598cbd.camel@kernel.crashing.org>
 <20180802182959-mutt-send-email-mst@kernel.org>
 <82ccef6ec3d95ee43f3990a4a2d0aea87eb45e89.camel@kernel.crashing.org>
 <20180802200646-mutt-send-email-mst@kernel.org>
 <e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
 <20180802225738-mutt-send-email-mst@kernel.org>
 <de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 02, 2018 at 04:13:09PM -0500, Benjamin Herrenschmidt wrote:
> On Thu, 2018-08-02 at 23:52 +0300, Michael S. Tsirkin wrote:
> > > Yes, this is the purpose of Anshuman original patch (I haven't looked
> > > at the details of the patch in a while but that's what I told him to
> > > implement ;-) :
> > > 
> > >   - Make virtio always use DMA ops to simplify the code path (with a set
> > > of "transparent" ops for legacy)
> > > 
> > >   and
> > > 
> > >   -  Provide an arch hook allowing us to "override" those "transparent"
> > > DMA ops with some custom ones that do the appropriate swiotlb gunk.
> > > 
> > > Cheers,
> > > Ben.
> > > 
> > 
> > Right but as I tried to say doing that brings us to a bunch of issues
> > with using DMA APIs in virtio. Put simply DMA APIs weren't designed for
> > guest to hypervisor communication.
> 
> I'm not sure I see the problem, see below
> 
> > When we do (as is the case with PLATFORM_IOMMU right now) this adds a
> > bunch of overhead which we need to get rid of if we are to switch to
> > PLATFORM_IOMMU by default.  We need to fix that.
> 
> So let's differenciate the two problems of having an IOMMU (real or
> emulated) which indeeds adds overhead etc... and using the DMA API.

Well actually it's the other way around. An iommu in theory doesn't need
to bring overhead if you set it in bypass mode.  Which does imply the
iommu supports bypass mode. Is that universally the case?  DMA API does
see Christoph's list of things it does some of which add overhead.

> At the moment, virtio does this all over the place:
> 
> 	if (use_dma_api)
> 		dma_map/alloc_something(...)
> 	else
> 		use_pa
> 
> The idea of the patch set is to do two, somewhat orthogonal, changes
> that together achieve what we want. Let me know where you think there
> is "a bunch of issues" because I'm missing it:
> 
>  1- Replace the above if/else constructs with just calling the DMA API,
> and have virtio, at initialization, hookup its own dma_ops that just
> "return pa" (roughly) when the IOMMU stuff isn't used.
> 
> This adds an indirect function call to the path that previously didn't
> have one (the else case above). Is that a significant/measurable
> overhead ?

Seems to be :( Jason reports about 4%. I wonder whether we can support
map_sg and friends being NULL, then use that when mapping is an
identity. A conditional branch there is likely very cheap.

Would this cover all platforms with kvm (which is where we care
most about performance)?

> This change stands alone, and imho "cleans" up virtio by avoiding all
> that if/else "2 path" and unless it adds a measurable overhead, should
> probably be done.
> 
>  2- Make virtio use the DMA API with our custom platform-provided
> swiotlb callbacks when needed, that is when not using IOMMU *and*
> running on a secure VM in our case.
> 
> This benefits from -1- by making us just plumb in a different set of
> DMA ops we would have cooked up specifically for virtio in our arch
> code (or in virtio itself but build arch-conditionally in a separate
> file). But it doesn't strictly need it -1-:
> 
> Now, -2- doesn't strictly needs -1-. We could have just done another
> xen-like hack that forces the DMA API "ON" for virtio when running in a
> secure VM.
> 
> The problem if we do that however is that we also then need the arch
> PCI code to make sure it hooks up the virtio PCI devices with the
> special "magic" DMA ops that avoid the iommu but still do swiotlb, ie,
> not the same as other PCI devices. So it will have to play games such
> as checking vendor/device IDs for virtio, checking the IOMMU flag,
> etc... from the arch code which really bloody sucks when assigning PCI
> DMA ops.
> 
> However, if we do it the way we plan here, on top of -1-, with a hook
> called from virtio into the arch to "override" the virtio DMA ops, then
> we avoid the problem completely: The arch hook would only be called by
> virtio if the IOMMU flag is *not* set. IE only when using that special
> "hypervisor" iommu bypass. If the IOMMU flag is set, virtio uses normal
> PCI dma ops as usual.
> 
> That way, we have a very clear semantic: This hook is purely about
> replacing those "null" DMA ops that just return PA introduced in -1-
> with some arch provided specially cooked up DMA ops for non-IOMMU
> virtio that know about the arch special requirements. For us bounce
> buffering.
> 
> Is there something I'm missing ?
> 
> Cheers,
> Ben.

Right so I was trying to write it up in a systematic way, but just to
give you one example, if there is a system where DMA API handles
coherency issues, or flushing of some buffers, then our PLATFORM_IOMMU
flag causes that to happen.

And we kinda worked around this without the IOMMU by basically saying
"ok we do not really need DMA API so let's just bypass it" and
it was kind of ok except now everyone is switching to vIOMMU
just in case. So now people do want some parts of what DMA API does,
such as the bounce buffer use, or IOMMU mappings.

And maybe in the end the solution is going to be to do something similar
to virt_Xmb except for DMA APIs: add APIs that handle just the
addressing bits but without the overhead. See
commit 6a65d26385bf487926a0616650927303058551e3
    asm-generic: implement virt_xxx memory barriers
for reference, it's a similar set of issues.

So it's not a problem with your patches as such, it's just that
they don't solve that harder problem.

-- 
MST
