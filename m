Return-Path: <nd@bplan-gmbh.de>
Date: Fri, 3 Nov 2006 08:31:45 +0100 (MET)
Message-ID: <454AF03E.6040208@bplan-gmbh.de>
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Nicolas DET <nd@bplan-gmbh.de>
Subject: Re: [PATCH/RFC] powerpc: Add Efika platform support
References: <45490394.8020202@bplan-gmbh.de>		<1162419546.25682.460.camel@localhost.localdomain>	<1162423546.25682.486.camel@localhost.localdomain>
	<454A5A61.6080800@bplan-gmbh.de>
In-Reply-To: <454A5A61.6080800@bplan-gmbh.de>
Content-Type: multipart/mixed; boundary="------------060907010700020809040605"
Cc: linuxppc-embedded@ozlabs.org, sl@bplan-gmbh.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060907010700020809040605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nicolas DET wrote:

> +	of_node_put(root);
> +
> +	if (pcictrl == NULL) {
> +		printk(KERN_WARNING EFIKA_PLATFORM_NAME
> +		       ": Unable to find the PCI bridge node\n");
> +		of_node_put(pcictrl);
> +		return;
> +	}


Oups...

By the way, take advantage of this one
http://patchwork.ozlabs.org/linuxppc/patch?id=7648

It means, it won't work if you source tree doesn't include this.

Regards,

--------------060907010700020809040605
Content-Type: text/plain;
 name="archpowerpc_efika.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="archpowerpc_efika.patch"

--- a/arch/powerpc/platforms/efika/setup.c	1970-01-01 01:00:00.000000000 +0100
+++ b/arch/powerpc/platforms/efika/setup.c	2006-11-03 08:25:34.000000000 +0100
@@ -0,0 +1,166 @@
+/*
+ *
+ * Efika 5K2 platform setup
+ * Some code really inspired from the lite5200b platform.
+ * 
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ */
+
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/ptrace.h>
+#include <linux/slab.h>
+#include <linux/user.h>
+#include <linux/interrupt.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/utsrelease.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/console.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/initrd.h>
+#include <linux/module.h>
+#include <linux/timer.h>
+
+#include <asm/pgtable.h>
+#include <asm/prom.h>
+#include <asm/dma.h>
+#include <asm/machdep.h>
+#include <asm/irq.h>
+#include <asm/sections.h>
+#include <asm/time.h>
+#include <asm/rtas.h>
+#include <asm/of_device.h>
+#include <asm/mpc52xx.h>
+
+#include "efika.h"
+
+static void efika_show_cpuinfo(struct seq_file *m)
+{
+	struct device_node *root;
+	const char *revision = NULL;
+	const char *codegendescription = NULL;
+	const char *codegenvendor = NULL;
+
+	root = of_find_node_by_path("/");
+	if (root) {
+		revision = get_property(root, "revision", NULL);
+		codegendescription =
+		    get_property(root, "CODEGEN,description", NULL);
+		codegenvendor = get_property(root, "CODEGEN,vendor", NULL);
+	}
+
+	of_node_put(root);
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
+		ppc_md.progress("Linux/PPC " UTS_RELEASE " runnung on Efika ;-)\n", 0x0);
+}
+
+static void __init efika_init_IRQ(void)
+{
+	mpc52xx_init_irq();
+}
+
+static void __init efika_init(void)
+{
+	struct device_node *np;
+	struct device_node *cnp = NULL;
+	const u32 *base;
+	char *name;
+
+	/* Find every child of the SOC node and add it to of_platform */
+	np = of_find_node_by_name(NULL, "builtin");
+	if (np) {
+		while ((cnp = of_get_next_child(np, cnp))) {
+			name = kmalloc(BUS_ID_SIZE, GFP_KERNEL);
+			if (name == NULL)
+				continue;
+
+			strcpy(name, cnp->name);
+
+			base = get_property(cnp, "reg", NULL);
+			if (base == NULL) {
+				kfree(name);
+				continue;
+			}
+
+			sprintf(name+strlen(name), "@%x", *base);
+			of_platform_device_create(cnp, name, NULL);
+
+			printk(KERN_INFO ": Added %s (%s) to the known devices\n", name, cnp->full_name);
+		}
+	}
+
+	if (ppc_md.progress)
+		ppc_md.progress("  Have fun with your Efika!    ", 0x7777);
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
+	.name = EFIKA_PLATFORM_NAME,
+	.probe = efika_probe,
+	.setup_arch = efika_setup_arch,
+	.init = efika_init,
+	.show_cpuinfo = efika_show_cpuinfo,
+	.init_IRQ = efika_init_IRQ,
+	.get_irq = mpc52xx_get_irq,
+	.restart = rtas_restart,
+	.power_off = rtas_power_off,
+	.halt = rtas_halt,
+	.set_rtc_time = rtas_set_rtc_time,
+	.get_rtc_time = rtas_get_rtc_time,
+	.progress = rtas_progress,
+	.get_boot_time = rtas_get_boot_time,
+	.calibrate_decr = generic_calibrate_decr,
+	.phys_mem_access_prot = pci_phys_mem_access_prot,
+};
--- a/arch/powerpc/platforms/efika/pci.c	1970-01-01 01:00:00.000000000 +0100
+++ b/arch/powerpc/platforms/efika/pci.c	2006-11-03 08:26:08.000000000 +0100
@@ -0,0 +1,119 @@
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/string.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/sections.h>
+#include <asm/pci-bridge.h>
+#include <asm/rtas.h>
+
+#include "efika.h"
+
+#ifdef CONFIG_PCI
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
--- a/arch/powerpc/platforms/efika/efika.h	1970-01-01 01:00:00.000000000 +0100
+++ b/arch/powerpc/platforms/efika/efika.h	2006-11-02 17:54:37.000000000 +0100
@@ -0,0 +1,19 @@
+/*
+ * Efika 5K2 platform setup - Header file
+ *
+ * Copyright (C) 2006 bplan GmbH
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ */
+
+#ifndef __ARCH_POWERPC_EFIKA__
+#define __ARCH_POWERPC_EFIKA__
+
+#define EFIKA_PLATFORM_NAME "Efika"
+
+extern void __init efika_pcisetup(void);
+
+#endif
--- a/arch/powerpc/platforms/efika/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ b/arch/powerpc/platforms/efika/Makefile	2006-11-02 17:55:29.000000000 +0100
@@ -0,0 +1 @@
+obj-y += setup.o pci.o
--- a/arch/powerpc/platforms/Makefile	2006-11-01 09:18:43.000000000 +0100
+++ b/arch/powerpc/platforms/Makefile	2006-11-02 17:54:37.000000000 +0100
@@ -6,6 +6,7 @@ obj-$(CONFIG_PPC_PMAC)		+= powermac/
 endif
 endif
 obj-$(CONFIG_PPC_CHRP)		+= chrp/
