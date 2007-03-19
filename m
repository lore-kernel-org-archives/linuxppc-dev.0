Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 40644DDED0
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 06:52:10 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2JJq5AZ031661
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 15:52:05 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2JJq5ea150304
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 15:52:05 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2JJq5O6016118
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 15:52:05 -0400
Date: Mon, 19 Mar 2007 14:52:04 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/11] ppc64: EEH: Add clarifying messages.
Message-ID: <20070319195204.GB11532@austin.ibm.com>
References: <20070319194349.GT5151@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070319194349.GT5151@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


There are multiple code patchs tht resuls in a "permanent
failure"; when examining rare events, it can be hard to see 
which was taken. This patch adds printk's to assist.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_driver.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

Index: linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2007-03-19 12:51:09.000000000 -0500
+++ linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh_driver.c	2007-03-19 13:19:28.000000000 -0500
@@ -367,8 +367,10 @@ struct pci_dn * handle_eeh_events (struc
 	 */
 	if ((event->state == pci_channel_io_perm_failure) &&
 	    ((event->time_unavail <= 0) ||
-	     (event->time_unavail > MAX_WAIT_FOR_RECOVERY*1000)))
+	     (event->time_unavail > MAX_WAIT_FOR_RECOVERY*1000))) {
+		printk(KERN_WARNING "EEH: Permanent failure\n");
 		goto hard_fail;
+	}
 
 	eeh_slot_error_detail(frozen_pdn, 1 /* Temporary Error */);
 	printk(KERN_WARNING
@@ -390,8 +392,10 @@ struct pci_dn * handle_eeh_events (struc
 	 */
 	if (result == PCI_ERS_RESULT_NONE) {
 		rc = eeh_reset_device(frozen_pdn, frozen_bus);
-		if (rc)
+		if (rc) {
+			printk(KERN_WARNING "EEH: Unable to reset, rc=%d\n", rc);
 			goto hard_fail;
+		}
 	}
 
 	/* If all devices reported they can proceed, then re-enable MMIO */
@@ -417,21 +421,27 @@ struct pci_dn * handle_eeh_events (struc
 	}
 
 	/* If any device has a hard failure, then shut off everything. */
-	if (result == PCI_ERS_RESULT_DISCONNECT)
+	if (result == PCI_ERS_RESULT_DISCONNECT) {
+		printk(KERN_WARNING "EEH: Device driver gave up\n");
 		goto hard_fail;
+	}
 
 	/* If any device called out for a reset, then reset the slot */
 	if (result == PCI_ERS_RESULT_NEED_RESET) {
 		rc = eeh_reset_device(frozen_pdn, NULL);
-		if (rc)
+		if (rc) {
+			printk(KERN_WARNING "EEH: Cannot reset, rc=%d\n", rc);
 			goto hard_fail;
+		}
 		result = PCI_ERS_RESULT_NONE;
 		pci_walk_bus(frozen_bus, eeh_report_reset, &result);
 	}
 
 	/* All devices should claim they have recovered by now. */
-	if (result != PCI_ERS_RESULT_RECOVERED)
+	if (result != PCI_ERS_RESULT_RECOVERED) {
+		printk(KERN_WARNING "EEH: Not recovered\n");
 		goto hard_fail;
+	}
 
 	/* Tell all device drivers that they can resume operations */
 	pci_walk_bus(frozen_bus, eeh_report_resume, NULL);
