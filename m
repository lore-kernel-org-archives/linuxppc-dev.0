Return-Path: <linuxppc-dev+bounces-22482-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F6DCD98D5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 11:37:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbgcT46r2z3brD;
	Thu, 11 Jun 2026 21:37:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f2c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781177865;
	cv=none; b=fTnBlZgurdsbLd5zXkE/cKfyv9AqKI0xCSzByeBCQs4iQrW9+hfnNS0fE2NKvS1I9t133S02nG/81AjgiHgu5t6trcKSVDmdAEMcMU0F57lDn2TQ4ypBJ6qENl4BX3G/vWc8HtmGNAro7KkVqVmB3Ob9F2cXOH6KRto0/i2Z+v+fLHAF8SjFVGIgrGLE6SrBN4qEpIy2XSUUpp/O+a3GkMoe+J1NRWNfDQivMgj9Rtq/9PTT7o3hckoTLgGx41PE+L0YHLdsh5HHNkYksmwarvIXP6yZcZ7uJIhJVbHNTb2sdU4hvMEsgel4e3KF9sOlJPbq9a1LgfDcQ3vrfG1GYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781177865; c=relaxed/relaxed;
	bh=4CsqKJTBvj+SobIiLXzFxApwnBR8BVsF1yARBI6K1lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdrvfP70ZA0Wa2B0k0AvDD4nFibCpGLtDFu4o9DclSQ7sYlh4kQxq8d/nrBaLK5eMlEHbWDmes8POjifp4v3jxm4uqpoJScQon7lcQCsZBrhfPQ8ZerTI2Qy2KbQYDUZ2J7j2L4r75wzVDGKz2vjwgiXbwFlH/izI+0mFVMyoFEOVRAgQvwv5exRpe+IAJBYi6fgDr9R2Vc+QCCxB+6No0lDA0BAk4vIOAKqv0WF6+xBg84X3g8Q4BHrOJsyzbGzBWNM7+Xo1EMw/6i8+x1hFDKsl0xmFalTZZTz2Dsw1PdZStJdbioHxfByt1rwYu+thb1zEXThbrkEhaUQSSo1kA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=P1btV1Hq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2c; helo=mail-qv1-xf2c.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=P1btV1Hq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f2c; helo=mail-qv1-xf2c.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbgcS4FBzz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 21:37:44 +1000 (AEST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-8ccea53f35cso78707536d6.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 04:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781177862; x=1781782662; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4CsqKJTBvj+SobIiLXzFxApwnBR8BVsF1yARBI6K1lw=;
        b=P1btV1HqB8IqY9tMAbgdt1FfJgFmoFztFk8evEaT5K+Hq1N11zlcX38w9UXeeDlymt
         Hsslx3K5T9FH2QmX1dm3nqdS+OCWt/pAh+xhlNH5BCGitq9OnXbCPKDceIx1B0U6Igh7
         z9e7fXEozLYkLq4gos3Oqh5WQ5PLpyL110IdombVUFUmBSMgxnRPZ4fS93G0t0MMVZme
         RcsetRiIWi/H2txKIluA38snrm/b+4lsrl5CKSUAJpsP88t7Z3dtnMBsmjsbxWp8X3Y2
         uAt1GpT9yYYnC/kcY78RBEgBkLCYPNgykP/1PdfZX0hFE83Fg5ucgGVY2a94k+iOdsMV
         R4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781177862; x=1781782662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CsqKJTBvj+SobIiLXzFxApwnBR8BVsF1yARBI6K1lw=;
        b=AuI2bHIkl0PE7+jC9Fax7woQ2N90LWb98e1B6UBKDN0TGuXxaNyiWYJY+P9Ak1MyPD
         K9lRvaB6KZvDcka+EE+/+9Qhbt3+Qqojfgh88jWQ/HNXz2qrX9PmFN9UXG3KdwyRpIl8
         6YrX6MoRAYNFkjBG7TZM8z6O+LqG0kdKCPpQ4QuyUfUHkyuGobWCXIm/pxSSblrCUrRu
         aKRaEdeua7tGG11pps0Ap/shYxR1RtrtouB5PGY+kYVVkDJGZ0sQrEtL+MZIQ8+htxpe
         V8WkqOcqiMoOjlPE4uFu/XH9bZKqiTNKVAle6qbVaMWLB+MbRTa6Fsi31teNelGZXluX
         rCtA==
X-Forwarded-Encrypted: i=1; AFNElJ92yvITKrjEUBe5HDxgwKBg2BTXSz2yExEyq4DKPDjUmnw6nQGY7/35rpw/jc4C/+Pds65qd4p5KNoSD88=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyK2ulTakniINYYfAQhJ2gVZcydmFZ0rv87aXGxTJLfpMccM0ye
	BRzslOAbf10E+lARdBbAKVioDq9Mr1Wc1reBAc+yWYh0a8vE+6DICFc546+jK1izTHQ=
X-Gm-Gg: Acq92OFF0sCcd2d72qMitw2kZBUsk62GVNJ/gJIX90kKuf20WpYYA4Mt2A0uQYiHVkO
	fQij+oCkgeIE3E8Lf89ACGyzAKsKP2C52mHev7R6BBr/s1tVvTSZ6egKHRJrM/qO/LpnHSD/v1t
	KH+HJ6qwfkWtgpvslspe5i/4DT2pYblpphDhm3y50x/fBwJ5+hRTBsWEqe7F4Z95d6G3LPAPn0n
	H4WMfRaONyQhhI5GEH7XiXCQaj/cC6AKwsD49FPQOijV5tHTFX02i8bpS2lPSR+fyoENIlQRCz1
	YSFsUNYBzUtvbw50IZUt7z+HKyu26ibpRSzy0Pr4ECTwRIjg70jYa/EYXtCNBwBD7XmNNE35QS3
	uL+QfrUgZkaRwVULh1vzbBBycYCWmU+W3JJ9rUjU/z/da6nTarYy8ocVUUOnUhyvzVTjKTNPIAm
	fJ3CChBaoNmnNaaMg0y+1P87VqSe69fqPvT4iLHSMqvBSR/MmfGPuNfy8tz+/zRcz4sjqUDMqN2
	q9C8zmvosaxX3L9
X-Received: by 2002:a05:6214:410b:b0:8ce:b2e9:a4c1 with SMTP id 6a1803df08f44-8d1d8cfbdc0mr38674016d6.14.1781177861623;
        Thu, 11 Jun 2026 04:37:41 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d1e838f586sm15478786d6.20.2026.06.11.04.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 04:37:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wXdjA-00000005ezW-0ftx;
	Thu, 11 Jun 2026 08:37:40 -0300
Date: Thu, 11 Jun 2026 08:37:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
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
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 04/20] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260611113740.GB1066031@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-5-aneesh.kumar@kernel.org>
 <20260609143242.GK2764304@ziepe.ca>
 <yq5aa4t1myw4.fsf@kernel.org>
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
In-Reply-To: <yq5aa4t1myw4.fsf@kernel.org>

