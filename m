Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 490B7DDE1C
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 05:58:40 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAFJ0EvW026224
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 14:00:14 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lAFIwaNw091758
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 13:58:36 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAFIwair031240
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 13:58:36 -0500
Date: Thu, 15 Nov 2007 12:58:36 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/3]: powerpc/eeh: report errors as soon as possible.
Message-ID: <20071115185836.GC24772@austin.ibm.com>
References: <20071115185420.GF18745@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071115185420.GF18745@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: munsone@us.ibm.com, linuxppc-dev@ozlabs.org,
	Sandra Rhodes <sdrhodes@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Do not wait for the pci slot status before reporting an error
to the device driver. Some systems may take many seconds to
report the slot status, and this can confuse unsuspecting 
device drivers.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_driver.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

Index: linux-2.6.23-rc8-mm1/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.23-rc8-mm1.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2007-11-09 17:28:58.000000000 -0600
+++ linux-2.6.23-rc8-mm1/arch/powerpc/platforms/pseries/eeh_driver.c	2007-11-09 17:36:51.000000000 -0600
@@ -354,13 +354,6 @@ struct pci_dn * handle_eeh_events (struc
 	if (frozen_pdn->eeh_freeze_count > EEH_MAX_ALLOWED_FREEZES)
 		goto excess_failures;
 
-	/* Get the current PCI slot state. */
-	rc = eeh_wait_for_slot_status (frozen_pdn, MAX_WAIT_FOR_RECOVERY*1000);
-	if (rc < 0) {
-		printk(KERN_WARNING "EEH: Permanent failure\n");
-		goto hard_fail;
-	}
-
 	printk(KERN_WARNING
 	   "EEH: This PCI device has failed %d times in the last hour:\n",
 		frozen_pdn->eeh_freeze_count);
@@ -376,6 +369,14 @@ struct pci_dn * handle_eeh_events (struc
 	 */
 	pci_walk_bus(frozen_bus, eeh_report_error, &result);
 
+	/* Get the current PCI slot state. This can take a long time,
+	 * sometimes over 3 seconds for certain systems. */
+	rc = eeh_wait_for_slot_status (frozen_pdn, MAX_WAIT_FOR_RECOVERY*1000);
+	if (rc < 0) {
+		printk(KERN_WARNING "EEH: Permanent failure\n");
+		goto hard_fail;
+	}
+
 	/* Since rtas may enable MMIO when posting the error log,
 	 * don't post the error log until after all dev drivers
 	 * have been informed.
