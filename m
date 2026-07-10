Return-Path: <linuxppc-dev+bounces-24005-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8486FC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 10:50:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxTBS6x9fz2yS4;
	Fri, 10 Jul 2026 20:50:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783680624;
	cv=none; b=HcjZ0GDm2GlZ/qK845pH8oZjm3JksDKawuOhyCBrmZERTxdZkrJNL0YDDaThA+HqTY6HdXIWogtwFQ2gXzBKosjW+ogycgg/46GshNYNOsMNZDHvOWLBLexRy+6pMUyNlqndhmIfloXPPa2MWsSHlnV/HAUsjfy8/92ErP5BKdbammRELgkeO1ech/JgGOrqBNsFFzphu4wNr9L9VHnVecEXX2N0sva88XtF69h2QRu9q6lKQYGX3+U5IpoNdYWGgZEp7JSL1slI7S/KoGgIM/mCMBMkTeTkI/34pDEv+yPJ0NfYNUaQ2avBiiNPdPMjIvzmjlK3tGsn4kNVTG/pRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783680624; c=relaxed/relaxed;
	bh=hfTO3wFu/T6iZFaBLNDZLHaW6Mq653VUZn4uoRS7Zj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMJpN3OOHMjyRx7uSffblOTQn1PmGGhtyvGALHo2MiGNdqrIDH5Eh+AyvMCt9h0+USrzBNjIZoqepcWdaU26DHcoNqbenKh/GcoeekGz8I4jJcmHC/3F9mYsucNCjx+X7o/5ot+jYa3dwkh3qr2S4Huha6PYsvW5NztkptzpByiuu8q38Y6I3WvG9TBXN6EgzMUwwQUhJ5E37jpuGRTpvpPCQm8Qyf/67L6vPrA6pQEkccL/rDDbd1iaINarH/BueEp/s2tPV7S6uvhJLvZhOIHXbvL8T1VS64z/5FyGWeqkZ9Bs3NREX1g0hwqS/gIJUYnyS6YhQvrPkD0o3chyjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYLQ+9PR; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=will@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYLQ+9PR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=will@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxTBR6j5hz2yRF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 20:50:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C6DCD40813;
	Fri, 10 Jul 2026 10:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4B11F000E9;
	Fri, 10 Jul 2026 10:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783680621;
	bh=hfTO3wFu/T6iZFaBLNDZLHaW6Mq653VUZn4uoRS7Zj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nYLQ+9PRsu6pTYa7XveNy4Y0cihb6Lvyb2okOddtnzEDFyhKZMoEp28hrsnAuSs1/
	 mZWLZmRgr8X2MEZjnVFnbhGNKuv/d+Kl4OD/zcri16TTTzcUSRPgbwYMsnlmQYVZ2Q
	 fSNn40vQEBtYdfiI8057+h/qZPp0qDO1qn8JAF++X66Q6YwXY6qHMbRN4akzlqykrG
	 X1sftYbJurNQTvVGQJCWWm50cIkILsstPYP8QSi2lEZ21NAzI0sqPbfqxqtElSQcNS
	 pnRxs8cUNLPGyy81RO4cJUiFw3EmrJ5RSS3AlI20Gr4GlHC1U07tf55AuvCMff4Rs3
	 VIJHcPWynLx/A==
Date: Fri, 10 Jul 2026 11:50:12 +0100
From: Will Deacon <will@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
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
Subject: Re: [PATCH v7 00/22] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
Message-ID: <alDOZAK_reXPQJsN@willie-the-truck>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <CGME20260707080628eucas1p13fa8a57e60ef5dd3ec651e19e42af0a1@eucas1p1.samsung.com>
 <yq5av7argr65.fsf@kernel.org>
 <fc804746-4fb8-4ea9-997f-a4cae9ba8c14@samsung.com>
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
In-Reply-To: <fc804746-4fb8-4ea9-997f-a4cae9ba8c14@samsung.com>

On Tue, Jul 07, 2026 at 03:03:48PM +0200, Marek Szyprowski wrote:
> On 07.07.2026 10:06, Aneesh Kumar K.V wrote:
> > "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:
> >
> >> This series tracks confidential-computing shared DMA state through the
> >> dma-direct, dma-pool, and swiotlb paths so that encrypted and decrypted
> >> DMA buffers are handled consistently.
> >>
> >> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
> >> shared/decrypted buffer handling. This series consolidates the
> >> force_dma_unencrypted() checks in the top-level functions and ensures
> >> that the remaining DMA interfaces use DMA attributes to make the correct
> >> decisions.
> >>
> >> The series separates mapping and allocation state:
> >> - DMA_ATTR_CC_SHARED describes the DMA address attribute requested for a
> >>   mapping. It tells the DMA mapping path that the DMA address must target
> >>   shared/decrypted memory.
> >> - __DMA_ATTR_ALLOC_CC_SHARED is an internal DMA-mapping attribute used only
> >>   by allocation paths after the DMA core decides that the backing pages
> >>   must be allocated as shared/decrypted memory.
> >>
> >> The series:
> >> - moves swiotlb-backed allocations out of __dma_direct_alloc_pages(),
> >> - uses __DMA_ATTR_ALLOC_CC_SHARED through the dma-direct alloc/free paths
> >> - teaches the atomic DMA pools to track encrypted versus decrypted
> >>   state
> >> - tracks swiotlb pool encryption state and enforces strict pool
> >>   selection
> >> - centralizes encrypted/decrypted pgprot handling in dma_pgprot() using
> >>   DMA attributes
> >> - passes DMA attributes down to dma_capable() so capability checks can
> >>   validate whether the selected DMA address encoding matches
> >>   DMA_ATTR_CC_SHARED
> >> - makes dma_direct_map_phys() choose the DMA address encoding from
> >>   DMA_ATTR_CC_SHARED and fall back to swiotlb when a shared DMA request
> >>   cannot use the direct mapping, which lets arm64 and x86 CCA guests stop
> >>   relying on SWIOTLB_FORCE for DMA mappings
> >> - use the selected swiotlb pool state to derive the returned DMA
> >>   address
> >> - reports CC_ATTR_GUEST_MEM_ENCRYPT for arm64 Realms, powerpc secure
> >>   guests, and s390 protected virtualization guests.
> >>
> >> Dependency:
> >> This series depends on the pKVM changes posted at:
> >> https://lore.kernel.org/all/20260603110522.3331819-1-smostafa@google.com

FYI, I'll probably take the second patch there as a fix, then I can put
the other two on a topic branch in the arm64 tree.

Will

