Return-Path: <linuxppc-dev+bounces-21145-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A64CD4F57
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 11:07:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKX1d0GJCz2yCM;
	Tue, 19 May 2026 21:07:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779188820;
	cv=none; b=Ei4KE3CBESnb9Zx2tGwvCZlovo/S3GgBna0QG7kbXJEp0isucXqfckkUCo2sklU+Ghpp+K1xbxChrcoxgQ8XxJi3EOkjLrgmqpfOwnmW/2XoWsjQjVS6NWYOcyjeOny8dT+yflfjQHL5B/hE5qaIXOtYD0ZQeb7CBjdEBg/gNCpUK4+KjL4QgcheKAFLo5bqHoBO0TB71gG+Ob//kkurNzA9mJUcKqeMXZxsbFTHXR8JQY6CRkSFF/I/6rBEwnqhZRigKeJbkgGOYJ1aZ+BCwiHJ4BLEb6oxhohSAA708h8dw6EhbxBu4/xa7RyOecBFq8SVOSICHOr9PyRcLxZ1zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779188820; c=relaxed/relaxed;
	bh=gqrcVfnO7KvHz04L9yl4e6Ci0L4LjlQK4/aWUr5steg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2j1k5Y5/4toMdMceEgDQ4jQK+B6D7jsDMeE+YSyDN4EQkjMc7kjZ0AYvKKLpORMYpMVylfD52MGfV6DyVcYe6/MKnNSRPY4BGWGP/vMy4VSevd8regU8fi+sUgVmn2U0ekyhBc3QLg4zaCcr4CqhZgcjwExURM6rna7ngv0jnMXTZNWWXV1BR8ab38bQ7A1hk8HQzAbXOSWnkvrWrQzipkynak30WuqhqHexDY+G7oXnZ6YUGVYCN+B0VMtiLniIcVnhE5axG/BSsVROWY4sJUvpE0zFE/KJVvFIVKeIFMAPWb18qq7VTd8gmLJslC2skS2WXjse3to01fdAZTybw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EE3040bU; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EE3040bU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKX1c0vgzz2xwH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 21:07:00 +1000 (AEST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-48d1c670255so85e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 04:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779188817; x=1779793617; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gqrcVfnO7KvHz04L9yl4e6Ci0L4LjlQK4/aWUr5steg=;
        b=EE3040bUeMfp87OY0usu68Z3xCIww86KE3H7gtcF+kQk5TIRnt01qzKGcgaXRJpAlP
         ++9l/6HYkkWdaFEIQ+Cf50Fx2s9Wak2dEIFLTxubxkKGOVewUFKlh34U3xz4XDHDOaGv
         Wy3/wt1kc/6/aJRvflejg3tghqqHHgOQYM1EGQ9jFgi0nzOHxp8vYTCq7qrJFcAcZC16
         WPOgkW9CA8uCZPPu7FJ6jIjKnrffdcIT84fsEW+6lmkuFbJYLgPYBZECetV1V6PdAJzf
         jCDaZzRp+sfTipC9/eZtpwAT4eSnq3ioizhdzQUh5w2/bPfAiTs/6K5DP6pIW0OjwD3q
         4AWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188817; x=1779793617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqrcVfnO7KvHz04L9yl4e6Ci0L4LjlQK4/aWUr5steg=;
        b=dTggEdOGWH6GyZqSCQv5M3pkSfc5oFRgjxcJbm6xm6RssK5+qHHn5mtl6vhVDi3CgH
         2CT6zOeDWWDKYnnUzDXcdLPEv0tB4863TM6/dfCs0y6JAHzLk7C7KKbFT/lyivEt3cvg
         rxq6fLkP9d9mLYhMgsSOR7avsQ0zrbgRXW+HYUlTZjSQRLChWqVCIsOCvZ/BASZO3SbJ
         pAT9nJLn5ymULbHISc8wLPyuVQgaB+4S3goszdLXWH4qXsqKLzot6w0j030jO78RfWtx
         X33EXcIhdO4ngnw6tL0Q8xMWw55/7JhQ83183Ym5OkVJ7S4SfKmdCrVwfgi0KVlupMMa
         VuPQ==
X-Forwarded-Encrypted: i=1; AFNElJ9EE7pMeTKufTpD3WG8SkToqCulWaTYyPsFbqg/7Hdhrinv/EVWS2j7ZrjWtcgSqBbelSPfhimNdbQxbpc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzlYZIT/774t+ebRms0BmljndEYx5Y+6xLEP6vT/VN3gIq+xOrx
	+3lXuPKiOpaoSyOoxvVvF+/LVsbUPIRFOxg2OQL4NI8Zy7nwnP5AIMuWpF/2fMeRMA==
X-Gm-Gg: Acq92OGAdCOtCyILb+hXJJPuPJv+AddRc9HYh/2AFxc1g9kFiX52Nn09rI/u/Dlx/w6
	YeRM0ULI5da84r/kYNlwHAPOzfB3+E6bUFEabkxQr6JLAPmb9tpVnLMnJ7AV4TIEyL9p5HQr5zX
	aQxDbumwsm04mptLrn11HXL0ZcEVuNKwTgNjjHfPhZx9oFQUQo4oRrLUqM4xWJ+loQzsJztVeZM
	uu0p63oNplJjF7Lnt0sQvGlR3M/Q37KUVeFxgXrmn320x7jRb7Ldon2WBsrjcmAPbrofUo7/Y7B
	hXg6Bb5CqW7uPlFy5loQZzAHcSP67E6rdOMTjeyS01sf2gEjQgF46n48wOmokb6GQIQOM36ch+N
	EFV0bzflfcva9Jdh/v+PMvJ1S/iwoberdjKRPTyE5+XJzQOvgVkYvOj+U5FnQM7NUJDlAY4FsZ6
	8JD6+RlqZi3NDmXw/6xpq+WImgsD3TIP62IO5vDZGHmj5qtxc2+DMk0oNO62q2kA0EygBtdiwNm
	6hvEMGmLIHAzg==
X-Received: by 2002:a05:600c:418b:b0:488:960f:60b8 with SMTP id 5b1f17b1804b1-48ffa5e1272mr2275185e9.6.1779188816592;
        Tue, 19 May 2026 04:06:56 -0700 (PDT)
Received: from google.com (136.41.155.104.bc.googleusercontent.com. [104.155.41.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe53767ecsm288995945e9.10.2026.05.19.04.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:06:55 -0700 (PDT)
Date: Tue, 19 May 2026 11:06:52 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
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
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <agxETC1rXBUSkWYg@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <20260513172450.GR7702@ziepe.ca>
 <agW2lzJI-20DyJVe@google.com>
 <20260514123529.GZ7702@ziepe.ca>
 <agXfm3mS_M3fvRrN@google.com>
 <20260515225113.GN7702@ziepe.ca>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515225113.GN7702@ziepe.ca>

On Fri, May 15, 2026 at 07:51:13PM -0300, Jason Gunthorpe wrote:
> On Thu, May 14, 2026 at 02:43:39PM +0000, Mostafa Saleh wrote:
> > > That's a somewhat different problem, we have the dev->trusted stuff
> > > that is supposed to deal with this kind of security. We need it for
> > > IOMMU based systems too, eg hot plug thunderbolt should have it.
> > 
> > I see that it is used only for dma-iommu and for PCI devices.
> > However, I think that should be a problem with other CCA solutions
> > with emulated devices as they are untrusted. As I'd expect they
> > would have virtio devices.
> 
> Yes, any security solution with an out of TCB device should be using either
> memory encryption so the kernel already bounces or this trusted stuff
> and a force strict dma-iommu so the dma layer is careful.
> 
> This is more policy from userspace what devices they want in or out of
> their TCB. Like you make accept the device into T=1 but then still
> want to keep it out of your TCB with the vIOMMU, I can see good
> arguments for something like that.
> 
> > > > While we can debate the aesthetics of the setup , this is
> > > > the exisitng behaviour for Linux, which existed for years
> > > > and pKVM relies on and is used extensively.
> > > > And, this patch alters that long-standing logic and introduces
> > > > a functional regression.
> > > 
> > > Yeah, Aneesh needs to do something here, I'm pointing out it is
> > > entirely seperate thing from the CC path we are working on which is
> > > decoupling CC from reylying on force swiotlb.
> > 
> > I am looking into converting pKVM to use the CC stuff, I replied with
> > a patch to Aneesh in this thread. However, I need to do more testing
> > and make sure there are not any unwanted consequences.
> 
> Yeah, it is a nice patch and I think it will help reduce the
> complexity if it aligns to CCA type stuff.
> 
> > > In a pkvm world it should be the same, the S2 table for the SMMU will
> > > control what the device can access, and if the SMMU points to a
> > > "private" or "shared" page is not something the device needs to know
> > > or care about.
> > 
> > I see that's because dma-iommu chooses the attrs for iommu_map().
> 
> Long term the DMA API path through the dma-iommu will pass the
> ATTR_CC_SHARED through to iommu_map so when the arch requires a
> different IOPTE it can construct it.
> 
> > In pKVM, dma_addr_t and IOPTE are the same for private and shared,
> > so nothing differs in that case.
> 
> Yes, so you don't have to worry.
> 
> > We don’t expect pass-through devices to interact with shared
> > memory (T=0) at the moment.
> > However, I can see use cases for that, where the host and the guest
> > collaborate with device passthrough and require zero copy.
> 
> Once you add the CC patch it becomes immediately possible though
> because the user can allocate a CC shared DMA HEAP and feed that all
> over the place.
> 
> > One other interesting case for device-passthrough is non-coherent
> > devices which then require private pools for bouncing.
> 
> Why does shared/private matter for bouncing? Why do you need to bounce
> at all? Do cmo's not work in pkvm guests?

At the moment, in iommu_dma_map_phys(), if a non coherent device
tries to map an unaligned address or size it will be bounced.
In pKVM, dma-iommu is used for assigned devices which operate on
private memory, so bouncing that through the SWIOTLB would leak
information from the guest as the SWIOTLB is decrypted.
In that case, the device needs a pool which remains private.

Thanks,
Mostafa

> 
> Jason

