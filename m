Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E8E1CB7131
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Jan 2011 08:51:25 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0QLfts2009707
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2011 16:42:18 -0500
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 5F17D72804D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Jan 2011 16:51:22 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p0QLpLxY2392064
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2011 16:51:21 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p0QLpJVp005418
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2011 16:51:21 -0500
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/5] powerpc/44x: don't use tlbivax on AMP systems
Date: Wed, 26 Jan 2011 15:51:15 -0600
Message-Id: <1296078676-13940-5-git-send-email-shaggy@linux.vnet.ibm.com>
In-Reply-To: <1296078676-13940-1-git-send-email-shaggy@linux.vnet.ibm.com>
References: <1296078676-13940-1-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since other OS's may be running on the other cores don't use tlbivax

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu.h |    2 +-
 arch/powerpc/kernel/setup_32.c |    2 ++
 arch/powerpc/mm/tlb_nohash.c   |   21 ++++++++++++++++++++-
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index bb40a06..f3a7c65 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -80,7 +80,7 @@ static inline int mmu_has_feature(unsigned long feature)
 
 extern unsigned int __start___mmu_ftr_fixup, __stop___mmu_ftr_fixup;
 
-/* MMU initialization (64-bit only fo now) */
+/* MMU initialization */
 extern void early_init_mmu(void);
 extern void early_init_mmu_secondary(void);
 
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index d1ca976..e50ead7 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -126,6 +126,8 @@ notrace void __init machine_init(unsigned long dt_ptr)
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
 
+	early_init_mmu();
+
 	probe_machine();
 
 	setup_kdump_trampoline();
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 2a030d8..b33c5e6 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -35,6 +35,7 @@
 #include <linux/preempt.h>
 #include <linux/spinlock.h>
 #include <linux/memblock.h>
+#include <linux/of_fdt.h>
 
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
@@ -153,6 +154,17 @@ EXPORT_SYMBOL(local_flush_tlb_page);
  */
 #ifdef CONFIG_SMP
 
+static int amp;
+
+#ifdef CONFIG_44x
+void __init early_init_mmu_44x(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+	if (of_flat_dt_is_compatible(root, "ibm,47x-AMP"))
+		amp = 1;
+}
+#endif /* CONFIG_44x */
+
 static DEFINE_RAW_SPINLOCK(tlbivax_lock);
 
 static int mm_is_core_local(struct mm_struct *mm)
@@ -232,7 +244,7 @@ void __flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 	cpu_mask = mm_cpumask(mm);
 	if (!mm_is_core_local(mm)) {
 		/* If broadcast tlbivax is supported, use it */
-		if (mmu_has_feature(MMU_FTR_USE_TLBIVAX_BCAST)) {
+		if (!amp && mmu_has_feature(MMU_FTR_USE_TLBIVAX_BCAST)) {
 			int lock = mmu_has_feature(MMU_FTR_LOCK_BCAST_INVAL);
 			if (lock)
 				raw_spin_lock(&tlbivax_lock);
@@ -587,4 +599,11 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	/* Finally limit subsequent allocations */
 	memblock_set_current_limit(first_memblock_base + ppc64_rma_size);
 }
+#else /* ! CONFIG_PPC64 */
+void __init early_init_mmu(void)
+{
+#if defined(CONFIG_SMP) && defined(CONFIG_44x)
+	early_init_mmu_44x();
+#endif
+}
 #endif /* CONFIG_PPC64 */
-- 
1.7.3.4
