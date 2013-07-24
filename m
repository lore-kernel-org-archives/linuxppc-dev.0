Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5E4912C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 12:25:16 +1000 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 24 Jul 2013 02:25:13 -0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 73F2419D804E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 20:24:57 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6O2P8ou157704
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 20:25:08 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6O2P7hj014764
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 20:25:08 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 02/11] powerpc/eeh: Export functions for hotplug
Date: Wed, 24 Jul 2013 10:24:52 +0800
Message-Id: <1374632701-20972-3-git-send-email-shangw@linux.vnet.ibm.com>
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
