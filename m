Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1A95667B52
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 09:22:48 +1000 (EST)
Message-ID: <42A0E640.4020304@am.sony.com>
Date: Fri, 03 Jun 2005 16:22:40 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] [1/2] PM support for Ebony
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I rebased this to apply to Benjamin's ppc32-rework-pm.diff, but 
didn't recode it to take advantage of the extra hooks.  More work 
is certainly needed for wake-on-lan.  Any comments on improvement 
would be most welcome.

I could also make one available against a 2.6.12-rc if requested.

-Geoff

* pm-on-ebony.patch 

This patch provides power management support for the IBM PPC440GP Ebony 
Reference Platform.  The main portion of the patch implements the platform 
specific pm_ops structure required by the kernel power management sub-system.  
The current implementation only supports suspend-to-memory (PM_SUSPEND_MEM), 
though unpublished suspend-to-disk work has been started.

This implementation arranges for the U44 switch on the Ebony platform, 
connected to the SMI interrupt handler, to be used as a system resume trigger.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com> for CELF

--
Index: linux-2.6.12-bhpm/arch/ppc/platforms/4xx/Kconfig
===================================================================
--- linux-2.6.12-bhpm.orig/arch/ppc/platforms/4xx/Kconfig	2005-06-03 16:14:44.000000000 -0700
+++ linux-2.6.12-bhpm/arch/ppc/platforms/4xx/Kconfig	2005-06-03 16:15:07.000000000 -0700
@@ -214,10 +214,6 @@
 	depends on 4xx
 	default y
 
-config PM
-	bool "Power Management support (EXPERIMENTAL)"
-	depends on 4xx && EXPERIMENTAL
-
 choice
 	prompt "TTYS0 device and default console"
 	depends on 40x
Index: linux-2.6.12-bhpm/arch/ppc/platforms/4xx/Makefile
===================================================================
--- linux-2.6.12-bhpm.orig/arch/ppc/platforms/4xx/Makefile	2005-06-03 16:14:44.000000000 -0700
+++ linux-2.6.12-bhpm/arch/ppc/platforms/4xx/Makefile	2005-06-03 16:15:07.000000000 -0700
@@ -25,3 +25,6 @@
 obj-$(CONFIG_405EP)		+= ibm405ep.o
 obj-$(CONFIG_405GPR)		+= ibm405gpr.o
 obj-$(CONFIG_VIRTEX_II_PRO)	+= virtex-ii_pro.o
