Return-Path: <BATV+fca8fac9a0a6ce832f12+5462+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41l46N0pHNzDqBx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 16:16:43 +1000 (AEST)
Date: Mon, 6 Aug 2018 23:16:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Christoph Hellwig <hch@infradead.org>, Will Deacon <will.deacon@arm.com>,
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
Message-ID: <20180807061637.GB32709@infradead.org>
References: <20180803070507.GA1344@infradead.org>
 <eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
 <20180803220443-mutt-send-email-mst@kernel.org>
 <051fd78e15595b414839fa8f9d445b9f4d7576c6.camel@kernel.crashing.org>
 <20180805031046-mutt-send-email-mst@kernel.org>
 <fd8fee94cf42e436878f179c7895de3a4dab3355.camel@kernel.crashing.org>
 <20180806164106-mutt-send-email-mst@kernel.org>
 <ef6d5d7c7b812bd797a1c3fd6bc7a26d0074020f.camel@kernel.crashing.org>
 <20180806233024-mutt-send-email-mst@kernel.org>
 <0967fc30001323e6e38ed12c8dba8ee3d1aa13f5.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0967fc30001323e6e38ed12c8dba8ee3d1aa13f5.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 07, 2018 at 07:26:35AM +1000, Benjamin Herrenschmidt wrote:
> > I think Christoph merely objects to the specific implementation.  If
> > instead you do something like tweak dev->bus_dma_mask for the virtio
> > device I think he won't object.
> 
> Well, we don't have "bus_dma_mask" yet ..or you mean dma_mask ?

It will be new in 4.19:

http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/f07d141fe9430cdf9f8a65a87c41

> So, something like that would be a possibility, but the problem is that
> the current virtio (guest side) implementation doesn't honor this when
> not using dma ops and will not use dma ops if not using iommu, so back
> to square one.
> 
> Christoph seems to be wanting to use a flag in the interface to make
> the guest use dma_ops which is what I don't understand.

As-is virtio devices are very clearly and explcitly defined to use
physical addresses in the spec.  dma ops will often do platform
based translations (iommu, offsets), so we can't just use the plaform
default dma ops and will need to opt into them.

> What would be needed then would be something along the lines of virtio
> noticing that dma_mask isn't big enough to cover all of memory (which
> isn't something generic code can easily do here for various reasons I
> can elaborate if you want, but that specific test more/less has to be
> arch specific), and in that case, force itself to use DMA ops routed to
> swiotlb.
> 
> I'd rather have arch code do the bulk of that work, don't you think ?

There is nothing architecture specific about that.  I've been working
hard to remove all the bullshit architectures have done in their DMA
ops and consolidating them into common code based on rules.  The last
thing I want is another vector for weird underspecified arch
interfaction with DMA ops, which is exactly what your patch below
does.
