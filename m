Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 444E4DE1DF
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 11:48:19 +1000 (EST)
Subject: Re: [PATCH 2/11] cell: generalize io-workarounds code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <1208330282.6958.264.camel@pasglop>
References: <20080314.212034.-1625856941.kouish@swc.toshiba.co.jp>
	<1208330282.6958.264.camel@pasglop>
Content-Type: text/plain
Date: Thu, 17 Apr 2008 11:48:10 +1000
Message-Id: <1208396890.6958.323.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So I found a few issues with your patch. Below is a "Fixup" patch that
fixes the QS20 cell blades for me, but I would like you to apply that
directly to your series and post a new version of it so that there
is no breakage of QS20 during bisection.

Note that I believe Celleb may have some problems too. See below.

So the base issue was that on QS20, there was no struct device, thus the
dma mapping would crash.

I fixed that by changing the Cell blades code to create
of_platform_device's for the PCI busses like it does on QS21 or later,
and removed the initial call to the rtas PCI bus creation.

Now, that doesn't fix it all....

One thing I noticed in celleb_pci is that you initialize the workarounds
for the bus after it's been created at device_initcall time. This is not
good because at that time, drivers can already have been loaded &
initialized, quirks have been run, etc... so it's actually too late to
initialize the workarounds. They need to be initialized earlier.

I've tried something around the lines of initializing them from within
the PHB setup callback, which happens before the PCI probe. You should
be able to use the same approach for Celleb I suppose. Seems to work for
me so far...

In addition, your patch would have called io_workaround_init() on QS21
which doesn't need them (no Spider), thus slowing down access on
machines that don't need the workarounds.

My new code should hopefully only call this when needed. I made the call
safe to call multiple time to avoid having to test in the caller.

Another thing I noticed is that you removed the workaround to disable
PCI prefetch. Is there a reason for that ? As far as I understand,
prefetch is broken and can cause errors ranging from data corruption to
iommu exceptions if the iommu is enabled. Maybe you want to make it
depend on the revision of Spider in case your SCC has that fixed ?

My patch doesn't change that but we might need to...

So here is the patch. Please integrate my changes in your patch serie
and re-post it (minus the two patches that Paulus already accepted).

Cheers,
Ben.

