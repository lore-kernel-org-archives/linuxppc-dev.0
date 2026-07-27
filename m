Return-Path: <linuxppc-dev+bounces-24853-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040C6C531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 04:24:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7lq214Ymz2y1F;
	Mon, 27 Jul 2026 14:24:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785126254;
	cv=none; b=Mme7vzklRfhDwb+MqoMo6iqsSWTG1p8THmVNLdiRYE0DDIjuGq/2F8ub/NzCk76udYEZ6nivnTbmBQYcJFSWak9xPZWMSQOcxxvc+UOVdHejFIWogkn/Ng3xVChMLQOatDcyNnx14b6S2BJlD8BsABLWYJ9AaHXZN1T8Q3POSnnLNgtAUoY49giefZjCp+WCihAcKZ9+ZewqUdybn8hVChrMsDHou9/RumT4i8Xxo5auXXGS2B77384hJI86MlquOe7MsVJJFKq6z0W4hzkWWOh9c0ed0U/bTZL4e6KMk9rr9zXXekMp/ncT/AMvUjRkUsX812kBvWOWcUjRE3VN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785126254; c=relaxed/relaxed;
	bh=Yy8IISh+FV9cpGipg7vORYQVek5AJgkZkfEGn4HmLng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llP0z8x/xX+7idXa1biHWki4FotpYIe/AK0/cu75Qy9klr1h7RFVne9v/wEougdtQ6GqPjiShoEk5epXtsjWyf1tS+NwmsVKLwBnRrgwuNkr5MA0RBjYR+kbKL8q2eDF+pAzIHYcvtQDHn8gLmKLKDWB8hBrlCtXmorvGAKx0z03+eRybx38Zc47LHXqcWOKHdt17qU+6W5nMvuLXy+fYEWRCuvFD30VEgWNJD18II0wTpdbZOEfA/jKAyVwo+EsAKz+ke1n2Dm8iFqsNlAeaw1NOls21r//qhrm5H/WnQzkBf4WYfdXkVMKjE6MCfMdefrPn7wQIJXWbHUeu7mskg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=XFOE3bn6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=XFOE3bn6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7lq04W7Rz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 14:24:11 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1861018a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2026 21:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1785126249; x=1785731049; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yy8IISh+FV9cpGipg7vORYQVek5AJgkZkfEGn4HmLng=;
        b=XFOE3bn6Do3xmjzgbv+sb7XlbXY19yAMTfSoReozhPr8EPHtA5p01ICoKoo1dk1MZ3
         V++h8TUqotWpPvJRMyK72JZAv02/ys7axPzoTnjVDqJoCjpdug6BRJ5bKxyIYLv/6t6s
         c/PkRnYGtazmCHWc2IldwoayrZv+x/B8jA9hTQFUQIJhKymkYf1M85ayWQAXqP3LFMKl
         F9AyFTvmMXqelNffUEIDbnwGxCBb3xCiUNDxfzRMjhfkxbUNbfdVJ9o1NzHuHn2pcMbW
         tAJPwFdR2psgDW2swOFES3s8f1HGsv0rVwSBBR1q/xY299X3wKHJ9QWKQ2Lx9GD0q6Pn
         30Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785126249; x=1785731049;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yy8IISh+FV9cpGipg7vORYQVek5AJgkZkfEGn4HmLng=;
        b=AI+RPb5oUtp4l1vV64Q0dHwjsj08IftCCSVQekhg+7vMadDnKZwljXzW5Qp6BxJ2cA
         5swHEcBtL7UoVSyGLjj0dz3AkPwok0sPAP1jM1y/TYx5yhAaU1v2TKcoHPxcBHih1Eua
         elH7GNcOC2066OTCmVtWjJMV53bpeqEGiKWl42nKyK0HQKI2KJeKUDhcK4UnOslSH61+
         crJUOycdZOiCxO5D0oeEG3+jKU1dKp1qolzdp5lqQOZEbc6R5c4bFKgAchwsiH8XbWZ6
         LgW0y3EdkO/vQX+cElcdkJ+NdnV5IkKyrnnI6BekKp2gy/BBk8J1NxnztbBcFy2+abAb
         dmVQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqra4kTm+Q9yjkSY+RenVCuW13XH07BGK18tlqA6Z6WRMBSZMqpBJ0tN97d5IHYaGPoPFzYUHNk2qySx1g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyMUsPIuDCaZQLNPWXk7/NSJdnI2U3P9+zuwMqGoudzZWYhmxPw
	FYV8sFylAZ7A+9O/4Tu6zl/1OZ8SLv4RZUh7hlImS7j0IZNsoXPLRIOCCM4A4PmddDE=
