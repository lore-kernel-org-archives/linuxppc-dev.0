Return-Path: <linuxppc-dev+bounces-21170-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCACDCD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 15:08:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKdMs2p9kz2yRM;
	Wed, 20 May 2026 01:08:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779203289;
	cv=none; b=Ig+qw4UQRexuckUgXawx+MkzIaJKZHHKGtQDJ4uUaXLMyeIkqgecu/zBhMZOiiCG8Lnx9JE34Us/JoQLiwJ1ndhdHwX3rYQ7izTvFfQZZjjJskeTqbo81Vno48BJ/JngvM89PFbn4PGAmnLh0U/zN8UZmek+LPKEflt+9snCm4SGSebhTLqPIumgDRhzuWLNJ9FVrkhUHmYrXX+PfMLqbEx+KqMZNIm4aNBBYnJf8ord5RuxL4hNztHSQmaiKNeEwDujTtincviv2YTpq4XCXjv8BQtOp/90T9bPo2io2ZX+KRDnDFV44o/5sd3E7x2fVW52NbycKfUeFFgDYZ6wWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779203289; c=relaxed/relaxed;
	bh=Ttyl0SGfI2S+HXHnoxLYjOoSjjZ/rM+6b9HnFU18EnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SEKbcE/kTMIErjNXVRQ2NSIlfcXJl3pXudr0kiTWlLpP9Of/hd5ID825JsIL7t+D2ePlgjBheS+poBKK1a7bEr+oSTDE8s4eTASWw0Ac7Y8nF1EwyvQ8GOW+aaQ3qPgeIX+sgG9e1CF0ZBJPG73jv5b4LkyCIWKC2fL4mpXY/z9HrWVUVx/IzHYIqVjF+Zb7WF8ZysricuX4lcXopkcicRboqkoSAhBWYuM1lME29Wcvj+3FYkazO0YzNxujEA8lYEfM6TOTf0IKsbVkoik2F1klUPr37zNdQF4Dp3bz9JJ2cJSBShBUSS9uTdKSl8dSaJ5bE/sbGhmSjIfY+OwoLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gfCVmqRQ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gfCVmqRQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKdMr24cBz2xqv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 01:08:08 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2AEB060121;
	Tue, 19 May 2026 15:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CB7C2BCB3;
	Tue, 19 May 2026 15:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779203285;
	bh=KyaOKUufk660jyAnyO4dwLztr2A/5z8gocMgG2ZXcQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gfCVmqRQQdy8M8HA+XstwwoOpKN65jH/uDBv2iWJ6wdryzFjV5aqQ5J5zLKpnXd1R
	 MFePXRwJdlj0GE7vzB9h3mSdyYx+ToaECrqs8QXecIfN1ZsN3uSEg/aPjk5q3dnHDd
	 6x79LO3IArWLhr/nYRTv/X7YOfD7PNsBnNqxTreMAIV0LA5SmVfv87HgZUtCD/QPrU
	 ZbPRwVbbTLSoiNY4KtbyRJLSxc77SM+MLRmeWIXpFli++we4iwZ1y+H0UFcDRjYdiy
	 f3BUle31jswVsGu+sQx5NS55VsHZxmeQelzm2Y/aOpkLXTQLxhx9k+011Cn+nvKBVz
	 CMNlOzS75r7pw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
In-Reply-To: <yq5amrxvshxg.fsf@kernel.org>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com> <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com> <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com> <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com> <yq5amrxvshxg.fsf@kernel.org>
Date: Tue, 19 May 2026 20:37:54 +0530
Message-ID: <yq5abjebsaid.fsf@kernel.org>
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

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:

