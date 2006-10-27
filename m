Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0C5BD67D8E
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Oct 2006 07:12:49 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9RLCTwX018409
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 17:12:29 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9RLCTYE383598
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 15:12:29 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9RLCShK024090
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 15:12:28 -0600
Date: Fri, 27 Oct 2006 16:12:28 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: Subject: [PATCH] powerpc: EEH recovery tweaks
Message-ID: <20061027211227.GJ6360@austin.ibm.com>
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

Please apply and forward upstream. This patch is not urgent,
it provides fixes for a code path that is not currently used
by any existing driver.

--linas

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

Index: linux-2.6.19-rc1-git11/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.19-rc1-git11.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2006-10-26 16:21:06.000000000 -0500
+++ linux-2.6.19-rc1-git11/arch/powerpc/platforms/pseries/eeh_driver.c	2006-10-26 16:33:19.000000000 -0500
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
