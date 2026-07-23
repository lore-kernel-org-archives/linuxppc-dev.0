Return-Path: <linuxppc-dev+bounces-24716-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81C2C531C7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 07:57:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5Nkd3QgRz2yFg;
	Thu, 23 Jul 2026 17:57:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784793433;
	cv=none; b=Xot4xdRGSYzsZYAyx18gSeh0exwMCEAQ2RyOfSQpmiLJLw22uqRB3aCc1ImEV4rKzn0phM0OJhgAtO9iWT0ud696kic+pIstBwYUPbOjhlb650PcXOpIoik6NFln2NXL2RH9vfcaMaz4ALsybmOKi1Fx9LMexytb4BrP+ZYuxBPrk1w/sFVteN4j2PbXTLxvQ4WFY6cF8gQUlopjWcDvlKtFA4Qu9p/1CyeCtZjjtD+FMXCL1zhg2O51gUP3pqP1q2mIOHhpzPr1JbLO0tXJxPd0WcpI6vI3GH/SE2PmrxrjF4qDFcQznMVE4Y1P/qntucEAyWMtXsekYvEevpyVKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784793433; c=relaxed/relaxed;
	bh=MV/ddKhkOPrQoZ9vfnIwVbLJK9zML3biWg/uhRgYT0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RV2dtfEkTgxh2D8KfJWbQh2y+QPJ4BgmwC7VNavzev+P8t9vZZtbHzRZyINkrOlgSWWwpP11+k8b84DpXQX2W7GcYy17V+jIYM7IfgjitRLN3+IAJd5wzgVSmzNh1LU92WE6ueKbo9iafWl9R0HVVoykgsChmsUWP9CPc1SEot58YPfy9fX3yj1OnzrGbMNjy3c0QQ6ByxYfPsvs+dF320uAVpovtFOJv1AnK1umoeuD0KdkuPwK/TP1MCt6pCOsXgZ+vbGg2/oIcc7TNp5qAOwKTRLJMGKE7PF63mKMcICe+1nStsCtYlCaDO/jzJjpNYBw8zysBs63nOuXgOs3DA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3xmLXvw; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3xmLXvw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5Nkc2MTyz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 17:57:12 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4C5024047E;
	Thu, 23 Jul 2026 07:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF221F000E9;
	Thu, 23 Jul 2026 07:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784793429;
	bh=MV/ddKhkOPrQoZ9vfnIwVbLJK9zML3biWg/uhRgYT0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d3xmLXvwi2GMENZnteIxAJT9s/vth/ydaB8jnGiDbnoJQUcvxVpdQ4CJ0u/BR5Y29
	 qaZW01Tiv8f4zxAh9MGXy85RlTXDqDPcKcAejcfjjHjyYTYGbVh/52WQY1d0+CsjH4
	 ZXpYH0x/j/a+NIv+xUiENTmrpZC3T7+frmDwNIUG6kyP4miDxfjWLm2Kn7T3DD2S1N
	 Rr5EEKagMJePKW4DfUuaR2sNSURnR2wMcS+E4LnTti/I86ga4mpseDz/aSW2/dFH2l
	 lQt2pE4DfhbMPDcGZRVqphfYVCpTaURvHtyxvsl8CTFjve+0WEFD5IouvdUm0NhOK9
	 QYRocdPIUyYIw==
Date: Thu, 23 Jul 2026 10:57:04 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <20260723075704.GC110966@unreal>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-2-aneesh.kumar@kernel.org>
 <20260721115456.GI110966@unreal>
 <yq5atsps77c5.fsf@kernel.org>
 <20260721142921.GN110966@unreal>
 <yq5ao6g0750v.fsf@kernel.org>
 <20260721153321.GO110966@unreal>
 <amEhEKQW0_HJ9cLN@ziepe.ca>
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
In-Reply-To: <amEhEKQW0_HJ9cLN@ziepe.ca>

On Wed, Jul 22, 2026 at 04:59:12PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 21, 2026 at 06:33:21PM +0300, Leon Romanovsky wrote:
> 
> > Something like, but probably void* needs to be phys_addr_t:
> > 
> > static inline struct page *dma_phys_to_page(void *addr)
> > {
> > #ifdef CONFIG_DMA_DIRECT_REMAP
> > 	return vmalloc_to_page(addr);
> > #else
> > 	return virt_to_page(addr);
> > #endif
> > }
> 
> I don't like this, we don't know for sure the addr will be in a vmap
> and this will fail if it isn't.

Of course we know. The existing "#ifdef CONFIG_DMA_DIRECT_REMAP" is
relevant for addresses acquired from pool.

dma_phys_to_page() is a bad name for some low-level conversion function.
It needs to be internal to DMA logic, in the level when we convert from
phys to page.

Thanks

> 
> Jason
> 

