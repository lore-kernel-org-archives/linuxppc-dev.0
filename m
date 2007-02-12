Return-Path: <tnt@246tNt.com>
Received: from outmx006.isp.belgacom.be (outmx006.isp.belgacom.be
	[195.238.4.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 61340DDF39
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 09:14:27 +1100 (EST)
Received: from outmx006.isp.belgacom.be (localhost [127.0.0.1])
	by outmx006.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1CMEJZX013476
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 23:14:19 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 06/10] powerpc: Small cleanup of EFIKA platform
Date: Mon, 12 Feb 2007 23:13:24 +0100
Message-Id: <11713184152189-git-send-email-tnt@246tNt.com>
In-Reply-To: <11713184141191-git-send-email-tnt@246tNt.com>
References: <11713184081457-git-send-email-tnt@246tNt.com>
	<11713184091057-git-send-email-tnt@246tNt.com>
	<11713184101239-git-send-email-tnt@246tNt.com>
	<11713184112187-git-send-email-tnt@246tNt.com>
	<11713184132161-git-send-email-tnt@246tNt.com>
	<11713184141191-git-send-email-tnt@246tNt.com>
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The efika platform used three files efika-pci.c efika-setup.c and
a 2 line efika.h to link the two. The total of code in those is
really not much and therefore, I think they're better merged
in a single file.

There is absolutely _no_code_change_ at all, just merged the files.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/platforms/52xx/Makefile      |    2 
 arch/powerpc/platforms/52xx/efika-pci.c   |  119 --------------
 arch/powerpc/platforms/52xx/efika-setup.c |  121 --------------
 arch/powerpc/platforms/52xx/efika.c       |  243 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/52xx/efika.h       |   19 --
 5 files changed, 244 insertions(+), 260 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/Makefile b/arch/powerpc/platforms/52xx/Makefile
index 795b713..07cdbca 100644
--- a/arch/powerpc/platforms/52xx/Makefile
+++ b/arch/powerpc/platforms/52xx/Makefile
@@ -6,5 +6,5 @@ obj-y				+= mpc52xx_pic.o mpc52xx_common
 obj-$(CONFIG_PCI)		+= mpc52xx_pci.o
 endif
 
-obj-$(CONFIG_PPC_EFIKA)		+= efika-setup.o efika-pci.o
+obj-$(CONFIG_PPC_EFIKA)		+= efika.o
 obj-$(CONFIG_PPC_LITE5200)	+= lite5200.o
diff --git a/arch/powerpc/platforms/52xx/efika-pci.c b/arch/powerpc/platforms/52xx/efika-pci.c
deleted file mode 100644
index 62e05b2..0000000
--- a/arch/powerpc/platforms/52xx/efika-pci.c
+++ /dev/null
@@ -1,119 +0,0 @@
-
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/string.h>
-#include <linux/init.h>
-
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
-#include <asm/machdep.h>
-#include <asm/sections.h>
-#include <asm/pci-bridge.h>
-#include <asm/rtas.h>
-
-#include "efika.h"
-
-#ifdef CONFIG_PCI
-/*
- * Access functions for PCI config space using RTAS calls.
- */
-static int rtas_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
-			    int len, u32 * val)
-{
-	struct pci_controller *hose = bus->sysdata;
-	unsigned long addr = (offset & 0xff) | ((devfn & 0xff) << 8)
-	    | (((bus->number - hose->first_busno) & 0xff) << 16)
-	    | (hose->index << 24);
-	int ret = -1;
-	int rval;
-
-	rval = rtas_call(rtas_token("read-pci-config"), 2, 2, &ret, addr, len);
-	*val = ret;
-	return rval ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
-}
-
-static int rtas_write_config(struct pci_bus *bus, unsigned int devfn,
-			     int offset, int len, u32 val)
-{
-	struct pci_controller *hose = bus->sysdata;
-	unsigned long addr = (offset & 0xff) | ((devfn & 0xff) << 8)
-	    | (((bus->number - hose->first_busno) & 0xff) << 16)
-	    | (hose->index << 24);
-	int rval;
-
-	rval = rtas_call(rtas_token("write-pci-config"), 3, 1, NULL,
-			 addr, len, val);
-	return rval ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
-}
-
-static struct pci_ops rtas_pci_ops = {
-	rtas_read_config,
-	rtas_write_config
-};
-
-void __init efika_pcisetup(void)
-{
-	const int *bus_range;
-	int len;
-	struct pci_controller *hose;
-	struct device_node *root;
-	struct device_node *pcictrl;
-
-	root = of_find_node_by_path("/");
-	if (root == NULL) {
-		printk(KERN_WARNING EFIKA_PLATFORM_NAME
-		       ": Unable to find the root node\n");
-		return;
-	}
-
-	for (pcictrl = NULL;;) {
-		pcictrl = of_get_next_child(root, pcictrl);
-		if ((pcictrl == NULL) || (strcmp(pcictrl->name, "pci") == 0))
-			break;
-	}
-
-	of_node_put(root);
-
-	if (pcictrl == NULL) {
-		printk(KERN_WARNING EFIKA_PLATFORM_NAME
-		       ": Unable to find the PCI bridge node\n");
-		return;
-	}
-
-	bus_range = get_property(pcictrl, "bus-range", &len);
-	if (bus_range == NULL || len < 2 * sizeof(int)) {
-		printk(KERN_WARNING EFIKA_PLATFORM_NAME
-		       ": Can't get bus-range for %s\n", pcictrl->full_name);
-		return;
-	}
-
-	if (bus_range[1] == bus_range[0])
-		printk(KERN_INFO EFIKA_PLATFORM_NAME ": PCI bus %d",
-		       bus_range[0]);
-	else
-		printk(KERN_INFO EFIKA_PLATFORM_NAME ": PCI buses %d..%d",
-		       bus_range[0], bus_range[1]);
-	printk(" controlled by %s\n", pcictrl->full_name);
-	printk("\n");
-
-	hose = pcibios_alloc_controller();
-	if (!hose) {
-		printk(KERN_WARNING EFIKA_PLATFORM_NAME
-		       ": Can't allocate PCI controller structure for %s\n",
-		       pcictrl->full_name);
-		return;
-	}
-
-	hose->arch_data = of_node_get(pcictrl);
-	hose->first_busno = bus_range[0];
-	hose->last_busno = bus_range[1];
-	hose->ops = &rtas_pci_ops;
-
-	pci_process_bridge_OF_ranges(hose, pcictrl, 0);
-}
-
-#else
-void __init efika_pcisetup(void)
-{}
-#endif
diff --git a/arch/powerpc/platforms/52xx/efika-setup.c b/arch/powerpc/platforms/52xx/efika-setup.c
deleted file mode 100644
index b6945cb..0000000
--- a/arch/powerpc/platforms/52xx/efika-setup.c
+++ /dev/null
@@ -1,121 +0,0 @@
-/*
- *
- * Efika 5K2 platform setup
- * Some code really inspired from the lite5200b platform.
- *
- * Copyright (C) 2006 bplan GmbH
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- *
- */
-
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/reboot.h>
-#include <linux/init.h>
-#include <linux/utsrelease.h>
-#include <linux/seq_file.h>
-#include <linux/root_dev.h>
-#include <linux/initrd.h>
-#include <linux/timer.h>
-#include <linux/pci.h>
-
-#include <asm/pgtable.h>
-#include <asm/prom.h>
-#include <asm/time.h>
-#include <asm/machdep.h>
-#include <asm/rtas.h>
-#include <asm/of_device.h>
-#include <asm/of_platform.h>
-#include <asm/mpc52xx.h>
-
-#include "efika.h"
-
-static void efika_show_cpuinfo(struct seq_file *m)
-{
-	struct device_node *root;
-	const char *revision = NULL;
-	const char *codegendescription = NULL;
-	const char *codegenvendor = NULL;
-
-	root = of_find_node_by_path("/");
-	if (!root)
-		return;
-
-	revision = get_property(root, "revision", NULL);
-	codegendescription =
-		    get_property(root, "CODEGEN,description", NULL);
-	codegenvendor = get_property(root, "CODEGEN,vendor", NULL);
-
-	if (codegendescription)
-		seq_printf(m, "machine\t\t: %s\n", codegendescription);
-	else
-		seq_printf(m, "machine\t\t: Efika\n");
-
-	if (revision)
-		seq_printf(m, "revision\t: %s\n", revision);
-
-	if (codegenvendor)
-		seq_printf(m, "vendor\t\t: %s\n", codegenvendor);
-
-	of_node_put(root);
-}
-
-static void __init efika_setup_arch(void)
-{
-	rtas_initialize();
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	initrd_below_start_ok = 1;
-
-	if (initrd_start)
-		ROOT_DEV = Root_RAM0;
-	else
-#endif
-		ROOT_DEV = Root_SDA2;	/* sda2 (sda1 is for the kernel) */
-
-	efika_pcisetup();
-
-	if (ppc_md.progress)
-		ppc_md.progress("Linux/PPC " UTS_RELEASE " running on Efika ;-)\n", 0x0);
-}
-
-static int __init efika_probe(void)
-{
-	char *model = of_get_flat_dt_prop(of_get_flat_dt_root(),
-					  "model", NULL);
-
-	if (model == NULL)
-		return 0;
-	if (strcmp(model, "EFIKA5K2"))
-		return 0;
-
-	ISA_DMA_THRESHOLD = ~0L;
-	DMA_MODE_READ = 0x44;
-	DMA_MODE_WRITE = 0x48;
-
-	return 1;
-}
-
-define_machine(efika)
-{
-	.name			= EFIKA_PLATFORM_NAME,
-	.probe			= efika_probe,
-	.setup_arch		= efika_setup_arch,
-	.init			= mpc52xx_declare_of_platform_devices,
-	.show_cpuinfo		= efika_show_cpuinfo,
-	.init_IRQ		= mpc52xx_init_irq,
-	.get_irq		= mpc52xx_get_irq,
-	.restart		= rtas_restart,
-	.power_off		= rtas_power_off,
-	.halt			= rtas_halt,
-	.set_rtc_time		= rtas_set_rtc_time,
-	.get_rtc_time		= rtas_get_rtc_time,
-	.progress		= rtas_progress,
-	.get_boot_time		= rtas_get_boot_time,
-	.calibrate_decr		= generic_calibrate_decr,
-	.phys_mem_access_prot	= pci_phys_mem_access_prot,
-};
diff --git a/arch/powerpc/platforms/52xx/efika.c b/arch/powerpc/platforms/52xx/efika.c
new file mode 100644
index 0000000..8de0341
--- /dev/null
+++ b/arch/powerpc/platforms/52xx/efika.c
@@ -0,0 +1,243 @@
+/*
+ * Efika 5K2 platform code
+ * Some code really inspired from the lite5200b platform.
+ *
+ * Copyright (C) 2006 bplan GmbH
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/utsrelease.h>
+#include <linux/seq_file.h>
+#include <linux/string.h>
+#include <linux/root_dev.h>
+#include <linux/initrd.h>
+#include <linux/timer.h>
+#include <linux/pci.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/sections.h>
+#include <asm/pci-bridge.h>
+#include <asm/pgtable.h>
+#include <asm/prom.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/rtas.h>
+#include <asm/of_device.h>
+#include <asm/of_platform.h>
+#include <asm/mpc52xx.h>
+
+
+#define EFIKA_PLATFORM_NAME "Efika"
+
+
+/* ------------------------------------------------------------------------ */
+/* PCI accesses thru RTAS                                                   */
+/* ------------------------------------------------------------------------ */
+
+#ifdef CONFIG_PCI
+
+/*
+ * Access functions for PCI config space using RTAS calls.
+ */
+static int rtas_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
+			    int len, u32 * val)
+{
+	struct pci_controller *hose = bus->sysdata;
+	unsigned long addr = (offset & 0xff) | ((devfn & 0xff) << 8)
+	    | (((bus->number - hose->first_busno) & 0xff) << 16)
+	    | (hose->index << 24);
+	int ret = -1;
+	int rval;
+
+	rval = rtas_call(rtas_token("read-pci-config"), 2, 2, &ret, addr, len);
+	*val = ret;
+	return rval ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
+}
+
+static int rtas_write_config(struct pci_bus *bus, unsigned int devfn,
+			     int offset, int len, u32 val)
+{
+	struct pci_controller *hose = bus->sysdata;
+	unsigned long addr = (offset & 0xff) | ((devfn & 0xff) << 8)
+	    | (((bus->number - hose->first_busno) & 0xff) << 16)
+	    | (hose->index << 24);
+	int rval;
+
+	rval = rtas_call(rtas_token("write-pci-config"), 3, 1, NULL,
+			 addr, len, val);
+	return rval ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops rtas_pci_ops = {
+	rtas_read_config,
+	rtas_write_config
+};
+
+
+void __init efika_pcisetup(void)
+{
+	const int *bus_range;
+	int len;
+	struct pci_controller *hose;
+	struct device_node *root;
+	struct device_node *pcictrl;
+
+	root = of_find_node_by_path("/");
+	if (root == NULL) {
+		printk(KERN_WARNING EFIKA_PLATFORM_NAME
+		       ": Unable to find the root node\n");
+		return;
+	}
+
+	for (pcictrl = NULL;;) {
+		pcictrl = of_get_next_child(root, pcictrl);
+		if ((pcictrl == NULL) || (strcmp(pcictrl->name, "pci") == 0))
+			break;
+	}
+
+	of_node_put(root);
+
+	if (pcictrl == NULL) {
+		printk(KERN_WARNING EFIKA_PLATFORM_NAME
+		       ": Unable to find the PCI bridge node\n");
+		return;
+	}
+
+	bus_range = get_property(pcictrl, "bus-range", &len);
+	if (bus_range == NULL || len < 2 * sizeof(int)) {
+		printk(KERN_WARNING EFIKA_PLATFORM_NAME
+		       ": Can't get bus-range for %s\n", pcictrl->full_name);
+		return;
+	}
+
+	if (bus_range[1] == bus_range[0])
+		printk(KERN_INFO EFIKA_PLATFORM_NAME ": PCI bus %d",
+		       bus_range[0]);
+	else
+		printk(KERN_INFO EFIKA_PLATFORM_NAME ": PCI buses %d..%d",
+		       bus_range[0], bus_range[1]);
+	printk(" controlled by %s\n", pcictrl->full_name);
+	printk("\n");
+
+	hose = pcibios_alloc_controller();
+	if (!hose) {
+		printk(KERN_WARNING EFIKA_PLATFORM_NAME
+		       ": Can't allocate PCI controller structure for %s\n",
+		       pcictrl->full_name);
+		return;
+	}
+
+	hose->arch_data = of_node_get(pcictrl);
+	hose->first_busno = bus_range[0];
+	hose->last_busno = bus_range[1];
+	hose->ops = &rtas_pci_ops;
+
+	pci_process_bridge_OF_ranges(hose, pcictrl, 0);
+}
+
+#else
+void __init efika_pcisetup(void)
+{}
+#endif
+
+
+
+/* ------------------------------------------------------------------------ */
+/* Platform setup                                                           */
+/* ------------------------------------------------------------------------ */
+
+static void efika_show_cpuinfo(struct seq_file *m)
+{
+	struct device_node *root;
+	const char *revision = NULL;
+	const char *codegendescription = NULL;
+	const char *codegenvendor = NULL;
+
+	root = of_find_node_by_path("/");
+	if (!root)
+		return;
+
+	revision = get_property(root, "revision", NULL);
+	codegendescription =
+		    get_property(root, "CODEGEN,description", NULL);
+	codegenvendor = get_property(root, "CODEGEN,vendor", NULL);
+
+	if (codegendescription)
+		seq_printf(m, "machine\t\t: %s\n", codegendescription);
+	else
+		seq_printf(m, "machine\t\t: Efika\n");
+
+	if (revision)
+		seq_printf(m, "revision\t: %s\n", revision);
+
+	if (codegenvendor)
+		seq_printf(m, "vendor\t\t: %s\n", codegenvendor);
+
+	of_node_put(root);
+}
+
+static void __init efika_setup_arch(void)
+{
+	rtas_initialize();
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	initrd_below_start_ok = 1;
+
+	if (initrd_start)
+		ROOT_DEV = Root_RAM0;
+	else
+#endif
+		ROOT_DEV = Root_SDA2;	/* sda2 (sda1 is for the kernel) */
+
+	efika_pcisetup();
+
+	if (ppc_md.progress)
+		ppc_md.progress("Linux/PPC " UTS_RELEASE " running on Efika ;-)\n", 0x0);
+}
+
+static int __init efika_probe(void)
+{
+	char *model = of_get_flat_dt_prop(of_get_flat_dt_root(),
+					  "model", NULL);
+
+	if (model == NULL)
+		return 0;
+	if (strcmp(model, "EFIKA5K2"))
+		return 0;
+
+	ISA_DMA_THRESHOLD = ~0L;
+	DMA_MODE_READ = 0x44;
+	DMA_MODE_WRITE = 0x48;
+
+	return 1;
+}
+
+define_machine(efika)
+{
+	.name			= EFIKA_PLATFORM_NAME,
+	.probe			= efika_probe,
+	.setup_arch		= efika_setup_arch,
+	.init			= mpc52xx_declare_of_platform_devices,
+	.show_cpuinfo		= efika_show_cpuinfo,
+	.init_IRQ		= mpc52xx_init_irq,
+	.get_irq		= mpc52xx_get_irq,
+	.restart		= rtas_restart,
+	.power_off		= rtas_power_off,
+	.halt			= rtas_halt,
+	.set_rtc_time		= rtas_set_rtc_time,
+	.get_rtc_time		= rtas_get_rtc_time,
+	.progress		= rtas_progress,
+	.get_boot_time		= rtas_get_boot_time,
+	.calibrate_decr		= generic_calibrate_decr,
+	.phys_mem_access_prot	= pci_phys_mem_access_prot,
+};
+
diff --git a/arch/powerpc/platforms/52xx/efika.h b/arch/powerpc/platforms/52xx/efika.h
deleted file mode 100644
index 2f060fd..0000000
--- a/arch/powerpc/platforms/52xx/efika.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * Efika 5K2 platform setup - Header file
- *
- * Copyright (C) 2006 bplan GmbH
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- *
- */
-
-#ifndef __ARCH_POWERPC_EFIKA__
-#define __ARCH_POWERPC_EFIKA__
-
-#define EFIKA_PLATFORM_NAME "Efika"
-
-extern void __init efika_pcisetup(void);
-
-#endif
-- 
1.4.2
