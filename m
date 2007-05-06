Return-Path: <tnt@246tNt.com>
Received: from outmx033.isp.belgacom.be (outmx033.isp.belgacom.be
	[195.238.6.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4D61BDDEC1
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 01:39:13 +1000 (EST)
Received: from outmx033.isp.belgacom.be (localhost.localdomain [127.0.0.1])
	by outmx033.isp.belgacom.be (8.13.4/8.13.4/Debian-3sarge3) with ESMTP
	id l46Fd9Fc027646
	for <linuxppc-dev@ozlabs.org>; Sun, 6 May 2007 17:39:09 +0200
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 8/8] powerpc: mpc52xx suspend to deep-sleep
Date: Sun,  6 May 2007 17:38:52 +0200
Message-Id: <11784659383413-git-send-email-tnt@246tNt.com>
In-Reply-To: <11784659381238-git-send-email-tnt@246tNt.com>
References: <11784659324066-git-send-email-tnt@246tNt.com>
	<11784659351487-git-send-email-tnt@246tNt.com>
	<1178465935138-git-send-email-tnt@246tNt.com>
	<11784659368-git-send-email-tnt@246tNt.com>
	<1178465936695-git-send-email-tnt@246tNt.com>
	<11784659371139-git-send-email-tnt@246tNt.com>
	<11784659372712-git-send-email-tnt@246tNt.com>
	<11784659381238-git-send-email-tnt@246tNt.com>
Cc: PPC dev ML <linuxppc-dev@ozlabs.org>, Sylvain Munaut <tnt@246tNt.com>,
	Domen Puncer <domen.puncer@telargo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Domen Puncer <domen.puncer@telargo.com>

Implement deep-sleep on MPC52xx.
SDRAM is put into self-refresh with help of SRAM code
(alternatives would be code in FLASH, I-cache).
Interrupt code must also not be in SDRAM, so put it
in I-cache.
MPC52xx core is static, so contents will remain intact even
with clocks turned off.

Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 arch/powerpc/platforms/52xx/Makefile        |    2 +
 arch/powerpc/platforms/52xx/efika.c         |   15 ++
 arch/powerpc/platforms/52xx/lite5200.c      |   28 ++++
 arch/powerpc/platforms/52xx/mpc52xx_pm.c    |  191 +++++++++++++++++++++++++++
 arch/powerpc/platforms/52xx/mpc52xx_sleep.S |  154 +++++++++++++++++++++
 include/asm-powerpc/mpc52xx.h               |   11 ++
 6 files changed, 401 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/52xx/mpc52xx_pm.c
 create mode 100644 arch/powerpc/platforms/52xx/mpc52xx_sleep.S

diff --git a/arch/powerpc/platforms/52xx/Makefile b/arch/powerpc/platforms/52xx/Makefile
index 07cdbca..b91e39c 100644
--- a/arch/powerpc/platforms/52xx/Makefile
+++ b/arch/powerpc/platforms/52xx/Makefile
@@ -8,3 +8,5 @@ endif
 
 obj-$(CONFIG_PPC_EFIKA)		+= efika.o
 obj-$(CONFIG_PPC_LITE5200)	+= lite5200.o
+
+obj-$(CONFIG_PM)		+= mpc52xx_sleep.o mpc52xx_pm.o
diff --git a/arch/powerpc/platforms/52xx/efika.c b/arch/powerpc/platforms/52xx/efika.c
index a6bba97..f591a9f 100644
--- a/arch/powerpc/platforms/52xx/efika.c
+++ b/arch/powerpc/platforms/52xx/efika.c
@@ -184,6 +184,16 @@ static void efika_show_cpuinfo(struct seq_file *m)
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
@@ -199,6 +209,11 @@ static void __init efika_setup_arch(void)
 
 	efika_pcisetup();
 
+#ifdef CONFIG_PM
+	mpc52xx_suspend.board_suspend_prepare = efika_suspend_prepare;
+	mpc52xx_pm_init();
+#endif
+
 	if (ppc_md.progress)
 		ppc_md.progress("Linux/PPC " UTS_RELEASE " running on Efika ;-)\n", 0x0);
 }
diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index 8e2646a..1cfc00d 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
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
@@ -107,6 +129,12 @@ static void __init lite5200_setup_arch(void)
 	mpc52xx_setup_cpu();	/* Generic */
 	lite5200_setup_cpu();	/* Platorm specific */
 
+#ifdef CONFIG_PM
+	mpc52xx_suspend.board_suspend_prepare = lite5200_suspend_prepare;
+	mpc52xx_suspend.board_resume_finish = lite5200_resume_finish;
+	mpc52xx_pm_init();
+#endif
+
 #ifdef CONFIG_PCI
 	np = of_find_node_by_type(NULL, "pci");
 	if (np) {
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pm.c b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
new file mode 100644
index 0000000..fd40044
--- /dev/null
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
@@ -0,0 +1,191 @@
+#include <linux/init.h>
+#include <linux/pm.h>
+#include <linux/io.h>
+#include <asm/time.h>
+#include <asm/cacheflush.h>
+#include <asm/mpc52xx.h>
+
+#include "mpc52xx_pic.h"
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
+static void *sram;
+static int sram_size;
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
+	sdram	= mbar + 0x100;
+	cdm	= mbar + 0x200;
+	intr	= mbar + 0x500;
+	gpiow	= mbar + 0xc00;
+	sram	= mbar + 0x8000;	/* Those will be handled by the */
+	sram_size = 0x4000;		/* bestcomm driver soon */
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
+	memcpy(saved_sram, sram, sram_size);
+
+	/* copy low level suspend code to sram */
+	memcpy(sram, mpc52xx_ds_sram, mpc52xx_ds_sram_size);
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
+	mpc52xx_deep_sleep(sram, sdram, cdm, intr);
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
+	memcpy(sram, saved_sram, sram_size);
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
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_sleep.S b/arch/powerpc/platforms/52xx/mpc52xx_sleep.S
new file mode 100644
index 0000000..4dc170b
--- /dev/null
+++ b/arch/powerpc/platforms/52xx/mpc52xx_sleep.S
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
diff --git a/include/asm-powerpc/mpc52xx.h b/include/asm-powerpc/mpc52xx.h
index 7afd5bf..c4631f6 100644
--- a/include/asm-powerpc/mpc52xx.h
+++ b/include/asm-powerpc/mpc52xx.h
@@ -253,5 +253,16 @@ extern int __init mpc52xx_add_bridge(struct device_node *node);
 
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
 
-- 
1.5.1.2
