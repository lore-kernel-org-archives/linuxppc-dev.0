Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AFEDD2C00DE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 13:35:17 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 14 May 2013 21:35:15 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 6E8C03E40030
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 21:34:57 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4F3ZCNn112732
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 21:35:12 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4F3ZBPF003782
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 21:35:11 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/22] powerpc/eeh: EEH backend for P7IOC
Date: Wed, 15 May 2013 11:34:48 +0800
Message-Id: <1368588898-16224-13-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1368588898-16224-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1368588898-16224-1-git-send-email-shangw@linux.vnet.ibm.com>
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
index 48dc4bb..a7b3902 100644
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
@@ -149,6 +168,9 @@ struct pnv_phb {
 };
 
 extern struct pci_ops pnv_pci_ops;
+#ifdef CONFIG_EEH
+extern struct pnv_eeh_ops ioda_eeh_ops;
+#endif
 
 extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 				      void *tce_mem, u64 tce_size,
-- 
1.7.5.4
