Return-Path: <linuxppc-dev+bounces-22746-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97210CD98E2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2026 15:41:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggSkc5339z2xLk;
	Thu, 18 Jun 2026 01:41:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::834"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781710872;
	cv=none; b=b0wekYZBdZs/QJBV71Gu4tk3EDLn7qlQ+P/gXinx9LdvtNeQTL0WnoAdBm0T8KE7Ykd+NtRX9kA+IA051OIalG6RHSCcZgBkmcFCEHNyCCRgV/M+nnfHgVfnmVw5hQXfVvQloBpMcFO0AWhZmCxb3Rk17QaCWJAlPWslI78beMHy2eb0K1SqcmMwej+2x8HtALZUpvdQDCaWB21Nb8XRVYJXeIKKYpizrCullm+2SE1eXLGoVwyb8GbQleqTFm7FD2oXOleBdV6vghsZGuOuaSMjKKWsV541ryXfmQUN5z5AgK6azOPmWBdMOXoiihcWEnA+V6XDpCooCDYF3Acplw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781710872; c=relaxed/relaxed;
	bh=ElWjBVhbO2IQzO43OlPWnTyijSop9myiCxf+4rjWyeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPiF49vMUTXd3sdmdYoAsOoCns97M5wlpySTqYw7uMxBA7Rr8J2UpUnb4Ot3DD4MjC71aLa2DVimyIYiU9buH5SU/MejgLKxfOUOuNmCAXqZLcH4AdnfCKL/HQJAfeL6+5UImQ0y+OCufbLb++e+PkKU++sLPWQFBNC0pNpp47J5tIDimyg4f/QT47RQXNd13h0uLZHCnr0pW2TCMmWugi3m4OpP0BISQ+VBuFCb3QWm7KulfXmM/LYstnP4FQPTK8ddFNaLwcmkPx0ZMXPTgFzb3XDtKoWQocVZ0cE+OOD+tmqhswngFgsvKIu36HOhwuwYM6GwND06g7FRCL4T7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=OCskk9y6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=OCskk9y6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggSkW5mhDz2xK7
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 01:41:06 +1000 (AEST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-5177945a22eso43758131cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781710864; x=1782315664; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ElWjBVhbO2IQzO43OlPWnTyijSop9myiCxf+4rjWyeA=;
        b=OCskk9y6t69Ew254Ty8Q+VBqCry/fGd7fXMtfwjBmXOayIIutld3lgwkjJ7XH5eG/D
         kdWUm46RXspslamoP9LGEScuhNdPQ3seFZZLYHFo7Q4tdHguhPk0q0jETQFUmyxc/45i
         f7zzsJnaRhCVkkQJSts6P42cHTipFsW+7LixxxxDZ5pgsWc2ekwPReoyvUMPQ9ZY23LP
         LJhPX5P64TEAYPgwwcSBmgKvUE8S30TK09dvuJDm1Wsp/4LjV3C47ym4m/oCmy80U3CF
         aq7o9B7FEt/QI+bGsU+s+lcBRxPYGgTtgF4QDlmdZqeCgM3Nz4WrEWGrjgW5MQ+nrpnI
         lywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781710864; x=1782315664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElWjBVhbO2IQzO43OlPWnTyijSop9myiCxf+4rjWyeA=;
        b=FDXNf1rUlGupZlbUxi2zv5+T+fPOFdtTOHPhbuxdS2ddZCHdqvp2/zSTZNJm5N311q
         MYz8x93yqMcXigwEAeK4sEQ0zluxqj9+cF13WmfscsI+fbN0JY042qtMmKWDgxCIXAEC
         ZYm0hWo95GcG//m7T90eODlsHo4+z1lzUfOLMD74cXsFtCRqg205g8W+mYaWDZq7mD0P
         uBIK5unS+i9sH124c7WHWgE7hfrFQi3Xj9qt8JeDsGLSNGsPRjKOIABF20Ihigeo48yL
         NWeyv2SBlRvd79b9V20VxHTgeqfn2rng+dobSBzvI+53p65tEnTnBuKLU6tugS7Ov9OS
         h7FA==
X-Forwarded-Encrypted: i=1; AFNElJ+wl3Ds+CYTXhHgbfg4gNw/3vGB7sUF/ovnAJjHiraSfYpZmbjB9IIni0g4xJrg7CpuT9WX9xcaY3E8L8E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwvwhhPETxPpBuFSRz1D6JU2uqbcX306nQtZegUKwu+D4p897eC
	iW1M/l5aWVCt3G2NYAVN55E6SL1VNmOOKD9FTe92UCENacRA+BP8aYDFtTfw7FDDjQg=
X-Gm-Gg: Acq92OH69IkPQeUsS+2cfyRZeaL3/zCOdgNCgTRgXWpmhWCllwxlAhEWOwCmxe8rMsX
	mIrHOrXU1xbYhl4zPGOrWJVnCn1FHO+Xe+2Rk9ASC5ADlvXltCt/0ucMzcZdl0fq0HA3JK0TLVQ
	wVbTnn/9lA+YN4LFIB+8LZVHnTXUv1a8k3GsR8cAd+PzgJEp7/2llB7JIKtBknshXkSbU9UW609
	p6pySGPuO/uRUeGcMlIZAqFP3pML7tzBzPQe3srZYj1snhIHKzKfvKGcM4l5eAWPEQyng1aErTb
	llJ/IbPspL4vGCCef+SBEq6yIJ3c8O6DmKeAOyTVLQimtQJBFewuHfgVu7+q4xRhrxGeughM4BY
	30ZRMtYQL1vU1wE6M4QzO3YVsElb+wBoza92VMx9FH6MMwg7z8vDYsCgWl4xUeDm8UUkvUTv4N2
	Dy+wn8ISLKXhW67bYRSbWSmgR1GBjoQip98Qvz4rC65vdgavQNMznx9WJFXaebzbq3tcdhHy2fm
	6nSkw==
X-Received: by 2002:ac8:638b:0:b0:517:7620:20f9 with SMTP id d75a77b69052e-519a8e01895mr53967651cf.19.1781710863733;
        Wed, 17 Jun 2026 08:41:03 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7a3c4asm171544001cf.14.2026.06.17.08.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:41:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wZsNx-00000000iiO-3Q8i;
	Wed, 17 Jun 2026 12:41:01 -0300
Date: Wed, 17 Jun 2026 12:41:01 -0300
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
Message-ID: <20260617154101.GE3577091@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-4-aneesh.kumar@kernel.org>
 <845d0c8a-6d51-47aa-8e0b-8381e733444a@amd.com>
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
In-Reply-To: <845d0c8a-6d51-47aa-8e0b-8381e733444a@amd.com>

On Wed, Jun 17, 2026 at 10:50:39AM +1000, Alexey Kardashevskiy wrote:
> > @@ -193,16 +193,31 @@ void *dma_direct_alloc(struct device *dev, size_t size,
> >   		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> >   {
> >   	bool remap = false, set_uncached = false;
> > -	bool mark_mem_decrypt = true;
> > +	bool mark_mem_decrypt = false;
> >   	struct page *page;
> >   	void *ret;
> > +	/*
> > +	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
> > +	 * attribute. The direct allocator uses it internally after it has
> > +	 * decided that the backing pages must be shared/decrypted, so the
> > +	 * rest of the allocation path can consistently select DMA addresses,
> > +	 * choose compatible pools and restore encryption on free.
> 
> Why this limit?
> 
> Context: I am looking for a memory pool for a few shared pages (to
> do some guest<->host communication), SWIOTLB seems like the right
> fit but swiotlb_alloc() is not exported and
> dma_direct_alloc(DMA_ATTR_CC_SHARED) is not allowed.  Thanks,

Then setup your struct device so that the DMA API knows the
guest<->host channel requires unecrypted and it will work correctly.

I think this is a reasonable API to use for that, and I was just
advocating that hyperv should be using it too.

But it all relies on a properly setup struct device.

Jason

