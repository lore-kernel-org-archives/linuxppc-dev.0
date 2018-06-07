Return-Path: <BATV+903b398dd7e97a6c787a+5401+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411ZGX6Y5WzDrYb
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 15:43:48 +1000 (AEST)
Date: Wed, 6 Jun 2018 22:23:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>, robh@kernel.org, aik@ozlabs.ru,
 jasowang@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 joe@perches.com, linuxppc-dev@lists.ozlabs.org,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 cohuck@redhat.com, pawel.moll@arm.com,
 Tom Lendacky <thomas.lendacky@amd.com>,
 "Rustad, Mark D" <mark.d.rustad@intel.com>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180607052306.GA1532@infradead.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <20180524072104.GD6139@ram.oc3035372033.ibm.com>
 <0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
 <20180531204320-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180531204320-mutt-send-email-mst@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 31, 2018 at 08:43:58PM +0300, Michael S. Tsirkin wrote:
> Pls work on a long term solution. Short term needs can be served by
> enabling the iommu platform in qemu.

So, I spent some time looking at converting virtio to dma ops overrides,
and the current virtio spec, and the sad through I have to tell is that
both the spec and the Linux implementation are complete and utterly fucked
up.

Both in the flag naming and the implementation there is an implication
of DMA API == IOMMU, which is fundamentally wrong.

The DMA API does a few different things:

 a) address translation

	This does include IOMMUs.  But it also includes random offsets
	between PCI bars and system memory that we see on various
	platforms.  Worse so some of these offsets might be based on
	banks, e.g. on the broadcom bmips platform.  It also deals
	with bitmask in physical addresses related to memory encryption
	like AMD SEV.  I'd be really curious how for example the
	Intel virtio based NIC is going to work on any of those
	plaforms.

  b) coherency

	On many architectures DMA is not cache coherent, and we need
	to invalidate and/or write back cache lines before doing
	DMA.  Again, I wonder how this is every going to work with
	hardware based virtio implementations.  Even worse I think this
	is actually broken at least for VIVT event for virtualized
	implementations.  E.g. a KVM guest is going to access memory
	using different virtual addresses than qemu, vhost might throw
	in another different address space.

  c) bounce buffering

	Many DMA implementations can not address all physical memory
	due to addressing limitations.  In such cases we copy the
	DMA memory into a known addressable bounc buffer and DMA
	from there.

  d) flushing write combining buffers or similar

	On some hardware platforms we need workarounds to e.g. read
	from a certain mmio address to make sure DMA can actually
	see memory written by the host.

All of this is bypassed by virtio by default despite generally being
platform issues, not particular to a given device.
