Return-Path: <Dongsheng.Wang@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 450452C0392
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 19:03:26 +1100 (EST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>, <benh@kernel.crashing.org>
Subject: [PATCH 2/3] powerpc/85xx: Provide two functions to save/restore the
 core registers
Date: Tue, 14 Jan 2014 15:59:56 +0800
Message-ID: <1389686397-46555-2-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1389686397-46555-1-git-send-email-dongsheng.wang@freescale.com>
References: <1389686397-46555-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: anton@enomsg.org, linuxppc-dev@lists.ozlabs.org, chenhui.zhao@freescale.com,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

Add fsl_cpu_state_save/fsl_cpu_state_restore functions, used for deep
sleep and hibernation to save/restore core registers. We abstract out
save/restore code for use in various modules, to make them don't need
to maintain.

Currently supported processors type are E6500, E5500, E500MC, E500v2 and
E500v1.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/arch/powerpc/include/asm/fsl_sleep.h b/arch/powerpc/include/asm/fsl_sleep.h
new file mode 100644
index 0000000..31c8a9b
--- /dev/null
+++ b/arch/powerpc/include/asm/fsl_sleep.h
@@ -0,0 +1,98 @@
+/*
+ * Freescale 85xx Power management set
+ *
+ * Author: Wang Dongsheng <dongsheng.wang@freescale.com>
+ *
+ * Copyright 2014 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_FSL_SLEEP_H
+#define __ASM_FSL_SLEEP_H
+
+/*
+ * Freescale 85xx Core registers set, core register map definition
+ * Address base on r3, we need to compatible with both 32-bit and 64-bit, so
+ * the data width is 64-bit(double word).
+ *
+ * Acronyms:
+ *	dw(data width)	0x08
+ *
+ * Map:
+ * General-Purpose Registers
+ *	GPR1(sp)		0
+ *	GPR2			0x8		(dw * 1)
+ *	GPR13 - GPR31		0x10 ~ 0xa0	(dw * 2 ~ dw * 20)
+ * Foating-point registers
+ *	FPR14 - FPR31		0xa8 ~ 0x130	(dw * 21 ~ dw * 38)
+ * Registers for Branch Operations
+ *	CR			0x138		(dw * 39)
+ *	LR			0x140		(dw * 40)
+ * Processor Control Registers
+ *	MSR			0x148		(dw * 41)
+ *	EPCR			0x150		(dw * 42)
+ *
+ *	Only e500, e500v2 need to save HID0 - HID1
+ *	HID0 - HID1		0x158 ~ 0x160 (dw * 43 ~ dw * 44)
+ * Timer Registers
+ *	TCR			0x168		(dw * 45)
+ *	TB(64bit)		0x170		(dw * 46)
+ *	TBU(32bit)		0x178		(dw * 47)
+ *	TBL(32bit)		0x180		(dw * 48)
+ * Interrupt Registers
+ *	IVPR			0x188		(dw * 49)
+ *	IVOR0 - IVOR15		0x190 ~ 0x208	(dw * 50 ~ dw * 65)
+ *	IVOR32 - IVOR41		0x210 ~ 0x258	(dw * 66 ~ dw * 75)
+ * Software-Use Registers
+ *	SPRG1			0x260		(dw * 76), 64-bit need to save.
+ *	SPRG3			0x268		(dw * 77), 32-bit need to save.
+ * MMU Registers
+ *	PID0 - PID2		0x270 ~ 0x280	(dw * 78 ~ dw * 80)
+ * Debug Registers
+ *	DBCR0 - DBCR2		0x288 ~ 0x298	(dw * 81 ~ dw * 83)
+ *	IAC1 - IAC4		0x2a0 ~ 0x2b8	(dw * 84 ~ dw * 87)
+ *	DAC1 - DAC2		0x2c0 ~ 0x2c8	(dw * 88 ~ dw * 89)
+ *
+ */
+
+#define SR_GPR1			0x000
+#define SR_GPR2			0x008
+#define SR_GPR13		0x010
+#define SR_FPR14		0x0a8
+#define SR_CR			0x138
+#define SR_LR			0x140
+#define SR_MSR			0x148
+#define SR_EPCR			0x150
+#define SR_HID0			0x158
+#define SR_TCR			0x168
+#define SR_TB			0x170
+#define SR_TBU			0x178
+#define SR_TBL			0x180
+#define SR_IVPR			0x188
+#define SR_IVOR0		0x190
+#define SR_IVOR32		0x210
+#define SR_SPRG1		0x260
+#define SR_SPRG3		0x268
+#define SR_PID0			0x270
+#define SR_DBCR0		0x288
+#define SR_IAC1			0x2a0
+#define SR_DAC1			0x2c0
+#define FSL_CPU_SR_SIZE		(SR_DAC1 + 0x10)
+
+#ifndef __ASSEMBLY__
+
+enum core_save_type {
+	BASE_SAVE = 0,
+	ALL_SAVE = 1,
+};
+
+extern int fsl_cpu_state_save(void *save_page, enum core_save_type type);
+extern int fsl_cpu_state_restore(void *restore_page, enum core_save_type type);
+
+#endif
+
+#endif
+
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 25cebe7..650a01c 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -4,6 +4,7 @@
 obj-$(CONFIG_SMP) += smp.o
 
 obj-y += common.o
+obj-y += save-core.o
 
 obj-$(CONFIG_BSC9131_RDB) += bsc913x_rdb.o
 obj-$(CONFIG_C293_PCIE)   += c293pcie.o
diff --git a/arch/powerpc/platforms/85xx/save-core.S b/arch/powerpc/platforms/85xx/save-core.S
new file mode 100644
index 0000000..a6b93b8
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/save-core.S
@@ -0,0 +1,497 @@
+/*
+ * Freescale Power Management, Save/Restore core state
+ *
+ * Copyright 2014 Freescale Semiconductor, Inc.
+ * Author: Wang Dongsheng <dongsheng.wang@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/ppc_asm.h>
+#include <asm/fsl_sleep.h>
+
+/*
+ * Freescale 85xx Cores
+ * Support Core List:
+ * E500v1, E500v2, E500MC, E5500, E6500.
+ */
+
+ /*
+ * Save/Restore register operation define
+ */
+#define LOAD_SAVE_ADDRESS	\
+	mr	r10, r3
+
+#ifdef CONFIG_PPC64
+#define PPC_STD(sreg, offset, areg) \
+	std	sreg, (offset)(areg)
+#define PPC_LD(lreg, offset, areg) \
+	ld	lreg, (offset)(areg)
+
+#define PPC_STFD(sreg, offset, areg) \
+	stfd	sreg, (offset)(areg)
+#define PPC_LFD(lreg, offset, areg) \
+	lfd	lreg, (offset)(areg)
+#else
+#define PPC_STD(sreg, offset, areg) \
+	stw	sreg, (offset)(areg)
+#define PPC_LD(lreg, offset, areg) \
+	lwz	lreg, (offset)(areg)
+
+#define PPC_STFD(sreg, offset, areg) \
+	stfs	sreg, (offset)(areg)
+#define PPC_LFD(lreg, offset, areg) \
+	lfs	lreg, (offset)(areg)
+#endif
+
+#define do_save_gpr_reg(reg, addr) \
+	mr	r0, reg ;\
+	PPC_STD(r0, addr, r10)
+
+#define do_restore_gpr_reg(reg, addr) \
+	PPC_LD(r0, addr, r10) ;\
+	mr	reg, r0
+
+#define do_save_fpr_reg(reg, addr) \
+	fmr	fr0, reg ;\
+	PPC_STFD(fr0, addr, r10)
+
+#define do_restore_fpr_reg(reg, addr) \
+	PPC_LFD(fr0, addr, r10) ;\
+	fmr	reg, fr0
+
+#define do_save_spr_reg(reg, addr) \
+	mfspr	r0, SPRN_##reg ;\
+	PPC_STD(r0, addr, r10)
+
+#define do_restore_spr_reg(reg, addr) \
+	PPC_LD(r0, addr, r10) ;\
+	mtspr	SPRN_##reg, r0
+
+#define do_save_special_reg(special, addr) \
+	mf##special	r0 ;\
+	PPC_STD(r0, addr, r10)
+#define do_restore_special_reg(special, addr) \
+	PPC_LD(r0, addr, r10) ;\
+	mt##special	r0
+
+#define do_sr_general_gpr_regs(func) \
+	do_##func##_gpr_reg(r1, SR_GPR1) ;\
+	do_##func##_gpr_reg(r2, SR_GPR2) ;\
+	do_##func##_gpr_reg(r13, SR_GPR13 + 0x00) ;\
+	do_##func##_gpr_reg(r14, SR_GPR13 + 0x08) ;\
+	do_##func##_gpr_reg(r15, SR_GPR13 + 0x10) ;\
+	do_##func##_gpr_reg(r16, SR_GPR13 + 0x18) ;\
+	do_##func##_gpr_reg(r17, SR_GPR13 + 0x20) ;\
+	do_##func##_gpr_reg(r18, SR_GPR13 + 0x28) ;\
+	do_##func##_gpr_reg(r19, SR_GPR13 + 0x30) ;\
+	do_##func##_gpr_reg(r20, SR_GPR13 + 0x38) ;\
+	do_##func##_gpr_reg(r21, SR_GPR13 + 0x40) ;\
+	do_##func##_gpr_reg(r22, SR_GPR13 + 0x48) ;\
+	do_##func##_gpr_reg(r23, SR_GPR13 + 0x50) ;\
+	do_##func##_gpr_reg(r24, SR_GPR13 + 0x58) ;\
+	do_##func##_gpr_reg(r25, SR_GPR13 + 0x60) ;\
+	do_##func##_gpr_reg(r26, SR_GPR13 + 0x68) ;\
+	do_##func##_gpr_reg(r27, SR_GPR13 + 0x70) ;\
+	do_##func##_gpr_reg(r28, SR_GPR13 + 0x78) ;\
+	do_##func##_gpr_reg(r29, SR_GPR13 + 0x80) ;\
+	do_##func##_gpr_reg(r30, SR_GPR13 + 0x88) ;\
+	do_##func##_gpr_reg(r31, SR_GPR13 + 0x90)
+
+#define do_sr_fpr_regs(func) \
+	do_##func##_fpr_reg(fr14, SR_FPR14 + 0x00) ;\
+	do_##func##_fpr_reg(fr15, SR_FPR14 + 0x08) ;\
+	do_##func##_fpr_reg(fr16, SR_FPR14 + 0x10) ;\
+	do_##func##_fpr_reg(fr17, SR_FPR14 + 0x18) ;\
+	do_##func##_fpr_reg(fr18, SR_FPR14 + 0x20) ;\
+	do_##func##_fpr_reg(fr19, SR_FPR14 + 0x28) ;\
+	do_##func##_fpr_reg(fr20, SR_FPR14 + 0x30) ;\
+	do_##func##_fpr_reg(fr21, SR_FPR14 + 0x38) ;\
+	do_##func##_fpr_reg(fr22, SR_FPR14 + 0x40) ;\
+	do_##func##_fpr_reg(fr23, SR_FPR14 + 0x48) ;\
+	do_##func##_fpr_reg(fr24, SR_FPR14 + 0x50) ;\
+	do_##func##_fpr_reg(fr25, SR_FPR14 + 0x58) ;\
+	do_##func##_fpr_reg(fr26, SR_FPR14 + 0x60) ;\
+	do_##func##_fpr_reg(fr27, SR_FPR14 + 0x68) ;\
+	do_##func##_fpr_reg(fr28, SR_FPR14 + 0x70) ;\
+	do_##func##_fpr_reg(fr29, SR_FPR14 + 0x78) ;\
+	do_##func##_fpr_reg(fr30, SR_FPR14 + 0x80) ;\
+	do_##func##_fpr_reg(fr31, SR_FPR14 + 0x88)
+
+#define do_sr_general_branch_regs(func) \
+	do_##func##_special_reg(CR, SR_CR)
+
+#define do_sr_general_pcr_regs(func) \
+	do_##func##_special_reg(MSR, SR_MSR) ;\
+	do_##func##_spr_reg(EPCR, SR_EPCR) ;\
+	do_##func##_spr_reg(HID0, SR_HID0 + 0x00)
+
+#define do_sr_e500_pcr_regs(func) \
+	do_##func##_spr_reg(HID1, SR_HID0 + 0x08)
+
+#define do_sr_save_tb_regs \
+	do_save_spr_reg(TBRU, SR_TBU) ;\
+	do_save_spr_reg(TBRL, SR_TBL)
+
+#define do_sr_restore_tb_regs \
+	do_restore_spr_reg(TBWU, SR_TBU) ;\
+	do_restore_spr_reg(TBWL, SR_TBL)
+
+#define do_sr_general_time_regs(func) \
+	do_sr_##func##_tb_regs	;\
+	do_##func##_spr_reg(TCR, SR_TCR)
+
+#define do_sr_interrupt_regs(func) \
+	do_##func##_spr_reg(IVPR, SR_IVPR) ;\
+	do_##func##_spr_reg(IVOR0, SR_IVOR0 + 0x00) ;\
+	do_##func##_spr_reg(IVOR1, SR_IVOR0 + 0x08) ;\
+	do_##func##_spr_reg(IVOR2, SR_IVOR0 + 0x10) ;\
+	do_##func##_spr_reg(IVOR3, SR_IVOR0 + 0x18) ;\
+	do_##func##_spr_reg(IVOR4, SR_IVOR0 + 0x20) ;\
+	do_##func##_spr_reg(IVOR5, SR_IVOR0 + 0x28) ;\
+	do_##func##_spr_reg(IVOR6, SR_IVOR0 + 0x30) ;\
+	do_##func##_spr_reg(IVOR7, SR_IVOR0 + 0x38) ;\
+	do_##func##_spr_reg(IVOR8, SR_IVOR0 + 0x40) ;\
+	do_##func##_spr_reg(IVOR10, SR_IVOR0 + 0x50) ;\
+	do_##func##_spr_reg(IVOR11, SR_IVOR0 + 0x58) ;\
+	do_##func##_spr_reg(IVOR12, SR_IVOR0 + 0x60) ;\
+	do_##func##_spr_reg(IVOR13, SR_IVOR0 + 0x68) ;\
+	do_##func##_spr_reg(IVOR14, SR_IVOR0 + 0x70) ;\
+	do_##func##_spr_reg(IVOR15, SR_IVOR0 + 0x78)
+
+#define do_e6500_sr_interrupt_regs(func) \
+	do_##func##_spr_reg(IVOR9, SR_IVOR0 + 0x48) ;\
+	do_##func##_spr_reg(IVOR32, SR_IVOR32 + 0x00) ;\
+	do_##func##_spr_reg(IVOR33, SR_IVOR32 + 0x08) ;\
+	do_##func##_spr_reg(IVOR35, SR_IVOR32 + 0x18) ;\
+	do_##func##_spr_reg(IVOR36, SR_IVOR32 + 0x20) ;\
+	do_##func##_spr_reg(IVOR37, SR_IVOR32 + 0x28) ;\
+	do_##func##_spr_reg(IVOR38, SR_IVOR32 + 0x30) ;\
+	do_##func##_spr_reg(IVOR39, SR_IVOR32 + 0x38) ;\
+	do_##func##_spr_reg(IVOR40, SR_IVOR32 + 0x40) ;\
+	do_##func##_spr_reg(IVOR41, SR_IVOR32 + 0x48)
+
+#define do_e5500_sr_interrupt_regs(func) \
+	do_##func##_spr_reg(IVOR9, SR_IVOR0 + 0x48) ;\
+	do_##func##_spr_reg(IVOR35, SR_IVOR32 + 0x18) ;\
+	do_##func##_spr_reg(IVOR36, SR_IVOR32 + 0x20) ;\
+	do_##func##_spr_reg(IVOR37, SR_IVOR32 + 0x28) ;\
+	do_##func##_spr_reg(IVOR38, SR_IVOR32 + 0x30) ;\
+	do_##func##_spr_reg(IVOR39, SR_IVOR32 + 0x38) ;\
+	do_##func##_spr_reg(IVOR40, SR_IVOR32 + 0x40) ;\
+	do_##func##_spr_reg(IVOR41, SR_IVOR32 + 0x48)
+
+#define do_e500_sr_interrupt_regs(func) \
+	do_##func##_spr_reg(IVOR32, SR_IVOR32 + 0x00) ;\
+	do_##func##_spr_reg(IVOR33, SR_IVOR32 + 0x08) ;\
+	do_##func##_spr_reg(IVOR34, SR_IVOR32 + 0x10)
+
+#define do_e500mc_sr_interrupt_regs(func) \
+	do_##func##_spr_reg(IVOR9, SR_IVOR0 + 0x48) ;\
+	do_##func##_spr_reg(IVOR35, SR_IVOR32 + 0x18) ;\
+	do_##func##_spr_reg(IVOR36, SR_IVOR32 + 0x20) ;\
+	do_##func##_spr_reg(IVOR37, SR_IVOR32 + 0x28) ;\
+	do_##func##_spr_reg(IVOR38, SR_IVOR32 + 0x30) ;\
+	do_##func##_spr_reg(IVOR39, SR_IVOR32 + 0x38) ;\
+	do_##func##_spr_reg(IVOR40, SR_IVOR32 + 0x40) ;\
+	do_##func##_spr_reg(IVOR41, SR_IVOR32 + 0x48)
+
+#define do_sr_general_software_regs(func) \
+	do_##func##_spr_reg(SPRG1, SR_SPRG1) ;\
+	do_##func##_spr_reg(SPRG3, SR_SPRG3)
+
+#define do_sr_general_mmu_regs(func) \
+	do_##func##_spr_reg(PID0, SR_PID0 + 0x00)
+
+#define do_sr_e500_mmu_regs(func) \
+	do_##func##_spr_reg(PID1, SR_PID0 + 0x08) ;\
+	do_##func##_spr_reg(PID2, SR_PID0 + 0x10)
+
+#define do_sr_debug_regs(func) \
+	do_##func##_spr_reg(DBCR0, SR_DBCR0 + 0x00) ;\
+	do_##func##_spr_reg(DBCR1, SR_DBCR0 + 0x08) ;\
+	do_##func##_spr_reg(DBCR2, SR_DBCR0 + 0x10) ;\
+	do_##func##_spr_reg(IAC1, SR_IAC1 + 0x00) ;\
+	do_##func##_spr_reg(IAC2, SR_IAC1 + 0x08) ;\
+	do_##func##_spr_reg(DAC1, SR_DAC1 + 0x00) ;\
+	do_##func##_spr_reg(DAC2, SR_DAC1 + 0x08)
+
+#define do_e6500_sr_debug_regs(func) \
+	do_##func##_spr_reg(IAC3, SR_IAC1 + 0x10) ;\
+	do_##func##_spr_reg(IAC4, SR_IAC1 + 0x18)
+
+/*
+ * Freescale 85xx Cores, Save/Restore core registers.
+ */
+_GLOBAL(core_registers_save_area)
+	.space FSL_CPU_SR_SIZE
+
+	.section .text
+	.align	5
+_GLOBAL(fsl_cpu_base_save)
+	do_sr_general_gpr_regs(save)
+	do_sr_general_branch_regs(save)
+	do_sr_general_pcr_regs(save)
+	do_sr_general_software_regs(save)
+	do_sr_general_mmu_regs(save)
+
+	/*
+	 * Need to save float-point registers if MSR[FP] = 1.
+	 */
+	mfmsr	r12
+	andi.	r12, r12, MSR_FP
+	beq	1f
+	do_sr_fpr_regs(save)
+
+1:
+	mfspr	r5, SPRN_TBRU
+	do_sr_general_time_regs(save)
+	mfspr	r6, SPRN_TBRU
+	cmpw	r5, r6
+	bne	1b
+
+	blr
+
+_GLOBAL(fsl_cpu_base_restore)
+	do_sr_general_gpr_regs(restore)
+	do_sr_general_branch_regs(restore)
+	do_sr_general_pcr_regs(restore)
+	do_sr_general_software_regs(restore)
+	do_sr_general_mmu_regs(restore)
+
+	isync
+
+	/*
+	 * Need to restore float-point registers if MSR[FP] = 1.
+	 */
+	mfmsr	r12
+	andi.	r12, r12, MSR_FP
+	beq	1f
+	do_sr_fpr_regs(restore)
+
+1:
+	/* Restore Time registers */
+	/* clear tb lower to avoid wrap */
+	li	r0, 0
+	mtspr	SPRN_TBWL, r0
+	do_sr_general_time_regs(restore)
+
+	lis	r0, (TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS)@h
+	mtspr	SPRN_TSR, r0
+
+	/* Kick decrementer */
+	li	r0, 1
+	mtdec	r0
+
+	blr
+
+/* Base registers, e500v1, e500v2 need to do some special save/restore */
+_GLOBAL(e500_base_special_save)
+	lis	r12, 0
+	ori	r12, r12, PVR_VER_E500V1@l
+	cmpw	r11, r12
+	beq	500f
+
+	lis	r12, 0
+	ori	r12, r12, PVR_VER_E500V2@l
+	cmpw	r11, r12
+	bne	1f
+
+500:
+	do_sr_e500_pcr_regs(save)
+	do_sr_e500_mmu_regs(save)
+1:
+	blr
+
+_GLOBAL(e500_base_special_restore)
+	lis	r12, 0
+	ori	r12, r12, PVR_VER_E500V1@l
+	cmpw	r11, r12
+	beq	500f
+
+	lis	r12, 0
+	ori	r12, r12, PVR_VER_E500V2@l
+	cmpw	r11, r12
+	bne	1f
+
+500:
+	do_sr_e500_pcr_regs(save)
+	do_sr_e500_mmu_regs(save)
+1:
+	blr
+
+_GLOBAL(fsl_cpu_append_save)
+	mfspr	r0, SPRN_PVR
+	rlwinm	r11, r0, 16, 16, 31
+
+	lis	r12, 0
+	ori	r12, r12, PVR_VER_E6500@l
+	cmpw	r11, r12
+	beq	e6500_append_save
+
+	lis	r12, 0
+	ori	r12, r12, PVR_VER_E5500@l
+	cmpw	r11, r12
+	beq	e5500_append_save
+
+	lis	r12, 0
+	ori	r12, r12, PVR_VER_E500MC@l
+	cmpw	r11, r12
+	beq	e500mc_append_save
+
+	lis	r12, 0
+	ori	r12, r12, PVR_VER_E500V2@l
+	cmpw	r11, r12
+	beq	e500v2_append_save
+
+	lis	r12, 0
+	ori	r12, r12, PVR_VER_E500V1@l
+	cmpw	r11, r12
+	beq	e500v1_append_save
+
+	b	1f
+
+e6500_append_save:
+	do_e6500_sr_interrupt_regs(save)
+	do_e6500_sr_debug_regs(save)
+	b	1f
+
+e5500_append_save:
+	do_e5500_sr_interrupt_regs(save)
+	b	1f
+
+e500mc_append_save:
+	do_e500mc_sr_interrupt_regs(save)
+	b	1f
+
+e500v2_append_save:
+e500v1_append_save:
+	do_e500_sr_interrupt_regs(save)
+
+1:
+	do_sr_interrupt_regs(save)
+	do_sr_debug_regs(save)
+
+	blr
+
+_GLOBAL(fsl_cpu_append_restore)
+	mfspr	r0, SPRN_PVR
+	rlwinm	r11, r0, 16, 16, 31
+
+	lis	r12, 0
+	ori	r12, r12, PVR_VER_E6500@l
+	cmpw	r11, r12
+	beq	e6500_append_restore
+
+	lis	r12, 0
+	ori	r12, r12, PVR_VER_E5500@l
+	cmpw	r11, r12
+	beq	e5500_append_restore
+
+	lis	r12, 0
+	ori	r12, r12, PVR_VER_E500MC@l
+	cmpw	r11, r12
+	beq	e500mc_append_restore
+
+	lis	r12, 0
+	ori	r12, r12, PVR_VER_E500V2@l
+	cmpw	r11, r12
+	beq	e500v2_append_restore
+
+	lis	r12, 0
+	ori	r12, r12, PVR_VER_E500V1@l
+	cmpw	r11, r12
+	beq	e500v1_append_restore
+
+	b	1f
+
+e6500_append_restore:
+	do_e6500_sr_interrupt_regs(restore)
+	do_e6500_sr_debug_regs(restore)
+	b	1f
+
+e5500_append_restore:
+	do_e5500_sr_interrupt_regs(restore)
+	b	1f
+
+e500mc_append_restore:
+	do_e500mc_sr_interrupt_regs(restore)
+	b	1f
+
+e500v2_append_restore:
+e500v1_append_restore:
+	do_e500_sr_interrupt_regs(restore)
+
+1:
+	do_sr_interrupt_regs(restore)
+	do_sr_debug_regs(restore)
+
+	sync
+
+	blr
+
+/*
+ * r3 = the virtual address of buffer
+ * r4 = suspend type, 0-BASE_SAVE, 1-ALL_SAVE
+ */
+_GLOBAL(fsl_cpu_state_save)
+	mflr	r9
+	LOAD_SAVE_ADDRESS
+
+	/* save the return address to SR_LR */
+	do_save_gpr_reg(r9, SR_LR)
+
+	/* if core_save_type is BASE_SAVE, goto 1f */
+	cmpwi	r4, 0
+	beq	1f
+
+	bl	fsl_cpu_append_save
+
+1:
+	bl	e500_base_special_save
+
+	bl	fsl_cpu_base_save
+
+	li	r3, 0
+	mtlr	r9
+	blr
+
+/*
+ * r3 = the virtual address of buffer
+ * r4 = suspend type, 0-BASE_SAVE, 1-ALL_SAVE
+ */
+_GLOBAL(fsl_cpu_state_restore)
+	mflr	r9
+	LOAD_SAVE_ADDRESS
+
+	/*
+	 * Disable machine checks and critical exceptions,
+	 * if core_save_type is ALL_SAVE, we will restore interrupt
+	 * IVORs registers.
+	 */
+	mfmsr	r5
+	rlwinm	r5, r5, 0, ~MSR_CE
+	rlwinm	r5, r5, 0, ~MSR_ME
+	mtmsr	r5
+	isync
+
+	/* if core_save_type is BASE_SAVE, goto 1f */
+	cmpwi	r4, 0
+	beq	1f
+
+	bl	fsl_cpu_append_restore
+
+1:
+	bl	e500_base_special_restore
+
+	bl	fsl_cpu_base_restore
+
+	/* return the return address of the save time */
+	do_restore_gpr_reg(r9, SR_LR)
+
+	li	r3, 0
+	mtlr	r9
+	blr
-- 
1.8.5
