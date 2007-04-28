Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AFFE1DDEEF
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 17:49:20 +1000 (EST)
Subject: [PATCH] powermac: proper sleep management
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sat, 28 Apr 2007 09:49:22 +0200
Message-Id: <1177746562.3448.10.camel@johannes.berg>
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

After having removed the power management ops from powermac completely, this
patch adds them back for PMU based machines, directly in the PMU driver.
This finally allows suspending via /sys/power/state on powerbooks.

The patch also replaces the PMU ioctl with a simple call to
pm_suspend(PM_SUSPEND_MEM) and puts the sleep-related PMU ioctls onto the
feature-removal schedule.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
This was tested on slightly older machines by David Woodhouse and by me
on my PowerBook5,6. It will apply, build and suspend-to-ram will work
against current kernels (the arch suspend hooks have been merged via
Greg KH) but it will break suspend to disk if working. This is addressed
by a patch to the generic code that Andrew Morton has and will be
sending soon under the title "rework pm_ops pm_disk_mode, kill misuse".

---
 Documentation/feature-removal-schedule.txt |   10 
 drivers/macintosh/via-pmu.c                |  329 +++++++++++++----------------
 2 files changed, 159 insertions(+), 180 deletions(-)

--- linux-2.6.orig/drivers/macintosh/via-pmu.c	2007-04-27 23:56:19.176021121 +0200
+++ linux-2.6/drivers/macintosh/via-pmu.c	2007-04-28 09:45:25.746883531 +0200
@@ -61,6 +61,10 @@
 #include <asm/cputable.h>
 #include <asm/time.h>
 #include <asm/backlight.h>
+#include <asm/suspend.h>
+
+/* remove when we don't need kernel_power_off any more */
+#include <linux/reboot.h>
 
 #include "via-pmu-event.h"
 
@@ -155,9 +159,6 @@ static int drop_interrupts;
 #if defined(CONFIG_PM) && defined(CONFIG_PPC32)
 static int option_lid_wakeup = 1;
 #endif /* CONFIG_PM && CONFIG_PPC32 */
-#if (defined(CONFIG_PM)&&defined(CONFIG_PPC32))||defined(CONFIG_PMAC_BACKLIGHT_LEGACY)
-static int sleep_in_progress;
-#endif
 static unsigned long async_req_locks;
 static unsigned int pmu_irq_stats[11];
 
@@ -1991,132 +1992,6 @@ restore_via_state(void)
 
 extern void pmu_backlight_set_sleep(int sleep);
 
-static int
-pmac_suspend_devices(void)
-{
-	int ret;
-
-	pm_prepare_console();
-	
-	/* Notify old-style device drivers */
-	broadcast_sleep(PBOOK_SLEEP_REQUEST);
-
-	/* Sync the disks. */
-	/* XXX It would be nice to have some way to ensure that
-	 * nobody is dirtying any new buffers while we wait. That
-	 * could be achieved using the refrigerator for processes
-	 * that swsusp uses
-	 */
-	sys_sync();
-
-	broadcast_sleep(PBOOK_SLEEP_NOW);
-
-	/* Send suspend call to devices, hold the device core's dpm_sem */
-	ret = device_suspend(PMSG_SUSPEND);
-	if (ret) {
-		broadcast_wake();
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
-		broadcast_wake();
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
-	/* Notify old style drivers */
-	broadcast_wake();
-
-	pm_restore_console();
-
-	return 0;
-}
-
 #define	GRACKLE_PM	(1<<7)
 #define GRACKLE_DOZE	(1<<5)
 #define	GRACKLE_NAP	(1<<4)
@@ -2127,19 +2002,12 @@ static int powerbook_sleep_grackle(void)
 	unsigned long save_l2cr;
 	unsigned short pmcr1;
 	struct adb_request req;
-	int ret;
 	struct pci_dev *grackle;
 
 	grackle = pci_find_slot(0, 0);
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
@@ -2200,8 +2068,6 @@ static int powerbook_sleep_grackle(void)
 			PMU_POW_ON|PMU_POW_BACKLIGHT|PMU_POW_CHARGER|PMU_POW_IRLED|PMU_POW_MEDIABAY);
 	pmu_wait_complete(&req);
 
-	pmac_wakeup_devices();
-
 	return 0;
 }
 
@@ -2211,7 +2077,6 @@ powerbook_sleep_Core99(void)
 	unsigned long save_l2cr;
 	unsigned long save_l3cr;
 	struct adb_request req;
-	int ret;
 	
 	if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) < 0) {
 		printk(KERN_ERR "Sleep mode not supported on this machine\n");
@@ -2221,12 +2086,6 @@ powerbook_sleep_Core99(void)
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
@@ -2297,8 +2156,6 @@ powerbook_sleep_Core99(void)
 	/* Restore LPJ, cpufreq will adjust the cpu frequency */
 	loops_per_jiffy /= 2;
 
-	pmac_wakeup_devices();
-
 	return 0;
 }
 
