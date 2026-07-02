Return-Path: <linuxppc-dev+bounces-23410-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E4FC43602
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 14:47:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grfqq5svfz2ygl;
	Fri, 03 Jul 2026 00:47:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::82e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783003655;
	cv=none; b=MOddg5Ti4O+taClRu5HlLdhoyzAPasx+ZuWpbj9FznLL5RZ52dYI35hzRFYrXBf0IpEXsqZygaiLbEdsFC+NBuRYlXwgQwb8B+etKo+bD+g6sH+l3etsQNz9nqZv6yerDrBHeNs1mXBj/v8NqqiG+ABbwaqLROtATNxtB2LO7wRd9AKf2snZAwEbbb7f1hieTke9Kd+7hyBrhvKkNbetlhPDEsBdEWGYcdFoLjhWyKhHdX7gYqnkBvJgB4LwtAc4I5uMCWkRQScAZ9nwJ2oxrjpnL3jiHvVUGdi0yK0sdC0iWiT943iFNhG1ou06DYTZNLRawtDL9ZCE1MIMaEf7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783003655; c=relaxed/relaxed;
	bh=VHZVkcI1dGlitqBERLzcSZUkSvuExam94MObbuJvLAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQqzBtYnTbt7TdHbucP0bKhoWZxu+1qX4tvA15bH6il8PCV7zouHbnz6ec+igJfzztu3RFZjRioIHe0qb95zYZOIisHjpFkJme9wOR7AKhlUeonXtKPscUq4EzNVZZpQeeedjZUMJskiQDGpJrXX7oUcIOq0LghEmHUTMB2GmHGmX9ky5ouLx00gMpXukrPlIrYVY1iiJ36mERgsoluFLlvL4jxvEzkQugdAoeVtNmahIJHR3O7csFq6+60ZtXP1FqVLruH1PsXHJHEjjf5dRe9N1D//jdZOiffK2PxeEgxTDreIgIKdfDMoIdjrvax4+VSQ4wt4Ms3GsUYlG1wYBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bZOMemHC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82e; helo=mail-qt1-x82e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bZOMemHC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::82e; helo=mail-qt1-x82e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grfqp0sB2z2yf5
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 00:47:33 +1000 (AEST)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-51c16ac21acso11595311cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 07:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783003651; x=1783608451; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VHZVkcI1dGlitqBERLzcSZUkSvuExam94MObbuJvLAQ=;
        b=bZOMemHCbzOWaB6Yenw3Vp7yJWtwRMKGFvD9sY4ihh+YH/zmngJT2wczT4BdBfvTCh
         Q+9J/YkaRuNSXai/bNn9wg3EDCUTzVFDDhxnaALV/aBR1WCrqsA0ZriDW46Mp1R3LV1M
         Z3e01tAyKcLgbkpCyKfaHP6kRsvoJNOydIXr1ZQbFbaUt8WEsePaC5UYFpM3nlSf05WB
         t6IdP7//YS58jCvIQeVAu93kAo0jBKQo4wWkJefYayZLXd7p3mBI+fDaTOwkcXinmgco
         W8IWp+4heliiNMmCueoTgUNhR7TQ7C68Jh1BwHP1PkjonhiGP7jVFvrN6GRFTdUtYzu9
         qTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783003651; x=1783608451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHZVkcI1dGlitqBERLzcSZUkSvuExam94MObbuJvLAQ=;
        b=GfuYG0qiIXBdEaeGnmVG7BC2A2qxAVtJMbsx89DVj9OU4DDSND5Bsm2Ad2S7jGNlqw
         dN64+Ktg8v0+A6LUjfb36SHNijJB+kcbNQieALlbcxsaRVXdOUxIvzwcqCQ1JOqsCbfI
         Ct3E2aGV9O+RLMxiX3SBvsO7AzhP4IBMIw1qUPf2UNqzzT8URrdDimYqE19pvyHEnSOR
         tjGlEEoIOgSzKp9fNEOllOOLexylzzBGkPEdKY8YddGQTj3uXFogJFJEWib+P7KLoKes
         8X0/A9kQ3XlK1H2KLuLpWAkOXHyZfcLpWxgHsgkr38OkpkBUZBex4BeY0ViyaDhoKnvB
         7wIA==
