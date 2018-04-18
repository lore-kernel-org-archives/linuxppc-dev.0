Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40R6lz0TV8zF1yH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 02:20:14 +1000 (AEST)
Date: Wed, 18 Apr 2018 19:20:10 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, robh@kernel.org,
 aik@ozlabs.ru, jasowang@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, joe@perches.com,
 david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
 elfring@users.sourceforge.net
Subject: Re: [RFC] virtio: Use DMA MAP API for devices without an IOMMU
Message-ID: <20180418191722-mutt-send-email-mst@kernel.org>
References: <3e1b113b-79ca-b700-5be9-10c66d74aabe@linux.vnet.ibm.com>
 <20180405175326-mutt-send-email-mst@kernel.org>
 <1522940983.21446.205.camel@kernel.crashing.org>
 <20180405213042-mutt-send-email-mst@kernel.org>
 <1522963113.21446.211.camel@kernel.crashing.org>
 <70cb433f-a8f7-5199-3c96-a760c7624804@linux.vnet.ibm.com>
 <20180406071634.GA31108@infradead.org>
 <1523003838.21446.238.camel@kernel.crashing.org>
 <20180415121157.GA17726@infradead.org>
 <002f153f-452d-f64b-4fc7-7f3383b39162@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <002f153f-452d-f64b-4fc7-7f3383b39162@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 18, 2018 at 08:47:10AM +0530, Anshuman Khandual wrote:
> On 04/15/2018 05:41 PM, Christoph Hellwig wrote:
> > On Fri, Apr 06, 2018 at 06:37:18PM +1000, Benjamin Herrenschmidt wrote:
> >>>> implemented as DMA API which the virtio core understands. There is no
> >>>> need for an IOMMU to be involved for the device representation in this
> >>>> case IMHO.
> >>>
> >>> This whole virtio translation issue is a mess.  I think we need to
> >>> switch it to the dma API, and then quirk the legacy case to always
> >>> use the direct mapping inside the dma API.
> >>
> >> Fine with using a dma API always on the Linux side, but we do want to
> >> special case virtio still at the arch and qemu side to have a "direct
> >> mapping" mode. Not sure how (special flags on PCI devices) to avoid
> >> actually going through an emulated IOMMU on the qemu side, because that
> >> slows things down, esp. with vhost.
> >>
> >> IE, we can't I think just treat it the same as a physical device.
> > 
> > We should have treated it like a physical device from the start, but
> > that device has unfortunately sailed.
> > 
> > But yes, we'll need a per-device quirk that says 'don't attach an
> > iommu'.
> 
> How about doing it per platform basis as suggested in this RFC through
> an arch specific callback. Because all the virtio devices in the given
> platform would require and exercise this option (to avail bounce buffer
> mechanism for secure guests as an example). So the flag basically is a
> platform specific one not a device specific one.

That's not the case. A single platform can have a mix of virtio and
non-virtio devices. Same applies even within virtio, e.g. the balloon
device always bypasses an iommu.  Further, QEMU supports out of process
devices some of which might bypass the IOMMU.

-- 
MST
