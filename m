Return-Path: <linuxppc-dev+bounces-21168-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFDDCD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 14:49:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKcyg2WRNz2yRG;
	Wed, 20 May 2026 00:49:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::729"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779202187;
	cv=none; b=KxOvrVuEQRje7PteM0WlNialjGsYACdDLAKL1EXQ6rl16ftC6jPgE4piFy+/jwC3NXF2bD/q9BVk00dVFeQp3otYFdZDDhdU6zlSuV2JHkSxDZXMpqjQmW/sTxNMQh/V9V0epJVUA+CC7P0alTKNSFmYadcQboPccZFVE4F/cr1O7sjUKy0M8wZtxhCectZSXteF/WFq+NpxbiRYs7Tw6wNzGFLIkiC0bET5xsXTPGiWx68umX8Cen6MO8YAPfPSKog4Ru+t157cDLJGyPHC+kvZP1rwpKMQKAM5OkvxxbLRGttlgfKpz1y2x2LNq8J4d+VWnckU5n272Ud6CR9PlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779202187; c=relaxed/relaxed;
	bh=mf/OGUGuIRiuTTXYie0rUXZGqyUUzS6jn0J2l0v1FPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzJclQn2+qREVfcIbRG+FsQ4VqUWZrkxjYYIZ5bD8mBmuWKjQIvtbZoQeMqAIdIEooMWIywut4HOpzWMzwl1RGj/SnWb64aDd9V4of03hCmfGE/Hu+5JLwSjDb4TI1QN9lvRDrYoiH5uvP7Ikb+Vye4MW8aJ+md9J7LvJaM+I9irT0jurJOxhmkD8vl/XCa09pWZ5Wcby0lllbKv9Z6HU2koHnv3I9DHSsDPq+0bf5hbsU0UOvv7gM/lEMcPJwNnq7TlpFyjj4+lDQPbLBzKo338vHdOqsddYKksHZSXLd4Y4eVOPAUCQ1Rie1GbaNxp6CIFBY4xcR5YYf/WgBEg+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=aIe0+QUI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::729; helo=mail-qk1-x729.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=aIe0+QUI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::729; helo=mail-qk1-x729.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKcyf130Kz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 00:49:45 +1000 (AEST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-90cbb2b50ccso286933585a.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779202183; x=1779806983; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mf/OGUGuIRiuTTXYie0rUXZGqyUUzS6jn0J2l0v1FPs=;
        b=aIe0+QUIm9W9c8frg7fClbM2NMY+jld82ZHFUY8vLKpTdnaAKl+i0YgPxiYOzmlmi1
         mi/S7pTOu5jVOM7+enu7N9DtjG0HGM18qA+mjVYXW/efLi+ScQpa5CPM09Ooqt2m64x9
         Bx9necnFmXoJ3M45oKXIxjTpfHwKZDp3mb9xDTlPc3IeXmEVY6YsYMsHc2SY/8kB+1Bf
         v2Fr9zKbVTKlwqrVacvGulqnFce4RJDU45v/hSeC0CYDoD5/coFBupSHZuLSrUiXciNf
         16Ljpz90DnWbjU8MZCx3IPitzsjoWXIyVkyF0urIRidM6tcKyOeMSWIezyUhjgM3z4/V
         7agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779202183; x=1779806983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf/OGUGuIRiuTTXYie0rUXZGqyUUzS6jn0J2l0v1FPs=;
        b=M6woeWMi4HYMpvQnUHxjqImbtdmLX2LHajwtMTyQLecO319nm91GZgF9xdGSoAQidR
         GbwnLZuYZJne6qPSc2C/sqFwEMa3HA/lmxuOfLw/vlMt/BVRJ1cVr89XnrAxpIfK2brq
         m4CCrdBfP2hhFhbU2W+FuqsHQHuj1mpqKmrh/X5Ao0wlxxTbl3hTWakbw3KR0o11TETc
         zJ7NlUrURlOkNuMVWVbKaLSyNdKJ/UPexRZ/wsMW2bm4bVdM/z4PwFrPNIrCsibzzJfA
         TRgwl8uaNTI+gVYy7wSsONsFCNb1faMiz8an4qC2maf8JVQClB60Too9hN1B3psTMGch
         XbUw==
X-Forwarded-Encrypted: i=1; AFNElJ+AAGLf7betYIlLn4wD7zu9kHNjfj9jC1qHMvFRkmokMdOtEUwe3mijSeaYxczyvr2J5TzpIURis3Me95E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzUctCbYa0aQYjCKsOOvKH6ttFu9Dd8YRF1eL5Jb9nSzf0Xqyaq
	GX8rTi9JO0/8+a6Bpp5u5QzieRgMg/E4SDpT4C97gy/IgiTg/5ME2aR5t8sOwDULows=
X-Gm-Gg: Acq92OGLlRM0Dv2CyoYXfN43zirQMYO0LxjD0bWn0YaYW3lfbmm/n2bnSFcqKWMMD1H
	crQ/ijwS0hsQHG2EefbK7jtXYsBxMnOo4MfudYv66EZPYFLqvozWa9qxXxrPAWnINh84FUgZvr2
	ZfbM4A8CFPzO9sOn7DkztaM8j62K3RGg09f+h2D9fPBODbnfIdWPXn27rc29oSfJYZpMwo/AxSg
	3165yMyDbaQeZof8BjcWMFWML0BaHlkvSjsjYIXE6IBMnhCcs+2qsoJoj1UxSBmlTKH4eexI6pd
	eATntp4fLj19X4qPvI2Cxb4tk6Xz7471JBGgmvvQYHieAI0x/5q3MY53XV0oOWVrxFbcpqbc+7I
	B8LixXW1ltiAxbGcPuplYiEbk5yA9QasuRG7g4lH6rOHakwmzXkwMskzbPkTaNO/Vija+m761xm
	oF2kE7+5L+b6kXqyaKgcSyn/mluKi0QklGCnAkRC/aEpkyKsPPlXdSKYiq2sWUWZN5eNA10qgJ4
	dG79w==
X-Received: by 2002:a05:620a:1a14:b0:911:411e:2e4b with SMTP id af79cd13be357-911cd46df94mr3109274985a.23.1779202183344;
        Tue, 19 May 2026 07:49:43 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba36e68csm1851459085a.10.2026.05.19.07.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:49:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPLlO-0000000F92G-1VL1;
	Tue, 19 May 2026 11:49:42 -0300
Date: Tue, 19 May 2026 11:49:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
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
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <20260519144942.GJ7702@ziepe.ca>
References: <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <20260519132911.GA7702@ziepe.ca>
 <agxolksC_1nfO34X@google.com>
 <20260519143529.GD7702@ziepe.ca>
 <agx3j6Oc8QivZ3RG@google.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agx3j6Oc8QivZ3RG@google.com>

On Tue, May 19, 2026 at 02:45:35PM +0000, Mostafa Saleh wrote:
> However, it should not alway use SWIOTLB? It can trigger decryption for
> any memory returned from __dma_direct_alloc_pages() which can come
> from alloc_pages_node().

The alloc coherent flow is seperate and different, these are not pages
'passed into the DMA API' but pages fully allocated internally and
owned by it.

Yes, it should cause decrypted *allocation*.

Jason

