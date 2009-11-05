Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D631B7BA5
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 02:22:07 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id nA5FLmJd006725
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Nov 2009 09:21:59 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl-booke: Rework TLB CAM code
Date: Thu,  5 Nov 2009 09:21:48 -0600
Message-Id: <1257434508-14695-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Re-write the code so its more standalone and fixed some issues:
* Bump'd # of CAM entries to 64 to support e500mc
* Make the code handle MAS7 properly
* Use pr_cont instead of creating a string as we go

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/asm-offsets.c    |    3 -
 arch/powerpc/kernel/head_fsl_booke.S |   22 ------
 arch/powerpc/mm/fsl_booke_mmu.c      |  132 +++++++++++++++++++---------------
 arch/powerpc/mm/mmu_decl.h           |   11 ---
 4 files changed, 74 insertions(+), 94 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index e2e2082..a6c2b63 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -421,9 +421,6 @@ int main(void)
 	DEFINE(PGD_T_LOG2, PGD_T_LOG2);
 	DEFINE(PTE_T_LOG2, PTE_T_LOG2);
 #endif
-#ifdef CONFIG_FSL_BOOKE
-	DEFINE(TLBCAM_SIZE, sizeof(struct tlbcam));
-#endif
 
 #ifdef CONFIG_KVM_EXIT_TIMING
 	DEFINE(VCPU_TIMING_EXIT_TBU, offsetof(struct kvm_vcpu,
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 975788c..7f4bd7f 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -944,28 +944,6 @@ _GLOBAL(__setup_e500mc_ivors)
 	blr
 
 /*
- * extern void loadcam_entry(unsigned int index)
- *
- * Load TLBCAM[index] entry in to the L2 CAM MMU
- */
-_GLOBAL(loadcam_entry)
-	lis	r4,TLBCAM@ha
-	addi	r4,r4,TLBCAM@l
-	mulli	r5,r3,TLBCAM_SIZE
-	add	r3,r5,r4
-	lwz	r4,0(r3)
-	mtspr	SPRN_MAS0,r4
-	lwz	r4,4(r3)
-	mtspr	SPRN_MAS1,r4
-	lwz	r4,8(r3)
-	mtspr	SPRN_MAS2,r4
-	lwz	r4,12(r3)
-	mtspr	SPRN_MAS3,r4
-	tlbwe
-	isync
-	blr
-
-/*
  * extern void giveup_altivec(struct task_struct *prev)
  *
  * The e500 core does not have an AltiVec unit.
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index dc93e95..b8fac4f 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -54,26 +54,35 @@
 
 #include "mmu_decl.h"
 
-extern void loadcam_entry(unsigned int index);
 unsigned int tlbcam_index;
-static unsigned long cam[CONFIG_LOWMEM_CAM_NUM];
 
-#define NUM_TLBCAMS	(16)
+#define NUM_TLBCAMS	(64)
 
 #if defined(CONFIG_LOWMEM_CAM_NUM_BOOL) && (CONFIG_LOWMEM_CAM_NUM >= NUM_TLBCAMS)
 #error "LOWMEM_CAM_NUM must be less than NUM_TLBCAMS"
 #endif
 
-struct tlbcam TLBCAM[NUM_TLBCAMS];
+struct tlbcam {
+	u32	MAS0;
+	u32	MAS1;
+	unsigned long	MAS2;
+	u32	MAS3;
+	u32	MAS7;
+} TLBCAM[NUM_TLBCAMS];
 
 struct tlbcamrange {
-   	unsigned long start;
+	unsigned long start;
 	unsigned long limit;
 	phys_addr_t phys;
 } tlbcam_addrs[NUM_TLBCAMS];
 
 extern unsigned int tlbcam_index;
 
+unsigned long tlbcam_sz(int idx)
+{
+	return tlbcam_addrs[idx].limit - tlbcam_addrs[idx].start + 1;
+}
+
 /*
  * Return PA for this VA if it is mapped by a CAM, or 0
  */
@@ -94,23 +103,36 @@ unsigned long p_mapped_by_tlbcam(phys_addr_t pa)
 	int b;
 	for (b = 0; b < tlbcam_index; ++b)
 		if (pa >= tlbcam_addrs[b].phys
-	    	    && pa < (tlbcam_addrs[b].limit-tlbcam_addrs[b].start)
+			&& pa < (tlbcam_addrs[b].limit-tlbcam_addrs[b].start)
 		              +tlbcam_addrs[b].phys)
 			return tlbcam_addrs[b].start+(pa-tlbcam_addrs[b].phys);
 	return 0;
 }
 
+void loadcam_entry(int idx)
+{
+	mtspr(SPRN_MAS0, TLBCAM[idx].MAS0);
+	mtspr(SPRN_MAS1, TLBCAM[idx].MAS1);
+	mtspr(SPRN_MAS2, TLBCAM[idx].MAS2);
+	mtspr(SPRN_MAS3, TLBCAM[idx].MAS3);
+
+	if (cur_cpu_spec->cpu_features & MMU_FTR_BIG_PHYS)
+		mtspr(SPRN_MAS7, TLBCAM[idx].MAS7);
+
+	asm volatile("isync;tlbwe;isync" : : : "memory");
+}
+
 /*
  * Set up one of the I/D BAT (block address translation) register pairs.
  * The parameters are not checked; in particular size must be a power
  * of 4 between 4k and 256M.
  */
-void settlbcam(int index, unsigned long virt, phys_addr_t phys,
-		unsigned int size, int flags, unsigned int pid)
+static void settlbcam(int index, unsigned long virt, phys_addr_t phys,
+		unsigned long size, unsigned long flags, unsigned int pid)
 {
 	unsigned int tsize, lz;
 
-	asm ("cntlzw %0,%1" : "=r" (lz) : "r" (size));
+	asm (PPC_CNTLZL "%0,%1" : "=r" (lz) : "r" (size));
 	tsize = 21 - lz;
 
 #ifdef CONFIG_SMP
@@ -128,8 +150,10 @@ void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 	TLBCAM[index].MAS2 |= (flags & _PAGE_GUARDED) ? MAS2_G : 0;
 	TLBCAM[index].MAS2 |= (flags & _PAGE_ENDIAN) ? MAS2_E : 0;
 
-	TLBCAM[index].MAS3 = (phys & PAGE_MASK) | MAS3_SX | MAS3_SR;
+	TLBCAM[index].MAS3 = (phys & MAS3_RPN) | MAS3_SX | MAS3_SR;
 	TLBCAM[index].MAS3 |= ((flags & _PAGE_RW) ? MAS3_SW : 0);
+	if (cur_cpu_spec->cpu_features & MMU_FTR_BIG_PHYS)
+		TLBCAM[index].MAS7 = phys >> 32;
 
 #ifndef CONFIG_KGDB /* want user access for breakpoints */
 	if (flags & _PAGE_USER) {
@@ -148,27 +172,44 @@ void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 	loadcam_entry(index);
 }
 
-void invalidate_tlbcam_entry(int index)
-{
-	TLBCAM[index].MAS0 = MAS0_TLBSEL(1) | MAS0_ESEL(index);
-	TLBCAM[index].MAS1 = ~MAS1_VALID;
-
-	loadcam_entry(index);
-}
-
-unsigned long __init mmu_mapin_ram(void)
+unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx)
 {
+	int i;
 	unsigned long virt = PAGE_OFFSET;
 	phys_addr_t phys = memstart_addr;
+	unsigned long amount_mapped = 0;
+	unsigned long max_cam = (mfspr(SPRN_TLB1CFG) >> 16) & 0xf;
+
+	/* Convert (4^max) kB to (2^max) bytes */
+	max_cam = max_cam * 2 + 10;
 
-	while (tlbcam_index < ARRAY_SIZE(cam) && cam[tlbcam_index]) {
-		settlbcam(tlbcam_index, virt, phys, cam[tlbcam_index], PAGE_KERNEL_X, 0);
-		virt += cam[tlbcam_index];
-		phys += cam[tlbcam_index];
-		tlbcam_index++;
+	/* Calculate CAM values */
+	for (i = 0; ram && i < max_cam_idx; i++) {
+		unsigned int camsize = __ilog2(ram) & ~1U;
+		unsigned int align = __ffs(virt | phys) & ~1U;
+		unsigned long cam_sz;
+
+		if (camsize > align)
+			camsize = align;
+		if (camsize > max_cam)
+			camsize = max_cam;
+
+		cam_sz = 1UL << camsize;
+		settlbcam(i, virt, phys, cam_sz, PAGE_KERNEL_X, 0);
+
+		ram -= cam_sz;
+		amount_mapped += cam_sz;
+		virt += cam_sz;
+		phys += cam_sz;
 	}
+	tlbcam_index = i;
+
+	return amount_mapped;
+}
 
-	return virt - PAGE_OFFSET;
+unsigned long __init mmu_mapin_ram(void)
+{
+	return tlbcam_addrs[tlbcam_index - 1].limit - PAGE_OFFSET + 1;
 }
 
 /*
@@ -179,46 +220,21 @@ void __init MMU_init_hw(void)
 	flush_instruction_cache();
 }
 
-void __init
-adjust_total_lowmem(void)
+void __init adjust_total_lowmem(void)
 {
-	phys_addr_t ram;
-	unsigned int max_cam = (mfspr(SPRN_TLB1CFG) >> 16) & 0xff;
-	char buf[ARRAY_SIZE(cam) * 5 + 1], *p = buf;
+	unsigned long ram;
 	int i;
-	unsigned long virt = PAGE_OFFSET & 0xffffffffUL;
-	unsigned long phys = memstart_addr & 0xffffffffUL;
-
-	/* Convert (4^max) kB to (2^max) bytes */
-	max_cam = max_cam * 2 + 10;
 
 	/* adjust lowmem size to __max_low_memory */
 	ram = min((phys_addr_t)__max_low_memory, (phys_addr_t)total_lowmem);
 
-	/* Calculate CAM values */
-	__max_low_memory = 0;
-	for (i = 0; ram && i < ARRAY_SIZE(cam); i++) {
-		unsigned int camsize = __ilog2(ram) & ~1U;
-		unsigned int align = __ffs(virt | phys) & ~1U;
+	__max_low_memory = map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM);
 
-		if (camsize > align)
-			camsize = align;
-		if (camsize > max_cam)
-			camsize = max_cam;
-
-		cam[i] = 1UL << camsize;
-		ram -= cam[i];
-		__max_low_memory += cam[i];
-		virt += cam[i];
-		phys += cam[i];
-
-		p += sprintf(p, "%lu/", cam[i] >> 20);
-	}
-	for (; i < ARRAY_SIZE(cam); i++)
-		p += sprintf(p, "0/");
-	p[-1] = '\0';
-
-	pr_info("Memory CAM mapping: %s Mb, residual: %dMb\n", buf,
+	pr_info("Memory CAM mapping: ");
+	for (i = 0; i < tlbcam_index - 1; i++)
+		pr_cont("%lu/", tlbcam_sz(i) >> 20);
+	pr_cont("%lu Mb, residual: %dMb\n", tlbcam_sz(tlbcam_index - 1) >> 20,
 	        (unsigned int)((total_lowmem - __max_low_memory) >> 20));
+
 	__initial_memory_limit_addr = memstart_addr + __max_low_memory;
 }
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index d2e5321..e27a990 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -98,21 +98,10 @@ extern void _tlbia(void);
 
 #ifdef CONFIG_PPC32
 
-struct tlbcam {
-	u32	MAS0;
-	u32	MAS1;
-	u32	MAS2;
-	u32	MAS3;
-	u32	MAS7;
-};
-
 extern void mapin_ram(void);
 extern int map_page(unsigned long va, phys_addr_t pa, int flags);
 extern void setbat(int index, unsigned long virt, phys_addr_t phys,
 		   unsigned int size, int flags);
-extern void settlbcam(int index, unsigned long virt, phys_addr_t phys,
-		      unsigned int size, int flags, unsigned int pid);
-extern void invalidate_tlbcam_entry(int index);
 
 extern int __map_without_bats;
 extern unsigned long ioremap_base;
-- 
1.6.0.6
