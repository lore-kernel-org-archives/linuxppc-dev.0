Return-Path: <linuxppc-dev+bounces-24132-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956B6C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 19:08:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzX5z5yW5z2y1F;
	Tue, 14 Jul 2026 05:08:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f2e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783969719;
	cv=none; b=Ttu5cphlPP74UpbYiO9RFZ+emBooW4X4PMZeRTUvsSgDEdT9H6EzPXRH6xFOc9m0sBYQ7BU1sU+ekPvt1rCMGFdT7PiVLRFuMaW4Qqq82srmhsSDBwlueugeKMNihzod7bqHXjxax7/ATMLJzUZWKvYozd+mc95ro3Zl60/ZB4YTrvjjElvWTGjvIHSzhbApoatt82gQ3KpVyU+g6u8xYTW1qzGSjaUnqTqPIxxA7JlQdKjHlW+4cp+wBGrkOWgeyXX5bLHdTqPkVnJVAT5ZrIH9Gcj8s4p8Yj6WAyUG9bhZFo49TJZ+sk4/KA9mzmNuX0xmylNijRsTnnvjfo/jIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783969719; c=relaxed/relaxed;
	bh=xI/VqVGbyjLJTRr9oYnYDAONmrfr0w8bRuYGoSNi5Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3iEMTkcM7IcAcdSbS8cY7dR3tlttagnohFXTLaQtXYJU0A+yyS+/Q2cExokl5OxvzfqyyBtMFIlhiPbjH4qAh9QPNKoPg1Qj3ywCwmDa1DnGSvZZ+LTdb2ooqL3mazsPD2rSlevKqfZp5XpJbEPf576d6BzQTC4JtCsLkOS90X3UQm7hPLDhqUswHlMIO+mSbIDNl3SoJX/NIFI3lihilKdrGna0+f/HqObC2W73MYulw+DCdsLzvaHA8yAWVr2xL2brGdbFP7rgTz3HAYpZfVwZmA1EcwIWACemRSr4NPBgmhE0fntQAtfT+Yx/uHHK0fLD+Y5ax4gX4zqAN9Mvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=HkVHitbF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2e; helo=mail-qv1-xf2e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=HkVHitbF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f2e; helo=mail-qv1-xf2e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzX5y6sRWz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:08:38 +1000 (AEST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so2152136d6.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783969716; x=1784574516; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xI/VqVGbyjLJTRr9oYnYDAONmrfr0w8bRuYGoSNi5Tw=;
        b=HkVHitbF+iGh4cJG+lRyZAD7Ox6LGTR1W7QWV5yrWsqfp8DVjX2OddwFcYFiLCgW72
         uTWquww+OuKcu8aO44WV7id5HSfmI+xHMv6EsybTO/EGI9PmQMOZNfn9XFBWc1R7oNZT
         wSk4dlKe+iEKX5ULJSafXZ2WyjK5PP5PkXiJnIn0gJqbNSuXrEB2jxSCdI2IUEPCPbiK
         xVweBECFJVtQ+Qo8nVeZln4QQv6wSJChELHkguj3qADkSdaDk3XAGpRk71W+66SyUXFc
         bi2pc1zEQ5HGjbVEx7tknpUJ8m6FxLG4LaplyHN09laTN1gIcHqcomTC9eNotA9FctG7
         kuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783969716; x=1784574516;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xI/VqVGbyjLJTRr9oYnYDAONmrfr0w8bRuYGoSNi5Tw=;
        b=s1pR06x5Vcr24ueSmRxjpL4n2JpJPkVdN3t6wk8yLr99CAuo39fIuQaESF9BiHPvU7
         kmBoXBkTqp8eWAjb56TV6Z1Q+4PmwQSXtarV+AI6Onex6TUJYiz/GKcfGt1SQBaBH6+i
         NiCU1gVpre06gdU57T/1Gk45Go8sqkpCXNrdnyakNYPnOpjQBvp4DGXQ3vNZWPULEJUd
         a5Snl5L55cnKTzLTNChuI91O2mNRlHAIUwBpn+rYp/bYinh3qIcZfKn4gIq49WMAN0gq
         QHm/S7+1hSi7ETZuURNmoI+QHEm2XD4KTM7tuFEx+j/lkCiNS+m++u5sFoglHG2FhoFI
         Rzwg==
X-Forwarded-Encrypted: i=1; AHgh+Rprf6hg/Dgg2ZWlCx5kOrfbnsRWrzEYLBr+lJhmBX4lgcP0EQA0Y/t9p1z/5OjIUbJW6W7EkOuSzz83AXM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxHaUIwABumyEK/ZpfWcuEh+ICG1kHw3EilGeio61lB4J6M/P4d
	Gk80CrvUXti6nhe7TDHzMEx7tVsg+QIOadzaU+K0Jft5pINyNkJVisUfGrRZmYIF81I=
X-Gm-Gg: AfdE7cnRGgaXwD2QQ2U9gHfRkOjZNK4bQf1Hdvsa4pnPWIsPBcai/9bxx9Vyk9Q2gw4
	Ql/kcPNJVlLDQ9a2x6YSI3yUyOdNJzj80tPzR5LRas4YW0lehPTmCjUOaTcei4A87PCWOfXUbhB
	xJaaiR87OBxCo46VKpebRsA1LlyDksMAwI4MrAjfhFMl6n4TEwa0wIf5uft/d5elfyTlV9a2K2i
	IFZgGz3gh2mfteuoFVHUn9qLHrAgleuGNrB1XBY2r7ch6+G7JAY6NYf/A0pjySlIzPR20FcKFan
	ixMyawOVDBn9vmusThI0StrVBmQUeL3Cu0P8WGo3yYzO8JHLzTu3lbJFEPGmbz3dEhV6QFW83J5
	nHQ/xbT1PVsu/bCD7QxTT36aR58ZQSBmPAhwHQsVK8W5k3SaBRohaEZGqzy08
X-Received: by 2002:a05:6214:419c:b0:8ef:6c8a:e8db with SMTP id 6a1803df08f44-9040206aa9fmr110916776d6.47.1783969715612;
        Mon, 13 Jul 2026 12:08:35 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e0811sm137651756d6.3.2026.07.13.12.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:08:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjM14-0000000E3qf-1Q0G;
	Mon, 13 Jul 2026 16:08:34 -0300
Date: Mon, 13 Jul 2026 16:08:34 -0300
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
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 05/22] swiotlb: Preserve allocation virtual address
 for dynamic pools
Message-ID: <20260713190834.GN3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-6-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260701054926.825925-6-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:09AM +0530, Aneesh Kumar K.V (Arm) wrote:
> swiotlb_alloc_tlb() can allocate from the DMA atomic pool when a decrypted
> pool is needed from atomic context. With CONFIG_DMA_DIRECT_REMAP, the
> atomic pool is backed by remapped virtual addresses, which are not the same
> as the direct-map addresses returned by phys_to_virt().
> 
> swiotlb_init_io_tlb_pool() currently reconstructs the pool virtual address
> from the physical start address. For atomic-pool backed allocations this
> stores the wrong address in pool->vaddr. Later, swiotlb_free_tlb() passes
> that address to dma_free_from_pool(), which will fail to recognize the
> chunk
> 
> Pass the virtual address returned by the allocation path into
> swiotlb_init_io_tlb_pool(), and store that address in pool->vaddr. This
> keeps the pool free path using the same virtual address as the allocator.
> 
> Fixes: 79636caad361 ("swiotlb: if swiotlb is full, fall back to a transient memory pool")
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

