Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zGw3j2sGJzF0js
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 03:50:07 +1100 (AEDT)
Subject: Re: [PATCH 27/33] dma-direct: use node local allocations for coherent
 memory
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
 <20180110080027.13879-28-hch@lst.de>
 <3672aa56-b85c-5d2c-0c0e-709031b0c0a0@arm.com>
 <20180110153017.GD17790@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3f37ba8d-66fa-80e2-bbe1-77c2a4323d6b@arm.com>
Date: Wed, 10 Jan 2018 16:49:58 +0000
MIME-Version: 1.0
In-Reply-To: <20180110153017.GD17790@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/01/18 15:30, Christoph Hellwig wrote:
> On Wed, Jan 10, 2018 at 12:06:22PM +0000, Robin Murphy wrote:
>> On 10/01/18 08:00, Christoph Hellwig wrote:
>>> To preserve the x86 behavior.
>>
>> And combined with patch 10/22 of the SWIOTLB refactoring, this means
>> SWIOTLB allocations will also end up NUMA-aware, right? Great, that's what
>> we want on arm64 too :)
> 
> Well, only for swiotlb allocations that can be satisfied by
> dma_direct_alloc.  If we actually have to fall back to the swiotlb
> buffers there is not node affinity yet.

Yeah, when I looked into it I reached the conclusion that per-node 
bounce buffers probably weren't worth it - if you have to bounce you've 
already pretty much lost the performance game, and if the CPU doing the 
bouncing happens to be on a different node from the device you've 
certainly lost either way. Per-node CMA zones we definitely *would* 
like, but that's a future problem (it looks technically feasible without 
huge infrastructure changes, but fiddly).

Robin.
