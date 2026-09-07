Return-Path: <linuxppc-dev+bounces-26698-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09186C79FAA
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 21:07:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hf05m2mB5z2xKN;
	Tue, 08 Sep 2026 07:07:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:34::10" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788815276;
	cv=pass; b=dyTorkPGqy/3xWZ7GzO4TnlDgR3V4vfxOX5e+KLlKTvpDJgEdBBx/dwOCK6xpqiVo+JoDTfvxyG8sf1QBRYbmEcVgc6jfT6HfEgy/mvGpbesFaDdYM83IBKGcpGtrj24VbshtW+PAGM2g2x5YmSYQIPbPBhPCThjQSwn9eoXZh7mUBsvSEoCzYb6fcR/TyN9vpLJBS8DhLRyf3wXEtS9uJWvv1q0UkMtg0G9qwP/YhsdaNqMc3nfuuSJqDfMZZ1TD/ey4ucA7uBp9JDhapq0h3g1DFxzrMCMD+dkS66TCeib9Dudx6A8U57zxAQzC7e7SfJsmdr6YnsruTXMpFfh3A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788815276; c=relaxed/relaxed;
	bh=j33dWXa87ubHe2rcHlgmZCfdvDttwcXovkMGxt/Pcfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOEI4XYvJXvbME495dxJo46C4FLBonFzNdQE2J97hAHg1WIU8UcC1RHFlBrTXRvFHeTz9Z4sU/sPgIAy7jyl4GEyVSX/FtyrbIx1mygTllW+Ny163z9k1TMph2fLqrRm6jPLDHyr/RqG+6r+YKV+tpSdyfZrfViC3PgLaV2UTvPZgd2aFVdZTkVFRE6Y6bFFVYo1WJv2JTW2rveqV5MmtYbFh4Vf9A/pSW8ebrOPrfvhnuwmaDIdykzDih1jVSa2OcGgFBCJjnMyQftcS4wmhtcV3TgXY0T28B7ydnq7hoZXHbEg9/Jc+h4iQaqTux42fzTXjpR/e+MzGMr+mnK60Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NMTQn1uk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:34::10; helo=mail-qk2-x10.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NMTQn1uk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:34::10; helo=mail-qk2-x10.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qk2-x10.google.com (mail-qk2-x10.google.com [IPv6:2607:f8b0:4864:34::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hf05k55hWz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 07:07:54 +1000 (AEST)
Received: by mail-qk2-x10.google.com with SMTP id d75a77b69052e-5306706e89dso455981cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 14:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788815271; cv=none;
        d=google.com; s=arc-20260327;
        b=X8L3NhlqpJ8MMPlcCWn/scjBLIJ63OSssej8TPwxeaZpPaHbDKwPSgkNACM0StnSe9
         ndPdmiMqOz1Ip6B3opBMsf7d/zNq9L2JAvc73cVbBFhwt5KWMhdaa9Yexl3KyVswsLEx
         unrJPT7sAvVaXU52FUwAPI8IBTc6BVjHnLiyujy/7Q16ofo9V92CD3PAO2rByVtaC0ko
         2dF6o0mHI2dfeWbu35xcJngLMTJ3RarJKAtaG2flCr4C84pqgwAmi8lTYxbO3r69QO2b
         9B/GE6RD5YHUYi7I4SVDhsxHQ9n2iqHeER/Fr96ENaU3lizq01TBovFDlFGa5ixbRNgD
         wsXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j33dWXa87ubHe2rcHlgmZCfdvDttwcXovkMGxt/Pcfc=;
        fh=0C/IoAREQ55RJf4D+g3rVFBNOd1KO4iri8s088ERMP8=;
        b=fRzP4Qzzq6XFsY4fy+wnxP34HiLY9bsX5OXNibGe9XOiQtiQqzknf6nv8VtUjidtla
         9OLpc3IjkDV+OuJLyvcHKfPeGh0iLHtlCWr3StKOdKaoypn9nTGxqor9FJhpYtwIC8Vd
         SrLKD+i+1byYNdoqPtGH+ww4phE5n85qVdH13wwk2q60wv9LfOQpzVCUykNglX/FQHky
         j4Nhue45vTn6CQ7W+wRBYqvLiTZ2XwePPpuu/CB+uaKQZMyD+cwl/l0RobfUmSdyqFNb
         mgvyO+10r3Z9KOcvII/F7c0iOdT3FubIVVrSGIBVvpM/poAlBGOEB31S2xxgXM3VbeC6
         9Dtw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788815271; x=1789420071; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j33dWXa87ubHe2rcHlgmZCfdvDttwcXovkMGxt/Pcfc=;
        b=NMTQn1ukfK6mQ6EOdK5+dY+xnX8eAPY+SBdH1X6G4tdwxr4qGryQUf+xVt2I/e3QKM
         TrRHeLamy75X2WRcEpI0UxdLMpWKOM3q74hJi4e0vLmWbO+m6mFcwYFfFbOJgwrPRCFC
         x3czyI0QJzESbn5y+SdU2MJ2mlhAqxN4rKOXj88fxugwAPXlLFTGlD3P46gI5lxvj3a1
         vk7x4KhQPhN+heLX/taj3TXLole6ONu1omh14DRCXSIj58plVpkGb0etEOxJheVxnN24
         7nxTRpQa6muHVSLSIxn9I4zfX0X/jaoaMB4NGSLvDI88LqMlVfWQrThLGLIrqoe0d970
         qNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788815271; x=1789420071;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j33dWXa87ubHe2rcHlgmZCfdvDttwcXovkMGxt/Pcfc=;
        b=KpBUugtYfnNpJaLBBuMFRiUd1iMVpUtdrDfxEoJ6Ut1/TG1ZusP3YcKuTaE7RO02mw
         LozlSJuz3zqpMKfgPFQeWFO16VpH3wnQpbo4YotMi4acQWllfCj8biA/5HqKIztDRGtC
         +p3wuqQ6QTL9JQnB4hwkOjYPGUpMOH8wzFNBBY104fZY0dlCW8wzih4OgpJJYRDTWNis
         +UlcsuXOPZ6ab4v10weK9IjYW/Dnz4d4r1h3Z0siRLPjoZpo3bgUIlU5OCCN1pVenk8y
         k8qnSjGQpj+DfJGsjZQ0oOdXcved8BUl+73M8EEd+coN9SXfGC3X2aKX8WlQ+U7fX7o/
         PkWA==
X-Forwarded-Encrypted: i=1; AKwUvBzZp++D5OXAzxYxN+rKRAZaPkXPopihLjl15x031VJYwAJKhd84CevdqdA+spNPMyX6OTSo0t1gO3sWHAs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mEnKcMfY67itlCiTzOt8h9p5cwXciLLgorB4IRMjtsOInfG7Gy
	hVV0FAG3JUitb3RiwRQZ0Avbe3p4UMnJZg5ZJjCouw7YV65Jk4YALwRptBaVF3BPm4qIoYT/yHl
	KDY+LDe3OIFZ7WNuqsxV+9rN6OlPs5MP37vg9otig
X-Gm-Gg: AYBFou3p89J45Po+KYiEd98zzBmFXG+stK7qbj3w+HM3KaHgKdi6URqg+O5wY0xMBUP
	kAurk5qQU8IEZHxvRej95F/7mX1r0DAWgho8mRvTv9VTo3bdA0YMIiMdDI+CK+UFsnN8JyaWqWV
	OHb+AbIiNTdErjKar/z5Qoy+NdaeW/Mkzvmp9GbUPrFNTZcifuoKkglAcxiMn9/0ih7bCaTiexy
	noQJPxZO3KtW3Cs3XVGOVPJZick/HwS6newx/oq8U2UPdTxz6KFlyM2UOr8VcgPa3f6gtqb0HF8
	rwAiCZwLtopoIlJt3n2EcZ76yKcEKCi8R41yfl9CRXY=
X-Received: by 2002:a05:622a:2589:b0:517:64f6:3365 with SMTP id
 d75a77b69052e-53065d7943emr35669061cf.4.1788815269129; Mon, 07 Sep 2026
 14:07:49 -0700 (PDT)
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
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org> <20260901-rcu-pagetable-freeing-v1-5-5456a81c8212@kernel.org>
In-Reply-To: <20260901-rcu-pagetable-freeing-v1-5-5456a81c8212@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 7 Sep 2026 14:07:37 -0700
X-Gm-Features: AcwNN1U8TkUrFVP6EqWbmqC7u-eOkQZui9u0urXe4uY9QHhCrt9ILjWVeJ-SJWo
Message-ID: <CAJuCfpESe_BXihJh-8FhjQVKzsSpnS4zdMgg3e59byJTc8QViA@mail.gmail.com>
Subject: Re: [PATCH 05/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for arc,
 microblaze, xtensa
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Dinh Nguyen <dinguyen@kernel.org>, Simon Schuster <schuster.simon@siemens-energy.com>, 
	Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, 
	Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 4:06=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Each of these architectures directly free page tables without routing the=
se
> changes through tlb_remove_ptdesc().
>
> The use of tlb_remove_ptdesc() is required for
> CONFIG_MMU_GATHER_RCU_TABLE_FREE to correctly free page tables under RCU,
> so simply update these architectures to use these functions.
>
> Since none of the architectures share page tables or do anything unusual,
> nothing complicated is required here.
>
> Therefore this is simply a mechanical change - convert __pud_free_tlb(),
> __pmd_free_tlb() and __pte_free_tlb() to use tlb_remove_ptdesc() as
> required.
>
> At the point this is in place, all mmu_gather page table freeing is
> performed under RCU, and thus MMU_GATHER_RCU_TABLE_FREE is selected for
> each architecture.
>
> This forms part of an overall effort to switch every architecture to this
> mode.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  arch/arc/Kconfig                      | 1 +
>  arch/arc/include/asm/pgalloc.h        | 6 +++---
>  arch/microblaze/Kconfig               | 1 +
>  arch/microblaze/include/asm/pgalloc.h | 2 +-
>  arch/xtensa/Kconfig                   | 1 +
>  arch/xtensa/include/asm/tlb.h         | 2 +-
>  6 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index 2ed7186c81c5..7a7542b61823 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -47,6 +47,7 @@ config ARC
>         select HAVE_SYSCALL_TRACEPOINTS
>         select IRQ_DOMAIN
>         select LOCK_MM_AND_FIND_VMA
> +       select MMU_GATHER_RCU_TABLE_FREE
>         select MODULES_USE_ELF_RELA
>         select OF
>         select OF_EARLY_FLATTREE
> diff --git a/arch/arc/include/asm/pgalloc.h b/arch/arc/include/asm/pgallo=
c.h
> index dfae070fe8d5..9b6c37f92e97 100644
> --- a/arch/arc/include/asm/pgalloc.h
> +++ b/arch/arc/include/asm/pgalloc.h
> @@ -72,7 +72,7 @@ static inline void p4d_populate(struct mm_struct *mm, p=
4d_t *p4dp, pud_t *pudp)
>         set_p4d(p4dp, __p4d((unsigned long)pudp));
>  }
>
> -#define __pud_free_tlb(tlb, pmd, addr)  pud_free((tlb)->mm, pmd)
> +#define __pud_free_tlb(tlb, pmd, addr)  tlb_remove_ptdesc((tlb), virt_to=
_ptdesc(pmd))
>
>  #endif
>
> @@ -83,10 +83,10 @@ static inline void pud_populate(struct mm_struct *mm,=
 pud_t *pudp, pmd_t *pmdp)
>         set_pud(pudp, __pud((unsigned long)pmdp));
>  }
>
> -#define __pmd_free_tlb(tlb, pmd, addr)  pmd_free((tlb)->mm, pmd)
> +#define __pmd_free_tlb(tlb, pmd, addr)  tlb_remove_ptdesc((tlb), virt_to=
_ptdesc(pmd))
>
>  #endif
>
> -#define __pte_free_tlb(tlb, pte, addr)  pte_free((tlb)->mm, pte)
> +#define __pte_free_tlb(tlb, pte, addr)  tlb_remove_ptdesc((tlb), page_pt=
desc(pte))
>
>  #endif /* _ASM_ARC_PGALLOC_H */
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index 484ebb3baedf..af7e821e96c1 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -41,6 +41,7 @@ config MICROBLAZE
>         select PCI_SYSCALL if PCI
>         select CPU_NO_EFFICIENT_FFS
>         select MMU_GATHER_NO_RANGE
> +       select MMU_GATHER_RCU_TABLE_FREE
>         select SPARSE_IRQ
>         select ZONE_DMA
>         select TRACE_IRQFLAGS_SUPPORT
> diff --git a/arch/microblaze/include/asm/pgalloc.h b/arch/microblaze/incl=
ude/asm/pgalloc.h
> index 084a8a0dc239..ffee6a009219 100644
> --- a/arch/microblaze/include/asm/pgalloc.h
> +++ b/arch/microblaze/include/asm/pgalloc.h
> @@ -25,7 +25,7 @@ extern void __bad_pte(pmd_t *pmd);
>
>  extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
>
> -#define __pte_free_tlb(tlb, pte, addr) pte_free((tlb)->mm, (pte))
> +#define __pte_free_tlb(tlb, pte, addr) tlb_remove_ptdesc((tlb), page_ptd=
esc(pte))
>
>  #define pmd_populate(mm, pmd, pte) \
>                         (pmd_val(*(pmd)) =3D (unsigned long)page_address(=
pte))
> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index f2f9cd9cde50..33c4caee30e2 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -55,6 +55,7 @@ config XTENSA
>         select HAVE_VIRT_CPU_ACCOUNTING_GEN
>         select IRQ_DOMAIN
>         select LOCK_MM_AND_FIND_VMA
> +       select MMU_GATHER_RCU_TABLE_FREE if MMU

And MMU is required because NOMMU does not perform mmu_gather
operations, same as in the previous patch? If so, maybe make a note of
it in the changelog?

>         select MODULES_USE_ELF_RELA
>         select PERF_USE_VMALLOC
>         select TRACE_IRQFLAGS_SUPPORT
> diff --git a/arch/xtensa/include/asm/tlb.h b/arch/xtensa/include/asm/tlb.=
h
> index 8c3ceb427018..6fb7b78154f6 100644
> --- a/arch/xtensa/include/asm/tlb.h
> +++ b/arch/xtensa/include/asm/tlb.h
> @@ -16,7 +16,7 @@
>
>  #include <asm-generic/tlb.h>
>
> -#define __pte_free_tlb(tlb, pte, address)      pte_free((tlb)->mm, pte)
> +#define __pte_free_tlb(tlb, pte, address)      tlb_remove_ptdesc((tlb), =
page_ptdesc(pte))
>
>  void check_tlb_sanity(void);
>
>
> --
> 2.55.0
>

