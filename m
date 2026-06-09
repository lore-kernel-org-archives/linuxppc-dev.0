Return-Path: <linuxppc-dev+bounces-22321-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE6FCD8C92
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 12:18:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZScM73b0z2yv2;
	Tue, 09 Jun 2026 22:18:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781007507;
	cv=none; b=ODiLp+rvOn0/2GRbQFlHw7rD4DpuOy3SRRT8syRyPHeQg6AXyC1MJxeXEpU2421duG2rRaWVQF070gPqhvAy44NDZbglrBwNm5MXx8OwGRvpe1T7qH491MkopB7ZBIOje2JQEbLmgrUNxxEo2yI7aUQyY9K7z2USlLC2Bq528qxbbSoc/jC8ftaHvKapHi6cBUlwBXjMXcHwl9tp60IZoC85GnAtZWWWNAarQL2tqY4Qh6FRQ5hUNgX1GbOlUOy6CGDNQDU6luG8KrHp9TbzdC8ljGp+zGWO95CuiAdyrJDCCAeQmvPOZFKWFQEIEGZrgPGzaoBdM6UpfZoA/yVWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781007507; c=relaxed/relaxed;
	bh=5cgmjA35OZT82unFdAfj17g91mhG8pXqbVF134yH8ow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ojngraLXBMc5rCavOaH2siPAuwt1SyO4tl9e5EJzQqSvrdcshA3PysggYUM3hikFCwwwWcdaNVYhuHT1LPdfsTGv/r0yPdD9ftiNsTNKZZS5hDSQwipn4RRfh9A2jGyrME16HzDf1avQpImh7ZPAz4zUMZLkrpK9nh+MhJESFN69dvJwfN3jhUooGCy5CsyuSqDSdurvGIL7dnDYePGNJeJRBkgG659H3RoV2MM6n7EfaWqqPzMp592SRiJBzkFaCtm2yalnBLv0mxR0/IcP9lpPzSL7o62rK7TOcColCHUmpms4uc22BUb8kjUyx4ek0Fhy2CZQqAtdHf1NERgwlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=cEY56qdY; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=cEY56qdY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZScL5n4rz2ytV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 22:18:26 +1000 (AEST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-490b1c39fe4so5484405e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 05:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781007504; x=1781612304; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cgmjA35OZT82unFdAfj17g91mhG8pXqbVF134yH8ow=;
        b=cEY56qdYlpBfolREptdtv72nAhp5RIZPqS4oeKHrO4tpRz2qKk3DRTTsuinkO8kQdv
         eOixcOn5AC/zaTiozVx9SY0YPkv7zxwfgf5dIJvX63mltKQmO29zjP0p9b6qmcDVzSB3
         rxYwme8Zc1dpVHcOlJZFTJxOphF5JSe7Ks7CbsnkUdtTH+1dgnNJk69hMy9dav5VGWmT
         dq3jwaAe6w4rWI+zI4a8A+ifdGVgecLNNG6KvIIx2sVXxzYtNfM/DzyYvvf2EL7KsdQx
         5gtmg7mvllOVIxeVHszcOZIp9W7OM11N63r415wVCZAqyjMtD/W2vpznT2J4lRlIJXRO
         mrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781007504; x=1781612304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5cgmjA35OZT82unFdAfj17g91mhG8pXqbVF134yH8ow=;
        b=AXFXPIpdzXoQ4p0k/gF8pZ7zoyuBDu+qo4Xa5zakbx/xE4irs3A/BgtMEGSZDYCwat
         Xg69XTRoePWUj9o5cVFzhhGulZ03d6DPCMnTIfaW5BFNFPo6LWX0Q+LhnfAIl+VHJKtg
         GGd4szIA6ZzXcKWFVzLDC2Zs0xkkZP803f66/FuDjBUGHCZ26bNv/s13LwIyOSuZPlIl
         MJE3tNlHqKpatVPG+fzZsBBoiIw1Og628W2vcgKiqBmpqjyix3v7pD0Mg7mazlw50zzv
         D2UaYEbBFv5H/gSlaMSifh/x9hejfouzx5nxO0wquwHTS5PodHyzGBXCEpp+RkCRV1cF
         0mPg==
X-Forwarded-Encrypted: i=1; AFNElJ94z3y2tvznbafVCs4x/mXKfIqPI3yX/LlsrE9CEwteQI4s7u93xLiESibgpmVWtEAQVFUgvRy1jxPF/vQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx3jhvL+aMBV0Rl5H2Ig2teh+esKfUskgNCUAJUuuNc+qiS6vxn
	/EppwOdTenBZpLOfmQNqKpSVXU5UPUt/6Q1BlGY4T3iSxsm1ZZr3G/tl1tEOsNmOuK0=
X-Gm-Gg: Acq92OHvv7gddfS2n0o2DPxVHM55I1FyIY3uEmdBkB4MqrmvwnBmBOVQp9NfRqTOZM0
	qHkUjIVKULpWrvD9fbnk7yzNUv3QmXRCLJQqIUsJ4Es+U51LO1jC+6ae2phmzp9hboMrS4LSZTO
	7x5BE2lV13+/ddcKSXimJVRN00RKisCptIZRXMVq4WVYMYt7PjT2Vw5eJdwsszUXrgL89dQIaU6
	BaBsVd+mhUst2MmWJRhiqJkM6necdWTY0qC/VWbph3LoT3vDEQCYBnWY5hGDQ9j7t+9nZR+0A39
	my8HP+hv2wLIQ39Kp27KjROM4s5hodmf41OH8begawv2EzADUqWMkHSimkeEqfSVTangJAR41zO
	zgz7AWmebhBQ+dQefpuXIYNB/oJ2WMkU/i63WnzyaNgtlTjn48rsd+e2jXyV/1EHybaIfANH/oM
	eNS65MsPPujU8Z6iZ3bCNdt4M=
X-Received: by 2002:a05:600c:6990:b0:490:c123:3b7a with SMTP id 5b1f17b1804b1-490c25f5864mr145239965e9.4.1781007503651;
        Tue, 09 Jun 2026 05:18:23 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm61851766f8f.20.2026.06.09.05.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 05:18:22 -0700 (PDT)
Date: Tue, 9 Jun 2026 14:18:14 +0200
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
 <svens@linux.ibm.com>, x86@kernel.org, Jiri Pirko <jiri@nvidia.com>,
 Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 03/20] dma-direct: use DMA_ATTR_CC_SHARED in
 alloc/free paths
