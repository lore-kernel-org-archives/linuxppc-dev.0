Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7F3962C033D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 18:24:31 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 30 May 2013 04:24:28 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id AC0696E803C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 04:24:23 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4U8ORYX239296
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 04:24:27 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4U8OQGW023161
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 04:24:26 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 23/23] powerpc/eeh: Add debugfs entry to inject errors
Date: Thu, 30 May 2013 16:24:05 +0800
Message-Id: <1369902245-5886-24-git-send-email-shangw@linux.vnet.ibm.com>
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

The patch intends to add debugfs entry powerpc/EEH/PHBx so that
the administrator can inject EEH errors to specified PCI host
bridge for testing purpose.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |   36 ++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index ec5c524..4cc9db7 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -22,6 +22,7 @@
 
 #include <linux/bootmem.h>
 #include <linux/delay.h>
+#include <linux/debugfs.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -43,6 +44,29 @@
 #include "powernv.h"
 #include "pci.h"
 
+static struct dentry *ioda_eeh_dbgfs = NULL;
+
+static int ioda_eeh_dbgfs_set(void *data, u64 val)
+{
+	struct pci_controller *hose = data;
+	struct pnv_phb *phb = hose->private_data;
+
+	out_be64(phb->regs + 0xD10, val);
+	return 0;
+}
+
+static int ioda_eeh_dbgfs_get(void *data, u64 *val)
+{
+	struct pci_controller *hose = data;
+	struct pnv_phb *phb = hose->private_data;
+
+	*val = in_be64(phb->regs + 0xD10);
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(ioda_eeh_dbgfs_ops, ioda_eeh_dbgfs_get,
+			ioda_eeh_dbgfs_set, "0x%llx\n");
+
 /**
  * ioda_eeh_post_init - Chip dependent post initialization
  * @hose: PCI controller
@@ -54,10 +78,20 @@
 static int ioda_eeh_post_init(struct pci_controller *hose)
 {
 	struct pnv_phb *phb = hose->private_data;
+	char name[16];
+
+	/* Create EEH debugfs root if possible */
+	if (!ioda_eeh_dbgfs)
+		ioda_eeh_dbgfs = debugfs_create_dir("EEH", powerpc_debugfs_root);
 
 	/* FIXME: Enable it for PHB3 later */
-	if (phb->type == PNV_PHB_IODA1)
+	if (phb->type == PNV_PHB_IODA1) {
+		sprintf(name, "PHB%d", hose->global_number);
+		debugfs_create_file(name, 0600, ioda_eeh_dbgfs,
+				    hose, &ioda_eeh_dbgfs_ops);
+
 		phb->eeh_enabled = 1;
+	}
 
 	return 0;
 }
-- 
1.7.5.4
