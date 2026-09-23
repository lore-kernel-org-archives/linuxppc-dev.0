Return-Path: <linuxppc-dev+bounces-28019-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14675C982FA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 13:05:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqcd71T3dz2yqw;
	Wed, 23 Sep 2026 23:04:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790168699;
	cv=none; b=H1ydTlzk7grx5XScSZXEji6tD4zDSzXxK6EGZLrftwNWQwOpnr8CGJhkgsDQoX0XQg/gcxLT05lT67bfE2LcugWm7j8KX/N8TCENIRRY6bT+CKVWVjMkGyozUVetfe+6ahqG+u7ZtQjqF7xlbQ2ziggVDlcc6lr00guGsAXqLTLS723ClMKYG1JwXEEpF/QUnPLWgyz3XnH0tvwTbJL6jNpibzFAJPBH58dbXfr3UMVpXyraveIgCCfaeUL4mH2zDRjamUhGZSDTcHdAbAU32CyIdvVDTIJ1aym43z9QYYM2piZF32eePfq7zMhAwGkxesAnjanEMHYl9pAu1oBJ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790168699; c=relaxed/relaxed;
	bh=ogBbb6P7GlWqXIs8xvSnHcODf4KNfQaxAfTAtslALNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LN2Auz2edUR7yNRwkv/Pi5ZmVAfztmOFYrbRgY4/Zo7RjHmxIKnhqiur5owc7MdHzFX3Sp4p7+uexQ7+XUwWej8Qqw9luztL3rpRm+hVnRYkZlTayQe4F/9rRqWsfFlLuCm/4/tT+44eci6Eg16astcWTooykX7kbGvwBVrbjzNZxt39ppfTaCKfR9HesMVqLHeTuwDuNeGldHWDhJNDqs6ZecD56aJqVkEX32L2KFEfn9tGNstfBrGktdy3R/1ktAUxEe2O0OmfACifjEcqCa9dmYxRSdGCaZShiYjl3ffadZRNGCW/S0OkXI9ZskquK07y5WLPt0dH1otm5jBxjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ZvqzetxD; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ZvqzetxD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqcd6003Pz2xs1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 23:04:57 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A0231570;
	Wed, 23 Sep 2026 06:04:22 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1A663F86F;
	Wed, 23 Sep 2026 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790168665; bh=V2eG6fezUymbQQ69ZuSww8KCP/5bN/QHpNMXTsYSPOw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZvqzetxDsEV+z9y8tgXSp1WMJmVGbPD4FFevEiSlqja3DG2IGWuF2b73OrQ3DI5PP
	 ebwj8SPEQZ4BaUOAgvsq/NUWIH7HsMxifQ4aW+kmBXBfzWreFCdx8DwnXmCnT2MCb1
	 pQF5HqiW/0gA6vvYspF/vjHUh2HXW5nKxCvWawCQ=
Message-ID: <8c9c04ae-cba7-4096-a7d1-70b90a46c161@arm.com>
Date: Wed, 23 Sep 2026 14:04:00 +0100
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
Subject: Re: [PATCH v5 5/6] dma: swiotlb: Add an overridable architecture pool
 opt-out
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon
 <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>,
 Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
 Petr Tesarik <ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>,
 Dan Williams <dan.j.williams@intel.com>, Xu Yilun
 <yilun.xu@linux.intel.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Russell King <linux@armlinux.org.uk>,
 Huacai Chen <chenhuacai@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, x86@kernel.org
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-6-aneesh.kumar@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260921063628.362078-6-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/09/2026 7:36 am, Aneesh Kumar K.V (Arm) wrote:
> On x86, iommu=off historically prevented SWIOTLB initialization by not
> setting SWIOTLB_INIT_ADDRESSING_LIMIT. This overloads that flag: it
> controls both whether a pool is selected and where the pool is
> allocated. If another requirement, swiotlb=force selects a pool
> independently, omitting SWIOTLB_INIT_ADDRESSING_LIMIT may place it above
> the addressable range of devices which need bounce buffering.

Well then surely something is wrong with the design? If 
SWIOTLB_INIT_ADDRESSING_LIMIT is set then SWIOTLB still needs to respect 
it irrespective of any *additional* reasons for activating (either from 
arch code or internally). And conversely, if devices have addressing 
limits but SWIOTLB_INIT_ADDRESSING_LIMIT is *not* set, then the arch 
code has clearly gone wrong or made a bad assumption, but that doesn't 
seem like SWIOTLB's problem to worry about.

