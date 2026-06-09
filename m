Return-Path: <linuxppc-dev+bounces-22340-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DABCD8CAA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 13:40:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZVQy3XFzz2ySf;
	Tue, 09 Jun 2026 23:40:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781012426;
	cv=none; b=PXTrMXEGd1iBb84s9Ghj6kj3ojw/XPH9bxKggEF2MR2pt1wOKQCfK9ExBIxvsC3Dok10UUDwvnwbxAYH636EoZCLFPO/JHkO6ErBpvZxjvvFjT8rgobTeieRhQyVo/cK0s7I386aM0ngj3O0rqAVezwSwyYdKkmB0Ct2TgzYtJLjYew9O8IoFRs9ArfskkWWtm0IbY3xCuNFPmWPQQuLPaJ2duvfBEl6ra0MqB9TlAv7echXG0OL5niJfNVv3UREbTIGN9Qll31LxomZLM/Lbut/GI3rq++ZodhXUKbg2Gn/Y6Mvhbx6ijnH/2jR+DzzIWrfngNxqnsjlVOryEZDOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781012426; c=relaxed/relaxed;
	bh=LapnW6RyijtMlBbcLjGQ51I+00mOkKRbnIVzAqqw2OE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sf3OqR4AS8OpCW+z13qqaCRZU0JdRnDBuEUxYpGsl4bScpAi9UXbGXhXruehCQ7HzJLoki3f/reZqWQwTafNvmT9x5f0MUEr0SEgWDfUveNbwKa9cQnwaoWc1BYf5No2UaTmPc4UF2WCaqjHD+TV9NSPNYOT723/2E0dHa0cGZ14u5rMZvBPF2fwjdnw5s4IGWbxFYMHBOUp+ToAmfBkLq1WPZXKI7QP6YmCuTxEEBEY08Qzwwl1WFt53RWGW72aDUc2/EnL0bJbofPW3+m/HOlcOk9ilnCHKVNzzV6KAjSZV1dcngOvDDWIgSNAKm8kfP5BKbSIzIpGyTG+8ljd/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=KVacdCB6; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=KVacdCB6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZVQx0HyQz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 23:40:23 +1000 (AEST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-490b1c39fe4so5559965e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 06:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781012421; x=1781617221; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LapnW6RyijtMlBbcLjGQ51I+00mOkKRbnIVzAqqw2OE=;
        b=KVacdCB6cWum5Z3+ucN3PHAXAoZykwkTaDA6AZCQYR7AUvvUPUq6VxvGaYhf9Cppzq
         04Y+TKSCh22dR0bJTsKAVDmlMMfWXOLxeRWDK+SkprP/xccZKTmneOTwbAJBAI9hhOsR
         wZCXt507NvfbzbheogarJzp47eThK30nvx2t7kyvBjYmwzTxDXWBqkHWC4Cu80ucDBIp
         ZVwb5WoICyOHCE/c8E0NmK3fceCNreIhk0t/l+xn3zjYUHrupF/0udVNIN+Idraq2KFg
         XDiK9SpoG+u0Dw5jSiS18lmV+RdWAQQRlwhbm93X3HUZvJ5GF4zKvWQmwmKEksjOFVRA
         Ljdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781012421; x=1781617221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LapnW6RyijtMlBbcLjGQ51I+00mOkKRbnIVzAqqw2OE=;
        b=O0eEF8S3iasgYx8OGcd8+MONm8NhcfDgv+df6lKQ7cdCpHLSIuuehKtKNb/cchI/QN
         E5+N6pdtmppldA5rGawhXGi3TS45ZmoQ3Ho9KN+UlVd/Zi6HgmSszJArSPMSG9RA8wqW
         WpvtzCqLBHNMHfETUte/YuvW/W72e2OY6PbPNprpKEVz3VQXv/W2GjKI7l6ZIQSQumJF
         MLLC1wmO3wn3zRGqZz2HKllKktx1ChaztRjMv+YVGCJW2TzzgJF7Xl91VNdG2gSYd7uZ
         v/OQH4nDS9RbiJevk2MpMl36V1y9Rt8LHnE/Fo2x1M+INxZrcwiNxGTPWetaa7nTpV54
         eR7g==
X-Forwarded-Encrypted: i=1; AFNElJ8Sq1lOMtcnOFt+y/Cab/3ZFL/ybSe17c+/xHH65CeOO0ZKAS68Qvje6OeUDCjrNJYNmRYVMVReNW48FEM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz0QDGnpHIzfdKlJkoNDnLT1Qfmnba85Pv1twOYNtwaOrWWksWu
	477O5cBk27yUNyOzn4Da/oBmkvzPSwMT0dl02gmBIhZOG+4j3QozW5KQ0YXfb2Gn9Fc=
X-Gm-Gg: Acq92OHQtZGfEOSQeP/icotD69fCyHuXkQwMMyr1Lgve/ZrOeJXNAnwBZlhMluzkEyy
	Eg2NBc0fq9YCehpYWaGKEYugscDSnvIah2tFduEnbj8rl840Mf6J9dUkAtm3K5jh/uh0otCinLK
	7Vaem01s2+EFYuhCFdegWkqqrlYWfazZlMC7sLIcNt/ZyWPCHvjzrZKwBBC5tQDPl59zjJxZzIq
	bjwIQlg1toQggAgaWGFzSulXC4GkHGoSlSDK1yiRQN5VMIpVx250MDPMmyNgsBg/918dlY1iov2
	PKV2t5PSNYfp4so+85orjwxiXU3+DbvSoz8+AU2RUoO5DVD7IjmQMlkd5/eo6oBcUWwvtds6tTG
	iX5Xgx0h6cYT//4WY0vUgIS266DgHEtbpzA6B9fntSFJUo0NtIar5BLcmMvgqAWtonHFcZRNfSD
	GUemMhLuua87NMMksg7dlbsA5Tt8BPdT6O1w==
X-Received: by 2002:a05:600c:8b82:b0:490:abf1:2ddb with SMTP id 5b1f17b1804b1-490c2603825mr146744795e9.6.1781012421133;
        Tue, 09 Jun 2026 06:40:21 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm68263785f8f.5.2026.06.09.06.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:40:20 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:40:18 +0200
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
Subject: Re: [PATCH v6 19/20] swiotlb: Preserve allocation virtual address
 for dynamic pools
Message-ID: <20260609154018.554e5448@mordecai>
In-Reply-To: <20260604083959.1265923-20-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-20-aneesh.kumar@kernel.org>
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

On Thu,  4 Jun 2026 14:09:58 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> swiotlb_alloc_tlb() can allocate from the DMA atomic pool when a decrypted
> pool is needed from atomic context. With CONFIG_DMA_DIRECT_REMAP, the
> atomic pool is backed by remapped virtual addresses, which are not the same
> as the direct-map addresses returned by phys_to_virt().
> 
> swiotlb_init_io_tlb_pool() currently reconstructs the pool virtual address
> from the physical start address. For atomic-pool backed allocations this
> stores the wrong address in pool->vaddr. Later, swiotlb_free_tlb() passes
> that address to dma_free_from_pool(), which will fail to recognize the
> chunk
> 
> Pass the virtual address returned by the allocation path into
> swiotlb_init_io_tlb_pool(), and store that address in pool->vaddr. This
> keeps the pool free path using the same virtual address as the allocator.
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Hm, so the old code was broken; you may want to add:

Fixes: 79636caad361 ("swiotlb: if swiotlb is full, fall back to a transient memory pool")

And of course:

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Thank you!
Petr T

> ---
>  kernel/dma/swiotlb.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 14d834ca298b..e4bd8c9eaeda 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -302,9 +302,9 @@ void __init swiotlb_update_mem_attributes(void)
>  }
>  
>  static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
> -		unsigned long nslabs, bool late_alloc, unsigned int nareas)
> +		void *vaddr, unsigned long nslabs, bool late_alloc,
> +		unsigned int nareas)
>  {
> -	void *vaddr = phys_to_virt(start);
>  	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
>  
>  	mem->nslabs = nslabs;
> @@ -445,7 +445,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  		return;
>  	}
>  
> -	swiotlb_init_io_tlb_pool(mem, __pa(tlb), nslabs, false, nareas);
> +	swiotlb_init_io_tlb_pool(mem, __pa(tlb), tlb, nslabs, false, nareas);
>  	add_mem_pool(&io_tlb_default_mem, mem);
>  
>  	if (flags & SWIOTLB_VERBOSE)
> @@ -553,7 +553,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  		}
>  	}
>  
> -	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), nslabs, true,
> +	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), vstart, nslabs, true,
>  				 nareas);
>  	add_mem_pool(&io_tlb_default_mem, mem);
>  
> @@ -664,25 +664,26 @@ static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes,
>   * @phys_limit:	Maximum allowed physical address of the buffer.
>   * @attrs:	DMA attributes for the allocation.
>   * @gfp:	GFP flags for the allocation.
> + * @vaddr:	Receives the virtual address for the allocated buffer.
>   *
>   * Return: Allocated pages, or %NULL on allocation failure.
>   */
>  static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
> -		u64 phys_limit, unsigned long attrs, gfp_t gfp)
> +		u64 phys_limit, unsigned long attrs, gfp_t gfp, void **vaddr)
>  {
>  	struct page *page;
>  
> +	*vaddr = NULL;
> +
>  	/*
>  	 * Allocate from the atomic pools if memory is encrypted and
>  	 * the allocation is atomic, because decrypting may block.
>  	 */
>  	if (!gfpflags_allow_blocking(gfp) && (attrs & DMA_ATTR_CC_SHARED)) {
> -		void *vaddr;
> -
>  		if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
>  			return NULL;
>  
> -		return dma_alloc_from_pool(dev, bytes, &vaddr, gfp,
> +		return dma_alloc_from_pool(dev, bytes, vaddr, gfp,
>  					   attrs, dma_coherent_ok);
>  	}
>  
> @@ -705,6 +706,8 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
>  			return NULL;
>  	}
>  
> +	if (page)
> +		*vaddr = phys_to_virt(page_to_phys(page));
>  	return page;
>  }
>  
> @@ -750,6 +753,7 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
>  {
>  	struct io_tlb_pool *pool;
>  	unsigned int slot_order;
> +	void *tlb_vaddr;
>  	struct page *tlb;
>  	size_t pool_size;
>  	size_t tlb_size;
> @@ -767,7 +771,8 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
>  	pool->unencrypted = !!(attrs & DMA_ATTR_CC_SHARED);
>  
>  	tlb_size = nslabs << IO_TLB_SHIFT;
> -	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, attrs, gfp))) {
> +	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, attrs, gfp,
> +					 &tlb_vaddr))) {
>  		if (nslabs <= minslabs)
>  			goto error_tlb;
>  		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
> @@ -781,12 +786,12 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
>  	if (!pool->slots)
>  		goto error_slots;
>  
> -	swiotlb_init_io_tlb_pool(pool, page_to_phys(tlb), nslabs, true, nareas);
> +	swiotlb_init_io_tlb_pool(pool, page_to_phys(tlb), tlb_vaddr, nslabs,
> +				 true, nareas);
>  	return pool;
>  
>  error_slots:
> -	swiotlb_free_tlb(page_address(tlb), tlb_size,
> -			 !!(attrs & DMA_ATTR_CC_SHARED));
> +	swiotlb_free_tlb(tlb_vaddr, tlb_size, !!(attrs & DMA_ATTR_CC_SHARED));
>  error_tlb:
>  	kfree(pool);
>  error:
> @@ -1995,7 +2000,8 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>  			mem->unencrypted = false;
>  		}
>  
> -		swiotlb_init_io_tlb_pool(pool, rmem->base, nslabs,
> +		swiotlb_init_io_tlb_pool(pool, rmem->base, phys_to_virt(rmem->base),
> +					 nslabs,
>  					 false, nareas);
>  		mem->force_bounce = true;
>  		mem->for_alloc = true;


