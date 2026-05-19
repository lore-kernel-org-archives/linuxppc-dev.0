Return-Path: <linuxppc-dev+bounces-21161-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C252CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 14:04:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKbyb6lwwz2yFQ;
	Wed, 20 May 2026 00:04:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779199479;
	cv=none; b=PpmFp8+DAfY1iaUKtnjKOOwdlLemkDoggvwfxszc9Ox4nr7chqhSsGm3LvzWIStGKwn2ZBid/jKgLwvIyxXGnHBhyxaJTnflswX5bXlCD1AsbZ3o/04UuFfNAigNx620PN1YTk3aAgowJqGExMgaHhdzrHw6craZP/TFABgBwDVIJjHQo3hJWmJsx/3ngMSxxSQTlMHuiE/1Vl85txxjCxAg/IHm30yOVaZ9IUglkNItwT8pOU+7Af0ovxp8AWFBPvIVaozjOHvNkrlFQMhrs62huwEXIQaGpzKZMPnYY7Rwtaw4xjN4+dkQ5gD/h9dzZ52/MsON50841EFJ43ICSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779199479; c=relaxed/relaxed;
	bh=/eckcCpi0xrpFbE201pgVvuYoNal9URjmldCWt34Ap8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxt++fQ9pTSY9NE1HRwHfzzok5LlgLQT+YtuFNXzIKjw2lXdKpITiDPzXye1dU7ZvhB7SjjNIjikyJe/B/Qe/ZVlcSFkKH4VV6zWW4pMpKHykYDu09uiqMTnD6v81G5TrzIRKPg5ThL9C6llI+GvkjS4catMXBuP+51Q+S0F6cJ9uiLAO2yLtGl0UmPiIAIm80lVN3gWWk5S20W0Dj4AH0YzhkYrIjHiZXZjKMtWCHkcCjMMQ7hyjcXpVBPTLqJ4uRPV4MXTyCBHPpUwPSvWjVQqjvYatiKJsk62V0h9qgENp0gcKtIHZdWPvpoL/YO24Bmmk7/bugN3JMqfXS64Lg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=vozE4hLG; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=vozE4hLG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKbyZ1Prsz2yFP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 00:04:37 +1000 (AEST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so3135e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 07:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779199474; x=1779804274; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/eckcCpi0xrpFbE201pgVvuYoNal9URjmldCWt34Ap8=;
        b=vozE4hLGNEV3h4dqaFMyP4JiStasV3OAt9PMdJIS8NAwCwI+XoaInwMrvL1sVKfI28
         JVQc/hxADismQlw9vnn2ahTDpaTwOhQ5ZU3xXqIchKeSN7QcERr0ga3FK6leVlGER+nc
         /D7NvOc6UMNhSgsbqCOw8bM91jnYDQuKDuqQEfjskyjiAdIvIaCjOvaS4YbaeW9Yl5on
         fUxTPL5qaIORA+8w+SkfZj70hWLC358mMhEfvf44GaUDkgSl/oIiY2NEyn7eQCjNwuN5
         f+es6qeyF96VkCfRFnFmBt2ujSV5CDM4jjd1xSKxZgPrEoEvKOuyCD9QFLdYhIDN85a/
         ccsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199474; x=1779804274;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/eckcCpi0xrpFbE201pgVvuYoNal9URjmldCWt34Ap8=;
        b=sOARMIbDA520DH5g7XCmopIaLSEyNsaALgkVb8HN8L+3GY5WLbxs61k7siRmms2RHv
         uSB6vgeO4jycKL31REJpko2Tfbjhw3d5bJx4bjtSSX7zyh6dqIbZk0kGt2+cHpf4h43I
         Ssq5XcEp0fI6KaV5FNIcSsNtcfOc3iG8TZIcX1XshIKtyFV9jX59hw+q2srW9GSFAe0k
         +CC1cUCupFca6xyaKJnvLWQu5hWTE9M5oNGihAsw0U8EEwUQg0/PEDeUVGvG5JsOb9t3
         l9a180nu2b71roOXgsAPX0F0nd5ijDjNtGpvQ9wcRKsp9G3B1jbbCI9uUFO9SsRKLP6B
         /8nw==
X-Forwarded-Encrypted: i=1; AFNElJ9g8bPCqxr6Oc0/moNyB7gWZQKBf/VapO/L48eeAyVh8w5uSJcjYK+Co1EKvlKq1cLKnPJ5MO2hqIolJ+0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyEOCBKgmrRRn+H2VOZjsmx5OsTlrr5tzma+Dq6pjLwBB7FadiC
	oIElU0NR9Y3y28IrCN5V8CEkkiwaWDNI+4hbsnDGGsy+FXRE7Shb+WzPCJQJKqrGPA==
X-Gm-Gg: Acq92OEbdrxsECgy02XC0yaYGrWFmJd5jzK4khYhY71n0iP4A42M+D3gysWjS0Xcogr
	lSOb9eSgOzvoOlkJu9QcnWk5xbjGLe9XBcxUN7BzLTS+5P6BlEfR7mlIPuawDO1igtUiRLd3tFk
	KwR8PnkmYcabG+ILqQQ5A/NQbODqR5BsYpIybSA/xAWX98zHMSL2V6x8MwWDInyQqaBoxb6AxJw
	BVpRZUQAlOeOTSQ6jOOzkPEGHa0TxLC8Cq/bagAdRU1syyZq5iW3VxHIxk6bNb5Af/MC4AvbvC1
	jCl+MMS/wFug3/vEL2ga6sfglieO6ZVZMe5KDB6mkLapUOg22arpeq/RjPBSM3lNYN7o9wlGkgC
	urk6DzUSgFe8lgVL5FawD7XDVWigkghgV7An5GA6WudZPepvRIX1YK9IpfYDp3Yvw6s6Tew9lKU
	jZyvYr8XRYszBWDDLIJ+wGlJXYiRz7U+5rgHWkCQHUlDv5tW2FpmWCB0cQgeSXoj28sDxD+Ac0H
	8I=
X-Received: by 2002:a05:600c:621a:b0:489:1adc:f017 with SMTP id 5b1f17b1804b1-4901573b1a3mr2225915e9.5.1779199473882;
        Tue, 19 May 2026 07:04:33 -0700 (PDT)
Received: from google.com (136.41.155.104.bc.googleusercontent.com. [104.155.41.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19b1dsm45189665f8f.17.2026.05.19.07.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:04:33 -0700 (PDT)
Date: Tue, 19 May 2026 14:04:29 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
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
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <agxt7SFGT7OLMIah@google.com>
References: <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <20260519132911.GA7702@ziepe.ca>
 <agxolksC_1nfO34X@google.com>
 <yq5ah5o3sdn3.fsf@kernel.org>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5ah5o3sdn3.fsf@kernel.org>

On Tue, May 19, 2026 at 07:30:16PM +0530, Aneesh Kumar K.V wrote:
> Mostafa Saleh <smostafa@google.com> writes:
> 
> >> > 
> >> > I am still running more tests, but looking more into it. Setting
> >> > force_dma_unencrypted() to true for pKVM guests is wrong, as the
> >> > guest shouldn’t try to decrypt arbitrary memory as it can include
> >> > sensitive information (for example in case of virtio sub-page
> >> > allocation) and should strictly rely on the restricted-dma-pool
> >> > for that.
> >> 
> >> ??
> >> 
> >> Where does force_dma_unencrypted() cause arbitary memory passed into
> >> the DMA API to be decrypted? That should never happen???
> >
> > Sorry, maybe arbitrary is not the right expression again :)
> > I mean that, with emulated devices that use the DMA-API under pKVM,
> > they will map memory coming from other layers (VFS, net) through
> > vitrio-block, virtio-net... These can be smaller than a page, and
> >
> 
> Don't we PAGE_ALIGN these requests?
> 
> dma_direct_alloc
> 	size = PAGE_ALIGN(size);
> 
> iommu_dma_alloc_pages
> 	size_t alloc_size = PAGE_ALIGN(size);
> 
> 

For allocation, yes, and that's fine because we bring memory from
the pool.
But not for mapping, as dma_direct_map_phys(), where the memory is
allocated from the driver or other parts in the kernel and the page
may be shared with other kernel components.

Thanks,
Mostafa

> 
> > using force_dma_unencrypted() will share the whole page.
> > And as discussed, that leaks sensitive information to the untrusted
> > host.
> > I am currently investigating passing iova/phys/size
> > to force_dma_unencrypted() and then we can share pages inplace only
> > if possible without leaking extra information.
> > I am trying to get some performance results first. But the tricky part
> > is to get the semantics right, I believe in that case those devices
> > shouldn’t use restricted-dma-pools as those should always force
> > bouncing. Instead bouncing happens through the default SWIOTLB pool,
> > if not possible to decrypt in place.
> >
> 
> -aneesh

