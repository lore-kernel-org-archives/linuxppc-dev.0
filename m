Return-Path: <linuxppc-dev+bounces-27863-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B78C982E6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 16:50:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpTkL2SShz2yfH;
	Tue, 22 Sep 2026 02:50:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790009434;
	cv=none; b=S9TQw9sqZomBUw7Wkt8u6I5fid5TLw26ljJTTj43Wlx+iCDaZVo0BRF7DQuzWgQuM1vEKdt+khr39HQELwSei2kgOb0cb2efM0jocOytVhSal5Uuqd8UXFMP8MQ8IlZ8tq8SSjwTnC8+VBklQOk3hPKTyxGiNVXnKX1PPm4YOsnd99P+jVp1XwGRODeg9A6b4jXOxE3GJPaJpwc6Id+tdaDeLnSbpovS7DNmafrL7Z3XRetu6ibxd9wuXbciDZ4+w8sic6p+ek2zodMfSCI9AZVeeQIjF1/dEGbFh63cLS+gc0DP4ymMUsw3vvHRYa2ZfS0pSL0xRnM1idwyyl5SYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790009434; c=relaxed/relaxed;
	bh=9Hw49sKCrk0TxQWy4HKwk2Z7RruqtWeFijH78wRP870=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4lE1REOvf6T+Sfb7rqL7cGLFod6rSjuVU01WlVUmjkCgGTMzpCPKop+UtxWM1eVBC9CEtAhfyqPqS2OjDa34fUEpTGtQ7sccUdTXzYYWQnijm7+G/VbI/QUifsq1QgZDcO3ifvmRjarUKJcAIUb1h/EBL3fFXFIF/MyOpBs2WhmcNdsyPfSymiasK8uNmMgVr1JOlq3uY8FQs1pBbBnyceR35ftPNLfHEQ9r8ZWXY3rCiLDrBDjjkS5kZbeGKwW6Gy5GNW20cp7MXOaCEVBmsJMDpweha4XZg40qKjMM2YaUmg3KE65H0mKkm2zx70Qd59x9RdqCIFq1aaqEDVbjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XQmomevp; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XQmomevp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpTkJ0qGSz2yVd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 02:50:30 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9584919F0;
	Mon, 21 Sep 2026 09:49:53 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C3E73F9A2;
	Mon, 21 Sep 2026 09:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790009397; bh=Wdg09chPpqQgC/K0e8SKRfjnjFGDVmMx8BswypSmTA0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XQmomevpZT09cy6cgr1kTzu2so5J171U16ite1cLw6tf7wJFB4IdlH5QxKz6sSd/4
	 qRHE98CmDqCVVIr1K3Cv1yP6IMXAdywdYQoc3xBrma/fZL4DL86RO08+Hgqua4e3tA
	 tpLMTY+ABzQMH+5gDW1Tr/akzSw8iQXUsL5/7yfc=
Message-ID: <21180ec6-b9ad-43fd-9e52-51df644e1b93@arm.com>
Date: Mon, 21 Sep 2026 17:49:42 +0100
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
Subject: Re: [PATCH v5 3/6] dma: swiotlb: Centralize minimal pool sizing
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
 <20260921063628.362078-4-aneesh.kumar@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260921063628.362078-4-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/09/2026 7:36 am, Aneesh Kumar K.V (Arm) wrote:
> A default SWIOTLB pool used only for unaligned kmalloc bouncing can be
> smaller than one required for limited DMA addressing. Arm64 and RISC-V
> currently implement this sizing independently, using 1 MiB of SWIOTLB
> space per GiB of RAM.
> 
> The SWIOTLB core now identifies this case with SWIOTLB_POOL_MINIMAL.
> Size that policy in swiotlb_adjust_pool_size() and remove the
> architecture-specific adjustments.
> 
> Explicit swiotlb= sizing remains unchanged because swiotlb_adjust_size()
> preserves a user-configured size.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>   arch/arm64/mm/init.c | 11 -----------
>   arch/riscv/mm/init.c |  4 ----
>   kernel/dma/swiotlb.c | 11 ++++++++++-
>   3 files changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 7d51fb5f5a71..95075b5c8207 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -340,17 +340,6 @@ void __init arch_mm_preinit(void)
>   {
>   	unsigned int flags = SWIOTLB_VERBOSE;
>   
> -	if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
> -		/*
> -		 * If no bouncing needed for ZONE_DMA, reduce the swiotlb
> -		 * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.
> -		 */
> -		unsigned long size =
> -			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
> -
> -		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
> -	}
> -
>   	if (max_pfn > PFN_DOWN(arm64_dma_phys_limit))
>   		flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
>   
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index e0e4c103d603..96856114b387 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -183,10 +183,6 @@ void __init arch_mm_preinit(void)
>   		 * memory when DRAM starts above dma32_phys_limit.  Allocate
>   		 * ~1 MB per 1 GB of RAM.
>   		 */
> -		unsigned long size =
> -			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
> -		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
> -		swiotlb = true;
>   		swiotlb_flags |= SWIOTLB_ANY;
>   	}
>   
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 8f86deb25be2..f368a73f4ed0 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -483,9 +483,18 @@ static bool __init swiotlb_kmalloc_needs_bounce(void)
>   static void __init
>   swiotlb_adjust_pool_size(enum swiotlb_pool_policy policy)
>   {
> +	if (swiotlb_default_size_changed())
> +		return;
> +

This appears to be entirely redundant, as ultimately the point of this 
function is to call swiotlb_adjust_size() (if it does anything at all), 
and the first thing that does is this same exact check. We hardly need 
to micro-optimise short-circuiting a handful of arithmetic in a one-off 
setup path, and it's convoluted enough as it is, so please try to avoid 
redundancy that makes it even more confusing to follow.

>   	switch (policy) {
> -	case SWIOTLB_POOL_MINIMAL:
> +	case SWIOTLB_POOL_MINIMAL: {
> +		unsigned long size;
> +
> +		/* Use 1MB per 1GB of RAM for kmalloc() bouncing. */
> +		size = DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
> +		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
>   		break;

Similarly I think it would be clearer if we had a common 
swiotlb_adjust_size() call at the end of the function, and then either 
calculate a size or return early in each switch case as appropriate.

Furthermore, swiotlb_size_or_default() is awful IMO - and in fact after 
this series we could perhaps clean it up entirely by making the size 
implicit in swiotlb_init_late() - not to mention misleadingly redundant. 
I'd say just open-code "default_nslabs << IO_TLB_SHIFT" like elsewhere 
in the file, but in fact it may as well just be IO_TLB_DEFAULT_SIZE 
(think about it...)

Thanks,
Robin.

> +	}
>   	case SWIOTLB_POOL_CC_GUEST:
>   		break;
>   	case SWIOTLB_POOL_NONE:


