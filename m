Return-Path: <linuxppc-dev+bounces-24942-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3723EC54F4C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 14:24:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8d5S6qhdz2yj1;
	Wed, 29 Jul 2026 00:24:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785248684;
	cv=none; b=SOh0Ak8ZGURRYmRslrvm4a7OMJn/j5lzI0Vp0Fw3NxV6bhESsYCZu6RrRP+ob+/LWDv4AbBDolRQGJh01T4sIaf1gTPiM6m5VhhFX88WQ2sEotMT+ykgAIThcssGH587/meL+v0lTNOyaEeHBMFcnMPGYYzXWRLLkf7fDAozLW53higl5gMhbqEvzX3COF4HLRqVQRWSnc93Tt+qPhtJppLx2HxmHyWw3G+xIfhJfKRnVn9EIwSe+oT9HyPTApd8zTHLSCXD5EvmKQLx6guxRpvVraWDeV+HyLAU9iYUjBmKPME3jUgfjsGXTM0LEJtx3CyzqGrlwCsrLrOtEp8QPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785248684; c=relaxed/relaxed;
	bh=pLh0JMDAJYh72m8FtF6BfLrBflAoWAmkZ9Sv6YSjD4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQAfcwkT+1OGx8gp9C4psUMjOXygTaSL2U5E9pLdHgl3BM85u9t+WcHKBLZxKle7qybv5s/colY4ZvQtlou850ZxcAmYBJ9cKSR8ZngwwxhYpK0YjmQunLO69z2OMYJDL78e9IklFerKBLPsiK/YakVXGlngeWp41nLL7bJDeruD2k6rKWt3yjFZVsAB5rCAWDkhvs8wGqdHlLIP8VblySsAza9Nab8rMh4cSNKQ9tozMJspOnG+TMAxxAWOCUbPKjMSFHsEysnW/S2WDzRDE/9oh9FGWxxJGtsAZCkUi2KZfwt5GviYdOg1ByAfGEW6Zi133PKkbkT2RDTfvxarqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=clgLWrW6; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=clgLWrW6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8d5R6G4vz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 00:24:43 +1000 (AEST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so62035e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 07:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785248680; x=1785853480; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pLh0JMDAJYh72m8FtF6BfLrBflAoWAmkZ9Sv6YSjD4c=;
        b=clgLWrW6B3WbiRbkV2pJK+eAcldXx7L0s2U8pFQ/SLbr0oQDe+nloDK3pj5+4wi70e
         xyD4W8vJPrjwY41WqlICnEB3BhygbiqgBHacWajKNqJlsgml4jnE11expys2gukPtqqv
         kyG6XKRkJO5pGKEJn2gmLzQCTGJVwq7cPyhbwUnBLa/y0+Ns1bskn3QvuJl3Eo68JG4c
         lOYxbmehuXuXoIjrKqESvBZyvOYJjQ3xS3g/QcYA5NIaVmle2VTcsgJ++vIng6lXMgEe
         lVaBFPsXm6X5Ijlsy/q7iRvelYnAeex69rWwJUH5l9g5fiCtisq1/+uvgNOTYzwx0cX/
         Dkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785248680; x=1785853480;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pLh0JMDAJYh72m8FtF6BfLrBflAoWAmkZ9Sv6YSjD4c=;
        b=R7Q082llxgYlB65rN17DimhgEiblbpV3KxIKGG/fVlUWF+UeJuAAen5YKFvhk9YCRv
         C2zZIHgOHRZWYKZVYKYwVZAU3PHPiD5ZhZZF9yPDwKod31V0XG0/EeCKK2IPF4yKaip9
         iXwSeLO88OGHhsl/BpC35ZmzsXJB9/6mGcF/7mv5FRVeSIu5X9vXtAK1Yz/uabnchMce
         8WKR11g5ol7YAX0SfVxn/tGsJZciJiKNlj88eT3I3p39v+P+tW5QycMwIq4Lqk57cSDN
         OfOETfZrTnZcrKyzjpa0W3WECzdg0vAqD6gsxhXqlwBYNIReHeDfvL/Ldl7xDsZsc3j4
         hclA==
X-Forwarded-Encrypted: i=1; AHgh+RqHUCYsziBEUQnAMg2bkIho4fl5abEMXQ0UnR5FiXPMhKXkAmeDKx1APmLwqVrLUX2PLh3M4x7QMZJv+Jw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwpM/vXKAJoHvOqYoMK17CgQkat9sfRDu2XVnCJ5+SzNAp7STt6
	vDPCxfZ6HFjpbub2E/3IE00/S6fd97BRsDqOCNEBytpritZglzDHs8d8AlJ2ZTYJfA==
X-Gm-Gg: AR+sD10MvjSkM/fRp5MJJKZEFkOOH/SqyTTLkdK/J9oldo/h1rjmftcBHKtSYE6uTEC
	GDpBoscYUhSP6t6jDAN7ho083VXdw+nmEtklqj6cc/aXtE0+BfxqBYlpJasocjer+7vy+f30Ndp
	4yvUG4grxeAmp+6K+rxHAYH5f0eAH/iBSxAkYEdXrpU9zoEDm17uz3oyMNKom+hNIaUSGZfM5WK
	uAmZnsqo1FHdoKjtTSAlEPs04BEbaSjqBlHJ5Fao5QLLclcMboxITDWKl7KAK+PWTTasgcIg1ke
	ZFqf81NofYNqsSUhn6i5IVjv4raSp5mUG1VK7rav1Vy2+2AAs5H62yWwGJNcwcUpbZhPFV1d0sR
	nVeWwW9epFdwRBQ1IQ099qCY0ZD6VsoEHMF9QuXvZRYyDYB2a0l8MFI3OGutVq9LOdGhMrrNJYu
	tgAIfReyagonNdj/54MdfWnGmJZZbGt0UNedNgHzVNwFU=
X-Received: by 2002:a05:600c:35c2:b0:495:5515:3c00 with SMTP id 5b1f17b1804b1-496b53f7910mr71275e9.9.1785248679759;
        Tue, 28 Jul 2026 07:24:39 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c444304esm79447515e9.0.2026.07.28.07.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:24:39 -0700 (PDT)
Date: Tue, 28 Jul 2026 14:24:30 +0000
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
	stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v8 01/23] dma-direct: return struct page from
 dma_direct_alloc_from_pool()
