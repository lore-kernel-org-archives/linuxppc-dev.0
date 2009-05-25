Return-Path: <glikely@secretlab.ca>
Received: from mail-px0-f176.google.com (mail-px0-f176.google.com
	[209.85.216.176]) by ozlabs.org (Postfix) with ESMTP id 2FB66DE612
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 00:48:07 +1000 (EST)
Received: by mail-px0-f176.google.com with SMTP id 6so3894034pxi.17
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 07:48:07 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v5 1/4] powerpc/virtex: Add support for Xilinx PCI host bridge
To: linuxppc-dev@ozlabs.org, Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Mon, 25 May 2009 08:41:18 -0600
Message-ID: <20090525144117.13016.40437.stgit@localhost.localdomain>
In-Reply-To: <20090525144023.13016.23071.stgit@localhost.localdomain>
References: <20090525144023.13016.23071.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roderick Colenbrander <thunderbird2k@gmail.com>

This patch adds support for the Xilinx plbv46-pci-1.03.a PCI host
bridge IPcore.

Signed-off-by: Roderick Colenbrander <thunderbird2k@gmail.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/include/asm/xilinx_pci.h |   21 +++++
 arch/powerpc/platforms/40x/virtex.c   |    2 +
 arch/powerpc/platforms/44x/virtex.c   |    2 +
 arch/powerpc/platforms/Kconfig        |    4 +
 arch/powerpc/sysdev/Makefile          |    1 
 arch/powerpc/sysdev/xilinx_pci.c      |  132 +++++++++++++++++++++++++++++++++
 6 files changed, 162 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/include/asm/xilinx_pci.h
 create mode 100644 arch/powerpc/sysdev/xilinx_pci.c


diff --git a/arch/powerpc/include/asm/xilinx_pci.h b/arch/powerpc/include/asm/xilinx_pci.h
new file mode 100644
index 0000000..7a8275c
--- /dev/null
+++ b/arch/powerpc/include/asm/xilinx_pci.h
@@ -0,0 +1,21 @@
+/*
+ * Xilinx pci external definitions
+ *
+ * Copyright 2009 Roderick Colenbrander
+ * Copyright 2009 Secret Lab Technologies Ltd.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef INCLUDE_XILINX_PCI
+#define INCLUDE_XILINX_PCI
+
+#ifdef CONFIG_XILINX_PCI
+extern void __init xilinx_pci_init(void);
+#else
+static inline void __init xilinx_pci_init(void) { return; }
+#endif
+
+#endif /* INCLUDE_XILINX_PCI */
diff --git a/arch/powerpc/platforms/40x/virtex.c b/arch/powerpc/platforms/40x/virtex.c
index fc7fb00..d0fc686 100644
--- a/arch/powerpc/platforms/40x/virtex.c
+++ b/arch/powerpc/platforms/40x/virtex.c
@@ -14,6 +14,7 @@
 #include <asm/prom.h>
 #include <asm/time.h>
 #include <asm/xilinx_intc.h>
