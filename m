Return-Path: <linuxppc-dev+bounces-24822-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12784C531C9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2026 14:34:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6nRv2dXRz2ygW;
	Sun, 26 Jul 2026 00:34:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::931"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784990059;
	cv=none; b=jZLJnXRXcxqPHktBbzuWMpe9FJ+nva/L18oAwOpcknxVYeEZfhc1T1cESp/fRAz8VN9LcThgYizpoMEfcBb41n0cPwN0uSBXgzcOL+SPKk0k/HDhOG7qDDbRa74ZDvwrZmavlLDFt9wkiediVFLazGs6Umh+4mDqbGrFWV8JpZbgePhR3Q9a6f5BYwdcA+ENBuisDO8RjZarkpL+IN9TjMqFFN3KHMLX/H13ZlXrL9Kz7O/B6yzlTsw084E757uoDWKubhJ/He+f/SdFVnmMSyn/lHVoWwDywXp0jgNKvsn7y8uYeUYAP6JG1aU0fUb0QEt1F+2HNrF/T9ll721tLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784990059; c=relaxed/relaxed;
	bh=vD91S1DbebApVBCN527t7AaQw07MlhokwGC+vI5FhsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbAVNNMihq6fiP2fVqR5GWWpNg2KjV1Oqnl0kz/zZNhXjCnb7Dq2b2drAyx0H8EDbbY5CC2lpgHFpN0wBjFh+YQ0Qq3+Fz9hEeko8r3XsJ88vDbchIE49ki9/Di4yq4KrFzkApIp7Dh+DldR+dYHgUFRs4BQqkUjyAexD4l5ONTLdyN2KE2ig5FDDgIwfAw1fQuANA/j0vZIgVoZLUR1Io6GOVjCldt6l4LdQX33lgv2cC/uS79RM951wvxz30nNW7L98XWS1Q8oiaevutx7hdvH5zHr1FL9LSusuUx+Li6e1VJUGJOf46AfjNbI+N3VDGb4u/X6ia6vhu7lepkuBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RKYYZWRT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::931; helo=mail-ua1-x931.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RKYYZWRT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::931; helo=mail-ua1-x931.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6nRt4BSnz2yfH
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2026 00:34:18 +1000 (AEST)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-9674d727c0aso1316277241.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784990056; x=1785594856; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vD91S1DbebApVBCN527t7AaQw07MlhokwGC+vI5FhsI=;
        b=RKYYZWRTRNKdMbRzBZPx8JAyI3YZNC17frWH/mdc5isjT9ukooDCCswQfAJJ8ZgrRH
         BdYxnjlQ7Sub4/mrwQ347Kui0m6EQjIDhNFHyp7jH+1FUIiPXApgtQt9XZCCfPSoz8KY
         4yKgKnH26OBJL/rJfN2G6pz7bnkehL3GoAdddDZLV4hb9jw41/4oIoCfTuUs6lUMvNWt
         gpQK6RKzrggRj/k7CXbpqti8C0SWyGArV+vEzqoysZhOKQz9P/xGIgRLz5fT6mYBI9We
         lUFo8m9qpjYHX+vsLiSDNwS7DPZSxGCUovGIdV+O431L8jXNCYPfESYL+uAXR2koraEN
         D4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784990056; x=1785594856;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vD91S1DbebApVBCN527t7AaQw07MlhokwGC+vI5FhsI=;
        b=YRX0No7FW8mXoKik8FtmPTgM2Vhw+kjGgC0okqYElRYoPCqRDZ3AEakwu7JJPUcBCk
         PX4lQ4hoV5SP+/yNFZdzo6Kxzzj9d9r3ID0kiWWXoDYIAejeEevOlY8/2lr3CKe34zUT
         /SrUz5VbcZDmocKPGkK3LoNhtBvwexfD5s9A6QKF4btXJAhHbrgsAmRqv9aydgnjdXsB
         Nl5HcWqYtspMntMG63hijWsjxP3fALIh1H+WS6VlAc6hHLDPMCOORP2A4GOleX4fWilO
         0edZ7DNP/3j3jSt0+c7OMDlh+n2cu0Fp6cV+0Fz2TxPu1Poj8zn/XAedF3L3hao40Ph4
         ElRw==
