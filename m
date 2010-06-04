Return-Path: <bpeters@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BEF7EB7D59
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Jun 2010 10:46:02 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o540dP56012793
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Jun 2010 18:39:25 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o540jtlY084862
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Jun 2010 18:45:56 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o540jsYc021162
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Jun 2010 18:45:55 -0600
Message-ID: <4C084CBC.7090002@linux.vnet.ibm.com>
Date: Thu, 03 Jun 2010 17:45:48 -0700
From: Brad Peters <bpeters@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, rlary@linux.vnet.ibm.com
Subject: [PATCH] - PCI EEH pci_restore_state fix allowing for repeated adapter
	recovery per state save
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch Overview:
The pci_restore_state API is shared by both power management code and Extended
Error Handling (EEH) code on Power.  This patch adds an additional recovery
function to pci_restore_state API.  The problem being addressed is that Power
Management semantics only allow the saved state of PCI device to be restored
once per save.  With this patch, EEH is able to restore the saved state
each time a PCI error is detected, enabling recovery in the face of repeated errors.

There was some discussion of renaming the existing and new functions to more
clearly break out unconditional restore from the default conditional one, but a
name change seemed a heavy-handed change to force on the 200+ current users.

Bit more detail:
PCI device drivers which support EEH/AER save their  pci state once during
driver initialization and during EEH/AER error recovery, restore the
original saved state.  What we found was that our pci driver code would
recover from the first EEH error and fail to recover on subsequent
EEH errors. This issue results from pci_restore_state() function
restoring the state during initialization on the first EEH error.

What this patch does is to provide the pci_force_restore_state() for use
by PCI drivers which support EEH/AER that require the original saved
state be restored each time an EEH/AER error is detected.


Signed-off by: Brad Peters <bpeters@us.ibm.com>
Signed-off by: Richard A Lary <rlary@linux.vnet.ibm.com>

-- 
Brad Peters
IBM
Linux on System-P Platform Serviceability Team Lead
bpeters@linux.vnet.ibm.com


-----------------


diff -uNrp -X linux-2.6.34/Documentation/dontdiff
linux-2.6.34.orig/drivers/pci/pci.c linux-2.6.34/drivers/pci/pci.c
--- linux-2.6.34.orig/drivers/pci/pci.c	2010-05-16 14:17:36.000000000 -0700
+++ linux-2.6.34/drivers/pci/pci.c	2010-05-26 17:16:20.000000000 -0700
@@ -920,19 +920,11 @@ pci_save_state(struct pci_dev *dev)
 	return 0;
 }

-/**
- * pci_restore_state - Restore the saved state of a PCI device
- * @dev: - PCI device that we're dealing with
- */
-int
-pci_restore_state(struct pci_dev *dev)
+static void __pci_restore_state(struct pci_dev *dev)
 {
 	int i;
 	u32 val;

-	if (!dev->state_saved)
-		return 0;
-
 	/* PCI Express register must be restored first */
 	pci_restore_pcie_state(dev);

@@ -953,12 +945,44 @@ pci_restore_state(struct pci_dev *dev)
 	pci_restore_pcix_state(dev);
 	pci_restore_msi_state(dev);
 	pci_restore_iov_state(dev);
+}
+
+
+/**
+ * pci_restore_state - Restore the saved state of a PCI device
+ *                     only if dev->state_saved is not 0. Used by
+ *                     power management suspend/restore routines.
+ * @dev: - PCI device that we're dealing with
+ */
+int
+pci_restore_state(struct pci_dev *dev)
+{
+
+	if (!dev->state_saved)
+		return 0;
+
+	__pci_restore_state(dev);

 	dev->state_saved = false;

 	return 0;
 }

+/**
+ * pci_force_restore_state - Restore the saved state of a PCI device
+ *                           even if dev->state_saved is 0. Used by
+ *                           EEH and AER PCI error recovery.
+ * @dev: - PCI device that we're dealing with
+ */
+int
+pci_force_restore_state(struct pci_dev *dev)
+{
+	__pci_restore_state(dev);
+
+	return 0;
+}
+
+

 static int do_pci_enable_device(struct pci_dev *dev, int bars)
 {
 	int err;
@@ -3039,6 +3063,7 @@ EXPORT_SYMBOL(pci_select_bars);
 EXPORT_SYMBOL(pci_set_power_state);
 EXPORT_SYMBOL(pci_save_state);
 EXPORT_SYMBOL(pci_restore_state);
+EXPORT_SYMBOL(pci_force_restore_state);
 EXPORT_SYMBOL(pci_pme_capable);
 EXPORT_SYMBOL(pci_pme_active);
 EXPORT_SYMBOL(pci_wake_from_d3);
diff -uNrp -X linux-2.6.34/Documentation/dontdiff
linux-2.6.34.orig/include/linux/pci.h linux-2.6.34/include/linux/pci.h
--- linux-2.6.34.orig/include/linux/pci.h	2010-05-16 14:17:36.000000000 -0700
+++ linux-2.6.34/include/linux/pci.h	2010-05-26 17:16:21.000000000 -0700
@@ -792,6 +792,7 @@ size_t pci_get_rom_size(struct pci_dev *
 /* Power management related routines */
 int pci_save_state(struct pci_dev *dev);
 int pci_restore_state(struct pci_dev *dev);
+int pci_force_restore_state(struct pci_dev *dev);
 int __pci_complete_power_transition(struct pci_dev *dev, pci_power_t state);
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
 pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state);
@@ -1155,6 +1156,11 @@ static inline int pci_restore_state(stru
 	return 0;
 }

+static inline int pci_force_restore_state(struct pci_dev *dev)
+{
+	return 0;
+}
+
 static inline int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	return 0;
