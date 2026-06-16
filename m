Return-Path: <linuxppc-dev+bounces-22679-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFDFCD98DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 03:05:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfX1Y2rzTz3brR;
	Tue, 16 Jun 2026 13:05:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781579153;
	cv=none; b=jg/rJQPzw20EqrWF9Gs2AWyEYZHyo+iDUveCWTPB7sYlsSp4joOW4MHs/nle8F1Fe+Rf+cQ+xv2OXsoRU5bCxU6X82u+OpfPgGpojcD8lh3il23gnErjB4ziGi4/a09FpIw23EkJ2SuQrfEVbkWfPF9QNODhLpcz8OvkKym+mppN2NaaUSoJDJD5IbambFk8mmf3qeSXRy3Oh+sC9aVtCQYQjhLzx5l54ilc2l15rMKiRVg+niyrsgsf7kvEU1O9lL9Bjc040Ij39y9TF5dPQ+DeJ+huzoYNnpUJd/allncnkY06cNoU7OaR8eycHzQ6Pyfj1j3lpRWxq8OtO+Q0GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781579153; c=relaxed/relaxed;
	bh=UCuy06I4nPKaRj4EdDj906BN7ekSIsZfFchCV1iyaYU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jU5qfxj8y4DuLB6zkjuOExmLWVs6oj3BbycdnI9iFbrYqWX0eK1U0Ks+1kQjcEMUqa+BnQpLbghvFMBTcw2h6hObYgPViGZTkwkfxqKLSeJgs2cgOSMFWg9lPgNwtOartOMYCBZ+qKx+eemU/A95Z+Gwc7rs/U6aSb+8EfH3C1rVVV5ZRtF+IRUQWhW8/AY+JkGlOc1wW9k7wTkfao/hPG9AiND2UI2MlWMEfcyZLiE3RjQ8sPOQvw4oMsBtJChMiTc3YpAyiU61za6QaCf2ttb5pgBseKEFvDcwz4+1Ar/2f6PO9bVYPYb481L7ORcSNf9ihcWXU7Mylw6P+Eo0+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jjiaLzgs; dkim-atps=neutral; spf=pass (client-ip=95.215.58.188; helo=out-188.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jjiaLzgs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.188; helo=out-188.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfX1T52wBz3bqh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 13:05:48 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781579123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCuy06I4nPKaRj4EdDj906BN7ekSIsZfFchCV1iyaYU=;
	b=jjiaLzgsV6Wzixa47UJBYqkzHBZu+5T+BdwBeaP3Le78Qf58EYhpy7SAeR8EzB+hv4DRBm
	C+3deN0BgPOxgtnYgt9wTPs2kPyjRObnf7P2aN6RXqLyTmgaIQgS+Vx5m0zg5fsawIjQqp
	B1YPvSV49572/4yXnAe+FSAUoj5Ddfg=
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v4 07/19] mm/sparse: Move subsection_map_init() into
 sparse_init()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <tencent_5D21B8CE461994D9323FDEDA6441E4234407@qq.com>
Date: Tue, 16 Jun 2026 11:04:38 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mike Rapoport <rppt@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Mike Kravetz <mike.kravetz@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC123A77-79AE-42F1-89F9-4001D0B63E9E@linux.dev>
References: <20260612035903.2468601-1-songmuchun@bytedance.com>
 <20260612035903.2468601-8-songmuchun@bytedance.com>
 <tencent_5D21B8CE461994D9323FDEDA6441E4234407@qq.com>
To: XIAO WU <xiaowu.417@qq.com>
X-Migadu-Flow: FLOW_OUT



> On Jun 16, 2026, at 00:35, XIAO WU <xiaowu.417@qq.com> wrote:
>=20
> Hi Muchun,

Hi,

>=20
> Muchun Song <muchun.song@linux.dev> wrote:
> > mm/sparse: Move subsection_map_init() into sparse_init()
> >
> > This commit moves subsection_map_init() from free_area_init() into
> > sparse_init() so that sparse-specific setup stays together instead =
of being
> > split across the generic free_area_init() path.
>=20
> This patch introduces a new `sparse_init_subsection_map()` that =
iterates
> over all memblock ranges and calls =
`sparse_init_subsection_map_range()`:
>=20
> > +void __init sparse_init_subsection_map(void)
> > +{
> > +    int i, nid;
> > +    unsigned long start, end;
> > +
> > +    for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, &nid)
> > +        sparse_init_subsection_map_range(start, end - start);
>=20
> However, earlier in `sparse_init()`, `memblocks_present()` calls
> `memory_present()`, which internally caps PFN ranges at
> `max_sparsemem_pfn` via `mminit_validate_memmodel_limits()`. Sections
> beyond this cap never have `ms->usage` allocated.
>=20
> `for_each_mem_pfn_range()` returns the raw, uncapped memblock ranges.
> If a range extends beyond `max_sparsemem_pfn`, then inside
> `sparse_init_subsection_map_range()`:
>=20
>     ms =3D __nr_to_section(nr);
>     subsection_mask_set(ms->usage->subsection_map, pfn, pfns);
>=20
> `ms->usage` is NULL because `sparse_init_early_section()` was never
> called for this section, causing a NULL pointer dereference.

Thanks for your report. IIUC, it is a pre-existing issue.

>=20
> I was able to reproduce this on x86_64 with 4-level paging by booting
> with `memmap=3D4G@0x400080000000` to place a memblock range beyond the
> ~64 TiB `max_sparsemem_pfn` limit.  The kernel crashes during early =
boot:
>=20
>   node  -1: [mem 0x0000400080000000-0x000040017fffffff]
>   ------------[ cut here ]------------
>   WARNING: mm/sparse.c:142 at sparse_init+0x1ac/0x8a0
>    ...
>   PANIC: early exception 0x0d IP =
10:...sparse_init_subsection_map+0x12f/0x250
>   RIP: 0010:sparse_init_subsection_map+0x12f/0x250
>   Call Trace:
>    sparse_init+0x69f/0x8a0
>    mm_core_init_early+0x12fa/0x20c0
>    start_kernel+0x89/0x4e0
>=20
> The fix is a one-line NULL check in =
sparse_init_subsection_map_range():

Would you mind sending a separate fix patch since it is not introduced =
by
this patch? I would like to review it.

Muchun,
Thanks.

>=20
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -608,6 +608,8 @@ void __init sparse_init_subsection_map(unsigned =
long pfn,
>          pfns =3D min(nr_pages, PAGES_PER_SECTION
>                  - (pfn & ~PAGE_SECTION_MASK));
>          ms =3D __nr_to_section(nr);
> +        if (!ms->usage)
> +            continue;
>          subsection_mask_set(ms->usage->subsection_map, pfn, pfns);
>=20
> On most systems `max_sparsemem_pfn` is large enough that this is never
> hit, but on 32-bit or PAE configurations where the limit is much =
lower,
> the mismatch between `for_each_mem_pfn_range()` and
> `mminit_validate_memmodel_limits()` can trigger with reasonable memory
> sizes.
>=20
> Thanks,
> Xiao
>=20
>=20


