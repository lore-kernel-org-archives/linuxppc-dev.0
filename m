Return-Path: <dja@axtens.net>
Received: from mail-pd0-x22b.google.com (mail-pd0-x22b.google.com
 [IPv6:2607:f8b0:400e:c02::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E94BC1A0A16
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:37:11 +1100 (AEDT)
Received: by pdbcz9 with SMTP id cz9so17006015pdb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:37:10 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 20/27] powerpc/cell: Move controller ops from ppc_md to
 controller_ops
Date: Wed, 25 Mar 2015 16:35:54 +1100
Message-Id: <1427261761-22952-21-git-send-email-dja@axtens.net>
In-Reply-To: <1427261761-22952-1-git-send-email-dja@axtens.net>
References: <1427261761-22952-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves the Cell platform to use the pci_controller_ops
structure rather than ppc_md for PCI controller operations.

This depends on the patch to drop celleb support:
http://patchwork.ozlabs.org/patch/451730/

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/platforms/cell/cell.h  | 24 ++++++++++++++++++++++++
 arch/powerpc/platforms/cell/iommu.c |  7 ++++---
 arch/powerpc/platforms/cell/setup.c |  5 +++++
 3 files changed, 33 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/platforms/cell/cell.h

diff --git a/arch/powerpc/platforms/cell/cell.h b/arch/powerpc/platforms/cell/cell.h
new file mode 100644
index 0000000..ef143df
--- /dev/null
+++ b/arch/powerpc/platforms/cell/cell.h
@@ -0,0 +1,24 @@
+/*
+ * Cell Platform common data structures
+ *
+ * Copyright 2015, Daniel Axtens, IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef CELL_H
+#define CELL_H
+
+#include <asm/pci-bridge.h>
+
+extern struct pci_controller_ops cell_pci_controller_ops;
+
+#endif
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 31b1a67..4cb120f 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -39,6 +39,7 @@
 #include <asm/firmware.h>
 #include <asm/cell-regs.h>
 
+#include "cell.h"
 #include "interrupt.h"
 
 /* Define CELL_IOMMU_REAL_UNMAP to actually unmap non-used pages
@@ -857,7 +858,7 @@ static int __init cell_iommu_init_disabled(void)
 	cell_dma_direct_offset += base;
 
 	if (cell_dma_direct_offset != 0)
-		ppc_md.pci_dma_dev_setup = cell_pci_dma_dev_setup;
+		cell_pci_controller_ops.dma_dev_setup = cell_pci_dma_dev_setup;
 
 	printk("iommu: disabled, direct DMA offset is 0x%lx\n",
 	       cell_dma_direct_offset);
@@ -1197,8 +1198,8 @@ static int __init cell_iommu_init(void)
 		if (cell_iommu_init_disabled() == 0)
 			goto bail;
 
-	/* Setup various ppc_md. callbacks */
-	ppc_md.pci_dma_dev_setup = cell_pci_dma_dev_setup;
+	/* Setup various callbacks */
+	cell_pci_controller_ops.dma_dev_setup = cell_pci_dma_dev_setup;
 	ppc_md.dma_get_required_mask = cell_dma_get_required_mask;
 	ppc_md.tce_build = tce_build_cell;
 	ppc_md.tce_free = tce_free_cell;
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index d62aa98..d1be268 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -54,6 +54,7 @@
 #include <asm/cell-regs.h>
 #include <asm/io-workarounds.h>
 
+#include "cell.h"
 #include "interrupt.h"
 #include "pervasive.h"
 #include "ras.h"
@@ -131,6 +132,8 @@ static int cell_setup_phb(struct pci_controller *phb)
 	if (model == NULL || strcmp(np->name, "pci"))
 		return 0;
 
+	phb->controller_ops = cell_pci_controller_ops;
+
 	/* Setup workarounds for spider */
 	if (strcmp(model, "Spider"))
 		return 0;
@@ -279,3 +282,5 @@ define_machine(cell) {
 	.init_IRQ       	= cell_init_irq,
 	.pci_setup_phb		= cell_setup_phb,
 };
+
+struct pci_controller_ops cell_pci_controller_ops;
-- 
2.1.4
