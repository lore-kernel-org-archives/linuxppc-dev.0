Return-Path: <linuxppc-dev+bounces-27657-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62969C982D2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 06:14:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmMm64ZCfz30M6;
	Fri, 18 Sep 2026 16:14:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789712086;
	cv=none; b=ohGp33miy54B3WX0k340OvPiarVOuY+BTzf3Rmy0h+2LUNmebYs2sLdlLu9pNWInY+zNjKw/DvnlJQ1Dq+sV0pq24yov4ZQSwuW4WyWnXCcevGZ69fP0orJOMScFUNifQ+b6RmrjMi30dd/LzMFnE8eWle7aoSkeYXDZwOMgbpwU4CWPxwXwYEsVJDdEAQW1ALpVb68UMVqWE+7xVMlqh3i7l9y0s2ezwxMpmdidP+bj48ivMz8P75ePpBSjUpZFYHOU11f0q2c30eRVyCYy3GpF2ll5bBMmVVSI16Q4giB+9AcFRESN6Fd4BaDbT3Go27KFrZkFeVgbQEiIdo7eJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789712086; c=relaxed/relaxed;
	bh=mSUon0Ye+JTXHkgGPecismrQ6aWB6KUmBQxrnhvgcgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RU7SkpBU8LhsJI6+EHRyTQeYMZu8XOircabLkzsUUkUg3riG/EXnwdtlFm3m/KBxvsx1Btf+hdZHAonzZZSPxEsP8yEvyzUucvj1BLBYLHsrzN3PAMv0qdAsan3AiDXq/3nmSKJyriD4DRLEUXnLmiMf55hUq7dmTv+I3QR5bDgbaJbickE9+Feh1vIZaTGrhNkhwgGN67LUPajB8tS9kA14XOFfiD0oQUqBN7pfLkVl+CV7nlgIrfURs0GqFN/YswcTvZGI+0sLpYAck2bIfNsK1SXdrXROjWdxJ4wD8D5pvOXVZ9sQWCSU+nq9q2Yn/ThOfpvcwxtz9jJprZF9FQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRu9qUjQ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRu9qUjQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmMm52Q48z2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 16:14:45 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2D86544782
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 06:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124931F00898
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 06:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789712083;
	bh=mSUon0Ye+JTXHkgGPecismrQ6aWB6KUmBQxrnhvgcgA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JRu9qUjQXlRcjBdYLmYId5fUC6gNDmR6uvG9HayWY2hzLkH+HiGKuskUL/ctLgP2U
	 Ob9+gFsoHQpIkKakYQSc0AbdsDy6276zAapXDiWaE9paVunN0VkmUUpMNDSDscA4Dw
	 TvkGHI+97S2SioWsf3/Ey/5smgTkPfQZu5lwVDNsJ+wK04tjbiBQI+ETfTKpxJYqhm
	 sMx5mw0Ln8+FkO+cAoi9V3yM+cMQj4udf54sUfcPw2eDg4/WPE53GkFK1qwojK1mdl
	 O8XwhWGUjhPRf0KLJ2oE243yp5Fxp0NBITZRZQCQ4NAar+SXKaC++dyEEH2NBA+Z/g
	 G9Cm/SO1Eid+g==
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109f067cso41824585a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 23:14:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzb/GZyMncglFiGNbTpJARfDdv20gnNuRnlvBYC/7HoHrg+6UJUC/FgVqssvnRlT8NcSwkizxL3CYQCD4Y=@lists.ozlabs.org
X-Gm-Message-State: AFuF++knu5whwLpRvIFMM8/ivAUQ4UdJtW1n2+m2x4CDErHKqOQQZpW8
	EPthd0tGAd3pQA+s9woo62i8cFIKJ3i/shKq2G9RBUv8rqCRgk7VSMlCev6slB9cVZSoQr0emd0
	0QOomd6cjMwxIMOGFlgrcM5+RyhKBGmI=
X-Received: by 2002:a05:620a:17a3:b0:939:e735:c50e with SMTP id
 af79cd13be357-93bdc6a6970mr193841685a.13.1789712082223; Thu, 17 Sep 2026
 23:14:42 -0700 (PDT)
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
 <CAHKocdE_zyUQT459AiTBDzQHk0jh+VpXuSMDdgHjkg-dAkgBNg@mail.gmail.com>
 <CAGsJ_4yJ-KCHbJ9S2GKXfO51KB8g-y2Q_MikqE9-6VesR-RC9Q@mail.gmail.com> <2462f67c-f7d3-4eb3-a093-6a338ef49f14@kernel.org>
