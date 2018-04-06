Return-Path: <BATV+ed5d6cd84c69c83c4889+5339+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40HWjY3PKpzF1s5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 17:36:49 +1000 (AEST)
Date: Fri, 6 Apr 2018 00:16:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, robh@kernel.org,
 aik@ozlabs.ru, jasowang@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, joe@perches.com,
 david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
 elfring@users.sourceforge.net
Subject: Re: [RFC] virtio: Use DMA MAP API for devices without an IOMMU
Message-ID: <20180406071634.GA31108@infradead.org>
References: <20180405105631.9514-1-khandual@linux.vnet.ibm.com>
 <3e1b113b-79ca-b700-5be9-10c66d74aabe@linux.vnet.ibm.com>
 <20180405175326-mutt-send-email-mst@kernel.org>
 <1522940983.21446.205.camel@kernel.crashing.org>
 <20180405213042-mutt-send-email-mst@kernel.org>
 <1522963113.21446.211.camel@kernel.crashing.org>
 <70cb433f-a8f7-5199-3c96-a760c7624804@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <70cb433f-a8f7-5199-3c96-a760c7624804@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 06, 2018 at 08:23:10AM +0530, Anshuman Khandual wrote:
> On 04/06/2018 02:48 AM, Benjamin Herrenschmidt wrote:
> > On Thu, 2018-04-05 at 21:34 +0300, Michael S. Tsirkin wrote:
> >>> In this specific case, because that would make qemu expect an iommu,
> >>> and there isn't one.
> >>
> >>
> >> I think that you can set iommu_platform in qemu without an iommu.
> > 
> > No I mean the platform has one but it's not desirable for it to be used
> > due to the performance hit.
> 
> Also the only requirement is to bounce the I/O buffers through SWIOTLB
> implemented as DMA API which the virtio core understands. There is no
> need for an IOMMU to be involved for the device representation in this
> case IMHO.

This whole virtio translation issue is a mess.  I think we need to
switch it to the dma API, and then quirk the legacy case to always
use the direct mapping inside the dma API.
