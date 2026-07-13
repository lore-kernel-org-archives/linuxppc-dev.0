Return-Path: <linuxppc-dev+bounces-24140-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77108C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 19:32:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzXdg1LXBz2xWY;
	Tue, 14 Jul 2026 05:32:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::82f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783971159;
	cv=none; b=IeC/338bnzlTiBr4ipy1fnRZ7s32iXPlvCZjeigkTtzL3AYdYnPRRXXtjS10XbC/U0ZCkcX5FjEIo/r4xZ9foVhaaDdNlrvcX2m+voUq7YiPllfbJu8eO+nM3ik9N9HdZgKzWidUiWpIhTmsZbFD/dRP/ZsbgppgfI52ov73WPY87BOxd9H4HzkCXcy/UiRyljnFbA5zGbdtZiZxK0tD37hFpVshuqVfVX9hQtFseZExggcZaUNkrxkCcg9SQC+imfJ5qHa6lJvQ1rfOJERECA5nm9SMUT/OWBngERCsGafwfhxqIKtljupXhsVcbL1EJI65U2dqvIV4OXt72mWLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783971159; c=relaxed/relaxed;
	bh=hGsZNW66zFo4mTPQ6ULtWG3KXt/fdlFbCgUmJIue0mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ux+vPki1nkydYyV2V7ZZ74FtpxBzoABkuhB0Tt68Lsy0LCvOFO2eYVh3Eh2jfszil3k1idNsfDDNKB+tCXbW18UjuDg0I/QGEqHrqPHF3hG25anrd1Em2CNgxjtbSbubjdv/TluTGIufkImSd8pMdDsRBViIgufttcK64N6vYYCxKeJtxp2fQSNDCVIoI+tcKjgSAWaph4SHvmy+FAktQspXHLV9k1X+5rm3vgCceMDa97S6E2cfEwHw12mvCXiJFmKpVdaC3wY9Darwg74/82Y3odv7Dj9L8XLCpa5LlIkIR6kmSz9vQ1rOcASesF5ohqhu7ldyuZkRIr8RnldTmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=BsmQ/71/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=BsmQ/71/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzXdd5rg2z2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:32:37 +1000 (AEST)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-51c8e2e39easo28023571cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 12:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971155; x=1784575955; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hGsZNW66zFo4mTPQ6ULtWG3KXt/fdlFbCgUmJIue0mw=;
        b=BsmQ/71/LE15VEy8JkNVxqmpi1E2lvfN+kYCSij5DVlDzIe0tQ2JGFvY75xLkNdpSN
         CpFGJG1dZKmMSYHvi8gq+AzpdWIXLJkO+zolnvPBlhjORz95+qviqVcjBwtOjd7TpgBt
         N8/ne+C+e27ZThihnSI77jPRyptFLMkD5JSXBUIexZ2pOIZjNA3SiiFKN4KPmx2Sq1cc
         pOLODAdc5k8Gnwg/aiD/XrCwlwMH2JPXBgre/Kny1QnuU1nl1K1btqeCw7weFKRMaqEa
         PjDDOScc1aeDOMdn4QG+7SyGdZdyayaFunEhk2ApjVpxDTwc+cxdzTqTlaAJroDh+Xu+
         AXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971155; x=1784575955;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hGsZNW66zFo4mTPQ6ULtWG3KXt/fdlFbCgUmJIue0mw=;
        b=ln7MLIRGHxB5c/x1bfyj+UZlqdD3/vL+Hg2+eTLGkzd7ocC/n/lrSN/OZmZkHQqm0A
         f4YdIx+eREEdQyLvX978CAaIR1Jziof15FS4tX1h/AQndHlJa2juwUaoOz3W3XX6eefe
         8YbOgHl7swCyjHa10Uh31PgRfOLbNmyWlMBnBf3flOBIGLPgRfU7bc06qH1WFU+MS13j
         8i7emiJtMLUeOKz+iuLDGlWQqPLgeoTCV9SyxvIRkkdoWFtnEdCbaHV3r9w0RVKTp4tZ
         bOE/wpbzeTpWZg4DgfVYfO3jEdhUZ2HHbupCEe5ckz2qmIp0OcLUBijvJTOi8jDSUjeI
         +qZw==
