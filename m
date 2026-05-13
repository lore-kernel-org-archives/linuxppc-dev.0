Return-Path: <linuxppc-dev+bounces-20920-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75326CD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 17:25:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gG0hY5kBhz2xld;
	Thu, 14 May 2026 03:25:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::736"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778693101;
	cv=none; b=EKkMnKTXnpj+T3JnVq5VkncWTi1j+t/DkhimWxay7Q4W/8gvKcO5Wt/cij2WR6PlpK/ZU1s/z+TXrlQl8hYF6HBObCR9mI+mWNeohMpom0+yC7fLhZfwpaObOL5pTDuk4NXkKCJcm4vlv0GRdMPjBGGLHewIshYnvlYbqPuWSA2eGTImaJACdFGJgQ50CIyuymuwueDPraFny6VM9ODAxKHvmf2sU9wBa2Hs80ilGzy96RRVZUoaxy0ByORS2A5XPoRR0EUsXwlIIRHCyRKaX55t7H0t5LHI3Gn/iqNx71efgQIMXPitA8e+OEPlESBadg6W2nK91y6YHA3cW1AidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778693101; c=relaxed/relaxed;
	bh=fQtwNmxswhQih8gmC6FPDl+zfVKzr3i0rq4YmglfcBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEM40uvKVxwcXQZcyDBjvnOtPFlDhNxF9ghrGpmyHdab9/R1CEvIlpbXwaYiFrZW795/P9L3hgHa1sj/XhQoGcly7Xe+0CEANI3UiYY424nKe2mC5DtpFaqh/cpB9RksEQzJug7tSr8kIYK81lvqzZq5LLqLUiOmn+8sDtGU09SQ4VANTjjK70HpU17dwVepUCwA7+nrCLKjkZUgIlCLPrL9MfdRaCPdWPuNWI6Pjh7HCXjzKrI9kuzOObFmJdGp9SsU1mwGdpOqWzJ10DXm1fIlhgzEpxE7tBMzSQ0mvRMF1eQT8apHjm0YxnCNqk9CKe3zUYdk6Y9bdrSfMdiSsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=f3w4Y0Cr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::736; helo=mail-qk1-x736.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=f3w4Y0Cr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::736; helo=mail-qk1-x736.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gG0hS4qXvz2xlV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 03:24:55 +1000 (AEST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-8d560ede296so784028485a.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 10:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778693092; x=1779297892; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fQtwNmxswhQih8gmC6FPDl+zfVKzr3i0rq4YmglfcBk=;
        b=f3w4Y0Crx5RJ9hwoKiVyY/ILyA725kEoj1n65JRdscszwiOe4i/kH1OEU2cJU1dg8Z
         x2TJWUB4CWN73FwUy/QohgGqxdbIj7Bim8AyONUyLs1v0sG3uXaW9yTJNBYHA0aZmYPo
         d12Rq51k/NOATofN0OaeC37x7c23qF75u6bpwwZQ0buKdxDUlr5e+uYlMEJDVWFYyeR6
         xvq8h6uzzLiZXKsKef1wxt8NnyqNXbwymIZ2Iy1Fvg2+1HbQke7UvUaqOPlav1p1JHn9
         fYPJRChesYWiTH6UdVUKkhOjlksMrpUs+9NkanYu84+nQvAovEeDbtviL9olLNk3+tRx
         digw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778693092; x=1779297892;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQtwNmxswhQih8gmC6FPDl+zfVKzr3i0rq4YmglfcBk=;
        b=CjVbCR5YORnuQQjZ2wpJ4c0z95YdhfCQiV+1m/L7FppGfxEHK/TRpgm2c41iPmaV5e
         n5yAhKYWItMCqD3UZx1rrbQmFoIUht7AntVnnSJqBMGf4TsbxlBOAWHjKVop426Feye9
         +afeb3fL3yEgZ8bTGsMLt9w5wkpBrvrD5LMBh2/jIOmanWEQyPpznSiJUf8zXU2ZJ2YM
         27AoSCEBaXMvqGGGA2u/+VS/wz0xtqcEAlTOSVZStbXZJLviisoR3DnrMzkkiKbaqkUk
         y1GP8hBN7Ysix62EGgUD8Jk+whnhKWcGmv1121sjRuTMR2vFpx7IanRTDqJCwGQYSE9B
         jLLA==
X-Forwarded-Encrypted: i=1; AFNElJ816nzEN3blB7iKjEkXVdLw7Fy9LU4koJIjovKx/YUj5PQzcqHoTztNJQIyFdovZ5qhgdtxAQVTchEdZhc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw+ikViz+7MQougrRreouFeYnTPTOGKdQ0PoiogxR4R9P6zumLJ
	LwxZbfLcZ3O71mU1nMQQN2yrsNbWnyKy4x5Y+5uYbbDOSTh6lkeS+xLA7fcfNfoaxeU=
X-Gm-Gg: Acq92OGJqfr3RCqAIZKCqcfpWgo55iv4EVcJrwO5U7vSQtqwJGSRMBOFHnUHcm0wF1t
	Iiz7KyfkNKsEqQ+tFtrnXgPA4XCxDaer5M9A3XmmpUfVV9b23I/GmHR4h7aY6VDDsEScGQ95Msx
	1UXbSrHuClctxigJOy8GM8g8tWfIHRJyQn3wPbd7dEncETKe53tQ3rA0tBk3B461m21U8GjSegR
	/Jn1v2ISoOaGG7pQ6eY0wWxssfhGrheBmVaJRsDQuHI8FNnNNuQz16CLMWWK7er7SxncfifGf9w
	oRzHjh70DcaLxh4eA79XnPUnn6urx/1od1j9oZJCa17Kb54qp8OimNSOQka2Qd1jw+oJH1LSQE0
	1wrqIU1fyRXLWbnRIYJphhLXSyPI/9MpmHDaU2j+rAV94R52QuYU2U35SdDQ9RhY+NeolXuhvq9
	9ljVZMacd5GrgV8Y45U9AMnbkrNWH1/gighh+RIxlrXdki/OsJEt2CXT5JU32/Tu4CRNvMuOQ4R
	EK28Q==
X-Received: by 2002:a05:620a:19a3:b0:8ee:42cc:4d9c with SMTP id af79cd13be357-90f8ac08735mr658592985a.39.1778693092335;
        Wed, 13 May 2026 10:24:52 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83bbf5sm13598685a.28.2026.05.13.10.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:24:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNDKE-00000003dZu-0jxL;
	Wed, 13 May 2026 14:24:50 -0300
Date: Wed, 13 May 2026 14:24:50 -0300
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
Message-ID: <20260513172450.GR7702@ziepe.ca>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
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
In-Reply-To: <agSKQrSIhizCXKwx@google.com>

On Wed, May 13, 2026 at 02:27:14PM +0000, Mostafa Saleh wrote:

> > +		/*
> > +		 * if platform supports memory encryption,
> > +		 * restricted mem pool is decrypted by default
> > +		 */
> > +		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
> > +			mem->unencrypted = true;
> > +			set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
> > +					     rmem->size >> PAGE_SHIFT);
> > +		} else {
> > +			mem->unencrypted = false;
> > +		}
>
> This breaks pKVM as it doesn’t set CC_ATTR_MEM_ENCRYPT, so all virtio
> traffic now fails.

