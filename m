Return-Path: <linuxppc-dev+bounces-28582-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19E5CA5FCB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 15:16:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvzCN3njkz2y2J;
	Thu, 01 Oct 2026 01:16:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:34::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790781376;
	cv=none; b=nP5aGMwpYx9PtZ5/ubgkV7Vdurr5lAdF+LLuJoXRBKUyAtSztKcQIBLr282jmHsaXEI2/NDVWhiojky0FQiuPYKbpFNI2x+TEau6USPIR7C9/zLc9FlIYPrvFT5Ox5yBWhOKNGj0z11XUWSmKA5Ln92SXZLSVVb2u1Zw6bwSHYzmTj/+Lc8i80gmj398GJG0mwxHmMwWSpEyIxJN2NRW2s2ETMx0qXftlLL94eXHGbTc7i6LkRakJZp5DeO8iHFyjufWuTBq8ka9cdzf32ssWjtWqJBz6RB0dga1YPcepHd5n3Dj3u13iYaUk+D/1SVV4o8SAyFRaWotrlw1wqm8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790781376; c=relaxed/relaxed;
	bh=q9dGLqKNBlMrHbdqAQfcvM1eXGcLD/Xmv99laXST3Cc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P64kiGiSea4Rx4sS+9LAtRQ01z07eLjKfxJRQxXOAVAim1gDwKqqNx66S1cr/zRPaaLw7Z+/zfb5aS0Bov5CpW6kVQzGjSOawnzeE71cYCxz34Wu2XE0HuRy1SWQgX9vd2yL7PwmnC4+pB4mKWYkkK7Tg+O//0bjh85T72coToFLFOFCjaTEWht1hyPQijb0CC4Qj7uNEjd6z1x3pIID6IXWHhW0inNOd/0OadJVDfFanYWHGb0OchBZyWZsSsuT/g8DaQuh8JGDNhearmo3H+b9nIJx+NTZD+tjRb9IdgyQM0kVkka1Zj5kGpjr6pG3FVd2m30X/jpXSzDr9rR8MQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P7MUY7a5; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:34::f; helo=mail-ej2-x0f.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P7MUY7a5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:34::f; helo=mail-ej2-x0f.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej2-x0f.google.com (mail-ej2-x0f.google.com [IPv6:2a00:1450:4864:34::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvzCM2fvSz2y24
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 01:16:15 +1000 (AEST)
Received: by mail-ej2-x0f.google.com with SMTP id a640c23a62f3a-c2e20bb4583so108406866b.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790781372; x=1791386172; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q9dGLqKNBlMrHbdqAQfcvM1eXGcLD/Xmv99laXST3Cc=;
        b=P7MUY7a5Ct+eXG4NTNFGHi7Ip2I5aeKZeqpogxgQbjF5AZxiwm5ydCCY9Urywl8VZM
         vCFGTVaCYbhmEK//VN7sakLQCz6zchsvHnmPFtaPve7yMt5ATVWYsBbO5muIcKnzX3Yu
         LnNg11JxhmPznhOs1fp9fBzblr22LBLZvoq4U0CH65JuwGFXWDJvWlCGlV60JIFTFAWq
         RLNhS7VVwsCZJF///6lrIu/mszoDOjF5Kxy8xWLHFFxQ5RbzIDVyrKM0a4VYHhtDy1K7
         hKteRyX4qeMl+8kgMBH0xTO6J5Chq9jfR+9D/9QtLoLqVKhPL4odYGyl5oHKTb0sUyku
         +0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790781372; x=1791386172;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q9dGLqKNBlMrHbdqAQfcvM1eXGcLD/Xmv99laXST3Cc=;
        b=gW1wZyj5c3N+MlUoSRLX1p32OZnbCBk1coXk53eY/AMUFI7+hrx969cgd7n2mHMlmO
         LKW6nel7fiLCSIsAfA5E6BlxCTYImY/La4i4CE+WjPx1UFrYLG1yUIiHLugq47OkpqUZ
         parZtYRFXozOJ/HgycrCQAlwMnfrUJleMeO2H8hgVOA3bkbAkXmflY+Dmc53yqkDDg3n
         DjhU6XA2LLRWjW9JDWnupM4Zp9A7vRSU5DSK1WSQHdgAMBL4XztDwR1iIEqDvd23/UAn
         F3NYbNCu2x8bIlLCKtKR+vmhoS1cJiUmFWOiEwZdbsgqSTrvqUVl65FqPUpG7skDaeg0
         5T6Q==
