Return-Path: <linuxppc-dev+bounces-24185-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA0BC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 04:28:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzmWN6rrgz2xRs;
	Tue, 14 Jul 2026 14:28:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784003280;
	cv=none; b=UXXStdfXqWQ+iXX6Z/9BMJPKek+DASnjJgkViI5FHhp5VPI95t8kAr5P9p42Q2a3/aw5Bs5XUVhPNzz1o+IT/MmD8xvRKQ4kFkiSeqmoRuHiRak5IiGTh4TOXzv3gslx6mGbnld42vjBwAMvQ1qu4BL3gcdndO9+qtIjC1RUZjzYnEX9QfkBGIBy57DeJLryncvmBweawhuFgoJPvgcEv4TvbaYgg3BOOVgtYVAUItIaG2G7YFQqRJ3+4Xd88NIGOf3Z0jfzp5gW+WT7T/P3Y0MCvRHA9aD2zE/1m9onpZdYLKhsi8mfzmyBI8b5/M+Nvha+sj6cUJDz50c/Kxp+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784003280; c=relaxed/relaxed;
	bh=NgdeQo2TB81zknr7ANK1aIrRxeu3MOxic6XnLAtyCXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e2oktM3bqY3VGdJWKoHrz1U/ast1sTFJ6T76QRzBaDw3ErwxPUfwZHxWa4XLeorVgpv21qztG1hR13ISCDmOM9yUp3afT6qCjWRxnY31SAkG5upxlji7+xwwYe2qJw9y+fF/lX4TDbeUJbhocmnHErUZSSTCYFX7Q5vRnUViY8VUb+zl5QGtCsUCYLetoPn4/o3rt9Gi3LEN33zu5dA4H0q3tf2reXBPgKggo9SYiXXkXZfTtiP+Nja9jWm5rz5bRpnmnPWPwAYX6Fy8ha7jEUmTCHoDQ9Oty98h/cGNtv6+q3+1dbfGYbq74EvUR1tKe7Q3nDPu0RUOcXP0tsCWJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NJHJ1nkT; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NJHJ1nkT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzmWM6GyCz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 14:27:59 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2C26443BEC;
	Tue, 14 Jul 2026 04:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25181F000E9;
	Tue, 14 Jul 2026 04:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784003277;
	bh=NgdeQo2TB81zknr7ANK1aIrRxeu3MOxic6XnLAtyCXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=NJHJ1nkTI1FRoIrGQfUrmz/9sKaOTlPMfecxhsBJjkAryeyRg38SqXMsX+CgDLuGR
	 4Q+jx3b6NEJbgs8uemLCGN7Zkoj5723IXe4JdKf63X4D+ZVXsg0HpD4CBSG/Igtr2m
	 iN5AaVHORWnFjRo7d87PKE0EuKEC5tvMH/+rVtulslDEm0/njvC512nUuoYQj8gPg2
	 cWL5XiAM1KnkjzfrdR/N+hPFm8qQM/wctqv6dolHYgKwbun/QgJKr7pwtkQ+6ma+04
	 OBdUqTBT1d9bGsHovryg0z+BKJjY3K/q0L0r2iALawfRiRXGezWmC0KKAIImrBlaDY
	 5Ls8gREIG7Nzg==
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
Subject: Re: [PATCH v7 11/22] dma-pool: track decrypted atomic pools and
 select them via attrs
In-Reply-To: <20260713184810.GM3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-12-aneesh.kumar@kernel.org>
 <20260713184810.GM3133966@ziepe.ca>
Date: Tue, 14 Jul 2026 09:57:43 +0530
Message-ID: <yq5aqzl6mc00.fsf@kernel.org>
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

> On Wed, Jul 01, 2026 at 11:19:15AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> @@ -114,14 +120,17 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>>  	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
>>  	 * shrink so no re-encryption occurs in dma_direct_free().
>>  	 */
>> -	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
>> -				   1 << order);
>> -	if (ret) {
>> -		leak_pages = true;
>> -		goto remove_mapping;
>> +	if (dma_pool->cc_shared) {
>> +		ret = set_memory_decrypted((unsigned long)page_to_virt(page),
>> +					   1 << order);
>> +		if (ret) {
>> +			leak_pages = true;
>> +			goto remove_mapping;
>> +		}
>>  	}
>
> This makes the memory_decrypted conditional, but it doesn't change
> the lines a few above:
>
> 	addr = dma_common_contiguous_remap(page, pool_size,
> 			pgprot_decrypted(pgprot_dmacoherent(PAGE_KERNEL)),
>                             ^^^^^^^^^^^^
> 			__builtin_return_address(0));
> 	if (!addr)
> 		goto free_page;
>
> It is wrong to pass pgprot_decrypted() to the arch code if
> set_memory_decrypted() was not called.
>
> Also it looks at some point the nature of the atomic pool has become
> confused. Originally it was just to allocate atomic memory that had
> been vmap'd outside the atomic context (to set the non-coherent
> pgprot), so every caller was expecting non-cached memory.
>
> Then it was reused to also allocate CC shared memory outside the
> atomic context. That was fine for x86 that doesn't use DMA_REMAP but
> on ARM64 it now means all atomic pool CC memory is uncached? That
> doesn't seem to make any sense...
>
> I suppose along the lines of this patch the solution is to add a
> noncoherent property to the pool so we can select the correct
> combination:
>
>  noncoherent !SHARED = vmap pgprot_noncached
> !noncoherent  SHARED= vmap pgprot_decrypted + set_memory_decrypted
>  noncoherent  SHARED = (probably unrealistic in real systems)
> !noncoherent !SHARED = normal __dma_direct_alloc_pages()
>
> But I don't view this as that important, the CC hypervisor is probably
> going to use the S2 page table to force cachable on all system memory
> so the non-cached pgprot is a NOP, but the extra vmap is wasteful and
> it is confusing.. So maybe a little fixme is all that is needed here.
>

Something like?

modified   kernel/dma/direct.c
@@ -260,6 +260,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	/*
 	 * Remapping or decrypting memory may block, allocate the memory from
 	 * the atomic pools instead if we aren't allowed block.
+	 * FIXME!! With CONFIG_DMA_DIRECT_REMAP, the pool is also mapped as
+	 * DMA-coherent (non-cacheable). We may want to create a separate pool
+	 * dedicated to CC_SHARED atomic allocations.
 	 */
 	if ((remap || (attrs & __DMA_ATTR_ALLOC_CC_SHARED)) &&
 	    dma_direct_use_pool(dev, gfp)) {
modified   kernel/dma/pool.c
@@ -88,6 +88,7 @@ static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
 	unsigned int order;
 	struct page *page = NULL;
 	bool leak_pages = false;
+	pgprot_t prot;
 	void *addr;
 	int ret = -ENOMEM;
 	unsigned int min_encrypt_order = get_order(mem_cc_shared_granule_size());
@@ -110,8 +111,12 @@ static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
 	arch_dma_prep_coherent(page, pool_size);
 
 #ifdef CONFIG_DMA_DIRECT_REMAP
-	addr = dma_common_contiguous_remap(page, pool_size,
-			pgprot_decrypted(pgprot_dmacoherent(PAGE_KERNEL)),
+	if (dma_pool->cc_shared)
+		prot = pgprot_decrypted(pgprot_dmacoherent(PAGE_KERNEL));
+	else
+		prot = pgprot_dmacoherent(PAGE_KERNEL);
+
+	addr = dma_common_contiguous_remap(page, pool_size, prot,
 			__builtin_return_address(0));
 	if (!addr)
 		goto free_page;

