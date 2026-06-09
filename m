Return-Path: <linuxppc-dev+bounces-22328-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885C5CD8CA4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 12:54:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZTQS06XLz2xll;
	Tue, 09 Jun 2026 22:54:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781009695;
	cv=none; b=Wm3ffjwG/abJrmKNxG7NbF4koK+T2mgezHN1CUu2FnnzbxVdKZhbtuo5JDP9y4afl8ojl+8l9EJUbzuV1T3bF6/qDuh3r9CsaOh2l4ldKsYlaa3Paczxm4I1vIt8lRc9B6FVLnNKME5o1b14IWfx4JopWgXdgtUGo6eb0NWbf2RX29oQO7rYeTQFRUr/CIuSYa+VUu3ZczSpRU/WbFMtRVITJ6IjeFaHAHUgH1UuRfsas48Wjw17hUtTIP94NDEka2DR7eMXjAndCrgYcAeRF9kzaLsUV1TvFMzm7oXhEwUeshJDjUGkY+LdX5DFiWRZ3l2odYeC1BksCMsm70ZaCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781009695; c=relaxed/relaxed;
	bh=vkYHspRdfakTgJWTmfOhWR71X/NTXsb3/ZhoDPOxGQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTBqrbPetHYTadaxoh2ugGgkyM1iNNK076VrkFJ2UNza3sR3R9E9LSLHgvzyw7GcFQvLoC5C9AjarO0DzsIwFhL51u3leQ3+zdc+P4zGg1Ef8M1UvR+StDZt0ntm/69n7r4gOKyt9gLFaFhpMFVl1RyBIPYJ0aMsdBN+jEPXtCdSUe2Pyp3jKYDihUWlHMZNoCgvZ+3l9g5TfUUQUptjx67ma0S3X93AMqPmkREJIHAK4uxWHN99GogHWoiYdqFKhB6NNc7FKUgodN9kpLUmQinxys+pNiPMw8P67xJKUlvg5eZEhdPXKf0AvWlqUYgt8TBwsz75w7+u6epf0v6RZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ISajn7WL; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ISajn7WL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZTQQ4vH4z2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 22:54:54 +1000 (AEST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-45ef93a0b0fso364214f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 05:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781009691; x=1781614491; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkYHspRdfakTgJWTmfOhWR71X/NTXsb3/ZhoDPOxGQs=;
        b=ISajn7WLdmXTmaMn151e+DZ/pWtZPpYJrA5HbFLNZw3RUZkekPh4f/FLc/gm6VmSY/
         b4p2kVRnBnDgYJVniekmMyvCYThKO0L8IuHBtVdlRD9G1fCRc4G11argoo35yuW/AYT4
         52r57+kkwD+WKxIwRAXquix9kmsiBw7tuFzZW0RYfaKSYwUf+odrJ/sMv6PymC7RwAHS
         s3SXCmuuQHOmWBXiRuWcU3ZI8cyvRnVET1dNgnzB27vHCKic7dOKxGZUHK6W3QDm0H37
         JNsj0YHTdHvKiN0kc8EJyWTslYg+qx1/hptH+bNy8yh1fV13inoT6GKn+c3ODYQIA8Tl
         oYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781009691; x=1781614491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vkYHspRdfakTgJWTmfOhWR71X/NTXsb3/ZhoDPOxGQs=;
        b=rpqLCRJl1eMMyG8ghMdB8UUWX4doPz49shUXDM94S6X32yRVWAM0D6lP9DO2Et3rTb
         7O9zADMiYfh4crr2cepyrOIVNzsKkJ/z1TRyMLnfnFwZYwU8t2e2lFk3OFo3pxbrT9dv
         EkoERbSVCFItm0n6dwhtK1BusPk0R6Si8F2j25VunUQekqzWMtqrrwEzhPszxdxnabWQ
         RFqWIc7l4BxQnFM0WN5Uf6Oc7oi/7vWcyWynfojcB5HZ4JCvgutL5Tw9gmBewRqQiAIb
         RGxmBXXGEW4Xm5BoN8G4euqnIY8W5s7e8BzyZuM7BmpplAGtwLVlNDCkD8tDcO/aP98q
         9Psw==
X-Forwarded-Encrypted: i=1; AFNElJ9erPMC9NW/+VrUyMueRObOKwrOgGcm7IBYkzCyRjUabVe6wl5ZfGerZ3b4S/vZUv0qxMBcL6s7ZBynJEE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxP5HorkXy/563In2aXvTCTCLhEoutcB0wBYaMiJYqDyEZzH8Zb
	LO1x7w2DDHSOW2RDH/5Z4Xv20HnLY6ylDE3uR8Ed8Yih7D0P2l/CAVIzZeQ6aYEDabk=
X-Gm-Gg: Acq92OEjv2OCSiXkfKNtyo875LyPYTQ2cZND4ANBSZIcnPYu6a36mbgvmhe02p3uWkC
	XPRbcuv6n9AoWqwlQGOMOsuGbEIJpBxqIUJMOOyUKP81PXlEboaaEO4wcEX2zTsYg8BIW8lVLy0
	JkAZDYK8UaM3RqYGRNKOJS5EXCtOTkvDzjCTh8xkXb2uhLl4TRljfPfRHSjXW81SKo0XrQ+4v+7
	sqnfTdGYImP70yu2zrjdw3xzFbPQNW6ee1EcLcaMJgl5449Ro2dQadfP7SVhIOKHrjLEmYv8FlJ
	ctw7+xkxiHMzu+6Pi1b4dWaMtXKOS654P7sBflQwQTp2HL9Y5DMtDm7peU7HMcOa3EfbLCDkWsY
	+9uxZM5VMagZEJteprddXjHvOqA7vFZDITrMyAvrFlVBFws84Vl8d/1dIRLadRiKSaYkxVozCJW
	EuiazkSrWBisZBRlIHHlc9P9I=
X-Received: by 2002:a05:6000:4a02:b0:45e:ced1:19c1 with SMTP id ffacd0b85a97d-4603063eee7mr14300728f8f.3.1781009690891;
        Tue, 09 Jun 2026 05:54:50 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc577sm63402978f8f.3.2026.06.09.05.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 05:54:50 -0700 (PDT)
Date: Tue, 9 Jun 2026 14:54:45 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Will
 Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price
 <steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Alexey
 Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
 Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, x86@kernel.org, Michael Kelley
 <mhklinux@outlook.com>
Subject: Re: [PATCH v6 13/20] dma-direct: rename ret to cpu_addr in alloc
 helpers
Message-ID: <20260609145445.6144add4@mordecai>
In-Reply-To: <20260604083959.1265923-14-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-14-aneesh.kumar@kernel.org>
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

On Thu,  4 Jun 2026 14:09:52 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> ret in dma_direct_alloc() and dma_direct_alloc_pages() holds the returned
> CPU mapping, not a generic return value. Rename it to cpu_addr and update
> the remaining uses to match.
> 
> This makes the allocation paths easier to follow and keeps the local naming
> consistent with what the variable actually represents.
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

I wondered if cpu_addr is descriptive enough (a CPU address could
theoretically be virtual or physical), but I can see that a few other
places already use cpu_addr to hold virtual addresses, so yeah, let's
keep this name.

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> ---
>  kernel/dma/direct.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index aa3489aa10a0..4e446aa4130e 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -204,7 +204,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	bool mark_mem_decrypt = false;
>  	bool allow_highmem = true;
>  	struct page *page;
> -	void *ret;
> +	void *cpu_addr;
>  
>  	/*
>  	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
> @@ -318,34 +318,33 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  		arch_dma_prep_coherent(page, size);
>  
>  		/* create a coherent mapping */
> -		ret = dma_common_contiguous_remap(page, size, prot,
> -				__builtin_return_address(0));
> -		if (!ret)
> +		cpu_addr = dma_common_contiguous_remap(page, size, prot,
> +					__builtin_return_address(0));
> +		if (!cpu_addr)
>  			goto out_encrypt_pages;
>  	} else {
> -		ret = page_address(page);
> +		cpu_addr = page_address(page);
>  	}
>  
> -	memset(ret, 0, size);
> +	memset(cpu_addr, 0, size);
>  
>  	if (set_uncached) {
>  		void *uncached_cpu_addr;
>  
>  		arch_dma_prep_coherent(page, size);
> -		uncached_cpu_addr = arch_dma_set_uncached(ret, size);
> +		uncached_cpu_addr = arch_dma_set_uncached(cpu_addr, size);
>  		if (IS_ERR(uncached_cpu_addr))
>  			goto out_free_remap_pages;
> -		ret = uncached_cpu_addr;
> +		cpu_addr = uncached_cpu_addr;
>  	}
>  
>  	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
>  					 !!(attrs & DMA_ATTR_CC_SHARED));
> -	return ret;
> -
> +	return cpu_addr;
>  
>  out_free_remap_pages:
>  	if (remap)
> -		dma_common_free_remap(ret, size);
> +		dma_common_free_remap(cpu_addr, size);
>  
>  out_encrypt_pages:
>  	if (mark_mem_decrypt &&
> @@ -439,7 +438,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  {
>  	unsigned long attrs = 0;
>  	struct page *page;
> -	void *ret;
> +	void *cpu_addr;
>  
>  	if (force_dma_unencrypted(dev))
>  		attrs |= DMA_ATTR_CC_SHARED;
> @@ -453,7 +452,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  		if (!page)
>  			return NULL;
>  
> -		ret = page_address(page);
> +		cpu_addr = page_address(page);
>  		goto setup_page;
>  	}
>  
> @@ -461,11 +460,11 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  	if (!page)
>  		return NULL;
>  
> -	ret = page_address(page);
> -	if ((attrs & DMA_ATTR_CC_SHARED) && dma_set_decrypted(dev, ret, size))
> +	cpu_addr = page_address(page);
> +	if ((attrs & DMA_ATTR_CC_SHARED) && dma_set_decrypted(dev, cpu_addr, size))
>  		goto out_leak_pages;
>  setup_page:
> -	memset(ret, 0, size);
> +	memset(cpu_addr, 0, size);
>  	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
>  					 !!(attrs & DMA_ATTR_CC_SHARED));
>  	return page;


