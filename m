Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zx1G34bHBzF1dG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 15:42:19 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w274clBc058133
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Mar 2018 23:42:16 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gj4mm8tdw-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 23:42:16 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 6 Mar 2018 21:42:15 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V3 0/3] Add support for 4PB virtual address space on hash
Date: Wed,  7 Mar 2018 10:12:01 +0530
Message-Id: <20180307044204.8904-1-aneesh.kumar@linux.vnet.ibm.com>
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

Changes from V2:
* Rebased on top of slice_mask series from Nick Piggin
* Fixed segfault when mmap with 512TB hint address

Aneesh Kumar K.V (3):
  powerpc/mm: Add support for handling > 512TB address in SLB miss
  powerpc/mm/hash64: Increase the VA range
  powerpc/mm/hash: Don't memset pgd table if not needed

 arch/powerpc/include/asm/book3s/64/hash-4k.h  |   6 ++
 arch/powerpc/include/asm/book3s/64/hash-64k.h |   7 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |   6 +-
 arch/powerpc/include/asm/book3s/64/mmu.h      |  24 +++++
 arch/powerpc/include/asm/book3s/64/pgalloc.h  |  13 ++-
 arch/powerpc/include/asm/processor.h          |  16 ++-
 arch/powerpc/kernel/exceptions-64s.S          |  12 ++-
 arch/powerpc/mm/copro_fault.c                 |   2 +-
 arch/powerpc/mm/hash_utils_64.c               |   4 +-
 arch/powerpc/mm/init_64.c                     |   6 --
 arch/powerpc/mm/mmu_context_book3s64.c        |  17 ++-
 arch/powerpc/mm/pgtable-hash64.c              |   2 +-
 arch/powerpc/mm/pgtable_64.c                  |   5 -
 arch/powerpc/mm/slb.c                         | 146 ++++++++++++++++++++++++++
 arch/powerpc/mm/slb_low.S                     |   6 +-
 arch/powerpc/mm/tlb_hash64.c                  |   2 +-
 16 files changed, 245 insertions(+), 29 deletions(-)

-- 
2.14.3
