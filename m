Return-Path: <linuxppc-dev+bounces-19330-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBE1F3D5E1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:53:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXSm73dHz2ybQ;
	Sun, 05 Apr 2026 22:53:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393608;
	cv=none; b=BmUyxkFeW2X871hg3bbPauBipnO4XaeXQVYU09TgWHA77zoZa7v4DY2j/EEUYanHiEvP2FsL7SxBbQL025WrfEsdliOkxfjXch+H6EXnNTx5NusHa/VE/faTITEHeffsRGS+Fb4RntiGqnDYTxqGCku3+Gz3uIiHWB/aP9NzDZ+O+VObPE5WhtxGArr7kImUcD+7Rdqn47WhZbjRGf4NkuRPWQGtNy00ev7hNxUHZOr+DQPNAal6SflGHUZAE9+E+7nfrBpIoMSno7DjhpsAKjGhQXhyoBmXcNyl2rWvwou/uV/aVIYimrUkFBahiJuO0Yvht6UoL8ZR7bUl+K1VkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393608; c=relaxed/relaxed;
	bh=vIYRrJ1FD8xk10dmqDqll/GEWBWA7JriVZCvyhEOAJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iq0R5OHbuQfFthWAVQYsQLi5GenWLXZ572vOt+lg3YUs8LAlVvyCYQaehe6BiFRexjP39KeUYMIjq+jXaY298PpIxJn0qwUCGz5ZiTblGZvOx54t4+e4ptFVln1UPiGTTFYKFG0edGItvk4HLm20O6B1b6hy4tAYvx1BUjvoJyUCeZpRYR5WkhYN6ZorRwoXSbi/o5Yb7kXtTQEsHkCvjVCGfGT+yjuFcsxRMcMeX6q4xUt9aoEs+n8sGpPrEP76bJ40BOknXkyxeEwhIuPv0J05tTutT0b8qKJFpKOBrlv2U5TgtvBewSKdV7TRG1e+26Ew5GAhhrVs3ty6tUyZ3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=NTePTrAR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=NTePTrAR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXSk5blrz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:53:23 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso1813051a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393602; x=1775998402; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vIYRrJ1FD8xk10dmqDqll/GEWBWA7JriVZCvyhEOAJE=;
        b=NTePTrARQ+mCNPs/p2PXVdnlYyfEEowgpBkBcjPOwaQtS7BevWtH0ye5foaugpIVu7
         vkdYqMZNWSwnLLOhrMKfZbGtLTMO3lCL3p4OUnffEyl8e+W98UecA5grSiMKRaH/8m4Y
         y/oqCaTNWwnMy3ouU30hkReLB8Da5cQg8vItGS0B2u9pkeqjepg27pttX6m0Pu9ahmQa
         M5FIgtJAPUPo0327VOLig8mIoIVUDkCcWM32mZ20lWAMCHUkS/F1OFiDkDJbETOxVelP
         7kls81WqnvBpb0RPNkc7Dt5P0VQDCSlP7Z0PZW24Fjr4UioNcmi/7EWMMV+8Iu8XpG5R
         peHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393602; x=1775998402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIYRrJ1FD8xk10dmqDqll/GEWBWA7JriVZCvyhEOAJE=;
        b=LFmtDnf1iQLKIr6suaFHz4OzCib6VKr3/D+rbjq0lkawJWt311W0RMPEY/S3l6Gz8U
         eWudNcRh0iqtnV0MfoV9fod9nkuGxj08ZekEBjRlj5IvGSOkWhK9IjuIdXqUbJ1LdMfN
         X28LG6TbAUMhNZCHwveWamiOsfW1NoZyYk/ai8/i27wdf/BK/C/VAaTh6WERPToxRfmp
         Cs409q44oz64Wf9w16yL3vD79kWFyJYeevniXBo2CJNvLqeB542nDGJKP1nlKc6AwfWV
         fVXzEmzR7ffGKPIu2X5MZYzgQlBMSWotENUPq4G2xJO+VA+66mhMXvS10hOYTP20Uw6/
         u9Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXl8BbqWMMJUmVZMvq5gN9W/q7oxVoOSi+80TMYXah2yPJ1rCNWhpDgSW+qFE2dMi8I3zfLhikH3SbF82g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywt5mL59rETwE55AeQ2rUuOAlqoJIHN69rbilWs/iNM6hwHD02p
	gf36buKQPmlE/hM4Sj4JxfI/fNli+JaWSE7QnLBCpSD85QxD/hyz+QIwkX98f8Vtx6U=
