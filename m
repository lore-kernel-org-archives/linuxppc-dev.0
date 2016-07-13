Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqDKW2JyYzDqSW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 19:38:23 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D9YDj6008520
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:38:21 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452ypda1m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:38:21 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 03:38:20 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH for-4.8_set3 00/10] Use jump label for cpu/mmu_has_feature
Date: Wed, 13 Jul 2016 15:08:00 +0530
Message-Id: <1468402690-5373-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I have converted the usage of cpu/mmu_has_feature in __init functions
to use the non jump label variant. Even though some of them happen
after featurefix, I guess it is better to have a simpler rule such
that we use __cpu/mmu_has_feature in __init functions and the jump
label variant otherwise.


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
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  2 +-
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
 arch/powerpc/kernel/setup-common.c            |  7 +--
 arch/powerpc/kernel/setup_32.c                | 23 +++++++---
 arch/powerpc/kernel/setup_64.c                | 20 ++++++---
 arch/powerpc/kernel/smp.c                     |  3 +-
 arch/powerpc/kvm/book3s_hv_builtin.c          |  2 +-
 arch/powerpc/mm/44x_mmu.c                     |  6 +--
 arch/powerpc/mm/hash_native_64.c              |  2 +-
 arch/powerpc/mm/hash_utils_64.c               | 12 +++---
 arch/powerpc/mm/hugetlbpage.c                 |  2 +-
 arch/powerpc/mm/mmu_context_nohash.c          |  4 +-
 arch/powerpc/mm/pgtable-hash64.c              |  2 +-
 arch/powerpc/mm/pgtable-radix.c               | 23 +++++++++-
 arch/powerpc/mm/ppc_mmu_32.c                  |  2 +-
 arch/powerpc/platforms/44x/iss4xx.c           |  2 +-
 arch/powerpc/platforms/44x/ppc476.c           |  2 +-
 arch/powerpc/platforms/85xx/smp.c             |  6 +--
 arch/powerpc/platforms/cell/pervasive.c       |  3 +-
 arch/powerpc/platforms/cell/smp.c             |  2 +-
 arch/powerpc/platforms/powermac/setup.c       |  2 +-
 arch/powerpc/platforms/powermac/smp.c         |  4 +-
 arch/powerpc/platforms/powernv/setup.c        |  2 +-
 arch/powerpc/platforms/powernv/smp.c          |  4 +-
 arch/powerpc/platforms/powernv/subcore.c      |  2 +-
 arch/powerpc/platforms/pseries/lpar.c         |  4 +-
 arch/powerpc/platforms/pseries/smp.c          |  6 +--
 arch/powerpc/xmon/ppc-dis.c                   |  2 +
 kernel/jump_label.c                           |  3 ++
 47 files changed, 296 insertions(+), 82 deletions(-)
 create mode 100644 arch/powerpc/include/asm/cpufeatures.h

-- 
2.7.4