@@ -2308,7 +2165,7 @@ powerbook_sleep_Core99(void)
 static int
 powerbook_sleep_3400(void)
 {
-	int ret, i, x;
+	int i, x;
 	unsigned int hid0;
 	unsigned long p;
 	struct adb_request sleep_req;
@@ -2326,13 +2183,6 @@ powerbook_sleep_3400(void)
 	/* Allocate room for PCI save */
 	pbook_alloc_pci_save();
 
-	ret = pmac_suspend_devices();
-	if (ret) {
-		pbook_free_pci_save();
-		printk(KERN_ERR "Sleep rejected by devices\n");
-		return ret;
-	}
-
 	/* Save the state of PCI config space for some slots */
 	pbook_pci_save();
 
@@ -2376,7 +2226,6 @@ powerbook_sleep_3400(void)
 	while (asleep)
 		mb();
 
-	pmac_wakeup_devices();
 	pbook_free_pci_save();
 	iounmap(mem_ctrl);
 
@@ -2558,6 +2407,142 @@ pmu_release(struct inode *inode, struct 
 	return 0;
 }
 
+#if defined(CONFIG_PM) && defined(CONFIG_PPC32)
+static int powerbook_prepare_sleep(suspend_state_t state)
+{
+	/* Notify old-style device drivers */
+	broadcast_sleep(PBOOK_SLEEP_REQUEST);
+	broadcast_sleep(PBOOK_SLEEP_NOW);
+
+	return 0;
+}
+
+/*
+ * overrides the weak arch_suspend_disable_irqs in kernel/power/main.c
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
+static int powerbook_finish_sleep(suspend_state_t state)
+{
+	/* Notify old style drivers */
+	broadcast_wake();
+
+	return 0;
+}
+
+static int pmu_sleep_valid(suspend_state_t state)
+{
+	return state == PM_SUSPEND_MEM
+		&& (pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, -1) >= 0);
+}
+
+static struct pm_ops pmu_pm_ops = {
+	.prepare = powerbook_prepare_sleep,
+	.enter = powerbook_sleep,
+	.finish = powerbook_finish_sleep,
+	.valid = pmu_sleep_valid,
+};
+
+static int register_pmu_pm_ops(void)
+{
+	pm_set_ops(&pmu_pm_ops);
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
@@ -2567,29 +2552,19 @@ pmu_ioctl(struct inode * inode, struct f
 
 	switch (cmd) {
 #if defined(CONFIG_PM) && defined(CONFIG_PPC32)
+	/* just provided for compatibility */
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
+		printk(KERN_INFO "via-pmu: the PMU_IOC_SLEEP ioctl is deprecated.\n");
+		printk(KERN_INFO "via-pmu: use \"echo mem > /sys/power/state\" instead!\n");
+		printk(KERN_INFO "via-pmu: this ioctl will be removed soon.\n");
+		error = pm_suspend(PM_SUSPEND_MEM);
 		break;
 	case PMU_IOC_CAN_SLEEP:
+		printk(KERN_INFO "via-pmu: the PMU_IOC_CAN_SLEEP ioctl is deprecated.\n");
+		printk(KERN_INFO "via-pmu: use \"grep mem /sys/power/state\" instead!\n");
+		printk(KERN_INFO "via-pmu: this ioctl will be removed soon.\n");
 		if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) < 0)
 			return put_user(0, argp);
 		else
@@ -2602,9 +2577,6 @@ pmu_ioctl(struct inode * inode, struct f
 	{
 		int brightness;
 
-		if (sleep_in_progress)
-			return -EBUSY;
-
 		brightness = pmac_backlight_get_legacy_brightness();
 		if (brightness < 0)
 			return brightness;
@@ -2616,9 +2588,6 @@ pmu_ioctl(struct inode * inode, struct f
 	{
 		int brightness;
 
-		if (sleep_in_progress)
-			return -EBUSY;
-
 		error = get_user(brightness, argp);
 		if (error)
 			return error;
--- linux-2.6.orig/Documentation/feature-removal-schedule.txt	2007-04-27 23:56:19.196021121 +0200
+++ linux-2.6/Documentation/feature-removal-schedule.txt	2007-04-28 00:52:59.482010117 +0200
@@ -302,3 +302,13 @@ Why:	Code was merged, then submitter imm
 Who:	David S. Miller <davem@davemloft.net>
 
 ---------------------------
+
+What:	/dev/pmu suspend/can-suspend ioctls
+When:	2.6.24
+Files:	drivers/macintosh/via-pmu.c
+Why:	powermac supports proper generic pm_ops now and can suspend with
+	"echo mem > /sys/power/state" instead of the ioctl, checking if
+	it can suspend can be done by reading /sys/power/state.
+Who:	Johannes Berg <johannes@sipsolutions.net>
+
+---------------------------
