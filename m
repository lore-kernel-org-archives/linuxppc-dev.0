Return-Path: <linuxppc-dev+bounces-25661-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81472C5AD4E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 09:30:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJTxL5X1jz3048;
	Mon, 10 Aug 2026 19:29:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786354198;
	cv=none; b=Z/Lt+skkRU2kjIbz8GRmZXdJIzNd43td9mJJOhJMBKiSkXJckPYPnH1laTAc82XAum+Hfh2CKwlxjHLHlJOtx3zOL2KWYkyLkH6sbJTUdGuXb3xM8jbO0nQtBD/7cn/ZgHdJmvS40ekT0b1b3dFF2u9AWlpm1CeXVa1oL7uKLeuCqUp2S6b0zEwqew61+bLS0V+S4aMMssh1/FHLJycYRSC+K4vmukSrJkKckVpaCEFkbR6cyQqBAQe4UMr/jw14tfSXcXe9hH5BZoWQ18/j3nK9x3Bz4EDd6UWysubAeOL33UlTPVHvx05b0Anpt5Nv9bwyBPws9DTneAUFkdH+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786354198; c=relaxed/relaxed;
	bh=ePzJdMR5XS4l0T+U+JwL7EAJw0TvLA27eLAbg0PvUSg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qs2m6IMNuw3FmdFCxxAOoQbbvZyK94HmgGiCHuppA3BAybaQ0oPyy96hikiHMhNPoGS7N5ELGNc0Nf1MO87j8ZUshpB6tGkLHMtv8WRd1LZ8P04OtuCYYS5Zoc+/9vMfqGsWVBbPfoJxajwYVkRXQ2Tx5jUf5Dpx3w0JcLJa38rOrMlpNH1FN84saALhYfxRmxgRBiXTP7Wf+QYyvOTimSlWzyG2XBa5E4gugK8ItCtzsfdL00oZHIg48W+bryIrMyJ+PbdumN00ejL6Y7jUvol9F/dTbkeSFXWP5/6O00uddZ//rWgSdZq3LPTJMU6LWD9o3XRKQh/e/iVQhF5vQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOZ5btVK; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOZ5btVK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJTxK4lbcz300V
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 19:29:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AEF1160052;
	Mon, 10 Aug 2026 09:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A721F00A3F;
	Mon, 10 Aug 2026 09:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786354194;
	bh=ePzJdMR5XS4l0T+U+JwL7EAJw0TvLA27eLAbg0PvUSg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=EOZ5btVK5wc2PRm7y+pa82bf3EF9Q2evs44jC9f7gpN6kM6uHUCiuwM/CQt4buzLp
	 DvHbec2P6GdoqL8LuZU/Gp2huwKC6TNH1usgp+1qSI0OPhXP+jlNLEvRYgs4rrvLZj
	 l6SC7NOcbBVPs0B/jDmCJ5lndL9VLQZant1O86GzzUwTAgB31/rfQ4jUTM6GwATKT2
	 v3632dOTCea49nhxBk+pLY5vDnGLk1o+g/UNwr4OcDX9GQH6d3QaJY1fkwdush9HYo
	 vxAF5lClYDTXMP/FeWosYTJwRJDLhO850dR/2D38G+l2Vjw3KjfDR12j3puAsWRWj5
	 EzAp8I7p17uYA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
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
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected guests
In-Reply-To: <7d22482f-d5fd-4cf4-9d32-6a54e02f2fbb@samsung.com>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck> <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck> <20260807135810.GA200537@ziepe.ca>
 <anX7F7dnKOtAOIIe@google.com> <20260807164734.GE200537@ziepe.ca>
 <anYgXSR4VAi3TpOj@google.com>
 <CGME20260807182023eucas1p1f653436207b2b00338e99ea1d8f847df@eucas1p1.samsung.com>
 <20260807182017.GH200537@ziepe.ca>
 <7d22482f-d5fd-4cf4-9d32-6a54e02f2fbb@samsung.com>
Date: Mon, 10 Aug 2026 14:59:42 +0530
Message-ID: <yq5av79iiard.fsf@kernel.org>
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
Content-Type: text/plain

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> On 07.08.2026 20:20, Jason Gunthorpe wrote:
>> On Fri, Aug 07, 2026 at 06:13:49PM +0000, Mostafa Saleh wrote:
>>> But the whole thing is best effort anyway, the kernel picks
>>> IO_TLB_DEFAULT_SIZE which does not depend on the system topology or
>>> how many devices or how much DMA they do.
>>> SWIOTLB memory is wasted if unused so we should be careful around
>>> that as it would be the other way around and users would have to
>>> decrease it manually.
>> Yeah, it is why the arch code shouldn't really be sizing it directly,
>> it should be done in common code and, yes, we are probably going to
>> have to do something alot smarter to have the common code better
>> auto-tune this for the CC case..
>
> What about the $subject patch? I assume that it is still needed to
>
> restore the behavior that was altered by the "[PATCH v8 00/23]
>
> dma-mapping: Track shared DMA state through direct, pool and swiotlb
>
> paths?" patchset?
>

I would request that we pick this patch to fix the regression described
in https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org/.

We can then work separately on improving the default swiotlb pool size
in generic code based on other metrics. I consider this patch
independent of that work.

Even with such an improvement, this patch would still be applicable: a
condition that resizes the swiotlb pool based on arm64_dma_phys_limit
should not apply when guest memory encryption is in use, because the
purpose of the swiotlb pool is different in that configuration.

-aneesh

