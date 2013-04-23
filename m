Return-Path: <B16395@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 94B892C0164
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 14:44:06 +1000 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <galak@kernel.crashing.org>, <benh@kernel.crashing.org>,
 <stuart.yoder@freescale.com>, <scottwood@freescale.com>
Subject: [PATCH 1/3 v2] iommu: Move swap_pci_ref function to pci.h.
Date: Tue, 23 Apr 2013 10:05:24 +0530
Message-ID: <1366691726-9023-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

swap_pci_ref function is used by the IOMMU API code for swapping pci device
pointers, while determining the iommu group for the device.
Currently this function was being implemented for different IOMMU drivers.
This patch moves the function to a new file, drivers/iommu/pci.h so that the
implementation can be shared across various IOMMU drivers.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
v2 changes:
- created a new file drivers/iommu/pci.h.

 drivers/iommu/amd_iommu.c   |    7 +------
 drivers/iommu/intel-iommu.c |    7 +------
 drivers/iommu/pci.h         |   29 +++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 12 deletions(-)
 create mode 100644 drivers/iommu/pci.h

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a7f6b04..2463464 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -46,6 +46,7 @@
 #include "amd_iommu_proto.h"
 #include "amd_iommu_types.h"
 #include "irq_remapping.h"
+#include "pci.h"
 
 #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
 
@@ -263,12 +264,6 @@ static bool check_device(struct device *dev)
 	return true;
 }
 
-static void swap_pci_ref(struct pci_dev **from, struct pci_dev *to)
-{
-	pci_dev_put(*from);
-	*from = to;
-}
-
 static struct pci_bus *find_hosted_bus(struct pci_bus *bus)
 {
 	while (!bus->self) {
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6e0b9ff..81ad7b8 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -47,6 +47,7 @@
 #include <asm/iommu.h>
 
 #include "irq_remapping.h"
+#include "pci.h"
 
 #define ROOT_SIZE		VTD_PAGE_SIZE
 #define CONTEXT_SIZE		VTD_PAGE_SIZE
@@ -4137,12 +4138,6 @@ static int intel_iommu_domain_has_cap(struct iommu_domain *domain,
 	return 0;
 }
 
-static void swap_pci_ref(struct pci_dev **from, struct pci_dev *to)
-{
-	pci_dev_put(*from);
-	*from = to;
-}
-
 #define REQ_ACS_FLAGS	(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
 
 static int intel_iommu_add_device(struct device *dev)
diff --git a/drivers/iommu/pci.h b/drivers/iommu/pci.h
new file mode 100644
index 0000000..d460646
--- /dev/null
+++ b/drivers/iommu/pci.h
@@ -0,0 +1,29 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright (C) 2013 Red Hat, Inc.
+ * Copyright (C) 2013 Freescale Semiconductor, Inc.
+ *
+ */
+#ifndef __PCI_H
+#define __PCI_H
+
+/* Helper function for swapping pci device reference */
+static inline void swap_pci_ref(struct pci_dev **from, struct pci_dev *to)
+{
+	pci_dev_put(*from);
+	*from = to;
+}
+
+#endif  /* __PCI_H */
-- 
1.7.4.1
