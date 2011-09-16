Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 372BEB7199
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Sep 2011 01:40:03 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p8GFe0FA000795
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Sep 2011 10:40:01 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc/fsl-booke: Fix setup_initial_memory_limit to not
	blindly map
Date: Fri, 16 Sep 2011 10:39:59 -0500
Message-Id: <1316187599-27549-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1316187599-27549-1-git-send-email-galak@kernel.crashing.org>
References: <1316187599-27549-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On FSL Book-E devices we support multiple large TLB sizes and so we can
get into situations in which the initial 1G TLB size is too big and
we're asked for a size that is not mappable by a single entry (like
512M).  The single entry is important because when we bring up secondary
cores they need to ensure any data structure they need to access (eg
PACA or stack) is always mapped.

So we really need to determine what size will actually be mapped by the
first TLB entry to ensure we limit early memory references to that
region.  We refactor the map_mem_in_cams() code to provider a helper
function that we can utilize to determine the size of the first TLB
entry while taking into account size and alignment constraints.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/mm/fsl_booke_mmu.c |   31 +++++++++++++++++++------------
 arch/powerpc/mm/mmu_decl.h      |    2 ++
 arch/powerpc/mm/tlb_nohash.c    |   21 ++++++++++++++++++---
 3 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index f7802c8..6f593bd 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -146,29 +146,36 @@ static void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 	loadcam_entry(index);
 }
 
+unsigned long calc_cam_sz(unsigned long ram, unsigned long virt,
+			  phys_addr_t phys)
+{
+	unsigned int camsize = __ilog2(ram) & ~1U;
+	unsigned int align = __ffs(virt | phys) & ~1U;
+	unsigned long max_cam = (mfspr(SPRN_TLB1CFG) >> 16) & 0xf;
+
+	/* Convert (4^max) kB to (2^max) bytes */
+	max_cam = max_cam * 2 + 10;
+
+	if (camsize > align)
+		camsize = align;
+	if (camsize > max_cam)
+		camsize = max_cam;
+
+	return 1UL << camsize;
+}
+
 unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx)
 {
 	int i;
 	unsigned long virt = PAGE_OFFSET;
 	phys_addr_t phys = memstart_addr;
 	unsigned long amount_mapped = 0;
-	unsigned long max_cam = (mfspr(SPRN_TLB1CFG) >> 16) & 0xf;
-
-	/* Convert (4^max) kB to (2^max) bytes */
-	max_cam = max_cam * 2 + 10;
 
 	/* Calculate CAM values */
 	for (i = 0; ram && i < max_cam_idx; i++) {
-		unsigned int camsize = __ilog2(ram) & ~1U;
-		unsigned int align = __ffs(virt | phys) & ~1U;
 		unsigned long cam_sz;
 
-		if (camsize > align)
-			camsize = align;
-		if (camsize > max_cam)
-			camsize = max_cam;
-
-		cam_sz = 1UL << camsize;
+		cam_sz = calc_cam_sz(ram, virt, phys);
 		settlbcam(i, virt, phys, cam_sz, PAGE_KERNEL_X, 0);
 
 		ram -= cam_sz;
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index dd0a258..83eb5d5 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -142,6 +142,8 @@ extern unsigned long mmu_mapin_ram(unsigned long top);
 
 #elif defined(CONFIG_PPC_FSL_BOOK3E)
 extern unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx);
+extern unsigned long calc_cam_sz(unsigned long ram, unsigned long virt,
+				 phys_addr_t phys);
 #ifdef CONFIG_PPC32
 extern void MMU_init_hw(void);
 extern unsigned long mmu_mapin_ram(unsigned long top);
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index afc95c7..6c2eabf 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -642,13 +642,28 @@ void __cpuinit early_init_mmu_secondary(void)
 void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 				phys_addr_t first_memblock_size)
 {
-	/* On Embedded 64-bit, we adjust the RMA size to match
+	/* On non-FSL Embedded 64-bit, we adjust the RMA size to match
 	 * the bolted TLB entry. We know for now that only 1G
 	 * entries are supported though that may eventually
-	 * change. We crop it to the size of the first MEMBLOCK to
+	 * change.
+	 *
+	 * on FSL Embedded 64-bit, we adjust the RMA size to match the
+	 * first bolted TLB entry size.  We still limit max to 1G even if
+	 * the TLB could cover more.  This is due to what the early init
+	 * code is setup to do.
+	 *
+	 * We crop it to the size of the first MEMBLOCK to
 	 * avoid going over total available memory just in case...
 	 */
-	ppc64_rma_size = min_t(u64, first_memblock_size, 0x40000000);
+#ifdef CONFIG_PPC_FSL_BOOK3E
+	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
+		unsigned long linear_sz;
+		linear_sz = calc_cam_sz(first_memblock_size, PAGE_OFFSET,
+					first_memblock_base);
+		ppc64_rma_size = min_t(u64, linear_sz, 0x40000000);
+	} else
+#endif
+		ppc64_rma_size = min_t(u64, first_memblock_size, 0x40000000);
 
 	/* Finally limit subsequent allocations */
 	memblock_set_current_limit(first_memblock_base + ppc64_rma_size);
-- 
1.7.3.4
