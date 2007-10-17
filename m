Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
Message-Id: <8f76815cbbaf5fbab82c843d87bc0dafab038c80.1192605144.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/2] Introduce of_get_pci_dev_node()
Date: Wed, 17 Oct 2007 17:12:26 +1000 (EST)
Cc: sparclinux@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	"David S. Miller" <davem@davemloft.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Both powerpc and sparc have a routine, pci_device_to_OF_node(), which
returns the device_node associated with a given pci device.

The new routine, of_get_pci_dev_node(), performs exactly the same function
with the one exception that it returns a refcounted pointer to the
device_node, callers must then release the reference with of_node_put().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 drivers/of/Makefile |    1 +
 drivers/of/pci.c    |   24 ++++++++++++++++++++++++
 include/linux/of.h  |    3 +++
 3 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index ab9be5d..f49898c 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -1,2 +1,3 @@
 obj-y = base.o
 obj-$(CONFIG_OF_DEVICE) += device.o platform.o
+obj-$(CONFIG_PCI)	+= pci.o
diff --git a/drivers/of/pci.c b/drivers/of/pci.c
new file mode 100644
index 0000000..2319c22
--- /dev/null
+++ b/drivers/of/pci.c
@@ -0,0 +1,24 @@
+/*
+ * Copyright 2007 Michael Ellerman, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/of.h>
+#include <linux/pci.h>
+
+/**
+ * of_get_pci_dev_node - Get a device node from a pci_dev
+ * @pdev: pci_dev to get the node from
+ *
+ * Returns a node pointer with refcount incremented, use
+ * of_node_put() on it when done.
+ */
+struct device_node *of_get_pci_dev_node(struct pci_dev *pdev)
+{
+	return of_node_get(pci_device_to_OF_node(pdev));
+}
+EXPORT_SYMBOL(of_get_pci_dev_node);
diff --git a/include/linux/of.h b/include/linux/of.h
index 6df80e9..e5bfb13 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -57,4 +57,7 @@ extern const void *of_get_property(const struct device_node *node,
 extern int of_n_addr_cells(struct device_node *np);
 extern int of_n_size_cells(struct device_node *np);
 
+struct pci_dev;
+extern struct device_node *of_get_pci_dev_node(struct pci_dev *pdev);
+
 #endif /* _LINUX_OF_H */
-- 
1.5.1.3.g7a33b
