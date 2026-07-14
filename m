Return-Path: <linuxppc-dev+bounces-24209-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84609C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 12:26:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzz7l6HvTz2y8p;
	Tue, 14 Jul 2026 22:26:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f32"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784032003;
	cv=none; b=NFYZyXhkg0V+9VfmHQKkMRDXQhKDAGS3NW/vLda4q3F3zGs5eUP0SbAjVcsGzehOsW2N9rgDttmRgBl9U6jQhw1RbcgbFTeHS+BnqWAjBDECGABN/4+U3+Po/yWRAizOZr62et+LySaRvKJYHpuECjU7lZVVkkcpl2BsnvgvxxM1oPAJHMpMZQeAzHWJ063Aflg7vSmpNkTDm0/He/UA2ZatgS4W2Dch8oDcnGWbLsBQDyYXojVyGd9h8SfVoJ2Kwjp5VRtyHixNN9MSKY7YPzZh0TBwAsZqXB3E1kpYf25g6SSj9B4yNlA2ElfKrW/M9YNlrrA2nbf6cdHIfkt84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784032003; c=relaxed/relaxed;
	bh=AuDF+BU2wT5tVoACVa1l/BwLN4UR/axOeynKCGX6Iio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpEMMfJ36jaklG9h8YELAzQfwy2xJcP0h6vUQRjD/axAQweidJVDaEqa6ifhhhL5IC2GUNla3/DS8BF9NdeuQ73HTHYdhWG8FNFuWVKEeEehOhacVputdFfIIa9O9hgZ7C+KP9XQ8EQTIiy30ydLwU+C4N/35ZUjHcM+TN4QU7xd7MbsSKhCK0dZPF3YMmCqe0F7+ejDYk2GEgkN7Yc8/CF4AhVPcxVup83HuBKuD7M6AbNT/DWZx6AdRV+K5tzwfkhiwmw+KICcuaLCHY68fE89Y4NPogpfJBTgot6bWsTHfMfbF0TuYs1xmBFXgOyWrC6NbYVedTbndynyEutJ0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=WjUZNroJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=WjUZNroJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzz7k45GHz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 22:26:42 +1000 (AEST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-8f18d92172aso12773456d6.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784032000; x=1784636800; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AuDF+BU2wT5tVoACVa1l/BwLN4UR/axOeynKCGX6Iio=;
        b=WjUZNroJbtZJDlEuHbGhjjU3vVXN9oVZII//KHQi3seAe5GmVkLArHqh+7uLvuMXDq
         Dg/7fRwBEGSccbksvWzi5PwWQKQvEmYqQLzAtdaF/f+tV93aEevDtjWlWdzvUfo4tjKm
         PwUl/2tWl3u8Yxk7KK9Vs8qgnHpstjVa3Hmqf8olRBHyQpUFS5t9F6TMZ6/pvshQPB2M
         VBwz77cOw84l6pBgTcCZOMROnynuoGgtG2s2RnQymvsoltGV79pV2xH4EqKjlxClhefL
         0dadq1i/Fz4zNYRQnRaONybSBy7KPsuDvuSr1k+bNyZkhh3UBvNpHgRZ59vpHooXtBYo
         CYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784032000; x=1784636800;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AuDF+BU2wT5tVoACVa1l/BwLN4UR/axOeynKCGX6Iio=;
        b=d/6rmmn53p8+JKTn3kQ8Ikje+Z6AUye4aaVOqXX+YKjgiqOW+uPIehX64CYpPB1yZ5
         vnNrFoSX+SqCLxXYwOpieICBsBaBes/zZJeKbzT5drjeMGIFCgSa0TFNNJxw8w8b7ah6
         CjGqUrqoAyl2XM4DvDgOZ51pwrvCcjGz11/3uHXmAGxm+7PwrhZOrAZOScRl7KQcN+hr
         /PN55thW0Sw8qFS3OIV/9YJxl4ECpkA15tcSwQq1uu+wdKdhI3jK+ruRLH7Xlx/pDay4
         QybepyZV1FK6rAyF9e8hNt9wndVObjHyQf0ZYjB4rjcJPi39hqjtmt8UzuDZBI27f7Rx
         GFrw==
X-Forwarded-Encrypted: i=1; AHgh+Rr/qYvyR+/HgH0uU2chN2qFvKaa2+3Ui9mrr9EUJ6qhHTs3DFUXAK7r2Ej40Hn1KOeu2cF9xQujkJIJm1s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxoLA1kzHo/LN/id+wtKX0hd9yE4TXr1KwCCKWFghpD7DoZtxCk
	SzJ5ckqHq+l46aby57EiOFx3Y6YXaDQx3uGxyc9CZhzybsgTLPe66uhtUw6r9kZvhP8=
X-Gm-Gg: AfdE7ckCDXqiUTjBQdISAj+szsVcb8pqPGrZWXkIslVlez5mdh31zdEcgX/IN9a6HhF
	lfHViaVujNequBiTM159dj+NNx3p1PmzHT2NrQFH+SgqHKVfNLOb9YwZ1QjHNiGUZo6MrueR6qr
	4GWbK9Vr2Y44VGZcdhny2AZK+pxsBD47aoCXnNnZn6yySXDyxBITvif3YIbOl8YQfzXaCLycYb4
	wNYM1xrmi2q855iPoZY/SHay3FZnJWdRqlenBvmFT6kFPJYl7SfNr+r8C1o2D/VDl0CIW10rYs/
	mtzORybxkbVvBqDpNoIW9f+q92h2mW0vkxnaUHD8p1jsyV7fKGBDVc+cg58VuPSHMSJttwHyOw0
	G4Qf0iteflWJZW47iOjUqiQImGuEiIsWFY1fNDDarNHCA57I3qZzJrXbypRo4
X-Received: by 2002:a05:6214:1cc6:b0:8e9:f5de:d629 with SMTP id 6a1803df08f44-9040423dcecmr141353846d6.56.1784032000167;
        Tue, 14 Jul 2026 05:26:40 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1ec84sm168106996d6.29.2026.07.14.05.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:26:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjcDf-0000000FRvu-0Ugk;
	Tue, 14 Jul 2026 09:26:39 -0300
Date: Tue, 14 Jul 2026 09:26:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 11/22] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260714122639.GH3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-12-aneesh.kumar@kernel.org>
 <20260713184810.GM3133966@ziepe.ca>
 <yq5aqzl6mc00.fsf@kernel.org>
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
In-Reply-To: <yq5aqzl6mc00.fsf@kernel.org>

On Tue, Jul 14, 2026 at 09:57:43AM +0530, Aneesh Kumar K.V wrote:
> >
> > But I don't view this as that important, the CC hypervisor is probably
> > going to use the S2 page table to force cachable on all system memory
> > so the non-cached pgprot is a NOP, but the extra vmap is wasteful and
> > it is confusing.. So maybe a little fixme is all that is needed here.
> >
> 
> Something like?

Yeah

Jason

