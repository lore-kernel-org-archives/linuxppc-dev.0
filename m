Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C3370DDF7B
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 02:07:39 +1100 (EST)
Subject: [RFC v2] powermac: move pm_ops
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1174357090.3813.1.camel@johannes.berg>
References: <1174357090.3813.1.camel@johannes.berg>
Content-Type: text/plain
Date: Thu, 22 Mar 2007 15:26:22 +0100
Message-Id: <1174573582.3588.0.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Subject: powermac: move pm_ops

This patch moves the pm_ops implementation from via-pmu to
arch/powerpc/platforms/powermac/pm.c since most of it isn't pmu
specific. Ben, I loosely based this the ppc32 rework patch you
sent me without actually doing any generic code rework.

Note that I've #ifdef'ed out all the pci config space save/restore
foo that's only done for 3400 anyway. For testing this code allows
you to put it back by putting a #define PCI_SAVE somewhere in the
file, but either the ifdef's should be removed or the whole code
should go, whichever works.

I have for now removed the ability to disable lid wakeup, will have to
figure out a solution for that.

---
 arch/powerpc/platforms/powermac/Makefile |    1 
 arch/powerpc/platforms/powermac/pm.c     |  445 ++++++++++++++++++++
 drivers/macintosh/via-pmu-backlight.c    |   14 
 drivers/macintosh/via-pmu-led.c          |    2 
 drivers/macintosh/via-pmu.c              |  663 +------------------------------
 include/linux/pmu.h                      |    8 
 6 files changed, 487 insertions(+), 646 deletions(-)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/arch/powerpc/platforms/powermac/pm.c	2007-03-21 10:24:48.042243895 +0100