X-Gm-Gg: AeBDietj4cLtENlN9YEdAMGOf5abVuHEE6V3hfQsYeI3vcGKB1YXH09r5NFYFMCvlJX
	WEwwgeweaCAvkCKUNoDAoNXqRo7tEYSA3t7JPxBCQGRqFV49AxQGWu5wKpQ7FA5rN1aL+Xml2v2
	TITrhCv1yD/cbbkv8puK2UR8h1j0y9U5ZUqUeZRA1DLiKeADkcFV3mKyVAV4BbEHXuzZmdssOj+
	HL8Ms1BT9nxVFRJs43xsLVbHoLeWBy9BLvV5fLhxXe9w7qrbkZ2TaglDUH/TaM1nneOU/64mE29
	eMB5wKs+azYOp5dZ8ZlbFUhGVC4dcRCai5U1JEm1CfkoBKK/zutHmVJ04H8Ya0z9ZpSzbt1x2jq
	s6t+1wLLqRt4Uu4WWeL1xKtEhg6oQLR6onJEX0qtt/YA7zI7ics2rRK+64gJSW3+eCYJqiLc065
	OmA4+sY2HgJwVoxTvn/Fbad9soay/plj4MpM7gaqRZCYO+HjVR5SzNAQ==
X-Received: by 2002:a17:90b:1e0f:b0:35b:e4f8:7cb0 with SMTP id 98e67ed59e1d1-35de691ad72mr8772276a91.21.1775393601639;
        Sun, 05 Apr 2026 05:53:21 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:53:21 -0700 (PDT)
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
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 00/49] mm: Generalize vmemmap optimization for DAX and HugeTLB
Date: Sun,  5 Apr 2026 20:51:51 +0800
Message-Id: <20260405125240.2558577-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
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

Overview:
This patch series generalizes the HugeTLB Vmemmap Optimization (HVO)
into a generic vmemmap optimization framework that can be used by both
HugeTLB and DAX.

Background:
Currently, the vmemmap optimization feature is highly coupled with
HugeTLB. However, DAX also has similar requirements for optimizing vmemmap
pages to save memory. The current implementation has separate vmemmap
optimization paths for HugeTLB and DAX, leading to duplicated logic,
complex initialization sequences, and architecture-specific flags.

Implementation:
This series breaks down the optimization into a generic framework:
- Patch 1-6: Fix bugs related to sparse vmemmap initialization and DAX.
- Patch 7-13: Refactor the existing sparse vmemmap initialization.
- Patch 14-26: Decouple the vmemmap optimization from HugeTLB and
  introduce generic optimization macros and functions.
- Patch 27-39: Switch HugeTLB and DAX to use the generic framework.
- Patch 40-49: Clean up the old HVO-specific code and simplify it.

Benifit:
- When CONFIG_DEFERRED_STRUCT_PAGE_INIT is disabled, all struct pages
  utilizing HVO (HugeTLB Vmemmap Optimization) skip initialization in
  memmap_init, significantly accelerating boot times.
- All architectures supporting HVO benefit from the optimizations 
  provided by SPARSEMEM_VMEMMAP_PREINIT without requiring 
  architecture-specific adaptations.
- Device DAX struct page savings are further improved, saving an 
  additional 4KB of struct page memory for every 2MB huge page.
- Vmemmap tail pages used for Device DAX shared mappings are changed 
  from read-write to read-only, enhancing system security.
- HugeTLB and Device DAX now share a unified vmemmap optimization 
  framework, reducing long-term maintenance overhead.

Testing:
- Verification: Compiled and tested on x86 architecture.


Chengkaitao (1):
  mm: Convert vmemmap_p?d_populate() to static functions

