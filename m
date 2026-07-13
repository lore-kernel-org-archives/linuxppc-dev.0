Return-Path: <linuxppc-dev+bounces-24117-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4D3C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 13:56:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzPB84TPGz2xwN;
	Mon, 13 Jul 2026 23:56:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f32"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783951008;
	cv=none; b=UH2vX+0xAo5Xlzck5QTidRJlBQGTP82NjRiMRZD8QEQG36ztlvkfMZWIpxfRD7uj2cXclewRrFs2zdsDhVYpWVK2Wy+Jbx01+eOCy85V0vHEk0C/Y6Tayn9g/enXJxTJeZMaNf7zJ2Gi/AYQS6hP8XBScHC6eOJPynhaX3XsLiqsmeE4EM5fWdQ2Uxg6kRX/ORFwu2Hc0uDvouMSXctaJYhjdv0YrkIEXkKMCfhy37bLFhsk9sNe0fRwJsaSDdJvahLxR8ylw4BMoSaCneUKGuEjf8yz8BGMpm804//FzzXdv0zmZmPg8dbsH0bazyV4uEADU1aFCPMW8eqVMCUb4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783951008; c=relaxed/relaxed;
	bh=dThHBkWDs48b/2hz2YL35z2V9VnPq+MKY/40ZoZ5a/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AN3U5dm/xNhl7Ol1QBl49VqV7n0X1CWo4A4HzUUqGotwx9/6aBEivmk88UBdN1kZv1fpq4qDlM3F3a4vmzXYaKyMfRL5uedkBrNH3/3bxzDQHykapLPwzla75ue0hOoPZI/26C4twYdqV1xKrqMXz8c1egXMTYvfZySdePHRiQUfxWX4RHiaC3eGfm5qTA2LYUvukqXEHbJBOysTFBGzsxmj4ovQsa2zDtkGiuKLfIZEOsr4nJsLxWmGqmscWdOHKuyLE1QPnRZ3wCsevhGIwPfIEGJqnznkK6DYvBUQT/QawZOa7AKnjdf2p8Qv6AW7etbrC4tQaTcXonD28Bj1MA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=TQrfqSE1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=TQrfqSE1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzPB31z9Hz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 23:56:42 +1000 (AEST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-8fcc43c48f7so27401496d6.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 06:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783950999; x=1784555799; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dThHBkWDs48b/2hz2YL35z2V9VnPq+MKY/40ZoZ5a/U=;
        b=TQrfqSE1z2hgvHg0t12xhNb2BLJbhdYev7/tSJYn7oF1hatqKvHivLKrK9zMcGdT+n
         rf/uRmPkspQ/BH5Ksk1qtn0GbAP734aZBH+OPn0Y5A83mbCdUbk59X9cPrmVqskX0ife
         +lhedLkOlyJSCYy3DAcojYlnxrNXAqt4ZXEJGp7a40fPHICg1ZcQsus4suPgeYHWrQT0
         6XUtGNLdXPSUJTpSXSGH2ogc75m7gD4/EcBwCEdB95cLFCftudEQouoCdbLitJ7Mr+it
         3eC5KTiFXM0dJV5w0/0TmIetT8HTluTY1nLM9nUSZ8mP/DWxEkNLA9MiW48Ze52MfyZD
         xA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783950999; x=1784555799;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dThHBkWDs48b/2hz2YL35z2V9VnPq+MKY/40ZoZ5a/U=;
        b=MMI7pLVLrrV/080qwFBRy8UPkdNxolUbeNGO5cuQ/YUubZT1n9s2F2RbjEsIPfb4eC
         I+96d9e4s0RPu9pXCMwMwiQWX7E99YNUlixBy61u5Pw5/doFJKbY4/P3CwarxfyWqvqK
         I7f7xIQ3s3Gh3bz1Zz6f3PUQpC1T/r32Hy0HH7s71joqnPJ1NKWNd/tMzSWAQTAE7usX
         VZdPJyANWYx0cIYBu0VWpHNkqrZZHVVG3xv2lRCrs6dNyHkdsyW4VB1YJYhpzoCmfLB3
         H+rbi5UZ7lt+GHrymoVhaVI/baaSJa+LvrG9WuM+5tzG+uA9IBk3K7bUlhafNcx1SYeA
         rn7g==
X-Forwarded-Encrypted: i=1; AHgh+RpclhCEAXD6RrFX91bOD8soibSOqE4TIhABmRbnxQ0/BBOwPr/4LX1ed5qrkg+aiCVoPYedR6eOQewtDZA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwEW8i5BCVnH/ktOqV+36oXBbgrYRArfu9GAYd595fM06jH4sWm
	h3Wsg3P3RwFqo//ONruUmE7tikLdfbHw22FefOgkt0XWUU6HGLFEBWcuC3iQlBSRUBc=
X-Gm-Gg: AfdE7ckQkZzSoQrJjB+fSTtwDgAese1qTV8fVRn1c59NDzIYOz0EYSoCtNP0TaHHbQ3
	yjTmhaJMj/ihBT3f16T3ITQ/bn53QnRgige/CObuxIf/viTs0m7pP/BcKuM1tEqj9TmymXatHXX
	cBIE+LZzRFNh2Ha+dVLJC5hBrrFh93lgsUZbLFjjAYGS7+rO4ObFUypVI063ChOGQ8B9ouEz7VN
	bhQM/XKv4wZ5qF5hVulmyGZvkwxIwMd8pHxLf+unYhpSYRkfoJaqAPtllRTRQmW6UFVTwZh8Go8
	rRQp8y5n/PIrv+WDxMu7jh2FOgPC6MYQHUQNZR4b8B5zfCNpLP0+/JX8Ugb6+RdiUfz0zvUyqzF
	HueP402iiEKLbbFQaR7o51Uim50PLcoWITm+eSZLgzoGcCh9etHyJGiLd7cuX
X-Received: by 2002:a05:6214:da9:b0:8ee:756a:f1d3 with SMTP id 6a1803df08f44-903ffc638e5mr98221496d6.28.1783950999687;
        Mon, 13 Jul 2026 06:56:39 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd81f4bbdsm126704796d6.36.2026.07.13.06.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:56:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjH9C-0000000DL9o-26N7;
	Mon, 13 Jul 2026 10:56:38 -0300
Date: Mon, 13 Jul 2026 10:56:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
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
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Message-ID: <20260713135638.GB3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
 <ak42F240d-53QeFN@arm.com>
 <yq5apl0xgy89.fsf@kernel.org>
 <ak-CT3oanlDfgTy4@arm.com>
 <20260709181336.GM118978@ziepe.ca>
 <yq5ajyr3h106.fsf@kernel.org>
 <20260710161945.GO118978@ziepe.ca>
 <yq5atsq6hdaa.fsf@kernel.org>
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
In-Reply-To: <yq5atsq6hdaa.fsf@kernel.org>

On Sat, Jul 11, 2026 at 12:39:49AM +0530, Aneesh Kumar K.V wrote:

> > But if you really want to it should be
> > cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) *only* and get rid of the wrong
> > force_dma_unencrypted().
> >
> 
> Ok, I will update the changes to so we preserve the previous behaviour
> for SME?
> 
> 	if (attrs & DMA_ATTR_MMIO) {
> 		/*
> 		 * For host memory encryption treat MMIO memory as shared
> 		 */
> 		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
> 			attrs |= DMA_ATTR_CC_SHARED;
> 	}

I'm OK with this, with the expectation we should aim to remove it when
fixing the callers.

> > But IMHO, I'd rather this series treat ATTR_MMIO as private MMIO and
> > ATTR_MMIO|CC_SHARED as shared MMIO and that's the right and correct
> > thing for the DMA API.
> >
> 
> If you think the rest of the series is ready for upstream, could you
> please ack it so it can be picked up for the next merge window? I'll
> repost v8, rebased on top of the pKVM topic branch.

Yeah

Jason

