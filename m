Return-Path: <rlary@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D4F661007DB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 May 2011 08:57:45 +1000 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p44MSd2Q016183
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2011 18:28:39 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p44MvUP7095948
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2011 18:57:30 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p44MvS5B002705
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2011 19:57:29 -0300
Message-ID: <4DC1D9CE.4050104@linux.vnet.ibm.com>
Date: Wed, 04 May 2011 15:57:18 -0700
From: Richard A Lary <rlary@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, antonb@au1.ibm.com
Subject: [PATCH 3/3] [repost] powerpc/eeh: Display eeh error location for
	bus and device
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

  rebased to powerpc-next

Signed-off-by: Richard A Lary <rlary@linux.vnet.ibm.com>
---
---
  arch/powerpc/platforms/pseries/eeh_driver.c |   22 	13 +	9 -	0 !
  1 file changed, 13 insertions(+), 9 deletions(-)

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
@@ -364,13 +364,8 @@ struct pci_dn * handle_eeh_events (struc
  	frozen_pdn = PCI_DN(frozen_dn);
  	frozen_pdn->eeh_freeze_count++;

-	if (frozen_pdn->pcidev) {
-		pci_str = pci_name (frozen_pdn->pcidev);
-		drv_str = pcid_name (frozen_pdn->pcidev);
-	} else {
-		pci_str = eeh_pci_name(event->dev);
-		drv_str = pcid_name (event->dev);
-	}
+	pci_str = eeh_pci_name(event->dev);
+	drv_str = pcid_name(event->dev);
  	
  	if (frozen_pdn->eeh_freeze_count > EEH_MAX_ALLOWED_FREEZES)
  		goto excess_failures;
@@ -378,8 +373,17 @@ struct pci_dn * handle_eeh_events (struc
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
