Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A416FDDDF4
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 18:22:31 +1100 (EST)
Subject: Re: [PATCH] powermac: clean up PIC initialisation code
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1170639708.2620.77.camel@localhost.localdomain>
References: <1170375448.4036.33.camel@johannes.berg>
	<1170639708.2620.77.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 05 Feb 2007 08:21:14 +0100
Message-Id: <1170660074.3554.2.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-02-05 at 12:41 +1100, Benjamin Herrenschmidt wrote:

> Not fan of having an ifdef here... I'd rather have a pmac_pic_init()
> that does the right thing, maybe in setup.c

Ok. From what I can tell it isn't necessary to call of_irq_map_init() on
newer machines that have an IBM mpic2. So how about this?

--- mb-wireless.orig/arch/powerpc/platforms/powermac/Makefile	2007-02-02 11:56:19.723225416 +0100
+++ mb-wireless/arch/powerpc/platforms/powermac/Makefile	2007-02-02 11:56:23.943225416 +0100
@@ -1,6 +1,6 @@
 CFLAGS_bootx_init.o  		+= -fPIC
 
-obj-y				+= pic.o setup.o time.o feature.o pci.o \
+obj-y				+= setup.o time.o feature.o pci.o \
 				   sleep.o low_i2c.o cache.o pfunc_core.o \
 				   pfunc_base.o
 obj-$(CONFIG_PMAC_BACKLIGHT)	+= backlight.o
@@ -8,7 +8,7 @@ obj-$(CONFIG_CPU_FREQ_PMAC)	+= cpufreq_3
 obj-$(CONFIG_CPU_FREQ_PMAC64)	+= cpufreq_64.o
 obj-$(CONFIG_NVRAM)		+= nvram.o
 # ppc64 pmac doesn't define CONFIG_NVRAM but needs nvram stuff
