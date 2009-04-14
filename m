Return-Path: <thunderbird2k@gmail.com>
Received: from mx.utwente.nl (mx2.utsp.utwente.nl [130.89.2.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8FB9EDDF9D
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 00:58:48 +1000 (EST)
Subject: Patch 1/2: Add support for Xilinx PLB PCI soft-core
From: Roderick Colenbrander <thunderbird2k@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Tue, 14 Apr 2009 16:58:38 +0200
Message-Id: <1239721118.27976.1.camel@CE202>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From c1cf80d7e5332240c2e54500476027c23b496b92 Mon Sep 17 00:00:00 2001
From: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Tue, 14 Apr 2009 15:45:07 +0200
Subject: [PATCH] Add support for the Xilinx PLB PCI soft-core which is
used on Xilinx ML410 and ML510 FPGA boards.

---
 arch/powerpc/sysdev/Kconfig      |    4 ++
 arch/powerpc/sysdev/Makefile     |    1 +
 arch/powerpc/sysdev/virtex_pci.c |   95
++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/virtex_pci.c

diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index 3965828..2d0be14 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -12,3 +12,7 @@ config PPC_MSI_BITMAP
 	depends on PCI_MSI
 	default y if MPIC
 	default y if FSL_PCI
+
+config XILINX_VIRTEX_PCI
+	bool
+	depends on PCI
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index b33b28a..b93794e 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_IPIC)		+= ipic.o
 obj-$(CONFIG_4xx)		+= uic.o
 obj-$(CONFIG_4xx_SOC)		+= ppc4xx_soc.o
 obj-$(CONFIG_XILINX_VIRTEX)	+= xilinx_intc.o
+obj-$(CONFIG_XILINX_VIRTEX_PCI)	+= virtex_pci.o
 obj-$(CONFIG_OF_RTC)		+= of_rtc.o
 ifeq ($(CONFIG_PCI),y)
 obj-$(CONFIG_4xx)		+= ppc4xx_pci.o
diff --git a/arch/powerpc/sysdev/virtex_pci.c
b/arch/powerpc/sysdev/virtex_pci.c
new file mode 100644
index 0000000..bf24aa4
--- /dev/null
+++ b/arch/powerpc/sysdev/virtex_pci.c
@@ -0,0 +1,95 @@
+/*
+ * PCI support for Xilinx plbv46_pci soft-core which can be used on
Xilinx Virtex ML410 / ML510 boards.
+ *
+ * Copyright 2009 Roderick Colenbrander
+ *
+ * The pci bridge fixup code was copied from ppc4xx_pci.c and was
written by Benjamin Herrenschmidt.
+ * Copyright 2007 Ben. Herrenschmidt <benh@kernel.crashing.org>, IBM
Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public
License
+ * version 2. This program is licensed "as is" without any warranty of
any
+ * kind, whether express or implied.
+ */
+
+#include <linux/pci.h>
+#include <mm/mmu_decl.h>
+#include <asm/io.h>
+
+#define XPLB_PCI_ADDR 0x10c
+#define XPLB_PCI_DATA 0x110
+#define XPLB_PCI_BUS  0x114
+
+#define PCI_HOST_ENABLE_CMD PCI_COMMAND_SERR | PCI_COMMAND_PARITY |
PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY  
+
+static void fixup_virtex_pci_bridge(struct pci_dev *dev)
+{
+	struct pci_controller *hose;
+	int i;
+
+	if (dev->devfn != 0 || dev->bus->self != NULL)
+		return;
+
+	hose = pci_bus_to_host(dev->bus);
+	if (hose == NULL)
+		return;
+
+	if(!of_device_is_compatible(hose->dn, "xlnx,plbv46-pci-1.03.a"))
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
+	dev_info(&dev->dev, "PCI: Hiding Xilinx plb-pci host bridge resources
%s\n", pci_name(dev));
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID,
fixup_virtex_pci_bridge);      
+
+void virtex_pci_init(void)
+{
+	struct device_node *pci_node = of_find_compatible_node(NULL, NULL,
"xlnx,plbv46-pci-1.03.a");
+
+	if(pci_node)
+	{
+		struct pci_controller *hose;
+		struct resource r;
+		void __iomem *pci_reg;
+
+		printk("Found a Xilinx plb-pci host bridge\n");
+
+		if(of_address_to_resource(pci_node, 0, &r))
+		{
+			printk("No address for Xilinx plb-pci host bridge\n");
+			return;
+		}
+
+		hose = pcibios_alloc_controller(pci_node);
+		if (!hose)
+			return;
+
+		hose->first_busno = 0;
+		hose->last_busno = 0;
+      
+		/* Setup config space */
+		setup_indirect_pci(hose, r.start + XPLB_PCI_ADDR, r.start +
XPLB_PCI_DATA, PPC_INDIRECT_TYPE_SET_CFG_TYPE);
+
+		/* According to the xilinx plbv46_pci documentation the soft-core
starts a self-init when the bus master enable bit is set.
+		 * Without this bit set the pci bus can't be scanned. */
+		early_write_config_word(hose, 0, 0, PCI_COMMAND,
PCI_HOST_ENABLE_CMD);
+
+		/* Set the max latency timer to 255 */
+		early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0xff);
+
+		/* Set the max bus number to 255 */
+		pci_reg = of_iomap(pci_node, 0);
+		out_8(pci_reg + XPLB_PCI_BUS, 0xff);
+		iounmap(pci_reg);
+
+		/* Register the host bridge with the linux kernel! */
+		pci_process_bridge_OF_ranges(hose, pci_node, 1); 
+	}
+}
-- 
1.5.6.3