X-Forwarded-Encrypted: i=1; AFNElJ927UWAJU80DxTUIZ4dyL8Di9Aje17mpoAIJCdmqlG2dhZ/n65qikw28G9f80bwsgbi0D+Rlqt5JebymEU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzr+XDr2W49PLky9nrxg7BD8JTciHDh07ETuA7z6sIO8X7BM5dF
	+J3Zn+SjPUC5aNharEPXN9PyjsLv7Od1itJ0fj/evA4+aOYxwYFwq8GEp4CTydK3Sjo=
X-Gm-Gg: AfdE7ckzavof7jouIvTv86y6rOzIeGWecBRjdt90uNX381jTZDU3WhcmsNpIOKG447J
	IMOTzsVJHY7IiKHzVwzOBLf8IIrGCCHYJVntebzD2cBYY5kQQI/FqJuGn7FAgu6omyLAd1VWi/p
	QaCO6/CkPJw7dDvN/xNiGzUsWMyrdzaZY5SuAR0S86tlYsJ5sjYujhk7dzzA8odly7m/AsXjojA
	tzaoihHb6mmCh8uas3YhNaAIiw4N5hMi+2t5cwfgISn802MFSHuZWL0emYcWcXlE0aTwPEWvN/t
	kIFMXK6RRFFBCaF9DnXSqSBQ6odKKczU7AW6VHb5OuTYLqPcPgNdtR6Vr+t7QjrgfVQNPjW1ROu
	w7WuBrYNhCo48w61UKGAG8DXN4ucSs9P+zq6hwyTPdVvF8coB5G95cXFx9F9qydY92TtQbnF8NL
	zXV5btC1XQO+nQZ8Naxv+T75G2Aq2enZ3pPgJAvYe2zqfvftbqyjI2bEiFRY7XgBdLiGk=
X-Received: by 2002:a05:622a:1b92:b0:51c:1ec5:d0f with SMTP id d75a77b69052e-51c2aebaa70mr65534301cf.40.1783003650663;
        Thu, 02 Jul 2026 07:47:30 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c30c61857sm15516901cf.28.2026.07.02.07.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 07:47:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfIhN-00000005tmX-0mNc;
	Thu, 02 Jul 2026 11:47:29 -0300
Date: Thu, 2 Jul 2026 11:47:29 -0300
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
Message-ID: <20260702144729.GP7525@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-4-aneesh.kumar@kernel.org>
 <845d0c8a-6d51-47aa-8e0b-8381e733444a@amd.com>
 <20260617154101.GE3577091@ziepe.ca>
 <25155bd6-4348-4aa8-ba70-0a882fc84db9@amd.com>
 <20260630160242.GI7525@ziepe.ca>
 <98800d21-18f6-44d6-9ba0-da9b77567d85@amd.com>
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
In-Reply-To: <98800d21-18f6-44d6-9ba0-da9b77567d85@amd.com>

On Thu, Jul 02, 2026 at 10:25:16AM +1000, Alexey Kardashevskiy wrote:

> > > not externally available so I'll have to trick the DMA layer into
> > > using SWIOTLB (which is still all shared, right?) as I specifically
> > > want to skip page conversions. Setting low DMA mask won't guarantee
> > > that the DMA layer won't allocate a page outside of SWIOTLB and
> > > convert it. Manually do
> > 
> > Why so particular?
> 
> aahhh I missed "pre-". I need a way to get pre-shared pages for my
> sev-guest activities.

It sounds to me like you don't, what you are worried about is
optimizing the dma_alloc_coherent flow to avoid fragmentation and all
CC architetures require this optimization.

So I'm strongly against you trying to open code something in your
driver. Use the DMA API as-is. Propose general DMA API improvements to
reduce the fragmentation problem. It is a real problem.

Jason

