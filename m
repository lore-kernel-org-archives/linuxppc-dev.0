Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fG4D5GFqzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 20:28:12 +1000 (AEST)
Date: Mon, 30 Jul 2018 13:28:03 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
 linuxram@us.ibm.com, haren@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
 jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180730125100-mutt-send-email-mst@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180727095804.GA25592@arm.com>
 <20180730093414.GD26245@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730093414.GD26245@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 30, 2018 at 02:34:14AM -0700, Christoph Hellwig wrote:
> We really need to distinguish between legacy virtual crappy
> virtio (and that includes v1) that totally ignores the bus it pretends
> to be on, and sane virtio (to be defined) that sit on a real (or
> properly emulated including iommu and details for dma mapping) bus.

Let me reply to the "crappy" part first:
So virtio devices can run on another CPU or on a PCI bus. Configuration
can happen over mupltiple transports.  There is a discovery protocol to
figure out where it is. It has some warts but any real system has warts.

So IMHO virtio running on another CPU isn't "legacy virtual crappy
virtio". virtio devices that actually sit on a PCI bus aren't "sane"
simply because the DMA is more convoluted on some architectures.

Performance impact of the optimizations possible when you know
your "device" is in fact just another CPU has been measured,
it is real, so we aren't interested in adding all that overhead back
just so we can use DMA API. The "correct then fast" mantra doesn't
apply to something that is as widely deployed as virtio.

And I can accept an argument that maybe the DMA API isn't designed to
support such virtual DMA. Whether it should I don't know.

With this out of my system:
I agree these approaches are hacky. I think it is generally better to
have virtio feature negotiation tell you whether device runs on a CPU or
not rather than rely on platform specific ways for this. To this end
there was a recent proposal to rename VIRTIO_F_IO_BARRIER to
VIRTIO_F_REAL_DEVICE.  It got stuck since "real" sounds vague to people,
e.g.  what if it's a VF - is that real or not? But I can see something
like e.g. VIRTIO_F_PLATFORM_DMA gaining support.

We would then rename virtio_has_iommu_quirk to virtio_has_dma_quirk
and test VIRTIO_F_PLATFORM_DMA in addition to the IOMMU thing.

-- 
MST
