Return-Path: <linuxppc-dev+bounces-25781-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689D5C5B572
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 17:26:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKwQM2tRwz302l;
	Thu, 13 Aug 2026 03:26:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786555595;
	cv=none; b=U5kBXHzBtMhYt9TlvrYi2oS+kU8Sl8mfwM+qZRe6gbikwUbdX+fBSuBdd6FFSEyasNQE3LfAwyRemHGiAiOjn7Z39mlUx7ig/Zi2AxLwiS/Mb5YqX00SV7fCo51lwZvRs2p4R+WFG2cSmIPLu2vph3bHg/ICTn/QyMTBdpIZLjF7H3Qg2J99pvY+eCG6ru86W06Vt385U2FpPHyJ7yBcdRjmygsDfX8XukA+r5yqS//UD26pwWdfgM3uKvGp7N2mXvgW37Xcd0dIdGkm9SYW48xNDgovCht+386Y2oNjulMO+GnjQY3imm4bjPuJfaDZIScQsaOsFDBMNSHyZrHeIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786555595; c=relaxed/relaxed;
	bh=sgtKXHzGDDQyHWV9xugerf2/7MZfWzmH0C1BOKc6FKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxd/uzRjEwPVj1jl5GKAgebR5emQ8LKGafuE1TYns+02Qcy4X5jHggMvlnWCmHr9WsIqKlYuCC3Y0j9kAHxFAFLc6bq44AK8T123zMmcM3MJNUUIXhCG9/7kc3CkF3vKO+9lfGz43ndMn3yt23ZprDzcE/CuBuzMedaqFBkltsrdqvPsXWBqYHWOXT4Asgy4CGDMjYP1CZdspCgUVSjMOwPVoO+wa9Re4fRpsyLo28k2Xw9s44ZFgMbTrSvtF6JHOFER8Uzx4r4cXR4mipQ8uK5RI3Yjsp6NXaG/6lRcupyOB9NKke0kS5HomR7ks2nQuofoUKBIHLDMomSevvIQlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=B7MvlTwC; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=B7MvlTwC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKwQJ1cFZz2yvB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 03:26:29 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 027DA1596;
	Wed, 12 Aug 2026 10:25:53 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B91943F66F;
	Wed, 12 Aug 2026 10:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786555556; bh=H8Ctj6oiAsOEpGNBs0wlRNq4MV8mA+m6BBgfdUbyouk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7MvlTwCYIwI4GDClgPFTpjUn0sPusFPcML8t810t+/14DjgB7H6MHkilb/6UiE7z
	 ygNoSqQ5anoFHIng2RTl38bEgQufRq6aCROSFR8PsvTOYN+DONSLOZ4RNcz/oEDVl8
	 rDzolVsJ4vasql17ywsCsdZsl95wvqEHSbsasHfo=
Date: Wed, 12 Aug 2026 18:25:49 +0100
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
Message-ID: <anysnQFVTO_RAYxp@arm.com>
References: <20260811134056.756015-1-aneesh.kumar@kernel.org>
 <anxEc8EHmJQywVI5@arm.com>
 <yq5ajypvioks.fsf@kernel.org>
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
In-Reply-To: <yq5ajypvioks.fsf@kernel.org>

On Wed, Aug 12, 2026 at 04:38:03PM +0530, Aneesh Kumar K.V wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> > On Tue, Aug 11, 2026 at 07:10:56PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> Systems with memory encryption use swiotlb to provide shared or
> >> unencrypted buffers for device DMA. Confidential guests may route all
> >> DMA through these buffers, while SME hosts use them for devices that
> >> cannot address encrypted memory. The default swiotlb pool can therefore
> >> be exhausted under I/O-intensive workloads.
> >> 
> >> Let architectures mark the default swiotlb pool as shared before
> >> swiotlb_init().
> >
> > I thought we wanted even this decision to be moved out of the arch code.
> 
> Architectures may want to use an unencrypted swiotlb pool for different
> reasons, one of them being CC_ATTR_GUEST_MEM_ENCRYPT. x86 hosts also
> require unencrypted pool to support SME. We can cover both cases using
> CC_ATTR_MEM_ENCRYPT.

Yes but in one case it did not do resizing. With your proposal, it now
does swiotlb resizing even for SME.

> However, pKVM does not want an unencrypted SWIOTLB
> pool. So I was thinking it would be much cleaner to let the architecture
> code drive that decision.

Let's not single out pKVM but rather the reason it does not want one -
it relies heavily on restricted mem. If you started a pKVM guest
without rmem in DT, I assume it will need swiotlb to function properly.
It's not a great heuristic (devices may not use rmem) but it preserves
the current behaviour and can be overridden on the command line.

> > BTW, why does arm64 report CC_ATTR_MEM_ENCRYPT instead of the GUEST
> > option in realms?

It's still not clear to me why we went for CC_ATTR_MEM_ENCRYPT instead
of CC_ATTR_GUEST_MEM_ENCRYPT.

> For the same reason I mentioned above, architectures may have different
> reasons for setting cc_shared = true. IMHO, it is cleaner to let the
> architecture code make that decision before swiotlb_init().

The arch code already reports cc_platform_has(), can we not rely on
this in the core code instead of specific is_realm_world() and a new
SWIOTLB_INIT_CC_SHARED flag or function call?

We have three different decisions that shouldn't be driven by a single
flag from the arch code:

1. allocate default pool
2. make default pool shared
3. resize default pool

(1) is traditionally driven by arch code and that's fine. For (2), the
core code has the information via CC_ATTR_*. For (3), we can enlarge it
based on CC_ATTR_GUEST_MEM_ENCRYPT in combination with rmem (but not
CC_ATTR_MEM_ENCRYPT to keep the current x86 behaviour).

I think we should also move the reduction based on
CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC into the core code. Riscv copied the
same heuristic as arm64, so there's precedent for sharing.

-- 
Catalin

