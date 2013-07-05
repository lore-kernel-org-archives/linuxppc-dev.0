Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A1A92C0096
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jul 2013 12:57:46 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 4 Jul 2013 22:57:43 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 65919C90058
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 22:57:39 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r652veRQ236068
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jul 2013 22:57:40 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r652vdtg023609
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jul 2013 22:57:40 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/8] powerpc/eeh: Export functions for hotplug
Date: Fri,  5 Jul 2013 10:57:28 +0800
Message-Id: <1372993054-25730-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372993054-25730-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372993054-25730-1-git-send-email-shangw@linux.vnet.ibm.com>
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
index 39954fe..a186de8 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -838,7 +838,7 @@ core_initcall_sync(eeh_init);
  * on the CEC architecture, type of the device, on earlier boot
  * command-line arguments & etc.
  */
-static void eeh_add_device_early(struct device_node *dn)
+void eeh_add_device_early(struct device_node *dn)
 {
 	struct pci_controller *phb;
 
@@ -886,7 +886,7 @@ EXPORT_SYMBOL_GPL(eeh_add_device_tree_early);
  * This routine must be used to complete EEH initialization for PCI
  * devices that were added after system boot (e.g. hotplug, dlpar).
  */
-static void eeh_add_device_late(struct pci_dev *dev)
+void eeh_add_device_late(struct pci_dev *dev)
 {
 	struct device_node *dn;
 	struct eeh_dev *edev;
@@ -975,7 +975,7 @@ EXPORT_SYMBOL_GPL(eeh_add_sysfs_files);
  * this device will no longer be detected after this call; thus,
  * i/o errors affecting this slot may leave this device unusable.
  */
-static void eeh_remove_device(struct pci_dev *dev, int purge_pe)
+void eeh_remove_device(struct pci_dev *dev, int purge_pe)
 {
 	struct eeh_dev *edev;
 
-- 
1.7.5.4
