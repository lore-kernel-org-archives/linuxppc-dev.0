Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id BBEA3DDDD5
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 08:30:33 +1000 (EST)
Date: Wed, 29 Aug 2007 00:30:29 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
	Tony Breeds <tony@bakeyournoodle.com>, Pavel Machek <pavel@ucw.cz>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH, RFC] linkstation: implement standby
In-Reply-To: <1188214327.7837.9.camel@johannes.berg>
Message-ID: <Pine.LNX.4.60.0708290015580.3552@poirot.grange>
References: <Pine.LNX.4.60.0708260157330.3809@poirot.grange>
	<1188214327.7837.9.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Implement suspend/resume for "mpc10x" compatible fsl host PCI controllers, 
use it for linkstation standby. This is version 2, taking into account 
comments to the previous version and re-implementing MPC10x suspend in a 
separate pci driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

---

On Sun, 26 Aug 2007, Stephen Rothwell wrote:

> On Sun, 26 Aug 2007 02:03:49 +0200 (CEST) Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> >
> > +fail:
> 
> Unused label?

Removed.

On Mon, 27 Aug 2007, Tony Breeds wrote:

> On Sun, Aug 26, 2007 at 02:03:49AM +0200, Guennadi Liakhovetski wrote:
> 
> > +static int __init ls_pm_init(void)
> > +{
> > +	if (!machine_is(linkstation))
> > +		return 0;
> 
> This should probably be -ENODEV.

Fixed. The rest your comments are no longer relevant for this version, 
since mpc10x_{suspend,resume} functions are not called directly from 
linkstation.c, rather using late_suspend / early_resume (pci) hooks.

On Mon, 27 Aug 2007, Johannes Berg wrote:

> On Sun, 2007-08-26 at 02:03 +0200, Guennadi Liakhovetski wrote:
> 
> > +#ifdef CONFIG_PM
> 
> some of those probably want to be CONFIG_PM_SLEEP now.

Well, I wasn't sure when PM can be used not meaning PM_SLEEP, so, I left 
PM for now. Can certainly change, if it really matters.

A couple more thing:

1. the driver is called mpc10x.c, but the comment says it is for MPC8241. 
I don't know what PCI IDs other fsl chips have and which of them are 
compatible with 824[15].

2. the probe function, that just returns 0 seems to be redundant, but 
without it device-driver linking is incomplete and suspend/resume are not 
called.

3. the patch(es) from Scott Wood that are required for this one are still 
not merged, and I cannot remember having seen any comments / objections...

Thanks
Guennadi

diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index ab9e3f9..eb214d0 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -196,3 +196,53 @@ define_machine(linkstation){
 	.halt	 		= linkstation_halt,
 	.calibrate_decr 	= generic_calibrate_decr,
 };
+
+#ifdef CONFIG_PM
+
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
+	mpc6xx_enter_sleep();
+
+	local_irq_disable();
+
+	set_tb(tb >> 32, tb & 0xfffffffful);
+
+	return 0;
+}
+
+static struct pm_ops ls_pm_ops = {
+	.valid		= ls_pm_valid,
+	.enter		= ls_pm_enter,
+};
+
+static int __init ls_pm_init(void)
+{
+	if (!machine_is(linkstation))
+		return -ENODEV;
+
+	pm_set_ops(&ls_pm_ops);
+	return 0;
+}
+
+device_initcall(ls_pm_init);
+#endif
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 7a1d6d5..4676cc8 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -39,3 +39,6 @@ config HT_IRQ
 	   This allows native hypertransport devices to use interrupts.
 
 	   If unsure say Y.
+
+config MPC10X_PM
+	def_bool FSL_SOC && PCI && PM
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 006054a..161e36b 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -43,6 +43,8 @@ obj-$(CONFIG_HOTPLUG) += setup-bus.o
 
 obj-$(CONFIG_PCI_SYSCALL) += syscall.o
 
+obj-$(CONFIG_MPC10X_PM) += mpc10x.o
+
 ifeq ($(CONFIG_PCI_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
 endif
diff --git a/drivers/pci/mpc10x.c b/drivers/pci/mpc10x.c
index e9891df..6bd773b 100644
--- a/drivers/pci/mpc10x.c
+++ b/drivers/pci/mpc10x.c
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
index 01a33ed..be86967 100644
--- a/include/asm-powerpc/mpc6xx.h
+++ b/include/asm-powerpc/mpc6xx.h
@@ -1,6 +1,6 @@
 #ifndef __ASM_POWERPC_MPC6xx_H
 #define __ASM_POWERPC_MPC6xx_H
 
-void mpc6xx_enter_sleep(void);
+extern void mpc6xx_enter_sleep(void);
 
 #endif
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b15c649..dfe9bd2 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -802,6 +802,7 @@
 #define PCI_DEVICE_ID_MOTOROLA_MPC105	0x0001
 #define PCI_DEVICE_ID_MOTOROLA_MPC106	0x0002
 #define PCI_DEVICE_ID_MOTOROLA_MPC107	0x0004
+#define PCI_DEVICE_ID_MOTOROLA_MPC8241	0x0006
 #define PCI_DEVICE_ID_MOTOROLA_RAVEN	0x4801
 #define PCI_DEVICE_ID_MOTOROLA_FALCON	0x4802
 #define PCI_DEVICE_ID_MOTOROLA_HAWK	0x4803