> Mostafa Saleh <smostafa@google.com> writes:
>
>> On Thu, May 14, 2026 at 08:13:25PM +0530, Aneesh Kumar K.V wrote:
>>> >>=20
>>> >> What I meant was that we need a generic way to identify a pKVM guest=
, so
>>> >> that we can use it in the conditional above.
>>> >
>>> > I have this patch, with that I can boot with your series unmodified,
>>> > but I will need to do more testing.
>>> >
>>>=20
>>> Thanks, I can add this to the series once you complete the required tes=
ting.
>>>=20
>>
>> I am still running more tests, but looking more into it. Setting
>> force_dma_unencrypted() to true for pKVM guests is wrong, as the
>> guest shouldn=E2=80=99t try to decrypt arbitrary memory as it can include
>> sensitive information (for example in case of virtio sub-page
>> allocation) and should strictly rely on the restricted-dma-pool
>> for that.
>>
>> However, with my patch and setting force_dma_unencrypted() to false
>> on top of this series, it fails on pKVM due to a missing shared
>> attribute as Alexey mentioned, as now SWIOTLB rejects non shared
>> attrs, so, the DMA-API has to pass it. With that, I can boot again:
>>
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index 5103a04df99f..b19aeec03f27 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -286,6 +286,8 @@ void *dma_direct_alloc(struct device *dev, size_t si=
ze,
>>  	}
>>=20=20
>>  	if (is_swiotlb_for_alloc(dev)) {
>> +		attrs |=3D DMA_ATTR_CC_SHARED;
>> +
>>  		page =3D dma_direct_alloc_swiotlb(dev, size, attrs);
>>  		if (page) {
>>  			/*
>> @@ -449,6 +451,8 @@ struct page *dma_direct_alloc_pages(struct device *d=
ev, size_t size,
>>  						  &cpu_addr, gfp, attrs);
>>=20=20
>>  	if (is_swiotlb_for_alloc(dev)) {
>> +		attrs |=3D DMA_ATTR_CC_SHARED;
>> +
>>  		page =3D dma_direct_alloc_swiotlb(dev, size, attrs);
>>  		if (!page)
>>  			return NULL;
>> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
>> index 4e35264ab6f8..8ee5bbf78cfb 100644
>> --- a/kernel/dma/direct.h
>> +++ b/kernel/dma/direct.h
>> @@ -92,6 +92,7 @@ static inline dma_addr_t dma_direct_map_phys(struct de=
vice *dev,
>>  		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>>  			return DMA_MAPPING_ERROR;
>>=20=20
>> +		attrs |=3D DMA_ATTR_CC_SHARED;
>>  		return swiotlb_map(dev, phys, size, dir, attrs);
>>  	}
>>=20=20
>> --
>>
>
> How about the below?
>
> modified   kernel/dma/direct.c
> @@ -278,6 +278,10 @@ void *dma_direct_alloc(struct device *dev, size_t si=
ze,
>  	}
>=20=20
>  	if (is_swiotlb_for_alloc(dev)) {
> +
> +		if (dev->dma_io_tlb_mem->unencrypted)
> +			attrs |=3D DMA_ATTR_CC_SHARED;
> +
>  		page =3D dma_direct_alloc_swiotlb(dev, size, attrs);
>  		if (page) {
>  			/*
> @@ -451,6 +455,10 @@ struct page *dma_direct_alloc_pages(struct device *d=
ev, size_t size,
>  						  &cpu_addr, gfp, attrs);
>=20=20
>  	if (is_swiotlb_for_alloc(dev)) {
> +
> +		if (dev->dma_io_tlb_mem->unencrypted)
> +			attrs |=3D DMA_ATTR_CC_SHARED;
> +
>  		page =3D dma_direct_alloc_swiotlb(dev, size, attrs);
>  		if (!page)
>  			return NULL;
> modified   kernel/dma/direct.h
> @@ -92,6 +92,9 @@ static inline dma_addr_t dma_direct_map_phys(struct dev=
ice *dev,
>  		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>  			return DMA_MAPPING_ERROR;
>=20=20
> +		if (dev->dma_io_tlb_mem->unencrypted)
> +			attrs |=3D DMA_ATTR_CC_SHARED;
> +
>  		return swiotlb_map(dev, phys, size, dir, attrs);
>  	}
>=20=20
>
>

if we get force_dma_unencrypted(dev) correct, we won't need the above.

for dma_direct_alloc and dma_direct_alloc_pages() we have

	if (force_dma_unencrypted(dev))
		attrs |=3D DMA_ATTR_CC_SHARED;


for dma_direct_map_phys(), if we have swiotlb bouncing forced,

swiotlb_tbl_map_single():

	if ((attrs & DMA_ATTR_CC_SHARED) || force_dma_unencrypted(dev))
		require_decrypted =3D true;

-aneesh

