Return-Path: <linuxppc-dev+bounces-28662-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD55CA5FD4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 15:48:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwbt152lzz2xfq;
	Fri, 02 Oct 2026 01:48:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:34::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790869705;
	cv=none; b=ASsBYHlCUGcizT5OY59GS70+gmB6QjVqBgX1L8Iu28HzLVqENTzd/iRLAfLYW3S1GHglDkhxpD8BReO4f2xQ75NIXtXRXekrMZmigKzVwz7syaPIF/YWxpAD7mJmuQVZJksTGvQFBoKifjO/miMMcCTiTl9Eyx5VaPbmZ+f7XFgvNGeHNEra1IrOblSnjgDTt9uOMUmgEvFH8NWirmhvmbuHpv+ZxUi4BJdseyalk83U4L5AZjcRndwHV7d7FQV4KO6mI93HXP8TuqOUVFpQEXmCwKUdoV0lFHAe2nFeHEEJrbOZJQlAFoFDHeTmIEA+QSmLv8Z9BHpKHeX1Q67pMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790869705; c=relaxed/relaxed;
	bh=1YG6o6wTRxoEQtd5iQEcu4HXOz2uoJ4yfyWYLykx9lM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmjpCUns/P4NZs7jhqRuPKQTnaHlXlfxbzlrBTSVZd6d/mEBp6eDl/Bw2VQhocDfMo6NYglM+lEOj2N0Fu7luHSXvjZABkShZctMBh1GugN53ZgRr88BhsuDDLV1JD4pB7N6nirywi4tkeDflzeYr/IRecBz9tlMdfH09RhV8LjqPTNsKS6dlWMA7/T6Q+zFoVi5yb1JFA82lBcekk3t7sLlikdgRpKPzOc5s6vph658Z/tvQpc/GxVaXGca/AuGkXwZlf91wP1V5zh7MAS1AyAr3nHz9jGIhc5/ECgvKBdA/yrZzJb2zAuw8UukyYGB2mmX2NPuHBAoQZEP+ilvZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RQ6mx9+q; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:34::f; helo=mail-ej2-x0f.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RQ6mx9+q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:34::f; helo=mail-ej2-x0f.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej2-x0f.google.com (mail-ej2-x0f.google.com [IPv6:2a00:1450:4864:34::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwbsz3krLz2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 01:48:22 +1000 (AEST)
Received: by mail-ej2-x0f.google.com with SMTP id a640c23a62f3a-c2e2050feb1so357329566b.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 08:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790869698; x=1791474498; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1YG6o6wTRxoEQtd5iQEcu4HXOz2uoJ4yfyWYLykx9lM=;
        b=RQ6mx9+qGUX9xeCbwOktfmmT03d71fS/TANjqZSAjIz8R44+I8Mfrk20Wa4dG1dlMj
         2Di7NAVIEkMpx/HgDej6bTPH3rq4SHb3GykC8noUNMvDKTZ8yVY94SN+t7GLGcF9AOXs
         W2bY+IqOAS6pYBUEzcvJdpgt5SOL2B8SS3ODz7QnFSOa6dk/Pbd1M6hEifR/4Od01ONZ
         GIVyPQYJrnDcMJyTsNFpibb0RJy7MTAB+jrcNY7qrq8Pk6EL7ZWrY8KlTJAHqvUKCK9U
         HQ/sJB7BF8wVjxvzUWJvgpHKTsyJ/iNXZJEnKvfrzPFqjIv1zCEH7W8GbnS5udFJmmXM
         WnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869698; x=1791474498;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1YG6o6wTRxoEQtd5iQEcu4HXOz2uoJ4yfyWYLykx9lM=;
        b=lElIVIEljtejV3rdKiWpHCmqme5b3ejIBjpB7GiGJXoGOsgalNb6ji82ns/TsdMdty
         Z0QflKQiP4LeYsksmMt6VijypdsgTNyoBphdqsKFnXv7nBvE67KMrvX94QkTIdp8+ze3
         08pU0ur5/ehDaIHc5UMesP4reg9eOBAdh4fuNbkFhUdYFmwf2mDSvKM70oNXxfNhg3GZ
         zQl7gMPiomCqEc/Rk3U6q2Qt/NCNTMYb/caYaNVjPeEFoj5j2c+sl4mZKSO2YJKUDX/5
         yTcdC5D3rNvF9BgeAK9EclcWKmpK+wzKcX2tFt3I4vxQu/LYt0+egyeD0An+Dx1tUqdc
         WmSQ==
X-Forwarded-Encrypted: i=1; AKwUvBxX1NpYCXJOgqfy+DM9yNRC6UG8ThQV6xqszTp3o2NxvB6IjupfFoFkCxeGLrzdFD48ZOKvXQcgRBD5+6c=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lfpsLQCXk2Db1n6MNNwBFTG5Dt+asVv95k6EyJyUJmkJOikZXH
	c6Pu0FqOLEP3czxVEBGQ8ekW9r1cU2qBVyALJIktUVRdp/KQGfyZH7s8
X-Gm-Gg: AYBFou0CB2VB8A1WYGpxmObVuHq3tMfno4Xwb8/8q+cDpHbXIvmUHQEnSbwvtbNp9GX
	6Lln9Lnv0sgVCUg73ApzAK3H8xNKefBDj1s3Lw7Zn5g+jTKvEA5KS9zwzCTQsr2dTTmpnsvF0l1
	OwxfREuyqc72Tw+Cx1nrDxu9Yet4jjt6iW7tP13svJWaIdx5WHfyEagDjMtqOooZfGE7oDs9buQ
	uzfUoPaOU7VGmV2S02iPvmXq8/BT5fAjjwvcGC6A3mrBqrt0Syq1tXKvG5CMH6JfKxqlJiBcTMk
	vLiYDj7q6bYf9dlGN6d5EH5oCU9DK7UcdNiCUob4KWjbcWsZpMgq901E4pYvngmuOuFVzXaC4BX
	UsJp7jYCOgorFLi3VZJY2d3KGoqSMGLi0UkJTsSm1yuvcBxZadoDgrcwYhLg+5a2mGBevJuhKOq
	iiumf90MfZ3XfB3SZBnJjwvtuv8jc5TEAjqAI=
X-Received: by 2002:a17:907:3f87:b0:c2e:856:2a08 with SMTP id a640c23a62f3a-c2e4a9b37a6mr2297866b.1.1790869697837;
        Thu, 01 Oct 2026 08:48:17 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31d87bdfsm180664666b.57.2026.10.01.08.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:48:05 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 1 Oct 2026 17:48:00 +0200
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
Subject: Re: [PATCH v9 09/10] mm/vmalloc: map contiguous pages in batches for
 vmap() if possible
Message-ID: <ar6AsIvAviFFQjEh@milan>
References: <20260923062832.479455-1-jiangwen6@xiaomi.com>
 <20260923062832.479455-10-jiangwen6@xiaomi.com>
 <ar0lMkKxugZV7xyw@milan>
 <CAHKocdEqnCCyW1TgmiRotFO0hQdHt7pXP1sdqzZ7Up6wc+-Bsw@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHKocdEqnCCyW1TgmiRotFO0hQdHt7pXP1sdqzZ7Up6wc+-Bsw@mail.gmail.com>

On Thu, Oct 01, 2026 at 04:09:24PM +0800, Wen Jiang wrote:
> On Wed, 30 Sept 2026 at 23:05, Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Wed, Sep 23, 2026 at 02:28:31PM +0800, Wen Jiang wrote:
> > > From: "Barry Song (Xiaomi)" <baohua@kernel.org>
> > >
> > > In many cases, the pages passed to vmap() may include high-order
> > > pages. For example, the systemheap often allocates pages in descending
> > > order: order 8, then 4, then 0. Currently, vmap() iterates over every
> > > page individually—even pages inside a high-order block are handled
> > > one by one.
> > >
> > > This patch detects physically contiguous pages (regardless of whether
> > > they are compound or non-compound) by scanning with
> > > num_pages_contiguous(), and maps them as a single contiguous block
> > > whenever possible. The mapping order is determined by taking the
> > > minimum of the contiguous page count and the pfn alignment, allowing
> > > graceful degradation when pfn alignment is less than the contiguous
> > > range.
> > >
> > > Pages with the same page_shift are coalesced and mapped via
> > > vmap_pages_range_noflush_walk() to avoid page table rewalk.
> > >
> > > As users typically allocate memory in descending orders (e.g.
> > > 8 → 4 → 0), once an order-0 page is encountered, we stop scanning
> > > for contiguous pages since subsequent pages are likely order-0 as well.
> > >
> > > Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
> > > Co-developed-by: Dev Jain <dev.jain@arm.com>
> > > Signed-off-by: Dev Jain <dev.jain@arm.com>
> > > Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> > > Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> > > Tested-by: Leo Yan <leo.yan@arm.com>
> > > ---
> > >  mm/vmalloc.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 80 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index a43965016eb4d..37cddb7f45a4f 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3576,6 +3576,85 @@ static inline unsigned int vm_shift(pgprot_t prot, unsigned long size)
> > >       return arch_vmap_pte_supported_shift(size);
> > >  }
> > >
> > > +static inline int get_vmap_batch_order(struct page **pages,
> > > +             pgprot_t prot, unsigned int nr_pages)
> > >
> > get_vmap_mapping_order()?
> >
> 
> Agreed, that's a clearer name.
> 
> > > +{
> > > +     unsigned long pfn;
> > > +     unsigned int nr_contig;
> > > +     int order;
> > > +
> > > +     if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
> > > +             return 0;
> > > +
> > > +     /* Limit nr_pages by pfn alignment */
> > > +     pfn = page_to_pfn(*pages);
> > > +     if (pfn > 0)
> > > +             nr_pages = min_t(size_t, nr_pages, 1UL << __ffs(pfn));
> > > +
> > > +     nr_contig = num_pages_contiguous(pages, nr_pages);
> > > +     if (nr_contig < 2)
> > > +             return 0;
> > > +
> > > +     order = ilog2(nr_contig);
> > > +
> > > +     if (vm_shift(prot, PAGE_SIZE << order) == PAGE_SHIFT)
> > > +             return 0;
> > > +
> > > +     return order;
> > > +}
> > > +
> > > +static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
> > > +             pgprot_t prot, struct page **pages)
> > > +{
> > > +     const unsigned int nr_pages = (end - addr) >> PAGE_SHIFT;
> > > +     unsigned int prev_shift = 0, batch_idx = 0;
> > > +     unsigned long batch_start = addr, batch_end = addr;
> > > +     int err;
> > > +
> > > +     err = kmsan_vmap_pages_range_noflush(addr, end, prot, pages,
> > > +                                          PAGE_SHIFT, GFP_KERNEL);
> > > +
> > > +     if (err)
> > > +             goto out;
> > > +
> > > +     for (unsigned int i = 0; i < nr_pages; ) {
> > > +             unsigned int shift = PAGE_SHIFT +
> > > +                     get_vmap_batch_order(pages + i, prot, nr_pages - i);
> > > +
> > > +             if (!i)
> > > +                     prev_shift = shift;
> > > +
> > > +             if (shift != prev_shift) {
> > > +                     err = vmap_pages_range_noflush_walk(batch_start, batch_end,
> > > +                                     prot, pages + batch_idx, prev_shift);
> > > +                     if (err)
> > > +                             goto out;
> > > +                     prev_shift = shift;
> > > +                     batch_start = batch_end;
> > > +                     batch_idx = i;
> > > +             }
> > > +
> > > +             /*
> > > +              * Once we fail to batch pages, we expect to fail batching
> > > +              * for all remaining pages, so just give up.
> > > +              */
> > > +             if (shift == PAGE_SHIFT)
> > > +                     break;
> > > +
> > > +             batch_end += 1UL << shift;
> > > +             i += 1U << (shift - PAGE_SHIFT);
> > > +     }
> > > +
> > > +     /* Remaining */
> > > +     if (batch_start < end)
> > > +             err = vmap_pages_range_noflush_walk(batch_start, end, prot,
> > > +                             pages + batch_idx, prev_shift);
> > > +
> > > +out:
> > > +     flush_cache_vmap(addr, end);
> > > +     return err;
> > >
> > On error, if kmsan_vmap_pages_range_noflush() succeed you do not do a
> > proper cleanup?
> >
> > i.e. to cleanup KMSAN metadata: kmsan_vunmap_range_noflush(addr, end);
> >
> 
> The KMSAN metadata is cleaned up by the caller: on error vmap calls
> vunmap(area->addr), which reaches kmsan_vunmap_range_noflush() through
> remove_vm_area() -> free_unmap_vmap_area() -> vunmap_range_noflush().
> That is the same contract as the pre-existing vmap_pages_range() path,
> which likewise relied on the caller's vunmap() to clean up. So there
> is no behavioral
> change here.
> 
Right. With better naming:

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki



