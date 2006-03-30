Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4161B679E7
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 08:27:38 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2ULRYLH024039
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 16:27:34 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2ULRYo9248584
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 16:27:34 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2ULRYHK030063
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 16:27:34 -0500
Date: Thu, 30 Mar 2006 15:27:33 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc/pseries: fix device name printing, again.
Message-ID: <20060330212732.GO2172@austin.ibm.com>
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


Paul, please apply and send upstram.

--linas

[PATCH] powerpc/pseries: fix device name printing, again.

The recent patch to print device names in EEH reset messages
was lacking ... this patch works better.

Signed-off-by: Linas Vepstas <linas@linas.org>

----
 arch/powerpc/platforms/pseries/eeh_driver.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

Index: linux-2.6.16-git6/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.16-git6.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2006-03-30 14:43:51.000000000 -0600
+++ linux-2.6.16-git6/arch/powerpc/platforms/pseries/eeh_driver.c	2006-03-30 14:47:31.000000000 -0600
@@ -292,9 +292,10 @@ struct pci_dn * handle_eeh_events (struc
 	frozen_pdn = PCI_DN(frozen_dn);
 	frozen_pdn->eeh_freeze_count++;
 
-	pci_str = pci_name (frozen_pdn->pcidev);
-	drv_str = pcid_name (frozen_pdn->pcidev);
-	if (!pci_str) {
+	if (frozen_pdn->pcidev) {
+		pci_str = pci_name (frozen_pdn->pcidev);
+		drv_str = pcid_name (frozen_pdn->pcidev);
+	} else {
 		pci_str = pci_name (event->dev);
 		drv_str = pcid_name (event->dev);
 	}
