Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 23B33DDDA0
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 09:20:51 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 10 Feb 2009 23:20:49 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20090210222049.44270@gmx.net>
MIME-Version: 1.0
Subject: [PATCH v3 1/4] powerpc: Add platform support for AmigaOne
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This commit adds the setup code for booting Linux on AmigaOne G3SE (G3
only), AmigaOne XE and uA1 (G3/G4) desktop computers. These boards were
sold by Eyetech and are based on MAI Logic's Teron boards and its
Articia S northbridge.
The AmigaOne uses U-boot as firmware, which doesn't support a flattened
device tree yet. The northbridge has some design flaws, which makes it
necessary to use non cacheable memory for DMA operations
(CONFIG_NOT_COHERENT_CACHE) and to avoid setting the coherence (M) flag
for memory pages.

Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
---
 arch/powerpc/platforms/Kconfig           |    1 +
 arch/powerpc/platforms/Makefile          |    1 +
 arch/powerpc/platforms/amigaone/Kconfig  |   18 +++
 arch/powerpc/platforms/amigaone/Makefile |    1 +
 arch/powerpc/platforms/amigaone/setup.c  |  170 ++++++++++++++++++++++++++++++
 5 files changed, 191 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/amigaone/Kconfig
 create mode 100644 arch/powerpc/platforms/amigaone/Makefile
 create mode 100644 arch/powerpc/platforms/amigaone/setup.c

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 200b9cb..b25404c 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -28,6 +28,7 @@ source "arch/powerpc/platforms/86xx/Kconfig"
 source "arch/powerpc/platforms/embedded6xx/Kconfig"
 source "arch/powerpc/platforms/44x/Kconfig"
 source "arch/powerpc/platforms/40x/Kconfig"
+source "arch/powerpc/platforms/amigaone/Kconfig"
 
 config PPC_NATIVE
 	bool
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index 8079e0b..f741919 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_PPC_PASEMI)	+= pasemi/
 obj-$(CONFIG_PPC_CELL)		+= cell/
 obj-$(CONFIG_PPC_PS3)		+= ps3/
 obj-$(CONFIG_EMBEDDED6xx)	+= embedded6xx/
