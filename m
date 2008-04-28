Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 7E77BDE9FC
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 01:40:06 +1000 (EST)
Date: Mon, 28 Apr 2008 17:40:19 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 7/7] linkstation: implement standby
In-Reply-To: <Pine.LNX.4.64.0804281714000.7897@axis700.grange>
Message-ID: <Pine.LNX.4.64.0804281732000.7897@axis700.grange>
References: <Pine.LNX.4.64.0804281714000.7897@axis700.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	Pavel Machek <pavel@ucw.cz>, Scott Wood <scottwood@freescale.com>,
	linux-pm@lists.linux-foundation.org,
	Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Implement suspend/resume for "mpc10x" compatible fsl host PCI controllers, 
use it for linkstation standby. This is version 3, updated to the current
powerpc git tree. Depends as before on TLF_SLEEPING and HID0_SLEEP patches
from Scott Wood.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 20f45a8..693da18 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -192,7 +192,7 @@ config ARCH_HIBERNATION_POSSIBLE
 
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
-	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx
+	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || MPC10X_BRIDGE
 
 config PPC_DCR_NATIVE
 	bool
diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index eb5d74e..3bab51f 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -197,3 +197,54 @@ define_machine(linkstation){
 	.halt	 		= linkstation_halt,
 	.calibrate_decr 	= generic_calibrate_decr,
 };
+
+#ifdef CONFIG_PM_SLEEP
+
+#include <linux/suspend.h>
+#include <linux/serial_reg.h>
+#include <sysdev/fsl_soc.h>
+#include <asm/mpc6xx.h>
+
+static int ls_pm_valid(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static int ls_pm_enter(suspend_state_t state)
+{
+	u64 tb;
+
+	/* Get timebase */
+	tb = get_tb();
+
+	/* put CPU to sleep, re-enabling interrupts */
+	mpc6xx_enter_standby();
+
+	local_irq_disable();
+
+	set_tb(tb >> 32, tb & 0xfffffffful);
+
+	return 0;
+}
+
+static struct platform_suspend_ops ls_pm_ops = {
+	.valid		= ls_pm_valid,
+	.enter		= ls_pm_enter,
+};
+
+static int __init ls_pm_init(void)
+{
+	if (!machine_is(linkstation))
+		return -ENODEV;
+
+	suspend_set_ops(&ls_pm_ops);
+	return 0;
+}
+
+device_initcall(ls_pm_init);
+#endif
diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index 72fb35b..4df3230 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -6,3 +6,6 @@ config PPC4xx_PCI_EXPRESS
 	bool
 	depends on PCI && 4xx
 	default n
+
+config MPC10X_PM
+	def_bool FSL_SOC && PCI && PM_SLEEP
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 2cc5052..0b90cc8 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -48,3 +48,5 @@ endif
 ifeq ($(CONFIG_SUSPEND),y)
 obj-$(CONFIG_6xx)		+= 6xx-suspend.o
 endif
+
+obj-$(CONFIG_MPC10X_PM)		+= mpc10x_pm.o
diff -u /dev/null b/arch/powerpc/sysdev/mpc10x_pm.c
new file mode 100644
index 0000000..6bd773b
--- /dev/null	2008-04-28 10:35:13.531006534 +0200
+++ b/arch/powerpc/sysdev/mpc10x_pm.c	2008-04-25 21:18:19.000000000 +0200
@@ -0,0 +1,73 @@
+/*
+ * Power-management driver for MPC8241 host-PCI controller
+ *
+ * Copyright (C) 2007 G. Liakhovetski (g.liakhovetski@gmx.de)
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of
+ * any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/pm.h>
+
+#include <asm/pci-bridge.h>
+
+#define	MPC10X_LP_REF_EN	(1<<12)
+#define	MPC10X_PM		(1<<7)
+#define MPC10X_DOZE		(1<<5)
+#define	MPC10X_NAP		(1<<4)
+#define	MPC10X_SLEEP		(1<<3)
+
+static int __devinit mpc10x_pm_probe(struct pci_dev *pdev,
+				     const struct pci_device_id *id)
+{
+	return 0;
+}
+
+static int mpc10x_pm_suspend_late(struct pci_dev *dev, pm_message_t state)
+{
+	u16 pmcr1;
+
+	pci_read_config_word(dev, 0x70, &pmcr1);
+	pmcr1 &= ~(MPC10X_DOZE | MPC10X_NAP);
+	pmcr1 |= MPC10X_PM | MPC10X_SLEEP | MPC10X_LP_REF_EN;
+	pci_write_config_word(dev, 0x70, pmcr1);
+
+	return 0;
+}
+
+static int mpc10x_pm_resume_early(struct pci_dev *dev)
+{
+	u16 pmcr1;
+
+	pci_read_config_word(dev, 0x70, &pmcr1);
+	pmcr1 &= ~(MPC10X_PM | MPC10X_DOZE | MPC10X_SLEEP | MPC10X_NAP | MPC10X_LP_REF_EN);
+	pci_write_config_word(dev, 0x70, pmcr1);
+
+	return 0;
+}
+
+static struct pci_device_id mpc10x_pm_pci_tbl[] = {
+	{ PCI_VENDOR_ID_MOTOROLA, PCI_DEVICE_ID_MOTOROLA_MPC8241,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, mpc10x_pm_pci_tbl);
+
+static struct pci_driver mpc10x_pm_driver = {
+	.name		= "mpc10x-pm",
+	.id_table	= mpc10x_pm_pci_tbl,
+	.resume_early	= mpc10x_pm_resume_early,
+	.suspend_late	= mpc10x_pm_suspend_late,
+	.probe		= mpc10x_pm_probe,
+};
+
+static int __init mpc10x_pm_init(void)
+{
+	return pci_register_driver(&mpc10x_pm_driver);
+}
+
+device_initcall(mpc10x_pm_init);
diff --git a/include/asm-powerpc/mpc6xx.h b/include/asm-powerpc/mpc6xx.h
index effc229..9bdf8b4 100644
--- a/include/asm-powerpc/mpc6xx.h
+++ b/include/asm-powerpc/mpc6xx.h
@@ -1,6 +1,6 @@
 #ifndef __ASM_POWERPC_MPC6xx_H
 #define __ASM_POWERPC_MPC6xx_H
 
-void mpc6xx_enter_standby(void);
+extern void mpc6xx_enter_standby(void);
 
 #endif
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 70eb3c8..9eb84cc 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -800,6 +800,7 @@
 #define PCI_DEVICE_ID_MOTOROLA_MPC105	0x0001
 #define PCI_DEVICE_ID_MOTOROLA_MPC106	0x0002
 #define PCI_DEVICE_ID_MOTOROLA_MPC107	0x0004
+#define PCI_DEVICE_ID_MOTOROLA_MPC8241	0x0006
 #define PCI_DEVICE_ID_MOTOROLA_RAVEN	0x4801
 #define PCI_DEVICE_ID_MOTOROLA_FALCON	0x4802
 #define PCI_DEVICE_ID_MOTOROLA_HAWK	0x4803
