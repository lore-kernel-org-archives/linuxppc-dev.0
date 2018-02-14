Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhLQ95mGqzF1GY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 00:50:25 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1EDmnDC066836
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 08:50:22 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g4k23gv20-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 08:50:21 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 14 Feb 2018 08:50:20 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 0/6] powerpc/mm/book3s64: Support for split pmd ptlock
Date: Wed, 14 Feb 2018 19:20:03 +0530
Message-Id: <20180214135009.32748-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series add split pmd pagetable lock for book3s64. nohash64 also should
be able to switch to this. I need to workout the code dependency. This series
also migh have broken the build on platforms otherthan book3s64. I am sending this early
to get feedback on whether we should continue with the approach.

We switch the pmd allocator to use something similar to what we already use for
level 4 pagetable allocation. We get an order 0 page and divide that to fragments
and hand over fragments when we get request for a pmd pagetable. The pmd lock is
now stashed in the struct page backing the allocated page.

The series should help in reducing lock contention on mm->page_table_lock.

Aneesh Kumar K.V (6):
  powerpc/mm: Rename pte fragment functions
  powerpc/mm/4k: Switch 4k pagesize config to use pagetable fragment
  powerpc/mm: Implement helpers for pagetable fragment support at PMD
    level
  powerpc/mm: Simplify the rcu callback for page table free
  powerpc/mm: Use page fragments for allocation page table at PMD level
  enable split pmd ptlock.

 arch/powerpc/include/asm/book3s/32/pgalloc.h   |   2 +-
 arch/powerpc/include/asm/book3s/64/hash-4k.h   |  10 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h  |   4 +
 arch/powerpc/include/asm/book3s/64/mmu.h       |   7 +-
 arch/powerpc/include/asm/book3s/64/pgalloc.h   |  43 ++------
 arch/powerpc/include/asm/book3s/64/pgtable.h   |   6 ++
 arch/powerpc/include/asm/book3s/64/radix-4k.h  |   8 ++
 arch/powerpc/include/asm/book3s/64/radix-64k.h |   4 +
 arch/powerpc/include/asm/pgalloc.h             |   9 ++
 arch/powerpc/mm/hash_utils_64.c                |   2 +
 arch/powerpc/mm/init-common.c                  |   2 -
 arch/powerpc/mm/mmu_context_book3s64.c         |  39 ++++---
 arch/powerpc/mm/pgtable-radix.c                |   2 +
 arch/powerpc/mm/pgtable_64.c                   | 144 +++++++++++++++++++++----
 arch/powerpc/platforms/Kconfig.cputype         |   4 +
 15 files changed, 209 insertions(+), 77 deletions(-)

-- 
2.14.3