On Thu, Jun 11, 2026 at 10:55:47AM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > The sashiko note does look legit though:
> >
> > 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> > 	    !gfpflags_allow_blocking(gfp) && !coherent) {
> > 		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
> > 					   gfp, attrs, NULL);
> > 		if (!page)
> > 			return NULL;
> >
> > I don't see anything doing the force_dma_unencrypted test along this
> > callchain..
> >
> > I guess it should be done one step up in dma_alloc_attrs() instead of
> > in dma_direct_alloc()?
> >
> 
> I think we should do something similar to what dma_map_phys() does here,
> considering that we only support DMA direct with DMA_ATTR_CC_SHARED/DMA_ATTR_ALLOC_CC_SHARED.

Yeah, I think that's the right idea for now..

> +	if (force_dma_unencrypted(dev))
> +		attrs |= DMA_ATTR_ALLOC_CC_SHARED;
> +
> +	is_cc_shared = attrs & DMA_ATTR_CC_SHARED;
> +
>  	if (dma_alloc_direct(dev, ops) || arch_dma_alloc_direct(dev)) {
>  		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
> +	} else if (is_cc_shared) {
> +		trace_dma_alloc(dev, NULL, 0, size, DMA_BIDIRECTIONAL, flag,
> +				attrs);

But it would be clearer to put the test in the iommu_ functions I
think, since they are the ones that have the issue. We will need to
fix it someday..

I think we can ignore the op-> functions, arches cannot support CC and
still use dma_map_ops..

Jason