+#include <asm/xilinx_pci.h>
 #include <asm/ppc4xx.h>
 
 static struct of_device_id xilinx_of_bus_ids[] __initdata = {
@@ -47,6 +48,7 @@ static int __init virtex_probe(void)
 define_machine(virtex) {
 	.name			= "Xilinx Virtex",
 	.probe			= virtex_probe,
+	.setup_arch		= xilinx_pci_init,
 	.init_IRQ		= xilinx_intc_init_tree,
 	.get_irq		= xilinx_intc_get_irq,
 	.restart		= ppc4xx_reset_system,
diff --git a/arch/powerpc/platforms/44x/virtex.c b/arch/powerpc/platforms/44x/virtex.c
index 68637fa..cf96cca 100644
--- a/arch/powerpc/platforms/44x/virtex.c
+++ b/arch/powerpc/platforms/44x/virtex.c
@@ -16,6 +16,7 @@
 #include <asm/prom.h>
 #include <asm/time.h>
 #include <asm/xilinx_intc.h>
+#include <asm/xilinx_pci.h>
 #include <asm/reg.h>
 #include <asm/ppc4xx.h>
 #include "44x.h"
@@ -53,6 +54,7 @@ static int __init virtex_probe(void)
 define_machine(virtex) {
 	.name			= "Xilinx Virtex440",
 	.probe			= virtex_probe,
+	.setup_arch		= xilinx_pci_init,
 	.init_IRQ		= xilinx_intc_init_tree,
 	.get_irq		= xilinx_intc_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index e3e8707..04a8061 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -329,4 +329,8 @@ config MCU_MPC8349EMITX
 	  also register MCU GPIOs with the generic GPIO API, so you'll able
 	  to use MCU pins as GPIOs.
 
+config XILINX_PCI
+	bool "Xilinx PCI host bridge support"
+	depends on PCI && XILINX_VIRTEX
+
 endmenu
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index b33b28a..2d1c87d 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_IPIC)		+= ipic.o
 obj-$(CONFIG_4xx)		+= uic.o
 obj-$(CONFIG_4xx_SOC)		+= ppc4xx_soc.o
 obj-$(CONFIG_XILINX_VIRTEX)	+= xilinx_intc.o
+obj-$(CONFIG_XILINX_PCI)	+= xilinx_pci.o
 obj-$(CONFIG_OF_RTC)		+= of_rtc.o
 ifeq ($(CONFIG_PCI),y)
 obj-$(CONFIG_4xx)		+= ppc4xx_pci.o
diff --git a/arch/powerpc/sysdev/xilinx_pci.c b/arch/powerpc/sysdev/xilinx_pci.c
new file mode 100644
index 0000000..1453b0e
--- /dev/null
+++ b/arch/powerpc/sysdev/xilinx_pci.c
@@ -0,0 +1,132 @@
+/*
+ * PCI support for Xilinx plbv46_pci soft-core which can be used on
+ * Xilinx Virtex ML410 / ML510 boards.
+ *
+ * Copyright 2009 Roderick Colenbrander
+ * Copyright 2009 Secret Lab Technologies Ltd.
+ *
+ * The pci bridge fixup code was copied from ppc4xx_pci.c and was written
+ * by Benjamin Herrenschmidt.
+ * Copyright 2007 Ben. Herrenschmidt <benh@kernel.crashing.org>, IBM Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/ioport.h>
+#include <linux/of.h>
+#include <linux/pci.h>
+#include <mm/mmu_decl.h>
+#include <asm/io.h>
+#include <asm/xilinx_pci.h>
+
+#define XPLB_PCI_ADDR 0x10c
+#define XPLB_PCI_DATA 0x110
+#define XPLB_PCI_BUS  0x114
+
+#define PCI_HOST_ENABLE_CMD PCI_COMMAND_SERR | PCI_COMMAND_PARITY | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY
+
+static struct of_device_id xilinx_pci_match[] = {
+	{ .compatible = "xlnx,plbv46-pci-1.03.a", },
+	{}
+};
+
+/**
+ * xilinx_pci_fixup_bridge - Block Xilinx PHB configuration.
+ */
+static void xilinx_pci_fixup_bridge(struct pci_dev *dev)
+{
+	struct pci_controller *hose;
+	int i;
+
+	if (dev->devfn || dev->bus->self)
+		return;
+
+	hose = pci_bus_to_host(dev->bus);
+	if (!hose)
+		return;
+
+	if (!of_match_node(xilinx_pci_match, hose->dn))
+		return;
+
+	/* Hide the PCI host BARs from the kernel as their content doesn't
+	 * fit well in the resource management
+	 */
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+		dev->resource[i].start = 0;
+		dev->resource[i].end = 0;
+		dev->resource[i].flags = 0;
+	}
+
+	dev_info(&dev->dev, "Hiding Xilinx plb-pci host bridge resources %s\n",
+		 pci_name(dev));
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, xilinx_pci_fixup_bridge);
+
+/**
+ * xilinx_pci_exclude_device - Don't do config access for non-root bus
+ *
+ * This is a hack.  Config access to any bus other than bus 0 does not
+ * currently work on the ML510 so we prevent it here.
+ */
+static int
+xilinx_pci_exclude_device(struct pci_controller *hose, u_char bus, u8 devfn)
+{
+	return (bus != 0);
+}
+
+/**
+ * xilinx_pci_init - Find and register a Xilinx PCI host bridge
+ */
+void __init xilinx_pci_init(void)
+{
+	struct pci_controller *hose;
+	struct resource r;
+	void __iomem *pci_reg;
+	struct device_node *pci_node;
+
+	pci_node = of_find_matching_node(NULL, xilinx_pci_match);
+	if(!pci_node)
+		return;
+
+	if (of_address_to_resource(pci_node, 0, &r)) {
+		pr_err("xilinx-pci: cannot resolve base address\n");
+		return;
+	}
+
+	hose = pcibios_alloc_controller(pci_node);
+	if (!hose) {
+		pr_err("xilinx-pci: pcibios_alloc_controller() failed\n");
+		return;
+	}
+
+	/* Setup config space */
+	setup_indirect_pci(hose, r.start + XPLB_PCI_ADDR,
+			   r.start + XPLB_PCI_DATA,
+			   PPC_INDIRECT_TYPE_SET_CFG_TYPE);
+
+	/* According to the xilinx plbv46_pci documentation the soft-core starts
+	 * a self-init when the bus master enable bit is set. Without this bit
+	 * set the pci bus can't be scanned.
+	 */
+	early_write_config_word(hose, 0, 0, PCI_COMMAND, PCI_HOST_ENABLE_CMD);
+
+	/* Set the max latency timer to 255 */
+	early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0xff);
+
+	/* Set the max bus number to 255 */
+	pci_reg = of_iomap(pci_node, 0);
+	out_8(pci_reg + XPLB_PCI_BUS, 0xff);
+	iounmap(pci_reg);
+
+	/* Nothing past the root bridge is working right now.  By default
+	 * exclude config access to anything except bus 0 */
+	if (!ppc_md.pci_exclude_device)
+		ppc_md.pci_exclude_device = xilinx_pci_exclude_device;
+
+	/* Register the host bridge with the linux kernel! */
+	pci_process_bridge_OF_ranges(hose, pci_node, 1);
+
+	pr_info("xilinx-pci: Registered PCI host bridge\n");
+}
