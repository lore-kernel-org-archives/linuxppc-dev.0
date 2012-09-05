Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A01232C0388
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2012 16:15:26 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 5 Sep 2012 00:15:24 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 434F61FF003D
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2012 00:15:20 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q856FLms236910
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2012 00:15:21 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q856FKdI028840
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2012 00:15:21 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/21] ppc/eeh: trace EEH state based on PE
Date: Wed,  5 Sep 2012 14:14:46 +0800
Message-Id: <1346825696-13960-12-git-send-email-shangw@linux.vnet.ibm.com>
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

Since we've introduced dedicated struct to trace individual PEs,
it's reasonable to trace its state through the dedicated struct
instead of using "eeh_dev" any more.

The patches implements the state tracing based on PE. It's notable
that the PE state will be applied to the specified PE as well as
its child PEs. That complies with the rule that problematic parent
PE will prevent those child PEs from working properly.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h          |    3 +
 arch/powerpc/include/asm/ppc-pci.h      |    4 +-
 arch/powerpc/platforms/pseries/eeh.c    |  102 -------------------------------
 arch/powerpc/platforms/pseries/eeh_pe.c |   79 ++++++++++++++++++++++++
 4 files changed, 84 insertions(+), 104 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index fd69584..493dc7c 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -67,6 +67,9 @@ struct eeh_pe {
 	struct list_head child;		/* Child PEs			*/
 };
 
