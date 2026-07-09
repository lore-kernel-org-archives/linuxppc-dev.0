Return-Path: <linuxppc-dev+bounces-23951-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2BBC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 18:13:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx34R0npRz2xll;
	Fri, 10 Jul 2026 04:13:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::82c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783620823;
	cv=none; b=TLr8o09YMWC6uRnU/JkAxPtpjOoIDt+wTKBaJIFcZCYPy3f5lQvk/Rvnh89RDFwtdTv3B4//gOnsGyV47Ue5pmEsVnK5JBIXAYcsdOZ3uXf8bbLcgiR+Ie7KD5Dj5t/j5L/7NunnLJb5ZNbs65hzShqKFFgmZmA4iod6wx7P1jo53TUCDPcr+G3I3lgIZYPehuPIBMHw5hMqtKGYJUK87U/MyikdBSBYn7xt3kYVYilQHKEHFb48GI+qWnL0DBRXzZZN7TWLTAbwDsf/3ZTpgBCiQ+11LUHNxdMhXIaO/ua/ezG5tC+xWEqH+nSBFA4pSr/T+8qVTTQfEzEc00hd4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783620823; c=relaxed/relaxed;
	bh=cHkQmsdB2OewXXEQfHxageXwJQg6EnEw6Gurdq9kErI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kr8/F+gUUWu0aeHguZJJY+TqkOnSFXkG8tF3NIIxjDlkJRsPifPYsxvMzXykgp/tK6oA7diAUqmPlS9oJeu7Vw6koG/obzYY/WyTg2OCjW06c3ssJquXEEzednbfROmuHqYnzfmrZVqiwtHx37ayGohie1+h2R3VR34i2wALlQlN5IPSHB1f4muPs3axAsTwzo9j8y7Cw3RBGEkJoE2On0pQn8Qvx6/LMBLWqLR4WUWE0uXP4MOuisDg59jBWq3bjR4hEUe6Bvp9XAleLBmBb37OGEKc0HV6/lrGja7qXnybXwGgmDbYy49qI9ClyzVA2Xt+kSpPkFhlbRUnWiWOvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=GR3eFHHW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=GR3eFHHW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx34N72Wyz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 04:13:40 +1000 (AEST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-51c167c58f2so611871cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 11:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783620817; x=1784225617; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cHkQmsdB2OewXXEQfHxageXwJQg6EnEw6Gurdq9kErI=;
        b=GR3eFHHW0w5pewL6RMQvflz8Jl5eBHF/Fo89ocPogyB+1LZBB+3NcS+nuVEDgxIJVJ
         eQLPsTpWfNnzyH5QJ3ce/CX4Vo5+KK8YyfQji44pF86JUk+v+1njPv9mHdk+q4qo+LOv
         B8kAZyIHhXjlo2CYz3K+Zebu9/vmsAs2bEY4MzDIQmdzVFOfa+FaEHe9PJWALvscen3h
         P86gEDweO1zB4elTJnFMbZwW41r3eeBeMFGKzlCv8yFEnpIE1jziSNOvpznoRJJcEtMH
         trrnePAhAIFxdlgZXshHKEtHkqjRnvDoKOh4KtcKoiy02eb/eswDyVV5YF5fd2HB+tfy
         BJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783620817; x=1784225617;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cHkQmsdB2OewXXEQfHxageXwJQg6EnEw6Gurdq9kErI=;
        b=pz31y0B0wpOezWyUQrkeBjdlZeGXkUkrvJiktvoTp2SILDJ1IDGFLY5sxcTJb/s/bH
         jpTayh7fD4YY2yGLjo3opRx2iCPT/TrENCtnSnhVR/NJqpdSBd7n1O6uLP1zkIz8PYpU
         SBUxxNyI+MoDgPqm4/oTGTOcscu0Db67G3r54eTTrGk8nBKmBDkGiC/SOAo9x50knvtZ
         ryyif6NBU/kEydGPIiYk/o4xSIOQdQn+fJ26P6qjuCpKFw9kb8hjdriRcJkwXZNy0RRK
         TMY84i3HTKqrZI/GyRejdHixAgaMj287JvOdkUfbm1eo16igUwezZJZoSPojvg2+F6Ns
         enZA==
X-Forwarded-Encrypted: i=1; AHgh+RqRoJ7TAf9gB+8DhYHtx9KfzCOHGMCqIkW2dMx8YStrg+17JqyZTAo3Blz+ZQzc2RJmaynNX2CXz6VDXvQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwfZqMmTpg9hSCtmRrodj/hwEpLb5jo3tgk+kDvc4t38gtEiIcH
	vSzkUW9ZQC8LxwMrVlWmkOhFbmGc8ElOebdk4A8qj5WS6H9U9UtvcjatPcCBFca8388=
X-Gm-Gg: AfdE7cnr4tYJuUcUTYFSlLko7lSTI6l061+t4e+cBIcUOtztZpgtO5/sRoJ1/A0mZSa
	R/m98+OqVf8zS7AiEqabYVbC3LSdR0E4lS+cGADUV4Zht2QCBR+mOJ/cM0cOXUknD7XjZJJDCaJ
	MbeBxQbOZjqb8KrYIAdTHggG146HG6A9BC2J4o9WNhKgC3EEVCXe/AvX2KcGrwR/9WkHvmqIaaD
	nKqscuEiDxT4OdRQEb5edSHx/xlzxyvADT9SOB2DHBgg1UE4C2jUhMF1AmkomipZ5bxEWlBrJTj
	55CIVNOuIDQmfgUUUDxlHevPPWBOFplCWJq903pDWjR9V331KXlWINiv+HmqgCO/iFpE8BiIW5W
	t2at1MA7bq2vC3DOr1vPKGCINY7Pg2owEpbTOwBUX6Zcj92LEoACQJtn/VO+T
X-Received: by 2002:ac8:690c:0:b0:51c:43d8:8604 with SMTP id d75a77b69052e-51c8b3b4eb1mr92527611cf.51.1783620817365;
        Thu, 09 Jul 2026 11:13:37 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd82ea9casm22695666d6.42.2026.07.09.11.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:13:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1whtFg-00000005Kqr-0IQc;
	Thu, 09 Jul 2026 15:13:36 -0300
Date: Thu, 9 Jul 2026 15:13:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
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
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Message-ID: <20260709181336.GM118978@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
 <ak42F240d-53QeFN@arm.com>
 <yq5apl0xgy89.fsf@kernel.org>
 <ak-CT3oanlDfgTy4@arm.com>
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
In-Reply-To: <ak-CT3oanlDfgTy4@arm.com>

On Thu, Jul 09, 2026 at 12:13:19PM +0100, Catalin Marinas wrote:
> > > For AMD/SME, on host with memory encryption we now end up setting the C
> > > bit for DMA_ATTR_MMIO. This is fine for RAM but not sure whether
> > > some other MMIO bus understands this attribute. Maybe we should stick to
> > > something like __phys_to_dma() for the !CC_SHARED && MMIO path. Or,
> > > since this is not universally defined, just use the old dma_addr = phys
> > > if MMIO and ignore any unlikely DMA offsets.
> > >
> > 
> > Considering for AMD/SME system an unencrypted dma addr is one without C
> > bit, will this be good?
> > 
> > 	/*
> > 	 * For host memory encryption and device requiring unencrypted DMA,
> > 	 * MMIO memory is treated as shared by default.
> > 	 */
> > 	if (attrs & DMA_ATTR_MMIO) {
> > 		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) || force_dma_unencrypted(dev))
> > 			attrs |= DMA_ATTR_CC_SHARED;
> > 	}
> 
> Yes, I think it does the trick, preserves the current semantics for AMD.
> I guess you could use a single 'if' for all checks (up to you).

Please don't change it, MMIO P2P is broken on CC systems today and it
should stay broken. Passing DMA_ATTR_MMIO with DMA_ATTR_CC_SHARED is
an error that we need to correct in the drivers not make work in the
core code.

Jason

 

