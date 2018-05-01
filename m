Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40b6SG62T4zF2R7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 02:34:22 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w41GTmVr031579
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 May 2018 12:34:19 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hpuakh8bc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 May 2018 12:34:18 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 1 May 2018 17:34:16 +0100
Date: Tue, 1 May 2018 09:34:07 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>, robh@kernel.org,
 aik@ozlabs.ru, jasowang@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, joe@perches.com,
 linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net,
 david@gibson.dropbear.id.au
Subject: Re: [RFC] virtio: Use DMA MAP API for devices without an IOMMU
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180405175326-mutt-send-email-mst@kernel.org>
 <1522940983.21446.205.camel@kernel.crashing.org>
 <20180405213042-mutt-send-email-mst@kernel.org>
 <1522963113.21446.211.camel@kernel.crashing.org>
 <70cb433f-a8f7-5199-3c96-a760c7624804@linux.vnet.ibm.com>
 <20180406071634.GA31108@infradead.org>
 <1523003838.21446.238.camel@kernel.crashing.org>
 <20180415121157.GA17726@infradead.org>
 <002f153f-452d-f64b-4fc7-7f3383b39162@linux.vnet.ibm.com>
 <20180418191722-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180418191722-mutt-send-email-mst@kernel.org>
Message-Id: <20180501163407.GA6450@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 18, 2018 at 07:20:10PM +0300, Michael S. Tsirkin wrote:
> On Wed, Apr 18, 2018 at 08:47:10AM +0530, Anshuman Khandual wrote:
> > On 04/15/2018 05:41 PM, Christoph Hellwig wrote:
> > > On Fri, Apr 06, 2018 at 06:37:18PM +1000, Benjamin Herrenschmidt wrote:
> > >>>> implemented as DMA API which the virtio core understands. There is no
> > >>>> need for an IOMMU to be involved for the device representation in this
> > >>>> case IMHO.
> > >>>
> > >>> This whole virtio translation issue is a mess.  I think we need to
> > >>> switch it to the dma API, and then quirk the legacy case to always
> > >>> use the direct mapping inside the dma API.
> > >>
> > >> Fine with using a dma API always on the Linux side, but we do want to
> > >> special case virtio still at the arch and qemu side to have a "direct
> > >> mapping" mode. Not sure how (special flags on PCI devices) to avoid
> > >> actually going through an emulated IOMMU on the qemu side, because that
> > >> slows things down, esp. with vhost.
> > >>
> > >> IE, we can't I think just treat it the same as a physical device.
> > > 
> > > We should have treated it like a physical device from the start, but
> > > that device has unfortunately sailed.
> > > 
> > > But yes, we'll need a per-device quirk that says 'don't attach an
> > > iommu'.
> > 
> > How about doing it per platform basis as suggested in this RFC through
> > an arch specific callback. Because all the virtio devices in the given
> > platform would require and exercise this option (to avail bounce buffer
> > mechanism for secure guests as an example). So the flag basically is a
> > platform specific one not a device specific one.
> 
> That's not the case. A single platform can have a mix of virtio and
> non-virtio devices. Same applies even within virtio, e.g. the balloon
> device always bypasses an iommu.  Further, QEMU supports out of process
> devices some of which might bypass the IOMMU.

Given that each virtio device has to behave differently depending on 
(a) what it does?  (balloon, block, net etc ) 
(b) what platform it is on?  (pseries, x86, ....)
(c) what environment it is on?  (secure, insecure...)

I think, we should let the virtio device decide what it wants, instead
of forcing it to NOT use dma_ops when VIRTIO_F_IOMMU_PLATFORM is NOT
enabled.

Currently, virtio generic code, has an assumption that a device must NOT
use dma operations if the hypervisor has NOT enabled VIRTIO_F_IOMMU_PLATFORM.
This assumption is baked into vring_use_dma_api(); though there is a
special exception for xen_domain().

This assumption is restricting us from using the dma_ops abstraction for
virtio devices on secure VM. BTW: VIRTIO_F_IOMMU_PLATFORM may or may not
be set on this platform.

On our secure VM, virtio devices; by default, do not share pages with
hypervisor. In other words, hypervisor cannot access the secure VM
pages. The secure VM with the help of the hardware enables some pages
to be shared with the hypervisor.  Secure VM then uses these pages to
bounce virtio data with the hypervisor.

One elegant way to impliment this functionality is to abstract it
under our special dma_ops and wire it to the virtio devices.

However the restriction imposed by the generic virtio code, contrains us
from doing so.

If we can enrich vring_use_dma_api() to take multiple factors into
consideration and not just VIRTIO_F_IOMMU_PLATFORM; perferrably by
consulting a arch-dependent function, we could seemlessly integrate
into the existing virtio infrastructure.

RP
> 
> -- 
> MST

-- 
Ram Pai
