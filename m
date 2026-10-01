Return-Path: <linuxppc-dev+bounces-28632-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121FBCA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 08:09:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwPhj20Dtz2yYf;
	Thu, 01 Oct 2026 18:09:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:30::e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790842181;
	cv=pass; b=VWQdDlZrS/c/ME6CxoYDv7PMhaumTJsbMkdoXxax2OGiOCD4HegAHwGcxBKYmlrIO5aobEr/TLXlECn5Res3btRaLkqb8oDvZc8kkcFPz1W59379afxvARnBDlNflCGoCsDjYJ6TyOy2p3UJNCyPRQOX1CwQ9RzRv4SDzubmlbVp73CwUi1NgdQn/vvRvXwBnHLDRzNZeEKuPmvzJ1lwZE9FtjWlkLA8TLmJBauNTHr9onsI/2h1bNlOpS7KK7JJwhZ6kxSpezcTsQhc15mqFNA5kZP6+YGHUiEgsK09Uywh93qUNSEdNJI8iBJRhQEwNtL8igakaMX91duROjj/Fw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790842181; c=relaxed/relaxed;
	bh=7WUeRXQIxnR9XpkkjIeWQnzVeCWSoXoruQ6cCNl/Q6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIFbt1gr5NBCxhXcBM96xDRMYeHB8cZxy5VB76uaL1oL3Ld0jJa35v+g+uwWkgdqDP99Wny5TzLPw6X7jlClqVzzc2Agl4lgGjBMXSS7eG9JqjvODuYmByHKjce28y2tT35ILQ81bXaYGTL7M9ML/Yg2Smn0N6455F4VJQsxZlisVI6e1eG5yxYx5pe181q69HJB1jXlGu/KB5Q4iRnLWJja+k8Z4B+WmhWs2YJ7EiVbHqr1UYygylqhkXV/cNtBHf/OEj+ps4yE6o0yQf2nV9LdqEeYIp/0GWmsTmhnGtDTioQv5x0xM6//3iLkM9aM5QjBgB5L5+sBntEOr6CQyw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ShmpPEIb; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:30::e; helo=mail-wr2-x0e.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ShmpPEIb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:30::e; helo=mail-wr2-x0e.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com [IPv6:2a00:1450:4864:30::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwPhh1qqJz2y2Z
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 18:09:40 +1000 (AEST)
Received: by mail-wr2-x0e.google.com with SMTP id ffacd0b85a97d-48b00a0ac65so923873f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 01:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790842177; cv=none;
        d=google.com; s=arc-20260327;
        b=nWTCUlLaZmDg917UyUTi73gnRSXyhj3Tu6h+vci4eYP/0VGzRwEsUpdHNEKd0rQBpk
         LwgIoL1G/fPMNVg+UOjg7csDSbD/qod95UVi6Ah8zfAq+TorBNo7bHyppRovYJZO/Mek
         plDTZGISlKZzHzl5D/H01uaMcR7TgECql7G4JI6FCMIFKGbc9pUoGVGHwZZFnzbluAqD
         NhXHnlhktaHg8zm/7vUayjJKPSx4h6+sGs9ANiwW/SqCLuYISx57dbglmSxiUdHKZGbc
         51Oml59SM3soQC16ir764jTqt2fF+3xnLIA8GdXSgC5WwrH/JElml95gqGJTTRORZX8z
         ZlMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7WUeRXQIxnR9XpkkjIeWQnzVeCWSoXoruQ6cCNl/Q6Q=;
        fh=Z4xL/jZPOw5CjMaMm0tRI9U8itLdwrMH5bzbSZiouY4=;
        b=CYqCRATdlP/EDEKhWzsWMcRJLL1qzV3wz/a7HAPlivcLPS9FrfuazUGflxjQR/tsSs
         v4CX6IXUEMuBxbmAvolLR+7MxAe+0lcH14cmaBnWqGe1uVS+vuNzlfS6zX4g/ywiq3UB
         9E21F948Y+KqUk3JaoIDommdSSCNNoikuGrRUK3FAK+AVEXXi27B5hrUGoY1xBpGfYBr
         oPH6Ysm4Z9/tWCxBLXWxjeP7e3PIZsKXV2A3kQecdDkgvTnyf1mK9EQPSreeLOFuLK1n
         7Zcpfu4+b6VyBbj1JMWLhCIswZKNzZWMD8Om20iLsEytSDQTUB03P6jBZDuRwae/xe0x
         hikQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790842177; x=1791446977; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7WUeRXQIxnR9XpkkjIeWQnzVeCWSoXoruQ6cCNl/Q6Q=;
        b=ShmpPEIbPtnAG66zgO/r/kDfGEZTUMRZ1RQ9AMgHZ6Tu1HcTFrmylfSqf/RK4Hzbx2
         frQj3YVdhymkKUyxEguQJ760ptwAHfWy+k5oVAqrHFYfyudyYRCbc3r2X2QAZdCTBKx+
         7DvB2Y8crIQtObCV9H1SaCyLaREzYQ2gV+1wiZ0hqzyx9bWkohgebsUG72rD3i3bTMXm
         PEe3X45czylM15zpJEMABFH7ph1fHGzOWfd1MQBm/G6+KZ4sdzN57Fjxohh2R5L5YEKE
         ytho8ZuxphKszVROSduRbc4yKdNFRfg+TM+7qM8c4skOdcrBz7ZHvHKUgitpHfXH0j0E
         9D+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790842177; x=1791446977;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7WUeRXQIxnR9XpkkjIeWQnzVeCWSoXoruQ6cCNl/Q6Q=;
        b=V5hWJYgdcMD5FZe/HTpc9N90c6MOTPtnv9foajHdmHweolib2ZlmIX28qCf8JefTsn
         EgKt4jK+rznbSKiiTR4gJw2rASyiJd10jUHY5dJcBMbmxoNoQE213035MokdBTZ79jdj
         vxhm/4JgLo3dzK1ift8N98J8dnymUIVytmyU6wwhV8b8iFZ1aHr5cpaIyrrOMV/c3ktb
         FDHf/pfxx+A2cqkYH6SaLFHan4Z69V6avjH1JMozvTpL7gy93qO+3AQ2L0oy8Lr1xRV0
         PJ44bfA+VMasDLK0Ok30EwYTQj7nVHydWCjgOsV8fgbwIll1HOBkE5i+uqrcQiPb15Kk
         4bvQ==
