Return-Path: <linuxppc-dev+bounces-22331-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3416CCD8CA4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 13:12:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZTpt5DdTz2ySf;
	Tue, 09 Jun 2026 23:12:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781010758;
	cv=none; b=a2/atSULTbLTSXZLyh07PLaTvoDWi/+UNMQPhMpQjbngF70Jmqns6F6LsgBQb+5yBsHWk7OhpmItwteg/sjoKcs7oDhNQF3eCgKMX8C+0nALoPqLQNq79vOqMT1WlGZpyu5khb40RKgFPEKHAwEyfcT6yXcOl2DBdn88gQc/zZrW9k/JZ3O3ZL5mUtunFV7+p25SZPDkIWQna7jcqEHXxbfp0lWaKhQ61rV47hARqvsRpUgu+QlfkuVAgbH8XzOjmWBt4u61n8SFEIbK476YVdXG2/dA7XXbFpkiZqaEaK/OAP9TaMnkxUyYxX4+bB0SNySv8VHqKmO8KDpETZyU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781010758; c=relaxed/relaxed;
	bh=jOb0YWdrCyqRf70PqWxcCcSyY2RJrYltX6EkSx4+w3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZVVAr9e7HPMCxWs9fkFHSi/OeOxaCfXYelqPEWpYnmYqFrmhG1OalUsXvRp+v9zwzlWRjAiPBRV7DpR9nhUGxd+ALhENopNuek/IKuxk5Oigrvacjv8nlKl942iMHHPG9bkll8CAXfPgEU+tXlBrSSBY0fFcEZMustMzSax4TZYQHO5qLejA6UOXGAsPiEZcZoNfP86iKqkT7qPPGrgUu4eKeHhgR4pbUQ2pOOLM6tsVxeaxTAq+iFmpaxmnBcnGYDVpRVuY9ymoEMjoOsZgzAobXbvDv2FC8mVlcdhqRt0FTHP6b4exUIrYz1Lrtd1WdR0+68xzdiGdnPIhR0UKqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=P6rY82lB; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=P6rY82lB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZTps2DJNz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 23:12:36 +1000 (AEST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-490b8adf7efso3709295e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 06:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781010754; x=1781615554; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOb0YWdrCyqRf70PqWxcCcSyY2RJrYltX6EkSx4+w3M=;
        b=P6rY82lBbwh3hYUGuhpnDs+J6qVOl0FPNER7Ng/glNzAzyOgKMOtPIfAqs1Gv5xhW4
         +CeEj4+rBoocOxjKKdqFU3MsEZzgjq98rN4s19hhB9r1KIKaSEONzcgS9SpfLgPfaQOi
         YmWXWktXLq/w77PFEiGwScwTukv6x9vBWnWxmydNe2RXwtxrUXIldFtRmXWoaKsKXHK7
         3ai0PWbzp0aII7mQkpwjKlJk04t7D9ZLg2ITPCkxomgIvjsnzkwk2myqZZaX928baxO/
         6kYPFYtHs8TytCojJbEMQSdtYPo60H0jXhcQDelZEielVhvU+O3nyUz+FooXlXZr4MR1
         z/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781010754; x=1781615554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jOb0YWdrCyqRf70PqWxcCcSyY2RJrYltX6EkSx4+w3M=;
        b=QxOgp+vHiS3GzGk/iilcw/A9djRXY3gWpUg/HFrxWxSkEisflIIPcSpynucPRSr2HL
         RL4pRN9yHd1xu/XEOm5q218FQpghnNEB+7H61rEYFxXH8LPaZGYEzWkXYroicIZrr351
         1RBuiNtIivPr9LR6xMGlKEqmaLdRScoiB9ydtvWUCaT1t/JD36f6XCfDsL6JtVdJGm/l
         FnMzWLvCOd98SIxVgB6q+ta21xTI+lhWyIgEL3vNLwVv5oirNiApA2ThsVugGb+u5oYC
         btrSfR3RY0xDaMDGa2HlG3d8iTQSsB4TaI7Djs9BjLhiL9Spgfp+06sxd2jWbIZoRICx
         btrQ==
X-Forwarded-Encrypted: i=1; AFNElJ+qqwoB3uCNffPjkMet8vhi35UDcAPa9NWY+1e8rKDxD3grb4Nr51gqf4YFlfv0Q2e54sPrAy3H3Bw2Z+w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxbm7yYw0UsKMwwJvlRJJTYqnarJS/Q8dwt41w8FGbhaN5PxZNH
	kdmTA2kNZr1fTQ0TBhGTyaP2JMXFCv/EJIIPYAzPu5yE0EiSsBzu//cDnLh5qsNJYtY=
X-Gm-Gg: Acq92OFoV31G/vPOHrY36SmmEbf2PkIYi8CBBsZYZ+a2ScYlZCnCMoHyXBm6roIxYDR
	P3vZ+QxQBD+Deq4qZw8DHUXbmgaKoFOly1qortjYSvz8rnr6xK1dWZDVtj/IqLRSCAR9JnYh0q4
	SkLQvV5Yc0fbxR8gYTlN7DQgB4ZmQVvpoDCo/0M3N6x1pC4D5GUOQ4r0cLl1BmxKm2YcOrJ3qNQ
	gSFF/u8wTV3EVUU1DSQm9hnWpbP0EqWvscEqLvgcI6hbuNmP56dQKnBum1vTRAzbMO07pigIJNY
	aQwVDXZXQzD7nT0xsRYBd+W47d8yTh6nXbTAmJzcyoKatL+ye5XeiERGkGntSwCY2FaqLR3FqGC
	1nQEAu8fKEYrOq9dhwBN4D9YV50iI7UbklsHa3en/zDpylkexwEE4UQwDUojcaS45oRejRm6uGr
	n5gOOH2QPfgzvBtZ2GUX9zZrk=
X-Received: by 2002:a05:600c:8b65:b0:490:b4d4:5c16 with SMTP id 5b1f17b1804b1-490d72759f0mr16962775e9.8.1781010753634;
        Tue, 09 Jun 2026 06:12:33 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm111677469f8f.29.2026.06.09.06.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:12:26 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:12:22 +0200
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
 <svens@linux.ibm.com>, x86@kernel.org, stable@vger.kernel.org, Michael
 Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 14/20] dma-direct: return struct page from
 dma_direct_alloc_from_pool()