X-Forwarded-Encrypted: i=1; AHgh+Rrc/q4JmmqdHXoSIuTy4zgnq9kqaCtAUGOoML6rNAb6VVlUgLSpDDftm0JFbwRAL3OZBKc0OJlCbEVj4/0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwtwKmuF8sneXn0YKGB6uf5MgEEtg1rYxjkhTy/xDxrX+Zh8VcA
	GtXB98ZMsxBUVa+5IGVBleShR1kBZ1XZD919JbiKBa8U+aXidyc1hDYTKkmhbfnrhZc=
X-Gm-Gg: AfdE7cms3gqRttECtu4iAYrg9P3VWURmKMXKYEZ/EjLOIIsnlgzZPePu3ABoqNhJDpV
	sw4vLGMDCM6CLU6t3P5bOPf85SJSjyxK8Z7JAnMU/KeBLfuA8GnbpFu47L5tGemcE+LCgA8B6q2
	9eRb/zFGIUnFxVzs0dncfURZgUkp4xN27HnElwIKUFHamgozCZA60PWxIebmrCmg9zZJSqBPL5c
	tjtEw6vQowATm3RCjmBVPrVUyPgcmMVP3mOvoLGQD78t8a/njgPeNQcONArPVj4jIjIVplQaB/6
	aKS1RShmBW8bvtRJeo1QOZ2/uIjgi0PB9DizAtFIgGdbdWMsrkkvFrfiKvp0bh0GZqxZV7OUAqI
	8E//+aryOwcSVMQ2sXMQXtjk7Hlrac5p5brRelTG0TCtRi1WdMfYSc91LCijL
X-Received: by 2002:a05:622a:1b22:b0:51c:18e4:38ab with SMTP id d75a77b69052e-51cbf2ee945mr103155851cf.66.1783971155509;
        Mon, 13 Jul 2026 12:32:35 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1ec84sm138505026d6.29.2026.07.13.12.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:32:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMOI-0000000E5wx-1usj;
	Mon, 13 Jul 2026 16:32:34 -0300
Date: Mon, 13 Jul 2026 16:32:34 -0300
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
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Message-ID: <20260713193234.GV3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260701054926.825925-17-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:20AM +0530, Aneesh Kumar K.V (Arm) wrote:
> @@ -88,37 +88,40 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>  {
>  	dma_addr_t dma_addr;
>  
> +	/*
> +	 * For a device requiring unencrypted DMA, MMIO memory is treated
> +	 * as shared by default.
> +	 */
> +	if (force_dma_unencrypted(dev) && (attrs & DMA_ATTR_MMIO))
> +		attrs |= DMA_ATTR_CC_SHARED;
> +
>  	if (is_swiotlb_force_bounce(dev)) {
> -		if (!(attrs & DMA_ATTR_CC_SHARED)) {
> -			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> -				return DMA_MAPPING_ERROR;
> +		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> +			return DMA_MAPPING_ERROR;
>  
> -			return swiotlb_map(dev, phys, size, dir, attrs);
> -		}
> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> -		return DMA_MAPPING_ERROR;
> +		return swiotlb_map(dev, phys, size, dir, attrs);
>  	}
>  
> -	if (attrs & DMA_ATTR_MMIO) {
> -		dma_addr = phys;
> -		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
> -			goto err_overflow;
> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> +	if (attrs & DMA_ATTR_CC_SHARED)
>  		dma_addr = phys_to_dma_unencrypted(dev, phys);
> +	else
> +		dma_addr = phys_to_dma_encrypted(dev, phys);

Maybe things should be adjusted so this can be
  phys_to_dma_direct(dev, phys, (attrs & DMA_ATTR_CC_SHARED) 

?

It would also be nice if swiotlb.c could do the same

Stated another way, maybe we should get rid of
phys_to_dma_unencrypted/encrypted() entirely and just have the bool
variation since that seems to be what everyone wants.

Jason

