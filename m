Return-Path: <linuxppc-dev+bounces-22735-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D79BCD98E2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2026 06:56:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggF5M2wptz2yFj;
	Wed, 17 Jun 2026 16:56:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::ad"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781679399;
	cv=none; b=G2vZyfkGX+EBZo6+zj9x2Xjjakt4GG8XIjb3AEYj+jpvP/8sdrDe48MVZMhx9RWFw8vYx8uSsHNARRvhw7JnRvqID1LoO1tfUR/KUb1na7lYVv3Oy0QAxZQC/SAGYQVRJ2+VWoZlxS8SqQeZDXrusia8Vox8buIqciArZtaWfk27YbW5zny2WyrRMFXUcNyZ1hsjqH9d952rFuyar7HnE/7UukhuoaAyyvyARb1rh9kpURFKOAjZKTDRVxXMkRTzqIM/qUfiWMRIXvtLynMqiDTidvt2CrVXfnGeG5yqHVcTD5BmFVY8SCr9vJJoXKYv6mFSoxzLbvHJoofmuRpWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781679399; c=relaxed/relaxed;
	bh=Pd8gbWlNCzyQkqrU5ZHSLBlgsjsUTsM3D0rkfq8QUW0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Jc1ISKHP9EE6qSLaAAzwdVQFE81YWmILQiuCoRCsXLDSX71/sB3IjoquyYFV5W3k5tfU4+mC8rr7yk9xiFTQaKP4dAEj4BMS1ajgkdCwOU6PRNGmd0b9039OSrKpVspEBcjuAgK765g1HRXF6cG15f1ZAP0vL3nmQAGJZOCNTPsewayHOXwSzlr/xyAhmP3Kd9eqhEJ4upExWwIoYdumElg0N3DJrdoe6+QBB5bGYqxesEQczjXwxdbQDqE660A1BQVY7Z375hWhK4Lovbh1OZiworxmfQL+1buXK/9b2ozM5QtSBrLItP7OUqAW4y+PT4Cli+2dHDkCb4wRIMikvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ttcAU0uv; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::ad; helo=out-173.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ttcAU0uv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::ad; helo=out-173.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [IPv6:2001:41d0:203:375::ad])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggF5H0MMMz2yFc
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 16:56:33 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781679372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pd8gbWlNCzyQkqrU5ZHSLBlgsjsUTsM3D0rkfq8QUW0=;
	b=ttcAU0uv6c4ydMwv2tlS3Wzs4bC6X98JE1iuB1K3Xm0VC+m/C51NpfOzx5cdFQzkyMK+vp
	YRs/Mhod1qpU9xD9YJL4sDSKUoMdQz4FqoMOwK397a4Fy+3cVA52NT6LDbcvy25HoPukjR
	7w3/v5h8h9a09AS9H3WcWW1T1bs3iCw=
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
Subject: Re: [PATCH v4 00/19] mm: Refactor bootmem gigantic hugepage
 allocation
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260612035903.2468601-1-songmuchun@bytedance.com>
Date: Wed, 17 Jun 2026 14:54:39 +0800
Cc: Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Muchun Song <songmuchun@bytedance.com>,
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
 linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1213AB34-BDA3-4EB0-A2D1-83A4744C710F@linux.dev>
References: <20260612035903.2468601-1-songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT



> On Jun 12, 2026, at 11:58, Muchun Song <songmuchun@bytedance.com> =
wrote:
>=20
> This series is split out from the earlier larger series "mm: =
Generalize
> HVO for HugeTLB and device DAX" [1]. It collects the first 19 patches =
of
> that series as a standalone set of fixes and preparatory cleanups =
around
> bootmem HugeTLB handling, sparse initialization ordering, and related
> vmemmap setup.
>=20
> The first patches fix a few bugs found while reviewing the existing
> code, including incorrect bootmem HVO handling, wrong vmemmap
> registration arguments, a powerpc compound-vmemmap tracking bug, and
> too-late initialization of gigantic bootmem HugeTLB struct pages.
>=20
> The rest of the series reorders early memory initialization so the
> relevant zone state is available before sparse and HugeTLB boot-time
> setup runs, then simplifies the remaining bootmem gigantic hugepage
> allocation path and removes code made obsolete by that rework.
>=20
> At a high level:
>  - patches [1-4] fix boot-time and arch-specific bugs
>  - patches [5-12] reorder and simplify sparse/mm/hugetlb early init
>  - patches [13-19] refactor bootmem gigantic hugepage allocation and
>    remove obsolete helpers and state
>=20
> Changes since v3:
>  - patches 2-4: add Cc: stable@vger.kernel.org to the applicable fixes
>  - patch 3: collect Reviewed-by from Ritesh Harjani
>  - patch 15: move pfn_to_zone() before hugetlb_vmemmap_init_early()
>    instead of using a forward declaration
>  - patches 15-17: collect Acked-by from Mike Rapoport where applicable
>  - patch 15: collect Acked-by from Usama Arif
>  - patch 18: clarify that the changelog also covers the early CMA
>    bootmem allocation fallback refactoring
>  - patch 19: initialize pgdat at declaration in
>    __init_deferred_page() and collect Reviewed-by from Mike Rapoport
>=20
> [1] =
https://lore.kernel.org/linux-mm/20260513130542.35604-1-songmuchun@bytedan=
ce.com/

