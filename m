Return-Path: <nd@bplan-gmbh.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.188])
	by ozlabs.org (Postfix) with ESMTP id 579A667B75
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Nov 2006 07:04:31 +1100 (EST)
Date: Tue, 31 Oct 2006 21:04:25 +0100 (MET)
Message-ID: <4547AC30.3090208@bplan-gmbh.de>
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Nicolas DET <nd@bplan-gmbh.de>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt
	controller	support	for	ARCH=powerpc
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>		<7BDB728E-0CC2-4940-9856-B496022F3482@kernel.crashing.org>		<4546F7DE.6070104@bplan-gmbh.de>		<1162280335.25682.302.camel@localhost.localdomain>		<4547086D.2050808@bplan-gmbh.de>	<1162284176.25682.320.camel@localhost.localdomain>
	<454712A4.3000501@bplan-gmbh.de>
In-Reply-To: <454712A4.3000501@bplan-gmbh.de>
Content-Type: multipart/mixed; boundary="------------080407010506090501010402"
Cc: linuxppc-embedded@ozlabs.org, sl@bplan-gmbh.de, sha@pengutronix.de,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080407010506090501010402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nicolas DET wrote:
> Benjamin Herrenschmidt wrote:
>> On Tue, 2006-10-31 at 09:25 +0100, Nicolas DET wrote:
>>
>>> Ok. By the way, the mbar is include as property in our OpenFrimware. 
>>> Moreover, the G2CORE CPU has a new SPR 'MBAR' which is the MBAR ;-). 
>>> It would maybe make sense to create a new file 
>>> (arch/powerpc/sysdev/mpc52xx.c) which would contain chip specific code.
>>>
>>> Like mpc52xx_get_mbar(), mpc52xx_get_ipbfreq(), etc...
>>>
>>> I updated a bit the patches. I applied Dale requests.
>>> My kernel still compiles and boots. ;-)
>>>
>>> Should I post the new patches?
>>
>> Sure.
>>
> 
> Ok. Should be done this morning.
> 

Here is is ;-).
As my mailer can insert a file, I copy paste. I hope it's still ok...

archpowerpc_efika.patch
-----------------------
--- a/arch/powerpc/platforms/efika/setup.c	1970-01-01 01:00:00.000000000 
+0100
+++ b/arch/powerpc/platforms/efika/setup.c	2006-10-31 12:31:55.000000000 
+0100
@@ -0,0 +1,153 @@
+/*
+ *
+ * Efika 5K2 platform setup
+ *
+ * Copyright (C) 2006 bplan GmbH
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
+#include <asm/mpc52xx.h>
+
+#include "efika.h"
+
+void rtas_indicator_progress(char *, unsigned short);
+
+extern unsigned long loops_per_jiffy;
+
+static void efika_show_cpuinfo(struct seq_file *m)
+{
+	struct device_node *root;
+	const char *revision = NULL;
+	const char *codegendescription = NULL;
+	const char *codegenvendor = NULL;
+
+	root = find_path_device("/");
+	if (root) {
+		revision = get_property(root, "revision", NULL);
+		codegendescription =
+		    get_property(root, "CODEGEN,description", NULL);
+		codegenvendor = get_property(root, "CODEGEN,vendor", NULL);
+	}
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
+	/* init to some ~sane value until calibrate_delay() runs */
+	loops_per_jiffy = 50000000 / HZ;
+
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
+	pci_create_OF_bus_map();
+
+	efika_pcisetup();
+
+	if (ppc_md.progress)
+		ppc_md.progress("Linux/PPC " UTS_RELEASE " runnung on Efika ;-)\n", 0x0);
+}
+
+static void __init efika_init_IRQ(void)
+{
+	of_irq_map_init(0);
+	mpc52xx_init_irq();
+}
+
+static void __init efika_init(void)
+{
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
+	/*
+	 * Others values (isa_mem_base, pci_dram_base) are 0
+	 * in CHRP for us. Only isa_io_base is changed.
+	*/
+	isa_io_base = CHRP_ISA_IO_BASE;
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
+	.pcibios_fixup = efika_pciirq_map,
+};
--- a/arch/powerpc/platforms/efika/pci.c	1970-01-01 01:00:00.000000000 +0100
+++ b/arch/powerpc/platforms/efika/pci.c	2006-10-31 12:31:55.000000000 +0100
@@ -0,0 +1,150 @@
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/ide.h>
+
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/irq.h>
+#include <asm/hydra.h>
+#include <asm/prom.h>
+#include <asm/gg2.h>
+#include <asm/machdep.h>
+#include <asm/sections.h>
+#include <asm/pci-bridge.h>
+#include <asm/grackle.h>
+#include <asm/rtas.h>
+
+#include "efika.h"
+
+static struct device_node *efika_pcictrl;
+
+/*
+ * Access functions for PCI config space using RTAS calls.
+ */
+static int rtas_read_config(struct pci_bus *bus, unsigned int devfn, 
int offset,
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
+	if (pcictrl == NULL) {
+		printk(KERN_WARNING EFIKA_PLATFORM_NAME
+		       ": Unable to find the PCI bridge node\n");
+		return;
+	}
+
+	efika_pcictrl = pcictrl;
+
+	bus_range = get_property(pcictrl, "bus-range", &len);
+	if (bus_range == NULL || len < 2 * sizeof(int)) {
+		printk(KERN_WARNING EFIKA_PLATFORM_NAME
+		       ": Can't get bus-range for %s\n", pcictrl->full_name);
+		return;
+	}
+	if (bus_range[1] == bus_range[0])
+		printk(KERN_INFO EFIKA_PLATFORM_NAME ": PCI bus %d",
+		       bus_range[0]);
+	else
+		printk(KERN_INFO EFIKA_PLATFORM_NAME ": PCI buses %d..%d",
+		       bus_range[0], bus_range[1]);
+	printk(" controlled by %s", pcictrl->full_name);
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
+	hose->arch_data = pcictrl;
+	hose->first_busno = bus_range[0];
+	hose->last_busno = bus_range[1];
+	hose->ops = &rtas_pci_ops;
+
+	pci_process_bridge_OF_ranges(hose, pcictrl, 0);
+}
+
+void __init efika_pciirq_map(void)
+{
+	struct device_node *pcictrl = efika_pcictrl;
+	struct pci_dev *pdev = NULL;
+	struct device_node *ofwdev;
+
+	if (pcictrl == NULL)
+		return;
+
+	/*
+	 * We need to find PCI irq, create a virtual mapping, and set
+	 * the irq number into the PCI structure (software/Linux side)
+	 * I could to this by walking into the /pci node, do
+	 * of_irq_map_pci(), irq_create_of_mapping(), then find
+	 * the good 'struct pci_dev *' and update pci_dev->irq.
+	 * However, pci_read_irq_line() should do everything correctly!
+	*/
+
+	for_each_pci_dev(pdev)
+	{
+		if (pci_read_irq_line(pdev) < 0)
+			continue;
+
+		ofwdev = pci_device_to_OF_node(pdev);
+		if (ofwdev)
+			printk(KERN_INFO EFIKA_PLATFORM_NAME ": got IRQ 0x%x for '%s'\n", 
pdev->irq, ofwdev->full_name);
+	}
+
+}
--- a/arch/powerpc/platforms/efika/efika.h	1970-01-01 01:00:00.000000000 
+0100
+++ b/arch/powerpc/platforms/efika/efika.h	2006-10-31 12:31:55.000000000 
+0100
@@ -0,0 +1,20 @@
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
+void __init efika_pcisetup(void);
+void __init efika_pciirq_map(void);
+
+#endif
--- a/arch/powerpc/platforms/efika/Makefile	1970-01-01 
01:00:00.000000000 +0100
+++ b/arch/powerpc/platforms/efika/Makefile	2006-10-31 
20:03:05.000000000 +0100
@@ -0,0 +1 @@
+obj-y += setup.o pci.o
--- a/arch/powerpc/platforms/Makefile	2006-10-31 20:28:06.000000000 +0100
+++ b/arch/powerpc/platforms/Makefile	2006-10-31 12:31:55.000000000 +0100
@@ -6,6 +6,7 @@ obj-$(CONFIG_PPC_PMAC)		+= powermac/
  endif
  endif
  obj-$(CONFIG_PPC_CHRP)		+= chrp/
