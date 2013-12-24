Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x236.google.com (mail-pb0-x236.google.com
 [IPv6:2607:f8b0:400e:c01::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8CB232C04E3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Dec 2013 18:13:52 +1100 (EST)
Received: by mail-pb0-f54.google.com with SMTP id un15so6135720pbc.41
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2013 23:13:49 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v4 09/10] powerpc/fsl_booke: smp support for booting a
 relocatable kernel above 64M
Date: Tue, 24 Dec 2013 15:12:11 +0800
Message-Id: <1387869132-12650-10-git-send-email-haokexin@gmail.com>
In-Reply-To: <1387869132-12650-1-git-send-email-haokexin@gmail.com>
References: <1387869132-12650-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When booting above the 64M for a secondary cpu, we also face the
same issue as the boot cpu that the PAGE_OFFSET map two different
physical address for the init tlb and the final map. So we have to use
switch_to_as1/restore_to_as0 between the conversion of these two
maps. When restoring to as0 for a secondary cpu, we only need to
return to the caller. So add a new parameter for function
restore_to_as0 for this purpose.

Use LOAD_REG_ADDR_PIC to get the address of variables which may
be used before we set the final map in cams for the secondary cpu.
Move the setting of cams a bit earlier in order to avoid the
unnecessary using of LOAD_REG_ADDR_PIC.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v4: A new patch in v4.

 arch/powerpc/kernel/head_fsl_booke.S | 41 ++++++++++++++++++++++++------------
 arch/powerpc/mm/fsl_booke_mmu.c      |  4 ++--
 arch/powerpc/mm/mmu_decl.h           |  2 +-
 arch/powerpc/mm/tlb_nohash_low.S     |  4 +++-
 4 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 71e08dfbd1d1..0e545630c42a 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -216,8 +216,7 @@ set_ivor:
 	/* Check to see if we're the second processor, and jump
 	 * to the secondary_start code if so
 	 */
-	lis	r24, boot_cpuid@h
-	ori	r24, r24, boot_cpuid@l
+	LOAD_REG_ADDR_PIC(r24, boot_cpuid)
 	lwz	r24, 0(r24)
 	cmpwi	r24, -1
 	mfspr   r24,SPRN_PIR
@@ -1146,24 +1145,36 @@ _GLOBAL(__flush_disable_L1)
 /* When we get here, r24 needs to hold the CPU # */
 	.globl __secondary_start
 __secondary_start:
-	lis	r3,__secondary_hold_acknowledge@h
-	ori	r3,r3,__secondary_hold_acknowledge@l
-	stw	r24,0(r3)
-
-	li	r3,0
-	mr	r4,r24		/* Why? */
-	bl	call_setup_cpu
-
-	lis	r3,tlbcam_index@ha
-	lwz	r3,tlbcam_index@l(r3)
+	LOAD_REG_ADDR_PIC(r3, tlbcam_index)
+	lwz	r3,0(r3)
 	mtctr	r3
 	li	r26,0		/* r26 safe? */
 
+	bl	switch_to_as1
+	mr	r27,r3		/* tlb entry */
 	/* Load each CAM entry */
 1:	mr	r3,r26
 	bl	loadcam_entry
 	addi	r26,r26,1
 	bdnz	1b
+	mr	r3,r27		/* tlb entry */
+	LOAD_REG_ADDR_PIC(r4, memstart_addr)
+	lwz	r4,0(r4)
+	mr	r5,r25		/* phys kernel start */
+	rlwinm	r5,r5,0,~0x3ffffff	/* aligned 64M */
+	subf	r4,r5,r4	/* memstart_addr - phys kernel start */
+	li	r5,0		/* no device tree */
+	li	r6,0		/* not boot cpu */
+	bl	restore_to_as0
+
+
+	lis	r3,__secondary_hold_acknowledge@h
+	ori	r3,r3,__secondary_hold_acknowledge@l
+	stw	r24,0(r3)
+
+	li	r3,0
+	mr	r4,r24		/* Why? */
+	bl	call_setup_cpu
 
 	/* get current_thread_info and current */
 	lis	r1,secondary_ti@ha
@@ -1253,6 +1264,7 @@ _GLOBAL(switch_to_as1)
  * r3 - the tlb entry which should be invalidated
  * r4 - __pa(PAGE_OFFSET in AS0) - __pa(PAGE_OFFSET in AS1)
  * r5 - device tree virtual address. If r4 is 0, r5 is ignored.
+ * r6 - boot cpu
 */
 _GLOBAL(restore_to_as0)
 	mflr	r0
@@ -1268,6 +1280,7 @@ _GLOBAL(restore_to_as0)
 	 */
 	subf	r9,r4,r9
 	subf	r5,r4,r5
+	subf	r0,r4,r0
 
 2:	mfmsr	r7
 	li	r8,(MSR_IS | MSR_DS)
@@ -1290,7 +1303,9 @@ _GLOBAL(restore_to_as0)
 	isync
 
 	cmpwi	r4,0
-	bne	3f
+	cmpwi	cr1,r6,0
+	cror	eq,4*cr1+eq,eq
+	bne	3f			/* offset != 0 && is_boot_cpu */
 	mtlr	r0
 	blr
 
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index ce0c7d7db6c3..2a81f53d49f1 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -231,7 +231,7 @@ void __init adjust_total_lowmem(void)
 
 	i = switch_to_as1();
 	__max_low_memory = map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM);
-	restore_to_as0(i, 0, 0);
+	restore_to_as0(i, 0, 0, 1);
 
 	pr_info("Memory CAM mapping: ");
 	for (i = 0; i < tlbcam_index - 1; i++)
@@ -301,7 +301,7 @@ notrace void __init relocate_init(u64 dt_ptr, phys_addr_t start)
 		else
 			map_mem_in_cams_addr(start, PAGE_OFFSET - offset,
 					0x4000000, CONFIG_LOWMEM_CAM_NUM);
-		restore_to_as0(n, offset, __va(dt_ptr));
+		restore_to_as0(n, offset, __va(dt_ptr), 1);
 		/* We should never reach here */
 		panic("Relocation error");
 	}
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 91da910210cb..9615d82919b8 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -149,7 +149,7 @@ extern void MMU_init_hw(void);
 extern unsigned long mmu_mapin_ram(unsigned long top);
 extern void adjust_total_lowmem(void);
 extern int switch_to_as1(void);
-extern void restore_to_as0(int esel, int offset, void *dt_ptr);
+extern void restore_to_as0(int esel, int offset, void *dt_ptr, int bootcpu);
 #endif
 extern void loadcam_entry(unsigned int index);
 
diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/tlb_nohash_low.S
index 626ad081639f..43ff3c797fbf 100644
--- a/arch/powerpc/mm/tlb_nohash_low.S
+++ b/arch/powerpc/mm/tlb_nohash_low.S
@@ -402,7 +402,9 @@ _GLOBAL(set_context)
  * Load TLBCAM[index] entry in to the L2 CAM MMU
  */
 _GLOBAL(loadcam_entry)
-	LOAD_REG_ADDR(r4, TLBCAM)
+	mflr	r5
+	LOAD_REG_ADDR_PIC(r4, TLBCAM)
+	mtlr	r5
 	mulli	r5,r3,TLBCAM_SIZE
 	add	r3,r5,r4
 	lwz	r4,TLBCAM_MAS0(r3)
-- 
1.8.3.1
