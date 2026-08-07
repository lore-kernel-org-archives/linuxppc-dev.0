Return-Path: <linuxppc-dev+bounces-25551-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1345BC5AC7C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 09:51:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGfZ50KXmz3c2K;
	Fri, 07 Aug 2026 19:51:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786096316;
	cv=none; b=jSN270ROp+JImQFIRPRQx7/fMi2z4tdNbDvU2d+ZO5QE2tWpA7eoFaLWwmknW5FV5vCfETYbkH8opLeFGw8PT/J/YZB1sOcrHR7/KN1UJuLNRDaLtLFgdDuy9zfxSmAFHCmxSRuQjGNBQK+Th0/Zih7g9FpiH4Arix888HFrXSMLTaHbVXYRkB/JQGqhWtUWiFMxVAu2CVlClZswuBL1zft8jqTtz4NPa+SOEPB/jX3zOORCxQTaiabzRBwryr0KTQ843jCH2a+jKPDf1Q2282RMh5f+KQxWmJwo3+4nPdw8ioYWoQCOV18vUK4rQ9zPMvFJpA8o8gFe1GTRwJBsPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786096316; c=relaxed/relaxed;
	bh=QYbufw58gsel6FCE1/jEcLG9PAf4/Ixif2gUvboMhY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4u8HKRYb1/ndyiHidcmHL9FCCePuenPRsX+NIlUO5zMppqo75hcBRTadIwSBOP9axmjczFRhYYRUqdvZ93eAekiuQ0LVuhphX12lIaMrZjP8hbVTedJMScPMegbdoBA8tcGtXgFf7a+Ya1Vz9u7B2pFJ49vdzNLBX0D2Xi6ccsKE+Yj1MNkQzPI35DGwrudj99HDzMA8n4/s38E23t+z7F2ihPVeIbC0M465jJHl+4NmMFRihRAetY8dBaICgENNi+ZYSGm0PxbDHTpp1bqOdGiOTBWtFO8qRiHKBSF22zm0tVlFBO3kS9IOn8OKg1bszrFWmzNaAHeMQ/EqVDRgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ArC+DY5E; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ArC+DY5E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGfZ20y7Vz3bxH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 19:51:53 +1000 (AEST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-6a177b2dc8dso9901a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 02:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786096305; x=1786701105; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QYbufw58gsel6FCE1/jEcLG9PAf4/Ixif2gUvboMhY0=;
        b=ArC+DY5EC/GQURgS3/Klocjmt6ai30UHP9bXDC48U7gdzNUKWyygM/X40GrT74Wtb9
         daPa446DxVMeRr6L5AUyS6H+MVLzPtZlqSUAn++QGsHjmP819jt6XpZrQTM84+nh5PPd
         REVEphs994Dh2o43tj9VCM7yE267KknPZKt1RdDRXj8ddGoeo9FOfvzniJVTBldGcNQi
         lWASJ4mARMSudhUx+uEJWn5RNAdqFBWDdVefECP045vPhj//TBoHTcDXpe1DaQe5J0qd
         NX+y5Qt6hbrFU0jsy/d9Qa1KQQ1JoHjWV/h+JKucs5OUhacvQDp/c8yGpUN5Ii0AbU+v
         6Wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786096305; x=1786701105;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QYbufw58gsel6FCE1/jEcLG9PAf4/Ixif2gUvboMhY0=;
        b=QVC+1wiTpa/3jUFVHpm8Bky1fi803S49xTpVYifH+liOulIcL0gXSo5HY2yB0o+YUm
         L0/yV5L/0BjOCA38RcHfKZit0wWOrVLXUWvCVYJcG3IQrS9pfVJyF0P4gqrQusKngo4a
         U4zt3msbX16+4ATHEOIt4T5D255QK7nR4zlRJu34er7GQyncosifksKKC6YsckyC1+hN
         V4E8bWs0wbIDWJtKnQxaw3roGM+2RQDqhQ4ow9axuqwGUYuz02IqS3bOueExnyGSdFyn
         Ju3YfCfcDtjmjo8mgtPK2XGg0tW8A/6/riRGcjq0TABuIq2FGlrvydw/dmbglE6OLBwh
         gPQQ==
X-Forwarded-Encrypted: i=1; AHgh+RrKe2eqHz1S4Ag71DqkpTkNade4qESuhA2LlgpoPPpmMgeqlmzVizD/FgAldnQUABgLOT4zE3oiPS8I8KU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxRwDottJtgfYfb3VRBuPWxqEPtPcPeE16+K32R4PVGfaebdQl3
	tvj+7HkQdwUAtIiX9bAgsQFCEuZGkVm05ajJmZcvzaXKK7OrYXMQ1g6TU4LBbmIG2Q==
X-Gm-Gg: AR+sD13tF0dSOqr/1UiOT+xuyzV0VwxwMCpSsFjQDF78MRzlar2mjbotEzuF5y+q7Ip
	HdeWwqrGcEeRH+d0mLE99eJUJ8f0sBESGHE1H4nOExd8LKRL0jhcpou79NTBxDHCR9mhvJz1coo
	aZwDivqDb7SCMVzVZ3vt9ZLGRIJO6z9YL2dsOqoKS452krEXF6FvYvfOtIcA7xXVWXY0P8UJGA/
	EX7KfViIxi53XhJviVM2pZhKNI9MAzHsuUYz6Vt+5FI8PUKBMXi5ci1DL67ytCJdwmqUsXseTnK
	7FZpuo+nOhHxKJDDaubyj+pntN4UnJ06/ouHE0NHibQPulyQsC4z+ad/E5iyj91NCiccKyhJ5Tp
	O2jfMFx5KEm0CXs0DXh6LvB8QJ/yyAwON6JonvA7w5F4aFRfNJk01uDPN8SEeCvncCKa/XEizLC
	AcGArj/KLK3H9g6ERKz+9EuJzVdURuu14ve0O3+QJw/QYogO/mxYSFfc4j+YpiOGijnfN5f/uWa
	BAH4rGjRkN8u6ZZOwqdIslZcfqnUA==
X-Received: by 2002:a05:6402:a5c6:20b0:69c:cf5e:a504 with SMTP id 4fb4d7f45d1cf-6a1da7b32camr36697a12.8.1786096304665;
        Fri, 07 Aug 2026 02:51:44 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a6fa80sm32856466b.22.2026.08.07.02.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:51:43 -0700 (PDT)
Date: Fri, 7 Aug 2026 09:51:39 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v8 00/23] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
Message-ID: <anWqq-vjEwwaziaM@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <CGME20260725070930eucas1p16cbafb514de7a2e7531d0e4ae158acfb@eucas1p1.samsung.com>
 <yq5azezfeeax.fsf@kernel.org>
 <85be992d-9567-433e-ae2e-64ae5483964d@samsung.com>
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
In-Reply-To: <85be992d-9567-433e-ae2e-64ae5483964d@samsung.com>

