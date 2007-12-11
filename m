Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 18A4CDDF87
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 01:26:19 +1100 (EST)
Subject: [PATCH 2.6.25 5/5] powermac: proper sleep management
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
References: <20071211142122.966506000@sipsolutions.net>
Content-Type: text/plain
Date: Tue, 11 Dec 2007 15:25:59 +0100
Message-Id: <1197383159.4037.19.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds platform_suspend_ops for PMU based machines, directly in
the PMU driver. This finally allows suspending via /sys/power/state
on powerbooks.

The patch also replaces the PMU ioctl with a simple call to
pm_suspend(PM_SUSPEND_MEM).

Additionally, it cleans up some debug code.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/macintosh/via-pmu.c |  451 ++++++++++++++++++++------------------------
 1 file changed, 206 insertions(+), 245 deletions(-)

--- everything.orig/drivers/macintosh/via-pmu.c	2007-12-11 15:13:33.156913629 +0100
+++ everything/drivers/macintosh/via-pmu.c	2007-12-11 15:19:21.126913032 +0100
@@ -10,13 +10,13 @@
  *
  * Copyright (C) 1998 Paul Mackerras and Fabio Riccardi.
  * Copyright (C) 2001-2002 Benjamin Herrenschmidt
+ * Copyright (C) 2006-2007 Johannes Berg
  *
  * THIS DRIVER IS BECOMING A TOTAL MESS !
  *  - Cleanup atomically disabling reply to PMU events after
  *    a sleep or a freq. switch
- *  - Move sleep code out of here to pmac_pm, merge into new
- *    common PM infrastructure
- *  - Save/Restore PCI space properly
+ *  - check if powerbook 3400 really needs the extra PCI
+ *    save/restore code we have
  *
  */
 #include <stdarg.h>
@@ -64,7 +64,7 @@
 #include "via-pmu-event.h"
 
 /* Some compile options */
-#define DEBUG_SLEEP
+#undef DEBUG_SLEEP
 
 /* Misc minor number allocated for /dev/pmu */
 #define PMU_MINOR		154
@@ -149,12 +149,9 @@ static spinlock_t pmu_lock;
 static u8 pmu_intr_mask;
 static int pmu_version;
 static int drop_interrupts;
-#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_PPC32)
+#if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC32)
 static int option_lid_wakeup = 1;
-#endif /* CONFIG_PM_SLEEP && CONFIG_PPC32 */
-#if (defined(CONFIG_PM_SLEEP)&&defined(CONFIG_PPC32))||defined(CONFIG_PMAC_BACKLIGHT_LEGACY)
-static int sleep_in_progress;
-#endif
+#endif /* CONFIG_SUSPEND && CONFIG_PPC32 */
 static unsigned long async_req_locks;
 static unsigned int pmu_irq_stats[11];
 
@@ -220,7 +217,7 @@ extern void enable_kernel_fp(void);
 
 #ifdef DEBUG_SLEEP
 int pmu_polled_request(struct adb_request *req);
