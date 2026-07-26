Return-Path: <linuxppc-dev+bounces-24835-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D987C531CC
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2026 08:18:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7F3K2zyhz2xyk;
	Sun, 26 Jul 2026 18:18:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785053885;
	cv=none; b=gp5o+IGRNCckWq3NfPNcI3WKl9R7fm0sH87vpy+yZI2R0oXrlyIAzIzgK9ewe6xpAgkMsckjeGhbKEtd0vZaBDGKiP48M4mxIHJgpV9dScOvQ93113nW34Z/IG7bm/Kfvn8aR3DH1yS018BsmOcIyOmfRAgA6Uefrqy/WCPLlIjXWo50XbY+xiT1gglVSNKojoJ+2+FYEgIY7CVzWT0EEWxB4KidsJrt4vs9/gVpv5wkoXIV8lcDueoieR0st8YWsSAPtq8KrZkdcIRjnclqOdA8Komubz/5l4pm0RDHzbreU5FSWEZVPquQaJhYx0MRQYVweQxVI8UiT2CLkJTsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785053885; c=relaxed/relaxed;
	bh=rV3KV7vBjyfzuXzvKP70K3FcZTJiIsGPcCYGDQB6sAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpkYsy8Ycs2qv2pdXHHO2sJ53zFcIz/3W7eH5CT+GgrMC+y25tbgAuFVbHVJ95Xz7TXxrrEo46fhFdm7eB+tvyJyfI9STk9kqiEOJ4EVMSvmk1FqZr+6DTbmiD7NJDYMb6mtZ1FaQUiximRFXEVMq10O0WYMH7OYcFborWH2QhdTUCDEIM239FNDEcCtfIbiQ4cjFBVKBGHdwVdoic96rxUWurAApGHzpNzD6m5liXkHLGRg5eD7hRSQy6FEJ1K4lPULgJIk2VZoZW1oGnGrMDgHM03yoeeb/rwbcHz+fbcvJ/qHKx+E3OMLoxWp92G1awvGnapvwOkrx04jQqXkIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QSh6v7Ln; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QSh6v7Ln;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7F3J2nQwz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2026 18:18:04 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F349B432FC;
	Sun, 26 Jul 2026 08:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CAF1F000E9;
	Sun, 26 Jul 2026 08:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785053879;
	bh=rV3KV7vBjyfzuXzvKP70K3FcZTJiIsGPcCYGDQB6sAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QSh6v7LnboLYO6xF16A2+7oGN8HoXODtGw5S8YO/FkrMU2s6CN6sTfDR1dR/lfKoz
	 2qUJFoixbeZXmsG6d/uilEjj2PxxfrzsGPE5BQ6jhQ7HBFfdBcaRGpQouUb6azeUgi
	 n34cs0woLHoRxqtxV+r8p4J5+gDE7MQ2o8/RgCRL+DPKTM2UP/nwvcwVwn7QnpLOsV
	 UEkEXGiiy6JDqh7Ys0iN1ikcBqAGMSkjH68/0zQ4NQTKpbdrGGQ02iEM4JloZieZQY
	 oOKoUoPlmPX5blblYslJfGJhkNgUevihiOHrfRA+gi9U3BaHvOnD+uI6bcD17dyw+v
	 MOsVc9tnoXHPw==
Date: Sun, 26 Jul 2026 11:17:53 +0300
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
Message-ID: <20260726081753.GD12003@unreal>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-2-aneesh.kumar@kernel.org>
 <20260721115456.GI110966@unreal>
 <yq5atsps77c5.fsf@kernel.org>
 <20260721142921.GN110966@unreal>
 <yq5ao6g0750v.fsf@kernel.org>
 <20260721153321.GO110966@unreal>
 <amEhEKQW0_HJ9cLN@ziepe.ca>
 <20260723075704.GC110966@unreal>
 <amTJY_CdE-uDgoGG@ziepe.ca>
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
In-Reply-To: <amTJY_CdE-uDgoGG@ziepe.ca>

On Sat, Jul 25, 2026 at 11:34:11AM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 23, 2026 at 10:57:04AM +0300, Leon Romanovsky wrote:
> > On Wed, Jul 22, 2026 at 04:59:12PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jul 21, 2026 at 06:33:21PM +0300, Leon Romanovsky wrote:
> > > 
> > > > Something like, but probably void* needs to be phys_addr_t:
> > > > 
> > > > static inline struct page *dma_phys_to_page(void *addr)
> > > > {
> > > > #ifdef CONFIG_DMA_DIRECT_REMAP
> > > > 	return vmalloc_to_page(addr);
> > > > #else
> > > > 	return virt_to_page(addr);
> > > > #endif
> > > > }
> > > 
> > > I don't like this, we don't know for sure the addr will be in a vmap
> > > and this will fail if it isn't.
> > 
> > Of course we know. The existing "#ifdef CONFIG_DMA_DIRECT_REMAP" is
> > relevant for addresses acquired from pool.
> 
> Yeah, but I still don't like it :) It is hard to follow if you make
> those kinds of leaps, someone will call this new helper on something
> they shouldn't

This issue is straightforward to address today. Limit the scope, use
an appropriate function name, and add a comment indicating that the
function is local to and specific to the pool. The latter helps
AI-based review tools flag incorrect usage outside the intended scope.

> 
> > dma_phys_to_page() is a bad name for some low-level conversion function.
> > It needs to be internal to DMA logic, in the level when we convert from
> > phys to page.
> 
> I think we should not convert from phys to page, that's also easy to
> do wrong

Perhaps I'll reiterate my complaint. DMA internals are already hard to
understand. Part of that complexity is necessary to support every
possible use case, but another part comes from a maze of types that is
entirely self-inflicted. I think this code only makes the latter worse.

Currently, the phys type universally describes memory and can be
reliably translated into any required representation. It is the most
fundamental type we have.

Thanks

> 
> Jason
> 