@@ -0,0 +1,445 @@
+/*
+ * suspend to ram code
+ *
+ * Based on code from old via-pmu.c and more.
+ *
+ * Copyright (C) 1998		Paul Mackerras and Fabio Riccardi.
+ * Copyright (C) 2001-2002	Benjamin Herrenschmidt
+ * Copyright (C) 2007		Johannes Berg
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/adb.h>
+#include <linux/pmu.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/cpu.h>
+#include <asm/time.h>
+#include <asm/pmac_pfunc.h>
+#include <asm/pmac_low_i2c.h>
+#include <asm/mmu_context.h>
+#include <asm/pmac_feature.h>
+#include <asm/page.h>
+#include <asm/reg.h>
+
+static int (*pmac_low_sleep_handler)(void);
+
+#if defined(CONFIG_ADB_PMU) && defined(CONFIG_PPC32)
+/* assembly stuff */
+extern void low_sleep_handler(void);
+
+extern void pmu_backlight_set_sleep(int sleep);
+
+#define	GRACKLE_PM	(1<<7)
+#define GRACKLE_DOZE	(1<<5)
+#define	GRACKLE_NAP	(1<<4)
+#define	GRACKLE_SLEEP	(1<<3)
+
+static int powerbook_sleep_grackle(void)
+{
+	unsigned long save_l2cr;
+	unsigned short pmcr1;
+	struct adb_request req;
+	struct pci_dev *grackle;
+
+	grackle = pci_find_slot(0, 0);
+	if (!grackle)
+		return -ENODEV;
+
+	/* Turn off various things. Darwin does some retry tests here... */
+	pmu_request(&req, NULL, 2, PMU_POWER_CTRL0, PMU_POW0_OFF|PMU_POW0_HARD_DRIVE);
+	pmu_wait_complete(&req);
+	pmu_request(&req, NULL, 2, PMU_POWER_CTRL,
+		PMU_POW_OFF|PMU_POW_BACKLIGHT|PMU_POW_IRLED|PMU_POW_MEDIABAY);
+	pmu_wait_complete(&req);
+
+	/* For 750, save backside cache setting and disable it */
+	save_l2cr = _get_L2CR();	/* (returns -1 if not available) */
+
+	/* Ask the PMU to put us to sleep */
+	pmu_request(&req, NULL, 5, PMU_SLEEP, 'M', 'A', 'T', 'T');
+	pmu_wait_complete(&req);
+
+	/* The VIA is supposed not to be restored correctly*/
+	pmu_save_via_state();
+	/* We shut down some HW */
+	pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, 1);
+
+	pci_read_config_word(grackle, 0x70, &pmcr1);
+	/* Apparently, MacOS uses NAP mode for Grackle ??? */
+	pmcr1 &= ~(GRACKLE_DOZE|GRACKLE_SLEEP);
+	pmcr1 |= GRACKLE_PM|GRACKLE_NAP;
+	pci_write_config_word(grackle, 0x70, pmcr1);
+
+	/* Call low-level ASM sleep handler */
+	low_sleep_handler();
+
+	/* We're awake again, stop grackle PM */
+	pci_read_config_word(grackle, 0x70, &pmcr1);
+	pmcr1 &= ~(GRACKLE_PM|GRACKLE_DOZE|GRACKLE_SLEEP|GRACKLE_NAP);
+	pci_write_config_word(grackle, 0x70, pmcr1);
+
+	/* Make sure the PMU is idle */
+	pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, 0);
+	pmu_restore_via_state();
+
+	/* Restore L2 cache */
+	if (save_l2cr != 0xffffffff && (save_l2cr & L2CR_L2E) != 0)
+ 		_set_L2CR(save_l2cr);
+
+	/* Power things up */
+	pmu_unlock();
+	pmu_request(&req, NULL, 2, PMU_POWER_CTRL0,
+			PMU_POW0_ON|PMU_POW0_HARD_DRIVE);
+	pmu_wait_complete(&req);
+	pmu_request(&req, NULL, 2, PMU_POWER_CTRL,
+			PMU_POW_ON|PMU_POW_BACKLIGHT|PMU_POW_CHARGER|PMU_POW_IRLED|PMU_POW_MEDIABAY);
+	pmu_wait_complete(&req);
+
+	return 0;
+}
+
+static int
+powerbook_sleep_Core99(void)
+{
+	unsigned long save_l2cr;
+	unsigned long save_l3cr;
+	struct adb_request req;
+
+	if (num_online_cpus() > 1 || cpu_is_offline(0))
+		return -EAGAIN;
+
+	/* Stop environment and ADB interrupts */
+	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, 0);
+	pmu_wait_complete(&req);
+
+	/* Tell PMU what events will wake us up */
+	pmu_request(&req, NULL, 4, PMU_POWER_EVENTS, PMU_PWR_CLR_WAKEUP_EVENTS,
+		0xff, 0xff);
+	pmu_wait_complete(&req);
+	pmu_request(&req, NULL, 4, PMU_POWER_EVENTS, PMU_PWR_SET_WAKEUP_EVENTS,
+		0, PMU_PWR_WAKEUP_KEY | PMU_PWR_WAKEUP_LID_OPEN);
+	pmu_wait_complete(&req);
+
+	/* Save the state of the L2 and L3 caches */
+	save_l3cr = _get_L3CR();	/* (returns -1 if not available) */
+	save_l2cr = _get_L2CR();	/* (returns -1 if not available) */
+
+	/* Ask the PMU to put us to sleep */
+	pmu_request(&req, NULL, 5, PMU_SLEEP, 'M', 'A', 'T', 'T');
+	pmu_wait_complete(&req);
+
+	/* The VIA is supposed not to be restored correctly*/
+	pmu_save_via_state();
+
+	/* Shut down various ASICs. There's a chance that we can no longer
+	 * talk to the PMU after this, so I moved it to _after_ sending the
+	 * sleep command to it. Still need to be checked.
+	 */
+	pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, 1);
+
+	/* Call low-level ASM sleep handler */
+	low_sleep_handler();
+
+	/* Restore Apple core ASICs state */
+	pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, 0);
+
+	/* Restore VIA */
+	pmu_restore_via_state();
+
+	/* tweak LPJ before cpufreq is there */
+	loops_per_jiffy *= 2;
+
+	/* Restore video */
+	pmac_call_early_video_resume();
+
+	/* Restore L2 cache */
+	if (save_l2cr != 0xffffffff && (save_l2cr & L2CR_L2E) != 0)
+ 		_set_L2CR(save_l2cr);
+	/* Restore L3 cache */
+	if (save_l3cr != 0xffffffff && (save_l3cr & L3CR_L3E) != 0)
+ 		_set_L3CR(save_l3cr);
+
+	pmu_unlock();
+
+	/* Restore LPJ, cpufreq will adjust the cpu frequency */
+	loops_per_jiffy /= 2;
+
+	return 0;
+}
+
+#define PB3400_MEM_CTRL		0xf8000000
+#define PB3400_MEM_CTRL_SLEEP	0x70
+
+#ifdef PCI_SAVE
+static struct pci_save {
+	u16 command;
+	u16 cache_lat;
+	u16 intr;
+	u32 rom_address;
+} *pbook_pci_saves;
+static int pbook_npci_saves;
+
+static void pbook_alloc_pci_save(void)
+{
+	int npci;
+	struct pci_dev *pd = NULL;
+
+	npci = 0;
+	while ((pd = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
+		++npci;
+	}
+	if (npci == 0)
+		return;
+	pbook_pci_saves = (struct pci_save *)
+	    kmalloc(npci * sizeof(struct pci_save), GFP_KERNEL);
+	pbook_npci_saves = npci;
+}
+
+static void pbook_free_pci_save(void)
+{
+	if (pbook_pci_saves == NULL)
+		return;
+	kfree(pbook_pci_saves);
+	pbook_pci_saves = NULL;
+	pbook_npci_saves = 0;
+}
+
+static void pbook_pci_save(void)
+{
+	struct pci_save *ps = pbook_pci_saves;
+	struct pci_dev *pd = NULL;
+	int npci = pbook_npci_saves;
+
+	if (ps == NULL)
+		return;
+
+	while ((pd = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
+		if (npci-- == 0) {
+			pci_dev_put(pd);
+			return;
+		}
+		pci_read_config_word(pd, PCI_COMMAND, &ps->command);
+		pci_read_config_word(pd, PCI_CACHE_LINE_SIZE, &ps->cache_lat);
+		pci_read_config_word(pd, PCI_INTERRUPT_LINE, &ps->intr);
+		pci_read_config_dword(pd, PCI_ROM_ADDRESS, &ps->rom_address);
+		++ps;
+	}
+}
+
+/* For this to work, we must take care of a few things: If gmac was enabled
+ * during boot, it will be in the pci dev list. If it's disabled at this point
+ * (and it will probably be), then you can't access it's config space.
+ */
+static void pbook_pci_restore(void)
+{
+	u16 cmd;
+	struct pci_save *ps = pbook_pci_saves - 1;
+	struct pci_dev *pd = NULL;
+	int npci = pbook_npci_saves;
+	int j;
+
+	while ((pd = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
+		if (npci-- == 0)
+			return;
+		ps++;
+		if (ps->command == 0)
+			continue;
+		pci_read_config_word(pd, PCI_COMMAND, &cmd);
+		if ((ps->command & ~cmd) == 0)
+			continue;
+		switch (pd->hdr_type) {
+		case PCI_HEADER_TYPE_NORMAL:
+			for (j = 0; j < 6; ++j)
+				pci_write_config_dword(pd,
+						       PCI_BASE_ADDRESS_0 +
+						       j * 4,
+						       pd->resource[j].start);
+			pci_write_config_dword(pd, PCI_ROM_ADDRESS,
+					       ps->rom_address);
+			pci_write_config_word(pd, PCI_CACHE_LINE_SIZE,
+					      ps->cache_lat);
+			pci_write_config_word(pd, PCI_INTERRUPT_LINE, ps->intr);
+			pci_write_config_word(pd, PCI_COMMAND, ps->command);
+			break;
+		}
+	}
+}
+#endif
+
+static int
+powerbook_sleep_3400(void)
+{
+	int i, x;
+	unsigned int hid0;
+	unsigned long p;
+	struct adb_request sleep_req;
+	void __iomem *mem_ctrl;
+	unsigned int __iomem *mem_ctrl_sleep;
+
+	/* first map in the memory controller registers */
+	mem_ctrl = ioremap(PB3400_MEM_CTRL, 0x100);
+	if (mem_ctrl == NULL) {
+		printk("powerbook_sleep_3400: ioremap failed\n");
+		return -ENOMEM;
+	}
+	mem_ctrl_sleep = mem_ctrl + PB3400_MEM_CTRL_SLEEP;
+
+#ifdef PCI_SAVE
+	/* Allocate room for PCI save */
+	pbook_alloc_pci_save();
+
+	/* Save the state of PCI config space for some slots */
+	pbook_pci_save();
+#endif
+
+	/* Set the memory controller to keep the memory refreshed
+	   while we're asleep */
+	for (i = 0x403f; i >= 0x4000; --i) {
+		out_be32(mem_ctrl_sleep, i);
+		do {
+			x = (in_be32(mem_ctrl_sleep) >> 16) & 0x3ff;
+		} while (x == 0);
+		if (x >= 0x100)
+			break;
+	}
+
+	/* Ask the PMU to put us to sleep */
+	pmu_request(&sleep_req, NULL, 5, PMU_SLEEP, 'M', 'A', 'T', 'T');
+	while (!sleep_req.complete)
+		mb();
+
+	pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, 1);
+
+	/* displacement-flush the L2 cache - necessary? */
+	for (p = KERNELBASE; p < KERNELBASE + 0x100000; p += 0x1000)
+		i = *(volatile int *)p;
+
+	/* Put the CPU into sleep mode */
+	hid0 = mfspr(SPRN_HID0);
+	hid0 = (hid0 & ~(HID0_NAP | HID0_DOZE)) | HID0_SLEEP;
+	mtspr(SPRN_HID0, hid0);
+	mtmsr(mfmsr() | MSR_POW | MSR_EE);
+	udelay(10);
+
+	/* OK, we're awake again, start restoring things */
+	out_be32(mem_ctrl_sleep, 0x3f);
+	pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, 0);
+
+#ifdef PCI_SAVE
+	pbook_pci_restore();
+#endif
+
+	pmu_unlock();
+
+	/* wait for the PMU interrupt sequence to complete */
+	mdelay(10);
+
+#ifdef PCI_SAVE
+	pbook_free_pci_save();
+#endif
+	iounmap(mem_ctrl);
+
+	return 0;
+}
+
+#endif /* CONFIG_ADB_PMU && CONFIG_PPC32 */
+
+static int powermac_prepare_sleep(suspend_state_t state)
+{
+	/* Call platform functions marked "on sleep" */
+	pmac_pfunc_i2c_suspend();
+	pmac_pfunc_base_suspend();
+
+	preempt_disable();
+
+	return 0;
+}
+
+static int powermac_sleep(suspend_state_t state)
+{
+	int error = 0;
+
+	asm volatile("mtdec %0" : : "r" (0x7fffffff));
+	/* Make sure any pending DEC interrupt occurring while we did
+	 * the above didn't re-enable the DEC */
+	mb();
+	asm volatile("mtdec %0" : : "r" (0x7fffffff));
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
+	error = pmac_low_sleep_handler();
+
+	if (error)
+		return error;
+
+	mdelay(100);
+
+	/* Restart jiffies & scheduling */
+	wakeup_decrementer();
+
+	return 0;
+}
+
+static int powermac_finish_sleep(suspend_state_t state)
+{
+#ifdef CONFIG_PPC32
+	/* Restore userland MMU context */
+	set_context(current->active_mm->context.id, current->active_mm->pgd);
+#endif
+
+	preempt_enable();
+
+	/* Call platform functions marked "on wake" */
+	pmac_pfunc_base_resume();
+	pmac_pfunc_i2c_resume();
+
+	return 0;
+}
+
+static int powermac_sleep_valid(suspend_state_t state)
+{
+	return state == PM_SUSPEND_MEM && pmac_low_sleep_handler;
+}
+
+static struct pm_ops pmac_pm_ops = {
+	.prepare = powermac_prepare_sleep,
+	.finish = powermac_finish_sleep,
+	.enter = powermac_sleep,
+	.valid = powermac_sleep_valid,
+};
+
+static int __init register_pmac_pm_ops(void)
+{
+#if defined(CONFIG_ADB_PMU) && defined(CONFIG_PPC32)
+	switch (pmu_get_model()) {
+	case PMU_OHARE_BASED:
+		pmac_low_sleep_handler = powerbook_sleep_3400;
+		break;
+	case PMU_HEATHROW_BASED:
+	case PMU_PADDINGTON_BASED:
+		pmac_low_sleep_handler = powerbook_sleep_grackle;
+		break;
+	case PMU_KEYLARGO_BASED:
+		if (pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, -1) >= 0)
+			pmac_low_sleep_handler = powerbook_sleep_Core99;
+		break;
+	}
+#endif
+
+	pm_set_ops(&pmac_pm_ops);
+
+	return 0;
+}
+/* must be a late initcall to allow that pmac_call_feature to work */
+late_initcall(register_pmac_pm_ops);
--- linux-2.6.orig/drivers/macintosh/via-pmu.c	2007-03-21 08:18:35.996639252 +0100
+++ linux-2.6/drivers/macintosh/via-pmu.c	2007-03-21 08:21:27.666639252 +0100
@@ -14,9 +14,6 @@
  * THIS DRIVER IS BECOMING A TOTAL MESS !
  *  - Cleanup atomically disabling reply to PMU events after
  *    a sleep or a freq. switch
