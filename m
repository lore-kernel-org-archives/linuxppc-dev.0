Return-Path: <linuxppc-dev+bounces-24715-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218D8C531CB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 07:51:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5Nbx2FRzz2yFg;
	Thu, 23 Jul 2026 17:51:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784793085;
	cv=none; b=O+qyNF+wuqONAuRUvNfdwr04ZZLBekFuUnb5XT1DO8+WDxuYlqmzQAFkQC5N0zs87rPavfhC3C0Q9otI+DH3519PDp6QIPDVR4nQOGGEVEPhV8eOjlxpblybT1Vjn3k0f7r+fljlJuKUn8JKGs3jPvQt4YW/EliMyX0q6owgqcW6q+0Jjnd+dkHbL5ZobOWdzr/sJEw5X9mFSamyClgIcAhn1OjmBnjGvnVlXXOV8nTVPda14GnCsuMa8yPpy5oay23xFcbz2TWeiibuUm+I5zp8L54q0SI3nflp3NaejxPxyKVJ99+nYFh4HXtc5UPFheNcJf+kB+uXKvMUTZdVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784793085; c=relaxed/relaxed;
	bh=oS1NMvx865gW2UoErMylGfTUK0dtoB1K+HlWaCkJDOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFsfkft0H4KRbniYmf/ERG6djy0OIEjvJanE5+TOlXLIcpzs2mTBcIXyDL4IcwwaFB0XcMJavZNM498qk8nVbEZRsPlHYlHCA6O0/HhHMSEL08ltvXk2dFgH14ZSyhkBS1AAmhpJHFYnEkIYuHGxA7lZOsYn+BqwtqQ49GNH0eGF+v8fDL6qDCJ1AM+SAUg/8XW5q8ZMUswiiZhzRK8TYY9rnmcJ14YC4C1kd2PjxtZ0uesiURFb8QY/KY/572BbT9CK1GL7MPnoojL5c/tiitzZINz4YXKQZTj6z2vDv0Gf+uyhkIhPvzNBwXb5CtDRTM2QDnEwlSPclJT1sBto7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5yVtX07; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5yVtX07;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5Nbw2Myhz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 17:51:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 587A360A6C;
	Thu, 23 Jul 2026 07:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBAF1F000E9;
	Thu, 23 Jul 2026 07:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784793081;
	bh=oS1NMvx865gW2UoErMylGfTUK0dtoB1K+HlWaCkJDOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C5yVtX07ZkUJj3b2b+kYtfuR23XpTFRkdHRdENTWAARDLYmTf2IRILt6XAP3lcQ3i
	 guxWOSpqvbZxIkPudGanZc9oRLKmaWg7jWE5nWdWWffLISp3ZQ+ad4Ihoe02/FYjI0
	 zawcqNvZ4YMD98rRRw9KmxbnYTZO2a2pevFxO+lic7WvlenUPBRb/qjJSo021Hq+fK
	 RnJUL29qw9dIMmgyNVWejeSnfUWslCr7nlHO+wb/2jqEuc0/cAk14jRWF5Uc2ySZeT
	 fSQ5DwAeoStwg7yjuT2gjGQyNTVPQV9uRZe39mcHkbKAqEo5c/lhrEDQ+DHZjlr32v
	 nL9nveFp0YtMA==
Date: Thu, 23 Jul 2026 10:51:08 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <20260723075108.GB110966@unreal>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260721124056.GK110966@unreal>
 <amEglRH3u6UFFnIQ@ziepe.ca>
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
In-Reply-To: <amEglRH3u6UFFnIQ@ziepe.ca>

On Wed, Jul 22, 2026 at 04:57:09PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 21, 2026 at 03:40:56PM +0300, Leon Romanovsky wrote:
> 
> > Why don't we continue the effort to remove "struct page" entirely
> > from the DMA API internals?
> > 
> > IMHO, everything not exposed to DMA API users should use
> > phys_addr_t, including the DMA address pool.
> 
> The alloc interfaces return a struct page, that is why this stuff is
> organized like this. Look at dma_alloc_pages()

And I didn't say that we should change dma_alloc_pages(). It is external
API, which needs to be struct *page. I'm talking about internals.

Even dma_alloc_pages() flow shows how convoluted and non-uniform
the code underneath which performs translations all the time.

dma_alloc_pages()
	->  __dma_alloc_pages()
		-> dma_direct_alloc_pages()
....
	ret = page_address(page);             <--- here we need virt address
	if (dma_set_decrypted(dev, ret, size))
		goto out_leak_pages;
	memset(ret, 0, size);
	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page)); <- and here we need phys address
	return page;

So my point is that internal flows should not require struct page
and should not depend on it.

> 
> There is also an API that forms a scatterlist that has to be struct
> page as well
> 
> Jason
> 

