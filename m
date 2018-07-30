Return-Path: <BATV+396ebc2d5722fb16c925+5454+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fH9v1VLHzF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 21:18:09 +1000 (AEST)
Date: Mon, 30 Jul 2018 04:18:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Will Deacon <will.deacon@arm.com>,
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
Message-ID: <20180730111802.GA9830@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180727095804.GA25592@arm.com>
 <20180730093414.GD26245@infradead.org>
 <20180730125100-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730125100-mutt-send-email-mst@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 30, 2018 at 01:28:03PM +0300, Michael S. Tsirkin wrote:
> Let me reply to the "crappy" part first:
> So virtio devices can run on another CPU or on a PCI bus. Configuration
> can happen over mupltiple transports.  There is a discovery protocol to
> figure out where it is. It has some warts but any real system has warts.
> 
> So IMHO virtio running on another CPU isn't "legacy virtual crappy
> virtio". virtio devices that actually sit on a PCI bus aren't "sane"
> simply because the DMA is more convoluted on some architectures.

All of what you said would be true if virtio didn't claim to be
a PCI device.  Once it claims to be a PCI device and we also see
real hardware written to the interface I stand to all what I said
above.

> With this out of my system:
> I agree these approaches are hacky. I think it is generally better to
> have virtio feature negotiation tell you whether device runs on a CPU or
> not rather than rely on platform specific ways for this. To this end
> there was a recent proposal to rename VIRTIO_F_IO_BARRIER to
> VIRTIO_F_REAL_DEVICE.  It got stuck since "real" sounds vague to people,
> e.g.  what if it's a VF - is that real or not? But I can see something
> like e.g. VIRTIO_F_PLATFORM_DMA gaining support.
> 
> We would then rename virtio_has_iommu_quirk to virtio_has_dma_quirk
> and test VIRTIO_F_PLATFORM_DMA in addition to the IOMMU thing.

I don't really care about the exact naming, and indeed a device that
sets the flag doesn't have to be a 'real' device - it just has to act
like one.  I explained all the issues that this means (at least relating
to DMA) in one of the previous threads.

The important bit is that we can specify exact behavior for both
devices that sets the "I'm real!" flag and that ones that don't exactly
in the spec.  And that very much excludes arch-specific (or
Xen-specific) overrides.
