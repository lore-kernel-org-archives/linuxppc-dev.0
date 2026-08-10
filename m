Return-Path: <linuxppc-dev+bounces-25668-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ACEC5AC82
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 11:37:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJXmT09Nwz2yr6;
	Mon, 10 Aug 2026 21:37:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786361848;
	cv=none; b=JNDobhLyLKpbbvZPEPrSabwhsQVAJv3HSrN61nzdDNAeklogA4x/5cTktMA0ZK79y9TmJxF8y9zvfSh2FSKm4s4TCQQmgs2Ri6f1Oap1FvjlCnbzyuvhSlIcaB4xCiPzpsttcECqocOImLGVwzoBt9vMDTMsGJAxkXItGUUQhGgu4tyk57ZRTPteKBI7E0G1Upg+VoXWDKIMPP0YcOQAzO/oK5rvJJ9buPXx7PgF7kuWrjDLgPWteUarMjY+wUfUn2hYDPvh6I1AoiShAIUxaVVwkuz59wlaQsiaXF+v7ME11CV64mU2L+tU1NBbDAXVIH2HW1Pcys0Ubq7uC95aDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786361848; c=relaxed/relaxed;
	bh=kV5ZYrj5wE4GOEKRMF/gxoB7LU5gFTUJHkhmU9HyjMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=VDQEftHG7V55AwMidZeRNciHWobtVuhxza7RdGazMgjh0P7qEuLMtIXLaFFA9oekA8leKtj0hpPl5aV0NlOY16cjLjATuvFcw9zVO5yHJ04JxbaRxTD/J74m5Du+MnR8KXZiSzJLw4wjz0FOXJ4FcQOJxiJKsDS5VOzEOrJLwS65soPoIkREIUD7cI+cCn1bEvnThqBNquKUxeUVh5+yuvEUG1FPKq2qIl3xf3d3p3l8PvQv5+W6ZojTepm4vq8IOEMQ3tjUgRdKLw+PBzlXe90xCwS9McHMDLf4hUU3YPPC27hlA8CGR4mI9d7zU7x+v8mCEcVF5K4ECxmkxIY6nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=kN3DxXhi; dkim-atps=neutral; spf=pass (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=kN3DxXhi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJXmP6q6cz2ykn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 21:37:24 +1000 (AEST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260810113713euoutp016f3f4b77a2df3bfdc305d031c6984c9a~Kbp97gzYA2148921489euoutp01h;
	Mon, 10 Aug 2026 11:37:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260810113713euoutp016f3f4b77a2df3bfdc305d031c6984c9a~Kbp97gzYA2148921489euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1786361833;
	bh=kV5ZYrj5wE4GOEKRMF/gxoB7LU5gFTUJHkhmU9HyjMA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=kN3DxXhiV6A32AfRhNBQCO8Y9H3rbjoYrVAP4Y+RwnGiaH2R4moCILniw2BNmc07i
	 qVDB2xKU0IDVgY36eMntlSkuzEBYinOGgCSE0qA/VEzpbfJWamjWYMHLWeJVGM2Q6c
	 TT41noYxnIJu2mycFyI4SXwKJL3jDjmL5dWuupLA=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260810113713eucas1p1b0aa58555e68eca16ad8962462d5afdd~Kbp9wCQhp2359123591eucas1p1b;
	Mon, 10 Aug 2026 11:37:13 +0000 (GMT)
Received: from [106.120.50.46] (unknown [106.120.50.46]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260810113711eusmtip2ac80bb2608e56255c84c347422994fd6~Kbp8OmsY60892908929eusmtip2X;
	Mon, 10 Aug 2026 11:37:11 +0000 (GMT)
Message-ID: <28442500-1d53-4776-bae5-459c3ffc1cc6@samsung.com>
Date: Mon, 10 Aug 2026 13:37:11 +0200
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
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
To: Will Deacon <will@kernel.org>, "Aneesh Kumar K.V"
	<aneesh.kumar@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy
	<robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>, Steven Price
	<steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
	Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Petr
	Tesarik <ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>, Dan
	Williams <dan.j.williams@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Madhavan
	Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
	<gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
	Gorbik <gor@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
	x86@kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <anml6lLRERm1Iv-_@willie-the-truck>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260810113713eucas1p1b0aa58555e68eca16ad8962462d5afdd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260807182023eucas1p1f653436207b2b00338e99ea1d8f847df
X-EPHeader: CA
X-CMS-RootMailID: 20260807182023eucas1p1f653436207b2b00338e99ea1d8f847df
References: <yq5acxvu2ict.fsf@kernel.org>
	<anXbJ2O4DWgPxCeg@willie-the-truck> <20260807135810.GA200537@ziepe.ca>
	<anX7F7dnKOtAOIIe@google.com> <20260807164734.GE200537@ziepe.ca>
	<anYgXSR4VAi3TpOj@google.com>
	<CGME20260807182023eucas1p1f653436207b2b00338e99ea1d8f847df@eucas1p1.samsung.com>
	<20260807182017.GH200537@ziepe.ca>
	<7d22482f-d5fd-4cf4-9d32-6a54e02f2fbb@samsung.com>
	<yq5av79iiard.fsf@kernel.org> <anml6lLRERm1Iv-_@willie-the-truck>

On 10.08.2026 12:20, Will Deacon wrote:
> On Mon, Aug 10, 2026 at 02:59:42PM +0530, Aneesh Kumar K.V wrote:
>> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>>
>>> On 07.08.2026 20:20, Jason Gunthorpe wrote:
>>>> On Fri, Aug 07, 2026 at 06:13:49PM +0000, Mostafa Saleh wrote:
>>>>> But the whole thing is best effort anyway, the kernel picks
>>>>> IO_TLB_DEFAULT_SIZE which does not depend on the system topology or
>>>>> how many devices or how much DMA they do.
>>>>> SWIOTLB memory is wasted if unused so we should be careful around
>>>>> that as it would be the other way around and users would have to
>>>>> decrease it manually.
>>>> Yeah, it is why the arch code shouldn't really be sizing it directly,
>>>> it should be done in common code and, yes, we are probably going to
>>>> have to do something alot smarter to have the common code better
>>>> auto-tune this for the CC case..
>>> What about the $subject patch? I assume that it is still needed to
>>>
>>> restore the behavior that was altered by the "[PATCH v8 00/23]
>>>
>>> dma-mapping: Track shared DMA state through direct, pool and swiotlb
>>>
>>> paths?" patchset?
>>>
>> I would request that we pick this patch to fix the regression described
>> in https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org/.
> I really don't think we need it. CCA hardware isn't exactly widespread
> and the KVM host side patches don't appear close to being merged.

Does this mean that the branch for-next/coco [1] won't go to v7.3-rc1?

I've used it as a base for the mentioned DMA-mapping patchset.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/coco


> We have time to fix this properly, rather than papering over it in the
> arch code.
>
> Please consider this a NAK from the arm64 side on this patch.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


