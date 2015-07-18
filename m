Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B31BA1A0CEC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2015 06:09:22 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Tiejun Chen <tiejun.chen@intel.com>, <kexec@lists.infradead.org>, "Scott
 Wood" <scottwood@freescale.com>
Subject: [RFC PATCH 01/17] powerpc/85xx: Load all early TLB entries at once
Date: Sat, 18 Jul 2015 15:08:38 -0500
Message-ID: <1437250134-307-2-git-send-email-scottwood@freescale.com>
In-Reply-To: <1437250134-307-1-git-send-email-scottwood@freescale.com>
References: <1437250134-307-1-git-send-email-scottwood@freescale.com>
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

Use an AS=1 trampoline TLB entry to allow all normal TLB1 entries to
be loaded at once.  This avoids the need to keep the translation that
code is executing from in the same TLB entry in the final TLB
configuration as during early boot, which in turn is helpful for
relocatable kernels (e.g. kdump) where the kernel is not running from
what would be the first TLB entry.

On e6500, we limit map_mem_in_cams() to the primary hwthread of a
core (the boot cpu is always considered primary, as a kdump kernel
can be entered on any cpu),  Each TLB only needs to be set up once,
and when we do, we don't want another thread to be running when we
create a temporary trampoline TLB1 entry.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/setup_64.c   |  8 +++++
 arch/powerpc/mm/fsl_booke_mmu.c  | 15 ++++++++--
 arch/powerpc/mm/mmu_decl.h       |  1 +
 arch/powerpc/mm/tlb_nohash.c     | 19 +++++++++++-
 arch/powerpc/mm/tlb_nohash_low.S | 63 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index bdcbb71..505ec2c 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -108,6 +108,14 @@ static void setup_tlb_core_data(void)
 	for_each_possible_cpu(cpu) {
 		int first = cpu_first_thread_sibling(cpu);
 
+		/*
+		 * If we boot via kdump on a non-primary thread,
+		 * make sure we point at the thread that actually
+		 * set up this TLB.
+		 */
+		if (cpu_first_thread_sibling(boot_cpuid) == first)
+			first = boot_cpuid;
+
 		paca[cpu].tcd_ptr = &paca[first].tcd;
 
 		/*
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 354ba3c..36d3c55 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -105,8 +105,9 @@ unsigned long p_mapped_by_tlbcam(phys_addr_t pa)
  * an unsigned long (for example, 32-bit implementations cannot support a 4GB
  * size).
  */
-static void settlbcam(int index, unsigned long virt, phys_addr_t phys,
-		unsigned long size, unsigned long flags, unsigned int pid)
+static void preptlbcam(int index, unsigned long virt, phys_addr_t phys,
+		       unsigned long size, unsigned long flags,
+		       unsigned int pid)
 {
 	unsigned int tsize;
 
@@ -141,7 +142,13 @@ static void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 	tlbcam_addrs[index].start = virt;
 	tlbcam_addrs[index].limit = virt + size - 1;
 	tlbcam_addrs[index].phys = phys;
+}
 
+void settlbcam(int index, unsigned long virt, phys_addr_t phys,
+	       unsigned long size, unsigned long flags,
+	       unsigned int pid)
+{
+	preptlbcam(index, virt, phys, size, flags, pid);
 	loadcam_entry(index);
 }
 
@@ -181,13 +188,15 @@ static unsigned long map_mem_in_cams_addr(phys_addr_t phys, unsigned long virt,
 		unsigned long cam_sz;
 
 		cam_sz = calc_cam_sz(ram, virt, phys);
-		settlbcam(i, virt, phys, cam_sz, pgprot_val(PAGE_KERNEL_X), 0);
+		preptlbcam(i, virt, phys, cam_sz, pgprot_val(PAGE_KERNEL_X), 0);
 
 		ram -= cam_sz;
 		amount_mapped += cam_sz;
 		virt += cam_sz;
 		phys += cam_sz;
 	}
+
+	loadcam_multi(0, i, max_cam_idx);
 	tlbcam_index = i;
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 085b66b..27c3a2d 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -152,6 +152,7 @@ extern int switch_to_as1(void);
 extern void restore_to_as0(int esel, int offset, void *dt_ptr, int bootcpu);
 #endif
 extern void loadcam_entry(unsigned int index);
+extern void loadcam_multi(int first_idx, int num, int tmp_idx);
 
 struct tlbcam {
 	u32	MAS0;
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 723a099..a7381fb 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -42,6 +42,7 @@
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include <asm/code-patching.h>
+#include <asm/cputhreads.h>
 #include <asm/hugetlb.h>
 #include <asm/paca.h>
 
@@ -628,10 +629,26 @@ static void early_init_this_mmu(void)
 #ifdef CONFIG_PPC_FSL_BOOK3E
 	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
 		unsigned int num_cams;
+		int __maybe_unused cpu = smp_processor_id();
+		bool map = true;
 
 		/* use a quarter of the TLBCAM for bolted linear map */
 		num_cams = (mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY) / 4;
-		linear_map_top = map_mem_in_cams(linear_map_top, num_cams);
+
+		/*
+		 * Only do the mapping once per core, or else the
+		 * transient mapping would cause problems.
+		 */
+#ifdef CONFIG_SMP
+		if (cpu != boot_cpuid &&
+		    (cpu != cpu_first_thread_sibling(cpu) ||
+		     cpu == cpu_first_thread_sibling(boot_cpuid)))
+			map = false;
+#endif
+
+		if (map)
+			linear_map_top = map_mem_in_cams(linear_map_top,
+							 num_cams);
 	}
 #endif
 
diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/tlb_nohash_low.S
index 43ff3c7..68c4775 100644
--- a/arch/powerpc/mm/tlb_nohash_low.S
+++ b/arch/powerpc/mm/tlb_nohash_low.S
@@ -400,6 +400,7 @@ _GLOBAL(set_context)
  * extern void loadcam_entry(unsigned int index)
  *
  * Load TLBCAM[index] entry in to the L2 CAM MMU
+ * Must preserve r7, r8, r9, and r10
  */
 _GLOBAL(loadcam_entry)
 	mflr	r5
@@ -423,4 +424,66 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_BIG_PHYS)
 	tlbwe
 	isync
 	blr
