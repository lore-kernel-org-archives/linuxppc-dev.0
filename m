Return-Path: <linuxppc-dev+bounces-24127-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5E6C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 17:56:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzVVZ0j9Cz2yfD;
	Tue, 14 Jul 2026 03:56:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::835"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783965382;
	cv=none; b=eY0bYLCgKSpm/VRIclGa1TvUlILbbDiU1E8JMDpesziOP7aWOrlm3FUyfT1R1o0FMEmGfC5rJC+0/YWZVOWOFCMKIQHNEktlhBUUuaRgpyIj7y9S3MfFz0Ga3Y9Q9x2zWNlzb6q6bEYR5LjHfCps+g2+prKJuk4Ff0AA216+5vvNyWE3pUjyJyqhBwqAwPBrutpWKIcyUQXDCueSaXzZZ7AE+2Zxp/jdo9NlYvLcwTPjsWYRXWcMsAGXz349Ycfa355AdS1Itr/S7sTPERr6Rp6LdmMUf/7wAxNeeSXXKSdpVVuN57WiLt4W2vCdXwLZs7UEE72WCKtUGLBccyA0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783965382; c=relaxed/relaxed;
	bh=C/wrHcKHA68TkDcKIgsJLD5FCo0DNb4FA5MINQ+2Q20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAqJK+TO2B/XRmZ4ApgbltXhA9Dey9QUVpz48Pi7dltrMJt0YNPyfe0z967TBSDX4+pUBTyhoXFea4myEM2dRhuL+mBPS2fW6lDglYaUjjq0ZuDLCmm1XcwG85j5T3BYZ4owQukIqtoXRALov2LD2xAl+izYi1lMY6oSiI8Kwsi38Kg7AiNHLVls/SN8NiIY6sgejwOZS4qv5c8v5gnAmzX6jOEiMQ5XFicpA4wInoyxk5la1h0Z5sD0mJ2vzlH6y4vo8/WfPi5UYRaVPCDNe1M/ouzs8ntqXoYUOW8Z0+0mGBkzpAMwreWccq7a44fjL/q0Zb7X4g1NKlDGDY+k8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ZY1GnKcZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ZY1GnKcZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzVVY1c43z2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 03:56:20 +1000 (AEST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-51c29b46382so22232071cf.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 10:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783965378; x=1784570178; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C/wrHcKHA68TkDcKIgsJLD5FCo0DNb4FA5MINQ+2Q20=;
        b=ZY1GnKcZHPJkMza3Uy/9yz+HyKQgw+QQU4eKd8X5aXuGTopuEK4HJvlnLB6gU3pFs0
         ZW0VE156ZP9Gh/3qR3at1ntWKwCGfgZX1WqMYa7T8hYkunOJEuxR7nuFNBFUSQABFpOS
         zJid/Bnx5lNv/XKLuB54iD0X2rTuuR3+MYZ/MS+Ffzi3wpq4FIURiXtwrLrPA9sihHTj
         jHt4NgUTSz9SlHcl2y7peMZ40YbqQCPckhCHDv7kgFVwsQUQIVUW7F5/voCTnMlvgm3Q
         9IClWU2wuUfHE3TaG5m3ngnnwMugZpBy7TkdIAg4LyqmSPN6QFa5CPNyrtlwx7WYGxGJ
         8NkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965378; x=1784570178;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/wrHcKHA68TkDcKIgsJLD5FCo0DNb4FA5MINQ+2Q20=;
        b=k7RafGGhrxoiJgmviAUPLIPolwzze7Ijs9xWkZhDCyWIO8r1sSbqP6DNTkWa/nov+3
         6oIKM7n75+vdnccEzY43oE1GcmaTt/MRftytQmDGP3wPYlk60E+RgxkmSdBwaOSEklff
         EtoLAl+Tu1e1FoFAc/Wg0yqg73UuuinLM9U7jjLMs9oifMj2Q+9GN0reHHio/HCIoYwN
         TVGov+0O9qtt4eZ/H+nmtJFsmYv+4hQjuqJ+bEnXxyz51ABEvt+RyB+Bn3QaJp4GNOJB
         0og8Xedtu36FLxIjsvF5v6p+G33TxmNdBHlmlA4M+shBDQqMEl19fZrfnDyPEJkZro+w
         bYLA==
X-Forwarded-Encrypted: i=1; AHgh+RqUobw6oNSq9cxGiKLZExdZ4mOhVkVYO6qIksve3SoeCphmMue/zSTWlZ06vWT5FCVzhS58llrWxfNi6XQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyDbx46WHNKsw6AhzLomhiYUJ1kdjmRY/lfkCi+gXla6OSQPiAN
	C5a63tPHJIZ2YjHgaxRvqgeK3xJQ/XxN0oKatcNdVxAfO4Vcd2lPDjmV7QcEap2W5CE=
X-Gm-Gg: AfdE7clLx08BHMRMlpqcSrUpBPGtVbUfDq7+0UH8baerATiF9ymoF/s1MaW1XmYYQ0R
	4R/f0dRJEFo5DAn0cVkt+gG9QggEQ/QA+lhvC7mb7QrGid1DNMzqypprfdXWUCRHSsveLVVOABs
	dnSqGhV5g/s/9QuCbTa7YVGxN4tlfdYzdANCDiW1gEGc7FglCqX03WTMaS7XISSJQbFfZ89SVkQ
	w+6D2VwL5vk+VjzaBIx+i1p/e81HinKEn9dxpVmZkNBN4BwTD9gP0I8/rQcABy7TsS2F0k4OgKS
	e/ig0m88g5VwBqDnK3LQmBeyceZ5nCBhVppyatC1aoiMGfbR7zJ2Dp050cjU2DNVaIvIUQGPY6m
	87C6LfevCzMmrexF+6XB6asvnq0pEwJPTDYKQk3jpovRRUdE+C0VPoTytgH3c
X-Received: by 2002:ac8:584d:0:b0:51a:8945:3141 with SMTP id d75a77b69052e-51cbf1faa3dmr98217881cf.55.1783965378189;
        Mon, 13 Jul 2026 10:56:18 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf5f61csm91065131cf.22.2026.07.13.10.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:56:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjKt6-0000000Dx9V-2ddz;
	Mon, 13 Jul 2026 14:56:16 -0300
Date: Mon, 13 Jul 2026 14:56:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
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
Subject: Re: [PATCH v7 11/22] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260713175616.GJ3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-12-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260701054926.825925-12-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:15AM +0530, Aneesh Kumar K.V (Arm) wrote:
> -static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
> +static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
>  			      gfp_t gfp)
>  {
>  	unsigned int order;
> @@ -114,14 +120,17 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
>  	 * shrink so no re-encryption occurs in dma_direct_free().
>  	 */
> -	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
> -				   1 << order);
> -	if (ret) {
> -		leak_pages = true;
> -		goto remove_mapping;
> +	if (dma_pool->cc_shared) {
> +		ret = set_memory_decrypted((unsigned long)page_to_virt(page),
> +					   1 << order);
> +		if (ret) {
> +			leak_pages = true;
> +			goto remove_mapping;
> +		}
>  	}
> -	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
> -				pool_size, NUMA_NO_NODE);
> +
> +	ret = gen_pool_add_virt(dma_pool->pool, (unsigned long)addr,
> +				page_to_phys(page), pool_size, NUMA_NO_NODE);
>  	if (ret)
>  		goto encrypt_mapping;
>  
> @@ -129,12 +138,10 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  	return 0;
>  
>  encrypt_mapping:
> -	ret = set_memory_encrypted((unsigned long)page_to_virt(page),
> -				   1 << order);
> -	if (WARN_ON_ONCE(ret)) {
> -		/* Decrypt succeeded but encrypt failed, purposely leak */
> +	if (dma_pool->cc_shared &&
> +	    set_memory_encrypted((unsigned long)page_to_virt(page), 1 << order))
>  		leak_pages = true;
> -	}
> +

Was it intentional to remove the WARN_ON and comment ?

Jason

