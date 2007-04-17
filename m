Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id EEDD3DDEC4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 17:05:18 +1000 (EST)
Date: Tue, 17 Apr 2007 09:05:13 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 4/5] mpc52xx suspend: deep-sleep
Message-ID: <20070417070513.GL18236@moe.telargo.com>
References: <20070315103959.GA22215@moe.telargo.com>
	<20070315104307.GE22215@moe.telargo.com>
	<528646bc0703230858h237237c2t5b7bedca6e42cddd@mail.gmail.com>
	<20070404073755.GE18236@moe.telargo.com>
	<528646bc0704152240u60bf24dbx6a1ca8dd15aaaf53@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528646bc0704152240u60bf24dbx6a1ca8dd15aaaf53@mail.gmail.com>
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

Implement deep-sleep on MPC52xx.
SDRAM is put into self-refresh with help of SRAM code
(alternatives would be code in FLASH, I-cache).
Interrupt code must also not be in SDRAM, so put it
in I-cache.
MPC52xx core is static, so contents will remain intact even
with clocks turned off.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
 arch/powerpc/platforms/52xx/Makefile        |    2 
 arch/powerpc/platforms/52xx/efika.c         |   15 ++
 arch/powerpc/platforms/52xx/lite5200.c      |   28 ++++
 arch/powerpc/platforms/52xx/mpc52xx_pm.c    |  187 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/52xx/mpc52xx_sleep.S |  154 +++++++++++++++++++++++
 include/asm-powerpc/mpc52xx.h               |   11 +
 6 files changed, 397 insertions(+)

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
@@ -0,0 +1,187 @@
+#include <linux/init.h>
+#include <linux/pm.h>
+#include <linux/io.h>
+#include <asm/time.h>
+#include <asm/cacheflush.h>
+#include <asm/mpc52xx.h>
+#include "bestcomm.h"
+
+
+/* these are defined in mpc52xx_sleep.S, and only used here */
+extern void mpc52xx_deep_sleep(void *sram, void *sdram_regs,
+		struct mpc52xx_cdm *, struct mpc52xx_intr *);
+extern void mpc52xx_ds_sram(void);
+extern const long mpc52xx_ds_sram_size;
+extern void mpc52xx_ds_cached(void);
+extern const long mpc52xx_ds_cached_size;
+
+static void __iomem *mbar;
+static void __iomem *sdram;
+static struct mpc52xx_cdm __iomem *cdm;
+static struct mpc52xx_intr __iomem *intr;
+static struct mpc52xx_gpio_wkup __iomem *gpiow;
+
+struct mpc52xx_suspend mpc52xx_suspend;
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
+int mpc52xx_set_wakeup_gpio(u8 pin, u8 level)
+{
+	u16 tmp;
+
+	/* enable gpio */
+	out_8(&gpiow->wkup_gpioe, in_8(&gpiow->wkup_gpioe) | (1 << pin));
+	/* set as input */
+	out_8(&gpiow->wkup_ddr, in_8(&gpiow->wkup_ddr) & ~(1 << pin));
+	/* enable deep sleep interrupt */
+	out_8(&gpiow->wkup_inten, in_8(&gpiow->wkup_inten) | (1 << pin));
+	/* low/high level creates wakeup interrupt */
+	tmp = in_be16(&gpiow->wkup_itype);
+	tmp &= ~(0x3 << (pin * 2));
+	tmp |= (!level + 1) << (pin * 2);
+	out_be16(&gpiow->wkup_itype, tmp);
+	/* master enable */
+	out_8(&gpiow->wkup_maste, 1);
+
+	return 0;
+}
+
+int mpc52xx_pm_prepare(suspend_state_t state)
+{
+	if (state != PM_SUSPEND_STANDBY)
+		return -EINVAL;
+
+	/* map the whole register space */
+	mbar = mpc52xx_find_and_map("mpc5200");
+	if (!mbar) {
+		printk(KERN_ERR "%s:%i Error mapping registers\n", __func__, __LINE__);
+		return -ENOSYS;
+	}
+	/* these offsets are from mpc5200 users manual */
+	sdram = mbar + 0x100;
+	cdm = mbar + 0x200;
+	intr = mbar + 0x500;
+	gpiow = mbar + 0xc00;
+
+
+	/* call board suspend code, if applicable */
+	if (mpc52xx_suspend.board_suspend_prepare)
+		mpc52xx_suspend.board_suspend_prepare(mbar);
+	else {
+		printk(KERN_ALERT "%s: %i don't know how to wake up the board\n",
+				__func__, __LINE__);
+		goto out_unmap;
+	}
+
+	return 0;
+
+ out_unmap:
+	iounmap(mbar);
+	return -ENOSYS;
+}
+
+
+char saved_sram[0x4000];
+
+int mpc52xx_pm_enter(suspend_state_t state)
+{
+	u32 clk_enables;
+	u32 msr, hid0;
+	u32 intr_main_mask;
+	void __iomem * irq_0x500 = (void *)CONFIG_KERNEL_START + 0x500;
+	unsigned long irq_0x500_stop = (unsigned long)irq_0x500 + mpc52xx_ds_cached_size;
+	char saved_0x500[mpc52xx_ds_cached_size];
+
+	/* disable all interrupts in PIC */
+	intr_main_mask = in_be32(&intr->main_mask);
+	out_be32(&intr->main_mask, intr_main_mask | 0x1ffff);
+
+	/* don't let DEC expire any time soon */
+	mtspr(SPRN_DEC, 0x7fffffff);
+
+	/* save SRAM */
+	memcpy(saved_sram, sdma.sram, sdma.sram_size);
+
+	/* copy low level suspend code to sram */
+	memcpy(sdma.sram, mpc52xx_ds_sram, mpc52xx_ds_sram_size);
+
+	out_8(&cdm->ccs_sleep_enable, 1);
+	out_8(&cdm->osc_sleep_enable, 1);
+	out_8(&cdm->ccs_qreq_test, 1);
+
+	/* disable all but SDRAM and bestcomm (SRAM) clocks */
+	clk_enables = in_be32(&cdm->clk_enables);
+	out_be32(&cdm->clk_enables, clk_enables & 0x00088000);
+
+	/* disable power management */
+	msr = mfmsr();
+	mtmsr(msr & ~MSR_POW);
+
+	/* enable sleep mode, disable others */
+	hid0 = mfspr(SPRN_HID0);
+	mtspr(SPRN_HID0, (hid0 & ~(HID0_DOZE | HID0_NAP | HID0_DPM)) | HID0_SLEEP);
+
+	/* save original, copy our irq handler, flush from dcache and invalidate icache */
+	memcpy(saved_0x500, irq_0x500, mpc52xx_ds_cached_size);
+	memcpy(irq_0x500, mpc52xx_ds_cached, mpc52xx_ds_cached_size);
+	flush_icache_range((unsigned long)irq_0x500, irq_0x500_stop);
+
+	/* call low-level sleep code */
+	mpc52xx_deep_sleep(sdma.sram, sdram, cdm, intr);
+
+	/* restore original irq handler */
+	memcpy(irq_0x500, saved_0x500, mpc52xx_ds_cached_size);
+	flush_icache_range((unsigned long)irq_0x500, irq_0x500_stop);
+
+	/* restore old power mode */
+	mtmsr(msr & ~MSR_POW);
+	mtspr(SPRN_HID0, hid0);
+	mtmsr(msr);
+
+	out_be32(&cdm->clk_enables, clk_enables);
+	out_8(&cdm->ccs_sleep_enable, 0);
+	out_8(&cdm->osc_sleep_enable, 0);
+
+	/* restore SRAM */
+	memcpy(sdma.sram, saved_sram, sdma.sram_size);
+
+	/* restart jiffies */
+	wakeup_decrementer();
+
+	/* reenable interrupts in PIC */
+	out_be32(&intr->main_mask, intr_main_mask);
+
+	return 0;
+}
+
+int mpc52xx_pm_finish(suspend_state_t state)
+{
+	/* call board resume code */
+	if (mpc52xx_suspend.board_resume_finish)
+		mpc52xx_suspend.board_resume_finish(mbar);
+
+	iounmap(mbar);
+
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
+int __init mpc52xx_pm_init(void)
+{
+	pm_set_ops(&mpc52xx_pm_ops);
+	return 0;
+}
Index: grant.git/arch/powerpc/platforms/52xx/mpc52xx_sleep.S
===================================================================
--- /dev/null
+++ grant.git/arch/powerpc/platforms/52xx/mpc52xx_sleep.S
@@ -0,0 +1,154 @@
+#include <asm/reg.h>
+#include <asm/ppc_asm.h>
+#include <asm/processor.h>
+
+
+.text
+
+_GLOBAL(mpc52xx_deep_sleep)
+mpc52xx_deep_sleep: /* args r3-r6: SRAM, SDRAM regs, CDM regs, INTR regs */
+
+	/* enable interrupts */
+	mfmsr	r7
+	ori	r7, r7, 0x8000 /* EE */
+	mtmsr	r7
+	sync; isync;
+
+	li	r10, 0 /* flag that irq handler sets */
+
+	/* enable tmr7 (or any other) interrupt */
+	lwz	r8, 0x14(r6) /* intr->main_mask */
+	ori	r8, r8, 0x1
+	xori	r8, r8, 0x1
+	stw	r8, 0x14(r6)
+	sync
+
+	/* emulate tmr7 interrupt */
+	li	r8, 0x1
+	stw	r8, 0x40(r6) /* intr->main_emulate */
+	sync
+
+	/* wait for it to happen */
+1:
+	cmpi	cr0, r10, 1
+	bne	cr0, 1b
+
+	/* lock icache */
+	mfspr	r10, SPRN_HID0
+	ori	r10, r10, 0x2000
+	sync; isync;
+	mtspr	SPRN_HID0, r10
+	sync; isync;
+
+
+	mflr	r9 /* save LR */
+
+	/* jump to sram */
+	mtlr	r3
+	blrl
+
+	mtlr	r9 /* restore LR */
+
+	/* unlock icache */
+	mfspr	r10, SPRN_HID0
+	ori	r10, r10, 0x2000
+	xori	r10, r10, 0x2000
+	sync; isync;
+	mtspr	SPRN_HID0, r10
+	sync; isync;
+
+
+	/* return to C code */
+	blr
+
+
+_GLOBAL(mpc52xx_ds_sram)
+mpc52xx_ds_sram:
+	/* put SDRAM into self-refresh */
+	lwz	r8, 0x4(r4)	/* sdram->ctrl */
+
+	oris	r8, r8, 0x8000 /* mode_en */
+	stw	r8, 0x4(r4)
+	sync
+
+	ori	r8, r8, 0x0002 /* soft_pre */
+	stw	r8, 0x4(r4)
+	sync
+	xori	r8, r8, 0x0002
+
+	xoris	r8, r8, 0x8000 /* !mode_en */
+	stw	r8, 0x4(r4)
+	sync
+
+	oris	r8, r8, 0x5000
+	xoris	r8, r8, 0x4000 /* ref_en !cke */
+	stw	r8, 0x4(r4)
+	sync
+
+	/* disable SDRAM clock */
+	lwz	r8, 0x14(r5) /* cdm->clkenable */
+	ori	r8, r8, 0x0008
+	xori	r8, r8, 0x0008
+	stw	r8, 0x14(r5)
+	sync
+
+
+	/* put mpc5200 to sleep */
+	mfmsr	r10
+	oris	r10, r10, 0x0004	/* POW = 1 */
+	sync; isync;
+	mtmsr	r10
+	sync; isync;
+
+
+	/* enable clock */
+	lwz	r8, 0x14(r5)
+	ori	r8, r8, 0x0008
+	stw	r8, 0x14(r5)
+	sync
+
+	/* get ram out of self-refresh */
+	lwz	r8, 0x4(r4)
+	oris	r8, r8, 0x5000 /* cke ref_en */
+	stw	r8, 0x4(r4)
+	sync
+
+	blr
+_GLOBAL(mpc52xx_ds_sram_size)
+mpc52xx_ds_sram_size:
+	.long $-mpc52xx_ds_sram
+
+
+/* ### interrupt handler for wakeup from deep-sleep ### */
+_GLOBAL(mpc52xx_ds_cached)
+mpc52xx_ds_cached:
+	mtspr	SPRN_SPRG0, r7
+	mtspr	SPRN_SPRG1, r8
+
+	/* disable emulated interrupt */
+	mfspr	r7, 311 /* MBAR */
+	addi	r7, r7, 0x540	/* intr->main_emul */
+	li	r8, 0
+	stw	r8, 0(r7)
+	sync
+	dcbf	0, r7
+
+	/* acknowledge wakeup, so CCS releases power pown */
+	mfspr	r7, 311	/* MBAR */
+	addi	r7, r7, 0x524	/* intr->enc_status */
+	lwz	r8, 0(r7)
+	ori	r8, r8, 0x0400
+	stw	r8, 0(r7)
+	sync
+	dcbf	0, r7
+
+	/* flag - we handled the interrupt */
+	li	r10, 1
+
+	mfspr	r8, SPRN_SPRG1
+	mfspr	r7, SPRN_SPRG0
+
+	rfi
+_GLOBAL(mpc52xx_ds_cached_size)
+mpc52xx_ds_cached_size:
+	.long $-mpc52xx_ds_cached
Index: grant.git/arch/powerpc/platforms/52xx/efika.c
===================================================================
--- grant.git.orig/arch/powerpc/platforms/52xx/efika.c
+++ grant.git/arch/powerpc/platforms/52xx/efika.c
@@ -185,6 +185,16 @@ static void efika_show_cpuinfo(struct se
 	of_node_put(root);
 }
 
+#ifdef CONFIG_PM
+static void efika_suspend_prepare(void __iomem *mbar)
+{
+	u8 pin = 4;	/* GPIO_WKUP_4 (GPIO_PSC6_0 - IRDA_RX) */
+	u8 level = 1;	/* wakeup on high level */
+	/* IOW. to wake it up, short pins 1 and 3 on IRDA connector */
+	mpc52xx_set_wakeup_gpio(pin, level);
+}
+#endif
+
 static void __init efika_setup_arch(void)
 {
 	rtas_initialize();
@@ -200,6 +210,11 @@ static void __init efika_setup_arch(void
 
 	efika_pcisetup();
 
+#ifdef CONFIG_PM
+	mpc52xx_suspend.board_suspend_prepare = efika_suspend_prepare;
+	mpc52xx_pm_init();
+#endif
+
 	if (ppc_md.progress)
 		ppc_md.progress("Linux/PPC " UTS_RELEASE " running on Efika ;-)\n", 0x0);
 }
Index: grant.git/arch/powerpc/platforms/52xx/lite5200.c
===================================================================
--- grant.git.orig/arch/powerpc/platforms/52xx/lite5200.c
+++ grant.git/arch/powerpc/platforms/52xx/lite5200.c
@@ -85,6 +85,28 @@ error:
 	iounmap(gpio);
 }
 
+#ifdef CONFIG_PM
+static u32 descr_a;
+static void lite5200_suspend_prepare(void __iomem *mbar)
+{
+	u8 pin = 1;	/* GPIO_WKUP_1 (GPIO_PSC2_4) */
+	u8 level = 0;	/* wakeup on low level */
+	mpc52xx_set_wakeup_gpio(pin, level);
+
+	/*
+	 * power down usb port
+	 * this needs to be called before of-ohci suspend code
+	 */
+	descr_a = in_be32(mbar + 0x1048);
+	out_be32(mbar + 0x1048, (descr_a & ~0x200) | 0x100);
+}
+
+static void lite5200_resume_finish(void __iomem *mbar)
+{
+	out_be32(mbar + 0x1048, descr_a);
+}
+#endif
+
 static void __init lite5200_setup_arch(void)
 {
 	struct device_node *np;
@@ -107,6 +129,12 @@ static void __init lite5200_setup_arch(v
 	mpc52xx_setup_cpu();	/* Generic */
 	lite5200_setup_cpu();	/* Platorm specific */
 
+#ifdef CONFIG_PM
+	mpc52xx_suspend.board_suspend_prepare = lite5200_suspend_prepare;
+	mpc52xx_suspend.board_resume_finish = lite5200_resume_finish;
+	mpc52xx_pm_init();
+#endif
+
 #ifdef CONFIG_PCI
 	np = of_find_node_by_type(np, "pci");
 	if (np)
Index: grant.git/include/asm-powerpc/mpc52xx.h
===================================================================
--- grant.git.orig/include/asm-powerpc/mpc52xx.h
+++ grant.git/include/asm-powerpc/mpc52xx.h
@@ -253,5 +253,16 @@ extern int __init mpc52xx_add_bridge(str
 
 #endif /* __ASSEMBLY__ */
 
+#ifdef CONFIG_PM
+struct mpc52xx_suspend {
+	void (*board_suspend_prepare)(void __iomem *mbar);
+	void (*board_resume_finish)(void __iomem *mbar);
+};
+
+extern struct mpc52xx_suspend mpc52xx_suspend;
+extern int __init mpc52xx_pm_init(void);
+extern int mpc52xx_set_wakeup_gpio(u8 pin, u8 level);
+#endif /* CONFIG_PM */
+
 #endif /* __ASM_POWERPC_MPC52xx_H__ */
 
