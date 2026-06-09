Return-Path: <linuxppc-dev+bounces-22341-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD24CD8CA4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 13:43:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZVVx4dVpz2ytV;
	Tue, 09 Jun 2026 23:43:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781012633;
	cv=none; b=R3NPRiwxxlhI9SZ/FOjFge8U7I546GUSFVhDF/XdAd+9MJAreq9Ln3y65xQxefaM9ZDvMTHpdYou2XGNFHvLJmC9jq3dpNgdkfC43s/eZ2zDUz7eu8Q4uAQTjhIy1+ynEexGYOWruABxFNGyCsr2rRToJhpeDOb4ps/dcWNSxPeZtRd+FiHOGR2DFuLMSiANAMmtCaHn8FOm4zFqpq2PbuXev1TuI9MyQ6BLR32FbrEkYuaI0+lmeMsOov7PwYxDDLz351Jzi8JYQQ8YFMW0SRzFF+h3s6NkPSDG/ZHEtemgrJ3JFRZH3ITlSSXzbb8xzbscPBqmCVpij/Ag3lIGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781012633; c=relaxed/relaxed;
	bh=gu/JOyC84tVJBCUkG+lF/hJMdSljFsmWBlUj9ii2JRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rt7TGnilaLLmQ1sKLdsqf7dZWb6OB5Gj9hxVElsJW3fjQn6Cde29TWuQpdJKcf/xGLVx86D5ZJFgsVLNjgQ049o8E1KuPucb5o6DOBoWEK4nvzhftQ9YVDNLv2lFITTCRPsdTpi55/t107ojdpKMvRITb5tNJuWP4gXAuuTwlN/D7q43PAENIVJnaRVt0SRWMzUNQCm5caCRXdkhHpJ12khbO7dHZ/0hW8XsofvgasLijaquJpxUZUY98zmgUHWiaSe3pFA7FoMC4OKySUCQrMoledPtHRUhtd91EtfWlPYJIcRPxUZSwZNyPcivKsPpMIAZMZw6h3qN3Znx8eyknA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VdePvHJg; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VdePvHJg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZVVt5DF4z2xll
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 23:43:48 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E6BB2437;
	Tue,  9 Jun 2026 06:43:11 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8BBF3F905;
	Tue,  9 Jun 2026 06:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781012596; bh=gsPLZ/6wNx5smfboDFDZbwlQNRoOq0tSh+FJ8vH4Sq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VdePvHJgxJOe1dY8fL/GyRImPjZC211XqLf1CRh8e+OlR7sAHSTSRvm/CDfHIje1r
	 LphvOA/eLEwMoTILXuNzkRN89nvHyZofNbc5Tgstwe+A12chZvnn1N4E+yvrRZI/gN
	 M3BSKz50eWnASlzIVYiwpL5xaVu6OizZaXiJJOk4=
Date: Tue, 9 Jun 2026 14:43:08 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
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
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <aigYbK12D8uKQvJF@arm.com>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260604083959.1265923-1-aneesh.kumar@kernel.org>

On Thu, Jun 04, 2026 at 02:09:39PM +0530, Aneesh Kumar K.V (Arm) wrote:
> This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
> dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
> are handled consistently.
> 
> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
> shared/decrypted buffer handling. This series consolidates the
> force_dma_unencrypted() checks in the top-level functions and ensures
> that the remaining DMA interfaces use DMA attributes to make the correct
> decisions.

Please check Sashiko's reports, it has some good points:

https://sashiko.dev/#/patchset/20260604083959.1265923-1-aneesh.kumar@kernel.org

I think the main one is the swiotlb_tbl_map_single() changes which break
AMD SME host support. There cc_platform_has(CC_ATTR_MEM_ENCRYPT) is true
but force_dma_unencrypted() is false. Normally you'd not end up on this
path but you can have swiotlb=force.

> Aneesh Kumar K.V (Arm) (20):
>   s390: Expose protected virtualization through cc_platform_has()
>   dma-direct: swiotlb: handle swiotlb alloc/free outside
>     __dma_direct_alloc_pages
>   dma-direct: use DMA_ATTR_CC_SHARED in alloc/free paths
>   dma-pool: track decrypted atomic pools and select them via attrs
>   dma: swiotlb: pass mapping attributes by reference
>   dma: swiotlb: track pool encryption state and honor DMA_ATTR_CC_SHARED
>   dma-mapping: make dma_pgprot() honor DMA_ATTR_CC_SHARED
>   dma-direct: pass attrs to dma_capable() for DMA_ATTR_CC_SHARED checks
>   dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED
>   dma-direct: set decrypted flag for remapped DMA allocations

Patch 10 above...

>   dma-direct: select DMA address encoding from DMA_ATTR_CC_SHARED
>   dma-pool: fix page leak in atomic_pool_expand() cleanup

Patch 12...

>   dma-direct: rename ret to cpu_addr in alloc helpers
>   dma-direct: return struct page from dma_direct_alloc_from_pool()
>   iommu/dma: Check atomic pool allocation result directly

and I think patches 14, 15 are independent fixes. Some of them even have
Fixes: tags and Cc: stable. Please move them to the beginning of the
series to avoid inadvertent dependencies and make them harder to
backport. It's also easier to follow the series without random fixes for
mainline in the middle.

>   dma: swiotlb: free dynamic pools from process context
>   dma: swiotlb: handle set_memory_decrypted() failures
>   dma: free atomic pool pages by physical address
>   swiotlb: Preserve allocation virtual address for dynamic pools
>   swiotlb: remove unused SWIOTLB_FORCE flag

-- 
Catalin

