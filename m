Return-Path: <linuxppc-dev+bounces-21242-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4440ACD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 13:40:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLCNZ6GXWz2xrC;
	Wed, 20 May 2026 23:40:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f2e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779284446;
	cv=none; b=hj9BqElTazNV7Q8wTU+m7zxZXn9H1D9pQufSFco/MqxlxcqgFSbdCQgl5BrBKh8eMF9koQqlrtFsUTEqtiZPhG9qbRaCxeXePF0JLBZwbF2AgRRX9J7Snm6c3K3QV0iOKTyISbDDhqKEoMI8Qgphdml6Ryur3l8LxjU1X2C1aGMi2HSCDelxQawzwdJh1KE8MT0REClPSF3lDjeyEHt/uGkPl21K/APAJiI1kBPBj3OP91MJbelDE+6ENG25yWIV22jj3Hp5wMt9GYsYjk5JYQQPlNDO6wQfnWRE96njLA0YTU285Hx/Fzuydi7vZMU6laaVqzm6X2Jew5C86JlfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779284446; c=relaxed/relaxed;
	bh=W+SwQbDLFG0Y+rBu9pL52xRO2ueMe5MsHi84X45A//o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOMsT/sXUmtn9EPQOqUEfhS/db+kXbT2A3FMBuyQOHriwujhy3LHgpxR6NR2DYmDwyKtBVvS3vb3tQWagL64beoJrFd86LVrUB46anhUBW/EaWXS0r6SayUQkYqKBka6DqDClBkwHyQpm74aMYjE3HWm4hSE3Q2Y0RIn0oNIq+aaZ8Dr5UzWjP8pyrkmNT/4TixwyfwO9iREHkxDFIuSK2U1+06/AZOpjtBGQOqncN6qCFmk1XGb+wNc2MmcsSnyfYGiFw61r5wPylqWS/I8f73sHRR6NCkWxWjJMYXaEWy27DYKfcVsFcf1dVdkvSg6Ka6WjtBbRp31QAUB9T1LjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=JNKcIVHT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2e; helo=mail-qv1-xf2e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=JNKcIVHT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f2e; helo=mail-qv1-xf2e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLCNX6Gyjz2xqv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 23:40:44 +1000 (AEST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-8b98482b253so79711606d6.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 06:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779284441; x=1779889241; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W+SwQbDLFG0Y+rBu9pL52xRO2ueMe5MsHi84X45A//o=;
        b=JNKcIVHTvjUbxCvIzhi7vggG6X96RZraYJkpF3fUBglmHuxQpFD6fysRXWFFFtmmnY
         D8tirpU+kmFdyYHgj213Pffk6d+pAnsXMKGxeIQW6fhvmmfZCjcKcEcu3+nwBZZSasEK
         aFECBqy7LOTJ/dcfYYS2zozdEXaAA2NboAel/qwbVNfL19bCriSH1Dksfu2HWXQUe0A8
         qyf4L2NI9viZMFg5s70Vtpva2OMKnK03GVG1/q+wiHB+/7LxAxaVGbOUYOMp/Hni+IJ9
         3i+/L3Vpx1alFjWSGT+sO52QYFI7sGX1WaYr1wgubInTEZCNZOCnJny6XJlIOGW7XW02
         LbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779284441; x=1779889241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+SwQbDLFG0Y+rBu9pL52xRO2ueMe5MsHi84X45A//o=;
        b=QNCXmTEV+q9UYI94wVeWRrHoccqAEYp1h5YO/FlH156/js7/LsruLUqcM5NzToufQA
         cWWnVwAwgm1sPsoqxws8u5SsOM4DwObdRxhocbTEUuK+A7R3xl/KF+3WypyHeXlm4UID
         ORvpaRTmaBYdWA5KJF0ZuBpMKHYXJuP1PtOU2vkAVtni+1PZT1Qcbh++MVFu9c9v11uR
         MRPiIxCfh3cVjJzZAY8oSchvL4Nn58owaGRpVFGuoPdAFKjTWbjv6oJNHQ2G8xiHEpGq
         8LTReymOv3XLvZiBklRP+mkeZExB9zh0WQj/cFwYEtZLkQkhOQKdVrbhVf9mNn5U4NCx
         Q5IQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ADZVwlBpdq4Y3BA6PryRzFnDaTnRq+pGNuwPM7KKrqz8kmxpe2FKcLner498mOJ6HXUfCYiH4BYVPXjI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxZw45bcHFcpioK6rJ74eYhSiP43bvqqEN6PAUJS6sPGIh3hrVy
	dB8AZRryPcKU2E47QcTR6vvNRmAV3RlMtLcV7n2eYBO6LoepiVm6F2VlRRUyC8nrCV8=
