Return-Path: <linuxppc-dev+bounces-24947-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAF5C53219
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 14:31:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8dFV4Fd1z2yjR;
	Wed, 29 Jul 2026 00:31:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785249102;
	cv=none; b=dMH6kPvQL6g4ktiGZC1btBVtzhZq2K8xTRCMoFWg60R9edApo+wKkAyeNj/dx/YDR0HodFqHRMRwT9vFraQPw7nisRofNUg3vtaPfpAJVqWv+8CK4Jj7q3HoDjRCxr6hUi+IrBCiGChaLv+u53WILN7aZy85mlEnP2s985Nul1QO4PywJo+AKyMybW7E0+i1L+sDMU+M37kjOgTNUBRmdJOG4oYmLoZkMiZ5FhmV34Rhu7ioid5HTmfL0HfoGDqfvY/CcfKsU2JKnmfz6+m/tpQ7Vz/LZ3v7S/BXJMWJZFTeMe0J/nSCgWlO06OTRb43AE3AB3Hhd6J72hCUjlqubw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785249102; c=relaxed/relaxed;
	bh=ZXqe2wlo2yiPOh072n71Jij5i60MC3cIjM/IN/S3eis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTbCirUPkl76V9YsAd6IN7jWC+ENmAptiy4qn+HSDH0DE6klQCrcFSuRN2ZBzi925VXkJKfo0NEfaNoQbU6122w2DVGmzq4YmK9alPv7Csh5fydUitO5pArFlREU8HjLdXeZASzEUXkR0y4yMbO4qz2hoOKe0EPZ/xZg1KKgYx9BC/7wtXWxlYhqSxV5ZFxZDib+4xgWx+Stp5grmpKNEGknvz7LGh7agblqNsu3kW4AoE4UGuK4FpyNN1+1Oa6UI8++zXddm22J/bs1XVvs0tdYKdcEZIhqfJ9LctRhKfBKpZx9chhy886Ojowoe+0dHoF518IPW4JZDIntuh/pkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZfjNg0BO; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZfjNg0BO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8dFT3wDmz2yjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 00:31:41 +1000 (AEST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-495509b08ebso50145e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 07:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785249098; x=1785853898; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZXqe2wlo2yiPOh072n71Jij5i60MC3cIjM/IN/S3eis=;
        b=ZfjNg0BOyllu5rZkCZngo5D45qrWxoI1cvWou30atvCfyeZlEI/176qS5ZGGTsacVB
         IIafczOst4piv44xhV992TBeeY2JFyGCO5xnyHrx7oE7RV8Modw/ZJ8lakAzXsJwEsgT
         NxvqRwoLozxtKuCKdxmWxIKgGnCEi6LpWFsQDCEMCb2ibHufXG7BHQKsdC2zMeDT8Lmd
         7piVzdjTunN4nOm4i7fYQhH7ZdQt8pYRKQuLRoMhhq183UXv1Ml9wtKPdPQ7xWClhHVD
         HVsVJ+pCyUa79ajF/vd4zg2Pu4S8KrelxYd8GSSf0jvnlu1vchl3z/CUn9d1xMdESLFR
         zlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785249098; x=1785853898;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZXqe2wlo2yiPOh072n71Jij5i60MC3cIjM/IN/S3eis=;
        b=QKqBZzc5xkkEqch8x0GwuEcgI9o3m0oxyvlQMGaQsiCYqvtAbxpWX30scfP81F/Rwa
         WJleYtMoMS4Eg2VGaRFyHf3dC0MvcSnsUVkeLqMeciFCl8XLoo3wzmWe9YX3zyJtqtSn
         Zwou1cOYWcCPgpz+kxqGaKCIESwlP8P8tdmRWxMXpXZ01otKVKG8G0+MLET5A0yv5kzL
         dAo/zo90PlgpTLKLlUs/GWae+6Tzqlbk8vN8xNO3rXY9V0gaCP+UpAYTRVrthGdMTH6K
         gBOlQWgluyoZr5RF25Trfdlp5dEhgYXU3qtIFgOGQKA/awhLhUMbjSa1Cl2I+C2hq4Yp
         C+5g==
X-Forwarded-Encrypted: i=1; AHgh+Ro/G34+vYBrxmIDSzIvt8+gHEzhcxgCqtVor3ezT+WveMreVDWre3gZyITDaKJ5yZpd7Qtwv72oPoz+BJs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzziEzZKRfcEcWChvnmMiOg3wQ1Y3vVRnBEqFGr65Tr7B2TQiXZ
	Ouny1e1srmXwrvO/b1O8FGR4fDsBTmOPv3vcgnKp4+FeBtZVvHhZCTGbi5wdC08x6Q==
X-Gm-Gg: AR+sD10+Wi2j6KiCQLncaw/bgk/oJ2T58SJTEJv9poAElq8ttee8vyW6Z5FOrl+6Kmz
	yqPKrfQGD9+Y9oRPN7X+l/fXSg+XdKmNt2Rh0SDd9cRsVAzdChwlyonRczFPz0chyONVczuGD1W
	3gIVPHp5Ek27sbXae2LSWDkGabhwMHa9oNxYMOUNz6NhQqERE37bxVNroLH+Mre15AUOGvfOlyf
	AzE4Yz2h3Y5mAuVRexelOwhS/rS4hlAJT/XF0DlOSbC9lGlmGuGaAxdGYi8K8PsciK/tljKAD67
	8nr/TK8kDE1lEILWfg9fN2P60j+MdWIh5XxwU5YFWvMKejZRfThjFpP7VYm4EA/lcjx3Wr36VqV
	9qEbLdDJm5bm2RWS0C4TSR7Tnj7UReJ6gK/s+7nktzUwYkoRqfYL6sa3pXoZ0tEaukHwwv4org2
	jxBxdutvS7bUdPA3YeIIkGpcACKaM0wnrRBCGMwpmhFwE=
X-Received: by 2002:a05:600d:6405:20b0:48a:5618:b4d4 with SMTP id 5b1f17b1804b1-496b53e888dmr48025e9.1.1785249097771;
        Tue, 28 Jul 2026 07:31:37 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6ef25sm54228115f8f.36.2026.07.28.07.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:31:36 -0700 (PDT)
Date: Tue, 28 Jul 2026 14:31:30 +0000
From: Mostafa Saleh <smostafa@google.com>
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
	Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 19/23] dma-direct: select DMA address encoding from
 __DMA_ATTR_ALLOC_CC_SHARED
