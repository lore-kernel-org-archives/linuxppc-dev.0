Return-Path: <linuxppc-dev+bounces-20850-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C15DCD4F24
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:07:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFtzg32Ckz2xld;
	Wed, 13 May 2026 23:07:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677663;
	cv=none; b=cffWCXsNYtjTD3uJdCa+owszF0RpD1AzgpqsM+EWFsussqL3P6YrfH2STzONPbwfapoqUrkJuUm6mGiq+YRMk84rmAyZUBcTMZId4f3rMspuQroMJqfKfZueNAgW41i2RkUg+PdLVFEHnNZtuQVvJXU9EkzUiF5Xq6chPDGvO2xOtigJ4+q4F8t7CDL8NWzk3lB+Nk9mwVrroBRUJswXBQTSuQsrNx0kKfYjtvcZPeHjQIPXdnOs2thFb1/Y5lKE8cl8gVbEsNkllBgz0qIj7zBkHPhuYqQ5qGdDy56KRZgOhOOclAV2GVqrLIPW4rTO9B+l846veFJvWR6kCvCt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677663; c=relaxed/relaxed;
	bh=J8NpoUoHQ+aQSSKrd0jYtj6P28R/h0KlfJ/MEbWicLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HfIsfQjJdzIdi2e46lP4203heu/aSdfmcqswWkoZ6yn+mcCPTQ84ucyAP4jfO9kTFHvqyJTY1pB/q6mKdnEOjyHGKD+nazXfn9vK9/koTDxltkwgofvajTuFGFyRTR/LpndYraGCbwqlm9R2rwLFThhN+CEZSYZ6jmyIVQhcQLLpif8wxU8ewAHEbAVE9XmsGAJoUkEYA0U7EBl1vLNx5KzF7zNP2uU0DVRUNtVxoy5y/vIZ9AzJMojXPia0bIT9woFbMRJ3epferxkMxg1pFIeeFdaKqQR2wE5J+TnPS82gEuhn4BuTJdaa/KJ4auDkMwbax4l72ckdYZSKWwlzBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=dIYvHzXG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=dIYvHzXG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFtzY5rFqz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:07:36 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-c7ffe8eeaf2so2863538a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677653; x=1779282453; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J8NpoUoHQ+aQSSKrd0jYtj6P28R/h0KlfJ/MEbWicLs=;
        b=dIYvHzXGiOCtFjjPYRoBeeS5NxVkLB5SysE9h4SyUwA4S8SXfXgDTIbj2jtKzUyVL2
         eYEEcdISosLB38UtXvk2/lPzQeVbOMiVboymxYfbF2bVRvsOiFV0ALV7AFOgZ+NhgDRl
         kzQW5aKFdrpcpW4QK4NP0kMPgQUuq2MsVpldJ/e150/VYV4eElVRFHfWm2prMotiD1wM
         1Zy/EmJSnR/3LbvN5HmAgaU9DZORB1JoJ/WoARiegPHAN1GB20FJfMxDF03JdDhBxRBX
         l0w3nNuBw7ImX2LdxBYSJl6oiuAP7HUF6ajRO0YFUEU46w7IRcx0ypRW/qTgp4gd9KHR
         8PXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677653; x=1779282453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8NpoUoHQ+aQSSKrd0jYtj6P28R/h0KlfJ/MEbWicLs=;
        b=Dzrh8S/39+Wrn9BQ2dQh2U7GRWMOb4RlEBjWZQQkPCIZpokFZsT/v5fKEwve2psXWh
         zSRDdkexQsqkPIm4bl7PHR/xuGZ9EjHSBCJrGDheKBKnXKD6L1ULeR65Sa0Wj3DWvk8P
         VttqyOZ1Go0CXVjsOTCJgu7tA6srabs9uk1Slott/dBWuwGQEmwU0Ti1RWFx0lxj2KOK
         bkqB+YVRh8qCHzU/KRJKaVukFhBav4uylaoeO8mZWQ1VYpsELsov6CJ3NHvJIwwfc0Ni
         Q0tltNXOTQXw5UwYQHxTpfV4id5jzJv8Rv+rSsqbNQW2oJATPZI3uuE7stTrAPIm6u5g
         IrTg==
