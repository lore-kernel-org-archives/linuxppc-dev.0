Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D20FDDDF13
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 11:16:46 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/15] [POWERPC] Pass the pci_controller into
	pci_exclude_device
Date: Tue, 26 Jun 2007 20:16:33 -0500
Message-Id: <11829070091056-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11829070073637-git-send-email-galak@kernel.crashing.org>
References: <11829070051484-git-send-email-galak@kernel.crashing.org>
	<11829070063989-git-send-email-galak@kernel.crashing.org>
	<11829070073637-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are times that we need to know which controller we are on to decide
how to exclude devices properly.  We now pass the pci_controller that we
are going to use down to the pci_exclude_device function. This will
greatly simplify being able to exclude the PHBs in multiple controller
setups.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/82xx/mpc82xx_ads.c         |    3 +-
 arch/powerpc/platforms/83xx/mpc83xx.h             |    4 +-
 arch/powerpc/platforms/83xx/pci.c                 |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ads.c         |    3 +-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c         |    3 +-
 arch/powerpc/platforms/86xx/mpc86xx.h             |    3 +-
 arch/powerpc/platforms/86xx/pci.c                 |    2 +-
 arch/powerpc/platforms/embedded6xx/holly.c        |    2 +-
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    3 +-
 arch/powerpc/sysdev/Makefile                      |    2 +-
 arch/powerpc/sysdev/fsl_pcie.c                    |    4 +-
 arch/powerpc/sysdev/indirect_pci.c                |    8 +-
 arch/powerpc/sysdev/tsi108_pci.c                  |    6 +-
 arch/ppc/syslib/Makefile                          |    1 +
 arch/ppc/syslib/indirect_pci.c                    |  134 +++++++++++++++++++++
 include/asm-powerpc/machdep.h                     |    2 +-
 16 files changed, 163 insertions(+), 19 deletions(-)
 create mode 100644 arch/ppc/syslib/indirect_pci.c

diff --git a/arch/powerpc/platforms/82xx/mpc82xx_ads.c b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
index 04bf570..715107b 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
@@ -507,7 +507,8 @@ void m82xx_pci_init_irq(void)
 	return;
 }
 
