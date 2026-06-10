Return-Path: <linuxppc-dev+bounces-22394-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65464CD98C7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 08:46:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZzsR6CQkz2xfB;
	Wed, 10 Jun 2026 18:46:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781081195;
	cv=none; b=e+J9a1VEDeLl9alz6NgueEZQwNHPMYNpKU2wIbrNne3yp6pov5JfGLConZd8nZNQOZ4UzozcwnqxKTsPcRUetJ/+OdfolqaGeYW7Bto05E/fqPgKXZuN9+vp3cfG+5Bz1N0N9oiDCq0/j7XaxMItq7Om1yWpeSFU63MCKN2HS4xDWAcWt9MpVxMtBJSSbxvBdkDvVVUJMZ/c9MJNP/0tOOCOoI3YOsh1W7ZOOEzb7ez5uMO1hmKnvSffZAqsd40AZoLkGXEG6V725PqjlO267s6pnQ99sdahDEHF4zJ7Ed6PtU1WRVCm4vC6sSznEzRuQbwMR+/lDjXk/mGB8F9ALQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781081195; c=relaxed/relaxed;
	bh=GIu5mk7+fDzBkFE8LUyyxyRKu1YjSQcW0/cQDtsXGSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g0wCpg5ce68clnK0t3luSy6qQffyC3Z+fqNyCRNFOxINswFNyb+b5yJ5LRyh10nXSsIBalUiCng1Rie97EpoOx+y10TcW99OHRObfdd0HW6LcSMnxJ5bLZA1IXHierD7ztb242s2L1IkfOeyi/R0voHt9/su/cjV1xtlmLogVupEkKpe6RBzAsQhjEo7hPxcdnRx3a75b2E7WTwcMhF2ERAkcvZHl6kCFErDOGXIx2TkJjGfm5koZDvsur2DblqyBKXhjm0qEIfB4ObAFN55wTTXdlYdWnNDVHlogOMW9GIBjruY1rMJjOEwSPDJJrQ+IeVNpg1ewrcrozIAPu/S6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gqceO5Wt; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gqceO5Wt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZzsQ3TTCz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 18:46:34 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 47E4A6001A;
	Wed, 10 Jun 2026 08:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954211F00893;
	Wed, 10 Jun 2026 08:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781081191;
	bh=GIu5mk7+fDzBkFE8LUyyxyRKu1YjSQcW0/cQDtsXGSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gqceO5WtU+8o4iRLg+54E8X01VwOX/Pcl7CIT39DQ0pqmrHHo/vBxeK7jsaOAcCaS
	 YBgcKllYIQj1HWF/hPyROXVFlBBcsVf7biqD1SoLBFLlOCDPz2cSZKwrkPq2JjJeON
	 Ktk7ZoQL/je6Tm7V0x4WHLl6FPfnSFgfRLowvXIjL0V6x/Z73L5zTuiKuUCUObt8VJ
	 vIsqW9AMwRWNEkg0dDhmgKSYTJ0+WlZY+fHkDiYP/mNT/IAr5DJi+PSaHxr1QXu7ax
	 U6yoqsWAiXT9wxpMsRUn8xlVD4N61bGUJO8A/UMw01rLgt/SDu1HpcZ4IbOjfgm+V1
	 vidQTXP2nKKgg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Petr Tesarik <ptesarik@suse.com>
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
Subject: Re: [PATCH v6 06/20] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
In-Reply-To: <20260609144836.4ecea34e@mordecai>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-7-aneesh.kumar@kernel.org>
 <20260609144836.4ecea34e@mordecai>
Date: Wed, 10 Jun 2026 14:16:17 +0530
Message-ID: <yq5acxxyzsti.fsf@kernel.org>
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

Petr Tesarik <ptesarik@suse.com> writes:

> On Thu,  4 Jun 2026 14:09:45 +0530
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
>

...

>>  /*
>>   * If memory encryption is supported, phys_to_dma will set the memory encryption
>>   * bit in the DMA address, and dma_to_phys will clear it.
>> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
>> index 29187cec90d8..4dcbf3931be1 100644
>> --- a/include/linux/swiotlb.h
>> +++ b/include/linux/swiotlb.h
>> @@ -81,6 +81,7 @@ struct io_tlb_pool {
>>  	struct list_head node;
>>  	struct rcu_head rcu;
>>  	bool transient;
>> +	bool unencrypted;
>
> IIUC this is a copy of the unencrypted member in the corresponding
> struct io_tlb_mem. In other words, if pools are allocated dynamically,
> all pools must have the same encryption state, correct?
>

That is correct. The reason we have the unencrypted member in struct
io_tlb_pool is that we need it in swiotlb_dyn_free().

When freeing memory from an unencrypted pool, we need to convert the
memory back to private/encrypted

>
>>  #endif
>>  };
>>  
>> @@ -111,6 +112,7 @@ struct io_tlb_mem {
>>  	struct dentry *debugfs;
>>  	bool force_bounce;
>>  	bool for_alloc;
>> +	bool unencrypted;
>>  #ifdef CONFIG_SWIOTLB_DYNAMIC
>>  	bool can_grow;
>>  	u64 phys_limit;
>> @@ -282,7 +284,8 @@ static inline void swiotlb_sync_single_for_cpu(struct device *dev,
>>  extern void swiotlb_print_info(void);

....

>> @@ -604,30 +621,26 @@ static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
>>   * @dev:	Device for which a memory pool is allocated.
>>   * @bytes:	Size of the buffer.
>>   * @phys_limit:	Maximum allowed physical address of the buffer.
>> + * @attrs:	DMA attributes for the allocation.
>>   * @gfp:	GFP flags for the allocation.
>>   *
>>   * Return: Allocated pages, or %NULL on allocation failure.
>>   */
>>  static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
>> -		u64 phys_limit, gfp_t gfp)
>> +		u64 phys_limit, unsigned long attrs, gfp_t gfp)
>
> If my assumption above is correct, then I prefer to add a struct
> io_tlb_mem *mem parameter here and calculate the allocation attributes
> inside this function, so you don't have to repeat it in the callers.
>

Will switch to that. That is, we will use struct io_tlb_mem->unencrypted
to determine the pool attribute instead of using unsigned long attrs

>
>>  {
>>  	struct page *page;
>> -	unsigned long attrs = 0;
>>  
>>  	/*
>>  	 * Allocate from the atomic pools if memory is encrypted and
>>  	 * the allocation is atomic, because decrypting may block.
>>  	 */
>> -	if (!gfpflags_allow_blocking(gfp) && dev && force_dma_unencrypted(dev)) {
>> +	if (!gfpflags_allow_blocking(gfp) && (attrs & DMA_ATTR_CC_SHARED)) {
>
> You're removing the check that dev is non-NULL. This is fine, because
> the only call with dev == NULL is from swiotlb_dyn_alloc(), and that one
> uses GFP_KERNEL (i.e. allows blocking). However, if this is an intended
> optimization, I'd rather have it in a separate commit, with this
> explanation why it's OK to do it.
>
> The rest of the patch looks good to me.
>

I'll add that back.

-aneesh

