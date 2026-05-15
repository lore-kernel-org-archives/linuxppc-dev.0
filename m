Return-Path: <linuxppc-dev+bounces-20993-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CEDCD4851
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 22:51:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gHMr95f0sz2xH9;
	Sat, 16 May 2026 08:51:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::833"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778885481;
	cv=none; b=leYHxe8TDdbs3USa6gbmwUpIHn8c1MSP9NITRTyAuDThBsFDTOL/32Nt5tyeZtZEIbwZfPf1cksdD4HYJkLshBjMshM8Syl80sEHQfho4LGIe8GJXyMICX/HykJrbV0NciNv4dn1QVJ8WW2L4P+mvdLT/yqwwdeA/wHeV9Oovgb38SOKyuK1DlFIkQg7tQszC0f5mkfRY8qQz45ogbN4LcHU5Q2UWAW5mq+zv1nP7yiX9f2Mo3UH1t6Q4X7OzImBkHME9UoBiQ2qHNFfjiHoOkVBPfC9Ku6TO8Gxg6fnWDAwz8Q/sPTEkT/8UW6CxljG32AXMf/Q159sUa+pkSp2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778885481; c=relaxed/relaxed;
	bh=immH+g/3RYXTN+iTjjy3LaccswRoDpZE21Qsh/sCfkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwInCtwPkqjjKizl9kN6Dy7jcN9AJsqg331LRYcdo3ptJNorQ6QWUO+oe9td3G7PsYjl5E8yk2zjg8Bwlo+WgAa3JmLatLgdxk30/0WOA2K2Lhf9kq4RxdsxEMZk0I7Zq3MV19qahPmhPvr4KHuWo3rVP2Dn66mC/+AvBZn0pLFU95c6M7dIZ+W/gNs//d3BjgztyjjqKgPN2SwrDUSy/FFsCHViG7klNQdy2/NK5Sm6PFczQYxvdjxRy+LvklVmMEAtryqKqhDPOBdWy9+JxBboAU7llO5Fyn1VnP+AbdSMRgYKnqVjEXj+FwT2nYvW5N1Tji6v9gpXmJOSPIAnhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=k81ePGSj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=k81ePGSj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gHMr733Fdz2xFl
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 08:51:18 +1000 (AEST)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-51306c36c3eso6088431cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 15:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778885475; x=1779490275; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=immH+g/3RYXTN+iTjjy3LaccswRoDpZE21Qsh/sCfkE=;
        b=k81ePGSjrIz10R0goyp9FE8lH5WW8WGR+818kouyAYKL/L7uZ5dJd6bYn48uupY8P+
         HcA5Ukzg1PirLpAfGq+QUZIcu89nrHMCzxWcvovLRw/PwN1m1J+iGTYIyZyKYvv6avKm
         YEr9lCK4UQU/1sZCCiSEfTvwsRoKr56Jsf74V73Xhe8v7j6BXvxsdpoPnVb5ZT5WnJtn
         GpXJAfiIAB1GeXbBjGzrSbvEjuvlree547ta2keFCs5aH7GCZgX2lSY8g3t6uMyWawpp
         TFIztQiwBTRg4595Myw6HOG1glT5kH/bkS8boSByjtXPgs107prp+MII/V09xqRzIUdw
         7teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778885475; x=1779490275;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=immH+g/3RYXTN+iTjjy3LaccswRoDpZE21Qsh/sCfkE=;
        b=oZzFrxLjo9x8vthmgZVcME7P8/4JtCZyelJJmKPcKuVX9bEJFivV3ZihvZq4YFwVp7
         HqkoB3bQjGn3sOB19m3T8+ZNUfudLRb4IBZJMMNjD7GWcI421fEpd2vK26xi/lN7qK2d
         VeI5CfJwbnvsRRRqat/mmeOu35QBUP4HP68r/3RAO355I8/AMkXUJyHGBz4YhL2SIYHJ
         Fi9TOOkFEqsuQnzkNFCXj56tL6PaCHV/XnXDiJSx1Md4AGYzpHO2vr2POy4yEg8SGtbk
         TvnZaBHF9cX51nbY/ZA/flaGG0BZ7oh42tcqMAuqtuY9nXaMZ0oL4qeRppIS4tueWl62
         B2sw==
X-Forwarded-Encrypted: i=1; AFNElJ9FPrR0vY3TbRDHJ8IswgQIHEJVJC++IuarHRprtHgggxv3yT+ph5p/NZ0qfWasg29wCCyQt8HCkQlNTFU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyO91jCNft14u9YWPnUDhKCjhdnlq4ukRvsbV5zcGKGU3HBBVN/
	quGDavMLFbmE0s0m+52ueJqk7p1sYUCKzT4KhblboJVSbs0yWGBHHT1/sP2B93E/IBc=
