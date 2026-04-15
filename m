Return-Path: <linuxppc-dev+bounces-19770-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E2DF4198B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 11:23:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwf086bzrz2yvL;
	Wed, 15 Apr 2026 21:23:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.181
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776252200;
	cv=none; b=TA0IIYp1r/SThqTqsxG19X0lxZqlCM4X5AMCqryddjz23ml1+oeJGhReOdhDbayxLOPMYoMIpD6eeAxRsqz+oJGf1c+O7xatDWqlRiuzsfd4LnX8XL5mkNYlMWHPNwltsfB0+iXR33A5qFReJLd8H1Hrm9boMb5z7lwCIOY2qRzUtSnX63Mxp/UgHYh2tl6nHCMcv+YsRZ4EPRvgx45CFNwDV3hoBRDUT/p89+A9Imc19ETAhFn55ee1sY8kN/pnzdAxaG+mwDYuNV+JnHEUsIp1SFh8KPWmwi9P6YpTQcFF9UTXghCUlT1qhiPtH251GOHnKtm6qekdMT6AApbePA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776252200; c=relaxed/relaxed;
	bh=QqCAsAgI0t6/akrOnA6+jyaIV6f8Vm9SfhfdX5V+FDk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Mw4yugEDNeW6a8+B+sSFlFg17BqtNuFfunBwy2X/8CGSbm++9/9XpaiFXq/yExnAdPHh5IE/lJ71QphkRi10Pt2ooDkh0U6+1NKWRSqiKMYwAdugeQnSQlWu0u6pJh6fGt0tFs+88prDqamLqXq6E9wLtMVzDhjVBYfsQyTMJHrrNqc2uoTGDglBJMYOiLH+17RCnaKpdLrwMmEfjI0JG4k352qOiJYcRoDyrm3McHxKORgHqtM/5tZ/RwF8t2Ib+ShfZuvqzmqC9eDjsn92b9cwvJdQ6prBAddMoCPRfqNN/8D7R1Sth7UxtSJJ3CPK3xLmlg60peklkm3iToR3BQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RaGcxQDS; dkim-atps=neutral; spf=pass (client-ip=95.215.58.181; helo=out-181.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RaGcxQDS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.181; helo=out-181.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwf036jkRz2yrM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 21:23:14 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776252173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QqCAsAgI0t6/akrOnA6+jyaIV6f8Vm9SfhfdX5V+FDk=;
	b=RaGcxQDSopj/bba3OgaNovmtsXkk6rePZxmzVbt3nTmIjJUQYozcPGze7Jb32nSgW5f06a
	wZtmqQYFIqXBBvJM91lDyIxSSjFLlHCqf/6G3zPINXJOyYOA6Vsoujg5XI7HuYoQXiaMpw
	gS7OsiK8i7Xsyp/6flz0+QI42Sndqdk=
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 00/49] mm: Generalize vmemmap optimization for DAX and
 HugeTLB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260405125240.2558577-1-songmuchun@bytedance.com>
Date: Wed, 15 Apr 2026 19:22:02 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D9685A9A-9791-4E34-B01B-F9F5F3B28B5D@linux.dev>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
To: Muchun Song <songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Apr 5, 2026, at 20:51, Muchun Song <songmuchun@bytedance.com> =
wrote:
>=20
> Overview:
> This patch series generalizes the HugeTLB Vmemmap Optimization (HVO)
> into a generic vmemmap optimization framework that can be used by both
> HugeTLB and DAX.
>=20
> Background:
> Currently, the vmemmap optimization feature is highly coupled with
> HugeTLB. However, DAX also has similar requirements for optimizing =
vmemmap
> pages to save memory. The current implementation has separate vmemmap
> optimization paths for HugeTLB and DAX, leading to duplicated logic,
> complex initialization sequences, and architecture-specific flags.
>=20
> Implementation:
> This series breaks down the optimization into a generic framework:
> - Patch 1-6: Fix bugs related to sparse vmemmap initialization and =
DAX.
> - Patch 7-13: Refactor the existing sparse vmemmap initialization.
> - Patch 14-26: Decouple the vmemmap optimization from HugeTLB and
>  introduce generic optimization macros and functions.
> - Patch 27-39: Switch HugeTLB and DAX to use the generic framework.
> - Patch 40-49: Clean up the old HVO-specific code and simplify it.
>=20
> Benifit:
> - When CONFIG_DEFERRED_STRUCT_PAGE_INIT is disabled, all struct pages
>  utilizing HVO (HugeTLB Vmemmap Optimization) skip initialization in
>  memmap_init, significantly accelerating boot times.
> - All architectures supporting HVO benefit from the optimizations=20
>  provided by SPARSEMEM_VMEMMAP_PREINIT without requiring=20
>  architecture-specific adaptations.
> - Device DAX struct page savings are further improved, saving an=20
>  additional 4KB of struct page memory for every 2MB huge page.
> - Vmemmap tail pages used for Device DAX shared mappings are changed=20=

>  from read-write to read-only, enhancing system security.
> - HugeTLB and Device DAX now share a unified vmemmap optimization=20
>  framework, reducing long-term maintenance overhead.
>=20
> Testing:
> - Verification: Compiled and tested on x86 architecture.

Hi all,

I have factored out all the bug fixes from this patchset into a new,
dedicated series:

=
https://lore.kernel.org/linux-mm/20260415111412.1003526-1-songmuchun@byted=
ance.com/T/#t

Once those fixes are merged, I will follow up with v2 of this series.
Thanks for your patience and feedback!

Thanks,
Muchun

