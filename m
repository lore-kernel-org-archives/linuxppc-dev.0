Return-Path: <BATV+fca8fac9a0a6ce832f12+5462+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lGHY35LkzDqBx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 23:55:18 +1000 (AEST)
Date: Tue, 7 Aug 2018 06:55:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>,
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
Message-ID: <20180807135505.GA29034@infradead.org>
References: <20180803160246.GA13794@infradead.org>
 <22310f58605169fe9de83abf78b59f593ff7fbb7.camel@kernel.crashing.org>
 <20180804082120.GB4421@infradead.org>
 <a3ec0a454928e880dabc3782ea906e318634abf9.camel@kernel.crashing.org>
 <20180805072930.GB23288@infradead.org>
 <b7e8294e3e70d24072883a7e8e5375719d5af870.camel@kernel.crashing.org>
 <20180806094243.GA16032@infradead.org>
 <6c707d6d33ac25a42265c2e9b521c2416d72c739.camel@kernel.crashing.org>
 <20180807062117.GD32709@infradead.org>
 <aa59c7f8556bd4b332394a1dcf2d4a8faf3dc4a2.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <aa59c7f8556bd4b332394a1dcf2d4a8faf3dc4a2.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 07, 2018 at 04:42:44PM +1000, Benjamin Herrenschmidt wrote:
> Note that I can make it so that the same DMA ops (basically standard
> swiotlb ops without arch hacks) work for both "direct virtio" and
> "normal PCI" devices.
> 
> The trick is simply in the arch to setup the iommu to map the swiotlb
> bounce buffer pool 1:1 in the iommu, so the iommu essentially can be
> ignored without affecting the physical addresses.
> 
> If I do that, *all* I need is a way, from the guest itself (again, the
> other side dosn't know anything about it), to force virtio to use the
> DMA ops as if there was an iommu, that is, use whatever dma ops were
> setup by the platform for the pci device.

In that case just setting VIRTIO_F_IOMMU_PLATFORM in the flags should
do the work (even if that isn't strictly what the current definition
of the flag actually means).  On the qemu side you'll need to make
sure you have a way to set VIRTIO_F_IOMMU_PLATFORM without emulating
an iommu, but with code to take dma offsets into account if your
plaform has any (various power plaforms seem to have them, not sure
if it affects your config).