+obj-$(CONFIG_AMIGAONE)		+= amigaone/
diff --git a/arch/powerpc/platforms/amigaone/Kconfig b/arch/powerpc/platforms/amigaone/Kconfig
new file mode 100644
index 0000000..9276a96
--- /dev/null
+++ b/arch/powerpc/platforms/amigaone/Kconfig
@@ -0,0 +1,18 @@
+config AMIGAONE
+	bool "Eyetech AmigaOne/MAI Teron"
+	depends on PPC32 && BROKEN_ON_SMP && PPC_MULTIPLATFORM
+	select PPC_I8259
+	select PPC_INDIRECT_PCI
+	select PPC_UDBG_16550
+	select PCI
+	select NOT_COHERENT_CACHE
+	select CHECK_CACHE_COHERENCY
+	select DEFAULT_UIMAGE
+	select PCSPKR_PLATFORM
+	help
+	Select AmigaOne for the following machines:
+	- AmigaOne SE/Teron CX (G3 only)
+	- AmigaOne XE/Teron PX
+	- uA1/Teron mini
+	  More information is available at:
+	  <http://amigaone-linux.sourceforge.net/>.
diff --git a/arch/powerpc/platforms/amigaone/Makefile b/arch/powerpc/platforms/amigaone/Makefile
new file mode 100644
index 0000000..e6885b3
--- /dev/null
+++ b/arch/powerpc/platforms/amigaone/Makefile
@@ -0,0 +1 @@
+obj-y	+= setup.o
diff --git a/arch/powerpc/platforms/amigaone/setup.c b/arch/powerpc/platforms/amigaone/setup.c
new file mode 100644
index 0000000..4430353
--- /dev/null
+++ b/arch/powerpc/platforms/amigaone/setup.c
@@ -0,0 +1,170 @@
+/*
+ * AmigaOne platform setup
+ *
+ * Copyright 2008 Gerhard Pircher (gerhard_pircher@gmx.net)
+ *
+ *   Based on original amigaone_setup.c source code
+ * Copyright 2003 by Hans-Joerg Frieden and Thomas Frieden
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/seq_file.h>
+#include <linux/utsrelease.h>
+
+#include <asm/machdep.h>
+#include <asm/cputable.h>
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+#include <asm/i8259.h>
+#include <asm/time.h>
+#include <asm/udbg.h>
+
+extern void __flush_disable_L1(void);
+
+void amigaone_show_cpuinfo(struct seq_file *m)
+{
+	seq_printf(m, "vendor\t\t: Eyetech Ltd.\n");
+}
+
+static int __init amigaone_add_bridge(struct device_node *dev)
+{
+	const u32 *cfg_addr, *cfg_data;
+	int len;
+	const int *bus_range;
+	struct pci_controller *hose;
+
+	printk(KERN_INFO "Adding PCI host bridge %s\n", dev->full_name);
+
+	cfg_addr = of_get_address(dev, 0, NULL, NULL);
+	cfg_data = of_get_address(dev, 1, NULL, NULL);
+	if ((cfg_addr == NULL) || (cfg_data == NULL))
+		return -ENODEV;
+
+	bus_range = of_get_property(dev, "bus-range", &len);
+	if ((bus_range == NULL) || (len < 2 * sizeof(int)))
+		printk(KERN_WARNING "Can't get bus-range for %s, assume"
+		       " bus 0\n", dev->full_name);
+
+	hose = pcibios_alloc_controller(dev);
+	if (hose == NULL)
+		return -ENOMEM;
+
+	hose->first_busno = bus_range ? bus_range[0] : 0;
+	hose->last_busno = bus_range ? bus_range[1] : 0xff;
+
+	setup_indirect_pci(hose, cfg_addr[0], cfg_data[0], 0);
+
+	/* Interpret the "ranges" property */
+	/* This also maps the I/O region and sets isa_io/mem_base */
+	pci_process_bridge_OF_ranges(hose, dev, 1);
+
+	return 0;
+}
+
+void __init amigaone_setup_arch(void)
+{
+	struct device_node *np;
+	int phb = -ENODEV;
+
+	/* Lookup PCI host bridges. */
+	for_each_compatible_node(np, "pci", "mai-logic,articia-s")
+		phb = amigaone_add_bridge(np);
+
+	BUG_ON(phb != 0);
+
+	if (ppc_md.progress)
+		ppc_md.progress("Linux/PPC "UTS_RELEASE"\n", 0);
+}
+
+void __init amigaone_init_IRQ(void)
+{
+	struct device_node *pic, *np = NULL;
+	const unsigned long *prop = NULL;
+	unsigned long int_ack = 0;
+
+	/* Search for ISA interrupt controller. */
+	pic = of_find_compatible_node(NULL, "interrupt-controller",
+	                              "pnpPNP,000");
+	BUG_ON(pic == NULL);
+
+	/* Look for interrupt acknowledge address in the PCI root node. */
+	np = of_find_compatible_node(NULL, "pci", "mai-logic,articia-s");
+	if (np) {
+		prop = of_get_property(np, "8259-interrupt-acknowledge", NULL);
+		if (prop)
+			int_ack = prop[0];
+		of_node_put(np);
+	}
+
+	if (int_ack == 0)
+		printk(KERN_WARNING "Cannot find PCI interrupt acknowledge"
+		       " address, polling\n");
+
+	i8259_init(pic, int_ack);
+	ppc_md.get_irq = i8259_irq;
+	irq_set_default_host(i8259_get_host());
+}
+
+void __init amigaone_init(void)
+{
+	request_region(0x00, 0x20, "dma1");
+	request_region(0x40, 0x20, "timer");
+	request_region(0x80, 0x10, "dma page reg");
+	request_region(0xc0, 0x20, "dma2");
+}
+
+void amigaone_restart(char *cmd)
+{
+	local_irq_disable();
+
+	/* Flush and disable caches. */
+	__flush_disable_L1();
+
+        /* Set SRR0 to the reset vector and turn on MSR_IP. */
+	mtspr(SPRN_SRR0, 0xfff00100);
+	mtspr(SPRN_SRR1, MSR_IP);
+
+	/* Do an rfi to jump back to firmware. */
+	__asm__ __volatile__("rfi" : : : "memory");
+
+	/* Not reached. */
+	while (1);
+}
+
+static int __init amigaone_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "eyetech,amigaone")) {
+		/*
+		 * Coherent memory access cause complete system lockup! Thus
+		 * disable this CPU feature, even if the CPU needs it.
+		 */
+		cur_cpu_spec->cpu_features &= ~CPU_FTR_NEED_COHERENT;
+
+		ISA_DMA_THRESHOLD = 0x00ffffff;
+		DMA_MODE_READ = 0x44;
+		DMA_MODE_WRITE = 0x48;
+
+		return 1;
+	}
+
+	return 0;
+}
+
+define_machine(amigaone) {
+	.name			= "AmigaOne",
+	.probe			= amigaone_probe,
+	.setup_arch		= amigaone_setup_arch,
+	.init			= amigaone_init,
+	.show_cpuinfo		= amigaone_show_cpuinfo,
+	.init_IRQ		= amigaone_init_IRQ,
+	.restart		= amigaone_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
-- 
1.5.3.4


-- 
Jetzt 1 Monat kostenlos! GMX FreeDSL - Telefonanschluss + DSL 
für nur 17,95 Euro/mtl.!* http://dsl.gmx.de/?ac=OM.AD.PD003K11308T4569a
