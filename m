Return-Path: <B35336@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe002.messaging.microsoft.com
 [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 56418B6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2012 21:18:50 +1100 (EST)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/mpc85xxcds: Fix PCI I/O space resource of PCI bridge
Date: Wed, 22 Feb 2012 18:20:14 +0800
Message-ID: <1329906014-9896-2-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1329906014-9896-1-git-send-email-chenhui.zhao@freescale.com>
References: <1329906014-9896-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: chenhui zhao <chenhui.zhao@freescale.com>

There is a PCI bridge(Tsi310) between the MPC8548 and a VIA
southbridge chip.

The bootloader sets the PCI bridge to open a window from 0x0000
to 0x1fff on the PCI I/O space. But the kernel can't set the I/O
resource. In the routine pci_read_bridge_io(), if the base which
is read from PCI_IO_BASE is equal to zero, the routine don't set
the I/O resource of the child bus.

To allow the legacy I/O space on the VIA southbridge to be accessed,
use the fixup to fix the PCI I/O space of the PCI bridge.

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   30 +++++++++++++++++++++++++++-
 include/linux/pci_ids.h                   |    1 +
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 40f03da..96947c4 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -3,7 +3,7 @@
  *
  * Maintained by Kumar Gala (see MAINTAINERS for contact information)
  *
- * Copyright 2005 Freescale Semiconductor Inc.
+ * Copyright 2005, 2011-2012 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -158,6 +158,32 @@ DECLARE_PCI_FIXUP_EARLY(0x1957, 0x3fff, skip_fake_bridge);
 DECLARE_PCI_FIXUP_EARLY(0x3fff, 0x1957, skip_fake_bridge);
 DECLARE_PCI_FIXUP_EARLY(0xff3f, 0x5719, skip_fake_bridge);
 
+/*
+ * Fix Tsi310 PCI-X bridge resource.
+ * Force the bridge to open a window from 0x0000-0x1fff in PCI I/O space.
+ * This allows legacy I/O(i8259, etc) on the VIA southbridge to be accessed.
+ */
+void mpc85xx_cds_fixup_bus(struct pci_bus *bus)
+{
+	struct pci_dev *dev = bus->self;
+	struct resource *res = bus->resource[0];
+
+	if (dev != NULL &&
+	    dev->vendor == PCI_VENDOR_ID_IBM &&
+	    dev->device == PCI_DEVICE_ID_TSI310) {
+		if (res) {
+			res->start = 0;
+			res->end   = 0x1fff;
+			res->flags = IORESOURCE_IO;
+			pr_info("mpc85xx_cds: PCI bridge resource \
+							fixup applied\n");
+			pr_info("mpc85xx_cds: %pR\n", res);
+		}
+	}
+
+	fsl_pcibios_fixup_bus(bus);
+}
+
 #ifdef CONFIG_PPC_I8259
 static void mpc85xx_8259_cascade_handler(unsigned int irq,
 					 struct irq_desc *desc)
@@ -323,7 +349,7 @@ define_machine(mpc85xx_cds) {
 	.get_irq	= mpic_get_irq,
 #ifdef CONFIG_PCI
 	.restart	= mpc85xx_cds_restart,
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+	.pcibios_fixup_bus	= mpc85xx_cds_fixup_bus,
 #else
 	.restart	= fsl_rstcr_restart,
 #endif
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 31d77af..17f1b95 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -484,6 +484,7 @@
 #define PCI_DEVICE_ID_IBM_ICOM_V2_ONE_PORT_RVX_ONE_PORT_MDM	0x0251
 #define PCI_DEVICE_ID_IBM_ICOM_V2_ONE_PORT_RVX_ONE_PORT_MDM_PCIE 0x0361
 #define PCI_DEVICE_ID_IBM_ICOM_FOUR_PORT_MODEL	0x252
+#define PCI_DEVICE_ID_TSI310		0x01a7
 
 #define PCI_SUBVENDOR_ID_IBM		0x1014
 #define PCI_SUBDEVICE_ID_IBM_SATURN_SERIAL_ONE_PORT	0x03d4
-- 
1.6.4.1
