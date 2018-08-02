Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hMn06R9yzF2D1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 06:52:20 +1000 (AEST)
Date: Thu, 2 Aug 2018 23:52:10 +0300
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
Message-ID: <20180802225738-mutt-send-email-mst@kernel.org>
References: <20180730155633-mutt-send-email-mst@kernel.org>
 <20180731173052.GA17153@infradead.org>
 <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
 <20180801081637.GA14438@arm.com>
 <20180801083639.GF26378@infradead.org>
 <26c1d3d50d8e081eed44fe9940fbefed34598cbd.camel@kernel.crashing.org>
 <20180802182959-mutt-send-email-mst@kernel.org>
 <82ccef6ec3d95ee43f3990a4a2d0aea87eb45e89.camel@kernel.crashing.org>
 <20180802200646-mutt-send-email-mst@kernel.org>
 <e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 02, 2018 at 12:53:41PM -0500, Benjamin Herrenschmidt wrote:
> On Thu, 2018-08-02 at 20:19 +0300, Michael S. Tsirkin wrote:
> > 
> > I see. So yes, given that device does not know or care, using
> > virtio features is an awkward fit.
> > 
> > So let's say as a quick fix for you maybe we could generalize the
> > xen_domain hack, instead of just checking xen_domain check some static
> > branch.  Then teach xen and others to enable that.>
> 
> > OK but problem then becomes this: if you do this and virtio device appears
> > behind a vIOMMU and it does not advertize the IOMMU flag, the
> > code will try to use the vIOMMU mappings and fail.
> >
> > It does look like even with trick above, you need a special version of
> > DMA ops that does just swiotlb but not any of the other things DMA API
> > might do.
> > 
> > Thoughts?
> 
> Yes, this is the purpose of Anshuman original patch (I haven't looked
> at the details of the patch in a while but that's what I told him to
> implement ;-) :
> 
>  - Make virtio always use DMA ops to simplify the code path (with a set
> of "transparent" ops for legacy)
> 
>  and
> 
>  -  Provide an arch hook allowing us to "override" those "transparent"
> DMA ops with some custom ones that do the appropriate swiotlb gunk.
> 
> Cheers,
> Ben.
> 

Right but as I tried to say doing that brings us to a bunch of issues
with using DMA APIs in virtio. Put simply DMA APIs weren't designed for
guest to hypervisor communication.

When we do (as is the case with PLATFORM_IOMMU right now) this adds a
bunch of overhead which we need to get rid of if we are to switch to
PLATFORM_IOMMU by default.  We need to fix that.

-- 
MST
