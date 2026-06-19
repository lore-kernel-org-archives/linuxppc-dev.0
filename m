Return-Path: <linuxppc-dev+bounces-22817-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EBACD98F2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 12:03:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghbpJ3YcYz2ykX;
	Fri, 19 Jun 2026 22:03:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::e2e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781870600;
	cv=none; b=JUQ0SApnBM1e3PczVQ6+mvDXrx4pnGLiK6D9F05cnmb5yI0qBXUucq60hoJTmn2eXW1AUwKGhd/T45z9J/WlmpF4L56s61JEbkJnRCYIeCxk1+B3FSIuBVRNtJM9VjNx5sH38bwjugDBru3Ecw5bfazLQjB08vbEXtZ5OiLLUDoimzU/SVfZ5ZEVJ0Iry1WilgddKUl6kZPAB1UQ4McehMShlm6unnLSTHqbNiwE6WDQflugl7jlIKFdcElIM9VNTuCy1FdohRr8JHyuZH/FVrHCyirJ7V/LlMKVe4c6b6bv7IWapB5WtanZClYtWzc5Rre5vnvGAZORA+TesgwjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781870600; c=relaxed/relaxed;
	bh=StlCUTUicQISJ/bWwbWkmSHhXapLgWFJJHXk0oHb5Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyTBy4T/YUqSPbayX/pzJ4qh3vJwmODwnbhEJwtpOaaTtoLTgIBfDPUy0+IwILCTBrYvvy3eHHDsiDPUoyTl/LEQ3l96h4rPYvhO1t9Gl3yHYAWPn/IYtoOK3olmLhjBBZxCAUnz/tCYpV71sDCHUmIa7hbambF2atoKFLMT7z8od0Nvy7t9AezSMQglNVRj3V1Zb71CAUhiSbnzw3yJ0xpegyJEbTFlN36WoL5BT/eylA7fGLymI6OdkmkQ+V1xZLGAv3iSt96vDNsprbC5I5lcncPjy5LvLRvvL4ArOQxT009aPNowA5IYK20953/+2RUYYMIuNFNe807DNvJWKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=XNmjmWmv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e2e; helo=mail-vs1-xe2e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=XNmjmWmv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::e2e; helo=mail-vs1-xe2e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghbpC4DC2z2ySW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 22:03:14 +1000 (AEST)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-7296071d19fso905757137.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 05:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781870592; x=1782475392; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=StlCUTUicQISJ/bWwbWkmSHhXapLgWFJJHXk0oHb5Ig=;
        b=XNmjmWmvne8qE2OgTLJFVCytHcUrSTkeDPxHvNNjUW1XCWLvMuvVjLeF8pyywGJI8y
         UQRAadviOi6YPR0lC0W9civou622einf0as4aTHe68iaDTVPd0M3Fu/nWV3oX+KuE0dL
         rU+AnLVnmUJS6jyBZRzvM+XAZGyXln+ptgZBPs1pUOUd4Pp//LAggWxmGC+ma0K8CXLv
         2sZEji3n8G3iC0ykgJsq0ys+1edxwNIHKoTSI6Y3mzicCoc4TDt4lwY/lPRrVsxyUXrM
         tWUZNdjSKidpeU71xpcVXz4DzM+YkL+pbITQcatiDMULL/KuH3iOCurp2+9cLs0w+VWf
         uhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781870592; x=1782475392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StlCUTUicQISJ/bWwbWkmSHhXapLgWFJJHXk0oHb5Ig=;
        b=YPIuAO4AO/oNi69Grve+iI55AEKpIOS+QE3ZZepEss0brYRMAea1Jk2pRQmcz1K2Bo
         hm+XNdO8MS7hOZPPTx6pOGnvt6jYZm/zPXjr6C+kIX1h6jATJZJHejoqe72lGCsInWtb
         Ji7rrKqOCf5Efy8AJsDJ40veOTc5bXBmQ4i0u5kBFa7qdXehRXB0xseXKHp1pZXiuqBd
         +ogE9FguV9/kppozlEq59kkc61IIVvN2tp54ZhcQHTyVEpYB31ZgHKTMQMLmoCH1JGXY
         G/rW4KPacvSdN6Si1H/t+SCakCi0SQYCsSCPzUk9oFFV2k24N20p7ufDBdNuy7qaPgAf
         9xTQ==
X-Forwarded-Encrypted: i=1; AFNElJ95UrAKqC/Ay61zZBCHZioQz3gUWcTctqVjoXGup/kZ1rcgNuHJAg/DFU36PyNJStXkW3L0VBcgE1gy7CM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxgzaqV/tr8bK0/1tRGMd7/owe9RMp9KBbKGN6uuAEpFKSym0cJ
	Q0GUuL74eotZ2HXeVd+Zps7xx0uxDXA+00uz7mjI9lSuPn/QsXEb8z0vObnnBNoslV8=
