Return-Path: <linuxppc-dev+bounces-28069-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6DEC9830B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 21:30:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqqr96Sltz2yqw;
	Thu, 24 Sep 2026 07:30:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790199017;
	cv=none; b=aSrb19AottoagsYt49bORRbPWYHlxWah/JSApPnYVJWGFpJ/GDEscL0SEYz5XJaasO4N1tBT1ZXft8EMrfJV9HhixcX5tF2v44h0TZ/hIxjakxnq3nn6gwQFkgpeFn/XzYf5WjwlkYtMCUDNyrDZfc8Szms3u+cXb9px66OJcCro/9NP+Odx/qZpC3Q3cAQvHpKKcvMmeOX3Y6qmJj/FlIbxQJfuCQdww/jY3HwcdSrP4wzZrW1PcyDHIsYcrdZhEuotK6Po9hryYWYlm9w4VTEAhMSOqElQcy6DDk141ln0yq7HB/vTiAVq6kC3B0h0EemtcWI7MFl0D94wEW5Dew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790199017; c=relaxed/relaxed;
	bh=d3tq9N0LJ4r7VJ+9wdwqQQlbn4k6qzBMuLB5kE1baa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bv9dIBYTBZkbPhkcZ4AtMwRM4hMHf90dbZtu2Prn5RdsRJ8bQIIH1HHCv7tNYs7cky8qtbM8RNGFYWN6wpIKvrIFUCNLNqe1fI18wWZ2cIiB+DGST9gEB9PWjPf0+unmm3bI2O+6IsxkkOKfj7LgKlMYviyN0x5CksT/xJ5RSOhfEZIUsX8aU2bO4npGLD2nFv3JhK32M0z2SPJdjND4SYKxn9r3yz+mpEE5j82+9whUQqEmTjIjfh7uqi1YaHMCykuFyil3JQnuTIPeMysuBYP2osdsykMTWa/gxweXmEK9rIr98In0xYpUF9Lh9s5QrySUXtAPL6Y0SQ19oPzUMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKAxKVtM; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKAxKVtM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqqr85XlZz2yHT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 07:30:16 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8F88A601FD
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 21:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D501F0089B
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 21:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790199013;
	bh=d3tq9N0LJ4r7VJ+9wdwqQQlbn4k6qzBMuLB5kE1baa4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JKAxKVtMZbF3TD2Yn2zgDD4fLtybBqJ/igLQzq3NUT4r9bDACuqKvXjvgz60TR+JA
	 BIFmfFeaS555lQfbIUJsxtX1zQkAUve6IUQqNm7nLfx6uf7seZiMIvm9RK03R3nD3X
	 yIqwdSH/bmBuXrza+VBpZYbApAWVCksy8bFBjD49DyaS1W6AQq+JhF2QihqME55VXB
	 IJ8+SeI/dKeiSzaW7jniNvqm6j5i8qbdAiZMMHyUhEOvu3CyESGyLW7HUG4hOhAWJf
	 +n7NPspRkMseNo+3GfhH9oIjsO6FjECoNDaxM6ZpMUq4024vg6/mylbECDTlTHtIO7
	 kd3RiEuWZgBSg==
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910ad2273so151266085a.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 14:30:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxeS+UqNk2RrrgGgAjR2kuuPxFCFnzxBum2s/VYwpVTD525UM6fTZelGatqCh1h3Z+gwVV5Bz/xLLjI1XA=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mq0chL2anZjzuP4bNRA1oxE1JoDgzLhqyxj7lfoa0apaOerL2b
	5K/xjKz+FWTiV+CdptnFKWGvVLaiQC/O02cOnqAW+aOffOYn+MhgNegoh4yvCYW585HM/cDbkU/
	zqHrsqUI06tXPTXpjoHp98MgctPutJnQ=
X-Received: by 2002:a05:620a:4707:b0:937:50b6:4a5b with SMTP id
 af79cd13be357-93c345836d2mr78355685a.23.1790199012523; Wed, 23 Sep 2026
 14:30:12 -0700 (PDT)
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
References: <20260923062832.479455-1-jiangwen6@xiaomi.com> <20260923062832.479455-2-jiangwen6@xiaomi.com>
In-Reply-To: <20260923062832.479455-2-jiangwen6@xiaomi.com>
From: Barry Song <baohua@kernel.org>
Date: Thu, 24 Sep 2026 05:30:00 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xQhmRigaV_2G3pdOgk5mvC6HNzqCyUdRY3RSG8-QNC-Q@mail.gmail.com>
X-Gm-Features: AcwNN1UaTtV0wPc3IJY9Sx6rnYvw9-CPwWOiah8w0K1fH7hCcF4lT-foCe1dQ8M
Message-ID: <CAGsJ_4xQhmRigaV_2G3pdOgk5mvC6HNzqCyUdRY3RSG8-QNC-Q@mail.gmail.com>
Subject: Re: [PATCH v9 01/10] arm64/mm: add pte_set_huge() and pte_clear_huge()
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

On Wed, Sep 23, 2026 at 2:28=E2=80=AFPM Wen Jiang <jiangwenxiaomi@gmail.com=
> wrote:
>
> vmap installs PTE-level block mappings (PTE_CONT on arm64) by reusing
> set_huge_pte_at() and huge_ptep_get_and_clear(), which are HugeTLB
> helpers gated by CONFIG_HUGETLB_PAGE. This makes the feature silently
> unavailable on CONFIG_HUGETLB_PAGE=3Dn kernels and couples mm/vmalloc.c t=
o
> HugeTLB internals it does not otherwise need.
>
> Add pte_set_huge()/pte_clear_huge() to arm64, joining the existing
> pmd_set_huge()/pud_set_huge() family in mm/mmu.c. They build on
> __set_ptes() and __get_and_clear_full_ptes() directly, so they do not
> depend on CONFIG_HUGETLB_PAGE.
>
> There is no caller yet: mm/vmalloc.c is converted later in this series,
> once the generic fallbacks are in place.
>
> Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>

LGTM. Please see the comment below.

Reviewed-by: Barry Song <baohua@kernel.org>

[...]

> +void pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
> +                 pgprot_t prot, unsigned long size)
> +{
> +       unsigned long pfn =3D __phys_to_pfn(phys);
> +       pte_t pte =3D pte_mkcont(pfn_pte(pfn, prot));
> +       unsigned int nr =3D size >> PAGE_SHIFT;
> +
> +       VM_WARN_ON(!IS_ALIGNED(size, CONT_PTE_SIZE));
> +       VM_WARN_ON(!IS_ALIGNED(addr, CONT_PTE_SIZE));
> +       VM_WARN_ON(!IS_ALIGNED(pfn, CONT_PTES));
> +
> +       __set_ptes(&init_mm, addr, ptep, pte, nr);

You have patch 4 to revert the `clear_flush()` modification from
06fc959fcff ("arm64/mm: Support huge pte-mapped pages in vmap").

I guess you may still need to guard against the case I mentioned in my
reply to patch 4:
https://lore.kernel.org/linux-mm/CAGsJ_4xiLScr2PrPu7Eem73GvPCtsuYd3J05kW3SC=
4QSs5Q4aQ@mail.gmail.com/

Something like this:
VM_WARN_ON (pte_valid(__ptep_get(ptep)));

Best Regards
Barry

