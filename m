Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 505ECDE17B
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 00:01:10 +1100 (EST)
Message-Id: <20070207124615.473330000@sipsolutions.net>
References: <20070207124536.963531000@sipsolutions.net>
Date: Wed, 07 Feb 2007 13:45:48 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 12/12] powermac: proper sleep management
Mime-Version: 1.0
Cc: linux-pm@lists.osdl.org
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
pm_suspend(PM_SUSPEND_MEM) and puts the PMU ioctls onto the feature-removal
schedule.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
Tested on my powerbook and it works! Needs some more testing on older
powerbooks I suppose, just to see if they get problems with the slight
reordering of the suspend/resume sequence.

And before someone asks:
Yes, it is safe to remove the backlight ioctl restrictions
because the generic layer actually freezes processes before STR.

diffstat:
 Documentation/feature-removal-schedule.txt |    8 
 drivers/macintosh/via-pmu.c                |  306 +++++++++++------------------
 2 files changed, 134 insertions(+), 180 deletions(-)

--- linux-2.6-git.orig/drivers/macintosh/via-pmu.c	2007-02-07 02:55:35.966884289 +0100
+++ linux-2.6-git/drivers/macintosh/via-pmu.c	2007-02-07 02:55:36.757884289 +0100
@@ -155,9 +155,6 @@ static int drop_interrupts;
 #if defined(CONFIG_PM) && defined(CONFIG_PPC32)
 static int option_lid_wakeup = 1;
 #endif /* CONFIG_PM && CONFIG_PPC32 */
-#if (defined(CONFIG_PM)&&defined(CONFIG_PPC32))||defined(CONFIG_PMAC_BACKLIGHT_LEGACY)
-static int sleep_in_progress;
-#endif
 static unsigned long async_req_locks;
 static unsigned int pmu_irq_stats[11];
 
@@ -1992,132 +1989,6 @@ restore_via_state(void)
 
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
@@ -2128,19 +1999,12 @@ static int powerbook_sleep_grackle(void)
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
@@ -2201,8 +2065,6 @@ static int powerbook_sleep_grackle(void)
 			PMU_POW_ON|PMU_POW_BACKLIGHT|PMU_POW_CHARGER|PMU_POW_IRLED|PMU_POW_MEDIABAY);
 	pmu_wait_complete(&req);
 
-	pmac_wakeup_devices();
-
 	return 0;
 }
 
@@ -2212,7 +2074,6 @@ powerbook_sleep_Core99(void)
 	unsigned long save_l2cr;
 	unsigned long save_l3cr;
 	struct adb_request req;
-	int ret;
 	
 	if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) < 0) {
 		printk(KERN_ERR "Sleep mode not supported on this machine\n");
@@ -2222,12 +2083,6 @@ powerbook_sleep_Core99(void)
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
@@ -2298,8 +2153,6 @@ powerbook_sleep_Core99(void)
 	/* Restore LPJ, cpufreq will adjust the cpu frequency */
 	loops_per_jiffy /= 2;
 
-	pmac_wakeup_devices();
-
 	return 0;
 }
 