+obj-$(CONFIG_PPC_EFIKA)		+= efika/
  obj-$(CONFIG_4xx)		+= 4xx/
  obj-$(CONFIG_PPC_83xx)		+= 83xx/
  obj-$(CONFIG_PPC_85xx)		+= 85xx/
--- a/arch/powerpc/boot/Makefile	2006-10-25 19:07:23.000000000 +0200
+++ b/arch/powerpc/boot/Makefile	2006-10-31 12:31:55.000000000 +0100
@@ -155,6 +155,7 @@ image-$(CONFIG_PPC_PSERIES)		+= zImage.p
  image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
  image-$(CONFIG_PPC_IBM_CELL_BLADE)	+= zImage.pseries
  image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
+image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
  image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
  image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage

--- a/arch/powerpc/Kconfig	2006-10-31 20:28:06.000000000 +0100
+++ b/arch/powerpc/Kconfig	2006-10-31 19:57:57.000000000 +0100
@@ -386,6 +386,19 @@ config PPC_CHRP
  	select PPC_UDBG_16550
  	default y

+config PPC_MPC52xx_PIC
+        bool
+	default y
+
+config PPC_EFIKA
+	bool "bPlan Efika 5k2. MPC5200B based computer"
+	depends on PPC_MULTIPLATFORM && PPC32
+	select PPC_RTAS
+	select RTAS_PROC
+	select PPC_MPC52xx
+	select PPC_MPC52xx_PIC
+	default y
+
  config PPC_PMAC
  	bool "Apple PowerMac based machines"
  	depends on PPC_MULTIPLATFORM