X-Gm-Gg: Acq92OHjbVrPaT+n22acGNazpTpvtndjyZeq0/nJew2Xdq/TILkZPhJcaixVkPB+CVU
	V6zGgaN8YV5d3IL7LeurcfmtIVrfYenVINBHTpB5NA7UYSQgkbU5CnQn4PdiGgg9Xflw6sft1wT
	KeILne2xxnZzLskvBqo37i9aSc1Q4dMqdLHMDKr+JftsDslK5xCmQOp2y0Es2VUSOKFeGIKKQTH
	IVnxpUqFkRgKwBPu5d8s9YeGmvJ3PuVwYmA8tPVR3nZQxRA6/GGiSP6erT5tNpVHnUyn/9ibm3e
	Xdl/bIP1y7YVLrqhf2GkHu9UPollK2ns7TLFCQYgG9yv9iIkhz/tjUMMbFH2cK95uQ9jNWM4F4Z
	xXV67vxHw9YUrdFjn829GYz+iIzIj1SxvUu6SLmbeZ0IsP282sRtA1iCp3G1GJiBEoVIMIdbD8c
	+7eeP2nF2gaWgT4XeZfbRJ+ytlLqbNms9K8/C9FamCPxMB0vrnwdOrZOtPzwwxB5b84r/OwG8ov
	7704w==
X-Received: by 2002:a05:622a:590c:b0:50e:fcbc:6b7e with SMTP id d75a77b69052e-5165a275f74mr79497231cf.29.1778885475017;
        Fri, 15 May 2026 15:51:15 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164585c5e0sm56735501cf.29.2026.05.15.15.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 15:51:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wO1NC-00000008Fgc-00Mh;
	Fri, 15 May 2026 19:51:14 -0300
Date: Fri, 15 May 2026 19:51:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
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
Message-ID: <20260515225113.GN7702@ziepe.ca>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <20260513172450.GR7702@ziepe.ca>
 <agW2lzJI-20DyJVe@google.com>
 <20260514123529.GZ7702@ziepe.ca>
 <agXfm3mS_M3fvRrN@google.com>
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
In-Reply-To: <agXfm3mS_M3fvRrN@google.com>

On Thu, May 14, 2026 at 02:43:39PM +0000, Mostafa Saleh wrote:
> > That's a somewhat different problem, we have the dev->trusted stuff
> > that is supposed to deal with this kind of security. We need it for
> > IOMMU based systems too, eg hot plug thunderbolt should have it.
> 
> I see that it is used only for dma-iommu and for PCI devices.
> However, I think that should be a problem with other CCA solutions
> with emulated devices as they are untrusted. As I'd expect they
> would have virtio devices.

Yes, any security solution with an out of TCB device should be using either
memory encryption so the kernel already bounces or this trusted stuff
and a force strict dma-iommu so the dma layer is careful.

This is more policy from userspace what devices they want in or out of
their TCB. Like you make accept the device into T=1 but then still
want to keep it out of your TCB with the vIOMMU, I can see good
arguments for something like that.

> > > While we can debate the aesthetics of the setup , this is
> > > the exisitng behaviour for Linux, which existed for years
> > > and pKVM relies on and is used extensively.
> > > And, this patch alters that long-standing logic and introduces
> > > a functional regression.
> > 
> > Yeah, Aneesh needs to do something here, I'm pointing out it is
> > entirely seperate thing from the CC path we are working on which is
> > decoupling CC from reylying on force swiotlb.
> 
> I am looking into converting pKVM to use the CC stuff, I replied with
> a patch to Aneesh in this thread. However, I need to do more testing
> and make sure there are not any unwanted consequences.

Yeah, it is a nice patch and I think it will help reduce the
complexity if it aligns to CCA type stuff.

> > In a pkvm world it should be the same, the S2 table for the SMMU will
> > control what the device can access, and if the SMMU points to a
> > "private" or "shared" page is not something the device needs to know
> > or care about.
> 
> I see that's because dma-iommu chooses the attrs for iommu_map().

Long term the DMA API path through the dma-iommu will pass the
ATTR_CC_SHARED through to iommu_map so when the arch requires a
different IOPTE it can construct it.

> In pKVM, dma_addr_t and IOPTE are the same for private and shared,
> so nothing differs in that case.

Yes, so you don't have to worry.

> We don’t expect pass-through devices to interact with shared
> memory (T=0) at the moment.
> However, I can see use cases for that, where the host and the guest
> collaborate with device passthrough and require zero copy.

Once you add the CC patch it becomes immediately possible though
because the user can allocate a CC shared DMA HEAP and feed that all
over the place.

> One other interesting case for device-passthrough is non-coherent
> devices which then require private pools for bouncing.

Why does shared/private matter for bouncing? Why do you need to bounce
at all? Do cmo's not work in pkvm guests?

Jason

