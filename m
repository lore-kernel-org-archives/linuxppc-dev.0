Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B0FC169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 17:42:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8718D20863
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 17:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="fT9JNspF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8718D20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43x2Z45lNkzDqcW
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 04:42:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=andreyknvl@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="fT9JNspF"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43x2X45DsBzDqbY
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 04:40:35 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id z11so1887946pgu.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Feb 2019 09:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Go1VRvx/8L0QU1rl0vOOYSWKTtgB0UTzUDeaSFlHE/U=;
 b=fT9JNspFdYqEr4bCaMIUIrtSDQIzlMNulJrhxo0r4NEHCbBHju9o76Uu2IvCDKZt+p
 gIzXDsyRVl1/QlbACnOssBnuB7b+sASRwkav4196DBlELMZ+GrioA/NCPaxnvbUFZuk8
 cU27aRYeyEDjqZXIBSj8fNLCZlGMzoUfz0hFbfWsqrV/Gr52Bkg4bD779RDYjN7E2Tt+
 2sUKzMS3OR4hKf81JJGiGlFlYRbkw9q38Jmuig22thBwndgXItQ9FVUxPXLzSwsuJVRA
 iHR9izIab78Y6JDuiYCeVBOYHULdukt7pTj7Pm+JDUvvqmZ9g8Ve09ezhksKoJRn53D9
 1isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Go1VRvx/8L0QU1rl0vOOYSWKTtgB0UTzUDeaSFlHE/U=;
 b=a3S68VlnEC7eX9/sq+MzRhtMoFXzunG288e2j0Vy82fB5acjWR5B/ka3oNGEz4tR7S
 QGmhTH4cyOfh9CLtSngFk44q2HtUrD5XzkWbUPgRSD4Xzi5kQ3z7OnJ1uDqiF1L77PiO
 n6RGAK2xfiXQ9+GJdwX0NhNAdmri9mDlWj75rgDJ+FmeNEtk6HjaVu6FrccU35E1+KIz
 rqLViNX52m7zwKniZ9pcZBS8wcWopIU1uX8tcDq6Po21e0Vb3Dm4tmlWbEFLu5fvBlve
 MlllH7JIQcNFt/C3eZW8NCRDjZYJga6vEMA4lHIGGWxHvUnGWLWm24iCMW2vbeBUvf+l
 FuFA==
X-Gm-Message-State: AHQUAuZ79SGdZEkXiKFFDdnhe+N5s2vONYDs8tZzpdLCo/HeIjO5aHBe
 Ao7+QjeFi6ZXcVqh49y+1OjETriZNVCXxR9kGJ5UxQ==
X-Google-Smtp-Source: AHgI3IZJKdSSj7Vgo9NmfLXYnXi4fnyw/ajbO6S4cAcNvP4TePiNubBDJ4qJC+2i/sxVck4KUp6amBNYeaseuNWQpfM=
X-Received: by 2002:a63:7044:: with SMTP id a4mr21178893pgn.359.1549647633096; 
 Fri, 08 Feb 2019 09:40:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548166824.git.christophe.leroy@c-s.fr>
 <1f5629e03181d0e30efc603f00dad78912991a45.1548166824.git.christophe.leroy@c-s.fr>
 <87ef8i45km.fsf@dja-thinkpad.axtens.net>
 <69720148-fd19-0810-5a1d-96c45e2ec00c@c-s.fr>
