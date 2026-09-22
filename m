Return-Path: <linuxppc-dev+bounces-27886-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586C2C982FE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 05:32:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hppdg4BZbz2yFK;
	Tue, 22 Sep 2026 15:32:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790055159;
	cv=none; b=X3ixrACFGjv4NOLcA+7vn0Jf+4LhhNeH4bMCjFqUBQtn3yqy7iR0BLz1KYjB0OljKwd8mpclRR1xWcJE8L833wXX9iOBWI012MFEmIxHNrqEqb48YqWep9RiVFNNrvfJbud8EmG6szFfzZ1/8wNDw6OeSrsf7KdzbKdGzDYRchP+C8F9Q3VsfHK8gYqIZCpt+mr/ffGTguSRwaZF+M0lnB3mNYMRfkyDJgW3P/SLrjHUtHfK6yXrCdUk4XOK7Lh85UG7Y0LYLtMnBqzvlujzdL0jgbAQCyPrd7v3YlA1/iQsuNrceAtr1RjOvnKcBX+U/BD1KMtXQ8bisGbm16wDAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790055159; c=relaxed/relaxed;
	bh=2gdM7pJQWOB32IRzRuuSECTGadyK+L+jFgZIHeUlWCg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cOH/X5ABOZ1QNa9GeTn5kBdgYtVOQIg5Z7iUVVXTHsCphMXrGUb/lUj/BS/IZy2xK17r4QReKtdT04MYLk2KYnphR9RrsptUHV/R3fd5soECOb+F+hEp0fWCdMrh3OoLIfvDx2yqT1o3nnXfX+m0NCdnW4oalqg0/C2/RIqKh3UKTYo2fxyNjdAACYaLH7g0AVzAgE+Whp5jltM3B49WdEfvFG7KaKjWSgEZFTyIkhU1Hdr2jduvIP1g5b0jYvXIAXs6eJ79KlT9NRndmqPe+8H960fT8BZwb9hpTrJQic5DE2XjCfSQUnVnFe6MUg53h46xerSgbe+vT0fHi/OA/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+sHkd3I; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+sHkd3I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hppdf11fVz2xSg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 15:32:38 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C79C443B9C;
	Tue, 22 Sep 2026 05:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F581F000FF;
	Tue, 22 Sep 2026 05:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790055153;
	bh=2gdM7pJQWOB32IRzRuuSECTGadyK+L+jFgZIHeUlWCg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=V+sHkd3IFKj/u1XrhzjZHaVWFT/6SS6oRLDyXWiULliXGM1LHof1yu+9SpjH+o9S5
	 qF51+zWQXWibRxXwB+At7raCSyzo0QFJREV65DomR9GvesvkJN8pn4LgEE7wF2bO5+
	 zSLA+kNPsEZ2pyzsYhVjQ8l29HQT8LaTtO2SsCZRKyM66vejz/2Wjk0xwPsN+8GGUe
	 tM0CsZF6sBU7t3+Uuom/cP15Anfopu7hSOpU8Y+nOHLjXkTLRxs5jbdAz0AbeBgwFs
	 s6rgYq/A+/k73xGj/EHQ+h+FSnWosqmHOStWzy7hZryanbnyuEHkd8yDtMI4g2Mkxq
	 lWUOQc1CyuE7A==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v5 1/6] dma: swiotlb: Centralize default pool policy
 selection
In-Reply-To: <4ef23d65-02d2-4187-904b-9d1665d8cff5@arm.com>
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-2-aneesh.kumar@kernel.org>
 <4ef23d65-02d2-4187-904b-9d1665d8cff5@arm.com>
Date: Tue, 22 Sep 2026 11:02:18 +0530
Message-ID: <yq5av77x3l7h.fsf@kernel.org>
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

Robin Murphy <robin.murphy@arm.com> writes:

> On 21/09/2026 7:36 am, Aneesh Kumar K.V (Arm) wrote:
> [...]
>> diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
>> index ba256c37bcc0..97fffa46f05a 100644
>> --- a/arch/powerpc/kernel/dma-swiotlb.c
>> +++ b/arch/powerpc/kernel/dma-swiotlb.c
>> @@ -14,8 +14,10 @@ unsigned int ppc_swiotlb_flags;
>>   
>>   void __init swiotlb_detect_4g(void)
>>   {
>> -	if ((memblock_end_of_DRAM() - 1) > 0xffffffff)
>> +	if ((memblock_end_of_DRAM() - 1) > 0xffffffff) {
>>   		ppc_swiotlb_enable = 1;
>
> Nit: Perhaps it's beyond the functional scope of this patch, but I do 
> wonder if these <arch>_swiotlb_enable conditions become redundant and 
> could just be replaced with "if (<arch>_swiotlb_flags != 0)" too.
>


Possibly. However, x86 has a case where x86_swiotlb_enable is cleared
and used to free the swiotlb pool during initialization.

pci_iommu_init() {
	if (x86_swiotlb_enable) {
		pr_info("PCI-DMA: Using software bounce buffering for IO (SWIOTLB)\n");
		swiotlb_print_info();
	} else {
		swiotlb_exit();
	}
}

>
>> +		ppc_swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
>> +	}
>>   }
>>   
>>   static int __init check_swiotlb_enabled(void)
> [...]
>> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
>> index 75cf8f6ae8cd..0cff255827ba 100644
>> --- a/arch/x86/kernel/pci-dma.c
>> +++ b/arch/x86/kernel/pci-dma.c
>> @@ -44,8 +44,10 @@ static unsigned int x86_swiotlb_flags;
>>   static void __init pci_swiotlb_detect(void)
>>   {
>>   	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
>> -	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN)
>> +	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN) {
>>   		x86_swiotlb_enable = true;
>> +		x86_swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
>> +	}
>>   
>>   	/*
>>   	 * Set swiotlb to 1 so that bounce buffers are allocated and used for
>> @@ -81,8 +83,10 @@ static void __init pci_xen_swiotlb_init(void)
>>   	if (!xen_swiotlb_enabled())
>>   		return;
>>   	x86_swiotlb_enable = true;
>> -	x86_swiotlb_flags |= SWIOTLB_ANY;
>> -	swiotlb_init_remap(true, x86_swiotlb_flags, xen_swiotlb_fixup);
>> +	/* Xen can use a SWIOTLB pool anywhere in directly mapped memory. */
>> +	x86_swiotlb_flags &= ~SWIOTLB_INIT_ADDRESSING_LIMIT;
>> +	x86_swiotlb_flags |= SWIOTLB_INIT_REMAP | SWIOTLB_ANY;
>
> Similarly, I see how having a SWIOTLB_INIT_REMAP flag keeps 
> swiotlb_select_pool_policy() neat, but couldn't we technically already 
> infer that from the fact that a non-NULL remap function was passed?
>


I thought deriving the entire pool policy from the flags made the code
easier to follow. For example, if flags == 0 and remap != NULL, we would
also need to pass remap to swiotlb_select_pool_policy() to determine the
policy.

>
> Nits aside, the overall change seems reasonable to me;
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks
-aneesh