+obj-$(CONFIG_PPC_EFIKA)          += efika/
 obj-$(CONFIG_4xx)		+= 4xx/
 obj-$(CONFIG_PPC_83xx)		+= 83xx/
 obj-$(CONFIG_PPC_85xx)		+= 85xx/
--- a/arch/powerpc/boot/Makefile	2006-11-01 09:18:42.000000000 +0100
+++ b/arch/powerpc/boot/Makefile	2006-10-31 12:31:55.000000000 +0100
@@ -115,7 +115,7 @@ endif
 quiet_cmd_wrap	= WRAP    $@
       cmd_wrap	=$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) vmlinux
 quiet_cmd_wrap_initrd = WRAP    $@
-      cmd_wrap_initrd =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
+      cmd_wrap_initrd =$(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
 				-i $(obj)/ramdisk.image.gz vmlinux
 
 $(obj)/zImage.chrp: vmlinux $(wrapperbits)
@@ -155,6 +155,7 @@ image-$(CONFIG_PPC_PSERIES)		+= zImage.p
 image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
 image-$(CONFIG_PPC_IBM_CELL_BLADE)	+= zImage.pseries
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
+image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 
--- a/arch/powerpc/Kconfig	2006-11-01 09:18:42.000000000 +0100
+++ b/arch/powerpc/Kconfig	2006-11-02 17:55:20.000000000 +0100
@@ -386,6 +386,14 @@ config PPC_CHRP
 	select PPC_UDBG_16550
 	default y
 
+config PPC_EFIKA
+	bool "bPlan Efika 5k2. MPC5200B based computer"
+	depends on PPC_MULTIPLATFORM && PPC32
+	select PPC_RTAS
+	select RTAS_PROC
+	select PPC_MPC52xx
+	default y
+
 config PPC_PMAC
 	bool "Apple PowerMac based machines"
 	depends on PPC_MULTIPLATFORM

--------------060907010700020809040605
Content-Type: text/x-vcard; charset=utf-8;
 name="nd.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nd.vcf"

begin:vcard
fn:Nicolas DET ( bplan GmbH )
n:DET;Nicolas
org:bplan GmbH
adr:;;;;;;Germany
email;internet:nd@bplan-gmbh.de
title:Software Entwicklung
tel;work:+49 6171 9187 - 31
x-mozilla-html:FALSE
url:http://www.bplan-gmbh.de
version:2.1
end:vcard


--------------060907010700020809040605--
