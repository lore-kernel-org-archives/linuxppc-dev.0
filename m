Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gpFL0gTwzF1Qn
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 08:41:26 +1000 (AEST)
Date: Thu, 2 Aug 2018 01:41:20 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
Message-ID: <20180802014028-mutt-send-email-mst@kernel.org>
References: <20180727095804.GA25592@arm.com>
 <20180730093414.GD26245@infradead.org>
 <20180730125100-mutt-send-email-mst@kernel.org>
 <20180730111802.GA9830@infradead.org>
 <20180730155633-mutt-send-email-mst@kernel.org>
 <20180731173052.GA17153@infradead.org>
 <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
 <20180801081637.GA14438@arm.com>
 <20180801083639.GF26378@infradead.org>
 <20180801090535.GB14438@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180801090535.GB14438@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 01, 2018 at 10:05:35AM +0100, Will Deacon wrote:
> Hi Christoph,
> 
> On Wed, Aug 01, 2018 at 01:36:39AM -0700, Christoph Hellwig wrote:
> > On Wed, Aug 01, 2018 at 09:16:38AM +0100, Will Deacon wrote:
> > > On arm/arm64, the problem we have is that legacy virtio devices on the MMIO
> > > transport (so definitely not PCI) have historically been advertised by qemu
> > > as not being cache coherent, but because the virtio core has bypassed DMA
> > > ops then everything has happened to work. If we blindly enable the arch DMA
> > > ops,
> > 
> > No one is suggesting that as far as I can tell.
> 
> Apologies: it's me that wants the DMA ops enabled to handle legacy devices
> behind an IOMMU, but see below.
> 
> > > we'll plumb in the non-coherent ops and start getting data corruption,
> > > so we do need a way to quirk virtio as being "always coherent" if we want to
> > > use the DMA ops (which we do, because our emulation platforms have an IOMMU
> > > for all virtio devices).
> > 
> > From all that I've gather so far: no you do not want that.  We really
> > need to figure out virtio "dma" interacts with the host / device.
> > 
> > If you look at the current iommu spec it does talk of physical address
> > with a little careveout for VIRTIO_F_IOMMU_PLATFORM.
> 
> That's true, although that doesn't exist in the legacy virtio spec, and we
> have an existing emulation platform which puts legacy virtio devices behind
> an IOMMU. Currently, Linux is unable to boot on this platform unless the
> IOMMU is configured as bypass. If we can use the coherent IOMMU DMA ops,
> then it works perfectly.
> 
> > So between that and our discussion in this thread and its previous
> > iterations I think we need to stick to the current always physical,
> > bypass system dma ops mode of virtio operation as the default.
> 
> As above -- that means we hang during boot because we get stuck trying to
> bring up a virtio-block device whose DMA is aborted by the IOMMU. The easy
> answer is "just upgrade to latest virtio and advertise the presence of the
> IOMMU". I'm pushing for that in future platforms, but it seems a shame not
> to support the current platform, especially given that other systems do have
> hacks in mainline to get virtio working.
> 
> > We just need to figure out how to deal with devices that deviate
> > from the default.  One things is that VIRTIO_F_IOMMU_PLATFORM really
> > should become VIRTIO_F_PLATFORM_DMA to cover the cases of non-iommu
> > dma tweaks (offsets, cache flushing), which seems well in spirit of
> > the original design.  The other issue is VIRTIO_F_IO_BARRIER
> > which is very vaguely defined, and which needs a better definition.
> > And last but not least we'll need some text explaining the challenges
> > of hardware devices - I think VIRTIO_F_PLATFORM_DMA + VIRTIO_F_IO_BARRIER
> > is what would basically cover them, but a good description including
> > an explanation of why these matter.
> 
> I agree that this makes sense for future revisions of virtio (or perhaps
> it can just be a clarification to virtio 1.0), but we're still left in the
> dark with legacy devices and it would be nice to have them work on the
> systems which currently exist, even if it's a legacy-only hack in the arch
> code.
> 
> Will


Myself I'm sympathetic to this use-case and I see more uses to this
than just legacy support. But more work is required IMHO.
Will post tomorrow though - it's late here ...

-- 
MST
