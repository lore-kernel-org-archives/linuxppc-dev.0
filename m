Return-Path: <linuxppc-dev+bounces-24593-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3598C4451C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 12:31:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4Gvp5rThz2xqJ;
	Tue, 21 Jul 2026 22:31:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784637078;
	cv=none; b=ZpHIcfhX294v2QbCMZrBRO9pb3z8MzI5ugdEW0sh7EoPHlU+4VXs4d/6lVgUDUHEnhwkHdzkzALu9emMje+fc5qGt72r0p9P4TBeL9JJYQISvzKAZLbrsMHsMFO6Ccjq2bMncM3W/ATEdlpYb2h4X+m851ol6S2NtoBTVl1p0+PRW7pKTUXj92x5/cN+zY7Nxuwdw1Yi9eRyWV7hkd2ElP2fck/ridSj7x9EzS9yQ70e5JlqrzS+djV2cnOtOZjSI0vIPDItOO/fxqiTtVjv7u3pl67m6wUcbWCR8izrG+BliJqf364a37MiaBzNC/DyjpYKVFNfs2hD3w+MTOM/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784637078; c=relaxed/relaxed;
	bh=wWSrAB9EVKT/XWaemQKPpIPZcdC2pMdFep2pkjliXa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRN7L0jeoBRXd8mZ+xRh6Py87cqck8C6atraru4VdhM7n2cw0ed4pR1DWQi2KJH3THKOXnMgNjcfI0bFQk9VyQNiD8sk1M/iXtZEzg/EQO0M2Q6gDXLofQXTS3/Ws48j07vQRU/kPwGv0JHEuDR6HUB6TKZtP1/2EiuyV1TUDEyIqZKTjWxVp8FUFfSjRZyq2fKjxgWfOR5tNBx431Whvs643/Ubi9G1mYF7+pLYXZoK9Fb92K9Z8hnF1J7uiUbk73sN4r8TsYxyVieWfgFkJDVJPVPO3kkRks1u5rpRkzdGKPE/Et4jI+zr0aOZjXXZ1lXSp+ty6D/VxV/Dis9ejQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NMAaRN/0; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NMAaRN/0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4Gvn4y0xz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 22:31:17 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 10FD6600AE;
	Tue, 21 Jul 2026 12:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D601F000E9;
	Tue, 21 Jul 2026 12:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784637074;
	bh=wWSrAB9EVKT/XWaemQKPpIPZcdC2pMdFep2pkjliXa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NMAaRN/0pR1UXrKesy1NVUZZb3tGCe/Vlw+6q4IisWckyQHrk7t8f9UFf/nD3eOc2
	 cDCyPrN6wzIW97ofA8f2c/wOZcBa5yT6IRAiQ8btVup6aqmVGAsCaPvNMbuEE0ea+q
	 gdY7WVBH3xSnTaTrfUnVBaVXFPSS6ziUrVglN++YJIJJeonhivjr96HgNl/cpK8ecU
	 NGtirSdm7tyorkJEWFNzDuIDdmKgeLCYl928d21hGD0TfQj7dV7V7bAxdG5f06L2hm
	 kigSERMdxJZyFtBgL6QvorkJiWKTsBMC3d4eEgC9yuIQX2gmXno0ZvJ/a70zLANA5C
	 C987wbhcZtg2A==
Date: Tue, 21 Jul 2026 15:31:07 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
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
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 02/23] dma-pool: fix page leak in atomic_pool_expand()
 cleanup
Message-ID: <20260721123107.GJ110966@unreal>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-3-aneesh.kumar@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717180442.110954-3-aneesh.kumar@kernel.org>

On Fri, Jul 17, 2026 at 11:34:20PM +0530, Aneesh Kumar K.V (Arm) wrote:
> atomic_pool_expand() frees the allocated pages from the remove_mapping
> error path only when CONFIG_DMA_DIRECT_REMAP is enabled.
> 
> When CONFIG_DMA_DIRECT_REMAP is disabled, failures after page allocation,
> such as gen_pool_add_virt(), jump to remove_mapping and return without
> freeing the pages.
> 
> Move __free_pages(page, order) out of the CONFIG_DMA_DIRECT_REMAP block so
> that cleanup paths always release the allocation.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/pool.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 2b2fbb709242..b0303efbc153 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -81,6 +81,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  {
>  	unsigned int order;
>  	struct page *page = NULL;
> +	bool leak_pages = false;
>  	void *addr;
>  	int ret = -ENOMEM;
>  
> @@ -115,8 +116,10 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  	 */
>  	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
>  				   1 << order);
> -	if (ret)
> +	if (ret) {
> +		leak_pages = true;
>  		goto remove_mapping;
> +	}
>  	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
>  				pool_size, NUMA_NO_NODE);
>  	if (ret)
> @@ -130,14 +133,15 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  				   1 << order);
>  	if (WARN_ON_ONCE(ret)) {
>  		/* Decrypt succeeded but encrypt failed, purposely leak */
> -		goto out;
> +		leak_pages = true;

Instead of doing this dance with temporal variable, change "goto out" to
be "return true".

>  	}
>  remove_mapping:
>  #ifdef CONFIG_DMA_DIRECT_REMAP
>  	dma_common_free_remap(addr, pool_size);
>  free_page:

Remove free_page label, and change leftover of "goto free_page" to be
"goto out"

> -	__free_pages(page, order);
>  #endif
> +	if (!leak_pages)
> +		__free_pages(page, order);

Put these checks under out label and rely on page != NULL as a marker.
if (page)
 __free_pages(page, order);

>  out:
>  	return ret;
>  }
> -- 
> 2.43.0
> 
> 

