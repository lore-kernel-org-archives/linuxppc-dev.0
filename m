Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id B30F867B43
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 10:01:11 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k1ANH3Gi029875 for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 16:17:03 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k1ANA0HC000058
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 17:10:01 -0600 (CST)
Received: from ld0175-tx32.am.freescale.net (ld0175-tx32 [10.82.19.125])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	k1AMvfTP015566 for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 16:57:41 -0600 (CST)
Received: from ld0175-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0175-tx32.am.freescale.net (Postfix) with ESMTP id A3E6C4F8CC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 17:01:07 -0600 (CST)
Received: from localhost (afleming@localhost)
	by ld0175-tx32.am.freescale.net (8.12.11/8.12.11/Submit) with ESMTP id
	k1AN16Jn009293
	for <linuxppc-embedded@ozlabs.org>; Fri, 10 Feb 2006 17:01:07 -0600
Date: Fri, 10 Feb 2006 17:01:06 -0600 (CST)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] Add PCI support for 8540 ADS to powerpc tree
Message-ID: <Pine.LNX.4.61.0602101654580.8978@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This patch applies on top off Becky's cleanup patches

Signed-off-by: Andy Fleming <afleming@freescale.com>

diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 70e1190..ffc4139 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -1,4 +1,5 @@
 #
 # Makefile for the PowerPC 85xx linux kernel.
 #
-obj-$(CONFIG_PPC_85xx)	+= misc.o mpc85xx_ads.o
+obj-$(CONFIG_PPC_85xx)	+= misc.o pci.o
+obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
diff --git a/arch/powerpc/platforms/85xx/mpc8540_ads.h b/arch/powerpc/platforms/85xx/mpc8540_ads.h
index b3ec88c..16976bd 100644
--- a/arch/powerpc/platforms/85xx/mpc8540_ads.h
+++ b/arch/powerpc/platforms/85xx/mpc8540_ads.h
@@ -39,7 +39,7 @@
 #define MPC85XX_PCI1_IO_BASE	0xe2000000
 #define MPC85XX_PCI1_MEM_OFFSET	0x00000000
 
-#define MPC85XX_PCI1_IO_SIZE	0x01000000
+#define MPC85XX_PCI1_IO_SIZE	0x00100000
 
 /* PCI config */
 #define PCI1_CFG_ADDR_OFFSET	(0x8000)
diff --git a/arch/powerpc/platforms/85xx/mpc85xx.h b/arch/powerpc/platforms/85xx/mpc85xx.h
index be75abb..b44db62 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx.h
+++ b/arch/powerpc/platforms/85xx/mpc85xx.h
@@ -15,3 +15,4 @@
  */
 
 extern void mpc85xx_restart(char *);
+extern int add_bridge(struct device_node *dev);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index e14cd20..3a4b409 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -67,6 +67,62 @@ static u_char mpc85xx_ads_openpic_initse
 	0x0,						/* External 11: */
 };
 
