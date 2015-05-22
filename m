Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 771D71A0BE8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2015 15:18:44 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 22 May 2015 15:18:42 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4A3F2357804C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2015 15:18:38 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4M5IUCp27263204
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2015 15:18:38 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4M5I4n2023216
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2015 15:18:05 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, schwidefsky@de.ibm.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V6 0/3] THP related code cleanup
Date: Fri, 22 May 2015 10:47:29 +0530
Message-Id: <1432271852-12949-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changes from v5:
* Fix build failure on x86 with thp enabled.
* Tested on x86_64, ppc64.

Aneesh Kumar K.V (3):
  mm/thp: Split out pmd collpase flush into a separate functions
  powerpc/mm: Use generic version of pmdp_clear_flush
  mm: Clarify that the function operates on hugepage pte

 arch/mips/include/asm/pgtable.h          |  8 ++--
 arch/powerpc/include/asm/pgtable-ppc64.h | 14 +++---
 arch/powerpc/mm/pgtable_64.c             | 73 +++++++++++++++-----------------
 arch/s390/include/asm/pgtable.h          | 30 ++++++++-----
 arch/sparc/include/asm/pgtable_64.h      |  8 ++--
 arch/tile/include/asm/pgtable.h          |  8 ++--
 arch/x86/include/asm/pgtable.h           |  4 +-
 include/asm-generic/pgtable.h            | 34 +++++++++++----
 include/linux/mmu_notifier.h             | 12 +++---
 mm/huge_memory.c                         | 18 ++++----
 mm/migrate.c                             |  2 +-
 mm/pgtable-generic.c                     | 29 +++++++++++--
 mm/rmap.c                                |  2 +-
 13 files changed, 141 insertions(+), 101 deletions(-)

-- 
2.1.4
