Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A5A70B6FFF
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 02:02:32 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 12:02:30 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A9B136E807B
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:02:25 -0400 (EDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5RG2NSu214008
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:02:24 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5RG28mE024466
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:02:08 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 14/21] ppc/eeh: device bars restore based on PE
Date: Thu, 28 Jun 2012 00:01:44 +0800
Message-Id: <1340812911-6793-15-git-send-email-shangw@linux.vnet.ibm.com>
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

The patch introduces the function to traverse the devices of the
specified PE and its child PEs. Also, the restore on device bars
is implemented based on the traverse function.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h          |    3 +
 arch/powerpc/include/asm/ppc-pci.h      |    1 -
 arch/powerpc/platforms/pseries/eeh.c    |   79 --------------------------
 arch/powerpc/platforms/pseries/eeh_pe.c |   93 +++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+), 80 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 96451b7..9a9fe28 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -171,6 +171,9 @@ typedef void *(*eeh_traverse_func)(void *data, void *flag);
 int __devinit eeh_phb_pe_create(struct pci_controller *phb);
 int eeh_pe_create(struct eeh_dev *edev);
 int eeh_pe_remove(struct eeh_dev *edev);
+void *eeh_pe_dev_traverse(struct eeh_pe *root,
+		eeh_traverse_func fn, void *flag);
+void eeh_pe_restore_bars(struct eeh_pe *pe);
 
 void * __devinit eeh_dev_init(struct device_node *dn, void *data);
 void __devinit eeh_dev_phb_init_dynamic(struct pci_controller *phb);
diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 3e301b1..5cbe3f2 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -54,7 +54,6 @@ struct pci_dev *pci_addr_cache_get_device(unsigned long addr);
 void eeh_slot_error_detail(struct eeh_dev *edev, int severity);
 int eeh_pci_enable(struct eeh_dev *edev, int function);
 int eeh_reset_pe(struct eeh_dev *);
-void eeh_restore_bars(struct eeh_dev *);
 int rtas_write_config(struct pci_dn *, int where, int size, u32 val);
 int rtas_read_config(struct pci_dn *, int where, int size, u32 *val);
 void eeh_pe_state_mark(struct eeh_pe *pe, int state);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 636413f..28d0c04 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -610,85 +610,6 @@ int eeh_reset_pe(struct eeh_dev *edev)
 	return -1;
 }
 