-int pmu_wink(struct adb_request *req);
+void pmu_blink(int n);
 #endif
 
 /*
@@ -871,7 +868,7 @@ proc_read_options(char *page, char **sta
 {
 	char *p = page;
 
-#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_PPC32)
+#if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC32)
 	if (pmu_kind == PMU_KEYLARGO_BASED &&
 	    pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) >= 0)
 		p += sprintf(p, "lid_wakeup=%d\n", option_lid_wakeup);
@@ -912,7 +909,7 @@ proc_write_options(struct file *file, co
 	*(val++) = 0;
 	while(*val == ' ')
 		val++;
-#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_PPC32)
+#if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC32)
 	if (pmu_kind == PMU_KEYLARGO_BASED &&
 	    pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) >= 0)
 		if (!strcmp(label, "lid_wakeup"))
@@ -1718,7 +1715,7 @@ pmu_present(void)
 	return via != 0;
 }
 
-#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_PPC32)
+#if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC32)
 /*
  * This struct is used to store config register values for
  * PCI devices which may get powered off when we sleep.
@@ -1821,42 +1818,6 @@ pbook_pci_restore(void)
 	}
 }
 
-#ifdef DEBUG_SLEEP
-/* N.B. This doesn't work on the 3400 */
-void 
-pmu_blink(int n)
-{
-	struct adb_request req;
-
-	memset(&req, 0, sizeof(req));
-
-	for (; n > 0; --n) {
-		req.nbytes = 4;
-		req.done = NULL;
-		req.data[0] = 0xee;
-		req.data[1] = 4;
-		req.data[2] = 0;
-		req.data[3] = 1;
-		req.reply[0] = ADB_RET_OK;
-		req.reply_len = 1;
-		req.reply_expected = 0;
-		pmu_polled_request(&req);
-		mdelay(50);
-		req.nbytes = 4;
-		req.done = NULL;
-		req.data[0] = 0xee;
-		req.data[1] = 4;
-		req.data[2] = 0;
-		req.data[3] = 0;
-		req.reply[0] = ADB_RET_OK;
-		req.reply_len = 1;
-		req.reply_expected = 0;
-		pmu_polled_request(&req);
-		mdelay(50);
-	}
-	mdelay(50);
-}
-#endif
 
 /*
  * Put the powerbook to sleep.
@@ -1894,122 +1855,6 @@ restore_via_state(void)
 
 extern void pmu_backlight_set_sleep(int sleep);
 
-static int
-pmac_suspend_devices(void)
-{
-	int ret;
-
-	pm_prepare_console();
-	
-	/* Sync the disks. */
-	/* XXX It would be nice to have some way to ensure that
-	 * nobody is dirtying any new buffers while we wait. That
-	 * could be achieved using the refrigerator for processes
-	 * that swsusp uses
-	 */
-	sys_sync();
-
-	/* Send suspend call to devices, hold the device core's dpm_sem */
-	ret = device_suspend(PMSG_SUSPEND);
-	if (ret) {
-		printk(KERN_ERR "Driver sleep failed\n");
-		return -EBUSY;
-	}
-
-#ifdef CONFIG_PMAC_BACKLIGHT
-	/* Tell backlight code not to muck around with the chip anymore */
-	pmu_backlight_set_sleep(1);
-#endif
-
-	/* Call platform functions marked "on sleep" */
-	pmac_pfunc_i2c_suspend();
-	pmac_pfunc_base_suspend();
-
-	/* Stop preemption */
-	preempt_disable();
-
-	/* Make sure the decrementer won't interrupt us */
-	asm volatile("mtdec %0" : : "r" (0x7fffffff));
-	/* Make sure any pending DEC interrupt occurring while we did
-	 * the above didn't re-enable the DEC */
-	mb();
-	asm volatile("mtdec %0" : : "r" (0x7fffffff));
-
-	/* We can now disable MSR_EE. This code of course works properly only
-	 * on UP machines... For SMP, if we ever implement sleep, we'll have to
-	 * stop the "other" CPUs way before we do all that stuff.
-	 */
-	local_irq_disable();
-
-	/* Broadcast power down irq
-	 * This isn't that useful in most cases (only directly wired devices can
-	 * use this but still... This will take care of sysdev's as well, so
-	 * we exit from here with local irqs disabled and PIC off.
-	 */
-	ret = device_power_down(PMSG_SUSPEND);
-	if (ret) {
-		wakeup_decrementer();
-		local_irq_enable();
-		preempt_enable();
-		device_resume();
-		printk(KERN_ERR "Driver powerdown failed\n");
-		return -EBUSY;
-	}
-
-	/* Wait for completion of async requests */
-	while (!batt_req.complete)
-		pmu_poll();
-
-	/* Giveup the lazy FPU & vec so we don't have to back them
-	 * up from the low level code
-	 */
-	enable_kernel_fp();
-
-#ifdef CONFIG_ALTIVEC
-	if (cpu_has_feature(CPU_FTR_ALTIVEC))
-		enable_kernel_altivec();
-#endif /* CONFIG_ALTIVEC */
-
-	return 0;
-}
-
-static int
-pmac_wakeup_devices(void)
-{
-	mdelay(100);
-
-#ifdef CONFIG_PMAC_BACKLIGHT
-	/* Tell backlight code it can use the chip again */
-	pmu_backlight_set_sleep(0);
-#endif
-
-	/* Power back up system devices (including the PIC) */
-	device_power_up();
-
-	/* Force a poll of ADB interrupts */
-	adb_int_pending = 1;
-	via_pmu_interrupt(0, NULL);
-
-	/* Restart jiffies & scheduling */
-	wakeup_decrementer();
-
-	/* Re-enable local CPU interrupts */
-	local_irq_enable();
-	mdelay(10);
-	preempt_enable();
-
-	/* Call platform functions marked "on wake" */
-	pmac_pfunc_base_resume();
-	pmac_pfunc_i2c_resume();
-
-	/* Resume devices */
-	device_resume();
-
-	pm_restore_console();
-
-	return 0;
-}
-
 #define	GRACKLE_PM	(1<<7)
 #define GRACKLE_DOZE	(1<<5)
 #define	GRACKLE_NAP	(1<<4)
