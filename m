Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 1E237DDEF0
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 08:40:48 +1100 (EST)
Date: Sun, 18 Mar 2007 22:40:49 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH] power-management elements for 603e/fsl
Message-ID: <Pine.LNX.4.60.0703182216130.4143@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all

Below is my current patch that allows me to suspend my kurobox.

As some of you would know, it is not a real suspend-to-RAM, since kurobox' 
hardware doesn't support powering down CPU and peripherals while keeping 
RAM in self-refresh. So, this patch just sends the SoC and the CPU to 
SLEEP. It also needs some extra patches for timer suspend / resume, so, 
this alone will not work properly. Besides, I am not where to put and how 
to call these functions. So far I put them in fsl namespace as that'll, 
probably, be similar among Freescale chips? Maybe it's better to call this 
mode standby, not str?

Is there interest in this code at all? if yes - how and where do we want 
to put it?

Thanks
Guennadi
---
Guennadi Liakhovetski

Implement "soft" suspend on linkstation.

Signed-off-by: G. Liakhovetski <g.liakhovetski@gmx.de>

diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index 3f6c411..1daf0ae 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -11,15 +11,15 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/pci.h>
 #include <linux/initrd.h>
 #include <linux/mtd/physmap.h>
+#include <linux/serial_reg.h>
+#include <sysdev/fsl_soc.h>
 
 #include <asm/time.h>
 #include <asm/prom.h>
 #include <asm/mpic.h>
 #include <asm/mpc10x.h>
