Return-Path: <linuxppc-dev+bounces-24136-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19F5C44501
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 19:22:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzXQ61G0gz2y1F;
	Tue, 14 Jul 2026 05:22:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f30"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783970558;
	cv=none; b=EMvgXWsRTlWwMFUykQnJ2WfBfBmwZJWjf4cblLBCFLPhRHkpcA4G6xRdNaaBzBpWQmJydQc62h8Q+lNsHobXUF2JZZ3sa6lgdFMWc5JIz7srbq8k6FxHCAltoqw0wQj0tms17q5+h8m2Eo3EwLoMsJ6yJ96J28Uxr0Txj0rGwkKswOReDVuiqU6W5UYM8g5PMZYiRVkUUbM/olmGSXhyyvqCTS/DNq9cjac6r18B/2R2K4Gg/QcS3XXcj7mmoejkl1eW1NCTHH4RJwuX2T/uYTvZmIM+NwD/ooXETUBWx70APCXBSojpIJBXy5Zkdgj/qAYigeApXfVTQ2cpyjmFUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783970558; c=relaxed/relaxed;
	bh=rTUChJSUQ7qBnpi6xNUNbqkdyOGkeoHtaVMHI6/gjvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3bDTeNh3FLm+MJWnUjQ78hjjYaiP29VlkXSPVUgg9rR7gBeXFny9prIU8oPJalUGfFkHzPZW0pSgwg1GBONSvhjG3csv+GflRXfeujQaeE5wdTUEGHjQqVpahXRvM0VQ4WouWnPTGeRcRRdpjuE+2dJ0etyeJL6RLbWwb1S0OH8pAj3XQUYSEu8v9ZOlD3Wq9IRB9dZmzzRs5852odp+WzeNwl5wuoLK+6YofJw+sU/PR4BQE3GVSMHgt9XK1Tiy765cm3MCqHgy8I692GkyIfBFooMYENyXAhJW0PzzAaJUtdk0NNgIYxr3yWooWxWGp5dx6iQF+hAMnWClVhG5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=o7brlQ7C; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=o7brlQ7C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzXQ51TpCz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:22:37 +1000 (AEST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-9061a795d76so2211456d6.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 12:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783970555; x=1784575355; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rTUChJSUQ7qBnpi6xNUNbqkdyOGkeoHtaVMHI6/gjvI=;
        b=o7brlQ7CkZ1FEeuwkPv1uh2LFKRDrlgjRqB4vxL8iATX/2h9807oVwtNUHjnKMmz8s
         aFxSma3c8ro8EovS1Rj7lOq4KfFAHGzrnJGG3qssRyaReDdvR5XH7bZVfs7PsETwbBIb
         N8UJNhD1BKu++CiIJJTu5ovHvBuBdE0lAdQCwp9Q/V9MjLJXcZ5ZH6bRS5t2lVR8tCIa
         EZb7zYnbkWe3HUx4u+ft+wcSoTq7ercyf5dfKuYsxhtb6OleXK+o8u8SUxQAtQeugZGx
         XKuQB/iZoQEgofrmGIMETVdIGWIyR6lWrxmXe+5FCG3N5woP5QSam1MBpOkviMbzHgSU
         iulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970555; x=1784575355;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rTUChJSUQ7qBnpi6xNUNbqkdyOGkeoHtaVMHI6/gjvI=;
        b=h+Ku3WDDIu24Mlc5ORrjEOUZha3jPR0Tq+s7dAnHrlIvqtJEkqz1JaPSDqrbGHJd3w
         Juzkwq8YTL3nTy1tX8xNTDEMJODnb9urSnKi3drfWp1h8IPbsAZ199GdAoTEAQW1mRUp
         uQijSnw4cBNBVno45JWxXxZr6NkwRdfdctTvd0WwQyUROxyDokomNvSaubavcgaBQMIH
         vRbDARRQDgS09PT9cuMFJaRrRgVDu8sehACdI7AIe+YRNOuS/qvHpKjmoCSzjGYMJYWK
         gGWfsCtJxWdljtTIiBI9gH60bkCkoD4UfDyOT3cW4TPLJR83lrh6Q1QvETLco4ItbbTT
         sFmg==
X-Forwarded-Encrypted: i=1; AHgh+RrZS6IpfgDFrG2LG9538VD4ruWn6uGYd7zD4GroizxzrWkrduR8TuiMKunJAXTbNcx/9VruOnvRZNZdVtY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxOChJYb8nbZPV++eyt42htwqpJBoP/qhEL37uF/BWAQ2Oh0jqJ
	2r6ARtgDE3uV+FVwYWKv8KPVmEJEuygIwKF4l/Lk+wx09S28tpEMeM69/M7qfm6i+vs=
X-Gm-Gg: AfdE7cnDsDR0QWbCwtb5E6LEX8T6CLY/O7TO8Q03rBWgxOhVNhzvbjhqVg0KrcVK9A6
	PmhFsKDQ/IfWI3PVWPZdGZ7RxK7Uv4d7BrCI8Ohhag/ml5E3H0heQ+ReA6qsprHJzb3kIURvQIh
	er/WrneERb31VZl47xeqgKteY2AFsdWo8hRQMIrpQwGdaGm1q50Bd5NQ8E3mLK8g5MZyGv0wrUk
	DB8RXBeoo0Y6vThAzd3uq+f6opndF9GEUpDNoEHWoRiv5JoEr4OWRrv7AIqxSFrdWsrjjVHKvxF
	tmkExsJmRDb2yACuGNHA9R6Wd/AqoqPYuJ6tJ3pvsIrV8ZVj5vXihL9elWYFCSPq0o2SqcgO5mY
	BQ2jG6NBspUiPVAPKkJuCyl2MmJhbgvjCw67+fniCutELLp1ZB3UEGqG9QIcKEiI/l7Z8a/k=
X-Received: by 2002:ad4:5caf:0:b0:8f1:2607:ad86 with SMTP id 6a1803df08f44-90400b8b562mr134619656d6.4.1783970554874;
        Mon, 13 Jul 2026 12:22:34 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50df5e2sm138736336d6.4.2026.07.13.12.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:22:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMEb-0000000E54I-3Zkq;
	Mon, 13 Jul 2026 16:22:33 -0300
Date: Mon, 13 Jul 2026 16:22:33 -0300
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
Subject: Re: [PATCH v7 12/22] dma: swiotlb: pass mapping attributes by
 reference
Message-ID: <20260713192233.GR3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-13-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260701054926.825925-13-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:16AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Change swiotlb_tbl_map_single() to take the DMA mapping attributes by
> reference and update the direct callers accordingly.
> 
> This is a preparatory change for a follow-up patch which updates the
> attributes based on the selected swiotlb pool. Keeping the signature change
> separate makes the follow-up patch easier to review.
> 
> No functional change in this patch.
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/dma-iommu.c | 2 +-
>  drivers/xen/swiotlb-xen.c | 2 +-
>  include/linux/swiotlb.h   | 2 +-
>  kernel/dma/swiotlb.c      | 6 +++---
>  4 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