Message-ID: <ami9QgMEfCcU0ToH@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-20-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260717180442.110954-20-aneesh.kumar@kernel.org>

On Fri, Jul 17, 2026 at 11:34:37PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Make the dma-direct helpers derive the DMA address encoding from
> __DMA_ATTR_ALLOC_CC_SHARED instead of implicitly relying on
> force_dma_unencrypted() inside phys_to_dma_direct()
> 
> Pass an explicit unencrypted/decrypted state into phys_to_dma_direct(),
> make the alloc paths return DMA addresses that match the requested buffer
> encryption state. Also only call dma_set_decrypted() when
> __DMA_ATTR_ALLOC_CC_SHARED is actually set.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  kernel/dma/direct.c | 43 ++++++++++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index f7f064323bd9..eb0ce0787885 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -26,11 +26,11 @@
>  u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
>  
>  static inline dma_addr_t phys_to_dma_direct(struct device *dev,
> -		phys_addr_t phys)
> +		phys_addr_t phys, bool unencrypted)
>  {
> -	if (force_dma_unencrypted(dev))
> +	if (unencrypted)
>  		return phys_to_dma_unencrypted(dev, phys);
> -	return phys_to_dma(dev, phys);
> +	return phys_to_dma_encrypted(dev, phys);
>  }
>  
>  static inline struct page *dma_direct_to_page(struct device *dev,
> @@ -41,8 +41,9 @@ static inline struct page *dma_direct_to_page(struct device *dev,
>  
>  u64 dma_direct_get_required_mask(struct device *dev)
>  {
> +	bool require_decrypted = force_dma_unencrypted(dev);
>  	phys_addr_t phys = ((phys_addr_t)max_pfn << PAGE_SHIFT) - 1;
> -	u64 max_dma = phys_to_dma_direct(dev, phys);
> +	u64 max_dma = phys_to_dma_direct(dev, phys, require_decrypted);
>  
>  	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
>  }
> @@ -71,7 +72,8 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
>  
>  bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>  {
> -	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys);
> +	bool require_decrypted = force_dma_unencrypted(dev);
> +	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys, require_decrypted);
>  
>  	if (dma_addr == DMA_MAPPING_ERROR)
>  		return false;
> @@ -81,17 +83,18 @@ bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>  
>  static int dma_set_decrypted(struct device *dev, void *vaddr, size_t size)
>  {
> -	if (!force_dma_unencrypted(dev))
> -		return 0;
> -	return set_memory_decrypted((unsigned long)vaddr, PFN_UP(size));
> +	int ret;
> +
> +	ret = set_memory_decrypted((unsigned long)vaddr, PFN_UP(size));
> +	if (ret)
> +		pr_warn_ratelimited("leaking DMA memory that can't be decrypted\n");
> +	return ret;
>  }
>  
>  static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
>  {
>  	int ret;
>  
> -	if (!force_dma_unencrypted(dev))
> -		return 0;
>  	ret = set_memory_encrypted((unsigned long)vaddr, PFN_UP(size));
>  	if (ret)
>  		pr_warn_ratelimited("leaking DMA memory that can't be re-encrypted\n");
> @@ -171,7 +174,8 @@ static struct page *dma_direct_alloc_from_pool(struct device *dev, size_t size,
>  				   dma_coherent_ok);
>  	if (!page)
>  		return NULL;
> -	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> +	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
> +					 attrs & __DMA_ATTR_ALLOC_CC_SHARED);
>  	return page;
>  }
>  
> @@ -187,9 +191,11 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
>  	/* remove any dirty cache lines on the kernel alias */
>  	if (!PageHighMem(page))
>  		arch_dma_prep_coherent(page, size);
> -
> -	/* return the page pointer as the opaque cookie */
> -	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> +	/*
> +	 * return the page pointer as the opaque cookie.
> +	 * Never used for unencrypted allocation
> +	 */
> +	*dma_handle = phys_to_dma_encrypted(dev, page_to_phys(page));
>  	return page;
>  }
>  
> @@ -329,7 +335,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  		ret = uncached_cpu_addr;
>  	}
>  
> -	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> +	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
> +					 attrs & __DMA_ATTR_ALLOC_CC_SHARED);
>  	return ret;
>  
>  
> @@ -450,11 +457,13 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  		return NULL;
>  
>  	ret = page_address(page);
> -	if (dma_set_decrypted(dev, ret, size))
> +	if ((attrs & __DMA_ATTR_ALLOC_CC_SHARED) &&
> +	    dma_set_decrypted(dev, ret, size))
>  		goto out_leak_pages;
>  setup_page:
>  	memset(ret, 0, size);
> -	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> +	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
> +					 attrs & __DMA_ATTR_ALLOC_CC_SHARED);
>  	return page;
>  out_leak_pages:
>  	return NULL;
> -- 
> 2.43.0
> 

