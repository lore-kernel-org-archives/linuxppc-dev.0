Return-Path: <linuxppc-dev+bounces-23818-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EC0C44501
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 12:12:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwH6G2lsMz2xll;
	Wed, 08 Jul 2026 22:12:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783512758;
	cv=none; b=C2zPt6KkMAluu2SOTPZLpPUfWSyNtJSkgsWzRAYWmqJbEWTLoBnM2L6raapZsMSOLvOlbU7jbQGYKBbZ2XOjLYZ1zwwHZca5EBzP1tzzIRjVMDDuT35EkVlmZvtrDfLIqiWFdUHTnpknf7Gw0/aNphbdTV2E8Bbep+WHuBifZ9vr8xSU24QF0+p93Js0WHvQTxoXhrKqFETBz27XH9QviomQ3OeGDPKnzDgBmUB5AOTf3thU9fF1/r1T7h/YxV21EQT2Mj0HlKMVsYxafLopjOjFrv3PWiAkePR0vyeUbd2Jt8xAOXen9J0UuB328v1yuxrmJB4XTrNWevqmNfrbTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783512758; c=relaxed/relaxed;
	bh=V2AT9xr1vEyQ54p+OXNl/EXreb4EIkVz492WmIMeztY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z3TvEw+1lqJ+eGFgLdCWtAtl4dhotpW17Q/CY7FlfMD89oPjWkUgSEoGvB2Lvmu7TrHsWQ2t+nimiPB3xmv8zqC+lufxVT9Ht6GkyeINtpiyil7RBkCKaUr5sYhdcoISSQst1KJUBuYeIP/+0ezZS2kSlg7qj7XeIlE/JfE1t7/rmrNK8531q20Z7JATwhGsRu5PnVqXiMXjsX6ord1P34vqoyojCShgMn+leqm34zoQrmO6LP5fuy80obyuMkrLMayA92/tXOHewfuoU5ccaT77YfdTnLu7piwCs/PnDXU0H4L0TjbbZOvq0VibGCNh2ijiW9+xcJNwqG426fdeCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VYLThK6n; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=suzuki.poulose@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VYLThK6n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=suzuki.poulose@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwH6F0jnqz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 22:12:36 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8995215A1;
	Wed,  8 Jul 2026 05:12:00 -0700 (PDT)
Received: from [10.1.37.27] (Suzukis-MBP.cambridge.arm.com [10.1.37.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B81CF3F7B4;
	Wed,  8 Jul 2026 05:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783512724; bh=8/7zvmWxegXEn2qwWzbLy+la1fhDjUolmn1c+tkuiCo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VYLThK6nv7poE0WxqyAkkUzVattkhpNXgz0FB5kUhD63AtBVZyrisuMmv5M0CoESI
	 L6c2zVVqqGetqMAqNotIZPSb5x7ZJI/M+DkEmmj/SyrIe71mPHqJUlt3Lr8T1+qgXX
	 3+YkEUZClQkuG47VW0GuZxUiJRDmk0w4H31JziKU=
Message-ID: <79a41669-72f0-4068-9f38-62fb586d9180@arm.com>
Date: Wed, 8 Jul 2026 13:11:57 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Content-Language: en-GB
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>,
 Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
 Petr Tesarik <ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>,
 Dan Williams <dan.j.williams@intel.com>, Xu Yilun
 <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
 Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20260701054926.825925-17-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/07/2026 06:49, Aneesh Kumar K.V (Arm) wrote:
> Teach dma_direct_map_phys() to select the DMA address encoding based on
> DMA_ATTR_CC_SHARED.
> 
> Use phys_to_dma_unencrypted() for decrypted mappings and
> phys_to_dma_encrypted() otherwise. If a device requires unencrypted DMA
> but the source physical address is still encrypted, force the mapping
> through swiotlb so the DMA address and backing memory attributes remain
> consistent.
> 
> Update the arm64, x86, s390 and powerpc secure-guest setup to not use
> swiotlb force option
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
> Changes from v3:
> * Handle DMA_ATTR_MMIO
> ---
>   arch/arm64/mm/init.c                 |  4 +--
>   arch/powerpc/platforms/pseries/svm.c |  2 +-
>   arch/s390/mm/init.c                  |  2 +-
>   arch/x86/kernel/pci-dma.c            |  4 +--
>   kernel/dma/direct.c                  |  4 ++-
>   kernel/dma/direct.h                  | 45 +++++++++++++++-------------
>   6 files changed, 31 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 97987f850a33..acf67c7064db 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -338,10 +338,8 @@ void __init arch_mm_preinit(void)
>   	unsigned int flags = SWIOTLB_VERBOSE;
>   	bool swiotlb = max_pfn > PFN_DOWN(arm64_dma_phys_limit);
>   
> -	if (is_realm_world()) {
> +	if (is_realm_world())
>   		swiotlb = true;
> -		flags |= SWIOTLB_FORCE;
> -	}
>   
>   	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb) {
>   		/*


For arm64 CCA bits:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

