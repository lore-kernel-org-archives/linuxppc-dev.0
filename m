Return-Path: <linuxppc-dev+bounces-25686-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7C9C5AD7B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 15:58:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJfZ75Lrzz2yxG;
	Tue, 11 Aug 2026 01:58:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786377535;
	cv=none; b=dpJYlT2pBujYzSCCTV3cn1z9aQ6Wur5/BIQnl0seNNUkDTePiH91aagIBmLXqtyDUeEnCXvk1+Xpv0nmEquWQmX40TDPEe2WtrcS+2ZmDL6p7NaK9aLWsBNXikvv8FX+Ub5ZlhaB/E08EIpL5Vwzq9gwN0iZ/Rq6i18qKz6b55hJRGhLoWW+GxFHGg1mJiwYmVI71+eXw21lCj0Nof3ifFltgCivvjLKcCjW+hdbwjwRtHr8vom4jzwRFMMl6PK+5pRK2r49xu84fuhzj7ocObBEOoVK83kw+gta5uTbiHROgBHtnAGKMiMkdWHJ1T0Oeh3dUeNo2DJTS+8bp3vNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786377535; c=relaxed/relaxed;
	bh=JNujZOp6SvxQUqxxQAnbQ1M+55BGiKjS96+FFU7yPIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjfOTdf50rV5HQMDXDyc4/pB0nCNpwvM38FubnxXdq++Llkyb3F/VER9RoqLuMzEwg7kzlfA/t+ZEXKj9/D+xTyRGpN/nKKO66MLTWdbJueHlDbWAF/ENtmFiv4IHket85qDD6wXmwNtCYd0etCcvej2jf1PYBukwSFdClWqYJu+oCrlTJDBVaPWyMVNMuG1mMXtzaSTCE6TWl+n8Pzgxufg9kPHZsn/Kgfj09tz3Y+uUuRY5sn1gXXLOvns7s/IaL2aApB6V72huyO94Lf6rAM/aERo7e+mQ5SmCIaEJWwOEHQ71wsqWTJeVcBLYEk62AS+kEtaiT4F1bQxYofz3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IhYR6wGF; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=will@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IhYR6wGF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=will@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJfZ62bcxz2yn2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 01:58:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8DD38600C8;
	Mon, 10 Aug 2026 15:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32581F000E9;
	Mon, 10 Aug 2026 15:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786377530;
	bh=JNujZOp6SvxQUqxxQAnbQ1M+55BGiKjS96+FFU7yPIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IhYR6wGF3mEiQ3fkJyZhchwlWwIuqXxVgyx97z/WA5KqRyecBvU6zy0Hg6lpL6SYc
	 QYBTi9wWbkz2DzQw8TXn15QrwGtypcBN8ddGE/Tmw2xZabRVlmCPnVn3Pt9SCQ3iMU
	 ZEuaVfhKzSumYrsNU8o+wPC7nO0Bf+UYG2VwfktxmZieTUBvDcQu6G3ZvJXyjbmnz4
	 oZ91MIsniybaPNFpcM00hW3/IkLRXu+8tSKD0ph/X9SR8iMO4R0qfJrl3QX5gC6mcC
	 A4uZ0ogkLO08jyHFqegDcY3/L7mDflUgMhXn27rszSsNTXcJoGL9n6J0zvvHOF8rHg
	 QPolLhvuE/uSg==
Date: Mon, 10 Aug 2026 16:58:42 +0100
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
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
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
Message-ID: <ann1MnO8bADV9EGe@willie-the-truck>
References: <CGME20260807182023eucas1p1f653436207b2b00338e99ea1d8f847df@eucas1p1.samsung.com>
 <20260807182017.GH200537@ziepe.ca>
 <7d22482f-d5fd-4cf4-9d32-6a54e02f2fbb@samsung.com>
 <yq5av79iiard.fsf@kernel.org>
 <anml6lLRERm1Iv-_@willie-the-truck>
 <28442500-1d53-4776-bae5-459c3ffc1cc6@samsung.com>
 <anm6K2umtx4iKnyZ@willie-the-truck>
 <20260810130818.GN200537@ziepe.ca>
 <annc1ynWUsWQc4JM@willie-the-truck>
 <annx8-HDjTq933vp@arm.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <annx8-HDjTq933vp@arm.com>

