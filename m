Return-Path: <linuxppc-dev+bounces-23228-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7915CC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 17:42:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqVpR4rcxz2yR5;
	Wed, 01 Jul 2026 03:42:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::829"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782841343;
	cv=none; b=gewFpuUmQU0xjAjdc8jyts2ZZhtotCEwTK2GX/jN5zwUtmfEHB5GeIfNc9y1SeMbWUChVpJv7+JdWIR8LelZf9zL8lOotkJmm8aB4mWWY8tP+R0dc/l1/O5CvCoIaNAxTBBABZAbaIb6ZGnPewAsiy1VmHdsrIrUQWFsRWm2GLZ41P7xpmHR3M01K/jO7YdIBBGJEf+UhQanA3m1UANW9SWoKzafXWdyKq+HtDDidhf5Ng0ZgxwyE2Hd0EUMDJq0nCJHisEs1XYA4QT2ldg48LY9TQOKyyVODjoO37RvILK0Qhv4RdZ2edwBBUzzJHsyovPnyWAV6Y4h5/UQXtNTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782841343; c=relaxed/relaxed;
	bh=zClWOUjkDWFvMHOUBkD6PB+uKy7SGdgOfe7bM5K85sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaQNRfOrKmorm1w9FC7382Aqkv5yjswZbeAlPobFSe2kusZj1JWkeASJ3Ne5buN1yD2D2L3F6fBIiCVwm8Fpo5sMWwNEmf5RQODuip/+XXDjpvrSW3fPWnKZxXY8UhvlqahqczCRF/+iBFdUXKlJASjFeMW1vIzIpe5dd2/NAr6+CSjPIbPBrAKSzPyIZIHeWlqfNSo86EEJ64NYLtYNHkqjoepz0breuCiHEyzx2vqFszyzLlJdnzs1In8PNDSTMkAFSts/lNALjTU+UovoBAzEQB+eSBYWF1y1SLrgpFQYN36p1TQYBpqCdyTV8AF6nN1FQU7EiMv84L1pTMnYFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hBF7BwFD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::829; helo=mail-qt1-x829.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hBF7BwFD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::829; helo=mail-qt1-x829.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqVpQ2PD1z2xq0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 03:42:21 +1000 (AEST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-51c19f91d7dso5352791cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 10:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1782841338; x=1783446138; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zClWOUjkDWFvMHOUBkD6PB+uKy7SGdgOfe7bM5K85sk=;
        b=hBF7BwFDfOhXeJy4uuufiEcsXq3kz6btQpkaLAPdotgTSJaWWRiuRcsveiVGUQGeq2
         S4Z27tnts1QIJMUE8yiAVTtJiz2B0Fx9N06poJW6OegkMavkpLxc+xGWatrX6mdImb8D
         X6gfRaYNUUpRMJKgD3VkC372/c6C1RUReinoCxZqnhFVgJRWWAMsrC9Vy5kNjsg80GvU
         N519tYuQO8AEugeXeljDzjjlviGkDCJH1ZQT+lo5Omn6jhbji4989Q+aBFBUu/SA9teh
         kbx2Lumj4FD7FgIUjRm0BgRyh9lp0Mi0agPUzU0/hQ2vOjkq7XrU2DwPU+zhVzzti9B/
         GXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782841338; x=1783446138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zClWOUjkDWFvMHOUBkD6PB+uKy7SGdgOfe7bM5K85sk=;
        b=OABQSzp4VwAsARJPT2PAd8ba6vhi+fgRx++ahK5qWnecIkVzlWkV5Xz6LswExW/no/
         bnROIxUJWLQcn8WQbg1ybvQ9TzJ5YtyYZK3xuu8SM5XoDkcGWoNLkMBn4yrJlf3YE7S+
         tzuUSaDK2sc7dYSDo84n9dx5MgfaZ1Yrx82fgXG+0Y9i0nbW6in8m7wCOJE249ocnibi
         mJWFZkymd20JZapo6OAUpIHP0QEMzYtDWAV7unqy6uMZoSk2IQbBLemnMlITHIxcyeqo
         +SABVOwPArrIpEfDblZcIuZqSF3noEtCV9eesiLnNQDWNqLZV+IAfBS1jXQmWGpqL1ux
         8Qmg==
X-Forwarded-Encrypted: i=1; AFNElJ/DkvSeUz8kRGwvsyb3xxsw9LzRT7FZ1tuowtmvt22MFOZhTZ4c/K/U6yLOF9tnDnnh5yeitEGsj6Bg5uo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxWEMMorFudtzO0ZraJbqg72Y9VrDBnInT+gefce3YEtJ9tKWBN
	4ry7pI1kn2xzvB80PCwDg6dQbHFRxuDCeFyZ/yMjuaMzNgL3Gm/FxBQqxIgrNA7xH8E=
X-Gm-Gg: AfdE7cnpN4KvYOXqbeDMrIVvp09kQnT4t5J4TfoxECg0wXOinDzpcDdQtZjLBkg7P4E
	9uzFDwvv0LhAPvbXbyJ9pT3ZlQHSBZfY/y7tW3d/7AqXyRJ5VZM5P5gXjH27s5xr91Ygt372f8o
	urM8xS9Xhi2MR4qBJZhmuq6tXOSOWINpRHMHCJ8Z7etrY5dSRQfAQDiMSGYJLs1HB8x7DUD41IT
	EBDeo4NheNzE/Sp6kgAZuknaOYq9GGqnLhdrwP77dKBMXZ588RnzoXzz3JL70/4t+ADPxmvU6aR
	oh+iw97OA/1xiGEFZOlyD5rIgpsH7+mL5HQsbSvLxCz6bJKlsmR25AXfzAPMr/f4UbHkBhBgt11
	Ri27YoI6EVPycdo8vzbsQoEYyZB4EKrdbKiFYKgwbWb3bGGBAiemINQwN0IQaeMtKgQhQOkvF3b
	4JA9xGrzEwUa7ziJHA+F4wlKvXp4lsQNuVruk7H8brS5jmGudygBhqCQ08fArN2TPwCZc=
X-Received: by 2002:ac8:59d4:0:b0:51a:8c99:1f14 with SMTP id d75a77b69052e-51c108ca48fmr58918701cf.67.1782841337969;
        Tue, 30 Jun 2026 10:42:17 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c1080d4dcsm22942861cf.5.2026.06.30.10.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:42:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wecTQ-00000002FOX-35V1;
	Tue, 30 Jun 2026 14:42:16 -0300
Date: Tue, 30 Jun 2026 14:42:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <20260630174216.GK7525@ziepe.ca>
References: <aigYbK12D8uKQvJF@arm.com>
 <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca>
 <yq5ao6h6enhm.fsf@kernel.org>
 <20260619122148.GL231643@ziepe.ca>
 <yq5aldcaejos.fsf@kernel.org>
 <20260619140616.GB1068655@ziepe.ca>
 <yq5ao6gtoncp.fsf@kernel.org>
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
In-Reply-To: <yq5ao6gtoncp.fsf@kernel.org>

On Mon, Jun 29, 2026 at 12:16:30PM +0530, Aneesh Kumar K.V wrote:
> >> Thinking about this more, I guess we should mark the swiotlb as
> >> cc_shared only with  CC_ATTR_GUEST_MEM_ENCRYPT instead of
> >> CC_ATTR_MEM_ENCRYPT as we have below.
> >
> > The name cc_shared should be used for GUEST scenarios only.
> >
> > I guess there is some merit in keeping swiotlb using "decrypted" to
> > mean it usinig pgprot_decrypted and set_memory_decyped() which AMD
> > gives meaning to on both host and guest.
> 
> Are you suggesting to change the struct io_tlb_mem::cc_shared back to
> struct io_tlb_mem::unencrypted?. 

Yes

> > IDK what AMD should do on the host by default. I guess it should setup
> > a swiotlb pool of low dma addrs "unencrypted", but not "cc_shared"?
> >
> 
> If by low DMA address you mean using an address with the C-bit
> cleared. 

Yes

> The current code already does this and uses the swiotlb pool correctly
> on SME.

Well, through the force_dma_unencrypted() hack...

> The challenge arises when we want to force SWIOTLB
> bouncing even for devices that can handle encrypted DMA addresses (more
> on that below). For such a config force_dma_uencrypted(dev) will return
> false and swiotlb will be marked cc_shared/decrypted = true; This trip
> the new check we added.

Yes, because cc_shared (guest) and unencrypted (host) are very
different things and we've mixed them:

> 	if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))

