Return-Path: <linuxppc-dev+bounces-25671-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3204C5AD55
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 13:08:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJZnP6ZQvz2ytv;
	Mon, 10 Aug 2026 23:08:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::831"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786367305;
	cv=none; b=FtB3f0G0/sJ8J1UokPsiLP25rlxe2NliUH8jAAG+AJQglm5JhYaRAemsbwbdvCXGc9Xhqv2r6R65+yN327dNv3oaCOMGwmC0U5MJ931NH0WQZIYfDFuR5+CddyCtF8WB+QhY+6X11febiLb/gKq/rsu7+UBprtlGOw6xe7ShVinMsjFB8G/tzpZ52UBy3PXl3WSC/h510QlUien664QJYcpY9Q8XVE22a16CrHh3N6RSbeldtlxtjorl5JoCQc3dCOJLTQCGDAlap5YyiIcxWOiap6ImxuX6+0356YS8O07cnD840irLXNuy4RleZtNHucUuVzuZdXL5MaABEIIKag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786367305; c=relaxed/relaxed;
	bh=pTDI6EKrZhHzu91ABEa/3hYoH7aGPcaJaVd/MJRw0Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALAIxB+SrysypXYDmthXXBIKTk4tdpC9CHedyCEOXCMflVI9QuXXKgdaba1QOX6Bp9IqhdKt/TAYJbiIxAVH5DLI9h6K61xtp28SkbI0KsNTyUqeICF5xJaMRtbkPgF1JkwEGfoXllU3VLgmjj8hyb/YSKLni1Sjh0Jeu63sF/FUhciDCQ+ATPaZsuIwp+kTYnqmqqockCtjlkKJtfTxPc6EKoy21m+wSMy8UZFGAB4OD6B4kjBgmRXe7wa0obN1jxnslGPJpUtZiwpUY6f01GIQZLwtizkBhXLEu8AfQf+4qZiscBm+DCLe8tiZ8oNblR8El+dsPgNzctT1sVzg6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ddK68yzs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ddK68yzs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJZnN2hLTz2ysb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 23:08:23 +1000 (AEST)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-51c1372f84dso11757551cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 06:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786367299; x=1786972099; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pTDI6EKrZhHzu91ABEa/3hYoH7aGPcaJaVd/MJRw0Ok=;
        b=ddK68yzs/YAIisbUBT0vJZSfCBovbJIXjjnEAI35rIdJ7HeMnGmHGEejv/5aJqBZn4
         HQiCgOFOQQ+jZfYwRWgYg3XJjo3w01mr1WkTC6i2GqR5cCFZF83wGAO3KD0TPHdvu9P4
         JRrJD6e4XwAuwcHPtSAJjY87uxCFhinvBON5K8O5CEtak4przhffDXiJwhgM30jEu8U2
         qDQpaThzHciIod5sp//3gT2RjZbUKQSr5hT9H/u2LWJFpfKP70WBr9mvQOUD1P6xZgwf
         +9IRmAwGm3s2z97EwWTuWKo2cTJxkWI0pxYWjPJ3Dr4sAtfUrCX1Ou4fqNF5bwb/PgMN
         xHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786367299; x=1786972099;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pTDI6EKrZhHzu91ABEa/3hYoH7aGPcaJaVd/MJRw0Ok=;
        b=nBse9gQ57ynLJaEaHv5QmDZP5xhR9/MihULLRTjt9RVisAf5wKMkhZopShXpJ6NA4n
         sLjDzMmwA4odt1NqRvtnDKxSUADPx/MRi3UQzN8MRacceY95pQy8+7w8jYsdkP1+1BvQ
         0Ii2pWImbySnY3LL7guEtPD+Pr5qBCVylJJSn+an3r2apP9c/YzSu+IzH4me+AXznlSN
         Xoi38KA3hIwyDg93Jdy5We73rGGVtgjmZ1uluYJKvdtGarglnHOXxDRTb1QpTI3jD00r
         E1FqACrPjsuZCETrllu+Rj1WXETBXdVAusNmAqyxpC4cGCfA1bVTqA5wuz/7HlgYAnuf
         inwA==
X-Forwarded-Encrypted: i=1; AHgh+RprnaWS+MXMiS2ijaFWJDxkx7DX/6zkOmA3GFp7CQRJbmYy+zqR8QYaEFMOp8sm/P/GlxC3n7hl3sudX6g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywm0CF+BsiHyPp7ZuFfF8ke7+JunBJ9DLSxeKyu4ZdLM2Y3mC9/
	+1rAV/S3sxbcnr0jH9Gd7rpWdODk8frdffjH93LPGw5m58aDVP8NQWpSr+Kl4LRpt2s=