Message-ID: <20260609151222.476a5521@mordecai>
In-Reply-To: <20260604083959.1265923-15-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-15-aneesh.kumar@kernel.org>
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

On Thu,  4 Jun 2026 14:09:53 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

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

While I totally agree with the reasoning and the fix, it's interesting
that this bug has been apparently present in the kernel for 5+ years
without anybody hitting nasty memory corruption bugs.

How can it be? Is the buggy code path never actually used in practice?
Does it hint at a missed opportunity to simplify the code?

Anyway, these these thoughts are intended for a possible future
cleanup. For now, let's apply the fix as is, of course.

Petr T

> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/direct.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4e446aa4130e..e0ab9ff3f1d6 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -157,24 +157,24 @@ static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
>  	return !gfpflags_allow_blocking(gfp) && !is_swiotlb_for_alloc(dev);
>  }
>  
> -static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> +static struct page *dma_direct_alloc_from_pool(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, void **cpu_addr, gfp_t gfp,
> +		unsigned long attrs)
>  {
>  	struct page *page;
>  	u64 phys_limit;
> -	void *ret;
>  
>  	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_COHERENT_POOL)))
>  		return NULL;
>  
>  	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
> -	page = dma_alloc_from_pool(dev, size, &ret, gfp, attrs,
> +	page = dma_alloc_from_pool(dev, size, cpu_addr, gfp, attrs,
>  				   dma_coherent_ok);
>  	if (!page)
>  		return NULL;
>  	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
>  					 !!(attrs & DMA_ATTR_CC_SHARED));
> -	return ret;
> +	return page;
>  }
>  
>  static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
> @@ -270,9 +270,12 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	 * the atomic pools instead if we aren't allowed block.
>  	 */
>  	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
> -	    dma_direct_use_pool(dev, gfp))
> -		return dma_direct_alloc_from_pool(dev, size, dma_handle,
> -						  gfp, attrs);
> +	    dma_direct_use_pool(dev, gfp)) {
> +		page = dma_direct_alloc_from_pool(dev, size,
> +					dma_handle, &cpu_addr,
> +					gfp, attrs);
> +		return page ? cpu_addr : NULL;
> +	}
>  
>  	if (is_swiotlb_for_alloc(dev)) {
>  		page = dma_direct_alloc_swiotlb(dev, size, attrs);
> @@ -445,7 +448,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  
>  	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
>  		return dma_direct_alloc_from_pool(dev, size, dma_handle,
> -						  gfp, attrs);
> +						  &cpu_addr, gfp, attrs);
>  
>  	if (is_swiotlb_for_alloc(dev)) {
>  		page = dma_direct_alloc_swiotlb(dev, size, attrs);