I'm aruging force_dma_unencrypted should mean cc_shared and be
guest_only, but the SME hack breaks this.

> We can also do
> 
> 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> 		/* swiotlb pool is incorrect for this device */
> 		if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
> 			return (phys_addr_t)DMA_MAPPING_ERROR;
> 
> 		/* Force attrs to match the kind of memory in the pool */
> 		if (mem->cc_shared)
> 			*attrs |= DMA_ATTR_CC_SHARED;
> 		else
> 			*attrs &= ~DMA_ATTR_CC_SHARED;
> 	} else {
> 		/*
> 		 * Host memory encryption where device requires an
> 		 * unencrypted dma_addr_t due to dma mask limit
>     		 */
> 		if (force_dma_unencrypted(dev))
> 			*attrs |= DMA_ATTR_CC_SHARED;
> 		else
> 			*attrs &= ~DMA_ATTR_CC_SHARED;
> 	}

If we do this I would like to split the force_dma_.. functions into
guest and host, ie force_dma_cc_shared() and force_host_decrypted()

To make it clear there are two very different things here.

> Here I see value in having DMA_ATTR_UNENCRYPTED. The question is do we
> need to split this into two flags and introduce the resulting code
> duplication.

The external flag name should be DMA_ATTR_CC_SHARED and only used on
CC guest. Internally that turns into using set_memory_decrypted()
which works on guest and host for AMD. I don't know how to make the
host only case clearer and still keep the code efficient..

> > The dma api has to detect, after the driver sets the dma limit, that
> > none of system memory is usable when:
> >  - The direct path is being used
> >  - phys to dma for 0 is outside the dma limit
> >
> > Then it should assume the arch has setup a swiotlb pool for it to use
> > to fix the high memory problem.
> >
> > Similar hackery would be needed in the dma alloc path to know that
> > decrypted can be used to fix the high memory problem like for GUEST.
> >
> > I guess some 'dev_cannot_reach_memory(dev)' sort of test in a
> > few key places? Setup with a static branch to be a nop on everything
> > but AMD, compiled out on every other arch.
> >
> 
> If we are not able to reach the memory because of the memory encryption
> bit, then isn't dev_cannot_reach_memory(dev) the same as
> force_dma_unencrypted(dev)? If so, that is how it is already done.

Sort of yes, but it is properly named to its purpose and not confused
with what should be a guest-only function.

> x86/dma: Disable forced SWIOTLB bouncing for SME IOMMU passthrough

Maybe as a crutch to get this series merged..

Jason

