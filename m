Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 2BC72DE2C6
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 00:55:00 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 07 Jan 2009 14:54:57 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20090107135457.234150@gmx.net>
MIME-Version: 1.0
Subject: [PATCH 1/5] powerpc: Add platform support for AmigaOne
To: linuxppc-dev@ozlabs.org
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
 arch/powerpc/platforms/amigaone/setup.c  |  197 ++++++++++++++++++++++++++++++
 5 files changed, 218 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/amigaone/Kconfig
 create mode 100644 arch/powerpc/platforms/amigaone/Makefile
 create mode 100644 arch/powerpc/platforms/amigaone/setup.c

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 47fe2be..3fce996 100644
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
index 0000000..30c9b46
--- /dev/null
+++ b/arch/powerpc/platforms/amigaone/setup.c
@@ -0,0 +1,197 @@
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
+#include <linux/delay.h>
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
+void amigaone_show_cpuinfo(struct seq_file *m)
+{
+	struct device_node *root;
+	const char *model = "";
+
+	root = of_find_node_by_path("/");
+	if (root)
+		model = of_get_property(root, "model", NULL);
+	seq_printf(m, "machine\t\t: %s\n", model);
+
+	of_node_put(root);
+	return;
+}
+
+static int __init amigaone_add_bridge(struct device_node *dev)
+{
+	int len;
+	struct pci_controller *hose;
+	const int *bus_range;
+
+	printk(KERN_INFO "Adding PCI host bridge %s\n", dev->full_name);
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
+	setup_indirect_pci(hose, 0xfec00cf8, 0xfee00cfc, 0);
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
+
+	/* Initialization until calibrate_delay() runs. */
+	loops_per_jiffy = 50000000/HZ;
+
+	/* Lookup PCI host bridges. */
+	for_each_compatible_node(np, "pci", "mai-logic,articia-s")
+		amigaone_add_bridge(np);
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
+/* Copied from U-Boot. */
+static inline void amigaone_soft_restart(unsigned long addr)
+{
+	/* SRR0 has system reset vector, SRR1 has default MSR value.
+	 * rfi restores MSR from SRR1 and sets the PC to the SRR0 value.
+	 */
+	__asm__ __volatile__ ("mtspr	26, %0"		:: "r" (addr));
+	__asm__ __volatile__ ("li	4, (1 << 6)"	::: "r4");
+	__asm__ __volatile__ ("mtspr	27, 4");
+	__asm__ __volatile__ ("rfi");
+}
+
+void amigaone_restart(char *cmd)
+{
+	unsigned long addr;
+
+	local_irq_disable();
+
+	/* Flush and disable I/D cache. */
+	__asm__ __volatile__ ("mfspr	3, 1008"	::: "r3");
+	__asm__ __volatile__ ("ori	5, 5, 0xcc00"	::: "r5");
+	__asm__ __volatile__ ("ori	4, 3, 0xc00"	::: "r4");
+	__asm__ __volatile__ ("andc	5, 3, 5"	::: "r5");
+	__asm__ __volatile__ ("sync");
+	__asm__ __volatile__ ("mtspr	1008, 4");
+	__asm__ __volatile__ ("isync");
+	__asm__ __volatile__ ("sync");
+	__asm__ __volatile__ ("mtspr	1008, 5");
+	__asm__ __volatile__ ("isync");
+	__asm__ __volatile__ ("sync");
+
+	addr = 0xfff00100;
+	amigaone_soft_restart(addr);
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
+		/* Coherent memory access cause complete system lockup! Thus
+		 * disable this CPU feature, even if the CPU needs it. The L2
+		 * cache prefetch engines sould be disabled later on.
+		 */
+		cur_cpu_spec->cpu_features &= ~CPU_FTR_NEED_COHERENT;
+
+		/* Patch out unwanted feature. */
+		do_feature_fixups(cur_cpu_spec->cpu_features,
+		                  PTRRELOC(&__start___ftr_fixup),
+		                  PTRRELOC(&__stop___ftr_fixup));
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
1.5.6.5


-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört? Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger
