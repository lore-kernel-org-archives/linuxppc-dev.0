Return-Path: <linuxppc-dev+bounces-22351-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA8FCD8CA4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 14:32:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZWbP2wmtz2ySf;
	Wed, 10 Jun 2026 00:32:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::731"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781015569;
	cv=none; b=RwJ4nezTkXOqCW/N9ZFmz27y/vhKFhY9mnxCZ84eyN2znEei3Un7//+19MMOpYrmHOIDiE5OcGPhdWy70/UQJPG2zWVSMSqEXmXVJMIAZF7NggijHwVcZuRQmIokmCMXqaqGZZ6XQIvc68QzlNLQmHD1Fb2EBBbOqRMfCWXH/wmU6sMU/jxtd3Jnzanbh2/Lf5P5GBzibanRsCwRIPMaS7CXEksyxzdPCrZkSV4t14jUYuWSfRI0SNwNK+IQNS35SyqUFIjlt+zsQ8pP+fDOUUzk2LfMBpIfRqHIg3eIkwePAb2beqxxLLaVDjJRKg86MKI+W5A953uaOBmD+rBQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781015569; c=relaxed/relaxed;
	bh=D9KAUhO8tYdZLzMRayCE9PmCg2//sOlzvRLMvdEyREI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwjuVclsKeyD03QFoFo0k6z6UqgvBnbgp6vW6qDdmK50DnQcID4TkcfO6tEjE6OhYwSTjgolSsZJp9pUgkxCb2AKM74zamA4jOlWbq5gPaRxyU1mN4tENNUoW5lif/egqIo67+WJTjq/zP4S1kctHkHxwdCEB2lO4HcGFJZhhIPQy+k8HDZ5cY5/VRk5VERrql09eDezCBscP4ev4Li5eqSY7k8QACq+3687a1AJSmvcG96SKSCy3/8I1WZoc8XtSGHFIdKXW6Oxz+mURJqvsZ+WF2BJ3R9E3jcBaZ83rhvV8MDJndN/cC2ORqBuauPapr1WRyL1FyYyDJmivct7bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=DO3oGBJ7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::731; helo=mail-qk1-x731.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=DO3oGBJ7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::731; helo=mail-qk1-x731.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZWbN1Npfz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 00:32:47 +1000 (AEST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-9157f7c1c0eso565058885a.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 07:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781015564; x=1781620364; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D9KAUhO8tYdZLzMRayCE9PmCg2//sOlzvRLMvdEyREI=;
        b=DO3oGBJ70+K8L7PnwpTPwR0hTf37yJzGNW1eubOPMJwtBfx5uQ1UCH3KeQmRT9SQ7s
         uG/EQGYXAQlE2GDvZNMKgMS+PdHZdix+GILAFOcmlJXLwnzOMF22dBclWTkM8Px7YZW0
         PPACUJZrcLGNJLFA/wOMK9JgZxQRpIE8bTgGDcufi19SW9jKR/4z9NpXelAXdRZ+Op4u
         5HmoyD+FRb5zQk0TACeBWIlPIrhi3adyoOnf3/DISzECam6G+MIG+xZFEaCx0QQ3lFSS
         GImlkarz9IZ7toNsYkv8RhQkyGVPupdZBG5MYjJorr/TX6hHTRBkgEfOiVhPalCe3GXv
         3nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015564; x=1781620364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9KAUhO8tYdZLzMRayCE9PmCg2//sOlzvRLMvdEyREI=;
        b=kEJ/ZkULlP4YcHbMbwpIwx13QA9c+LS9jJ0bX+FcF964GxyKz+ZCbaUBhzBvPDFv6f
         k0YlgU6rxqI20VipWdsDXrmA28IXIN5r8bTtmP+xFtsaQEaeNj10c62UyDW0jqH+uSq8
         tCBkRnLzD0LRovEMeMfuVAIigOxsdif+IDUcr5llAcTNfJG5EglTj+fWxsfLKz4IOYVp
         +LhPVXTH+c5cM69Q/F52mwuO5wC+TGNu7V+Blh2lS08AZ+Xb8pVyT1XSXUBtN41ZLNOR
         J/ogCtZk7rddpq8rHxkaKv83P1n4VKpnoEd1F0k09qyACkUZqfJ9cRD4v3TIdXMJQMNg
         kTbA==