-/** Save and restore of PCI BARs
- *
- * Although firmware will set up BARs during boot, it doesn't
- * set up device BAR's after a device reset, although it will,
- * if requested, set up bridge configuration. Thus, we need to
- * configure the PCI devices ourselves.  
- */
-
-/**
- * eeh_restore_one_device_bars - Restore the Base Address Registers for one device
- * @edev: PCI device associated EEH device
- *
- * Loads the PCI configuration space base address registers,
- * the expansion ROM base address, the latency timer, and etc.
- * from the saved values in the device node.
- */
-static inline void eeh_restore_one_device_bars(struct eeh_dev *edev)
-{
-	int i;
-	u32 cmd;
-	struct device_node *dn = eeh_dev_to_of_node(edev);
-
-	if (!edev->phb)
-		return;
-
-	for (i=4; i<10; i++) {
-		eeh_ops->write_config(dn, i*4, 4, edev->config_space[i]);
-	}
-
-	/* 12 == Expansion ROM Address */
-	eeh_ops->write_config(dn, 12*4, 4, edev->config_space[12]);
-
-#define BYTE_SWAP(OFF) (8*((OFF)/4)+3-(OFF))
-#define SAVED_BYTE(OFF) (((u8 *)(edev->config_space))[BYTE_SWAP(OFF)])
-
-	eeh_ops->write_config(dn, PCI_CACHE_LINE_SIZE, 1,
-	            SAVED_BYTE(PCI_CACHE_LINE_SIZE));
-
-	eeh_ops->write_config(dn, PCI_LATENCY_TIMER, 1,
-	            SAVED_BYTE(PCI_LATENCY_TIMER));
-
-	/* max latency, min grant, interrupt pin and line */
-	eeh_ops->write_config(dn, 15*4, 4, edev->config_space[15]);
-
-	/* Restore PERR & SERR bits, some devices require it,
-	 * don't touch the other command bits
-	 */
-	eeh_ops->read_config(dn, PCI_COMMAND, 4, &cmd);
-	if (edev->config_space[1] & PCI_COMMAND_PARITY)
-		cmd |= PCI_COMMAND_PARITY;
-	else
-		cmd &= ~PCI_COMMAND_PARITY;
-	if (edev->config_space[1] & PCI_COMMAND_SERR)
-		cmd |= PCI_COMMAND_SERR;
-	else
-		cmd &= ~PCI_COMMAND_SERR;
-	eeh_ops->write_config(dn, PCI_COMMAND, 4, cmd);
-}
-
-/**
- * eeh_restore_bars - Restore the PCI config space info
- * @edev: EEH device
- *
- * This routine performs a recursive walk to the children
- * of this device as well.
- */
-void eeh_restore_bars(struct eeh_dev *edev)
-{
-	struct device_node *dn;
-	if (!edev)
-		return;
-	
-	if ((edev->mode & EEH_MODE_SUPPORTED) && !IS_BRIDGE(edev->class_code))
-		eeh_restore_one_device_bars(edev);
-
-	for_each_child_of_node(eeh_dev_to_of_node(edev), dn)
-		eeh_restore_bars(of_node_to_eeh_dev(dn));
-}
-
 /**
  * eeh_save_bars - Save device bars
  * @edev: PCI device associated EEH device
diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
index 3041e32..8bae0f6 100644
--- a/arch/powerpc/platforms/pseries/eeh_pe.c
+++ b/arch/powerpc/platforms/pseries/eeh_pe.c
@@ -154,6 +154,38 @@ static void *eeh_pe_traverse(struct eeh_pe *root,
 }
 
 /**
+ * eeh_pe_dev_traverse - Traverse the devices from the PE
+ * @root: EEH PE
+ * @fn: function callback
+ * @flag: extra parameter to callback
+ *
+ * The function is used to traverse the devices of the specified
+ * PE and its child PEs.
+ */
+void *eeh_pe_dev_traverse(struct eeh_pe *root,
+		eeh_traverse_func fn, void *flag)
+{
+	struct eeh_pe *pe;
+	struct eeh_dev *edev;
+	void *ret;
+
+	if (!root) {
+		pr_warning("%s: Invalid PE %p\n", __func__, root);
+		return NULL;
+	}
+
+	/* Traverse root PE */
+	for (pe = root; pe; pe = eeh_pe_next(pe, root)) {
+		eeh_pe_for_each_dev(pe, edev) {
+			ret = fn(edev, flag);
+			if (ret) return ret;
+		}
+	}
+
+	return NULL;
+}
+
+/**
  * __eeh_pe_get - Check the PE address
  * @data: EEH PE
  * @flag: EEH device
@@ -461,3 +493,64 @@ void eeh_pe_state_clear(struct eeh_pe *pe, int state)
 	eeh_pe_traverse(pe, __eeh_pe_state_clear, &state);
 }
 
+/**
+ * eeh_restore_one_device_bars - Restore the Base Address Registers for one device
+ * @data: EEH device
+ * @flag: Unused
+ *
+ * Loads the PCI configuration space base address registers,
+ * the expansion ROM base address, the latency timer, and etc.
+ * from the saved values in the device node.
+ */
+static void *eeh_restore_one_device_bars(void *data, void *flag)
+{
+	int i;
+	u32 cmd;
+	struct eeh_dev *edev = (struct eeh_dev *)data;
+	struct device_node *dn = eeh_dev_to_of_node(edev);
+
+	for (i = 4; i < 10; i++)
+                eeh_ops->write_config(dn, i*4, 4, edev->config_space[i]);
+	/* 12 == Expansion ROM Address */
+	eeh_ops->write_config(dn, 12*4, 4, edev->config_space[12]);
+
+#define BYTE_SWAP(OFF) (8*((OFF)/4)+3-(OFF))
+#define SAVED_BYTE(OFF) (((u8 *)(edev->config_space))[BYTE_SWAP(OFF)])
+
+	eeh_ops->write_config(dn, PCI_CACHE_LINE_SIZE, 1,
+			SAVED_BYTE(PCI_CACHE_LINE_SIZE));
+	eeh_ops->write_config(dn, PCI_LATENCY_TIMER, 1,
+		SAVED_BYTE(PCI_LATENCY_TIMER));
+
+	/* max latency, min grant, interrupt pin and line */
+	eeh_ops->write_config(dn, 15*4, 4, edev->config_space[15]);
+
+	/* Restore PERR & SERR bits, some devices require it,
+	 * don't touch the other command bits
+	 */
+	eeh_ops->read_config(dn, PCI_COMMAND, 4, &cmd);
+	if (edev->config_space[1] & PCI_COMMAND_PARITY)
+		cmd |= PCI_COMMAND_PARITY;
+	else
+		cmd &= ~PCI_COMMAND_PARITY;
+	if (edev->config_space[1] & PCI_COMMAND_SERR)
+		cmd |= PCI_COMMAND_SERR;
+	else
+		cmd &= ~PCI_COMMAND_SERR;
+	eeh_ops->write_config(dn, PCI_COMMAND, 4, cmd);
+
+	return NULL;
+}
+
+/**
+ * eeh_pe_restore_bars - Restore the PCI config space info
+ * @pe: EEH PE
+ *
+ * This routine performs a recursive walk to the children
+ * of this device as well.
+ */
+void eeh_pe_restore_bars(struct eeh_pe *pe)
+{
+	eeh_pe_dev_traverse(pe, eeh_restore_one_device_bars, NULL);
+}
+
-- 
1.7.9.5
