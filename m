Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 608942C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jul 2013 12:14:33 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 17 Jul 2013 22:14:29 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id D9CEBC9004A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 22:14:26 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6I2ERMP170394
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 22:14:28 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6I2ERib028707
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 22:14:27 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 02/10] powerpc/eeh: Export functions for hotplug
Date: Thu, 18 Jul 2013 10:14:12 +0800
Message-Id: <1374113660-15347-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1374113660-15347-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1374113660-15347-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make some functions public in order to support hotplug on either specific
PCI bus or PCI device in future.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |    9 +++++++++
 arch/powerpc/kernel/eeh.c      |    6 +++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 09a8743..d9d35c2 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -209,9 +209,12 @@ unsigned long eeh_check_failure(const volatile void __iomem *token,
 				unsigned long val);
 int eeh_dev_check_failure(struct eeh_dev *edev);
 void eeh_addr_cache_build(void);
+void eeh_add_device_early(struct device_node *);
 void eeh_add_device_tree_early(struct device_node *);
+void eeh_add_device_late(struct pci_dev *);
 void eeh_add_device_tree_late(struct pci_bus *);
 void eeh_add_sysfs_files(struct pci_bus *);
+void eeh_remove_device(struct pci_dev *, int);
 void eeh_remove_bus_device(struct pci_dev *, int);
 
 /**
@@ -252,12 +255,18 @@ static inline unsigned long eeh_check_failure(const volatile void __iomem *token
 
 static inline void eeh_addr_cache_build(void) { }
 
+static inline void eeh_add_device_early(struct device_node *dn) { }
+
 static inline void eeh_add_device_tree_early(struct device_node *dn) { }
 
+static inline void eeh_add_device_late(struct pci_dev *dev) { }
+
 static inline void eeh_add_device_tree_late(struct pci_bus *bus) { }
 
 static inline void eeh_add_sysfs_files(struct pci_bus *bus) { }
 
+static inline void eeh_remove_device(struct pci_dev *dev, int purge_pe) { }
+
 static inline void eeh_remove_bus_device(struct pci_dev *dev, int purge_pe) { }
 
 #define EEH_POSSIBLE_ERROR(val, type) (0)
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index b5c425e..582ad1e 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -836,7 +836,7 @@ core_initcall_sync(eeh_init);
  * on the CEC architecture, type of the device, on earlier boot
  * command-line arguments & etc.
  */
-static void eeh_add_device_early(struct device_node *dn)
+void eeh_add_device_early(struct device_node *dn)
 {
 	struct pci_controller *phb;
 
@@ -884,7 +884,7 @@ EXPORT_SYMBOL_GPL(eeh_add_device_tree_early);
  * This routine must be used to complete EEH initialization for PCI
  * devices that were added after system boot (e.g. hotplug, dlpar).
  */
-static void eeh_add_device_late(struct pci_dev *dev)
+void eeh_add_device_late(struct pci_dev *dev)
 {
 	struct device_node *dn;
 	struct eeh_dev *edev;
@@ -972,7 +972,7 @@ EXPORT_SYMBOL_GPL(eeh_add_sysfs_files);
  * this device will no longer be detected after this call; thus,
  * i/o errors affecting this slot may leave this device unusable.
  */
-static void eeh_remove_device(struct pci_dev *dev, int purge_pe)
+void eeh_remove_device(struct pci_dev *dev, int purge_pe)
 {
 	struct eeh_dev *edev;
 
-- 
1.7.5.4
