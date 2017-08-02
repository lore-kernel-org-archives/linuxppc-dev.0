Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMhqd0SLszDrVk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 15:40:44 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v725UPPs134705
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 01:40:42 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c31j9t8fp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 01:40:41 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Aug 2017 23:40:41 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 00/17] Remove slot tracking from linux page table
Date: Wed,  2 Aug 2017 11:09:59 +0530
Message-Id: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This patch series removes hash pte slot tracking in linux page table.
This free up 4 bits from linux page table and brings the hash and radix
linux page table closer. The series also attempt remove __real_pte_t
because without slot tracking 4k subpage and 64k page , pte formats
are similar. 

However not tracking slot implies we search the hash group during invalidate
and updatepp operations. That involves searching max 16 slots to find the
matching hash page table entry. W.r.t subpages, since we don't track the
validity of slots, when invalidating 64K page, we ends up calling invalidate
for all subpages irrespective of whether we have taken a subpage
fault or not.

W.r.t THP, we skip the above and still track slots in level deposited page table.

The patch series do have an impact, hence i am sending this as an RFC series
before doing further measurements with kvm. On baremetal a kernel build gives.

Without patch:
/usr/bin/time -p make  vmlinux modules > /dev/null
real 270.70
user 280.23
sys 57.99

With patch
/usr/bin/time -p make  vmlinux modules > /dev/null
real 272.97
user 281.32
sys 61.46

That is 6% impact on system time:  The real time impact is within the runtime
variance. 

Let me know if you think we should continue with this approach.

-aneesh

Aneesh Kumar K.V (17):
  powerpc/mm: Update native_hpte_find to return hash pte
  powerpc/pseries: Update hpte find helper to take hash value
  powerpc/ps3/mm: Add helper for finding hash pte slot using hash value
  powerpc/mm: Add hash invalidate callback
  powerpc/mm: use hash_invalidate for __kernel_map_pages()
  powerpc/mm: Switch flush_hash_range to not use slot
  powerpc/mm: Add hash updatepp callback
  powerpc/mm/hash: Don't track hash pte slot number in linux page table.
  powerpc/mm: Remove unused flag arg in global_invalidates
  powerpc/mm: Add new firmware feature HASH API
  powerpc/kvm/hash: Implement HASH_REMOVE hcall
  powerpc/kvm/hash: Implement HASH_PROTECT hcall
  powerpc/kvm/hash: Implement HASH_BULK_REMOVE hcall
  powerpc/mm/pseries: Use HASH_PROTECT hcall in guest
  powerpc/mm/pseries: Use HASH_REMOVE hcall in guest
  powerpc/mm/pseries: Move slot based bulk remove to helper
  powerpc/mm/pseries: Use HASH_BULK_REMOVE hcall in guest

 arch/powerpc/include/asm/book3s/64/hash-4k.h       |  16 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h      |  44 +--
 arch/powerpc/include/asm/book3s/64/hash.h          |   5 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      |  12 +
 arch/powerpc/include/asm/book3s/64/pgtable.h       |  26 --
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h |   3 +-
 arch/powerpc/include/asm/firmware.h                |   3 +-
 arch/powerpc/include/asm/hvcall.h                  |   5 +-
 arch/powerpc/include/asm/pgtable-be-types.h        |  10 -
 arch/powerpc/include/asm/pgtable-types.h           |   9 -
 arch/powerpc/include/asm/plpar_wrappers.h          |  23 ++
 arch/powerpc/kvm/book3s_hv.c                       |   3 +
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                | 306 ++++++++++++++++++---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |   4 +
 arch/powerpc/kvm/powerpc.c                         |   4 +
 arch/powerpc/mm/dump_linuxpagetables.c             |  10 -
 arch/powerpc/mm/hash64_4k.c                        |   9 +-
 arch/powerpc/mm/hash64_64k.c                       | 108 ++------
 arch/powerpc/mm/hash_native_64.c                   | 172 ++++++++----
 arch/powerpc/mm/hash_utils_64.c                    |  65 +----
 arch/powerpc/mm/hugetlbpage-hash64.c               |  13 +-
 arch/powerpc/mm/tlb_hash64.c                       |   9 +-
 arch/powerpc/platforms/ps3/htab.c                  |  88 ++++++
 arch/powerpc/platforms/pseries/firmware.c          |   1 +
 arch/powerpc/platforms/pseries/lpar.c              | 193 ++++++++++---
 include/uapi/linux/kvm.h                           |   1 +
 26 files changed, 736 insertions(+), 406 deletions(-)

-- 
2.13.3