Message-ID: <ami7nhBTXzAfqoVE@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-2-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260717180442.110954-2-aneesh.kumar@kernel.org>

On Fri, Jul 17, 2026 at 11:34:19PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Commit 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool
> helper") changed dma_direct_alloc_from_pool() to return the CPU address
> from dma_alloc_from_pool(). That fits dma_direct_alloc(), but
> dma_direct_alloc_pages() also uses the helper and expects a struct page *.
> 
> Fix this by making dma_direct_alloc_from_pool() return the struct page *
> again, and pass the CPU address back through an out-parameter for the
> dma_direct_alloc() caller.
> 
> Fixes: 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool helper")
> Cc: stable@vger.kernel.org
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  kernel/dma/direct.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index d8219efe3273..363d984d90e7 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -164,22 +164,21 @@ static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
>  	return !gfpflags_allow_blocking(gfp) && !is_swiotlb_for_alloc(dev);
>  }
>  
> -static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t gfp)
> +static struct page *dma_direct_alloc_from_pool(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, void **cpu_addr, gfp_t gfp)
>  {
>  	struct page *page;
>  	u64 phys_limit;
> -	void *ret;
>  
>  	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_COHERENT_POOL)))
>  		return NULL;
>  
>  	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
> -	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
> +	page = dma_alloc_from_pool(dev, size, cpu_addr, gfp, dma_coherent_ok);
>  	if (!page)
>  		return NULL;
>  	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> -	return ret;
> +	return page;
>  }
>  
>  static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
> @@ -247,8 +246,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	 * the atomic pools instead if we aren't allowed block.
>  	 */
>  	if ((remap || force_dma_unencrypted(dev)) &&
> -	    dma_direct_use_pool(dev, gfp))
> -		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
> +	    dma_direct_use_pool(dev, gfp)) {
> +		page = dma_direct_alloc_from_pool(dev, size, dma_handle,
> +						  &ret, gfp);
> +		return page ? ret : NULL;
> +	}
>  
>  	/* we always manually zero the memory once we are done */
>  	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
> @@ -357,7 +359,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  	void *ret;
>  
>  	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
> -		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
> +		return dma_direct_alloc_from_pool(dev, size, dma_handle, &ret, gfp);
>  
>  	page = __dma_direct_alloc_pages(dev, size, gfp, false);
>  	if (!page)
> -- 
> 2.43.0
> 