> Add SWIOTLB_INIT_FORCE_DISABLE to let an architecture opt out of normal
> pool initialization without discarding the pool placement constraints.
> 
> Unlike swiotlb_force_disable, which is set by swiotlb=noforce and
> unconditionally prevents pool initialization, the new flag is an
> architecture default. Explicit requirements such as memory encryption,
> architecture remapping, or swiotlb=force take precedence over it.

Logically, that should already be implied by the architecture passing no 
SWIOTLB_INIT flags.

Thanks,
Robin.

> iommu=soft retains SWIOTLB_INIT_ADDRESSING_LIMIT because it requests
> software bounce buffering for devices whose DMA masks cannot address all
> system memory. Such devices must be able to reach the bounce pool.
> 
> Clear both flags for Xen because Xen explicitly requires a remapped
> SWIOTLB pool and may allocate it anywhere in directly mapped memory.
> 
> With no override, iommu=off disables both hardware IOMMU translation and
> SWIOTLB bouncing. Direct DMA remains available; mappings outside a
> device's addressable range fail instead of being bounced.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>   arch/x86/kernel/pci-dma.c | 11 ++++++++---
>   include/linux/swiotlb.h   |  2 ++
>   kernel/dma/swiotlb.c      | 10 ++++++++--
>   3 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index 0cff255827ba..ce257b20ea9c 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -44,9 +44,13 @@ static unsigned int x86_swiotlb_flags;
>   static void __init pci_swiotlb_detect(void)
>   {
>   	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
> -	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN) {
> -		x86_swiotlb_enable = true;
> +	if (no_iommu)
> +		x86_swiotlb_flags |= SWIOTLB_INIT_DEFAULT_OFF;
> +
> +	if (max_possible_pfn > MAX_DMA32_PFN) {
>   		x86_swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
> +		if (!no_iommu)
> +			x86_swiotlb_enable = true;
>   	}
>   
>   	/*
> @@ -84,7 +88,8 @@ static void __init pci_xen_swiotlb_init(void)
>   		return;
>   	x86_swiotlb_enable = true;
>   	/* Xen can use a SWIOTLB pool anywhere in directly mapped memory. */
> -	x86_swiotlb_flags &= ~SWIOTLB_INIT_ADDRESSING_LIMIT;
> +	x86_swiotlb_flags &= ~(SWIOTLB_INIT_ADDRESSING_LIMIT |
> +			       SWIOTLB_INIT_DEFAULT_OFF);
>   	x86_swiotlb_flags |= SWIOTLB_INIT_REMAP | SWIOTLB_ANY;
>   	swiotlb_init_remap(x86_swiotlb_flags, xen_swiotlb_fixup);
>   	dma_ops = &xen_swiotlb_dma_ops;
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index be3962a33fc6..466c33795db0 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -20,6 +20,8 @@ struct scatterlist;
>   #define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 2)
>   /* Initialize a default-sized pool that requires architecture remapping. */
>   #define SWIOTLB_INIT_REMAP		(1 << 3)
> +/* Do not initialize a pool unless SWIOTLB is explicitly required. */
> +#define SWIOTLB_INIT_DEFAULT_OFF		(1 << 4)
>   
>   /*
>    * Maximum allowable number of contiguous slabs to map,
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c19675846fc1..46b789eb0806 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -563,10 +563,16 @@ swiotlb_select_pool_policy(unsigned int flags)
>   	if (flags & SWIOTLB_INIT_REMAP)
>   		return SWIOTLB_POOL_DEFAULT;
>   
> -	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
> +	if (swiotlb_force_bounce)
>   		return SWIOTLB_POOL_DEFAULT;
>   
> -	if (swiotlb_force_bounce)
> +	/*
> +	 * Explicit requirements above override an architecture's default opt-out.
> +	 */
> +	if (flags & SWIOTLB_INIT_DEFAULT_OFF)
> +		return SWIOTLB_POOL_NONE;
> +
> +	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
>   		return SWIOTLB_POOL_DEFAULT;
>   
>   	if (swiotlb_kmalloc_needs_bounce())