Muchun Song (48):
  mm/sparse: fix vmemmap accounting imbalance on memory hotplug error
  mm/sparse: add a @pgmap argument to memory deactivation paths
  mm/sparse: fix vmemmap page accounting for HVOed DAX
  mm/sparse: add a @pgmap parameter to arch vmemmap_populate()
  mm/sparse: fix missing architecture-specific page table sync for HVO
    DAX
  mm/mm_init: fix uninitialized pageblock migratetype for ZONE_DEVICE
    compound pages
  mm/mm_init: use pageblock_migratetype_init_range() in
    deferred_free_pages()
  mm: panic on memory allocation failure in sparse_init_nid()
  mm: move subsection_map_init() into sparse_init()
  mm: defer sparse_init() until after zone initialization
  mm: make set_pageblock_order() static
  mm: integrate sparse_vmemmap_init_nid_late() into sparse_init_nid()
  mm/cma: validate hugetlb CMA range by zone at reserve time
  mm/hugetlb: free cross-zone bootmem gigantic pages after allocation
  mm/hugetlb: initialize vmemmap optimization in early stage
  mm: remove sparse_vmemmap_init_nid_late()
  mm/mm_init: make __init_page_from_nid() static
  mm/sparse-vmemmap: remove the VMEMMAP_POPULATE_PAGEREF flag
  mm: rename vmemmap optimization macros to generic names
  mm/sparse: drop power-of-2 size requirement for struct mem_section
  mm/sparse: introduce compound page order to mem_section
  mm/mm_init: skip initializing shared tail pages for compound pages
  mm/sparse-vmemmap: initialize shared tail vmemmap page upon allocation
  mm/sparse-vmemmap: support vmemmap-optimizable compound page
    population
  mm/hugetlb: use generic vmemmap optimization macros
  mm: call memblocks_present() before HugeTLB initialization
  mm/hugetlb: switch HugeTLB to use generic vmemmap optimization
  mm: extract pfn_to_zone() helper
  mm/sparse-vmemmap: remove unused SPARSEMEM_VMEMMAP_PREINIT feature
  mm/hugetlb: remove HUGE_BOOTMEM_HVO flag and simplify pre-HVO logic
  mm/sparse-vmemmap: consolidate shared tail page allocation
  mm: introduce CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
  mm/sparse-vmemmap: switch DAX to use generic vmemmap optimization
  mm/sparse-vmemmap: introduce section zone to struct mem_section
  powerpc/mm: use generic vmemmap_shared_tail_page() in compound vmemmap
  mm/sparse-vmemmap: unify DAX and HugeTLB vmemmap optimization
  mm/sparse-vmemmap: remap the shared tail pages as read-only
  mm/sparse-vmemmap: remove unused ptpfn argument
  mm/hugetlb_vmemmap: remove vmemmap_wrprotect_hvo() and related code
  mm/sparse: simplify section_vmemmap_pages()
  mm/sparse-vmemmap: introduce section_vmemmap_page_structs()
  powerpc/mm: rely on generic vmemmap_can_optimize() to simplify code
  mm/sparse-vmemmap: drop ARCH_WANT_OPTIMIZE_DAX_VMEMMAP and simplify
    checks
  mm/sparse-vmemmap: drop @pgmap parameter from vmemmap populate APIs
  mm/sparse: replace pgmap with order and zone in sparse_add_section()
  mm: redefine HVO as Hugepage Vmemmap Optimization
  Documentation/mm: restructure vmemmap_dedup.rst to reflect generalized
    HVO
  mm: consolidate struct page power-of-2 size checks for HVO

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/admin-guide/sysctl/vm.rst       |   2 +-
 Documentation/mm/vmemmap_dedup.rst            | 218 ++--------
 arch/powerpc/Kconfig                          |   1 -
 arch/powerpc/include/asm/book3s/64/radix.h    |  12 -
 arch/powerpc/mm/book3s64/radix_pgtable.c      | 114 +----
 arch/powerpc/mm/init_64.c                     |   1 +
 arch/riscv/Kconfig                            |   1 -
 arch/x86/Kconfig                              |   2 -
 fs/Kconfig                                    |   6 +-
 include/linux/hugetlb.h                       |   7 +-
 include/linux/memory_hotplug.h                |   2 +-
 include/linux/mm.h                            |  50 +--
 include/linux/mm_types.h                      |   2 +
 include/linux/mm_types_task.h                 |   4 +
 include/linux/mmzone.h                        | 143 ++++---
 include/linux/page-flags.h                    |  31 +-
 kernel/bounds.c                               |   2 +
 mm/Kconfig                                    |  20 +-
 mm/bootmem_info.c                             |   5 +-
 mm/cma.c                                      |   3 +-
 mm/hugetlb.c                                  | 143 +++----
 mm/hugetlb_cma.c                              |   3 +-
 mm/hugetlb_vmemmap.c                          | 237 +----------
 mm/hugetlb_vmemmap.h                          |  35 +-
 mm/internal.h                                 |  26 +-
 mm/memory_hotplug.c                           |  15 +-
 mm/mm_init.c                                  | 138 +++---
 mm/sparse-vmemmap.c                           | 392 +++++-------------
 mm/sparse.c                                   |  85 ++--
 mm/util.c                                     |   2 +-
 scripts/gdb/linux/mm.py                       |   6 +-
 32 files changed, 513 insertions(+), 1197 deletions(-)

-- 
2.20.1


