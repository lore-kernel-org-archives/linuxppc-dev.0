Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408qWl6CntzF1vP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 21:05:06 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2Q9xasN052153
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 06:05:04 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gxttatr43-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 06:05:04 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 26 Mar 2018 06:05:02 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V6 0/4] Add support for 4PB virtual address space on hash
Date: Mon, 26 Mar 2018 15:34:46 +0530
Message-Id: <20180326100450.18614-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series extended the max virtual address space value from 512TB
to 4PB with 64K page size. We do that by allocating one vsid context for
each 512TB range. More details of that is explained in patch 3.

Changes from V5:
* Fix for loop segmentation fault.
* updates from Michael

Changes from V4:
* Move context allocation to mmap time instead of SLB miss time
* Address review comments 

Changes from V3:
* move extended_id to be a union with mm_context_t id. This reduce some
 array index complexity.
* Add addr_limit check when handling slb miss for extended context

Changes from V2:
* Rebased on top of slice_mask series from Nick Piggin
* Fixed segfault when mmap with 512TB hint address


Aneesh Kumar K.V (4):
  powerpc/mm/slice: Consolidate return path in slice_get_unmapped_area()
  powerpc/mm: Add support for handling > 512TB address in SLB miss
  powerpc/mm/hash64: Increase the VA range
  powerpc/mm/hash: Don't memset pgd table if not needed

 arch/powerpc/include/asm/book3s/64/hash-4k.h  |   6 ++
 arch/powerpc/include/asm/book3s/64/hash-64k.h |   8 +-
 arch/powerpc/include/asm/book3s/64/mmu.h      |  33 +++++++-
 arch/powerpc/include/asm/book3s/64/pgalloc.h  |  12 ++-
 arch/powerpc/include/asm/mmu_context.h        |  39 ++++++++++
 arch/powerpc/include/asm/processor.h          |  15 +++-
 arch/powerpc/kernel/exceptions-64s.S          |  11 ++-
 arch/powerpc/kernel/traps.c                   |  12 ---
 arch/powerpc/mm/copro_fault.c                 |   2 +-
 arch/powerpc/mm/hash_utils_64.c               |   4 +-
 arch/powerpc/mm/init_64.c                     |   6 --
 arch/powerpc/mm/mmu_context_book3s64.c        |  15 +++-
 arch/powerpc/mm/pgtable-hash64.c              |   6 +-
 arch/powerpc/mm/pgtable_64.c                  |   5 --
 arch/powerpc/mm/slb.c                         | 108 ++++++++++++++++++++++++++
 arch/powerpc/mm/slb_low.S                     |  11 ++-
 arch/powerpc/mm/slice.c                       |  49 ++++++++----
 arch/powerpc/mm/tlb_hash64.c                  |   2 +-
 18 files changed, 288 insertions(+), 56 deletions(-)

-- 
2.14.3
