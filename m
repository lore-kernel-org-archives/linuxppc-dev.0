Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41l4jM5xvJzDqBx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 16:43:35 +1000 (AEST)
Message-ID: <aa59c7f8556bd4b332394a1dcf2d4a8faf3dc4a2.camel@kernel.crashing.org>
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
Date: Tue, 07 Aug 2018 16:42:44 +1000
In-Reply-To: <20180807062117.GD32709@infradead.org>
References: <20180803070507.GA1344@infradead.org>
 <eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
 <20180803160246.GA13794@infradead.org>
 <22310f58605169fe9de83abf78b59f593ff7fbb7.camel@kernel.crashing.org>
 <20180804082120.GB4421@infradead.org>
 <a3ec0a454928e880dabc3782ea906e318634abf9.camel@kernel.crashing.org>
 <20180805072930.GB23288@infradead.org>
 <b7e8294e3e70d24072883a7e8e5375719d5af870.camel@kernel.crashing.org>
 <20180806094243.GA16032@infradead.org>
 <6c707d6d33ac25a42265c2e9b521c2416d72c739.camel@kernel.crashing.org>
 <20180807062117.GD32709@infradead.org>
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

On Mon, 2018-08-06 at 23:21 -0700, Christoph Hellwig wrote:
> On Tue, Aug 07, 2018 at 05:52:12AM +1000, Benjamin Herrenschmidt wrote:
> > > It is your job to write a coherent interface specification that does
> > > not depend on the used components.  The hypervisor might be PAPR,
> > > Linux + qemu, VMware, Hyperv or something so secret that you'd have
> > > to shoot me if you had to tell me.  The guest might be Linux, FreeBSD,
> > > AIX, OS400 or a Hipster project of the day in Rust.  As long as we
> > > properly specify the interface it simplify does not matter.
> > 
> > That's the point Christoph. The interface is today's interface. It does
> > NOT change. That information is not part of the interface.
> > 
> > It's the VM itself that is stashing away its memory in a secret place,
> > and thus needs to do bounce buffering. There is no change to the virtio
> > interface per-se.
> 
> Any guest that doesn't know about your magic limited adressing is simply
> not going to work, so we need to communicate that fact.

The guest does. It's the guest itself that initiates it. That's my
point, it's not a factor of the hypervisor, which is unchanged in that
area.

It's the guest itself, that makes the decision early on, to stash it's
memory away in a secure place, and thus needs to establish some kind of
bouce buffering via a few left over "insecure" pages.

It's all done by the guest: initiated by the guest and controlled by
the guest.

That's why I don't see why this specifically needs to involve the
hypervisor side, and thus a VIRTIO feature bit.

Note that I can make it so that the same DMA ops (basically standard
swiotlb ops without arch hacks) work for both "direct virtio" and
"normal PCI" devices.

The trick is simply in the arch to setup the iommu to map the swiotlb
bounce buffer pool 1:1 in the iommu, so the iommu essentially can be
ignored without affecting the physical addresses.

If I do that, *all* I need is a way, from the guest itself (again, the
other side dosn't know anything about it), to force virtio to use the
DMA ops as if there was an iommu, that is, use whatever dma ops were
setup by the platform for the pci device.

Cheers,
Ben.
