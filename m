Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A390D1A074D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 15:15:30 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 29 Feb 2016 21:15:28 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 34EDB3E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 21:15:25 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u214FOWR45219952
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 21:15:24 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u214FNVm010205
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 21:15:24 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 0/4] Add 4 level page table for 64k book3s config
Date: Tue,  1 Mar 2016 09:45:10 +0530
Message-Id: <1456805714-21774-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series move book3s config with 64k linux page size to a 4 level
linux page table setup. This makes it similar to PowerISA 3.0 radix
setup which inturn will enable us to support both hash and radix
MMU model using single kernel.


Aneesh Kumar K.V (3):
  powerpc/mm: Split pgtable types to separate header
  powerpc/mm: Don't have conditional defines for real_pte_t
  powerpc/mm: Switch book3s 64 with 64K page size to 4 level page table

Kirill A. Shutemov (1):
  mm: Some arch may want to use HPAGE_PMD related values as variables

 arch/powerpc/Kconfig                          |   1 +
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  33 +-------
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  31 ++++----
 arch/powerpc/include/asm/book3s/64/hash.h     |  11 +++
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  30 ++++++--
 arch/powerpc/include/asm/page.h               | 104 +-------------------------
 arch/powerpc/include/asm/pgalloc-64.h         |  28 ++++++-
 arch/powerpc/include/asm/pgtable-types.h      | 103 +++++++++++++++++++++++++
 arch/powerpc/mm/init_64.c                     |  21 ++++--
 arch/powerpc/mm/pgtable_64.c                  |   7 ++
 include/linux/bug.h                           |   9 +++
 include/linux/huge_mm.h                       |   3 -
 mm/huge_memory.c                              |  17 ++++-
 13 files changed, 227 insertions(+), 171 deletions(-)
 create mode 100644 arch/powerpc/include/asm/pgtable-types.h

-- 
2.5.0