X-Forwarded-Encrypted: i=1; AFNElJ95tUxHfm+5uVTKgpWAprrGA5i37OrJDPmj8NdgefJw8zW2THji7sUxT+vZWyW/B6FrXZ/c7fh8ZJ3sX2A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy5OOQ1P79jhpLlkaguIu0TI+GQWACLxZaWaNg6yYSRrDoccBvq
	kPYaNyGz602zHnguzdHINipyWAmB804jutSrsqQjmRYjusS2GCJiV+jhqP1/eGC8Rt8=
X-Gm-Gg: Acq92OGneu/A3OsvfQ8Be9hKXaOUsM7pw0FFrFofTZCMWkEWEP1LSdO6Gu2Nnb10Zho
	gMUuK5fKyhCUhgJe1bFercCKNdrlTE+uBGwRz9oYfaBYj54+6fMniORBXv5pFg01XVd/wJSS3OU
	LF3ClyOnB16GX5l/TYN/2/yLs5PT3SXxCq4jr3K1ve3rPk+xzkWKStV2XBTTd6zkWn8RiL3D2uA
	eEzOJDIFHpjZLzJUMHyU7VN3WJhrYe4NRzCzcXYcUxvn9EjAb4SdIMEpuuBCLjGNtO/ii6eewZd
	YsIfTbxxf7jbDDRzfOMrWyqWCdf+nJflCwPFAVTCAmjUqGCNWDOurd7UbmytrBfRcdeLsoBQPOg
	R3dOEousRPvFkzp+iYn80ouCZ0n/YEEer+Nc66vpGdD0ytqIvmTsGv0hWeK6owPm6UfGQwFpqhs
	M5/4Gyi1YM+ZnUCOByyPm4r/b8SiM9TPLFDYjYRL7YHZTF2zKhS2jIrExJWdw=
X-Received: by 2002:a17:903:1b4f:b0:2b0:9c2b:641d with SMTP id d9443c01a7336-2bd2f4dbc06mr31307215ad.2.1778677652955;
        Wed, 13 May 2026 06:07:32 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.07.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:07:32 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Frank van der Linden <fvdl@google.com>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 00/69] mm: Generalize HVO for HugeTLB and device DAX
Date: Wed, 13 May 2026 21:04:28 +0800
Message-ID: <20260513130542.35604-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
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
Content-Transfer-Encoding: 8bit

In this series, HVO is redefined as Hugepage Vmemmap Optimization: a
general vmemmap optimization model for large hugepage-backed mappings,
rather than a HugeTLB-only implementation detail.

The existing code grew around the original HugeTLB-specific HVO path,
while device DAX developed similar but separate vmemmap optimization
handling. As a result, the current implementation carries duplicated
logic, boot-time special cases, and subsystem-specific interfaces around
what is fundamentally the same sparse-vmemmap optimization.

This series generalizes that optimization into a common framework used
by both HugeTLB and device DAX.

The first few patches include some minor bug fixes found during AI-aided
review of the current code. These fixes are not the main goal of the
series, but the later refactoring and unification work depends on them,
so they are included here as preparatory changes.

The series then reworks the relevant early boot and sparse
initialization paths, introduces a generic section-based sparse-vmemmap
optimization infrastructure, switches HugeTLB and device DAX over to the
shared implementation, and removes the old special-case code.

At a high level, the series does the following:

  - apply a small set of preparatory bug fixes
  - reorder early boot and sparse initialization so optimized vmemmap
    setup has the required zone and pageblock state
  - introduce generic section-based vmemmap optimization infrastructure
  - switch HugeTLB and device DAX to the shared implementation
  - consolidate HVO enablement and naming
  - remove obsolete HugeTLB-specific boot-time and architecture-specific
    optimization code
  - rewrite the documentation around the unified design

This brings a few concrete benefits:

  - HugeTLB and device DAX share one vmemmap optimization framework,
    reducing duplicated logic and long-term maintenance overhead
  - when CONFIG_DEFERRED_STRUCT_PAGE_INIT is disabled, optimized struct
    pages can skip the usual memmap_init() initialization work, which
    helps reduce boot-time overhead
  - all architectures that support HVO benefit from the generic
    sparse-vmemmap optimization path without extra architecture-specific
    preinit handling
  - device DAX improves its struct page savings further by dropping the
    extra reserved tail page
  - shared vmemmap tail pages are mapped read-only, improving robustness

