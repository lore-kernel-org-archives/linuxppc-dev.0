Return-Path: <rlary@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BAC2D100889
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Apr 2011 06:00:51 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3MJmS0o026719
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2011 13:48:28 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p3MK0c25100762
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2011 14:00:38 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p3MK0brY013524
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2011 14:00:38 -0600
Message-ID: <4DB1DE63.1020408@linux.vnet.ibm.com>
Date: Fri, 22 Apr 2011 13:00:35 -0700
From: Richard A Lary <rlary@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc/eeh: Handle functional reset on non-PCIe device
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: antonb@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Richard A Lary <rlary@linux.vnet.ibm.com>

  For adapters which have devices under a PCIe switch/bridge it is informative
  to display information for both the PCIe switch/bridge and the device on
  which the bus error was detected.

Signed-off-by: Richard A Lary <rlary@linux.vnet.ibm.com>
---
  arch/powerpc/platforms/pseries/eeh_driver.c |   24 	14 +	10 -	0 !
  1 file changed, 14 insertions(+), 10 deletions(-)

Index: b/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -328,7 +328,7 @@ struct pci_dn * handle_eeh_events (struc
  	struct pci_bus *frozen_bus;
  	int rc = 0;
  	enum pci_ers_result result = PCI_ERS_RESULT_NONE;
-	const char *location, *pci_str, *drv_str;
+	const char *location, *pci_str, *drv_str, *bus_pci_str, *bus_drv_str;

  	frozen_dn = find_device_pe(event->dn);
  	if (!frozen_dn) {
@@ -364,22 +364,26 @@ struct pci_dn * handle_eeh_events (struc
  	frozen_pdn = PCI_DN(frozen_dn);
  	frozen_pdn->eeh_freeze_count++;

-	if (frozen_pdn->pcidev) {
-		pci_str = pci_name (frozen_pdn->pcidev);
-		drv_str = pcid_name (frozen_pdn->pcidev);
-	} else {
-		pci_str = eeh_pci_name(event->dev);
-		drv_str = pcid_name (event->dev);
-	}
-	
+	pci_str = eeh_pci_name(event->dev);
+	drv_str = pcid_name(event->dev);
+
  	if (frozen_pdn->eeh_freeze_count > EEH_MAX_ALLOWED_FREEZES)
  		goto excess_failures;

  	printk(KERN_WARNING
  	   "EEH: This PCI device has failed %d times in the last hour:\n",
  		frozen_pdn->eeh_freeze_count);
+
+	if (frozen_pdn->pcidev) {
+		bus_pci_str = pci_name(frozen_pdn->pcidev);
+		bus_drv_str = pcid_name(frozen_pdn->pcidev);
+		printk(KERN_WARNING
+			"EEH: Bus location=%s driver=%s pci addr=%s\n",
+			location, bus_drv_str, bus_pci_str);
+	}
+
  	printk(KERN_WARNING
-		"EEH: location=%s driver=%s pci addr=%s\n",
+		"EEH: Device location=%s driver=%s pci addr=%s\n",
  		location, drv_str, pci_str);

  	/* Walk the various device drivers attached to this slot through
