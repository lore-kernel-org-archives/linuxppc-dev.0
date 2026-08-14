Return-Path: <linuxppc-dev+bounces-25874-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192FAC5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 17:35:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hM8Wc6xD9z2yRZ;
	Sat, 15 Aug 2026 03:35:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786728924;
	cv=none; b=nW8J6WMo5Gnd/lXF8bfG/yxwCfKllcU/q2+5wY6h7tHmHFjI2A7Qvfmwk+sX67kUTNR+xPyDLFusXtfrk/nVf1X/HNNlz+V/uz4Wa/8pIkJcKKAAHlm+12c/DiTzqqNNx22bPVzodZQV5RSsry7XQ9UXy6LRH7uliP2uzDIPeDcGTy3v3CdATqKzLuFwwTg/T/VSdx//5OvqUXp1ITyL49+hguzG8CmUe0vgZWro9edHu0IksKJV82XENYdOVFaVw7lTT6VQn5DeaAV7S5/LxRwx0HsPja/hGSGupiTjC56TuzFzddySTMdewA+V8QPzOT4ofIoWfsZyZKB9dokvZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786728924; c=relaxed/relaxed;
	bh=H24ZRelcLqUPv7V5dnsfABF8idbNok51QAO8v9aIS+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4L3gu3bMqYMDT9HxOCBC3WUMaNyAltF6Zdj1AR57yewMfTGJW1WsFzw8COYw68c1FJt9u2TmoQN+oo3Xopx3eqbclwqAekSOlSa7c5E/6uyal4dm0SUWJ4TU/vii1n//akl0lSZcG/xWxa89dwwL/fBWc8jxvtHEJN0jJltXA8D8bnM5UUWGNz9FjIL2pL7mY5beffDEIcPexWKQZrsowRDZBrYFyLnQv52Lp63jIChHo70BNh7zoDMzteO6AL5jAdirE7v2kNKOYdpHVRh5hCKvzNSkV4gseg6pxjL1kdxjaEBsvPfjyu/NJFfUbiwyjM55Wo8N6XHB1HC8hpV/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ppm7pmp8; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ppm7pmp8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hM8WY6T0gz2yH5
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 03:35:19 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D9611516;
	Fri, 14 Aug 2026 10:34:42 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CB4D3F66F;
	Fri, 14 Aug 2026 10:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786728886; bh=u3T9edAxlh7yKorxUAb9VAjz6kQdSTTbvHmmGeDDHoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppm7pmp8E9oVikMGpVoQQWvjA2spsMWcUEwM5vXpRx2erTjnP16IFLrGmEifQQ7DC
	 8sLEvBHanZyBCAqJAEiPNurm8WKYBKyyxL14TwTjEu5odWeJbfPbCk4dKh+9cwcRrg
	 SHpUIcPXbrmDNJK4N0VK054T4ts//EmbcSpr6RgI=
Date: Fri, 14 Aug 2026 18:34:39 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [RFC PATCH v2 2/2] dma: swiotlb: Initialize and size shared
 default pools for memory encryption
Message-ID: <an9RrwoaAsqJQ2vN@arm.com>
References: <20260813102521.1367737-1-aneesh.kumar@kernel.org>
 <20260813102521.1367737-3-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260813102521.1367737-3-aneesh.kumar@kernel.org>

