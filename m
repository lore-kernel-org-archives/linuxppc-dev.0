Return-Path: <linuxppc-dev+bounces-25980-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FA5C5DF86
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 11:58:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQ4pT6SVlz2yRZ;
	Wed, 19 Aug 2026 21:58:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787140705;
	cv=none; b=TcT/00RgnH+NUALDwtDkqkIBYA5EiVvyd60D2k8pHiiZhtF6F/3xrEmeb2iSl5bp37dnMh0mm11qa9YonheCrF4yBSLJ8IbYifEJ2dQZYTVz4C+NFHPEjjYvEekVBZvYnidQuSXlqBV0d35T1gQuH/LJ4AVk9q3JQ6hteAiMTvoVrM6HVs5q086I1onUU2F6VuIzjll9L4APlRLHlXf+9SBlBNaoCbMT6Zbri7c6R4a4Uk4Cy1MUzgRbCuUnN2BwzR5XyyINGAUfGpdE5j3eL1e9XwYPZJgGYIQg6XQtca6iSsMLcSM8KZMd0gX0pR2Qz8MZEOmsFxul55+FaTl3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787140705; c=relaxed/relaxed;
	bh=EXxZGZEywjxNurZeESjYxxLymZy1CGZALFo9AOoKV8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=glpwFQnFIyJWXOf/vcitEwdzI2CPi0ByCojDJ4YfdYoQaOQMC/mLVwwd3usguCrU0Pv234ko42sHAxnm307rEI0+xqKmYPN/owNkr7JEGTQbKPxOh1Wo5mJjFw8+MCEbqbE5CTjLR0Y1JmycLzsYAUyXs3Vm/vKbQyAritz+7WizYxeGMtSla5+6T7Kz36BOM6J3trhDgEfDSH0OwWxy+TVA77rZafxi0QKseak861iaYXZiw4VXvHB7LBg/9alkeokVqjk/srIAQipFF7/7mlv68uFIV8TeEwg5m8bwXzsVa3odgu/8VzjJQcZvJpSNpzHWsFzrhF9VvJ7Ex+kwaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7sCLHr+; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7sCLHr+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQ4pS2BbCz2yDr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 21:58:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E7BEB60A59;
	Wed, 19 Aug 2026 11:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7111F000E9;
	Wed, 19 Aug 2026 11:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787140701;
	bh=EXxZGZEywjxNurZeESjYxxLymZy1CGZALFo9AOoKV8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Y7sCLHr++lEfDPrDldeMn1qW7IddWaOx5VMdOckO2EN3I1bH3mDY61TxArZ3GTMQz
	 75hGvcLct/UjSyyAOj1B/b0VdGQf17N2DqMtWlk79/oUc2pz1ZxORtokWoIAfT0Ws2
	 nbdiwbTr6aL1k6EUtD64Eue71PmdLZ26H5l1LHP2nfN/EcMH2go06a8I1Gd/yR5Efo
	 yqCeaTlLSC7dHGkteiKOQZ/s2d63g8LjWQ0lmSP23ksfhJ+xpLBpXXvthjS3W0afiZ
	 ONOi9ReMFSLV0Z79QD/T5x5/eYR53dkbgBIQ3+hhEyQSu6dKqmD4uJhs46SqA4DPu4
	 EYGNkQLMTgSpg==
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
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
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
In-Reply-To: <an9RrwoaAsqJQ2vN@arm.com>
References: <20260813102521.1367737-1-aneesh.kumar@kernel.org>
 <20260813102521.1367737-3-aneesh.kumar@kernel.org>
 <an9RrwoaAsqJQ2vN@arm.com>
Date: Wed, 19 Aug 2026 17:28:03 +0530
Message-ID: <yq5aecfuiapg.fsf@kernel.org>
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

