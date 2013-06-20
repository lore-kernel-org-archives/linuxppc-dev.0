Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5215F2C039D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 15:21:51 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 19 Jun 2013 23:21:49 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 9BE031FF001D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 23:16:33 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5K5LlK7161182
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 23:21:47 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5K5LlNo004203
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 23:21:47 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 30/31] powerpc/powernv: Debugfs directory for PHB
Date: Thu, 20 Jun 2013 13:21:20 +0800
Message-Id: <1371705681-24632-31-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371705681-24632-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371705681-24632-1-git-send-email-shangw@linux.vnet.ibm.com>
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
