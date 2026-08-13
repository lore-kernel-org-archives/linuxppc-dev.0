Return-Path: <linuxppc-dev+bounces-25812-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F53FC5AC67
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 08:48:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLJsp37jKz2yNj;
	Thu, 13 Aug 2026 18:48:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786610894;
	cv=none; b=VGWG4GGzHsUxy3nIRJvy1la/29yIon9muvwmrBuWgIbGK7/H8eiuXZq4imzWcEU6nAHeZ0XGfTMxt1q90csRo3TTzTgDcdUgu/evIUUPNoGrwDfsoXRumBtAbUHtaadONPJeagqKN0GSW43UsDTD0uGcqXlYXo0WX4CvZcDeSdFSh8443O09bmiwKnNV29IS4JDCTVC11XJRDsc3e9i78m+Jflp74QdhYbZrtGF1iYYwyJwTFTv2BFUj5GBLPOX7Cg4Sz53smDrS3/Z7CMlaEbHZHxNQkt7MV18ZYXLlw25Y0U2szB5TMlwIVmh8/jtxcPawWFLhg41oWdwvq53YXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786610894; c=relaxed/relaxed;
	bh=SoWTkmUJh/zufVuD2EZbwPjMgkQ/naSZXgSsBw6ff3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDC4cKB+PCTflQG+KB8g3rrIojfG9CB4ahAf+Mg0a/8Hlp5M5/t3VeLQwlyMFE0bt8UqDHDMVv2csTueWqrlTTp5kKOBvC4LY6O0brlLvxgeRG4JwOoCee30VKqLj1Jo0+zwfmVOn2JADeHKTmFxs9nFMZx6vaaEQ//p3Z+8Uy14HZWH1f27VV4QPT82H4vteXnG5/ZuvoJvbh2cFvC+Oj7pJU0XX/up94Q5Gu1KsMp00THFtTKnfNrRhhqQuSaHx8r+WodtA2aIni/o/zLVQiR9IK7FaMscYxGCNLNr5e6afGRxJp9i665Wm8Yk4se8ahbjKdDk4cKFgLro1RqbDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kT2LB7gW; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kT2LB7gW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLJsl23vQz2y32
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 18:48:09 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDACB153B;
	Thu, 13 Aug 2026 01:47:31 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B7F53F632;
	Thu, 13 Aug 2026 01:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786610855; bh=u5KMzGgVOcLWbuPlGu/sTLdzSGT3hVGWZa68nwwdEyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kT2LB7gWPYpgXVp71WWZoEXALMvIuyrYp2tyQrSRM7LMcXDOoynp3ByKSZ/tbnOds
	 7sOyvXvON5GdcI8v+AGnoMPFjNbyQnUOJYmgJ/wJu21XtiGgJJDFOhsnMhJdtg/Kps
	 Ku5KeVrNaQDn+9+ZGLenYYr12tmjJiDAlfff6Owc=
Date: Thu, 13 Aug 2026 09:47:28 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
Subject: Re: [RFC PATCH] dma: swiotlb: Size shared default pools for memory
 encryption
Message-ID: <an2EoONjyp570tvB@arm.com>
References: <20260811134056.756015-1-aneesh.kumar@kernel.org>
 <anxEc8EHmJQywVI5@arm.com>
 <yq5ajypvioks.fsf@kernel.org>
 <anysnQFVTO_RAYxp@arm.com>
 <yq5aecg2io0u.fsf@kernel.org>
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
In-Reply-To: <yq5aecg2io0u.fsf@kernel.org>

On Thu, Aug 13, 2026 at 11:02:17AM +0530, Aneesh Kumar K.V wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> > On Wed, Aug 12, 2026 at 04:38:03PM +0530, Aneesh Kumar K.V wrote:
> >> Catalin Marinas <catalin.marinas@arm.com> writes:
> >> > On Tue, Aug 11, 2026 at 07:10:56PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> >> Systems with memory encryption use swiotlb to provide shared or
> >> >> unencrypted buffers for device DMA. Confidential guests may route all
> >> >> DMA through these buffers, while SME hosts use them for devices that
> >> >> cannot address encrypted memory. The default swiotlb pool can therefore
> >> >> be exhausted under I/O-intensive workloads.
> >> >> 
> >> >> Let architectures mark the default swiotlb pool as shared before
> >> >> swiotlb_init().
> >> >
> >> > I thought we wanted even this decision to be moved out of the arch code.
> >> 
> >> Architectures may want to use an unencrypted swiotlb pool for different
> >> reasons, one of them being CC_ATTR_GUEST_MEM_ENCRYPT. x86 hosts also
> >> require unencrypted pool to support SME. We can cover both cases using
> >> CC_ATTR_MEM_ENCRYPT.
> >
> > Yes but in one case it did not do resizing. With your proposal, it now
> > does swiotlb resizing even for SME.
> 
> Isn't that a bug with x86 SME? I would expect both SME and SEV to
> require that swiotlb resize.

Maybe, but that's for a different discussion (and we may want different
sizing). Better to keep the semantics unchanged for now.

> >> > BTW, why does arm64 report CC_ATTR_MEM_ENCRYPT instead of the GUEST
> >> > option in realms?
> 
> This is getting fixed in  
> https://lore.kernel.org/all/20260701054926.825925-9-aneesh.kumar@kernel.org/

You might want to bring this early together with the swiotlb adjustment
here.

> >> For the same reason I mentioned above, architectures may have different
> >> reasons for setting cc_shared = true. IMHO, it is cleaner to let the
> >> architecture code make that decision before swiotlb_init().
> >
> > The arch code already reports cc_platform_has(), can we not rely on
> > this in the core code instead of specific is_realm_world() and a new
> > SWIOTLB_INIT_CC_SHARED flag or function call?
> >
> > We have three different decisions that shouldn't be driven by a single
> > flag from the arch code:
> >
> > 1. allocate default pool
> > 2. make default pool shared
> > 3. resize default pool
> >
> > (1) is traditionally driven by arch code and that's fine. For (2), the
> > core code has the information via CC_ATTR_*. For (3), we can enlarge it
> > based on CC_ATTR_GUEST_MEM_ENCRYPT in combination with rmem (but not
> > CC_ATTR_MEM_ENCRYPT to keep the current x86 behaviour).
> 
> Okay, if the presence of restricted-dma-pool is taken as a hint, we can
> definitely move that to generic code.
> 
> I still think not resizing the swiotlb pool on the host for SME is an
> x86 bug. However, I'll keep it compatible with the current behavior and
> use CC_ATTR_GUEST_MEM_ENCRYPT for now. We can handle host SME in a
> separate patch if needed.

Sound good.

> > I think we should also move the reduction based on
> > CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC into the core code. Riscv copied the
> > same heuristic as arm64, so there's precedent for sharing.
> 
> I already have a patch doing that.

Great. Now you have a 3-patch series for the generic swiotlb sizing ;)

-- 
Catalin

