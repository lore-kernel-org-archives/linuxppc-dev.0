Return-Path: <linuxppc-dev+bounces-21175-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC0CCD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 16:11:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKfmr6gCYz3bqQ;
	Wed, 20 May 2026 02:11:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b12a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779207084;
	cv=none; b=djq5N7NesavVV1lIu88X8JT7qICbKaCT7unwAuaV46jwtwhmpzHNa51KQu2x45JpLqIACa00gnM3/p05v5VtQ/C+g+cx+GlmL4e0LZV2KA3VsSMwRZRfPsGB/dWq3c1piZBDG9ZRMbkt+ZTV87LkIr9T2HzFpSgNAolJw6+16mFnbtV/2vmzLFl7qsNf7ZDVS0ykWfbl7BMIs+kbFuKo+Tr0RVJJQUO8py4XEulA54q7/1b0BmWCga7UMcmDKgsllb31hjxoQbzSde84vq9vivqznnlftb/43ozkKC7bODLJG1oEZx9agkhOk5b+RPHba/tsImmudpxUV/EsPXHArA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779207084; c=relaxed/relaxed;
	bh=UcSuL4+fBcC8SeCa+tlTSs00pii8MZZ+rCZs+NXP3JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZEbP/g2yJ0MsskGuxqNk7r4o8m0lkduzUY2hOyxTo1muFfPnhdXpT+u442G1ks8HR0+OoIJBEYIJRnZ0u4vsnLr9YxIAmVN8xaaz4DrPPRb3Wg1cEMKTt2MQV0WViGVFu623dzFdi3FsZWvJgQfHW1H7pyQWs4oZMleLbUUq9rxaGrt2MZTXD3uJVz7Rp+t4mB3tC7GXkszgZP4HKtvd+juPfImIq6EyctRuu2OKEvf/Hw+t+ojDQTsVuyyZUm4ZC+mfX6jtlwiINloOQtv6XBmLLmQSz98362Y9dA3dZgxHLyIJGF0p1NT8MhmiXRlJH6xQ7jbD7vf4O/QYiY2hw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=M73slNWC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12a; helo=mail-yx1-xb12a.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=M73slNWC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::b12a; helo=mail-yx1-xb12a.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com [IPv6:2607:f8b0:4864:20::b12a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKfmr17w6z30GG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 02:11:24 +1000 (AEST)
Received: by mail-yx1-xb12a.google.com with SMTP id 956f58d0204a3-65c21049dafso3319132d50.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779207082; x=1779811882; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UcSuL4+fBcC8SeCa+tlTSs00pii8MZZ+rCZs+NXP3JM=;
        b=M73slNWCDb0cQ0gwVj1/v9mPwVJg4L3MARdVGKFeLs/E1So3NnJZekE4atYu+ooFo9
         TlH5CUuGD3TPoNJAT9wRnUUe5srpA284vxsJjff7a7O1wWWanH10QGvlqu+OZzoI7u3a
         BbNPZaVbgWaZNOgeZOW7+D/0U94KzuW+4vLCeYMBYWerWgGYZXu0vJm17TBv6sTtogYp
         CytRy4x0gAvtNLS84Jn8fPl2ZoWg2RJwFZV/jBsqQ6ZirdL2xCC4XIPbz/6zGS7O2K6w
         T4YwETPXkM+vGIS5fSulfpY6eptaEgvda9OZB7XENKlth7HRc7rQxxcsdWCbAZeVhL1x
         tzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207082; x=1779811882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcSuL4+fBcC8SeCa+tlTSs00pii8MZZ+rCZs+NXP3JM=;
        b=bLiwaS17+WyO7dnADeXoN5Kh2tXTtDkU9mW32qD+GwGyY0rDCcp1lEvCEnvVysXoyk
         0lfADih1rMX62ooIenvHp3t62l9zey8WhwTNw4rTa1GmBMKwGou3Wh897eftNIUIMnsE
         KnFS+1Dw/nRqgi0p6BCntSZEiSrc446/iLg0+VKSV1UvsuH9nTFor6TI+165wbm4gLj5
         xFpdoVyHATl7jjupAh0l/7EuWf4xZH1Hg9OWfKntUwUgqTNfWAqQbFmGqDawqHWw2ZBA
         xGLZlu942bGgsso+lsrZ5BpOcaBmaX7FqWWkIPem6Hm6QL77V4LZzuJE0jrCGZyIt9hc
         EuUA==
X-Forwarded-Encrypted: i=1; AFNElJ8Wv2u3iGBcWkM00nDcE3jvNjXXTfu2HhapfLvpe5RnOn2iSp3bkUlRSiGqMZ6bWnrRbewsf2hih4ZnX7U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxLQ0OMFVKSeCYtfAGxdtHc08YuKNvujZof7cl0g/RN4ntdZSWZ
	/78ipQufthApCIUWuhEkAjoidxfCacy5MVoLV1drFvZv7qJhNpq3kwtk2jL+WRcMK58=
X-Gm-Gg: Acq92OHZxde4he4WRRyfs2lgQXhh5p2Mks4RqQh3g/OIskyRGgTZpCHAar6EQj7I+9T
	e5PvpIrEpkISy4wJlAo07zgEQkXvr2/hN/4SkdpW3v2zsSrqlYlnBgqT4S0ox3xI4F8HHwq5XyV
	Arlbg2HhjRWp79Z8damzTU3pu4AgbW8ZnMB44WONXx8eXpYTD/b5tpYK0oadIbu5Y7Dn4ZDUE/C
	w6TgepD4oNqdfP8YG7MZImV7adfN6PhFLSpUQMnMzl15ZufhXHZOtkWD/4UstnilOT09vROLBEZ
	BqwC3kMc/k+0lTij5evAT/yb3i8sPnJTzfNuO6E2O9wySTEEjzXjkwJPC9ZiHxBGpNE/2o1a3kO
	CKTJ08IFaZdhHqUOqZcuOJPJxQg0DRikl/gr/l9a5WhCCwRxAcAuaPvvdQoC0AaxVJg/LHeWYIW
	MVGghJ7tvrkDydb9x3NIG1gT7VnBj89K5/fDX2PwQV1z1VRBNRKCcZWiYa+hfunfnq+956+sIuf
	nPx3Q==
X-Received: by 2002:a05:690e:148b:b0:65e:18a4:3021 with SMTP id 956f58d0204a3-65e22839e72mr21408719d50.52.1779207081601;
        Tue, 19 May 2026 09:11:21 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36086a61sm95500586d6.4.2026.05.19.09.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:11:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPN2O-0000000FGo6-1YPM;
	Tue, 19 May 2026 13:11:20 -0300
Date: Tue, 19 May 2026 13:11:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20260519161120.GO7702@ziepe.ca>
References: <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <yq5amrxvshxg.fsf@kernel.org>
 <yq5abjebsaid.fsf@kernel.org>
 <20260519152741.GM7702@ziepe.ca>
 <yq5a8q9fs7ud.fsf@kernel.org>
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
In-Reply-To: <yq5a8q9fs7ud.fsf@kernel.org>

On Tue, May 19, 2026 at 09:35:30PM +0530, Aneesh Kumar K.V wrote:
> Yes, that also resulted in simpler and cleaner code.
> 
> swiotlb_tbl_map_single
> 	/*
> 	 * If the physical address is encrypted but the device requires
> 	 * decrypted DMA, use a decrypted io_tlb_mem and update the
> 	 * attributes so the caller knows that a decrypted io_tlb_mem
> 	 * was used.
> 	 */
> 	if (!(*attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
> 		*attrs |= DMA_ATTR_CC_SHARED;
> 
> 	if (mem->unencrypted != !!(*attrs & DMA_ATTR_CC_SHARED))
> 		return (phys_addr_t)DMA_MAPPING_ERROR;

Yeah, exactly that is so much clearer now that the mem->unecrypted is
tied directly.

That logic is reversed though, the incoming ATTR_CC doesn't matter for
swiotlb, that is just the source of the memcpy.

/* swiotlb pool is incorrect for this device */
if (mem->unencrypted != force_dma_unencrypted(dev))
    return (phys_addr_t)DMA_MAPPING_ERROR;

/* Force attrs to match the kind of memory in the pool */
if (mem->unencrypted)
     *attrs |= DMA_ATTR_CC_SHARED;
else
     *attrs &= ~DMA_ATTR_CC_SHARED;


Attrs should be forced to whatever memory swiotlb selected.

Jason

