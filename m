Return-Path: <linuxppc-dev+bounces-24665-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140C1C44536
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2026 19:59:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h54pD4VNfz2yFK;
	Thu, 23 Jul 2026 05:59:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784750356;
	cv=none; b=UrTQ8Rx4EjOATPID/1uXroC8ZlZ/klFmsAyjqMsqabg8lfxEZY+v4Mq50zq+XeO+yBWD3iBB8CeawSN4lVFjgzg+yHC5IGX13PhpMVCF6NkZZS//m8W83R/wk8jTc/lqXb2O6r9zmbpZ6UCuCkBpLRH8bswRGcijkNp4QZE2sj4C7Gw2NK8ZoD3y3tFZ9D90gmuG7YuS8pghbAgro60BxRxRz62VhXRMHiWfcLOqc/Sh3WRPe0PM0SOPGFw1xQxy7J8DWBnFUE2OnTyYVv7fz70hoR5cyHmrHq6n7tpEXeJ+ZvEDRjARrV+uEYnZnOkiyQPM4J2VkAKmoltJ1h9YJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784750356; c=relaxed/relaxed;
	bh=EEIQnXJI41GVGpHCEj7IDcqZ+AmiiYPwRk5ZlYk7rZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYvrs8tWVLz+kOswNak9dide5MQNbyOEuboTApGejXfjPkbUyiQ7isFPOrQ5P6P54rjkqZemBHMDS0t9c/ZYgIbQbazbYwa/daXXIwC3CDY/nDHupiA2cTwFc0ZjZkaoPmeTQXx7XSqzFMMUVtFraP+hrkXD1O3gjB8ncAxZSyR/VryQHPOjem9VhmEtZCrAB699zBoCPlzTGivBE0C/IV4raJBjTBtKaxqIZi09OjfwL+3kbfo8W6OfKN0fxoUSbM95wqbkERZx45/wEINIEz8YwctYIyhRAmZ8ERJdVKXNGHVVuFhxnQahzM6TH2P8eIMdG7ZiM77s1ymGCdW9sA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=aLGVPvLu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=aLGVPvLu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h54pC5vmjz2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 05:59:15 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-38e041ea211so10836899a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 12:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784750353; x=1785355153; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EEIQnXJI41GVGpHCEj7IDcqZ+AmiiYPwRk5ZlYk7rZE=;
        b=aLGVPvLuqtZW4Zf1KgpxKbWWxCyOk0bKVHwFHrB1HmxdZ1N7rW4G0oDnQXAHD82Yun
         H5KWJkILlDwaUdnFG4copuKxgnF3OeepzOMR5ob3/rQHjcD9hxkSkTn2ZpFuZwjgCWEA
         uaUGqYR5aGUnySwkWVLv8iJ6OVYHV6AnBuFyuiG3iVS8bQVO93B+rxU0Kiap507ZrdCc
         JpbYA9ivKV6DJAosZJwf2v9bLWgoBdvx0+WTVfv+I4OBQ+643PSZ7iiXOnZ2RN7jszpd
         J3/ae1eSfOyv2EKPXzHtQQoVI405Z9wZsGMd2V5RyEOybcjODVaiC3Yy3wAy/vbGg0Zd
         kxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784750353; x=1785355153;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EEIQnXJI41GVGpHCEj7IDcqZ+AmiiYPwRk5ZlYk7rZE=;
        b=de9I5I3ePo6BipKaUayGd7av3BJCPkqxXrKYvDojy0jPhe/2Y8nIW2ZWxOuFI1Vp5M
         f4Zmc8VHx16MAjTKe90la3qEn7nwoRY0R6joCLKHLYbu1+wPFW6rY27zG2NZNcbPQSGK
         7edpsoOIc8NxKNXaDsST3sMzUXnLN29iTQb6SzazS68pLhdperiR8mlEj40y/btP+dJM
         etFu6IDkNURqRmwxm5kMnhV9sf9OxPkd2S3061trPQkEWDqVb1n0tZ5HDX9ky0jB4EbZ
         m/if1eT3Misg6YP8ibkg599rgwKzNEHcGYSMh+0rSLroNarIS3BPsQ6uGaKv5rArLjFs
         GTLA==
X-Forwarded-Encrypted: i=1; AHgh+RpHHbeI178jnZnJuW0XbopExy6Zb3KL1bvEMJome1WFxAueaRUpXj2ib4+gKbMEz7oGV9dNwLGgF4tNzT0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyE8EiCVmx0o6qHXtWdig0tXzvsZy8NTBK9Ehn6OpnWTNparADk
	f2aIbzbfK6KvClXPu6PticleVKvFiDEq3EJavMr6cRnzOD6/mJFtDLLjOaaGbKfxdT4=
X-Gm-Gg: AR+sD10b5xlxR750yYsdldEu8oceWe4FApYafm/yreninm19THGgubk3623V1nmBF0F
	eG4IheglnAKgwuEwiGQsKrNihskTb68E/cE98xRRAnj4/3asM6NY/orDO+TVOvq9Kz7F4SkjSOY
	77XUozHkG5axC7s7YXpZnSa2wxBxn5mKPndbpXec3G8z4Mr4VNZZBavVoaBLoiueGP+iSYegCiT
	euhW6oqHkdbsubN91qmd/B5Ll0o9dW1oC9a6EwwqydXwILe4LxPPs12A/2vGprQ4xka5pTdF0fb
	n6o6nzr2UA01yK/VVzzpydEWmBzlWAgbZv9K71ELYKap3OkqPgPdq/UwIvNBOxXJge7zclnnKSm
	DuWykv2hr3MhJuHeQyLdlF1C4gOXo82qu4x/Bvq4HNXXYtAj1/F2N
X-Received: by 2002:a17:90b:28c5:b0:38e:7080:b4c0 with SMTP id 98e67ed59e1d1-38ec6979bc6mr98413a91.10.1784750353408;
        Wed, 22 Jul 2026 12:59:13 -0700 (PDT)
Received: from ziepe.ca ([216.228.115.8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13003f12sm14809771c88.2.2026.07.22.12.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 12:59:12 -0700 (PDT)
Received: from jgg by NV-9X0Z6D3.localdomain with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wmd60-000000002O0-1hvF;
	Wed, 22 Jul 2026 16:59:12 -0300
Date: Wed, 22 Jul 2026 16:59:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
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
	stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 01/23] dma-direct: return struct page from
 dma_direct_alloc_from_pool()
Message-ID: <amEhEKQW0_HJ9cLN@ziepe.ca>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-2-aneesh.kumar@kernel.org>
 <20260721115456.GI110966@unreal>
 <yq5atsps77c5.fsf@kernel.org>
 <20260721142921.GN110966@unreal>
 <yq5ao6g0750v.fsf@kernel.org>
 <20260721153321.GO110966@unreal>
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
In-Reply-To: <20260721153321.GO110966@unreal>

On Tue, Jul 21, 2026 at 06:33:21PM +0300, Leon Romanovsky wrote:

> Something like, but probably void* needs to be phys_addr_t:
> 
> static inline struct page *dma_phys_to_page(void *addr)
> {
> #ifdef CONFIG_DMA_DIRECT_REMAP
> 	return vmalloc_to_page(addr);
> #else
> 	return virt_to_page(addr);
> #endif
> }

I don't like this, we don't know for sure the addr will be in a vmap
and this will fail if it isn't.

Jason