X-Forwarded-Encrypted: i=1; AKwUvBxt2PQ4ZzM22tL1OCPFzz6Tgy12dR3lFcXMeJPRnY/8Y6xdKUxrkzRj9GlUu32LTVdXAMtbbZmt8XCGh/8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mSL/j6x6jagCjrpa4JYBlCHtth3HnDn6eZ/loYnMFkn7yaVzHx
	n49A05wgVRmN2W3uAzX7y0IK39nm+MH71N9z4wRu0gCKCMLESyM2Dl1F
X-Gm-Gg: AYBFou1HXJ+IiLEGtuptn9oK7mDFTmOHSXkyI3DFaHZZQpW7T1ws5gW6mYee2bn5m3c
	XbPNm7rLlplOGi/Iyq2EF9psHoBDSJU/UMRTLn/wF/th3uEeNrh2Lo1+5iRZP6wSCEUeAqAdTyt
	8rIkecMQFTZwQ7v585y1Z4IaUSPV1QHMI5smp+JMyTvTmz2kzrXQsnfZy3QtZKN7yWGp5NLKA33
	f/ea69xUNqinxEpW8fCyO1dpFWzo8xB4OJIYvyGOMKQ9SO7TNLt25+apb91+vUaqatw4OSHarSl
	xZBOGYaUGrjwh5cFgXovbvZGBlsLMaGQ5u2fvgN+zGvlC//pFT7Rqi8GerJspShaC0+6H1YEzE7
	0HKzyNAD3j0+hvrPzLdjWcs6yiUXc7RGV57EjJMP8nhjIWQSJUQ6NtoYaKdn7WrO2eFZSsA/JPG
	KLBY+e6hx7q0PKxiS0GaA2c91ouYd1HgNxlWE=
X-Received: by 2002:a17:907:d1e:b0:c29:cf4b:5cac with SMTP id a640c23a62f3a-c2e23749268mr150465666b.5.1790781371662;
        Wed, 30 Sep 2026 08:16:11 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31ce9e4fsm21985066b.31.2026.09.30.08.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:16:11 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 30 Sep 2026 17:16:08 +0200
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
Subject: Re: [PATCH v9 07/10] mm/vmalloc: extend page table walk to support
 larger page_shift sizes and eliminate page table rewalk
Message-ID: <ar0nuJ7ocTMgbiMu@milan>
References: <20260923062832.479455-1-jiangwen6@xiaomi.com>
 <20260923062832.479455-8-jiangwen6@xiaomi.com>
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
In-Reply-To: <20260923062832.479455-8-jiangwen6@xiaomi.com>

On Wed, Sep 23, 2026 at 02:28:29PM +0800, Wen Jiang wrote:
> From: "Barry Song (Xiaomi)" <baohua@kernel.org>
> 
> vmap_pages_range_noflush_walk() (formerly vmap_small_pages_range_noflush())
> provides a clean interface by taking struct page **pages and mapping them
> via direct PTE iteration. This avoids the page table rewalk seen when
> using vmap_range_noflush() for page_shift values other than PAGE_SHIFT.
> 
> Extend it to support larger page_shift values, and add PMD- and
> contiguous-PTE mappings as well.
> 
> Rename it to vmap_pages_range_noflush_walk() since it now handles
> more than just small pages.
> 
> For vmalloc() allocations with VM_ALLOW_HUGE_VMAP, we no longer need to
> iterate over pages one by one via vmap_range_noflush(), which would
> otherwise lead to page table rewalk. The code is now unified with the
> PAGE_SHIFT case by simply calling vmap_pages_range_noflush_walk().
> 
> Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
> Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> ---
>  mm/vmalloc.c | 84 +++++++++++++++++++++++++++++++---------------------
>  1 file changed, 50 insertions(+), 34 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d475e52110e4a..6e0dec73107a7 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -558,8 +558,10 @@ void vunmap_range(unsigned long addr, unsigned long end)
>  
>  static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
>  		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
> -		pgtbl_mod_mask *mask)
> +		pgtbl_mod_mask *mask, unsigned int shift)
>  {
> +	unsigned long pfn, size;
> +	unsigned int steps;
>  	int err = 0;
>  	pte_t *pte;
>  
> @@ -590,9 +592,10 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
>  			break;
>  		}
>  
> -		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
> -		(*nr)++;
> -	} while (pte++, addr += PAGE_SIZE, addr != end);
> +		pfn = page_to_pfn(page);
> +		size = vmap_set_ptes(pte, addr, end, pfn, prot, shift);
> +		steps = PFN_DOWN(size);
> +	} while (pte += steps, *nr += steps, addr += size, addr != end);
>
nr_mapped_pages?

