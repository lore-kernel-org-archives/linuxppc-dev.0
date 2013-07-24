Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 02F1B2C010F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 12:25:19 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 23 Jul 2013 20:25:17 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 52E0A1FF001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 20:19:53 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6O2PEmU148476
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 20:25:14 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6O2PDXK032450
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 20:25:14 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 11/11] powerpc/eeh: Introdce flag to protect sysfs
Date: Wed, 24 Jul 2013 10:25:01 +0800
Message-Id: <1374632701-20972-12-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1374632701-20972-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1374632701-20972-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch introduces flag EEH_DEV_SYSFS to trace that the sysfs for
the corresponding EEH device (then PCI device) has been added or
removed, in order to avoid race condition.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |    2 ++
 arch/powerpc/kernel/eeh.c                    |    2 ++
 arch/powerpc/kernel/eeh_sysfs.c              |   16 +++++++++++++++-
 arch/powerpc/platforms/powernv/eeh-powernv.c |    4 ++--
 arch/powerpc/platforms/pseries/eeh_pseries.c |    2 +-
 5 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 4199d99..d3e5e9b 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -90,6 +90,8 @@ struct eeh_pe {
 #define EEH_DEV_IRQ_DISABLED	(1 << 3)	/* Interrupt disabled	*/
 #define EEH_DEV_DISCONNECTED	(1 << 4)	/* Removing from PE	*/
 
+#define EEH_DEV_SYSFS		(1 << 8)	/* Sysfs created        */
+
 struct eeh_dev {
 	int mode;			/* EEH mode			*/
 	int class_code;			/* Class code of the device	*/
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index a5783f1..ea9414c8 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -911,6 +911,7 @@ void eeh_add_device_late(struct pci_dev *dev)
 		eeh_rmv_from_parent_pe(edev);
 		eeh_addr_cache_rmv_dev(edev->pdev);
 		eeh_sysfs_remove_device(edev->pdev);
+		edev->mode &= ~EEH_DEV_SYSFS;
 
 		edev->pdev = NULL;
 		dev->dev.archdata.edev = NULL;
@@ -1016,6 +1017,7 @@ void eeh_remove_device(struct pci_dev *dev)
 
 	eeh_addr_cache_rmv_dev(dev);
 	eeh_sysfs_remove_device(dev);
+	edev->mode &= ~EEH_DEV_SYSFS;
 }
 
 static int proc_eeh_show(struct seq_file *m, void *v)
diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
index 61e2a14..5d753d4 100644
--- a/arch/powerpc/kernel/eeh_sysfs.c
+++ b/arch/powerpc/kernel/eeh_sysfs.c
@@ -56,26 +56,40 @@ EEH_SHOW_ATTR(eeh_pe_config_addr,  pe_config_addr,  "0x%x");
 
 void eeh_sysfs_add_device(struct pci_dev *pdev)
 {
+	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
 	int rc=0;
 
+	if (edev && (edev->mode & EEH_DEV_SYSFS))
+		return;
+
 	rc += device_create_file(&pdev->dev, &dev_attr_eeh_mode);
 	rc += device_create_file(&pdev->dev, &dev_attr_eeh_config_addr);
 	rc += device_create_file(&pdev->dev, &dev_attr_eeh_pe_config_addr);
 
 	if (rc)
 		printk(KERN_WARNING "EEH: Unable to create sysfs entries\n");
+	else if (edev)
+		edev->mode |= EEH_DEV_SYSFS;
 }
 
 void eeh_sysfs_remove_device(struct pci_dev *pdev)
 {
+	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
+
 	/*
 	 * The parent directory might have been removed. We needn't
 	 * continue for that case.
 	 */
-	if (!pdev->dev.kobj.sd)
+	if (!pdev->dev.kobj.sd) {
+		if (edev)
+			edev->mode &= ~EEH_DEV_SYSFS;
 		return;
+	}
 
 	device_remove_file(&pdev->dev, &dev_attr_eeh_mode);
 	device_remove_file(&pdev->dev, &dev_attr_eeh_config_addr);
 	device_remove_file(&pdev->dev, &dev_attr_eeh_pe_config_addr);
+
+	if (edev)
+		edev->mode &= ~EEH_DEV_SYSFS;
 }
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 4361a5c..79663d2 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -122,8 +122,8 @@ static int powernv_eeh_dev_probe(struct pci_dev *dev, void *flag)
 		return 0;
 
 	/* Initialize eeh device */
-	edev->class_code	= dev->class;
-	edev->mode		= 0;
+	edev->class_code = dev->class;
+	edev->mode	&= 0xFFFFFF00;
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
 		edev->mode |= EEH_DEV_BRIDGE;
 	if (pci_is_pcie(dev)) {
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 9e80f0a..7fbc25b 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -218,7 +218,7 @@ static void *pseries_eeh_of_probe(struct device_node *dn, void *flag)
 	 */
 	edev->class_code = *class_code;
 	edev->pcie_cap = pseries_eeh_find_cap(dn, PCI_CAP_ID_EXP);
-	edev->mode = 0;
+	edev->mode &= 0xFFFFFF00;
 	if ((edev->class_code >> 8) == PCI_CLASS_BRIDGE_PCI) {
 		edev->mode |= EEH_DEV_BRIDGE;
 		if (edev->pcie_cap) {
-- 
1.7.5.4
