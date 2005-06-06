Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E91DA679EF
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Jun 2005 04:06:04 +1000 (EST)
Message-ID: <42A49084.3070002@am.sony.com>
Date: Mon, 06 Jun 2005 11:05:56 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
References: <20050604005106.GB12513@gate.ebshome.net>
In-Reply-To: <20050604005106.GB12513@gate.ebshome.net>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] [1/2] PM support for Ebony
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eugene Surovegin wrote:
> On Fri, Jun 03, 2005 at 04:22:40PM -0700, Geoff Levand wrote:
> 
> [snip]
> 
> 
>>+	/* save current CPM */
>>+	cpm_save_er = mfdcr(DCRN_CPC0_ER);
>>+
>>+	/* save UIC0 enable registers */
>>+	uic_save_er = mfdcr(DCRN_UIC_ER(UIC0));
>>+
>>+#ifdef USE_ETHER_TO_RESUME
>>+	mtdcr(DCRN_UIC_ER(UIC0), UIC0_EIR5_BIT|UIC0_UIC1NC_BIT);
>>+#else
>>+	/* mask UIC0 interrupts, except External Intr #5 */
>>+	mtdcr(DCRN_UIC_ER(UIC0), UIC0_EIR5_BIT);
>>+#endif
> 
> 
> Why UIC PM code is here and not in ppc4xx_pic.c? I don't think this is 
> the right place to mess with UIC registers.
> 
> [snip]
> 
> 
>>===================================================================
>>--- linux-2.6.12-bhpm.orig/arch/ppc/platforms/4xx/ibm440gp_sleep.S
> 
> 2005-06-01 08:52:49.947684744 -0700
> 
>>+++ linux-2.6.12-bhpm/arch/ppc/platforms/4xx/ibm440gp_sleep.S
> 
> 2005-06-03 16:15:07.000000000 -0700
> 
> I think it should be in arch/ppc/syslib not in arch/ppc/platforms/4xx.
> 

Here's a cleaned-up version.  I moved ibm440gp_sleep.S into syslib 
and put a declaration in ibm440gp_common.h.  I also made two new 
pm suspend/resume routines in ppc4xx_pic.c.

I was thinking to add a static variable in ppc4xx_pic.c to hold the 
state, that way the arch pm code doesn't need to take care of it, 
which will make suspend to disk easier since the value will be 
saved in the system image.  I'm not sure which way to go.  Any 
comments?

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
--- linux-2.6.12-bhpm.orig/arch/ppc/platforms/4xx/Kconfig	2005-06-06 09:29:06.000000000 -0700
+++ linux-2.6.12-bhpm/arch/ppc/platforms/4xx/Kconfig	2005-06-06 09:32:24.000000000 -0700
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
--- linux-2.6.12-bhpm.orig/arch/ppc/platforms/4xx/Makefile	2005-06-06 09:29:06.000000000 -0700
+++ linux-2.6.12-bhpm/arch/ppc/platforms/4xx/Makefile	2005-06-06 09:32:24.000000000 -0700
@@ -25,3 +25,6 @@
 obj-$(CONFIG_405EP)		+= ibm405ep.o
 obj-$(CONFIG_405GPR)		+= ibm405gpr.o
 obj-$(CONFIG_VIRTEX_II_PRO)	+= virtex-ii_pro.o
