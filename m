Return-Path: <linuxppc-dev+bounces-24137-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2ACAC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 19:25:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzXSz1RRrz2y1F;
	Tue, 14 Jul 2026 05:25:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::832"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783970707;
	cv=none; b=hJ1S6TWSHpqLVz7ROuFx9HQzMAz2hDnazC1k2ZRpW1J/b6vDEFCkVvev5PJZmpd0ncjNIbV6t/lcaPPvLSWQgJ5KsM0iJEr7j0t9aZmUDUi0Ykr+sOjhhZpqvjH57TxRvImFg8kbDC/dy9sg0WpIbFWNMnZWGmK0a28QSwIkFmVPFrbOZVPOr1ThBX0BQfXMIMFGzHriMXlrmdkgfXT9/AtTQUpa0u9O44k1x3qw8uT5O3qu0X2W9HOlCiOPdSgcZnYnFqAHyLw09sybCbo9hRVyMwunDth4+ctEV8kzMTbcxf846lU6yFq/EHXf/rCgYZseU6aRiE8Q3cp9Rn5Euw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783970707; c=relaxed/relaxed;
	bh=2kWy2240zOoLDDzwtKisgk31mZ51kjxw8fZyoUW4j0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SW9Ynh7retYBDePKtQXoxFwGXa0OTtNkqnbnWdpOqJ3icKoGKWW3iz+bD6jxmHFxD0QDcC4ijO7xJVHLv//Bur4/MRxcQvhy1uWz8pLCz+jgQAcNDBZZ2KZruiXnq7U9PbukGcV2spFZl3mdyZ4A+zZnrVw9D7kXk9jzv/alSrC0gbqo4kPkXAUBUc4h5KNsR008RAbe3AeqrVJr6RFFXUydb3CM7PxLd+Dn71XW+MwRjvjvIc898BoFL4TDXUSNo+OHQ83Ory6TlHaANbrMLyL0SE9VTaO36uqRauHdwsXWkh8vnit7N3hQ6zoWVYv91D1Nqe9diQI1dJlHJ472uQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=fCC3mLTl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=fCC3mLTl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzXSy22spz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:25:06 +1000 (AEST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-51c08df8513so1660411cf.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 12:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783970704; x=1784575504; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2kWy2240zOoLDDzwtKisgk31mZ51kjxw8fZyoUW4j0E=;
        b=fCC3mLTlTeeO3NbZIUQvdzJayktw/wGLdz9wb4ngpqnaqvgcZsKxPckfUYGu1VMs+r
         Kq0hX11gfj7o6IlD6I7n3pnJ9SbWLRGgpvd0h15CETO2Kb8gklGrbC9m6B2wprAleZYt
         0Qncc39YqbSTz41Yq28Hto67ENKzLHkqDAv9dz8k0w3omeR4ufMetHYlxQ/6Mc+7g6Ii
         VIbpu8uA+iyykwC/pUXaYrHCqEv8BI5QE9dYfzIjk4zOApwQ6k2KhC+fSRY6JdyuzeB1
         Od7w6cfFChTk6pLGyifWy0enlL3fP3ER+0r+fWMLcHk4b/bNYs8XgHz/lHEd+6sSplHj
         zgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970704; x=1784575504;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2kWy2240zOoLDDzwtKisgk31mZ51kjxw8fZyoUW4j0E=;
        b=Rk3pdMUkVgt95GQUGfa4X7rixmLhcsUINZrrF4R33DWfqTDP5hSrtcJfx1sAXJE4qN
         xK5Z5FKSLLuhPRcRQfhAHseUECjZrDsSFet/hkWQj9h1KJmNOoDvHebp41Qxt7Qr0E+W
         AC4Dad/4AWGxXP0/MffizJhIy3tlXO/kv1AErfXNuJW/Sua2wl0KATngXgDI7UKEkn5H
         HXWpuTEY4+onR8nvO2JMy1ZwwfSjKvK2GQtI6uEvd4ozpWrt/2WxmP9bNtW1O3UEhRIV
         8WqdDXVLtFUV0tpX4MhFLbqP/o09Ymdhd1bDdS2+LzuJOKr95wEnEPBVNmVk5Gt3Ks5S
         nF2g==
X-Forwarded-Encrypted: i=1; AHgh+RqxSNh7hAOXFDwLxTHjqDEW2MGgCHB2i8eHLJJVBAJd2pS6qdfGT7LUz4/EquDlMytFWUlGlXaL4chXdFY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxJizWsuoz8OJG8L1BYSefzyvA1FY3vqrOvaZlGkUD5Nl5xeUnv
	k617PWnV2Ttj9iYzWMavUQWkcXZSbDZhBBvg8lr7Pl4ilMXpw25ugAuJRpazZDt9dIU=
X-Gm-Gg: AfdE7cl4GdzwPa5My6GXcVHhdhjhfWCWnoHipyO3VLayHrz//5kWivlDftyggTofBAg
	nYzOOb4huNibzKB71UapOHcNZj2bLTcK+sflkZ/KBAIJKSJO0vngiGI2Z7eLIN3LCroKR/77LT3
	PpQux3EWWC8sC29WCJI9BRykd9fFzFCBGECd+c2xYp0U7ykwgp66iAzECK5w/bv0NeDtbRTeUQn
	GD3h90F+P54SxMC6Et1gnV4ZYOxci+Q3K893CtTHLCKs50EQv6VUCww6YVWkVs9m/cjy5Jzm2iJ
	P2CNm2ao693FHpy+Ak+M5odwGWyS7Qsmk+WofqfnGl1t50KHZYADITHej5wHLagEC7gAIuCA09m
	8GJP2Hl/WYcidobVm0hzegM8IDEjzPL0r2N0OQZkrMGMAt/8W1AiPaD+OoRBC
X-Received: by 2002:a05:6214:2f8d:b0:8ef:76c:cb18 with SMTP id 6a1803df08f44-903fe450e81mr122377626d6.11.1783970703547;
        Mon, 13 Jul 2026 12:25:03 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1da1bsm137170026d6.30.2026.07.13.12.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:25:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMH0-0000000E5NW-1O3S;
	Mon, 13 Jul 2026 16:25:02 -0300
Date: Mon, 13 Jul 2026 16:25:02 -0300
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
Subject: Re: [PATCH v7 13/22] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <20260713192502.GS3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-14-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260701054926.825925-14-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:17AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Teach swiotlb to distinguish between encrypted and decrypted bounce
> buffer pools, and make allocation and mapping paths select a pool whose
> state matches the requested DMA attributes.
> 
> Add a cc_shared flag to io_tlb_mem, initialize it for the default and
> restricted pools, and propagate __DMA_ATTR_ALLOC_CC_SHARED into swiotlb
> pool allocation. Reject swiotlb alloc/map requests when the selected pool
> does not match the required encrypted/decrypted state.
> 
> Also return DMA addresses with the matching phys_to_dma_{encrypted,
> unencrypted} helper so the DMA address encoding stays consistent with the
> chosen pool.
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  include/linux/dma-direct.h |  10 +++
>  include/linux/swiotlb.h    |  10 ++-
>  kernel/dma/direct.c        |  13 ++-
>  kernel/dma/swiotlb.c       | 177 ++++++++++++++++++++++++++++---------
>  4 files changed, 162 insertions(+), 48 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