@@ -2020,19 +1865,12 @@ static int powerbook_sleep_grackle(void)
 	unsigned long save_l2cr;
 	unsigned short pmcr1;
 	struct adb_request req;
-	int ret;
 	struct pci_dev *grackle;
 
 	grackle = pci_get_bus_and_slot(0, 0);
 	if (!grackle)
 		return -ENODEV;
 
-	ret = pmac_suspend_devices();
-	if (ret) {
-		printk(KERN_ERR "Sleep rejected by devices\n");
-		return ret;
-	}
-	
 	/* Turn off various things. Darwin does some retry tests here... */
 	pmu_request(&req, NULL, 2, PMU_POWER_CTRL0, PMU_POW0_OFF|PMU_POW0_HARD_DRIVE);
 	pmu_wait_complete(&req);
@@ -2095,8 +1933,6 @@ static int powerbook_sleep_grackle(void)
 			PMU_POW_ON|PMU_POW_BACKLIGHT|PMU_POW_CHARGER|PMU_POW_IRLED|PMU_POW_MEDIABAY);
 	pmu_wait_complete(&req);
 
-	pmac_wakeup_devices();
-
 	return 0;
 }
 
@@ -2106,7 +1942,6 @@ powerbook_sleep_Core99(void)
 	unsigned long save_l2cr;
 	unsigned long save_l3cr;
 	struct adb_request req;
-	int ret;
 	
 	if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) < 0) {
 		printk(KERN_ERR "Sleep mode not supported on this machine\n");
@@ -2116,12 +1951,6 @@ powerbook_sleep_Core99(void)
 	if (num_online_cpus() > 1 || cpu_is_offline(0))
 		return -EAGAIN;
 
-	ret = pmac_suspend_devices();
-	if (ret) {
-		printk(KERN_ERR "Sleep rejected by devices\n");
-		return ret;
-	}
-
 	/* Stop environment and ADB interrupts */
 	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, 0);
 	pmu_wait_complete(&req);
@@ -2192,41 +2021,24 @@ powerbook_sleep_Core99(void)
 	/* Restore LPJ, cpufreq will adjust the cpu frequency */
 	loops_per_jiffy /= 2;
 
-	pmac_wakeup_devices();
-
 	return 0;
 }
 
 #define PB3400_MEM_CTRL		0xf8000000
 #define PB3400_MEM_CTRL_SLEEP	0x70
 
+static void __iomem *pb3400_mem_ctrl;
+
 static int
 powerbook_sleep_3400(void)
 {
-	int ret, i, x;
+	int i, x;
 	unsigned int hid0;
 	unsigned long p;
 	struct adb_request sleep_req;
-	void __iomem *mem_ctrl;
 	unsigned int __iomem *mem_ctrl_sleep;
 
-	/* first map in the memory controller registers */
-	mem_ctrl = ioremap(PB3400_MEM_CTRL, 0x100);
-	if (mem_ctrl == NULL) {
-		printk("powerbook_sleep_3400: ioremap failed\n");
-		return -ENOMEM;
-	}
-	mem_ctrl_sleep = mem_ctrl + PB3400_MEM_CTRL_SLEEP;
-
-	/* Allocate room for PCI save */
-	pbook_alloc_pci_save();
-
-	ret = pmac_suspend_devices();
-	if (ret) {
-		pbook_free_pci_save();
-		printk(KERN_ERR "Sleep rejected by devices\n");
-		return ret;
-	}
+	mem_ctrl_sleep = pb3400_mem_ctrl + PB3400_MEM_CTRL_SLEEP;
 
 	/* Save the state of PCI config space for some slots */
 	pbook_pci_save();
@@ -2271,14 +2083,10 @@ powerbook_sleep_3400(void)
 	while (asleep)
 		mb();
 
-	pmac_wakeup_devices();
-	pbook_free_pci_save();
-	iounmap(mem_ctrl);
-
 	return 0;
 }
 
