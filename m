Return-Path: <linuxppc-dev+bounces-22820-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C477CD98F2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 12:21:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghcCk4FG5z3bpp;
	Fri, 19 Jun 2026 22:21:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f2c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781871714;
	cv=none; b=T8EQbBryRlPcHBUNYafjiZfTITtmEHc8dtxvCbsoGcQl5V74XQmoS2gmzy1YZYvoDiRn3MUNNs43TdW+c/gi7nqmt45wj0NtZlNdSVu5b0UWjBnzHY6Y2CTQE5h5JF1yDDeZKnnPBuwmqscIeQ6fR0tbhnkFk6TBFVq6sW/38362TGyqX02YVRetAYQhUkpnybjuAeXSdtn0kkGZm6f6V4jF/Ml3nuc+wzgKSzpa9knk7P/yMEZf1AvBJS2LSN6AV8yToQKJ3JUELS151QZrWdfFx9nuVpqjpjFgkFsdEM0TUhbRJmpIhvGRj6+nlIjg2l67LmJ4gc2+EjUxuW08qA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781871714; c=relaxed/relaxed;
	bh=c9LPBfHeyyLdgfb3oWsJJs9sVnnCU9Plv3UTJaVJh/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oljADZ0B1sqAr2yrRy0triKd5099WEo0y0waGh9jLgnZ5DNZxW6mIrXgdMuCq7gJOhEQsn6t/yZLas7TNQG6QgLx9G7nLPo8arjIlzTT4L6EkfctDy+rGx9KBU/+yGn/UzCh05BhzFSlr7CU4lywNaptEgArlcjcRzj+iarN4MqM7aj4A4+G9mmKcBxbEuviOeWVEm9PRmC37vjwX6ju7Yi2MyeoiczDY1nIyZk7gOvx3trCSzY10/9wtEc8lVumEc8jNN4ZInu9yNuAgs3uxQotVU1chm87LwS1exJhu9ItlENKPU9c+DGgAeFRI1G/QTyHPx8lx7qDiCihlp/JaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=GWO32+pX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2c; helo=mail-qv1-xf2c.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=GWO32+pX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f2c; helo=mail-qv1-xf2c.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghcCj1wfSz3bpm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 22:21:52 +1000 (AEST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-8dd6e530061so22680226d6.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 05:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781871710; x=1782476510; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9LPBfHeyyLdgfb3oWsJJs9sVnnCU9Plv3UTJaVJh/Q=;
        b=GWO32+pX9ikEUinTJwzydMsDe/huyfKa8p9xKbFri1TUGTAVPluw5RZ2gxatTqJoma
         YtQXYo04wEEl1WsI3JDRocWSFR4kbTRaoRBBDim2tfFRkwPqATPYOqdISAm/pP5SYHQW
         EuaCt9h33BEb3iwMdX0TjJG8OJ3whzL+MYYC2CGz5xsrxvQOC01tgRrkOhgKWL7X964o
         38M4itGcphqB7kDczHpYR8aDYk8fJ3PFPU4ETJSOvma4UblSmKqlHg7SvmnNqF9/eXJp
         w+gRBXTHSfmQ/4WMU/A7a2hqSR+TfA0oLVmDjEoDhifSebpXHq4/ZTw30LMCllRWhvtM
         27hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781871710; x=1782476510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9LPBfHeyyLdgfb3oWsJJs9sVnnCU9Plv3UTJaVJh/Q=;
        b=rKG86D7POVchi9mV8Iv6ArZ13p90gtS1+yVOxI2Z5eBd7z/+3WjowTLA4S8neoOfil
         9OcQCDvrj9zxEUgLa9qmjxdaVv4+MnmmIke7FIe8LxWpjODr2xxFxABtiwhQ1BQnumdM
         3Wb0vF0nPXwEl/jzIJZPnZ6DWBLmQVMSdn8DTpdscKR6O322LtHpPzd9q3kdvlnpWi5F
         MEGOhFVMiDd7DofytrTvNzJCLvEKGv7xwQsSd6w2epdE2nhU6eyIaEEn9Fb3Zc7RnKlf
         Vunqoz7Xq2QFmbcf1M7m4xr8znbLFtKsURG6H2mmITPiuMrWtWyB3fEEJOWzpWKMYtxT
         /dAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ZfZnugUEeAby166BrYLPRkXxoWNOX6FSpFAU1KS7Br+I6yUsqVmVPjPxEsxOkgONvqLQz2cFKbqwQGjg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzve/FXWSsNFuR0BSmKPkdULmvvbxYxN9Xdt6rsC3REpjvjIdTe
	WgYQFtvfyWqvZpKffnkFKD3objCLbENS+RtoGoqFbQJli+nKh0M4XaBJUdFgXzXbDRE=
X-Gm-Gg: AfdE7cnMxg6aJ+GPNYifDCSjeOQqmS0Z2CyYZpGOjmUCHo+niXoSQT/SJ3VlpBBHMCf
	MGL6RfVnuXFuCDh2aKLkohGx1JaAKWd1CT5vR9XTGjg2xlHP916mQamIFoiJbFY52WHTKsQo8zY
	9yUSh1le8kBgxTi/6twUwX1lilcF8Zp5PoFm10uuzJ6XcbhnEkn7Ut7eFLdX56JwNdJWFv1o9N3
	OWNRYQZbHCJrWj6PtzHxaKycEhy0r48TPPBWQjcaOghd5es9BqVRyl9+jDhRUWZa6ZdvwaODYGl
	x844y1TchoMHkXNLoS27dDAgsAF1eXbLFb6ZVy/rKSE68p/e5PiqUL6CV54Q2fDq5+0HKxLFec+
	9sLFwtsIa44vSQn9vlBTxKIhk5uW/thHdDshCeak3bco4Z8i29pBiLMttw1M60q7FHwntQ/+v/V
	GE1dhbqwfBmBV8JTZMH63H8OF1ei9HjbkFi00wkgfSYCSMU1/d2xsulb8Gou61BVB/+OcHTzczy
	h4cxg==
X-Received: by 2002:a05:620a:4413:b0:915:1359:fc5f with SMTP id af79cd13be357-9208f835f14mr474588385a.14.1781871709844;
        Fri, 19 Jun 2026 05:21:49 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a4966577sm218949585a.34.2026.06.19.05.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 05:21:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1waYEG-00000004U03-2Vgj;
	Fri, 19 Jun 2026 09:21:48 -0300
Date: Fri, 19 Jun 2026 09:21:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <20260619122148.GL231643@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com>
 <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca>
 <yq5ao6h6enhm.fsf@kernel.org>
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
In-Reply-To: <yq5ao6h6enhm.fsf@kernel.org>

On Fri, Jun 19, 2026 at 01:14:13PM +0100, Aneesh Kumar K.V wrote:
> > And this is more insane logic. The right fix is to allocate the
> > swiotlb bounce from the *encrypted* pools when running on the
> > hypervisor which requires undoing this abuse of force_dma_decrypted().
> >
> 
> Agreed. If the device can do encrypted DMA and requires bouncing, it
> should bounce through encrypted pools. We don't support encrypted pools
> now and that means, we mark the option ("mem_encrypt=on iommu=pt
> swiotlb=force") not supported for now? 

?? if you don't have a CC system then the swiotlb is "encrypted"
meaning ordinary struct page system memory.

The hypervisor should not be triggering any CC special stuff here, it
is not a CC guest.

Agree we don't need to worry about swiotlb=force with a trusted device
in the GUEST for now, but it should be something to fix eventually.

Jason

