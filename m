Return-Path: <linuxppc-dev+bounces-28357-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA98C9830E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 02:42:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htQZt3MZbz2yQH;
	Mon, 28 Sep 2026 12:42:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:30::17" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790563366;
	cv=pass; b=dHYNRGUPeJM8wYpDSU2G/bBdj8yQrbVZTxKUoAOQ5G2hBpDrl/qQ38BL56mNAqUIBxwyN8am2S2eKzauL/T2dzv9vZmhcqFEDrW4cXaxcrnzcTsKdxAUmxLgvsOz9kVjt0dz7Lukt7t6+0pXUV+ECfz4yOM9D+1P5vnAphhV9NvNG4NG8Z3e+m5C6Rk3MZ/pvf/NLppCuVrotgPsZ7wKd3eehpjJybZGMHjIPWjmfbXwQBw9tVePjYt0kOESzOQkJKok+oxL9bJLWu6O0ps17c7IxZd8X9PKn6ERSYwGu53guDhwzokMD5TCkbuommUbUcSrp6CqKnxswRDXZIhKgQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790563366; c=relaxed/relaxed;
	bh=YZjJVun8xN7GDkHYEL3bXr/VlWpA2YfoNARMcoM9xVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUDSsifBCKXl1WZjp5Ej8chgL7LAN/lqK+qjyvWrQeaR/VTEGuUf8fgWm0ayehW4NCEeL6eX+vyMN13Z+741YSPPjbeFE4JUsmr/B8ZmYwF0l1dEw1uZiEHh3x+AC7WhOUr8zX7F06pRrqoKFo4wreqLqLxTG7zWrVWCBqICKoBojUwA+VRPDGAch+a87Q15/XWw+ZZcJcXwTZn/fxk7Zl8tRVt5rJoDAyi4aG/wG5/sjgld5LD0gSlY8Zw3PVX93wnmqkYJsJxvSWA21gKftOwyeJU7sDw2EXrQzEK/U9o9bLGvGJazCndzg0qNS3nWR28gKm+dS/bgaAcKnFZ0hQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dueWzq9L; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:30::17; helo=mail-wr2-x17.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dueWzq9L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:30::17; helo=mail-wr2-x17.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr2-x17.google.com (mail-wr2-x17.google.com [IPv6:2a00:1450:4864:30::17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htQZr2dBKz2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 12:42:43 +1000 (AEST)
Received: by mail-wr2-x17.google.com with SMTP id ffacd0b85a97d-4888598e4f9so1345591f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 19:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790563358; cv=none;
        d=google.com; s=arc-20260327;
        b=OmmF7q3RvpXzOIB3zeWUNd9uNPGbUMjS5tTqyg6wSW8JRVVx/n/BWl3nTSFxbjpLTp
         EDlUUC7qbWFFP++hric11rusi2RB0TbzfzJf0+Zj2aMYRD8hmCqZV5SzMMW+0riYo5rT
         OWLJJp9tkp8oCPPw0TL2+e2rg3va1LGtvq3e0tNIzHftibV/TpjhkBNx9+Q+0rJCHkwV
         swAmY55DUQsxn0MTQj4gDqO8OaSqN822coqhqc6i74Av8cEUuwFIzEeqkftwBXt9bcJq
         gmZ67+MML8QOWm7SkYDvKttIzVqjJwC0/4jAe8BpVu/1NelZmTniCgHeBPzzrKeGZu1a
         nd0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YZjJVun8xN7GDkHYEL3bXr/VlWpA2YfoNARMcoM9xVw=;
        fh=2QLzzYAKK/C13nLGmPYsDS96giNGDtTcrx/7xzucGcE=;
        b=r5oIjsPJtMcQbMvo60tsUHvnaGeKy/D/A8TPDigTSsbRZduorvwAd4pOd997TExFIN
         /soNqZ+O1WA3kmbimwoY30DHXRwb2Y9z1u8NRLn7XBBPsKRmST6kW9Et4LOYlPcUCdjw
         i89f/E0H5w6M5Qg43HXyCTHn5BN+5L7LAkA4vzEtlmt63c+hdU9n+Z7ZLrfaCU13ZgRs
         Q0PJBbYbQy4SD89bscXzlGeor3UblQ0ngYYM6fFGxGFfRsWeIGjqBFQkp4lFgxoJJTGA
         7ZyrpuqZeCrdySodjQFKYwmx3g7hHGyXlAxt1SWhqRWBsveoNyYmXz8xc7NMs/BtwRQH
         GWfw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790563358; x=1791168158; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YZjJVun8xN7GDkHYEL3bXr/VlWpA2YfoNARMcoM9xVw=;
        b=dueWzq9LxDB1a07zFDuQi02XfbVWr3YlnfHSZ5eMBwknEqb3r7uMrBpdnXkVDg20Pb
         x5Hw1h/WoNXPL8OCLJ3ENMysmnXFlv0/UREEjtxM34lcnUqB/CmHZk4YgPzoyLpuF6Sb
         krFXZrYzriQVcP5MVOc9cMtQJjoo59Xco0vvEK8tsuOSRfkMunoNHqeTQDVjKabLrwFz
         kyNpbTxLRDt5elFnPgNqxRdNetnMSejn00HB705WwqmYBX3x9BNLjrGDXzw//d9f/aqb
         hWhFWgZMEjheOaajEcih7tDK00CMniiOgZde1EpivIbS6d5TDfQmC0NYlk5s1hDVvPry
         ubmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790563358; x=1791168158;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YZjJVun8xN7GDkHYEL3bXr/VlWpA2YfoNARMcoM9xVw=;
        b=k0E9q5s7fFO5pX6n9ECkxF9Kor5UQkvmx6eBq5druIHldswKc9s38EhKKqbLklWCHC
         OMoa/Bj626nBt+GY3c2fPRLIaLGhQAU6R5bC/xbE0CnanDSIGy3aid+myz1tDu78ukIm
         2squzM2k2Q8CwCgSrvil1ELZNgVMkQJw2Ky7P6SqCOygxpzT2RTYPb0XTf6TQHfGidH7
         2LpVuhNf6OpG6lUMoLSdwRHBIyEg6/2084BhjFayp2yr6AZlSVdLTZ1P9LnNF50JAoMK
         56Q9D9PZMU1rK8yh/xIznhWZKl3YDhIPS3fKqwoHGTe9YFKnpNJAKksh+ltKAHvQpOot
         NDtg==
X-Forwarded-Encrypted: i=1; AKwUvByGMudoaCBpKiqZJixUNRrbP9hmNMstMZ7kWoQir4zWSesd/T6KU3THROBFlW2D/mL+c5nrrFjgkGcf6eE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLnS9KaVmB7IhkqzywBVH7OWcZfJjpcpjfySFfX7Mw5WwApl9vv
	XeiHQtbKSnS0+T4wga0/3j09g8T7AXcxQHSX3hBdCf50LBQ0QBYD9ub6b82JawzzRFn+Ztz9lJR
	pnPOFG8KBI36IQ7j/YzNtXyr4acvKp7Q=
X-Gm-Gg: AYBFou3C06wBOsoif+rPbO7tpEvG1vp+rEgow7zubGzE5uJhIH28G6m9L9l9YEWnHon
	nPLmk4wAmBJdvhdoKFzGoHu4C4omY8lbepozOq2LFjg69FYPGZk+hyXvRuMsYjBSn/qTq8mfQ1M
	C2TbjHHSMIEM+dQ8qMJZysCMpR7RlXwL33o0ysatVp5KrRs811HEaFBQ7E1WFkSCyUZuuKn4ZAT
	mY1ye8qXx2A7g+a38TxIRUwYALnsXY7c79GPPE5JoUSclGVMyRi9WTt314/Nvt2DJmCSsHpTz0O
	Tcz8EYTKfyzhlXonJnDomGSBLiQs9NtaABrmtF0eFzvtLmSNm7ehrsSW
X-Received: by 2002:a05:6000:385:b0:488:8cde:aaf5 with SMTP id
 ffacd0b85a97d-4888cdead77mr6051154f8f.2.1790563357707; Sun, 27 Sep 2026
 19:42:37 -0700 (PDT)
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
 <CAGsJ_4xQhmRigaV_2G3pdOgk5mvC6HNzqCyUdRY3RSG8-QNC-Q@mail.gmail.com>
In-Reply-To: <CAGsJ_4xQhmRigaV_2G3pdOgk5mvC6HNzqCyUdRY3RSG8-QNC-Q@mail.gmail.com>
From: Wen Jiang <jiangwenxiaomi@gmail.com>
Date: Mon, 28 Sep 2026 10:42:26 +0800
X-Gm-Features: AclHuK-tj6RxDkR8fHhPZoG4i4S4CyEDCcJlFwKY4ZUdtlHJk_F2XqaylhywMI4
Message-ID: <CAHKocdFUw3BDjKwGhE+gMxyVXmMWtX4pP8brY3dBOhYhYoCgdg@mail.gmail.com>
Subject: Re: [PATCH v9 01/10] arm64/mm: add pte_set_huge() and pte_clear_huge()
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

On Thu, 24 Sept 2026 at 05:30, Barry Song <baohua@kernel.org> wrote:
>
> On Wed, Sep 23, 2026 at 2:28=E2=80=AFPM Wen Jiang <jiangwenxiaomi@gmail.c=
om> wrote:
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
> LGTM. Please see the comment below.
>
> Reviewed-by: Barry Song <baohua@kernel.org>
>
> [...]
>
> > +void pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
> > +                 pgprot_t prot, unsigned long size)
> > +{
> > +       unsigned long pfn =3D __phys_to_pfn(phys);
> > +       pte_t pte =3D pte_mkcont(pfn_pte(pfn, prot));
> > +       unsigned int nr =3D size >> PAGE_SHIFT;
> > +
> > +       VM_WARN_ON(!IS_ALIGNED(size, CONT_PTE_SIZE));
> > +       VM_WARN_ON(!IS_ALIGNED(addr, CONT_PTE_SIZE));
> > +       VM_WARN_ON(!IS_ALIGNED(pfn, CONT_PTES));
> > +
> > +       __set_ptes(&init_mm, addr, ptep, pte, nr);
>
> You have patch 4 to revert the `clear_flush()` modification from
> 06fc959fcff ("arm64/mm: Support huge pte-mapped pages in vmap").
>
> I guess you may still need to guard against the case I mentioned in my
> reply to patch 4:
> https://lore.kernel.org/linux-mm/CAGsJ_4xiLScr2PrPu7Eem73GvPCtsuYd3J05kW3=
SC4QSs5Q4aQ@mail.gmail.com/
>
> Something like this:
> VM_WARN_ON (pte_valid(__ptep_get(ptep)));
>

Hi Barry,

Agreed. I'll add this. The vmap path should never see a valid=E2=86=92valid=
 transition,
but an explicit assert makes that contract visible.

Thanks,
Wen.

