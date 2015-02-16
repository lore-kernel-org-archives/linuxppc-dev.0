Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E02751A0268
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 14:47:25 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AC763140213
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:25 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 16 Feb 2015 13:47:25 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 11BFE2CE8050
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:24 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1G3lFKk28639396
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:24 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1G3kobN031083
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:46:50 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/10] powerpc/powernv: Remove unused file
Date: Mon, 16 Feb 2015 14:45:48 +1100
Message-Id: <1424058348-28951-11-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1424058348-28951-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1424058348-28951-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch removes unused file eeh-ioda.c and updates makefile
accordingly. Besides, the definition of "struct pnv_eeh_ops" and
the instances are all removed. Until now, the chip layer of EEH
implementation for PowerNV platform is removed completely.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/Makefile   |  2 +-
 arch/powerpc/platforms/powernv/eeh-ioda.c | 38 -------------------------------
 arch/powerpc/platforms/powernv/pci-ioda.c |  3 ---
 arch/powerpc/platforms/powernv/pci.h      | 13 -----------
 4 files changed, 1 insertion(+), 55 deletions(-)
 delete mode 100644 arch/powerpc/platforms/powernv/eeh-ioda.c

diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 6f3c5d3..33e44f3 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -5,7 +5,7 @@ obj-y			+= opal-msglog.o opal-hmi.o opal-power.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
-obj-$(CONFIG_EEH)	+= eeh-ioda.o eeh-powernv.o
+obj-$(CONFIG_EEH)	+= eeh-powernv.o
 obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
 obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
 obj-$(CONFIG_TRACEPOINTS)	+= opal-tracepoints.o
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
deleted file mode 100644
index 9fcfc45..0000000
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * The file intends to implement the functions needed by EEH, which is
- * built on IODA compliant chip. Actually, lots of functions related
- * to EEH would be built based on the OPAL APIs.
- *
- * Copyright Benjamin Herrenschmidt & Gavin Shan, IBM Corporation 2013.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include <linux/debugfs.h>
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/kernel.h>
-#include <linux/msi.h>
-#include <linux/notifier.h>
-#include <linux/pci.h>
-#include <linux/string.h>
-
-#include <asm/eeh.h>
-#include <asm/eeh_event.h>
-#include <asm/io.h>
-#include <asm/iommu.h>
-#include <asm/msi_bitmap.h>
-#include <asm/opal.h>
-#include <asm/pci-bridge.h>
-#include <asm/ppc-pci.h>
-#include <asm/tce.h>
-
-#include "powernv.h"
-#include "pci.h"
-
-struct pnv_eeh_ops ioda_eeh_ops = {
-};
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 4e21596..26fe099 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2078,9 +2078,6 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	phb->get_pe_state = pnv_ioda_get_pe_state;
 	phb->freeze_pe = pnv_ioda_freeze_pe;
 	phb->unfreeze_pe = pnv_ioda_unfreeze_pe;
-#ifdef CONFIG_EEH
-	phb->eeh_ops = &ioda_eeh_ops;
-#endif
 
 	/* Setup RID -> PE mapping function */
 	phb->bdfn_to_pe = pnv_ioda_bdfn_to_pe;
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 39f2ca3..18ae927 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -75,12 +75,6 @@ struct pnv_ioda_pe {
 	struct list_head	list;
 };
 
-/* IOC dependent EEH operations */
-#ifdef CONFIG_EEH
-struct pnv_eeh_ops {
-};
-#endif /* CONFIG_EEH */
-
 #define PNV_PHB_FLAG_EEH	(1 << 0)
 
 struct pnv_phb {
@@ -94,10 +88,6 @@ struct pnv_phb {
 	int			initialized;
 	spinlock_t		lock;
 
-#ifdef CONFIG_EEH
-	struct pnv_eeh_ops	*eeh_ops;
-#endif
-
 #ifdef CONFIG_DEBUG_FS
 	int			has_dbgfs;
 	struct dentry		*dbgfs;
@@ -203,9 +193,6 @@ struct pnv_phb {
 };
 
 extern struct pci_ops pnv_pci_ops;
-#ifdef CONFIG_EEH
-extern struct pnv_eeh_ops ioda_eeh_ops;
-#endif
 
 void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
 				unsigned char *log_buff);
-- 
1.8.3.2
