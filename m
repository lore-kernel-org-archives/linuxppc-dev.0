Return-Path: <linuxppc-dev+bounces-24141-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68680C44501
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 19:37:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzXlD0vMtz2xRw;
	Tue, 14 Jul 2026 05:37:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783971448;
	cv=none; b=iGOH0yiuVYvYlXaeWbteYqQ0dAKYe1RZ6OzVMqmX3jpYzk8L+hzUhcWMjb01t8BYbg6xtOuFfEn+4JOO0goYJUjKwciYYqXXGNIW7wWdvvcZ0y0TNUP8LPqlNdN1ZhgJJxVLlZpGJxdugz/7RONerGsVHNvZ4fnk+3iu3GCHk6x3hhxXs2HQa4bVOTsFaKYwcXpUJ3h3+SdCALSyDRtda/3LmGh12jwZKCWY6iblZoQh3kQjQh0v7YqfNo76Zi4LImS+QTie5fJs0Qhz8aKfvAY3q3H7Wg5Gt/862As489Z7+GRKNtnMnYA5vGEu1J2vSpMqS6Bmt0T3qMf1jCnIZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783971448; c=relaxed/relaxed;
	bh=seRQ4x7WCVBDlRNvM1ESoBfWnXSVwL4ZPJ5Cc52Vq54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkPuZjsBoIMZ0gsRd1ETzYebdXZeXCeFQuEopEhI6PIyllBTDHiL2XbvO30aQsX5YpgXI6r3UdiEuyZqU33cCIwXTlsnYZfNIUFVUiqNpcluSgF4jaULNtUDJXrKxJdTObMF07WOYF/N89ppQiQndU0kHg2gQb4tbIrpHE4Z6mJCSn4iLsYCeC77bzTL3/tJzWxde8vT0NFWgA354ADPXA2nPwEUJVCLSqlN6PoYglccMToYmTkTB8mYKlCMT5j9ztnu6PT/Mz8bHJ/nk6m91zqo7Jmnci8C+zEUVDbNi6Lq/i5DB42oDvMq+kw0UYebMwKIUNnwaBOBXDs3OS6BKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=QBGWtZ0l; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=QBGWtZ0l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzXlB72t2z2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:37:26 +1000 (AEST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-92e5d50b0dbso16345085a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 12:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971444; x=1784576244; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=seRQ4x7WCVBDlRNvM1ESoBfWnXSVwL4ZPJ5Cc52Vq54=;
        b=QBGWtZ0lKCQ02vw6oFVaLbodRL+x3C7tnSnrFfnCS+1nilMP2Drh28yjps8cnD4lv/
         GVyy3fstIHQ7wuvCYyzMmXkmQza2WKCBO4bjZE+5BBCHBxhs0r/slpm18QAiH18xVGmx
         UAEJEvUNQVjsWSgObrcfhc4HvKPO+ehqBd+QzN+FMsPaFulFPa2PSAd9m3PDMRhFmRKW
         r8LZnpbl9oUif4krYJW3tOX6kYGLb/YAHz9NfGXEQegEEVf2VqM7uO6UikNyBEfplBWG
         bDeC13dHVmVs9kJk6bWBdiWy6TfwvMTCgR6HufHU6JfCjw41rDHq/SHCuryEp0ZeiH5i
         oqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971444; x=1784576244;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=seRQ4x7WCVBDlRNvM1ESoBfWnXSVwL4ZPJ5Cc52Vq54=;
        b=hvMjD8wj/xT9u6dySt74byDSIT5FcA27rpf/d9HpNaR5eO1YNVUNCOjkYwUwvJtiND
         19kbQpsG2oWDVcZPyteREO+WfjVmrB6FcAAgBiaSmF9ZjzDaE+fDjaYwbeTnikk0bH9M
         lRceATnBvrlL4m/ZqGFIHsW/pupNJ/nt6CQiFPXIqO5QGQwN6i9NEOjT9k5blxRY3GfG
         tmjrvITF0Lq4YhAm51PVjCh31UDQDvRwEmiYxDNvplXy9lqGKMkKYR1x1eFag+ynid3U
         ReF/6uMsGsPUGZY0qD8E/XgyC1/PnOH/R4wRykbq0ojc0dcUD9eiTens+G69Jnw071L+
         rezw==
X-Forwarded-Encrypted: i=1; AHgh+Rp5FjNZpe56DfNWk2SeKwpGJYS2VGbuE1gz0JNPS5Fp723ZtBxzz9vjoDzsP4xeERVh9ZT6v5S/kDq2khM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxWB88BWiT1a/ikPLP6NFI7H/n0RKD807vyhWWCj+sc5t3RLNN2
	kuu8z1cEu0ymM4DvUXO4/h6RNYY4iR3C7nTS+qgsNZ9Lyrb7HWqrz2ByoMMXclww8xo=
X-Gm-Gg: AfdE7cnCef8LMy1H1kYXs8F9sU/9jsgZrjsHlKC88ZHZVIa9zpumTj7Qb6yqgaPjfBg
	6mkdx7YE9iHHbmjLRqGaDvWgBrvt+VW/rnYCnK+JDOQpIm2aE1fXxPlxbsli0LCGXpNIojLlFY+
	bqA+vnNy5w3gXENLG53bI4A6k/0QX1GbYUgj+HcXDvsRk2pTU6ChMmSk6NeXe0yZT24pAEmskE6
	2+EDDHJdr9cg/kojkJAJa0+B9QcGqHIsVxkBoH11AJ9GHVY/zxh27DRE7xLvpkj9gEIwCphlD6n
	VIBYujj3CDbkJ9VpgBgdVvYkkKVA0kBV+/XG31Ktxfu8q6sDtzpWPcjqyL9plPpoledetpi500X
	5OCrG/6mY8SMH21CvcWfLKJv6MdWeT+26MfW4A1fM4lJ6wjqZ7Qs2oocWUcB01Meappl6zaY=
X-Received: by 2002:a05:620a:2551:b0:915:5930:94e6 with SMTP id af79cd13be357-92ef2bcc91emr1112783085a.51.1783971443832;
        Mon, 13 Jul 2026 12:37:23 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b86276sm1177578085a.11.2026.07.13.12.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:37:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMSw-0000000E6Rs-2gqS;
	Mon, 13 Jul 2026 16:37:22 -0300
Date: Mon, 13 Jul 2026 16:37:22 -0300
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
Subject: Re: [PATCH v7 17/22] dma-direct: set decrypted flag for remapped DMA
 allocations
Message-ID: <20260713193722.GW3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-18-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260701054926.825925-18-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:21AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Devices that are DMA non-coherent and require a remap were skipping
> dma_set_decrypted(), leaving DMA buffers encrypted even when the device
> requires unencrypted access. Move the call after the if (remap) branch
> so that both the direct and remapped allocation paths correctly mark the
> allocation as decrypted (or fail cleanly) before use.
> 
> Fix dma_direct_alloc() and dma_direct_free() to apply set_memory_*() to the
> linear-map alias of the backing pages instead of the remapped CPU address.
> Also disallow highmem pages for __DMA_ATTR_ALLOC_CC_SHARED, because highmem
> buffers do not provide a usable linear-map address.
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/direct.c | 56 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 44 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

