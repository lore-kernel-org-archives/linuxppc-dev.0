Return-Path: <linuxppc-dev+bounces-25872-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99D0C5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 16:16:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hM6mB45Dtz2y8G;
	Sat, 15 Aug 2026 02:16:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786724170;
	cv=none; b=l9kT4yEqCIH04hHFHdNduaRc/YcwPxfkOsg0QjrLFmyis3h7/PtBz2FknlztSkJBNOLSWBLrXpAdzXM6Dp1g9j2gwfM0+VUtzk1Hod4G3/se+kacQQAtb0RBSJKNZDV9m94c2/clDMXD4ZPYFLy3xBK/QntEh0ZUxbeDM+liR+T71LvTPLtZ/Nphrvz+ibsOPpeQGcPY1mBGdJ1DzATjZc2eQrgDbA0JSg4YM4JJJcfsG2yWkVRFit3VjWeaNISL8jJl8lj6WcGm8D6Pe3iMEOCNkNAq9ivB4ytPTqFKDs/IUKLwlR7KyEkOOUuDlqxo9JJ96r6I0Q8wXU+TQJ7KPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786724170; c=relaxed/relaxed;
	bh=ANRY6z832Ro79eJkIpumMqXKf2RRmUpXrfx0OSabUaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ft8pqsHgDr7EXBGQaZjdxd0TvBQri1V1a1FCoPm1HoKrGX+e+1EKNg2kDiLNJff/IyQpita4PUm/0WGs5ltcQevtXkVoDaSkpQKk2vvgQgbrciWJDZwqouiDEII6mbnojFRksK7nChIYz16XvUSVrYM2FyiVtEBBLiuzyfGRAuxp137thSf+b7/SkVrRmcyFF8a6uetBrTT9HiU4htAjxNGpm9xPFqHvto/Uv+Fy9WMCJE5AD2EQJfuz/0PiNkGijHxAIwUJFmbguZYwNGF/lmeH/QweDfapWRkn39M9VRLQGZ5isEHKhDcOyva6Lm1zMFHtavlVOz5sR2Z3nHZ8Zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cbfJLndh; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cbfJLndh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hM6m06W2Kz2yv9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 02:15:58 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 435B01596;
	Fri, 14 Aug 2026 09:15:21 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0879C3F632;
	Fri, 14 Aug 2026 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786724125; bh=CDXQA+EPdlI0BbPlq/PGU1VNQn7L/CNo5Id1Sf3ism8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cbfJLndhxTyrWoqa7N0FvMI7C5ellZPkmqibKvH/xugi4DkwGUR8MXxECibikKhHA
	 r2peZGXac4kfP7Iq+wBnj49hJv4z1WzdVYAlmECjmYuTAyTPTllk67UYCjRBKitdio
	 +Xjl6D4uqfp94Fg6zciUVaBL+LX0gfOk2Ey1b8pE=
Date: Fri, 14 Aug 2026 17:15:18 +0100
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
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [RFC PATCH v2 1/2] dma: swiotlb: Centralize default pool
 initialization and sizing
Message-ID: <an8_FvcdI01XmVXs@arm.com>
References: <20260813102521.1367737-1-aneesh.kumar@kernel.org>
 <20260813102521.1367737-2-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260813102521.1367737-2-aneesh.kumar@kernel.org>

On Thu, Aug 13, 2026 at 03:55:20PM +0530, Aneesh Kumar K.V (Arm) wrote:
> The addressing_limited argument to swiotlb_init() no longer describes
> all the reasons why a default swiotlb pool may be needed. Confidential
> computing systems need a shared pool even without addressing limitations,
> while some systems need a smaller pool for bouncing unaligned kmalloc
> buffers.
> 
> Replace the argument with SWIOTLB_INIT_ADDRESSING_LIMIT and
> SWIOTLB_INIT_CC_SHARED reason flags, and add swiotlb_should_init() to
> determine whether initialization is required for limited DMA addressing,
> confidential-computing shared DMA, unaligned kmalloc bouncing, or
> swiotlb=force.
> 
> Have architectures report addressing-limit and confidential-computing
> requirements before swiotlb_init(). Mark CC pools shared before their
> memory attributes are updated, and keep both addressing-limited and
> CC-shared pools at their normal size instead of applying the reduced
> kmalloc-only sizing policy.
> 
> Move the reduced kmalloc-bounce sizing policy from arm64 and RISC-V into
> the SWIOTLB core. This keeps architecture code responsible for reporting
> why a pool is needed while centralizing initialization and sizing
> decisions.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/arm/mm/init.c                   |  6 +++-
>  arch/arm64/mm/init.c                 | 18 ++++------
>  arch/loongarch/kernel/setup.c        |  2 +-
>  arch/mips/cavium-octeon/dma-octeon.c |  2 +-
>  arch/mips/loongson64/dma.c           |  2 +-
>  arch/mips/sibyte/common/dma.c        |  2 +-
>  arch/powerpc/kernel/dma-swiotlb.c    |  4 ++-
>  arch/powerpc/mm/mem.c                | 15 +++++++-
>  arch/powerpc/platforms/pseries/svm.c | 10 ------
>  arch/powerpc/sysdev/fsl_pci.c        |  1 +
>  arch/riscv/mm/init.c                 | 18 +++-------
>  arch/s390/mm/init.c                  |  2 +-
>  arch/x86/include/asm/iommu.h         |  2 ++
>  arch/x86/kernel/amd_gart_64.c        |  1 +
>  arch/x86/kernel/pci-dma.c            | 17 +++++----
>  arch/x86/mm/mem_encrypt.c            |  4 +++
>  include/linux/swiotlb.h              | 12 ++++---
>  kernel/dma/swiotlb.c                 | 52 ++++++++++++++++++++++++----
>  18 files changed, 109 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 0cc1bf04686d..aca97a4e5dcd 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -223,7 +223,11 @@ static inline void poison_init_mem(void *s, size_t count)
>  void __init arch_mm_preinit(void)
>  {
>  #ifdef CONFIG_ARM_LPAE
> -	swiotlb_init(max_pfn > arm_dma_pfn_limit, SWIOTLB_VERBOSE);
> +	unsigned int flags = SWIOTLB_VERBOSE;
> +
> +	if (max_pfn > arm_dma_pfn_limit)
> +		flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
> +	swiotlb_init(flags);
>  #endif
>  
>  #ifdef CONFIG_SA1111
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index e308a7cabd12..9f5b366d2086 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -338,19 +338,15 @@ void __init arch_setup_zero_pages(void)
>  void __init arch_mm_preinit(void)
>  {
>  	unsigned int flags = SWIOTLB_VERBOSE;
> +	/* pKVM uses restricted-dma-pool */
> +	bool cc_guest = is_realm_world();
>  
> -	if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
> -		/*
> -		 * If no bouncing needed for ZONE_DMA, reduce the swiotlb
> -		 * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.
> -		 */
> -		unsigned long size =
> -			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
> -
> -		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
> -	}
> +	if (cc_guest)
> +		flags |= SWIOTLB_INIT_CC_SHARED;
> +	else if (max_pfn > PFN_DOWN(arm64_dma_phys_limit))
> +		flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
>  
> -	swiotlb_init(true, flags);
> +	swiotlb_init(flags);

I like the idea of more flags than the boolean for address limit.
However, depending on when such patch would go in (presumably on top of
what's currently in -next), we may not need the SWIOTLB_INIT_CC_SHARED
at all here just to remove it in the second patch. I think we have all
the information available already.

Other than that, it looks fine to me. If you repost at -rc1, hopefully
Sashiko will manage to apply it.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

