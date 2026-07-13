Return-Path: <linuxppc-dev+bounces-24143-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6AEC44501
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 19:40:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzXpL2qSsz2xWY;
	Tue, 14 Jul 2026 05:40:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f2e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783971610;
	cv=none; b=J4OUyMqeK8ajnGv1DxPfU6CMgu1Ig+pve/9o6nWqR2470rIWpsSnfR+phPjJjpPZDW3iafEPzEpCUC3szbuAdJtnC7668+iL56iX0Ux1RPKCu3Fxw5NK7uXcJ+r/oz4sPzIqvfTF4YG9CIvUd/7SO7fNHYDWNDPXzbKSEtNJxpdDJyvHXxGobxWciMpOBrbCwnZiIIPW/zVy2jMtOMmBEgYv//1/jtutJx+ye4dqZzFErpH4b2cY0YgOYlnRfM2K8s5quC7VGOa4/b/qSqwDxXASbNdVdzEf6UlKU3x2D0ioL7HZ5qzfgICxVAhMQOpxZgK7kZf1Wh3/Vy9Slq1CWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783971610; c=relaxed/relaxed;
	bh=3axe3nHsSV3pW5ca03j1xpTM6jT4Lmr5n6MpYvrruyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtM7w3Rfb+6oD/xck0dxRHlbI2H1ttymGMtCMb6E8PgrwEI+0kPStBT4bNAgIemWrhz6msAdSZSAP3uMBsleMUYKXMMzMPuOQ4eNSMCy9MC7sZU0te+AHW0PAXxHmpnBwBhxg/bWZnTbcPDBRUzrp1D1puVbPg77oFoC/WewCHUcAvleDQs60ljgiextIiWtHarqCR5sOm3m62AFdFl6XZyh7VkkuFQ88n6Zo16zCIEpPHqqcW98KVV+rrnbIrc6p9XqjJdFZ/HU93RYJ5g1NLAnJJeEpAr/ORlXrvy9AsaQYM4hLrVMmb2+nABRWLh/xFs4E2XBW84i793a9FchdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=U+/pzf9F; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2e; helo=mail-qv1-xf2e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=U+/pzf9F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f2e; helo=mail-qv1-xf2e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzXpK13Jsz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:40:09 +1000 (AEST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-902fc790cd5so34953176d6.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971607; x=1784576407; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3axe3nHsSV3pW5ca03j1xpTM6jT4Lmr5n6MpYvrruyI=;
        b=U+/pzf9FL7y7O8hC2sWHMA+uYiPgcz2ohMLrgnG2ScLSNXMkhKonayRQdaPEEJmXJ9
         VFhBipTceReAJVVVaIDLaqB0/IoJQu6d9+TJnL0XwsD+kSVUXZ+MNESelF8eaLqsveZD
         8mXgyrRZEEzg6uOIua0R3xV+p/ycLuOjL5pDvOsrHkwjXS5xoboywetlHmvTLKL+t2Uu
         pPI/u5Gwzqwdm1w9mZhkn3i5C4e1YtNQMSpH5YYvDQekeqrr5ScOJQoH1xKkHaLOqiM2
         M1hlb8fmB7O1i3pXbcZrcc1Bvm2avaW89o5UNzUgpyo3K1AE9RNS4pVjJnLwsBAYPLd2
         +P2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971607; x=1784576407;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3axe3nHsSV3pW5ca03j1xpTM6jT4Lmr5n6MpYvrruyI=;
        b=daXKUG4BNZYOhTvQKYP+naXZfdEpcA1hjoRAMpTcjcD/hydQKX185ZPbWfPtW1JbwC
         Z/EJiiQktTSZXtUjESuZ8WPxjGNiYws8Vov6P4Hjq55fLhe9bhd01EkAcXdjRqYGbixS
         9SyL4/5PVJkpv7ztJUKiuBO4SkU9HBDdO5oJO6zbZx/9GxeWKKSHgFBpn3oO0+RSQdPe
         eQcbYcmpqwebg8Driz4sIlVT4OJXYee+lJalVpkMiY0IzGW5qDqtqmnQa76YmwIGrBqL
         4u4sb6Uyc3w/me00D2ohuHh3ydkS3Ixv/zoJbjBsEnDk3YFQjXNWrzBqp2/C4gRJYlC7
         bIeA==
X-Forwarded-Encrypted: i=1; AHgh+Rq67hoGS7BoAxskqCm9ndUxaFhe0m9NhQ/Fad4MenZXo2H7VsWXjSIlt2y4h0hnpBsWiB4Xa+GXlD0FmUM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxNo6HF6SYdQNeRAfetsB7gupbTrymaSWPqaGrZonoULkM/WGq3
	knNyxDoLSoCmlER388Wn/JhpRVUr/HcluzWNgkY0cl6DeJ/kW8gUab5tzFiy6v6MZX8=
X-Gm-Gg: AfdE7cmubscvkT/Bw5iyndWEc0Vd1easpsE09/YchP6lcJcf9SMEtjBKnqmpiiU88pL
	zqJ6wuUqmFfYFwZX8mUorkjXSj5poNneh9hi9OcFsI0q7SwoGQZuebLovwbpd5SzDOx0s3vI9yx
	mbCVvGcrnwxqXOLpignlD70M7uiugOcEWYcWTn1T6h1EKWXPqkpdQ9CjxXGUhKdi6uxpoHisLk4
	rTn2HUqoVi8zeVnFz2pXsIw7EWwQgIRa7MU/sJ06OBy1Bh4PNnfR+xezAQdfMkp3xGQpkc3169D
	dd3beATcxzXaPHpQ6gKi9A9N5dchtB/Yw/WSn8Hty5ZIP4/jHHI/yZAZhIywhToVsrg4eS5v9Wf
	I+S706My5jiPhJ5KBtAV1R/5D9vHOC/OJJcrBEME1d/+Jiz+Xm56MiimSVCHl
X-Received: by 2002:a05:6214:e8c:b0:8fd:6e12:9711 with SMTP id 6a1803df08f44-90747d1c8bbmr12839976d6.63.1783971607034;
        Mon, 13 Jul 2026 12:40:07 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56c06e1sm136829916d6.14.2026.07.13.12.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:40:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMVa-0000000E6cV-053d;
	Mon, 13 Jul 2026 16:40:06 -0300
Date: Mon, 13 Jul 2026 16:40:06 -0300
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
Subject: Re: [PATCH v7 19/22] dma-direct: rename ret to cpu_addr in alloc
 helpers
Message-ID: <20260713194006.GY3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-20-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260701054926.825925-20-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:23AM +0530, Aneesh Kumar K.V (Arm) wrote:
> ret in dma_direct_alloc() and dma_direct_alloc_pages() holds the returned
> CPU mapping, not a generic return value. Rename it to cpu_addr and update
> the remaining uses to match.
> 
> This makes the allocation paths easier to follow and keeps the local naming
> consistent with what the variable actually represents.
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/direct.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

