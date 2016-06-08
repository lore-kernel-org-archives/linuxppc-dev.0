Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPrNG674pzDqs2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 00:26:37 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 10:26:32 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 00/10] Fixes for Radix support
Date: Wed,  8 Jun 2016 19:55:48 +0530
Message-Id: <1465395958-21349-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

This series includes patches I had posted before. I collected them in a series
and marked the series V2. This address the review feedback I received from
last post.


Aneesh Kumar K.V (9):
  powerpc/mm/radix: Update to tlb functions ric argument
  powerpc/mm/radix: Flush page walk cache when freeing page table
  powerpc/mm/radix: Update LPCR HR bit as per ISA
  powerpc/mm: use _raw variant of page table accessors
  powerpc/mm: Compile out radix related functions if RADIX_MMU is
    disabled
  powerpc/hash: Use the correct ppp mask when updating hpte
  powerpc/mm: Clear top 16 bits of va only on older cpus
  powerpc/mm: Print formation regarding the the MMU mode
  powerpc/mm/hash: Update SDR1 size encoding as documented in ISA 3.0

Balbir Singh (1):
  Fix .long's in mm/tlb-radix.c to more meaningful

 arch/powerpc/include/asm/book3s/32/pgalloc.h       |  1 -
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      |  1 +
 arch/powerpc/include/asm/book3s/64/mmu.h           |  5 ++
 arch/powerpc/include/asm/book3s/64/pgalloc.h       | 16 +++-
 arch/powerpc/include/asm/book3s/64/pgtable-4k.h    |  6 +-
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h   |  6 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       | 99 +++++++++++++++-------
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  3 +
 arch/powerpc/include/asm/book3s/64/tlbflush.h      | 15 +++-
 arch/powerpc/include/asm/book3s/pgalloc.h          |  5 --
 arch/powerpc/include/asm/mmu.h                     | 12 ++-
 arch/powerpc/include/asm/pgtable-be-types.h        | 15 ++++
 arch/powerpc/include/asm/ppc-opcode.h              | 14 +++
 arch/powerpc/include/asm/reg.h                     |  1 +
 arch/powerpc/mm/hash_native_64.c                   | 14 +--
 arch/powerpc/mm/hash_utils_64.c                    | 12 +--
 arch/powerpc/mm/pgtable-radix.c                    |  7 +-
 arch/powerpc/mm/tlb-radix.c                        | 94 +++++++++++++-------
 18 files changed, 236 insertions(+), 90 deletions(-)

-- 
2.7.4
