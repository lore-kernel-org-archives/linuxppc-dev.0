Return-Path: <linuxppc-dev+bounces-22480-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5B4CD98D2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 11:30:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbgSV5R3qz3brC;
	Thu, 11 Jun 2026 21:30:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::836"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781177450;
	cv=none; b=doLZkHpH2hnNSojlqlD6jgM9QABce2yXgGYDsXtlI8DaVzEtIYM45ZMi7JBsWrBry6tmgRQtqa4kRsfcw3SISyu+iaFGs50hpwZcP5zHBEzhTVVLjhuZSAPpaDhFjTGnc7mi3llulXxFsQlCyEH6lGeBOXczPUWgWB0Ro7bjHJK6bbBx9vAvgDwRTTqOSlDjNaF6pvfUVrkaNRQ4KIcbU3Ho4/+sXB4zn+6UYv0rmCsGD8cg+MDpyx5flNpY2RhjOqr+8iLG1hQRxiPDJTqMMV9AAbNgLCfXQ+l45+nxc2CUUkgHrbGLjyR1GYlzh2gIPVu3DC1Famzxy7UKuCWcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781177450; c=relaxed/relaxed;
	bh=haH/H6OcYua3Z5rTl0sktjLmKVSLqKAqacU21OYuo/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMGJgdLp9kZ6K3idtB4Y0h5kxzQ/c8qzsVXwDwTJ0AFzk73t0wgq/IUULkq57CawRMlnRyLA++gjhIGyFTNN9LH485eyW1DSIyY0ZA0uQsMIChUiXJdz8vXSiVk8+QDK6EHzswEnfBlyoCPjWgRAA2en8EGFVK5s3pQKorg7BRmHLTE1E8rcpSkdtSqCOiT1PNUZgL44X74hN348rGHMAq2ndgpaIwB9LUhB65JTzaXoI9KOg5ZtinPsrU0FOyJpOjPYiGjZetTKf5rWIDB7ch3hvqQ8TTa7M7A5PzP+geziILDC/O7nupOgFz5gSdRpyhwBamg5oQphZ8jCGiFMVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FvW+obO6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::836; helo=mail-qt1-x836.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FvW+obO6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::836; helo=mail-qt1-x836.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbgST0fBXz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 21:30:48 +1000 (AEST)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-517583cb07aso84173781cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 04:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781177445; x=1781782245; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=haH/H6OcYua3Z5rTl0sktjLmKVSLqKAqacU21OYuo/8=;
        b=FvW+obO66FICl1tLc2lBtJ1DLTSs3i3ILkmcOchJOVQzLWuVOTEalzpLptjrjs5dT0
         TBVMSmcH8DYEmQIdsijkhe/xSTzwAiPNkcj3iwhrmtXyX+TkGieqMOwFfGqGgUoubZ0D
         4h09qigsp/05Y7GjwnTJmBa4TFq1nMCPQu3Y05e10dmpls4RcpgsrbnLq7v+rZ0NzaJq
         rGVf4JEG6uqTD3qs1f6qfbkkWOwny6jq2TX5W8JFEDuPbxGgmaM/XiCddeKHQHnF0Tfl
         ntQfpnodwef9YFQR/sojctDbfuK/Z1aDQVnBnR1zmMh0H1gzv7VrgH4I2d9ySCnScAiU
         suOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781177445; x=1781782245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haH/H6OcYua3Z5rTl0sktjLmKVSLqKAqacU21OYuo/8=;
        b=X2JcM3n1KrBk3EGk0R5V6xXGcBlvssGPIDY7jBVdi3CKYm2PQGoE7y1a016v3HrVdk
         OxU8ypJsukn64dJfK0kMrPHPxlVLQzV08iL13E4E34K/aAcEM9TOxnIUbwquvIsWwuLP
         uE5yLrJIts50mIlktZlehsK+UgqlbFVENCvJrQ+eSHo/3eJBBq+nV19rPT48+euCz1Dl
         hIH1/wTaILYVvwkXR9Cgr/Q5L7dSrMlgHCpynzO04e8ZoQzATS0M79g4ezjOaSbNd2GK
         w6F9dTtSP8xzuBDzluYp9yWHjsjOvRc/0ieJ69aGd3n23d3OJpPbDEp9vQtzHLhKQazx
         BhYg==
X-Forwarded-Encrypted: i=1; AFNElJ+C1DWD223cfR4jyW+VSTsoWo6klG77K3kY/8EdF0MeCI2MBflGaEtB4zRMi8VEe2xA/EWGXcV8h68ktJc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YynQ0jc6w+OqfMfYlaxMojlZk5FGm0m6dSUOwIWKFdIugGKXTik
	nr7Y3YpAgNjkQZ4q0WbN9ib7739uoSGwIFpmQxiWMG3xKyhVyj0IPrFPB7UpLYkyMws=
