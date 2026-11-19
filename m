Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF537606A324
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qkcEXJc6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVctd1WW8z2xnS;
	Thu, 19 Nov 2026 23:18:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1231"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795090681;
	cv=none; b=UZnjtNakxOXnuzAyEWB6O+dupEzXRVbuR7w53uWG+gSDhX/Q2zQ0HiNFBukbyBrSdIcnVC25527p6afakK5CNkDpzuWDO4N5SGJnV7w2JZRi1jubMwkxtJ905xgM0LBSRm1FR1PpF0zvUZPeN3+GRWclY6+J0JGSCfNuL/qbvnY6fzwEBRghOmY7zSV0Msy17jmZmUpNlHXiQmV9JeXVqk7bQGvzJhPpusujh6A5rMnY9eN8eA4x3Ohzk9qgFj+EoXnVI+iDACMgksFtOo9s8fhD1NC1bYashP2aQC6I/CqR5sqQxk2+GX3IPU2aRKg32rNYsavq21e+oEE0SCNtKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795090681; c=relaxed/relaxed;
	bh=SsWTDqy6U/s3LdSWkLHVQ7n4MxNSxrVjauJtJeDqFQI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=NpRqfHslWVJtdOJVI6uTNYoYpsfOP9Lh18JJymFyj6JuKE/tAGNgJ9opC6CCWNf+uOD66432h5t43yUoxsWpp8uaSPF7g6ty07K5oJW1/iPSmeS6H5/JM6mhTxqhdVAdf/x7TsvLoA6wXOBEKkIouKJTjFckgKO+gIu6ynoGOyIWy0Tmz7eSDpKmBUrJA4yPe+mYoo+P0aJ4v5TeKTQ0L5v/z/5gYR8H8kx+Y+gMQpNkR4/1+Ri65DOBYJBUfTkpmJAsxqcYyt46VItQAgoZJzhBXwDGEBHvMq6BIlvASkiGVBoO9V+o/G2zdka+e3oTZQBy+YnxENDoUl/OKnCHUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qkcEXJc6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qkcEXJc6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1231.google.com (mail-dl1-x1231.google.com [IPv6:2607:f8b0:4864:20::1231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVctb4xfgz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 23:17:58 +1100 (AEDT)
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso2738277c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 04:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795090676; x=1795695476; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SsWTDqy6U/s3LdSWkLHVQ7n4MxNSxrVjauJtJeDqFQI=;
        b=qkcEXJc6msKdB0CGikfz0duo3zfOBAoYRgsREsSuAT+cI6P405HN2XFf1O/sFtL+D1
         ueiOPNDhB7dXqGeCZJlG2i08W9K7502Wa0h9Q50nG+Ppb3Ud4jttgbPOQ75NkNGikLst
         4SOxQgeisKY8X0W+1ctb/hY7nZkQy0EEVLJdebXs/CEarPjmUBD+0xFEGLK1UVD7NR9W
         FoIZh0f1TAfSwoNxXWKr8ka5gJ16ctWMoGullggft9xJuUbXbzvOFCU722yAh22u3nA1
         XHUhgVcV4qffwxjDqtoMtUezK89MycMJGdvsigcD0ZV+WUuKGI7+cLrOAt8VH1Cqz/Ey
         iDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795090676; x=1795695476;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SsWTDqy6U/s3LdSWkLHVQ7n4MxNSxrVjauJtJeDqFQI=;
        b=TBf4QbHZR+ncu7XL20anm2ZE8k8RGtoCEQX9r0Cn7VCK2P0ehOftDonRNdgyjwx75m
         lx5yUoehUwg7HJ0eddQmm7w/WxnQW20AyXx23JTHSELEtX/AQl64vmoJ0jTw7jXq4PkA
         CyqLSd1ViHuXII3mGNYXKLaH0qsSMJ18OWF9ZTv+Fwm/hIHyo7uZ+oMKVURCa5agUtoC
         2d7zyc8wgigii4L0E3HLUg5R530zYankknHSFGsmauRvY4WwVnq2pn9Axj5GvqpHH1X6
         K8dAPl8Yb55FzOl4Y9tieTadBPiHT7D4MjofgzCsv6sRxyxCeCbUM1AQIQnu4UCt640V
         qiWQ==
X-Forwarded-Encrypted: i=1; AL+hErGnHcQSQ6oHtk+leu7wAUh0Z7dCw222soRq3vRPRSssgYyad0W9uEkHOrFQFpCk4ABV+D9gxfWqDDzdGZ8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+JIEbRAEVhmRC/5vlCZd5DWoH3SoW/uFBjv0/+crl1e4o7dAIH
	Qay4h9As62hMG+OJa1e+o2j9669LMbLgawS0YMXrWpYlz+R0IR9DApBL
X-Gm-Gg: AZFdTZdummUzA+yrBoAU/MAfAAlk/CuHPnHoRtPcXbYDyDbUeJP77CJwIPUnZsneqEX
	6TFCPnxbYjdxMv4f6l2eGbzUib7sD08+xJY8Aylg7iAbdDQEsHN33CYjxiIWoCBF+mP4Lr+0y6F
	Ukz/Q86O5r8eSuTfkru7//wiFa48KvUhxEK/jCgEGExu+UULke4r51NPnBq/KiCXrG0KMn+GbVZ
	FUty/tQ4EEIVdCjCdRta2Hl0uhkpxQ9omuPEdA8Lo3d5t1p/KHVkBmdTokz+KCOOilyqrtRFilo
	VZaU6z8HPtllx8m0ttFRj+sTJy9p6AIo/lSj6Js05h7+b+DKBJscMory9FmZkgvj6RU14tVrcy+
	WsM1AGBj/8f1rHbBDxcZ0WzUAJQt/hZ1QRllkCYCtId53gJp040cjCWaBjVu/losAamhNxK+nZE
	L9WJjgoXKq7fAt6cj2OE34o9HugNypMBpXH798o0yJXKSgK9cAwqiiI6wGyjLfU8hs2mEYtyOPK
	cvOg6hIBfJ6TCpEq5L+vnwdIKZ8BmvT4SdHI9P+IJuLNzblDjqYoZltT1dqyIXvVZByYzT84eRZ
	dPgIGOX6rlJK73yh6TL8t5TilSPq/oBUhE0az+R96wvX0yDr3w==
X-Received: by 2002:a05:7300:1c9c:b0:361:1dd6:531b with SMTP id 5a478bee46e88-38281025c89mr5440546eec.26.1795090675937;
        Thu, 19 Nov 2026 04:17:55 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a80bc19bsm17656695eec.29.2026.11.19.04.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:17:54 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 4/7] powerpc/mm: handle highmem pages in arch_dma_prep_coherent()
In-Reply-To: <20261110094830.2081847-5-m.szyprowski@samsung.com>
Date: Thu, 19 Nov 2026 17:37:02 +0530
Message-ID: <jym96n4p.ritesh.list@gmail.com>
References: <20261110094830.2081847-1-m.szyprowski@samsung.com> <CGME20261110094850eucas1p1f10fa1473aca341473077f60a088b490@eucas1p1.samsung.com> <20261110094830.2081847-5-m.szyprowski@samsung.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> arch_dma_prep_coherent() performs the cache maintenance on the address
> returned by page_address(). On 32-bit powerpc with CONFIG_HIGHMEM that
> is NULL for a highmem page which is not kmapped, so the flush would
> operate on the wrong virtual range and leave the dirty lines of the
> buffer in place.
>
> The generic DMA code may pass highmem pages to this hook:
> dma_direct_alloc() handles a highmem page returned by
> dma_alloc_contiguous() by forcing the remap path, which calls
> arch_dma_prep_coherent() on that page before creating the uncached
> mapping. This cannot happen on powerpc today only because it does not
> select HAVE_DMA_CONTIGUOUS, so dma-direct never gets a highmem page
> there, but nothing in the hook's contract rules it out.
>
> Use __dma_sync_page() with DMA_BIDIRECTIONAL, which the
> arch_sync_dma_for_*() hooks already use and which kmaps highmem pages
> one at a time. Without CONFIG_HIGHMEM it does the same
> flush_dcache_range() on the linear mapping as before.
>

Does that mean, this change can add additional overhead for
CONFIG_HIGHMEM=y kernels, where the buffer received still belongs to
lowmem? (Because of extra per-page book keeping like
local_irq_save/restore, kmap_xxx). Thoughts?

Although functionally the change looks correct to me. But maybe
__dma_sync_page() on powerpc side could use some cleanups (outside of
this patch series perhaps).


-ritesh

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/powerpc/mm/dma-noncoherent.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
> index 30260b5d146d..e646256365d5 100644
> --- a/arch/powerpc/mm/dma-noncoherent.c
> +++ b/arch/powerpc/mm/dma-noncoherent.c
> @@ -118,7 +118,5 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
>  
>  void arch_dma_prep_coherent(struct page *page, size_t size)
>  {
> -	unsigned long kaddr = (unsigned long)page_address(page);
> -
> -	flush_dcache_range(kaddr, kaddr + size);
> +	__dma_sync_page(page_to_phys(page), size, DMA_BIDIRECTIONAL);
>  }
> -- 
> 2.43.0

