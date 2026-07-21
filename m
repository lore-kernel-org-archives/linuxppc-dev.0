Return-Path: <linuxppc-dev+bounces-24607-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859D4C44529
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 15:10:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4LRS5NkHz2xqJ;
	Wed, 22 Jul 2026 01:10:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784646628;
	cv=none; b=KGVv45i6kt6L1VFfNBPeiRdP3uCR4Fucc4l2KFP79E3omM4OQRP4k0dmkU38ojnV3+a8si/EdVRMJZvo+pLt92EFYnUStSq6TloN3Kaj4TxVwSu7+O292LD3JrIaZAJljBwGyUtGiaAecG6dvQjNwxIWhbGTWSGZ6MNwkXyRdrx0Wl4Q33KP1MOwFtEX51e366etGaFuLo/iAL86bS+Pc1ZI6033F5tI4lLkxsV0d6wK2bWNCi/hGBCmVqur2BcPeLAThQ1Sk727Mz5FqgfwGavAgWI7xiSpva9OMksMsEPtSjW0vU/8zRsccuYtlAHbl4YO6IEYFBUtrT+u10HUNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784646628; c=relaxed/relaxed;
	bh=bvwAwSrLeSxpgcF25JgoIOFsh0jmxPsKQj8167368cc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pi6EnFTLFjSCiEDX9KT7iwDPd8mqkWo4vDhKhlp176OJyll6NIPUxcKYcanFT5UDHKZwxhxBx7nrT4aF3AKcAVzUGwK8tD4bZgYiCuA6DcuGFIKnR6d5qM88ok7vS0jnFghZS0fFVvNqiiNYPZZtT+W3h+7IwgV3LePx8txJUpk49vMNmeJeNGmAIf3mCLxpyj+0xZ2P9SORTZi9WjuzNkJJ/PXscHSHYWKMOa6eLxMYSjnbZ9qv92r31zLK3WvbciF70qw4O16/n4zG3HLWlpk9d7Xg1l91Ke/0NmjA01dHfM9aG2pmrRAig6TAEXiyyMm5k9EabHiVqPJsjKnYIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IclAOpNz; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IclAOpNz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4LRR0JJpz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 01:10:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 742AA60054;
	Tue, 21 Jul 2026 15:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFD01F000E9;
	Tue, 21 Jul 2026 15:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784646624;
	bh=bvwAwSrLeSxpgcF25JgoIOFsh0jmxPsKQj8167368cc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=IclAOpNzF8vtkrxgfEod7QcY++7SL6g2X5yy3VGZRcTePf/oHQAgK9RU9Ox50wcfa
	 pPLYbaHBIt2vjrDtcc6F5wvhpNNXtPpSimZ2mVkiyiOxw4kutVj8SD2mR3EcAYHmPn
	 eVsQYvJl9dIUQ6ld2dvQN1ApGA6l1K7FH/KH9uLMJ5IwvN0KsMxr6zqfK2FXJmfzdD
	 pw8CTfRYP+RifEZS9qJgiTR0ptjoWabDB8Dnsy04uKD+z5Q/R1XqUquTVsGYKbV/fo
	 brOApORB0m69sbMZblmz3MJWWgPgCexjbl3S7+EttrVY84wY2vannekxqBLe6gYJNy
	 Vj7EdjPaINAMA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
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
	stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v8 01/23] dma-direct: return struct page from
 dma_direct_alloc_from_pool()
In-Reply-To: <20260721142921.GN110966@unreal>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-2-aneesh.kumar@kernel.org>
 <20260721115456.GI110966@unreal> <yq5atsps77c5.fsf@kernel.org>
 <20260721142921.GN110966@unreal>
Date: Tue, 21 Jul 2026 20:40:08 +0530
Message-ID: <yq5ao6g0750v.fsf@kernel.org>
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

Leon Romanovsky <leon@kernel.org> writes:

> On Tue, Jul 21, 2026 at 07:50:10PM +0530, Aneesh Kumar K.V wrote:
>> Leon Romanovsky <leon@kernel.org> writes:
>> 
>> > On Fri, Jul 17, 2026 at 11:34:19PM +0530, Aneesh Kumar K.V (Arm) wrote:
....
>> >>  static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
>> >> @@ -247,8 +246,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>> >>  	 * the atomic pools instead if we aren't allowed block.
>> >>  	 */
>> >>  	if ((remap || force_dma_unencrypted(dev)) &&
>> >> -	    dma_direct_use_pool(dev, gfp))
>> >> -		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>> >> +	    dma_direct_use_pool(dev, gfp)) {
>> >> +		page = dma_direct_alloc_from_pool(dev, size, dma_handle,
>> >> +						  &ret, gfp);
>> >> +		return page ? ret : NULL;
>> >
>> > Sorry for joining the discussion late, but the line above caught my
>> > attention.
>> >
>> > Why do we need both ret and page? We can derive cpu_addr from page and
>> > vice versa. Do we really need the &ret parameter? Or, more generally, do
>> > we really need "struct page *"?
>> >
>> > static struct page *__dma_alloc_from_pool(struct device *dev, size_t size,
>> > 		struct gen_pool *pool, void **cpu_addr,
>> > 		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
>> > {
>> > ...
>> > 	*cpu_addr = (void *)addr;
>> > 	memset(*cpu_addr, 0, size);
>> > 	return pfn_to_page(__phys_to_pfn(phys));
>> > }
>> >
>> > Why
>> >
>> 
>> With CONFIG_DMA_DIRECT_REMAP the cpu_addr can be different from
>> page_address.
>
> Can you please point to the code there it can happen?
> __dma_alloc_from_pool() has direct connection between physical address
> and struct page.
>

dma_direct_alloc -> 	remap = IS_ENABLED(CONFIG_DMA_DIRECT_REMAP);
	if ((remap && dma_direct_use_pool(dev, gfp)) {
		page = dma_direct_alloc_from_pool(dev, size,

..
__dma_alloc_from_pool -> 
	addr = gen_pool_alloc(pool, size);
	if (!addr)


We expand the pool as below..

atomic_pool_expand ->

#ifdef CONFIG_DMA_DIRECT_REMAP
	addr = dma_common_contiguous_remap(page, pool_size,
			pgprot_decrypted(pgprot_dmacoherent(PAGE_KERNEL)),
			__builtin_return_address(0));
	if (!addr)
		goto free_page;
#else
	addr = page_to_virt(page);
#endif


-aneesh

