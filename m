Return-Path: <linuxppc-dev+bounces-27582-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72296C88E72
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:03:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm0sx5BCvz2xbQ;
	Fri, 18 Sep 2026 02:03:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789661013;
	cv=none; b=GgnG+LhTFK9fkETc7UsOT8BPwLoCG6cW/PouTTo5//rZ8TIpQnDpcgflO/CjcQi6k2cyktrwIGpC7ZkeZFUK3SLYQjVeJcX8Xe4NM9G2uo2P36CiU9sGC6CuSvRCOo1LJ4hQu3hPnt5nsScrQ8WY7Bkd/uQ+HdA7XCSLiNhkiOA37vAsoV0NjEdE7drRtUrYvAy6s3TuF1r1SZ2rN0bb1xPgR0e27igA8I+z8zqQbSnZXggu2PCGJqJmg6LKm9SaqWYLtilsB+PSHWwx398lvNCrnWa8VZbun83+BCMVlmlA7hSVrnaArWiIOAnJyyF7SCt/mNEyFTdSkO8eXuFBow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789661013; c=relaxed/relaxed;
	bh=n9baZrzeQeG41zDPvfWu4ExVgKd47frrFZAecif66Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cz20wrXPyBaNPpJ7HAD4dxz6dwZ41OKWOst+pS9156z6+knDTmtrpxPMNcoWwUjT1COrgCvb1nGfKtFttLELqGdaSr/Oz4XrWDhcVoFpJ2Q3Mqq1itJBEY6SqRDiz2wyUX4YfwUU6AoG6ZkQy+NpaDndpHlM/3wp5SOLelScEOsixGyFN7t+O5nok919iG6ZtSluolUXZKys0f7ihkIxbLyzD7oMAu9Cw0MM5gUVuowmirUlpZkpLXuRCvnMTyXf78tbVL9fLJ7Xd/RhpzAtrdKGuhg/roSVGc9isqr2jxWpNn8tl3gXr1W+5pTZ+pTjd/vCBp+rB4WFr4P29OqQCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=S2fxmt5n; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=S2fxmt5n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm0sv03HYz2xCC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 02:03:28 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 676491476;
	Thu, 17 Sep 2026 09:02:52 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0676E3F7B4;
	Thu, 17 Sep 2026 09:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789660976; bh=oTSpkmkdrCN17NbG/BBwkxPXVynnbNeoywXS03zePeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2fxmt5n7wqW8D4QzBKWm8vc57hZzAXsLdw9Jtmn7fDwYuUkUjAjjz0iYC6XiR0tu
	 9uTMew8t9VAK7rJOxWX62e/iXJau/fZJ5mkD/AXyBAM4cL0DOiEE+aa31dFygWVPu6
	 NIHL5WfGiIh7klKkEub7eNcTGfyNDO5DXPYwmJRI=
Date: Thu, 17 Sep 2026 17:02:48 +0100
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
Subject: Re: [PATCH v4 3/5] dma: swiotlb: Centralize memory-encryption pool
 sizing
Message-ID: <aqwPKO80ZEn0cqa7@arm.com>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
 <20260914070135.313337-4-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260914070135.313337-4-aneesh.kumar@kernel.org>

On Mon, Sep 14, 2026 at 12:31:32PM +0530, Aneesh Kumar K.V (Arm) wrote:
> +/**
> + * swiotlb_adjusted_size() - get the prospective adjusted SWIOTLB size
> + *
> + * Return the size that confidential-computing guest sizing would select for
> + * the default pool, without changing the configured SWIOTLB size. An
> + * explicit swiotlb= size is always preserved. An explicit area count is
> + * included in the size calculation. Automatic area sizing is initialized
> + * later from the running kernel's possible CPU map and any resulting size
> + * adjustment is therefore not reflected in the returned size.
> + */
> +unsigned long __init swiotlb_adjusted_size(void)
> +{
> +	unsigned long nslabs, size = swiotlb_size_or_default();
> +
> +	if (swiotlb_default_size_changed() ||
> +	    !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +		return size;
> +	/*
> +	 * For SEV and TDX and CCA, all DMA has to occur via
> +	 * shared/unencrypted pages. Kernel uses SWIOTLB to make this
> +	 * happen without changing device drivers. However, depending on
> +	 * the workload being run, the default 64MB of SWIOTLB may not be
> +	 * enough and SWIOTLB may run out of buffers for DMA, resulting in
> +	 * I/O errors and/or performance degradation especially with high
> +	 * I/O workloads.
> +	 *
> +	 * Adjust the default size of SWIOTLB using a percentage of guest
> +	 * memory for SWIOTLB buffers. Also, as the SWIOTLB bounce buffer
> +	 * memory is allocated from low memory, ensure that the adjusted
> +	 * size is within the limits of low available memory.

Nit: if SWIOTLB_ANY is passed, do we still allocate only from low
memory? I think this comment made sense on x86 but it's not valid for
s390, pseries with the changes so far.

Otherwise:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

