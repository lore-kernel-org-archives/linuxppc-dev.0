Return-Path: <linuxppc-dev+bounces-20955-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486DBCD4851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 12:10:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGTgS5YXlz2xy8;
	Thu, 14 May 2026 22:10:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778760183;
	cv=none; b=Z8YxtebDOV7wR5bbgZ5673jpmWoizM1F6ypLs2PKKeqnCpbLmv7YH0gLEJ1d3EhwJsAiYNwDqjO0A393SsNRPqEK3fM6NcWUelCZofx+tZXd7TH5aiPB9Eaj/pEqD9//KGpRBM0oCfkQxJtlFDrMHsKR+nauhLKxANqCL83zUkokRAKXb+AEvmYqs4hd49UBEMdbyXwEXBWJMQAprj2VELF9VXUnwd0GI5v59QEMTVviTc+6VAZygznsdVkr7awcmyyGdj2O4EVgeqtl7pwYz2VH3tACo00FJyQsnn35MnwPCa7LTP86GQZFWnIdxFZ/BndXJH3qxS9Bb9C9+/GpmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778760183; c=relaxed/relaxed;
	bh=vJxKoSS948AHETXs6aJtd/s8FhaXTHx5b+RGT+Rq9q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCKKI2aibmadWqTgZviqTVfVNaxfz7ZrXPgOcypPRW1WcUQB+FAenVoW8mm1FoNd0B32wHazh+ayknYZq6tCysBxY5OjpW+8iTrzRTDvBZd9MjmvLPSQUo+GBmMNmPh+zlY8qjw6d1lYMZUq2AxA9Cdfgb8lUsjUMOrpFgjX+TXZkNEq55jngg+6faTu4ehrowGBlkKtoGd8HaFLVGZ70Djf2IYjmYwnZA/dJ+pXf3J40kQUXsyLqNSC/bAGWfV6aTUYp3+0JLnb1ZX9kZdoHiZ9KVGA3/2s1ah25ShFuxm6ZHrFwQCHjfHcZcmyRsgkVEzLw41YWCDP0o4QaQHSPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YKUpZVif; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YKUpZVif;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGTVY50cJz2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 22:03:01 +1000 (AEST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so90995e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 05:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778760178; x=1779364978; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vJxKoSS948AHETXs6aJtd/s8FhaXTHx5b+RGT+Rq9q8=;
        b=YKUpZVifdxhMyIP8Kh9Tp1YCKwe5i6c5HX6v1DDbRaeHi6299RGiZGZHByfiZtzo98
         97li6vqlSaxD8xiPgktbUEzq0F876bi1Boau09yxH802GCbI+d0IWA7kpKTSM2oy5S5U
         8u3h22KDdELlna3RVpDDlIVrg2yqU6iaPkjA83t3PrWsjjeNMlClBJv24tuA/AvmnR1a
         nePIImN5HqrIXvrqL75BKtUfNgkJFLm/ZrCSwjGY8xekNH0IzT+1jhyCvRM4VnF+LKN6
         CPJZ//M9LtctFzZvJrqI0MlRyNL1OUyOwSEBzsFySqO9wcf77n6jxtuyC/a0pXKeYP7/
         HAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778760178; x=1779364978;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJxKoSS948AHETXs6aJtd/s8FhaXTHx5b+RGT+Rq9q8=;
        b=klLnKaqxb4sNHUhGK8nggth4g7ElhNSfpCj6U24lUy7EjozKGvCiWcgkglfpm6GYTX
         2j3yF9oQteNYP/cKt0+31PNkSe0YLfaVUUl2RwmFHjqFKpcADeX/dCfyZQq3xPGyRCZ7
         v0nLEA1NAyR5F8rE2vq1plVI33/WY2BBoGO2qiJWAnEMSz+4lgJS2WUGVkwNFRTP6yfO
         FQa21ePjhkP/dRbEp8G9WVf5vSdWDxgtt1PY2b0vuoHNYS11FGVRlGXROv8U7aVBnu27
         E/PTAze5F8N66F0vCRGoMOMvj0oAWeUZsjW5heuqOdRXk7rUoZjijM3SJ1hEaH1UIMzO
         hYnQ==
X-Forwarded-Encrypted: i=1; AFNElJ8kZEJdQEyXRz7JHPuFLwRHikvPDvZLJPJvTW5X9gyxJNdKVcOw2lhMOL8LQzfE9do+6GH7ivolmU0YrxQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz2YTV3Y1Nh6RyY7GrlV/sO9WPMJI/NTpcs8THni/P8+GJ5kvHg
	JxrJdIkyi3MKE9CQFrYxQTyTove2ly7HY/Nn30jsXE6RJ5s8Pe4LHb4XgKTwPSopNw==
X-Gm-Gg: Acq92OEtf/HTnJXuAUYdIT89JFM9qkrzy0wRZt2F5vZc1oIR7G6Xa1VJDGwBfbyr4MU
	tTGocmrzzWETXUzsMGRrSrVtpFQGb4ndP5U1JujNq+RKKvJEy3kioceADd9us0Z2l5G5WHEf3Hj
	NIwsavRJZVmDnBT1AvRXSkBI8JjM4Ppc1bSx06Y5hBnxy6izK/uLePm+B+l7d00GkjEnhqBSOHl
	K3IN2S1O1YbmM/ZesTQpD0cvzhD2S1sxkSdDaf7th8NAbjFOhKIaiko2NgH5PD9aST651ZMubsZ
	ZXudAQ1uXXZ2SvZda32EN3UxrklSvuCbQfPvmjz+YzBvppuh54dD7BrY3mSAWOIoAbZ3wC4pWpx
	dm47pWTn1irD7mGFaRCeiXNSRLAcn9E8qLM2TuyMukJPc9yYqi4LBaDOh9wM3T1R3iY4nJgRzkj
	e/ysJBBzlpXWYJJhV3n0TW8S4oOdYRPmy2jbP3zTkANv6C74iGTexq6dlMCqE50psYDPM=
X-Received: by 2002:a05:600c:4e8d:b0:489:1f6a:4ac0 with SMTP id 5b1f17b1804b1-48fd69aa905mr749295e9.0.1778760175002;
        Thu, 14 May 2026 05:02:55 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdb278ad3sm62166485e9.8.2026.05.14.05.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 05:02:54 -0700 (PDT)
Date: Thu, 14 May 2026 12:02:49 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <agW5rhE9n2gDQ0w5@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
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
In-Reply-To: <yq5ah5oaa63h.fsf@kernel.org>

On Thu, May 14, 2026 at 11:24:42AM +0530, Aneesh Kumar K.V wrote:
> Mostafa Saleh <smostafa@google.com> writes:
> 
> > On Tue, May 12, 2026 at 02:33:59PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> Teach swiotlb to distinguish between encrypted and decrypted bounce
> >> buffer pools, and make allocation and mapping paths select a pool whose
> >> state matches the requested DMA attributes.
> >> 
> >> Add a decrypted flag to io_tlb_mem, initialize it for the default and
> >> restricted pools, and propagate DMA_ATTR_CC_SHARED into swiotlb pool
> >> allocation. Reject swiotlb alloc/map requests when the selected pool does
> >> not match the required encrypted/decrypted state.
> >> 
> >> Also return DMA addresses with the matching phys_to_dma_{encrypted,
> >> unencrypted} helper so the DMA address encoding stays consistent with the
> >> chosen pool.
> >> 
> >> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> >> ---
> >>  include/linux/dma-direct.h |  10 ++++
> >>  include/linux/swiotlb.h    |   8 ++-
> >>  kernel/dma/direct.c        |  14 +++--
> >>  kernel/dma/swiotlb.c       | 108 +++++++++++++++++++++++++++----------
> >>  4 files changed, 107 insertions(+), 33 deletions(-)
> >> 
> >> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> >> index c249912456f9..94fad4e7c11e 100644
> >> --- a/include/linux/dma-direct.h
> >> +++ b/include/linux/dma-direct.h
> >> @@ -77,6 +77,10 @@ static inline dma_addr_t dma_range_map_max(const struct bus_dma_region *map)
> >>  #ifndef phys_to_dma_unencrypted
> >>  #define phys_to_dma_unencrypted		phys_to_dma
> >>  #endif
> >> +
> >> +#ifndef phys_to_dma_encrypted
> >> +#define phys_to_dma_encrypted		phys_to_dma
> >> +#endif
> >>  #else
> >>  static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
> >>  {
> >> @@ -90,6 +94,12 @@ static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
> >>  {
> >>  	return dma_addr_unencrypted(__phys_to_dma(dev, paddr));
> >>  }
> >> +
> >> +static inline dma_addr_t phys_to_dma_encrypted(struct device *dev,
> >> +		phys_addr_t paddr)
> >> +{
> >> +	return dma_addr_encrypted(__phys_to_dma(dev, paddr));
> >> +}
> >>  /*
> >>   * If memory encryption is supported, phys_to_dma will set the memory encryption
> >>   * bit in the DMA address, and dma_to_phys will clear it.
> >> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> >> index 3dae0f592063..b3fa3c6e0169 100644
> >> --- a/include/linux/swiotlb.h
> >> +++ b/include/linux/swiotlb.h
> >> @@ -81,6 +81,7 @@ struct io_tlb_pool {
> >>  	struct list_head node;
> >>  	struct rcu_head rcu;
> >>  	bool transient;
> >> +	bool unencrypted;
> >>  #endif
> >>  };
> >>  
> >> @@ -111,6 +112,7 @@ struct io_tlb_mem {
> >>  	struct dentry *debugfs;
> >>  	bool force_bounce;
> >>  	bool for_alloc;
> >> +	bool unencrypted;
> >>  #ifdef CONFIG_SWIOTLB_DYNAMIC
> >>  	bool can_grow;
> >>  	u64 phys_limit;
> >> @@ -282,7 +284,8 @@ static inline void swiotlb_sync_single_for_cpu(struct device *dev,
> >>  extern void swiotlb_print_info(void);
> >>  
> >>  #ifdef CONFIG_DMA_RESTRICTED_POOL
> >> -struct page *swiotlb_alloc(struct device *dev, size_t size);
> >> +struct page *swiotlb_alloc(struct device *dev, size_t size,
> >> +		unsigned long attrs);
> >>  bool swiotlb_free(struct device *dev, struct page *page, size_t size);
> >>  
> >>  static inline bool is_swiotlb_for_alloc(struct device *dev)
> >> @@ -290,7 +293,8 @@ static inline bool is_swiotlb_for_alloc(struct device *dev)
> >>  	return dev->dma_io_tlb_mem->for_alloc;
> >>  }
> >>  #else
> >> -static inline struct page *swiotlb_alloc(struct device *dev, size_t size)
> >> +static inline struct page *swiotlb_alloc(struct device *dev, size_t size,
> >> +		unsigned long attrs)
> >>  {
> >>  	return NULL;
> >>  }
> >> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> >> index dc2907439b3d..97ae4fa10521 100644
> >> --- a/kernel/dma/direct.c
> >> +++ b/kernel/dma/direct.c
> >> @@ -104,9 +104,10 @@ static void __dma_direct_free_pages(struct device *dev, struct page *page,
> >>  	dma_free_contiguous(dev, page, size);
> >>  }
> >>  
> >> -static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
> >> +static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size,
> >> +		unsigned long attrs)
> >>  {
> >> -	struct page *page = swiotlb_alloc(dev, size);
> >> +	struct page *page = swiotlb_alloc(dev, size, attrs);
> >>  
> >>  	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> >>  		swiotlb_free(dev, page, size);
> >> @@ -266,8 +267,12 @@ void *dma_direct_alloc(struct device *dev, size_t size,
> >>  						  gfp, attrs);
> >>  
> >>  	if (is_swiotlb_for_alloc(dev)) {
> >> -		page = dma_direct_alloc_swiotlb(dev, size);
> >> +		page = dma_direct_alloc_swiotlb(dev, size, attrs);
> >>  		if (page) {
> >> +			/*
> >> +			 * swiotlb allocations comes from pool already marked
> >> +			 * decrypted
> >> +			 */
> >>  			mark_mem_decrypt = false;
> >>  			goto setup_page;
> >>  		}
> >> @@ -374,6 +379,7 @@ void dma_direct_free(struct device *dev, size_t size,
> >>  		return;
> >>  
> >>  	if (swiotlb_find_pool(dev, dma_to_phys(dev, dma_addr)))
> >> +		/* Swiotlb doesn't need a page attribute update on free */
> >>  		mark_mem_encrypted = false;
> >>  
> >>  	if (is_vmalloc_addr(cpu_addr)) {
> >> @@ -403,7 +409,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
> >>  						  gfp, attrs);
> >>  
> >>  	if (is_swiotlb_for_alloc(dev)) {
> >> -		page = dma_direct_alloc_swiotlb(dev, size);
> >> +		page = dma_direct_alloc_swiotlb(dev, size, attrs);
> >>  		if (!page)
> >>  			return NULL;
> >>  
> >> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> >> index ab4eccbaa076..065663be282c 100644
> >> --- a/kernel/dma/swiotlb.c
> >> +++ b/kernel/dma/swiotlb.c
> >> @@ -259,10 +259,21 @@ void __init swiotlb_update_mem_attributes(void)
> >>  	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
> >>  	unsigned long bytes;
> >>  
> >> +	/*
> >> +	 * if platform support memory encryption, swiotlb buffers are
> >> +	 * decrypted by default.
> >> +	 */
> >> +	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> >> +		io_tlb_default_mem.unencrypted = true;
> >> +	else
> >> +		io_tlb_default_mem.unencrypted = false;
> >> +
> >>  	if (!mem->nslabs || mem->late_alloc)
> >>  		return;
> >>  	bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
> >> -	set_memory_decrypted((unsigned long)mem->vaddr, bytes >> PAGE_SHIFT);
> >> +
> >> +	if (io_tlb_default_mem.unencrypted)
> >> +		set_memory_decrypted((unsigned long)mem->vaddr, bytes >> PAGE_SHIFT);
> >>  }
> >>  
> >>  static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
> >> @@ -505,8 +516,10 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
> >>  	if (!mem->slots)
> >>  		goto error_slots;
> >>  
> >> -	set_memory_decrypted((unsigned long)vstart,
> >> -			     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
> >> +	if (io_tlb_default_mem.unencrypted)
> >> +		set_memory_decrypted((unsigned long)vstart,
> >> +				     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
> >> +
> >>  	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), nslabs, true,
> >>  				 nareas);
> >>  	add_mem_pool(&io_tlb_default_mem, mem);
> >> @@ -539,7 +552,9 @@ void __init swiotlb_exit(void)
> >>  	tbl_size = PAGE_ALIGN(mem->end - mem->start);
> >>  	slots_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), mem->nslabs));
> >>  
> >> -	set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
> >> +	if (io_tlb_default_mem.unencrypted)
> >> +		set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
> >> +
> >>  	if (mem->late_alloc) {
> >>  		area_order = get_order(array_size(sizeof(*mem->areas),
> >>  			mem->nareas));
> >> @@ -563,6 +578,7 @@ void __init swiotlb_exit(void)
> >>   * @gfp:	GFP flags for the allocation.
> >>   * @bytes:	Size of the buffer.
> >>   * @phys_limit:	Maximum allowed physical address of the buffer.
> >> + * @unencrypted: true to allocate unencrypted memory, false for encrypted memory
> >>   *
> >>   * Allocate pages from the buddy allocator. If successful, make the allocated
> >>   * pages decrypted that they can be used for DMA.
> >> @@ -570,7 +586,8 @@ void __init swiotlb_exit(void)
> >>   * Return: Decrypted pages, %NULL on allocation failure, or ERR_PTR(-EAGAIN)
> >>   * if the allocated physical address was above @phys_limit.
> >>   */
> >> -static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
> >> +static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes,
> >> +		u64 phys_limit, bool unencrypted)
> >>  {
> >>  	unsigned int order = get_order(bytes);
> >>  	struct page *page;
> >> @@ -588,13 +605,13 @@ static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
> >>  	}
> >>  
> >>  	vaddr = phys_to_virt(paddr);
> >> -	if (set_memory_decrypted((unsigned long)vaddr, PFN_UP(bytes)))
> >> +	if (unencrypted && set_memory_decrypted((unsigned long)vaddr, PFN_UP(bytes)))
> >>  		goto error;
> >>  	return page;
> >>  
> >>  error:
> >>  	/* Intentional leak if pages cannot be encrypted again. */
> >> -	if (!set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
> >> +	if (unencrypted && !set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
> >>  		__free_pages(page, order);
> >>  	return NULL;
> >>  }
> >> @@ -604,30 +621,26 @@ static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
> >>   * @dev:	Device for which a memory pool is allocated.
> >>   * @bytes:	Size of the buffer.
> >>   * @phys_limit:	Maximum allowed physical address of the buffer.
> >> + * @attrs:	DMA attributes for the allocation.
> >>   * @gfp:	GFP flags for the allocation.
> >>   *
> >>   * Return: Allocated pages, or %NULL on allocation failure.
> >>   */
> >>  static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
> >> -		u64 phys_limit, gfp_t gfp)
> >> +		u64 phys_limit, unsigned long attrs, gfp_t gfp)
> >>  {
> >>  	struct page *page;
> >> -	unsigned long attrs = 0;
> >>  
> >>  	/*
> >>  	 * Allocate from the atomic pools if memory is encrypted and
> >>  	 * the allocation is atomic, because decrypting may block.
> >>  	 */
> >> -	if (!gfpflags_allow_blocking(gfp) && dev && force_dma_unencrypted(dev)) {
> >> +	if (!gfpflags_allow_blocking(gfp) && (attrs & DMA_ATTR_CC_SHARED)) {
> >>  		void *vaddr;
> >>  
> >>  		if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
> >>  			return NULL;
> >>  
> >> -		/* swiotlb considered decrypted by default */
> >> -		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> >> -			attrs = DMA_ATTR_CC_SHARED;
> >> -
> >>  		return dma_alloc_from_pool(dev, bytes, &vaddr, gfp,
> >>  					   attrs, dma_coherent_ok);
> >>  	}
> >> @@ -638,7 +651,8 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
> >>  	else if (phys_limit <= DMA_BIT_MASK(32))
> >>  		gfp |= __GFP_DMA32;
> >>  
> >> -	while (IS_ERR(page = alloc_dma_pages(gfp, bytes, phys_limit))) {
> >> +	while (IS_ERR(page = alloc_dma_pages(gfp, bytes, phys_limit,
> >> +					     !!(attrs & DMA_ATTR_CC_SHARED)))) {
> >>  		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
> >>  		    phys_limit < DMA_BIT_MASK(64) &&
> >>  		    !(gfp & (__GFP_DMA32 | __GFP_DMA)))
> >> @@ -657,15 +671,18 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
> >>   * swiotlb_free_tlb() - free a dynamically allocated IO TLB buffer
> >>   * @vaddr:	Virtual address of the buffer.
> >>   * @bytes:	Size of the buffer.
> >> + * @unencrypted: true if @vaddr was allocated decrypted and must be
> >> + *	re-encrypted before being freed
> >>   */
> >> -static void swiotlb_free_tlb(void *vaddr, size_t bytes)
> >> +static void swiotlb_free_tlb(void *vaddr, size_t bytes, bool unencrypted)
> >>  {
> >>  	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
> >>  	    dma_free_from_pool(NULL, vaddr, bytes))
> >>  		return;
> >>  
> >>  	/* Intentional leak if pages cannot be encrypted again. */
> >> -	if (!set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
> >> +	if (!unencrypted ||
> >> +	    !set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
> >>  		__free_pages(virt_to_page(vaddr), get_order(bytes));
> >>  }
> >>  
> >> @@ -676,6 +693,7 @@ static void swiotlb_free_tlb(void *vaddr, size_t bytes)
> >>   * @nslabs:	Desired (maximum) number of slabs.
> >>   * @nareas:	Number of areas.
> >>   * @phys_limit:	Maximum DMA buffer physical address.
> >> + * @attrs:	DMA attributes for the allocation.
> >>   * @gfp:	GFP flags for the allocations.
> >>   *
> >>   * Allocate and initialize a new IO TLB memory pool. The actual number of
> >> @@ -686,7 +704,8 @@ static void swiotlb_free_tlb(void *vaddr, size_t bytes)
> >>   */
> >>  static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
> >>  		unsigned long minslabs, unsigned long nslabs,
> >> -		unsigned int nareas, u64 phys_limit, gfp_t gfp)
> >> +		unsigned int nareas, u64 phys_limit, unsigned long attrs,
> >> +		gfp_t gfp)
> >>  {
> >>  	struct io_tlb_pool *pool;
> >>  	unsigned int slot_order;
> >> @@ -704,9 +723,10 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
> >>  	if (!pool)
> >>  		goto error;
> >>  	pool->areas = (void *)pool + sizeof(*pool);
> >> +	pool->unencrypted = !!(attrs & DMA_ATTR_CC_SHARED);
> >>  
> >>  	tlb_size = nslabs << IO_TLB_SHIFT;
> >> -	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, gfp))) {
> >> +	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, attrs, gfp))) {
> >>  		if (nslabs <= minslabs)
> >>  			goto error_tlb;
> >>  		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
> >> @@ -724,7 +744,8 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
> >>  	return pool;
> >>  
> >>  error_slots:
> >> -	swiotlb_free_tlb(page_address(tlb), tlb_size);
> >> +	swiotlb_free_tlb(page_address(tlb), tlb_size,
> >> +			 !!(attrs & DMA_ATTR_CC_SHARED));
> >>  error_tlb:
> >>  	kfree(pool);
> >>  error:
> >> @@ -742,7 +763,9 @@ static void swiotlb_dyn_alloc(struct work_struct *work)
> >>  	struct io_tlb_pool *pool;
> >>  
> >>  	pool = swiotlb_alloc_pool(NULL, IO_TLB_MIN_SLABS, default_nslabs,
> >> -				  default_nareas, mem->phys_limit, GFP_KERNEL);
> >> +				  default_nareas, mem->phys_limit,
> >> +				  mem->unencrypted ? DMA_ATTR_CC_SHARED : 0,
> >> +				  GFP_KERNEL);
> >>  	if (!pool) {
> >>  		pr_warn_ratelimited("Failed to allocate new pool");
> >>  		return;
> >> @@ -762,7 +785,7 @@ static void swiotlb_dyn_free(struct rcu_head *rcu)
> >>  	size_t tlb_size = pool->end - pool->start;
> >>  
> >>  	free_pages((unsigned long)pool->slots, get_order(slots_size));
> >> -	swiotlb_free_tlb(pool->vaddr, tlb_size);
> >> +	swiotlb_free_tlb(pool->vaddr, tlb_size, pool->unencrypted);
> >>  	kfree(pool);
> >>  }
> >>  
> >> @@ -1232,6 +1255,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
> >>  	nslabs = nr_slots(alloc_size);
> >>  	phys_limit = min_not_zero(*dev->dma_mask, dev->bus_dma_limit);
> >>  	pool = swiotlb_alloc_pool(dev, nslabs, nslabs, 1, phys_limit,
> >> +				  mem->unencrypted ? DMA_ATTR_CC_SHARED : 0,
> >>  				  GFP_NOWAIT);
> >>  	if (!pool)
> >>  		return -1;
> >> @@ -1394,6 +1418,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
> >>  		enum dma_data_direction dir, unsigned long attrs)
> >>  {
> >>  	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> >> +	bool require_decrypted = false;
> >>  	unsigned int offset;
> >>  	struct io_tlb_pool *pool;
> >>  	unsigned int i;
> >> @@ -1411,6 +1436,16 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
> >>  	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> >>  		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
> >>  
> >> +	/*
> >> +	 * if we are trying to swiotlb map a decrypted paddr or the paddr is encrypted
> >> +	 * but the device is forcing decryption, use decrypted io_tlb_mem
> >> +	 */
> >> +	if ((attrs & DMA_ATTR_CC_SHARED) || force_dma_unencrypted(dev))
> >> +		require_decrypted = true;
> >> +
> >> +	if (require_decrypted != mem->unencrypted)
> >> +		return (phys_addr_t)DMA_MAPPING_ERROR;
> >> +
> >>  	/*
> >>  	 * The default swiotlb memory pool is allocated with PAGE_SIZE
> >>  	 * alignment. If a mapping is requested with larger alignment,
> >> @@ -1608,8 +1643,14 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
> >>  	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
> >>  		return DMA_MAPPING_ERROR;
> >>  
> >> -	/* Ensure that the address returned is DMA'ble */
> >> -	dma_addr = phys_to_dma_unencrypted(dev, swiotlb_addr);
> >> +	/*
> >> +	 * Use the allocated io_tlb_mem encryption type to determine dma addr.
> >> +	 */
> >> +	if (dev->dma_io_tlb_mem->unencrypted)
> >> +		dma_addr = phys_to_dma_unencrypted(dev, swiotlb_addr);
> >> +	else
> >> +		dma_addr = phys_to_dma_encrypted(dev, swiotlb_addr);
> >> +
> >>  	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
> >>  		__swiotlb_tbl_unmap_single(dev, swiotlb_addr, size, dir,
> >>  			attrs | DMA_ATTR_SKIP_CPU_SYNC,
> >> @@ -1773,7 +1814,8 @@ static inline void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
> >>  
> >>  #ifdef CONFIG_DMA_RESTRICTED_POOL
> >>  
> >> -struct page *swiotlb_alloc(struct device *dev, size_t size)
> >> +struct page *swiotlb_alloc(struct device *dev, size_t size,
> >> +		unsigned long attrs)
> >>  {
> >>  	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> >>  	struct io_tlb_pool *pool;
> >> @@ -1784,6 +1826,9 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
> >>  	if (!mem)
> >>  		return NULL;
> >>  
> >> +	if (mem->unencrypted != !!(attrs & DMA_ATTR_CC_SHARED))
> >> +		return NULL;
> >> +
> >>  	align = (1 << (get_order(size) + PAGE_SHIFT)) - 1;
> >>  	index = swiotlb_find_slots(dev, 0, size, align, &pool);
> >>  	if (index == -1)
> >> @@ -1853,9 +1898,18 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
> >>  			kfree(mem);
> >>  			return -ENOMEM;
> >>  		}
> >> +		/*
> >> +		 * if platform supports memory encryption,
> >> +		 * restricted mem pool is decrypted by default
> >> +		 */
> >> +		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
> >> +			mem->unencrypted = true;
> >> +			set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
> >> +					     rmem->size >> PAGE_SHIFT);
> >> +		} else {
> >> +			mem->unencrypted = false;
> >> +		}
> >
> > This breaks pKVM as it doesn’t set CC_ATTR_MEM_ENCRYPT, so all virtio
> > traffic now fails.
> >
> > Also, by design, some drivers are clueless about bouncing, so
> > I believe that the pool should have a way to control it’s property
> > (encrypted or decrypted) and that takes priority over whatever
> > attributes comes from allocation.
> > And that brings us to the same point whether it’s better to return
> > the memory along with it’s state or we pass the requested state.
> > I think for other cases it’s fine for the device/DMA-API to dictate
> > the attrs, but not in restricted-dma case, the firmware just knows better.
> >
> 
> Is it that the pKVM guest kernel does not have awareness of
> encrypted/decrypted DMA allocations? Instead, the firmware attaches
> hypervisor-shared pages to the device via restricted-dma-pool? The
> kernel then has swiotlb->for_alloc = true, and hence all DMA allocations
> go through the restricted-dma-pool?

