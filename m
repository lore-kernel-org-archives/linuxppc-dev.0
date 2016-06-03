Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLjHC2yvVzDqB8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 21:56:23 +1000 (AEST)
Message-ID: <1464954975.21530.1.camel@ellerman.id.au>
Subject: Re: [RFC v3 22/45] powerpc: dma-mapping: Use unsigned long for
 dma_attrs
From: Michael Ellerman <mpe@ellerman.id.au>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Fri, 03 Jun 2016 21:56:15 +1000
In-Reply-To: <1464881987-13203-23-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
 <1464881987-13203-23-git-send-email-k.kozlowski@samsung.com>
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

On Thu, 2016-06-02 at 17:39 +0200, Krzysztof Kozlowski wrote:

> diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
> index 0c2794d2b6c0..5d1a7ef3fdee 100644
> --- a/arch/powerpc/platforms/cell/iommu.c
> +++ b/arch/powerpc/platforms/cell/iommu.c
> @@ -166,7 +166,7 @@ static void invalidate_tce_cache(struct cbe_iommu *iommu, unsigned long *pte,
>  
>  static int tce_build_cell(struct iommu_table *tbl, long index, long npages,
>  		unsigned long uaddr, enum dma_data_direction direction,
> -		struct dma_attrs *attrs)
> +		unsigned long attrs)
>  {
>  	int i;
>  	unsigned long *io_pte, base_pte;

You missed the call site:

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 2018e562d124..6128bdb428b2 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -526,7 +526,7 @@ cell_iommu_setup_window(struct cbe_iommu *iommu, struct device_node *np,
 
 	__set_bit(0, window->table.it_map);
 	tce_build_cell(&window->table, window->table.it_offset, 1,
-		       (unsigned long)iommu->pad_page, DMA_TO_DEVICE, NULL);
+		       (unsigned long)iommu->pad_page, DMA_TO_DEVICE, 0);
 
 	return window;
 }


cheers
