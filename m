Return-Path: <linuxppc-dev+bounces-28663-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3535CA5FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 15:52:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwbzB3bRHz2yMn;
	Fri, 02 Oct 2026 01:52:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:34::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790869974;
	cv=none; b=atljXHFSbeZeNSpMsCtPgjW7wMd2fbr+l7BQ5aeBFCYXUrHdIi6iUdtg/FkFV1KnthuYXYwCtEYWUmb2BdC/kNEMriTkjJ1g158Gncz+4hEGhdkuB5SMsBq+1ELgInFPzAKoRfioEI0q9bUy6+RZ+VIUUAwlGCEeRPLsyFTjnRUj5hKxSRykV6Z3LxicSt5vvXyFu9XWIXY3vM32YE+F+x5hGjldzhrXo+2z7d7tXaAMgsUrba8Mtp94ckPtNUoM5PNaTaR2UmTscXr8GWfw8akbuG8cmzdzLATJPHDDzCtNgrnBRl9UwvnaRw2bZF9ksoeoqejT0koYMi2QDEBOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790869974; c=relaxed/relaxed;
	bh=fSlkzBUmp3M8NJ8QezoWTcsem1pj+Ihncq28ei+hc8U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmlZKCONYdOFT74WU0qeCsF1Ych5bVvXn2ceRQrNXHAJjBP7a70cRiwrMWe01YeBvCJFvj87vT81/89zX1G3WVcb4u82ChKj41H1rX22HdIOm3Jrwyg2PW4zf9hWMoPAcA0n/0bZ6noelGtvoUqTUQ5ZQuqYH3aQNyNww7h4iiBaEuUhU357ID24x3aP/UBIA7s9JNXC/5G99n2ddI6X6CRuKrOZysQy8B6/rohwpXZZJn+zsvzxpvsgX8qy26mvWl2A9EzhBAYWzSjgj97Hmma6yyqmDGL10tK+mXZ7C0wFH2wPKWaSxqq3W+DSHbcLbcbq5NEWs4Skh/BM8TDCOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZaD1Wyaw; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:34::f; helo=mail-ej2-x0f.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZaD1Wyaw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:34::f; helo=mail-ej2-x0f.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej2-x0f.google.com (mail-ej2-x0f.google.com [IPv6:2a00:1450:4864:34::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwbz92xtZz2xfq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 01:52:52 +1000 (AEST)
Received: by mail-ej2-x0f.google.com with SMTP id a640c23a62f3a-c2e227422e3so225073666b.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790869970; x=1791474770; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fSlkzBUmp3M8NJ8QezoWTcsem1pj+Ihncq28ei+hc8U=;
        b=ZaD1WyawHDLO7+WdtH5vSPFVsl4gcypIuuuiVI5Z6NgnnfpsVJ/1D5J+9ti4HB7pQK
         cYX0f9E9wDStG6mgtdC90CG68122yU6loGr4JgHgfohUDKaNSGg5h0s+6p0f1TTH4jw6
         2mmFdwy9mR2JQQETTME6/mD+fekVsqcxue+EsPPyzbieb0yEQL9NxRM6Jq1zSBsMze01
         LYpMjyOihzFE82phI+s6ipKM/qR+I1J1pZGfdQx2/jZqUxZQ8faXFSVTmukBMcH6HPyI
         P2KHQIaaX9dSavYOHPU/lq7SZ8OxFKggc+GdsSYAT+lY1EPpn/FckASOi5shOQBHLEWO
         6LEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869970; x=1791474770;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fSlkzBUmp3M8NJ8QezoWTcsem1pj+Ihncq28ei+hc8U=;
        b=yEIko08z5zulf9EdP1+EYJdA3UQMndhr7vZI5OMJuYTKWPl/UuJ5uQUC2Vjl56Xxh1
         w+D55Y+KWRsfU7rhw88/5qnNGWecAR9814ektBaiSWNs1ngE26LlG2NHSHuy0141+DHn
         TswQxRfKlBIX0JikkhdufILVwl8xkYM8gWItRiW3pbAOSzBQUFLautXxfa/Q8pYxIRM3
         gAGdcn72W7Wt0mbiLoc0Gao7ylrkPa6R1p2FqhfZs5x8iBoXKPdbR6bH0TDdSd8i4k0h
         Nr5eCKxyan1r3/QFMawjWE73QlybGiqTteWgcWhnq7Clvw2GBeqPI10IN/YbgtDtjn7+
         CELA==
X-Forwarded-Encrypted: i=1; AKwUvBxRizRlVD08dtEN9XwdD3QGoMspmHcc1TU3IwRro9J1pzrFCRfFWzVfV/IrN4+w3hOnW+M8Xv7UNshQ9ZU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mwGyCJz7cxDHxlIQMmP6v2C//Q0p1wrrkWj5fqkXsX3cIuSc1M
	Sc/qvbAvUh1TSxz5rpg229WbULj1ODTixas7Nuds4KCGlSKx3Fn/PrO0
X-Gm-Gg: AYBFou2X/SkSYpqj/ByVhUNM9qaQ/5fV+dDa2OEfqDXlQVEKihNT6XrbSjE3631QYoB
	u0o8Vu2OxHa5+LZzkZG2E8zGoG3NaEIDT5n2DaVWIVwWGih/weSkksJwa40AqCMraLgKNw59+u/
	MaIgJbokYdkhqFzxXAFbNQpbss419eNWiJq4h431+30ulXikkNGWToP4IqUJ8/Kp6ldmAMgeAuC
	2SUamX85s6A0VsJ4Od0JEC3FPxEDw5C5ohUwIzsLqrDxXUo5vkxKp9gEL114zRjyPiFrdZz3DC8
	DnU0L+CI7SCFrLbHcI0FOJ3USIU280O/4O+CmWN6KsPrzVgDxDQyRlBE5+hIvehSjFllfDeQ/iO
	ufF2ESaZnzryYSyuH7pkUwvM88pei8VnF2K8J+3IDSuZ5skQ4zkKKrR5WOElv5bPbfEAfQfTx4+
	CVwZvttrZNhm0uz7cGbxS267/RmPGyf8MEewnUDkPx1SV7IA==
X-Received: by 2002:a17:907:9406:b0:c2d:23af:5fcd with SMTP id a640c23a62f3a-c2e23e1fcd8mr487499166b.44.1790869969629;
        Thu, 01 Oct 2026 08:52:49 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31dc7393sm179858266b.65.2026.10.01.08.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:52:49 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 1 Oct 2026 17:52:46 +0200
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
Subject: Re: [PATCH v9 07/10] mm/vmalloc: extend page table walk to support
 larger page_shift sizes and eliminate page table rewalk
Message-ID: <ar6BzubFrn46vuTu@milan>
References: <20260923062832.479455-1-jiangwen6@xiaomi.com>
 <20260923062832.479455-8-jiangwen6@xiaomi.com>
 <ar0nuJ7ocTMgbiMu@milan>
 <CAHKocdH-NeWYJBrCVfGctuDyh=D4a2YrzUf1VxB3cG7Di-EAMw@mail.gmail.com>
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
In-Reply-To: <CAHKocdH-NeWYJBrCVfGctuDyh=D4a2YrzUf1VxB3cG7Di-EAMw@mail.gmail.com>

> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index d475e52110e4a..6e0dec73107a7 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -558,8 +558,10 @@ void vunmap_range(unsigned long addr, unsigned long end)
> > >
> > >  static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
> > >               unsigned long end, pgprot_t prot, struct page **pages, int *nr,
> > > -             pgtbl_mod_mask *mask)
> > > +             pgtbl_mod_mask *mask, unsigned int shift)
> > >  {
> > > +     unsigned long pfn, size;
> > > +     unsigned int steps;
> > >       int err = 0;
> > >       pte_t *pte;
> > >
> > > @@ -590,9 +592,10 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
> > >                       break;
> > >               }
> > >
> > > -             set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
> > > -             (*nr)++;
> > > -     } while (pte++, addr += PAGE_SIZE, addr != end);
> > > +             pfn = page_to_pfn(page);
> > > +             size = vmap_set_ptes(pte, addr, end, pfn, prot, shift);
> > > +             steps = PFN_DOWN(size);
> > > +     } while (pte += steps, *nr += steps, addr += size, addr != end);
> > >
> > nr_mapped_pages?
> >
> 
> As noted in the patch 6 reply, I'll rename steps to nr_pages here as well.
> 
Thank you!

> > > +
> > > +                     if (vmap_try_huge_pmd(pmd, addr, next, phys_addr, prot, shift)) {
> > > +                             *mask |= PGTBL_PMD_MODIFIED;
> > > +                             *nr += 1 << (PMD_SHIFT - PAGE_SHIFT);
> > >
> > *nr += 1 << (PMD_SHIFT - PAGE_SHIFT); --->  *nr += 1U << (PMD_SHIFT - PAGE_SHIFT);
> > as it used to be?
> >
> 
> Agreed, I'll use 1U.
> 
Thank you. With noted modifications:

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

> > >
> > This is not about this patch but probably on that WARN_ON we should bail out
> > early.
> >
> 
> I'll send a separate cleanup patch changing it to:
> 
>         if (WARN_ON_ONCE(page_shift < PAGE_SHIFT))
>                 return -EINVAL;
> 
Sounds good.

--
Uladzislau Rezki

