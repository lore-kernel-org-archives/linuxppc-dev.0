Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zw8CV24FvzDsMk
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 05:52:04 +1100 (AEDT)
Subject: Re: [PATCH 5/6] dma-mapping: support fsl-mc bus
To: Christoph Hellwig <hch@lst.de>
Cc: Nipun Gupta <nipun.gupta@nxp.com>, will.deacon@arm.com,
 mark.rutland@arm.com, catalin.marinas@arm.com,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 m.szyprowski@samsung.com, gregkh@linuxfoundation.org, joro@8bytes.org,
 leoyang.li@nxp.com, shawnguo@kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, bharat.bhushan@nxp.com, stuyoder@gmail.com,
 laurentiu.tudor@nxp.com
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
 <20180305150814.GA15918@lst.de>
 <7b4f9972-6aaa-fc9d-3854-d48b19a8051c@arm.com>
 <20180305183938.GB20086@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1729ae21-d08c-b413-51a3-f22c394b388d@arm.com>
Date: Mon, 5 Mar 2018 18:51:56 +0000
MIME-Version: 1.0
In-Reply-To: <20180305183938.GB20086@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/03/18 18:39, Christoph Hellwig wrote:
> On Mon, Mar 05, 2018 at 03:48:32PM +0000, Robin Murphy wrote:
>> Unfortunately for us, fsl-mc is conceptually rather like PCI in that it's
>> software-discoverable and the only thing described in DT is the bus "host",
>> thus we need the same sort of thing as for PCI to map from the child
>> devices back to the bus root in order to find the appropriate firmware
>> node. Worse than PCI, though, we wouldn't even have the option of
>> describing child devices statically in firmware at all, since it's actually
>> one of these runtime-configurable "build your own network accelerator"
>> hardware pools where userspace gets to create and destroy "devices" as it
>> likes.
> 
> I really hate the PCI special case just as much.  Maybe we just
> need a dma_configure method on the bus, and move PCI as well as fsl-mc
> to it.

Hmm, on reflection, 100% ack to that idea. It would neatly supersede 
bus->force_dma *and* mean that we don't have to effectively pull pci.h 
into everything, which I've never liked. In hindsight dma_configure() 
does feel like it's grown into this odd choke point where we munge 
everything in just for it to awkwardly unpick things again.

Robin.
