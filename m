Return-Path: <afleming@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 3A3B6DDDE6
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 13:44:07 +1100 (EST)
Date: Thu, 15 Feb 2007 20:43:25 -0600 (CST)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>,
	jdl@jdl.com
Subject: [RFC 1/7] Unite all PCI-e on 85xx and 86xx under one codebase
Message-ID: <Pine.LNX.4.61.0702152042080.9034@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make 86xx PCIe support generic for Freescale parts

Move arch/powerpc/platforms/86xx/mpc86xx_pcie.c to
arch/powerpc/sysdev/fsl_pcie.c.
Add CONFIG_FSL_PCIE, 8548CDS and 86xx processor need select these
config.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/Kconfig                       |    5 +
 arch/powerpc/platforms/85xx/Kconfig        |    1 +
 arch/powerpc/platforms/86xx/Makefile       |    2 +-
 arch/powerpc/platforms/86xx/mpc86xx_pcie.c |  173 ----------------------------
 arch/powerpc/sysdev/Makefile               |    1 +
 arch/powerpc/sysdev/fsl_pcie.c             |  171 +++++++++++++++++++++++++++
 6 files changed, 179 insertions(+), 174 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 340d9be..243bf75 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -168,6 +168,7 @@ config PPC_86xx
 	bool "Freescale 86xx"
 	select 6xx
 	select FSL_SOC
+	select FSL_PCIE
 	select PPC_FPU
 	select ALTIVEC
 	help
@@ -1013,6 +1014,10 @@ config SBUS
 config FSL_SOC
 	bool
 
+config FSL_PCIE
+	bool
+	depends on MPC85xx_CDS || PPC_86xx
+
 # Yes MCA RS/6000s exist but Linux-PPC does not currently support any
 config MCA
 	bool
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 0584f3c..ac2de08 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -20,6 +20,7 @@ config MPC8560_ADS
 config MPC85xx_CDS
 	bool "Freescale MPC85xx CDS"
 	select DEFAULT_UIMAGE
+	select FSL_PCIE
 	help
 	  This option enables support for the MPC85xx CDS board
 
diff --git a/arch/powerpc/platforms/86xx/Makefile b/arch/powerpc/platforms/86xx/Makefile
index 476a6ee..418fd8f 100644
--- a/arch/powerpc/platforms/86xx/Makefile
+++ b/arch/powerpc/platforms/86xx/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_SMP)		+= mpc86xx_smp.o
 obj-$(CONFIG_MPC8641_HPCN)	+= mpc86xx_hpcn.o
