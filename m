Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41kFvs0pjqzF3HD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2018 08:34:48 +1000 (AEST)
Message-ID: <b7e8294e3e70d24072883a7e8e5375719d5af870.camel@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
 haren@linux.vnet.ibm.com, paulus@samba.org, srikar@linux.vnet.ibm.com,
 robin.murphy@arm.com, jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Date: Mon, 06 Aug 2018 07:16:47 +1000
In-Reply-To: <20180805072930.GB23288@infradead.org>
References: <20180802200646-mutt-send-email-mst@kernel.org>
 <e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
 <20180802225738-mutt-send-email-mst@kernel.org>
 <de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
 <20180803070507.GA1344@infradead.org>
 <eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
 <20180803160246.GA13794@infradead.org>
 <22310f58605169fe9de83abf78b59f593ff7fbb7.camel@kernel.crashing.org>
 <20180804082120.GB4421@infradead.org>
 <a3ec0a454928e880dabc3782ea906e318634abf9.camel@kernel.crashing.org>
 <20180805072930.GB23288@infradead.org>
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

On Sun, 2018-08-05 at 00:29 -0700, Christoph Hellwig wrote:
> On Sun, Aug 05, 2018 at 11:10:15AM +1000, Benjamin Herrenschmidt wrote:
> >  - One you have rejected, which is to have a way for "no-iommu" virtio
> > (which still doesn't use an iommu on the qemu side and doesn't need
> > to), to be forced to use some custom DMA ops on the VM side.
> > 
> >  - One, which sadly has more overhead and will require modifying more
> > pieces of the puzzle, which is to make qemu uses an emulated iommu.
> > Once we make qemu do that, we can then layer swiotlb on top of the
> > emulated iommu on the guest side, and pass that as dma_ops to virtio.
> 
> Or number three:  have a a virtio feature bit that tells the VM
> to use whatever dma ops the platform thinks are appropinquate for
> the bus it pretends to be on.  Then set a dma-range that is limited
> to your secure memory range (if you really need it to be runtime
> enabled only after a device reset that rescans) and use the normal
> dma mapping code to bounce buffer.

Who would set this bit ? qemu ? Under what circumstances ?

What would be the effect of this bit while VIRTIO_F_IOMMU is NOT set,
ie, what would qemu do and what would Linux do ? I'm not sure I fully
understand your idea.

I'm trying to understand because the limitation is not a device side
limitation, it's not a qemu limitation, it's actually more of a VM
limitation. It has most of its memory pages made inaccessible for
security reasons. The platform from a qemu/KVM perspective is almost
entirely normal.

So I don't understand when would qemu set this bit, or should it be set
by the VM at runtime ?

Cheers,
Ben.
