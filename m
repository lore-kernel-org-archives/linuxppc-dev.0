Return-Path: <linuxppc-dev+bounces-22322-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B127BCD8C92
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 12:21:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZSh51cjlz2ytV;
	Tue, 09 Jun 2026 22:21:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781007701;
	cv=none; b=g4JTYeOES/cKQZO6VeFJ8x6fen/kGsS6wTtd0Kk8AGiAXgxCoYAFZZlixw8UpD1eSS4bCPWz8MKFkT/xz9ZdZPN8LlWAlJV0d5gRxRn0qtVbecTDBAVg113vAtV2jBLjVuQ7PvvTVJX17oq21xDnDOKc4YXxwYWWpxFbng/4HwI6CYLNqCMFEz0NePTUAkRIqjorysO7kKdL17M9jsGfTyl9SSleBZO1CUfqsB6dffm8QoHhVpMe5zI76PRpDexSGH/QQLlFwVV1DzLBPbFTnIFYf8J3kK8RKGaJtNoYzQG5RFSj5770v1GN+7rixVqPZ25CooxvD6jZGVy1hAE1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781007701; c=relaxed/relaxed;
	bh=y47BTKkIONM0+RQeKdRPDrTRuu7HqPM7iSbtp8PzT1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A17vATe+lfvB488Ymh0Q/uBOadEybgQGyFv326mFTEujcGFiYOwaUqjyBNAjArjjk/UDis5uNw2B2+WIJ9m84Hy6JAJsYzlvGWxZ1CjeBNY/7MyYAuTI9QEg5TnXCvUOPR1RPAvaziPYTBmfZcDuiMeCEJtbkiNQ/l60ZqMIPtd4V3xjMpxAgP0uFrEb12G1c2rH2fAFc6z0CRh80GSdkPKH4hgvmgaE2GSt/E/NsseWes2cgHlCsPMUiPauPW0nbonItPZFjmyAVhkfQNAOtbF4HUl7F5kodLxTexw0lQtjyYuSojwajGL4awW+VM/DShJLeZ77d8WD7SRhUf+qAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=CD54iGf4; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=CD54iGf4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZSh40bZRz2ySf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 22:21:39 +1000 (AEST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-45ef4332d89so339916f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 05:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781007696; x=1781612496; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y47BTKkIONM0+RQeKdRPDrTRuu7HqPM7iSbtp8PzT1o=;
        b=CD54iGf44ynoTYbahAFoolNv3FbnXanmzt+FTw+eCGhkqDfM3omZBpNv5EIN9PJ1sF
         SCiiX+Eeh0zaqecDr2GiDnaMtp/NKeSWOlPr7S9BehzRBS+IZRRhnL80pqNCx+EpY+7g
         yFavUn6957k6JjMi7qfLUUEg8kg5080Yg7Tuh92xaqkSJSIiq4y6KGpBv6yek8Twe+PH
         G68oTdqiziKNj1Gb+gmuvTKbnmVp9bWt52oTfkfxa5019poPEFv2oS7wl6yUJdzS6azL
         uhflQwosnwMPG7Pfq18MsmhH+XMC+xp3Y+x57m2rJqtTHjpKgMWaI3pSnzA1Zy7tIimi
         hF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781007696; x=1781612496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y47BTKkIONM0+RQeKdRPDrTRuu7HqPM7iSbtp8PzT1o=;
        b=L3TE/+QQ3i8GP1eT7Vd6VJcNfFcKfVMpKfwYiU/AJzYiqbUJGBCZjBpR4VqcnByqgM
         g4uEhYC7CjcXVtA8W/TxBqDjcADssOpnQ36SPdCSS8/jC5ZLmRH+H1pf6hvHUadfuTBH
         17NNgBkgiQJqSAq+jHOVfYKmnXSIqyHXRIISVNxM9FeTWyPawPPWuULS4vVNI2X2I0jL
         qXf+DOewocTMmyLJ4ixKg+GbikQVald+o94rROtnesbDGorvJolYzBWiVSC9ttuZLJgw
         vHr/Ox+rvvoE8Iovo11PHilMcFm04Ni2zMhVXYx4ZxEPcwAPrGLcT1wY6z4ECsmtVHJ8
         PJqQ==
X-Forwarded-Encrypted: i=1; AFNElJ9C9V3uzu+zbVRkRL8C/dwdmnSanPMlmKSw9Lqm1ArvrqwlpmS8fKJv88Jz6pcGhJm20kod4zYILqfGv14=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzKh5mYNJJXMv3hBUGfxTzYVN9qnF5tmJLtWDvwSLQidzzgw50H
	0O6hc9e6T5h1KAHo9xlITtDa9C2v9JB5jUoS47K4IyrrpAqRqJ/9bPUGRvA1MvONZy0=
X-Gm-Gg: Acq92OEgoYHcm1+nOS8bMGNSfCv4VyLK+68rjRdbpjdhxzx+RHBHkYpZZlrXTL1gL4G
	3D5TaQ72FzBVH9YcTuKsmop+zgLuGDaHL93FYPq5+PTJTK9IB3m6VTi7i1XpATO467hMGGCR5Gr
	8v7SMvPNwDWXAUocTtQ+ocXF/pnnhdNU8lGjXK1jwtZeOqfCWSyooHPpXcBqc8FAjL0P1qlyi/U
	6jTx442KNxVcKlQWgjz4wUuW22O3vMY1srpHhAci/JEwOl4IUXpn4vv1iPPA8W8RzUHT7KvIQlf
	r9wSR2ce1yp/uduQe2/WW7kXf6Ue6nYqAl4nJaOLWwMpDG8O3G3u2D77rdbgiJ3C5KXVJyOYBMz
	pjWgXIAGDHIb9jAdV5WrKpkFMSIZZ9tBakIToCeJiUkmoDw/UJK9SGMW1eQRNey9UcmMPyavZ//
	ko8ie9oNK2mNTt+jCXq8/hPuE=
X-Received: by 2002:a05:6000:1a88:b0:460:11ac:d58 with SMTP id ffacd0b85a97d-4603064331fmr16626567f8f.3.1781007696224;
        Tue, 09 Jun 2026 05:21:36 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm60125048f8f.12.2026.06.09.05.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 05:21:35 -0700 (PDT)
Date: Tue, 9 Jun 2026 14:21:22 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Will
 Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price
 <steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Alexey
 Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
 Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, x86@kernel.org, Michael Kelley
 <mhklinux@outlook.com>
Subject: Re: [PATCH v6 05/20] dma: swiotlb: pass mapping attributes by
 reference
Message-ID: <20260609142122.7e721621@mordecai>
In-Reply-To: <20260604083959.1265923-6-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-6-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 14:09:44 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Change swiotlb_tbl_map_single() to take the DMA mapping attributes by
> reference and update the direct callers accordingly.
> 
> This is a preparatory change for a follow-up patch which updates the
> attributes based on the selected swiotlb pool. Keeping the signature change
> separate makes the follow-up patch easier to review.
> 
> No functional change in this patch.
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Thanks
Petr T

> ---
>  drivers/iommu/dma-iommu.c | 2 +-
>  drivers/xen/swiotlb-xen.c | 2 +-
>  include/linux/swiotlb.h   | 2 +-
>  kernel/dma/swiotlb.c      | 6 +++---
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index c2595bee3d41..725c7adb0a8d 100644
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
> index 133bb8ca9032..29187cec90d8 100644
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
> index be4d418d92ac..78ce05857c00 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1391,7 +1391,7 @@ static unsigned long mem_used(struct io_tlb_mem *mem)
>   */
>  phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>  		size_t mapping_size, unsigned int alloc_align_mask,
> -		enum dma_data_direction dir, unsigned long attrs)
> +		enum dma_data_direction dir, unsigned long *attrs)
>  {
>  	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>  	unsigned int offset;
> @@ -1425,7 +1425,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>  	size = ALIGN(mapping_size + offset, alloc_align_mask + 1);
>  	index = swiotlb_find_slots(dev, orig_addr, size, alloc_align_mask, &pool);
>  	if (index == -1) {
> -		if (!(attrs & DMA_ATTR_NO_WARN))
> +		if (!(*attrs & DMA_ATTR_NO_WARN))
>  			dev_warn_ratelimited(dev,
>  	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
>  				 size, mem->nslabs, mem_used(mem));
> @@ -1604,7 +1604,7 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
>  
>  	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size);
>  
> -	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, 0, dir, attrs);
> +	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, 0, dir, &attrs);
>  	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
>  		return DMA_MAPPING_ERROR;
>  


