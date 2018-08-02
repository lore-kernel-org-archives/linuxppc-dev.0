Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hDXM32dNzF21L
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 01:25:55 +1000 (AEST)
Message-ID: <26c1d3d50d8e081eed44fe9940fbefed34598cbd.camel@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>, Will Deacon <will.deacon@arm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
 haren@linux.vnet.ibm.com, paulus@samba.org, srikar@linux.vnet.ibm.com,
 robin.murphy@arm.com, jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Date: Thu, 02 Aug 2018 10:24:57 -0500
In-Reply-To: <20180801083639.GF26378@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180727095804.GA25592@arm.com> <20180730093414.GD26245@infradead.org>
 <20180730125100-mutt-send-email-mst@kernel.org>
 <20180730111802.GA9830@infradead.org>
 <20180730155633-mutt-send-email-mst@kernel.org>
 <20180731173052.GA17153@infradead.org>
 <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
 <20180801081637.GA14438@arm.com> <20180801083639.GF26378@infradead.org>
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

On Wed, 2018-08-01 at 01:36 -0700, Christoph Hellwig wrote:
> We just need to figure out how to deal with devices that deviate
> from the default.  One things is that VIRTIO_F_IOMMU_PLATFORM really
> should become VIRTIO_F_PLATFORM_DMA to cover the cases of non-iommu
> dma tweaks (offsets, cache flushing), which seems well in spirit of
> the original design. 

I don't completely agree:

1 - VIRTIO_F_IOMMU_PLATFORM is a property of the "other side", ie qemu
for example. It indicates that the peer bypasses the normal platform
iommu. The platform code in the guest has no real way to know that this
is the case, this is a specific "feature" of the qemu implementation.

2 - VIRTIO_F_PLATFORM_DMA (or whatever you want to call it), is a
property of the guest platform itself (not qemu), there's no way the
"peer" can advertize it via the virtio negociated flags. At least for
us. I don't know for sure whether that would be workable for the ARM
case. In our case, qemu has no idea at VM creation time that the VM
will turn itself into a secure VM and thus will require bounce
buffering for IOs (including virtio).

So unless we have another hook for the arch code to set
VIRTIO_F_PLATFORM_DMA on selected (or all) virtio devices from the
guest itself, I don't see that as a way to deal with it.

>  The other issue is VIRTIO_F_IO_BARRIER
> which is very vaguely defined, and which needs a better definition.
> And last but not least we'll need some text explaining the challenges
> of hardware devices - I think VIRTIO_F_PLATFORM_DMA + VIRTIO_F_IO_BARRIER
> is what would basically cover them, but a good description including
> an explanation of why these matter.

Ben.
