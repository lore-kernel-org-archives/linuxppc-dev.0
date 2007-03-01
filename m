Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id 394A0DDF01
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 18:56:47 +1100 (EST)
Date: Thu, 1 Mar 2007 08:56:44 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 5/7] mpc52xx suspend: deep-sleep
Message-ID: <20070301075644.GE17184@moe.telargo.com>
References: <20070301075323.GP4397@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070301075323.GP4397@moe.telargo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Implement deep-sleep on MPC52xx.
SDRAM is put into self-refresh with help of SRAM code
(alternatives would be code in FLASH, I-cache).
Interrupt code must also not be in SDRAM, so put it
in I-cache.
MPC52xx core is static, so contents will remain intact even
with clocks turned off.

There seems to be a race with decrementer interrupt (uncomment
#define TESTING, and execute `echo standby > /sys/power/state`
couple thousands of times to reproduce it). :-(


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

Index: grant.git/arch/powerpc/platforms/52xx/Makefile
===================================================================
--- grant.git.orig/arch/powerpc/platforms/52xx/Makefile
+++ grant.git/arch/powerpc/platforms/52xx/Makefile
@@ -10,3 +10,5 @@ endif
 
 obj-$(CONFIG_PPC_EFIKA)		+= efika.o
 obj-$(CONFIG_PPC_LITE5200)	+= lite5200.o
+
+obj-$(CONFIG_PM)		+= mpc52xx_sleep.o mpc52xx_pm.o
Index: grant.git/arch/powerpc/platforms/52xx/mpc52xx_pm.c
===================================================================
--- /dev/null
+++ grant.git/arch/powerpc/platforms/52xx/mpc52xx_pm.c
@@ -0,0 +1,123 @@
+#include <linux/init.h>
+#include <linux/pm.h>
+#include <linux/io.h>
+#include <asm/mpc52xx.h>
+#include "bestcomm.h"
+#include "mpc52xx_pic.h"
+
+extern void mpc52xx_deep_sleep(void *, void *);
+
+static int mpc52xx_pm_valid(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static int mpc52xx_pm_prepare(suspend_state_t state)
+{
+	return 0;
+}
+
+/* you will want to change this, to match your board gpios, rtc or whatever */
+static void mpc52xx_set_wakeup_mode(void)
+{
+	struct mpc52xx_gpio_wkup __iomem *gpiow;
+	struct mpc52xx_intr __iomem *intr;
+	int pin = 1; /* GPIO_WKUP_1 (GPIO_PSC2_4) */
+	u16 tmp;
+
+	gpiow = mpc52xx_find_and_map("mpc5200-gpio-wkup");
+	intr = mpc52xx_find_and_map("mpc5200-pic");
+	if (!gpiow || !intr) {
+		printk(KERN_ERR "%s: couldn't map io space\n", __func__);
+		goto out;
+	}
+
+	/* enable gpio */
+	out_8(&gpiow->wkup_gpioe, in_8(&gpiow->wkup_gpioe) | (1 << pin));
+	/* set as input */
+	out_8(&gpiow->wkup_ddr, in_8(&gpiow->wkup_ddr) & ~(1 << pin));
+	/* enable deep sleep interrupt */
+	out_8(&gpiow->wkup_inten, in_8(&gpiow->wkup_inten) | (1 << pin));
+	/* low level creates wakeup interrupt */
+	tmp = in_be16(&gpiow->wkup_itype);
+	tmp &= 2 << (pin * 2);
+	tmp |= 2 << (pin * 2);
+	out_be16(&gpiow->wkup_itype, tmp);
+	/* master enable */
+	out_8(&gpiow->wkup_maste, 1);
+
+	/* enable wakeup gpio interrupt in PIC */
+	out_be32(&intr->main_mask, in_be32(&intr->main_mask) & ~(1 << 8));
+ out:
+	iounmap(gpiow);
+	iounmap(intr);
+}
+
+int mpc52xx_pm_enter(suspend_state_t state)
+{
+	int err = 0;
+	void __iomem *mbar;
+	struct mpc52xx_cdm __iomem *cdm;
+	u32 clk_enables;
+
+	if (state != PM_SUSPEND_STANDBY)
+		return 0;
+
+	mpc52xx_set_wakeup_mode();
+
+	/* is there a nicer way? */
+	mbar = ioremap_nocache(0xf0000000, 0x8000);
+	cdm = mpc52xx_find_and_map("mpc5200-cdm");
+	if (!mbar || !cdm) {
+		printk(KERN_ERR "%s:%i Error mapping registers\n", __func__, __LINE__);
+		err = -ENOSYS;
+		goto out;
+	}
+
+	mpc52xx_sdma_suspend();
+
+	out_8(&cdm->ccs_sleep_enable, 1);
+	out_8(&cdm->osc_sleep_enable, 1);
+	out_8(&cdm->ccs_qreq_test, 1);
+
+	/* disable all but SDRAM, bestcomm (SRAM) and timer clocks */
+	clk_enables = in_be32(&cdm->clk_enables);
+	out_be32(&cdm->clk_enables, clk_enables & 0x00088002);
+
+	mpc52xx_deep_sleep(sdma.sram, mbar);
+
+	out_be32(&cdm->clk_enables, clk_enables);
+	out_8(&cdm->ccs_sleep_enable, 0);
+	out_8(&cdm->osc_sleep_enable, 0);
+
+	mpc52xx_sdma_resume();
+
+	iounmap(mbar);
+ out:
+	return err;
+}
+
+static int mpc52xx_pm_finish(suspend_state_t state)
+{
+	return 0;
+}
+
+static struct pm_ops mpc52xx_pm_ops = {
+	.valid		= mpc52xx_pm_valid,
+	.prepare	= mpc52xx_pm_prepare,
+	.enter		= mpc52xx_pm_enter,
+	.finish		= mpc52xx_pm_finish,
+};
+
+static int __init mpc52xx_pm_init(void)
+{
+	pm_set_ops(&mpc52xx_pm_ops);
+	return 0;
+}
+
+arch_initcall(mpc52xx_pm_init);
Index: grant.git/arch/powerpc/platforms/52xx/mpc52xx_sleep.S
===================================================================
--- /dev/null
+++ grant.git/arch/powerpc/platforms/52xx/mpc52xx_sleep.S
@@ -0,0 +1,277 @@
+#include <asm/reg.h>
+#include <asm/ppc_asm.h>
+#include <asm/processor.h>
+
+
+// Tck is cca. 2000 cpu cycles here
+#define TCK 2000
+
+#define TMR0_ENABLE 0x600
+#define TMR0_INPUT 0x604
+
+#define SDRAM_CTRL	0x104
+
+#define CDM_CE		0x214
+#define CDM_CCSCR	0x21c
+
+#define INTR_MAIN_MASK	0x514
+#define INTR_ENC_STAT	0x524
+
+
+//#define TESTING
+
+// mpc5200b puts sdram automatically in self-refresh, previous versions don't
+#define SELF_REFRESH
+
+	.globl mpc52xx_deep_sleep
+mpc52xx_deep_sleep:
+
+	mr	r7, r3	// SRAM va
+	mr	r8, r4	// MBAR va
+	mflr	r9
+
+	// we don't want DEC expiring anytime soon, but not very late either
+	lis	r4, 0x1
+	mtspr	SPRN_DEC, r4
+
+
+	// setup power mode bits
+	mfmsr	r11
+	mr	r10, r11
+	oris	r10, r10, 0x0004
+	xoris	r10, r10, 0x0004	// POW = 0
+	sync; isync;
+	mtmsr	r10
+	sync; isync;
+
+	mfspr	r12, SPRN_HID0
+	mr	r10, r12
+	oris	r10, r10, 0x00f0
+	xoris	r10, r10, 0x00d0	// disable all power modes but sleep
+	sync; isync;
+	mtspr	SPRN_HID0, r10
+	sync; isync;
+
+	// copy code to sram
+	mr	r4, r7
+	subi	r4, r4, 4
+	li	r3, (sram_code_end-sram_code)/4
+	mtctr	r3
+	lis	r3, (sram_code-4)@h
+	ori	r3, r3, (sram_code-4)@l
+1:
+	lwzu	r5, 4(r3)
+	stwu	r5, 4(r4)
+	bdnz	1b
+
+
+	// save original irq handler, and write a new one
+	lis	r3, (orig_0x500-4)@h
+	ori	r3, r3, (orig_0x500-4)@l
+	li	r4, (cached_code_end - cached_code)/4
+	mtctr	r4
+	lis	r4, CONFIG_KERNEL_START@h
+	ori	r4, r4, 0x500
+	lis	r10, (cached_code-4)@h
+	ori	r10, r10, (cached_code-4)@l
+1:
+	lwz	r5, 0(r4)
+	stwu	r5, 4(r3)
+	lwzu	r5, 4(r10)
+	stw	r5, 0(r4)
+
+	dcbf	0, r4
+	icbi	0, r4
+	addi	r4, r4, 4
+
+	bdnz-	1b
+
+
+	// enable tmr0 interrupt
+	lwz	r4, INTR_MAIN_MASK(r8)
+	ori	r4, r4, 0x0080
+	xori	r4, r4, 0x0080
+	stw	r4, INTR_MAIN_MASK(r8)
+	sync
+
+	li	r5, 0 // flag that irq handler sets
+
+	// enable interrupts
+	mfmsr	r3
+	ori	r3, r3, 0x8000 // EE
+	mtmsr	r3
+	sync; isync;
+
+	// trigger tmr interrupt to cache the code
+	lis	r4, 0x100
+	ori	r4, r4, 0x1
+	stw	r4, TMR0_INPUT(r8)
+	sync
+	li	r4, 0x1104
+	stw	r4, TMR0_ENABLE(r8)
+	sync
+
+1:
+	cmpi	cr0, r5, 1
+	bne	cr0, 1b
+
+	// lock icache
+	mfspr	r10, SPRN_HID0
+	ori	r10, r10, 0x2000
+	sync; isync;
+	mtspr	SPRN_HID0, r10
+	sync; isync;
+
+	// jump to sram
+	mtlr	r7
+	blrl
+
+
+	// unlock icache
+	mfspr	r10, SPRN_HID0
+	ori	r10, r10, 0x2000
+	xori	r10, r10, 0x2000
+	sync; isync;
+	mtspr	SPRN_HID0, r10
+	sync; isync;
+
+
+	// restore former power mode (and re-disable interrupts)
+	mfmsr	r10
+	oris	r10, r10, 0x0004
+	xoris	r10, r10, 0x0004	// POW = 0
+	sync; isync;
+	mtmsr	r10
+	sync; isync;
+
+	mtspr	SPRN_HID0, r12
+	sync; isync;
+
+	mtmsr	r11
+	sync; isync;
+
+	// restore original irq handler
+	lis	r3, (orig_0x500-4)@h
+	ori	r3, r3, (orig_0x500-4)@l
+	li	r4, (cached_code_end - cached_code)/4
+	mtctr	r4
+	lis	r4, CONFIG_KERNEL_START@h
+	ori	r4, r4, 0x500
+1:
+	lwzu	r5, 4(r3)
+	stw	r5, 0(r4)
+
+	dcbf	0, r4
+	icbi	0, r4
+	addi	r4, r4, 4
+
+	bdnz-	1b
+
+
+	mtlr	r9
+	blr
+
+
+sram_code:
+	// self refresh
+#ifdef SELF_REFRESH
+	lwz	r4, SDRAM_CTRL(r8)
+
+	oris	r4, r4, 0x8000 //mode_en
+	stw	r4, SDRAM_CTRL(r8)
+	sync
+
+	ori	r4, r4, 0x0002 // soft_pre
+	stw	r4, SDRAM_CTRL(r8)
+	sync
+	xori	r4, r4, 0x0002
+
+	xoris	r4, r4, 0x8000 //mode_en
+	stw	r4, SDRAM_CTRL(r8)
+	sync
+
+	// delay one sdram cycle
+	li	r5, TCK
+	mtctr	r5
+1:
+	bdnz-	1b
+
+	oris	r4, r4, 0x5000
+	xoris	r4, r4, 0x4000 // ref_en !cke
+	stw	r4, SDRAM_CTRL(r8)
+	sync
+
+	// delay for 2 sdram cycles
+	li	r4, 2*TCK
+	mtctr	r4
+1:
+	bdnz-	1b
+
+	// disable clock
+	lwz	r4, CDM_CE(r8)
+	ori	r4, r4, 0x0008
+	xori	r4, r4, 0x0008
+	stw	r4, CDM_CE(r8)
+	sync
+#endif
+
+#ifndef TESTING
+	// put it to sleep
+	mfmsr	r10
+	oris	r10, r10, 0x0004	// POW = 1
+	sync; isync;
+	mtmsr	r10
+	sync; isync;
+#endif
+
+#ifdef SELF_REFRESH
+	// enable clock
+	lwz	r4, CDM_CE(r8)
+	ori	r4, r4, 0x0008
+	stw	r4, CDM_CE(r8)
+	sync
+
+	// get ram out of self-refresh
+	lwz	r4, SDRAM_CTRL(r8)
+	oris	r4, r4, 0x5000 // cke ref_en
+	stw	r4, SDRAM_CTRL(r8)
+	sync
+
+	li	r4, 2*TCK
+	mtctr	r4
+1:
+	bdnz-	1b
+#endif
+
+	blr
+sram_code_end:
+
+
+// ### interrupt handler for wakeup from deep-sleep ###
+cached_code:
+	// disable timer
+	mfspr	r3, 311	// MBAR
+	addi	r3, r3, TMR0_ENABLE
+	li	r4, 0
+	stw	r4, 0(r3)
+	sync
+	dcbf	0, r3
+
+	// acknowledge wakeup, so CCS releases power pown
+	mfspr	r3, 311	// MBAR
+	addi	r3, r3, INTR_ENC_STAT
+	lwz	r4, 0(r3)
+	ori	r4, r4, 0x0400
+	stw	r4, 0(r3)
+	sync
+	dcbf	0, r3
+
+	// flag that we handled an interrupt
+	li	r5, 1
+
+	rfi
+cached_code_end:
+
+
+orig_0x500:
+	.space (cached_code_end - cached_code)