- *  - Move sleep code out of here to pmac_pm, merge into new
- *    common PM infrastructure
- *  - Save/Restore PCI space properly
  *
  */
 #include <stdarg.h>
@@ -43,9 +40,7 @@
 #include <linux/device.h>
 #include <linux/sysdev.h>
 #include <linux/freezer.h>
-#include <linux/syscalls.h>
 #include <linux/suspend.h>
-#include <linux/cpu.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
@@ -57,7 +52,6 @@
 #include <asm/pmac_pfunc.h>
 #include <asm/pmac_low_i2c.h>
 #include <asm/uaccess.h>
-#include <asm/mmu_context.h>
 #include <asm/cputable.h>
 #include <asm/time.h>
 #include <asm/backlight.h>
@@ -66,8 +60,6 @@
 
 /* Some compile options */
 #undef SUSPEND_USES_PMU
-#define DEBUG_SLEEP
-#undef HACKED_PCI_SAVE
 
 /* Misc minor number allocated for /dev/pmu */
 #define PMU_MINOR		154
@@ -172,8 +164,7 @@ static int query_batt_timer = BATTERY_PO
 static struct adb_request batt_req;
 static struct proc_dir_entry *proc_pmu_batt[PMU_MAX_BATTERIES];
 
-int __fake_sleep;
-int asleep;
+int pmu_sys_suspended;
 
 #ifdef CONFIG_ADB
 static int adb_dev_map;
