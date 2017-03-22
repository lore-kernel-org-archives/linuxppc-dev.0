Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnwNt3GSbzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 14:37:34 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2M3TNCC141942
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 23:37:20 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29b9vmjmv0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 23:37:19 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Mar 2017 21:37:19 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V5 00/17] powerpc/mm/ppc64: Add 128TB support
Date: Wed, 22 Mar 2017 09:06:46 +0530
Message-Id: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series increase the effective virtual address range of
applications from 64TB to 128TB. We do that by supporting a 
68 bit virtual address. On platforms that can only do 65 bit virtual
address we limit the max contexts to a 16bit value instead of 19.

The patch series also switch the page table layout such that we can
do 512TB effective address. Userspace can ask for allocation from
the full 512TB address space by specifying hint address
(with or without MAP_FIXED) above 128TB.


Changes from V4:
* Rebase to latest upstream
* Add support 512TB mmap.

Changes from V3:
* Rebase to latest upstream
* Fixes based on testing

Changes from V2:
* Handle hugepage size correctly.


Aneesh Kumar K.V (17):
  powerpc/mm/slice: Convert slice_mask high slice to a bitmap
  powerpc/mm/slice: Update the function prototype
  powerpc/mm: Move copy_mm_to_paca to paca.c
  powerpc/mm: Remove redundant TASK_SIZE_USER64 checks
  powerpc/mm/slice: Move slice_mask struct definition to slice.c
  powerpc/mm/slice: Update slice mask printing to use bitmap printing.
  powerpc/mm/hash: Move kernel context to the starting of context range
  powerpc/mm/hash: Support 68 bit VA
  powerpc/mm/hash: VSID 0 is no more an invalid VSID
  powerpc/mm/hash: Convert mask to unsigned long
  powerpc/mm/hash: Increase VA range to 128TB
  powerpc/mm/slice: Use mm task_size as max value of slice index
  powerpc/mm/hash: Store task size in PACA
  powerpc/mm/hash: Skip using reserved virtual address range
  powerpc/mm: Switch TASK_SIZE check to use mm->task_size
  mm: Let arch choose the initial value of task size
  powerpc/mm: Enable mappings above 128TB

 arch/powerpc/include/asm/book3s/64/hash-4k.h  |   2 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h |   2 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 178 ++++++++++--------
 arch/powerpc/include/asm/kvm_book3s_64.h      |   2 -
 arch/powerpc/include/asm/mmu.h                |  19 +-
 arch/powerpc/include/asm/mmu_context.h        |   3 +-
 arch/powerpc/include/asm/paca.h               |  22 +--
 arch/powerpc/include/asm/page_64.h            |  14 --
 arch/powerpc/include/asm/processor.h          |  45 ++++-
 arch/powerpc/kernel/asm-offsets.c             |   4 +
 arch/powerpc/kernel/paca.c                    |  21 +++
 arch/powerpc/kernel/setup-common.c            |   9 +
 arch/powerpc/kvm/book3s_64_mmu_host.c         |  10 +-
 arch/powerpc/mm/hash_utils_64.c               |  86 +++++++--
 arch/powerpc/mm/hugetlbpage-radix.c           |  11 +-
 arch/powerpc/mm/init_64.c                     |   4 -
 arch/powerpc/mm/mmap.c                        |  41 +++--
 arch/powerpc/mm/mmu_context_book3s64.c        | 130 ++++++++++---
 arch/powerpc/mm/pgtable-hash64.c              |   1 -
 arch/powerpc/mm/pgtable_64.c                  |   5 -
 arch/powerpc/mm/slb.c                         |   2 +-
 arch/powerpc/mm/slb_low.S                     |  82 ++++++---
 arch/powerpc/mm/slice.c                       | 253 ++++++++++++++++----------
 arch/powerpc/mm/subpage-prot.c                |   3 +-
 arch/powerpc/mm/tlb_hash64.c                  |   1 -
 fs/exec.c                                     |  10 +-
 26 files changed, 631 insertions(+), 329 deletions(-)

-- 
2.7.4
