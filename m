Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rxMHg3r4GzDqS6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jul 2016 19:13:03 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6N9A3M8074632
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jul 2016 05:13:01 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24c4etsppk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jul 2016 05:13:00 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 23 Jul 2016 03:13:00 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH for-4.8 V2 00/10] Use jump label for cpu/mmu_has_feature
Date: Sat, 23 Jul 2016 14:42:33 +0530
Message-Id: <1469265163-1491-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changes from V1:
* Update "powerpc/mm: Convert early cpu/mmu feature check to use the new helpers"
  based on resend code changes in this area.

We now do feature fixup early and hence we can reduce the usage of
 __cpu/__mmu_has_feature.

Aneesh Kumar K.V (5):
  powerpc/mm: Add __cpu/__mmu_has_feature
  powerpc/mm: Convert early cpu/mmu feature check to use the new helpers
  powerpc/mm/radix: Add radix_set_pte to use in early init
  powerpc: Call jump_label_init early
  powerpc/mm: Catch the usage of cpu/mmu_has_feature before jump label
    init

Kevin Hao (5):
  jump_label: make it possible for the archs to invoke jump_label_init()
    much earlier
  powerpc: kill mfvtb()
  powerpc: move the cpu_has_feature to a separate file
  powerpc: use the jump label for cpu_has_feature
  powerpc: use jump label for mmu_has_feature

 arch/powerpc/Kconfig.debug                    | 11 +++++
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  5 ++-
 arch/powerpc/include/asm/book3s/64/mmu.h      | 19 ++++++--
 arch/powerpc/include/asm/cacheflush.h         |  1 +
 arch/powerpc/include/asm/cpufeatures.h        | 49 +++++++++++++++++++++
 arch/powerpc/include/asm/cputable.h           | 16 +++----
 arch/powerpc/include/asm/cputime.h            |  1 +
 arch/powerpc/include/asm/dbell.h              |  1 +
 arch/powerpc/include/asm/dcr-native.h         |  1 +
 arch/powerpc/include/asm/mman.h               |  1 +
 arch/powerpc/include/asm/mmu.h                | 62 ++++++++++++++++++++++++++-
 arch/powerpc/include/asm/reg.h                |  9 ----
 arch/powerpc/include/asm/time.h               |  3 +-
 arch/powerpc/include/asm/xor.h                |  1 +
 arch/powerpc/kernel/align.c                   |  1 +
 arch/powerpc/kernel/cputable.c                | 37 ++++++++++++++++
 arch/powerpc/kernel/irq.c                     |  1 +
 arch/powerpc/kernel/paca.c                    |  2 +-
 arch/powerpc/kernel/process.c                 |  3 +-
 arch/powerpc/kernel/setup-common.c            |  1 +
 arch/powerpc/kernel/setup_32.c                |  1 +
 arch/powerpc/kernel/setup_64.c                |  4 +-
 arch/powerpc/kernel/smp.c                     |  1 +
 arch/powerpc/lib/feature-fixups.c             |  8 ++++
 arch/powerpc/mm/hash_native_64.c              |  2 +-
 arch/powerpc/mm/hash_utils_64.c               | 10 ++---
 arch/powerpc/mm/pgtable-radix.c               | 23 +++++++++-
 arch/powerpc/platforms/cell/pervasive.c       |  1 +
 arch/powerpc/xmon/ppc-dis.c                   |  2 +
 kernel/jump_label.c                           |  3 ++
 30 files changed, 243 insertions(+), 37 deletions(-)
 create mode 100644 arch/powerpc/include/asm/cpufeatures.h

-- 
2.7.4
