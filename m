Return-Path: <linuxppc-dev+bounces-28987-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FD5CA5FF1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2026 10:04:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j07ys4JXrz30CZ;
	Wed, 07 Oct 2026 21:04:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791367493;
	cv=none; b=d4vMJQANDGWC0KLavuOzIXR4cslW89Y1ntfUGAERGGnfaLqx6EnFh5oN3UHd1z7h15oS9OZGIzWqQSZywhXW3rDXMYMRW3D+BBK+I5Dexi6s4eWeMvKID2P/n7BbaxPyWta5RGu8z7CIeIZ1f8TAouHVsnHcKSiTIKzPsq+u2zxRP4N0CyMTt3x6CC781cPwxtMsTJ4veAHAvWBagup3LR1N+VRtTLzJKKYH4ska5Llc6ouVHjf3kBuz5aX+7Rblb36YJlp4BqnlQZy1hX4cInNoiX0bn2tkuD3OvkU+Ma9nhGSFdSOypj+MYDu0bG79OK7Vqtj073Y4gfYSVfzITg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791367493; c=relaxed/relaxed;
	bh=tXoZOat7TSm0SoGp6Oxn3YyJRs/T7t1zTztyNMt36pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDKPOhQogy24siMMnOp1eFNR3xD2FxZWTiEIZI8STOEkx8SiPVTknIkpi9I99mQARZz+FhSV++F/PQr6riHP8VTHhd1y5c5v4oMyuWsTthNWlNPyqBiMDO6EXycvvlpCZWyDsyqQKkYpXdudvB3niy8d57UlIyGbbbTICYTjE0l2wnIfarrA/inhTwJhCNOhf9iZlY0slISymtjfI00ITu30gFxvPP0j88vgUZ3BWpqFo9cipB5Ol91Fqz0J15yOIscYEnNj4grLUYpdickD3a+BzkixWUHt+x/3C97AhClLBBrq/LDrJ/Goc+x4Ww02oSvpOJLyLBj77C2Aqk5O3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=FvDQmLy4; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=FvDQmLy4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j07yp2gMgz2yqf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 21:04:48 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85BE1152B;
	Wed,  7 Oct 2026 03:04:12 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D0133F86F;
	Wed,  7 Oct 2026 03:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791367455; bh=CbXWi9ehHUC17LrX7h7fiWJISOx4QxW252o3EdbyLB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FvDQmLy4EGj89GAfvZk4KGPda4lF9dF5oeqcn5GaKKWzv0KKEFA+8t3r7QqyDC8G5
	 15dMv0AaR5+XBy9C4yatPq0j3+EwXMtpi531/x06RJAiNh8Dw7kgMptDkWV6AFLItD
	 7tFE/6cK6Ee5diPXgRQlJIGJZozxaEJpY12Bwfsw=
Date: Wed, 7 Oct 2026 11:04:05 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
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
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v6 6/8] dma: swiotlb: Centralize memory-encryption pool
 sizing
Message-ID: <asYZFXGyafRjjBS0@arm.com>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-7-aneesh.kumar@kernel.org>
 <asVs3doaJ4WrT3M2@willie-the-truck>
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
In-Reply-To: <asVs3doaJ4WrT3M2@willie-the-truck>

On Tue, Oct 06, 2026 at 10:49:17PM +0100, Will Deacon wrote:
> On Thu, Sep 24, 2026 at 11:37:54AM +0530, Aneesh Kumar K.V (Arm) wrote:
> > @@ -496,7 +516,8 @@ swiotlb_select_pool_policy(unsigned int flags)
> >  	if (swiotlb_force_disable)
> >  		return SWIOTLB_POOL_NONE;
> >  
> > -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> > +	    !restricted_dma_pool_present)
> >  		return SWIOTLB_POOL_CC_GUEST;
> 
> I think this check on the restricted DMA pool is too general -- the pool
> could be tied to a specific DMA-capable peripheral and so treating its
> presence as a global property isn't right.

I agree it's a hack but that was the simplest way to avoid the pVMs
getting a bounce buffer after this patch. More than happy to leave it
out and reduce the buffer on cmdline or we come up with some better
heuristics.

Another option could be the arch code passing another flag that it
doesn't want an encrypted pool (e.g. when running in a pKVM guest) but I
don't particularly this either. The arch code doesn't know whether
there's an alternative pool.

That said, such heuristics should have been a separate patch to make it
easier to review/drop.

-- 
Catalin

