Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EDC67B6FD9
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 02:28:35 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 10:28:32 -0600
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 29F5FC93C78
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:03:11 -0400 (EDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5RG3AQI183346
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:03:11 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5RG2CwA025157
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:02:13 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 21/21] ppc/eeh: trace eeh device from I/O cache
Date: Thu, 28 Jun 2012 00:01:51 +0800
Message-Id: <1340812911-6793-22-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The idea comes from Benjamin Herrenschmidt. The eeh cache helps
fetching the pci device according to the given I/O address. Since
the eeh cache is serving for eeh, it's reasonable for eeh cache
to trace eeh device except pci device.

The patch make eeh cache to trace eeh device. Also, the major
eeh entry function eeh_dn_check_failure has been renamed to
eeh_dev_check_failure since it will take eeh device as input
parameter.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h             |    7 ++----
 arch/powerpc/include/asm/pci-bridge.h      |    2 ++
 arch/powerpc/include/asm/ppc-pci.h         |    2 +-
 arch/powerpc/kernel/rtas_pci.c             |    2 +-
 arch/powerpc/platforms/pseries/eeh.c       |   33 ++++++++++++----------------
 arch/powerpc/platforms/pseries/eeh_cache.c |   14 +++++++-----
 6 files changed, 28 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 91c38b7..4d59da0 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -196,7 +196,7 @@ int __init eeh_ops_register(struct eeh_ops *ops);
 int __exit eeh_ops_unregister(const char *name);
 unsigned long eeh_check_failure(const volatile void __iomem *token,
 				unsigned long val);
-int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev);
+int eeh_dev_check_failure(struct eeh_dev *edev);
 void __init pci_addr_cache_build(void);
 void eeh_add_device_tree_early(struct device_node *);
 void eeh_add_device_tree_late(struct pci_bus *);
@@ -231,10 +231,7 @@ static inline unsigned long eeh_check_failure(const volatile void __iomem *token
 	return val;
 }
 
-static inline int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
-{
-	return 0;
-}
+#define eeh_dev_check_failure(x) (0)
 
 static inline void pci_addr_cache_build(void) { }
 
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index ac39e6a..f6bd6b2 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -183,6 +183,8 @@ static inline struct eeh_dev *of_node_to_eeh_dev(struct device_node *dn)
 {
 	return PCI_DN(dn)->edev;
 }
+#else
+#define of_node_to_eeh_dev(x) (NULL)
 #endif
 
 /** Find the bus corresponding to the indicated device node */
diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 56d55c7..962a902 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -50,7 +50,7 @@ extern int rtas_setup_phb(struct pci_controller *phb);
 void pci_addr_cache_build(void);
 void pci_addr_cache_insert_device(struct pci_dev *dev);
 void pci_addr_cache_remove_device(struct pci_dev *dev);
-struct pci_dev *pci_addr_cache_get_device(unsigned long addr);
+struct eeh_dev *pci_addr_cache_get_device(unsigned long addr);
 void eeh_slot_error_detail(struct eeh_pe *pe, int severity);
 int eeh_pci_enable(struct eeh_pe *pe, int function);
 int eeh_reset_pe(struct eeh_pe *);
diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 140735c..6de63e3 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -81,7 +81,7 @@ int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (returnval == EEH_IO_ERROR_VALUE(size) &&
-	    eeh_dn_check_failure (pdn->node, NULL))
+	    eeh_dev_check_failure(of_node_to_eeh_dev(pdn->node)))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	return PCIBIOS_SUCCESSFUL;
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index b2caf84..81e8c8e 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -270,9 +270,8 @@ static inline unsigned long eeh_token_to_phys(unsigned long token)
 }
 
 /**
- * eeh_dn_check_failure - Check if all 1's data is due to EEH slot freeze
- * @dn: device node
- * @dev: pci device, if known
+ * eeh_dev_check_failure - Check if all 1's data is due to EEH slot freeze
+ * @edev: eeh device
  *
  * Check for an EEH failure for the given device node.  Call this
  * routine if the result of a read was all 0xff's and you want to
@@ -284,12 +283,13 @@ static inline unsigned long eeh_token_to_phys(unsigned long token)
  *
  * It is safe to call this routine in an interrupt context.
  */