X-Forwarded-Encrypted: i=1; AKwUvByj120rhrCwMWZYLmS4MNrGC2IEEBvWk5KQpCpU5SY+59KcDYjCsa0s71zs5xFYLvmN/ROMajfxFyV6S/0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK1hVrXPxWwbibzQ7MVu+yFYFpRqha2S3jMphqJlRAZaM65dJPB
	i9ggd7O2KrmUNHNlQmOly7cv/ZMBwjt9DlvRsa33s684jvdqS29v3eZbYafWo1CyzTMJ0WjsKhl
	Yj+chMhEw/y8SeGDf6J5tZNlWKTO0GNo=
X-Gm-Gg: AYBFou1mnT0HkjLbVQXrW65e8c6OuTIAO1X5Ue67jceo38DbhOEjMFjUm0hUSKDQYfU
	GIFEsZWPG/aMruqCKedtzVuc53+US4eXr2q7zu86W+rTfiYiUOodQEBDHBc2OpjhYNKJEyv++NG
	mIcxrP5EuQH4uBi+5XPEia44JsHMdVBjzEhxoqyJfj9oCruWdjwcZfiV7+Kstb1wbr0nsslCIC8
	drVKuwgrkl9mCZ7Q5jp8s3NbQ9l1PWFHvTRAn7mBi8i+ukIcWocF0ajaeoW3HRy275F6g0PWgwm
	ngU2HeNjqJYndOwCeETObjzBRgROQEKMIAHx8SjW1/B+OsxrgJKmV5Ua
