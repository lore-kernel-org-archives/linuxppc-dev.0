Return-Path: <linuxppc-dev+bounces-28574-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6553CA5FC7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 14:39:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvyPJ5wbfz2y24;
	Thu, 01 Oct 2026 00:39:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:34::d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790779188;
	cv=none; b=ZMMi3OmHK1AeMv0LCezAySwtMab7VtkYVjBw+YAK2ZSYpTqKZNzE8iEXB0NYxjd1Dfz2gPwgIpsB4pvRX72dxevzG3a8eIHw6ncqMugJYTatx4U94UXFGeXOmr1GuUU0GTIRqYmDkP+U2cA0S9jC0GaLIZZ7AtmIaXCWFw5F6nNcV/lGZIHX9tiAgavgrMKV4rDMR0bMwZuDjbZd6nm3INIsbScrPrACrJ4g3VuslRNbojUP7q/N3KBM/eSrDyFyY+ZndoR2t/QXCiD+3EEwzmvqLBIj9tB/J5p0e4coSeX5sDNBLMN0h9RPr2+SlQVuEVVL+AqSuioqyYfyTyrm9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790779188; c=relaxed/relaxed;
	bh=8zIgRBEcUOotWURvolQ5JIFyn/MboxYU1izn9qFVjOk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ve3njpoaNntwpjhhIASzmkmSe6AkjHAUu67wDoMztIvmGunP0iyT406XJvqW6H33Z+nBKAiSku432WBLOYspCzKl/vwPBE53oHIauvUDKEdRd363JYiIdOPYgGQRHSbgcExGg81gIVAPRxl5R2Pax1eFELwqW9xeqe9r9ccGefbAq2/g9Ynw2v7V9cItkteWGgsDqLPnRcZoO0uG/aPiiMFVoLahByZ91qTsuOGVcGfbIG8ZNVopSP8YTs6Yo/3tqr+jsILxrqVbZMrPy/zewhKWtOaSbOH3kIzHr+Wm5Tx/+z6cvEQqhfw1hVZC+j5HvGFUFb0MwNIUv2BxUWc8Tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K6+Rromu; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:34::d; helo=mail-ej2-x0d.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K6+Rromu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:34::d; helo=mail-ej2-x0d.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej2-x0d.google.com (mail-ej2-x0d.google.com [IPv6:2a00:1450:4864:34::d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvyPG4p9Yz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 00:39:45 +1000 (AEST)
Received: by mail-ej2-x0d.google.com with SMTP id a640c23a62f3a-c2dd363f57aso440477766b.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790779177; x=1791383977; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8zIgRBEcUOotWURvolQ5JIFyn/MboxYU1izn9qFVjOk=;
        b=K6+RromuMfI7TBOAE+sSKSKRYsTksRK3nBo4M4CuxVHfO544FSlR9mSDsP/H3jZdno
         d8Y1Xp8YdGMWQ2td5mGDRGnIAGCgg/7bDuVZ8WdjcnUQ9fjU2I1D2y69SmTL7m14xK5I
         ldO6abPjqGdII+YD+7u++7Jah4OIu5kqXoGiitzAHR/b0eGljk3SFz1pZNfcHOptsuvG
         clPnarGMmI1IRvhChBaanLyX1efCS6HxeWjFeOHW3tM7fvrPdYpW1sPToiECqB81PtGU
         TeiEudu0yJSqE34s7u5Za10HUu9nQi+Buh54EiBcLfrngAUfo9wj5/OfMr/PWCs5nYEK
         ZJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790779177; x=1791383977;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8zIgRBEcUOotWURvolQ5JIFyn/MboxYU1izn9qFVjOk=;
        b=2rcwDfciHKEAicJm5YMJulwefmpTQGQBXdMObMKgjVLJIyuTnDlD9uwtIFIaiYxgNl
         mI0OZVLJKkkCid7C8vyS1cGvm++cF11zOVgcTq5rSUKYLzIMnaoFMc2iLSexFXyEA8iD
         Nhh8yKE8eKjW1zvNTMap/rBzUuJMgnq8MzfbWwIgyvehNN94gMgn0xti+3QKG0Z6LAuU
         aXAPu7MI8oBHykhHNshyuDVezzALhTPHnlPmIurUD1dO29GymdpaDYMm47X0+wlkO2Ae
         AJwFXJ42G9G6A0cH20iVfzjUleGjryDwhPHHkBFPHdPMg/7bOLhaPkcCGQmA1mH0BIII
         0P4A==
X-Forwarded-Encrypted: i=1; AKwUvBweK74dmmn5LUrN6hQe2SJ3RvF+yFqQhTKmphLSRwLSyUDONViU8Ay6laUb/0OZHr/186X7oX6Lw4ZkXT4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lrZ0dn+brnBsEsaGjZr39avsYQhYAwFZ2EsPRG4uQakxIQObLU
	FnSxR0RXU5Bvn5vH0G6KAbPWzvz2LPno2g++yc8EIjNS45MuZCNTEKhG
X-Gm-Gg: AYBFou1f/Dmmlq3k94hUdPf6zNcIliq33nqyIufVAx7qgJANIKdCeR38YZV3HwxcxTG
	H987jxv0nwrh//1zZturZXO0zI+wFmiFvRp+/36Zc1JLxTi9Kli/RvKQVpA4LcdPoYXT/crWe2P
	tgNPjsAca3aZheZoCSaLAJpiU2RPTYGxsyJGEn1FiAgtlhk2cWPqDbXumi8lCQGSnwM2NJvP5dD
	iBgWkoxlkMTUmacclURDBRPrJH9O8sPFrI5qlJdi9wuqnYcogDsFxv9aPYnpuJRdE0vSKDnXLvP
	hwHfMhxniPE9g34M1zBqTCOny9ry4bvOzwksGVJ93MCOXaHLbgVc9zpJe8QR+ExMJ/8TmLsRknx
	1oZ2Ai4USxL4PFboiZas4UN/zLc87Eoiv65p3+NTeg7RyU+10WUJw2iDn+egUJ/noUIWMrY27+v
	eTnJovoYWEwSfIvVQwpDQoCdDLwfGfL1oZZg4=
X-Received: by 2002:a17:907:2d24:b0:c29:5172:6151 with SMTP id a640c23a62f3a-c2e23de355amr130161966b.45.1790779177087;
        Wed, 30 Sep 2026 07:39:37 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31cf0d6esm13604766b.37.2026.09.30.07.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:39:36 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 30 Sep 2026 16:39:33 +0200
To: Wen Jiang <jiangwenxiaomi@gmail.com>
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org,
	urezki@gmail.com, will@kernel.org, Xueyuan.chen21@gmail.com,
	ajd@linux.ibm.com, anshuman.khandual@arm.com, baohua@kernel.org,
	chleroy@kernel.org, david@kernel.org, dev.jain@arm.com,
	jiangwen6@xiaomi.com, leo.yan@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, rppt@kernel.org,
	ryan.roberts@arm.com
Subject: Re: [PATCH v9 06/10] mm/vmalloc: extract vmap_set_ptes() to
 consolidate PTE mapping logic
Message-ID: <ar0fJcjNmGGV6uFu@milan>
References: <20260923062832.479455-1-jiangwen6@xiaomi.com>
 <20260923062832.479455-7-jiangwen6@xiaomi.com>
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
In-Reply-To: <20260923062832.479455-7-jiangwen6@xiaomi.com>

On Wed, Sep 23, 2026 at 02:28:28PM +0800, Wen Jiang wrote:
> Extract the common PTE mapping logic from vmap_pte_range() into a
> shared helper vmap_set_ptes(). This handles both CONT_PTE and regular
> PTE mappings in a single function, preparing for the next patch which
> will extend vmap_pages_pte_range() to also use this helper.
> 
> No functional change.
> 
> Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> ---
>  mm/vmalloc.c | 36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index fb757d95bde25..d475e52110e4a 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -92,6 +92,29 @@ struct vfree_deferred {
>  static DEFINE_PER_CPU(struct vfree_deferred, vfree_deferred);
>  
>  /*** Page table manipulation functions ***/
> +
> +/*
> + * Try contiguous mappings at the PTE level for arches which support them, and if
> + * requested by the caller. Fall back to PAGE_SIZE mappings otherwise.
> + *
> + * Return: mapping size.
> + */
> +static __always_inline unsigned long vmap_set_ptes(pte_t *ptep,
> +		unsigned long addr, unsigned long end, u64 pfn,
> +		pgprot_t prot, unsigned int max_page_shift)
> +{
> +	unsigned long size;
> +
> +	size = arch_vmap_pte_range_map_size(addr, end, pfn, max_page_shift);
> +	if (size != PAGE_SIZE) {
> +		pte_set_huge(ptep, addr, PFN_PHYS(pfn), prot, size);
> +		return size;
> +	}
> +
> +	set_pte_at(&init_mm, addr, ptep, pfn_pte(pfn, prot));
> +	return PAGE_SIZE;
> +}
> +
>  static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  			phys_addr_t phys_addr, pgprot_t prot,
>  			unsigned int max_page_shift, pgtbl_mod_mask *mask)
> @@ -100,6 +123,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  	u64 pfn;
>  	struct page *page;
>  	unsigned long size;
> +	unsigned int steps;
>  
>  	if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
>  		return -EINVAL;
> @@ -120,15 +144,9 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  			BUG();
>  		}
>  
> -		size = arch_vmap_pte_range_map_size(addr, end, pfn, max_page_shift);
> -		if (size != PAGE_SIZE) {
> -			pte_set_huge(pte, addr, PFN_PHYS(pfn), prot, size);
> -			pfn += PFN_DOWN(size);
> -			continue;
> -		}
> -		set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
> -		pfn++;
> -	} while (pte += PFN_DOWN(size), addr += size, addr != end);
> +		size = vmap_set_ptes(pte, addr, end, pfn, prot, max_page_shift);
> +		steps = PFN_DOWN(size);
> +	} while (pte += steps, pfn += steps, addr += size, addr != end);
>
#define PFN_DOWN(x)	((x) >> PAGE_SHIFT) - how many pages covers the size.
Replace steps by nr_pages or nr_ptes?

--
Uladzislau Rezki

