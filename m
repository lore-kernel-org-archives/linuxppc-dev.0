Return-Path: <linuxppc-dev+bounces-24201-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1791C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 10:00:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzvv15mZdz2y71;
	Tue, 14 Jul 2026 20:00:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784023229;
	cv=none; b=GnGrcUVadmeMl0nZomcJgysw+uPM8ml6Ec2NVTmpr+5jCq9Zdw37MTiiLUiQ2gLdEiiWGAQpB/xb0QEOskBfGQr945GYjcWO5x7b44ECTreV7iy7/UGaF2slLAQLuHjY53CgzsNuhsdIcLlOemy1KZGb1vN17VukTPSyHe4h6zxv/SX0YwGpLzrc0tn9zBUTb61ykdSX291Bo1h3jNB6eKj+tBkYgmn7WhoJeNyjGKg5i4o9yW35p+Birqq4lheZgom1pKvDyqITRIEl658Y5Jm38UiIsPzxfkNVYx4AaGccQmPCDjnNugbmVlZuQNn1uEYioQ2X/shgvt+wROcE/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784023229; c=relaxed/relaxed;
	bh=IUra5EJSRaUGl/khGQ/hVpRAn7fp80t3QbcNAonpnHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=KIUf/qVPniV0NUUKFSEktILddOL4d7yosWyivmP/EUlPRpCYMsZDGl9kjQdTqE+sALNLTS4TWvvfXEEwpoIUUjr0HTy56WnqLW8aXFOVddpkBA0pemNvbpqjD1g0+u+DYaOHdcU6t/cvNsb/Y29MPTJksl/TMiMYqD6dQuO2lwe/gi4QtSn7YuB8O6kDzSwg3eSdm6knrvb7IhK/u+4sXGy7drPMaKM/11mEgcj8Bt4U/bTxkXXZ/udF7vT5IlakDKPCQFy2qDARPu/faDVbIPUv9M1dRaarSsBha7kmjWZpi+yVG+JQsWGSjdmWvnJVvh/d7qIRGp/TcZ+s1fcflg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=NMjfCsqZ; dkim-atps=neutral; spf=pass (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=NMjfCsqZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzvty5gjFz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 20:00:26 +1000 (AEST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260714100016euoutp010b64ed20ec9ba1c6447f10b7abae08b8~CH6nFLiNZ1160011600euoutp01a;
	Tue, 14 Jul 2026 10:00:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260714100016euoutp010b64ed20ec9ba1c6447f10b7abae08b8~CH6nFLiNZ1160011600euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1784023216;
	bh=IUra5EJSRaUGl/khGQ/hVpRAn7fp80t3QbcNAonpnHo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=NMjfCsqZ5hnUEU0WETu01Q9nOdFTV987l1OyEpSxVC3qsrjuo+pdKGHJOn1P/uqy9
	 0ML3iTMDQp8jsFJA5eqo2WdyOclP9r+hDHP0Qb9E1dtE0XTKwa/FLLs+p4+9q/ScPz
	 8vhb3Wq8om+OapgJr8LiPPxclNzpInm/pkQwvQpQ=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260714100016eucas1p2bbfe02d5fc02fcf561dc5409c7ecb5ab~CH6mtujgB0401004010eucas1p2d;
	Tue, 14 Jul 2026 10:00:16 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260714100014eusmtip1f8ce1c67533271011f679d0bcf054f91~CH6lJz-Yt2122621226eusmtip1M;
	Tue, 14 Jul 2026 10:00:14 +0000 (GMT)
Message-ID: <6f35eaae-f3d2-48fb-abce-9a2cc124b0ef@samsung.com>
Date: Tue, 14 Jul 2026 12:00:13 +0200
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
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v7 00/22] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Jason Gunthorpe
	<jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy
	<robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier
	<maz@kernel.org>, Steven Price <steven.price@arm.com>, Suzuki K Poulose
	<Suzuki.Poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Jiri
	Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>, Petr Tesarik
	<ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Madhavan
	Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Gerald
	Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian
	Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, x86@kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <yq5aldbdnbj8.fsf@kernel.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260714100016eucas1p2bbfe02d5fc02fcf561dc5409c7ecb5ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260707080628eucas1p13fa8a57e60ef5dd3ec651e19e42af0a1
X-EPHeader: CA
X-CMS-RootMailID: 20260707080628eucas1p13fa8a57e60ef5dd3ec651e19e42af0a1
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
	<CGME20260707080628eucas1p13fa8a57e60ef5dd3ec651e19e42af0a1@eucas1p1.samsung.com>
	<yq5av7argr65.fsf@kernel.org>
	<fc804746-4fb8-4ea9-997f-a4cae9ba8c14@samsung.com>
	<20260713194323.GC3133966@ziepe.ca>
	<cd5d0504-1592-4b48-89ea-1efe8aa57968@samsung.com>
	<yq5aldbdnbj8.fsf@kernel.org>

On 14.07.2026 11:52, Aneesh Kumar K.V wrote:
> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>> On 13.07.2026 21:43, Jason Gunthorpe wrote:
>>> On Tue, Jul 07, 2026 at 03:03:48PM +0200, Marek Szyprowski wrote:
>>>> I'm fine with merging on top of the topic branch and I assume that this
>>>> patchset is mature enough to give it a try in linux-next, but first I
>>>> would like to get a review or at least acks from others with good CC
>>>> knowledge or experience.
>>> I think it is good to go from a CC perspective, there are still some
>>> more items to fix up (like the MMIO) but I'd rather they be followups
>>> at this point.
>> Great. Aneesh, any chance You could send v8 with the remaining items
>> fixed till end of this week? I will be happy to push it to
>> dma-mapping-for-next for testing in linux-next asap.
>>
> Sure. You need this rebased on top of the pKVM changes, right?
> Otherwise, we'll end up with conflicts when you do the final pull
> request.
Ah, indeed. I forgot about the pKVM changes. If there is a stable
branch with those patches, please base v8 on top of it.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