archpowerpc_mpc52xx.patch
-------------------------
--- a/arch/powerpc/sysdev/mpc52xx_pic.c	1970-01-01 01:00:00.000000000 +0100
+++ b/arch/powerpc/sysdev/mpc52xx_pic.c	2006-10-31 19:56:22.000000000 +0100
@@ -0,0 +1,511 @@
+/*
+ *
+ * Programmable Interrupt Controller functions for the Freescale MPC52xx.
+ *
+ * Copyright (C) 2006 bplan GmbH
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ */
+
+#undef DEBUG
+
+#include <linux/stddef.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/stddef.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/hardirq.h>
+
+#include <asm/io.h>
+#include <asm/processor.h>
+#include <asm/system.h>
+#include <asm/irq.h>
+#include <asm/prom.h>
+#include <asm/mpc52xx.h>
+
+static struct mpc52xx_intr __iomem *intr;
+static struct mpc52xx_sdma __iomem *sdma;
+static struct irq_host *mpc52xx_irqhost = NULL;
+
+static unsigned char mpc52xx_map_senses[4] = {
+	IRQ_TYPE_LEVEL_HIGH,
+	IRQ_TYPE_EDGE_FALLING,
+	IRQ_TYPE_EDGE_RISING,
+	IRQ_TYPE_LEVEL_LOW,
+};
+
+/*
+ *
+*/
+
+static inline void io_be_setbit(u32 __iomem *addr, int bitno)
+{
+	out_be32(addr, in_be32(addr) | (1 << bitno) );
+}
+
+static inline void io_be_clrbit(u32 __iomem *addr, int bitno)
+{
+	out_be32(addr, in_be32(addr) & ~(1 << bitno));
+}
+
+/*
+ * Critial interrupt irq_chip
+*/
+static void mpc52xx_crit_mask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x, l2=%d\n", __func__, irq, l2irq);
+
+	BUG_ON(l2irq != 0);
+
+	io_be_clrbit(&intr->ctrl, 11);
+}
+
+static void mpc52xx_crit_unmask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	BUG_ON(l2irq != 0);
+
+	io_be_setbit(&intr->ctrl, 11);
+}
+
+static void mpc52xx_crit_ack(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	BUG_ON(l2irq != 0);
+
+	io_be_setbit(&intr->ctrl, 27);
+}
+
+static struct irq_chip mpc52xx_crit_irqchip = {
+	.typename = "MPC52xx IRQ0",
+	.mask = mpc52xx_crit_mask,
+	.unmask = mpc52xx_crit_unmask,
+	.ack = mpc52xx_crit_ack,
+};
+
+/*
+ * IRQ[1-3] interrupt irq_chip
+*/
+
+static void mpc52xx_mainirq_mask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_clrbit(&intr->ctrl, 11 - l2irq);
+}
+
+static void mpc52xx_mainirq_unmask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_setbit(&intr->ctrl, 11 - l2irq);
+}
+
+static void mpc52xx_mainirq_ack(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_setbit(&intr->ctrl, 27-l2irq);
+}
+
+static struct irq_chip mpc52xx_mainirq_irqchip = {
+	.typename = " MPC52xx IRQ[1-3] ",
+	.mask = mpc52xx_mainirq_mask,
+	.unmask = mpc52xx_mainirq_unmask,
+	.ack = mpc52xx_mainirq_ack,
+};
+
+/*
+ * Main interrupt irq_chip
+*/
+
+static void mpc52xx_main_mask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_setbit(&intr->main_mask, 15 - l2irq);
+}
+
+static void mpc52xx_main_unmask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_clrbit(&intr->main_mask, 15 - l2irq);
+}
+
+static struct irq_chip mpc52xx_main_irqchip = {
+	.typename = "MPC52xx Main",
+	.mask = mpc52xx_main_mask,
+	.mask_ack = mpc52xx_main_mask,
+	.unmask = mpc52xx_main_unmask,
+};
+
+/*
+ * Peripherals interrupt irq_chip
+*/
+
+static void mpc52xx_periph_mask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_setbit(&intr->per_mask, 31 - l2irq);
+}
+
+static void mpc52xx_periph_unmask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_clrbit(&intr->per_mask, 31 - l2irq);
+}
+
+static struct irq_chip mpc52xx_periph_irqchip = {
+	.typename = "MPC52xx Peripherals",
+	.mask = mpc52xx_periph_mask,
+	.mask_ack = mpc52xx_periph_mask,
+	.unmask = mpc52xx_periph_unmask,
+};
+
+/*
+ * SDMA interrupt irq_chip
+*/
+
+static void mpc52xx_sdma_mask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_setbit(&sdma->IntMask, l2irq);
+}
+
+static void mpc52xx_sdma_unmask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_clrbit(&sdma->IntMask, l2irq);
+}
+
+static void mpc52xx_sdma_ack(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	out_be32(&sdma->IntPend, 1 << l2irq);
+}
+
+static struct irq_chip mpc52xx_sdma_irqchip = {
+	.typename = "MPC52xx SDMA",
+	.mask = mpc52xx_sdma_mask,
+	.unmask = mpc52xx_sdma_unmask,
+	.ack = mpc52xx_sdma_ack,
+};
+
+/*
+ * irq_host
+*/
+
+static int mpc52xx_irqhost_match(struct irq_host *h, struct device_node 
*node)
+{
+	pr_debug("%s: %p vs %p\n", __func__, find_mpc52xx_picnode(), node);
+	return mpc52xx_irqhost->host_data == node;
+}
+
+static int mpc52xx_irqhost_xlate(struct irq_host *h, struct device_node 
*ct,
+				 u32 * intspec, unsigned int intsize,
+				 irq_hw_number_t * out_hwirq,
+				 unsigned int *out_flags)
+{
+	int intrvect_l1;
+	int intrvect_l2;
+	int intrvect_type;
+	int intrvect_linux;
+
+	if (intsize != 3)
+		return -1;
+
+	intrvect_l1 = (int)intspec[0];
+	intrvect_l2 = (int)intspec[1];
+	intrvect_type = (int)intspec[2];
+
+	intrvect_linux =
+	    (intrvect_l1 << MPC52xx_IRQ_L1_OFFSET) & MPC52xx_IRQ_L1_MASK;
+	intrvect_linux |=
+	    (intrvect_l2 << MPC52xx_IRQ_L2_OFFSET) & MPC52xx_IRQ_L2_MASK;
+
+	pr_debug("return %x, l1=%d, l2=%d\n", intrvect_linux, intrvect_l1,
+		 intrvect_l2);
+
+	*out_hwirq = intrvect_linux;
+	*out_flags = mpc52xx_map_senses[intrvect_type];
+
+	return 0;
+}
+
+/*
+ * this function retrieves the correct IRQ type out
+ * of the MPC regs
+ * Only externals IRQs needs this
+*/
+static int mpc52xx_irqx_gettype(int irq)
+{
+	int type;
+	u32 ctrl_reg;
+
+	ctrl_reg = in_be32(&intr->ctrl);
+	type = (ctrl_reg >> (22 - irq * 2)) & 0x3;
+
+	return mpc52xx_map_senses[type];
+}
+
+static int mpc52xx_irqhost_map(struct irq_host *h, unsigned int virq,
+			       irq_hw_number_t irq)
+{
+	int l1irq;
+	int l2irq;
+	struct irq_chip *good_irqchip;
+	void *good_handle;
+	int type;
+
+	l1irq = (irq & MPC52xx_IRQ_L1_MASK) >> MPC52xx_IRQ_L1_OFFSET;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	/*
+	 * Most of ours IRQs will be level low
+	 * Only external IRQs on some platform may be others
+	 */
+	type = IRQ_TYPE_LEVEL_LOW;
+
+	switch (l1irq) {
+	case MPC52xx_IRQ_L1_CRIT:
+		pr_debug("%s: Critical. l2=%x\n", __func__, l2irq);
+
+		BUG_ON(l2irq != 0);
+
+		type = mpc52xx_irqx_gettype(l2irq);
+		good_irqchip = &mpc52xx_crit_irqchip;
+		break;
+
+	case MPC52xx_IRQ_L1_MAIN:
+		pr_debug("%s: Main IRQ[1-3] l2=%x\n", __func__, l2irq);
+
+		if ((l2irq >= 0) && (l2irq <= 3)) {
+			type = mpc52xx_irqx_gettype(l2irq);
+			good_irqchip = &mpc52xx_mainirq_irqchip;
+		} else {
+			good_irqchip = &mpc52xx_main_irqchip;
+		}
+		break;
+
+	case MPC52xx_IRQ_L1_PERP:
+		pr_debug("%s: Peripherals. l2=%x\n", __func__, l2irq);
+		good_irqchip = &mpc52xx_periph_irqchip;
+		break;
+
+	case MPC52xx_IRQ_L1_SDMA:
+		pr_debug("%s: SDMA. l2=%x\n", __func__, l2irq);
+		good_irqchip = &mpc52xx_sdma_irqchip;
+		break;
+
+	default:
+		pr_debug("%s: Error, unknown L1 IRQ (0x%x)\n", __func__, l1irq);
+		printk(KERN_ERR "Unknow IRQ!\n");
+		return -EINVAL;
+	}
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_FALLING:
+	case IRQ_TYPE_EDGE_RISING:
+		good_handle = handle_edge_irq;
+		break;
+	default:
+		good_handle = handle_level_irq;
+	}
+
+	set_irq_chip_and_handler(virq, good_irqchip, good_handle);
+
+	pr_debug("%s: virq=%x, hw=%x. type=%x\n", __func__, virq,
+		 (int)irq, type);
+
+	return 0;
+}
+
+static struct irq_host_ops mpc52xx_irqhost_ops = {
+	.match = mpc52xx_irqhost_match,
+	.xlate = mpc52xx_irqhost_xlate,
+	.map = mpc52xx_irqhost_map,
+};
+
+/*
+ * init (public)
+*/
+
+void __init mpc52xx_init_irq(void)
+{
+	u32 intr_ctrl;
+
+	/* Remap the necessary zones */
+	intr = ioremap(MPC52xx_PA(MPC52xx_INTR_OFFSET), MPC52xx_INTR_SIZE);
+	sdma = ioremap(MPC52xx_PA(MPC52xx_SDMA_OFFSET), MPC52xx_SDMA_SIZE);
+
+	if ((intr == NULL) || (sdma == NULL))
+		panic("Can't ioremap PIC/SDMA register or init_irq !");
+
+	/* Disable all interrupt sources. */
+	out_be32(&sdma->IntPend, 0xffffffff);	/* 1 means clear pending */
+	out_be32(&sdma->IntMask, 0xffffffff);	/* 1 means disabled */
+	out_be32(&intr->per_mask, 0x7ffffc00);	/* 1 means disabled */
+	out_be32(&intr->main_mask, 0x00010fff);	/* 1 means disabled */
+	intr_ctrl = in_be32(&intr->ctrl);
+	intr_ctrl &= 0x00ff0000;	/* Keeps IRQ[0-3] config */
+	intr_ctrl |= 0x0f000000 |	/* clear IRQ 0-3 */
+	    0x00001000 |	/* MEE master external enable */
+	    0x00000000 |	/* 0 means disable IRQ 0-3 */
+	    0x00000001;		/* CEb route critical normally */
+	out_be32(&intr->ctrl, intr_ctrl);
+
+	/* Zero a bunch of the priority settings.  */
+	out_be32(&intr->per_pri1, 0);
+	out_be32(&intr->per_pri2, 0);
+	out_be32(&intr->per_pri3, 0);
+	out_be32(&intr->main_pri1, 0);
+	out_be32(&intr->main_pri2, 0);
+
+	/*
+	 * As last step, add an irq host to translate the real
+	 * hw irq information provided by the ofw to linux virq
+	 */
+
+	mpc52xx_irqhost =
+	    irq_alloc_host(IRQ_HOST_MAP_LINEAR, 0xd0,
+			   &mpc52xx_irqhost_ops, -1);
+
+	if (mpc52xx_irqhost)
+		mpc52xx_irqhost->host_data = (void *)find_mpc52xx_picnode();
+}
+
+/*
+ * get_irq (public)
+*/
+unsigned int mpc52xx_get_irq(void)
+{
+	u32 status;
+	int irq = NO_IRQ_IGNORE;
+
+	status = in_be32(&intr->enc_status);
+	if (status & 0x00000400) {	/* critical */
+		irq = (status >> 8) & 0x3;
+		if (irq == 2)	/* high priority peripheral */
+			goto peripheral;
+		irq |=
+		    (MPC52xx_IRQ_L1_CRIT << MPC52xx_IRQ_L1_OFFSET) &
+		    MPC52xx_IRQ_L1_MASK;
+	} else if (status & 0x00200000) {	/* main */
+		irq = (status >> 16) & 0x1f;
+		if (irq == 4)	/* low priority peripheral */
+			goto peripheral;
+		irq |=
+		    (MPC52xx_IRQ_L1_MAIN << MPC52xx_IRQ_L1_OFFSET) &
+		    MPC52xx_IRQ_L1_MASK;
+	} else if (status & 0x20000000) {	/* peripheral */
+	      peripheral:
+		irq = (status >> 24) & 0x1f;
+		if (irq == 0) {	/* bestcomm */
+			status = in_be32(&sdma->IntPend);
+			irq = ffs(status) - 1;
+			irq |=
+			    (MPC52xx_IRQ_L1_SDMA << MPC52xx_IRQ_L1_OFFSET) &
+			    MPC52xx_IRQ_L1_MASK;
+		} else
+			irq |=
+			    (MPC52xx_IRQ_L1_PERP << MPC52xx_IRQ_L1_OFFSET) &
+			    MPC52xx_IRQ_L1_MASK;
+
+	}
+
+	pr_debug("%s: irq=%x. virq=%d\n", __func__, irq,
+		 irq_linear_revmap(mpc52xx_irqhost, irq));
+
+	return irq_linear_revmap(mpc52xx_irqhost, irq);
+}
--- a/arch/powerpc/sysdev/Makefile	2006-10-25 19:07:24.000000000 +0200
+++ b/arch/powerpc/sysdev/Makefile	2006-10-31 19:56:41.000000000 +0100
@@ -13,6 +13,7 @@ obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
  obj-$(CONFIG_PPC_TODC)		+= todc.o
  obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
  obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
