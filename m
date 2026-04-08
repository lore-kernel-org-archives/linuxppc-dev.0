Return-Path: <linuxppc-dev+bounces-19514-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D2010F994F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 15:30:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frRp414ztz2yDk;
	Thu, 09 Apr 2026 01:30:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::32f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775662204;
	cv=pass; b=i3Y3ySjUDfU5s1CYjvKvrLNAQtixUV7gaojanGiQwmr4wmFRkTLAbclIdgeMvcl18GONFSWk504pGK75tJIRIQbkTNb2RLW4ud9KlfH2Xj0y6HZw94G2Sre6riCrEZHB46V/jEM9JqJ/HpM1WTULSMLmyvgcjuiV7bqH0ab6KqYTbIsC5+aeOsy63xtNHB/A7nh7gDkgDvNXTD+QhQxag2xWjy2wyAXXdVNr5cqbBZImi3lpF3Y6qWjFW+226ztTxfv5K5QqNc6c0/7wMA5+eshIyaQAmGQ/7IcrGSwuX4zyjY0f62mvRtxwv7jCaQ8n6gDCKEBzGCd7fRL6hPXPxQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775662204; c=relaxed/relaxed;
	bh=sJHD6SMQiiS15OEauGdACHyjg3IeXbof2naajJssOZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpEbMhMxPGQgXS7fcFrfUUUteyxp1lxrBa+TkEmWIEI7g/xgGcLs+G0rIvP8DeJaoejA7c1XwGcmCOyVYzqeRZjInJLMseRKbOR8ppYAWKQLCsGzgw5Pu8212BUyu2Duj0uN6cYBcfB/DSne4ELgBg4++NjSeBu64DbDIOIINmWFXHi4isNkLMxxWbF6zJVnlYA4HrHO0r44TGdolYVoytIOvYdIVul9QiOgWzon6+PwHiksv2dO3toA7H7Gwka8eAaD3Pa5SV4IAeM2rD16KilI4rFB75YQiqC0F1PE7PnPm1P58Ey1zcGezhP9Avk6dt5qxn2d9qkQd/7XnHKkhQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=jMXmCy2L; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=fvdl@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=jMXmCy2L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=fvdl@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frRp15QvDz2yC9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Apr 2026 01:30:01 +1000 (AEST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-488879dcbc3so131185e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 08:30:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775662198; cv=none;
        d=google.com; s=arc-20240605;
        b=KMhdIo9RKviWW92PbYQYLwcYvYtMIkBpCv1u9kPAWhR3aL+9tPytjsNbXisILjQ0uT
         D7BU9bsDzt7Jzq9rvtTsTl5NfTqBS4Pd7ByTovg3XtCYcR78zzHwlekVF58wL5xb8JUS
         lE3Ee8odyzppPnHK0+X71qaSJDFIL0ve+3astqCx1XXyo5ol9JxORl1nDtlTVPzGZeop
         LhGjy9YOeMWkjm3OWXReFWc0HvzHq8iqtVOdrnhlT3w3cBehPbVDGvkCEfLVR58qj0Vs
         aRXiO4emBnIxDzjshKneERJ+9+OttPyjza3SLY1phLm5j8cTMJFbxzBK4bUoeTAVwSLk
         WLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sJHD6SMQiiS15OEauGdACHyjg3IeXbof2naajJssOZ4=;
        fh=LLq9s+HCSFJOgpc4/KkL4043oReRLTcZEfIlO3uTO6Q=;
        b=T6EnwqU+LsRGS6UPEXJJc8M9dDRqUOeXRyek8ehpnPQEnHQoX/MhxX0tddgXbkxM4q
         FnwTQNDbc/sSEOTDyVPGQNsRvLv5XsD1EhSaOXizGVaToHwoGoGChfOo0gtK3ksqdViZ
         vhi+9fSgPDZq7obo/tW8ypAPOO2MCQPcSs8s8RiieZ3f9cyRyYW9oW/NXIm4a3reO7R9
         R6vp5VIUt0Y2pDJTdiCqinoL5GX1GptGukhddlUyxX0BnD614/y9rytiUkJQJNXtY4fV
         BUGvGBqvKaiKq0Ad8H++xZr5oF7oHvrnIkdLyXg23o6nZ+DuO2WRxrYpmTOOPm7pvKSN
         Oc7g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775662198; x=1776266998; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJHD6SMQiiS15OEauGdACHyjg3IeXbof2naajJssOZ4=;
        b=jMXmCy2LxH8VqYlFfMaMXzpPyUCpPaB5R1YELKfzaGbYfrXUzsKkaOMvTsAHLG9OSF
         +6PnHnU/+gFEIKPDqS1BY03Lp4iG52VItbDXBb+xLOZHTWcybQpmnmZe0sW1lq41Ni6k
         7pqco3EdPOr40NQrdq5dARFi1frisHf6hflF+OFeJHIEOSI4PSrYBBR6aDOCWqThl55p
         8d1JY4JUgYQ40evV4+wEd4pHZOfmWyJ8ZDnD1sJbxBC//8RzNJdp4qhKxy0aO57RvUnH
         Ts1iqguUnMnzOskgpqF4Jo8iDTy3rgFTNtekFnr22OwW58SZgNAENc2yOqREGh/pyPq1
         JORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775662198; x=1776266998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sJHD6SMQiiS15OEauGdACHyjg3IeXbof2naajJssOZ4=;
        b=eOKkcUPS4sIkXFSYcfWrEjfyjkjpDAKJdop9YBm2htkuWRGaWJXUeCdJ/+tzvZIBil
         oSd9NIaHB7JbegP69I7U4P0TIuwK4RwqSkPsralVADzCWYEKvJAA24gKFbUAUameoMpb
         b8KooDTp4h5KOS4VkXiQn2bMdli25tLw7UuQvCrUcgD9HDue6dLfwkPTbPeo3xZioW0+
         RaMNiw/IwaR9n3cUrmG0rVkQ19alsKZzfbt6Bp5SU9m+ZKXnCJ8nHqWXHuXCz1jxGo5q
         QrCYaAkB8JwImQxzEAdLcAtewcroR4GwnBa5wSDBThkqzs6oIySGEDbzZt7INlV0Ica4
         gZLA==
X-Forwarded-Encrypted: i=1; AJvYcCVzDjBzipWY8Xe0MEi1S0nwl3Jj6i834Wd+lIATZGHfT/vYvVssjEQipUg8SXyDsBVr/gCRrbNMvdwnP4Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwWW89SiyxZKRf+trLtw0OPEKPnYsosZqFx+jewAQjYYgVUDyRp
	MbMgJQ9RpTqkULsqaumznTebVyDZxT4bz0mv89FDeWQ0KMN25nAayQgQm0S4JJuDAvkty6OMCsZ
	BHL+dOdLhf8OlhYSYcXmrjBCPLJaugG80vuoJTeRg
X-Gm-Gg: AeBDievC5Uq5ORjtQfmPjoej0ZfV5OHNOhVb+SG08r3CFOLULDxaWtHwdd5DmPApcoz
	dISGGbes00wVVp/UC+mmqJXzB2H+V5ET8n+LRIpAFhbM0xGzAGyJgz1MFmwwZbqgLkh6VY7BMlS
	D8M5CrmzTTL28BlsnP6wu04RKJaORhUwu4x5a13AZlemEmdznK0aUy+7IKZRsIjJgF+Xr8+ETS5
	VzczjgOH2ARjP/RGu0Y5M7ezcpTZzQX9Z8pApr+DAAYGZRsIVbPXwS+i5W515pmtgAmYWTfxhRH
	tHM6k2c=
X-Received: by 2002:a05:600c:4612:b0:485:2ab4:c1f9 with SMTP id
 5b1f17b1804b1-488cbf2e5b1mr176595e9.4.1775662197639; Wed, 08 Apr 2026
 08:29:57 -0700 (PDT)
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
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
In-Reply-To: <20260405125240.2558577-1-songmuchun@bytedance.com>
From: Frank van der Linden <fvdl@google.com>
Date: Wed, 8 Apr 2026 08:29:45 -0700
X-Gm-Features: AQROBzDIxpbHHhnqGHn8vjelH9Nu4WEufqUDV3KFtdzQowFVpT_ZJVEDEErX9Ks
Message-ID: <CAPTztWYp7P=zALy_R7evjZPmQq_xMUOD8QR1wOmJHqcaENJ7cg@mail.gmail.com>
Subject: Re: [PATCH 00/49] mm: Generalize vmemmap optimization for DAX and HugeTLB
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com, joao.m.martins@oracle.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 5, 2026 at 5:53=E2=80=AFAM Muchun Song <songmuchun@bytedance.co=
m> wrote:
>
> Overview:
> This patch series generalizes the HugeTLB Vmemmap Optimization (HVO)
> into a generic vmemmap optimization framework that can be used by both
> HugeTLB and DAX.
>
> Background:
> Currently, the vmemmap optimization feature is highly coupled with
> HugeTLB. However, DAX also has similar requirements for optimizing vmemma=
p
> pages to save memory. The current implementation has separate vmemmap
> optimization paths for HugeTLB and DAX, leading to duplicated logic,
> complex initialization sequences, and architecture-specific flags.
>
> Implementation:
> This series breaks down the optimization into a generic framework:
> - Patch 1-6: Fix bugs related to sparse vmemmap initialization and DAX.
> - Patch 7-13: Refactor the existing sparse vmemmap initialization.
> - Patch 14-26: Decouple the vmemmap optimization from HugeTLB and
>   introduce generic optimization macros and functions.
> - Patch 27-39: Switch HugeTLB and DAX to use the generic framework.
> - Patch 40-49: Clean up the old HVO-specific code and simplify it.
>
> Benifit:
> - When CONFIG_DEFERRED_STRUCT_PAGE_INIT is disabled, all struct pages
>   utilizing HVO (HugeTLB Vmemmap Optimization) skip initialization in
>   memmap_init, significantly accelerating boot times.
> - All architectures supporting HVO benefit from the optimizations
>   provided by SPARSEMEM_VMEMMAP_PREINIT without requiring
>   architecture-specific adaptations.
> - Device DAX struct page savings are further improved, saving an
>   additional 4KB of struct page memory for every 2MB huge page.
> - Vmemmap tail pages used for Device DAX shared mappings are changed
>   from read-write to read-only, enhancing system security.
> - HugeTLB and Device DAX now share a unified vmemmap optimization
>   framework, reducing long-term maintenance overhead.
>
> Testing:
> - Verification: Compiled and tested on x86 architecture.
>
>
> Chengkaitao (1):
>   mm: Convert vmemmap_p?d_populate() to static functions
>
> Muchun Song (48):
>   mm/sparse: fix vmemmap accounting imbalance on memory hotplug error
>   mm/sparse: add a @pgmap argument to memory deactivation paths
>   mm/sparse: fix vmemmap page accounting for HVOed DAX
>   mm/sparse: add a @pgmap parameter to arch vmemmap_populate()
>   mm/sparse: fix missing architecture-specific page table sync for HVO
>     DAX
>   mm/mm_init: fix uninitialized pageblock migratetype for ZONE_DEVICE
>     compound pages
>   mm/mm_init: use pageblock_migratetype_init_range() in
>     deferred_free_pages()
>   mm: panic on memory allocation failure in sparse_init_nid()
>   mm: move subsection_map_init() into sparse_init()
>   mm: defer sparse_init() until after zone initialization
>   mm: make set_pageblock_order() static
>   mm: integrate sparse_vmemmap_init_nid_late() into sparse_init_nid()
>   mm/cma: validate hugetlb CMA range by zone at reserve time
>   mm/hugetlb: free cross-zone bootmem gigantic pages after allocation
>   mm/hugetlb: initialize vmemmap optimization in early stage
>   mm: remove sparse_vmemmap_init_nid_late()
>   mm/mm_init: make __init_page_from_nid() static
>   mm/sparse-vmemmap: remove the VMEMMAP_POPULATE_PAGEREF flag
>   mm: rename vmemmap optimization macros to generic names
>   mm/sparse: drop power-of-2 size requirement for struct mem_section
>   mm/sparse: introduce compound page order to mem_section
>   mm/mm_init: skip initializing shared tail pages for compound pages
>   mm/sparse-vmemmap: initialize shared tail vmemmap page upon allocation
>   mm/sparse-vmemmap: support vmemmap-optimizable compound page
>     population
>   mm/hugetlb: use generic vmemmap optimization macros
>   mm: call memblocks_present() before HugeTLB initialization
>   mm/hugetlb: switch HugeTLB to use generic vmemmap optimization
>   mm: extract pfn_to_zone() helper
>   mm/sparse-vmemmap: remove unused SPARSEMEM_VMEMMAP_PREINIT feature
>   mm/hugetlb: remove HUGE_BOOTMEM_HVO flag and simplify pre-HVO logic
>   mm/sparse-vmemmap: consolidate shared tail page allocation
>   mm: introduce CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
>   mm/sparse-vmemmap: switch DAX to use generic vmemmap optimization
>   mm/sparse-vmemmap: introduce section zone to struct mem_section
>   powerpc/mm: use generic vmemmap_shared_tail_page() in compound vmemmap
>   mm/sparse-vmemmap: unify DAX and HugeTLB vmemmap optimization
>   mm/sparse-vmemmap: remap the shared tail pages as read-only
>   mm/sparse-vmemmap: remove unused ptpfn argument
>   mm/hugetlb_vmemmap: remove vmemmap_wrprotect_hvo() and related code
>   mm/sparse: simplify section_vmemmap_pages()
>   mm/sparse-vmemmap: introduce section_vmemmap_page_structs()
>   powerpc/mm: rely on generic vmemmap_can_optimize() to simplify code
>   mm/sparse-vmemmap: drop ARCH_WANT_OPTIMIZE_DAX_VMEMMAP and simplify
>     checks
>   mm/sparse-vmemmap: drop @pgmap parameter from vmemmap populate APIs
>   mm/sparse: replace pgmap with order and zone in sparse_add_section()
>   mm: redefine HVO as Hugepage Vmemmap Optimization
>   Documentation/mm: restructure vmemmap_dedup.rst to reflect generalized
>     HVO
>   mm: consolidate struct page power-of-2 size checks for HVO
>
>  .../admin-guide/kernel-parameters.txt         |   2 +-
>  Documentation/admin-guide/sysctl/vm.rst       |   2 +-
>  Documentation/mm/vmemmap_dedup.rst            | 218 ++--------
>  arch/powerpc/Kconfig                          |   1 -
>  arch/powerpc/include/asm/book3s/64/radix.h    |  12 -
>  arch/powerpc/mm/book3s64/radix_pgtable.c      | 114 +----
>  arch/powerpc/mm/init_64.c                     |   1 +
>  arch/riscv/Kconfig                            |   1 -
>  arch/x86/Kconfig                              |   2 -
>  fs/Kconfig                                    |   6 +-
>  include/linux/hugetlb.h                       |   7 +-
>  include/linux/memory_hotplug.h                |   2 +-
>  include/linux/mm.h                            |  50 +--
>  include/linux/mm_types.h                      |   2 +
>  include/linux/mm_types_task.h                 |   4 +
>  include/linux/mmzone.h                        | 143 ++++---
>  include/linux/page-flags.h                    |  31 +-
>  kernel/bounds.c                               |   2 +
>  mm/Kconfig                                    |  20 +-
>  mm/bootmem_info.c                             |   5 +-
>  mm/cma.c                                      |   3 +-
>  mm/hugetlb.c                                  | 143 +++----
>  mm/hugetlb_cma.c                              |   3 +-
>  mm/hugetlb_vmemmap.c                          | 237 +----------
>  mm/hugetlb_vmemmap.h                          |  35 +-
>  mm/internal.h                                 |  26 +-
>  mm/memory_hotplug.c                           |  15 +-
>  mm/mm_init.c                                  | 138 +++---
>  mm/sparse-vmemmap.c                           | 392 +++++-------------
>  mm/sparse.c                                   |  85 ++--
>  mm/util.c                                     |   2 +-
>  scripts/gdb/linux/mm.py                       |   6 +-
>  32 files changed, 513 insertions(+), 1197 deletions(-)
>
> --
> 2.20.1

Thanks very much for doing this. This cleans up a lot of stuff. I did
want to do some of this when I did the pre-HVO code, but I ended up
not doing it to prevent perfect being the enemy of good.

I haven't looked at all the individual patches yet, but overall this
looks great to me.

- Frank

