Return-Path: <linuxppc-dev+bounces-27585-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62BCC88E72
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:09:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm10k2Xd0z2xCC;
	Fri, 18 Sep 2026 02:09:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789661366;
	cv=none; b=ntjjz5LJwoxgJg1dbiMpwZlGvJBEbCQzNykKk2SFJX10RkZuGlZIl7IajrJu7awAHgVeK4oyb++Z871bAheEX52wty6cc9evYpnKZY/no+t0vEaU0/EgS/8yfaSPHQYzUtHf/0mnNtYl/lJuXF6U91bDid/mYPFe3kY/O/IEIgHZn2bJ8egAK9kBcMIb6+293TX+R2texLQDvHUQNvxZ52IzBWqHGcgSlAVDlLHfzxeaBZp/yI+YubXr8Jv+VNSWcGuM0sP+16IxXdA3iGwdMQ3XkGJsOgdEzETzY1aBunFilrpnXTu0CmtORkSnivJCC5+MHSdEfdXeGR2nzhQodg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789661366; c=relaxed/relaxed;
	bh=ZelrVAC8hza6e4DyNfSmnXov3Kf0KltqsG+OQSTaRyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/k1aovoYjQtcFfvjKvhzI3lJuBWlc8SjJHo6rDi+KN5Qi/goV6F2UG6e3QnkkPuyQPtQ4AUGpqCC4IhxOWY30cc5YfGKH1pToPdZnZnYktO1QdzsmpUGVZVbZCZrsQYv/uB8evPukbcqOmYyjoGe7nPl4+CO3Nhan4jsuDFL4kdth3Oq/n2Y0UYSXidcbFp5QkRc90mDlPqyiGF63X/lJRecnxNo6p9kidYs+77SBYPy5tmsQ4i9fwIYngYmwyXXWL3ysHbFA1ZN7OAYc+JzEhvaqu/7/W29HkAuzfZDH1FIMHFxAn3qUNK6LrQQJNztUg2Lg0sVdfcMnKSFY6oEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=fg2BVR2h; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=fg2BVR2h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm10h1Yjjz2xSR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 02:09:23 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D71DA1476;
	Thu, 17 Sep 2026 09:08:48 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C2B23F86F;
	Thu, 17 Sep 2026 09:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789661332; bh=LTrp4k+I8MTH1TFb/n0jAUNy6sMkQLKvNVm0Ssk0Ik4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fg2BVR2hsmdfzOw802jgLmkU4C8dYgDiVodN/BCQcJnNlXQvUZTot4764bZzdYHoP
	 KpxaXu68DSJ+nTWkJw0nr52jlY0S/pY38k0WZGKhlRoxtkP4hWgPjgsWanps+qYf6p
	 OWz0B8EVzI71pY/BTigybbpetQ2VZbhxL7LsQAdw=
Date: Thu, 17 Sep 2026 17:08:43 +0100
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
Subject: Re: [PATCH v4 5/5] dma: swiotlb: Remove SWIOTLB_ANY
Message-ID: <aqwQi0AGG6NvHKHG@arm.com>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
 <20260914070135.313337-6-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260914070135.313337-6-aneesh.kumar@kernel.org>

On Mon, Sep 14, 2026 at 12:31:34PM +0530, Aneesh Kumar K.V (Arm) wrote:
> swiotlb pools are currently allocated below the architecture's low
> address limit by default. SWIOTLB_ANY overrides this and permits
> allocation anywhere in directly mapped memory.
> 
> SWIOTLB_INIT_ADDRESSING_LIMIT now explicitly identifies callers which
> need a pool that is reachable by devices with limited DMA addressing.
> Use it as the placement constraint and remove SWIOTLB_ANY.
> 
> This changes the default behavior for callers which do not set either
> flag. Previously, omitting SWIOTLB_ANY placed the default pool below the
> architecture's low address limit and also constrained dynamically
> allocated pools to the same range. After this change, omitting
> SWIOTLB_INIT_ADDRESSING_LIMIT permits both static and dynamic pools to
> use any directly mapped memory.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

