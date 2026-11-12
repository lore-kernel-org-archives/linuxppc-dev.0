Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B32606A337
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 00:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PmJkfRtO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQ1X95n2nz308H;
	Thu, 12 Nov 2026 11:31:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794443465;
	cv=pass; b=YFHWyILoD9RD+/ledMhKIGBPUIDa/5K6mYJECORMLkX9YRK/ELb2/azG3YSYDZXh73Bx2aNyk2XWmcf2PeDE1lUVDsA6a3k6aasvVxYn9PXfpHqXIqwseVpfOCyeAgkz7oGaMZIWdyWBRwnTdCgxJsQGQHkX9DLmV4a9A9KOXP3FQeUF9L9Q4KgYgX4wI27vBvFWDs5m+u8csgtJkGoT19I242j4u/diZxOYdPx22ZJYbyBUHHYVQKtVP5QS71J7nDiQV1OCv1SHGsUDmW/mcrV9dLPv2cuH1fyxez8ykSkgPjCJkGQ70DmTSNGs6FdZ3W78Gzj4B2FoWTEI3G0M8w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794443465; c=relaxed/relaxed;
	bh=6u9+23TRytDuYgPE46LNdROZdeRwOWR2OfnIkWa60H4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKS48135O9q8nlEl5hjGcv5IENOCUOg/7SxYT9RRxvt/7wZB6lo3D46fmVZG3DxF5JO/1Eo4LNcH/42bz4fbW2eiG39PEkJnAuvRpHx6W6+IJx/WDcQy4ZQtQ851NYI2xBErpG/iZsBygbQojmruTQIr9HPRVQFLnEieTiwkfVkDN1CnoCZLGtGBsGq162qFl/CGCn16wzlV/72J+d5GRU2quuizBMZyzFRdct0kduILZqnSUBTyAIQGgiM2bHSN8LOl4PyDeLEJ9Oj4jAsaW3ZBNJjNLvXqQKNrQHIIlWPgCD5puO9dV2gGrrEY21+MgPztk/q548GPnrbRX/tAkA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PmJkfRtO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PmJkfRtO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQ1X856RYz2yqx
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 11:31:04 +1100 (AEDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-54492d8a988so56191cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 16:31:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794443462; cv=none;
        d=google.com; s=arc-20260327;
        b=R+qHtinbNcmDCbjYhld9ob1vQkW9O045r6WivEn1ULbBC/njaAc52VllULrtHSKjpp
         yfXAADvorY3LBJ6+lvTrgdy/K6jqiqRGr/xSLPBPISKe/n148GUmgTlkv6k9qetjpCmA
         +UAA7NICU34Tax8zvUpMg7f//VUivxvzlAREg77G6iC2ahR6T0qcL/mrdmBOFxnMGCCG
         PeuLZxYXwOW57H71YMOKDuJk/OYUKsg/HTp6lR4LnqBoD9vrstyJvJOMU31w7NRVMzrM
         2d8Ho5hvs/0ckOjBtOW/YoZmuhkOx5vCN+YenSX1j2sjZKnYNyGsrGASfqCicM80dYbb
         TIuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6u9+23TRytDuYgPE46LNdROZdeRwOWR2OfnIkWa60H4=;
        fh=TlRugkRw9vaD+pB335L9hZfr+AKj+JG+XXvvAapTxc0=;
        b=BSFcjZ/nV1ySOvBMe8YdIWk2HTdjmxjPWE3jOucmi4llJC/s9+28jaiCE3li2iobxB
         3ojaLn1SkOegKzzdrtErWlUb4hmyiAHI/cmlDULzTAicEXYQI8peLPQxybIT/AGH/rxf
         XhcGwLga0BjJsRwkC7FpTFLP4EWeoTzi9yEU2/CuZwOW9BE5zLYeHN9S0Iyhn+5mZyaw
         nocVYaaWp4CVXh8D9R/GOfjI7p0GIU6JNerTtCDzs0QGW7u1gRk4bYhCI1he6Mk9XG+X
         riM9EMXOobKzduHq04U8Zp9pwugmCqIlpB9r9j65AHslYVKz8OvhQYtyaRkPftcwiNYL
         y/HA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794443462; x=1795048262; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6u9+23TRytDuYgPE46LNdROZdeRwOWR2OfnIkWa60H4=;
        b=PmJkfRtOa0rO/Dh1tMDwvyYyi8i4E7mqOIhdjvTs6fPsROBJ3Pq2NAvvMYplIx+rmm
         ruHkGOr3hL3+VrpiVX8xX4YZ7sp52IWEuz8p+Q9p8LBungYSGVz/vz+BFaTqokvz4yYd
         lb0O4tsLPwJ5oZiVKZIZeXkAFWXaf1Rlo3LCzVSGq1sPYg6pJPc1X3E9eEoosvQZuQPn
         00rLLD64ErhJR12cHuBoKtynFP8WAlxfWphZLLT2ImDj4RZHEskQxHzJtG/cB268giDn
         e0LXgzAAHqHDpBV/AmN2spYV9ZhgoB1fyPNRintHhQzNtE56fAaZGpJcDbohehDw3YP9
         WcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794443462; x=1795048262;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6u9+23TRytDuYgPE46LNdROZdeRwOWR2OfnIkWa60H4=;
        b=SpEjxTFywlyjmppSrf8O6VS1Bqoi3578If7zXrwp7MLScsAqFUg1CnKW8H+7Nd0Qqx
         5B/Jk9Evyih8bexCqwndDqTYsZVccrJd02fyCVnFV+s2NY+UgBzQEKLK60rArQVHOLsr
         9AwUz/QtV7NEVlXctb8FASQc7PtSOizcsFFkmmR29Bq0x4gF5mjHsI9n8k/Q5mUj1Rba
         3n8KGtCG350avZpY6SboUo49MpM/X4OTfFnFfi7sWZrvkC2zMxAOVHD+TBCinTUMpDN2
         hHr4pC1cLpppAQMcabIwV7naPAX5lQt1Zpiu0Jld67EHIids8d0zb9/i5p0hOgCsDCpA
         gJgA==
X-Forwarded-Encrypted: i=1; AL+hErEX9vsG+vV3UtA8KnflB2R75U6NgDXthAV0s3K4HCzhrSwtYvrGGQZesbRIREfLKf+Pivm+7bHryapYH5I=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8cSTfMRjI7wvkIQR67QSwBfIjrKBffcuo0djTBggW2HF63/ys5
	UGDIwmmxurL2kIeYpA/c9KVAYz/29IuXbBucoI7MpWdH3Pj5FWwc2LBEKlBUegi6WW2sRbQvHdt
	piaAaNWnoTKzs3iuN0+awGzfeMB0SXqRrv1OfU3GR
X-Gm-Gg: AYBFou2ZbTqgsmnMwA1t+2HsUkG91BNeU/0+J8Vv0928QG3rw346ENrQivuts9riTqF
	KrSSTjEiAXVOAXVUi9s/bpzadtlL07SnweElwytB1FBBCklOltjE0o8a5JJ8oT71YmMVQ5Ln3MA
	hYUOe09uIoNaaALu2bsOCmpO3nfpGCgpl7MVTbeLXAGzZuewybJwnf9yJVI/7eSp5kiv222x7x9
	XF1iDUEJV/n3Qv8VjdpsBamEFtedRmEWzNBnqe/KrHNayAj7IxL5Z3/4hZHeiwQFWmdEv74Fe2c
	FqZZeekUGhVisOxdMUHqmFcDQQ03+MwOwtypsnJppxj/L/92YhWLr0XG3Hj002KMk/RgLFDB/TA
	IzCSTcViriuR+NNRdz8laujjI3xGF+cqmlC3lPJVbkKvia1cqa7UdW3JwpLDORukXqshhy31RTh
	NoRwQgrTwPJYmQ4/7cClgIw7Mh
X-Received: by 2002:a05:622a:5597:b0:536:6d88:600a with SMTP id
 d75a77b69052e-5598fa68ba7mr5286631cf.9.1794443461135; Wed, 11 Nov 2026
 16:31:01 -0800 (PST)
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
References: <20261110112546.261415-1-hao.ge@linux.dev> <20261110112546.261415-7-hao.ge@linux.dev>
In-Reply-To: <20261110112546.261415-7-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 12 Nov 2026 00:30:49 +0000
X-Gm-Features: AclHuK8yVOU0rM_Krxb68wuVhwe9clhKmxqaCwvxpYiiXo0gID9uClDW_ZDomNY
Message-ID: <CAJuCfpHReBDoXj_U3Dy2hksj63KyHNBm4gS+wtR_ywidyJ8mfw@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] mm/vmalloc: only flush the cache after the vmap succeeded
To: Hao Ge <hao.ge@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Sashiko <sashiko-bot@kernel.org>
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
> vmap_page_range() and __vmap_pages_range() call flush_cache_vmap()

