Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 757091A018E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 17:01:05 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 15 Jul 2014 17:01:03 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 854E52CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 17:01:00 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F70iMT7667990
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 17:00:44 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F70xrg028984
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 17:01:00 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/eeh: Fetch IOMMU table in reliable way
Date: Tue, 15 Jul 2014 17:00:56 +1000
Message-Id: <1405407656-3751-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1405407656-3751-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1405407656-3751-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Function eeh_iommu_group_to_pe() iterates each PCI device to check
the binding IOMMU group with get_iommu_table_base(), which possibly
fetches pdev->dev.archdata.dma_data.dma_offset. It's (0x1 << 59)
for "bypass" cases.

The patch fixes the issue by iterating devices hooked to the IOMMU
group and fetch IOMMU table there.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 18c40fd..4de2103 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -27,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/pci.h>
+#include <linux/iommu.h>
 #include <linux/proc_fs.h>
 #include <linux/rbtree.h>
 #include <linux/reboot.h>
@@ -1178,6 +1179,24 @@ out:
 }
 EXPORT_SYMBOL(eeh_dev_release);
 
+static int dev_has_iommu_table(struct device *dev, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev **ppdev = data;
+	struct iommu_table *tbl;
+
+	if (!dev)
+		return 0;
+
+	tbl = get_iommu_table_base(dev);
+	if (tbl && tbl->it_group) {
+		*ppdev = pdev;
+		return 1;
+	}
+
+	return 0;
+}
+
 /**
  * eeh_iommu_group_to_pe - Convert IOMMU group to EEH PE
  * @group: IOMMU group
@@ -1186,24 +1205,16 @@ EXPORT_SYMBOL(eeh_dev_release);
  */
 struct eeh_pe *eeh_iommu_group_to_pe(struct iommu_group *group)
 {
-	struct iommu_table *tbl;
 	struct pci_dev *pdev = NULL;
 	struct eeh_dev *edev;
-	bool found = false;
+	int ret;
 
 	/* No IOMMU group ? */
 	if (!group)
 		return NULL;
 
-	/* No PCI device ? */
-	for_each_pci_dev(pdev) {
-		tbl = get_iommu_table_base(&pdev->dev);
-		if (tbl && tbl->it_group == group) {
-			found = true;
-			break;
-		}
-	}
-	if (!found)
+	ret = iommu_group_for_each_dev(group, &pdev, dev_has_iommu_table);
+	if (!ret || !pdev)
 		return NULL;
 
 	/* No EEH device or PE ? */
-- 
1.8.3.2
