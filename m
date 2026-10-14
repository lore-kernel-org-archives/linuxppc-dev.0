Return-Path: <linuxppc-dev+bounces-29465-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D45CC6B29
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 08:47:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4Pw25wgLz2yDm;
	Wed, 14 Oct 2026 19:47:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::32b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791967634;
	cv=pass; b=fpMlCO7C6H8FfVAFmZjQoN4Rldm40Ws27DzMQMUF07B3Yax0wW8XypSmJ0bYsr9o5clBKBlAg43Tyd76PP4oWp1qJf/MlEpK1d/hjHI9yaTPRPW0I+LceFHX5wNRfnBTnPK+WdE9OKW+CL2kuqsKmCtvN+IFyvADIXR39Lk7WS9vKrRKBcJcRvmvy9DjDnHbi5AOje0Iwq3MttYx/6P0SjfOxgVa0hu+xNk++lTggdK3OXvGPZ0+QCUM+hknlbSYrRRlhjt0CK+i2NCqmIs9M/E7WX1YK6/VJxksn2rCHDVJsGkylV90VIJ1kD/k6P1xO+NscpJVGatMT88CH8I9aQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791967634; c=relaxed/relaxed;
	bh=0cYhJsFY6GItBPWieM4stDAK2l4sudXXbycAkGrr3pY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTyFF7qQr/bYaJgT0DxiVsrLfIDH4rk70gjrZNEZKXdnVC/dnfCt6hCcdx6b7+rwocKBpaLCzZWOjGvwM3jm/wpJtGuSYhRz3D1PfO7O8WvQzIB7TUPIkv/rlMlyedO4hghHLvJMocMo65bE9gjl3C1pHsmu2WvbllNYJ+hZoVoC1LovgkZSgmDByjLwED80aqixGDgfwKqAzolrb6s2TNtVVOGFKvSvDdFeQI/vnN1aG3sAwzqY3jo9pTiM8PMfwbbWU9UxXHSDg9CFok8uNPM+WvzGwdCtFqbIZtjEv5ZKfO9HgzfgCQVtx14g1HrFHouOKG+o/L3UAH/PpcemMw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hGLTPLLx; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hGLTPLLx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4Pw06ww2z2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 19:47:11 +1100 (AEDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-49ff680331aso7527245e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 01:47:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791967628; cv=none;
        d=google.com; s=arc-20260327;
        b=ALNvKb3PwJUl2eERUO6gDs68C8BfcKHRF3vIL+RvBLmmvi4Yer+HcCPTqyHjcXCrXt
         bprVQvstNZM5qEDNSUtaKiy3XrB3A86qsAXj/EYjkOxRz/u6i5sxExnBBrD5ULtFyOKP
         E7zXHeWPbQy4WWqCPVqvpJlkOXx9vpwVhii657bMZoNFxXev0BoUv8+MQMTRJEPzIqE0
         R2fZfcmv+9E14iP31Xv7tYzaLB3dad2TtPR+g3FPXPrp4W0lC68k9Hkkc2eXoxCM8HpL
         U2Z2l4LMkbblXmMkjQmt5QaQMNElgvCoRenriSivMcjkj3QvZ4Rj4igucsJqa2Lc3aUD
         3TFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0cYhJsFY6GItBPWieM4stDAK2l4sudXXbycAkGrr3pY=;
        fh=sURwSDNzuLvVibu6NTrnPCu6l6bWXpnJRQxDVpoz6Z0=;
        b=grin2P6DW9AmSWZboh7J/3Q2AnGm8oP+cAgZH8F63cdHBe9Y6yEPjKMmCl5s+ymVWJ
         CP85/EffczwADBNBcnAVP0NBWNs+Tz7KnHH2+fkIwIv8DBGdbnZns5rWeHlebpJ+qaUx
         Er/7Qba3c/t+gPoqLTKJEdP008eMB7FFsYnsLKCTZs4m7U6ysBfMmMMyZy5onIZ1X8+N
         +5vVagSunBfVGcTx+b6QM/l+pAC4d2WtytAvRE0h8amSPksWjX30SO0Jw57soDB1H4YI
         vmNq/K/u3JWEgab7dqxgE4UCvTHMHsTpLXR4Ve9bmEn+H9K3IFliWhPdh7gn9A+SwhVG
         W4Bg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791967628; x=1792572428; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0cYhJsFY6GItBPWieM4stDAK2l4sudXXbycAkGrr3pY=;
        b=hGLTPLLxajxTPryUyHYizai1M/D1CkZrIm+ThoEhCa1E5ZV7mEx4+sDjmG+OWJ9cI2
         0KF2NcEAPF6H3Jm8N5LFF7v8H/RyeaErokJysOy+agQ2VPfYbW8LbzQeEWsdfUnVIQAr
         WttvSkM5s1kYO/HNkctIEQ+BJu2fKFUn8/+MuQllEM6MRwXOs9jumbdi2NvjdLXDD7Qi
         mlBsWQugLTbdqg6XOaoAXQXRAGOTJYxLLmK3g6iQR+xHT4/CmfPCeXtN1xgYeZ+FS7qR
         j4AZFmZprATJDq9xnzLPcs7X32wz7DUL2C6WoBXI47rXAWJYR7OI/PzPcYiexIkIYQ2L
         pYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791967628; x=1792572428;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0cYhJsFY6GItBPWieM4stDAK2l4sudXXbycAkGrr3pY=;
        b=MVtMSrb943vngH5ShYWiu2WOA5yuWYzI2Ky6Y1xpsN2hEEWmQADGZmjuXEMhgdQSkg
         9Xo1eYBLr14UKlAByNEkelUu4rUKtQjD36avdBFQn9GeSOG5O7iYClNXUBNA91LQb/qx
         cKngo9u8DvCjrMiMQa6o7HB7bAhcievzCUO9nfuas/QkDVSecWm9SOQUZ9Ml+kS9OXXl
         W7Ov6eTfIhQm2K6wgshN18+De9Ed4ijOdXPAEmXzHlGxeZALGZp3f7Dr6S1mQk2rSqkK
         3TKg8BpTGkTDsd1jlmCAatXEELzIKfMcsFUT2J1hdBmdbRQYk1ci422EwlzxQM/3lQp0
         pvyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxacB8iaCystXSClDNyvvAq/MhFB754HiDrfTTWdwQEALP9J4Zgl92rO8oHK1ef/UscBrRhj3/k6O5eBCk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKtY1OY6E1i6V6E64Tl/PoqIyxXg/Y+nVwyiPNE+YeeTiojdCHO
	W0zUaagYus5ucWWbnEdSd6qgxyT/KWr3GnY77xXFBq9O/IAYlIydXn+You8VQlTdLNiQ6XT4EUF
	N5c9fwtQQ60bTrEAOb8O3TCDEbfgs+Yk=
X-Gm-Gg: AYBFou0PPAZ4yBnhq+71FA1tks3k+ecl1ReULsFbvvs5bcbeDH3HNnISi+Qua0mqgrl
	AWZDKV2Py2mM1BosY9IzfgCy250c/gTdvy7gz6c9sJC+CRq/ZvHp5WXRaCx8dN1BORRMWscxu1T
	1xGzi5Vzo+zicH2cDoJDYJmynzJ3WwRWCzbpaUgEqWykniWe1tcQa0VaAU7OmPinPYpq4+d69m+
	nahMt7vaAtX4iT1OBDaEtfPhMMEI8i+3kSHLoboQ3LWPFkL/ssN4uCgAvRtsTy9iglaSfY58il2
	pstzCYAOGpTuoPNnHHscnvFYOFx/T00bSf9uz7+GAMTrszcP+9TNx+zAmA==
X-Received: by 2002:a05:600c:83c4:b0:4a1:7367:5395 with SMTP id
 5b1f17b1804b1-4a18e446f4amr296569785e9.2.1791967627867; Wed, 14 Oct 2026
 01:47:07 -0700 (PDT)
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
References: <20261002090947.869220-1-jiangwen6@xiaomi.com> <20261002090947.869220-2-jiangwen6@xiaomi.com>
 <7b3c3a39-4cf3-430d-9fd3-ba83e5175e72@arm.com>
In-Reply-To: <7b3c3a39-4cf3-430d-9fd3-ba83e5175e72@arm.com>
From: Wen Jiang <jiangwenxiaomi@gmail.com>
Date: Wed, 14 Oct 2026 16:46:55 +0800
X-Gm-Features: AclHuK-bFuc3dEYGYwD4zSgb8fq4NoGf2OiM-E1K3hrsnLGY-8dDIYkDzN8S8fw
Message-ID: <CAHKocdFOoDhjcuWXJatQ-AbSXyXuV+Q=sA1-iGiGrp7vhHZMBQ@mail.gmail.com>
Subject: Re: [PATCH v10 01/10] arm64/mm: add pte_set_huge() and pte_clear_huge()
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org, 
	urezki@gmail.com, will@kernel.org, Xueyuan.chen21@gmail.com, 
	ajd@linux.ibm.com, anshuman.khandual@arm.com, baohua@kernel.org, 
	chleroy@kernel.org, david@kernel.org, jiangwen6@xiaomi.com, leo.yan@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, rppt@kernel.org, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Oct 2026 at 14:03, Dev Jain <dev.jain@arm.com> wrote:
>
>
>
> On 02/10/26 2:39 pm, Wen Jiang wrote:
> > vmap installs PTE-level block mappings (PTE_CONT on arm64) by reusing
> > set_huge_pte_at() and huge_ptep_get_and_clear(), which are HugeTLB
> > helpers gated by CONFIG_HUGETLB_PAGE. This makes the feature silently
> > unavailable on CONFIG_HUGETLB_PAGE=n kernels and couples mm/vmalloc.c to
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
> > Reviewed-by: Barry Song <baohua@kernel.org>
> > ---
> >  arch/arm64/include/asm/pgtable.h |  6 ++++++
> >  arch/arm64/mm/mmu.c              | 23 +++++++++++++++++++++++
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index 6000905a2e865..9b762eb68cff0 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -1978,6 +1978,12 @@ static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
> >
> >  #endif /* CONFIG_ARM64_CONTPTE */
> >
> > +#define __HAVE_ARCH_PTE_SET_HUGE
> > +void pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
> > +               pgprot_t prot, unsigned long size);
> > +#define __HAVE_ARCH_PTE_CLEAR_HUGE
> > +pte_t pte_clear_huge(pte_t *ptep, unsigned long addr, unsigned long size);
> > +
> >  #endif /* !__ASSEMBLER__ */
> >
> >  #endif /* __ASM_PGTABLE_H */
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 79d90226fd5dc..ae2f15618c97d 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -1912,6 +1912,29 @@ int pmd_clear_huge(pmd_t *pmdp)
> >       return 1;
> >  }
> >
> > +void pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
> > +               pgprot_t prot, unsigned long size)
> > +{
> > +     unsigned long pfn = __phys_to_pfn(phys);
> > +     pte_t pte = pte_mkcont(pfn_pte(pfn, prot));
> > +     unsigned int nr = size >> PAGE_SHIFT;
> > +
> > +     VM_WARN_ON(!IS_ALIGNED(size, CONT_PTE_SIZE));
> > +     VM_WARN_ON(!IS_ALIGNED(addr, CONT_PTE_SIZE));
> > +     VM_WARN_ON(!IS_ALIGNED(pfn, CONT_PTES));
> > +
> > +     /* For vmap, there is no valid -> valid transition */
> > +     VM_WARN_ON(pte_valid(__ptep_get(ptep)));
> > +
> > +     __set_ptes(&init_mm, addr, ptep, pte, nr);
> > +}
> > +
> > +pte_t pte_clear_huge(pte_t *ptep, unsigned long addr, unsigned long size)
> > +{
> > +     return __get_and_clear_full_ptes(&init_mm, addr, ptep,
> > +                                      size >> PAGE_SHIFT, 0);
> > +}
>
> I think we should have the same VM_WARN_ON() checks here, as for
> pte_clear_huge(), in addition to also warning for
> current->mm != &init_mm.
>
> We should make it clear that pte_clear_huge() gets called only for
> kernel mappings, and the range we operate on is definitely an aligned
> CONT range - which is why we do not go through get_and_clear_full_ptes ->
> contpte_get_and_clear_full_ptes, and possibly contpte_try_unfold(), but
> directly use __get_and_clear_full_ptes.
>

Hi Dev,

I'll add the alignment VM_WARN_ON() checks to pte_clear_huge() to
match pte_set_huge().

Regarding the current->mm != &init_mm check: these functions don't take
an mm parameter -- &init_mm is hardcoded in the function body.
current->mm would never equal &init_mm in practice: for user processes it
points to the process's own mm, and for kernel threads it is NULL.
So VM_WARN_ON(current->mm != &init_mm) would always fire.

The existing hugetlb helpers that vmalloc used before this decoupling
(huge_ptep_get_and_clear -> get_clear_contig) also take mm as a
parameter
and don't check current->mm either -- the caller simply passes &init_mm.

How about adding a comment to make the "kernel mapping only" intent
more explicit?
Something like:

 pte_t pte_clear_huge(pte_t *ptep, unsigned long addr, unsigned long size)
 {
+       /* Kernel mappings only */
+
+       VM_WARN_ON(!IS_ALIGNED(size, CONT_PTE_SIZE));
+       VM_WARN_ON(!IS_ALIGNED(addr, CONT_PTE_SIZE));
+
        return __get_and_clear_full_ptes(&init_mm, addr, ptep,
                                         size >> PAGE_SHIFT, 0);
 }

Thanks,
Wen

