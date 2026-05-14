Return-Path: <linuxppc-dev+bounces-20940-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0609CCD4851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 07:01:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGLpJ26n6z2xnQ;
	Thu, 14 May 2026 17:01:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778742072;
	cv=none; b=M0copVkhh/NchQidKInQ+tosGeynylsAhEuKVYTUFMOZKjuvtk5ibAUq9DpxhYfDszXdvsaFJDWEszXnR7c2WFPj6C0CNJGiWJpKYmvuYHPjqAWLe5lvpZoL1eNjubTRE7Hgwq6OXA8fQ9b83Gpv70bBqAp64ACxg+JU99aEs9uvgTQCr5d4MoTVbGtVQsTjD4abziEpB8eXsnpM9xhzq5XavljTl9MMVPVVcoahptEXFUOAyY2EbkF8aKXPuw0Me535YrhIoGk2S/lp86Byu6+Q+dJsRNU6WKQn6MgGqYorXd1aSLb3r4D/OupzH/Nrp00O3KyJCv3/MJyWGljcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778742072; c=relaxed/relaxed;
	bh=Gd1QdciNqJLabQe9V6UbfKLhjsyQkS+rfP3lZ3ns1AA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SG/YyalWIwOLdMLium1GP7N9uqjDc/QKE2VvBLxPZ6pnmaH6Vvgmr1XkvOH9PbiOOk6tmHO7OkH3U+LwBaaqh3W/kkQENPPjLVUzs9T4sCL5wnwehX1+jTEqCFios5QBJasKw1SidVjT8MXYy8TYOLGo9GKCa8HXHegnACU0RIk/hmnup7zp3W/qn3sP30WMUWCv3y6eKh4mY4J2CfZRrmHBWrpVfmiDUBNKngqduvqMGCCcUpNtVcSEOTrtgGrJ28dNNfm5eNGWDytAA8WKJgyCnSIW93xG0G/S2CwXrq6uJuRBM2f2DZPdGuT0N8A+nKSqku2vxUjmSmk6T9BMCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HNCUigYp; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HNCUigYp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGLpH2SDZz2xlQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 17:01:11 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0979B40332;
	Thu, 14 May 2026 07:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96842C2BCB7;
	Thu, 14 May 2026 07:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778742068;
	bh=f66lgQPtTtd9CODAjOd3YiCN6f2o8c7PL46CffwEH+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HNCUigYpQNIMO+LxVL5xbaa1ZBiZuV2vfRVdsc+y1HHuPEq+l5D5j/DC+iPE2kiIq
	 NpDsRHaoFXm34+ZqBocK830wWh70Kw2uZ7kNeJCIkV7COgnNUBdPHRKGHc1Irr6eqT
	 RzIdbuXwoG5RlINNMckfHkUIlsEBm8Q+6X6fbrNS2E7E458DcXOOWvUh3a7kWJKjHX
	 3EMGurhVhG6iArtsZj1jNDGSW6qS4EdUJUwdCenJ/uVYvP608IEFPORinOqSL2kojN
	 dZmmuskcWBS0eH8pFr7ZoMjQsMpu0LZsmkHF6dDbrjpt0d1kopfEpVNDU3hdnSFdSi
	 Ck4CbLAhd2How==
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
Subject: Re: [PATCH v4 03/13] dma-pool: track decrypted atomic pools and
 select them via attrs
In-Reply-To: <agSED6BdSXBhbDYI@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-4-aneesh.kumar@kernel.org>
 <agSED6BdSXBhbDYI@google.com>
Date: Thu, 14 May 2026 12:30:54 +0530
Message-ID: <yq5abjeia315.fsf@kernel.org>
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

Mostafa Saleh <smostafa@google.com> writes:

...

>>  struct page *dma_alloc_from_pool(struct device *dev, size_t size,
>> -		void **cpu_addr, gfp_t gfp,
>> +		void **cpu_addr, gfp_t gfp, unsigned long attrs,
>>  		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
>>  {
>> -	struct gen_pool *pool =3D NULL;
>> +	struct dma_gen_pool *dma_pool =3D NULL;
>>  	struct page *page;
>>  	bool pool_found =3D false;
>>=20=20
>> -	while ((pool =3D dma_guess_pool(pool, gfp))) {
>> +	while ((dma_pool =3D dma_guess_pool(dma_pool, gfp))) {
>> +
>> +		if (dma_pool->unencrypted !=3D !!(attrs & DMA_ATTR_CC_SHARED))
>> +			continue;
>> +
>
> nit: If we fail to find a matching pool, a slightly misleading message
> is printed as pool_found =3D false
>

The message printed is

	WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));

That is correct, isn=E2=80=99t it? The kernel failed to find a pool with the
correct encryption attribute. For example, the request was for an
encrypted allocation from the pool, but no encrypted pool was available.

>
>>  		pool_found =3D true;
>> -		page =3D __dma_alloc_from_pool(dev, size, pool, cpu_addr,
>> +		page =3D __dma_alloc_from_pool(dev, size, dma_pool->pool, cpu_addr,
>>  					     phys_addr_ok);
>>  		if (page)
>>  			return page;
>> @@ -296,12 +345,14 @@ struct page *dma_alloc_from_pool(struct device *de=
v, size_t size,

-aneesh

