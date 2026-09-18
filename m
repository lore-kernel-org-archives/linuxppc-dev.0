Return-Path: <linuxppc-dev+bounces-27684-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602AEC982D2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 08:37:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmQxD0b4Lz2y7r;
	Fri, 18 Sep 2026 18:37:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:30::10" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789720672;
	cv=pass; b=hO8xuYRJIJIduDu0F+Ue7NmOl482WEz/eyqq+q+EncJ2rWoxZp091nOjxPGjq17cZHCeMo1Q2R18plizmXzq3geMGMB70k9FvjpIg4FPgsgpuSrquAI0QLmMr8CWJIlmAKW4PvVmOLUVw2kZOKSORf37UQVRtluFKiUpZGBYywAVoQvC29FNLXzqSQGtkJ/4rIZxD+cPDh+fDPfWWskfSDd+zUnYqouBr98mitYo4IJVtzVDgnLZ3n3OUBXCdrPhp2yELV8z0/YC1jko3U2Vcq8pOAuCBx8JyCznKudbo3ECXdiDVc6dZTuNEVF8inytGo2CF6OBRTeeYRHPrR8f1w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789720672; c=relaxed/relaxed;
	bh=m0yQ4rBAEiKMEofLz40Ao8DmOY1a2/mbTmLdfwCpmzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ea+W9NU4z/KF9xP6cabA/2nFRztOYBnimLs5OSKt5ibHwCQjHRFUjugzePXkaWSdjTTvIcgOvwfEpGGuwXAbZmKDEWqeSNMJzLYxzrPuDrAUV7od7WmlCFSa5Hf9ub7cz6i6ujrSLHZbiBWtk1qdQ7R7RqOd50oOxW6Zm8EvHZXc3MCsJ+35m/qhkIDBX+qBdktmpjgV/GgcsTTkGwEvBk7VaultAT0MrFGaaU1Q31i1acIIMxpYGRAPTluZsAFxQ0kQo7FnQeE3JddEMw+6XkM0+35X2u4Am2UUfI3/FgA99W70SCffOiS5EbPAV0fWQsFsey3Xl1nJ5d5C11P6lw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KsJoFKP6; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KsJoFKP6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com [IPv6:2a00:1450:4864:30::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmQxB3Jgsz2y2W
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 18:37:48 +1000 (AEST)
Received: by mail-wr2-x10.google.com with SMTP id ffacd0b85a97d-4843172bff4so214258f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 01:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789720665; cv=none;
        d=google.com; s=arc-20260327;
        b=ZbkNPfcys/0utKYX1qb7w/qx8iVsc1m9I3+MTIor5MD5IF/NYAOk8W34l2ba4ryv1o
         dTV3okqFK9bMBMDNMQD6QTHLqHkHi/pzQF4qKG9exXKfTjD8LvJu6LAZsoMop+S7vBIV
         ljgLKQ7iCVyzSu0QLKd2lM6uTIZYb+6BNqqQ3d0/yRU1OLElAsRf8ACU9jhkTwku7n0d
         sN+k36ZTP1bl6LQK9TkTAXanm5k/0zaUbx5LE3Y51vn2xHkgkVl7/5PWl+KKQGyy7jqF
         rEljcOkF4dCAvbcdS1jmFPwYST4HIfxvWZyudbwsV+uxbpE4BInnQRf8YCD1WaRt6Hsd
         NJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m0yQ4rBAEiKMEofLz40Ao8DmOY1a2/mbTmLdfwCpmzU=;
        fh=vNuQQdFxvqSPq4TlJQwwyqxTV2FXX+8MjhwaMw4cT40=;
        b=b0QH6YsT3k8ovkoptDmiAL19S8kk9pgeKU/MsXFQynVf4ehR/pqIFlHFJ90VINJ2Uo
         OlH0hMTL0b/LaWD1kUfK5zfedK5pWRb9XolRuI4pw51JAp4ASyIUoXV3gRt1UB9GDgVE
         lgq4MdsJ/fCS2dJ8BC0qSZFR9bjs/B7HXbvZDqcxN6W7z+A5lrutAt+W9fCOL8g5CLcB
         VZqb6/zHLXCq22lswL5rn5dQ1GhL+PGan/j0J4+s21P4Kx0WKlw54TI/d8X5jvuidVVj
         a7RJquBiuiAHpO/dx6qpoGQKXtqL+BMZFOl76Un45f1BSQBy2XGhy+L7Q54kP5uI1Uac
         xDOg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789720665; x=1790325465; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m0yQ4rBAEiKMEofLz40Ao8DmOY1a2/mbTmLdfwCpmzU=;
        b=KsJoFKP6fliwHXtRyuiJecwbIYdPyPn/0eCp5BHvnNrRgx7ufhoEaB3gBM7VeyUhe7
         63gB6fM9LMvq95mvIDlwnozEsfkamTzbuy7t1trHX9dtluppxyf7N5BA+siBmWObVKUM
         HUsev/YNSaD9AG364U6Oy7GSYbySVCI6xIlZnlZobzHEAJtCOKMKIhGBNq6Z/ZouPxI3
         OaD9AhTazJYCDkKOp8iBbjRUvKcNrNYLtmLNTeET30dU6+fwKTsU/J1/u2CV/9FfOO6t
         tfuxxHJ/IsLr+lYBiCO3qkYuEoysUZR0TE7RcWBv3fcKUw50dEz702JfReu6WFE/4M+T
         16IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789720665; x=1790325465;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m0yQ4rBAEiKMEofLz40Ao8DmOY1a2/mbTmLdfwCpmzU=;
        b=B0dAzexaWuYzJ24JvbfqUM9ghrfsCBmf5z5Vl2CkLSPWKoFFWtjsyuDDbeVQHGAm+X
         vA7hX5Oz0+N3OjUgWhafjQJ28ithqKcnveBe8toB0DtMwLxxyNJpJhMQDnyO0/duF93d
         Y6Cmw5xxcinbLZHpA4gUYHiirt62bzgB/dAHaHFGUMlu8O+cbtYcNMiiJ2Jhez3xQ66e
         NlXPrYMDHEhuMyg7L92JjFbiXbFFqgjIPp4oZGZH0H13Fe7sUrKQGjv04ku0QESYHh7/
         d+iZ0J+BKl/BBeabxxB/GMrGwz8hhFD+/+HVNSvodqjJQax5/peqAGgztgXaHF9kKww5
         ouSQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4ABq8CM9K8DL0oSyaz3yjEoAPjD1l67SBuQDVbBHDEnB6gMeuBHqD5fZ+MA+ONrKSTiuEgu0maCHEkDo=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m5bieHcusIhhmigW9eg31nM1kfzyizikKEXoOmNxnwMpB1sTIa
	DL0ehVoxuoUiddt0h8zBCIiYtxOFMJfPdUnYJ/0FClbA4c9lixPWIO4dsBLn4NkhBl246MeX2xE
	PCQRZu9U0uEQK3yG7eoflz9RFUxgOlpA=
X-Gm-Gg: AYBFou2vtJ/yvseCdf0/SLjZdVYQDsWRBmkejwEQaW0prgywmas9g1VY30S6ORN3XJ6
	DqEZbmXt0wE+8XWHEoM2m9SWXRlr8BAzPEfBOjREYPw0Zzy4ij1DelXP9Ws4Vw1sR5BVQls0wQW
	GZB48Deyavj6Mut+42o95yiVr/MxUbrRWabsJisuy/igNJOVi8q2t4h4CuQjsT0rn1wcJcjp8Va
	Pttr5JdFN6OX8EPjOvEcjH+K0Kz4mmGtx4i9EMD6fQkhOBjyG0XrAHqhUJUSRvcOd6bwZcAOzaV
	W2G4khiK8jMSUnIbrkrQVqs0YvhUmBpvloVNFXWzYAGWNa2dSsA7XtuC
X-Received: by 2002:a5d:5f4f:0:b0:486:f4ae:72a2 with SMTP id
 ffacd0b85a97d-4871e2131a7mr2297716f8f.1.1789720665326; Fri, 18 Sep 2026
 01:37:45 -0700 (PDT)
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
 <CAGsJ_4yJ-KCHbJ9S2GKXfO51KB8g-y2Q_MikqE9-6VesR-RC9Q@mail.gmail.com>
 <2462f67c-f7d3-4eb3-a093-6a338ef49f14@kernel.org> <CAGsJ_4zMG6v-ioi8-NhveqowPVAnsHkFCNy_c7+KHDMRW3JH-Q@mail.gmail.com>
 <24aedc8c-a5c6-418b-a37e-051f0d6d9fa7@kernel.org>
In-Reply-To: <24aedc8c-a5c6-418b-a37e-051f0d6d9fa7@kernel.org>
From: Wen Jiang <jiangwenxiaomi@gmail.com>
Date: Fri, 18 Sep 2026 16:37:34 +0800
X-Gm-Features: AcwNN1XBh3Wey2x3l7KbPhov9h79lwYf3qMIq1ZNnS7cqxD6HqWXu6Gr_vbTLnA
Message-ID: <CAHKocdEmb-Hsxu8FCxvzhz3XdzmrPddGo4wv6GqjeHvAYfxVrQ@mail.gmail.com>
Subject: Re: [PATCH v8 03/10] mm/vmalloc: use pte_set_huge()/pte_clear_huge()
 for PTE-level block mappings
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Barry Song <baohua@kernel.org>, akpm@linux-foundation.org, catalin.marinas@arm.com, 
	linux-mm@kvack.org, urezki@gmail.com, will@kernel.org, 
	Xueyuan.chen21@gmail.com, ajd@linux.ibm.com, anshuman.khandual@arm.com, 
	david@kernel.org, dev.jain@arm.com, jiangwen6@xiaomi.com, leo.yan@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, rppt@kernel.org, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Sept 2026 at 15:04, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
>
>
> Le 18/09/2026 =C3=A0 08:14, Barry Song a =C3=A9crit :
> > On Fri, Sep 18, 2026 at 2:05=E2=80=AFPM Christophe Leroy (CS GROUP)
> > <chleroy@kernel.org> wrote:
> >>
> >>
> >>
> >> Le 17/09/2026 =C3=A0 23:44, Barry Song a =C3=A9crit :
> >>> On Thu, Sep 17, 2026 at 10:41=E2=80=AFPM Wen Jiang <jiangwenxiaomi@gm=
ail.com> wrote:
> > [...]
> >
> >>>>>>
> >>>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >>>>>> index cdd68ed3ae1a9..349ced999f959 100644
> >>>>>> --- a/include/linux/pgtable.h
> >>>>>> +++ b/include/linux/pgtable.h
> >>>>>> @@ -2134,6 +2134,35 @@ static inline int pmd_free_pte_page(pmd_t *=
pmd, unsigned long addr)
> >>>>>>     }
> >>>>>>     #endif      /* CONFIG_HAVE_ARCH_HUGE_VMAP */
> >>>>>>
> >>>>>> +/*
> >>>>>> + * PTE-level block mappings for vmap.
> >>>>>> + *
> >>>>>> + * pte_set_huge() only has to be implemented by architectures who=
se
> >>>>>> + * arch_vmap_pte_range_map_size() can return a size other than PA=
GE_SIZE.
> >>>>>> + */
> >>>>>> +#ifndef __HAVE_ARCH_PTE_SET_HUGE
> >>>>>> +static inline void pte_set_huge(pte_t *ptep, unsigned long addr,
> >>>>>> +                             phys_addr_t phys, pgprot_t prot,
> >>>>>> +                             unsigned long size)
> >>>>>> +{
> >>>>>> +     WARN_ON_ONCE(1);
> >>>>>
> >>>>> BUILD_BUG_ON() would be better here.
> >>>>>
> >>>>> It should be possible because fallback arch_vmap_pte_range_map_size=
()
> >>>>> will constant-fold PAGE_SIZE so pte_set_huge() will never be called=
.
> >>>>>
> >>>>
> >>>> Agreed. These fallbacks exist only to keep the build working on
> >>>> architectures with PTE-level block mappings and should never actuall=
y
> >>>> be reached, so BUILD_BUG_ON() is right. I'll make that change in v9.
> >>>>
> >>>
> >>> I am not quite sure. It won't be called at runtime because
> >>> `vmap size`/`unmap size` return `PAGE_SIZE`, so the code won't
> >>> reach this branch. But it will still be built.
> >>
> >> The fallbacks are defined as:
> >>
> >> #ifndef arch_vmap_pte_range_map_size
> >> static inline unsigned long arch_vmap_pte_range_map_size(unsigned long
> >> addr, unsigned long end,
> >>                                                           u64 pfn, uns=
igned int max_page_shift)
> >> {
> >>          return PAGE_SIZE;
> >> }
> >> #endif
> >>
> >> #ifndef arch_vmap_pte_range_unmap_size
> >> static inline unsigned long arch_vmap_pte_range_unmap_size(unsigned lo=
ng
> >> addr,
> >>                                                             pte_t *pte=
p)
> >> {
> >>          return PAGE_SIZE;
> >> }
> >> #endif
> >>
> >> Therefore in:
> >>
> >>                   size =3D arch_vmap_pte_range_unmap_size(addr, pte);
> >>                   if (size !=3D PAGE_SIZE) {
> >>
> >> GCC knows 'size' is const and its value is PAGE_SIZE, so it won't emit
> >> the branch at all.
> >>
> >> It is call constant folding, some explanation here:
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fen=
.wikipedia.org%2Fwiki%2FConstant_folding&data=3D05%7C02%7Cchristophe.leroy%=
40csgroup.eu%7C869dac21f28d45988a3d08df154c225a%7C8b87af7d86474dc78df45f69a=
2011bb5%7C0%7C0%7C639253088878897551%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcG=
kiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D=
%3D%7C0%7C%7C%7C&sdata=3DDvtz1%2FAHvAbVYO%2BRaHTOizcD%2FclJ9FqTcWXKMhIFVyw%=
3D&reserved=3D0
> >>
> >>>
> >>> So, would a `BUILD_BUG_ON()` trigger a build failure here?
> >>
> >> It shouldn't, if it does it is a compiled bug or this is because someo=
ne
> >> has redefined arch_vmap_pte_range_map_size() and not pte_set_huge()
> >> which we'd better know at build time rather than at runtime.
> >
> > Thanks, Christophe. I was also thinking about compiler optimization. I
> > was just a bit worried that we're touching the common MM code, which
> > affects almost all architectures, so I'm not quite sure whether this is
> > supported by all GCC versions used by those architectures.
> >
> > If it is supported by all of them, I agree that `BUILD_BUG_ON()` is a
> > perfect approach.
>
> AFAIU this is the assumption made by the kernel, see
> https://docs.kernel.org/process/coding-style.html#conditional-compilation
>
> This is the same compiler, I see no reason why ability to constant-fold
> would be dependant on architecture.
>
> Christophe

Hi Barry and Christophe,

pgtable.h already does this in a few places, the !THP fallback of
pmdp_clear_flush_young() is just BUILD_BUG(), and its caller in mm/rmap.c,
a file that is built unconditionally, is guarded by
IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) rather than #ifdef. So on every
THP=3Dn build, on every architecture, that call has to be eliminated by
the compiler or the build breaks.

I built it with BUILD_BUG() on x86_64, arm64 and powerpc (8xx) to be sure,
and all three are clean.

It will be BUILD_BUG() rather than BUILD_BUG_ON(1): BUILD_BUG_ON() expects =
a
condition the compiler should know is false, while BUILD_BUG() is documente=
d
as the way to flag code that is expected to be eliminated at build time.

Thanks,
Wen

