Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41jhSk59RfzF3HK
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Aug 2018 10:27:50 +1000 (AEST)
Date: Sun, 5 Aug 2018 03:27:42 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <20180805032504-mutt-send-email-mst@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180727095804.GA25592@arm.com>
 <20180730093414.GD26245@infradead.org>
 <20180730125100-mutt-send-email-mst@kernel.org>
 <20180730111802.GA9830@infradead.org>
 <20180730155633-mutt-send-email-mst@kernel.org>
 <20180731173052.GA17153@infradead.org>
 <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
 <20180801081637.GA14438@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180801081637.GA14438@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 01, 2018 at 09:16:38AM +0100, Will Deacon wrote:
> On Tue, Jul 31, 2018 at 03:36:22PM -0500, Benjamin Herrenschmidt wrote:
> > On Tue, 2018-07-31 at 10:30 -0700, Christoph Hellwig wrote:
> > > > However the question people raise is that DMA API is already full of
> > > > arch-specific tricks the likes of which are outlined in your post linked
> > > > above. How is this one much worse?
> > > 
> > > None of these warts is visible to the driver, they are all handled in
> > > the architecture (possibly on a per-bus basis).
> > > 
> > > So for virtio we really need to decide if it has one set of behavior
> > > as specified in the virtio spec, or if it behaves exactly as if it
> > > was on a PCI bus, or in fact probably both as you lined up.  But no
> > > magic arch specific behavior inbetween.
> > 
> > The only arch specific behaviour is needed in the case where it doesn't
> > behave like PCI. In this case, the PCI DMA ops are not suitable, but in
> > our secure VMs, we still need to make it use swiotlb in order to bounce
> > through non-secure pages.
> 
> On arm/arm64, the problem we have is that legacy virtio devices on the MMIO
> transport (so definitely not PCI) have historically been advertised by qemu
> as not being cache coherent, but because the virtio core has bypassed DMA
> ops then everything has happened to work. If we blindly enable the arch DMA
> ops, we'll plumb in the non-coherent ops and start getting data corruption,
> so we do need a way to quirk virtio as being "always coherent" if we want to
> use the DMA ops (which we do, because our emulation platforms have an IOMMU
> for all virtio devices).
> 
> Will

Right that's not very different from placing the device within the IOMMU
domain but in fact bypassing the IOMMU. I wonder whether anyone ever
needs a non coherent virtio-mmio. If yes we can extend
PLATFORM_IOMMU to cover that or add another bit.

What exactly do the non-coherent ops do that causes the corruption?

-- 
MST
