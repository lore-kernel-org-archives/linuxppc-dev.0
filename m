Return-Path: <linuxppc-dev+bounces-24207-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E88C44501
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 12:23:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzz4C2dk3z2y7W;
	Tue, 14 Jul 2026 22:23:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::82b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784031819;
	cv=none; b=kS13wdcRtyqpAWUzIbt77GgwQMrSQ5nNlgfNc4NZ/0yR5/IGjiarqv+rCkmNK9DPpc5ZHVvDul4mJyLa1NjMkQXCgMN9y2QjmQTM40tdMq2FP90VaEcj7fbmCIQn65waAbG/mtDDeZI5tOE6hcvKaapolnkqUuJdcQgK+ops5SQh5llzjQ3frGg0pGOgv0Ig+kXz6ogRj5UY77q97rbmLhikA2oKtRYGmbZeh8G1JvhDLEDi/XW5Nm7lv2V3PR1uLmawpYcLJU8As5jD1zaNlfIfjYQYUlBXrhHce1rs7MsFAG0IKBxJMTPU+ohZ5ryfC9HID+UVdktGnqPtui2VYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784031819; c=relaxed/relaxed;
	bh=XrBPfnLDD8eQ7eCQ6RhRSXn0CPQXVWcRtTZW3fZ/anA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GECEiD6d5D216knftYq3PaPf2ByJ0L6sY9vv2xanC7QKeeco0aFRFUoPxxwVBOBVBuTxlnJF8r4NRRoQmz1YlXNiaLXqd+ELBxgdwLWHyMwFgkO/iVMnKwfpPZrZCkvQBmmXi0dImQgyDi5y2z9ZUw9Glbwyx5gIhcOFKeugNbSX+j7TDC82D/D1vaoT+32m2Ig6mOTpDHisZ4NtTcZtNb4zAWJ8LVyxco95VTIf/gM+ZFsvmedoEj5NMqNg3LaReZ5ptddD9CdtEYKea69WORoTJuyeoz+HC/k8F4FenJ0JeLV4m2EeAh24vLvjUZUdRygPpOjJT0JQB+PA9NvDvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=arxRPcz8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=arxRPcz8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzz4B2nGVz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 22:23:38 +1000 (AEST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-51c167c58f2so28277271cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784031816; x=1784636616; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XrBPfnLDD8eQ7eCQ6RhRSXn0CPQXVWcRtTZW3fZ/anA=;
        b=arxRPcz8mnc6clnNaT0TI/eww+vB6K/jAthZvt4eMosJfOgaRCZShBNHqG6LCDTl54
         65iCxw5UPa2BbouldcgMZfI4+jfn4/obR2YmSUBPn6n8Yy75OmgvMHl70VLxuQEST5Yp
         sRqAjsqet3N91yoc5HAxkeUnxuIp2hdITkaNzqmbAwWa4gKz5Gua6cUhrIc755m3dRYq
         YE/U6e6sSmTdG33wFrN73oJn3XCdp3KB7oNmS3YNuopKbttqwAgb5C2LALGGKnTxarH0
         H2sT5/Wup4MPnOosNsqogo99XrxIPJjRAYYvtvTkM7j8di9S6wKBrRRharrb6/Fy61rU
         bUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784031816; x=1784636616;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XrBPfnLDD8eQ7eCQ6RhRSXn0CPQXVWcRtTZW3fZ/anA=;
        b=X/R9ouTqW+qyl8wyxZt4WIGT+yKvJugt3PDKeGv/k6AWNLhbQpzliLJ8p67L5Pel8F
         m3owIuDLQgXextOjBrojxuLOER0NvJY1/P+0ZvXm34Cyj+qnmjEju6YQv4C8hq7g7h/V
         iR2tollAeQvuNoH9lx4yR8Eu2bKiWpLPzeW/vkr2D0qGi+ib5vGstJpKG7g7ddPfKrGz
         dYxDbcQ7YuVLfLcwvaNbzo1abUVMUFMmIK+w7aadUr/SAkuGGKEB6FMfzQ5yUYJ44R/j
         SVeBcsxU9QAiVEaVlQ4zK+3FzxWixfijh0atHWfRT/uH9hyoNV6x52HpJ2hy4mlS0P7c
         /IUw==
X-Forwarded-Encrypted: i=1; AHgh+RrKT9hAtZCRocB8uCgbLpu3vn8iVHz2LrgYmPTGmVnQxagbUIl2uO2AcmQ/cFEmS3WsYWOrv5jLTgXC8hc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzDHyw12C6ww4B5rGnjkrbksYWnJ+pIPwr8TO0ITLM2tibsDz/V
	ZibvkPXa6dySdVWhkapJIhPVIao88wSJdErSHmYHkRkpnVgjubyicA18w+nJZE6308w=
X-Gm-Gg: AfdE7ckIavI5UOES5L/8KtdDktbM6rT30RfpgRwIWt+ypoodKmOZlcE/spvgRcTud0X
	2JJ1+1QCLppj3SOBuDx6Vtc/6eHrHQbDca6MS7uoQegtXnp8jO7GuBHVgq5i7rlgBUKAIYnZ4y2
	Kl0622vtZYOaOCmpsYHiCHPnvSwXT2EL1rIdIqah8IvUrG+1DTYegsjQ1bMH2s9+G4sKFUdwjrJ
	31fLk8pcoe9xkAds9WoAXLbIBlE0pLRtK2537ORXn5KEUJcwPTcYTcyOQamKsSjXiUW6ESoGZ2g
	qxbq9E9s03GwvP6GnA/tlAqjCIVZcNhfDHIZqrp2+9plRI8FNno54H2DAbQ/S/CerCTXhxXsHQp
	OCyyE+rF7REPiK7BdN6+RUTeLWgZjAPVX2YagIiNA+2SEZBXLPSySRb6D5uF0
X-Received: by 2002:ac8:578b:0:b0:51a:8c97:9375 with SMTP id d75a77b69052e-51e42494cb4mr15995711cf.61.1784031816150;
        Tue, 14 Jul 2026 05:23:36 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caacad30asm109896611cf.9.2026.07.14.05.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:23:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjcAg-0000000FRbN-3RTk;
	Tue, 14 Jul 2026 09:23:34 -0300
Date: Tue, 14 Jul 2026 09:23:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
Subject: Re: [PATCH v7 04/22] dma: free atomic pool pages by physical address
Message-ID: <20260714122334.GF3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-5-aneesh.kumar@kernel.org>
 <20260713181059.GL3133966@ziepe.ca>
 <yq5awluymdf6.fsf@kernel.org>
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
In-Reply-To: <yq5awluymdf6.fsf@kernel.org>

On Tue, Jul 14, 2026 at 09:27:01AM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Wed, Jul 01, 2026 at 11:19:08AM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> dma_direct_alloc_pages() may satisfy atomic allocations from the coherent
> >> atomic pools. The pool allocation is keyed by the virtual address stored in
> >> the gen_pool, but the pages API returns only the backing struct page.
> >> 
> >> On architectures with CONFIG_DMA_DIRECT_REMAP, atomic pool chunks are added
> >> to the gen_pool using their remapped virtual address.
> >> dma_direct_free_pages() reconstructs a linear-map address with
> >> page_address(page) and passes that to dma_free_from_pool(). That address
> >> does not match the gen_pool virtual range, so the pool lookup can fail and
> >> the code can fall through to freeing a pool-owned page through the normal
> >> page allocator path.
> >> 
> >> Add a page-based pool free helper that looks up the owning pool chunk by
> >> physical address, translates it back to the gen_pool virtual address, and
> >> frees that address to the pool. Use it from dma_direct_free_pages() while
> >> keeping the existing virtual-address helper for coherent allocation frees.
> >> 
> >> Tested-by: Michael Kelley <mhklinux@outlook.com>
> >> Tested-by: Mostafa Saleh <smostafa@google.com>
> >> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> >> ---
> >>  include/linux/dma-map-ops.h |  1 +
> >>  kernel/dma/direct.c         |  4 +--
> >>  kernel/dma/pool.c           | 54 +++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 57 insertions(+), 2 deletions(-)
> >
> > This seems pretty suboptimal?
> >
> > If !CONFIG_DMA_DIRECT_REMAP then page_to_virt() was used to compute
> > the genpool's addr so dma_free_from_pool_page() can use the same
> > logic, which is how things must be working at all today
> >
> > The CONFIG_DMA_DIRECT_REMAP scenario does look broken, so I'm
> > surprised there isn't a Fixes line on this commit? I don't have an
> > opinion on the search, but since alloc_pages() is used there is 8
> > bytes in the struct page that could be used to store the remapped
> > vaddr to avoid the search if someday someone wants to improve
> > this. Maybe a small comment hinting that direction would be a nice
> > addition.
> 
> Something like
> 
> +/*
> + * FIXME!! We could avoid this by storing the remapped virtual address in
> + * struct page and using that for lookup.
> + */
>  bool dma_free_from_pool_page(struct device *dev, struct page *page, size_t size)

Plus some if (!IS_ENABLED()) that does the direct lookup

I would just use : not !! :)

Jason

