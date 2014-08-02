Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (dns-bn1lp0143.outbound.protection.outlook.com [207.46.163.143])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C99CD1A073A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Aug 2014 13:08:01 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] powerpc/nohash: Split __early_init_mmu() into boot and
 secondary
Date: Fri, 1 Aug 2014 22:07:41 -0500
Message-ID: <1406948861-11322-2-git-send-email-scottwood@freescale.com>
In-Reply-To: <1406948861-11322-1-git-send-email-scottwood@freescale.com>
References: <1406948861-11322-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>
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
 arch/powerpc/mm/tlb_nohash.c | 90 ++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 92cb18d..11ece11 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -581,42 +581,10 @@ static void setup_mmu_htw(void)
 /*
  * Early initialization of the MMU TLB code
  */
-static void __early_init_mmu(int boot_cpu)
+static void early_init_mmu_allcpus(void)
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
@@ -662,7 +625,51 @@ static void __early_init_mmu(int boot_cpu)
 		/* use a quarter of the TLBCAM for bolted linear map */
 		num_cams = (mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY) / 4;
 		linear_map_top = map_mem_in_cams(linear_map_top, num_cams);
+	}
+#endif
+}
 
+void __init early_init_mmu(void)
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
+	/* Set the global containing the top of the linear mapping
+	 * for use by the TLB miss code
+	 */
+	linear_map_top = memblock_end_of_DRAM();
+
+	early_init_mmu_allcpus();
+
+#ifdef CONFIG_PPC_FSL_BOOK3E
+	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
 		/* limit memory so we dont have linear faults */
 		memblock_enforce_memory_limit(linear_map_top);
 
@@ -683,14 +690,9 @@ static void __early_init_mmu(int boot_cpu)
 	memblock_set_current_limit(linear_map_top);
 }
 
-void __init early_init_mmu(void)
-{
-	__early_init_mmu(1);
-}
-
 void early_init_mmu_secondary(void)
 {
-	__early_init_mmu(0);
+	early_init_mmu_allcpus();
 }
 
 void setup_initial_memory_limit(phys_addr_t first_memblock_base,
-- 
1.9.1
