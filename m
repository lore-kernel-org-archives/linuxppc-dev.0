Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqDGW3wblzDqPK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 19:35:47 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D9YDvA033188
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:35:45 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24566wwn3u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:35:44 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 03:35:44 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH for-4.8_set1 00/12] Radix fixes for 4.8
Date: Wed, 13 Jul 2016 15:05:19 +0530
Message-Id: <1468402531-4914-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This series include cleanup and fixes for radix MMU mode. I also added a
patch that provides a kernel command line option to disable radix.

Aneesh Kumar K.V (11):
  powerpc/mm/radix: Update LPCR HR bit as per ISA
  powerpc/mm: use _raw variant of page table accessors
  powerpc/mm: Compile out radix related functions if RADIX_MMU is
    disabled
  powerpc/mm: Clear top 16 bits of va only on older cpus
  powerpc/mm: Print formation regarding the the MMU mode
  powerpc/mm/hash: Update SDR1 size encoding as documented in ISA 3.0
  powerpc/mm/radix: Update PID switch sequence
  powerpc/mm/radix: Update machine call back to support new HCALL.
  powerpc/mm/radix: Add LPID based tlb flush helpers
  powerpc/mm: Cleanup LPCR defines
  powerpc/mm/radix: Add a kernel command line to disable radix

Balbir Singh (1):
  Fix .long's in mm/tlb-radix.c to more meaningful

 Documentation/kernel-parameters.txt                |  3 +
 arch/powerpc/include/asm/book3s/64/mmu.h           |  5 ++
 arch/powerpc/include/asm/book3s/64/pgtable-4k.h    |  6 +-
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h   |  6 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       | 99 +++++++++++++++-------
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  4 +-
 arch/powerpc/include/asm/machdep.h                 |  3 +-
 arch/powerpc/include/asm/mmu.h                     |  9 +-
 arch/powerpc/include/asm/pgtable-be-types.h        | 15 ++++
 arch/powerpc/include/asm/ppc-opcode.h              | 17 ++++
 arch/powerpc/include/asm/reg.h                     | 55 ++++++------
 arch/powerpc/kernel/cputable.c                     |  4 +-
 arch/powerpc/kernel/prom.c                         | 13 +++
 arch/powerpc/mm/hash_native_64.c                   | 16 +++-
 arch/powerpc/mm/hash_utils_64.c                    | 12 +--
 arch/powerpc/mm/mmu_context_book3s64.c             |  5 +-
 arch/powerpc/mm/pgtable-radix.c                    | 16 ++--
 arch/powerpc/mm/tlb-radix.c                        | 65 ++++++++++++--
 18 files changed, 260 insertions(+), 93 deletions(-)

-- 
2.7.4
