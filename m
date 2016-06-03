Return-Path: <k.kozlowski@samsung.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com
 [210.118.77.13])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLkDW4jL2zDq62
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 22:39:07 +1000 (AEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0O8700MTC4H13U60@mailout3.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 03 Jun 2016 13:39:01 +0100 (BST)
Subject: Re: [RFC v3 22/45] powerpc: dma-mapping: Use unsigned long for
 dma_attrs
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
 <1464881987-13203-23-git-send-email-k.kozlowski@samsung.com>
 <1464954975.21530.1.camel@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <57517A64.2010408@samsung.com>
Date: Fri, 03 Jun 2016 14:39:00 +0200
MIME-version: 1.0
In-reply-to: <1464954975.21530.1.camel@ellerman.id.au>
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/03/2016 01:56 PM, Michael Ellerman wrote:
> On Thu, 2016-06-02 at 17:39 +0200, Krzysztof Kozlowski wrote:
> 
>> diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
>> index 0c2794d2b6c0..5d1a7ef3fdee 100644
>> --- a/arch/powerpc/platforms/cell/iommu.c
>> +++ b/arch/powerpc/platforms/cell/iommu.c
>> @@ -166,7 +166,7 @@ static void invalidate_tce_cache(struct cbe_iommu *iommu, unsigned long *pte,
>>  
>>  static int tce_build_cell(struct iommu_table *tbl, long index, long npages,
>>  		unsigned long uaddr, enum dma_data_direction direction,
>> -		struct dma_attrs *attrs)
>> +		unsigned long attrs)
>>  {
>>  	int i;
>>  	unsigned long *io_pte, base_pte;
> 
> You missed the call site:

Right, thanks!

Best regards,
Krzysztof

> diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
> index 2018e562d124..6128bdb428b2 100644
> --- a/arch/powerpc/platforms/cell/iommu.c
> +++ b/arch/powerpc/platforms/cell/iommu.c
> @@ -526,7 +526,7 @@ cell_iommu_setup_window(struct cbe_iommu *iommu, struct device_node *np,
>  
>  	__set_bit(0, window->table.it_map);
>  	tce_build_cell(&window->table, window->table.it_offset, 1,
> -		       (unsigned long)iommu->pad_page, DMA_TO_DEVICE, NULL);
> +		       (unsigned long)iommu->pad_page, DMA_TO_DEVICE, 0);
>  
>  	return window;
>  }
> 
> 
> cheers
> 
> 
> 