X-Gm-Gg: AR+sD12cun9Vk1d6AHvn6vBA/TYtDqFBTTsz5mwzBOUUSP75dSzr3jo4dGZ3cCMncLe
	6t54iraiHPnZmzMRK1EHVerx/CAxVneL1f8feNOx8Euvf5yJ7U1akfYDA/69EZW2Dd73Bzbb17t
	oDBWaa5lwNKv9kvsmHx8X02GDMlcACfHOcJNuR+8jSGAxbW7ABBjO6PNuc1yl6Kufm4jTmVVsNa
	a5YsqyY3hIgMyPibKhPFUw4J47X892Lu87bfHdzeHmH9+3RgokpwnHuJGwBvewUCLoiijPHuhWu
	uj6/BQ8rKovXLpXNAocQvbi5TiHSdKw5fd6rV+IP0VJi89sMMeYhrqUUE42krS9XvgZOr2WLUHx
	7wnwQybmit639DF9Jdi3dU3mL6O08CU/UK+5z7H9lhr3W7qEbAOjEuDBnYl/sZw==
X-Received: by 2002:a17:90b:5350:b0:37f:be6c:f3f2 with SMTP id 98e67ed59e1d1-38f29399845mr6819950a91.2.1785126248497;
        Sun, 26 Jul 2026 21:24:08 -0700 (PDT)
Received: from ziepe.ca ([64.114.68.211])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f041b8be9sm4471929a91.14.2026.07.26.21.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 21:24:08 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1woCsf-0002Mt-Ls;
	Mon, 27 Jul 2026 01:23:57 -0300
Date: Mon, 27 Jul 2026 01:23:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
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
	stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 01/23] dma-direct: return struct page from
 dma_direct_alloc_from_pool()
Message-ID: <ambdXXcfgK+cxqxa@ziepe.ca>
References: <20260717180442.110954-2-aneesh.kumar@kernel.org>
 <20260721115456.GI110966@unreal>
 <yq5atsps77c5.fsf@kernel.org>
 <20260721142921.GN110966@unreal>
 <yq5ao6g0750v.fsf@kernel.org>
 <20260721153321.GO110966@unreal>
 <amEhEKQW0_HJ9cLN@ziepe.ca>
 <20260723075704.GC110966@unreal>
 <amTJY_CdE-uDgoGG@ziepe.ca>
 <20260726081753.GD12003@unreal>
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
In-Reply-To: <20260726081753.GD12003@unreal>

On Sun, Jul 26, 2026 at 11:17:53AM +0300, Leon Romanovsky wrote:

> Currently, the phys type universally describes memory and can be
> reliably translated into any required representation. It is the most
> fundamental type we have.

You cannot go from phys to page reliably unless you make assumptions
about the phys, that's the whole issue here. If the callchain expects
and intends to use a page it should really stay in a page and not take
a side trip to phys.

I agree it would help to have some helpers that were more phys based
for the callchains that want that since we are mixing two fairly
different activities in these functions..

But making phys the only output out of the pool isn't going to be an
improvement.

BTW how does a struct page even work for decrypted memory? You can't
actually use it that way right? If you try to access it then you'll
get the wrong IPA and it should explode?

Maybe we should be blocking the struct page path entirely for CC
shared?

Jason

