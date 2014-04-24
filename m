Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0191F140179
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:33 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:33 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id ED4F13578053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:30 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O80Gbg131514
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:16 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80URW015024
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:30 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 19/25] powrpc/powernv: Reset PHB in kdump kernel
Date: Thu, 24 Apr 2014 18:00:25 +1000
Message-Id: <1398326431-24305-20-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the kdump scenario, the first kerenl doesn't shutdown PCI devices
and the kdump kerenl clean PHB IODA table at the early probe time.
That means the kdump kerenl can't support PCI transactions piled
by the first kerenl. Otherwise, lots of EEH errors and frozen PEs
will be detected.

In order to avoid the EEH errors, the PHB is resetted to drop all
PCI transaction from the first kerenl.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 15 +++++++++++----
 arch/powerpc/platforms/powernv/pci-ioda.c | 12 ++++++++++++
 arch/powerpc/platforms/powernv/pci.h      |  1 +
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 58ef809..753f08e 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -388,13 +388,16 @@ static s64 ioda_eeh_phb_poll(struct pnv_phb *phb)
 		if (rc <= 0)
 			break;
 
-		msleep(rc);
+		if (system_state < SYSTEM_RUNNING)
+			udelay(1000 * rc);
+		else
+			msleep(rc);
 	}
 
 	return rc;
 }
 
-static int ioda_eeh_phb_reset(struct pci_controller *hose, int option)
+int ioda_eeh_phb_reset(struct pci_controller *hose, int option)
 {
 	struct pnv_phb *phb = hose->private_data;
 	s64 rc = OPAL_HARDWARE;
@@ -422,8 +425,12 @@ static int ioda_eeh_phb_reset(struct pci_controller *hose, int option)
 	 * need the PCI bus settlement delay.
 	 */
 	rc = ioda_eeh_phb_poll(phb);
-	if (option == EEH_RESET_DEACTIVATE)
-		msleep(EEH_PE_RST_SETTLE_TIME);
+	if (option == EEH_RESET_DEACTIVATE) {
+		if (system_state < SYSTEM_RUNNING)
+			udelay(1000 * EEH_PE_RST_SETTLE_TIME);
+		else
+			msleep(EEH_PE_RST_SETTLE_TIME);
+	}
 out:
 	if (rc != OPAL_SUCCESS)
 		return -EIO;
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 0bfc4d1..6a2cb37 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/crash_dump.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/string.h>
@@ -1394,6 +1395,17 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	rc = opal_pci_reset(phb_id, OPAL_PCI_IODA_TABLE_RESET, OPAL_ASSERT_RESET);
 	if (rc)
 		pr_warning("  OPAL Error %ld performing IODA table reset !\n", rc);
+
+	/* If we're running in kdump kerenl, the previous kerenl never
+	 * shutdown PCI devices correctly. We already got IODA table
+	 * cleaned out. So we have to issue PHB reset to stop all PCI
+	 * transactions from previous kerenl.
+	 */
+	if (is_kdump_kernel()) {
+		pr_info("  Issue PHB reset ...\n");
+		ioda_eeh_phb_reset(hose, EEH_RESET_FUNDAMENTAL);
+		ioda_eeh_phb_reset(hose, OPAL_DEASSERT_RESET);
+	}
 }
 
 void __init pnv_pci_init_ioda2_phb(struct device_node *np)
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 34a0974..676232c 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -205,5 +205,6 @@ extern void pnv_pci_init_ioda2_phb(struct device_node *np);
 extern void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
 					__be64 *startp, __be64 *endp, bool rm);
 extern void pnv_pci_reset_secondary_bus(struct pci_dev *dev);
+extern int ioda_eeh_phb_reset(struct pci_controller *hose, int option);
 
 #endif /* __POWERNV_PCI_H */
-- 
1.8.3.2
