Return-Path: <linuxppc-dev+bounces-24131-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459E3C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 18:48:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzWfR44nnz2xwN;
	Tue, 14 Jul 2026 04:48:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f2e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783968495;
	cv=none; b=DoRswkpJuAVUncUXIe4i6bAfdSaF6KGkv9w2Ji/cPnDNvTPOLn/Pzf8y9Y0q/GbTCPeMgFIq6tlmCzcfuZDR2AK5a91eb3bHQgVoU2HPi0VcM+vryCO0F9R5yn3T3e4MF7FsH6pspF5aD3Q0RkgXMX6D+WNIgP1RgkQmFJsdiVvrq/xe51WPoxM84WlU8iTqjftfTUhBa5PIPav5ShCOdtwoplob5QRKA8ZbPOiggk4OqpXdilAyUNODE9ii7FQyp1D2w8ktsRqyKImqADK1xser1WbkzcruhCNKgLFfMFOkyfgu5OGFrE2Btlz1F3MrB3u7PWz14OxJIQTUMBeIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783968495; c=relaxed/relaxed;
	bh=+4oaM697jjJh0i29DhT77Bw1lzVGGZ7UjxKZh4sSss8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqP/groC22erP5VhbSourXnBxUDzN9djynja6bw/diOMPWGGomnPuIcHf1ZmkmjTGdFqgH8uhyseRxSNqAW1o6yPzR/LEG0IeyfFidkW7JNpWTcSG7qrpB5LSgTJ+5D8uw6/r047jnBUh+oTdUeOxuXo50O/+dGP9WSwb7xtG3KQqDmzu0R+9zkcWYxrzRX7jy5bbNg4jx5AUMj/K3WUetg14t27FEIVpMy/i34xhDnjBla4fD4qkw+H+DzKtMLF/Z35nj0ZNBBtWV15vAGlQtRaqAY72aKJLFRB9dLPHd/vQI2TzzxFA7p4Z6aW4ox2Liimt/GhFNWmGy8coXW0pQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=kA8v2e6U; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2e; helo=mail-qv1-xf2e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=kA8v2e6U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f2e; helo=mail-qv1-xf2e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzWfQ2Dvbz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 04:48:13 +1000 (AEST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-9030f8ea3b3so29849436d6.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 11:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783968491; x=1784573291; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4oaM697jjJh0i29DhT77Bw1lzVGGZ7UjxKZh4sSss8=;
        b=kA8v2e6UYbbttWecj9EpDEj773iPR2PWL+5kZWdM5cj5xI742oSIYdI4We/vkfHhkr
         GW5U4aF8mZnqSTYix6fW8QQ+jYwpJpmoC4GITmHJBiVj/ZS0SUmtyNdYTsWnuBKD3u+X
         M94fmA3twz4CloP+Mz/09a+m3eYfJMxrypARcXTTnlbf7ufUkGjLEBEBCLQQ3CrLCiMm
         SvSoR0J3EsUsATXbcHMKTnlMkumtIMMt7LIs6J1PDqaRJjCHJQL+2mnfZH3sDYFcjRoA
         cjBZRIFibjaVZlaDpBrurGrKNq050FH48tLZazDhsFoEnzBnb34uAew5F3gQ7OYeDBvG
         Sk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783968491; x=1784573291;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4oaM697jjJh0i29DhT77Bw1lzVGGZ7UjxKZh4sSss8=;
        b=iN89KqoketLuHh6ybhoGe5oUv3c/wQxORauIHGW7BTWWBU7fKlnJPNcLXoy8MYOeJH
         hKsvNgA6sEKJHnFOhCUucS+HXYn3MKe4bluuFKSRRtejpPU7W8Cz8FHv4XV4XaN1fXrQ
         cWjDohmAni2mCPKPiYX9yrZN5z/84ygfwbRPoKr15GS4e8inQzZWz3yoJW1a6uoCDBPc
         aADT/qlb/UbZZUZn8o7tWXwZ3o5cwuWApL0h+U/EjvNHNw9W+MqfWvjFcG5QIWzl3SBx
         tmUsj+S9Y6QLh4AndzA3sQo+3lziiH0dUuEUvnNbvyBrItetQOdbmWJ93HS5fVHixSOy
         VyxA==
X-Forwarded-Encrypted: i=1; AHgh+RrRhSXZNQ0id+ppwQWi+PzCgKjmY/Hpmn2o2XugTQhVbaMtCAPt3nslN7W8eDqw7/d37UpEV0hcG5NM6rQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzy/HI84uFw7BJcQWlTZmqQm2PDwMzgbTM3GP9IrIuNWquWeP1s
	N0ldx0Mcu7TGBw/Ozn7rISvMF2qClOJe/RePaB9u1OrcYn7RY6AzmJWHh6h+148dMWN1m9lD1KP
	ztyFN
X-Gm-Gg: AfdE7cmFjSvMEXLs36wfrb+dc0bG+1DZxnMtKRbftavwZdi6gdEJ5PefeGuZymd6HoO
	ha61aSP9J4pptFlNrMFwoouzNOZkN8iXowlwZTnZimnBIzYV40DrGbU9xApzcU5mc1IFfrs9PI+
	ZB6eCRpOlkQ5lEoOaRp0pL32EMxPnhjYP+eDW/+66Vu+yPon5GmUY/fLazhH147i3T/ex5kN2m+
	vO3/As9+TagKfhkrLis3WiijVJQ5sX5VmcJOQQlCMGP0mrEMqGp8WRruMSm6oGFvfaV25T6ttsH
	BnFbGVUWnYcyd80ka7B/bOiaUrRt458mNW+LHTRC2L9nvxTw4+sZhJFvwfQGFRjTOfT12JLqr+f
	zp77uEYR87XDkB+60fTtxdV+eWpNRIqBRMPik6sYtt317lbYyH8J1HMGK49gtK1dEjq7cQGo=
X-Received: by 2002:a05:6214:e8c:b0:904:49fa:3085 with SMTP id 6a1803df08f44-90449fa364dmr123814316d6.18.1783968491378;
        Mon, 13 Jul 2026 11:48:11 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd82e8ffdsm139962266d6.37.2026.07.13.11.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 11:48:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjLhK-0000000E1oE-0kyB;
	Mon, 13 Jul 2026 15:48:10 -0300
Date: Mon, 13 Jul 2026 15:48:10 -0300
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
Message-ID: <20260713184810.GM3133966@ziepe.ca>
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

This makes the memory_decrypted conditional, but it doesn't change
the lines a few above:

	addr = dma_common_contiguous_remap(page, pool_size,
			pgprot_decrypted(pgprot_dmacoherent(PAGE_KERNEL)),
                            ^^^^^^^^^^^^
			__builtin_return_address(0));
	if (!addr)
		goto free_page;

It is wrong to pass pgprot_decrypted() to the arch code if
set_memory_decrypted() was not called.

Also it looks at some point the nature of the atomic pool has become
confused. Originally it was just to allocate atomic memory that had
been vmap'd outside the atomic context (to set the non-coherent
pgprot), so every caller was expecting non-cached memory.

Then it was reused to also allocate CC shared memory outside the
atomic context. That was fine for x86 that doesn't use DMA_REMAP but
on ARM64 it now means all atomic pool CC memory is uncached? That
doesn't seem to make any sense...

I suppose along the lines of this patch the solution is to add a
noncoherent property to the pool so we can select the correct
combination:

 noncoherent !SHARED = vmap pgprot_noncached
!noncoherent  SHARED= vmap pgprot_decrypted + set_memory_decrypted
 noncoherent  SHARED = (probably unrealistic in real systems)
!noncoherent !SHARED = normal __dma_direct_alloc_pages()

But I don't view this as that important, the CC hypervisor is probably
going to use the S2 page table to force cachable on all system memory
so the non-cached pgprot is a NOP, but the extra vmap is wasteful and
it is confusing.. So maybe a little fixme is all that is needed here.

Jason

