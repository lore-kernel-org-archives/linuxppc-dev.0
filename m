Return-Path: <linuxppc-dev+bounces-20926-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF86CD37AC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 23:01:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gG88d0LHKz2yF1;
	Thu, 14 May 2026 09:01:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::82d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778680654;
	cv=none; b=Tl5hqZqrpYkWYM56Vd8jRX8aZFwqT1OkQYz7JN/yxBeHnGzPGhg1vkoAGYnSNOt6kM5aP2dCdalOfpRZ9Ybe5aoBRgcJvQShJWNeQXnZ/K3lxh2UPKE9tcBPrue/xjXl96qcy6v7HFPHsZ9ZOUU5rJG7yoFd+QgAJiMX0hc3JAthIgE/dqlquGgOuTNNthtElZs56gXGe7u5YEDJrfhLPXeDGdaUilG/KZZeg+iGbXFoQaySfk5h4sJw+CxNWY7vJ5rbEj9d35q4yz1048Sy0IEF9hk2sxfl5+f89+jtd4BflK562xJtLQMX9oGIZQI7XZ+vvIBKnFe3xT0WAghjvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778680654; c=relaxed/relaxed;
	bh=RC0MVOdN5acyyI+7Hj0grkgWIyN6rVofWs5PThfM++E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZVqCo3g6Q3+b1NCXsFXavIRSPS6QzAkaI7ln06doYSasGK5xoYb9mF2jnyEghkEe4wIH8Y3vZ1RY3nkJmqsWVYX8dEYj+teiDcUsWCIRQj//HAnyx1fdeJr76T+g+9dd46hjF6p89zm5l+BTw312GsV0RdL4Z81lMkZq1r/QROvGFJaVWRqFbciAUHojPmqcA1UL/2mNz5SXHnLslWVZiFlefTzoXuIP3Ru9YDVPbPJvTYOeQFkjbkx5zdRncDE+36eGv3clhIA2iKW5NOc5ycYm7RJyiEBZONawyqy8Kk4uG0+lhX5QOP6CJu7WxXRAtjTtedV62UErcfSAqzOsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=t02/IDuO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82d; helo=mail-qt1-x82d.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=t02/IDuO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82d; helo=mail-qt1-x82d.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFw5856CRz2xlV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:57:32 +1000 (AEST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-50d864c23bdso16511cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778680649; x=1779285449; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RC0MVOdN5acyyI+7Hj0grkgWIyN6rVofWs5PThfM++E=;
        b=t02/IDuOUioOszXRl92pN0lz5tRxOCzRpNp+f0Bn9O5dkJ1TA2Q0MlF2X+cnDFDit1
         mgljqCrrKtjMaMrDIUsrlQikOqQ7OV3Z5YK42kRFLSSDRas8qDZCEXTtrYE9mCJkt+Zt
         QEZfHi6v5hjkXcfhPs5plArKGy7nAL0lEkFFdx9DlTVlq2f/1btlHEQGn6R6O9HDwKyA
         8evu9/1M/w61QGbcbiwqQAD3PM9s9ooG9K35m4mawrfuWZbhivnhgNQ4LzZNHItKOuKp
         Lk7GsQzdRBT/n1uq7SggkC/gQROJDix8N/cY+DbMf1+/1T+MCrojtWNyjLmV7Zp22zBn
         s44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680649; x=1779285449;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RC0MVOdN5acyyI+7Hj0grkgWIyN6rVofWs5PThfM++E=;
        b=l5yMZ+c31IGYM6kSY3S1zeIc1tvs19r9eRMy5IXU+sFbcXqCSCO83TSiM2LNpJn8sl
         pmYFYVIo0lBpjUgSKlz95BcUbnCdiTUdDmAc1UXsLwfJ4LzUbdYassLzDEgowfN1IoHw
         liWlDjWj7MxgKhkS0nFBUfh/n7HF9a57JW7uG/1jfb7j75dv3hyN330SuwMSWjEGvJqs
         JcBrVEfKwHCdd2cBrALrOkv4wQazbj56poImWkENbIs4Ecs3iQIgJEQpfOft52Kc4uFQ
         HRhacEYbD9Wd9RR/ZgqhLlJEr8fi8aqupRPmyyMyqT6py+y4sFdHhYT6MyEBe2QjDVqI
         TP/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8SZT7UNlOG14StF2iqQvwWegAlB3T1WJc6nzHRcnWQiURST6FK+OWciJaygx/YAmz0f/dPLUA4YWYowPI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw+YzGctJV+UNbmgECruzbHUwBsAt0AY0ejl7VWFuW3uDlbzFX6
	wKJFsx5DltWohzq+dAGt8HL2WMquBPFc4Znk7ppaw6D19GJzSiQRNQbiAy8bGHl8AQ==
