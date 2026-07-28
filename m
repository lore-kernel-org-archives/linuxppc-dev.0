Return-Path: <linuxppc-dev+bounces-24948-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24428C53219
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 14:41:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8dT24DvSz2xyh;
	Wed, 29 Jul 2026 00:41:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785249702;
	cv=none; b=XYJMlrIkvlsUTVr7FPCsBzp0Exww02GUppE4gglIQO9lJSQjaB+yyItVF7YCqkV9OJ44pvTQxrJXs8l/6JectJDXKUFgsWTqvK9iwIHxRHKGLnz+11/GWTc7PP7u3DvM3RdaRmOh9TQHxyGDfWQKePu8lsypmw6YG8CSu17CXerZrNqAi52CANpoG/V0PoNl5G1E7Hyb3tiGoVuKUQaWlTvCdhQ8DXA1Wf9s97Z+pUn9xRYg/SVWT2L9UQTzOI51LObt9cd3ycR1oBl93XXULdJpV7O9BT/IRUMtS0tHc7nCr+hPVgQoOH5FP1Ab1HlpQPzV2nvRjTkJtaJQd5os1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785249702; c=relaxed/relaxed;
	bh=JCZrUOE9kwIF4hUfSxEIdPGLi7SYMbxXEbVOya3wkPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8xhsnZlJGgNdeuvVqr60//uKTP2xHF73igQqCIH+31BQkazTkTQi+e05zqXk9AwJw0v9Taf8ftPdgYfUTAopD00WrAvJpTMoeKTdvhrz825gxtsYK+ld04/JUwk+0oXDF1x9wwd+OzwtGPqdGHs21VJmAKDNmQ+F0m9FNa+5qJhE4DHAY0hqmjwFUALGUL5wdf2FyhzglKA/WxCKvo8EhHf14sxZP1GwpLM5iLCD9C31AMUbC1oC6On5/6w+81z0+j/KqA0XDsa0uUD7XqTHsWoSHAwi/vfEsfk4XJsXcCSjkvsqZTkasYMVsMsSTakg3vsRxGHfSymo+4eQtRgCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gk1/fp+i; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gk1/fp+i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8dT11ZDZz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 00:41:40 +1000 (AEST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so64015e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785249698; x=1785854498; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JCZrUOE9kwIF4hUfSxEIdPGLi7SYMbxXEbVOya3wkPE=;
        b=gk1/fp+icVdmkWsTfYu9LHbh7g+w1TSJcF14zRN/qmVbUCDDI9377hjyFrqCx9vjHj
         c8qdv7R2y+WcskC5k7kBf6BrrLcBGp8TKqG79MK3+6bdTe+hFIxXnQamAV6DzC22S3we
         75VAp6fK9uNqPZo4kYU7pGFMvroRQI8ADo5sXE4rzpDvKzzSKxg6+/htj0Ddx0zaReQc
         ClWemS1++qRGE5/AZNgqKKZdoKLjQN3YL0NvH+rqrMSPlRq7DGip0nm84KiRf5Csn4f+
         EgoUlkIP2d6VROmRY/lWRy8LAGP0KLDqABQY92hALFxlc7MBlRtZpyJ4HLcf35rO/LLu
         WGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785249698; x=1785854498;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JCZrUOE9kwIF4hUfSxEIdPGLi7SYMbxXEbVOya3wkPE=;
        b=hcrmdV2qpxSeS6XGfhcKI++PbgElu9wXutFJZDHfkn8RI5EE7fX2p1mPOBt991pgfA
         oFikbpdWWXsMvs40URwIVdOAMHUaAYd/x2nyXy+/dkiREZZRRXoL9h02j8HfTGKP2DSF
         IaSZHgjqztrqyiUId6n7W71IxtACrjVjBy2PC+N+gVoelV+xlu4z15fvcMw4CLab/CPv
         qhF3Q5rHN0owAeK2cSoz0pEyS8fo//OUkF6eaZVdBQaesx8Lf+IVrn6VWch43bIcVBEJ
         hDJpTxzbD6x+vAxuOW3fzgyFfixnpQKXoEG0/1YhNTvTNxoIqlazrvWG2dsmSnv3ZZYy
         o0jQ==
X-Forwarded-Encrypted: i=1; AHgh+Rowr+RjSgqoszU6JDaeJBfE7QJ8rHMP+UMiiimcBfxUkoCljtZk1bh9B3F4mqQufshp5f/YAzLIxLA4WwI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxFiEu189uvng+SNkTmzgM9O+Ipm7xBW4QiDzNJeTz7KFz0V6Zx
	m7hEVjVv1GnrTADUqswtkHc4h0/977/FIMUbEytQPM5a1bWNywac+pRNaQFLCB4Nrw==