>  
>  	lazy_mmu_mode_disable();
>  	*mask |= PGTBL_PTE_MODIFIED;
> @@ -602,60 +605,88 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
>  
>  static int vmap_pages_pmd_range(pud_t *pud, unsigned long addr,
>  		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
> -		pgtbl_mod_mask *mask)
> +		pgtbl_mod_mask *mask, unsigned int shift)
>  {
>  	pmd_t *pmd;
>  	unsigned long next;
> +	int err;
>  
>  	pmd = pmd_alloc_track(&init_mm, pud, addr, mask);
>  	if (!pmd)
>  		return -ENOMEM;
>  	do {
>  		next = pmd_addr_end(addr, end);
> -		if (vmap_pages_pte_range(pmd, addr, next, prot, pages, nr, mask))
> -			return -ENOMEM;
> +
> +		if (shift >= PMD_SHIFT) {
> +			struct page *page = pages[*nr];
> +			phys_addr_t phys_addr;
> +
> +			if (WARN_ON(!page))
> +				return -ENOMEM;
> +			if (WARN_ON(!pfn_valid(page_to_pfn(page))))
> +				return -EINVAL;
> +
> +			phys_addr = page_to_phys(page);
> +
> +			if (vmap_try_huge_pmd(pmd, addr, next, phys_addr, prot, shift)) {
> +				*mask |= PGTBL_PMD_MODIFIED;
> +				*nr += 1 << (PMD_SHIFT - PAGE_SHIFT);
>
*nr += 1 << (PMD_SHIFT - PAGE_SHIFT); --->  *nr += 1U << (PMD_SHIFT - PAGE_SHIFT);
as it used to be?

> +				continue;
> +			}
> +		}
> +		err = vmap_pages_pte_range(pmd, addr, next, prot, pages, nr, mask, shift);
> +		if (err)
> +			return err;
>  	} while (pmd++, addr = next, addr != end);
>  	return 0;
>  }
>  
>  static int vmap_pages_pud_range(p4d_t *p4d, unsigned long addr,
>  		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
> -		pgtbl_mod_mask *mask)
> +		pgtbl_mod_mask *mask, unsigned int shift)
>  {
>  	pud_t *pud;
>  	unsigned long next;
> +	int err;
>  
>  	pud = pud_alloc_track(&init_mm, p4d, addr, mask);
>  	if (!pud)
>  		return -ENOMEM;
>  	do {
>  		next = pud_addr_end(addr, end);
> -		if (vmap_pages_pmd_range(pud, addr, next, prot, pages, nr, mask))
> -			return -ENOMEM;
> +		err = vmap_pages_pmd_range(pud, addr, next, prot, pages, nr, mask, shift);
> +		if (err)
> +			return err;
>  	} while (pud++, addr = next, addr != end);
>  	return 0;
>  }
>  
>  static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
>  		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
> -		pgtbl_mod_mask *mask)
> +		pgtbl_mod_mask *mask, unsigned int shift)
>  {
>  	p4d_t *p4d;
>  	unsigned long next;
> +	int err;
>  
>  	p4d = p4d_alloc_track(&init_mm, pgd, addr, mask);
>  	if (!p4d)
>  		return -ENOMEM;
>  	do {
>  		next = p4d_addr_end(addr, end);
> -		if (vmap_pages_pud_range(p4d, addr, next, prot, pages, nr, mask))
> -			return -ENOMEM;
> +		err = vmap_pages_pud_range(p4d, addr, next, prot, pages, nr, mask, shift);
> +		if (err)
> +			return err;
>  	} while (p4d++, addr = next, addr != end);
>  	return 0;
>  }
>  
> -static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
> -		pgprot_t prot, struct page **pages)
> +/*
> + * It can take an array of pages which are not all contiguous, but it
> + * may have contiguous chunks, as hinted by @shift.
> + */
> +static int vmap_pages_range_noflush_walk(unsigned long addr, unsigned long end,
> +		pgprot_t prot, struct page **pages, unsigned int shift)
>  {
>  	unsigned long start = addr;
>  	pgd_t *pgd;
> @@ -670,7 +701,7 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
>  		next = pgd_addr_end(addr, end);
>  		if (pgd_bad(*pgd))
>  			mask |= PGTBL_PGD_MODIFIED;
> -		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
> +		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask, shift);
>  		if (err)
>  			break;
>  	} while (pgd++, addr = next, addr != end);
> @@ -693,27 +724,12 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
>  int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>  		pgprot_t prot, struct page **pages, unsigned int page_shift)
>  {
> -	unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
> -
>  	WARN_ON(page_shift < PAGE_SHIFT);
>
This is not about this patch but probably on that WARN_ON we should bail out
early.

--
Uladzislau Rezki