X-Gm-Gg: Acq92OEZ4g8PtMPcfts6dKLW9JSMwFQxsY7I4kSmKiJRtnILJLQwbmNr9SXyaSGhp+k
	YrlObbez83Q4xl/1Kkz9WLlBjDTd+2ZfQ2Pt+Smy1vlJ3ZbJ9XfFvok1Cl9Cie4HH/OulONID40
	HWVP7uyZRnDTq2hUyVpoWPfSeKTPgaFLQ/uULqOtZA/UjZf8uhz0ZJb4P7LvT2S3ChBDGj6GlNr
	eGKZ8Og9A0RKGk7htAoSmX3H6g8NC/TGyQagWRnVmJlskT7UvqBTfXhvFEzZR726WttMzeio2tg
	b+XF1Uyh1zX8wSsAWS7Q5sMM+ZAaokXVxLoJxkeMJyoBZiAl8A3fQcbVWmhMw3qga/GLIr3laXE
	4UqJxsm8fsB2r/lnnd50+a8nSt0gzlpIVIlok6sPgcoJzGVztLHK3w19/oleknHNylbXHVPB7ej
	uSesY2BiJhLS/WInNmQyH4nOkce/XZJ/riyDQ7Z97e+oCN1yVbA3HAmInG1H7mUcFj9CV4JfyV6
	+PmMfgWooflFKw0
X-Received: by 2002:a05:6214:5c42:b0:8ca:16fd:7297 with SMTP id 6a1803df08f44-8ca16fd752cmr347910676d6.30.1779284440966;
        Wed, 20 May 2026 06:40:40 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca360ac735sm122405916d6.19.2026.05.20.06.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 06:40:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPhA7-0000000HB8S-389S;
	Wed, 20 May 2026 10:40:39 -0300
Date: Wed, 20 May 2026 10:40:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
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
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <20260520134039.GT7702@ziepe.ca>
References: <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <yq5amrxvshxg.fsf@kernel.org>
 <yq5abjebsaid.fsf@kernel.org>
 <20260519152741.GM7702@ziepe.ca>
 <yq5a8q9fs7ud.fsf@kernel.org>
 <20260519161120.GO7702@ziepe.ca>
 <yq5a5x4ispg8.fsf@kernel.org>
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
In-Reply-To: <yq5a5x4ispg8.fsf@kernel.org>

On Wed, May 20, 2026 at 09:27:27AM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Tue, May 19, 2026 at 09:35:30PM +0530, Aneesh Kumar K.V wrote:
> >> Yes, that also resulted in simpler and cleaner code.
> >> 
> >> swiotlb_tbl_map_single
> >> 	/*
> >> 	 * If the physical address is encrypted but the device requires
> >> 	 * decrypted DMA, use a decrypted io_tlb_mem and update the
> >> 	 * attributes so the caller knows that a decrypted io_tlb_mem
> >> 	 * was used.
> >> 	 */
> >> 	if (!(*attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
> >> 		*attrs |= DMA_ATTR_CC_SHARED;
> >> 
> >> 	if (mem->unencrypted != !!(*attrs & DMA_ATTR_CC_SHARED))
> >> 		return (phys_addr_t)DMA_MAPPING_ERROR;
> >
> > Yeah, exactly that is so much clearer now that the mem->unecrypted is
> > tied directly.
> >
> > That logic is reversed though, the incoming ATTR_CC doesn't matter for
> > swiotlb, that is just the source of the memcpy.
> >
> > /* swiotlb pool is incorrect for this device */
> > if (mem->unencrypted != force_dma_unencrypted(dev))
> >     return (phys_addr_t)DMA_MAPPING_ERROR;
> >
> > /* Force attrs to match the kind of memory in the pool */
> > if (mem->unencrypted)
> >      *attrs |= DMA_ATTR_CC_SHARED;
> > else
> >      *attrs &= ~DMA_ATTR_CC_SHARED;
> >
> >
> > Attrs should be forced to whatever memory swiotlb selected.
> >
> 
> But that will not handle a T=1 device that wants to use swiotlb to
> bounce unencrypted memory. That is:
> 
> force_dma_unencrypted(dev) == 0  /* T=1 device */
> attrs = DMA_ATTR_CC_SHARED;
>
> In that case, it should use an unencrypted io_tlb_mem:
> mem->unencrypted == 1

No! The DMA_ATTR_CC_SHARED only states the nature of the source
memory, the DMA transfer will always happen under T=1

It is perfectly fine to memcpy from shared to private and do a T=1 DMA
from the private memory if we have to bounce.

Jason

