Return-Path: <linuxppc-dev+bounces-27579-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DCEC982D6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 14:48:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlzCB2P8Jz2y2W;
	Fri, 18 Sep 2026 00:48:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789656502;
	cv=none; b=F2S+MFu0r0JzmBJebQfjf8i9akHATj2p3jrh48UVtFwQvE8c3QqI+grkNHboEo/rB+lMsMpQfKEnTzsdUfQ85w507bMiwq98pHFAwppGonNHS4WCyashHfOI2qJUB4CD2dMe7uNOzkMNq+MsfRxGHaqvU9W18dmerWCznjrx2gebNqYAKpe27kMIiNWVRY4GVOoZN9E8wDvRF5M+iOrFM1p4qOlHlAuQB+vbfRSx7c0oYtmlwja99zE9Yuk/kPh8c1jE/4+OKbIWCf/gkcAcIPpjZFXBMoNNoIk/pVfHxsfuVUwbC9sme0NwIMe6Rxx914SfRGcTKUGes0s1fdOIgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789656502; c=relaxed/relaxed;
	bh=1TXHNfPeizA8o8U5zeR9HPM854xm6a245g4oK4MpUHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FK1u5ryLv6s+hpHvW0GHvzA2AIIe6+U+3ycXkRanmoarMXpho4y0QgU/eKmY9/sIvSWsby49Cej1Fkx8tA4vRlNmIjSalDJQiKhCQroXu1rGqG1ceilLz8YlIpHtkW2g0zAfmLb5TdRXtkIB69AKQnWgXa2rBmGQp6edWE2n1EWorAVFUJ+bOA8sEIxvo1N4ssUxp6k+XcjRnOegnjLXAxtDM8USPfD+P9hvxqgA9nJuXOu44ZY69YBiFzXer7kxYhHbkGQDm/gxdbnoEqWrlROXXgRBdB/SWJVROUfu3FdO4ZYWrMkgmVQgq4vYnVgN4USXlGp8kRy5fyKewPSrzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=FfOzLZ+3; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=FfOzLZ+3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlzC75Bc0z2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 00:48:18 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52F5B1476;
	Thu, 17 Sep 2026 07:47:42 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 011E03F86F;
	Thu, 17 Sep 2026 07:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789656465; bh=M6L3gDgo7kZ+fxTWrN1ZIsrMlAv/aP6jh31bZohJ0Rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FfOzLZ+3Qia0W7RivVKaHNN7ieAHkjlQ0vn4TRTzuF7z8OiKjJ/k086OfMvanwLe4
	 ELpOh1p5+42rsPtfbx27NAQlMXC2xMiCbIVs5xTJrXk64zRBISqHGguvSJA4aBz7vA
	 RLAIQplJPf8iM7ccnFiG8UpvaheI8Ih5+YH3OgPE=
Date: Thu, 17 Sep 2026 15:47:37 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
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
	Xu Yilun <yilun.xu@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v4 1/5] dma: swiotlb: Centralize default pool policy
 selection
Message-ID: <aqv9icxsfN3PLErN@arm.com>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
 <20260914070135.313337-2-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260914070135.313337-2-aneesh.kumar@kernel.org>

On Mon, Sep 14, 2026 at 12:31:30PM +0530, Aneesh Kumar K.V (Arm) wrote:
> diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
> index 3be2451e7bc8..22c8190fe34d 100644
> --- a/arch/x86/include/asm/iommu.h
> +++ b/arch/x86/include/asm/iommu.h
> @@ -14,8 +14,10 @@ extern bool amd_iommu_snp_en;
>  
>  #ifdef CONFIG_SWIOTLB
>  extern bool x86_swiotlb_enable;
> +extern unsigned int x86_swiotlb_flags;
>  #else
>  #define x86_swiotlb_enable false
> +#define x86_swiotlb_flags 0
>  #endif
>  
>  /* 10 seconds */
> diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
> index b5f1f031d45b..d0fbc0271e43 100644
> --- a/arch/x86/kernel/amd_gart_64.c
> +++ b/arch/x86/kernel/amd_gart_64.c
> @@ -814,6 +814,7 @@ int __init gart_iommu_init(void)
>  	dma_ops = &gart_dma_ops;
>  	x86_platform.iommu_shutdown = gart_iommu_shutdown;
>  	x86_swiotlb_enable = false;
> +	x86_swiotlb_flags = 0;

I don't think the flags are still read anywhere after this function.
gart_iommu_init() is called long after swiotlb_init(). So you can drop
this and make x86_swiotlb_flags static in pci-dma.c.

With this:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

