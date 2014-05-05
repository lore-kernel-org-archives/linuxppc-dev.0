Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4D838140172
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:56 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 11:27:55 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 391DC3578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:53 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s451Rc7v3867026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:27:38 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s451Rqrc011612
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:27:52 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 02/22] powerpc/eeh: Info to trace passed devices
Date: Mon,  5 May 2014 11:27:51 +1000
Message-Id: <1399253291-3975-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
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

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h | 49 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 7782056..8bfb167 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -48,6 +48,17 @@ struct device_node;
 #define EEH_PE_RST_HOLD_TIME		250
 #define EEH_PE_RST_SETTLE_TIME		1800
 
+#ifdef CONFIG_KVM_EEH
+struct eeh_vfio_pci_addr {
+	struct kvm	*kvm;		/* KVM identifier		*/
+	unsigned int	buid_hi;	/* PHB BUID high		*/
+	unsigned int	buid_lo;	/* PHB BUID low			*/
+	unsigned char	bus;		/* Bus number			*/
+	unsigned char	devfn;		/* Slot and function		*/
+	int		pe_addr;	/* PE configuration address	*/
+};
+#endif /* CONFIG_KVM_EEH */
+
 /*
  * The struct is used to trace PE related EEH functionality.
  * In theory, there will have one instance of the struct to
@@ -72,6 +83,7 @@ struct device_node;
 #define EEH_PE_RESET		(1 << 2)	/* PE reset in progress	*/
 
 #define EEH_PE_KEEP		(1 << 8)	/* Keep PE on hotplug	*/
+#define EEH_PE_PASSTHROUGH	(1 << 9)	/* PE owned by guest	*/
 
 struct eeh_pe {
 	int type;			/* PE type: PHB/Bus/Device	*/
@@ -85,6 +97,9 @@ struct eeh_pe {
 	struct timeval tstamp;		/* Time on first-time freeze	*/
 	int false_positives;		/* Times of reported #ff's	*/
 	struct eeh_pe *parent;		/* Parent PE			*/
+#ifdef CONFIG_KVM_EEH
+	struct eeh_vfio_pci_addr gaddr;	/* Associated KVM guest address */
+#endif
 	struct list_head child_list;	/* Link PE to the child list	*/
 	struct list_head edevs;		/* Link list of EEH devices	*/
 	struct list_head child;		/* Child PEs			*/
@@ -93,6 +108,21 @@ struct eeh_pe {
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
@@ -110,6 +140,7 @@ struct eeh_pe {
 #define EEH_DEV_SYSFS		(1 << 9)	/* Sysfs created	*/
 #define EEH_DEV_REMOVED		(1 << 10)	/* Removed permanently	*/
 #define EEH_DEV_FRESET		(1 << 11)	/* Fundamental reset	*/
+#define EEH_DEV_PASSTHROUGH	(1 << 12)	/* Owned by guest	*/
 
 struct eeh_dev {
 	int mode;			/* EEH mode			*/
@@ -126,6 +157,9 @@ struct eeh_dev {
 	struct device_node *dn;		/* Associated device node	*/
 	struct pci_dev *pdev;		/* Associated PCI device	*/
 	struct pci_bus *bus;		/* PCI bus for partial hotplug	*/
+#ifdef CONFIG_KVM_EEH
+	struct eeh_vfio_pci_addr gaddr;	/* Address in guest		*/
+#endif
 };
 
 static inline struct device_node *eeh_dev_to_of_node(struct eeh_dev *edev)
@@ -138,6 +172,21 @@ static inline struct pci_dev *eeh_dev_to_pci_dev(struct eeh_dev *edev)
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
-- 
1.8.3.2