Hi Marek,

On Fri, Jul 31, 2026 at 09:33:47AM +0200, Marek Szyprowski wrote:
> On 25.07.2026 09:09, Aneesh Kumar K.V wrote:
> > "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:
> >> This series tracks confidential-computing shared DMA state through the
> >> dma-direct, dma-pool, and swiotlb paths so that encrypted and decrypted
> >> DMA buffers are handled consistently.
> >>
> >> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
> >>
[...]
> > pKVM topic branch is now available 
> >
> > https://lore.kernel.org/all/178467286876.125042.12010461715645610054.b4-ty@kernel.org/
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/coco
> I've just got back from my holiday's and I see that there is everything ready to give
> this patchset some tests in linux-next. I hope nothing will break.
> 
> I've applied this patchset to dma-mapping-for-next, on top of pKVM topic branch with

I was trying to find this tree and it seems the MAINTAINERS file have
the wrong address:
DMA MAPPING HELPERS
M:      Marek Szyprowski <m.szyprowski@samsung.com>
R:      Robin Murphy <robin.murphy@arm.com>
L:      iommu@lists.linux.dev
S:      Supported
W:      http://git.infradead.org/users/hch/dma-mapping.git
T:      git git://git.infradead.org/users/hch/dma-mapping.git

I believe the corret one is:
https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git/

Thanks,
Mostafa

> patch "[PATCH v8 17/23] dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED"
> rebased onto latest changes in arch/arm64/mm/init.c.
> 
> The remaining items pointed in the review can be fixed incrementally.
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 

