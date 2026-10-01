Return-Path: <linuxppc-dev+bounces-28630-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA528CA5FB3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 07:58:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwPRz1Y7mz2yYf;
	Thu, 01 Oct 2026 17:58:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:30::f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790841519;
	cv=pass; b=gl4+JDFIds76Df2r6sTptLiPf1zcSQrFAB4zdFMGQM/tawS5smzSRoH8cg2S6vSNZBCuG0dF7cyrZ1YvJcQp2KmTbmKFxu8g0k89PDuroMi2DAX0BNeWSctbHHLjb+Zg8HjZkUcmv6r5BErDUL4OR2ECjUJJajEUpwSuDe1qZuTAbzvEhWQj84/g1Bm9Q7OtAkQrBURj4Ucvd+xSkkVQ7f/ZCeJ8dcssQmnIDwOpApiLcxT7dC05EX0mYrJnp9tj4hCeaDtvMwJfWoR4UxjLZp04cJh/4w3af+1jUxgnPWeyGwo+8Rstll+GZk76wcGguqYBUPoH0US5ccbfRnHm/A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790841519; c=relaxed/relaxed;
	bh=I0ryAjqgJbQ97DrgWNuEBrn7YtVDsU7C9id15LD6WBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBONTzGcqA7GRbyvUif2d88SLQnHSERRw6Vfau6Y9bW7/Dgg38VJ7w1BlZdePJdUMIMihia+AJeKY4H0DlaGdfxtQdO8nDPjLZmWUMIbWBrOC0NFPpnJe7NtITRMsvq5XijM3X3541h+ecIurqIj8l0tU/KCym3RrbbQx6srKKQe0OeBFyrkK4vswJpD59HIDmvKls8UvygEZ70Ck0MMJGszTFhArGGHNgAl2yrS4qaZFdUhWQccgrc4ZHx58QBjVRO5uOdhNl6xKdlqzd3FrCCRmM+jodTNhNJUL89rUSqxl4t86qEui5TUuQCIB5fxr1ZWFf1ny3cnfVssWjh3RA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PzIZxk1l; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:30::f; helo=mail-wr2-x0f.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PzIZxk1l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:30::f; helo=mail-wr2-x0f.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr2-x0f.google.com (mail-wr2-x0f.google.com [IPv6:2a00:1450:4864:30::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwPRy10Mkz2y2Z
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 17:58:38 +1000 (AEST)
Received: by mail-wr2-x0f.google.com with SMTP id ffacd0b85a97d-48b059eae96so679048f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 00:58:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790841514; cv=none;
        d=google.com; s=arc-20260327;
        b=KOfp2ePdriegE6WbggaJ4xNvr+4CbszYauMv9sqbpyGEMWd1ZKqqkd419jEYP0dOEz
         mLHPEVVDZwhCGiJUVr2sEgWx2EiXvoaOlYS2CEi7e5SQYoNFE5ggQSbxAzsb5v6KTGLS
         jdktUsryYWd569uth42ja9WZ15/J1hJ1AQHxiGUQXLg96OtYNCWWuzNVHRqBJVOZt44b
         aBzjvpAxG+9krpyLpBkoBukoQssXHNqP/L6QQqcRA9XzXqIthhBuyb1ve4n1N3iyPZNg
         hVh6RUWilk/fx+ysLQcNh2mNjRZvye/036Al+sEMwoSRCQ8x0xMi5iNztjylyXYk4iac
         P7mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=I0ryAjqgJbQ97DrgWNuEBrn7YtVDsU7C9id15LD6WBU=;
        fh=BVulaRoSCOluRLCZK7YPByZIclwdUoku3PKh/zK+70A=;
        b=JK5RkpWxHq9r2mkKd3xGjdFmJEXRVphz4T58UK6aackaDcReDavv0KcgIYURaBZl0/
         I7JqaU/+CirJhRgU4aG+mNozi1Vgr6v4bvxE977E8xwfIBgZC4TTMx6qk7wHCze/PTL6
         +75F8iZnGcUwFB5H3Q3ZKI2Pu3bcw1GHIN1FCGwjwmZW/0w8ZKiug9OaTIUbYoRbA0zm
         2soXliPulnMToHJPwpUPTZa3X8BFCakYQbvcT6LEgOWd5Az/y+8WKK05llHQKejfkdmB
         SUQ9jcL9wimGZ6UaRUYz6O4GDdUh6jFjWlvqHBYSSMBxVCnktN6QlAxK4g5c8w9ZjY+q
         75Hw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790841514; x=1791446314; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I0ryAjqgJbQ97DrgWNuEBrn7YtVDsU7C9id15LD6WBU=;
        b=PzIZxk1lOdtsWdze1KUV9ZhWIO5l/t+eDB6L0Mb7gefjBPQbBcaeScPEw0wheabQBN
         dKnIOP7Tp80s0nssfQgosCUr5MzzAJm4tmGPt/D02pY1Z0JbDYA7QJeu2k1D7/7tRtRx
         8/m89ssyjXkNhCK24aNA4Y18I84xjWelKEuLgDoCeCyMjc2K+bZS/CKiwzkEgzIK3Oi6
         3BqNEoGEtnQ3cw6zlVvsf8vsmhYBiPketGw18YISc1DdyH6n4jHgYTd0q8UA1KU/BKU3
         BJjeSUVvRipYMdQnjwKK81p+x32s+iwz2v7hsSmhxiYoURYEneQQ/QsoW8Q49jeWOpuo
         mf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790841514; x=1791446314;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I0ryAjqgJbQ97DrgWNuEBrn7YtVDsU7C9id15LD6WBU=;
        b=ZxFYuPlRKptXZNgK7i3tyoNeaecmzM0lrdONnI4Xrj04HnbadHPIwstmaV/LE0i5Fo
         pPcUnVw0uS0YmEpR+ZNSADersC+u36Z5PFtxnBEWpDXWEGx0IZWyntpC9qmaF8WLQWd4
         vauruUmcufwKirZUXaE86krZO83cC//HagkGv3gN11vRIu3CqUN1M0ezY8sSz5RJeYEn
         NvjLQP8w3qx7k7lR3ydZnnMzpJx1nB5fiG+bCTdIXiEsD3QUA2jo2IB6nkrh3VYscorJ
         yY+SeAhK4V6UxDjUS7kIcuj1DIVLaSMpyyWUVSUm99yd2zWRBz85+Ez0i32Axb2RG4Yk
         R3qg==
X-Forwarded-Encrypted: i=1; AKwUvBwi1IZHEboGy+bWnYRWoUcIk4pjrjbTx3+q8lQrodMkSVocpHE5nFTWpLzaK/c3WTWgObY+jbdqjiUEeH8=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKFx6zKs6waChJrTbqLZMvwX0sxkF6oJEzbX0BZx8M355yE8mCB
	cdOba8t5H+aqSPF0WciL6lf7zy8MWgZWA/nfzUaol/yuggQRFJKVzq+GcvympXwkWbfd22SULlW
	4NmvIoIfwtfiK41d/17kPNjPhVtk5dgM=
X-Gm-Gg: AYBFou05ZxE+lbH8WLlot/aSQEBMq1IwakdQpSgnolQK66kdRFSCCfzXr+o06cxqlkK
	/S8u2QEHUrOOiV5Oz1gWE3Ubhvatx5vyH5cb102o0a9i/kJ9BAkHu/VFSOv36ulvtk6fxDGq332
	BUYpHiULO5wzPmRnhuBW7lq3jxkC1TdLXW/b+GXwRdci2amhUnptZHrkVFvS7/iDd7AlKLiVG8W
	HERYcCSluWBDIjEppnxV1gJc7J3M1Hqevi2Cy0z4Ctjp7ZzwCCN9JzfzbrTYT2fTIO+drHWP9+I
	QSG3f4pAVnNwxabzGJWe2a3tFlxQGvsFdrbmpN6nQISRkRG/nzWJoLfD6m6ION9IVvQ=
X-Received: by 2002:a05:6000:4a19:b0:48b:1b6:3df8 with SMTP id
 ffacd0b85a97d-48b02520a95mr7176472f8f.35.1790841514203; Thu, 01 Oct 2026
 00:58:34 -0700 (PDT)
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
References: <20260923062832.479455-1-jiangwen6@xiaomi.com> <20260923062832.479455-7-jiangwen6@xiaomi.com>
 <ar0fJcjNmGGV6uFu@milan>
In-Reply-To: <ar0fJcjNmGGV6uFu@milan>
From: Wen Jiang <jiangwenxiaomi@gmail.com>
Date: Thu, 1 Oct 2026 15:58:21 +0800
X-Gm-Features: AclHuK_89bv7uwzbXx-_ECYL_ZRmqX93WJQq5H0UucnAezX9o9f55Dqa5iDge00
Message-ID: <CAHKocdF43Rqnt8-v0WP-t=Dxz2sSJ9xpyjLAYc2fzzKAW1_N8A@mail.gmail.com>
Subject: Re: [PATCH v9 06/10] mm/vmalloc: extract vmap_set_ptes() to
 consolidate PTE mapping logic
To: Uladzislau Rezki <urezki@gmail.com>
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org, 
	will@kernel.org, Xueyuan.chen21@gmail.com, ajd@linux.ibm.com, 
	anshuman.khandual@arm.com, baohua@kernel.org, chleroy@kernel.org, 
	david@kernel.org, dev.jain@arm.com, jiangwen6@xiaomi.com, leo.yan@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, rppt@kernel.org, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Sept 2026 at 22:39, Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Wed, Sep 23, 2026 at 02:28:28PM +0800, Wen Jiang wrote:
> > Extract the common PTE mapping logic from vmap_pte_range() into a
> > shared helper vmap_set_ptes(). This handles both CONT_PTE and regular
> > PTE mappings in a single function, preparing for the next patch which
> > will extend vmap_pages_pte_range() to also use this helper.
> >
> > No functional change.
> >
> > Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> > Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> > Tested-by: Leo Yan <leo.yan@arm.com>
> > ---
> >  mm/vmalloc.c | 36 +++++++++++++++++++++++++++---------
> >  1 file changed, 27 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index fb757d95bde25..d475e52110e4a 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -92,6 +92,29 @@ struct vfree_deferred {
> >  static DEFINE_PER_CPU(struct vfree_deferred, vfree_deferred);
> >
> >  /*** Page table manipulation functions ***/
> > +
> > +/*
> > + * Try contiguous mappings at the PTE level for arches which support them, and if
> > + * requested by the caller. Fall back to PAGE_SIZE mappings otherwise.
> > + *
> > + * Return: mapping size.
> > + */
> > +static __always_inline unsigned long vmap_set_ptes(pte_t *ptep,
> > +             unsigned long addr, unsigned long end, u64 pfn,
> > +             pgprot_t prot, unsigned int max_page_shift)
> > +{
> > +     unsigned long size;
> > +
> > +     size = arch_vmap_pte_range_map_size(addr, end, pfn, max_page_shift);
> > +     if (size != PAGE_SIZE) {
> > +             pte_set_huge(ptep, addr, PFN_PHYS(pfn), prot, size);
> > +             return size;
> > +     }
> > +
> > +     set_pte_at(&init_mm, addr, ptep, pfn_pte(pfn, prot));
> > +     return PAGE_SIZE;
> > +}
> > +
> >  static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
> >                       phys_addr_t phys_addr, pgprot_t prot,
> >                       unsigned int max_page_shift, pgtbl_mod_mask *mask)
> > @@ -100,6 +123,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
> >       u64 pfn;
> >       struct page *page;
> >       unsigned long size;
> > +     unsigned int steps;
> >
> >       if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
> >               return -EINVAL;
> > @@ -120,15 +144,9 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
> >                       BUG();
> >               }
> >
> > -             size = arch_vmap_pte_range_map_size(addr, end, pfn, max_page_shift);
> > -             if (size != PAGE_SIZE) {
> > -                     pte_set_huge(pte, addr, PFN_PHYS(pfn), prot, size);
> > -                     pfn += PFN_DOWN(size);
> > -                     continue;
> > -             }
> > -             set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
> > -             pfn++;
> > -     } while (pte += PFN_DOWN(size), addr += size, addr != end);
> > +             size = vmap_set_ptes(pte, addr, end, pfn, prot, max_page_shift);
> > +             steps = PFN_DOWN(size);
> > +     } while (pte += steps, pfn += steps, addr += size, addr != end);
> >
> #define PFN_DOWN(x)     ((x) >> PAGE_SHIFT) - how many pages covers the size.
> Replace steps by nr_pages or nr_ptes?
>

Agreed, I'll use nr_pages. Since vmap_pages_pte_range() in the next patch has
the same "step = PFN_DOWN(size)" pattern, I'll rename it there too.

Thanks,
Wen

