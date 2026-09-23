Return-Path: <linuxppc-dev+bounces-28068-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B117EC98304
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 21:23:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqqhS6mvHz2yqw;
	Thu, 24 Sep 2026 07:23:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790198616;
	cv=none; b=dxYeSLbXe2PzD1/Qi1nzX0NUegdX7jBwu2tzYvesG4UcRhBOaHzxLJwFbqpC6G/B1SEF+i1FcjEfVk+EyqR882a/AzpVLIe669pQGuGamDxxFV9djFOeCpgsGMpRmoFQyKVMFXGO2d90BJ/XjjX1Yn9Z4RpNxw7QRx3Q7m5WiAYuroje0DqjngwOgaCKxz/QfZ5jc5ifTntQOdsn5oTmatEDY031InEatjZqFy9IAcdbKday7m6ONVcPppm4XpBpMvlxsirz5gIj+Eb0qo9rcQjgrArhiolZJAfRdaX7/1hxxHKBSPOu66TQvxoW91okhdl/k/0Op2Sx9Axs9ubwdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790198616; c=relaxed/relaxed;
	bh=pFOUdSvHwil/K0FhFzOket4pw49ZzFhiG+QLBkwjfts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfA38w6m1H7/J+YEyZxINZOyiSeKEApyucMMV5K23uQN1eVSzZrRY1GmFQqBdDZQJRkXBuji4xm0GPLXLmRj8WFb0/hrbniRBk6jyFmXq1R/8nqeMqiVsbmQSoWKadZto9t31FJ3bTKr222JZzw0uGW7lJFG4jNa3mD3WYv1WGngHVVLoczhGTZZpAwtmVi8o8+l32FS5pF1LOu5n66aP7EHIaFEd2R5QCUlwJ+35klqeFrMDH34i8mskpZBMxAt1ivGCSo4mGyy6lMqABhpuef8oyqZkZV0Bf91vYOvGe+7+hNZGWgZxyABbUTjGZXidTPCouq2KhZnSZ4ELv9hDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2NXnhWk; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2NXnhWk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqqhR5pPPz2yHT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 07:23:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 309C4438B1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 21:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156071F0089A
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 21:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790198613;
	bh=pFOUdSvHwil/K0FhFzOket4pw49ZzFhiG+QLBkwjfts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=l2NXnhWk5v24WehMq4tSpmYi+d5xm5L5yI8aFPMPz4HayjF3RJ4ct2hxFlSr6eGvJ
	 0Dtw3flW+pOGjBESMhPfV/DI6fLstSCno88OFAUOcih9X39nhGNIm+VpXZpUCynB5X
	 +D7okYDBr1ytqcLJCoruXi0yL6W3PylDaJ4luGmUZJF5UlIpJep2khrcvpacTDYim7
	 IT05Utcze2c06jhGz6rpyFOWDLNJd1LCpKETbFh+ZE4BggMJqtOZYAweaXhTF8C/pj
	 MBU8+1dE75n0Jan3UlAQY4zyyjUWmsOME/jxXvmE57pTuE7aDqGqKM9u4ELTtwB8wP
	 qgVVtkJxP0phQ==
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93910ad2273so150804485a.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 14:23:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzrHMeklLyQ7fNfyj5dkPIxQZXZOm9INohb06Scbgkc+CzFaJqRSQbTZsy9mcsTRUSDV3T3fesYtBRgFNM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m+Lp0rJwcTR3n1qQLzxHEw8e+ZvqiS9xw5eNzRdABYnnFDZqcO
	kpS5Xfx5TliV4sc6e2Ir2MRrcPq4aJDo/pHyEr3xTRPnBfDJ/Ci7rt2KMzlEwuAsXe++RxWVpqy
	qoukD9sKm73edRnHf/VEe4li8k4ORIDE=
X-Received: by 2002:a05:620a:2a04:b0:93b:d7a1:ba0d with SMTP id
 af79cd13be357-93c346ca45amr66989285a.56.1790198612443; Wed, 23 Sep 2026
 14:23:32 -0700 (PDT)
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
References: <20260923062832.479455-1-jiangwen6@xiaomi.com> <20260923062832.479455-5-jiangwen6@xiaomi.com>
In-Reply-To: <20260923062832.479455-5-jiangwen6@xiaomi.com>
From: Barry Song <baohua@kernel.org>
Date: Thu, 24 Sep 2026 05:23:20 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xiLScr2PrPu7Eem73GvPCtsuYd3J05kW3SC4QSs5Q4aQ@mail.gmail.com>
X-Gm-Features: AcwNN1U6u4upYBVse70ygcbBam77nB0znlsjMQqKiWEExUFJn-qljmWnP0sSc0Y
Message-ID: <CAGsJ_4xiLScr2PrPu7Eem73GvPCtsuYd3J05kW3SC4QSs5Q4aQ@mail.gmail.com>
Subject: Re: [PATCH v9 04/10] arm64/hugetlb: drop the init_mm special case in clear_flush()
To: Wen Jiang <jiangwenxiaomi@gmail.com>
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org, 
	urezki@gmail.com, will@kernel.org, Xueyuan.chen21@gmail.com, 
	ajd@linux.ibm.com, anshuman.khandual@arm.com, chleroy@kernel.org, 
	david@kernel.org, dev.jain@arm.com, jiangwen6@xiaomi.com, leo.yan@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, rppt@kernel.org, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 2:29=E2=80=AFPM Wen Jiang <jiangwenxiaomi@gmail.com=
> wrote:
>
> clear_flush() calls flush_tlb_kernel_range() when mm is &init_mm. This
> was added by commit 06fc959fcff7 ("arm64/mm: Support huge pte-mapped
> pages in vmap") because vmap called set_huge_pte_at(&init_mm, ...).
>
> Now that vmap uses pte_set_huge()/pte_clear_huge(), mm/vmalloc.c is no
> longer a caller of set_huge_pte_at() on arm64. The only remaining
> callers passing &init_mm are in arch/powerpc, which uses its own
> implementation. Remove the dead branch.
>
> No functional change.
>
> Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>

LGTM. Please see the comments below.

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  arch/arm64/mm/hugetlbpage.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 8e799c1fe0aa6..ce247b06fe03d 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -206,10 +206,7 @@ static void clear_flush(struct mm_struct *mm,
>         for (i =3D 0; i < ncontig; i++, addr +=3D pgsize, ptep++)
>                 __ptep_get_and_clear_anysz(mm, addr, ptep, pgsize);
>
> -       if (mm =3D=3D &init_mm)
> -               flush_tlb_kernel_range(saddr, addr);
> -       else
> -               __flush_hugetlb_tlb_range(&vma, saddr, addr, pgsize, TLBF=
_NOWALKCACHE);
> +       __flush_hugetlb_tlb_range(&vma, saddr, addr, pgsize, TLBF_NOWALKC=
ACHE);


For the vmap case, we are not mapping over a valid mapping, so there is no
case where `pte_present()` can be true. But I guess we can strengthen the
check in patch 1 by adding a `VM_WARN_ON()` for `pte_valid()` and some
comments.

/* For vmap, there is no valid -> valid transition */
VM_WARN_ON (pte_valid(__ptep_get(ptep)));

Best Regards
Barry