-#include <asm/pci-bridge.h>
 
 static struct mtd_partition linkstation_physmap_partitions[] = {
 	{
@@ -134,6 +134,7 @@ static void __init linkstation_init_IRQ(
 
 extern void avr_uart_configure(void);
 extern void avr_uart_send(const char);
+extern int avr_uart_ier_swap(const char, char *);
 
 static void linkstation_restart(char *cmd)
 {
@@ -197,3 +198,87 @@ define_machine(linkstation){
 	.halt	 		= linkstation_halt,
 	.calibrate_decr 	= generic_calibrate_decr,
 };
+
+#ifdef CONFIG_PM
+
+static int ls_pm_valid(suspend_state_t state)
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
+static int ls_pm_enter(suspend_state_t state)
+{
+	char ier;
+	int ret = 0;
+	u64 tb;
+
+	/* Stop preemption */
+	preempt_disable();
+
+	if ((ret = fsl_suspend(state)) < 0) {
+		preempt_enable();
+		return ret;
+	}
+
+	local_irq_disable();
+
+	avr_uart_configure();
+	ret = avr_uart_ier_swap(UART_IER_RDI | UART_IER_RLSI/* | UART_IER_THRI*/, &ier);
+	if (ret < 0)
+		goto fail;
+
+	/* Get timebase */
+	tb = get_tb();
+
+	/* go zzzzz... (re-enabling interrupts) */
+	fsl_low_sleep();
+
+	local_irq_disable();
+
+	set_tb(tb >> 32, tb & 0xfffffffful);
+
+	(void)avr_uart_ier_swap(ier, NULL);
+fail:
+
+	/* Re-enable local CPU interrupts */
+	local_irq_enable();
+
+	preempt_enable();
+
+	fsl_resume(state);
+
+	return ret;
+}
+
+/*
+ * Called after devices are re-setup, but before processes are thawed.
+ */
+static int ls_pm_finish(suspend_state_t state)
+{
+	return 0;
+}
+
+/*
+ * Set to PM_DISK_FIRMWARE so we can quickly veto suspend-to-disk.
+ */
+static struct pm_ops ls_pm_ops = {
+//	.pm_disk_mode	= PM_DISK_FIRMWARE,
+	.valid		= ls_pm_valid,
+	.enter		= ls_pm_enter,
+	.finish		= ls_pm_finish,
+};
+
+static int __init ls_pm_init(void)
+{
+	pm_set_ops(&ls_pm_ops);
+	return 0;
+}
+
+device_initcall(ls_pm_init);
+#endif
diff --git a/arch/powerpc/platforms/embedded6xx/ls_uart.c b/arch/powerpc/platforms/embedded6xx/ls_uart.c
index 0e83776..e7cf3bd 100644
--- a/arch/powerpc/platforms/embedded6xx/ls_uart.c
+++ b/arch/powerpc/platforms/embedded6xx/ls_uart.c
@@ -1,3 +1,14 @@
+/*
+ * AVR power-management chip interface for the Buffalo Linkstation /
+ * Kurobox Platform.
+ *
+ * Author: 2006 (c) G. Liakhovetski
+ *	 g.liakhovetski@gmx.de
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of
+ * any kind, whether express or implied.
+ */
 #include <linux/workqueue.h>
 #include <linux/string.h>
 #include <linux/delay.h>
@@ -11,6 +22,7 @@ #include <asm/termbits.h>
 
 static void __iomem *avr_addr;
 static unsigned long avr_clock;
+static unsigned int avr_virq;
 
 static struct work_struct wd_work;
 
@@ -42,6 +54,37 @@ static void wd_stop(struct work_struct *
 	printk("\n");
 }
 
+static irqreturn_t avr_handler(int irq, void *id)
+{
+	(void) in_8(avr_addr + UART_LSR);
+	(void) in_8(avr_addr + UART_RX);
+	(void) in_8(avr_addr + UART_IIR);
+	(void) in_8(avr_addr + UART_MSR);
+
+	return IRQ_HANDLED;
+}
+
+int avr_uart_ier_swap(const char new, char *old)
+{
+	int ret = 0;
+
+	if (!avr_addr || !avr_clock || avr_virq == NO_IRQ)
+		return -EIO;
+
+	if (old)
+		ret = request_irq(avr_virq, avr_handler, 0, "avr_wakeup", NULL);
+	else
+		free_irq(avr_virq, NULL);
+
+	if (ret >= 0) {
+		if (old)
+			*old = in_8(avr_addr + UART_IER);
+		out_8(avr_addr + UART_IER, new);
+	}
+
+	return ret;
+}
+
 #define AVR_QUOT(clock) ((clock) + 8 * 9600) / (16 * 9600)
 
 void avr_uart_configure(void)
@@ -104,7 +147,7 @@ static int __init ls_uarts_init(void)
 {
 	struct device_node *avr;
 	phys_addr_t phys_addr;
-	int len;
+	int len, irq;
 
 	avr = of_find_node_by_path("/soc10x/serial@80004500");
 	if (!avr)
@@ -112,10 +155,15 @@ static int __init ls_uarts_init(void)
 
 	avr_clock = *(u32*)get_property(avr, "clock-frequency", &len);
 	phys_addr = ((u32*)get_property(avr, "reg", &len))[0];
+	irq = ((u32*)get_property(avr, "interrupts", &len))[0];
 
 	if (!avr_clock || !phys_addr)
 		return -EINVAL;
 
+	avr_virq = irq_find_mapping(NULL, irq);
+	if (avr_virq == NO_IRQ)
+		return -EIO;
+
 	avr_addr = ioremap(phys_addr, 32);
 	if (!avr_addr)
 		return -EFAULT;
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 26ca3ff..a939edd 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -11,9 +11,15 @@ obj-$(CONFIG_PPC_PMI)		+= pmi.o
 obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
+ifeq ($(CONFIG_PM),y)
+obj-$(CONFIG_FSL_SOC)		+= fsl_pm.o
+endif
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
 
+# contains only the suspend handler for time
+obj-$(CONFIG_PM)		+= timer.o
+
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
 obj-$(CONFIG_PPC_83xx)		+= ipic.o
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index d20f029..80465fd 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -1097,3 +1097,65 @@ err:
 arch_initcall(cpm_smc_uart_of_init);
 
 #endif /* CONFIG_8xx */
+
+#ifdef CONFIG_PM
+#include <linux/pci.h>
+#include <asm/pci-bridge.h>
+
+#define	MPC10X_LP_REF_EN	(1<<12)
+#define	MPC10X_PM		(1<<7)
+#define MPC10X_DOZE		(1<<5)
+#define	MPC10X_NAP		(1<<4)
+#define	MPC10X_SLEEP		(1<<3)
+
+int fsl_suspend(suspend_state_t state)
+{
+	struct pci_dev *bridge;
+	unsigned long flags;
+	u16 pmcr1;
+
+	bridge = pci_find_slot(0, 0);
+	if (!bridge)
+		return -ENODEV;
+
+	pci_read_config_word(bridge, 0x70, &pmcr1);
+	local_irq_save(flags);
+	/* Apparently, MacOS uses NAP mode for Grackle ??? */
+	pmcr1 &= ~(MPC10X_DOZE | MPC10X_NAP); 
+	pmcr1 |= MPC10X_PM | MPC10X_SLEEP | MPC10X_LP_REF_EN;
+	pci_write_config_word(bridge, 0x70, pmcr1);
+	local_irq_restore(flags);
+
+	/* Make sure the decrementer won't interrupt us */
+	asm volatile("mtdec %0" : : "r" (0x7fffffff));
+	/* Make sure any pending DEC interrupt occurring while we did
+	 * the above didn't re-enable the DEC */
+	mb();
+	asm volatile("mtdec %0" : : "r" (0x7fffffff)); /* 8 seconds */
+
+	return 0;
+}
+
+int fsl_resume(suspend_state_t state)
+{
+	struct pci_dev *bridge;
+	unsigned long flags;
+	u16 pmcr1;
+
+	bridge = pci_find_slot(0, 0);
+	if (!bridge)
+		return -ENODEV;
+
+	local_irq_save(flags);
+	/* We're awake again, stop grackle PM */
+	pci_read_config_word(bridge, 0x70, &pmcr1);
+	pmcr1 &= ~(MPC10X_PM | MPC10X_DOZE | MPC10X_SLEEP | MPC10X_NAP | MPC10X_LP_REF_EN);
+	pci_write_config_word(bridge, 0x70, pmcr1);
+	local_irq_restore(flags);
+
+	/* Restart jiffies & scheduling */
+	wakeup_decrementer();
+
+	return 0;
+}
+#endif
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 04e145b..1a4b364 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -8,5 +8,11 @@ extern phys_addr_t get_immrbase(void);
 extern u32 get_brgfreq(void);
 extern u32 get_baudrate(void);
 
+#ifdef CONFIG_PM
+extern int fsl_suspend(suspend_state_t state);
+extern int fsl_resume(suspend_state_t state);
+extern void fsl_low_sleep(void);
+#endif
+
 #endif
 #endif
--- /dev/null	2005-08-21 16:20:22.000000000 +0200
+++ b/arch/powerpc/sysdev/fsl_pm.S	2007-03-18 21:10:53.000000000 +0100
@@ -0,0 +1,19 @@
+#include <asm/reg.h>
+#include <asm/ppc_asm.h>
+
+_GLOBAL(fsl_low_sleep)
+	isync			/* Set the HID0 and MSR for sleep. */
+	mfspr	r3,SPRN_HID0
+	rlwinm	r3,r3,0,10,7	/* clear doze, nap */
+	oris	r3,r3,HID0_SLEEP@h /* r3 |= HID0_SLEEP & (0xffff << 16) */
+	sync
+	isync
+	mtspr	SPRN_HID0,r3
+	sync
+	mfmsr	r3
+	ori	r3,r3,MSR_EE	/* Enable interrupts to wake us up */
+	oris	r3,r3,MSR_POW@h
+	sync
+	mtmsr	r3
+	isync
+	blr
