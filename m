Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8BE606A338
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 01:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LDauOIbk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQ2WN04k2z2yR1;
	Thu, 12 Nov 2026 12:15:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794446127;
	cv=pass; b=EFDeNOb86EVIIGPbygU7QGK675bXf08L/yWnLk5iw1WHXcBaAfaMBBgwi9DiD5cKI1RamicE+bEvkvGee8dGSB3Ml6ZYObTCuE3haYeN7Jk9cD4vsoGHs1UWDwzlnMC2pJuZ6JeaV48NnR9PkIFwVNDs/2a1IHyl8UiiVW36uCFfdJESNswzTALHdTg+4OZaVYnPEUe2Wj6Dwm+sw41ZbryKzwn9IPa2zx+qYdWZX9FDVH+27edoMbF29c3h6MfNKmsy22z6G7TWw1vHuJ/aNIf9aM5vJx5IVPdFdh2O+RC535A/PTSWEMLo/e0dL9mFW4L/FWsHc4A8QlzN/v6nbA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794446127; c=relaxed/relaxed;
	bh=9a0zqbKXeobEqiLKUEeOvGBAydGpaXNxzwtSlXyYudU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6A6QAZ5vkHXuwiXrpsdGuTQUN65sajMmuHvP34c6Hg5LP+DGgwUMpMd00m7gPm4svXBOqP+XwvCfjLd8gUbrnTq6rYFSuYq/WeKv1zxeAV5reRXmpcoVywKvV3KO8fBAMK2ZM92ymlTDj91ffGmZCXmvIKATj58VycvnMQrnWfO9S7gUSZirq53axcm6xO23HMbXivlqniezvOECGhYYslGnDXqyzSVLGz5r0BF4ZT/rw00FE4qEid0p1MczYv/IEBT0qJUCRVagOvC4wIVjxtYDyRSC1vDeQLXt1YStD2XS6hIJTAxNGYc5+PLUv/yHytH1kwbRHPPEs1OUjLobg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LDauOIbk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LDauOIbk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQ2WK6y0fz2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 12:15:25 +1100 (AEDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-535f598d126so53511cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 17:15:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794446123; cv=none;
        d=google.com; s=arc-20260327;
        b=ihAh5QgJmstzWCbRVU4Z67owowyY43X37urei4bHuiOY7qYHQ9w3/3uCL/KkJUqADW
         EM/uamG5KU9Ksehvi49pSvUa//ygUX65qLE9pCdf7v2G0YCkXiJeOV+D7j4AtVQrP1WR
         +zgjfGyfng3/3HdWQY4dSI96vj+RF4MmnnxZaGH+p/bwW/8tfDewYMw0J28KPztFgOxI
         SuZJ2ooX+bu/LGiRJb02poDKdrYlIwPWrKbHslg3pP1kzQqwYJosw3OK5JLCzSQYU+XF
         2uMNwGk61XFE6zSRikpKetTkDZ0Y/Ssb9+rklUw2TVaJn47BiFWNBSpnWU6Zf/MJXK3k
         lgog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9a0zqbKXeobEqiLKUEeOvGBAydGpaXNxzwtSlXyYudU=;
        fh=FG6M9N2t63mmAN2ion0fPWhDwovAqzQu2L+zsl5zLT8=;
        b=BykYNM2MB9i8Ejuo7TWWJwNnK1OHoeCvd6elBbDbykgUIoWg+j6ZCgNp1ekOd2qQgW
         UzhpkPL0t8gqOCCroKhxd8lAwtvRh9gANBMkkLWvgJAg+qS/rkO8NI74wFwuL/KZ4QMR
         gtBBXIilp8Z6hKS/bYCj+prHnocThQKF5oMrjB5/E1PDgWq5vkU54Xrd50dAhdlRtVVa
         ER+kvrU3/lQB1EPzM1EXls/pj/IQVXRJMcwg370j6avlcMZBuNA9ohNFXcIrPo6DEt87
         F4OBtaftG3X/Qswe8+ZixxQmoS92MKxN7mwJJnEc7lVsgocFj0KfsqRweN5fuSCDA2cr
         dJ7g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794446123; x=1795050923; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9a0zqbKXeobEqiLKUEeOvGBAydGpaXNxzwtSlXyYudU=;
        b=LDauOIbkKKP6fLiYYMyZOD7EFa5TlaTPEpFezuVxvbREZVNKqrRD6I9Ur7L0Rr0TEP
         EbFcoH78g3Rz9CPx6LTWIh3C7bFmTF3EROriuBOeKphsQpfUMX68WHBSe7KzT/BbsKGV
         WALfhgdJ0HoMku1NenNWlcoZyY9gDQCVP7Cwecl83Gxlp9dYgWwkkXFgAyAVZ51KWEov
         Ub6c0qrAPstthBuVEbWU4ZesfeKsuCoYPR4/vi4lIV2nJlZdQ5GABLrcXf7Ceqevvw2N
         VL3ZeA7kJKkxkdq95FNn96J0gTiKom+BwSYeuM6m1vvUNN9tIhbigQtVTcozl/Ml4w2D
         TtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794446123; x=1795050923;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9a0zqbKXeobEqiLKUEeOvGBAydGpaXNxzwtSlXyYudU=;
        b=bGSyUl6MnWFio1UbF77dKHBM8EtRh5g2ZExobDmu1Og4FSEsufsltoJAg2QR3qhqOZ
         6WJAPiRYWOCGbig7+UZh/hnU9NUGrX798TxXzcS5mwcP62esYF8tYVwaCCv4nKO3H2Qw
         OxELpGf0J80ylUuxJreRI1Eo+4nVTh8R5YEtYOfEo4uE9QBrqfRZivuiRc8nre1Lx+iG
         0KaZNbVSx4JHK7p4TLRx3JW3jEOa5Ag63uVmn69ipwskoZTMsrj5zhQreQ2KtR3B2EMa
         omjrCbHLSBLPwZmc1hYsH/r9R3ajM6gsNSNlwOK0JYyGVc+pl3SH3nCXLWqOibqKoQS1
         9JtA==
X-Forwarded-Encrypted: i=1; AL+hErF4zesRMtV0nut/zKN1SwSION0yWjbfmt2jUzNG5oeVB0OPBNYtcUFaMLnCGCPlTRQ+03L1U6gfsSFuRhs=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9lE1U7CEIvX0IYeQ/w9m6vEiKSJMEp+4SDEuSoVz1gSnrj5C3S
	b1xRHYF/cWInoPy+YgtHMuWQmITpYI2IGuYVsafp0Z1zvvTD622VcbSvqk5VnMxtQ58iZVSh72v
	8FpzbU/jSPnYfL90P7rLMteErJdztCu9g5J+az/Pd
X-Gm-Gg: AYBFou2e8Cq1sHikkdulqNfd5dX5VE++exs5zxj2n/+iU+tlG+wO/vQoETLAHigVieI
	OBI4QA9ZCThU+NFAYhm0ozCkjtXOWvPuPakw/TGUF5HgzVBSTB0PyzgfmGTnN7lPzKH2+1vFoBs
	QOk+eMj4yQq0m9C7wMhuzqPMyFjweO1LM1j0LCnIe0sr4oauiOLswE0reZzaaA8mJCk21do9xQC
	JlhShK6UvbJjMrXd+77IBMW05oR/A0UiAGaCl0zbGv53sAnb8m+kye8pShvsBTH/gCYW5Z2MtKp
	UwJGuqwDDe1xTJAbKWTnMXH3Icmc90OWrCSwO9W4uQ2BtkgUl1tdX65lkEA1zLsmuAlku/vnBKL
	eW1yZQ8h5iEGz3458sOTH4EleElcFmNEHb0/DrJpMog2IHi7nOquFfVW/MGDjx2uoNV/x8HmckY
	FAYl6KWcopPfMwWTsGmLTbQzAf
X-Received: by 2002:a05:622a:1e07:b0:536:97c0:dcd0 with SMTP id
 d75a77b69052e-5596dbd7d56mr8576951cf.4.1794446121968; Wed, 11 Nov 2026
 17:15:21 -0800 (PST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110112546.261415-1-hao.ge@linux.dev> <20261110112546.261415-8-hao.ge@linux.dev>
In-Reply-To: <20261110112546.261415-8-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 12 Nov 2026 01:15:09 +0000
X-Gm-Features: AclHuK-zAC-IeQ8aLVFiwYzq7tLi3yUNydZZveOqio07sklDAsvxkskKKL_OCWU
Message-ID: <CAJuCfpFHaahsCNkXCOn8ks65yj_bPy33cOLZ5BW=rtTOuedLqw@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] mm/vmalloc: undo partial mappings inside the
 mapping functions
To: Hao Ge <hao.ge@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 11:25=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> The vmap entry points may install some PTEs and then fail, leaving a
> partial mapping behind.
>
> The callers do not agree on who cleans it up. pcpu_map_pages() and
> kmsan_ioremap_page_range() roll back what they mapped, while
> vm_module_tags_populate() and the __GFP_NOFAIL retry loop in
> __vmalloc_area_node() expect a clean range from the mapping function.
> For them the leftovers stay mapped, and the next attempt to map the
> same range trips the WARN_ON(!pte_none()) in vmap_pages_pte_range().
> A leftover huge pmd is even worse. During the retry, vmap_try_huge_pmd()
> calls pmd_free_pte_page() on it, and the x86 implementation cannot
> tell a leaf entry from a page table and frees the mapped page.
>
> After discussing with Suren and Ulad, we decided to put the rollback
> into the entry points of the vmap API rather than into every
> low-level helper. __vmap_pages_range_noflush() undoes the whole range
> it was asked to map when it fails, and vmap_page_range() undoes its
> range for the ioremap-style mappings.
>
> The rollback is __vunmap_range_noflush(), which only clears the PTEs.
> No TLB flush is needed, nothing has touched the mapping yet.
> vmap_pages_range_noflush() also drops the KMSAN metadata of the
> failed mapping.
>
> The undo walk skips its cond_resched() when the caller's gfp mask
> cannot block. __vmalloc() with GFP_ATOMIC or GFP_NOWAIT can run in
> atomic context, where cond_resched() cannot schedule.
> __vunmap_range_noflush() takes a can_resched argument for that, which
> the sleepable callers pass as true.
>
> Suggested-by: Uladyslau Rezki <urezki@gmail.com>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  include/linux/kmsan.h |  8 ++++--
>  mm/kmsan/hooks.c      | 18 ++++++++-----
>  mm/kmsan/shadow.c     |  7 ++---
>  mm/vmalloc.c          | 61 +++++++++++++++++++++++++++++++++----------
>  mm/vmalloc.h          |  6 +++--
>  5 files changed, 72 insertions(+), 28 deletions(-)
>
> diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
> index 7da9fd506b39..0016c032d1e7 100644
> --- a/include/linux/kmsan.h
> +++ b/include/linux/kmsan.h
> @@ -150,11 +150,14 @@ int __must_check kmsan_vmap_pages_range_noflush(uns=
igned long start,
>   * kmsan_vunmap_kernel_range_noflush() - Notify KMSAN about a vunmap.
>   * @start: start of vunmapped range.
>   * @end:   end of vunmapped range.
> + * @can_resched: whether the unmap walk may call cond_resched(); pass
> + * false from atomic context.
>   *
>   * KMSAN unmaps the contiguous metadata ranges created by
>   * kmsan_map_kernel_range_noflush().
>   */
> -void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end);
> +void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end,
> +                               bool can_resched);
>
>  /**
>   * kmsan_ioremap_page_range() - Notify KMSAN about a ioremap_page_range(=
) call.
> @@ -355,7 +358,8 @@ static inline int __must_check kmsan_vmap_pages_range=
_noflush(
>  }
>
>  static inline void kmsan_vunmap_range_noflush(unsigned long start,
> -                                             unsigned long end)
> +                                             unsigned long end,
> +                                             bool can_resched)
>  {
>  }
>
> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> index 107f66841274..0cd1edaa1120 100644
> --- a/mm/kmsan/hooks.c
> +++ b/mm/kmsan/hooks.c
> @@ -136,13 +136,16 @@ static unsigned long vmalloc_origin(unsigned long a=
ddr)
>                                                  KMSAN_META_ORIGIN);
>  }
>
> -void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end)
> +void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end,
> +                               bool can_resched)
>  {
>         if (!kmsan_enabled)
>                 return;
>
> -       __vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end)=
);
> -       __vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end)=
);
> +       __vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end)=
,
> +                              can_resched);
> +       __vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end)=
,
> +                              can_resched);
>         flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
>         flush_cache_vmap(vmalloc_origin(start), vmalloc_origin(end));
>  }
> @@ -171,8 +174,9 @@ static void kmsan_iounmap_pages(unsigned long start, =
unsigned long end)
>                 if (origin)
>                         __free_pages(origin, KMSAN_IOREMAP_META_ORDER);
>         }
> -       __vunmap_range_noflush(shadow_start, shadow_end);
> -       __vunmap_range_noflush(origin_start, origin_end);
> +       /* ioremap metadata mappings are always GFP_KERNEL, so resched is=
 safe. */
