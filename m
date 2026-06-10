Return-Path: <linuxppc-dev+bounces-22393-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D9BCD98C7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 08:07:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZz0Y63ZNz2ySl;
	Wed, 10 Jun 2026 18:07:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781078861;
	cv=none; b=kJ0Ee6QMw6V573iywEVlSTrD1p+OB40s9PDE47xxj40GIFUROIB7tGrV+lfS486l58zDYDhWr14aQuES+579J4DSiiJ75eFmZCrg8hA4XYS3dXo7TdIltU91EEqn8cNTKrlxvDKv4pj6BY9yZfZTNTAJEjanWqo+ZW9pT9ZfcJQp9Wo00Z/ny2ZFid+mjihZPrPybSHIlupxcbAhmwg0LTGFGhdwRhc1Gw2QLyGPprjlfqOvU7vFYbhA5Z3dxFOFqbkWPpcCj4cQ1LvC6ac5Kp8ZQYX1cqqEEFD/RPPlK7MpF+dSt5QwovVzmtLUqQe4dKezHfxAr3Z0uKG8VeodUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781078861; c=relaxed/relaxed;
	bh=0QHcq+ldvvjOXKYe7v0SGXcqZmQygGGJknrasUV2jDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZSiLKmqreFXyEvg49aqvdwlpsW6v9nP1AzNjDEQiNwpKfu0vlJTm357xWLYqPU/bYV9rZO+PeePfGWDxI6lMHJMtta7bxH5CmNDABtd/5alZx22k/h1XDoL5uI07bkqLusrHFeBAsUVN6U6LvEWC/Wqt2hvZRqk6yI3KkcfS3fU9S6ulIUZOyv/EvyAlwLvLlZOjw4JPCuGY2WO+uM9r27hEv2qGGuWxroYv0RGYp8xS7B4y5aP6b/fN428qvmB2b0J7xYvZeY2BQxX4t4/yNcL67hR1tFjluTuTdguYhe+jP4+6U7J2bvjr8WzxukBS/RXyLqkq8tJVXGQ4MeOiaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UZtvV0j4; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UZtvV0j4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZz0X5W70z2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 18:07:40 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8CCC5416F7;
	Wed, 10 Jun 2026 08:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4241F00893;
	Wed, 10 Jun 2026 08:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781078858;
	bh=0QHcq+ldvvjOXKYe7v0SGXcqZmQygGGJknrasUV2jDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=UZtvV0j4JPtGHjZWg1UsD2g+GxuSXIcXg6UMmssH9fOxo7BYN9s2Ha3MdttDa9dbZ
	 Y3LzCfYH3mse4KAw7UN/JV6C0wueAFYRrIGQ2UJ5pq6jRXX5P53Ch4aOs4N4umLYYs
	 nxpDHYwre7gShpAf+irvZS6VbqPnGX2pway8OyS6BalzGhpCmqjZn2itF7oRY6PEU+
	 SWXC9gxC0MFuAqRGUuuWYv1ujhTOYVz8b0PbDvuNVvVsTNPknSMUQy9Bm3/tqwgaF8
	 CI7mgB3EIJsBnPozx7Kng480IYc8IOGEBcGtUzsuIOR3Srq3phPC6r3VzcvBTdg+8I
	 keGWA+6ChZARA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
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
Subject: Re: [PATCH v6 04/20] dma-pool: track decrypted atomic pools and
 select them via attrs
In-Reply-To: <20260609143242.GK2764304@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-5-aneesh.kumar@kernel.org>
 <20260609143242.GK2764304@ziepe.ca>
Date: Wed, 10 Jun 2026 13:37:26 +0530
Message-ID: <yq5afr2uzum9.fsf@kernel.org>
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

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Thu, Jun 04, 2026 at 02:09:43PM +0530, Aneesh Kumar K.V (Arm) wrote:
>>  struct page *dma_alloc_from_pool(struct device *dev, size_t size,
>> -		void **cpu_addr, gfp_t gfp,
>> +		void **cpu_addr, gfp_t gfp, unsigned long attrs,
>>  		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
>>  {
>> -	struct gen_pool *pool = NULL;
>> +	struct dma_gen_pool *dma_pool = NULL;
>>  	struct page *page;
>>  	bool pool_found = false;
>>  
>> -	while ((pool = dma_guess_pool(pool, gfp))) {
>> +	while ((dma_pool = dma_guess_pool(dma_pool, gfp))) {
>> +
>> +		if (dma_pool->unencrypted != !!(attrs & DMA_ATTR_CC_SHARED))
>> +			continue;
>
> I don't think you should be overloading DMA_ATTR_CC_SHARED like this.
>
> 	/*
> 	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
> 	 * attribute. The direct allocator uses it internally after it has
> 	 * decided that the backing pages must be shared/decrypted, so the
> 	 * rest of the allocation path can consistently select DMA addresses,
> 	 * choose compatible pools and restore encryption on free.
> 	 */
> 	if (attrs & DMA_ATTR_CC_SHARED)
> 		return NULL;
>
> 	if (force_dma_unencrypted(dev)) {
> 		attrs |= DMA_ATTR_CC_SHARED;
> 		mark_mem_decrypt = true;
> 	}
>
> It is fine to have a bit inside the attrs that is only used by the
> internal logic, but it needs to have a clearer name
> __DMA_ATTR_REQUIRE_CC_SHARED perhaps.
>

Are you suggesting adding another attribute in addition to
DMA_ATTR_CC_SHARED?

Is the idea that __DMA_ATTR_REQUIRE_CC_SHARED would be used in the
allocation path to request a CC_SHARED allocation, while
DMA_ATTR_CC_SHARED would be used in the mapping path to describe the
attribute of the address?



>
> The sashiko note does look legit though:
>
> 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> 	    !gfpflags_allow_blocking(gfp) && !coherent) {
> 		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
> 					   gfp, attrs, NULL);
> 		if (!page)
> 			return NULL;
>
> I don't see anything doing the force_dma_unencrypted test along this
> callchain..
>
> I guess it should be done one step up in dma_alloc_attrs() instead of
> in dma_direct_alloc()?
>

Yes, I'll move it there.

-aneesh

