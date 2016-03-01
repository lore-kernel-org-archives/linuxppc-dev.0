Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E4A061A0B5B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 18:29:59 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Mar 2016 00:29:57 -0700
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 3F2FD1FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 00:17:46 -0700 (MST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u217TaeN27525132
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 07:29:36 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u217TZJ8030500
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 02:29:35 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 0/8] BOOk3s 64 MMU code cleanup
Date: Tue,  1 Mar 2016 12:59:16 +0530
Message-Id: <1456817364-3329-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series include changes that should help in implementing
radix MMU model. Besides that, we also try to consolidate
hash64 code into separate files wherever it simplifies
the existing code by removing #ifdef around C code. IMHO
code movement also helps in indicating supported features
on different platforms better. (Changes like moving THP to hash64
indicates that for now we only have THP implemented for hash64).

The series is on top of changes posted at 

http://mid.gmane.org/1456805714-21774-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com

Aneesh Kumar K.V (8):
  powerp/mm: Update code comments
  powerpc/mm: add _PAGE_HASHPTE similar to 4K hash
  powerpc/mm: Use flush_tlb_page in ptep_clear_flush_young
  powerpc/mm: Move hash related mmu-*.h headers to book3s/
  powerpc/mm: Create a new headers for tlbflush for hash64
  powerpc/mm: Move hash page table related functions to pgtable-hash64.c
  powerpc/mm: THP is only available on hash64 as of now
  powerpc/mm: Use generic version of pmdp_clear_flush_young

 .../asm/{mmu-hash32.h => book3s/32/mmu-hash.h}     |   0
 arch/powerpc/include/asm/book3s/64/hash.h          |  47 +-
 .../asm/{mmu-hash64.h => book3s/64/mmu-hash.h}     |   0
 arch/powerpc/include/asm/book3s/64/pgtable.h       |  26 +-
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h |  94 ++++
 arch/powerpc/include/asm/mmu.h                     |   4 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h       |   3 +
 arch/powerpc/include/asm/tlbflush.h                |  92 +--
 arch/powerpc/kernel/cpu_setup_power.S              |   2 +-
 arch/powerpc/kernel/idle_power7.S                  |   2 +-
 arch/powerpc/kvm/book3s_32_mmu_host.c              |   2 +-
 arch/powerpc/kvm/book3s_64_mmu.c                   |   2 +-
 arch/powerpc/kvm/book3s_64_mmu_host.c              |   2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |   2 +-
 arch/powerpc/kvm/book3s_64_vio.c                   |   2 +-
 arch/powerpc/kvm/book3s_64_vio_hv.c                |   2 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                |   2 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |   2 +-
 arch/powerpc/mm/Makefile                           |   3 +-
 arch/powerpc/mm/hash64_4k.c                        |   4 +-
 arch/powerpc/mm/hash64_64k.c                       |   4 +-
 arch/powerpc/mm/init_64.c                          | 114 +---
 arch/powerpc/mm/mem.c                              |  29 +-
 arch/powerpc/mm/mmu_decl.h                         |   5 -
 arch/powerpc/mm/pgtable-book3e.c                   | 163 ++++++
 arch/powerpc/mm/pgtable-hash64.c                   | 614 +++++++++++++++++++++
 arch/powerpc/mm/pgtable.c                          |   9 +
 arch/powerpc/mm/pgtable_64.c                       | 461 ----------------
 arch/powerpc/mm/ppc_mmu_32.c                       |  30 +
 29 files changed, 973 insertions(+), 749 deletions(-)
 rename arch/powerpc/include/asm/{mmu-hash32.h => book3s/32/mmu-hash.h} (100%)
 rename arch/powerpc/include/asm/{mmu-hash64.h => book3s/64/mmu-hash.h} (100%)
 create mode 100644 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
 create mode 100644 arch/powerpc/mm/pgtable-book3e.c
 create mode 100644 arch/powerpc/mm/pgtable-hash64.c

-- 
2.5.0
