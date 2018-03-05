Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zw7xD0YhFzF10n
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 05:39:42 +1100 (AEDT)
Date: Mon, 5 Mar 2018 19:39:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Nipun Gupta <nipun.gupta@nxp.com>,
 will.deacon@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 m.szyprowski@samsung.com, gregkh@linuxfoundation.org,
 joro@8bytes.org, leoyang.li@nxp.com, shawnguo@kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 bharat.bhushan@nxp.com, stuyoder@gmail.com, laurentiu.tudor@nxp.com
Subject: Re: [PATCH 5/6] dma-mapping: support fsl-mc bus
Message-ID: <20180305183938.GB20086@lst.de>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
 <20180305150814.GA15918@lst.de>
 <7b4f9972-6aaa-fc9d-3854-d48b19a8051c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7b4f9972-6aaa-fc9d-3854-d48b19a8051c@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 05, 2018 at 03:48:32PM +0000, Robin Murphy wrote:
> Unfortunately for us, fsl-mc is conceptually rather like PCI in that it's 
> software-discoverable and the only thing described in DT is the bus "host", 
> thus we need the same sort of thing as for PCI to map from the child 
> devices back to the bus root in order to find the appropriate firmware 
> node. Worse than PCI, though, we wouldn't even have the option of 
> describing child devices statically in firmware at all, since it's actually 
> one of these runtime-configurable "build your own network accelerator" 
> hardware pools where userspace gets to create and destroy "devices" as it 
> likes.

I really hate the PCI special case just as much.  Maybe we just
need a dma_configure method on the bus, and move PCI as well as fsl-mc
to it.
