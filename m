Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E43811A03DF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 13:41:29 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 0/9] powerpc/mm: Restructure Linux PTE on Book3S/64 to radix
 format
Date: Mon, 22 Feb 2016 13:41:11 +1100
Message-Id: <1456108880-27464-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series modifies the Linux PTE format used on 64-bit Book3S
processors (i.e. POWER server processors) to make the bits line up
with the PTE format used in the radix trees defined in PowerISA v3.0.
This will reduce the amount of further change required to make a
kernel that can run with either a radix MMU or a hashed page table
(HPT) MMU.

This also changes the upper levels of the tree to use real addresses
rather than kernel virtual addresses - that is, we no longer have the
0xc000... at the top of each PGD/PUD/PMD entry.  Unlike the previous
version of these patches, these patches do not change the format for
the 64-bit embedded processors, only for 64-bit server processors.

The patch series is against v4.5-rc5.

I have compiled this for all the defconfigs in the tree, without
error.  I have tested this, with Aneesh's "powerpc/mm/hash: Clear the
invalid slot information correctly" patch on top, both running
bare-metal on a POWER8 and in a KVM guest on that POWER8 system.  In
the guest I tested both 4k and 64k configs, with THP enabled; in the
host I tested with 64k page size and THP enabled.  All these tests ran
fine, including running a KVM guest on the bare-metal system.  So far
I have done kernel compiles in a loop as the test, but I plan to run
LTP and possibly some other tests.

Paul.

 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  5 ++-
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 24 +++++------
 arch/powerpc/include/asm/book3s/64/hash.h     | 57 ++++++++++++++-------------
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  6 +--
 arch/powerpc/include/asm/nohash/64/pgtable.h  |  3 ++
 arch/powerpc/include/asm/pgalloc-64.h         | 16 ++++----
 arch/powerpc/mm/hash64_64k.c                  |  3 +-
 arch/powerpc/mm/hash_utils_64.c               | 10 ++---
 arch/powerpc/mm/hugetlbpage-hash64.c          |  5 ++-
 arch/powerpc/mm/mmu_decl.h                    |  3 +-
 arch/powerpc/mm/pgtable_64.c                  |  4 +-
 11 files changed, 73 insertions(+), 63 deletions(-)
