Return-Path: <mmlnx@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3A8E4DDDA1
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 08:12:26 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n1ALA9o5001198
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 14:10:09 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n1ALCLc0188928
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 14:12:21 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n1ALCL0m026230
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 14:12:21 -0700
Message-ID: <4991EDB5.8070803@us.ibm.com>
Date: Tue, 10 Feb 2009 13:12:21 -0800
From: Mike Mason <mmlnx@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Only disable/enable LSI interrupts in EEH
References: <4990EF8B.7060203@us.ibm.com>
In-Reply-To: <4990EF8B.7060203@us.ibm.com>
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

I'm resubmitting this patch with a couple changes
suggested by Michael Ellerman.  1) the new functions
should be static, and 2) some people may object to
including unrelated formating changes.

=========================================================

The EEH code disables and enables interrupts during the
device recovery process.  This is unnecessary for MSI
and MSI-X interrupts because they are effectively disabled
by the DMA Stopped state when an EEH error occurs.  The
current code is also incorrect for MSI-X interrupts.  It
doesn't take into account that MSI-X interrupts are tracked
in a different way than LSI/MSI interrupts.  This patch 
ensures only LSI interrupts are disabled/enabled.

Signed-off-by: Mike Mason <mmlnx@us.ibm.com>
Acked-by: Linas Vepstas <linasvepstas@gmail.com>


--- arch/powerpc/platforms/pseries/eeh_driver.c-orig	2009-02-10 07:12:31.000000000 -0800
+++ arch/powerpc/platforms/pseries/eeh_driver.c	2009-02-10 08:19:54.000000000 -0800
@@ -76,6 +76,40 @@ static int irq_in_use(unsigned int irq)
 	return rc;
 }
 
+/**
+ * eeh_disable_irq - disable interrupt for the recovering device
+ */
+static void eeh_disable_irq(struct pci_dev *dev)
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
+static void eeh_enable_irq(struct pci_dev *dev)
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
 