X-Received: by 2002:a5d:6f0d:0:b0:48b:677:f80d with SMTP id
 ffacd0b85a97d-48b0677f9aamr3770293f8f.26.1790842176618; Thu, 01 Oct 2026
 01:09:36 -0700 (PDT)
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
References: <20260923062832.479455-1-jiangwen6@xiaomi.com> <20260923062832.479455-10-jiangwen6@xiaomi.com>
 <ar0lMkKxugZV7xyw@milan>
In-Reply-To: <ar0lMkKxugZV7xyw@milan>
From: Wen Jiang <jiangwenxiaomi@gmail.com>
Date: Thu, 1 Oct 2026 16:09:24 +0800
X-Gm-Features: AclHuK8OMAhb_UVj1_7OhXb2I-BHJ5VHW4np9K-mqeZSCcIAGrWhZjO-kRMUNUQ
Message-ID: <CAHKocdEqnCCyW1TgmiRotFO0hQdHt7pXP1sdqzZ7Up6wc+-Bsw@mail.gmail.com>
Subject: Re: [PATCH v9 09/10] mm/vmalloc: map contiguous pages in batches for
 vmap() if possible
To: Uladzislau Rezki <urezki@gmail.com>
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org, 
	will@kernel.org, Xueyuan.chen21@gmail.com, ajd@linux.ibm.com, 
	anshuman.khandual@arm.com, baohua@kernel.org, chleroy@kernel.org, 
	david@kernel.org, dev.jain@arm.com, jiangwen6@xiaomi.com, leo.yan@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, rppt@kernel.org, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Sept 2026 at 23:05, Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Wed, Sep 23, 2026 at 02:28:31PM +0800, Wen Jiang wrote:
> > From: "Barry Song (Xiaomi)" <baohua@kernel.org>
> >
> > In many cases, the pages passed to vmap() may include high-order
> > pages. For example, the systemheap often allocates pages in descending
> > order: order 8, then 4, then 0. Currently, vmap() iterates over every
> > page individually=E2=80=94even pages inside a high-order block are hand=
led
> > one by one.
> >
> > This patch detects physically contiguous pages (regardless of whether
> > they are compound or non-compound) by scanning with
> > num_pages_contiguous(), and maps them as a single contiguous block
> > whenever possible. The mapping order is determined by taking the
> > minimum of the contiguous page count and the pfn alignment, allowing
> > graceful degradation when pfn alignment is less than the contiguous
> > range.
> >
> > Pages with the same page_shift are coalesced and mapped via
> > vmap_pages_range_noflush_walk() to avoid page table rewalk.
> >
> > As users typically allocate memory in descending orders (e.g.
> > 8 =E2=86=92 4 =E2=86=92 0), once an order-0 page is encountered, we sto=
p scanning
> > for contiguous pages since subsequent pages are likely order-0 as well.
> >
> > Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
> > Co-developed-by: Dev Jain <dev.jain@arm.com>
> > Signed-off-by: Dev Jain <dev.jain@arm.com>
> > Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> > Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> > Tested-by: Leo Yan <leo.yan@arm.com>
> > ---
> >  mm/vmalloc.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 80 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index a43965016eb4d..37cddb7f45a4f 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3576,6 +3576,85 @@ static inline unsigned int vm_shift(pgprot_t pro=
t, unsigned long size)
> >       return arch_vmap_pte_supported_shift(size);
> >  }
> >
> > +static inline int get_vmap_batch_order(struct page **pages,
> > +             pgprot_t prot, unsigned int nr_pages)
> >
> get_vmap_mapping_order()?
>

Agreed, that's a clearer name.

