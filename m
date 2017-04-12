Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w307h0Z2TzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 20:11:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH] powerpc/mm: Fix swapper_pg_dir size on 64-bit hash w/64K pages
Date: Wed, 12 Apr 2017 20:11:07 +1000
Message-Id: <1491991867-8758-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recently in commit f6eedbba7a26 ("powerpc/mm/hash: Increase VA range to 128TB"),
we increased H_PGD_INDEX_SIZE to 15 when we're building with 64K pages. This
makes it larger than RADIX_PGD_INDEX_SIZE (13), which means the logic to
calculate MAX_PGD_INDEX_SIZE in book3s/64/pgtable.h is wrong.

The end result is that the PGD (Page Global Directory, ie top level page table)
of the kernel (aka. swapper_pg_dir), is too small.

This generally doesn't lead to a crash, as we don't use the full range in normal
operation. However if we try to dump the kernel pagetables we can trigger a
crash because we walk off the end of the pgd into other memory and eventually
try to dereference something bogus:

  $ cat /sys/kernel/debug/kernel_pagetables
  Unable to handle kernel paging request for data at address 0xe8fece0000000000
  Faulting instruction address: 0xc000000000072314
  cpu 0xc: Vector: 380 (Data SLB Access) at [c0000000daa13890]
      pc: c000000000072314: ptdump_show+0x164/0x430
      lr: c000000000072550: ptdump_show+0x3a0/0x430
     dar: e802cf0000000000
  seq_read+0xf8/0x560
  full_proxy_read+0x84/0xc0
  __vfs_read+0x6c/0x1d0
  vfs_read+0xbc/0x1b0
  SyS_read+0x6c/0x110
  system_call+0x38/0xfc

The root cause is that MAX_PGD_INDEX_SIZE isn't actually computed to be
the max of H_PGD_INDEX_SIZE or RADIX_PGD_INDEX_SIZE. To fix that move
the calculation into asm-offsets.c where we can do it easily using
max().

Fixes: f6eedbba7a26 ("powerpc/mm/hash: Increase VA range to 128TB")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 4 ----
 arch/powerpc/kernel/asm-offsets.c            | 4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index fb72ff6b98e6..fb8380a2d8d5 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -232,10 +232,6 @@ extern unsigned long __pte_frag_nr;
 extern unsigned long __pte_frag_size_shift;
 #define PTE_FRAG_SIZE_SHIFT __pte_frag_size_shift
 #define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
-/*
- * Pgtable size used by swapper, init in asm code
- */
-#define MAX_PGD_TABLE_SIZE (sizeof(pgd_t) << RADIX_PGD_INDEX_SIZE)
 
 #define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
 #define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index e7c8229a8812..8e1163426ccb 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -400,8 +400,8 @@ int main(void)
 	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
 #endif
 
-#ifdef MAX_PGD_TABLE_SIZE
-	DEFINE(PGD_TABLE_SIZE, MAX_PGD_TABLE_SIZE);
+#ifdef CONFIG_PPC_BOOK3S_64
+	DEFINE(PGD_TABLE_SIZE, (sizeof(pgd_t) << max(RADIX_PGD_INDEX_SIZE, H_PGD_INDEX_SIZE)));
 #else
 	DEFINE(PGD_TABLE_SIZE, PGD_TABLE_SIZE);
 #endif
-- 
2.7.4
