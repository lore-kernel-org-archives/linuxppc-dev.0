Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D79B82C0314
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 18:24:26 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 30 May 2013 04:24:24 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id D3DB56E8048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 04:24:16 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4U8OK49316842
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 04:24:20 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4U8OJZi000559
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 05:24:20 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/23] powerpc/eeh: EEH backend for P7IOC
Date: Thu, 30 May 2013 16:23:54 +0800
Message-Id: <1369902245-5886-13-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For EEH on PowerNV platform, the overall architecture is a bit
different from that on pSeries platform. In order to support multiple
I/O chips in future, we split EEH to 3 layers for PowerNV platform:
EEH core, platform layer, I/O layer. It would give EEH implementation
on PowerNV much more flexibility in future.

The patch adds the EEH backend for P7IOC.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/Makefile   |    1 +
 arch/powerpc/platforms/powernv/eeh-ioda.c |   53 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h      |   22 ++++++++++++
 3 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/eeh-ioda.c

diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index bcc3cb4..09bd0cb 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -3,3 +3,4 @@ obj-y			+= opal-rtc.o opal-nvram.o
 
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
+obj-$(CONFIG_EEH)	+= eeh-ioda.o
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
new file mode 100644
index 0000000..b344576
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -0,0 +1,53 @@
+/*
+ * The file intends to implement the functions needed by EEH, which is
+ * built on IODA compliant chip. Actually, lots of functions related
+ * to EEH would be built based on the OPAL APIs.
+ *
+ * Copyright Benjamin Herrenschmidt & Gavin Shan, IBM Corporation 2013.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/bootmem.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/msi.h>
+#include <linux/pci.h>
+#include <linux/string.h>
+
+#include <asm/eeh.h>
+#include <asm/eeh_event.h>
+#include <asm/io.h>
+#include <asm/iommu.h>
+#include <asm/msi_bitmap.h>
+#include <asm/opal.h>
+#include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
+#include <asm/tce.h>
+
+#include "powernv.h"
+#include "pci.h"
+
+struct pnv_eeh_ops ioda_eeh_ops = {
+	.post_init		= NULL,
+	.set_option		= NULL,
+	.get_state		= NULL,
+	.reset			= NULL,
+	.get_log		= NULL,
+	.configure_bridge	= NULL
+};
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 25d76c4..1770188 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -66,15 +66,34 @@ struct pnv_ioda_pe {
 	struct list_head	list;
 };
 
+/* IOC dependent EEH operations */
+#ifdef CONFIG_EEH
+struct pnv_eeh_ops {
+	int (*post_init)(struct pci_controller *hose);
+	int (*set_option)(struct eeh_pe *pe, int option);
+	int (*get_state)(struct eeh_pe *pe, int *state);
+	int (*reset)(struct eeh_pe *pe, int option);
+	int (*get_log)(struct eeh_pe *pe, int severity,
+		       char *drv_log, unsigned long len);
+	int (*configure_bridge)(struct eeh_pe *pe);
+};
+#endif /* CONFIG_EEH */
+
 struct pnv_phb {
 	struct pci_controller	*hose;
 	enum pnv_phb_type	type;
 	enum pnv_phb_model	model;
+	u64			hub_id;
 	u64			opal_id;
 	void __iomem		*regs;
 	int			initialized;
 	spinlock_t		lock;
 
+#ifdef CONFIG_EEH
+	struct pnv_eeh_ops	*eeh_ops;
+	int			eeh_enabled;
+#endif
+
 #ifdef CONFIG_PCI_MSI
 	unsigned int		msi_base;
 	unsigned int		msi32_support;
@@ -150,6 +169,9 @@ struct pnv_phb {
 };
 
 extern struct pci_ops pnv_pci_ops;
+#ifdef CONFIG_EEH
+extern struct pnv_eeh_ops ioda_eeh_ops;
+#endif
 
 extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 				      void *tce_mem, u64 tce_size,
-- 
1.7.5.4
