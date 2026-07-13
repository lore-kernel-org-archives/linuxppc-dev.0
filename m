Return-Path: <linuxppc-dev+bounces-24134-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508F4C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 19:13:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzXCm5GFPz2y1F;
	Tue, 14 Jul 2026 05:13:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::733"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783970020;
	cv=none; b=j7TJz/V/ZPTjTwDV7o+LZaekuY6JBa0HF7FHme4wEA12jVxI4oaP3anDNwIosZ8KeLUE0s5cGJHU6i2YLX3X44d2094B3ZHFyKorllddMEQB8ZCyK9E85VAC2zM9e7Gx2wcFia9luNH7Frtg86q3Y+3UkbvTfvpRWm2ynKmRgehr/V96mwGwDkeIjUe7w9gyeopoU7pW7dvcEjae+q/v2rqdFdw9jmEeDzOwp2mWYb+TjyJVsPcJGpWOF7MXPWP63Ec9BV51USJWB2QycpdZ/7Ufuar3V1C5t2WBXhtoLZqWziJM/EOQ5sPrTPeWYAoxeZEoBXThEDnZ2L5nokroFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783970020; c=relaxed/relaxed;
	bh=GfyQxZTxEaV2M3A7Wuj8sGJT6iMHPBQ3Q1zHUbuKZKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWjKfKLDYd6fEfwE2xDqt1y4JfAz3YuxX6SZIO1z0p+bSJ6madgywdoaZSYGWFjmkfxE+PXpSnaIbuwPXHrGJ61W3wyAZCJmHHwoo2I4FXErDB2CkjQQXUqB0kTq+PNvhlosFgAfOPOxwKrRwtokvZ4qt/qaYLuzzQOs8N/B6g3jrWix9AcnsoNW/5fFjxs1k2Tx9d/zrnY7FvCdp5n6H0Bzfa71TCG9nIat64N/VBgXoLdHaFIy7ralR5xbCj5wKcxmm9+6fhcy1RyhGA69ngee5yAX1pWbN8aL+mCpmrBQj8ijmAxh463xDXsNCJBN0Y5mEPNUpqEb6Lyv6Ph0cA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nd9rRCcJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::733; helo=mail-qk1-x733.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nd9rRCcJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::733; helo=mail-qk1-x733.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzXCl4kRWz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:13:38 +1000 (AEST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-92e4fd65b2bso18355785a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 12:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783970016; x=1784574816; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GfyQxZTxEaV2M3A7Wuj8sGJT6iMHPBQ3Q1zHUbuKZKY=;
        b=nd9rRCcJCNCiCpGFfywXPWt7v2q6HQNtSQgWITsE1vdid7wbAbAZRr/qLo+YFSVBM/
         TwOjxUCs2MhkTu1kU0Hqbg6IPOXLfa6eUMqCFQL0qb6vgSqgWF8wbLlSZmKWqwyKP8ZJ
         bz8NrzKVScRxQzerhXkxfvqB5w129rFraQzRj8dyjdVYszegFkMi4UucAR58ev1LS7k5
         UT3SmkIs2WuCA5Yspjw+LO5+yUrs2bsR5sBdE9iW1NQ4ckos4iA1BHoUDQtwtO661YYC
         2P6kUCTOMEykWUohgzQIkgojSbAFrBdfg4sJNdz/i9UryJsAq3WvHFJ9uo0wISGRcasC
         e8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970016; x=1784574816;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GfyQxZTxEaV2M3A7Wuj8sGJT6iMHPBQ3Q1zHUbuKZKY=;
        b=AgMrh10qdVwRPmKM5qWpZR4m8Hv4dHWX5mCXDFphYydW2MBbE06iTzGn1eC+6Y+vz1
         PUjdS7g2+TKYrBup24vMW1qKCsTNutQRSXYql/DcukZZYtub8Hjb02+XHagtzBC3a6CQ
         MSn37eR9tJf0GqXcFyMBgBovEYRqT3QUYoY2AfpJRIV61wUrtKZZD9HcIrOCt0hdyxEL
         lHLKMJMz75xe9hBYoCA5+RKEEYBhYS4r3Fpowi17el6f3wFS7DRA560pYI8UB0EcwYQz
         GH5WsKAnTPTYs7xq3ahBWrh6UhhTjpuvK3YJSqu0AzK46wdcLVOH3Hh7oXvnTTkDYTTL
         GlVw==
X-Forwarded-Encrypted: i=1; AHgh+RrsbP+CmOzpU0qH43MuoWHLap5Kf/thA9AKvwf8BoWLnQ9vSGUt9Z4IxXbVT7iueJ0PZ8/WaeFoLNUpBbQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzW6ozOOCbHDSRrYtOr1FoW54huOBlRwF538BPiYzQUVirsKYrB
	a6AsJWbf1XPWFU7CWPWD1fXIJn7m1qibdDI2Y8Qf0fG/BibtizfDXEWZF7WT/ESLg7M=
X-Gm-Gg: AfdE7ckTscSlfoFQpoJVAkrs455d9JNXkRnKqcq3OGgqWDS+S08svP9YtA/6jmuq+U7
	j4OHMjCXe394O2aftuzvSgUGawUQGioH0Sp/zNXJ7moejIulsz27twmc2a2/jPejeHhBMgDkMrx
	iD/piCOZ1pclntVDjZ3Ve7TvCqgnVj8/A4qQx/j19NuqxPhUuCWx9Qm9hkJBNGJY8Dba4Hfss0A
	jYPgZnEKnP9HjTkqF+ieo3Tn2zBnf760bPDKzAEzQ3acorbrIQTPGUbd4jHYVLLEYuL2nMbkToB
	KDiVhhyYeVd82A2u4sWtIwHKxsTWC3GntLUQ3ujQbJ3dFXieBHV7A4eK+k1PbUNSIuDeMidXDW/
	I/A9/xp8xhcZAJ8Euq1JeN7goatLgONb1r8KJ8xTPRx3KUPC18EGE/Xbnt8WY
X-Received: by 2002:a05:620a:8908:b0:92b:6805:9198 with SMTP id af79cd13be357-92ef2c69c53mr1083302685a.64.1783970016442;
        Mon, 13 Jul 2026 12:13:36 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5bab293sm1169545085a.18.2026.07.13.12.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:13:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjM5v-0000000E4M5-1cBx;
	Mon, 13 Jul 2026 16:13:35 -0300
Date: Mon, 13 Jul 2026 16:13:35 -0300
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v7 09/22] dma-mapping: Add internal shared allocation
 attribute
Message-ID: <20260713191335.GP3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-10-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260701054926.825925-10-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:13AM +0530, Aneesh Kumar K.V (Arm) wrote:
> DMA_ATTR_CC_SHARED describes an existing DMA mapping whose backing memory
> is already shared, or decrypted, for confidential computing. It is a
> mapping attribute: callers use it to request a shared DMA address encoding
> for memory that has already been prepared for shared DMA.
> 
> Allocation paths need a related but different state. Once the DMA core
> decides that an allocation must use shared backing pages, the lower-level
> allocation helpers need to select shared pools, decrypt newly allocated
> pages, derive the DMA address with the shared-memory translation and
> restore encryption on free. That state is internal to the DMA-mapping
> implementation and should not be passed by drivers to dma_alloc_attrs().
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  Documentation/core-api/dma-attributes.rst | 29 +++++++++++++++++++++++
>  include/linux/dma-mapping.h               |  8 +++++++
>  include/trace/events/dma.h                |  3 ++-
>  3 files changed, 39 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

