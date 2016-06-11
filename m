Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rRvhF0gWrzDqGs
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jun 2016 09:02:36 +1000 (AEST)
Message-ID: <1465686148.19533.28.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: convert 'iommu_alloc failed' messages to
 dynamic debug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Sun, 12 Jun 2016 09:02:28 +1000
In-Reply-To: <1465563831-6565-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1465563831-6565-1-git-send-email-mauricfo@linux.vnet.ibm.com>
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

On Fri, 2016-06-10 at 10:03 -0300, Mauricio Faria de Oliveira wrote:
> This prevents flooding the logs with 'iommu_alloc failed' messages
> while I/O is performed (normally) to very fast devices (e.g. NVMe).
> 
> That error is not necessarily a problem; device drivers can retry
> later / reschedule the requests for which the allocation failed,
> and handle things gracefully for the caller stack on top of them.
> 
> This helps at least with NVMe devices without "64-bit"/direct DMA
> window scenarios (e.g., systems with more than a few terabytes of
> memory, on which DDW cannot be enabled, currently), where just an
> 'dd' command can trigger errors.

I'm not fan of this. This is a very useful message to diagnose why,
for example, your network adapter is not working properly.

A lot of drivers don't deal well with IOMMU errors.

The fact that NVME trigger these is a problem that needs to be solved
differently.

Cheers,
Ben.

> 
>   # dd if=/dev/zero of=/dev/nvme0n1p1 bs=64k count=512k
>   <...>
>   # echo $?
>   0
> 
>   # dmesg
>   nvme 0000:00:06.0: iommu_alloc failed, tbl c0000001fa67c520 vaddr
> c000000151c90000 npages 16
>   nvme 0000:00:06.0: iommu_alloc failed, tbl c0000001fa67c520 vaddr
> c000000151c90000 npages 16
>   nvme 0000:00:06.0: iommu_alloc failed, tbl c0000001fa67c520 vaddr
> c000000151c90000 npages 16
>   <...>
>   ppc_iommu_map_sg: 8186 callbacks suppressed
>   nvme 0000:00:06.0: iommu_alloc failed, tbl c0000001fa67c520 vaddr
> c0000000fa5c0000 npages 16
>   nvme 0000:00:06.0: iommu_alloc failed, tbl c0000001fa67c520 vaddr
> c000000100440000 npages 16
>   nvme 0000:00:06.0: iommu_alloc failed, tbl c0000001fa67c520 vaddr
> c000000100440000 npages 16
>   <...>
>   ppc_iommu_map_sg: 5707 callbacks suppressed
>   nvme 0000:00:06.0: iommu_alloc failed, tbl c0000001fa67c520 vaddr
> c0000000b5f50000 npages 16
>   nvme 0000:00:06.0: iommu_alloc failed, tbl c0000001fa67c520 vaddr
> c0000000b5c60000 npages 16
>   nvme 0000:00:06.0: iommu_alloc failed, tbl c0000001fa67c520 vaddr
> c0000000b4b30000 npages 16
>   <...>
> 
> Tested on next-20160609.
> 
> Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.co
> m>
> ---
>  arch/powerpc/kernel/iommu.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/iommu.c
> b/arch/powerpc/kernel/iommu.c
> index a8e3490..b585bdc 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -479,10 +479,9 @@ int ppc_iommu_map_sg(struct device *dev, struct
> iommu_table *tbl,
>  
>  		/* Handle failure */
>  		if (unlikely(entry == DMA_ERROR_CODE)) {
> -			if (printk_ratelimit())
> -				dev_info(dev, "iommu_alloc failed,
> tbl %p "
> -					 "vaddr %lx npages %lu\n",
> tbl, vaddr,
> -					 npages);
> +			dev_dbg_ratelimited(dev, "iommu_alloc
> failed, tbl %p "
> +				 "vaddr %lx npages %lu\n", tbl,
> vaddr,
> +				 npages);
>  			goto failure;
>  		}
>  
> @@ -776,11 +775,9 @@ dma_addr_t iommu_map_page(struct device *dev,
> struct iommu_table *tbl,
>  					 mask >> tbl->it_page_shift, 
> align,
>  					 attrs);
>  		if (dma_handle == DMA_ERROR_CODE) {
> -			if (printk_ratelimit())  {
> -				dev_info(dev, "iommu_alloc failed,
> tbl %p "
> -					 "vaddr %p npages %d\n",
> tbl, vaddr,
> -					 npages);
> -			}
> +			dev_dbg_ratelimited(dev, "iommu_alloc
> failed, tbl %p "
> +				 "vaddr %p npages %d\n", tbl, vaddr,
> +				 npages);
>  		} else
>  			dma_handle |= (uaddr &
> ~IOMMU_PAGE_MASK(tbl));
>  	}
