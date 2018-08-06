Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41krMZ2ygJzDqBx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 07:27:21 +1000 (AEST)
Message-ID: <0967fc30001323e6e38ed12c8dba8ee3d1aa13f5.camel@kernel.crashing.org>
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
Date: Tue, 07 Aug 2018 07:26:35 +1000
In-Reply-To: <20180806233024-mutt-send-email-mst@kernel.org>
References: <20180802225738-mutt-send-email-mst@kernel.org>
 <de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
 <20180803070507.GA1344@infradead.org>
 <eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
 <20180803220443-mutt-send-email-mst@kernel.org>
 <051fd78e15595b414839fa8f9d445b9f4d7576c6.camel@kernel.crashing.org>
 <20180805031046-mutt-send-email-mst@kernel.org>
 <fd8fee94cf42e436878f179c7895de3a4dab3355.camel@kernel.crashing.org>
 <20180806164106-mutt-send-email-mst@kernel.org>
 <ef6d5d7c7b812bd797a1c3fd6bc7a26d0074020f.camel@kernel.crashing.org>
 <20180806233024-mutt-send-email-mst@kernel.org>
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

On Mon, 2018-08-06 at 23:35 +0300, Michael S. Tsirkin wrote:
> > As I said replying to Christoph, we are "leaking" into the interface
> > something here that is really what's the VM is doing to itself, which
> > is to stash its memory away in an inaccessible place.
> > 
> > Cheers,
> > Ben.
> 
> I think Christoph merely objects to the specific implementation.  If
> instead you do something like tweak dev->bus_dma_mask for the virtio
> device I think he won't object.

Well, we don't have "bus_dma_mask" yet ..or you mean dma_mask ?

So, something like that would be a possibility, but the problem is that
the current virtio (guest side) implementation doesn't honor this when
not using dma ops and will not use dma ops if not using iommu, so back
to square one.

Christoph seems to be wanting to use a flag in the interface to make
the guest use dma_ops which is what I don't understand.

What would be needed then would be something along the lines of virtio
noticing that dma_mask isn't big enough to cover all of memory (which
isn't something generic code can easily do here for various reasons I
can elaborate if you want, but that specific test more/less has to be
arch specific), and in that case, force itself to use DMA ops routed to
swiotlb.

I'd rather have arch code do the bulk of that work, don't you think ?

Which brings me back to this option, which may be the simplest and
avoids the overhead of the proposed series (I found the series to be a
nice cleanup but retpoline does kick us in the nuts here).

So what about this ?

--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -155,7 +155,7 @@ static bool vring_use_dma_api(struct virtio_device
*vdev)
         * the DMA API if we're a Xen guest, which at least allows
         * all of the sensible Xen configurations to work correctly.
         */
-       if (xen_domain())
+       if (xen_domain() || arch_virtio_direct_dma_ops(&vdev->dev))
                return true;
 
        return false;

(Passing the dev allows the arch to know this is a virtio device in
"direct" mode or whatever we want to call the !iommu case, and
construct appropriate DMA ops for it, which aren't the same as the DMA
ops of any other PCI device who *do* use the iommu).

Otherwise, the harder option would be for us to hack so that
xen_domain() returns true in our setup (gross), and have the arch code,
when it sets up PCI device DMA ops, have a gross hack to identify
virtio PCI devices, checks their F_IOMMU flag itself, and sets up the
different ops at that point.

As for those "special" ops, they are of course just normal swiotlb ops,
there's nothing "special" other that they aren't the ops that other PCI
device on that bus use.

Cheers,
Ben.
