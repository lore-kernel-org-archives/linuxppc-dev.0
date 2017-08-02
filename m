Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1050.oracle.com (aserp1050.oracle.com [141.146.126.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN4mn0nv5zDqnm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 06:39:36 +1000 (AEST)
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v72KdYvO003060
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 20:39:35 GMT
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 mhocko@kernel.org
Subject: [v4 00/15] complete deferred page initialization
Date: Wed,  2 Aug 2017 16:38:09 -0400
Message-Id: <1501706304-869240-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changelog:
v3 - v2
- Rewrote code to zero sturct pages in __init_single_page() as
  suggested by Michal Hocko
- Added code to handle issues related to accessing struct page
  memory before they are initialized.

v2 - v3
- Addressed David Miller comments about one change per patch:
    * Splited changes to platforms into 4 patches
    * Made "do not zero vmemmap_buf" as a separate patch

v1 - v2
- Per request, added s390 to deferred "struct page" zeroing
- Collected performance data on x86 which proofs the importance to
  keep memset() as prefetch (see below).

SMP machines can benefit from the DEFERRED_STRUCT_PAGE_INIT config option,
which defers initializing struct pages until all cpus have been started so
it can be done in parallel.

However, this feature is sub-optimal, because the deferred page
initialization code expects that the struct pages have already been zeroed,
and the zeroing is done early in boot with a single thread only.  Also, we
access that memory and set flags before struct pages are initialized. All
of this is fixed in this patchset.

In this work we do the following:
- Never read access struct page until it was initialized
- Never set any fields in struct pages before they are initialized
- Zero struct page at the beginning of struct page initialization

Performance improvements on x86 machine with 8 nodes:
Intel(R) Xeon(R) CPU E7-8895 v3 @ 2.60GHz

Single threaded struct page init: 7.6s/T improvement
Deferred struct page init: 10.2s/T improvement

Pavel Tatashin (15):
  x86/mm: reserve only exiting low pages
  x86/mm: setting fields in deferred pages
  sparc64/mm: setting fields in deferred pages
  mm: discard memblock data later
  mm: don't accessed uninitialized struct pages
  sparc64: simplify vmemmap_populate
  mm: defining memblock_virt_alloc_try_nid_raw
  mm: zero struct pages during initialization
  sparc64: optimized struct page zeroing
  x86/kasan: explicitly zero kasan shadow memory
  arm64/kasan: explicitly zero kasan shadow memory
  mm: explicitly zero pagetable memory
  mm: stop zeroing memory during allocation in vmemmap
  mm: optimize early system hash allocations
  mm: debug for raw alloctor

 arch/arm64/mm/kasan_init.c          |  32 ++++++++
 arch/sparc/include/asm/pgtable_64.h |  18 +++++
 arch/sparc/mm/init_64.c             |  31 +++-----
 arch/x86/kernel/setup.c             |   5 +-
 arch/x86/mm/init_64.c               |   9 ++-
 arch/x86/mm/kasan_init_64.c         |  29 +++++++
 include/linux/bootmem.h             |  11 +++
 include/linux/memblock.h            |  10 ++-
 include/linux/mm.h                  |   9 +++
 mm/memblock.c                       | 152 ++++++++++++++++++++++++++++--------
 mm/nobootmem.c                      |  16 ----
 mm/page_alloc.c                     |  29 ++++---
 mm/sparse-vmemmap.c                 |  10 ++-
 mm/sparse.c                         |   6 +-
 14 files changed, 279 insertions(+), 88 deletions(-)

--
2.13.3
