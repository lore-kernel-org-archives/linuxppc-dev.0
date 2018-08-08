Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lnCT3b0BzDqgZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 20:08:37 +1000 (AEST)
Message-ID: <4b596883892b5cb5560bef26fcd249e7107173ac.camel@kernel.crashing.org>
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
Date: Wed, 08 Aug 2018 20:07:49 +1000
In-Reply-To: <20180808063158.GA2474@infradead.org>
References: <20180804082120.GB4421@infradead.org>
 <a3ec0a454928e880dabc3782ea906e318634abf9.camel@kernel.crashing.org>
 <20180805072930.GB23288@infradead.org>
 <b7e8294e3e70d24072883a7e8e5375719d5af870.camel@kernel.crashing.org>
 <20180806094243.GA16032@infradead.org>
 <6c707d6d33ac25a42265c2e9b521c2416d72c739.camel@kernel.crashing.org>
 <20180807062117.GD32709@infradead.org>
 <aa59c7f8556bd4b332394a1dcf2d4a8faf3dc4a2.camel@kernel.crashing.org>
 <20180807135505.GA29034@infradead.org>
 <2103ecfe52d23cec03f185d08a87bfad9c9d82b5.camel@kernel.crashing.org>
 <20180808063158.GA2474@infradead.org>
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

On Tue, 2018-08-07 at 23:31 -0700, Christoph Hellwig wrote:
> 
> You don't need to set them the time you go secure.  You just need to
> set the flag from the beginning on any VM you might want to go secure.
> Or for simplicity just any VM - if the DT/ACPI tables exposed by
> qemu are good enough that will always exclude a iommu and not set a
> DMA offset, so nothing will change on the qemu side of he processing,
> and with the new direct calls for the direct dma ops performance in
> the guest won't change either.

So that's where I'm not sure things are "good enough" due to how
pseries works. (remember it's paravirtualized).

A pseries system starts with a default iommu on all devices, that uses
translation using 4k entires with a "pinhole" window (usually 2G with
qemu iirc). There's no "pass through" by default.

Qemu virtio bypasses that iommu when the VIRTIO_F_IOMMU_PLATFORM flag
is not set (default) but there's nothing in the device-tree to tell the
guest about this since it's a violation of our pseries architecture, so
we just rely on Linux virtio "knowing" that it happens. It's a bit
yucky but that's now history...

Essentially pseries "architecturally" does not have the concept of not
having an iommu in the way and qemu violates that architecture today.

(Remember it comes from pHyp, our priorietary HV, which we are somewhat
mimmicing here).

So if we always set VIRTIO_F_IOMMU_PLATFORM, it *will* force all virtio
through that iommu and performance will suffer (esp vhost I suspect),
especially since adding/removing translations in the iommu is a
hypercall.

Now, we do have HV APIs to create a second window that's "permanently
mapped" to the guest memory, thus avoiding dynamic map/unmaps, and
Linux can make use of this but I don't know if that works with qemu and
the performance impact with vhost.

So the situation isn't that great.... On the other hand, I think the
other approach works for us:

> > It's nicer if we have a way in the guest virtio driver to do something
> > along the lines of
> > 
> > 	if ((flags & VIRTIO_F_IOMMU_PLATFORM) || arch_virtio_wants_dma_ops())
> > 
> > Which would have the same effect and means the issue is entirely
> > contained in the guest.
> 
> It would not be the same effect.  The problem with that is that you must
> now assumes that your qemu knows that for example you might be passing
> a dma offset if the bus otherwise requires it. 

I would assume that arch_virtio_wants_dma_ops() only returns true when
no such offsets are involved, at least in our case that would be what
happens.

>  Or in other words:
> you potentially break the contract between qemu and the guest of always
> passing down physical addresses.  If we explicitly change that contract
> through using a flag that says you pass bus address everything is fine.

For us a "bus address" is behind the iommu so that's what
VIRTIO_F_IOMMU_PLATFORM does already. We don't have the concept of a
bus address that is different. I suppose it's an ARMism to have DMA
offsets that are separate from iommus ? 

> Note that in practice your scheme will probably just work for your
> initial prototype, but chances are it will get us in trouble later on.

Not on pseries, at least not in any way I can think of mind you... but
maybe other architectures would abuse it... We could add a WARN_ON if
that calls returns true on a bus with an offset I suppose.

Cheers,
Ben.
