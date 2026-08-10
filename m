Return-Path: <linuxppc-dev+bounces-25678-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D222EC5AE49
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 14:15:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJcGD2VrWz2yxG;
	Tue, 11 Aug 2026 00:15:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786371300;
	cv=none; b=bPYdJ9hg9J2LBMQ3qJGyxcZQHVYbD9D6j/1IsVH3zYj9hvNwImlgsFX+jo1ju0ey3vQaHXwwBpQtD14bXjBDh8r+Fe7tb9tBC2hDO/hcUseye+DLY2o5BBnuOUP2IkNtZjxuf0hPanU2TFWTYuBQUbhog0sh3q0qePycPi2ps93lQGLUHaqmvtZFUoN8FVNeTsHxeEGg2L2Z6GVL0QInVGjVCdgl6T4qxdEYc955uFsz4kf6gdQWDaUtlkp/LI6G8qsLkEcC0FabliusATrHtm8NGj3HePCC4SLtQ+HTqOwbtWH8Qqgw1lIZB4EjG8oxzklXFGYUP3zGNuC1U11RyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786371300; c=relaxed/relaxed;
	bh=Cqbq7ocjp5qLqhn6ub1Jz2ULUPz57xxAkQlmliZcS0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQInl2T5kymIA8DlasAMBHoMp504TLkc6r47kyg9CXBStcwzq+NptF+/jIsWDd3ou0zj6i3rxSFcAaCsEuNK3ow5fZGikPwW/RrOkYdj3/3kTyfAaujPoVixlxty9YcPRjZkzI90FcKNI2xXm5pgUbd4CFMbE8aa9sABBDJpLVdvNaKJPDNcgvpvUYVdKNGkxbcpzioci1DZ554X9IS5vLsUos3wly1ThRv9yZvYQEGhiiFNF0/HrmExUYglWJ1+y/r0ADVEpiyAwyFSAncY/zh3Qd33dAzWjMHcR6geXqX3TyyDGPf3TYM8B06VCWo+Se/ktAS91lZILeJAsAcYVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FBkTu6+8; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=will@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FBkTu6+8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=will@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJcGC3Dv4z2ysb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 00:14:59 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 39CF360052;
	Mon, 10 Aug 2026 14:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E94C1F000E9;
	Mon, 10 Aug 2026 14:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786371296;
	bh=Cqbq7ocjp5qLqhn6ub1Jz2ULUPz57xxAkQlmliZcS0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FBkTu6+85usDU52Dha/5DQXVxWOENVS7yKDU9Ofdw3/oCPIg8ZLLUDSMcKrnVSP9L
	 f3c2cikYrYuD545fo9Hujadnw/NDojGZoRhVIg9Jw3Posb1ONG7re4pg3rkKq4FDSi
	 +veUdAwky9ShQkN2t7ZmYRCR2su1bedXoyHeAfhfydhcQAYdnKuNH0K4+OncmDgbXR
	 c0VrUqERtZN0kZ8GV6c/ch6F0MNItNaGkFJrLo0roy86L4K6/lG4uLnvSgbdwglunP
	 MNHEtAN3z1+wuwpt11fYQGr3o9Sd77LRs1gJTjf1yjJVk7tzduLbddd70pQP+LLyoY
	 mmQse+6xWKhIg==
Date: Mon, 10 Aug 2026 15:14:47 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
Message-ID: <annc1ynWUsWQc4JM@willie-the-truck>
References: <20260807164734.GE200537@ziepe.ca>
 <anYgXSR4VAi3TpOj@google.com>
 <CGME20260807182023eucas1p1f653436207b2b00338e99ea1d8f847df@eucas1p1.samsung.com>
 <20260807182017.GH200537@ziepe.ca>
 <7d22482f-d5fd-4cf4-9d32-6a54e02f2fbb@samsung.com>
 <yq5av79iiard.fsf@kernel.org>
 <anml6lLRERm1Iv-_@willie-the-truck>
 <28442500-1d53-4776-bae5-459c3ffc1cc6@samsung.com>
 <anm6K2umtx4iKnyZ@willie-the-truck>
 <20260810130818.GN200537@ziepe.ca>
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
In-Reply-To: <20260810130818.GN200537@ziepe.ca>

