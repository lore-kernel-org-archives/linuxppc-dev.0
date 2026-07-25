Return-Path: <linuxppc-dev+bounces-24821-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637E2C531D0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2026 14:32:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6nQ517pBz2yYY;
	Sun, 26 Jul 2026 00:32:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::e31"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784989965;
	cv=none; b=HU9DJh1HEXkJRm3RPC2t6lsb6Ig/Io14oIjSSwiGOUjIAK74o/EKEku6pRX3oooqcfQzFrZVbKN+BhAlYCA0HA9qVt+bDAO3aCLRqve6q6EB30qnuRSuym+f8K22feUzBMfJpOJLcLcnehOZTvqJtVWoh8ymvP5rQiidQ+Cfr50MpoQlWijFxinFcrFwl7EUsHhAIgt5zScidGIb1jh8AVYAf8CO6hTvoW2wQolnezrqKQzwPHA7pPPGdRWZiSUdOkJlbKbipAl8zWmSeqbG074ARIQM9A10FqyV964qh/45HJzicNUsUzH9vzppuIIyApHPo0jfMAD/naYPyA4F/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784989965; c=relaxed/relaxed;
	bh=MDjgTbE6npl3ZujjcO5BO0pJ+G7Th/Ah/Rj5MPFfgH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUz0jujg8xmicLaqyymJnbJ2eBQrG9wZRFktubyF4XAeb5jyNU5qCypnFZnvysWqvG8/ibqsSJlZ1V1wE7KcRFC3JJbFoblh2b09pvabPm9tISft0ZQx6YH+SSRW0NL3M6dLp5lnpFgBxD2veOdNc2ySoInlyhLPr7/p7UuUsda5Ksrsoc+JEkGgZIhF1GeGICRIiQB9BGj0/aXDm5l4B4Qj0Uvrsls1rbAuJAU03tfk6t9X7acGHn3wmu1IABnjWMrGEjCU+iu9G2HBmsEONi6qqkyfjKfuFhfDTq+mQMfbxPyf/JX6LttZD9VId3fPdoYZ4vUeXAi+FIdGcrJvRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=arxB0pu5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e31; helo=mail-vs1-xe31.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=arxB0pu5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::e31; helo=mail-vs1-xe31.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6nQ35YX8z2ySJ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2026 00:32:42 +1000 (AEST)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-7473e927969so360044137.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 07:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784989958; x=1785594758; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MDjgTbE6npl3ZujjcO5BO0pJ+G7Th/Ah/Rj5MPFfgH0=;
        b=arxB0pu5wd7pgK2OL5IVbWQzx/+PhW2zlLxeL7mthk5qr3nI8otQtNCCLa1rS8xvUl
         imqpHqS46sS5n/e7io7qd3eE4RXysmkh+VOv2XdGQmjg/tQ4dIyAAhQUD15HKkmfNDwF
         tN2FR92k+2Lvw2bUltbHgjyh3CEGForRla0+WtE7+C0PSysYhy3I3M3Vih77gH/zxgod
         nqzegQGm7q5xnTUqwBqbmelaosn7LQ02Nbjv/3B3Jh1EqoXBN79hkNu43gkCHiQWlaeY
         Cp26FMHl/6y1SOvuqy8M5w9KDVktVS1Zbs7GFBCk+OW8d9RjfUagxhpi5c55T5PPhNMa
         wSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784989958; x=1785594758;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MDjgTbE6npl3ZujjcO5BO0pJ+G7Th/Ah/Rj5MPFfgH0=;
        b=c08FhEKABaZE2BZpM2lOnOslhqoXVDcp7vG+9pYULMRClI1ZOhPJmcLXGE3K9dlO70
         0aAUDbg2YUlI5lhB1DVHJnvvajbBk1KQG2xTCQ3y4F0iTKRp83yEZ+ZclbVQBisg+T7Z
         ccNO5MS0Cq6LVq0y7VN/QePELYXTQN6YJoaaBgQ/LNpQ47DmADSmnoEbplv/YS/Ws2FC
         tJ1wrTwTd1m1fHzjweRiVhwuVRTsIdQDlHyBEhA81O8UScdoVoUAi4JXS3VN5OULC6Rz
         c5p5rrWvf/+QObhcWk0Njn1Q5yy+UOr0I6LLN+7/dgqWUeTl9NGSsvxjsFguYLfDnZSM
         tqJg==
