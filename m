Return-Path: <linuxppc-dev+bounces-23817-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9647C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 11:36:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwGJg2bCRz2xll;
	Wed, 08 Jul 2026 21:36:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783510595;
	cv=none; b=NGa0IMg3HOg/zJHeDN258e/+9MrrQ1b2hKznTD+oCWL6gTDeIZAlz+97Sw8Ow7ZGmH0Pa1LKDqD6j2E5GEVe8cIaav5bBopK3OIiAIoKZnZEtcTl1nXRLZYVN+xYwQjy/U4cMZgOkMUlO1ni6FtsY66q5/adTbVt6VcivCHwcx3giq/L/rpS2xZNGQQEbCSXDM5SAh5zYIQe/4gfY8q4n5fBHxe6BWA2CCO+OGh6ckSZapUm6TqaGeriuRqiY03/3/P8ktbxfkFDnfl3O1sWX8HyKsLkcP/LwfGkCo2PBWJBG/fdT7O8OCbgTcB4NGbZRaWc0XciDIFdCjEW9r0IHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783510595; c=relaxed/relaxed;
	bh=wvVAlEJVuGFLkU8Sx+0lCwd7KQJAZlMmHPeMITO1ozY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eX2BrdQv3uoAHqC6i6YioeN5WF5SoV7dvX08PlAO+nWROGqbN35gh7YFPsjW/vIpEqPpiU7DHTZoM/B263WpKr/5S5JHfIys1zeOFLz3oAL3Ves9QOqtaq80910Q6U4PcSAaBmoTI9x0q8AqW4QRSJdL/feX1vmJuz7usVE7auTe2gB94decZka13kgyPZf0wjJhr5jEt6xlBmmAQdLUghVwwz1J/rtTu+pMMG94+fJhsGwVmpokj6Uf+oXXaaTYh3giyV480vGGoLHeAGW6B0F7q0RcMcy/7j/aORNG3q4LinKzx+vLxX1cLf7sr4MPE/6Ml20lxw3vzlFQEUzQvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BDUtEDVy; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BDUtEDVy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwGJc1hP5z2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 21:36:30 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00BCE1E5E;
	Wed,  8 Jul 2026 04:35:53 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E39E3F85F;
	Wed,  8 Jul 2026 04:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783510557; bh=skF61y21KgPsVGfJvwoIpH8oYC/C836tWg/Zi0aByAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BDUtEDVyOjE2X987uSwyfq3z9RD7lBFkhkdA5EBvVEUJF3xFy0wXNZao/bpBtdGJT
	 bzEIyGgplNZ8FteGaCdPd8M9i1hu4qN4jloW+AkzdgaaYEgqMwYQieSh7ECTVL08I/
	 ukOcYIu1QhMGKdh1zDxGves8zlEW6X1jwQ6tkJ14=
Date: Wed, 8 Jul 2026 12:35:51 +0100
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
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Message-ID: <ak42F240d-53QeFN@arm.com>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260701054926.825925-17-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:20AM +0530, Aneesh Kumar K.V (Arm) wrote:
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 97987f850a33..acf67c7064db 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -338,10 +338,8 @@ void __init arch_mm_preinit(void)
>  	unsigned int flags = SWIOTLB_VERBOSE;
>  	bool swiotlb = max_pfn > PFN_DOWN(arm64_dma_phys_limit);
>  
> -	if (is_realm_world()) {
> +	if (is_realm_world())
>  		swiotlb = true;
> -		flags |= SWIOTLB_FORCE;
> -	}

For this part:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index e05dc7649366..f3fc28f352ba 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -88,37 +88,40 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>  {
>  	dma_addr_t dma_addr;
>  
> +	/*
> +	 * For a device requiring unencrypted DMA, MMIO memory is treated
> +	 * as shared by default.
> +	 */
> +	if (force_dma_unencrypted(dev) && (attrs & DMA_ATTR_MMIO))
> +		attrs |= DMA_ATTR_CC_SHARED;
> +
>  	if (is_swiotlb_force_bounce(dev)) {
> -		if (!(attrs & DMA_ATTR_CC_SHARED)) {
> -			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> -				return DMA_MAPPING_ERROR;
> +		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> +			return DMA_MAPPING_ERROR;
>  
> -			return swiotlb_map(dev, phys, size, dir, attrs);
> -		}
> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> -		return DMA_MAPPING_ERROR;
> +		return swiotlb_map(dev, phys, size, dir, attrs);
>  	}
>  
> -	if (attrs & DMA_ATTR_MMIO) {
> -		dma_addr = phys;
> -		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
> -			goto err_overflow;
> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> +	if (attrs & DMA_ATTR_CC_SHARED)
>  		dma_addr = phys_to_dma_unencrypted(dev, phys);
> +	else
> +		dma_addr = phys_to_dma_encrypted(dev, phys);

For AMD/SME, on host with memory encryption we now end up setting the C
bit for DMA_ATTR_MMIO. This is fine for RAM but not sure whether
some other MMIO bus understands this attribute. Maybe we should stick to
something like __phys_to_dma() for the !CC_SHARED && MMIO path. Or,
since this is not universally defined, just use the old dma_addr = phys
if MMIO and ignore any unlikely DMA offsets.

In the other case, for an arm CCA guest, if the MMIO is shared we end up
setting the shared attribute but that's fine, it's only an IPA address.

-- 
Catalin

