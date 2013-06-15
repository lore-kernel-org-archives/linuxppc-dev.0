Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 132152C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 19:03:43 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sat, 15 Jun 2013 05:03:41 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 0E91338C8045
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 05:03:39 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5F93d10292704
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 05:03:39 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5F93c1W026652
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 06:03:39 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 27/27] powerpc/eeh: Debugfs for error injection
Date: Sat, 15 Jun 2013 17:03:18 +0800
Message-Id: <1371286998-2842-28-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371286998-2842-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371286998-2842-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch creates debugfs entries (powerpc/PCIxxxx/err_injct) for
injecting EEH errors for testing purpose.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |   33 ++++++++++++++++++++++++++++-
 1 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 95f7d96..ff7a504 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/bootmem.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -34,6 +35,29 @@
 #include "powernv.h"
 #include "pci.h"
 
+#ifdef CONFIG_DEBUG_FS
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
+#endif /* CONFIG_DEBUG_FS */
+
 /**
  * ioda_eeh_post_init - Chip dependent post initialization
  * @hose: PCI controller
@@ -47,8 +71,15 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
 	struct pnv_phb *phb = hose->private_data;
 
 	/* FIXME: Enable it for PHB3 later */
-	if (phb->type == PNV_PHB_IODA1)
+	if (phb->type == PNV_PHB_IODA1) {
+#ifdef CONFIG_DEBUG_FS
+		if (phb->dbgfs)
+			debugfs_create_file("err_injct", 0600,
+				phb->dbgfs, hose, &ioda_eeh_dbgfs_ops);
+#endif
+
 		phb->eeh_enabled = 1;
+	}
 
 	return 0;
 }
-- 
1.7.5.4
