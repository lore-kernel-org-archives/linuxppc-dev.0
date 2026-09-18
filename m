Return-Path: <linuxppc-dev+bounces-27681-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08132C88E75
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 07:48:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmPrJ2R5cz2y7r;
	Fri, 18 Sep 2026 17:48:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:30::10" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789717712;
	cv=pass; b=QPrURkNp1plRTauAsZcKS5W8yO9GWfPVEgljx4aqugdDPkrNdmg+CGmwxWAE/zxmxII1QbL+rkSJgtPXoQ0ETO9ZGUEScjWH8vSle6WAG7SpE6x/cd9F52RbpMYWCXSQEII+Wl9VVuv9MaT3G5gjFEHH5nL3+TNDYGbyewjoKwFvsknunuyEW44NgeLaqZxmeQ7u1C2xUFLGB1x9QCt0PMB0J3jTRtU2q/MGO29VBVMsXr5gEOAVs9ho4K02xdVrDffHub2Dauhekekjk3AhbQGAl7tzSjqZeREovzt5Cg65a+5N/7kgcrhjyp1jwEdRIL1G2ux0PysMrZDYetQtlg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789717712; c=relaxed/relaxed;
	bh=MXqdDZMk2n2ZA2FZuhNJE90D+Z4Rs/KppQMaR2DzMcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYTACA0Sh9p5oPbTbJC3qCs8ATf7Ux290O1CBFoqq9HI8s9OC4sQfYWslnP53GxEz0y/KkReQVUgmb03sOYkkgatcbqhAjWD2lD9895LLfgTt9lsBrUNh4Ka9ETSvAIZxLSbKgEosDKcDrZFzAM0LhSNP6XCFk8/qlW6WpP144l3X7GyOJqMGB5l+xqmfqs/omoV3uGxwJSzD17f4owX7RDKVgvjD8tRDr3F+syrcNDKpoT2ls4Df3btJVadSdj9uqX5dD8vUWkDmXiBP3ZoRCjUkBFZgdih4HUYjfV8kpeiOFDqUav8jZDLKzNmHX6AKtfb8Wn6OIoc7s3g6oWF3A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EzRDHjD2; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EzRDHjD2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com [IPv6:2a00:1450:4864:30::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmPrG3mGxz2y2W
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 17:48:29 +1000 (AEST)
Received: by mail-wr2-x10.google.com with SMTP id ffacd0b85a97d-482f63546c3so291415f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 00:48:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789717705; cv=none;
        d=google.com; s=arc-20260327;
        b=C/uFLzAEWBkWh4XfhDdeWryiy0yJj9LutdkzfMUFShW9+jdsG58VwJ4u55MXqn2iKs
         7j/bHRTFdfiPm/w7c6vX6psTPJc9FivSXym+NMCPfa+/hG35xi80DQr+jEisaTfGwaS6
         /T51Y2zh20bgQV2TT//+xQkxsqM3WBNSMV4MsMl0s/I8LcgnhlvPelEG97kkzMuIXLks
         8p1RO5ytj/gXzofYpxUF3XVjNeTBcKiazMZXNIDHBNkRaHJwPP8wxGyDHhrQHg/GZsdr
         vkiil61FgjcAJR6AzwEu7P7zfnrpSjaj3jVkyz47f7iPoY/kwbJY3KelhxpQaVYUjtQy
         GUdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MXqdDZMk2n2ZA2FZuhNJE90D+Z4Rs/KppQMaR2DzMcs=;
        fh=1Xd7r5g86O0YfHcTKrSsiF2Sy6hPpxhte1A0vTi+lrg=;
        b=aoxVoUeq5U0mtRX00cVWI2Cr3ZEwDuCr4RKrbB8Q9Xh5WETPX5MYwoaSlIxh6ufbHE
         qzkv1GrUGHxPWcAB2R2QBDnZ7U1bc6/aAtQge5R5Nn3p0H2KCqJvtZNq7v3VyVdRRLw0
         n7dfvvdwkWjmGHDCDkCcLS7TpwSe0HSvAzX2IRnnENeK4haV2fO7mdDTEtmS0cVUuUvX
         zWTrpGut6PlZQfoHHpwCX79HM2im5h3qUm8AW7oop9IfxOf33w5ZiTHgLtbvUsmI7ul7
         /zIY3ne9Os5kQqKDsJJf2AplqdCjH3D7GxsnHkUZF6GHQtIO70Z3C37Nw0UzmRzFKuKM
         t3lQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789717705; x=1790322505; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MXqdDZMk2n2ZA2FZuhNJE90D+Z4Rs/KppQMaR2DzMcs=;
        b=EzRDHjD2gwjrKkjlwjrfwZpIvlg+lj7NEdqU1hjXFTLS656YZMPHHEEKamWLerAfgu
         l1KyvlVQ6RwDs941gWqHXAne7x7qQlTCmDgeaO4kpLx2ar2oYVwJZY9sEOMIHfQLDPm1
         wqOZBbJ22PYY83cN+JBmGm3oMXBgQPjKNeZCIFkWC9qoqGOkbJ9bMpKP5pMKGJQmQknN
         8oa5zqvKogD6iAWw+grSN/GS3p8NCfZqhY8bXOWh4ktgqi9Hjx8By9F5FGLyRs6io2Rm
         R/K+UWAxgqrmhIhUChWlNjGuKnnqi/7ePe/8DTOW6ui6j4FMlBXYIlsfShJ2lOqtR828
         vD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789717705; x=1790322505;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MXqdDZMk2n2ZA2FZuhNJE90D+Z4Rs/KppQMaR2DzMcs=;
        b=P/DzEu1cqwJF19hcp7pnw8AffCR9YPe53t+jnxFPJM5pi9nJ+zuAvmJx7XrrnIhVUA
         bVrGMnD9RCRc/lq4yJO3KZ9B1CWt4OLoaHyk60o1/0t5tCKEPPPEX1GMcFNOCOsy2CtZ
         rDK8fHip4L5Ztk8eKxwpEWisZU4iiZfv3eYn1mIZrjAjfuxxOzl4NX2L6AYCSRbtVbgU
         EfdDxCJyQ6WTn+fd4KVVleM14uxa4+R3jr4UCWwMGKrK/xGcFh84SUfaDz00MNmuwhMF
         ohDYZbHQG6/OESNq53r1bwjJgsWZMAJyfzbZ8/MloccvpWjArMTwYEJrBs10T8wDlzGm
         IHSg==
X-Forwarded-Encrypted: i=1; AKwUvBzCZ97G+2ZoMfKEcnAFp5l4bqzOgKVC88sNuDyh0DjQZ13IxXUIM88pPN6Uuai7J7o90Gz+6y8Njuy+SC4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nmcNn+DqNAgshDAqVgulgfBhL0O54Ti30J/Ym+BBDBAmhDXvlP
	Ssz37Iov0JefSNSOmy/NICGv7VT2VAZpuqOR/FgdyNgFWA9Tf23+TLIWqvFfqJzTDEN5KIwTWB0
	8PRrKBvjU02xoezVxnR/TvtYsZ6rzsEM=
X-Gm-Gg: AYBFou1Ta3OSHMacTHIN4VUtFxxVMhkdA0jEBOjIudrJ5/lhQ/I3bNUvXx0ksdXgS4F
	8FUv/bESFZFqhRYrnE4BWFO8GSPFCVX6F5WoWkHteGK2xnKEl39+nprDmPmYksshdJK58XNbg70
	pwvRaE9QJyWG8ns3BZZ0jrmZEOs0Q8MahsdNgq2I2/6OM5naGv7IhjBaZTHddU+Bo3xwWgIF/nA
	5t76cRFg6MEFcV5MyuElyU3BXS6o0LmEzQIBBo0GMROBqxGs/3nKOhyAylrOPsqfNONReY6EyNz
	+24VUDWC79MMkWJgPLSsUHjEoS9/QW9LmtCxvQl8hqgvot3sR36uViVW7e1zE+EidL4=
X-Received: by 2002:a05:6000:4b13:b0:487:1687:197d with SMTP id
 ffacd0b85a97d-4871e212458mr1713724f8f.6.1789717705281; Fri, 18 Sep 2026
 00:48:25 -0700 (PDT)
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
 <20260917052933.188679-2-jiangwenxiaomi@gmail.com> <CAGsJ_4xujxpH6OuuUao2=TAjTMKhr77ufW6OoZuk-VB=YPd6fw@mail.gmail.com>
In-Reply-To: <CAGsJ_4xujxpH6OuuUao2=TAjTMKhr77ufW6OoZuk-VB=YPd6fw@mail.gmail.com>
From: Wen Jiang <jiangwenxiaomi@gmail.com>
Date: Fri, 18 Sep 2026 15:48:13 +0800
X-Gm-Features: AcwNN1U7w_zpIxImLoNROHRiindh6mTvUu1jbd9liF3b4JQySYxKRKgU7ZyE2AY
Message-ID: <CAHKocdHS-D7Gg_n3razCrp-QT5seT4KWz9r1TSWVVwLFsZmU7Q@mail.gmail.com>
Subject: Re: [PATCH v8 01/10] arm64/mm: add pte_set_huge() and pte_clear_huge()
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

On Fri, 18 Sept 2026 at 07:22, Barry Song <baohua@kernel.org> wrote:
>
> On Thu, Sep 17, 2026 at 1:29=E2=80=AFPM Wen Jiang <jiangwenxiaomi@gmail.c=
om> wrote:
> >
> > From: Wen Jiang <jiangwen6@xiaomi.com>
> >
> > vmap installs PTE-level block mappings (PTE_CONT on arm64) by reusing
> > set_huge_pte_at() and huge_ptep_get_and_clear(), which are HugeTLB
> > helpers gated by CONFIG_HUGETLB_PAGE. This makes the feature silently
> > unavailable on CONFIG_HUGETLB_PAGE=3Dn kernels and couples mm/vmalloc.c=
 to
> > HugeTLB internals it does not otherwise need.
> >
> > Add pte_set_huge()/pte_clear_huge() to arm64, joining the existing
> > pmd_set_huge()/pud_set_huge() family in mm/mmu.c. They build on
> > __set_ptes() and __get_and_clear_full_ptes() directly, so they do not
> > depend on CONFIG_HUGETLB_PAGE.
> >
> > There is no caller yet: mm/vmalloc.c is converted later in this series,
> > once the generic fallbacks are in place.
> >
> > Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
>
> I tried to apply the patch to mm-new, but it doesn't apply.
>
> % git am raw
> Applying: arm64/mm: add pte_set_huge() and pte_clear_huge()
> error: patch failed: arch/arm64/mm/mmu.c:1872
> error: arch/arm64/mm/mmu.c: patch does not apply
> Patch failed at 0001 arm64/mm: add pte_set_huge() and pte_clear_huge()
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> % patch -p1 < raw
> patching file 'arch/arm64/include/asm/pgtable.h'
> patching file 'arch/arm64/mm/mmu.c'
> 1 out of 1 hunks failed--saving rejects to 'arch/arm64/mm/mmu.c.rej'
>
>
> [...]
>
> > +void pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
> > +                 pgprot_t prot, unsigned long size)
> > +{
> > +       unsigned long pfn =3D __phys_to_pfn(phys);
> > +       pte_t new_pte =3D pte_mkcont(pfn_pte(pfn, prot));
>
> Maybe we can drop the `new_` prefix.
>

Will do.

> > +       unsigned int nr =3D size >> PAGE_SHIFT;
> > +
> > +       VM_WARN_ON(!IS_ALIGNED(pfn, CONT_PTES));
> > +       VM_WARN_ON(!IS_ALIGNED(size, CONT_PTE_SIZE));
>
> Do we also need to check that `addr` is aligned?
>

Yes. arch_vmap_pte_range_map_size() already guarantees all three,
since we are already checking two of them here, we should complete the
set. I'll add it in v9.

Thanks,
Wen

