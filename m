Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e5.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A626B2C00D8
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2012 18:44:41 +1000 (EST)
Received: from /spool/local
 by e5.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sat, 8 Sep 2012 04:44:38 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9BC7A6E803F
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2012 04:44:36 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q888iahO143756
 for <linuxppc-dev@ozlabs.org>; Sat, 8 Sep 2012 04:44:36 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q888iao4002756
 for <linuxppc-dev@ozlabs.org>; Sat, 8 Sep 2012 05:44:36 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/22] ppc/eeh: remove PE at appropriate time
Date: Sat,  8 Sep 2012 16:44:10 +0800
Message-Id: <1347093863-6319-10-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1347093863-6319-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1347093863-6319-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During PCI hotplug and EEH recovery, the PE hierarchy tree might be
changed due to the PCI topology changes. At later point when the
PCI device is added, the PE will be created dynamically again.

The patch introduces new function to remove EEH devices from the
associated PE. That also can cause that the parent PE is removed
from the PE tree if the parent PE doesn't include valid EEH devices
and child PEs.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h          |    1 +
 arch/powerpc/platforms/pseries/eeh.c    |    1 +
 arch/powerpc/platforms/pseries/eeh_pe.c |   47 +++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 6b13790..250ae27 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -167,6 +167,7 @@ static inline void eeh_unlock(void)
 typedef void *(*eeh_traverse_func)(void *data, void *flag);
 int __devinit eeh_phb_pe_create(struct pci_controller *phb);
 int eeh_add_to_parent_pe(struct eeh_dev *edev);
+int eeh_rmv_from_parent_pe(struct eeh_dev *edev);
 
 void * __devinit eeh_dev_init(struct device_node *dn, void *data);
 void __devinit eeh_dev_phb_init_dynamic(struct pci_controller *phb);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 8f214906..b60863b 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -1156,6 +1156,7 @@ static void eeh_remove_device(struct pci_dev *dev)
 	dev->dev.archdata.edev = NULL;
 	pci_dev_put(dev);
 
+	eeh_rmv_from_parent_pe(edev);
 	pci_addr_cache_remove_device(dev);
 	eeh_sysfs_remove_device(dev);
 }
diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
index 08b62de..0629ae5 100644
--- a/arch/powerpc/platforms/pseries/eeh_pe.c
+++ b/arch/powerpc/platforms/pseries/eeh_pe.c
@@ -341,3 +341,50 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 
 	return 0;
 }
+
+/**
+ * eeh_rmv_from_parent_pe - Remove one EEH device from the associated PE
+ * @edev: EEH device
+ *
+ * The PE hierarchy tree might be changed when doing PCI hotplug.
+ * Also, the PCI devices or buses could be removed from the system
+ * during EEH recovery. So we have to call the function remove the
+ * corresponding PE accordingly if necessary.
+ */
+int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
+{
+	struct eeh_pe *pe, *parent;
+
+	if (!edev->pe) {
+		pr_warning("%s: No PE found for EEH device %s\n",
+			__func__, edev->dn->full_name);
+		return -EEXIST;
+	}
+
+	/* Remove the EEH device */
+	pe = edev->pe;
+	edev->pe = NULL;
+	list_del(&edev->list);
+
+	/*
+	 * Check if the parent PE includes any EEH devices.
+	 * If not, we should delete that. Also, we should
+	 * delete the parent PE if it doesn't have associated
+	 * child PEs and EEH devices.
+	 */
+	while (1) {
+		parent = pe->parent;
+		if (pe->type == EEH_PE_PHB)
+			break;
+
+		if (list_empty(&pe->edevs) &&
+		    list_empty(&pe->child_list)) {
+			list_del(&pe->child);
+			kfree(pe);
+		}
+
+		pe = parent;
+	}
+
+	return 0;
+}
-- 
1.7.5.4