+
+/*
+ * Load multiple TLB entries at once, using an alternate-space
+ * trampoline so that we don't have to care about whether the same
+ * TLB entry maps us before and after.
+ *
+ * r3 = first entry to write
+ * r4 = number of entries to write
+ * r5 = temporary tlb entry
+ */
+_GLOBAL(loadcam_multi)
+	mflr	r8
+
+	/*
+	 * Set up temporary TLB entry that is the same as what we're
+	 * running from, but in AS=1.
+	 */
+	bl	1f
+1:	mflr	r6
+	tlbsx	0,r8
+	mfspr	r6,SPRN_MAS1
+	ori	r6,r6,MAS1_TS
+	mtspr	SPRN_MAS1,r6
+	mfspr	r6,SPRN_MAS0
+	rlwimi	r6,r5,MAS0_ESEL_SHIFT,MAS0_ESEL_MASK
+	mr	r7,r5
+	mtspr	SPRN_MAS0,r6
+	isync
+	tlbwe
+	isync
+
+	/* Switch to AS=1 */
+	mfmsr	r6
+	ori	r6,r6,MSR_IS|MSR_DS
+	mtmsr	r6
+	isync
+
+	mr	r9,r3
+	add	r10,r3,r4
+2:	bl	loadcam_entry
+	addi	r9,r9,1
+	cmpw	r9,r10
+	mr	r3,r9
+	blt	2b
+
+	/* Return to AS=0 and clear the temporary entry */
+	mfmsr	r6
+	rlwinm.	r6,r6,0,~(MSR_IS|MSR_DS)
+	mtmsr	r6
+	isync
+
+	li	r6,0
+	mtspr	SPRN_MAS1,r6
+	rlwinm	r6,r7,MAS0_ESEL_SHIFT,MAS0_ESEL_MASK
+	oris	r6,r6,MAS0_TLBSEL(1)@h
+	mtspr	SPRN_MAS0,r6
+	isync
+	tlbwe
+	isync
+
+	mtlr	r8
+	blr
 #endif
-- 
2.1.4
