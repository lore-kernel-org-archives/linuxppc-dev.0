Return-Path: <BATV+d706c0dee861f90f12c9+5458+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hf9J0LlpzF12N
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 17:40:51 +1000 (AEST)
Date: Fri, 3 Aug 2018 00:05:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Christoph Hellwig <hch@infradead.org>, Will Deacon <will.deacon@arm.com>,
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
Message-ID: <20180803070507.GA1344@infradead.org>
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
> So let's differenciate the two problems of having an IOMMU (real or
> emulated) which indeeds adds overhead etc... and using the DMA API.
> 
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

If you call it often enough it does:

https://www.spinics.net/lists/netdev/msg495413.html

>  2- Make virtio use the DMA API with our custom platform-provided
> swiotlb callbacks when needed, that is when not using IOMMU *and*
> running on a secure VM in our case.

And total NAK the customer platform-provided part of this.  We need
a flag passed in from the hypervisor that the device needs all bus
specific dma api treatment, and then just use the normal plaform
dma mapping setup.  To get swiotlb you'll need to then use the DT/ACPI
dma-range property to limit the addressable range, and a swiotlb
capable plaform will use swiotlb automatically.
