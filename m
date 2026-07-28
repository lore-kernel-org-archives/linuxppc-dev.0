Return-Path: <linuxppc-dev+bounces-24946-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33468C54F4C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 14:30:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8dDN4r32z2yjN;
	Wed, 29 Jul 2026 00:30:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785249044;
	cv=none; b=S6yOXcQfyd4fjmgcG77WHV2kL2DxI9DlA+W0ZDEnqE/IROnZ4oAIC8GxCdefIth53rtfEBQGx1Z7hVFNnPiacZ/Qi4b6H0x3vbMUomxABqhN5k15rzvxgX5ntE7+7UQ4zT/lJz4dPhTen1PsAsVeTfFCKIC1Rgclfz+7zJTqqalldNCy681rJe1eiFb6XLGAV8p5Zhlyd/ITktWlQhTEuyIXfwhG3gEmv1G4rVhEarffG0VKlhZw0F3j3r9SvHGYmJDNg4+IRQ7u8+nKxu6fmmieNHhAH5MSvt5HlTEf5x0V41LISuSnn1cAMnLZiysjtkxOtfT+b2EqdJJeA0xISw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785249044; c=relaxed/relaxed;
	bh=n7ks/Fyt5IClzQtUiNDuj+0oa2UT627bnJeYPNERE0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmv7J/Tx+nC6S9RmNf7R6Skv9SJiLAYULLToRIDI/mJOgSWkX/Wq7fTNCk2nLWRXd1PBpZ08NCX7EQytZL8dj2ZXk7T7iU6RiVgeOqvKY0SnmQPd5taWubqgShFA+iu8ShxHIzgV5HygVcZx/tqIu2EKELNNjQ6MIhmLXdR7IBO7mieoKrdTz2W1N7Lm+CSYa/fboEOTzw4pNYx39Ic5jHjPdtquddq/Czv6FrsK4hxl1fWVN4CPfIB4uxbcFLtBiGyXFjfJN7MBflh67DFVQ3Y6cNnL8Xw+j2nK3UZghvshp9UbZ7uu11oNyN+QpRCRU93SwtI7741CPYCZKYDC0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TgtdQZl7; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TgtdQZl7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8dDM3Z0Fz2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 00:30:43 +1000 (AEST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so62825e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 07:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785249040; x=1785853840; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n7ks/Fyt5IClzQtUiNDuj+0oa2UT627bnJeYPNERE0g=;
        b=TgtdQZl7CxFghcPrwyTGwAOv/FCPuouZHE9mAnUMPdi69sAbVVBU+l4rG15TnyE4rr
         JmX3kwd4PNsX8yI2fa9GBFc0UAE7JFODmfRITvSaZcfScRSOIvEhPJQhI18KTK4rxOBk
         cBzt0RCqJi5pdMGxJ+bJYpQb7Z9c3pSCYi1T98wuif+uXFFXFhXCw3+R7TbABneEXT2m
         h9HBI7NCJZrdpBfIWN20znoObFC4PPfUOzOYyejdsKMNjl7ipbdHF5PNBG4fA1wfPyhC
         tCPadss3nYWapjuo3HyKmRJxCEkbvaGKNOANw7dW/RMeqTOPpninM5h1wWU+c/SUd6db
         CrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785249040; x=1785853840;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n7ks/Fyt5IClzQtUiNDuj+0oa2UT627bnJeYPNERE0g=;
        b=W4Lxnjhi0ttV660mmjhgLjb/KbN3Nh5FLL5SuklEDBjXsVG5g8tyqSEhyQQRG1LZhe
         ++aJ2bsYSNRFq1ByIal5Uu2NQJLOCPvTpU55HhJY4+DvSZtMLnvt4WiTQ99K8c0RKtTy
         65Wv6eqYT4MrIhGNeDZ7Igdz16QZSsi7x9GbDv1p7oFmIiz6Co8vsGXO8G4Jod+RJV8M
         ywIuXISerNlyZVJHQLItNbYOMvUHeY3X6ERKApWjMWZc9AEx6xxbeoxggcuyd4En96Z8
         cPPNiR8kTPLaaSROlLFu0xuwnrad8igeKRvzc037B69eM+avvYOuPD9MrbuFJBMQIevj
         E1Xw==
X-Forwarded-Encrypted: i=1; AHgh+RrcJAkWhAHXB4ixlDK7rCKAVt3eAbTdABc2q5CXY0gVtsUcRL5rXljmgOv0Ic9SJoEktpIt/b5dYZFPBIQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwbBUlWEchqAilMFPVgXQsGJsmBaggzUiJ0YwTvC5/6IfJYsbit
	0KS/bZjrvjw8XESaib/8K/CEoSderPLoeqOtetUMLYbNeSM7/tV+Ra/NgK/XSqofwQ==
X-Gm-Gg: AR+sD10vuWI2SFuOGCSodUCTAJrUgRGKEl8OAUkfMAHADzAvgVS5HlDmHfGIAcyt1lD
	4d2zcbyNhPRiWG2mYu89tCla5Y4jm3ULBO6EAwg4I/VUtc5ffpzWx7TQfXnGKJ9QoSm5XZeAfT1
	PrCI6UU2PhRFB1SVZ9V8q/qcFQ1+rLmzyJCJ91Hu1TTfzMr4f8+/67f9tzj5V0zwT115XqNhI88
	BdQCI9VrmWEJs+YSBavYVXxYBVtCUZdUL/BDdoyGQ4GMg7amCkXBU9vYB+Ieun/p1Ex7oQyaAWZ
	ATHO897ZF5gYLB9LID+yTgsSRJ/Lz2xck0ukyIDwEbAue7KsH0KsnmtR8TbF4Zn5ErFjuZ5+5pt
	C171WbhwBYPDxrf0SJCfwTfaKbB2roCaUMZ6ds4bg39EhTQvFuBToFj1BSI7rLVNkuI0yvdA1mk
	IS8tK+/hs98cNUzIjVgLJe4ZS/YfWXO3rn+j/UCFTYYPAfIGKLb8kzxA==
X-Received: by 2002:a05:600c:c0d2:20b0:495:6d47:59b5 with SMTP id 5b1f17b1804b1-496b4d2f828mr44175e9.6.1785249039185;
        Tue, 28 Jul 2026 07:30:39 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c4632263sm89342385e9.15.2026.07.28.07.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:30:38 -0700 (PDT)
Date: Tue, 28 Jul 2026 14:30:32 +0000
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
	Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 15/23] dma-direct: pass attrs to dma_capable() for
 DMA_ATTR_CC_SHARED checks