New vmap_pages_range_batched() function has the same issue, so needs fixing=
 too.

> before they even look at the error code. A failed mapping is never
> used, so the flush is pointless at best.
>
> According to the Sashiko review it is worse than pointless on UML:
> flush_cache_vmap() there is flush_tlb_kernel_range(), which syncs the
> PTEs into the host OS. Flushing a half-installed mapping therefore
> leaves host mappings behind for a range that was just freed again.
>
> Only flush when the mapping, and for vmap_page_range() also the KMSAN
> metadata, is fully set up.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/vmalloc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 0565cbfe325c..3f98056f8c7e 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -369,10 +369,12 @@ int vmap_page_range(unsigned long addr, unsigned lo=
ng end,
>
>         err =3D vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
>                                  ioremap_max_page_shift);
> -       flush_cache_vmap(addr, end);
>         if (!err)
>                 err =3D kmsan_ioremap_page_range(addr, end, phys_addr, pr=
ot,
>                                                ioremap_max_page_shift);
> +       if (!err)
> +               flush_cache_vmap(addr, end);
> +
>         return err;
>  }
>
> @@ -758,7 +760,9 @@ static int __vmap_pages_range(unsigned long addr, uns=
igned long end,
>         int err;
>
>         err =3D vmap_pages_range_noflush(addr, end, prot, pages, page_shi=
ft, gfp_mask);
> -       flush_cache_vmap(addr, end);
> +       if (!err)
> +               flush_cache_vmap(addr, end);
> +
>         return err;
>  }
>
> --
> 2.25.1
>

