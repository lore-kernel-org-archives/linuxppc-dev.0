Return-Path: <linuxppc-dev+bounces-23681-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A39C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 08:06:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvYhh411gz2yR5;
	Tue, 07 Jul 2026 18:06:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783411588;
	cv=none; b=PaaF7qP1qRnPAc2tfMV8TGOivRP8WeO+aaAntXXrRwFuJ78e71KuuxFV8RF0qUAAne9ZiPXkdjvS14qHVyMMoorHn9iEcodiY1dwxPgLzhALaeR6u+3iTPxfasyKW0yp2gUJI9Ixs8AdD9wt/Xet47IvfOjSRLC7PeFGKHdkO/YjNJgLxE64GpxQdVwvCYezbMGqYVoEJiUFV9LblOHqL6W8/Q2kA1z9o2ho1EV27ni3aQ5h1kzU92qxBPzVfVea51DPXgj14vLWJirXEZ1c6slCTXnw5NcBs+L+tuKErRZ+FW0pZhhCL2U7OzhxsxPahP/NniXDgUnRS8OTtHHz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783411588; c=relaxed/relaxed;
	bh=ea0IOau1aAltI3DRKVxyYkxeEjLOa5kYpwFj12qVzqc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VtaomaUlFyqrisbd00aHEnIRpc20BTW9miEZAUX07BKJsZGRaQTp2pXdGGR4TJh9YwGx8NMkDlebfUiPd7CF5YN9M3i8HqBAYeY2AJtjR7RI8N8fxoPiUiChUOFcw5cQK7BPJzBSBpdJiPqn7snJ1QQj+uPmco5UuZLd1I6BRj7OHfv7YqPl/ykbF2JIq7qe2DSc0OUpdIRa8m9ZRwELrrsUUZWuuhprz5e0VxfJMUw7h4LE5qQtpsKggW5fvfJnXgqVlWunDQTmSB5etjOnpCmD4bfoEAVqs9X5JDHujguQj9+gYgU2W0bqM6EVoh/bx5WNqzTuJuLbg1QljqKyNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehzJVAlx; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehzJVAlx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvYhf3fVNz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 18:06:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DB220618A6;
	Tue,  7 Jul 2026 08:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E980D1F000E9;
	Tue,  7 Jul 2026 08:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783411583;
	bh=ea0IOau1aAltI3DRKVxyYkxeEjLOa5kYpwFj12qVzqc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ehzJVAlxIC/pC2sXhGD1Zd5xyp2mkGV8OuobvUJm80sNhARBCJldhVJnR/fvzUlg8
	 t2QQb326FSv7l+dfyMjQn+q4qi0x/iJZD8qCoLvIATEMQErD8y3iRKIcZPoxzVgszV
	 oRoggpbomDjX7tQZq9G9GaoCtyybcTlqjfRz4+F1rB3X4H4ooSWHLgUZt7CnfLeeFM
	 zwEb6VljE8Xh9Fi9TviWiquZI1cqM+c0j9tSvLQJ700z+8l/66JsCg+ZgzcpDbHZNA
	 MK5IFv5kO6A9ODArwj2zGJLks6KS3/uwYgDXQCaGY1s1PvXpmfKk7P0jRMoD6rRJUF
	 QGcIHGnDYecHw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v7 00/22] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
In-Reply-To: <20260701054926.825925-1-aneesh.kumar@kernel.org>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
Date: Tue, 07 Jul 2026 13:36:10 +0530
Message-ID: <yq5av7argr65.fsf@kernel.org>
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

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> This series tracks confidential-computing shared DMA state through the
> dma-direct, dma-pool, and swiotlb paths so that encrypted and decrypted
> DMA buffers are handled consistently.
>
> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
> shared/decrypted buffer handling. This series consolidates the
> force_dma_unencrypted() checks in the top-level functions and ensures
> that the remaining DMA interfaces use DMA attributes to make the correct
> decisions.
>
> The series separates mapping and allocation state:
> - DMA_ATTR_CC_SHARED describes the DMA address attribute requested for a
>   mapping. It tells the DMA mapping path that the DMA address must target
>   shared/decrypted memory.
> - __DMA_ATTR_ALLOC_CC_SHARED is an internal DMA-mapping attribute used only
>   by allocation paths after the DMA core decides that the backing pages
>   must be allocated as shared/decrypted memory.
>
> The series:
> - moves swiotlb-backed allocations out of __dma_direct_alloc_pages(),
> - uses __DMA_ATTR_ALLOC_CC_SHARED through the dma-direct alloc/free paths
> - teaches the atomic DMA pools to track encrypted versus decrypted
>   state
> - tracks swiotlb pool encryption state and enforces strict pool
>   selection
> - centralizes encrypted/decrypted pgprot handling in dma_pgprot() using
>   DMA attributes
> - passes DMA attributes down to dma_capable() so capability checks can
>   validate whether the selected DMA address encoding matches
>   DMA_ATTR_CC_SHARED
> - makes dma_direct_map_phys() choose the DMA address encoding from
>   DMA_ATTR_CC_SHARED and fall back to swiotlb when a shared DMA request
>   cannot use the direct mapping, which lets arm64 and x86 CCA guests stop
>   relying on SWIOTLB_FORCE for DMA mappings
> - use the selected swiotlb pool state to derive the returned DMA
>   address
> - reports CC_ATTR_GUEST_MEM_ENCRYPT for arm64 Realms, powerpc secure
>   guests, and s390 protected virtualization guests.
>
> Dependency:
> This series depends on the pKVM changes posted at:
> https://lore.kernel.org/all/20260603110522.3331819-1-smostafa@google.com
>
> Please merge this series only after the pKVM changes above are merged.
> Otherwise pKVM will be broken.
>

A rebased tree on top of the dependent pKVM changes can be found at:
https://gitlab.arm.com/linux-arm/linux-cca/-/tree/scratch/pkvm/testing?ref_type=heads

The patches had minor conflicts. I am not sure how we want to get this
merged.

Should we ask the pKVM maintainers for a topic branch, and then I can
repost the updated series on top of that?

-aneesh