+ifeq ($(CONFIG_PM),y)
+obj-$(CONFIG_EBONY)		+= ebony_pm.o
+endif
Index: linux-2.6.12-bhpm/arch/ppc/platforms/4xx/ebony_pm.c
===================================================================
--- linux-2.6.12-bhpm.orig/arch/ppc/platforms/4xx/ebony_pm.c	2005-06-01 08:52:49.947684744 -0700
+++ linux-2.6.12-bhpm/arch/ppc/platforms/4xx/ebony_pm.c	2005-06-06 10:42:42.000000000 -0700
@@ -0,0 +1,192 @@
+/*
+ * ebony_pm.c - This file contains the PM functions for Ebony.
+ *
+ *  Copyright 2004,2005 Sony Corp.
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
+#include <asm/ppc4xx_pic.h>
+
+#undef DEBUG
+#undef ENABLE_WAKE_ON_LAN
+
+#define IBM_CPM_ALL (IBM_CPM_IIC0 | IBM_CPM_IIC1 | IBM_CPM_PCI | IBM_CPM_CPU  \
+	| IBM_CPM_DMA | IBM_CPM_BGO | IBM_CPM_BGI | IBM_CPM_EBC | IBM_CPM_EBM \
+	| IBM_CPM_DMC | IBM_CPM_PLB | IBM_CPM_SRAM  |  IBM_CPM_PPM            \
+	| IBM_CPM_UIC1 | IBM_CPM_GPIO0 | IBM_CPM_UART0 | IBM_CPM_UART1        \
+	| IBM_CPM_UIC0 | IBM_CPM_TMRCLK)
+
+#define UIC0_EIR5_BIT (1<<(31-28)) /* External Intr 5  == SMI */
+#define UIC0_UIC1NC_BIT (1<<(31-30))
+
+#if defined(DEBUG)
+#define tm_printk(...) __tm_printk(__VA_ARGS__)
+static int 
+__tm_printk (const char *fmt, ...)
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
+static inline void 
+serial8250_suspend_port_busy (int line) {return;}
+static inline void 
+serial8250_resume_port_busy (int line) {return;}
+#else
+#define tm_printk(...) (void)(0)
+static inline void 
+serial8250_suspend_port_busy (int line) {return;}
+static inline void 
+serial8250_resume_port_busy (int line) {return;}
+#endif
+
+static int 
+ebony_pm_enter (suspend_state_t state)
+{
+	u32 pic_state;
+	u32 save_msr;
+	u32 cpm_save_er;
+	u32 cpm_er;
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
+#if !defined(ENABLE_WAKE_ON_LAN)
+	ppc4xx_pic_suspend(UIC0_EIR5_BIT, &pic_state);
+	
+	/* set up CPM */
+	cpm_er = IBM_CPM_ALL & ~IBM_CPM_UIC0;
+#else
+	ppc4xx_pic_suspend(UIC0_EIR5_BIT | UIC0_UIC1NC_BIT, &pic_state);
+	
+	/* set up CPM */
+	cpm_er = IBM_CPM_ALL & ~(IBM_CPM_UIC0 | CPM_UIC1);
+#endif
+
+	tm_printk("UIC0_ER: 0x%8.8x -> 0x%8.8x\n", pic_state, 
+		mfdcr(DCRN_UIC_ER(UIC0)));
+	tm_printk("UIC0_SR: 0x%8.8x\n", mfdcr(DCRN_UIC_SR(UIC0)));
+	tm_printk("CPM_ER: 0x%8.8x\n", cpm_er);
+	tm_printk("SLEEP\n");
+
+	/* for late printk on serial console */
+	serial8250_suspend_port_busy(0);
+
+	/* Enable interrupts and Enter SLEEP mode */
+	ibm440gp_sleep(cpm_er, (MSR_EE|MSR_WE));
+
+	/*  Stop all interrupts, again */
+	_nmask_and_or_msr((MSR_CE|MSR_EE), 0);
+
+	/* Restore CPM.  Need to do before resume serials */
+	mtdcr(DCRN_CPC0_ER, cpm_save_er);
+
+	/* for early printk on serial console */
+	serial8250_resume_port_busy(0);
+
+	tm_printk("WAKEUP\n");
+
+	ppc4xx_pic_resume(pic_state);
+
+	/* Restore MSR */
+	mtmsr(save_msr);
+
+	return 0;
+}
+
+static int 
+ebony_pm_prepare (suspend_state_t state)
+{
+	if (state != PM_SUSPEND_MEM)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int 
+ebony_pm_finish (suspend_state_t state)
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
+static int __init 
+ebony_pm_init (void)
+{
+	pm_set_ops(&ebony_pm_ops);
+	return 0;
+}
+
+late_initcall(ebony_pm_init);
+
+/*
+ * Use SMI handler for resume
+ */
+
+#define PPC440GP_EXT_INT5_INTR 28 /* See ebony.c */
+
+static irqreturn_t 
+smi_handler (int cpl, void *dev_id, struct pt_regs *regs)
+{
+	tm_printk("SMI INTR\n");
+	return IRQ_HANDLED;
+}
+
+static int __init 
+init_smi (void)
+{
+	if (request_irq(PPC440GP_EXT_INT5_INTR, smi_handler, SA_INTERRUPT, 
+		"SMI", NULL)) {
+		printk(KERN_ERR "SMI: cannot register IRQ:%d\n", 
+			PPC440GP_EXT_INT5_INTR);
+		return -EIO;
+	}
+	return 0;
+}
+
+late_initcall(init_smi);
Index: linux-2.6.12-bhpm/arch/ppc/syslib/Makefile
===================================================================
--- linux-2.6.12-bhpm.orig/arch/ppc/syslib/Makefile	2005-06-06 09:31:48.000000000 -0700
+++ linux-2.6.12-bhpm/arch/ppc/syslib/Makefile	2005-06-06 09:32:24.000000000 -0700
@@ -11,7 +11,7 @@
 obj-$(CONFIG_PPC_OCP)		+= ocp.o
 obj-$(CONFIG_IBM_OCP)		+= ibm_ocp.o
 obj-$(CONFIG_44x)		+= ibm44x_common.o
-obj-$(CONFIG_440GP)		+= ibm440gp_common.o
+obj-$(CONFIG_440GP)		+= ibm440gp_common.o ibm440gp_sleep.o
 obj-$(CONFIG_440GX)		+= ibm440gx_common.o
 obj-$(CONFIG_440SP)		+= ibm440gx_common.o ibm440sp_common.o
 ifeq ($(CONFIG_4xx),y)
Index: linux-2.6.12-bhpm/arch/ppc/syslib/ibm440gp_common.h
===================================================================
--- linux-2.6.12-bhpm.orig/arch/ppc/syslib/ibm440gp_common.h	2005-06-06 09:29:06.000000000 -0700
+++ linux-2.6.12-bhpm/arch/ppc/syslib/ibm440gp_common.h	2005-06-06 09:32:24.000000000 -0700
@@ -29,6 +29,7 @@
  */
 void ibm440gp_get_clocks(struct ibm44x_clocks*, unsigned int sys_clk,
 	unsigned int ser_clk) __init;
+void ibm440gp_sleep(u32 cpc0_er_val, u32 msr_or_val);
 
 #endif /* __ASSEMBLY__ */
 #endif /* __PPC_SYSLIB_IBM440GP_COMMON_H */
Index: linux-2.6.12-bhpm/arch/ppc/syslib/ibm440gp_sleep.S
===================================================================
--- linux-2.6.12-bhpm.orig/arch/ppc/syslib/ibm440gp_sleep.S	2005-06-01 08:52:49.947684744 -0700
+++ linux-2.6.12-bhpm/arch/ppc/syslib/ibm440gp_sleep.S	2005-06-06 09:32:24.000000000 -0700
@@ -0,0 +1,45 @@
+/*
+ * ibm440gp_sleep.S - This file contains the sleep function for 440GP CPU.
+ *
+ *  Copyright 2004,2005 Sony Corp.
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
+#include <linux/config.h>
+#include <asm/processor.h>
+#include <asm/ppc_asm.h>
+
+	.text
+
+#if defined(CONFIG_PM)
+
+/*
+ * void ibm440gp_sleep(u32 cpc0_er_val, u32 msr_or_val);
+ *  r3: new CPC0_ER value
+ *  r4: value to be OR'ed with MSR
+ */
+ 
+_GLOBAL(ibm440gp_sleep)
+	mfmsr	r0
+	or	r0,r0,r4
+	sync
+	mtdcr	0xb1,r3 /* 0xb1 = DCRN_CPC0_ER */
+	sync
+	mtmsr	r0
+	sync
+
+	blr
+
+#endif /* defined(CONFIG_PM) */
Index: linux-2.6.12-bhpm/include/asm-ppc/ocp.h
===================================================================
--- linux-2.6.12-bhpm.orig/include/asm-ppc/ocp.h	2005-06-06 09:31:47.000000000 -0700
+++ linux-2.6.12-bhpm/include/asm-ppc/ocp.h	2005-06-06 09:32:24.000000000 -0700
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


* ppc4xx_pic-pm.patch 

This patch provides power management support for the IBM PPC4xx interrupt 
controllers.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com> for CELF

--
Index: linux-2.6.12-bhpm/arch/ppc/syslib/ppc4xx_pic.c
===================================================================
--- linux-2.6.12-bhpm.orig/arch/ppc/syslib/ppc4xx_pic.c	2005-06-06 09:31:45.000000000 -0700
+++ linux-2.6.12-bhpm/arch/ppc/syslib/ppc4xx_pic.c	2005-06-06 10:12:10.000000000 -0700
@@ -245,3 +245,23 @@
 
 	ppc_md.get_irq = ppc4xx_pic_get_irq;
 }
