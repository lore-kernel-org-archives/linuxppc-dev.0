Return-Path: <linuxppc-dev+bounces-23083-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CA9C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 09:51:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gphPV68JLz2yFc;
	Mon, 29 Jun 2026 19:51:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782726686;
	cv=none; b=UcwGNDWwfLHoZqu4HfBv8XwfdDTfc6A4ClnQZi4xEF8YI6HFWxIManZsyXCviz3EmQVeKVR/gR8UWaqraiTyJJpQwsOZeRLzGGC7NubpSa6MB1cs7O7o+1XecG23Hx64WnewYS/UnsLG/ny4sSzJnW6JHymCCYxCzhQjhjLDLuvNnBu/f3FWpA/BAkXjgFMtUKx7rpTwoHS/3h21anCove0CTwHztUp0eLFZoSJRcvvm5DtlBblL3qjd5tlrPsEmFa7AskyxGfUSOD8Bf9SZ2kn29pd1G7wI7ebOMN6n9yzKAV0VAAIsDaMk2KXfUh7rIg+OS4FsWSULWTFBuSec+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782726686; c=relaxed/relaxed;
	bh=Ans8cQyuz+4bONK8ZwcfQWnEefdUl8mlhioaHY5g7cg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=atUO0kTrKu12nGXM6tgrhUU9ouMeZbF0tNmMJPzK4kvr+KSVOx5a6jvoewbfEiQfjcZJxP8ZxEkXdkeiyB4Cqrhuu/HBrjsRf7wgKEv6MNjT8GptTrkFeKWR0seqWlwlNhWIIHlSiZr7vod4viJFTl7ZDb8We7Z9XgzKG04v9s0NXb09k+OOYGcxP8AmIg5uy1dSfHpXJ+I/dTqUzE2c/oWEeTnbhPliTpq+yaJSLJ124YUJYZ6U8AiXxA2sHtgxM67vINfe/2M+A7zO1bCO60oOwx82SeRLkM8bWcCsAP/yJA5jNR/sgnwCUsgBQ1Z1mqh4s6UfnUY6WAm9yInt+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVJB8yvf; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVJB8yvf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gphPT3kGKz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 19:51:25 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C3B2C60008;
	Mon, 29 Jun 2026 09:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681D11F000E9;
	Mon, 29 Jun 2026 09:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782726682;
	bh=Ans8cQyuz+4bONK8ZwcfQWnEefdUl8mlhioaHY5g7cg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=OVJB8yvfXgbiOBWbfWIoCv4EaqRoiMKbn/u81nCdeww8OY0lsKYD5YUIGjzxCGvda
	 QELTkKii4nlxFHZwgwLIfbn0ZuR6eySGblk232ZI6431dTMGNSMlXLKKQ9Qa1qM3jm
	 PwJPy2IiyYjaHq4ALlzg8wobD7QaTTEdFsyUk4xvyyOGmzo8YP5EJ5x6ldFZ4JvAPS
	 iXqMh0s+dbaUW+YKPGg0H5u/nJIvCb4b7ivUOvUQoo34xbrDTEkKt9Iy9BelIW2fDb
	 FhaZMyl2j8BRqrNZGVnrwnyxL/L/6vRUJ4wxARUZ8wqDwoPUKvuyLL22OYmDijOqQ3
	 V3iAOA40OozrQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
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
In-Reply-To: <yq5ao6gtoncp.fsf@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com> <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org> <20260618153705.GH231643@ziepe.ca>
 <yq5ao6h6enhm.fsf@kernel.org> <20260619122148.GL231643@ziepe.ca>
 <yq5aldcaejos.fsf@kernel.org> <20260619140616.GB1068655@ziepe.ca>
 <yq5ao6gtoncp.fsf@kernel.org>
Date: Mon, 29 Jun 2026 15:21:08 +0530
Message-ID: <yq5ah5mloesz.fsf@kernel.org>
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


Alexey,

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:

> The current code already does this and uses the swiotlb pool correctly
> on SME. The challenge arises when we want to force SWIOTLB
> bouncing even for devices that can handle encrypted DMA addresses (more
> on that below). For such a config force_dma_uencrypted(dev) will return
> false and swiotlb will be marked cc_shared/decrypted = true; This trip
> the new check we added.
>
> 	/* swiotlb pool is incorrect for this device */
> 	if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
> 		return (phys_addr_t)DMA_MAPPING_ERROR;
>
> We can also do
>
> 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> 		/* swiotlb pool is incorrect for this device */
> 		if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
> 			return (phys_addr_t)DMA_MAPPING_ERROR;
>
> 		/* Force attrs to match the kind of memory in the pool */
> 		if (mem->cc_shared)
> 			*attrs |= DMA_ATTR_CC_SHARED;
> 		else
> 			*attrs &= ~DMA_ATTR_CC_SHARED;
> 	} else {
> 		/*
> 		 * Host memory encryption where device requires an
> 		 * unencrypted dma_addr_t due to dma mask limit
>     		 */
> 		if (force_dma_unencrypted(dev))
> 			*attrs |= DMA_ATTR_CC_SHARED;
> 		else
> 			*attrs &= ~DMA_ATTR_CC_SHARED;
> 	}
>
>
> Here I see value in having DMA_ATTR_UNENCRYPTED. The question is do we
> need to split this into two flags and introduce the resulting code
> duplication.
>

Can you help to test this patch?

commit 0275ed870ff8dadb4890fe8342e84b294f657c43
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Date:   Mon Jun 29 11:55:08 2026 +0530

    swiotlb: Return unencrypted DMA addresses for SME bounce buffers
    
    On hosts with memory encryption, the default swiotlb pool is marked shared
    and decrypted when memory encryption is active.
    
    Make host-memory-encryption swiotlb mappings consistently return
    unencrypted DMA addresses. This applies regardless of whether the device
    itself requires unencrypted DMA due to its DMA mask, because the bounce
    buffer memory backing the mapping is already unencrypted. It also preserves
    swiotlb=force for devices that can address encrypted memory: forced bounce
    mappings use the unencrypted swiotlb pool and receive unencrypted DMA
    addresses.
    
    Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index a62e1571ec95..9ba23cf8d97b 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1514,15 +1514,26 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
 
-	/* swiotlb pool is incorrect for this device */
-	if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
-		return (phys_addr_t)DMA_MAPPING_ERROR;
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+		/* swiotlb pool is incorrect for this device */
+		if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
+			return (phys_addr_t)DMA_MAPPING_ERROR;
 
-	/* Force attrs to match the kind of memory in the pool */
-	if (mem->cc_shared)
+		/* Force attrs to match the kind of memory in the pool */
+		if (mem->cc_shared)
+			*attrs |= DMA_ATTR_CC_SHARED;
+		else
+			*attrs &= ~DMA_ATTR_CC_SHARED;
+	} else if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
+		/*
+		 * On hosts with memory encryption, SWIOTLB-backed memory
+		 * is unencrypted memory. DMA addresses returned for bounce
+		 * buffers must therefore have the C-bit cleared, even for
+		 * devices that can address encrypted memory. This also
+		 * preserves swiotlb=force for those devices.
+		 */
 		*attrs |= DMA_ATTR_CC_SHARED;
-	else
-		*attrs &= ~DMA_ATTR_CC_SHARED;
+	}
 
 	/*
 	 * The default swiotlb memory pool is allocated with PAGE_SIZE

