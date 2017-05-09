Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wMX4K2R2JzDqJk
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 May 2017 18:05:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, paulus@samba.org
Subject: [PATCH] powerpc/mm/book3s/64: Rework page table geometry for lower
 memory usage
Date: Tue,  9 May 2017 18:05:48 +1000
Message-Id: <1494317148-18554-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recently in commit f6eedbba7a26 ("powerpc/mm/hash: Increase VA range to 128TB")
we increased the virtual address space for user processes to 128TB by default,
and up to 512TB if user space opts in.

This obviously required expanding the range of the Linux page tables. For Book3s
64-bit using hash and with PAGE_SIZE=64K, we increased the PGD to 2^15 entries.
This meant we could cover the full address range, while still being able to
insert a 16G hugepage at the PGD level and a 16M hugepage in the PMD.

The downside of that geometry is that it uses a lot of memory for the PGD, and
in particular makes the PGD a 4-page allocation, which means it's much more
likely to fail under memory pressure.

Instead we can make the PMD larger, so that a single PUD entry maps 16G,
allowing the 16G hugepages to sit at that level in the tree. We're then able to
split the remaining bits between the PUG and PGD. We make the PGD slightly
larger as that results in lower memory usage for typical programs.

When THP is enabled the PMD actually doubles in size, to 2^11 entries, or 2^14
bytes, which is large but still < PAGE_SIZE.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 214219dff87c..9732837aaae8 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -2,9 +2,9 @@
 #define _ASM_POWERPC_BOOK3S_64_HASH_64K_H
 
 #define H_PTE_INDEX_SIZE  8
-#define H_PMD_INDEX_SIZE  5
-#define H_PUD_INDEX_SIZE  5
-#define H_PGD_INDEX_SIZE  15
+#define H_PMD_INDEX_SIZE  10
+#define H_PUD_INDEX_SIZE  7
+#define H_PGD_INDEX_SIZE  8
 
 /*
  * 64k aligned address free up few of the lower bits of RPN for us
-- 
2.7.4