I have only built and tested this series on x86. I do not currently have
a powerpc test environment, so any testing or feedback on powerpc would
be much appreciated.

Changes since v1:
  - rebased onto current next tree
  - added the preparatory minor bug fixes found during AI-aided review
  - added further refactoring on top of the new infrastructure

Muchun Song (69):
  mm/hugetlb: Fix boot panic with CONFIG_DEBUG_VM and HVO bootmem pages
  mm/hugetlb_vmemmap: Fix __hugetlb_vmemmap_optimize_folios()
  powerpc/mm: Fix wrong addr_pfn tracking in compound vmemmap population
  mm/hugetlb: Initialize gigantic bootmem hugepage struct pages earlier
  mm/mm_init: Simplify deferred_free_pages() migratetype init
  mm/sparse: Panic on memmap and usemap allocation failure
  mm/sparse: Move subsection_map_init() into sparse_init()
  mm/mm_init: Defer sparse_init() until after zone initialization
  mm/mm_init: Defer hugetlb reservation until after zone initialization
  mm/mm_init: Remove set_pageblock_order() call from sparse_init()
  mm/sparse: Move sparse_vmemmap_init_nid_late() into sparse_init_nid()
  mm/hugetlb_cma: Validate hugetlb CMA range by zone at reserve time
  mm/hugetlb: Refactor early boot gigantic hugepage allocation
  mm/hugetlb: Free cross-zone bootmem gigantic pages after allocation
  mm/hugetlb_vmemmap: Move bootmem HVO setup to early init
  mm/hugetlb: Remove obsolete bootmem cross-zone checks
  mm/sparse-vmemmap: Remove sparse_vmemmap_init_nid_late()
  mm/hugetlb: Remove unused bootmem cma field
  mm/mm_init: Make __init_page_from_nid() static
  mm/sparse-vmemmap: Drop VMEMMAP_POPULATE_PAGEREF
  mm: Rename vmemmap optimization macros around folio semantics
  mm/sparse: Drop power-of-2 size requirement for struct mem_section
  mm/sparse-vmemmap: track compound page order in struct mem_section
  mm/mm_init: Skip initializing shared vmemmap tail pages
  mm/sparse-vmemmap: Initialize shared tail vmemmap pages on allocation
  mm/sparse-vmemmap: Support section-based vmemmap accounting
  mm/sparse-vmemmap: Support section-based vmemmap optimization
  mm/hugetlb: Use generic vmemmap optimization macros
  mm/sparse: Mark memblocks present earlier
  mm/hugetlb: Switch HugeTLB to section-based vmemmap optimization
  mm/sparse: Remove section_map_size()
  mm/mm_init: Factor out pfn_to_zone() as a shared helper
  mm/sparse: Remove SPARSEMEM_VMEMMAP_PREINIT
  mm/sparse: Inline usemap allocation into sparse_init_nid()
  mm/hugetlb: Remove HUGE_BOOTMEM_HVO
  mm/hugetlb: Remove HUGE_BOOTMEM_CMA
  mm/sparse-vmemmap: Factor out shared vmemmap page allocation
  mm/sparse-vmemmap: Introduce CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
  mm/sparse-vmemmap: Switch DAX to vmemmap_shared_tail_page()
  powerpc/mm: Switch DAX to vmemmap_shared_tail_page()
  mm/sparse-vmemmap: Drop the extra tail page from DAX reservation
  mm/sparse-vmemmap: Switch DAX to section-based vmemmap optimization
  mm/sparse-vmemmap: Unify DAX and HugeTLB population paths
  mm/sparse-vmemmap: Remove the unused ptpfn argument
  powerpc/mm: Make vmemmap_populate_compound_pages() static
  mm/sparse-vmemmap: Map shared vmemmap tail pages read-only
  powerpc/mm: Map shared vmemmap tail pages read-only
  mm/sparse-vmemmap: Inline vmemmap_populate_address() into its caller
  mm/hugetlb_vmemmap: Remove vmemmap_wrprotect_hvo()
  mm/sparse: Simplify section_nr_vmemmap_pages()
  mm/sparse-vmemmap: Introduce vmemmap_nr_struct_pages()
  powerpc/mm: Drop powerpc vmemmap_can_optimize()
  mm/sparse-vmemmap: Drop vmemmap_can_optimize()
  mm/sparse-vmemmap: Drop @pgmap from vmemmap population APIs
  mm/sparse: Decouple section activation from ZONE_DEVICE
  mm: Redefine HVO as Hugepage Vmemmap Optimization
  mm/sparse-vmemmap: Consolidate HVO enable checks
  mm/hugetlb: Make HVO optimizable checks depend on generic logic
  mm/sparse-vmemmap: Localize init_compound_tail()
  mm/mm_init: Check zone consistency on optimized vmemmap sections
  mm/hugetlb: Drop boot-time HVO handling for gigantic folios
  mm/hugetlb: Simplify hugetlb_folio_init_vmemmap()
  mm/hugetlb: Initialize the full bootmem hugepage in hugetlb code
  mm/mm_init: Factor out compound page initialization
  mm/mm_init: Make __init_single_page() static
  mm/cma: Move CMA pageblock initialization into cma_activate_area()
  mm/cma: Move init_cma_pageblock() into cma.c
  mm/mm_init: Initialize pageblock migratetype in memmap init helpers
  Documentation/mm: Rewrite vmemmap_dedup.rst for unified HVO

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/admin-guide/mm/hugetlbpage.rst  |   4 +-
 .../admin-guide/mm/memory-hotplug.rst         |   2 +-
 Documentation/admin-guide/sysctl/vm.rst       |   3 +-
 Documentation/arch/powerpc/index.rst          |   1 -
 Documentation/arch/powerpc/vmemmap_dedup.rst  | 101 ----
 Documentation/mm/vmemmap_dedup.rst            | 217 ++------
 arch/arm64/mm/mmu.c                           |   5 +-
 arch/loongarch/mm/init.c                      |   5 +-
 arch/powerpc/include/asm/book3s/64/radix.h    |  12 -
 arch/powerpc/mm/book3s64/radix_pgtable.c      | 154 +-----
 arch/powerpc/mm/hugetlbpage.c                 |  11 +-
 arch/powerpc/mm/init_64.c                     |   1 +
 arch/powerpc/mm/mem.c                         |   5 +-
 arch/riscv/mm/init.c                          |   5 +-
 arch/s390/mm/init.c                           |   5 +-
 arch/x86/Kconfig                              |   1 -
 arch/x86/entry/vdso/vdso32/fake_32bit_build.h |   1 -
 arch/x86/mm/init_64.c                         |   5 +-
 drivers/dax/Kconfig                           |   1 +
 fs/Kconfig                                    |   6 +-
 include/linux/hugetlb.h                       |  23 +-
 include/linux/memory_hotplug.h                |  12 +-
 include/linux/mm.h                            |  44 +-
 include/linux/mm_types.h                      |   3 +-
 include/linux/mmzone.h                        | 151 ++++--
 include/linux/page-flags-layout.h             |   2 +
 include/linux/page-flags.h                    |  31 +-
 kernel/bounds.c                               |   5 +
 mm/Kconfig                                    |   9 +-
 mm/bootmem_info.c                             |   5 +-
 mm/cma.c                                      |  18 +-
 mm/hugetlb.c                                  | 337 ++++--------
 mm/hugetlb_cma.c                              |  41 +-
 mm/hugetlb_cma.h                              |   4 +-
 mm/hugetlb_vmemmap.c                          | 266 +--------
 mm/hugetlb_vmemmap.h                          |  64 +--
 mm/internal.h                                 |  72 ++-
 mm/memory-failure.c                           |   6 +-
 mm/memory_hotplug.c                           |  22 +-
 mm/memremap.c                                 |   4 +-
 mm/mm_init.c                                  | 241 ++++-----
 mm/sparse-vmemmap.c                           | 511 ++++++------------
 mm/sparse.c                                   | 129 +----
 mm/util.c                                     |   2 +-
 scripts/gdb/linux/mm.py                       |   6 +-
 46 files changed, 743 insertions(+), 1812 deletions(-)
 delete mode 100644 Documentation/arch/powerpc/vmemmap_dedup.rst


base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
-- 
2.54.0