> > +{
> > +     unsigned long pfn;
> > +     unsigned int nr_contig;
> > +     int order;
> > +
> > +     if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
> > +             return 0;
> > +
> > +     /* Limit nr_pages by pfn alignment */
> > +     pfn =3D page_to_pfn(*pages);
> > +     if (pfn > 0)
> > +             nr_pages =3D min_t(size_t, nr_pages, 1UL << __ffs(pfn));
> > +
> > +     nr_contig =3D num_pages_contiguous(pages, nr_pages);
> > +     if (nr_contig < 2)
> > +             return 0;
> > +
> > +     order =3D ilog2(nr_contig);
> > +
> > +     if (vm_shift(prot, PAGE_SIZE << order) =3D=3D PAGE_SHIFT)
> > +             return 0;
> > +
> > +     return order;
> > +}
> > +
> > +static int vmap_pages_range_batched(unsigned long addr, unsigned long =
end,
> > +             pgprot_t prot, struct page **pages)
> > +{
> > +     const unsigned int nr_pages =3D (end - addr) >> PAGE_SHIFT;
> > +     unsigned int prev_shift =3D 0, batch_idx =3D 0;
> > +     unsigned long batch_start =3D addr, batch_end =3D addr;
> > +     int err;
> > +
> > +     err =3D kmsan_vmap_pages_range_noflush(addr, end, prot, pages,
> > +                                          PAGE_SHIFT, GFP_KERNEL);
> > +
> > +     if (err)
> > +             goto out;
> > +
> > +     for (unsigned int i =3D 0; i < nr_pages; ) {
> > +             unsigned int shift =3D PAGE_SHIFT +
> > +                     get_vmap_batch_order(pages + i, prot, nr_pages - =
i);
> > +
> > +             if (!i)
> > +                     prev_shift =3D shift;
> > +
> > +             if (shift !=3D prev_shift) {
> > +                     err =3D vmap_pages_range_noflush_walk(batch_start=
, batch_end,
> > +                                     prot, pages + batch_idx, prev_shi=
ft);
> > +                     if (err)
> > +                             goto out;
> > +                     prev_shift =3D shift;
> > +                     batch_start =3D batch_end;
> > +                     batch_idx =3D i;
> > +             }
> > +
> > +             /*
> > +              * Once we fail to batch pages, we expect to fail batchin=
g
> > +              * for all remaining pages, so just give up.
> > +              */
> > +             if (shift =3D=3D PAGE_SHIFT)
> > +                     break;
> > +
> > +             batch_end +=3D 1UL << shift;
> > +             i +=3D 1U << (shift - PAGE_SHIFT);
> > +     }
> > +
> > +     /* Remaining */
> > +     if (batch_start < end)
> > +             err =3D vmap_pages_range_noflush_walk(batch_start, end, p=
rot,
> > +                             pages + batch_idx, prev_shift);
> > +
> > +out:
> > +     flush_cache_vmap(addr, end);
> > +     return err;
> >
> On error, if kmsan_vmap_pages_range_noflush() succeed you do not do a
> proper cleanup?
>
> i.e. to cleanup KMSAN metadata: kmsan_vunmap_range_noflush(addr, end);
>

The KMSAN metadata is cleaned up by the caller: on error vmap calls
vunmap(area->addr), which reaches kmsan_vunmap_range_noflush() through
remove_vm_area() -> free_unmap_vmap_area() -> vunmap_range_noflush().
That is the same contract as the pre-existing vmap_pages_range() path,
which likewise relied on the caller's vunmap() to clean up. So there
is no behavioral
change here.

Thanks,
Wen

> > +}
> > +
> >  /**
> >   * vmap - map an array of pages into virtually contiguous space
> >   * @pages: array of page pointers
> > @@ -3619,8 +3698,7 @@ void *vmap(struct page **pages, unsigned int coun=
t,
> >               return NULL;
> >
> >       addr =3D (unsigned long)area->addr;
> > -     if (vmap_pages_range(addr, addr + size, pgprot_nx(prot),
> > -                             pages, PAGE_SHIFT) < 0) {
> > +     if (vmap_pages_range_batched(addr, addr + size, pgprot_nx(prot), =
pages) < 0) {
> >               vunmap(area->addr);
> >               return NULL;
> >       }
> > --
> > 2.34.1
> >

