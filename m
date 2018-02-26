Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqkFp1Z0qzF1DP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 01:08:45 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1QE6mgo068278
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 09:08:43 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gcf9nuenn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 09:08:42 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 26 Feb 2018 09:08:41 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 0/4] Add support for 4PB virtual address space on hash
Date: Mon, 26 Feb 2018 19:38:22 +0530
Message-Id: <20180226140826.11641-1-aneesh.kumar@linux.vnet.ibm.com>
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


Aneesh Kumar K.V (4):
  powerpc/mm/slice: Update documentation in the file.
  powerpc/mm/slice: Reduce the stack usage in slice_get_unmapped_area
  powerpc/mm: Add support for handling > 512TB address in SLB miss
  powerpc/mm/hash64: Increase the VA range

 arch/powerpc/include/asm/book3s/64/hash-4k.h  |   6 ++
 arch/powerpc/include/asm/book3s/64/hash-64k.h |   7 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |   6 +-
 arch/powerpc/include/asm/book3s/64/mmu.h      |  24 +++++
 arch/powerpc/include/asm/processor.h          |  16 ++-
 arch/powerpc/kernel/exceptions-64s.S          |  12 ++-
 arch/powerpc/mm/copro_fault.c                 |   2 +-
 arch/powerpc/mm/hash_utils_64.c               |   4 +-
 arch/powerpc/mm/init_64.c                     |   6 --
 arch/powerpc/mm/mmu_context_book3s64.c        |  17 ++-
 arch/powerpc/mm/pgtable-hash64.c              |   2 +-
 arch/powerpc/mm/pgtable_64.c                  |   5 -
 arch/powerpc/mm/slb.c                         | 150 ++++++++++++++++++++++++++
 arch/powerpc/mm/slb_low.S                     |   6 +-
 arch/powerpc/mm/slice.c                       |  61 ++++++-----
 arch/powerpc/mm/tlb_hash64.c                  |   2 +-
 16 files changed, 273 insertions(+), 53 deletions(-)

-- 
2.14.3
