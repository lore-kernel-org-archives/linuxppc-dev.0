Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EB8EF1400FE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 14:12:11 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 14 May 2014 14:12:10 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3F638357805F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 14:12:06 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4E4BovQ9503184
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 14:11:51 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4E4C4MA023561
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 14:12:04 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 2/8] powerpc/eeh: Info to trace passed devices
Date: Wed, 14 May 2014 14:11:56 +1000
Message-Id: <1400040722-29608-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, agraf@suse.de, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The address of passed PCI devices (domain:bus:slot:func) might be
quite different from the perspective of host and guest. We have to
trace the address mapping so that we can emulate EEH RTAS requests
from guest. The patch introduces additional fields to eeh_pe and
eeh_dev for the purpose.

Also, the patch adds function eeh_vfio_pe_get() and eeh_vfio_dev_get()
to search EEH PE or device according to the given guest address. Both
of them will be used by subsequent patches.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h | 52 +++++++++++++++++++++++++++
 arch/powerpc/kernel/eeh_pe.c   | 80 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 7782056..96dabfc 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -48,6 +48,14 @@ struct device_node;
 #define EEH_PE_RST_HOLD_TIME		250
 #define EEH_PE_RST_SETTLE_TIME		1800
 
+#ifdef CONFIG_VFIO_EEH
+struct eeh_vfio_pci_addr {
+	uint64_t	buid;		/* PHB BUID			*/
+	uint16_t	config_addr;	/* Bus/Device/Function number	*/
+	uint32_t	pe_addr;	/* PE configuration address	*/
+};
+#endif /* CONFIG_VFIO_EEH */
+
 /*
  * The struct is used to trace PE related EEH functionality.
  * In theory, there will have one instance of the struct to
@@ -72,6 +80,7 @@ struct device_node;
 #define EEH_PE_RESET		(1 << 2)	/* PE reset in progress	*/
 
 #define EEH_PE_KEEP		(1 << 8)	/* Keep PE on hotplug	*/