Yes.

> 
> Given that pKVM supports pkvm_set_memory_encrypted() and
> pkvm_set_memory_decrypted(), can we consider adding CC_ATTR_MEM_ENCRYPT
> support to pKVM? It would also be good to investigate whether we can set
> force_dma_unencrypted(dev) to true where needed.

I was looking in to that, but it didn't work because
force_dma_unencrypted() is broken with restricted-dma due to the
double decryption issue, that's when I sent my first series [1]

May be we should land some basic fixes for that path so we can
convert pKVM, then we do the full rework.

I will revive my old work and see if I can send a RFC.

[1] https://lore.kernel.org/all/20260305170335.963568-1-smostafa@google.com/

> 
> I agree that this patch, as it stands, can break pKVM because we are now
> missing the set_memory_decrypted() call required for pKVM to work.
> 
> We now mark the swiotlb io_tlb_mem as unencrypted/encrypted in the guest
> using struct io_tlb_mem->unencrypted. I am not clear what we can use for
> pKVM to conditionalize this so that it works for both protected and
> unprotected guests.

There is no problem with non-protected guests as they don't use memory
encryption, my initial thought was that th encrpyted/decrypted is
per-pool property which is decided by FW (device-tree).

Thanks,
Mostafa

> 
> -aneesh
> 

