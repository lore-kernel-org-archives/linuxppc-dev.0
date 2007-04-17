Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id 63FE0DDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 17:11:52 +1000 (EST)
Date: Tue, 17 Apr 2007 09:11:48 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/5] lite5200b suspend: low-power mode
Message-ID: <20070417071148.GM18236@moe.telargo.com>
References: <20070315103959.GA22215@moe.telargo.com>
	<20070315104447.GG22215@moe.telargo.com>
	<528646bc0703150709v49af8085p959bd36e0adf1e4a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528646bc0703150709v49af8085p959bd36e0adf1e4a@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Low-power mode implementation for Lite5200b.  (Most of devices
on board, including the CPU, are powered down)

Some I/O registers are also saved here.

A patch to U-Boot that wakes up SDRAM, and transfers control
to address saved at physical 0x0 is needed, and is already
merged in git://www.denx.de/git/u-boot-ppc4xx.git tree.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
 arch/powerpc/platforms/52xx/Makefile         |    3 
 arch/powerpc/platforms/52xx/lite5200.c       |    2 
 arch/powerpc/platforms/52xx/lite5200_pm.c    |  210 +++++++++++++
 arch/powerpc/platforms/52xx/lite5200_sleep.S |  413 +++++++++++++++++++++++++++
 include/asm-powerpc/mpc52xx.h                |   10 
 5 files changed, 637 insertions(+), 1 deletion(-)