@@ -214,15 +205,6 @@ struct adb_driver via_pmu_driver = {
 };
 #endif /* CONFIG_ADB */
 
-extern void low_sleep_handler(void);
-extern void enable_kernel_altivec(void);
-extern void enable_kernel_fp(void);
-
-#ifdef DEBUG_SLEEP
-int pmu_polled_request(struct adb_request *req);
-int pmu_wink(struct adb_request *req);
-#endif
-
 /*
  * This table indicates for each PMU opcode:
  * - the number of data bytes to be sent with the command, or -1
@@ -527,8 +509,10 @@ init_pmu(void)
 	int timeout;
 	struct adb_request req;
 
-	out_8(&via[B], via[B] | TREQ);			/* negate TREQ */
-	out_8(&via[DIRB], (via[DIRB] | TREQ) & ~TACK);	/* TACK in, TREQ out */
+	/* negate TREQ */
+	out_8(&via[B], in_8(&via[B]) | TREQ);
+	/* TACK in, TREQ out */
+	out_8(&via[DIRB], (in_8(&via[DIRB]) | TREQ) & ~TACK);
 
 	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, pmu_intr_mask);
 	timeout =  100000;
@@ -784,6 +768,8 @@ done_battery_state_smart(struct adb_requ
 static void
 query_battery_state(void)
 {
+	if (pmu_sys_suspended)
+		return;
 	if (test_and_set_bit(0, &async_req_locks))
 		return;
 	if (pmu_kind == PMU_OHARE_BASED)
@@ -1319,7 +1305,6 @@ pmu_handle_data(unsigned char *data, int
 	unsigned char ints, pirq;
 	int i = 0;
 
-	asleep = 0;
 	if (drop_interrupts || len < 1) {
 		adb_int_pending = 0;
 		pmu_irq_stats[8]++;
@@ -1432,8 +1417,8 @@ pmu_sr_intr(void)
 	struct adb_request *req;
 	int bite = 0;
 
-	if (via[B] & TREQ) {
-		printk(KERN_ERR "PMU: spurious SR intr (%x)\n", via[B]);
+	if (in_8(&via[B]) & TREQ) {
+		printk(KERN_ERR "PMU: spurious SR intr (%x)\n", in_8(&via[B]));
 		out_8(&via[IFR], SR_INT);
 		return NULL;
 	}
@@ -1730,175 +1715,10 @@ pmu_present(void)
 }
 
 #if defined(CONFIG_PM) && defined(CONFIG_PPC32)
-/*
- * This struct is used to store config register values for
- * PCI devices which may get powered off when we sleep.
- */
-static struct pci_save {
-#ifndef HACKED_PCI_SAVE
-	u16	command;
-	u16	cache_lat;
-	u16	intr;
-	u32	rom_address;
-#else
-	u32	config[16];
-#endif	
-} *pbook_pci_saves;
-static int pbook_npci_saves;
-
-static void
-pbook_alloc_pci_save(void)
-{
-	int npci;
-	struct pci_dev *pd = NULL;
-
-	npci = 0;
-	while ((pd = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
-		++npci;
-	}
-	if (npci == 0)
-		return;
-	pbook_pci_saves = (struct pci_save *)
-		kmalloc(npci * sizeof(struct pci_save), GFP_KERNEL);
-	pbook_npci_saves = npci;
-}
-
-static void
-pbook_free_pci_save(void)
-{
-	if (pbook_pci_saves == NULL)
-		return;
-	kfree(pbook_pci_saves);
-	pbook_pci_saves = NULL;
-	pbook_npci_saves = 0;
-}
-
-static void
-pbook_pci_save(void)
-{
-	struct pci_save *ps = pbook_pci_saves;
-	struct pci_dev *pd = NULL;
-	int npci = pbook_npci_saves;
-	
-	if (ps == NULL)
-		return;
-
-	while ((pd = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
-		if (npci-- == 0) {
-			pci_dev_put(pd);
-			return;
-		}
-#ifndef HACKED_PCI_SAVE
-		pci_read_config_word(pd, PCI_COMMAND, &ps->command);
-		pci_read_config_word(pd, PCI_CACHE_LINE_SIZE, &ps->cache_lat);
-		pci_read_config_word(pd, PCI_INTERRUPT_LINE, &ps->intr);
-		pci_read_config_dword(pd, PCI_ROM_ADDRESS, &ps->rom_address);
-#else
-		int i;
-		for (i=1;i<16;i++)
-			pci_read_config_dword(pd, i<<4, &ps->config[i]);
-#endif
-		++ps;
-	}
-}
-
-/* For this to work, we must take care of a few things: If gmac was enabled
- * during boot, it will be in the pci dev list. If it's disabled at this point
- * (and it will probably be), then you can't access it's config space.
- */
-static void
-pbook_pci_restore(void)
-{
-	u16 cmd;
-	struct pci_save *ps = pbook_pci_saves - 1;
-	struct pci_dev *pd = NULL;
-	int npci = pbook_npci_saves;
-	int j;
-
-	while ((pd = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
-#ifdef HACKED_PCI_SAVE
-		int i;
-		if (npci-- == 0) {
-			pci_dev_put(pd);
-			return;
-		}
-		ps++;
-		for (i=2;i<16;i++)
-			pci_write_config_dword(pd, i<<4, ps->config[i]);
-		pci_write_config_dword(pd, 4, ps->config[1]);
-#else
-		if (npci-- == 0)
-			return;
-		ps++;
-		if (ps->command == 0)
-			continue;
-		pci_read_config_word(pd, PCI_COMMAND, &cmd);
-		if ((ps->command & ~cmd) == 0)
-			continue;
-		switch (pd->hdr_type) {
-		case PCI_HEADER_TYPE_NORMAL:
-			for (j = 0; j < 6; ++j)
-				pci_write_config_dword(pd,
-					PCI_BASE_ADDRESS_0 + j*4,
-					pd->resource[j].start);
-			pci_write_config_dword(pd, PCI_ROM_ADDRESS,
-				ps->rom_address);
-			pci_write_config_word(pd, PCI_CACHE_LINE_SIZE,
-				ps->cache_lat);
-			pci_write_config_word(pd, PCI_INTERRUPT_LINE,
-				ps->intr);
-			pci_write_config_word(pd, PCI_COMMAND, ps->command);
-			break;
-		}
-#endif	
-	}
-}
-
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
-
-/*
- * Put the powerbook to sleep.
- */
- 
 static u32 save_via[8];
 
-static void
-save_via_state(void)
+void
+pmu_save_via_state(void)
 {
 	save_via[0] = in_8(&via[ANH]);
 	save_via[1] = in_8(&via[DIRA]);
@@ -1909,8 +1729,9 @@ save_via_state(void)
 	save_via[6] = in_8(&via[T1CL]);
 	save_via[7] = in_8(&via[T1CH]);
 }
-static void
-restore_via_state(void)
+
+void
+pmu_restore_via_state(void)
 {
 	out_8(&via[ANH], save_via[0]);
 	out_8(&via[DIRA], save_via[1]);
@@ -1924,249 +1745,6 @@ restore_via_state(void)
 	out_8(&via[IFR], 0x7f);				/* clear IFR */
 	out_8(&via[IER], IER_SET | SR_INT | CB1_INT);
 }
-
-extern void pmu_backlight_set_sleep(int sleep);
-
-#define	GRACKLE_PM	(1<<7)
-#define GRACKLE_DOZE	(1<<5)
-#define	GRACKLE_NAP	(1<<4)
-#define	GRACKLE_SLEEP	(1<<3)
-
-static int powerbook_sleep_grackle(void)
-{
-	unsigned long save_l2cr;
-	unsigned short pmcr1;
-	struct adb_request req;
-	struct pci_dev *grackle;
-
-	grackle = pci_find_slot(0, 0);
-	if (!grackle)
-		return -ENODEV;
-
-	/* Turn off various things. Darwin does some retry tests here... */
-	pmu_request(&req, NULL, 2, PMU_POWER_CTRL0, PMU_POW0_OFF|PMU_POW0_HARD_DRIVE);
-	pmu_wait_complete(&req);
-	pmu_request(&req, NULL, 2, PMU_POWER_CTRL,
-		PMU_POW_OFF|PMU_POW_BACKLIGHT|PMU_POW_IRLED|PMU_POW_MEDIABAY);
-	pmu_wait_complete(&req);
-
-	/* For 750, save backside cache setting and disable it */
-	save_l2cr = _get_L2CR();	/* (returns -1 if not available) */
-
-	if (!__fake_sleep) {
-		/* Ask the PMU to put us to sleep */
-		pmu_request(&req, NULL, 5, PMU_SLEEP, 'M', 'A', 'T', 'T');
-		pmu_wait_complete(&req);
-	}
-
-	/* The VIA is supposed not to be restored correctly*/
-	save_via_state();
-	/* We shut down some HW */
-	pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,1);
-
-	pci_read_config_word(grackle, 0x70, &pmcr1);
-	/* Apparently, MacOS uses NAP mode for Grackle ??? */
-	pmcr1 &= ~(GRACKLE_DOZE|GRACKLE_SLEEP); 
-	pmcr1 |= GRACKLE_PM|GRACKLE_NAP;
-	pci_write_config_word(grackle, 0x70, pmcr1);
-
-	/* Call low-level ASM sleep handler */
-	if (__fake_sleep)
-		mdelay(5000);
-	else
-		low_sleep_handler();
-
-	/* We're awake again, stop grackle PM */
-	pci_read_config_word(grackle, 0x70, &pmcr1);
-	pmcr1 &= ~(GRACKLE_PM|GRACKLE_DOZE|GRACKLE_SLEEP|GRACKLE_NAP); 
-	pci_write_config_word(grackle, 0x70, pmcr1);
-
-	/* Make sure the PMU is idle */
-	pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,0);
-	restore_via_state();
-	
-	/* Restore L2 cache */
-	if (save_l2cr != 0xffffffff && (save_l2cr & L2CR_L2E) != 0)
- 		_set_L2CR(save_l2cr);
-	
-	/* Restore userland MMU context */
-	set_context(current->active_mm->context.id, current->active_mm->pgd);
-
-	/* Power things up */
-	pmu_unlock();
-	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, pmu_intr_mask);
-	pmu_wait_complete(&req);
-	pmu_request(&req, NULL, 2, PMU_POWER_CTRL0,
-			PMU_POW0_ON|PMU_POW0_HARD_DRIVE);
-	pmu_wait_complete(&req);
-	pmu_request(&req, NULL, 2, PMU_POWER_CTRL,
-			PMU_POW_ON|PMU_POW_BACKLIGHT|PMU_POW_CHARGER|PMU_POW_IRLED|PMU_POW_MEDIABAY);
-	pmu_wait_complete(&req);
-
-	return 0;
-}
-
-static int
-powerbook_sleep_Core99(void)
-{
-	unsigned long save_l2cr;
-	unsigned long save_l3cr;
-	struct adb_request req;
-	
-	if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) < 0) {
-		printk(KERN_ERR "Sleep mode not supported on this machine\n");
-		return -ENOSYS;
-	}
-
-	if (num_online_cpus() > 1 || cpu_is_offline(0))
-		return -EAGAIN;
-
-	/* Stop environment and ADB interrupts */
-	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, 0);
-	pmu_wait_complete(&req);
-
-	/* Tell PMU what events will wake us up */
-	pmu_request(&req, NULL, 4, PMU_POWER_EVENTS, PMU_PWR_CLR_WAKEUP_EVENTS,
-		0xff, 0xff);
-	pmu_wait_complete(&req);
-	pmu_request(&req, NULL, 4, PMU_POWER_EVENTS, PMU_PWR_SET_WAKEUP_EVENTS,
-		0, PMU_PWR_WAKEUP_KEY |
-		(option_lid_wakeup ? PMU_PWR_WAKEUP_LID_OPEN : 0));
-	pmu_wait_complete(&req);
-
-	/* Save the state of the L2 and L3 caches */
-	save_l3cr = _get_L3CR();	/* (returns -1 if not available) */
-	save_l2cr = _get_L2CR();	/* (returns -1 if not available) */
-
-	if (!__fake_sleep) {
-		/* Ask the PMU to put us to sleep */
-		pmu_request(&req, NULL, 5, PMU_SLEEP, 'M', 'A', 'T', 'T');
-		pmu_wait_complete(&req);
-	}
-
-	/* The VIA is supposed not to be restored correctly*/
-	save_via_state();
-
-	/* Shut down various ASICs. There's a chance that we can no longer
-	 * talk to the PMU after this, so I moved it to _after_ sending the
-	 * sleep command to it. Still need to be checked.
-	 */
-	pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, 1);
-
-	/* Call low-level ASM sleep handler */
-	if (__fake_sleep)
-		mdelay(5000);
-	else
-		low_sleep_handler();
-
-	/* Restore Apple core ASICs state */
-	pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, 0);
-
-	/* Restore VIA */
-	restore_via_state();
-
-	/* tweak LPJ before cpufreq is there */
-	loops_per_jiffy *= 2;
-
-	/* Restore video */
-	pmac_call_early_video_resume();
-
-	/* Restore L2 cache */
-	if (save_l2cr != 0xffffffff && (save_l2cr & L2CR_L2E) != 0)
- 		_set_L2CR(save_l2cr);
-	/* Restore L3 cache */
-	if (save_l3cr != 0xffffffff && (save_l3cr & L3CR_L3E) != 0)
- 		_set_L3CR(save_l3cr);
-	
-	/* Restore userland MMU context */
-	set_context(current->active_mm->context.id, current->active_mm->pgd);
-
-	/* Tell PMU we are ready */
-	pmu_unlock();
-	pmu_request(&req, NULL, 2, PMU_SYSTEM_READY, 2);
-	pmu_wait_complete(&req);
-	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, pmu_intr_mask);
-	pmu_wait_complete(&req);
-
-	/* Restore LPJ, cpufreq will adjust the cpu frequency */
-	loops_per_jiffy /= 2;
-
-	return 0;
-}
-
-#define PB3400_MEM_CTRL		0xf8000000
-#define PB3400_MEM_CTRL_SLEEP	0x70
-
-static int
-powerbook_sleep_3400(void)
-{
-	int i, x;
-	unsigned int hid0;
-	unsigned long p;
-	struct adb_request sleep_req;
-	void __iomem *mem_ctrl;
-	unsigned int __iomem *mem_ctrl_sleep;
-
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
-	/* Save the state of PCI config space for some slots */
-	pbook_pci_save();
-
-	/* Set the memory controller to keep the memory refreshed
-	   while we're asleep */
-	for (i = 0x403f; i >= 0x4000; --i) {
-		out_be32(mem_ctrl_sleep, i);
-		do {
-			x = (in_be32(mem_ctrl_sleep) >> 16) & 0x3ff;
-		} while (x == 0);
-		if (x >= 0x100)
-			break;
-	}
-
-	/* Ask the PMU to put us to sleep */
-	pmu_request(&sleep_req, NULL, 5, PMU_SLEEP, 'M', 'A', 'T', 'T');
-	while (!sleep_req.complete)
-		mb();
-
-	pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,1);
-
-	/* displacement-flush the L2 cache - necessary? */
-	for (p = KERNELBASE; p < KERNELBASE + 0x100000; p += 0x1000)
-		i = *(volatile int *)p;
-	asleep = 1;
-
-	/* Put the CPU into sleep mode */
-	hid0 = mfspr(SPRN_HID0);
-	hid0 = (hid0 & ~(HID0_NAP | HID0_DOZE)) | HID0_SLEEP;
-	mtspr(SPRN_HID0, hid0);
-	mtmsr(mfmsr() | MSR_POW | MSR_EE);
-	udelay(10);
-
-	/* OK, we're awake again, start restoring things */
-	out_be32(mem_ctrl_sleep, 0x3f);
-	pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,0);
-	pbook_pci_restore();
-	pmu_unlock();
-
-	/* wait for the PMU interrupt sequence to complete */
-	while (asleep)
-		mb();
-
-	pbook_free_pci_save();
-	iounmap(mem_ctrl);
-
-	return 0;
-}
-
 #endif /* CONFIG_PM && CONFIG_PPC32 */
 
 /*
@@ -2342,116 +1920,6 @@ pmu_release(struct inode *inode, struct 
 	return 0;
 }
 
-#if defined(CONFIG_PM) && defined(CONFIG_PPC32)
-static int powerbook_prepare_sleep(suspend_state_t state)
-{
-#ifdef CONFIG_PMAC_BACKLIGHT
-	/* Tell backlight code not to muck around with the chip anymore */
-	pmu_backlight_set_sleep(1);
-#endif
-
-	/* Call platform functions marked "on sleep" */
-	pmac_pfunc_i2c_suspend();
-	pmac_pfunc_base_suspend();
-
-	preempt_disable();
-
-	return 0;
-}
-
-static int powerbook_sleep(suspend_state_t state)
-{
-	int error = 0;
-
-	asm volatile("mtdec %0" : : "r" (0x7fffffff));
-	/* Make sure any pending DEC interrupt occurring while we did
-	 * the above didn't re-enable the DEC */
-	mb();
-	asm volatile("mtdec %0" : : "r" (0x7fffffff));
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
-	switch (pmu_kind) {
-	case PMU_OHARE_BASED:
-		error = powerbook_sleep_3400();
-		break;
-	case PMU_HEATHROW_BASED:
-	case PMU_PADDINGTON_BASED:
-		error = powerbook_sleep_grackle();
-		break;
-	case PMU_KEYLARGO_BASED:
-		error = powerbook_sleep_Core99();
-		break;
-	default:
-		return -ENOSYS;
-	}
-
-	if (error)
-		return error;
-
-	mdelay(100);
-
-	/* Force a poll of ADB interrupts */
-	adb_int_pending = 1;
-	via_pmu_interrupt(0, NULL);
-
-	/* Restart jiffies & scheduling */
-	wakeup_decrementer();
-
-	return 0;
-}
-
-static int powerbook_finish_sleep(suspend_state_t state)
-{
-#ifdef CONFIG_PMAC_BACKLIGHT
-	/* Tell backlight code it can use the chip again */
-	pmu_backlight_set_sleep(0);
-#endif
-
-	preempt_enable();
-
-	/* Call platform functions marked "on wake" */
-	pmac_pfunc_base_resume();
-	pmac_pfunc_i2c_resume();
-
-	return 0;
-}
-
-static int pmu_sleep_valid(suspend_state_t state)
-{
-	return state == PM_SUSPEND_MEM
-		&& (pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, -1) >= 0);
-}
-
-static struct pm_ops pmu_pm_ops = {
-	.prepare = powerbook_prepare_sleep,
-	.finish = powerbook_finish_sleep,
-	.enter = powerbook_sleep,
-	.valid = pmu_sleep_valid,
-};
-
-static int register_pmu_pm_ops(void)
-{
-	pm_set_ops(&pmu_pm_ops);
-
-	return 0;
-}
-
-device_initcall(register_pmu_pm_ops);
-#endif
-
 static int
 pmu_ioctl(struct inode * inode, struct file *filp,
 		     u_int cmd, u_long arg)
