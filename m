Return-Path: <linuxppc-dev+bounces-28631-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F8FCA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 08:02:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwPXT6HDFz2yYf;
	Thu, 01 Oct 2026 18:02:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:30::e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790841753;
	cv=pass; b=c8FMfhy6n6NUP0tsoFMZjha3CM+iI59AAhq5tLLUlKK9uxW/icKdpFMWh00TRkl7JsY2HgBaXPwV0Ki/mfatI/wnUGp7fzbD6nfO+9366sxfgUC1rinkgAcgHkRte7d5F43djJBNsIe1PGIMAt3qAwrnd8BxO36Rzp8yZCCIlE2raVXThqs/NMY8BkWpo3OVh8ajUGVuczs2AWr4IovP/ON5PYOcVXXl3Yy4yYIbAm+6JBYRXHRcFXlOLEcd/tWcnnAbNllJYK+rmcp3y2sagRPw4oYSHdqVfdZWIV7JTeBWfQyDPSOGYnXokBHdkqh5pjW0jiqUzNUHAZRQC76b2w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790841753; c=relaxed/relaxed;
	bh=8wFYgQFxyClJH+0q2sU9iXyjK0XmqVNpkJ48os8SONM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfytAit91kvCiDYRHe6XU17bwspxhNPOMbV45rm6WYKMRA7ESK2FSa4j+oDXrnwdiPCjSDRFld4qIgqcmjcBYaxvqANfjY1ZBZi7ZFy0BwHYHcDQ6RkthC0XCWiRE6BBQN3faAqKkbTD5NcS1s3eAo3dpXFXPhV4x+vHDXyFV+RqCzAjloo8eMF40PYTDUupNt1I/HcQi8Wv8kR48fAHcXMa4t5wKz/1hs25LKFfdTprQwJj81dFZztXDSHrjnUIbU2SNb5NFBvjdktg0urzNYV8jqh5NRyDr/tBbMbhdb6thpH6E00/eiT5WkzkPEmqZCa36JS124yWXtzsB0KeHg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nehqHCNU; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:30::e; helo=mail-wr2-x0e.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nehqHCNU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:30::e; helo=mail-wr2-x0e.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com [IPv6:2a00:1450:4864:30::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwPXS5Qf5z2y2Z
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 18:02:32 +1000 (AEST)
Received: by mail-wr2-x0e.google.com with SMTP id ffacd0b85a97d-48affb828f1so1572135f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 01:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790841749; cv=none;
        d=google.com; s=arc-20260327;
        b=SvazG/MWWCT9RZwOlF2KA6AFwxcezpdzfd2kL1ireGvuyjaGi1rElGDJyMEOUQDTtv
         PfMv1gwAZ0nnIS3244CKohckfjuolc/4SpgFfUyjVcfmoDuRNH7DuypQgZ8FgYSzlWm0
         bR0jzzvVbO/ujjH5z4fHlCPGg5gD0h5ufVffNcGxHr21cY3qFSAAviSnRwAP0WdpJBV6
         nwTgn7AbpBpherbOpXn2nFk6QYBetsmRYzgQQkwMEbufsmatDatJ3VivBr35AmTXN19K
         8WLUY2AlGyETCLMmxdC0a0wZr7bKIqYFnqjw0VYJnSql+JJMDySPUmI31hPe0KyuunY5
         gdNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8wFYgQFxyClJH+0q2sU9iXyjK0XmqVNpkJ48os8SONM=;
        fh=k/7l3BFaC+ga0yN0tDDNink5uFkFLh/VjGtodfooDMA=;
        b=KHuwGY0uZFqlmfmMkOlKVpX0SurJ2JaeUqqABfyj9YjsIr+ghZQ8WIcSChHo83qhpA
         7qQ5rPfBvh/uHDwr4UWlc1baoLPmG5/6AC0uUBGzPWEdbl8hLe9AALCs896218AtstWE
         J3Z0M/XbHuXOR1Icte2Igkid6XIkZC0bieAq8QT2DyqKU1NHute6BFoj7OFqC3qCQIIn
         5qtYDn+fTTAWVA/pBaOBfdzPTegYNS0C1U6VwUZ72zfTB1lVnw2tTNrjvCgoTv43whS5
         kNj0xoyPC+JL08gJNbzLtd0OPOAv35HrlywmBRLyjHrQUcOAl4ydpQjmMDr4LG4n5Tdh
         jnPA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790841749; x=1791446549; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8wFYgQFxyClJH+0q2sU9iXyjK0XmqVNpkJ48os8SONM=;
        b=nehqHCNUmlEHCtZkwYOVsY9OLIJWpcQcwLf+5prKomZ92l/k87gv4MkNae9C3nEE2M
         GAWFMSoeaMxy0fmFaFdIcC+EGI4D8xtzovwHEVcxttSp8v3Ke+NCRTlcTsx4jHWPV5YY
         BaJL637UCygGKBIqM6OUjKobyzUjusfMBtto2YtqXfHV6TAPu2GPvVgMxHrVz7tYU+d7
         ACJEpfj60RsYZiIeuvUxRkBQUq5g5he5P52CLVfAUzVP40R6pKu19BWrCSVNvZL1hycN
         UB57kBDEfBpLDa4nAZrbT+vXcCR0fi7U9Urr7hRZc4HL3XRDyhtt0WGLr9rZdIKgLgOc
         ugqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790841749; x=1791446549;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8wFYgQFxyClJH+0q2sU9iXyjK0XmqVNpkJ48os8SONM=;
        b=ciFEfbzk/hKLYynwuprfJltSQacpI2Gn0z5AUMDz+3e8gNqgMfI6XHb7WqR5nAEUv+
         jUBoCtD72Lau9iOAGPVQRWCoMu6XYfti+siQJXUhV3+HYJyG7NCnpCPpE3QrP10vKQdw
         5R1wWGFzHi7EBWhrqEQqy0qCeuYjjskGjaTGqa9TpnIGuwdpBgkIVxtADsCZWmrBXbck
         lr5nlDGX9k7MG0xj5j9VtNTwgjwAHf5seMcsGbRAnDqhiraS7nEX1/F6K56L6Qmcihm3
         mSQzJeD+Hw5q/2Qd8v3D7gFa2ddGcMxWtOcIGAgKBAN/zVG/TqOkNsSbAycs5CwwcGHF
         LRXw==
X-Forwarded-Encrypted: i=1; AKwUvBzwGA+REhmtIA+AyWKWD2WlZ0yRtaVt2TyC6BnCYpKLIBi5l6fvd5I7O0u6oNXI9HZsO05t3w8tVJNEyX4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kWRT8A3lIoAjko4MGo9CLaM9J3O23UsUbe19GcZ9dUrZ9tC5Gn
	EJs4x4tDFwHpUpuo8nqrhN/mj3F2XtzCwxlcmGEsSBM04u44BZklpUS4wtf12p0BZfuem1PolGy
	stjTpfJ/UWi0Jiv1oOLEPKZyXkSYMk3o=
X-Gm-Gg: AYBFou0+pZOnfS15CGrMsZyWHFr0yibRNoQztQ5/VLWQNBXNopvTHdm94Ps0xhqjEv8
	6YXd+5/EsXSdlumGKEOeYuo2ua25Uc066Zb/ufkffQh6dURAlBTMaYp2T231iguk/06IXXhOguG
	YWafJfHaO71xR7jMeNZEGBTB6kx1RKhkJhEch+sxCr5/b4MEG23vP2gn26sFs+7dhXeJ92JbyTA
	HZYghFSbyZhksaxPohJ6xme77VcTOiQkBd0TQZoRPWVsnvnO7c7PuJOy/35Ug/CT7+DY4aDqORN
	ib7VVNTv5Kow+MmQ4eh/98DRtvBaq0X1fXnPJOEpWVqLdTV2Ybi/4ggv
X-Received: by 2002:a05:600c:3152:b0:49c:fc6e:8cbb with SMTP id
 5b1f17b1804b1-4a01b131631mr63017475e9.31.1790841748605; Thu, 01 Oct 2026
 01:02:28 -0700 (PDT)
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
References: <20260923062832.479455-1-jiangwen6@xiaomi.com> <20260923062832.479455-8-jiangwen6@xiaomi.com>
 <ar0nuJ7ocTMgbiMu@milan>
In-Reply-To: <ar0nuJ7ocTMgbiMu@milan>
From: Wen Jiang <jiangwenxiaomi@gmail.com>
Date: Thu, 1 Oct 2026 16:02:17 +0800
X-Gm-Features: AclHuK9TMMGS3_KK3AGC469G5gqBizlXQV9uB6i_baT8npA09Tvz5gZK4c--_ZU
Message-ID: <CAHKocdH-NeWYJBrCVfGctuDyh=D4a2YrzUf1VxB3cG7Di-EAMw@mail.gmail.com>
Subject: Re: [PATCH v9 07/10] mm/vmalloc: extend page table walk to support
 larger page_shift sizes and eliminate page table rewalk
To: Uladzislau Rezki <urezki@gmail.com>
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org, 
	will@kernel.org, Xueyuan.chen21@gmail.com, ajd@linux.ibm.com, 
	anshuman.khandual@arm.com, baohua@kernel.org, chleroy@kernel.org, 
	david@kernel.org, dev.jain@arm.com, jiangwen6@xiaomi.com, leo.yan@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, rppt@kernel.org, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Sept 2026 at 23:16, Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Wed, Sep 23, 2026 at 02:28:29PM +0800, Wen Jiang wrote:
> > From: "Barry Song (Xiaomi)" <baohua@kernel.org>
> >
> > vmap_pages_range_noflush_walk() (formerly vmap_small_pages_range_noflush())
> > provides a clean interface by taking struct page **pages and mapping them
> > via direct PTE iteration. This avoids the page table rewalk seen when
> > using vmap_range_noflush() for page_shift values other than PAGE_SHIFT.
> >
> > Extend it to support larger page_shift values, and add PMD- and
> > contiguous-PTE mappings as well.
> >
> > Rename it to vmap_pages_range_noflush_walk() since it now handles
> > more than just small pages.
> >
> > For vmalloc() allocations with VM_ALLOW_HUGE_VMAP, we no longer need to
> > iterate over pages one by one via vmap_range_noflush(), which would
> > otherwise lead to page table rewalk. The code is now unified with the
> > PAGE_SHIFT case by simply calling vmap_pages_range_noflush_walk().
> >
> > Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
> > Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> > Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> > Tested-by: Leo Yan <leo.yan@arm.com>
> > Reviewed-by: Dev Jain <dev.jain@arm.com>
> > ---
> >  mm/vmalloc.c | 84 +++++++++++++++++++++++++++++++---------------------
> >  1 file changed, 50 insertions(+), 34 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index d475e52110e4a..6e0dec73107a7 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -558,8 +558,10 @@ void vunmap_range(unsigned long addr, unsigned long end)
> >
> >  static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
> >               unsigned long end, pgprot_t prot, struct page **pages, int *nr,
> > -             pgtbl_mod_mask *mask)
> > +             pgtbl_mod_mask *mask, unsigned int shift)
> >  {
> > +     unsigned long pfn, size;
> > +     unsigned int steps;
> >       int err = 0;
> >       pte_t *pte;
> >
> > @@ -590,9 +592,10 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
> >                       break;
> >               }
> >
> > -             set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
> > -             (*nr)++;
> > -     } while (pte++, addr += PAGE_SIZE, addr != end);
> > +             pfn = page_to_pfn(page);
> > +             size = vmap_set_ptes(pte, addr, end, pfn, prot, shift);
> > +             steps = PFN_DOWN(size);
> > +     } while (pte += steps, *nr += steps, addr += size, addr != end);
> >
> nr_mapped_pages?
>

