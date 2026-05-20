Return-Path: <linuxppc-dev+bounces-21201-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F083CD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 03:57:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKyRq18GDz2yDs;
	Wed, 20 May 2026 13:57:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779249463;
	cv=none; b=oYdRBCi0bcdIprYugCnkpGCEKeZipuB2INDMQlGhq71RPEzIU1udhBZ0sgAXFSlVwoAvIM8IKdGGlk2qMJtzRpYueylQt5uB4PjNiT/icD4g5V3sgSXlW86of2eW1hZPKKNscy2C5zckLY1gevBbBRzuG0kat6LI7x5tgTbp7YQzKrIUoE2csxnVZOSuMrBeIrL156CTd4ZL/Q4jfl2i//X9NMbtG4Qk6+DAnbY0dlpKvCuytw7v7oz/FfJTVT6iDfgOQJGzwMDUk76T/VXlo6tUpoXnUO+4Up9YlgwKiL6tAGqbE6/oVeexPGYOxNLAN4xt42HG3kX7yniTiS1jpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779249463; c=relaxed/relaxed;
	bh=2/10KWZth3f3oJZ9cVmYGyrspKBWGW0LeGuuNx46MWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E61wG4afnh8fls5G5u39JouS4yTKu2I4peB4QhBvNHlcqZe+PLV1LuBqruYvph/H0o5m0AwxoybZoeJVFeWqV/ytcak72LTGwIO8LlrIEdXCV7IhDdbdWLyRlLLw2AgVuUWO0Yc4rtzPEDlHzUpfK1778t+BJznJ9tsyLmUHPOmIdSlHVG6qdyWMkGaFOJnTIYj1XcrUWRaoc/oAYqiGC6bhk7/PCFXrkfkTa8Hw8S0xP9YUWEL3jJyIf7O7dpu1uwlt3K1eLRtIJbjFBBVHM1DXNNFx+HK8OsPkAHCCabUg9ZGa0trJCR0FarfLc8HWHM8useCpo31QhVlkxgHIKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=InlsMQlE; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=InlsMQlE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKyRn5G4Zz2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 13:57:41 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 95B7543EA4;
	Wed, 20 May 2026 03:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679B51F000E9;
	Wed, 20 May 2026 03:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779249458;
	bh=2/10KWZth3f3oJZ9cVmYGyrspKBWGW0LeGuuNx46MWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=InlsMQlEZWNdtUwAJ/WfdVY8k13HPRMssotBX7SBIuNa54Jg5vv0DFKV/w2mGAhTl
	 Tzussp1c8bM+KGnneYMWBdGbE4oZul6IPm60d103sHqARcIHtvuJIiVgW9S3QWUNxe
	 GjNuOmh9trmY3E8I6iNu0UCo/Ee4tbvNHH+iz36pcjOMPgbKC1DF7Zdic5DUxAP/5r
	 qFDNlC2UfvXa6u5GW5TK6+7EPafA/L3aUULUJfYDKazwkubhgxm0YcqdzN4vollRka
	 RL31G/X3pgTFzHPzIAgWwh2bzokWqpVVU6U6B2r+w0u77cJDi7s4qVbg0kWegirLl0
	 +27eesvv2tbCg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
In-Reply-To: <20260519161120.GO7702@ziepe.ca>
References: <yq5ah5oaa63h.fsf@kernel.org> <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org> <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org> <agxDxdxynp4KEovA@google.com>
 <yq5amrxvshxg.fsf@kernel.org> <yq5abjebsaid.fsf@kernel.org>
 <20260519152741.GM7702@ziepe.ca> <yq5a8q9fs7ud.fsf@kernel.org>
 <20260519161120.GO7702@ziepe.ca>
Date: Wed, 20 May 2026 09:27:27 +0530
Message-ID: <yq5a5x4ispg8.fsf@kernel.org>
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

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Tue, May 19, 2026 at 09:35:30PM +0530, Aneesh Kumar K.V wrote:
>> Yes, that also resulted in simpler and cleaner code.
>> 
>> swiotlb_tbl_map_single
>> 	/*
>> 	 * If the physical address is encrypted but the device requires
>> 	 * decrypted DMA, use a decrypted io_tlb_mem and update the
>> 	 * attributes so the caller knows that a decrypted io_tlb_mem
>> 	 * was used.
>> 	 */
>> 	if (!(*attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
>> 		*attrs |= DMA_ATTR_CC_SHARED;
>> 
>> 	if (mem->unencrypted != !!(*attrs & DMA_ATTR_CC_SHARED))
>> 		return (phys_addr_t)DMA_MAPPING_ERROR;
>
> Yeah, exactly that is so much clearer now that the mem->unecrypted is
> tied directly.
>
> That logic is reversed though, the incoming ATTR_CC doesn't matter for
> swiotlb, that is just the source of the memcpy.
>
> /* swiotlb pool is incorrect for this device */
> if (mem->unencrypted != force_dma_unencrypted(dev))
>     return (phys_addr_t)DMA_MAPPING_ERROR;
>
> /* Force attrs to match the kind of memory in the pool */
> if (mem->unencrypted)
>      *attrs |= DMA_ATTR_CC_SHARED;
> else
>      *attrs &= ~DMA_ATTR_CC_SHARED;
>
>
> Attrs should be forced to whatever memory swiotlb selected.
>

But that will not handle a T=1 device that wants to use swiotlb to
bounce unencrypted memory. That is:

force_dma_unencrypted(dev) == 0  /* T=1 device */
attrs = DMA_ATTR_CC_SHARED;

In that case, it should use an unencrypted io_tlb_mem:
mem->unencrypted == 1

-aneesh