@@ -2549,98 +2017,28 @@ static int pmu_device_init(void)
 }
 device_initcall(pmu_device_init);
 
-
-#ifdef DEBUG_SLEEP
-static inline void 
-polled_handshake(volatile unsigned char __iomem *via)
-{
-	via[B] &= ~TREQ; eieio();
-	while ((via[B] & TACK) != 0)
-		;
-	via[B] |= TREQ; eieio();
-	while ((via[B] & TACK) == 0)
-		;
-}
-
-static inline void 
-polled_send_byte(volatile unsigned char __iomem *via, int x)
-{
-	via[ACR] |= SR_OUT | SR_EXT; eieio();
-	via[SR] = x; eieio();
-	polled_handshake(via);
-}
-
-static inline int
-polled_recv_byte(volatile unsigned char __iomem *via)
-{
-	int x;
-
-	via[ACR] = (via[ACR] & ~SR_OUT) | SR_EXT; eieio();
-	x = via[SR]; eieio();
-	polled_handshake(via);
-	x = via[SR]; eieio();
-	return x;
-}
-
-int
-pmu_polled_request(struct adb_request *req)
-{
-	unsigned long flags;
-	int i, l, c;
-	volatile unsigned char __iomem *v = via;
-
-	req->complete = 1;
-	c = req->data[0];
-	l = pmu_data_len[c][0];
-	if (l >= 0 && req->nbytes != l + 1)
-		return -EINVAL;
-
-	local_irq_save(flags);
-	while (pmu_state != idle)
-		pmu_poll();
-
-	while ((via[B] & TACK) == 0)
-		;
-	polled_send_byte(v, c);
-	if (l < 0) {
-		l = req->nbytes - 1;
-		polled_send_byte(v, l);
-	}
-	for (i = 1; i <= l; ++i)
-		polled_send_byte(v, req->data[i]);
-
-	l = pmu_data_len[c][1];
-	if (l < 0)
-		l = polled_recv_byte(v);
-	for (i = 0; i < l; ++i)
-		req->reply[i + req->reply_len] = polled_recv_byte(v);
-
-	if (req->done)
-		(*req->done)(req);
-
-	local_irq_restore(flags);
-	return 0;
-}
-#endif /* DEBUG_SLEEP */
-
-
-/* FIXME: This is a temporary set of callbacks to enable us
- * to do suspend-to-disk.
- */
-
 #if defined(CONFIG_PM) && defined(CONFIG_PPC32)
