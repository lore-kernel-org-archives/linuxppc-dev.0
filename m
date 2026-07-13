Return-Path: <linuxppc-dev+bounces-24135-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2A7C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 19:22:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzXPR3tTHz2xWY;
	Tue, 14 Jul 2026 05:22:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783970523;
	cv=none; b=KhzNafY67p+mG30nRXZrf68MGz6OqgMdcaXNflsG4AggJQscfPrQhYlIZ3Xbj+twD/yOuTG2ccWIXxBF1vimxk5MX6TrBgzCB+DHcc5bAZW0LnoMfFyOXI0xUH5GDfo1VbvMD40KZan6VUgEJYBp2zCQ+W+mBiE8zlt5XGSwmKDAJgBwnarynETETXam7CF7JdWKm9FBDVrzZyRjugkn9FQYS/qeh/nQeda4k1bgMI+peCADP64t7+cBNPw5bwa7RtEVNwpC4/s2D++Jkv1zgZzPkZBh7KJYnR/U+MM0bELCxTME0w9NoZ1dWVltk1ZsFMb5YhC0yI2UcsrvuqFtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783970523; c=relaxed/relaxed;
	bh=Kt1NNWVp5vzCd+THxZiV4tdGJLfhiT0ZXPz0TueqWMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYp24wx4ZccFGQ0OOXEsrf42HIMjZbn+7+eXxUD5l9cm9DbtEb7AFmiOWTkAQ+xxnx2VNBJ7kEpewdeRgPkw3Q+DufkH5KMMQSbJt/aT6SZBm1nYVVymhdJbnAJXPHS1kRoOLtJFtio+tvO9CTDchTmUU+HuU+Y0gsl+U96IrQb+U2rixsq0UYJB3SaigP/DCO5IF0xlJL99UJxJEMA2fjAFa+sYlnVvSu4UqkBIalZssQaW/pM5KxGMCCz7vsU2ZaJtoyzFr95Tmx3dyvPE9d5Yl8QCm7PZZ8ixIZat3KCClY745ixVuoPN++pQB4awRJbqEEHXav/QscTK1eEfvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=KwZsvayp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72e; helo=mail-qk1-x72e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=KwZsvayp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::72e; helo=mail-qk1-x72e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzXPQ38ysz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:22:01 +1000 (AEST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-92e55b62640so204982985a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 12:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783970519; x=1784575319; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kt1NNWVp5vzCd+THxZiV4tdGJLfhiT0ZXPz0TueqWMw=;
        b=KwZsvaypWN9GfhrpPxgSxACXrW/mCSZLKuOYnRdqot0JX3l4La0S2b3PjlUENLkoz0
         c291UMG9tDVZisobGpXEHoyKFASpqs0bajudauixxl4d9Ginh1hqHeZNAGnFRkz/7GeD
         th/IDbIU0XifNbCaimF+BjDJJ7jYtkE/yCn3JtCClVul0lVwXM8mGTO0rGNMtjJWHVPB
         8fvUGfQLvnTPiyJ2xZDMKAE6XXqoCJza3hlLNo0e8+h1bRzG5Hucaaxcu+FH0U+vDeUx
         hLzskNqx1KcfdVehvt0HKYBT82usMbkln/I36jB/qxfulgMNlQBv9UEBGC1dlPcPdUHa
         R0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970519; x=1784575319;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kt1NNWVp5vzCd+THxZiV4tdGJLfhiT0ZXPz0TueqWMw=;
        b=eClxgg2zgIVJ7s8saAXVh4ygZFpXCHrvrE0U9R/tEI6GpOrmrG6971qoT481vt+Iwe
         iP6VYsYz2kNrR9wmgc98N3+TZALjKe/4m5yakzZdo/uPTIzSB51Ql6wk3M+F57D4jhDs
         pKwUK8w2sqz4a83QQZEIQbeiq8bxzDpOj7mZx+89B9uSW3ycXnhi8VcVDGm1Ux1NwEtM
         A8JMDduJ6qQbY+2KAqN9RYZ5llKJMuVmWUCJv3jLD8hmvmUDIusIxuUL/QBu827LdEGM
         CtCaIMW8b1vSO35cBOpEGrz35L/R3rRu7/TitUhXXeHCgZj1Sd7qRNlSFc1a/isHWjDa
         bJRQ==
X-Forwarded-Encrypted: i=1; AHgh+RrF5bTfQ6wRnkKrOyG/vldij43oBkZDwX/pPUE8Vlt+BzWLZGwdHyhyzjrp1cp9tvC6QhcKFU3WDzuk1ro=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx6c6DL0icQRqlefTsBL0OWDThndF4xNhxewozGqGCfLWO91kJS
	66A73jKXAnabuU27GiFgi9hrWfjcuVk7wLPUSDqY5swhMtu15Faq0w/yOIDEZ5ZZo6w=
X-Gm-Gg: AfdE7clEO+B3oIRTf/nsEZjufYNxhT5GXwRSiLcVBIPM15L9WJIL95Dq9yLLgq9wqRU
	IIVYb7U5w80bxlDlW//e3VBhBqdl9VEQjYR9RJFOufZmKbtVrFLa2ewAOzK13FmgNyQu5T0JrnE
	vIb582LrpFer+B0BRxvqszqX3O681n/uk9DvveT5YsoLCTEUujiuB+HG/b2fGuyIUqiMxqQxtkR
	R5An5yM62z5mtMN4n4v7UMJ7E8WADqLSXNeGR38JTEMALmx8EySQMnW3oiaLH86j4RNG/iZPMgd
	82Ie1JqlGNnan5nk3QICxXsYg58Mkt7cwR6zefntThoOcQsOrtEqlPLr9eEZYhe32Dfvj+OsUtY
	6SBvnOhPKIW5mQexgEJsbunSDRX7lchyU5OFIJstEzQVCvq1ofIEtORLp22Zx9Oo2BUZbVUs=
X-Received: by 2002:a05:620a:44cf:b0:92b:6805:eae0 with SMTP id af79cd13be357-92ef2c0c787mr987778485a.61.1783970519182;
        Mon, 13 Jul 2026 12:21:59 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf7ab2sm1122922585a.30.2026.07.13.12.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:21:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjME1-0000000E53O-3cBb;
	Mon, 13 Jul 2026 16:21:57 -0300
Date: Mon, 13 Jul 2026 16:21:57 -0300
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
Subject: Re: [PATCH v7 10/22] dma-direct: use __DMA_ATTR_ALLOC_CC_SHARED in
 alloc/free paths
Message-ID: <20260713192157.GQ3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-11-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260701054926.825925-11-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:14AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Propagate force_dma_unencrypted() into __DMA_ATTR_ALLOC_CC_SHARED in the
> dma-direct allocation path and use the attribute to drive the related
> decisions.
> 
> This updates dma_direct_alloc(), dma_direct_free(), and
> dma_direct_alloc_pages() to fold the forced unencrypted case into attrs.
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/direct.c  | 42 +++++++++++++++++++++++++++++++++---------
>  kernel/dma/mapping.c |  9 +++++++++
>  2 files changed, 42 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 0cbf2b0835c4..98e47e0b332d 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -192,16 +192,22 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
>  	bool remap = false, set_uncached = false;
> -	bool mark_mem_decrypt = true;
> +	bool mark_mem_decrypt = false;
>  	struct page *page;
>  	void *ret;
>  
> +	if (force_dma_unencrypted(dev))
> +		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;

After going through what was left of force_dma_unencrypted() once the
series was fully applied you might consider something like

  dma_update_attrs(dev, &attrs);

To remove the frequently duplicated code

It is fine like this too

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

