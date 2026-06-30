Return-Path: <linuxppc-dev+bounces-23225-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F97C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 16:02:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqSbd5VZYz2yft;
	Wed, 01 Jul 2026 02:02:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782835373;
	cv=none; b=EEpWbHcfF3cSrdlH32KmRMWlLDaMiV/CWrN6k8TrPd+hyx+LoamiLT6fll+kOk7WTNx7RCfUe87suvYoKMys5rj/pO1Ho1kxK+nalfpYSFvjr0UmzZ3YNew3aVY+fTt1AS/wwJJnlMM9Pm6ujnU7R6ocdx0uLLWxSq/zOZhp98AgtCqbkCFjbo+hGOe+6WcpwnVXWP84+I2GZCo2XWGuxUSOn4FoUOQIh8mA5NfxTey1MNYSnyKF1zMFwaz9SSjTrQzIfu9bvOX/eDPVsTZRwM5ePELh5hxk9YhEwSvkszAiFNYa35ABqfqlUslojmoOdDM8sci9ozhYaMh5386iSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782835373; c=relaxed/relaxed;
	bh=GI+sDv/bw0RypxsaDxkfRwNjpEKuAX+hIc2iRD1v3+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcuaoWDOE92XqfXFzqyIJV6lcc3bOxfUwL/hjTkJWij4Hn+ftnZHqMv0IGjMZs2me1A9gH58EzDliA+TLQ6P5/dpSW9HkXPdfCqV+DeP1cMizSH1azneq4C8VZCenoCdmhxJ0pyJbYPlklhsbZLGPs+/QrzUT50M4npSZ0mLRe4zmzqmMUs4qpDoN4ZK8mwh48AXFyAVqd45OHEPuZNdsQofBJQ2mrxlgNLYC5zyg0Tb7mTh8ZAQZqH66B6UkFi3OrkMin5qMkyT1aiUugdvFNa738OEeStMqbZg/u13/Y6tTAwnLsaPoTW5lOYnDiJTWwlbcdzytxSN9zoIrQ5rbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hkNpiewC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72e; helo=mail-qk1-x72e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hkNpiewC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::72e; helo=mail-qk1-x72e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqSbc0dnwz2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 02:02:49 +1000 (AEST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-92e622cc874so92475085a.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 09:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1782835367; x=1783440167; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GI+sDv/bw0RypxsaDxkfRwNjpEKuAX+hIc2iRD1v3+Q=;
        b=hkNpiewC6faG6bQItlOKDQhiNN3etHqvKzr2vXjuVyl9dNMZd/HbN0Qw3gYs3jSzwX
         3TTwscsfRWCQ1nOAM+cJfuK06deDe28LaJ10bG8HGg/q1Hf73Gx5o/iJGqXC8erqX2o9
         vSsLxbA6P3YA2VAp/PNtuueBz2JYLgXL+4km3Y23xuES0sLXKyMf4OmWOk5+vPM0wvKB
         7e4bjnKLgY6pt04yYGTw6Kd/a/7jz2+u0xinZ+nQyzSsK/mXga/meaZRyyReTm7ExAx5
         anaSwNPN97b/CDo9Mit/pLwLjJaIA6NW3NxeTiG7NonscNZyH4ELIY5Q1Wb1px3HWM/I
         IO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835367; x=1783440167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GI+sDv/bw0RypxsaDxkfRwNjpEKuAX+hIc2iRD1v3+Q=;
        b=SGd6V/k3RxvIyW7e0FC23ZBQcttijeTEPyovCmdeSeiK7ezsCxYpoCpxUlIHuX1Zv1
         kxTi3W9Dr1801pMiHEWP6AkmWkfLDM6WusIa+yJXaR2OmLfW0orsvFa94bR9064/hPHZ
         PF+TXmS/9bPBSfMskr9HRTwwo4asvTcKqeh8lHrSm9pTG5BNRknpGfSinWbz8nfF9d0Q
         KJuUl9esIR+sRM/hKmOTIQyFP9q9f9+XRjXLqoLZaR4n+q+qrLlcWOtJ418HFGexi28T
         6HQ1OfyiNdaqyYHz1xFJ51Ty0H5236AB7pIVf+eTyD6GQSWKHfWSM8u0HUHHmwTtup7u
         5w7A==
X-Forwarded-Encrypted: i=1; AFNElJ/BhgfpqE6VmneBUgYHv2/42Us4xTijtZFwPhmEEsb8uWTKB2en7QRaXt0o41WZfxrEoDcI7sPrwLW8dOE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywvf3i3SBaKvIMRocWel6aIqFZcLbDTRWB0m/OYjRK2XmECV+B5
	C9RnCUyElj5jFvTyURe0/nliKE3TDp36jnPlTwEyY4XqIyI0kmnmfuNx+CfLjIUOviw=
X-Gm-Gg: AfdE7cm8N1OoFHE0D3NSgNo3zzeXtDd9vymWKrM/YjxlmOAcbIMc7/zCnA8V0ApBDLo
	kgdX71ZrFvOHhzONuN3AyQZsrFZEFZuyVw/2++ln6Vd3qDm4JrPtVFlAWRH7m22HdDa0JnsmnM3
	aOxZHVdr0dM3AN98l4SXk3X+Er9WIBWgojQpB9q4WLqfBoJrVZlihRQNJu/OcyEIiAy80L7YCN+
	Lq4F1vVZCnebv8eRGcpLyPh20IsfGmkQs3N2oEDJuYWnWuuU6A+jP5kEwsw13AlvQiXP3Og+Wpj
	khBPe1xPLjtY3hXu679UUY78pwiOiMHKVTLLu8jJZDziGzI60sn13eHpxpGytkhevwDO2fd4GzS
	SMPv8xyCBVZdF6WH4fbnficb1kZi/Q8VpXfAHw+sub02p+0cO3Ku3HJjMQ/OLujF0KxSF2tzetA
	1ytGsbdhjGiw6wgrSTQY4k3zyrs4Ge0ca4k4bJr/IvBk8LwCw9cfWJmFLhJ5uvh/EasqA=
X-Received: by 2002:a05:620a:839b:b0:915:c4de:7ac0 with SMTP id af79cd13be357-92e6278d80fmr646181785a.31.1782835365891;
        Tue, 30 Jun 2026 09:02:45 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6236b9fcsm262102385a.41.2026.06.30.09.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:02:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1weav4-000000027Ay-3dT0;
	Tue, 30 Jun 2026 13:02:42 -0300
Date: Tue, 30 Jun 2026 13:02:42 -0300
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
Message-ID: <20260630160242.GI7525@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-4-aneesh.kumar@kernel.org>
 <845d0c8a-6d51-47aa-8e0b-8381e733444a@amd.com>
 <20260617154101.GE3577091@ziepe.ca>
 <25155bd6-4348-4aa8-ba70-0a882fc84db9@amd.com>
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
In-Reply-To: <25155bd6-4348-4aa8-ba70-0a882fc84db9@amd.com>

On Thu, Jun 18, 2026 at 12:39:21PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 18/6/26 01:41, Jason Gunthorpe wrote:
> > On Wed, Jun 17, 2026 at 10:50:39AM +1000, Alexey Kardashevskiy wrote:
> > > > @@ -193,16 +193,31 @@ void *dma_direct_alloc(struct device *dev, size_t size,
> > > >    		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> > > >    {
> > > >    	bool remap = false, set_uncached = false;
> > > > -	bool mark_mem_decrypt = true;
> > > > +	bool mark_mem_decrypt = false;
> > > >    	struct page *page;
> > > >    	void *ret;
> > > > +	/*
> > > > +	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
> > > > +	 * attribute. The direct allocator uses it internally after it has
> > > > +	 * decided that the backing pages must be shared/decrypted, so the
> > > > +	 * rest of the allocation path can consistently select DMA addresses,
> > > > +	 * choose compatible pools and restore encryption on free.
> > > 
> > > Why this limit?
> > > 
> > > Context: I am looking for a memory pool for a few shared pages (to
> > > do some guest<->host communication), SWIOTLB seems like the right
> > > fit but swiotlb_alloc() is not exported and
> > > dma_direct_alloc(DMA_ATTR_CC_SHARED) is not allowed.  Thanks,
> > 
> > Then setup your struct device so that the DMA API knows the
> > guest<->host channel requires unecrypted and it will work correctly.
> > 
> > I think this is a reasonable API to use for that, and I was just
> > advocating that hyperv should be using it too.
> > 
> > But it all relies on a properly setup struct device.
> 
> Sounds good but how do I do that in practice? 

I think we haven't got there yet, I understood Dan's plan was to add a
bit in the struct device that signals if the device must be
unencrypted or can support all memory.

Currently the dma api assumes all devices must have unencrypted by
default so it should be fine already, shouldn't it?

> not externally available so I'll have to trick the DMA layer into
> using SWIOTLB (which is still all shared, right?) as I specifically
> want to skip page conversions. Setting low DMA mask won't guarantee
> that the DMA layer won't allocate a page outside of SWIOTLB and
> convert it. Manually do

Why so particular? Any address that satisifies the constraints should
be good enough?

Jason

