Return-Path: <linuxppc-dev+bounces-27578-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7B1C982D8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 14:41:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlz2l0C8Kz2y2W;
	Fri, 18 Sep 2026 00:41:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:31::11" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789656062;
	cv=pass; b=WXJiq3qMxIYMjU93G98zidArP/JIjjTiJCx8AMnMODtc2yqy/8Z1QIchmsIGlAiSSIyPb8TsM8DUJG9Xh6pQdpBFWhfCetTJZBqmogwwAOanLq6GCPU6zwQZxb+4Zscm2xUdMsraiZqfv/VXEEPwbqPrGrB1vaKq8l3fKEnjtJxg9Zk5jHD3khlaXNQb9EV0n90a/r/Vm/hsOMvSz21r9KOqqCx068zLurWnY1dPdi56eZz8htmMyaeLuKoKy2l70inxAok8grQS7yYqhelfw5W/RqMA3ymD0h7plYzRhO2+cPadd20lKo5Xps4U+d4oh2RLBbQ+VFH+xGNExB8ymg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789656062; c=relaxed/relaxed;
	bh=tKlGaZ7QcAexG2kTHUATEVY4bTePWKI9i02YcMMarMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJWHX3TUJo4lN3eC3GTsV6druqEAdDVQf5VS9+TNVC/nU6lsLwLf7e14joo9Gj2mBH+cz9qhdSKiCoRJslc8f1Zkfg3FPbLaZc+R+yMDqSJaudBa0wH9JMJbP51WAefx2OkS6OP+/lS5tmmXdRw4u3zFFtTUrzYoSm87LwzvKMLG/4IcH2u/16yLXopoD0DoiWixMDDQdzDdtimY46t/axq4L72eiuxco42cOJmEOZaBMxWv/jYW40EGIfNbURtUh1MBfmrYq8+3ENJBBD4dqlaKI6DaIJ05euB+lbHuaGWQKQaa+LZlv27PKX5FBuq3j0YehgK2xABTMMRjn6klyg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fzavn8hc; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fzavn8hc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com [IPv6:2a00:1450:4864:31::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlz2j4wG3z2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 00:41:00 +1000 (AEST)
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49b912e2406so4990145e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 07:41:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789656057; cv=none;
        d=google.com; s=arc-20260327;
        b=E8PxzyTkEypJo+pOScUeHN6QLw7pUl+bL69TG3Vo1/pvI99ob552DpUHNW6261AsFF
         xo4UmAjwmqbknY4TUSRFFmOVF0pnnuRuRiyOjiVR9xZqC2wVexUlSF3ehj3Qxtsi0nI9
         BSEyGc6vKE/2jNdMM7UYlEEnnu+gHM5719I4sSCpyVUG8lTm5txAXhrNGz8DGFxLRm2L
         Lnz4RFjzsaqzW8PexnZmOo4wKUwhf49sHnpT6pX6PYUa960HRuhYei12VQ5ekVpl4LZ1
         MxiiL2Wtw8rgQtMLYL5H2VNmzDy+pH+WJIFWlkBzH0vJ0qwxpkmzddJJjs0e9YhRsqeX
         oZGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tKlGaZ7QcAexG2kTHUATEVY4bTePWKI9i02YcMMarMU=;
        fh=+6nJuPa1PWr+wteKdxOCglHqcnAg/m23n7jOYFuSSxA=;
        b=DrbVYXdbdSmEX8WGngtWYw8D4c3H346rtgsjsTbhIPw89/PZgzJWnd5x6S4Kel2SsB
         eXm+YOspF0hPHrXYFt+BELNpTiunCkBp6DGke+ZvRGqDE+7vDpSIlpikJ8u9rxeF60Bi
         UMzP7kVSm04AdaAG+fM1VHsAHjbjSrKjic70TdcRwm9UTk/qr8m3LR2F+XBsa9tfb+Lz
         QfS2xCR1NL9hLgy/6La+red2kwGdfWFJNd1o0B/T/+e5ne71haqCBhvU2Qr871gMJPVy
         PVywWWHBlKJDnMSja18KUWG1zCtoqxn2usNB4QOIkgK9QGRtU1oD1XGYCvEpLEvL6NUE
         SGNg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789656057; x=1790260857; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tKlGaZ7QcAexG2kTHUATEVY4bTePWKI9i02YcMMarMU=;
        b=Fzavn8hcZh7mZuHm/4tRkHUhpjL8fItY6j4gqoqv5uh7MArs7U7nZbY1+G5Vw67Xki
         QefwICDbPeYIdz6Sq7SXL2/8Or41rPClcIxQUVHSzQJuTZPZTj5OxUm55MMF4Bq8iY3x
         6xS0tmEIC0yToTnbluOLX8lVmfWGaIeT+nYdvcxFRn9d/2JqZje96Tct8ogj9T201z8u
         9WRkmmJ+o8BMkP4Hq6iK5saC8X73d/pa4NnC4WthS+jvFt276hGtnKG7kiElz0/s2bi2
         A1CkgVC5lcsfQwXWxKUglogWfk3CayLTLnsBTUviYrXdQzdmjuBQ15UwWpyPac2gNX1Y
         KxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789656057; x=1790260857;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tKlGaZ7QcAexG2kTHUATEVY4bTePWKI9i02YcMMarMU=;
        b=13fDmAr60M0MPu2E1SV2jxPR0+zXI0sJmFJx68i+DdWYg55Poyd0UxTqJxSjL62XLq
         fjEWapwhnA8+8vVmfc/u+9PUZiRGDB2Tsxv0oljaJZnaP71KMVdro4prL0PXqdzwXupR
         vRxHQyYI54hC0n+Jpfr3Dle8ghXeBWadvjF2V6CG3mWllVUYBHLMrAOc0sjZkVwEvV7U
         zyRYv6fKWzHxMIhYja4K5SDqWzAJiQMc+wVvndKwLdkmyN/O6mVCrCLEmNEx/JMKiDT0
         mkmgfoyT1y7DgphEEJ4/R/TrWxieNsVsfN1+T7jS4gT59EhbDQ51EEJUSZTbZcAu5UOA
         p1EA==
X-Forwarded-Encrypted: i=1; AKwUvBx/KwHn6BOEnWCZ+V4OUw0AzrRdkfs2VkK6MmLWeORes/2AZxHJoDxYdtEitnfXXedH7ZIvJs3JCabTxGU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mdSL9F/U2DniJnNR+hGK3pLnLHu9q3ZZR0/ne4CkwAsdJcpEDd
	TS6gQ+bh6OUP8Ss4yXYdK01uS/9nDJkGoQnxHzIDfjGlET6maqEEsRXDe152Nsc0sLkUHYUERb2
	MHUy01CRStDG+wo9z/ZMw67N7HM0wQK8=
X-Gm-Gg: AYBFou0IU2xoQB90ZVHHtUQhJfbSiM19dL8XkTNnbZDKZLHQGjWKkUeD+SXFBOIhvwF
	mb2487RkJ4oiqOGyHSHtJhPXSygqJHYiM6fuFTqSfgHJJs3fTsLPJQzMnB3knO51ut5B7GDZ3zZ
	KU9AhxL0if1ZnwC0QQJYoVmALOihAtO4E2wzY8FasgiWx+GQACcQ4MMsGdgDBufCWLOUfYr3OEu
	hVoWGRveYEOMbYSn1rnWKGPeX7wFbQ+9yivp3wDHXUITShttwG7nqJPPest17P3ZDFdQo+KULUP
	nAbYtFt+5Z8R5k6ZALfWHaUUGRR2q4AlXpCV8BbSkyd+7xP5Po9AmfGI
X-Received: by 2002:a05:600c:c490:b0:49c:e37e:4389 with SMTP id
 5b1f17b1804b1-49fbd1b7e82mr50298125e9.4.1789656056433; Thu, 17 Sep 2026
 07:40:56 -0700 (PDT)
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
References: <20260917052933.188679-1-jiangwenxiaomi@gmail.com>
 <20260917052933.188679-4-jiangwenxiaomi@gmail.com> <27072d94-13bf-4bea-948a-d8a67976601e@kernel.org>
In-Reply-To: <27072d94-13bf-4bea-948a-d8a67976601e@kernel.org>
From: Wen Jiang <jiangwenxiaomi@gmail.com>
Date: Thu, 17 Sep 2026 22:40:46 +0800
X-Gm-Features: AcwNN1Xe57v3xkT9n8VgdwgVRkLfN2sWNkgkjHSUvI4F8KcWXjC4skCrmqkDzZ4
Message-ID: <CAHKocdE_zyUQT459AiTBDzQHk0jh+VpXuSMDdgHjkg-dAkgBNg@mail.gmail.com>
Subject: Re: [PATCH v8 03/10] mm/vmalloc: use pte_set_huge()/pte_clear_huge()
 for PTE-level block mappings
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org, 
	urezki@gmail.com, will@kernel.org, Xueyuan.chen21@gmail.com, 
	ajd@linux.ibm.com, anshuman.khandual@arm.com, baohua@kernel.org, 
	david@kernel.org, dev.jain@arm.com, jiangwen6@xiaomi.com, leo.yan@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, rppt@kernel.org, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Sept 2026 at 22:00, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
>
>
> Le 17/09/2026 =C3=A0 07:29, Wen Jiang a =C3=A9crit :
> > From: Wen Jiang <jiangwen6@xiaomi.com>
> >
> > vmap installs PTE-level block mappings by reusing set_huge_pte_at() and
> > huge_ptep_get_and_clear() under #ifdef CONFIG_HUGETLB_PAGE. This makes
> > the feature silently unavailable on CONFIG_HUGETLB_PAGE=3Dn kernels and
> > couples mm/vmalloc.c to HugeTLB internals it does not otherwise need.
> >
> > Now that arm64 and powerpc/8xx provide pte_set_huge() and
> > pte_clear_huge(), add the generic fallbacks next to the existing
> > pmd/pud_set_huge() family and convert vmap_pte_range() and
> > vunmap_pte_range() to the new helpers. The CONFIG_HUGETLB_PAGE guards
> > around the block-mapping paths are dropped, so PTE-level block mappings
> > now also work on CONFIG_HUGETLB_PAGE=3Dn kernels, and mm/vmalloc.c no
> > longer includes <linux/hugetlb.h>.
> >
> > The fallbacks exist only to keep the build working on architectures
> > without PTE-level block mapping support. They are unreachable there:
> > the callers only run when arch_vmap_pte_range_map_size() or
> > arch_vmap_pte_range_unmap_size() return a size other than PAGE_SIZE,
> > which requires an arch implementation. WARN_ON_ONCE() makes that
> > explicit rather than silently doing nothing.
> >
> > Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> > ---
> >   include/linux/pgtable.h | 29 +++++++++++++++++++++++++++++
> >   mm/vmalloc.c            | 19 ++++++-------------
> >   2 files changed, 35 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index cdd68ed3ae1a9..349ced999f959 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -2134,6 +2134,35 @@ static inline int pmd_free_pte_page(pmd_t *pmd, =
unsigned long addr)
> >   }
> >   #endif      /* CONFIG_HAVE_ARCH_HUGE_VMAP */
> >
> > +/*
> > + * PTE-level block mappings for vmap.
> > + *
> > + * pte_set_huge() only has to be implemented by architectures whose
> > + * arch_vmap_pte_range_map_size() can return a size other than PAGE_SI=
ZE.
> > + */
> > +#ifndef __HAVE_ARCH_PTE_SET_HUGE
> > +static inline void pte_set_huge(pte_t *ptep, unsigned long addr,
> > +                             phys_addr_t phys, pgprot_t prot,
> > +                             unsigned long size)
> > +{
> > +     WARN_ON_ONCE(1);
>
> BUILD_BUG_ON() would be better here.
>
> It should be possible because fallback arch_vmap_pte_range_map_size()
> will constant-fold PAGE_SIZE so pte_set_huge() will never be called.
>

Agreed. These fallbacks exist only to keep the build working on
architectures with PTE-level block mappings and should never actually
be reached, so BUILD_BUG_ON() is right. I'll make that change in v9.

Thanks,
Wen
> > +}
> > +#endif
> > +
> > +/*
> > + * Likewise, pte_clear_huge() only has to be implemented by architectu=
res
> > + * whose arch_vmap_pte_range_unmap_size() can return a size other than
> > + * PAGE_SIZE.
> > + */
> > +#ifndef __HAVE_ARCH_PTE_CLEAR_HUGE
> > +static inline pte_t pte_clear_huge(pte_t *ptep, unsigned long addr,
> > +                                unsigned long size)
> > +{
> > +     WARN_ON_ONCE(1);
> > +     return __pte(0);
>
> Same I guess.
>
> > +}
> > +#endif
> > +
> >   #ifndef __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
> >   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >   /*