Index: linux-work/arch/powerpc/kernel/of_platform.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/of_platform.c	2008-04-17 11:31:32.000000000 +1000
+++ linux-work/arch/powerpc/kernel/of_platform.c	2008-04-17 11:31:53.000000000 +1000
@@ -275,6 +275,8 @@ static int __devinit of_pci_phb_probe(st
 
 	/* Scan the bus */
 	scan_phb(phb);
+	if (phb->bus == NULL)
+		return -ENXIO;
 
 	/* Claim resources. This might need some rework as well depending
 	 * wether we are doing probe-only or not, like assigning unassigned
Index: linux-work/arch/powerpc/platforms/cell/spider-pci.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/spider-pci.c	2008-04-17 11:31:53.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/spider-pci.c	2008-04-17 11:44:12.000000000 +1000
@@ -25,17 +25,12 @@
 #include <asm/ppc-pci.h>
 #include <asm/pci-bridge.h>
 #include <asm/io.h>
+#include <asm/of_platform.h>
 
 #include "io-workarounds.h"
 
 #undef SPIDER_PCI_DISABLE_PREFETCH
 
-#define SPIDER_PCI_REG_BASE		0xd000
-#define SPIDER_PCI_REG_SIZE		0x1000
-#define SPIDER_PCI_VCI_CNTL_STAT	0x0110
-#define SPIDER_PCI_DUMMY_READ		0x0810
-#define SPIDER_PCI_DUMMY_READ_BASE	0x0814
-
 struct spiderpci_iowa_private {
 	void __iomem *regs;
 };
@@ -187,31 +182,3 @@ struct ppc_pci_io spiderpci_ops = {
 	.memcpy_fromio = spiderpci_memcpy_fromio,
 };
 
-/* We must setup the IOMMU before spider_io_workaround_init() is called. */
-static int __init spider_pci_workaround_init(void)
-{
-	struct pci_controller *phb;
-
-	/* Find spider bridges. We assume they have been all probed
-	 * in setup_arch(). If that was to change, we would need to
-	 * update this code to cope with dynamically added busses
-	 */
-	list_for_each_entry(phb, &hose_list, list_node) {
-		struct device_node *np = phb->dn;
-		const char *model = of_get_property(np, "model", NULL);
-
-		/* If no model property or name isn't exactly "pci", skip */
-		if (model == NULL || strcmp(np->name, "pci"))
-			continue;
-		/* If model is not "Spider", skip */
-		if (strcmp(model, "Spider"))
-			continue;
-		iowa_register_bus(phb, &spiderpci_ops, &spiderpci_iowa_init,
-				  (void *)SPIDER_PCI_REG_BASE);
-	}
-
-	io_workaround_init();
-
-	return 0;
-}
-machine_arch_initcall_sync(cell, spider_pci_workaround_init);
Index: linux-work/arch/powerpc/platforms/cell/io-workarounds.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/io-workarounds.c	2008-04-17 11:31:53.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/io-workarounds.c	2008-04-17 11:31:53.000000000 +1000
@@ -183,6 +183,11 @@ void __init iowa_register_bus(struct pci
 /* enable IO workaround */
 void __init io_workaround_init(void)
 {
+	static int io_workaround_inited;
+
+	if (io_workaround_inited)
+		return;
 	ppc_pci_io = iowa_pci_io;
 	ppc_md.ioremap = iowa_ioremap;
+	io_workaround_inited = 1;
 }
Index: linux-work/arch/powerpc/platforms/cell/io-workarounds.h
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/io-workarounds.h	2008-04-17 11:31:53.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/io-workarounds.h	2008-04-17 11:31:53.000000000 +1000
@@ -40,6 +40,12 @@ struct iowa_bus *iowa_mem_find_bus(const
 struct iowa_bus *iowa_pio_find_bus(unsigned long);
 
 extern struct ppc_pci_io spiderpci_ops;
-int spiderpci_iowa_init(struct iowa_bus *, void *);
+extern int spiderpci_iowa_init(struct iowa_bus *, void *);
+
+#define SPIDER_PCI_REG_BASE		0xd000
+#define SPIDER_PCI_REG_SIZE		0x1000
+#define SPIDER_PCI_VCI_CNTL_STAT	0x0110
+#define SPIDER_PCI_DUMMY_READ		0x0810
+#define SPIDER_PCI_DUMMY_READ_BASE	0x0814
 
 #endif /* _IO_WORKAROUNDS_H */
Index: linux-work/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/setup.c	2008-04-17 11:31:33.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/setup.c	2008-04-17 11:31:53.000000000 +1000
@@ -57,6 +57,7 @@
 #include "interrupt.h"
 #include "pervasive.h"
 #include "ras.h"
+#include "io-workarounds.h"
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -117,13 +118,50 @@ static void cell_fixup_pcie_rootcomplex(
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, cell_fixup_pcie_rootcomplex);
 
+static int __devinit cell_setup_phb(struct pci_controller *phb)
+{
+	const char *model;
+	struct device_node *np;
+
+	int rc = rtas_setup_phb(phb);
+	if (rc)
+		return rc;
+
+	np = phb->dn;
+	model = of_get_property(np, "model", NULL);
+	if (model == NULL || strcmp(np->name, "pci"))
+		return 0;
+
+	/* Setup workarounds for spider */
+	if (strcmp(model, "Spider"))
+		return 0;
+
+	iowa_register_bus(phb, &spiderpci_ops, &spiderpci_iowa_init,
+				  (void *)SPIDER_PCI_REG_BASE);
+	io_workaround_init();
+
+	return 0;
+}
+
 static int __init cell_publish_devices(void)
 {
+	struct device_node *root = of_find_node_by_path("/");
+	struct device_node *np;
 	int node;
 
 	/* Publish OF platform devices for southbridge IOs */
 	of_platform_bus_probe(NULL, NULL, NULL);
 
+	/* On spider based blades, we need to manually create the OF
+	 * platform devices for the PCI host bridges
+	 */
+	for_each_child_of_node(root, np) {
+		if (np->type == NULL || (strcmp(np->type, "pci") != 0 &&
+					 strcmp(np->type, "pciex") != 0))
+			continue;
+		of_platform_device_create(np, NULL, NULL);
+	}
+
 	/* There is no device for the MIC memory controller, thus we create
 	 * a platform device for it to attach the EDAC driver to.
 	 */
@@ -132,6 +170,7 @@ static int __init cell_publish_devices(v
 			continue;
 		platform_device_register_simple("cbe-mic", node, NULL, 0);
 	}
+
 	return 0;
 }
 machine_subsys_initcall(cell, cell_publish_devices);
@@ -213,7 +252,7 @@ static void __init cell_setup_arch(void)
 
 	/* Find and initialize PCI host bridges */
 	init_pci_config_tokens();
-	find_and_init_phbs();
+
 	cbe_pervasive_init();
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
@@ -249,7 +288,7 @@ define_machine(cell) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= cell_progress,
 	.init_IRQ       	= cell_init_irq,
-	.pci_setup_phb		= rtas_setup_phb,
+	.pci_setup_phb		= cell_setup_phb,
 #ifdef CONFIG_KEXEC
 	.machine_kexec		= default_machine_kexec,
 	.machine_kexec_prepare	= default_machine_kexec_prepare,
