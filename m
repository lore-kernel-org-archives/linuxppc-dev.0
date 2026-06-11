Return-Path: <linuxppc-dev+bounces-22491-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E1ECD98D2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 11:50:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbgv64pZ4z2y8h;
	Thu, 11 Jun 2026 21:50:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781178626;
	cv=none; b=mTNh2msAKy7sIMyYnNOY+WS1gvnVV/UG3reA6X33iiV9OEXkCGlFRlkGwI9/ioajNhvSjYlub3d1zQxkx3FXI6IXXoJpM3wzhGkCoQBIsCNv+2xucCsVIIiElOPh+ZauE9yRXxECLfePyarQqlShiNf6WNJ5y1wSxLaOQ5VfGfTmMk8lUs7xt6DNdXlSpnXakGYrVTGV/9SzCt3Dd+3nhcGvdaim8WXuUX8ITzycA10wtCUyfjtFz8zREhkZErD9K8FuCYgW0xzcDazR0ozZKqjjXAmH8w445Y4dH3EVJe8X8ppYYDUG01if7VleFIxG7cG4kyWZjTSZSvZZexhnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781178626; c=relaxed/relaxed;
	bh=By5jxDRfMhWNJ3zdMqbqgKEuQjBAiR2dgY0SOpXrO1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzMQQIQ12pNfWu8jMleYQhWM1dy6Oi4Y2Ihwab9tUV67bDUmAKEYR7iduWdlXTChI1Ez49P0/tcu4ZkPE31ATtUy6ahhyoYue8MgIg6hcKJgSJxVO5dpYFWcDcd+ZBlHGN3QmgN3CiSAV+EYzui1dpE6z30Sc4PRIACbE8w8ZWDOwwVSeXHDVIsebUQulMkadnnqYWaPOSxQ2Uy07sf8XZYOv08YzpcW7L8CKFoLk73jKRISDrfmPGvSi/ZjYk8HO1mdXDvchADGFkYq78Q4E892yomVb5i8v9OnoZYVtFgwn5F+aSWNozL8T70AxA4Z5OuFFOXm2rUwdxR1C+5arA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=PQz2tr8q; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=PQz2tr8q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbgv40Yf8z2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 21:50:22 +1000 (AEST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-45ef14d4200so761731f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 04:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781178615; x=1781783415; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=By5jxDRfMhWNJ3zdMqbqgKEuQjBAiR2dgY0SOpXrO1o=;
        b=PQz2tr8qHbPVoZZBsPcH4mXFjPrvK1X8HEvBPBzITQt7E1A/zKmr5g1oVCI+N/TXXl
         EZeJG9PFVtv7XKQVCEQyEiApPvTizMZFfOwQe4Eiv3Uc7zvZSQ9mpT27BxFXEP7FI0A4
         ck2cDjpqEqQlBTsiQBP71bKg0qbzakKyLBOu/nOqXlybrBVzul+mg2A4BxVwkbibyOqA
         oQzl/zJ7ZrOYk4LDemqm13CN7s0+Pm4n68FpwZ6M4dwMbqJGSwAp4K8ZdFmKmcKbowxi
         zG6RmrFRRaoox5MsxOGzwo2IQPkTEFfOmanI/EhjXpRTXMbbBYo4ESRi25zt6RUPCE1h
         /d1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781178615; x=1781783415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=By5jxDRfMhWNJ3zdMqbqgKEuQjBAiR2dgY0SOpXrO1o=;
        b=BxlQaRUMC+tE43ApTVk9VBguBsu8r3G7gDLfOkj5XofDZyScmfMbE6u4eE5TJsEQ10
         yF2J/9MVr3OkK2rMctLVe7hKgfn5bCxT21CdFeQBnDO7J61iy/cLD/y4uMlLs/fLMBZn
         snYOF7gq4ohOOLnBMF9RxZYzCwSr7ACr2eNp++zPMPzeyCC+Cz+0jBS5yani9meF0EzH
         aDLAZo3tFkFUAMZZBE+dWRzsBTnQx8wJY99Jpx0L6KqvfmKdyjRhw/8di2WeqeAOVYTi
         yiSWyeZozOFVxCt5le0vwdpi/4XHARA6JKq0mTmoxeNim93X2v7nivHRC/3wZD1iSD3q
         0U1g==
X-Forwarded-Encrypted: i=1; AFNElJ+xxYBSFIpOw39pZiI1j+iiEcoKaPq85+8IxfN/uSVgZXoj6tRe/7i/n4YEo+OmKrUNFDnjWY7g+IAqaMI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxGRuGcc+RbMHWvvjT6tTJH4TmLXyP9LRcuUAyq/4OMdg8AZzhz
	/Rm13WI23JUjtvsnEVYeLUe24Ltgb2kgZgVxjbmSAogzVyS1rKLAj5f/3PPP7O0foMQ=
X-Gm-Gg: Acq92OEOAhqHICnJhmp/L5N4fb/X7kmI3raeM+tnTE0HDL7qSnh5dcXegSpYkllbOqF
	K3UaxXbnpwrRG0l2MUpSs0jUuSm7FkSaSn50RdfJI+1lLNaiYQgALzUTM06rPLofpfEQmnMHRxA
	9baWe3ZxCju/ezdPM2tn1gb7eh4vTy2VEXrQ0QKHyJRR81hh3NiOtW7eOa1YWwP2GyWKd6T3R4z
	gNg5B3CNJzKWCDFJkAz2GOB3o4Y7b6C+xy3Az5nD/LXlg7Rj0dxU/783RbfBCGF9KVKLhpnwKr2
	6CcpcYjIjEX6f8Jwbd5WWr6nzX6rumP+BYfDHoUoJ81xpF7/Y1oEWG3R/OOeRoBnCCcxMq1H83w
	D43e8jpFt3breUQT/1FA0pt/8cFjpRMWs6eL8Rgy10BC1SNDwTJQ8aHjcZtpMrOP4+c1wJaYwoB
	NTLgwgBgSIHv9OxerlisZf3FD0fqS8VpKPWtjOniP9UdXk5Z8F3RZAVacRgGn2zj+Q3WUL6nGEU
	Y6Zt4uIicMD+FVRY+xCn3zL2cKdUhBPGUrhaw==
X-Received: by 2002:a05:6000:2508:b0:460:1bf8:c959 with SMTP id ffacd0b85a97d-460673e3ae5mr1690022f8f.0.1781178614930;
        Thu, 11 Jun 2026 04:50:14 -0700 (PDT)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ed944sm83042430f8f.13.2026.06.11.04.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 04:50:14 -0700 (PDT)
Date: Thu, 11 Jun 2026 13:50:04 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, Marc
 Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>, Suzuki K
 Poulose <Suzuki.Poulose@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh
 <smostafa@google.com>, Alexey Kardashevskiy <aik@amd.com>, Dan Williams
 <dan.j.williams@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Gerald
 Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, x86@kernel.org, Jiri Pirko <jiri@nvidia.com>,
 Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 04/20] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260611135004.70d48daa@mordecai>
