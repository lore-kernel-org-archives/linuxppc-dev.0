Return-Path: <linuxppc-dev+bounces-24943-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63FFC53219
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 14:25:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8d6F0Mg4z2yjN;
	Wed, 29 Jul 2026 00:25:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785248725;
	cv=none; b=ZVWqQqLPfL3M3HzbaWmcRQnDP7fneW7u8LXxbZJXs+7Ux8j2wR+NCEDMnPCxUUXfZnbGOYGQ1D7lS5tafXFNxrUna6kGmOfwg0ahjqAz7FU+x2cJwIns0oDUYvQpQ/F9lI+dyczRXmgzk+RcadCeq60ema4jndhJpFmJR98+2imcug1DlIvXq9Ibgzc6QdBOj6eQdMsO9Qi9yELFddTrrOXisowd1RtAg21cZKWZ6BB+y8BYylG9qD8/VTz6Ew4N9ucedFrXQiCUBI7s5mEWr/A0WdEq6eVNtBng3LL/mLxHPIV6Kf8K04YnTELK6qhA1p6K/K61v9cz5ZvMLmpATw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785248725; c=relaxed/relaxed;
	bh=Hhyo6VG61tN8AV0h0asytp+Vqc/+CnuTmYLnyeoXGkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvD3TxJa/kcuA4N/4Jy1r0TDmoNgyQl616hjv1P7kxJ66qCyMUCYYqWHW9unEiXzcJkcl+/LhMiOPEOf2Wwxio/gqVCiEvA5VlhoDtID26wECgryCaBp2xyED3uAERRM70MM0DPNtRwTWgx8iUXjaOXhrp4TJSt/I+3sjO170SY/35FVyH+Wss/EbH2Iac7sPXKAS3VvDRMfSvPkgGXNSB7pqIW4OzN8Wp9vsQGHUpzSHWQbUiEiDrSYnH/lcheHaCYNbR1AIIzrmwLqRrXAjeM7RjAgIwdFUhGkvGF7yyJjPZxM76lqYFP0LS00efTw0yTSM37h8S+VAhrAOhn/fA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QBdEjFp+; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QBdEjFp+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8d6C71b7z2yj1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 00:25:23 +1000 (AEST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4954d5d814fso69905e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 07:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785248721; x=1785853521; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hhyo6VG61tN8AV0h0asytp+Vqc/+CnuTmYLnyeoXGkw=;
        b=QBdEjFp+P2GjqrqSl//SC559d2JcxA4GjyMbDkGnVFf10o4vWTq0tpvhmzTNKhkLIE
         nLQIRNWUa0w3FxYiWxY2v8+dcbc7gaS4bFsCz5BoS6jldd0tG1lAk6EQ+IaeScrqB+VQ
         88OvSeCTPDzZde5j7svQXYAzJZguOc1EXPpZoRrmgOeOmok9MjCZymhqHlOPVkCydlYZ
         CGOaz97xn6zh6fo0ngxpDdJYo1YrWdkdaOuDkYMD2yLkgwo2U0YY3yWWgPZuCkIA0gTC
         z6ryPl/6SMxPCh/2kgY/BEwsl3wxQTpFo1lDfjm+yTUHtzuOMcRjOexXCXDKist9XVmu
         N6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785248721; x=1785853521;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hhyo6VG61tN8AV0h0asytp+Vqc/+CnuTmYLnyeoXGkw=;
        b=RqUn/uTbEF3Z85zoKyQFJ4Wn68sVRxMETNEdXMJowcLTSSh8Hi+7VVZUt85T8Y6fT7
         Nw6zoD/CUe/9mM8aSd1nxww4qf0wzcwub3GQ2rOGMAUUsoTNMBK9MN7SSXapk3Ujw5bm
         edk2npHZx5BQc3FJNYmH4W9RsD+5BBu6b9PkEZgAy/ZnGCGXaWC+LlSXMxbFJISsi7q1
         djxAhryH7IFj/bJ+EMlvInMJljX6dhmkUUmmGDW7qfBzOWjhJtZ4n+t7jgTbLacm+dz+
         qkgco45tKXtn7N1RbJrlg7JyNHgfnRiSOjHE22fbe7BRYRvsJ6u6fcPdYMyibPAZkh21
         Yt9A==
X-Forwarded-Encrypted: i=1; AHgh+Rr6OqlPOpQzsm5+RggVeA2+0ZtG3HuORjjnnC+ayqtiW7tCZHDf6etdotD4TQROL0HSoK8zvYYHnpGeeQ4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx6/vkkjvZ7GeJw6f2xhuabJhisyL/4UKbyrgdh09r1lRenykh1
	HWCpoxJi53Kk9HIjSzDXZgdREGZ4iIwCgWL45/JNvWO7eyG2S8TGn6arAA58Xi8iiw==
X-Gm-Gg: AR+sD11HzBH7/GogT1rbNQkqvJcW7CZZ/MenFefvws6dUeXZ3Vk5Nu5Ve+yMCidRK5H
	KBwRmstg4Lpe8AY0aHaAFf5FwX1wxx5GAIA++wKss1sN0KbtXZ6UhO0HByiGe0nzV63RgZnyw5J
	xTQGc199dAm5vQdv6HNzYOXiTR211gyEwH20SC+5M7/9NjB+QPuTqxXcE71CpWd01n4f4G1EDHS
	210kgN0ih/aSQQdrHmB+cZDHaSOI7wy4niNhjRUD3wp2azPhe7NEuf7a/v+3U3JLe7T/aMDum1N
	lTskyq4dHDZ2nQRfUQQ+l+cULvJoaKmHhMa3vFW2o4X4kHrG5byWut0aT43KbJ+w4DZogV0GtHx
	jNgSZdsTR3Pqh1yJQrk5yLBR1hS0a9d2IwcMwUe++OXdIAmuvXe6H1uRZT1ktQGgZLKbX6CV5ZS
	oDotvSE2+RXOlBaMcx3qp7M+b2LNR+P6KQyg8G3uMvnJ4=
X-Received: by 2002:a05:600c:6a8d:b0:493:b47f:a24 with SMTP id 5b1f17b1804b1-496b4d2f236mr4342575e9.6.1785248720307;
        Tue, 28 Jul 2026 07:25:20 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c45e0424sm84654015e9.13.2026.07.28.07.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:25:19 -0700 (PDT)
Date: Tue, 28 Jul 2026 14:25:11 +0000
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
Subject: Re: [PATCH v8 05/23] swiotlb: Preserve allocation virtual address
 for dynamic pools
Message-ID: <ami7x9uXfRLmjVhK@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-6-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260717180442.110954-6-aneesh.kumar@kernel.org>

On Fri, Jul 17, 2026 at 11:34:23PM +0530, Aneesh Kumar K.V (Arm) wrote:
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
> Fixes: 79636caad361 ("swiotlb: if swiotlb is full, fall back to a transient memory pool")
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  kernel/dma/swiotlb.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 1abd3e6146f4..6e8db52866bf 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -266,9 +266,9 @@ void __init swiotlb_update_mem_attributes(void)
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
> @@ -409,7 +409,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  		return;
>  	}
>  
> -	swiotlb_init_io_tlb_pool(mem, __pa(tlb), nslabs, false, nareas);
> +	swiotlb_init_io_tlb_pool(mem, __pa(tlb), tlb, nslabs, false, nareas);
>  	add_mem_pool(&io_tlb_default_mem, mem);
>  
>  	if (flags & SWIOTLB_VERBOSE)
> @@ -507,7 +507,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  
>  	set_memory_decrypted((unsigned long)vstart,
>  			     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
> -	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), nslabs, true,
> +	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), vstart, nslabs, true,
>  				 nareas);
>  	add_mem_pool(&io_tlb_default_mem, mem);
>  
> @@ -605,25 +605,26 @@ static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
>   * @bytes:	Size of the buffer.
>   * @phys_limit:	Maximum allowed physical address of the buffer.
>   * @gfp:	GFP flags for the allocation.
> + * @vaddr:	Receives the virtual address for the allocated buffer.
>   *
>   * Return: Allocated pages, or %NULL on allocation failure.
>   */
>  static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
> -		u64 phys_limit, gfp_t gfp)
> +		u64 phys_limit, gfp_t gfp, void **vaddr)
>  {
>  	struct page *page;
>  
> +	*vaddr = NULL;
> +
>  	/*
>  	 * Allocate from the atomic pools if memory is encrypted and
>  	 * the allocation is atomic, because decrypting may block.
>  	 */
>  	if (!gfpflags_allow_blocking(gfp) && dev && force_dma_unencrypted(dev)) {
> -		void *vaddr;
> -
>  		if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
>  			return NULL;
>  
> -		return dma_alloc_from_pool(dev, bytes, &vaddr, gfp,
> +		return dma_alloc_from_pool(dev, bytes, vaddr, gfp,
>  					   dma_coherent_ok);
>  	}
>  
> @@ -645,6 +646,8 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
>  			return NULL;
>  	}
>  
> +	if (page)
> +		*vaddr = phys_to_virt(page_to_phys(page));
>  	return page;
>  }
>  
> @@ -685,6 +688,7 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
>  {
>  	struct io_tlb_pool *pool;
>  	unsigned int slot_order;
> +	void *tlb_vaddr;
>  	struct page *tlb;
>  	size_t pool_size;
>  	size_t tlb_size;
> @@ -701,7 +705,8 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
>  	pool->areas = (void *)pool + sizeof(*pool);
>  
>  	tlb_size = nslabs << IO_TLB_SHIFT;
> -	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, gfp))) {
> +	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, gfp,
> +					 &tlb_vaddr))) {
>  		if (nslabs <= minslabs)
>  			goto error_tlb;
>  		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
> @@ -715,11 +720,12 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
>  	if (!pool->slots)
>  		goto error_slots;
>  
> -	swiotlb_init_io_tlb_pool(pool, page_to_phys(tlb), nslabs, true, nareas);
> +	swiotlb_init_io_tlb_pool(pool, page_to_phys(tlb), tlb_vaddr, nslabs,
> +				 true, nareas);
>  	return pool;
>  
>  error_slots:
> -	swiotlb_free_tlb(page_address(tlb), tlb_size);
> +	swiotlb_free_tlb(tlb_vaddr, tlb_size);
>  error_tlb:
>  	kfree(pool);
>  error:
> @@ -1851,7 +1857,8 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>  
>  		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
>  				     rmem->size >> PAGE_SHIFT);
> -		swiotlb_init_io_tlb_pool(pool, rmem->base, nslabs,
> +		swiotlb_init_io_tlb_pool(pool, rmem->base, phys_to_virt(rmem->base),
> +					 nslabs,
>  					 false, nareas);
>  		mem->force_bounce = true;
>  		mem->for_alloc = true;
> -- 
> 2.43.0
> 