X-Forwarded-Encrypted: i=1; AFNElJ+3QM31XwkuUAqNeMJqj4ApyyKCO1JxhMqdbm300ChmOm4GuldUzU1rww62DEGu4SedLM8TA891lDCXTtk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxiCZeLZYkldGqUKz5CXzH/F7EZnBaBTDtQzMMaqeIjpaW2ayaR
	akBjy7UMPJbSakO5tkn28ijTLT6EUpHOnj42L7btOuB2EpX1YhCS99+rzDQYFx/Ljz4=
X-Gm-Gg: Acq92OHnnCB7zde/RxRvCB7M9NyYdGsIszTs3AXBDqENmBIJ71+8KMnBG2jYgNd8NOU
	WeUtjJA16u0/1xRoTF+hVGcpG1fKWYx7Xe4v/8tJKWVXdpn+t9Fdijt/N1ZKaaHYIjhpZv8cVvh
	pWCzrCX2xkEW/NzNyh1VpWHeYYaBSySwoqZnF8H38eBCvCdu3wrmwl3eO0Y9qDHldYO2sgA9yL0
	ZLgj71jLo9g5nnj4+2EXEDnav3YVUuKLd1Ax4U6M15wLQBVsebvOxZlmHfXLShzSniPi1qZmHNo
	42/Y/qV6ZYWN7GHoumUwI9OVBDEcUK1p1eIYp+n/rUZgJEzt8my5hk0R2kiHSknI09WbZJQ6g4l
	HMGrj8gF4L/NNltaS1Rlf4gUzah4HjLr0etD7uBEEoElLu9vz7Z3SodvLsKzrMDic/CybMwfniv
	a2wC8AZn5ucazETxlUQ1ysgD++JWCSqM8cBKGxa0fx4Iq9PPG30XdoFjCF5qho/s5d+rkEbzDhw
	n5HrBxwIl1DE61I
X-Received: by 2002:a05:620a:c46:b0:915:9f28:6748 with SMTP id af79cd13be357-915a9cdcf02mr3443110085a.23.1781015564257;
        Tue, 09 Jun 2026 07:32:44 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00afafsm2106743685a.2.2026.06.09.07.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:32:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWxVS-0000000241b-3Vv0;
	Tue, 09 Jun 2026 11:32:42 -0300
Date: Tue, 9 Jun 2026 11:32:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
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
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 04/20] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260609143242.GK2764304@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-5-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260604083959.1265923-5-aneesh.kumar@kernel.org>

On Thu, Jun 04, 2026 at 02:09:43PM +0530, Aneesh Kumar K.V (Arm) wrote:
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

I don't think you should be overloading DMA_ATTR_CC_SHARED like this.

	/*
	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
	 * attribute. The direct allocator uses it internally after it has
	 * decided that the backing pages must be shared/decrypted, so the
	 * rest of the allocation path can consistently select DMA addresses,
	 * choose compatible pools and restore encryption on free.
	 */
	if (attrs & DMA_ATTR_CC_SHARED)
		return NULL;

	if (force_dma_unencrypted(dev)) {
		attrs |= DMA_ATTR_CC_SHARED;
		mark_mem_decrypt = true;
	}

It is fine to have a bit inside the attrs that is only used by the
internal logic, but it needs to have a clearer name
__DMA_ATTR_REQUIRE_CC_SHARED perhaps.

The sashiko note does look legit though:

	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
	    !gfpflags_allow_blocking(gfp) && !coherent) {
		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
					   gfp, attrs, NULL);
		if (!page)
			return NULL;

I don't see anything doing the force_dma_unencrypted test along this
callchain..

I guess it should be done one step up in dma_alloc_attrs() instead of
in dma_direct_alloc()?

Jason

