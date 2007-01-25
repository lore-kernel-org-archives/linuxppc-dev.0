Return-Path: <michael@ozlabs.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 25 Jan 2007 19:34:12 +1100
Subject: [RFC/PATCH 8/16] Enable MSI on Powerpc
In-Reply-To: <1169714047.65693.647693675533.qpush@cradle>
Message-Id: <20070125083413.98C3FDE358@ozlabs.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, "David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Allow PCI_MSI to build on Powerpc. Until we merge and enable some
backends, pci_enable_msi() etc. will always return an error.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/pci/Kconfig           |    3 ++-
 include/asm-powerpc/machdep.h |    4 ++++
 include/asm-powerpc/msi.h     |   23 +++++++++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

Index: msi/drivers/pci/Kconfig
===================================================================
--- msi.orig/drivers/pci/Kconfig
+++ msi/drivers/pci/Kconfig
@@ -4,7 +4,8 @@
 config PCI_MSI
 	bool "Message Signaled Interrupts (MSI and MSI-X)"
 	depends on PCI
-	depends on (X86_LOCAL_APIC && X86_IO_APIC) || IA64
+	depends on (X86_LOCAL_APIC && X86_IO_APIC) || IA64 || PPC_MERGE
+	select PCI_MSI_NEW if PPC_MERGE
 	help
 	   This allows device drivers to enable MSI (Message Signaled
 	   Interrupts).  Message Signaled Interrupts enable a device to
Index: msi/include/asm-powerpc/machdep.h
===================================================================
--- msi.orig/include/asm-powerpc/machdep.h
+++ msi/include/asm-powerpc/machdep.h
@@ -30,6 +30,7 @@ struct pci_controller;
 #ifdef CONFIG_KEXEC
 struct kimage;
 #endif
+struct msi_ops;
 
 #ifdef CONFIG_SMP
 struct smp_ops_t {
@@ -111,6 +112,9 @@ struct machdep_calls {
 	void		(*pcibios_fixup)(void);
 	int		(*pci_probe_mode)(struct pci_bus *);
 	void		(*pci_irq_fixup)(struct pci_dev *dev);
+#ifdef CONFIG_PCI_MSI
+	struct msi_ops*	(*get_msi_ops)(struct pci_dev *pdev);
+#endif
 
 	/* To setup PHBs when using automatic OF platform driver for PCI */
 	int		(*pci_setup_phb)(struct pci_controller *host);
Index: msi/include/asm-powerpc/msi.h
===================================================================
--- /dev/null
+++ msi/include/asm-powerpc/msi.h
@@ -0,0 +1,23 @@
+#ifndef __ASM_POWERPC_MSI_H
+#define __ASM_POWERPC_MSI_H
+/*
+ * Copyright (C) 2006-2007 Michael Ellerman, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2 of the
+ * License.
+ *
+ */
+
+#include <asm/machdep.h>
+
+static inline struct msi_ops *arch_get_msi_ops(struct pci_dev *pdev)
+{
+	if (ppc_md.get_msi_ops)
+		return ppc_md.get_msi_ops(pdev);
+
+	return NULL;
+}
+
+#endif /* __ASM_POWERPC_MSI_H */
