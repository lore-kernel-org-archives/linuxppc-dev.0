Return-Path: <linuxppc-dev+bounces-25669-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1E2C5AC82
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 11:47:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJXzW52Mqz2yr6;
	Mon, 10 Aug 2026 21:47:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786362423;
	cv=none; b=DWoQ7PaPWncZ2rJjcxHX0q/iHtosaZMOS+JASmzf30wGHEA8a/wxZvPGFBmGQpvGBEmWjmpBtwYlq5+Yj8t4T8LLi4+6IinP2PlMSJPTLKsbwXxxPw+L8RSJmTtHNK1vQexujKnGCe6I5xeTekyIr5g7coLLfxogGcSBr9azCfQEGf9e4fkzR5/QdTcgkcPG0VKEKChAPiC5MBbstxrHESa6NA0gm+m1opbxJwMfQWtoLmo/ut14MuJdM10KvQMyWTq+Io1RTQqLvjhBN35QZmQil3CNkohxGbB6GmZHYMPCYsUJNgj/pDDPqa/WGRmRtZQFU01ywiwLtBDGfI6DBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786362423; c=relaxed/relaxed;
	bh=fCRqoeWNWtgyOE15SAxF1YS8N0xnzH3d7d2rFiQqAvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDAWGqDIhYZQmrx4aHBx6csx9E8uoa94e3vN9AdP3ISLLWZX4kOTOX2Rm+IfeYEMkGutej8DxyOoEiOnyMYREza+/f9GcDCNIa1JbPAX7e/4BYcO1Rs0+Mfpf9V6LPM7XMBnRCgtugCyapS/YWb8ULKmEIgiKiBwydQPWqczvBxQsw69Lg1w0dy0ixzxpb/0Js24/91HxgEQ6b/5PA4N7pT2oPDoL+JFejYppU9CdcVe/isc/x+7O4V7i4b2uagjNpD2nrMbFzZyfiJeLEy2LAFSQW16HbU8QqabxC5F+kit4BqGsgez2WadHKhaKYg2knbUTEQDOzm+BHkn3+bidQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZdqOARlq; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=will@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZdqOARlq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=will@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJXzV3Zlnz2yPq
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 21:47:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CB24243E05;
	Mon, 10 Aug 2026 11:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2455F1F000E9;
	Mon, 10 Aug 2026 11:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786362419;
	bh=fCRqoeWNWtgyOE15SAxF1YS8N0xnzH3d7d2rFiQqAvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZdqOARlqNVXG2WPdY64KIFiiHy7+iL34WY5SFGKkpbDKTPzoxcrf8GlztQOTzotYK
	 Kg5HPHwLV+5NhAnFpPy2M0d3tpks7urO5LVdtaYhr6+MuPr6zb4pRlRwSp3hiSM9Aj
	 vCAxgQFWgzY6cDHelMHj4C/jXVkJj7f+QtrE7Yt3Gg22QfoyAeZM99oD0he866L/DY
	 F2KZG03kM1xVZJQxLaqFMXnxi4i4KMM/sYLsNWaGEVRErraJAxad6KiDUUDo+NPuEt
	 O2mzWp+GVkyfqSfgZBJpiQWioD1g/jvLk6/XCtjYgdXIs9llPpIPtA7fDAT8VOn/Ix
	 ydjL4LdODFn+Q==
Date: Mon, 10 Aug 2026 12:46:51 +0100
From: Will Deacon <will@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
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
Message-ID: <anm6K2umtx4iKnyZ@willie-the-truck>
References: <20260807135810.GA200537@ziepe.ca>
 <anX7F7dnKOtAOIIe@google.com>
 <20260807164734.GE200537@ziepe.ca>
 <anYgXSR4VAi3TpOj@google.com>
 <CGME20260807182023eucas1p1f653436207b2b00338e99ea1d8f847df@eucas1p1.samsung.com>
 <20260807182017.GH200537@ziepe.ca>
 <7d22482f-d5fd-4cf4-9d32-6a54e02f2fbb@samsung.com>
 <yq5av79iiard.fsf@kernel.org>
 <anml6lLRERm1Iv-_@willie-the-truck>
 <28442500-1d53-4776-bae5-459c3ffc1cc6@samsung.com>
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
In-Reply-To: <28442500-1d53-4776-bae5-459c3ffc1cc6@samsung.com>

On Mon, Aug 10, 2026 at 01:37:11PM +0200, Marek Szyprowski wrote:
> On 10.08.2026 12:20, Will Deacon wrote:
> > On Mon, Aug 10, 2026 at 02:59:42PM +0530, Aneesh Kumar K.V wrote:
> >> Marek Szyprowski <m.szyprowski@samsung.com> writes:
> >>
> >>> On 07.08.2026 20:20, Jason Gunthorpe wrote:
> >>>> On Fri, Aug 07, 2026 at 06:13:49PM +0000, Mostafa Saleh wrote:
> >>>>> But the whole thing is best effort anyway, the kernel picks
> >>>>> IO_TLB_DEFAULT_SIZE which does not depend on the system topology or
> >>>>> how many devices or how much DMA they do.
> >>>>> SWIOTLB memory is wasted if unused so we should be careful around
> >>>>> that as it would be the other way around and users would have to
> >>>>> decrease it manually.
> >>>> Yeah, it is why the arch code shouldn't really be sizing it directly,
> >>>> it should be done in common code and, yes, we are probably going to
> >>>> have to do something alot smarter to have the common code better
> >>>> auto-tune this for the CC case..
> >>> What about the $subject patch? I assume that it is still needed to
> >>>
> >>> restore the behavior that was altered by the "[PATCH v8 00/23]
> >>>
> >>> dma-mapping: Track shared DMA state through direct, pool and swiotlb
> >>>
> >>> paths?" patchset?
> >>>
> >> I would request that we pick this patch to fix the regression described
> >> in https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org/.
> > I really don't think we need it. CCA hardware isn't exactly widespread
> > and the KVM host side patches don't appear close to being merged.
> 
> Does this mean that the branch for-next/coco [1] won't go to v7.3-rc1?

Argh, no, I'm definitely planning to send that!

I'm just saying that this specific fixup patch (which is a PATCH sent
in reply to another patch in the middle of a series...):

https://lore.kernel.org/all/20260807092612.2202005-1-aneesh.kumar@kernel.org/

isn't something we should take for the upcoming merge window. There are
better, alternative ways to tackle the issue (as discussed in the thread)
and it's really not as urgent as Aneesh is trying to make it sound.

Will

