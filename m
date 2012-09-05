Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B1CE82C00B1
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2012 16:15:24 +1000 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 5 Sep 2012 00:15:22 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id DC90A3E40039
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2012 00:15:18 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q856FJOA232990
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2012 00:15:19 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q856FIPa028617
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2012 00:15:18 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/21] ppc/eeh: remove PE at appropriate time
Date: Wed,  5 Sep 2012 14:14:44 +0800
Message-Id: <1346825696-13960-10-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1346825696-13960-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1346825696-13960-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During PCI hotplug and EEH recovery, the PE hierarchy PE might be
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
 arch/powerpc/platforms/pseries/eeh_pe.c |   46 +++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index e41107d..fd69584 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -167,6 +167,7 @@ static inline void eeh_unlock(void)
 typedef void *(*eeh_traverse_func)(void *data, void *flag);
 int __devinit eeh_phb_pe_create(struct pci_controller *phb);
 int eeh_pe_create(struct eeh_dev *edev);
+int eeh_pe_remove(struct eeh_dev *edev);
 
 void * __devinit eeh_dev_init(struct device_node *dn, void *data);
 void __devinit eeh_dev_phb_init_dynamic(struct pci_controller *phb);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 99937da..82a5fdc 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -1156,6 +1156,7 @@ static void eeh_remove_device(struct pci_dev *dev)
 	dev->dev.archdata.edev = NULL;
 	pci_dev_put(dev);
 
+	eeh_pe_remove(edev);
 	pci_addr_cache_remove_device(dev);
 	eeh_sysfs_remove_device(dev);
 }
diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
index 56aab91..ed675b8 100644
--- a/arch/powerpc/platforms/pseries/eeh_pe.c
+++ b/arch/powerpc/platforms/pseries/eeh_pe.c
@@ -336,3 +336,49 @@ int eeh_pe_create(struct eeh_dev *edev)
         return 0;
 }
 
+/**
+ * eeh_pe_remove - Remove one EEH device from the associated PE
+ * @edev: EEH device
+ *
+ * The PE hierarchy tree might be changed when doing PCI hotplug.
+ * Also, the PCI devices or buses could be removed from the system
+ * during EEH recovery.
+ */
+int eeh_pe_remove(struct eeh_dev *edev)
+{
+	struct eeh_pe *pe, *parent;
+
+	if (!edev->pe) {
+		pr_err("%s: No PE found for EEH device %s\n",
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
+		if (pe->type & EEH_PE_PHB)
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
+
-- 
1.7.5.4