+#ifdef CONFIG_PCI
+/*
+ * interrupt routing
+ */
+
+int
+mpc85xx_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+{
+	static char pci_irq_table[][4] =
+	    /*
+	     * This is little evil, but works around the fact
+	     * that revA boards have IDSEL starting at 18
+	     * and others boards (older) start at 12
+	     *
+	     *      PCI IDSEL/INTPIN->INTLINE
+	     *       A      B      C      D
+	     */
+	{
+		{PIRQA, PIRQB, PIRQC, PIRQD},	/* IDSEL 2 */
+		{PIRQD, PIRQA, PIRQB, PIRQC},
+		{PIRQC, PIRQD, PIRQA, PIRQB},
+		{PIRQB, PIRQC, PIRQD, PIRQA},	/* IDSEL 5 */
+		{0, 0, 0, 0},	/* -- */
+		{0, 0, 0, 0},	/* -- */
+		{0, 0, 0, 0},	/* -- */
+		{0, 0, 0, 0},	/* -- */
+		{0, 0, 0, 0},	/* -- */
+		{0, 0, 0, 0},	/* -- */
+		{PIRQA, PIRQB, PIRQC, PIRQD},	/* IDSEL 12 */
+		{PIRQD, PIRQA, PIRQB, PIRQC},
+		{PIRQC, PIRQD, PIRQA, PIRQB},
+		{PIRQB, PIRQC, PIRQD, PIRQA},	/* IDSEL 15 */
+		{0, 0, 0, 0},	/* -- */
+		{0, 0, 0, 0},	/* -- */
+		{PIRQA, PIRQB, PIRQC, PIRQD},	/* IDSEL 18 */
+		{PIRQD, PIRQA, PIRQB, PIRQC},
+		{PIRQC, PIRQD, PIRQA, PIRQB},
+		{PIRQB, PIRQC, PIRQD, PIRQA},	/* IDSEL 21 */
+	};
+
+	const long min_idsel = 2, max_idsel = 21, irqs_per_slot = 4;
+	return PCI_IRQ_TABLE_LOOKUP;
+}
+
+int
+mpc85xx_exclude_device(u_char bus, u_char devfn)
+{
+	if (bus == 0 && PCI_SLOT(devfn) == 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	else
+		return PCIBIOS_SUCCESSFUL;
+}
+
+#endif /* CONFIG_PCI */
+
+
 void __init mpc85xx_ads_pic_init(void)
 {
 	struct mpic *mpic1;
@@ -110,6 +166,7 @@ void __init mpc85xx_ads_pic_init(void)
 static void __init mpc85xx_ads_setup_arch(void)
 {
 	struct device_node *cpu;
+	struct device_node *np;
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_ads_setup_arch()", 0);
@@ -125,6 +182,16 @@ static void __init mpc85xx_ads_setup_arc
 			loops_per_jiffy = 50000000 / HZ;
 		of_node_put(cpu);
 	}
+
+#ifdef CONFIG_PCI
+	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
+		add_bridge(np);
+
+	ppc_md.pci_swizzle = common_swizzle;
+	ppc_md.pci_map_irq = mpc85xx_map_irq;
+	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
+#endif
+
 #ifdef  CONFIG_ROOT_NFS
 	ROOT_DEV = Root_NFS;
 #else
diff --git a/arch/powerpc/platforms/85xx/pci.c b/arch/powerpc/platforms/85xx/pci.c
new file mode 100644
index 0000000..93b0bb1
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/pci.c
@@ -0,0 +1,96 @@
+/*
+ * FSL SoC setup code
+ *
+ * Maintained by Kumar Gala (see MAINTAINERS for contact information)
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+
+#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/io.h>
+#include <asm/pci-bridge.h>
+#include <asm/prom.h>
+#include <sysdev/fsl_soc.h>
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
+int mpc85xx_pci2_busno = 0;
+
+#ifdef CONFIG_PCI
+int __init add_bridge(struct device_node *dev)
+{
+	int len;
+	struct pci_controller *hose;
+	struct resource rsrc;
+	int *bus_range;
+	int primary = 1, has_address = 0;
+	phys_addr_t immr = get_immrbase();
+
+	DBG("Adding PCI host bridge %s\n", dev->full_name);
+
+	/* Fetch host bridge registers address */
+	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
+
+	/* Get bus range if any */
+	bus_range = (int *) get_property(dev, "bus-range", &len);
+	if (bus_range == NULL || len < 2 * sizeof(int)) {
+		printk(KERN_WARNING "Can't get bus-range for %s, assume"
+		       " bus 0\n", dev->full_name);
+	}
+
+	hose = pcibios_alloc_controller();
+	if (!hose)
+		return -ENOMEM;
+	hose->arch_data = dev;
+	hose->set_cfg_type = 1;
+
+	hose->first_busno = bus_range ? bus_range[0] : 0;
+	hose->last_busno = bus_range ? bus_range[1] : 0xff;
+
+	/* PCI 1 */
+	if ((rsrc.start & 0xfffff) == 0x8000) {
+		setup_indirect_pci(hose, immr + 0x8000, immr + 0x8004);
+	}
+	/* PCI 2*/
+	if ((rsrc.start & 0xfffff) == 0x9000) {
+		setup_indirect_pci(hose, immr + 0x9000, immr + 0x9004);
+		primary = 0;
+		hose->bus_offset = hose->first_busno;
+		mpc85xx_pci2_busno = hose->first_busno;
+	}
+
+	printk(KERN_INFO "Found MPC85xx PCI host bridge at 0x%08lx. "
+	       "Firmware bus number: %d->%d\n",
+		rsrc.start, hose->first_busno, hose->last_busno);
+
+	DBG(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
+		hose, hose->cfg_addr, hose->cfg_data);
+
+	/* Interpret the "ranges" property */
+	/* This also maps the I/O region and sets isa_io/mem_base */
+	pci_process_bridge_OF_ranges(hose, dev, primary);
+
+	return 0;
+}
+
+#endif