-#endif /* CONFIG_PM_SLEEP && CONFIG_PPC32 */
+#endif /* CONFIG_SUSPEND && CONFIG_PPC32 */
 
 /*
  * Support for /dev/pmu device
@@ -2451,6 +2259,157 @@ pmu_release(struct inode *inode, struct 
 	return 0;
 }
 
+#if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC32)
+static int powerbook_prepare_sleep(void)
+{
+	if (pmu_kind == PMU_OHARE_BASED) {
+		/* first map in the memory controller registers */
+		pb3400_mem_ctrl = ioremap(PB3400_MEM_CTRL, 0x100);
+		if (!pb3400_mem_ctrl) {
+			printk(KERN_ERR "powerbook_sleep_3400: "
+			       "ioremap failed\n");
+			return -ENOMEM;
+		}
+
+		/* Allocate room for PCI save */
+		pbook_alloc_pci_save();
+	}
+
+	return 0;
+}
+
+/*
+ * overrides the weak arch_suspend_disable_irqs in kernel/power/main.c
+ *
+ * XXX: Once Scott Wood's patch is merged, this needs to use the ppc_md
+ *	hooks that patch adds!
+ */
+void arch_suspend_disable_irqs(void)
+{
+#ifdef CONFIG_PMAC_BACKLIGHT
+	/* Tell backlight code not to muck around with the chip anymore */
+	pmu_backlight_set_sleep(1);
+#endif
+
+	/* Call platform functions marked "on sleep" */
+	pmac_pfunc_i2c_suspend();
+	pmac_pfunc_base_suspend();
+
+	/* Stop preemption */
+	preempt_disable();
+
+	/* Make sure the decrementer won't interrupt us */
+	asm volatile("mtdec %0" : : "r" (0x7fffffff));
+	/* Make sure any pending DEC interrupt occurring while we did
+	 * the above didn't re-enable the DEC */
+	mb();
+	asm volatile("mtdec %0" : : "r" (0x7fffffff));
+
+	local_irq_disable();
+}
+
+static int powerbook_sleep(suspend_state_t state)
+{
+	int error = 0;
+
+	/* Wait for completion of async requests */
+	while (!batt_req.complete)
+		pmu_poll();
+
+	/* Giveup the lazy FPU & vec so we don't have to back them
+	 * up from the low level code
+	 */
+	enable_kernel_fp();
+
+#ifdef CONFIG_ALTIVEC
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
+		enable_kernel_altivec();
+#endif /* CONFIG_ALTIVEC */
+
+	switch (pmu_kind) {
+	case PMU_OHARE_BASED:
+		error = powerbook_sleep_3400();
+		break;
+	case PMU_HEATHROW_BASED:
+	case PMU_PADDINGTON_BASED:
+		error = powerbook_sleep_grackle();
+		break;
+	case PMU_KEYLARGO_BASED:
+		error = powerbook_sleep_Core99();
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	if (error)
+		return error;
+
+	mdelay(100);
+
+#ifdef CONFIG_PMAC_BACKLIGHT
+	/* Tell backlight code it can use the chip again */
+	pmu_backlight_set_sleep(0);
+#endif
+
+	return 0;
+}
+
+/*
+ * overrides the weak arch_suspend_enable_irqs in kernel/power/main.c
+ *
+ * XXX: Once Scott Wood's patch is merged, this needs to use the ppc_md
+ *	hooks that patch adds!
+ */
+void arch_suspend_enable_irqs(void)
+{
+	/* Force a poll of ADB interrupts */
+	adb_int_pending = 1;
+	via_pmu_interrupt(0, NULL);
+
+	/* Restart jiffies & scheduling */
+	wakeup_decrementer();
+
+	/* Re-enable local CPU interrupts */
+	local_irq_enable();
+	mdelay(10);
+	preempt_enable();
+
+	/* Call platform functions marked "on wake" */
+	pmac_pfunc_base_resume();
+	pmac_pfunc_i2c_resume();
+}
+
+static void powerbook_finish_sleep(void)
+{
+	if (pmu_kind == PMU_OHARE_BASED) {
+		pbook_free_pci_save();
+		iounmap(pb3400_mem_ctrl);
+	}
+}
+
+static int pmu_sleep_valid(suspend_state_t state)
+{
+	return state == PM_SUSPEND_MEM
+		&& (pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, -1) >= 0);
+}
+
+static struct platform_suspend_ops pmu_pm_ops = {
+	.prepare = powerbook_prepare_sleep,
+	.enter = powerbook_sleep,
+	.finish = powerbook_finish_sleep,
+	.valid = pmu_sleep_valid,
+};
+
+static int register_pmu_pm_ops(void)
+{
+	suspend_set_ops(&pmu_pm_ops);
+
+	return 0;
+}
+
+device_initcall(register_pmu_pm_ops);
+#endif
+
 static int
 pmu_ioctl(struct inode * inode, struct file *filp,
 		     u_int cmd, u_long arg)