-int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
+int eeh_dev_check_failure(struct eeh_dev *edev)
 {
 	int ret;
 	unsigned long flags;
+	struct device_node *dn;
+	struct pci_dev *dev;
 	struct eeh_pe *pe;
-	struct eeh_dev *edev;
 	int rc = 0;
 	const char *location;
 
@@ -298,15 +298,12 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 	if (!eeh_subsystem_enabled)
 		return 0;
 
-	if (dn) {
-		edev = of_node_to_eeh_dev(dn);
-	} else if (dev) {
-		edev = pci_dev_to_eeh_dev(dev);
-		dn = pci_device_to_OF_node(dev);
-	} else {
+	if (!edev) {
 		eeh_stats.no_dn++;
 		return 0;
 	}
+	dn = eeh_dev_to_of_node(edev);
+	dev = eeh_dev_to_pci_dev(edev);
 	pe = edev->pe;
 
 	/* Access to IO BARs might get this far and still not want checking. */
@@ -393,7 +390,7 @@ dn_unlock:
 	return rc;
 }
 
-EXPORT_SYMBOL_GPL(eeh_dn_check_failure);
+EXPORT_SYMBOL_GPL(eeh_dev_check_failure);
 
 /**
  * eeh_check_failure - Check if all 1's data is due to EEH slot freeze
@@ -410,21 +407,19 @@ EXPORT_SYMBOL_GPL(eeh_dn_check_failure);
 unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned long val)
 {
 	unsigned long addr;
-	struct pci_dev *dev;
-	struct device_node *dn;
+	struct eeh_dev *edev;
 
 	/* Finding the phys addr + pci device; this is pretty quick. */
 	addr = eeh_token_to_phys((unsigned long __force) token);
-	dev = pci_addr_cache_get_device(addr);
-	if (!dev) {
+	edev = pci_addr_cache_get_device(addr);
+	if (!edev) {
 		eeh_stats.no_device++;
 		return val;
 	}
 
-	dn = pci_device_to_OF_node(dev);
-	eeh_dn_check_failure(dn, dev);
+	eeh_dev_check_failure(edev);
 
-	pci_dev_put(dev);
+	pci_dev_put(eeh_dev_to_pci_dev(edev));
 	return val;
 }
 
diff --git a/arch/powerpc/platforms/pseries/eeh_cache.c b/arch/powerpc/platforms/pseries/eeh_cache.c
index a191057..6c5ef75 100644
--- a/arch/powerpc/platforms/pseries/eeh_cache.c
+++ b/arch/powerpc/platforms/pseries/eeh_cache.c
@@ -50,6 +50,7 @@ struct pci_io_addr_range {
 	struct rb_node rb_node;
 	unsigned long addr_lo;
 	unsigned long addr_hi;
+	struct eeh_dev *edev;
 	struct pci_dev *pcidev;
 	unsigned int flags;
 };
@@ -59,7 +60,7 @@ static struct pci_io_addr_cache {
 	spinlock_t piar_lock;
 } pci_io_addr_cache_root;
 
-static inline struct pci_dev *__pci_addr_cache_get_device(unsigned long addr)
+static inline struct eeh_dev *__pci_addr_cache_get_device(unsigned long addr)
 {
 	struct rb_node *n = pci_io_addr_cache_root.rb_root.rb_node;
 
@@ -74,7 +75,7 @@ static inline struct pci_dev *__pci_addr_cache_get_device(unsigned long addr)
 				n = n->rb_right;
 			} else {
 				pci_dev_get(piar->pcidev);
-				return piar->pcidev;
+				return piar->edev;
 			}
 		}
 	}
@@ -92,15 +93,15 @@ static inline struct pci_dev *__pci_addr_cache_get_device(unsigned long addr)
  * from zero (that is, they do *not* have pci_io_addr added in).
  * It is safe to call this function within an interrupt.
  */
-struct pci_dev *pci_addr_cache_get_device(unsigned long addr)
+struct eeh_dev *pci_addr_cache_get_device(unsigned long addr)
 {
-	struct pci_dev *dev;
+	struct eeh_dev *edev;
 	unsigned long flags;
 
 	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
-	dev = __pci_addr_cache_get_device(addr);
+	edev = __pci_addr_cache_get_device(addr);
 	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
-	return dev;
+	return edev;
 }
 
 #ifdef DEBUG
@@ -158,6 +159,7 @@ pci_addr_cache_insert(struct pci_dev *dev, unsigned long alo,
 	pci_dev_get(dev);
 	piar->addr_lo = alo;
 	piar->addr_hi = ahi;
+	piar->edev = pci_dev_to_eeh_dev(dev);
 	piar->pcidev = dev;
 	piar->flags = flags;
 
-- 
1.7.9.5