-static int m82xx_pci_exclude_device(u_char bus, u_char devfn)
+static int m82xx_pci_exclude_device(struct pci_controller *hose,
+				    u_char bus, u_char devfn)
 {
 	if (bus == 0 && PCI_SLOT(devfn) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 9bd85f5..f5c5034 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -3,6 +3,7 @@
 
 #include <linux/init.h>
 #include <linux/device.h>
+#include <asm/pci-bridge.h>
 
 /* System Clock Control Register */
 #define MPC83XX_SCCR_OFFS          0xA08
@@ -28,7 +29,8 @@
  */
 
 extern int mpc83xx_add_bridge(struct device_node *dev);
-extern int mpc83xx_exclude_device(u_char bus, u_char devfn);
+extern int mpc83xx_exclude_device(struct pci_controller *hose,
+				  u_char bus, u_char devfn);
 extern void mpc83xx_restart(char *cmd);
 extern long mpc83xx_time_init(void);
 
diff --git a/arch/powerpc/platforms/83xx/pci.c b/arch/powerpc/platforms/83xx/pci.c
index 3471602..f92e71f 100644
--- a/arch/powerpc/platforms/83xx/pci.c
+++ b/arch/powerpc/platforms/83xx/pci.c
@@ -35,7 +35,7 @@
 
 int mpc83xx_pci2_busno;
 
-int mpc83xx_exclude_device(u_char bus, u_char devfn)
+int mpc83xx_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn)
 {
 	if (bus == 0 && PCI_SLOT(devfn) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 4100e17..1262d1b 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -39,7 +39,8 @@
 #endif
 
 #ifdef CONFIG_PCI
-static int mpc85xx_exclude_device(u_char bus, u_char devfn)
+static int mpc85xx_exclude_device(struct pci_controller *hose,
+				   u_char bus, u_char devfn)
 {
 	if (bus == 0 && PCI_SLOT(devfn) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index fa6b6be..fcea5ab 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -57,7 +57,8 @@ static volatile u8 *cadmus;
 
 extern int mpc85xx_pci2_busno;
 
-static int mpc85xx_exclude_device(u_char bus, u_char devfn)
+static int mpc85xx_exclude_device(struct pci_controller *hose,
+				  u_char bus, u_char devfn)
 {
 	if (bus == 0 && PCI_SLOT(devfn) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
diff --git a/arch/powerpc/platforms/86xx/mpc86xx.h b/arch/powerpc/platforms/86xx/mpc86xx.h
index dc2f6fd..4c2789d 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx.h
+++ b/arch/powerpc/platforms/86xx/mpc86xx.h
@@ -17,7 +17,8 @@
 
 extern int mpc86xx_add_bridge(struct device_node *dev);
 
-extern int mpc86xx_exclude_device(u_char bus, u_char devfn);
+extern int mpc86xx_exclude_device(struct pci_controller *hose,
+				  u_char bus, u_char devfn);
 
 extern void setup_indirect_pcie(struct pci_controller *hose,
 				       u32 cfg_addr, u32 cfg_data);
diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/platforms/86xx/pci.c
index 1e47c14..7659259 100644
--- a/arch/powerpc/platforms/86xx/pci.c
+++ b/arch/powerpc/platforms/86xx/pci.c
@@ -140,7 +140,7 @@ mpc86xx_setup_pcie(struct pci_controller *hose, u32 pcie_offset, u32 pcie_size)
 	early_write_config_dword(hose, 0, 0, PCI_PRIMARY_BUS, temps);
 }
 
-int mpc86xx_exclude_device(u_char bus, u_char devfn)
+int mpc86xx_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn)
 {
 	if (bus == 0 && PCI_SLOT(devfn) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index 3a0b4a0..6292e36 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -45,7 +45,7 @@
 
 #define HOLLY_PCI_CFG_PHYS 0x7c000000
 
-int holly_exclude_device(u_char bus, u_char devfn)
+int holly_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn)
 {
 	if (bus == 0 && PCI_SLOT(devfn) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index 69eab17..1e3cc69 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -56,7 +56,8 @@
 
 extern void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
 
-int mpc7448_hpc2_exclude_device(u_char bus, u_char devfn)
+int mpc7448_hpc2_exclude_device(struct pci_controller *hose,
+				u_char bus, u_char devfn)
 {
 	if (bus == 0 && PCI_SLOT(devfn) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index c3ce0bd..43fd7e0 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -5,7 +5,6 @@ endif
 mpic-msi-obj-$(CONFIG_PCI_MSI)	+= mpic_msi.o mpic_u3msi.o
 obj-$(CONFIG_MPIC)		+= mpic.o $(mpic-msi-obj-y)
 
-obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
 obj-$(CONFIG_PPC_MPC106)	+= grackle.o
 obj-$(CONFIG_PPC_DCR)		+= dcr.o
 obj-$(CONFIG_PPC_DCR_NATIVE)	+= dcr-low.o
@@ -23,6 +22,7 @@ obj-$(CONFIG_MV64X60)		+= $(mv64x60-y) mv64x60_pic.o mv64x60_dev.o
 obj-$(CONFIG_PM)		+= timer.o
 
 ifeq ($(CONFIG_PPC_MERGE),y)
+obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
 obj-$(CONFIG_PPC_83xx)		+= ipic.o
 obj-$(CONFIG_4xx)		+= uic.o
diff --git a/arch/powerpc/sysdev/fsl_pcie.c b/arch/powerpc/sysdev/fsl_pcie.c
index 041c07e..6bbd7f8 100644
--- a/arch/powerpc/sysdev/fsl_pcie.c
+++ b/arch/powerpc/sysdev/fsl_pcie.c
@@ -39,7 +39,7 @@ indirect_read_config_pcie(struct pci_bus *bus, unsigned int devfn, int offset,
 	u32 temp;
 
 	if (ppc_md.pci_exclude_device)
-		if (ppc_md.pci_exclude_device(bus->number, devfn))
+		if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
 			return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/* Possible artifact of CDCpp50937 needs further investigation */
@@ -90,7 +90,7 @@ indirect_write_config_pcie(struct pci_bus *bus, unsigned int devfn, int offset,
 	u32 temp;
 
 	if (ppc_md.pci_exclude_device)
-		if (ppc_md.pci_exclude_device(bus->number, devfn))
+		if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
 			return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/* Possible artifact of CDCpp50937 needs further investigation */
diff --git a/arch/powerpc/sysdev/indirect_pci.c b/arch/powerpc/sysdev/indirect_pci.c
index e714884..3dedf8f 100644
--- a/arch/powerpc/sysdev/indirect_pci.c
+++ b/arch/powerpc/sysdev/indirect_pci.c
@@ -35,14 +35,14 @@ indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 	u8 cfg_type = 0;
 
 	if (ppc_md.pci_exclude_device)
-		if (ppc_md.pci_exclude_device(bus->number, devfn))
+		if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
 			return PCIBIOS_DEVICE_NOT_FOUND;
 	
 	if (hose->set_cfg_type)
 		if (bus->number != hose->first_busno)
 			cfg_type = 1;
 
-	PCI_CFG_OUT(hose->cfg_addr, 					 
+	PCI_CFG_OUT(hose->cfg_addr,
 		 (0x80000000 | ((bus->number - hose->bus_offset) << 16)
 		  | (devfn << 8) | ((offset & 0xfc) | cfg_type)));
 
@@ -74,14 +74,14 @@ indirect_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 	u8 cfg_type = 0;
 
 	if (ppc_md.pci_exclude_device)
-		if (ppc_md.pci_exclude_device(bus->number, devfn))
+		if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
 			return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (hose->set_cfg_type)
 		if (bus->number != hose->first_busno)
 			cfg_type = 1;
 
-	PCI_CFG_OUT(hose->cfg_addr, 					 
+	PCI_CFG_OUT(hose->cfg_addr,
 		 (0x80000000 | ((bus->number - hose->bus_offset) << 16)
 		  | (devfn << 8) | ((offset & 0xfc) | cfg_type)));
 
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 33177b6..298e2dd 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -64,9 +64,10 @@ tsi108_direct_write_config(struct pci_bus *bus, unsigned int devfunc,
 			   int offset, int len, u32 val)
 {
 	volatile unsigned char *cfg_addr;
+	struct pci_controller *hose = bus->sysdata;
 
 	if (ppc_md.pci_exclude_device)
-		if (ppc_md.pci_exclude_device(bus->number, devfunc))
+		if (ppc_md.pci_exclude_device(hose, bus->number, devfunc))
 			return PCIBIOS_DEVICE_NOT_FOUND;
 
 	cfg_addr = (unsigned char *)(tsi_mk_config_addr(bus->number,
@@ -149,10 +150,11 @@ tsi108_direct_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 			  int len, u32 * val)
 {
 	volatile unsigned char *cfg_addr;
+	struct pci_controller *hose = bus->sysdata;
 	u32 temp;
 
 	if (ppc_md.pci_exclude_device)
-		if (ppc_md.pci_exclude_device(bus->number, devfn))
+		if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
 			return PCIBIOS_DEVICE_NOT_FOUND;
 
 	cfg_addr = (unsigned char *)(tsi_mk_config_addr(bus->number,
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
index 9569415..543795b 100644
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -7,6 +7,7 @@ CFLAGS_btext.o          += -fPIC
 
 wdt-mpc8xx-$(CONFIG_8xx_WDT)	+= m8xx_wdt.o
 
+obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
 obj-$(CONFIG_PPCBUG_NVRAM)	+= prep_nvram.o
 obj-$(CONFIG_PPC_OCP)		+= ocp.o
 obj-$(CONFIG_IBM_OCP)		+= ibm_ocp.o
diff --git a/arch/ppc/syslib/indirect_pci.c b/arch/ppc/syslib/indirect_pci.c
new file mode 100644
index 0000000..e714884
--- /dev/null
+++ b/arch/ppc/syslib/indirect_pci.c
@@ -0,0 +1,134 @@
+/*
+ * Support for indirect PCI bridges.
+ *
+ * Copyright (C) 1998 Gabriel Paubert.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+#include <asm/machdep.h>
+
+#ifdef CONFIG_PPC_INDIRECT_PCI_BE
+#define PCI_CFG_OUT out_be32
+#else
+#define PCI_CFG_OUT out_le32
+#endif
+
+static int
+indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
+		     int len, u32 *val)
+{
+	struct pci_controller *hose = bus->sysdata;
+	volatile void __iomem *cfg_data;
+	u8 cfg_type = 0;
+
+	if (ppc_md.pci_exclude_device)
+		if (ppc_md.pci_exclude_device(bus->number, devfn))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+	
+	if (hose->set_cfg_type)
+		if (bus->number != hose->first_busno)
+			cfg_type = 1;
+
+	PCI_CFG_OUT(hose->cfg_addr, 					 
+		 (0x80000000 | ((bus->number - hose->bus_offset) << 16)
+		  | (devfn << 8) | ((offset & 0xfc) | cfg_type)));
+
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	cfg_data = hose->cfg_data + (offset & 3);
+	switch (len) {
+	case 1:
+		*val = in_8(cfg_data);
+		break;
+	case 2:
+		*val = in_le16(cfg_data);
+		break;
+	default:
+		*val = in_le32(cfg_data);
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int
+indirect_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
+		      int len, u32 val)
+{
+	struct pci_controller *hose = bus->sysdata;
+	volatile void __iomem *cfg_data;
+	u8 cfg_type = 0;
+
+	if (ppc_md.pci_exclude_device)
+		if (ppc_md.pci_exclude_device(bus->number, devfn))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (hose->set_cfg_type)
+		if (bus->number != hose->first_busno)
+			cfg_type = 1;
+
+	PCI_CFG_OUT(hose->cfg_addr, 					 
+		 (0x80000000 | ((bus->number - hose->bus_offset) << 16)
+		  | (devfn << 8) | ((offset & 0xfc) | cfg_type)));
+
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	cfg_data = hose->cfg_data + (offset & 3);
+	switch (len) {
+	case 1:
+		out_8(cfg_data, val);
+		break;
+	case 2:
+		out_le16(cfg_data, val);
+		break;
+	default:
+		out_le32(cfg_data, val);
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops indirect_pci_ops =
+{
+	indirect_read_config,
+	indirect_write_config
+};
+
+void __init
+setup_indirect_pci_nomap(struct pci_controller* hose, void __iomem * cfg_addr,
+	void __iomem * cfg_data)
+{
+	hose->cfg_addr = cfg_addr;
+	hose->cfg_data = cfg_data;
+	hose->ops = &indirect_pci_ops;
+}
+
+void __init
+setup_indirect_pci(struct pci_controller* hose, u32 cfg_addr, u32 cfg_data)
+{
+	unsigned long base = cfg_addr & PAGE_MASK;
+	void __iomem *mbase, *addr, *data;
+
+	mbase = ioremap(base, PAGE_SIZE);
+	addr = mbase + (cfg_addr & ~PAGE_MASK);
+	if ((cfg_data & PAGE_MASK) != base)
+		mbase = ioremap(cfg_data & PAGE_MASK, PAGE_SIZE);
+	data = mbase + (cfg_data & ~PAGE_MASK);
+	setup_indirect_pci_nomap(hose, addr, data);
+}
diff --git a/include/asm-powerpc/machdep.h b/include/asm-powerpc/machdep.h
index 6cf1a83..71c6e7e 100644
--- a/include/asm-powerpc/machdep.h
+++ b/include/asm-powerpc/machdep.h
@@ -218,7 +218,7 @@ struct machdep_calls {
 	int  (*pcibios_enable_device_hook)(struct pci_dev *, int initial);
 
 	/* Called in indirect_* to avoid touching devices */
-	int (*pci_exclude_device)(unsigned char, unsigned char);
+	int (*pci_exclude_device)(struct pci_controller *, unsigned char, unsigned char);
 
 	/* Called at then very end of pcibios_init() */
 	void (*pcibios_after_init)(void);
-- 
1.5.2.1
