Return-Path: <linuxppc-dev+bounces-24147-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A7EC44501
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 19:43:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzXt72Cm7z2yb9;
	Tue, 14 Jul 2026 05:43:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f31"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783971807;
	cv=none; b=eVKnTAHJZNVyzaZNixNc3ku4xQWFkdCkSxkRWzwzx02tJsAf2ndi62u7MHxpOI6AGIcEBYB7xFEaqL5gnrpUPWNMrdWJxWisLLl0imFp8ri+4bX/ouxV8O4lLcKcDOIOSGQ8GOoA72whk13HPV6eLSrQ2617ttiL3qBR8NfMEsXdHcuL7ZbghJ+6QkKisBmQg3E09kJtzkUPawllcK8N+c7Y2risMtMneU8cq+DeApJwh5wGJWQi6wl3Udz2T1jfgvr9MhEYv+vycK9+I0N8xF2Gk7Of8RExG2hgQCaiqO7l7gEVoisdAAuPzz75UzJ8U0UMK5Vpean+eUxzgNmifA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783971807; c=relaxed/relaxed;
	bh=0npl5BvtjzaikMt6SIylqQSymiXrW9C26cahZl14wSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ok5p8okiz5t3MzZO89JwkuLNLnxa6s/WKjhBJv6x8bMrj9t3zuHUMrdqAK6Qa1RX8d5Mrt9LZ11w0WoRgoK+fteRDelXVx3HLGO5vDuKP8rZxSz7wqj0d676l9Kuq5OE4Fl7Jf2H5b++ahtlAEoJqqD2ZBMe5ZSYV9EqD6DgbCngFUaDVcUN34w0eejAAWyeYwhE8X/Xb3b6AX6CTkmgB3Tcsjkn1iz8+NYoBuw3mzuB8QkMjwK3oT5m71CQwfPlvudcVBmI3j3YOHLg2CDMytUyXfW2TSNublsmVFu/a/Rj6N7IgoLTAtxIfmp9AP7m7BcTffP+TXbKDPBqZbr7ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=CneI8la6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f31; helo=mail-qv1-xf31.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=CneI8la6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f31; helo=mail-qv1-xf31.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzXt63RwNz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:43:26 +1000 (AEST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-8efbafa1bacso29125156d6.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 12:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971804; x=1784576604; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0npl5BvtjzaikMt6SIylqQSymiXrW9C26cahZl14wSc=;
        b=CneI8la6NntxgtRKeYY2jdk38ELtEKHytA0jfEsbRsxvbPJi0G63L0SlHjpjkjWWLS
         bOpMgqH25wxbgUBV7HZYXF6GBmDEWS7amHsKFXE4sWMTGwHZgJZcaGfoosxA/NdSMFG7
         X5iPl0bfVBhyN1/d/Y2668nUFbOG38O1NV0za5yDMRX2G1kSPwE6hHBjXphYFchKDE9w
         rDrVmK0CG+PkZP95SyU8FpZYOMLXuyUysPZk0XOMUO6LeLnEuvtOphRUahQh/FImgDc9
         O2zb143ipVLERD0ohCM2eTgkTbscuhz+ZWxF9Ea/6GzCuc7AABLJapm+ItmDL2xoyYJu
         ebEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971804; x=1784576604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0npl5BvtjzaikMt6SIylqQSymiXrW9C26cahZl14wSc=;
        b=SZTv+szUNIGdOKBn4c1Vnjd47zQ8uPuMEnE21DH3KcODoUxWjwRs3GEif2rBxt4Zg3
         0ySuq/pdBcInTqEUSkOLUpz+U3IRNi/17vLUFEyPOeLh3SFcYLIFAd9RSGE4lfnQpmC1
         JDmM4bumkRcHs1fl1paaBKpEI9llZ0ibGHvHx9knDeciqyYQvAxT+K0i6LIRHgP3xeMz
         1wfzOdBKCTL5a6RpFd8rRhKdW38lAx5eaE06YiF0ihWUajglndWud9XJB1KReKYtDOIQ
         Dmd4/XEMg69oWEyXBKdVY3/iitaEhaR7xjIDTKycZkHhDiRahf19jstswtbXdLHzeLHE
         oUgA==
X-Forwarded-Encrypted: i=1; AHgh+RquWsNAfUj3zy9XOM48ZzUNDbQxgQZrG+T1/LvRrI5/kdh5CwjgrJ5/oIEZ532i2qQqySDMEcjRTGscHXM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzMuMN9fnZSDO0tf/pZgIvob3S3YJn+2qwUUbh0w5NPwFAryRtJ
	T5/ewNw2NjFi9qQ5npqOihVEmpYA5xtFSCX3ee22A2/P/n9sdRMmJpI+Bv/IXTOV1f4=
X-Gm-Gg: AfdE7cnm2MiG/gtzgoPZtjoZBQPC06wdcGsvxBZ/6j6Vwp2NpO1Kux4cMsNG0L9nIPW
	vFtHGMdLnWKhoExkEFIg9kYxLKr6Cs8PxlXynw+I51Gr4dxa9l5gaAQKcPtZxiZdl/7SWSafpyZ
	L6Pfc9mMzorQX+fWJRPX2sHzCmj9FKIs1LfchGz5f6rV1Ofaehsshl8tNReil4Vbz1EanuGIv5j
	5xyCzXQOrOITFrRzunk4QQlodq3e/JAU7WBX1AtgXAvabxd/7zczogtHTFtXlz8T7xssd96RD/1
	D5A/Of16XA47PCIPO3m9/V0/jp5oR2En0n0LASbydKAAvROx1dIFzPphHD334Q9VQT+3YqATPpN
	xMBw+CVh/LOeeef8wCJA6NdTIrh1qEvPPoiTsltxoENbPT3ngFeMkN+1ZOY4zfhpuHYaWR1o=
X-Received: by 2002:a05:6214:3302:b0:8f0:63b6:5881 with SMTP id 6a1803df08f44-9040236cc47mr114290366d6.26.1783971804298;
        Mon, 13 Jul 2026 12:43:24 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87c9500sm137858946d6.46.2026.07.13.12.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:43:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMYl-0000000E6yO-1CDU;
	Mon, 13 Jul 2026 16:43:23 -0300
Date: Mon, 13 Jul 2026 16:43:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
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
Subject: Re: [PATCH v7 00/22] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
Message-ID: <20260713194323.GC3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <CGME20260707080628eucas1p13fa8a57e60ef5dd3ec651e19e42af0a1@eucas1p1.samsung.com>
 <yq5av7argr65.fsf@kernel.org>
 <fc804746-4fb8-4ea9-997f-a4cae9ba8c14@samsung.com>
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
In-Reply-To: <fc804746-4fb8-4ea9-997f-a4cae9ba8c14@samsung.com>

On Tue, Jul 07, 2026 at 03:03:48PM +0200, Marek Szyprowski wrote:

> I'm fine with merging on top of the topic branch and I assume that this
> patchset is mature enough to give it a try in linux-next, but first I
> would like to get a review or at least acks from others with good CC
> knowledge or experience.

I think it is good to go from a CC perspective, there are still some
more items to fix up (like the MMIO) but I'd rather they be followups
at this point.

Thanks,
Jason

