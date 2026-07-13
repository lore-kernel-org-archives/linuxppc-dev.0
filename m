Return-Path: <linuxppc-dev+bounces-24128-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8A7C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 17:57:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzVWf2wL5z2xLg;
	Tue, 14 Jul 2026 03:57:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f2e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783965438;
	cv=none; b=HkfKD4KVNMTa7C0zl9YjQt5t46nW60frzpKSFdLvb5/5TwFKMHx98G2Ab/ddx8RuhPMvbYv4tQRjwlmMAyBQ4uOzqnPurEdAw1eBg5/yyncy0OVtUJebQmtyFVkuvCC72Pxbi4kWsKHtV9tSt5Mk9ttHf3sjbp5ooFnfVpMbF79IPnmBMrLZ83uxTxYxJGrNgdYd8psPPFuUybgVnvT80mK9yiYcAwkp8SKg4I54L14QXPr3V4a41/aSVHmPKtTG9RNtJak9FY/KoOrQBFz9aJvXOeRwk5JjSxYh2OlEYBrnUaEV03x97huMAPE74ZNyWTJ9jpD9pVSGAoBtfjvPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783965438; c=relaxed/relaxed;
	bh=YGHI47Uk7ivYjDw6pJp4pRueuEDSB7hHUc7Dm7encu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQ9fdextRP9h6WCy+Wk1hoidoCw7z8LrQmdavOC2gXkP09ffyIuzIZyUypM1p+gGP3tw6rX+0v9hbKNP+Idv92bjI95spODrQVNRtgWqz9Fw7bu/uStji5jVcwBQY/LG5aQRnn1tFQivwV0PYnAG5nwxEvYEJbYTEllLg8HcwLtOKgi4gyggotlJ6iSYa2IIOiaHTd4K28xIQ9zaUcOMr3UGn0rcpUtk/WU8vch3UDzVuiE0xSMhgdeQcBTrXh1q0IP6OhuLyBmtrT5dfDG0KqD/rAexy05xB99bcIMtozIE4Cg0YdnC5e767eVGaepYMRzYahb70lv1VyzLfx1Pig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=naerqkYJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2e; helo=mail-qv1-xf2e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=naerqkYJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f2e; helo=mail-qv1-xf2e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzVWd1rJCz2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 03:57:17 +1000 (AEST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-902f92b8504so26291216d6.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 10:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783965435; x=1784570235; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YGHI47Uk7ivYjDw6pJp4pRueuEDSB7hHUc7Dm7encu0=;
        b=naerqkYJ3STp/sn9mwCz5wCAIlek6ASxBK6B+AjVjwP3DSJaUDkgnI2DILlIBuNP2f
         YK27+yX2O74hI7IUZNhspGnjqElEbR9aG0L9X2IHD3LYXN88dis/i3pnXJ768Yyb2861
         +7Ly65BeZnO+YLSg1oKac1IuUS6pp1CHlbU9ErF4F4EFLhFRk+rELUH9zoM9yH1yUUp1
         uHhemvyM6P2MnQUIvB5BhPoaucrwG67+7xI7geciAAIkVa1iaF7u/pdKi+C90VK2Bpmj
         Vh4aT/Ud4EF5y2Q3CJ2pWAclHl8Ot5EIb06IEgjEJneebde8FdXh+OC/ADnyYoIKmIoq
         NvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965435; x=1784570235;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YGHI47Uk7ivYjDw6pJp4pRueuEDSB7hHUc7Dm7encu0=;
        b=c1uNWRW4K7edXjnZZkvPQ4iSDQ0pnlu7bMWNJrIFS/RY/GR1qfzs9vmrO7Aojbq+z6
         f2gOsg9AmN++yoA5nzAtcl5gMR0tD5EmsAfDbkC1By1U2C0zIkDU/ei2Z8mnOIb9r1Zp
         RQGpsqt/IZCBlbJdfF5BgtZpEO/ka24XdwHHCHWUoZ826vSpKDZY74n+ABTPbmNgL9oV
         zIfdy2G5+R9bpLP7wbBQQkE3sTlZyUjhK66WLcAYK6EnkFEXt99pQGgHYFDOggULc5+i
         2Px87pJkaoNsZgc86UlJcKTjaxEVzUck5SDd4Bo845MgC7rWyMgXYPmVi0pj0QqG14kH
         +axA==
X-Forwarded-Encrypted: i=1; AHgh+RrCeX6n9qER201/Jry4y0UN293A5x3nqOcO53UGsmZfFRBPxyEJahczlMRmZTr3/IPp+2islAnrsmjK/tY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwEMTB2bMzcpRZ3yaU8zqYdsIskL/PpG8QiNqk2OIv84DAvHngp
	5BRtzt1tq+2GK+99OwfSO8rLDE+I8wiT/lnTVRAbQAFrlpkQmfKf6brjwjCbTdf1jZE=
X-Gm-Gg: AfdE7clKfsbd/wJtBupsMz08h51Stq+unesNMv5/9Gt9LEQMuy7KdJhkDA9iG+V6B12
	MHo6Xj0nbnjDxwlzO3fO6PSt9UeLFPneNjuTPbtcXBOLmrzjJmmcYnuH9bVCWzkQtDZZYiKhCDX
	HCZEc0GibuLzcu/n+8mlMyKLS/t8vlN35cL4Q9cwOWItkDaQbBuX5hfAV51frT/MqOQn790Xgci
	ybSS9K6aEheu4rOwxD7t3tTGTlmnz1ChXU1zoyKvjKc3+Yfv61GUQc2Y1cR3tWV94hfuiXZCEtV
	YF1G+gr/MdeB3wmhgmd+yS4QAbNGiaX8citoJRUSMAYVaRwikSV6prxNIEhavyyZV+dVCOeQYb4
	Mg11SjSf21nM2NACGghUr0/IlK+eD6CmxsuQiO1xnQcXWrZ4dzgJ9PmNx4sRq
X-Received: by 2002:a05:6214:5012:b0:8ff:60cd:8174 with SMTP id 6a1803df08f44-904053d8c92mr120238636d6.60.1783965434905;
        Mon, 13 Jul 2026 10:57:14 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e082csm149305496d6.5.2026.07.13.10.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:57:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjKu1-0000000DxAz-2t49;
	Mon, 13 Jul 2026 14:57:13 -0300
Date: Mon, 13 Jul 2026 14:57:13 -0300
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
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 03/22] iommu/dma: Check atomic pool allocation result
 directly
Message-ID: <20260713175713.GK3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-4-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260701054926.825925-4-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:07AM +0530, Aneesh Kumar K.V (Arm) wrote:
> The non-blocking, non-coherent allocation path uses dma_alloc_from_pool(),
> which returns the allocated page and fills cpu_addr only on success.
> 
> Do not rely on cpu_addr to detect allocation failure in this path. Check
> the returned page directly before using it for the IOMMU mapping.
> 
> Fixes: 9420139f516d ("dma-pool: fix coherent pool allocations for IOMMU mappings")
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/dma-iommu.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

