Return-Path: <linuxppc-dev+bounces-22323-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F422CD8C92
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 12:23:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZSkC10C4z2ytV;
	Tue, 09 Jun 2026 22:23:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781007811;
	cv=none; b=Kt6qZAau1iB4TmieKub60KHAmYKo0wPfPzrmGyZkV2WOi7bTYubIEIV9tP7iWDhAW07NvKaiLz33JhjYwjF/G2MfDRc9I/1pSz2j9W1nJ3sYys2XfHJ/1KnPiTpNfRzetsm1S/2c2T6FHb6is7G9Cu77NDCBElI4WjKF4vJHN6XyJgyK6dh5HuP7UKYQJ6u/inSY0lZKAPMo66wHv9MGf4Lkv0rnLvvT0qM871k5Y/t2AhrH41eq2/8BhMLnp21d+OMTxkNTxc8ysKtarM8uQSFytedTuYEallh7Tc4XJ1jvhbwdeYfpj8fVHulJDKJ0Rg0TYvjmuU6h935pahuxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781007811; c=relaxed/relaxed;
	bh=3mQLuvtz3glfIEIPFlr7hcRvFUTFmCVW/e4HDdH4bW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2/qn7Xm83bXdZ9PkPSE5WiSTkpkcsSI+ieTz8ncE9Hnmw/j1L9lRCvlP80AXFSFGkz7pMnzS1gjrgFpCfdJEPkRE7jE8e4IpmvEs6pynGi0wommfDyGaoK1v66oI2P1L1dPGfVNC90I1c0kqeXVm7MurzTIdSkEBJWurVjKpUuNi+HBT8eFjbWyhHaaaEWgg00v3PKgEZOKUNvVsdAbLrIYQzcOQXlIF0eq0y+tl1JD8vWWulpUXdA1Hn7nQAt/dkfZEgc/snQlu526rjjhp3nzc0NSJ6nivXsJ9pnQYKYUjWYCFj+Jn7zj/GvhzBP2J7Vm65IGiqCW0W206CEMYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Pf2lx9TM; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Pf2lx9TM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZSk95Tr3z2ySf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 22:23:29 +1000 (AEST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-490ae0812c9so4300525e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 05:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781007807; x=1781612607; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mQLuvtz3glfIEIPFlr7hcRvFUTFmCVW/e4HDdH4bW4=;
        b=Pf2lx9TMcUc5k0Pi+lxER3+dyZS1aIntwESNMY+PJZihRcb9OdVuyGFWapVyr1qwrY
         bhOySCTMkMaPf8Rgf2k6T9Z0Js/ydbweG/NvRlqf/y90S6pKKYL1nhpqXtkkEwj0UXOI
         3Cgi9GI4E29fyrIuPWuvTewwqvvpTqj2RCNk2nNGfaDdglyCp18yj4skczZj3SS0QExX
         PJj3+TfVYpy2U3fa0BLnQaAKWR2xJqFk7tWPV1HMTEizBOvFlNlUEMuNzewymygLPICX
         A1j17nmbfzP5xNir9BFDvgktr43XMNwTvKexPzd14LRkjtD95beZHp2Io9ouKSynSkJD
         ex7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781007807; x=1781612607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3mQLuvtz3glfIEIPFlr7hcRvFUTFmCVW/e4HDdH4bW4=;
        b=A3LPNUg6T1zVolVYgdPrDX68pPt679ltiV56qUQxsdteVm5y42qxDzJ6sA851kTGpG
         ri3wItNEaa9T/GWgMorO3HcgpDAeeGj+TF5Z6bhX+ZZfKF2PsiYXDTD0TEYncM+03jBV
         nD5jIjZn4uZQWXTVUPHiM+euSpCn1j/KbOOy7FYWphhVHZ7VQDgVP9KxxQpiMEH8WHR4
         rAlApSRh5JEM4Q9+vPAA8LBIuGiF1kFzkJpnhfbOWdRELCvkY9aG9q1Q/IF5dRLyHnxf
         4kkb7ZO0Jo8nGsIJ7ttEPvw9VMDrysxwR45JdpswDccJ6mIq+k126rwtqNmGDcjCkKZJ
         d9CA==
X-Forwarded-Encrypted: i=1; AFNElJ+rTU1Kp98WOj0wzSPyP7n6Mz/VeVJpYWfY+bVrNgcJZ9oaqjBF3AgHeoj88WjGpD1O2jRYbSl+hoDYdq8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw+DOUwml7jiWyYfgI1EjkgXJqm10SgVr2QA8tclP9DS1p4PFJu
	4a15BQqgqz2D7/CeYdtqSo34UWrLtFYs8KJFkDqM2EoFaapSIfVjpJZT1xq5VLlJ9pE=
X-Gm-Gg: Acq92OFiRacbK80D+C1YErb4dyIfS1l7wjxlFMufc2qfh/vb2PIQAXPUh24ze8+IqkE
	aaYmYO9qwCN+UC3rOrHK61nE9a7pWRoXIq2W8KnXE/fY+V8X2TZt/rVCCbU6GvS1CDUy28zz1gt
	AJQx/SZDvXE6Gc76quOjsM/tftP16cXUfgMb68cs8LDB5/aKxREu2BAtzZISW4qm872PnVsG5FM
	mnnFAGf75beyuMGi4z4VcaNMWy7HTGtsnAgsVsE9TCA+Hw3fKD9X4pRTPbnl9+U0DUU51PG1Kc1
	GqEuOVMTW2a6urCIO9PQsy/0qKgs8G6ohzAtB+wtFumDZxlxF7MQGBeN3V+0s4Fa42t+qupuj6l
	BVNwkpGWumvBLcQULGtJ1VoZY1/J45zDJJzLK5PH/6AqHDveW+PoVAG/DV3hKVK5ZC5ayXDc0ev
	dRJY09hSNefUD0rkzi41fiBls=
X-Received: by 2002:a05:600c:5286:b0:490:a2f4:c498 with SMTP id 5b1f17b1804b1-490c2618175mr140985815e9.6.1781007806640;
        Tue, 09 Jun 2026 05:23:26 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413541sm514472945e9.14.2026.06.09.05.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 05:23:26 -0700 (PDT)
Date: Tue, 9 Jun 2026 14:23:17 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Will
 Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price
 <steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Alexey
 Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
 Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, x86@kernel.org, Jiri Pirko <jiri@nvidia.com>,
 Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 04/20] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260609142317.46569b8a@mordecai>