X-Forwarded-Encrypted: i=1; AHgh+RoPICuFrLdU/aBtT/rE/Nf5Twe4ncKPuOx7pT3grqmgqYmN4rfJye6F+d8xdqOCl+yloLB9wes/6nPwv/k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyT3WpvGLTYfwlBi1BGi2PTjiKLknz3Gty+KSA+JTWQMMSTOa4W
	5JpUOswlTXbmlwwcCN1YA4CeNc8FbX19TYlYmOm91t/XV+AvlargUB7I8Y9lkriCQuI=
X-Gm-Gg: AR+sD13P8PNRZl6KKvFXkgFTsrb+/uV7dRuH10yD8quN9QtytBuTwuUoNPBsngNDIwL
	XixQz/pWJ2guqcTamftY7QFxiGUtWT+MPePCtD28UMuaitck7nEl0yxcU+sS7S/PLsVr78Q46/6
	JddccZcXeM6g7nfsbWx5Sl4eL3rwoUC6itu13yT942GKGYUVOZmEmdHn2bELJhD1rYP056o+LA3
	NZ+okYRmrGw5REeYZ4tFaPNrgWh/NCKYjFaWEHLLaIRFZxJRX0CVDgHqiPlxVheMDLw6AOU/zPt
	rFLQdP6ljz88ajnBp+/UvGUj8mmDLey5bqGGxqxWB0Kkmg0+M+7HPz2BZ7cuhNDL04eu1UMV9+P
	0YZAW9aHkf1Uf7kXYJd9PZbkLxTx6HLzGKRPrnu7lKCLbX1z10uSv
X-Received: by 2002:a67:fd76:0:b0:744:d517:b0b0 with SMTP id ada2fe7eead31-74f9f02b7f2mr2159251137.10.1784990055747;
        Sat, 25 Jul 2026 07:34:15 -0700 (PDT)
Received: from ziepe.ca ([12.18.163.234])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97774f12690sm1878229241.12.2026.07.25.07.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 07:34:15 -0700 (PDT)
Received: from jgg by NV-9X0Z6D3.localdomain with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wndS7-000000000hU-1YTd;
	Sat, 25 Jul 2026 11:34:11 -0300
Date: Sat, 25 Jul 2026 11:34:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
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
Message-ID: <amTJY_CdE-uDgoGG@ziepe.ca>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-2-aneesh.kumar@kernel.org>
 <20260721115456.GI110966@unreal>
 <yq5atsps77c5.fsf@kernel.org>
 <20260721142921.GN110966@unreal>
 <yq5ao6g0750v.fsf@kernel.org>
 <20260721153321.GO110966@unreal>
 <amEhEKQW0_HJ9cLN@ziepe.ca>
 <20260723075704.GC110966@unreal>
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
In-Reply-To: <20260723075704.GC110966@unreal>

On Thu, Jul 23, 2026 at 10:57:04AM +0300, Leon Romanovsky wrote:
> On Wed, Jul 22, 2026 at 04:59:12PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jul 21, 2026 at 06:33:21PM +0300, Leon Romanovsky wrote:
> > 
> > > Something like, but probably void* needs to be phys_addr_t:
> > > 
> > > static inline struct page *dma_phys_to_page(void *addr)
> > > {
> > > #ifdef CONFIG_DMA_DIRECT_REMAP
> > > 	return vmalloc_to_page(addr);
> > > #else
> > > 	return virt_to_page(addr);
> > > #endif
> > > }
> > 
> > I don't like this, we don't know for sure the addr will be in a vmap
> > and this will fail if it isn't.
> 
> Of course we know. The existing "#ifdef CONFIG_DMA_DIRECT_REMAP" is
> relevant for addresses acquired from pool.

Yeah, but I still don't like it :) It is hard to follow if you make
those kinds of leaps, someone will call this new helper on something
they shouldn't

> dma_phys_to_page() is a bad name for some low-level conversion function.
> It needs to be internal to DMA logic, in the level when we convert from
> phys to page.

I think we should not convert from phys to page, that's also easy to
do wrong

Jason

