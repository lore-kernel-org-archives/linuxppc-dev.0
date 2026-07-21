Return-Path: <linuxppc-dev+bounces-24600-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E474C44529
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 14:20:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4KKn2TxFz2xqJ;
	Wed, 22 Jul 2026 00:20:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784643629;
	cv=none; b=JV31YvcWCfccZ20w+MnGirWwrAvyzWs2uz0n45JXOT4FTb26aOS3Q39uhxiZQOO01xbr7rFdHDBSU6gSfZcjvlLU+QrHriOAV+zQaq6zsbtdwsjliSJ7GIF+8fZqsqwSab2ehNCGSYF3zM886NNyaA+EylGBf454ybZojr2YgCl9RQRRVB52ubb6vLwhqiBabmFdxr/HDxw8SOwcSuyE2/DvVaPU5OngrgjX2OS5yaMmO3FZymG5iS06eMB2C135kMN9fJFSvlzf5j1CSlxUV3eoOm6lwjjHPJXlqrJtOBfVUyNMJkPFYVImtslL9YU+bWEWvNkNYck83XqlSRZcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784643629; c=relaxed/relaxed;
	bh=0vlMnn1H9hiO4jT5wquIo2lbFYyrtK27kHf9bWe+2BM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gb5+X+mm1hjJT3UOXhWivZSEEVDHKy/cwIhrOjYB58gEOndbLL344HVCGljLFfRI3/9hQU5TlQPr3u8IkJtQkpJ/t5pXdQED3jIfV8muw6WE73GAnFtN0AJVWih3fiCDLMqwWTz/atgeCnEcKVroAhbArDfXtzpIjEXJppb7vRTnFiNyKz183f2qRFYUbBnyKvtVD9Ey00p+iQJCu3G3yMtaLPxu3SaFAc4W9+hwC/7ODdfGdrQA5yH5nlmx61o4bp7vWSWpQtXDVFHNllItpz0reL/JBfhF8LmNj87NFS59wOgYTgZJBn7fcy+aMYrurprCs/gDeJ3MnyVnZVWHxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZAXeJTn5; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZAXeJTn5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4KKm0G0Xz2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 00:20:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3AFF760A59;
	Tue, 21 Jul 2026 14:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992DD1F000E9;
	Tue, 21 Jul 2026 14:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643624;
	bh=0vlMnn1H9hiO4jT5wquIo2lbFYyrtK27kHf9bWe+2BM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZAXeJTn5Gpmsi+fP/8KnFVJrWtLr1s+gLT8XCY+gJDlj/j3JD5/rYU5iAxSrzp+pd
	 olYQzw9d9qnF622vSrO0xgj0l2V/UWVA/TwCEdteCq9j5ZG5/DBjpuMXcH9FrxHWil
	 v85SMWGDxZbPRG2SeJtJpKBw0NI86LxW0iHL6uBUKgcqneXjADoUesd7rroKVKo3mm
	 SC9mFdCU8LmsaoJ7LEzSPJZXaM2HeNcQ54nqu/ic/L5F5VrXdzNVoDsdMC66+nliHc
	 cM0qXX4fadGnq6/2LCkf6IQ7hjwQ818TGBo7IX/dKg+5Y2YA0GOVfKLHel40zJ33wz
	 APR8zrlv8Umyg==
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
In-Reply-To: <20260721115456.GI110966@unreal>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-2-aneesh.kumar@kernel.org>
 <20260721115456.GI110966@unreal>
Date: Tue, 21 Jul 2026 19:50:10 +0530
Message-ID: <yq5atsps77c5.fsf@kernel.org>
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

> On Fri, Jul 17, 2026 at 11:34:19PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> Commit 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool
>> helper") changed dma_direct_alloc_from_pool() to return the CPU address
>> from dma_alloc_from_pool(). That fits dma_direct_alloc(), but
>> dma_direct_alloc_pages() also uses the helper and expects a struct page *.
>> 
>> Fix this by making dma_direct_alloc_from_pool() return the struct page *
>> again, and pass the CPU address back through an out-parameter for the
>> dma_direct_alloc() caller.
>> 
>> Fixes: 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool helper")
>> Cc: stable@vger.kernel.org
>> Tested-by: Michael Kelley <mhklinux@outlook.com>
>> Tested-by: Mostafa Saleh <smostafa@google.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>  kernel/dma/direct.c | 18 ++++++++++--------
>>  1 file changed, 10 insertions(+), 8 deletions(-)
>> 
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index d8219efe3273..363d984d90e7 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -164,22 +164,21 @@ static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
>>  	return !gfpflags_allow_blocking(gfp) && !is_swiotlb_for_alloc(dev);
>>  }
>>  
>> -static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
>> -		dma_addr_t *dma_handle, gfp_t gfp)
>> +static struct page *dma_direct_alloc_from_pool(struct device *dev, size_t size,
>> +		dma_addr_t *dma_handle, void **cpu_addr, gfp_t gfp)
>>  {
>>  	struct page *page;
>>  	u64 phys_limit;
>> -	void *ret;
>>  
>>  	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_COHERENT_POOL)))
>>  		return NULL;
>>  
>>  	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
>> -	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
>> +	page = dma_alloc_from_pool(dev, size, cpu_addr, gfp, dma_coherent_ok);
>>  	if (!page)
>>  		return NULL;
>>  	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
>> -	return ret;
>> +	return page;
>>  }
>>  
>>  static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
>> @@ -247,8 +246,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>  	 * the atomic pools instead if we aren't allowed block.
>>  	 */
>>  	if ((remap || force_dma_unencrypted(dev)) &&
>> -	    dma_direct_use_pool(dev, gfp))
>> -		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>> +	    dma_direct_use_pool(dev, gfp)) {
>> +		page = dma_direct_alloc_from_pool(dev, size, dma_handle,
>> +						  &ret, gfp);
>> +		return page ? ret : NULL;
>
> Sorry for joining the discussion late, but the line above caught my
> attention.
>
> Why do we need both ret and page? We can derive cpu_addr from page and
> vice versa. Do we really need the &ret parameter? Or, more generally, do
> we really need "struct page *"?
>
> static struct page *__dma_alloc_from_pool(struct device *dev, size_t size,
> 		struct gen_pool *pool, void **cpu_addr,
> 		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
> {
> ...
> 	*cpu_addr = (void *)addr;
> 	memset(*cpu_addr, 0, size);
> 	return pfn_to_page(__phys_to_pfn(phys));
> }
>
> Why
>

With CONFIG_DMA_DIRECT_REMAP the cpu_addr can be different from
page_address.

-aneesh