X-Gm-Gg: Acq92OFAS5dAIXM5OVU1DOM4uEWv56pC9YMpAKHrescgWY3g5ZhH/UqKGrjrodNow0W
	fH4Fc3IyhY9zLB1a4ly6QgDYQaVZXIbrXA2NKlDgQQulJPm/NqYApHl+dZGyvk8P6e6U51v3Hif
	Q8J3SATbppcn4SgDwM240NpHZzYK38Ycw8ZJPU05ik0iX37Ji4OZEqaD5yvGKefmWtN2q1QObM4
	iDME/f3QtbB6cwqJ1OmQBS5cKxTh5wQYUpt3IpA60lVd6CH3VlrxDPirZicaSmMpe1ZYdCROh93
	Wice830bmrEjQK8uxfykElSvhhzxuOin20MWRp0SPXWQJ0Q3xUhuZoqgmIZOqbJ9gbcY0ZT0maz
	uGVXue58L/6TWIcT+z0Dvxctom3q5y0ppAxOCj4Iz5vQ+dRmH8vhqtsTV0VPOorocoVNhHPHRhT
	7MYv5qXzAMJ44RgNiN0LHY6vio19grylFxcLqMSoF4ljkrCnROClqwdlihfmNyvcvNQOv1
X-Received: by 2002:a05:622a:5885:b0:50e:5e19:587a with SMTP id d75a77b69052e-5162f6cdb43mr14055691cf.3.1778680648735;
        Wed, 13 May 2026 06:57:28 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6652744asm186174597b3.1.2026.05.13.06.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:57:27 -0700 (PDT)
Date: Wed, 13 May 2026 13:57:16 +0000
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 01/13] dma-direct: swiotlb: handle swiotlb alloc/free
 outside __dma_direct_alloc_pages
Message-ID: <agSDPJMZkcI-uH8f@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-2-aneesh.kumar@kernel.org>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512090408.794195-2-aneesh.kumar@kernel.org>