Message-ID: <20260609141814.413c1f2f@mordecai>
In-Reply-To: <20260604083959.1265923-4-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-4-aneesh.kumar@kernel.org>
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

On Thu,  4 Jun 2026 14:09:42 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Propagate force_dma_unencrypted() into DMA_ATTR_CC_SHARED in the
> dma-direct allocation path and use the attribute to drive the related
> decisions.
> 
> This updates dma_direct_alloc(), dma_direct_free(), and
> dma_direct_alloc_pages() to fold the forced unencrypted case into attrs.
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> ---
>  kernel/dma/direct.c | 53 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index a741c8a2ee66..90dc5057a0c0 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -193,16 +193,31 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
>  	bool remap = false, set_uncached = false;
> -	bool mark_mem_decrypt = true;
> +	bool mark_mem_decrypt = false;
>  	struct page *page;
>  	void *ret;
>  
> +	/*
> +	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
> +	 * attribute. The direct allocator uses it internally after it has
> +	 * decided that the backing pages must be shared/decrypted, so the
> +	 * rest of the allocation path can consistently select DMA addresses,
> +	 * choose compatible pools and restore encryption on free.
> +	 */
> +	if (attrs & DMA_ATTR_CC_SHARED)
> +		return NULL;
> +
> +	if (force_dma_unencrypted(dev)) {
> +		attrs |= DMA_ATTR_CC_SHARED;
> +		mark_mem_decrypt = true;
> +	}
> +
>  	size = PAGE_ALIGN(size);
>  	if (attrs & DMA_ATTR_NO_WARN)
>  		gfp |= __GFP_NOWARN;
>  
> -	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> -	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
> +	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_CC_SHARED)) ==
> +	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev))
>  		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
>  
>  	if (!dev_is_dma_coherent(dev)) {
> @@ -236,7 +251,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	 * Remapping or decrypting memory may block, allocate the memory from
>  	 * the atomic pools instead if we aren't allowed block.
>  	 */
> -	if ((remap || force_dma_unencrypted(dev)) &&
> +	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
>  	    dma_direct_use_pool(dev, gfp))
>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>  
> @@ -312,12 +327,24 @@ void dma_direct_free(struct device *dev, size_t size,
>  		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
>  {
>  	phys_addr_t phys;
> -	bool mark_mem_encrypted = true;
> +	bool mark_mem_encrypted = false;
>  	struct io_tlb_pool *swiotlb_pool;
>  	unsigned int page_order = get_order(size);
>  
> -	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> -	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
> +	/* see dma_direct_alloc() for details */
> +	WARN_ON(attrs & DMA_ATTR_CC_SHARED);
> +
> +	/*
> +	 * if the device had requested for an unencrypted buffer,
> +	 * convert it to encrypted on free
> +	 */
> +	if (force_dma_unencrypted(dev)) {
> +		attrs |= DMA_ATTR_CC_SHARED;
> +		mark_mem_encrypted = true;
> +	}
> +
> +	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_CC_SHARED)) ==
> +	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev)) {
>  		/* cpu_addr is a struct page cookie, not a kernel address */
>  		dma_free_contiguous(dev, cpu_addr, size);
>  		return;
> @@ -366,10 +393,14 @@ void dma_direct_free(struct device *dev, size_t size,
>  struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
>  {
> +	unsigned long attrs = 0;
>  	struct page *page;
>  	void *ret;
>  
> -	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
> +	if (force_dma_unencrypted(dev))
> +		attrs |= DMA_ATTR_CC_SHARED;
> +
> +	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>  
>  	if (is_swiotlb_for_alloc(dev)) {
> @@ -403,7 +434,11 @@ void dma_direct_free_pages(struct device *dev, size_t size,
>  	phys_addr_t phys;
>  	void *vaddr = page_address(page);
>  	struct io_tlb_pool *swiotlb_pool;
> -	bool mark_mem_encrypted = true;
> +	/*
> +	 * if the device had requested for an unencrypted buffer,
> +	 * convert it to encrypted on free
> +	 */
> +	bool mark_mem_encrypted = force_dma_unencrypted(dev);
>  
>  	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
>  	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&