As noted in the patch 6 reply, I'll rename steps to nr_pages here as well.

> >
> >       lazy_mmu_mode_disable();
> >       *mask |= PGTBL_PTE_MODIFIED;
> > @@ -602,60 +605,88 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
> >
> >  static int vmap_pages_pmd_range(pud_t *pud, unsigned long addr,
> >               unsigned long end, pgprot_t prot, struct page **pages, int *nr,
> > -             pgtbl_mod_mask *mask)
> > +             pgtbl_mod_mask *mask, unsigned int shift)
> >  {
> >       pmd_t *pmd;
> >       unsigned long next;
> > +     int err;
> >
> >       pmd = pmd_alloc_track(&init_mm, pud, addr, mask);
> >       if (!pmd)
> >               return -ENOMEM;
> >       do {
> >               next = pmd_addr_end(addr, end);
> > -             if (vmap_pages_pte_range(pmd, addr, next, prot, pages, nr, mask))
> > -                     return -ENOMEM;
> > +
> > +             if (shift >= PMD_SHIFT) {
> > +                     struct page *page = pages[*nr];
> > +                     phys_addr_t phys_addr;
> > +
> > +                     if (WARN_ON(!page))
> > +                             return -ENOMEM;
> > +                     if (WARN_ON(!pfn_valid(page_to_pfn(page))))
> > +                             return -EINVAL;
> > +
> > +                     phys_addr = page_to_phys(page);
> > +
> > +                     if (vmap_try_huge_pmd(pmd, addr, next, phys_addr, prot, shift)) {
> > +                             *mask |= PGTBL_PMD_MODIFIED;
> > +                             *nr += 1 << (PMD_SHIFT - PAGE_SHIFT);
> >
> *nr += 1 << (PMD_SHIFT - PAGE_SHIFT); --->  *nr += 1U << (PMD_SHIFT - PAGE_SHIFT);
> as it used to be?
>

Agreed, I'll use 1U.

> > +                             continue;
> > +                     }
> > +             }
> > +             err = vmap_pages_pte_range(pmd, addr, next, prot, pages, nr, mask, shift);
> > +             if (err)
> > +                     return err;
> >       } while (pmd++, addr = next, addr != end);
> >       return 0;
> >  }
> >
> >  static int vmap_pages_pud_range(p4d_t *p4d, unsigned long addr,
> >               unsigned long end, pgprot_t prot, struct page **pages, int *nr,
> > -             pgtbl_mod_mask *mask)
> > +             pgtbl_mod_mask *mask, unsigned int shift)
> >  {
> >       pud_t *pud;
> >       unsigned long next;
> > +     int err;
> >
> >       pud = pud_alloc_track(&init_mm, p4d, addr, mask);
> >       if (!pud)
> >               return -ENOMEM;
> >       do {
> >               next = pud_addr_end(addr, end);
> > -             if (vmap_pages_pmd_range(pud, addr, next, prot, pages, nr, mask))
> > -                     return -ENOMEM;
> > +             err = vmap_pages_pmd_range(pud, addr, next, prot, pages, nr, mask, shift);
> > +             if (err)
> > +                     return err;
> >       } while (pud++, addr = next, addr != end);
> >       return 0;
> >  }
> >
> >  static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
> >               unsigned long end, pgprot_t prot, struct page **pages, int *nr,
> > -             pgtbl_mod_mask *mask)
> > +             pgtbl_mod_mask *mask, unsigned int shift)
> >  {
> >       p4d_t *p4d;
> >       unsigned long next;
> > +     int err;
> >
> >       p4d = p4d_alloc_track(&init_mm, pgd, addr, mask);
> >       if (!p4d)
> >               return -ENOMEM;
> >       do {
> >               next = p4d_addr_end(addr, end);
> > -             if (vmap_pages_pud_range(p4d, addr, next, prot, pages, nr, mask))
> > -                     return -ENOMEM;
> > +             err = vmap_pages_pud_range(p4d, addr, next, prot, pages, nr, mask, shift);
> > +             if (err)
> > +                     return err;
> >       } while (p4d++, addr = next, addr != end);
> >       return 0;
> >  }
> >
> > -static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
> > -             pgprot_t prot, struct page **pages)
> > +/*
> > + * It can take an array of pages which are not all contiguous, but it
> > + * may have contiguous chunks, as hinted by @shift.
> > + */
> > +static int vmap_pages_range_noflush_walk(unsigned long addr, unsigned long end,
> > +             pgprot_t prot, struct page **pages, unsigned int shift)
> >  {
> >       unsigned long start = addr;
> >       pgd_t *pgd;
> > @@ -670,7 +701,7 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
> >               next = pgd_addr_end(addr, end);
> >               if (pgd_bad(*pgd))
> >                       mask |= PGTBL_PGD_MODIFIED;
> > -             err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
> > +             err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask, shift);
> >               if (err)
> >                       break;
> >       } while (pgd++, addr = next, addr != end);
> > @@ -693,27 +724,12 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
> >  int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> >               pgprot_t prot, struct page **pages, unsigned int page_shift)
> >  {
> > -     unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
> > -
> >       WARN_ON(page_shift < PAGE_SHIFT);
> >
> This is not about this patch but probably on that WARN_ON we should bail out
> early.
>

I'll send a separate cleanup patch changing it to:

        if (WARN_ON_ONCE(page_shift < PAGE_SHIFT))
                return -EINVAL;

Thanks,
Wen
> --
> Uladzislau Rezki