X-Forwarded-Encrypted: i=1; AHgh+Rq044I/HrMklruuN9+oefFyAdUGG7jIDdcceThtX+pnPmrUBkL4QjPqGRcj5UaAn1wV0URprK2I6jWeH70=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzHAjOAN3oMxfOfPvgBbqXgblRlqpu0P7nDMAVCMl23uKKeM2cW
	PmfMIb5zYy+ZpBADxCUYd4Cw11tYaIS86cn2j9dJRQ0hgZTzf5K4ELIe/mqQczhQAbY=
X-Gm-Gg: AR+sD12NKp5HBHf+Mzf9+Xg4ZQP2UwZb3HC+4Gx6sPz/fXeG4M4NDZNBb1bTMLF/zaz
	zxqSURsS1bnHXrWEpn+RVOZ6H9skc0CoNSE9cKiUyXYFv1MD/50fHl2KPpdogrvOUfXkgy+58wC
	oxEFDwxsRa9mPjK3fSXIP4I81zIQzn79Ew2txhu4bMuO2zz3Wre9E686P99GQg4u5fDqRkIkrVN
	lAGW4S6skVbYM96vkV4aI11ygcrCyz0oabkS+0HfSagEK6XPiWmS+vGQUTX0JwBiv5sSHW0syfG
	CUKXNwLyr/98RPzE8/Q3BbXynkcmgxj+lA7UxYhtIvIpwW+pKO/yZgG63sTA+yhjnPc4jAlGWJL
	51TjLU5i6euDvah+rcgsjaPDU/mHMim2e+XWz7T2dlXjgGaCIO1JWC+SpHRT0jDI=
X-Received: by 2002:a05:6102:5794:b0:74a:b5e3:e96f with SMTP id ada2fe7eead31-7503e26761cmr1503853137.7.1784989958188;
        Sat, 25 Jul 2026 07:32:38 -0700 (PDT)
Received: from ziepe.ca ([12.18.163.234])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-750362e67cfsm1546647137.8.2026.07.25.07.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 07:32:37 -0700 (PDT)
Received: from jgg by NV-9X0Z6D3.localdomain with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wndQX-000000000hB-3EP5;
	Sat, 25 Jul 2026 11:32:33 -0300
Date: Sat, 25 Jul 2026 11:32:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
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
Subject: Re: [PATCH v8 00/23] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
Message-ID: <amTJAXNy9fGFrve6@ziepe.ca>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260721124056.GK110966@unreal>
 <amEglRH3u6UFFnIQ@ziepe.ca>
 <20260723075108.GB110966@unreal>
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
In-Reply-To: <20260723075108.GB110966@unreal>

On Thu, Jul 23, 2026 at 10:51:08AM +0300, Leon Romanovsky wrote:
> On Wed, Jul 22, 2026 at 04:57:09PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jul 21, 2026 at 03:40:56PM +0300, Leon Romanovsky wrote:
> > 
> > > Why don't we continue the effort to remove "struct page" entirely
> > > from the DMA API internals?
> > > 
> > > IMHO, everything not exposed to DMA API users should use
> > > phys_addr_t, including the DMA address pool.
> > 
> > The alloc interfaces return a struct page, that is why this stuff is
> > organized like this. Look at dma_alloc_pages()
> 
> And I didn't say that we should change dma_alloc_pages(). It is external
> API, which needs to be struct *page. I'm talking about internals.
> 
> Even dma_alloc_pages() flow shows how convoluted and non-uniform
> the code underneath which performs translations all the time.

Yeah, but I don't really want to go from phys/virt to page, I'd rather
see the other direction that is easier to reason about

Maybe some small wrapper that returned phys or whatever would clean
this up

Jason

