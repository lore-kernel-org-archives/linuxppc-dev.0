Return-Path: <linuxppc-dev+bounces-24208-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E361C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 12:25:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzz5x3RhMz2y7W;
	Tue, 14 Jul 2026 22:25:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::731"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784031909;
	cv=none; b=bs9h9d0FYzCV1uiHvrHDZ0728DcjbGYc4P2XUOmjY+M7DSSVRvTHQF03AYYW6YhnWs3/5GSz6aqLO99Gz4MkB5g2CN6G6tBH6lcaZ/MW4n4SPp7Gn60CtK0xKLjb1fhmzB5kF2HyMA2nqfZX5gPKRQ+8R88gE4fvVwLHBvXDCX/v1W4WijiOCK61TzLR5VyUWSHkJYEPvA2jUsWzP5wA2a8NteZ8WRzQmz6fRkXKyQCV4gHzuhx6p3nfYTnyWKUqoevpO4wrHbDvvmSbWBjLylZ1ErjwmkFABqWH82ZEj/Y0raqWaiQ9LdGo67Fez/bYK13bkn9t1YaqMt5oRdEVGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784031909; c=relaxed/relaxed;
	bh=NW2Ta6E1fh/Eyc2M2Ag3HwLKZzUCdETSNuP1MsMtNOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmMdF9NuYq5DAWacJjzKhqsZ3XopPdC8ve/Fz6ofUTjpjc3lJOxf6rKUo22hjBVkZ9cY4RWOvWuVJhtX0KEmE+O3DxCVh1H0y0W58Kk2djpH11TYQ1H+oPhMnrrDT46pDyTT8c9VKf70a+rdVWM/IIIi8bx77SG7lxIIXWscCf1XGWQE1lEZGV7V7nWBOUDFI2soXbsaXXKBSe3ruKsrKXZCBnIRWAxdDuwNqhV5yNoN2FOyJU7JAzch2klwrOZi5xORU5U5lTe93yPi+KMjheJcA74ScNb+yOwWGpQaN5eG3VQbXKPk7qpSS/l/RhUXBPXIyKFIHgqdnsVMXhXGOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=NFakNNO2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::731; helo=mail-qk1-x731.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=NFakNNO2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::731; helo=mail-qk1-x731.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzz5w4l6Kz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 22:25:08 +1000 (AEST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-92e50c5d14cso257071585a.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784031906; x=1784636706; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NW2Ta6E1fh/Eyc2M2Ag3HwLKZzUCdETSNuP1MsMtNOc=;
        b=NFakNNO2sIc0ynkRD08KPwv8jQtSOuuZiqj1+TNcQMdRxhM72Ek+8MkiHlWgb/Ign5
         03MVjoezX/ry3Q/Uj8aFXGGxAoV5uM5+XN1/SySaZgm1DsciT6MoKaRcIsSUGrBjQ/sz
         1pSdMxGg1wRbl7Lq6Mw2MvdVerV+gPiZY5tZR+8lk7Tc7uBn3nDXpxG1hzyngUdSC9A3
         WDOX3bX7N9rkPWExlMEO4NjH7dIM10cEre49tqDr0lxKPAv8Oo126YXNb2vOFZgVg6zL
         z/CpFxaVv22U8J5Hj+1UomDEi0j3V5YRHM9/DD2co/5uBFDL+L7DoXHVvv97fAhDdqDF
         HqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784031906; x=1784636706;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NW2Ta6E1fh/Eyc2M2Ag3HwLKZzUCdETSNuP1MsMtNOc=;
        b=FTl8dVJ4kPLtNQPc66q0hie+a/mp6pfjNgaiiFf5XSS8XtH4pGQUulKRduPyTrDUrE
         gd40k1phlqIQ6SanmDB4oZSBp6GOvh1Xxie/BQjkwan5pbjK6ngMl9j4EMnUXWtf3qEn
         NXSVPRwdYGJYHfAhlfTTgGn2wQESJ0+H2G108ARG405cE/pxEeBqlpJkzBb5s46Y0b9S
         I4LfWj559L29CUOsuNw5Bw0BrnOCSBOEqxG7HHbMJpXOzaYWkoYzE9kThmV/+5F8H7vj
         j3GWQg8yWf4/D+KoMb1GoCttM0EBnbNqkjklRI8hfh+bO5pk/Kfb7xKGA/8OaMxE+k7U
         8Dng==
X-Forwarded-Encrypted: i=1; AHgh+Rq79mhaoowpq0UCileBsihSB/swoUMKAzm4MBUvaSpH+W69rRr03apKQkl0dLt1oXvnt03L8EYV9sO6jqs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxY9ivGRJoDBtffopf7U5pGHAUVKisrKo7/yIbknqLoTEMiYTW8
	l3LBJU3tn9ipBlGQ10G/yOEJwG4bjNk1ly60uCk/+rqnd6hqH+6AcRlHyFkW45Hn8vI=
X-Gm-Gg: AfdE7cmMDKGlYkr128h6DUZrAvw7wWh76uP8SaSMXuJU3S2yGuFBbC47ebV82d/UhqH
	grulHEH0HhXtjOl+KNZ81Q12aJh+fbBz1QxILwgtu5n2jm5Asai24kZ2hrT/HghU4qARugACLmk
	t7ajAuXaJF0696ewE4CHnVZmIjCju46PoL9le+OwPrjZzgurJV3A6MSDUVeGS0sxqYN3eCY620x
	XNjLLzVFUqfWixJ/4tlcPxMGzxK+huMjehAKRyPP7RdGAxP23e8yYCVTuSGivWITd1L8mnq6Jfq
	QK8x/DdAfuxTuih4/GZQ18Efc4qOJODDcZaTYR6d+IWMBjy8FXk0WKrjK5mJoY2K7smgkOo8oUm
	dxxnyrUPQ2P3nyDOOS1NNPm0H7mXbtRIlv1qSUt4CnKvwV86UPFmRQ0FV0SYzQ3zbTKZa2NM=
X-Received: by 2002:a05:620a:261b:b0:92e:c118:18d9 with SMTP id af79cd13be357-93083dc8f4fmr281429185a.80.1784031906057;
        Tue, 14 Jul 2026 05:25:06 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4a0a6sm1474337885a.8.2026.07.14.05.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:25:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjcC8-0000000FRl8-3aT6;
	Tue, 14 Jul 2026 09:25:04 -0300
Date: Tue, 14 Jul 2026 09:25:04 -0300
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
Message-ID: <20260714122504.GG3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-12-aneesh.kumar@kernel.org>
 <20260713175616.GJ3133966@ziepe.ca>
 <yq5atsq2md64.fsf@kernel.org>
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
In-Reply-To: <yq5atsq2md64.fsf@kernel.org>

On Tue, Jul 14, 2026 at 09:32:27AM +0530, Aneesh Kumar K.V wrote:

> If we want to warn about such failures, we should add the warning
> consistently across the code. We may also want to handle decrypt
> failures by encrypting the page again to avoid leaking it.
> 
> I will work on that as a tree-wide change in a separate patch.

IMHO the WARN should be inside set_memory_encrypted(), and maybe it
should be a BUG_ON...

"free" functions shouldn't fail, and returning the memory back to
normal is a "free" operation.

Jason