>=20
>=20
> Chengkaitao (1):
>  mm: Convert vmemmap_p?d_populate() to static functions
>=20
> Muchun Song (48):
>  mm/sparse: fix vmemmap accounting imbalance on memory hotplug error
>  mm/sparse: add a @pgmap argument to memory deactivation paths
>  mm/sparse: fix vmemmap page accounting for HVOed DAX
>  mm/sparse: add a @pgmap parameter to arch vmemmap_populate()
>  mm/sparse: fix missing architecture-specific page table sync for HVO
>    DAX
>  mm/mm_init: fix uninitialized pageblock migratetype for ZONE_DEVICE
>    compound pages
>  mm/mm_init: use pageblock_migratetype_init_range() in
>    deferred_free_pages()
>  mm: panic on memory allocation failure in sparse_init_nid()
>  mm: move subsection_map_init() into sparse_init()
>  mm: defer sparse_init() until after zone initialization
>  mm: make set_pageblock_order() static
>  mm: integrate sparse_vmemmap_init_nid_late() into sparse_init_nid()
>  mm/cma: validate hugetlb CMA range by zone at reserve time
>  mm/hugetlb: free cross-zone bootmem gigantic pages after allocation
>  mm/hugetlb: initialize vmemmap optimization in early stage
>  mm: remove sparse_vmemmap_init_nid_late()
>  mm/mm_init: make __init_page_from_nid() static
>  mm/sparse-vmemmap: remove the VMEMMAP_POPULATE_PAGEREF flag
>  mm: rename vmemmap optimization macros to generic names
>  mm/sparse: drop power-of-2 size requirement for struct mem_section
>  mm/sparse: introduce compound page order to mem_section
>  mm/mm_init: skip initializing shared tail pages for compound pages
>  mm/sparse-vmemmap: initialize shared tail vmemmap page upon =
allocation
>  mm/sparse-vmemmap: support vmemmap-optimizable compound page
>    population
>  mm/hugetlb: use generic vmemmap optimization macros
>  mm: call memblocks_present() before HugeTLB initialization
>  mm/hugetlb: switch HugeTLB to use generic vmemmap optimization
>  mm: extract pfn_to_zone() helper
>  mm/sparse-vmemmap: remove unused SPARSEMEM_VMEMMAP_PREINIT feature
>  mm/hugetlb: remove HUGE_BOOTMEM_HVO flag and simplify pre-HVO logic
>  mm/sparse-vmemmap: consolidate shared tail page allocation
>  mm: introduce CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
>  mm/sparse-vmemmap: switch DAX to use generic vmemmap optimization
>  mm/sparse-vmemmap: introduce section zone to struct mem_section
>  powerpc/mm: use generic vmemmap_shared_tail_page() in compound =
vmemmap
>  mm/sparse-vmemmap: unify DAX and HugeTLB vmemmap optimization
>  mm/sparse-vmemmap: remap the shared tail pages as read-only
>  mm/sparse-vmemmap: remove unused ptpfn argument
>  mm/hugetlb_vmemmap: remove vmemmap_wrprotect_hvo() and related code
>  mm/sparse: simplify section_vmemmap_pages()
>  mm/sparse-vmemmap: introduce section_vmemmap_page_structs()
>  powerpc/mm: rely on generic vmemmap_can_optimize() to simplify code
>  mm/sparse-vmemmap: drop ARCH_WANT_OPTIMIZE_DAX_VMEMMAP and simplify
>    checks
>  mm/sparse-vmemmap: drop @pgmap parameter from vmemmap populate APIs
>  mm/sparse: replace pgmap with order and zone in sparse_add_section()
>  mm: redefine HVO as Hugepage Vmemmap Optimization
>  Documentation/mm: restructure vmemmap_dedup.rst to reflect =
generalized
>    HVO
>  mm: consolidate struct page power-of-2 size checks for HVO
>=20
> .../admin-guide/kernel-parameters.txt         |   2 +-
> Documentation/admin-guide/sysctl/vm.rst       |   2 +-
> Documentation/mm/vmemmap_dedup.rst            | 218 ++--------
> arch/powerpc/Kconfig                          |   1 -
> arch/powerpc/include/asm/book3s/64/radix.h    |  12 -
> arch/powerpc/mm/book3s64/radix_pgtable.c      | 114 +----
> arch/powerpc/mm/init_64.c                     |   1 +
> arch/riscv/Kconfig                            |   1 -
> arch/x86/Kconfig                              |   2 -
> fs/Kconfig                                    |   6 +-
> include/linux/hugetlb.h                       |   7 +-
> include/linux/memory_hotplug.h                |   2 +-
> include/linux/mm.h                            |  50 +--
> include/linux/mm_types.h                      |   2 +
> include/linux/mm_types_task.h                 |   4 +
> include/linux/mmzone.h                        | 143 ++++---
> include/linux/page-flags.h                    |  31 +-
> kernel/bounds.c                               |   2 +
> mm/Kconfig                                    |  20 +-
> mm/bootmem_info.c                             |   5 +-
> mm/cma.c                                      |   3 +-
> mm/hugetlb.c                                  | 143 +++----
> mm/hugetlb_cma.c                              |   3 +-
> mm/hugetlb_vmemmap.c                          | 237 +----------
> mm/hugetlb_vmemmap.h                          |  35 +-
> mm/internal.h                                 |  26 +-
> mm/memory_hotplug.c                           |  15 +-
> mm/mm_init.c                                  | 138 +++---
> mm/sparse-vmemmap.c                           | 392 +++++-------------
> mm/sparse.c                                   |  85 ++--
> mm/util.c                                     |   2 +-
> scripts/gdb/linux/mm.py                       |   6 +-
> 32 files changed, 513 insertions(+), 1197 deletions(-)
>=20
> --=20
> 2.20.1
>=20


