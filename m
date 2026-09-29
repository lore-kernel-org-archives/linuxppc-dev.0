Return-Path: <linuxppc-dev+bounces-28434-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA9FCA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 02:21:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv23y2Xcdz30Vd;
	Tue, 29 Sep 2026 12:21:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:30::e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790648494;
	cv=pass; b=PRhb6dZ/BL4IT24jhI3JBcPKwyoYRLzzLHDd41znIwGUXhRdNAxiGnz6Qd8jjb6ijDqkvF06LhZxXaucSLYUCNXJS6Hq6GNo4uNKm8r10c0pXRMuGOR6tH/e0NwFyO82QYDxIi+sanOKAepfq7v5IisJiCb6PccW/PNNCIhozzem+13tM7ObN1aH2GrX1KeZb6cCwfTtXww5uP9Obeo4cxzDvYlykqnlAEInzOLISYbwgkbMFvc7PV/eh5CuxsnlAE+GX+d489vXwAy5d/sbYy11+jLkXJrmvrrgd+Gn64zJu0wQLFpnUn89jIgJzCGzt3TvbBHQS5/FwumCoxbDrg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790648494; c=relaxed/relaxed;
	bh=QhRXGlPI7eTuBNU9/cBeyXlhvR5QBZCVis/qgqQbLB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0Ig3J3bgtDzTaPTtVm6JedMz/Qf09LJTxGWcVh3+5tbxhj1kcvx0q4czQvfgstkWg2mZotfesNmLqJ6E9p3gYbGWpfNAaUlZzCzPGMhrb0YLch/Ov6Lq6HXB777vgC0aJerqSNaHimorKuqCgZbPCNIlDA4SzfKUHITlrV1hhkpPgg2C7Q06DAfbSIqR211nMAjtv8aQF04nY0CtudpKUY+KjrlLOQDR7Ew/hORNCK05M93RxuBLukdnchFgCj6cOnPj2P6QwBe50ul0iQ+XjnxKceifQFgM6F2M1IzKdEseu6JBn5pWr1CMx+mZt3liPN0m6Fa/lRA6UTAfuCTCA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IuKiHcho; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:30::e; helo=mail-wr2-x0e.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IuKiHcho;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:30::e; helo=mail-wr2-x0e.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com [IPv6:2a00:1450:4864:30::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv23w6bVbz30Vb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 12:21:31 +1000 (AEST)
Received: by mail-wr2-x0e.google.com with SMTP id ffacd0b85a97d-48af4663da5so43470f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 19:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790648487; cv=none;
        d=google.com; s=arc-20260327;
        b=TuPIUcq1CRMkQ6H9+1OewLXYPR9Dca6dsU4pbWevr2SjEzvSR0lDSPItETaQ+je8uM
         XbLJ7pek3ntIxJDPkAE3PksGjqKoVUBmqBhsxRXybWsSrUeKPdi+B040GJuX6BhMe4SK
         BIrjiGROe2tcmnstp0nz72/4PJ4GelN+gq/vHAMoJZNaU/dcOiQrFoD5G+6g0WevOtVr
         5CZxV02P1fbQOw3JQ1WRNYdGwLJXDt5Y0Tyxynnwl3DeSedNDEAnUAW9c2moalvfL6QT
         mFjJTUMcLqknGSPugAPHTzmCEW3pFeF0B51MI9+yiJ136jt3vaoCdxJG4VbUKHR1Z+dR
         3vLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QhRXGlPI7eTuBNU9/cBeyXlhvR5QBZCVis/qgqQbLB8=;
        fh=SVEPEm+MXG6J272ahk3Z56rqtFg4eCVyoCWks0F1XV0=;
        b=HPhyKtsodzrZ3iAP+phcyDtrZTjv6SObExwM8AEh1MS3OLNML4GiUHDqrR0FMjg/bh
         cjQU8GBBTY1s8kDNRAkGNFwcS/7oWAeIjlX+OzkrMTND/fQjrwO3GC70J2f4ztU20Zdb
         BwIMNxqghsEZABZWrg2QXFlC7QnH1u9KFsHzOr0tyEaZNGma9l5KnCexEF9II88mhmem
         ELm7YeE/H2ZEhcBU+AO9PzT0jR4xyMbwyaVaZ5wn8DpUcd91eFVkWTG1OUoiyvXinVeo
         AR8XwQTH7IxdNvFCNAEBgykO+18Wr1HBFQYU45KXCU9HM8DXPm5frm0SKr2WbuZTqBTV
         U9rw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790648487; x=1791253287; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QhRXGlPI7eTuBNU9/cBeyXlhvR5QBZCVis/qgqQbLB8=;
        b=IuKiHchoJL1pV0+t1QXMx1d0Y9zouDR+eGj4npEMUHvfpT6gBXHOlOiM9MDjbXiPcI
         0UBQDpWMT+1w4277pWlCSYyoseANm+tmQf8yJEn3q8uht3VhUcm0oAuCPZK5sPmawGSm
         jl2DUWAC8ahq5Ljmg06GjW7JoPe057itLfve6BIvkcROZOnZBzqZtKP/3LDBezvVON65
         KgfW93UDjRU7BJ/bvvgUuj3pfLmxzdZ94RHj1s36YFVn4nFyiBKKBI7LYavv8634yA4u
         4xKmq3KJ7PAn1l1CLh8cWjmR6FvcTKVcB14fSbBzNsp4L3pnTIqNB4lUO4htNisLsTMM
         n+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790648487; x=1791253287;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QhRXGlPI7eTuBNU9/cBeyXlhvR5QBZCVis/qgqQbLB8=;
        b=axJcbIDlxQnxr8rhbYB1zRCj24nonwwvgF/F6Ar444GhwBlkWPZWGHWAkjGQlbGlLS
         QQ4Egv3Xf2jYmruSqQ+Gx/MxwFafmpA4vhrSdqCw4/cBGR4n/nnVKYQLEvow8QV7t78+
         qc+ArUKHy4SOqO84ZrTmkT6lp29hDpDtaPuNGfBXboztQbHy+cL08hcryw1RzPHZuOZc
         lSmDNxTCIhRAtEFbm5miXYgm7nW4VT2mRGLh6KunIWJutaFFhHaVJFQDZmTICcvUAFEL
         2VtQZkz5Qbqgcf6Jnc4UmMBVs5qwpm3GSk8TJxHbbX5NFqKw6UVTJiwX02m91/2UL+BC
         vd2Q==
X-Forwarded-Encrypted: i=1; AKwUvBw84b5pg2wc28JTx7tLzqTHv6l9j8smM0nRw4lFxPbBUAZjl+nbdt0OhSHe+FJ2FoIbpy/oLLUU1HBPs04=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJog6B4XUNs7YTXs10k6Qh8T05UvkmoSG8gwA9oiH68dwdtXaCC
	nF/L/6PBFXKjP2YUT2F475PFTMPcLV4pAn/nHs7U5tD7r8AEoAXo4Oknm3jyRdU4GV9aKlC1tbu
	Cr7+p/NWoO3cBKicVrdCdsg7AL83NSqg=
X-Gm-Gg: AYBFou2oRBAJPcdYWX13vxi0JzbFFWakYhVkEj3sTSAaCHaVhzk5Ovh9l/FcJjVoYyF
	5iksgds5EMCROIHPnggL/UNiThKnQzmt9w0v7cpwdoJPcXtry/BmCcyenMHRk0hVaI6nf3/Kzom
	jT12eLRnQwX8TmJSv0GRcpcpA2tgBJuzKhb7TZGuz2ZEBv1X7VFOrQFHxI4kF7gLyXeQuHZXNlJ
	j/0jXnwlhyk2whIJWAqmZozfXMtl2n4P0DaWH0o9GqTsyVwQJflI9tNu47oVp8IaTiDvIElRSo3
	bkRVtqCTkumRjsohy9W6+AaCSvJDB6hQTLp8cwEuoXvfXZam3jYdnRrXqMN0qSKZkk4=
X-Received: by 2002:a05:6000:268a:b0:486:f9d9:fe0d with SMTP id
 ffacd0b85a97d-48872abc48emr28274596f8f.29.1790648487350; Mon, 28 Sep 2026
 19:21:27 -0700 (PDT)
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
References: <20260923062832.479455-1-jiangwen6@xiaomi.com> <20260923062832.479455-4-jiangwen6@xiaomi.com>
 <CAGsJ_4z-oqoxKynRr6mz0-5zZU_2NBnPkwz05CEEHHnwTyqa-Q@mail.gmail.com>
In-Reply-To: <CAGsJ_4z-oqoxKynRr6mz0-5zZU_2NBnPkwz05CEEHHnwTyqa-Q@mail.gmail.com>
From: Wen Jiang <jiangwenxiaomi@gmail.com>
Date: Tue, 29 Sep 2026 10:21:16 +0800
X-Gm-Features: AclHuK8No2tft3nV17h4GBsP_bu8Pg3JxoSCR-9ncascs6inJDmmsjStzCiYUMU
Message-ID: <CAHKocdGWbEukM6y5iYDR3u-9jJrqr=zDxqAkR1smR+o+TFKGug@mail.gmail.com>
Subject: Re: [PATCH v9 03/10] mm/vmalloc: use pte_set_huge()/pte_clear_huge()
 for PTE-level block mappings
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org, 
	urezki@gmail.com, will@kernel.org, Xueyuan.chen21@gmail.com, 
	ajd@linux.ibm.com, anshuman.khandual@arm.com, chleroy@kernel.org, 
	david@kernel.org, dev.jain@arm.com, jiangwen6@xiaomi.com, leo.yan@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, rppt@kernel.org, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Sept 2026 at 05:38, Barry Song <baohua@kernel.org> wrote:
>
> On Wed, Sep 23, 2026 at 2:28=E2=80=AFPM Wen Jiang <jiangwenxiaomi@gmail.c=
om> wrote:
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
>
> Since this is a `BUILD_BUG`, can the compiler simply eliminate the call?
> I guess the build would still pass even without the fallbacks, so this is
> more of a build-time check than something needed to keep the build passin=
g?
>
> Am I missing something?
>

Hi Barry,

The generic fallbacks are actually needed to keep the build passing.
Without them, x86 defconfig fails with "implicit declaration of
function 'pte_set_huge'" =E2=80=94 the compiler requires a declaration at t=
he
call site before dead code elimination can kick in. So "keep the build
working" in the changelog is accurate.

Thanks,
Wen

> > the callers only run when arch_vmap_pte_range_map_size() or
> > arch_vmap_pte_range_unmap_size() return a size other than PAGE_SIZE,
> > which requires an arch implementation. BUILD_BUG() makes that
> > explicit rather than silently doing nothing.
> >
> > Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
>
> Nice to see that `#ifdef CONFIG_HUGETLB_PAGE` and
> `#include <linux/hugetlb.h>` are no longer needed in `vmalloc`.
>
> Nothing concerns me except for the changelog issue mentioned above.
> Please double-check whether the changelog needs to be corrected.
>
> Reviewed-by: Barry Song <baohua@kernel.org>

