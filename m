Return-Path: <linuxppc-dev+bounces-27642-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B06C982D9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 23:22:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmBcL2nncz2y8p;
	Fri, 18 Sep 2026 09:22:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789687346;
	cv=none; b=Q4p1pzmL4OFIxvXeGle8stu3XI8aFdJLN+k4k8rakRTJlpLfwn8xaCjvWWpqk+fbXn64sLd/WLGzPMXatNS65eX11qu/sU/1a1CDDu+QNE4cnykeqKfVuBEJsLvihEdHySttfdNjlC+1x/P49vgb3LBhE2r26WAkyCIiRi5adS8quRMANJ7TsOjn+8FI0oPdtUnA6osegLiAztGN+b/Ge3Sbp6D7TWTj9IhKZeCv5WGEOiDWZzI0OA5iz+hEADKQKksrgtPr8NI7oTpfN6pKw1BH2EjE+GPxATwEXRQ+mitxfNxvFN7sfC0dLD4zC8YL+UAIkm87ngTV4HlY+ojdxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789687346; c=relaxed/relaxed;
	bh=tMZh1YMYCYrRC2uuwUki1Jazz5iXTgol+eU8SrrfkyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUKKyB8/16ZoIU8FNUlRzXwBCdb326vx6IxLLMgSJt+YBU9el/fh08T6yUOxZ12esNULmm+CLCN6LYzy5jXb7bTHRFHXa3wvIPpjJBzMTDCgkWwXp36dSsCD5OJD2LI+72iwf7KAoCDFj1A43oJAau8SsASA045cNuf3G9CRvZdrpNOUDKtdELMDrBt4RoM0Nlz3j5nxx+/D03maFwkMn0SqsVlJFidXLG1OTbxm33EhIp/HVRiL4V+TGkx4LVhDJv404JffBE6GP3zAJLjJLLlV3uzFvkt7V0GjfTfwlQPMcV+2SdJ5zg+hJb1MnWSA+GtxVUL7qhTEjkW9npkzJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UMyDXfFP; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UMyDXfFP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmBcK1gYQz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 09:22:25 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9B7A343F51
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 23:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1021F0089B
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 23:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789687341;
	bh=tMZh1YMYCYrRC2uuwUki1Jazz5iXTgol+eU8SrrfkyY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UMyDXfFPJ6TD7VAJu/Wo9nOwx21vOAIJyHqkxfySfMaGoz3L5SRzIRuYI6+hBq5Fn
	 VDxtPogqxAZqT8pWf20ID37n7+Tnf1ShUmnTeR6Ws4U8ye+c5hV8nmnvdP/9SIaRz1
	 oVrxtZYf9D25VxY16SDLIkJw+KxWNVDWByqc7Bv821rdlnEV0ad0v/0J10dcDSxlBx
	 DUjrmnzdOgwZ5WBE8l1Rg98I3/mY5h/CmE2mnXbu9SnLwfE2Q9/STmdY1xkpDSRuvq
	 QubDsA6jFihfX+X0r3Vgzg14qdy25FbeEj7HpBIQnOY9UhbIVFC0VzepoarsGjndoF
	 thgumBxMGF03g==
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91064d2d54fso2697556d6.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 16:22:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz9GFMKqgVtBmhZJvf5VatgnQHlFMDcntSJRLzM3iVz3l42iy0b04+HnSlEty1AQGi54aJgeKuAzHuoMGM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k9VZrYw0iOxVz9uDIqXYPuNUail7tjUvAFxgef0TdnMyAncuGl
	E62nXYDuPiZliEEe3FKlupi9bJ5LTgobGYsbPD2XCTFVDqQysvfWoCGR+1j7XLN2XJR9/dj1vyL
	ZAtq1YHq2IlD0dODoxIpRvkoUDS86Rmw=
X-Received: by 2002:a05:620a:294a:b0:93b:da60:a557 with SMTP id
 af79cd13be357-93bdc6d5b3amr95981185a.19.1789687340744; Thu, 17 Sep 2026
 16:22:20 -0700 (PDT)
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
References: <20260917052933.188679-1-jiangwenxiaomi@gmail.com> <20260917052933.188679-2-jiangwenxiaomi@gmail.com>
In-Reply-To: <20260917052933.188679-2-jiangwenxiaomi@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 18 Sep 2026 07:22:09 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xujxpH6OuuUao2=TAjTMKhr77ufW6OoZuk-VB=YPd6fw@mail.gmail.com>
X-Gm-Features: AcwNN1WjNP8GdpSkB1mGsUq58TKlHY6lfOfrir1kzagtl_zxNQgmPbeTkRXOdwM
Message-ID: <CAGsJ_4xujxpH6OuuUao2=TAjTMKhr77ufW6OoZuk-VB=YPd6fw@mail.gmail.com>
Subject: Re: [PATCH v8 01/10] arm64/mm: add pte_set_huge() and pte_clear_huge()
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

On Thu, Sep 17, 2026 at 1:29=E2=80=AFPM Wen Jiang <jiangwenxiaomi@gmail.com=
> wrote:
>
> From: Wen Jiang <jiangwen6@xiaomi.com>
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

I tried to apply the patch to mm-new, but it doesn't apply.

% git am raw
Applying: arm64/mm: add pte_set_huge() and pte_clear_huge()
error: patch failed: arch/arm64/mm/mmu.c:1872
error: arch/arm64/mm/mmu.c: patch does not apply
Patch failed at 0001 arm64/mm: add pte_set_huge() and pte_clear_huge()
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

% patch -p1 < raw
patching file 'arch/arm64/include/asm/pgtable.h'
patching file 'arch/arm64/mm/mmu.c'
1 out of 1 hunks failed--saving rejects to 'arch/arm64/mm/mmu.c.rej'


[...]

> +void pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
> +                 pgprot_t prot, unsigned long size)
> +{
> +       unsigned long pfn =3D __phys_to_pfn(phys);
> +       pte_t new_pte =3D pte_mkcont(pfn_pte(pfn, prot));

Maybe we can drop the `new_` prefix.

> +       unsigned int nr =3D size >> PAGE_SHIFT;
> +
> +       VM_WARN_ON(!IS_ALIGNED(pfn, CONT_PTES));
> +       VM_WARN_ON(!IS_ALIGNED(size, CONT_PTE_SIZE));

Do we also need to check that `addr` is aligned?

Best Regards
Barry