In-Reply-To: <2462f67c-f7d3-4eb3-a093-6a338ef49f14@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Fri, 18 Sep 2026 14:14:31 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zMG6v-ioi8-NhveqowPVAnsHkFCNy_c7+KHDMRW3JH-Q@mail.gmail.com>
X-Gm-Features: AcwNN1X6q5f1Ex-rUff9-91gcAaVXuwTbEB0wMz6EV5siIJ-q7nSpPx4G64lSm8
Message-ID: <CAGsJ_4zMG6v-ioi8-NhveqowPVAnsHkFCNy_c7+KHDMRW3JH-Q@mail.gmail.com>
Subject: Re: [PATCH v8 03/10] mm/vmalloc: use pte_set_huge()/pte_clear_huge()
 for PTE-level block mappings
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Wen Jiang <jiangwenxiaomi@gmail.com>, akpm@linux-foundation.org, 
	catalin.marinas@arm.com, linux-mm@kvack.org, urezki@gmail.com, 
	will@kernel.org, Xueyuan.chen21@gmail.com, ajd@linux.ibm.com, 
	anshuman.khandual@arm.com, david@kernel.org, dev.jain@arm.com, 
	jiangwen6@xiaomi.com, leo.yan@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, rppt@kernel.org, 
	ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 2:05=E2=80=AFPM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
>
>
> Le 17/09/2026 =C3=A0 23:44, Barry Song a =C3=A9crit :
> > On Thu, Sep 17, 2026 at 10:41=E2=80=AFPM Wen Jiang <jiangwenxiaomi@gmai=
l.com> wrote:
[...]

> >>>>
> >>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >>>> index cdd68ed3ae1a9..349ced999f959 100644
> >>>> --- a/include/linux/pgtable.h
> >>>> +++ b/include/linux/pgtable.h
> >>>> @@ -2134,6 +2134,35 @@ static inline int pmd_free_pte_page(pmd_t *pm=
d, unsigned long addr)
> >>>>    }
> >>>>    #endif      /* CONFIG_HAVE_ARCH_HUGE_VMAP */
> >>>>
> >>>> +/*
> >>>> + * PTE-level block mappings for vmap.
> >>>> + *
> >>>> + * pte_set_huge() only has to be implemented by architectures whose
> >>>> + * arch_vmap_pte_range_map_size() can return a size other than PAGE=
_SIZE.
> >>>> + */
> >>>> +#ifndef __HAVE_ARCH_PTE_SET_HUGE
> >>>> +static inline void pte_set_huge(pte_t *ptep, unsigned long addr,
> >>>> +                             phys_addr_t phys, pgprot_t prot,
> >>>> +                             unsigned long size)
> >>>> +{
> >>>> +     WARN_ON_ONCE(1);
> >>>
> >>> BUILD_BUG_ON() would be better here.
> >>>
> >>> It should be possible because fallback arch_vmap_pte_range_map_size()
> >>> will constant-fold PAGE_SIZE so pte_set_huge() will never be called.
> >>>
> >>
> >> Agreed. These fallbacks exist only to keep the build working on
> >> architectures with PTE-level block mappings and should never actually
> >> be reached, so BUILD_BUG_ON() is right. I'll make that change in v9.
> >>
> >
> > I am not quite sure. It won't be called at runtime because
> > `vmap size`/`unmap size` return `PAGE_SIZE`, so the code won't
> > reach this branch. But it will still be built.
>
> The fallbacks are defined as:
>
> #ifndef arch_vmap_pte_range_map_size
> static inline unsigned long arch_vmap_pte_range_map_size(unsigned long
> addr, unsigned long end,
>                                                          u64 pfn, unsigne=
d int max_page_shift)
> {
>         return PAGE_SIZE;
> }
> #endif
>
> #ifndef arch_vmap_pte_range_unmap_size
> static inline unsigned long arch_vmap_pte_range_unmap_size(unsigned long
> addr,
>                                                            pte_t *ptep)
> {
>         return PAGE_SIZE;
> }
> #endif
>
> Therefore in:
>
>                  size =3D arch_vmap_pte_range_unmap_size(addr, pte);
>                  if (size !=3D PAGE_SIZE) {
>
> GCC knows 'size' is const and its value is PAGE_SIZE, so it won't emit
> the branch at all.
>
> It is call constant folding, some explanation here:
> https://en.wikipedia.org/wiki/Constant_folding
>
> >
> > So, would a `BUILD_BUG_ON()` trigger a build failure here?
>
> It shouldn't, if it does it is a compiled bug or this is because someone
> has redefined arch_vmap_pte_range_map_size() and not pte_set_huge()
> which we'd better know at build time rather than at runtime.

Thanks, Christophe. I was also thinking about compiler optimization. I
was just a bit worried that we're touching the common MM code, which
affects almost all architectures, so I'm not quite sure whether this is
supported by all GCC versions used by those architectures.

If it is supported by all of them, I agree that `BUILD_BUG_ON()` is a
perfect approach.

Best Regards
Barry