X-Gm-Gg: AR+sD1298zZrMclrt1pkmIKrcLjQE+fYG5Pr0OLr6Ofq3tK8Kzgulua6TtMdL0jb2bD
	W8X8zwp2VAHeNCMjboLdVk2ntxfIFr/7RNHZoy2Xek5aeHuWpJb35v6Fl9j4fgXcn4KtI2j6kNM
	xJSMBJWvtA4n7yvkgQlIMlkQpyCVO1a81qGv+rLKKEA6Ttow3BnBukq8lGezVjs3UaJ1Xu5JulE
	JqCZJly+B6iwAtdniHDoRHJSLoQdV3W95IqTEKQNfCySUkukkSs7ETp2uoxJ4Q29O//bD2M8C3D
	Zr9DXLK8Ub4mfvHthv5OpIct3gyjRkrALD+AhZDJOn4U/crFT0nOs/8w4fbE3iagHlXtM7VWKV7
	txabnXvDqafRsLwuqAZX4eXQqkuD3jYceiqiatEln/QVP8ZL5chxqBRN8uFqHh0fcmCJxIsAweP
	13WT1wIKC7IKR6v74SdpdTJX6l/nn3Fmlq7K71LA==
X-Received: by 2002:ac8:574f:0:b0:51b:fcb4:7576 with SMTP id d75a77b69052e-52d20961711mr224570371cf.15.1786367299519;
        Mon, 10 Aug 2026 06:08:19 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d163c1aefsm70838551cf.12.2026.08.10.06.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:08:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtPjm-000000022LS-0EaO;
	Mon, 10 Aug 2026 10:08:18 -0300
Date: Mon, 10 Aug 2026 10:08:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
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
Message-ID: <20260810130818.GN200537@ziepe.ca>
References: <anX7F7dnKOtAOIIe@google.com>
 <20260807164734.GE200537@ziepe.ca>
 <anYgXSR4VAi3TpOj@google.com>
 <CGME20260807182023eucas1p1f653436207b2b00338e99ea1d8f847df@eucas1p1.samsung.com>
 <20260807182017.GH200537@ziepe.ca>
 <7d22482f-d5fd-4cf4-9d32-6a54e02f2fbb@samsung.com>
 <yq5av79iiard.fsf@kernel.org>
 <anml6lLRERm1Iv-_@willie-the-truck>
 <28442500-1d53-4776-bae5-459c3ffc1cc6@samsung.com>
 <anm6K2umtx4iKnyZ@willie-the-truck>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anm6K2umtx4iKnyZ@willie-the-truck>

On Mon, Aug 10, 2026 at 12:46:51PM +0100, Will Deacon wrote:
> On Mon, Aug 10, 2026 at 01:37:11PM +0200, Marek Szyprowski wrote:
> > On 10.08.2026 12:20, Will Deacon wrote:
> > > On Mon, Aug 10, 2026 at 02:59:42PM +0530, Aneesh Kumar K.V wrote:
> > >> Marek Szyprowski <m.szyprowski@samsung.com> writes:
> > >>
> > >>> On 07.08.2026 20:20, Jason Gunthorpe wrote:
> > >>>> On Fri, Aug 07, 2026 at 06:13:49PM +0000, Mostafa Saleh wrote:
> > >>>>> But the whole thing is best effort anyway, the kernel picks
> > >>>>> IO_TLB_DEFAULT_SIZE which does not depend on the system topology or
> > >>>>> how many devices or how much DMA they do.
> > >>>>> SWIOTLB memory is wasted if unused so we should be careful around
> > >>>>> that as it would be the other way around and users would have to
> > >>>>> decrease it manually.
> > >>>> Yeah, it is why the arch code shouldn't really be sizing it directly,
> > >>>> it should be done in common code and, yes, we are probably going to
> > >>>> have to do something alot smarter to have the common code better
> > >>>> auto-tune this for the CC case..
> > >>> What about the $subject patch? I assume that it is still needed to
> > >>>
> > >>> restore the behavior that was altered by the "[PATCH v8 00/23]
> > >>>
> > >>> dma-mapping: Track shared DMA state through direct, pool and swiotlb
> > >>>
> > >>> paths?" patchset?
> > >>>
> > >> I would request that we pick this patch to fix the regression described
> > >> in https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org/.
> > > I really don't think we need it. CCA hardware isn't exactly widespread
> > > and the KVM host side patches don't appear close to being merged.
> > 
> > Does this mean that the branch for-next/coco [1] won't go to v7.3-rc1?

Let's not make progress on guest support contingent on KVM CCA host
side patches please. I expect the CSPs will have VM instance types
available based on CCA within quarters, and Linux as a Guest should
work in those environments regardless of what KVM is doing. I don't
really expect full KVM support for years, frankly, the patchset is
massive. Even Intel and AMD don't have full KVM support yet.

People already have CCA capable HW, are already testing this stuff and
the closer upstream can get to being workable as a guest without a
mountain of OOT patches the better.

I agree the thing is not ideal, but it was merged to ARM like this a
long time ago, this patch is just fixing a small oopsie (was it a
merge conflict?) to put it back. I don't the objection.

Jason

