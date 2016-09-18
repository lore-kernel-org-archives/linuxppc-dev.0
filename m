Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scm7053hTzDsTW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 09:53:16 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8INqYjg027154
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Sep 2016 19:53:13 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25h2bhnxtn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Sep 2016 19:53:13 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 19 Sep 2016 09:53:11 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E46303578056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 09:53:09 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8INr94n66715720
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 09:53:09 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8INr9g1002414
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 09:53:09 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, mpe@ellerman.id.au,
 clsoto@us.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] PCI: Add parameter @mmio_force_on to pci_update_resource()
Date: Mon, 19 Sep 2016 09:53:30 +1000
Message-Id: <1474242810-11530-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In pci_update_resource(), the PCI device's memory decoding (0x2 in
PCI_COMMAND) is disabled when 64-bits memory BAR is updated if the
PCI device's memory space wasn't asked to be always on by @pdev->
mmio_always_on. The PF's memory decoding might be disabled when
updating its IOV BARs in the following path. Actually, the PF's
memory decoding shouldn't be disabled in this scenario as the PF
has been started to provide services:

   sriov_numvfs_store
   pdev->driver->sriov_configure
   mlx5_core_sriov_configure
   pci_enable_sriov
   sriov_enable
   pcibios_sriov_enable
   pnv_pci_sriov_enable
   pnv_pci_vf_resource_shift
   pci_update_resource

This doesn't change the PF's memory decoding in the path by introducing
additional parameter (@mmio_force_on) to pci_update_resource().

Reported-by: Carol Soto <clsoto@us.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Tested-by: Carol Soto <clsoto@us.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 drivers/pci/iov.c                         | 2 +-
 drivers/pci/pci.c                         | 2 +-
 drivers/pci/setup-res.c                   | 9 +++++----
 include/linux/pci.h                       | 2 +-
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index bc0c91e..2d6a2b7 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -999,7 +999,7 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
 		dev_info(&dev->dev, "VF BAR%d: %pR shifted to %pR (%sabling %d VFs shifted by %d)\n",
 			 i, &res2, res, (offset > 0) ? "En" : "Dis",
 			 num_vfs, offset);
-		pci_update_resource(dev, i + PCI_IOV_RESOURCES);
+		pci_update_resource(dev, i + PCI_IOV_RESOURCES, true);
 	}
 	return 0;
 }
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 2194b44..117aae6 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -511,7 +511,7 @@ static void sriov_restore_state(struct pci_dev *dev)
 		return;
 
 	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++)
-		pci_update_resource(dev, i);
+		pci_update_resource(dev, i, false);
 
 	pci_write_config_dword(dev, iov->pos + PCI_SRIOV_SYS_PGSIZE, iov->pgsz);
 	pci_iov_set_numvfs(dev, iov->num_VFs);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aab9d51..87a33c0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -545,7 +545,7 @@ static void pci_restore_bars(struct pci_dev *dev)
 		return;
 
 	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++)
-		pci_update_resource(dev, i);
+		pci_update_resource(dev, i, false);
 }
 
 static const struct pci_platform_pm_ops *pci_platform_pm;
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 66c4d8f..e8a50ff 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -26,7 +26,7 @@
 #include "pci.h"
 
 
-void pci_update_resource(struct pci_dev *dev, int resno)
+void pci_update_resource(struct pci_dev *dev, int resno, bool mmio_force_on)
 {
 	struct pci_bus_region region;
 	bool disable;
@@ -81,7 +81,8 @@ void pci_update_resource(struct pci_dev *dev, int resno)
 	 * disable decoding so that a half-updated BAR won't conflict
 	 * with another device.
 	 */
-	disable = (res->flags & IORESOURCE_MEM_64) && !dev->mmio_always_on;
+	disable = (res->flags & IORESOURCE_MEM_64) &&
+		  !mmio_force_on && !dev->mmio_always_on;
 	if (disable) {
 		pci_read_config_word(dev, PCI_COMMAND, &cmd);
 		pci_write_config_word(dev, PCI_COMMAND,
@@ -310,7 +311,7 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
 	res->flags &= ~IORESOURCE_STARTALIGN;
 	dev_info(&dev->dev, "BAR %d: assigned %pR\n", resno, res);
 	if (resno < PCI_BRIDGE_RESOURCES)
-		pci_update_resource(dev, resno);
+		pci_update_resource(dev, resno, false);
 
 	return 0;
 }
@@ -350,7 +351,7 @@ int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsiz
 	dev_info(&dev->dev, "BAR %d: reassigned %pR (expanded by %#llx)\n",
 		 resno, res, (unsigned long long) addsize);
 	if (resno < PCI_BRIDGE_RESOURCES)
-		pci_update_resource(dev, resno);
+		pci_update_resource(dev, resno, false);
 
 	return 0;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0ab8359..99231d1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1039,7 +1039,7 @@ int pci_try_reset_bus(struct pci_bus *bus);
 void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
 void pci_reset_bridge_secondary_bus(struct pci_dev *dev);
-void pci_update_resource(struct pci_dev *dev, int resno);
+void pci_update_resource(struct pci_dev *dev, int resno, bool mmio_force_on);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
 int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
-- 
2.1.0