In-Reply-To: <20260604083959.1265923-5-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-5-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 14:09:43 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Teach the atomic DMA pool code to distinguish between encrypted and
> unencrypted pools, and make pool allocation select the matching pool based
> on DMA attributes.
> 
> Introduce a dma_gen_pool wrapper that records whether a pool is
> unencrypted, initialize that state when the atomic pools are created, and
> use it when expanding and resizing the pools. Update dma_alloc_from_pool()
> to take attrs and skip pools whose encrypted state does not match
> DMA_ATTR_CC_SHARED. Update dma_free_from_pool() accordingly.
> 
> Also pass DMA_ATTR_CC_SHARED from the swiotlb atomic allocation path so
> decrypted swiotlb allocations are taken from the correct atomic pool.
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

FWIW this also looks good to me, but I don't think I'm the best person
to review changed to DMA generic pools.

Petr T

> ---
>  drivers/iommu/dma-iommu.c   |   2 +-
>  include/linux/dma-map-ops.h |   2 +-
>  kernel/dma/direct.c         |  11 ++-
>  kernel/dma/pool.c           | 167 +++++++++++++++++++++++-------------
>  kernel/dma/swiotlb.c        |   7 +-
>  5 files changed, 123 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 54d96e847f16..c2595bee3d41 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1673,7 +1673,7 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>  	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
>  	    !gfpflags_allow_blocking(gfp) && !coherent)
>  		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
> -					       gfp, NULL);
> +					   gfp, attrs, NULL);
>  	else
>  		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
>  	if (!cpu_addr)
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 6a1832a73cad..696b2c3a2305 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -212,7 +212,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size, pgprot_t prot,
>  void dma_common_free_remap(void *cpu_addr, size_t size);
>  
>  struct page *dma_alloc_from_pool(struct device *dev, size_t size,
> -		void **cpu_addr, gfp_t flags,
> +		void **cpu_addr, gfp_t flags, unsigned long attrs,
>  		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
>  bool dma_free_from_pool(struct device *dev, void *start, size_t size);
>  
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 90dc5057a0c0..681f16a984ab 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -154,7 +154,7 @@ static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
>  }
>  
>  static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t gfp)
> +		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
>  	struct page *page;
>  	u64 phys_limit;
> @@ -164,7 +164,8 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
>  		return NULL;
>  
>  	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
> -	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
> +	page = dma_alloc_from_pool(dev, size, &ret, gfp, attrs,
> +				   dma_coherent_ok);
>  	if (!page)
>  		return NULL;
>  	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> @@ -253,7 +254,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	 */
>  	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
>  	    dma_direct_use_pool(dev, gfp))
> -		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
> +		return dma_direct_alloc_from_pool(dev, size, dma_handle,
> +						  gfp, attrs);
>  
>  	if (is_swiotlb_for_alloc(dev)) {
>  		page = dma_direct_alloc_swiotlb(dev, size);
> @@ -401,7 +403,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  		attrs |= DMA_ATTR_CC_SHARED;
>  
>  	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
> -		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
> +		return dma_direct_alloc_from_pool(dev, size, dma_handle,
> +						  gfp, attrs);
>  
>  	if (is_swiotlb_for_alloc(dev)) {
>  		page = dma_direct_alloc_swiotlb(dev, size);
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 2b2fbb709242..be78474a6c49 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -12,12 +12,18 @@
>  #include <linux/set_memory.h>
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
> +#include <linux/cc_platform.h>
>  
> -static struct gen_pool *atomic_pool_dma __ro_after_init;
> +struct dma_gen_pool {
> +	bool unencrypted;
> +	struct gen_pool *pool;
> +};
> +
> +static struct dma_gen_pool atomic_pool_dma __ro_after_init;
>  static unsigned long pool_size_dma;
> -static struct gen_pool *atomic_pool_dma32 __ro_after_init;
> +static struct dma_gen_pool atomic_pool_dma32 __ro_after_init;
>  static unsigned long pool_size_dma32;
> -static struct gen_pool *atomic_pool_kernel __ro_after_init;
> +static struct dma_gen_pool atomic_pool_kernel __ro_after_init;
>  static unsigned long pool_size_kernel;
>  
>  /* Size can be defined by the coherent_pool command line */
> @@ -76,11 +82,12 @@ static bool cma_in_zone(gfp_t gfp)
>  	return true;
>  }
>  
> -static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
> +static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
>  			      gfp_t gfp)
>  {
>  	unsigned int order;
>  	struct page *page = NULL;
> +	bool leak_pages = false;
>  	void *addr;
>  	int ret = -ENOMEM;
>  
> @@ -113,12 +120,17 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
>  	 * shrink so no re-encryption occurs in dma_direct_free().
>  	 */
> -	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
> -				   1 << order);
> -	if (ret)
> -		goto remove_mapping;
> -	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
> -				pool_size, NUMA_NO_NODE);
> +	if (dma_pool->unencrypted) {
> +		ret = set_memory_decrypted((unsigned long)page_to_virt(page),
> +					   1 << order);
> +		if (ret) {
> +			leak_pages = true;
> +			goto remove_mapping;
> +		}
> +	}
> +
> +	ret = gen_pool_add_virt(dma_pool->pool, (unsigned long)addr,
> +				page_to_phys(page), pool_size, NUMA_NO_NODE);
>  	if (ret)
>  		goto encrypt_mapping;
>  
> @@ -126,62 +138,67 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  	return 0;
>  
>  encrypt_mapping:
> -	ret = set_memory_encrypted((unsigned long)page_to_virt(page),
> -				   1 << order);
> -	if (WARN_ON_ONCE(ret)) {
> -		/* Decrypt succeeded but encrypt failed, purposely leak */
> -		goto out;
> -	}
> +	if (dma_pool->unencrypted &&
> +	    set_memory_encrypted((unsigned long)page_to_virt(page), 1 << order))
> +		leak_pages = true;
> +
>  remove_mapping:
>  #ifdef CONFIG_DMA_DIRECT_REMAP
>  	dma_common_free_remap(addr, pool_size);
>  free_page:
> -	__free_pages(page, order);
> +	if (!leak_pages)
> +		__free_pages(page, order);
>  #endif
>  out:
>  	return ret;
>  }
>  
> -static void atomic_pool_resize(struct gen_pool *pool, gfp_t gfp)
> +static void atomic_pool_resize(struct dma_gen_pool *dma_pool, gfp_t gfp)
>  {
> -	if (pool && gen_pool_avail(pool) < atomic_pool_size)
> -		atomic_pool_expand(pool, gen_pool_size(pool), gfp);
> +	if (dma_pool->pool && gen_pool_avail(dma_pool->pool) < atomic_pool_size)
> +		atomic_pool_expand(dma_pool, gen_pool_size(dma_pool->pool), gfp);
>  }
>  
>  static void atomic_pool_work_fn(struct work_struct *work)
>  {
>  	if (IS_ENABLED(CONFIG_ZONE_DMA))
> -		atomic_pool_resize(atomic_pool_dma,
> +		atomic_pool_resize(&atomic_pool_dma,
>  				   GFP_KERNEL | GFP_DMA);
>  	if (IS_ENABLED(CONFIG_ZONE_DMA32))
> -		atomic_pool_resize(atomic_pool_dma32,
> +		atomic_pool_resize(&atomic_pool_dma32,
>  				   GFP_KERNEL | GFP_DMA32);
> -	atomic_pool_resize(atomic_pool_kernel, GFP_KERNEL);
> +	atomic_pool_resize(&atomic_pool_kernel, GFP_KERNEL);
>  }
>  
> -static __init struct gen_pool *__dma_atomic_pool_init(size_t pool_size,
> -						      gfp_t gfp)
> +static __init struct dma_gen_pool *__dma_atomic_pool_init(struct dma_gen_pool *dma_pool,
> +		size_t pool_size, gfp_t gfp)
>  {
> -	struct gen_pool *pool;
>  	int ret;
>  
> -	pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
> -	if (!pool)
> +	dma_pool->pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
> +	if (!dma_pool->pool)
>  		return NULL;
>  
> -	gen_pool_set_algo(pool, gen_pool_first_fit_order_align, NULL);
> +	gen_pool_set_algo(dma_pool->pool, gen_pool_first_fit_order_align, NULL);
> +
> +	/* if platform is using memory encryption atomic pools are by default decrypted. */
> +	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> +		dma_pool->unencrypted = true;
> +	else
> +		dma_pool->unencrypted = false;
>  
> -	ret = atomic_pool_expand(pool, pool_size, gfp);
> +	ret = atomic_pool_expand(dma_pool, pool_size, gfp);
>  	if (ret) {
> -		gen_pool_destroy(pool);
> +		gen_pool_destroy(dma_pool->pool);
> +		dma_pool->pool = NULL;
>  		pr_err("DMA: failed to allocate %zu KiB %pGg pool for atomic allocation\n",
>  		       pool_size >> 10, &gfp);
>  		return NULL;
>  	}
>  
>  	pr_info("DMA: preallocated %zu KiB %pGg pool for atomic allocations\n",
> -		gen_pool_size(pool) >> 10, &gfp);
> -	return pool;
> +		gen_pool_size(dma_pool->pool) >> 10, &gfp);
> +	return dma_pool;
>  }
>  
>  #ifdef CONFIG_ZONE_DMA32
> @@ -207,21 +224,22 @@ static int __init dma_atomic_pool_init(void)
>  
>  	/* All memory might be in the DMA zone(s) to begin with */
>  	if (has_managed_zone(ZONE_NORMAL)) {
> -		atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
> -						    GFP_KERNEL);
> -		if (!atomic_pool_kernel)
> +		__dma_atomic_pool_init(&atomic_pool_kernel, atomic_pool_size, GFP_KERNEL);
> +		if (!atomic_pool_kernel.pool)
>  			ret = -ENOMEM;
>  	}
> +
>  	if (has_managed_dma()) {
> -		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
> -						GFP_KERNEL | GFP_DMA);
> -		if (!atomic_pool_dma)
> +		__dma_atomic_pool_init(&atomic_pool_dma, atomic_pool_size,
> +				       GFP_KERNEL | GFP_DMA);
> +		if (!atomic_pool_dma.pool)
>  			ret = -ENOMEM;
>  	}
> +
>  	if (has_managed_dma32) {
> -		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
> -						GFP_KERNEL | GFP_DMA32);
> -		if (!atomic_pool_dma32)
> +		__dma_atomic_pool_init(&atomic_pool_dma32, atomic_pool_size,
> +				       GFP_KERNEL | GFP_DMA32);
> +		if (!atomic_pool_dma32.pool)
>  			ret = -ENOMEM;
>  	}
>  
> @@ -230,19 +248,44 @@ static int __init dma_atomic_pool_init(void)
>  }
>  postcore_initcall(dma_atomic_pool_init);
>  
> -static inline struct gen_pool *dma_guess_pool(struct gen_pool *prev, gfp_t gfp)
> +static inline struct dma_gen_pool *__dma_guess_pool(struct dma_gen_pool *first,
> +		struct dma_gen_pool *second, struct dma_gen_pool *third)
>  {
> -	if (prev == NULL) {
> +	if (first->pool)
> +		return first;
> +	if (second && second->pool)
> +		return second;
> +	if (third && third->pool)
> +		return third;
> +	return NULL;
> +}
> +
> +static inline struct dma_gen_pool *dma_guess_pool(struct dma_gen_pool *prev,
> +		gfp_t gfp)
> +{
> +	if (!prev) {
>  		if (gfp & GFP_DMA)
> -			return atomic_pool_dma ?: atomic_pool_dma32 ?: atomic_pool_kernel;
> +			return __dma_guess_pool(&atomic_pool_dma,
> +						&atomic_pool_dma32,
> +						&atomic_pool_kernel);
> +
>  		if (gfp & GFP_DMA32)
> -			return atomic_pool_dma32 ?: atomic_pool_dma ?: atomic_pool_kernel;
> -		return atomic_pool_kernel ?: atomic_pool_dma32 ?: atomic_pool_dma;
> +			return __dma_guess_pool(&atomic_pool_dma32,
> +						&atomic_pool_dma,
> +						&atomic_pool_kernel);
> +
> +		return __dma_guess_pool(&atomic_pool_kernel,
> +					&atomic_pool_dma32,
> +					&atomic_pool_dma);
>  	}
> -	if (prev == atomic_pool_kernel)
> -		return atomic_pool_dma32 ? atomic_pool_dma32 : atomic_pool_dma;
> -	if (prev == atomic_pool_dma32)
> -		return atomic_pool_dma;
> +
> +	if (prev == &atomic_pool_kernel)
> +		return __dma_guess_pool(&atomic_pool_dma32,
> +					&atomic_pool_dma, NULL);
> +
> +	if (prev == &atomic_pool_dma32)
> +		return __dma_guess_pool(&atomic_pool_dma, NULL, NULL);
> +
>  	return NULL;
>  }
>  
> @@ -272,16 +315,20 @@ static struct page *__dma_alloc_from_pool(struct device *dev, size_t size,
>  }
>  
>  struct page *dma_alloc_from_pool(struct device *dev, size_t size,
> -		void **cpu_addr, gfp_t gfp,
> +		void **cpu_addr, gfp_t gfp, unsigned long attrs,
>  		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
>  {
> -	struct gen_pool *pool = NULL;
> +	struct dma_gen_pool *dma_pool = NULL;
>  	struct page *page;
>  	bool pool_found = false;
>  
> -	while ((pool = dma_guess_pool(pool, gfp))) {
> +	while ((dma_pool = dma_guess_pool(dma_pool, gfp))) {
> +
> +		if (dma_pool->unencrypted != !!(attrs & DMA_ATTR_CC_SHARED))
> +			continue;
> +
>  		pool_found = true;
> -		page = __dma_alloc_from_pool(dev, size, pool, cpu_addr,
> +		page = __dma_alloc_from_pool(dev, size, dma_pool->pool, cpu_addr,
>  					     phys_addr_ok);
>  		if (page)
>  			return page;
> @@ -296,12 +343,14 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
>  
>  bool dma_free_from_pool(struct device *dev, void *start, size_t size)
>  {
> -	struct gen_pool *pool = NULL;
> +	struct dma_gen_pool *dma_pool = NULL;
> +
> +	while ((dma_pool = dma_guess_pool(dma_pool, 0))) {
>  
> -	while ((pool = dma_guess_pool(pool, 0))) {
> -		if (!gen_pool_has_addr(pool, (unsigned long)start, size))
> +		if (!gen_pool_has_addr(dma_pool->pool, (unsigned long)start, size))
>  			continue;
> -		gen_pool_free(pool, (unsigned long)start, size);
> +
> +		gen_pool_free(dma_pool->pool, (unsigned long)start, size);
>  		return true;
>  	}
>  
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index ac03a6856c2e..be4d418d92ac 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -612,6 +612,7 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
>  		u64 phys_limit, gfp_t gfp)
>  {
>  	struct page *page;
> +	unsigned long attrs = 0;
>  
>  	/*
>  	 * Allocate from the atomic pools if memory is encrypted and
> @@ -623,8 +624,12 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
>  		if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
>  			return NULL;
>  
> +		/* swiotlb considered decrypted by default */
> +		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> +			attrs = DMA_ATTR_CC_SHARED;
> +
>  		return dma_alloc_from_pool(dev, bytes, &vaddr, gfp,
> -					   dma_coherent_ok);
> +					   attrs, dma_coherent_ok);
>  	}
>  
>  	gfp &= ~GFP_ZONEMASK;