On Tue, May 12, 2026 at 02:33:56PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Move swiotlb allocation out of __dma_direct_alloc_pages() and handle it in
> dma_direct_alloc() / dma_direct_alloc_pages().
> 
> This is needed for follow-up changes that simplify the handling of
> memory encryption/decryption based on the DMA attribute flags.
> 
> swiotlb backing pages are already mapped decrypted by
> swiotlb_update_mem_attributes() and rmem_swiotlb_device_init(), so
> dma-direct should not call dma_set_decrypted() on allocation nor
> dma_set_encrypted() on free for swiotlb-backed memory.
> 
> Update alloc/free paths to detect swiotlb-backed pages and skip
> encrypt/decrypt transitions for those paths. Keep the existing highmem
> rejection in dma_direct_alloc_pages() for swiotlb allocations.
> 
> Only for "restricted-dma-pool", we currently set `for_alloc = true`, while
> rmem_swiotlb_device_init() decrypts the whole pool up front. This pool is
> typically used together with "shared-dma-pool", where the shared region is
> accessed after remap/ioremap and the returned address is suitable for
> decrypted memory access. So existing code paths remain valid.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/direct.c | 44 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 37 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index ec887f443741..b958f150718a 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -125,9 +125,6 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>  
>  	WARN_ON_ONCE(!PAGE_ALIGNED(size));
>  
> -	if (is_swiotlb_for_alloc(dev))
> -		return dma_direct_alloc_swiotlb(dev, size);
> -
>  	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
>  	page = dma_alloc_contiguous(dev, size, gfp);
>  	if (page) {
> @@ -204,6 +201,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
>  	bool remap = false, set_uncached = false;
> +	bool mark_mem_decrypt = true;
>  	struct page *page;
>  	void *ret;
>  
> @@ -250,11 +248,21 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	    dma_direct_use_pool(dev, gfp))
>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>  
> +	if (is_swiotlb_for_alloc(dev)) {
> +		page = dma_direct_alloc_swiotlb(dev, size);
> +		if (page) {
> +			mark_mem_decrypt = false;
> +			goto setup_page;
> +		}
> +		return NULL;
> +	}
> +
>  	/* we always manually zero the memory once we are done */
>  	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
>  	if (!page)
>  		return NULL;
>  
> +setup_page:
>  	/*
>  	 * dma_alloc_contiguous can return highmem pages depending on a
>  	 * combination the cma= arguments and per-arch setup.  These need to be
> @@ -281,7 +289,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  			goto out_free_pages;
>  	} else {
>  		ret = page_address(page);
> -		if (dma_set_decrypted(dev, ret, size))
> +		if (mark_mem_decrypt && dma_set_decrypted(dev, ret, size))

I am ok with that approach, but Jason was mentioning we shouldn’t
special case swiotlb and make the allocator return the memory state
(similar to the dma_page [1]) . I am also OK if you want to merge that
part of my series with is.

[1] https://lore.kernel.org/linux-iommu/20260408194750.2280873-1-smostafa@google.com/

>  			goto out_leak_pages;
>  	}
>  
> @@ -298,7 +306,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	return ret;
>  
>  out_encrypt_pages:
> -	if (dma_set_encrypted(dev, page_address(page), size))
> +	if (mark_mem_decrypt && dma_set_encrypted(dev, page_address(page), size))
>  		return NULL;
>  out_free_pages:
>  	__dma_direct_free_pages(dev, page, size);
> @@ -310,6 +318,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  void dma_direct_free(struct device *dev, size_t size,
>  		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
>  {
> +	bool mark_mem_encrypted = true;
>  	unsigned int page_order = get_order(size);
>  
>  	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> @@ -338,12 +347,15 @@ void dma_direct_free(struct device *dev, size_t size,
>  	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
>  		return;
>  
> +	if (swiotlb_find_pool(dev, dma_to_phys(dev, dma_addr)))
> +		mark_mem_encrypted = false;
> +
>  	if (is_vmalloc_addr(cpu_addr)) {
>  		vunmap(cpu_addr);
>  	} else {
>  		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
>  			arch_dma_clear_uncached(cpu_addr, size);
> -		if (dma_set_encrypted(dev, cpu_addr, size))
> +		if (mark_mem_encrypted && dma_set_encrypted(dev, cpu_addr, size))
>  			return;
>  	}
>  
> @@ -359,6 +371,19 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>  
> +	if (is_swiotlb_for_alloc(dev)) {
> +		page = dma_direct_alloc_swiotlb(dev, size);
> +		if (!page)
> +			return NULL;
> +
> +		if (PageHighMem(page)) {

My understanding is that rmem_swiotlb_device_init() asserts that there
is no PageHighMem()? Also a similar check doesn’t exist in
dma_direct_alloc().

Thanks,
Mostafa


> +			swiotlb_free(dev, page, size);
> +			return NULL;
> +		}
> +		ret = page_address(page);
> +		goto setup_page;
> +	}
> +
>  	page = __dma_direct_alloc_pages(dev, size, gfp, false);
>  	if (!page)
>  		return NULL;
> @@ -366,6 +391,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  	ret = page_address(page);
>  	if (dma_set_decrypted(dev, ret, size))
>  		goto out_leak_pages;
> +setup_page:
>  	memset(ret, 0, size);
>  	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
>  	return page;
> @@ -378,13 +404,17 @@ void dma_direct_free_pages(struct device *dev, size_t size,
>  		enum dma_data_direction dir)
>  {
>  	void *vaddr = page_address(page);
> +	bool mark_mem_encrypted = true;
>  
>  	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
>  	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
>  	    dma_free_from_pool(dev, vaddr, size))
>  		return;
>  
> -	if (dma_set_encrypted(dev, vaddr, size))
> +	if (swiotlb_find_pool(dev, page_to_phys(page)))
> +		mark_mem_encrypted = false;
> +
> +	if (mark_mem_encrypted && dma_set_encrypted(dev, vaddr, size))
>  		return;
>  	__dma_direct_free_pages(dev, page, size);
>  }
> -- 
> 2.43.0
> 