X-Gm-Gg: AR+sD11dvRddV6/bVtwykJ+VsGJd7GmKc+xyc+rQJva0dL4G9DIrEyXeYD+Gb5Gnd/2
	W9y2JFm1uhhsrlcXrcU6lzmFstpLUVXxdj6/eGIhe7NZ2XSF/hFyYavAzSKtf7bJSATjWmZ3e+I
	eaFvTkJZovVqPsR9V9r+afhpgEmS/pVyCNsrYfXLzpuYrsy9TS3l6IJ7IMv9at6GV7qyfa+wVEm
	lzm9ylZYHMJp4T8Ve+3KzKf++GQzgbhmg1+01FOXGst9QL56CJEpgU1f5ZBHYNIyapUhyX9RJ81
	PU/NkfF5PaoNKqDrUL3C/3xfi8ChQJ3gKQlItlPv8A/FubmCRCLneAb79DrkitO68PBnysMA8s8
	3ik+4HoTczocno7dS1gHVZMTnNo8iZqEoRSyKFprIN41YBhSnKzpsXqAwO8y/BVR4Gw4FA92HLX
	gAVZMgf5IqJAdr/kmtzfqftjVGwW68P7W0s5MJoSDj+Vg=
X-Received: by 2002:a05:600c:528c:b0:490:ab15:b9e8 with SMTP id 5b1f17b1804b1-496b944f535mr5111045e9.2.1785249696887;
        Tue, 28 Jul 2026 07:41:36 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c45c338fsm83874795e9.8.2026.07.28.07.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:41:36 -0700 (PDT)
Date: Tue, 28 Jul 2026 14:41:30 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 12/23] dma: swiotlb: pass mapping attributes by
 reference
Message-ID: <ami_mpd_1pF4Tmdu@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-13-aneesh.kumar@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717180442.110954-13-aneesh.kumar@kernel.org>

On Fri, Jul 17, 2026 at 11:34:30PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Change swiotlb_tbl_map_single() to take the DMA mapping attributes by
> reference and update the direct callers accordingly.
> 
> This is a preparatory change for a follow-up patch which updates the
> attributes based on the selected swiotlb pool. Keeping the signature change
> separate makes the follow-up patch easier to review.
> 

I do not understand the point of this, why would
swiotlb_tbl_map_single() force attrs over the caller which should
already know the context (whether DMA is shared or not) which case
would this be useful to force from the SWIOTLB code?

Thanks,
Mostafa


> No functional change in this patch.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/dma-iommu.c | 2 +-
>  drivers/xen/swiotlb-xen.c | 2 +-
>  include/linux/swiotlb.h   | 2 +-
>  kernel/dma/swiotlb.c      | 6 +++---
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 83bf15ae9777..c42e40e60575 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1180,7 +1180,7 @@ static phys_addr_t iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>  	trace_swiotlb_bounced(dev, phys, size);
>  
>  	phys = swiotlb_tbl_map_single(dev, phys, size, iova_mask(iovad), dir,
> -			attrs);
> +				      &attrs);
>  
>  	/*
>  	 * Untrusted devices should not see padding areas with random leftover
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 2cbf2b588f5b..8c4abe65cd49 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -243,7 +243,7 @@ static dma_addr_t xen_swiotlb_map_phys(struct device *dev, phys_addr_t phys,
>  	 */
>  	trace_swiotlb_bounced(dev, dev_addr, size);
>  
> -	map = swiotlb_tbl_map_single(dev, phys, size, 0, dir, attrs);
> +	map = swiotlb_tbl_map_single(dev, phys, size, 0, dir, &attrs);
>  	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
>  		return DMA_MAPPING_ERROR;
>  
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index c92ff6791595..ea4c0a292dea 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -238,7 +238,7 @@ static inline phys_addr_t default_swiotlb_limit(void)
>  
>  phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
>  		size_t mapping_size, unsigned int alloc_aligned_mask,
> -		enum dma_data_direction dir, unsigned long attrs);
> +		enum dma_data_direction dir, unsigned long *attrs);
>  dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs);
>  
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 908de28aceb2..046ae92c4832 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1396,7 +1396,7 @@ static unsigned long mem_used(struct io_tlb_mem *mem)
>   */
>  phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>  		size_t mapping_size, unsigned int alloc_align_mask,
> -		enum dma_data_direction dir, unsigned long attrs)
> +		enum dma_data_direction dir, unsigned long *attrs)
>  {
>  	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>  	unsigned int offset;
> @@ -1430,7 +1430,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>  	size = ALIGN(mapping_size + offset, alloc_align_mask + 1);
>  	index = swiotlb_find_slots(dev, orig_addr, size, alloc_align_mask, &pool);
>  	if (index == -1) {
> -		if (!(attrs & DMA_ATTR_NO_WARN))
> +		if (!(*attrs & DMA_ATTR_NO_WARN))
>  			dev_warn_ratelimited(dev,
>  	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
>  				 size, mem->nslabs, mem_used(mem));
> @@ -1609,7 +1609,7 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
>  
>  	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size);
>  
> -	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, 0, dir, attrs);
> +	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, 0, dir, &attrs);
>  	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
>  		return DMA_MAPPING_ERROR;
>  
> -- 
> 2.43.0
> 