+#define EEH_PE_PASSTHROUGH	(1 << 9)	/* PE owned by guest	*/
 
 struct eeh_pe {
 	int type;			/* PE type: PHB/Bus/Device	*/
@@ -85,6 +94,9 @@ struct eeh_pe {
 	struct timeval tstamp;		/* Time on first-time freeze	*/
 	int false_positives;		/* Times of reported #ff's	*/
 	struct eeh_pe *parent;		/* Parent PE			*/
+#ifdef CONFIG_VFIO_EEH
+	struct eeh_vfio_pci_addr guest_addr;
+#endif
 	struct list_head child_list;	/* Link PE to the child list	*/
 	struct list_head edevs;		/* Link list of EEH devices	*/
 	struct list_head child;		/* Child PEs			*/
@@ -93,6 +105,21 @@ struct eeh_pe {
 #define eeh_pe_for_each_dev(pe, edev, tmp) \
 		list_for_each_entry_safe(edev, tmp, &pe->edevs, list)
 
+static inline bool eeh_pe_passed(struct eeh_pe *pe)
+{
+	return pe ? !!(pe->state & EEH_PE_PASSTHROUGH) : false;
+}
+
+static inline void eeh_pe_set_passed(struct eeh_pe *pe, bool passed)
+{
+	if (pe) {
+		if (passed)
+			pe->state |= EEH_PE_PASSTHROUGH;
+		else
+			pe->state &= ~EEH_PE_PASSTHROUGH;
+	}
+}
+
 /*
  * The struct is used to trace EEH state for the associated
  * PCI device node or PCI device. In future, it might
@@ -110,6 +137,7 @@ struct eeh_pe {
 #define EEH_DEV_SYSFS		(1 << 9)	/* Sysfs created	*/
 #define EEH_DEV_REMOVED		(1 << 10)	/* Removed permanently	*/
 #define EEH_DEV_FRESET		(1 << 11)	/* Fundamental reset	*/
+#define EEH_DEV_PASSTHROUGH	(1 << 12)	/* Owned by guest	*/
 
 struct eeh_dev {
 	int mode;			/* EEH mode			*/
@@ -126,6 +154,9 @@ struct eeh_dev {
 	struct device_node *dn;		/* Associated device node	*/
 	struct pci_dev *pdev;		/* Associated PCI device	*/
 	struct pci_bus *bus;		/* PCI bus for partial hotplug	*/
+#ifdef CONFIG_VFIO_EEH
+	struct eeh_vfio_pci_addr guest_addr;
+#endif
 };
 
 static inline struct device_node *eeh_dev_to_of_node(struct eeh_dev *edev)
@@ -138,6 +169,21 @@ static inline struct pci_dev *eeh_dev_to_pci_dev(struct eeh_dev *edev)
 	return edev ? edev->pdev : NULL;
 }
 
+static inline bool eeh_dev_passed(struct eeh_dev *dev)
+{
+	return dev ? !!(dev->mode & EEH_DEV_PASSTHROUGH) : false;
+}
+
+static inline void eeh_dev_set_passed(struct eeh_dev *dev, bool passed)
+{
+	if (dev) {
+		if (passed)
+			dev->mode |= EEH_DEV_PASSTHROUGH;
+		else
+			dev->mode &= ~EEH_DEV_PASSTHROUGH;
+	}
+}
+
 /* Return values from eeh_ops::next_error */
 enum {
 	EEH_NEXT_ERR_NONE = 0,
@@ -335,6 +381,12 @@ static inline void eeh_remove_device(struct pci_dev *dev) { }
 #define EEH_IO_ERROR_VALUE(size) (-1UL)
 #endif /* CONFIG_EEH */
 
+
+#ifdef CONFIG_VFIO_EEH
+struct eeh_dev *eeh_vfio_dev_get(struct eeh_vfio_pci_addr *addr);
+struct eeh_pe *eeh_vfio_pe_get(struct eeh_vfio_pci_addr *addr);
+#endif /* CONFIG_VFIO_EEH */
+
 #ifdef CONFIG_PPC64
 /*
  * MMIO read/write operations with EEH support.
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index fbd01eb..0e7f7af 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -248,6 +248,86 @@ struct eeh_pe *eeh_pe_get(struct eeh_dev *edev)
 	return pe;
 }
 
+#ifdef CONFIG_VFIO_EEH
+static void *__eeh_vfio_dev_get(void *data, void *flag)
+{
+	struct eeh_pe *pe = (struct eeh_pe *)data;
+	struct eeh_vfio_pci_addr *addr = (struct eeh_vfio_pci_addr *)flag;
+	struct eeh_dev *edev, *tmp;
+
+	eeh_pe_for_each_dev(pe, edev, tmp) {
+		if (!eeh_dev_passed(edev))
+			continue;
+
+		/* Comparing the address in the guest */
+		if (edev->guest_addr.buid == addr->buid &&
+		    edev->guest_addr.config_addr == addr->config_addr)
+			return edev;
+	}
+
+	return NULL;
+}
+
+/**
+ * eeh_vfio_dev_get - Search EEH device based on guest's address
+ * @addr: EEH device guest address
+ *
+ * Search the EEH device according to its guest's address, which
+ * is made up of PHB BUID, and PCI config address.
+ */
+struct eeh_dev *eeh_vfio_dev_get(struct eeh_vfio_pci_addr *addr)
+{
+	struct eeh_pe *root;
+	struct eeh_dev *edev;
+
+	list_for_each_entry(root, &eeh_phb_pe, child) {
+		edev = eeh_pe_traverse(root, __eeh_vfio_dev_get, addr);
+		if (edev)
+			return edev;
+	}
+
+	return NULL;
+}
+
+static void *__eeh_vfio_pe_get(void *data, void *flag)
+{
+	struct eeh_pe *pe = (struct eeh_pe *)data;
+	struct eeh_vfio_pci_addr *addr = (struct eeh_vfio_pci_addr *)flag;
+
+	if (!eeh_pe_passed(pe))
+		return NULL;
+
+	/* Comparing the address */
+	if (pe->guest_addr.buid == addr->buid &&
+	    pe->guest_addr.pe_addr == addr->pe_addr)
+		return pe;
+
+	return NULL;
+}
+
+/**
+ * eeh_vfio_pe_get - Search EEH PE based on guest's address
+ * @addr: EEH PE guest address
+ *
+ * Search the EEH PE according to the guest address, which
+ * is made up of VM indicator, PHB BUID, and PE configuration
+ * address.
+ */
+struct eeh_pe *eeh_vfio_pe_get(struct eeh_vfio_pci_addr *addr)
+{
+	struct eeh_pe *root;
+	struct eeh_pe *pe;
+
+	list_for_each_entry(root, &eeh_phb_pe, child) {
+		pe = eeh_pe_traverse(root, __eeh_vfio_pe_get, addr);
+		if (pe)
+			return pe;
+	}
+
+	return NULL;
+}
+#endif /* CONFIG_VFIO_EEH */
+
 /**
  * eeh_pe_get_parent - Retrieve the parent PE
  * @edev: EEH device
-- 
1.8.3.2