Message-ID: <ami9CIGanuQX3lxb@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-16-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260717180442.110954-16-aneesh.kumar@kernel.org>

On Fri, Jul 17, 2026 at 11:34:33PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Teach dma_capable() about DMA_ATTR_CC_SHARED so the capability
> check can reject encrypted DMA addresses for devices that require
> unencrypted/shared DMA.
> 
> Also propagate DMA_ATTR_CC_SHARED in swiotlb_map() when the selected
> SWIOTLB pool is decrypted so the capability check sees the correct DMA
> address attribute.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/x86/kernel/amd_gart_64.c | 30 ++++++++++++++++--------------
>  drivers/xen/swiotlb-xen.c     |  6 +++---
>  include/linux/dma-direct.h    | 10 +++++++++-
>  kernel/dma/direct.h           |  6 +++---
>  kernel/dma/swiotlb.c          |  2 +-
>  5 files changed, 32 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
> index e8000a56732e..b5f1f031d45b 100644
> --- a/arch/x86/kernel/amd_gart_64.c
> +++ b/arch/x86/kernel/amd_gart_64.c
> @@ -180,22 +180,23 @@ static void iommu_full(struct device *dev, size_t size, int dir)
>  }
>  
>  static inline int
> -need_iommu(struct device *dev, unsigned long addr, size_t size)
> +need_iommu(struct device *dev, unsigned long addr, size_t size, unsigned long attrs)
>  {
> -	return force_iommu || !dma_capable(dev, addr, size, true);
> +	return force_iommu || !dma_capable(dev, addr, size, true, attrs);
>  }
>  
>  static inline int
> -nonforced_iommu(struct device *dev, unsigned long addr, size_t size)
> +nonforced_iommu(struct device *dev, unsigned long addr, size_t size,
> +		unsigned long attrs)
>  {
> -	return !dma_capable(dev, addr, size, true);
> +	return !dma_capable(dev, addr, size, true, attrs);
>  }
>  
>  /* Map a single continuous physical area into the IOMMU.
>   * Caller needs to check if the iommu is needed and flush.
>   */
>  static dma_addr_t dma_map_area(struct device *dev, dma_addr_t phys_mem,
> -				size_t size, int dir, unsigned long align_mask)
> +		size_t size, int dir, unsigned long align_mask, unsigned long attrs)
>  {
>  	unsigned long npages = iommu_num_pages(phys_mem, size, PAGE_SIZE);
>  	unsigned long iommu_page;
> @@ -206,7 +207,7 @@ static dma_addr_t dma_map_area(struct device *dev, dma_addr_t phys_mem,
>  
>  	iommu_page = alloc_iommu(dev, npages, align_mask);
>  	if (iommu_page == -1) {
> -		if (!nonforced_iommu(dev, phys_mem, size))
> +		if (!nonforced_iommu(dev, phys_mem, size, attrs))
>  			return phys_mem;
>  		if (panic_on_overflow)
>  			panic("dma_map_area overflow %lu bytes\n", size);
> @@ -231,10 +232,10 @@ static dma_addr_t gart_map_phys(struct device *dev, phys_addr_t paddr,
>  	if (unlikely(attrs & DMA_ATTR_MMIO))
>  		return DMA_MAPPING_ERROR;
>  
> -	if (!need_iommu(dev, paddr, size))
> +	if (!need_iommu(dev, paddr, size, attrs))
>  		return paddr;
>  
> -	bus = dma_map_area(dev, paddr, size, dir, 0);
> +	bus = dma_map_area(dev, paddr, size, dir, 0, attrs);
>  	flush_gart();
>  
>  	return bus;
> @@ -289,7 +290,7 @@ static void gart_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
>  
>  /* Fallback for dma_map_sg in case of overflow */
>  static int dma_map_sg_nonforce(struct device *dev, struct scatterlist *sg,
> -			       int nents, int dir)
> +		int nents, int dir, unsigned long attrs)
>  {
>  	struct scatterlist *s;
>  	int i;
> @@ -301,8 +302,8 @@ static int dma_map_sg_nonforce(struct device *dev, struct scatterlist *sg,
>  	for_each_sg(sg, s, nents, i) {
>  		unsigned long addr = sg_phys(s);
>  
> -		if (nonforced_iommu(dev, addr, s->length)) {
> -			addr = dma_map_area(dev, addr, s->length, dir, 0);
> +		if (nonforced_iommu(dev, addr, s->length, attrs)) {
> +			addr = dma_map_area(dev, addr, s->length, dir, 0, attrs);
>  			if (addr == DMA_MAPPING_ERROR) {
>  				if (i > 0)
>  					gart_unmap_sg(dev, sg, i, dir, 0);
> @@ -401,7 +402,7 @@ static int gart_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>  		s->dma_address = addr;
>  		BUG_ON(s->length == 0);
>  
> -		nextneed = need_iommu(dev, addr, s->length);
> +		nextneed = need_iommu(dev, addr, s->length, attrs);
>  
>  		/* Handle the previous not yet processed entries */
>  		if (i > start) {
> @@ -449,7 +450,7 @@ static int gart_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>  
>  	/* When it was forced or merged try again in a dumb way */
>  	if (force_iommu || iommu_merge) {
> -		out = dma_map_sg_nonforce(dev, sg, nents, dir);
> +		out = dma_map_sg_nonforce(dev, sg, nents, dir, attrs);
>  		if (out > 0)
>  			return out;
>  	}
> @@ -473,7 +474,8 @@ gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
>  		return vaddr;
>  
>  	*dma_addr = dma_map_area(dev, virt_to_phys(vaddr), size,
> -			DMA_BIDIRECTIONAL, (1UL << get_order(size)) - 1);
> +				 DMA_BIDIRECTIONAL,
> +				 (1UL << get_order(size)) - 1, attrs);
>  	flush_gart();
>  	if (unlikely(*dma_addr == DMA_MAPPING_ERROR))
>  		goto out_free;
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 8c4abe65cd49..e2538824ef52 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -212,7 +212,7 @@ static dma_addr_t xen_swiotlb_map_phys(struct device *dev, phys_addr_t phys,
>  	BUG_ON(dir == DMA_NONE);
>  
>  	if (attrs & DMA_ATTR_MMIO) {
> -		if (unlikely(!dma_capable(dev, phys, size, false))) {
> +		if (unlikely(!dma_capable(dev, phys, size, false, attrs))) {
>  			dev_err_once(
>  				dev,
>  				"DMA addr %pa+%zu overflow (mask %llx, bus limit %llx).\n",
> @@ -231,7 +231,7 @@ static dma_addr_t xen_swiotlb_map_phys(struct device *dev, phys_addr_t phys,
>  	 * we can safely return the device addr and not worry about bounce
>  	 * buffering it.
>  	 */
> -	if (dma_capable(dev, dev_addr, size, true) &&
> +	if (dma_capable(dev, dev_addr, size, true, attrs) &&
>  	    !dma_kmalloc_needs_bounce(dev, size, dir) &&
>  	    !range_straddles_page_boundary(phys, size) &&
>  		!xen_arch_need_swiotlb(dev, phys, dev_addr) &&
> @@ -253,7 +253,7 @@ static dma_addr_t xen_swiotlb_map_phys(struct device *dev, phys_addr_t phys,
>  	/*
>  	 * Ensure that the address returned is DMA'ble
>  	 */
> -	if (unlikely(!dma_capable(dev, dev_addr, size, true))) {
> +	if (unlikely(!dma_capable(dev, dev_addr, size, true, attrs))) {
>  		__swiotlb_tbl_unmap_single(dev, map, size, dir,
>  				attrs | DMA_ATTR_SKIP_CPU_SYNC,
>  				swiotlb_find_pool(dev, map));
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index 94fad4e7c11e..daa31a1adf7b 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -135,12 +135,20 @@ static inline bool force_dma_unencrypted(struct device *dev)
>  #endif /* CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED */
>  
>  static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
> -		bool is_ram)
> +		bool is_ram, unsigned long attrs)
>  {
>  	dma_addr_t end = addr + size - 1;
>  
>  	if (addr == DMA_MAPPING_ERROR)
>  		return false;
> +	/*
> +	 * The DMA address was derived from encrypted RAM, but this device
> +	 * requires unencrypted DMA addresses. Treat it as not DMA-capable
> +	 * so the caller can fall back to a suitable SWIOTLB pool.
> +	 */
> +	if (!(attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
> +		return false;
> +

I guess it does not make sense to check the other way? I'd be worried if
some a confidential device uses shared memory which might leak info.

Thanks,
Mostafa

>  	if (is_ram && !IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
>  	    min(addr, end) < phys_to_dma(dev, PFN_PHYS(min_low_pfn)))
>  		return false;
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index 7140c208c123..e05dc7649366 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -101,15 +101,15 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>  
>  	if (attrs & DMA_ATTR_MMIO) {
>  		dma_addr = phys;
> -		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
> +		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
>  			goto err_overflow;
>  	} else if (attrs & DMA_ATTR_CC_SHARED) {
>  		dma_addr = phys_to_dma_unencrypted(dev, phys);
> -		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
> +		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
>  			goto err_overflow;
>  	} else {
>  		dma_addr = phys_to_dma(dev, phys);
> -		if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
> +		if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs)) ||
>  		    dma_kmalloc_needs_bounce(dev, size, dir)) {
>  			if (is_swiotlb_active(dev) &&
>  			    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 335e27bc1e1f..b5960c2e98d8 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1697,7 +1697,7 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
>  	else
>  		dma_addr = phys_to_dma_encrypted(dev, swiotlb_addr);
>  
> -	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
> +	if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs))) {
>  		__swiotlb_tbl_unmap_single(dev, swiotlb_addr, size, dir,
>  			attrs | DMA_ATTR_SKIP_CPU_SYNC,
>  			swiotlb_find_pool(dev, swiotlb_addr));
> -- 
> 2.43.0
> 

