Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411rZd6jXlzF34J
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 02:28:41 +1000 (AEST)
Date: Thu, 7 Jun 2018 19:28:35 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>, robh@kernel.org, aik@ozlabs.ru,
 jasowang@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, joe@perches.com,
 linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net,
 david@gibson.dropbear.id.au, cohuck@redhat.com, pawel.moll@arm.com,
 Tom Lendacky <thomas.lendacky@amd.com>,
 "Rustad, Mark D" <mark.d.rustad@intel.com>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180607185234-mutt-send-email-mst@kernel.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <20180524072104.GD6139@ram.oc3035372033.ibm.com>
 <0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
 <20180531204320-mutt-send-email-mst@kernel.org>
 <20180607052306.GA1532@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180607052306.GA1532@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 06, 2018 at 10:23:06PM -0700, Christoph Hellwig wrote:
> On Thu, May 31, 2018 at 08:43:58PM +0300, Michael S. Tsirkin wrote:
> > Pls work on a long term solution. Short term needs can be served by
> > enabling the iommu platform in qemu.
> 
> So, I spent some time looking at converting virtio to dma ops overrides,
> and the current virtio spec, and the sad through I have to tell is that
> both the spec and the Linux implementation are complete and utterly fucked
> up.

Let me restate it: DMA API has support for a wide range of hardware, and
hardware based virtio implementations likely won't benefit from all of
it.

And given virtio right now is optimized for specific workloads, improving
portability without regressing performance isn't easy.

I think it's unsurprising since it started a strictly a guest/host
mechanism.  People did implement offloads on specific platforms though,
and they are known to work. To improve portability even further,
we might need to make spec and code changes.

I'm not really sympathetic to people complaining that they can't even
set a flag in qemu though. If that's the case the stack in question is
way too inflexible.



> Both in the flag naming and the implementation there is an implication
> of DMA API == IOMMU, which is fundamentally wrong.

Maybe we need to extend the meaning of PLATFORM_IOMMU or rename it.

It's possible that some setups will benefit from a more
fine-grained approach where some aspects of the DMA
API are bypassed, others aren't.

This seems to be what was being asked for in this thread,
with comments claiming IOMMU flag adds too much overhead.


> The DMA API does a few different things:
> 
>  a) address translation
> 
> 	This does include IOMMUs.  But it also includes random offsets
> 	between PCI bars and system memory that we see on various
> 	platforms.

I don't think you mean bars. That's unrelated to DMA.

>  Worse so some of these offsets might be based on
> 	banks, e.g. on the broadcom bmips platform.  It also deals
> 	with bitmask in physical addresses related to memory encryption
> 	like AMD SEV.  I'd be really curious how for example the
> 	Intel virtio based NIC is going to work on any of those
> 	plaforms.

SEV guys report that they just set the iommu flag and then it all works.
I guess if there's translation we can think of this as a kind of iommu.
Maybe we should rename PLATFORM_IOMMU to PLARTFORM_TRANSLATION?

And apparently some people complain that just setting that flag makes
qemu check translation on each access with an unacceptable performance
overhead.  Forcing same behaviour for everyone on general principles
even without the flag is unlikely to make them happy.

>   b) coherency
> 
> 	On many architectures DMA is not cache coherent, and we need
> 	to invalidate and/or write back cache lines before doing
> 	DMA.  Again, I wonder how this is every going to work with
> 	hardware based virtio implementations.


You mean dma_Xmb and friends?
There's a new feature VIRTIO_F_IO_BARRIER that's being proposed
for that.


>  Even worse I think this
> 	is actually broken at least for VIVT event for virtualized
> 	implementations.  E.g. a KVM guest is going to access memory
> 	using different virtual addresses than qemu, vhost might throw
> 	in another different address space.

I don't really know what VIVT is. Could you help me please?

>   c) bounce buffering
> 
> 	Many DMA implementations can not address all physical memory
> 	due to addressing limitations.  In such cases we copy the
> 	DMA memory into a known addressable bounc buffer and DMA
> 	from there.

Don't do it then?


>   d) flushing write combining buffers or similar
> 
> 	On some hardware platforms we need workarounds to e.g. read
> 	from a certain mmio address to make sure DMA can actually
> 	see memory written by the host.

I guess it isn't an issue as long as WC isn't actually used.
It will become an issue when virtio spec adds some WC capability -
I suspect we can ignore this for now.

> 
> All of this is bypassed by virtio by default despite generally being
> platform issues, not particular to a given device.

It's both a device and a platform issue. A PV device is often more like
another CPU than like a PCI device.



-- 
MST
