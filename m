Return-Path: <linuxppc-dev+bounces-29358-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870F6CC6B03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 11:23:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3sQq18PVz3brc;
	Tue, 13 Oct 2026 22:23:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791890611;
	cv=pass; b=A4v5uaF2UsuwNDIL6s8syholONy3Txu5y5mbysGjctLF8vrAq4+DpB9ra8bpmWf/H/0UjwNgAtlI6yx7kgWVBQQzi82vD5BqQqU6htkK5uAYsNAceO8gqVbkuRP3pGQ3WpFfkH5GqWZMRm82eTgMoBDdSPwdDgD4d7jIZkpX81M5XqdbOTpcn+cpGoKFf+6a+l9Y6PL81VWkMzL9OTkVxd95z48GXbAO9keFN5A/LjNLI83Nl4vnHJ5D6OMzbOt+nZld5jYxnpPBEWywVwA8z+5W6biqu6kfHq4j6GOpVz+vjALsRpfwORVWoy74fjVbL98WEz9H2xg8ATkyxy0OAg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791890611; c=relaxed/relaxed;
	bh=lglLC9+yE+tZ+AHV0VONJs0/vCldZdYwmVgqh0e7e90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZE9xpW8qhX3c27DryI0VrjjgkmG30S6enZl9ZgFGBcGi7eFy5kMNA5CEMzRw0AvYRnLHOEKh5wKFfjnbHJ74jaY6q20MiM98b/EzqPFoHsqaKd8gLtDin6ASP0A6lg05dlxLNAMRNeJoxxizWDRXHFAG0tUgvapWAPypN0Ze16qQt7E+B0kv570JqpBwetvhLhPUznQ21KAQMpgbvnjOi2vlUE0cHZ3qkw0wm3Iw7J0oOl33FjCeAwAnhJXLST1iXYyXXhwuttzxFSe0y4fscg7ge4xPjy6BUMG4otF7n+XOTaIU5imdTPfaaRyCWBJe6lZYFi0DBkbfz8XBVLe8Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=M7yBiXjf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=M7yBiXjf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3sQp1Cq7z3br2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 22:23:30 +1100 (AEDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-533202fe429so700371cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 04:23:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791890607; cv=none;
        d=google.com; s=arc-20260327;
        b=g2D0c9sbTXS0G0sqb/MpFEZiiYBtnnkXo2gDo4oSLGRcHDqTEode+NHPdyLJC1obzJ
         nDe1mcE2RrphvLVNpwyMZNsxAgE3H9/J89IRvc5TwmZ6IU/PE+nckdQOTrkEEu6rv650
         xb6DebpuY4HUup7XPNzHi1JYGqByZcmNM0hWti6kd0910yWQfPKKUFhuMOWxRKp7Lv4j
         WZOgFDxRVJjChvag/uDB0PvsoUwGHXupmE3GWeqO0xsj6oKZSCkrwqAvU3tJIfvbGSPn
         5mWLoZY4X90tI5GO2gNU4miHq/JUec6V2aILbaOuiQ9DHZZaudi90IKnrqrxCCjHhPon
         0/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lglLC9+yE+tZ+AHV0VONJs0/vCldZdYwmVgqh0e7e90=;
        fh=eK8a5Yp1hy0gVG9uKqnwcg32I9ZFtDOvsQ7Ce7eMkz0=;
        b=nA/Azl9DG8Y+F9alyRfg/k77mqjoARHb/m4a7MRj0Ci2AvSXhmYgAkJ0jCk43k6YdE
         rF2/JCRKnLCaBQc8SN55wdOSndefmJssUiRWXgdW0CKuX7Kxb04HEatBOGDJw+Khga8r
         UO9QfpkV1qqeqkfrGPI9sMSp1mQBn2peA+2RhjOx713hziGhRZKS0Umote9uohqpaNz8
         rGUoRtg+VVtGcJCfVEGW5BJKX9W3YM3N4isTCEhOeh8QqB5LYBIEJgax8mU4CiXUBJ0U
         VApJNBqoCZ/b1xO589YDdFPzBKtUVm1jNEo8qV6T5HlrWC7FDi/b0gCsLZ7850SsuJCI
         FMOw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791890607; x=1792495407; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lglLC9+yE+tZ+AHV0VONJs0/vCldZdYwmVgqh0e7e90=;
        b=M7yBiXjfLJ9WXwNFDAs8OkP0xtFW7MQkRHskLGCks3wEXaR2riXvj/TP9V4Ys+TuZv
         EfzJ3SslJtC32924zFodiMDGWIP70Z/1LRxA8oqjnhV1lgrPne1aNFqaNetzeJ37N/BD
         8Aw2n/hU1Lvv1P1p+fb+NbBrfp9lvdtBNiIG9H3U2PxXecx3yk0q5nuPWv6KHMZEqgCW
         eiK7yTAEVR9gBpQLRaPHfo6cjbMsY1N2t2+SmWgkmY4cDf/uN6UoXfsZMU8enDLucAtV
         fIvaYQ1qJFHloID0jMiaqFFrlfWJAbFDEIBrCvOAbarRl+lyLQxH/vdhMNzu+JsIqMcM
         07Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791890607; x=1792495407;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lglLC9+yE+tZ+AHV0VONJs0/vCldZdYwmVgqh0e7e90=;
        b=fB2eZciVzktuVkvu40V5VSzvnbOESbtVfTCUfr2h28IKxhbGNV/u3crbCc6eYGSUVH
         MZZ7pMgUsg6yL68ct7aNPMBuVJPuF/5w6nWLBtKAMUmtFh+ovaBdK97A8xLiWxwD35CL
         4Zi3+O+N/CAHgwYWA4Xj6RIsQInHViKvpVO6c9oXPh+SrAboBx7aO2d1eQMXAQcw+EkH
         juAVY85iLpXzGL5HbUFbXJtc0bismVjnD3U/upQ/JKUtQQZ+vhyWcrwIiE006rHfAG/O
         Vy/nmbIMuoxkHNOy9hu1Sok/DK0QHGFmlmQtTyiWyqBPmSYcsjahPJJZaKqo3P4P6HeI
         5Rhw==
X-Forwarded-Encrypted: i=1; AKwUvBxYWQzFBT1q+f534V8SRudEdcYH9lCxHaZN1CxrQKK47MO5vS9YDfD0NJq0wzWreQxTaxdh/nfLhbVmd0E=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIa24Uh1s7Fct+hxVeeoJF2Yo0wwZwNf5nrB36vCmnZrzO92WzC
	HTF9KkbUdbwQAhOAxCv3QBc5D7y7kV4yUYePSSTWFkUi/NwKSaZpqVvuWLgvdy4DarhR/t1fi6U
	OdlQ0r8Yla/RnGKtGh3AfV2lGjaV7x4H5kFECIUOI
X-Gm-Gg: AYBFou3GlpE5Y/E6wwPqdz59l3SUWoX8pJC1Pon9Zkq1tDGHXVPZIz5wc/XVXKzC/Cc
	E24z3DjcmwT4RYl73maTSHRuL0qoeDywJrhmIqCKodEjaHwgYRRW3UMbaltDVOT/1/kbJdP+Bi5
	F4va49iVeLpotszRi+j3Av1ULE16L+OPy2XP/4+0WFF5NPCx4HdgUSIPpm1U57l0LuFwMhvWFdw
	QCuFTONbmIDCZ5+60WYZjRpKKXilQwd6XhBjnk0qoAWU5GOrrFmHpAePCzFrw1e98Cc3sk1mghT
	ZFvXaGHNI6aMVVAYnJDT/vZBNy4ui2TXePQFVVPxsIAO59C1uMo9O/5S
X-Received: by 2002:a05:622a:180d:b0:531:34b9:2532 with SMTP id
 d75a77b69052e-535b320372fmr48865141cf.4.1791890605760; Tue, 13 Oct 2026
 04:23:25 -0700 (PDT)
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
References: <20261009063619.112313-1-hao.ge@linux.dev> <20261009063619.112313-3-hao.ge@linux.dev>
In-Reply-To: <20261009063619.112313-3-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Oct 2026 15:23:14 +0400
X-Gm-Features: AclHuK-YS0X8RHvN1DiVTwo6aWWizXGsTLGePiTKV5Kwl9ajh5-w8CnH9PG_B2Y
Message-ID: <CAJuCfpE9VfgTw2ZNMJTEVh41H_R+1RY_MtzeMuZNCD3BFm-Piw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] mm/vmalloc: undo partial mappings inside the
 mapping functions
