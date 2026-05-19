Return-Path: <linuxppc-dev+bounces-21155-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B1FCD4F5B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 13:39:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKbPL75Qxz2yD6;
	Tue, 19 May 2026 23:39:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::82c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779197958;
	cv=none; b=i6jPkqMu44Kn7mfb1fGxxkRcA5eoZRg/CZcsXszNsYywZGF5wLua61khwKoTD8AFk+DKPEtiNbSo37TvvsQGFCwu/UaqKXYo6i3XkOaDYGhCpftXRnWh0RZPAs034rc1iFjxDPKK1ENK2gm7ed7lVCobWOKE0MxggLZFtPstMoyXI2PCr2P79cRSuB5BbKAIyTH+Xgos2Uol7ognpPERubltSMjUzLmEJReN0oBZWuXSUlMoZDBocl5kJ7c4ighkKDn8PX6W9+dMQs1Z3OWlrkPGEbSvLgeKICAvv/jHuHh7lYukTMw1hLRLiWWI7BRupfLIUwMnknfW4OTTau5A8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779197958; c=relaxed/relaxed;
	bh=Y2jBYQyB5cOJsBc04yDDPLVV700aJQU8UB+xEqw7DWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEYdQv+pfmdm3bGNZ7UZo1nYXxyTSVgyOIr9LrjeP/jB193PCzvi4RtnvS5ixPI9hlCSC8jPJXcqt1Pw2Cl+iHYV+7Q9Dh0WZSZvHb1H7W/7+JKPgAmSEawXNMiuQD3Wl+RCbD4CkZrcG4x3vfoatsZGXtbsqq7hVoLErrD6iII07oQIg2Mj9jPjjFrYPWSNvfg8OuhHHdfBMu4Y1ruKKxiDydZ3muqKT0nfN439p496vrnMW/EZjQTUSZJ/SBkzooysw5jYHDaa2PlJ2NLo+d7ttkyqMCjtrFgTQbMGuHSERpT9vWYcyebBIkwMB3LWijz3DG8rZO1Y+t4jLlTeaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=NvGkdEeA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=NvGkdEeA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKbPK4phLz2xqv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 23:39:17 +1000 (AEST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-50faeb8317bso33617921cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 06:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779197955; x=1779802755; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2jBYQyB5cOJsBc04yDDPLVV700aJQU8UB+xEqw7DWQ=;
        b=NvGkdEeAsSZWSA3VQFw5Ma1q+iiCYK1GYtmYBDGw5Zev7l2C2wQGZwnHbhIBk/IYgL
         mjRGAjeMQLWUzJ1L7wjj0pGmZ46BsLWcns43mswiG7YDR0HZajWIsz4FkhvVF4JuoUUI
         vTFg5uH3ZQiP9v6uQHT0l6+tduzdXWc+fNOzzs6mVrZsZVR5X/wlHFP1S4emjGdZU7G/
         b/P5wjqP/Vez2qwxgjfqR+w/jcu4Vy9PVon10nTydLw9Kx9VA2XWBpJOYJxnh4UeS3gj
         62tJwWdvDWz8fl4lOfKIlUnHROANwqgQU3yCxo2Tw7GPc7YhM4j4p2NMhwxiIj9FXLJ4
         q3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197955; x=1779802755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2jBYQyB5cOJsBc04yDDPLVV700aJQU8UB+xEqw7DWQ=;
        b=q1v2AQ32DK1pynoNm7gAe6Mh4Jwa8F69jLVYAfKWbfWThf/qm4j5B5y8cuNRgGOxP8
         GenJmN714KywL6q2F+KLSQijTJ/e4rhufHQQVGCR+J1AhShkqZL6uBBQUkA4BndDRftL
         4C9d08o+FDwL7eLlEwqTaUsU8mhBIkuCGE2kSOq3hb9xfR86SBdGW5DfPRz6NZDFX5gZ
         rsvYglKPM4RXxaELCfUWAKHyaWpFkvEjOWqeQQEWoL+2bHwvcQxel/Lc3VluAvNqEJHX
         se8Ui5lLJ2jI0rrcxuMeUcJhXsoiY3W+9GWPWEK1h+AIZ+GQwrfHmjC86YhYPdGULDib
         G8ug==
X-Forwarded-Encrypted: i=1; AFNElJ+EaNbCzOKPc/A/CBPq+nJ/V3ShDbb00RnFn0/jyJJ4I32BCFhACg9TG79hSuJ2HEeFqT11iPhCkKuFdRY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzdQuAJWzt6LJRVkqShnlpfRlYIYwjIwNy1C8HvNjIuep36dKoM
	py8Yap6JaDiJdpeOeNJaxZc70uFADRznmQA3hm0DBdhrZxYtwxxvDTllOJNCExuHMfA=
X-Gm-Gg: Acq92OE9ZsOPhl5s8dLEaAePMNIy8D9iYenVwRlp7tGv/swjnURME89AAj3t1ybSkJ1
	fT8B9aLee8swTO5R9o/mNL3B53xuIK0zYnYPlZAJlWeMW05HVfACZ0Z6TNxlgiyV7R++Tj+AuK7
	jgHbVlw0NwSzCHCaW2/YbHj5RHTAU/u/eZGrh/3/QlwBvOE4ax9WoglQ8HsAxUlSN0VbR0A01c3
	FoImXZ0fA9eTCGTsF3GD281sFrER3MpZ5vaOhBQKwj6Sos/Xw5DO4BctdmQqMWK0weRs1cV//15
	lU96zF9ol0t7k2akD6+C18Nmycb6h+k+ViS9Yz3RDEayzCJwYGyWNT/8+Zr/0O64QPlVXt54KAn
	RIPvdD3JjViNpGq5cuE7Hu/OVE4mX1rhBUAR7cYC/tZBlQkhAx0gWWviGzFM4eLcHVDUCtoGmt6
	aRE8mBrOkzC9wdJ+ug7dZRH721LVHkE9BTd89x9z2Eh0JC/ugBjshhBsd6NwuMkQJ1GAFzHtgEJ
	ZjroA==
X-Received: by 2002:a05:622a:50f:b0:50d:a6e3:ae1 with SMTP id d75a77b69052e-5165a03ee67mr270655651cf.17.1779197954757;
        Tue, 19 May 2026 06:39:14 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516514e0b91sm152289551cf.15.2026.05.19.06.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:39:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPKfB-0000000Evg5-382Z;
	Tue, 19 May 2026 10:39:13 -0300
Date: Tue, 19 May 2026 10:39:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20260519133913.GB7702@ziepe.ca>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <20260513172450.GR7702@ziepe.ca>
 <agW2lzJI-20DyJVe@google.com>
 <20260514123529.GZ7702@ziepe.ca>
 <agXfm3mS_M3fvRrN@google.com>
 <20260515225113.GN7702@ziepe.ca>
 <agxETC1rXBUSkWYg@google.com>
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
In-Reply-To: <agxETC1rXBUSkWYg@google.com>

On Tue, May 19, 2026 at 11:06:52AM +0000, Mostafa Saleh wrote:

> > > One other interesting case for device-passthrough is non-coherent
> > > devices which then require private pools for bouncing.
> > 
> > Why does shared/private matter for bouncing? Why do you need to bounce
> > at all? Do cmo's not work in pkvm guests?
> 
> At the moment, in iommu_dma_map_phys(), if a non coherent device
> tries to map an unaligned address or size it will be bounced.

Sure, that's fine.

> In pKVM, dma-iommu is used for assigned devices which operate on
> private memory, so bouncing that through the SWIOTLB would leak
> information from the guest as the SWIOTLB is decrypted.

Yes, a device that can do private access should not be using a shared
SWIOTLB, that should be part of the selection logic inside the SWIOTLB
stuff..

Jason