X-Gm-Gg: AfdE7ckTdL514lMqYC5F3gKoJCOcHpgp4//NEvG/o0neejUsnP5pcq0/si9pRFtOXZ+
	2xt30p21RJNxj4dslh2dfqCeQnDFQZj9+E2QrP2H42udJXqlh7sMR+fyQnOa2mcurSIElzpTqHW
	zzUOHZF9jgw+GQyybzhYPwyILl1Tpwt40krLsd/BYWO807vlF6k1BZEpS6iSjWc0tjZ2iRW6/2t
	f2sCjkWVYI/J+0qG0WIIip1hyIGKglabEdOiqiM0reppqFeAtgRZw+rV0jxcCEZywqiY/QPDwEU
	vmR2g7eITj0mIr5CUgABIz0eGyO28AvP4wIcXHwBh9jJw68YHt4PDRUuOqMb40FMgJuCGvFmD7J
	lTVtwDPAS/VbwfmpwKWSFnl41AQt8tLlMR8gnLuLcioqhwvRA61jKbYrYX7gBgfikAEgofSNhNj
	nLmRm0sOX3R7TJYig511T8oQwuSZruBFXmANjVJoXNEtUnL1NjzufFlLHMqnbMhGJ0OhSqs51XT
	29SXA==
X-Received: by 2002:a05:6102:c89:b0:729:213f:76ca with SMTP id ada2fe7eead31-72a20215eaamr1999509137.29.1781870591985;
        Fri, 19 Jun 2026 05:03:11 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a424f817sm215731985a.22.2026.06.19.05.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 05:03:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1waXwD-00000004SQK-4AfU;
	Fri, 19 Jun 2026 09:03:09 -0300
Date: Fri, 19 Jun 2026 09:03:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
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
Message-ID: <20260619120309.GI231643@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com>
 <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca>
 <d4ef9a9f-18d9-40e1-9d02-87aeb9cb6540@amd.com>
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
In-Reply-To: <d4ef9a9f-18d9-40e1-9d02-87aeb9cb6540@amd.com>

On Fri, Jun 19, 2026 at 12:05:45PM +1000, Alexey Kardashevskiy wrote:

> > > > > IMHO that's an AMD issue, not with the design of this series..
> > > > > 
> > > > > The series is right, a device that is !force_dma_decrypted() must be
> > > > > considerd to be a trusted device and we must never place any DMA
> > > > > mappings for a trusted device into shared memory.
> > > > 
> > > > swiotlb=force forces swiotlb, not decryption.
> > 
> > If force_dma_decrypted() == true then swiotlb must allocate from a
> > decrypted memory pool. It is right there in the name!
> > 
> > The hypervisor environment should *never* set force_dma_decrypted()
> > because all devices can access all hypervisor memory, up to their IOVA
> > limits.
> 
> True. But we do not have encrypted swiotlb pool today, right?

"encrypted" is just normal struct page memory, that's the default for
swiotlb.

I think it was a big mistake for the AMD SME stuff to overload the
decrypted/encrypted CC stuff which should mean shared/private in a
guest context to also mean things about physical memory encryption in
the host. It is really confusing.

The SME side is just a bad arch choice, the real world doesn't work
well if you set high address bits in your dma_addr_t. I think AMD
needs to use those restricted swiotlb pool where it allocates this
very special "SME Disabled" memory that will have a low
dma_addr_t. Then alloc and bouncing will get memory with a suitable
dma_addr_t. This has nothing to do with force_dma_unencrypted() which
is only a CC guest concept and nothing else in the OS should ever
touch decrypted memory.

> > And this is more insane logic. The right fix is to allocate the
> > swiotlb bounce from the *encrypted* pools when running on the
> > hypervisor which requires undoing this abuse of force_dma_decrypted().
> 
> +1.
> 
> But how does the kernel decide if it is this swiotlb pool or just
> some page which happens to be below the IOVA limit?

You mean in swiotlb_tbl_unmap_single() ? It checks the address against
the pool's range?

> swiotlb can be for bouncing (with all these dma_sync_single_for_cpu)
> or, if dev->dma_io_tlb_mem->for_alloc = true, for coherent
> allocation (no need in dma_sync_single_for_cpu).
> 
> I am looking for a way to set up my "sev-guest" device such as when

Whats a "sev-guest" device?

> dma_alloc_attrs(snp_dev->dev,...) happens, it allocates a page from
> the shared swiotlb pool (with no actual bouncing) and there is no
> obvious way to trick the DMA layer into doing that.

Why do you need this?

Jason

