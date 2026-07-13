Return-Path: <linuxppc-dev+bounces-24142-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA27C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 19:39:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzXnv1k9pz2xWY;
	Tue, 14 Jul 2026 05:39:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f30"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783971587;
	cv=none; b=ck2bccqQd/6y4uvLNOLrbn8dTPWyhi+fXtPVMoESDrYoiUlmE0OLxH3WgpvrnwNwZDria1XGh1km807cDt2HvCnwuf4m+QbpWrtpYPvkjiqoK7Qw2R/+xfQVGB9n1uHTVaFCsgtwyNrX+iSTQcpNZpqEhH0IywqPxflksuod6l+YErOMb0AovgGQpokO5hsTRcx0617c4TJmMA9D+LOrHfIvJHthQnTWzXplaDCxosY36TorzmlxfLaa/z4XW+Qa2V0E3GZ3vw+/4BU44BfAHLtWqVo6JVqMHDBFBIl03huI524kdn8kr6c4pLrFxFFKZc0Osk8onxitHYIC83a6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783971587; c=relaxed/relaxed;
	bh=1JWJRfd6QdZf7qlUjcbW5D2kIZlwkQZ3KWr7+m1ApiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlRvwunOseohzhFhOuzmc4NkBJgtO9g7Pl/e43AJF4Q198cPJFkKDV+RWMJ8CrRvoWbg8OnYfHawPFcG9h3BPZFkMAIZOr01e6UmFfAqrLV43yt+gMMWK6WgibvsWMbJhl+qWmjSGhQkeJHzuMJ0nosc4Hq5aFfa/5SolnZzRrDzjwTrscuxSEPuBBteaSP0YeGKdXK9/5iwCXQVw1AMTrjBtjAB1MwfV81MrrQd5/fMoQNW9cAxIrP6UZlx3X+Ze6TCTqKWmIC8RTNfYIwOaMMhcm4Qjo788JxxwdJP0DFZyYAVn/o2qLS5z7Oq0W6gTNZwEXzAvOVD2y95CQmQHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=fwRSmLxN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=fwRSmLxN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzXns5Xc3z2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:39:45 +1000 (AEST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-8efcef23d21so31547636d6.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 12:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971583; x=1784576383; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1JWJRfd6QdZf7qlUjcbW5D2kIZlwkQZ3KWr7+m1ApiM=;
        b=fwRSmLxNBGE7eJg+wPQHbw+e1hG+GNezVfBDIzEeAZ2rJVc4Mq9lzt8/I1j96IwR1f
         1X+YT5YcYCXxJug9jObUfQ8Yc1ybw+ujxC5XscZKVG/pIjVGH/6oe5VhyA4pq7JemVTr
         +cydWlY1bQN/C7Om2BStmPxEEc2SKZaBHGRVhLP+j1lDFLWrXcKkCdULrVLBcOnjNcNI
         PmbtYbXXiAoPCUz8fAMU4ELffqqFxwLUXRHxlt93RKSBo+psVDmB4Hogw6WvC1IxYQjG
         p1VB1QyzF3EwlyrLMGambwtoxDwsdC7NBwQODWWmWKLkk74juHGlbvQbPn7qMA8jFscQ
         b/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971583; x=1784576383;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1JWJRfd6QdZf7qlUjcbW5D2kIZlwkQZ3KWr7+m1ApiM=;
        b=BQ1kdge2W6Z93UQSOkNiAWqsMMK/N6WLrLbt+aW5IgQFnvuoLVcH2tbZe4wpA2NNjD
         R+ncj8N5SX16OLwxq/bzudsWV+5hQja4heVKUurfm/u3YEvzp8L/5jXBpht2PUGWm9jb
         b/GrHxUU//5Z3dtFwFVHpJAe2gCvQXNq7K4qFyUdOJuEVIe/Lzm3C7VTLwKCBEhDVf3a
         ETqM6uXEzCd99B2f6mzAFSjkMtGgY6SY+vfjHECjfYxzQWso1D9ppxz4na5ZBPJUKj9H
         eBR8aRRE8zD4LDtzSJQGBkt/8Xzdls5wB3gTz6pXEOEkAnBhN46leHIvVfMZJpF9n8mA
         4tvw==
X-Forwarded-Encrypted: i=1; AHgh+RqXIqC8Z1RMt2dLjLQ+nU2KzyO4FopugHm0bnGIM1LNSohscqlNhk0uI9tZwYKc48qqKfEYKguz0uu1CFQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxKjwpdwpdMjZdpHos6kIKVusDXp47msn/ZqrqjOu/d1qD2CA07
	K5RBQzgu42C4+TCfgWzadp00STIfa6nozyMwL+Rszw4ZUFSkMgX0P5+xYuctx2y96gY=
X-Gm-Gg: AfdE7cm5y2dVxwSMt797e3GZNSnhl6zwLyr9L+O3GCLEdlTiLN23SeaRLY5btpxNxJj
	m36nYY/AVoyNFx0bN37iQwUtXj4dPQZ+sqKtHWQnZVjvf8PfReZ5i1Yb199gbEcSbbpg8CmEUw1
	ahXNuU+kmaE0x1flQjpdhZqrWJYu1Q4UggETkFVkVB9nmKgNKh8XSnlG6Mpi/TaXKynJY/iy4Up
	B6owurzxrP1jf03dGuEGa3WdRyjD8l0dU43MhDwF+wdLD+Y11y2lbVLI7rp+s41AwArLnF61u/J
	DBHGR8Ky6n+/WOJJ4WKvcfQXQ2W/j6DquBe9CL9l+EoEr8gCKiXrwJTWBGaaVsWEM404lalepgG
	zxzcXDhx0ZkVFZHsxCUGD0C1sA53Yy1bHEgIZYIQEutTSxYr4++X76h7K698F
X-Received: by 2002:a05:6214:4c8a:b0:8f1:3533:7a83 with SMTP id 6a1803df08f44-90402c68b4dmr105755746d6.33.1783971582552;
        Mon, 13 Jul 2026 12:39:42 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90725bc050esm20419156d6.28.2026.07.13.12.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:39:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMVB-0000000E6bn-2D9o;
	Mon, 13 Jul 2026 16:39:41 -0300
Date: Mon, 13 Jul 2026 16:39:41 -0300
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
Subject: Re: [PATCH v7 18/22] dma-direct: select DMA address encoding from
 __DMA_ATTR_ALLOC_CC_SHARED
Message-ID: <20260713193941.GX3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-19-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260701054926.825925-19-aneesh.kumar@kernel.org>

> -	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> +	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
> +					 !!(attrs & __DMA_ATTR_ALLOC_CC_SHARED));

The !! isn't needed when going through bool, the compiler does it
automatically.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

