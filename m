Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B42B5B6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 06:00:03 +1000 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/5] powerpc: Create next_tlbcam_idx percpu variable for
	FSL_BOOKE
Date: Tue, 28 Jun 2011 14:54:47 -0500
Message-Id: <13092911313115-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <13092910702553-git-send-email-beckyb@kernel.crashing.org>
References: <1309290888309-git-send-email-beckyb@kernel.crashing.org>
	<13092909493748-git-send-email-beckyb@kernel.crashing.org>
	<13092910103675-git-send-email-beckyb@kernel.crashing.org>
	<13092910702553-git-send-email-beckyb@kernel.crashing.org>
Cc: wli@holomorphy.com, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Becky Bruce <beckyb@kernel.crashing.org>

This is used to round-robin TLBCAM entries.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/include/asm/mmu.h |    5 +++++
 arch/powerpc/kernel/smp.c      |    4 ++++
 arch/powerpc/mm/mem.c          |    9 +++++++++
 arch/powerpc/mm/tlb_nohash.c   |    6 ++++++
 4 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 4138b21..b427a55 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -115,6 +115,11 @@
 #ifndef __ASSEMBLY__
 #include <asm/cputable.h>
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+#include <asm/percpu.h>
+DECLARE_PER_CPU(int, next_tlbcam_idx);
+#endif
+
 static inline int mmu_has_feature(unsigned long feature)
 {
 	return (cur_cpu_spec->mmu_features & feature);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 2975f64..3c9681a 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -313,6 +313,10 @@ struct thread_info *current_set[NR_CPUS];
 static void __devinit smp_store_cpu_info(int id)
 {
 	per_cpu(cpu_pvr, id) = mfspr(SPRN_PVR);
+#ifdef CONFIG_PPC_FSL_BOOK3E
+	per_cpu(next_tlbcam_idx, id)
+		= (mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY) - 1;
+#endif
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 097b288..7209901 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -353,6 +353,15 @@ void __init mem_init(void)
 	}
 #endif /* CONFIG_HIGHMEM */
 
+#if defined(CONFIG_PPC_FSL_BOOK3E) && !defined(CONFIG_SMP)
+	/*
+	 * If smp is enabled, next_tlbcam_idx is initialized in the cpu up
+	 * functions.... do it here for the non-smp case.
+	 */
+	per_cpu(next_tlbcam_idx, smp_processor_id()) =
+		(mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY) - 1;
+#endif
+
 	printk(KERN_INFO "Memory: %luk/%luk available (%luk kernel code, "
 	       "%luk reserved, %luk data, %luk bss, %luk init)\n",
 		nr_free_pages() << (PAGE_SHIFT-10),
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 5693499..ea037ba 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -102,6 +102,12 @@ unsigned long linear_map_top;	/* Top of linear mapping */
 
 #endif /* CONFIG_PPC64 */
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+/* next_tlbcam_idx is used to round-robin tlbcam entry assignment */
+DEFINE_PER_CPU(int, next_tlbcam_idx);
+EXPORT_PER_CPU_SYMBOL(next_tlbcam_idx);
+#endif
+
 /*
  * Base TLB flushing operations:
  *
-- 
1.5.6.5
