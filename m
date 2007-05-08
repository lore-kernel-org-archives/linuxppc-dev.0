Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 08 May 2007 12:58:34 +1000
Subject: [PATCH 2/7] Powerpc MSI infrastructure
In-Reply-To: <1178593113.675058.404575641543.qpush@cradle>
Message-Id: <20070508025839.B974DDDEDB@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch provides the architecture specific hooks to support MSI on
powerpc. We implement the newly added arch_setup_msi_irqs() and
arch_teardown_msi_irqs(), and then delegate to ppc_md routines.

Platforms that don't implement MSI will leave the ppc_md calls blank,
arch_msi_check_device() will detect this and return ENOSYS. Drivers
should detect this error and continue to use LSI.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/Kconfig          |    1 +
 arch/powerpc/kernel/Makefile  |    1 +
 arch/powerpc/kernel/msi.c     |   38 ++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/machdep.h |    8 ++++++++
 4 files changed, 48 insertions(+)

Index: msi-new/arch/powerpc/Kconfig
===================================================================
--- msi-new.orig/arch/powerpc/Kconfig
+++ msi-new/arch/powerpc/Kconfig
@@ -659,6 +659,7 @@ config PCI
 		&& !PPC_85xx && !PPC_86xx
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && APUS
 	default PCI_QSPAN if !4xx && !CPM2 && 8xx
+	select ARCH_SUPPORTS_MSI
 	help
 	  Find out whether your system includes a PCI bus. PCI is the name of
 	  a bus system, i.e. the way the CPU talks to the other stuff inside
Index: msi-new/arch/powerpc/kernel/Makefile
===================================================================
--- msi-new.orig/arch/powerpc/kernel/Makefile
+++ msi-new/arch/powerpc/kernel/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_MODULES)		+= $(module-y)
 pci64-$(CONFIG_PPC64)		+= pci_64.o pci_dn.o
 pci32-$(CONFIG_PPC32)		:= pci_32.o
 obj-$(CONFIG_PCI)		+= $(pci64-y) $(pci32-y)
+obj-$(CONFIG_PCI_MSI)		+= msi.o
 kexec-$(CONFIG_PPC64)		:= machine_kexec_64.o
 kexec-$(CONFIG_PPC32)		:= machine_kexec_32.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o crash.o $(kexec-y)
Index: msi-new/arch/powerpc/kernel/msi.c
===================================================================
--- /dev/null
+++ msi-new/arch/powerpc/kernel/msi.c
@@ -0,0 +1,38 @@
+/*
+ * Copyright 2006-2007, Michael Ellerman, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/msi.h>
+
+#include <asm/machdep.h>
+
+int arch_msi_check_device(struct pci_dev* dev, int nvec, int type)
+{
+	if (!ppc_md.setup_msi_irqs || !ppc_md.teardown_msi_irqs) {
+		pr_debug("msi: Platform doesn't provide MSI callbacks.\n");
+		return -ENOSYS;
+	}
+
+	if (ppc_md.msi_check_device) {
+		pr_debug("msi: Using platform check routine.\n");
+		return ppc_md.msi_check_device(dev, nvec, type);
+	}
+
+        return 0;
+}
+
+int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	return ppc_md.setup_msi_irqs(dev, nvec, type);
+}
+
+void arch_teardown_msi_irqs(struct pci_dev *dev)
+{
+	return ppc_md.teardown_msi_irqs(dev);
+}
Index: msi-new/include/asm-powerpc/machdep.h
===================================================================
--- msi-new.orig/include/asm-powerpc/machdep.h
+++ msi-new/include/asm-powerpc/machdep.h
@@ -115,6 +115,14 @@ struct machdep_calls {
 	/* To setup PHBs when using automatic OF platform driver for PCI */
 	int		(*pci_setup_phb)(struct pci_controller *host);
 
+#ifdef CONFIG_PCI_MSI
+	int		(*msi_check_device)(struct pci_dev* dev,
+					    int nvec, int type);
+	int		(*setup_msi_irqs)(struct pci_dev *dev,
+					  int nvec, int type);
+	void		(*teardown_msi_irqs)(struct pci_dev *dev);
+#endif
+
 	void		(*restart)(char *cmd);
 	void		(*power_off)(void);
 	void		(*halt)(void);
