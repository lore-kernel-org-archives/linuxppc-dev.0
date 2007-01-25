Return-Path: <michael@ozlabs.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 25 Jan 2007 19:34:10 +1100
Subject: [RFC/PATCH 6/16] Add bare metal MSI enable & disable routines
In-Reply-To: <1169714047.65693.647693675533.qpush@cradle>
Message-Id: <20070125083412.077F8DE320@ozlabs.org>
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

Add bare metal MSI enable & disable routines.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/pci/msi/Makefile |    2 -
 drivers/pci/msi/raw.c    |   94 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/msi-ops.h  |    5 ++
 3 files changed, 100 insertions(+), 1 deletion(-)

Index: msi/drivers/pci/msi/Makefile
===================================================================
--- msi.orig/drivers/pci/msi/Makefile
+++ msi/drivers/pci/msi/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the PCI MSI support
 #
 
-obj-y			+= core.o
+obj-y			+= core.o raw.o
 
 ifeq ($(CONFIG_PCI_MSI_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
Index: msi/drivers/pci/msi/raw.c
===================================================================
--- /dev/null
+++ msi/drivers/pci/msi/raw.c
@@ -0,0 +1,94 @@
+/*
+ * Bare metal MSI enable & disable.
+ *
+ * Copyright 2006-2007, Michael Ellerman, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/msi-ops.h>
+#include <linux/pci.h>
+#include <asm/msi.h>
+
+int msi_raw_enable(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type)
+{
+	struct msi_ops *ops;
+	struct msi_msg msg;
+	int pos;
+	u16 control;
+
+	pos = pci_find_capability(pdev, type);
+	if (!pos) {
+		msi_debug("cap (%d) not found for %s\n", type, pci_name(pdev));
+		return -1;
+	}
+
+	ops = arch_get_msi_ops(pdev);
+	BUG_ON(!ops);
+
+	pci_read_config_word(pdev, pos + PCI_MSI_FLAGS, &control);
+
+	switch (type) {
+	case PCI_CAP_ID_MSI:
+		BUG_ON(!ops->setup_msi_msg);
+
+		ops->setup_msi_msg(pdev, &entries[0], &msg, type);
+
+		pci_write_config_dword(pdev, pos + PCI_MSI_ADDRESS_LO,
+			msg.address_lo);
+
+		if (control & PCI_MSI_FLAGS_64BIT) {
+			pci_write_config_dword(pdev, pos + PCI_MSI_ADDRESS_HI,
+						msg.address_hi);
+			pci_write_config_dword(pdev, pos + PCI_MSI_DATA_64,
+						msg.data);
+		} else {
+			pci_write_config_dword(pdev, pos + PCI_MSI_DATA_32,
+						msg.data);
+		}
+
+		control |= PCI_MSI_FLAGS_ENABLE;
+		break;
+	case PCI_CAP_ID_MSIX:
+		WARN_ON(1); /* XXX implement me */
+		return -1;
+	default:
+		BUG();
+	}
+
+	pci_write_config_word(pdev, pos + PCI_MSI_FLAGS, control);
+
+	return 0;
+}
+
+void msi_raw_disable(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type)
+{
+	int pos;
+	u16 control;
+
+	pos = pci_find_capability(pdev, type);
+	BUG_ON(!pos);
+
+	pci_read_config_word(pdev, pos + PCI_MSI_FLAGS, &control);
+
+	switch (type) {
+	case PCI_CAP_ID_MSI:
+		control &= ~PCI_MSI_FLAGS_ENABLE;
+		break;
+	case PCI_CAP_ID_MSIX:
+		control &= ~PCI_MSIX_FLAGS_ENABLE;
+		break;
+	default:
+		BUG();
+	}
+
+	pci_write_config_word(pdev, pos + PCI_MSI_FLAGS, control);
+
+	return;
+}
Index: msi/include/linux/msi-ops.h
===================================================================
--- msi.orig/include/linux/msi-ops.h
+++ msi/include/linux/msi-ops.h
@@ -163,6 +163,11 @@ struct msi_info {
 #define msi_debug(fmt, args...)	\
 	pr_debug("MSI:%s:%d: " fmt, __FUNCTION__, __LINE__, ## args)
 
+extern int msi_raw_enable(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type);
+extern void msi_raw_disable(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type);
+
 #endif /* __KERNEL__ */
 #endif /* __ASSEMBLY__ */
 #endif /* LINUX_MSI_OPS_H */