@@ -2459,35 +2418,15 @@ pmu_ioctl(struct inode * inode, struct f
 	int error = -EINVAL;
 
 	switch (cmd) {
-#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_PPC32)
 	case PMU_IOC_SLEEP:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
-		if (sleep_in_progress)
-			return -EBUSY;
-		sleep_in_progress = 1;
-		switch (pmu_kind) {
-		case PMU_OHARE_BASED:
-			error = powerbook_sleep_3400();
-			break;
-		case PMU_HEATHROW_BASED:
-		case PMU_PADDINGTON_BASED:
-			error = powerbook_sleep_grackle();
-			break;
-		case PMU_KEYLARGO_BASED:
-			error = powerbook_sleep_Core99();
-			break;
-		default:
-			error = -ENOSYS;
-		}
-		sleep_in_progress = 0;
-		break;
+		return pm_suspend(PM_SUSPEND_MEM);
 	case PMU_IOC_CAN_SLEEP:
-		if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) < 0)
+		if (pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, -1) < 0)
 			return put_user(0, argp);
 		else
 			return put_user(1, argp);
-#endif /* CONFIG_PM_SLEEP && CONFIG_PPC32 */
 
 #ifdef CONFIG_PMAC_BACKLIGHT_LEGACY
 	/* Compatibility ioctl's for backlight */
@@ -2495,9 +2434,6 @@ pmu_ioctl(struct inode * inode, struct f
 	{
 		int brightness;
 
-		if (sleep_in_progress)
-			return -EBUSY;
-
 		brightness = pmac_backlight_get_legacy_brightness();
 		if (brightness < 0)
 			return brightness;
@@ -2509,9 +2445,6 @@ pmu_ioctl(struct inode * inode, struct f
 	{
 		int brightness;
 
-		if (sleep_in_progress)
-			return -EBUSY;
-
 		error = get_user(brightness, argp);
 		if (error)
 			return error;
@@ -2636,15 +2569,43 @@ pmu_polled_request(struct adb_request *r
 	local_irq_restore(flags);
 	return 0;
 }
-#endif /* DEBUG_SLEEP */
 
+/* N.B. This doesn't work on the 3400 */
+void pmu_blink(int n)
+{
+	struct adb_request req;
 
-/* FIXME: This is a temporary set of callbacks to enable us
- * to do suspend-to-disk.
- */
+	memset(&req, 0, sizeof(req));
 
-#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_PPC32)
+	for (; n > 0; --n) {
+		req.nbytes = 4;
+		req.done = NULL;
+		req.data[0] = 0xee;
+		req.data[1] = 4;
+		req.data[2] = 0;
+		req.data[3] = 1;
+		req.reply[0] = ADB_RET_OK;
+		req.reply_len = 1;
+		req.reply_expected = 0;
+		pmu_polled_request(&req);
+		mdelay(50);
+		req.nbytes = 4;
+		req.done = NULL;
+		req.data[0] = 0xee;
+		req.data[1] = 4;
+		req.data[2] = 0;
+		req.data[3] = 0;
+		req.reply[0] = ADB_RET_OK;
+		req.reply_len = 1;
+		req.reply_expected = 0;
+		pmu_polled_request(&req);
+		mdelay(50);
+	}
+	mdelay(50);
+}
+#endif /* DEBUG_SLEEP */
 
+#if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC32)
 int pmu_sys_suspended;
 
 static int pmu_sys_suspend(struct sys_device *sysdev, pm_message_t state)
@@ -2678,7 +2639,7 @@ static int pmu_sys_resume(struct sys_dev
 	return 0;
 }
 
-#endif /* CONFIG_PM_SLEEP && CONFIG_PPC32 */
+#endif /* CONFIG_SUSPEND && CONFIG_PPC32 */
 
 static struct sysdev_class pmu_sysclass = {
 	set_kset_name("pmu"),
@@ -2689,10 +2650,10 @@ static struct sys_device device_pmu = {
 };
 
 static struct sysdev_driver driver_pmu = {
-#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_PPC32)
+#if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC32)
 	.suspend	= &pmu_sys_suspend,
 	.resume		= &pmu_sys_resume,
-#endif /* CONFIG_PM_SLEEP && CONFIG_PPC32 */
+#endif /* CONFIG_SUSPEND && CONFIG_PPC32 */
 };
 
 static int __init init_pmu_sysfs(void)
@@ -2727,10 +2688,10 @@ EXPORT_SYMBOL(pmu_wait_complete);
 EXPORT_SYMBOL(pmu_suspend);
 EXPORT_SYMBOL(pmu_resume);
 EXPORT_SYMBOL(pmu_unlock);
-#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_PPC32)
+#if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC32)
 EXPORT_SYMBOL(pmu_enable_irled);
 EXPORT_SYMBOL(pmu_battery_count);
 EXPORT_SYMBOL(pmu_batteries);
 EXPORT_SYMBOL(pmu_power_flags);
-#endif /* CONFIG_PM_SLEEP && CONFIG_PPC32 */
+#endif /* CONFIG_SUSPEND && CONFIG_PPC32 */
 
