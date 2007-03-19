Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 03012DDF9B
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 07:00:43 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2JK0br3000338
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 16:00:37 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2JK00CU292008
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 16:00:00 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2JK00gh015898
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 16:00:00 -0400
Date: Mon, 19 Mar 2007 14:59:59 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 10/11] ppc64: EEH: verify state change
Message-ID: <20070319195959.GJ11532@austin.ibm.com>
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


After requesting a state change, verify that the state change 
actually ocurred, and the system ends up in the expected state.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c        |    6 +++++-
 arch/powerpc/platforms/pseries/eeh_driver.c |    6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

Index: linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2007-03-19 13:21:49.000000000 -0500
+++ linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh_driver.c	2007-03-19 13:21:53.000000000 -0500
@@ -300,7 +300,7 @@ static int eeh_reset_device (struct pci_
 /* The longest amount of time to wait for a pci device
  * to come back on line, in seconds.
  */
-#define MAX_WAIT_FOR_RECOVERY 15
+#define MAX_WAIT_FOR_RECOVERY 150
 
 struct pci_dn * handle_eeh_events (struct eeh_event *event)
 {
@@ -393,6 +393,8 @@ struct pci_dn * handle_eeh_events (struc
 	if (result == PCI_ERS_RESULT_CAN_RECOVER) {
 		rc = rtas_pci_enable(frozen_pdn, EEH_THAW_MMIO);
 
+		if (rc < 0)
+			goto hard_fail;
 		if (rc) {
 			result = PCI_ERS_RESULT_NEED_RESET;
 		} else {
@@ -405,6 +407,8 @@ struct pci_dn * handle_eeh_events (struc
 	if (result == PCI_ERS_RESULT_CAN_RECOVER) {
 		rc = rtas_pci_enable(frozen_pdn, EEH_THAW_DMA);
 
+		if (rc < 0)
+			goto hard_fail;
 		if (rc)
 			result = PCI_ERS_RESULT_NEED_RESET;
 		else
Index: linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/arch/powerpc/platforms/pseries/eeh.c	2007-03-19 13:21:49.000000000 -0500
+++ linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh.c	2007-03-19 13:21:53.000000000 -0500
@@ -527,9 +527,13 @@ rtas_pci_enable(struct pci_dn *pdn, int 
 		            function);
 
 	if (rc)
-		printk(KERN_WARNING "EEH: Cannot enable function %d, err=%d dn=%s\n",
+		printk(KERN_WARNING "EEH: Unexpected state change %d, err=%d dn=%s\n",
 		        function, rc, pdn->node->full_name);
 
+	rc = eeh_wait_for_slot_status (pdn, PCI_BUS_RESET_WAIT_MSEC);
+	if ((rc == 4) && (function == EEH_THAW_MMIO))
+		return 0;
+
 	return rc;
 }
 
