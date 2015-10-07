Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8FE2B1A0142
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 14:48:42 +1100 (AEDT)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Tiejun Chen <tiejun.chen@intel.com>, Michael Ellerman
 <mpe@ellerman.id.au>, <kexec@lists.infradead.org>, Scott Wood
 <scottwood@freescale.com>
Subject: [PATCH v2 06/18] powerpc/fsl-booke-64: Don't limit ppc64_rma_size to
 one TLB entry
Date: Tue, 6 Oct 2015 22:48:10 -0500
Message-ID: <1444189702-17241-7-git-send-email-scottwood@freescale.com>
In-Reply-To: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
References: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is required for kdump to work when loaded at at an address that
does not fall within the first TLB entry -- which can easily happen
because while the lower limit is enforced via reserved memory, which
doesn't affect how much is mapped, the upper limit is enforced via a
different mechanism that does.  Thus, more TLB entries are needed than
would normally be used, as the total memory to be mapped might not be a
power of two.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/mm/fsl_booke_mmu.c | 22 +++++++++++++++-------
 arch/powerpc/mm/mmu_decl.h      |  3 ++-
 arch/powerpc/mm/tlb_nohash.c    | 24 +++++++++++++++++-------
 3 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 36d3c55..5eef7d7 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -178,7 +178,8 @@ unsigned long calc_cam_sz(unsigned long ram, unsigned long virt,
 }
 
 static unsigned long map_mem_in_cams_addr(phys_addr_t phys, unsigned long virt,
-					unsigned long ram, int max_cam_idx)
+					unsigned long ram, int max_cam_idx,
+					bool dryrun)
 {
 	int i;
 	unsigned long amount_mapped = 0;
@@ -188,7 +189,9 @@ static unsigned long map_mem_in_cams_addr(phys_addr_t phys, unsigned long virt,
 		unsigned long cam_sz;
 
 		cam_sz = calc_cam_sz(ram, virt, phys);
-		preptlbcam(i, virt, phys, cam_sz, pgprot_val(PAGE_KERNEL_X), 0);
+		if (!dryrun)
+			preptlbcam(i, virt, phys, cam_sz,
+				   pgprot_val(PAGE_KERNEL_X), 0);
 
 		ram -= cam_sz;
 		amount_mapped += cam_sz;
@@ -196,6 +199,9 @@ static unsigned long map_mem_in_cams_addr(phys_addr_t phys, unsigned long virt,
 		phys += cam_sz;
 	}
 
+	if (dryrun)
+		return amount_mapped;
+
 	loadcam_multi(0, i, max_cam_idx);
 	tlbcam_index = i;
 
@@ -208,12 +214,12 @@ static unsigned long map_mem_in_cams_addr(phys_addr_t phys, unsigned long virt,
 	return amount_mapped;
 }
 
-unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx)
+unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx, bool dryrun)
 {
 	unsigned long virt = PAGE_OFFSET;
 	phys_addr_t phys = memstart_addr;
 
-	return map_mem_in_cams_addr(phys, virt, ram, max_cam_idx);
+	return map_mem_in_cams_addr(phys, virt, ram, max_cam_idx, dryrun);
 }
 
 #ifdef CONFIG_PPC32
@@ -244,7 +250,7 @@ void __init adjust_total_lowmem(void)
 	ram = min((phys_addr_t)__max_low_memory, (phys_addr_t)total_lowmem);
 
 	i = switch_to_as1();
-	__max_low_memory = map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM);
+	__max_low_memory = map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM, false);
 	restore_to_as0(i, 0, 0, 1);
 
 	pr_info("Memory CAM mapping: ");
@@ -312,10 +318,12 @@ notrace void __init relocate_init(u64 dt_ptr, phys_addr_t start)
 		n = switch_to_as1();
 		/* map a 64M area for the second relocation */
 		if (memstart_addr > start)
-			map_mem_in_cams(0x4000000, CONFIG_LOWMEM_CAM_NUM);
+			map_mem_in_cams(0x4000000, CONFIG_LOWMEM_CAM_NUM,
+					false);
 		else
 			map_mem_in_cams_addr(start, PAGE_OFFSET + offset,
-					0x4000000, CONFIG_LOWMEM_CAM_NUM);
+					0x4000000, CONFIG_LOWMEM_CAM_NUM,
+					false);
 		restore_to_as0(n, offset, __va(dt_ptr), 1);
 		/* We should never reach here */
 		panic("Relocation error");
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 27c3a2d..9f58ff4 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -141,7 +141,8 @@ extern void MMU_init_hw(void);
 extern unsigned long mmu_mapin_ram(unsigned long top);
 
 #elif defined(CONFIG_PPC_FSL_BOOK3E)
-extern unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx);
+extern unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx,
+				     bool dryrun);
 extern unsigned long calc_cam_sz(unsigned long ram, unsigned long virt,
 				 phys_addr_t phys);
 #ifdef CONFIG_PPC32
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index a7381fb..bb04e4d 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -648,7 +648,7 @@ static void early_init_this_mmu(void)
 
 		if (map)
 			linear_map_top = map_mem_in_cams(linear_map_top,
-							 num_cams);
+							 num_cams, false);
 	}
 #endif
 
@@ -746,10 +746,14 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	 * entries are supported though that may eventually
 	 * change.
 	 *
-	 * on FSL Embedded 64-bit, we adjust the RMA size to match the
-	 * first bolted TLB entry size.  We still limit max to 1G even if
-	 * the TLB could cover more.  This is due to what the early init
-	 * code is setup to do.
+	 * on FSL Embedded 64-bit, usually all RAM is bolted, but with
+	 * unusual memory sizes it's possible for some RAM to not be mapped
+	 * (such RAM is not used at all by Linux, since we don't support
+	 * highmem on 64-bit).  We limit ppc64_rma_size to what would be
+	 * mappable if this memblock is the only one.  Additional memblocks
+	 * can only increase, not decrease, the amount that ends up getting
+	 * mapped.  We still limit max to 1G even if we'll eventually map
+	 * more.  This is due to what the early init code is set up to do.
 	 *
 	 * We crop it to the size of the first MEMBLOCK to
 	 * avoid going over total available memory just in case...
@@ -757,8 +761,14 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 #ifdef CONFIG_PPC_FSL_BOOK3E
 	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
 		unsigned long linear_sz;
-		linear_sz = calc_cam_sz(first_memblock_size, PAGE_OFFSET,
-					first_memblock_base);
+		unsigned int num_cams;
+
+		/* use a quarter of the TLBCAM for bolted linear map */
+		num_cams = (mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY) / 4;
+
+		linear_sz = map_mem_in_cams(first_memblock_size, num_cams,
+					    true);
+
 		ppc64_rma_size = min_t(u64, linear_sz, 0x40000000);
 	} else
 #endif
-- 
2.1.4
