Return-Path: <linas@austin.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BB730679E9
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2006 10:33:43 +1100 (EST)
Received: from e32.co.us.ibm.com (e32.boulder.ibm.com [9.17.249.42])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2ONBZ1S013993
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 18:11:35 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2ONBU6r018559
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 18:11:31 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2ONEY1r191920
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 16:14:34 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2ONBUtb030882
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 16:11:30 -0700
Date: Fri, 24 Mar 2006 17:11:29 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc/pseries: Cleanup device name printing.
Message-ID: <20060324231129.GB21895@austin.ibm.com>
Mime-Version: 1.0
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

Please apply and forward. 

--linas


[PATCH] powerpc/pseries: Cleanup device name printing.

This patch avoids printk'ing a NULL string.

Signed-off-by: Linas Vepstas <linas@linas.org>

----

 arch/powerpc/platforms/pseries/eeh_driver.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

Index: linux-2.6.16-git6/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.16-git6.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2006-03-24 16:46:25.836892186 -0600
+++ linux-2.6.16-git6/arch/powerpc/platforms/pseries/eeh_driver.c	2006-03-24 16:58:55.305489138 -0600
@@ -257,6 +257,7 @@ void handle_eeh_events (struct eeh_event
 	struct pci_bus *frozen_bus;
 	int rc = 0;
 	enum pci_ers_result result = PCI_ERS_RESULT_NONE;
+	const char *pci_str, *drv_str;
 
 	frozen_dn = find_device_pe(event->dn);
 	frozen_bus = pcibios_find_pci_bus(frozen_dn);
@@ -291,6 +292,13 @@ void handle_eeh_events (struct eeh_event
 
 	frozen_pdn = PCI_DN(frozen_dn);
 	frozen_pdn->eeh_freeze_count++;
+
+	pci_str = pci_name (frozen_pdn->pcidev);
+	drv_str = pcid_name (frozen_pdn->pcidev);
+	if (!pci_str) {
+		pci_str = pci_name (event->dev);
+		drv_str = pcid_name (event->dev);
+	}
 	
 	if (frozen_pdn->eeh_freeze_count > EEH_MAX_ALLOWED_FREEZES)
 		goto hard_fail;
@@ -306,9 +314,7 @@ void handle_eeh_events (struct eeh_event
 	eeh_slot_error_detail(frozen_pdn, 1 /* Temporary Error */);
 	printk(KERN_WARNING
 	   "EEH: This PCI device has failed %d times since last reboot: %s - %s\n",
-		frozen_pdn->eeh_freeze_count,
-		pci_name (frozen_pdn->pcidev), 
-		pcid_name(frozen_pdn->pcidev));
+		frozen_pdn->eeh_freeze_count, drv_str, pci_str);
 
 	/* Walk the various device drivers attached to this slot through
 	 * a reset sequence, giving each an opportunity to do what it needs
@@ -360,9 +366,7 @@ hard_fail:
 	   "EEH: PCI device %s - %s has failed %d times \n"
 	   "and has been permanently disabled.  Please try reseating\n"
 	   "this device or replacing it.\n",
-		pci_name (frozen_pdn->pcidev), 
-		pcid_name(frozen_pdn->pcidev), 
-		frozen_pdn->eeh_freeze_count);
+		drv_str, pci_str, frozen_pdn->eeh_freeze_count);
 
 	eeh_slot_error_detail(frozen_pdn, 2 /* Permanent Error */);
 