Index: grant.git/arch/powerpc/platforms/52xx/lite5200_pm.c
===================================================================
--- /dev/null
+++ grant.git/arch/powerpc/platforms/52xx/lite5200_pm.c
@@ -0,0 +1,210 @@
+#include <linux/init.h>
+#include <linux/pm.h>
+#include <asm/io.h>
+#include <asm/time.h>
+#include <asm/mpc52xx.h>
+#include "bestcomm.h"
+
+/* defined in lite5200_sleep.S and only used here */
+extern void lite5200_low_power(void *sram, void *mbar);
+
+static struct mpc52xx_cdm __iomem *cdm;
+static struct mpc52xx_intr __iomem *pic;
+static struct mpc52xx_sdma __iomem *bes;
+static struct mpc52xx_xlb __iomem *xlb;
+static struct mpc52xx_gpio __iomem *gps;
+static struct mpc52xx_gpio_wkup __iomem *gpw;
+static void __iomem *mbar;
+
+static int lite5200_pm_valid(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+	case PM_SUSPEND_MEM:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static int lite5200_pm_prepare(suspend_state_t state)
+{
+	/* deep sleep? let mpc52xx code handle that */
+	if (state == PM_SUSPEND_STANDBY)
+		return mpc52xx_pm_prepare(state);
+
+	if (state != PM_SUSPEND_MEM)
+		return -EINVAL;
+
+	/* map registers */
+	mbar = mpc52xx_find_and_map("mpc5200");
+	if (!mbar) {
+		printk(KERN_ERR "%s:%i Error mapping registers\n", __func__, __LINE__);
+		return -ENOSYS;
+	}
+
+	cdm = mbar + 0x200;
+	pic = mbar + 0x500;
+	gps = mbar + 0xb00;
+	gpw = mbar + 0xc00;
+	bes = mbar + 0x1200;
+	xlb = mbar + 0x1f00;
+
+	return 0;
+}
+
+/* save and restore registers not bound to any real devices */
+static struct mpc52xx_cdm scdm;
+static struct mpc52xx_intr spic;
+static struct mpc52xx_sdma sbes;
+static struct mpc52xx_xlb sxlb;
+static struct mpc52xx_gpio sgps;
+static struct mpc52xx_gpio_wkup sgpw;
+
+static void lite5200_save_regs(void)
+{
+	_memcpy_fromio(&spic, pic, sizeof(*pic));
+	_memcpy_fromio(&sbes, bes, sizeof(*bes));
+	_memcpy_fromio(&scdm, cdm, sizeof(*cdm));
+	_memcpy_fromio(&sxlb, xlb, sizeof(*xlb));
+	_memcpy_fromio(&sgps, gps, sizeof(*gps));
+	_memcpy_fromio(&sgpw, gpw, sizeof(*gpw));
+
+	memcpy(saved_sram, sdma.sram, sdma.sram_size);
+}
+
+static void lite5200_restore_regs(void)
+{
+	int i;
+	memcpy(sdma.sram, saved_sram, sdma.sram_size);
+
+
+	/*
+	 * GPIOs. Interrupt Master Enable has higher address then other
+	 * registers, so just memcpy is ok.
+	 */
+	_memcpy_toio(gpw, &sgpw, sizeof(*gpw));
+	_memcpy_toio(gps, &sgps, sizeof(*gps));
+
+
+	/* XLB Arbitrer */
+	out_be32(&xlb->snoop_window, sxlb.snoop_window);
+	out_be32(&xlb->master_priority, sxlb.master_priority);
+	out_be32(&xlb->master_pri_enable, sxlb.master_pri_enable);
+
+	/* enable */
+	out_be32(&xlb->int_enable, sxlb.int_enable);
+	out_be32(&xlb->config, sxlb.config);
+
+
+	/* CDM - Clock Distribution Module */
+	out_8(&cdm->ipb_clk_sel, scdm.ipb_clk_sel);
+	out_8(&cdm->pci_clk_sel, scdm.pci_clk_sel);
+
+	out_8(&cdm->ext_48mhz_en, scdm.ext_48mhz_en);
+	out_8(&cdm->fd_enable, scdm.fd_enable);
+	out_be16(&cdm->fd_counters, scdm.fd_counters);
+
+	out_be32(&cdm->clk_enables, scdm.clk_enables);
+
+	out_8(&cdm->osc_disable, scdm.osc_disable);
+
+	out_be16(&cdm->mclken_div_psc1, scdm.mclken_div_psc1);
+	out_be16(&cdm->mclken_div_psc2, scdm.mclken_div_psc2);
+	out_be16(&cdm->mclken_div_psc3, scdm.mclken_div_psc3);
+	out_be16(&cdm->mclken_div_psc6, scdm.mclken_div_psc6);
+
+
+	/* BESTCOMM */
+	out_be32(&bes->taskBar, sbes.taskBar);
+	out_be32(&bes->currentPointer, sbes.currentPointer);
+	out_be32(&bes->endPointer, sbes.endPointer);
+	out_be32(&bes->variablePointer, sbes.variablePointer);
+
+	out_8(&bes->IntVect1, sbes.IntVect1);
+	out_8(&bes->IntVect2, sbes.IntVect2);
+	out_be16(&bes->PtdCntrl, sbes.PtdCntrl);
+
+	for (i=0; i<32; i++)
+		out_8(&bes->ipr[i], sbes.ipr[i]);
+
+	out_be32(&bes->cReqSelect, sbes.cReqSelect);
+	out_be32(&bes->task_size0, sbes.task_size0);
+	out_be32(&bes->task_size1, sbes.task_size1);
+	out_be32(&bes->MDEDebug, sbes.MDEDebug);
+	out_be32(&bes->ADSDebug, sbes.ADSDebug);
+	out_be32(&bes->Value1, sbes.Value1);
+	out_be32(&bes->Value2, sbes.Value2);
+	out_be32(&bes->Control, sbes.Control);
+	out_be32(&bes->Status, sbes.Status);
+	out_be32(&bes->PTDDebug, sbes.PTDDebug);
+
+	/* restore tasks */
+	for (i=0; i<16; i++)
+		out_be16(&bes->tcr[i], sbes.tcr[i]);
+
+	/* enable interrupts */
+	out_be32(&bes->IntPend, sbes.IntPend);
+	out_be32(&bes->IntMask, sbes.IntMask);
+
+
+	/* PIC */
+	out_be32(&pic->per_pri1, spic.per_pri1);
+	out_be32(&pic->per_pri2, spic.per_pri2);
+	out_be32(&pic->per_pri3, spic.per_pri3);
+
+	out_be32(&pic->main_pri1, spic.main_pri1);
+	out_be32(&pic->main_pri2, spic.main_pri2);
+
+	out_be32(&pic->enc_status, spic.enc_status);
+
+	/* unmask and enable interrupts */
+	out_be32(&pic->per_mask, spic.per_mask);
+	out_be32(&pic->main_mask, spic.main_mask);
+	out_be32(&pic->ctrl, spic.ctrl);
+}
+
+static int lite5200_pm_enter(suspend_state_t state)
+{
+	/* deep sleep? let mpc52xx code handle that */
+	if (state == PM_SUSPEND_STANDBY) {
+		return mpc52xx_pm_enter(state);
+	}
+
+	lite5200_save_regs();
+
+	/* effectively save FP regs */
+	enable_kernel_fp();
+
+	lite5200_low_power(sdma.sram, mbar);
+
+	lite5200_restore_regs();
+
+	/* restart jiffies */
+	wakeup_decrementer();
+
+	iounmap(mbar);
+	return 0;
+}
+
+static int lite5200_pm_finish(suspend_state_t state)
+{
+	/* deep sleep? let mpc52xx code handle that */
+	if (state == PM_SUSPEND_STANDBY) {
+		return mpc52xx_pm_finish(state);
+	}
+	return 0;
+}
+
+static struct pm_ops lite5200_pm_ops = {
+	.valid		= lite5200_pm_valid,
+	.prepare	= lite5200_pm_prepare,
+	.enter		= lite5200_pm_enter,
+	.finish		= lite5200_pm_finish,
+};
+
+int __init lite5200_pm_init(void)
+{
+	pm_set_ops(&lite5200_pm_ops);
+	return 0;
+}
Index: grant.git/arch/powerpc/platforms/52xx/lite5200_sleep.S
===================================================================
--- /dev/null
+++ grant.git/arch/powerpc/platforms/52xx/lite5200_sleep.S
@@ -0,0 +1,413 @@
+#include <asm/reg.h>
+#include <asm/ppc_asm.h>
+#include <asm/processor.h>
+#include <asm/cache.h>
+
+
+#define SDRAM_CTRL	0x104
+#define SC_MODE_EN	(1<<31)
+#define SC_CKE		(1<<30)
+#define SC_REF_EN	(1<<28)
+#define SC_SOFT_PRE	(1<<1)
+
+#define GPIOW_GPIOE	0xc00
+#define GPIOW_DDR	0xc08
+#define GPIOW_DVO	0xc0c
+
+#define CDM_CE		0x214
+#define CDM_SDRAM	(1<<3)
+
+
+/* helpers... beware: r10 and r4 are overwritten */
+#define SAVE_SPRN(reg, addr)		\
+	mfspr	r10, SPRN_##reg;	\
+	stw	r10, ((addr)*4)(r4);
+
+#define LOAD_SPRN(reg, addr)		\
+	lwz	r10, ((addr)*4)(r4);	\
+	mtspr	SPRN_##reg, r10;	\
+	sync;				\
+	isync;
+
+
+	.data
+registers:
+	.space 0x5c*4
+	.text
+
+/* ---------------------------------------------------------------------- */
+/* low-power mode with help of M68HLC908QT1 */
+
+	.globl lite5200_low_power
+lite5200_low_power:
+
+	mr	r7, r3	/* save SRAM va */
+	mr	r8, r4	/* save MBAR va */
+
+	/* setup wakeup address for u-boot at physical location 0x0 */
+	lis	r3, CONFIG_KERNEL_START@h
+	lis	r4, lite5200_wakeup@h
+	ori	r4, r4, lite5200_wakeup@l
+	sub	r4, r4, r3
+	stw	r4, 0(r3)
+
+
+	/*
+	 * save stuff BDI overwrites
+	 * 0xf0 (0xe0->0x100 gets overwritten when BDI connected;
+	 *   even when CONFIG_BDI* is disabled and MMU XLAT commented; heisenbug?))
+	 * WARNING: self-refresh doesn't seem to work when BDI2000 is connected,
+	 *   possibly because BDI sets SDRAM registers before wakeup code does
+	 */
+	lis	r4, registers@h
+	ori	r4, r4, registers@l
+	lwz	r10, 0xf0(r3)
+	stw	r10, (0x1d*4)(r4)
+
+	/* save registers to r4 [destroys r10] */
+	SAVE_SPRN(LR, 0x1c)
+	bl	save_regs
+
+	/* flush caches [destroys r3, r4] */
+	bl	flush_data_cache
+
+
+	/* copy code to sram */
+	mr	r4, r7
+	li	r3, (sram_code_end - sram_code)/4
+	mtctr	r3
+	lis	r3, sram_code@h
+	ori	r3, r3, sram_code@l
+1:
+	lwz	r5, 0(r3)
+	stw	r5, 0(r4)
+	addi	r3, r3, 4
+	addi	r4, r4, 4
+	bdnz	1b
+
+	/* get tb_ticks_per_usec */
+	lis	r3, tb_ticks_per_usec@h
+	lwz	r11, tb_ticks_per_usec@l(r3)
+
+	/* disable I and D caches */
+	mfspr	r3, SPRN_HID0
+	ori	r3, r3, HID0_ICE | HID0_DCE
+	xori	r3, r3, HID0_ICE | HID0_DCE
+	sync; isync;
+	mtspr	SPRN_HID0, r3
+	sync; isync;
+
+	/* jump to sram */
+	mtlr	r7
+	blrl
+	/* doesn't return */
+
+
+sram_code:
+	/* self refresh */
+	lwz	r4, SDRAM_CTRL(r8)
+
+	/* send NOP (precharge) */
+	oris	r4, r4, SC_MODE_EN@h	/* mode_en */
+	stw	r4, SDRAM_CTRL(r8)
+	sync
+
+	ori	r4, r4, SC_SOFT_PRE	/* soft_pre */
+	stw	r4, SDRAM_CTRL(r8)
+	sync
+	xori	r4, r4, SC_SOFT_PRE
+
+	xoris	r4, r4, SC_MODE_EN@h	/* !mode_en */
+	stw	r4, SDRAM_CTRL(r8)
+	sync
+
+	/* delay (for NOP to finish) */
+	li	r12, 1
+	bl	udelay
+
+	/*
+	 * mode_en must not be set when enabling self-refresh
+	 * send AR with CKE low (self-refresh)
+	 */
+	oris	r4, r4, (SC_REF_EN | SC_CKE)@h
+	xoris	r4, r4, (SC_CKE)@h	/* ref_en !cke */
+	stw	r4, SDRAM_CTRL(r8)
+	sync
+
+	/* delay (after !CKE there should be two cycles) */
+	li	r12, 1
+	bl	udelay
+
+	/* disable clock */
+	lwz	r4, CDM_CE(r8)
+	ori	r4, r4, CDM_SDRAM
+	xori	r4, r4, CDM_SDRAM
+	stw	r4, CDM_CE(r8)
+	sync
+
+	/* delay a bit */
+	li	r12, 1
+	bl	udelay
+
+
+	/* turn off with QT chip */
+	li	r4, 0x02
+	stb	r4, GPIOW_GPIOE(r8)	/* enable gpio_wkup1 */
+	sync
+
+	stb	r4, GPIOW_DVO(r8)	/* "output" high */
+	sync
+	stb	r4, GPIOW_DDR(r8)	/* output */
+	sync
+	stb	r4, GPIOW_DVO(r8)	/* output high */
+	sync
+
+	/* 10uS delay */
+	li	r12, 10
+	bl	udelay
+
+	/* turn off */
+	li	r4, 0
+	stb	r4, GPIOW_DVO(r8)	/* output low */
+	sync
+
+	/* wait until we're offline */
+  1:
+	b	1b
+
+
+	/* local udelay in sram is needed */
+  udelay: /* r11 - tb_ticks_per_usec, r12 - usecs, overwrites r13 */
+	mullw	r12, r12, r11
+	mftb	r13	/* start */
+	addi	r12, r13, r12 /* end */
+    1:
+	mftb	r13	/* current */
+	cmp	cr0, r13, r12
+	blt	1b
+	blr
+
+sram_code_end:
+
+
+
+/* uboot jumps here on resume */
+lite5200_wakeup:
+	bl	restore_regs
+
+
+	/* HIDs, MSR */
+	LOAD_SPRN(HID1, 0x19)
+	LOAD_SPRN(HID2, 0x1a)
+
+
+	/* address translation is tricky (see turn_on_mmu) */
+	mfmsr	r10
+	ori	r10, r10, MSR_DR | MSR_IR
+
+
+	mtspr	SPRN_SRR1, r10
+	lis	r10, mmu_on@h
+	ori	r10, r10, mmu_on@l
+	mtspr	SPRN_SRR0, r10
+	sync
+	rfi
+mmu_on:
+	/* kernel offset (r4 is still set from restore_registers) */
+	addis	r4, r4, CONFIG_KERNEL_START@h
+
+
+	/* restore MSR */
+	lwz	r10, (4*0x1b)(r4)
+	mtmsr	r10
+	sync; isync;
+
+	/* invalidate caches */
+	mfspr	r10, SPRN_HID0
+	ori	r5, r10, HID0_ICFI | HID0_DCI
+	mtspr	SPRN_HID0, r5	/* invalidate caches */
+	sync; isync;
+	mtspr	SPRN_HID0, r10
+	sync; isync;
+
+	/* enable caches */
+	lwz	r10, (4*0x18)(r4)
+	mtspr	SPRN_HID0, r10	/* restore (enable caches, DPM) */
+	/* ^ this has to be after address translation set in MSR */
+	sync
+	isync
+
+
+	/* restore 0xf0 (BDI2000) */
+	lis	r3, CONFIG_KERNEL_START@h
+	lwz	r10, (0x1d*4)(r4)
+	stw	r10, 0xf0(r3)
+
+	LOAD_SPRN(LR, 0x1c)
+
+
+	blr
+
+
+/* ---------------------------------------------------------------------- */
+/* boring code: helpers */
+
+/* save registers */
+#define SAVE_BAT(n, addr)		\
+	SAVE_SPRN(DBAT##n##L, addr);	\
+	SAVE_SPRN(DBAT##n##U, addr+1);	\
+	SAVE_SPRN(IBAT##n##L, addr+2);	\
+	SAVE_SPRN(IBAT##n##U, addr+3);
+
+#define SAVE_SR(n, addr)		\
+	mfsr	r10, n;			\
+	stw	r10, ((addr)*4)(r4);
+
+#define SAVE_4SR(n, addr)	\
+	SAVE_SR(n, addr);	\
+	SAVE_SR(n+1, addr+1);	\
+	SAVE_SR(n+2, addr+2);	\
+	SAVE_SR(n+3, addr+3);
+
+save_regs:
+	stw	r0, 0(r4)
+	stw	r1, 0x4(r4)
+	stw	r2, 0x8(r4)
+	stmw	r11, 0xc(r4) /* 0xc -> 0x5f, (0x18*4-1) */
+
+	SAVE_SPRN(HID0, 0x18)
+	SAVE_SPRN(HID1, 0x19)
+	SAVE_SPRN(HID2, 0x1a)
+	mfmsr	r10
+	stw	r10, (4*0x1b)(r4)
+	/*SAVE_SPRN(LR, 0x1c) have to save it before the call */
+	/* 0x1d reserved by 0xf0 */
+	SAVE_SPRN(RPA,   0x1e)
+	SAVE_SPRN(SDR1,  0x1f)
+
+	/* save MMU regs */
+	SAVE_BAT(0, 0x20)
+	SAVE_BAT(1, 0x24)
+	SAVE_BAT(2, 0x28)
+	SAVE_BAT(3, 0x2c)
+	SAVE_BAT(4, 0x30)
+	SAVE_BAT(5, 0x34)
+	SAVE_BAT(6, 0x38)
+	SAVE_BAT(7, 0x3c)
+
+	SAVE_4SR(0, 0x40)
+	SAVE_4SR(4, 0x44)
+	SAVE_4SR(8, 0x48)
+	SAVE_4SR(12, 0x4c)
+
+	SAVE_SPRN(SPRG0, 0x50)
+	SAVE_SPRN(SPRG1, 0x51)
+	SAVE_SPRN(SPRG2, 0x52)
+	SAVE_SPRN(SPRG3, 0x53)
+	SAVE_SPRN(SPRG4, 0x54)
+	SAVE_SPRN(SPRG5, 0x55)
+	SAVE_SPRN(SPRG6, 0x56)
+	SAVE_SPRN(SPRG7, 0x57)
+
+	SAVE_SPRN(IABR,  0x58)
+	SAVE_SPRN(DABR,  0x59)
+	SAVE_SPRN(TBRL,  0x5a)
+	SAVE_SPRN(TBRU,  0x5b)
+
+	blr
+
+
+/* restore registers */
+#define LOAD_BAT(n, addr)		\
+	LOAD_SPRN(DBAT##n##L, addr);	\
+	LOAD_SPRN(DBAT##n##U, addr+1);	\
+	LOAD_SPRN(IBAT##n##L, addr+2);	\
+	LOAD_SPRN(IBAT##n##U, addr+3);
+
+#define LOAD_SR(n, addr)		\
+	lwz	r10, ((addr)*4)(r4);	\
+	mtsr	n, r10;
+
+#define LOAD_4SR(n, addr)	\
+	LOAD_SR(n, addr);	\
+	LOAD_SR(n+1, addr+1);	\
+	LOAD_SR(n+2, addr+2);	\
+	LOAD_SR(n+3, addr+3);
+
+restore_regs:
+	lis	r4, registers@h
+	ori	r4, r4, registers@l
+
+	/* MMU is not up yet */
+	subis	r4, r4, CONFIG_KERNEL_START@h
+
+	lwz	r0, 0(r4)
+	lwz	r1, 0x4(r4)
+	lwz	r2, 0x8(r4)
+	lmw	r11, 0xc(r4)
+
+	/*
+	 * these are a bit tricky
+	 *
+	 * 0x18 - HID0
+	 * 0x19 - HID1
+	 * 0x1a - HID2
+	 * 0x1b - MSR
+	 * 0x1c - LR
+	 * 0x1d - reserved by 0xf0 (BDI2000)
+	 */
+	LOAD_SPRN(RPA,   0x1e);
+	LOAD_SPRN(SDR1,  0x1f);
+
+	/* restore MMU regs */
+	LOAD_BAT(0, 0x20)
+	LOAD_BAT(1, 0x24)
+	LOAD_BAT(2, 0x28)
+	LOAD_BAT(3, 0x2c)
+	LOAD_BAT(4, 0x30)
+	LOAD_BAT(5, 0x34)
+	LOAD_BAT(6, 0x38)
+	LOAD_BAT(7, 0x3c)
+
+	LOAD_4SR(0, 0x40)
+	LOAD_4SR(4, 0x44)
+	LOAD_4SR(8, 0x48)
+	LOAD_4SR(12, 0x4c)
+
+	/* rest of regs */
+	LOAD_SPRN(SPRG0, 0x50);
+	LOAD_SPRN(SPRG1, 0x51);
+	LOAD_SPRN(SPRG2, 0x52);
+	LOAD_SPRN(SPRG3, 0x53);
+	LOAD_SPRN(SPRG4, 0x54);
+	LOAD_SPRN(SPRG5, 0x55);
+	LOAD_SPRN(SPRG6, 0x56);
+	LOAD_SPRN(SPRG7, 0x57);
+
+	LOAD_SPRN(IABR,  0x58);
+	LOAD_SPRN(DABR,  0x59);
+	LOAD_SPRN(TBWL,  0x5a);	/* these two have separate R/W regs */
+	LOAD_SPRN(TBWU,  0x5b);
+
+	blr
+
+
+
+/* cache flushing code. copied from arch/ppc/boot/util.S */
+#define NUM_CACHE_LINES (128*8)
+
+/*
+ * Flush data cache
+ * Do this by just reading lots of stuff into the cache.
+ */
+        .globl flush_data_cache
+flush_data_cache:
+	lis	r3,CONFIG_KERNEL_START@h
+	ori	r3,r3,CONFIG_KERNEL_START@l
+	li	r4,NUM_CACHE_LINES
+	mtctr	r4
+1:
+	lwz	r4,0(r3)
+	addi	r3,r3,L1_CACHE_BYTES	/* Next line, please */
+	bdnz	1b
+	blr
Index: grant.git/arch/powerpc/platforms/52xx/Makefile
===================================================================
--- grant.git.orig/arch/powerpc/platforms/52xx/Makefile
+++ grant.git/arch/powerpc/platforms/52xx/Makefile
@@ -12,3 +12,6 @@ obj-$(CONFIG_PPC_EFIKA)		+= efika.o
 obj-$(CONFIG_PPC_LITE5200)	+= lite5200.o
 
 obj-$(CONFIG_PM)		+= mpc52xx_sleep.o mpc52xx_pm.o
+ifeq ($(CONFIG_PPC_LITE5200),y)
+	obj-$(CONFIG_PM)	+= lite5200_sleep.o lite5200_pm.o
+endif
Index: grant.git/arch/powerpc/platforms/52xx/lite5200.c
===================================================================
--- grant.git.orig/arch/powerpc/platforms/52xx/lite5200.c
+++ grant.git/arch/powerpc/platforms/52xx/lite5200.c
@@ -132,7 +132,7 @@ static void __init lite5200_setup_arch(v
 #ifdef CONFIG_PM
 	mpc52xx_suspend.board_suspend_prepare = lite5200_suspend_prepare;
 	mpc52xx_suspend.board_resume_finish = lite5200_resume_finish;
-	mpc52xx_pm_init();
+ 	lite5200_pm_init();
 #endif
 
 #ifdef CONFIG_PCI
Index: grant.git/include/asm-powerpc/mpc52xx.h
===================================================================
--- grant.git.orig/include/asm-powerpc/mpc52xx.h
+++ grant.git/include/asm-powerpc/mpc52xx.h
@@ -262,6 +262,16 @@ struct mpc52xx_suspend {
 extern struct mpc52xx_suspend mpc52xx_suspend;
 extern int __init mpc52xx_pm_init(void);
 extern int mpc52xx_set_wakeup_gpio(u8 pin, u8 level);
+
+#ifdef CONFIG_PPC_LITE5200
+extern int __init lite5200_pm_init(void);
+
+/* lite5200 calls mpc5200 suspend functions, so here they are */
+extern int mpc52xx_pm_prepare(suspend_state_t);
+extern int mpc52xx_pm_enter(suspend_state_t);
+extern int mpc52xx_pm_finish(suspend_state_t);
+extern char saved_sram[0x4000]; /* reuse buffer from mpc52xx suspend */
+#endif
 #endif /* CONFIG_PM */
 
 #endif /* __ASM_POWERPC_MPC52xx_H__ */