In-Reply-To: <20260611113740.GB1066031@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-5-aneesh.kumar@kernel.org>
	<20260609143242.GK2764304@ziepe.ca>
	<yq5aa4t1myw4.fsf@kernel.org>
	<20260611113740.GB1066031@ziepe.ca>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 08:37:40 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Thu, Jun 11, 2026 at 10:55:47AM +0530, Aneesh Kumar K.V wrote:
> > Jason Gunthorpe <jgg@ziepe.ca> writes:
> >   
> > > The sashiko note does look legit though:
> > >
> > > 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> > > 	    !gfpflags_allow_blocking(gfp) && !coherent) {
> > > 		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
> > > 					   gfp, attrs, NULL);
> > > 		if (!page)
> > > 			return NULL;
> > >
> > > I don't see anything doing the force_dma_unencrypted test along this
> > > callchain..
> > >
> > > I guess it should be done one step up in dma_alloc_attrs() instead of
> > > in dma_direct_alloc()?
> > >  
> > 
> > I think we should do something similar to what dma_map_phys() does here,
> > considering that we only support DMA direct with DMA_ATTR_CC_SHARED/DMA_ATTR_ALLOC_CC_SHARED.  
> 
> Yeah, I think that's the right idea for now..
> 
> > +	if (force_dma_unencrypted(dev))
> > +		attrs |= DMA_ATTR_ALLOC_CC_SHARED;
> > +
> > +	is_cc_shared = attrs & DMA_ATTR_CC_SHARED;
> > +
> >  	if (dma_alloc_direct(dev, ops) || arch_dma_alloc_direct(dev)) {
> >  		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
> > +	} else if (is_cc_shared) {
> > +		trace_dma_alloc(dev, NULL, 0, size, DMA_BIDIRECTIONAL, flag,
> > +				attrs);  
> 
> But it would be clearer to put the test in the iommu_ functions I
> think, since they are the ones that have the issue. We will need to
> fix it someday..
> 
> I think we can ignore the op-> functions, arches cannot support CC and
> still use dma_map_ops..

Hm, sounds reasonable. Should we probably enforce this at configure or
build time?

Petr T