+obj-$(CONFIG_PPC_MPC52xx_PIC)	+= mpc52xx_pic.o

  ifeq ($(CONFIG_PPC_MERGE),y)
  obj-$(CONFIG_PPC_I8259)		+= i8259.o
--- a/include/asm-powerpc/mpc52xx.h	1970-01-01 01:00:00.000000000 +0100
+++ b/include/asm-powerpc/mpc52xx.h	2006-10-31 12:31:55.000000000 +0100
@@ -0,0 +1,373 @@
+/*
+ *
+ * Prototypes, etc. for the Freescale MPC52xx embedded cpu chips
+ * May need to be cleaned as the port goes on ...
+ *
+ * Copyright (C) 2004-2005 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2003 MontaVista, Software, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __ASM_POWERPC_MPC52xx_H__
+#define __ASM_POWERPC_MPC52xx_H__
+
+#ifndef __ASSEMBLY__
+#include <asm/types.h>
+#include <asm/prom.h>
+
+#endif				/* __ASSEMBLY__ */
+
+#ifdef CONFIG_PCI
+#define _IO_BASE        isa_io_base
+#define _ISA_MEM_BASE   isa_mem_base
+#define PCI_DRAM_OFFSET pci_dram_offset
+#else
+#define _IO_BASE        0
+#define _ISA_MEM_BASE   0
+#define PCI_DRAM_OFFSET 0
+#endif
+
+/* 
======================================================================== */
+/* Main registers/struct addresses 
      */