On Mon, Aug 10, 2026 at 04:44:51PM +0100, Catalin Marinas wrote:
> On Mon, Aug 10, 2026 at 03:14:47PM +0100, Will Deacon wrote:
> > On Mon, Aug 10, 2026 at 10:08:18AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Aug 10, 2026 at 12:46:51PM +0100, Will Deacon wrote:
> > > > On Mon, Aug 10, 2026 at 01:37:11PM +0200, Marek Szyprowski wrote:
> > > > > On 10.08.2026 12:20, Will Deacon wrote:
> > > > > > On Mon, Aug 10, 2026 at 02:59:42PM +0530, Aneesh Kumar K.V wrote:
> > > > > >> Marek Szyprowski <m.szyprowski@samsung.com> writes:
> > > > > >>
> > > > > >>> On 07.08.2026 20:20, Jason Gunthorpe wrote:
> > > > > >>>> On Fri, Aug 07, 2026 at 06:13:49PM +0000, Mostafa Saleh wrote:
> > > > > >>>>> But the whole thing is best effort anyway, the kernel picks
> > > > > >>>>> IO_TLB_DEFAULT_SIZE which does not depend on the system topology or
> > > > > >>>>> how many devices or how much DMA they do.
> > > > > >>>>> SWIOTLB memory is wasted if unused so we should be careful around
> > > > > >>>>> that as it would be the other way around and users would have to
> > > > > >>>>> decrease it manually.
> > > > > >>>> Yeah, it is why the arch code shouldn't really be sizing it directly,
> > > > > >>>> it should be done in common code and, yes, we are probably going to
> > > > > >>>> have to do something alot smarter to have the common code better
> > > > > >>>> auto-tune this for the CC case..
> > > > > >>> What about the $subject patch? I assume that it is still needed to
> > > > > >>>
> > > > > >>> restore the behavior that was altered by the "[PATCH v8 00/23]
> > > > > >>>
> > > > > >>> dma-mapping: Track shared DMA state through direct, pool and swiotlb
> > > > > >>>
> > > > > >>> paths?" patchset?
> > > > > >>>
> > > > > >> I would request that we pick this patch to fix the regression described
> > > > > >> in https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org/.
> > > > > > I really don't think we need it. CCA hardware isn't exactly widespread
> > > > > > and the KVM host side patches don't appear close to being merged.
> > > > > 
> > > > > Does this mean that the branch for-next/coco [1] won't go to v7.3-rc1?
> > > 
> > > Let's not make progress on guest support contingent on KVM CCA host
> > > side patches please. I expect the CSPs will have VM instance types
> > > available based on CCA within quarters, and Linux as a Guest should
> > > work in those environments regardless of what KVM is doing. I don't
> > > really expect full KVM support for years, frankly, the patchset is
> > > massive. Even Intel and AMD don't have full KVM support yet.
> > 
> > To be clear: the only part I'm pushing back on is the realm-specific hack
> > to size the SWIOTLB area in arch/arm64/. Even with that hack applied, I
> > don't believe a one-size-fits-all value is going to work for everybody,
> > so it was really great to see that special-case removed in:
> > 
> > https://lore.kernel.org/all/20260717180442.110954-18-aneesh.kumar@kernel.org/
> 
> We had Mostafa's patch here:
> 
> https://lore.kernel.org/all/20260603110522.3331819-4-smostafa@google.com/
> 
> adding the same swiotlb buffer allocation for pKVM guests and realms.

Yes, and I think that's bad for pKVM guests which is why I'm happy to
see that part removed.

> Aneesh's cleanup of SWIOTLB_FORCE inadvertently removed the 'else'
> clause and limited_addressing is now always checked, meaning that we get
> size limiting irrespective of whether we still need a default swiotlb.

Inadvertently, perhaps, but it's got Tested-bys from three different
companies on it and I think it's a good change. I don't think we should
be special-casing these environments based on some random collection of
virtio devices in a testing setup.

> Normally I would consider this a regression on top of mainline and
> Mostafa's patches rather than a cleanup. However, if the default size of
> the bounce buffer was never sufficient for realms, as you said, we may
> need something better here anyway, so not worth fixing.
> 
> I can see x86 in mem_encrypt_setup_arch() adjusting the bounce buffer to
> 6% of the guest memory. We could make up similar logic for arm64 or we
> could just rely on CONFIG_SWIOTLB_DYNAMIC (default off currently for
> arm64 I think).

As Jason said, this should be done outside the arch code.

Will