In-Reply-To: <69720148-fd19-0810-5a1d-96c45e2ec00c@c-s.fr>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Fri, 8 Feb 2019 18:40:21 +0100
Message-ID: <CAAeHK+wcUwLiSQffUkcyiH2fuox=VihJadEqQqRG1YfU3Y2gDA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] powerpc/32: Add KASAN support
To: Christophe Leroy <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: LKML <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>,
 kasan-dev <kasan-dev@googlegroups.com>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>, Dmitry Vyukov <dvyukov@google.com>,
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 8, 2019 at 6:17 PM Christophe Leroy <christophe.leroy@c-s.fr> w=
rote:
>
> Hi Daniel,
>
> Le 08/02/2019 =C3=A0 17:18, Daniel Axtens a =C3=A9crit :
> > Hi Christophe,
> >
> > I've been attempting to port this to 64-bit Book3e nohash (e6500),
> > although I think I've ended up with an approach more similar to Aneesh'=
s
> > much earlier (2015) series for book3s.
> >
> > Part of this is just due to the changes between 32 and 64 bits - we nee=
d
> > to hack around the discontiguous mappings - but one thing that I'm
> > particularly puzzled by is what the kasan_early_init is supposed to do.
>
> It should be a problem as my patch uses a 'for_each_memblock(memory,
> reg)' loop.
>
> >
> >> +void __init kasan_early_init(void)
> >> +{
> >> +    unsigned long addr =3D KASAN_SHADOW_START;
> >> +    unsigned long end =3D KASAN_SHADOW_END;
> >> +    unsigned long next;
> >> +    pmd_t *pmd =3D pmd_offset(pud_offset(pgd_offset_k(addr), addr), a=
ddr);
> >> +    int i;
> >> +    phys_addr_t pa =3D __pa(kasan_early_shadow_page);
> >> +
> >> +    BUILD_BUG_ON(KASAN_SHADOW_START & ~PGDIR_MASK);
> >> +
> >> +    if (early_mmu_has_feature(MMU_FTR_HPTE_TABLE))
> >> +            panic("KASAN not supported with Hash MMU\n");
> >> +
> >> +    for (i =3D 0; i < PTRS_PER_PTE; i++)
> >> +            __set_pte_at(&init_mm, (unsigned long)kasan_early_shadow_=
page,
> >> +                         kasan_early_shadow_pte + i,
> >> +                         pfn_pte(PHYS_PFN(pa), PAGE_KERNEL_RO), 0);
> >> +
> >> +    do {
> >> +            next =3D pgd_addr_end(addr, end);
> >> +            pmd_populate_kernel(&init_mm, pmd, kasan_early_shadow_pte=
);
> >> +    } while (pmd++, addr =3D next, addr !=3D end);
> >> +}
> >
> > As far as I can tell it's mapping the early shadow page, read-only, ove=
r
> > the KASAN_SHADOW_START->KASAN_SHADOW_END range, and it's using the earl=
y
> > shadow PTE array from the generic code.
> >
> > I haven't been able to find an answer to why this is in the docs, so I
> > was wondering if you or anyone else could explain the early part of
> > kasan init a bit better.
>
> See https://www.kernel.org/doc/html/latest/dev-tools/kasan.html for an
> explanation of the shadow.
>
> When shadow is 0, it means the memory area is entirely accessible.
>
> It is necessary to setup a shadow area as soon as possible because all
> data accesses check the shadow area, from the begining (except for a few
> files where sanitizing has been disabled in Makefiles).
>
> Until the real shadow area is set, all access are granted thanks to the
> zero shadow area beeing for of zeros.

Not entirely correct. kasan_early_init() indeed maps the whole shadow
memory range to the same kasan_early_shadow_page. However as kernel
loads and memory gets allocated this shadow page gets rewritten with
non-zero values by different KASAN allocator hooks. Since these values
come from completely different parts of the kernel, but all land on
the same page, kasan_early_shadow_page's content can be considered
garbage. When KASAN checks memory accesses for validity it detects
these garbage shadow values, but doesn't print any reports, as the
reporting routine bails out on the current->kasan_depth check (which
has the value of 1 initially). Only after kasan_init() completes, when
the proper shadow memory is mapped, current->kasan_depth gets set to 0
and we start reporting bad accesses.