+/* 
======================================================================== */
+
+/* MBAR position */
+#define MPC52xx_MBAR		0xf0000000	/* Phys address */
+#define MPC52xx_MBAR_VIRT	0xf0000000	/* Virt address */
+#define MPC52xx_MBAR_SIZE	0x00010000
+
+#define MPC52xx_PA(x)		((phys_addr_t)(MPC52xx_MBAR + (x)))
+#define MPC52xx_VA(x)		((void __iomem *)(MPC52xx_MBAR_VIRT + (x)))
+
+/* Registers zone offset/size  */
+#define MPC52xx_MMAP_CTL_OFFSET		0x0000
+#define MPC52xx_MMAP_CTL_SIZE		0x068
+#define MPC52xx_SDRAM_OFFSET		0x0100
+#define MPC52xx_SDRAM_SIZE		0x010
+#define MPC52xx_CDM_OFFSET		0x0200
+#define MPC52xx_CDM_SIZE		0x038
+#define MPC52xx_INTR_OFFSET		0x0500
+#define MPC52xx_INTR_SIZE		0x04c
+#define MPC52xx_GPTx_OFFSET(x)		(0x0600 + ((x)<<4))
+#define MPC52xx_GPT_SIZE		0x010
+#define MPC52xx_RTC_OFFSET		0x0800
+#define MPC52xx_RTC_SIZE		0x024
+#define MPC52xx_GPIO_OFFSET		0x0b00
+#define MPC52xx_GPIO_SIZE		0x040
+#define MPC52xx_GPIO_WKUP_OFFSET	0x0c00
+#define MPC52xx_GPIO_WKUP_SIZE		0x028
+#define MPC52xx_PCI_OFFSET		0x0d00
+#define MPC52xx_PCI_SIZE		0x100
+#define MPC52xx_SDMA_OFFSET		0x1200
+#define MPC52xx_SDMA_SIZE		0x100
+#define MPC52xx_XLB_OFFSET		0x1f00
+#define MPC52xx_XLB_SIZE		0x100
+#define MPC52xx_PSCx_OFFSET(x)		(((x)!=6)?(0x1e00+((x)<<9)):0x2c00)
+#define MPC52xx_PSC_SIZE		0x0a0
+
+/* SRAM used for SDMA */
+#define MPC52xx_SRAM_OFFSET		0x8000
+#define MPC52xx_SRAM_SIZE		0x4000
+
+/* 
======================================================================== */
+/* IRQ mapping 
      */