How will pKVM signal what kind of memory the DMA needs then?

Does it use set_memory_decrypted()? How can it use
set_memory_decrypted() without offering CC_ATTR_MEM_ENCRYPT ?

> Also, by design, some drivers are clueless about bouncing, so

Oh? What does this mean? We take quite a dim view of drivers mis-using
the DMA API..

> I believe that the pool should have a way to control it’s property
> (encrypted or decrypted) and that takes priority over whatever
> attributes comes from allocation.

We should get here because dma_capable() fails, and then swiotlb needs
to return something that makes dma_capable() succeed. Yes, it should
return details about the thing it decided, but it shouldn't have been
pre-created with some idea how to make dma_capable() work.

If dma_capable() can fail, then swiotlb should know exactly what to do
to fix it.

If pkvm wants to use the hacky scheme where you force a swiotlb pool
configuration during arch init with force swiotlb that's a somewhat
different flow and, sure the forced pool should force do whatever it
is forced to.

But lets try to keep them seperated in the discussion..

> And that brings us to the same point whether it’s better to return
> the memory along with it’s state or we pass the requested state.
> I think for other cases it’s fine for the device/DMA-API to dictate
> the attrs, but not in restricted-dma case, the firmware just knows better.

The memory type must be returned back at some level so downstream
things can do the right transformation of the phys_addr_t.

One of the aspirational CC things that should work is a T=1 device
tries to DMA from a decrypted page, finds the address is above the dma
limit of the device, so it bounces it with SWIOTLB to an encrypted low
address page and then the DMA API internal flow switiches from working
with decrypted to encrypted phys_addr_t.

If we can make that work then maybe the flows are designed correctly.

Jason

