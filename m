Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zGtJj0WSLzDqMJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 02:31:16 +1100 (AEDT)
Subject: Re: [PATCH 11/33] dma-mapping: move swiotlb arch helpers to a new
 header
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-mips@linux-mips.org,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 Konrad Rzeszutek Wilk <konrad@darnok.org>,
 linux-snps-arc@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 patches@groups.riscv.org, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-12-hch@lst.de>
 <3721b4ba-0685-255e-06b9-6e60678a1a92@arm.com>
 <20180110152617.GB17790@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b0f90ed0-989f-4dc2-6f86-de8b4e486b55@arm.com>
Date: Wed, 10 Jan 2018 15:31:08 +0000
MIME-Version: 1.0
In-Reply-To: <20180110152617.GB17790@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/01/18 15:26, Christoph Hellwig wrote:
> On Wed, Jan 10, 2018 at 02:56:01PM +0000, Robin Murphy wrote:
>> I took a look at these, and it seems their phys_to_dma() usage is doing the
>> thing which we subsequently formalised as dma_map_resource(). I've had a
>> crack at a quick patch to update the CESA driver; qcom_nandc looks slightly
>> more complex in that the changes probably need to span the BAM dmaengine
>> driver as well.
> 
> Sounds great, although probably something for the next merge window.
> 
> In the meantime does this patch looks good to you?

Yes indeed, modulo Vladimir's comments - it does seem prudent to fix the 
obvious off-by-ones as we touch them. I've wanted to do something like 
this for ages, but never got around to it myself.

Thanks,
Robin.
