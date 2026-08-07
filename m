Return-Path: <linuxppc-dev+bounces-25549-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4715AC5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 09:21:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGdvK5VDdz3c2K;
	Fri, 07 Aug 2026 19:21:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786094509;
	cv=none; b=DBjWkobrNiUdjskaM7F5qS07FP1FQP5FhNmqvAUN6W2vQfgDJNsl1e1TvrK/EFLC6N/c8yD39VVjVQn/t5dWTapJb+9K92pQxFNtj5E03W7EssY9RtoFQ0urPYc/Ibn8mTJ8BXAnHNPyIfk/Y3vz/l5qIlj+ls7NxtyQLEvUdiY8PwH5DX4YPbqWmHX9EAQKMuV55E69y7ZPdo5AogEZFJhzoi8aBAO+cZJzNZm7ku6gaTUoLbVmBzySMemojZnt5gkCmvybAWKpNt9rPAZra3NPdTDmy8IgHkoYJs+UzQq7HzmYKJv5nBcrPHxx0WTyv1hdsypuHPXQ1lFxWtzDFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786094509; c=relaxed/relaxed;
	bh=Pneo29ys3hGXogLk2+e1LzC80FrdOftuA2dSFmi144s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mYsdEGERN7U6VgSioVMBf2362ojCCNL+RwBSx27ytsy1gug79J7ja0gtgTC7+IA77hU4lHIrv74gmwJhLtpP4AZifvrM21i4/OPMi4M6uh2HGAOqjOK8SIZfVdiAbol5mhxv2PBYupU8sIDj5aFDEap0bGA4xxDkG0WQ9j/H+afQbgwAK7VH96TMA2Zcg3pyEq78dbsACS4bVUTxAbGncv6sczKiXO1onD5H6Uh70IA5nJzh3m1RYZD4M8yvsOhaZrRfqBGnBHCO1kPWbdcVlboUomw6w77zgEK4dj/6JwtVSwNtBrV+GDurjc2lY7q9r406zPbuGDkFB3AqgrH2pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XMQCJ/Gj; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XMQCJ/Gj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGdvJ6S1Dz3c1D
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 19:21:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7010641180;
	Fri,  7 Aug 2026 09:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAC51F000E9;
	Fri,  7 Aug 2026 09:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786094506;
	bh=Pneo29ys3hGXogLk2+e1LzC80FrdOftuA2dSFmi144s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XMQCJ/Gj7Iu0ebVkhN13wsJt7AMBs/hyKYZHipvHCieM6Evyh/O2tF++XsVqENx/W
	 O4WpssKXAy1yB++mPLwn98gKLPnv8EJJ/xWJsxJdcHW3lvVwqg0WL0zQ3gkXU+TSmf
	 //VtTLKCKI8L/CclOy9PRdlovmOFa+u7XuDa26ivvRmK9rJgKLrvrxtkUPdmv+dDNU
	 LtPQ7TYk2UHyko3C2QTCSIU/KvPbS03jl7EOyg7RbatVxdODw0IY3BaCmRDRK3wPX2
	 Y5kMliqWeBs0luT8yI7Y4mRC+oPOczxGCmhB0P9lrQf7CzQN4ZpwcwEEKQH0dUWYGx
	 z/ew0497IG91Q==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
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
Subject: Re: [PATCH v8 00/23] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
In-Reply-To: <85be992d-9567-433e-ae2e-64ae5483964d@samsung.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <CGME20260725070930eucas1p16cbafb514de7a2e7531d0e4ae158acfb@eucas1p1.samsung.com>
 <yq5azezfeeax.fsf@kernel.org>
 <85be992d-9567-433e-ae2e-64ae5483964d@samsung.com>