On Thu, Aug 13, 2026 at 03:55:21PM +0530, Aneesh Kumar K.V (Arm) wrote:
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9f5b366d2086..c3188ca878f3 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -338,12 +338,8 @@ void __init arch_setup_zero_pages(void)
>  void __init arch_mm_preinit(void)
>  {
>  	unsigned int flags = SWIOTLB_VERBOSE;
> -	/* pKVM uses restricted-dma-pool */
> -	bool cc_guest = is_realm_world();
>  
> -	if (cc_guest)
> -		flags |= SWIOTLB_INIT_CC_SHARED;
> -	else if (max_pfn > PFN_DOWN(arm64_dma_phys_limit))
> +	if (max_pfn > PFN_DOWN(arm64_dma_phys_limit))
>  		flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
>  
>  	swiotlb_init(flags);

This looks fine. As I mentioned on patch 1, we might as well move this
hunk over there and avoid the flag definition.

> @@ -102,9 +101,6 @@ void __init mem_encrypt_init(void)
>  
>  void __init mem_encrypt_setup_arch(void)
>  {
> -	phys_addr_t total_mem = memblock_phys_mem_size();
> -	unsigned long size;
> -
>  	/*
>  	 * Do RMP table fixups after the e820 tables have been setup by
>  	 * e820__memory_setup().
> @@ -112,33 +108,9 @@ void __init mem_encrypt_setup_arch(void)
>  	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
>  		snp_fixup_e820_tables();
>  
> -	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> -		x86_swiotlb_flags |= SWIOTLB_INIT_CC_SHARED;
> -
>  	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>  		return;
>  
> -	/*
> -	 * For SEV and TDX, all DMA has to occur via shared/unencrypted pages.
> -	 * Kernel uses SWIOTLB to make this happen without changing device
> -	 * drivers. However, depending on the workload being run, the
> -	 * default 64MB of SWIOTLB may not be enough and SWIOTLB may
> -	 * run out of buffers for DMA, resulting in I/O errors and/or
> -	 * performance degradation especially with high I/O workloads.
> -	 *
> -	 * Adjust the default size of SWIOTLB using a percentage of guest
> -	 * memory for SWIOTLB buffers. Also, as the SWIOTLB bounce buffer
> -	 * memory is allocated from low memory, ensure that the adjusted size
> -	 * is within the limits of low available memory.
> -	 *
> -	 * The percentage of guest memory used here for SWIOTLB buffers
> -	 * is more of an approximation of the static adjustment which
> -	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
> -	 */
> -	size = total_mem * 6 / 100;
> -	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
> -	swiotlb_adjust_size(size);
> -
>  	/* Set restricted memory access for virtio. */
>  	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
>  }

Credit to claude, it noticed a slight change in behaviour for x86 w.r.t.
the crash kernel reservation. crash_low_size_default() reads the swiotlb
size but the resizing now happens after arch_reserve_crashkernel().
Maybe not an issue.

Alternatively, we could build the sizing logic into
swiotlb_size_or_default() but I haven't checked whether we have the
right information when this function is called.

> @@ -382,12 +374,54 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
>  	return tlb;
>  }
>  
> +static void __init swiotlb_adjust_cc_attributes(void)
> +{
> +	unsigned long size;
> +	phys_addr_t total_mem = memblock_phys_mem_size();
> +
> +	/* Do not resize for host memory encryption. */
> +	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +		return;
> +
> +	/*
> +	 * For SEV and TDX and CCA, all DMA has to occur via
> +	 * shared/unencrypted pages. Kernel uses SWIOTLB to make this
> +	 * happen without changing device drivers. However, depending on
> +	 * the workload being run, the default 64MB of SWIOTLB may not be
> +	 * enough and SWIOTLB may run out of buffers for DMA, resulting in
> +	 * I/O errors and/or performance degradation especially with high
> +	 * I/O workloads.
> +	 *
> +	 * Adjust the default size of SWIOTLB using a percentage of guest
> +	 * memory for SWIOTLB buffers. Also, as the SWIOTLB bounce buffer
> +	 * memory is allocated from low memory, ensure that the adjusted
> +	 * size is within the limits of low available memory.
> +	 *
> +	 * The percentage of guest memory used here for SWIOTLB buffers is
> +	 * more of an approximation of the static adjustment which 64MB for
> +	 * <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
> +	 */
> +	size = total_mem * 6 / 100;
> +	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
> +	swiotlb_adjust_size(size);
> +
> +	if (!IS_ENABLED(CONFIG_SWIOTLB_DYNAMIC))
> +		pr_info("Consider enabling CONFIG_SWIOTLB_DYNAMIC for memory-encrypted systems\n");

I agree with Michael, let's drop this pr_info().

> +}
> +
>  static bool __init swiotlb_kmalloc_needs_bounce(void)
>  {
>  	return IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
>  	       (dma_get_cache_alignment() > 1);
>  }
>  
> +static bool __init swiotlb_default_pool_needs_cc_shared(void)
> +{
> +	/* A restricted DMA pool provides the shared buffers instead. */
> +	return cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
> +	       !restricted_dma_pool_present;
> +}

I don't think restricted_dma_pool_present should change the cc_shared
attribute. The rmem pool is all about sizing the swiotlb, not disabling
sharing.

Thinking some more, if other archs don't like rmem pool influencing the
default swiotlb size, we could add a flag (SWIOTLB_SKIP_IF_RMEM_POOL or
some better name). But only if people dislike the heuristics.

> @@ -437,9 +469,11 @@ void __init swiotlb_init_remap(unsigned int flags,
>  		io_tlb_default_mem.phys_limit = ARCH_LOW_ADDRESS_LIMIT;
>  #endif
>  
> -	if (!(flags & (SWIOTLB_INIT_ADDRESSING_LIMIT |
> -		       SWIOTLB_INIT_CC_SHARED)) &&
> -	    swiotlb_kmalloc_needs_bounce()) {
> +	if (swiotlb_default_pool_needs_cc_shared()) {
> +		io_tlb_default_mem.cc_shared = true;
> +		swiotlb_adjust_cc_attributes();
> +	} else if (!(flags & SWIOTLB_INIT_ADDRESSING_LIMIT) &&
> +		   swiotlb_kmalloc_needs_bounce()) {

I think at a high level, we need (i.e. separate attributed from sizing):

	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
		io_tlb_default_mem.cc_shared = true;

	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
		if (!restricted_dma_pool_present)
			swiotlb_adjust_cc_size();	/* 6%, clamped */
	} else if (!(flags & SWIOTLB_INIT_ADDRESSING_LIMIT) &&
		   swiotlb_kmalloc_needs_bounce()) {
		swiotlb_shrink_for_kmalloc();		/* 1MB per 1GB */
	}

-- 
Catalin

