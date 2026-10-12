Return-Path: <linuxppc-dev+bounces-29229-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1978CA9EC5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 07:34:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j38Nt6PB7z2yYY;
	Mon, 12 Oct 2026 18:34:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::431" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791790462;
	cv=pass; b=lseI5yI4xa5mUs3cvW6kTUpf6Ru65JJXMXASsCl/K0Eeeh7zsNgQiXDW7jmQdXSZ44tFYIzdhDJs2yGXCaAO+RclmhGAK5xMsahDBCMc98HyOmEiO2RXh1Yi8jPMLVgWg3yBwaU9/LjdttAgFEfAyo3GQamINqji/bjhOPoRGfiVAOGZxSWP5knhPRO0xUZHXA6g6bRPPczSD6Wm+JDMSNQPQprpjzpgCuIgyqooxdgGoz65cIDYZP5LDzq9YBw6AWYXUZjV9zmP+SKeA4laop5IeFuNrTsDYOQ3SqsCxeVMeORq9Fban0kEOxDlkLR5mOM1a/QO+qLOajTkD9lf2w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791790462; c=relaxed/relaxed;
	bh=TB1tvVpc7k0BKK/tU4j4YuTf01twWs+L2M2upFeIsNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8C0HAgLbQxofbNlMxWr+K/ldG1RlzNw4oEJog67AFTHrGxDF0R2RHNvYL5iqxASk0mxDnMro1mdwGoYCvRJ7WWa5HZq5LY/+UyVgVn2Zbf2/JwpYZ2s+eIYNaW6iszvpj+xV4vIbcN1lgR7bytp+eZw+cxv3R++I2abBCQf5KCSJDclB92cbK7vJ0PKptn1cNKXoxw3Cipgb6eOAlFDKoj8pzIdfn3uzNAC8vgls0Y1Lr2oSTGBWkR1eBTOcrmUhQNAJpbjuP4xrG8l8/mX1sApAOod30gt8IC7sd6/2euTAIVvr5YxKLZw8MLtr4cHIMRUmj5UqK6PWfVfN6A1iQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QCsPuILz; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QCsPuILz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j38Nr5rfFz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 18:34:19 +1100 (AEDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-48b001cd92bso864722f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 00:34:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791790455; cv=none;
        d=google.com; s=arc-20260327;
        b=K+2IkyztVz04/kYWccJGzdV1mXiWJWlQOobRP/nfsB2VpWwD8XxJDfU53D6BnA8v7O
         sEBwlTeMW4jq4ogGJIxC2C71Szr/g+a8DEPWy6aqHbtwflXOP5HBlPT74PO+R5+Wlj4D
         UAJAgzz3KVDAUcaKMZRK1QERgER4cqrdNNLQcv/kLCBHhBfEkuCBEDnImPUoK8ImPr3V
         rEerdcRLzCQntbsUKdbo8qekt7wMBPAUxyEp1AdW3qUnvs0Q7dg6kiitj3ZPz5EDvpGQ
         zG21JrZbycnWLfNZ+0oxzTI9V9H6ABaLyDudDIaPnx5MYio3EpA72sFJn1hPDoeXBMVd
         dm1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TB1tvVpc7k0BKK/tU4j4YuTf01twWs+L2M2upFeIsNA=;
        fh=WO3YBLhy5ba/NjrIcvZ7SWnNRGvgYqpse0OacP32q9g=;
        b=VDSCN4Nnewo0n8UQ4JbP4QLr/AgxLSntZZ0d6vGoG0ifMijLVUfG926biwnfNvE9eK
         K4XM4niKRg4ZNRzewxjgE/sZIzi+2J9k98hd0BNnc4lT2Hb/D5YcxiXhuNIJU/NVvmiR
         NYB4/Nrnaa6TaMOzOHQe7ZFG74KWK8gBJwk79aJ+H44Z347394AkUEOd7RdvW9WOll9F
         jjC0OoER8Yw7c1p7RbI+Ri8Sqw1IihZMB0lCPHRLq/qBGDO4+cAEC16u+wG4VPdZwlss
         iutJFNtxz45TBWR1AONEoVgF63hvJhjR8jipJWfbua0v4jaWFG7tEC91gYcaXuLHqE8e
         T/cA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791790455; x=1792395255; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TB1tvVpc7k0BKK/tU4j4YuTf01twWs+L2M2upFeIsNA=;
        b=QCsPuILznfZPK9HpEQh6gF3SIWKycsGIcXnoLO+crRmcadNxyJS9mInkxtCID6fIT9
         koLnFtbX7pF6nHOOGNR0UO+Q49cmFMe57RreCaoSbuGDkOWoxtAPeiA6TsNLy4XhvMLc
         ihL3NBnXBSFzmF2+iMYLMijYf8ddkvYJXJw9WgHdNNnI+wEwXBs3xVmdIGgTvvaAA8lO
         oM/khDLp6SayNPOPVGP9lIQu0VIUN3p4L7i9MpJbH1hKsI1SLp4wYGkUD0sHNM3FQodx
         H3tehtXIVOaYXCO1jRLz1tissX4MXx/x/SJpOFn4ShIocmbWuLFKMVMsdfTlVt6wiFuC
         732Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791790455; x=1792395255;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TB1tvVpc7k0BKK/tU4j4YuTf01twWs+L2M2upFeIsNA=;
        b=ToIve/itU2tI3IA6unptK0A755IfTsB9OFxBBI7l8+P1BJwpcHvSgNJTVMKZjtxR1G
         akLJIyX519JEvQ0BFM5sk70f9A5N3ykz8U2fW9gSnYorveY3ofWktnDD5Ni4WrBssROi
         EjMhq6xnkzEHg1V0eUWVmhqEjkDX6Tn8xeGsft568RCCqVYIRd1RwJHfA9ow96u8KRn+
         peCNn7MremDgtRpigwrgIfuwfypv4ut3ILdDTgA7swKvuy4ec6hc2Z05qZW4kc1bHaJS
         /NMmeOC0FgU/9bRSnWcFKrVvkTjI0r/Wuta5D6/p4OVRRYoWspKPtHfW7bgGQKZaGttl
         N1ZQ==
X-Forwarded-Encrypted: i=1; AKwUvBy9O5jAYlAlvdtVZTjZwOCsrH18U5kekVGRbvLEszmEcOIHmD0WvNLr8OSAh50g+1C8J6ZI80f97IJ29xY=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJ/DZp35X6gPa13O1IWLnCldyD40uGLV74jHSNjzWsACAhHBQrN
	ZdEEo9ShvR4Sqh07fnVLVwDmwoOZQJEwHRV6uBBIxtAhxIExaQgODVQKFaizzUQF68pQhEuD27b
	wrxrGmWM0t0dLQdhufngwj8hAqa1cscs=
X-Gm-Gg: AYBFou03uQoWO4FzkV5IKJsRIW/YF8yqTSxEa+y5toXyfIHPf4CYFb2odYm4piYCBMq
	po61IlTS8VtFoPUB7sLStcYnK/HNSW/OACr/oU9yIYjvHK0eWGx0AakGHHYCXvX9d5Jw3dwnuRp
	6YBeoyaVjdTwKgal+To5TaL/EMpq7rcPujJX8ZeDOvDb/pRfuT+q5QFkGUu5G3bMz3lBA3IruVJ
	IZitDY+xRqrHYoJyBkGcAsnBQR7sGO5qigcVRbuWoLiN+8KIdsjvCCYEFGd1unkAd1oU5xtSFbG
	FKcpWD3ojk5wwvcN54Vcvwb7LnJ6NaPyTgfcmVIC7cc1nSk/0zLA0eic
X-Received: by 2002:a05:600c:154b:b0:49c:fed6:cd3f with SMTP id
 5b1f17b1804b1-4a18e4d0be2mr158510455e9.23.1791790455069; Mon, 12 Oct 2026
 00:34:15 -0700 (PDT)
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
References: <20261002090947.869220-1-jiangwen6@xiaomi.com> <20261002090947.869220-4-jiangwen6@xiaomi.com>
 <asudY_EhrT5fZGmZ@milan>
In-Reply-To: <asudY_EhrT5fZGmZ@milan>
From: Wen Jiang <jiangwenxiaomi@gmail.com>
Date: Mon, 12 Oct 2026 15:34:02 +0800
X-Gm-Features: AclHuK_LlxXaCmKE3CgA4amsUlg18qyTu4ifi545sZ2ZwusM-AnLpZx1y3tgmDI
Message-ID: <CAHKocdH9Cmjb4oEVvZnxDhYRKfK+b00k3mm_YwWmSnO4fZ+qyg@mail.gmail.com>
Subject: Re: [PATCH v10 03/10] mm/vmalloc: use pte_set_huge()/pte_clear_huge()
 for PTE-level block mappings
To: Uladzislau Rezki <urezki@gmail.com>
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org, 
	will@kernel.org, Xueyuan.chen21@gmail.com, ajd@linux.ibm.com, 
	anshuman.khandual@arm.com, baohua@kernel.org, chleroy@kernel.org, 
	david@kernel.org, dev.jain@arm.com, jiangwen6@xiaomi.com, leo.yan@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, rppt@kernel.org, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 11 Oct 2026 at 22:29, Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Fri, Oct 02, 2026 at 05:09:40PM +0800, Wen Jiang wrote:
> > vmap installs PTE-level block mappings by reusing set_huge_pte_at() and
> > huge_ptep_get_and_clear() under #ifdef CONFIG_HUGETLB_PAGE. This makes
> > the feature silently unavailable on CONFIG_HUGETLB_PAGE=n kernels and
> > couples mm/vmalloc.c to HugeTLB internals it does not otherwise need.
> >
> > Now that arm64 and powerpc/8xx provide pte_set_huge() and
> > pte_clear_huge(), add the generic fallbacks next to the existing
> > pmd/pud_set_huge() family and convert vmap_pte_range() and
> > vunmap_pte_range() to the new helpers. The CONFIG_HUGETLB_PAGE guards
> > around the block-mapping paths are dropped, so PTE-level block mappings
> > now also work on CONFIG_HUGETLB_PAGE=n kernels, and mm/vmalloc.c no
> > longer includes <linux/hugetlb.h>.
> >
> > The fallbacks exist only to keep the build working on architectures
> > without PTE-level block mapping support. They are unreachable there:
> > the callers only run when arch_vmap_pte_range_map_size() or
> > arch_vmap_pte_range_unmap_size() return a size other than PAGE_SIZE,
> > which requires an arch implementation. BUILD_BUG() makes that
> > explicit rather than silently doing nothing.
> >
> > Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> > Reviewed-by: Barry Song <baohua@kernel.org>
> > ---
> >  include/linux/pgtable.h | 29 +++++++++++++++++++++++++++++
> >  mm/vmalloc.c            | 19 ++++++-------------
> >  2 files changed, 35 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index 8c093c119e5a8..a7fd51fec8a17 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -2204,6 +2204,35 @@ static inline int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
> >  }
> >  #endif       /* CONFIG_HAVE_ARCH_HUGE_VMAP */
> >
> > +/*
> > + * PTE-level block mappings for vmap.
> > + *
> > + * pte_set_huge() only has to be implemented by architectures whose
> > + * arch_vmap_pte_range_map_size() can return a size other than PAGE_SIZE.
> > + */
> > +#ifndef __HAVE_ARCH_PTE_SET_HUGE
> > +static inline void pte_set_huge(pte_t *ptep, unsigned long addr,
> > +                             phys_addr_t phys, pgprot_t prot,
> > +                             unsigned long size)
> > +{
> > +     BUILD_BUG();
> > +}
> > +#endif
> > +
> > +/*
> > + * Likewise, pte_clear_huge() only has to be implemented by architectures
> > + * whose arch_vmap_pte_range_unmap_size() can return a size other than
> > + * PAGE_SIZE.
> > + */
> > +#ifndef __HAVE_ARCH_PTE_CLEAR_HUGE
> > +static inline pte_t pte_clear_huge(pte_t *ptep, unsigned long addr,
> > +                                unsigned long size)
> > +{
> > +     BUILD_BUG();
> > +     return __pte(0);
> > +}
> > +#endif
> > +
> >  #ifndef __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  /*
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index bea9f76ed7e74..fb757d95bde25 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -38,7 +38,6 @@
> >  #include <linux/rbtree_augmented.h>
> >  #include <linux/overflow.h>
> >  #include <linux/pgtable.h>
> > -#include <linux/hugetlb.h>
> >  #include <linux/sched/mm.h>
> >  #include <asm/tlbflush.h>
> >  #include <asm/shmparam.h>
> > @@ -100,7 +99,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
> >       pte_t *pte;
> >       u64 pfn;
> >       struct page *page;
> > -     unsigned long size = PAGE_SIZE;
> > +     unsigned long size;
> >
> >       if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
> >               return -EINVAL;
> > @@ -121,17 +120,12 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
> >                       BUG();
> >               }
> >
> > -#ifdef CONFIG_HUGETLB_PAGE
> >               size = arch_vmap_pte_range_map_size(addr, end, pfn, max_page_shift);
> >               if (size != PAGE_SIZE) {
> > -                     pte_t entry = pfn_pte(pfn, prot);
> > -
> > -                     entry = arch_make_huge_pte(entry, ilog2(size), 0);
> > -                     set_huge_pte_at(&init_mm, addr, pte, entry, size);
> > +                     pte_set_huge(pte, addr, PFN_PHYS(pfn), prot, size);
> >
> As far as i understand, X86_64 arches do not use this path. This
> specifically is only for ARM64 or powerpc. pte_set_huge() makes me
> thinking about huge-page mappings(PMD/PUD/hugetlb). This helper is
> about mutli page mapping on the PTE level.
>
> Better naming? pte_set_large()?
>
> Any thoughts?
>

Agreed, "huge" is misleading here: on arm64 these are CONT_PTE entries
and the helper writes a range of PTEs rather than a single leaf, so it
is not a PMD/PUD/hugetlb huge mapping. I'll rename them to
pte_set_large()/pte_clear_large() in v11.

Thanks,
Wen