+ifeq ($(CONFIG_PM),y)
+obj-$(CONFIG_EBONY)		+= ebony_pm.o ibm440gp_sleep.o
+endif
Index: linux-2.6.12-bhpm/arch/ppc/platforms/4xx/ebony_pm.c
===================================================================
--- linux-2.6.12-bhpm.orig/arch/ppc/platforms/4xx/ebony_pm.c	2005-06-01 08:52:49.947684744 -0700
+++ linux-2.6.12-bhpm/arch/ppc/platforms/4xx/ebony_pm.c	2005-06-03 16:15:07.000000000 -0700
@@ -0,0 +1,202 @@
+/*
+ * ebony_pm.c - This file contains the PM functions for Ebony.
+ *
+ *  Copyright 2004 Sony Corp.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/types.h>
+#include <linux/suspend.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <asm/ibm44x.h>
+
+#define IBM_CPM_ALL        (IBM_CPM_IIC0 | IBM_CPM_IIC1 | IBM_CPM_PCI | \
+                       IBM_CPM_CPU | IBM_CPM_DMA | IBM_CPM_BGO | IBM_CPM_BGI |  \
+                       IBM_CPM_EBC | IBM_CPM_EBM | IBM_CPM_DMC | IBM_CPM_PLB | IBM_CPM_SRAM  | \
+                       IBM_CPM_PPM | IBM_CPM_UIC1 | IBM_CPM_GPIO0 | IBM_CPM_UART0 | IBM_CPM_UART1 | \
+                       IBM_CPM_UIC0 | IBM_CPM_TMRCLK )
+
+#define UIC0_EIR5_BIT (1<<(31-28))	/* External Intr 5  == SMI */
+#define UIC0_UIC1NC_BIT (1<<(31-30))	
+
+extern void serial8250_suspend_port_busy(int line);
+extern void serial8250_resume_port_busy(int line);
+
+void ibm440gp_sleep(__u32 CPM, __u32 MSR_OR);
+
+#define DEBUG
+
+#ifdef	DEBUG
+
+/* #define  USE_ETHER_TO_RESUME */
+
+static int __tm_printk(const char *fmt, ...)
+{
+        char buf[512];
+        va_list args;
+        int i;
+        unsigned long long tt;
+        unsigned long us, ms;
+
+        tt = sched_clock();
+        ms = tt >> 10;  /* convert to usec */
+        us = ms % 1000;
+        ms = ms / 1000;
+
+        i = sprintf(buf, "%6.6lu.%3.3lums:", ms,us);
+        va_start(args, fmt);
+        i = vsnprintf(buf+i, sizeof(buf)-i, fmt, args);
+        va_end(args);
+        printk(buf);
+
+        return i;
+}
+
+#endif /* DEBUG */
+
+
+/*
+ * PM ops for EBONY board.
+ */
+
+static int ebony_pm_enter(suspend_state_t state)
+{
+	__u32 uic_save_er;
+	__u32 save_msr;
+	__u32 cpm_save_er;
+	__u32 cpm_er;
+
+	if (state != PM_SUSPEND_MEM)
+		return -EINVAL;
+
+	/*  Save MSR and Stop all interrupts */
+	save_msr = mfmsr();
+	_nmask_and_or_msr((MSR_CE|MSR_EE), 0);
+
+	/* save current CPM */
+	cpm_save_er = mfdcr(DCRN_CPC0_ER);
+
+	/* save UIC0 enable registers */
+	uic_save_er = mfdcr(DCRN_UIC_ER(UIC0));
+
+#ifdef USE_ETHER_TO_RESUME
+	mtdcr(DCRN_UIC_ER(UIC0), UIC0_EIR5_BIT|UIC0_UIC1NC_BIT);
+#else
+	/* mask UIC0 interrupts, except External Intr #5 */
+	mtdcr(DCRN_UIC_ER(UIC0), UIC0_EIR5_BIT);
+#endif
+
+#ifdef	DEBUG
+	__tm_printk("UIC0_ER:0x%8.8x -> 0x%8.8x\n",uic_save_er, mfdcr(DCRN_UIC_ER(UIC0)));
+#endif
+
+	/* set up CPM */
+	cpm_er = IBM_CPM_ALL & ~IBM_CPM_UIC0;
+#ifdef USE_ETHER_TO_RESUME
+	cpm_er &= ~CPM_UIC1;
+#endif
+
+#ifdef	DEBUG
+	__tm_printk("UIC0_SR:0x%8.8x\n", mfdcr(DCRN_UIC_SR(UIC0)));
+	__tm_printk("CPM_ER:0x%8.8x\n", cpm_er);
+	__tm_printk("SLEEP\n");
+#endif
+
+	/* we need this to work with printk on serial console */
+	serial8250_suspend_port_busy(0);
+
+	/* Enable interrupts and Enter SLEEP mode */
+	ibm440gp_sleep(cpm_er, (MSR_EE|MSR_WE));
+
+	/*  Stop all interrupts, again */
+	_nmask_and_or_msr((MSR_CE|MSR_EE), 0);
+
+	/* Restore CPM, before resume serials for printk() */
+	mtdcr(DCRN_CPC0_ER, cpm_save_er);
+
+	/* we need this to work with printk on serial console */
+	serial8250_resume_port_busy(0);
+
+	__tm_printk("WAKEUP\n");
+
+	/* Restore UIC0 enable registers */
+	mtdcr(DCRN_UIC_ER(UIC0), uic_save_er);
+
+	/* Restore MSR */
+	mtmsr(save_msr);
+
+	return 0;
+}
+
+static int ebony_pm_prepare(suspend_state_t state)
+{
+
+	if (state != PM_SUSPEND_MEM)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ebony_pm_finish(suspend_state_t state)
+{
+	return 0;
+}
+
+static struct pm_ops ebony_pm_ops = {
+	.pm_disk_mode	= PM_DISK_FIRMWARE,
+	.prepare	= ebony_pm_prepare,
+	.enter		= ebony_pm_enter,
+	.finish		= ebony_pm_finish,
+};
+
+static int __init ebony_pm_init(void)
+{
+	pm_set_ops(&ebony_pm_ops);
+	return 0;
+}
+
+late_initcall(ebony_pm_init);
+
+/*
+ * SMI handler for resume
+ */
+
+#define PPC440GP_EXT_INT5_INTR	28	/* SMI: See ebony.c */
+
+static irqreturn_t 
+smi_handler(int cpl, void *dev_id, struct pt_regs *regs)
+{
+#ifdef	DEBUG
+	printk("SMI INTR\n");
+#endif
+	return IRQ_HANDLED;
+}
+
+static int __init  init_smi(void)
+{
+	/* Enable SMI interrupt */
+	if (request_irq(PPC440GP_EXT_INT5_INTR, smi_handler, 
+				SA_INTERRUPT, "SMI", NULL)) {
+		printk(KERN_ERR "SMI: cannot register IRQ:%d\n", PPC440GP_EXT_INT5_INTR);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+late_initcall(init_smi);
+
+
Index: linux-2.6.12-bhpm/arch/ppc/platforms/4xx/ibm440gp_sleep.S
===================================================================
--- linux-2.6.12-bhpm.orig/arch/ppc/platforms/4xx/ibm440gp_sleep.S	2005-06-01 08:52:49.947684744 -0700
+++ linux-2.6.12-bhpm/arch/ppc/platforms/4xx/ibm440gp_sleep.S	2005-06-03 16:15:07.000000000 -0700
@@ -0,0 +1,44 @@
+/*
+ * ibm440gp_sleep.S - This file contains the sleep function for 440GP CPU.
+ *
+ *  Copyright 2004 Sony Corp.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+
+#include <linux/config.h>
+#include <asm/processor.h>
+#include <asm/ppc_asm.h>
+
+
+	.text
+
+/*
+ * ibm440gp_sleep (CPC0_ER_VAL, MSR_OR_VAL)
+ * 	r3: new CPC0_ER value
+ * 	r4: MSR value to be OR
+ */
+_GLOBAL(ibm440gp_sleep)
+	mfmsr	r0
+	or	r0,r0,r4
+	sync
+	mtdcr	177,r3	// 177: DCRN_CPC0_ER
+	sync
+	mtmsr	r0
+	sync
+
+	blr
+
+
Index: linux-2.6.12-bhpm/include/asm-ppc/ocp.h
===================================================================
--- linux-2.6.12-bhpm.orig/include/asm-ppc/ocp.h	2005-06-03 16:14:44.000000000 -0700
+++ linux-2.6.12-bhpm/include/asm-ppc/ocp.h	2005-06-03 16:15:07.000000000 -0700
@@ -151,13 +151,21 @@
 static inline void
 ocp_force_power_off(struct ocp_device *odev)
 {
+#ifdef CONFIG_44x
+	mtdcr(DCRN_CPC0_FR, mfdcr(DCRN_CPC0_FR) | odev->def->pm);
+#else
 	mtdcr(DCRN_CPMFR, mfdcr(DCRN_CPMFR) | odev->def->pm);
+#endif
 }
 
 static inline void
 ocp_force_power_on(struct ocp_device *odev)
 {
+#ifdef CONFIG_44x
+	mtdcr(DCRN_CPC0_FR, mfdcr(DCRN_CPC0_FR) & ~odev->def->pm);
+#else
 	mtdcr(DCRN_CPMFR, mfdcr(DCRN_CPMFR) & ~odev->def->pm);
+#endif
 }
 #else
 #define ocp_force_power_off(x)	(void)(x)

-EOF
