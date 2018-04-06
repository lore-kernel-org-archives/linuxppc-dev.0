Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40HY4P1KVFzF1ys
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 18:38:12 +1000 (AEST)
Message-ID: <1523003838.21446.238.camel@kernel.crashing.org>
Subject: Re: [RFC] virtio: Use DMA MAP API for devices without an IOMMU
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, robh@kernel.org, aik@ozlabs.ru,
 jasowang@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, joe@perches.com,
 david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
 elfring@users.sourceforge.net
Date: Fri, 06 Apr 2018 18:37:18 +1000
In-Reply-To: <20180406071634.GA31108@infradead.org>
References: <20180405105631.9514-1-khandual@linux.vnet.ibm.com>
 <3e1b113b-79ca-b700-5be9-10c66d74aabe@linux.vnet.ibm.com>
 <20180405175326-mutt-send-email-mst@kernel.org>
 <1522940983.21446.205.camel@kernel.crashing.org>
 <20180405213042-mutt-send-email-mst@kernel.org>
 <1522963113.21446.211.camel@kernel.crashing.org>
 <70cb433f-a8f7-5199-3c96-a760c7624804@linux.vnet.ibm.com>
 <20180406071634.GA31108@infradead.org>
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

On Fri, 2018-04-06 at 00:16 -0700, Christoph Hellwig wrote:
> On Fri, Apr 06, 2018 at 08:23:10AM +0530, Anshuman Khandual wrote:
> > On 04/06/2018 02:48 AM, Benjamin Herrenschmidt wrote:
> > > On Thu, 2018-04-05 at 21:34 +0300, Michael S. Tsirkin wrote:
> > > > > In this specific case, because that would make qemu expect an iommu,
> > > > > and there isn't one.
> > > > 
> > > > 
> > > > I think that you can set iommu_platform in qemu without an iommu.
> > > 
> > > No I mean the platform has one but it's not desirable for it to be used
> > > due to the performance hit.
> > 
> > Also the only requirement is to bounce the I/O buffers through SWIOTLB
> > implemented as DMA API which the virtio core understands. There is no
> > need for an IOMMU to be involved for the device representation in this
> > case IMHO.
> 
> This whole virtio translation issue is a mess.  I think we need to
> switch it to the dma API, and then quirk the legacy case to always
> use the direct mapping inside the dma API.

Fine with using a dma API always on the Linux side, but we do want to
special case virtio still at the arch and qemu side to have a "direct
mapping" mode. Not sure how (special flags on PCI devices) to avoid
actually going through an emulated IOMMU on the qemu side, because that
slows things down, esp. with vhost.

IE, we can't I think just treat it the same as a physical device.

Cheers,
Ben.
