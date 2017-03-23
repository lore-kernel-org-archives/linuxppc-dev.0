Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vq22R0L9NzDq95
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 09:55:26 +1100 (AEDT)
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.or
Subject: [v1 0/5] parallelized "struct page" zeroing
Date: Thu, 23 Mar 2017 19:01:48 -0400
Message-Id: <1490310113-824438-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When deferred struct page initialization feature is enabled, we get a
performance gain of initializing vmemmap in parallel after other CPUs are
started. However, we still zero the memory for vmemmap using one boot CPU.
This patch-set fixes the memset-zeroing limitation by deferring it as well.

Here is example performance gain on SPARC with 32T:
base
https://hastebin.com/ozanelatat.go

fix
https://hastebin.com/utonawukof.go

As you can see without the fix it takes: 97.89s to boot
With the fix it takes: 46.91 to boot.

On x86 time saving is going to be even greater (proportionally to memory size)
because there are twice as many "struct page"es for the same amount of memory,
as base pages are twice smaller.


Pavel Tatashin (5):
  sparc64: simplify vmemmap_populate
  mm: defining memblock_virt_alloc_try_nid_raw
  mm: add "zero" argument to vmemmap allocators
  mm: zero struct pages during initialization
  mm: teach platforms not to zero struct pages memory

 arch/powerpc/mm/init_64.c |    4 +-
 arch/s390/mm/vmem.c       |    5 ++-
 arch/sparc/mm/init_64.c   |   26 +++++++----------------
 arch/x86/mm/init_64.c     |    3 +-
 include/linux/bootmem.h   |    3 ++
 include/linux/mm.h        |   15 +++++++++++--
 mm/memblock.c             |   46 ++++++++++++++++++++++++++++++++++++------
 mm/page_alloc.c           |    3 ++
 mm/sparse-vmemmap.c       |   48 +++++++++++++++++++++++++++++---------------
 9 files changed, 103 insertions(+), 50 deletions(-)
