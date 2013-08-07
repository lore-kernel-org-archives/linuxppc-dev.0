Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EBAC42C009F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 11:22:12 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>, Kumar Gala
 <galak@kernel.crashing.org>
Subject: [PATCH v3 4/7] powerpc/fsl_booke: set the tlb entry for the kernel
 address in AS1
Date: Wed, 7 Aug 2013 09:18:32 +0800
Message-ID: <1375838315-27797-5-git-send-email-haokexin@gmail.com>
In-Reply-To: <1375838315-27797-1-git-send-email-haokexin@gmail.com>
References: <1375838315-27797-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We use the tlb1 entries to map low mem to the kernel space. In the
current code, it assumes that the first tlb entry would cover the
kernel image. But this is not true for some special cases, such as
when we run a relocatable kernel above the 64M or set
CONFIG_KERNEL_START above 64M. So we choose to switch to address
space 1 before setting these tlb entries.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v3: Typo fix.

v2: A new patch in v2.

 arch/powerpc/kernel/head_fsl_booke.S | 81 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/fsl_booke_mmu.c      |  2 +
 arch/powerpc/mm/mmu_decl.h           |  2 +
 3 files changed, 85 insertions(+)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index f6ec9a3..7e9724e 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -1170,6 +1170,87 @@ __secondary_hold_acknowledge:
 #endif
 
 /*
+ * Create a tlb entry with the same effective and physical address as
+ * the tlb entry used by the current running code. But set the TS to 1.
+ * Then switch to the address space 1. It will return with the r3 set to
+ * the ESEL of the new created tlb.
+ */
+_GLOBAL(switch_to_as1)
+	mflr	r5
+
+	/* Find a entry not used */
+	mfspr	r3,SPRN_TLB1CFG
+	andi.	r3,r3,0xfff
+	mfspr	r4,SPRN_PID
+	rlwinm	r4,r4,16,0x3fff0000	/* turn PID into MAS6[SPID] */
+	mtspr	SPRN_MAS6,r4
+1:	lis	r4,0x1000		/* Set MAS0(TLBSEL) = 1 */
+	addi	r3,r3,-1
+	rlwimi	r4,r3,16,4,15		/* Setup MAS0 = TLBSEL | ESEL(r3) */
+	mtspr	SPRN_MAS0,r4
+	tlbre
+	mfspr	r4,SPRN_MAS1
+	andis.	r4,r4,MAS1_VALID@h
+	bne	1b
+
+	/* Get the tlb entry used by the current running code */
+	bl	0f
+0:	mflr	r4
+	tlbsx	0,r4
+
+	mfspr	r4,SPRN_MAS1
+	ori	r4,r4,MAS1_TS		/* Set the TS = 1 */
+	mtspr	SPRN_MAS1,r4
+
+	mfspr	r4,SPRN_MAS0
+	rlwinm	r4,r4,0,~MAS0_ESEL_MASK
+	rlwimi	r4,r3,16,4,15		/* Setup MAS0 = TLBSEL | ESEL(r3) */
+	mtspr	SPRN_MAS0,r4
+	tlbwe
+	isync
+	sync
+
+	mfmsr	r4
+	ori	r4,r4,MSR_IS | MSR_DS
+	mtspr	SPRN_SRR0,r5
+	mtspr	SPRN_SRR1,r4
+	sync
+	rfi
+
+/*
+ * Restore to the address space 0 and also invalidate the tlb entry created
+ * by switch_to_as1.
+*/
+_GLOBAL(restore_to_as0)
+	mflr	r0
+
+	bl	0f
+0:	mflr	r9
+	addi	r9,r9,1f - 0b
+
+	mfmsr	r7
+	li	r8,(MSR_IS | MSR_DS)
+	andc	r7,r7,r8
+
+	mtspr	SPRN_SRR0,r9
+	mtspr	SPRN_SRR1,r7
+	sync
+	rfi
+
+	/* Invalidate the temporary tlb entry for AS1 */
+1:	lis	r9,0x1000		/* Set MAS0(TLBSEL) = 1 */
+	rlwimi	r9,r3,16,4,15		/* Setup MAS0 = TLBSEL | ESEL(r3) */
+	mtspr	SPRN_MAS0,r9
+	tlbre
+	mfspr	r9,SPRN_MAS1
+	rlwinm	r9,r9,0,2,31		/* Clear MAS1 Valid and IPPROT */
+	mtspr	SPRN_MAS1,r9
+	tlbwe
+	isync
+	mtlr	r0
+	blr
+
+/*
  * We put a few things here that have to be page-aligned. This stuff
  * goes at the beginning of the data segment, which is page-aligned.
  */
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index ce4a116..1d54f6d 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -222,7 +222,9 @@ void __init adjust_total_lowmem(void)
 	/* adjust lowmem size to __max_low_memory */
 	ram = min((phys_addr_t)__max_low_memory, (phys_addr_t)total_lowmem);
 
+	i = switch_to_as1();
 	__max_low_memory = map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM);
+	restore_to_as0(i);
 
 	pr_info("Memory CAM mapping: ");
 	for (i = 0; i < tlbcam_index - 1; i++)
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 83eb5d5..eefbf7b 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -148,6 +148,8 @@ extern unsigned long calc_cam_sz(unsigned long ram, unsigned long virt,
 extern void MMU_init_hw(void);
 extern unsigned long mmu_mapin_ram(unsigned long top);
 extern void adjust_total_lowmem(void);
+extern int switch_to_as1(void);
+extern void restore_to_as0(int esel);
 #endif
 extern void loadcam_entry(unsigned int index);
 
-- 
1.8.3.1