+
+#if defined(CONFIG_PM)
+
+void ppc4xx_pic_suspend(u32 resume_bits, u32* pic_state)
+{
+	/* save UIC0 enable registers */
+	*pic_state = mfdcr(DCRN_UIC_ER(UIC0));
+
+	/* mask UIC0 interrupts, except resume_bits */
+	mtdcr(DCRN_UIC_ER(UIC0), resume_bits);
+}
+
+void ppc4xx_pic_resume(u32 pic_state)
+{
+	/* Restore UIC0 enable registers */
+	mtdcr(DCRN_UIC_ER(UIC0), pic_state);
+}
+
+#endif /* defined(CONFIG_PM) */
+
Index: linux-2.6.12-bhpm/include/asm-ppc/ppc4xx_pic.h
===================================================================
--- linux-2.6.12-bhpm.orig/include/asm-ppc/ppc4xx_pic.h	2005-06-06 09:31:47.000000000 -0700
+++ linux-2.6.12-bhpm/include/asm-ppc/ppc4xx_pic.h	2005-06-06 09:32:07.000000000 -0700
@@ -49,5 +49,7 @@
 };
 
 extern void ppc4xx_pic_init(void);
+void ppc4xx_pic_suspend(u32 resume_bits, u32* pic_state);
+void ppc4xx_pic_resume(u32 pic_state);
 
 #endif				/* __PPC4XX_PIC_H__ */

-EOF
