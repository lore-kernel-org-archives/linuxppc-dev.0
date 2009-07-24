Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 586C9B899F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 19:15:57 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 24 Jul 2009 19:15:42 +1000
Subject: [PATCH 16/20] powerpc: Add PACA fields specific to 64-bit Book3E
	processors
In-Reply-To: <1248426902.401617.944220131651.qpush@grosgo>
Message-Id: <20090724091557.49AE4DDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds various fields in the PACA that are for use specifically
by Book3E processors, such as exception save areas, current pgd
pointer, special exceptions kernel stacks etc...

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/paca.h   |   23 ++++++++++++++++++++---
 arch/powerpc/kernel/asm-offsets.c |   14 ++++++++++++++
 arch/powerpc/kernel/paca.c        |    3 +++
 3 files changed, 37 insertions(+), 3 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/paca.h	2009-07-23 14:29:58.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/paca.h	2009-07-23 14:31:42.000000000 +1000
@@ -14,9 +14,11 @@
 #define _ASM_POWERPC_PACA_H
 #ifdef __KERNEL__
 
-#include	<asm/types.h>
-#include	<asm/lppaca.h>
-#include	<asm/mmu.h>
+#include <asm/types.h>
+#include <asm/lppaca.h>
+#include <asm/mmu.h>
+#include <asm/page.h>
+#include <asm/exception-64e.h>
 
 register struct paca_struct *local_paca asm("r13");
 
@@ -91,6 +93,21 @@ struct paca_struct {
 	u16 slb_cache[SLB_CACHE_ENTRIES];
 #endif /* CONFIG_PPC_STD_MMU_64 */
 
+#ifdef CONFIG_PPC_BOOK3E
+	pgd_t *pgd;			/* Current PGD */
+	pgd_t *kernel_pgd;		/* Kernel PGD */
+	u64 exgen[8] __attribute__((aligned(0x80)));
+	u64 extlb[EX_TLB_SIZE*3] __attribute__((aligned(0x80)));
+	u64 exmc[8];		/* used for machine checks */
+	u64 excrit[8];		/* used for crit interrupts */
+	u64 exdbg[8];		/* used for debug interrupts */
+
+	/* Kernel stack pointers for use by special exceptions */
+	void *mc_kstack;
+	void *crit_kstack;
+	void *dbg_kstack;
+#endif /* CONFIG_PPC_BOOK3E */
+
 	mm_context_t context;
 
 	/*
Index: linux-work/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/asm-offsets.c	2009-07-23 14:31:35.000000000 +1000
+++ linux-work/arch/powerpc/kernel/asm-offsets.c	2009-07-23 14:31:42.000000000 +1000
@@ -140,6 +140,20 @@ int main(void)
 					    context.high_slices_psize));
 	DEFINE(MMUPSIZEDEFSIZE, sizeof(struct mmu_psize_def));
 #endif /* CONFIG_PPC_MM_SLICES */
+
+#ifdef CONFIG_PPC_BOOK3E
+	DEFINE(PACAPGD, offsetof(struct paca_struct, pgd));
+	DEFINE(PACA_KERNELPGD, offsetof(struct paca_struct, kernel_pgd));
+	DEFINE(PACA_EXGEN, offsetof(struct paca_struct, exgen));
+	DEFINE(PACA_EXTLB, offsetof(struct paca_struct, extlb));
+	DEFINE(PACA_EXMC, offsetof(struct paca_struct, exmc));
+	DEFINE(PACA_EXCRIT, offsetof(struct paca_struct, excrit));
+	DEFINE(PACA_EXDBG, offsetof(struct paca_struct, exdbg));
+	DEFINE(PACA_MC_STACK, offsetof(struct paca_struct, mc_kstack));
+	DEFINE(PACA_CRIT_STACK, offsetof(struct paca_struct, crit_kstack));
+	DEFINE(PACA_DBG_STACK, offsetof(struct paca_struct, dbg_kstack));
+#endif /* CONFIG_PPC_BOOK3E */
+
 #ifdef CONFIG_PPC_STD_MMU_64
 	DEFINE(PACASTABREAL, offsetof(struct paca_struct, stab_real));
 	DEFINE(PACASTABVIRT, offsetof(struct paca_struct, stab_addr));
Index: linux-work/arch/powerpc/kernel/paca.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/paca.c	2009-07-23 14:29:58.000000000 +1000
+++ linux-work/arch/powerpc/kernel/paca.c	2009-07-23 14:31:42.000000000 +1000
@@ -13,6 +13,7 @@
 #include <asm/lppaca.h>
 #include <asm/paca.h>
 #include <asm/sections.h>
+#include <asm/pgtable.h>
 
 /* This symbol is provided by the linker - let it fill in the paca
  * field correctly */
@@ -87,6 +88,8 @@ void __init initialise_pacas(void)
 
 #ifdef CONFIG_PPC_BOOK3S
 		new_paca->lppaca_ptr = &lppaca[cpu];
+#else
+		new_paca->kernel_pgd = swapper_pg_dir;
 #endif
 		new_paca->lock_token = 0x8000;
 		new_paca->paca_index = cpu;