> +       __vunmap_range_noflush(shadow_start, shadow_end, true);
> +       __vunmap_range_noflush(origin_start, origin_end, true);
>         flush_tlb_kernel_range(shadow_start, shadow_end);
>         flush_tlb_kernel_range(origin_start, origin_end);
>  }
> @@ -207,7 +211,7 @@ int kmsan_ioremap_page_range(unsigned long start, uns=
igned long end,
>                 mapped =3D __vmap_pages_range_noflush(
>                         vmalloc_shadow(start + off),
>                         vmalloc_shadow(start + off + PAGE_SIZE), prot, &s=
hadow,
> -                       PAGE_SHIFT);
> +                       PAGE_SHIFT, gfp_mask);
>                 if (mapped) {
>                         err =3D mapped;
>                         goto ret;
> @@ -217,7 +221,7 @@ int kmsan_ioremap_page_range(unsigned long start, uns=
igned long end,
>                 mapped =3D __vmap_pages_range_noflush(
>                         vmalloc_origin(start + off),
>                         vmalloc_origin(start + off + PAGE_SIZE), prot, &o=
rigin,
> -                       PAGE_SHIFT);
> +                       PAGE_SHIFT, gfp_mask);
>                 if (mapped) {
>                         err =3D mapped;
>                         goto ret;
> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
> index 2166086d3dc3..452760a333e4 100644
> --- a/mm/kmsan/shadow.c
> +++ b/mm/kmsan/shadow.c
> @@ -247,7 +247,7 @@ int kmsan_vmap_pages_range_noflush(unsigned long star=
t, unsigned long end,
>         origin_end =3D vmalloc_meta((void *)end, KMSAN_META_ORIGIN);
>         kmsan_enter_runtime();
>         mapped =3D __vmap_pages_range_noflush(shadow_start, shadow_end, p=
rot,
> -                                           s_pages, page_shift);
> +                                           s_pages, page_shift, gfp_mask=
);
>         kmsan_leave_runtime();
>         if (mapped) {
>                 err =3D mapped;
> @@ -255,12 +255,13 @@ int kmsan_vmap_pages_range_noflush(unsigned long st=
art, unsigned long end,
>         }
>         kmsan_enter_runtime();
>         mapped =3D __vmap_pages_range_noflush(origin_start, origin_end, p=
rot,
> -                                           o_pages, page_shift);
> +                                           o_pages, page_shift, gfp_mask=
);
>         kmsan_leave_runtime();
>         if (mapped) {
>                 /* Undo the shadow mapping set up above. */
>                 kmsan_enter_runtime();
> -               __vunmap_range_noflush(shadow_start, shadow_end);
> +               __vunmap_range_noflush(shadow_start, shadow_end,
> +                                      gfpflags_allow_blocking(gfp_mask))=
;
>                 kmsan_leave_runtime();
>                 err =3D mapped;
>                 goto ret;
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 3f98056f8c7e..d1986f68eab4 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -372,8 +372,12 @@ int vmap_page_range(unsigned long addr, unsigned lon=
g end,
>         if (!err)
>                 err =3D kmsan_ioremap_page_range(addr, end, phys_addr, pr=
ot,
>                                                ioremap_max_page_shift);
> -       if (!err)
> +       if (err) {
> +               /* Callers are ioremap and arch setup code, always sleepa=
ble. */
> +               __vunmap_range_noflush(addr, end, true);
> +       } else {
>                 flush_cache_vmap(addr, end);
> +       }
>
>         return err;
>  }
> @@ -429,7 +433,7 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned lon=
g addr, unsigned long end,
>  }
>
>  static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned lo=
ng end,
> -                            pgtbl_mod_mask *mask)
> +                            pgtbl_mod_mask *mask, bool can_resched)
>  {
>         pmd_t *pmd;
>         unsigned long next;
> @@ -451,12 +455,14 @@ static void vunmap_pmd_range(pud_t *pud, unsigned l=
ong addr, unsigned long end,
>                         continue;
>                 vunmap_pte_range(pmd, addr, next, mask);
>
> -               cond_resched();
> +               /* The undo path may run in atomic context. */
> +               if (can_resched)
> +                       cond_resched();
>         } while (pmd++, addr =3D next, addr !=3D end);
>  }
>
>  static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned lo=
ng end,
> -                            pgtbl_mod_mask *mask)
> +                            pgtbl_mod_mask *mask, bool can_resched)
>  {
>         pud_t *pud;
>         unsigned long next;
> @@ -476,12 +482,12 @@ static void vunmap_pud_range(p4d_t *p4d, unsigned l=
ong addr, unsigned long end,
>                 }
>                 if (pud_none_or_clear_bad(pud))
>                         continue;
> -               vunmap_pmd_range(pud, addr, next, mask);
> +               vunmap_pmd_range(pud, addr, next, mask, can_resched);
>         } while (pud++, addr =3D next, addr !=3D end);
>  }
>
>  static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned lo=
ng end,
> -                            pgtbl_mod_mask *mask)
> +                            pgtbl_mod_mask *mask, bool can_resched)
>  {
>         p4d_t *p4d;
>         unsigned long next;
> @@ -496,7 +502,7 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned lon=
g addr, unsigned long end,
>
>                 if (p4d_none_or_clear_bad(p4d))
>                         continue;
> -               vunmap_pud_range(p4d, addr, next, mask);
> +               vunmap_pud_range(p4d, addr, next, mask, can_resched);
>         } while (p4d++, addr =3D next, addr !=3D end);
>  }
>
> @@ -512,7 +518,8 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned lon=
g addr, unsigned long end,
>   *
>   * This is an internal function only. Do not use outside mm/.
>   */
> -void __vunmap_range_noflush(unsigned long start, unsigned long end)
> +void __vunmap_range_noflush(unsigned long start, unsigned long end,
> +                           bool can_resched)
>  {
>         unsigned long next;
>         pgd_t *pgd;
> @@ -529,7 +536,7 @@ void __vunmap_range_noflush(unsigned long start, unsi=
gned long end)
>                         mask |=3D PGTBL_PGD_MODIFIED;
>                 if (pgd_none_or_clear_bad(pgd))
>                         continue;
> -               vunmap_p4d_range(pgd, addr, next, &mask);
> +               vunmap_p4d_range(pgd, addr, next, &mask, can_resched);
>         } while (pgd++, addr =3D next, addr !=3D end);
>
>         if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
> @@ -538,8 +545,9 @@ void __vunmap_range_noflush(unsigned long start, unsi=
gned long end)
>
>  void vunmap_range_noflush(unsigned long start, unsigned long end)
>  {
> -       kmsan_vunmap_range_noflush(start, end);
> -       __vunmap_range_noflush(start, end);
> +       /* The unmap paths are sleepable, keep the resched point. */
> +       kmsan_vunmap_range_noflush(start, end, true);
> +       __vunmap_range_noflush(start, end, true);
>  }
>
>  /**
> @@ -727,18 +735,32 @@ static int vmap_pages_range_noflush_walk(unsigned l=
ong addr, unsigned long end,
>   * The caller is responsible for calling flush_cache_vmap() after this
>   * function returns successfully and before the addresses are accessed.
>   *
> + * On failure the mapping is torn down before returning, so a retry
> + * sees a clean range. When @gfp_mask cannot block, the teardown
> + * skips cond_resched(), it may run in atomic context.
> + *
>   * This is an internal function only. Do not use outside mm/.
>   */
>  int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> -               pgprot_t prot, struct page **pages, unsigned int page_shi=
ft)
> +               pgprot_t prot, struct page **pages, unsigned int page_shi=
ft,
> +               gfp_t gfp_mask)
>  {
> +       int err;
> +
>         if (WARN_ON_ONCE(page_shift < PAGE_SHIFT))
>                 return -EINVAL;
>
>         if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC))
>                 page_shift =3D PAGE_SHIFT;
>
> -       return vmap_pages_range_noflush_walk(addr, end, prot, pages, page=
_shift);
> +       err =3D vmap_pages_range_noflush_walk(addr, end, prot, pages, pag=
e_shift);
> +
> +       /* Undo the PTEs installed before the failure. */
> +       if (err)
> +               __vunmap_range_noflush(addr, end,
> +                                      gfpflags_allow_blocking(gfp_mask))=
;