Date: Fri, 07 Aug 2026 14:51:35 +0530
Message-ID: <yq5afr0q2sm8.fsf@kernel.org>
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

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> On 25.07.2026 09:09, Aneesh Kumar K.V wrote:
>> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:
>>> This series tracks confidential-computing shared DMA state through the
>>> dma-direct, dma-pool, and swiotlb paths so that encrypted and decrypted
>>> DMA buffers are handled consistently.
>>>
>>> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>>> shared/decrypted buffer handling. This series consolidates the
>>> force_dma_unencrypted() checks in the top-level functions and ensures
>>> that the remaining DMA interfaces use DMA attributes to make the correct
>>> decisions.
>>>
>>> The series separates mapping and allocation state:
>>> - DMA_ATTR_CC_SHARED describes the DMA address attribute requested for a
>>>   mapping. It tells the DMA mapping path that the DMA address must target
>>>   shared/decrypted memory.
>>> - __DMA_ATTR_ALLOC_CC_SHARED is an internal DMA-mapping attribute used only
>>>   by allocation paths after the DMA core decides that the backing pages
>>>   must be allocated as shared/decrypted memory.
>>>
>>> The series:
>>> - moves swiotlb-backed allocations out of __dma_direct_alloc_pages(),
>>> - uses __DMA_ATTR_ALLOC_CC_SHARED through the dma-direct alloc/free paths
>>> - teaches the atomic DMA pools to track encrypted versus decrypted
>>>   state
>>> - tracks swiotlb pool encryption state and enforces strict pool
>>>   selection
>>> - centralizes encrypted/decrypted pgprot handling in dma_pgprot() using
>>>   DMA attributes
>>> - passes DMA attributes down to dma_capable() so capability checks can
>>>   validate whether the selected DMA address encoding matches
>>>   DMA_ATTR_CC_SHARED
>>> - makes dma_direct_map_phys() choose the DMA address encoding from
>>>   DMA_ATTR_CC_SHARED and fall back to swiotlb when a shared DMA request
>>>   cannot use the direct mapping, which lets arm64 and x86 CCA guests stop
>>>   relying on SWIOTLB_FORCE for DMA mappings
>>> - use the selected swiotlb pool state to derive the returned DMA
>>>   address
>>> - reports CC_ATTR_GUEST_MEM_ENCRYPT for arm64 Realms, powerpc secure
>>>   guests, and s390 protected virtualization guests.
>>>
>>> Dependency:
>>> This series depends on the pKVM changes posted at:
>>> https://lore.kernel.org/all/20260603110522.3331819-1-smostafa@google.com
>>>
>>> Please merge this series only after the pKVM changes above are merged.
>>> Otherwise pKVM will be broken.
>>>
>> pKVM topic branch is now available 
>>
>> https://lore.kernel.org/all/178467286876.125042.12010461715645610054.b4-ty@kernel.org/
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/coco
> I've just got back from my holiday's and I see that there is everything ready to give
> this patchset some tests in linux-next. I hope nothing will break.
>
> I've applied this patchset to dma-mapping-for-next, on top of pKVM topic branch with
> patch "[PATCH v8 17/23] dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED"
> rebased onto latest changes in arch/arm64/mm/init.c.
>

That might need a fix.

From 5a9af89e74e9e2671ed0a572af129ebfa6fd4640 Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Date: Fri, 7 Aug 2026 13:14:51 +0530
Subject: [PATCH] arm64: swiotlb: Keep the default size for protected guests

Realm guests and protected KVM guests may require swiotlb for device DMA
even when all system RAM is addressable by the DMA zones.

Do not reduce the SWIOTLB buffer to the kmalloc-bouncing size for these
guests, as the reduced number of slots can be exhausted during CCA guest
operation.

Fixes: 30c5e45ee2c5 ("dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED")
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/mm/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index e308a7cabd12..24caaf10e755 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -339,7 +339,8 @@ void __init arch_mm_preinit(void)
 {
 	unsigned int flags = SWIOTLB_VERBOSE;
 
-	if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
+	    max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
 		/*
 		 * If no bouncing needed for ZONE_DMA, reduce the swiotlb
 		 * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.
-- 
2.43.0


