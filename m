Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7042FB700A
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 17:04:45 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 28 Feb 2012 05:59:33 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1S64RIt1089776
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 17:04:27 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1S64RUt019178
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 17:04:27 +1100
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 16/21] Replace pci_dn with eeh_dev for EEH address cache
Date: Tue, 28 Feb 2012 14:04:06 +0800
Message-Id: <1330409051-8941-17-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With original EEH implementation, struct pci_dn is used while building
PCI I/O address cache, which helps on searching the corresponding
PCI device according to the given physical I/O address. Besides, pci_dn
is associated with the corresponding PCI device while building its
I/O cache.

The patch replaces struct pci_dn with struct eeh_dev so that EEH address
cache won't depend on struct pci_dn. That will help EEH to become an
independent module in future. Besides, the binding of eeh_dev and PCI
device is done while building PCI device I/O cache.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_cache.c |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_cache.c b/arch/powerpc/platforms/pseries/eeh_cache.c
index 7c36a9c..e5ae1c6 100644
--- a/arch/powerpc/platforms/pseries/eeh_cache.c
+++ b/arch/powerpc/platforms/pseries/eeh_cache.c
@@ -175,7 +175,7 @@ pci_addr_cache_insert(struct pci_dev *dev, unsigned long alo,
 static void __pci_addr_cache_insert_device(struct pci_dev *dev)
 {
 	struct device_node *dn;
-	struct pci_dn *pdn;
+	struct eeh_dev *edev;
 	int i;
 
 	dn = pci_device_to_OF_node(dev);
@@ -184,13 +184,19 @@ static void __pci_addr_cache_insert_device(struct pci_dev *dev)
 		return;
 	}
 
+	edev = of_node_to_eeh_dev(dn);
+	if (!edev) {
+		pr_warning("PCI: no EEH dev found for dn=%s\n",
+			dn->full_name);
+		return;
+	}
+
 	/* Skip any devices for which EEH is not enabled. */
-	pdn = PCI_DN(dn);
-	if (!(pdn->eeh_mode & EEH_MODE_SUPPORTED) ||
-	    pdn->eeh_mode & EEH_MODE_NOCHECK) {
+	if (!(edev->mode & EEH_MODE_SUPPORTED) ||
+	    edev->mode & EEH_MODE_NOCHECK) {
 #ifdef DEBUG
-		printk(KERN_INFO "PCI: skip building address cache for=%s - %s\n",
-		       pci_name(dev), pdn->node->full_name);
+		pr_info("PCI: skip building address cache for=%s - %s\n",
+			pci_name(dev), dn->full_name);
 #endif
 		return;
 	}
@@ -281,6 +287,7 @@ void pci_addr_cache_remove_device(struct pci_dev *dev)
 void __init pci_addr_cache_build(void)
 {
 	struct device_node *dn;
+	struct eeh_dev *edev;
 	struct pci_dev *dev = NULL;
 
 	spin_lock_init(&pci_io_addr_cache_root.piar_lock);
@@ -291,8 +298,14 @@ void __init pci_addr_cache_build(void)
 		dn = pci_device_to_OF_node(dev);
 		if (!dn)
 			continue;
+
+		edev = of_node_to_eeh_dev(dn);
+		if (!edev)
+			continue;
+
 		pci_dev_get(dev);  /* matching put is in eeh_remove_device() */
-		PCI_DN(dn)->pcidev = dev;
+		dev->dev.archdata.edev = edev;
+		edev->pdev = dev;
 
 		eeh_sysfs_add_device(dev);
 	}
-- 
1.7.5.4