I remember we discussed this before that __vunmap_range_noflush() will
be unmapping the entire range between addr and end instead of the
range vmap_pages_range_noflush_walk() actially mapped and your reply
was that this keeps things simple and avoids adding extra code in the
common path when we do not fail. This was bothering me, so I looked a
bit deeper and I think there is an issue with this approach.
vmap_pages_pte_range() fails with -EBUSY if it encounters an already
installed PTE. So, if this happens, we immediately bail out of mapping
the range and will be unmapping the entire range, including these
existing PTEs. I don't think that's ok.

A fix might be quite simple. vmap_pages_range_noflush_walk() already
counts how many pages we processed in nr variable. If we propagate
that one level up then we could unmap only the range we actually
mapped.

> +
> +       return err;
>  }
>
>  int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> @@ -750,7 +772,18 @@ int vmap_pages_range_noflush(unsigned long addr, uns=
igned long end,
>
>         if (ret)
>                 return ret;
> -       return __vmap_pages_range_noflush(addr, end, prot, pages, page_sh=
ift);
> +
> +       ret =3D __vmap_pages_range_noflush(addr, end, prot, pages, page_s=
hift,
> +                                        gfp_mask);
> +       /*
> +        * The page tables undo themselves on failure. Tear down the
> +        * metadata that was fully set up before the mapping failed.
> +        */
> +       if (ret)
> +               kmsan_vunmap_range_noflush(addr, end,
> +                                          gfpflags_allow_blocking(gfp_ma=
sk));
> +
> +       return ret;
>  }
>
>  static int __vmap_pages_range(unsigned long addr, unsigned long end,
> diff --git a/mm/vmalloc.h b/mm/vmalloc.h
> index d8372a4f65c4..9ea28845f713 100644
> --- a/mm/vmalloc.h
> +++ b/mm/vmalloc.h
> @@ -40,10 +40,12 @@ void clear_vm_uninitialized_flag(struct vm_struct *vm=
);
>
>  int __must_check __vmap_pages_range_noflush(unsigned long addr,
>                 unsigned long end, pgprot_t prot,
> -               struct page **pages, unsigned int page_shift);
> +               struct page **pages, unsigned int page_shift,
> +               gfp_t gfp_mask);
>
>  void vunmap_range_noflush(unsigned long start, unsigned long end);
>
> -void __vunmap_range_noflush(unsigned long start, unsigned long end);
> +void __vunmap_range_noflush(unsigned long start, unsigned long end,
> +                           bool can_resched);
>
>  #endif /* __MM_VMALLOC_H */
> --
> 2.25.1
>