@@ -2309,7 +2162,7 @@ powerbook_sleep_Core99(void)
 static int
 powerbook_sleep_3400(void)
 {
-	int ret, i, x;
+	int i, x;
 	unsigned int hid0;
 	unsigned long p;
 	struct adb_request sleep_req;
@@ -2327,13 +2180,6 @@ powerbook_sleep_3400(void)
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
 
@@ -2377,7 +2223,6 @@ powerbook_sleep_3400(void)
 	while (asleep)
 		mb();
 
-	pmac_wakeup_devices();
 	pbook_free_pci_save();
 	iounmap(mem_ctrl);
 
@@ -2559,6 +2404,126 @@ pmu_release(struct inode *inode, struct 
 	return 0;
 }
 
+#if defined(CONFIG_PM) && defined(CONFIG_PPC32)
+static int powerbook_prepare_sleep(suspend_state_t state)
+{
+	/* Notify old-style device drivers */
+	broadcast_sleep(PBOOK_SLEEP_REQUEST);
+
+	sys_sync();
+
+	broadcast_sleep(PBOOK_SLEEP_NOW);
+
+#ifdef CONFIG_PMAC_BACKLIGHT
+	/* Tell backlight code not to muck around with the chip anymore */
+	pmu_backlight_set_sleep(1);
+#endif
+
+	/* Call platform functions marked "on sleep" */
+	pmac_pfunc_i2c_suspend();
+	pmac_pfunc_base_suspend();
+
+	preempt_disable();
+
+	return 0;
+}
+
+static int powerbook_sleep(suspend_state_t state)
+{
+	int error = 0;
+
+	asm volatile("mtdec %0" : : "r" (0x7fffffff));
+	/* Make sure any pending DEC interrupt occurring while we did
+	 * the above didn't re-enable the DEC */
+	mb();
+	asm volatile("mtdec %0" : : "r" (0x7fffffff));
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
+	/* Force a poll of ADB interrupts */
+	adb_int_pending = 1;
+	via_pmu_interrupt(0, NULL);
+
+	/* Restart jiffies & scheduling */
+	wakeup_decrementer();
+
+	return 0;
+}
+
+static int powerbook_finish_sleep(suspend_state_t state)
+{
+#ifdef CONFIG_PMAC_BACKLIGHT
+	/* Tell backlight code it can use the chip again */
+	pmu_backlight_set_sleep(0);
+#endif
+
+	preempt_enable();
+
+	/* Call platform functions marked "on wake" */
+	pmac_pfunc_base_resume();
+	pmac_pfunc_i2c_resume();
+
+	/* Notify old style drivers */
+	broadcast_wake();
+
+	return 0;
+}
+
+static int pmu_sleep_valid(suspend_state_t state)
+{
+	return state == PM_SUSPEND_MEM;
+}
+
+static struct pm_ops pmu_pm_ops = {
+	.pm_disk_mode = PM_DISK_PLATFORM,
+	.prepare = powerbook_prepare_sleep,
+	.finish = powerbook_finish_sleep,
+	.enter = powerbook_sleep,
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
@@ -2568,27 +2533,14 @@ pmu_ioctl(struct inode * inode, struct f
 
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
+		printk(KERN_INFO "via-pmu: suspending via ioctl is deprecated.\n");
+		printk(KERN_INFO "via-pmu: use \"echo mem > /sys/power/state\" instead!\n");
+		printk(KERN_INFO "via-pmu: this ioctl will be removed soon.\n");
+		error = pm_suspend(PM_SUSPEND_MEM);
 		break;
 	case PMU_IOC_CAN_SLEEP:
 		if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) < 0)
@@ -2603,9 +2555,6 @@ pmu_ioctl(struct inode * inode, struct f
 	{
 		int brightness;
 
-		if (sleep_in_progress)
-			return -EBUSY;
-
 		brightness = pmac_backlight_get_legacy_brightness();
 		if (brightness < 0)
 			return brightness;
@@ -2617,9 +2566,6 @@ pmu_ioctl(struct inode * inode, struct f
 	{
 		int brightness;
 
-		if (sleep_in_progress)
-			return -EBUSY;
-
 		error = get_user(brightness, argp);
 		if (error)
 			return error;
--- linux-2.6-git.orig/Documentation/feature-removal-schedule.txt	2007-02-07 02:54:55.727884289 +0100
+++ linux-2.6-git/Documentation/feature-removal-schedule.txt	2007-02-07 02:55:36.759884289 +0100
@@ -325,3 +325,11 @@ Why:	Unmaintained for years, superceded 
 Who:	Jeff Garzik <jeff@garzik.org>
 
 ---------------------------
+
+What:	via-pmu suspend ioctls (PMU_IOC_SLEEP, PMU_IOC_CAN_SLEEP)
+When:	February 2008
+Why:	The regular platform-independent interface in /sys/power/state
+	should be used instead.
+Who:	Johannes Berg <johannes@sipsolutions.net>
+
+---------------------------

--