-obj-$(CONFIG_PPC64)		+= nvram.o
-obj-$(CONFIG_PPC32)		+= bootx_init.o
+obj-$(CONFIG_PPC64)		+= nvram.o mpic.o
+obj-$(CONFIG_PPC32)		+= bootx_init.o pic.o mpic.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_PPC_MERGE)		+= udbg_scc.o udbg_adb.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ mb-wireless/arch/powerpc/platforms/powermac/mpic.c	2007-02-05 08:14:16.760498543 +0100
@@ -0,0 +1,143 @@
+/*
+ *  OpenPIC initialisation for PowerMacs.
+ *
+ *  Copyright (C) 1997 Paul Mackerras (paulus@samba.org)
+ *  Copyright (C) 2005 Benjamin Herrenschmidt (benh@kernel.crashing.org)
+ *                     IBM, Corp.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <asm/prom.h>
+#include <asm/pmac_feature.h>
+#include <asm/mpic.h>
+
+static void pmac_u3_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	struct mpic *mpic = desc->handler_data;
+
+	unsigned int cascade_irq = mpic_get_one_irq(mpic);
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq);
+	desc->chip->eoi(irq);
+}
+
+static void __init pmac_pic_setup_mpic_nmi(struct mpic *mpic)
+{
+#if defined(CONFIG_XMON) && defined(CONFIG_PPC32)
+	struct device_node* pswitch;
+	int nmi_irq;
+
+	pswitch = of_find_node_by_name(NULL, "programmer-switch");
+	if (pswitch) {
+		nmi_irq = irq_of_parse_and_map(pswitch, 0);
+		if (nmi_irq != NO_IRQ) {
+			mpic_irq_set_priority(nmi_irq, 9);
+			setup_irq(nmi_irq, &xmon_action);
+		}
+		of_node_put(pswitch);
+	}
+#endif	/* defined(CONFIG_XMON) && defined(CONFIG_PPC32) */
+}
+
+static struct mpic * __init pmac_setup_one_mpic(struct device_node *np,
+						int master)
+{
+	const char *name = master ? " MPIC 1   " : " MPIC 2   ";
+	struct resource r;
+	struct mpic *mpic;
+	unsigned int flags = master ? MPIC_PRIMARY : 0;
+	int rc;
+
+	rc = of_address_to_resource(np, 0, &r);
+	if (rc)
+		return NULL;
+
+	pmac_call_feature(PMAC_FTR_ENABLE_MPIC, np, 0, 0);
+
+	flags |= MPIC_WANTS_RESET;
+	if (get_property(np, "big-endian", NULL))
+		flags |= MPIC_BIG_ENDIAN;
+
+	/* Primary Big Endian means HT interrupts. This is quite dodgy
+	 * but works until I find a better way
+	 */
+	if (master && (flags & MPIC_BIG_ENDIAN))
+		flags |= MPIC_BROKEN_U3;
+
+	mpic = mpic_alloc(np, r.start, flags, 0, 0, name);
+	if (mpic == NULL)
+		return NULL;
+
+	mpic_init(mpic);
+
+	return mpic;
+ }
+
+int __init pmac_pic_probe_mpic(void)
+{
+	struct mpic *mpic1, *mpic2;
+	struct device_node *np, *master = NULL, *slave = NULL;
+	unsigned int cascade;
+
+	/* We can have up to 2 MPICs cascaded */
+	for (np = NULL; (np = of_find_node_by_type(np, "open-pic"))
+		     != NULL;) {
+		if (master == NULL &&
+		    get_property(np, "interrupts", NULL) == NULL)
+			master = of_node_get(np);
+		else if (slave == NULL)
+			slave = of_node_get(np);
+		if (master && slave)
+			break;
+	}
+
+	/* Check for bogus setups */
+	if (master == NULL && slave != NULL) {
+		master = slave;
+		slave = NULL;
+	}
+
+	/* Not found, default to good old pmac pic */
+	if (master == NULL)
+		return -ENODEV;
+
+	/* Set master handler */
+	ppc_md.get_irq = mpic_get_irq;
+
+	/* Setup master */
+	mpic1 = pmac_setup_one_mpic(master, 1);
+	BUG_ON(mpic1 == NULL);
+
+	/* Install NMI if any */
+	pmac_pic_setup_mpic_nmi(mpic1);
+
+	of_node_put(master);
+
+	/* No slave, let's go out */
+	if (slave == NULL)
+		return 0;
+
+	/* Get/Map slave interrupt */
+	cascade = irq_of_parse_and_map(slave, 0);
+	if (cascade == NO_IRQ) {
+		printk(KERN_ERR "Failed to map cascade IRQ\n");
+		return 0;
+	}
+
+	mpic2 = pmac_setup_one_mpic(slave, 0);
+	if (mpic2 == NULL) {
+		printk(KERN_ERR "Failed to setup slave MPIC\n");
+		of_node_put(slave);
+		return 0;
+	}
+	set_irq_data(cascade, mpic2);
+	set_irq_chained_handler(cascade, pmac_u3_cascade);
+
+	of_node_put(slave);
+	return 0;
+}
--- mb-wireless.orig/arch/powerpc/platforms/powermac/pic.c	2007-02-02 11:56:19.773225416 +0100
+++ mb-wireless/arch/powerpc/platforms/powermac/pic.c	2007-02-05 08:14:54.710498543 +0100
@@ -15,25 +15,14 @@
  *
  */
 
-#include <linux/stddef.h>
 #include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/signal.h>
-#include <linux/pci.h>
-#include <linux/interrupt.h>
-#include <linux/sysdev.h>
 #include <linux/adb.h>
 #include <linux/pmu.h>
-#include <linux/module.h>
 
-#include <asm/sections.h>
-#include <asm/io.h>
 #include <asm/smp.h>
 #include <asm/prom.h>
-#include <asm/pci-bridge.h>
 #include <asm/time.h>
 #include <asm/pmac_feature.h>
-#include <asm/mpic.h>
 
 #include "pmac.h"
 
@@ -44,7 +33,6 @@
  */
 extern irqreturn_t xmon_irq(int, void *);
 
-#ifdef CONFIG_PPC32
 struct pmac_irq_hw {
         unsigned int    event;
         unsigned int    enable;
@@ -438,134 +426,6 @@ static void __init pmac_pic_probe_oldsty
 	setup_irq(irq_create_mapping(NULL, 20), &xmon_action);
 #endif
 }