To: Hao Ge <hao.ge@linux.dev>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Uladzislau Rezki <urezki@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 10:36=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> __vmap_pages_range_noflush() and friends can install some PTEs before
> failing and leave them mapped, and the kernel callers do not agree on
> who cleans them up. pcpu_map_pages() and kmsan_ioremap_page_range()
> roll back what they mapped before the failure, while
> vm_module_tags_populate() and the __GFP_NOFAIL retry loop in
> __vmalloc_area_node() rely on the mapping functions cleaning up and
> do not call anything like vunmap_range() themselves. When the same
> range is mapped again, the attempt hits the leftovers and fails, with
> a BUG() in vmap_pte_range() for huge mappings and a warning on the
> small-page path.
>
> After discussing with Suren and Ulad, we decided to put the rollback
> into the entry points of the vmap API rather than into every low-level
> helper. __vmap_pages_range_noflush() undoes the whole range it was
> asked to map when it fails, and vmap_page_range() undoes its range
> for the ioremap-style mappings.
>
> The rollback is __vunmap_range_noflush(), it only clears the PTEs,
> no TLB flush, nothing has touched these mappings.
> vmap_pages_range_noflush() drops the KMSAN metadata when the data
> mapping fails, and an empty range bails out with -EINVAL now, which
> used to BUG_ON() on the small-page path and map nothing at all on
> the huge-page one.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Suggested-by: Uladyslau Rezki <urezki@gmail.com>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/vmalloc.c | 44 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 12 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index db669103dc66..e1b376f57dd2 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -363,6 +363,9 @@ int vmap_page_range(unsigned long addr, unsigned long=
 end,
>         if (!err)
>                 err =3D kmsan_ioremap_page_range(addr, end, phys_addr, pr=
ot,
>                                                ioremap_max_page_shift);
> +       if (err)
> +               __vunmap_range_noflush(addr, end);
> +
>         return err;
>  }
>
> @@ -683,27 +686,35 @@ int __vmap_pages_range_noflush(unsigned long addr, =
unsigned long end,
>                 pgprot_t prot, struct page **pages, unsigned int page_shi=
ft)
>  {
>         unsigned int i, nr =3D (end - addr) >> PAGE_SHIFT;
> +       unsigned long start =3D addr;
> +       int err =3D 0;
> +
> +       if (WARN_ON_ONCE(addr >=3D end))
> +               return -EINVAL;
>
>         if (WARN_ON_ONCE(page_shift < PAGE_SHIFT))
>                 return -EINVAL;
>
>         if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
> -                       page_shift =3D=3D PAGE_SHIFT)
> -               return vmap_small_pages_range_noflush(addr, end, prot, pa=
ges);
> -
> -       for (i =3D 0; i < nr; i +=3D 1U << (page_shift - PAGE_SHIFT)) {
> -               int err;
> -
> -               err =3D vmap_range_noflush(addr, addr + (1UL << page_shif=
t),
> +                       page_shift =3D=3D PAGE_SHIFT) {
> +               err =3D vmap_small_pages_range_noflush(addr, end, prot, p=
ages);
> +       } else {
> +               for (i =3D 0; i < nr; i +=3D 1U << (page_shift - PAGE_SHI=
FT)) {
> +                       err =3D vmap_range_noflush(addr, addr + (1UL << p=
age_shift),
>                                         page_to_phys(pages[i]), prot,
>                                         page_shift);
> -               if (err)
> -                       return err;
> +                       if (err)
> +                               break;
>
> -               addr +=3D 1UL << page_shift;
> +                       addr +=3D 1UL << page_shift;
> +               }
>         }
>
> -       return 0;
> +       /* Undo the PTEs installed before the failure. */
> +       if (err)
> +               __vunmap_range_noflush(start, end);

Would it be too complicated to track how much was actually mapped and
unmap only that portion?


> +
> +       return err;
>  }
>
>  int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> @@ -715,7 +726,16 @@ int vmap_pages_range_noflush(unsigned long addr, uns=
igned long end,
>
>         if (ret)
>                 return ret;
> -       return __vmap_pages_range_noflush(addr, end, prot, pages, page_sh=
ift);
> +
> +       ret =3D __vmap_pages_range_noflush(addr, end, prot, pages, page_s=
hift);
> +       /*
> +        * The page tables undo themselves on failure. Tear down the
> +        * metadata that was fully set up before the mapping failed.
> +        */
> +       if (ret)
> +               kmsan_vunmap_range_noflush(addr, end);
> +
> +       return ret;
>  }
>
>  static int __vmap_pages_range(unsigned long addr, unsigned long end,
> --
> 2.25.1
>