-
-int pmu_sys_suspended;
-
 static int pmu_sys_suspend(struct sys_device *sysdev, pm_message_t state)
 {
-	if (state.event != PM_EVENT_SUSPEND || pmu_sys_suspended)
+	struct adb_request req;
+
+	if (pmu_sys_suspended)
 		return 0;
 
+	/* Stop environment interrupts */
+	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, 0);
+	pmu_wait_complete(&req);
+
 	/* Suspend PMU event interrupts */
 	pmu_suspend();
 
+	/* Mark driver suspended */
 	pmu_sys_suspended = 1;
+
+	/* Wait for completion of async battery requests */
+	while (!batt_req.complete)
+		pmu_poll();
+
 	return 0;
 }
 
@@ -2651,6 +2049,10 @@ static int pmu_sys_resume(struct sys_dev
 	if (!pmu_sys_suspended)
 		return 0;
 
+	/* Restart environment interrupts */
+	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, pmu_intr_mask);
+	pmu_wait_complete(&req);
+
 	/* Tell PMU we are ready */
 	pmu_request(&req, NULL, 2, PMU_SYSTEM_READY, 2);
 	pmu_wait_complete(&req);
@@ -2658,6 +2060,7 @@ static int pmu_sys_resume(struct sys_dev
 	/* Resume PMU event interrupts */
 	pmu_resume();
 
+	/* Mark driver ready for async requests */
 	pmu_sys_suspended = 0;
 
 	return 0;
@@ -2713,9 +2116,7 @@ EXPORT_SYMBOL(pmu_suspend);
 EXPORT_SYMBOL(pmu_resume);
 EXPORT_SYMBOL(pmu_unlock);
 #if defined(CONFIG_PM) && defined(CONFIG_PPC32)
-EXPORT_SYMBOL(pmu_enable_irled);
 EXPORT_SYMBOL(pmu_battery_count);
 EXPORT_SYMBOL(pmu_batteries);
 EXPORT_SYMBOL(pmu_power_flags);
 #endif /* CONFIG_PM && CONFIG_PPC32 */
-
--- linux-2.6.orig/arch/powerpc/platforms/powermac/Makefile	2007-03-21 08:18:35.966639252 +0100
+++ linux-2.6/arch/powerpc/platforms/powermac/Makefile	2007-03-21 08:21:27.666639252 +0100
@@ -12,3 +12,4 @@ obj-$(CONFIG_PPC64)		+= nvram.o
 obj-$(CONFIG_PPC32)		+= bootx_init.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_PPC_MERGE)		+= udbg_scc.o udbg_adb.o