+/* 
======================================================================== */
+
+#define MPC52xx_IRQ_L1_CRIT	(0)
+#define MPC52xx_IRQ_L1_MAIN	(1)
+#define MPC52xx_IRQ_L1_PERP	(2)
+#define MPC52xx_IRQ_L1_SDMA	(3)
+
+#define MPC52xx_IRQ_L1_OFFSET   (6)
+#define MPC52xx_IRQ_L1_MASK     (0x00c0)
+
+#define MPC52xx_IRQ_L2_OFFSET   (0)
+#define MPC52xx_IRQ_L2_MASK     (0x003f)
+
+/*
+ * 24 peripherals ints
+ * + 16 mains ints
+ * + 4 crit
+ * + 16 bestcomm task
+ * = 64
+*/
+#define MPC52xx_IRQ_MAXCOUNT     (64)
+
+/* 
======================================================================== */
+/* Structures mapping of some unit register set 
      */
+/* 
======================================================================== */
+
+#ifndef __ASSEMBLY__
+
+/* Memory Mapping Control */
+struct mpc52xx_mmap_ctl {
+	u32 mbar;		/* MMAP_CTRL + 0x00 */
+
+	u32 cs0_start;		/* MMAP_CTRL + 0x04 */
+	u32 cs0_stop;		/* MMAP_CTRL + 0x08 */
+	u32 cs1_start;		/* MMAP_CTRL + 0x0c */
+	u32 cs1_stop;		/* MMAP_CTRL + 0x10 */
+	u32 cs2_start;		/* MMAP_CTRL + 0x14 */
+	u32 cs2_stop;		/* MMAP_CTRL + 0x18 */
+	u32 cs3_start;		/* MMAP_CTRL + 0x1c */
+	u32 cs3_stop;		/* MMAP_CTRL + 0x20 */
+	u32 cs4_start;		/* MMAP_CTRL + 0x24 */
+	u32 cs4_stop;		/* MMAP_CTRL + 0x28 */
+	u32 cs5_start;		/* MMAP_CTRL + 0x2c */
+	u32 cs5_stop;		/* MMAP_CTRL + 0x30 */
+
+	u32 sdram0;		/* MMAP_CTRL + 0x34 */
+	u32 sdram1;		/* MMAP_CTRL + 0X38 */
+
+	u32 reserved[4];	/* MMAP_CTRL + 0x3c .. 0x48 */
+
+	u32 boot_start;		/* MMAP_CTRL + 0x4c */
+	u32 boot_stop;		/* MMAP_CTRL + 0x50 */
+
+	u32 ipbi_ws_ctrl;	/* MMAP_CTRL + 0x54 */
+
+	u32 cs6_start;		/* MMAP_CTRL + 0x58 */
+	u32 cs6_stop;		/* MMAP_CTRL + 0x5c */
+	u32 cs7_start;		/* MMAP_CTRL + 0x60 */
+	u32 cs7_stop;		/* MMAP_CTRL + 0x64 */
+};
+
+/* SDRAM control */
+struct mpc52xx_sdram {
+	u32 mode;		/* SDRAM + 0x00 */
+	u32 ctrl;		/* SDRAM + 0x04 */
+	u32 config1;		/* SDRAM + 0x08 */
+	u32 config2;		/* SDRAM + 0x0c */
+};
+
+/* Interrupt controller */
+struct mpc52xx_intr {
+	u32 per_mask;		/* INTR + 0x00 */
+	u32 per_pri1;		/* INTR + 0x04 */
+	u32 per_pri2;		/* INTR + 0x08 */
+	u32 per_pri3;		/* INTR + 0x0c */
+	u32 ctrl;		/* INTR + 0x10 */
+	u32 main_mask;		/* INTR + 0x14 */
+	u32 main_pri1;		/* INTR + 0x18 */
+	u32 main_pri2;		/* INTR + 0x1c */
+	u32 reserved1;		/* INTR + 0x20 */
+	u32 enc_status;		/* INTR + 0x24 */
+	u32 crit_status;	/* INTR + 0x28 */
+	u32 main_status;	/* INTR + 0x2c */
+	u32 per_status;		/* INTR + 0x30 */
+	u32 reserved2;		/* INTR + 0x34 */
+	u32 per_error;		/* INTR + 0x38 */
+};
+
+/* SDMA */
+struct mpc52xx_sdma {
+	u32 taskBar;		/* SDMA + 0x00 */
+	u32 currentPointer;	/* SDMA + 0x04 */
+	u32 endPointer;		/* SDMA + 0x08 */
+	u32 variablePointer;	/* SDMA + 0x0c */
+
+	u8 IntVect1;		/* SDMA + 0x10 */
+	u8 IntVect2;		/* SDMA + 0x11 */
+	u16 PtdCntrl;		/* SDMA + 0x12 */
+
+	u32 IntPend;		/* SDMA + 0x14 */
+	u32 IntMask;		/* SDMA + 0x18 */
+
+	u16 tcr[16];		/* SDMA + 0x1c .. 0x3a */
+
+	u8 ipr[32];		/* SDMA + 0x3c .. 0x5b */
+
+	u32 cReqSelect;		/* SDMA + 0x5c */
+	u32 task_size0;		/* SDMA + 0x60 */
+	u32 task_size1;		/* SDMA + 0x64 */
+	u32 MDEDebug;		/* SDMA + 0x68 */
+	u32 ADSDebug;		/* SDMA + 0x6c */
+	u32 Value1;		/* SDMA + 0x70 */
+	u32 Value2;		/* SDMA + 0x74 */
+	u32 Control;		/* SDMA + 0x78 */
+	u32 Status;		/* SDMA + 0x7c */
+	u32 PTDDebug;		/* SDMA + 0x80 */
+};
+
+/* GPT */
+struct mpc52xx_gpt {
+	u32 mode;		/* GPTx + 0x00 */
+	u32 count;		/* GPTx + 0x04 */
+	u32 pwm;		/* GPTx + 0x08 */
+	u32 status;		/* GPTx + 0X0c */
+};
+
+/* RTC */
+struct mpc52xx_rtc {
+	u32 time_set;		/* RTC + 0x00 */
+	u32 date_set;		/* RTC + 0x04 */
+	u32 stopwatch;		/* RTC + 0x08 */
+	u32 int_enable;		/* RTC + 0x0c */
+	u32 time;		/* RTC + 0x10 */
+	u32 date;		/* RTC + 0x14 */
+	u32 stopwatch_intr;	/* RTC + 0x18 */
+	u32 bus_error;		/* RTC + 0x1c */
+	u32 dividers;		/* RTC + 0x20 */
+};
+
+/* GPIO */
+struct mpc52xx_gpio {
+	u32 port_config;	/* GPIO + 0x00 */
+	u32 simple_gpioe;	/* GPIO + 0x04 */
+	u32 simple_ode;		/* GPIO + 0x08 */
+	u32 simple_ddr;		/* GPIO + 0x0c */
+	u32 simple_dvo;		/* GPIO + 0x10 */
+	u32 simple_ival;	/* GPIO + 0x14 */
+	u8 outo_gpioe;		/* GPIO + 0x18 */
+	u8 reserved1[3];	/* GPIO + 0x19 */
+	u8 outo_dvo;		/* GPIO + 0x1c */
+	u8 reserved2[3];	/* GPIO + 0x1d */
+	u8 sint_gpioe;		/* GPIO + 0x20 */
+	u8 reserved3[3];	/* GPIO + 0x21 */
+	u8 sint_ode;		/* GPIO + 0x24 */
+	u8 reserved4[3];	/* GPIO + 0x25 */
+	u8 sint_ddr;		/* GPIO + 0x28 */
+	u8 reserved5[3];	/* GPIO + 0x29 */
+	u8 sint_dvo;		/* GPIO + 0x2c */
+	u8 reserved6[3];	/* GPIO + 0x2d */
+	u8 sint_inten;		/* GPIO + 0x30 */
+	u8 reserved7[3];	/* GPIO + 0x31 */
+	u16 sint_itype;		/* GPIO + 0x34 */
+	u16 reserved8;		/* GPIO + 0x36 */
+	u8 gpio_control;	/* GPIO + 0x38 */
+	u8 reserved9[3];	/* GPIO + 0x39 */
+	u8 sint_istat;		/* GPIO + 0x3c */
+	u8 sint_ival;		/* GPIO + 0x3d */
+	u8 bus_errs;		/* GPIO + 0x3e */
+	u8 reserved10;		/* GPIO + 0x3f */
+};
+
+#define MPC52xx_GPIO_PSC_CONFIG_UART_WITHOUT_CD	4
+#define MPC52xx_GPIO_PSC_CONFIG_UART_WITH_CD	5
+#define MPC52xx_GPIO_PCI_DIS			(1<<15)
+
+/* GPIO with WakeUp*/
+struct mpc52xx_gpio_wkup {
+	u8 wkup_gpioe;		/* GPIO_WKUP + 0x00 */
+	u8 reserved1[3];	/* GPIO_WKUP + 0x03 */
+	u8 wkup_ode;		/* GPIO_WKUP + 0x04 */
+	u8 reserved2[3];	/* GPIO_WKUP + 0x05 */
+	u8 wkup_ddr;		/* GPIO_WKUP + 0x08 */
+	u8 reserved3[3];	/* GPIO_WKUP + 0x09 */
+	u8 wkup_dvo;		/* GPIO_WKUP + 0x0C */
+	u8 reserved4[3];	/* GPIO_WKUP + 0x0D */
+	u8 wkup_inten;		/* GPIO_WKUP + 0x10 */
+	u8 reserved5[3];	/* GPIO_WKUP + 0x11 */
+	u8 wkup_iinten;		/* GPIO_WKUP + 0x14 */
+	u8 reserved6[3];	/* GPIO_WKUP + 0x15 */
+	u16 wkup_itype;		/* GPIO_WKUP + 0x18 */
+	u8 reserved7[2];	/* GPIO_WKUP + 0x1A */
+	u8 wkup_maste;		/* GPIO_WKUP + 0x1C */
+	u8 reserved8[3];	/* GPIO_WKUP + 0x1D */
+	u8 wkup_ival;		/* GPIO_WKUP + 0x20 */
+	u8 reserved9[3];	/* GPIO_WKUP + 0x21 */
+	u8 wkup_istat;		/* GPIO_WKUP + 0x24 */
+	u8 reserved10[3];	/* GPIO_WKUP + 0x25 */
+};
+
+/* XLB Bus control */
+struct mpc52xx_xlb {
+	u8 reserved[0x40];
+	u32 config;		/* XLB + 0x40 */
+	u32 version;		/* XLB + 0x44 */
+	u32 status;		/* XLB + 0x48 */
+	u32 int_enable;		/* XLB + 0x4c */
+	u32 addr_capture;	/* XLB + 0x50 */
+	u32 bus_sig_capture;	/* XLB + 0x54 */
+	u32 addr_timeout;	/* XLB + 0x58 */
+	u32 data_timeout;	/* XLB + 0x5c */
+	u32 bus_act_timeout;	/* XLB + 0x60 */
+	u32 master_pri_enable;	/* XLB + 0x64 */
+	u32 master_priority;	/* XLB + 0x68 */
+	u32 base_address;	/* XLB + 0x6c */
+	u32 snoop_window;	/* XLB + 0x70 */
+};
+
+#define MPC52xx_XLB_CFG_PLDIS		(1 << 31)
+#define MPC52xx_XLB_CFG_SNOOP		(1 << 15)
+
+/* Clock Distribution control */
+struct mpc52xx_cdm {
+	u32 jtag_id;		/* CDM + 0x00  reg0 read only */
+	u32 rstcfg;		/* CDM + 0x04  reg1 read only */
+	u32 breadcrumb;		/* CDM + 0x08  reg2 */
+
+	u8 mem_clk_sel;		/* CDM + 0x0c  reg3 byte0 */
+	u8 xlb_clk_sel;		/* CDM + 0x0d  reg3 byte1 read only */
+	u8 ipb_clk_sel;		/* CDM + 0x0e  reg3 byte2 */
+	u8 pci_clk_sel;		/* CDM + 0x0f  reg3 byte3 */
+
+	u8 ext_48mhz_en;	/* CDM + 0x10  reg4 byte0 */
+	u8 fd_enable;		/* CDM + 0x11  reg4 byte1 */
+	u16 fd_counters;	/* CDM + 0x12  reg4 byte2,3 */
+
+	u32 clk_enables;	/* CDM + 0x14  reg5 */
+
+	u8 osc_disable;		/* CDM + 0x18  reg6 byte0 */
+	u8 reserved0[3];	/* CDM + 0x19  reg6 byte1,2,3 */
+
+	u8 ccs_sleep_enable;	/* CDM + 0x1c  reg7 byte0 */
+	u8 osc_sleep_enable;	/* CDM + 0x1d  reg7 byte1 */
+	u8 reserved1;		/* CDM + 0x1e  reg7 byte2 */
+	u8 ccs_qreq_test;	/* CDM + 0x1f  reg7 byte3 */
+
+	u8 soft_reset;		/* CDM + 0x20  u8 byte0 */
+	u8 no_ckstp;		/* CDM + 0x21  u8 byte0 */
+	u8 reserved2[2];	/* CDM + 0x22  u8 byte1,2,3 */
+
+	u8 pll_lock;		/* CDM + 0x24  reg9 byte0 */
+	u8 pll_looselock;	/* CDM + 0x25  reg9 byte1 */
+	u8 pll_sm_lockwin;	/* CDM + 0x26  reg9 byte2 */
+	u8 reserved3;		/* CDM + 0x27  reg9 byte3 */
+
+	u16 reserved4;		/* CDM + 0x28  reg10 byte0,1 */
+	u16 mclken_div_psc1;	/* CDM + 0x2a  reg10 byte2,3 */
+
+	u16 reserved5;		/* CDM + 0x2c  reg11 byte0,1 */
+	u16 mclken_div_psc2;	/* CDM + 0x2e  reg11 byte2,3 */
+
+	u16 reserved6;		/* CDM + 0x30  reg12 byte0,1 */
+	u16 mclken_div_psc3;	/* CDM + 0x32  reg12 byte2,3 */
+
+	u16 reserved7;		/* CDM + 0x34  reg13 byte0,1 */
+	u16 mclken_div_psc6;	/* CDM + 0x36  reg13 byte2,3 */
+};
+
+#endif				/* __ASSEMBLY__ */
+
+/* 
========================================================================= */
+/* Prototypes for MPC52xx syslib 
       */
+/* 
========================================================================= */
+
+#ifndef __ASSEMBLY__
+
+extern void mpc52xx_init_irq(void);
+extern unsigned int mpc52xx_get_irq(void);
+
+static inline struct device_node *find_mpc52xx_picnode(void)
+{
+	return of_find_compatible_node(NULL, "interrupt-controller",
+				       "mpc5200-pic");
+}
+
+	/* Matching of PSC function */
+struct mpc52xx_psc_func {
+	int id;
+	char *func;
+};
+
+extern int mpc52xx_match_psc_function(int psc_idx, const char *func);
+extern struct mpc52xx_psc_func mpc52xx_psc_functions[];
+	/* This array is to be defined in platform file */
+
+#endif				/* __ASSEMBLY__ */
+
+#endif				/* _ASM_POWERPC_MPC52xx_H__ */

--------------080407010506090501010402
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


--------------080407010506090501010402--
