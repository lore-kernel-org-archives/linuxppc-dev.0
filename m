Return-Path: <BATV+2e2b7d69833f9a8d01a8+5461+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41kYQ21bF0zF3HG
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2018 20:13:30 +1000 (AEST)
Date: Mon, 6 Aug 2018 02:42:43 -0700
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
Message-ID: <20180806094243.GA16032@infradead.org>
References: <20180802225738-mutt-send-email-mst@kernel.org>
 <de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
 <20180803070507.GA1344@infradead.org>
 <eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
 <20180803160246.GA13794@infradead.org>
 <22310f58605169fe9de83abf78b59f593ff7fbb7.camel@kernel.crashing.org>
 <20180804082120.GB4421@infradead.org>
 <a3ec0a454928e880dabc3782ea906e318634abf9.camel@kernel.crashing.org>
 <20180805072930.GB23288@infradead.org>
 <b7e8294e3e70d24072883a7e8e5375719d5af870.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b7e8294e3e70d24072883a7e8e5375719d5af870.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 06, 2018 at 07:16:47AM +1000, Benjamin Herrenschmidt wrote:
> Who would set this bit ? qemu ? Under what circumstances ?

I don't really care who sets what.  The implementation might not even
involved qemu.

It is your job to write a coherent interface specification that does
not depend on the used components.  The hypervisor might be PAPR,
Linux + qemu, VMware, Hyperv or something so secret that you'd have
to shoot me if you had to tell me.  The guest might be Linux, FreeBSD,
AIX, OS400 or a Hipster project of the day in Rust.  As long as we
properly specify the interface it simplify does not matter.

> What would be the effect of this bit while VIRTIO_F_IOMMU is NOT set,
> ie, what would qemu do and what would Linux do ? I'm not sure I fully
> understand your idea.

In a perfect would we'd just reuse VIRTIO_F_IOMMU and clarify the
description which currently is rather vague but basically captures
the use case.  Currently is is:

VIRTIO_F_IOMMU_PLATFORM(33)
    This feature indicates that the device is behind an IOMMU that
    translates bus addresses from the device into physical addresses in
    memory. If this feature bit is set to 0, then the device emits
    physical addresses which are not translated further, even though an
    IOMMU may be present.

And I'd change it to something like:

VIRTIO_F_PLATFORM_DMA(33)
    This feature indicates that the device emits platform specific
    bus addresses that might not be identical to physical address.
    The translation of physical to bus address is platform speific
    and defined by the plaform specification for the bus that the virtio
    device is attached to.
    If this feature bit is set to 0, then the device emits
    physical addresses which are not translated further, even if
    the platform would normally require translations for the bus that
    the virtio device is attached to.

If we can't change the defintion any more we should deprecate the
old VIRTIO_F_IOMMU_PLATFORM bit, and require the VIRTIO_F_IOMMU_PLATFORM
and VIRTIO_F_PLATFORM_DMA to be not set at the same time.

> I'm trying to understand because the limitation is not a device side
> limitation, it's not a qemu limitation, it's actually more of a VM
> limitation. It has most of its memory pages made inaccessible for
> security reasons. The platform from a qemu/KVM perspective is almost
> entirely normal.

Well, find a way to describe this either in the qemu specification using
new feature bits, or by using something like the above.
