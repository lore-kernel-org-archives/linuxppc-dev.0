Return-Path: <linuxppc-dev+bounces-25680-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817E6C5AE49
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 14:33:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJcgV6z3Fz2ytv;
	Tue, 11 Aug 2026 00:33:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786372406;
	cv=none; b=iDeDAhJUWVinqX7ZnYQ2WBZnpf1xE9VPyw/uqg0XTHsEONBoDeO2lap3dGJDpHZhCpZ3YBXqxs4vWWpRErop+QzeXNYLgLQX3k7qLA5uG9Ftkjt0eK4VN7qhf+fztYBnzjrAX34vRII4XqBlY7Cr8NBZ0dp75oZ27gngzlo9Nd5tdKIPlmYlccRV5yAcj+5uaBSnvEJD4KjqxK80mJuogyZd68YaYSdYgHHlAw8CpImmIsJfjiKlhxKvmnKmV2TNMLuJf936cdxAJu4JmIq+Rde3BgG4SCj1O4VJcjGqfBcP7lcx8LKo9ZQW1U+30sJjPdpaJ3dXrnlhG+IoKfCRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786372406; c=relaxed/relaxed;
	bh=7nq4F6eVa+igOyPizq1W0mha35WNgJ79/K+NijHuU08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eh1bD/sR216k6cnB4pjPQuxHUxQ3KOYslbMCBMo4IK38eLvZbFaFlHozgKy4wsEMXpb4iNfZind22gAIgiNIOkOEBJ0tBLsCXjvWFwVp7L4GoXu3c5QAgVZ5D0DJ+XOPVreIcbuKLqi76EUYkcOlUdygzdw+m0+xHRnhDUSX8bW3Yqp/tnRNJ41hC7EautTCXKyl5ypW6NUYrTlOI4xDFoZNgMPmqvHNHBIfKx/KjpT1hqhMDSkkQda/MP73zztpSOiDmul/DosJp6jaKu4e39Kp8YVfxqbUmjYhDnjPxAebjNDo2CyEcX+xrd79eE+NebrbQ8p7w18SUCGF2r4NUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSEg5P7W; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSEg5P7W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJcgT6FkWz2ysb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 00:33:25 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6AA7943D10;
	Mon, 10 Aug 2026 14:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694EF1F000E9;
	Mon, 10 Aug 2026 14:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786372403;
	bh=7nq4F6eVa+igOyPizq1W0mha35WNgJ79/K+NijHuU08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FSEg5P7W76NmVIq/uL3ZJ2JQ93MR3s+H6sZ8oMjTjqoQtXHtpU2o8sZMVTuz5+8hg
	 s/icfW+TbRoP+BIL+Loawx2mDkc39Fga6I40bNBiXUw3nB8b264pGFeY2r4EsV+SQ/
	 Q48Vqv2S8+JWnnwUTV2LAOB1KEzUy1OtCTc2kDiWMYMhfgicWh6aJLxgocxnjXteXp
	 Uh7ToRG+nxYY1VwUX4I2D+iq7cDjxmG7Qmo1ULPbcjMYqklUgFlWSNeJqJLZLC9zWi
	 jGnT9IpWporSvmykehgrhxxupjX8d/mSoeZuCdmoSHpGyNGZ6YcvG7+JV12NxM75p3
	 1qv9ezVXXbK8w==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Will Deacon <will@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
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
In-Reply-To: <20260810130818.GN200537@ziepe.ca>
References: <anX7F7dnKOtAOIIe@google.com> <20260807164734.GE200537@ziepe.ca>
 <anYgXSR4VAi3TpOj@google.com>
 <CGME20260807182023eucas1p1f653436207b2b00338e99ea1d8f847df@eucas1p1.samsung.com>
 <20260807182017.GH200537@ziepe.ca>
 <7d22482f-d5fd-4cf4-9d32-6a54e02f2fbb@samsung.com>
 <yq5av79iiard.fsf@kernel.org> <anml6lLRERm1Iv-_@willie-the-truck>
 <28442500-1d53-4776-bae5-459c3ffc1cc6@samsung.com>
 <anm6K2umtx4iKnyZ@willie-the-truck> <20260810130818.GN200537@ziepe.ca>
Date: Mon, 10 Aug 2026 20:03:09 +0530
Message-ID: <yq5amruuhwpm.fsf@kernel.org>
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
Content-Transfer-Encoding: quoted-printable

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Mon, Aug 10, 2026 at 12:46:51PM +0100, Will Deacon wrote:
>> On Mon, Aug 10, 2026 at 01:37:11PM +0200, Marek Szyprowski wrote:
>> > On 10.08.2026 12:20, Will Deacon wrote:
>> > > On Mon, Aug 10, 2026 at 02:59:42PM +0530, Aneesh Kumar K.V wrote:
>> > >> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>> > >>
>> > >>> On 07.08.2026 20:20, Jason Gunthorpe wrote:
>> > >>>> On Fri, Aug 07, 2026 at 06:13:49PM +0000, Mostafa Saleh wrote:
>> > >>>>> But the whole thing is best effort anyway, the kernel picks
>> > >>>>> IO_TLB_DEFAULT_SIZE which does not depend on the system topology=
 or
>> > >>>>> how many devices or how much DMA they do.
>> > >>>>> SWIOTLB memory is wasted if unused so we should be careful around
>> > >>>>> that as it would be the other way around and users would have to
>> > >>>>> decrease it manually.
>> > >>>> Yeah, it is why the arch code shouldn't really be sizing it direc=
tly,
>> > >>>> it should be done in common code and, yes, we are probably going =
to
>> > >>>> have to do something alot smarter to have the common code better
>> > >>>> auto-tune this for the CC case..
>> > >>> What about the $subject patch? I assume that it is still needed to
>> > >>>
>> > >>> restore the behavior that was altered by the "[PATCH v8 00/23]
>> > >>>
>> > >>> dma-mapping: Track shared DMA state through direct, pool and swiot=
lb
>> > >>>
>> > >>> paths?" patchset?
>> > >>>
>> > >> I would request that we pick this patch to fix the regression descr=
ibed
>> > >> in https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org/.
>> > > I really don't think we need it. CCA hardware isn't exactly widespre=
ad
>> > > and the KVM host side patches don't appear close to being merged.
>> >=20
>> > Does this mean that the branch for-next/coco [1]=C2=A0won't go to v7.3=
-rc1?
>
> Let's not make progress on guest support contingent on KVM CCA host
> side patches please. I expect the CSPs will have VM instance types
> available based on CCA within quarters, and Linux as a Guest should
> work in those environments regardless of what KVM is doing. I don't
> really expect full KVM support for years, frankly, the patchset is
> massive. Even Intel and AMD don't have full KVM support yet.
>
> People already have CCA capable HW, are already testing this stuff and
> the closer upstream can get to being workable as a guest without a
> mountain of OOT patches the better.
>
> I agree the thing is not ideal, but it was merged to ARM like this a
> long time ago, this patch is just fixing a small oopsie (was it a
> merge conflict?) to put it back. I don't the objection.
>

It was not a merge conflict issue. The change was introduced by an
incorrect rebase I did when updating the patch series on top of the pKVM
changes.


-aneesh