-obj-$(CONFIG_PCI)		+= pci.o mpc86xx_pcie.o
+obj-$(CONFIG_PCI)		+= pci.o
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_pcie.c b/arch/powerpc/platforms/86xx/mpc86xx_pcie.c
deleted file mode 100644
index a2f4f73..0000000
--- a/arch/powerpc/platforms/86xx/mpc86xx_pcie.c
+++ /dev/null
@@ -1,173 +0,0 @@
-/*
- * Support for indirect PCI bridges.
- *
- * Copyright (C) 1998 Gabriel Paubert.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- *
- * "Temporary" MPC8548 Errata file -
- * The standard indirect_pci code should work with future silicon versions.
- */
-
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/delay.h>
-#include <linux/string.h>
-#include <linux/init.h>
-#include <linux/bootmem.h>
-
-#include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/pci-bridge.h>
-#include <asm/machdep.h>
-
-#include "mpc86xx.h"
-
-#define PCI_CFG_OUT out_be32
-
-/* ERRATA PCI-Ex 14 PCIE Controller timeout */
-#define PCIE_FIX		out_be32(hose->cfg_addr+0x4, 0x0400ffff)
-
-
-static int
-indirect_read_config_pcie(struct pci_bus *bus, unsigned int devfn, int offset,
-		     int len, u32 *val)
-{
-	struct pci_controller *hose = bus->sysdata;
-	volatile void __iomem *cfg_data;
-	u32 temp;
-
-	if (ppc_md.pci_exclude_device)
-		if (ppc_md.pci_exclude_device(bus->number, devfn))
-			return PCIBIOS_DEVICE_NOT_FOUND;
-
-	/* Possible artifact of CDCpp50937 needs further investigation */
-	if (devfn != 0x0 && bus->number == 0xff)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	PCIE_FIX;
-	if (bus->number == 0xff) {
-		PCI_CFG_OUT(hose->cfg_addr,
-			    (0x80000000 | ((offset & 0xf00) << 16) |
-			     ((bus->number - hose->bus_offset) << 16)
-			     | (devfn << 8) | ((offset & 0xfc) )));
-	} else {
-		PCI_CFG_OUT(hose->cfg_addr,
-			    (0x80000001 | ((offset & 0xf00) << 16) |
-			     ((bus->number - hose->bus_offset) << 16)
-			     | (devfn << 8) | ((offset & 0xfc) )));
-	}
-
-	/*
-	 * Note: the caller has already checked that offset is
-	 * suitably aligned and that len is 1, 2 or 4.
-	 */
-	/* ERRATA PCI-Ex 12 - Configuration Address/Data Alignment */
-	cfg_data = hose->cfg_data;
-	PCIE_FIX;
-	temp = in_le32(cfg_data);
-	switch (len) {
-	case 1:
-		*val = (temp >> (((offset & 3))*8)) & 0xff;
-		break;
-	case 2:
-		*val = (temp >> (((offset & 3))*8)) & 0xffff;
-		break;
-	default:
-		*val = temp;
-		break;
-	}
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-indirect_write_config_pcie(struct pci_bus *bus, unsigned int devfn, int offset,
-		      int len, u32 val)
-{
-	struct pci_controller *hose = bus->sysdata;
-	volatile void __iomem *cfg_data;
-	u32 temp;
-
-	if (ppc_md.pci_exclude_device)
-		if (ppc_md.pci_exclude_device(bus->number, devfn))
-			return PCIBIOS_DEVICE_NOT_FOUND;
-
-	/* Possible artifact of CDCpp50937 needs further investigation */
-	if (devfn != 0x0 && bus->number == 0xff)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	PCIE_FIX;
-	if (bus->number == 0xff) {
-		PCI_CFG_OUT(hose->cfg_addr,
-			    (0x80000000 | ((offset & 0xf00) << 16) |
-			     ((bus->number - hose->bus_offset) << 16)
-			     | (devfn << 8) | ((offset & 0xfc) )));
-	} else {
-		PCI_CFG_OUT(hose->cfg_addr,
-			    (0x80000001 | ((offset & 0xf00) << 16) |
-			     ((bus->number - hose->bus_offset) << 16)
-			     | (devfn << 8) | ((offset & 0xfc) )));
-        }
-
-	/*
-	 * Note: the caller has already checked that offset is
-	 * suitably aligned and that len is 1, 2 or 4.
-	 */
-	/* ERRATA PCI-Ex 12 - Configuration Address/Data Alignment */
-	cfg_data = hose->cfg_data;
-	switch (len) {
-	case 1:
-		PCIE_FIX;
-		temp = in_le32(cfg_data);
-		temp = (temp & ~(0xff << ((offset & 3) * 8))) |
-			(val << ((offset & 3) * 8));
-		PCIE_FIX;
-		out_le32(cfg_data, temp);
-		break;
-	case 2:
-		PCIE_FIX;
-		temp = in_le32(cfg_data);
-		temp = (temp & ~(0xffff << ((offset & 3) * 8)));
-		temp |= (val << ((offset & 3) * 8)) ;
-		PCIE_FIX;
-		out_le32(cfg_data, temp);
-		break;
-	default:
-		PCIE_FIX;
-		out_le32(cfg_data, val);
-		break;
-	}
-	PCIE_FIX;
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static struct pci_ops indirect_pcie_ops = {
-	indirect_read_config_pcie,
-	indirect_write_config_pcie
-};
-
-void __init
-setup_indirect_pcie_nomap(struct pci_controller* hose, void __iomem * cfg_addr,
-	void __iomem * cfg_data)
-{
-	hose->cfg_addr = cfg_addr;
-	hose->cfg_data = cfg_data;
-	hose->ops = &indirect_pcie_ops;
-}
-
-void __init
-setup_indirect_pcie(struct pci_controller* hose, u32 cfg_addr, u32 cfg_data)
-{
-	unsigned long base = cfg_addr & PAGE_MASK;
-	void __iomem *mbase, *addr, *data;
-
-	mbase = ioremap(base, PAGE_SIZE);
-	addr = mbase + (cfg_addr & ~PAGE_MASK);
-	if ((cfg_data & PAGE_MASK) != base)
-		mbase = ioremap(cfg_data & PAGE_MASK, PAGE_SIZE);
-	data = mbase + (cfg_data & ~PAGE_MASK);
-	setup_indirect_pcie_nomap(hose, addr, data);
-}
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 85dcdf1..70c99ea 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_PPC_DCR_NATIVE)	+= dcr-low.
 obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
+obj-$(CONFIG_FSL_PCIE)		+= fsl_pcie.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
 
diff --git a/arch/powerpc/sysdev/fsl_pcie.c b/arch/powerpc/sysdev/fsl_pcie.c
new file mode 100644
index 0000000..041c07e
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_pcie.c
@@ -0,0 +1,171 @@
+/*
+ * Support for indirect PCI bridges.
+ *
+ * Copyright (C) 1998 Gabriel Paubert.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * "Temporary" MPC8548 Errata file -
+ * The standard indirect_pci code should work with future silicon versions.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+#include <asm/machdep.h>
+
+#define PCI_CFG_OUT out_be32
+
+/* ERRATA PCI-Ex 14 PCIE Controller timeout */
+#define PCIE_FIX		out_be32(hose->cfg_addr+0x4, 0x0400ffff)
+
+
+static int
+indirect_read_config_pcie(struct pci_bus *bus, unsigned int devfn, int offset,
+		     int len, u32 *val)
+{
+	struct pci_controller *hose = bus->sysdata;
+	volatile void __iomem *cfg_data;
+	u32 temp;
+
+	if (ppc_md.pci_exclude_device)
+		if (ppc_md.pci_exclude_device(bus->number, devfn))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+	/* Possible artifact of CDCpp50937 needs further investigation */
+	if (devfn != 0x0 && bus->number == 0xff)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	PCIE_FIX;
+	if (bus->number == 0xff) {
+		PCI_CFG_OUT(hose->cfg_addr,
+			    (0x80000000 | ((offset & 0xf00) << 16) |
+			     ((bus->number - hose->bus_offset) << 16)
+			     | (devfn << 8) | ((offset & 0xfc) )));
+	} else {
+		PCI_CFG_OUT(hose->cfg_addr,
+			    (0x80000001 | ((offset & 0xf00) << 16) |
+			     ((bus->number - hose->bus_offset) << 16)
+			     | (devfn << 8) | ((offset & 0xfc) )));
+	}
+
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	/* ERRATA PCI-Ex 12 - Configuration Address/Data Alignment */
+	cfg_data = hose->cfg_data;
+	PCIE_FIX;
+	temp = in_le32(cfg_data);
+	switch (len) {
+	case 1:
+		*val = (temp >> (((offset & 3))*8)) & 0xff;
+		break;
+	case 2:
+		*val = (temp >> (((offset & 3))*8)) & 0xffff;
+		break;
+	default:
+		*val = temp;
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int
+indirect_write_config_pcie(struct pci_bus *bus, unsigned int devfn, int offset,
+		      int len, u32 val)
+{
+	struct pci_controller *hose = bus->sysdata;
+	volatile void __iomem *cfg_data;
+	u32 temp;
+
+	if (ppc_md.pci_exclude_device)
+		if (ppc_md.pci_exclude_device(bus->number, devfn))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+	/* Possible artifact of CDCpp50937 needs further investigation */
+	if (devfn != 0x0 && bus->number == 0xff)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	PCIE_FIX;
+	if (bus->number == 0xff) {
+		PCI_CFG_OUT(hose->cfg_addr,
+			    (0x80000000 | ((offset & 0xf00) << 16) |
+			     ((bus->number - hose->bus_offset) << 16)
+			     | (devfn << 8) | ((offset & 0xfc) )));
+	} else {
+		PCI_CFG_OUT(hose->cfg_addr,
+			    (0x80000001 | ((offset & 0xf00) << 16) |
+			     ((bus->number - hose->bus_offset) << 16)
+			     | (devfn << 8) | ((offset & 0xfc) )));
+        }
+
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	/* ERRATA PCI-Ex 12 - Configuration Address/Data Alignment */
+	cfg_data = hose->cfg_data;
+	switch (len) {
+	case 1:
+		PCIE_FIX;
+		temp = in_le32(cfg_data);
+		temp = (temp & ~(0xff << ((offset & 3) * 8))) |
+			(val << ((offset & 3) * 8));
+		PCIE_FIX;
+		out_le32(cfg_data, temp);
+		break;
+	case 2:
+		PCIE_FIX;
+		temp = in_le32(cfg_data);
+		temp = (temp & ~(0xffff << ((offset & 3) * 8)));
+		temp |= (val << ((offset & 3) * 8)) ;
+		PCIE_FIX;
+		out_le32(cfg_data, temp);
+		break;
+	default:
+		PCIE_FIX;
+		out_le32(cfg_data, val);
+		break;
+	}
+	PCIE_FIX;
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops indirect_pcie_ops = {
+	indirect_read_config_pcie,
+	indirect_write_config_pcie
+};
+
+void __init
+setup_indirect_pcie_nomap(struct pci_controller* hose, void __iomem * cfg_addr,
+	void __iomem * cfg_data)
+{
+	hose->cfg_addr = cfg_addr;
+	hose->cfg_data = cfg_data;
+	hose->ops = &indirect_pcie_ops;
+}
+
+void __init
+setup_indirect_pcie(struct pci_controller* hose, u32 cfg_addr, u32 cfg_data)
+{
+	unsigned long base = cfg_addr & PAGE_MASK;
+	void __iomem *mbase, *addr, *data;
+
+	mbase = ioremap(base, PAGE_SIZE);
+	addr = mbase + (cfg_addr & ~PAGE_MASK);
+	if ((cfg_data & PAGE_MASK) != base)
+		mbase = ioremap(cfg_data & PAGE_MASK, PAGE_SIZE);
+	data = mbase + (cfg_data & ~PAGE_MASK);
+	setup_indirect_pcie_nomap(hose, addr, data);
+}
-- 
1.4.4
