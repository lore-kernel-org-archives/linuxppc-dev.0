Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <ec0c4e092c60d1bbcb4b776a94589ac838f4f008.1210220828.git.michael@ellerman.id.au>
In-Reply-To: <5d2ed2a7e92250bdc6d9959dbeaeb3784a7109b4.1210220828.git.michael@ellerman.id.au>
References: <5d2ed2a7e92250bdc6d9959dbeaeb3784a7109b4.1210220828.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 04/12] Remove duplicate variable definitions in mm/tlb_64.c
Date: Thu,  8 May 2008 14:27:09 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Somewhere along the way (e28f7faf05159f1cfd564596f5e6178edba6bd49,
"Four level pagetables for ppc64") we ended up with duplicate
definitions for pte_freelist_cur and pte_freelist_force_free.
Somehow this compiles, but it would be better to just have one
definition for each.

The two definitions we end up with can be static too!

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/mm/tlb_64.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/tlb_64.c b/arch/powerpc/mm/tlb_64.c
index e2d867c..509bc56 100644
--- a/arch/powerpc/mm/tlb_64.c
+++ b/arch/powerpc/mm/tlb_64.c
@@ -37,8 +37,8 @@ DEFINE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
  * include/asm-powerpc/tlb.h file -- tgall
  */
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
-DEFINE_PER_CPU(struct pte_freelist_batch *, pte_freelist_cur);
-unsigned long pte_freelist_forced_free;
+static DEFINE_PER_CPU(struct pte_freelist_batch *, pte_freelist_cur);
+static unsigned long pte_freelist_forced_free;
 
 struct pte_freelist_batch
 {
@@ -47,9 +47,6 @@ struct pte_freelist_batch
 	pgtable_free_t	tables[0];
 };
 
-DEFINE_PER_CPU(struct pte_freelist_batch *, pte_freelist_cur);
-unsigned long pte_freelist_forced_free;
-
 #define PTE_FREELIST_SIZE \
 	((PAGE_SIZE - sizeof(struct pte_freelist_batch)) \
 	  / sizeof(pgtable_free_t))
-- 
1.5.5
