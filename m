Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0203.outbound.protection.outlook.com [207.46.163.203])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B62D11A0DDB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Aug 2014 09:44:24 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2] powerpc/nohash: Split __early_init_mmu() into boot and
 secondary
Date: Fri, 8 Aug 2014 18:44:01 -0500
Message-ID: <1407541441-4169-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

__early_init_mmu() does some things that are really only needed by the
boot cpu.  On FSL booke, This includes calling
memblock_enforce_memory_limit(), which is labelled __init.  Secondary
cpu init code can't be __init as that would break CPU hotplug.

While it's probably a bug that memblock_enforce_memory_limit() isn't
__init_memblock instead, there's no reason why we should be doing this
stuff for secondary cpus in the first place.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v2: Rename early_init_this_mmu(), and factor early_init_mmu_global()
and early_mmu_set_memory_limit() out from early_init_mmu().

 arch/powerpc/mm/tlb_nohash.c | 111 +++++++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 92cb18d..f38ea4d 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -581,42 +581,10 @@ static void setup_mmu_htw(void)
 /*
  * Early initialization of the MMU TLB code
  */
-static void __early_init_mmu(int boot_cpu)
+static void early_init_this_mmu(void)
 {
 	unsigned int mas4;
 
-	/* XXX This will have to be decided at runtime, but right
-	 * now our boot and TLB miss code hard wires it. Ideally
-	 * we should find out a suitable page size and patch the
-	 * TLB miss code (either that or use the PACA to store
-	 * the value we want)
-	 */
-	mmu_linear_psize = MMU_PAGE_1G;
-
-	/* XXX This should be decided at runtime based on supported
-	 * page sizes in the TLB, but for now let's assume 16M is
-	 * always there and a good fit (which it probably is)
-	 *
-	 * Freescale booke only supports 4K pages in TLB0, so use that.
-	 */
-	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E))
-		mmu_vmemmap_psize = MMU_PAGE_4K;
-	else
-		mmu_vmemmap_psize = MMU_PAGE_16M;
-
-	/* XXX This code only checks for TLB 0 capabilities and doesn't
-	 *     check what page size combos are supported by the HW. It
-	 *     also doesn't handle the case where a separate array holds
-	 *     the IND entries from the array loaded by the PT.
-	 */
-	if (boot_cpu) {
-		/* Look for supported page sizes */
-		setup_page_sizes();
-
-		/* Look for HW tablewalk support */
-		setup_mmu_htw();
-	}
-
 	/* Set MAS4 based on page table setting */
 
 	mas4 = 0x4 << MAS4_WIMGED_SHIFT;
@@ -650,11 +618,6 @@ static void __early_init_mmu(int boot_cpu)
 	}
 	mtspr(SPRN_MAS4, mas4);
 
-	/* Set the global containing the top of the linear mapping
-	 * for use by the TLB miss code
-	 */
-	linear_map_top = memblock_end_of_DRAM();
-
 #ifdef CONFIG_PPC_FSL_BOOK3E
 	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
 		unsigned int num_cams;
@@ -662,10 +625,49 @@ static void __early_init_mmu(int boot_cpu)
 		/* use a quarter of the TLBCAM for bolted linear map */
 		num_cams = (mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY) / 4;
 		linear_map_top = map_mem_in_cams(linear_map_top, num_cams);
+	}
+#endif
 
-		/* limit memory so we dont have linear faults */
-		memblock_enforce_memory_limit(linear_map_top);
+	/* A sync won't hurt us after mucking around with
+	 * the MMU configuration
+	 */
+	mb();
+}
 
+static void __init early_init_mmu_global(void)
+{
+	/* XXX This will have to be decided at runtime, but right
+	 * now our boot and TLB miss code hard wires it. Ideally
+	 * we should find out a suitable page size and patch the
+	 * TLB miss code (either that or use the PACA to store
+	 * the value we want)
+	 */
+	mmu_linear_psize = MMU_PAGE_1G;
+
+	/* XXX This should be decided at runtime based on supported
+	 * page sizes in the TLB, but for now let's assume 16M is
+	 * always there and a good fit (which it probably is)
+	 *
+	 * Freescale booke only supports 4K pages in TLB0, so use that.
+	 */
+	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E))
+		mmu_vmemmap_psize = MMU_PAGE_4K;
+	else
+		mmu_vmemmap_psize = MMU_PAGE_16M;
+
+	/* XXX This code only checks for TLB 0 capabilities and doesn't
+	 *     check what page size combos are supported by the HW. It
+	 *     also doesn't handle the case where a separate array holds
+	 *     the IND entries from the array loaded by the PT.
+	 */
+	/* Look for supported page sizes */
+	setup_page_sizes();
+
+	/* Look for HW tablewalk support */
+	setup_mmu_htw();
+
+#ifdef CONFIG_PPC_FSL_BOOK3E
+	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
 		if (book3e_htw_mode == PPC_HTW_NONE) {
 			extlb_level_exc = EX_TLB_SIZE;
 			patch_exception(0x1c0, exc_data_tlb_miss_bolted_book3e);
@@ -675,22 +677,41 @@ static void __early_init_mmu(int boot_cpu)
 	}
 #endif
 
-	/* A sync won't hurt us after mucking around with
-	 * the MMU configuration
+	/* Set the global containing the top of the linear mapping
+	 * for use by the TLB miss code
 	 */
-	mb();
+	linear_map_top = memblock_end_of_DRAM();
+}
+
+static void __init early_mmu_set_memory_limit(void)
+{
+#ifdef CONFIG_PPC_FSL_BOOK3E
+	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
+		/*
+		 * Limit memory so we dont have linear faults.
+		 * Unlike memblock_set_current_limit, which limits
+		 * memory available during early boot, this permanently
+		 * reduces the memory available to Linux.  We need to
+		 * do this because highmem is not supported on 64-bit.
+		 */
+		memblock_enforce_memory_limit(linear_map_top);
+	}
+#endif
 
 	memblock_set_current_limit(linear_map_top);
 }
 
+/* boot cpu only */
 void __init early_init_mmu(void)
 {
-	__early_init_mmu(1);
+	early_init_mmu_global();
+	early_init_this_mmu();
+	early_mmu_set_memory_limit();
 }
 
 void early_init_mmu_secondary(void)
 {
-	__early_init_mmu(0);
+	early_init_this_mmu();
 }
 
 void setup_initial_memory_limit(phys_addr_t first_memblock_base,
-- 
1.9.1