-#endif /* CONFIG_PPC32 */
-
-static void pmac_u3_cascade(unsigned int irq, struct irq_desc *desc)
-{
-	struct mpic *mpic = desc->handler_data;
-
-	unsigned int cascade_irq = mpic_get_one_irq(mpic);
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-	desc->chip->eoi(irq);
-}
-
-static void __init pmac_pic_setup_mpic_nmi(struct mpic *mpic)
-{
-#if defined(CONFIG_XMON) && defined(CONFIG_PPC32)
-	struct device_node* pswitch;
-	int nmi_irq;
-
-	pswitch = of_find_node_by_name(NULL, "programmer-switch");
-	if (pswitch) {
-		nmi_irq = irq_of_parse_and_map(pswitch, 0);
-		if (nmi_irq != NO_IRQ) {
-			mpic_irq_set_priority(nmi_irq, 9);
-			setup_irq(nmi_irq, &xmon_action);
-		}
-		of_node_put(pswitch);
-	}
-#endif	/* defined(CONFIG_XMON) && defined(CONFIG_PPC32) */
-}
-
-static struct mpic * __init pmac_setup_one_mpic(struct device_node *np,
-						int master)
-{
-	const char *name = master ? " MPIC 1   " : " MPIC 2   ";
-	struct resource r;
-	struct mpic *mpic;
-	unsigned int flags = master ? MPIC_PRIMARY : 0;
-	int rc;
-
-	rc = of_address_to_resource(np, 0, &r);
-	if (rc)
-		return NULL;
-
-	pmac_call_feature(PMAC_FTR_ENABLE_MPIC, np, 0, 0);
-
-	flags |= MPIC_WANTS_RESET;
-	if (get_property(np, "big-endian", NULL))
-		flags |= MPIC_BIG_ENDIAN;
-
-	/* Primary Big Endian means HT interrupts. This is quite dodgy
-	 * but works until I find a better way
-	 */
-	if (master && (flags & MPIC_BIG_ENDIAN))
-		flags |= MPIC_BROKEN_U3;
-
-	mpic = mpic_alloc(np, r.start, flags, 0, 0, name);
-	if (mpic == NULL)
-		return NULL;
-
-	mpic_init(mpic);
-
-	return mpic;
- }
-
-static int __init pmac_pic_probe_mpic(void)
-{
-	struct mpic *mpic1, *mpic2;
-	struct device_node *np, *master = NULL, *slave = NULL;
-	unsigned int cascade;
-
-	/* We can have up to 2 MPICs cascaded */
-	for (np = NULL; (np = of_find_node_by_type(np, "open-pic"))
-		     != NULL;) {
-		if (master == NULL &&
-		    get_property(np, "interrupts", NULL) == NULL)
-			master = of_node_get(np);
-		else if (slave == NULL)
-			slave = of_node_get(np);
-		if (master && slave)
-			break;
-	}
-
-	/* Check for bogus setups */
-	if (master == NULL && slave != NULL) {
-		master = slave;
-		slave = NULL;
-	}
-
-	/* Not found, default to good old pmac pic */
-	if (master == NULL)
-		return -ENODEV;
-
-	/* Set master handler */
-	ppc_md.get_irq = mpic_get_irq;
-
-	/* Setup master */
-	mpic1 = pmac_setup_one_mpic(master, 1);
-	BUG_ON(mpic1 == NULL);
-
-	/* Install NMI if any */
-	pmac_pic_setup_mpic_nmi(mpic1);
-
-	of_node_put(master);
-
-	/* No slave, let's go out */
-	if (slave == NULL)
-		return 0;
-
-	/* Get/Map slave interrupt */
-	cascade = irq_of_parse_and_map(slave, 0);
-	if (cascade == NO_IRQ) {
-		printk(KERN_ERR "Failed to map cascade IRQ\n");
-		return 0;
-	}
-
-	mpic2 = pmac_setup_one_mpic(slave, 0);
-	if (mpic2 == NULL) {
-		printk(KERN_ERR "Failed to setup slave MPIC\n");
-		of_node_put(slave);
-		return 0;
-	}
-	set_irq_data(cascade, mpic2);
-	set_irq_chained_handler(cascade, pmac_u3_cascade);
-
-	of_node_put(slave);
-	return 0;
-}
-
 
 void __init pmac_pic_init(void)
 {
@@ -574,27 +434,17 @@ void __init pmac_pic_init(void)
 	/* We configure the OF parsing based on our oldworld vs. newworld
 	 * platform type and wether we were booted by BootX.
 	 */
-#ifdef CONFIG_PPC32
 	if (!pmac_newworld)
 		flags |= OF_IMAP_OLDWORLD_MAC;
 	if (get_property(of_chosen, "linux,bootx", NULL) != NULL)
 		flags |= OF_IMAP_NO_PHANDLE;
-#endif /* CONFIG_PPC_32 */
 
 	of_irq_map_init(flags);
 
-	/* We first try to detect Apple's new Core99 chipset, since mac-io
-	 * is quite different on those machines and contains an IBM MPIC2.
-	 */
-	if (pmac_pic_probe_mpic() == 0)
-		return;
-
-#ifdef CONFIG_PPC32
 	pmac_pic_probe_oldstyle();
-#endif
 }
 
