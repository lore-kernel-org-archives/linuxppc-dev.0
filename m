Return-Path: <brking@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7A2DEDDEE3
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 07:49:41 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0CKnZvO024668
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 15:49:35 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	l0CKnZf4303004
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 15:49:35 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0CKnZEr018906
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 15:49:35 -0500
Subject: [PATCH 1/1] powerpc: Export PCI slot reset API
To: paulus@samba.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Fri, 12 Jan 2007 14:49:32 -0600
Message-Id: <11686349711123-patch-mail.ibm.com>
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Adds two new APIs to assert/deassert PCI reset to a given
device. This is needed for an ipr PCI-E adapter which does not
properly implement either BIST nor PCI-E hot reset, requiring
a PCI-E warm reset, which is what this implements.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 linux-2.6-bjking1/arch/powerpc/platforms/pseries/eeh.c |   41 +++++++++++++++++
 linux-2.6-bjking1/include/asm-powerpc/ppc-pci.h        |    3 +
 2 files changed, 44 insertions(+)

diff -puN arch/powerpc/platforms/pseries/eeh.c~powerpc_slot_reset_api2 arch/powerpc/platforms/pseries/eeh.c
--- linux-2.6/arch/powerpc/platforms/pseries/eeh.c~powerpc_slot_reset_api2	2007-01-11 15:52:57.000000000 -0600
+++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/eeh.c	2007-01-11 15:52:57.000000000 -0600
@@ -591,6 +591,47 @@ static void __rtas_set_slot_reset(struct
 	msleep (PCI_BUS_SETTLE_TIME_MSEC);
 }
 
+/**
+ * pci_set_slot_reset - Assert PCI reset to the PCI slot
+ * @dev:	pci device struct
+ *
+ * After asserting PCI reset, the caller should wait for
+ * 100 milliseconds or longer.
+ *
+ * Return value:
+ * 	0 if success
+ **/
+int pci_set_slot_reset(struct pci_dev *dev)
+{
+	struct device_node *dn = pci_device_to_OF_node(dev);
+	struct pci_dn *pdn = PCI_DN(dn);
+
+	rtas_pci_slot_reset(pdn, 3);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_set_slot_reset);
+
+/**
+ * pci_clear_slot_reset - Clear PCI reset to the PCI slot
+ * @dev:	pci device struct
+ *
+ * After clearing PCI reset, the caller should wait 1.8 seconds
+ * or longer for the bus to stabilize and the device to come
+ * ready.
+ *
+ * Return value:
+ * 	0 if success
+ **/
+int pci_clear_slot_reset(struct pci_dev *dev)
+{
+	struct device_node *dn = pci_device_to_OF_node(dev);
+	struct pci_dn *pdn = PCI_DN(dn);
+
+	rtas_pci_slot_reset (pdn, 0);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_clear_slot_reset);
+
 int rtas_set_slot_reset(struct pci_dn *pdn)
 {
 	int i, rc;
diff -puN include/asm-powerpc/ppc-pci.h~powerpc_slot_reset_api2 include/asm-powerpc/ppc-pci.h
--- linux-2.6/include/asm-powerpc/ppc-pci.h~powerpc_slot_reset_api2	2007-01-11 15:52:57.000000000 -0600
+++ linux-2.6-bjking1/include/asm-powerpc/ppc-pci.h	2007-01-11 15:52:57.000000000 -0600
@@ -124,6 +124,9 @@ void eeh_clear_slot (struct device_node 
 /* Find the associated "Partiationable Endpoint" PE */
 struct device_node * find_device_pe(struct device_node *dn);
 
+int pci_set_slot_reset(struct pci_dev *dev);
+int pci_clear_slot_reset(struct pci_dev *dev);
+
 #endif
 
 #endif /* __KERNEL__ */
_
