Return-Path: <linuxppc-dev+bounces-24138-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95687C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 19:26:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzXVg18t9z2y1F;
	Tue, 14 Jul 2026 05:26:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::832"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783970795;
	cv=none; b=Pplr6GNbqZgo4XPINDjHKLvjkOJEWPUNwDGubeRSZyGz2p1sgwxDhE/eQNEXmG3iJyVCvEQs7rGN/NVZrr34qKG4qzLjacw4Mvp4zweb7E/wX4qOO9cbFcL1Fr96O4BdzudUsOrGvccjJ+TFxcm2KzTEuiB+QU/eHxzS0KQEroKo0DR02zIP5QR6e+lfL7sNfM4nZBt6kl6fdXYhQYZOBlckPTvEBZwLot8liZIUexdWvZLrGM/YfWC2dx2Sd6TJPi6he3q4r86icEwx2Pgn6ey78cw6k2EQvvJVB5a4SKomelCPAwNZd1MjNaMO8lcAH1HHFJN1DkikEG1uVI0ODA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783970795; c=relaxed/relaxed;
	bh=WcYJlt5p9Qz8AXWYIObijachKEBwhFuSBSepR8dnD2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=El3zeV0LKtMXdU5QCutRG2JcCStKLxECoV/qe4e3Yt2mPDnhczslfzk2bXflteDoGOTq7QFArTE3hIVDDPLz2flAMlANnjRWMnLotNA/a8M2uEi6dzWavFGBCvZe2Z4+JPigcjn0DCoOITmtKcRrDvcDe9A029NY56IRhi4aCiDpoTrbjsYOY4KrFSanMgu/sn05jSzc0ZKif9gp5/pzd7m4IOSK41WZZQyB7YrkJ3tXGx+YrvdLOpDniLBKtPHo7k5YxxvjoExAvAFY+n+IzuG+xOyIwLK4406T2M0yZIv2CM99OkoZvjCGwDuSlj0dBGQPDZ4+vC/iHCEPy0heXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Tc3zUrot; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Tc3zUrot;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzXVf2jB9z2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:26:34 +1000 (AEST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-51c928bf172so23035911cf.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 12:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783970792; x=1784575592; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WcYJlt5p9Qz8AXWYIObijachKEBwhFuSBSepR8dnD2g=;
        b=Tc3zUrot7Tx4dL72hITeOmjrtmJVZ2/f2Uoqvtwly7i3JDZgqvkGoiryG3S8TI6dUk
         2bFvZEncvnq7SYeQyGDNxVJm0AL2gno1uxK2P3qim5HDj3rrvRolxF6gay9r/yWbcXdl
         3or4QJv3HG1WWmPpa+QRcLE/6XKCkk2ncbiBf76oaYZKzWXDr1eGghvQqropy4peNtfb
         j61OlMOEs4yf1qDA5cHgrU1dS5YYmBk6L8kBKnTXA4I/3YZ8qwqTDPceHpPCAQxRfywZ
         4vuPx5+2buVv8xWXJdYdJeDZvAaLxPB2gqt1rBbRUcTA2hB/NlzObzFCxZJ2/JfOXW9m
         hyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970792; x=1784575592;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WcYJlt5p9Qz8AXWYIObijachKEBwhFuSBSepR8dnD2g=;
        b=EMLcGebYbN3RPIQtzONrXTLPIwWhx4JnbSmrg5B681VCr3qcMxXpELYivslbvmeosm
         wqN6M3lDBj+ctNp5TtbhSOdUJJgCd/Dm9G5Awa0qaGrH9xXNt1/ZpuNDnXmV1EO+N9l/
         l/+cjx1edAbQHo8W1yvivBeMR8ab4ok8+GQ40JKhh3OXWrlMfkDfukluDezMhP9ONfJ6
         MF1nbfAAclrXgbGmZ5FbMcyIyCxaOS3WKRrxfcAgFY34QGAiUwpNxHHE0gLJ1Kb133hk
         a5B2UXnxWk+lL6A2hlaNRaUAcxgZigGxzC5zYDvMhNmUzeY0vp+xWirvhS86yMtuC/fU
         ONCQ==
X-Forwarded-Encrypted: i=1; AHgh+RpKQISrQmvsLSotyFBbNru3QVcuJJ09j6YEkIe+FW77VSNvCrHMBIFrYNchYjtKDHFu6RM5XuFVUenoWLo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzgn2UI227kgaNTrdTm3J7xjffYygjPvvaeVe5mvKLvhYuDOmyg
	xl6NrtaAXYUiB/TRCHDmHtwAPx3ITuGEnWmlwXALp/liQK2KbExBJ+Le4eRvSC3RfWQ=
X-Gm-Gg: AfdE7cnKNrWR/6inTW/2QxaQGkM3P10bDwytAT1iwYGyvbxAjnPeLkRFeN3Eq7irElE
	Gx2XiMzvM/6lkiwHn1rm8d9sJYG37dwHdJRfJMWvJggQy3QeXITU7xrZtMCqoPrZYGXAAQTf5A0
	qzzsOLybHBVmH+3pICPS6lcQb0qhigfwM+KdWvqDzJJ0Zg0+GZDWqN84X75e0g3Q8gXEayf0VOe
	ddbwpZhveXEkKNjKikXkB8n/Hn7GjBopfhlGcrVs7KK1o8ijoUIt7BHmhJwZWxD2qPjEJfCZKv3
	WrG/w4J32tdgA/8A/IMdJfiFkHNKlDbUDptCqeePU795wnbux/ULkWwXG8BN1AP9M1nHyn0VaSX
	8P1qlDKF17N6sI36QBfFOxUYt2kiDwl/9U6phQM+BCz9P01MLWp4dbBDjKzp9Hrv+OEbCAUQ=
X-Received: by 2002:ac8:5906:0:b0:51c:83ee:e430 with SMTP id d75a77b69052e-51cbf27d077mr95594101cf.75.1783970792197;
        Mon, 13 Jul 2026 12:26:32 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51cbd8efab4sm70831241cf.1.2026.07.13.12.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:26:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMIR-0000000E5Pw-0MTy;
	Mon, 13 Jul 2026 16:26:31 -0300
Date: Mon, 13 Jul 2026 16:26:31 -0300
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
Subject: Re: [PATCH v7 14/22] dma-mapping: make dma_pgprot() honor
 __DMA_ATTR_ALLOC_CC_SHARED
Message-ID: <20260713192631.GT3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-15-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260701054926.825925-15-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:18AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Fold encrypted/decrypted pgprot selection into dma_pgprot() so callers
> do not need to adjust the page protection separately.
> 
> Update dma_pgprot() to apply pgprot_decrypted() when DMA_ATTR_CC_SHARED or
> __DMA_ATTR_ALLOC_CC_SHARED is set and pgprot_encrypted() otherwise Convert
> the dma-direct mmap paths to pass DMA_ATTR_CC_SHARED instead of open-coding
> force_dma_unencrypted() handling around dma_pgprot().
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/direct.c  |  8 +++-----
>  kernel/dma/mapping.c | 16 ++++++++++++----
>  2 files changed, 15 insertions(+), 9 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

