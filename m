Return-Path: <linuxppc-dev+bounces-22824-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C41CD98F2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 13:44:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghf383M8zz3bpx;
	Fri, 19 Jun 2026 23:44:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781876676;
	cv=none; b=YQKPP5uQ/bBp1qUUrp5leZubsQg5EYeFwYQqI59K4qLZko20BR6FdFKQFlu2vemRFDjhCwGARKU+PsYzGgXVmsbefk8a4iiopLmvT5cloYlOBn/Cae/PGSp2iVJb7h5v6Tv1fWiplaBaHG8RTulw37+JX6RIrscWo/HjF+YWmihSWxRzjRtvepcdLM4OTCe2d8GQp2kwPhR8kj0DIQjENkcIiwTddHuVehfL/muVoN05mm9zqXXWw6tJsnznhLbXII+P27uvXoojtcfOAeNvPw5upxOv/83NWzBRdfgNFKSE7k1ivu8j5cwBQot0ZigtmmnrhpjzTx040egwytkAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781876676; c=relaxed/relaxed;
	bh=NOlJ0qkWwGjqOtI46GdlsCxvHcFNK9S64rnZbC57zPI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PvXXLyyEVvSt38Gf6tG1+B/tPFZC4qsaGiZis6BFG1cTsk4xQn5rW3N/uPeAATH75LK7hs5XVup053Qj+Uh6ul4XELC2QZcAZjLj0gAjrEirErDRNHZMyNh3G4wbuMiLPEO81DkMlSZmrH/GbLnMz8CWYJ98s9MIYSIPXLlS3/iylyMMFiN/p/1yYTZHNKUwxAre+otXr3bXoS75S1ARaXa7X6OpPYp9Igr0KWteis2oJAUxih8Kp6ijtTc5d5j02abLnVDO189Ev2nmnijgZVolKiBlzFr9BoOm+PCr+mW+iNqI3OX3jyVFOmzbcAMHEn72hp/1utcRvZa2BITFvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lQzkkU4F; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lQzkkU4F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghf372k8tz2ykX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 23:44:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E51A344168;
	Fri, 19 Jun 2026 13:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449711F000E9;
	Fri, 19 Jun 2026 13:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781876672;
	bh=NOlJ0qkWwGjqOtI46GdlsCxvHcFNK9S64rnZbC57zPI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=lQzkkU4Fajz1t5MDntjr+eBXOgH/kqWDGPbPnNEl6OlP4DsAaE0JKuqovdDh57WYY
	 I/6ltpFvRt56sqvzdXsVfD5NofYwR/VqfDXfNqNt77Yx03Hf0sOR6e/Q6ZJSfeD9GO
	 MmbYnKiDy6yTiZjdCMwqi+8UMVqLgh0oXCGBXinMAlZ1DP4u2+GGJzF27w5GUsgnCT
	 Af+NzJvNa18t/AFT8LNiUDtN+85DcWRyilFlXUGHfHNM1wTlz4AIvIFrWjmsrrYPJ0
	 wqYIMCBqen+y6u04gcv4qb2+QSFkFebPKCBt/9BLwnbVHBt66NMmfUQHW+KW7B7/Ka
	 vLTBA3dhzOVKQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Alexey Kardashevskiy <aik@amd.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
In-Reply-To: <20260619120309.GI231643@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com> <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org> <20260618153705.GH231643@ziepe.ca>
 <d4ef9a9f-18d9-40e1-9d02-87aeb9cb6540@amd.com>
 <20260619120309.GI231643@ziepe.ca>
Date: Fri, 19 Jun 2026 14:44:22 +0100
Message-ID: <yq5aik7eejbd.fsf@kernel.org>
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

> On Fri, Jun 19, 2026 at 12:05:45PM +1000, Alexey Kardashevskiy wrote:
>
>> > > > > IMHO that's an AMD issue, not with the design of this series..
>> > > > > 
>> > > > > The series is right, a device that is !force_dma_decrypted() must be
>> > > > > considerd to be a trusted device and we must never place any DMA
>> > > > > mappings for a trusted device into shared memory.
>> > > > 
>> > > > swiotlb=force forces swiotlb, not decryption.
>> > 
>> > If force_dma_decrypted() == true then swiotlb must allocate from a
>> > decrypted memory pool. It is right there in the name!
>> > 
>> > The hypervisor environment should *never* set force_dma_decrypted()
>> > because all devices can access all hypervisor memory, up to their IOVA
>> > limits.
>> 
>> True. But we do not have encrypted swiotlb pool today, right?
>
> "encrypted" is just normal struct page memory, that's the default for
> swiotlb.
>
> I think it was a big mistake for the AMD SME stuff to overload the
> decrypted/encrypted CC stuff which should mean shared/private in a
> guest context to also mean things about physical memory encryption in
> the host. It is really confusing.
>
> The SME side is just a bad arch choice, the real world doesn't work
> well if you set high address bits in your dma_addr_t. I think AMD
> needs to use those restricted swiotlb pool where it allocates this
> very special "SME Disabled" memory that will have a low
> dma_addr_t. Then alloc and bouncing will get memory with a suitable
> dma_addr_t. This has nothing to do with force_dma_unencrypted() which
> is only a CC guest concept and nothing else in the OS should ever
> touch decrypted memory.

Agreed. This would make the code much simpler.

-aneesh