Hi Andrew,

Would you mind picking these up for the mm-unstable branch? Almost all
patches have received a Reviewed-by or Acked-by.

Regarding the Sashiko review comments, it reported 5 issues in total, =
and
I've verified all of them:

- Patches 7 & 11: These are pre-existing issues and not introduced by =
this
  series.
- Patch 14: This is a false positive.
- Patches 8 & 9: These are valid observations but not a practical issue. =
The
  report mentioned:

	"moving these reservations after free_area_init() artificially =
inflate
	 nr_kernel_pages and nr_all_pages, potentially causing an early =
boot OOM"

However, this aligns the 1GB HugeTLB allocation behavior with the =
existing
2MB HugeTLB allocation, which already behaves this way. So it won't =
introduce
new risks.

Thanks for your time!

Best regards,
Muchun

>=20
> Muchun Song (19):
>  mm/hugetlb: Fix boot panic with CONFIG_DEBUG_VM and HVO bootmem pages
>  mm/hugetlb_vmemmap: Fix __hugetlb_vmemmap_optimize_folios()
>  powerpc/mm: Fix wrong addr_pfn tracking in compound vmemmap =
population
>  mm/hugetlb: Initialize gigantic bootmem hugepage struct pages earlier
>  mm/mm_init: Simplify deferred_free_pages() migratetype init
>  mm/sparse: Panic on memmap and usemap allocation failure
>  mm/sparse: Move subsection_map_init() into sparse_init()
>  mm/mm_init: Defer sparse_init() until after zone initialization
>  mm/mm_init: Defer hugetlb reservation until after zone initialization
>  mm/mm_init: Remove set_pageblock_order() call from sparse_init()
>  mm/sparse: Move sparse_vmemmap_init_nid_late() into sparse_init_nid()
>  mm/hugetlb_cma: Validate hugetlb CMA range by zone at reserve time
>  mm/hugetlb: Refactor early boot gigantic hugepage allocation
>  mm/hugetlb: Free cross-zone bootmem gigantic pages after allocation
>  mm/hugetlb_vmemmap: Move bootmem HVO setup to early init
>  mm/hugetlb: Remove obsolete bootmem cross-zone checks
>  mm/sparse-vmemmap: Remove sparse_vmemmap_init_nid_late()
>  mm/hugetlb: Remove unused bootmem cma field
>  mm/mm_init: Fold __init_page_from_nid() into __init_deferred_page()
>=20
> arch/powerpc/mm/book3s64/radix_pgtable.c |   7 +-
> arch/powerpc/mm/hugetlbpage.c            |  13 +-
> include/linux/hugetlb.h                  |  24 +--
> include/linux/mmzone.h                   |   7 -
> mm/cma.c                                 |   3 +-
> mm/hugetlb.c                             | 259 +++++++++++------------
> mm/hugetlb_cma.c                         |  44 ++--
> mm/hugetlb_cma.h                         |   8 +-
> mm/hugetlb_vmemmap.c                     | 120 +++--------
> mm/hugetlb_vmemmap.h                     |   5 -
> mm/internal.h                            |  14 +-
> mm/mm_init.c                             |  86 +++-----
> mm/sparse-vmemmap.c                      |  26 ++-
> mm/sparse.c                              |  48 +----
> 14 files changed, 251 insertions(+), 413 deletions(-)
>=20
>=20
> base-commit: ec039126b7fac4e3af35ebccaa7c6f9b6875ba81
> --=20
> 2.54.0


