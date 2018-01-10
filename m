Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zGmT15XkMzF0jj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 22:08:04 +1100 (AEDT)
Subject: Re: [PATCH 09/33] dma-mapping: take dma_pfn_offset into account in
 dma_max_pfn
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, x86@kernel.org,
 Konrad Rzeszutek Wilk <konrad@darnok.org>,
 linux-snps-arc@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 patches@groups.riscv.org, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-10-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <6e4732eb-9eaf-7e5b-863c-d3faa47bb513@arm.com>
Date: Wed, 10 Jan 2018 11:07:55 +0000
MIME-Version: 1.0
In-Reply-To: <20180110080027.13879-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/01/18 08:00, Christoph Hellwig wrote:
> This makes sure the generic version can be used with architectures /
> devices that have a DMA offset in the direct mapping.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/dma-mapping.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 81ed9b2d84dc..d84951865be7 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -692,7 +692,7 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
>   #ifndef dma_max_pfn
>   static inline unsigned long dma_max_pfn(struct device *dev)
>   {
> -	return *dev->dma_mask >> PAGE_SHIFT;
> +	return (*dev->dma_mask >> PAGE_SHIFT) + dev->dma_pfn_offset;
>   }
>   #endif
>   
> 
