Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 808BD2C0447
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 18:35:10 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 18 Jun 2013 04:35:08 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id E07F96E804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 04:35:00 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5I8YYZl264116
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 04:34:34 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5I8YXYm022252
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 05:34:34 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 30/31] powerpc/powernv: Debugfs directory for PHB
Date: Tue, 18 Jun 2013 16:33:54 +0800
Message-Id: <1371544435-4943-31-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch creates one debugfs directory ("powerpc/PCIxxxx") for
each PHB so that we can hook EEH error injection debugfs entry
there in proceeding patch.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   22 ++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h      |    4 ++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 48b0940..0d9d302 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/init.h>
@@ -968,12 +969,33 @@ static void pnv_pci_ioda_setup_DMA(void)
 	}
 }
 
+static void pnv_pci_ioda_create_dbgfs(void)
+{
+#ifdef CONFIG_DEBUG_FS
+	struct pci_controller *hose, *tmp;
+	struct pnv_phb *phb;
+	char name[16];
+
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+		phb = hose->private_data;
+
+		sprintf(name, "PCI%04x", hose->global_number);
+		phb->dbgfs = debugfs_create_dir(name, powerpc_debugfs_root);
+		if (!phb->dbgfs)
+			pr_warning("%s: Error on creating debugfs on PHB#%x\n",
+				__func__, hose->global_number);
+	}
+#endif /* CONFIG_DEBUG_FS */
+}
+
 static void pnv_pci_ioda_fixup(void)
 {
 	pnv_pci_ioda_setup_PEs();
 	pnv_pci_ioda_setup_seg();
 	pnv_pci_ioda_setup_DMA();
 
+	pnv_pci_ioda_create_dbgfs();
+
 #ifdef CONFIG_EEH
 	eeh_addr_cache_build();
 	eeh_init();
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 3656a240..43906e3 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -96,6 +96,10 @@ struct pnv_phb {
 	int			removed;
 #endif
 
+#ifdef CONFIG_DEBUG_FS
+	struct dentry		*dbgfs;
+#endif
+
 #ifdef CONFIG_PCI_MSI
 	unsigned int		msi_base;
 	unsigned int		msi32_support;
-- 
1.7.5.4
