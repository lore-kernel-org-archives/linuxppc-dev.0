Return-Path: <linuxppc-dev+bounces-22426-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D62ACD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 16:42:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbBPz3mWXz2yv2;
	Thu, 11 Jun 2026 02:41:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::735"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781109719;
	cv=none; b=Fvz2/ox1yxeuwjFIvb5TiOco0Y0Npj9QmspyTixETGahWdapllmsV1Myx+vi0+f8c12kAOpkXZzIQZH9c94jybik+zqQRCuQb8wnvoqck7+Y12kN8jBY/FpSmbT7pddnReAoctN3XikJYwc0EG6DfcBiFgiuBrGS+qw7/e5gsPxzm7pH81PrKujkrk+DbfSRO7t/9PU1DIp9yVHA499V6G66sGT3DX1y6diQKGW5JCh/ICYW9am6AjHa6K8yT9/+3zbNtr7H8tMB0I8iqOnKc/c7zCGXbY+B5lJD7KlvmYKQ+WP3bZzzAivoPTAyOHXSexpyLdeXzPuZERZOo6qyvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781109719; c=relaxed/relaxed;
	bh=DeYS8psnLhx+0nTbu07Q/N5cf93jt28LjVA9fcxz2cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7vrsN1+vPMNjEFwL7iRND5WfG959uql7cSVoGaNE5u/CeFVtGYuhVVehL6MDIN8g35CmEmf0BsMu7d7D7IUHqs/gZCPgZORWV3SXgFT4PoXr5maO1oUOLDYlHzP1ltquWrughE8HgpFRwmvV5AjBCfoOPaQdwblKmJlIHGa9GSE/ME6tvxS1zj/QoVsj2X0odV/p/wm1L1W8ekDvlbBNNK4nsIgS1JVgNfaxjAy1yUbpMpp4ohE99khnC1tJjchZhW2KCsrA69Pb5gxe3XRr7ivBYZHXq8hqg7tPLiIFAy81q8D7Y1+kzARxvqBdVXotQ+to8W8H3Of620gZc+dTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=gUF8luCI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::735; helo=mail-qk1-x735.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=gUF8luCI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::735; helo=mail-qk1-x735.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbBPx5s9Sz2ysW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 02:41:57 +1000 (AEST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-91587626ae1so785793085a.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781109715; x=1781714515; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DeYS8psnLhx+0nTbu07Q/N5cf93jt28LjVA9fcxz2cA=;
        b=gUF8luCIttfc5v5mIhLJzwNYNxslKmqWw7GLmFKXgOz72u+0aIYKmB8ld9JR9ama9G
         SSehF9wjPrf8Vt60rmsBkK0EJ1OEm6WWNFVzOtQjc9rc2cFO5bNr9S3RLXZVJ15J1lrw
         CVH3sX0j0yDaW6j2fQtqNhr+v5M0r7m2WXSVTE97fj+vSEtsPYB5+rpIpCZMp/3CWW10
         q0q34TYuwOspwjUn1cVCf5wBHe3dsPiWYh9w/tMyRkIWX8kqxD0++1SaUfV/LjiThPUv
         njyOko7QC6wgIp5AdtJCPu1fZZXZrsLkAn+RTuB9otG76Zo8ZJjvjWfsO1usKjc9hsBc
         +iJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781109715; x=1781714515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeYS8psnLhx+0nTbu07Q/N5cf93jt28LjVA9fcxz2cA=;
        b=MyLXQgYPAiSl/wJ0cvApLzumtLGNxV1bQOSYVioLue62s1wOm1l3tk2sp5GU1k09YK
         yaV61dQDevoQwO2nrDFrY9m1CpWEJIN17/AzqM0aE70g02IWXKGGCTzsI9SLosiR82ts
         4pXMif23c+sbSAES1awi9L2/y0fW5R2/Sr5OWX4YAIVzCOM1kOuueBhU9a6jVAtRmZmY
         LwuN8g3Cg+3ynOPfaiM6lrJIP8s+OmdCUBkCcJUvSxBYX3YH0simMM7yFRdu89d+eql9
         M2kxk3E6QGxnB0gOm3GWoqbuA5fPWZ0qrWiMKx4sRgvVmKH6PRWtswoSTKFtpZ49yJ9F
         2pXA==
X-Forwarded-Encrypted: i=1; AFNElJ9eaRXxSpqwuJE5h+1iNmsQ0HKEVk4xlNTEXoURETTzxLUmWoQ2Zz2KRBdpvUdJqFPlBQ5usJHMWLew5no=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzjknVIwOgOzBtND7kf35AbhduKaFdNzIKe2fIrw+DcEeL4Gj/u
	GYg7oul1Iol693qsyIWXJWlZIQnHj+fe0gZRtObos5AO35UXxTHhm+7XsUuWZkN4SAs=
X-Gm-Gg: Acq92OEoc3Kl3TEEuOqu9JcVKauEGN9SC8ZHuYw3tiOsS8opvjv8BjCX4V9T3qnpj8f
	OKVAUqfocOZwAmO++vQ0poLs/OYk8pefbQlHrgOYeJMtBYYPXe/t0gu0QCPRroFlI775S0vOv3I
	C3GegDv6pmHTkhN7Izapzm0kIMaoZ38DkK3Ci56OPInmsOsB0pzPPb3CKN4yQHFVBkSzVWMxJia
	U1bMEG0BcvSlSJCXyUN2RotA+tNhTeOZokC29OrP8/6T8rEJ1J1xnUPzgw1yPR60RD/NT00BFCb
	ghSmstVeKkob84TxPhiwLBzdNTaiHs83SXiWD32Hm8w1mEiSBYlFuTBfsyAhS4vvKcIMKIlb+e5
	wJCPsGBh+4UbUkMzfEqg7fgsc0PN2HAX8bZdRp40XL+urKWnXpg4WCiMNmAIqAIrQjUuG9pogOV
	ROKOzWlTJPQIuvuTQwcZD55ZEbN6Mnm3Gq/6UgbH8plzA6Thk2hL0DNOk2s+K7eltiAuGp2gjWM
	36cx+UndFw3qC4M
X-Received: by 2002:a05:620a:a414:20b0:914:afc1:c66d with SMTP id af79cd13be357-915a9c75c96mr3039706285a.11.1781109715064;
        Wed, 10 Jun 2026 09:41:55 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a22dbbesm2438570085a.13.2026.06.10.09.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 09:41:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wXM01-000000048i4-3DtT;
	Wed, 10 Jun 2026 13:41:53 -0300
Date: Wed, 10 Jun 2026 13:41:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
Message-ID: <20260610164153.GQ2764304@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-5-aneesh.kumar@kernel.org>
 <20260609143242.GK2764304@ziepe.ca>
 <yq5afr2uzum9.fsf@kernel.org>
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
In-Reply-To: <yq5afr2uzum9.fsf@kernel.org>

On Wed, Jun 10, 2026 at 01:37:26PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Thu, Jun 04, 2026 at 02:09:43PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >>  struct page *dma_alloc_from_pool(struct device *dev, size_t size,
> >> -		void **cpu_addr, gfp_t gfp,
> >> +		void **cpu_addr, gfp_t gfp, unsigned long attrs,
> >>  		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
> >>  {
> >> -	struct gen_pool *pool = NULL;
> >> +	struct dma_gen_pool *dma_pool = NULL;
> >>  	struct page *page;
> >>  	bool pool_found = false;
> >>  
> >> -	while ((pool = dma_guess_pool(pool, gfp))) {
> >> +	while ((dma_pool = dma_guess_pool(dma_pool, gfp))) {
> >> +
> >> +		if (dma_pool->unencrypted != !!(attrs & DMA_ATTR_CC_SHARED))
> >> +			continue;
> >
> > I don't think you should be overloading DMA_ATTR_CC_SHARED like this.
> >
> > 	/*
> > 	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
> > 	 * attribute. The direct allocator uses it internally after it has
> > 	 * decided that the backing pages must be shared/decrypted, so the
> > 	 * rest of the allocation path can consistently select DMA addresses,
> > 	 * choose compatible pools and restore encryption on free.
> > 	 */
> > 	if (attrs & DMA_ATTR_CC_SHARED)
> > 		return NULL;
> >
> > 	if (force_dma_unencrypted(dev)) {
> > 		attrs |= DMA_ATTR_CC_SHARED;
> > 		mark_mem_decrypt = true;
> > 	}
> >
> > It is fine to have a bit inside the attrs that is only used by the
> > internal logic, but it needs to have a clearer name
> > __DMA_ATTR_REQUIRE_CC_SHARED perhaps.
> >
> 
> Are you suggesting adding another attribute in addition to
> DMA_ATTR_CC_SHARED?
> 
> Is the idea that __DMA_ATTR_REQUIRE_CC_SHARED would be used in the
> allocation path to request a CC_SHARED allocation, while
> DMA_ATTR_CC_SHARED would be used in the mapping path to describe the
> attribute of the address?

Yeah, it is a thought at least

Maybe a comment is good enough.

I just find it hard to follow when we have this dual usage. Like the
code above for dma_pool->unencrypted is completely wrong if it is an
"attribute of an address". Easy to cut & paste that into the wrong
context.

Especially if you move things up higher.. having the alloc set both
CC_SHARED and REQUIRE_CC_SHARED or maybe ALLOC_CC_SHARED would make it
clearer that the alloc code lives under that callchain

Jason

