Return-Path: <mmlnx@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E3A56DDDBA
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 14:08:21 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n1A36POn000836
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Feb 2009 22:06:25 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n1A38InL132896
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Feb 2009 22:08:18 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n1A38H8N009768
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Feb 2009 22:08:18 -0500
Message-ID: <4990EF8B.7060203@us.ibm.com>
Date: Mon, 09 Feb 2009 19:07:55 -0800
From: Mike Mason <mmlnx@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Only disable/enable LSI interrupts in EEH
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linasvepstas@gmail.com, paulus@samba.org, ellerman@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The EEH code disables and enables interrupts during the
device recovery process.  This is unnecessary for MSI
and MSI-X interrupts because they are effectively disabled
by the DMA Stopped state when an EEH error occurs.  The 
current code is also incorrect for MSI-X interrupts.  It
doesn't take into account that MSI-X interrupts are tracked
in a different way than LSI/MSI interrupts.  This 
patch ensures only LSI interrupts are disabled/enabled.

The patch also includes a couple minor formatting fixes.


Signed-off-by: Mike Mason <mmlnx@us.ibm.com> 

--- linux-2.6.18.ppc64-orig/arch/powerpc/platforms/pseries/eeh_driver.c	2009-01-16 10:59:59.000000000 -0800
+++ linux-2.6.18.ppc64/arch/powerpc/platforms/pseries/eeh_driver.c	2009-02-07 12:29:14.000000000 -0800
@@ -67,7 +67,7 @@ static int irq_in_use(unsigned int irq)
 {
 	int rc = 0;
 	unsigned long flags;
-   struct irq_desc *desc = irq_desc + irq;
+	struct irq_desc *desc = irq_desc + irq;
 
 	spin_lock_irqsave(&desc->lock, flags);
 	if (desc->action)
@@ -76,6 +76,40 @@ static int irq_in_use(unsigned int irq)
 	return rc;
 }
 
+/**
+ * eeh_disable_irq - disable interrupt for the recovering device
+ */
+void eeh_disable_irq(struct pci_dev *dev)
+{
+	struct device_node *dn = pci_device_to_OF_node(dev);
+
+	/* Don't disable MSI and MSI-X interrupts. They are
+	 * effectively disabled by the DMA Stopped state 
+	 * when an EEH error occurs.
+	*/
+	if (dev->msi_enabled || dev->msix_enabled)
+		return;
+
+	if (!irq_in_use(dev->irq))
+		return;
+
+	PCI_DN(dn)->eeh_mode |= EEH_MODE_IRQ_DISABLED;
+	disable_irq_nosync(dev->irq);
+}
+
+/**
+ * eeh_enable_irq - enable interrupt for the recovering device
+ */
+void eeh_enable_irq(struct pci_dev *dev)
+{
+	struct device_node *dn = pci_device_to_OF_node(dev);
+
+	if ((PCI_DN(dn)->eeh_mode) & EEH_MODE_IRQ_DISABLED) {
+		PCI_DN(dn)->eeh_mode &= ~EEH_MODE_IRQ_DISABLED;
+		enable_irq(dev->irq);
+	}
+}
+
 /* ------------------------------------------------------- */
 /**
  * eeh_report_error - report pci error to each device driver
@@ -95,11 +129,8 @@ static void eeh_report_error(struct pci_
 	if (!driver)
 		return;
 
-	if (irq_in_use (dev->irq)) {
-		struct device_node *dn = pci_device_to_OF_node(dev);
-		PCI_DN(dn)->eeh_mode |= EEH_MODE_IRQ_DISABLED;
-		disable_irq_nosync(dev->irq);
-	}
+	eeh_disable_irq(dev);
+
 	if (!driver->err_handler ||
 	    !driver->err_handler->error_detected)
 		return;
@@ -144,15 +175,12 @@ static void eeh_report_reset(struct pci_
 {
 	enum pci_ers_result rc, *res = userdata;
 	struct pci_driver *driver = dev->driver;
-	struct device_node *dn = pci_device_to_OF_node(dev);
 
 	if (!driver)
 		return;
 
-	if ((PCI_DN(dn)->eeh_mode) & EEH_MODE_IRQ_DISABLED) {
-		PCI_DN(dn)->eeh_mode &= ~EEH_MODE_IRQ_DISABLED;
-		enable_irq(dev->irq);
-	}
+	eeh_enable_irq(dev);
+
 	if (!driver->err_handler ||
 	    !driver->err_handler->slot_reset)
 		return;
@@ -171,17 +199,14 @@ static void eeh_report_reset(struct pci_
 static void eeh_report_resume(struct pci_dev *dev, void *userdata)
 {
 	struct pci_driver *driver = dev->driver;
-	struct device_node *dn = pci_device_to_OF_node(dev);
 
 	dev->error_state = pci_channel_io_normal;
 
 	if (!driver)
 		return;
 
-	if ((PCI_DN(dn)->eeh_mode) & EEH_MODE_IRQ_DISABLED) {
-		PCI_DN(dn)->eeh_mode &= ~EEH_MODE_IRQ_DISABLED;
-		enable_irq(dev->irq);
-	}
+	eeh_enable_irq(dev);
+
 	if (!driver->err_handler ||
 	    !driver->err_handler->resume)
 		return;
@@ -205,15 +230,12 @@ static void eeh_report_failure(struct pc
 	if (!driver)
 		return;
 
-	if (irq_in_use (dev->irq)) {
-		struct device_node *dn = pci_device_to_OF_node(dev);
-		PCI_DN(dn)->eeh_mode |= EEH_MODE_IRQ_DISABLED;
-		disable_irq_nosync(dev->irq);
-	}
-	if (!driver->err_handler)
-		return;
-	if (!driver->err_handler->error_detected)
+	eeh_disable_irq(dev);
+
+	if (!driver->err_handler ||
+	    !driver->err_handler->error_detected)
 		return;
+
 	driver->err_handler->error_detected(dev, pci_channel_io_perm_failure);
 }
 
