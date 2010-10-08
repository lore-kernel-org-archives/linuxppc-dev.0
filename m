Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CFB07B70EF
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Oct 2010 06:07:15 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o98J7BbE005932
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Oct 2010 14:07:12 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/11] powerpc/fsl-booke64: Use TLB CAMs to cover linear
	mapping on FSL 64-bit chips
Date: Fri,  8 Oct 2010 14:06:51 -0500
Message-Id: <1286564813-21209-9-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1286564813-21209-8-git-send-email-galak@kernel.crashing.org>
References: <1286564813-21209-1-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-2-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-3-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-4-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-5-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-6-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-7-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-8-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Freescale parts typically have TLB array for large mappings that we can
bolt the linear mapping into.  We utilize the code that already exists
on PPC32 on the 64-bit side to setup the linear mapping to be cover by
bolted TLB entries.  We utilize a quarter of the variable size TLB array
for this purpose.

Additionally, we limit the amount of memory to what we can cover via
bolted entries so we don't get secondary faults in the TLB miss
handlers.  We should fix this limitation in the future.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/asm-offsets.c |    4 ++--
 arch/powerpc/mm/Makefile          |    2 +-
 arch/powerpc/mm/fsl_booke_mmu.c   |   12 +++++++-----
 arch/powerpc/mm/mmu_decl.h        |    5 ++++-
 arch/powerpc/mm/tlb_nohash.c      |   14 ++++++++++++++
 arch/powerpc/mm/tlb_nohash_low.S  |    2 +-
 6 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index c634940..c3e0194 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -61,7 +61,7 @@
 #endif
 #endif
 
-#if defined(CONFIG_FSL_BOOKE)
+#if defined(CONFIG_PPC_FSL_BOOK3E)
 #include "../mm/mmu_decl.h"
 #endif
 
@@ -470,7 +470,7 @@ int main(void)
 	DEFINE(PGD_T_LOG2, PGD_T_LOG2);
 	DEFINE(PTE_T_LOG2, PTE_T_LOG2);
 #endif
-#ifdef CONFIG_FSL_BOOKE
+#ifdef CONFIG_PPC_FSL_BOOK3E
 	DEFINE(TLBCAM_SIZE, sizeof(struct tlbcam));
 	DEFINE(TLBCAM_MAS0, offsetof(struct tlbcam, MAS0));
 	DEFINE(TLBCAM_MAS1, offsetof(struct tlbcam, MAS1));
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index ce68708..d646f16 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_PPC_STD_MMU)	+= hash_low_$(CONFIG_WORD_SIZE).o \
 				   mmu_context_hash$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_40x)		+= 40x_mmu.o
 obj-$(CONFIG_44x)		+= 44x_mmu.o
-obj-$(CONFIG_FSL_BOOKE)		+= fsl_booke_mmu.o
+obj-$(CONFIG_PPC_FSL_BOOK3E)	+= fsl_booke_mmu.o
 obj-$(CONFIG_NEED_MULTIPLE_NODES) += numa.o
 obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
 ifeq ($(CONFIG_HUGETLB_PAGE),y)
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 1b4354d..67bc8a7 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -56,11 +56,6 @@
 
 unsigned int tlbcam_index;
 
-
-#if defined(CONFIG_LOWMEM_CAM_NUM_BOOL) && (CONFIG_LOWMEM_CAM_NUM >= NUM_TLBCAMS)
-#error "LOWMEM_CAM_NUM must be less than NUM_TLBCAMS"
-#endif
-
 #define NUM_TLBCAMS	(64)
 struct tlbcam TLBCAM[NUM_TLBCAMS];
 
@@ -185,6 +180,12 @@ unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx)
 	return amount_mapped;
 }
 
+#ifdef CONFIG_PPC32
+
+#if defined(CONFIG_LOWMEM_CAM_NUM_BOOL) && (CONFIG_LOWMEM_CAM_NUM >= NUM_TLBCAMS)
+#error "LOWMEM_CAM_NUM must be less than NUM_TLBCAMS"
+#endif
+
 unsigned long __init mmu_mapin_ram(unsigned long top)
 {
 	return tlbcam_addrs[tlbcam_index - 1].limit - PAGE_OFFSET + 1;
@@ -216,3 +217,4 @@ void __init adjust_total_lowmem(void)
 
 	__initial_memory_limit_addr = memstart_addr + __max_low_memory;
 }
+#endif
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 63b84a0..dd0a258 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -140,10 +140,13 @@ extern void wii_memory_fixups(void);
 extern void MMU_init_hw(void);
 extern unsigned long mmu_mapin_ram(unsigned long top);
 
-#elif defined(CONFIG_FSL_BOOKE)
+#elif defined(CONFIG_PPC_FSL_BOOK3E)
+extern unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx);
+#ifdef CONFIG_PPC32
 extern void MMU_init_hw(void);
 extern unsigned long mmu_mapin_ram(unsigned long top);
 extern void adjust_total_lowmem(void);
+#endif
 extern void loadcam_entry(unsigned int index);
 
 struct tlbcam {
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 6651899..61fe32a 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -541,6 +541,20 @@ static void __early_init_mmu(int boot_cpu)
 	 */
 	linear_map_top = memblock_end_of_DRAM();
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
+		unsigned int num_cams;
+
+		/* use a quarter of the TLBCAM for bolted linear map */
+		num_cams = (mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY) / 4;
+		linear_map_top = map_mem_in_cams(linear_map_top, num_cams);
+
+		/* limit memory so we dont have linear faults */
+		memblock_enforce_memory_limit(linear_map_top);
+		memblock_analyze();
+	}
+#endif
+
 	/* A sync won't hurt us after mucking around with
 	 * the MMU configuration
 	 */
diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/tlb_nohash_low.S
index b9d9fed..af405ee 100644
--- a/arch/powerpc/mm/tlb_nohash_low.S
+++ b/arch/powerpc/mm/tlb_nohash_low.S
@@ -367,7 +367,7 @@ _GLOBAL(set_context)
 #error Unsupported processor type !
 #endif
 
-#if defined(CONFIG_FSL_BOOKE)
+#if defined(CONFIG_PPC_FSL_BOOK3E)
 /*
  * extern void loadcam_entry(unsigned int index)
  *
-- 
1.7.2.3
