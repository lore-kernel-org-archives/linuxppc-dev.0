Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F293B67C02
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 05:32:23 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB6IWKHD013758
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 13:32:20 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB6IWKqt200408
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 13:32:20 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB6IWKXf001880
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 13:32:20 -0500
Date: Wed, 6 Dec 2006 12:32:20 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: EEH recovery tweaks (resend)
Message-ID: <20061206183220.GB17931@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul,

Please apply and forward upstream. 
(Resend of patch from 27 October 2006.)

--linas

Subject: [PATCH] powerpc: EEH recovery tweaks

If one attempts to create a device driver recovery sequence that
does not depend on a hard reset of the device, but simply just
attempts to resume processing, then one discovers that the 
recovery sequence implemented on powerpc is not quite right.
This patch fixes this up.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c        |    1 +
 arch/powerpc/platforms/pseries/eeh_driver.c |   13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

Index: linux-2.6.19-git7/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.19-git7.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2006-11-29 15:57:37.000000000 -0600
+++ linux-2.6.19-git7/arch/powerpc/platforms/pseries/eeh_driver.c	2006-12-06 11:56:21.000000000 -0600
@@ -170,14 +170,19 @@ static void eeh_report_reset(struct pci_
 static void eeh_report_resume(struct pci_dev *dev, void *userdata)
 {
 	struct pci_driver *driver = dev->driver;
+	struct device_node *dn = pci_device_to_OF_node(dev);
 
 	dev->error_state = pci_channel_io_normal;
 
 	if (!driver)
 		return;
-	if (!driver->err_handler)
-		return;
-	if (!driver->err_handler->resume)
+
+	if ((PCI_DN(dn)->eeh_mode) & EEH_MODE_IRQ_DISABLED) {
+		PCI_DN(dn)->eeh_mode &= ~EEH_MODE_IRQ_DISABLED;
+		enable_irq(dev->irq);
+	}
+	if (!driver->err_handler ||
+	    !driver->err_handler->resume)
 		return;
 
 	driver->err_handler->resume(dev);
@@ -407,6 +412,8 @@ struct pci_dn * handle_eeh_events (struc
 
 		if (rc)
 			result = PCI_ERS_RESULT_NEED_RESET;
+		else
+			result = PCI_ERS_RESULT_RECOVERED;
 	}
 
 	/* If any device has a hard failure, then shut off everything. */
Index: linux-2.6.19-git7/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.19-git7.orig/arch/powerpc/platforms/pseries/eeh.c	2006-11-29 15:57:37.000000000 -0600
+++ linux-2.6.19-git7/arch/powerpc/platforms/pseries/eeh.c	2006-12-06 11:56:21.000000000 -0600
@@ -337,6 +337,7 @@ int eeh_dn_check_failure(struct device_n
 			printk (KERN_ERR "EEH: Device driver ignored %d bad reads, panicing\n",
 			        pdn->eeh_check_count);
 			dump_stack();
+			msleep(5000);
 			
 			/* re-read the slot reset state */
 			if (read_slot_reset_state(pdn, rets) != 0)