X-Gm-Gg: Acq92OES+UKkOYVpGnCeARIM/HpTNMsK+3FNN01ohFOMaO3+OMwrk79rhccmupcshff
	q2a/S8kAzEtfcW/hqgl++kOLZSBFfibmg8w138KxfH1pcZ2P+0ApzGNul+nAYEXwvyMmahbXCJh
	TVrX6m3f2BqitaBTS/XNff+vwQ6fjJdT+XySqpmZbkVeOMvvHMwkqddGbBSZcK5MGQHreUMog8Q
	zqXIdNONME7GVaGTxsXDT4p9pz0Udjh+qH9rp/eiQ7UjbIuwdeK+fZikx+krvriE98rKQ/3sGgD
	ARNQHBJFoDw3wBvjVHST8j8K5KzLxwDlyIqm/22o0lWlyEu2C9sggPVkVk5mL+NpFGhlHGyANFf
	CZQm7d/BqgDaYDZ6xFXcx0YeBIRicobvkaPi1AKqMy9NpkviEAI7dcZw9QGCCc3oWzYlxZCAB3l
	32IVawyzKMcsPOmiBPacxWxIlYu8lxrm18cbeaV/d9qX0AjPQY/GgaL/PijwouxTNlIs9EqF4Ho
	Kh8tXBTLfx1LWyl
X-Received: by 2002:a05:622a:354:b0:517:875a:d619 with SMTP id d75a77b69052e-517ede4125cmr35159281cf.6.1781177440327;
        Thu, 11 Jun 2026 04:30:40 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517ef61dfeasm14521801cf.24.2026.06.11.04.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 04:30:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wXdcM-00000005deq-1WZO;
	Thu, 11 Jun 2026 08:30:38 -0300
Date: Thu, 11 Jun 2026 08:30:38 -0300
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
Message-ID: <20260611113038.GA1066031@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-5-aneesh.kumar@kernel.org>
 <20260609143242.GK2764304@ziepe.ca>
 <yq5afr2uzum9.fsf@kernel.org>
 <20260610164153.GQ2764304@ziepe.ca>
 <yq5acxxxn0gp.fsf@kernel.org>
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
In-Reply-To: <yq5acxxxn0gp.fsf@kernel.org>

On Thu, Jun 11, 2026 at 10:21:50AM +0530, Aneesh Kumar K.V wrote:

> If we are adding DMA_ATTR_ALLOC_SHARED, should we also allow
> dma_alloc_attrs() to take that attribute value?

I don't think we should..

It is hard to see any reason to allocate shared memory through the DMA
API. The way the DMA API works only the device that it is allocated
for can access that memory, so it is effectively private to the
device. Thus what purpose is shared device private memory?

> +DMA_ATTR_CC_SHARED
> +------------------
> +
> +This attribute indicates that a DMA mapping is shared, or decrypted, for
> +confidential computing guests. For normal system memory, the caller must
> +already have marked the memory decrypted with set_memory_decrypted(). CPU
> +PTEs for the mapping must use pgprot_decrypted(), and the same shared
> +semantic may be passed to a vIOMMU when it sets up the IOPTE.
> +
> +This attribute describes an existing mapping. It does not allocate shared
> +backing pages and must not be passed to dma_alloc_attrs(). For MMIO, use
> +this together with DMA_ATTR_MMIO to indicate shared MMIO. Unless
> +DMA_ATTR_MMIO is provided, the mapping requires a struct page.

Yes, though we need to fix a few ATTR_MMIO users to make this
statement true

> +DMA_ATTR_ALLOC_CC_SHARED
> +------------------------
> +
> +This attribute indicates that a dma_alloc_attrs() allocation must use
> +shared, or decrypted, backing pages for confidential computing guests.
> +Allocation paths use this request when they select shared DMA pools,
> +decrypt newly allocated pages or restore encryption on free.
> +
> +DMA_ATTR_ALLOC_CC_SHARED differs from DMA_ATTR_CC_SHARED in that it
> +requests shared backing memory from the allocation path. DMA_ATTR_CC_SHARED
> +describes an already-shared mapping and requires the caller to have
> +prepared normal system memory before mapping it. Callers that need shared
> +memory from dma_alloc_attrs() should request DMA_ATTR_ALLOC_CC_SHARED
> +instead of DMA_ATTR_CC_SHARED.

The semantic is right, but I would make it a private attribute since
no driver should use it.

Jason

