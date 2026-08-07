Return-Path: <linuxppc-dev+bounces-25552-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1DEC5AC80
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 10:05:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGfsP3Rkfz3c2L;
	Fri, 07 Aug 2026 20:05:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786097113;
	cv=none; b=BqYgGHEwUvEhM+IzfhzdlCG95kzwWgpuwCVWofWuz6CUTlGEbTJbkwMvXl3NqAtQOEBlEagNGizXaYO9WTUUY8I6shSAmQPW4mnR/5EazM1idi3wa02RB0Qq+x1SCl1PmGoiDU3wYgHVABAmK/hiubMF5YCT2kECy2pKZFhJLqNPnLBlS7M7XfJwmVAPNX1alRKUhHJNrJ1+FpqxPWpvTBexjeIegx+hVPnSLqEjEIRA2QSozgJIgu0EYRoRrsg7AaYQanvNn1+w0KRvVcV/rjVqyXjy1saLerorwMdoGvyhG5XM6Ymp7rfHe26aswmLN7cbK87QiI6XESDtR1PfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786097113; c=relaxed/relaxed;
	bh=tYmr0H9Ny/ow4oRf+kOxKy/va62yVPIOs3FFYDqPiJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=EYJpTDxxQ7HCQ6kfMzKpRjVjZ82ORaTKCT6oqs4y0uPlQfPFQ7L84MYNWGh/y6y5cbvgu8NzeXCzDntDzmuotEWCUqPeeH26GdKrwhz14omOPBwOIdJzOTFM5J4wI5yh8g/HmovO21bI3joriC79+Wx4mUTlLPhlUtJhqP+I4q0lnWj3aH14rdOrIKJZW4D2xINPZ/In2dCKu+jo3ooARqxCNlwej5JaK9SB81w4e64LeeXPqHts1TCifbbALDAUSq6e0stStivUxED/OLVSZ0F61d0xeQ1u5c1Bxr8QSoJIgHcaFlqc5ema2hGcASL9KH0IB1/dDbqxPLEuCvRDwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=eSgPaohg; dkim-atps=neutral; spf=pass (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=eSgPaohg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGfsK6JCjz3c2K
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 20:05:06 +1000 (AEST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260807100453euoutp01e08fd1317b5254e81dfe38ab56a7e318~JfdftXfrq0070000700euoutp018;
	Fri,  7 Aug 2026 10:04:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260807100453euoutp01e08fd1317b5254e81dfe38ab56a7e318~JfdftXfrq0070000700euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1786097093;
	bh=tYmr0H9Ny/ow4oRf+kOxKy/va62yVPIOs3FFYDqPiJE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=eSgPaohg3Ovh0J+b1VIFqfeHKkdgmjpLe5hrSy9TY75XNitr28SV92trUU9PslGo3
	 GaTZ+DDtA/CkPLguep0RMyOGadNXne7NZjAO0FCPKMjC/pYLr2u2SAbwA0Yp+g9cnq
	 bhJxJ6mGaKViGjHEGlcRFjpPia7jjmMs+eZr590I=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260807100453eucas1p136aea760b58c932260c5118603636b6a~JfdfRJz5D2159221592eucas1p1t;
	Fri,  7 Aug 2026 10:04:53 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260807100450eusmtip2cd49a3ac23b36ad2dca8af2eba115dfa~JfdcaVKqS0729607296eusmtip20;
	Fri,  7 Aug 2026 10:04:49 +0000 (GMT)
Message-ID: <04c8b1a8-9194-4e63-9d30-11315ea6c1a9@samsung.com>
Date: Fri, 7 Aug 2026 12:04:49 +0200
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
Subject: Re: [PATCH v8 00/23] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
To: Mostafa Saleh <smostafa@google.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, Will Deacon
	<will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price
	<steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
	Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason
	Gunthorpe <jgg@ziepe.ca>, Petr Tesarik <ptesarik@suse.com>, Alexey
	Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
	Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, x86@kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <anWqq-vjEwwaziaM@google.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260807100453eucas1p136aea760b58c932260c5118603636b6a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260725070930eucas1p16cbafb514de7a2e7531d0e4ae158acfb
X-EPHeader: CA
X-CMS-RootMailID: 20260725070930eucas1p16cbafb514de7a2e7531d0e4ae158acfb
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
	<CGME20260725070930eucas1p16cbafb514de7a2e7531d0e4ae158acfb@eucas1p1.samsung.com>
	<yq5azezfeeax.fsf@kernel.org>
	<85be992d-9567-433e-ae2e-64ae5483964d@samsung.com>
	<anWqq-vjEwwaziaM@google.com>

On 07.08.2026 11:51, Mostafa Saleh wrote:
> On Fri, Jul 31, 2026 at 09:33:47AM +0200, Marek Szyprowski wrote:
>> On 25.07.2026 09:09, Aneesh Kumar K.V wrote:
>>> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:
>>>> This series tracks confidential-computing shared DMA state through the
>>>> dma-direct, dma-pool, and swiotlb paths so that encrypted and decrypted
>>>> DMA buffers are handled consistently.
>>>>
>>>> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>>>>
> [...]
>>> pKVM topic branch is now available 
>>>
>>> https://lore.kernel.org/all/178467286876.125042.12010461715645610054.b4-ty@kernel.org/
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/coco
>> I've just got back from my holiday's and I see that there is everything ready to give
>> this patchset some tests in linux-next. I hope nothing will break.
>>
>> I've applied this patchset to dma-mapping-for-next, on top of pKVM topic branch with
> I was trying to find this tree and it seems the MAINTAINERS file have
> the wrong address:
> DMA MAPPING HELPERS
> M:      Marek Szyprowski <m.szyprowski@samsung.com>
> R:      Robin Murphy <robin.murphy@arm.com>
> L:      iommu@lists.linux.dev
> S:      Supported
> W:      https://protect2.fireeye.com/v1/url?k=dbfa7485-ba7161ce-dbfbffca-74fe485fb305-800153ec5c55b6a1&q=1&e=ed464763-9bbc-4c24-9629-f9ac5e8f5ef4&u=http%3A%2F%2Fgit.infradead.org%2Fusers%2Fhch%2Fdma-mapping.git
> T:      git git://git.infradead.org/users/hch/dma-mapping.git
>
> I believe the corret one is:
> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git/

Thanks for pointing this out! It looks that I've forgot to update it.I will send an update soon.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


