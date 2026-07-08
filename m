Return-Path: <linuxppc-dev+bounces-23840-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B19C44501
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 17:58:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwQnP4gLYz3054;
	Thu, 09 Jul 2026 03:58:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783533513;
	cv=none; b=CReK+5KhTKMNy/J1KghG60VjekS706FStZGtgqg8MxYFi0s7wDGktHPY0e+n5IpHP/1MxNi9mu/nwbMvA/sSdeeGisWGC3syTaMxl8YoD0SXDr2J+l9P05lEluslFLqhMPbBHOBKYXSSbO3XwvPAS9nJt9jbqxjJXj4WWZeJjK5zDJ3SWGbka69q8kxsvjpNJIy7Jcw7VRKFn2Qpu6sfnCIxGa9wbp42GGVh+Tdn2TQ4gKu3kdccBnTnfqcn47YOqU9Znxujf7ONYNGPWffxUTLYNWhYqmk1rjHOpp/OQyB+zpNUKS9U0P0RrQtRKaktG2pCh8Hn59hdi38Kj9tRUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783533513; c=relaxed/relaxed;
	bh=2zcJcB1E4eAZy0egEbo5b49ra1AlE1ZZgAl0aBZPFpg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CYTGHMvotYsslaoNcB0lWiJNo/lG4cXspfC3Y/p4EFTAMnB5xsdVplYIJqWeL/THur1U7deMv5i3dll4iMX9AQaNGKa9pgetcMq2YPKJrstVetfZBG4UNkqHqGv7K7dxocWoqcrxwwYw/Mpom9yWALEdZf23Z7YgqIqEcPNDkPNBt16kDEC0E5FjrDC11NfdghyxjZJaXHu+08EYcS9EHDL/CsYb2Sse13z4apVT/XXo5dm0op/rkgV0DqCKEgYuPxs478fBtNGngZv0LL/M6ezSLIy+00W861vKapVD20zpIml4791+KbXEQkSvi1c1nOUlIkqrvZwatQ+IzoEOug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lUFCGVvh; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lUFCGVvh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwQnN2RhHz2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 03:58:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7B9D940279;
	Wed,  8 Jul 2026 17:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFE91F000E9;
	Wed,  8 Jul 2026 17:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783533509;
	bh=2zcJcB1E4eAZy0egEbo5b49ra1AlE1ZZgAl0aBZPFpg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=lUFCGVvhi3r0g2REAtCb2IGA8CZvBtpISzpqNOsLlIz4oC8RYsx/4BDzxBWlKpED0
	 OO0H8pEE+Rj/gvkRHSvopojk6+7GJ2AVOWtst9fH1KbISbjRghLiVKG8hjeEoo2NJL
	 1pONN4spCjOkHAEVviRtqhHebsdb8FkdHq+W9mwMHVu3D2rDo+PIliDI8dLOzCpavH
	 2v63vsnLIDMQkmI7iMKzYlLlawSHemKEODU9IgIdU5HL7fCECve8y+XTvAEm18oYQ/
	 fjk+++bhVL1mK2ZtC2q+a75eR0XtyKKWF5XVAIEO0u/AFkjmd4VWUqV8Us3U8DJG1R
	 Qf80NCztIqmrQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
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
	Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
In-Reply-To: <ak42F240d-53QeFN@arm.com>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
 <ak42F240d-53QeFN@arm.com>
Date: Wed, 08 Jul 2026 23:28:14 +0530
Message-ID: <yq5apl0xgy89.fsf@kernel.org>
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
Content-Type: text/plain

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Wed, Jul 01, 2026 at 11:19:20AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 97987f850a33..acf67c7064db 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -338,10 +338,8 @@ void __init arch_mm_preinit(void)
>>  	unsigned int flags = SWIOTLB_VERBOSE;
>>  	bool swiotlb = max_pfn > PFN_DOWN(arm64_dma_phys_limit);
>>  
>> -	if (is_realm_world()) {
>> +	if (is_realm_world())
>>  		swiotlb = true;
>> -		flags |= SWIOTLB_FORCE;
>> -	}
>
> For this part:
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>
>> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
>> index e05dc7649366..f3fc28f352ba 100644
>> --- a/kernel/dma/direct.h
>> +++ b/kernel/dma/direct.h
>> @@ -88,37 +88,40 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>>  {
>>  	dma_addr_t dma_addr;
>>  
>> +	/*
>> +	 * For a device requiring unencrypted DMA, MMIO memory is treated
>> +	 * as shared by default.
>> +	 */
>> +	if (force_dma_unencrypted(dev) && (attrs & DMA_ATTR_MMIO))
>> +		attrs |= DMA_ATTR_CC_SHARED;
>> +
>>  	if (is_swiotlb_force_bounce(dev)) {
>> -		if (!(attrs & DMA_ATTR_CC_SHARED)) {
>> -			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>> -				return DMA_MAPPING_ERROR;
>> +		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>> +			return DMA_MAPPING_ERROR;
>>  
>> -			return swiotlb_map(dev, phys, size, dir, attrs);
>> -		}
>> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
>> -		return DMA_MAPPING_ERROR;
>> +		return swiotlb_map(dev, phys, size, dir, attrs);
>>  	}
>>  
>> -	if (attrs & DMA_ATTR_MMIO) {
>> -		dma_addr = phys;
>> -		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
>> -			goto err_overflow;
>> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
>> +	if (attrs & DMA_ATTR_CC_SHARED)
>>  		dma_addr = phys_to_dma_unencrypted(dev, phys);
>> +	else
>> +		dma_addr = phys_to_dma_encrypted(dev, phys);
>
> For AMD/SME, on host with memory encryption we now end up setting the C
> bit for DMA_ATTR_MMIO. This is fine for RAM but not sure whether
> some other MMIO bus understands this attribute. Maybe we should stick to
> something like __phys_to_dma() for the !CC_SHARED && MMIO path. Or,
> since this is not universally defined, just use the old dma_addr = phys
> if MMIO and ignore any unlikely DMA offsets.
>

Considering for AMD/SME system an unencrypted dma addr is one without C
bit, will this be good?

	/*
	 * For host memory encryption and device requiring unencrypted DMA,
	 * MMIO memory is treated as shared by default.
	 */
	if (attrs & DMA_ATTR_MMIO) {
		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) || force_dma_unencrypted(dev))
			attrs |= DMA_ATTR_CC_SHARED;
	}


>
> In the other case, for an arm CCA guest, if the MMIO is shared we end up
> setting the shared attribute but that's fine, it's only an IPA address.
>
> -- 
> Catalin

-aneesh