+obj-$(CONFIG_PM)		+= pm.o
--- linux-2.6.orig/drivers/macintosh/via-pmu-backlight.c	2007-03-21 08:18:36.066639252 +0100
+++ linux-2.6/drivers/macintosh/via-pmu-backlight.c	2007-03-21 08:21:27.676639252 +0100
@@ -17,7 +17,6 @@
 
 static struct backlight_ops pmu_backlight_data;
 static DEFINE_SPINLOCK(pmu_backlight_lock);
-static int sleeping;
 static u8 bl_curve[FB_BACKLIGHT_LEVELS];
 
 static void pmu_backlight_init_curve(u8 off, u8 min, u8 max)
@@ -77,7 +76,7 @@ static int pmu_backlight_update_status(s
 	spin_lock_irqsave(&pmu_backlight_lock, flags);
 
 	/* Don't update brightness when sleeping */
-	if (sleeping)
+	if (pmu_sys_suspended)
 		goto out;
 
 	if (bd->props.power != FB_BLANK_UNBLANK ||
@@ -116,17 +115,6 @@ static struct backlight_ops pmu_backligh
 
 };
 
-#ifdef CONFIG_PM
-void pmu_backlight_set_sleep(int sleep)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&pmu_backlight_lock, flags);
-	sleeping = sleep;
-	spin_unlock_irqrestore(&pmu_backlight_lock, flags);
-}
-#endif /* CONFIG_PM */
-
 void __init pmu_backlight_init()
 {
 	struct backlight_device *bd;
--- linux-2.6.orig/include/linux/pmu.h	2007-03-21 08:18:36.386639252 +0100
+++ linux-2.6/include/linux/pmu.h	2007-03-21 08:21:27.676639252 +0100
@@ -150,6 +150,9 @@ extern void pmu_wait_complete(struct adb
 extern void pmu_suspend(void);
 extern void pmu_resume(void);
 
+extern void pmu_save_via_state(void);
+extern void pmu_restore_via_state(void);
+
 extern void pmu_enable_irled(int on);
 
 extern void pmu_restart(void);
@@ -183,8 +186,13 @@ struct pmu_battery_info
 };
 
 extern int pmu_battery_count;
+extern int pmu_cur_battery;
 extern struct pmu_battery_info pmu_batteries[PMU_MAX_BATTERIES];
 extern unsigned int pmu_power_flags;
+extern int pmu_sys_suspended;
+
+/* adb driver */
+extern struct adb_driver via_pmu_driver;
 
 /* Backlight */
 extern void pmu_backlight_init(void);
--- linux-2.6.orig/drivers/macintosh/via-pmu-led.c	2007-03-21 08:18:36.256639252 +0100
+++ linux-2.6/drivers/macintosh/via-pmu-led.c	2007-03-21 08:21:27.676639252 +0100
@@ -32,8 +32,6 @@ static struct adb_request pmu_blink_req;
 /* -1: no change, 0: request off, 1: request on */
 static int requested_change;
 
-extern int pmu_sys_suspended;
-
 static void pmu_req_done(struct adb_request * req)
 {
 	unsigned long flags;
