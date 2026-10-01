Return-Path: <linuxppc-dev+bounces-28664-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AA4CA5FD6
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 15:54:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwc0y30spz30DY;
	Fri, 02 Oct 2026 01:54:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790870066;
	cv=none; b=PLiZBEUlQrvcVMU9jXTj12DOsz3CZgfBAQbH6xflD7xbPmM7+GDkPuJgKk36q8bNeV7Ga0I4ZpytlnBTnTm/5ck0FJuujDo3akKM7PUtxxaRFC8RLqWg6UFi9VkSI/ETw4V/n84hrQIOCLrvZcoya/LXRuWOzJ+xGqrKRzakeP2DxtFHfCrQSJ7oYS6kctnCq/75GtOYT5EifbUEb37keZ4igXztNnTDRCYsEGggmK/icPereA4pYM5vHVmSVKw6WucGAK91aVVBpvl9ouid6fxyHMf7O/4coO4oJw3dHs4YMlDA6wt/dq3XkjbDlWzUtXFoUZKy+7GPUU0suxsAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790870066; c=relaxed/relaxed;
	bh=t/FSvKdD0Rw1UPKEmYKGjjwHZIO5Pn+E96++Oh5YfMs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCYref2LIV8WxyYvylr5UY2KXJrn7pLqOsrPEGBC2y8Vk+EJEyxfjQSgreKtDfvXcqmAcO+1UYuyTXaTI3nMshjbQ4vZT5L4OO8Cwn+v7QH7vzyXdWqApIJ0hD74qb1Tl6mehAXhDtxIZNuYZcxg9Ykg/9/pom5oyBAOAZh3rJEBjXcRR3WxfWhK7sU4a0RFeFJ2rZb9wjQ5RqjdzzrGTY9Qf+pQvC9X/AxhmwqdKbchnKl0tC2a4pGelTnhVe2H7cCdDi+OsIjEuscK104Rlo+QLvpQLy03zTYryLsXQvkMH/jR8Lu3eJP5CCl8M/z0vL8gVghcsdDXN5hHaZHk+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pZPlaEnO; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pZPlaEnO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com [IPv6:2a00:1450:4864:34::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwc0x2Ddzz2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 01:54:24 +1000 (AEST)
Received: by mail-ej2-x10.google.com with SMTP id a640c23a62f3a-c2940ff2313so244006466b.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 08:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790870062; x=1791474862; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t/FSvKdD0Rw1UPKEmYKGjjwHZIO5Pn+E96++Oh5YfMs=;
        b=pZPlaEnOyS7ViBy8qqO+rAiYgDgUWYIODP6mX1hCyg/JW0Oo7TvDSeAcR+E5hu2maP
         qdB/yY8gr4w2xCRaaWiCJXDCgeAr3HrGnuZ21y4ksjPXacBxR471xgYoyK5tQo3Eq8a2
         GQyjcXr0/Gdbbzo89Wq29Q1YF8wbk2UvYN5bwigYspw2sLb6JiU5yBOSqBoLTZsYUyNA
         HoVqcf3MfCaKmbo7ZYo8+rHhccuaxhY8btgrrBBYEJK0NBPlARfiJyezrKWVJ6yeRUhB
         0jb+MnBhI2v6aeCgHINQNqLlYCmb6z4BfZyQq5xBWakFmfqqPzUECpyvWtidICMBoGB+
         ys/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790870062; x=1791474862;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t/FSvKdD0Rw1UPKEmYKGjjwHZIO5Pn+E96++Oh5YfMs=;
        b=0jDj3QdJrozf4p5+rh+4JPif2oeB6j5i/uhNRXg+8DN7tRYWa0UlzprMjpjvhLWfI6
         +HXIjmNCZJ5+J6EgTkcxr4oU829/1/66s1YXs7+TjSiMZuyVuSWi09BEsx2+gHZVlBNO
         Bh91F7lBX8w1OEbNDvq4C2/rLq24ZRvzj85c2qjB2nCvu1vCuLiVdv0/iDwoDcIVhP60
         6tzEKCWW977mLufc/mHxi1zWCIGY+8Tf1uqjXl1vIFoSCz5ytnLX/r2GrOxOkFeIbRLg
         NWsIUB2GICWZdCD7SCLHXMWUxyYxn9JqChN0hgIMv/IOFjbAb10thci7EIr3SHEd4tgV
         Kq7A==
X-Forwarded-Encrypted: i=1; AKwUvBzgALrRsEmDEwphH2X7sEjDTueq2wb62i5A8+jaqGmNecbJxFTOppk4KK6FcFKQFTgwh2V76B0zrKHjyIQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l3R3I+Z5rXL64tCQ7MeOYEc1+hpg2fb639kROb3GqxNg/kqU+R
	ZO3vlZ96u6viauGNuPFriZaYHsDBL8drjO3DuLxOUWUuC041ZgEDHrXA
X-Gm-Gg: AYBFou393APu88BKgubcRx9ciw8Micd5Q6awdmv2m/CZ3OuqUY2EUuik9J51JLUNRFV
	wh52CHYDP/hOlGfftBMaHQ1WWd4WvHUPhh+vCR/ihTBW0yPY5eB38d1pYWtKKyA4MutGe/DpmGR
	wJohSvDyFbQnOh2iCem5xAWf12+FezeMDSGrzuJ8X1g7uXPR++ECHL2SaAuTUSrxMNzqc9w/w+e
	UVpdxubye1JZewxdeejKqQzTCiLytXthGpRqGcus828LLylK2yeTklmtH8GlOkysib7ezx764cx
	EtHSxDD9PyihsoDQLlu6tHTmXI95HVVHHSOrZVw0yyAUC/5X7OxCFzUZ8UpPJMuilm782cKw8XI
	sgUeUg1ZXx07NXdWagJb4S0qZtzqKzuusQJTnQ8UJAI+L4LPr3SlR21qWawpUdHKbYVPmlhm3Ty
	jhANwiAEzwlPiRfyzsyR/cbOMZmEewp3Ksc0c=
X-Received: by 2002:a17:907:d87:b0:c2e:4397:7c82 with SMTP id a640c23a62f3a-c2e4aa6562dmr2262966b.6.1790870061590;
        Thu, 01 Oct 2026 08:54:21 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31cf0d6esm183317366b.37.2026.10.01.08.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:54:18 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 1 Oct 2026 17:54:15 +0200
To: Wen Jiang <jiangwenxiaomi@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, akpm@linux-foundation.org,
	catalin.marinas@arm.com, linux-mm@kvack.org, will@kernel.org,
	Xueyuan.chen21@gmail.com, ajd@linux.ibm.com,
	anshuman.khandual@arm.com, baohua@kernel.org, chleroy@kernel.org,
	david@kernel.org, dev.jain@arm.com, jiangwen6@xiaomi.com,
	leo.yan@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	rppt@kernel.org, ryan.roberts@arm.com
Subject: Re: [PATCH v9 06/10] mm/vmalloc: extract vmap_set_ptes() to
 consolidate PTE mapping logic
Message-ID: <ar6CJ9pWSEB8fAcC@milan>
References: <20260923062832.479455-1-jiangwen6@xiaomi.com>
 <20260923062832.479455-7-jiangwen6@xiaomi.com>
 <ar0fJcjNmGGV6uFu@milan>
 <CAHKocdF43Rqnt8-v0WP-t=Dxz2sSJ9xpyjLAYc2fzzKAW1_N8A@mail.gmail.com>
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
In-Reply-To: <CAHKocdF43Rqnt8-v0WP-t=Dxz2sSJ9xpyjLAYc2fzzKAW1_N8A@mail.gmail.com>

On Thu, Oct 01, 2026 at 03:58:21PM +0800, Wen Jiang wrote:
> On Wed, 30 Sept 2026 at 22:39, Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Wed, Sep 23, 2026 at 02:28:28PM +0800, Wen Jiang wrote:
> > > Extract the common PTE mapping logic from vmap_pte_range() into a
> > > shared helper vmap_set_ptes(). This handles both CONT_PTE and regular
> > > PTE mappings in a single function, preparing for the next patch which
> > > will extend vmap_pages_pte_range() to also use this helper.
> > >
> > > No functional change.
> > >
> > > Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> > > Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> > > Tested-by: Leo Yan <leo.yan@arm.com>
> > > ---
> > >  mm/vmalloc.c | 36 +++++++++++++++++++++++++++---------
> > >  1 file changed, 27 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index fb757d95bde25..d475e52110e4a 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -92,6 +92,29 @@ struct vfree_deferred {
> > >  static DEFINE_PER_CPU(struct vfree_deferred, vfree_deferred);
> > >
> > >  /*** Page table manipulation functions ***/
> > > +
> > > +/*
> > > + * Try contiguous mappings at the PTE level for arches which support them, and if
> > > + * requested by the caller. Fall back to PAGE_SIZE mappings otherwise.
> > > + *
> > > + * Return: mapping size.
> > > + */
> > > +static __always_inline unsigned long vmap_set_ptes(pte_t *ptep,
> > > +             unsigned long addr, unsigned long end, u64 pfn,
> > > +             pgprot_t prot, unsigned int max_page_shift)
> > > +{
> > > +     unsigned long size;
> > > +
> > > +     size = arch_vmap_pte_range_map_size(addr, end, pfn, max_page_shift);
> > > +     if (size != PAGE_SIZE) {
> > > +             pte_set_huge(ptep, addr, PFN_PHYS(pfn), prot, size);
> > > +             return size;
> > > +     }
> > > +
> > > +     set_pte_at(&init_mm, addr, ptep, pfn_pte(pfn, prot));
> > > +     return PAGE_SIZE;
> > > +}
> > > +
> > >  static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
> > >                       phys_addr_t phys_addr, pgprot_t prot,
> > >                       unsigned int max_page_shift, pgtbl_mod_mask *mask)
> > > @@ -100,6 +123,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
> > >       u64 pfn;
> > >       struct page *page;
> > >       unsigned long size;
> > > +     unsigned int steps;
> > >
> > >       if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
> > >               return -EINVAL;
> > > @@ -120,15 +144,9 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
> > >                       BUG();
> > >               }
> > >
> > > -             size = arch_vmap_pte_range_map_size(addr, end, pfn, max_page_shift);
> > > -             if (size != PAGE_SIZE) {
> > > -                     pte_set_huge(pte, addr, PFN_PHYS(pfn), prot, size);
> > > -                     pfn += PFN_DOWN(size);
> > > -                     continue;
> > > -             }
> > > -             set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
> > > -             pfn++;
> > > -     } while (pte += PFN_DOWN(size), addr += size, addr != end);
> > > +             size = vmap_set_ptes(pte, addr, end, pfn, prot, max_page_shift);
> > > +             steps = PFN_DOWN(size);
> > > +     } while (pte += steps, pfn += steps, addr += size, addr != end);
> > >
> > #define PFN_DOWN(x)     ((x) >> PAGE_SHIFT) - how many pages covers the size.
> > Replace steps by nr_pages or nr_ptes?
> >
> 
> Agreed, I'll use nr_pages. Since vmap_pages_pte_range() in the next patch has
> the same "step = PFN_DOWN(size)" pattern, I'll rename it there too.
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