>
> I mainly used ARM arch as an exemple when I implemented KASAN for ppc32.
>
> >
> > At the moment, I don't do any early init, and like Aneesh's series for
> > book3s, I end up needing a special flag to disable kasan until after
> > kasan_init. Also, as with Balbir's seris for Radix, some tests didn't
> > fire, although my missing tests are a superset of his. I suspect the
> > early init has something to do with these...?
>
> I think you should really focus on establishing a zero shadow area as
> early as possible instead of trying to ack the core parts of KASAN.
>
> >
> > (I'm happy to collate answers into a patch to the docs, btw!)
>
> We can also have the discussion going via
> https://github.com/linuxppc/issues/issues/106
>
> >
> > In the long term I hope to revive Aneesh's and Balbir's series for hash
> > and radix as well.
>
> Great.
>
> Christophe
>
> >
> > Regards,
> > Daniel
> >
> >> +
> >> +static void __init kasan_init_region(struct memblock_region *reg)
> >> +{
> >> +    void *start =3D __va(reg->base);
> >> +    void *end =3D __va(reg->base + reg->size);
> >> +    unsigned long k_start, k_end, k_cur, k_next;
> >> +    pmd_t *pmd;
> >> +
> >> +    if (start >=3D end)
> >> +            return;
> >> +
> >> +    k_start =3D (unsigned long)kasan_mem_to_shadow(start);
> >> +    k_end =3D (unsigned long)kasan_mem_to_shadow(end);
> >> +    pmd =3D pmd_offset(pud_offset(pgd_offset_k(k_start), k_start), k_=
start);
> >> +
> >> +    for (k_cur =3D k_start; k_cur !=3D k_end; k_cur =3D k_next, pmd++=
) {
> >> +            k_next =3D pgd_addr_end(k_cur, k_end);
> >> +            if ((void *)pmd_page_vaddr(*pmd) =3D=3D kasan_early_shado=
w_pte) {
> >> +                    pte_t *new =3D pte_alloc_one_kernel(&init_mm);
> >> +
> >> +                    if (!new)
> >> +                            panic("kasan: pte_alloc_one_kernel() fail=
ed");
> >> +                    memcpy(new, kasan_early_shadow_pte, PTE_TABLE_SIZ=
E);
> >> +                    pmd_populate_kernel(&init_mm, pmd, new);
> >> +            }
> >> +    };
> >> +
> >> +    for (k_cur =3D k_start; k_cur < k_end; k_cur +=3D PAGE_SIZE) {
> >> +            void *va =3D memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> >> +            pte_t pte =3D pfn_pte(PHYS_PFN(__pa(va)), PAGE_KERNEL);
> >> +
> >> +            if (!va)
> >> +                    panic("kasan: memblock_alloc() failed");
> >> +            pmd =3D pmd_offset(pud_offset(pgd_offset_k(k_cur), k_cur)=
, k_cur);
> >> +            pte_update(pte_offset_kernel(pmd, k_cur), ~0, pte_val(pte=
));
> >> +    }
> >> +    flush_tlb_kernel_range(k_start, k_end);
> >> +}
> >> +
> >> +void __init kasan_init(void)
> >> +{
> >> +    struct memblock_region *reg;
> >> +
> >> +    for_each_memblock(memory, reg)
> >> +            kasan_init_region(reg);
> >> +
> >> +    kasan_init_tags();
> >> +
> >> +    /* At this point kasan is fully initialized. Enable error message=
s */
> >> +    init_task.kasan_depth =3D 0;
> >> +    pr_info("KASAN init done\n");
> >> +}
> >> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> >> index 33cc6f676fa6..ae7db88b72d6 100644
> >> --- a/arch/powerpc/mm/mem.c
> >> +++ b/arch/powerpc/mm/mem.c
> >> @@ -369,6 +369,10 @@ void __init mem_init(void)
> >>      pr_info("  * 0x%08lx..0x%08lx  : highmem PTEs\n",
> >>              PKMAP_BASE, PKMAP_ADDR(LAST_PKMAP));
> >>   #endif /* CONFIG_HIGHMEM */
> >> +#ifdef CONFIG_KASAN
> >> +    pr_info("  * 0x%08lx..0x%08lx  : kasan shadow mem\n",
> >> +            KASAN_SHADOW_START, KASAN_SHADOW_END);
> >> +#endif
> >>   #ifdef CONFIG_NOT_COHERENT_CACHE
> >>      pr_info("  * 0x%08lx..0x%08lx  : consistent mem\n",
> >>              IOREMAP_TOP, IOREMAP_TOP + CONFIG_CONSISTENT_SIZE);
> >> --
> >> 2.13.3
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/69720148-fd19-0810-5a1d-96c45e2ec00c%40c-s.fr.
> For more options, visit https://groups.google.com/d/optout.