+#define eeh_pe_for_each_dev(pe, edev) \
+		list_for_each_entry(edev, &pe->edevs, list)
+
 /*
  * The struct is used to trace EEH state for the associated
  * PCI device node or PCI device. In future, it might
diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 80fa704..c7e5bd6 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -57,8 +57,8 @@ int eeh_reset_pe(struct eeh_dev *);
 void eeh_restore_bars(struct eeh_dev *);
 int rtas_write_config(struct pci_dn *, int where, int size, u32 val);
 int rtas_read_config(struct pci_dn *, int where, int size, u32 *val);
-void eeh_mark_slot(struct device_node *dn, int mode_flag);
-void eeh_clear_slot(struct device_node *dn, int mode_flag);
+void eeh_pe_state_mark(struct eeh_pe *pe, int state);
+void eeh_pe_state_clear(struct eeh_pe *pe, int state);
 struct device_node *eeh_find_device_pe(struct device_node *dn);
 
 void eeh_sysfs_add_device(struct pci_dev *pdev);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 82a5fdc..c527c46 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -279,108 +279,6 @@ struct device_node *eeh_find_device_pe(struct device_node *dn)
 }
 
 /**
- * __eeh_mark_slot - Mark all child devices as failed
- * @parent: parent device
- * @mode_flag: failure flag
- *
- * Mark all devices that are children of this device as failed.
- * Mark the device driver too, so that it can see the failure
- * immediately; this is critical, since some drivers poll
- * status registers in interrupts ... If a driver is polling,
- * and the slot is frozen, then the driver can deadlock in
- * an interrupt context, which is bad.
- */
-static void __eeh_mark_slot(struct device_node *parent, int mode_flag)
-{
-	struct device_node *dn;
-
-	for_each_child_of_node(parent, dn) {
-		if (of_node_to_eeh_dev(dn)) {
-			/* Mark the pci device driver too */
-			struct pci_dev *dev = of_node_to_eeh_dev(dn)->pdev;
-
-			of_node_to_eeh_dev(dn)->mode |= mode_flag;
-
-			if (dev && dev->driver)
-				dev->error_state = pci_channel_io_frozen;
-
-			__eeh_mark_slot(dn, mode_flag);
-		}
-	}
-}
-
-/**
- * eeh_mark_slot - Mark the indicated device and its children as failed
- * @dn: parent device
- * @mode_flag: failure flag
- *
- * Mark the indicated device and its child devices as failed.
- * The device drivers are marked as failed as well.
- */
-void eeh_mark_slot(struct device_node *dn, int mode_flag)
-{
-	struct pci_dev *dev;
-	dn = eeh_find_device_pe(dn);
-
-	/* Back up one, since config addrs might be shared */
-	if (!pcibios_find_pci_bus(dn) && of_node_to_eeh_dev(dn->parent))
-		dn = dn->parent;
-
-	of_node_to_eeh_dev(dn)->mode |= mode_flag;
-
-	/* Mark the pci device too */
-	dev = of_node_to_eeh_dev(dn)->pdev;
-	if (dev)
-		dev->error_state = pci_channel_io_frozen;
-
-	__eeh_mark_slot(dn, mode_flag);
-}
-
-/**
- * __eeh_clear_slot - Clear failure flag for the child devices
- * @parent: parent device
- * @mode_flag: flag to be cleared
- *
- * Clear failure flag for the child devices.
- */
-static void __eeh_clear_slot(struct device_node *parent, int mode_flag)
-{
-	struct device_node *dn;
-
-	for_each_child_of_node(parent, dn) {
-		if (of_node_to_eeh_dev(dn)) {
-			of_node_to_eeh_dev(dn)->mode &= ~mode_flag;
-			of_node_to_eeh_dev(dn)->check_count = 0;
-			__eeh_clear_slot(dn, mode_flag);
-		}
-	}
-}
-
-/**
- * eeh_clear_slot - Clear failure flag for the indicated device and its children
- * @dn: parent device
- * @mode_flag: flag to be cleared
- *
- * Clear failure flag for the indicated device and its children.
- */
-void eeh_clear_slot(struct device_node *dn, int mode_flag)
-{
-	unsigned long flags;
-	raw_spin_lock_irqsave(&confirm_error_lock, flags);
-	
-	dn = eeh_find_device_pe(dn);
-	
-	/* Back up one, since config addrs might be shared */
-	if (!pcibios_find_pci_bus(dn) && of_node_to_eeh_dev(dn->parent))
-		dn = dn->parent;
-
-	of_node_to_eeh_dev(dn)->mode &= ~mode_flag;
-	of_node_to_eeh_dev(dn)->check_count = 0;
-	__eeh_clear_slot(dn, mode_flag);
-	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
-}
-
-/**
  * eeh_dn_check_failure - Check if all 1's data is due to EEH slot freeze
  * @dn: device node
  * @dev: pci device, if known
diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
index ed675b8..3041e32 100644
--- a/arch/powerpc/platforms/pseries/eeh_pe.c
+++ b/arch/powerpc/platforms/pseries/eeh_pe.c
@@ -382,3 +382,82 @@ int eeh_pe_remove(struct eeh_dev *edev)
 	return 0;
 }
 
+/**
+ * __eeh_pe_state_mark - Mark the state for the PE
+ * @data: EEH PE
+ * @flag: state
+ *
+ * The function is used to mark the indicated state for the given
+ * PE. Also, the associated PCI devices will be put into IO frozen
+ * state as well.
+ */
+static void *__eeh_pe_state_mark(void *data, void *flag)
+{
+	struct eeh_pe *pe = (struct eeh_pe *)data;
+	int state = *((int *)flag);
+	struct eeh_dev *tmp;
+	struct pci_dev *pdev;
+
+	/*
+	 * Mark the PE with the indicated state. Also,
+	 * the associated PCI device will be put into
+	 * I/O frozen state to avoid I/O accesses from
+	 * the PCI device driver.
+	 */
+	pe->state |= state;
+	eeh_pe_for_each_dev(pe, tmp) {
+		pdev = eeh_dev_to_pci_dev(tmp);
+		if (pdev)
+			pdev->error_state = pci_channel_io_frozen;
+	}
+
+	return NULL;
+}
+
+/**
+ * eeh_pe_state_mark - Mark specified state for PE and its associated device
+ * @pe: EEH PE
+ *
+ * EEH error affects the current PE and its child PEs. The function
+ * is used to mark appropriate state for the affected PEs and the
+ * associated devices.
+ */
+void eeh_pe_state_mark(struct eeh_pe *pe, int state)
+{
+	eeh_pe_traverse(pe, __eeh_pe_state_mark, &state);
+}
+
+/**
+ * __eeh_pe_state_clear - Clear state for the PE
+ * @data: EEH PE
+ * @flag: state
+ *
+ * The function is used to clear the indicated state from the
+ * given PE. Besides, we also clear the check count of the PE
+ * as well.
+ */
+static void *__eeh_pe_state_clear(void *data, void *flag)
+{
+	struct eeh_pe *pe = (struct eeh_pe *)data;
+	int state = *((int *)flag);
+
+	pe->state &= ~state;
+	pe->check_count = 0;
+
+	return NULL;
+}
+
+/**
+ * eeh_pe_state_clear - Clear state for the PE and its children
+ * @pe: PE
+ * @state: state to be cleared
+ *
+ * When the PE and its children has been recovered from error,
+ * we need clear the error state for that. The function is used
+ * for the purpose.
+ */
+void eeh_pe_state_clear(struct eeh_pe *pe, int state)
+{
+	eeh_pe_traverse(pe, __eeh_pe_state_clear, &state);
+}
+
-- 
1.7.5.4
