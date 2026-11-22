Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C99606A32A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 03:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kYAEUvkx
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXFg6581dz2xnn;
	Sun, 22 Nov 2026 14:58:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::836" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795319922;
	cv=pass; b=AB4yqytvPubval8pxztIHq3RTN/bsCiUU4OJPQkjBJ0yYW6tLi4WMbv7kv3gI6O2LXxRcEhGpQSz/6QP2q8ROa2KXjquETOujtXgWM85kiQ/TkBrZADiepyxe1T4+ClD1Np/ogzvK55PdxDdwaVgZt4nVB0735+4PeC2k+I04XmDUGec+kDIPqzEDF22H8a4yEo5GXbCrkPP/1G6xemQC3aEHFde4a/mW5/+AFI/ouGMda4wKqVbDhg22kzWuTNSoyZo9JESrffbAC332Zx+r76Zd1blep6E4ZnHhbMewFzuhThHmA69/9KoiEX3/d85+L3OYUISBpXYZxtEeLRC0A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795319922; c=relaxed/relaxed;
	bh=U6lDo04XbaVHnGHBXBgBBEvTruBmRJrwphZdUWl/Gp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFiaVccZUF2078tivjczMsWD2D2wLYBKiz8eQcKg/fG3Vxz7bHrraJhqcciUlrYMCcgzvop8JLEd9M7VU+QyQgJ+BdsGh2cLVPd0AxfKbT3L064RdSmHk998l+/O7bHw0xlnCpIv5aLYzxGqak+lsxCEUl+5jzvKSP7xEqyOxd/DURs7Ijrrr3ySPy1UwF0LeUiqnP95G97W4FlMzCjx+70HYeEXpHDpyxmifoDfOFKCTwmbFX2NJZ/5dkarReoY7difgUoxOFnfNLL1Q/VP9KKETICwgpB5JYZn8IP8ceobchx6MZGrEDz1L12RDJV4hZ1K3W9bsRdAT0uMjpjdvg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kYAEUvkx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::836; helo=mail-qt1-x836.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kYAEUvkx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::836; helo=mail-qt1-x836.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXFg51BmWz2xgv
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 14:58:40 +1100 (AEDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-55c7445cf85so154451cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 19:58:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795319918; cv=none;
        d=google.com; s=arc-20260327;
        b=HnGInRyeZYfr8fD2voWjP0ddEqQuRHHkd+1dljNnNJ4Exz+H4wXv7thHHm6zQrmqb4
         h45nkbksaoI9+/CydTc0d/H/H7FDb8erRcfJFrPR8sxF0a0XoFjG/N1QM0xoI5610H8t
         1PWNUVuRr1d5UKZ+C7FqAwcTB0kW2mP84ErkeqOlh4gSyzg4rqgkR4hyGyCscPH6764p
         gtMGUmQDOiE7fUNzbt/X2wjxkY3Drpu1wCh8/LquiYUwl/Hs0+tNydIZLKW+a7M8n7IM
         tngYa9lMhBuf8FwBItU2HQQo5njboaEeUMTKcPhQs2N9edfa2dsBOnmG1/1WZgpn2Reu
         5lOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U6lDo04XbaVHnGHBXBgBBEvTruBmRJrwphZdUWl/Gp8=;
        fh=GbxsEAQ6CJH5bB31gya4QmQnJQTvuq5v0ttYejYRn2Y=;
        b=Xitol5yYSYDhF2sA2QD5j/y19OHgYslUDE481QaY5kPodCM15mrvnDTN+k7nrlvOpc
         HALIJZ8ZOMr1kXKW32M6F3jIB+cqwMcXccnxtI73lIZNza2lZV22bbkTdmPbfmxVP2xR
         EXxcMqPjSEo99oLqKOa/nmzZiFEZ+tnROlH1Vg4MUCHhh8Qyeh8+5LjXemq7Xhc+1/CN
         0kG5lINAHpcOs2ru5E6cYWiC9WmzSQM/qCYQoeX+PGVCby6zSvna8tjTXMdwCRTibjPW
         9qESSvFxz5sWuC0AnUUZtsrqMsAWaD/XMKTAmCer2AgHryerhk/8OhpVfJjmF5pILHyo
         rofg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795319918; x=1795924718; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U6lDo04XbaVHnGHBXBgBBEvTruBmRJrwphZdUWl/Gp8=;
        b=kYAEUvkxufDWMqE1gDvLDXvEuKdLnEqmrp8sp3jpFAZYu0wL81WlLp1zt5TA0XOFvW
         qdFtQ33CMD48SkpqNlk4HXdLny5CdYsmH2xKlvtFc9tVsjCA/VUfboMBJPd1eAZHXFc8
         fnoiWh7CPoOM9T3qDfgKcBXrVmkKR0D1PUKGwDdiGzR8Fkry/JDvSBq+tcq6kdwsT+vr
         QwGJKAHEhBVb0XMnFAe9dlJMRpX1l/FruizfQToutjPiKZkB4bUVBVLh1IP+djI9TFF3
         U46aaUo2vAzdjRZKbZfyBtObEWBagBPYwTwRASyyj/T+vaUpj09ynKjn61+n7RGPslXT
         vXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795319918; x=1795924718;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U6lDo04XbaVHnGHBXBgBBEvTruBmRJrwphZdUWl/Gp8=;
        b=KVqFSwDR07ZrTUTmDzayx25NkTT06bl8TJ71p7pjkM3F4BOKP5Au9t4e3MeKaJmPFK
         kXvQjB1c8jn9OdipU79Jk44kU1LtMH1ECKKv1Y6HzLEL02gpm0vgiHz6J38Er0Ogl9TC
         HGMDJMl7y3t8wEizwDnCZsKFPVvpB8T3KskeJwGI0PQ2RNh40+4/4PdKy4iUPPP10GGf
         bjDT65XlMU+xyGnNliRGlO6ubUjSe61zGhG71ClFa8I7cDjNMPzGYh+SpsM7H34/KQC0
         bHyFhtV0EZ22yiv4jVJmAzpuYgAIvryhFzEzLPxMaZGNWTY8GZsLMj2GTr3fwMnMiD9C
         0fvA==
X-Forwarded-Encrypted: i=1; AL+hErHNwNw8JO0ckQ0uxkaG+bcNjXfttMe/aQG8JHv+sHMeBaD7dNFMruy30H+SJ3T1FJu08v4mCXQ45ptehj8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9RZaV9XzYXafbispBvKmwNYZOE4snd6fBe++fLAr4l8FPzZadi
	XWbrNBhNbEhNXTFd7VobKEQLPU7jhUrDhCFRKkaWA6gxtxBe3pR7mS94gNEvBrsIQaFsvFP1Z2e
	9K8a6qvQ0UJ+opXPgtIWPQcdzM90sF+C6w1EkpUbl
X-Gm-Gg: AZFdTZepSe2XhWltb4Zo3/NHJlGbhfpOuI1ojp6QemT5Uw7KB7/UWpWHRxy+0WZRQ7e
	XnnKpS3UFw6X5JgHSDvIPrprUXp/Zz0OYJ20rBtd1oA0LVVbIh4+Psplu3oy27gScYEZJ93WERx
	hlreKhqa2rmTa0a1PCO/J7Zp5mpUIhdiHUkt6OvH5+BZMeX49YtkBmBcnEePuNQJli1eBKpqaEm
	/V9l4EZuTzSg5K1au205Tmw891Tvo2bb5RRWW5GBtTWdNtY0qUwc0OVtT0KLGXgzU37ajKnhk4H
	ezC+c3Oy7R2aG7LQ3FJ9XGznunFO1ldWWcjWveXqOUf4hrdTaxJNES1Du7cvYyYWyapv576oUjP
	zg+hxnR1XgyfZtxCRdx8CHJ0wgadlems0M/RT21AJmbTkbe+0e0VpDEpF24DkRSg9dElfpk0=
X-Received: by 2002:a05:622a:4010:b0:532:9220:a9ae with SMTP id
 d75a77b69052e-55d8818abdbmr18248231cf.6.1795319917430; Sat, 21 Nov 2026
 19:58:37 -0800 (PST)
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
References: <20261116071325.263682-1-hao.ge@linux.dev> <20261116071325.263682-8-hao.ge@linux.dev>
In-Reply-To: <20261116071325.263682-8-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 21 Nov 2026 19:58:26 -0800
X-Gm-Features: Aa3M54oUVu1y1QdsMhiWrEo5U1kKt_0hi7a4znXOHdNoNhlvmsvMEXTR-bBBo9A
Message-ID: <CAJuCfpFvA5oqop2tovy33fKydx7n8Sm=X-hE0sJxpcR1gg5hMA@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] mm/vmalloc: undo what __vmap_pages_range_noflush()
 mapped on failure
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
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 11:14=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> __vmap_pages_range_noflush() maps a struct page array and may fail
> half way. The ptes installed so far stay behind, so a retry of the
> same range, the __GFP_NOFAIL loop in __vmalloc_area_node() or the
> module tags populate, trips the WARN_ON(!pte_none()) in
> vmap_pages_pte_range() and fails with -EBUSY.
>
> vmap_pages_range_noflush_walk() now reports how many pages it
> installed through its running index into the pages array, and
> __vmap_pages_range_noflush() undoes [addr, addr + mapped_pages *
> PAGE_SIZE) on failure. vmap_pages_pte_range() fails with -EBUSY
> instead of installing over a pte that is already set, so the ptes
> below that point are all ours, while a pte above it can only have
> been put there by somebody else, for example when the caller's range
> overlaps an existing mapping. Going further would clear ptes that
> are not ours.
>
> This path can run with a non-blocking gfp mask, the undo passes
> gfpflags_allow_blocking() as can_resched.
>
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Suggested-by: Uladzislau Rezki <urezki@gmail.com>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/kmsan/hooks.c  |  4 ++--
>  mm/kmsan/shadow.c |  4 ++--
>  mm/vmalloc.c      | 36 +++++++++++++++++++++++++++++-------
>  mm/vmalloc.h      |  3 ++-
>  4 files changed, 35 insertions(+), 12 deletions(-)
>
> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> index 69008b085658..d830a4e649f1 100644
> --- a/mm/kmsan/hooks.c
> +++ b/mm/kmsan/hooks.c
> @@ -208,7 +208,7 @@ int kmsan_ioremap_page_range(unsigned long start, uns=
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
> @@ -218,7 +218,7 @@ int kmsan_ioremap_page_range(unsigned long start, uns=
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
> index 212449db34a1..452760a333e4 100644
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
> @@ -255,7 +255,7 @@ int kmsan_vmap_pages_range_noflush(unsigned long star=
t, unsigned long end,
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
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 5c1eacc2a0ac..4f3c320a4849 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -725,7 +725,8 @@ static int vmap_pages_p4d_range(pgd_t *pgd, unsigned =
long addr,
>   * may have contiguous chunks, as hinted by @shift.
>   */
>  static int vmap_pages_range_noflush_walk(unsigned long addr, unsigned lo=
ng end,
> -               pgprot_t prot, struct page **pages, unsigned int shift)
> +               pgprot_t prot, struct page **pages, unsigned int shift,
> +               unsigned int *mapped_pages)
>  {
>         unsigned long start =3D addr;
>         pgd_t *pgd;
> @@ -748,6 +749,7 @@ static int vmap_pages_range_noflush_walk(unsigned lon=
g addr, unsigned long end,
>         if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
>                 arch_sync_kernel_mappings(start, end);
>
> +       *mapped_pages =3D nr;
>         return err;
>  }
>
> @@ -758,18 +760,36 @@ static int vmap_pages_range_noflush_walk(unsigned l=
ong addr, unsigned long end,
>   * The caller is responsible for calling flush_cache_vmap() after this
>   * function returns successfully and before the addresses are accessed.
>   *
> + * On failure the PTEs installed by this call are torn down before
> + * returning, so a retry sees a clean range; PTEs that were already
> + * there when the walk failed are left alone. When @gfp_mask cannot
> + * block, the teardown skips cond_resched(), it may run in atomic
> + * context.
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
> +       unsigned int mapped_pages =3D 0;
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
e_shift,
> +                                           &mapped_pages);
> +
> +       /* Undo the PTEs installed before the failure. */
> +       if (err && mapped_pages)
> +               __vunmap_range_noflush(addr, addr + (mapped_pages * PAGE_=
SIZE),
> +                                      gfpflags_allow_blocking(gfp_mask))=
;
> +
> +       return err;
>  }
>
>  int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> @@ -781,7 +801,8 @@ int vmap_pages_range_noflush(unsigned long addr, unsi=
gned long end,
>
>         if (ret)
>                 return ret;
> -       return __vmap_pages_range_noflush(addr, end, prot, pages, page_sh=
ift);
> +       return __vmap_pages_range_noflush(addr, end, prot, pages, page_sh=
ift,
> +                                         gfp_mask);
>  }
>
>  static int __vmap_pages_range(unsigned long addr, unsigned long end,
> @@ -3715,7 +3736,7 @@ static int vmap_pages_range_batched(unsigned long a=
ddr, unsigned long end,
>                 pgprot_t prot, struct page **pages)
>  {
>         const unsigned int nr_pages =3D (end - addr) >> PAGE_SHIFT;
> -       unsigned int prev_shift =3D 0, batch_idx =3D 0;
> +       unsigned int prev_shift =3D 0, batch_idx =3D 0, nr_mapped;
>         unsigned long batch_start =3D addr, batch_end =3D addr;
>         int err;
>
> @@ -3734,7 +3755,8 @@ static int vmap_pages_range_batched(unsigned long a=
ddr, unsigned long end,
>
>                 if (shift !=3D prev_shift) {
>                         err =3D vmap_pages_range_noflush_walk(batch_start=
, batch_end,
> -                                       prot, pages + batch_idx, prev_shi=
ft);
> +                                       prot, pages + batch_idx, prev_shi=
ft,
> +                                       &nr_mapped);
>                         if (err)
>                                 goto out;
>                         prev_shift =3D shift;
> @@ -3756,7 +3778,7 @@ static int vmap_pages_range_batched(unsigned long a=
ddr, unsigned long end,
>         /* Remaining */
>         if (batch_start < end)
>                 err =3D vmap_pages_range_noflush_walk(batch_start, end, p=
rot,
> -                               pages + batch_idx, prev_shift);
> +                               pages + batch_idx, prev_shift, &nr_mapped=
);
>
>  out:
>         if (!err)

So, you are recording nr_mapped but not undoing
vmap_pages_range_batched() partial mappings yet. You do that in patch
#9. It's weird to fix one place but leave the other one until later. I
would suggest merging patches 7 and 9 to have a complete fix.

> diff --git a/mm/vmalloc.h b/mm/vmalloc.h
> index 4ec114a75f04..9ea28845f713 100644
> --- a/mm/vmalloc.h
> +++ b/mm/vmalloc.h
> @@ -40,7 +40,8 @@ void clear_vm_uninitialized_flag(struct vm_struct *vm);
>
>  int __must_check __vmap_pages_range_noflush(unsigned long addr,
>                 unsigned long end, pgprot_t prot,
> -               struct page **pages, unsigned int page_shift);
> +               struct page **pages, unsigned int page_shift,
> +               gfp_t gfp_mask);
>
>  void vunmap_range_noflush(unsigned long start, unsigned long end);
>
> --
> 2.25.1
>