On Mon, Aug 10, 2026 at 10:08:18AM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 10, 2026 at 12:46:51PM +0100, Will Deacon wrote:
> > On Mon, Aug 10, 2026 at 01:37:11PM +0200, Marek Szyprowski wrote:
> > > On 10.08.2026 12:20, Will Deacon wrote:
> > > > On Mon, Aug 10, 2026 at 02:59:42PM +0530, Aneesh Kumar K.V wrote:
> > > >> Marek Szyprowski <m.szyprowski@samsung.com> writes:
> > > >>
> > > >>> On 07.08.2026 20:20, Jason Gunthorpe wrote:
> > > >>>> On Fri, Aug 07, 2026 at 06:13:49PM +0000, Mostafa Saleh wrote:
> > > >>>>> But the whole thing is best effort anyway, the kernel picks
> > > >>>>> IO_TLB_DEFAULT_SIZE which does not depend on the system topology or
> > > >>>>> how many devices or how much DMA they do.
> > > >>>>> SWIOTLB memory is wasted if unused so we should be careful around
> > > >>>>> that as it would be the other way around and users would have to
> > > >>>>> decrease it manually.
> > > >>>> Yeah, it is why the arch code shouldn't really be sizing it directly,
> > > >>>> it should be done in common code and, yes, we are probably going to
> > > >>>> have to do something alot smarter to have the common code better
> > > >>>> auto-tune this for the CC case..
> > > >>> What about the $subject patch? I assume that it is still needed to
> > > >>>
> > > >>> restore the behavior that was altered by the "[PATCH v8 00/23]
> > > >>>
> > > >>> dma-mapping: Track shared DMA state through direct, pool and swiotlb
> > > >>>
> > > >>> paths?" patchset?
> > > >>>
> > > >> I would request that we pick this patch to fix the regression described
> > > >> in https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org/.
> > > > I really don't think we need it. CCA hardware isn't exactly widespread
> > > > and the KVM host side patches don't appear close to being merged.
> > > 
> > > Does this mean that the branch for-next/coco [1] won't go to v7.3-rc1?
> 
> Let's not make progress on guest support contingent on KVM CCA host
> side patches please. I expect the CSPs will have VM instance types
> available based on CCA within quarters, and Linux as a Guest should
> work in those environments regardless of what KVM is doing. I don't
> really expect full KVM support for years, frankly, the patchset is
> massive. Even Intel and AMD don't have full KVM support yet.

To be clear: the only part I'm pushing back on is the realm-specific hack
to size the SWIOTLB area in arch/arm64/. Even with that hack applied, I
don't believe a one-size-fits-all value is going to work for everybody,
so it was really great to see that special-case removed in:

https://lore.kernel.org/all/20260717180442.110954-18-aneesh.kumar@kernel.org/

but now, because it regresses some test configuration, the proposal was
to penalise protected VMs too (bearing in mind that the patch above
hasn't yet landed upstream):

https://lore.kernel.org/all/20260807092612.2202005-1-aneesh.kumar@kernel.org/

with the alternative being to reintroduce the original hack that we
just removed!

https://lore.kernel.org/all/yq5acxvu2ict.fsf@kernel.org/

I'm saying: merge the patches as they are, without reintroducing this
horrible bodge in the architecture code to drive a heuristic that most
people seem to agree should be handled more robustly elsewhere.

> People already have CCA capable HW, are already testing this stuff and
> the closer upstream can get to being workable as a guest without a
> mountain of OOT patches the better.

This specific part is about a single line of code, to control something
which is already configurable in Kconfig and on the cmdline. It's not
a mountain of out-of-tree patches.

> I agree the thing is not ideal, but it was merged to ARM like this a
> long time ago, this patch is just fixing a small oopsie (was it a
> merge conflict?) to put it back. I don't the objection.

My main objection is that I have very little confidence in people trying
to fix this properly if we take the realm-specific bodge in the arch
code. With all the CCA patches floating about already, why would they?

Will

