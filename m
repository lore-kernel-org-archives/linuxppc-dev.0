Return-Path: <linuxppc-dev+bounces-22338-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0E5CD8CA4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 13:26:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZV7F4Sc0z2ytV;
	Tue, 09 Jun 2026 23:26:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781011609;
	cv=none; b=Ev6VNNAZbnfwvlv9D/nKQaDTfTyIJ7DFYE7Qb6hTf7D2Cgpucdli7gdXcs+l/xzmxZq13fKCSnU7z8cw5s7OdtrRZC5W5NxDcAEFZRr/KAKOngpVLNnKYfaVLm2DAbMjEhKVJbFVKuGNUA8fOFSpYIl6na2p20HGCKzgM3huoRxiQ5gQLPCvxadKV0VGaqwsSNrblMR8ITKxju8NzAwa2mazadAkLxX5Z7tuEc7rjsWDAdBqfugicqmKZqmQQoeypJdJyXidnD+XNzBJbzgELYV9oMbqcB46P0hdxPZoIJwf1gKqIB4PrpjizqrJsKVW7cKYKl12a6ouciVfmEJL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781011609; c=relaxed/relaxed;
	bh=5Mb3ECCQF4KDrnD1oEZunr+tebvyQKuHVVgCgeE/hK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gIDj/sgTM+7IiLHJn70YOoFjRF0LT1qsLGavR/ZYvp8q50ANPyv7Q5+pde9UiGa70QYjnL1cwqLYnYa19DTkiRPq09YmbiPcpc4OqFlGF5Y9POCyN+Twn0sv0TxBoVGP+uoxl5Ooww9zBgfh38i+7VgE5Yv8X2OxPZgoIcdG4D5g8xZQKDN7K1tn2qabP31X7Vc6UwGNApAnDPxkbIyJcxddGz+MlMWSzNj2EAI4F9iqC0dT5hjtq9XP1QkiScRvlOmV1inga9EPqNB0Zbma7VmwjYweUqny2ZvTdDq2GAx+sgEeCgT4CavHLE1+GUCeu1qiFD+tz0yEEeHtboZe8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=MsnuBIzQ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=MsnuBIzQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZV7D5Ccqz2ySf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 23:26:48 +1000 (AEST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-490791a3e92so7709345e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 06:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781011606; x=1781616406; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Mb3ECCQF4KDrnD1oEZunr+tebvyQKuHVVgCgeE/hK8=;
        b=MsnuBIzQKj7dQfofHi40fWDp0K3PY8kRnblu0hx/2+iJxX8GP3Z1eBGuKxicNV+Od6
         WBDLJOCKn+qF8wo4EXqM5xKp43E7+c7R4J7mcypNz+e1L+Koz8BiZjeIB7DJq9dIK1d0
         4KKUKVg51A/fXUyQxjhtqoVNxjA1YRrnmU5/l547Mnzj+RW/Mk9M0815+Ahe2xSL4kWt
         7FpVMVkfaAMwDq6nB+9WItsy+2wnYNyLhOYOPtUyN1tQ2b4jW7hyjYeucyY85rrJIZNy
         ln45ugCJ/ULWojg2B9XoNRD/4jhm4rQxKTQ9rw0N9aaNoe39aw6xCVCOk2mufmjMXOOL
         JCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011606; x=1781616406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Mb3ECCQF4KDrnD1oEZunr+tebvyQKuHVVgCgeE/hK8=;
        b=F/oxuwKjqHNPid3ezc3z6URZlCRIF4Vzd92d0SfLLGvcktQE0K/rL0AfHI2bLXBTPi
         kiRLlKecjvnCh3DwQjFY2vSUiuqJcDc+/sVE8x8fRCqp5DtZJwTkB/E2pnA5H59XcATt
         5f7bsxWLupdbTZDFQXnTn9fR5Fjp3Tjr+pY6ksZUyucjv0FqZiyZTjovSKFMlm0urCXj
         8PfNlU1Mj7EqcvXZkUb0+tayzWoGy0K2p+XYdfrXad+djT9SZNnwy18rnUseXNApiZHP
         0BMTX5mYfIgSPd9ccfFFTyuDHPwXzx4xXday4dejZJ1/ad/Mhmmwnb2k+urQesba5k9u
         5TIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+HGjlPkksy47rPW+51C9sFtv0CTpVCdNgT7s8f9vrS527Qxuzbyvz6O0juMuFXJzjlCc/tp+DIZTYhwwc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzJNMudRnrgDEGnsc8CjZXE0159q4yDrtMf09GX2eI7KVXAHex5
	8c9fewpsCd7dWVlSlOaThDnp36UuQCL1tyRleRIAdGys8L8HtjRVkHkCj0/p3vcVwuU=
X-Gm-Gg: Acq92OEPYtjUBmksQoHoY+SxS7vv8T78ykty/3OEzvcBRJ1DUyceE7VmvbA/E0QJ7sq
	PoDHh413bUlAQbJsC0UQKVtLTB4jln22jdYAZQaHsPwFEpvLSiimH1qABPYsSNMeCXESbyfs5J0
	/ShESN5QodzkwV1lD15pYYBTf5txBqZiydjfpyr63Q1v8OhXdoZZSGTFW/K7MatSayvQlUQbW6s
	StyxtIl3X5oLEZqoLHZMgxdXzehgrD57XEShsFHb2cU4XYTKpcu6xPnAq8t12kbeEmYRLisI6ND
	3R3GMUPe4rWl6EBtnMhzzvXYS101UqIwplyVXjpXAevT3LW81mPivzWLEjw8zXXFzMXOWRebs6A
	p8qMjSeC5UirrCU4jMNIifCU7TNnVnkN/BWCKCiqnne0TRG1LrkUj3UKi5WWabTrS5wwwO5itKv
	fWzn6rs6P/aaoVdakc4lugOKc=
X-Received: by 2002:a05:600c:8705:b0:490:3fdd:d344 with SMTP id 5b1f17b1804b1-490c25897eamr150306735e9.1.1781011605912;
        Tue, 09 Jun 2026 06:26:45 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39def5sm469464095e9.5.2026.06.09.06.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:26:45 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:13:54 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Will
 Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price
 <steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Alexey
 Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
 Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, x86@kernel.org, Michael Kelley
 <mhklinux@outlook.com>
Subject: Re: [PATCH v6 15/20] iommu/dma: Check atomic pool allocation result
 directly
Message-ID: <20260609151354.534bb18d@mordecai>
In-Reply-To: <20260604083959.1265923-16-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-16-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 14:09:54 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> The non-blocking, non-coherent allocation path uses dma_alloc_from_pool(),
> which returns the allocated page and fills cpu_addr only on success.
> 
> Do not rely on cpu_addr to detect allocation failure in this path. Check
> the returned page directly before using it for the IOMMU mapping.
> 
> Fixes: 9420139f516d ("dma-pool: fix coherent pool allocations for IOMMU mappings")
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> ---
>  drivers/iommu/dma-iommu.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 725c7adb0a8d..52c599f4472c 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1671,13 +1671,16 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>  	}
>  
>  	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> -	    !gfpflags_allow_blocking(gfp) && !coherent)
> +	    !gfpflags_allow_blocking(gfp) && !coherent) {
>  		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
>  					   gfp, attrs, NULL);
> -	else
> +		if (!page)
> +			return NULL;
> +	} else {
>  		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
> -	if (!cpu_addr)
> -		return NULL;
> +		if (!cpu_addr)
> +			return NULL;
> +	}
>  
>  	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot,
>  			dev->coherent_dma_mask);