-#if defined(CONFIG_PM) && defined(CONFIG_PPC32)
+#ifdef CONFIG_PM
 /*
  * These procedures are used in implementing sleep on the powerbooks.
  * sleep_save_intrs() saves the states of all interrupt enables
@@ -662,7 +512,7 @@ static int pmacpic_resume(struct sys_dev
 	return 0;
 }
 
-#endif /* CONFIG_PM && CONFIG_PPC32 */
+#endif /* CONFIG_PM */
 
 static struct sysdev_class pmacpic_sysclass = {
 	set_kset_name("pmac_pic"),
@@ -674,18 +524,17 @@ static struct sys_device device_pmacpic 
 };
 
 static struct sysdev_driver driver_pmacpic = {
-#if defined(CONFIG_PM) && defined(CONFIG_PPC32)
+#ifdef CONFIG_PM
 	.suspend	= &pmacpic_suspend,
 	.resume		= &pmacpic_resume,
-#endif /* CONFIG_PM && CONFIG_PPC32 */
+#endif /* CONFIG_PM */
 };
 
 static int __init init_pmacpic_sysfs(void)
 {
-#ifdef CONFIG_PPC32
 	if (max_irqs == 0)
 		return -ENODEV;
-#endif
+
 	printk(KERN_DEBUG "Registering pmac pic with sysfs...\n");
 	sysdev_class_register(&pmacpic_sysclass);
 	sysdev_register(&device_pmacpic);
--- mb-wireless.orig/arch/powerpc/platforms/powermac/pmac.h	2007-02-02 11:56:19.793225416 +0100
+++ mb-wireless/arch/powerpc/platforms/powermac/pmac.h	2007-02-05 08:14:41.110498543 +0100
@@ -45,5 +45,6 @@ extern void pmac_ide_init_hwif_ports(hw_
 
 extern int pmac_nvram_init(void);
 extern void pmac_pic_init(void);
+extern int pmac_pic_probe_mpic(void);
 
 #endif /* __PMAC_H__ */
--- mb-wireless.orig/arch/powerpc/platforms/powermac/setup.c	2007-02-02 11:56:19.863225416 +0100
+++ mb-wireless/arch/powerpc/platforms/powermac/setup.c	2007-02-05 08:16:31.800498543 +0100
@@ -718,13 +718,28 @@ static int pmac_pci_probe_mode(struct pc
 }
 #endif
 
+static void __init pmac_init_irq(void)
+{
+	int ret;
+
+	/* We first try to detect Apple's new Core99 chipset, since mac-io
+	 * is quite different on those machines and contains an IBM MPIC2.
+	 */
+	ret = pmac_pic_probe_mpic();
+
+#ifdef CONFIG_PPC32
+	if (!ret)
+		pmac_pic_init();
+#endif
+}
+
 define_machine(powermac) {
 	.name			= "PowerMac",
 	.probe			= pmac_probe,
 	.setup_arch		= pmac_setup_arch,
 	.init_early		= pmac_init_early,
 	.show_cpuinfo		= pmac_show_cpuinfo,
-	.init_IRQ		= pmac_pic_init,
+	.init_IRQ		= pmac_init_irq,
 	.get_irq		= NULL,	/* changed later */
 	.pci_irq_fixup		= pmac_pci_irq_fixup,
 	.restart		= pmac_restart,
