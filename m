Return-Path: <BATV+e58a793fbb47aa1f3849+5463+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lhmV5LT7zDqhV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 16:48:26 +1000 (AEST)
Date: Tue, 7 Aug 2018 23:31:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>,
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
Message-ID: <20180808063158.GA2474@infradead.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2103ecfe52d23cec03f185d08a87bfad9c9d82b5.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 08, 2018 at 06:32:45AM +1000, Benjamin Herrenschmidt wrote:
> As for the flag itself, while we could set it from qemu when we get
> notified that the guest is going secure, both Michael and I think it's
> rather gross, it requires qemu to go iterate all virtio devices and
> "poke" something into them.

You don't need to set them the time you go secure.  You just need to
set the flag from the beginning on any VM you might want to go secure.
Or for simplicity just any VM - if the DT/ACPI tables exposed by
qemu are good enough that will always exclude a iommu and not set a
DMA offset, so nothing will change on the qemu side of he processing,
and with the new direct calls for the direct dma ops performance in
the guest won't change either.

> It's nicer if we have a way in the guest virtio driver to do something
> along the lines of
> 
> 	if ((flags & VIRTIO_F_IOMMU_PLATFORM) || arch_virtio_wants_dma_ops())
> 
> Which would have the same effect and means the issue is entirely
> contained in the guest.

It would not be the same effect.  The problem with that is that you must
now assumes that your qemu knows that for example you might be passing
a dma offset if the bus otherwise requires it.  Or in other words:
you potentially break the contract between qemu and the guest of always
passing down physical addresses.  If we explicitly change that contract
through using a flag that says you pass bus address everything is fine.

Note that in practice your scheme will probably just work for your
initial prototype, but chances are it will get us in trouble later on.
