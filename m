Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40vv0Z13qDzDr3M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 09:57:01 +1000 (AEST)
Message-ID: <2f1d48cf029c1f0903f3cffea946ae5b85f60ec0.camel@kernel.crashing.org>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au, hch@infradead.org
Date: Tue, 29 May 2018 09:56:24 +1000
In-Reply-To: <6fff9f5d67361653e6072570a857cf0d1009a123.camel@kernel.crashing.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
 <20180525202300-mutt-send-email-mst@kernel.org>
 <6fff9f5d67361653e6072570a857cf0d1009a123.camel@kernel.crashing.org>
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

On Tue, 2018-05-29 at 09:48 +1000, Benjamin Herrenschmidt wrote:
> > Well it's not supposed to be much slower for the static case.
> > 
> > vhost has a cache so should be fine.
> > 
> > A while ago Paolo implemented a translation cache which should be
> > perfect for this case - most of the code got merged but
> > never enabled because of stability issues.
> > 
> > If all else fails, we could teach QEMU to handle the no-iommu case
> > as if VIRTIO_F_IOMMU_PLATFORM was off.
> 
> Any serious reason why not just getting that 2 line patch allowing our
> arch code to force virtio to use the DMA API ?
> 
> It's not particularly invasive and solves our problem rather nicely
> without adding overhead or additional knowledge to qemu/libvirt/mgmnt
> tools etc... that it doesn't need etc....
> 
> The guest knows it's going secure so the guest arch code can do the
> right thing rather trivially.
> 
> Long term we should probably make virtio always use the DMA API anyway,
> and interpose "1:1" dma_ops for the traditional virtio case, that would
> reduce code clutter significantly. In that case, it would become just a
> matter of having a platform hook to override the dma_ops used.

To elaborate a bit ....

What we are trying to solve here is entirely a guest problem, I don't
think involving qemu in the solution is the right thing to do.

The guest can only allow external parties (qemu, potentially PCI
devices, etc...) access to some restricted portions of memory (insecure
memory). Thus the guest need to do some bounce buffering/swiotlb type
tricks.

This is completely orthogonal to whether there is an actual iommu
between the guest and the device (or emulated device/virtio).

This is why I think the solution should reside in the guest kernel, by
proper manipulation (by the arch code) of the dma ops.

I don't think forcing the addition of an emulated iommu in the middle
just to work around the fact that virtio "cheats" and doesn't use the
dma API unless there is one, is the right "fix".

The right long term fix is to always use the DMA API, reducing code
path etc... and just have a single point where virtio can "chose"
alternate DMA ops (via an arch hook to deal with our case).

In the meantime, having the hook we propose gets us going, but if you
agree with the approach, we should also work on the long term approach.

Cheers,
Ben.
