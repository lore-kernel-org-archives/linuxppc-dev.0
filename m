Return-Path: <linuxppc-dev+bounces-23501-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CC2C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 11:47:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsBn16y9Xz2xdb;
	Fri, 03 Jul 2026 21:47:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::82c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783079221;
	cv=none; b=Zfrxfpajk5JOo85rQXXA86iP421UHmGLf2X55digJKTcqUrMNZlVYbSUFIESY7bEgO1xdwYQ1zIHKTQ0QLP8rZiZwAQYQb4XZq/HK+/Y7FeMzMb5F5+Y3suEbLAZeYr92W73vt4e6RTO0y76vzCkB2Vs3IvLwKUlhYjVLnuHgqHkr2f8YKNtor2nm1fKkUhDZZbSR3j2mVwIV7WBHapp1Zize++6Zvw9qXIy36Ig9/q8qt9YG616IRmKpveOzbNgIggrkKgikUIlaQ2W7g1x50jfzkdpymPdUilBMY1YDqO9KnQYeEfzsSEGLwoblB4R0P4buu1m3IuaPdu+wqmHyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783079221; c=relaxed/relaxed;
	bh=GF/dZxM95AsUU1wWK1B0B/CUui/snGJUvA0tIkHl1DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uei6Kxq0/ASNbOQKCUfql8h0OuKWedWVzfEVRX3YZ7W0Wix8l7rhNCkGBf1y2mqJqOuCvdFpZg1YKWEuWWwZI5S4lBv0ltCNHTyanavW4AEdxOW5sBYqKsJpRJgqHtJwnP83z4AGDdCXOQi+gnENHkRq6KSUvEzCtoS1ZQBX5y19ck/3XdxiStFOJQU9JtwDiYTLn4ldHHPPXUYY91Xqubm/V3kFo0bNhNHa99Cdejs0Vil5fQx95sjmSh2U78BsLvkcCyEiWE1TWUOX4QHkOiClUpeK4gis5UdTCkitmNCnUlRQRNz+TAfUXmil2WnD2cpw+N2NxjeUVXQ/O+kh9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=HWRgT0cg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=HWRgT0cg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsBn04vFBz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 21:46:59 +1000 (AEST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-51c08df8513so3452361cf.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 04:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783079217; x=1783684017; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GF/dZxM95AsUU1wWK1B0B/CUui/snGJUvA0tIkHl1DM=;
        b=HWRgT0cgGtMAYEejmSaA4J3mFVFol4a3pO4iprW6TeCHjEO+9S6W1cyP950tQ2eULJ
         UErFPXr5R4qAoED84Vr0fHwa3zSfBrOTEoZ+Hby9h+F12ctYqyloR6ueyrCOUaHPcuoY
         SiVg8Rqk4rfTGFnwhev7XKj/nVZONMmGPorcdToqZRWHVHOHDLTWI8igTdRNcezjuogI
         C5W9RnxCD6+sC2W2t0donML5N7bZWDLruQ9bbP7K6DNlq8mTWLb+Vm3+ZMsc4bSyzWD9
         yjr1R5jpOX5acMjfxaOkRWa+GB7doEfIjhB9o8LZNHpVi9olFdjg8JRR8F0iyPbl3LC3
         Ifng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783079217; x=1783684017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GF/dZxM95AsUU1wWK1B0B/CUui/snGJUvA0tIkHl1DM=;
        b=fDb1tMYaLh/CXjBqChVwnge9nSWz5+DdT8edhNJj+JryTL6ZDNmHdhCVXlq/8Rr+fg
         UOEm082bBz2c0+hRXOJMdTGDcbqytsE2NGsILT9PjOWoGhRw4fGupFuKoGyaGJxGJmwJ
         SPPrcmd+uecLsfbGZxim/38KuPEZFbRhJRgE6qUHwY1+r1Ko4fFEdPs1TArJlZRWJvul
         vOWt7C/7rjWmdG6kSNUfRLqr9XqldDMT1xUPfJ1b050WOw4WWVtil7wDvP/y/S7d22PS
         LZ3UnOmmqofoJD+dGQvypwzs+hBw2Mq6QvmBuL2WGsi4E/OcWNm1una3z9/Q9R1jnRK2
         Rvxg==
X-Forwarded-Encrypted: i=1; AFNElJ/DWy46JnmlgeaxMl39itFL0OEOvEGyJCExmxz44Vw+Ieo26mqBykxU1BqfF9hfwERjoAzCGCwRiOsppec=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw7J5kSlUDcoANObXiJ8j1KKlZvEZimIC3vtz17Ag/Fkb/WznhM
	YR4zBRoLrGBZyNGFdmEkeOCQf7y4Kapr2mhM2QCN+3/oEpsa6i7awgzJe5SypxOJraY=
X-Gm-Gg: AfdE7cl8yQd74jgRogjlj9R4ZyTdvdQ3yA/7Dyd7w4vpOmn0ExFA5AWcnGJwWPOm9JX
	4gAVA2e9+pfn/VTNf/3Bon3wLTQPL0gXzg/xKRkZ9Te32bH/9lVcOannZ36Btf8XPPi1AjgITOc
	/745/Ryv/FERs0YPOKRzSLd1mrwyRkTUKK0T/HPOkJXGFpHbTZ6/cqAo2ox/JfZKsh4k21V5VCu
	BMqQbgpEpFYTXCE7qLNz5gum/mydgN7Ad8TmuE1QfIfcxj9qOksjicPjGA93kKhgr1+0XNOybvs
	jr0Sn5KGVyoSFMmfxEthDm9X47zgeSQrLA7jgG3gQSSGXsLgduvRDLUqJs+mST6tOaM+67paRLK
	PNZuxpSU9Ua0UYvUhZBmXlQREdxfEeA8K5qrVJNUAGtmtWJPg96KRwmGrnOsyBlCyWO7L+nkrVa
	uoxWu+qmXz9yZfxX4uIJPfm+LLGhpxKrV+7w2t/urGXa+taTEJInBaFSIAAooM36fZRZ8=
X-Received: by 2002:ac8:59d1:0:b0:51c:555:7dea with SMTP id d75a77b69052e-51c2ad42df1mr112307971cf.30.1783079216951;
        Fri, 03 Jul 2026 04:46:56 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c4202366csm13366551cf.30.2026.07.03.04.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:46:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfcMB-00000007ngp-0vd7;
	Fri, 03 Jul 2026 08:46:55 -0300
Date: Fri, 3 Jul 2026 08:46:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>,
	"Cheloha, Scott" <Scott.Cheloha@amd.com>
Subject: Re: [PATCH v6 03/20] dma-direct: use DMA_ATTR_CC_SHARED in
 alloc/free paths
Message-ID: <20260703114655.GW7525@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-4-aneesh.kumar@kernel.org>
 <845d0c8a-6d51-47aa-8e0b-8381e733444a@amd.com>
 <20260617154101.GE3577091@ziepe.ca>
 <25155bd6-4348-4aa8-ba70-0a882fc84db9@amd.com>
 <20260630160242.GI7525@ziepe.ca>
 <98800d21-18f6-44d6-9ba0-da9b77567d85@amd.com>
 <20260702144729.GP7525@ziepe.ca>
 <58bb92a9-c5ea-47a3-b19a-934573f15305@amd.com>
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
In-Reply-To: <58bb92a9-c5ea-47a3-b19a-934573f15305@amd.com>

On Fri, Jul 03, 2026 at 08:15:49PM +1000, Alexey Kardashevskiy wrote:
> On 3/7/26 00:47, Jason Gunthorpe wrote:
> > On Thu, Jul 02, 2026 at 10:25:16AM +1000, Alexey Kardashevskiy wrote:
> > 
> > > > > not externally available so I'll have to trick the DMA layer into
> > > > > using SWIOTLB (which is still all shared, right?) as I specifically
> > > > > want to skip page conversions. Setting low DMA mask won't guarantee
> > > > > that the DMA layer won't allocate a page outside of SWIOTLB and
> > > > > convert it. Manually do
> > > > 
> > > > Why so particular?
> > > 
> > > aahhh I missed "pre-". I need a way to get pre-shared pages for my
> > > sev-guest activities.
> > 
> > It sounds to me like you don't, what you are worried about is
> > optimizing the dma_alloc_coherent flow to avoid fragmentation and all
> > CC architetures require this optimization.
> 
> It is not about fragmentation, it is about unwanted page state
> changes when few pages are shared for a very short time.

That's really basically the same thing. The responsiblity for
optimizing the shared/private conversion lies with the DMA API not the
callers.

> When I needed these pages, I could: get a private page, convert,
> (possibly trigger RMP and IO PDE smashing if that 4K is backed with
> 2M), do the VM<->HV communication, convert back to private (and
> possibly unsmash the page).

IMHO it would be better to use something like dma_pool to amortize the
coherent allocations instead of trying to hack with swiotlb.

Jason

