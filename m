Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 618F6B7C14
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 16:00:01 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 23 Jul 2009 15:59:50 +1000
Subject: [PATCH 17/20] powerpc/mm: Move around mmu_gathers definition on 64-bit
Message-Id: <20090723060001.54576DDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The definition for the global structure mmu_gathers, used by generic code,
is currently defined in multiple places not including anything used by
64-bit Book3E. This changes it by moving to one place common to all
processors.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/mm/init_32.c    |    2 --
 arch/powerpc/mm/pgtable.c    |    2 ++
 arch/powerpc/mm/tlb_hash64.c |    5 -----
 3 files changed, 2 insertions(+), 7 deletions(-)

--- linux-work.orig/arch/powerpc/mm/tlb_hash64.c	2009-07-23 14:24:47.000000000 +1000
+++ linux-work/arch/powerpc/mm/tlb_hash64.c	2009-07-23 14:34:13.000000000 +1000
@@ -33,11 +33,6 @@
 
 DEFINE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
 
-/* This is declared as we are using the more or less generic
- * arch/powerpc/include/asm/tlb.h file -- tgall
- */
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
-
 /*
  * A linux PTE was changed and the corresponding hash table entry
  * neesd to be flushed. This function will either perform the flush
Index: linux-work/arch/powerpc/mm/init_32.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/init_32.c	2009-07-23 14:41:17.000000000 +1000
+++ linux-work/arch/powerpc/mm/init_32.c	2009-07-23 14:41:19.000000000 +1000
@@ -54,8 +54,6 @@
 #endif
 #define MAX_LOW_MEM	CONFIG_LOWMEM_SIZE
 
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
-
 phys_addr_t total_memory;
 phys_addr_t total_lowmem;
 
Index: linux-work/arch/powerpc/mm/pgtable.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/pgtable.c	2009-07-23 14:41:29.000000000 +1000
+++ linux-work/arch/powerpc/mm/pgtable.c	2009-07-23 14:41:38.000000000 +1000
@@ -33,6 +33,8 @@
 static DEFINE_PER_CPU(struct pte_freelist_batch *, pte_freelist_cur);
 static unsigned long pte_freelist_forced_free;
 
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
+
 struct pte_freelist_batch
 {
 	struct rcu_head	rcu;