> On Thu, Aug 13, 2026 at 03:55:21PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 9f5b366d2086..c3188ca878f3 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -338,12 +338,8 @@ void __init arch_setup_zero_pages(void)
>>  void __init arch_mm_preinit(void)
>>  {
>>  	unsigned int flags = SWIOTLB_VERBOSE;
>> -	/* pKVM uses restricted-dma-pool */
>> -	bool cc_guest = is_realm_world();
>>  
>> -	if (cc_guest)
>> -		flags |= SWIOTLB_INIT_CC_SHARED;
>> -	else if (max_pfn > PFN_DOWN(arm64_dma_phys_limit))
>> +	if (max_pfn > PFN_DOWN(arm64_dma_phys_limit))
>>  		flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
>>  
>>  	swiotlb_init(flags);
>
> This looks fine. As I mentioned on patch 1, we might as well move this
> hunk over there and avoid the flag definition.
>
>> @@ -102,9 +101,6 @@ void __init mem_encrypt_init(void)
>>  
>>  void __init mem_encrypt_setup_arch(void)
>>  {
>> -	phys_addr_t total_mem = memblock_phys_mem_size();
>> -	unsigned long size;
>> -
>>  	/*
>>  	 * Do RMP table fixups after the e820 tables have been setup by
>>  	 * e820__memory_setup().
>> @@ -112,33 +108,9 @@ void __init mem_encrypt_setup_arch(void)
>>  	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
>>  		snp_fixup_e820_tables();
>>  
>> -	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>> -		x86_swiotlb_flags |= SWIOTLB_INIT_CC_SHARED;
>> -
>>  	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>>  		return;
>>  
>> -	/*
>> -	 * For SEV and TDX, all DMA has to occur via shared/unencrypted pages.
>> -	 * Kernel uses SWIOTLB to make this happen without changing device
>> -	 * drivers. However, depending on the workload being run, the
>> -	 * default 64MB of SWIOTLB may not be enough and SWIOTLB may
>> -	 * run out of buffers for DMA, resulting in I/O errors and/or
>> -	 * performance degradation especially with high I/O workloads.
>> -	 *
>> -	 * Adjust the default size of SWIOTLB using a percentage of guest
>> -	 * memory for SWIOTLB buffers. Also, as the SWIOTLB bounce buffer
>> -	 * memory is allocated from low memory, ensure that the adjusted size
>> -	 * is within the limits of low available memory.
>> -	 *
>> -	 * The percentage of guest memory used here for SWIOTLB buffers
>> -	 * is more of an approximation of the static adjustment which
>> -	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
>> -	 */
>> -	size = total_mem * 6 / 100;
>> -	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
>> -	swiotlb_adjust_size(size);
>> -
>>  	/* Set restricted memory access for virtio. */
>>  	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
>>  }
>
> Credit to claude, it noticed a slight change in behaviour for x86 w.r.t.
> the crash kernel reservation. crash_low_size_default() reads the swiotlb
> size but the resizing now happens after arch_reserve_crashkernel().
> Maybe not an issue.
>
> Alternatively, we could build the sizing logic into
> swiotlb_size_or_default() but I haven't checked whether we have the
> right information when this function is called.
>

IIUC, the current code can still get a different value from
crash_low_size_default() than the final swiotlb size we end up using.
This is because crash_low_size_default() is computed early, before
default_nareas, which is derived from num_possible_cpus(), has been set.

If we are okay with keeping this consistent with the existing behavior,
moving sizing logic to swiotlb_adjusted_size() looks like a clean option.

>
>> @@ -382,12 +374,54 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
>>  	return tlb;
>>  }

...

>> +static bool __init swiotlb_default_pool_needs_cc_shared(void)
>> +{
>> +	/* A restricted DMA pool provides the shared buffers instead. */
>> +	return cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
>> +	       !restricted_dma_pool_present;
>> +}
>
> I don't think restricted_dma_pool_present should change the cc_shared
> attribute. The rmem pool is all about sizing the swiotlb, not disabling
> sharing.
>
> Thinking some more, if other archs don't like rmem pool influencing the
> default swiotlb size, we could add a flag (SWIOTLB_SKIP_IF_RMEM_POOL or
> some better name). But only if people dislike the heuristics.
>
>> @@ -437,9 +469,11 @@ void __init swiotlb_init_remap(unsigned int flags,
>>  		io_tlb_default_mem.phys_limit = ARCH_LOW_ADDRESS_LIMIT;
>>  #endif
>>  
>> -	if (!(flags & (SWIOTLB_INIT_ADDRESSING_LIMIT |
>> -		       SWIOTLB_INIT_CC_SHARED)) &&
>> -	    swiotlb_kmalloc_needs_bounce()) {
>> +	if (swiotlb_default_pool_needs_cc_shared()) {
>> +		io_tlb_default_mem.cc_shared = true;
>> +		swiotlb_adjust_cc_attributes();
>> +	} else if (!(flags & SWIOTLB_INIT_ADDRESSING_LIMIT) &&
>> +		   swiotlb_kmalloc_needs_bounce()) {
>
> I think at a high level, we need (i.e. separate attributed from sizing):
>
> 	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> 		io_tlb_default_mem.cc_shared = true;
>
> 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> 		if (!restricted_dma_pool_present)
> 			swiotlb_adjust_cc_size();	/* 6%, clamped */
> 	} else if (!(flags & SWIOTLB_INIT_ADDRESSING_LIMIT) &&
> 		   swiotlb_kmalloc_needs_bounce()) {
> 		swiotlb_shrink_for_kmalloc();		/* 1MB per 1GB */
> 	}
>

But pKVM wants to reduce the swiotlb size based on
kmalloc_needs_bounce() when it is using a restricted-dma-pool.

ie,
	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
		io_tlb_default_mem.cc_shared = true;
..

	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
	    !restricted_dma_pool_present) {
		swiotlb_adjust_cc_attributes();
	} else if (!(flags & SWIOTLB_INIT_ADDRESSING_LIMIT) &&
		   swiotlb_kmalloc_needs_bounce()) {

-aneesh

