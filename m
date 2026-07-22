Return-Path: <linuxppc-dev+bounces-24664-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149FFC4453A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2026 19:57:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h54lw2kY3z2xyj;
	Thu, 23 Jul 2026 05:57:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784750236;
	cv=none; b=I3n8Xc+Ylv9JLP26ZbXftvgif7iiiIBtyR/2qO/yTU7HfQABwgh6Ag2d3QqpODqNQWdKdrnHQ67IhRNXWvBbclxmWTm/nQfWYHDkkUhO9Wud60A226EaMR07SCy3+ALHY7SiShoZxAlgyJ1ad4SaVyKMN2Hc2rQ3AB5xEylqEKn+Ss83oUYtswiSgE3wN7CzU8p+JSqcqmfk8VFnqRAUKXBcKjCN9m2amYBgYXZzWd/hb6txw5H0V+7kHNi0/6tqDyeFMfaGnwS6bSxzrX9N9+mDhLErfQT2BB7ECrpa/HxQTyHg+Z+5T3QCPHRsBB6fN2E6SPTnS/Kthj+LWmd9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784750236; c=relaxed/relaxed;
	bh=N2NbIgCir1Hq8D+FOL5JeKeK13r88FeOdRS8YSok+dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yi7Zv2qGQJPhMHRkhUNS46EYj8AU9RHRMW9e3FKZKsZ0H2DTNXzSzoyDGZh1ZMOC0CZH8pUUtPRc4Uo7QClFMaZVDdC/Un8jFYieUTzk4g4A5Ol3eICQ8LYYlz8BH59sPtZ2BbqjxSzwZEphSi/xhG2Jtd4dpfyGO+jv5kc3fZbDw3k4jaah9A1fT5+0MzXWWBUn4E554yZOOtCdJ8FAGr2ZsmaXVW1RWurNnpdwPBEXkvFvS94YY742OCDpP/r0IaH5iIe4PoV+V4HjjpHU0X7xeiCMMmE2odTwjW9rg6zeIdYF3hVm6jGiQITFI0PgpMoYfjyiLrjATjPDZV758g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ndJEnSfc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ndJEnSfc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h54lv12lhz2xLh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 05:57:14 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2cf452def93so35828945ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 12:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784750231; x=1785355031; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N2NbIgCir1Hq8D+FOL5JeKeK13r88FeOdRS8YSok+dE=;
        b=ndJEnSfcjCFa1o4gdIYQ/YU3bvjFP4M1bZoEXAXrOZPu/ufjAGmqSxI/8K+RiIV3pZ
         F2Ko0R++8eg+ZJeqJeCSxgetESl+Ep7VHG7rOfKjjGzuz01GuCQ77OJjpCAqkzhA0N6k
         iibo3aG8+Ax5G5lGClX4Wm7PfUG3KoCHVQW1uqsarYwJgpqh72nfgtvepsqdcHG+6ZRt
         VeIEjL+PJ7f7rfH8MRoQfwdtEafykmnHkx1S/gD902DyNR7c8OIiHmoprDRQH3trdQA+
         mAjX1dIrcsxw6QWvE6W6it3CRuwUg5g00S/oOkY6psn6w6v6ELN/aO5+rvreT92Tqhcp
         Utig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784750231; x=1785355031;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2NbIgCir1Hq8D+FOL5JeKeK13r88FeOdRS8YSok+dE=;
        b=SKl5c4PQ/5owG0b+szzawMl/0kVt5jxm8x7hCcj5JM/TcUzv34u1kaH6ZTsGMRL3Tk
         NSDIRvS+HmBPcw3RF5fL/M+neMbTxIVxn04QjeEom3tvJKPYcb/ljgkuOBlv9aEZU3aJ
         vTtGhJlD3wDslqqkDDUQExud+V01QDBR+yKaOQVrYYsOarAVZq7Vs4GjDSvwcdXGO4xb
         o8hLSc6Ik+973zazX726E+2oHdLYwSa+iwlNe/cyT33RToOv7FJMUJnALmTURfRW2+T0
         LESE7qgYaAoZ1tY/gs8ZbFaKO5H9RA1iGJmD3PmJi74kAuFg1pk3nf/AzmOgoAwgis5h
         K0FA==
X-Forwarded-Encrypted: i=1; AHgh+RrZDypkqgOvHcHzpW87Q2tAjgXYkrB5jRot7weFfgn8cS89QO+wNwb71/svWRQlruYz6/FmymE6cGPYnOI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzdU1/s1SzRqGUtjoBIsHMQ/2RStKQugybBG6qKZVvPQLb/6ISd
	JIBDJ/Tq2r7+DbDawRMbjYNJxZbrFv7F9JwKx16hsdzFiwprse7XFU6JnfTxHzKzEY8=
X-Gm-Gg: AR+sD10y0IpUnNulbohWiFACG8wHRU166CAwEY+F4HZmSUAdDZYHf/TDlESWe58tMnM
	FCUwxwCTgJMpYYp7zuFKl4KWr/ylNnSxR+FXp5TpEq7SF49AbzdOsm1ixIkk6O5kgcvkTuTROVS
	jii+hp68Y+/VoypM3UIU30VJdSnq66eazFOMd27uzkbqLwwLRROeywlI9bVqiRXwBOzaYeZ1ZEV
	XkMxzcqKdn2NmRBT62KK86ttum9pXqKzIQBQ/uYWoGXacq/xnGR+yICo0nZ5Fz8Fc824Wk8MHsY
	J2EmIvEHny0ZZHFviLibfGNAqf7nneCYuB/DpaZ0JeebT7064DlskGN6kMGFsLrNwscvSyfugcU
	PKrGYaO8kcrRalyJX4f1N+nN+m9ZhKCPetSzm3fMxyreXlmteVtbA
X-Received: by 2002:a17:903:4410:b0:2cb:402:70cc with SMTP id d9443c01a7336-2cf8df30504mr51520965ad.28.1784750231136;
        Wed, 22 Jul 2026 12:57:11 -0700 (PDT)
Received: from ziepe.ca ([216.228.115.8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc6162csm11833170eec.7.2026.07.22.12.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 12:57:10 -0700 (PDT)
Received: from jgg by NV-9X0Z6D3.localdomain with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wmd42-000000002HD-06RY;
	Wed, 22 Jul 2026 16:57:10 -0300
Date: Wed, 22 Jul 2026 16:57:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v8 00/23] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
Message-ID: <amEglRH3u6UFFnIQ@ziepe.ca>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260721124056.GK110966@unreal>
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
In-Reply-To: <20260721124056.GK110966@unreal>

On Tue, Jul 21, 2026 at 03:40:56PM +0300, Leon Romanovsky wrote:

> Why don't we continue the effort to remove "struct page" entirely
> from the DMA API internals?
> 
> IMHO, everything not exposed to DMA API users should use
> phys_addr_t, including the DMA address pool.

The alloc interfaces return a struct page, that is why this stuff is
organized like this. Look at dma_alloc_pages()

There is also an API that forms a scatterlist that has to be struct
page as well

Jason

