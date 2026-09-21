Return-Path: <linuxppc-dev+bounces-27859-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73BAC982ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 15:26:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpRs02mqZz2yfH;
	Tue, 22 Sep 2026 01:26:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790004372;
	cv=none; b=F/B0vfojRDQZGfDrVqkhjyqinNH/8FqfsOInZujtWdGibFDeqaSOOqR7TZmqjqNezljySaFavijSrnODUHsmPW7wY+rZ4c+E3MUjoNUi2EJIJZvAq8DbJLp4QvRclRL/de0cUTDAQUuZHJP5V81ajKXa/X7c4GJa0iCj3h8ZY88OHUk9bwrmACk5t2gh0ytMdWHw7/9+ybhUnTTaXBzlQB46mQVQkoWjqQPpywunrIaiVLMlU5CjqGON43nTILtzzxvHNBtbbv3jHpSZv4OWUTGUn5MyXS4XnBTwDAPEigD6slJBIMz/XQV2myohBtAwhqctNJ4Dm3fyR3wRMF+I2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790004372; c=relaxed/relaxed;
	bh=/G4SJ10TLwoXOF2o6hT3EIcBx3zt7MidRUkw+4U/uKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XljE6HNdTYyfaM62r1e/auzVJg7P2CYSm+DRBqWtGhj1JPUdy6fGNwG+thLSq4SaYzfmHKWH3e++u4UsyPnWwTnQVVPfswvpDpj5h7KA4Eu7Fqfe4cYJNJ4Pg+BryNPHFC7nRL54BCVWjOLSV9TpF3DB+prVBfbwDxFI2OVP4McO2ODBJ+/VBT6fDaZSRAlKcESP5fIt34voiDoaGRInG41laOaopnhYcRBmowChxe9O04fix2Gj3TcRr6EiIgB7BT7B/KyeUU68rl24GPCfW2T5kiUj2LRuq0rJyPIxb7v4B5X0VPBRcAMOHEdOcRLjcF8sBb0PrY0bOEX3SUn7Mw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bJ6BTSYH; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bJ6BTSYH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpRrw73Fdz2yVd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 01:26:07 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 467AE176C;
	Mon, 21 Sep 2026 08:25:31 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4049D3F9A2;
	Mon, 21 Sep 2026 08:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790004334; bh=zzx3mjbudK64AmYFt4zDvBW4IWB8i50rKocOK6Kc+dM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bJ6BTSYHKivo2/eRF9c4tWP/TAAVxpqB5Gki+6hqB70gMH9c6T0DN/7LvVp33NcYt
	 fV1Z2JO0j2YRGDrhpnqtAy2GN69cKLeg4YLIjHpGCN+UjR/tG+22iBWPqhPA/ijEBI
	 8cO8DvQWcF+Nt3XHK3carG/MXQkDFh2hAqfz/P4w=
Message-ID: <4ef23d65-02d2-4187-904b-9d1665d8cff5@arm.com>
Date: Mon, 21 Sep 2026 16:25:25 +0100
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
Subject: Re: [PATCH v5 1/6] dma: swiotlb: Centralize default pool policy
 selection
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
 <20260921063628.362078-2-aneesh.kumar@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260921063628.362078-2-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/09/2026 7:36 am, Aneesh Kumar K.V (Arm) wrote:
[...]
> diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
> index ba256c37bcc0..97fffa46f05a 100644
> --- a/arch/powerpc/kernel/dma-swiotlb.c
> +++ b/arch/powerpc/kernel/dma-swiotlb.c
> @@ -14,8 +14,10 @@ unsigned int ppc_swiotlb_flags;
>   
>   void __init swiotlb_detect_4g(void)
>   {
> -	if ((memblock_end_of_DRAM() - 1) > 0xffffffff)
> +	if ((memblock_end_of_DRAM() - 1) > 0xffffffff) {
>   		ppc_swiotlb_enable = 1;

Nit: Perhaps it's beyond the functional scope of this patch, but I do 
wonder if these <arch>_swiotlb_enable conditions become redundant and 
could just be replaced with "if (<arch>_swiotlb_flags != 0)" too.

> +		ppc_swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
> +	}
>   }
>   
>   static int __init check_swiotlb_enabled(void)
[...]
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index 75cf8f6ae8cd..0cff255827ba 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -44,8 +44,10 @@ static unsigned int x86_swiotlb_flags;
>   static void __init pci_swiotlb_detect(void)
>   {
>   	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
> -	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN)
> +	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN) {
>   		x86_swiotlb_enable = true;
> +		x86_swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
> +	}
>   
>   	/*
>   	 * Set swiotlb to 1 so that bounce buffers are allocated and used for
> @@ -81,8 +83,10 @@ static void __init pci_xen_swiotlb_init(void)
>   	if (!xen_swiotlb_enabled())
>   		return;
>   	x86_swiotlb_enable = true;
> -	x86_swiotlb_flags |= SWIOTLB_ANY;
> -	swiotlb_init_remap(true, x86_swiotlb_flags, xen_swiotlb_fixup);
> +	/* Xen can use a SWIOTLB pool anywhere in directly mapped memory. */
> +	x86_swiotlb_flags &= ~SWIOTLB_INIT_ADDRESSING_LIMIT;
> +	x86_swiotlb_flags |= SWIOTLB_INIT_REMAP | SWIOTLB_ANY;

Similarly, I see how having a SWIOTLB_INIT_REMAP flag keeps 
swiotlb_select_pool_policy() neat, but couldn't we technically already 
infer that from the fact that a non-NULL remap function was passed?

Nits aside, the overall change seems reasonable to me;

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

