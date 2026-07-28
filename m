Return-Path: <linuxppc-dev+bounces-24937-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC026C54F52
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 12:32:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8ZbW2mrSz2xyk;
	Tue, 28 Jul 2026 22:32:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785241927;
	cv=none; b=C8vKmUq/PI2vLq1TarG8yNtUn6wQvKZ77rFZD9OpOCGgd37v2CgR8tHKKSXqzB081rEzhb2jCkRB+QZdxsHG8Hd0OMVn2TN1HVSURzSmasb8zSsxIezKU/w9Se/ow6Yv1gQqCGffo2VnirphJXR8lswVIRY3AZQc+UXB6KGu/gug9b2PWXp66Nl+1s0SFmsT3qagusNFvfE9GhRCeQqd3Ali38OANYIJrVfc75btfZEey4URg8O6lljbNSJEQrohV5ReyT4vqxVR8O8ZtoaEh32KSojPDpvdR0diZYy/PuHdVQdBakzE+tIQglSQaCWDi4WhzAynt1caN2jPTv79Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785241927; c=relaxed/relaxed;
	bh=lSkwhKAcEsyJqT/0xqVJXtxYxIXWD0v9uCPSjTmMF2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=byXxRqWZAA7Siv4kn8a5DHORtaAd2M4I/FcIGIHN8OX44zXoTovb74GmDBqcTod2ribWWh25Y2/lNZRXauDqAnNUrSMVOREHbZteluIsOGDfJQDpZaiRHrdJYHxlidI4wCFRsPWbqXS8XjUSl14p3YruR8n6S9tZvA2RqXAqJTUmk7EwBlliWBxKS3087qVJPZxfxVdKC3TWULOurrJonD50E6GaPYUbMbhZGwT8ONSJ4NKmasvUBEPnqprfIOQkfVZ2BdLfHuTtmBogGrtO1DNPr32hxOiGIvh46GCIAyaYVquwHcdw+2x4kHV4qOBiIi11N78/6/nGBBhOzRJwUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEM01trD; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEM01trD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8ZbV1SZ0z2xlQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 22:32:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B021A40321;
	Tue, 28 Jul 2026 12:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E771F000E9;
	Tue, 28 Jul 2026 12:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785241920;
	bh=lSkwhKAcEsyJqT/0xqVJXtxYxIXWD0v9uCPSjTmMF2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=WEM01trD462HpzukrLQzJYedOMo/krm72PvzqlsPIr95pA22pK97BItUkKTq0RiE1
	 BafhKgnPLjt9aVTzvU1dFa7RMbB40i5ZGyvy+Uq+GD3nlFNKGJAlh6v5YCczVVs88W
	 XLgMqJmGuxCudWp7Pe+Yi+kgsFNJVH9ZJXfZCAW/9lfgbs+iqFLXWZDleq9blMw7mP
	 +MH5pd841sVe9ss5f/WYkSBvsx7eS76Efavuj5k30SQrM2EWKd6eLiQqbz9Kr4x/nz
	 YGdV+Rm3lqSrOuShxDdIBjk4LGOrgQZRl5vevgtv94weDxSm1UhqL4Mz6Y3mDajtlK
	 HdSaygY48BoeQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
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
In-Reply-To: <20260726081753.GD12003@unreal> (Leon Romanovsky's message of
	"Sun, 26 Jul 2026 11:17:53 +0300")
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
	<20260717180442.110954-2-aneesh.kumar@kernel.org>
	<20260721115456.GI110966@unreal> <yq5atsps77c5.fsf@kernel.org>
	<20260721142921.GN110966@unreal> <yq5ao6g0750v.fsf@kernel.org>
	<20260721153321.GO110966@unreal> <amEhEKQW0_HJ9cLN@ziepe.ca>
	<20260723075704.GC110966@unreal> <amTJY_CdE-uDgoGG@ziepe.ca>
	<20260726081753.GD12003@unreal>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 28 Jul 2026 18:01:45 +0530
Message-ID: <yq5ah5ljjnwu.fsf@kernel.org>
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
Content-Type: text/plain

Leon Romanovsky <leon@kernel.org> writes:

> On Sat, Jul 25, 2026 at 11:34:11AM -0300, Jason Gunthorpe wrote:
>> On Thu, Jul 23, 2026 at 10:57:04AM +0300, Leon Romanovsky wrote:
>> > On Wed, Jul 22, 2026 at 04:59:12PM -0300, Jason Gunthorpe wrote:
>> > > On Tue, Jul 21, 2026 at 06:33:21PM +0300, Leon Romanovsky wrote:
>> > > 
>> > > > Something like, but probably void* needs to be phys_addr_t:
>> > > > 
>> > > > static inline struct page *dma_phys_to_page(void *addr)
>> > > > {
>> > > > #ifdef CONFIG_DMA_DIRECT_REMAP
>> > > > 	return vmalloc_to_page(addr);
>> > > > #else
>> > > > 	return virt_to_page(addr);
>> > > > #endif
>> > > > }
>> > > 
>> > > I don't like this, we don't know for sure the addr will be in a vmap
>> > > and this will fail if it isn't.
>> > 
>> > Of course we know. The existing "#ifdef CONFIG_DMA_DIRECT_REMAP" is
>> > relevant for addresses acquired from pool.
>> 
>> Yeah, but I still don't like it :) It is hard to follow if you make
>> those kinds of leaps, someone will call this new helper on something
>> they shouldn't
>
> This issue is straightforward to address today. Limit the scope, use
> an appropriate function name, and add a comment indicating that the
> function is local to and specific to the pool. The latter helps
> AI-based review tools flag incorrect usage outside the intended scope.
>
>> 
>> > dma_phys_to_page() is a bad name for some low-level conversion function.
>> > It needs to be internal to DMA logic, in the level when we convert from
>> > phys to page.
>> 
>> I think we should not convert from phys to page, that's also easy to
>> do wrong
>
> Perhaps I'll reiterate my complaint. DMA internals are already hard to
> understand. Part of that complexity is necessary to support every
> possible use case, but another part comes from a maze of types that is
> entirely self-inflicted. I think this code only makes the latter worse.
>
> Currently, the phys type universally describes memory and can be
> reliably translated into any required representation. It is the most
> fundamental type we have.
>

I think we can address the suggested changes as a follow-up patch series
on top of this.

How about we get this picked up for the next merge window first, so that
we can get the CC_SHARED related changes in? The follow-up changes
should be easier once we have agreement on the overall design, and can
then be done as incremental cleanups.

-aneesh

